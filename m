Return-Path: <bpf+bounces-76859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9043CC7677
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 12:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 018403066DAF
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33EC31280E;
	Wed, 17 Dec 2025 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tGpgVuJZ"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D4281368
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765971755; cv=none; b=gpH77XPdTvpC6GgcpZHPA5Qbn8YcSILcM9eGoVoddnB80Z4UItCJcGYC067edEhDB6vaaVuuTN5TunN4J1KrolTi0EMkkd1wW27DkeiD9OQu/O7jqvI67v/bSXIyQeVjykOAvQbYKJ+MvN49eajFYH+r4ZampCKPCgbftBH3DkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765971755; c=relaxed/simple;
	bh=asjqG5ky9qjNfDNBeoJBS/H665g69eYrWS5a+LRbBP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRDMWDxlUkAfCTeyTjuYl8TVCvc/bRt6ux6pWBOuppTvM8bsZ/vfUPFMwx/ySTzh6zM9fDxJPpJfKhTtmLIP7PhOgVeElsWxrPXBMxgOgIZ4F1FNjgjeN2diBuCJyExWcz29YRioaki8wVBwKXDlF0LfHQpb+WsUmsh2s6X9djU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tGpgVuJZ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765971741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFzo+jyO3jV8hpTcOAiXTm+sJpwPvrdDGxKAjY2Y8IU=;
	b=tGpgVuJZ8PR3inKSg0pN+RxEka5C/4dExLdDhHYxtOSf+9BMd6FQVFtLA63EeCByV3r9x2
	1McngJ9tTLYSDCgcm3N5e+Xg5h5m5dSmkeyaBm9/frInDeHlGmjbv2hXUpMBeU42WHIihg
	gzCAKzsaIMOZU+oHbTzk/BKhT9MNroc=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, ast@kernel.org, andrii@kernel.org,
 bot+bpf-ci@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v4 8/9] selftests/bpf: add testcases for tracing session
Date: Wed, 17 Dec 2025 19:42:06 +0800
Message-ID: <5069094.31r3eYUQgx@7940hx>
In-Reply-To:
 <e2567121e26195cb0dc4d9285f7269c377a4fb26c0aede0ad8ec112d7a2c98f0@mail.kernel.org>
References:
 <20251217095445.218428-9-dongml2@chinatelecom.cn>
 <e2567121e26195cb0dc4d9285f7269c377a4fb26c0aede0ad8ec112d7a2c98f0@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/17 18:24 bot+bpf-ci@kernel.org write:
> > diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
> > new file mode 100644
> > index 000000000000..f7c96ef1c7a9
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/fsession_test.c
> > @@ -0,0 +1,192 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 ChinaTelecom */
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +char _license[] SEC("license") = "GPL";
> 
> [ ... ]
> 
> > +__u64 test8_entry_result = 0;
> > +__u64 test8_exit_result = 0;
> > +SEC("fsession/bpf_fentry_test1")
> > +int BPF_PROG(test8, int a)
> > +{
> > +	__u64 addr = bpf_get_func_ip(ctx);
> > +
> > +	if (bpf_fsession_is_return(ctx))
> > +		test8_exit_result = (const void *) addr == &bpf_fentry_test1;
> > +	else
> > +		test8_entry_result = (const void *) addr == &bpf_fentry_test1;
> > +	return 0;
> > +}
> 
> In test8, the code uses &bpf_fentry_test1 without declaring it. Looking at
> similar tests like kprobe_multi.c and kprobe_multi_session.c, they include:
> 
>     extern const void bpf_fentry_test1 __ksym;
> 
> at the top of the file before taking the address of kernel symbols.
> Without the __ksym declaration, does the comparison work correctly, or
> would this cause the test to fail during compilation or at runtime?

It seems that it is generated into vmlinux.h, and that's why it works
well during compilation and runtime.

Thanks!
Menglong Dong

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20299185010
> 





