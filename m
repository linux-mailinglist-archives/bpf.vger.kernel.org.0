Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B044E135
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 06:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhKLFDt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 00:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhKLFDs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 00:03:48 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53D2C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:00:58 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id k4so7455094plx.8
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 21:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AxWIPqvrkawTlpH0UCSDFgc90SjLWmUpo4cVzvWCBZA=;
        b=dx72wLItbhvWjSOL/VSxGFyc49tPbn81pmaDo8KYC6Qj8nxdl5M0YkEELMrc3d+ElD
         TSxyrKnTHmtwKBTTa4QzgtxjSvF0LMw3WV1+D2ZBqfOP44BvrkR2uvlozuRfW+MfRon7
         rHjpmm4LzQzkA9uasOGOaSs0pllaS0plbnKb6qmhx+D8eD+5BbV1IJOgqasFXgh3NZyN
         tsFZuoLWPXJljI999k4qaa2FZxKJlIW35ml96I9WE2KjU3rqvXIoawoebXAs2mjSGecS
         Mv3TgLZYBnvE9pC1X0WJUs/GUNwfPpp8fC7iocdX8+x6fuWCHkjtyOnEQUE+iLArlFFR
         CWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AxWIPqvrkawTlpH0UCSDFgc90SjLWmUpo4cVzvWCBZA=;
        b=TWex5GR7G28NSPy9uwUPTOMKserNCutObQW9mh3YR6vmOA51e/BiB15mFCw77YFqrE
         UbSqiPGXE4ybUKAOibzLDY4XvuUFXKOfWjfo0AdcIQOP8EiMLcaQM4RCEBW+9OwHjoQ/
         67k3ZuDGqtTjAkqkzcgPm0qNiqxf2Xw1l46UnNeOMgv547/xbEWgiiv0GqTYmMiDa+5A
         lBNF+GfsSFOjjJkvXeprBoMxqGOT72x7s4nFdPVaufAUAZBUKSSkBJoUxx/Uh7F03foR
         b0C0cjJ46QCQAEJi7ewka6l8KT5TdiT5jt6xuJZJn282mwCjCaeDxgnn6p8+ETFwoJAh
         LBnQ==
X-Gm-Message-State: AOAM531G7FCuK/ERn2V1bhzcChy0GryzXy2qjCTfCdqJkwXUwCjxja7p
        0Zb/S8gCgw5yjqjsss3g8vSFMVzxUZKzAw==
X-Google-Smtp-Source: ABdhPJyfEeVP4nQuKH3ttG9m12EQV8pP289Ks5a5w5jiQ0vMymmW/1vi5e6uRFkhXc6RZTApoYy/kA==
X-Received: by 2002:a17:90a:c58f:: with SMTP id l15mr33515063pjt.75.1636693258098;
        Thu, 11 Nov 2021 21:00:58 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id t66sm4572660pfd.150.2021.11.11.21.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 21:00:57 -0800 (PST)
Date:   Fri, 12 Nov 2021 10:30:55 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: fd leak in lskel
Message-ID: <20211112050055.l33meilakhvq4nco@apollo.localdomain>
References: <CAADnVQJ6jSitKSNKyxOrUzwY2qDRX0sPkJ=VLGHuCLVJ=qOt9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJ6jSitKSNKyxOrUzwY2qDRX0sPkJ=VLGHuCLVJ=qOt9g@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 12, 2021 at 07:56:23AM IST, Alexei Starovoitov wrote:
> Hi Kumar,
>
> I think I noticed a small regression:
>
> $ bpftool prog load -L ./test_ksyms_module.o
>
> will print:
> "loader prog leaked 2 FDs"
>
> That's a builtin sanity test in bpftool that checks
> that loader prog is doing the right thing.
> I suspect the cleanup path of ksym patches is leaving FD opened.
>
> $ cat /sys/kernel/debug/tracing/trace_pipe
>          bpftool-1356    [002] d..21   175.537998: bpf_trace_printk:
> btf_load size 1895 r=5
>          bpftool-1356    [002] d..21   175.538085: bpf_trace_printk:
> map_create test_ksy.bss idx 0 type 2 value_size 4 value_btf_id 32 r=6
>          bpftool-1356    [002] d..21   175.538108: bpf_trace_printk:
> update_elem idx 0 value_size 4 r=0
>          bpftool-1356    [002] d..21   175.538165: bpf_trace_printk:
> map_create test_ksy.rodata idx 1 type 2 value_size 4 value_btf_id 34
> r=7
>          bpftool-1356    [002] d..21   175.538187: bpf_trace_printk:
> update_elem idx 1 value_size 4 r=0
>          bpftool-1356    [002] d..21   175.538191: bpf_trace_printk:
> map_freeze r=0
>          bpftool-1356    [002] d..21   175.540873: bpf_trace_printk:
> find_by_name_kind(bpf_testmod_invalid_mod_kfunc,12) r=-2
>          bpftool-1356    [002] d..21   175.540876: bpf_trace_printk:
> func (bpf_testmod_invalid_mod_kfunc:count=1): imm: 0, off: 0
>          bpftool-1356    [002] d..21   175.540877: bpf_trace_printk:
> func (bpf_testmod_invalid_mod_kfunc:count=1): btf_fd r=0
>          bpftool-1356    [002] d..21   175.543305: bpf_trace_printk:
> find_by_name_kind(bpf_testmod_test_mod_kfunc,12) r=-2
>
> I see this leak with other tests too as long as they fail to load.
> On success the cleanup of FD is good.
>
> Any idea?

Ack, I'll take a look.

--
Kartikeya
