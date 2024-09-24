Return-Path: <bpf+bounces-40268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10806984AE3
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 20:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BA728486B
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 18:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D733A1AC892;
	Tue, 24 Sep 2024 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUPfh76P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C51B85F5;
	Tue, 24 Sep 2024 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727202959; cv=none; b=XMUaeNKAszWyMzMchzZdhC/os2DWCWRLZJrR2XaypPpyAzk/+tSs5Gjwo5o1eHLT9HfivN0wgt+3UAXpdsxeHYT6TIrOFXqodFWjk5iFScGKGUmpicDiYDUe9Mjtt49Dme3F4XjIcNKIa87GXb8qG4Ql6dehLeZMdrNIiU62cCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727202959; c=relaxed/simple;
	bh=LsmppvOjKCADHOoV12H5YeykmZ0NbKbrpsEnDL0LZPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7dkqzEC6P4Vw5YWRtDsKioiC3Spwk/rsXK+qqfglpQ4DrUqRNhXaWziOOlgOEPB+AfJaesVTPA5Qo5xx7YaOq0oVE6uwxIBxU0bTbBs8faW3+wV9BCqymaxBztfUTRPF/nSZ12UycOueF53hqHCxbjr71yroRbpOC1Yaic4bv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUPfh76P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57647C4CEC4;
	Tue, 24 Sep 2024 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727202958;
	bh=LsmppvOjKCADHOoV12H5YeykmZ0NbKbrpsEnDL0LZPw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cUPfh76PDJAz17PH6AXMezs2DuFYutpX1ebWy7NbkKwOaPWE2088gHVfjdUxnyWzy
	 kBe41H3h8BVuUyIOcoytNJX7fM37+/0jHH0616pT56ieok/wZtGqt+02YCnxZ8YFW5
	 iBu3Ot0uO00PbxFeEke8B3yYPTrfBEUtnyHB4zcuij6sucIae7yWK0S1j+2wQCgM3s
	 /D2MYodOGKvAmu+OqzD07CUDG2KOsVPRYTWjZpRcmZgiF6j6cI69VHiTAm+UVLW8oW
	 jTIsDFoq1Ms5wXK03Z/UIyC49XzQIBarOKddI/pe6XtmcmtUBP7bUyXdTTJUFwj+Tk
	 MwuyEV81JYpsA==
Message-ID: <3dd42159-9c5e-4cf8-87ca-7fe0ea9f4b62@kernel.org>
Date: Tue, 24 Sep 2024 19:35:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Remove llvm-strip from Makefile
To: Tao Chen <chen.dylane@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240924165202.1379930-1-chen.dylane@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240924165202.1379930-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

2024-09-25 00:52 UTC+0800 ~ Tao Chen <chen.dylane@gmail.com>
> As Quentin and Andrri said [0], bpftool gen object strips
> out DWARF already, so remove the repeat operation.
> 
> [0] https://github.com/libbpf/bpftool/issues/161
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Suggested-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>

Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you!

