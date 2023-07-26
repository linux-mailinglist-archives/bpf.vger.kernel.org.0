Return-Path: <bpf+bounces-6023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FEE764249
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 00:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C1E281FB6
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 22:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA2BA940;
	Wed, 26 Jul 2023 22:53:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A31BEF3
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 22:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0C6C433C7;
	Wed, 26 Jul 2023 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690412027;
	bh=Gc0MdxE9TJLVJnxGVdhAqK+Fa1GdL+sEgIBIAagN3WI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oEBJXlrReZWTXlTFcPvCxDjoBxAqHNi8Z04tDXBU62cESYZGcTVYn7pVunAmoPiVE
	 kY8YsvtXo3hJNgxD5EDAZQW5D1EL3fdBPccEpMWpdohKA71/dPySkAEeEIAQ3rjxul
	 vqrLzxe+kCSaA5Z/5r2Y01XBZkGWTLIenin/9+5sB/K+o5U3wrNhm8HWaETVQ2qRnY
	 BTUHqs0HjJZS8NpXNMDCymr6Z1hY3UugpxeLt1FqxfKxu2lb0v6UeRgnrv4bf361Xf
	 rSUUEY4f9zTTXpfUiqNL/DQQzBeKkJC3RzV65LBNXARVru0PAlIr/caAX4cJwQV4g2
	 9SKNEy6XWwU6A==
Date: Thu, 27 Jul 2023 07:53:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v3 5/9] tracing/probes: Support BTF field access from
 $retval
Message-Id: <20230727075342.43f600a1850810f6e1dd6c2e@kernel.org>
In-Reply-To: <169037644255.607919.6218637643155663128.stgit@devnote2>
References: <169037639315.607919.2613476171148037242.stgit@devnote2>
	<169037644255.607919.6218637643155663128.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 22:00:42 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:


>  
> -static const struct btf_param *find_btf_func_param(const char *funcname, s32 *nr,
> -						   struct btf **btf_p, bool tracepoint)
> +static int query_btf_context(struct traceprobe_parse_context *ctx)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);

Oops, kernel test bot reported this is wrong. I have to remove ERR_PTR().

Thanks,

>  }

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

