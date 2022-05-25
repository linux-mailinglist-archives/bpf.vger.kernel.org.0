Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0E533A4F
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 11:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiEYJzw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 May 2022 05:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbiEYJzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 May 2022 05:55:46 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B548E6D
        for <bpf@vger.kernel.org>; Wed, 25 May 2022 02:55:44 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id a15so524545ilq.12
        for <bpf@vger.kernel.org>; Wed, 25 May 2022 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NvPg3g1sb2KF0lsVLKmOciRLB5HpeJ/qMtV1hiJ5YEU=;
        b=QhAswP38aVdWFdBD/kntfKnoBsZN4wbjkt4kLK1KMTm4aokd1iPXAhmekGK/ZpsQJh
         wHdBxBanosxwcu01HCnsmyrYbWyLs1CWOVc0XP1HR19GOh2g1euzXG9eJQLbZA0YNh6Z
         Erk2POwQAjY7ri1hVhiLXVuIxqIOi/FOAg+Jj83EF5k6kr4uvtfS16fK8rCLIEGoK1HI
         /szBYK+1YNM7xY0DL9kMpHDnb8NpDBgMFpWi9JiXhTwKaPrJXb+6QI2+86cKniWNHgFZ
         Y+AyJpB+nuwiSNPpxRahsUzWJlE8swV+WfWxBY1S1fJbXZUJpF8LRyhiyubsznqgulnC
         NjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NvPg3g1sb2KF0lsVLKmOciRLB5HpeJ/qMtV1hiJ5YEU=;
        b=jdPtV5nsQ7sZ8APZrQHYc/c5oAen1QtWVFRH2KBKEpNVE/vMHkIpb/ato5yZ3k3ECc
         T/5Tad8cG6dlwS2Yvh1M16DD/srTPFJBA+2Sh42bQghfc8KeABwzicCgem1BDv2c5iGb
         ns4pSL/5IedfT1h14EHP8DOOAMlvKPsp7I9he/knD6bc78sIZdY4P4/eU5jStK0/CBKI
         +rEtyw9/+E6y3Hzr600c/kHq6wRk5hxPqXsv/IwzXX61oUNX4YaKAog06+f66e0mNY4z
         /WXFUN+cG20cIzRegKi5QNvvZ6lO75BrEKzdFDNQvK4qBVgsBPS8r48n6Vnz5iDbjjUd
         2p+g==
X-Gm-Message-State: AOAM533bK05t/UjkSItsY74Ac0fNyefxvip3E0ivNwZKckvFDXrgLah5
        FwKgNzkdN89UaXiWLwr8Zye8KnIloLiMA971FEPTkBj6HGY5RUNj4FI=
X-Google-Smtp-Source: ABdhPJzTYAkwsJG0EF16Apq4qSl5bbWhNjIYYGDOljRFuerMCbBWgDMP5VUbwsIhD3sRntUVe5T26FqJz3E/p8bLvKA=
X-Received: by 2002:a05:6e02:be8:b0:2cf:b8d:5fa with SMTP id
 d8-20020a056e020be800b002cf0b8d05famr16610776ilu.93.1653472543809; Wed, 25
 May 2022 02:55:43 -0700 (PDT)
MIME-Version: 1.0
From:   Ye ZhengMao <yezhengmaolove@gmail.com>
Date:   Wed, 25 May 2022 17:55:09 +0800
Message-ID: <CAJ=PnJmZVmAszzyfc8PLUCheQk04iCATXkrLJFxHL4Z=Pc1+Zg@mail.gmail.com>
Subject: bpftool coredump
To:     bpf@vger.kernel.org
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

i using cross compiler to compile the bpftool for aarch64 and when gen
skeleton for the minimal.bpf.o, bpftool core.

libbpf: loading object 'minimal_bpf' from buffer
libbpf: elf: section(2) tp/syscalls/sys_enter_write, size 104, link 0,
flags 6, type=1
libbpf: elf: section(3) license, size 13, link 0, flags 3, type=1
libbpf: license of minimal_bpf is Dual BSD/GPL
libbpf: elf: section(4) .bss, size 4, link 0, flags 3, type=8
libbpf: elf: section(5) .rodata, size 28, link 0, flags 2, type=1
libbpf: elf: section(6) .symtab, size 192, link 8, flags 0, type=2
libbpf: elf: section(7) .reltp/syscalls/sys_enter_write, size 32, link
6, flags 0, type=9
libbpf: looking for externs among 8 symbols...
libbpf: collected 0 externs total
libbpf: map 'minimal_.bss' (global data): at sec_idx 4, offset 0, flags 400.
libbpf: map 0 is "minimal_.bss"
libbpf: map 'minimal_.rodata' (global data): at sec_idx 5, offset 0, flags 480.
libbpf: map 1 is "minimal_.rodata"
libbpf: sec '.reltp/syscalls/sys_enter_write': collecting relocation
for section(2) 'tp/syscalls/sys_enter_write'
libbpf: sec '.reltp/syscalls/sys_enter_write': relo #0: insn #2 against 'my_pid'
Segmentation fault (core dumped)

core in function find_prog_by_sec_insn

i using gdb to found the obj->nr_programs == 0
prog = &obj->programs[l]; can`t work fine
