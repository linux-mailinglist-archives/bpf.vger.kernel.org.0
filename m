Return-Path: <bpf+bounces-33665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A35C924984
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B52C286B88
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 20:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93187201244;
	Tue,  2 Jul 2024 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJwEXy3m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF54A1CF8F
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953043; cv=none; b=uQvW+Xrga8OZtX5otBdZw7wxic4g+9R6dv70nr+pYE+XXLv/bfCGM5Xi9NF1Ld08BufGTiEZOS5a7R9cOJEzT7yQR4QQaT5SmoV53/MMcm3ePoEQP42J60m+4CRet9EyaLatD4bcKvoyJquzEK9tGjfAIRom6eLoHdyOlqQvGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953043; c=relaxed/simple;
	bh=ByN6RqnFn/tsnwij3dM0b1UtZYZopkjf3L4+9NiqaNE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcWw39bsyi/sO5fKVUJqdB9C0SopeqkgH5Z3l4ohmb6npKHpeELDsh4cwOIFz0nNWaiR6hMUJMY6XeaS6aoEDy7h12DEC9TtoWkXsyQbbksagB4mmZGDh/M2WBPngiVxQcBrdB0E62IZ9eKU7zFyRuxT5iWiVJTb9kmBLue0Lr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJwEXy3m; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fab50496f0so28091885ad.2
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719953041; x=1720557841; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9Qi1pu+cs5awGul39nevCkdf52zOPGQn70hdgurqUM=;
        b=bJwEXy3maisuhZtDjg5KK9Fy06eViELh+SADqYv8ZkXGwu2efuxcM2XC4LtxlI998x
         hCitqLhtOaFlsstSPrfBeb8XR5uMGuMW5OTk2eNuc3cPr2n715xmATB8OZ6F9dejro6E
         0mSjdibIa/KlYMRDEfeD3bNTnROfWE8KSzxhjXtAt7p93Dq9slEzg9hwHUaa1XdTSZ1O
         Hz/LRlHM4EZc7D31I8Fr3rimtbBrJGD5O9CaLG0iiQoeb3MyFsnfXIfSzZytW+QDbfh+
         Cf63jk0nDhumF2WMx7k4uyVBjNlfaUcjbxGiAN4F6D1wsja5rPkzryhQFRnnG0zlHzXw
         wQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719953041; x=1720557841;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9Qi1pu+cs5awGul39nevCkdf52zOPGQn70hdgurqUM=;
        b=cnIFtwV8pCm7hanYZFkPKN4JyoDs3D5I6pXkrwFOg4TlRsVCN57dEozwF7A3VkfSHU
         t4SIM6P2jZGSvW9XemRNkoaMODulUp73ycIPPYuFIkGQT0whkBHUSLsfJeueKHJ5M3lh
         phWbdClM2sMuMXVPGjA3McNc0DaTKmuNg5JQsWIuIrfE/2TE1aDPLx3hXcaML9u2LAHW
         q3Y6sm68MeACEzWkFMIvZlXYFzoZC/XrfoNyyf++19z93aLmt5eA7Fb/gp9JpSQaWsWq
         /LCR+nmAmjD5pLxeim5heDiSIXPFjqlOY4g6xyPIVgsyyaHRjwyvhm4qKpOAOyMhy69X
         vP7g==
X-Gm-Message-State: AOJu0Yy2IwoJsUcV4nCxyaG2mm2vvbagXQkbDgzdaIOyXKdqgm+qXqzX
	Up8eeGHuQbwY0nEEUawt/PB1q3PWS4qAZyRDo5JjtmQPcx84WCTP
X-Google-Smtp-Source: AGHT+IGyYktNV/M3RvbQ7wG6nr8zkWrrotQ7CFC3qg1f7N4asL7EEP6SFMJfkM0WgBOWrRvylwYGMg==
X-Received: by 2002:a17:902:d506:b0:1f9:b16d:f988 with SMTP id d9443c01a7336-1fadbc74952mr58592085ad.22.1719953040930;
        Tue, 02 Jul 2024 13:44:00 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535b94sm88718585ad.155.2024.07.02.13.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 13:44:00 -0700 (PDT)
Message-ID: <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for
 bpf_get_smp_processor_id()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com
Date: Tue, 02 Jul 2024 13:43:55 -0700
In-Reply-To: <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
References: <20240629094733.3863850-1-eddyz87@gmail.com>
	 <20240629094733.3863850-4-eddyz87@gmail.com>
	 <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-01 at 17:41 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -158,6 +158,7 @@ const struct bpf_func_proto bpf_get_smp_processor_i=
d_proto =3D {
> >         .func           =3D bpf_get_smp_processor_id,
> >         .gpl_only       =3D false,
> >         .ret_type       =3D RET_INTEGER,
> > +       .nocsr          =3D true,
>=20
> I'm wondering if we should call this flag in such a way that it's
> clear that this is more of an request, while the actual nocsr cleanup
> and stuff is done only if BPF verifier/BPF JIT support that for
> specific architecture/config/etc?

Can change to .allow_nocsr. On the other hand, can remove this flag
completely and rely on call_csr_mask().

[...]

> > @@ -16030,7 +16030,14 @@ static u8 get_helper_reg_mask(const struct bpf=
_func_proto *fn)
> >   */
> >  static bool verifier_inlines_helper_call(struct bpf_verifier_env *env,=
 s32 imm)
> >  {
> > -       return false;
> > +       switch (imm) {
> > +#ifdef CONFIG_X86_64
> > +       case BPF_FUNC_get_smp_processor_id:
> > +               return env->prog->jit_requested && bpf_jit_supports_per=
cpu_insn();
> > +#endif
>=20
> please see bpf_jit_inlines_helper_call(), arm64 and risc-v inline it
> in JIT, so we need to validate they don't assume any of R1-R5 register
> to be a scratch register

At the moment I return false for this archs.
Or do you suggest these to be added in the current patch-set?

[...]

