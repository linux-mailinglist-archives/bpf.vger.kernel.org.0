Return-Path: <bpf+bounces-65063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB9B1B550
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 15:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEF318A52FA
	for <lists+bpf@lfdr.de>; Tue,  5 Aug 2025 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226A272E6B;
	Tue,  5 Aug 2025 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vdp3mqg5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB423C8A0;
	Tue,  5 Aug 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401988; cv=none; b=c6ACfRio1J9+H//HUlRJ9mqmocISdbnvHv31qnxIcqc5LkeK5n0kxDthlgnnIJr63309GghnW1xUF+SEpBCfl6QfOIUAbsrwaSyaGa7ye8qbevwUS7LI2v5Z1hElvGM+wz2WTUu73QxV+PWAqkcYIgX77pOtFmOqS/ZYe9XuNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401988; c=relaxed/simple;
	bh=uuwQYFV4a8rDtlwIuIlrsfmkSaWzwwcDNhpynZHllK4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHIFXZqZ9Av/M3bw0rUlbn0apncW2tKZAwP8eB8V2YTn70l3IG4FAvSMRdzM3c2IS9G/MhnrXFXHSAs6mha6fgwrvVJRvBLBNQBbFHF4DOQg4/q4bBEEuRN7yHZKMl5JEiFqj7rlubpz19XMpTWGuEu3fUYDuPN7vBA/YDnBwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vdp3mqg5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so10019380a12.2;
        Tue, 05 Aug 2025 06:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754401985; x=1755006785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SH1wB8Gi2MTnYi6+BkNp7a0JXjEXXABO2XTD+pj/4Ys=;
        b=Vdp3mqg5i+7uIYgCuTClm2YtIkN9THHFI55GBUIRoEyZa02/sjtzxQnaTaDbAY/zA2
         Hfw51fm4Tt/bFUkw/nuxyq4SZWpbY95ppQ9AdlIabywhCd3hnZ5Cns8S1KGbUz9MsGEf
         I7aEUiWB5E6kZWwHmGXtb9XD5fXkv5zTxCKrhc1ahrpPBShXyxdsL8dsEsF3OlihKrmU
         +jWB6FCTi66AeFVfyEa4FTKoJzlGBONiO7BS8tdQ4sKX9i44wz0ShTFuskE6DOvBRcmw
         gZchHyetYx7pm+YeKS04daTWBjDdjjay+ZoAKgMxWA9zzHBwlm0Qcb234Fwragb2+D0I
         g3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754401985; x=1755006785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH1wB8Gi2MTnYi6+BkNp7a0JXjEXXABO2XTD+pj/4Ys=;
        b=a++TBPHWs1ouZE4n+AcoVJzN0PrvOx3CjkadFs/vNw+UJE/ZkYJzuNcNjn1u6GE6Ig
         NrAHzsvPa/tyPxL6FwfMCzitqJJ7/80sJuWghN2liGSCqtplMJ4qBZVgAo67CAAxVwFv
         FU5BeKcoW/6JmHswvRvxfYd/pcjKDZSMVUOGS5wy086SX3YKMyS+EzJV3n3srPM02phK
         p88T0868G8h5VOKdBq3FQGt/QdjKPQyo/FJxGh9dGkxMZIB8hPnAxr/IP3tr48TG53Mw
         DbD0Yoxmbx2uV9IYMat+gCXvgJkWIpnxdX61wY3tmF8ANvB4I8czVPMwdqX11X/fU3pj
         9kTA==
X-Forwarded-Encrypted: i=1; AJvYcCW6vw7bglLPXq1xNzlN2R8EmHUFWM6NLpQ3CrTKjgsm5+zEhsDuoht1WdMrza8Ckq3eESgaJLPZvDtPSeYj@vger.kernel.org, AJvYcCWmMtGYVLd1TmbH84CGdm7+oeJ7bLic9iwXlEJIzlAsY0iI+3b9xZEIjpEyyPgCllGZmn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKDprHF5wWKZepUH3wcEg4SqUDVHdvDODv/UpC34R6ah2MB2c
	peu7ZPIuupOR8psERkqhlA9JlFTi1l/wXuUjl8aNxwJT6eqbRnM2Wyt0
X-Gm-Gg: ASbGncv98iDCYBMgCptaDYQkjRqWtT7Yq/ABnAnLiL5ibQaGr6IpWtDYQCBedY5Msye
	BuVU+THFqIL43+wWBEBVg6RjxJYMQyx2ZFzqz7mBi5CrWpOwmjZ6wRynj4ZRkSUr2/TFU9Bsrh9
	i6898qvJoJjJxbjdXr02u4c8XfrAffGemlkFco9SMKJuA2PLGVnhEtim+uCuW5sYiJ4D8WDUnDI
	RvNDkZD5bnV00p00O2xLOCXxw1fjvcw2g13+GNBYjlTwnTgVimWAeEWIT4i9FzYwJtFMPNt3uEp
	paQjrtVoPIL6ybz54ZW/cYIp9FDw2D5H3IgkOmM0orvTR5SSM6XEsVoqSMv+wJE5jvlK86dnGAH
	1LReQD/i/
X-Google-Smtp-Source: AGHT+IGoSl1mkAheWodWVeOU3uzc15i8AALpv4FagRrIF4NjBlKoPu/lc/rbUwjVmUBEXiRsZnKNSQ==
X-Received: by 2002:a05:6402:3593:b0:60e:404:a931 with SMTP id 4fb4d7f45d1cf-615e6f015fcmr12107295a12.15.1754401984876;
        Tue, 05 Aug 2025 06:53:04 -0700 (PDT)
Received: from krava ([173.38.220.35])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f15fa5sm8297145a12.14.2025.08.05.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 06:53:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Aug 2025 15:53:02 +0200
To: syzbot <syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING in do_misc_fixups
Message-ID: <aJIMvndTxgUzLC9F@krava>
References: <68904050.050a0220.7f033.0001.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68904050.050a0220.7f033.0001.GAE@google.com>

On Sun, Aug 03, 2025 at 10:08:32PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a6923c06a3b2 Merge tag 'bpf-fixes' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1561dcf0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f89bb9497754f485
> dashboard link: https://syzkaller.appspot.com/bug?extid=a9ed3d9132939852d0df
> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165d0aa2580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117bd834580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-a6923c06.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9862ca8219e0/vmlinux-a6923c06.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/042ebe320cfd/Image-a6923c06.gz.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a9ed3d9132939852d0df@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> verifier bug: not inlined functions bpf_probe_read_kernel_str#115 is missing func(1)
> WARNING: CPU: 1 PID: 3594 at kernel/bpf/verifier.c:22838 do_misc_fixups+0x1784/0x1ab4 kernel/bpf/verifier.c:22838
> Modules linked in:
> CPU: 1 UID: 0 PID: 3594 Comm: syz.2.17 Not tainted 6.16.0-syzkaller-11105-ga6923c06a3b2 #0 PREEMPT 
> Hardware name: linux,dummy-virt (DT)
> pstate: 61402009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> pc : do_misc_fixups+0x1784/0x1ab4 kernel/bpf/verifier.c:22838
> lr : do_misc_fixups+0x1784/0x1ab4 kernel/bpf/verifier.c:22838
> sp : ffff80008936b9a0
> x29: ffff80008936b9a0 x28: f5ff8000832f5000 x27: 000000000000000a
> x26: f8f0000007ba8000 x25: 0000000000000000 x24: f8f0000007bae200
> x23: 000000000000f0ff x22: 000000000000000a x21: f8f0000007bae128
> x20: f8f0000007ba8aa8 x19: ffff80008243e828 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: ffff800081b73b80
> x14: 0000000000000342 x13: 0000000000000000 x12: 0000000000000002
> x11: 00000000000000c0 x10: 646e0773d90f24cc x9 : 73727a981a23afd7
> x8 : fcf0000007bb36f8 x7 : 0000000000000190 x6 : 0000003978391654
> x5 : 0000000000000001 x4 : fbffff3fffffffff x3 : 000000000000ffff
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : fcf0000007bb2500
> Call trace:
>  do_misc_fixups+0x1784/0x1ab4 kernel/bpf/verifier.c:22838 (P)
>  bpf_check+0x1308/0x2a8c kernel/bpf/verifier.c:24739
>  bpf_prog_load+0x634/0xb74 kernel/bpf/syscall.c:2979
>  __sys_bpf+0x2e0/0x1a3c kernel/bpf/syscall.c:6029
>  __do_sys_bpf kernel/bpf/syscall.c:6139 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:6137 [inline]
>  __arm64_sys_bpf+0x24/0x34 kernel/bpf/syscall.c:6137
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
>  el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x34/0x10c arch/arm64/kernel/entry-common.c:879
>  el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:898
>  el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:596
> ---[ end trace 0000000000000000 ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

trying suggested fix by Alexei

jirka


#syz test

---
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0806295945e4..6aa303f76849 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11344,6 +11344,13 @@ static bool can_elide_value_nullness(enum bpf_map_type type)
 	}
 }
 
+static bool is_valid_proto(const struct bpf_func_proto *fn, int func_id)
+{
+	if (func_id == BPF_FUNC_tail_call)
+		return true;
+	return fn && fn->func;
+}
+
 static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 			    const struct bpf_func_proto **ptr)
 {
@@ -11354,7 +11361,7 @@ static int get_helper_proto(struct bpf_verifier_env *env, int func_id,
 		return -EINVAL;
 
 	*ptr = env->ops->get_func_proto(func_id, env->prog);
-	return *ptr ? 0 : -EINVAL;
+	return is_valid_proto(*ptr, func_id) ? 0 : -EINVAL;
 }
 
 static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,

