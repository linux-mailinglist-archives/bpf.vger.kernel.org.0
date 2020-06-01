Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FC61EA7C9
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 18:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgFAQ1r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQ1r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 12:27:47 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD57C05BD43
        for <bpf@vger.kernel.org>; Mon,  1 Jun 2020 09:27:45 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e5so1104082ote.11
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2020 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmuHPd2+K5lfeRY8Pu4zV9lugswo2+fs051abBWrdnM=;
        b=ZnkT6BT/RcTGbpKssI/DqKTqANTJZN2VbyE5gM2YwxiYrdg9RC9+lF4kjUbwhwDmx9
         /8YmJe5UFuF3hATqN4N+83jaCCJnFQDLEI0B0mJS9tUSbg5IvTuJHtkw62ANXjAHzDm2
         /Tooybr8If7NeudSNe2FVWwATiSj97pOp9uo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmuHPd2+K5lfeRY8Pu4zV9lugswo2+fs051abBWrdnM=;
        b=NkpyCI0zZYT7m+CVeeJ5W6Vkn6to6L+7HDR3ORkzdtErflP2zHAa4OU92VSq01tSZN
         owTgRyyNhlMDuZC9vE3QD2hcOA5SiA6VZL5Vxo1E4to7/3dlkY2LqtmlGSyC1AVSO6bd
         SDUjG+KB2TXMYK+/Fj2YN1QU1YdA3sG4zxcDJODYPdykqnzyV46pYvBTDCJ/+pW4+2XR
         hspHYAFkRaOVMU5q/B8y3XCv6g0kg6Gf4+xtAoD2gYFJ7EMPTRAhvZeh1G/l730IDmph
         2DkoDzklq9vE4R9nEI9IRysGD/bgrw/FjrVFQowYRqNWt73krOWK4RNmT8FKW8Blp6za
         DaQA==
X-Gm-Message-State: AOAM533MBZ3GrGBX0Wod4wuNOEYSS7RKnxh7tNkt06fKb/ORvyBz6yDP
        aPWE22BoiCVP8E3m2g0WxFK2e0oEgXFkUfwO5o9lfw==
X-Google-Smtp-Source: ABdhPJxFED8blCThSJzjX94HVr+6bk84E/DHVRs7EQxPeHeVBFHhgWNkQm8Q+tloE7MqsUP+wc9BddHLVZiKKK4636Y=
X-Received: by 2002:a9d:a4c:: with SMTP id 70mr18149078otg.334.1591028865101;
 Mon, 01 Jun 2020 09:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw99G8vWfZAxy5ohapnTgwndzDrBeTARvxyrO6xopoW98yQ@mail.gmail.com>
 <CACAyw98Stt_Ch3nFZ26UO9qDoCL46w-bt73G==NH=bMieCwBPw@mail.gmail.com> <cf3ee3cc-9095-3bac-0210-51b866b115db@fb.com>
In-Reply-To: <cf3ee3cc-9095-3bac-0210-51b866b115db@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Mon, 1 Jun 2020 17:27:33 +0100
Message-ID: <CACAyw9-Kp21FotWKgzvWkzjXUdpNPH=HJy79eX3aBbZmcYsFQQ@mail.gmail.com>
Subject: Re: Trouble running bpf_iter tests
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 1 Jun 2020 at 16:13, Yonghong Song <yhs@fb.com> wrote:
>
>
> On 6/1/20 7:42 AM, Lorenz Bauer wrote:
> > For some reason the initial e-mail wasn't plain text, apologies.
> >
> > ---------- Forwarded message ---------
> > From: Lorenz Bauer <lmb@cloudflare.com>
> > Date: Mon, 1 Jun 2020 at 15:32
> > Subject: Trouble running bpf_iter tests
> > To: Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
> > Cc: kernel-team <kernel-team@cloudflare.com>
> >
> >
> > Hi Yonghong,
> >
> > I'm having trouble running the bpf_iter tests on bpf-next at 551f08b1d8eadbc.
> > On a freshly built kernel running in a VM I get the following:
> >
> >      root@vm:/home/lorenz/dev/bpf-next/tools/testing/selftests/bpf#
> > ./test_progs -t bpf_iter
> > 510 bits_offset=640
> >      #3/1 btf_id_or_null:OK
> >      libbpf: failed to open system Kconfig
> >      libbpf: failed to load object 'bpf_iter_ipv6_route'
> >      libbpf: failed to load BPF skeleton 'bpf_iter_ipv6_route': -22
> >      test_ipv6_route:FAIL:bpf_iter_ipv6_route__open_and_load skeleton
> > open_and_load failed1510 bits_offset=1024
> >      #3/2 ipv6_route:FAIL
> >      libbpf: netlink is not found in vmlinux BTF
> >      libbpf: failed to load object 'bpf_iter_netlink'
> >      libbpf: failed to load BPF skeleton 'bpf_iter_netlink': -2
> >      test_netlink:FAIL:bpf_iter_netlink__open_and_load skeleton
> > open_and_load failed1510 bits_offset=1408
> >      #3/3 netlink:FAIL
> >      libbpf: bpf_map is not found in vmlinux BTF
> >      libbpf: failed to load object 'bpf_iter_bpf_map'
> >      libbpf: failed to load BPF skeleton 'bpf_iter_bpf_map': -2
> >      test_bpf_map:FAIL:bpf_iter_bpf_map__open_and_load skeleton
> > open_and_load failed
> >      #3/4 bpf_map:FAIL
> >      ....
> >      #3 bpf_iter:FAIL
> >      Summary: 0/1 PASSED, 0 SKIPPED, 12 FAILED
> >
> > If I understand correctly, this is because there is no function
> > information for bpf_iter_bpf_map
> > present in my /sys/kernel/btf/vmlinux:
> >
> >      # ./bpftool btf dump file /sys/kernel/btf/vmlinux format raw |
> > grep bpf_iter_bpf_map
> >      #
>
> Yes, this is the reason.
>
> >
> > There is an entry in /proc/kallsyms however:
> >
> >      # grep bpf_iter_bpf_map /proc/kallsyms
> >      ffffffff826b2f13 T bpf_iter_bpf_map
> That means the kernel actually haves the right information.
> >
> > And other bpf_iter related symbols are available in BTF:
> >
> >      # ./bpftool btf dump file /sys/kernel/btf/vmlinux format raw |
> > grep bpf_iter_
> >      [12602] TYPEDEF 'bpf_iter_init_seq_priv_t' type_id=9310
> >      [12603] TYPEDEF 'bpf_iter_fini_seq_priv_t' type_id=352
> >      [12604] STRUCT 'bpf_iter_reg' size=56 vlen=7
> >      [12608] STRUCT 'bpf_iter_meta' size=24 vlen=3
> >      [12609] STRUCT 'bpf_iter_target_info' size=32 vlen=3
> >      [12611] STRUCT 'bpf_iter_link' size=72 vlen=2
> >      [12613] STRUCT 'bpf_iter_priv_data' size=40 vlen=6
> >      [12617] STRUCT 'bpf_iter_seq_map_info' size=4 vlen=1
> >      [12620] STRUCT 'bpf_iter__bpf_map' size=16 vlen=2
> >      [12622] STRUCT 'bpf_iter_seq_task_common' size=8 vlen=1
> >      [12623] STRUCT 'bpf_iter_seq_task_info' size=16 vlen=2
> >      [12625] STRUCT 'bpf_iter__task' size=16 vlen=2
> >      [12626] STRUCT 'bpf_iter_seq_task_file_info' size=32 vlen=5
> >      [12628] STRUCT 'bpf_iter__task_file' size=32 vlen=4
> >      [25591] STRUCT 'bpf_iter__netlink' size=16 vlen=2
> >      [27509] STRUCT 'bpf_iter__ipv6_route' size=16 vlen=2
> >
> > Can you help me make this work?
>
> Looks like you have old pahole in your system. You need pahole 1.16 or later
>
> to enable global functions emitted to vmlinux BTF. Could you give a try?

Indeed, upgrading to v1.17 fixed the issue! Thanks for your help :)

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
