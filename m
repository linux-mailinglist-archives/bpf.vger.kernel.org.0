Return-Path: <bpf+bounces-13280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B05527D770D
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 23:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651CC281B71
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0D34CD0;
	Wed, 25 Oct 2023 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IogRoM43"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7BD1401F
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 21:49:06 +0000 (UTC)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A4A3
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 14:49:05 -0700 (PDT)
Message-ID: <4724ebcf-0e29-45d3-a886-a99013df7a5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698270542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kf8tYH6CQPftx7oBWYvrTe587NHO4Z3+fbMp8S4x8xE=;
	b=IogRoM43DcC8dFrlmzW5w1CTaXvJHkXFQmonNSzPw7EdB6VWRbtEJPSd7h5r/pbhK/JOKN
	n9OEemaqUp0J2bmCYdVHzBRN560eM7SEpXiWEhcYfGfH1eNgfsPVF6YZ6lYqBzEqfMhVV6
	CO9OMfjaXv2ET01DlvnoQQ4CR3eCPnw=
Date: Wed, 25 Oct 2023 14:48:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 bpf-next 0/6] Allow bpf_refcount_acquire of mapval
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20231025214007.2920506-1-davemarchevsky@fb.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: David Marchevsky <david.marchevsky@linux.dev>
In-Reply-To: <20231025214007.2920506-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

The name of this series was cut off. It's supposed to be "Allow
bpf_refcount_acquire of mapval obtained via direct LD". Respins of this
series will have the correct name.


