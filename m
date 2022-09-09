Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73C5B363C
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 13:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiIILVW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 07:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiIILVS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 07:21:18 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40001269D6
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 04:21:17 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id n81so692911iod.6
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 04:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pMJtpD8lzjZlebUzb4hjthDap7S/m6yp2XaBqfiOfk0=;
        b=kPpdyOWrSWFUoi+9KAj8L32FfyYb44F3ML0qpjw+sYVPjQNsl0DFayannUmpvL1NiX
         AuQ4aygA2gCDdvj0OQXqGUDezHS/VMgcaMdiBmcMgeP2Oa77eJNt/7RnrrNUAY6IrtdO
         qhEW5eYLDFWgdVL8WS0ZWRsO1BHTkI7RnisvfdTLk4VpiJLJVFQlN0ns2ytiUui6gCTP
         ItqVpGbbXYFEviZrilhSz1fZO48k4f/zqqkWSsuse9WeSU33Io/F6CSpvPhJWH1G2zFB
         yHTrQfoOQJOmL1AsDuEJwbO2j0LPZkgmI6w2s/5eNgD76TUZYAIy89XqAtpyosJsQZuv
         rHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pMJtpD8lzjZlebUzb4hjthDap7S/m6yp2XaBqfiOfk0=;
        b=FbSqB2SJVSHokmNGbSvNlrgBre8a9dhBh0mmuMWwSkYb93bBr7qBvzt0YQ/KnMGbhI
         CHxZXFtsbuWkEQ1sdv9RO/TkseTuB6YJxqKWDdsfo8dhVHWP2AuemW8Dn+hrmqk3VCh+
         GQGqE8k8pus9QwELOQtvzPg+7eCVWejUuu5rl8NuMbCrr+w0S57yr1MABpifVHEltFiq
         qP3VxpYwIPjBZlRAhoosLhaX6/DTW/0MUX+hgH34x41B4XnrTuqxPb9ZDbf1m1SNcv9Z
         BzdlREoPzfmo9CcnV9sBVhVLwA+yjiRFxomQ6GOa1BUEahzLB1WOWw0mIs+HIEXEZ+an
         l3RQ==
X-Gm-Message-State: ACgBeo3AOEUEBqJqfbF7hGTfWtSoZfmaPR6fn2nNcedmLPwMgtZnnowz
        BtWzqSbJ1xeLqledWLYW5zr7TLBg7Abv7i5DieahO8dP
X-Google-Smtp-Source: AA6agR4NRt2H2AxAlCacOfajhb9iIUhfgSOCljdYAN5wCBHkIA2Z0BWsQ1q4uY7rGP9j/pe9m4yzbzD00jOKe1ZuJKg=
X-Received: by 2002:a05:6602:2d8b:b0:688:ece0:e1da with SMTP id
 k11-20020a0566022d8b00b00688ece0e1damr6180322iow.18.1662722477099; Fri, 09
 Sep 2022 04:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-19-memxor@gmail.com>
 <20220908003557.uqiiwfjmjoq2sp3j@macbook-pro-4.dhcp.thefacebook.com> <247e2959-410f-f494-1083-f53224fb6f7a@fb.com>
In-Reply-To: <247e2959-410f-f494-1083-f53224fb6f7a@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 9 Sep 2022 13:20:41 +0200
Message-ID: <CAP01T77RdV-yP4RBy2G1R1SDfuwhLPOBi9mdAwnB7q_B8ovPtA@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 18/32] bpf: Support bpf_spin_lock in local kptrs
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
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

On Fri, 9 Sept 2022 at 10:25, Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 9/7/22 8:35 PM, Alexei Starovoitov wrote:
> > On Sun, Sep 04, 2022 at 10:41:31PM +0200, Kumar Kartikeya Dwivedi wrote:
> >> diff --git a/include/linux/poison.h b/include/linux/poison.h
> >> index d62ef5a6b4e9..753e00b81acf 100644
> >> --- a/include/linux/poison.h
> >> +++ b/include/linux/poison.h
> >> @@ -81,4 +81,7 @@
> >>  /********** net/core/page_pool.c **********/
> >>  #define PP_SIGNATURE                (0x40 + POISON_POINTER_DELTA)
> >>
> >> +/********** kernel/bpf/helpers.c **********/
> >> +#define BPF_PTR_POISON              ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
> >> +
> >
> > That was part of Dave's patch set as well.
> > Please keep his SOB and authorship and keep it as separate patch.
>
> My patch picked a different constant :). But on that note, it also added some
> checking in verifier.c so that verification fails if any arg or retval type
> was BPF_PTR_POISON after it should've been replaced. Perhaps it's worth shipping
> that patch ("bpf: Add verifier check for BPF_PTR_POISON retval and arg")
> separately? Would allow both rbtree series and this lock-focused patch to drop
> BPF_PTR_POISON changes after rebase.

Yeah, feel free to post it separately. I'm using the constant in this
patch for a different purpose (I separate the BPF_PTR_POISON case into
its own different argument type, and then check that it is always set
for it in check_btf_id_ok, to ensure DYN_BTF_ID is not setting some
static real BTF ID).

But why change the constant, eB9F looks very close to eBPF already :).
UL is just for unsigned long.
