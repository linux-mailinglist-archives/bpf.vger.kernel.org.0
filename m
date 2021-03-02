Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4781232A473
	for <lists+bpf@lfdr.de>; Tue,  2 Mar 2021 16:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578118AbhCBKfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 05:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380006AbhCBKZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 05:25:22 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FABC06178A
        for <bpf@vger.kernel.org>; Tue,  2 Mar 2021 02:24:40 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id a7so21084150iok.12
        for <bpf@vger.kernel.org>; Tue, 02 Mar 2021 02:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OTOWiCKDVAyEcgQihoMEGgYpip7NJz+xqKkvweThjKQ=;
        b=uFFduu+2wJZtqtrECdMcTkSZ+FEzCztf/kOrtrfz5wH257uSKVL0zUcW78oZTpvJxl
         Yc6ew/LQBwwboPdWGoMSUyiFXw9CZ2qVJ1Uc5YFWk7J0M4uTsxnTRGM+pAWNs9w2ZoRZ
         8LkVa9B3lifxqenRX0WLNEZv5ctWbvC+1D4XvA6fxptndDiT9DvJmtwasZPZgmild1/s
         gSOn7mYaKWhbR9LoMmaOGn24SiCZoYrrqTF9FiuJ50FJssbZ9VYXU2BatAHGsomo4PE3
         lnO0Bos3TxCYiIayt7jitP//4rf2hI3mPkG+B0BVDKe4G1jHlm+5cOk5bTC7Uh4l40ap
         IZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OTOWiCKDVAyEcgQihoMEGgYpip7NJz+xqKkvweThjKQ=;
        b=SVd9R/SMohMV0SA4HyxZYhzalkLlvkul2hmrFO0BhMU2A0z80iHizJN+vhfYkt2MQU
         IYZu3bUz7a76FTTLSW3PWSMyMEXilr2tDBCD9485j9yIRcAaZIKp1cBvGg3i9pH3L7US
         dhHmxcQJBXz6Nuc9fITKvAC1I72BWTBRGqLz3azXeHyskOasF+AVbV4MlbtssHXKeK/C
         /2X7ECZGf4V+dDlXqvn2CUyZd9PAsY9onkMC0rORcGBY1z6rLzcrvGpGXEdFAcPHpF8V
         nI7SgHgeCcymgfvZMzhtODq0XrR7HNGsuKkFv53a2X1kQmL+AND5SPNz4QhSyxnA6l5L
         6stg==
X-Gm-Message-State: AOAM532sJC3gQy4Eq8KoiyBFt8KOgy40HNv1EcbjZtPe20/QOlGUUO8r
        McEH7FxuVB6Ppot8yxbAki84fOggxYMPogVfhoGqwl3E/Cw=
X-Google-Smtp-Source: ABdhPJyY07Y5amB8Bqy7tSevwtWrEU1j+ddLrJdPUoixiNEEo78YhISXiqgDUPY9m81FzPx77s/TDusvSMRxYRj3OmU=
X-Received: by 2002:a6b:ea08:: with SMTP id m8mr17001589ioc.194.1614680679983;
 Tue, 02 Mar 2021 02:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20210301154019.129110-1-iii@linux.ibm.com>
In-Reply-To: <20210301154019.129110-1-iii@linux.ibm.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Tue, 2 Mar 2021 11:24:28 +0100
Message-ID: <CA+i-1C1TgJMsFSMJEHyqhUTXy8HE38ePuVXGEDsPvmKv0kJmFg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf] bpf: Account for BPF_FETCH in insn_has_def32()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks!

On Mon, 1 Mar 2021 at 16:40, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> insn_has_def32() returns false for 32-bit BPF_FETCH insns. This makes
> adjust_insn_aux_data() incorrectly set zext_dst, as can be seen in [1].
> This happens because insn_no_def() does not know about the BPF_FETCH
> variants of BPF_STX.
>
> Fix in two steps.
>
> First, replace insn_no_def() with insn_def_regno(), which returns the
> register an insn defines. Normally insn_no_def() calls are followed by
> insn->dst_reg uses; replace those with the insn_def_regno() return
> value.
>
> Second, adjust the BPF_STX special case in is_reg64() to deal with
> queries made from opt_subreg_zext_lo32_rnd_hi32(), where the state
> information is no longer available. Add a comment, since the purpose
> of this special case is not clear at first glance.
>
> [1] https://lore.kernel.org/bpf/20210223150845.1857620-1-jackmanb@google.com/
>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> ---
>
> v1: https://lore.kernel.org/bpf/20210224141837.104654-1-iii@linux.ibm.com/
> v1 -> v2: Per Martin's comments: rebase against the bpf branch, fix the
>           Fixes: tag, fix the comment style, replace ?: with the more
>           readable if-else, handle the internal verifier error using
>           WARN_ON_ONCE(), verbose() and -EFAULT.
>
> v2: https://lore.kernel.org/bpf/20210226213131.118173-1-iii@linux.ibm.com/
> v2 -> v3: Per Brendan's comment, add "verifier bug." to the error
>           message. Unfortunately, the load_reg assignment cannot be
>           moved, because this would also require moving the insn
>           assignment, and this would ruin the reverse xmas tree.

Acked-by: Brendan Jackman <jackmanb@google.com>
