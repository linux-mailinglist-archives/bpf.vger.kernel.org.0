Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58026A8D26
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCBXm7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 18:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjCBXm6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:42:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D04ED2
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:42:53 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id d30so3697743eda.4
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tICp5FUK9Wwn91g1zDYmFl33tm/JT0JoDVvb2DFe+4=;
        b=SdJXjjVfom8sWzzTm7r+D9aqdh6Ljbl6Y7RBUOTkQKOcGWRvwkHJx4s1WXNjFI3BfA
         qTlFGL/Vti9v/t5fYbZW0FQFQCwKP4h6aVe5lfOM/93c3ZDLgctI8pNSmKkgMgh1d1Gp
         x3kK5UNIx6Mdp822nXMMzPyhTLqBdN2ZlX/Z2AjeXnQGF/JidoT3RF8LAMWOI31dHkPM
         84qmFWfFeCO4ZSaJUdHPSf2GrpZ/l/TLqOyyL4ht1WIMugshbvjhhfONwcSfvvP6BNgA
         zFVCVuADab4bs8lAW93wFm94OLnukc2910HYw5FsRrzqOBir5jIe8v0Tka60SviHMgwT
         lgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tICp5FUK9Wwn91g1zDYmFl33tm/JT0JoDVvb2DFe+4=;
        b=J0hWnWK4gOz8ZtMfgsQd3VCJ/uuJFP0PMDbnxlYR9H478quwhwQGqlQ+8NSbzGPv3R
         mBQH2WtNK39TP5ze1HCuWTNhtAsZBBNRE8X6QrdNDVuAADraafz++DquB/JdhLdje46p
         i7K5epH2/WUTLG243ZuVPi2N6fiFnWV7TGQmtifT0QMVJ9ooL5d/G0qNQ2jSnePqxE0l
         61zOXwalH4kWq9SO32dtoIgXV4qr2RkdZJbUZNW+g6Cn62+l16dziC2uOoDqJmoKk0A8
         u7rZ12WAcVP2WtNsCnTMtHdFf/2xi0Ov1Bm8a1DJCPuzK76/e5l2PoaRSLq8z9/03UeY
         GXCw==
X-Gm-Message-State: AO0yUKUIFWi4i/+FDwsnsfj7Q0Tn20u1ishvI8fB/9OkECkMbQAfVmvm
        PIBY1bKF3B8TjjN9E71cAFsPm2gnTc3GFAU+WhE=
X-Google-Smtp-Source: AK7set/6M0StbKuF9hlUeB3ATIAzMQZvnHYey65BYjj58iaa2HhsfHho1HS9qGLXVWDQYoByrKpcfS7EwGNxatGS+Ao=
X-Received: by 2002:a17:906:d789:b0:8ae:9f1e:a1c5 with SMTP id
 pj9-20020a170906d78900b008ae9f1ea1c5mr5812244ejb.3.1677800571707; Thu, 02 Mar
 2023 15:42:51 -0800 (PST)
MIME-Version: 1.0
References: <20230302233528.532299-1-davemarchevsky@fb.com>
In-Reply-To: <20230302233528.532299-1-davemarchevsky@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Mar 2023 15:42:38 -0800
Message-ID: <CAADnVQL1Lh4r1TJe5LH40m6uRV9jV8FndFbU2AD0oXLepFfDDQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add -Wuninitialized flag to
 bpf prog flags
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>
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

On Thu, Mar 2, 2023 at 3:35=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb.c=
om> wrote:
>
> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/test=
ing/selftests/bpf/progs/rbtree_fail.c
> index bf3cba115897..4614cd7bfa46 100644
> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
> @@ -232,8 +232,9 @@ long rbtree_api_first_release_unlock_escape(void *ctx=
)
>
>         bpf_spin_lock(&glock);
>         res =3D bpf_rbtree_first(&groot);
> -       if (res)
> -               n =3D container_of(res, struct node_data, node);
> +       if (!res)
> +               return 1;
> +       n =3D container_of(res, struct node_data, node);
>         bpf_spin_unlock(&glock);

It has the same issue.
I don't think we should rely on the order of basic blocks.
If 'return 1' block is happened to be a fallthrough
the verifier will error on 'lock is still held'.
