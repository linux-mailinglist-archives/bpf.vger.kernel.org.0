Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766605FF497
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 22:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiJNUd1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 16:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiJNUd0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 16:33:26 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AFE1D2F59
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 13:33:23 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 3so6072500vsh.5
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 13:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmHmqpLWIpu/f8Gu0TCJWnlhc6RbUwzVVDCHsMl7wmE=;
        b=RcxQ/3mKLkMqDDoFj1rdY9ytj1vzLxiqjGMWJu6YFvE8vSr1c+7Zu4AvMbMAlwlTz6
         /fA2mTwQzTn4lFbBs1HMIj/veJOVW4vVKxuEbefnPVMZVav0/VAukwvPS1QqQQBu+rjY
         e8XezgkerfOGNrVEG/dmK8++/VXxkwmcr25XQAuaOtDE9tte0ey3lw6c7IWho2p/SPmS
         JK+EQL4Bw+sjpRaWHmqxbkmtiIN1F+2QU+atRTaf06RbB/5fLhz5SwqaOM90XOKKKCwG
         UTj+5QNTwsd2QZsHj+Z5Ec0X7xqVz5AhXw4O9+pA6Wfs+Ggx2jFwAZruDPl4q6I/kYzF
         fyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmHmqpLWIpu/f8Gu0TCJWnlhc6RbUwzVVDCHsMl7wmE=;
        b=sNF+GC0XS9y11JzrVKTUAhv3G8HqPaMtCxOXa/pkWKC+MjlAStRyxQwPN3GKWvXIrD
         MK57wz4X+5KpWmy2Ueg9aiA5oLKBJByOeLi85XyI5tdib/0YEnxpx+HfKMGESlF6Bl1e
         J3WjhTXsTzCq/jqx4MHiIuQzRk0tf4NLJBzv6dWLBIAX1bi90W9jBJMva6QSF2LrRLpf
         JtrSRlZSpbTFhXsQBX6y+tSTGOGjs4GpFg50yZh9fTM1CqaazXgCO3E0A1Aul9F1p92b
         p1lCuIXx/Vy3LLUXlqKsGPYkp4id65ymLdlz6uXU0v9K5SnYNBrAXv/pfOkCtiAvXRV+
         RT0g==
X-Gm-Message-State: ACrzQf0r9TyfJZ4blnSr+TGsG0Ngnjei8v7eMkPJKpBQ8twG0qpJ/vjJ
        0DBCVHVtpfy+xAgIl32AznK6epjJpDCdNdxKvmQSig==
X-Google-Smtp-Source: AMsMyM7eMoUFojXZujKfXJe/UVIqcF7hPQK4gJsnCI3O8tMQ2WFm9k6RLLZTN4nce66oOQvrsAVDmvLlaiAoFTJuwv0=
X-Received: by 2002:a05:6102:c88:b0:3a7:868b:5637 with SMTP id
 f8-20020a0561020c8800b003a7868b5637mr3733051vst.23.1665779602056; Fri, 14 Oct
 2022 13:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220927182345.149171-1-pnaduthota@google.com>
 <20220927182345.149171-2-pnaduthota@google.com> <d6f272a6-020e-6a46-d86a-72c2dcc15264@linux.dev>
 <CAEf4BzZC553QJNVuTxLGWDcvoo8y5iwqXrjdjG2R-OTo+QWddA@mail.gmail.com>
In-Reply-To: <CAEf4BzZC553QJNVuTxLGWDcvoo8y5iwqXrjdjG2R-OTo+QWddA@mail.gmail.com>
From:   Pramukh Naduthota <pnaduthota@google.com>
Date:   Fri, 14 Oct 2022 13:32:56 -0700
Message-ID: <CAEeqUsosyq+HTWx26eZjfuDdomgpekxd1Ur+pfmAuGQk2EHU4Q@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] Ignore RDONLY_PROG for devmaps in libbpf to allow
 re-loading of pinned devmaps
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Do you have any more thoughts on this?
For my 2c:

- It looks like the kernel is making the map BPF_F_RDONLY_PROG because
  "Lookup returns a pointer straight to dev->ifindex", so I don't know
if we have to
  worry about the kernel allowing write access to devmaps

- I like having the guardrails in libbpf, but I'm not sure what the
exact contract
  is for what libbpf will let me reload

I'll spin out a V2 similar to what I had if nobody has any strong opinions on
the exact behavior of this check

- Pramukh
