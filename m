Return-Path: <bpf+bounces-61007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53B7ADF938
	for <lists+bpf@lfdr.de>; Thu, 19 Jun 2025 00:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA0B17BE50
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 22:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F280E27E7DD;
	Wed, 18 Jun 2025 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOjDGYZw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1A2153D8
	for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750284779; cv=none; b=NjJyNiimrOYFaoPhRHQ6+KdCrY9PuujlelXbYDsOakZynQZzovEmi2t/RJjYJDRZ4bIUJzryJlY2u+0RdPq8m8jPAHAUYI8YmXAfAXRGf/nSt3ZjsUKrpEAGenFCvHKMNULQ2nlQ/8ptmNSI182/Z24WTe/cmy/qR/GpMnPKr4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750284779; c=relaxed/simple;
	bh=EhmD1njWEVSLsR0H8BFBZjgrpowBt235EDpzH/SmavQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p1mQzNTNPFNsb/4nRShyBFqXd+36lHp14FyKKx87D4V3DRP3X2VKZ/8WYPRqGYJfqHxoaez6urlw/Qih+SOhc+Dx1mr4CEShht+op6ez2oT1pTCazZhns9xM0tpZ2wPeqIsqFYfQSSJeQP8HPWE3kovEV9mjl3aqj4XKETLquE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOjDGYZw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so94468b3a.0
        for <bpf@vger.kernel.org>; Wed, 18 Jun 2025 15:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750284777; x=1750889577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EhmD1njWEVSLsR0H8BFBZjgrpowBt235EDpzH/SmavQ=;
        b=XOjDGYZw09CM0ZdJ66covisQO9Be4MRLd808t17YhVXSV9flnkPdKhhDJv18S1bfn/
         j+zdaN6Li+8PBSJfnplN9zhyMVSgso/pDBtiL1CCwb4+Rm7vuXxm0Mu53vpLY3aEmjan
         cmSAfZGdQVvXw7xvghOqG1b0AJB4vysXzYPVJyIUNiX+Cf7o5nelZhla0Jc71fmtWefr
         LYL+vlDq5l0N9YsILHlTqdg/JS5ls/RBQ1woSbmF+2iG7CQE8gsd4G0wKyn1r7HcAoHx
         7536mbQ5bekyHUjNPu6UV3R0fQ7dM+4eJ6U/V0Tj9sgvr8S8cFjMyEqip1sJHaJ9dzw0
         8gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750284777; x=1750889577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EhmD1njWEVSLsR0H8BFBZjgrpowBt235EDpzH/SmavQ=;
        b=tAFkhcOAosAznoisoHYbtFtNA0VdpmOj+3TWv14u3QteqVRgQHXZuSxCO3nstAqIKf
         Sz/WjPWAwA4l7TmxHd3HIokMxCDhemRpgz2lXXjdGcEOPzDtCueyGTvYYRqP1Zqksx/Z
         Iz8iPkvKzUPxJd5xar30pQ7uNPlfuULSwUhaWU/qsoVthQb+bd2fCaX5tlwm6iFn2LXe
         mt47Q+6Ho56Eu9aPrz5mv5URzrb05I0P68fgtd0k6VqvuNcADPdu9zbWZwxAul+O8JNI
         jpLg4SlppRdQdkeFKmKHsZhrZknpSMj25S6LR5R9niQJSCUeoX3IGM1G1FXNnvue//nY
         mOpw==
X-Forwarded-Encrypted: i=1; AJvYcCUgwoDH4WhvYW6Ff8G32zcMmmvL20QEcdxHv7zsk/GOnWu7KhHIpIrV2pbWTuCxONBBsSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVcOaq6aihgytpynjG6YJ4AI7U0cpcRvoga7+Ga+I2YHW0Ysu6
	f0oR9Rjm7kmLtz2J58FnwiQ9jv8OZpQQaUYgBukBq8LUrdE7u8V4L8+x
X-Gm-Gg: ASbGncs/+iOutOFDCmjigVggnvmbu4RLmRSxE/nQsYeZncAL2z4rEXSlc8GRzcbkQ4d
	M1H57f6pIqDlZsPLU47q8LVDw/RJV17/aBHnB8Id9cIfTBmvil1yS4fYQf4AFmwY9JQtQxPA2MY
	FyIGLpt6sqiq7H1Pxdbrr5YHXl7JarlDhRUVygz7901XhPt7a9QO1FZ8UBxMjcGJ3hkh2rUYROn
	LbfJda6l6HYJugRJxezi4pxM/JTQUB0s5Kj7kNgW7860qq6TollAFVndg/seGWNoquBFWRYpjUc
	29DEMFTMGjApjFD/31SYV73C4uaNqg/Iipr70gN7+68EFEnYCG1Rml/jsg==
X-Google-Smtp-Source: AGHT+IF5vX/KQyjWrIq2ZY5guClWcjmd+2sRNk/9pKOWMtOEqyBeTDaa1V2UPrqVG/pDG8HMD0nrWg==
X-Received: by 2002:a05:6a00:806:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-7489cfdce76mr28614049b3a.21.1750284777349;
        Wed, 18 Jun 2025 15:12:57 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca93sm11657659b3a.20.2025.06.18.15.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 15:12:57 -0700 (PDT)
Message-ID: <7da6c128d7763a16081b5ed55623db67c7ccb7a8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: separate var preset
 parsing in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 18 Jun 2025 15:12:55 -0700
In-Reply-To: <20250618203903.539270-2-mykyta.yatsenko5@gmail.com>
References: <20250618203903.539270-1-mykyta.yatsenko5@gmail.com>
	 <20250618203903.539270-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-06-18 at 21:39 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Refactor var preset parsing in veristat to simplify implementation.
> Prepare parsed variable beforehand so that parsing logic is separated
> from functionality of calculating offsets and searching fields.
> Introduce rvalue struct, storing either int or enum (string value),
> will be reused in the next patch, extract parsing rvalue into a
> separate function.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


