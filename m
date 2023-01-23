Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680AC677754
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 10:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjAWJWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 04:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjAWJWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 04:22:11 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B23413D74
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 01:22:09 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id r18so8462143pgr.12
        for <bpf@vger.kernel.org>; Mon, 23 Jan 2023 01:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xn535Ligq/pkolj1yklpP0vyf/cE0wZB2EDA2ZhrWEA=;
        b=R/kXrZUK8ZS+erJ6xpLWEdf2hb4SFPk2v0o4uQs3/vbTQ1lqL3TEAtXI7LK5PiTjVN
         xdLmEUf+obM0qG8tqM0K4XaK9zUAxcsK3CS2fz1DHGbrW/XUoHnRsLd0mPekgZjUq++8
         E4SFgMEQlMcaw/fHaPPmoLR1x3UAjhg6Unp1jKpo+r9lc4KmIxXqdX5HJaj3uWQBlyfJ
         sSAN1GOzbAKYPXjhihLtfQb+Duo7O/hWyADPRZocr6d5+s25jEi/0n2ZUOxG/BNNNjo6
         eWkQOQ10mip88rNRe6pgl2AScIy/OMR7VsLDJNxxp7HgXWbxoyTKXBxvMRIPQ7o/nmKW
         8iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xn535Ligq/pkolj1yklpP0vyf/cE0wZB2EDA2ZhrWEA=;
        b=1K385tNwejqksHzd+x+hJ/CKqqPc+jFV2MZU6fplR/yzH8o321DkGRvUrA3Gstd8sj
         GnURgYz3jXxRlBx1Qnkym/KxHkvWq3Wsp40JJkobgHIJzjBr0Yp7MbZV1Tpq8bh1HLfr
         e3pltBNFlnV7g4MsbkYL1YWHdd80ocjDILxy+a5kuZKLDYGDjyWwTYBpD8VtcoG4Fd6b
         8vRSFweo/2Uo3P6j//QtkM4wIbd3fapWASCLD9ha/IQ206UycLgeMPbPlKAzQkwtZAxV
         62vOeVIE9fqK/Vi7hj6EhIGSMfurKNVbA6eLrf7Vu5qpKZS7MN2CIx9RF3lf0Jm5cqQ1
         Vuqg==
X-Gm-Message-State: AFqh2kpXeSG5oSY4MKm7gInN1DtUwi4ansMe3D7xFGaBYte+tk193+Ic
        RbPXhZQR9XbZ0U5HgwQftRlL935XOPl40QSNZkyMwSb2Hzc=
X-Google-Smtp-Source: AMrXdXu9HRjrKmX4MpNGRZ+PkhKhbFZINkyncA4XEdhb1nxa8R/+lJu2xb4msHduG8HMyZvapsJBhEaV3e1qTMVxPto=
X-Received: by 2002:aa7:8a4e:0:b0:577:a0ce:6e5e with SMTP id
 n14-20020aa78a4e000000b00577a0ce6e5emr2390773pfa.21.1674465728791; Mon, 23
 Jan 2023 01:22:08 -0800 (PST)
MIME-Version: 1.0
From:   Yaniv Agman <yanivagman@gmail.com>
Date:   Mon, 23 Jan 2023 11:21:57 +0200
Message-ID: <CAMy7=ZW27JeWd-o7dYaXob2BC+qKRqRqpihiN9viTqq1+Eib-g@mail.gmail.com>
Subject: Are BPF programs preemptible?
To:     bpf <bpf@vger.kernel.org>
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

Hello!

Several places state that eBPF programs cannot be preempted by the
kernel (e.g. https://docs.cilium.io/en/latest/bpf/toolchain), however,
I did see a strange behavior where an eBPF percpu map gets overridden,
and I'm trying to figure out if it's due to a bug in my program or
some misunderstanding I have about eBPF. What caught my eye was a
sentence in a LWN article (https://lwn.net/Articles/812503/) that
says: "Alexei thankfully enlightened me recently over a beer that the
real intent here is to guarantee that the program runs to completion
on the same CPU where it started".

So my question is - are BPF programs guaranteed to run from start to
end without being interrupted at all or the only guarantee I get is
that they run on the same CPU but IRQs (NMIs, soft irqs, whatever) can
interrupt their run?

If the only guarantee is no migration, it means that a percpu map
cannot be safely used by two different BPF programs that can preempt
each other (e.g. some kprobe and a network cgroup program).
