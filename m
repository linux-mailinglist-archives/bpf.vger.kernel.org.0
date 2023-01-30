Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D69E681BA5
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 21:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjA3UjP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 15:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjA3UjO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 15:39:14 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381583C2AB
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 12:39:14 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id d10so5655994ilc.12
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 12:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0nT5TiK59F4dVt37DfJK9Bll0YITX9f8CMHepmR7VeE=;
        b=IZa9mIFHrck31VCRcZzKJUjsd9OFmNO4Y4EijYb5f0CdfBrfaEIeXC6NTe2IeuuLLt
         nhiqU295YFwVM+//XpPJ7LwmcaouKBploPXztnZzseuPu7qJR8gcKItfP41DBUjvG1Mn
         +72lxpmvjBxRPBTGQ//8/6HvCd1HxxqAkHkauR2YuCVZIxnWgv7T0ibGWO829JuObZPO
         VOTXCFGgCMdx/MK8z81NV1o3ziHLiwbpr2bQYwMTDcT9VP4sMCK6AzYCwbnb8ejfAI1x
         mCduhZnM+ZFUhtqO61WTfMPyGyz/2DnIkd9Ez8OvRPCInb+X8GkZkDcLDL89OxCSEmbi
         /sHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nT5TiK59F4dVt37DfJK9Bll0YITX9f8CMHepmR7VeE=;
        b=kWWcW5/dJ8xId4SvcjyCrodKjsC2koaCTHOqCELiro3C0a7oNFJGHSHvR3aFC4KwUc
         qP8nAPYUD+U6IV8yfrSPFBU8907uqKR+mF8fBrQsQhpcOsaXVw0Xfx4w3nOCZyOVYYzk
         pq5dlpbhC5N7ZhOeSDcoOYJsvAw704eftniigVfKJ5cwI6U2w2lTRg980LJmuQ4sNjkq
         glIUdbG5S+TteLqQKoRGYGS5A9qIAvGduCGU0yBKBjYGkpIVsUmteBeoDF59A8YPLZgn
         YQ5d3vhUidVMrWNl3I/gI+hbOPA0W0nej24AwQgO2nxH6c4jQYGFAsanDYqnb4gFlaax
         kHNg==
X-Gm-Message-State: AFqh2kqU2KySyY0qmFX4A0jHRVVqITSpdwLA5d5t4QgSJGpOv6js0PPy
        WFUYlwV1sXYZ6tJA1F0bHpETHP+hLYWXmnSaXEg=
X-Google-Smtp-Source: AMrXdXs+Qf8qFByKg4v0vZKBNSzUgOWmdQ3Uz0NCQrHvExt8s7Q2At+X5yRgkE/+cvtV5q4+inZXb49YjtpCzN/thcc=
X-Received: by 2002:a05:6e02:1a01:b0:30f:299f:9120 with SMTP id
 s1-20020a056e021a0100b0030f299f9120mr5964454ild.4.1675111153594; Mon, 30 Jan
 2023 12:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20230127214353.628551-1-grantseltzer@gmail.com> <202301281621.DfTZgf4X-lkp@intel.com>
In-Reply-To: <202301281621.DfTZgf4X-lkp@intel.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 30 Jan 2023 15:39:02 -0500
Message-ID: <CAO658oVzcmr5cm-Re2amK0C=EQMweXLcPMA7cUUfJqJ++=tYWw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Add support for tracing programs in BPF_PROG_RUN
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I see I left in a couple of unused variables, but I'm now questioning
their purpose. KP, as the original author, can you explain the purpose
of the `bpf_modify_return_test`? Since this function is running in the
context of the bpf syscall and not the bpf program itself, how would
the side effect of the addition operation (I guess simulating the
attached function running) ever not happen? If we adopt actually
running the BPF program, should there just be a check for setting the
upper 16 bits to represent 'side effects'?
