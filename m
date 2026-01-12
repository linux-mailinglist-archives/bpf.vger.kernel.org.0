Return-Path: <bpf+bounces-78609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 228E7D14C62
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A25308603C
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 18:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5313876A9;
	Mon, 12 Jan 2026 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGfTysYU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6903876A7
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768242519; cv=none; b=Q26Cv+shyHpgEMhItEwAoCdMpECfWs2h7w4tmPAWSmwM0222X1AIwR1hFlvB5sWS9/pud6pVRj1CdqFwfV5Bfl8uAx3FkkkNKLkXQzq5qvBMN9rnulluz8SZRNnNq1S/2tRJbLA1v0aQT3iLWxA+ZtYSbAxf92GazlJ2/7/Lyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768242519; c=relaxed/simple;
	bh=Ww8dTKlL8svqCEt09b6zV77XCKA9IZGYTWQfhZDLVCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1Lw2XvOWwPf6ZkgXSKKiH1teQdtP8FNNdMyBW2AibFLgKYN7GNHICJaOJz4IBeMcvgRInMXqJ0reGpFUW7zaAgWjbGj+FCnVs63c/K7xbAKFHBzBy2mKGAfNTvAngYb34jjbQeD4qdDvyMhgoueVOyJX5LZOi5GHJ5+oA1gwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGfTysYU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f478e5283so1520137b3a.2
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 10:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768242515; x=1768847315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ww8dTKlL8svqCEt09b6zV77XCKA9IZGYTWQfhZDLVCg=;
        b=hGfTysYUWbfhe35NnnghQJGF3NNQOPOBHTTZeQ8Kj0sTzLcRYr8Gv5yZoUmVZLnvez
         MedLwXp55hsXZdG02E7RdR4wlgMT4Lh7thJL2ccysRlgbyjFaZ7cTCZDIl96gw8gCLvL
         an6CTm8BHyJZ60bRhKi0dh2Q0DM4TDq4p6qOn0kxlNCkz0JY0vwh+yXriMsXTnF5Ddnr
         wnRWwYa4YN2fsYvVyUxLQpjIour0v9+2kp8QD/+mZk/kHjzuyyFPoKzz4ftRoSQ9Xfwj
         o5c/WtsFuMPw4b4KMP3CsJrlj56Ov99JZs39UQG/8lPjFDIHWKYbiPRQ8V0HF3DYmuRy
         u+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768242515; x=1768847315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ww8dTKlL8svqCEt09b6zV77XCKA9IZGYTWQfhZDLVCg=;
        b=HYyD8OqvmfqRKbiBfRJRfLGMDxmxOq5GY8t7GqMSYJrCM3eBcPPkDJb2J44FZ2wNwZ
         NIcnn0XLKUlGvKVv+nzWiw6OU5ZHgZ0SLVnynXOnjpJWs5It43ekGhKDB/xpP2SoubOY
         hJDfO8dycJUmx4Uf8ZFPTRcGChRngLhYlqdhA3ngiWmSznaZiuuproKXhpYO5tMQuKZF
         gFwAS3l0LV4DojR+AEIBB9JVZuKePRTecSLat9DryyuAypB8dA+ZJMjtDyHnGZAxGtih
         tbmvuaVllbKVmZEPLH8OVU72LO5hItZa4+Z54snqezHl1RjlL6YLG3cWfVDgstjGwBvf
         iN0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNXfLfZwVA5uvAMk66xJ4LOeTS4gDXy4AgfYs48wmqkpD+eFGuCzaHTm8NwL6XcYYaZQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3oPjTMXwO0WYzneSI4Ia1+L7mJFcfgpTDpt5A7FRKvGRcnYTo
	Zd1iAAHJw1u16iWpas4el9fySFEEvcONpJHQ8inoSkVbF6FltGP2N/X+
X-Gm-Gg: AY/fxX6jLiE6UvRQftXi6g3qdq/1N/3d3lCVXt0M4q8QHw+OblQ3UKu0/IRG+Q3BPyv
	JaOY+8qvZhKvYx/X5Gjdp/YMMI7egRef8afmNcOlXSCwhzLzyJutxB3dppmE8/A1ZbAZThsunIa
	hFOPBZpXLiiUqcHlF2PY/Q6C+oEU1QYiNdTqDyQ/wNyJny+eOxiHnEFjRy5oqY3hnglHVde1gsp
	UlOD99qZgr42DY2g89cbXtw3e0d4EY639KJpdqRPXWV1KuMnCQCNXBRc906ijYMIvNRjLmdDZqm
	NtCNLIhVYtwNA/PAvzuC83vWArKOn2EpprW60qdCgPPELlGUT51rZLukDRTBR0VaI1glo67H+iK
	F7gZu/EEaa8G7YIA8ubNQS21kVS3tPbedvJtcrFfguWr4EaEK1QM6UUD/VHPVO8WRWK+Ldei54C
	DNQ3H6xKDgFsiQrj8=
X-Google-Smtp-Source: AGHT+IFZO3R6LvzZZWvRh7XqITfngO5+nReNnVMEJVA3rCLts9qeDuKg3uj6KFcpivQl1tEiXHJ8jg==
X-Received: by 2002:a05:6a00:909d:b0:81f:4f74:2246 with SMTP id d2e1a72fcca58-81f4f742549mr4264740b3a.16.1768242515448;
        Mon, 12 Jan 2026 10:28:35 -0800 (PST)
Received: from [172.16.233.96] ([118.143.118.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81e6c8199f4sm6462596b3a.68.2026.01.12.10.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 10:28:34 -0800 (PST)
Message-ID: <b39e9af7-bdbf-4e02-ab7e-ec24626cada4@gmail.com>
Date: Mon, 12 Jan 2026 10:33:00 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv, bpf: Emit fence.i for BPF_NOSPEC
To: Lukas Gerlach <lukas.gerlach@cispa.de>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, tech-speculation-barriers@lists.riscv.org
Cc: bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 luke.r.nels@gmail.com, xi.wang@gmail.com, palmer@dabbelt.com,
 luis.gerhorst@fau.de, daniel.weber@cispa.de, marton.bognar@kuleuven.be,
 jo.vanbulck@kuleuven.be, michael.schwarz@cispa.de
References: <20251228173753.56767-1-lukas.gerlach@cispa.de>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20251228173753.56767-1-lukas.gerlach@cispa.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lukas,

Please also check out Ved's response from the Speculation Barrier TG:

https://lists.riscv.org/g/tech-speculation-barriers/message/21

I think the best way forward is to wait for the TG to clearly define
speculation barrier instructions, and use them for future cores. For
existing HW, emit a warning and do nothing. I don't want to see bpf
doing fence.i universally for all riscv. Neither do I like it guessing
this and that specific core implementation needing fence.i or not. We
simply don't know how each vendor design their cores. Let the vendor
tell us what's the best instruction to use for our existing HW. E.g.,
for JH7110, it's really U74 from Sifive, so we can ask them to fill-in
If we absolutely want fence.i as a best-effort kind of approach, then
I strongly suggest we make it opt-in. I'd imagine it'd be a very loud
noise if folks found the bpf perf on riscv suddenly regressed.

Bo

