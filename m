Return-Path: <bpf+bounces-55909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A49A8903D
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 01:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EC93B299E
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 23:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA91F4CB8;
	Mon, 14 Apr 2025 23:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nsUv0JJA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398271A29A
	for <bpf@vger.kernel.org>; Mon, 14 Apr 2025 23:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744674586; cv=none; b=HcDaAXe2jakjQUMKOFUlRvzxLfw1RR1TUDYKWMKD/EOVp6ttYFhPoM0F0Yg1Mbi2mc9H+lrdhXBhH4y+qwkANK4/EXivmV4pxQ1WAAtQzB9RUQB8VF6wAl1vcJ1osrpmo8HChj9JsKfO+vBpSZ6QGry0uMUSpsVULuVdPJALt7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744674586; c=relaxed/simple;
	bh=tdJcPXm9L2RK+q8v+nEOrZPSnVuRaQIsUl0JE0nalzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYrqW4Ntnj2lw9ayxWI400h+eSzny7Y1COlp8Ci45sPepL6Y8AD8Nux7+XPUo708V1huYR6grPMIE9nCkP+ej3jFyWXuvXnTEHtsaUFvrheEeGbD4xP+SXO/nm/GEt04WgnH/NtgVWr6cCyk9CKGVQLHeRNPJtzJhWKEx/0wNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nsUv0JJA; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744674586; x=1776210586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ONk7lnSTyojOR9En0v6L9VLQvBOYVVnFTjpseWT/b4k=;
  b=nsUv0JJAzGTfXZxRoIA43VM1IWgYDZ9UcwM7kG3qVoG8Dr+2/QWqwr3G
   M3DR4KJdPcrj9lmUo7XTfiTtmsbAdNEEXhZz79vQ7U17qqDSSMg+m2jXb
   h5VLR+UzLoHu1D7up4jEXeq8CRZKP9cP2KSoyYsWsETQ5qfqmaH+1epBi
   s=;
X-IronPort-AV: E=Sophos;i="6.15,213,1739836800"; 
   d="scan'208";a="83655881"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 23:49:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:40573]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.63:2525] with esmtp (Farcaster)
 id 81196f03-c690-420e-828e-33cfcb34916b; Mon, 14 Apr 2025 23:49:37 +0000 (UTC)
X-Farcaster-Flow-ID: 81196f03-c690-420e-828e-33cfcb34916b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 23:49:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 23:49:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <alexei.starovoitov@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bjorn@kernel.org>,
	<bpf@vger.kernel.org>, <christophe.leroy@csgroup.eu>, <daniel@iogearbox.net>,
	<davem@davemloft.net>, <gor@linux.ibm.com>, <hbathini@linux.ibm.com>,
	<hca@linux.ibm.com>, <iii@linux.ibm.com>, <johan.almbladh@anyfinetworks.com>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux@armlinux.org.uk>,
	<list+bpf@vahedi.org>, <luke.r.nels@gmail.com>, <paulburton@kernel.org>,
	<puranjay@kernel.org>, <syzkaller@googlegroups.com>, <udknight@gmail.com>,
	<xi.wang@gmail.com>, <xukuohai@huaweicloud.com>, <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v1 bpf 2/2] bpf: Set -ENOMEM to err in bpf_int_jit_compile().
Date: Mon, 14 Apr 2025 16:49:01 -0700
Message-ID: <20250414234924.86039-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAADnVQJ6NKjhWbr=ya4=R7HaWyyiFneLLisByW3JopfQQYLrpg@mail.gmail.com>
References: <CAADnVQJ6NKjhWbr=ya4=R7HaWyyiFneLLisByW3JopfQQYLrpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Apr 2025 15:32:21 -0700
[...]
> >  bpf_int_jit_compile+0x1292/0x18b0
> >  bpf_prog_select_runtime+0x439/0x780
> >
> > Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to enable jits")
> 
> The Fixes tag looks wrong and I suspect you root caused it incorrectly

I chose this one as it added WARN_ON_ONCE(), but if we
go back to the first invocation of bpf_int_jit_compile(),
the tag will be

Fixes: 8f577cadf718 ("seccomp: JIT compile seccomp filter")
Fixes: 622582786c9e ("net: filter: x86: internal BPF JIT")

?

FWIW, syzkaller reported the same splat in the seccomp path too.


> and the "fix" adds a ton of churn for no good reason.
> 
> If CONFIG_BPF_JIT_ALWAYS_ON=y and JIT fails for whatever reason
> the following should have executed:
>                 fp = bpf_int_jit_compile(fp);
>                 bpf_prog_jit_attempt_done(fp);
>                 if (!fp->jited && jit_needed) {
>                         *err = -ENOTSUPP;
>                         return fp;
>                 }
> 
> so the prog won't load and won't execute.
> 
> jit_needed will be false if CONFIG_BPF_JIT_ALWAYS_ON=n
> and if fp->jit_requested == true then ret0_warn may indeed stay.
> 
> Then the fix is probably just this hunk:
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ba6b6118cf50..662c1bd9937f 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2493,7 +2493,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct
> bpf_prog *fp, int *err)
> 
>                 fp = bpf_int_jit_compile(fp);
>                 bpf_prog_jit_attempt_done(fp);
> -               if (!fp->jited && jit_needed) {
> +               if (!fp->jited && (fp->jit_requested || jit_needed)) {
> 
> or maybe this instead:
> -       bool jit_needed = false;
> +       bool jit_needed = fp->jit_requested;

This looks much cleaner, will use this in v2.

Thanks!

