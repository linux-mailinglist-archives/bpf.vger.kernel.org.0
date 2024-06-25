Return-Path: <bpf+bounces-33074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB1916ED5
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 19:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AE11C22CBE
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 17:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95F176ABC;
	Tue, 25 Jun 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uo7+oQM2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F1sjTFCO"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F282F56;
	Tue, 25 Jun 2024 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335172; cv=none; b=MVN8rE3U7xHW4LjgiLnpY5tdoJTxNWiOv9uUjPv3AwUFmFYZOiBjBMLMBMIsxYYIDfGz0vi0wUGpV8/axse/BaqmPG80TrUOmEN+Y5yRW6C9bOXQWc2FzIKcOPCZ2vMeh/GDUM1qCxLzLGJd0yA65vlp441cOST61HAkf9sVf14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335172; c=relaxed/simple;
	bh=UTmZystc/lUIF2dv8V5MVxh724Lvos5ltuhrFv04XU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO6HI3f5v3ywHf+9pR7QzY+UYuLubHW/B95O5dsi5vPKSqDw8xxBp9auRwsS79IgX4cfneR8f6b2/N4dHw633hR8EG0zSkdG6rf98QF24k/gGUOuFyFYEer4SvI0P51YJyw9MXJDoV/6swNulBQT8g+Xkk5o0ApfosVzjUAm28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uo7+oQM2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F1sjTFCO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Jun 2024 19:06:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719335168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDKcb91P2bymxECJFmNCk0GOaYMAG2KZIckrdZE6cQM=;
	b=Uo7+oQM2NAbTRCNa0S5m5WVy0/w/jVy2j2L/fdgHY8xjfj1sS41vZp8X1PaPbSw7A+ijEq
	Ckty3m8DHhCwIkxm7S/7qhN8ziGG9NZGhhKfjpGdZzbH7V/wRVMxXxthjG4St4L7ORNKu7
	oxZv0fZLq16YJZYLfx6nCmEGp3mJSH55+eyeP2W/tKsnW+tODa+bY1l+4K6IrrIJLSZuAd
	k3aZrb/Oy6gPb4R2AqigEuyrmQv4hH1Xn+SlAITVRjTBIZ62FI0DtP4yvOIo67QyoowePr
	XF9Le7rorxru/XBJPEAmkKKXIbOvasdGUeomjLu0OEAXbJlKxql0ph9UqU1+zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719335168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDKcb91P2bymxECJFmNCk0GOaYMAG2KZIckrdZE6cQM=;
	b=F1sjTFCOFfnKOnRTvpYlZsggX3FRB9ypKtLh86a1ZH7+1vVOe0/MDMDZf7dKSfMT2kVNp0
	91LJAstjVbti3xDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: syzbot <syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me,
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] WARNING in bpf_lwt_seg6_adjust_srh
Message-ID: <20240625170606.Ed9u123U@linutronix.de>
References: <000000000000571681061bb9b5ad@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <000000000000571681061bb9b5ad@google.com>

On 2024-06-25 09:51:25 [-0700], syzbot wrote:
> Hello,
Hi,

=E2=80=A6
> commit d1542d4ae4dfdc47c9b3205ebe849ed23af213dd
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Thu Jun 20 13:22:02 2024 +0000
>=20
>     seg6: Use nested-BH locking for seg6_bpf_srh_states.
=E2=80=A6
> WARNING: CPU: 0 PID: 5091 at net/core/filter.c:6579 ____bpf_lwt_seg6_adju=
st_srh net/core/filter.c:6579 [inline]
> WARNING: CPU: 0 PID: 5091 at net/core/filter.c:6579 bpf_lwt_seg6_adjust_s=
rh+0x877/0xb30 net/core/filter.c:6568
=E2=80=A6
> Call Trace:
>  <TASK>
>  bpf_prog_2088341bddeddc1d+0x40/0x42
>  bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
>  __bpf_prog_run include/linux/filter.h:691 [inline]
>  bpf_prog_run include/linux/filter.h:698 [inline]
>  bpf_test_run+0x4f0/0xa90 net/bpf/test_run.c:432
>  bpf_prog_test_run_skb+0xafa/0x13b0 net/bpf/test_run.c:1081
>  bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4313
>  __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5728
>  __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5815
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f

I assumed this can only originate from input_action_end_bpf() but
clearly this not a hard requirement based on the report.
So this a valid invocation and it should not have been killer earlier in
the stack?

Sebastian

