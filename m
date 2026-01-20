Return-Path: <bpf+bounces-79526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53820D3BCF7
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 02:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5253300B340
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 01:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1FB23E356;
	Tue, 20 Jan 2026 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BMJJZxKf"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC9176FB1
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768872964; cv=none; b=NnelH2m6Bsuqf/mTlHrVv1YSVc8gLTlHQKYj1PKlMQIn8vhSaKZWHPrTF7s3nw6QLzHtZVsBAqI28KM3eWgswJuFQADrQDMcm2uJbGaJTWhnPIZg7DQpRXCWHwNRNbFIb3Cf5pTgMqwmJiAZU6AQhs78CtjjJ80PW3ZitRJZbiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768872964; c=relaxed/simple;
	bh=fVwBsl0hYDzuuniqthT4W4rcID34sNMzgRBJVGiZKfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgeLCeQUITeISfJbTbDedck7cknBj1jTok5Km2MqPCNpxYOhHwfXaxCyFve0i1ieP9LkZrDIK1dK57hKXKMs3yCO/JmqefT+ctTaRm3Xn5saUBaGRH4AmnyCZKi6tNIEVEOWm4y12/Ual9nw130qzqhZO2CuPnHl4ChOdlfFgko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BMJJZxKf; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768872959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lywwtfd66k3pVfQyQhQhvb3xHOcEh0uBDjwtJzlgHMc=;
	b=BMJJZxKflqFLv2oM1bFP5crwtlMPDM0L0s5c15nK42Wm3EKi4t2NrST0rJqqSwqXIPjZC3
	LhThKyll0KyclHNC4RmmRtQNaylciu7zeM/cpeAaZ/DaZmLVyJ3pJ+cxyBKzAgEcdWj8eN
	Pu87VTr/MQaXuW3FG/zyY6A7d9Idgw4=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v5 2/2] selftests/bpf: test the jited inline of
 bpf_get_current_task
Date: Tue, 20 Jan 2026 09:27:46 +0800
Message-ID: <5212176.31r3eYUQgx@7950hx>
In-Reply-To: <0a277a7ff97395803d114a0ea74a5cab9fd75237.camel@gmail.com>
References:
 <20260119070246.249499-1-dongml2@chinatelecom.cn>
 <20260119070246.249499-3-dongml2@chinatelecom.cn>
 <0a277a7ff97395803d114a0ea74a5cab9fd75237.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/20 04:37, Eduard Zingerman wrote:
> On Mon, 2026-01-19 at 15:02 +0800, Menglong Dong wrote:
> > Add the testcase for the jited inline of bpf_get_current_task().
> > 
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  .../selftests/bpf/prog_tests/verifier.c       |  2 ++
> >  .../selftests/bpf/progs/verifier_jit_inline.c | 35 +++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > index 38c5ba70100c..2ae7b096bd64 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > @@ -111,6 +111,7 @@
> >  #include "verifier_xdp_direct_packet_access.skel.h"
> >  #include "verifier_bits_iter.skel.h"
> >  #include "verifier_lsm.skel.h"
> > +#include "verifier_jit_inline.skel.h"
> >  #include "irq.skel.h"
> >  
> >  #define MAX_ENTRIES 11
> > @@ -253,6 +254,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
> >  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
> >  void test_irq(void)			      { RUN(irq); }
> >  void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
> > +void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
> >  
> >  static int init_test_val_map(struct bpf_object *obj, char *map_name)
> >  {
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> > new file mode 100644
> > index 000000000000..0938ca1dac87
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> > @@ -0,0 +1,35 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> 
> I don't think this #if is necessary as well as 'dummy_test'.
> test_loader.c:run_subtest() checks current architecture against a mask
> supplied by __arch_* annotations and skips the test for unsupported
> archs.

Yeah, you are right, they are unnecessary.

> 
> > +
> > +SEC("fentry/bpf_fentry_test1")
> > +__description("Jit inline, bpf_get_current_task")
> 
> Nit: please don't use __description() for new tests,
>      it makes "./test_progs -t" tests selection harder.

OK, I'll remove them.

Thanks!
Menglong Dong

> 
> > +__success __retval(0)
> > +__arch_x86_64
> > +__jited("	addq	%gs:{{.*}}, %rax")
> > +__arch_arm64
> > +__jited("	mrs	x7, SP_EL0")
> > +int inline_bpf_get_current_task(void)
> > +{
> > +	bpf_get_current_task();
> > +
> > +	return 0;
> > +}
> > +
> > +#else
> > +
> > +SEC("kprobe")
> > +__description("Jit inline is not supported, use a dummy test")
> > +__success
> > +int dummy_test(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +#endif
> > +
> > +char _license[] SEC("license") = "GPL";
> 
> 





