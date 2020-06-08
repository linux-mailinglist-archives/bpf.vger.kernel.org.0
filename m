Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB771F1C73
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 17:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgFHPym (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 11:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgFHPym (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 11:54:42 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7252AC08C5C2
        for <bpf@vger.kernel.org>; Mon,  8 Jun 2020 08:54:42 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i1so16032037ils.11
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2020 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kLKPwVpWorCw8nCW5DpXWIGBbAVjNFGZ0QtGfMbrHE=;
        b=J51dzEmSRHNYKF+nyTk80O/dpZgtTQgB8P7TA4mVvB61vMVNhvJgafHEmgSZ/BkH9q
         ni44N9QWPDardIEAuzrbV4jRkSWdNq4uLWYRTlXHJ8ogS5gSOLi5gvXJVL5kPWPXRcIz
         CBI0j1Hg7+/TNpgoYnh+rgcbVbaSHI2IuCKfFPwBBIfgekKfSkplK2OlsTQHVNa+edCk
         0sIi5PMrMlEWzGiMGAICYRtHQV79zFH2iGhW5rdhA8mOBxpqV74Tj0iYV3wVMbV/Y9Xa
         GiRdmgNrl/DN5le6DfgiIWhL6XDhCXvwh2OyzR+YKy0u0ZbZRoesiw4qoirI68I0jBZD
         TGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kLKPwVpWorCw8nCW5DpXWIGBbAVjNFGZ0QtGfMbrHE=;
        b=Qnb68v1ysRKBbQbQQLa1lzStLBaJWbnLRmVuMFH0+CXjOlCLrI7tm1YUxZIL7MwY30
         W++3rSAK80g9YrsRjC2m/AkTGSKOmOPgFqGH8kNksI23GNFrmmfPG5zy/DEp9QFkd9dB
         Mm6r9/O/r1HGKw0ud7A+9fasYMePsGKhJsenMJJocB0Fb8mOcrerHE4ILeg/rMRbjovE
         3W/Dq/NUgKL1cUYgrFtkLgyzL3IwGNFxSljsSDZVrJAB2906KweQ+0t5Pue2ifrBb3B+
         1PgC9XT1J8+TfH119rBpmkTa6THI14DhpyNRXL/XDLyrkR1IcNj02PE9Ecs67ATYpC2K
         LI7A==
X-Gm-Message-State: AOAM530oYAvPC9T2UCdA5SnNAlv6ZTRsNUURX2KegiZ2IDgXbQ+Dwo6b
        36JSjnEFyhBUwj7vpyLUso4XYigmtdD5jbvC+WVz37rzomU=
X-Google-Smtp-Source: ABdhPJygA96lynH4xQx878uXyR+SQgP8Fqiah78LngAI78+6ArbF568c4x5hcF+jMLU1U76U9Xtsto4gXEFJLDwm9qY=
X-Received: by 2002:a92:c60b:: with SMTP id p11mr15972973ilm.137.1591631681394;
 Mon, 08 Jun 2020 08:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591315176.git.zhuyifei@google.com> <4f13798ae41986f8fe8a6f8698c7cbeaefba93b0.1591315176.git.zhuyifei@google.com>
 <8b8290bf-2691-4c1e-07ae-e3262ef25632@iogearbox.net>
In-Reply-To: <8b8290bf-2691-4c1e-07ae-e3262ef25632@iogearbox.net>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Mon, 8 Jun 2020 10:54:29 -0500
Message-ID: <CAA-VZPm687Okro3D+RUGfE9UBgV4auGn+uBWAfp8RZtXoCkU-A@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] net/filter: Permit reading NET in
 load_bytes_relative when MAC not set
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 8, 2020 at 8:56 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> Couldn't you run into the case above where the passed offset is large enough
> that start + offset goes beyond end pointer [and then above comparison is
> performed as unsigned ..]?

You are right. I missed that offset would be large and make start +
offset > end,
when I was trying to reason the offsets and overflows. I just checked
that on x86_64
it emits a 'jg' instruction on x86_64, and the test I tried with
offset = 0xffff does
return -EFAULT. However, I searched around and saw that this is due to integer
promotion of len and the test would fail (i.e. not returning -EFAULT) on x86_32
(I have not tested this).

> (At least on x86-64, the 'ptr + len <= end' should
> never have an issue [0].)

Alright, I see that len is an ARG_CONST_SIZE, which would be checked by
check_helper_mem_access, so it is bound by the stack size. So the argument
against ptr >= start also applies here, correct?

YiFei Zhu
