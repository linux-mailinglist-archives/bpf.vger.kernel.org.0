Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742B4616D21
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 19:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiKBStI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 14:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKBSso (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 14:48:44 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB08F31216
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 11:48:13 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h206so12312422iof.10
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 11:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V3iH6kltXbn8DPbJp+/IxLmJXJxqLstc5tLD9AXFX2A=;
        b=fp1z4Ve8HlaIUkOCymKtX9XryLF7bC+TBx+ZYubac6gbAMlw+yTJhARqwJWDvk5on1
         l07gg0JNcRnCgabwBwc+ffyb26jqfhOsEnIfrLXAlUhI2H+unhSJ4/jFBfuNo9cfvXq3
         jTBPe/3yREEmXW25zOSi9w1sOMrhIZH5lCVj9UgDbG3BQICKlCNhFyONETuhlPDUttBV
         93fvFr7TsJnu+1lJgOzAsXljL5cwCwwHfVLemgGBdA9dhmOZAxTkf5BXjSVYOBewxpJ5
         QZ5Z+Q4JDK6Jm4SjRzDYHvx5ZwQ6BB9dhTIclAjgnRLHYLYVLNRimd8UT57bqkwKEA13
         SgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V3iH6kltXbn8DPbJp+/IxLmJXJxqLstc5tLD9AXFX2A=;
        b=P9zCKeCg3iQCE6ULjU3/exMk6g/2D8A1PmUh1aSQdqTmKffHZ1cJDF6ZCLR6KtPgAD
         ICcJF0zEuX6wjB5Xb2dJ15N0Qv20VyhPssAGnO0vLBEtFbAc4eymxF05aR9ksYJMxJUs
         l7RpOWZCh6uzC5+fCIOx2v9oVlp2OFHjRmM4sUSoCoJ2JQLV8OuG7OXlPSWPkpiB8hOm
         TGs+5BslVABmYhcjC20UfrL6F0Mb/nPsN0w4I24r7FyB1UC0PJwTt3AS3tGlkpf1kdcV
         nA0yHoR0txCCGUqPaQrV/UqseU6DbEpsF5yO5c8VKKWRyVSzd51dfAHrp8b1GjVSP6gr
         l44g==
X-Gm-Message-State: ACrzQf0xQ4+ThgT5P4ChzSS3ZeADgQLTRXcSosARYStt6qHFBh70vyNm
        zX1or9UpAwok4g6HZQfW1E7aLawtyLLeGHfxRwsbeP6Z8ec=
X-Google-Smtp-Source: AMsMyM6sKcPINQGd+KD6W4GncQDNJyhJZUPzjOCpinuV11Lq0SmAZX7NvSy90r9y8s73TfFuAaNgYoxWM1gz4D6qwX0=
X-Received: by 2002:a02:3346:0:b0:375:4c11:ee4d with SMTP id
 k6-20020a023346000000b003754c11ee4dmr14060114jak.207.1667414892996; Wed, 02
 Nov 2022 11:48:12 -0700 (PDT)
MIME-Version: 1.0
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 2 Nov 2022 11:47:31 -0700
Message-ID: <CAJD7tkYKmr0daXhCSkvNZYgx_rDuBaq1OExnw=AEMJ+fSzaHwg@mail.gmail.com>
Subject: Question: BPF maps reliability
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
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

Hey everyone,

TL;DR Are BPF map operations guaranteed to succeed if the map is
configured correctly and accesses to the map do not interrupt each
other? Can this be relied on in the future as well?

I am looking into migrating some cgroup statistics we internally
maintain to use BPF instead of in-kernel code. I am considering
several aspects of that, including reliability. With in-kernel code
things are really simple, we add the data structures containing the
stats to cgroup controller struct, we update them as appropriate, and
we export them when needed. With BPF, we need to hook progs to the
right locations and store the stats in BPF maps (cgroup local
storages, task local storages, hash tables, trees - in the future -)
etc.

The question I am asking here is about the reliability of such map
operations. Looking at the code for lookups and updates for some map
types, I can see a lot of failure cases. Looking deeper into them it
*seems* to me like in an ideal scenario nothing should fail. By an
ideal scenario I mean:
- The map size is set correctly,
- There is sufficient memory on the system,
- We don't use the BPF maps in any progs attached to the BPF maps
manipulation code itself,
- We don't use the BPF maps in any progs that can interrupt each other
(e.g. NMI context).

IOW, there are no cases where we fail because two programs running in
parallel are trying to access the same map (or map element) or because
we couldn't acquire a resource that we don't want to wait on (that
wouldn't result in a deadlock)., situations where we might prefer the
caller to retry later or where we don't care about one missed
operation.

Maybe all of this is obvious and I am being paranoid, or maybe there
are other obvious failure cases that I missed, or maybe this is just a
dumb question, so I apologize in advance if any of this is true :)

Thanks!
