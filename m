Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CF16A2B9D
	for <lists+bpf@lfdr.de>; Sat, 25 Feb 2023 21:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBYUHK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Feb 2023 15:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBYUHK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Feb 2023 15:07:10 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D1016316
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 12:07:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n6so1539899plf.5
        for <bpf@vger.kernel.org>; Sat, 25 Feb 2023 12:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZRUV5AZ5/dRt8bVgigafy3WUHI2STOba5Tb0L7G2BkY=;
        b=dKbZm6vOy+t3sKqkfiWhzQN6voynd2qcyz9ZGtOhDgVOoy1mXB9Mu/JYjouQ/yMAhT
         brA0WxJ/QlA267Q57+kLxLrkUyeBmqVTAH7HxsMt++QS8xdG9CfoCxj6SggC4IKIDCeY
         asbQvcDp97yL/0fETeDPGP8qnzc8zd9Fqav5/E1xK6IFlr/yoU20/TE0zYKgc0KEZPsL
         Fnps6wH9fKz+uLQCN+6Bv5+x4PgSIudNZFn3OlnnwULuMYr/8uqSnzyKfrNNz6LqZunc
         K+zx4cq83onsrfhq7nhthouupLLxF0k2chodiJ/6OGqfOWeNt66MBeGpBMwDwvwSNqsW
         p6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRUV5AZ5/dRt8bVgigafy3WUHI2STOba5Tb0L7G2BkY=;
        b=6m+kzE+bf7OujcH9zjwfPeJOnJ1CvqwUtm8gWTfM0Ad0nhhRavBvb/0hRMcu5UZ/q0
         P7xGWbqu2Weup8XedITU7vsMz5TNsDoMwenUIXigmf4RIRGONtKJEv+ncsc3x6Cgt23v
         4X6IT+XPOaC0FlzZfvEiac4YstuVtWzlC+k3LKVjA3hOKgVuDtVLYtT5oC+aBX2JHY1h
         UNbSqsMBYu7z1n9P1v7LObV11eCvKA3a3L1Yh/1q60jzQQzf+BIExNoEUoyiNLUFnr4g
         VUpM9Tkf9OwXMqbkuoaNiJ5qsnWlc3Zn6d0gJyYzdm4zIz9suCXhRuMp1Aj7t9XkhB9f
         ufjQ==
X-Gm-Message-State: AO0yUKW7YOC0DFcJ2EoDoZi/6pft39UUgrtQ4XOJhHkaVKq/q2mw2pDX
        UzwxkzyGWdPURwGqzh05u+7hUDQV8yvbpMRYV2nivg==
X-Google-Smtp-Source: AK7set+TAltQyoKadENnB5ypmLp7xOFzYfXhNKLKcmVeVwHUhrSjj7PHriZ4kcg0m2cog5MCl7oy3JTUFp5qe7B+ucc=
X-Received: by 2002:a17:903:4289:b0:19a:9984:558c with SMTP id
 ju9-20020a170903428900b0019a9984558cmr4466320plb.6.1677355627525; Sat, 25 Feb
 2023 12:07:07 -0800 (PST)
MIME-Version: 1.0
From:   Hao Luo <haoluo@google.com>
Date:   Sat, 25 Feb 2023 12:06:56 -0800
Message-ID: <CA+khW7g9_71V=k1hTEghBrBUOWMmerD=mByUK+On-ZiwTR023g@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Debugging kernel lock performance using BPF
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        David Vernet <void@manifault.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
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

Debugging kernel performance bugs is usually a hard task. In this
talk, I would like to share my recent experience of using BPF to debug
a performance regression caused by kernel lock contentions. I am going
to introduce the BPF programs that I used to successfully root cause a
regression of kernel operation latencies that only occurs in our
production environment. Traditional profiling and monitoring tools
fail to capture relevant information for me to debug this issue, but
BPF tracing programs provide a sufficient set of facilities that turn
out to be very helpful. They are made possible by the modern BPF
features, including:

 - Lock contention tracepoints [1]
 - BPF timer [2]
 - CO-RE kernel type matching APIs [3]
 - BPF static linking [4]

Looking forward, as we will see more heterogeneous platforms,
profiling kernel synchronization performances and gaining better
understanding are going to become more important nowadays. From my
experience, I would like to open discussions for support of better
observability of kernel performances, including getting full lock
owner information [5] and more reliably getting Build ID stacktraces
[6].

[1] https://lore.kernel.org/bpf/20220322185709.141236-1-namhyung@kernel.org/
[2] https://lwn.net/Articles/862136/
[3] https://lwn.net/Articles/898839/
[4] https://lwn.net/Articles/848997/
[5] https://lore.kernel.org/lkml/20230207002403.63590-1-namhyung@kernel.org/
[6] https://lore.kernel.org/bpf/Y9vX49CtDzyg3B%2F8@krava/T/
