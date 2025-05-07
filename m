Return-Path: <bpf+bounces-57671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C198AAE784
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 19:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584F53B4673
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4473A28C2C1;
	Wed,  7 May 2025 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIjMgzYN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B046719AD5C
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638057; cv=none; b=scjjnkpyxQHmAvRO1aDkygKN2mPXihiHiE+1s5OPLrcaMeaVa53T9PAnfWgLyNKYmFB4Zkb0D61mSveWJ1v7qDEFIxV7NxkZc60ejt/NOlf6EmceCmCjB4VQIBFCsAGk/tA16Ur9Ka9CByhx6JMox7Va2JF170uLd4nDfox3kyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638057; c=relaxed/simple;
	bh=cCa4CGxsKfxNDbbpUcVtFm+oX/nZVa3GlQNJNDMRHVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zw1zM/MESp6Yf48Bh2vAxXSraxKHagXgqiLAxEaBVRDWXz538b5C5kNOGdm02sRYOHIhdKri83WPJ/ndeabxnCKVbF5SvFNOnTV42rL6UL+4C5s8GicQIT2SjFIi0o482KGD/PSxjaMETtyXs0iP264n2FTf/5L/rKEac0t/9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIjMgzYN; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-54e98f73850so102111e87.1
        for <bpf@vger.kernel.org>; Wed, 07 May 2025 10:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746638053; x=1747242853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8dn4k3qQ7o0rvngSoxoIRhrtqb2GJyGBwHpVitONOPs=;
        b=FIjMgzYNUD9bWt5IZAoe+ocu6an18OEPswF87lD5NOheb4dS6KomIdaa5Eqs+FkAio
         FTI2K2Fvuzy6bzC0qfAIvK2BBigRH34dS3mJWz7jEkOWcaDQJXYJubSXj8g0X84eZ4r4
         7deQKocas6Xn1OHbuMhiZY57v1SWnnZZhSuCtvRp+5+79lQB1AXVfW+Lgwk1A18bOWF5
         X+ovclA/N/feuZ7ExCN9ZumE7xdDRIPSd3TmQv3UBqp8U4Zmy9BFJpQDox9QZt2LRSTE
         RP7VR10zXqk8sI0c6QAGF+/We3GEKxAm26rUhQJeW88bXF9TV37vQLshHCxk3FllHowb
         9tNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746638053; x=1747242853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dn4k3qQ7o0rvngSoxoIRhrtqb2GJyGBwHpVitONOPs=;
        b=f5KONMNz3bxrTcAWFYmZ7fG/AlLD+Dd/ogk5am0JAkT+vz0cEsDOwwVxlc7lZNsQ+T
         ssCDFWadu+HJOuxIvdtlS98B5iWHhxT8bNyZqMYmk3yIibFt8Kv9qwlPx42DytZFAend
         0gm7cpogaa7pOwpYkDi9zP778cxt/hdYzBkNkSb+miZ6aj02nLSNKOuh1jJbyTohRqzI
         CjL5Ggtek6o0HlL+0GMjPFbMGQu1soOuinWCYq3QEi4bWiFa9wJQa1/tcuVDnU7PZdjP
         VzdFBQ/Jc9MmP36DVbVRuKQINkiYD9gK5e1mWUZYwH7PW7cgX+dzjaQY96c8JnXwGR7Q
         diMg==
X-Gm-Message-State: AOJu0YxlNMej2mCxxfYetzz1GYBEm5XrTG2YrWWgKjleVVlBubYbU5kx
	PcTJdlfu5Kr+Wa81lWMC0AHz7k0bUpmLdw6UXb+Bv3g5UxIAfs69PaWLAlGTus4g5D4+hXVaTW2
	1Q8rD8RMbZIAQ9rHCbYzlFT5KgzUIMhRQF9M=
X-Gm-Gg: ASbGnct13c83T4bTPbBIuMC/v9Rq2eh/gQ+NOx+DtjsRRBz4GNG4axhthadS2R05eSR
	TgYlnWWu/D3BjIWRd0zaZXxt/LnXfeCEhL4jxNr7uUnUsdacz7s8RrLsDEXY5ZzmXStZ19Tba2d
	W+MLjuQijMfctY7OQYBanFpO4=
X-Google-Smtp-Source: AGHT+IEnFHmppPIH0AUZcbBD/s2Gl+0S5bsQ2CJPm215axQry1HScv8jrF0lIHzSNZ3etJe9iP9odL/i7Rap998O5lw=
X-Received: by 2002:a17:907:c388:b0:abf:742e:1fd7 with SMTP id
 a640c23a62f3a-ad1e8d89795mr434313966b.57.1746638041609; Wed, 07 May 2025
 10:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-13-memxor@gmail.com>
 <278df14f-4d2b-4457-94a8-c2f7ff62dd6a@kernel.org>
In-Reply-To: <278df14f-4d2b-4457-94a8-c2f7ff62dd6a@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 7 May 2025 19:13:25 +0200
X-Gm-Features: ATxdqUGhEUiuSFgl1eP6g_ost1ggY18MvN2HMWinE2oCKTXlj5iEnfCwNUQ2wuA
Message-ID: <CAP01T74oJT=ipS636yQWJ9HpSaAfMyoN_3bWMWJpyme8cKT6-Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 12/13] bpftool: Add support for
 dumping streams
To: Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 00:10, Quentin Monnet <qmo@kernel.org> wrote:
>
> 2025-04-14 09:14 UTC-0700 ~ Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Add bpftool support for dumping streams of a given BPF program.
>
>
> Thanks for adding bpftool support!
>
>
> > TODO: JSON and filepath support.
>
>
> ... plus documentation (man page), and bash completion please.
>

Done.

>
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  tools/bpf/bpftool/Makefile              |  2 +-
> >  tools/bpf/bpftool/prog.c                | 71 +++++++++++++++++-
> >  tools/bpf/bpftool/skeleton/stream.bpf.c | 96 +++++++++++++++++++++++++
> >  3 files changed, 166 insertions(+), 3 deletions(-)
> >  create mode 100644 tools/bpf/bpftool/skeleton/stream.bpf.c
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index 9e9a5f006cd2..eb908223c3bb 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -234,7 +234,7 @@ $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
> >  $(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTRAP)
> >       $(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) gen skeleton $< > $@
> >
> > -$(OUTPUT)prog.o: $(OUTPUT)profiler.skel.h
> > +$(OUTPUT)prog.o: $(OUTPUT)profiler.skel.h $(OUTPUT)stream.skel.h
> >
> >  $(OUTPUT)pids.o: $(OUTPUT)pid_iter.skel.h
> >
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index f010295350be..d0800fec9c3d 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -35,12 +35,16 @@
> >  #include "main.h"
> >  #include "xlated_dumper.h"
> >
> > +#include "stream.skel.h"
> > +
> >  #define BPF_METADATA_PREFIX "bpf_metadata_"
> >  #define BPF_METADATA_PREFIX_LEN (sizeof(BPF_METADATA_PREFIX) - 1)
> >
> >  enum dump_mode {
> >       DUMP_JITED,
> >       DUMP_XLATED,
> > +     DUMP_STDOUT,
> > +     DUMP_STDERR,
> >  };
> >
> >  static const bool attach_types[] = {
> > @@ -697,6 +701,55 @@ static int do_show(int argc, char **argv)
> >       return err;
> >  }
> >
> > +static int process_stream_sample(void *ctx, void *data, size_t len)
> > +{
> > +     FILE *file = ctx;
> > +
> > +     fprintf(file, "%s", (char *)data);
> > +     fflush(file);
> > +     return 0;
> > +}
> > +
> > +static int
> > +prog_dump_stream(struct bpf_prog_info *info, enum dump_mode mode, const char *filepath)
> > +{
> > +     FILE *file = mode == DUMP_STDOUT ? stdout : stderr;
> > +     LIBBPF_OPTS(bpf_test_run_opts, opts);
> > +     struct ring_buffer *ringbuf;
> > +     struct stream_bpf *skel;
> > +     int map_fd, ret = -1;
> > +
> > +     __u32 prog_id = info->id;
> > +     __u32 stream_id = mode == DUMP_STDOUT ? 1 : 2;
> > +
> > +     skel = stream_bpf__open_and_load();
> > +     if (!skel)
> > +             return -errno;
> > +     skel->bss->prog_id = prog_id;
> > +     skel->bss->stream_id = stream_id;
> > +
> > +     //TODO(kkd): Filepath handling
> > +     map_fd = bpf_map__fd(skel->maps.ringbuf);
> > +     ringbuf = ring_buffer__new(map_fd, process_stream_sample, file, NULL);
> > +     if (!ringbuf) {
> > +             ret = -errno;
> > +             goto end;
> > +     }
> > +     do {
> > +             skel->bss->written_count = skel->bss->written_size = 0;
> > +             ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.bpftool_dump_prog_stream), &opts);
> > +             ret = -EINVAL;
> > +             if (ring_buffer__consume_n(ringbuf, skel->bss->written_count) != skel->bss->written_count)
> > +                     goto end;
> > +     } while (!ret && opts.retval == EAGAIN);
> > +
> > +     if (opts.retval != 0)
> > +             ret = -EINVAL;
> > +end:
> > +     stream_bpf__destroy(skel);
> > +     return ret;
> > +}
> > +
> >  static int
> >  prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
> >         char *filepath, bool opcodes, bool visual, bool linum)
> > @@ -719,13 +772,15 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
> >               }
> >               buf = u64_to_ptr(info->jited_prog_insns);
> >               member_len = info->jited_prog_len;
> > -     } else {        /* DUMP_XLATED */
> > +     } else if (mode == DUMP_XLATED) {       /* DUMP_XLATED */
> >               if (info->xlated_prog_len == 0 || !info->xlated_prog_insns) {
> >                       p_err("error retrieving insn dump: kernel.kptr_restrict set?");
> >                       return -1;
> >               }
> >               buf = u64_to_ptr(info->xlated_prog_insns);
> >               member_len = info->xlated_prog_len;
> > +     } else if (mode == DUMP_STDOUT || mode == DUMP_STDERR) {
> > +             return prog_dump_stream(info, mode, filepath);
> >       }
> >
> >       if (info->btf_id) {
> > @@ -898,8 +953,10 @@ static int do_dump(int argc, char **argv)
> >               mode = DUMP_JITED;
> >       } else if (is_prefix(*argv, "xlated")) {
> >               mode = DUMP_XLATED;
> > +     } else if (is_prefix(*argv, "stdout") || is_prefix(*argv, "stderr")) {
> > +             mode = is_prefix(*argv, "stdout") ? DUMP_STDOUT : DUMP_STDERR;
> >       } else {
> > -             p_err("expected 'xlated' or 'jited', got: %s", *argv);
> > +             p_err("expected 'stdout', 'stderr', 'xlated' or 'jited', got: %s", *argv);
> >               return -1;
> >       }
> >       NEXT_ARG();
> > @@ -950,6 +1007,14 @@ static int do_dump(int argc, char **argv)
> >               }
> >       }
> >
> > +     if (mode == DUMP_STDOUT || mode == DUMP_STDERR) {
> > +             if (opcodes || visual || linum) {
> > +                     p_err("'%s' is not compatible with 'opcodes', 'visual', or 'linum'",
> > +                           mode == DUMP_STDOUT ? "stdout" : "stderr");
> > +                     goto exit_close;
> > +             }
> > +     }
> > +
> >       if (filepath && (opcodes || visual || linum)) {
> >               p_err("'file' is not compatible with 'opcodes', 'visual', or 'linum'");
> >               goto exit_close;
> > @@ -2468,6 +2533,8 @@ static int do_help(int argc, char **argv)
> >               "Usage: %1$s %2$s { show | list } [PROG]\n"
> >               "       %1$s %2$s dump xlated PROG [{ file FILE | [opcodes] [linum] [visual] }]\n"
> >               "       %1$s %2$s dump jited  PROG [{ file FILE | [opcodes] [linum] }]\n"
> > +             "       %1$s %2$s dump stdout PROG [{ file FILE }]\n"
> > +             "       %1$s %2$s dump stderr PROG [{ file FILE }]\n"
>
>
> I'm not sure "prog dump" is the best subcommand for these features. The
> "dump" has been associated with printing the program itself, either
> translated or as JITed instructions. Here we display something else;
> it's closer to "prog tracelog", that we use to dump the trace pipe. And
> stdout/stderr are streams anyway, I'm not sure that "dumping" them is
> the most accurate term.
>
> How about "prog trace (stdout|stderr)"? Bonus: you don't have to handle
> opcodes/linum/visual, and don't have to add support for "filepath".

I went with prog tracelog {stdout|stderr}, since trace probably feels
a bit odd in this context.
Tracelog alone will print trace pipe, when passed stdout/stderr it
gives the stream output.
Let me know what you think.

>
>
> >               "       %1$s %2$s pin   PROG FILE\n"
> >               "       %1$s %2$s { load | loadall } OBJ  PATH \\\n"
> >               "                         [type TYPE] [{ offload_dev | xdpmeta_dev } NAME] \\\n"
> > diff --git a/tools/bpf/bpftool/skeleton/stream.bpf.c b/tools/bpf/bpftool/skeleton/stream.bpf.c
> > new file mode 100644
> > index 000000000000..31b5933e0384
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/skeleton/stream.bpf.c
> > @@ -0,0 +1,96 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
>
> Bpftool is dual-licensed (GPL-2.0-only OR BSD-2-Clause), please consider
> using the same here.

Done.

>
>
> > +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include <bpf/bpf_helpers.h>
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_RINGBUF);
> > +     __uint(max_entries, 1024 * 1024);
> > +} ringbuf SEC(".maps");
> > +
> > +struct value {
> > +     struct bpf_stream_elem_batch __kptr *batch;
> > +};
> > +
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_ARRAY);
> > +     __type(key, int);
> > +     __type(value, struct value);
> > +     __uint(max_entries, 1);
> > +} array SEC(".maps");
> > +
> > +int written_size;
> > +int written_count;
> > +int stream_id;
> > +int prog_id;
> > +
> > +#define ENOENT 2
> > +#define EAGAIN 11
> > +#define EFAULT 14
> > +
> > +SEC("syscall")
> > +int bpftool_dump_prog_stream(void *ctx)
> > +{
> > +     struct bpf_stream_elem_batch *elem_batch;
> > +     struct bpf_stream_elem *elem;
> > +     struct bpf_stream *stream;
> > +     bool cont = false;
> > +     struct value *v;
> > +     bool ret = 0;
> > +
> > +     stream = bpf_prog_stream_get(BPF_STDERR, prog_id);
>
>
> Calls to these new kfuncs will break compilation on older systems that
> don't support them yet (and don't have the definition in their
> vmlinux.h). We should provide fallback definitions to make sure that the
> program compiles.

This is the only thing I haven't yet addressed in v2, because it
seemed a bit ugly.
I tried adding kfunc declarations, but those aren't enough.
We rely on structs introduced and read in this patch.
So I think vmlinux.h needs to be dropped, but it means adding a lot
more than just the declarations, all types, plus any types they
transitively depend on.
Maybe there is a better way (like detecting compilation failure and skipping?).
But if not, I will address like above in v3.

>
>
> > +     if (!stream)
> > +             return ENOENT;
> > +
> > +     v = bpf_map_lookup_elem(&array, &(int){0});
> > +
> > +     if (v->batch)
> > +             elem_batch = bpf_kptr_xchg(&v->batch, NULL);
> > +     else
> > +             elem_batch = bpf_stream_next_elem_batch(stream);
> > +     if (!elem_batch)
> > +             goto end;
> > +
> > +     bpf_repeat(BPF_MAX_LOOPS) {
> > +             struct bpf_dynptr dst_dptr, src_dptr;
> > +             int size;
> > +
> > +             elem = bpf_stream_next_elem(elem_batch);
> > +             if (!elem)
> > +                     break;
> > +             size = elem->mem_slice.len;
> > +
> > +             if (bpf_dynptr_from_mem_slice(&elem->mem_slice, 0, &src_dptr))
> > +                     ret = EFAULT;
> > +             if (bpf_ringbuf_reserve_dynptr(&ringbuf, size, 0, &dst_dptr))
> > +                     ret = EFAULT;
> > +             if (bpf_dynptr_copy(&dst_dptr, 0, &src_dptr, 0, size))
> > +                     ret = EFAULT;
> > +             bpf_ringbuf_submit_dynptr(&dst_dptr, 0);
> > +
> > +             written_count++;
> > +             written_size += size;
> > +
> > +             bpf_stream_free_elem(elem);
> > +
> > +             /* Probe and exit if no more space, probe for twice the typical size.*/
> > +             if (bpf_ringbuf_reserve_dynptr(&ringbuf, 2048, 0, &dst_dptr))
> > +                     cont = true;
> > +             bpf_ringbuf_discard_dynptr(&dst_dptr, 0);
> > +
> > +             if (ret || cont)
> > +                     break;
> > +     }
> > +
> > +     if (cont)
> > +             elem_batch = bpf_kptr_xchg(&v->batch, elem_batch);
> > +     if (elem_batch)
> > +             bpf_stream_free_elem_batch(elem_batch);
> > +end:
> > +     bpf_prog_stream_put(stream);
> > +
> > +     return ret ?: (cont ? EAGAIN : 0);
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
>
>
> Same note on the license, other programs used by bpftool have license
> string "Dual BSD/GPL".

Done, please take a look at the changes in v2.

