Return-Path: <bpf+bounces-69360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBDDB9547B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7F0190666D
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 09:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53174320CBD;
	Tue, 23 Sep 2025 09:38:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFB78F51;
	Tue, 23 Sep 2025 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620300; cv=none; b=A0pYKFSrL5hwOZgw2AQKB1UunF5F0ZLzwdUAcNKCnSBZbPBa4rt/4/NJKf/Y1/m+95oQV6+oZtLiHpYX5Ivbh651/m99O+37w+lObKBwNIQ/EScsdQJc7VbkY6EtiJFac4bu544qhlSKmP8cRsfO/TU5n3qs0kMmM0gbYsUK+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620300; c=relaxed/simple;
	bh=hhSdDPgeVXFdLc5At3Dqi7NuTmkDRjPmDyhTsE9ULBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiipKOReoEyg2lQBzRK/TpM6ls43ICG+u5ukdLzZcpGNjK9DH1VSfPeWHKFfyv57WkEGzjss/b5d9mYNJEJDARpFLKOwenfXwHko4Ohv94TJed/c+axSOa55KPAzJizSW89wncXnLan3ByFaC5q1KTfatwsfOsm3MgMI+dKBYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 7E8E213AE53;
	Tue, 23 Sep 2025 09:38:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 279C420027;
	Tue, 23 Sep 2025 09:38:07 +0000 (UTC)
Date: Tue, 23 Sep 2025 05:38:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: fprobe: rename fprobe_entry to
 fprobe_fgraph_entry
Message-ID: <20250923053803.0adee9a0@batman.local.home>
In-Reply-To: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
References: <20250923092001.1087678-1-dongml2@chinatelecom.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 57cnhcjhjt5r5kffzjfkpjjukxg7qyc3
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 279C420027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19O4u4nSSCwymIDA7wqHMfAXLp/t6GK0Q4=
X-HE-Tag: 1758620287-100015
X-HE-Meta: U2FsdGVkX1+llrdTj9tfpUOCSxr85uTKc5SZbaQbF5Lj56YCGgBtdjMLGnMxlsd4/TC6lxc6nY0vGg/Jsz/UVKWImMy07KRL2pqIkaiFFyCo+k3cY398AAyX0VZS3jXHqRR+l9NUn8tGsn7y4URY39N9VMxzGK+DnI+q+8fhmnXcstEVHCRGJrcgpaxFriAtn6Uv68hY0TRBj1AjQKbEH8w63KfFMdTfLO6ZnvUmhyDpTxL2gpBtyCKGsohcVQ1vxJrVJT4L4i8yaz2olOT5+n3zbJcUCjoe827Iwk1ZdGTHjk6xis4pbEEBZKL1Wlmc8bujqfUe8t8huO0v2fyKWZM7oEwT/5xJ

On Tue, 23 Sep 2025 17:20:00 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> The fprobe_entry() is used by fgraph_ops, so rename it to
> fprobe_fgraph_entry to be more distinctive.

The change log should be more specific and state that this will allow
to have fprobes to use ftrace too. I didn't know why you did this until
I saw the second patch. As change logs should be self contain, it
should have enough information to not rely on knowing other commits to
understand why the patch is made.

-- Steve

