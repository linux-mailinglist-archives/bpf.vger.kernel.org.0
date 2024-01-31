Return-Path: <bpf+bounces-20791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F89584380B
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 08:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E56B24088
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 07:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7054BDE;
	Wed, 31 Jan 2024 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N0kng6W4"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF3A54F9C
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 07:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686806; cv=none; b=WAI0LjB28Mo22xAtbgxozwxMF1zGYt9NmKLBBpXEacx6UeDonnV8m0vUWivebSN+4lz9w1O7S/AZrNt90q/4iNYeeGTWW65Jmi0z7UUKI3Xt3Lk2I9OeUxOkBCJCTLrX/FmNrSZM2YEW3knzVaFIHTBdIGyz8++upQBcKf28qCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686806; c=relaxed/simple;
	bh=3nLOswC5+ewlsy+OrMfvXS53YCx9mM/XLDJTCDiILck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2qGKwnjGK20pnPGp/hPeK4jgH0nZwc3iMTUQ1697ftjXgO1HGGP6HQ1pz8ul4meeAE3cVVLlm6RGYquCYXAGrap+0zd57SaBv6EurqQtqs+5C1jug/IZkQFs459dS3u0nbUxZiWCd4kzNli1sqxM7dqLZ8PLO0yHPLCkXMO+nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N0kng6W4; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49e40094-0644-4b11-b80c-c2316c66ca3b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706686800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nLOswC5+ewlsy+OrMfvXS53YCx9mM/XLDJTCDiILck=;
	b=N0kng6W4kOfhLQsuulrkqMiV3BPSIZLo5kfxNBYkulvXW2/0PB0cA5Cb0+9Wr5sxgMdDT+
	yOGcea2MIiWPpInJVnp16hY/l162AdLwAty80mNkbx1im5ba6DPEWQakywEa/TGBYhkpFI
	/jjyu6rjRai0b1KBDzpE+Siw5c8dn4c=
Date: Tue, 30 Jan 2024 23:39:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/5] libbpf: add missed btf_ext__raw_data() API
Content-Language: en-GB
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20240130193649.3753476-1-andrii@kernel.org>
 <20240130193649.3753476-5-andrii@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240130193649.3753476-5-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/30/24 11:36 AM, Andrii Nakryiko wrote:
> Another API that was declared in libbpf.map but actual implementation
> was missing. btf_ext__get_raw_data() was intended as a discouraged alias
> to consistently-named btf_ext__raw_data(), so make this an actuality.
>
> Fixes: 20eccf29e297 ("libbpf: hide and discourage inconsistently named getters")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


