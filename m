Return-Path: <bpf+bounces-76919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 162BACC98EB
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 22:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E07E301739A
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 21:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C8930F53E;
	Wed, 17 Dec 2025 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VQ25ZOjv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C830E0F4;
	Wed, 17 Dec 2025 21:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005837; cv=none; b=Gv6CjCXS4SnaeJeBzrOtKjBovFKXlj9sWrbbBBONmWw11xTtvVkQhBtUShFflxZOJHYsYvvZxcXiEBhFF31hJm/tu4LPPJBvktiJauTj413bN8/ImPlArQnZsiHHihK17jpC7Tuc264SbEZMYpn23E7IZqyWnkOtjrXnQiiQPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005837; c=relaxed/simple;
	bh=H/UivWUmzn/uHjBsx2v4acnIi0mp8px46mtcwuYIaFc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Nb2MEOA2oeOJ2dwTWQw5WwKPbIbC40QlEJfABjyPC/onNxIQkb/irTBdpmCuypULsjbts0zKxbVBViEMTS+aH3/76MjAAT7aVRJjCXfLQKW7g3B9WbRkHKsiL538fBsg0ofGQDf9SgahDTzGLYeEmA7t1OL89P5w29c71HGxc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VQ25ZOjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D3FC4CEF5;
	Wed, 17 Dec 2025 21:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1766005837;
	bh=H/UivWUmzn/uHjBsx2v4acnIi0mp8px46mtcwuYIaFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VQ25ZOjvMUgNQqMYp2I730O85nYGybn/sRyqBytwhOcM/Cj8zqiDrxCjeh/IQSeSg
	 QAHmy6JFr/tuRF8kcrO2KjHnvz9yWVUTl+7lw0yWltE6zyYehSISElrjcXtTXtawLx
	 AsBFwR26Bp6B8EBc6uUUdDB7gywumnJb8tCphag4=
Date: Wed, 17 Dec 2025 13:10:36 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, Aaron
 Tomlin <atomlin@atomlin.com>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Luis
 Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kallsyms: Prevent invalid access when showing
 module buildid
Message-Id: <20251217131036.589576e8c89b89c01ea53cf9@linux-foundation.org>
In-Reply-To: <aUFl9n3b8DWnYGyJ@pathway.suse.cz>
References: <20251128135920.217303-1-pmladek@suse.com>
	<aUFl9n3b8DWnYGyJ@pathway.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Dec 2025 15:00:22 +0100 Petr Mladek <pmladek@suse.com> wrote:

> I wonder who could take this patchset.
> 
> IMHO, the failed test report is bogus. The system went out of memory.
> Anyway, the info provided by the mail is not enough for debugging.
> 
> IMHO. this patchset is ready for linux-next. Unfortunately, kallsyms
> do not have any dedicated maintainer. I though about Kees (hardening)
> or Andrew (core stuff). Or I could take it via printk tree.

I seem to be a usual kallsyms patch monkey so I scooped it up, thanks. 
If you or Kees prefer to take it then I'll drop the mm.git copy when I
get notified of the duplication by the linux-next maintainer.

