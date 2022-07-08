Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84DD56C1E7
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 01:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbiGHWtD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 18:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbiGHWtC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 18:49:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6080637195
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 15:49:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k30so190479edk.8
        for <bpf@vger.kernel.org>; Fri, 08 Jul 2022 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcTjbqBGCX8LcxF4+sijp1af/+RCRq0VS67Y38akCFo=;
        b=G6sFgZol1bOmdZPq374giZao/8yULoPhM6eJPENXDjrXGX0d2D/NGRC7hEaF34C0Aj
         6ZJEr89HYdMOSu8SqDKMuU0jGDAHfDwIyvugqrP/FJpJDqJOSClA/xY48BYQOZjMKtPC
         eX63t74gPofmw1zZqeOVCnRWpSzfqCEmozNHmYlU0Pz5MadqVGrjGN03qGqHOlAS1X59
         DrfZFtPTWBrw0k+sdk4BMcnuc6SryGT9rDM0zmHwLT4e4TjQuGCtj11HMMTulhzr/iZ1
         Nhp/2Zu7Q+Mieg4GXN/V9YlCExOJl8P8iDAFoDiNc59vYu7NamG9NkJniyzcRUhdeCkF
         WL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcTjbqBGCX8LcxF4+sijp1af/+RCRq0VS67Y38akCFo=;
        b=j0sg2P1nUJJkZHS6AmeDFvX00+2uAnktO8ufcl/M+kyh5UY23hW3maLB1FesSXY1oq
         Bf8vbXRbGxTZQiFe7ePqfKPc0RZeMAAOLz5d2Gr3k8H7uAKC3z9assuChlYGIVeTZ64m
         60PkMs3JnJNlGOZWTCkIyY/F6BnnRxeic4Ksta+gK8Wmh6xZApnQzbwBrSyiM4DRM+vH
         6U7D8h9+lVk0pVHSntJ71/4CX672u3fzlyRKAOVRsQaNiQRlUwb4671W9R/t7fXB1xLq
         foXZ0DLwPps6fVydy+UR75czfiADVCmEtTuwsB6hMK8qtoEdsAaZns7PSstOnRR2J3xQ
         WbMQ==
X-Gm-Message-State: AJIora8BBBWaIVt1yKC7hLUt39zZTbzicWATb6uNwYtPwGUdrOV+oJeg
        QTLVelx27bGOo2DKLVvrBTa+Ki+tjGJM1hIRLMI=
X-Google-Smtp-Source: AGRyM1swV6zbKZQ43Zy/vKvO1GJILWvnkOoZDqSBKvStlzFqMSESp0IPJPkMjX1a7TjAOQwd4zU2sxgPa84kj6qqz50=
X-Received: by 2002:a05:6402:50d2:b0:43a:8487:8a09 with SMTP id
 h18-20020a05640250d200b0043a84878a09mr7866729edb.232.1657320539995; Fri, 08
 Jul 2022 15:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220708060416.1788789-1-arilou@gmail.com> <20220708060416.1788789-2-arilou@gmail.com>
In-Reply-To: <20220708060416.1788789-2-arilou@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Jul 2022 15:48:48 -0700
Message-ID: <CAEf4BzZkfWTQppe97E1CTLKEqgtxP9gUQqbXB1EKRm5pK_ZmDA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] libbpf: perfbuf: allow raw access to buffers
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Jon Doron <jond@wiz.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 7, 2022 at 11:04 PM Jon Doron <arilou@gmail.com> wrote:
>
> From: Jon Doron <jond@wiz.io>
>
> Add support for writing a custom event reader, by exposing the ring
> buffer state, and allowing to set it's tail.
>
> Few simple examples where this type of needed:
> 1. perf_event_read_simple is allocating using malloc, perhaps you want
>    to handle the wrap-around in some other way.
> 2. Since perf buf is per-cpu then the order of the events is not
>    guarnteed, for example:
>    Given 3 events where each event has a timestamp t0 < t1 < t2,
>    and the events are spread on more than 1 CPU, then we can end
>    up with the following state in the ring buf:
>    CPU[0] => [t0, t2]
>    CPU[1] => [t1]
>    When you consume the events from CPU[0], you could know there is
>    a t1 missing, (assuming there are no drops, and your event data
>    contains a sequential index).
>    So now one can simply do the following, for CPU[0], you can store
>    the address of t0 and t2 in an array (without moving the tail, so
>    there data is not perished) then move on the CPU[1] and set the
>    address of t1 in the same array.
>    So you end up with something like:
>    void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>    and move the tails as you process in order.
> 3. Assuming there are multiple CPUs and we want to start draining the
>    messages from them, then we can "pick" with which one to start with
>    according to the remaining free space in the ring buffer.
>

All the above use cases are sufficiently advanced that you as such an
advanced user should be able to write your own perfbuf consumer code.
There isn't a lot of code to set everything up, but then you get full
control over all the details.

I don't see this API as a generally useful, it feels way too low-level
and special for inclusion in libbpf.

> Signed-off-by: Jon Doron <jond@wiz.io>
> ---
>  tools/lib/bpf/libbpf.c   | 40 ++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 25 +++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 67 insertions(+)
>

[...]
