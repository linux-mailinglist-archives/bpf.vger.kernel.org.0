Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71810678BE7
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 00:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjAWXRv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 18:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAWXRv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 18:17:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51961D50D;
        Mon, 23 Jan 2023 15:17:49 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id v6so34672381ejg.6;
        Mon, 23 Jan 2023 15:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rGHQVT6OOGT/1kN7WFy1iuELzwSb3GW4ljiie40ssGc=;
        b=bwIjx0/nDLuZ7FsuDbvsDQXX63weXAifErsOCvGlSgINo0kfaUVeJzkcUZ9UokIR9w
         GU98gDLCoRP2xD/e4z/YjYgw/lPnlCOdp99e0ChZv/ZWIVDGkFD4ESs87JVKduEYm77k
         dlRnAE50km6Yij9AOVzU02CG6HbrcwaRquG+e5ufQgAPbvcg2ttZ3RAu3AeCl0kR4+ax
         2WTet5AtQLr/rTTJxUfcTad9pxrxRiy9gqQAd5zEcKnxRxg1qZcV6Alq9JvJiqIkOutO
         Z9qKoy/ttJx5lnTvs4jA/dwb3SIMtWac/SLT9s/XEG8siOxmOhXJCMpVu0iWC7U0hfRz
         kc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rGHQVT6OOGT/1kN7WFy1iuELzwSb3GW4ljiie40ssGc=;
        b=H4QESPWjg8VzLQPaMU1yZGgBLp1s3ZDkRahssVEQ3FF7ch2p0ej1e7HNchB+BahoYd
         /D/SoBa7Vtfv740PwGSMM/lSJ7XJgrxFmH/TXOz6VXQuzYrA0m5R7N/g8j719WajWwVF
         ZHc5VaycRnufyjwgsbiQwN/xpwCjjRyrvcnoG1bXEMFvbJ0tTwAe3ksdDv9ra1gS6b9S
         lso3Nt9oqVHnPiTuBJclHctsw45ynQ/byxsSZ9f2hWFgmbsxZQHOB3t8FaXawsu5tCBA
         N2W279hRBIdX6sQAIMpoiSdafOL1QS32gDOk2Sq7g1iF0IS/JEXGmntrIWKJ09e8HNYI
         wuRw==
X-Gm-Message-State: AFqh2koXY+FHPxqOIPjAOkuH6CZSIzC/sQpVEKR0oCt9KWjkXolXhAei
        hSdeeX2X+7tDryMIAuYcBdbIB3ntF12wfTGPz4f1S3M5i8I=
X-Google-Smtp-Source: AMrXdXu0pw3W2DXe7/rd+P1f3BnuChmYExdV7mrCu15SFPLmnT7xk2iiFgYqo7vEHuwgHAhY34tBKbgcyOWKEd+PGN8=
X-Received: by 2002:a17:906:c09:b0:86e:9975:81e6 with SMTP id
 s9-20020a1709060c0900b0086e997581e6mr2577122ejf.102.1674515867717; Mon, 23
 Jan 2023 15:17:47 -0800 (PST)
MIME-Version: 1.0
References: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Jan 2023 15:17:35 -0800
Message-ID: <CAEf4BzZfBb75smH0uTn4E36T6vk1xhZZ+5_ONtdh9aFQCMH2pw@mail.gmail.com>
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

On Tue, Jan 17, 2023 at 11:57 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> If CONFIG_NF_CONNTRACK=m, there are no definitions of NF_NAT_MANIP_SRC
> and NF_NAT_MANIP_DST in vmlinux.h, build test_bpf_nf.c failed.
>
> $ make -C tools/testing/selftests/bpf/
>
>   CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
>                 bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>                                                        ^
> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_MANIP_DST'
>                 bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>                                                        ^
> 2 errors generated.
>
> Copy the definitions in include/net/netfilter/nf_nat.h to test_bpf_nf.c,
> in order to avoid redefinitions if CONFIG_NF_CONNTRACK=y, rename them with
> ___local suffix. This is similar with commit 1058b6a78db2 ("selftests/bpf:
> Do not fail build if CONFIG_NF_CONNTRACK=m/n").
>
> Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kfunc")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> index 227e85e..9fc603c 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -34,6 +34,11 @@ __be16 dport = 0;
>  int test_exist_lookup = -ENOENT;
>  u32 test_exist_lookup_mark = 0;
>
> +enum nf_nat_manip_type___local {
> +       NF_NAT_MANIP_SRC___local,
> +       NF_NAT_MANIP_DST___local
> +};
> +
>  struct nf_conn;
>
>  struct bpf_ct_opts___local {
> @@ -58,7 +63,7 @@ int bpf_ct_change_timeout(struct nf_conn *, u32) __ksym;
>  int bpf_ct_set_status(struct nf_conn *, u32) __ksym;
>  int bpf_ct_change_status(struct nf_conn *, u32) __ksym;
>  int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
> -                       int port, enum nf_nat_manip_type) __ksym;
> +                       int port, enum nf_nat_manip_type___local) __ksym;
>
>  static __always_inline void
>  nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
> @@ -157,10 +162,10 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>
>                 /* snat */
>                 saddr.ip = bpf_get_prandom_u32();
> -               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> +               bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC___local);
>                 /* dnat */
>                 daddr.ip = bpf_get_prandom_u32();
> -               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> +               bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST___local);
>

it would be a bit more reliable if you used `bpf_core_enum_value(enum
nf_nat_manip_type___local, NF_NAT_MANIP_DST___local)`. That would make
libbpf substitute correct absolute value, if actual enum
nf_nat_manip_type in kernel ever changed. Please consider a follow up
patch for this.

>                 ct_ins = bpf_ct_insert_entry(ct);
>                 if (ct_ins) {
> --
> 2.1.0
>
