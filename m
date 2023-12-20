Return-Path: <bpf+bounces-18395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB6681A285
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 16:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46356288EAC
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673B541236;
	Wed, 20 Dec 2023 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IL6B8Hmd"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177FF3DB9C;
	Wed, 20 Dec 2023 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4bUErUjZLs4pkeHsV/Dwm9jJV2+WpHt+gu1NJERDxK4=; b=IL6B8HmdByDdGbi9OEVuL01zjV
	t1KQmrKxVlu77+Z/gLJ9bKTtUGGkRI3FwhvyP93vVJ/VjS3BZm3gDAYJcvuXLZme5dKZk/boZY1ah
	p8aSo25c98XDd8HE5AiXqUYFoff9DQr1ZYylCRxihvmkNI1te7sQq2lPnyjnlmJnPWN8fOjIv5Nox
	w4+HtVBHvc5rdtAV5pnLQhsIuweBtEa07WxtEt8O3eGRPpRBhNH5rDJbdwexJNwo7xv9LoHD60xhD
	py+HWAuWd97A2fcqZtXNLqYbF/PpROCd6h/eh5rV9FC1k5MgjPw6kTr4iPLxm2c8HS885P9NnspU4
	/W9I772A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFyVF-000OvN-61; Wed, 20 Dec 2023 16:28:57 +0100
Received: from [178.197.249.36] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rFyVE-000FNW-QQ; Wed, 20 Dec 2023 16:28:56 +0100
Subject: Re: [PATCH] libbpf: skip DWARF sections in linker sanity check
To: Alyssa Ross <hi@alyssa.is>, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: patches@lists.linux.dev, Sergei Trofimovich <slyich@gmail.com>
References: <CAEf4BzbN7cUVQgd7nUAsmAQMmCpz7O9v+r3iyiUfa_FK6WMY-w@mail.gmail.com>
 <20231219110324.8989-1-hi@alyssa.is>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f721923a-ef37-41cc-0343-226a16016e8b@iogearbox.net>
Date: Wed, 20 Dec 2023 16:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231219110324.8989-1-hi@alyssa.is>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27129/Wed Dec 20 10:38:37 2023)

On 12/19/23 12:03 PM, Alyssa Ross wrote:
> clang can generate (with -g -Wa,--compress-debug-sections) 4-byte
> aligned DWARF sections that declare themselves to be 8-byte aligned in
> the section header.  Since DWARF sections are dropped during linking
> anyway, just skip running the sanity checks on them.
> 
> Reported-by: Sergei Trofimovich <slyich@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Closes: https://lore.kernel.org/bpf/ZXcFRJVKbKxtEL5t@nz.home/
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Looks reasonable to skip, thus:

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

