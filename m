Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8255587D6
	for <lists+bpf@lfdr.de>; Thu, 23 Jun 2022 20:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiFWSwc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 14:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239675AbiFWSwN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 14:52:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A0FE014
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 10:57:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id t5so10188337eje.1
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3o7lvY9y14bRaUXUMDEqnxgARMhV76ElzGzrTEpkW0=;
        b=RYZEP/Lj3xajAVAEazBpjfQCYGrtpz7YPf2qY3DjFckdAGo6THiKtoCPrJn3QhF1LC
         etmVnVLCC9WmeaTkdFnleguA3XoI57Oiy2HgKUttcgDw1SApH9PpdI1XxBAUiD2iieU0
         zYHuOANDJ5C6hcbY85cMbIqCtDsF7F9p93LF0eVQJ+ODxNrz+80htwXBL4ahLHn+aqu1
         iP2yZLVpsVerxGhvLuh92ydNL8XWAtayZD0Bb/RWgFxWRnIoXWzvsOcJjZavzBupLB3G
         2yfyneZTa/pd/tRcNk7Ic99pbkjC6nPAvXDrejI90kjO8nKEK/kNh9Cvh3I9uzJ7QQo3
         4Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3o7lvY9y14bRaUXUMDEqnxgARMhV76ElzGzrTEpkW0=;
        b=geHxcl0tU2oVBeUJzK1V002Iv9bmuwUURMTkOI5oPcuAlFZfGCD8Yiwl3QR2qV1mts
         HVymq6UHQ114qPAir1te1uVbLFDvJgVNpKPu2gGWGy2UXTQQAnyjC4/tFL62p8ksUD2W
         PpezZTuTMRPAUrp/BhEa3v99/cQL/557RiKyUpB4aP8SYwVg8hQrRqO2A5V9o6sG/jt4
         8kaExFHhdKYYqGFZufZB9sY1GBl0Em3PzGv76GG/HXlrf9cnv7d/kxOUB5U+NHZCJlNK
         z3SBZnxX6Sdl8ieiJYpLmsXIwkLnAhUovRkQQslfuwhUg9bT2coLaFld9xc+aOCA347/
         YxLA==
X-Gm-Message-State: AJIora+PKFETz78d144ixjcaMRAQnnm5WHIgQB38k77jK27/4caTYwm4
        k8VYd3fnS8vn+WM+XYFpGmP7EoT5n02BG1H2bX4=
X-Google-Smtp-Source: AGRyM1uBYizx0FuZ0GNlk6No3NcgioOCMvgX7pmIVGqb7o8o0YhS5/v0LI2BVY+wZEVdPl1MHOE8Wk3qckOugcNTUCc=
X-Received: by 2002:a17:906:3f51:b0:712:3945:8c0d with SMTP id
 f17-20020a1709063f5100b0071239458c0dmr9270826ejj.302.1656007026756; Thu, 23
 Jun 2022 10:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <1655982614-13571-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1655982614-13571-1-git-send-email-alan.maguire@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 23 Jun 2022 10:56:54 -0700
Message-ID: <CAEf4BzbbME=oZbp26=OMVpMSfrH-6Bp38ELcY6oNYSCAsnobQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: support building selftests when CONFIG_NF_CONNTRACK=m
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 23, 2022 at 4:10 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> when CONFIG_NF_CONNTRACK=m, vmlinux BTF does not contain
> BPF_F_CURRENT_NETNS or bpf_ct_opts; they are both found in nf_conntrack
> BTF; for example:
>
> bpftool btf dump file /sys/kernel/btf/nf_conntrack|grep ct_opts
> [114754] STRUCT 'bpf_ct_opts' size=12 vlen=5
>
> This causes compilation errors as follows:
>
>   CLNG-BPF [test_maps] xdp_synproxy_kern.o
> progs/xdp_synproxy_kern.c:83:14: error: declaration of 'struct bpf_ct_opts' will not be visible outside of this function [-Werror,-Wvisibility]
>                                          struct bpf_ct_opts *opts,
>                                                 ^
> progs/xdp_synproxy_kern.c:89:14: error: declaration of 'struct bpf_ct_opts' will not be visible outside of this function [-Werror,-Wvisibility]
>                                          struct bpf_ct_opts *opts,
>                                                 ^
> progs/xdp_synproxy_kern.c:397:15: error: use of undeclared identifier 'BPF_F_CURRENT_NETNS'; did you mean 'BPF_F_CURRENT_CPU'?
>                 .netns_id = BPF_F_CURRENT_NETNS,
>                             ^~~~~~~~~~~~~~~~~~~
>                             BPF_F_CURRENT_CPU
> tools/testing/selftests/bpf/tools/include/vmlinux.h:43115:2: note: 'BPF_F_CURRENT_CPU' declared here
>         BPF_F_CURRENT_CPU = 4294967295,
>
> While tools/testing/selftests/bpf/config does specify
> CONFIG_NF_CONNTRACK=y, it would be good to use this case to show
> how we can generate a module header file via split BTF.
>
> In the selftests Makefile, we define NF_CONNTRACK BTF via VMLINUX_BTF
> (thus gaining the path determination logic it uses).  If the nf_conntrack
> BTF file exists (which means it is built as a module), we run
> "bpftool btf dump" to generate module BTF, and if not we simply copy
> vmlinux.h to nf_conntrack.h; this allows us to avoid having to pass
> a #define or deal with CONFIG variables in the program.
>
> With these changes the test builds and passes:
>
> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Why not just define expected types locally (doesn't have to be a full
definition)? Adding extra rule and generating header for each
potential module seems like a huge overkill.


>  tools/testing/selftests/bpf/Makefile                  | 11 +++++++++++
>  tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c |  2 +-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index cb8e552..a5fa636 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -141,6 +141,8 @@ VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>  ifeq ($(VMLINUX_BTF),)
>  $(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)")
>  endif
> +# If nf_conntrack is a module, need BTF for it also
> +NF_CONNTRACK_BTF ?= $(shell dirname $(VMLINUX_BTF))/nf_conntrack
>
>  # Define simple and short `make test_progs`, `make test_sysctl`, etc targets
>  # to build individual tests.
> @@ -280,6 +282,14 @@ else
>         $(Q)cp "$(VMLINUX_H)" $@
>  endif
>
> +$(INCLUDE_DIR)/nf_conntrack.h: $(INCLUDE_DIR)/vmlinux.h
> +ifneq ("$(wildcard $(NF_CONNTRACK_BTF))","")
> +       $(call msg,GEN,,$@)
> +       $(BPFTOOL) btf dump file $(NF_CONNTRACK_BTF) format c > $@
> +else
> +       $(Q)cp $(INCLUDE_DIR)/vmlinux.h $@
> +endif
> +
>  $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids   \
>                        $(TOOLSDIR)/bpf/resolve_btfids/main.c    \
>                        $(TOOLSDIR)/lib/rbtree.c                 \
> @@ -417,6 +427,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:                         \
>                      $(TRUNNER_BPF_PROGS_DIR)/%.c                       \
>                      $(TRUNNER_BPF_PROGS_DIR)/*.h                       \
>                      $$(INCLUDE_DIR)/vmlinux.h                          \
> +                    $$(INCLUDE_DIR)/nf_conntrack.h                     \
>                      $(wildcard $(BPFDIR)/bpf_*.h)                      \
>                      $(wildcard $(BPFDIR)/*.bpf.h)                      \
>                      | $(TRUNNER_OUTPUT) $$(BPFOBJ)
> diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
> index 9fd62e9..8c5f46e 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>  /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
>
> -#include "vmlinux.h"
> +#include "nf_conntrack.h"
>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_endian.h>
> --
> 1.8.3.1
>
