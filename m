Return-Path: <bpf+bounces-38209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 587629618C5
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 22:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E531F24656
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 20:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AE91D318D;
	Tue, 27 Aug 2024 20:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsW9zN7S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11211D2780
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791859; cv=none; b=hqs1O50BCMR49sIK/Z2rjUL2SyZs4VMzoTeTeOTDpMPkyMkN0sonKK1YfgHCIM700VIlYW178kq37pQKbKk50QtfNfZmdGGFaZ5FeN92A5uIObYCiMVwId8l0lkRccghBYAwTcwoaa/HjWysgvTmsLO18S5mGUEes8YaGzwBv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791859; c=relaxed/simple;
	bh=AysLGNjtUG7H9zwKmPRl7V2VJ8kxJke3MQkhX2aMEGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+hjy0s2RIwMaYEMuxpDsMBy7vzXKiRDysyE+f6nsKbOy6aiFxKj9+EtrR+hmJoSTw4ulpLSmzkG5j4X5OCDmOs3L7wOJAYSbMJQWhhsSNoi9IamuAApFg0d0qmvR9sSxpPbBQbu2zfNpc8MQgZEPIjMk4CuortPh4ofl3FGARM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsW9zN7S; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso51257245e9.0
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 13:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724791856; x=1725396656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPT1mPxctDrHDMwVvEL0rYvpNuwx7rbLWzqeCXKR0jk=;
        b=OsW9zN7SplPbjQz9kLUGlD6VP/fW/GF7IzsAx8oevsLNQHygf3yt7cGbmZb9fkzJIV
         clOMdSc7MfCVRmhENOlcfCnVTmHGYWBiYBr/XH3hziMvPCubWdkCZf0NjNUDeWhmBSpW
         xuWvDZzNAVzcVPL0jHjMh7KMyGrVDRnzddDe4lsfXnLbz8Fzvi5gynICiFlkvXT+LYmt
         y0YIVsbAb9XTu10juE7Wr4G0GLURM4eSAzuBejZ8X08Mvb7Q2dyd/ETZqwsXmzGNBOM6
         6m5hQZE+GTsCcUH421WeCt3l/JlRYm2JPsm/rvQ7MxXphh0A9fhVLBG4IsQyajogYZt4
         inbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791856; x=1725396656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPT1mPxctDrHDMwVvEL0rYvpNuwx7rbLWzqeCXKR0jk=;
        b=rBSw84aPIuhBACrEo6IQrIvVcIrfJEsNHqCquPSMpkWois9u9f1fJBX0XVp6Fld6b4
         9DtfxFVyLgkjJ+e4bPIk40d/SYk9TDFoZn/VgzVWsoV/YRicc1hTBqigx7w9xDJ1TpnK
         3vQ/SSfxSg/IIyI1bwsDd6MMSyk4axzWqhAXdu8gJfDerXi6+a0BnFf8yYaGKg5dIc75
         Tc/Ihc+2EyIIZ2pXZXApWbYJ0NYPWWoVDwAURK6qNE6yoostogu1rk0LPZKQag5LMcd8
         U12jwr97jjtZa1MgGo0zoyTN9ieYaFs8H7I5IxpU8bc3ohqeuy6P1jAHF5zJ7CNc52q/
         /f6A==
X-Forwarded-Encrypted: i=1; AJvYcCUK4vNgD9OsVbOXPm4sQaLIhAqbbQEcwE96vodcrO5RRbO5dMsLMl0x1eM6UIthHeJQiN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IHgzEHLB7PgNbZY3EOe9RWAmxlEActZTGwS+Hea29vyvhMIm
	gr1LFmzptTqT+7jj6H0+0s7iM5gS/5FTYyW94pI0rtyaN85qvdKFu5FZS2YvoymN82tfHfiHHGl
	RFegWIpL7ygUcaT3e5zPfJogg4ao=
X-Google-Smtp-Source: AGHT+IEClX75+7BsmF2l4/mcMLBWxhyZQBrE+mJ6pdCwwo6h+V7XKNPiNB8grkpnl9rwE0cvUbXPQ3PR/2Q4JyzuDyM=
X-Received: by 2002:adf:a295:0:b0:371:9377:8cb5 with SMTP id
 ffacd0b85a97d-3748c7ceff7mr2566922f8f.14.1724791855797; Tue, 27 Aug 2024
 13:50:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825130943.7738-1-leon.hwang@linux.dev> <20240825130943.7738-2-leon.hwang@linux.dev>
 <699f5798e7d982baa2e6d4b6383ab6cd588ef5a9.camel@gmail.com> <dc2d2273-6bd7-4915-aa77-ad8f64b36218@linux.dev>
In-Reply-To: <dc2d2273-6bd7-4915-aa77-ad8f64b36218@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Aug 2024 13:50:44 -0700
Message-ID: <CAADnVQJZ_jyDzpW8rMuOH2jkiP6mAXMn21DDvF=PA9L8xYt3PQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf, x64: Fix tailcall infinite loop caused
 by freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 5:48=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> > I wonder if disallowing to freplace programs when
> > replacement.tail_call_reachable !=3D replaced.tail_call_reachable
> > would be a better option?
> >
>
> This idea is wonderful.
>
> We can disallow attaching tail_call_reachable freplace prog to
> not-tail_call_reachable bpf prog. So, the following 3 cases are allowed.
>
> 1. attach tail_call_reachable freplace prog to tail_call_reachable bpf pr=
og.
> 2. attach not-tail_call_reachable freplace prog to tail_call_reachable
> bpf prog.
> 3. attach not-tail_call_reachable freplace prog to
> not-tail_call_reachable bpf prog.

I think it's fine to disable freplace and tail_call combination altogether.

And speaking of the patch. The following:
-                       if (tail_call_reachable) {
-
LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
-                               ip +=3D 7;
-                       }
+                       LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
+                       ip +=3D 7;

Is too high of a penalty for every call for freplace+tail_call combo.

So disable it in the verifier.

pw-bot: cr

