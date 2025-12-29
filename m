Return-Path: <bpf+bounces-77471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A955BCE749F
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 17:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 073BF300E7C5
	for <lists+bpf@lfdr.de>; Mon, 29 Dec 2025 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5932E686;
	Mon, 29 Dec 2025 16:03:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5E32E131;
	Mon, 29 Dec 2025 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024219; cv=none; b=k6QwDeTndUgZbEzaiaaMTzPvLPfYtb3YSujumb7V856eqoWiOGG3Tin5mKC4IqPfRO0gOfcS2vL4aQ21FM+x2LeTJHu9PuPzJwL/fwXHgSvuKcEMsVP7+aWRBaCYMJv7yCi3rLME2KFx+6mRsqZQp/jIbvTxJ9r+qbnBX6P4tnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024219; c=relaxed/simple;
	bh=HmUgq1yr7Ldrp6As2Z2B3JdatI+KSxe5tvhmxvD24NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQ0dOk2fTH+OnYnKHMxjXY1mQfgJFUssiQAznpzhKWO74ZApljRKthZ4CNj5IKevkwl2VuwBpJysxxM7l4UfmaZZrMzYiW49ktw4RagxUtXjvhERyD+b8yjGZrxq8nW4W20IdIId1ylmg3+3esXUXETjmzYoyKU6BeyqosanoUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 1FCD31401C3;
	Mon, 29 Dec 2025 16:03:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 5275D2000F;
	Mon, 29 Dec 2025 16:03:32 +0000 (UTC)
Date: Mon, 29 Dec 2025 11:03:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>,
 Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu
 <song@kernel.org>
Subject: Re: [PATCHv5 bpf-next 9/9] bpf,x86: Use single ftrace_ops for
 direct calls
Message-ID: <20251229110337.030232e0@gandalf.local.home>
In-Reply-To: <aVFLKgZ56wt5aLci@krava>
References: <20251215211402.353056-1-jolsa@kernel.org>
	<20251215211402.353056-10-jolsa@kernel.org>
	<20251218112608.11a14a4a@gandalf.local.home>
	<aUUanPijlWsDlS0X@krava>
	<aVFLKgZ56wt5aLci@krava>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: wk4rtw6rr6g4p4h5uhrzm8w5hsw49mbm
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 5275D2000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+B2wF6tKeYH5GnSEs+kzFmQoFDKLjrxgk=
X-HE-Tag: 1767024212-326374
X-HE-Meta: U2FsdGVkX1/bW0jhkTC4A5lBxmoz7injUkXEiRwc49PHTrEtedO+o2+EF7kEIX13OfCkWR8cfC/wf6yKI/Q0NQDlTnSJsNmpf4yT0wpVV+N4nepWY5mkqko6TEbEej1Hr/XBJOTUmUhLNAw+F8Po9cqWSf80LUhYgReNteLIHYoT3xCo0TXT+IvZW0BFzVvJMpeRVZg0aujEtfTujLBdfwJ6gs/3VmkTqwGCQMfW0cPRs+W71KOxMC0xTVONhn/fO58DXW07r0HY13AiCiGRLvic7zoMOT1W6fEzioF/e36A4d8P1U4RXDcCu+d2MOGF7nIBtPhn3X26ymHlZZaJMYNK8sq9I5FMZaPIESRM/MU5RtaPB+ULqw==

On Sun, 28 Dec 2025 16:22:18 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> actualy, it seems that having it the original way with adding the rest
> of the wrappers for !CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS case is
> easier AFAICS

I'm fine either way.

-- Steve

