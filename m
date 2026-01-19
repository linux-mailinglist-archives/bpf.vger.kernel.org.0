Return-Path: <bpf+bounces-79519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07377D3BB0E
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 23:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF3C23043979
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 22:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604732D97B4;
	Mon, 19 Jan 2026 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK2choiz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BC197A7D
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768863335; cv=none; b=KOcU99+vI3NTwNA3kbmzXLQAwxU3fIvxwX+fW/4PnvBylQz6iI5oqC/Qy1D3IgwkVPXButsEvY3sUngMBEBECXn2WFb5ymc7stHSgFNwibRjHit3gNq7fnRGQdJoNd/rIgHf63cVhkDWJ3rNboEx4mCeH553AhRpBiaWZrS12DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768863335; c=relaxed/simple;
	bh=CknUH1Ef36XFVXyjVu+tBfwZhOLw/zHsFq9ziLwCTqI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SXAXNSlSobfgnDhshEp6oFghYqJefbSpfpriTL39hc+GvnmZKtqTGAYNB96VyFGMxmj657TZ0guBKveQLENhYVIpbRwa3JtYItk4d8dxhP5fi9zltZQyHomI+YPypRA50ilrXdqXDidCW6EFW36M2+wY/xeS4RkqJD+Uy3/jqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK2choiz; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1233bc1117fso2980278c88.0
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768863333; x=1769468133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TZazt0YRQVuWHg3NtOlqMLp781jG3zf7E4stDnzqRW0=;
        b=AK2choizzYSc8ldcPOoXgouxp0wyq3U5VU5SJM5DrIhxfMOLyyhqttFL1vkik9Nnxh
         bFjzTyFR+9XV1svb9KeKmeDFMLcv9GXXUb0lCBb2ZnomUvAQabiOJ2EKnQeGrUmlyvjA
         UH6XAG4jnJQdJEl0o3XbBehcta6dkcBx2rPhKcnI7sAOt2hWGFQn2LT22BGNSzc4dC9y
         yGsvPc7hgkmsoWQAsXauDKhrUrSwU9Nny1oi3d9uUg0LyR5pSQRFWTFHOXPpgO1qYbEU
         NgPC2iIpg+1G0DhQq7nZdIIhTJffqp+5+EXtUCJlW8psd0YjJC43/jhIfizan1gB2xva
         jIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768863333; x=1769468133;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TZazt0YRQVuWHg3NtOlqMLp781jG3zf7E4stDnzqRW0=;
        b=o+KiNoq/YhaIx5DEq3nVtrj9B3dwNg+jpkU02Udoe5ksmxbqocrKg8xWBWaS62FIp5
         mONiqqYYAnw89AZtquSTNjiuO9caag0ac1HovHkhyE/V1R7ZFv4qe4x54IeWvPyPGuQo
         NnaToudzXQSFU4BM1ooWEsmH3CDSZgEAejZzltciurdg0sgnxUlHIKwdox9WKqBMzXVu
         fNBk4ymPpFBe9jcVPOzADJYb3QmdjXFG+BNLe865Vk+aIhSMjQ+XxWamCeo3xvIomXkO
         bCTeUAB2K21bAiBUAO6BkshnliV56OA38VKy6qi0roYKesxRQRTU3GApRijoQ7uKgvOT
         DT1A==
X-Forwarded-Encrypted: i=1; AJvYcCVfcfSzMtqwNZoUul1f6NjXCpE+Q5lvIOdyBN7LATk1CE5DvSxgODcMKyHpENyrfJXHDB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU5zYPrsd30mpFRDtTRR/Fis0YF8K5FoTx+HL0H0XjT+zTZU8g
	y3fmG7327wqwv1i8PeZd/w/hNudMs/aPX1hZ06KvBojJUsUhtgJ4I96k
X-Gm-Gg: AY/fxX4MIb1O5hEVqQgDHqvzjxxTBLTu//1eHuejati6EaXFkGUnKaDxhK+qpxHiwXn
	TT40jsq2GH3kGRPRRD0Kl8c6zwChtwA0xlKKPOqMAwwJZuCUTfLscYLfGFD/feMOe2CuOalqdrC
	MJ6gfXVY1KELxH337++ifEvF5+8q5u5MCE1T84+L8qrBJxVfRRQGzkz/j/TpUeFWoj8H8+fUD+A
	pIE9mtrBFANTJaNxP7TkRnGysTfupVL0NuM7rkJac2OrB3R9wPvy0uSV9/iIVqrca3J2YlKizeD
	gYGyjbCn4uTDQsQrSUNFpzosGLcVePVgUA27VcykTzsQvNm/4UenwAr2oxPdbh9SWNpZuoG+P76
	16LRDrlBAuw99btTWKJAeCZrQrGtec+NLbDdp9bvkhsIEoTP2t8NJk76XAh4axsQoEa4vS7GbZT
	r1FPpW3srpY9p8j53QLY+E7VQ8ufeN9V+EVbUviM9iZp2fSvDh/9DgvA0SgBE7TDT3wA==
X-Received: by 2002:a05:7022:2489:b0:11b:c86b:3870 with SMTP id a92af1059eb24-1244a923b9amr9542797c88.4.1768863332815;
        Mon, 19 Jan 2026 14:55:32 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac6c2besm18729400c88.5.2026.01.19.14.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 14:55:32 -0800 (PST)
Message-ID: <8eb725d8d0878a7a1b582fdfacf05d20a2542304.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Remove kfunc support in prologue and
 epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Amery Hung
 <ameryhung@gmail.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com
Date: Mon, 19 Jan 2026 14:55:29 -0800
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-3-e8b88d6430d8@cloudflare.com>
References: 
	<20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
	 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-3-e8b88d6430d8@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-19 at 20:53 +0100, Jakub Sitnicki wrote:
> Remove add_kfunc_in_insns() and its call sites in convert_ctx_accesses().
> This function was used to register kfuncs found in prologue and epilogue
> instructions, but is no longer needed now that we use direct helper calls
> via BPF_EMIT_CALL instead.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

I think that patches #3 and #4 have to be swapped, otherwise there is
a selftest failure when only patches #1-3 are applied:

  #281/17  pro_epilogue/syscall_pro_epilogue:FAIL

If we want to keep selftests passing for arbitrary bisects.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

