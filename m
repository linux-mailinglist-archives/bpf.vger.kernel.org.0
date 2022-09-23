Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459E05E8511
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 23:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiIWVmV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 17:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWVmV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 17:42:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69213FB7D
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:42:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m3so1838925eda.12
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2EKXcM8AAXuWuxSPVj5TCMBy/lNTlxYxDKaiGh1Dpdk=;
        b=XBlvIr/M15ee+tUlkEhI4EJwtBv+jItXhnYCZmHoEQrE/lYMHgy9bwm8y6bMaxBllL
         yXxS1W45qURTrYtR/kChyDjaBSPYyGAI7qtYMx+IzydVnCk+ckdh9W/RP/PMeIzB1MAq
         Tu4fevvdH8ICqNARuUvgYA6cf1FvtNb41BEb5aaRMr1oq0rI6VxMLHm/2Mp0G+pbGD6C
         W2eR9BwKeWjdW287twIPVxd1/0zMTguq+2dAIrHxzjz/b3zEkl/PUqAsQbarpPf8hItu
         raHT+BAc5emWX7P2NL/NS1PM5pIeI7raTNbboHNZXAyLGQoj5PggcVCDUr73vqsh5k9J
         Gpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2EKXcM8AAXuWuxSPVj5TCMBy/lNTlxYxDKaiGh1Dpdk=;
        b=W18j+liPVQ32f/wR2WrDdTBuATgZ9ffHDIpemDikkgkpFF0nuaeXz6aR0bshtTlEBm
         OWZxy48aJ1alnfaRrQXOr4WfGcKjLuZ3PmQ0u0Ae5MzbPj36wtGbaV0Z45IktJFZ+KPK
         wXZIm3PCUBBhAQEmCaU5eZAs09A1AMEXigOXL/LCvvwgu4uwQ7t3YB0OKSo6kJGazPHx
         JiqGZZlvATTFFUobcGSWynHu4h574gLK9iPHL1XBAkCJ+E9NpkBJSP+HsY48vU+l6rSv
         HYMkCAJSLT2cCy/2RCSbWzxFzwxFLjxHKzySnrkXj5ao2cCSTv2arSrYoWao4IjxL0Al
         tQ2g==
X-Gm-Message-State: ACrzQf3WMDThTVgNgFP1r0xLDrpF95NBaLZVGBF1q6wIb5OLeIG1sYXN
        DPszmG1QpCXNuIlJiiLPHd3GiyxH/vK54amq0eWBfqllo0A=
X-Google-Smtp-Source: AMsMyM5JnYOqrSK3Nms9gmj2LZf0sIButMglIcDStkJZud81SGPfmsyNiBhYK6SbxAx6g5O98XkHOohcvUR/RqLcntw=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr10579539edb.333.1663969338267; Fri, 23
 Sep 2022 14:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220922210320.1076658-1-jolsa@kernel.org> <20220922210320.1076658-6-jolsa@kernel.org>
In-Reply-To: <20220922210320.1076658-6-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 14:42:07 -0700
Message-ID: <CAEf4BzbuWK3Ud=dwSv9-gDDsqX=ZWpZaFS=YL_SRiYsSBr+W2w@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 5/6] bpf: Return value in kprobe get_func_ip
 only for entry address
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>
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

On Thu, Sep 22, 2022 at 2:04 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Changing return value of kprobe's version of bpf_get_func_ip
> to return zero if the attach address is not on the function's
> entry point.
>
> For kprobes attached in the middle of the function we can't easily
> get to the function address especially now with the CONFIG_X86_KERNEL_IBT
> support.
>
> If user cares about current IP for kprobes attached within the
> function body, they can get it with PT_REGS_IP(ctx).
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/trace/bpf_trace.c                             | 5 ++++-
>  tools/testing/selftests/bpf/progs/get_func_ip_test.c | 4 ++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>

Can you please add a note in bpf_get_func_ip() description in
uapi/linux/bpf.h that this function returns zero for kprobes in the
middle of the function?

With that:

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index ebd1b348beb3..688552df95ca 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1048,7 +1048,10 @@ BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
>  {
>         struct kprobe *kp = kprobe_running();
>
> -       return kp ? (uintptr_t)kp->addr : 0;
> +       if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
> +               return 0;
> +
> +       return get_entry_ip((uintptr_t)kp->addr);
>  }

[...]
