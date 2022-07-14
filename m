Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDDC57579B
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 00:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiGNW0l (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 18:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238023AbiGNW0k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 18:26:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9037D71BD9;
        Thu, 14 Jul 2022 15:26:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r14so4415586wrg.1;
        Thu, 14 Jul 2022 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:date:message-id:references
         :user-agent:mime-version;
        bh=H/Jj7pZPPGF1xEq9pAXzJYyU1Miyhpi/aiyDdUK3nCg=;
        b=h/NYKrymZ/S05urtQyPWtoVbWeg7qcVUjzj90pe9QPU980mDqCR7Go7CxuaF34E/jn
         i7Z1Q6LROT46LN5AnN652dF6EJh/plA9z38raD9FKK6Ls2mXbuBQOIWCeM1zOUAv/mI0
         Ix5+/SX1VMCqxFXTj7XeItXEY9gvzjbgvXgnxhC8yYfys3mdNKwq5YsPwftorOmOES8K
         HGfaiVD8Fixbf9uaQfk9RHfplgL4+mWqr7eBjvj1diqNRE7P9BXdqqgih9rZhHIzkg7y
         b0mSGmYVR/CmWijsdIn1gjJPsCMFzf9L6DTF3Jsiyq567yxxsR1dHVfwiOlDnh/hY+WJ
         FjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:message-id
         :references:user-agent:mime-version;
        bh=H/Jj7pZPPGF1xEq9pAXzJYyU1Miyhpi/aiyDdUK3nCg=;
        b=ITqkEOHTeyusGgRisbaW4c6OukuhYMInn9+GBkXFtQbopkh9nYORTgYys8TQ1XwVX+
         0+zMw6OSUR0lqzZnplwpWlmZ5kWRxM0JZO74cYOypS3crjjnjQecd+LDWbnEzfHOiZUy
         dttDn+TUEb4kdy97os6xKNgDdZ5y6zmaSarsjVLBaaubNLwma9eimG5BR9U6p0+pYvLp
         8yUxopf/o6aK+A+2ry/09i4GslugWfk05P8DnuehqeRN0Zv6JTkEwGW8gDhN17XU8TB8
         7tjtZPv13lvZo7ERUt6qp8wRTDK1sqFP81p5RnkzVdEpQTxKMC0OOVIhvzvCIX2J62JB
         GtcA==
X-Gm-Message-State: AJIora9usXLr64Hf1/1dlgabEy6sS6PaOpLHUMEp6vBASA08Y1nQEfCT
        wfDx+r1Sm7wNH0QPQ0pNxcY=
X-Google-Smtp-Source: AGRyM1uICzbizyCz4pfVRHt9cE3HmtPYtDbrO4idqAXHmn/LTI43YJyNnklf2Fb8Tt94b5zCd00Xpw==
X-Received: by 2002:adf:e187:0:b0:21d:64c6:74f0 with SMTP id az7-20020adfe187000000b0021d64c674f0mr9615376wrb.221.1657837598021;
        Thu, 14 Jul 2022 15:26:38 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:7cd7:ddd5:b3c7:3e26])
        by smtp.gmail.com with ESMTPSA id m185-20020a1c26c2000000b003a302fb9df7sm2850707wmm.21.2022.07.14.15.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 15:26:37 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] bpf, docs: document BPF_MAP_TYPE_HASH and variants
In-Reply-To: <5fd3bc40-61f5-e7bc-6178-cb50b3af4042@gmail.com> (Bagas Sanjaya's
        message of "Thu, 14 Jul 2022 15:10:56 +0700")
Date:   Thu, 14 Jul 2022 22:53:13 +0100
Message-ID: <m235f34b06.fsf@gmail.com>
References: <20220713211612.84782-1-donald.hunter@gmail.com>
        <99351eee-17b4-66e0-1b9e-7f798756780a@gmail.com>
        <20220714055137.dsatpuyrwdlel2ck@vaio>
        <5fd3bc40-61f5-e7bc-6178-cb50b3af4042@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:
>
> From Documentation/process/submitting-patches.rst:
>
>> Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
>> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
>> to do frotz", as if you are giving orders to the codebase to change
>> its behaviour.
>
> The recommendation above is from commit 74a475acea4945
> ("SubmittingPatches: add style recommendation to use imperative descriptions")
>
> Thanks.

Thanks for the pointer. I will follow this guidance for v2.

Donald.
