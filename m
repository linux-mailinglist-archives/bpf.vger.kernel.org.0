Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B8A4C8066
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 02:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiCABiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 20:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiCABiQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 20:38:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163DD22520
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 17:37:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D45A76156D
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 01:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F6EC340EE
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 01:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646098655;
        bh=Xs9sRozGvtPStbYMq0g/5V/66r6PtbUrStImxXrUP9s=;
        h=From:Date:Subject:To:From;
        b=UXkdjiQ83LZAOTqVELD29zfSyXWESD30IuXLOCJL9aTXnfqgMH8ljU0tRA8lNStgF
         /epmjyj1pA+OdY4uz3l3VtJK96h+onEZAeVgBDm0qZP63aebyCqC44EdrSarZoAnEf
         jVYTWSBD1axAPTdWy+YzwkLwieS5YJpfIj7uGkBCkkAyLpfyo/8o3P+ZfLhi4wNKP5
         91ojeNkKpRQ7wckyqHhSB3O1NBMvSyUShj95dC284K9sgS6cS9lSIxxMqRIFgDKKW9
         Ejxn4o+5syM/ZuiteQtR/HcRzLhxB8gYxTr/5263LP8ZtfCnVD50Di5tOzeHIeVLHp
         FS5UAGnLsm6YA==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2d07c4a0d06so128476127b3.13
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 17:37:35 -0800 (PST)
X-Gm-Message-State: AOAM5306Wx0YWK2SVCUu1MLBFRuBLbe1y0s8JT9uqHV/ldY8DBMIpc8G
        yygAbHB8f4v97D7Joo+KAhfP00l0FndF8AY470Y=
X-Google-Smtp-Source: ABdhPJzarOJB46/w1u1JDw/iJbG4cKlKO/BhYpv4clIqTdoybcuucC5alZO7SG6xH+6LAluGb7+r3/iPXfAScVGQTK4=
X-Received: by 2002:a81:c47:0:b0:2d6:beec:b381 with SMTP id
 68-20020a810c47000000b002d6beecb381mr22985482ywm.148.1646098654346; Mon, 28
 Feb 2022 17:37:34 -0800 (PST)
MIME-Version: 1.0
From:   Song Liu <song@kernel.org>
Date:   Mon, 28 Feb 2022 17:37:23 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6c17p3XkzSxxo7YBW9LHjqerOqQvt7C1+S--8C9omeng@mail.gmail.com>
Message-ID: <CAPhsuW6c17p3XkzSxxo7YBW9LHjqerOqQvt7C1+S--8C9omeng@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Debug with BPF in container environments
To:     lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF based tools, such as bcc and bpftrace, are very helpful for
debugging various issues. However, most BPF capabilities require
CAP_SYS_ADMIN, CAP_BPF, CAP_NET_ADMIN, and/or CAP_PERF, which creates
security concerns in container environments. In this LSF/MM/BPF, I
would like to discuss different options to enable debugging with BPF
in a container, while maintaining security.

To kick off the brainstorming, here are some random ideas on the top of my head:

1. Control what data is accessible to each user. This is clearly
tricky for kernel data structures shared by different users.

2. Control the trigger of BPF programs, iow, one user's BPF program
could not trigger on other user's tasks. However, this won't work well
with interrupts and special kernel functions/tracepoints, such as
context switches.

3. Limit which BPF programs are accessible to non-root users. There
are multiple ways to do this. The sys admin could pin some BPF
programs and share them with users in the container (via a bind mount
of bpffs). This is relatively safe, but not flexible enough for
debugging uses. On the other side of the safe-flexible spectrum, the
sys admin could use setcap on bpftrace, bcc-py, or some customized
tools, but this is not ideal either.

4. perf subsystem enables monitoring for non-root users with per-task
perf events that move with a specific task. We don't have such a
concept in BPF, but similar ideas may work well in some scenarios.

5. Some combination of different mechanisms.

Thanks,
Song
