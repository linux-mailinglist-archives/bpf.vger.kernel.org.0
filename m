Return-Path: <bpf+bounces-21203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1C6849415
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 07:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B9D1F23D65
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 06:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4437CD26D;
	Mon,  5 Feb 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BV36VqZ4"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520810A0F
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116283; cv=none; b=L2GJUORvrQpSH8oD2iSjPTZtYeHONgfqU7Y+p48IjFMq+UIl3XmrHC1+1WNs6PzzEmIu1qQtLuQBqs1Nofg3lxgz/zYFWu6ouJstnbK42ro7D1XtODHhWF+20QKU/byA1g8HbdG2UTkUimVEuTpelIL3e6oPBI1jiMXnBzJchZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116283; c=relaxed/simple;
	bh=a2id2WyiM9zMsxzoO0XSIuDgw9Q3Is5nNopl7phwFxg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FkWwz0TdhKXa0PCq4DMjg1E8Fc41gUL+cKTUZ1JzpnIBrS5KcGjtiNvQMbmh/tc7tP4NHXb0xjt+voEPgVkFa6GEghqFZEnqkTd7gcw6G1Fr2kZrsw5FC/UyctKAQDpoDdgW8s3SoOZdFLgx4muhG5LdINun3F+mgYzlm/QUY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BV36VqZ4; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <32bde0f0-1881-46c9-931a-673be566c61d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707116279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uKpg5ZwxuYkdQBcsfSoX/GXGaC2E+symdv4wpTzu8F4=;
	b=BV36VqZ4Rh5MldI1+/xbLaKH7PYXhdX3lE0NMxpH48W8jVhEHVAyIvRoUwF4vpnZc7+ZCE
	wJ1BpZTSBkZgenUgPDBwP26Ae0AIxhQp9OeYC7jmT+HjD5Ad4XnpDR+wnl4Etukqo7DsC7
	au8Ns/LarbBmDG8K/AYv8MUqy2FAU0w=
Date: Sun, 4 Feb 2024 22:57:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-GB
To: bpf <bpf@vger.kernel.org>, Eddy Z <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
Subject: FYI: bpf selftest verif_scale_strobemeta_subprogs failed with latest
 llvm19
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

The selftest verif_scale_strobemeta_subprogs failed with latest llvm19 compiler.
For example,

   $ ./test_progs -n 498
   ...
   libbpf: prog 'on_event': BPF program load failed: Permission denied
   libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
   combined stack size of 4 calls is 544. Too large
   verification time 1417195 usec
   stack depth 24+440+0+32
   processed 53561 insns (limit 1000000) max_states_per_insn 18 total_states 1457 peak_states 308 mark_read 146
   -- END PROG LOAD LOG --
   libbpf: prog 'on_event': failed to load: -13
   libbpf: failed to load object 'strobemeta_subprogs.bpf.o'
   scale_test:FAIL:expect_success unexpected error: -13 (errno 13)
   #498     verif_scale_strobemeta_subprogs:FAIL
   Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

The maximum stack size exceeded 512 bytes and caused verification failure.

The following llvm patch caused the above regression:
   https://github.com/llvm/llvm-project/pull/68882

I will do some analysis and try to find a solution to resolve this failure.

Thanks,

Yonghong


