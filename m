Return-Path: <bpf+bounces-77653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E11ACECAAF
	for <lists+bpf@lfdr.de>; Thu, 01 Jan 2026 00:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CE6E3019195
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 23:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491C930ACE6;
	Wed, 31 Dec 2025 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhfkJDVO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417AB2C027B
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767223261; cv=none; b=E0FuoX/KxJGWX1yJOhg3rle4YOMFGIH40F5SiT+0wQ5uHg1wV+EV4genNh5QJ9waGeSnZerX5GEgTZiAVLVMeIHClMq3fiAKZ3xfpO41F5Ogo9UcJAWwnyqVC1cZS01rXYJd7Z6nhqncNm5PMN+7ijpCBogvnU1r6WfhkdrXewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767223261; c=relaxed/simple;
	bh=QbQeTPKkvqwDTi9jphXlB0QOUtZZZiT4Q18MidmASV8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GIuURj+HW60k77/7oBZ23Rv+z8BvA8cdrBwXQjlzWlocVxeeqiYoutvU4gCYyxmqxk41Ptn3iPepnRZ7bVxxAcbDZJu+S9LC8TT7z2M5jneI2SM2MsXF7il44HZFkWVJhlq8xSv4FZ83VScULZUeOoNMQbSLL8NahycpyY50ndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhfkJDVO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maze.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c3373f2bd74so3049570a12.3
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 15:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767223260; x=1767828060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Fkw4pJwbf+RiOcgktvh2leaGPbqkfTxYnH0P1Ik49Q=;
        b=FhfkJDVOGW5SC5mYvQfUZRTckHq32r336Gq8jBxoh8hRdxfyNDhLNigiu1Ssm02SuY
         pAROAV6L35jOpeQX9OdtdzU59dIBeYiHibvm/wgkwiwlYsDA/aPULhV2nwhJx4C00Moh
         CxKNxujnmbdXavkQrm3pXGvJ8yzk32hjBH2gQgVGwjh3VQb7UapXhv3qxIFQiva6e/Ex
         bJQ1rS9aJoxZjzSWO5a67BW8nOVV53nRVZBqL1OQgSwG91E2sKtasHfJ2Ys8x1gNqLMx
         7RvlFXeX4hcYEuOYxUlmjuqdGQxIz5FRx55KxAax3YoIHYVcmD4qLO02lzDlCuIIuNr+
         /ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767223260; x=1767828060;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fkw4pJwbf+RiOcgktvh2leaGPbqkfTxYnH0P1Ik49Q=;
        b=gq4bCTgpTfQRYYxnL/xHCUvpBD/UfSAKrJ5tF3iP1Om6GhAsNw0ViQAA2ppaVGNX9r
         GE3QnRQ+FlAr57QmllxD0e5EuY/s81vvZRGTKXPY4iJt2tC/eE2uuWMCNUdLeyyxsgka
         BMspbtQTHwMjeqY/Z+bGctoD2gLevUgdljRqP4dFPHX9FVPstPDy6RBEMfo7V2kN+Odj
         MYa/11SWhiTFIvQyaapDg7GNH2rCWAUWdWZF0AeczbGKBesTvlrfK71FS4MRWfRaxxTh
         Sbse4a+qS/a/OzCHWNqOlpvYNO5ZPjJN3M/2J9vrsZ1vmK4heqXyifWb1GrUFs9XEYA0
         6TBg==
X-Forwarded-Encrypted: i=1; AJvYcCVDmP+U/tx+55+C3A89/fTvLPu+qBXEy7wAjpi15IFNd24j8/5A0s952sxhYBkSaY2rXnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2huGIdD2xY3zNuSU5sd3Rm796q/vBikkEudK7N6LcdDrumx3y
	BnbUT0HkVMfIxwYLDiTyXIxcijpJ6e2lbpdSMdDQ1M+b4o4WjDWSgNyRhWswbJuo8HJpPZZF0A=
	=
X-Google-Smtp-Source: AGHT+IGQ1Yo74Lfs+XDagvF/do2RICQ0VFYGB7N4aHuu3r4sO5GbnwTUXgQ19dSEciYhPBpJEkJa6lWY
X-Received: from dlbsi4.prod.google.com ([2002:a05:7022:b884:b0:119:9f33:34a6])
 (user=maze job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f401:b0:119:fb9c:4ebb
 with SMTP id a92af1059eb24-121722ebbafmr31057680c88.30.1767223259510; Wed, 31
 Dec 2025 15:20:59 -0800 (PST)
Date: Wed, 31 Dec 2025 15:20:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.394.g0814c687bb-goog
Message-ID: <20251231232048.2860014-1-maze@google.com>
Subject: [PATCH bpf] bpf: 'fix' for undefined future potential exploits of BPF_PROG_LOAD
From: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>
To: "=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <zenczykowski@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, BPF Mailing List <bpf@vger.kernel.org>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Over the years there's been a number of issues with the eBPF
verifier/jit/codegen (incl. both code bugs & spectre related stuff).

It's an amazing but very complex piece of logic, and I don't think
it's realistic to expect it to ever be (or become) 100% secure.

For example we currently have KASAN reporting buffer length violation
issues on 6.18 (which may or may not be due to eBPF subsystem, but are
worrying none-the-less)

Blocking bpf(BPF_PROG_LOAD, ...) is the only sure fire way to guarantee
the inability to exploit the eBPF subsystem.
In comparison other eBPF operations are pretty benign.
Even map creation is usually at most a memory DoS, furthermore it
remains useful (even with prog load disabled) due to inner maps.

This new sysctl is designed primarily for verified boot systems,
where (while the system is booting from trusted/signed media)
BPF_PROG_LOAD can be enabled, but before untrusted user
media is mounted or networking is enabled, BPF_PROG_LOAD
can be outright disabled.

This provides for a very simple way to limit eBPF programs to only
those signed programs that are part of the verified boot chain,
which has always been a requirement of eBPF use in Android.

I can think of two other ways to accomplish this:
(a) via sepolicy with booleans, but it ends up being pretty complex
    (especially wrt verifying the correctness of the resulting policies)
(b) via BPF_LSM bpf_prog_load hook, which requires enabling additional
    kernel options which aren't necessarily worth the bother,
    and requires dynamically patching the kernel (frowned upon by
    security folks).

This approach appears to simply be the most trivial.

I've chosed to return EUNATCH 'Protocol driver not attached.'
to separate it from EPERM and make it clear the eBPF program loading
subsystem has been outright disabled (detached).  There aren't
any permissions you could gain to make things work again (short
of a reboot/kexec).

It is intentionally kernel global and doesn't affect cBPF,
which has various runtime use cases (incl. tcpdump style dynamic
socket filters and seccomp sandboxing) and thus cannot be disabled,
but (as experience shows) is also much less dangerous (mainly due
to being much simpler).

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  9 +++++++++
 kernel/bpf/syscall.c                        | 14 ++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index f3ee807b5d8b..4906ef08c741 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1655,6 +1655,15 @@ entry will default to 2 instead of 0.
 =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
+disable_bpf_prog_load
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Writing 1 to this entry will cause all future invocations of
+``bpf(BPF_PROG_LOAD, ...)`` to fail with -EUNATCH, thus effectively
+permanently disabling the instantiation of new eBPF programs.
+Once set to 1, this cannot be reset back to 0.
+
+
 warn_limit
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6589acc89ef8..ef655ff501e7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -67,6 +67,8 @@ static DEFINE_SPINLOCK(link_idr_lock);
 int sysctl_unprivileged_bpf_disabled __read_mostly =3D
 	IS_BUILTIN(CONFIG_BPF_UNPRIV_DEFAULT_OFF) ? 2 : 0;
=20
+int sysctl_disable_bpf_prog_load =3D 0;
+
 static const struct bpf_map_ops * const bpf_map_types[] =3D {
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
 #define BPF_MAP_TYPE(_id, _ops) \
@@ -2891,6 +2893,9 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr=
_t uattr, u32 uattr_size)
 				 BPF_F_TOKEN_FD))
 		return -EINVAL;
=20
+	if (sysctl_disable_bpf_prog_load)
+		return -EUNATCH;
+
 	bpf_prog_load_fixup_attach_type(attr);
=20
 	if (attr->prog_flags & BPF_F_TOKEN_FD) {
@@ -6511,6 +6516,15 @@ static const struct ctl_table bpf_syscall_table[] =
=3D {
 		.extra1		=3D SYSCTL_ZERO,
 		.extra2		=3D SYSCTL_TWO,
 	},
+	{
+		.procname	=3D "disable_bpf_prog_load",
+		.data		=3D &sysctl_disable_bpf_prog_load,
+		.maxlen		=3D sizeof(sysctl_disable_bpf_prog_load),
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dointvec_minmax,
+		.extra1		=3D SYSCTL_ONE,
+		.extra2		=3D SYSCTL_ONE,
+	},
 	{
 		.procname	=3D "bpf_stats_enabled",
 		.data		=3D &bpf_stats_enabled_key.key,
--=20
2.52.0.394.g0814c687bb-goog


