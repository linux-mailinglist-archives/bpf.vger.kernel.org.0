Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324115F15A4
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiI3WC1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiI3WC0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:02:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBE218F420
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:02:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j6-20020a17090a31c600b0020a07b184deso2559719pjf.3
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZkakRNUHxuryr2twAFE4czJlYFi0rXIaL0aPx3WghkE=;
        b=W+mpm82qFTXxK0v9AoLuPCByBucAQSi10tVPwHNROxjLL4DUkuNnHiz20F0+ZF4jTW
         W54DMWDo3AXzb5CmYV6KlidxOYTxTSPYKh8Sc/HNcsQiytg9LX+j9HOX+INmryvcQ3Av
         xbZ8UZjB+882wfoIggcY93GjMcopbE4Tx7gWsYyUv6tKYaqFTnzPGmlRCSj6L0hAzqS8
         NK4x86RXH+/vDNtw71BrDPg4OO3HOLN90VDUUScfIus0iewtkpAhBR+vVh/WteZIzBNO
         gE6v8gaeaiafAD4Qo8LgsTF8bJVg7h7qwcGGyPy20oxRJDTwjUzOipndO7s/YSHVeg0s
         JJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZkakRNUHxuryr2twAFE4czJlYFi0rXIaL0aPx3WghkE=;
        b=3UbgpSLyafIjyyqAVEojahCfvN0hYwYkiwyk5i4DICw52miv7ncIvrB9Y7dhRNFwrP
         pG0yhkPyfKRMHI+7nGTwxWdR7QcGMcMmxZRvq7bQhhvsURLEIL1NROuyNRomHLmiMksR
         A+v76gq6pKCQqfqA4NEBWP2KZ8GAl941BTHClzexoiTfzbCkc+/e6W3umh+KPqVEdCvt
         JYYyAAglUax2kg0EvIbGZ6RSqMS2K5Y/reuq3zWV71wJlbt0kGCIFBnestgOP4C/9vHQ
         Z9DOPTSg3cqRA+ruqODmycfP9W3DcKIiEcoOQW9gAmRxDuBmUXqkHwcDeARwxi5Cly5c
         69pQ==
X-Gm-Message-State: ACrzQf14AUaMuj2V7j/DBGbPA6JTb/prfRHAlY9qzm26sXrOHJGKo8Ex
        5WLT3t1MX1uqnYXgQpEqFZc=
X-Google-Smtp-Source: AMsMyM7k8G/wdHoMVf2RVVL7WvBkV31ReYWKbJyxkliHThqfxJp5EJB24QX7S8CUol6TkCDS0pcO+Q==
X-Received: by 2002:a17:90a:688e:b0:205:e1ed:5cb1 with SMTP id a14-20020a17090a688e00b00205e1ed5cb1mr355187pjd.69.1664575345537;
        Fri, 30 Sep 2022 15:02:25 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:5e53])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b00176dd41320dsm2387008plk.119.2022.09.30.15.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:02:25 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:02:23 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH 10/15] ebpf-docs: Add appendix of all opcodes in order
Message-ID: <20220930220223.avtsehbwmgsbkzcz@macbook-pro-4.dhcp.thefacebook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-10-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927185958.14995-10-dthaler1968@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 06:59:53PM +0000, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/instruction-set.rst | 197 ++++++++++++++++++++++++++
>  1 file changed, 197 insertions(+)
> 
> diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
> index 926957830..b6f098104 100644
> --- a/Documentation/bpf/instruction-set.rst
> +++ b/Documentation/bpf/instruction-set.rst
> @@ -408,3 +408,200 @@ Legacy BPF Packet access instructions
>  eBPF previously introduced special instructions for access to packet data that were
>  carried over from classic BPF. However, these instructions are
>  deprecated and should no longer be used.
> +
> +Appendix
> +========
> +
> +For reference, the following table lists opcodes in order by value.
> +
> +======  ===  ====  ===================================================  ========================================
> +opcode  src  imm   description                                          reference
> +======  ===  ====  ===================================================  ========================================
> +0x00    0x0  any   (additional immediate value)                         `64-bit immediate instructions`_
> +0x04    0x0  any   dst = (uint32_t)(dst + imm)                          `Arithmetic instructions`_
> +0x05    0x0  0x00  goto +offset                                         `Jump instructions`_
> +0x07    0x0  any   dst += imm                                           `Arithmetic instructions`_
> +0x0c    any  0x00  dst = (uint32_t)(dst + src)                          `Arithmetic instructions`_


I guess it's useful, but how did you generate this table?
Looks very error prone if all hex numbers were done by human.
