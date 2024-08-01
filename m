Return-Path: <bpf+bounces-36243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4C94546A
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 00:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84AD9B22B01
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 22:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C0A14BF8D;
	Thu,  1 Aug 2024 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhtK9znP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0829314AA9;
	Thu,  1 Aug 2024 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722550050; cv=none; b=nPTgwXu+n73LCLDkHOgxwUbfwRgnTQVLh+B9VchXiGWYclWej9iMy7zfC6Fcf059QFtlYFA+z5Yo5TrIwykDapZ+SvOjmvs+URizS/r7rLQbo74VouvwO0ptbHt+Lmp4a0iVxwnpYfn/7mpzGgDkwikVoNnhQDV65vQKOW0KfjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722550050; c=relaxed/simple;
	bh=TOGLWNhF5p5GdZujCGl8jQTU/6I0l2GvAAxJ6TSUZZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=axIihhpiaCYfpah+T+DWBkp0Bk6k9llRrhFM867sGwa7MIuONlkitAPuaYhLBu6qWhKPBsKoDCJDzwFoQPsjd4jUadaOTxrJmhllN6o3tUq9cs+XXccqL2VfqErQUKb6M5wxLIyInWXLKGTqDA5DxNk5kC0ImXGMi0L9fboQre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhtK9znP; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cd34c8c588so4963731a91.0;
        Thu, 01 Aug 2024 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722550048; x=1723154848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYS2AEYCJtFtV57GQlwW8Fve/z77BhV+8pGxgsn8T3c=;
        b=BhtK9znP35JRp+1K6dDDp61EmsgD1KtFcEICpdb8ZdGB/FgFjUROtFiGwIhr+pkHW6
         PAm0H1HkEtpFP84vA94ckQOaCJOzbQo3JTPZv6rTf7yhV6gaVn4crZVQoE0AcDdQJNa/
         9bvPfwhKYiAQ4zLntcccSNExCc65iIGhd/gRWtcc29IPgm3AGUYoRlEmyAFnb70IkbkX
         yy4xbdAJWeLjPy9RC0WPtDUF931lkV4TmLgQjj6MUXFJDKnYXz1EkX1V74Y3Dfszmp3Y
         uWx6ORqXY/Wod9hr3d/kaZpuS7A7nWVK4iW4j+ko+Tt6p0xpLOLwyxLExGC/0frP1hdD
         sq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722550048; x=1723154848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYS2AEYCJtFtV57GQlwW8Fve/z77BhV+8pGxgsn8T3c=;
        b=ACf4AiOsLDrBWQI4cU0JVPSnSVpYg5Atpgn+VoWHnzr+kV/9TSa49W1/QmJd4Ao9ib
         KetTqz014DHxddumZBmLVHXFZCLlPzi6vHlg4gwd5taOEbo0MQFJQr782TQpOWJBXt7v
         o5R3jz3M+thTzKejGTr3iN25bRn5pAK06rZ7GzgLZ5zT1I8IK9T54kx3x6/HK426+5+G
         fOktamixvuxGhInUNxBxilqd97ORyrI0P0MBQHiN51tKg9MU0KxN8nEK4d99YHUqgRp+
         kBRviC/mT6jmJPsRyGZObn3X4qltHUUmPLOabrjhb8CPj4z3ZgsEF0I345dQf1qVTZmH
         QxGA==
X-Forwarded-Encrypted: i=1; AJvYcCXtjlEX67416kxeSR5A8zOdWdmTuF5Hg2V6f0ghkZHDG3gVAKtkX9AACEyQxHcatJaxBETUdOd7UMp9eH+gi+RxxeC4nJCm9ZQtB4t6Y1CzgkmUGKO0Iiiniw7kcs/6N3Gz
X-Gm-Message-State: AOJu0YwQr4KDLxQJI5nmDQzh2r9yHNgjeLjKBXLrZ0E4xAlPqswEKXTS
	ButFVp+nTtprL2RSIruk3qKhbZUifHIBbfg/AKe5L3HeGwHhvlVUMpuMPJnAn6uC3NBNZFv6gYm
	SXNfaBb9welBT7cHIJzvr9U/5iik=
X-Google-Smtp-Source: AGHT+IHQK6y9k7j/mCUctFTdzErlU6p5TueNCtHJNqwCPDs0USArBcJj3E9BZexY9dQVdpyl4EEOBT5flVw8ETwXPgA=
X-Received: by 2002:a17:90b:2790:b0:2c9:6f06:8009 with SMTP id
 98e67ed59e1d1-2cff93d59e1mr2109379a91.1.1722550048009; Thu, 01 Aug 2024
 15:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731214256.3588718-1-andrii@kernel.org> <20240731214256.3588718-3-andrii@kernel.org>
In-Reply-To: <20240731214256.3588718-3-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 Aug 2024 15:07:15 -0700
Message-ID: <CAEf4BzYZ7yudWK2ff4nZr36b1yv-wRcN+7WM9q2S2tGr6cV=rA@mail.gmail.com>
Subject: Re: [PATCH 2/8] uprobes: revamp uprobe refcounting and lifetime management
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 2:43=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Revamp how struct uprobe is refcounted, and thus how its lifetime is
> managed.
>
> Right now, there are a few possible "owners" of uprobe refcount:
>   - uprobes_tree RB tree assumes one refcount when uprobe is registered
>     and added to the lookup tree;
>   - while uprobe is triggered and kernel is handling it in the breakpoint
>     handler code, temporary refcount bump is done to keep uprobe from
>     being freed;
>   - if we have uretprobe requested on a given struct uprobe instance, we
>     take another refcount to keep uprobe alive until user space code
>     returns from the function and triggers return handler.
>
> The uprobe_tree's extra refcount of 1 is confusing and problematic. No
> matter how many actual consumers are attached, they all share the same
> refcount, and we have an extra logic to drop the "last" (which might not
> really be last) refcount once uprobe's consumer list becomes empty.
>
> This is unconventional and has to be kept in mind as a special case all
> the time. Further, because of this design we have the situations where
> find_uprobe() will find uprobe, bump refcount, return it to the caller,
> but that uprobe will still need uprobe_is_active() check, after which
> the caller is required to drop refcount and try again. This is just too
> many details leaking to the higher level logic.
>
> This patch changes refcounting scheme in such a way as to not have
> uprobes_tree keeping extra refcount for struct uprobe. Instead, each
> uprobe_consumer is assuming its own refcount, which will be dropped
> when consumer is unregistered. Other than that, all the active users of
> uprobe (entry and return uprobe handling code) keeps exactly the same
> refcounting approach.
>
> With the above setup, once uprobe's refcount drops to zero, we need to
> make sure that uprobe's "destructor" removes uprobe from uprobes_tree,
> of course. This, though, races with uprobe entry handling code in
> handle_swbp(), which, through find_active_uprobe()->find_uprobe() lookup,
> can race with uprobe being destroyed after refcount drops to zero (e.g.,
> due to uprobe_consumer unregistering). So we add try_get_uprobe(), which
> will attempt to bump refcount, unless it already is zero. Caller needs
> to guarantee that uprobe instance won't be freed in parallel, which is
> the case while we keep uprobes_treelock (for read or write, doesn't
> matter).
>
> Note also, we now don't leak the race between registration and
> unregistration, so we remove the retry logic completely. If
> find_uprobe() returns valid uprobe, it's guaranteed to remain in
> uprobes_tree with properly incremented refcount. The race is handled
> inside __insert_uprobe() and put_uprobe() working together:
> __insert_uprobe() will remove uprobe from RB-tree, if it can't bump
> refcount and will retry to insert the new uprobe instance. put_uprobe()
> won't attempt to remove uprobe from RB-tree, if it's already not there.
> All that is protected by uprobes_treelock, which keeps things simple.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 163 +++++++++++++++++++++++-----------------
>  1 file changed, 93 insertions(+), 70 deletions(-)
>

[...]

> @@ -1094,17 +1120,12 @@ void uprobe_unregister(struct uprobe *uprobe, str=
uct uprobe_consumer *uc)
>         int err;
>
>         down_write(&uprobe->register_rwsem);
> -       if (WARN_ON(!consumer_del(uprobe, uc)))
> +       if (WARN_ON(!consumer_del(uprobe, uc))) {
>                 err =3D -ENOENT;
> -       else
> +       } else {
>                 err =3D register_for_each_vma(uprobe, NULL);
> -
> -       /* TODO : cant unregister? schedule a worker thread */
> -       if (!err) {
> -               if (!uprobe->consumers)
> -                       delete_uprobe(uprobe);
> -               else
> -                       err =3D -EBUSY;
> +               /* TODO : cant unregister? schedule a worker thread */
> +               WARN(err, "leaking uprobe due to failed unregistration");

Ok, so now that I added this very loud warning if
register_for_each_vma(uprobe, NULL) returns error, it turns out it's
not that unusual for this unregistration to fail. If I run my
uprobe-stress for just a little bit, and then terminate it with ^C, I
get this splat:

[ 1980.854229] leaking uprobe due to failed unregistration
[ 1980.854244] WARNING: CPU: 3 PID: 23013 at
kernel/events/uprobes.c:1123 uprobe_unregister_nosync+0x68/0x80
[ 1980.855356] Modules linked in: aesni_intel(E) crypto_simd(E)
cryptd(E) kvm_intel(E) kvm(E) floppy(E) i2c_piix4(E) i2c_]
[ 1980.856746] CPU: 3 UID: 0 PID: 23013 Comm: exe Tainted: G        W
OE      6.11.0-rc1-00032-g308d1f294b79 #129
[ 1980.857407] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[ 1980.857788] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04
[ 1980.858489] RIP: 0010:uprobe_unregister_nosync+0x68/0x80
[ 1980.858826] Code: 6e fb ff ff 4c 89 e7 89 c3 e8 24 e8 e3 ff 85 db
75 0c 5b 48 89 ef 5d 41 5c e9 84 e5 ff ff 48 c7 c7 d0
[ 1980.860052] RSP: 0018:ffffc90002fb7e58 EFLAGS: 00010296
[ 1980.860428] RAX: 000000000000002b RBX: 00000000fffffffc RCX: 00000000000=
00000
[ 1980.860913] RDX: 0000000000000002 RSI: 0000000000000027 RDI: 00000000fff=
fffff
[ 1980.861379] RBP: ffff88811159ac00 R08: 00000000fffeffff R09: 00000000000=
00001
[ 1980.861871] R10: 0000000000000000 R11: ffffffff83299920 R12: ffff8881115=
9ac20
[ 1980.862340] R13: ffff88810153c7a0 R14: ffff88810c3fe000 R15: 00000000000=
00000
[ 1980.862830] FS:  0000000000000000(0000) GS:ffff88881ca00000(0000)
knlGS:0000000000000000
[ 1980.863370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1980.863758] CR2: 00007fa08aea8276 CR3: 000000010f59c005 CR4: 00000000003=
70ef0
[ 1980.864239] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1980.864708] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1980.865202] Call Trace:
[ 1980.865356]  <TASK>
[ 1980.865524]  ? __warn+0x80/0x180
[ 1980.865745]  ? uprobe_unregister_nosync+0x68/0x80
[ 1980.866074]  ? report_bug+0x18d/0x1c0
[ 1980.866326]  ? handle_bug+0x3a/0x70
[ 1980.866568]  ? exc_invalid_op+0x13/0x60
[ 1980.866836]  ? asm_exc_invalid_op+0x16/0x20
[ 1980.867098]  ? uprobe_unregister_nosync+0x68/0x80
[ 1980.867390]  ? uprobe_unregister_nosync+0x68/0x80
[ 1980.867726]  bpf_uprobe_multi_link_release+0x31/0xd0
[ 1980.868044]  bpf_link_free+0x54/0xd0
[ 1980.868267]  bpf_link_release+0x17/0x20
[ 1980.868542]  __fput+0x102/0x2e0
[ 1980.868760]  task_work_run+0x55/0xa0
[ 1980.869027]  syscall_exit_to_user_mode+0x1dd/0x1f0
[ 1980.869344]  do_syscall_64+0x70/0x140
[ 1980.869603]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1980.869923] RIP: 0033:0x7fa08aea82a0
[ 1980.870171] Code: Unable to access opcode bytes at 0x7fa08aea8276.
[ 1980.870587] RSP: 002b:00007ffe838cd030 EFLAGS: 00000202 ORIG_RAX:
000000000000003b
[ 1980.871098] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[ 1980.871563] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[ 1980.872055] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[ 1980.872526] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[ 1980.873044] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[ 1980.873568]  </TASK>


I traced it a little bit with retsnoop to figure out where this is
coming from, and here we go:

14:53:18.897165 -> 14:53:18.897171 TID/PID 23013/23013 (exe/exe):

FUNCTION CALLS                RESULT    DURATION
---------------------------   --------  --------
=E2=86=92 uprobe_write_opcode
    =E2=86=92 get_user_pages_remote
        =E2=86=94 __get_user_pages    [-EINTR]   1.382us
    =E2=86=90 get_user_pages_remote   [-EINTR]   4.889us
=E2=86=90 uprobe_write_opcode         [-EINTR]   6.908us

                   entry_SYSCALL_64_after_hwframe+0x76
(entry_SYSCALL_64 @ arch/x86/entry/entry_64.S:130)
                   do_syscall_64+0x70
(arch/x86/entry/common.c:102)
                   syscall_exit_to_user_mode+0x1dd
(kernel/entry/common.c:218)
                   . __syscall_exit_to_user_mode_work
(kernel/entry/common.c:207)
                   . exit_to_user_mode_prepare
(include/linux/entry-common.h:328)
                   . exit_to_user_mode_loop
(kernel/entry/common.c:114)
                   . resume_user_mode_work
(include/linux/resume_user_mode.h:50)
                   task_work_run+0x55                   (kernel/task_work.c=
:222)
                   __fput+0x102                         (fs/file_table.c:42=
2)
                   bpf_link_release+0x17
(kernel/bpf/syscall.c:3116)
                   bpf_link_free+0x54
(kernel/bpf/syscall.c:3067)
                   bpf_uprobe_multi_link_release+0x31
(kernel/trace/bpf_trace.c:3198)
                   . bpf_uprobe_unregister
(kernel/trace/bpf_trace.c:3186)
                   uprobe_unregister_nosync+0x42
(kernel/events/uprobes.c:1120)
                   register_for_each_vma+0x427
(kernel/events/uprobes.c:1092)
     6us [-EINTR]  uprobe_write_opcode+0x79
(kernel/events/uprobes.c:478)
                   . get_user_page_vma_remote
(include/linux/mm.h:2489)
     4us [-EINTR]  get_user_pages_remote+0x109          (mm/gup.c:2627)
                   . __get_user_pages_locked            (mm/gup.c:1762)
!    1us [-EINTR]  __get_user_pages


So, we do uprobe_unregister -> register_for_each_vma ->
remove_breakpoint -> set_orig_insn -> uprobe_write_opcode ->
get_user_page_vma_remote -> get_user_pages_remote ->
__get_user_pages_locked -> __get_user_pages and I think we then hit
`if (fatal_signal_pending(current)) return -EINTR;` check.


So, is there something smarter we can do in this case besides leaking
an uprobe (and note, my changes don't change this behavior)?

I can of course just drop the WARN given it's sort of expected now,
but if we can handle that more gracefully it would be good. I don't
think that should block optimization work, but just something to keep
in mind and maybe fix as a follow up.


>         }
>         up_write(&uprobe->register_rwsem);
>

[...]

