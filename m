Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE9468A5EE
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 23:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBCWQj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 17:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjBCWQb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 17:16:31 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446E2199E6;
        Fri,  3 Feb 2023 14:16:29 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m2so19181194ejb.8;
        Fri, 03 Feb 2023 14:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yyIzc/EPH8/rkFm5mu9NZaeZeycgNNKv+q/PlZgdU58=;
        b=cKtEpdYz6lsT/Cen89RhZrowvyDMxmlekzJy81R8HgMi9P0DKVx9fVLPuM51/Utk/X
         ShOBXCY2WSn3s7m49CINrZ5UoKYWp1xyAoqovGKFNP2HuSomPfz5xsWrN84z+Ex3aHK6
         6MD4kIsSq2dzhXnwXhayuf71gPzfYlm8zqzV9uys0rvJNrO0pO7Yt/bq47ShKFcnwd7j
         Sw4cQrsT6j6jhQY+WsAC7yiBFUf8fn524dJHKu8nXi10w6TPEgvEWFM2ubPPYE35sYrK
         sVBmRd4lbCuC9+dcnuPPBPwscrM9NROUrIuTkvUsB2XvYnSN1Jx2m2shHpjCCqBczBXh
         ZuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yyIzc/EPH8/rkFm5mu9NZaeZeycgNNKv+q/PlZgdU58=;
        b=X7PtzyXnbT+ly3vMAT5FXCeB/tEzLwfRTKStmlsUfxAcOhkXqKO9iafJLxLGr2138M
         1rhXwwrDjOoAAkQG9wXlGA4SapjFyRt6/Dqv2mQp/ECJOW3Hk3cGsAeNEczdZYoIW7OD
         qdw7zITmD/gr3QzN7DcmmMtPhMFgC4dC/W/xgH3rTHyDnL6GQdPOQE+lTbg+lsxINiDa
         GG21z1mtGE7NvM5u9ngbYqTeuVBNcTH0iqNZyzPin3AVBLOZRY0BrRzjTxkA9ILNtoKq
         VwtCrjg+5e0IE7zCwXTWJOfjug+tdZVh5y6lZ5b8XkM00gnXb5PQw586F1esHVnqIopW
         dW7g==
X-Gm-Message-State: AO0yUKXZId/ewc0WPptCR1kWEILRJlW86kLgYM9Sx9VJ/K3gItfSTxeI
        Je7JrmejuqmHCma/NBYRd4zm6uAO0yQ4kbSaZiE=
X-Google-Smtp-Source: AK7set+nyz4Mu1ReWCRNle2OkSZ74cM49oZhh6bOdKS6RpbOYx3+yIaHsF1yw5cVe0n0HHVLvujMf0EN07x8wF/BEjM=
X-Received: by 2002:a17:906:cb9a:b0:877:5b9b:b426 with SMTP id
 mf26-20020a170906cb9a00b008775b9bb426mr3153055ejb.12.1675462587721; Fri, 03
 Feb 2023 14:16:27 -0800 (PST)
MIME-Version: 1.0
References: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
 <CAEf4BzZfBb75smH0uTn4E36T6vk1xhZZ+5_ONtdh9aFQCMH2pw@mail.gmail.com> <496935ea-298e-db57-bcd1-b3fb6ae6608d@loongson.cn>
In-Reply-To: <496935ea-298e-db57-bcd1-b3fb6ae6608d@loongson.cn>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Feb 2023 14:16:15 -0800
Message-ID: <CAEf4BzY5VNgPeR4cTkcpVAy4FSek2MaTMPYHKcGdmCVUbBbpfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix build errors if CONFIG_NF_CONNTRACK=m
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 28, 2023 at 10:25 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>
>
> On 01/24/2023 07:17 AM, Andrii Nakryiko wrote:
> > On Tue, Jan 17, 2023 at 11:57 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
> >>
> >> If CONFIG_NF_CONNTRACK=m, there are no definitions of NF_NAT_MANIP_SRC
> >> and NF_NAT_MANIP_DST in vmlinux.h, build test_bpf_nf.c failed.
> >>
> >> $ make -C tools/testing/selftests/bpf/
> >>
> >>   CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> >> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
> >>                 bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> >>                                                        ^
> >> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_MANIP_DST'
> >>                 bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> >>                                                        ^
> >> 2 errors generated.
> >>
> >> Copy the definitions in include/net/netfilter/nf_nat.h to test_bpf_nf.c,
> >> in order to avoid redefinitions if CONFIG_NF_CONNTRACK=y, rename them with
> >> ___local suffix. This is similar with commit 1058b6a78db2 ("selftests/bpf:
> >> Do not fail build if CONFIG_NF_CONNTRACK=m/n").
> >>
> >> Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kfunc")
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> >>  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> >> index 227e85e..9fc603c 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> >> @@ -34,6 +34,11 @@ __be16 dport = 0;
> >>  int test_exist_lookup = -ENOENT;
> >>  u32 test_exist_lookup_mark = 0;
> >>
> >> +enum nf_nat_manip_type___local {
> >> +       NF_NAT_MANIP_SRC___local,
> >> +       NF_NAT_MANIP_DST___local
> >> +};
> >> +
> >>  struct nf_conn;
> >>
> >>  struct bpf_ct_opts___local {
> >> @@ -58,7 +63,7 @@ int bpf_ct_change_timeout(struct nf_conn *, u32) __ksym;
> >>  int bpf_ct_set_status(struct nf_conn *, u32) __ksym;
> >>  int bpf_ct_change_status(struct nf_conn *, u32) __ksym;
> >>  int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
> >> -                       int port, enum nf_nat_manip_type) __ksym;
> >> +                       int port, enum nf_nat_manip_type___local) __ksym;
> >>
> >>  static __always_inline void
> >>  nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
> >> @@ -157,10 +162,10 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
> >>
> >>                 /* snat */
> >>                 saddr.ip = bpf_get_prandom_u32();
> >> -               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> >> +               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC___local);
> >>                 /* dnat */
> >>                 daddr.ip = bpf_get_prandom_u32();
> >> -               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> >> +               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST___local);
> >>
> >
> > it would be a bit more reliable if you used `bpf_core_enum_value(enum
> > nf_nat_manip_type___local, NF_NAT_MANIP_DST___local)`. That would make
> > libbpf substitute correct absolute value, if actual enum
> > nf_nat_manip_type in kernel ever changed. Please consider a follow up
> > patch for this.
>
> Sorry for the late reply, I tested the code as your suggestion, but it
> failed.
>
> failed to resolve CO-RE relocation <enumval_value> [101] enum
> nf_nat_manip_type___local::NF_NAT_MANIP_SRC___local = 0


Was nf_conntrack kernel module loaded at the time when you ran the
test? If yes, what's the output of

bpftool btf dump file /sys/kernel/btf/nf_conntrack | grep nf_nat_manip_type

?

>
> Is it necessary to send a follow patch now? Thank you.
>
> Here are the test results.
>
> (1) bpf_nf passed with the current code if CONFIG_NF_CONNTRACK=m:
>
> [root@fedora bpf]# ./test_progs -a bpf_nf
> #16/1    bpf_nf/xdp-ct:OK
> #16/2    bpf_nf/tc-bpf-ct:OK
> #16/3    bpf_nf/alloc_release:OK
> #16/4    bpf_nf/insert_insert:OK
> #16/5    bpf_nf/lookup_insert:OK
> #16/6    bpf_nf/set_timeout_after_insert:OK
> #16/7    bpf_nf/set_status_after_insert:OK
> #16/8    bpf_nf/change_timeout_after_alloc:OK
> #16/9    bpf_nf/change_status_after_alloc:OK
> #16/10   bpf_nf/write_not_allowlisted_field:OK
> #16      bpf_nf:OK
> Summary: 1/10 PASSED, 0 SKIPPED, 0 FAILED
>
> (2) bpf_nf failed with the following changes if CONFIG_NF_CONNTRACK=m:
>
> [yangtiezhu@fedora bpf.git]$ git diff
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> index 9fc603c9d673..f56ba60ab809 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -2,6 +2,7 @@
>   #include <vmlinux.h>
>   #include <bpf/bpf_helpers.h>
>   #include <bpf/bpf_endian.h>
> +#include <bpf/bpf_core_read.h>
>
>   #define EAFNOSUPPORT 97
>   #define EPROTO 71
> @@ -162,10 +163,14 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *,
> struct bpf_sock_tuple *, u32,
>
>                  /* snat */
>                  saddr.ip = bpf_get_prandom_u32();
> -               bpf_ct_set_nat_info(ct, &saddr, sport,
> NF_NAT_MANIP_SRC___local);
> +               bpf_ct_set_nat_info(ct, &saddr, sport,
> +                                   bpf_core_enum_value(enum
> nf_nat_manip_type___local,
> +
> NF_NAT_MANIP_SRC___local));
>                  /* dnat */
>                  daddr.ip = bpf_get_prandom_u32();
> -               bpf_ct_set_nat_info(ct, &daddr, dport,
> NF_NAT_MANIP_DST___local);
> +               bpf_ct_set_nat_info(ct, &daddr, dport,
> +                                   bpf_core_enum_value(enum
> nf_nat_manip_type___local,
> +
> NF_NAT_MANIP_DST___local));
>
>                  ct_ins = bpf_ct_insert_entry(ct);
>                  if (ct_ins) {
>
> [root@fedora bpf]# ./test_progs -a bpf_nf
> ...
> All error logs:
> libbpf: prog 'nf_xdp_ct_test': BPF program load failed: Invalid argument
> libbpf: prog 'nf_xdp_ct_test': -- BEGIN PROG LOAD LOG --
> ...
> libbpf: failed to load object 'test_bpf_nf'
> libbpf: failed to load BPF skeleton 'test_bpf_nf': -22
> test_bpf_nf_ct:FAIL:test_bpf_nf__open_and_load unexpected error: -22
> #16/1    bpf_nf/xdp-ct:FAIL
> libbpf: prog 'nf_xdp_ct_test': BPF program load failed: Invalid argument
> libbpf: prog 'nf_xdp_ct_test': -- BEGIN PROG LOAD LOG --
> ...
> 217: (bf) r1 = r7                     ;
> R1_w=ptr_nf_conn___init(ref_obj_id=18,off=0,imm=0)
> R7=ptr_nf_conn___init(ref_obj_id=18,off=0,imm=0) refs=18
> 218: <invalid CO-RE relocation>
> failed to resolve CO-RE relocation <enumval_value> [101] enum
> nf_nat_manip_type___local::NF_NAT_MANIP_SRC___local = 0
> processed 170 insns (limit 1000000) max_states_per_insn 0 total_states
> 12 peak_states 12 mark_read 2
> -- END PROG LOAD LOG --
> libbpf: prog 'nf_xdp_ct_test': failed to load: -22
> libbpf: failed to load object 'test_bpf_nf'
> libbpf: failed to load BPF skeleton 'test_bpf_nf': -22
> test_bpf_nf_ct:FAIL:test_bpf_nf__open_and_load unexpected error: -22
> #16/2    bpf_nf/tc-bpf-ct:FAIL
> #16      bpf_nf:FAIL
> Summary: 0/8 PASSED, 0 SKIPPED, 1 FAILED
>
> Thanks,
> Tiezhu
>
