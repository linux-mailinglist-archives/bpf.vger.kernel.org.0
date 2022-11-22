Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B87663422F
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234456AbiKVRHW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 12:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiKVRHQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 12:07:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22CB79913
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 09:07:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EE5E8CE1E13
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 17:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FA1C43470
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 17:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669136832;
        bh=cFg+Ix8hY30rUJ3j51nwQZLgBpY91a5BRFB9zFYjT2A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GLzq7M1xnKrg3WNHE2B787FMaUcaMS14vk8eAjdxA8wl7yU6cUURofmUSQNCrQtqk
         qMJFSNeyY50+7r2MyPiZQA7H8zUPIu+JFiP+0TYfGXEPTJzZqW30iiUMxjRuLFfDiO
         YXSw30l7OWBcepbf65jX+Q/eDmWH4XoyzhcXgjazIZhF7N1B8VhKT2RPCoR2VfeSry
         9Jnt1BtBZg57S7thCESeTZ1SNjYVsQzEJlCgqb5Xp6dsWrl1/uvJFsIOwgEHVNvWIE
         xMilr1c2m64e700o1gPpOEnDrHnJuqon7SNSY1CrorkaS2vkD1i9ND9xdTrHiiPYB7
         6JsDxM7NWKGsg==
Received: by mail-lf1-f45.google.com with SMTP id p8so24466328lfu.11
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 09:07:12 -0800 (PST)
X-Gm-Message-State: ANoB5plUQIxfJqg1ShZe9co1REhtHZL7F76z797VUAdP+S6tiIQJ03WD
        b5Ab7JDzkCsoZHoQUhJ24BmTjysvQCDnzFKEUMzLHw==
X-Google-Smtp-Source: AA0mqf6SiK7WkZcR8wmGUfroZd88xTkJlFtD61qmghQn2ID3yWUOiJYz4LTzhSvX3HfKQOAIBHFlFv/v8ISdOLjlZKY=
X-Received: by 2002:a05:6512:3416:b0:498:f589:c1b3 with SMTP id
 i22-20020a056512341600b00498f589c1b3mr2926461lfr.406.1669136830097; Tue, 22
 Nov 2022 09:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20221121170515.1193967-1-yhs@fb.com> <20221121170525.1196049-1-yhs@fb.com>
In-Reply-To: <20221121170525.1196049-1-yhs@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 22 Nov 2022 18:06:59 +0100
X-Gmail-Original-Message-ID: <CACYkzJ6RVoc_F2xpZF7C=HcQASnBwh-R3EhH2k1QrC2jaMCU2w@mail.gmail.com>
Message-ID: <CACYkzJ6RVoc_F2xpZF7C=HcQASnBwh-R3EhH2k1QrC2jaMCU2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/4] bpf: Abstract out functions to check
 sleepable helpers
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 6:05 PM Yonghong Song <yhs@fb.com> wrote:
>
> Abstract out two functions to check whether a particular helper
> is sleepable or not for bpf_lsm and bpf_trace. These two
> functions will be used later to check whether a helper is
> sleepable or not in verifier. There is no functionality
> change.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: KP Singh <kpsingh@kernel.org>
