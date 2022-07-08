Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1857B56B476
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 10:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiGHI01 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 04:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237586AbiGHI00 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 04:26:26 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39871814A7
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 01:26:25 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h131-20020a1c2189000000b003a2cc290135so705849wmh.2
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 01:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/OVTFWFueCRPCSOvGcnm5qhmYMmcAYT2qYgKyKk2GrU=;
        b=QayVImNEczOhK0XOfo/Un1TkE91WIaEh4vd5WGqaoap8Zp3zXyX1dE2P6RqQrpT1XS
         oy1BzMte5WWi0qpuvNFLbedtjg2n7Za2D4EYGowA6pIDEJpZATtjx7KTCqtGGcRO+0Hm
         w4Ot42GczZ1AqfqjZNrfsIYwRBv4+h7ReSSB9exmjeAS3NcLvVOm3Cp0vlKsBAUZLeK4
         3U0QqPn/SGSigUG8o6BjBZ/4XRXPETHIM0smmMd84MTwqwWFc+HDBmhlrFEZT6wwwNtr
         wRf5occqwIOBxSXFsjoS+goTKLITad0wByayOqYY9Tj1R8PO6+gn4sR8T1ZFngyCv/Yb
         FUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/OVTFWFueCRPCSOvGcnm5qhmYMmcAYT2qYgKyKk2GrU=;
        b=ArXVB/abTUlil2gc78e4Kloh8FnhkBtFqzeSV1FZs0tCTPXTKbZluBQj+Ze6gyefaf
         DQW3VhpBWPo28vYI1h9lWL0cfIk4eIie/N+0afl66DmBVUIllU1mr6/wpR0xJR/uK3pm
         0plpeE617D2c4WU3x0ocSiS7yNg+ele67N29Ok4Ttsp4dNnZAwZYH/LxUrzXGWPgiKKj
         gAT9p8QB6Dmc7ADjHi/es32GSFw8xecxgjpePY+bdNlP0pzX2T/H57XH40VNTjDLYOg0
         tio9BdF6B1WQCaaboTNTSS+cJJ+JfcpJXqnY3C6vuDNUO5Tr7H8pK5zxIrutXVPEY3eD
         zAqQ==
X-Gm-Message-State: AJIora9RJZ1dLmrbFHNaF/dca7TE+zwI3KKkhT/TUURiIls7rNXNnBr5
        XxY3UN0EPbulUfzvFcvWxkSP4w==
X-Google-Smtp-Source: AGRyM1v4J522/CsbJ15YeUOvSaWI8hyF/D8ynhoDdCisWlk5JSxaXP8LbE/H1oMLQMyP+D4lTEzv7Q==
X-Received: by 2002:a05:600c:3491:b0:3a0:4d4a:2e2d with SMTP id a17-20020a05600c349100b003a04d4a2e2dmr9448093wmq.4.1657268783790;
        Fri, 08 Jul 2022 01:26:23 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id l1-20020a7bc441000000b003a2cf1535aasm1403895wmi.17.2022.07.08.01.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:26:23 -0700 (PDT)
Date:   Fri, 8 Jul 2022 09:25:58 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Hou Tao <houtao1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>
Subject: Re: [PATCH bpf-next v6 3/4] bpf, arm64: Impelment
 bpf_arch_text_poke() for arm64
Message-ID: <YsfqFp+IkhvXPoDl@myrica>
References: <20220625161255.547944-1-xukuohai@huawei.com>
 <20220625161255.547944-4-xukuohai@huawei.com>
 <YscMo+jlif44bxBP@larix>
 <b2d21d18-2fc1-be68-f8ac-d185fcfadbbd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d21d18-2fc1-be68-f8ac-d185fcfadbbd@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 08, 2022 at 10:41:46AM +0800, Xu Kuohai wrote:
> >> +/* generated prologue:
> >> + *      bti c // if CONFIG_ARM64_BTI_KERNEL
> >> + *      mov x9, lr
> >> + *      nop  // POKE_OFFSET
> >> + *      paciasp // if CONFIG_ARM64_PTR_AUTH_KERNEL
> > 
> > Any reason for the change regarding BTI and pointer auth?  We used to put
> > 'bti c' at the function entry if (BTI && !PA), or 'paciasp' if (BTI && PA),
> > because 'paciasp' is an implicit BTI.
> > 
> 
> Assuming paciasp is the first instruction if (BTI && PA), when a
> trampoline with BPF_TRAMP_F_CALL_ORIG flag attached, we'll encounter the
> following scenario.
> 
> bpf_prog:
>         paciasp // LR1
>         mov x9, lr
>         bl <trampoline> ----> trampoline:
>                                       ....
>                                       mov x10, <entry_for_CALL_ORIG>
>                                       blr x10
>                                         |
> CALL_ORIG_entry:                        |
>         bti c        <------------------|
>         stp x29, lr, [sp, #- 16]!
>         ...
>         autiasp // LR2
>         ret
> 
> Because LR1 and LR2 are not equal, the autiasp will fail!
> 
> To make this scenario work properly, the first instruction should be
> 'bti c'.

Right my mistake, this layout is also what GCC generates for normal kernel
functions when (BTI && PA), so it makes sense to use the same

Thanks,
Jean
