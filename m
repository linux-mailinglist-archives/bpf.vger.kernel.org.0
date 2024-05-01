Return-Path: <bpf+bounces-28319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4878B862E
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D301C21312
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C10F4D5A5;
	Wed,  1 May 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvaYDxOm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA645000;
	Wed,  1 May 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714549392; cv=none; b=hLUXTcck21n30UA6Kr8/daK69Et3wfB8shu2Q4kHY3yLX4d96Bi4PrNrRxwVDY13B83380IL9oCasqQyw5zjIwC3D0ycqbmpYEU5Gq5uozLLik7+A+/HbvvOPtYRgCqDQHzhT3HzLhgt5x6buiJRQ9Nfvup7YH0aQFDUpBzvkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714549392; c=relaxed/simple;
	bh=nDz7IgBIt8zcUbDYSusybKLUFygsWzYKS7tlIuHx9Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPW5m5k/EF2CRh7BLwDxSwG+PJ1qL6hVMGG+n25y9VxWZUI1xAj1xTvOkzNSf8kwP6yV6cb8UwZGMKui+ajzV2KpZ1+ts37/KHKyq4WUQ9UrOHwPNCxg8wslDA31F/P5kY+Tf+rUqv36fx3FMkTr7btjSQt8tWVH5jB2GSU+32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvaYDxOm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b79450f78so37502525e9.2;
        Wed, 01 May 2024 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714549389; x=1715154189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VS97UVDmTq0jUKWg6SotUR+zNkhZ/4MYnHJe/NRtR38=;
        b=EvaYDxOmRdxvt0t0qzk3LfyR6+Cm3+dsdaiBdYzs9D3gWMlXiovjdWh8ap25lJboNv
         afXdV1/2tA2rAOTFLGNdpCiiGwG2qhLCAfO/484GGfxA40d2Apx7OP6pPSizJhPeecl+
         xqJ9nGkVtH3ChtH4PXMaamUvmaH3fCukE28f9bcuRpaAAM61d4wimx7po6oqEHh6x7O6
         snDk3T3eRPQn5ZYIEUkuRpMxA7IzWzHj/Kv/IsQV5/CS7ThI3hQh3HS909WyhlZhyy4K
         MwuvFtYRjUC9dFAWaWQ4/5eDhYdIENrGH6m6CmAUu1kcoh5CncgK7JbyxWzINrfqO2Re
         oRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714549389; x=1715154189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS97UVDmTq0jUKWg6SotUR+zNkhZ/4MYnHJe/NRtR38=;
        b=wjuS/+H9oMbBFljvKqKSUKf+QTWgEE0esVZ2FHcbs6mtR0D4MRFffNZXJQ0riGjJaL
         xAgO/crWWwzO402kErihABH3cqr4I4uhWiWw7rsHvaUKTGh8pfBWiijkmAws9v46yaWE
         GU+ge01KPGK+eUibQlzGwRv2MFBJTtefH630L/wF/BtEUgpz8E6ZC6RLhtXoQuFv2O4U
         SYJ5ctEKdHXUnPtX8MqWQTsEOyVuxb3PxCeyUnwFdBVKanGaYUTA9m3gPEx/LFpkcqxl
         MEzhu07DJ4PzqzRbn4NemIPMONDswWYTV/BcG6cOLag0DfUxEL9CiP5tQi03EgXdmkDw
         H7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUMiSgF7XXxTiIMEvv2ee7BnMZuklikgjLa0Y7XX4aEkGpjpYdjRGTEGJZLj5LvzoO/zpglCFwIWlK+O9e00F9M0cfA6Gss+C8u8NbQeUnvXKYhsxd92gsHVNJ9YmSnjGIF
X-Gm-Message-State: AOJu0Yyi4LBY3kz1MNKCEAQhsSOfilt9Z58Ilk3wZQFFc1zSAx65CsZ3
	j+LTdbCPoBgSEdMds0FG4H52qLhx3omBHAGiLREaiTGrgtiwLaLxrFpTppkI
X-Google-Smtp-Source: AGHT+IE+xuenBBdfvMBsv6WfaxYXki4TTiAgFoUeJbfTWshn1vHer1TP0WJ88r2aPYPWbRWPovAXWQ==
X-Received: by 2002:a05:600c:3ba2:b0:41b:d973:24c1 with SMTP id n34-20020a05600c3ba200b0041bd97324c1mr1933561wms.12.1714549388206;
        Wed, 01 May 2024 00:43:08 -0700 (PDT)
Received: from gmail.com (20014C4C171B8800C2E0EE13693E7E35.unconfigured.pool.telekom.hu. [2001:4c4c:171b:8800:c2e0:ee13:693e:7e35])
        by smtp.gmail.com with ESMTPSA id c14-20020adfa30e000000b0034da4e80885sm2428071wrb.59.2024.05.01.00.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 00:43:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 1 May 2024 09:43:04 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hillf Danton <hdanton@sina.com>, Andy Lutomirski <luto@amacapital.net>,
	Peter Anvin <hpa@zytor.com>, Adrian Bunk <bunk@kernel.org>,
	syzbot <syzbot+83e7f982ca045ab4405c@syzkaller.appspotmail.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	andrii@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] x86/mm: Remove broken vsyscall emulation code from the
 page fault code
Message-ID: <ZjHyiI4DlNNh/HRq@gmail.com>
References: <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com>
 <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
 <Zi9Ts1HcqiKzy9GX@gmail.com>
 <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
 <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
 <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com>
 <ZjCLSLQ4WttYQXVd@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjCLSLQ4WttYQXVd@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > I guess that patch to rip out sig_on_uaccess_err needs to go into 6.9 and 
> > even be marked for stable, since it most definitely breaks some stuff 
> > currently. Even if that "some stuff" is pretty esoteric (ie 
> > "vsyscall=emulate" together with tracing).
> 
> Yeah - I just put it into tip:x86/urgent as-is, with the various Tested-by 
> and Acked-by tags added, and we'll send it to you later this week if all 
> goes well.

Update: added the delta patch below to the fix, because now 
'tsk' is unused in emulate_vsyscall().

Thanks,

	Ingo

 arch/x86/entry/vsyscall/vsyscall_64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 3b0f61b2ea6d..2fb7d53cf333 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -115,7 +115,6 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 bool emulate_vsyscall(unsigned long error_code,
 		      struct pt_regs *regs, unsigned long address)
 {
-	struct task_struct *tsk;
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
 	long ret;
@@ -166,8 +165,6 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto sigsegv;
 	}
 
-	tsk = current;
-
 	/*
 	 * Check for access_ok violations and find the syscall nr.
 	 *


