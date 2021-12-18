Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6F479DA1
	for <lists+bpf@lfdr.de>; Sat, 18 Dec 2021 22:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbhLRVs7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Dec 2021 16:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbhLRVso (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Dec 2021 16:48:44 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F1C06173E
        for <bpf@vger.kernel.org>; Sat, 18 Dec 2021 13:48:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gj24so5591222pjb.0
        for <bpf@vger.kernel.org>; Sat, 18 Dec 2021 13:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jNgPI4B1FdRyWW9gIi22ITRzmw8GrD5hVZrmo55JFM=;
        b=Io2KZxs7Mv4EMPcs5XpUkOQZcfrw6kCow1EHRV7Og79TqJDWd7dvXEVg/QISM/t6aR
         9Tx7UG/3SPd2nTUCjWVuGXgQyIu62jvtpu86PcmxBDHoghpptH4A8+UntjTTobt5RKge
         TPx0b+hr6UElXxOYL1EQLjDLQ9ZLGE/uUESqFer/fsCl1VzJWjyCPTr1EQlCvphYtgA0
         cX5U+CiFmhsOjp1I2bIajtlIzabjl0i1Xqk7E85OF/JWNIG0rE6OJyQRIdcIZ0KYrBSv
         1GEFXlqMsG6sxngR75P5QKLFz3rcyKBnhrJTyRXwH9ggLu7cVMaTqEmV4wqtS73n2Up3
         ggqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jNgPI4B1FdRyWW9gIi22ITRzmw8GrD5hVZrmo55JFM=;
        b=r85wUK75UJcRUP4Yui6hvSvFY7SlOtBZF5vhRKRACYACQbJGOLPg9fbyGYaRK8KKQP
         xKNY8tDxqVjTT6oK21sZ1885d8PxTc7gWieGXbM3WSI3HwyWO8dRoJcnkwgYQVQ5bjSt
         GVa89V3vR1j4U54OSoilm88IUyQP09Cddmtm/6OLIJED/U+Lw+x9kGVLx/VJJMvdINUk
         Z+dpjX3pBKnlz82V/N6eHz7qQfyU6c8L6YH2FVasTe35KObyxQ0L7jgFU3pT8Ug6Evbt
         njSuO0mJTgB/PRlM/ePVYrecWW3Duy5XTOjFe+4MeDdMCsMfj/N1ZQAi89qR+ge7P/56
         iPag==
X-Gm-Message-State: AOAM531uvYdt/OTa3GuMP0e4iPEk/omSKGiFdCbgInLsTszBpu6aNtpa
        oMCqzrWQxK+0wZlraYjzrDJ9KB5E4DZ7oMutF8oGq7Nx
X-Google-Smtp-Source: ABdhPJwRedYZIsosXTKO+/thFn1SGj42HNTBR4zfAIVg/KpCbAYEVsFnpQ9wwgC9vi54P73A2Q0W6IPWPKD1CjUp2NM=
X-Received: by 2002:a17:902:c443:b0:148:f689:d924 with SMTP id
 m3-20020a170902c44300b00148f689d924mr3052788plm.78.1639864123293; Sat, 18 Dec
 2021 13:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20211217003152.48334-1-haoluo@google.com> <20211217003152.48334-5-haoluo@google.com>
In-Reply-To: <20211217003152.48334-5-haoluo@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 18 Dec 2021 13:48:32 -0800
Message-ID: <CAADnVQJi9izQFBxebcTLpneTsec3UG1d9zTpRh0msSJtTsDc2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Replace PTR_TO_XXX_OR_NULL with
 PTR_TO_XXX | PTR_MAYBE_NULL
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 4:32 PM Hao Luo <haoluo@google.com> wrote:
> -       switch (ptr_reg->type) {
> -       case PTR_TO_MAP_VALUE_OR_NULL:
> -               verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
> -                       dst, reg_type_str[ptr_reg->type]);
> +       if (ptr_reg->type & PTR_MAYBE_NULL) {
> +               verbose(env, "R%d (of type %s) may be null, null-check it first\n",
> +                       dst, reg_type_str(env, ptr_reg->type));
>                 return -EACCES;

I manually fixed the merge conflict in bpf_verifier.h, since
the verifier log improvement patchset went in first.

Also reverted to the original message in the above hunk while applying,
since it says 'may be null' twice and breaks test_verifier tests
which were not updated by this patch.
