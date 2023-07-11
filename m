Return-Path: <bpf+bounces-4783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1842674F653
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 19:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A47E1C20ED5
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD51DDE8;
	Tue, 11 Jul 2023 17:01:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A81DDD0
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 17:01:22 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D31710
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 10:01:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so7477036a12.0
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689094878; x=1691686878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wy8enXrf/EGldNgdq3R3GbuXPj6cchEQP7hwbTGHBfs=;
        b=mYik1NgOgIxmzA2gbZ0HQa3bkn9S1nnP8CM+R/u0p1IGjHcLMz0+WyODBCmxLJjbcV
         NwAAvINt7CWcExhksP7Y/xUToGIPon/XtH/PL15Fyck0iwMASVJU/PcWrt3PkbEqI74o
         uGDIapn6inxKN0S7xtC5wtzaABujdc4MMz3YTllFeXY2BDEAVbp6TW5MLJfpyqh9k7N5
         T6lB3zwf7ubRfm8whD1wuHwN9aMS2gpThnc/2WXDsVeTrxHtDSAaA0uMIqNCaIt3Qx+D
         ejsNJdTSbnYfTMHyAr65OXAvUn9nnEkQ8nQixafAGg3SJkqyVvjH0LvqpeA/h1B+xF9u
         Z4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689094878; x=1691686878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wy8enXrf/EGldNgdq3R3GbuXPj6cchEQP7hwbTGHBfs=;
        b=hZf/YJZ7AMJqI/NmOFtJu9HwfQnH4yC//scYlp+yiym0nYpdRuT+nXJ80G8LDCNAR/
         ryragqSDsOl4xBFc+k/dEKeUbYRGNG9dm811FZ75DrYX1Fp6CYaWvbPyYYNG1xIbdDqh
         XIoaneQ+KFyLSzEBWSbJtWfsvstls402cPeAJ3glCyTpvr1RTD0P6O8Xbpn6Qxhwzjoa
         roK/SgFP9D4s/Hi9E2trsB7SCGuNMCpQ49wxCFMJ+LOBqUZPBcc8864Odbhv7xa8o0/J
         q3wsHpgEg5T/j1leJSexVItbAfnrSt3HdhZ/3CcisIeMk9jh2dGYB80/CZOfDe4skkKh
         XM0w==
X-Gm-Message-State: ABy/qLaRIbT1Alz1yK0GiejnZ3jYiauUUwUAovLRS0GdNPwWPJhrOsGj
	nO6vAJw+calrWWjQfhRLFj62HfBOSFLkmB61fEo=
X-Google-Smtp-Source: APBJJlHrqQKlL+YtL2clAbcSL40NsrkRmbcDDa8qcOnRgJBB2diZ2zBpjxPR3QAq3IuMnPp/KFfCFNBIiwXDaJj3h1E=
X-Received: by 2002:aa7:d3c2:0:b0:51e:1a3c:e729 with SMTP id
 o2-20020aa7d3c2000000b0051e1a3ce729mr14588398edr.15.1689094878111; Tue, 11
 Jul 2023 10:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230630083344.984305-1-jolsa@kernel.org> <20230630083344.984305-8-jolsa@kernel.org>
 <CAEf4BzbLDnEyCwEBn2PJCM_756d_C8Pbb+ocvwEkacnd1b8yVQ@mail.gmail.com> <ZK0bYPiJdTBZaE9h@krava>
In-Reply-To: <ZK0bYPiJdTBZaE9h@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jul 2023 10:01:05 -0700
Message-ID: <CAEf4BzbP2NGa_g9MHHvtern9NDq-d4QzoMuC6Pto32P+Rq08Uw@mail.gmail.com>
Subject: Re: [PATCHv3 bpf-next 07/26] libbpf: Move elf_find_func_offset*
 functions to elf object
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 2:05=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Jul 06, 2023 at 04:02:22PM -0700, Andrii Nakryiko wrote:
> > On Fri, Jun 30, 2023 at 1:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Adding new elf object that will contain elf related functions.
> > > There's no functional change.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/lib/bpf/Build        |   2 +-
> > >  tools/lib/bpf/elf.c        | 198 +++++++++++++++++++++++++++++++++++=
++
> > >  tools/lib/bpf/libbpf.c     | 186 +---------------------------------
> > >  tools/lib/bpf/libbpf_elf.h |  11 +++
> > >  4 files changed, 211 insertions(+), 186 deletions(-)
> > >  create mode 100644 tools/lib/bpf/elf.c
> > >  create mode 100644 tools/lib/bpf/libbpf_elf.h
> > >
> >
> > [...]
> >
> > > diff --git a/tools/lib/bpf/libbpf_elf.h b/tools/lib/bpf/libbpf_elf.h
> > > new file mode 100644
> > > index 000000000000..1b652220fabf
> > > --- /dev/null
> > > +++ b/tools/lib/bpf/libbpf_elf.h
> > > @@ -0,0 +1,11 @@
> > > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > > +
> > > +#ifndef __LIBBPF_LIBBPF_ELF_H
> > > +#define __LIBBPF_LIBBPF_ELF_H
> > > +
> > > +#include <libelf.h>
> > > +
> > > +long elf_find_func_offset(Elf *elf, const char *binary_path, const c=
har *name);
> > > +long elf_find_func_offset_from_file(const char *binary_path, const c=
har *name);
> > > +
> > > +#endif /* *__LIBBPF_LIBBPF_ELF_H */
> >
> > we have libbpf_internal.h, let's put all this there for now, it's
> > already all the internal stuff together, I don't know if separate
> > header with few functions gives us much
>
> there's more functions coming later in the patchset
>
>         struct elf_fd {
>                 Elf *elf;
>                 int fd;
>         };
>
>         int elf_open(const char *binary_path, struct elf_fd *elf_fd);
>         void elf_close(struct elf_fd *elf_fd);
>
>         int elf_resolve_syms_offsets(const char *binary_path, int cnt,
>                                      const char **syms, unsigned long **p=
offsets);
>
>         int elf_resolve_pattern_offsets(const char *binary_path, const ch=
ar *pattern,
>                                          unsigned long **poffsets, size_t=
 *pcnt);
>
>
> and there's probably more elf helpers to eventually move in:
>
>         libbpf.c:static const char *elf_sym_str(const struct bpf_object *=
obj, size_t off);
>         libbpf.c:static const char *elf_sec_str(const struct bpf_object *=
obj, size_t off);
>         libbpf.c:static Elf_Scn *elf_sec_by_idx(const struct bpf_object *=
obj, size_t idx);
>         libbpf.c:static Elf_Scn *elf_sec_by_name(const struct bpf_object =
*obj, const char *name);
>         libbpf.c:static Elf64_Shdr *elf_sec_hdr(const struct bpf_object *=
obj, Elf_Scn *scn);
>         libbpf.c:static const char *elf_sec_name(const struct bpf_object =
*obj, Elf_Scn *scn);
>         libbpf.c:static Elf_Data *elf_sec_data(const struct bpf_object *o=
bj, Elf_Scn *scn);
>         libbpf.c:static Elf64_Sym *elf_sym_by_idx(const struct bpf_object=
 *obj, size_t idx);
>         libbpf.c:static Elf64_Rel *elf_rel_by_idx(Elf_Data *data, size_t =
idx);
>

yep, I was anticipating that these will move as well. But I think it's
fine if they all stay in libbpf_internal.h, IMO. I'd rather not have
many small internal header for no good reason (like we have
str_error.h right now, with a single func declaration)

>         usdt.c:static int find_elf_sec_by_name(Elf *elf, const char *sec_=
name, GElf_Shdr *shdr, Elf_Scn **scn)
>
>         'struct elf_seg' stuff
>
>         usdt.c:static int cmp_elf_segs(const void *_a, const void *_b)
>         usdt.c:static int parse_elf_segs(Elf *elf, const char *path, stru=
ct elf_seg **segs, size_t *seg_cnt)
>         usdt.c:static int parse_vma_segs(int pid, const char *lib_path, s=
truct elf_seg **segs, size_t *seg_cnt)
>         usdt.c:static struct elf_seg *find_elf_seg(struct elf_seg *segs, =
size_t seg_cnt, long virtaddr)
>         usdt.c:static struct elf_seg *find_vma_seg(struct elf_seg *segs, =
size_t seg_cnt, long offset)
>
>
> but I can add the new header file later in follow up changes when
> we have more elf functions in

see above, I don't think we should, let's stick to libbpf_internal.h for no=
w

>
> jirka

