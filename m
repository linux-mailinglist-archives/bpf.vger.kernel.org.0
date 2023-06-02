Return-Path: <bpf+bounces-1715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D9F7207A4
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 18:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA761C21238
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5756086C;
	Fri,  2 Jun 2023 16:32:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923860864
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 16:32:54 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EFBB6
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 09:32:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5149c51fd5bso3181569a12.0
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 09:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685723570; x=1688315570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfHaXMUrHBmG1blSwlT8XcGepblU1x35yi4cf2C1ZjQ=;
        b=b3dMWjY/r92CBfSoVM4DNJCxBEpNeEz1g0VDBu3B7qPA4HpUXkUFdd8UcXNhb5GX/g
         6THCXT2qAhCzEplbi1vP9cyL+EDCi9uTVBGHrOUNyolKrq3LYiW4MdhggpzRd/26NWbK
         klPTmbZS5Qqas8RYSVaV/NLGfylU0L8WlESrtu92KlqwSWl7r9OvxB355cj3JqCV00pj
         b/knIerzsi2Z9NqO1e26X7otmZx8dTmYXwZrCd+rhqpdQVu2B+m6DZutSlhzPIfPVWMa
         JxI6xHHaTJlWCggMjXOt0qzs9rtW9Oq+KY4P/v6NFtzgAqibk4dukKqLUAaB63d5D0Vf
         jaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723570; x=1688315570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfHaXMUrHBmG1blSwlT8XcGepblU1x35yi4cf2C1ZjQ=;
        b=aOEkglQDdegNu466vB3TrYAOwn/ER5M/iIWlM2ZoUsy8kVINAMfvwXUpQ5a+b9NJ8o
         Ei9GU2XPyd/7iaJGwqwIGXlE0jo3cVWe9ssm4n9p6+6vFQgX+MsqGZLHZbBztjyFIhvg
         kqJrJ+GLJEDJgUFefdQ7JYdqy/iBHsZEGfm7zFAHTEqrKGEeaSXDDbN1lKgT58JuL4uj
         I8fVccaOIPCoPndwSQuNJLE2fqsMt5i6LMXGrhWCaWUzjZkGyevDKGiqwHv5eezCRZnD
         +k7vS5Rvh+6evcDRCNYcAkO//63w5oT+f9voxFoMh4ZF9XnB3QRjq4ULAkYnSl7lVIDq
         Wo/A==
X-Gm-Message-State: AC+VfDy7iXBrwhg2XxNjcXiuU817l9SAbbZLtv9AA7bzt18iOqeXUJaM
	lOGL7zP+OkyaOUEvyn+2IcJgQ5Jm2S9tUhzCWzE=
X-Google-Smtp-Source: ACHHUZ6lKnm1c4kkhNi5LW1yAvSatE8m+etv2z39qEJuGjMYMf0hqxOtRcTsMRaa0lC+h8ksQcInan8dIdpD+ykKNA0=
X-Received: by 2002:a05:6402:1b1b:b0:514:9b60:ea6a with SMTP id
 by27-20020a0564021b1b00b005149b60ea6amr2589498edb.4.1685723569886; Fri, 02
 Jun 2023 09:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com> <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com> <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
In-Reply-To: <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Jun 2023 09:32:37 -0700
Message-ID: <CAEf4BzZaUEqYnyBs6OqX2_L_X=U4zjrKF9nPeyyKp7tRNVLMww@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
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

On Thu, Jun 1, 2023 at 9:54=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jun 1, 2023 at 3:38=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
> >
> > On 01/06/2023 04:53, Alexei Starovoitov wrote:
> > > On Wed, May 31, 2023 at 09:19:28PM +0100, Alan Maguire wrote:
> > >> BTF kind metadata provides information to parse BTF kinds.
> > >> By separating parsing BTF from using all the information
> > >> it provides, we allow BTF to encode new features even if
> > >> they cannot be used.  This is helpful in particular for
> > >> cases where newer tools for BTF generation run on an
> > >> older kernel; BTF kinds may be present that the kernel
> > >> cannot yet use, but at least it can parse the BTF
> > >> provided.  Meanwhile userspace tools with newer libbpf
> > >> may be able to use the newer information.
> > >>
> > >> The intent is to support encoding of kind metadata
> > >> optionally so that tools like pahole can add this
> > >> information.  So for each kind we record
> > >>
> > >> - a kind name string
> > >> - kind-related flags
> > >> - length of singular element following struct btf_type
> > >> - length of each of the btf_vlen() elements following
> > >>
> > >> In addition we make space in the metadata for
> > >> CRC32s computed over the BTF along with a CRC for
> > >> the base BTF; this allows split BTF to identify
> > >> a mismatch explicitly.  Finally we provide an
> > >> offset for an optional description string.
> > >>
> > >> The ideas here were discussed at [1] hence
> > >>
> > >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > >>
> > >> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDwrgX4=
bn=3DNuc1g8JPFC34MA@mail.gmail.com/
> > >> ---
> > >>  include/uapi/linux/btf.h       | 29 +++++++++++++++++++++++++++++
> > >>  tools/include/uapi/linux/btf.h | 29 +++++++++++++++++++++++++++++
> > >>  2 files changed, 58 insertions(+)
> > >>
> > >> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> > >> index ec1798b6d3ff..94c1f4518249 100644
> > >> --- a/include/uapi/linux/btf.h
> > >> +++ b/include/uapi/linux/btf.h
> > >> @@ -8,6 +8,34 @@
> > >>  #define BTF_MAGIC   0xeB9F
> > >>  #define BTF_VERSION 1
> > >>
> > >> +/* is this information required? If so it cannot be sanitized safel=
y. */
> > >> +#define BTF_KIND_META_OPTIONAL              (1 << 0)

Another flag I was thinking about was a flag whether struct btf_type's
type/size field is a type or a size (or something else). E.g., let's
say we haven't had btf_type_tag yet and were adding it after we had
this new metadata. We could say that type_tag's type/size field is
actually a type ID, and generic tools like bpftool could basically
skip type_tag and resolve to underlying type. This way, optional
modifier/decorator KINDs won't even have to break applications using
old libbpf's when it comes to calculating type sizes and resolving
them.

> > >> +
> > >> +struct btf_kind_meta {
> > >> +    __u32 name_off;         /* kind name string offset */

I'm not sure why we'd need to record this for every KIND? The tool
that doesn't know about this new kind can't do much about it anyways,
so whether it knows that this is "KIND_NEW_FANCY" or just its ID #123
doesn't make much difference?

> > >> +    __u16 flags;            /* see BTF_KIND_META_* values above */
> > >> +    __u8 info_sz;           /* size of singular element after btf_t=
ype */
> > >> +    __u8 elem_sz;           /* size of each of btf_vlen(t) elements=
 */

on the other hand, reserving __u32 as "extra" might be useful if we
ever want to have some more stuff here (worst case we can define it as
string offset which describes some more metadata


> > >> +};
> > >> +
> > >> +/* for CRCs for BTF, base BTF to be considered usable, flags must b=
e set. */
> > >> +#define BTF_META_CRC_SET            (1 << 0)
> > >> +#define BTF_META_BASE_CRC_SET               (1 << 1)
> > >> +
> > >> +struct btf_metadata {
> > >> +    __u8    kind_meta_cnt;          /* number of struct btf_kind_me=
ta */
> > >> +    __u32   flags;
> > >> +    __u32   description_off;        /* optional description string =
*/
> > >> +    __u32   crc;                    /* crc32 of BTF */
> > >> +    __u32   base_crc;               /* crc32 of base BTF */
> > >> +    struct btf_kind_meta kind_meta[];
> > >> +};
> > >> +
> > >> +struct btf_meta_header {
> > >> +    __u32   meta_off;       /* offset of metadata section */
> > >> +    __u32   meta_len;       /* length of metadata section */
> > >> +};
> > >> +
> > >>  struct btf_header {
> > >>      __u16   magic;
> > >>      __u8    version;
> > >> @@ -19,6 +47,7 @@ struct btf_header {
> > >>      __u32   type_len;       /* length of type section       */
> > >>      __u32   str_off;        /* offset of string section     */
> > >>      __u32   str_len;        /* length of string section     */
> > >> +    struct btf_meta_header meta_header;

looking through all this, it seems like it would be better to have a
separate "metadata" section, just like we have types and strings? And
then the contents are described by btf_metadata struct?


> > >>  };
> > >>
> > >>  /* Max # of type identifier */
> > >> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/lin=
ux/btf.h
> > >> index ec1798b6d3ff..94c1f4518249 100644
> > >> --- a/tools/include/uapi/linux/btf.h
> > >> +++ b/tools/include/uapi/linux/btf.h
> > >> @@ -8,6 +8,34 @@
> > >>  #define BTF_MAGIC   0xeB9F
> > >>  #define BTF_VERSION 1
> > >>
> > >> +/* is this information required? If so it cannot be sanitized safel=
y. */
> > >> +#define BTF_KIND_META_OPTIONAL              (1 << 0)
> > >> +
> > >> +struct btf_kind_meta {
> > >> +    __u32 name_off;         /* kind name string offset */
> > >> +    __u16 flags;            /* see BTF_KIND_META_* values above */
> > >> +    __u8 info_sz;           /* size of singular element after btf_t=
ype */
> > >> +    __u8 elem_sz;           /* size of each of btf_vlen(t) elements=
 */
> > >> +};
> > >> +
> > >> +/* for CRCs for BTF, base BTF to be considered usable, flags must b=
e set. */
> > >> +#define BTF_META_CRC_SET            (1 << 0)
> > >> +#define BTF_META_BASE_CRC_SET               (1 << 1)
> > >> +
> > >> +struct btf_metadata {
> > >> +    __u8    kind_meta_cnt;          /* number of struct btf_kind_me=
ta */
> > >
> > > Overall, looks great.
> > > Few small nits:
> > > I'd make kind_meta_cnt u32, since padding we won't be able to reuse a=
nyway
> > > and would bump the BTF_VERSION to 2 to make it a 'milestone'.

Bumping BTF_VERSION to 2 automatically makes BTF incompatible with all
existing kernels (and potentially many tools that parse BTF). Given we
can actually extend BTF in backwards compatible way by just adding an
optional two fields to btf_header + extra bytes for metadata sections,
why making our lives harder by bumping this version?

> > > v2 -> self described.
> >
> > sure, sounds good. One other change perhaps worth making; currently
> > we assume that the kind metadata is at the end of the struct
> > btf_metadata, but if we ever wanted to add metadata fields in the
> > future, we'd want so support both the current metadata structure and
> > any future structure which had additional fields.

see above, another reason to make metadata a separate section, in
addition to types and strings

> >
> > With that in mind, it might make sense to go with something like
> >
> > struct btf_metadata {
> >         __u32   kind_meta_cnt;
> >         __u32   kind_meta_offset;       /* kind_meta_cnt instances of s=
truct
> > btf_kind_meta start here */
> >         __u32   flags;
> >         __u32   description_off;        /* optional description string*=
/
> >         __u32   crc;                    /* crc32 of BTF */
> >         __u32   base_crc;               /* crc32 of base BTF */
> > };
> >
> > For the original version, kind_meta_offset would just be
> > at meta_off + sizeof(struct btf_metadata), but if we had multiple
> > versions of the btf_metadata header to handle, they could all rely on
> > the kind_meta_offset being where kind metadata is stored.
> > For validation we'd have to make sure kind_meta_offset was within
> > the the metadata header range.
>
> kind_meta_offset is an ok idea, but I don't quite see why we'd have
> multiple 'struct btf_metadata' pointing to the same set of 'struct
> btf_kind_meta'.
>
> Also why do we need description_off ? Shouldn't string go into
> btf_header->str_off ?
>
> > >
> > >> +    __u32   flags;
> > >> +    __u32   description_off;        /* optional description string =
*/
> > >> +    __u32   crc;                    /* crc32 of BTF */
> > >> +    __u32   base_crc;               /* crc32 of base BTF */
> > >
> > > Hard coded CRC also gives me a pause.
> > > Should it be an optional KIND like btf tags?
> >
> > The goal of the CRC is really just to provide a unique identifier that
> > we can use for things like checking if there's a mismatch between
> > base and module BTF. If we want to ever do CRC validation (not sure
> > if there's a case for that) we probably need to think about cases like
> > BTF sanitization of BPF program BTF; this would likely only be an
> > issue if metadata support is added to BPF compilers.
> >
> > The problem with adding it via a kind is that if we first compute
> > the CRC over the entire BTF object and then add the kind, the addition
> > of the kind breaks the CRC; as a result I _think_ we're stuck with
> > having to have it in the header.
>
> Hmm. libbpf can add BTF_KIND_CRC with zero-ed u32 crc field
> and later fill it in.
> It's really not different than u32 crc field inside 'struct btf_metadata'=
.
>
> > That said I don't think CRC is necessarily the only identifier
> > we could use, and we don't even need to identify it as a
> > CRC in the UAPI, just as a "unique identifier"; that would deal
> > with issues about breaking the CRC during sanitization. All
> > depends on whether we ever see a need to verify BTF via CRC
> > really.
>
> Right. It could be sha or anything else, but user space and kernel
> need to agree on the math to compute it, so something got to indicate
> that this 32-bit is a crc.
> Hence KIND_CRC, KIND_SHA fit better.

what if instead of crc and base_src fields, we have

__u32 id_str_off;
__u32 base_id_str_off;

and they are offsets into a string section. We can then define that
those strings have to be something like "crc:<crc-value>" or
"sha:<sha-value". This will be a generic ID, and extensible (and more
easily extensible, probably), but won't require new KIND.

This also has a good property that 0 means "no ID", which helps with
the base BTF case. Current "__u32 crc;" doesn't have this property and
requires a flag.

