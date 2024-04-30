Return-Path: <bpf+bounces-28227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047C08B6A34
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 08:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541F52813C2
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 06:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0724217BA2;
	Tue, 30 Apr 2024 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpkz2ITt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EC52F2B;
	Tue, 30 Apr 2024 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457422; cv=none; b=MCUVJRPAufn9HuMznwpjkexIGoRVntvRrxtAr0fi8A88rlHAdx+erDxITy+XqkwV/9ijqSyi52LWiGdUM2EGodXCNH0ljS14HNd8ME482kTUoUh5qM3opHbcyC9QOnPJRDMRsPodtQU42lovmbKcSYaqiiWheCcz8VZJiOQ4mVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457422; c=relaxed/simple;
	bh=xLk6olRuLjszn77c4N+vYNQwx3BiTeXJEPu82YWbAWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm7qoue28lo1gbT7y4TpFkq8z0wNOApoBAPHus7hgpwY0188DPOow1r5xFzeQ1uxyJSSJ6h3TKhEPNDo67uOGjMC5NaRlq5j9JLQ2ZKet4U/cLLoRaI1pvHDZRwge5m0jlK9wHzCaAceBeRjgGkLwAck+StMIArcODncyKonOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpkz2ITt; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d1ecaf25so7343556e87.2;
        Mon, 29 Apr 2024 23:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714457419; x=1715062219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKZTzZ8YF36Lg/+Y4l3XbLB30NDAuLh0Neyfhx6Ouxk=;
        b=fpkz2ITtseIYzT2e4HF7grqzvjb+YsLYkMgVSNwmfooYaeD+IJXy+1Umz0S3E6Lu/s
         DT2oIu/RA1N/+hywZMicGBeTizXJzSGKwHHTSXdp0a0hc/ZALDysxA6FvVLlcWodtCwI
         D8kDEBxdZlLP/TKVy6iPHY2UNZZJVkhmNSMqRIcvFxjJRBmdbs7rBVNH9oTVYPdcTrkb
         A4TvBUGl/T0i1HxBNm0gIpQ19bAMlEZb/WqGcmPxYs/Msje7IPgAEfwFOm1GdirGtlZc
         wSHxFbQpFsNuer7XT2mCprrMpXnDUaXFvl6uilJziKN8iSgOdiKmVv0F2fISIZkSLdFJ
         5Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714457419; x=1715062219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKZTzZ8YF36Lg/+Y4l3XbLB30NDAuLh0Neyfhx6Ouxk=;
        b=DYERbssi7HDgMgnEcDADYWDQhj02zNqXA0hnxjsGEYctes6pN7g5Gb/J0hA+EWuRzB
         aDCMa1RZgbo6i3ZXmV+6EJAPPM6Agry4DLNKjQt7ZPN2hiKK70aQPgR0wnEA1S5JFzFH
         HlaN3htwLj64FJAdv80lAII3vJa/+pSalg/pj9Mqg8Sk/dpcJaxvjRJUM4/WdXCZmLZf
         s64Fmx3OjZjMUiK29U4mI0W3X6MMTF3izLAEabwOVzEen9jC4FmtZFgzBjxk/xrFu8/q
         Z3C+5PZ70N9tQycX4rw5B/bmECL5+UZ+pGmtUDAkPytkciPaP1Ey88GdPLnMLy+4h2Ol
         cgaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmkRrA89Vg4mdhcC7HzfAI/ymCMu32ohMsKtpwKvS8nP/Z5iw6p0EWPA2HcuqxNZ8rxyz4nkvdqHY+2yCIAYgz7WmT1TZXbH7sMLcu/uiXMRquXHnnt4YYm0ef0piXPHDM
X-Gm-Message-State: AOJu0Yy8bxbI/ciEXSkUsPbuAmiQmp7QcCk2Rg7jIiqym/i1ynEhHTuU
	1KFTyVB3e1jNjuq/glnk6b0OJ5i9LRwgOna6BcSPECUEk8d+8UNpTaEmVNOR
X-Google-Smtp-Source: AGHT+IEWT/1/BvNmIdzytlSnSL5+oBNDY6IX7icEQAeMeszGxmfg3QImt1BKOEbeB8QiR4cswlx1Ng==
X-Received: by 2002:ac2:5510:0:b0:51c:f00c:2243 with SMTP id j16-20020ac25510000000b0051cf00c2243mr958004lfk.35.1714457418692;
        Mon, 29 Apr 2024 23:10:18 -0700 (PDT)
Received: from gmail.com (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id y18-20020adff152000000b0034d7a555047sm872704wro.96.2024.04.29.23.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:10:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 30 Apr 2024 08:10:16 +0200
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
Message-ID: <ZjCLSLQ4WttYQXVd@gmail.com>
References: <0000000000009dfa6d0617197994@google.com>
 <20240427231321.3978-1-hdanton@sina.com>
 <CAHk-=wjBvNvVggy14p9rkHA8W1ZVfoKXvW0oeX5NZWxWUv8gfQ@mail.gmail.com>
 <20240428232302.4035-1-hdanton@sina.com>
 <CAHk-=wjma_sSghVTgDCQxHHd=e2Lqi45PLh78oJ4WeBj8erV9Q@mail.gmail.com>
 <CAHk-=wh9D6f7HUkDgZHKmDCHUQmp+Co89GP+b8+z+G56BKeyNg@mail.gmail.com>
 <Zi9Ts1HcqiKzy9GX@gmail.com>
 <CAHk-=wj9=+4k+sY6hNsQy2oQA4HABNA369cBPSgBNaeRHbbTZg@mail.gmail.com>
 <CAHk-=wg63NPb-cEL7NTFTKN2=uM6Lygg_CcXwwDBTVCg=PeSRg@mail.gmail.com>
 <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whuH+-swynMTVd9=uCB0uuhaoanQ5kfHEX=QaRZx7UgBw@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I guess that patch to rip out sig_on_uaccess_err needs to go into 6.9 and 
> even be marked for stable, since it most definitely breaks some stuff 
> currently. Even if that "some stuff" is pretty esoteric (ie 
> "vsyscall=emulate" together with tracing).

Yeah - I just put it into tip:x86/urgent as-is, with the various Tested-by 
and Acked-by tags added, and we'll send it to you later this week if all 
goes well.

Thanks,

	Ingo

