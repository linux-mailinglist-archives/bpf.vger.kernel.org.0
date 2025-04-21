Return-Path: <bpf+bounces-56353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E056A959AE
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 01:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5A8174888
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 23:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BACC22B8AC;
	Mon, 21 Apr 2025 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAxXH8WV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E6BA4A;
	Mon, 21 Apr 2025 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745276662; cv=none; b=OCU7R7XDSl2anXIIAxN4AqXnJ5JB3rdmB16bDANgxyPuc/EGcc55MhTuLgbJDUsLcitvdvAeOYCpEa2lQR9SSxyNg1Y6JXP/19GimYIVZo86n19+uLmVffBtNGvmBW+ePXv7pxv+KQKk/D/O4SBFM93m8/15yB/SBwuGy2N94Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745276662; c=relaxed/simple;
	bh=FH7eNw8A9oKIsd9Yr14rZHcuTIHvuGQLaMOsp+wZksY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBQkrLYZz/UU+VLFzqnYEtfacBxsYL9e0SQ+3+oH02sVnDqZCxkPl0WQ+B4fyn8yQqU4M0bIsZm5RS5wlFgVn3dSkbkc785yLVsk3LjkmqY1NC6vNZK72Z+f0HvTEZkIJAGJAGhj1xdBo9KGJQvZRfgP8aLuUMA2YJhIEQLsK/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAxXH8WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85855C4CEE4;
	Mon, 21 Apr 2025 23:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745276662;
	bh=FH7eNw8A9oKIsd9Yr14rZHcuTIHvuGQLaMOsp+wZksY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAxXH8WVO9TbZS0yRT7cgaiMJ5rsqtfRQHX7PnJXUdes2BEDQRWwG/9j7DNKSYb5G
	 y+UzsADBQ8ZIGke163tYFbWFgtwF9AJkicytzrfFBMo9gffAi0JazT5FRAmsaLjB7/
	 7i5pHd92KCb67WVRl+LAlk3aZp6f2kNzwOk0T1+x+sBErjiq49ExEFTdYmY5kbVEHG
	 dK2WwwJwIvB+gWn1vefBLBkh/PfOP3R8UkX3YFenf/KW5DpAorJaHBLmY8gY7JeLhE
	 5jnRrG+J8UfAE1Qr4sjWLctXUrLzZ+7+pd2rMnTki3Jyp5f5buZGk2CaRSH6Q+KEOo
	 dqlI6HB0D2SPA==
Date: Mon, 21 Apr 2025 16:04:19 -0700
From: Kees Cook <kees@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 21/22] selftests/seccomp: validate uprobe
 syscall passes through seccomp
Message-ID: <202504211604.13B36E50B1@keescook>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-22-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421214423.393661-22-jolsa@kernel.org>

On Mon, Apr 21, 2025 at 11:44:21PM +0200, Jiri Olsa wrote:
> Adding uprobe checks into the current uretprobe tests.
> 
> All the related tests are now executed with attached uprobe
> or uretprobe or without any probe.
> 
> Renaming the test fixture to uprobe, because it seems better.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Eyal Birger <eyal.birger@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks for updating the tests!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

