Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D1A32B359
	for <lists+bpf@lfdr.de>; Wed,  3 Mar 2021 04:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352543AbhCCDvE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Mar 2021 22:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350730AbhCBUZg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 15:25:36 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC65C06178B;
        Tue,  2 Mar 2021 12:24:18 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id k12so16655560ljg.9;
        Tue, 02 Mar 2021 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULh96LV2OaSrxc6KmEsgLrWL5YvhH8PzX4MGi2t/P9s=;
        b=kwsrfJN4Qao4f75TPpRIUagrPr3NR40CDupm4idWUUtBseExEDxxZN7wHPeENSwVn4
         j3A4BYkK0H2dTCsddMKXFx//mI2qcdU0LUymO+E7CVRwr2LTsePmtin5nlvvJKq3nsMO
         bFG6pzmxppMeYlF1U9N2Pgg44FVWorzn2laVHUWXlT8fGTdVkAAw/Sc7SkTH6AQLAezH
         kf2VjRbGeZjqvQzVkVWMWiTUM5ClWy0wtCQ+wSgyMzpRQEIMlejzWqWAnpiqMtfIVvo0
         CEZp+gYsOaEWjuu4N/sbyJopv6SyHTpTcV6as7BcnziZI6Oqclp11Up7wie0gL/A1SLc
         8ZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULh96LV2OaSrxc6KmEsgLrWL5YvhH8PzX4MGi2t/P9s=;
        b=VyH046xD1HJr75CbZ32q0yzaNAIk/Rm9IbIHtdIp46u2P92BglbZX79nuQrquUhZK+
         KVpKnJXPX4tpm7CKZuQaJwZwIgvZs4W9FJh60/2XABi8kQN6d0gn+kqkmZaZ2X0bEAEy
         HaYg6p0sZxqFPVs7742DvgFlSPmiDGnTY0FrbH+vnzlaw7fb83/5yLcgaVMAzIbVMGRU
         3nXN4nuTJSdfTiJWvcpCb1BwXgVu4EcJwID6bzhUPHMgS7mRS2tiZNmJNGZkToFSBxV2
         vPuS38+psedDnqg+SlgMw4hSlXlIHL1oveddQlRBU3VOdH67iUtLtoM3DmZdj+XQmgiP
         5cFw==
X-Gm-Message-State: AOAM531P1dllHc1Dsdh2gTPuVhm/LRHcjkVVIUdo4DGHs+xzqvRXGEeg
        MkRO7mj+PU5XqGm+7sVfE40XlcA7en97MXKFfhU=
X-Google-Smtp-Source: ABdhPJx+uYmzLCyoFtxXeh/VC48g3NbZNITdjfoEpLPTTR8Z4jCpxJ6KDaebYgxmCwzV40VzRs50tuFwMl1bgbGmz3k=
X-Received: by 2002:a2e:9704:: with SMTP id r4mr12697751lji.486.1614716657058;
 Tue, 02 Mar 2021 12:24:17 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXzXv-V3A3SpN_Pdj_PNG8Gw0AVsZD7+VO-q_xCAu2T2A@mail.gmail.com>
 <20210301165130.GA5351@redhat.com> <CALCETrU2Rc4ejSoYyWgbk00U8tSc=aZDaj0mm+Ep62wOirZG7g@mail.gmail.com>
In-Reply-To: <CALCETrU2Rc4ejSoYyWgbk00U8tSc=aZDaj0mm+Ep62wOirZG7g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 2 Mar 2021 12:24:04 -0800
Message-ID: <CAADnVQ+czV6u4CM-A+o5U+WhApkocunZXiCMJBB_Zbs0mvNSwQ@mail.gmail.com>
Subject: Re: Why do kprobes and uprobes singlestep?
To:     Andy Lutomirski <luto@kernel.org>, bpf <bpf@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>, X86 ML <x86@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 2, 2021 at 10:38 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Is there something like a uprobe test suite?  How maintained /
> actively used is uprobe?

uprobe+bpf is heavily used in production.
selftests/bpf has only one test for it though.

Why are you asking?
