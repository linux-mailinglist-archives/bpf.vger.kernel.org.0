Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881CE1D1F53
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 21:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390711AbgEMTgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 15:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390397AbgEMTgk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 15:36:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC13C061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:36:39 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 8so543853lfp.4
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxiMveoP0RhCR8vjDCp/HmQWj731R3On/oP1uZF2PQE=;
        b=eyGhYtEXi8PPzZXswj9fBVzAZ7MKdPyfDFJANIY5Qa8lnG4B6PQlkLIvCnEsRuAYDd
         cijbLp3K6GqvurO+mnvtFYs9Cit1WsfsH6w5mAvZOtdvpGdoJxKX+co3FEMrxzMFBuxb
         6U4kH5ee2J4uHKUOq+K6Hnjpw8SSIL615vIlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxiMveoP0RhCR8vjDCp/HmQWj731R3On/oP1uZF2PQE=;
        b=ba2/NaPUj91DYD+AuH6N9tBLcnolvlYCUSmwZWmNNwRjkzl4uu9vkyk+sMH4N8hiTM
         McdO2J4HQfAd7hUgc1Lw4Eq2yYdA04PdYWinxpohyCnFowPve4amg4P7EG6HB8C/Mj2Y
         aNsML9yWcV6XZ4PK8Zc/r7rxf4P7F00cOWv5BFFeCDBXlZHzUwzDFH1yMERy8e4kAM9g
         cUedFCESLd84tw4QUWU76Z4ACzUqcSIp+0y8/0kAQmBBjQxkZ/x2X8e9J5/2T5hfDQxb
         +0Q/yXAj+jB2xoQLlSi9GjrmOHREi7803oxeZtW/iqO6HSl2RTLZ9fQq+ALwE94d9svf
         OVJA==
X-Gm-Message-State: AOAM532wow8IGSGpAT0ldgKAHzu1HlDIZwkrXHJkEcWfL6/GmeqKW2yz
        FyuuAZ7Omsu7+CI4tJ/LnvqhCGfERg8=
X-Google-Smtp-Source: ABdhPJyiRIoEwbfl6AWvvLRDa1QxTESsMjevVwQm/nw6vQ5418FffZtgP1icghtn7gYmswL75By+QQ==
X-Received: by 2002:a19:c6c5:: with SMTP id w188mr677564lff.65.1589398596982;
        Wed, 13 May 2020 12:36:36 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id p2sm223980lji.40.2020.05.13.12.36.34
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:36:35 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id w10so941271ljo.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:36:34 -0700 (PDT)
X-Received: by 2002:a2e:9641:: with SMTP id z1mr394092ljh.201.1589398594575;
 Wed, 13 May 2020 12:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-15-hch@lst.de>
In-Reply-To: <20200513160038.2482415-15-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:36:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzXqgYQQt2NCdZTtxLmV1FV1nbZ_gKw0O_mRkXZj57zg@mail.gmail.com>
Message-ID: <CAHk-=wgzXqgYQQt2NCdZTtxLmV1FV1nbZ_gKw0O_mRkXZj57zg@mail.gmail.com>
Subject: Re: [PATCH 14/18] maccess: allow architectures to provide kernel
 probing directly
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 9:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +               arch_kernel_read(dst, src, type, err_label);            \

I'm wondering if

 (a) we shouldn't expose this as an interface in general

 (b) it wouldn't be named differently..

The reason for (a) is that several users of the
"copy_from_kernel_nofault()" interfaces just seem to want a single
access from kernel mode.

The reason for (b) is that if we do expose this as a normal interface,
it shouldn't be called "arch_kernel_read", and it should have the same
semantics as "get_user_unsafe()".

IOW, maybe we should simply do exactly that: have a
"get_kernel_nofault()" thing that looks exactly like
unsafe_get_user().

On x86, it would basically be identical to unsafe_get_user().

And on architectures that only have the copy function, you'd just have
a fallback something like this:

  #define get_kernel_nofault(dst, src, err_label) do {  \
        typeof (*src) __gkn_result;                     \
        if (probe_kernel_read(&__gkn_result, src) < 0)  \
                goto err_label;                         \
        (dst) = __gkn_result;                           \
  } while (0)

and now the people who want to read a single kernel word can just do

        get_kernel_nofault(n, untrusted_pointer, error);

and they're done.

And some day - when we get reliably "asm goto" wiith outputs - that
"get_kernel_fault()" will literally be a single instruction asm with
the proper exception handler marker, the way "put_user_unsafe()"
already works (and the way "put_kernel_nofault()" would already work
if it does the above).

             Linus
