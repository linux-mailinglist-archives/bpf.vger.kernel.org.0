Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C796A0EE3
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 18:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjBWRq6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 12:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjBWRq5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 12:46:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE0A59436
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 09:46:47 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ck15so46333781edb.0
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 09:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MWrkMq6UMGZVQ5TH4LMI1UyZOhdYsyPfnrsHy5Q4eM0=;
        b=VRbcGHRHARx/cSl0ldTerLCd3OE5zQQmuFKnjuuhPNq/5xXTSl3fKWvnBg/yOO2jxc
         Sj+YKk/ucwZyWQ983SbyXra4EI7MUdxxLI1fYRnw1Dw/yDIgSZSMjNU3j0fQpx6XTJ09
         5mMrtNUHtQ+YKkVRjvxa5UVR4zyzv6AuX8rvnbBkiKf8H8V0MO1yMd5RI4wLSggKyaaS
         Wn1xiPeoLCBpM+eJkAIhbyTsJ1gBExyMJrvmowWo2hsjL/Fsj9LN0DWmtBHfEAgxIgCH
         uo7KaatG56TPPQ5OaApGH9eM4cLgrnUT6i7ecsfCSSu9NFPcu7sMaz5wm5+nxbDt2MBU
         ln5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWrkMq6UMGZVQ5TH4LMI1UyZOhdYsyPfnrsHy5Q4eM0=;
        b=mhTEpD9WC7VrRd0/SneUOcDL6WkOibgTXBeJqHjXkwpseEYUMYbiIdyMaj3Z6h9k03
         Er5M8z9DnakcUyTF5MXCfY0HLrDvUq15Nt/ZwHx7QiyIsP6X7ZMKHUphwBlWaWzRuGoB
         Yrp1gbKVjGR1Zrxzw+Oql8XxNEbZhwDN/HdcrrSjaYMSYWHvbiUWFdtLC8GBEqVJPjQr
         rjp3/5pZLVfZiMUX0QOEcZ7NA3uzYIDTvNYHp3NQL1ViR4rjmikTTRh9JNpMGCKDsIu0
         gzwi/Yjc9ZcD1ksXbKMP5hrT/gy+YVcNrmAgNmL22q43qxcBkxRFrW1WkcxIMtW/TbGk
         5rJA==
X-Gm-Message-State: AO0yUKXrGjKuVvJF2c7dlAf/3uol/4VpZ5c6Jxw4UJwXkZiNXgOufEkA
        Du3xU4MZx/MS+UifPlimn0kflZESpA8+w/pkhNz125sO03w=
X-Google-Smtp-Source: AK7set85IypKz20KILmW4qga8ZlQG/7rnmHyXIInzDVdpmZkKK71rR2wQ2jDAgfhBJz53LOvYQV9isTe4+/H0KqzRp0=
X-Received: by 2002:a17:906:eb4d:b0:87b:dce7:c245 with SMTP id
 mc13-20020a170906eb4d00b0087bdce7c245mr9320574ejb.3.1677174405908; Thu, 23
 Feb 2023 09:46:45 -0800 (PST)
MIME-Version: 1.0
References: <0838bc96-c8a8-c326-a8f0-80240cf6b31a@linux.intel.com>
In-Reply-To: <0838bc96-c8a8-c326-a8f0-80240cf6b31a@linux.intel.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 23 Feb 2023 09:46:34 -0800
Message-ID: <CAADnVQJ4fHzqeuhbCF5SDR5V1Ktku=U2RRRPLc17ia0aFgNG=w@mail.gmail.com>
Subject: Re: bpf: RFC for platform specific BPF helper addition
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Thu, Feb 23, 2023 at 5:23 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>
> Hi,
>
> Some background first; on x86 platforms there is a free running TSC
> counter which can be used to generate extremely accurate profiling time
> stamps. Currently this can be used by BPF programs via hooking into perf
> subsystem and reading the value there; however this reduces the accuracy
> due to latency + jitter involved with long execution chain, and also the
> timebase gets converted into relative from the start of the execution of
> the program, instead of getting an absolute system level value.

Are you talking about rdtsc or some other counter?
Does it need an arch specific setup?

> Now, I do have a pretty trivial patch (under internal review atm. at
> Intel) that adds an x86 platform specific bpf helper that can directly
> read this timestamp counter without relying to perf subsystem hooks.
>
> Do people have any feedback / insights on this list about addition of
> such platform specific BPF helper, basically thumbs up/down for adding
> such a thing? Currently I don't think there are any platform specific
> helpers in the kernel.

Right. That's one of the reasons we don't add new helpers anymore.
Please use kfunc instead. You can add it to:
arch/x86/net/bpf_jit_comp.c
like:
__bpf_kfunc u64 bpf_read_rdtsc(void)
{ asm ("...
or to arch specific kernel module.

Make sure to add selftests when you submit a patch.
