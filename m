Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47CAB296634
	for <lists+bpf@lfdr.de>; Thu, 22 Oct 2020 22:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371987AbgJVUwf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Oct 2020 16:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371979AbgJVUwe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Oct 2020 16:52:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E49CC0613CE;
        Thu, 22 Oct 2020 13:52:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n16so1711798pgv.13;
        Thu, 22 Oct 2020 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ag5R8ANFXiIKHrZi3CpUKkJaLv+KTVPp7lGufqkGA/Q=;
        b=d6+CBZngB4ab2gx0rcr80/mUgsqGHrDfBj1/ysacUwotFwRiXDdiFVeXasFIZHuxHV
         1x42nCvwwG6yQagKIIf1tCqN7+6tPyMBG1vriokW70nyWmsc8sMnME4tilAanNACPt9O
         UzNtsCl8lGUuz9Im9a2MYKC37+MOa7tXY3edPXllbkN0hCEGFSQJnOVjVtVIAq/+HJLn
         puZeL7mEq755h14QQNrKiJO3EdeJ0uF64975sPV2JD6dBoaXPh5ct0LHO4hygeT08KGT
         jSXmP5u+fSJpVAIRfAuEVSd0XPlAxR+NDLBHr9Bh1K2r/SHLCD+LPnn7xcu4RCGkQK5K
         2CnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ag5R8ANFXiIKHrZi3CpUKkJaLv+KTVPp7lGufqkGA/Q=;
        b=O7JKExU18i8h5t8FeQ8pekLfr5vW2QMhyLht6agAp/FCfedQiX1tERjHcDGH5Vl1ms
         /iDDBfd3SqQblaN2Me8KYjcPG3XgwZmnGrAY/la8HnDP9kFFa+Z1dIs8kMtajVgqIZgs
         ElPdcFs0WEME/jCuw8+lnIXiSnragfrTIAK0zjPBdewhsCMA2KA5csWfSgCfy+ZDZeKQ
         LpWqMFIGS2pTEKqZ8cNCKciTgjGfwDFJnLxiZrkmRghycAhexEvTMnf1N9bZifJFUNeu
         Wn0OYyz7gsfzhs3ZAQkqmwzVtp+jMdPYwQRKihIeJNNurB7kKUg03SxWx0oMnElk9Vjp
         GGHA==
X-Gm-Message-State: AOAM530BAvB8+L1wcG2mL/k74EuzqT7M8tz1WYF57kwpaMaK7bW/YGnL
        iVCOHIX5+ZW5q2+oLYt/iDvvBX2Pi1z4WfvaMzc=
X-Google-Smtp-Source: ABdhPJx+dBEdcJ+BztG+kLdnt+vX7FpE4LlJQH01ipc7IDV0pS9xsoGFMHkw/BUBCjO1GOwzT0IU3w3pZk202vhKcQg=
X-Received: by 2002:a17:90a:f184:: with SMTP id bv4mr3823913pjb.1.1603399952372;
 Thu, 22 Oct 2020 13:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602263422.git.yifeifz2@illinois.edu> <c2077b8a86c6d82d611007d81ce81d32f718ec59.1602263422.git.yifeifz2@illinois.edu>
 <202010091613.B671C86@keescook> <CABqSeARZWBQrLkzd3ozF16ghkADQqcN4rUoJS2MKkd=73g4nVA@mail.gmail.com>
 <202010121556.1110776B83@keescook> <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
In-Reply-To: <CABqSeAT2-vNVUrXSWiGp=cXCvz8LbOrTBo1GbSZP2Z+CKdegJA@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 22 Oct 2020 15:52:20 -0500
Message-ID: <CABqSeASc-3n_LXpYhb+PYkeAOsfSjih4qLMZ5t=q5yckv3w0nQ@mail.gmail.com>
Subject: Re: [PATCH v4 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 12, 2020 at 7:31 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> On Mon, Oct 12, 2020 at 5:57 PM Kees Cook <keescook@chromium.org> wrote:
> > I think it's fine to just have this "dangle" with a help text update of
> > "if seccomp action caching is supported by the architecture, provide the
> > /proc/$pid ..."
>
> I think it would be weird if someone sees this help text and wonder...
> "hmm does my architecture support seccomp action caching" and without
> a clear pointer to how seccomp action cache works, goes and compiles
> the kernel with this config option on for the purpose of knowing if
> their arch supports it... Or, is it a common practice in the kernel to
> leave dangling configs?

Bump, in case this question was missed. I don't really want to miss
the 5.10 merge window...

YiFei Zhu
