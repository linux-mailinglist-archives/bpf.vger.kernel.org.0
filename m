Return-Path: <bpf+bounces-46113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA839E4645
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 22:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE973286A26
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 21:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122B019007D;
	Wed,  4 Dec 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aor0yRud"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268B7239186
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346534; cv=none; b=UVGcAkWE5cJpEM86zkvTaRNaIDkigol3jppmGPwdiJlVggUPnRbcjBFLKbUw+W7ikq8OllvTf0TidZjsbp+iWLdCSQRhKa+XvVESQqWgHxrA5wjgcPas149DRaNLZfVR/dxXQkXhT/VDHS/A4dpu8lF50U0Hf5jr/23yYCj9CtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346534; c=relaxed/simple;
	bh=6nDDJdGFDDN/MFUJJlAiGc3JOk0EiYWE+uyw7n7l0r4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qtkFpnWkBNCQHD+bRSHl20kz2G3jRh6DLA5QzxSukvsbsZdClrqK7co39FhQr8tFduGkvii28BCTVfTpMqUxdS2FiLbzmoc+bY2D13CgL8kAc+erxPyX71U5WbLBobUkIAhqrwtDzIF5iWkJWsimrDVry5Lx7NDF73xsbx/s+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aor0yRud; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cf3e36a76so1722255ad.0
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 13:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733346532; x=1733951332; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jf+IgMVh1M32zc00NegILtoCExERKP1EGJG4MM0a9xA=;
        b=Aor0yRudQyREYqBXHmFDziIQMYnE1fYkA4ybAWzHvpimr5vAV++K6e/Ua2dGqzsfxD
         o/pBC3PlQYYCXNnJSvAdK22iY+3swObWcMwpT9Ic4AwbtjJaTmHM5epAk2XxUPHhhRH1
         8JO7UDfnSQE9/hhfNNydxQzx9JIGVhV34UTxWcaqlG5JBN3qkw4YcuTMCV6qpbeHMljq
         YL1pdhnAUxIzjJV2ZdLB8FRREclAUXyUfn9sqLpu8qx1tW3/pEZiMHQ9IswxFV+DgqLX
         1kqKYG3gOXt7l5nmMLh9rRspF0sWLC28QIpCzxOoX8ehUyHor2uhPTLhz3B0gA50+vek
         cBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733346532; x=1733951332;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jf+IgMVh1M32zc00NegILtoCExERKP1EGJG4MM0a9xA=;
        b=dtJlQEvLbnKTw3vh/PgI2rrfJXR+FaJQzJkqnmXqGlG7FOlCOeknjEueWj9HZL8gaN
         PObpphklvYrMcNGtw9TwKgHnZARxuzd1oVTXowdqkciOz3aBoX1juZooQJHyxrBo5Nc+
         6wD6eaPSM6XIbmoBp3Fq+CX5GqKiFrI8Kpr+PBsNx1AxJo5gu24GUgtK8uA+mrD1C2zn
         SQxgltGj+NLhmP2fZmuskxTGx2Q4lYoK9pkmLdCReITTgyxjRoNz4qmFZBJS+hVZS7rg
         ukoD6rMaoCm5lTXTw+IAzh9qvvcIRpFtElysaS9rmIzzYmmR/mEDg0jSUVAajp3r0vEu
         nDdA==
X-Gm-Message-State: AOJu0Yw9NB4ny3lIvxSucZZkO+2tEy+YOC6pazTvFFBMpoZ4v9LB6Xyx
	4ri1nJa5YBBM4zOXW5EXKeTrHKPWfv0ByvNXJA/BXqmi+0QPTtwJ
X-Gm-Gg: ASbGncutwt5f6zeFLZCI+rBdW+OHC0JvmXaDNtGqiy2f3oKskBK4ExpB+tYhMWS93Cn
	G0W5sfd8ijfjBx80IjEPW7Hii/ozMggDnYHuhU78LeOBZj3RSdLrKd1V3+7++uZ9kfCVxkKAx6f
	Rd3mW1Id1+u24iU4s7FfocbdvzInsmyZF6wL01JlnQYifHNw23ZhaNweDxNYuOdKyknLE05kXs2
	vEd2SDGrErCBGQPnyAOVhd09aILiAt0bNSH9z2QN8vvyMTzc+raIyMWpc1Hd8aaWA/Nbbbf+kIr
X-Google-Smtp-Source: AGHT+IHgDCgbfROtZQawSi1nP/RKALj65mRbhfJgoP6OZYPXStwng3pkTrhP74kHmUH62k4Abm1goQ==
X-Received: by 2002:a17:902:e849:b0:215:6426:30a5 with SMTP id d9443c01a7336-215bd11caa6mr112186005ad.40.1733346532291;
        Wed, 04 Dec 2024 13:08:52 -0800 (PST)
Received: from ?IPv6:2620:10d:c096:14a:ab16:b297:5216:f3f1? ([2620:10d:c090:600::1:468e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215dc045a98sm15924795ad.32.2024.12.04.13.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 13:08:51 -0800 (PST)
Message-ID: <ce15b00ac30c6cfba16f63e6c03018a59af8acb1.camel@gmail.com>
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Add raw_tp tests for
 PTR_MAYBE_NULL marking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Manu
 Bretelle <chantra@meta.com>, Kernel Team <kernel-team@fb.com>
Date: Wed, 04 Dec 2024 13:08:43 -0800
In-Reply-To: <CAP01T77F4yoJYJ3CZ-zypGUSCCApsS2iGQ-EZiO2Pk0sw2e0Mg@mail.gmail.com>
References: <20241204024154.21386-1-memxor@gmail.com>
	 <20241204024154.21386-3-memxor@gmail.com>
	 <f844604cb8f85688c9faf4bf0c6d5566eba5dcdb.camel@gmail.com>
	 <CAP01T77v3ctFfT37iOfMm0XOqOD_bzfYuLcjnvT=JeokCZ=2BQ@mail.gmail.com>
	 <CAP01T770rUveB4Toj_gU7Fy-SyyTr0EvaCBDTxdkGBz2bBBAzw@mail.gmail.com>
	 <CAADnVQLa7ArR0ZSi_zERZxWCCvi6u6TdmOpfkveuRo_EwGqsQA@mail.gmail.com>
	 <CAP01T77F4yoJYJ3CZ-zypGUSCCApsS2iGQ-EZiO2Pk0sw2e0Mg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-12-04 at 21:48 +0100, Kumar Kartikeya Dwivedi wrote:

[...[

(A) ----.
        |
        v
> > > What this will do in both cases::
> > > First, avoid walking states when off !=3D 0, and reset id.
> > > If off =3D=3D 0, go inside mark_ptr_or_null_reg and walk all regs, an=
d
> > > remove marks for those with off !=3D 0.

(B) ----.
        |
        v
> > That's getting intrusive.
> > How about we reset id=3D0 in adjust_ptr_min_max_vals()
> > right after we suppressed "null-check it first" message for raw_tp-s.
> >=20
> > That will address the issue as well, right?
>=20
> Yes (minor detail, it needs to be reset to a new id, otherwise we have
> warn on maybe_null set but !reg->id, but the idea is the same).
> Let's see what Eduard thinks and then I can give it a go.

Sorry for delay.

I like what Kumar is proposing in (A) because it could be generalized:
there is no real harm in doing 'r2 =3D r1; r2 +=3D 8; r1 !=3D 0; ...'
and what Kumar suggests could be used to lift the "null-check it first ..."
restriction.

However, as far as I understand, the plan is to fix this by generating
two entry tracepoint states: one with parameter as null, another with
parameter not-null (all combinations for every parameter).
If that is the plan, what Alexei suggests in (B) is simpler.

