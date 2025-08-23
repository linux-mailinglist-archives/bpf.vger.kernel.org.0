Return-Path: <bpf+bounces-66360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CCFB32724
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 08:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71742AC44DD
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3F2236E8;
	Sat, 23 Aug 2025 06:52:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CC672623;
	Sat, 23 Aug 2025 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755931933; cv=none; b=Ad0+PwPS0s32Tn87OVfhDHBJ8C8H+WVCJ6etvZ0kU4LG7o14YQtmJnpPMpBMhcZ5g2dxV6WregT9i0vCRqCwBcDwrMu2+0yoJ8crqHReHHfBL1XjTOFuFuHS3g4vl+LshP9zSmArNDwlk0WCqcgqmB4aoex3nCxVfpsx7h0TGCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755931933; c=relaxed/simple;
	bh=WWjVB3yFJIdS6R9JonpnjV7Az6tTIUBsiyXY8fEo234=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=oaA2lXsHSbqJE5cFeWle8Jba7gdR+xswHioWYWp+BR1RIscieOYibBtv5+EkKRS32CRzzaAWwZ0gIvrB8WxEL5AEDVoC+UxM9XLi26JaNpW0B4boHl+esoinkyzB5cG+pqOF2qdaxFQJqnQVwh4Bz8sNdUDeJIBvpatnhL4K3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 068BD340D7F;
	Sat, 23 Aug 2025 06:52:05 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: sam@gentoo.org
Cc: acme@kernel.org,adityag@linux.ibm.com,adrian.hunter@intel.com,ak@linux.intel.com,alexander.shishkin@linux.intel.com,amadio@gentoo.org,atrajeev@linux.vnet.ibm.com,bpf@vger.kernel.org,chaitanyas.prakash@arm.com,changbin.du@huawei.com,charlie@rivosinc.com,dvyukov@google.com,irogers@google.com,james.clark@linaro.org,jolsa@kernel.org,justinstitt@google.com,kan.liang@linux.intel.com,kjain@linux.ibm.com,lihuafei1@huawei.com,linux-kernel@vger.kernel.org,linux-perf-users@vger.kernel.org,llvm@lists.linux.dev,mark.rutland@arm.com,mhiramat@kernel.org,mingo@redhat.com,morbo@google.com,namhyung@kernel.org,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,peterz@infradead.org,sesse@google.com,song@kernel.org
Subject: Re: [PATCH v5 00/19] Support dynamic opening of capstone/llvm
 remove BUILD_NONDISTRO
In-Reply-To: <87ldnacz33.fsf@gentoo.org>
Organization: Gentoo
User-Agent: mu4e 1.12.12; emacs 31.0.50
Date: Sat, 23 Aug 2025 07:52:03 +0100
Message-ID: <87cy8mcyy4.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> A few months ago, objdump was the only way to get
> source line support [0]. Is that still the case?

... or is this perhaps handled by "[PATCH v5 18/19] perf srcline:
Fallback between addr2line implementations", in which case, shouldn't
that really land first so people can try the LLVM impl and use the
binutils one if it fails?

