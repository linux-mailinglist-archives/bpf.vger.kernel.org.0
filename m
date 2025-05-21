Return-Path: <bpf+bounces-58686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96518ABFF4D
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 00:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12631BC5676
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53696231839;
	Wed, 21 May 2025 22:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZB1qIssM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757561754B
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747865044; cv=none; b=Qg8oergNQD+BVsZaXkff6yGC/NIANMZSvTy6eUzOPt/J3kN5uO00hI8g826YZ1iED6Bik93K2Nr16CT9u5j9PXKSPpWyCS3QxsfC4KtNVEPC0SGQlhdsczH8NDfTGxBZce0y2uAfEYP/QXnktrHVit0IBHcj4Cle4gCY6AzT+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747865044; c=relaxed/simple;
	bh=DUQto6Gj9tcfOqspCUWtW8Wsnj9E1L5uJrdAwIKSnOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJKTAYQh2dj9WazqHfDkg9XAF9QDueKaWKxhLeWKqnoorgOGw6Y4ce5NzMap2ax3p3p0NyyLkbLBAujanDPqlmHiU0tHjWFXMkPYtg7ygPO4nD9q4RWLS1OpqVIRUio4YTAqI8qsMx2lfuofMOKSOCMbfAHZU37Bp+BzoubQu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZB1qIssM; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30f0d8628c8so2686178a91.0
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747865043; x=1748469843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us2zkd4e9Gu/uKMnClee4820ZPOn7s9M5IKlf6fun4Y=;
        b=ZB1qIssM0HF9UeDRbq2LqoVFG6CCk5lUQOzKM+ZWlggtvSwMWH9vWEyhR7YBmeVyDu
         JGAIkJYT5NZJmhfe2Rfh11laMP+DzeD2Xzubi72zW8G/8AezYoOk+hL8piG0cn7voeTr
         sF0X2kLGDjsMZMRjjRHJpaqhGxkdT5+VD/weljB04cb94gsyMXHM1ZDLddg1VE8Av67h
         x4ksx4AKbw1bb7LgfBRIiUe5AoTp7a1LF1DUZ2bb8tXMbTkk85lpkdx+SGZ96KIRLEZ0
         Iu3bnbzH7/MDsPygT55jmfoXLEZ5BsM0y3ONus6Hti/Cl7gz+lMHuUqksYNV9weBZ0r3
         c8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747865043; x=1748469843;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=us2zkd4e9Gu/uKMnClee4820ZPOn7s9M5IKlf6fun4Y=;
        b=LDeIMSBwvaslT0WhAHmDL2RaM6T2H8MsmgeRj6sWz5B+jEwgAkwg2lJRL0xD7MIWO/
         z6R8QvYcM0OgVpzcAnbmqirZVf3rf32H8talMfjZVcMM4fw1rH1/h37Li4ZZL1L1zcEB
         zhLYkFpSyF8mUDuZzLSCwxlS3Du7HANVoYmkDyqabIdhlcARys6Hj4sTo1h6GtA0Hg2j
         R9Mczr6IoqvxOBUVE2zhIKB1bRdyLYXmqLkqBkTFtWcr9mdjXZVsq5Bmwdo5PViViigi
         a151cmpjnJf95sA36zGHo51+bdzqAq0Dc3Lij0HZoMs7b58b7pTiE+C/nIWwa5/mp7pi
         zjRQ==
X-Gm-Message-State: AOJu0Yxo4kp2kQdJrFhL+gjEM+7tVHeQzv4BKqTmn1iDqZTrsRAyTgpt
	JHzKbVvZJEKXGSOr3oGfe0X+NYXdNKrJHbZ0tL1bkjGaCXpVokXqNuq3Mz2jdVM3
X-Gm-Gg: ASbGncsHogsDExSlf1ICpLxs0A1gvrKDGXHRgCrOQ7WhloAaFiGIYPw3f2vm2J5Xt03
	qsFC/RkvCMw7We//0hDg6Rketv5Z0Hrs+Viq2HHiXPLo9/pMoFAxOmE1wpde4jmQTp0gh42V5hA
	6lAz+QKEsIaRg1AynEarmV/xlkllg5oIGwSj+4YgOcgYIleJsIwseC9JPwgiB6p18wxG/E51Txk
	R/vDP9Nh0NYBmLQSd3pnLv63bRqEMEMDXqrAwC34bYn7amO3QqtKHleOJ9q1YvTBmAdkYxPdemi
	0RuYiD/jGnNgfGliVdbJvioRPj8eTlquOSjVQAVXrIyMWvkC4JfQHyo=
X-Google-Smtp-Source: AGHT+IEdZSRmFWd4uxTh47400rwglK4xna7iVW9QFoE5pyQA7z2WC/qZ6k0WLDoHiS6H6u8odmMN4Q==
X-Received: by 2002:a17:90b:3f4c:b0:2ff:556f:bf9 with SMTP id 98e67ed59e1d1-30e7dc1e9c0mr33413316a91.4.1747865042558;
        Wed, 21 May 2025 15:04:02 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:8d1a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f36366219sm4170148a91.6.2025.05.21.15.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 15:04:02 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  kernel-team@fb.com,  Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not include stack ptr register
 in precision backtracking bookkeeping
In-Reply-To: <m2zff5bp70.fsf@gmail.com> (Eduard Zingerman's message of "Wed,
	21 May 2025 14:59:15 -0700")
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
	<45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com>
	<2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev>
	<m2ikltd6kz.fsf@gmail.com>
	<6885590a-266e-4230-9eeb-4fbfd7e2f3f4@linux.dev>
	<m2zff5bp70.fsf@gmail.com>
Date: Wed, 21 May 2025 15:04:00 -0700
Message-ID: <m2tt5dboz3.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eduard Zingerman <eddyz87@gmail.com> writes:

> Yonghong Song <yonghong.song@linux.dev> writes:
>
> [...]
>
>> Let us say that we remove the code
>>
>> +=C2=A0=C2=A0=C2=A0 if (!src_reg) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (linked_regs)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn push_insn_history(env, state, 0, linked_regs);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 }
>>
>> The code should still work. But we might end up with more unnecessary
>> jump history entries. For example,
>>    dreg->type =3D=3D PTR_TO_STACK, sreg is faked (i.e., BPF_SRC(insn->co=
de) =3D=3D BPF_K)
>>    and linked_regs =3D 0
>>
>> In this particular, we will still generate a jump table entry which
>> is not used in backtrack_insn().
>
> If linked_regs set is not empty the push_insn_history() is necessary
> even if src_reg is fake. Linked registers are handled at entry and at
> exit from backtrack_insn() outside of instruction pattern match if-else
> block.

Nah, you already handle this in the !src_reg check, sorry for the noise.
Thank you for explaining, makes sense.

