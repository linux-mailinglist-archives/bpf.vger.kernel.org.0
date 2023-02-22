Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5A669FABA
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 19:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjBVSGE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 13:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjBVSGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 13:06:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0CF41094
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 10:06:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eg37so30140941edb.12
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cGpZFU2UcyLBydYiuqKlsQusqJUYTSHZymwHyqf4dkc=;
        b=Xkx03R7iomk5nIEr8uA5j4kl8AmgbyUaJcMuYDQL6IMZAsqZk4vY7foqn3wxGQQMy1
         NBVIwOkF82w3lG/JUIhE1hTT/K4ncaMS6R30z4+NAGQmt4eLAMVdYnty7qGBJrQl/zdI
         PTANY91znSBzv2Rt0b/823er0ArDX1ilVOnjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGpZFU2UcyLBydYiuqKlsQusqJUYTSHZymwHyqf4dkc=;
        b=2ACI+OlkpiOiNvMkrgmOcbWANQf8L7t84+7DVNt5y3cMp7oxLI440Lc8SUGZfazTBw
         W8a5XQYz93+RCd8apbP7tp3q2NBRvrVfCyMr3gqmDYrwDfEQ2w9c8Fe00UYlOuqR+Orx
         THLWCeF++Njmmy5D2xnTNDbSNLlpPHGtb1HlLSirmSkPyB6ZlHF34KmHQdQsMw7CG7Gi
         Z7MUDf3ws3HfEhknWDkzbl2N5vwjx9gJbzrraI5BKd9+gEtr/Pt73E3c/NonDrsw30eD
         0m7UxYB3LzsHyrilSUaQzRVNmZed9p+Elvy6XAiDMNdt+4DwQJYXxXABZ8Cw6OkkR08O
         zprQ==
X-Gm-Message-State: AO0yUKVlg+RrPcfdiH1VZgpNXA76dSXf6ma7BdoHc1hUKpq7RhwDsin7
        GZXchSysrr06fMAJC36ssX/EecvpiDOjn7oTfVo=
X-Google-Smtp-Source: AK7set9HyE0Ci/k5vDdyONlVERjxJtkXWe4dV+4WNJgRR4JDYcxXIP3fSZ7v7TPoMVYQ3Q772vqaeA==
X-Received: by 2002:a17:907:c689:b0:8b1:23cf:13dc with SMTP id ue9-20020a170907c68900b008b123cf13dcmr18271161ejc.16.1677089159256;
        Wed, 22 Feb 2023 10:05:59 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id qc10-20020a170906d8aa00b008ce79a0d3f8sm4601425ejb.44.2023.02.22.10.05.58
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 10:05:58 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id f13so33417368edz.6
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 10:05:58 -0800 (PST)
X-Received: by 2002:a50:d619:0:b0:4ab:3a49:68b9 with SMTP id
 x25-20020a50d619000000b004ab3a4968b9mr4197830edi.5.1677089157879; Wed, 22 Feb
 2023 10:05:57 -0800 (PST)
MIME-Version: 1.0
References: <9c476aa64c9588205817833dbaa622f87c0e0081.1677051600.git.viresh.kumar@linaro.org>
 <CAMuHMdXd3876o+petD51xfnJRBOOg=oqkO_pdsmcr8=Uec2KDg@mail.gmail.com>
 <7189da9a-f634-01ae-194d-a4d14a319a1c@intel.com> <CAADnVQKX0ZD=8Xu4U2H_vbyuNoXJv0UZ1OffUtqw3vs0v95ELQ@mail.gmail.com>
In-Reply-To: <CAADnVQKX0ZD=8Xu4U2H_vbyuNoXJv0UZ1OffUtqw3vs0v95ELQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Feb 2023 10:05:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8E68rT2X1fHjxxn0GQhmz7vSVOmmY4Kk1W0VEYjFjnA@mail.gmail.com>
Message-ID: <CAHk-=wg8E68rT2X1fHjxxn0GQhmz7vSVOmmY4Kk1W0VEYjFjnA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix undeclared function 'barrier_nospec' warning
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 22, 2023 at 8:29 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Linus,
> Since the blast radius is big, may be apply the fix directly ?

Yup, done. Of the different patches I picked the same location you had
taken so that there shouldn't be any conflicts if that ends making it
to me later.

                  Linus
