Return-Path: <bpf+bounces-73745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C793C384BD
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 00:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2545618C6026
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 23:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EB82F066D;
	Wed,  5 Nov 2025 23:04:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7F224AF0;
	Wed,  5 Nov 2025 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383874; cv=none; b=NR55UjfZOhcf/UUfm8QIy9GgSqqvhTSSppFRvW0dsusozdRo4C60Rs/rNKu8cMNFNflzLimR4j8LD62DFGAWv1jv8WcMipzy7lYJktTWg9inZOiTLxhwmbsND9r19bYZf07TUZpfNTozIwLdXvQTU6lrhUVRgxCHyN2BCUMa6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383874; c=relaxed/simple;
	bh=0rrqmkaj7x0Q7F33qcN3GD0vfzlYAbXLBOiEHfYEpko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrFo1JvuIag61svTdimT040YqkkMiTWCX5xzX4rE+9hHNiGrIdrcnuIvv3W/CnZmHZh91+F+/kZ24w3OS8QDw3OqMmvAgdsCWl4qWAK+6E7eqoBYpFBmwwni9PfhiEhV5lq1FZTge8WIafQjPRomVaPjuKslVsV/McJhvDGA2Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D74B31404A6;
	Wed,  5 Nov 2025 23:04:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 69A3E6000C;
	Wed,  5 Nov 2025 23:04:27 +0000 (UTC)
Date: Wed, 5 Nov 2025 18:04:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, bpf <bpf@vger.kernel.org>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Yonghong
 Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko
 <andrii@kernel.org>
Subject: Re: [PATCHv3 0/4] x86/fgraph,bpf: Fix ORC stack unwind from return
 probe
Message-ID: <20251105180436.369bef64@gandalf.local.home>
In-Reply-To: <20251105100359.2e6eeae5@gandalf.local.home>
References: <20251104215405.168643-1-jolsa@kernel.org>
	<CAADnVQJRv+2NT2TGd7nXbOtx_Cnsg=kOJuikOtL9aEdUVmwvag@mail.gmail.com>
	<20251105100359.2e6eeae5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fgdzzmbqw9dj5pxx7p4m7ohnpwpt4iw5
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 69A3E6000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+oy1W0um2quqCXqqxlNLP0Hbx46cfeda4=
X-HE-Tag: 1762383867-273358
X-HE-Meta: U2FsdGVkX1+bX4KGoqi+xgbCt1eN32WVAtoZBIPbE9XYJ/rkQ5vTzIhgis70s/yyjpKmn5VgSO13yDIYIfKlyng7dkD59VNfTO3OYvoIsnJ1laKTiaPMzs2rkCAa9rfOg8S8nWKMPrhT843r66+f1zF8eqakxCOhJryaP+JcLNIafOqW9QrnXsr/TgAKpRqEKIuvoz3fhzIlQTuu6FCfmWgS5ceau6rjtuDFuxmG3UxPW2EKq/YpbJxSZNoyI6id9tRwYotfi6o7+1W4xieBqDIYqAMF3rRTwJcJZ9IeT/fKeK9Qp7rZph52UBeW6WHSQ4C2u77sA4SRTCF5yXYOUb0TU/jt1hWBzBmgR90eCNybrTT9eoq1uvlMTog6s8qGogD6zIq/PsW5GkEMaOQw+w==

On Wed, 5 Nov 2025 10:03:59 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Let me run this through my tests and then I'll give you an Acked-by and you
> can take it through your tree.

It passed.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

