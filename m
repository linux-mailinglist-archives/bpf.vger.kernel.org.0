Return-Path: <bpf+bounces-73367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E11C2D8A8
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 18:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E760F1896812
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B980D3164B7;
	Mon,  3 Nov 2025 17:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6Q2cDnf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E432F3C1D;
	Mon,  3 Nov 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192416; cv=none; b=palrL7wu05x1+T4HaPipwkX35lgYQR09dSpXM1+hUXg0TnOx+N/FHkYMVb663Xzmlvx9iaWafYXR4gbQeOswnNjGHUBPBf8CF+Q3yq4zKcdIufMG6s3uuMh55x94LJum/NtaZj5/F+opd0L2Nt4AA2DyjPKRhPHOAMsAt6uOyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192416; c=relaxed/simple;
	bh=BlrU0595IFEy4eoPWOwgKhxI0Rau/vpyYKgc5M3nQj8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FHqtFP7DC5HCbiwF0YADB/8sNRPHYJ9LWv2Gof1gauHAXLtlYjlfCpgoC3WnokXRb/2jSx5qhG55sPpA6DgjYRIcRbjYx9tmEKGR1u5VBbmLr/oIJ5l2FEA9b8Qfv5IWsfE6kaHmNermFjlbZ3iZsSAP6tr1tBa5NdPqjDUfL7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6Q2cDnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21643C116D0;
	Mon,  3 Nov 2025 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192415;
	bh=BlrU0595IFEy4eoPWOwgKhxI0Rau/vpyYKgc5M3nQj8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=G6Q2cDnf8cZqXV/BFv8p5DthwALquI9nfrhcR61zonsl70yDByne9cWt7h4DbFDQs
	 ifDbKDTcj5fumB+VcHTBaiQjK04W5bZ9mprhj9qvV7f0NcAsKwF2hmp49mRRRuaRQ5
	 uDZWp2fL2h5Jp7y22OHCstOIZoQIBPK5fuj/TzNXDzomxcDagTZx9HkmxKAO1/t5Os
	 IGOTZf2AYX9onJuvPz0KGcfyeUgE6cCuJeCFiajQHqplE5/nZVJ8x1Y8B285K1wwJP
	 muEqcuZu/viC6yKH/8WX5YoKIGp5z/SOyuTFxwcykwZ6XKbDJGsuTs4utOyoz6rXqH
	 56lbwjwbs9fog==
From: Namhyung Kim <namhyung@kernel.org>
To: alexander.shishkin@linux.intel.com, peterz@infradead.org, 
 irogers@google.com, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Shuai Xue <xueshuai@linux.alibaba.com>
Cc: mingo@redhat.com, baolin.wang@linux.alibaba.com, acme@kernel.org, 
 mark.rutland@arm.com, jolsa@kernel.org, adrian.hunter@intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nathan@kernel.org, bpf@vger.kernel.org
In-Reply-To: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
References: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
Subject: Re: [PATCH] perf record: skip synthesize event when open evsel
 failed
Message-Id: <176219241402.1981113.8862807701851257330.b4-ty@kernel.org>
Date: Mon, 03 Nov 2025 09:53:34 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 23 Oct 2025 09:50:43 +0800, Shuai Xue wrote:
> When using perf record with the `--overwrite` option, a segmentation fault
> occurs if an event fails to open. For example:
> 
>   perf record -e cycles-ct -F 1000 -a --overwrite
>   Error:
>   cycles-ct:H: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
>   perf: Segmentation fault
>       #0 0x6466b6 in dump_stack debug.c:366
>       #1 0x646729 in sighandler_dump_stack debug.c:378
>       #2 0x453fd1 in sigsegv_handler builtin-record.c:722
>       #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
>       #4 0x6c5671 in __perf_event__synthesize_id_index synthetic-events.c:1862
>       #5 0x6c5ac0 in perf_event__synthesize_id_index synthetic-events.c:1943
>       #6 0x458090 in record__synthesize builtin-record.c:2075
>       #7 0x45a85a in __cmd_record builtin-record.c:2888
>       #8 0x45deb6 in cmd_record builtin-record.c:4374
>       #9 0x4e5e33 in run_builtin perf.c:349
>       #10 0x4e60bf in handle_internal_command perf.c:401
>       #11 0x4e6215 in run_argv perf.c:448
>       #12 0x4e653a in main perf.c:555
>       #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3ea72]
>       #14 0x43a3ee in _start ??:0
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



