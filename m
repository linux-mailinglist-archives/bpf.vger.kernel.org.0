Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00396EE47C
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 17:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjDYPIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 11:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjDYPIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 11:08:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12EF12C95;
        Tue, 25 Apr 2023 08:08:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2a8afef50f2so56258391fa.2;
        Tue, 25 Apr 2023 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682435316; x=1685027316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2tyWGZ0qRLO7YY/eW0Nu642ErqqwoMqPBQyRD2WOJg=;
        b=G7tYkADxKWB+OS6+Qc1SfHAEhnSsPaGxEylqlnunjwkYjL3k2wJrbD9YRMTNzQZuYq
         bhZ3VLAYMrsdVAbcvE8H4TcFYnoRhYRsL0ouHUedOrQX7UP5f6vStPemxg7dseQzu5mp
         KNFZPQlo2/VCZaQbJ+KVHaDQ9j9pf9K01xcDDTcCMOl+gdrJDk+EaLD6cj6cq3YtFqDK
         lFrx08ss40gLcqc7tv7eyEO1CNB4QSwglOR1l2wwSz26lpASy15Xc84R1YNJba+0qpBf
         W7Oek05uQLmQg5ysqQLXpWXk8uu1tnqojY2eM3sQwsWO0U1XL4wMnrQ47gR1nBQktfX2
         fbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682435316; x=1685027316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2tyWGZ0qRLO7YY/eW0Nu642ErqqwoMqPBQyRD2WOJg=;
        b=LlFFBkbKGdGY2csbYMG+9ESdaqQJguAlTHI6gbbfKWonwVUYRniDEUZMBS5TX3Q2E5
         dw+vBIUM5jNGhx6aXY5j2pp0ArLFcV0kkJ73A6YDc/tF9k/WrIUM/N405tbOEzwrZLYo
         QoO6eX1tanKZsyQBrRIVqiKXutF1Mg8CHWqnfYBAT5yrCPGEAdM/EPyhlrDp3v2pd6Y5
         kjKqAAarXQtHmD+igaYBlLWqFukNe1bEo+9hV0p4sa//J3ZP1qK+ov2dseRGdriWl7K4
         jYsKMI6lD4DaSRgz4ivPPXHIvBXW1ouqe/94gGsRbOgsektJZtSN04QzankUZige11+E
         rm6w==
X-Gm-Message-State: AAQBX9fBV8kE+jGrCnDuI7JOWdoor5wSVfD5sqehu9dUwZVbBBt3J2Li
        7NTGyCN9yRUEwAx8ru0R7Br2Qa0VT/qg5nOI+xk=
X-Google-Smtp-Source: AKy350aCuT+qNzt0J+KztoKq/HJfmWHr/XxwKmzGV0+o2FxOgShaI5sytvoBuThJczYbdmfBpRUWj3EJp4w0rucySec=
X-Received: by 2002:a2e:4952:0:b0:2aa:4705:440 with SMTP id
 b18-20020a2e4952000000b002aa47050440mr2973398ljd.33.1682435315454; Tue, 25
 Apr 2023 08:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002d14f305fa241e67@google.com>
In-Reply-To: <0000000000002d14f305fa241e67@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Apr 2023 08:08:24 -0700
Message-ID: <CAADnVQK3m34RPCgw-7qWxE4gBb+ZoX4ZmEtbe-Ku0_ZOSG+5vA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KCSAN: data-race in __bpf_lru_list_rotate /
 __htab_lru_percpu_map_update_elem (5)
To:     syzbot <syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin,


Please take a look at the trace below.
I think we just need to annotate bpf_lru_node_set_ref() with data_race().
wdyt?

Too bad there is no reproducer.

On Tue, Apr 25, 2023 at 12:31=E2=80=AFAM syzbot
<syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6a66fdd29ea1 Merge tag 'rust-fixes-6.3' of https://github=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D160d894828000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dfa4baf7c6b35b=
5d5
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Debe648a84e87847=
63f82
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Deb=
ian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/78937867b23a/dis=
k-6a66fdd2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dfd6c176adff/vmlinu=
x-6a66fdd2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/51509bf47166/b=
zImage-6a66fdd2.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in __bpf_lru_list_rotate / __htab_lru_percpu_map_up=
date_elem
>
> write to 0xffff888137038deb of 1 bytes by task 11240 on cpu 1:
>  __bpf_lru_node_move kernel/bpf/bpf_lru_list.c:113 [inline]
>  __bpf_lru_list_rotate_active kernel/bpf/bpf_lru_list.c:149 [inline]
>  __bpf_lru_list_rotate+0x1bf/0x750 kernel/bpf/bpf_lru_list.c:240
>  bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:329 [inline]
>  bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:447 [inline]
>  bpf_lru_pop_free+0x638/0xe20 kernel/bpf/bpf_lru_list.c:499
>  prealloc_lru_pop kernel/bpf/hashtab.c:290 [inline]
>  __htab_lru_percpu_map_update_elem+0xe7/0x820 kernel/bpf/hashtab.c:1316
>  bpf_percpu_hash_update+0x5e/0x90 kernel/bpf/hashtab.c:2313
>  bpf_map_update_value+0x2a9/0x370 kernel/bpf/syscall.c:200
>  generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1687
>  bpf_map_do_batch+0x2d9/0x3d0 kernel/bpf/syscall.c:4534
>  __sys_bpf+0x338/0x810
>  __do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
>  __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5094
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff888137038deb of 1 bytes by task 11241 on cpu 0:
>  bpf_lru_node_set_ref kernel/bpf/bpf_lru_list.h:70 [inline]
>  __htab_lru_percpu_map_update_elem+0x2f1/0x820 kernel/bpf/hashtab.c:1332
>  bpf_percpu_hash_update+0x5e/0x90 kernel/bpf/hashtab.c:2313
>  bpf_map_update_value+0x2a9/0x370 kernel/bpf/syscall.c:200
>  generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1687
>  bpf_map_do_batch+0x2d9/0x3d0 kernel/bpf/syscall.c:4534
>  __sys_bpf+0x338/0x810
>  __do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
>  __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5094
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0x01 -> 0x00
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 11241 Comm: syz-executor.3 Not tainted 6.3.0-rc7-syzkaller-00=
136-g6a66fdd29ea1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/30/2023
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
