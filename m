Return-Path: <bpf+bounces-5521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4EC75B533
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 19:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631F8281FE8
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 17:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C022FA41;
	Thu, 20 Jul 2023 17:05:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E651773D
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 17:05:58 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C37186
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 10:05:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262d33fa37cso537869a91.3
        for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689872756; x=1690477556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpptkd/Mdhg6c/eFiSNq82DPLgdaQ475OsYSI7hvFi4=;
        b=zS13WslXEZUV6mX8ftP70EqAc40IfiOzs5BUIHWW+aML7Wb7dKbRUdtTk8vJbIUjtp
         K40iGhvluR6xSaDaRjBpQvxh16uWLsT6TC4Waa3bVyTYkPaDQG3W9YaKM23JtbTu5+bM
         Xz5lSCf/u3JOL7m8B92620xDNsaOZBMfQqQHCxnOJzknNs+ecYz4y3+AABcAkLstYHbk
         6nYnR7EzwY5O92Y5+f1LgTkUF0VBimsmD9mEG+u6EpAIOLhcWuSJkmKtYFNSTyX6wR9v
         4zeh+28kvRHdos81K8jkQ98SJECYfpa4zubVJwbDCLSMRTMsW/2YfEgpNWCpYUZ94pnm
         ChGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689872756; x=1690477556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fpptkd/Mdhg6c/eFiSNq82DPLgdaQ475OsYSI7hvFi4=;
        b=c2PQd9XYur+j0SVWELw/HJUtla0o8w4xWUZ3eOxiP+dM5ITHoBwcmqHLjXyiXeZgYi
         lik1OkixU398e9ws7anKnX6VAw97pU0mCGuVC9wRh8XPf91QEgRorGETTLyEj+tBN9gj
         RdiXbNVyINIPiYTadwOJ+n9G33yucvl6eNMh/+ESfA0ReKQQ1Rh5WMPQEPcU/lJcihLl
         c0SBxkLA7igwrhTPkLEFN3bOZvmgGjTrO5+0sHwPuKW3pEWgwixsW6tt55Qf1b+Mq53p
         r/aUtbQ7f1ROJuRAn8S0U2/05uxv3ExvyEQS5IHFq1OI7+OGwg9S1tC3OoRJhYsPEWkB
         rEIQ==
X-Gm-Message-State: ABy/qLYlPT9RmOpsnDXc8kM5QDS/NAPlPYY2L12hsSljEUEGjj1ZfIHX
	N5oBkkcNG0gavepX6iMZtDylH+D9ICOq8ED9OBCiuA==
X-Google-Smtp-Source: APBJJlERF86l1BleiPxJMxRPbY6N2ixpdQhn08HHi50hhIDfvR1PzSC2ZrEUxePC1AAbm0ho228R34dpBowI1s05z7w=
X-Received: by 2002:a17:90a:3ec2:b0:263:6a7e:c239 with SMTP id
 k60-20020a17090a3ec200b002636a7ec239mr37883pjc.37.1689872755655; Thu, 20 Jul
 2023 10:05:55 -0700 (PDT)
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
 <CAKH8qBspx+7ZsCWZVxFzdPaMWWQem3+Thpa65973-H3sphGoSA@mail.gmail.com> <dfe68d18-d031-b6ef-ef96-97f7a119d3e1@gmail.com>
In-Reply-To: <dfe68d18-d031-b6ef-ef96-97f7a119d3e1@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 20 Jul 2023 10:05:44 -0700
Message-ID: <CAKH8qBtTvTnWYQwyHp9RWzJG8oO3FjW+AQvr+rjxTNeAxtNvxQ@mail.gmail.com>
Subject: Re: [PATCH v1] samples/bpf: Fix build out of source tree
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 9:13=E2=80=AFAM Anh Tuan Phan <tuananhlfc@gmail.com=
> wrote:
>
>
>
> On 7/17/23 23:46, Stanislav Fomichev wrote:
> > On Sun, Jul 16, 2023 at 2:42=E2=80=AFAM Anh Tuan Phan <tuananhlfc@gmail=
.com> wrote:
> >>
> >>
> >>
> >> On 7/11/23 00:18, Stanislav Fomichev wrote:
> >>> On 07/09, Anh Tuan Phan wrote:
> >>>> I updated the patch to reflect your suggestion. Thank you!
> >>>
> >>> In the future, can you please post a new one with v+1 instead of repl=
ying
> >>> to the old one? Thx!
> >>
> >> Will do in the next version.
> >>
> >>>
> >>>> On 7/7/23 23:53, Stanislav Fomichev wrote:
> >>>>> On 07/07, Anh Tuan Phan wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 7/7/23 01:09, Stanislav Fomichev wrote:
> >>>>>>> On 07/06, Anh Tuan Phan wrote:
> >>>>>>>> This commit fixes a few compilation issues when building out of =
source
> >>>>>>>> tree. The command that I used to build samples/bpf:
> >>>>>>>>
> >>>>>>>> export KBUILD_OUTPUT=3D/tmp
> >>>>>>>> make V=3D1 M=3Dsamples/bpf
> >>>>>>>>
> >>>>>>>> The compilation failed since it tried to find the header files i=
n the
> >>>>>>>> wrong places between output directory and source tree directory
> >>>>>>>>
> >>>>>>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> >>>>>>>> ---
> >>>>>>>>  samples/bpf/Makefile        | 8 ++++----
> >>>>>>>>  samples/bpf/Makefile.target | 2 +-
> >>>>>>>>  2 files changed, 5 insertions(+), 5 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> >>>>>>>> index 615f24ebc49c..32469aaa82d5 100644
> >>>>>>>> --- a/samples/bpf/Makefile
> >>>>>>>> +++ b/samples/bpf/Makefile
> >>>>>>>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)=
/hbm_kern.h
> >>>>>>>>  # Override includes for xdp_sample_user.o because $(srctree)/us=
r/include in
> >>>>>>>>  # TPROGS_CFLAGS causes conflicts
> >>>>>>>>  XDP_SAMPLE_CFLAGS +=3D -Wall -O2 \
> >>>>>>>> -                     -I$(src)/../../tools/include \
> >>>>>>>> +                     -I$(srctree)/tools/include \
> >>>>>>>
> >>>>>>> [..]
> >>>>>>>
> >>>>>>>>                       -I$(src)/../../tools/include/uapi \
> >>>>>>>
> >>>>>>> Does this $(src) need to be changed as well?
> >>>>>>
> >>>>>> I think this line doesn't affect the build. I removed it and it st=
ill
> >>>>>> compiles (after "make -C samples/bpf clean"). I guess xdp_sample_u=
ser.c
> >>>>>> doesn't include any file in tools/include/uapi. Am I missing somet=
hing
> >>>>>> or should I remove this line?
> >>>>>
> >>>>> You might have these headers installed on your system already if
> >>>>> it compiles without this part. So I'd keep this part but do
> >>>>> s/src/srctree/ (and remove ../..).
> >>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>>                       -I$(LIBBPF_INCLUDE) \
> >>>>>>>> -                     -I$(src)/../../tools/testing/selftests/bpf
> >>>>>>>> +                     -I$(srctree)/tools/testing/selftests/bpf
> >>>>>>>>
> >>>>>>>>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS =3D $(XDP_SAMPLE_CFLAGS)
> >>>>>>>>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sampl=
e_shared.h
> >>>>>>>> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sam=
ple.bpf.o
> >>>>>>>>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_samp=
le.bpf.h
> >>>>>>>> $(src)/xdp_sample_shared.h
> >>>>>>>>          @echo "  CLANG-BPF " $@
> >>>>>>>>          $(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCAR=
CH) \
> >>>>>>>> -                -Wno-compare-distinct-pointer-types -I$(srctree=
)/include \
> >>>>>>>> +                -Wno-compare-distinct-pointer-types -I$(obj) -I=
$(srctree)/include \
> >>>>>>>>                  -I$(srctree)/samples/bpf -I$(srctree)/tools/inc=
lude \
> >>>>>>>>                  -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
> >>>>>>>>                  -c $(filter %.bpf.c,$^) -o $@
> >>>>>>>> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps :=3D xdp_router_=
ipv4.bpf.o
> >>>>>>>> xdp_sample.bpf.o
> >>>>>>>>
> >>>>>>>>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.bpf.c,$(foreach
> >>>>>>>> skel,$(LINKED_SKELS),$($(skel)-deps)))
> >>>>>>>>
> >>>>>>>> -BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(src)/*.bpf.c))
> >>>>>>>> +BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(srctree)/$(src)/*.bp=
f.c))
> >>>>>>>>  BPF_OBJS_LINKED :=3D $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_S=
RCS_LINKED))
> >>>>>>>>  BPF_SKELS_LINKED :=3D $(addprefix $(obj)/,$(LINKED_SKELS))
> >>>>>>>>
> >>>>>>>> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.=
target
> >>>>>>>> index 7621f55e2947..86a454cfb080 100644
> >>>>>>>> --- a/samples/bpf/Makefile.target
> >>>>>>>> +++ b/samples/bpf/Makefile.target
> >>>>>>>> @@ -41,7 +41,7 @@ _tprogc_flags   =3D $(TPROGS_CFLAGS) \
> >>>>>>>>                   $(TPROGCFLAGS_$(basetarget).o)
> >>>>>>>>
> >>>>>>>>  # $(objtree)/$(obj) for including generated headers from checki=
n source
> >>>>>>>> files
> >>>>>>>
> >>>>>>> [..]
> >>>>>>>
> >>>>>>>> -ifeq ($(KBUILD_EXTMOD),)
> >>>>>>>> +ifneq ($(KBUILD_EXTMOD),)
> >>>>>>>
> >>>>>>> This parts seems to be copy-pasted all over the place in its 'ife=
q'
> >>>>>>> form. What is it doing and why is it needed?
> >>>>>>>
> >>>>>>>>  ifdef building_out_of_srctree
> >>>>>>>>  _tprogc_flags   +=3D -I $(objtree)/$(obj)
> >>>>>>>>  endif
> >>>>>>>> --
> >>>>>>>> 2.34.1
> >>>>
> >>>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> >>>> ---
> >>>>
> >>>> Change from the original patch
> >>>>
> >>>> - Change "-I$(src)/../../tools/include/uapi" to
> >>>> "-I$(srctree)/tools/include/uapi"
> >>>>
> >>>>  samples/bpf/Makefile        | 10 +++++-----
> >>>>  samples/bpf/Makefile.target |  2 +-
> >>>>  2 files changed, 6 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> >>>> index 615f24ebc49c..cfc960b3713a 100644
> >>>> --- a/samples/bpf/Makefile
> >>>> +++ b/samples/bpf/Makefile
> >>>> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm=
_kern.h
> >>>>  # Override includes for xdp_sample_user.o because $(srctree)/usr/in=
clude in
> >>>>  # TPROGS_CFLAGS causes conflicts
> >>>>  XDP_SAMPLE_CFLAGS +=3D -Wall -O2 \
> >>>> -                 -I$(src)/../../tools/include \
> >>>> -                 -I$(src)/../../tools/include/uapi \
> >>>> +                 -I$(srctree)/tools/include \
> >>>> +                 -I$(srctree)/tools/include/uapi \
> >>>>                   -I$(LIBBPF_INCLUDE) \
> >>>> -                 -I$(src)/../../tools/testing/selftests/bpf
> >>>> +                 -I$(srctree)/tools/testing/selftests/bpf
> >>>>
> >>>>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS =3D $(XDP_SAMPLE_CFLAGS)
> >>>>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_sh=
ared.h
> >>>> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.=
bpf.o
> >>>>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.b=
pf.h
> >>>> $(src)/xdp_sample_shared.h
> >>>>      @echo "  CLANG-BPF " $@
> >>>>      $(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
> >>>> -            -Wno-compare-distinct-pointer-types -I$(srctree)/includ=
e \
> >>>> +            -Wno-compare-distinct-pointer-types -I$(obj) -I$(srctre=
e)/include \
> >>>>              -I$(srctree)/samples/bpf -I$(srctree)/tools/include \
> >>>>              -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
> >>>>              -c $(filter %.bpf.c,$^) -o $@
> >>>> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps :=3D xdp_router_ipv4=
.bpf.o
> >>>> xdp_sample.bpf.o
> >>>>
> >>>>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.bpf.c,$(foreach
> >>>> skel,$(LINKED_SKELS),$($(skel)-deps)))
> >>>>
> >>>> -BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(src)/*.bpf.c))
> >>>> +BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c)=
)
> >>>>  BPF_OBJS_LINKED :=3D $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_=
LINKED))
> >>>>  BPF_SKELS_LINKED :=3D $(addprefix $(obj)/,$(LINKED_SKELS))
> >>>>
> >>>> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.targ=
et
> >>>> index 7621f55e2947..86a454cfb080 100644
> >>>> --- a/samples/bpf/Makefile.target
> >>>> +++ b/samples/bpf/Makefile.target
> >>>> @@ -41,7 +41,7 @@ _tprogc_flags   =3D $(TPROGS_CFLAGS) \
> >>>>                   $(TPROGCFLAGS_$(basetarget).o)
> >>>>
> >>>>  # $(objtree)/$(obj) for including generated headers from checkin so=
urce
> >>>> files
> >>>
> >>> [..]
> >>>
> >>>> -ifeq ($(KBUILD_EXTMOD),)
> >>>> +ifneq ($(KBUILD_EXTMOD),)
> >>>>  ifdef building_out_of_srctree
> >>>>  _tprogc_flags   +=3D -I $(objtree)/$(obj)
> >>>>  endif
> >>>
> >>> This question left undressed. Can you share more on why this change
> >>> is needed? Because it looks like it's actually needed for M=3D'' case=
.
> >>> IOW, maybe we should add $(objtree)/$(obj) somewhere else?
> >>
> >> If it's needed for both cases M=3D'' and M !=3D '', is it better to ju=
st
> >> remove the condition with $(KBUILD_EXTMOD)? FMPOV, -I $(objtree)/$(obj=
)
> >> is only needed in case of building_out_of_srctree, no matter what
> >> KBUILD_EXTMOD.
> >
> > My guess is that we're missing -I $(objtree)/$(obj) somewhere else.
> > Depending on what/where it fails, we probably need to add $(objtree)
> > to some of the $(obj)s?
> > I'm mostly speculating here, because I see that "ifeq
> > ($(KBUILD_EXTMOD),) + ifdef building_out_of_srctree" pattern being
> > used in the other places.
>
> It turns out that your guess is right. "-I $(objtree)/$(obj)" is only
> needed for the following objects: xdp_redirect_map_multi_user,
> xdp_redirect_cpu_user, xdp_redirect_map_user, xdp_redirect_user,
> xdp_monitor_user and xdp_router_ipv4_user. There is a variable to add
> flags for gcc named $(TPROGCFLAGS_$(basetarget).o) but it has not been
> set. My proposed fix is to set the following variables:

Looks like these are the tests that use bpf skeleton.

> +TPROGCFLAGS_xdp_redirect_map_multi_user.o +=3D -I$(objtree)/$(obj)
> +TPROGCFLAGS_xdp_redirect_cpu_user.o +=3D -I$(objtree)/$(obj)
> +TPROGCFLAGS_xdp_redirect_map_user.o +=3D -I$(objtree)/$(obj)
> +TPROGCFLAGS_xdp_redirect_user.o +=3D -I$(objtree)/$(obj)
> +TPROGCFLAGS_xdp_monitor_user.o +=3D -I$(objtree)/$(obj)
> +TPROGCFLAGS_xdp_router_ipv4_user.o +=3D -I$(objtree)/$(obj)
>
> It works with the original "ifeq
> > ($(KBUILD_EXTMOD),) + ifdef building_out_of_srctree" pattern. What do
> you think about my proposed fix?

Maybe we should just unconditionally add "-I $(objtree)/$(obj)" to
_tprogc_flags ?

And then we can drop that whole part:
ifeq ($(KBUILD_EXTMOD),)
ifdef building_out_of_srctree
_tprogc_flags   +=3D -I $(objtree)/$(obj)
endif
endif

IOW, replace that $(TPROGCFLAGS_$(basetarget).o) part with -I
$(objtree)/$(obj) and call it a day?
I honestly have no clue why it's this complicated and I doubt anybody
at this point remembers...

