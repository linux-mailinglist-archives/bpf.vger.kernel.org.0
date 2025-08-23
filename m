Return-Path: <bpf+bounces-66356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C396BB32719
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 08:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA591C26F1F
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 06:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1642222D2;
	Sat, 23 Aug 2025 06:49:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A91821A457;
	Sat, 23 Aug 2025 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755931753; cv=none; b=L11/OYc3vLDnRX2ONr40VkL6q02bTRMKAweFwYEuh/wAhzbEPmPxxFRUcBIZODB/FCem4SbOhDrL53FN0/nlMrF7y21TcRuE/pYObzCh7JY1kHMKnKaXhbnJRj8XUv75Hqmc3E2LCgXCPzZTgNwddGvydqHRLQIDvmhWO+cXyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755931753; c=relaxed/simple;
	bh=JuPmb3uHuzsOvpA/Et1mzggjy+NHYvPepLmklmkPxAw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=XRMQeuV0W7v3IvZaY4AaGFTlMl6zRIL3CrFLD+cMlsLTjJ9bCSwCdl/eS+r2J6pYC7y5gs6gVcv+De4ri+/1fQi0fzsBz3rJUt8ezte5XXvUr1giLbzU8ZGIp+ghdKo431Rg25Sc03QFTs9eP7fMGuHwnjIuLXe5d5mfqDUvKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 13BC0340D54;
	Sat, 23 Aug 2025 06:49:06 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: irogers@google.com, amadio@gentoo.org
Cc: acme@kernel.org,adityag@linux.ibm.com,adrian.hunter@intel.com,ak@linux.intel.com,alexander.shishkin@linux.intel.com,atrajeev@linux.vnet.ibm.com,bpf@vger.kernel.org,chaitanyas.prakash@arm.com,changbin.du@huawei.com,charlie@rivosinc.com,dvyukov@google.com,james.clark@linaro.org,jolsa@kernel.org,justinstitt@google.com,kan.liang@linux.intel.com,kjain@linux.ibm.com,lihuafei1@huawei.com,linux-kernel@vger.kernel.org,linux-perf-users@vger.kernel.org,llvm@lists.linux.dev,mark.rutland@arm.com,mhiramat@kernel.org,mingo@redhat.com,morbo@google.com,namhyung@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,peterz@infradead.org,sesse@google.com,song@kernel.org
Subject: Re: [PATCH v5 00/19] Support dynamic opening of capstone/llvm
 remove BUILD_NONDISTRO
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Organization: Gentoo
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Sat, 23 Aug 2025 07:49:04 +0100
Message-ID: <87ldnacz33.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> As this has been opt-in for nearly 2 years, commit dd317df07207 ("perf build: Make binutil libraries opt
> in"), remove the code to simplify the code base.

I don't think this is a reason to remove it by itself. We've been
enabling it in Gentoo and happily using it.

Anyway, my main concern (though I have a few) is that annotate support
will be lacking. A few months ago, objdump was the only way to get
source line support [0]. Is that still the case?

[0] https://lore.kernel.org/all/Z_S_JB_L_t9viciV@google.com/

