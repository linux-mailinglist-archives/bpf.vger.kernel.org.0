Return-Path: <bpf+bounces-46118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627B9E4739
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B1A18801C9
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7EC1925B9;
	Wed,  4 Dec 2024 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eVtsomJA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF118FDDB;
	Wed,  4 Dec 2024 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733349041; cv=none; b=BWRsdJcMf9nH4JDMDdwMshDRp1e3Xl3sg10PRjLb71pFk8omqDJWGsQsNKIbGWh00YQzs/ycf8dgKLZkE/2ChLB9KMMn5Ku7XpMhuH3K1bN/i+WIl6SEYRoWXzthSLWxi+bOStmgn5JtB3WWZGaqs9bw3IA7pDZaYHn8MRnRs48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733349041; c=relaxed/simple;
	bh=gr/u9cHGDJORjBUovtTKCrKNTCeYFWGfwm+ySqRUvGE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I7ie7T6dVvnuLuUTL9ntHku8yiLK2SlsBDP8LDLqzVwwAsRPEM1IynpRI6qLLyHhZ/UhdliU7pQARsDFcxVXRyLyzYBs64l9/L8Ox3xMCY4yTpnxtMGGPleDsexOL/VK3IK3njlCMJBPltsyr4AYGheuENne2meOd/CDe8TabAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eVtsomJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71324C4CED1;
	Wed,  4 Dec 2024 21:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1733349039;
	bh=gr/u9cHGDJORjBUovtTKCrKNTCeYFWGfwm+ySqRUvGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eVtsomJA/wCGcyuS3qmXOGDiigh3YWFe3BsNaPbvNLZc+88d5tUli+oS1oDG3VWvE
	 iOolwQciNyCa0zwhs3fvyyz4ytHp6RbzG3SJ2/GZ2taRR0PlLzjN7Yg2DGSA0cUhdF
	 u3//hLacXJf6NX4hv0EyOlZQMYmlydPcp0fzfSxU=
Date: Wed, 4 Dec 2024 13:50:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko
 <andrii@kernel.org>, linux-mm <linux-mm@kvack.org>, Uladzislau Rezki
 <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Vlastimil Babka
 <vbabka@suse.cz>, dakr@kernel.org, Michal Hocko <mhocko@suse.com>, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>
Subject: Re: [PATCH mm/stable] mm: fix vrealloc()'s KASAN poisoning logic
Message-Id: <20241204135038.1fa7e7803e14c41050584fc2@linux-foundation.org>
In-Reply-To: <CAADnVQKwZqajMd04Fp2CMmNbSAkfSKkUZiBwzoo4Dno1AzX7zQ@mail.gmail.com>
References: <20241126005206.3457974-1-andrii@kernel.org>
	<20241127165848.42331fd7078565c0f4e0a7e9@linux-foundation.org>
	<CAEf4BzZF8Gt_H=7J9SYXGorcjukQAqPJoX-a8vqBFdo73ZnXFA@mail.gmail.com>
	<CAADnVQKwZqajMd04Fp2CMmNbSAkfSKkUZiBwzoo4Dno1AzX7zQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Dec 2024 09:01:06 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Andrew,
> 
> What is the status of this urgent fix ?
> 

In mm-hotfixes for an upstream maerge later this week.

