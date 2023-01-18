Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCD6716B4
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 09:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjARI5K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 03:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjARI4c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 03:56:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF7676CC;
        Wed, 18 Jan 2023 00:10:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so824391wma.1;
        Wed, 18 Jan 2023 00:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0vdur1hQdUSHTad6H0g8tY0U7ro6sZT4Qb9ft9KwkQ=;
        b=Ns1R7g2r4HqaDOX1lehqhdR8/aT28lzgpN6iBJ2oIAtjOcAweyo8tHpkPLuzcn8bRe
         Yp9+8lBjMU2joLa+pXHsFX/pjGSHKdwBXnIRFBqOeGGIDj2cmIOhSGR1ohHopERg0PJN
         DbFx5visakm9nRdUBmZRbJuJACT/jYsV2EzrNQQC3cAjZj6jOsUdYlnJ3f4IFTK6NTZo
         LOZAOvbn1ctsLXz1NYeIDx+zIJ1YNVtcC7014fPCmIYmE4VL1Jzvoek2xmAEMxeamqOi
         v19uztFwd9Ll3fGjeHlx1iNv2LXUOh9/ZDw14NAC+UI0WrSm+/sqF8JxfZIocFAO7gjz
         YXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0vdur1hQdUSHTad6H0g8tY0U7ro6sZT4Qb9ft9KwkQ=;
        b=vT+SlV+2mb1pHhTvORovLGaMUt2kmCKlweOjv/rbss/gu5p4JaqKlLJwTR1Eqpst5k
         1ytWNyFRFmES0l9AFwfjr4iH2wkTb6TuZfqgWtgw6Y4JhzNXwmWndyMxOGWryIDT41I2
         jPSAFWDyepKrCEeIKP29WKMVl2imWxLcn+yN8HFmGWVUYsFDcQy5x1MxT8wiE83qJG2U
         PGdu8MCGE2gL+yzgpBXatJYpWoOu3GJovG4jOtlxNdvwVrmcVEXEDuAh/bz2P/SSoseI
         IfZnHZKdpwdoOcxShgTHz4VtGbQpThWflahYeGnxMyWHwuVPgYCtBi85MIddt+vnX5Yv
         13HA==
X-Gm-Message-State: AFqh2krhliFXFOR/02REsvp0xNx+ez7q+dMUBqeu28UPTq8bjmRHkzOZ
        SPQvzqvT5LmVNWfJxXjJHJ0=
X-Google-Smtp-Source: AMrXdXtfUflEd8kBxt0LTVMbUrV2vxV9ff6ftk/N9Vn690FwkH6mfDV65DPuZ5jZla2bkg/2L8CuMw==
X-Received: by 2002:a05:600c:d2:b0:3da:f475:6480 with SMTP id u18-20020a05600c00d200b003daf4756480mr5741538wmm.7.1674029439508;
        Wed, 18 Jan 2023 00:10:39 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id q24-20020a05600c331800b003d1de805de5sm1151356wmp.16.2023.01.18.00.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:10:39 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 18 Jan 2023 09:10:36 +0100
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
        Hao Luo <haoluo@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix build errors if
 CONFIG_NF_CONNTRACK=m
Message-ID: <Y8epfNbNDYikDYSr@krava>
References: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674028604-7113-1-git-send-email-yangtiezhu@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 18, 2023 at 03:56:44PM +0800, Tiezhu Yang wrote:
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

I hit the same problem, thanks

Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Jiri Olsa <jolsa@kernel.org>

jirka

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
> +	NF_NAT_MANIP_SRC___local,
> +	NF_NAT_MANIP_DST___local
> +};
> +
>  struct nf_conn;
>  
>  struct bpf_ct_opts___local {
> @@ -58,7 +63,7 @@ int bpf_ct_change_timeout(struct nf_conn *, u32) __ksym;
>  int bpf_ct_set_status(struct nf_conn *, u32) __ksym;
>  int bpf_ct_change_status(struct nf_conn *, u32) __ksym;
>  int bpf_ct_set_nat_info(struct nf_conn *, union nf_inet_addr *,
> -			int port, enum nf_nat_manip_type) __ksym;
> +			int port, enum nf_nat_manip_type___local) __ksym;
>  
>  static __always_inline void
>  nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
> @@ -157,10 +162,10 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
>  
>  		/* snat */
>  		saddr.ip = bpf_get_prandom_u32();
> -		bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
> +		bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC___local);
>  		/* dnat */
>  		daddr.ip = bpf_get_prandom_u32();
> -		bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
> +		bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST___local);
>  
>  		ct_ins = bpf_ct_insert_entry(ct);
>  		if (ct_ins) {
> -- 
> 2.1.0
> 
