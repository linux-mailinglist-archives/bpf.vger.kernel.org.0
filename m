Return-Path: <bpf+bounces-76993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5959CCC55C
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 15:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77B0A3033C83
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9433121E;
	Thu, 18 Dec 2025 14:53:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11125191;
	Thu, 18 Dec 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069587; cv=none; b=c+ct6bp8g7repHGCYCsYoQAOh9214AEcnxWV9x9iXJxwahykSO70x1Jsb7iSQOLVymV294ifjZjHZTP207YafrJfgLIIZO0xW9TmSnGCXWb6Ed2Noo+hmDGXURrlf6iWshxWtrR7/TG4C+JHTTC9eNIuBdcHjMTU3muNVgy28Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069587; c=relaxed/simple;
	bh=1tJPAzNE4seYqAInwkAAu2eJZnnIyziByoZ/2qLanGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZemTH0I0Z1q+Xu8q73MMsTIOyr2RuSwayqDqUZ7X+vRvGjVgHE1JaXRH3dPQqORHiWa0TAbK/xe+VSqlwdlWQJf8TeFq2pvWjud1Tp+ilSchzQbop3qeTSSmeLjocuNHVu9Hp6EskYkU4Wfn96E3JmDA4zuCQRRUgaVYE44zTis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dXD4M2j9Mz1sFNS;
	Thu, 18 Dec 2025 15:45:55 +0100 (CET)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4dXD4J3x1wz1sFNH;
	Thu, 18 Dec 2025 15:45:52 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4dXD4J16fdz1qqlb;
	Thu, 18 Dec 2025 15:45:52 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id l_Kr4_Abdg19; Thu, 18 Dec 2025 15:45:43 +0100 (CET)
X-Auth-Info: f7NtxmpzHQmYe1l150J0FpcJ3IOvKgngAnPl/ySUigHkHQOe66PIM7oOIodZILzN
Received: from igel.home (aftr-82-135-83-180.dynamic.mnet-online.de [82.135.83.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Thu, 18 Dec 2025 15:45:43 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id BFC012C1943; Thu, 18 Dec 2025 15:45:42 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org,  rostedt@goodmis.org,  daniel@iogearbox.net,
  john.fastabend@gmail.com,  andrii@kernel.org,  martin.lau@linux.dev,
  eddyz87@gmail.com,  song@kernel.org,  yonghong.song@linux.dev,
  kpsingh@kernel.org,  sdf@fomichev.me,  haoluo@google.com,
  jolsa@kernel.org,  mhiramat@kernel.org,  mark.rutland@arm.com,
  mathieu.desnoyers@efficios.com,  jiang.biao@linux.dev,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH bpf-next v3 3/6] bpf: fix the usage of
 BPF_TRAMP_F_SKIP_FRAME
In-Reply-To: <20251118123639.688444-4-dongml2@chinatelecom.cn> (Menglong
	Dong's message of "Tue, 18 Nov 2025 20:36:31 +0800")
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
	<20251118123639.688444-4-dongml2@chinatelecom.cn>
Date: Thu, 18 Dec 2025 15:45:42 +0100
Message-ID: <874ipnkfvt.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Nov 18 2025, Menglong Dong wrote:

> Some places calculate the origin_call by checking if
> BPF_TRAMP_F_SKIP_FRAME is set. However, it should use
> BPF_TRAMP_F_ORIG_STACK for this propose. Just fix them.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Acked-by: Alexei Starovoitov <ast@kernel.org>

This breaks RISC-V:

[    8.584381][    T1] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    8.588359][    T1] Insufficient stack space to handle exception!
[    8.588823][    T1] Task stack:     [0xff20000000010000..0xff20000000014000]
[    8.589219][    T1] Overflow stack: [0xff600000ffdad070..0xff600000ffdae070]
[    8.590133][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(voluntary)  c900881ed1c1988ec5cf3e914d0edeb1b4d83ca3
[    8.590898][    T1] Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
[    8.591494][    T1] epc : copy_from_kernel_nofault+0xa/0x198
[    8.592292][    T1]  ra : bpf_probe_read_kernel+0x20/0x60
[    8.592658][    T1] epc : ffffffff802b732a ra : ffffffff801e6070 sp : ff2000000000ffe0
[    8.593121][    T1]  gp : ffffffff82262ed0 tp : 0000000000000000 t0 : ffffffff80022320
[    8.593566][    T1]  t1 : ffffffff801e6056 t2 : 0000000000000000 s0 : ff20000000010040
[    8.593997][    T1]  s1 : 0000000000000008 a0 : ff20000000010050 a1 : ff60000083b3d320
[    8.594446][    T1]  a2 : 0000000000000008 a3 : 0000000000000097 a4 : 0000000000000000
[    8.594940][    T1]  a5 : 0000000000000000 a6 : 0000000000000021 a7 : 0000000000000003
[    8.595396][    T1]  s2 : ff20000000010050 s3 : ff6000008459fc18 s4 : ff60000083b3d340
[    8.595831][    T1]  s5 : ff20000000010060 s6 : 0000000000000000 s7 : ff20000000013aa8
[    8.596215][    T1]  s8 : 0000000000000000 s9 : 0000000000008000 s10: 000000000058dcb0
[    8.596641][    T1]  s11: 000000000058dca7 t3 : 000000006925116d t4 : ff6000008090f026
[    8.597065][    T1]  t5 : 00007fff9b0cbaa8 t6 : 0000000000000016
[    8.597363][    T1] status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000005
[    8.598033][    T1] Kernel panic - not syncing: Kernel stack overflow
[    8.598597][    T1] CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(voluntary)  c900881ed1c1988ec5cf3e914d0edeb1b4d83ca3
[    8.599244][    T1] Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
[    8.599659][    T1] Call Trace:
[    8.600117][    T1] [<ffffffff8001a1f8>] dump_backtrace+0x28/0x38
[    8.600517][    T1] [<ffffffff80002502>] show_stack+0x3a/0x50
[    8.600844][    T1] [<ffffffff800122be>] dump_stack_lvl+0x56/0x80
[    8.601176][    T1] [<ffffffff80012300>] dump_stack+0x18/0x22
[    8.601518][    T1] [<ffffffff80002abe>] vpanic+0xf6/0x328
[    8.601819][    T1] [<ffffffff80002d2e>] panic+0x3e/0x40
[    8.602088][    T1] [<ffffffff80019ef0>] handle_bad_stack+0x98/0xa0
[    8.602395][    T1] [<ffffffff801e6070>] bpf_probe_read_kernel+0x20/0x60

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

