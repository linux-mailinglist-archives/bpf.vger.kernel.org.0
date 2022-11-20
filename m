Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B39D63166D
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 21:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKTUto (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 15:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTUtn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 15:49:43 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C522E9C2
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 12:49:42 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f9so5263714pgf.7
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 12:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ckeXplXu4IR5HTGuyFR23eJ0de3U5LDAYym30S7gjE8=;
        b=TLBHVu87KSC1NGOoZOHvwfI3W56F/iJGB9R/D7KghH1+fbZN9rALhTg90q0t8v+p+Q
         9JUMnneS5kwBGdGvu25AKgbf1rzGzbZ8COKDohZHCkTNX5rOMP6TkquhUaDsoUjhyJxP
         tC0UHMjoVQ6UxP1lgkRMnE4EtfuaTjenFPkZL9s7TxtlpK6DAWJqDkoRtE+Ir+E5igPF
         hnSuL+ExptlQU7fKDo4K6poEAKnJ8sGP+jvjAiKPys7KEKLgBxQve0t4JjuM+fnNkBR9
         vJruS/o99/PIhArE4p3CWVWJ54rgB6ggSx84LU6gZBUFQ8iWmKUYm6IxvVdNk8LsvDSV
         93Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckeXplXu4IR5HTGuyFR23eJ0de3U5LDAYym30S7gjE8=;
        b=siINrfYSnCsOMd2QeI7WXQw8wjiKze/5xoWqv5ZA00zkRuo1bCxofeL3UMJkW+Aj4j
         Uqo0gjE6cLja8+/ELSqQQ0AWhZ24VbYbFBqffcS/0HEK0KiOThZXPETf3w1PAdiYCLnC
         ua+xxmuQ4r1UdxsbQ3HIC/wQj/XaErvFCNjK1sSvYTgyK6+Pjj7l73lnEPXGGunrCLoc
         AARrTuMeoyMrP9+q3DUWBlT450rK5CrPx2CVMSHgj7EJpKfwl9OntR1pe7yQ0qZBxWl1
         EvqQKlV5be6kPwlAnKn80iUMR/S3P/Uwi+jNObcoSIzDubJXaAwX9feZoVpfqdS4+wcY
         gxNw==
X-Gm-Message-State: ANoB5plJJBM3bGR1e89e5vrN92DDKasjyI7BIOgs/7iWF5siAMzx/YNW
        gRb2ibxpaQ+oSisKKdgzegY=
X-Google-Smtp-Source: AA0mqf5aR9FfbikRknqiKqtSNO9PgY0NMFoRgm+IwMFSeTa1mAKlSW+hFDMSV0LF7T8kwG+cOHW0sw==
X-Received: by 2002:a63:185a:0:b0:476:e84c:ab63 with SMTP id 26-20020a63185a000000b00476e84cab63mr923319pgy.496.1668977381936;
        Sun, 20 Nov 2022 12:49:41 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id 191-20020a6303c8000000b00434760ee36asm6068203pgd.16.2022.11.20.12.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 12:49:41 -0800 (PST)
Date:   Mon, 21 Nov 2022 02:19:30 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add a kfunc for generic type cast
Message-ID: <20221120204930.uuinebxndf7vkdwy@apollo>
References: <20221120195421.3112414-1-yhs@fb.com>
 <20221120195437.3114585-1-yhs@fb.com>
 <CAADnVQ+92vwqUB=J-QJYtrW0Yqvx2HAJJBREkXPJtW0+gyS1mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+92vwqUB=J-QJYtrW0Yqvx2HAJJBREkXPJtW0+gyS1mQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 01:46:04AM IST, Alexei Starovoitov wrote:
> On Sun, Nov 20, 2022 at 11:57 AM Yonghong Song <yhs@fb.com> wrote:
> >
> > @@ -8938,6 +8941,24 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                                 regs[BPF_REG_0].type = PTR_TO_BTF_ID | PTR_TRUSTED;
> >                                 regs[BPF_REG_0].btf = desc_btf;
> >                                 regs[BPF_REG_0].btf_id = meta.ret_btf_id;
> > +                       } else if (meta.func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
> > +                               if (!capable(CAP_PERFMON)) {
> > +                                       verbose(env,
> > +                                               "kfunc bpf_rdonly_cast requires CAP_PERFMON capability\n");
> > +                                       return -EACCES;
> > +                               }
>
> Just realized that bpf_cast_to_kern_ctx() has to be
> gated by cap_perfmon as well.
>
> Also the direct capable(CAP_PERFMON) is not quite correct.
> It should at least be perfmon_capable().
> But even better to use env->allow_ptr_leaks here.

Based on this, I wonder if this needs to be done for bpf_obj_new as well? It
doesn't zero initialize the memory it returns (except special fields, which is
required for correctness), so technically it allows leaking kernel addresses
with just CAP_BPF (apart from capabilities needed for the specific program types
it is available to).

Should that also have a env->allow_ptr_leaks check?
