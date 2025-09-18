Return-Path: <bpf+bounces-68859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534AFB86D78
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 22:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0789D188FD9F
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 20:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B90631AF00;
	Thu, 18 Sep 2025 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZbi97Hd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037A27EC73;
	Thu, 18 Sep 2025 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226194; cv=none; b=YfFLVBsccwcM33D1/uRG5SpUhJMs+nxEgu6ljCOxdDi/zqITxUGrEXjbcvuVauCmUmZsRj+b6bpbZhuJ0LdHLVNk3fQhVkHHGhEJvrkuAzxjL/mZjVUie33dqxhff+o6A3+oRQSVEJVw4fi8/EA/bpJTG1pWmKQ9e6NLNeyY71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226194; c=relaxed/simple;
	bh=c/b1hXwFk6oY3CbOm3JydXPJpzq+l/FYdblKI2dTnmE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p5eufoza9sTFvlN3SX8X2AxoX409VbI6lck/bhuNRvAFRPvYBZBgJTuGPYzy615GPgFUiEocWn/dgef1ynBAS/QaTgbb4pdkFHZOqqfzU/z7yInPux+lDoFFa1xzwXdxj50rUKv8jN4OnD0zdNIA7T/MHexCbiZVLcZDuVUJBFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZbi97Hd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424CCC4CEE7;
	Thu, 18 Sep 2025 20:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758226194;
	bh=c/b1hXwFk6oY3CbOm3JydXPJpzq+l/FYdblKI2dTnmE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=SZbi97HduxsXD13slRBmRXNFqoEFVVVLiB6rgDLfiA2KVIch+kwYm2qdkFygU0dA6
	 6fkhHgt6I3qawrSNPmVBUJmzJKYzwjm9ZftMLAZzKrcn/yWi3QpIFAJi64Fbga5wRP
	 VKGMk0KLgJp+tpiEpJoElHXViy7CIE4d5EJVesuGr4C1tb7rW+h97bI+LYiLmv79lZ
	 pl+J6NDnhWkOHYgAGGfsR5X4agwh8YKEo12OBOkbgIYx8zPYgZX2W99ra3SweoZ22L
	 SZaRh+GHB9Kzpsilm9H4pJNUX8WEzvcy/IFXQeLsG9mxgqZwxPsxup47QsV7mBMMnu
	 MqAtjNIstBjgA==
Message-ID: <3c45eaed-e17b-459d-a0fb-5a62f806721f@kernel.org>
Date: Thu, 18 Sep 2025 21:09:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpftool: Add HELP_SPEC_OPTIONS in token.c
To: Tao Chen <chen.dylane@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250918120908.1255263-1-chen.dylane@linux.dev>
Content-Language: en-GB
In-Reply-To: <20250918120908.1255263-1-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-09-18 20:09 UTC+0800 ~ Tao Chen <chen.dylane@linux.dev>
> $ ./bpftool token help
> 
> Usage: bpftool token { show | list }
>        bpftool token help
>        OPTIONS := { {-j|--json} [{-p|--pretty}] | {-d|--debug} }
> 
> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>

I acked this patch before.

Acked-by: Quentin Monnet <qmo@kernel.org>

