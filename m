Return-Path: <bpf+bounces-18777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817A82202F
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 18:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F7BB22426
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAAF156E0;
	Tue,  2 Jan 2024 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUdGPUGJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6F15AEA
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7d6565b5so6635936e87.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 09:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704215494; x=1704820294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaPQSrVpzgR6YH1aJItD4+rrpzN7x8UlcWikBN5njlE=;
        b=IUdGPUGJpD38VA7VfKCSomcdcrLIKSKpJGK5TsQig6MRTP3+wMw8gizweNRHYX2lEf
         qz41BZSRiGa6JZDIH8tGC1ydJWdW3wL6rVkL4doSFyQ95+DCdwSFUg8GaBuc7DbMBIi9
         0st0cLOUE87s/03fE1Wh8V27cexuD9ntNzFA1hQu80Ws2mxiYS+nlK655NLAbwZFZFpI
         2byGmXYGFqLTARsLyZKZ9iadW2os2+oEHGvlYD8ERdJRnCuR7L/O/Gv/SgRU53jQgvbJ
         tYCgQCo8qfyRj54xLdBiD2cNo+O/tfyfOOrgohraUdAPEQesXZekF3qB1GaOip8x66RD
         ZXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704215494; x=1704820294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaPQSrVpzgR6YH1aJItD4+rrpzN7x8UlcWikBN5njlE=;
        b=ai+1KLMGGCjRE3RAwfoNbRiLABUwbcDG+6RgmezxDte7/EHiZaR02Hv3kv7xE+bQTN
         9GoxnM/WosCrbSNxSlq+Ea916oA8m3iTxlYlbg4Rc1oJP4uEUvCa6WQ+c2qtkG49wcmu
         2r98UPQJC8sWnk06ZsBdxavqzhZE6ZDwYlCU4acHb+05/56JRJ6mLvwVH+zYQSrN/Y7O
         YXv5GV3kOU5NUQPkGFdSA54bHbkD8Sb20sSJCOjcla1pQVUdGIxVUIE8At4pnYjs0Ux0
         qiUmjJfEpnJSBBksy1FixpZUVmWbbdJwL92d5Mgnq1AnBvxwTK+rjJzTeKaQinKXwUDz
         dCkw==
X-Gm-Message-State: AOJu0YzlUuH77qlpziTBSg6anQBOwWfj8Pkdxus6Sg1pKqTeLniL4keI
	C8KxFbDiUMR8lsa3yflr7rK/f+g/t7TpyTbE3Dc=
X-Google-Smtp-Source: AGHT+IGWk/PQqlGfVazlOOzymSfmvY3pM5SxKkutJ5h7W5a1GgZSI6gFRXxcPdiWewUTsQQos+ZhlqYYTPt8F06We4o=
X-Received: by 2002:ac2:5feb:0:b0:50e:35ef:681f with SMTP id
 s11-20020ac25feb000000b0050e35ef681fmr6473179lfg.139.1704215493410; Tue, 02
 Jan 2024 09:11:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220233127.1990417-1-andrii@kernel.org> <20231220233127.1990417-8-andrii@kernel.org>
 <ZYWL3UNIB2sJ3HmQ@krava>
In-Reply-To: <ZYWL3UNIB2sJ3HmQ@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jan 2024 09:11:21 -0800
Message-ID: <CAEf4BzbS2ZEpPedq-CmLG6f-qAwrKQpR2dc9L_s3m_QUxUwVug@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] libbpf: implement __arg_ctx fallback logic
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 5:15=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Dec 20, 2023 at 03:31:26PM -0800, Andrii Nakryiko wrote:
> > Out of all special global func arg tag annotations, __arg_ctx is
> > practically is the most immediately useful and most critical to have
> > working across multitude kernel version, if possible. This would allow
> > end users to write much simpler code if __arg_ctx semantics worked for
> > older kernels that don't natively understand btf_decl_tag("arg:ctx") in
> > verifier logic.
>
> curious what's the workaround now.. having separate function for each
> program type instead of just one global function? I wonder ebpf/cilium
> library could do the same thing

You mean what users do today? Something like this:

/* static, so types don't matter */

static int common_logic(void *ctx, ...) { ... }

/* global */ int kprobe_logic(struct bpf_user_pt_regs_t *ctx)
{
    return common_logic(ctx);
}

/* global */ int perf_event_logic(struct bpf_perf_event_data *ctx)
{
    return common_logic(ctx);
}

And so on. So it's not great, but it works.

The problem arises when you have nested global functions that need to
pass context.


/* global */ int kprobe_logic_1(struct bpf_user_pt_regs_t *ctx)
{
    ...
}

/* global */ int kprobe_logic_2(struct bpf_user_pt_regs_t *ctx)
{
    int x;

    x =3D kprobe_logic_1(ctx);
    ...
}


With this nesting of global funcs the above trick doesn't work anymore
because common_logic() can't call per-program global function anymore.

>
> whole patchset lgtm:
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>

Thanks!


> jirka
>
> >
> > Luckily, it is possible to ensure __arg_ctx works on old kernels throug=
h
> > a bit of extra work done by libbpf, at least in a lot of common cases.
> >
> > To explain the overall idea, we need to go back at how context argument
> > was supported in global funcs before __arg_ctx support was added. This
> > was done based on special struct name checks in kernel. E.g., for
> > BPF_PROG_TYPE_PERF_EVENT the expectation is that argument type `struct
> > bpf_perf_event_data *` mark that argument as PTR_TO_CTX. This is all
> > good as long as global function is used from the same BPF program types
> > only, which is often not the case. If the same subprog has to be called
> > from, say, kprobe and perf_event program types, there is no single
> > definition that would satisfy BPF verifier. Subprog will have context
> > argument either for kprobe (if using bpf_user_pt_regs_t struct name) or
> > perf_event (with bpf_perf_event_data struct name), but not both.
> >
> > This limitation was the reason to add btf_decl_tag("arg:ctx"), making
> > the actual argument type not important, so that user can just define
> > "generic" signature:
> >
> >   __noinline int global_subprog(void *ctx __arg_ctx) { ... }
> >
> > I won't belabor how libbpf is implementing subprograms, see a huge
> > comment next to bpf_object__relocate_calls() function. The idea is that
> > each main/entry BPF program gets its own copy of global_subprog's code
> > appended.
> >
> > This per-program copy of global subprog code *and* associated func_info
> > .BTF.ext information, pointing to FUNC -> FUNC_PROTO BTF type chain
> > allows libbpf to simulate __arg_ctx behavior transparently, even if the
> > kernel doesn't yet support __arg_ctx annotation natively.
> >
> > The idea is straightforward: each time we append global subprog's code
> > and func_info information, we adjust its FUNC -> FUNC_PROTO type
> > information, if necessary (that is, libbpf can detect the presence of
> > btf_decl_tag("arg:ctx") just like BPF verifier would do it).
> >
> > The rest is just mechanical and somewhat painful BTF manipulation code.
> > It's painful because we need to clone FUNC -> FUNC_PROTO, instead of
> > reusing it, as same FUNC -> FUNC_PROTO chain might be used by another
> > main BPF program within the same BPF object, so we can't just modify it
> > in-place (and cloning BTF types within the same struct btf object is
> > painful due to constant memory invalidation, see comments in code).
> > Uploaded BPF object's BTF information has to work for all BPF
> > programs at the same time.
> >
> > Once we have FUNC -> FUNC_PROTO clones, we make sure that instead of
> > using some `void *ctx` parameter definition, we have an expected `struc=
t
> > bpf_perf_event_data *ctx` definition (as far as BPF verifier and kernel
> > is concerned), which will mark it as context for BPF verifier. Same
> > global subprog relocated and copied into another main BPF program will
> > get different type information according to main program's type. It all
> > works out in the end in a completely transparent way for end user.
> >
> > Libbpf maintains internal program type -> expected context struct name
> > mapping internally. Note, not all BPF program types have named context
> > struct, so this approach won't work for such programs (just like it
> > didn't before __arg_ctx). So native __arg_ctx is still important to hav=
e
> > in kernel to have generic context support across all BPF program types.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 239 +++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 231 insertions(+), 8 deletions(-)
> >

please trim

[...]

