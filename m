Return-Path: <bpf+bounces-46921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FD89F18FC
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A3DB188F1E7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A135B1EE00D;
	Fri, 13 Dec 2024 22:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkUTNwSx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A151EC4E8
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128385; cv=none; b=slSKWBZeq1XLzshoNOPw0Hd7HlVAM5JJW2N8lWg5bJEg5wSHEwRaNa/zIZbD0QEVIYnYotPJJScxh4ps+eq7BQoQconXtWaVpkuvN7UhipVfJ9fS5p0cIg5rSRxM036SPkbjw4P87fXU+eO0gujsObwBMgjx+cRyQnrVF4GYL7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128385; c=relaxed/simple;
	bh=GUeCi/jv1lNFy1n09Mq88+DHkVjeE8Xb/ZfM54x9UTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5EKlPfT3DYv8ZripqtsaU5muIIyDh2GDr/H0MdSPunOc/dVigVweYuno/q/ZTpZWVIrfIetRSfWHyGZOzz+19m6RjbgMrjwJW7OAfC81K5AgOUUq4pDXIwWh1lbUgK1WM59n0IJVN4rMYcD0NqII7NTdOBRu68Q/k7dF+JpCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkUTNwSx; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5d0f6fa6f8bso3400452a12.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 14:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128382; x=1734733182; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rpvfnryDtUut1CZZDJcDE4HC/lnIKvJJUQtoREsy4Tk=;
        b=SkUTNwSxIvho1yZMXgZaQODSaofc48H0JRbOdfzScCRnJWcobl6SF9awOe7+d9GGeB
         +BZAGMvbsgilgFmmzSD8aBultLaGLjbzq153oE/xU6icFpjluSTEBSFS6nB/qOH7VCoV
         JGa5SE40otrv/0bRYOgCwi67n144luUYKUMWXuzTNMO0CBx9bGn6P6oIbzDUolKNdmhe
         jw9EkyYgqQ79Bm3ufqKpZyNtNYgUp8cyAGa9kGjfp2SehwdIy64BeE0o9x/IjtMBYqJf
         jqvdRV0mYpKVrVDxWLsnsQcgmosaXZewLRUovpRXXZdUEEW1wyJsdhtoguZQhvceJOhN
         jsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128382; x=1734733182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpvfnryDtUut1CZZDJcDE4HC/lnIKvJJUQtoREsy4Tk=;
        b=i/d/crEl2UEsb/0obmurgiBitELSpqZOUGFodRK73v/5mOAFIzGq6z3PGOT+khvLnF
         n7SwBz5lSkV5AfuHoTeokcslwqde6npG616q+ubeR3oKYmQAJ0IUk3VvxcWd/OH2paxh
         OFMSLje51JPvJIH0K3oeOKPLMPm7OriG9113N32XZfUpUwhIpRb9Gp7qOy8zq/mauYYL
         YSxiU02BTE6gGQSmWtRw7gaqwhea27g3hudInDxv3DrbaYD3MpPTtrFVgIdzeRs9mZf3
         8bfov4PPndP88UDL5AeVJAkEvn4298/EeEm5hTlXlKQfphtZO20c2LVuFMMiW/fXRXCP
         oXEg==
X-Gm-Message-State: AOJu0YxeXOUGYWSHD6dWFgU2MhB1vrhogC0Vf48OJ2V3j72gkknr+phr
	kcghgo44+/Qe26Zw0li+62ewCAOdyGYAfD656O/Plj389qLaZA8perXZWcxyRvBc3c7rq+Ckxui
	o53EVMimozxO8ZiYEp/gRAxbgrDs=
X-Gm-Gg: ASbGnctuFZZAZp/59FJVbfPBUnse0DVATHJaLpRCztnEkY0+0LiUThlWTbqWUAk5Xna
	Bdd4mcq2wnH5mpBxejQgcQDEQ6c87888Xl610JzqZ
X-Google-Smtp-Source: AGHT+IHRZQrutavRUpUh2ysUw2N16dwbAxfdrvqrV6XEZPB1LsFAg16aeqMiT6mbxZI98ZrqlqF4ZRQkNnToHdOpeOA=
X-Received: by 2002:a05:6402:2708:b0:5d4:3761:d184 with SMTP id
 4fb4d7f45d1cf-5d63c3158cfmr3604913a12.10.1734128381673; Fri, 13 Dec 2024
 14:19:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213175127.2084759-1-memxor@gmail.com> <20241213175127.2084759-3-memxor@gmail.com>
 <7793d86c11139358ea1f1afb0f731d24a30f9d50.camel@gmail.com>
In-Reply-To: <7793d86c11139358ea1f1afb0f731d24a30f9d50.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 13 Dec 2024 23:19:05 +0100
Message-ID: <CAP01T771XgEpAJxneve+QA3uPd3EGG9wDLCm8OouksE5SxLEHg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/3] bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Juri Lelli <juri.lelli@redhat.com>, 
	Manu Bretelle <chantra@meta.com>, Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 21:06, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2024-12-13 at 09:51 -0800, Kumar Kartikeya Dwivedi wrote:
> > Arguments to a raw tracepoint are tagged as trusted, which carries the
> > semantics that the pointer will be non-NULL.  However, in certain cases,
> > a raw tracepoint argument may end up being NULL. More context about this
> > issue is available in [0].
> >
> > Thus, there is a discrepancy between the reality, that raw_tp arguments can
> > actually be NULL, and the verifier's knowledge, that they are never NULL,
> > causing explicit NULL check branch to be dead code eliminated.
> >
> > A previous attempt [1], i.e. the second fixed commit, was made to
> > simulate symbolic execution as if in most accesses, the argument is a
> > non-NULL raw_tp, except for conditional jumps.  This tried to suppress
> > branch prediction while preserving compatibility, but surfaced issues
> > with production programs that were difficult to solve without increasing
> > verifier complexity. A more complete discussion of issues and fixes is
> > available at [2].
> >
> > Fix this by maintaining an explicit list of tracepoints where the
> > arguments are known to be NULL, and mark the positional arguments as
> > PTR_MAYBE_NULL. Additionally, capture the tracepoints where arguments
> > are known to be ERR_PTR, and mark these arguments as scalar values to
> > prevent potential dereference.
> >
> > Each hex digit is used to encode NULL-ness (0x1) or ERR_PTR-ness (0x2),
> > shifted by the zero-indexed argument number x 4. This can be represented
> > as follows:
> > 1st arg: 0x1
> > 2nd arg: 0x10
> > 3rd arg: 0x100
> > ... and so on (likewise for ERR_PTR case).
> >
> > In the future, an automated pass will be used to produce such a list, or
> > insert __nullable annotations automatically for tracepoints. Each
> > compilation unit will be analyzed and results will be collated to find
> > whether a tracepoint pointer is definitely not null, maybe null, or an
> > unknown state where verifier conservatively marks it PTR_MAYBE_NULL.
> > A proof of concept of this tool from Eduard is available at [3].
> >
> > Note that in case we don't find a specification in the raw_tp_null_args
> > array and the tracepoint belongs to a kernel module, we will
> > conservatively mark the arguments as PTR_MAYBE_NULL. This is because
> > unlike for in-tree modules, out-of-tree module tracepoints may pass NULL
> > freely to the tracepoint. We don't protect against such tracepoints
> > passing ERR_PTR (which is uncommon anyway), lest we mark all such
> > arguments as SCALAR_VALUE.
> >
> > While we are it, let's adjust the test raw_tp_null to not perform
> > dereference of the skb->mark, as that won't be allowed anymore, and make
> > it more robust by using inline assembly to test the dead code
> > elimination behavior, which should still stay the same.
> >
> >   [0]: https://lore.kernel.org/bpf/ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb
> >   [1]: https://lore.kernel.org/all/20241104171959.2938862-1-memxor@gmail.com
> >   [2]: https://lore.kernel.org/bpf/20241206161053.809580-1-memxor@gmail.com
> >   [3]: https://github.com/eddyz87/llvm-project/tree/nullness-for-tracepoint-params
> >
> > Reported-by: Juri Lelli <juri.lelli@redhat.com> # original bug
> > Reported-by: Manu Bretelle <chantra@meta.com> # bugs in masking fix
> > Fixes: 3f00c5239344 ("bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs")
> > Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
> > Co-developed-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Tbh, I think we should have fixed the bug in what is currently in the
> tree and avoid revert. Anyways, the code looks good to me.
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>

Thanks for the review, I have addressed the nits and resent v3.

> [...]
>
> > @@ -6597,6 +6693,39 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> >       if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
> >               info->reg_type |= PTR_MAYBE_NULL;
> >
> > +     if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
> > +             struct btf *btf = prog->aux->attach_btf;
> > +             const struct btf_type *t;
> > +             const char *tname;
> > +
> > +             /* BTF lookups cannot fail, return false on error */
> > +             t = btf_type_by_id(btf, prog->aux->attach_btf_id);
> > +             if (!t)
> > +                     return false;
> > +             tname = btf_name_by_offset(btf, t->name_off);
> > +             if (!tname)
> > +                     return false;
> > +             /* Checked by bpf_check_attach_target */
> > +             tname += sizeof("bpf_trace_") - 1;
>
> Nit: bpf_check_attach_target uses "btf_trace_" prefix.
>
> > +             for (i = 0; i < ARRAY_SIZE(raw_tp_null_args); i++) {
> > +                     /* Is this a func with potential NULL args? */
> > +                     if (strcmp(tname, raw_tp_null_args[i].func))
> > +                             continue;
> > +                     if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
> > +                             info->reg_type |= PTR_MAYBE_NULL;
> > +                     /* Is the current arg IS_ERR? */
> > +                     if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
> > +                             ptr_err_raw_tp = true;
> > +                     break;
> > +             }
> > +             /* If we don't know NULL-ness specification and the tracepoint
> > +              * is coming from a loadable module, be conservative and mark
> > +              * argument as PTR_MAYBE_NULL.
> > +              */
> > +             if (i == ARRAY_SIZE(raw_tp_null_args) && btf_is_module(btf))
> > +                     info->reg_type |= PTR_MAYBE_NULL;
> > +     }
> > +
> >       if (tgt_prog) {
> >               enum bpf_prog_type tgt_type;
> >
> > @@ -6641,6 +6770,13 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> >       bpf_log(log, "func '%s' arg%d has btf_id %d type %s '%s'\n",
> >               tname, arg, info->btf_id, btf_type_str(t),
> >               __btf_name_by_offset(btf, t->name_off));
> > +
> > +     /* Perform all checks on the validity of type for this argument, but if
> > +      * we know it can be IS_ERR at runtime, scrub pointer type and mark as
> > +      * scalar.
> > +      */
> > +     if (ptr_err_raw_tp)
> > +             info->reg_type = SCALAR_VALUE;
>
> Nit: the log line above would be a bit confusing if 'ptr_err_raw_tp' would be true.
>      maybe add an additional line here, saying that verifier overrides BTF type?
>
> >       return true;
> >  }
> >  EXPORT_SYMBOL_GPL(btf_ctx_access);
>
> [...]
>

