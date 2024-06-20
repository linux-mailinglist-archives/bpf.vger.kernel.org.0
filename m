Return-Path: <bpf+bounces-32590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95098910338
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 13:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399791F239AA
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F01ABCB6;
	Thu, 20 Jun 2024 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA7u331L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDBB1AB526
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 11:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883669; cv=none; b=eIHUPkny1ZyzmoqusVyUcQwtvg6Zd7jh0Me+5vssQBM1xWCqB18NtPQL2SPBlSNARhT8XJGnfwThAugqzUbxco8MYjoCNKGkSzX8ERZ1d/Uho+AiYJiLleq3RC0r+YzaZ1MkAN8jOGSIo8SfabpOXRXFkGqNxHKW3fwB3ppd8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883669; c=relaxed/simple;
	bh=08jiWU/pYLwxgW10DWIpPvAggnMcew7mtMOdhwtIaB8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GlnZ9JR9NCUzb9QZrx44xlzp/w8A2saaFfL2sWDEKJMrgY8F6pwrBdCICrVyVAncRs9ZUC+Azqx6HfnqVdwPe7IsDiuj99+NUsx0kTXvHYMXxo4Zuht8qpqSbmhBUE6WPzL5yEyJBp5WX3vopY/FLhJpvWVSiJDzFEl+n7Vazms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA7u331L; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c7b14bb4a5so607150a91.0
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718883668; x=1719488468; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G1G/SeKmJmMUAkZyjlBU0bhquMoYb2ntx58fQmFOjIQ=;
        b=MA7u331L4Lb5kbCO1u0VSP3RFu782SjDQ+jat793Xv9N6s4SJaeGGVejBpOYKidMhn
         Tggmv+oo5VeV0HTUUY54GPcin1ukYeBcXRjtZ1aHSDJU/0CdyGckR2Is+X6Ya3hfmQcY
         XkY5bOy72SheZIQE8HxdIrDMLH8MfuruODReJwLx2PS/JJ22rIhINL3J8r9X1JqvtBZf
         JHwNq91v6yIx/qsW0c3qi7/cnUpQOYC69sIudRIKYxjUXWKTS1DNGTLYCw03+fq1kE+w
         qk7aH5V5YwawowJ1WIhkZoCjg/pumvMkEbtFWCrzvtUo+/3tYjc7OizNOaQIdGxnhYdq
         l9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718883668; x=1719488468;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G1G/SeKmJmMUAkZyjlBU0bhquMoYb2ntx58fQmFOjIQ=;
        b=eOMNqFh1koPEAqsbkRa89TmclRceZNagFotTiC/RIH0FqONoS45Yju6ytvXxNPumfb
         6hhHdY/JgeAO1Cl4HZL509aObWEPYC1WtBchYwW9hRJhOp51XaoMRrafT+p+a9Om9n/H
         gUfLEns29BP9+assNxsJ2O+grysWXsSFGlwjA7+Pr+fprMbTJ9zNPrPCG8Ecvud8xcAk
         sNVikd4NCS+6n/85AHcYieWfvBXjzhrYykYNWU1ctL6tlVbndXtiT4jY8sfx9+E2sUCU
         HLoncO4KPatLuRFz+Vfm1x4Orz5+0gIawAg8mMZPAkrHjG+AO3KDwbHw/mLo+3l14zi7
         wYOA==
X-Forwarded-Encrypted: i=1; AJvYcCV1j65jUenAV4/7f1HRTU9Fk8dPxZdZm8V9PH9jSl5TLfXjD6jdR/f1w4vyd1KlDkMdTh2Fp/Yi7Lc9nIelh41UbibO
X-Gm-Message-State: AOJu0YwNZyR1uC/5FTegNNfwYMzHvv+GsGgIaXcHDAqW+5q6ylr0zPDi
	0+whak9tlHpNYfxxHvJd+U2iowow+DYUfe+SjXC/tMThTLvG4i8f
X-Google-Smtp-Source: AGHT+IHuJJzL0naeX1NwNRfNqEXSWWl7HXoXS32kjmLq4mprC2XmdWOA8eK/ycYmTFHhKGS6lWT4GA==
X-Received: by 2002:a17:90a:f40f:b0:2c7:70ba:3f02 with SMTP id 98e67ed59e1d1-2c7b3ad6388mr7714183a91.6.1718883667671;
        Thu, 20 Jun 2024 04:41:07 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c7e4f03c4esm1497386a91.6.2024.06.20.04.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:41:06 -0700 (PDT)
Message-ID: <b9d80fb01651771108df802afd49748c8976da70.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/6] selftests/bpf: add kfunc_call test for
 simple dtor in bpf_testmod
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org
Cc: acme@redhat.com, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
  martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com,  mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, mykolal@fb.com,  thinker.li@gmail.com,
 bentiss@kernel.org, tanggeliang@kylinos.cn,  bpf@vger.kernel.org
Date: Thu, 20 Jun 2024 04:41:01 -0700
In-Reply-To: <20240620091733.1967885-7-alan.maguire@oracle.com>
References: <20240620091733.1967885-1-alan.maguire@oracle.com>
	 <20240620091733.1967885-7-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-20 at 10:17 +0100, Alan Maguire wrote:

[...]

Hi Alan,

I still get the error message in the dmesg:

[   10.489223] BUG: sleeping function called from invalid context at includ=
e/linux/sched/mm.h:337
[   10.489454] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 184, =
name: test_progs
[   10.489589] preempt_count: 200, expected: 0
[   10.489659] RCU nest depth: 1, expected: 0
[   10.489733] 1 lock held by test_progs/184:
[   10.489811]  #0: ffffffff83198a60 (rcu_read_lock){....}-{1:2}, at: bpf_t=
est_timer_enter+0x1d/0xb0
[   10.490040] Preemption disabled at:
[   10.490060] [<ffffffff81a0ee6a>] bpf_test_run+0x16a/0x300
[   10.490197] CPU: 1 PID: 184 Comm: test_progs Tainted: G           OE    =
  6.10.0-rc2-00766-gb812ab0e1306-dirty #39
[   10.490356] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
5.0-1 04/01/2014
[   10.490475] Call Trace:
[   10.490515]  <TASK>
[   10.490557]  dump_stack_lvl+0x83/0xa0
[   10.490618]  __might_resched+0x199/0x2b0
[   10.490695]  kmalloc_trace_noprof+0x273/0x320
[   10.490756]  ? srso_alias_return_thunk+0x5/0xfbef5
[   10.490836]  ? bpf_test_run+0xc0/0x300
[   10.490836]  ? bpf_testmod_ctx_create+0x23/0x50 [bpf_testmod]
[   10.490836]  bpf_testmod_ctx_create+0x23/0x50 [bpf_testmod]
[   10.490836]  bpf_prog_d1347efc07047347_kfunc_call_ctx+0x2c/0xae
[   10.490836]  bpf_test_run+0x198/0x300
[   10.490836]  ? srso_alias_return_thunk+0x5/0xfbef5
[   10.490836]  ? lockdep_init_map_type+0x4b/0x250
[   10.490836]  bpf_prog_test_run_skb+0x381/0x7f0
[   10.490836]  __sys_bpf+0xc4f/0x2e00
[   10.490836]  ? srso_alias_return_thunk+0x5/0xfbef5
[   10.490836]  ? reacquire_held_locks+0xcf/0x1f0
[   10.490836]  __x64_sys_bpf+0x1e/0x30
[   10.490836]  do_syscall_64+0x68/0x140
[   10.490836]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

The following fix helps:

--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -164,7 +164,7 @@ bpf_testmod_ctx_create(int *err)
 {
        struct bpf_testmod_ctx *ctx;
=20
-       ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL | GFP_ATOMIC);
+       ctx =3D kzalloc(sizeof(*ctx), GFP_ATOMIC);
        if (!ctx) {
                *err =3D -ENOMEM;
                return NULL;

Thanks,
Eduard

[...]

