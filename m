Return-Path: <bpf+bounces-32207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFE89093A7
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 23:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313E11C22755
	for <lists+bpf@lfdr.de>; Fri, 14 Jun 2024 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C741474CB;
	Fri, 14 Jun 2024 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/YxXeyK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71CE13A24B
	for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718399979; cv=none; b=NX2bJgmldgQlA+JlvyQSaHg9SG6QCuGI0xmHQdgMKLLkvR7fK7VPdD5tVjvZe2q7AWdUPj3+R1nhXSb9ho7GyUWP9GgXIikXHcapQL/LfskBFYvxPJ8kexXMhaONtr8xkksPZcFij8OK1jx2zmY5dHEeAwvWiLWS0vDSkLcmHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718399979; c=relaxed/simple;
	bh=g5N1bhoBk1KxIUms8/3jeyuoZo2ra7YQfx/u0r3HJgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Js34fu8ezPyQORZp9SqSMjLLH5b7Zobu68YlQO6ntj+pS2vQVXvqgzrxSO8vGfZ/WyD2JGjpUfQtbXgkG/ZTtCPINKmaW9AEVMk55y3yJCzd/+Z94a3xPNhddlZhEGS7iFZSfqbAoBbTJJv5nCGFEaV0Q4Ww5yqNf3nmq8qkw/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/YxXeyK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35f14af40c2so2282875f8f.0
        for <bpf@vger.kernel.org>; Fri, 14 Jun 2024 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718399976; x=1719004776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWXIHpFmgqufED/NbnBSGPImga6kttTp/FLBb0GuKoo=;
        b=L/YxXeyKU/orkPSVBABb0M7TDCG5JrdBzBPWns8u2gOiZDpV2ooykQBcBWFCym3D53
         HZTHNTHNfA4DLa+Qdbgd9UQ/JCsIHMxJH3hO0/uHiFoD93WexFAoOBzbj1QpSs3AYViV
         +Qus/mnKOxaS5ZKwL8YtqpZ6O5bETX42diXs8E/9EDhoVbjXAgmZXLklv2ADY4Rf+QEk
         +kKOpZ3z0BvlgFaJwfVHNLRMWUnMYLRjiDqEczVoGREc4mIfcTwLf/ldiziErx2E8PZA
         xYG2EJ9W0fRPj2bkdJm9RAcatVDU8c2+hqOjDpjl8GTZERnqX8jcwYDgh0h88u5T7oQq
         esQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718399976; x=1719004776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWXIHpFmgqufED/NbnBSGPImga6kttTp/FLBb0GuKoo=;
        b=pvhLwHvu6iNh8Kk8/pzY4izbBiqeavXx9Sqho9APD41Z2lWI9XR+V6E8geEhzxqYry
         awilM6to7twrdDrYcPoAHQtDggXNylvh6jFIOTGQYp8cmuqh8v4aTSQ2KhC7SzsVoLrJ
         TKQSO438IfVDUB2k5dZcC8PCjmwrLVFtbORoXwN9jlpzbJSJs6hcZ7y2epQqpDnNyf+1
         7Yur1B9vWhg6KvsmX0PxcZucJpDG9nmOaN0t9Aaj3R5xz68awulp/EYkGWXjh1GedXEN
         9G4B4/D0bkESKcxfGCJ5jPBTPKBm3yvPD1xE2c8+/omQIBKxmK3sjQECzJ1GPTX2LanJ
         yEMw==
X-Gm-Message-State: AOJu0YwOZfkYzeLv4KQdZ9J301Ada6g1kTrh/hoNZ5fNvrxjxJflznpB
	0cWZim2oJtgw26ezcxbT7TvIqXt2/JLFgmgP6bVphRrsaOgLsGuRq/CVDZJ5yUp3w4fE17xQH+4
	QwFXb6pp8sVfp/b3eRr6JWGmbd+o=
X-Google-Smtp-Source: AGHT+IEJcO2pRDLZ2gh09qWIzoyo0m7r5Qnisvg2xhzDajGziTxh59NM79dN5HdBFRNAxmXcjYqBZ4BiPyO0QVN/w2E=
X-Received: by 2002:a05:6000:4588:b0:35f:2cd7:e1b1 with SMTP id
 ffacd0b85a97d-3607a77af53mr2812511f8f.48.1718399975933; Fri, 14 Jun 2024
 14:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eHjqF1DbM2cbq_nXVoanIt042aeSlLwf3xBQ-LTesttfagbXyJfsxMa1zyHU6ngtUYRD4-nfM3sAmyRbPiSN7o4_sWtRy8zodlI7K2UmyTg=@protonmail.com>
In-Reply-To: <eHjqF1DbM2cbq_nXVoanIt042aeSlLwf3xBQ-LTesttfagbXyJfsxMa1zyHU6ngtUYRD4-nfM3sAmyRbPiSN7o4_sWtRy8zodlI7K2UmyTg=@protonmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Jun 2024 14:19:24 -0700
Message-ID: <CAADnVQLPU0Shz7dWV4bn2BgtGdxN3uFHPeobGBA72tpg5Xoykw@mail.gmail.com>
Subject: Re: rcu_preempt detected stalls related to ebpf
To: Zac Ecob <zacecob@protonmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:55=E2=80=AFPM Zac Ecob <zacecob@protonmail.com> =
wrote:
>
> Hi,
>
> I am receiving an error from the RCU stall detector when using ebpf.

Thanks for the report. I reduced the reproducer to the following:
0: R1=3Dctx() R10=3Dfp0
0: (71) r3 =3D *(u8 *)(r10 -387)        ;
R3_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=
=3D(0x0;
0xff)) R10=3Dfp0
1: (bc) w7 =3D (s8)w3                   ;
R3_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=
=3D(0x0;
0xff)) R7_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D127,=
var_off=3D(0x0;
0x7f))
2: (36) if w7 >=3D 0x2533823b goto pc-3
mark_precise: frame0: last_idx 2 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=3Dr7 stack=3D before 1: (bc) w7 =3D (s8)w3
mark_precise: frame0: regs=3Dr3 stack=3D before 0: (71) r3 =3D *(u8 *)(r10 =
-387)
2: R7_w=3Dscalar(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D127,var_=
off=3D(0x0; 0x7f))
3: (b4) w0 =3D 0                        ; R0_w=3D0
4: (95) exit
processed 5 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

The verifier doesn't process (s8) insn correctly.

Yonghong,
please take a look.

