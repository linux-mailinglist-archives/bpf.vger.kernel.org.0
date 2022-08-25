Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5095A0502
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 02:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiHYAON (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 20:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiHYAOM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 20:14:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076438048A
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:14:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r4so24062444edi.8
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1cZ5fH+Ewc2LGXwwIEQtYhVySKyjevRHiiFcPdgiin0=;
        b=IjZHKkFE+Y/xsGwnPIGv8XoyPktr8AHkmYM7kqDu3mLooyGu/LYG+vFKefWrUkL2uq
         7H7hVpwmCJw60ETvk+SXBnyK63VcGoOw/ZaAQC5s6p5HsU6iYizUcubV27rBKZ5gi+Zh
         J1lMtxonWXBqQ4SzXs7H9TqNGgpr5UnmFTItXNNqdx8H1qo8oF0k9MFlI61FZ20gysxg
         7/cu5ESsK5PS56/v97qssqxIjDiq5poHn3IVkUEk9elsdXsAzFR1IorUJLJY0Wk9ROtf
         ErNCPK87dFowrJf88ZkEnVlSnSNilsJkMpXD+wPvElqAKtXJiZD2kXAUVJ1inllp2oZq
         sZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1cZ5fH+Ewc2LGXwwIEQtYhVySKyjevRHiiFcPdgiin0=;
        b=IZWhc1f1TVXEk+PR2h+/C26dd7ALUYLyLChZAnZY6ZuWstAqAMlSt60v9xzc0W4LXf
         EARDQKw7B20PcPBBb6GrR5kdG6ptSW0+U7i+O7LP0TO6MIg6gnrPKJTSNV/ko9w2yGEo
         2wisB2Ry9V6BX6pFCABswAPTw0Q58Cp6OwjcVCxZwxwntR4jjH9TU/DPzONWib4j4G0W
         AvoSgE2kMTLnotLLBp6dLsKMh9XkK7s/z2lckiYwQcGWnenknCQ8Iu0u215K4t1Hk/b3
         155f2uO01wfzhTfqy3CiivYb2vm0vbNxdSIYUOqO/jXSNi2UB8GE/LcWmSWSstWvyvsn
         5x+Q==
X-Gm-Message-State: ACgBeo2sWLTEMIgadjA48nDOZDsN6eOLjdlDs49IpY5ibejB2JLlGKCF
        Am4mXCYMxBbnHV22VbR/F9RrMhwCjAnxWplIcqo=
X-Google-Smtp-Source: AA6agR7q1oY8UZE2gzyzK0MtljOQHFUAJdlTh63fIw5iHtU0la2yum1s/3oQOfGvI8spUSibYKcrFzkg3pPoopiigwQ=
X-Received: by 2002:a05:6402:28cb:b0:43b:c6d7:ef92 with SMTP id
 ef11-20020a05640228cb00b0043bc6d7ef92mr1106837edb.333.1661386450623; Wed, 24
 Aug 2022 17:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <20220819214232.18784-10-alexei.starovoitov@gmail.com> <CAP01T74qCUsm3mO64d6mbDcjQZxO2fxjZ+JX7kkv2ACXPpZojw@mail.gmail.com>
In-Reply-To: <CAP01T74qCUsm3mO64d6mbDcjQZxO2fxjZ+JX7kkv2ACXPpZojw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 24 Aug 2022 17:13:59 -0700
Message-ID: <CAADnVQJqqjN=i-ghnk4hjaztBtrRmyDZD7ro8cPNNwRP16=gkg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 09/15] bpf: Batch call_rcu callbacks instead
 of SLAB_TYPESAFE_BY_RCU.
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Joel Fernandes <joel@joelfernandes.org>
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

On Wed, Aug 24, 2022 at 12:59 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Fri, 19 Aug 2022 at 23:43, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > SLAB_TYPESAFE_BY_RCU makes kmem_caches non mergeable and slows down
> > kmem_cache_destroy. All bpf_mem_cache are safe to share across different maps
> > and programs. Convert SLAB_TYPESAFE_BY_RCU to batched call_rcu. This change
> > solves the memory consumption issue, avoids kmem_cache_destroy latency and
> > keeps bpf hash map performance the same.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Makes sense, there was a call_rcu_lazy work from Joel (CCed) on doing
> this batching using a timer + max batch count instead, I wonder if
> that fits our use case and could be useful in the future when it is
> merged?
>
> https://lore.kernel.org/rcu/20220713213237.1596225-2-joel@joelfernandes.org

Thanks for the pointer. It looks orthogonal.
timer based call_rcu is for power savings.
I'm not sure how it would help here. Probably wouldn't hurt.
But explicit waiting_for_gp list is necessary here,
because two later patches (sleepable support and per-cpu rcu-safe
freeing) are relying on this patch.
