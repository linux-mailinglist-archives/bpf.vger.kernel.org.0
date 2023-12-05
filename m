Return-Path: <bpf+bounces-16719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 435AD804D48
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 10:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745A01C20B47
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 09:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7363DB95;
	Tue,  5 Dec 2023 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="oIqpz0ck";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="XzSMYI0b"
X-Original-To: bpf@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBA511F;
	Tue,  5 Dec 2023 01:11:26 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
	id A4DF8C009; Tue,  5 Dec 2023 10:11:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701767484; bh=3iZ63APZbX61CIoo6gLzcv9i84+2PmzaZ9wPzVma8C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIqpz0ckW2yM5dz1Eb84uzefLbmlslS3T8HBWGHYwytNSfBw7uX72y60wtA5R4F/e
	 QiiYfCYVBU8ClgdWICRtFiDIaZtkuMNq4An4reGDHCNCrSK8h7XzwDx17gCe8GGbXU
	 vMUNhKCTBHQK2Q2ofpRlmTj/pFDSVR2fXS6BaLEgJ75ftPdjFoo0mMq6SAVRyMiRIG
	 uuUT7xHZVU2YZfaQAe34CRnTSNq5CMt9nSkhJL9uLjWvXJrdwDwZszF1Tk3v5wAktJ
	 dBq99DGdKt0MTniutgIGt7JBaZegTrGXMB3WXc3FzkKRkn1GsoEjbbpJ0Eq5QX7ZnS
	 BTX1zRae9D/ZQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 86018C009;
	Tue,  5 Dec 2023 10:11:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1701767483; bh=3iZ63APZbX61CIoo6gLzcv9i84+2PmzaZ9wPzVma8C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XzSMYI0bof0n+WYjxYrYL6gOwmwkBPBUDi4iIqhYEJhiPNvvplUQbz6BGjUof3ZTJ
	 40TKfb9qqi0LqG2SagX6rRgOUOUfLxUMqyViDSBtDOfTWy2TEFoTo5/w2x8rOHDiqE
	 zmZJMfj2DCeVsbeJip84/EAXDm7sPkAVmaxHLehc76b7CQM702UxxkRm3pRzv4aRBQ
	 LmF5zKHegx/GHRhGjwU4pdwnWNwDUZoblJiCMuuqc5Zh7JyR1dkys/twxRtZkx7Hwa
	 T7fToNgHSZDwyCSuYBrhLfLHJ92nftiJFKEqtLQgR4npu+vMIeQ0WgVWOvowNo6W3W
	 OzKv2QL1nHKBg==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 27fad260;
	Tue, 5 Dec 2023 09:11:17 +0000 (UTC)
Date: Tue, 5 Dec 2023 18:11:02 +0900
From: asmadeus@codewreck.org
To: JP Kobryn <inwardvessel@gmail.com>
Cc: ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, v9fs@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] 9p: prevent read overrun in protocol dump tracepoint
Message-ID: <ZW7pJvNLtObyglZW@codewreck.org>
References: <20231204202321.22730-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231204202321.22730-1-inwardvessel@gmail.com>

JP Kobryn wrote on Mon, Dec 04, 2023 at 12:23:20PM -0800:
> An out of bounds read can occur within the tracepoint 9p_protocol_dump. In
> the fast assign, there is a memcpy that uses a constant size of 32 (macro
> named P9_PROTO_DUMP_SZ). When the copy is invoked, the source buffer is not
> guaranteed match this size.  It was found that in some cases the source
> buffer size is less than 32, resulting in a read that overruns.
> 
> The size of the source buffer seems to be known at the time of the
> tracepoint being invoked. The allocations happen within p9_fcall_init(),
> where the capacity field is set to the allocated size of the payload
> buffer. This patch tries to fix the overrun by changing the fixed array to
> a dynamically sized array and using the minimum of the capacity value or
> P9_PROTO_DUMP_SZ as its length. The trace log statement is adjusted to
> account for this. Note that the trace log no longer splits the payload on
> the first 16 bytes. The full payload is now logged to a single line.
> 
> To repro the orignal problem, operations to a plan 9 managed resource can
> be used. The simplest approach might just be mounting a shared filesystem
> (between host and guest vm) using the plan 9 protocol while the tracepoint
> is enabled.
> 
> mount -t 9p -o trans=virtio <mount_tag> <mount_path>
> 
> The bpftrace program below can be used to show the out of bounds read.
> Note that a recent version of bpftrace is needed for the raw tracepoint
> support. The script was tested using v0.19.0.
> 
> /* from include/net/9p/9p.h */
> struct p9_fcall {
>     u32 size;
>     u8 id;
>     u16 tag;
>     size_t offset;
>     size_t capacity;
>     struct kmem_cache *cache;
>     u8 *sdata;
>     bool zc;
> };
> 
> tracepoint:9p:9p_protocol_dump
> {
>     /* out of bounds read can happen when this tracepoint is enabled */
> }
> 
> rawtracepoint:9p_protocol_dump
> {
>     $pdu = (struct p9_fcall *)arg1;
>     $dump_sz = (uint64)32;
> 
>     if ($dump_sz > $pdu->capacity) {
>         printf("reading %zu bytes from src buffer of %zu bytes\n",
>             $dump_sz, $pdu->capacity);
>     }
> }
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Thanks, I've updated the patch locally; will push to -next after testing
later tonight and to Linus next week.

-- 
Dominique Martinet | Asmadeus

