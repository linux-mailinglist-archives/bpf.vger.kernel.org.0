Return-Path: <bpf+bounces-71017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B7BDF988
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8214861FA
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94DE335BC0;
	Wed, 15 Oct 2025 16:11:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59DA262D0C;
	Wed, 15 Oct 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544702; cv=none; b=LljTWWOCUQwfB4H7NmPkaFB70Z7CJSwS52YaVWz0qptTDTXh/5/xV7j1FcXIQuH88u8QHQMLGFQ+TfBIqP/hgOQAOfDSeydVkP2T4CPOtDOjweCl3FjN/M19hkAmNGIddW8ndMaOctL5G5hHa00DPemhicmSDHm5N5/434Ih10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544702; c=relaxed/simple;
	bh=DOXXYnej07dW90ExuDFSCFYSCaWcO+Qy7hgGb5jV9y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svCl0IY4XBElScnvzn2+ujoMNOCOMhAji/ky9dhuPeW7DU09KU63m74fzw+tmeWjnLIYyKL7elymZtFwFzM3ympPBNxGWFVEMHwGvBUgE0qorrwmuy1L+SnkSN5pvbbRBct48h6gJALQyDZGRd6rF5w7Ofgp0rbQgOfKgMxPmuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A1ADD160201;
	Wed, 15 Oct 2025 16:11:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 560C420023;
	Wed, 15 Oct 2025 16:11:30 +0000 (UTC)
Date: Wed, 15 Oct 2025 12:11:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 Yonghong Song <yhs@fb.com>
Subject: Re: [BUG] no ORC stacktrace from kretprobe.multi bpf program
Message-ID: <20251015121138.4190d046@gandalf.local.home>
In-Reply-To: <wh4eq2iw3qwiuaivz67ygyd2zvafaqrq7i6eakvbdurrbbrcg5@jjfbagedoybk>
References: <aObSyt3qOnS_BMcy@krava>
	<20251013131055.441e7d08@gandalf.local.home>
	<wh4eq2iw3qwiuaivz67ygyd2zvafaqrq7i6eakvbdurrbbrcg5@jjfbagedoybk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tx1yy63e9uekhgdr1ypgqwiqzj7jopqg
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 560C420023
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19y642y/S3K/jzPPZcu1FbaPfAZ5Lj7MHw=
X-HE-Tag: 1760544690-730455
X-HE-Meta: U2FsdGVkX1//HB9Drl7RLVeKWELp4GwvT6wiL7JQsYLqu4N8PeRuEaqUhbP7wvWfskTUpkY4hjIzmisdY4yN23gq1tUnF+5GmqND52E4FMWZI0QmtFD8YUN3xPHY/1mKK9OKnJUdhqutfllsoOQyDC7Ovfbbj/imt4sji57VwxALtHCeSHqSaclh6MDL3Cj3dd3n9OqlK6ddJd2JBqQhm/Sl3DU334CAOebyudVJ5/m88/AhCdh+8g3ImdgttJfqlci3oyxP0bS3QxKEZySH6kt4irLfCgGIkxf2TpCdD8hoTusBtDGkzs9Ls5e2xh0tsvSS58SEYwGieGfkSPv67xJtgbF2nNOS

On Wed, 15 Oct 2025 09:06:12 -0700
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> > Hmm, we do have a way to retrieve the actual return caller from a location
> > for return_to_handler:
> > 
> >   See kernel/trace/fgraph.c: ftrace_graph_get_ret_stack()
> > 
> > Hmm, I think the x86 ORC unwinder needs to use this.  
> 
> I'm confused, is that not what ftrace_graph_ret_addr() already does?

Ah yeah, that does it too. I just searched for the first function that did
the look up ;-)

Now I guess the question is, why is this not working?

-- Steve

