Return-Path: <bpf+bounces-30492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694278CE6CC
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AD801C220F4
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F16E12C52E;
	Fri, 24 May 2024 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="w2eY3gpI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E08562C
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 14:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716560119; cv=none; b=UTFyBNwDgoqs1+A8LtJh9ofga2PggZHBiDm0BTWMCe6zHXU0HzmMBDeIVGO4oLwi3JmrILZ/+1nB7+SKJhlbxeyi/t1KsWEicJj1L6UFi9ytO4mcb8VbkEMUjsS4W8rqNNO8K1WcYFaurJ+4TpS9xK0Gj3PbE3DIg+vKiirDOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716560119; c=relaxed/simple;
	bh=3oyL1xg979Wd3JmqihENBu4Vnp+k+yMhGiZu/42vP/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eizMqLq+6uikoljIka/+9QQOLQC0sDjOmgFOHZRuwkrMFjbe3EFnciKzDMLl/YaU1e3lAG+qvbVZL/x59iEZjzpuwEsVNTZwKU8+fqNAAJVq+EM/xoZ65bNgcRWAkP1cOLkfmAW11WcsYDyBCd0DihYZjc/PhRBNg43R4tLenNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=w2eY3gpI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6265d48ec3so111839166b.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 07:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1716560116; x=1717164916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzH9/kd4g2Cv9SF58a2TQf0rXcjP1nTT2vaKMFNbqB8=;
        b=w2eY3gpI11fWOWyHAyD0HJ78a9x6kByT8Y0ozlox4j0FPw3MV5uivr+bi8WM14fnem
         nwE/Rmto8M3Dpx7WHnMHzxKuL+yxqJzhCl6uOz+M5fgiuYm3lkDH9wTlOitxmqBnIhfN
         rXdNnJTHArK7ED/FGTCUoKjXT6sGJKzkkr7gfd116NY/ja36dFa5ULzq2h5zuzMVWnXS
         CuGfz9AKQp10euoM7xufWPihAKuR1AaNOaD7yIVinWXWiYOffkn6u8bYu4NdyKmbLyEb
         nW/mWV79cWrNQ3i1XSPVtBGsbzJpwffSKfzA9x96pdXrgWk23ig/FhZeSOnBKc95mY3F
         pmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716560116; x=1717164916;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzH9/kd4g2Cv9SF58a2TQf0rXcjP1nTT2vaKMFNbqB8=;
        b=YmbhXqpnhkBW+wZXyzEqTReShVRP1rsTpb7NDnsMCqeCNYMJS11D0F+13wM5JP71hY
         Iu1uHRpy3o69ouzA9HDgIHFmfgotnTIjx08AgEQ21coeAMpjOABVR9wEJxMYhoqOco1/
         KYXi77ke4TiGNPPBgqgtZBl3ABFbA6LP4g7X+ZbS8Q01Jm0k1tscKCg8wKCg6Brjviwz
         JB+Az4O6h7U0EWKxcvzvxcMz7NUidpeorCYUkBRSqDP1QuT0Xn4O0PPnymvljDKei+Mw
         eEdyPXHWdM4rAoSyiQZuNy+njnQwifiG4G/eDSF1dQrFyOBm95qLwh4FcSYjzBFoGx7k
         LyYQ==
X-Gm-Message-State: AOJu0YxuDI8rVzW/DhNDFLB71UzfGyFhbaJBpyE8y7S2KwLSO8cKnRVX
	iQ4PzAMk6PEkmHWh6VEBtKaisQy4/wGfBFjsFnQVCJ4Oo6fG71OBbFF0BcfvesY=
X-Google-Smtp-Source: AGHT+IGW2my8QyFWm1svam7c8xLj4ilWKCOALaSOb4lBdLbBSSDNHKB6XgBLJ47V+U2VDEkOGE8lJA==
X-Received: by 2002:a17:907:170c:b0:a59:efd3:9d with SMTP id a640c23a62f3a-a628cd3826amr25637766b.58.1716560116405;
        Fri, 24 May 2024 07:15:16 -0700 (PDT)
Received: from [172.20.4.8] (92-64-183-131.biz.kpn.net. [92.64.183.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8da2asm138130466b.179.2024.05.24.07.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:15:15 -0700 (PDT)
Message-ID: <984f7580-890d-4644-b8ad-144505a882e4@blackwall.org>
Date: Fri, 24 May 2024 17:15:14 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 3/5] netkit: Fix syncing peer device mtu with primary
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, Joe Stringer <joe@cilium.io>
References: <20240524130115.9854-1-daniel@iogearbox.net>
 <20240524130115.9854-3-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240524130115.9854-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/24/24 16:01, Daniel Borkmann wrote:
> Implement the ndo_change_mtu callback in netkit in order to align the MTU
> to the primary device. This is needed in order to sync MTUs to the latter
> from the control plane (e.g. Cilium) which does not have access into the
> Pod's netns.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Joe Stringer <joe@cilium.io>
> ---
>  drivers/net/netkit.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

This one has unexpected behaviour IMO. If the app sets the MTU and we
silently overwrite, then it may continue working and thinking the MTU
was changed leading to unexpected problems. I think it'd be better to
keep the MTU synced explicitly (e.g. when set on main device, then
set it on peer as well) and error out when trying to set it without
the proper capabilities.


