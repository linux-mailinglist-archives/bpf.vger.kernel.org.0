Return-Path: <bpf+bounces-31840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFE6903EA1
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 16:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804EA1F2355C
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F3317D8A8;
	Tue, 11 Jun 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDRL8FNm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F51EF01;
	Tue, 11 Jun 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115933; cv=none; b=X/psZ6Hdv3rrr3ZcQXLAJo7tkQ33C0Ni/sMTE7cVYHM4CSdfbVwBDfckCNmqaXXqVtvVfrc2c0lh881AUB4NjlRKTj0/tnS/BJ/arJGsSD10cLPW8mPVqSUN+Vrcg+AjJubFRRb5uXCKTYegQSpnqJlDAi0Zvp93anaKfTaUUHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115933; c=relaxed/simple;
	bh=q7wQiHNLHYzy0RjwM792O1yu2UhopzF0mTpZxoTHKKI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mDuUV79Ht/YEEpOihflZ7STpvoRqyhZSMAH5YOR+k3Y6P6/j58vts3Nb5G6Ig6LrDaXdXzIVfyLD6HCfIAodffvtF9Hhcvgxa5NJxWk2dxbyR9HVHZUla9JG3XZ2ykGhUMGTqxRPW+h/o+ysKndogpvKca1aZ0LpTFaRlD7P/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDRL8FNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1124BC2BD10;
	Tue, 11 Jun 2024 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718115932;
	bh=q7wQiHNLHYzy0RjwM792O1yu2UhopzF0mTpZxoTHKKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NDRL8FNmdTG9WJ8ghyWQ/Lm8Qrhi9UqZ/CL9dnVq3O+mtLbeAK9bz3RHBQ8qePPH/
	 cOSZFfugvnKTO6ajItL3nBxo5zU2N6pQ2rfS7C12MUBaxJoOhJQMMOhKdvvwkMTiDY
	 vZmhORBPwNlozlOpHheOYw/hM9PnMEOaPSD1HZ9CzDivUxS40b8U9+eiDH8s5mIYKl
	 5oa4eHCQCQDAZ0F9NUloJN3H9FI0GDxXm0Nz6NuW+AsnzhtA+NHQ1925raVy/NzskX
	 16VI7jp4LnTNmI0Qg5AFXgD3nKcPax/6Tw56l8TvBMMKXMDNT3/7DSavVlN0XIB7T3
	 z+nMKVEfIMHOQ==
Date: Tue, 11 Jun 2024 23:25:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org, x86@kernel.org,
 bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCHv7 bpf-next 0/9] uprobe: uretprobe speed up
Message-Id: <20240611232525.c4aaee0d1a0ea3c7ecd78076@kernel.org>
In-Reply-To: <CAEf4BzYcwUS=7KFX5fUibS9eLT8yQxYqaWF_+sVM0YZJzBD=Sg@mail.gmail.com>
References: <20240523121149.575616-1-jolsa@kernel.org>
	<CAEf4Bza-+=04GG7Tg4U4pCQ28Oy_2F_5872EPDsX6X3Y=jhEuw@mail.gmail.com>
	<CAEf4Bzbc99bwGcmtCa3iekXSvSrxMQzfnTViT5Y-dn8qbvJy7A@mail.gmail.com>
	<20240611064641.9021829459211782902e4fb2@kernel.org>
	<CAEf4BzYcwUS=7KFX5fUibS9eLT8yQxYqaWF_+sVM0YZJzBD=Sg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 09:30:52 +0100
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> 
> > I think it would be better to include those patches together in
> > linux-tree. Can you review and ack to the last patch ? ([9/9])
> 
> Sure. Jiri, please add my ack for the entire series in the next revision:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks! let me pick the next version.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

