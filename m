Return-Path: <bpf+bounces-23163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDA886E755
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25321F2A2AF
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEDE20DF4;
	Fri,  1 Mar 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d6DDV6/E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE3225D0
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 17:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314243; cv=none; b=K0B0tNNY/CWbMAHDxTD+m2WRG/39jJwBc3YUGZz+dt2qba7Qob121j4RxhUhppYBDCh4ZDoXCTOxgOhkr2w9Mv4zfxxvkvqfyIcDKT6NsdRreuHUJlzOML/F+VQT9j8hhNmjIL/QvJF9IxDC6dlH7dgUc0eak1/oQW4SyCeXj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314243; c=relaxed/simple;
	bh=ylK+D7JueGqF19SPnHZNe+5mxcvVGQNvmcj6EMAxZD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6lNvRDxXtSmxYhoKebE+wyOejIb/6c4+8JS5Xk977UgvRJH1wybNaEk9gRnkSWDN8eA/9DkIAn5Qa2jvw0pFHTv7Yg7PmyD/UijjQPF1bDt1+7HEsG1+TmLZPAicdLyElxy44y1StkQarwwusC3OdzCV1mbzpng8t6SuJKWqGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d6DDV6/E; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so3900666a12.0
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 09:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709314240; x=1709919040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Im9Umr2T85hMOmj0bpnRxcaABawqPpPhu4ZR7NKNsVY=;
        b=d6DDV6/Eiarm0bJq1DNTlh7R5wtoJ1ISKdiLl35Ys/jOwOfcieS/bmafgVOQVrkXeY
         ESnDnJkis662XNZsXul5BOhCtq55yO9ZIiVPwAB2TuZVEYRZm/SIxvqDJA6V9M9iJQZl
         9T+b9NmKN2s6RgXn4cDFSevOL2kfTYkO4/z+ceLX8eEzOlWcfDb9UICjw6K+kjB/i3Eh
         E+tW80Zd9ALMirEfyGDsOdlREIDyG4cV484rrH/5CT64fkpaKiq4ZEsgLt2K84pI7WjT
         GPOKDPvrhcN7rlmx7VPKSPm/UFdw4pEyJHc8EtNQeYnh+GiWdg8VU9bNhU8/zxZUWvSs
         q7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314240; x=1709919040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Im9Umr2T85hMOmj0bpnRxcaABawqPpPhu4ZR7NKNsVY=;
        b=C6GaDCtzw5UgSFX3z/a9xUz5E0dATMV1OJvzfYZeaXIrpRtD22fzZau5LWl6psjWjR
         0jn5VEFNlFVDerEshRtKvmGgYcow6bmof9IYC8wh8uQHRQ7SexL80+HwWjI3cLEtZRmI
         b9AuUxPw6bCC+r1VjqAadGIoD10QG9C39WFhoYwtQ0R7YqDW/YIKPDbfYjZPi0Gz/BNJ
         zfPNty/WDf9sMDvf+rGUdlJ/6CmIzo/FJmF/Io6WlUQ8PA017oPplh2y7JcNlFYKVcFm
         SR5RjUyCz4TFXEVgWnqjxuq2PwAmNhdt29VWNWWNKno7dDQsr2XiV3aQjd7vOctk4Jzt
         sWSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfuCwBPWD8hVGUeD91/ROlqmiY9aFFiXtfbkef+Lkv5NCuscKZchLKv+sazn0g07mLgxXs7OWtt5LdRnpkscspEUFQ
X-Gm-Message-State: AOJu0YzTsH1ChtSrqk++UyMN8HWR25TaNcbubsex7VehO2PU16Sm8m42
	vighthZosm0oJFW54+/InLQcvNyA06On3q1I4nDEUaZngdzvOXo/12Pqew163W2pDCAy6Liq2b3
	HdRRGXf7qhrUTWajtYSoix3hVkDXYNKaeBdximA==
X-Google-Smtp-Source: AGHT+IGYLJyhVjmMRjbUCITVxHrHFq3SYd6tnAK4qRR5cHKptQ5mXdPAN6On8sZlA3S5Bv7Ldr+4yWiPY5SAqyrDMao=
X-Received: by 2002:a05:6402:35cc:b0:566:f851:f53b with SMTP id
 z12-20020a05640235cc00b00566f851f53bmr334043edc.35.1709314240646; Fri, 01 Mar
 2024 09:30:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZeFPz4D121TgvCje@debian.debian> <CAO3-PboqKqjqrAScqzu6aB8d+fOq97_Wuz8b7d5uoMKT-+-WvQ@mail.gmail.com>
 <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
In-Reply-To: <CANn89iLCv0f3vBYt8W+_ZDuNeOY1jDLDBfMbOj7Hzi8s0xQCZA@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 1 Mar 2024 11:30:29 -0600
Message-ID: <CAO3-PboZwTiSmVxVFFfAm94o+LgK=rnm1vbJvMhzSGep+RYzaQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: raise RCU qs after each threaded NAPI poll
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Fri, Mar 1, 2024 at 2:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> I could not see the reason for 1sec (HZ) delays.
>
> Would calling rcu_softirq_qs() every ~10ms instead be a serious issue ?
>
The trouble scenarios are often when we need to detach an ad-hoc BPF
tracing program, or restart a monitoring service. It is fine as long
as they do not block for 10+ seconds or even completely stall under
heavy traffic. Raising a QS every few ms or HZ both work in such
cases.

> In anycase, if this all about rcu_tasks, I would prefer using a macro
> defined in kernel/rcu/tasks.h
> instead of having a hidden constant in a networking core function.

Paul E. McKenney was suggesting either current form or

         local_bh_enable();
         if (!IS_ENABLED(CONFIG_PREEMPT_RT))
                 rcu_softirq_qs_enable(local_bh_enable());
         else
                 local_bh_enable();

With an interval it might have to be
"rcu_softirq_qs_enable(local_bh_enable(), &next_qs);" to avoid an
unnecessary extern/static var. Will it make more sense to you?

thanks

>
> Thanks.

