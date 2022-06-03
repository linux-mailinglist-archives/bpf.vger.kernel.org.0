Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B48253D379
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 00:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345833AbiFCWIj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 18:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245510AbiFCWIi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 18:08:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D9E286DB
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 15:08:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k16so11996738wrg.7
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Kb3Ai6KpAfH2AH6K23uvOBhY7FmI+MMGOfztKiUG0zI=;
        b=Z+236qXUs8BNmzDe5JNa/4ToDpDMSqb1ggqI4gUdnP9wLDXvrDLpYDzGWmAV0q9hd7
         pCLuVg65WgqPtpUpm+v6c3qmjBRgMAHoyAyeIdopCBdkCB33zuE1sT6MhV2lWAzGsrfb
         m7pIatkAS8uqwPnr6kgKHu6XGT9Jo1oS4e9M94K4YwOffPWeCIxB8t7blVZgAofXC2dm
         +C3P+dLl8U9aLahXtNsBT/YJ5VCLjsO8G4+vQ5o/GBUwLSUqwtB01MEEdSu+iRvGvPxy
         3i9LHoC7CgdGUf6uBiadrbvNUznDk30jn4MSN8lXiR+WHAdnVrixHDMuQs6iHEx3E3aF
         8MiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Kb3Ai6KpAfH2AH6K23uvOBhY7FmI+MMGOfztKiUG0zI=;
        b=FhN/U/Vr6vzKW0XTHKCiqhbbIKPxp5oqNpnaEfjY/5Bdr582wubfYjBwbMA+x6QYXb
         B4RCc+YXLeOQUoKao2g+D55TiuvFKXyckWu8dVEsg8uqx2NbFKw5igVMiSqpCfBqnfDM
         xzw9ZozV6ZS5otCI9rBs8l8m8CXm8DwBnDKjoMUqN0MRnVVkjrnpFGGeLhBcDRGJC2AP
         QJQrq6PIsnWbGFUg5dRwtZAtft7ebfox1gzi+hQrloiK+H22CvX1Cbt3Lw05EFGK41lk
         p7ZscfhqUyMWS6ztABydjZO/dHjjrJrcs6OpKO5Tqor1gwroo+AiARsDNvKo1WQvoein
         bLqg==
X-Gm-Message-State: AOAM533raNttYbsbQweXTNM37AxBNZxnPegDkGGG3mjNTq/3g2BGFWgq
        CHcp/os8qaMkV+WRHNRacF1JxehSvCFLNw==
X-Google-Smtp-Source: ABdhPJxkq+gxiYI65cIdljPEcfBWuRe8yqH4Re7DKCwBv0nLLi/TVgmSimW0wr9DC5xqXFQzVp3r6g==
X-Received: by 2002:adf:e2cb:0:b0:20c:c1bb:9fcb with SMTP id d11-20020adfe2cb000000b0020cc1bb9fcbmr10209705wrj.35.1654294115623;
        Fri, 03 Jun 2022 15:08:35 -0700 (PDT)
Received: from pluto (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id p8-20020a1c5448000000b003942a244ed7sm9625062wmi.28.2022.06.03.15.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 15:08:35 -0700 (PDT)
Message-ID: <cd7821030cd2fca945592a935c2c0853dd2852a4.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] selftests/bpf: specify expected
 instructions in test_verifier tests
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Date:   Sat, 04 Jun 2022 01:08:33 +0300
In-Reply-To: <CAPhsuW5WrL-4qZz-NPufj7SWbWe+z4rVzc0cN3ufU2M_PnTwoQ@mail.gmail.com>
References: <20220603141047.2163170-1-eddyz87@gmail.com>
         <20220603141047.2163170-2-eddyz87@gmail.com>
         <CAPhsuW5WrL-4qZz-NPufj7SWbWe+z4rVzc0cN3ufU2M_PnTwoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Fri, 2022-06-03 at 14:31 -0700, Song Liu wrote:
> > On Fri, Jun 3, 2022 at 7:11 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> 
> > +#define INSN_OFF_MASK  ((s16)0xFFFF)
> > +#define INSN_IMM_MASK  ((s32)0xFFFFFFFF)
> 
> Shall we use __s16 and __s32 to match struct bpf_insn exactly.

Will do.

[...]

> > +       __u32 buf_elt_size = sizeof(**buf);
> 
> I guess elt means "element"? I would recommend use sizeof(struct bpf_insn)
> directly.

Will do.

[...]

> > +static int null_terminated_insn_len(struct bpf_insn *seq, int max_len)
> > +{
> > +       for (int i = 0; i < max_len; ++i) {
> 
> Sorry for missing this in v1. We should really pull variable
> declaration out, like
> 
> int i;
> 
> for (int i = 0; ...)

Sorry, just to clarify, you want me to pull all loop counter
declarations to the top of the relevant functions, right? (Affecting 4
functions in this patch).

[...]

> > +static int find_insn_subseq(struct bpf_insn *seq, struct bpf_insn *subseq,
> > +       if (check_unexpected &&
> > +           find_all_insn_subseqs(buf, test->unexpected_insns,
> > +                                 cnt, MAX_UNEXPECTED_INSNS)) {
> 
> I wonder whether we want different logic for unexpected_insns. With multiple
> sub sequences, say seq-A and seq-B, it is more natural to reject any results
> with either seq-A or seq-B. However, current logic will reject seq-A => seq-B,
> but will accept seq-B => seq-A. Does this make sense?

Have no strong opinion on this topic. In theory different variants
might be useful in different cases.

In the test cases for bpf_loop inlining I only had to match a single
unexpected instruction, so I opted to use same match function in both
expected and unexpected cases to keep things simple.

One thought that I had was that struct bpf_test might be extended in
the future as follows:

#define MAX_PATTERNS 4
...
struct bpf_test {
	...
	struct bpf_insn unexpected_insns[MAX_UNEXPECTED_INSNS][MAX_PATTERNS];
	...
}

Where each pattern follows logic "seq-A => seq-B", but patterns are
matched independently. So if the goal is to match either "seq-A" or
"seq-B" these should be specified as separate patterns. However, this
seems to be an overkill for the problem at hand.


