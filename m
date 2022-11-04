Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69C619098
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 06:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKDF5z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 01:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiKDF5T (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 01:57:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FC95F9A
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 22:57:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i21so6110023edj.10
        for <bpf@vger.kernel.org>; Thu, 03 Nov 2022 22:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OaSYfQwbz8Zg84Y6tN7Z6ERl0vtx3Ly3o49JsRTsLyY=;
        b=WH1LXlX4dx2FPOIntcLzBr7qzrEPl/KcYFlXLGfTkReA0is/yuR+WnIR58wNVwsxFT
         Dz+IozQuMFEuDD2xPnyKZPPMGLCbCV1cxWNN4fwPn9sYedC6XLc2MKmL66jEbPeozZBz
         FtF+jrbMmYpp/2naAXVNf7ifjfu5+/6KsUEzCY6gNxvDMzgWz4B6dAuGhVF4oXPDuVeI
         O2MX00jGatlPVCwUJc/HOdSN4iKLknjhoXzQNAys5h6U8F+QPQCS9OBNzKMEcDOupg9v
         tJA+yNUQB5u/Tn4H0lW+cTkAMUScoBes5i1/Ta4fFLrpQnXRsMR0xHd1Zq64R01/WL2A
         L4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OaSYfQwbz8Zg84Y6tN7Z6ERl0vtx3Ly3o49JsRTsLyY=;
        b=y2220BIH02rCW7JPbb+Aip/ueXR+Z480Te4VvJc9Nu0VjbDai9u7yvmvx+fy7C5J39
         8/GR4QUp0Uf8uxGKM98pdscYGcP0PWfqM5lIp2pFemY32MfnHUkgg1tDL71VglZvk72y
         GH275G45R8R/2gYQ+RzOenVdwj0KaTU6gL2fFywH9O6NKg31W4hbknv/b6Z1PqhGGBpm
         gARfZVDJci4AC7Cb5RKfyZc+Snth04kw0b+1KI35ba61ImSGJwyQu3sUW6VU44vwtt0e
         fQ/O+yCZai/vfgcduTm53/sW9N5lLKdAcldkwPuFp01aD6NIFyBNFL3sn032MMW4qmd4
         lflw==
X-Gm-Message-State: ACrzQf2qaQ4yZYq3m6Oeefj+LlPcu41XgUc2FfoSInBOOnlZqLw4RqGl
        81fIvfTeLGUU9hn/j1nOCBI0JwXusR24UVXvjodIwTKXUgo=
X-Google-Smtp-Source: AMsMyM4nmyRpPG7E3MD7/DI8FG6uJzN2eZLpwRAZ6Q272fvpEKR04sMR8IB3ZVjrj1KlgkCEQ67jUoPIc+qdUfbLkgI=
X-Received: by 2002:a05:6402:428d:b0:460:b26c:82a5 with SMTP id
 g13-20020a056402428d00b00460b26c82a5mr34977134edc.66.1667541435602; Thu, 03
 Nov 2022 22:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221103191013.1236066-1-memxor@gmail.com> <20221103191013.1236066-11-memxor@gmail.com>
In-Reply-To: <20221103191013.1236066-11-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 3 Nov 2022 22:57:04 -0700
Message-ID: <CAADnVQKF7zs39ZRpU-9dAKaXZwRLRE8rFZ6m152AbWKC_6=LdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 10/24] bpf: Introduce local kptrs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Thu, Nov 3, 2022 at 12:11 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Introduce local kptrs, i.e. PTR_TO_BTF_ID that point to a type in
> program BTF. This is indicated by the presence of MEM_TYPE_LOCAL type
> tag in reg->type to avoid having to check btf_is_kernel when trying to
> match argument types in helpers.
...
>
> +       /* MEM is of a type from program BTF, not kernel BTF. This is used to
> +        * tag PTR_TO_BTF_ID allocated using bpf_kptr_alloc.
> +        */
> +       MEM_TYPE_LOCAL          = BIT(11 + BPF_BASE_TYPE_BITS),
> +

I know we have bpf_core_type_id_local.
It sort-of makes sense in the context of the program.
type_id_local -> inside the program
type_id_kernel -> kernel

but in the context of the verifier "local kptr" doesn't read right.
Especially in MEM_TYPE_LOCAL.

Also, since it applies to PTR_TO_BTF_ID, should it prefix with PTR_?
Probably MEM_ is actually cleaner.
And we're not consistent already with MEM_PERCPU.
We can live with this inconsistency for now.

So how about we rename MEM_ALLOC to MEM_RINGBUF,
since it's special bpf_ringbuf_reserve() memory
and use MEM_ALLOC to indicate the memory that came from bpf_obj_new ?

... which made me realize that the comment above should
s/bpf_kptr_alloc/bpf_obj_new/
