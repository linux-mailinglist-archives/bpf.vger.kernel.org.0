Return-Path: <bpf+bounces-56016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2408A8AC09
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC1919014B2
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 23:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA562D8DAC;
	Tue, 15 Apr 2025 23:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="veEPQ3aG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF712222C5
	for <bpf@vger.kernel.org>; Tue, 15 Apr 2025 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759510; cv=none; b=EYwQdjpwntgRfrOitZ+CZGdl7LvuR8iQKcf8mVpSpGxOhV+P/yfxqN3yKnlDYSbwOSj43hY20YtjdhcG7GY3OS3ytnVJe9iM9mXIRplppcoWOtiZ6KnhNLhRhNt3h9qacMKax5Aqm8cJp932oPMPGzC1Gm2X48kwVJZMcLD9aeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759510; c=relaxed/simple;
	bh=gB4Vvzy/tGL4X4oG6imbQXyOJTe5v04w6lRVA414+1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G51OmWM+125txKA9sTJo9HBPZ0wwXfHzUNN9GnBHZ9sSYVGY04e8bpLUjaloGKFoV6MNQVr68Xen3a4yBMZ6s9U0/L9PYC7x6Vo3idwGBAFLf322o6Y8wFi0yE+wUTLWJMeOnoxSQVh6iC/GuwBRCry+rvjZBv4OaFQ6yVyLWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=veEPQ3aG; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744759509; x=1776295509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hJV7+ohbRlqgNfaXWv9jzO8KlQnyrMvMheyXGPODrp0=;
  b=veEPQ3aGuYwIE+gjISs/XbZ1iMg3FcQ/VErJB1iQEuPwt5oZ8a+Ekkgu
   9h10UfFJuOBzEO8e1iJ1YKi8cN7EFvilZpYV6RY1BJBhLp0GhGrTO+sbp
   wdP/YWkisHXYKDa7ns4LkybGADGAEUWF99DozZzdW5LDDsn5cQJ7Ix+54
   I=;
X-IronPort-AV: E=Sophos;i="6.15,214,1739836800"; 
   d="scan'208";a="816340646"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:25:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:12897]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id f70184db-f366-44a8-b8b0-3554f4d91f5f; Tue, 15 Apr 2025 23:25:01 +0000 (UTC)
X-Farcaster-Flow-ID: f70184db-f366-44a8-b8b0-3554f4d91f5f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 23:25:00 +0000
Received: from 6c7e67bfbae3.amazon.com (10.88.149.87) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 23:24:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <andrii.nakryiko@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bjorn@kernel.org>,
	<bpf@vger.kernel.org>, <christophe.leroy@csgroup.eu>, <daniel@iogearbox.net>,
	<davem@davemloft.net>, <gor@linux.ibm.com>, <hbathini@linux.ibm.com>,
	<hca@linux.ibm.com>, <iii@linux.ibm.com>, <johan.almbladh@anyfinetworks.com>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux@armlinux.org.uk>,
	<list+bpf@vahedi.org>, <luke.r.nels@gmail.com>, <paulburton@kernel.org>,
	<puranjay@kernel.org>, <udknight@gmail.com>, <xi.wang@gmail.com>,
	<xukuohai@huaweicloud.com>, <yangtiezhu@loongson.cn>
Subject: Re: [PATCH v1 bpf 1/2] bpf: Allow bpf_int_jit_compile() to set errno.
Date: Tue, 15 Apr 2025 16:23:25 -0700
Message-ID: <20250415232448.7066-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAEf4BzbjeuMkJZnqL-E4x+mb744=sNWyaFaboKHY-V5ovWhqTQ@mail.gmail.com>
References: <CAEf4BzbjeuMkJZnqL-E4x+mb744=sNWyaFaboKHY-V5ovWhqTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 15 Apr 2025 16:10:42 -0700
> On Mon, Apr 14, 2025 at 2:22 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > There are some failure paths in bpf_int_jit_compile() that are not
> > worth triggering a warning in __bpf_prog_ret0_warn().
> >
> > For example, if we fail to allocate memory in bpf_int_jit_compile(),
> > we should propagate -ENOMEM to userspace instead of attaching
> > __bpf_prog_ret0_warn().
> >
> > Let's pass &err to bpf_int_jit_compile() to propagate errno.
> 
> Is there any reason we are not just returning ERR_PTR() instead of the
> approach in this patch? That seems more canonical within BPF
> subsystem, if we need to return error for pointer-returning functions?

From the comment in __bpf_prog_ret0_warn(), I thought BPF folks wanted
to catch any JIT failure as a warning for syzbot etc, instead of returning
an error to user.  Even it can be done by adding WARN_ON() to the caller
of bpf_int_jit_compile() though.

That's why I only set error in the -ENOMEM paths in patch 2, which is
not a BPF problem at least.

With Alexei's suggestion, we can suppress that case, but as -ENOTSUPP.

What do you think ?

