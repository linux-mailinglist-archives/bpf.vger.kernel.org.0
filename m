Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD82461A3E1
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 23:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiKDWG6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 18:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiKDWG4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 18:06:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ABF12A95
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 15:06:54 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i21so9526720edj.10
        for <bpf@vger.kernel.org>; Fri, 04 Nov 2022 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQGnI4Fql272mFNX+xYq49ADkeYk0fiL8Ihp8ioh7Z8=;
        b=XTR1XrwpA2MU4kIZMgnmXjG0BdM3VItXGq69crtVKTx0z3i1wE8Pu/js++UGZYBzym
         iZm9Fr5yJ9nv2N+VAi0XkUW1l7jTrD4f2YpaLMSA/ZS5kssAr1MymZJ+UTU932MIjlm+
         jMa9dU1jguLm9xg/4qCbFRsrnzp59TvOfrPxlluxXbAFGGCq7NnNZRR7FKX9wYwoJ4w8
         33bt4ppmuTYUpzxg+MYkJID/YaH5Aa8J4cmqzyGwv4TK9HRzRnlfcvOb/JiY+Ar6318B
         5hS1ybfIGMahi1saBUzn8UsEYvrt+EUd3QxkBc4Cx1Oi13/SgI2uJu8SptRjEryy33Ts
         GLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQGnI4Fql272mFNX+xYq49ADkeYk0fiL8Ihp8ioh7Z8=;
        b=HYhlj29o/bGRen1bM1hX9b924bW7JVY8C5kjtrE/wxTcphTq1OW8CJEDTun6/RHM/M
         tMbwGuxaNvYfWpFkTYqdeWQXted+SrOdILN0EPFaBVsNgkm2ihna71jaQn6fd/8fQjB9
         KNc8VVGb5kP7XI1cm93mR2+J2o5HnxqI7YQqixcY23tWgEiHD+9yp7hETCm+EW+5Z4s9
         S+FZRvTd2YGWvqTUtzApU+3Mc+4KdboOs8tFC7mc2e1cQlslXrdblSnMJWewUZh6ZBxN
         QKO2uzvF5wGQY47oww/deKpVrY09ROBysNq3QrGpaBNFUfbQ8UglJTRy45MeEb5Ks0vW
         udyw==
X-Gm-Message-State: ACrzQf0Kj0NAv1N9OGXuob9sAc3fjBhoFdLBzXzhzVeT+BL40e5aklYg
        XH2OVSqQlJUnQgNbbo0QccRVbUrUzMaCf1uApcsv77mxqBs=
X-Google-Smtp-Source: AMsMyM5ita2MXgEbEKnqwLeUMmzNIv1txt8WD0BQeEDnj1cejbgr36Cje2vQ+QXHTDzIVMlvwqrFKbWoHhAExT+PZro=
X-Received: by 2002:aa7:c2ca:0:b0:461:89a6:2281 with SMTP id
 m10-20020aa7c2ca000000b0046189a62281mr39318033edp.260.1667599613495; Fri, 04
 Nov 2022 15:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <m24jvgtexc.fsf@gmail.com>
In-Reply-To: <m24jvgtexc.fsf@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Nov 2022 15:06:41 -0700
Message-ID: <CAEf4BzZgQ6K=8=Aww3XRfUD2cbJUn3v_zfNCZ=JgUAE-r0whBQ@mail.gmail.com>
Subject: Re: Question: __u32 or u32 in BPF code
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org
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

On Thu, Nov 3, 2022 at 5:37 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Hi,
>
> Should BPF code be using UAPI types such as __u32 or is it considered
> acceptable to use kernel types such as u32? I ask because the helper
> definitions that come from libbpf use the UAPI __u32 style types, but
> the bpf-helpers(7) man page refers to the kernel u32 style types.
>
> As I understand it, u32 et al are kernel internal type definitions that
> should not leak into userspace which I believe extends to BPF
> code. In order to use a kernel internal type, the BPF programmer would
> need to define it themselves, or use a BTF generated vmlinux.h? Please
> correct me if I am wrong, or oversimplifying things.
>
> I think it would be useful to include a statement about UAPI types and
> usage in BPF code somewhere in the documentation. Once I have an answer
> to the question above, I am happy to work on a contribution to the
> documentation.
>
> A follow-on question is how to make things consistent across the UAPI
> header files and the bpf-helpers(7) documentation.

FWIW, libbpf's bpf_helper_defs.h is using __u32/__u64/etc.
scripts/bpf_doc.py remaps everything uXX to __uXX for bpf_helper_defs,
we can probably easily remap for man pages as well? But obviously
u32/u64 looks a bit cleaner and nicer. And BPF code tends to be
written in u32/u64 terms when using vmlinux.h, but only for internal
types. When defining global variables, one has to be careful to not
use u32/u64 because those types get exposed to user-space code.

So I guess from consistency and POV of the least surprise, __u32/__u64
is preferrable. From aesthetics POV, u32/u64 are a bit nicer. Curious
if anyone has a strong opinion, because I don't.
