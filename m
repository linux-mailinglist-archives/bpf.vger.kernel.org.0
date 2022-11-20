Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290BB631685
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 22:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiKTVCT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 16:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTVCS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 16:02:18 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEE227DCF
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 13:02:17 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y4so8918472plb.2
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 13:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYikZb7ZJffVyi8JRuLyXqDE9qFWPpbG20JgEQ9wQaI=;
        b=C1eioN6N0Q38Axzaaohblg0v5lcnlGsE1yslvf4aofiOhQczhOl1SgleYjQMKO0Jkt
         L4vtIt5oa++hi+TQee0tQvO5W8gWHrEE2iLklghqCZKxQHpmEnyJlSKNQF2/P78WbmZw
         2eu84TD+grZj3CQyLFwhyit9xATqq3LYF15Vhmt9DyQ9Qly0hG6smwXl+cS/9tKVg0gN
         Opu1eAXWr59FZpjXyD/CHnoYPLGJjanjP3lNQCBL//W2qhUY8z0V2UEG8FMXWfdGw9MI
         Xupo0TjVudVQoAaPJ89T/O4sHvX5KrkqGdyfst9083+wYktX/GKkh7OJiM+5CBWxJvgG
         YbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYikZb7ZJffVyi8JRuLyXqDE9qFWPpbG20JgEQ9wQaI=;
        b=ILvOmroDllMGuuWbYwjJtU2mRgFAILiQinmOAzofESA43AsHnNbdAJ0F1HMpuDpFXs
         3Pzt6ZB59Y+Dz4ysme1jLCz+fAIh4avDLSTlhZksnA5rxnEdB4wgQcBNkmVcgkWldr23
         EykR+djiNGTPylnPGW7lhacUtcI4kEb40euC5nPKgnNhjTu4q144gmTthcRd3lT/NgKF
         HgeTobPeVjwgV3sugxsaga5P2QXU/p190z77j0fzc5zwh7yjTVjONULqZScjetnxorO7
         xbyAIaXz+r7vdf7iXpjRW6JshUanWFQVqqUFmsN/Hl7pUXzhEtO5Ywb8SwY+ZeKZIV3I
         Gtwg==
X-Gm-Message-State: ANoB5pn8PuBlZHzsdEyXzNGVgztNJvmzw7vg0slyytsGwb3e9Q2pDye8
        pL9icL9vSkR7SiRzr6WUJr29h5n7IfM=
X-Google-Smtp-Source: AA0mqf6yryOtBqyylHB3a1q5mCUba8TWD7XIJXs9fWU97U3pnhPGMU3lSvZOv9B78qXDYh8yp0s8nw==
X-Received: by 2002:a17:90a:4c:b0:218:b187:d7da with SMTP id 12-20020a17090a004c00b00218b187d7damr2142549pjb.68.1668978137228;
        Sun, 20 Nov 2022 13:02:17 -0800 (PST)
Received: from localhost ([103.4.222.252])
        by smtp.gmail.com with ESMTPSA id g14-20020a17090a300e00b002137d3da760sm1065665pjb.39.2022.11.20.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 13:02:16 -0800 (PST)
Date:   Mon, 21 Nov 2022 02:32:05 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Move PTR_TO_STACK alignment check
 to process_dynptr_func
Message-ID: <20221120210205.anfsev2i66alszr3@apollo>
References: <20221115000130.1967465-1-memxor@gmail.com>
 <20221115000130.1967465-6-memxor@gmail.com>
 <Y3bIhyOWs1r22R+2@maniforge.lan>
 <20221120191013.plzlna24vwluxebk@apollo>
 <CAADnVQKcHObiPJ0Hs_5+QnEZwtZQ+9eezvpv_HcLWeq1z+PwqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKcHObiPJ0Hs_5+QnEZwtZQ+9eezvpv_HcLWeq1z+PwqQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 01:10:21AM IST, Alexei Starovoitov wrote:
> On Sun, Nov 20, 2022 at 11:10 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > IMO, there are a certain set of properties that check_func_arg_reg_off provides,
> > you could say that if each register type was a class, then the checks there
> > would be what you would do while constructing them on calling:
> >
> > PtrToStack(off, var_off /* can be const or variable */)
> > PtrToMapValue(off, var_off /* can be const or variable */)
> > PtrToBtfId(off /* must be >= 0 */) /* no var_off */
>
> Just to complicate things a bit... ;)
> There was a request to allow var_off in ptr_to_btf_id.
> Sometimes there are fixed size arrays in structs and
> programs need to iterate those arrays in a loop.

Honestly, I don't see why this case needs var_off.
Each iteration will bump the reg->off while indexing into the flex/fixed size
array. Even ptr += scalar where scalar is known will accumulate into reg->off.
But maybe I missed some specific case.

> Another case is to access flex_array at the end of a struct.
> Like cgroup->ancestors[].

This might, but still, to mark the dst_reg as pointer you need to know whether
the possibly variable offset going beyond type->size is 8-byte aligned, right?

Otherwise the best that could be done conservatively is mark_reg_unknown.

> Both are currently impossible, but the verifier has to
> get this capability.

I guess it will be a very involved change. All over the verifier there are
implicit assumptions in places (after certain checks) that PTR_TO_BTF_ID never
has var_off.
