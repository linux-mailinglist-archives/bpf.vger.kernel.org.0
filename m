Return-Path: <bpf+bounces-6220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6B27671D8
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE361C217E9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E830D1640B;
	Fri, 28 Jul 2023 16:30:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A811C1FB51
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:30:20 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDC2448C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:30:17 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a1ebb85f99so1838978b6e.2
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690561816; x=1691166616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERdUxHgCtf4PRByjyNFY0jw8J1N+cRKtHihzJzi9tpg=;
        b=AvMPpLJiuuPjWrVXfDiUdn4OY9iS6NOlRJtb8rvI4D3OXAQ4Mh33UiiLA80eH5Pq/A
         F5O9JAbb3L7uBtsbVWbL1Zr+CIL3KS2i9znF9XNqaZvcJPhw/K7iaFkhPsAKcH3IFHBo
         xGBScn2T7QBpDrKCbhoPVdVwRPHOhZJO1raURSW4lbTLbLeUai9AfXC9tWHtp06oszsQ
         AsBY3ElKqNn3bR6qh415/s+wnZ63QY2WHrEGp9vwfK2TuSJIZf8/EZnH90FUe34wiCHp
         OKVU98Q+pD5nawHYXHo2lcJNQegsDACQ9FnyLyeji+2wXql/3mG7FB9eOmYGttej/YSk
         Te3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690561816; x=1691166616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERdUxHgCtf4PRByjyNFY0jw8J1N+cRKtHihzJzi9tpg=;
        b=WA/47S4i40UIGtOZd7sZ9CNdEI8lHYLbm33TjXIEX3EE81534oxmwT5XbnVMx6BFrn
         1b28/ngzgHWgwXDVbRBae47yNjBsZMlf+qZSyFFpb7DG09Z+I6lcTnRSF3pzvtoP6B7t
         xhSEZkjuzZXhQHVVl2jJj5y87ccVlMlUcADmHu4c4t9wv2cMi29kn8aeLionpWo18XEj
         9hpQJXgs24B09jpBUYnl6Ot4cuC+bwFSuhdC9JboqAWAuo2a2q2VUJtYap2k0m6c2JHE
         pWAH4fcPjtKj6SEZyi3aOCzp5DhQCkeFhJtIKSO6Lngf5m3WGNT7As4hNtDSGPWV9w9M
         acFA==
X-Gm-Message-State: ABy/qLb45j7Jp41Fif3Upf9jyyAN0kmcLk7nwdkdlnfIAbeEwzJlaAXe
	r9XIG5BrhvGDeluae0jJ+pL11BVIyHPK5UaXbjquaw==
X-Google-Smtp-Source: APBJJlGWaEvPknSFylhXCPdiFY+yqrc0KovyuYagF+Qnrzppivy4Gy9lX+hlPJtfjPuJBYMDlVrbg2Kjut3WDblUy3Y=
X-Received: by 2002:a05:6808:1689:b0:3a1:e17a:b3fb with SMTP id
 bb9-20020a056808168900b003a1e17ab3fbmr4050638oib.1.1690561816550; Fri, 28 Jul
 2023 09:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ba1c076-f5bf-432f-50c1-72c845403167@gmail.com>
In-Reply-To: <2ba1c076-f5bf-432f-50c1-72c845403167@gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Fri, 28 Jul 2023 09:30:04 -0700
Message-ID: <CAKH8qBtJ-Nb--BqH+J6K4S++J7J-8uHTPewS3BrVA86GBry=sQ@mail.gmail.com>
Subject: Re: [PATCH v2] samples/bpf: Fix build out of source tree
To: Anh Tuan Phan <tuananhlfc@gmail.com>
Cc: ast <ast@kernel.org>, daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>, 
	"martin.lau" <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-kernel-mentees <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 5:43=E2=80=AFPM Anh Tuan Phan <tuananhlfc@gmail.com=
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

I was going to test it locally, but I can't apply it. Patchwork also
complains about the same issue:
  stderr: 'error: corrupt patch at line 33

Are you copy-pasting it to gmail maybe? (or manually edited it after
git format-patch?)
Maybe rebase, and resend properly with git send-email?

> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
> ---
> Changes from v1:
> - Unconditionally add "-I $(objtree)/$(obj)" to _tprogc_flags and drop
>   unnecessary part
> Reference:
> - v1:
> https://lore.kernel.org/all/67bec6a9-af59-d6f9-2630-17280479a1f7@gmail.co=
m/
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
>  $(obj)/%.bpf.o: $(src)/%.bpf.c $(obj)/vmlinux.h $(src)/xdp_sample.bpf.h
> $(src)/xdp_sample_shared.h
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
o
> xdp_sample.bpf.o
>
>  LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.bpf.c,$(foreach
> skel,$(LINKED_SKELS),$($(skel)-deps)))
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
> -# $(objtree)/$(obj) for including generated headers from checkin source
> files
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

