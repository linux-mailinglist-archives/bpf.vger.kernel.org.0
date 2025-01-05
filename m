Return-Path: <bpf+bounces-47885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6460EA01779
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 01:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A673118837EA
	for <lists+bpf@lfdr.de>; Sun,  5 Jan 2025 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2EF17E0;
	Sun,  5 Jan 2025 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgq9RMVN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0B191
	for <bpf@vger.kernel.org>; Sun,  5 Jan 2025 00:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736035920; cv=none; b=J94gp9aARhuFMnW4fv6KTWYUUWve38v+/x3ewUDLOEnZ94MhWyPYTEm7//4K6mcYqa6qFtcdM4fSPhy0tXZmLe7VEZUaVqk9WptVSgmOl8YmU09dTECzaCqSmt6AUSG3qOWmldKqROZ8XblS+RwO9TPSG8dfhvRCQpTeKIk734g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736035920; c=relaxed/simple;
	bh=yJeHHFGuqdSbh78GyKlK86nuCSOvOu/2kdEk6ClGqz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A4h7qWy244279VYEy93nUGXmR47HdH0bgKV3tovPtRnjWXmwLPyxMgV+6ahtM7deCWXTwZnlSwZuaB2WUC97eyzraA4MFRmlGGfW2oY7FwVoWGUqZUU0EIB/DPiCWAKVAM6itas04z57Ok6sX25zHL511zm5SevwwjeOmP+YIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dgq9RMVN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2166f1e589cso228948315ad.3
        for <bpf@vger.kernel.org>; Sat, 04 Jan 2025 16:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736035919; x=1736640719; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CUb0iAhCaTQveFByz5DjWAxnukdgKWyUzekHKwA1RQc=;
        b=Dgq9RMVN/ZPT4rYZZLzOnFwcXT6W+ebmgA1w8AMXdCiFJ1eAW5iHeIAj9ioKqOlWyA
         Fb7Vxa1QzOSsUHU7ZY4jjx2Oyig2e7jNfRPDUpjAvi0/KM+L7LT7d4dbl+cWmaBoeApY
         Gvx9yjbAoDazxhSGcevCiLZbhVSPYANMMXRnUpKJThGPNU4jIlf23pm8QPfA1kjeRqa9
         nvIZgDUSI48Cx+aRhc+agEgB50yqKMaSho+vAbc5+Ai2pR2JEL2Z4SP+ys/IHZMV4QJG
         VyevemyD4OKvyJtL2edRTIKOMVTFnGPEneghLl507A8ay0C1Qtd0+pMTmCyF+rvUmPF1
         eBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736035919; x=1736640719;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUb0iAhCaTQveFByz5DjWAxnukdgKWyUzekHKwA1RQc=;
        b=qODeWctK4jMXqK47fwo2DpZUegbZ2vx2xSAk1a8uOUIjQ/J9yr/8IkUPmO496OXwo2
         +A+xKsFZDbraBjwFsLZ6tl8zwDQMNVUbFm9F5IJV3VBt7JMwRKPJjV22qOIcgxB13XbR
         Fcl5DRgdBsKmePBdW/hS1EYX2z7pe9UC6enGUlOSg1yqwrluSMDUbv347jdue12ogfyA
         C2E+aYS0UZjUae6L1YNGEkUADXrGEUrmWJnQeqC9iqLAIJNu+n3hdDimrpc2J19W4nFu
         ejnvlwDOhDckFK+CVHpPnWCj4ed+mKmyHe2Qx0nXwhdFoH2AVQYAhOaPzpPzzUOuoUzy
         h6bg==
X-Gm-Message-State: AOJu0Yz+yF3UX8umAE+toPNkV5TxqZSyNyQaeoB8fWJGCXexOS0V0I8w
	H6f4grQ79dgXg7PvXaseDXfl4Ap0U/zMRHQh0joImdPJBQYKIQNKFNt37Q==
X-Gm-Gg: ASbGncs/LEcBKtIhZ2eAMf7wk07EkvutmjEiYErjVPDOXHAWFL9+9AtdANZiHs5Ofnh
	J9z55u0EM927WVZb8rMOQubRalGbNWr8nSCJhhDnt/aY/XVTXfbg8EMBA/9K8FDhlKoHl8E9DOH
	Px3ESS1vBInhYvaJtPFq05GDHO3kfK9Jmb5Hdr2tK5b0NFdTtisOSNp3D8u6ylFNMnmMEffuVMU
	xwV5SxJIdh88ihxGRFQ0Vc+yEhm5LP6Iz18eERqZL3Y9TBwgHkBWw==
X-Google-Smtp-Source: AGHT+IHFWm27CD+h6tyb7NFiGze0fnvBOclzVqD9vYxdIUKrlLuj+Es/8PnWGY0V4m0m7Ow/p1Pwvw==
X-Received: by 2002:a17:902:ecca:b0:215:a18f:88a8 with SMTP id d9443c01a7336-219e6f38a1amr647971615ad.51.1736035918655;
        Sat, 04 Jan 2025 16:11:58 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02b77sm266868075ad.242.2025.01.04.16.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 16:11:57 -0800 (PST)
Message-ID: <fbc6c684c4d374a3b7b08198bf4778c05963a313.camel@gmail.com>
Subject: Re: [PATCH 1/2] bpf: Allow bpf_for/bpf_repeat calls while holding a
 spinlock
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Date: Sat, 04 Jan 2025 16:11:53 -0800
In-Reply-To: <CABFh=a66Fk70ipHbrq+Jh-hA33vHq0fOJd+R9=1tRA1t212CzQ@mail.gmail.com>
References: <20250101203731.1651981-1-emil@etsalapatis.com>
	 <20250101203731.1651981-2-emil@etsalapatis.com>
	 <ac3eda5992a9fbee296abcbc917d5521da0be83c.camel@gmail.com>
	 <CABFh=a66Fk70ipHbrq+Jh-hA33vHq0fOJd+R9=1tRA1t212CzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-01-04 at 14:25 -0500, Emil Tsalapatis wrote:

[...]

> > > @@ -19048,7 +19066,7 @@ static int do_check(struct bpf_verifier_env *=
env)
> > >                               if (env->cur_state->active_locks) {
> > >                                       if ((insn->src_reg =3D=3D BPF_R=
EG_0 && insn->imm !=3D BPF_FUNC_spin_unlock) ||
> > >                                           (insn->src_reg =3D=3D BPF_P=
SEUDO_KFUNC_CALL &&
> > > -                                          (insn->off !=3D 0 || !is_b=
pf_graph_api_kfunc(insn->imm)))) {
> > > +                                          (insn->off !=3D 0 || !kfun=
c_spin_allowed(insn->imm)))) {
> > >                                               verbose(env, "function =
calls are not allowed while holding a lock\n");
> > >                                               return -EINVAL;
> > >                                       }
> >=20
> >=20
> > Nit: technically, 'bpf_loop' is a helper function independent of iter_n=
um API.
> >      I suggest to change the name to is_bpf_iter_num_api_kfunc.
> >      Also, if we decide that loops are ok with spin locks,
> >      the condition above should be adjusted to allow calls to bpf_loop,
> >      e.g. to make the following test work:
> >=20
>=20
> (Sorry for the duplicate, accidentally didn't send the email in plaintext=
)
>=20
> Will do, bpf_iter_num_api_kfunc is more reasonable. For bpf_loops
> AFAICT we would need to ensure the callback cannot sleep,
> which would need extra checks/changes to the verifier compared to
> bpf_for. IMO we can deal with it in a separate patch if we think
> allowing it is a good idea.

Not really, callbacks are verified "in-line". When a function call to
a function calling synchronous callback is verified, verifier steps
into callback body some number of times. If a sleeping call would
be discovered during callback function verification, verifier would
see that spin lock is currently taken and report error. So, this is
really just a check for particular helper call.

[...]


