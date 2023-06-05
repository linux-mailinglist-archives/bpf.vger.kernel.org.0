Return-Path: <bpf+bounces-1888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AEB723346
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 00:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4581A1C20CB7
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 22:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797F209BD;
	Mon,  5 Jun 2023 22:38:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95807C2F5
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 22:38:20 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306ADF3
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 15:38:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso8250673a12.0
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686004696; x=1688596696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IyyKkgWZUhPENbVCf+Ghk49spIYKCf2YD1F/gmgSwQ=;
        b=Tjqrs6jK9koYQd1qVYZVDoRIAiTKWNeFVzo0ss/23yuQsa0M/QMJKZGZpgMISi82Ys
         t+vDMALo/xVOTYV57HnJOdjXqGe0yrEt+2kbCXYPeV5AJJLOU9opKfeCZyPc0Ax/mbpd
         MgHbgGaZheCSpN2p+R80eCogB3uiNLTLbGTb6lDsCl1fc/WUuriFCok105X9JN+MGDwk
         xaglfYa+5+Bapk+GNIDgjEF1tOZaBWXben99cF6C1DJtGB2yWO6nARURkEaD6T4CaaCi
         kgzD2DujgKGEbRLxmDxzg3i3J/OLFyxbGerPHlHa7Jp6EiZoiAynxDTZqZs6nEvmrWNG
         mWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004696; x=1688596696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IyyKkgWZUhPENbVCf+Ghk49spIYKCf2YD1F/gmgSwQ=;
        b=AED9+RIMvwZinb7xZn/RCMoxwfimJJP2Z46KHXG3d2NxvBJrpzFqS5a1NzGE9MS0e2
         RlpZNUftq3aj0iHqVCdrQ/qT4TxYHa1PtHZLBtKrWaqKRXTl1VbglsrE8YIgZSTz/Kia
         77P0UeciVtypzWbTSP70PXuAMKFOIEl5IAeF9feT9vMOYD0wmwwwXxFtcqkQ6tYfHVwu
         J6BgS4dx+kXlKW04V2TYsWf8IAtM2LZ4jfl0UAJmZjxF0LknjgdKf3cXJpQp/Bq9gwVA
         SpbBTGgRL/+Q1pL3Q0a0tYXb0L1bqMJuQgqouHn+zmXvPQcPBO2su03qQNvRNomZ9Jum
         ASqg==
X-Gm-Message-State: AC+VfDwQWcezMvc1EaxxugrZfnYpJvsloay3uXobvCwNhkfIm+uIumaw
	+qJOHBA7GfR5lLnaRzEOSAXYWncYEyTeDv93nAU=
X-Google-Smtp-Source: ACHHUZ5hy+TBHlhJmAvruuIbw9tAo1uX9tpTTc4m4BjwxrNFwSe1/P929LiE8OA33tyo2hk/9QW3mAf2wRWrfz+v0VE=
X-Received: by 2002:aa7:dc19:0:b0:50b:c89f:f381 with SMTP id
 b25-20020aa7dc19000000b0050bc89ff381mr323740edu.29.1686004696298; Mon, 05 Jun
 2023 15:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com> <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com> <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
 <CAEf4BzZaUEqYnyBs6OqX2_L_X=U4zjrKF9nPeyyKp7tRNVLMww@mail.gmail.com>
 <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com>
 <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com> <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
In-Reply-To: <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 5 Jun 2023 15:38:04 -0700
Message-ID: <CAEf4Bzbtptc9DUJ8peBU=xyrXxJFK5=rkr3gGRh05wwtnBZ==A@mail.gmail.com>
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

On Mon, Jun 5, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 2, 2023 at 1:34=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > >
> > > > > > >> +
> > > > > > >> +struct btf_kind_meta {
> > > > > > >> +    __u32 name_off;         /* kind name string offset */
> > > >
> > > > I'm not sure why we'd need to record this for every KIND? The tool
> > > > that doesn't know about this new kind can't do much about it anyway=
s,
> > > > so whether it knows that this is "KIND_NEW_FANCY" or just its ID #1=
23
> > > > doesn't make much difference?
> > >
> > > The name is certainly more meaningful than 123.
> > > bpftool output is consumed by humans who will be able to tell the dif=
ference.
> > > I'd keep the name here.
> >
> > Ok, it's fine. When I was originally proposing this compact metadata,
> > I was trying to make it as minimal as possible, so adding 80 bytes
> > just for string offset fields (plus a bunch of strings) felt like an
> > unnecessary overhead. But it's not a big deal.
>
> Exactly. It's just 4 * num_kinds bytes in and ~20 * num_kinds for
> names, but it implements 'self description'.
> Otherwise the names become an external knowledge and BTF is not self desc=
ribed.
>
>
> > >
> > > > > > > and would bump the BTF_VERSION to 2 to make it a 'milestone'.
> > > >
> > > > Bumping BTF_VERSION to 2 automatically makes BTF incompatible with =
all
> > > > existing kernels (and potentially many tools that parse BTF). Given=
 we
> > > > can actually extend BTF in backwards compatible way by just adding =
an
> > > > optional two fields to btf_header + extra bytes for metadata sectio=
ns,
> > > > why making our lives harder by bumping this version?
> > >
> > > I fail to see how bumping the version makes it harder.
> > > libbpf needs to sanitize meta* fields in the struct btf_header on
> > > older kernels anway. At the same time sanitizing the version from 2 t=
o
> > > 1
> > > in the same header is one extra line of code in libbpf.
> > > What am I missing?
> >
> > So I checked libbpf code, and libbpf doesn't really check the version
> > field. So for the most part this BTF_VERSION bump wouldn't matter for
> > any tool that's based on libbpf's struct btf API. But if libbpf did
> > check version (as it probably should have), then by upgrading to newer
> > Clang that would emit BTF with this metadata (but no new fancy
> > BTF_KIND_KERNEL_FUNC or anything like that), we automatically make
> > such BTF incompatible with all those tools.
> >
> > Kernel is a bit different because it's extremely strict about BTF. I'm
> > more worried about tools like bpftool (but we don't check BTF_VERSION
> > there due to libbpf), llvm-objdump (when it supports BTF), etc.
> >
> > On the other hand, what do we gain by bumping this BTF_VERSION?
>
> The version bump will be an indication that
> v2 of BTF has enough info in the format for any tool/kernel to consume it=
.
> With v2 we should make BTF_KIND_META description mandatory.
> If we keep it as v1 then the presence of BTF_KIND_META would be
> an indication of 'self described' format.
> Which is also ok-ish, but seems less clean.
> zero vs not-zero of meta_off in btf_header is pretty much v1 vs v2.
>

We had a long offline discussion w/ Alexei about this whole
self-describing BTF, and I will try to summarize it here a bit,
because I think we both think about "self-describing" differently, and
as a result few different aspects are conflated with each other (there
are at least 3(!) different things here).

From my perspective, this self-describing BTF metadata was purely
designed to allow tools without latest BTF knowledge to be able to
skip over unknown BTF_KIND_xxx, at most being able to tell whether
it's critical for understanding BTF (that's the OPTIONAL flag) or not.
I.e., with older bpftool (but the one that knows about btf_metadata,
of course), it would still be possible to `bpftool btf dump file
<file-with-newer-btf-kinds>` just fine, except for new KINDS (which
would be just emitted as "unknown BTF_KIND_XXX, skipping...".

I think this problem is solved with this fixed + per-vlen sz and those
few extra flags. No one seems to deny this.

Now, crc/id and self-describing BTF in Alexei's sense. We can merge
them together, or we can skip them separately. Let's start with
Alexei's self-describing BTF in general.

His view is that we need some sort of way to keep adding new
information about BTF itself in a way that will be parsable by older
tools, and at the very least printable by those tools so that humans
can get this information. Sort of like a generic JSON-like format, but
encoded in BTF. As one of the example of using that might be `"crc" :
123123123` which would describe BTF's checksum.

Alexei's proposal is to add new BTF_KIND_xxx for each such new piece
of information, and given part #1 (information how to skip over this
new KIND), it would be an extensible mechanism. And while I agree that
it's one way to do this, I don't see how a generic tool like bpftool
can make any of that really printable, short of just hex-dumping an
entire new KIND contents, which doesn't seem to be very
human-readable.

But. If we think we need something like this generic metadata format,
I propose we add *one* new kind to describe it. Let's call it the
BTF_KIND_METADATA (or whatever) kind. It will/can have a name
(btf_type.name_off), and it has vlen items. Each item can be described
as:

struct bpf_metadata_item {
    __u32 key_off; /* key string */
    union {
        __u32 value_off; /* value string */
        __u32 value_type_id; /* type ID of a value of this item */
    }
    __u32 flags;
};


Each metadata_item represents one key:value pair, where key is always
described with a string ("id", "base_id", "something_fancy", etc), and
value can be interpreted based on flags. If one flag is set (e.g.,
BTF_METADATA_STR), it's a string offset, if, say, BTF_METADATA_TYPE,
then value_type_id points to another KIND describing value (it could
be another BTF_KIND_METADATA to create nested structures, if
necessary). We can reuse value_off/value_type_id also for 4-byte
integer value and whatever else, all based on flags. We can anticipate
arrays, if we want to. The point is not to completely design it here,
though.

Such approach will allow us to teach all tools about this data
structure once and just keep adding new items and codifying their key
names and semantics of the value. And we won't have to change bpftool
and such just to teach about new "some_fancy_key2" item.

With that, I'd argue we should also add new `__u32 metadata_id;` field
to `struct btf_metadata_header` to directly point to such root
type/kind, instead of doing linear search (which is especially
problematic with nested JSON-like structure, if we choose to do it).

This should satisfy Alexei's desire to have self-describing BTF in his
"self-describing" meaning. We'll get a generic bag of key:value pairs,
including nested objects.


Now, third. Regarding CRC, ID, etc. While the above metadata can
describe that, and we can just codify that, say "id" key is BTF's own
checksum/id, and "base_id" is checksum/id of expected base BTF. I
think the concept of ID is simple enough and important enough for
modules BTF and base/split BTF itself that it justifies having
dedicated two fields in btf_metadata_header for it, without
indirection of extra new KINDs.

As for binary vs string. I think most people don't think about GIT SHA
as array of bytes, and rather it's just a unique string, because we
work with them as strings in everyday life. So I think similarly here
it would be totally fine to just say that ID is a string (and we can
just hard-code SHA as an algorithm, or use this "algo:value" format of
a string), and keep things simple and straightforward for ID and base
ID.

Similarly, I think the whole bumping of V2 and adding new kinds just
for ID is just adding more complications for existing tooling, while
we can easily make new BTF be still consumable by old bpftool and
other tools. All that because libbpf is ignoring stuff in btf_header
past str_len field, so even if pahole or Clang start emitting metadata
describing btf_type byte size (fixed + per-vlen sizes), all that will
be backwards compatible with existing versions of tools.

The beauty of such an approach is that we can teach Clang to emit this
size metadata + ID today without breaking any of the existing
libbpf-based tooling (and I suspect other tooling dealing with BTF as
well, unless they chose to be as strict as kernel with unknown BTF
header fields). And libbpf will sanitize such BTF for old kernels
automatically like it does today with various KINDs that old kernel
don't understand. It will be a no-brainer to enable this
functionality, we won't even need a new option for Clang or pahole.
And then when we need to add yet more generic metadata, we can start
utilizing BTF_KIND_METADATA.

Sorry for the wall of text. At least I think I also addressed all the
below comments and won't write more text. :)


Thoughts?


> >
> > We don't have variable-sized KINDs, unless you are proposing to use
> > vlen as "number of bytes" of ID payload.
>
> Exactly. I'm proposing BTF_KIND_CHECKSUM and use vlen for size.
>
> > And another KIND is
> > automatically breaking backwards compat for all existing tools.
>
> No. That's the whole point of 'self described'.
> New kinds will not be breaking.
>
> > For no
> > good reason. This whole metadata is completely optional right now for
> > anything that's using libbpf for BTF parsing. But adding KIND_ID makes
> > it not optional at all.
>
> and that's the crux of our disagreement.
> If BTF_KIND_META are optional it's just a glorified comment inside BTF an=
d
> not a new 'self described' format.
> If it's just a comment I'd rather not add it to BTF.
> Such debug info can go to BTF.ext or don't do it at all.
>
> The self described BTF would mean that struct btf_kind_meta-s contain
> enough info for tools to parse from now on.
> Imagine we didn't need CRC right now.
> The self described format lands and now we want to add CRC.
> If we're saying: "let's add a few hard coded fields to struct btf_header
> or struct btf_metadata" then we failed.
> It's not a self described format if we still need to extend hard coded
> structs.
> The idea of self description is that struct btf_kind_meta-s describe
> absolutely everything about BTF from now on.
> Meaning that not only things like ENUM64 and FUNC with addresses
> become new KINDs, but crc-s and everything else is a new kind too,
> because that's the only thing that btf_kind_meta-s can describe.
>
> > Not sure what new KIND gives us in this case. This ID (whether it's
> > "crc:abcdef" or just "661866dbea52bfac7420cd35d0e502d4ccc11bb6" or
> > whatever) can be used by all application as is for comparison, you
> > don't need to understand how it is generated at all.
>
> That's fine. tools don't need to parse it.
> With BTF_KIND_CHECKSUM the tools will just compare vlen sized binary data=
.
>
> > >
> > > > This also has a good property that 0 means "no ID", which helps wit=
h
> > > > the base BTF case. Current "__u32 crc;" doesn't have this property =
and
> > > > requires a flag.
> > >
> > > imo this crc addition is a litmus test for this self-described format=
.
> > > If we cannot encode it as a new KIND* it means this self-described
> > > idea is broken.
> >
> > We can, but this can be a straightforward and simple *opaque* string
> > ID, so the new kind just seems unnecessary.
>
> BTF_KIND_CHECKSUM can have a string in vlen part of it, but
> it feels wrong to encode binary data as a string while everything else
> in BTF is binary.

