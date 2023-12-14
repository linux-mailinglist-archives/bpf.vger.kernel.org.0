Return-Path: <bpf+bounces-17823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 452E081310E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62B21F220BB
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99825478B;
	Thu, 14 Dec 2023 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU9D2cKR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1430E118
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 05:14:02 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-67ab16c38caso51625646d6.1
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 05:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702559641; x=1703164441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfN0hVgkxjRPizUVQSOAbQn80U8UNZ9vtvalz+tNfOc=;
        b=fU9D2cKRDiVKdOfDyynGbavC8iUkbGwhzFJgCLu/OLJSuDI5MJhsoEiJK92sSudHJX
         N8l0Z/irUqBbvJ5A7pllcvUdj9FVAXU8rUS/uqxwi71fIWyrqaomat7REkdhOhsm513N
         IA1R23ZPxc232rETjSldrq9hFz2NaHu+6RwT4qxSdfpfX6uDYe7bPTXvg2P3WxgIHIeU
         vK5YMPqmB6hRZ1IB4MHLocAU42/MBq6LE7n9zgPO4rFpuXJHQM0OYclB8S1YuAM8efnL
         zIIrODZ9ZdR5Olhx6kj/JoWaCKmAnTAmdOSGXjBLByn9kAhLbfg9CRCq6WGq6a7HCBSS
         aaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702559641; x=1703164441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfN0hVgkxjRPizUVQSOAbQn80U8UNZ9vtvalz+tNfOc=;
        b=RHdLU2O7f0s9hwKv4NxE+kKkjVL4r56CRhoRWNfNgsGwSldPwiVgZZxj3YFmHHbH5v
         QJjfGdrVCIt33DKCbCOluHocRe6q15uE2uDRiAnn4FhrdFy38MfUbmYjcBR8ofZ/OFMT
         9ILqAhm0JsAjw865jGutDX5UEV6W/s6MXBqCPDmhHLUPnIqj0gvhY5mJW/7cnpRXLwuH
         jyWvf7zM83wUKfqkaVUJchPnhyCbvMql4KkhJ55Fk25Kbm1Mc6u8z2DZtYbYUehJVRSE
         YuTvny9vStozJHofnhDIXMjK8zBHFulV+/yGkgQF9Czr3np2z3NalD2yrupvXRZox6mk
         r0IQ==
X-Gm-Message-State: AOJu0YyJlJKU2CvCn2uKm26im41hpPgsC5HH46Y05/Jc6mU6i7RNmqOc
	sfDbkvb1/lSBxnMec68E6J+xydhvHvPHt1pI3zs=
X-Google-Smtp-Source: AGHT+IH6hZIzujLZIAZAu6xwoPZprhkglrrXGYopnLg6SUxYi7luG3oOZpBAxP2TnN6ytKJonW1Qg+GCoSJWSXh5vLg=
X-Received: by 2002:ad4:5ce8:0:b0:67f:127d:3d49 with SMTP id
 iv8-20020ad45ce8000000b0067f127d3d49mr157814qvb.55.1702559641202; Thu, 14 Dec
 2023 05:14:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214120716.591528-1-dave@dtucker.co.uk>
In-Reply-To: <20231214120716.591528-1-dave@dtucker.co.uk>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 14 Dec 2023 21:13:24 +0800
Message-ID: <CALOAHbDzZ_KU05jq+Z_j29gzfSFQTnspnGK3c0iH=4xRQ3ct8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Include pid, uid and comm in audit output
To: Dave Tucker <dave@dtucker.co.uk>
Cc: bpf@vger.kernel.org, Dave Tucker <datucker@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 8:07=E2=80=AFPM Dave Tucker <dave@dtucker.co.uk> wr=
ote:
>
> Current output from auditd is as follows:
>
> time->Wed Dec 13 21:39:24 2023
> type=3DBPF msg=3Daudit(1702503564.519:11241): prog-id=3D439 op=3DLOAD
>
> This only tells you that a BPF program was loaded, but without
> any context. If we include the pid, uid and comm we get output as
> follows:
>
> time->Wed Dec 13 21:59:59 2023
> type=3DBPF msg=3Daudit(1702504799.156:99528): pid=3D27279 uid=3D0
>         comm=3D"new_name" prog-id=3D50092 op=3DUNLOAD

Is it possible to integrate these common details like pid, uid, and
comm into the audit_log_format() function for automatic inclusion? Or
would it be more appropriate to create a new helper function like
audit_log_format_common() dedicated specifically to incorporating
these common details? What are your thoughts on this?

--=20
Regards
Yafang

