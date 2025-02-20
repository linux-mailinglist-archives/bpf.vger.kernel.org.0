Return-Path: <bpf+bounces-52012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAF2A3CE0A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 01:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B99173A75
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 00:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C9F17BCE;
	Thu, 20 Feb 2025 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J7f5ZuIe"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2AA635
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 00:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740010754; cv=none; b=QZmjKzh3M6Oos9KIKc6i5mDY2Q3vHE7U8f56FXKGyaRY35s3p7rD7ihYYtZLccCBG/evOshRxRI4yq0o4C3Ga3Bnd1HLtuTfCb3taHLE1f/6gEvb/lDttBOXhl+XJlZwyuhAzBBCDvSwKYE39NTZOU0l9XS7wfXzQx8FZb4/A6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740010754; c=relaxed/simple;
	bh=sitxoHDO6x5zydEdjbtvLiizZhOEe7oruhYtIJO4mHI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XYuu8MtnOUjESknsluY4VDh+Cdl7d9lXWYb9Lu1Jk0VJZLtDcTLwTCgzV7SxzzohvBiAjcGzmUjZvsl6+o7xQrinU4ATtM9XaEOW8aoKPEWrSKoTH2l0yUZYcXBlmhh3jIZMaF8ukHXyDxU0bYgTl/wDlTJCcwqbAXy6ah1rtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J7f5ZuIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0718C4CED1;
	Thu, 20 Feb 2025 00:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740010753;
	bh=sitxoHDO6x5zydEdjbtvLiizZhOEe7oruhYtIJO4mHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J7f5ZuIe1ggLN9SPQPd+avBgQPL76vp140bV+hlNTZQ2A2R2PTgO4vV1z6JM+kV3U
	 lDlx2UIep315nTTfHbKhnaQCbzI7UGmilHS+5wj8fkwjSTa67Q9bjd19hP2qqy8Mir
	 rmvZyCZu6JvFPxmlG+9pLnmKV/kF7acfAZ8WHdvs=
Date: Wed, 19 Feb 2025 16:19:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, Jordan Rome
 <linux@jordanrome.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Kernel Team <kernel-team@fb.com>, Alexander Potapenko <glider@google.com>
Subject: Re: [bpf-next v8 1/3] mm: add copy_remote_vm_str
Message-Id: <20250219161912.ba13c3ea1c648500ea357e93@linux-foundation.org>
In-Reply-To: <ca3nfe2a2xfkt5ws6qkghzwmv4vmlsto4f2o2pr72sy46lftwe@xh4kt72yeia5>
References: <20250213152125.1837400-1-linux@jordanrome.com>
	<ca3nfe2a2xfkt5ws6qkghzwmv4vmlsto4f2o2pr72sy46lftwe@xh4kt72yeia5>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 15:33:12 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Hi Andrew,
> 
> Do you prefer this patch series to go though mm-tree or routing these
> through bpf tree is fine with you?
> 

I'm seeing no merge issues at this time.  Via the bpf tree, please.

