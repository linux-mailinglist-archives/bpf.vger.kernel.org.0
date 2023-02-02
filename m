Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F876888EB
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 22:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjBBVVe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 16:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjBBVVd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 16:21:33 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E306DB1B;
        Thu,  2 Feb 2023 13:21:32 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gr7so9861274ejb.5;
        Thu, 02 Feb 2023 13:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gSyJPeHxN6glqF50Jf3a9ZSuNsTot5DI62NEtSRA9us=;
        b=FsXdaugBi4veiEDNI7QHXEDaFz4OdEee/wHMOYm7CfGKxtza2J57Rv6BWlIBupunrY
         TTUKMoN6JAhAkohHlVCZgIDuGvo/1+XUBvS7ClBOv/i52MtPiDyzQfLXdzFNtmwhLmv9
         r7vITFgimeudrBKgiBQJCcOGOs3NOtkePG2hU02COwtMVaE6CSPfOeSBHI3CSh/rEMVg
         fkZhuPOBr34EB+tj23ZLHsnVUQ+pFvLyfaKGd9wgOmOE5iRGZ2G8fjuLvtq8jr4V2pzY
         HZNXrd2TO2lO5QNX0xJmBFG99S2lDRChbyO6WWodrAwLOS2NCpNkaXE40+9el6w7JESE
         Rh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSyJPeHxN6glqF50Jf3a9ZSuNsTot5DI62NEtSRA9us=;
        b=VdPclpnTdyJ9ZAoPkXZBEfdfQUYYlQ3uG2YNyJQr0yW54KiBKVOp0/dzipZPm10JS2
         +eyvJpjDJwJwLxT2Tls9W2fYtOnDmyq3Hm/V2FYl1pUYXpCSOz1wdLqWUmubqItnzlio
         WHxjd/oXLvDVrlgHgqYaw7Mhs2n3U3p5jINka8E2UnZe2LxzAXzXEQmwJKyz9kNwhKRJ
         Y25WsRkZfVwofclcNWgmTiR7gDFIhSV/qxxYagIz2gldQnYCePtuB+aQ6WZhtqVtz8wK
         b1fXOiFJ3DNnW2M0ftbw07m8/tppqYX8ckEbQvyJY3ybpkGEQdNThNARUkzBwI4jwXYl
         0vGw==
X-Gm-Message-State: AO0yUKVWFpJNXLtYtP2RZyemnCHFZP/Yzj+6JzMIRAEinDEpsqtCNC7C
        QgLroYMq9dH9nbRS1CCxjImZ5NR7x6+P3x3n3DA=
X-Google-Smtp-Source: AK7set/97qq3TZuGbibfCSy2G7vqNMrsQUGT0EAEq0g81eyVrVysCCP5tqXMHKoqJxk8y4oRfJRNEabmzbjQ/1DBY3w=
X-Received: by 2002:a17:906:fc20:b0:86e:429b:6a20 with SMTP id
 ov32-20020a170906fc2000b0086e429b6a20mr2277052ejb.247.1675372890547; Thu, 02
 Feb 2023 13:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20230202163056.658641-1-void@manifault.com> <20230202163056.658641-3-void@manifault.com>
In-Reply-To: <20230202163056.658641-3-void@manifault.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Feb 2023 13:21:19 -0800
Message-ID: <CAADnVQJjmnEpXWL8-SAPt5zYXnFYeF8-wXXpA9shOhqUXNPw=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add KF_DEPRECATED kfunc flag
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
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

On Thu, Feb 2, 2023 at 8:31 AM David Vernet <void@manifault.com> wrote:
>
> Now that we have our kfunc lifecycle expectations clearly documented,
> and that KF_DEPRECATED is documented as an optional method for kfunc
> developers and maintainers to provide a deprecation story to BPF users,
> we need to actually implement the flag.
>
> This patch adds KF_DEPRECATED, and updates the verifier to issue a
> verifier log message if a deprecated kfunc is called. Currently, a BPF
> program either has to fail to verify, or be loaded with log level 2 in
> order to see the message. We could eventually enhance this to always
> be logged regardless of log level or verification status, or we could
> instead emit a warning to dmesg. This seems like the least controversial
> option for now.
>
> A subsequent patch will add a selftest that verifies this behavior.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  include/linux/btf.h   | 1 +
>  kernel/bpf/verifier.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 49e0fe6d8274..a0ea788ee9b0 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -71,6 +71,7 @@
>  #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
>  #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
>  #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
> +#define KF_DEPRECATED   (1 << 8) /* kfunc is slated to be removed or deprecated */
>
>  /*
>   * Tag marking a kernel function as a kfunc. This is meant to minimize the
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4cc0e70ee71e..22adcf24f9e1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -8511,6 +8511,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
>         return meta->kfunc_flags & KF_RCU;
>  }
>
> +static bool is_kfunc_deprecated(const struct bpf_kfunc_call_arg_meta *meta)
> +{
> +       return meta->kfunc_flags & KF_DEPRECATED;
> +}
> +
>  static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
>  {
>         return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
> @@ -9646,6 +9651,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>                         mark_btf_func_reg_size(env, regno, t->size);
>         }
>
> +       if (is_kfunc_deprecated(&meta))
> +               verbose(env, "calling deprecated kfunc %s\n", func_name);
> +

Since prog will successfully load, no one will notice this message.

I think we can skip patches 2 and 3 for now.
