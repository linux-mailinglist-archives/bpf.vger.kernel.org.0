Return-Path: <bpf+bounces-35045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EBE937271
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 04:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22D221C212BB
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 02:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC29C2D6;
	Fri, 19 Jul 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="H4ZNR+Eh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A118C06
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721355210; cv=none; b=pTlx4Uq2Mk0cbEKCmb3hRFQMwJVlPx8DHf42SdOkN25dpNC+fvnOnS6dHFXhLaRtaXL+W75j+ur/VeOJnM75Wpc86vbV4pKnxrdyJ/DX12chCqYmyImVxWNIKvo5s9QxnTj+yPUhPfg5Cm41lyJdWhfTrypUKyiuHrMVOOpmmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721355210; c=relaxed/simple;
	bh=kRRp8LD5NDSju3eOBa9wP1KCbXySfixz28vLN27H/7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txNAc7bQ3YAXgAbAtJRf1lMlMkOyxL1OBkeI3FQPDFjh13qELRIFmVc0GAy0x3OxT7LgFBQ/8/bqAFK8RGahH7tbJElahjKhynofR8QbPl1adcRyOtL44EokS8Ss/EJLoQuBKNRweCN991Do+KGZLUKk+atoIUg2epXxXwYVJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=H4ZNR+Eh; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso1572835276.0
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2024 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721355206; x=1721960006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6xBCyZt4LBr3NtFQ/tQHQNxox1QnJWXPeKeevVBbMo=;
        b=H4ZNR+EhK/YQfniLDA6xNzaGoijxnVSvkTOCUwTz9DjbWuGXUpzA1CywazFlz/4JSy
         i9gQouuiqgbtLyjjpK054Cxp8E7jmeT08KthgMkM7Tfax2roODvw5bigaPtStJ5VcqJ/
         4DsyXyeM9OvjR+UaGK/S/XnKGErDdbb3qKiV7Ug4XkAWt93NO8xLGltO3TFXCIqYzMqY
         dHIBu94/vZgCanKC+6a50mLnsyV1IdN3EYgsI6E0VIZKS8Z/vYLF9Q9hV0Vb0Hb6gyLr
         jR6neljtrP0OOiLXGe3DgRbROMNPGwoeO4p3hpbQKL2OXY+PzPRFr9eLO3fBR6hsh2g6
         e3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721355206; x=1721960006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6xBCyZt4LBr3NtFQ/tQHQNxox1QnJWXPeKeevVBbMo=;
        b=BifwNFZpfQNfNTUcV1m3u7C0J+n0CDMEUgFWQp6cM17ic/yqZc+li+kYsz1qp5JhBK
         UZ2HMBHnoHbkaigaYMK+fLyRPtKveL6fqqaqjHX8QoNPQSd35FgembjWYnPvnOIuJg1h
         dlpmuU3wDSebMyWQllcciiM2O58G66YhDq3r6gXktdloHrcMWo7GbGnzUgV9QA7ASER2
         UM8e1mH6XloBOhq/AKkv0p6vD+Ude9ETaWwTviIWWDds+8CkOR6s2LpsRp/rlaTEySdc
         akXrYHLajNgBtJTKUyTTDrs2fmtgD9iEIcC+n5wugg1EWx0dXfHnbRxrIUL/NpzvnV+L
         ITwg==
X-Gm-Message-State: AOJu0Yzw/BeBY8/TXlvzc6B1lmPZmMkZWv0G55nrlUz4EFJUFDktxese
	eqTcTndl8LPsVOMkc1kWGPZnKs+6zkpngb1OyI5Gv72f4Kjx20gbD97tOdk83DYY1h33f3toSnI
	yZar6UQNZcNjM1gr38ViKGcjFHO4gAM7JMDWB
X-Google-Smtp-Source: AGHT+IHwwjQ8DinlK2wiNjovzG9BbNQIqAzdn4+/PROiJook0A2yi5g37Z7O91pcNOMATN+y4DlCwQYj+RCQbJxAIt0=
X-Received: by 2002:a05:6902:725:b0:e05:f07f:7d2e with SMTP id
 3f1490d57ef6-e0640c4a3acmr4231663276.6.1721355206291; Thu, 18 Jul 2024
 19:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711111908.3817636-1-xukuohai@huaweicloud.com> <CAHC9VhRohF+36PQbbEUiiiXjnmx-ZCphjOiAV5VTQwCejuejMA@mail.gmail.com>
In-Reply-To: <CAHC9VhRohF+36PQbbEUiiiXjnmx-ZCphjOiAV5VTQwCejuejMA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Jul 2024 22:13:15 -0400
Message-ID: <CAHC9VhQ-NAfLahQ-eomBrjBUT9t3s6OSzzE4nRLy=fj2AmJVqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] Add return value range check for BPF LSM
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, 
	selinux@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 5:44=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Jul 11, 2024 at 7:13=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.c=
om> wrote:
> > From: Xu Kuohai <xukuohai@huawei.com>
> >
> > LSM BPF prog returning a positive number attached to the hook
> > file_alloc_security makes kernel panic.
> >
> > Here is a panic log:
> >
> > [  441.235774] BUG: kernel NULL pointer dereference, address: 000000000=
00009
> > [  441.236748] #PF: supervisor write access in kernel mode
> > [  441.237429] #PF: error_code(0x0002) - not-present page
> > [  441.238119] PGD 800000000b02f067 P4D 800000000b02f067 PUD b031067 PM=
D 0
> > [  441.238990] Oops: 0002 [#1] PREEMPT SMP PTI
> > [  441.239546] CPU: 0 PID: 347 Comm: loader Not tainted 6.8.0-rc6-gafe0=
cbf23373 #22
> > [  441.240496] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.15.0-0-g2dd4b4
> > [  441.241933] RIP: 0010:alloc_file+0x4b/0x190
> > [  441.242485] Code: 8b 04 25 c0 3c 1f 00 48 8b b0 30 0c 00 00 e8 9c fe=
 ff ff 48 3d 00 f0 ff fb
> > [  441.244820] RSP: 0018:ffffc90000c67c40 EFLAGS: 00010203
> > [  441.245484] RAX: ffff888006a891a0 RBX: ffffffff8223bd00 RCX: 0000000=
035b08000
> > [  441.246391] RDX: ffff88800b95f7b0 RSI: 00000000001fc110 RDI: f089cd0=
b8088ffff
> > [  441.247294] RBP: ffffc90000c67c58 R08: 0000000000000001 R09: 0000000=
000000001
> > [  441.248209] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000=
000000001
> > [  441.249108] R13: ffffc90000c67c78 R14: ffffffff8223bd00 R15: fffffff=
ffffffff4
> > [  441.250007] FS:  00000000005f3300(0000) GS:ffff88803ec00000(0000) kn=
lGS:0000000000000000
> > [  441.251053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  441.251788] CR2: 00000000000001a9 CR3: 000000000bdc4003 CR4: 0000000=
000170ef0
> > [  441.252688] Call Trace:
> > [  441.253011]  <TASK>
> > [  441.253296]  ? __die+0x24/0x70
> > [  441.253702]  ? page_fault_oops+0x15b/0x480
> > [  441.254236]  ? fixup_exception+0x26/0x330
> > [  441.254750]  ? exc_page_fault+0x6d/0x1c0
> > [  441.255257]  ? asm_exc_page_fault+0x26/0x30
> > [  441.255792]  ? alloc_file+0x4b/0x190
> > [  441.256257]  alloc_file_pseudo+0x9f/0xf0
> > [  441.256760]  __anon_inode_getfile+0x87/0x190
> > [  441.257311]  ? lock_release+0x14e/0x3f0
> > [  441.257808]  bpf_link_prime+0xe8/0x1d0
> > [  441.258315]  bpf_tracing_prog_attach+0x311/0x570
> > [  441.258916]  ? __pfx_bpf_lsm_file_alloc_security+0x10/0x10
> > [  441.259605]  __sys_bpf+0x1bb7/0x2dc0
> > [  441.260070]  __x64_sys_bpf+0x20/0x30
> > [  441.260533]  do_syscall_64+0x72/0x140
> > [  441.261004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [  441.261643] RIP: 0033:0x4b0349
> > [  441.262045] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00=
 48 89 f8 48 89 f7 48 88
> > [  441.264355] RSP: 002b:00007fff74daee38 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000141
> > [  441.265293] RAX: ffffffffffffffda RBX: 00007fff74daef30 RCX: 0000000=
0004b0349
> > [  441.266187] RDX: 0000000000000040 RSI: 00007fff74daee50 RDI: 0000000=
00000001c
> > [  441.267114] RBP: 000000000000001b R08: 00000000005ef820 R09: 0000000=
000000000
> > [  441.268018] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000=
000000004
> > [  441.268907] R13: 0000000000000004 R14: 00000000005ef018 R15: 0000000=
0004004e8
> >
> > This is because the filesystem uses IS_ERR to check if the return value
> > is an error code. If it is not, the filesystem takes the return value
> > as a file pointer. Since the positive number returned by the BPF prog
> > is not a real file pointer, this misinterpretation causes a panic.
> >
> > Since other LSM modules always return either a negative error code
> > or a valid pointer, this specific issue only exists in BPF LSM. The
> > proposed solution is to reject LSM BPF progs returning unexpected
> > values in the verifier. This patch set adds return value check to
> > ensure only BPF progs returning expected values are accepted.
> >
> > Since each LSM hook has different excepted return values, we need to
> > know the expected return values for each individual hook to do the
> > check. Earlier versions of the patch set used LSM hook annotations
> > to specify the return value range for each hook. Based on Paul's
> > suggestion, current version gets rid of such annotations and instead
> > converts hook return values to a common pattern: return 0 on success
> > and negative error code on failure.
> >
> > Basically, LSM hooks are divided into two types: hooks that return a
> > negative error code and zero or other values, and hooks that do not
> > return a negative error code. This patch set converts all hooks of the
> > first type and part of the second type to return 0 on success and a
> > negative error code on failure (see patches 1-10). For certain hooks,
> > like ismaclabel and inode_xattr_skipcap, the hook name already imply
> > that returning 0 or 1 is the best choice, so they are not converted.
> > There are four unconverted hooks. Except for ismaclabel, which is not
> > used by BPF LSM, the other three are specified with a BTF ID list to
> > only return 0 or 1.
>
> Thank you for following up on your initial work with this patchset, Xu
> Kuohai.  It doesn't look like I'm going to be able to finish my review
> by the end of the day today, so expect that a bit later, but so far I
> think most of the changes look good and provide a nice improvement :)

You should have my feedback now, let me know if you have any questions.

One additional comment I might make is that you may either want to
wait until after v6.11-rc1 is released and I've had a chance to rebase
the lsm/{dev,next} branches and merge the patchsets which are
currently queued; there are a few patches queued up which will have an
impact on this work.  While it's an unstable branch, you can take a
peek at those queues patches in the lsm/dev-staging branch.

https://github.com/LinuxSecurityModule/kernel/blob/main/README.md

--=20
paul-moore.com

