Return-Path: <bpf+bounces-22077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B14F8563C0
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 13:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D556B2552A
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403612EBE4;
	Thu, 15 Feb 2024 12:52:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D65E18EA2;
	Thu, 15 Feb 2024 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001538; cv=none; b=NVBURfPlaCsWoGjGQNrzAyo1nAHWxT5AKAQmJOeGp6vSNYYScy+Eu9y4lY8paAzQmVte58Sma67+sdMwT9aAeNA/xG14hseTGeOkeYxJF6XE7Buz0E2yDf/gGl7zV8yJ697jzd+jVKl0vx3pPENP/A5qEA0A+3gDHN2CLavbFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001538; c=relaxed/simple;
	bh=bLWbQ46DZVFP3cIkPj3Ky15ZObtsdDCn3VqGQSFbZdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGd/xHuLK8HvfkAEWe1cxtByW/ljKKkTkwpEeZog8UKh+lkzEnZh+eBy8toUGFiy9eECFGH+/AFqH2BLYx567JWJA6WnxQ0mrHnVHE8YYZZFSrvwqxoBEzuZDaGeLQ4aifJLhQbeuWyli1KhWtVqvdjaBF5WjozTeQNlaEBPbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 425662F20246; Thu, 15 Feb 2024 12:52:11 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.102] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 60AF62F20242;
	Thu, 15 Feb 2024 12:52:08 +0000 (UTC)
Message-ID: <d16f0d00-b4de-27b1-f968-2ff177ef4903@basealt.ru>
Date: Thu, 15 Feb 2024 15:52:07 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15.y] bpf: Convert BPF_DISPATCHER to use static_call()
 (not ftrace)
Content-Language: en-US
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, kpsingh@kernel.org, john.fastabend@gmail.com,
 yhs@fb.com, songliubraving@fb.com, kafai@fb.com, andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org
References: <20240129180108.284057-1-kovalev@altlinux.org>
From: kovalev@altlinux.org
In-Reply-To: <20240129180108.284057-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

29.01.2024 21:01, kovalev@altlinux.org wrote:
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


