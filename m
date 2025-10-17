Return-Path: <bpf+bounces-71255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83960BEB69E
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 21:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 410BB4E48BF
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 19:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F26287253;
	Fri, 17 Oct 2025 19:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guBeXPWC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2305227563
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760730958; cv=none; b=MQmQedWqH4LfNSLtgnzJXvf27HC1VYtm7WDz8Xu8PyX7I8nIyZi4+SmxFVMID+IyeBzlV+y06aWT42ut971ChXZ8DjizKj5YaxrAbHGe6sBROS5X2tVtCckvH2FqIP7ZX0icvUKoWiDnBSdzIb/RPdOCtS/B4WYYIMLuFYoeMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760730958; c=relaxed/simple;
	bh=EqY+d2SeN9Desmrk+GwLbgEgVHIXInJEIfiq702dOOA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLwPBkYlBSnPF1Xsr2NJZVnGcYl2K4qO4lF4AQ5dCXDETLsK9nve2Ab0mLdhM0ZhJ1dwnbQsh79d0yNxv3/tFfzvzWvpsXm1T1UZwJyjme9tqfqniTBzUrtCkpQUDZVs6tWe6d3TGxYRyN+3KZI5LqynGGY8IF+FAz0FabXEhvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guBeXPWC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-79af647cef2so2121936b3a.3
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760730956; x=1761335756; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0DgnU83xx3BtxRdP1Acd96HFuVSZyZsOTR4ystA5riI=;
        b=guBeXPWCIPFMDZ88ExgzeSXdaWmo3QVZS9Kkuc1tegPbngwK9po2+InWYdmEx68jjT
         thGu9bR60sv2lDUOETKFaJ1UqltEru+WrOKnXKdFbf2RCqDnxn4h3YGQhzugwNthoyjb
         s+nta7JzBDNALPPxZap9KCOb5NZnl8lpzhTSMPgVqTOrkr2jrCLUi2YwTNnGmr9tdxCC
         idVrGmh141ro0QhZBmobGWXmTRaSN0vwpA/Y4OgDaVUJXrsQfqscRslRKref48F7TKa/
         dw1aWQm0szNu3sS7m+uCExd4Afi3liEBeSUHmBRKJ+DPaT6KwaN39f9/BcuD5B72lYTk
         6olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760730956; x=1761335756;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DgnU83xx3BtxRdP1Acd96HFuVSZyZsOTR4ystA5riI=;
        b=j8oznjnO/ddw1zcnNedf0pqR3Y6F8dOwep9yiDyDifp1G/IkIg/CNx7i7tWA5+jK/u
         KIyPixIZ1JL0wrgxRmRae0om4aPAo5HnM8Snab8X+B6VEjYs+RXlWNEdf9LdLhJT+I/i
         EvsY5yt4FXismZQ2BIfB7nFiY2VV0db1uBpEqaAJzeb7YJcjR89E5+A+ceySDSH/xKzS
         fghnOsgVZ+1QVPcacp25MqA3yvg8XfqCLUvLQqujKQlSaVct0V/mMizDFE6blt2L/BK8
         Szz+13QEHCqxwDH5Ui29R7AMt8uOMVQS1InMaat2aebiQSY99qFNQ7Xs4ZaTqOi2pnNL
         Ghjw==
X-Forwarded-Encrypted: i=1; AJvYcCXdRsjKas/bKY1OBrr5IoMKHPb6jVeb/w440ZczW+k6ZH84r0lJwDUT3QCNnUmhf8HywLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXIg5G8M+elIMREUG68IdjylR3pZkkPm0vK6jtXvGiroweqcdJ
	++4JEud2nJD/JZRxxR6ge+iNh9LHhS26/QU1eaZKHUSHPqnuDXQMT/7V
X-Gm-Gg: ASbGnctJh7gsUjRibUwu8dv8fRvBIMQvDf1bUZ5W96zyHq6EiMjX3HImjOYVsoLdbA7
	rYyx6qtQYIe++1cZLuolfOGm3sMikHocd0ARa1kyn5HtncV7lIWXZylzI6kbo8kuKTiI4xnD/8p
	MWnWslrdiiD3pWTrXr4DKM3FtqSgPNddkzw9bUBo6z4d6NCNHOCbiTG/j93sZeZiTNF8Vd7Ihdw
	PtEA784D9PNOuoM8bq9PBetT21snBkAIYAmHar5NtL6VHC+42QgFSP1sjoSXBhd5qa2t/mxj96/
	P6KbOup2Q0xmUwazk3OvVWix7NtiswthW0qJE3yVrfdbBZu7369mKt9DQ8Z7vxzhK7GUixKKkzt
	Nw83wo2M0pEuleBdgNCMlIursx9zs5PHw+FP8XaJbE4W6L6RL5kdeSvUzlM5QRCF+8sJvXaILgu
	I41+sK3c2Aa7DSp3sRIuTh8lM1
X-Google-Smtp-Source: AGHT+IFb/OHUmbjPaPl/a7yDHq1RKfFjsrF/MeEyN9vaxhfNMydNaD5+PiOmQfhjFogGYNA5pe9Hew==
X-Received: by 2002:a05:6a00:10d3:b0:781:1bf7:8c5a with SMTP id d2e1a72fcca58-7a220a455dfmr6072832b3a.1.1760730956184;
        Fri, 17 Oct 2025 12:55:56 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:49ef:d9f5:3ec:b542? ([2620:10d:c090:500::7:77fa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f25cdsm406982b3a.35.2025.10.17.12.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 12:55:55 -0700 (PDT)
Message-ID: <69e47b00df3d20b7cd5cd39896ee612ec6165a10.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix list_del() in arena list
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau <martin.lau@kernel.org>,
 kkd@meta.com, kernel-team@meta.com
Date: Fri, 17 Oct 2025 12:55:54 -0700
In-Reply-To: <CANk7y0jgRC3W6hQzJjfX0NX1PrttcDxSZLcXdB1jo_qxTFTVZg@mail.gmail.com>
References: <20251017141727.51355-1-puranjay@kernel.org>
	 <42bc3b8552fa2dec468747fc3e81a6b011222b84.camel@gmail.com>
	 <CANk7y0jgRC3W6hQzJjfX0NX1PrttcDxSZLcXdB1jo_qxTFTVZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 21:09 +0200, Puranjay Mohan wrote:

[...]

> [root@localhost bpf]# ./test_progs -a arena_list
> #5       arena_list:FAIL
> Caught signal #11!
> Stack trace:
> ./test_progs(crash_handler+0x1c)[0x956fd4]
> linux-vdso.so.1(__kernel_rt_sigreturn+0x0)[0xffff885b7820]
> ./test_progs[0x559f00]
> ./test_progs[0x55a728]
> ./test_progs(test_arena_list+0x28)[0x55aa7c]
> ./test_progs[0x957624]
> ./test_progs(main+0x6a0)[0x959298]
> /lib64/libc.so.6(+0x30558)[0xffff87e62558]
> /lib64/libc.so.6(__libc_start_main+0x9c)[0xffff87e6263c]
> ./test_progs(_start+0x30)[0x5522f0]
>=20
> I pushed it to the CI so you can see it fail:
> https://github.com/kernel-patches/bpf/actions/runs/18602175717/job/530435=
07792
>=20
> Another thing you can do in addition to commenting bpf_free() is to also =
comment
>=20
> //n->next =3D LIST_POISON1;
> //n->pprev =3D LIST_POISON2;
>=20
> and now the test will not crash but fail like:
>=20
> test_arena_list_add_del:FAIL:sum of list elems after del unexpected
> sum of list elems after del: actual 499500 !=3D expected 0

Ok, that was an error on my side. The test fails after clean rebuild,
sorry for the noise.

But my point is that if we care about list_del() correctness, the test
should be modified so that the bug is visible w/o commenting anything.

> This is because __list_del is a no-op, and after the poisoning logic
> is commented list_del() becomes a no-op.
> The list stays intact after arena_list_del() finishes.

Yes, I understand what you are fixing.

