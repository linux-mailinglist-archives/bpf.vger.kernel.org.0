Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9204862C3C2
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 17:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbiKPQQu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 11:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiKPQQs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 11:16:48 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A074756EF9;
        Wed, 16 Nov 2022 08:16:41 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i21so27311334edj.10;
        Wed, 16 Nov 2022 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oyC+JG2j0IITo5qTGz+wgr7L9QvSOVg95WWnwiLkRlk=;
        b=nu0f182GHr4/oXvVgfqPrTaVmMJY1kOkyoQNPJBEHeq/YTv4TnVqESuk44fa+dYSE6
         zROnl8KWUxSyc5d3spKfj+etdFbteVZudbjwk13CZ41P8TIB8HdqgyYP+FaCwhOe/hMd
         6d98SNTC604wKCD99u5v//MhwqU3kCXR9dwLLvZud4PTx1RAgD4R8hqM0pZeIbTbmN8t
         beeORJtPNmg6YEX84PhhPXehB6QayOFKi8iAbaH407dkoEL5lv+E6JD7besihzkfoxjs
         oO6S7ii7RRDDoPtCdngHJlxPA666lBxYnHmqwanJKulITwS8BoUIuTP+IFwym1yWT/Ee
         rTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyC+JG2j0IITo5qTGz+wgr7L9QvSOVg95WWnwiLkRlk=;
        b=j3I8OUfNRAkJWuPa9co9DDZ/sDVO9jjJKhz/lSPTnf9Vp+Sq51q+7tJln/tKb7Qpno
         Hu+/o3MX9OXx/GKLcmM1kkX8e6ebegb4VLF97YXHrXZZAsiV5/nYS9+8+gwFaspO+Oq1
         NThYAZqHHSFpVpI8YTcZeKJcRXZ6KVXy97r8HEVs81Lyy4DQLrPskrqy6aJ2EXD0BS1W
         erBolebA901JQhdVU0JitZT19KMpY03znW+WOJwtXSkJInjCjLhLTczHIq92f2l/nfmS
         Q0qLC8smpv8bdeKQhr+JaThlIFZBtCI2A5BM+SuKa9pWwvCC2NkN56/dJ320a+G5XL7X
         dI8w==
X-Gm-Message-State: ANoB5pn/XaWaCOMrz41e6oMB/69CRfA/lzg9ohqFLbA7zyBDmdFe04xM
        Uj/hB/TzcJw6O6V7SN0tmxf0YRL9x2ssmD/EwUI=
X-Google-Smtp-Source: AA0mqf5RzjDNrVdJ4jPbPIK4qWi/GaWjiVhjYKDAcBRL3/wrfTFxGQgHNmai2YxN5KZcYkypu2+WodYchj/bxoVWpRk=
X-Received: by 2002:a05:6402:2424:b0:459:2515:b27b with SMTP id
 t36-20020a056402242400b004592515b27bmr20048938eda.338.1668615400096; Wed, 16
 Nov 2022 08:16:40 -0800 (PST)
MIME-Version: 1.0
References: <700dffccdfeeb3d19c5385550e4c84f08c705e19.camel@huaweicloud.com> <20221116154712.4115929-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221116154712.4115929-1-roberto.sassu@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 16 Nov 2022 08:16:28 -0800
Message-ID: <CAADnVQLQswvu3oGyeevLrKMT200yD4hzCbkBUAs=1bKSDVaOQg@mail.gmail.com>
Subject: Re: [PoC][PATCH] bpf: Call return value check function in the JITed code
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
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

On Wed, Nov 16, 2022 at 7:48 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> +static bool is_ret_value_allowed(int ret, u32 ret_flags)
> +{
> +       if ((ret < 0 && !(ret_flags & LSM_RET_NEG)) ||
> +           (ret == 0 && !(ret_flags & LSM_RET_ZERO)) ||
> +           (ret == 1 && !(ret_flags & LSM_RET_ONE)) ||
> +           (ret > 1 && !(ret_flags & LSM_RET_GT_ONE)))
> +               return false;
> +
> +       return true;
> +}
> +
>  /* For every LSM hook that allows attachment of BPF programs, declare a nop
>   * function where a BPF program can be attached.
>   */
> @@ -30,6 +41,15 @@ noinline RET bpf_lsm_##NAME(__VA_ARGS__)     \
>  #include <linux/lsm_hook_defs.h>
>  #undef LSM_HOOK
>
> +#define LSM_HOOK(RET, DEFAULT, RET_FLAGS, NAME, ...)   \
> +noinline RET bpf_lsm_##NAME##_ret(int ret)     \
> +{                                              \
> +       return is_ret_value_allowed(ret, RET_FLAGS) ? ret : DEFAULT; \
> +}
> +
> +#include <linux/lsm_hook_defs.h>
> +#undef LSM_HOOK
> +

because lsm hooks is mess of undocumented return values your
"solution" is to add hundreds of noninline functions
and hack the call into them in JITs ?!
That's an obvious no-go. Not sure why you bothered to implement it.
