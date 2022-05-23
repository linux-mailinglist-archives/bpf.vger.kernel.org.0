Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8F530733
	for <lists+bpf@lfdr.de>; Mon, 23 May 2022 03:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351878AbiEWBkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 May 2022 21:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349081AbiEWBkO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 May 2022 21:40:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD02FE60
        for <bpf@vger.kernel.org>; Sun, 22 May 2022 18:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8EC9B80E8C
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 01:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCA3C385B8
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653270010;
        bh=5JeWuwjQW7xr/qkbQaD/3uau65ZZ/ngwMP47lMW7Jvo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jm5q6GjK3jpPgk4onSGCKNR2oqgAqJhBAlrAhMjc+RanBPhEFEQGrJafWhYJaGrhR
         9/PVLLg6dtnFafUMRwtHtzDLXVcUiwYux2y11qDNRjgaXe6pNftzIOB4b7+5i2737N
         UoYIdVjTd9+AR4jcaRo9if4eUzfh3xX3SImiVFmevjnsLYeaZ/XdNx2VjC4F4G6fZL
         KjgfgWX6l5vVrgThZ2XoMUWFhfxenTvHNGh2tjGSctOlUqGUzK062qrt5zRTQKtbba
         8oQp8meDDw7rMcTOFvCrPevcrdpvpFQpUw7uZAWr/y3ILoBCCMr+7UeDthTTTcfWAy
         QJ3YQkDo/q0tQ==
Received: by mail-lf1-f42.google.com with SMTP id p22so23074104lfo.10
        for <bpf@vger.kernel.org>; Sun, 22 May 2022 18:40:10 -0700 (PDT)
X-Gm-Message-State: AOAM533osre8JKnfMaM6IYjNztNsdICwmEVBT/2KnyIK6dsr+WZ/jlPW
        SysBPqg8eqQkBDrEiayVJmsznfOnzVCcC/LfLhJpmw==
X-Google-Smtp-Source: ABdhPJxmuAT2uoIVA13vw5iZhn4vJIM5zmSioEz4qbTJnHoc456EmfCoOhbAoNsxZbATqZraLBzH60m/6MHzCKaFZhM=
X-Received: by 2002:a05:6512:2347:b0:478:5a69:6dc4 with SMTP id
 p7-20020a056512234700b004785a696dc4mr8785670lfu.478.1653270008538; Sun, 22
 May 2022 18:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220518131638.3401509-1-xukuohai@huawei.com> <20220518131638.3401509-2-xukuohai@huawei.com>
In-Reply-To: <20220518131638.3401509-2-xukuohai@huawei.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 23 May 2022 03:39:57 +0200
X-Gmail-Original-Message-ID: <CACYkzJ4aetRT0SuF3Kh5MOMw3y_AQP8qNoDxFdz_0hypQ6H10w@mail.gmail.com>
Message-ID: <CACYkzJ4aetRT0SuF3Kh5MOMw3y_AQP8qNoDxFdz_0hypQ6H10w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/6] arm64: ftrace: Add ftrace direct call support
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Shuah Khan <shuah@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Steven Price <steven.price@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Mark Brown <broonie@kernel.org>,
        Delyan Kratunov <delyank@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 18, 2022 at 3:53 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>
> Add ftrace direct support for arm64.
>
> 1. When there is custom trampoline only, replace the fentry nop to a
>    jump instruction that jumps directly to the custom trampoline.
>
> 2. When ftrace trampoline and custom trampoline coexist, jump from
>    fentry to ftrace trampoline first, then jump to custom trampoline
>    when ftrace trampoline exits. The current unused register
>    pt_regs->orig_x0 is used as an intermediary for jumping from ftrace
>    trampoline to custom trampoline.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> Acked-by: Song Liu <songliubraving@fb.com>

Acked-by: KP Singh <kpsingh@kernel.org>
