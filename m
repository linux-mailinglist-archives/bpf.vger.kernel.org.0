Return-Path: <bpf+bounces-69524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06496B9906D
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 11:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABFC19C3701
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4582D640D;
	Wed, 24 Sep 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMp6Mazk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965A26D4E8;
	Wed, 24 Sep 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704665; cv=none; b=IjgZEITKuiTDp4d53gBT10Fu0jBdwLBy0XxNcjDrRX0j93AeWyvLDwfCP28ZBTWDTz+aPmT8Ww5dFMp1TS9cENyTkDkn5u92YC3sRY0uAfBycOBSRwhd/ZeUyuY9qM9mqib8xi5jPDTS2qJJUKJ97w2R+l3e4U8bC55KTh7L0fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704665; c=relaxed/simple;
	bh=CUTT6hFM029zyjt/sjCwVOO+wqY+uTvnvdQD3tLQyrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1hA11whNbj/uvdT+1P1n68bJh4k4pydBBLtm92o9hsOsWPpnYKMwvKQVmw2H0aRrZmgKLB4/ImW8y1sPoY4LUNNWHGjqbQZGy+s1WmTrIVtNGDrIT8UCDgGsp/gI/HdvxyO/FqP9D2ExIkxIGIo+bfWzgTneii48Qs2mHRB32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMp6Mazk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4455DC4CEE7;
	Wed, 24 Sep 2025 09:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758704664;
	bh=CUTT6hFM029zyjt/sjCwVOO+wqY+uTvnvdQD3tLQyrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LMp6MazkSQJXJ8I6WoKZonLwloDu1TlRBsxn2SISgTWfgor5fTzZqreXC0A178NQv
	 2W6inYqft3xuBI0fLzDACrLF0fA5HUirKLtYR/YbdgEEdPbYovcu8ljb3gjmm7MvUc
	 Pkx/GJiZlmjfpkc+GcC/JrybxeQOK6lzyVtz7HsZ4vYUz/+/c7dXvrAooWuHtT74hO
	 RHdNe2/43+2iTmACINI9Hs/i9uAW84nINWExoheXn1JW0NI5fbytRm04rGjd4Oy+4w
	 nE++ov9O8vM6lxDSWK84tD9mqNrp046b190IeOIeMceYsctEnE2mggUSfOzjAUCI44
	 dQKIauozEc5Lg==
Date: Wed, 24 Sep 2025 05:04:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Menglong Dong
 <menglong8.dong@gmail.com>
Subject: Re: [PATCH 2/9] ftrace: Add register_ftrace_direct_hash function
Message-ID: <20250924050415.4aefcb91@batman.local.home>
In-Reply-To: <20250923215147.1571952-3-jolsa@kernel.org>
References: <20250923215147.1571952-1-jolsa@kernel.org>
	<20250923215147.1571952-3-jolsa@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 23:51:40 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding register_ftrace_direct_hash function that registers
> all entries (ip -> direct) provided in hash argument.
> 
> The difference to current register_ftrace_direct is
>  - hash argument that allows to register multiple ip -> direct
>    entries at once

I'm a bit confused. How is this different? Doesn't
register_ftrace_direct() register multiple ip -> direct entries at once
too? But instead of using a passed in hash, it uses the hash from
within the ftrace_ops.

>  - we can call register_ftrace_direct_hash multiple times on the
>    same ftrace_ops object, becase after first registration with
>    register_ftrace_function_nolock, it uses ftrace_update_ops to
>    update the ftrace_ops object

OK, I don't like the name "register" here. "register" should be for the
first instance and then it is registered. If you call it multiple times
on the same ops without "unregister" it should give an error.

Perhaps call this "update_ftrace_direct()" where it can update a direct
ftrace_ops from?

> 
> This change will allow us to have simple ftrace_ops for all bpf
> direct interface users in following changes.

After applying all the patches, I have this:

$ git grep register_ftrace_direct_hash
include/linux/ftrace.h:int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
include/linux/ftrace.h:int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash);
include/linux/ftrace.h:int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
include/linux/ftrace.h:int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
kernel/trace/ftrace.c:  err = register_ftrace_direct_hash(ops, hash);
kernel/trace/ftrace.c:  err = unregister_ftrace_direct_hash(ops, hash);
kernel/trace/ftrace.c:int register_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
kernel/trace/ftrace.c:EXPORT_SYMBOL_GPL(register_ftrace_direct_hash);
kernel/trace/ftrace.c:int unregister_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash)
kernel/trace/ftrace.c:EXPORT_SYMBOL_GPL(unregister_ftrace_direct_hash);

Where I do not see it is used outside of ftrace.c. Why is it exported?

-- Steve

