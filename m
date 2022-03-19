Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8C4DEA1B
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 19:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiCSSbx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 14:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiCSSbw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 14:31:52 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9497237013
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:30:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so9533483plg.5
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+1FRkxmGjBJKvSmmH1vnoLHzLvR7ZC2SvKnWi1bLC4c=;
        b=UvAioAl6WuTBsy2MmDrsvUEJ7px5cNOjIl3Br+OoZ4C4EHhzPGq03m8b4ZHhvO6XY6
         80oHVoGgng5vUJ+fvr7nrmqW6blQxZBBzlf78hC0WCuQqAEwHTtExnVgLm6jWCYOQS4P
         vQaDEbaXZkAoDqOFYYC8lGORdxDkQL953EkaiC2jrw0WC5cyYsznCTJDo45OnYeceWVZ
         JmDtVkhZOPSsgBQMxmy626u5djEaD8s41f7zn0lD+/g7guS1Ts2tqOxGBmAhYoZe7Vac
         kEVL3AfVSH99eXJ8RvlhBGDAZN/jLAQkdM4QpfeyvVfpGPaojRGkUgTvMF4oaF0GFFAY
         YNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1FRkxmGjBJKvSmmH1vnoLHzLvR7ZC2SvKnWi1bLC4c=;
        b=KHMwnBflts3pPIKZtB5kR+wfN7506Kl5DNj1TedrPTwg9mhYoQKiBy1I0kZsmRQ8qM
         XSnWXFPaX0heMMvjMU5VNsdQfh8987FM0q24WLCVOecq3lMOjWe0YOE0rPDn94qPVU4m
         5GFX5jyukG7N05thL8fBMSrTkKf7Uh7jmVPEnwL+m92zTi6JFF/A2d40oFOcMX2KSwie
         60zsXlndTjlSPU5GoNeTaabwTyMhOymwHngTNVcbwgoWG6z2SGgkPHJmEYpNpbA65bHt
         xgW+g2QQDmWVz5Hjm8V7/AXFJrUtQ+9lQ8E6sgDZXsxLyo6P0WaYz1sRIjJ/RVBgkwTP
         ti7w==
X-Gm-Message-State: AOAM5332TGxexvFJ+XZbdJoT6N64ftZREqsGj7OoMvXm7pZtatOCo859
        VMQea5aqp6BZUBS4kHhEn94=
X-Google-Smtp-Source: ABdhPJwiho8CavNoM7p5fMsXGAO6cpZya7wjlPVRw8TE0a6fcYx/ts90H6MPNgSynzNgpS0KpHoIgQ==
X-Received: by 2002:a17:90b:180b:b0:1bf:27c5:2c51 with SMTP id lw11-20020a17090b180b00b001bf27c52c51mr17902172pjb.142.1647714631101;
        Sat, 19 Mar 2022 11:30:31 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a65d])
        by smtp.gmail.com with ESMTPSA id t9-20020a056a0021c900b004f7b425211bsm12895085pfj.36.2022.03.19.11.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:30:30 -0700 (PDT)
Date:   Sat, 19 Mar 2022 11:30:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 05/15] bpf: Allow storing percpu kptr in map
Message-ID: <20220319183028.pwzaoz2qogek6nwz@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-6-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317115957.3193097-6-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 17, 2022 at 05:29:47PM +0530, Kumar Kartikeya Dwivedi wrote:
> Make adjustments to the code to allow storing percpu PTR_TO_BTF_ID in a
> map. Similar to 'kptr_ref' tag, a new 'kptr_percpu' allows tagging types
> of pointers accepting stores of such register types. On load, verifier
> marks destination register as having type PTR_TO_BTF_ID | MEM_PERCPU |
> PTR_MAYBE_NULL.
> 
> Cc: Hao Luo <haoluo@google.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h   |  3 ++-
>  kernel/bpf/btf.c      | 13 ++++++++++---
>  kernel/bpf/verifier.c | 26 +++++++++++++++++++++-----
>  3 files changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 702aa882e4a3..433f5cb161cf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -161,7 +161,8 @@ enum {
>  };
>  
>  enum {
> -	BPF_MAP_VALUE_OFF_F_REF = (1U << 0),
> +	BPF_MAP_VALUE_OFF_F_REF    = (1U << 0),
> +	BPF_MAP_VALUE_OFF_F_PERCPU = (1U << 1),

What is the use case for storing __percpu pointer into a map?
