Return-Path: <bpf+bounces-4129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5504A749209
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 01:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B251C20C8A
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 23:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3715AEA;
	Wed,  5 Jul 2023 23:48:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A1156F7
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 23:48:19 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EA610F5
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 16:48:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc77e76abso931365e9.1
        for <bpf@vger.kernel.org>; Wed, 05 Jul 2023 16:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688600895; x=1691192895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZV3+AQe87ZlY/zWnWTfprROf7AElZpjB8G+9b+kj2E=;
        b=jt4yRFGa94GjytV/DxGKwOQUN+Q+JRGiDvYxlLi/Wwag2Ufc8LwWi/Odg4+eo6eT2w
         kq1YsYdrfz3ePFcZ1qoespv6I6nn10OrBag1w9+fpjk1VwTsOUrABllYWi9PTRxyvkf/
         7vjt1+VN/31M2s3wOUfWme02PRrbfW5/Z6wWnAoFmzdeggf3lBXi8Qqc3Aol7Uesvjk4
         6sxOkg4R9iZ+cWZ3JoP84sgWuITrIIV43H25Ix+aj84RRboJKlbXh0l2nOqV3rxCbR6x
         bquBeYQVvcqvAqybjubEFohfHrrHOnKsfsjgsAV3SLmPg3coWZQ95xEkwRKEF30wLAVD
         xdbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688600895; x=1691192895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZV3+AQe87ZlY/zWnWTfprROf7AElZpjB8G+9b+kj2E=;
        b=ITDVssFD1yJKA5/rnwJF8YtFP3oNf3Zn1nzS+v2aLh27oe9n920oyBf6yLKsLx1+0+
         F+MKlGlHxd3kvCYxfGYReDLF4rICKvSwkyWc0B2if+xaw7o6ZQk5xfNSK7+yJ7tp/JK4
         fwD54PEwGOZeWXMRDCqo0tFqTnwGzOqcqXyDBEW3bwKnV2tETKX/0+y62ZFZR/ZM6/vq
         UysxyRhyvAAk9394oD5ksQY/k++89sNxZ+a7TL5YI+XTTbKEekyGD7/oTonYOuGDc9i0
         ieh2PqWL1NAdOAB2It5f0JchvRCFpsE+reatYjb7Xn2Lqr1QMlc5r6o/AxDP9F0rRe0Q
         NQqw==
X-Gm-Message-State: ABy/qLZ6fHCYr6qVxn4z96BUklFK/SmUiJHF89dMYq7ou0A/xmQsjCDA
	Nfe4C4ITS5qlnQG4/CWNCpippLKZcU6Kys4lWIw=
X-Google-Smtp-Source: APBJJlH/PVYrItSIFHPE7ckjXd+nPoYHgPG0ywRI5poOOY3J1WAdjM4R+LuMfgbenYGtG3+GmUwbrJAR1osz2XZFhGE=
X-Received: by 2002:a7b:c019:0:b0:3f7:f584:579b with SMTP id
 c25-20020a7bc019000000b003f7f584579bmr81665wmb.9.1688600895282; Wed, 05 Jul
 2023 16:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230616171728.530116-2-alan.maguire@oracle.com> <CAEf4BzapHdQb=gXq9xLRGfRFBC=3xcQ=OSdV1o=+5nvgDwT4HA@mail.gmail.com>
 <b972e451-3a1f-4f29-b03a-68ce3ac765f1@oracle.com>
In-Reply-To: <b972e451-3a1f-4f29-b03a-68ce3ac765f1@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Jul 2023 16:48:03 -0700
Message-ID: <CAEf4Bzazke2aLWfEZChN2BCcf83b9_EufQVAP0Z19LY5z=+yZQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/9] btf: add kind layout encoding, crcs to UAPI
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	quentin@isovalent.com, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 3, 2023 at 6:42=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 22/06/2023 23:02, Andrii Nakryiko wrote:
> > On Fri, Jun 16, 2023 at 10:17=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>
> >> BTF kind layouts provide information to parse BTF kinds.
> >> By separating parsing BTF from using all the information
> >> it provides, we allow BTF to encode new features even if
> >> they cannot be used.  This is helpful in particular for
> >> cases where newer tools for BTF generation run on an
> >> older kernel; BTF kinds may be present that the kernel
> >> cannot yet use, but at least it can parse the BTF
> >> provided.  Meanwhile userspace tools with newer libbpf
> >> may be able to use the newer information.
> >>
> >> The intent is to support encoding of kind layouts
> >> optionally so that tools like pahole can add this
> >> information.  So for each kind we record
> >>
> >> - kind-related flags
> >> - length of singular element following struct btf_type
> >> - length of each of the btf_vlen() elements following
> >>
> >> In addition we make space in the BTF header for
> >> CRC32s computed over the BTF along with a CRC for
> >> the base BTF; this allows split BTF to identify
> >> a mismatch explicitly.
> >>
> >> The ideas here were discussed at [1], [2]; hence
> >>
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>
> >> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=3DeOXOs_ONrDwrgX4bn=
=3DNuc1g8JPFC34MA@mail.gmail.com/
> >> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@=
oracle.com/
> >> ---
> >>  include/uapi/linux/btf.h       | 24 ++++++++++++++++++++++++
> >>  tools/include/uapi/linux/btf.h | 24 ++++++++++++++++++++++++
> >>  2 files changed, 48 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
> >> index ec1798b6d3ff..cea9125ed953 100644
> >> --- a/include/uapi/linux/btf.h
> >> +++ b/include/uapi/linux/btf.h
> >> @@ -8,6 +8,22 @@
> >>  #define BTF_MAGIC      0xeB9F
> >>  #define BTF_VERSION    1
> >>
> >> +/* is this information required? If so it cannot be sanitized safely.=
 */
> >> +#define BTF_KIND_LAYOUT_OPTIONAL               (1 << 0)
> >
> > hm.. I thought we agreed to not have OPTIONAL flag last time, no? From
> > kernel's perspective nothing is optional. From libbpf perspective
> > everything should be optional, unless we get type_id reference to
> > something that we don't recognize. So why the flag and extra code to
> > handle it?
> >
> > We can always add it later, if necessary.
> >
>
> I totally agree we need to reject any BTF that contains references
> to unknown objects if these references are made via known ones;
> so for example an enum64 in a struct (in the case we didn't know
> about an enum64). However, it's possible a BTF kind could point
> _at_ other BTF kinds but not be pointed _to_ by any known kinds;
> in such a case wouldn't optional make sense even for the kernel
> to say "ignore any kinds that we don't know about that aren't
> participating in any known BTF relationships"? Default assumption
> without the optional flag would be to reject such BTF.

I think it's simpler (and would follow what we've been doing with
kernel-side strict validation of everything) to reject everything
unknown. "Being pointed to" isn't always contained within BTF itself.
E.g., for line and func info, type_id comes during BPF_PROG_LOAD. So
at the point of BTF validation you don't know that some FUNCs will be
pointed to (as an example). So I'd avoid making unnecessarily
dangerous assumptions that some pieces of information can be ignored.

And in general, kernel doesn't trust user-space data without
validation, so we'd have to double-check all this OPTIONAL flags
somehow anyways.

>
> >> +
> >> +/* kind layout section consists of a struct btf_kind_layout for each =
known
> >> + * kind at BTF encoding time.
> >> + */
> >> +struct btf_kind_layout {
> >> +       __u16 flags;            /* see BTF_KIND_LAYOUT_* values above =
*/
> >> +       __u8 info_sz;           /* size of singular element after btf_=
type */
> >> +       __u8 elem_sz;           /* size of each of btf_vlen(t) element=
s */
> >> +};
> >> +
> >> +/* for CRCs for BTF, base BTF to be considered usable, flags must be =
set. */
> >> +#define BTF_FLAG_CRC_SET               (1 << 0)
> >> +#define BTF_FLAG_BASE_CRC_SET          (1 << 1)
> >> +
> >>  struct btf_header {
> >>         __u16   magic;
> >>         __u8    version;
> >> @@ -19,8 +35,16 @@ struct btf_header {
> >>         __u32   type_len;       /* length of type section       */
> >>         __u32   str_off;        /* offset of string section     */
> >>         __u32   str_len;        /* length of string section     */
> >> +       __u32   kind_layout_off;/* offset of kind layout section */
> >> +       __u32   kind_layout_len;/* length of kind layout section */
> >> +
> >> +       __u32   crc;            /* crc of BTF; used if flags set BTF_F=
LAG_CRC_VALID */
> >> +       __u32   base_crc;       /* crc of base BTF; used if flags set =
BTF_FLAG_BASE_CRC_VALID */
> >>  };
> >>
> >> +/* required minimum BTF header length */
> >> +#define BTF_HEADER_MIN_LEN     (sizeof(struct btf_header) - 16)
> >
> > offsetof(struct btf_header, kind_layout_off) ?
> >
> > but actually why this needs to be a part of UAPI?
> >
>
> no not really. I was trying to come up with a more elegant
> way of differentiating between the old and new header formats
> on the basis of size and eventually just gave up and added
> a #define. It can absolutely be removed.

right, so that's why just checking if field is present based on
btf_header.len and field offset is a good approach? Let's drop
unnecessary constants from UAPI header

>
> >> +
> >>  /* Max # of type identifier */
> >>  #define BTF_MAX_TYPE   0x000fffff
> >>  /* Max offset into the string section */
> >> diff --git a/tools/include/uapi/linux/btf.h b/tools/include/uapi/linux=
/btf.h
> >> index ec1798b6d3ff..cea9125ed953 100644
> >> --- a/tools/include/uapi/linux/btf.h
> >> +++ b/tools/include/uapi/linux/btf.h
> >> @@ -8,6 +8,22 @@
> >>  #define BTF_MAGIC      0xeB9F
> >>  #define BTF_VERSION    1
> >>
> >> +/* is this information required? If so it cannot be sanitized safely.=
 */
> >> +#define BTF_KIND_LAYOUT_OPTIONAL               (1 << 0)
> >> +
> >> +/* kind layout section consists of a struct btf_kind_layout for each =
known
> >> + * kind at BTF encoding time.
> >> + */
> >> +struct btf_kind_layout {
> >> +       __u16 flags;            /* see BTF_KIND_LAYOUT_* values above =
*/
> >> +       __u8 info_sz;           /* size of singular element after btf_=
type */
> >> +       __u8 elem_sz;           /* size of each of btf_vlen(t) element=
s */
> >> +};
> >> +
> >> +/* for CRCs for BTF, base BTF to be considered usable, flags must be =
set. */
> >> +#define BTF_FLAG_CRC_SET               (1 << 0)
> >> +#define BTF_FLAG_BASE_CRC_SET          (1 << 1)
> >> +
> >>  struct btf_header {
> >>         __u16   magic;
> >>         __u8    version;
> >> @@ -19,8 +35,16 @@ struct btf_header {
> >>         __u32   type_len;       /* length of type section       */
> >>         __u32   str_off;        /* offset of string section     */
> >>         __u32   str_len;        /* length of string section     */
> >> +       __u32   kind_layout_off;/* offset of kind layout section */
> >> +       __u32   kind_layout_len;/* length of kind layout section */
> >> +
> >> +       __u32   crc;            /* crc of BTF; used if flags set BTF_F=
LAG_CRC_VALID */
> >
> > why are we making crc optional? shouldn't we just say that crc is
> > always filled out?
> >
>
> The approach I took was to have libbpf/pahole be flexible about
> specification of crcs and kind layout; neither, one of these or both
> are supported. When neither are specified we'll still generate
> a larger header, but it will be zeros for the new fields so parseable
> by older libbpf/kernel. I think we probably need to make it optional
> for a while to support new pahole on older kernels.

I'm not sure how this "optional for a while" will turn to
"non-optional", tbh, and who and when will decide that. I think the
"new pahole on old kernel" problem is solvable easily by making all
this new stuff opt-in. New kernel Makefiles will request pahole to
emit them, if pahole is new enough. Old kernels won't know about this
feature and even new pahole won't emit it.

I don't feel too strongly about it, just generally feeling like
minimizing all the different supportable variations.

>
>
> >> +       __u32   base_crc;       /* crc of base BTF; used if flags set =
BTF_FLAG_BASE_CRC_VALID */
> >
> > here it would be nice if we could just rely on zero meaning not set,
> > but I suspect not everyone will be happy about this, as technically
> > crc 0 is a valid crc :(
> >
>
> Right, I think we're stuck with the flags unfortunately.

yep. one extra reason why I like the idea of this being string offset,
but whatever, small thing


> Thanks for the review (and apologies for the belated response!)
>
> Alan
>
> >
> >>  };
> >>
> >> +/* required minimum BTF header length */
> >> +#define BTF_HEADER_MIN_LEN     (sizeof(struct btf_header) - 16)
> >> +
> >>  /* Max # of type identifier */
> >>  #define BTF_MAX_TYPE   0x000fffff
> >>  /* Max offset into the string section */
> >> --
> >> 2.39.3
> >>

