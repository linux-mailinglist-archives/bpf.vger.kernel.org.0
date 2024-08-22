Return-Path: <bpf+bounces-37797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B895A8E5
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 02:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A9F1F21AC7
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 00:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A901749C;
	Thu, 22 Aug 2024 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naY6ApJS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB696FCC
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 00:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286645; cv=none; b=JUrGDoDu1ta5O2nf5bCv+j06bWAQQ0DiaRWzmrYgWicbL0scWGntAsSqDuFUySxJDvNsEDbxu00sIZ+WWeoQDODX0OpJvSGD7bsslC/wPxsLaJYWmxnI7htNzk7WnWxiB2pBLwgLNzIBVzz0d35x5pH+unOFFvazUwKWD8BDHsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286645; c=relaxed/simple;
	bh=GmfoatDiwIvmr9GzbHQGtviyO1PB0z1FiIoN386/ABs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TBaJlATODJR0hRIyxbpFuEmJHH8WQI5UsgOu0vIoCs7XosRNLUx9KuZ64r7gJHPwUXpq6utZFSniuLG721BcgfGis7YKwHG6kW1hjVRdPbr+qWHedtL6jpcRlS49WtF5j+rYEb7NXoQlXIaDex6G0AfNH2ptQAotvvwyW38tJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naY6ApJS; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-70b2421471aso182665a12.0
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 17:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286644; x=1724891444; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IjDQHZisvOw1DPGAPWB2hPoyszjA/LZzhcVrYr68J8A=;
        b=naY6ApJSTSoTM/5sQzLM2qOFR1bfH2Wadqq8P971iRbbxgEDgHaZ8PaxYg4nWlDpgj
         dRMX1gr2JgUY9nrJLHJQS5bRSMOh59lj8uo4Qz4gPKOcElqCwIKZh8Z9wOTRIHdYx/Vv
         cMBAqxn8dmUhYciYV7lzdEQU/fzIAcQusxnGwoFyMoGctU13ysTvWP2iI1sDtc5g+Cds
         BGFUeMs17R4TnBH+F2UKm187mKzKGAokbl8zzsme3+QJ0COwtJRKBi+NyrEftsIHyVYS
         2QRGhHbHFA3WM8xVrW8RPhqkWZW2bTNYxNQXAst50WvtrHIm48M74/DzAmFhT7HC/hF+
         flxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286644; x=1724891444;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IjDQHZisvOw1DPGAPWB2hPoyszjA/LZzhcVrYr68J8A=;
        b=Hc44ULfSlZZiTXL5uXQfAjh5FVVqazdOBxtiZFyV53VsflJtMDjXj4Eaw67eZM9WGU
         4QyZuaZ71xOyY8duEtFG84lOl75JuZhQOi42TUnIq1BWrvT1CL35o5oPLGEh+j1sYwZj
         UV0J7kfZ4eDCIJoLbEZol2ynWPcko+T4kRB84rrasjP2HzyhM3/lpkTs+jzOCxKhppJi
         UpoXBuWgionsvri+OvD+NZcoVi5lCt1mnGwOqrgggH46XWtsvEndc9s87JfFfn2Xc/JW
         N1Ra+rVtiD6ttNR6LfzrQzOXi+6L1A5onfKQcGrHDpmj+pwrncxk0bsz9QsIi+3DtdgS
         9HOw==
X-Gm-Message-State: AOJu0YwcM9hyDEsqp08yjCWZLrOCg/SniT542rh2ZshroZcqMzNbR2VJ
	e35CHNC9K2wa/9bbdHthMJlhE4vMeuYhSqv4pU4k0cifxvHAsChn
X-Google-Smtp-Source: AGHT+IH+nFUms4E+NXLlUuYzwTWhZsEG0u6SrD/GDMFZFDq+Yy1xlxlp6fP805fld4IHsMdXuSz4tg==
X-Received: by 2002:a05:6a20:6f02:b0:1c4:bbb8:5050 with SMTP id adf61e73a8af0-1caeb30cb70mr284956637.37.1724286643533;
        Wed, 21 Aug 2024 17:30:43 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143679cd7asm83816b3a.112.2024.08.21.17.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:30:42 -0700 (PDT)
Message-ID: <958b4d92363729f1bed444bc1f4a7d58a54275b1.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/8] bpf: Add gen_epilogue to
 bpf_verifier_ops
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Martin KaFai Lau
	 <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 Kernel Team <kernel-team@meta.com>
Date: Wed, 21 Aug 2024 17:30:37 -0700
In-Reply-To: <CAADnVQKgT_vJJfOnFdTa6Gpf8s+_D79DwtT8pNzxfw2H4aq1Fg@mail.gmail.com>
References: <20240821233440.1855263-1-martin.lau@linux.dev>
	 <20240821233440.1855263-2-martin.lau@linux.dev>
	 <CAADnVQKgT_vJJfOnFdTa6Gpf8s+_D79DwtT8pNzxfw2H4aq1Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 17:22 -0700, Alexei Starovoitov wrote:

[...]

> > +       if (ops->gen_epilogue) {
> > +               epilogue_cnt =3D ops->gen_epilogue(epilogue_buf, env->p=
rog,
> > +                                                -(subprogs[0].stack_de=
pth + 8));
> > +               if (epilogue_cnt >=3D ARRAY_SIZE(epilogue_buf)) {
> > +                       verbose(env, "bpf verifier is misconfigured\n")=
;
> > +                       return -EINVAL;
> > +               } else if (epilogue_cnt) {
> > +                       /* Save the ARG_PTR_TO_CTX for the epilogue to =
use */
> > +                       cnt =3D 0;
> > +                       subprogs[0].stack_depth +=3D 8;
> > +                       insn_buf[cnt++] =3D BPF_STX_MEM(BPF_DW, BPF_REG=
_FP, BPF_REG_1,
> > +                                                     -subprogs[0].stac=
k_depth);
> > +                       insn_buf[cnt++] =3D env->prog->insnsi[0];
> > +                       new_prog =3D bpf_patch_insn_data(env, 0, insn_b=
uf, cnt);
> > +                       if (!new_prog)
> > +                               return -ENOMEM;
> > +                       env->prog =3D new_prog;
> > +                       delta +=3D cnt - 1;
>=20
> I suspect this is buggy.
> See commit 5337ac4c9b80 ("bpf: Fix the corner case with may_goto and
> jump to the 1st insn.")

Actually, I was unable to figure out a counter example for this case,
patching math seems to be correct, jump targets are just moved down.
But let's see, maybe Martin can come up with something.

[...]


