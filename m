Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB63ACDBA
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 16:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbhFROnz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 10:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhFROnz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 10:43:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84326C061574
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 07:41:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id r16so14350261ljk.9
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 07:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCBR6BF7LMg2tHmudh4GAfsetx7z27keqs+ygzFCjtA=;
        b=sPSVqFHpyGDS1pJSPPAZ4Oo4ATO6x61Ylou1imOHKo3v5SNqSdVWYCLo7xca+OpsRj
         TGwZc7SeNCiZHnb+KdLF9/Ozj27ruT7OdVPgIRandTbsus7EP1zhyHYNgLqzwQnaT6EN
         OytIvX1pKK5kK/KFjWE776Ey/NJiX731r3cVBRgYJxXwt2/p6ePVbib63R2F9TGg785J
         /woRk4WVj3QDjojokp10gbU+P4ZYqgIO4ESKPK0RIJk4o2Odjg9XAXbeZRn+HEEU4B2L
         l0LnMjmhALevBqCsVIbeH8J4l9+fdcUm6vePPiYnjW17shU+Hh9Y+nvwZg2eJx2KPzXX
         1coA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCBR6BF7LMg2tHmudh4GAfsetx7z27keqs+ygzFCjtA=;
        b=SP2whG6QoHiz9ZA7au2zib4qXwBmpSMvB7OoB7UhJqz0ZKV4pkRMpk271W8xMbU3yr
         79S1RrWFnSD1gmqUew570fSrEAwo65WamQG4c914J3fRH32nhU7EhmaFXnta0leXpt9d
         VNxY0dJ/6HsyvCvjxg5177V5i1ZbFS9sR7Vm+rI5CIUUbX/VRIewkLrpp90Jd3yPwGsu
         5gXcJvAQIjvp0jZ7VnV3MSnPmsugu4RKx4HT/3WR0ACLMgT3nt0hZYOQo7SziwzdZdL1
         oIrR8MSZy/Lxk9an7Kjyaf40C8pl/hy42w6v7wwtltVswUXwz/p5ONBOPcMHRQEF2PTD
         IkCA==
X-Gm-Message-State: AOAM533znSLFzMEkVjoVW1dg3uo50enka7IkyeNsARZfe15S27m0MemT
        zxigDPi08jSYNkHQoY+ce4gmpMlyLqygOxnC2hUAo7Zk
X-Google-Smtp-Source: ABdhPJwDaWLdcgnm7urD4xF7QHY0puKhEk51aK7yzkLQvmeZ4TBahZO+dxRodS4f3du8FBcEsCBvS4VRXQl2qAAjMLY=
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr9754541ljn.204.1624027303930;
 Fri, 18 Jun 2021 07:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
In-Reply-To: <aaedcede-5db5-1015-7dbf-7c45421c1e98@ghiti.fr>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 18 Jun 2021 07:41:32 -0700
Message-ID: <CAADnVQLTDXQkeCMJhz8ar76-XphrsA9uAqy9oGSb2B7Eg--y5w@mail.gmail.com>
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
>
> The underlying important fact is that in riscv, we are limited to 2GB
> offset to call functions and that restricts where we can place modules
> and BPF regions wrt kernel (see Documentation/riscv/vm-layout.rst for
> the current possibly wrong layout).
>
> So should we make sure that modules and BPF lie in the same 2GB region?

Ideally yes. bpf programs can call functions in modules and vice versa.
riscv can keep them in separate regions, but then riscv JIT will get more
complicated and run-time overhead of the function call will increase.
