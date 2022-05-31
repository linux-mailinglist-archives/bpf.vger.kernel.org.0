Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4FB5399E6
	for <lists+bpf@lfdr.de>; Wed,  1 Jun 2022 01:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348608AbiEaXDj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 19:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348606AbiEaXDj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 19:03:39 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC1E5A090
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 16:03:38 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id j11so90395vka.6
        for <bpf@vger.kernel.org>; Tue, 31 May 2022 16:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IeQK05qpc4eGrd2HqGzRJYXut6t9yCnUWkXWl7j6MuE=;
        b=VzBDufvYkS8nBzZ2IP7fRF9pzkrcKziuz1d+yCQL4S9vYEb4Xgf+NBM+RtD9GRawi7
         fBgTO+OciOCXeMpv8+paA6MaouWRRswAyeMQBzBh2DMilWL+RxPBdN90wN+m2OOZGbG7
         8v6IyR4lWqP2+z4qa+pVHZ0x3EyZSeOs7fVKti7I7Y5ZSuB8ETGNWBauPIuihZliyYad
         FOL7f3opjiR9J/lvUKBpBfydm6wuwhyvzJCwiWVFKYQPFl9wl+2yKWRERPcZ6cmKsJNG
         QyxtISdw7jMsI4q57XMQwt7Ymdz4KOsWf99VADv8XRZbfZuoBpwbJOB+JuDcctzl+lnf
         WqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IeQK05qpc4eGrd2HqGzRJYXut6t9yCnUWkXWl7j6MuE=;
        b=Z8QUMufhOorqWCUFyp6ejnzFe+QPjB3kdCTsqtPjWou8H85OizopVqO7/30I0J+Sbo
         bstNANTuphs/MBdZIjI33a2S7EiLIS9EJ4uiyiyCodpEsK6u7o1VjGhhpHe0CHWWYT2M
         JuMeHcK8dIHoD6PR4GS03XoshjZ1Br3SZyhyI8U8vOrTvN+8dsWP1C+EPptZ5WfNR6Ok
         fz/tK+duu3Ds0EZqH9N3k8VDrEmJ06KfNoLZ4pZkCUypqVPCRAznOKdGgrLohFafivaj
         CWsZAxwSbborTRZYhKbsWqFm2V364JPPpBcDTuNVbAaTs2/jvYcFl/oro22H1Wa8mpzB
         bhYQ==
X-Gm-Message-State: AOAM533k1YdkJ/76MoTqr3W+oPFSiV7qXPinYgB8cMdB2w3C4d4gE7IW
        csg1h0C71p+5HRybHvYo6IM4e1xAQsxzrqpGJ3irojnR
X-Google-Smtp-Source: ABdhPJxxuBTeovJ1sYXutxbILyJosEtzIyDQxow0F/FCjuh3pGdrQRoPJuwfjGS4/yX9bcFE860ymOblsbr3rITI5wk=
X-Received: by 2002:a1f:5907:0:b0:352:6327:926f with SMTP id
 n7-20020a1f5907000000b003526327926fmr23328322vkb.1.1654038217638; Tue, 31 May
 2022 16:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ=PnJmZVmAszzyfc8PLUCheQk04iCATXkrLJFxHL4Z=Pc1+Zg@mail.gmail.com>
In-Reply-To: <CAJ=PnJmZVmAszzyfc8PLUCheQk04iCATXkrLJFxHL4Z=Pc1+Zg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 31 May 2022 16:03:26 -0700
Message-ID: <CAEf4BzbnpvYjCMf+kVvdd9iQaiove5hDgjHsnKG-L4fxOhM70w@mail.gmail.com>
Subject: Re: bpftool coredump
To:     Ye ZhengMao <yezhengmaolove@gmail.com>
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

On Wed, May 25, 2022 at 1:10 PM Ye ZhengMao <yezhengmaolove@gmail.com> wrote:
>
> i using cross compiler to compile the bpftool for aarch64 and when gen
> skeleton for the minimal.bpf.o, bpftool core.
>
> libbpf: loading object 'minimal_bpf' from buffer
> libbpf: elf: section(2) tp/syscalls/sys_enter_write, size 104, link 0,
> flags 6, type=1

you should have seen a message about discovering a program here. Can
you share that .bpf.o file, somehow libbpf can't find program entry.


> libbpf: elf: section(3) license, size 13, link 0, flags 3, type=1
> libbpf: license of minimal_bpf is Dual BSD/GPL
> libbpf: elf: section(4) .bss, size 4, link 0, flags 3, type=8
> libbpf: elf: section(5) .rodata, size 28, link 0, flags 2, type=1
> libbpf: elf: section(6) .symtab, size 192, link 8, flags 0, type=2
> libbpf: elf: section(7) .reltp/syscalls/sys_enter_write, size 32, link
> 6, flags 0, type=9
> libbpf: looking for externs among 8 symbols...
> libbpf: collected 0 externs total
> libbpf: map 'minimal_.bss' (global data): at sec_idx 4, offset 0, flags 400.
> libbpf: map 0 is "minimal_.bss"
> libbpf: map 'minimal_.rodata' (global data): at sec_idx 5, offset 0, flags 480.
> libbpf: map 1 is "minimal_.rodata"
> libbpf: sec '.reltp/syscalls/sys_enter_write': collecting relocation
> for section(2) 'tp/syscalls/sys_enter_write'
> libbpf: sec '.reltp/syscalls/sys_enter_write': relo #0: insn #2 against 'my_pid'
> Segmentation fault (core dumped)
>
> core in function find_prog_by_sec_insn
>
> i using gdb to found the obj->nr_programs == 0
> prog = &obj->programs[l]; can`t work fine
