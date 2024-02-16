Return-Path: <bpf+bounces-22185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E2785883B
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 22:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D0FB210A4
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 21:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1BE14601E;
	Fri, 16 Feb 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImVnGyrv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC11353E4
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120246; cv=none; b=hoIP4d4Zn8JKWlZzzo7PxR/G80laq5bcz4aBX6twzALeclU4hFOjfezfE0FvOQWpfSuLcDxnNXF0C1GWiZUi/Ln/jiLwI7CdFdtIQ8pSmvXfk0SJ/bMumFXzcgNt6Oe9KOLFFTuXG/pUoFCTqvygnWeNE56ZsDxZGu2cEHqIgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120246; c=relaxed/simple;
	bh=8Zulg1BPHiGqli3MCyDauYZKh2zU86xEWY9Q85I3nQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o69j0QhuHvV4jksfCgrDIhrVi9LGIgY6KQnBv2EiCjYBX4+zB5x0L0pKIFUIQtR/uBRn2RDJSg5y++Cs954xYwtmMVcqipUdflI0mVtOGOTW+iiaKmHXDRaF4+CAFZQ9KOTCjXsPVKvCRNbik4I6AaGYNF0ShYWJNU24dsaHGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImVnGyrv; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a3d159220c7so173307866b.2
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 13:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708120243; x=1708725043; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=huUScqJvOqHGVHhhkDMWxf4uAuGRjwD3XzXY2vWlgVw=;
        b=ImVnGyrvuP6d0Zq5A1hBUfuuPoIcXIP/2Su34brVaV5823A0eycGvXoKe25mqB2+Sa
         CEmjNOITbHKdg/A5ZS0a8abIDHyudl16mgLmd1OR9r+yDyQEM1dBF/UrFl+ttATKqlic
         vyFQi5yXtaUyz6VBuoZF+xDsPAuKeVJMl1cXIYXkW7s/fZ5ZnYXdtHHmTdfuVDaz1PLT
         FVRtt+3kLXnBMbJrQlpwRurkfA/MdP0mAWkp3sCB5o70z5LjWc5p4aHcFlurB6nNht0a
         4hh1rvTaiBV2zrjW18VVbl0h44TyvPxq6+75BdHbZNwQsAWOCHbu3d7IrT0NFIophvsF
         J3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708120243; x=1708725043;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huUScqJvOqHGVHhhkDMWxf4uAuGRjwD3XzXY2vWlgVw=;
        b=bxqP4D1CBxJH4zfz0T9ZkJloXiJpSE+pLU/JQP7rhYjP5lP4x5qlIIH/o3h8U7DXKi
         CxXG9uBC2qF32StfZHPumyNop/hydx26t9xDwScLxI8xi+D3fKE6q+OgB2xnpCo84niN
         QeDZ0w0nrif2fWS62KCDM/gR3jV3lUWNqLtelku+c2UPu//IA/KW094KFpKuUevcxkec
         V2HHtBEhfAGtFJev6aTHxr/IOAl1dOtbSnyi7D4ch2vaE/DfvikZ6wKbz2DVdiV6MvVX
         jAPxIzMCo0dz2RGeVl3KYpiBJs/YX0HN2+G+0bq1+qEWA002Y39cenLKS3qQlAfD1T3q
         1v6w==
X-Gm-Message-State: AOJu0YyhUDvuEnUembIcxDykIptWgSxIw4o7TI8DtKyU1MA343xLupXr
	OZCrHoqTNK/K0mr272v9IBw2ZRCF+FubkxzdJk78bLDPJq1RlB2jPDbRG93+fiXMWh2PlrWeq+D
	OUndEHc55wqx2I2QLpgaKCXHimEUoddyQCn0=
X-Google-Smtp-Source: AGHT+IFPyqpf/oj3325biavALEaImLaLleLLmZsmIuWcGxEV+vyo1zMpHENoxZ5mHRJM81+AMRvj4zAAaMiN81ChZlk=
X-Received: by 2002:a17:906:2791:b0:a3d:b150:2145 with SMTP id
 j17-20020a170906279100b00a3db1502145mr3371749ejc.40.1708120242912; Fri, 16
 Feb 2024 13:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-3-memxor@gmail.com>
 <6bfdc890c49fe4836aa18dcd509c9d3ecc05e26f.camel@gmail.com>
In-Reply-To: <6bfdc890c49fe4836aa18dcd509c9d3ecc05e26f.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Feb 2024 22:50:06 +0100
Message-ID: <CAP01T75=3uN0N5gi+4n93aePdEtQNVZcxuvzMpTSaJbiZBDT0w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 02/14] bpf: Process global subprog's exception propagation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 02:10, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-02-01 at 04:20 +0000, Kumar Kartikeya Dwivedi wrote:
> > Global subprogs are not descended during symbolic execution, but we
> > summarized whether they can throw an exception (reachable from another
> > exception throwing subprog) in mark_exception_reachable_subprogs added
> > by the previous patch.
>
> [...]
>
> > Fixes: f18b03fabaa9 ("bpf: Implement BPF exceptions")
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Also, did you consider global subprograms that always throw?
> E.g. do some logging and unconditionally call bpf_throw().
>

I have an example for that in the exception test suite, but I will add
a test for that with lingering references around.

> [...]
>
> > @@ -9505,6 +9515,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >               mark_reg_unknown(env, caller->regs, BPF_REG_0);
> >               caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
> >
> > +             if (env->cur_state->global_subprog_call_exception)
> > +                     verbose(env, "Func#%d ('%s') may throw exception, exploring program path where exception is thrown\n",
> > +                             subprog, sub_name);
>
> Nit: Maybe move this log entry to do_check?
>      It would be printed right before returning to do_check() anyways.
>      Maybe add a log level check?
>

Hmm, true. I was actually even considering whether all frame_desc logs
should also be LOG_LEVEL2?

> >               /* continue with next insn after call */
> >               return 0;
> >       }
>
> [...]

