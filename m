Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5302A4ECA
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 19:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKCSYh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 13:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCSYh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 13:24:37 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33553C0613D1
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 10:24:36 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f38so14342346pgm.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 10:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jrvbh3YOoZQsUsIs/l5aQKcqL7qcnb4+3O0sfZNwUfY=;
        b=hXPTTKWf1og5l86CNbUz5beEHB6aiBmaLagpmpB9Uo3XKpAKRVGGt+m/gBZ1XhHOD9
         xWHaM+aWVEj8l8S0MRxcs9z7p6F4Vu8H+SK4eUGb9rvDLPiXblN+oMJI7cXPdSZp2aiO
         Q+pXnwJ8VL9AAzgG10pD18mDz3NOQ4DpU2nwSkU4s66rUawNmILWP1xJPqbo3m3I7bCC
         3aNgtZ5Dhna5Q638S8p1ZHe7H3DnhMFTuS15fxlKpf5CcQh0azniR0SAmC6atINfcc5g
         BeA3Iwv1suzLmoyzvJVZdvLi1zbvQ2j9s5KnBPpwedwARkQFloZRp7+pqkQr9nEQhsSf
         oX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jrvbh3YOoZQsUsIs/l5aQKcqL7qcnb4+3O0sfZNwUfY=;
        b=iAGCGctIGUBd6fB9T5Upc7qkf771QApbPp3Ta4rLnP1pHMbr0dihtC/XBnGx+JX1nS
         EifI/xphcFiX7mfHaiwv1BxMcl39P6VyXBiURzYDIryc9oWIwZjb5/3Lp8n8YYuCul9r
         6jpoU5Da3vPxw8EG4vT0XVNQUhS5RV96v/+O09hFfiuYPqR9p5N3aCHZTvmJnvKPTdj2
         8fwmqlpLh2fwmUQxcPP7GOcKg49r1KQ0OHkUmH3KR2T8NENMKknAcmpHlbHcpAjtFn3s
         z2rRHdHbVYpasYE/8Z1D/CpTv9p8tXGq8MYrC5UAEGp+hXQHN6F7OQIA7ZMQWxMFvPSx
         Zz6A==
X-Gm-Message-State: AOAM5312jiTaTr0ONtfgXV+J7WeBoV5L6gUI/RZ84ZrFaCPutAsor/DI
        LtsCSXrltwHzHa62YT4RRCQ=
X-Google-Smtp-Source: ABdhPJxIq4PoE2PKW4egDPr8WtxQbs09MNLiF1jMIgbEan80G1ZZ1G9wfa9aJ0zi1yeUG2nITZHbPA==
X-Received: by 2002:a17:90a:3fcd:: with SMTP id u13mr466388pjm.85.1604427875693;
        Tue, 03 Nov 2020 10:24:35 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4055])
        by smtp.gmail.com with ESMTPSA id x26sm17865020pfn.178.2020.11.03.10.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:24:34 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:24:32 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, andrii@kernel.org
Subject: Re: bpf_probe_read*str() may store junk after NUL terminator
Message-ID: <20201103182432.yjgfzf25prdhhnmf@ast-mbp.dhcp.thefacebook.com>
References: <C6TTDYNLD7UX.P2O6PJF7OC39@maharaja>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6TTDYNLD7UX.P2O6PJF7OC39@maharaja>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 03, 2020 at 09:45:41AM -0800, Daniel Xu wrote:
> Hi,
> 
> I recently received a bpftrace bug report [0] that identical strings
> were being stored as separate entries in maps. I dug into the issue and
> it turns out that bpf_probe_read*str() may store junk after the NUL
> terminator due to how do_strncpy_from_user() does long-sized copies.
> 
> Here is the code in question from lib/strncpy_from_user.c:
> 
>        *(unsigned long *)(dst+res) = c;
>        if (has_zero(c, &data, &constants)) {
>                data = prep_zero_mask(c, data, &constants);
>                data = create_zero_mask(data);
>                return res + find_zero(data);
>        }
> 
> This behavior is likely to cause subtle issues in bpf programs so a
> kernel fix may be necessary.

Looks like progs/pyperf.h will hit this issue since it's doing:
get_frame_data(frame_ptr, pidData, &frame, &sym)) {
      int32_t *symbol_id = bpf_map_lookup_elem(&symbolmap, &sym);
where get_frame_data() is doing:
bpf_probe_read_user_str(&symbol->file,
                        sizeof(symbol->file),
                        frame->co_filename + pidData->offsets.String_data);

progs/profiler.inc.h and progs/strobemeta.h look ok, because
they append to the end:
size_t comm_length = bpf_core_read_str(payload, TASK_COMM_LEN, &task->comm);
payload += comm_length;
and as the last step do:
unsigned long data_len = (void*)payload - (void*)data;
bpf_perf_event_output( ... data_len);

John,
please review cilium uses of bpf_probe_read_str().
You might be hitting this issue as well.

Certainly the kernel fix is necessary.
premature optimization is the root of all evil.
