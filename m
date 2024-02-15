Return-Path: <bpf+bounces-22078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649648563BE
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 13:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208E82879AF
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 12:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26B12F36D;
	Thu, 15 Feb 2024 12:54:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42612E1C4;
	Thu, 15 Feb 2024 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001654; cv=none; b=H2pHLUmsv7uxTqDvc7ZW3m98pW+eaKIWYDicPaeBMl5wyyqDmu/qon5H16ExJmjMMitFZZe8H05hud1XiQu/QnNeNl1Okme+XxP1Ooeue+6GSY6CSSuu3lBuE5jjG9FE/aQ9b+IS+nFKNcNsF2PWv3mBchldHdD7m3ZvOXL+rdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001654; c=relaxed/simple;
	bh=24ZQIplg2nxww6XREpPFlvV36xTf03s40vp7UO0EoeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tr1eIBlc+qhaIb49vekvyji5n8VIR96FvLNXUMRPGY8ThAv60PHbjwgh4KLAu/RguaMIzz0FpXxigqssXdcMy8TNgECY3nM/jjzgze6m/Unm4v5CNM41uY2B8N7b3VYaPHBy2vN4H4C4/OWds1ErghrWChcDb+yCC9RIGK6x9Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 969AB2F20253; Thu, 15 Feb 2024 12:54:09 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.102] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 365912F20246;
	Thu, 15 Feb 2024 12:54:06 +0000 (UTC)
Message-ID: <322f5fcc-942d-71ce-d6ad-ad6f2c603e67@basealt.ru>
Date: Thu, 15 Feb 2024 15:54:05 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10.y] bpf: Convert BPF_DISPATCHER to use static_call()
 (not ftrace)
Content-Language: en-US
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, kpsingh@kernel.org, john.fastabend@gmail.com,
 yhs@fb.com, songliubraving@fb.com, kafai@fb.com, andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org
References: <20240129183120.284801-1-kovalev@altlinux.org>
From: kovalev@altlinux.org
In-Reply-To: <20240129183120.284801-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

29.01.2024 21:31, kovalev@altlinux.org wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> [ Upstream commit c86df29d11dfba27c0a1f5039cd6fe387fbf4239 ]
>
> [...]

This patch fix warning in ftrace_verify_code (found Syzkaller), see log 
and the C reproduccer by link:

https://lore.kernel.org/bpf/87f74eab-ae51-08a4-5b7e-261f437146f4@basealt.ru/T/#maac87a6679825bbe8a14a2ec2ec4cf94681aa885 


-- 
Regards,
Vasiliy Kovalev


