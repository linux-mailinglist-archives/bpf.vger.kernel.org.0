Return-Path: <bpf+bounces-463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8053B701452
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 06:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366AE281C43
	for <lists+bpf@lfdr.de>; Sat, 13 May 2023 04:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B146EED2;
	Sat, 13 May 2023 04:18:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F70DEC0
	for <bpf@vger.kernel.org>; Sat, 13 May 2023 04:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97846C433EF;
	Sat, 13 May 2023 04:17:59 +0000 (UTC)
Date: Sat, 13 May 2023 00:17:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yonghong Song <yhs@meta.com>
Cc: Ze Gao <zegao2021@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, Song Liu
 <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ze Gao <zegao@tencent.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to
 avoid recursive trap
Message-ID: <20230513001757.75ae0d1b@rorschach.local.home>
In-Reply-To: <ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
References: <20230510122045.2259-1-zegao@tencent.com>
	<6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
	<ZFvUH+p0ebcgnwEg@krava>
	<CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
	<ee28e791-b3ab-3dfd-161b-4e7ec055c6ff@meta.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 May 2023 07:29:02 -0700
Yonghong Song <yhs@meta.com> wrote:

> A fprobe_blacklist might make sense indeed as fprobe and kprobe are 
> quite different... Thanks for working on this.

Hmm, I think I see the problem:

fprobe_kprobe_handler() {
   kprobe_busy_begin() {
      preempt_disable() {
         preempt_count_add() {  <-- trace
            fprobe_kprobe_handler() {
		[ wash, rinse, repeat, CRASH!!! ]

Either the kprobe_busy_begin() needs to use preempt_disable_notrace()
versions, or fprobe_kprobe_handle() needs a
ftrace_test_recursion_trylock() call.

-- Steve

