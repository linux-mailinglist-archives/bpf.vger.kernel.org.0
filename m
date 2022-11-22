Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48712634A2E
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 23:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiKVWoR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 17:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiKVWoQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 17:44:16 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A48B97C1;
        Tue, 22 Nov 2022 14:44:14 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f3so15284125pgc.2;
        Tue, 22 Nov 2022 14:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7QwrVpaHP+ARj4TelpCmRFDWtNrt1GA5zbr41rCHDo=;
        b=OeCkJ5JDqe9091oZ+PsiWtr5DntRwkyWH1UKBvVVwBeg4eoxfPKLnk1PBieGZ0vRRM
         2j0tZIMN1oXSXfp9+oqtdr+F9PJcbeTBy/8HNPQCyhoySu66QlGmSQg19YRni39q/jJr
         CncshkdAjwTvp81VdLBIED5iiePstDrp9PfhYSMovs1f3L1swkJWF5DZvC2bbdUYePjU
         QorfPjNlCBrQKkyRbHznWdnVzpcDsL9moeAgDG9NIPUa/iHk8ivJWTY/zdZrH2iK4cs3
         yvwLVrztkZJrm70W3guQv9VYeSjqgUGxOKEWz0Xm+BQxw+gG7jMqeWdYfCLsvfxvQJw1
         gEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7QwrVpaHP+ARj4TelpCmRFDWtNrt1GA5zbr41rCHDo=;
        b=NvnIIjFoF5Yvgg1uv+f9odDYvraztUsthMfjdVvpX6fwDdFE+6syVTIZ5AzZWIyEVt
         9H62sDylJLmVgbA3t2KSd0Og2riCR/p2/jG84b/UiCDcuOSQ35jBPdieAo5BHx09p8VE
         HZQrIEmXM3uKqa1y1+sL3e1CY9gz/n+k9r5sDF1OVOvmkd+a0+BNhUpPK/GwG0F/ZViI
         s4hxndaPTVd6xxoB0maQC82+/Rl+ZpIJu+Wxa9Ohp1DYm9cerV3q38nTycfWiyKzgpin
         RrUok4BPvV9JKoivvecNm8EE+WLCFTb3vF9btkBPsNbdYBja7kG04GyXTCioaL4b8sg5
         KnLw==
X-Gm-Message-State: ANoB5pk/Radz4z/OV87pHaHlkY7278rsxByE6zYX94R0nV3qVxbW9S0C
        Eu8ZmywlPIDySiOeJmSsfjo=
X-Google-Smtp-Source: AA0mqf46U0ekKGfqGRyjktGmlBF2/+vH7FzAXfBD71SUaspKv4p6zLuYGeVvzZ0fWGPJ+aZ5zw9zgQ==
X-Received: by 2002:a62:1812:0:b0:56c:afe:e8bf with SMTP id 18-20020a621812000000b0056c0afee8bfmr6100174pfy.51.1669157054025;
        Tue, 22 Nov 2022 14:44:14 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:bb3])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b00172e19c2fa9sm11998309plf.9.2022.11.22.14.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 14:44:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Nov 2022 12:44:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, yhs@fb.com,
        song@kernel.org, sdf@google.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, haoluo@google.com,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/4] Support storing struct cgroup * objects as
 kptrs
Message-ID: <Y31QvDkccnIosZCP@slm.duckdns.org>
References: <20221122055458.173143-1-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122055458.173143-1-void@manifault.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 11:54:54PM -0600, David Vernet wrote:
> In [0], we added support for storing struct task_struct * objects as
> kptrs. This patch set extends this effort to also include storing struct
> cgroup * object as kptrs.
> 
> As with tasks, there are many possible use cases for storing cgroups in
> maps. During tracing, for example, it could be useful to query cgroup
> statistics such as PSI averages, or tracking which tasks are migrating
> to and from the cgroup.
> 
> [0]: https://lore.kernel.org/all/20221120051004.3605026-1-void@manifault.com/
> 
> David Vernet (4):
>   bpf: Enable cgroups to be used as kptrs
>   selftests/bpf: Add cgroup kfunc / kptr selftests
>   bpf: Add bpf_cgroup_ancestor() kfunc
>   selftests/bpf: Add selftests for bpf_cgroup_ancestor() kfunc

From cgroup POV:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
