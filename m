Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0866E673F70
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 18:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjASRCP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 12:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjASRCO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 12:02:14 -0500
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93267693
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 09:02:13 -0800 (PST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-15f97c478a8so3175170fac.13
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 09:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xqJcG+rk0/yFhH7cO2OX+QADWK3GAOIC0vU6tY9etyA=;
        b=EWfsM9DnR0EV/BmEyiLsTBlTKna/8y2/mFDKh9gB63admXNGLDu9oWuSwFTBobSM4t
         oB3ZI6/+fzCf6oKuYD+Nk3xm2zF2ihej1znEHhCVsDRrn4X4sfwErx+VJu3OVniAKRAu
         LMgyu4PazSpZ9tmStXyz1S8EZHWwzO7QMXxkR1BPrms3z6nEJDg0EtyT8DbCTYWQz2FR
         3BewwqeblnS4c8slyiHICoIKcUoCtwHkNt7RYMNtXB58rAaciJK5puAfybTciAeAQAj7
         y/Af9oKF1BzQfDcsju9viCym+r/zK09pyfKyxJ3AkQPd7mgm/BnhKwsjPWxgbXr1tF13
         a2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqJcG+rk0/yFhH7cO2OX+QADWK3GAOIC0vU6tY9etyA=;
        b=Wf6RYl3Tq7K/5lLc7hasGNHQ4jpeaYQ/mwVMgl3G31o/2rNnnEiAJen6jZPPJZHmeY
         2BQT+3L8svrxjGRMmQMescNKntxhUOwimddTkOldFdHuTlF0dXarPYMdX2GxykRAdbfX
         YlFjFxWF8haJA/NdvrlZhFv6t9qqPICFoY+kspGcKnIfqg0BRJOaiiTRMm938KPTw+ac
         Ybr3dbn9OIxdHnaNOnlvvpCHsHbzRDfsjXy1MgWUSSG55aJBKzGjpOs5Mw/949UUKcPY
         8RO0QaUI42xw6mpnULBofqM2DyesjWtpn4KaUY/XD3U+P2KhqKvXZDQwZ7l+Q1wO0OYN
         iMbA==
X-Gm-Message-State: AFqh2koVo2iSywqwYL8fOw27rRfZrI1Lni0SN4qjUIo2ZmuaRcDNk/7P
        mc3eQXj206lC9qxVgfa4SSUsxqCvtDR0kNIKw54=
X-Google-Smtp-Source: AMrXdXsYF9+KMMxr98LTHOEoeoe0x7uOpT83jonGHAUqLh7OESWmBUzQ5nLtBiUFoe2XRGpSy/DN28j8SGFWShNl1pw=
X-Received: by 2002:a05:6870:2a41:b0:15e:f69d:a25e with SMTP id
 jd1-20020a0568702a4100b0015ef69da25emr718437oab.293.1674147732965; Thu, 19
 Jan 2023 09:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20230119141331.962281-1-jolsa@kernel.org>
In-Reply-To: <20230119141331.962281-1-jolsa@kernel.org>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 19 Jan 2023 22:31:36 +0530
Message-ID: <CAP01T74jnDPaam-wDrk3+PiiV8fbqA0MzFuTom=yaRgR+Aq-Fw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Add missing btf_put to register_btf_id_dtor_kfuncs
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
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

On Thu, 19 Jan 2023 at 19:43, Jiri Olsa <jolsa@kernel.org> wrote:
>
> We take the BTF reference before we register dtors and we need
> to put it back when it's done.
>
> We probably won't se a problem with kernel BTF, but module BTF
> would stay loaded (because of the extra ref) even when its module
> is removed.
>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Fixes: 5ce937d613a4 ("bpf: Populate pairs of btf_id and destructor kfunc in btf")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Thanks for the fix.
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/btf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f7dd8af06413..b7017cae6fd1 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7782,9 +7782,9 @@ int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_c
>
>         sort(tab->dtors, tab->cnt, sizeof(tab->dtors[0]), btf_id_cmp_func, NULL);
>
> -       return 0;
>  end:
> -       btf_free_dtor_kfunc_tab(btf);
> +       if (ret)
> +               btf_free_dtor_kfunc_tab(btf);
>         btf_put(btf);
>         return ret;
>  }
> --
> 2.39.0
>
