Return-Path: <bpf+bounces-5121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 822FF75697E
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BB71C20B2D
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052261855;
	Mon, 17 Jul 2023 16:46:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54410E7
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:46:44 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD42210CA
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:46:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8b2b60731so25409125ad.2
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689612402; x=1692204402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUHQbFidptBSyIBZDaaOXAvMeMIqguqqq69F1NY0Biw=;
        b=Nas6tA46UivdsFxCmBtC1mUg4WK/5XgIQrm3N7GaCvvXHyhslyJ5Rg5+hrJYpwjH2k
         8PQDA1P/fRWcj3d/mgqIFxNZ64kCvQsUCx4O3RTSLZOUPbQGsYDFuzSnEcL8imsqOcbs
         l2UdXocDGLRoDE4u4dajeg9aEpXyyjjrQ8KewvB37EziEq764w2XQTQ1Vor7f7T24hA0
         Y49V3KGdsBqp/hHHj3T4wsOIwWN4hmajuHrGyawKba23oDMevecnyV+8GEsC2Z1ORDEY
         vJJVPr3FiDaKo2jNyHbSTjjStlodGgJ+fkO+TKxcDhCdRrO260t/3Ad+x6SJM0tIZRny
         y/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612402; x=1692204402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUHQbFidptBSyIBZDaaOXAvMeMIqguqqq69F1NY0Biw=;
        b=DRc3OJUPjBQojCv4xBtj2wjLDnj0tgjpMYTUX5VvgL/qCM+/AkepT4HMfdFofY4CVU
         tjmsQ1/Hh90JzCLr/VCasFJKAY3/1Wi3Sw9GE4Kz2aktxpD5bgvBid6RGNtsPTpfHGjk
         9K4Xtmk1LWXbcE2Gu23rsDu04U8TPkTyou567oHCTaLTEUPfduz6n3G2OLm3lTOg1dkd
         8ELcrL+/heOGF5JXM4ymJsdiCz6pCRaF9XA+LmOAtCtBqKcHXXvRJAEIi1Z1xeh3CxvL
         oCyFpQt96Ue9oFZXhV5cSfbW3U8UjWKvqrTwUGtxkPY/QbgDWRsnoKkBlbfT6eCT64Kh
         jZGQ==
X-Gm-Message-State: ABy/qLa6sBvuCVLp2ls903eLO1D+sQ7mBzs2+gBoGlO1PXj0O/57UsUL
	hs3Ar+zz9UCDG5OttP/m66f4Ky66L9I4ClYztKN5xOBoFVZchjUGpCCuJA==
X-Google-Smtp-Source: APBJJlFYI5l0PbqKXp2d1zz70ZWVPc3dRH1gm4G8Ge0W7QpcOwUeIc0IuKOjVOgkL06s+68L6HZQ5HLsaFCplqVGiCs=
X-Received: by 2002:a17:903:2349:b0:1b6:4bbd:c3b6 with SMTP id
 c9-20020a170903234900b001b64bbdc3b6mr14574312plh.9.1689612401992; Mon, 17 Jul
 2023 09:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.com>
 <ZKcDdIYOUQuPP5Px@google.com> <51aa1dd7-86d0-ed08-1142-f229513ad316@gmail.com>
 <ZKhC9G5ouGOviSOG@google.com> <2b48be65-5f63-4658-38cb-03c00c10fdf3@gmail.com>
 <ZKw9XQGOza6qGDLf@google.com> <32972dd6-1c6c-d59f-3f13-d90dd6e4b400@gmail.com>
In-Reply-To: <32972dd6-1c6c-d59f-3f13-d90dd6e4b400@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 17 Jul 2023 09:46:30 -0700
Message-ID: <CAKH8qBspx+7ZsCWZVxFzdPaMWWQem3+Thpa65973-H3sphGoSA@mail.gmail.com>
Subject: Re: [PATCH v1] samples/bpf: Fix build out of source tree
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 16, 2023 at 2:42=E2=80=AFAM Anh Tuan Phan <tuananhlfc@gmail.com=
> wrote:
>
>
>
> On 7/11/23 00:18, Stanislav Fomichev wrote:
> > On 07/09, Anh Tuan Phan wrote:
> >> I updated the patch to reflect your suggestion. Thank you!
> >
> > In the future, can you please post a new one with v+1 instead of replyi=
ng
> > to the old one? Thx!
>
> Will do in the next version.
>
> >
> >> On 7/7/23 23:53, Stanislav Fomichev wrote:
> >>> On 07/07, Anh Tuan Phan wrote:
> >>>>
> >>>>
> >>>> On 7/7/23 01:09, Stanislav Fomichev wrote:
> >>>>> On 07/06, Anh Tuan Phan wrote:
> >>>>>> This commit fixes a few compilation issues when building out of so=
urce
> >>>>>> tree. The command that I used to build samples/bpf:
> >>>>>>
> >>>>>> export KBUILD_OUTPUT=3D/tmp
> >>>>>> make V=3D1 M=3Dsamples/bpf
> >>>>>>
> >>>>>> The compilation failed since it tried to find the header files in =
the
> >>>>>> wrong places between output directory and source tree directory
> >>>>>>
> >>>>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> >>>>>> ---
> >>>>>>  samples/bpf/Makefile        | 8 ++++----
> >>>>>>  samples/bpf/Makefile.target | 2 +-
> >>>>>>  2 files changed, 5 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> >>>>>> index 615f24ebc49c..32469aaa82d5 100644
> >>>>>> --- a/samples/bpf/Makefile
> >>>>>> +++ b/samples/bpf/Makefile
> >>>>>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/h=
bm_kern.h
> >>>>>>  # Override includes for xdp_sample_user.o because $(srctree)/usr/=
include in
> >>>>>>  # TPROGS_CFLAGS causes conflicts
> >>>>>>  XDP_SAMPLE_CFLAGS +=3D -Wall -O2 \
> >>>>>> -                     -I$(src)/../../tools/include \
> >>>>>> +                     -I$(srctree)/tools/include \
> >>>>>
> >>>>> [..]
> >>>>>
> >>>>>>                       -I$(src)/../../tools/include/uapi \
> >>>>>
> >>>>> Does this $(src) need to be changed as well?
> >>>>
> >>>> I think this line doesn't affect the build. I removed it and it stil=
l
> >>>> compiles (after "make -C samples/bpf clean"). I guess xdp_sample_use=
r.c
> >>>> doesn't include any file in tools/include/uapi. Am I missing somethi=
ng
> >>>> or should I remove this line?
> >>>
> >>> You might have these headers installed on your system already if
> >>> it compiles without this part. So I'd keep this part but do
> >>> s/src/srctree/ (and remove ../..).
> >>>
> >>>>>
> >>>>>
> >>>>>>                       -I$(LIBBPF_INCLUDE) \
> >>>>>> -                     -I$(src)/../../tools/testing/selftests/bpf
> >>>>>> +                     -I$(srctree)/tools/testing/selftests/bpf
> >>>>>>
> >>>>>>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS =3D $(XDP_SAMPLE_CFLAGS)
> >>>>>>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_=
shared.h
> >>>>>> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sampl=
e.bpf.o
> >>>>>>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample=
.bpf.h
> >>>>>> $(src)/xdp_sample_shared.h
> >>>>>>          @echo "  CLANG-BPF " $@
> >>>>>>          $(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH=
) \
> >>>>>> -                -Wno-compare-distinct-pointer-types -I$(srctree)/=
include \
> >>>>>> +                -Wno-compare-distinct-pointer-types -I$(obj) -I$(=
srctree)/include \
> >>>>>>                  -I$(srctree)/samples/bpf -I$(srctree)/tools/inclu=
de \
> >>>>>>                  -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
> >>>>>>                  -c $(filter %.bpf.c,$^) -o $@
> >>>>>> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps :=3D xdp_router_ip=
v4.bpf.o
> >>>>>> xdp_sample.bpf.o
> >>>>>>
> >>>>>>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.bpf.c,$(foreach
> >>>>>> skel,$(LINKED_SKELS),$($(skel)-deps)))
> >>>>>>
> >>>>>> -BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(src)/*.bpf.c))
> >>>>>> +BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(srctree)/$(src)/*.bpf.=
c))
> >>>>>>  BPF_OBJS_LINKED :=3D $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRC=
S_LINKED))
> >>>>>>  BPF_SKELS_LINKED :=3D $(addprefix $(obj)/,$(LINKED_SKELS))
> >>>>>>
> >>>>>> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.ta=
rget
> >>>>>> index 7621f55e2947..86a454cfb080 100644
> >>>>>> --- a/samples/bpf/Makefile.target
> >>>>>> +++ b/samples/bpf/Makefile.target
> >>>>>> @@ -41,7 +41,7 @@ _tprogc_flags   =3D $(TPROGS_CFLAGS) \
> >>>>>>                   $(TPROGCFLAGS_$(basetarget).o)
> >>>>>>
> >>>>>>  # $(objtree)/$(obj) for including generated headers from checkin =
source
> >>>>>> files
> >>>>>
> >>>>> [..]
> >>>>>
> >>>>>> -ifeq ($(KBUILD_EXTMOD),)
> >>>>>> +ifneq ($(KBUILD_EXTMOD),)
> >>>>>
> >>>>> This parts seems to be copy-pasted all over the place in its 'ifeq'
> >>>>> form. What is it doing and why is it needed?
> >>>>>
> >>>>>>  ifdef building_out_of_srctree
> >>>>>>  _tprogc_flags   +=3D -I $(objtree)/$(obj)
> >>>>>>  endif
> >>>>>> --
> >>>>>> 2.34.1
> >>
> >> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> >> ---
> >>
> >> Change from the original patch
> >>
> >> - Change "-I$(src)/../../tools/include/uapi" to
> >> "-I$(srctree)/tools/include/uapi"
> >>
> >>  samples/bpf/Makefile        | 10 +++++-----
> >>  samples/bpf/Makefile.target |  2 +-
> >>  2 files changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> >> index 615f24ebc49c..cfc960b3713a 100644
> >> --- a/samples/bpf/Makefile
> >> +++ b/samples/bpf/Makefile
> >> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_k=
ern.h
> >>  # Override includes for xdp_sample_user.o because $(srctree)/usr/incl=
ude in
> >>  # TPROGS_CFLAGS causes conflicts
> >>  XDP_SAMPLE_CFLAGS +=3D -Wall -O2 \
> >> -                 -I$(src)/../../tools/include \
> >> -                 -I$(src)/../../tools/include/uapi \
> >> +                 -I$(srctree)/tools/include \
> >> +                 -I$(srctree)/tools/include/uapi \
> >>                   -I$(LIBBPF_INCLUDE) \
> >> -                 -I$(src)/../../tools/testing/selftests/bpf
> >> +                 -I$(srctree)/tools/testing/selftests/bpf
> >>
> >>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS =3D $(XDP_SAMPLE_CFLAGS)
> >>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shar=
ed.h
> >> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bp=
f.o
> >>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf=
.h
> >> $(src)/xdp_sample_shared.h
> >>      @echo "  CLANG-BPF " $@
> >>      $(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
> >> -            -Wno-compare-distinct-pointer-types -I$(srctree)/include =
\
> >> +            -Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)=
/include \
> >>              -I$(srctree)/samples/bpf -I$(srctree)/tools/include \
> >>              -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
> >>              -c $(filter %.bpf.c,$^) -o $@
> >> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps :=3D xdp_router_ipv4.b=
pf.o
> >> xdp_sample.bpf.o
> >>
> >>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.bpf.c,$(foreach
> >> skel,$(LINKED_SKELS),$($(skel)-deps)))
> >>
> >> -BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(src)/*.bpf.c))
> >> +BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
> >>  BPF_OBJS_LINKED :=3D $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LI=
NKED))
> >>  BPF_SKELS_LINKED :=3D $(addprefix $(obj)/,$(LINKED_SKELS))
> >>
> >> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
> >> index 7621f55e2947..86a454cfb080 100644
> >> --- a/samples/bpf/Makefile.target
> >> +++ b/samples/bpf/Makefile.target
> >> @@ -41,7 +41,7 @@ _tprogc_flags   =3D $(TPROGS_CFLAGS) \
> >>                   $(TPROGCFLAGS_$(basetarget).o)
> >>
> >>  # $(objtree)/$(obj) for including generated headers from checkin sour=
ce
> >> files
> >
> > [..]
> >
> >> -ifeq ($(KBUILD_EXTMOD),)
> >> +ifneq ($(KBUILD_EXTMOD),)
> >>  ifdef building_out_of_srctree
> >>  _tprogc_flags   +=3D -I $(objtree)/$(obj)
> >>  endif
> >
> > This question left undressed. Can you share more on why this change
> > is needed? Because it looks like it's actually needed for M=3D'' case.
> > IOW, maybe we should add $(objtree)/$(obj) somewhere else?
>
> If it's needed for both cases M=3D'' and M !=3D '', is it better to just
> remove the condition with $(KBUILD_EXTMOD)? FMPOV, -I $(objtree)/$(obj)
> is only needed in case of building_out_of_srctree, no matter what
> KBUILD_EXTMOD.

My guess is that we're missing -I $(objtree)/$(obj) somewhere else.
Depending on what/where it fails, we probably need to add $(objtree)
to some of the $(obj)s?
I'm mostly speculating here, because I see that "ifeq
($(KBUILD_EXTMOD),) + ifdef building_out_of_srctree" pattern being
used in the other places.

