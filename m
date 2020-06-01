Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710091EA61E
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFAOnN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 10:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgFAOnI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 10:43:08 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEB9C05BD43
        for <bpf@vger.kernel.org>; Mon,  1 Jun 2020 07:43:08 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f95so4742201otf.7
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2020 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7T1PGmh2GlJDxRPXRQCPy/PB6f/6QowYBQE6SPg8CfM=;
        b=E/w4KfaBQQy626UH3TDZrfQCEgEe8MxCqmQ4xt8EvLHGLP8Sgb/m9CdNdQ7sJHTIJA
         RoXrTUjYo+i2uWh5IfhwVPopn4b/v+20wadSqGwblXkkT347UdwFOQMvBa15kY7bg6hI
         WGzrDmdd3m39UfYQ/SJ6yFZo4tPBhAIG5iU5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7T1PGmh2GlJDxRPXRQCPy/PB6f/6QowYBQE6SPg8CfM=;
        b=PxUOI8TfeMIrU8ucIvMOG8Q2E2ofVeG/lYWKgttNFzTv6WQ+kPygIJjq+ruhfLB7HH
         OyWn3sFCzDNxBrn/a1B0Zlfn7ULtTLBeoHKBt5PfXhf6IIma75B/xjlEdxDySPBZcSTn
         l6EbWvT4CIs9Iw+5ZP8UhTHlEZLLMrPRd9X0ETjLWAz/Ojd7VoiDEYhcUfEbK3rHSm5y
         ynDn8WHJsQhfzj35YchpEIFs7tEh5wZw7UqhaI+OvSRh2ExQZeX9jsJbZsbQIOfv0nTR
         cTsb3BuzGlwEPc+DKIMlssAjb4Zx5vHgHSoYZBG6T87m1mKFVIjyGT9lYsbXOXZHafN0
         f99A==
X-Gm-Message-State: AOAM530ugCxMyccG78SERdItFrut9tCPMv34ae+lrTuRkEDdUHLJ2P2A
        fw3nZ4wKtdEZXzFghbjvHBPvIggZY6sg8WPmMWQTEJ75JtU=
X-Google-Smtp-Source: ABdhPJxkURW3NMcGxoJ3VpEUkKyrup+jP/IyNUf1PvHPe/mBx8Axz35jnlJO5gn04xhOTP06cBbA3C4R1GH9uZOno4o=
X-Received: by 2002:a9d:a4c:: with SMTP id 70mr17796043otg.334.1591022587248;
 Mon, 01 Jun 2020 07:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw99G8vWfZAxy5ohapnTgwndzDrBeTARvxyrO6xopoW98yQ@mail.gmail.com>
In-Reply-To: <CACAyw99G8vWfZAxy5ohapnTgwndzDrBeTARvxyrO6xopoW98yQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 1 Jun 2020 15:42:56 +0100
Message-ID: <CACAyw98Stt_Ch3nFZ26UO9qDoCL46w-bt73G==NH=bMieCwBPw@mail.gmail.com>
Subject: Trouble running bpf_iter tests
To:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For some reason the initial e-mail wasn't plain text, apologies.

---------- Forwarded message ---------
From: Lorenz Bauer <lmb@cloudflare.com>
Date: Mon, 1 Jun 2020 at 15:32
Subject: Trouble running bpf_iter tests
To: Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>


Hi Yonghong,

I'm having trouble running the bpf_iter tests on bpf-next at 551f08b1d8eadbc.
On a freshly built kernel running in a VM I get the following:

    root@vm:/home/lorenz/dev/bpf-next/tools/testing/selftests/bpf#
./test_progs -t bpf_iter
510 bits_offset=640
    #3/1 btf_id_or_null:OK
    libbpf: failed to open system Kconfig
    libbpf: failed to load object 'bpf_iter_ipv6_route'
    libbpf: failed to load BPF skeleton 'bpf_iter_ipv6_route': -22
    test_ipv6_route:FAIL:bpf_iter_ipv6_route__open_and_load skeleton
open_and_load failed1510 bits_offset=1024
    #3/2 ipv6_route:FAIL
    libbpf: netlink is not found in vmlinux BTF
    libbpf: failed to load object 'bpf_iter_netlink'
    libbpf: failed to load BPF skeleton 'bpf_iter_netlink': -2
    test_netlink:FAIL:bpf_iter_netlink__open_and_load skeleton
open_and_load failed1510 bits_offset=1408
    #3/3 netlink:FAIL
    libbpf: bpf_map is not found in vmlinux BTF
    libbpf: failed to load object 'bpf_iter_bpf_map'
    libbpf: failed to load BPF skeleton 'bpf_iter_bpf_map': -2
    test_bpf_map:FAIL:bpf_iter_bpf_map__open_and_load skeleton
open_and_load failed
    #3/4 bpf_map:FAIL
    ....
    #3 bpf_iter:FAIL
    Summary: 0/1 PASSED, 0 SKIPPED, 12 FAILED

If I understand correctly, this is because there is no function
information for bpf_iter_bpf_map
present in my /sys/kernel/btf/vmlinux:

    # ./bpftool btf dump file /sys/kernel/btf/vmlinux format raw |
grep bpf_iter_bpf_map
    #

There is an entry in /proc/kallsyms however:

    # grep bpf_iter_bpf_map /proc/kallsyms
    ffffffff826b2f13 T bpf_iter_bpf_map

And other bpf_iter related symbols are available in BTF:

    # ./bpftool btf dump file /sys/kernel/btf/vmlinux format raw |
grep bpf_iter_
    [12602] TYPEDEF 'bpf_iter_init_seq_priv_t' type_id=9310
    [12603] TYPEDEF 'bpf_iter_fini_seq_priv_t' type_id=352
    [12604] STRUCT 'bpf_iter_reg' size=56 vlen=7
    [12608] STRUCT 'bpf_iter_meta' size=24 vlen=3
    [12609] STRUCT 'bpf_iter_target_info' size=32 vlen=3
    [12611] STRUCT 'bpf_iter_link' size=72 vlen=2
    [12613] STRUCT 'bpf_iter_priv_data' size=40 vlen=6
    [12617] STRUCT 'bpf_iter_seq_map_info' size=4 vlen=1
    [12620] STRUCT 'bpf_iter__bpf_map' size=16 vlen=2
    [12622] STRUCT 'bpf_iter_seq_task_common' size=8 vlen=1
    [12623] STRUCT 'bpf_iter_seq_task_info' size=16 vlen=2
    [12625] STRUCT 'bpf_iter__task' size=16 vlen=2
    [12626] STRUCT 'bpf_iter_seq_task_file_info' size=32 vlen=5
    [12628] STRUCT 'bpf_iter__task_file' size=32 vlen=4
    [25591] STRUCT 'bpf_iter__netlink' size=16 vlen=2
    [27509] STRUCT 'bpf_iter__ipv6_route' size=16 vlen=2

Can you help me make this work?

Thanks
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
