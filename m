Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE85A1BAE
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 23:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243507AbiHYVxM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 17:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiHYVxL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 17:53:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9598921E12
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 14:53:10 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pm13so12641740pjb.5
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=FO+YSP08oXauM4vkT/ZjxCNWgj3LrcVAIb/CblKB8Yg=;
        b=kEDeFr/pOfQmyeyOgKUWwegPv62A3zBPNtp8VUIN0bBEjGlNpQLwJ/VTahYOR80oTU
         4VBMuHmF9loiHwbfH/vkYAy4vU4Dwlo2MmLcHJW2V/MvjsBgiiRGafAxJGgv03NfFkeV
         OJ/2k0cugsh3fn6oT9x2z2uAUTpPmOzN++ApKlW4njKZyGZ51HqBOClWqK3vE4Bb2kP/
         8OgARwkU7pfJ7vNzAwks+SZC9K6RbS1+oBwUeEriA2rn7E24iWU4pTUvHXB9ARmQHUIR
         O/PL0vaFMbNVPDMGT0ZHKViV0naaaq+X0+Z+yJS+uC9pqsQRYfm/bxNv5rIa+MzsCNj+
         4G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=FO+YSP08oXauM4vkT/ZjxCNWgj3LrcVAIb/CblKB8Yg=;
        b=Gxki+ZVArgZoo3k65snZZ6CqXNmSy48akcrmpuIsXpOadxEseVP0F2scbM4baYFKpg
         Xme3IBWWK7riCKboCQg1UJq4WOMAH1OdTJBkwwEsOSlp+8U9PJyNKYJR/KiOKFvg58k7
         f5KO5zQN0bQqpE60m+YbJbYoiiNm4e1aunYyVbcIREy49/kXYw7LW8JBM/RXK6gOMqrB
         /hZY7LbMSKyn4Auhkw9CCWIS4rPutxnRK0q5BRdVX04ndH0iz45LWBJZIldIBPZcGrHi
         y1HCIWvXDDFNw1d7eG0zobUDXex9MNKpmwH/d892fKo7Jq8EUTwzlHfVKl1d2EpP3Bd3
         2/Sw==
X-Gm-Message-State: ACgBeo206uhZ+jUkD6QPwN5n5eUmxEXY3HfRkzmYuQDNMBFj0n7OWj2m
        NtSye2KJIi82/a2Et4eRSFY=
X-Google-Smtp-Source: AA6agR6GzUwRQ8hRS0hKfKk1me2YXK8o0utEelrllaB/hJ5nwyGKfmCHk36QQJytlx+7ppVUYLmgww==
X-Received: by 2002:a17:902:f394:b0:173:316c:b50 with SMTP id f20-20020a170902f39400b00173316c0b50mr941103ple.80.1661464390064;
        Thu, 25 Aug 2022 14:53:10 -0700 (PDT)
Received: from localhost ([98.97.36.33])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79f90000000b0052ac99c2c1csm120757pfr.83.2022.08.25.14.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:53:09 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:53:08 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org
Cc:     andrii@kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hsin-Wei Hung <hsinweih@uci.edu>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>
Message-ID: <6307ef446165d_aead208f7@john.notmuch>
In-Reply-To: <984b37f9fdf7ac36831d2137415a4a915744c1b6.1661462653.git.daniel@iogearbox.net>
References: <984b37f9fdf7ac36831d2137415a4a915744c1b6.1661462653.git.daniel@iogearbox.net>
Subject: RE: [PATCH bpf] bpf: Don't use tnum_range on array range checking for
 poke descriptors
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann wrote:
> Hsin-Wei reported a KASAN splat triggered by their BPF runtime fuzzer which
> is based on a customized syzkaller:
> 
>   BUG: KASAN: slab-out-of-bounds in bpf_int_jit_compile+0x1257/0x13f0
>   Read of size 8 at addr ffff888004e90b58 by task syz-executor.0/1489
>   CPU: 1 PID: 1489 Comm: syz-executor.0 Not tainted 5.19.0 #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>   1.13.0-1ubuntu1.1 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x9c/0xc9
>    print_address_description.constprop.0+0x1f/0x1f0
>    ? bpf_int_jit_compile+0x1257/0x13f0
>    kasan_report.cold+0xeb/0x197
>    ? kvmalloc_node+0x170/0x200
>    ? bpf_int_jit_compile+0x1257/0x13f0
>    bpf_int_jit_compile+0x1257/0x13f0
>    ? arch_prepare_bpf_dispatcher+0xd0/0xd0
>    ? rcu_read_lock_sched_held+0x43/0x70
>    bpf_prog_select_runtime+0x3e8/0x640
>    ? bpf_obj_name_cpy+0x149/0x1b0
>    bpf_prog_load+0x102f/0x2220
>    ? __bpf_prog_put.constprop.0+0x220/0x220
>    ? find_held_lock+0x2c/0x110
>    ? __might_fault+0xd6/0x180
>    ? lock_downgrade+0x6e0/0x6e0
>    ? lock_is_held_type+0xa6/0x120
>    ? __might_fault+0x147/0x180
>    __sys_bpf+0x137b/0x6070
>    ? bpf_perf_link_attach+0x530/0x530
>    ? new_sync_read+0x600/0x600
>    ? __fget_files+0x255/0x450
>    ? lock_downgrade+0x6e0/0x6e0
>    ? fput+0x30/0x1a0
>    ? ksys_write+0x1a8/0x260
>    __x64_sys_bpf+0x7a/0xc0
>    ? syscall_enter_from_user_mode+0x21/0x70
>    do_syscall_64+0x3b/0x90
>    entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   RIP: 0033:0x7f917c4e2c2d
> 
> The problem here is that a range of tnum_range(0, map->max_entries - 1) has
> limited ability to represent the concrete tight range with the tnum as the
> set of resulting states from value + mask can result in a superset of the
> actual intended range, and as such a tnum_in(range, reg->var_off) check may
> yield true when it shouldn't, for example tnum_range(0, 2) would result in
> 00XX -> v = 0000, m = 0011 such that the intended set of {0, 1, 2} is here
> represented by a less precise superset of {0, 1, 2, 3}. As the register is
> known const scalar, really just use the concrete reg->var_off.value for the
> upper index check.
> 
> Fixes: d2e4c1e6c294 ("bpf: Constant map key tracking for prog array pokes")
> Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  kernel/bpf/verifier.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
