Return-Path: <bpf+bounces-20443-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA19183E7F3
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 01:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7208281E79
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A053A4;
	Sat, 27 Jan 2024 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fy91KDO7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8FD4A36
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313987; cv=none; b=WkyDQ05MsWZsB4ZB/n5K7CbmlXB3xSSO4QeSkpUkNZefZGxRRf7xN0iUOaRGZLJWFmiiVSFIlcbcJVpP+gNwLksZudrAKJkVCXSENIpN3W5LPxWYY0dUWuiVG+y6NOawZO1AONc79zdsLz4/cxVm5vsmF5nBGel8d6PdnNHWvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313987; c=relaxed/simple;
	bh=ShkpPUEdKHeCDAxBSVUfv5E8tNWw8EMNWbx0u1z73UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7rwiaYInjPYZLFUXbDFU9PHLPvGbsVNsUHySnCWUVbTvDwnuflDMGx+LP338K64Ro0DHnS4hXBmvxEFxts5Ymcp8ZJj+OGNkfsX8XUn/gO3Zb1lJFpByNlPkzYgiz+8QQGm4CSEzfg3gzs1iytqaAzWb3p78IQdfOK6sVrcT9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fy91KDO7; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb9d54575cso764579b6e.2
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 16:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706313985; x=1706918785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69eARAhf7XSl8uhhOiVc2FKT/NanPdSAP33hAWuDYoY=;
        b=Fy91KDO7rjX/TzvAWqlGM3sCl+5pHtIcryk1+pEZWYzY//P0Fi+w2fO9utQQux7cmj
         ANc3T/akozFIZNtjjADuBDm077BZqvHUrNQ+1/kKhnDe4Oo/tswz5ZY/HMvODhT5coCp
         8iQqtkdNCJKpLHPJmwrxEb7hqgvwYUBvAadZ3z97maByVo0xDsbCiTS59d0J928898kv
         ljYL9FdlX5RT39vVuPViFj0Ko+Qa2ZcQiyEPNd1lkl5mlY1Mk3aw/RzBGCXkwbXsvoJO
         ZEtkcITGLLtgO5hn2iNlDe1UFN6uxx/wicDJ6s5Ih8nD+uCidKXmC1InWUWLqhsWHH+n
         BhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706313985; x=1706918785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69eARAhf7XSl8uhhOiVc2FKT/NanPdSAP33hAWuDYoY=;
        b=aeGO2sDCCVFKbrd7YB3CFPWivbhp1zzEKKuS4QWUniy1qVtCccaaUSnDwgoNMHAqx3
         GJmgU4gVhbyLCY4ZVonuGhIWZDLqQZybayxLBRbk/h8eRxuUrrtIAylKcKD3L855ERh8
         +0U8VfvCItXxb7xuW/i6+Eiv4XlQonJyeI8M2GA1XspOB0Gax4NAwcYsAbSHxkuw/Wq3
         GHdnsO5brUN5eMg6E+LevmiJFA8iycab2ZBcu6M7g69Axxw8Vyk2tinDfAUm3DeUAW/B
         ow0nJLvsOQuyDUDnm0sLPE/82GjVyMVBpLK3aQN+nh36REiOUGRRsZu4soWkdpF5d7bY
         jFXg==
X-Gm-Message-State: AOJu0YyqmbLRBAx1+2woH+rG8T58yrr7dMxLBaqK1+3CqQzPowyU9K9D
	xdk5F7aEHy3vBzONxkn1sSJCtDmB6wYf4s0DIyhhnxYU49rn16py/WOaCHtMANckoOKfTN4jDEm
	IiM5nrfqGSGLog+xJREvXJMg9HBY=
X-Google-Smtp-Source: AGHT+IFq3lOBg6TRdru6iiLX0sH0VvLbNetUMf6+EWv8iVpHfCW90xU+AgBx78sMprSRr5z7gC34TTdYV9NJay/gCzo=
X-Received: by 2002:a05:6808:45:b0:3bd:ba60:d956 with SMTP id
 v5-20020a056808004500b003bdba60d956mr591748oic.37.1706313985112; Fri, 26 Jan
 2024 16:06:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122212217.1391878-1-thinker.li@gmail.com>
 <CAEf4BzbQJXGw3w0RnjuUg=RRMDE9jGgOYxVcA9q9hbYnvFBHhg@mail.gmail.com> <CAADnVQKx3RK8pK4xpNEPQKYGUemO0VjdRePdr34fJwHZs6Urag@mail.gmail.com>
In-Reply-To: <CAADnVQKx3RK8pK4xpNEPQKYGUemO0VjdRePdr34fJwHZs6Urag@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 16:06:13 -0800
Message-ID: <CAEf4Bzbg2PJ8uxLFRtMSASDB309KKMkRQyGywjf_XjYgwVT60w@mail.gmail.com>
Subject: Re: [RFC bpf-next v3] bpf, selftests/bpf: Support PTR_MAYBE_NULL for
 struct_ops arguments.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Dave Marchevsky <davemarchevsky@meta.com>, David Vernet <dvernet@meta.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 4:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jan 26, 2024 at 3:21=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jan 22, 2024 at 1:22=E2=80=AFPM <thinker.li@gmail.com> wrote:
> > >
> > > From: Kui-Feng Lee <thinker.li@gmail.com>
> > >
> > > Allow passing a null pointer to the operators provided by a struct_op=
s
> > > object. This is an RFC to collect feedbacks/opinions.
> > >
> > > The previous discussions against v1 came to the conclusion that the
> > > developer should did it in ".is_valid_access". However, recently, kCF=
I for
> > > struct_ops has been landed. We found it is possible to provide a gene=
ric
> > > way to annotate arguments by adding a suffix after argument names of =
stub
> > > functions. So, this RFC is resent to present the new idea.
> > >
> > > The function pointers that are passed to struct_ops operators (the fu=
nction
> > > pointers) are always considered reliable until now. They cannot be
> > > null. However, in certain scenarios, it should be possible to pass nu=
ll
> > > pointers to these operators. For instance, sched_ext may pass a null
> > > pointer in the struct task type to an operator that is provided by it=
s
> > > struct_ops objects.
> > >
> > > The proposed solution here is to add PTR_MAYBE_NULL annotations to
> > > arguments and create instances of struct bpf_ctx_arg_aux (arg_info) f=
or
> > > these arguments. These arg_infos will be installed at
> > > prog->aux->ctx_arg_info and will be checked by the BPF verifier when
> > > loading the programs. When a struct_ops program accesses arguments in=
 the
> > > ctx, the verifier will call btf_ctx_access() (through
> > > bpf_verifier_ops->is_valid_access) to verify the access. btf_ctx_acce=
ss()
> > > will check arg_info and use the information of the matched arg_info t=
o
> > > properly set reg_type.
> > >
> > > For nullable arguments, this patch sets an arg_info to label them wit=
h
> > > PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL. This enforces the verif=
ier to
> > > check programs and ensure that they properly check the pointer. The
> > > programs should check if the pointer is null before reading/writing t=
he
> > > pointed memory.
> > >
> > > The implementer of a struct_ops should annotate the arguments that ca=
n be
> > > null. The implementer should define a stub function (empty) as a
> > > placeholder for each defined operator. The name of a stub function sh=
ould
> > > be in the pattern "<st_op_type>_stub_<operator name>". For example, f=
or
> > > test_maybe_null of struct bpf_testmod_ops, it's stub function name sh=
ould
> > > be "bpf_testmod_ops_stub_test_maybe_null". You mark an argument nulla=
ble by
> > > suffixing the argument name with "__nullable" at the stub function.  =
Here
> > > is the example in bpf_testmod.c.
> > >
> > >   static int bpf_testmod_ops_stub_test_maybe_null(int dummy, struct
> > >                 task_struct *task__nullable)
> >
> > let's keep this consistent with __arg_nullable/__arg_maybe_null? ([0])
> > I'd very much prefer __arg_nullable and __nullable vs
> > __arg_maybe_null/__maybe_null, but Alexei didn't like the naming when
> > I posted v1.
>
> fwiw I'm aware that _Nullable is a standard and it's supported by clang,e=
tc.
> If folks insist on such suffix, I can live with that.
> But I absolutely don't want that to be a reason to rename
> PTR_MAYBE_NULL in the verifier.
> My preference is for consistency in the verifier and suffixes.
> Hence __maybe_null.
> But I'm ok if we do __nullable and keep PTR_MAYBE_NULL.

+1 for that. That is the internal name, and we also have an internal
xxx_OR_NULL convention. We don't need to change any of that, IMO.

