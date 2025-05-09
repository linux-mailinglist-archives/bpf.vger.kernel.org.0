Return-Path: <bpf+bounces-57927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F22AB1E8D
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 22:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06AA83BE423
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425E25F78D;
	Fri,  9 May 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEjCIcnR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE777F7FC
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746823829; cv=none; b=TkHXfmweqqaH/tr+fuNBxF4U7+7xJd30Wf1ZbM744X4UidYEvY36J1kosjFry5s4NOxzNfYEU+d7Ih+qzqNldPRXybk9Cb9Dmh/mz2RzK5Nogxt/img6luBhct66qBT8mxaPei3E/CCb0cKFkq7/czs+TJDui8Nf/3N9QlRiXqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746823829; c=relaxed/simple;
	bh=VEaELEfWzy2VOV/pObng/qspqCv6qbfHZ25soDTAGHE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzEmgq+xQxmIvgEiO7BsFjx8GrfBwvy5eXxRyhFXvkOqkosW9h3eajAfXvoSMnusnOIanbDRinDUj4+EEhGiKsLm2069j3F8U0Um+4/nJMiJ9gw6vxU8DbS6cAh3P8GilfF+UpNz8Xz9TIUoFUl0XhUq990Hj/OxixySiBLXwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEjCIcnR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso2695397b3a.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746823827; x=1747428627; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xhnyj0tgRQstqWR5MXsGggEYjgU9NlA8t7NnKuIfKfg=;
        b=hEjCIcnRxDE1zogh5dqd78jBND6UXqyDwM/KtdM8VQH43HUsbwWaMyl6C9lBL4g5Hx
         hEjXkv7udoi+Nw1cyvv6CByCn/bg9XsMSTcmNMfyxbWbg45q8RN/xskKZcjh6wgsWtbQ
         +upiNyxH3U8vD9qfM9y6Ui0OxmiY/MUgK4l2sYrbAVCZ5IebOAFuBLlUIKpftTS89ts+
         bzIELRB8aIOsbGvjH4wfaqqoZqcPu8Woy1H6qtvvn2hDddI5AFx4miHT2yNnP5HI45KF
         TDQbeidI5xB4QbuLz3wYXWTaRQ4mnodpt4jofojuqrY39DqfmXh2W4uONvMzOOqfzLjl
         HL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746823827; x=1747428627;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xhnyj0tgRQstqWR5MXsGggEYjgU9NlA8t7NnKuIfKfg=;
        b=jABr5Gb3cDxpw20zy0gqvUNuKk/8CgTgKps5W2cxvPS6pZqhEuvkVO3JwdNU8JueKv
         JiJ0hRInhUgfohfu/OGnxF0rDCQY4vRZEhuF8+3n34C2HfvxC/nsy0WlEJ7WsZl1PmVz
         xhsMPcGu2Un8wSwcFj6rSi1EFaNPBlgCZDWRW0w0Z3Ti76X8wUpPKSENATTRZOUJzQCg
         r9+0881xrCZvL9nfUTj1L4oEoLMSmO3dt0wGEI45ysJR+ffkPKtS6qQ+B0ZL8hYP55vb
         veIo8ISON7+XPABDmgi2XrVRmm716pFtj0PGeP5BZJXk1Rsrb+efK+bLi257k7sfvmle
         frSw==
X-Forwarded-Encrypted: i=1; AJvYcCXtsyHi+mPkMbW3BY8WDDE5Bp316Bl2YPgkHQsJ1v7vDBFE/xttf/+RxqwlPPIQrafuw88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4KKqsq/bnVzhr1J3GliGUnsgcZtl2YSZ1n4P5Ta6meqcoz5R6
	v00jjNP/yMsfFGNG4EIEtH4n0bKKp/Ucgt4UaeyD+h7ZoWVxknzB
X-Gm-Gg: ASbGncuwa+lT9dDQc2rOoALBuQwta0isWx8tUDSV0s6y0qe8vHBBAlAGKAiez41NNEy
	OzenhDUKAKmslPOGm/spUlyrGNBf04wdFBSabIaiXgTtHxdLguYx67+0u1hRxAyraSLurNyZnop
	i9DWbVAElg9JCuI1tRza64ZDyRmfqMe2uSszxLyU60x0iRcePGTI+T0ss3powLJvA/mAri49p8d
	fY0zheiuI5Gh8szX/Jr5I5VOrKlPVblJjLRxeXCS3Mt5VgVw/VZXr5zsYO7oRm1UBAY35/ANWym
	58w+iZ1dBwjISOzOHm4D6n234RCWVu4bj426LEqmO7OOIA2bg33SpdeCQg==
X-Google-Smtp-Source: AGHT+IGLeV/9xJR40aE0Zj7L5jyufrYNxMyPtHAZesaZU71b4iutmmy12EVRGcNEClxiaybg1soZRA==
X-Received: by 2002:a05:6a00:1488:b0:736:57cb:f2b6 with SMTP id d2e1a72fcca58-7423bfc355cmr6914757b3a.12.1746823827322;
        Fri, 09 May 2025 13:50:27 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a8f520sm2222894b3a.172.2025.05.09.13.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:50:27 -0700 (PDT)
Message-ID: <342054de8fb765780b1856e5b3b81b4e0a531620.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 07/17] bpf: Support new 32bit offset jmp
 instruction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>, Andrii Nakryiko <andrii@kernel.org>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, Alexei Starovoitov
 <ast@kernel.org>,  bpf <bpf@vger.kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, David
 Faust <david.faust@oracle.com>, "Jose E . Marchesi"
 <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>,
 yi1.lai@intel.com
Date: Fri, 09 May 2025 13:50:25 -0700
In-Reply-To: <CAADnVQJBgEDXnsRjTC0BUPAqfiHoH+ZL6vk1Me-+QcXbT811jg@mail.gmail.com>
References: <20230728011143.3710005-1-yonghong.song@linux.dev>
	 <20230728011231.3716103-1-yonghong.song@linux.dev>
	 <Z/8q3xzpU59CIYQE@ly-workstation>
	 <763cbfb4-b1a0-4752-8428-749bb12e2103@linux.dev>
	 <33a03235-638d-4c63-811d-ec44872654b3@linux.dev>
	 <CAADnVQJBgEDXnsRjTC0BUPAqfiHoH+ZL6vk1Me-+QcXbT811jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 10:21 -0700, Alexei Starovoitov wrote:

[...]

> hmm.
> We probably should filter out r10 somehow,
> since the following:
> > mark_precise: frame1: regs=3Dr2 stack=3D before 7: (bd) if r2 <=3D r10 =
goto pc-1
> > mark_precise: frame1: regs=3Dr2,r10 stack=3D before 6: (06) gotol pc+0
>=20
> is already odd.

Not Andrii, but here are my 5 cents.

check_cond_jmp() allows comparing pointers with scalars.
is_branch_taken() predicts jumps for null comparisons.
Hence, tracking precision of the r2 above is correct.
backtrack_insn() does not know the types of the registers when
processing `r2 <=3D r10` and thus adds r10 to the tracked set.
Whenever a scalar is added to a PTR_TO_STACK such scalar is marked as preci=
se.
This means that there is no need to track precision for constituents
of the PTR_TO_STACK values.

Given above, I think that filtering out r10 should be safe.
In case if sequence of instructions would be more complex, e.g.:

	r9 =3D r10
	if r2 <=3D r9 goto -1; \

backtrack_insn() would still eventually get to r10 and stop
propagation.


