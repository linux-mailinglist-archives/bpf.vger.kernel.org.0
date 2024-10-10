Return-Path: <bpf+bounces-41511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE19979E8
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 02:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C1B1C2086B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 00:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9F17C9E;
	Thu, 10 Oct 2024 00:57:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0EB663;
	Thu, 10 Oct 2024 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521865; cv=none; b=eyNWkkHPnguEyKJzAaHqUma12ZYgfpXXjX34QfyMbkZSs091z9kzSSXNwvOOZZMPfFyO/CYtzV+A8c6QHnPN4uJiGSk2qMutEaTZmRUEan07RtYbMhLXIOhyqpkCISRih5+gGsKXkOc/KTCrNn/XpbC6WtHaqneUR/BAvde/tCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521865; c=relaxed/simple;
	bh=cw3ljwGcgCHCkRtCcchi1d4e92jE0gpUejeSr0CFMF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hADxIfa4sxshu5GImOPGDZGvBQu5mF8hXbRV6uSu6zwl4REsQNc1UatUS22uwkXall2sRoQzWeBWMRepGAqCZ/uuhGEzGa/2LSvcipertz3U9rrIMAmUS14hOCcE9i6sGpVOAJaYaJht8e14wdPwKIeCwAfeCgQD0nLfjM/rEuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0AEC4CEC3;
	Thu, 10 Oct 2024 00:57:44 +0000 (UTC)
Date: Wed, 9 Oct 2024 20:57:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Juri Lelli <juri.lelli@redhat.com>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Jose E.
 Marchesi" <jose.marchesi@oracle.com>
Subject: Re: NULL pointer deref when running BPF monitor program
 (6.11.0-rc1)
Message-ID: <20241009205750.43be92ad@gandalf.local.home>
In-Reply-To: <20241009205647.1be1d489@gandalf.local.home>
References: <CAADnVQL2ChR5hGAXoV11QdMjN2WwHTLizfiAjRQfz3ekoj2iqg@mail.gmail.com>
	<20240816101031.6dd1361b@rorschach.local.home>
	<Zr-ho0ncAk__sZiX@krava>
	<20240816153040.14d36c77@rorschach.local.home>
	<ZsMwyO1Tv6BsOyc-@krava>
	<20240819113747.31d1ae79@gandalf.local.home>
	<ZsRtOzhicxAhkmoN@krava>
	<20240820110507.2ba3d541@gandalf.local.home>
	<Zv11JnaQIlV8BCnB@krava>
	<Zwbqhkd2Hneftw5F@krava>
	<20241010003331.gsanhvqyl5g2kgiq@treble.attlocal.net>
	<20241009205647.1be1d489@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 20:56:47 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I was thinking if something like objtool (could be something else that can
> read the executable code) and know of where functions are. It could just
> see if anything tests rdi, rsi, rdx, rcx, r8 or r9 (or their 32 bit
> alternatives) for NULL before using or setting it.
> 
> If it does, then we know that one of the arguments could possibly be NULL.

Oh, and it only needs to look at functions that are named:

  trace_event_raw_event_*()

-- Steve

