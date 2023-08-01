Return-Path: <bpf+bounces-6604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9900C76BCE3
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A58281B6E
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E181235B7;
	Tue,  1 Aug 2023 18:48:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61296182C0
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 18:48:08 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D657AC6
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 11:48:06 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1bbafe6fd8fso4333175fac.3
        for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 11:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915686; x=1691520486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMzrdvdGDVBVT8pKCxDX3mfn16DbA30Sg2kYaNxaO7g=;
        b=eDW9Y051GNtyW9xCds03eye8SPMwHFznbthZMc0sMB4VcHGWdkb7mDPJStkIS3yi5o
         aVNMWsqdsMwcY3o/XYuBsj8ExEUvxmKAmRDTT2rhlNy4rd6S56DoSJA0mfCWFgjfDlAP
         /2Ot7kf55JxYCSLrjiSxl2qRGamIIsbiPz2anP39Hi2ld0va8d53svdrbqVZAe/ORwhX
         vk37sqVdbjnb27Rcs8xb5ZIl3cMKHF/NDon4v3y4XxuMlMoMAmcMg8pk5b16wszfLtuK
         6esmVf5nPv/0OOUdfikIyObOGff7RFuXysrH39aLGts5xQJg94xdQfQ6ZjFB8CaLwJMr
         zWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915686; x=1691520486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nMzrdvdGDVBVT8pKCxDX3mfn16DbA30Sg2kYaNxaO7g=;
        b=FKa3J7WF6t4dhfOb1RJWzUt98H7MYN/pixiyD+IdOfM9XGGGo6zF+jpS9qa1ag+CE9
         mQSYSLvGolxXIRRK1gWtTZ4sXSW78rngWq7Wz74rSiXzF5NH2riGyJNs8NwINH0eyLRX
         mtTVppDJo2d8qwXFELOfvDTdzCss+w/7q+5q3bVcFnHOna4ckkuugzhLIVZNtjGNL6I/
         GV4DbTvw/en2pfiD3RMt0VXZlcq2GsLlSZuk4630R8sBP3g+2Uc8mYG7Yh/GjqgIyTez
         oUduGR5yOS+mrZlQzQRY3NKf37IWc5x2lvOGskw6F2qTsmCgC0r9ply/1cRqGNH4lXwa
         j8VQ==
X-Gm-Message-State: ABy/qLZzqezHyN4rjBE8pjs6vYsI1jn4VOyi0MwFjN1H3Aeh/DOfdXZt
	4rmURMPnFuqZpTH81V3gV4UIxY3iATl8yf5c5ubcsg==
X-Google-Smtp-Source: APBJJlG+Abqdzww+d0y6okscA3laf/TFZ18QCcEuBV7TMn7e7xrhA8kWZD4Qb4hQuqzZUBRh1XpmOw19AOxzsC1IwXE=
X-Received: by 2002:a05:6870:c081:b0:1be:c2c5:a1d2 with SMTP id
 c1-20020a056870c08100b001bec2c5a1d2mr10387924oad.59.1690915685976; Tue, 01
 Aug 2023 11:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230730131750.16552-1-tuananhlfc@gmail.com> <CAKH8qBtNaEW4pEj7Y1WiLoPk2aMPoq3AuO14D=OF_NCN255awQ@mail.gmail.com>
 <34890307-ca7a-ffa8-321d-eb5ad0db4a5a@gmail.com>
In-Reply-To: <34890307-ca7a-ffa8-321d-eb5ad0db4a5a@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 1 Aug 2023 11:47:54 -0700
Message-ID: <CAKH8qBsy+PaFzCX7jNzHSWwFcKT5yEGyTihd6iwhOK1HPy5HeA@mail.gmail.com>
Subject: Re: [PATCH v3] samples/bpf: Fix build out of source tree
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, bpf@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 8:56=E2=80=AFAM Anh Tuan Phan <tuananhlfc@gmail.com>=
 wrote:
>
>
>
> On 01/08/2023 00:17, Stanislav Fomichev wrote:
> > On Sun, Jul 30, 2023 at 6:18=E2=80=AFAM Anh Tuan Phan <tuananhlfc@gmail=
.com> wrote:
> >>
> >> This commit fixes a few compilation issues when building out of source
> >> tree. The command that I used to build samples/bpf:
> >>
> >> export KBUILD_OUTPUT=3D/tmp
> >> make V=3D1 M=3Dsamples/bpf
> >>
> >> The compilation failed since it tried to find the header files in the
> >> wrong places between output directory and source tree directory
> >
> > Still doesn't apply cleanly, most likely due to commit bbaf1ff06af4
> > ("bpf: Replace deprecated -target with --target=3D for Clang").
> > Please rebase and repost. Also add [PATCH bpf-next v4] tag.
> >
>
> I rebased the commit from bpf tree so it's the reason for your failed
> applied. Have rebased from bpf-next tree and sent a "PATCH bpf-next v4"
> patch.

Yeah, not sure it should go via bpf tree. We don't have a good Fixes
tag and it's about samples, so let's keep bpf-next. Thx!

> Thank you!
>
> >
> >> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> >> ---
> >> Changes from v1:
> >> - Unconditionally add "-I $(objtree)/$(obj)" to _tprogc_flags and drop=
 unnecessary part
> >> Reference:
> >> - v1: https://lore.kernel.org/all/67bec6a9-af59-d6f9-2630-17280479a1f7=
@gmail.com/
> >> - v2: https://lore.kernel.org/all/2ba1c076-f5bf-432f-50c1-72c845403167=
@gmail.com/
> >> ---
> >>   samples/bpf/Makefile        | 10 +++++-----
> >>   samples/bpf/Makefile.target |  9 +--------
> >>   2 files changed, 6 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> >> index 615f24ebc49c..cfc960b3713a 100644
> >> --- a/samples/bpf/Makefile
> >> +++ b/samples/bpf/Makefile
> >> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_k=
ern.h
> >>   # Override includes for xdp_sample_user.o because $(srctree)/usr/inc=
lude in
> >>   # TPROGS_CFLAGS causes conflicts
> >>   XDP_SAMPLE_CFLAGS +=3D -Wall -O2 \
> >> -                    -I$(src)/../../tools/include \
> >> -                    -I$(src)/../../tools/include/uapi \
> >> +                    -I$(srctree)/tools/include \
> >> +                    -I$(srctree)/tools/include/uapi \
> >>                       -I$(LIBBPF_INCLUDE) \
> >> -                    -I$(src)/../../tools/testing/selftests/bpf
> >> +                    -I$(srctree)/tools/testing/selftests/bpf
> >>
> >>   $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS =3D $(XDP_SAMPLE_CFLAGS)
> >>   $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_sha=
red.h
> >> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bp=
f.o
> >>   $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bp=
f.h $(src)/xdp_sample_shared.h
> >>          @echo "  CLANG-BPF " $@
> >>          $(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
> >> -               -Wno-compare-distinct-pointer-types -I$(srctree)/inclu=
de \
> >> +               -Wno-compare-distinct-pointer-types -I$(obj) -I$(srctr=
ee)/include \
> >>                  -I$(srctree)/samples/bpf -I$(srctree)/tools/include \
> >>                  -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
> >>                  -c $(filter %.bpf.c,$^) -o $@
> >> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps :=3D xdp_router_ipv4.b=
pf.o xdp_sample.bpf.o
> >>
> >>   LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LIN=
KED_SKELS),$($(skel)-deps)))
> >>
> >> -BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(src)/*.bpf.c))
> >> +BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
> >>   BPF_OBJS_LINKED :=3D $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_L=
INKED))
> >>   BPF_SKELS_LINKED :=3D $(addprefix $(obj)/,$(LINKED_SKELS))
> >>
> >> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
> >> index 7621f55e2947..d2fab959652e 100644
> >> --- a/samples/bpf/Makefile.target
> >> +++ b/samples/bpf/Makefile.target
> >> @@ -38,14 +38,7 @@ tprog-cobjs  :=3D $(addprefix $(obj)/,$(tprog-cobjs=
))
> >>   # Handle options to gcc. Support building with separate output direc=
tory
> >>
> >>   _tprogc_flags   =3D $(TPROGS_CFLAGS) \
> >> -                 $(TPROGCFLAGS_$(basetarget).o)
> >> -
> >> -# $(objtree)/$(obj) for including generated headers from checkin sour=
ce files
> >> -ifeq ($(KBUILD_EXTMOD),)
> >> -ifdef building_out_of_srctree
> >> -_tprogc_flags   +=3D -I $(objtree)/$(obj)
> >> -endif
> >> -endif
> >> +                 -I $(objtree)/$(obj)
> >>
> >>   tprogc_flags    =3D -Wp,-MD,$(depfile) $(_tprogc_flags)
> >>
> >> --
> >> 2.34.1
> >>

