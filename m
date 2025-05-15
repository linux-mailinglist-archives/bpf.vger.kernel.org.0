Return-Path: <bpf+bounces-58350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94057AB8FA3
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 21:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38804E2D1C
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8B4298CB2;
	Thu, 15 May 2025 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N/8GmiUT"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DA219EA5
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 19:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335880; cv=none; b=sgw3ag53sIyGa0uycbPIU3ZQsqzrYvkDeLKxCrnPaLqGCz46w7rRdBMzcWxyU8w4KPKI6kpTWIO1M0yP0Z7Nqiu8VanQ0cmNH58pyzIgx/PkukMU9JampVjes74fph8dg26IxwTNpQ4/j6SiFWJC6PFz+PKtMYz67zrSuERXOwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335880; c=relaxed/simple;
	bh=2TFP4a/Qyyyjuub6ARU6zQrB5XmPSylzhP7ms0VvTec=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc; b=e9Ki5wWpxtuBeHVpPPi/7XubMd53+DV0HxTG/Vidi/W82Uq69AZogduc7oc69m1CpBe2YNNEg8blvK6tiDc9yO7VRCt0InX+Yv52oajcAHuoo6NC0PUGysQb+GYfFoqF+QA1pn9OQcOVG7lh6V17pIPGx1eKregotZvJtKTHVuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N/8GmiUT; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747335864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3xVcqiJPyPsrTbmfK2bOp+gjw4dxsJLuhhBcDUWNfHE=;
	b=N/8GmiUTbk9sX8xltdIbbU+mKNJ+liSq/cp0LIdoLtuVHg6bwYLfG7R4/6hLjwqlMfYd9C
	b84lVzCCksnINi65Q1VCuLbbX///KEo/s4+SpkIuYGtDV1mhA33pawuFH30OzFW4Gwhs3u
	vKmdoHqephCDU4xGI8ySbQhxDUCYgvk=
Date: Thu, 15 May 2025 19:04:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <4f3768be36e0298be4ceebd4fdd3e96dd4fbdc04@linux.dev>
TLS-Required: No
Subject: [bug?] s390: kernel panic on specification exception: 0006
To: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

Hi everyone.

Stumbled on the following while testing unrelated changes to BPF CI scrip=
ts:

    #353     select_reuseport:OK
    specification exception: 0006 ilc:2 [#1]SMP
    Modules linked in: bpf_testmod(OE) [last unloaded: bpf_test_modorder_=
x(OE)]
    CPU: 0 UID: 0 PID: 108 Comm: new_name Tainted: G           OE       6=
.15.0-rc4-g169491540638-dirty #1 NONE
    Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
    Hardware name: IBM 8561 LT1 400 (KVM/Linux)
    Krnl PSW : 0404e00180000000 000001e43ac595e4 (hrtimer_interrupt+0x4/0=
x2a0)
               R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA=
:3
    Krnl GPRS: 7fffffffffffffff 000001e43ac595e0 00000000fff8f200 000001e=
43c52a0c0
               00000164c50740d8 0000000000000000 0000000000000000 0000000=
000000000
               0000000000000000 0000000000000000 000001643afabe00 0000000=
000000000
               000003ff9fbadf98 000001e43b747550 000001e43ab12774 0000000=
0fffdfe68
    Krnl Code:#000001e43ac595e0: 67756573		mxd	%f7,1395(%r5,%r6)
              >000001e43ac595e4: 743d696e		unknown
               000001e43ac595e8: 73303031		unknown
               000001e43ac595ec: 61652c64		unknown
               000001e43ac595f0: 65627567		unknown
               000001e43ac595f4: 2d74		ddr	%f7,%f4
               000001e43ac595f6: 68726561		ld	%f7,1377(%r2,%r6)
               000001e43ac595fa: 64733d6f		unknown
    Call Trace:
     [<000001e43ac595e4>] hrtimer_interrupt+0x4/0x2a0
     [<000001e43ab128ca>] do_irq_async+0x5a/0x78
     [<000001e43b65f694>] do_ext_irq+0xac/0x168
     [<000001e43b66ae90>] ext_int_handler+0xc8/0xf8
    Last Breaking-Event-Address:
     [<000001e43ab08a9e>] clock_comparator_work+0x2e/0x30
    Kernel panic - not syncing: Fatal exception in interrupt

This is on the current tip of bpf-next (9325d53fe9ad).

Job: https://github.com/kernel-patches/vmtest/actions/runs/15051985809/jo=
b/42309244372
You can download full logs from there.

It only happened once so far, didn't repeat on restart.

