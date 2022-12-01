Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC20563E706
	for <lists+bpf@lfdr.de>; Thu,  1 Dec 2022 02:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiLABSp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 20:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLABSo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 20:18:44 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B128C691
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:18:40 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ha10so739813ejb.3
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 17:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWbZ+Uy7EGV8OBjrW+DHSOel6qWvYoCpiX/KnZ5OxYA=;
        b=lsmXcCXKRBvdQOOe1cpigNOUsh0/pk0EVD8tBf7aVdInmEdh08Ioc600GFsxWri/8m
         8otggCkUsK/smjI4bV2NOOUDdOZ+OVeov9Xk22gU43PzMoKrCMR5mUZiLb5WSwtW2NxQ
         WtKY5+RrSwx39GKhaf57jlPyOJ3iTRCMqqSzzULmdHtR63af9uv42B/IsA3b1aEXLLVM
         O+9P+TFqa5EaI/cSXvGVpKq48tCsJMTEDsheVh5OiaYMxyps0XxjYDarN3D3dw1dOgGg
         GtGOTHkcHI3xYsIsQrE2bSA+ViTLGymS02otD5SLW4WKoU3KN13Yst9U5PACJ6H9rLlZ
         OH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWbZ+Uy7EGV8OBjrW+DHSOel6qWvYoCpiX/KnZ5OxYA=;
        b=UUT2bwE19JkftmEkewhIp+obn8gvSjsTYgBEm0qyRHZTqb0JoN/B6S4a7q+q1B664b
         Ljl/Yq7Wia+QB8SDbLqCNuxYqR2WQIg7XdxTF0SrvxHiGovbmrQBuYH5VKlk4v2f2st/
         CM1O7jiXeFugS24V3NXPFn1Ubj/kAD5lnzh6IMQeMCrlVJV0FOhNkP1JjaiPPb8qKUJ2
         AoAWjaP/OGMX31GwwUDS6CQ7S4sCN5cB0ba2XTxoypwkk1tB7QNx2rLqdfDYbd2ewNb+
         LKjbxY+qWuDsUvJYlzhrXyK8WG7adObpeqAcJxuCK2w0PaKEVmkpZdtIEVDAokeCole9
         yGRw==
X-Gm-Message-State: ANoB5pmilsudwwoPCvI66z1jQrcIbzMGrrd56C/VeyFM2VcjU9nqphPs
        tG6Al2c5C2s19Sl0J/dOMdPBU8AL1cZssN5ISBU=
X-Google-Smtp-Source: AA0mqf7Q+7Ifhqs7c1/ZT1iZaNQT2lAn2s8GSVLa+mUPAmwqfAtpJynE88oR0R0stRE25iO+adpZSaEysy45+o65iKo=
X-Received: by 2002:a17:906:6403:b0:7b2:9667:241e with SMTP id
 d3-20020a170906640300b007b29667241emr54999159ejm.115.1669857518659; Wed, 30
 Nov 2022 17:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20221130144240.603803-1-toke@redhat.com> <20221130144240.603803-2-toke@redhat.com>
In-Reply-To: <20221130144240.603803-2-toke@redhat.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 17:18:26 -0800
Message-ID: <CAEf4BzaXbNkx85pBAB=gSshQvdGySkuZzw+HJ9KmDDA1JuheNQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add local definition of enum
 nf_nat_manip_type to bpf_nf test
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jiri Benc <jbenc@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 30, 2022 at 6:42 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> The bpf_nf selftest calls the bpf_ct_set_nat_info() kfunc, which takes a
> parameter of type enum nf_nat_manip_type. However, if the nf_nat code is
> compiled as a module, that enum is not defined in vmlinux BTF, and
> compilation of the selftest fails.
>
> A previous patch suggested just hard-coding the enum values:
>
> https://lore.kernel.org/r/tencent_4C0B445E0305A18FACA04B4A959B57835107@qq=
.com
>
> However, this doesn't work as the compiler then complains about an
> incomplete type definition in the function prototype. Instead, just add a
> local definition of the enum to the selftest code.
>
> Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kf=
unc")
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/test=
ing/selftests/bpf/progs/test_bpf_nf.c
> index 227e85e85dda..6350d11ec6f6 100644
> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
> @@ -43,6 +43,11 @@ struct bpf_ct_opts___local {
>         u8 reserved[3];
>  } __attribute__((preserve_access_index));
>
> +enum nf_nat_manip_type {
> +       NF_NAT_MANIP_SRC,
> +       NF_NAT_MANIP_DST
> +};
> +

and enum redefinition error if vmlinux.h already defines it?...

>  struct nf_conn *bpf_xdp_ct_alloc(struct xdp_md *, struct bpf_sock_tuple =
*, u32,
>                                  struct bpf_ct_opts___local *, u32) __ksy=
m;
>  struct nf_conn *bpf_xdp_ct_lookup(struct xdp_md *, struct bpf_sock_tuple=
 *, u32,
> --
> 2.38.1
>
