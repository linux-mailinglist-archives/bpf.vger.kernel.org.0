Return-Path: <bpf+bounces-78338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEE5D0B373
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 17:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BB02305B482
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 16:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC1A5CDF1;
	Fri,  9 Jan 2026 16:17:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060CD30E853;
	Fri,  9 Jan 2026 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767975465; cv=none; b=DrAHcHtIZ/le9/oPs/cCw0XluPovwe6jPl4QRMiD7lUCSOzWqOpI7X8rEsUFtquzJczhjhNybQt0tUyZMRt+wK+U2yQg+un79rHFkKzlqVQUrmdPWGjSkxEhBjZ5NiPrKz3k0mj26eOh/6ZUwkgbTqboNkOFWI8V/IUiR0q5fnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767975465; c=relaxed/simple;
	bh=u4xJagi6nb7Yc6X9FQFypEMGidVDdmf5kxoL21Ph7G4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L7oky1HgbYFr5tfoz2Y1yCcCB/tYOiUww+RqAr9PMiAIvFbosM1COx8OIUF6vjkH/vr7R+Fkv8IduOG+s5j/FELpFHQE/NBgfH1mfAu7KXurHnte3xnf1+yMflIaqeWOO4E38sL6U5S7LFIrlIoVIBnk0bK+9gavhyMfyN3rmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 40B7F160333;
	Fri,  9 Jan 2026 16:17:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 7C3552002C;
	Fri,  9 Jan 2026 16:17:33 +0000 (UTC)
Date: Fri, 9 Jan 2026 11:18:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Will Deacon <will@kernel.org>,
 Mahe Tardy <mahe.tardy@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, Yonghong Song
 <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 bpf-next 1/2] arm64/ftrace,bpf: Fix partial regs after
 bpf_prog_run
Message-ID: <20260109111804.481a6f20@gandalf.local.home>
In-Reply-To: <20260109093454.389295-1-jolsa@kernel.org>
References: <20260109093454.389295-1-jolsa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 7C3552002C
X-Stat-Signature: f8aus8gwt9gwwghji8dnqrqaet4ioy6e
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+dsryzGlYq/IBaVcXmTxW02qO+AtSzCCE=
X-HE-Tag: 1767975453-939575
X-HE-Meta: U2FsdGVkX195HTS3PXdoSrXMaKW9jSAqMC2F/Zr2Crpg0MiCloYO/UukNadfj8DBKa27oZ27laPKm/4He9R+NuUHpk6ZGtccKIKcGfY1T9mIju3yta15pVGhCsAjwPOP6oPCBuH/XmjyjXw8274URJ7oA7jwvw5b9EtIk662f2w5s+yFnw8OyJioll9LUPMhshmXpiMGzRVnTS+iMFJgImpS30y4O+Wj1gMyXdQMGCq5Fx+WF0QEa+qLcbzoI456A5q7Jgyv5eEIOt5SDZHm9yUWIjNt/aDsZdfMPQ5ZpY90q7BzwAsiwGprE//EDWLHCDd3z+Ajbnnh14kJleRYrTL+ooQCFoK6kixAZ3n8EeCIvhGQdH0Z/SLDZxU8yTijGfgy/xE9hzqWJAJEcCDEySYDlazdn704J1SZt0Bu7jc=

On Fri,  9 Jan 2026 10:34:53 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> Mahe reported issue with bpf_override_return helper not working when
> executed from kprobe.multi bpf program on arm.
> 
> The problem is that on arm we use alternate storage for pt_regs object
> that is passed to bpf_prog_run and if any register is changed (which
> is the case of bpf_override_return) it's not propagated back to actual
> pt_regs object.
> 
> Fixing this by introducing and calling ftrace_partial_regs_update function
> to propagate the values of changed registers (ip and stack).
> 
> Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

