Return-Path: <bpf+bounces-36471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB7E949159
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 15:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3254BB25FB3
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF331D278E;
	Tue,  6 Aug 2024 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAx3GpVq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783A1D1F6E;
	Tue,  6 Aug 2024 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950652; cv=none; b=dxpqaD2eUsXN83u5fbKoDyyWY2U3KkhlDgYCcaOayecC8sSW8shWmTPppq9NiVMMv2xKhOT2C8HRB/aiyLQIeCsyWN3pcda4p9ZzAsRWPeE4F1x7ZaP5HCHfJLSieqA5GocvZPNHPTpjPaUdDj3XixD5s1Fzpui6EzlFfGQq/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950652; c=relaxed/simple;
	bh=flY31rR6pmZoH4oEeY0NtqzgVGaYVAz6Fi0dOwG65fU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sm0BEgHzdECfi/MHWKt5bUIr3MFwvbezheFWTBXdFafxVSMsBFsolYv40kNBtugaz18D21GQB0YHsR/pVTU9c5WPekcHeckLrSyVW7bVVsHj4BugI8JoaZ9Pjmv8PqMiyHAgKL2D7QtpEqorQNOEuYW4YmhNaRfae0ufxGAZFH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAx3GpVq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a975fb47eso84467366b.3;
        Tue, 06 Aug 2024 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950649; x=1723555449; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UIfR/qoWHRktUdU3sb33iLjGERsBhmCcHVpktbloA4M=;
        b=BAx3GpVqwvLtY9gGHJIwBdleWglJU+HOojqWjKdRODYAjIBijjO1i5ofuj7y10Pbc0
         ieY2ZH/uTQ0eDl/RuYDfSgpLFidt7ODOLcaXzQuB/IhEp1P8kVYEt/UfjVZgV6UgLX7G
         2KjqqPc2s4v0t27NqUHwIo6qo5eJ1v5AiTDxe0EyQ2ieHXVvShob/1D9gOMSGa3gg3FE
         brB9wjZeWoLs0HCEvWeaLoUDmHSpJi+tHEzak3NB98WM+nbgLBxcoo9IoBjAYqggW3Qd
         mlC0nNubNyRM9JpUOUt/1vReXEWjDfbWNntylvzTcYhefom4uiLRLRmtDaUO//82vdlf
         eRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950649; x=1723555449;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIfR/qoWHRktUdU3sb33iLjGERsBhmCcHVpktbloA4M=;
        b=De+gWXb/eMNjQr0h2rXZ2a1dQYWTtSJhE/vI8ttSytBzKCD7x1fWgsHszUtW7NlT47
         Oz5urYfgiMJA9wxlh84pBlr9mYo0gPpW4t97k/t+OKMDk7gj9Zp4U0UDp0IA/EPFXfrT
         VlYUDb0zeiLY05SXJt/fWdv5V5ZGzoNqiPN6CpbTzHRXVnUOuCVrujyak3LcI1n85F/4
         Z78VEAd5jk66bRWEzMFSG/Fs2astHbg2uQ3b91ukiJ0Gp1TrT7hrPRX+awcdCHHSDhN+
         dUtovsUqf8swstOb8ZRqi5O/4xJwP8Vq2l4/fCi++e1/lREchNasIMn6SOu/K1Uve7rA
         nDJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXSt9czfs1ZVyuxllfKefgNXIPCUAwG/SvK6N2XcVK8xIThH/3l3bxI49rRwxklFBSBBUkBwNZpauYi2xd6ZJKoZ0FaNv+aqzxDDHDB058C2ynvbG2v6EGwgj/7tCXBrKK
X-Gm-Message-State: AOJu0YzNtV4QjsrQERsaHNSbo8RZZwY8NMrep8leNxlZlm+Uql/vjHPe
	zks18A1SnWo8C6C2HcIB8/XkK/xXkW1q//rokS9YVGvYHUFhxoCkXmY0YA==
X-Google-Smtp-Source: AGHT+IFWOnCIA2gd194+ITHxSNhVnn2tvZxKDVseMUk62HGons/HEc9a24a76DMnSoeM0IX6QmbX9w==
X-Received: by 2002:a17:907:7254:b0:a77:b784:deba with SMTP id a640c23a62f3a-a7dc4d8f5a7mr1122599966b.6.1722950648829;
        Tue, 06 Aug 2024 06:24:08 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0f8d2sm549363066b.46.2024.08.06.06.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:24:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 6 Aug 2024 15:24:06 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Artem Savkov <asavkov@redhat.com>
Subject: Re: NULL pointer deref when running BPF monitor program (6.11.0-rc1)
Message-ID: <ZrIj9jkXqpKXRuS7@krava>
References: <ZrCZS6nisraEqehw@jlelli-thinkpadt14gen4.remote.csb>
 <ZrECsnSJWDS7jFUu@krava>
 <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com>

On Mon, Aug 05, 2024 at 10:00:40AM -0700, Alexei Starovoitov wrote:
> On Mon, Aug 5, 2024 at 9:50 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Aug 05, 2024 at 11:20:11AM +0200, Juri Lelli wrote:
> >
> > SNIP
> >
> > > [  154.566882] BUG: kernel NULL pointer dereference, address: 000000000000040c
> > > [  154.573844] #PF: supervisor read access in kernel mode
> > > [  154.578982] #PF: error_code(0x0000) - not-present page
> > > [  154.584122] PGD 146fff067 P4D 146fff067 PUD 10fc00067 PMD 0
> > > [  154.589780] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > [  154.594659] CPU: 28 UID: 0 PID: 2234 Comm: thread0-13 Kdump: loaded Not tainted 6.11.0-rc1 #8
> > > [  154.603179] Hardware name: Dell Inc. PowerEdge R740/04FC42, BIOS 2.10.2 02/24/2021
> > > [  154.610744] RIP: 0010:bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x22/0xd7
> > > [  154.618310] Code: cc cc cc cc cc cc cc cc 0f 1f 44 00 00 66 90 55 48 89 e5 48 81 ec 30 00 00 00 53 41 55 41 56 48 89 fb 4c 8b 6b 00 4c 8b 73 08 <41> 8b be 0c 04 00 00 48 83 ff 06 0f 85 9b 00 00 00 41 8b be c0 09
> > > [  154.637052] RSP: 0018:ffffabac60aebbc0 EFLAGS: 00010086
> > > [  154.642278] RAX: ffffffffc03fba5c RBX: ffffabac60aebc28 RCX: 000000000000001f
> > > [  154.649411] RDX: ffff95a90b4e4180 RSI: ffffabac4e639048 RDI: ffffabac60aebc28
> > > [  154.656544] RBP: ffffabac60aebc08 R08: 00000023fce7674a R09: ffff95a91d85af38
> > > [  154.663674] R10: ffff95a91d85a0c0 R11: 000000003357e518 R12: 0000000000000000
> > > [  154.670807] R13: ffff95a90b4e4180 R14: 0000000000000000 R15: 0000000000000001
> > > [  154.677939] FS:  00007ffa6d600640(0000) GS:ffff95c01bf00000(0000) knlGS:0000000000000000
> > > [  154.686026] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  154.691769] CR2: 000000000000040c CR3: 000000014b9f2005 CR4: 00000000007706f0
> > > [  154.698903] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > [  154.706035] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > [  154.713168] PKRU: 55555554
> > > [  154.715879] Call Trace:
> > > [  154.718332]  <TASK>
> > > [  154.720439]  ? __die+0x20/0x70
> > > [  154.723498]  ? page_fault_oops+0x75/0x170
> > > [  154.727508]  ? sysvec_irq_work+0xb/0x90
> > > [  154.731348]  ? exc_page_fault+0x64/0x140
> > > [  154.735275]  ? asm_exc_page_fault+0x22/0x30
> > > [  154.739461]  ? 0xffffffffc03fba5c
> > > [  154.742780]  ? bpf_prog_ec8173ca2868eb50_handle__sched_pi_setprio+0x22/0xd7
> >
> > hi,
> > reproduced.. AFAICS looks like the bpf program somehow lost the booster != NULL
> > check and just load the policy field without it and crash when booster is rubbish
> >
> > int handle__sched_pi_setprio(u64 * ctx):
> > ; int handle__sched_pi_setprio(u64 *ctx)
> >    0: (bf) r6 = r1
> > ; struct task_struct *boosted = (void *) ctx[0];
> >    1: (79) r7 = *(u64 *)(r6 +0)
> > ; struct task_struct *booster = (void *) ctx[1];
> >    2: (79) r8 = *(u64 *)(r6 +8)
> > ; if (booster->policy != SCHED_DEADLINE)
> >
> > curious why the check disappeared, because object file has it, so I guess verifier
> > took it out for some reason, will check
> 
> Juri,
> 
> Thanks for flagging!
> 
> Jiri,
> 
> the verifier removes the check because it assumes that pointers
> passed by the kernel into tracepoint are valid and trusted.
> In this case:
>         trace_sched_pi_setprio(p, pi_task);
> 
> pi_task can be NULL.
> 
> We cannot make all tracepoint pointers to be PTR_TRUSTED | PTR_MAYBE_NULL
> by default, since it will break a bunch of progs.
> Instead we can annotate this tracepoint arg as __nullable and
> teach the verifier to recognize such special arguments of tracepoints.

ok, so you mean to be able to mark it in event header like:

  TRACE_EVENT(sched_pi_setprio,
        TP_PROTO(struct task_struct *tsk, struct task_struct *pi_task __nullable),

I guess we could make pahole to emit DECL_TAG for that argument,
but I'm not sure how to propagate that __nullable info to pahole

while wondering about that, I tried the direct fix below ;-)

jirka


---
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 95426d5b634e..1a20bbdead64 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6377,6 +6377,25 @@ int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 	return off;
 }
 
+static bool is_tracing_prog_raw_tp(const struct bpf_prog *prog, const char *name)
+{
+	struct btf *btf = prog->aux->attach_btf;
+	const struct btf_type *t;
+	const char *tname;
+
+	if (prog->expected_attach_type != BPF_TRACE_RAW_TP)
+		return false;
+
+	t = btf_type_by_id(btf, prog->aux->attach_btf_id);
+	if (!t)
+		return false;
+
+	tname = btf_name_by_offset(btf, t->name_off);
+	if (!tname)
+		return false;
+	return !strcmp(tname, name);
+}
+
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info)
@@ -6544,6 +6563,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		}
 	}
 
+	/* Second argument of sched_pi_setprio tracepoint can be null */
+	if (is_tracing_prog_raw_tp(prog, "btf_trace_sched_pi_setprio") && arg == 1)
+		info->reg_type |= PTR_MAYBE_NULL;
+
 	info->btf = btf;
 	info->btf_id = t->type;
 	t = btf_type_by_id(btf, t->type);

