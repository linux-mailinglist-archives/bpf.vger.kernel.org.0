Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDF5436EF8
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 02:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhJVAqH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 20:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbhJVAqH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 20:46:07 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8249FC061764
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 17:43:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o4-20020a17090a3d4400b001a1c8344c3fso2337301pjf.3
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 17:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOr4gx1mLXFhqHDG0rVpWr1TIx97UzCoZrRgZhCE5oI=;
        b=mzDTDDkogZSWzgWclse7WisdsvoWJzL1mYEQNQUWPAlG8Tjnzj4Dnowtyk9NSY8rGN
         38plmgBMXHzAiCVKkktt0FRBhDMyzKC7GTdDGRfv6c0PNvCa/hQU4iPwIGz1Flnbh4pO
         A5q8JH7gj+DznasBtW8PpUP3gRH4D1CffwN1Ijidi32b8clVLBD9Q7FgyHhaH9/uENzf
         riLcR7CvzcvnP179dP/Gzu5I2PVM+2Vw9xNxLFkuRrTG9c+n1DZmepljbYbogPe4c9A7
         FvdCAqa7FzHOGq9Xy1FnKtbNEq+7jeo+XftPXNJ3w5Cfe5DPLUPkiUprD5CJ8vIhCk74
         LfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOr4gx1mLXFhqHDG0rVpWr1TIx97UzCoZrRgZhCE5oI=;
        b=wOjXT4HbHuY4wRTZWO90oImeSVTc1Pu59OFUf5ouZ3Nr2M2sp/TIDg1273SWF+kvha
         ZZxw6VngO+KMAa1ah0NA1BoXZsIOfnf/szi3TJt6JFghtDK7nMCZlEQcXpGBIVXtJfzd
         TSEoieQR1ryB0HqJPxjMP1dfrcjTp9BfZ8Loat7WiX4FTuSnHcRqvI60YJfUZ4mid1yH
         l87PzlKOsbKaRrOnwwzYr+VdapSwHiGmypoSowcCYAuQ5lmA2ENlgx3lGAU6gxgpPWOj
         x/r4bEcqbPDfusaY1bJDt6hJjV3XsSu5YU4IDbPLY3rosBrCVEWZiVFne+GdTnaALMcY
         uA7g==
X-Gm-Message-State: AOAM533mJzBWERW0KwhJmB1W3jf7AI9NfForBnyNtAxIDRw5reyBmZYp
        +hslFdoxXKP0ugDAXhNjM4NQvDAThG3e4wKgkTgN+lr9mtg=
X-Google-Smtp-Source: ABdhPJw4CSNJBlXd3RsYe83lPTqDjVhPn/H6P/9Ytlw2Tv9La+3/cfs020EWha0uEEpJeE7jUDCU03EXhSUmLSFKiuA=
X-Received: by 2002:a17:902:8211:b0:13f:afe5:e4fb with SMTP id
 x17-20020a170902821100b0013fafe5e4fbmr8418238pln.20.1634863430037; Thu, 21
 Oct 2021 17:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <57c1bcd6-f034-f5d1-f282-a6d843a2937f@gmail.com>
In-Reply-To: <57c1bcd6-f034-f5d1-f282-a6d843a2937f@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Oct 2021 17:43:39 -0700
Message-ID: <CAADnVQLB6t7FwT7OMid63VJCRTorXGi5PJHve-fxd8Tvo6fM3w@mail.gmail.com>
Subject: Re: branch prediction issue
To:     zerons <sironhide0null@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 8, 2021 at 7:30 AM zerons <sironhide0null@gmail.com> wrote:
>
> In check_cond_jmp_op(), the is_branch_taken() is called when
> 1) SRC op is imm
> 2) the value of SRC op is known
>
> Here comes the question: what if the value of DST op is known.
>
> Consider the following instructions:
>
> BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_8, 0),
> BPF_JMP32_IMM(BPF_JGT, BPF_REG_7, 0x7ffffff0, 1),
> BPF_EXIT_INSN(),
> BPF_LD_IMM64(BPF_REG_3, 0x7fffffe0),
> BPF_JMP32_REG(BPF_JGT, BPF_REG_3, BPF_REG_7, 1),
> BPF_EXIT_INSN(),
> BPF_EXIT_INSN(), ==> point_a
...
> The point_a instructions should be dead code. I wonder if the
> verifier do this on purpose. Do we need to handle this situation?

The compiler would never generate such code. It would be optimized.
What's the point of adding complexity to the verifier for an
artificial use case?
