Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67944B2ADF
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 17:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243634AbiBKQrq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 11:47:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiBKQrp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 11:47:45 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC14FD
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 08:47:44 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 10so5140696plj.1
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 08:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vJ7J4K2EFU3/EsnFRf8ufMOj7l9QdZ9LQgXKhr/Xz2Q=;
        b=YaB3UGWaaTJ+vP6XrYwJY7RZ7ts1Nucck//dfLizzz/vvybX1LLTCcSLdfXPH60q7T
         vFgHHxBK09EXFVYUoJAgSccZkDKOP+D8QCetgQozoveesK8r6Zc9ZPwIl69O1oJ2CY5R
         Vablp1I6kcRF3DPTbOkC8pZYNj4ZIfd0jIOTKRRWTWb4GVw9z1Sy4MwUuP4hlEDbXIFC
         MgkgeaTVxwyiH3b0j7lhh+whyz/Ypak98OhwDJ9z62ypYdLc/IUZqM1g2d7ZFB51fAyH
         lJNkLIoEaNKMekleIy+noVCzUyKpLJiizwCC30wa2VghSeAzv0vC0wczZOrcPaTeON/w
         NEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vJ7J4K2EFU3/EsnFRf8ufMOj7l9QdZ9LQgXKhr/Xz2Q=;
        b=O+vLnvCka2mrHB1dUbm16cGLSfCQiVTVhTDb7M38QsMK4301xmKBvBcVFNLU86uSRj
         ZFz1EH2+a47dMDZXj/OxwD8pWn/+grU/3MG5gsF6ZJZSRGUMMwDHlqcwfdBuLxc7SfFv
         P/Oa6+oufJTcR4znL6qQ4BeHaEDKZIWQj13afUqVyH9xV1BjNAvqyuXkrQQjEdAfBxG+
         p2j1uI3iRxcWDiZvyKs0RH8QAeYKqMOBY5imF9Xa97wPIEV/2b3lYJKgXyuGPcgLPaT2
         dkPT2Qe9lfFwDBKdkLPFgP7zd00cZ0j1guS2SCXnKPsLFtdg6dBulKxVngzQDb3mI6aX
         JJNw==
X-Gm-Message-State: AOAM5336AxMFSqy0ds0y/qtETQEa+8yr4mqCNzg605g86JFMppiWjM3t
        HhD5w5vk7cBDSzNS466xz0jn7FzbsH6ccwXecEq4+Abu
X-Google-Smtp-Source: ABdhPJzORcWSIHZJyfJt5QTXMDFtmzWBc7By9ATdIxTffnoZ9MB5OPJasXb+VV01jtLcq0JA5m8N4M0KHUk0ha4Mm60=
X-Received: by 2002:a17:90b:1a8c:: with SMTP id ng12mr1260673pjb.62.1644598063736;
 Fri, 11 Feb 2022 08:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20220211152054.1584283-1-yhs@fb.com> <20220211152059.1584701-1-yhs@fb.com>
In-Reply-To: <20220211152059.1584701-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 11 Feb 2022 08:47:32 -0800
Message-ID: <CAADnVQJAMf0u=7gcpuNVgx7DQ8Zayvg4KGHYnQ7eNPjbVmc=cw@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix a bpf_timer initialization issue
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Fri, Feb 11, 2022 at 7:21 AM Yonghong Song <yhs@fb.com> wrote:
>
>   struct bpf_spin_lock {
>         __u32   val;
>   };
>   struct bpf_timer {
>         __u64 :64;
>         __u64 :64;
>   } __attribute__((aligned(8)));
>
> The initialization code:
>   *(struct bpf_spin_lock *)(dst + map->spin_lock_off) =
>       (struct bpf_spin_lock){};
>   *(struct bpf_timer *)(dst + map->timer_off) =
>       (struct bpf_timer){};
> It appears the compiler has no obligation to initialize anonymous fields.
> For example, let us use clang with bpf target as below:
>   $ cat t.c
>   struct bpf_timer {
>         unsigned long long :64;
>   };
>   struct bpf_timer2 {
>         unsigned long long a;
>   };
>
>   void test(struct bpf_timer *t) {
>     *t = (struct bpf_timer){};
>   }
>   void test2(struct bpf_timer2 *t) {
>     *t = (struct bpf_timer2){};
>   }
>   $ clang -target bpf -O2 -c -g t.c
>   $ llvm-objdump -d t.o
>    ...
>    0000000000000000 <test>:
>        0:       95 00 00 00 00 00 00 00 exit
>    0000000000000008 <test2>:
>        1:       b7 02 00 00 00 00 00 00 r2 = 0
>        2:       7b 21 00 00 00 00 00 00 *(u64 *)(r1 + 0) = r2
>        3:       95 00 00 00 00 00 00 00 exit

wow!
Is this a clang only behavior or gcc does the same "smart" optimization?

We've seen this issue with padding, but I could have never guessed
that compiler will do so for explicit anon fields.
I wonder what standard says and what other kernel code is broken
by this "optimization".
