Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668AA6A8CF1
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCBXXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 18:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCBXXj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:23:39 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CC3166D9
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:23:37 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d30so3552988eda.4
        for <bpf@vger.kernel.org>; Thu, 02 Mar 2023 15:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTNHqXtaKSgi63R5huOtNG629uTQ7ub/MZ0b03jX6ro=;
        b=buL9T7Nh0JDsdzn7kyeSQbbAfjKZwLpPN3I2Kn9LjSCt3sE2uu4Dyo1ZneMRRZifpF
         E9+z7GfEP086cYJN6O4ZztGyZWGz/Din1K/yhsXc2XWexsjbMShM0RNbECnlOK9vleZD
         Eis0JBH3/LsKGv17uNpJfxV2gLg5biNEjSkTU8lmvS4AgZL+gXSmzzHdUuoqJiw7lCj1
         R1FDwOIpwJ7z92uzMQh8tATxIig6imWjablQ7kIxiqkD9lDrd7cj4/4sW6eglRTDBwwL
         tJvAjSWPLtZTFFI5U0g7pHZdXVjnCA2RblPTsCt+zXqPPkoFJiYPJLBEH3KF13wPJSYv
         A+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTNHqXtaKSgi63R5huOtNG629uTQ7ub/MZ0b03jX6ro=;
        b=ovgzoQkLY/K7iGcqjuDTC0XgBnchCZkiQ0mjGKLpppPaGG8tX5cHyJRfsv1FBF82EF
         fyxEjwUWvXrRl5A4QK4jILKBpuniIW0K9proCwM1QCTaw7deG+3vlIFIpjS0Y0GdmxxY
         jDH/bowoCTA8rD8h1isLvx+u+iL7Qpp70YaoWZCljX+Pft7Z2mIg1PLGPr9tz2lj20Gq
         PxtL4/zYczyaSI0wC5VMGVVnHtE4KL+57U7Ne4HiDsTQemJ+OSOllBFjAO5Lan13QTk3
         oaBV8Kge6FtG3vfU5SRF24kNWOHEsSt25ENjh0E3vgOKRSuG+BcNmZBvg/hcIpHtiT+f
         X4VA==
X-Gm-Message-State: AO0yUKUjKQ3qzuV+wH4xyrVX/KMI3P8jnm+bHcwFvInDDSU8BpnNltel
        X1wnA71Q6xvPvydAoI7cG2BXTN+BRaddmkpCKnk=
X-Google-Smtp-Source: AK7set87Nushl8yBlpv3mTO4vlZu/AybmRHtQVZVWr8CIDI3lS82JrwbZLlmMRG0YYthZKK69jtScmb8eHT1Xo9g9Wo=
X-Received: by 2002:a17:906:a46:b0:895:58be:963 with SMTP id
 x6-20020a1709060a4600b0089558be0963mr5961917ejf.3.1677799416007; Thu, 02 Mar
 2023 15:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20230302231924.344383-1-davemarchevsky@fb.com>
In-Reply-To: <20230302231924.344383-1-davemarchevsky@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Mar 2023 15:23:22 -0800
Message-ID: <CAADnVQJV_yQ23EeFuuHC+AvoxgVLVKZvaYkWfzhk=z3kxWHmHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add -Wuninitialized flag to bpf
 prog flags
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

On Thu, Mar 2, 2023 at 3:19=E2=80=AFPM Dave Marchevsky <davemarchevsky@fb.c=
om> wrote:
>
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
> +               return -1;

The verifier cannot be ok with this return... I hope...

> +       n =3D container_of(res, struct node_data, node);
>         bpf_spin_unlock(&glock);
