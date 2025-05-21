Return-Path: <bpf+bounces-58696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C4AC000B
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 00:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798AB4E7205
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881A7237176;
	Wed, 21 May 2025 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbTxor9y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914CA33EA
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867802; cv=none; b=ImZft+87hg1zZiYRidmzxxt983SAKmGAybgjomDwRREtqUkpHhyVnSQYSZ9C8rbgK5Vk8Jg7cUwBpXNXT+HSL7/bTWDYNKf2Idl+anvM9aUfsQZg2eyAqSjuiq/Xg+4BdjfUzptrvTkyN/Nur8zEA/1WLM6/Jd9XPttm/APPtwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867802; c=relaxed/simple;
	bh=2PW7A9iAOIqE9DzKp7yYp1cI9D4fFxEw79zkb4Itdm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jOSrbdYZcFJkAps3SBcShGQY+65MRm2SsBTg8BetQkzbDsMZo3Tzt9iUG6NnRcxE4hMLI6bQbDTSFTIBrdq3yLJgdclejDkvXT16DGQSoF9lqBkbPz+UGoVSfMk7Um0h9HQtryJUc8hzTLi8AhuJzU7f5ir4OsFUVpcMLpP0vbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbTxor9y; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7426c44e014so7215714b3a.3
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 15:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747867800; x=1748472600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GKy078H29opj+eruj/7Cp74pKM5kcdsAQ8GUELupAw=;
        b=AbTxor9yg87jdNIqwBqioz4AKbQAlj7H0tYLouOKJJHvqHx+n0+p3DijVkVaeefS8Y
         ZnJ16nuerApPDcoYCVAxEd79lQJMkNXmZrnq4Bu8SqIHDs2yrHnMr9gx3BBj9UpGEoqg
         pnAao9O3lAyIkTH3N40rp4EEGSOOEesjVmvzvug60Lq5kAQIz4ithNevuw2OfuzOZtQ8
         ah6IGfR3Wqk/ZbC1rRWHPnrPk4x1T/dLfdc4RCZosiemBUkyxCTDNjf3qzDdoGE/WNJw
         f/H0ghQrMrC8/OkU3wnPnna5pjkgOGOIDhzwcHwhJF1raaAyXdWKxNQALUlO7FeEBjLQ
         kaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747867800; x=1748472600;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GKy078H29opj+eruj/7Cp74pKM5kcdsAQ8GUELupAw=;
        b=Yz+JBRqr9Y2fhBmAQefaGs8M1j82Sy220lgaO/+eGu4i0pgAOJF4AwNV6mtVoEwtvP
         fDdC3yypHwZ/NeCXZ5xK6Ix4HNszVDSOozTzOhCTgk+5pPXAUu/NR5BM0GKRhgyJsD1C
         iY3eabRq0NAy1t8020qjGrwMOtVyEIl9TQ7MxfdtZMvXA9VC10PNhkkFveyNqLQcJrEU
         /gMFC7u1LNJzZ3qTDQqStwESNcv1mstC3vjPPxHH9N84v7bqXXACgonuB3xeWDwIKuh1
         HXhDMv3YzeUDT3IJuVkRIqIUgkzPrcEvW7g2z4xhrE4MtAl9pYXGNvM5Z9kQ48tZkDaY
         0/yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHCOB+EIwgGk6nWDkD6M/0t5aoW5zsh1iNrrTifMikkcgjv2NaiKUfYV63e/stmF6xo4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrOHo7u8X+wEEYeCvDzWx8NrM8/Y/xm2C+/zw+eB8e++0T++ex
	xY+t8zY4waWKfvx3TWoCALrKAtq5UIURqnj/l9A9ozXQ1LhXbvOf4QYx
X-Gm-Gg: ASbGncvKG7+FPeNQIBH42xt2MelburfBMc8OFCBAjj8aFE8dY+8m+i6aJxxBf5cNmxV
	SkOlyQ7w6mxdj3yuyOh3FDMznJhdvvNiUp/mWlqytMjfaFO9VyevR/6SnsY5zQavRd7v6KEfshh
	2BKVFFDGhspniNqRDytfr2T6MFB5mEmh2X62jcbcFtfsGLtgZsMW5I3Bj2uWHG0hSN7K/HER0OU
	yX5bRdv/jbCnSaovdYS06RVWkzd9nFO384tLK4wykibLc8OrAHru32vBtVrbvMe1DGSIA1ZcyQ9
	rgkedzGPDBuF3z8bgfsrUXzBV8Lz9cbc8h2YA+qaxFbwLQexXYBEU6s=
X-Google-Smtp-Source: AGHT+IGXlQmMv2C0I2TaguMhzH24X7oVguNBjre9tBMoUidNLkZoxtG0z9NRD254tKQikE1ltprxvg==
X-Received: by 2002:a05:6a00:2288:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-742a9787737mr35715318b3a.3.1747867799687;
        Wed, 21 May 2025 15:49:59 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:8d1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a985e290sm10011526b3a.124.2025.05.21.15.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 15:49:59 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,  bpf@vger.kernel.org,  Alexei
 Starovoitov <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  kernel-team@fb.com,  Martin
 KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not include stack ptr register
 in precision backtracking bookkeeping
In-Reply-To: <CAEf4Bzbx6xHc2LMCWpY_yQExgjauo0UaDmF4rDuFjefNvOhqRg@mail.gmail.com>
	(Andrii Nakryiko's message of "Wed, 21 May 2025 15:38:50 -0700")
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
	<45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com>
	<2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev>
	<CAEf4Bzbx6xHc2LMCWpY_yQExgjauo0UaDmF4rDuFjefNvOhqRg@mail.gmail.com>
Date: Wed, 21 May 2025 15:49:57 -0700
Message-ID: <m2jz69bmui.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Wed, May 21, 2025 at 1:35=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
>>
>>
>>
>> On 5/21/25 11:55 AM, Eduard Zingerman wrote:
>> > [...]
>> >
>> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
>> >> index 78c97e12ea4e..e73a910e4ece 100644
>> >> --- a/include/linux/bpf_verifier.h
>> >> +++ b/include/linux/bpf_verifier.h
>> >> @@ -357,6 +357,10 @@ enum {
>> >>       INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
>> >>         INSN_F_STACK_ACCESS =3D BIT(9), /* we need 10 bits total */
>> >> +
>> >> +    INSN_F_DST_REG_STACK =3D BIT(10), /* dst_reg is PTR_TO_STACK */
>> >> +    INSN_F_SRC_REG_STACK =3D BIT(11), /* src_reg is PTR_TO_STACK */
>> >
>> > INSN_F_STACK_ACCESS can be inferred from INSN_F_DST_REG_STACK
>> > and INSN_F_SRC_REG_STACK if insn_stack_access_flags() is adjusted
>> > to track these flags instead. So, can be one less flag/bit.
>>
>> You are correct, we could have BIT(9) for both INSN_F_STACK_ACCESS and I=
NSN_F_DST_REG_STACK,
>> and BIT(10) for INSN_F_SRC_REG_STACK. But it makes code a little bit
>> complicated. I am okay with this if Andrii also thinks it is
>> worthwhile to do this.
>
> I originally wanted to replace INSN_F_STACK_ACCESS with either
> INSN_F_DST_REG_STACK or INSN_F_SRC_REG_STACK depending on STX/LDX. But
> then I realized that INSN_F_STACK_ACCESS implies the use of that spi
> mask, while xxx_REG_STACK doesn't. So it might be a bit simpler if we
> keep them distinct, and for LDX/STX we'll set either just
> INSN_F_STACK_ACCESS or INSN_F_STACK_ACCESS|INSN_F_xxx_REG_STACK
> (whichever makes most sense).
>
> We have enough bits, so I'd probably use two new bits and keep the
> existing STACK_ACCESS one as is. Unless Eduard thinks that this setup
> is actually more confusing?

Idk, I don't see much difference between these flags for LDX/STX or JMP.
In both cases it's a signal PTR_TO_STACK on the left / PTR_TO_STACK on
the right. So, having two ways to express the same thing seems a bit
confusing to me.

Defer to your best judgement.

[...]

