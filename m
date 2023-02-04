Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB668A804
	for <lists+bpf@lfdr.de>; Sat,  4 Feb 2023 04:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbjBDDrx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 22:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBDDrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 22:47:53 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E9F1C7EB
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 19:47:52 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id bd15so5042308pfb.8
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 19:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/oPdpjCXEICi0WB7qYNWjYe48S0NxtEX7NoBl8nlPs=;
        b=X0K1IuuO2V67IUIqK+OnHMr/N2OM1k0AQL8rRzI2HNm8qhLFv9Sl72iLVyer5PklnM
         GVfS8raikJ/XH2n34fLxUdm04BGyZKnOdlk0HScXwZwTMgbF2Rl1MaMDMI+Im3E0TOOR
         0+sbo5GHB846vSd9UygAyo9TrX2hbHjL5UMuPRg8zwEC56fRHIrHQNMbCAdrcjYW2rEa
         UHTwukvhDY+dmvkn5U68Iu5RJyGNbzgkPU4TwwgEyzncJAkooqpJv1kHu6FK2hxioKup
         PIGGAg3cBR84aj6Xl1BkC65YlXD62y0eviht6mugNBaoBkdcgRf+wLJk73SWGmRQJa6S
         bULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7/oPdpjCXEICi0WB7qYNWjYe48S0NxtEX7NoBl8nlPs=;
        b=tLjqYBHcu9T7e+L8JSIQmNKDi5PDGXKrRKU3fQfMov1lBsz4rUNyFcLji7MPK2JuDh
         woJlJGbkSHaC/BJkxPKq5ECgQZJ26/Hf5pZZ5Ske00sw/y6TI2xl/GfnCBlt3sJNU9g7
         xMlILEsLhtmpQQGxw0a4+SRbT3kpa/c7exK868TkLnysHvXYY6/EpqOI5Guu3mtWhdUs
         9L9hwzZbOXKMkSsDQdWDBatLmEpu7A9aKETQabKmsgsFReY13+o65odpFeWCJYkIhOHb
         xg2vYEN863cwpLb/+fZZXwwxkkuPdnMXZGjI9pHcIXrRNJGDvheTruQt3fAhNZQA32a3
         mmoQ==
X-Gm-Message-State: AO0yUKUmAQodg215u9dVXYzd5omrfjVCWCBylCguiv8cSd5e3uZnFiE7
        v8t1pn5fGmLL1piluMtwMYg=
X-Google-Smtp-Source: AK7set+dxM+rqI6RQF+VKLQ1oGHl6cwft1lfswmvq89rAIlxVmeEgQ7hRrdEAYRL+8gL8s80xw5mcw==
X-Received: by 2002:a05:6a00:21d1:b0:58b:ca43:9c05 with SMTP id t17-20020a056a0021d100b0058bca439c05mr14215338pfj.16.1675482471826;
        Fri, 03 Feb 2023 19:47:51 -0800 (PST)
Received: from localhost ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id a77-20020a621a50000000b0058e12658485sm2679453pfa.94.2023.02.03.19.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 19:47:51 -0800 (PST)
Date:   Fri, 03 Feb 2023 19:47:47 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     tong@infragraf.org, bpf@vger.kernel.org
Cc:     Tonghao Zhang <tong@infragraf.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Message-ID: <63ddd56327756_6bb1520881@john.notmuch>
In-Reply-To: <20230203133220.48919-1-tong@infragraf.org>
References: <20230203133220.48919-1-tong@infragraf.org>
Subject: RE: [bpf-next v1] bpf: introduce stats update helper
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

tong@ wrote:
> From: Tonghao Zhang <tong@infragraf.org>
> 
> This patch introduce a stats update helper to simplify codes.
> 
> Signed-off-by: Tonghao Zhang <tong@infragraf.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Hou Tao <houtao1@huawei.com>
> ---
>  include/linux/filter.h  | 22 +++++++++++++++-------
>  kernel/bpf/trampoline.c | 10 +---------
>  2 files changed, 16 insertions(+), 16 deletions(-)

Seems fine but I'm not sure it makes much difference. I guess see if
Daniel, Andrii or Alexei want to take it or just drop it as random
code churn.

Acked-by: John Fastabend <john.fastabend@gmail.com>
