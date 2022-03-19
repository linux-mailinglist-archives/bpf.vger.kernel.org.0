Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD9A4DEA17
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 19:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiCSS3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 14:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243900AbiCSS3i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 14:29:38 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5941010
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:28:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v4so9941974pjh.2
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+To/R+NnVFAU/xAg5Xct/HTY5anwcz9uD3bLfRK2LNU=;
        b=k8/V6s1CP93NGIQq7q6r7fxAIaCPWIuyJm6w40oxdXOooojDgegmn/KM4mwZdwT89Z
         NBy90xAVzC34IUoEm9bzzvk8J1q/ZGuL6UqlLrIOd3SNum9GeCo4D+LG2a0cqR33uSif
         d9S02Y3xfnXSKHgC+eCGnJLI2Wdw2TcS7lILhod2N+MjBlb9BjOQMgJCpWDt6eg7GGan
         7pVtUKqOdTqP4FIhA2sxfTUep8K4pdkislNbGzIqzfPa4P+FnYew7o1YlEGQKrcYtY0G
         ePbxLlnapspFMAFmfOs6LqaJKFxeO5OpTdjNVWsTwhP01v32vjsK1qWBexugI3kGG0Jj
         S32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+To/R+NnVFAU/xAg5Xct/HTY5anwcz9uD3bLfRK2LNU=;
        b=yWTM5/K77pHRnrV69xO1bPcJo3c/pVt9dEQNHbE5LgnBw+7Dv/JSqjXd+jbIN9Q3ps
         o+Uhl0MO/TQPaSH8OoV81h1GiudL9aiO2fyDY4aIk5XmPmUUIKy8DNesomXNAS6DCUGn
         5xTo22Ymqc6Ue8Y076OplacwszHzohxTsno/DxmKWUoCb5SJJGjUYHTDq7nVLK/438gc
         ozeF4D90oJHleQTnYQHruFT6kO2XcE3azWrqgpr55uauShbrcp56QqqXceCSUsTId/Os
         j4YD+mzUc3kpHTDFs1RP1pBKNQ37YCs4p20bVAkTENnt4Jqj6gSrOtOpG293nX8szz6R
         a5BQ==
X-Gm-Message-State: AOAM532AvHYtkwba030lTT/y4Z6oyCw6+4mt3aAkANGvOijiizpiV818
        5Sm+GnjHEkCbZgnolz3qBZ0=
X-Google-Smtp-Source: ABdhPJzWDJQk+vavXGTQZ5PJx/pq6LG0wSJznUPF02xreqQqYAVpbyLaEvMiy+7hmJj9cuxg9pVQcw==
X-Received: by 2002:a17:902:8d8f:b0:153:6546:2530 with SMTP id v15-20020a1709028d8f00b0015365462530mr5326400plo.81.1647714496401;
        Sat, 19 Mar 2022 11:28:16 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:a65d])
        by smtp.gmail.com with ESMTPSA id j6-20020a63b606000000b003808b0ea96fsm9893875pgf.66.2022.03.19.11.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:28:16 -0700 (PDT)
Date:   Sat, 19 Mar 2022 11:28:13 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 06/15] bpf: Allow storing user kptr in map
Message-ID: <20220319182813.issitd7s3c5b6qw3@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-7-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317115957.3193097-7-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 17, 2022 at 05:29:48PM +0530, Kumar Kartikeya Dwivedi wrote:
> Recently, verifier gained __user annotation support [0] where it
> prevents BPF program from normally derefering user memory pointer in the
> kernel, and instead requires use of bpf_probe_read_user. We can allow
> the user to also store these pointers in BPF maps, with the logic that
> whenever user loads it from the BPF map, it gets marked as MEM_USER. The
> tag 'kptr_user' is used to tag such pointers.
> 
>   [0]: https://lore.kernel.org/bpf/20220127154555.650886-1-yhs@fb.com
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf.h   |  1 +
>  kernel/bpf/btf.c      | 13 ++++++++++---
>  kernel/bpf/verifier.c | 15 ++++++++++++---
>  3 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 433f5cb161cf..989f47334215 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -163,6 +163,7 @@ enum {
>  enum {
>  	BPF_MAP_VALUE_OFF_F_REF    = (1U << 0),
>  	BPF_MAP_VALUE_OFF_F_PERCPU = (1U << 1),
> +	BPF_MAP_VALUE_OFF_F_USER   = (1U << 2),
...
> +		} else if (!strcmp("kptr_user", __btf_name_by_offset(btf, t->name_off))) {

I don't see a use case where __user pointer would need to be stored into a map.
That pointer is valid in the user task context.
When bpf prog has such pointer it can read user mem through it,
but storing it for later makes little sense. The user context will certainly change.
Reading it later from the map is more or less reading random number.
Lets drop this patch until real use case arises.
