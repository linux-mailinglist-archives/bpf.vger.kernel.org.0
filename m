Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F2B4AE8F6
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 06:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiBIFOh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 00:14:37 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347554AbiBIFLP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 00:11:15 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125B2C03E938
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 21:11:20 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id y18so1224049plb.11
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 21:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=01k5/ofkARbUi2P52ozVv/VlcCyx84Q7XncP8rRy6bo=;
        b=igdpaeA7NuSszrEiMZdr9Hbr3i8fM2qR0jFWYbMZA0mXp6Qsl+DoNvleHTwBDCKvv5
         k3/mEJs/WUa4ceMLa75uZgtP4VT3MtQXWfMfTP1TRPM4463J7fF1/IToXRbvNrZO17Lb
         jmjZWTDsNpGKBlh8oahVjF5oFNaFxiRbS2cq+pTmwZmYt0JgmqPuLseQxidsGWzMMI0b
         WMJe2ExRvDx7+PlJ7ZRFPIJ7ihzakfrGlpj/K5rUwqEvm68G5ZlEX9JqS6EEBSzv+KHB
         hRUZa8TY4VLABvVEAUHRuJ+EJCOiX63YTHLp+LR2/nxgKxfmVWuKLAfGGX4pbsZvrhY8
         KBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=01k5/ofkARbUi2P52ozVv/VlcCyx84Q7XncP8rRy6bo=;
        b=FO/q+/FdBiAyz7o6gF/Bql/bAQgyAULQJetIjeyMSMKw32YJpd9NVTLIxI2VHNp+wm
         OwCt6zQZiZlAfOGlY6m55H9HXvlBqF5gxyYCL8y4USyhAlEpF2Q9tI/vpSzO/ovXE0og
         +ytwmVHQgOCtVv6X+Nwfmzd/vs6PH7b3CZCeYnRCJLTt7QW3otnEzlUFhmDj55ULWcyW
         W9DTcX1mJGDvOBye8ZJXep6FIjjWmFiqxG3prEmNkW0EEjFc9mJ9cLsBjvz+84sAcrMW
         6WXIm5cAN9kDMOvIS+LTGvs+o+cHEBIr8APC8C2SXsrtVFTwQLmJvTRJgLf3sQggb4Ya
         +Idw==
X-Gm-Message-State: AOAM531zYaA9eG/fG6+yxbm59laSX+6UYfbVjfa7QvAAWbR/f8OouDY0
        uIh6+zBhJ6Rncj/F80F1Kbc2mVZOzfI=
X-Google-Smtp-Source: ABdhPJzOVPfIjk8Hil7OC9yn0m1vnaSa5HpaQv+IIZ8vkRlujv6UrWSSycJNB4MP93FCvtpnrP908w==
X-Received: by 2002:a17:902:8d81:: with SMTP id v1mr597526plo.20.1644383479386;
        Tue, 08 Feb 2022 21:11:19 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id b2sm12688598pgg.59.2022.02.08.21.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:11:19 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v1 1/2] bpf: Fix crash due to incorrect copy_map_value
Date:   Wed,  9 Feb 2022 10:41:12 +0530
Message-Id: <20220209051113.870717-2-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220209051113.870717-1-memxor@gmail.com>
References: <20220209051113.870717-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3899; h=from:subject; bh=IkfYRapMFL4pUGazXseOwNHacucDDERndd6ZAO0gZ6s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiA0yOEHAJVunivvzGoKEDA+676ALs+Ilfl8iDgO73 bwcplG6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYgNMjgAKCRBM4MiGSL8Ryj9yEA DCPzQlLzvz+0AbCYfIpUXV6LNns8XZn+gHe7uSBpwmgmCo0ImtgBLH2GY9btVKuKXra3uxY8ZlWRh4 ndUggrNfzk9kfFcDDEGX2zwIYC8RKI7A+7N7Lo+GFI7W+UM5jbuNA/xWTlTxIwLAbLtfl5anPHMer9 /otsaSLUh1qNZfCfYpGXcoagPsVpcnyFakFNi/gnYi4w0bqRTbCwhJ3E10Dsod2iSkFaPBVPsDhfEL OWczH2d6O8vcPG0He4593P8AiJzoTDwsgqBouExmg2okM2+yZUXjUeaIO3jgxRu6qZ5fADrjwzndhV rAqNT2zRQYQ4TeHThNU1N0RTeiF+8a+ReBL0JIKbw+e+Pba92TVooFDtGA2bPlYHbyR+xnBsc/mXAP grTuS6S6nFj/b96O3xpTjM9BSNp1q8m4TkM4Q81ZGCB22LlCpBn+jqCe6rn/GdxUGMtZOvKjZPn7HR LBrqPwlnL01mi+Al8FuZjg/PI6swcP52FkVBfmMiSjhQFl+wDUoSs9ECbzLqC7l5VGwE2++RelLcub XXgIKExxx05jmCZ7tT1QWtVTT0XAzJ9BBZ2fjg1mrPfc1xndSasWCVnYKFRoGEs4Qtak4+RuIGR7gP 0T+Hnv7EQIVFOblW9bi8G47AoefJWsVMtmgOEKtD660MGPwu9oEQC6n+iIXw==
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
index 2fc7e5c5ef41..c1c554249698 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -235,7 +235,8 @@ static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
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

