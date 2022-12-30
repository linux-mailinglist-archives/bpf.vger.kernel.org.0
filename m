Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5146E6596F9
	for <lists+bpf@lfdr.de>; Fri, 30 Dec 2022 10:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiL3JyV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Dec 2022 04:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiL3JyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Dec 2022 04:54:20 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0449140D2;
        Fri, 30 Dec 2022 01:54:18 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z7so8496326pfq.13;
        Fri, 30 Dec 2022 01:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nupBY8IgCxlZ4P9Kxn+Uy2z0GV1YOr96iu4t1qMcG7I=;
        b=VCpCd6pswqeSZwAFO1KQNPvpSckF62CmpP24C/LpkF1mvmbmBQ9qWY26OXStaR6yqN
         I72Dwh3jIsYQu5DpgmCYxI0atsdZsNgrbhQ2vxIUr7Rb++4QBw5Sa8KaxKNUHUgAZ23r
         Van+nro4tE50vFJpXfYrgs4Ncyqn8olfKxjVwlDHYs/mHB7iYPyjVTQ93aPxy8Eeqq33
         3cCgRr2NtECCt6rs/PczhsmwILm2lTxdwPasPDSbNHcL10NgofH956PUfDIdUsyn/nkF
         T7K3uT7XV8VjBuvUPBV97GlW3GdVGgDPyt5sUlt+GCA1kGK88e8WQG211qpMr9ETtd+r
         QGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nupBY8IgCxlZ4P9Kxn+Uy2z0GV1YOr96iu4t1qMcG7I=;
        b=q4E4jn48t+dXoXuGAUU736RDcJTmW082R/NkMF2GRJII3QDj7tUFiyqTU+uUX863BT
         L7Oyh2Vv6SGhHyAnnaHw1UpnqBZ21NUqfhvBhs/CDoiMNwWFYTguE/E7Z3Lgbifvjh2T
         mBZLAJKfrs1zLymUCKGwmGnVnaBjS9WTejiEu5X6fJe6KLeAFOMqArQ7XQyvRgXJHwWr
         zv4C8WJtHqsR5ixCe2mWg+NYOR0rFiEklrUVIri9zU4/SlvQ9z/V2JxBL3NFKCaonl91
         CCYAkD8P3UQJakhWNjKyK1EoRhOhCqJRXTcB6kpW+8UwErYSP9yjy8EMQMfSBxCXmpHg
         ISJg==
X-Gm-Message-State: AFqh2kqXFrcD1DwSvlFQjrDHPoGX8qCbjpLBAfMUmyqNAtPYWv5brPdT
        U7hu/InV1gjaNDsU9BQCGQ==
X-Google-Smtp-Source: AMrXdXubpKdrsO5YigBeNw/YayOXVNsmcDYEDBKPpiSbgbnG9ZYTAnrKYExHgA7A/lS46RrdDQkazA==
X-Received: by 2002:a62:6546:0:b0:578:119c:1c52 with SMTP id z67-20020a626546000000b00578119c1c52mr26595111pfb.14.1672394058343;
        Fri, 30 Dec 2022 01:54:18 -0800 (PST)
Received: from smtpclient.apple ([144.214.0.13])
        by smtp.gmail.com with ESMTPSA id 2-20020a621902000000b0058167c59bd7sm6141878pfz.40.2022.12.30.01.54.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Dec 2022 01:54:18 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: kernel panic: Attempted to kill init!
From:   Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <ef46c1f6-0939-c2ed-3efb-c3c5f28d1931@meta.com>
Date:   Fri, 30 Dec 2022 17:54:04 +0800
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <73E3CA9E-F67E-429F-A2DB-C77649E32D7A@gmail.com>
References: <20221222043507.33037-1-sunhao.th@gmail.com>
 <ef46c1f6-0939-c2ed-3efb-c3c5f28d1931@meta.com>
To:     Yonghong Song <yhs@meta.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 28 Dec 2022, at 2:35 PM, Yonghong Song <yhs@meta.com> wrote:
>=20
>=20
>=20
> On 12/21/22 8:35 PM, Hao Sun wrote:
>> Hi,
>> This crash can be triggered by executing the C reproducer for
>> multiple times, which just keep loading the following prog as
>> raw tracepoint into kmem_cache_free().
>> The prog send SIGSEGV to current via bpf_send_signal_thread(),
>> after load this, whoever tries to free mem would trigger this,
>> kernel crashed when this happens to init.
>> Seems we should filter init out in bpf_send_signal_common() by
>> is_global_init(current), or maybe we should check this in the
>> verifier?
>=20
> The helper is just to send a particular signal to *current*
> thread. In typical use case, it is never a good idea to send
> the signal to a *random* thread. In certain cases, maybe user
> indeed wants to send the signal to init thread to observe
> something. Note that such destructive side effect already
> exists in the bpf land. For example, for a xdp program,
> it could drop all packets to make machine not responsive
> to ssh etc. Therefore, I recommend to keep the existing
> bpf_send_signal_common() helper behavior.

Sound the two are different cases. Not responsive in XDP seems like
an intended behaviour, panic caused by killing init is buggy. If the
last thread of global init was killed, kernel panic immediately.


>=20
>> This can be reproduced on:
>> HEAD commit: 59fe41b5255f selftests/bpf: Add verifier test exercising =
jit PROBE_MEM logic
>> git tree: bpf-next
>> console output: https://pastebin.com/raw/FMgyvEnH
>> kernel config : https://pastebin.com/raw/XeF6jU43
>> C reproducer  : https://pastebin.com/raw/Tag5N893
>> func#0 @0
>> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>> 0: (18) r0 =3D 0x0                      ; R0_w=3D0
>> 2: (18) r6 =3D 0x0                      ; R6_w=3D0
>> 4: (18) r7 =3D 0x0                      ; R7_w=3D0
>> 6: (18) r8 =3D 0x0                      ; R8_w=3D0
>> 8: (18) r9 =3D 0x0                      ; R9_w=3D0
>> 10: (2d) if r0 > r0 goto pc+2
>> last_idx 10 first_idx 0
>> regs=3D1 stack=3D0 before 8: (18) r9 =3D 0x0
>> regs=3D1 stack=3D0 before 6: (18) r8 =3D 0x0
>> regs=3D1 stack=3D0 before 4: (18) r7 =3D 0x0
>> regs=3D1 stack=3D0 before 2: (18) r6 =3D 0x0
>> regs=3D1 stack=3D0 before 0: (18) r0 =3D 0x0
>> last_idx 10 first_idx 0
>> regs=3D1 stack=3D0 before 8: (18) r9 =3D 0x0
>> regs=3D1 stack=3D0 before 6: (18) r8 =3D 0x0
>> regs=3D1 stack=3D0 before 4: (18) r7 =3D 0x0
>> regs=3D1 stack=3D0 before 2: (18) r6 =3D 0x0
>> regs=3D1 stack=3D0 before 0: (18) r0 =3D 0x0
>> 11: R0_w=3D0
>> 11: (b7) r1 =3D 11                      ; R1_w=3D11
>> 12: (85) call bpf_send_signal_thread#117      ; R0=3Dscalar()
>> 13: (95) exit
>> processed 9 insns (limit 1000000) max_states_per_insn 0 total_states =
1 peak_states 1 mark_read 1
>> Kernel panic - not syncing: Attempted to kill init! =
exitcode=3D0x0000000b
>> CPU: 3 PID: 1 Comm: systemd Not tainted 6.1.0-09652-g59fe41b5255f =
#148
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:88 [inline]
>>  dump_stack_lvl+0x100/0x178 lib/dump_stack.c:106
>>  panic+0x2c4/0x60f kernel/panic.c:275
>>  do_exit.cold+0x63/0xe4 kernel/exit.c:789
>>  do_group_exit+0xd4/0x2a0 kernel/exit.c:950
>>  get_signal+0x2460/0x2600 kernel/signal.c:2858
>>  arch_do_signal_or_restart+0x78/0x5d0 arch/x86/kernel/signal.c:306
>>  exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
>>  exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
>>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>>  syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
>>  do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> RIP: 0033:0x55e738964df0
>> Code: 00 31 f6 89 ef 4c 8d 05 be 1b 0d 00 48 8d 15 b0 85 0c 00 31 c0 =
e8 f0 c3 ff ff e9 1c ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 <41> 57 =
41 56 41 55 41 54 41 89 fc 55 53 48 81 ec 48 01 00 00 64 48
>> RSP: 002b:00007ffeb8e87bb8 EFLAGS: 00000246 ORIG_RAX: =
00000000000000f7
>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f29dc8a6bc1
>> RDX: 00007ffeb8e87bc0 RSI: 00007ffeb8e87cf0 RDI: 000000000000000b
>> RBP: 00007ffeb90b73c0 R08: 0000000000000000 R09: 0000000000000002
>> R10: 0000000000000004 R11: 0000000000000246 R12: 00007f29dc3f76c8
>> R13: 000000000000294d R14: 0000000000000000 R15: 00007ffeb9686870
>>  </TASK>
>> Kernel Offset: disabled
>> Rebooting in 86400 seconds..

