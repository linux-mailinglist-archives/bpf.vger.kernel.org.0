Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17D59746B
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 18:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbiHQQlb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 12:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiHQQl3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 12:41:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AF27CB74;
        Wed, 17 Aug 2022 09:41:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w19so25531284ejc.7;
        Wed, 17 Aug 2022 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rNsoClh34rx/3eWm5W2OOBZPW56iIjZI3iAQYDBsTWs=;
        b=Fg3kShD9pR4kNxNRr0RRAEzvtaGoROTzXzWXbRQ/N91CLXomIxAXPrtyY9wuzmGqxt
         PpAYP747oAMly9tDUBssvT0/SzL0sMfmiyUdREi922bQ+79YLQQh1pD6d84hz+NVO508
         9eI6xz4JeRRTVVy2vTIOHEVSTX1twHcchbMm7OD4WsfQwMDDi2fNvWJoVX7QnbvLpdqi
         K+ITvj0cIT6GIVMiK0Kn4nQarHEVisyChJxGc+GMvVWIpSF43p42fqPGKNKq/RrzjFF1
         IWhRFrx/jpg6YSPFWsM7+q7EJDZoAGFAa+Or96qn+6wzCA1l1AM5xc21ELT8S9RRMv6K
         xzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rNsoClh34rx/3eWm5W2OOBZPW56iIjZI3iAQYDBsTWs=;
        b=b2IuYNFZEhGoB8/fNjckgCq+tF45fSQg76Al8QWK3ScQTmuXNMjkT7R/3LSV96okcA
         WjhUaJ83p2lYS8XxpWwTYpvOrC3Wi74nEHmpleZlFSsuNghzHZ8DT+QSbxeEW2+IBofX
         gafVrkwo2j4UcrIDYA5IMvfpeUdzsXECcW0Qi8qYG6Cn5IP6L6FtCpJUIKNRcJ8ROzn+
         PnUNgLvKTOEymcwBiWpLkWEGxcS/LeXyX3ASTbIL61Mw13XLwYuhr1ejZevq9ZcwVOto
         B/FQG+tvar9V+SGuR33X/BHCLPNLNhMZseLVuTm6qFv3SBna3CMbxsQ/bhIK6mH6dVf3
         TNpg==
X-Gm-Message-State: ACgBeo2liMBzcOneKNdw+K3nyH5AIDr+NYJ6vPGhiSqr5dWTPgGNKckj
        yS/UhH2tpt4t5clnpmA6LnatmFxWxQHFP1+y3fvka7W9
X-Google-Smtp-Source: AA6agR43/EUtCmpuDIx6Cp4gPaEJ+4+mhJLvg5Xro6mu953BxwhuJ+tFEbrp3F4IZrN+k6uBxNoJnFPAv3V7yphTRTw=
X-Received: by 2002:a17:907:e8d:b0:730:a4e8:27ed with SMTP id
 ho13-20020a1709070e8d00b00730a4e827edmr16635182ejc.58.1660754485835; Wed, 17
 Aug 2022 09:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220817130807.68279-1-punit.agrawal@bytedance.com>
In-Reply-To: <20220817130807.68279-1-punit.agrawal@bytedance.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 17 Aug 2022 09:41:14 -0700
Message-ID: <CAADnVQJsDYhNmP6G7O8tVfHZ7rQLeJ4KpwAQweVidny0fgTbyw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Simplify code by using for_each_cpu_wrap()
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>
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

On Wed, Aug 17, 2022 at 6:08 AM Punit Agrawal
<punit.agrawal@bytedance.com> wrote:
>
> No functional change intended.

?

> -       orig_cpu = cpu = raw_smp_processor_id();
> -       while (1) {
> +       for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
>                 struct pcpu_freelist_head *head;
>
>                 head = per_cpu_ptr(s->freelist, cpu);
> @@ -68,15 +67,10 @@ static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
>                         raw_spin_unlock(&head->lock);
>                         return;
>                 }
> -               cpu = cpumask_next(cpu, cpu_possible_mask);
> -               if (cpu >= nr_cpu_ids)
> -                       cpu = 0;
> -
> -               /* cannot lock any per cpu lock, try extralist */
> -               if (cpu == orig_cpu &&
> -                   pcpu_freelist_try_push_extra(s, node))
> -                       return;
>         }
> +
> +       /* cannot lock any per cpu lock, try extralist */
> +       pcpu_freelist_try_push_extra(s, node);

This is obviously not equivalent!
