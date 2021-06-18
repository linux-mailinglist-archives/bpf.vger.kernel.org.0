Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27CB3AD132
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 19:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhFRRel (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbhFRRej (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 13:34:39 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC42C061574
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 10:32:28 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id q190so10129791qkd.2
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 10:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cBfJsEOu3CT21muKug/zMTTafz5E9Mj079+J+0XBcIc=;
        b=DxcSWARedybK71u0R2dReXRC7GkMVu74EpPBC4o8qx/TUkEeSCB6s2S4mgqJtOx6Vt
         e2IgGtfEZbK2LkURMyhpJKwVPPEqgnJk/GeE6COjDeWO7Jknh7ODNHrN3cMCl4bJFdJL
         nGyY6zWlkjJ8wTvpbx0e21tz5ZJqYwzUP5bpSqdCn7jl1oTCL5ZTzBGwluP4bWhDblZu
         znn1UdML0ZAifjexATfGzt/Xrfw2ZXuChDVZBRHvIhToTaQqp/sBD0zr1mbtx/QvaDYY
         BJ4dYW1evt4PPaHAA/e6F1vs2zmPfW86h/rlrIKMzudlaLZxgiCjiFfMtE25xbSGhM5n
         RXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cBfJsEOu3CT21muKug/zMTTafz5E9Mj079+J+0XBcIc=;
        b=Z/M6rTomCEsjLt9E2RiYu9PkkrcZYrk7VakaExtZpVqpUfGEbeelPuo3rdeJKzfGKA
         N83v4Dho+duKv9hpNlMU7BNI0gfpoKvJMBB8XgD8wEXF7HX5xmRJbeAJ9FycKdVoJUGa
         vnIjGJwnQdviJ79LeFw4QPMoWaSwH4CQqGZCHr/zN368OjBBu6sMoOx7ZstdRqp4eTRF
         DUCX07b+VlhqTJhr6Csqv61NHXLos1Si04locB4jRouUGmitr9A/5I5JlKKnYUCebkPh
         kKU+XPGZEg5tgm9EmkVplygPl94EeQAgAud3t9TWWdwNw/mdPJnQUfYvtlYGyTiWTRTk
         G0gg==
X-Gm-Message-State: AOAM532xK1U0z5m+YaoRXO7x7+1QroYVEZynNov1zr52fpBP3lhzu4q8
        r0u0vwoXmIB1fRoFldOg6WtAvbH52HB9Z1fkJYI=
X-Google-Smtp-Source: ABdhPJzc5bI1LAo+S6k9meZqsoDyn8bkFIfNL60NfAV6R1DCzXxL1DhjZL5oDqVxO9DwMWcagkDpHj+a02rIdgGHs+Q=
X-Received: by 2002:a25:7246:: with SMTP id n67mr14664282ybc.510.1624037547196;
 Fri, 18 Jun 2021 10:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
In-Reply-To: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 18 Jun 2021 10:32:16 -0700
Message-ID: <CAEf4Bzbt1wvJ=J7Fb6TWUS52j11k3w_b+KpZPCMdsBRUTSsyOw@mail.gmail.com>
Subject: Re: BPF calls to modules?
To:     Alex Ghiti <alex@ghiti.fr>
Cc:     bpf <bpf@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 18, 2021 at 2:13 AM Alex Ghiti <alex@ghiti.fr> wrote:
>
> Hi guys,
>
> First, pardon my ignorance regarding BPF, the following might be silly.
>
> We were wondering here
> https://patchwork.kernel.org/project/linux-riscv/patch/20210615004928.2d27d2ac@xhacker/
> if BPF programs that now have the capability to call kernel functions
> (https://lwn.net/Articles/856005/) can also call modules function or
> vice-versa?

Not yet, but it was an explicit design consideration and there was
public interest just recently. So I'd say this is going to happen
sooner rather than later.

>
> The underlying important fact is that in riscv, we are limited to 2GB
> offset to call functions and that restricts where we can place modules
> and BPF regions wrt kernel (see Documentation/riscv/vm-layout.rst for
> the current possibly wrong layout).
>
> So should we make sure that modules and BPF lie in the same 2GB region?

Based on the above and what you are explaining about 2GB limits, I'd
say yes?.. Or alternatively those 2GB restrictions might perhaps be
lifted somehow?

>
> Thanks,
>
> Alex
