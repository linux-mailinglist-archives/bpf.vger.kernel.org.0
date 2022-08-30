Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F53C5A66EC
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 17:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiH3PIv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 11:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiH3PIu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 11:08:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F3A1037E1
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 08:08:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id cu2so22868503ejb.0
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 08:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=4DHXYEdzg78iSHm/5gQtgUaZY8h5B+cbeX8u1kaa8KQ=;
        b=Qnd8NLtuhk3QnaOQvizINi9wDEiUWDc8aBJ/tKYF7zb/+yF8sbYPfT1wN7z3vGEsyv
         4A2jt6TXUUsRmm6NxBboOkfvErfdWvttmz0cbkIxOPPWCdW/HW/J4yVXPsjc2PhAeuXR
         jcakbHmkCwG62Xm+AOOy7bPERrMk+nHm8TXbiWbnGx8N4zrFHQZ0NU+Gs+wUFw7LeqqL
         gIpEM3gmI/3Dtjs9PM37EaioJEyMgLkRs22BIUU/ktp7mmsLT0+U+ElI46mcj+cdzN/X
         0wOtmjpOIbleqEF18EZ5GcPvdeIHOIBM7mfuE50It2pn2QsclOAUlbsBC4AhKhNvZAsd
         GJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=4DHXYEdzg78iSHm/5gQtgUaZY8h5B+cbeX8u1kaa8KQ=;
        b=l41jw6m0Rs4YKpAhNj6gMQFNVZYKjk7mJU7bmsu7h1Sp55wq3k/fpUGd5tivSMqHYI
         G32u6Hb62VsG1e2YUFH1L283AQjC0zPxCYesEUe+jUOeisCEV8AMv1ewoYRtzqHnLYzx
         rTBXBDEtsE07PGc40M5j3woS9aHzrvJ6irKydCsjdssTR+ifS3VNMiisEca70ZC6OzDF
         cywwn4KcfWZwBm+boLHOBie8u7u+Pf4sqDPlKIllwf6KSUA5Xtc6YKta8HPbytgoDUnL
         SffaIU2Si60MGljCH2s8GXbq1VZnBcypZg4r2rAtDlfumvP8X38ZXMu1e/J/nQNH2nF1
         nLdw==
X-Gm-Message-State: ACgBeo10jvJd4uTaLu6r5R5HPx5pxLQqTOkIp//3+qLR+lV9iTtaWQFZ
        NB9YSmO5WdOWZQ2iJU5GTmM=
X-Google-Smtp-Source: AA6agR6dRXSU42ILbMGiby/JNiA7Vb1blihQLJ+ZloIZ4kkbnEUkJPPe5zYDX9MJq1ID06DGX1vbKg==
X-Received: by 2002:a17:906:dc93:b0:742:133b:42c3 with SMTP id cs19-20020a170906dc9300b00742133b42c3mr3213092ejc.502.1661872127348;
        Tue, 30 Aug 2022 08:08:47 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090609b100b0073022b796a7sm5941031eje.93.2022.08.30.08.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:08:46 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 30 Aug 2022 17:08:44 +0200
To:     Alexei Starovoitov <ast@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHv2 bpf-next 1/6] kprobes: Add new
 KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
Message-ID: <Yw4n/NmFRuYivgi6@krava>
References: <20220811091526.172610-1-jolsa@kernel.org>
 <20220811091526.172610-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811091526.172610-2-jolsa@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Masami,
could you please check on this one?

thanks,
jirka

On Thu, Aug 11, 2022 at 11:15:21AM +0200, Jiri Olsa wrote:
> Adding KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag to indicate that
> attach address is on function entry. This is used in following
> changes in get_func_ip helper to return correct function address.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/kprobes.h | 1 +
>  kernel/kprobes.c        | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 55041d2f884d..a0b92be98984 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -103,6 +103,7 @@ struct kprobe {
>  				   * this flag is only for optimized_kprobe.
>  				   */
>  #define KPROBE_FLAG_FTRACE	8 /* probe is using ftrace */
> +#define KPROBE_FLAG_ON_FUNC_ENTRY	16 /* probe is on the function entry */
>  
>  /* Has this kprobe gone ? */
>  static inline bool kprobe_gone(struct kprobe *p)
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f214f8c088ed..a6b1b5c49d92 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1605,9 +1605,10 @@ int register_kprobe(struct kprobe *p)
>  	struct kprobe *old_p;
>  	struct module *probed_mod;
>  	kprobe_opcode_t *addr;
> +	bool on_func_entry;
>  
>  	/* Adjust probe address from symbol */
> -	addr = kprobe_addr(p);
> +	addr = _kprobe_addr(p->addr, p->symbol_name, p->offset, &on_func_entry);
>  	if (IS_ERR(addr))
>  		return PTR_ERR(addr);
>  	p->addr = addr;
> @@ -1627,6 +1628,9 @@ int register_kprobe(struct kprobe *p)
>  
>  	mutex_lock(&kprobe_mutex);
>  
> +	if (on_func_entry)
> +		p->flags |= KPROBE_FLAG_ON_FUNC_ENTRY;
> +
>  	old_p = get_kprobe(p->addr);
>  	if (old_p) {
>  		/* Since this may unoptimize 'old_p', locking 'text_mutex'. */
> -- 
> 2.37.1
> 
