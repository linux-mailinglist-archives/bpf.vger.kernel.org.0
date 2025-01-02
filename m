Return-Path: <bpf+bounces-47770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 996E59FFF59
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 20:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B61E3A14AD
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 19:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38461B2188;
	Thu,  2 Jan 2025 19:22:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354F16EBE8;
	Thu,  2 Jan 2025 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735845772; cv=none; b=nFG780Xo+VMTmxNP+Ylu4vIhDX0ZF5CEGK3s8bm/cEtPAhUf6xV2g82ykcpl+7mp1gCujq2/koc/J0hpfXoAEQYZ0feRuQ5Qp5M9lDIhuAoZzmLegemN84r+WDgktHzCnklGHBK+f5ml8DVbip6ltG9sSazaTvtqjkl96y9ZaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735845772; c=relaxed/simple;
	bh=vFK9Ij6azRSAOqghSs1x5QEXxLFEh8eSBwKMNgwD4NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elIBZUpQj4BM/usIJfKnZhaApXfKfsrkjUsLiIecnPTYOm0KwDDtfEXwv7PWDH1Gx/b0exJALWhj/h5pTmJ5z45iM1BLtiyqB5JUxUq5r1OaQqAzhSy1FGTRtUAksRYHYGdmQKsQnsX89L/j3z84Lofh3L9ScroL9mDYm289RAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22691C4CED0;
	Thu,  2 Jan 2025 19:22:50 +0000 (UTC)
Date: Thu, 2 Jan 2025 14:24:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Zheng Yejian
 <zhengyejian1@huawei.com>, Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: [PATCH 00/14] scripts/sorttable: ftrace: Remove place holders
 for weak functions in available_filter_functions
Message-ID: <20250102142406.00a55f7c@gandalf.local.home>
In-Reply-To: <20250102185845.928488650@goodmis.org>
References: <20250102185845.928488650@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Jan 2025 13:58:45 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> The last patch adds the option "-s <file>" to sorttable.c. Now this code
> is called by:
> 
>   ${NM} -S vmlinux > .tmp_vmlinux.nm-sort
>   ${objtree}/scripts/sorttable -s .tmp_vmlinux.nm-sort ${1}
> 
> Where the file created by "nm -S" is read, recording the address
> and the associated sizes of each function. It then is sorted, and
> before sorting the mcount_loc table, it is scanned to make sure
> all symbols in the mcounc_loc are within the boundaries of the functions
> defined by nm. If they are not, they are zeroed out, as they are most
> likely weak functions (I don't know what else they would be).
> 
> Then on boot up, when creating the ftrace tables from the mcount_loc
> table, it will ignore any function that matches the kaslr_offset()
> value. As KASLR will still shift the values even if they are zero.
> But by skipping over entries in mcount_loc that match kaslr_offset()
> all weak functions are removed from the ftrace table as well as the
> available_filter_functions file that is derived from it.
> 

I mentioned this in the last patch, but forgot to mention it here.

Even if kallsyms is "fixed" where it doesn't return the name of a function
if the address is outside its size, that doesn't fix the place holder issue
with available_filter_functions. That would just make it easier to know a
function doesn't have a name, but a place holder is still required.

This patch set removes those place holders regardless of kallsyms being
fixed or not.

-- Steve

