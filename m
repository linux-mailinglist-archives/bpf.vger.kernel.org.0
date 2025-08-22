Return-Path: <bpf+bounces-66294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E74BB32125
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 19:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A7EB042CE
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 17:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163883128C6;
	Fri, 22 Aug 2025 17:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="KUeoQexD"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE42312802
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882478; cv=none; b=g/0fq5FcozZxCeSrkEgDSW/yGbQ4NCI9rAUNn1QL+MYJgggUC5DlpJVe61qquIJLzTSRLdH4EKdgg68rWXL3nV9UwtfgWu4FEZ2ebnP9N/+HHxM+YGRoswo7fxMSYkTTj1yUYW33iH/jhzx+OA5D96m7RdM1KHR0UD04LT8Y8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882478; c=relaxed/simple;
	bh=YwYmK0uEautm5jZ5vIrEXR/ozNJ9caRKMMIoKG5ox94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+C7tyzuKzFjIA7MYDLjNT0AXwcAo7ITQN+5tyAuNHops++qXymVorivMUSxawPUUBtZd2pTTQiXQZxu4SNsjFzPwd7hg+J80+4n8NGyJwMYyRx9PuOv8BoCnuFV5YgHHqVfzYY3NH316UkC7AJWmEpmYEhl8jBu/V0V2/EM2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=KUeoQexD; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [192.168.29.2] (unknown [49.47.192.36])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id B4B7144C87;
	Fri, 22 Aug 2025 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755882475;
	bh=YwYmK0uEautm5jZ5vIrEXR/ozNJ9caRKMMIoKG5ox94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KUeoQexDavhNwGSmvSHajvUBFYmIE0ybEVTT1thJubD8mstLJxlqcZGYSYLBYjBxd
	 uyBXLNGHaQ5DcgO5+5S7sLW//1Cmol66aAaHWRWPh6xKZii/AKtchHPoTj6mZoam83
	 qjLy+A21ohtIFHSQsTyUFRPU08DKXY5JPY+zwu3K3tXYdML/MQinVOo/70jEYYogfV
	 fZKBpVtblvYEodSrPW/JdSu7K0bnpG2hbChhe0t758p8Xad9YjqSWEiPYJ9hG6SL+4
	 HBg1C2YyEbKaLvQmVYwlcP52dvMpQmh6W7X9bc8rijrlmlgJmqXwYnw/AnJPSREfJS
	 kZuzWGlUsDruQ==
Message-ID: <d954d054-965b-4cd9-a336-95170f9ac096@nandakumar.co.in>
Date: Fri, 22 Aug 2025 22:37:46 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] bpf: improve the general precision of tnum_mul
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
References: <20250822170407.2053504-1-nandakumar@nandakumar.co.in>
Content-Language: en-US
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
In-Reply-To: <20250822170407.2053504-1-nandakumar@nandakumar.co.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sent with an incorrect subject line. Please ignore.

-- 
Nandakumar Edamana


