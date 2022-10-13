Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699445FDD3A
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJMPcY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 11:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJMPcY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 11:32:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEBF89CED;
        Thu, 13 Oct 2022 08:32:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id m16so3167864edc.4;
        Thu, 13 Oct 2022 08:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zxl10p8+VaJSG7LabxLfsUFo8al/diQxcVDs5XO+2gI=;
        b=CknogysIi9tHv/VGyj0iB9aDNnEzq85wjeUGeVBvvKUpDs0Fp7/mc45yxmn5CgwelH
         wnyxu+R0KQ72oiVWlXEP7tzcgTUpvJKBRyhzYc3MHwJkU263gJc0hY9J+657I1RDszGk
         juCVHaYDXAMJlHt3KILhhDNs1ZJzAYAkmvm2KlURgUqwCdESlzFs4iVD34FjZZuApKeW
         13PXrQwRlmD+nQzsihupc6Os3IP3l5PxHNGvmnOOaOzg8hqX8oa5PnAWcwLMfrWAOjlO
         gFVipKMOFCcmm1t37ffESa2IUei8NDxYglViuAE5pJrKDDb7G0WsDL4QaVgW7a2RAdeU
         iTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zxl10p8+VaJSG7LabxLfsUFo8al/diQxcVDs5XO+2gI=;
        b=VYBvzvIUx7ZlzeQY2jX+ooNGNElaVt7UuVZ3KfZX2S5/4n9HUWtRN6cctLgc9naOWk
         QIjVtTv6o+o4sdR6xIuUllAjEctcjzzJbe4KikmpusU1MIfXNLKXg7JiE+x13uqG95FD
         /Yx8mnsbzFXt3GA75pTxHZrbkaUuz2QqPTr5E+q4t80P0bfkBgUmwTjMAyasJrKqNsDM
         4fChMp9cxXDn+1yJ2KapqdWUkWurPRCD8ne7A9cA1W1iCJJaUS3WNWD7tZUQ8Hge1wy4
         A4QFtFUW/D7O1enF8MJVw0pFzc6kmQ5iBj8QeIrI96yn4wYsUXZt8XwZ2KlB3kCTQZkH
         gy+A==
X-Gm-Message-State: ACrzQf0HskSSYyxp9/yUJM7M/3gYL7lihayrrTEC2gUkkVXF3+dAbHkW
        /oTNR8EuUMhVGErLfMwZNvDfpT1VD67Nk5DbzxQ=
X-Google-Smtp-Source: AMsMyM5vphIX4iiWMzoRbVmI4TE9TkfpkKNI3FIJjTjlZIAQzqS70vKDNCzTe/FFWp7F2a9uMKvS/FgKPjt4HoCfFwo=
X-Received: by 2002:a05:6402:3641:b0:45c:4231:ddcc with SMTP id
 em1-20020a056402364100b0045c4231ddccmr324330edb.224.1665675141497; Thu, 13
 Oct 2022 08:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221012232015.1510043-1-void@manifault.com>
In-Reply-To: <20221012232015.1510043-1-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 Oct 2022 08:32:09 -0700
Message-ID: <CAEf4BzYzZ_84-AdwGbzhrqyGJ=1gT=9AtRAuA59k4BwT8R-SbQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow bpf_user_ringbuf_drain() callbacks to return 1
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        martin.lau@linux.dev, daniel@iogearbox.net, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
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

On Wed, Oct 12, 2022 at 4:20 PM David Vernet <void@manifault.com> wrote:
>
> The bpf_user_ringbuf_drain() helper function allows a BPF program to
> specify a callback that is invoked when draining entries from a
> BPF_MAP_TYPE_USER_RINGBUF ring buffer map. The API is meant to allow the
> callback to return 0 if it wants to continue draining samples, and 1 if
> it's done draining. Unfortunately, bpf_user_ringbuf_drain() landed shortly
> after commit 1bfe26fb0827 ("bpf: Add verifier support for custom
> callback return range"), which changed the default behavior of callbacks
> to only support returning 0, and the corresponding necessary change to
> bpf_user_ringbuf_drain() callbacks was missed.
>
> This patch set fixes this oversight, and updates the user_ringbuf
> selftests to return 1 in a callback to catch future instances of
> regression.
>
> This patch set should be merged to the bpf tree.

Please tag patch as [PATCH bpf x/N] next time. This will make it clear
that it's targeted against the bpf tree and will let our CI know that
it should be applied and tested in bpf (it chooses bpf-next by
default).

>
> David Vernet (2):
>   bpf: Allow bpf_user_ringbuf_drain() callbacks to return 1
>   selftests/bpf: Make bpf_user_ringbuf_drain() selftest callback return
>     1
>
>  kernel/bpf/verifier.c                                    | 1 +
>  tools/testing/selftests/bpf/progs/user_ringbuf_success.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> --
> 2.38.0
>
