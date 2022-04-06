Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0D84F6AE6
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 22:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiDFUK4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiDFUKt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 16:10:49 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFEF1E374C
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 10:25:37 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id z7so3824550iom.1
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ggMiBLd7ZOWtjzjD6Un6ZVq1KDYAxjij9mfV1L5UOfc=;
        b=OYsMQRgQSzJcxcLicpCrOAQ10fMKaO5Jn3mzVl3exVBSq9puagWkscXZy9oW2o3INz
         PLTeUuvzQ8EKNDrmGCx1uCz9Iv4Ow+Kk6C9YJCYqkb7ip09y00P3FqhqMLVa9Ako6aTy
         RcSNlEnH6/GpE2frCLl+2SHdIWiG6/NFBtRGxR3JzhnR83NK61AqXDvgFK7PvLHJR9hf
         uzaljKwJHv4MuUDjVa0R18WzzRwk4flbnzNmmK6IMAjQB02KaJIj2CRn0w8yy6oZtjcb
         jTOo1BTM0XkqxGILcsuCEhildvZM5LRb17CDMMfccNk8HjZvCT88qKUMz1J2lI8zPTFN
         l+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ggMiBLd7ZOWtjzjD6Un6ZVq1KDYAxjij9mfV1L5UOfc=;
        b=JfsZsjnw6YbhdcXKuEO229uXasYhrWWXIe82r0U8HuDmWycilS3aBm2ERQiZ5j0DF/
         PtNlOrvD5TuEumZdeQv6CXpe17aXkj0TtCIfTMxurkBM5QKvEUwsZODBf2I9PTGBewSU
         jAqhLuuGyMTcG8nOng1fxTs8RBQbn2YehvphMtpf3mW5mZNqkhhC8Sb0hnqqttb7jdT/
         lD9iy7IgZpaSmDhcRPc13KDaaFcgw3FSByqJYrtNwvCkIGiBQICKaMQaldQfk/c/hONX
         mcyX6ayTNR/s/X11FkLDgGcVqmavIeK/32/biMXreo6qKadBs3anzf0kSyzGld9lyCap
         32Xg==
X-Gm-Message-State: AOAM532DuQvPcqTkl3l0DhOkrnRZhWMCMf5EORW3zz022OrYkVOQ5iuI
        WBMb4gR5OUSY90FfPZSv27cPEHEC/EhgJcEwfn86tx5z
X-Google-Smtp-Source: ABdhPJyPD1NXSLENxiNh4Krx8RV9nWXfbsKJcL3qfORk3WaNJh4xqfJkHKRDPaCQZTQJgUaKDlNUyS70DaSVostvi+8=
X-Received: by 2002:a05:6638:1685:b0:323:9fed:890a with SMTP id
 f5-20020a056638168500b003239fed890amr5142215jat.103.1649265936934; Wed, 06
 Apr 2022 10:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <50b0dbb.2936.17fff506075.Coremail.wuzongyo@mail.ustc.edu.cn>
In-Reply-To: <50b0dbb.2936.17fff506075.Coremail.wuzongyo@mail.ustc.edu.cn>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 10:25:26 -0700
Message-ID: <CAEf4BzYMq92tHd+fqyLZwgykSf7j-Rbw-4H+Y+Xe5C-rnjnAxQ@mail.gmail.com>
Subject: Re: [Question] Failed to load ebpf program with BTF-defined map
To:     wuzongyo@mail.ustc.edu.cn
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 6, 2022 at 10:09 AM <wuzongyo@mail.ustc.edu.cn> wrote:
>
> Hi,
>
> I wrote a simple tc-bpf program like that:
>
>     #include <linux/bpf.h>
>     #include <linux/pkt_cls.h>
>     #include <linx/types.h>
>     #include <bpf/bpf_helpers.h>
>
>     struct {
>         __uint(type, BPF_MAP_TYPE_HASH);
>         __uint(max_entries, 1);
>         __type(key, int);
>         __type(value, int);
>     } hmap SEC(".maps");
>
>     SEC("classifier")
>     int _classifier(struct __sk_buff *skb)
>     {
>         int key = 0;
>         int *val;
>
>         val = bpf_map_lookup_elem(&hmap, &key);
>         if (!val)
>             return TC_ACT_OK;
>         return TC_ACT_OK;
>     }
>
>     char __license[] SEC("license") = "GPL";
>
> Then I tried to use tc to load the program:
>
>     tc qdisc add dev eth0 clsact
>     tc filter add dev eth0 egress bpf da obj test_bpf.o
>
> But the program loading failed with error messages:
>     Prog section 'classifier' rejected: Permission denied (13)!
>     - Type:          3
>     - Instructions:  9 (0 over limit
>     - License:       GPL
>
>     Verifier analysis:
>
>     Error fetching program/map!
>     Unable to load program
>
> I tried to replace the map definition with the following code and the program is loaded successfully!
>
>     struct bpf_map_def SEC("maps") hmap = {
>         .type = BPF_MAP_TYPE_HASH,
>         .key_size = sizeof(int),
>         .value_size = sizeof(int),
>         .max_entries = 1,
>     };
>
> With bpftrace, I can find that the errno -EACCES is returned by function do_check(). But I am still confused what's wrong with it.
>
> Linux Version: 5.17.0-rc3+ with CONFIG_DEBUG_INFO_BTF=y
> TC Version: 5.14.0
>
> Any suggestion will be appreciated!
>

This is an iproute2 question, please find their mailing list and ask
there. Or bypass iproute2 and use libbpf-provided TC APIS
(bpf_tc_xxx()) to do all this directly from your application without
shelling out or delegating to iproute2


> Thanks
>
