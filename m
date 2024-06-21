Return-Path: <bpf+bounces-32775-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CF9912FEE
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 00:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512971C2295D
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 22:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91A9155A30;
	Fri, 21 Jun 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpl+hE1O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2058138FB9
	for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007222; cv=none; b=NYesVrVc9vgnO9UsgQ5THf5A0GwDmY/LFGFuBzSACRtum4klsuNxWydNGhYB+KCFzZHoVwC/69x3bY2sCoNAXQeFWwKczVxMaQ9fFk2slRQ8K1Snm5lyMI569G7ZS7V0MMPDAJNLig842VkcUykA96ucbQ7k5IxMz1LqozXsawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007222; c=relaxed/simple;
	bh=nuVY9RkTGef870+z5rG5nUa6tpSfULTo36XrRB35ffo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OjcOjXupWQWNTPdskdSdIwB9zuIbSoSPgfyW9bF403G3vXGGPWvV9WdTqhr87uDv24yJjeVtFq9H79oJERUpsiVVxwQ97e3Ftr/dEDKNzbXvX8lUsFQgpgR00M4yZ/wDrf1Pk1Dp6H7k3Quyq87cweYqF7ieIoGOOqgdgXzbC6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpl+hE1O; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-707040e3018so1747270a12.1
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719007220; x=1719612020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYRmrZk/aEL6RfaLpWp/mJW1FmKM8PDTW9pFtzpph7w=;
        b=gpl+hE1ORJ6piL9ARcILtu3yodAsnPh2oe6bO73sQIaDSDm/r5xrQIlzqAXdHUfjTK
         TQMqa1LK88dXwAZYZ4oylocUuB2rqeKUAQvUXC06tCpyJw8crwWpZJLtvpHvlpZL4GIn
         TbFnOwb+oApPgTo7hGKs6mrbdUFBdt/XacRSmEjFgT7Ms3Iqw7sVb0s65YugK5dVAHEK
         4/xqCD5xdz4FHpx1Q1sd8bho1od0Ugrt7o7Y8k7ghpEfa0P0mTBSzXJVwIFFqCa+Qifx
         lOvfFRVMjGd1PKBUApbid/olV+0O5CI863XDsB8MR5G5iotZqXSssMCxoNtjviwiar2R
         +wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719007220; x=1719612020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYRmrZk/aEL6RfaLpWp/mJW1FmKM8PDTW9pFtzpph7w=;
        b=m8hRSIDOtyg4dza0adOdNkGfWnUJkay2gMjPVyxMFxqXZzrzia+3D4B0BNfks6seFG
         axhzKwBtxqWgLK6sogR2UUaErTc6Xt2J08X4l002NzdaQlWEkXknAuKf2oFM9feYFh6R
         EWeRfXiEWPZBJxQJerW8QRL/uDXK7BMXdc497HV1rs5cjCqbU4HofuVW5FtIRWBffTha
         MQfmmTym2fisSesoZ2M01ZhJjo+BcEpG0mtyZF1BtwLZnaIKVbMmD7KIfOCBkUGyRVmi
         kKBms84MObjPGjinNScaCcBpi8xRUxkMc1+sq9mlzmgj0zdpHmTqDxoYQ1MoTPIHjfLE
         LhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOyBcPbtmgZizcKGHQFZJkYKzmOTBWy+aLqolJ/F0H6GlgJ6NH2lhrKKQLoCJSczkwcf3PRJufx1khzWyVsB50xS1+
X-Gm-Message-State: AOJu0YyY0QJqE5pP1lHnGieGSKyTDxy8Bw+iDnt6p+8I3gf5GBkW83Z0
	lTOCDwankjt5deutWygxTVZU1LsxgMNjeJAO/HhY4IEvSTppc3yqKqLwnN8YyU7ZVjGJPcLhJTs
	jl3vwqpeqKa8hS0sLcsmAfN48U+U=
X-Google-Smtp-Source: AGHT+IE9mOSICaejvIMOwD57Jcf1mkLpCv8XLQvcIbleWPXyBFLAbdfchgcC+yGVN7wS5QIT/kxtYdCBfFZHImCdOWI=
X-Received: by 2002:a17:90b:4d8a:b0:2c8:84b:7d70 with SMTP id
 98e67ed59e1d1-2c8084b816amr4758166a91.42.1719007220342; Fri, 21 Jun 2024
 15:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620091733.1967885-1-alan.maguire@oracle.com>
 <20240620091733.1967885-7-alan.maguire@oracle.com> <b9d80fb01651771108df802afd49748c8976da70.camel@gmail.com>
In-Reply-To: <b9d80fb01651771108df802afd49748c8976da70.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Jun 2024 15:00:08 -0700
Message-ID: <CAEf4BzbKMZdh-NZPFSDtpKHSYdAhrsc5rabBrm_xes=vQpL-gw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/6] selftests/bpf: add kfunc_call test for
 simple dtor in bpf_testmod
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, acme@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mcgrof@kernel.org, 
	masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com, 
	bentiss@kernel.org, tanggeliang@kylinos.cn, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 4:41=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-06-20 at 10:17 +0100, Alan Maguire wrote:
>
> [...]
>
> Hi Alan,
>
> I still get the error message in the dmesg:
>
> [   10.489223] BUG: sleeping function called from invalid context at incl=
ude/linux/sched/mm.h:337
> [   10.489454] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 184=
, name: test_progs
> [   10.489589] preempt_count: 200, expected: 0
> [   10.489659] RCU nest depth: 1, expected: 0
> [   10.489733] 1 lock held by test_progs/184:
> [   10.489811]  #0: ffffffff83198a60 (rcu_read_lock){....}-{1:2}, at: bpf=
_test_timer_enter+0x1d/0xb0
> [   10.490040] Preemption disabled at:
> [   10.490060] [<ffffffff81a0ee6a>] bpf_test_run+0x16a/0x300
> [   10.490197] CPU: 1 PID: 184 Comm: test_progs Tainted: G           OE  =
    6.10.0-rc2-00766-gb812ab0e1306-dirty #39
> [   10.490356] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1=
.15.0-1 04/01/2014
> [   10.490475] Call Trace:
> [   10.490515]  <TASK>
> [   10.490557]  dump_stack_lvl+0x83/0xa0
> [   10.490618]  __might_resched+0x199/0x2b0
> [   10.490695]  kmalloc_trace_noprof+0x273/0x320
> [   10.490756]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   10.490836]  ? bpf_test_run+0xc0/0x300
> [   10.490836]  ? bpf_testmod_ctx_create+0x23/0x50 [bpf_testmod]
> [   10.490836]  bpf_testmod_ctx_create+0x23/0x50 [bpf_testmod]
> [   10.490836]  bpf_prog_d1347efc07047347_kfunc_call_ctx+0x2c/0xae
> [   10.490836]  bpf_test_run+0x198/0x300
> [   10.490836]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   10.490836]  ? lockdep_init_map_type+0x4b/0x250
> [   10.490836]  bpf_prog_test_run_skb+0x381/0x7f0
> [   10.490836]  __sys_bpf+0xc4f/0x2e00
> [   10.490836]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   10.490836]  ? reacquire_held_locks+0xcf/0x1f0
> [   10.490836]  __x64_sys_bpf+0x1e/0x30
> [   10.490836]  do_syscall_64+0x68/0x140
> [   10.490836]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> The following fix helps:
>
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -164,7 +164,7 @@ bpf_testmod_ctx_create(int *err)
>  {
>         struct bpf_testmod_ctx *ctx;
>
> -       ctx =3D kzalloc(sizeof(*ctx), GFP_KERNEL | GFP_ATOMIC);
> +       ctx =3D kzalloc(sizeof(*ctx), GFP_ATOMIC);

fixed while applying, thanks

>         if (!ctx) {
>                 *err =3D -ENOMEM;
>                 return NULL;
>
> Thanks,
> Eduard
>
> [...]

