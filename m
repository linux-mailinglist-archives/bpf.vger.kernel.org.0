Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDF326269A
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 07:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIIFHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 01:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIFHe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 01:07:34 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA49C061573
        for <bpf@vger.kernel.org>; Tue,  8 Sep 2020 22:07:33 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id s92so974314ybi.2
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2020 22:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hV5ggav+RkyjvbUngTV4JKPxO+1cvf+i9W+E5zmhRM=;
        b=AwnfXh61TmC9AXNQeWlWFGs/6XNBcUMFyUyeC7Wyb0s0wH5H1ZqY6ucrUY6bcj2tby
         MRB+pueLvdKTOFVxSBBCIX4aYP50DLABf3NGg4zqq6/rA61gFVmikFQ8G0+o9cmw84W+
         c6KSdS8XTaEccoBZJqfT4X9RdE7hRZjqWLdmD/fSU7xXXRGXXslSnW7vIqJG5WdF+x7Q
         hsU+JTdQawW9lQK2KWrlfxv55H7rJYU4RoCekAjY1EjO6h3hzYLFvPq3bfU3KvhxtGQU
         pKNhpjgqY12l6r5Br2CTSk8uCbSzNkIdZFKM+NXx9fdMtPetxZ7E8sIJvCH/30Ni7J4M
         zlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hV5ggav+RkyjvbUngTV4JKPxO+1cvf+i9W+E5zmhRM=;
        b=XjEfC3JHMAfV3y5nEPRbKLG7v5WYneV8qnXPoQruO91MV1mmch5p6NasCUhwdLJIWj
         12+AoC/u0ZZyUQT7nP8Y7PnA8S7MQ60BtpQuxZczHWWz65atX09G16E6Ajr5QgE/0Yh/
         fYkdfyIuze58MFAjBRvuNFXIv2MSSEykplzoY62BBP1iew7cMieGQ9wvmxkQFQoCHbC3
         l3zYkhBdeEg5wcnNUXPK0mQcDlbLZyCKUOGp+Bat7baEWOFP0CuNpFoMZgc5NEQmkO+c
         mzoEnc3aIyoAtB2towVoy7ath4kLi8PQhAKHqf3jh0v+C4A3ebR7u4yISLzgHEU4ltGW
         HKrA==
X-Gm-Message-State: AOAM530jZFUCW/9P2x/O243GptsTLLWDG3gkEttEpgy1gEngRocDeW/9
        Mj3GYCqBvTMC75ntplZmy4xeJLF7Hik3oo6+hQc=
X-Google-Smtp-Source: ABdhPJzzVxqUNZrpBC9fhILQ/z104H0yfv5Z4AQeHHzxgFyi+64RtQsNnD5nkEzAw0LbsdaPqk8ACUEv/RFHN6dNMLA=
X-Received: by 2002:a25:e655:: with SMTP id d82mr3494218ybh.347.1599628052870;
 Tue, 08 Sep 2020 22:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-11-lmb@cloudflare.com>
In-Reply-To: <20200904112401.667645-11-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Sep 2020 22:07:22 -0700
Message-ID: <CAEf4Bza7DuWGABz2sDxWcNX3c+3dDx=FKRdQs0aBVxYiZaxMFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/11] bpf: hoist type checking for nullable arg types
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 4:29 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> check_func_arg has a plethora of weird if statements with empty branches.
> They work around the fact that *_OR_NULL argument types should accept a
> SCALAR_VALUE register, as long as it's value is 0. These statements make
> it difficult to reason about the type checking logic.
>
> Instead, skip more detailed type checking logic iff the register is 0,
> and the function expects a nullable type. This allows simplifying the type
> checking itself.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  kernel/bpf/verifier.c | 66 ++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 35 deletions(-)
>

I like this change.

Acked-by: Andrii Nakryiko <andriin@fb.com>
