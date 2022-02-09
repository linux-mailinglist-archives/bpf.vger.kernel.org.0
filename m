Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27274AEAB6
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 08:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiBIHDa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 02:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiBIHD1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 02:03:27 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0613C0613CB
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 23:03:30 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id w1so1439253plb.6
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 23:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K1tE6ZW/NUDkpxrW0ZRNI1iBfcwyP1tiyNWTroz+6QI=;
        b=XWgaMd+wEZQ+EKhGBWjbIg0BSTIIjSyYW9BIi15jCU8aa12vnEowmHQPInjm7Gl6Xj
         EhV/lnxUckYV6VIgjZyAzIDoKIEvzl4q4N8OGkgnLIW8o9kLMlPVcTRJhSaaxLWjFyKG
         QKRD8GaX7C5VnzndkBmfVuvqAY6Ew3vvmHc1/ZSVGrluh36mp3fCxjgp7ZvZ0gkiKy4p
         kAx0GUccemRmHd98TIZP6Ic7lzLZVtm+YPPTX2yqnNyY/lI+LPCUzzaPFzfLPnja7UGV
         ETYA77vhj0TDxAUeIqWfWa7FUczYVjTH1cU7koAJHEo1PNQKL3cnbJb6uae8QZjcnQXF
         yy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K1tE6ZW/NUDkpxrW0ZRNI1iBfcwyP1tiyNWTroz+6QI=;
        b=7ckbaWHXTOfFcjY2J3342lgozcUGm0D3WSz5JRdyk41jri7K9BOSVhl2klMO6OPoU6
         BlNkubg0ku7+sICL2tE0QZ+Weoq8w5fGUK4lMALk8fX4aWgaLQ+eOiqoMKjbYQeIIYa0
         C1c9YPZPBqURic9CF/NKlk4ya6S7yMfLgS+yOBmBfVWF7HcHGzJkie8hbChvkqaHM+pO
         rhFwdGUC07NoHAXZNwy/3AK5KJdIONdz108jSA7VQ9QW0pMBdoMuK5yxSHk0o/Smg5QV
         i3AR/1Y8E+uE2d3KM8UiRv4DcPDFTyInrX8UlHR0PYlUTIzD+qI6OFWbtMDEnDTqJpzI
         ofNQ==
X-Gm-Message-State: AOAM531eKIeNAYKpM/8Ze5jPeAOWkChy0x8OUz5KRbTd6uxuVmfv7UAo
        mOBC2JgxyDp69uYcXPnsB1U7n7VbNIg=
X-Google-Smtp-Source: ABdhPJxfHgo+SujcOap2AbHN07JYqTHEX3fH+5aw8G5hyq/KmR3Irf5XP7sx2TVjOq5UxYzThYQ0+w==
X-Received: by 2002:a17:90b:1b46:: with SMTP id nv6mr1039044pjb.178.1644390210328;
        Tue, 08 Feb 2022 23:03:30 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id b12sm17524650pfm.154.2022.02.08.23.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 23:03:30 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v2 1/2] bpf: Fix crash due to incorrect copy_map_value
Date:   Wed,  9 Feb 2022 12:33:23 +0530
Message-Id: <20220209070324.1093182-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220209070324.1093182-1-memxor@gmail.com>
References: <20220209070324.1093182-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3899; h=from:subject; bh=9R9wYd4Dv3KVqE+B05p0sZedNr6tZnbW7fB/57aUdZU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiA2cPHKFZmbwVDSids4zQGnGpNYCXe75oK5SsEV1C GdTS93yJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYgNnDwAKCRBM4MiGSL8RykoCD/ 9MzvQroXyT18GRVVFcRkOQkunj4+ynaLtJKRo+6wUIUcy2//c0135xIU8x3w2wklbioyAhkBzapZRa zSm+8IN8CMBHJo40HjQYGKfDBOiqnDRrpvBcMy/F0j9EtZxkCWAjTITyLE8H3ADBmE7O5Rqav8x6+s 7q5E1QNSEP0vGLtqBZNm9/N8mwVyqqhSQEQfqAz/ZZlyy5ADP7FZb8z153uTUvfukGCyxbYajeCNNF 2Pep/wHoqiHiRItF5ZxVy/PmwwMqFoUtWy7qmLYrh+zH05XhmI0+gJJvhDndhNp99vz+bLCnWm/6HD LRLoMTY01zj9qolXoljwqLbLuRMr3klMRP34Nuy14SldJv2rHPelo0Iz3wq2BZ0Gi2a1aGA9pARVoB Wrk4/m3kHgGnyI1wixRWSqbSz+Pum4MWQ5b4G933TW7xLHccGuSd5PrFr0GyGORVbdrs5M+ydzRwB2 vJ9iWWOx5Rt8aQJTieNQfqH6NNE7nPkPZMwPvpPgD9N5wyZMMeoLanxtvx7qNFTw175HTOLtAXc3xL 2RuCoHfwWNRmNnrwuVBquf+sMM2EEfDtn6kO/vKzEKlTKeO5Qu7SmOybW5G+Q4obUcubOa0J/KoQt7 dwbwsqVrG1laVZINLtIeixVZD7hpaxPOzP1aC8J8u0iV5HPvT5+oGELUCCnA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When both bpf_spin_lock and bpf_timer are present in a BPF map value,
copy_map_value needs to skirt both objects when copying a value into and
out of the map. However, the current code does not set both s_off and
t_off in copy_map_value, which leads to a crash when e.g. bpf_spin_lock
is placed in map value with bpf_timer, as bpf_map_update_elem call will
be able to overwrite the other timer object.

When the issue is not fixed, an overwriting can produce the following
splat:

[root@(none) bpf]# ./test_progs -t timer_crash
[   15.930339] bpf_testmod: loading out-of-tree module taints kernel.
[   16.037849] ==================================================================
[   16.038458] BUG: KASAN: user-memory-access in __pv_queued_spin_lock_slowpath+0x32b/0x520
[   16.038944] Write of size 8 at addr 0000000000043ec0 by task test_progs/325
[   16.039399]
[   16.039514] CPU: 0 PID: 325 Comm: test_progs Tainted: G           OE     5.16.0+ #278
[   16.039983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.15.0-1 04/01/2014
[   16.040485] Call Trace:
[   16.040645]  <TASK>
[   16.040805]  dump_stack_lvl+0x59/0x73
[   16.041069]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
[   16.041427]  kasan_report.cold+0x116/0x11b
[   16.041673]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
[   16.042040]  __pv_queued_spin_lock_slowpath+0x32b/0x520
[   16.042328]  ? memcpy+0x39/0x60
[   16.042552]  ? pv_hash+0xd0/0xd0
[   16.042785]  ? lockdep_hardirqs_off+0x95/0xd0
[   16.043079]  __bpf_spin_lock_irqsave+0xdf/0xf0
[   16.043366]  ? bpf_get_current_comm+0x50/0x50
[   16.043608]  ? jhash+0x11a/0x270
[   16.043848]  bpf_timer_cancel+0x34/0xe0
[   16.044119]  bpf_prog_c4ea1c0f7449940d_sys_enter+0x7c/0x81
[   16.044500]  bpf_trampoline_6442477838_0+0x36/0x1000
[   16.044836]  __x64_sys_nanosleep+0x5/0x140
[   16.045119]  do_syscall_64+0x59/0x80
[   16.045377]  ? lock_is_held_type+0xe4/0x140
[   16.045670]  ? irqentry_exit_to_user_mode+0xa/0x40
[   16.046001]  ? mark_held_locks+0x24/0x90
[   16.046287]  ? asm_exc_page_fault+0x1e/0x30
[   16.046569]  ? asm_exc_page_fault+0x8/0x30
[   16.046851]  ? lockdep_hardirqs_on+0x7e/0x100
[   16.047137]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   16.047405] RIP: 0033:0x7f9e4831718d
[   16.047602] Code: b4 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 6c 0c 00 f7 d8 64 89 01 48
[   16.048764] RSP: 002b:00007fff488086b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000023
[   16.049275] RAX: ffffffffffffffda RBX: 00007f9e48683740 RCX: 00007f9e4831718d
[   16.049747] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff488086d0
[   16.050225] RBP: 00007fff488086f0 R08: 00007fff488085d7 R09: 00007f9e4cb594a0
[   16.050648] R10: 0000000000000000 R11: 0000000000000206 R12: 00007f9e484cde30
[   16.051124] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   16.051608]  </TASK>
[   16.051762] ==================================================================

Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fa517ae604ad..31a83449808b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -224,7 +224,8 @@ static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
 	if (unlikely(map_value_has_spin_lock(map))) {
 		s_off = map->spin_lock_off;
 		s_sz = sizeof(struct bpf_spin_lock);
-	} else if (unlikely(map_value_has_timer(map))) {
+	}
+	if (unlikely(map_value_has_timer(map))) {
 		t_off = map->timer_off;
 		t_sz = sizeof(struct bpf_timer);
 	}
-- 
2.35.1

