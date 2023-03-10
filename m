Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29396B53D1
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 23:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjCJWGO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 17:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjCJWFU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 17:05:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4C5FC7
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 14:04:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35965B8240F
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 22:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D64C433A4
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 22:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678485857;
        bh=X+V1obY9k9q5Lqak9f20lCniJONGHDWm3UfEXRBKy3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B4q13cBvQjexTrL7+QqLIpVLPfRfjKx5BHxMacXiwmCJUyJX26E3GBFRU2tNCIOw+
         Lvrz/MkVCYJVoiARFoTFnK/DvVURxK0t1+4u13LEPm4roWEsJN93IJ0LN/BdKhBNWG
         M09YrLF1thnYuMefe7ig+/jlHufHkr032dKyRg8cS5P01xhlhvd57ypu/c+B4D2kdb
         HrKmv5Cxs9sTe/hKbkIT6szkTvvZzkEhBmHsEeYlc8tzbmsCA1dTDxo6k1QjZmon5N
         BSgMMTezxq4B5qHN/oQ9fgmIIpXTZsXd7peFdR97u1689PS0uHkJD8Mvo7s11iTfQC
         Rzo5hb1XX/p0Q==
Received: by mail-lf1-f52.google.com with SMTP id s20so8482940lfb.11
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 14:04:16 -0800 (PST)
X-Gm-Message-State: AO0yUKUlySpCuWSobs470X6iet+9oCeQQhP6o7G9SkRK+2QDnGd++Dh6
        KLkC6kvMF04LpHHeQBmGNJzxcA9GOMQVKEm+pKA=
X-Google-Smtp-Source: AK7set/Gf3Y2SAywkERyf8wbQ7IxYD4QzZr7tNhfTElRC0kHLCpAZvrxVel8DA5dL1b7PM0RIIKWkR63fXwXAelyw9Q=
X-Received: by 2002:a19:e019:0:b0:4d8:86c2:75ea with SMTP id
 x25-20020a19e019000000b004d886c275eamr1664591lfg.3.1678485854943; Fri, 10 Mar
 2023 14:04:14 -0800 (PST)
MIME-Version: 1.0
References: <20230309180213.180263-1-hbathini@linux.ibm.com> <20230309180213.180263-3-hbathini@linux.ibm.com>
In-Reply-To: <20230309180213.180263-3-hbathini@linux.ibm.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 10 Mar 2023 14:04:01 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4pNHJ428Qf19Le=uuBFMRRmhF7r71ncsURvcpKvLZN_w@mail.gmail.com>
Message-ID: <CAPhsuW4pNHJ428Qf19Le=uuBFMRRmhF7r71ncsURvcpKvLZN_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc/bpf: implement bpf_arch_text_copy
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 9, 2023 at 10:02=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
> bpf_arch_text_copy is used to dump JITed binary to RX page, allowing
> multiple BPF programs to share the same page. Use the newly introduced
> patch_instructions() to implement it. Around 5X improvement in speed
> of execution observed, using the new patch_instructions() function
> over patch_instruction(), while running the tests from test_bpf.ko.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>  arch/powerpc/net/bpf_jit_comp.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index e93aefcfb83f..0a70319116d1 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -13,9 +13,12 @@
>  #include <linux/netdevice.h>
>  #include <linux/filter.h>
>  #include <linux/if_vlan.h>
> -#include <asm/kprobes.h>
> +#include <linux/memory.h>
>  #include <linux/bpf.h>
>
> +#include <asm/kprobes.h>
> +#include <asm/code-patching.h>
> +
>  #include "bpf_jit.h"
>
>  static void bpf_jit_fill_ill_insns(void *area, unsigned int size)
> @@ -272,3 +275,21 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *=
image, int pass, struct code
>         ctx->exentry_idx++;
>         return 0;
>  }
> +
> +void *bpf_arch_text_copy(void *dst, void *src, size_t len)
> +{
> +       void *ret =3D ERR_PTR(-EINVAL);
> +       int err;
> +
> +       if (WARN_ON_ONCE(core_kernel_text((unsigned long)dst)))
> +               return ret;
> +
> +       ret =3D dst;
> +       mutex_lock(&text_mutex);
> +       err =3D patch_instructions(dst, src, false, len);
> +       if (err)
> +               ret =3D ERR_PTR(err);
> +       mutex_unlock(&text_mutex);
> +
> +       return ret;
> +}

It seems we don't really need "ret". How about something like:

+void *bpf_arch_text_copy(void *dst, void *src, size_t len)
+{
+       int err;
+
+       if (WARN_ON_ONCE(core_kernel_text((unsigned long)dst)))
+               return ERR_PTR(-EINVAL);
+
+       mutex_lock(&text_mutex);
+       err =3D patch_instructions(dst, src, false, len);
+       mutex_unlock(&text_mutex);
+
+       return err ? ERR_PTR(err) : dst;
+}

Song
