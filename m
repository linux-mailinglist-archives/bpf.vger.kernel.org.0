Return-Path: <bpf+bounces-71131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE1DBE50FB
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 20:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE8E19A80A6
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06229233711;
	Thu, 16 Oct 2025 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sit5thjS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D1234966
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639412; cv=none; b=Oj6kVpjAtfn2CqSBtgMCpDS15yltu/E8itzRuH1lb/osHEkFEg4bATvwHMVV0BCeD4pHm/hjajs6tKG/9LYHsPkrBz+T9cV0GMYdl9VfGSo4pV9r904e9q1m02dZJ4g3jW+ioJG8/ESj1yIUjqcCBqa5Kvr140LSCE+aK/+bgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639412; c=relaxed/simple;
	bh=aoax4UC32EpDmJkajFIfdAiZfcABPRqs395Ltiscm7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJhc9M9qqF+tC1J2D1jGIEm9m9JPQ/B2z6ZlFRUheA6xPougLYbb5GAeLD7r3Hn6beC6mpVq3efrkkjqLYWKhe94RtIj43/6PUUKe1U3N73azT8KUEgEiafmfsDiwVupTfQzFE+Uf9HmlPD9rMmus7kYQuFevPld863sSiGnYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sit5thjS; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63bbf5f77daso1151529d50.3
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 11:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760639409; x=1761244209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzhvXWtbCkYpovjzVNvs150bS4n9HsGkgAH9hJSW7LQ=;
        b=Sit5thjSmO1U4bJ10xzluPT41EwCXW3FGifmljjWGCvwmO8d20N1LxvilKkjzKvsxV
         ahCL+BT7ckaN2izuF6n0dEM38VUgm4cJofMQ3cJL8jXD9jaX5B8zOpIZXlMzGARQM7y1
         iN0skvz3KSm2VGyV6xptwZxfcmABYMjHYNN9IH13OWQuXQ2zs/US6Qz/zo/0b66A7oEk
         gNgETjz+fSjcrbU5Fsa7gBYY8NzsLp/6k2Zf5YpJSiXLmCtbMQqS1RKVUn9xEXIZu1TF
         2X3dHrU+OBv8eYGID3kUBUA8v24HE3pLLWbNYDWWyPKaWHPcePAZKrcfSeElA3avNSdT
         57sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639409; x=1761244209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzhvXWtbCkYpovjzVNvs150bS4n9HsGkgAH9hJSW7LQ=;
        b=FSID9Ku0XQsAs4X1HB+5Uswl7GHzx0K5hSXKD6H36NexkULZwNOLgSdHMaImEhhy3H
         2xM45OK+Ri733WLBuONespHwpgWiq8sydTX5ECw2DrfM7WjJJ/v5RN7hMEo2th0sNCof
         kWhNLPB5NxkIDbPc2QE1RrgX4xKTMoh9SqPnDQJ6jTzWPTkPWi/M8XV2z1Es+JTK59si
         aMu7WEZ+EiOg0mJDCT8p576+pGIjDMCV8893751YqAwnd6sMiPux0+lBlxYSgPkQjAZq
         N5TqprCtNXiLNr4NLXUXN9wsRoKhd1K3ZukGSL8KQoAyROwTnSsm2wCW2Gc+Lx2IqBq+
         gzBQ==
X-Gm-Message-State: AOJu0YxjWQbghqMmzYQuDAeRfB4dgFd9BL47D3Xxau1KYMM6blrQhvoO
	/NgB0WJhWLbTFCd83NI+qnBdcnQlVAaCUPqcFRQqXq92N8DjY6okPIbtJ8X9nMmC5Ym4XU1UGdD
	nQoMNYHvQw11UQSNXF2mMAv8ujjgH/20=
X-Gm-Gg: ASbGncuW/7EPxGawqu8UM3hW44eE9Yz9KtzGxHln/ISxfEeLKXd/B40mBb6HkwEM8G0
	1nMggBinguNHKixMX2bPveR3I/8mD650Hz8SWdU1lkKtZopKMTpKhrx3Qults9GGfxmPXH4NvO4
	mDFBE631bNvpWXDExSdVv3SB3XYNJj0AXDl2H5924Bcsc9ZZuspetVzW/b1IPUC09NfpmpdALH1
	vA5hR7o5xqvhsgl6d/wFG7FQR3IOlyJOTXFhjx7nizDzoQoulnVqzXJyyY5G7Gxovaz7bg/f8RP
X-Google-Smtp-Source: AGHT+IH5oYT7ZLsH92Av5P9LlyrU53o8Cq9r2MjhjHiVkdNYfVY0oTjYKYqTmPtuvjEP+G86Xw9uVl7UKdVpAB7E6/4=
X-Received: by 2002:a53:5009:0:b0:63c:f5a7:3cc with SMTP id
 956f58d0204a3-63e161c6038mr864495d50.56.1760639408856; Thu, 16 Oct 2025
 11:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010174953.2884682-1-ameryhung@gmail.com> <20251010174953.2884682-2-ameryhung@gmail.com>
 <CAEf4Bzaqw2N58jCiApr6awfpub_8W6cTJMWuY75VpCCLMLjQBw@mail.gmail.com>
In-Reply-To: <CAEf4Bzaqw2N58jCiApr6awfpub_8W6cTJMWuY75VpCCLMLjQBw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 16 Oct 2025 11:29:57 -0700
X-Gm-Features: AS18NWCyZNZY1peWt4dmB31LMm4bdohA-ZAwwaH9Ng3BNMDyLMDDRgFLI7uyxQI
Message-ID: <CAMB2axOQqgpiUTb-33uOgYar48PM=DTeOFAZY3P3FYk16Dy33Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 bpf-next 1/4] bpf: Allow verifier to fixup kernel
 module kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 5:11=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Oct 10, 2025 at 10:49=E2=80=AFAM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > Allow verifier to fixup kfuncs in kernel module to support kfuncs with
> > __prog arguments. Currently, special kfuncs and kfuncs with __prog
> > arguments are kernel kfuncs. As there is no safety reason that prevents
> > a kernel module kfunc from accessing prog->aux, allow it by removing th=
e
> > kernel BTF check.
>
> I'd just clarify that this should be fine and shouldn't confuse all
> those desc->func_id comparisons because BTF IDs in module BTF are
> always greater than any of vmlinux BTF ID due to split BTF setup.

Got it. I will make the commit message less confusing.

>
>
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e892df386eed..d5f1046d08b7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -21889,8 +21889,7 @@ static int fixup_kfunc_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn,
> >
> >         if (!bpf_jit_supports_far_kfunc_call())
> >                 insn->imm =3D BPF_CALL_IMM(desc->addr);
> > -       if (insn->off)
> > -               return 0;
> > +
> >         if (desc->func_id =3D=3D special_kfunc_list[KF_bpf_obj_new_impl=
] ||
> >             desc->func_id =3D=3D special_kfunc_list[KF_bpf_percpu_obj_n=
ew_impl]) {
> >                 struct btf_struct_meta *kptr_struct_meta =3D env->insn_=
aux_data[insn_idx].kptr_struct_meta;
> > --
> > 2.47.3
> >

