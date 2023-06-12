Return-Path: <bpf+bounces-2461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BB172D4F6
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 01:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1691C20BC4
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 23:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32415101D9;
	Mon, 12 Jun 2023 23:32:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7306BE66
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 23:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D421C433D2;
	Mon, 12 Jun 2023 23:32:01 +0000 (UTC)
Date: Mon, 12 Jun 2023 19:31:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Yonghong Song <yhs@meta.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrii Nakryiko <andrii@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Jackie Liu
 <liu.yun@linux.dev>
Subject: Re: [PATCHv2] ftrace: Show all functions with addresses in
 available_filter_functions_addrs
Message-ID: <20230612193159.2b3d81ff@gandalf.local.home>
In-Reply-To: <CAEf4Bza+n3sTUuuseZA19PQG2GN6bLezu_gdUqU6mnHfPA77xg@mail.gmail.com>
References: <20230611130029.1202298-1-jolsa@kernel.org>
	<53a11f31-256d-e7bc-eca5-597571076dc5@meta.com>
	<20230611225407.3e9b8ad2@gandalf.local.home>
	<20230611225754.01350a50@gandalf.local.home>
	<d5ffd64c-65b7-e28c-b8ee-0d2ff9dcd78b@meta.com>
	<20230612110222.50c254f3@gandalf.local.home>
	<ZId/UL/iujOdgel+@krava>
	<CAEf4Bza+n3sTUuuseZA19PQG2GN6bLezu_gdUqU6mnHfPA77xg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Jun 2023 16:28:49 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:


> If Steven would be ok with it, can we land this change through the
> bpf-next tree? Then we can have BPF selftest added in the same patch
> set that parses a new file and uses bpf_program__attach_kprobe_multi()
> to attach using explicit addresses.
> 
> This should make it clear to everyone how this is meant to be used and
> will be a good test that everything works end-to-end.
> 

This touches some of the code I'm working with, so I rather have it be in
my tree.

-- Steve

