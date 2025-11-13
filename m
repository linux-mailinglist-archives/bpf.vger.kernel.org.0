Return-Path: <bpf+bounces-74418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 733D1C58BD2
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C22574F56E1
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CD328604;
	Thu, 13 Nov 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+HYxKei"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CCB30BB81
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049692; cv=none; b=iFYFdw5VH5FuIGERPHgJejw4kvOdbqHwa47fEmSjH9qsybuezFXGTx2JOaH+b1HsKNoyRJZGq/5q+Ouc4Wu7TEx6tzgcVnW86h8ibFN+weFl4ZZdjuscRrY8TGaau5o85I3xwxJ8EZkuORZFNgeyd9UdL1J4spghMf+uJka6QGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049692; c=relaxed/simple;
	bh=9WDCC70OmJeEIVmQhNXZOLDlHIOIBpTmoh/cc7/8VsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6oSoRT/OZGwDCdJeowTQMFszW6eEVOMW+VdjysENKP8ymflfbxBgEhMA9J5GTI3I2nFLblui3W9sVj8dUUtdNsekmJ9cg4ZxHE0cLX9J1qOtQWg4b6wxSm3FD6oYPXEs5IvT2vfCnrfeYyO+PbDl6hMeg/FdqISOH1LN2t/tks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+HYxKei; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-295548467c7so10911615ad.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 08:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763049690; x=1763654490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgH63ny58lKBouubCx45/ogsbkG1mv62vGa6krsx4L8=;
        b=T+HYxKei/agcRAfgeGRzsgT6uGDp2tViaIQhoOtV4fEwDejak07l9ZO+t61cQrLsX0
         4uroJkbzdCzS0FHGY/3uYbU3+zCT4KwZ3TqVauE0w/UFSMx626OrGNx3wTDC+b+alajB
         UV6XKNT/OcLrqznk339OPVbCw+ZKYeJ38Dy6GZ+rlK12gPVXviHQ0LIR0DhrOsodPXsL
         TkGz26L5kU0T8Mc01OwjkWxkP6CgzpCQjE1XYwUAATsB4icg8eOHWYSQB1DrypgiDCe/
         qTU3TRYRaApQleZcYsaomzF1fg1IEfsjNgf/c5ty9OeocJL4JMLHgMezqgYMAjtv9V6T
         r+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049690; x=1763654490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgH63ny58lKBouubCx45/ogsbkG1mv62vGa6krsx4L8=;
        b=veJscBYV1xLMqwjsiPPO2tCt/zg/06SB9XoUuaXtP4tl764D2HhC3pnLgb6045j54/
         Igit1PY19AQC8FLcJ42zK45psadYVVLpSA4hfDSbv++mCGG9mYapxPkrlkBwuWCUuM3U
         LNQQFdp9142ir6H9GQxDUeUG71W54OXobSsdv0uMKqWzduKVN9y1AXG08333Mnuqxr3q
         nFmf3EktaqwKbftX1EqNsJEu0g+C98bD1k2jcJYKIR6juFlCdJNRV7zbxwkDW8yZPtsP
         t6MPBJqlIVblzpyV7k++VPT7Dl+95Kkv/z78mNW/QUrOGbB9lev8Dh4H0L1sYcNTXoxm
         oxeA==
X-Forwarded-Encrypted: i=1; AJvYcCXrWExiKpSru8D9/oW+NQSamXerMP3p5akMGLkeSdJmw5n1ZIqpz8g9PET0YyJOxYh+llI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJjxEZndpZMmUBBxgVZjXiV4XK7Vtna7mTesvTuAhqlMDi9Mt
	PoTVB3VPJXpKXIIulKb4LabgCjN6ChhpOYkVXgsL+HIp9DdEzzK+FijEazQwgw==
X-Gm-Gg: ASbGncts+vi48PA7t+LRy214TBGOO1KaXHKRY7zkBT/2ILYmsrk9u3UcGJcwa7dlQzG
	YHp2vxSY36c1a8xM89L0R2KUSy5L8WQQCxTJKyxaGBLF+basAVGU6VLXh9wGCf0zR6tpYqyP3l+
	1swuXlTi5BPVbSvza7rjh94EWbtzUKvhU+hlIM2KgkhZHYlbshTOs22js13DFEDWlh07mYSh3+G
	2KnD7VKWFJUZ3ZPGNGRyHC75Y7fQp1R5a92S+y8D+tQDCPDkc8DzM1S7LN7/p7Gin5DGMUKouQk
	bVc+AfxJMu43dam/E48CO4nz0BaEcwqfrT8JKRAbVZ3rMUP2OscE1YJZlEmhHocHkF4aIAEZJeH
	IXUTTL2mn9TJLLVlR9HwcIjsAfVC7HEC6vBcmzbqvdj7Cq84NKQpAuYahAgODH9z90ja565/SJx
	mkuHCLTciukWrIi4XVj0MVs6OvK1dt5Uim
X-Google-Smtp-Source: AGHT+IETRHJjMQcMcYq5o8eYmHK9FmtR5njBTdfHhjInmdSK3tsl/WbqH5ZZXE1ALvPDCrvu/La6ew==
X-Received: by 2002:a17:902:e80b:b0:295:fdf2:d01e with SMTP id d9443c01a7336-2984ed257a5mr98424625ad.2.1763049689625;
        Thu, 13 Nov 2025 08:01:29 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm29399005ad.65.2025.11.13.08.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:01:28 -0800 (PST)
Date: Thu, 13 Nov 2025 08:01:26 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 0/4] make vmalloc gfp flags usage more apparent
Message-ID: <aRYA1shUhLeof8d8@fedora>
References: <20251112185834.32487-1-vishal.moola@gmail.com>
 <e1d26f84-7ea2-46de-8ab9-31e49b485832@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d26f84-7ea2-46de-8ab9-31e49b485832@linux.alibaba.com>

On Thu, Nov 13, 2025 at 11:48:05AM +0800, Baolin Wang wrote:
> Hi,
> 
> On 2025/11/13 02:58, Vishal Moola (Oracle) wrote:
> > We should do a better job at enforcing gfp flags for vmalloc. Right now, we
> > have a kernel-doc for __vmalloc_node_range(), and hope callers pass in
> > supported flags. If a caller were to pass in an unsupported flag, we may
> > BUG, silently clear it, or completely ignore it.
> > 
> > If we are more proactive about enforcing gfp flags, we can making sure
> > callers know when they may be asking for unsupported behavior.
> > 
> > This patchset lets vmalloc control the incoming gfp flags, and cleans up
> > some hard to read gfp code.
> > 
> > ---
> > Linked rfc [1] and rfc v2[2] for convenience.
> 
> Just FYI, I hit this warning when booting today's mm-new branch.
>
> [    1.238451] ------------[ cut here ]------------
> [    1.238453] Unexpected gfp: 0x400000 (__GFP_ACCOUNT). Fixing up to gfp:

Thanks. I'll send an updated version that catches this next week. In the
meantime, do let me know if you find any more warnings for other gfp
flags.

> 0xdc0 (GFP_KERNEL|__GFP_ZERO). Fix your code!
> [    1.249347] WARNING: CPU: 27 PID: 338 at mm/vmalloc.c:3937
> __vmalloc_noprof+0x74/0x80
> [    1.249352] Modules linked in:
> [    1.249354] CPU: 27 UID: 0 PID: 338 Comm: (journald) Not tainted
> 6.18.0-rc5+ #55 PREEMPT(none)
> [    1.249357] RIP: 0010:__vmalloc_noprof+0x74/0x80
> [    1.249359] Code: 00 5d e9 6f f8 ff ff 89 d1 49 89 e0 48 8d 54 24 04 89
> 74 24 04 81 e1 e0 ad 11 00 48 c7 c7 68 b0 75 82 89 0c 24 e8 7c bf ce ff <0f>
> 0b 8b 14 24 eb ab e8 f0 61 a5 00 90
>  90 90 90 90 90 90 90 90 90
> [    1.249360] RSP: 0018:ffffc90000bebe08 EFLAGS: 00010286
> [    1.249362] RAX: 0000000000000000 RBX: 0000000000001000 RCX:
> ffffffff82fdee68
> [    1.249363] RDX: 000000000000001b RSI: 0000000000000000 RDI:
> ffffffff82a5ee60
> [    1.249364] RBP: 0000000000001000 R08: 0000000000000000 R09:
> ffffc90000bebcb8
> [    1.249364] R10: ffffc90000bebcb0 R11: ffffffff8315eea8 R12:
> ffff88810aac98c0
> [    1.249365] R13: 0000000000000000 R14: ffffffff8141abe0 R15:
> fffffffffffffff3
> [    1.249368] FS:  00007fbc9436ee80(0000) GS:ffff88bec00e1000(0000)
> knlGS:0000000000000000
> [    1.249370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.249371] CR2: 0000562248eda010 CR3: 00000001028a8005 CR4:
> 0000000000770ef0
> [    1.249371] PKRU: 55555554
> [    1.249372] Call Trace:
> [    1.249373]  <TASK>
> [    1.249374]  bpf_prog_alloc_no_stats+0x37/0x250
> [    1.249377]  ? __pfx_seccomp_check_filter+0x10/0x10
> [    1.249379]  bpf_prog_alloc+0x1a/0xa0
> [    1.249381]  bpf_prog_create_from_user+0x51/0x130
> [    1.249385]  seccomp_set_mode_filter+0x117/0x410
> [    1.249387]  do_syscall_64+0x5b/0xda0
> [    1.249390]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [    1.249392] RIP: 0033:0x7fbc94f4c9cd
> 

