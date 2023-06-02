Return-Path: <bpf+bounces-1743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B94720A60
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 22:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D961C2125B
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 20:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3565224;
	Fri,  2 Jun 2023 20:34:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F68D2F33
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 20:34:11 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7297D1BE
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 13:34:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9700219be87so358546166b.1
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685738048; x=1688330048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rev4VG9g0dJPCrfiewlsFg+DBffNV1pL1pXSQ0dIZC8=;
        b=qQObyCxOugfFx5Ci+3IO9n73Wa7PPB7W/aSR/Q3bsbThXud8hhlb3GHoZrDLGRUa6d
         Q2YY269mUs1IXes8/h94nsXK9inIh7/Ayo97VdeS0jY2Ka3RiiRLd2+HQUgKiAuVAXu5
         mVHlP0WzF6JSMwIlNL0wx3Lqpteui0lqjYwdWoCKPj5EiEcpNgGVTC4lIqoP20GaaHoW
         TbfakxID2PM+8EliOqE8JsPLyxRm3ihjUXYHxDfJ/mS6AHSuVbY+Q9YTmZNTs5i4SW2u
         L5PmSOg5542xRKDjWDd695moDVDDeqw/WdVhgxJf4oawlJZDz1IB1lY/1XTKAjKWZIO6
         +lVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685738048; x=1688330048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rev4VG9g0dJPCrfiewlsFg+DBffNV1pL1pXSQ0dIZC8=;
        b=MH8AtWBpKB+w2axymKk4KsEulHdlszDw5XaP7v6rPrZTj+L8b7J1dgXRuqTu4VEorm
         pNsI1+3t99FarFsLu4hKRacRsVdMPL3UTfd1/utrOf6ygJTJUWNjfCT8XC1lvlj1y49X
         uY7ZVE1zp5FOzEPQ6AU8it6hEyyB/8x0ix4IL2LDw1652o5fzudYQMYbM9JI2m32Lb+2
         RRs/h9QTOtXJp+mrKVC967/s7et13/821lIxcFTytswOg0Xw3N+xMB6puk0JzPRv7U3b
         6vVbKYc5ZfNOD3uwil4NimNDIvZkRAGv5j1Fe6fBND0p9UDRvPrqivhgs0JF6t3iEP8w
         tJ/Q==
X-Gm-Message-State: AC+VfDy6LeKjLDxwV5OwkFhdvZJBPZTBf5+56NB4rOpjmXOO6ZaESKzy
	9BMl4cOfs173wZL8YaqvT/DPtdashtDmwpkeDgo=
X-Google-Smtp-Source: ACHHUZ7nPNqwZLd/rSrBFUw8UWmm46Y6E37slVDmRCKWO31ak2PkupZpmBZE3APZXGAmOV/2WVH7LTyLSLZyU8iGJg8=
X-Received: by 2002:a17:907:724a:b0:957:12a6:a00f with SMTP id
 ds10-20020a170907724a00b0095712a6a00fmr11406862ejc.21.1685738047610; Fri, 02
 Jun 2023 13:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com> <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com> <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
 <CAEf4BzZaUEqYnyBs6OqX2_L_X=U4zjrKF9nPeyyKp7tRNVLMww@mail.gmail.com> <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com>
In-Reply-To: <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 2 Jun 2023 13:33:55 -0700
Message-ID: <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
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

On Fri, Jun 2, 2023 at 11:12=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 2, 2023 at 9:32=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Jun 1, 2023 at 9:54=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Jun 1, 2023 at 3:38=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> > > >
> > > > On 01/06/2023 04:53, Alexei Starovoitov wrote:
> > > > > On Wed, May 31, 2023 at 09:19:28PM +0100, Alan Maguire wrote:
> > > > >> BTF kind metadata provides information to parse BTF kinds.
> > > > >> By separating parsing BTF from using all the information
> > > > >> it provides, we allow BTF to encode new features even if
> > > > >> they cannot be used.  This is helpful in particular for
> > > > >> cases where newer tools for BTF generation run on an
> > > > >> older kernel; BTF kinds may be present that the kernel
> > > > >> cannot yet use, but at least it can parse the BTF
> > > > >> provided.  Meanwhile userspace tools with newer libbpf
> > > > >> may be able to use the newer information.
> > > > >>
> > > > >> The intent is to support encoding of kind metadata
> > > > >> optionally so that tools like pahole can add this
> > > > >> information.  So for each kind we record
> > > > >>
> > > > >> - a kind name string
> > > > >> - kind-related flags
> > > > >> - length of singular element following struct btf_type
> > > > >> - length of each of the btf_vlen() elements following
> > > > >>
> > > > >> In addition we make space in the metadata for
> > > > >> CRC32s computed over the BTF along with a CRC for
> > > > >> the base BTF; this allows split BTF to identify
> > > > >> a mismatch explicitly.  Finally we provide an
> > > > >> offset for an optional description string.
> > > > >>
> > > > >> The ideas here were discussed at [1] hence
> > > > >>
> > > > >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > > >>
> > > > >> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDw=
rgX4bn=3DNuc1g8JPFC34MA@mail.gmail.com/
> > > > >> ---
> > > > >>  include/uapi/linux/btf.h       | 29 +++++++++++++++++++++++++++=
++
> > > > >>  tools/include/uapi/linux/btf.h | 29 +++++++++++++++++++++++++++=
++
> > > > >>  2 files changed, 58 insertions(+)
> > > > >>
> > > > >> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> > > > >> index ec1798b6d3ff..94c1f4518249 100644
> > > > >> --- a/include/uapi/linux/btf.h
> > > > >> +++ b/include/uapi/linux/btf.h
> > > > >> @@ -8,6 +8,34 @@
> > > > >>  #define BTF_MAGIC   0xeB9F
> > > > >>  #define BTF_VERSION 1
> > > > >>
> > > > >> +/* is this information required? If so it cannot be sanitized s=
afely. */
> > > > >> +#define BTF_KIND_META_OPTIONAL              (1 << 0)
> >
> > Another flag I was thinking about was a flag whether struct btf_type's
> > type/size field is a type or a size (or something else). E.g., let's
> > say we haven't had btf_type_tag yet and were adding it after we had
> > this new metadata. We could say that type_tag's type/size field is
> > actually a type ID, and generic tools like bpftool could basically
> > skip type_tag and resolve to underlying type. This way, optional
> > modifier/decorator KINDs won't even have to break applications using
> > old libbpf's when it comes to calculating type sizes and resolving
> > them.
>
> +1
>
> > > > >> +
> > > > >> +struct btf_kind_meta {
> > > > >> +    __u32 name_off;         /* kind name string offset */
> >
> > I'm not sure why we'd need to record this for every KIND? The tool
> > that doesn't know about this new kind can't do much about it anyways,
> > so whether it knows that this is "KIND_NEW_FANCY" or just its ID #123
> > doesn't make much difference?
>
> The name is certainly more meaningful than 123.
> bpftool output is consumed by humans who will be able to tell the differe=
nce.
> I'd keep the name here.

Ok, it's fine. When I was originally proposing this compact metadata,
I was trying to make it as minimal as possible, so adding 80 bytes
just for string offset fields (plus a bunch of strings) felt like an
unnecessary overhead. But it's not a big deal.

>
> > > > > and would bump the BTF_VERSION to 2 to make it a 'milestone'.
> >
> > Bumping BTF_VERSION to 2 automatically makes BTF incompatible with all
> > existing kernels (and potentially many tools that parse BTF). Given we
> > can actually extend BTF in backwards compatible way by just adding an
> > optional two fields to btf_header + extra bytes for metadata sections,
> > why making our lives harder by bumping this version?
>
> I fail to see how bumping the version makes it harder.
> libbpf needs to sanitize meta* fields in the struct btf_header on
> older kernels anway. At the same time sanitizing the version from 2 to
> 1
> in the same header is one extra line of code in libbpf.
> What am I missing?

So I checked libbpf code, and libbpf doesn't really check the version
field. So for the most part this BTF_VERSION bump wouldn't matter for
any tool that's based on libbpf's struct btf API. But if libbpf did
check version (as it probably should have), then by upgrading to newer
Clang that would emit BTF with this metadata (but no new fancy
BTF_KIND_KERNEL_FUNC or anything like that), we automatically make
such BTF incompatible with all those tools.

Kernel is a bit different because it's extremely strict about BTF. I'm
more worried about tools like bpftool (but we don't check BTF_VERSION
there due to libbpf), llvm-objdump (when it supports BTF), etc.

On the other hand, what do we gain by bumping this BTF_VERSION?

>
> >
> > > > > v2 -> self described.
> > > >
> > > > sure, sounds good. One other change perhaps worth making; currently
> > > > we assume that the kind metadata is at the end of the struct
> > > > btf_metadata, but if we ever wanted to add metadata fields in the
> > > > future, we'd want so support both the current metadata structure an=
d
> > > > any future structure which had additional fields.
> >
> > see above, another reason to make metadata a separate section, in
> > addition to types and strings
> >
> > > >
> > > > With that in mind, it might make sense to go with something like
> > > >
> > > > struct btf_metadata {
> > > >         __u32   kind_meta_cnt;
> > > >         __u32   kind_meta_offset;       /* kind_meta_cnt instances =
of struct
> > > > btf_kind_meta start here */
> > > >         __u32   flags;
> > > >         __u32   description_off;        /* optional description str=
ing*/
> > > >         __u32   crc;                    /* crc32 of BTF */
> > > >         __u32   base_crc;               /* crc32 of base BTF */
> > > > };
> > > >
> > > > For the original version, kind_meta_offset would just be
> > > > at meta_off + sizeof(struct btf_metadata), but if we had multiple
> > > > versions of the btf_metadata header to handle, they could all rely =
on
> > > > the kind_meta_offset being where kind metadata is stored.
> > > > For validation we'd have to make sure kind_meta_offset was within
> > > > the the metadata header range.
> > >
> > > kind_meta_offset is an ok idea, but I don't quite see why we'd have
> > > multiple 'struct btf_metadata' pointing to the same set of 'struct
> > > btf_kind_meta'.
> > >
> > > Also why do we need description_off ? Shouldn't string go into
> > > btf_header->str_off ?
> > >
> > > > >
> > > > >> +    __u32   flags;
> > > > >> +    __u32   description_off;        /* optional description str=
ing */
> > > > >> +    __u32   crc;                    /* crc32 of BTF */
> > > > >> +    __u32   base_crc;               /* crc32 of base BTF */
> > > > >
> > > > > Hard coded CRC also gives me a pause.
> > > > > Should it be an optional KIND like btf tags?
> > > >
> > > > The goal of the CRC is really just to provide a unique identifier t=
hat
> > > > we can use for things like checking if there's a mismatch between
> > > > base and module BTF. If we want to ever do CRC validation (not sure
> > > > if there's a case for that) we probably need to think about cases l=
ike
> > > > BTF sanitization of BPF program BTF; this would likely only be an
> > > > issue if metadata support is added to BPF compilers.
> > > >
> > > > The problem with adding it via a kind is that if we first compute
> > > > the CRC over the entire BTF object and then add the kind, the addit=
ion
> > > > of the kind breaks the CRC; as a result I _think_ we're stuck with
> > > > having to have it in the header.
> > >
> > > Hmm. libbpf can add BTF_KIND_CRC with zero-ed u32 crc field
> > > and later fill it in.
> > > It's really not different than u32 crc field inside 'struct btf_metad=
ata'.
> > >
> > > > That said I don't think CRC is necessarily the only identifier
> > > > we could use, and we don't even need to identify it as a
> > > > CRC in the UAPI, just as a "unique identifier"; that would deal
> > > > with issues about breaking the CRC during sanitization. All
> > > > depends on whether we ever see a need to verify BTF via CRC
> > > > really.
> > >
> > > Right. It could be sha or anything else, but user space and kernel
> > > need to agree on the math to compute it, so something got to indicate
> > > that this 32-bit is a crc.
> > > Hence KIND_CRC, KIND_SHA fit better.
> >
> > what if instead of crc and base_src fields, we have
> >
> > __u32 id_str_off;
> > __u32 base_id_str_off;
> >
> > and they are offsets into a string section. We can then define that
> > those strings have to be something like "crc:<crc-value>" or
> > "sha:<sha-value". This will be a generic ID, and extensible (and more
> > easily extensible, probably), but won't require new KIND.
>
> Encoding binary data in strings with \0 and other escape chars?
> Ouch. Please no.
> We can have variable size KIND_ID and encode crc vs sha in flags,
> but binary data better stay binary.

It's just a string representation of a hex dump of a byte array (or
u32 in crc32 case)? Only one of [0123456789abcdef], that's all. Just
like we have Git SHA string representation.

We don't have variable-sized KINDs, unless you are proposing to use
vlen as "number of bytes" of ID payload. And another KIND is
automatically breaking backwards compat for all existing tools. For no
good reason. This whole metadata is completely optional right now for
anything that's using libbpf for BTF parsing. But adding KIND_ID makes
it not optional at all.

Not sure what new KIND gives us in this case. This ID (whether it's
"crc:abcdef" or just "661866dbea52bfac7420cd35d0e502d4ccc11bb6" or
whatever) can be used by all application as is for comparison, you
don't need to understand how it is generated at all.

>
> > This also has a good property that 0 means "no ID", which helps with
> > the base BTF case. Current "__u32 crc;" doesn't have this property and
> > requires a flag.
>
> imo this crc addition is a litmus test for this self-described format.
> If we cannot encode it as a new KIND* it means this self-described
> idea is broken.

We can, but this can be a straightforward and simple *opaque* string
ID, so the new kind just seems unnecessary.

