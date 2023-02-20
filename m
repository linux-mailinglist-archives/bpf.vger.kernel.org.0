Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED33369CF80
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 15:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjBTOfq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 09:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjBTOfp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 09:35:45 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC7C1A49B
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 06:35:44 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b12so5474747edd.4
        for <bpf@vger.kernel.org>; Mon, 20 Feb 2023 06:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4cTS+03WSAZj4OQw44bxojcRPE7FE1xi3W2n1m1Zbng=;
        b=i7lSgiE2trIQi5iemzMZgRm6gAIDEeKoO9Tr5qPsCFmLco9j+h05u+PxS74kngplB2
         1uaMeDK4XAD5vB/TQDFiUcajw8ZdjheALS4CBehxghIOacTdumpPQN8iHzKDI8G71vAw
         5HIT7dhpsWIKd3znnHHePx7rViMfRbPqsi0xhDh0uQtLHMWt5EuD8xyimLTGvgeG/eYC
         6HmpfpiWzzLZeehHfr7bdaUWtAdk/mZ/L49XrsS3gmfAEdb3RcxmOUnRN0MtElA+W5av
         Jl7U8BSkEpRI8KUyAPmJsS5Hp4324z/UBMlUWCRrD3HRFe2fuIcItAGlUKjfXN6o+t0u
         tjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cTS+03WSAZj4OQw44bxojcRPE7FE1xi3W2n1m1Zbng=;
        b=sBWYu2haFej81dfV4jpHptX1NIgILYVOqBXHuIM1kA1vViHK7RMPEXk7zlg2SYi6re
         Atk4TUIGoIotqLNScNKk2TldzZvAnpW2uKc+cBCngLCCqWBAziwrxr4rC2X+L0vxpytg
         e1dl0raItUGumPdObiCaryl7zjDNMW0DuCWrkDgfChXCtgQJR7eb8i7N3Ko7U5Zt2SxY
         uAYPgixFbji+ieEyQdUB0GTVB2HJNFAjI3oRp3KPsydGbVt1pE+OcviQv6NkPEVdpm5o
         KdbRp2bjWZUOcVOJNyeSseeJQW9ezeceXUvq6y5T3t82BhOOMV0oTK3LLLZmamixZjN4
         h0Ag==
X-Gm-Message-State: AO0yUKU97MMVL7reRsfSisWLuk+HYIYL6hmv0R6mGBDzIYLHNlVNslUR
        T6jaPt9jxG91B1fl4t8d0PWejm7wF94xYL3KhB1xf6s8YJc=
X-Google-Smtp-Source: AK7set8yevEoM56owYsA3OBrmF52lP+thdLsnrahohcke3b6MMA6r5ZAIMpI11YOWAMD2yYi1uPOmbuLCbmgdrLw/i8=
X-Received: by 2002:a17:906:b751:b0:8b1:780d:e43d with SMTP id
 fx17-20020a170906b75100b008b1780de43dmr5873170ejb.13.1676903741845; Mon, 20
 Feb 2023 06:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20230219155249.1755998-1-memxor@gmail.com>
In-Reply-To: <20230219155249.1755998-1-memxor@gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 20 Feb 2023 15:35:04 +0100
Message-ID: <CAP01T74i5UCfT7fkigYVAu8CnNtwcAxB=9dzQL5N0OpCY4D3pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/7] Add support for kptrs in more BPF maps
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>
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

On Sun, 19 Feb 2023 at 16:52, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> This set adds support for kptrs in percpu hashmaps, percpu LRU hashmaps,
> and local storage maps (covering sk, cgrp, task, inode). There are also
> minor miscellaneous cleanups rolled in, unrelated to the set, that I
> collected over time. Feel free to drop them, they have been
> intentionally placed after the kptr support to ease partial application
> of the series.
>
> [...]

I've noticed the error in the CI, I'm trying to reproduce and fix it.
