Return-Path: <bpf+bounces-49241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C974EA15A62
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 01:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C38FF3A4245
	for <lists+bpf@lfdr.de>; Sat, 18 Jan 2025 00:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C4BA38;
	Sat, 18 Jan 2025 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="egwwn+Dl"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC03FC7
	for <bpf@vger.kernel.org>; Sat, 18 Jan 2025 00:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737160683; cv=none; b=JD1b5MtFNdMwymvx7g0Xrt6nIxTX1h7TGkhChf6l6UQ2Jml5UtTBDzy2tlFS1iJ9fCHMeaw+y5QFCZ4YISRDQFFI4l6vNXp/qQv98hiW7lu2Yh5PNk5+5Pu9M5gvABcRuRHenl34rhc5tL1SmHNMzacNv22p8sNA41AjtRTg3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737160683; c=relaxed/simple;
	bh=fowIewx5fcUgpIR0wE22nk5YzhxZgyNXhXkjjGa1Ons=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkH/PX3aItHKayleLYlac53rQaTOnd2xovxZa92fgieHIQ9KDj1nvGs8yfX/YLop61orQPT5W2xgAGE+I1l8LJUJn6m358B8h9M9Qz+G+07+23VWvUnQ5sTlP+11EQZFl/Hh6XQfxm71VRmjVfrFJaOaDRIBXcaM2It19qsBJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=egwwn+Dl; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <117fb39d-2c9b-424d-868b-08dff75fe926@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737160674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fowIewx5fcUgpIR0wE22nk5YzhxZgyNXhXkjjGa1Ons=;
	b=egwwn+DlaBkEdStNav2+2G+hZvXvkd0CapjlsXtovjdMgMIqZ08HDUCmtsCe/2YbxQNmbE
	PCAG6nCEQuklRdIyPN7c1mSbSNja6W3X7tTC72Iy1ztDMsrF/UQUWDaTg1qxgqVnW9pGwo
	e5NwOn4TjIvApIkk/fllx5OW3VjOVUY=
Date: Fri, 17 Jan 2025 16:37:49 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: use attach_btf instead of vmlinux in
 bpf_sk_storage_tracing_allowed
To: Jared Kangas <jkangas@redhat.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@kernel.org,
 ast@kernel.org, johannes.berg@intel.com, kafai@fb.com,
 songliubraving@fb.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250116162356.1054047-1-jkangas@redhat.com>
 <9e5b183e-5dd5-4d3d-b3e6-09ad5e7262dc@linux.dev>
 <Z4qIjSMgIOqbHoef@jkangas-thinkpadp1gen3.rmtuswa.csb>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <Z4qIjSMgIOqbHoef@jkangas-thinkpadp1gen3.rmtuswa.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/25 8:42 AM, Jared Kangas wrote:
> Good to know, that simplifies the patch quite a bit. Should I add a
> Suggested-by when resubmitting?

sgtm. Thanks.

