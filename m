Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEAB6652A5
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 05:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjAKEDl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 23:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjAKEDT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 23:03:19 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76018C;
        Tue, 10 Jan 2023 20:03:18 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o7-20020a17090a0a0700b00226c9b82c3aso15765911pjo.3;
        Tue, 10 Jan 2023 20:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IR5AitmdKy8K6dgR5mXWgIcQ8C4Z2A1sM2KlP+lxFIw=;
        b=E9m8UkKk0KPJY7lqwgBMwwgS8k8PC5c0vvq03PL6zPg5nibfitbxOOUEfvFWtBopIr
         k05LqecZKqiiDcGVb7yFm0S0C3ZTo6ErMYEhWbhpEGXT1XkUPCsZl2yTrd90FwZLkjYS
         aBHR+MqHD9/uSaOEhwenDk11uxr/y8oT0K9ZchO4GlAlB9KynbUFJM6wKXZeqrfcLF2t
         yoQe1La6OeWC9fMhLj7ZLv0AfbS1ItFrZOn4qSEpjzYGS50/4Y8nQavGOAkQWHG8fYaT
         UgX0bXlMYPNrd7isWwvVV09OApa2pVUY848WN+pwBC4hwFQB5NfTChwRqAwLu3IfhZxC
         47VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IR5AitmdKy8K6dgR5mXWgIcQ8C4Z2A1sM2KlP+lxFIw=;
        b=Kvd8fH2AVbQ0F3Wf6LufRXS9y7CG+vnlSu+Umi6MG0Mzdn8/LwsyPTg1ZsGH7XJ0li
         p9I0RuD00Otpp3JdElopJ+XCL/WmavefK+AfFb6j6VbJXB1eDlfMcRkhFuHdnO329Izu
         ydxQ5o+WGsnda2g4EAdFkrvxyl/K9dbUhJ7zVIZwD8EzqpKx3WRCcSmgAXIArRxUg0hP
         oq7RmS4dWzmRGRN6k4u+6FFjaHxqSI+nnq8TFNyP8e4eB4pFPdGMYdy6rbnR1fWsezww
         nadldbXG0lDxfHNFCcStmNLodF35Albe0+fcq86Ri4+WhziVML9n6Mscyw0pvPE1VCDa
         MutQ==
X-Gm-Message-State: AFqh2kqooDnMkGPNKtN3LQTg9BugfwV69OFDm/Hmfx1ra2gNoLrYniSG
        a6shqE/rSdJRR3pMUExcpEDf342yNojO
X-Google-Smtp-Source: AMrXdXtQTtGuTYq9yhoSnqAE0w2EguHsNNwzVw/Tb7zJ4i3W/+IQcM+KKRO3Ak0QNAiVr11LhxcN/g==
X-Received: by 2002:a17:90a:6344:b0:225:ce95:dc15 with SMTP id v4-20020a17090a634400b00225ce95dc15mr61078528pjs.29.1673409792805;
        Tue, 10 Jan 2023 20:03:12 -0800 (PST)
Received: from localhost.localdomain ([144.214.0.13])
        by smtp.gmail.com with ESMTPSA id gl1-20020a17090b120100b0020b2082e0acsm8013525pjb.0.2023.01.10.20.03.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jan 2023 20:03:12 -0800 (PST)
From:   Hao Sun <sunhao.th@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
Subject: WARNING: attempt to execute device eBPF program on the host!
Date:   Wed, 11 Jan 2023 12:02:42 +0800
Message-Id: <20230111040242.78139-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

The following warning can be triggered with the C reproducer in
the link. The syz repro may be more readable:
# {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:none SandboxArg:0 Leak:false NetInjection:true NetDevices:true NetReset:false Cgroups:true BinfmtMisc:false CloseFDs:true KCSAN:false DevlinkPCI:false NicVF:false USB:true VhciInjection:true Wifi:true IEEE802154:false Sysctl:true UseTmpDir:true HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}

r0 = bpf$MAP_CREATE(0x0, &(0x7f0000000140)={0xf, 0x4, 0x4, 0x8}, 0x48)
r1 = bpf$PROG_LOAD_XDP(0x5, &(0x7f00000001c0)={0x6, 0xb, &(0x7f0000000000)={{@imm, @map_fd={0x18, 0x6, 0x1, 0x0, r0}, @map_fd={0x18, 0x7, 0x1, 0x0, r0}, @map_fd={0x18, 0x8, 0x1, 0x0, r0}, @map_fd={0x18, 0x9, 0x1, 0x0, r0}}}, &(0x7f0000000080)}, 0x80)
r2 = bpf$BPF_LINK_CREATE_XDP(0x1c, &(0x7f0000000240)={r1, 0xf}, 0x10)
bpf$MAP_CREATE(0x0, &(0x7f0000000000)={0x5, 0x81c, 0x630, 0x8, 0x0, 0x1}, 0x48)
r3 = bpf$PROG_LOAD_XDP(0x5, &(0x7f0000000380)={0x6, 0xb, &(0x7f00000002c0)={{@imm, @imm, @imm, @imm, @imm}}, &(0x7f0000000340), 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x46}, 0x80)
bpf$BPF_LINK_UPDATE(0x1d, &(0x7f0000000840)={r2, r3, 0x4, r1}, 0x10)

This can be reproduced on:
HEAD commit:    6d0c4b11e743 ("libbpf: Poison strlcpy()")
git tree:       bpf-next
console output: https://pastebin.com/raw/DwdHsbS5
kernel config : https://pastebin.com/raw/AZCHdEbK
C reproducer  : https://pastebin.com/raw/tE08i586

------------[ cut here ]------------
attempt to execute device eBPF program on the host!
WARNING: CPU: 5 PID: 4498 at kernel/bpf/offload.c:252 bpf_prog_warn_on_exec+0x15/0x20 kernel/bpf/offload.c:252
Modules linked in:
CPU: 5 PID: 4498 Comm: kworker/5:3 Not tainted 6.2.0-rc2-00302-g6d0c4b11e743 #153
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:bpf_prog_warn_on_exec+0x15/0x20 kernel/bpf/offload.c:252
Code: e1 35 2f 00 eb c8 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa e8 b7 10 df ff 48 c7 c7 a0 c6 55 8a e8 95 53 20 08 <0f> 0b 31 c0 c3 66 0f 1f 44 00 00 48 b8 00 00 00 00 00 fc ff df 41
RSP: 0018:ffffc900009a09a8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff888027587100 RCX: 0000000000000000
RDX: ffff8881066c9d80 RSI: ffffffff81671400 RDI: fffff52000134127
RBP: ffff888013c47890 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000101 R11: ffffffff90d3f143 R12: ffff888027587156
R13: ffff888027587000 R14: ffffc900009a0a20 R15: ffff888013c47900
FS:  0000000000000000(0000) GS:ffff888135d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056006aaf00c0 CR3: 00000000264a0000 CR4: 0000000000750ee0
PKRU: 55555554
Call Trace:
 <IRQ>
 __bpf_prog_run include/linux/filter.h:600 [inline]
 bpf_prog_run_xdp include/linux/filter.h:775 [inline]
 veth_xdp_rcv_skb+0x8a2/0x21a0 drivers/net/veth.c:824
 veth_xdp_rcv.constprop.0+0x3f2/0xb20 drivers/net/veth.c:939
 veth_poll+0x141/0x8c0 drivers/net/veth.c:975
 __napi_poll.constprop.0+0xb0/0x440 net/core/dev.c:6485
 napi_poll net/core/dev.c:6552 [inline]
 net_rx_action+0x8f8/0xd50 net/core/dev.c:6663
 __do_softirq+0x1f7/0xaf6 kernel/softirq.c:571
 do_softirq kernel/softirq.c:472 [inline]
 do_softirq+0x10e/0x160 kernel/softirq.c:459
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf8/0x120 kernel/softirq.c:396
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:834 [inline]
 ip6_finish_output2+0x634/0x1aa0 net/ipv6/ip6_output.c:135
 __ip6_finish_output net/ipv6/ip6_output.c:195 [inline]
 ip6_finish_output+0x485/0x11c0 net/ipv6/ip6_output.c:206
 NF_HOOK_COND include/linux/netfilter.h:291 [inline]
 ip6_output+0x243/0x820 net/ipv6/ip6_output.c:227
 dst_output include/net/dst.h:444 [inline]
 NF_HOOK.constprop.0+0xfa/0x4c0 include/linux/netfilter.h:302
 ndisc_send_skb+0x9e8/0x1320 net/ipv6/ndisc.c:508
 ndisc_send_ns+0xb5/0x130 net/ipv6/ndisc.c:666
 addrconf_dad_work+0xc6b/0x1300 net/ipv6/addrconf.c:4171
 process_one_work+0xa33/0x1720 kernel/workqueue.c:2289
 worker_thread+0x67d/0x10e0 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
