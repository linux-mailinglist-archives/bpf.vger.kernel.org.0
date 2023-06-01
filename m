Return-Path: <bpf+bounces-1600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A766C71EFBE
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 18:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DFE128172E
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908640798;
	Thu,  1 Jun 2023 16:54:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFBC13AC3
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 16:54:02 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A276197
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 09:53:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b1a7e31dcaso5087381fa.2
        for <bpf@vger.kernel.org>; Thu, 01 Jun 2023 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685638435; x=1688230435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFkaxdEbxM8t47U0dsVAGWBvj4ph0U32/fpIw4XLbxA=;
        b=kqtnt64cuccM4VZl9xLLOyRQ3Wu2bsF5UsyMXze4nRwn/QGbdWZ5IvoG4aWUhgAvQ0
         ejp2AUvj9K4aEQOha44Z9F+B+bByH6uG9LQInDlOXkz/QMoxwzENL6R18fg7qmS/QGLg
         a5CjBfC+CEM+vFcLXpIzxPSCqPJJIDAj9gwcI2iHGKGmooHpoakGMEi2VtK1wus/9xZx
         MaI4OerQig2VVIlV0eY1mugOFo7YVmS4armGs6vnbPAQ72c3e4R1iU2PiEeXH0VuXF/r
         HwtrAnK0U0hGuES3Y9JHdZl7ljiljOK4T6V3rrERKSMRwWpULFVIJiw+4Vx7xMYlssrH
         JDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638435; x=1688230435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFkaxdEbxM8t47U0dsVAGWBvj4ph0U32/fpIw4XLbxA=;
        b=BsUccXbb0DOjxHCTikkcvy25qbR9MakJ/kR73Ia+72mzG/iRX5V+JMqtlei4rhGpsV
         VPP59VlFiHzUAfk+BAeNZ25hB9VQwdLh5AXaT+Q1/sOFx8RvyEKGq3mpaMCeAktUL9nM
         nKx563Dxpp+bNaZA9dfVtWQ/sVxv3SF3tBqtXtYeuWsv32IHBMRFLX4GtUJMQ2Ld4VhD
         nnHk9xd9HkB3xwMzznbXbBRya7FsYRIQf62Hy1TQaCWdPW/vSV+p3ktXb4apDXLCyOZu
         Ri3cI10a5PuegRWPcTDZ27V+M6hczN//T0bNPtNPpuyk64dwef/vE4HHgQzeOwQ9a+To
         mSJg==
X-Gm-Message-State: AC+VfDwYjmJzCrN7gOz0Dy/oJAEUFgdm3iKhHjk8eFSI9eyCxM8aOZrZ
	aQdbjY/k7NM1bqeHO+CsGUWYDFkMC0PjGDDNjD8=
X-Google-Smtp-Source: ACHHUZ6mWEE04FMiti7PoybgflWhelJ9hX69ty9gvc9cNFL66Dmx8sF4RKnw2gi4TrkyhhuMVXh7Sm6vN18lsKW4woU=
X-Received: by 2002:a2e:9d58:0:b0:2af:1e55:1290 with SMTP id
 y24-20020a2e9d58000000b002af1e551290mr8590ljj.46.1685638434249; Thu, 01 Jun
 2023 09:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com> <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com>
In-Reply-To: <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 1 Jun 2023 09:53:42 -0700
Message-ID: <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 1, 2023 at 3:38=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 01/06/2023 04:53, Alexei Starovoitov wrote:
> > On Wed, May 31, 2023 at 09:19:28PM +0100, Alan Maguire wrote:
> >> BTF kind metadata provides information to parse BTF kinds.
> >> By separating parsing BTF from using all the information
> >> it provides, we allow BTF to encode new features even if
> >> they cannot be used.  This is helpful in particular for
> >> cases where newer tools for BTF generation run on an
> >> older kernel; BTF kinds may be present that the kernel
> >> cannot yet use, but at least it can parse the BTF
> >> provided.  Meanwhile userspace tools with newer libbpf
> >> may be able to use the newer information.
> >>
> >> The intent is to support encoding of kind metadata
> >> optionally so that tools like pahole can add this
> >> information.  So for each kind we record
> >>
> >> - a kind name string
> >> - kind-related flags
> >> - length of singular element following struct btf_type
> >> - length of each of the btf_vlen() elements following
> >>
> >> In addition we make space in the metadata for
> >> CRC32s computed over the BTF along with a CRC for
> >> the base BTF; this allows split BTF to identify
> >> a mismatch explicitly.  Finally we provide an
> >> offset for an optional description string.
> >>
> >> The ideas here were discussed at [1] hence
> >>
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>
> >> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDwrgX4bn=
=3DNuc1g8JPFC34MA@mail.gmail.com/
> >> ---
> >>  include/uapi/linux/btf.h       | 29 +++++++++++++++++++++++++++++
> >>  tools/include/uapi/linux/btf.h | 29 +++++++++++++++++++++++++++++
> >>  2 files changed, 58 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> >> index ec1798b6d3ff..94c1f4518249 100644
> >> --- a/include/uapi/linux/btf.h
> >> +++ b/include/uapi/linux/btf.h
> >> @@ -8,6 +8,34 @@
> >>  #define BTF_MAGIC   0xeB9F
> >>  #define BTF_VERSION 1
> >>
> >> +/* is this information required? If so it cannot be sanitized safely.=
 */
> >> +#define BTF_KIND_META_OPTIONAL              (1 << 0)
> >> +
> >> +struct btf_kind_meta {
> >> +    __u32 name_off;         /* kind name string offset */
> >> +    __u16 flags;            /* see BTF_KIND_META_* values above */
> >> +    __u8 info_sz;           /* size of singular element after btf_typ=
e */
> >> +    __u8 elem_sz;           /* size of each of btf_vlen(t) elements *=
/
> >> +};
> >> +
> >> +/* for CRCs for BTF, base BTF to be considered usable, flags must be =
set. */
> >> +#define BTF_META_CRC_SET            (1 << 0)
> >> +#define BTF_META_BASE_CRC_SET               (1 << 1)
> >> +
> >> +struct btf_metadata {
> >> +    __u8    kind_meta_cnt;          /* number of struct btf_kind_meta=
 */
> >> +    __u32   flags;
> >> +    __u32   description_off;        /* optional description string */
> >> +    __u32   crc;                    /* crc32 of BTF */
> >> +    __u32   base_crc;               /* crc32 of base BTF */
> >> +    struct btf_kind_meta kind_meta[];
> >> +};
> >> +
> >> +struct btf_meta_header {
> >> +    __u32   meta_off;       /* offset of metadata section */
> >> +    __u32   meta_len;       /* length of metadata section */
> >> +};
> >> +
> >>  struct btf_header {
> >>      __u16   magic;
> >>      __u8    version;
> >> @@ -19,6 +47,7 @@ struct btf_header {
> >>      __u32   type_len;       /* length of type section       */
> >>      __u32   str_off;        /* offset of string section     */
> >>      __u32   str_len;        /* length of string section     */
> >> +    struct btf_meta_header meta_header;
> >>  };
> >>
> >>  /* Max # of type identifier */
> >> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux=
/btf.h
> >> index ec1798b6d3ff..94c1f4518249 100644
> >> --- a/tools/include/uapi/linux/btf.h
> >> +++ b/tools/include/uapi/linux/btf.h
> >> @@ -8,6 +8,34 @@
> >>  #define BTF_MAGIC   0xeB9F
> >>  #define BTF_VERSION 1
> >>
> >> +/* is this information required? If so it cannot be sanitized safely.=
 */
> >> +#define BTF_KIND_META_OPTIONAL              (1 << 0)
> >> +
> >> +struct btf_kind_meta {
> >> +    __u32 name_off;         /* kind name string offset */
> >> +    __u16 flags;            /* see BTF_KIND_META_* values above */
> >> +    __u8 info_sz;           /* size of singular element after btf_typ=
e */
> >> +    __u8 elem_sz;           /* size of each of btf_vlen(t) elements *=
/
> >> +};
> >> +
> >> +/* for CRCs for BTF, base BTF to be considered usable, flags must be =
set. */
> >> +#define BTF_META_CRC_SET            (1 << 0)
> >> +#define BTF_META_BASE_CRC_SET               (1 << 1)
> >> +
> >> +struct btf_metadata {
> >> +    __u8    kind_meta_cnt;          /* number of struct btf_kind_meta=
 */
> >
> > Overall, looks great.
> > Few small nits:
> > I'd make kind_meta_cnt u32, since padding we won't be able to reuse any=
way
> > and would bump the BTF_VERSION to 2 to make it a 'milestone'.
> > v2 -> self described.
>
> sure, sounds good. One other change perhaps worth making; currently
> we assume that the kind metadata is at the end of the struct
> btf_metadata, but if we ever wanted to add metadata fields in the
> future, we'd want so support both the current metadata structure and
> any future structure which had additional fields.
>
> With that in mind, it might make sense to go with something like
>
> struct btf_metadata {
>         __u32   kind_meta_cnt;
>         __u32   kind_meta_offset;       /* kind_meta_cnt instances of str=
uct
> btf_kind_meta start here */
>         __u32   flags;
>         __u32   description_off;        /* optional description string*/
>         __u32   crc;                    /* crc32 of BTF */
>         __u32   base_crc;               /* crc32 of base BTF */
> };
>
> For the original version, kind_meta_offset would just be
> at meta_off + sizeof(struct btf_metadata), but if we had multiple
> versions of the btf_metadata header to handle, they could all rely on
> the kind_meta_offset being where kind metadata is stored.
> For validation we'd have to make sure kind_meta_offset was within
> the the metadata header range.

kind_meta_offset is an ok idea, but I don't quite see why we'd have
multiple 'struct btf_metadata' pointing to the same set of 'struct
btf_kind_meta'.

Also why do we need description_off ? Shouldn't string go into
btf_header->str_off ?

> >
> >> +    __u32   flags;
> >> +    __u32   description_off;        /* optional description string */
> >> +    __u32   crc;                    /* crc32 of BTF */
> >> +    __u32   base_crc;               /* crc32 of base BTF */
> >
> > Hard coded CRC also gives me a pause.
> > Should it be an optional KIND like btf tags?
>
> The goal of the CRC is really just to provide a unique identifier that
> we can use for things like checking if there's a mismatch between
> base and module BTF. If we want to ever do CRC validation (not sure
> if there's a case for that) we probably need to think about cases like
> BTF sanitization of BPF program BTF; this would likely only be an
> issue if metadata support is added to BPF compilers.
>
> The problem with adding it via a kind is that if we first compute
> the CRC over the entire BTF object and then add the kind, the addition
> of the kind breaks the CRC; as a result I _think_ we're stuck with
> having to have it in the header.

Hmm. libbpf can add BTF_KIND_CRC with zero-ed u32 crc field
and later fill it in.
It's really not different than u32 crc field inside 'struct btf_metadata'.

> That said I don't think CRC is necessarily the only identifier
> we could use, and we don't even need to identify it as a
> CRC in the UAPI, just as a "unique identifier"; that would deal
> with issues about breaking the CRC during sanitization. All
> depends on whether we ever see a need to verify BTF via CRC
> really.

Right. It could be sha or anything else, but user space and kernel
need to agree on the math to compute it, so something got to indicate
that this 32-bit is a crc.
Hence KIND_CRC, KIND_SHA fit better.

