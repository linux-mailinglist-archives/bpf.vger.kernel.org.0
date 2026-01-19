Return-Path: <bpf+bounces-79456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CA7D3ABB3
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 794153048ECD
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAD637A4BD;
	Mon, 19 Jan 2026 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mXBS8QWj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176335581C
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832483; cv=none; b=JnSVgHHSyHK2yjkkVTnbBfIEKoIF0GPnTWcg75bhAG0T2O/rCucDeMpT7sLKw8a1qfx8M4MIdwNUlRZXGkyvgRP1rKQ8lOT4pKExREWMAGD10TpdxV/Ae9Q9EvTKSkbwWqeHBKoFftE/wEHA/3yBPwKombpMmiveNA77GlQpozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832483; c=relaxed/simple;
	bh=6O8j5Xb35ut+mOVJYW0x3in33ZLnFSISNS5PyTbB9q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhAhMyFRVSvg8xWunnN7rhoINgLZus8TB1gq3bSmcoqbTv+qoJMgITI1LZM278XHKpwivNdSLOYT9HzUDyEPUO0qY6Rz01y7k4DAAom+yoGO3RHuHSw+NZWUFPt/24ZK2q7bX9alwIoYu3ED9ZYFBfB99ko+kl41b5Qld0TVCtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mXBS8QWj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso6096040a12.3
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 06:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832480; x=1769437280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TU2AXntQ3PPGlHkKUhy3gD5Nsu2Le49jAjpZaqjsyqw=;
        b=mXBS8QWjQ37lXKSOY0A+OI9hY//h0tMQH79sDyf6OuK0LlgdfZPecq7bEarhmHEVPi
         QytCnRekqaP+liy3jWZdIe5PO3DZhCQ2nFPqcpMojwCaEpA7+5RkJfsRnEWkSvV+h/HP
         wvT57wOiY0sY2RE50CGVpEbveM+xAYD3fRG0BhHXU225XnN+ucZLroZN0007BjbG75vd
         NhFnjXLDkxsksmgWiEW4nAAPvsgka96ccmOVkdX6oOCE4ZJ9Uo4DxbHeQW7HvpdcS4vX
         xw/f/b4CiNupiAMq2sMc4b8Z7seifysOwALLMpC9DqoPq+LeM36fKYWIptLESYNcMUOo
         VNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832480; x=1769437280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TU2AXntQ3PPGlHkKUhy3gD5Nsu2Le49jAjpZaqjsyqw=;
        b=RoMRtgVh26yZFYFMuI6aKX8D8E3Z9I+dyYsR+jNeAlXvvWcfc7yahxuN91FXSXSpmf
         gKqTPeLA31g56nmsetkwnqIwmPU2YyUll6mvrkVl0NV9jIVobmJ9tMMhCES9HKygUg6K
         fFAqjkqkgrEDzqWdTiXUkrcCN3aQDsI080EbSdvxc/nZuufRTYpuy2eHrBUPinGAneIM
         5gN9XE3M5sz4ToSnW9wHxBdCb7CDLBbh8cdW0JwvwlgWvApUx8Bgn7x9JXdBNzfUY0ym
         KIuncCDpY/bbTIoRb5hybgfgKs8YJ1sRgJhZF2onTFEzcTvqKfDf9sUDTVfzgogHcnXv
         NiCQ==
X-Gm-Message-State: AOJu0YyTv49tsO/kSr3o0ZfMWOJv7bwav7+accr625rhSOZNyjCtKPGd
	w1ImVKqHloApCiLMUE+oBcL/ILfq84QqcFAPP/03rNbbURjDVv2IyT16ub3w5zjB8TY=
X-Gm-Gg: AY/fxX798ug0dsIkKSxQgg7L7fRk6pYwXcSB/+/4w5wo5JHDaMqZDxSEMyoXOrIJg5T
	GucL3YgGD+1pwm5g55GJQWOnQTOeuT9VxAJHijZOzhPTqccpyO7BFNsdOCtcuOaScSDUOATrMnc
	qdEYOivZ+KqmGG0iJg0StWdVosiSd0m1bp34r3sqhF3Y6plLv/YNdp2+B2zB7+NUqB1wS8FGdh0
	ssPs/ZlKnZcj2uJqhiNIhTH+tUc9F8Oe1KTROlof3uRaQE2LxTyLyPm1kB+XxUsW25qfY0cqysw
	oQOS59A0aAuSUVWhTX77kcenJ1/H8tpLYpwadcmoX1oGvvRspXd14rq24EAyyZ87bbSdq7KoZRS
	Ff2LBwbAjXquQHsVQgooKTXL8RtIth26NGVRv5gBOiKe6B+GjlzxQCbrLc2Sr/Pz+yq7PMrF/Cd
	APMqWSokGWGfHqmxknNB0f/sYIo7nmuTPVP1HkuaKgWTNxnNW4Irbk34Op4IQwwKNAvrlnsQ==
X-Received: by 2002:a17:907:d644:b0:b87:113a:7384 with SMTP id a640c23a62f3a-b8792fc5d9amr976649866b.32.1768832479507;
        Mon, 19 Jan 2026 06:21:19 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795a0880dsm1103126966b.57.2026.01.19.06.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:21:18 -0800 (PST)
Message-ID: <5c458312-2949-4dad-a358-1b25163df01f@blackwall.org>
Date: Mon, 19 Jan 2026 16:21:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 06/16] net: Proxy netdev_queue_get_dma_dev for
 leased queues
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-7-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-7-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:25, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Extend netdev_queue_get_dma_dev to return the physical device of the
> real rxq for DMA in case the queue was leased. This allows memory
> providers like io_uring zero-copy or devmem to bind to the physically
> leased rxq via virtual devices such as netkit.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   net/core/netdev_queues.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


