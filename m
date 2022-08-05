Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D5958AD0A
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 17:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbiHEP2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiHEP2P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 11:28:15 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FA2A472;
        Fri,  5 Aug 2022 08:28:14 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z22so3811842edd.6;
        Fri, 05 Aug 2022 08:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nk665Su5xb9lfbgCe09ymRRIU+UUZDMS8Dljdw9Nzec=;
        b=NcJfbaV8IP0wEnbKxkXsopTDyIDk65kpx/0CKlMw+Fc4SDosRJLZMHk58SNvoTC+uB
         DVIx/mze+OU4922IXHJ3//lXlm0rQ6V1nn8pTxcaXa79msaDb/jMk/jCG7Q1sSBDV44N
         rPRSxCkJmtB0+Bitgf/FRWSjZjtvUJZfYuDMQ3U4CYbJ/1UQhnz5csiMFwta+ZPYmnqu
         am6Mew8dMqKWK2lPkzWiOf4/9SYiKSh+cToBd7T1TsotL+m/LMcDDdf0ND5KJs+7qxk4
         Ei3WYLlqgDsTapYg0CHl0ngZFRzUmzzDmBtaKzNLUjgWc8ubM7lOPOmlFPz23bt2ekK8
         4gGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nk665Su5xb9lfbgCe09ymRRIU+UUZDMS8Dljdw9Nzec=;
        b=xy1ffR7b4ZKA5Lm3IkXyFXoYWD7256ll4Yu0Wvdc5o1rqNfHXfSMfg7BoFfg6CV1L1
         9m2hQfVwqCO/yP+rCpmJ70dkXVPzQZV8Dvy8+RpfamPxdVrUtr0wag7uuzsLpFp7RFCO
         Kleya6WOlmlZF1cO5lAVm7uJEwe38NIE3fRHATXg9Zi7pgeT0iLyLKi1PAOyJYK1zPoX
         JiS4md8hFUO3txo3i6HEbxiWU5lYOuX38fcrnXC8p9zojT7zALV/2E2o0yiaqHJJxilT
         eaaRd71G4su7L4OSJc1mCdYhheabzTyiUDaapQKPnI0R6doUSoxUIA5uKOx+Rh4COMVw
         HeCA==
X-Gm-Message-State: ACgBeo3HaMiP2KmziOzRPWIbraXPwQ0yQ9kgiFT8ERZSIrk3qeQ5i9RF
        Vx29IHYAMeNlSjPr/zUS9jVwdl5DZjXlzH/NB+Q=
X-Google-Smtp-Source: AA6agR75gtSXQnZkl1er1ObborDZW6Tt0Qlr8Lf6f0issBPgry00DlQa2kEbnOlZGdgfOPKILfTZDrpaUWTWXsrkdKk=
X-Received: by 2002:a05:6402:27ca:b0:43e:ce64:ca07 with SMTP id
 c10-20020a05640227ca00b0043ece64ca07mr6145406ede.66.1659713293023; Fri, 05
 Aug 2022 08:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081713.2182833-1-james.hilliard1@gmail.com>
In-Reply-To: <20220805081713.2182833-1-james.hilliard1@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 5 Aug 2022 08:28:01 -0700
Message-ID: <CAADnVQJ2LSrviYX++K8YQCc7B6yNapJ+MA9jCiFw=UQ3dQYMLw@mail.gmail.com>
Subject: Re: [PATCH v4] bpf/scripts: Generate GCC compatible helper defs header
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 5, 2022 at 1:18 AM James Hilliard <james.hilliard1@gmail.com> wrote:
>
> The current bpf_helper_defs.h helpers are llvm specific and don't work
> correctly with gcc.
>
> GCC requires kernel helper funcs to have the following attribute set:
> __attribute__((kernel_helper(NUM)))
>
> Generate gcc compatible headers based on the format in bpf-helpers.h.
>
> This leaves the bpf_helper_defs.h entirely unchanged and generates a
> fully separate GCC compatible bpf_helper_defs_attr.h header file
> which is conditionally included if the GCC kernel_helper attribute
> is supported.
>
> This adds GCC attribute style kernel helpers in bpf_helper_defs_attr.h:
>         void *bpf_map_lookup_elem(void *map, const void *key) __attribute__((kernel_helper(1)));
>
>         long bpf_map_update_elem(void *map, const void *key, const void *value, __u64 flags) __attribute__((kernel_helper(2)));
>
> See:
> https://github.com/gcc-mirror/gcc/blob/releases/gcc-12.1.0/gcc/config/bpf/bpf-helpers.h#L24-L27
>
> This fixes the following build error:
> error: indirect call in function, which are not supported by eBPF
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v3 -> v4:
>   - don't modify bpf_helper_defs.h
>   - generate bpf_helper_defs_attr.h for GCC
>   - check __has_attribute(kernel_helper) for selecting GCC defs

Great job ignoring the feedback.
Applied.
Just kidding.
