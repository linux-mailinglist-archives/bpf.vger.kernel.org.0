Return-Path: <bpf+bounces-69828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C49BA35D9
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F0B1C052C7
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 10:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233282F5329;
	Fri, 26 Sep 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPMh5BuC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982D21D3CA;
	Fri, 26 Sep 2025 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882796; cv=none; b=PSpTFxtSwbutvRx4Zo6R7DBTCWEp7/HespVVMrcrS0E889uGdekT74uhH6om6nrOY6kuShqQIMFOboSyh9UttQO9G8GxqUFMLqaA5GbW3WfkGukrMq+pezAbCQmK3OnXNbKm4psi7ttLC9IT3h1DLl6hjkRpQo5VEVxwnw7CGPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882796; c=relaxed/simple;
	bh=zsYZA4vHyrrFHdp0O66sAi9jcVuF0EDcLiQhVy6v75Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=li4OE9gC4LD9JOLi+HIEzHHNkihnlrAE6Aiq8vZRfT6KOzB5sPMbjDspW+tHiVivDTLnqvrfF7n50ecYv9AwxN4rxGRn9zDgy1HW16DV7+FIWVshORLk6jPivhlSH62o9i9DibdGmhGRc9K9v1fFfHRsf/3xkbP7ELTva9I8WNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPMh5BuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDCBC4CEF4;
	Fri, 26 Sep 2025 10:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758882796;
	bh=zsYZA4vHyrrFHdp0O66sAi9jcVuF0EDcLiQhVy6v75Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DPMh5BuCcsIHjB++3DnD73wHodEeA+UD3MrSymk+qPYxnrjn8ZM67N2W8hPLwC3SB
	 GWSddpgmBaNlFJxxCyDvN131kIpvO/zoO0ND0CsFJZzc813sU4dp5GTaPeeIw8PTBv
	 uckbI7guqoAnkqwbAnB0+HVru95ZUNwhGgI22VH31YCsDTWtYjYTlKnAN6DS0n5+U8
	 1gEBIMIgR6KqnZUqgMNasyhQhcCbEULqSfbe/WWkOSGaPxU6Jy8qNFpnwZqnqrhkro
	 BKwbhtyISTpcRLSJTFb268KbJiICdaFLY0J7ZFdZpK8PRMQFZlHMsu2K+IJABi7+Gi
	 C0cZUmOAD8NOg==
Message-ID: <b9c892c1-fb33-42fe-86bd-415d4cfa37f2@kernel.org>
Date: Fri, 26 Sep 2025 11:33:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/2] bpftool: Remove duplicate string.h header
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20250926095240.3397539-1-jiapeng.chong@linux.alibaba.com>
 <20250926095240.3397539-2-jiapeng.chong@linux.alibaba.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250926095240.3397539-2-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-26 17:52 UTC+0800 ~ Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ./tools/bpf/bpftool/sign.c: string.h is included more than once.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=25502
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>


Acked-by: Quentin Monnet <qmo@kernel.org>

