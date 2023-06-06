Return-Path: <bpf+bounces-1940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633EB724982
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 18:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B061C20AF8
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29E21ED2B;
	Tue,  6 Jun 2023 16:50:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F819915
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 16:50:58 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD110E6B
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 09:50:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-97454836448so834243766b.2
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686070255; x=1688662255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JosmGIyKYcue+Sptn+rDh2BoaksYeVnLxthEV8Q3z68=;
        b=dbLbrygGNkB9bgVtlzjojE95fGEBKvNouwwacseLLvSYkod8dbs5l+QyTDHVAA40j3
         0d43GoPrNQ/YXo30GrOgIrduI3vQBR0uQcxwzi7Si0RQC3tOhGUCY1N/AtKQ94ilbyLc
         qDvy85tBfNDUMYGWmKA5oUQM8JratQiTE1UAPvg4BVKi0KWFP1VK/+4tipF7IqAGocPn
         oNk93q2ABJ92C3UpqcVn8xsdUD5+3/vFcz15Q2Y/yyH7ftsHcnPKaE4l/CgmDJfYUpwC
         udHp3WQKRkIDiTIV1GooP5kr7KCl4cvHLeCpEC+gDxxAz42n7KCthL6zsmZUeTGLoOee
         RRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686070255; x=1688662255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JosmGIyKYcue+Sptn+rDh2BoaksYeVnLxthEV8Q3z68=;
        b=DBETMKmaO9eY/C4h+5HX6FPhm2O/IzLv91OR2XnKgAX7psCjXvVR3NN9JBdaWyRcPF
         GPNM9RSWjjswBqctPVh88Tzqg1dM6SQUl1q2yrpQSRcj1LFIQYUzPCxbqRsj4dJe+Vb7
         5rxxcww8qtIWG1ytUW8HevOqTSOJIN9EqzyOqbHqkVpQFkDL9eMyJeo1QsyzarkCRNCu
         DaV/haJiPoT6muoLPsbld2LitImMKzBvHzgZBpxbuTyHbpGrCmyUVQWmAV4pTv6Z4hn/
         XIvBNOIGKaDHBLve8dsbEj56MTq10Cso9SsXXRV/CTdl/P3+GYvL65ZMoQCrXlL110Po
         XbBg==
X-Gm-Message-State: AC+VfDwzxh/sBItD2Ntlg6h1JnCQEZj3E61rx3UJFNBqu3MLsyiMa8YV
	UJlLcvGvvbbsT+OVGLX22zAcU5xmnxYXu4ekBpI=
X-Google-Smtp-Source: ACHHUZ5olLnt2lI/7Z96mEWLiEJbuupPGUcYqzU9dQbCZy7/2mZOvzuJBC0dZFYWfCYnvzDBplk3wEDFB6EeA7fzj2w=
X-Received: by 2002:a17:906:c155:b0:973:d06d:545f with SMTP id
 dp21-20020a170906c15500b00973d06d545fmr3125005ejc.24.1686070254820; Tue, 06
 Jun 2023 09:50:54 -0700 (PDT)
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
 <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
 <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
 <CAEf4Bzbtptc9DUJ8peBU=xyrXxJFK5=rkr3gGRh05wwtnBZ==A@mail.gmail.com> <CAADnVQJAmYgR91WKJ_Jif6c3ja=OAmkMXoUO9sTnmp-xmnbVJQ@mail.gmail.com>
In-Reply-To: <CAADnVQJAmYgR91WKJ_Jif6c3ja=OAmkMXoUO9sTnmp-xmnbVJQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 6 Jun 2023 09:50:42 -0700
Message-ID: <CAEf4BzYG2FFcM_0mkiARzKnYinQYHpWE8ct35Z==-Fsefv9oQw@mail.gmail.com>
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

On Mon, Jun 5, 2023 at 7:46=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jun 5, 2023 at 3:38=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Jun 5, 2023 at 9:15=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jun 2, 2023 at 1:34=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > >
> > > > > > > > >> +
> > > > > > > > >> +struct btf_kind_meta {
> > > > > > > > >> +    __u32 name_off;         /* kind name string offset =
*/
> > > > > >
> > > > > > I'm not sure why we'd need to record this for every KIND? The t=
ool
> > > > > > that doesn't know about this new kind can't do much about it an=
yways,
> > > > > > so whether it knows that this is "KIND_NEW_FANCY" or just its I=
D #123
> > > > > > doesn't make much difference?
> > > > >
> > > > > The name is certainly more meaningful than 123.
> > > > > bpftool output is consumed by humans who will be able to tell the=
 difference.
> > > > > I'd keep the name here.
> > > >
> > > > Ok, it's fine. When I was originally proposing this compact metadat=
a,
> > > > I was trying to make it as minimal as possible, so adding 80 bytes
> > > > just for string offset fields (plus a bunch of strings) felt like a=
n
> > > > unnecessary overhead. But it's not a big deal.
> > >
> > > Exactly. It's just 4 * num_kinds bytes in and ~20 * num_kinds for
> > > names, but it implements 'self description'.
> > > Otherwise the names become an external knowledge and BTF is not self =
described.
> > >
> > >
> > > > >
> > > > > > > > > and would bump the BTF_VERSION to 2 to make it a 'milesto=
ne'.
> > > > > >
> > > > > > Bumping BTF_VERSION to 2 automatically makes BTF incompatible w=
ith all
> > > > > > existing kernels (and potentially many tools that parse BTF). G=
iven we
> > > > > > can actually extend BTF in backwards compatible way by just add=
ing an
> > > > > > optional two fields to btf_header + extra bytes for metadata se=
ctions,
> > > > > > why making our lives harder by bumping this version?
> > > > >
> > > > > I fail to see how bumping the version makes it harder.
> > > > > libbpf needs to sanitize meta* fields in the struct btf_header on
> > > > > older kernels anway. At the same time sanitizing the version from=
 2 to
> > > > > 1
> > > > > in the same header is one extra line of code in libbpf.
> > > > > What am I missing?
> > > >
> > > > So I checked libbpf code, and libbpf doesn't really check the versi=
on
> > > > field. So for the most part this BTF_VERSION bump wouldn't matter f=
or
> > > > any tool that's based on libbpf's struct btf API. But if libbpf did
> > > > check version (as it probably should have), then by upgrading to ne=
wer
> > > > Clang that would emit BTF with this metadata (but no new fancy
> > > > BTF_KIND_KERNEL_FUNC or anything like that), we automatically make
> > > > such BTF incompatible with all those tools.
> > > >
> > > > Kernel is a bit different because it's extremely strict about BTF. =
I'm
> > > > more worried about tools like bpftool (but we don't check BTF_VERSI=
ON
> > > > there due to libbpf), llvm-objdump (when it supports BTF), etc.
> > > >
> > > > On the other hand, what do we gain by bumping this BTF_VERSION?
> > >
> > > The version bump will be an indication that
> > > v2 of BTF has enough info in the format for any tool/kernel to consum=
e it.
> > > With v2 we should make BTF_KIND_META description mandatory.
> > > If we keep it as v1 then the presence of BTF_KIND_META would be
> > > an indication of 'self described' format.
> > > Which is also ok-ish, but seems less clean.
> > > zero vs not-zero of meta_off in btf_header is pretty much v1 vs v2.
> > >
> >
> > We had a long offline discussion w/ Alexei about this whole
> > self-describing BTF, and I will try to summarize it here a bit,
> > because I think we both think about "self-describing" differently, and
> > as a result few different aspects are conflated with each other (there
> > are at least 3(!) different things here).
>
> Thanks for summarizing. All correct.
>
> > From my perspective, this self-describing BTF metadata was purely
> > designed to allow tools without latest BTF knowledge to be able to
> > skip over unknown BTF_KIND_xxx, at most being able to tell whether
> > it's critical for understanding BTF (that's the OPTIONAL flag) or not.
> > I.e., with older bpftool (but the one that knows about btf_metadata,
> > of course), it would still be possible to `bpftool btf dump file
> > <file-with-newer-btf-kinds>` just fine, except for new KINDS (which
> > would be just emitted as "unknown BTF_KIND_XXX, skipping...".
> >
> > I think this problem is solved with this fixed + per-vlen sz and those
> > few extra flags.
>
> I'm fine with this approach as long as we don't fool ourselves that
> we're doing a "self described" format.
> We have a "size" field in btf_header. With this btf_metadata extension
> we're effectively adding "size" fields for each btf kind and its vlen par=
t.
> So what Alan proposed:
> +struct btf_kind_meta {
> +       __u16 flags;            /* see BTF_KIND_META_* values above */
> +       __u8 info_sz;           /* size of singular element after btf_typ=
e */
> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements *=
/
> +};
>
> _without_ name_off it makes the most sense.

Yep. I didn't see much need for name_off as well.

>
> As soon as we're trying to add 'name_off' to the kind we're falling into
> the trap of thinking that we're adding "self described" format and
> btf_kind_meta needs to actually describe it for printing (with
> real name and not just integer id) and further trying to describe
> semantics of unknown kind with another flag that Andrii's proposed:
> "Another flag I was thinking about was a flag whether struct btf_type's
> type/size field is a type or a size (or something else)."
>
> imo name_off and that other flag in addition to optional_or_not flag
> are carrying the concept too far.
>
> We should just say upfront that this "struct btf_kind_meta" is to be
> able to extend BTF easier and nothing else.

Yep, that was precisely (at least my) intent. It's great that we are
converging on this.


> "old" bpftool will be able to skip unknown kinds, but dedup
> probably won't be able to skip much anyway.

Agreed, I don't think we can ever make BTF dedup work reliably with
KINDs it doesn't understand. I wouldn't even try. I'd also say that
kernel should keep being strict about this (even if we add
"is-it-optional" field, kernel can't trust it). Libbpf and other
libraries will have to keep sanitizing BTF anyways.

I'm also ok with dropping "optional_or_not" flag. Same for
"does-it-point-to-type" flag. I can see some use for the latter (e.g.,
still being able to calculate sizes and stuff), but it's nothing super
critical, IMO.

>
> I'd also call it "struct btf_kind_description|layout|sizes"

I like btf_kind_layout, it's short and to the point.

> to narrow the scope.
> This BTF extension is not going to describe semantics of unknown kinds.
> Instead of "best effort" attempts with flags like "what type/size means"
> let's not even go there.
>

Ack.

> If we go this simple route I'm fine with hard coded crc and base_crc
> fields. They probably should go to btf_header though.

Yep, on btf_header fields. But I'd not hardcode "crc" name. If we are
doing them as strings (which I think we should instead of dooming them
to 32-bit integer crc32 value only), then can we just say generically
that it's either "id" or "checksum"?

But I guess crc32 would be fine in practice as well. So not something
I strongly feel about.

> We don't need "struct btf_metadata" as well.
> It's making things sound beyond what it actually is.
> btf_header can point to an array of struct btf_kind_description.
> As simple as it can get.

Agreed. Still, it's a third section, and we should at least have a
count of those btf_kind_layout items somewhere.

> No need for json like format and key/value things either.
> We're not creating a self described BTF format.
> We're just adding a few size fields.

Ack, great.

> The kernel/libbpf/dedup still needs to known semantics of future kinds
> to be able to print/operate on them.

Yes.

