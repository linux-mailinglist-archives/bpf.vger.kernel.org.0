Return-Path: <bpf+bounces-65734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 911EEB27AE9
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 10:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A7664E3E2B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D62245007;
	Fri, 15 Aug 2025 08:26:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC223FC66
	for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755246403; cv=none; b=EE49waJmvA6wFzF7ZbRkthn8gISFcyn55svyAjTlIcOQsXvZWKD8P4bnOxWOjAOJNNpt0TIi3hVpdE0peu6kLMmOn+2ng0rmkXybIk0dwv+quFCy61nyjSOIq+VYM8kHGeRuu0bUekiGwH5d26N+RGm6eLsHipIygVd9DlLx2cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755246403; c=relaxed/simple;
	bh=3ve7iKESMsF0B8Ys7MhLsxvts0hFWeh3erqqJ1Tt9JE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=pivYsy2WeXqB4G8ZKBBoOh8Z2tOR4TBhWRdlViCHJP/B+mxXQw+OcXBAgRKodC1uO3LYIMWfvzq8I8MImKySFKwJCivU76IjqIwMIPRdvIRPdj0AnKMczdVRhQrsgOhS0n4BIujAx1fgfl5Kfoe5Zqzmy/7fBgBsz8CwTyCzOb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-88432e1630fso183280239f.2
        for <bpf@vger.kernel.org>; Fri, 15 Aug 2025 01:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755246400; x=1755851200;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psCDpMANufTkvWEr4sxBSKdwAioBx/+eng9D/goPmpc=;
        b=HlxVUE/vV11oaBLWPYZO8rxjdR/zTu9Czgy+/8buRBjVSYlJdkgxleSTZC/IBzs5ZR
         ONvccO/qzM/zYKXnMRGTutWZlWUvJj8Kosp2vTNl/ByP65zFGEiX8Ekott3B/sEv/uq0
         2r5DwUC4TJApSmk7CLWuat8JIwrE+Bj9A8lL4VUXlPtDAyl6r/LHPUmNUZ4pijs3OP/i
         dPhzeq9O3s+MmeqKKyqgc+LeP4dGy0Q3w96U7K88gBk/owPh3dpAHHzJSL6RCFDSBymA
         dSD9XDn1xkxBO7YUq/j/+/9m1xf69jqVDD+UkxVuNvnA11c3dVTbe1eR4LUZ1f1JIjKy
         qc8w==
X-Forwarded-Encrypted: i=1; AJvYcCVG2W7TJZhpBNdE/WtwuIqgO0t+PCcCW2W/6Cx0qISFArBriei/JaMBqvwrT1QELLL7pEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5PB2tQ6TzcpRW7f6zsaf1dLfFIO5r8chJgPX6HgcClNV7BE0
	WmhsnnCx996Pp4Lt/3Qdcpv31TQQq0Aglivzc/B8+lnwDggrhvkRIxUxTmghn027L84tEiilHDL
	/jWFjZnPWTqGvNPSWj2mkinwsLI44DHp73RU1yBbu0J/GuwThCKzG3vyq6ng=
X-Google-Smtp-Source: AGHT+IGB1hq4S2GjWl7gjYNWBAlDNbs/4rg1cIsswcnXz1R3JsSZrhdrz3A4LGfNrTUBomOAPWOEVHWmggGw8DoffPC7Bi0VSlEU
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6015:b0:876:c5ff:24d4 with SMTP id
 ca18e2360f4ac-8843e39e9d8mr331892039f.4.1755246400660; Fri, 15 Aug 2025
 01:26:40 -0700 (PDT)
Date: Fri, 15 Aug 2025 01:26:40 -0700
In-Reply-To: <20250813205526.2992911-1-kpsingh@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689eef40.050a0220.e29e5.0010.GAE@google.com>
Subject: [syzbot ci] Re: Signed BPF programs
From: syzbot ci <syzbot+cic1938c6466797c55@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bboscaccy@linux.microsoft.com, 
	bpf@vger.kernel.org, daniel@iogearbox.net, kpsingh@kernel.org, 
	kys@microsoft.com, linux-security-module@vger.kernel.org, paul@paul-moore.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] Signed BPF programs
https://lore.kernel.org/all/20250813205526.2992911-1-kpsingh@kernel.org
* [PATCH v3 01/12] bpf: Update the bpf_prog_calc_tag to use SHA256
* [PATCH v3 02/12] bpf: Implement exclusive map creation
* [PATCH v3 03/12] libbpf: Implement SHA256 internal helper
* [PATCH v3 04/12] libbpf: Support exclusive map creation
* [PATCH v3 05/12] selftests/bpf: Add tests for exclusive maps
* [PATCH v3 06/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
* [PATCH v3 07/12] bpf: Move the signature kfuncs to helpers.c
* [PATCH v3 08/12] bpf: Implement signature verification for BPF programs
* [PATCH v3 09/12] libbpf: Update light skeleton for signing
* [PATCH v3 10/12] libbpf: Embed and verify the metadata hash in the loader
* [PATCH v3 11/12] bpftool: Add support for signing BPF programs
* [PATCH v3 12/12] selftests/bpf: Enable signature verification for some lskel tests

and found the following issue:
general protection fault in bpf_verify_pkcs7_signature

Full report is available here:
https://ci.syzbot.org/series/67d9a289-da5c-4051-8c3c-cc32b6ccd77d

***

general protection fault in bpf_verify_pkcs7_signature

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      07866544e410e4c895a729971e4164861b41fad5
arch:      amd64
compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
config:    https://ci.syzbot.org/builds/1e87aafb-11dc-48f1-a980-c91551ba52de/config
C repro:   https://ci.syzbot.org/findings/0c329233-09a8-4e8b-9e6e-72f234dd85ab/c_repro
syz repro: https://ci.syzbot.org/findings/0c329233-09a8-4e8b-9e6e-72f234dd85ab/syz_repro

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 UID: 0 PID: 6001 Comm: syz.0.17 Not tainted 6.17.0-rc1-syzkaller-00022-g07866544e410-dirty #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:bpf_verify_pkcs7_signature+0x31/0x190 kernel/bpf/helpers.c:3835
Code: 41 56 41 55 41 54 53 48 89 d3 49 89 f6 49 89 ff 48 bd 00 00 00 00 00 fc ff df e8 aa b0 e0 ff 4c 8d 63 08 4c 89 e0 48 c1 e8 03 <0f> b6 04 28 84 c0 0f 85 01 01 00 00 41 80 3c 24 00 74 3d 48 89 d8
RSP: 0018:ffffc90002f7fa08 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff888020c51cc0
RDX: 0000000000000000 RSI: ffffc90002f7faa0 RDI: ffffc90002f7fac0
RBP: dffffc0000000000 R08: 0000000000000018 R09: ffffffff820b8a70
R10: ffffc90002f7fac0 R11: fffff520005eff5a R12: 0000000000000008
R13: 0000000000000010 R14: ffffc90002f7faa0 R15: ffffc90002f7fac0
FS:  00005555895fe500(0000) GS:ffff8881a3c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30b63fff CR3: 0000000028898000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 bpf_prog_verify_signature+0x2da/0x3b0 kernel/bpf/syscall.c:2815
 bpf_prog_load+0xcc4/0x19e0 kernel/bpf/syscall.c:2989
 __sys_bpf+0x507/0x860 kernel/bpf/syscall.c:6116
 __do_sys_bpf kernel/bpf/syscall.c:6226 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:6224 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:6224
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a4558ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff940250b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f0a457b5fa0 RCX: 00007f0a4558ebe9
RDX: 00000000000000a8 RSI: 0000200000000140 RDI: 0000000000000005
RBP: 00007f0a45611e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0a457b5fa0 R14: 00007f0a457b5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:bpf_verify_pkcs7_signature+0x31/0x190 kernel/bpf/helpers.c:3835
Code: 41 56 41 55 41 54 53 48 89 d3 49 89 f6 49 89 ff 48 bd 00 00 00 00 00 fc ff df e8 aa b0 e0 ff 4c 8d 63 08 4c 89 e0 48 c1 e8 03 <0f> b6 04 28 84 c0 0f 85 01 01 00 00 41 80 3c 24 00 74 3d 48 89 d8
RSP: 0018:ffffc90002f7fa08 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff888020c51cc0
RDX: 0000000000000000 RSI: ffffc90002f7faa0 RDI: ffffc90002f7fac0
RBP: dffffc0000000000 R08: 0000000000000018 R09: ffffffff820b8a70
R10: ffffc90002f7fac0 R11: fffff520005eff5a R12: 0000000000000008
R13: 0000000000000010 R14: ffffc90002f7faa0 R15: ffffc90002f7fac0
FS:  00005555895fe500(0000) GS:ffff8881a3c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30b63fff CR3: 0000000028898000 CR4: 00000000000006f0
----------------
Code disassembly (best guess):
   0:	41 56                	push   %r14
   2:	41 55                	push   %r13
   4:	41 54                	push   %r12
   6:	53                   	push   %rbx
   7:	48 89 d3             	mov    %rdx,%rbx
   a:	49 89 f6             	mov    %rsi,%r14
   d:	49 89 ff             	mov    %rdi,%r15
  10:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
  17:	fc ff df
  1a:	e8 aa b0 e0 ff       	call   0xffe0b0c9
  1f:	4c 8d 63 08          	lea    0x8(%rbx),%r12
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 01 01 00 00    	jne    0x137
  36:	41 80 3c 24 00       	cmpb   $0x0,(%r12)
  3b:	74 3d                	je     0x7a
  3d:	48 89 d8             	mov    %rbx,%rax


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

