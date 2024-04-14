Return-Path: <bpf+bounces-26720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3B98A4202
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 13:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246141C20B02
	for <lists+bpf@lfdr.de>; Sun, 14 Apr 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27F136124;
	Sun, 14 Apr 2024 11:10:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144863DB97
	for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713093028; cv=none; b=rR+zbtVa+5m2pYgVyLCoXPjFiVphSkTCNZIlpSh26Uft8FcZ9hhzKPKxLVDL8WJ4UtSQ9hdcIS3qOp6eC/cr9c+JvWhPgABnPr27NEVDFV3/bnLFPsh5WT3QM7tJ1WqiuFE/7wpliCYWPc7BhhaXHJVdyhAtuDieIHgGogk5OLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713093028; c=relaxed/simple;
	bh=UuKeL2WcKRgqctSvEjKmBd6lMthB3+vcPL4dW8Jv3VY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oPnS4VJT8kfqGZ18zLyMtTfk5VnqJ19Kk7rvpmBVOqV3WIUfq7x5dfyVocSPmuZGCwSmjLQOQu0mOWepcr9uEj9yDcOfXD4n3jS/YXijFBG2uhXPg8O0ukaOjA9ntVZNmWrkO6lTY912scEica30aoewYagu5gn3I7JAFyEwf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a930922so316928039f.2
        for <bpf@vger.kernel.org>; Sun, 14 Apr 2024 04:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713093026; x=1713697826;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzmnxBjAYY26fFmUATQM9LcK9BACkrZL6MSaQ18rFTA=;
        b=npTqnY0K3z5GZAc72RPkp5Q83VEbyz69NYRXyHchJsWBwyOc3jA4c9heVnyaqC1+0+
         vuDRKbPIoWUKgP8NHAFwHpXD4OPtUguRTqtN5VY3tem6/6aYyGHXuN8GXJl/dAX1uXJc
         rABH3PC8kAMBmnBkVdb+HgjHsqzzD6l3YJgNu/Akh+h5MXS+GKGfp3PYaP170fA6hqQu
         WRSfqRMcpm/s6LaFSDkA8qbL9K/69asHHRqu/pF8/HX8QxTzE8YgyU6M7KxWB2E63BvT
         n2RMtbtvO+ARp7OTbJl1L/UNagdBwWpX9lVwNl5BrEMWc1HTUlqlIiTGweEw38Ns72uo
         v1rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF2V/rxRwa4gEAaFPT0aE6KRK+WSEYO63pIUQD3JNq4j2v+Tdz5Fu3EvE4o3OkRu6Wf34yCcFCb7DZrlg4MXm9iigQ
X-Gm-Message-State: AOJu0YyQ21rEW673t1iXYoHokyGF6g7lKkkzjdiF6p0R7mZjDrkAySU8
	23t+VRoF8LFYsRot115+yUnCyAwrENRt6Iu9V8mZrktadSl8oJehghYfxFiBt8XNSTQCjjKy5ZC
	2k6jxSHXIluqIhTeRIOl1r0VTj0a44Pa3UdlTXvUHBAZqu9RZBdDEdDQ=
X-Google-Smtp-Source: AGHT+IGxQxMusWloR5gS9iI5uuVX6/hg0xZUr/CXJrEZQv4+AzJ/A6Tf+txuVVShPLp7owE02/dTU9uIQW8lIgNVHT+XWrgbOw63
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3420:b0:7d0:ad03:af0b with SMTP id
 n32-20020a056602342000b007d0ad03af0bmr229319ioz.2.1713093026304; Sun, 14 Apr
 2024 04:10:26 -0700 (PDT)
Date: Sun, 14 Apr 2024 04:10:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004cf0fe06160c8d71@google.com>
Subject: [syzbot] [bpf?] KMSAN: uninit-value in htab_percpu_map_lookup_elem
From: syzbot <syzbot+0a079d6ef3831217a230@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c71fdf02a95 Merge tag 'drm-fixes-2024-04-09' of https://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=170425a1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5bc506ebba90cbf
dashboard link: https://syzkaller.appspot.com/bug?extid=0a079d6ef3831217a230
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16abe213180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ab97ad180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/36c01edd4b1e/disk-2c71fdf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7df598a3dceb/vmlinux-2c71fdf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/678bacfb883c/bzImage-2c71fdf0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a079d6ef3831217a230@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
BUG: KMSAN: uninit-value in htab_percpu_map_lookup_elem+0x3eb/0x4f0 kernel/bpf/hashtab.c:2302
 __htab_map_lookup_elem kernel/bpf/hashtab.c:691 [inline]
 htab_percpu_map_lookup_elem+0x3eb/0x4f0 kernel/bpf/hashtab.c:2302
 ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
 bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
 ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xb2/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x150/0x340 kernel/trace/bpf_trace.c:2422
 __bpf_trace_mm_page_alloc+0x37/0x50 include/trace/events/kmem.h:177
 trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
 __alloc_pages+0xdc0/0xe70 mm/page_alloc.c:4597
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 vma_alloc_folio+0x418/0x680 mm/mempolicy.c:2303
 wp_page_copy mm/memory.c:3263 [inline]
 do_wp_page+0x196c/0x66e0 mm/memory.c:3660
 handle_pte_fault mm/memory.c:5316 [inline]
 __handle_mm_fault mm/memory.c:5441 [inline]
 handle_mm_fault+0x5b76/0xce00 mm/memory.c:5606
 do_user_addr_fault arch/x86/mm/fault.c:1362 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x419/0x730 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:623

Local variable stack created at:
 __bpf_prog_run32+0x43/0xe0 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x150/0x340 kernel/trace/bpf_trace.c:2422

CPU: 0 PID: 5021 Comm: syz-executor180 Not tainted 6.9.0-rc3-syzkaller-00023-g2c71fdf02a95 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

