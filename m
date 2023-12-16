Return-Path: <bpf+bounces-18073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B2815674
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 03:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741BF287215
	for <lists+bpf@lfdr.de>; Sat, 16 Dec 2023 02:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C4D1868;
	Sat, 16 Dec 2023 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KbKvkmS/"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B781841
	for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <725bd1ef-94f0-4f2e-b3ba-d6842d291270@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702694682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPdrIFXWzIZ5rMj49ITx65he/WNt7o4m/QKb2jorIHs=;
	b=KbKvkmS/chm/AwVgnmugpRAeSCZG6m5AmP+bl+UBmVNfE43693Vzy6scKmpoDzlWXe0oHN
	fpUX+3Y1VfkN99s02Vhv8iSfQ4KdqGYN0rP6o4g2JXxaBKSWXcd5hnGc34hnsBHPipBgPy
	I5up6UzBg0CkyiOq9Zw1ex0GqG79MtA=
Date: Fri, 15 Dec 2023 18:44:35 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: ensure precise is reset to false in
 __mark_reg_const_zero()
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Maxim Mikityanskiy <maxtram95@gmail.com>
References: <20231215235822.908223-1-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231215235822.908223-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/15/23 3:58 PM, Andrii Nakryiko wrote:
> It is safe to always start with imprecise SCALAR_VALUE register.
> Previously __mark_reg_const_zero() relied on caller to reset precise
> mark, but it's very error prone and we already missed it in a few
> places. So instead make __mark_reg_const_zero() reset precision always,
> as it's a safe default for SCALAR_VALUE. Explanation is basically the
> same as for why we are resetting (or rather not setting) precision in
> current state. If necessary, precision propagation will set it to
> precise correctly.
>
> As such, also remove a big comment about forward precision propagation
> in mark_reg_stack_read() and avoid unnecessarily setting precision to
> true after reading from STACK_ZERO stack. Again, precision propagation
> will correctly handle this, if that SCALAR_VALUE register will ever be
> needed to be precise.
>
> Reported-by: Maxim Mikityanskiy <maxtram95@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


