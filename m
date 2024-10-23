Return-Path: <bpf+bounces-42857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0099ABB09
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 03:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5061F238ED
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 01:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B0339A8;
	Wed, 23 Oct 2024 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fy2CtgA9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA26B288B1;
	Wed, 23 Oct 2024 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647133; cv=none; b=S5BwxjzxSJJf42aV9ivjAl3euW6wgX7StX9nDHorP91KR5b3VhV3znn6nVI1YcZpi5SoxiMZ+GRvnFRxsUq38+WiVHNFYC7F18/p2zGlKk7gZLr7aERGPAO2kSJHMAodYU7BskQPivP3baNNuDF6+IRVryApVIYpc3ZWZGMhbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647133; c=relaxed/simple;
	bh=5C53vINuy3FyicC5nga4u/tAcMQz+V9nEUg+wHKFx4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA6fkSz9y6jS28ktUVv5AOoqIFiaNeldj3RUMfgmxNvgr7Thl4tYrzOjDPEL8NvMksomywxtww89std7WmWvUb4xnIdqkR2QRx8lAWACkbK0nu1PBYB8V3X6x42Agvc62W4K/iEpc7Ua/FhOWLLe2i4WPhJIBz+We1/UgshS68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fy2CtgA9; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so4312660a12.0;
        Tue, 22 Oct 2024 18:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729647131; x=1730251931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1a4vwbaJtSd23ba+kdujv/GFWeG37UIlsFbsztV+u2Y=;
        b=fy2CtgA9xW6Jsopt289Ndn5Z2GN14stzsoGPgILGzNOK/RwxxNldUuDesk/+WJTs1m
         UlioLBRBvHHxXua1CXy8KgBGykiWQ9+949uHbKOJydEtFwxfOYYcwRaYmb36GWnnmIvS
         8GVXBkfEYqweTAk+SCdZiP2AF40JtD6ajIMm7oaeJL8SWe5ptGSzib8HrAU3ufNdC8hd
         9dXBcmx0VqnmLzBU26OOUYUhOX0FFAmhONrDFcpLJApn3BQI5Xj7XtvX6/spq2BDIj/K
         GMwP6hhzRvHmXdHVS6jCd+ySmrnlUE+iyuSteYY+wLjL2lirDlgN5PLW5TFGU/+spq+4
         R8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729647131; x=1730251931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1a4vwbaJtSd23ba+kdujv/GFWeG37UIlsFbsztV+u2Y=;
        b=iv4SuNHXYblVlhx/bTjw1dvmTjRy/Q80YcJKvSpQi/xCNtdDNdRoyMk6mhRNDVZnPw
         jaYRUNrX/DHlhUVS1AlVyJa1dP/CSUd/mPOEe+XHsJUAsd3EYA/TnUVF3H29anb6tVZo
         66UUOwZMLhzjbX8wFFACEJDMaiWMX+kknDnl8OX2AbnkpEvfovwUjiidsvim5oNFXkTj
         6feXOEy53ayNIJ4A9AnT0iXqeqZzG2L6puIRbHkcxyBTQ8IujuxcIOrXQdK7mW3qxtYI
         X/jgjI2zP4/cTbEJdlarnlaecfxphAq0puH+8P2VBZ6mdytaSl9zo8CdhRQRP2/1fMwP
         GjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDlPEE+RHN3y0eMhPff/b5vajHbXJ/AT7IExlKh1tkEB23WDs96hvHAFgle5ybsFK1iEw=@vger.kernel.org, AJvYcCUWkrnS0G338SRHSFFxyVANO5LQB6lB1EPmgp66XtppKc+wNqm8qLFHCQWL8C6Q4cKPCdBBFVSOHJs8PGFe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1XOhq6Zn52XK20WX3zHfVGpgfROrYzOi4pGOPj2YZfCz1o+Ko
	3RgmYiH7pntFIZ/0o1tGXZIWfHVUMvMlAqXPCIia6G4Ko5EyVCODLzCGcnY/
X-Google-Smtp-Source: AGHT+IFdy95yPWrBRopX5YEiZemikX7ErDFeD+UuofU5hJl/6URCZdX+CS6HfaV9/6Wbnc8KkakGbQ==
X-Received: by 2002:a05:6a20:9f43:b0:1d8:f977:8cda with SMTP id adf61e73a8af0-1d978b2e4fbmr1330572637.27.1729647130827;
        Tue, 22 Oct 2024 18:32:10 -0700 (PDT)
Received: from localhost.localdomain ([210.205.14.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d7603sm5349852b3a.134.2024.10.22.18.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 18:32:10 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:29:23 +0900
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: Fix out-of-bounds write in trie_get_next_key()
Message-ID: <ZxhOCkxsGbMoiERy@localhost.localdomain>
References: <ZxcDzT/iv/f0Gyz0@localhost.localdomain>
 <CAADnVQ+Ow2E8qghEZw6x63VS4gM5rDtbM9R-ob00Rha2yBvfgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+Ow2E8qghEZw6x63VS4gM5rDtbM9R-ob00Rha2yBvfgA@mail.gmail.com>

On Tue, Oct 22, 2024 at 12:51:05PM -0700, Alexei Starovoitov wrote:
> On Mon, Oct 21, 2024 at 6:49 PM Byeonguk Jeong <jungbu2855@gmail.com> wrote:
> >
> > trie_get_next_key() allocates a node stack with size trie->max_prefixlen,
> > while it writes (trie->max_prefixlen + 1) nodes to the stack when it has
> > full paths from the root to leaves. For example, consider a trie with
> > max_prefixlen is 8, and the nodes with key 0x00/0, 0x00/1, 0x00/2, ...
> > 0x00/8 inserted. Subsequent calls to trie_get_next_key with _key with
> > .prefixlen = 8 make 9 nodes be written on the node stack with size 8.
> 
> Hmm. It sounds possible, but pls demonstrate it with a selftest.
> With the amount of fuzzing I'm surprised it was not discovered earlier.
> 
> pw-bot: cr

With a simple test below, the kernel crashes in a minute or you can easily
discover the bug on KFENCE-enabled kernels.

#!/bin/bash
bpftool map create /sys/fs/bpf/lpm type lpm_trie key 5 value 1 \
entries 16 flags 0x1name lpm

for i in {0..8}; do
	bpftool map update pinned /sys/fs/bpf/lpm \
	key hex 0$i 00 00 00 00 \
	value hex 00 any
done

while true; do
	bpftool map dump pinned /sys/fs/bpf/lpm
done

In my environment (6.12-rc4, with CONFIG_KFENCE), dmesg gave me this
message as expected.

[  463.141394] BUG: KFENCE: out-of-bounds write in trie_get_next_key+0x2f2/0x670

[  463.143422] Out-of-bounds write at 0x0000000095bc45ea (256B right of kfence-#156):
[  463.144438]  trie_get_next_key+0x2f2/0x670
[  463.145439]  map_get_next_key+0x261/0x410
[  463.146444]  __sys_bpf+0xad4/0x1170
[  463.147438]  __x64_sys_bpf+0x74/0xc0
[  463.148431]  do_syscall_64+0x79/0x150
[  463.149425]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  463.151436] kfence-#156: 0x00000000279749c1-0x0000000034dc4abb, size=256, cache=kmalloc-256

[  463.153414] allocated by task 2021 on cpu 2 at 463.140440s (0.012974s ago):
[  463.154413]  trie_get_next_key+0x252/0x670
[  463.155411]  map_get_next_key+0x261/0x410
[  463.156402]  __sys_bpf+0xad4/0x1170
[  463.157390]  __x64_sys_bpf+0x74/0xc0
[  463.158386]  do_syscall_64+0x79/0x150
[  463.159372]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

