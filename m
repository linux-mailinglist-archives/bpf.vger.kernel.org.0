Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69B5F15F6
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbiI3WRx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiI3WRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:17:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155991710DC
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:17:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o59-20020a17090a0a4100b0020a6d5803dfso631143pjo.4
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XH8juv9tTkl7oARxhoMI0PQqVhiNXka1fbBa32XDPkE=;
        b=HH8wI+ThhpwGaoaJD+425bNyh7WdqtEVuJkFChhDGNdxfheZZMpFtDtWMDd1JyjC6s
         3KNyCD/knKtbtSQa8R+aWtRGUD38dwhWXfprVbSATbV7vpt8pvNAxsuY1eHuvn6llrr+
         CR6qLB9Xg/mXVffJVULf09rMwPkTcn2OkIi8pjxBLyJXUlxethBmVcoa2YmpNWHvHRqj
         0wiDzFVnxu8I3Dhcagfg6sZ6OKjx9BGX6Q6TAy1Zr6hB7aOE5kJMimWbFkF2Uk5K1D2g
         LOuLSh8hHJGoW8C0jnAIWWg9RqZ4TKpwnoLMScas/ghas8bUieAoKxsRl/W155le1jCt
         BILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XH8juv9tTkl7oARxhoMI0PQqVhiNXka1fbBa32XDPkE=;
        b=N3ZpdO9sjKbx0PWJ+VVlze47azD3SAC1HEs/9rLE1KVw4C3OdddcKJOC9JBqxE1MmJ
         Fth6rImfcGN7RGVZNvrOEyANjRdjdlNTXxnuum60bO75qQeLhb/floA90raJ46YALOWj
         TRs7TyVOQvy4HXzKlPRWvn7ZcEpJSKnoer5eWY7Fnh3avD85JbM4lCYjt3cvA+6NqvXM
         Pl5HlnZqW0spBj6Ks+fppmUiZO4kLpJy6f2YZ6+9LUai7pmQ9LRdpvPqyBZDXGfgUwPR
         UNB2YURtftvEtwoW6bPyhnRUcVp8T6+KM042EVmL5DoNI2MxAG7erlQ3LtHhnfe7IueE
         VOWw==
X-Gm-Message-State: ACrzQf10JR6KWunRE9YV+TXOOl2BrXZufnIszL/lyIbAkyoRB1gM2LNE
        oQHjjaw/PkoQsUHh0EKoPAtcDApkg6o=
X-Google-Smtp-Source: AMsMyM6G8X9KEylVhB3QjUE/wslxTis4BoTsy/6gwJbFHOjKVYcpR1QFKZqPv3Cwa8Qqq4Bft3yHZg==
X-Received: by 2002:a17:902:ccc2:b0:178:29f9:5c5e with SMTP id z2-20020a170902ccc200b0017829f95c5emr10405547ple.21.1664576270390;
        Fri, 30 Sep 2022 15:17:50 -0700 (PDT)
Received: from macbook-pro-4.dhcp.thefacebook.com ([2620:10d:c090:400::5:5e53])
        by smtp.gmail.com with ESMTPSA id l188-20020a6225c5000000b005411a68fe74sm2324442pfl.183.2022.09.30.15.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:17:49 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:17:48 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     dthaler1968@googlemail.com
Cc:     bpf@vger.kernel.org, Dave Thaler <dthaler@microsoft.com>
Subject: Re: [PATCH 12/15] ebpf-docs: Add Linux note about register calling
 convention
Message-ID: <20220930221748.eknsxrfnzio2uouf@macbook-pro-4.dhcp.thefacebook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-12-dthaler1968@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927185958.14995-12-dthaler1968@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 27, 2022 at 06:59:55PM +0000, dthaler1968@googlemail.com wrote:
> From: Dave Thaler <dthaler@microsoft.com>
> 
> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
> ---
>  Documentation/bpf/linux-notes.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
> index 522ebe27d..0581ba326 100644
> --- a/Documentation/bpf/linux-notes.rst
> +++ b/Documentation/bpf/linux-notes.rst
> @@ -7,6 +7,12 @@ Linux implementation notes
>  
>  This document provides more details specific to the Linux kernel implementation of the eBPF instruction set.
>  
> +Registers and calling convention
> +================================
> +
> +All program types only use R1 which contains the "context", which is typically a structure containing all
> +the inputs needed, and the exit value for eBPF programs is passed as a 32 bit value.

There is a patch pending that makes return values 64-bit.
Also bpf progs that replace other bpf progs have all 5 input args.
I think this paragraph is unnecessary.

> +
>  Arithmetic instructions
>  =======================
>  
> -- 
> 2.33.4
> 
