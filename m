Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998296B6A19
	for <lists+bpf@lfdr.de>; Sun, 12 Mar 2023 19:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjCLSbD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Mar 2023 14:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjCLSas (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Mar 2023 14:30:48 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41BF1164F
        for <bpf@vger.kernel.org>; Sun, 12 Mar 2023 11:26:19 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s22so12988387lfi.9
        for <bpf@vger.kernel.org>; Sun, 12 Mar 2023 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678645477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUzlxJZzG3vDFVLZkW0fncGW5tXPXw+2URpsAfV9x14=;
        b=H1gGBXb2RbEuPUWP7OSUfpkzziuh2Wr44sN82869g+eCeYLSgZlDL8QCiwGxTiEBGK
         XuTtTimSHggqf+0JEbG+jaFxncXPZZlKp4RaGoZ4/oKFkxZg5rzfNrCLB5juKIEb/jDO
         1bg5WQoazuSWu+YFxxbN+KBHDk1I6Z4PZZdbN1Q0DjO/vSU8iWdDQerW2xm5avs301/a
         i3ng0vnp/o1ropwszzgYexnd27OvvJzeoPUPIJXe/PqFcSkEX7FLw/zuueTM7Xw5rCHn
         7SWnfi7yGEGa7/OfLEkqGOcj7+goqx7bZRyvT6610NQOpOe9pHWVRSzQ1Tjni0raP4XA
         TaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678645477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUzlxJZzG3vDFVLZkW0fncGW5tXPXw+2URpsAfV9x14=;
        b=zTYOwQVg5ozN+4U6bG7VHzBw2Y0o74pPhq0QYy/P28EZa8h2oNmS2luXFw0qv/adz1
         mRXPyfvrj20gpvkVEwyTZZKPGQpbMuFincrkFC0UmOEjgJ/DA4pwjc9pBr2aVjUu0wrh
         NUhV+tkC+TItNjp+W+CywExoXOmZ1cjr86k/m45jyCEkKtpSD9RlasBkoD8y+2B1Ya+k
         RE8gfIxaII29KsodonHl9PcGHAo98V6eMiJTH7kWL/gB9cqAQ75/qQT/FaJsUGI55HeQ
         R9eCUgERMFgwTXR112vi5Ox6oSlEt7r8gSe4eXUe65FyAWlwLPX2XaOR+O9U1wpZFk04
         X/Qw==
X-Gm-Message-State: AO0yUKV32QQ1beYHmOBErAnZli8X1H35RyyRZpBzzxh2J9lyoNelbVyb
        JLBBmsXeUnjz5hbr8PLd0TLk5m46Jaesnx7ML24lluLr6nXhzA==
X-Google-Smtp-Source: AK7set9r5gj5RyGgED4TFYKgmODS2sInMl+joMY2dCarExfaBOscog4bsT58YF1M1vwgtMF/YIGghsODV1apjUkQBrU=
X-Received: by 2002:ac2:550a:0:b0:4e8:426d:123f with SMTP id
 j10-20020ac2550a000000b004e8426d123fmr523410lfk.11.1678645476616; Sun, 12 Mar
 2023 11:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <CANk7y0gsUpnVnDMh=Wbs5h2Z=25bzMEZ5La03-MX133DPd=eDA@mail.gmail.com>
In-Reply-To: <CANk7y0gsUpnVnDMh=Wbs5h2Z=25bzMEZ5La03-MX133DPd=eDA@mail.gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Sun, 12 Mar 2023 23:54:25 +0530
Message-ID: <CANk7y0gPMe3tgUbWSgD9wiiN0RM=FZfws1ZrgM_AmvNxSkpQiQ@mail.gmail.com>
Subject: Re: [RFC] Implementing the BPF dispatcher on ARM64
To:     bjorn@rivosinc.com, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        daniel@iogearbox.net
Cc:     bjorn@kernel.org, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On Fri, Mar 10, 2023 at 3:03=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> Hi,
> I am starting this thread to know if someone is implementing the BPF
> dispatcher for ARM64 and if not, what would be needed to make this
> happen.
>
> The basic infra + x86 specific code was introduced in [1] by Bj=C3=B6rn T=
=C3=B6pel.
>
> To make BPF dispatcher work on ARM64, the
> arch_prepare_bpf_dispatcher() has to be implemented in
> arch/arm64/net/bpf_jit_comp.c.

I realized that after [2] the BPF dispatcher is using the
bpf_prog_pack allocator.

We need to implement bpf_arch_text_copy() and bpf_arch_text_invalidate() to
enable the bpf_prog_pack allocator for ARM64. Then we can use it in
the JIT as well.

[2] https://github.com/kernel-patches/bpf/commit/19c02415da2345d0dda2b5c449=
5bc17cc14b18b5

>
> As I am not well versed with XDP and the JIT, I have a few questions
> regarding this.
>
> 1. What is the best way to test this? Is there a selftest that will
> fail now and will pass once the dispatcher is implemented?
> 2. As there is no CONFIG_RETPOLINE in ARM64, will the dispatcher be usefu=
l.
>
> [1] https://github.com/torvalds/linux/commit/75ccbef6369e94ecac696a152a99=
8a978d41376b
>
> --
> Thanks and Regards
>
> Yours Truly,
>
> Puranjay Mohan



--=20
Thanks and Regards

Yours Truly,

Puranjay Mohan
