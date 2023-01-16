Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F332666BDD6
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 13:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjAPMab (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 07:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjAPMaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 07:30:18 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA411E1D2;
        Mon, 16 Jan 2023 04:30:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m21so40502512edc.3;
        Mon, 16 Jan 2023 04:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TikkHW0ZcXIRVosMJoyTcYHTFavaYJkhxqDa1cQHDPE=;
        b=Ho90coZksLKxJJ2dztj63xm1oe4Cz72H4OFqDijbAa3MufLTFJK72JkJvhyKJXNm9P
         N/EK6uiJBoV2+3Te5Vajs+6GTtbTTiaSTZ3ZupAr77RG/8/QE4OubbeUzecDG0l12oS7
         dIa2N7fvmV+cWT0L0RuoRNCy8oDadiF5ZJ1o/ANVxPRFCfo/918R6txFeXwRZJrjFtQl
         ++DJsBsdCQxV5MyU63hxW32XByaSmUKBaZma57CNeOSiF7SrX7jUxVRgO1psqBR2CbzI
         0CBDKeoTvo3RMAgsvBnytzkZd2320+4tiQgBfMQkqYLT2wMNzpoUQVHAqOwSIjUFxWcP
         uODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TikkHW0ZcXIRVosMJoyTcYHTFavaYJkhxqDa1cQHDPE=;
        b=QPQ6nTO92aHgA94cbbxv/vK6JZZNQhSkRWb0NjTx700qhiHT2o392lbSdFTXyTuDqe
         lZad4z42K8ApAhcHCI8T87gHBzW/6Ag/BlpMEq2uQwisMAPez9sbQaiSwBoh1qIhHZOt
         roo/YwoyLHMBl3cNzAzQXgYxlz82PIn0c6erY4gtpwi41ILpUgmoBRWmUNYHLHR3Pahj
         PPwk7wuSs+xunXsEuw1V27uSjRQU5oN6jGCABrwFD93FhpZlxKsZtb6rOyfIhtfGhmJl
         yT9/sxdWoI1QX8MiPU0p0+rVgpuGNdZ/PNu8oGqIS6qB6p+ilTkb4L9C34v2vQ8cwumL
         VKEw==
X-Gm-Message-State: AFqh2kqzMaH24FBEcxk0Br0J9GJ82y/S5FtaFPTmBgXybrkKUT/06E59
        XI43Hym0O2e51kTs1/9YpOw=
X-Google-Smtp-Source: AMrXdXv+CDDn0suA07/nf4nraJI+lZ8hgIYhS0EEKZTsSiyn2zJeOFqfS407n7/PbX3m5QZhPjLLTg==
X-Received: by 2002:aa7:df08:0:b0:49e:15ee:4f72 with SMTP id c8-20020aa7df08000000b0049e15ee4f72mr3993868edy.36.1673872215626;
        Mon, 16 Jan 2023 04:30:15 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ss5-20020a170907038500b00856ad9108e7sm7607946ejb.70.2023.01.16.04.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:30:15 -0800 (PST)
Message-ID: <14e0f634f084d0f07e447638c490da60943507d6.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix undeclared identifier build
 errors of test_bpf_nf.c
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 14:30:13 +0200
In-Reply-To: <1673844908-11533-1-git-send-email-yangtiezhu@loongson.cn>
References: <1673844908-11533-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-01-16 at 12:55 +0800, Tiezhu Yang wrote:
> $ make -C tools/testing/selftests/bpf/
>=20
>   CLNG-BPF [test_maps] test_bpf_nf.bpf.o
> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_M=
ANIP_SRC'
>                 bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>                                                        ^
> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_M=
ANIP_DST'
>                 bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>                                                        ^
> 2 errors generated.
>=20
> Copy the definitions in include/net/netfilter/nf_nat.h to test_bpf_nf.c
> to fix the above build errors.
>=20
> Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kf=
unc")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/test=
ing/selftests/bpf/progs/test_bpf_nf.c
> index 227e85e..114f961 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -34,6 +34,11 @@ __be16 dport =3D 0;
>  int test_exist_lookup =3D -ENOENT;
>  u32 test_exist_lookup_mark =3D 0;
> =20
> +enum nf_nat_manip_type {
> +	NF_NAT_MANIP_SRC,
> +	NF_NAT_MANIP_DST
> +};
> +

This is confusing, when I build the kernel/tests I get the declaration of
the "enum nf_nat_manip_type" from the vmlinux.h (which is included from tes=
t_bpf_nf.c).
Which means that this patch results in compilation error with my configurat=
ion.
Is there a chance that your kernel is configured without some necessary net=
filter
configuration options? Have you tried this patch with BPF CI?

>  struct nf_conn;
> =20
>  struct bpf_ct_opts___local {

