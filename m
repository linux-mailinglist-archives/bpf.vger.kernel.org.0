Return-Path: <bpf+bounces-49420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0F3A18862
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 00:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC11E16A5A2
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 23:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1921F91C2;
	Tue, 21 Jan 2025 23:29:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2A11EEA3C;
	Tue, 21 Jan 2025 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737502179; cv=none; b=J0gRsHRzC0Drg4KALyMJdUM7GvFHOhB5SdIu/UbeFpxzLyhJw2bqu4sxDFZw2IiakOTpBl9srKqXnDtEPeuGstiVSbw6lzXCdyraeOff8EUnmkmoVvF/TKFSCxwQ2mmUHUOhoeiBN0zRT44HFnJCuDCEjTrahS62IoCDTUh3g/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737502179; c=relaxed/simple;
	bh=a70oBIbk3dMa+YfyTeaI68sAJYTMH3i8jYtTuLjJZ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFYWXYPV/DuQBODKiz0h5a5QM/odUIvQiKk0axv1jDCDURvVo7TodlO0eMl5OyBCdS+pMBL/pRNstuioykwVM5DJfeHnzIxtjEg1SiiDyh2hwk6o6eDLwMTifI0kxEp+ODlaLDbccJFGfRiwcDMPzFY4aR/oWwvBETB7F7maAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E68EC4CEDF;
	Tue, 21 Jan 2025 23:29:36 +0000 (UTC)
Date: Tue, 21 Jan 2025 18:29:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa
 <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, luto@amacapital.net,
 wad@chromium.org, oleg@redhat.com, ldv@strace.io, mhiramat@kernel.org,
 andrii@kernel.org, alexei.starovoitov@gmail.com, cyphar@cyphar.com,
 songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
 daniel@iogearbox.net, ast@kernel.org, rafi@rbk.io,
 shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250121182939.33d05470@gandalf.local.home>
In-Reply-To: <CAHsH6GvcOjNh8VMpPs9CzyVSCOB+92zRj_3ZeDOd6APySWdm5Q@mail.gmail.com>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
	<202501181212.4C515DA02@keescook>
	<CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
	<8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
	<CAHsH6GtpXMswVKytv7_JMGca=3wxKRUK4rZmBBxJPRh1WYdObg@mail.gmail.com>
	<Z4-xeFH0Mgo3llga@krava>
	<20250121111631.6e830edd@gandalf.local.home>
	<Z4_Riahgmj-bMR8s@krava>
	<CAEf4BzZv3s0NtrviQ1MCCwZMO-SqCsiQF-WXpG6_-p4u5GeA2A@mail.gmail.com>
	<20250121174620.06a0c811@gandalf.local.home>
	<CAHsH6GvcOjNh8VMpPs9CzyVSCOB+92zRj_3ZeDOd6APySWdm5Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 15:13:52 -0800
Eyal Birger <eyal.birger@gmail.com> wrote:

> Isn't that the case already, or maybe I misunderstood what Jiri wrote [1]:
> 
> > On Sun, Jan 19, 2025 at 2:44 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > that's correct, uretprobe syscall is installed by kernel to special user
> > memory map and it can be executed only from there and if process calls it
> > from another place it receives sigill  
> 
> Eyal.
> 
> [1] https://lore.kernel.org/lkml/Z4zXlaEMPbiYYlQ8@krava/

Ah, he did. Thanks I missed that:

> that's correct, uretprobe syscall is installed by kernel to special user
> memory map and it can be executed only from there and if process calls it
> from another place it receives sigill

-- Steve

