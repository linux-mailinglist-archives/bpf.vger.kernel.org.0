Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2786E6A489F
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 18:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjB0Rw4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 12:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjB0Rwx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 12:52:53 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C842241C0;
        Mon, 27 Feb 2023 09:52:46 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ee7so29308269edb.2;
        Mon, 27 Feb 2023 09:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qwq8XhCRFLH/d4cwYy+6zaCwbL3In6bHOwcuZDmauo=;
        b=H6DURYAZTQ8PF2N7b3qfWLapNhTxlXgJTZyc3ujJtX+D0tX8Kd4ff5zzjJIzN4cR0l
         y2UZ00pA/JY0I5BDGoPt2jeIEFnObwSFyt78xUMKsdlUMqzLi3qxIiFrEJ9sIAr2scQ3
         T/ngLBEToNXLT07Jg4FchERytluSOwearfiJdV1CoYZhJxxocqa2VwgZEZMv7pvqu5A3
         uznc+XlwRLKDxoLglprE53551mt4M1eP/FKAdy0782o/t6vvCOEViS2RAJ2If6W8hmzN
         SFrunB84VUZotkF++hrNLjIhp/W+xg7/zGLosWvgZcHkBfagu5Vw9ivNPulK3yde1clF
         xv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Qwq8XhCRFLH/d4cwYy+6zaCwbL3In6bHOwcuZDmauo=;
        b=Vftkoh/kUSvYLzV8qlwgHLfbam70hpmnx97hrnKTOmqVEaqvPm6bqkaCB8TTtdUc+l
         swXP4y037BT0chlldeYVkMgqNI/n24EyDMmk52WT6loPPXRf1fo5nkvJPHm2oAkxvCfP
         snrbMGqZLxuPpduaYcFaA1ai31OQaGouZlx30yuyw43QXtbOHWykyjAX4eG8HLc6q83C
         Xwcm4ghAJMAZfMMfwBDTrFHanDj0a0wAlZ52g4fd5iQg/7p7Zl2DgFuxrl9GrYp2o8bV
         2pSTmK2eetjXkoZ6u60TTkUSJB3JEX9Ur7ABemi6zzz+SWfyS/7L14KR8ntrArh9Zfa5
         tNUg==
X-Gm-Message-State: AO0yUKXS9YUcoA5s0GmqIbdtIX3QXTZUgG3XDgwJRTzQBA+DfNb3oQGM
        6xNfC8Oz9ayfN1c7HKtRmAP/ctfhu7C4FbB1d+aupBe6
X-Google-Smtp-Source: AK7set8Oem3O1xhf2YjoZyEx4olYaq27sT9NEDEDzmR5XVAFlzXk3Zk/Y8sid/zcfeATcuHqbAxFIFthpxCV7Os9BhA=
X-Received: by 2002:a17:906:6d07:b0:8af:4963:fb08 with SMTP id
 m7-20020a1709066d0700b008af4963fb08mr16534964ejr.15.1677520364876; Mon, 27
 Feb 2023 09:52:44 -0800 (PST)
MIME-Version: 1.0
References: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1677235015-21717-1-git-send-email-yangtiezhu@loongson.cn>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 09:52:33 -0800
Message-ID: <CAEf4Bza9_LPMJnAGsPxDPEkY7JWL7PSwwZ7e_mHZGg32qaPvGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] Fix some build errors for bpf selftest on LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Feb 24, 2023 at 2:37 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> v2: Modify patch #3 to avoid breaking user_ringbuf test on x86
>
> Tiezhu Yang (3):
>   libbpf: Use struct user_pt_regs to define __PT_REGS_CAST() for
>     LoongArch
>   selftests/bpf: Check __TARGET_ARCH_loongarch if target is bpf for
>     LoongArch
>   selftests/bpf: Use __NR_prlimit64 instead of __NR_getrlimit in
>     user_ringbuf test

I've applied patches 1 and 3 to bpf-next, but we can't do what patch 2
does. Also, please provide a proper cover letter message next time,
just version log isn't enough.

>
>  tools/include/uapi/asm/bitsperlong.h                     | 2 +-
>  tools/lib/bpf/bpf_tracing.h                              | 2 ++
>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c    | 2 +-
>  tools/testing/selftests/bpf/progs/user_ringbuf_success.c | 2 +-
>  4 files changed, 5 insertions(+), 3 deletions(-)
>
> --
> 2.1.0
>
