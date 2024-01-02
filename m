Return-Path: <bpf+bounces-18776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABC0821FF1
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 18:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CED1F21B81
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B12154A1;
	Tue,  2 Jan 2024 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXOwMHbU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EB15481
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a27cc46d40bso243715066b.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 09:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704215206; x=1704820006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f438ZfkTtGo2xZkixTD8AVH0HhSnqcyNwfRA7DGfpEk=;
        b=MXOwMHbUE5HYMmQif/1UaXkQF9FaBev0QLLoF3IrPQF8g+dE961uVMT8S+tkuYDIFR
         huKjlsOV/a7lTF6HHA4hkqv5tn5UIq0vf6K7mFHsHA9kV5rrTnnCsGQRU5IBIu9mJoIA
         eKBFUupvPASlJFkc554+opRsDYaoMgCaUCNjZZi6/zHATQiHAAoYpDZ1daEME3ruR/gJ
         S9mf1B/2RdPaLOphxgOV8+0sLTbXwFIu2n227rVEWUBZWbi7bV3FHhM9PEKwqrzIFy3x
         ckaFzwz5fwD5TH6B6S4AU9dcW9b10vIHiPmiyHS06LIIviXOCTAwEXfSJJc64haYKfe8
         /MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704215206; x=1704820006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f438ZfkTtGo2xZkixTD8AVH0HhSnqcyNwfRA7DGfpEk=;
        b=gLTnMI04SIOBsj2rQyjmeHpT6x+xCV5KGV2Zw/S0Nd1mSCiO2NGHQo+na/ZaM32Soy
         ZPtba4g51o1UXsHKHBUGCAdoE3JIlKf14E0ax1NsSsGxYOzIYSPaU5r3b6AOHN1Qejzu
         7C9oGJtPplWRvgz61XbUvO/ECnu88z5OpJLTIiUhsdwnlTyQyGCPtlT1/QIMdKPPEwiV
         o2QsYDDvOS0ZfBUpvfPU5lFF9W4zPWC5gD3uegV3oZXs7Jyh/1U2WJMdSPDtCMzkJcLa
         8PH8xy0gFD196PbjjKkMh4EZvUc3TVSN8p9T1t9FzqhzX7DkpBhdpa0VoeghDh2SJRSw
         Er/w==
X-Gm-Message-State: AOJu0Ywc5PWKTtQjqQM8oI+cvfmxSA+sOVtad8sVu1sfl8XrQKbKAJgW
	KWNJ2lCJsVSBnpQ6zMAcOXfrBrVYvXS1BTjcHh8=
X-Google-Smtp-Source: AGHT+IEHXTGId2w8/CiTlmjZbHnN6sQTHf+nzxIk41zY5LdiIPsBJ7t4kIGROa24gOsTvhisfmjGxxCUsBUMEBf2S6Q=
X-Received: by 2002:a17:906:d0c1:b0:a23:22a3:9fea with SMTP id
 bq1-20020a170906d0c100b00a2322a39feamr5238892ejb.81.1704215205768; Tue, 02
 Jan 2024 09:06:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220233127.1990417-1-andrii@kernel.org> <20231220233127.1990417-8-andrii@kernel.org>
 <aa5oh3hr4hbq6uk5ejmazunhv4scr6fbmzuxqibilucwprhidy@wsmnjikxm6vu>
In-Reply-To: <aa5oh3hr4hbq6uk5ejmazunhv4scr6fbmzuxqibilucwprhidy@wsmnjikxm6vu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jan 2024 09:06:33 -0800
Message-ID: <CAEf4BzYHrdeGHYuNgiyVUCB3K1RJ6TS3qb_U2tx7i2Sn3W6Etg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] libbpf: implement __arg_ctx fallback logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 5:26=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 20, 2023 at 03:31:26PM -0800, Andrii Nakryiko wrote:
> > This limitation was the reason to add btf_decl_tag("arg:ctx"), making
> > the actual argument type not important, so that user can just define
> > "generic" signature:
> >
> >   __noinline int global_subprog(void *ctx __arg_ctx) { ... }
>
> Just realized that we probably need to enforce in both libbpf doing
> rewrite and in the kernel that __arg_ctx is either valid
> 'struct correct_type_for_bpf_prog *' or 'void *'.
>
> Otherwise the user will get surprising behavior when
> int foo(struct __sk_buff *ctx __arg_ctx)
> {
>   ctx->len;
> }
> will get rewritten to 'struct pt_regs *ctx' based on prog type
> while all asm instructions inside prog were compiled with 'struct __sk_bu=
ff'
> and CO_RE performs relocations against that type.

Nothing really prevents users from misusing types even today, so it
doesn't seem like a common problem, luckily.

But really the problem is that some program types don't have an
associated struct name at all, but still a valid context. Like for
LSM/TRACING programs it's a u64[]/u64 *. For tracepoints context is
defined as just plain u64 (according to bpf_ctx_convert), and so on.

Oh, and there is KPROBE program type, where it's (typedef)
bpf_user_pt_regs_t, and for backwards compatibility reasons we also
allow basically non-existing `struct bpf_user_pt_regs_t`.

So it gets messy. Either way, I have a patch set coming up for
kernel-side __arg_xxx tags support, so let's discuss it there?

>
> > +static struct {
> > +     enum bpf_prog_type prog_type;
> > +     const char *ctx_name;
> > +} global_ctx_map[] =3D {
> > +     { BPF_PROG_TYPE_CGROUP_DEVICE,           "bpf_cgroup_dev_ctx" },
> > +     { BPF_PROG_TYPE_CGROUP_SKB,              "__sk_buff" },
> > +     { BPF_PROG_TYPE_CGROUP_SOCK,             "bpf_sock" },
> > +     { BPF_PROG_TYPE_CGROUP_SOCK_ADDR,        "bpf_sock_addr" },
> > +     { BPF_PROG_TYPE_CGROUP_SOCKOPT,          "bpf_sockopt" },
> > +     { BPF_PROG_TYPE_CGROUP_SYSCTL,           "bpf_sysctl" },
> > +     { BPF_PROG_TYPE_FLOW_DISSECTOR,          "__sk_buff" },
> > +     { BPF_PROG_TYPE_KPROBE,                  "bpf_user_pt_regs_t" },
> > +     { BPF_PROG_TYPE_LWT_IN,                  "__sk_buff" },
> > +     { BPF_PROG_TYPE_LWT_OUT,                 "__sk_buff" },
> > +     { BPF_PROG_TYPE_LWT_SEG6LOCAL,           "__sk_buff" },
> > +     { BPF_PROG_TYPE_LWT_XMIT,                "__sk_buff" },
> > +     { BPF_PROG_TYPE_NETFILTER,               "bpf_nf_ctx" },
> > +     { BPF_PROG_TYPE_PERF_EVENT,              "bpf_perf_event_data" },
> > +     { BPF_PROG_TYPE_RAW_TRACEPOINT,          "bpf_raw_tracepoint_args=
" },
> > +     { BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, "bpf_raw_tracepoint_args=
" },
> > +     { BPF_PROG_TYPE_SCHED_ACT,               "__sk_buff" },
> > +     { BPF_PROG_TYPE_SCHED_CLS,               "__sk_buff" },
> > +     { BPF_PROG_TYPE_SK_LOOKUP,               "bpf_sk_lookup" },
> > +     { BPF_PROG_TYPE_SK_MSG,                  "sk_msg_md" },
> > +     { BPF_PROG_TYPE_SK_REUSEPORT,            "sk_reuseport_md" },
> > +     { BPF_PROG_TYPE_SK_SKB,                  "__sk_buff" },
> > +     { BPF_PROG_TYPE_SOCK_OPS,                "bpf_sock_ops" },
> > +     { BPF_PROG_TYPE_SOCKET_FILTER,           "__sk_buff" },
> > +     { BPF_PROG_TYPE_XDP,                     "xdp_md" },
>
> We already share the .c files (like relo_core.c) between kernel and libbp=
f
> let's share here as well to avoid copy paste.
> All of the above is available in include/linux/bpf_types.h

True, but libbpf sources are built both as part of the kernel repo and
separately on Github, so we'll need to start syncing
include/linux/bpf_types.h into tools/include, so that's a bit of
inconvenience.

But most of all I don't want to do it for a few other reasons.

This table was manually constructed by inspecting struct bpf_ctx_convert wi=
th:

  bpftool btf dump file /sys/kernel/btf/vmlinux format c | rg
bpf_ctx_convert -A65 | rg _prog

And it has to be manual because of other program types that don't have
associated struct for context. So even if there was bpf_types.h, we
can't use it as is.

But, if your concern is maintainability of this, I don't think that's
a problem at all. Even if we add a new program type with its own
struct name for context, we don't even have to extend this table
(though we might, if we want to), because at that point kernel is
guaranteed to have in-kernel native support for __arg_ctx, so libbpf
doesn't have to do type rewriting.

Also, this probably is the first explicit table that shows which
struct names should be used for global subprog context argument (if
not using __arg_ctx, of course). Which is not really a reason per se,
but it beats reading kernel code, and (non-trivially) figuring out
that one needs to look how struct bpf_ctx_convert is generated, etc.
Having this explicit table is much easier to link as a reference for
those special context type names.

>
> > +             /* clone fn/fn_proto, unless we already did it for anothe=
r arg */
> > +             if (func_rec->type_id =3D=3D orig_fn_id) {
>
> It feels that body of this 'if' can be factored out as a separate helper =
function.
>

Sure, I'll try to factor it out.

> > -static int
> > -bpf_object__load_progs(struct bpf_object *obj, int log_level)
> > +static int bpf_object_load_progs(struct bpf_object *obj, int log_level=
)
>
> pls keep __ convention.

replied on another patch, I'll do a conversion to consistent naming in
the next revision

