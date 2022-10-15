Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE75FF7A4
	for <lists+bpf@lfdr.de>; Sat, 15 Oct 2022 02:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJOAZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 20:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJOAYu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 20:24:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71E7209AF
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 17:24:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s13-20020a170902ea0d00b00183243c7a0fso4116767plg.3
        for <bpf@vger.kernel.org>; Fri, 14 Oct 2022 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJZ1j5u0NaOiTKFpm/rqLSFKmrKQCfuJe+acxT21U9k=;
        b=BSo3fNklnH0gMQltzOH9HJLOd/xV0SnvHxGy2m2dCEMJxW9u768I4gZ4zWl662lbJN
         kXff98qYPUscNS/dUaXe0Q2jjFbArcAIoDK3Q1+av2qwahWEQE4hoSMBKJQkmuMmYOzZ
         EwoE6cxXqE8T2RpjopNE9h0+/Q0XgeH3K9Pxr1Y082kRGJnHnrmx+vI1smymBOPRS5NP
         EVMFnG4BVg3/n1lu8RHoIepNvQSeVS8c2Nx3NJCvsVavV19m8w86HgsmEDyuiUkCvK0g
         R+s9YY77gnXTCPrknkvy3I+fLIGMBBj2B+nPoIGzC0OZIBc4J0FyGbTZilDIZBPorG1w
         OoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJZ1j5u0NaOiTKFpm/rqLSFKmrKQCfuJe+acxT21U9k=;
        b=NWN8W0WoJxFibZkjYXJBLavcDg1B61Ft5K8TNXyzfbvqKBM3PrkjT+Jqf2KxsYbNcg
         EQF6Ek3ugaFC5NErLDgbuCjiySemoJ9Ryrf+iItpnUDugK2lXjaRR3nPsqCeNCjFD/eb
         1RKmS/1sdq6rEBtIJjFFkrqs1V+BTjRooHeHTVZJdV9uZ9RvCtATrf7n1k2bw0kn/5QZ
         AnXbM1HlfvdoNoD109O28fkOB9zIQB8wGgm26kIO8uRzBGEf4Z3feAgklaDO9ll3aaYI
         ixTtIT4DfNIElQTN9cpX+nZgH0UDu1GNxtXG+5UgS99eZCmplWoV9z3fUIW/ZBSUpYP9
         3N/Q==
X-Gm-Message-State: ACrzQf32ZSL3EOI5aEoRTjZ/okcJe3I0Cfj8WGHJiEGQyengS4mBb5AZ
        VCt8juMS3xy6AnfwQWTN5JvI7aM3pS/OY70YzZmUMKc/nfOoNeWiaTjwkurlgjRz1Qjz2InhChL
        MyE1gndBxFKCBB49MQuPv+OA4fsjoLSM8brOSzAmH2/t7uQkYBQ==
X-Google-Smtp-Source: AMsMyM6LcWPvjTE0aK6+Qi7dbP94U3O2ezKcoU6876iwIfoGf8CpWKiLPKXAHNCsjZEcn+Zc+4s0sKo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:bf46:b0:179:eba5:90ba with SMTP id
 u6-20020a170902bf4600b00179eba590bamr311258pls.16.1665793488182; Fri, 14 Oct
 2022 17:24:48 -0700 (PDT)
Date:   Fri, 14 Oct 2022 17:24:44 -0700
In-Reply-To: <20221015002444.2680969-1-sdf@google.com>
Mime-Version: 1.0
References: <20221015002444.2680969-1-sdf@google.com>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221015002444.2680969-2-sdf@google.com>
Subject: [PATCH bpf-next 2/2] bpf: prevent decl_tag from being referenced in func_proto
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>,
        syzbot+d8bd751aef7c6b39a344@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Syzkaller was able to hit the following issue:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3609 at kernel/bpf/btf.c:1946
btf_type_id_size+0x2d5/0x9d0 kernel/bpf/btf.c:1946
Modules linked in:
CPU: 0 PID: 3609 Comm: syz-executor361 Not tainted
6.0.0-syzkaller-02734-g0326074ff465 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 09/22/2022
RIP: 0010:btf_type_id_size+0x2d5/0x9d0 kernel/bpf/btf.c:1946
Code: ef e8 7f 8e e4 ff 41 83 ff 0b 77 28 f6 44 24 10 18 75 3f e8 6d 91
e4 ff 44 89 fe bf 0e 00 00 00 e8 20 8e e4 ff e8 5b 91 e4 ff <0f> 0b 45
31 f6 e9 98 02 00 00 41 83 ff 12 74 18 e8 46 91 e4 ff 44
RSP: 0018:ffffc90003cefb40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
RDX: ffff8880259c0000 RSI: ffffffff81968415 RDI: 0000000000000005
RBP: ffff88801270ca00 R08: 0000000000000005 R09: 000000000000000e
R10: 0000000000000011 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000011 R14: ffff888026ee6424 R15: 0000000000000011
FS:  000055555641b300(0000) GS:ffff8880b9a00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000f2e258 CR3: 000000007110e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btf_func_proto_check kernel/bpf/btf.c:4447 [inline]
 btf_check_all_types kernel/bpf/btf.c:4723 [inline]
 btf_parse_type_sec kernel/bpf/btf.c:4752 [inline]
 btf_parse kernel/bpf/btf.c:5026 [inline]
 btf_new_fd+0x1926/0x1e70 kernel/bpf/btf.c:6892
 bpf_btf_load kernel/bpf/syscall.c:4324 [inline]
 __sys_bpf+0xb7d/0x4cf0 kernel/bpf/syscall.c:5010
 __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
 __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5067
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0fbae41c69
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8aeb6228 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0fbae41c69
RDX: 0000000000000020 RSI: 0000000020000140 RDI: 0000000000000012
RBP: 00007f0fbae05e10 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007f0fbae05ea0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Looks like it tries to create a func_proto which return type is
decl_tag. For the details, see Martin's spot on analysis in [0].

0: https://lore.kernel.org/bpf/CAKH8qBuQDLva_hHxxBuZzyAcYNO4ejhovz6TQeVSk8HY-2SO6g@mail.gmail.com/T/#mea6524b3fcd6298347432226e81b1e6155efc62c

Cc: Yonghong Song <yhs@fb.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
Fixes: bd16dee66ae4 ("bpf: Add BTF_KIND_DECL_TAG typedef support")
Reported-by: syzbot+d8bd751aef7c6b39a344@syzkaller.appspotmail.com
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eba603cec2c5..35c07afac924 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4436,6 +4436,11 @@ static int btf_func_proto_check(struct btf_verifier_env *env,
 			return -EINVAL;
 		}
 
+		if (btf_type_is_resolve_source_only(ret_type)) {
+			btf_verifier_log_type(env, t, "Invalid return type");
+			return -EINVAL;
+		}
+
 		if (btf_type_needs_resolve(ret_type) &&
 		    !env_type_is_resolved(env, ret_type_id)) {
 			err = btf_resolve(env, ret_type, ret_type_id);
-- 
2.38.0.413.g74048e4d9e-goog

