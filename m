Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849584FFCB3
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 19:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiDMRcD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Apr 2022 13:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiDMRcB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Apr 2022 13:32:01 -0400
Received: from mail-pf1-x463.google.com (mail-pf1-x463.google.com [IPv6:2607:f8b0:4864:20::463])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A8E13CDF
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 10:29:39 -0700 (PDT)
Received: by mail-pf1-x463.google.com with SMTP id w7so2567795pfu.11
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 10:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=Q6Uyx/u17kfyEFowJ70jn1vY1Zh92wKlmKeaXmuE8wQ=;
        b=LXeW7p6ot6s5EK1FvTGgUW2H9Uq5oUcRuocavPUBIR4Jpa+8b1JcIePwo81osm+VFB
         wWkTwPscfqA8qcvsBuQSY5oSUHq3h7UiE5neQfGn+S87yDN5CtLk52cDMEqZIw4aaKtz
         uIPI1BArEy1nxgFI560C9r41FL3nG3khl0oxv+k2DNBaDpHGYpSNpARmRq6sybW+RHVK
         HxQl4+GGF/Mt4klHi0Pp6zWGfWHjsb4nSHANJUdYKhltalpfsbP3iGlPannUkDhlzk3u
         5i4HdCS39+2HXrAKpHI3uEodKatm7MjTXbDFzPTCJe0xCF5lkDp6x2Y/vtkjkJOFsOfm
         HeFQ==
X-Gm-Message-State: AOAM531w1LxRLZp7nfJEt4jDawy6msb1XqOxPZMT5T9neJTS5BtWLy/F
        Q3DuPhsj5xDWI26f8LBdQvgTxmbg+JnpMUGfxOjB6QDofJs/FA==
X-Google-Smtp-Source: ABdhPJzwBC8QCECQXNjMg0Pmq6ERfERwywfUy0/uKTFfxD7ogAxqOyts2zTGHrBEdA4qUMYlHBS554MA5v0k
X-Received: by 2002:a63:9711:0:b0:398:5cf2:20bc with SMTP id n17-20020a639711000000b003985cf220bcmr35491530pge.480.1649870979465;
        Wed, 13 Apr 2022 10:29:39 -0700 (PDT)
Received: from netskope.com ([163.116.128.204])
        by smtp-relay.gmail.com with ESMTPS id r15-20020a170903020f00b0015489a65952sm523768plh.31.2022.04.13.10.29.39
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 10:29:39 -0700 (PDT)
X-Relaying-Domain: riotgames.com
Received: by mail-pf1-f200.google.com with SMTP id x2-20020a628602000000b005057a9b1675so1682434pfd.15
        for <bpf@vger.kernel.org>; Wed, 13 Apr 2022 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6Uyx/u17kfyEFowJ70jn1vY1Zh92wKlmKeaXmuE8wQ=;
        b=luIkG1BmzCwV+XUFke8Swm8J+If+cb0J4WwYCann818syunt2KefhrkrYzHsPoNDLJ
         X9Bwpow7Kz4RCfb6YaXToB9nkKfwqyZbES0OA5MDsytc01MiTzlla6ngUkaPflnJHvwG
         DhEGHlkvPTl5ALa9FAGwVPCjDnkQroEviwNqw=
X-Received: by 2002:a63:3441:0:b0:39d:a27b:e594 with SMTP id b62-20020a633441000000b0039da27be594mr6337690pga.98.1649870977963;
        Wed, 13 Apr 2022 10:29:37 -0700 (PDT)
X-Received: by 2002:a63:3441:0:b0:39d:a27b:e594 with SMTP id
 b62-20020a633441000000b0039da27be594mr6337678pga.98.1649870977705; Wed, 13
 Apr 2022 10:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <ceeb6831-7b2e-440b-69d9-3b46c7320b3c@suse.com>
 <CAEf4BzY6NXqsOVLLiaoGS2vv7S2eNeP1BQFh9cbPffJbf-2X5Q@mail.gmail.com>
 <7e7b5534-934c-f0fc-11c0-1d00560a4100@suse.com> <CAC1LvL2VZoik563Z8N_o49hyTA37iLsHi+O-gM7x8_rfrWth=w@mail.gmail.com>
 <28743474-02be-950f-a0ed-cd8fec42ca85@suse.com>
In-Reply-To: <28743474-02be-950f-a0ed-cd8fec42ca85@suse.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Wed, 13 Apr 2022 10:29:25 -0700
Message-ID: <CAC1LvL2YpBZxt33bnmHsTYRDbZwSwvPxLP251YrPZRQXDOANOA@mail.gmail.com>
Subject: Re: Error validating array access
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 13, 2022 at 12:08 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> <snip>
> >>>>            // Add this dentry name to path
> >>>>            struct qstr d_name = BPF_CORE_READ(dentry, d_name);
> >>>>            // Ensure path is no longer than PATH_MAX-1 and copy the terminating NULL
> >>>>            unsigned int len = (d_name.len+1) & (PATH_MAX-1);
> >>>>            // Start writing from the end of the buffer
> >>>>            unsigned int off = buf_off - len;
> >>>>            // Is string buffer big enough for dentry name?
> >>>>            int sz = 0;
> >>>>            // verify no wrap occurred
> >>>>            if (off <= buf_off)
> >>>>                sz = bpf_probe_read_kernel_str(&string_p->buf[IDX(off)], len, (void *)d_name.name);
> >>>>            else
> >>>>                break;
> >>>>
> >>>>            if (sz > 1) {
> >>>>                buf_off -= 1; // replace null byte termination with slash sign
> >>>>                bpf_probe_read(&(string_p->buf[IDX(buf_off)]), 1, &slash);
> >>>>                buf_off -= sz - 1;
> >
> > Isn't it (theoretically) possible for this to underflow? What happens if
> > sz > 1 and sz >= buf_off?
>
> No, because sz is bounded by len since bpf_probe_read_kernel_str would
> copy at most len -1 bytes as per description of the function. Since
> we've ensured len is smaller than buff_off (due to off <= buf_off check)
> then sz is also guaranteed to be less than buf_off.
>
> <snip>
>

That's in a single iteration, though. Each iteration, sz can be 4095 (when
len = PATH_MAX - 1). buff_off can be reduced by up to 4095 (1 + sz - 1). Your
loop allows 20 iterations, which would be a total adjustment to buff_off of
77,786 before the last iteration. This would cause buff_off to underflow (it
starts at 32767).

> >>> IDX(off) is bounded, but verifier needs to be sure that `off + len`
> >>> never goes beyond map value. so you should make sure and prove off <=
> >>> MAX_PERCPU_BUFSIZE - PATH_MAX. Verifier actually caught a real bug for
> >>
> >> But that is guaranteed since off = buff_off - len, and buf_off is
> >> guaranteed to be at most MAX_PERCPU_BUFSIZE -1, meaning off is in the
> >> worst case MAX_PERCPU_BUFSIZE - len  so the map value access can't go
> >> beyond the end ?
> >>
> >
> > If there's underflow in the calculation of buff_off (see above) then
> > buff_off > MAX_PERCPU_BUFSIZE - 1. Which makes off no longer bounded by
> > MAX_PERCPU_BUFSIZE - len, and it could exceed MAX_PERCPU_BUFSIZE.
>
> As per my rationale above I don't think buf_off can underflow.
>
> >
>
> <snip>
