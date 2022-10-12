Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8B5FCE20
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 00:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJLWIW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 18:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJLWHv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 18:07:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD208142CBB
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 15:06:04 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id mq15-20020a17090b380f00b0020ad26fa5edso2112841pjb.7
        for <bpf@vger.kernel.org>; Wed, 12 Oct 2022 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDe3yIdUsYj5isZjgp8M49Gc5ejUGlNAJHSilJvRTXY=;
        b=RjydvwJOw80w7ff/ve4wDSEZkH+pB5DcKq8VGWeRPgUMCqsR75juxv9p4XUwkOjoqo
         tiSxAMg1gH2JztJRnW8PPnfBR99Y+FjmVds2wyQIY32Ecynb3NHm7eCVa3GbpY1IU6OH
         bjlL8/px1LcZvEKqRDVTmtNj0o96ZBwE1anS+GhRyX8qyovudIJEylxoYvkK05DaoG3b
         1tQ8I7fj5/hmfV3WkxItsQ3i+PI7PORDpsDbcVc8r01hkCFygYjnYnYNSaG5cqE4RWDG
         /E294r192ZVX7cz0HDInKLVaKW4HWJ5iFe67GVhku2rymvVQnEKtq/vf2uARtRk7FIC4
         geMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDe3yIdUsYj5isZjgp8M49Gc5ejUGlNAJHSilJvRTXY=;
        b=c+FYjYOMDUTrIF5YzhAe3DEpxJe9gtrG1kcAk7NJWU2oIbboFqTUrYAkEQE17tStDo
         FjvLzUSp5eKFygU+0czUi8sO25frdLTyCmlgI6Z8Gkf5xrMCmzaAl57MyPVGXyJIipdO
         uCNcPG+EKv0SUN1IcCTqJJ0kGmxaVZn8ShtC3UGSQDC1b/mosTZSlCbQ0Eprf3tqAJCu
         wBeQMjcOkzsUB7FTw9qNXnZsG77wKOM9sbKvAWW57G8cywD3BUWwuFRz/hKLv8tb+jKg
         zmZZTUG2dwIS97fz9h7+QKnv+/maEgxaiA9NKmFhdNJoFB82USC2R2J5X3p2M/OY9i0A
         tj2Q==
X-Gm-Message-State: ACrzQf1Z2ZeqXlNkSsRPyxb5L9lhUhVp7hXb2xEuJJ3NwPVbI/UHEWz1
        LS0niKt25Jcvod5fxRNLDWzqrpELowqnt+MBWUvcF7rLhyDAPWOmGneiGbCbeX8pqjTl4++1QfI
        BlYPf9k25v6aL5mdndKNim9DFLwm3zxDdYSUWrjIkLEmMUbQ64w==
X-Google-Smtp-Source: AMsMyM7V9nZnG+YSSN+17GdxVTNKehy3i4yxrIYF+t0Pjn/ZEsKfd6BUQqMktdmjCJbuxq6XjxWjprU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:800a:0:b0:565:af23:f5a4 with SMTP id
 j10-20020aa7800a000000b00565af23f5a4mr4589035pfi.42.1665612276253; Wed, 12
 Oct 2022 15:04:36 -0700 (PDT)
Date:   Wed, 12 Oct 2022 15:04:34 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221012220434.3236596-1-sdf@google.com>
Subject: [PATCH bpf-next] bpf: remove WARN_ON_ONCE from btf_type_id_size
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+d8bd751aef7c6b39a344@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Syzkaller was able to hit it with the following reproducer:

bpf$BPF_BTF_LOAD(0x12, &(0x7f0000000140)=3D{&(0x7f0000001680)=3D{{0xeb9f, 0=
x1, 0x0, 0x18, 0x0, 0x34, 0x34, 0xc, [@fwd=3D{0xa}, @var=3D{0x3, 0x0, 0x0, =
0x11, 0x4, 0xffffffff}, @func_proto=3D{0x0, 0x0, 0x0, 0xd, 0x2}, @struct]},=
 {0x0, [0x0, 0x0, 0x5f, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x6c]}}, &(0x7f000000=
04c0)=3D""/4096, 0x58, 0x1000, 0x1}, 0x20)

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

Any reason we need that WARN_ON_ONCE in this place?
All callers except btf_array_check_member check the return value,
so it should be safe. Assuming btf_array_check_member should also be fine
because it hits 'btf_type_is_array()' condition.

Reported-by: syzbot+d8bd751aef7c6b39a344@syzkaller.appspotmail.com
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eba603cec2c5..999f62c697a7 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1943,8 +1943,8 @@ const struct btf_type *btf_type_id_size(const struct =
btf *btf,
 	} else if (btf_type_is_ptr(size_type)) {
 		size =3D sizeof(void *);
 	} else {
-		if (WARN_ON_ONCE(!btf_type_is_modifier(size_type) &&
-				 !btf_type_is_var(size_type)))
+		if (!btf_type_is_modifier(size_type) &&
+		    !btf_type_is_var(size_type))
 			return NULL;
=20
 		size_type_id =3D btf_resolved_type_id(btf, size_type_id);
--=20
2.38.0.rc1.362.ged0d419d3c-goog

