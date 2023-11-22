Return-Path: <bpf+bounces-15662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C387F49FC
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27D02810CA
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7834E1C9;
	Wed, 22 Nov 2023 15:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzdd5vMo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CC9A9
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:13:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a98517f3so9087868e87.0
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700665994; x=1701270794; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aylZEezUbbaRhiN6atOUd5UZ+qGtW9zr47TuqH8u2AA=;
        b=bzdd5vMoZM/ecE+w5fw1i8gU9L7dGhPe2+wBElxuRNrtqv0aAQ/rMD84KvmEbccI5V
         74caYEa4kZOY4Efnd4kDe0rHyGzRfStk47dAW1ZuuZHYhR9kIN48M/MQmJS5TZURyU14
         qRJONvYbx1B50kk+p5Sb/JTMKJB7FIaTI9wJ137zMPD2pryFFBjxfEW/qp849E0dJg1q
         7sp5nrjfnDkPjRSWHoHIYN5j4mSeFYYJMu2ObD8VcfaUE4OOwfvc2TWGnpi2xxKy5jlv
         wXJsIYeLa2jw8TJJIweDlJL8IkKQGoz9rRCwyZU5LBxFNxSHDbENpiS/4F+BNeAY+MYj
         I6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700665994; x=1701270794;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aylZEezUbbaRhiN6atOUd5UZ+qGtW9zr47TuqH8u2AA=;
        b=nZ8LWJaRJ2kYJQlCq4m8D8pS/6SxXmey6hALZ5IZC4G99zSOTEKM0VKojIBDskkPyq
         SXAGglbsj92t+nzBfeijzpbK++mP+WPDfKelUPb1e9g9oglruc33iRw785MqqS9KYt2y
         vHkO+xNb6jYn3f2Dj+AOdMTqV1VyDsvCLYfL4OOtnNy2YgWll/Gv4JbmnwJtCy38HC0I
         57GKj0tPL/xAX1yoMlySnYeTX3e5OibIcoo7Y97PsDnirU5j7TKFcKykfruaI+xrrlwZ
         clrpnljx+VFUIZ21niFd2De/Q2zRkxc+FU9tmc55p3vaP4bMzrf99z+CUuXqBqa7Q/y/
         d9Yg==
X-Gm-Message-State: AOJu0YysCgj0C02GJVDz/Em2/LOGtDgtaEgpjIl25D9S9dUn0W5uIOWx
	0F6x2uvjMTZKkoqEV9MOI2E=
X-Google-Smtp-Source: AGHT+IEPGhd1LoqG2Yo1O0MBNa8ie27wLVzgqaYzGpcq7Rtrnx1SPp2c3prPFlPvBO72CkrGBTfp+Q==
X-Received: by 2002:ac2:4906:0:b0:509:11fa:a208 with SMTP id n6-20020ac24906000000b0050911faa208mr2030682lfi.43.1700665993786;
        Wed, 22 Nov 2023 07:13:13 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i26-20020a0565123e1a00b0050aa94e6d15sm1364751lfv.9.2023.11.22.07.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 07:13:13 -0800 (PST)
Message-ID: <4b12e29372014a46a399ee26870c306fa492319d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 05/10] selftests/bpf: add selftest validating
 callback result is enforced
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Wed, 22 Nov 2023 17:13:12 +0200
In-Reply-To: <20231122011656.1105943-6-andrii@kernel.org>
References: <20231122011656.1105943-1-andrii@kernel.org>
	 <20231122011656.1105943-6-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 17:16 -0800, Andrii Nakryiko wrote:
> BPF verifier expects callback subprogs to return values from specified
> range (typically [0, 1]). This requires that r0 at exit is both precise
> (because we rely on specific value range) and is marked as read
> (otherwise state comparison will ignore such register as unimportant).
>=20
> Add a simple test that validates that all these conditions are enforced.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +SEC("?raw_tp")
> +__failure __log_level(2)
> +__flag(BPF_F_TEST_STATE_FREQ)

Nit: although it is redundant, but maybe also check precision log to
     check that r0 is indeed marked precise?

> +__msg("from 10 to 12: frame1: R0=3Dscalar(umin=3D1001) R10=3Dfp0 cb")
> +__msg("At callback return the register R0 has unknown scalar value shoul=
d have been in (0x0; 0x1)")
> +__naked int callback_precise_return_fail(void)

[...]



