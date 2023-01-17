Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061E466E432
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 17:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjAQQ5G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 11:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjAQQ5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 11:57:04 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDA243927
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 08:57:02 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kt14so17921849ejc.3
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IPm/BIeaIWSRdXh/u12PLRiz3RrXhk1IKiT2QoIsSj0=;
        b=hOUcZAZvLh7a5kYi39vbRDoodbYGpQbXEGOaxTONUnVgrSCb6yQNkuHygs3mUgESFJ
         juXS9X2PRgVI8BAysSnJwo8qPv6Q9ewiF0gHYVLqpASO+OHPQMDYszBUnjWahQY7wpT4
         3b0tOxkFzpYrBPnt4v40JU4oBnI4dsdwGYIu882rtOvP8vRQovKUfVqrP032Iw7xlicx
         taxRCcW+ZZm4OSUQ+eENrMbrXiT1IY6ALUB5rKXaOhPSZPobtlQD7Uxzg2044tsL4eig
         0k3YyzKyI+3DBuitTlpEUBcxrH4UK5exOhUxneFKE2RJi920IwW6hsusZLcvdRQN1YUW
         b5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPm/BIeaIWSRdXh/u12PLRiz3RrXhk1IKiT2QoIsSj0=;
        b=bau6B19uGK2hZ3SLyc1dgcJjabf9cp/MO9DQUDiHQZ8Ov8xC9fE9NuGxwANbK4Cgyr
         IBcp0xFzrW20gEbQ06W8WgszI6r6Pe3WfQvWfU7zHlcbjTQxT2BvQfCxBbN0leiO8VZS
         h0p98Yc5uytuHCAfQvj4dSsKPp2HvYD+7bC9ihv21lOHftQ+M6r31qkMhOCMggOukxMw
         5HlsBSvJRSXZU1nse7t+lu2TvpCo6AQ4CgRtGSZp0zI//hwaUrqTWEX7G/+NhbJDhGFS
         4FcawgnExkN0JYKDXxhVp6Z4eGYO9LEpC4RSkxw/n1kEtY3AxUWaVRRCLTVHnR414j7y
         pGTg==
X-Gm-Message-State: AFqh2kphQ00OqEgj+ORseBbEr0MXX6QFYnm5Qqjh29RZPSBqhue3R669
        MmNeCnfcHyVY7nUOEH81S/XCaQYootIdafp+TLs=
X-Google-Smtp-Source: AMrXdXuyOhZO3nqxOsxCR3dOQMli1bjLHsVfgk1taz2dk9lLFgCfEKVoziRzJbQJjIumEhvAPxXFVlHLyIK/bzSwNyQ=
X-Received: by 2002:a17:906:4a8f:b0:86c:e07a:3ce2 with SMTP id
 x15-20020a1709064a8f00b0086ce07a3ce2mr229630eju.58.1673974621303; Tue, 17 Jan
 2023 08:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-3-davemarchevsky@fb.com> <20221229035600.m43ayhidfisbl4sq@MacBook-Pro-6.local>
 <9763aed7-0284-e400-b4dc-ed01718d8e1e@meta.com>
In-Reply-To: <9763aed7-0284-e400-b4dc-ed01718d8e1e@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 17 Jan 2023 08:56:50 -0800
Message-ID: <CAADnVQLRNxCn33jtXTYeNzNNNFZDn3k+DKk_o_iJxCsUvxeQmQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: Migrate release_on_unlock logic to
 non-owning ref semantics
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
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

On Tue, Jan 17, 2023 at 8:07 AM Dave Marchevsky <davemarchevsky@meta.com> wrote:
>
> How about I try to make the names better in v3 instead of removing the kfunc
> flags entirely? If you're still opposed after that, I will instead add helpers
> with comments like:

Please review what I did with this patch:
https://patchwork.kernel.org/project/netdevbpf/patch/20221230010738.45277-1-alexei.starovoitov@gmail.com/
