Return-Path: <bpf+bounces-2402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7577F72C930
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3039E281039
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20861C750;
	Mon, 12 Jun 2023 15:02:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF1EAD38
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C75C433EF;
	Mon, 12 Jun 2023 15:02:23 +0000 (UTC)
Date: Mon, 12 Jun 2023 11:02:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yonghong Song <yhs@meta.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Andrii Nakryiko <andrii@kernel.org>,
 lkml <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jackie
 Liu <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230612110222.50c254f3@gandalf.local.home>
In-Reply-To: <d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
References: <20230611130029.1202298-1-jolsa@kernel.org>
	<53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
	<20230611225407.3e9b8ad2@gandalf.local.home>
	<20230611225754.01350a50@gandalf.local.home>
	<d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jun 2023 07:49:53 -0700
Yonghong Song <yhs@meta.com> wrote:

> I am actually interested in how available_filter_functions_addrs
> will be used. For example, bpf_program__attach_kprobe_multi_opts()
> can already take addresses from kallsyms. How to use
> available_filter_functions_addrs to facilitate kprobe_multi?
> Do we need to change kernel APIs? It would be great at least we
> got a RFC patch to answer these questions.

I agree, having that information would also be useful to me.

Jiri? Andrii?

-- Steve

