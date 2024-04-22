Return-Path: <bpf+bounces-27442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78168AD160
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0C9286436
	for <lists+bpf@lfdr.de>; Mon, 22 Apr 2024 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3CE153578;
	Mon, 22 Apr 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiCf3AQ8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D415350A
	for <bpf@vger.kernel.org>; Mon, 22 Apr 2024 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801570; cv=none; b=U2+voxJw60GenTROkpeTtbF71xI5iNsXEWvz+qkwCRL/iB31E6tHAqytnwNRyDdYUZveL4mtBewa9gv5V5nX9Prln4XrA4suWtTsNSE640sdLBgveL8Qn1vML/VkJvF2E+8kWCOMXVHL97MCt3e69hWvSwzqQImGOp17A9OkerA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801570; c=relaxed/simple;
	bh=9VMZddks3Ekgx883oDZjsDEI2XJ2LJ0ENmc3CoJLQx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isktbKWqkgfr7hKEARXZiQ96KPIB42KtloYlbm38dxbn5zFQKiQwhAjMb9EpiIGr2ecnUSR8daWlwQaLBAcIUsK/rfl0E6uys/t6LQGRXaLfyUwEQR21OeMyjuBXxGUZNu5RKEcF7u0thcC7nLRbEHwyXLyibzt//9dexrQUC/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiCf3AQ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713801567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZDVlmaFRH28jny24mSZR4RlhL/dQBLA0fwV8V32NgA=;
	b=YiCf3AQ84kieZSLa+T9vo26mmnggdDlk09sg/ZLXEQ5YoQYAIj16ZE1SBk/nvJ/pAjBWTq
	vvld3CMVlqeq7ObMOkhFtna5ZWzsc2yrLEdQ+iVxkLCddwazZpgh19+wxEmu25PcczizWP
	S73IT2av3meRHf7TjTypJKNyI/g0Kco=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-lelwKtoiNF2I2ygstDvVDA-1; Mon,
 22 Apr 2024 11:59:22 -0400
X-MC-Unique: lelwKtoiNF2I2ygstDvVDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 759A229ABA09;
	Mon, 22 Apr 2024 15:59:21 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.205])
	by smtp.corp.redhat.com (Postfix) with SMTP id 595AC1121312;
	Mon, 22 Apr 2024 15:59:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 22 Apr 2024 17:57:56 +0200 (CEST)
Date: Mon, 22 Apr 2024 17:57:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv3 bpf-next 1/7] uprobe: Wire up uretprobe system call
Message-ID: <20240422155751.GB32422@redhat.com>
References: <20240421194206.1010934-1-jolsa@kernel.org>
 <20240421194206.1010934-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421194206.1010934-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 04/21, Jiri Olsa wrote:
>
>  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
>  include/linux/syscalls.h               | 2 ++
>  include/uapi/asm-generic/unistd.h      | 5 ++++-
>  kernel/sys_ni.c                        | 2 ++
>  4 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


