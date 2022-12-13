Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE1B64BC3B
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 19:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiLMSns (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 13:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235679AbiLMSnr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 13:43:47 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8980B23E91
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 10:43:46 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t18so2803253pfq.13
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 10:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uRGW0A+WTGjFo/YgO5+knFwqY+lAetwgiQNnuZJK0ps=;
        b=JIKmFS0ek7EajdqLddDexCX/fRyN6IBC6pmw5HLl/UxsJPPx3Vz1AkQgQZWkhP48V8
         2gR2Qt+eLzojj3gcKbcGK8ScWFsZzSzCRsusU6Eq6u9YjxprWCrgmdUC/7tjsbg2tdnS
         V1wYEKQp9WvVfrl/7L7zT8+fmS4EHwmHH0ejf7iaka+X1PjPBw5EEJRVhxi3gSGVyGt3
         GXXNSpMXpTzpL+cENTbJsX16sfxazev75oeWwFVevwzn5/h3oL/DnE8kGvE7j5RcmDok
         0+3QJ5SAj3oBuBH00fM3bksJ9ftJd6hjERRIWCA9haYpfqhfX8A+hUOaL5xQ6fpFpB0N
         7aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRGW0A+WTGjFo/YgO5+knFwqY+lAetwgiQNnuZJK0ps=;
        b=POnD3mQGux8lA3PnE6TaBMFYPzODVy+P6O8BrCNEKpknfVV99WdUoTkV+0piTE+BOq
         sxDSqgd8+SiTnheJ7tBAyyfv3WJmrl1JFA/rGgQN90DH+6pL/QPqiEZ3ecHqhCwwjnMF
         coI2XKKjWJbr7s9TviF7mUkHWBfXNYJMcWaLo45iHiyzkka9G+g3GNY30AUU2FSDyBki
         XQFyB5KvPAmEz8i+Yla8swfuBcouMENJisp3fgaPNnr2DF/P0jUOdRbsUnZMcy35SMib
         Us+YKkqA7W+CT3lx11HMBsLIBHZMdjEYF3MZYpvpq4NLLiBJIh8tswp64LX+zP+S8nl3
         VnGw==
X-Gm-Message-State: ANoB5pk6E0RzAMflpjtJ6NTYTcQfFwO5j3c2fmgWUz8SbTC20iDiEpHm
        Eq9aMxb8gPdlnn+Ky2vl+gzp+Mjrgu3Kts+lyHv8+25XgM0zAMXq
X-Google-Smtp-Source: AA0mqf7HIg+ZL6u6Vm7VqqRU5sJQKj0S5J3zqbG7iBJWLAfsTsDvYbKfhNZvnBOz8boiRoThjX/RqqSzbBtXSzBBiAU=
X-Received: by 2002:aa7:9006:0:b0:578:8d57:12ce with SMTP id
 m6-20020aa79006000000b005788d5712cemr513366pfo.42.1670957025838; Tue, 13 Dec
 2022 10:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20221213175714.31963-1-milan@mdaverde.com>
In-Reply-To: <20221213175714.31963-1-milan@mdaverde.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 13 Dec 2022 10:43:34 -0800
Message-ID: <CAKH8qBvRnDFhWEkZr9UNdznKNoCcjsZNBXeSVpXWooFhm5+C3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: prevent leak of lsm program after failed attach
To:     Milan Landaverde <milan@mdaverde.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 13, 2022 at 9:58 AM Milan Landaverde <milan@mdaverde.com> wrote:
>
> In [0], we added the ability to bpf_prog_attach LSM programs to cgroups,
> but in our validation to make sure the prog is meant to be attached to
> BPF_LSM_CGROUP, we return too early if the check fails. This results in
> lack of decrementing prog's refcnt (through bpf_prog_put)
> leaving the LSM program alive past the point of the expected lifecycle.
> This fix allows for the decrement to take place.
>
> [0] https://lore.kernel.org/all/20220628174314.1216643-4-sdf@google.com/
>
> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> Signed-off-by: Milan Landaverde <milan@mdaverde.com>

Makes sense, thank you!

Reviewed-by: Stanislav Fomichev <sdf@google.com>

> ---
>  kernel/bpf/syscall.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 35972afb6850..64131f88c553 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3518,9 +3518,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>         case BPF_PROG_TYPE_LSM:
>                 if (ptype == BPF_PROG_TYPE_LSM &&
>                     prog->expected_attach_type != BPF_LSM_CGROUP)
> -                       return -EINVAL;
> -
> -               ret = cgroup_bpf_prog_attach(attr, ptype, prog);
> +                       ret = -EINVAL;
> +               else
> +                       ret = cgroup_bpf_prog_attach(attr, ptype, prog);
>                 break;
>         default:
>                 ret = -EINVAL;
> --
> 2.34.1
>
