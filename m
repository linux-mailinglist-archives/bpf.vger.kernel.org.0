Return-Path: <bpf+bounces-6459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB3E769F3A
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9104D2815F2
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AB21D2F6;
	Mon, 31 Jul 2023 17:18:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088F1D2EE
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 17:18:15 +0000 (UTC)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ABBE48
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 10:17:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2954712a12.2
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690823842; x=1691428642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YySrW/mX3IXPNrvq1xkd6fhbbO6Lnq+twOHWvtcNUYc=;
        b=p5LLEbIQFJTtr/NRAExSCkkzmun+3iHr4QHpWSL/GCXT8ocmDLVb1bn2y0iEDazCz9
         CAPe3Hl+GEqpzpNquGZgTMMFpx4NQgbYlpVQST0/u4V2xohbOfRNT/rT4hAj7Q/v+6HC
         x/51hMbN5kgVqP5A0jSImllP5Rwexe9/7rlq9v6BEqPEu54dS76wrd+Wp2bcwNOlY93+
         eHzeE5cXlJuLI0H07Xd5wVjXALLga2POK7oF9MNFG9atGb4npEP77nquSZPhRto2HlP9
         ehJrn8DMhLZJy9XHoYwULOY5FadwULWmNPLoLspjJZPaHF8uZ5dJVcupmelvPhrOBr3o
         X5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823842; x=1691428642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YySrW/mX3IXPNrvq1xkd6fhbbO6Lnq+twOHWvtcNUYc=;
        b=K9zUyIq5J/mRi7PRCV9COg2H9Nd70bkYfsYpU69rJ/ZIdH5BqKQl2LAenKZXApnhab
         ses9jSR0nwFZgT1+YmxRgNWIds61kt+a6sQjM7fBQWpUoqPFP5ChUz+4EhAeyNlCJapB
         PR0389sNYrW2VwXzRa/32Elh4NioMULw9780IaqpOHIwpavqdkq3V+GAOHA0+SukxQV7
         cOpS8U9ZunouET/B0+TKqUFbV7ZZNxfH06fjm0ZBzTx0r/ZWxbsq2yAR8kQTsq6EQtkQ
         n4fMj0VNeGUCSVsHUKVh8iuCXSsbIt16yt8N1x9Nk705BxBZZTEoCEwB7VaevyiOkbd6
         2Y8g==
X-Gm-Message-State: ABy/qLaMpFLTxMKG9yzetto8ztknTsVU1TmZl+w0BpxHCYIxmsLVwCC4
	to2XIOui/HC9IaU/Hp8CA4cA6TJMC0vFstkmb0ZZiQ==
X-Google-Smtp-Source: APBJJlHfyeIugZo1uvIqNr9v6g8QvSHtF4QRH7BpKAi2Wd3EgDQn20WeLAYr4ne7jQmvXgNEOK7zVi3jFCnEXvUkgtI=
X-Received: by 2002:a17:90b:1102:b0:263:ebab:a152 with SMTP id
 gi2-20020a17090b110200b00263ebaba152mr8706038pjb.19.1690823842533; Mon, 31
 Jul 2023 10:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230730131750.16552-1-tuananhlfc@gmail.com>
In-Reply-To: <20230730131750.16552-1-tuananhlfc@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 31 Jul 2023 10:17:11 -0700
Message-ID: <CAKH8qBtNaEW4pEj7Y1WiLoPk2aMPoq3AuO14D=OF_NCN255awQ@mail.gmail.com>
Subject: Re: [PATCH v3] samples/bpf: Fix build out of source tree
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, bpf@vger.kernel.org, 
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

On Sun, Jul 30, 2023 at 6:18=E2=80=AFAM Anh Tuan Phan <tuananhlfc@gmail.com=
> wrote:
>
> This commit fixes a few compilation issues when building out of source
> tree. The command that I used to build samples/bpf:
>
> export KBUILD_OUTPUT=3D/tmp
> make V=3D1 M=3Dsamples/bpf
>
> The compilation failed since it tried to find the header files in the
> wrong places between output directory and source tree directory

Still doesn't apply cleanly, most likely due to commit bbaf1ff06af4
("bpf: Replace deprecated -target with --target=3D for Clang").
Please rebase and repost. Also add [PATCH bpf-next v4] tag.


> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
> Changes from v1:
> - Unconditionally add "-I $(objtree)/$(obj)" to _tprogc_flags and drop un=
necessary part
> Reference:
> - v1: https://lore.kernel.org/all/67bec6a9-af59-d6f9-2630-17280479a1f7@gm=
ail.com/
> - v2: https://lore.kernel.org/all/2ba1c076-f5bf-432f-50c1-72c845403167@gm=
ail.com/
> ---
>  samples/bpf/Makefile        | 10 +++++-----
>  samples/bpf/Makefile.target |  9 +--------
>  2 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 615f24ebc49c..cfc960b3713a 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -341,10 +341,10 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern=
.h
>  # Override includes for xdp_sample_user.o because $(srctree)/usr/include=
 in
>  # TPROGS_CFLAGS causes conflicts
>  XDP_SAMPLE_CFLAGS +=3D -Wall -O2 \
> -                    -I$(src)/../../tools/include \
> -                    -I$(src)/../../tools/include/uapi \
> +                    -I$(srctree)/tools/include \
> +                    -I$(srctree)/tools/include/uapi \
>                      -I$(LIBBPF_INCLUDE) \
> -                    -I$(src)/../../tools/testing/selftests/bpf
> +                    -I$(srctree)/tools/testing/selftests/bpf
>
>  $(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS =3D $(XDP_SAMPLE_CFLAGS)
>  $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.=
h
> @@ -393,7 +393,7 @@ $(obj)/xdp_router_ipv4.bpf.o: $(obj)/xdp_sample.bpf.o
>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h =
$(src)/xdp_sample_shared.h
>         @echo "  CLANG-BPF " $@
>         $(Q)$(CLANG) -g -O2 -target bpf -D__TARGET_ARCH_$(SRCARCH) \
> -               -Wno-compare-distinct-pointer-types -I$(srctree)/include =
\
> +               -Wno-compare-distinct-pointer-types -I$(obj) -I$(srctree)=
/include \
>                 -I$(srctree)/samples/bpf -I$(srctree)/tools/include \
>                 -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
>                 -c $(filter %.bpf.c,$^) -o $@
> @@ -412,7 +412,7 @@ xdp_router_ipv4.skel.h-deps :=3D xdp_router_ipv4.bpf.=
o xdp_sample.bpf.o
>
>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.bpf.c,$(foreach skel,$(LINKED_=
SKELS),$($(skel)-deps)))
>
> -BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(src)/*.bpf.c))
> +BPF_SRCS_LINKED :=3D $(notdir $(wildcard $(srctree)/$(src)/*.bpf.c))
>  BPF_OBJS_LINKED :=3D $(patsubst %.bpf.c,$(obj)/%.bpf.o, $(BPF_SRCS_LINKE=
D))
>  BPF_SKELS_LINKED :=3D $(addprefix $(obj)/,$(LINKED_SKELS))
>
> diff --git a/samples/bpf/Makefile.target b/samples/bpf/Makefile.target
> index 7621f55e2947..d2fab959652e 100644
> --- a/samples/bpf/Makefile.target
> +++ b/samples/bpf/Makefile.target
> @@ -38,14 +38,7 @@ tprog-cobjs  :=3D $(addprefix $(obj)/,$(tprog-cobjs))
>  # Handle options to gcc. Support building with separate output directory
>
>  _tprogc_flags   =3D $(TPROGS_CFLAGS) \
> -                 $(TPROGCFLAGS_$(basetarget).o)
> -
> -# $(objtree)/$(obj) for including generated headers from checkin source =
files
> -ifeq ($(KBUILD_EXTMOD),)
> -ifdef building_out_of_srctree
> -_tprogc_flags   +=3D -I $(objtree)/$(obj)
> -endif
> -endif
> +                 -I $(objtree)/$(obj)
>
>  tprogc_flags    =3D -Wp,-MD,$(depfile) $(_tprogc_flags)
>
> --
> 2.34.1
>

