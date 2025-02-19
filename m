Return-Path: <bpf+bounces-51963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C022A3C389
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 16:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17AA1886F0F
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BB01F460A;
	Wed, 19 Feb 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cd9Mm5MZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A81EFFAB
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978612; cv=none; b=RLdOAwniH+YyaLvg7ORgK/By1xHnIvc1MsocZwdAc/Xlxry8w8+vQ3Vyu5TOaZtRtORJNj1h1sEbphwwcaJ3wmOjrqkYopgL4su9cuJCZpvAjmzwNVx10Oi7io99e5tyNNBoOPTCcN88FP3Z+qmYCmqtEP3X1BNSXu9qxyaWHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978612; c=relaxed/simple;
	bh=/0kmnhcuXSDK/VJa/ZW0gcKx1grCl+oTBF/dgOBkbx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpEMmdhhXPNJH2EayTl77hfBYlCKiNSEH8u43o9oW9FikYkNbS+3/GwPfAjLTeAH1NipAqTRfTei5A11VJ5Pt9KSmE8ij0Zhr+5RTdGCszkENsvMSOzlXxDOOZDJuni82PzhnmntWznSurKobTryw81b3efYi0rHNtjbOOqhrJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cd9Mm5MZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739978610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/0kmnhcuXSDK/VJa/ZW0gcKx1grCl+oTBF/dgOBkbx8=;
	b=Cd9Mm5MZNS3z07sHkLsx3dBldfuR5guE8U2UZk3F+BziKCZ0vWFaIi/8Egd0bUc/sNsTMf
	4KskhN8ezNOUGM2v/tDEtWzpEmRAnJWHOduLsW9l8SpxbU3BvT3jyIzKZJ+5GbR0B1E2SN
	9gBmGjCiPxGgu8+3egpvIGnrX4XRX3k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-wy_-NrPsPJOUKZFcVv0X_g-1; Wed,
 19 Feb 2025 10:23:27 -0500
X-MC-Unique: wy_-NrPsPJOUKZFcVv0X_g-1
X-Mimecast-MFC-AGG-ID: wy_-NrPsPJOUKZFcVv0X_g_1739978604
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F12119783BC;
	Wed, 19 Feb 2025 15:23:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.102])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 910421956094;
	Wed, 19 Feb 2025 15:23:08 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 19 Feb 2025 16:22:53 +0100 (CET)
Date: Wed, 19 Feb 2025 16:22:38 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Hildenbrand <david@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
	wangkefeng.wang@huawei.com, linux-mm <linux-mm@kvack.org>
Subject: Re: Add Morton,Peter and David for discussion//Re: [PATCH -next]
 uprobes: fix two zero old_folio bugs in __replace_page()
Message-ID: <20250219152237.GB5948@redhat.com>
References: <20250217123826.88503-1-tongtiangen@huawei.com>
 <c2924e9e-1a42-a4f6-5066-ea2e15477c11@huawei.com>
 <3b893634-5453-42d0-b8dc-e9d07988e9e9@redhat.com>
 <24a61833-f389-b074-0d9c-d5ad9efc2046@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24a61833-f389-b074-0d9c-d5ad9efc2046@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 02/18, Tong Tiangen wrote:
>
> OK, Before your rewrite last merged, How about i change the solution to
> just reject them immediately after get_user_page_vma_remote()？

I agree, uprobe_write_opcode() should simply fail if is_zero_page(old_page).

Oleg.


