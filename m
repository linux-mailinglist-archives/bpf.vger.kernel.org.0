Return-Path: <bpf+bounces-76688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F63CC1314
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 07:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E06E9302E717
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64692337BBF;
	Tue, 16 Dec 2025 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajUU8Apc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE6338594
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 06:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765865247; cv=none; b=U+/i6x0U9V333au+F2aQMnw707+POAa3rKlZ1YvGltPnvDD95dP0AsQBV6S0DQJlZKq/P1xwS/Uqjc/ngAjL29PUxR+sq0o2U6ynqBi83QOFWSIK/G9VeA5wq0rJK7sXgbjWphPgHbL5KCzARFY8yqBVq61XXMVwhIMtY/fpBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765865247; c=relaxed/simple;
	bh=j8tHbgh6sMbuf8CLYcBbbfNvN7CoH/WWFH6BqIPVObs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUCuVy/B6mUzTCLQbZTKvDKFb4G9lsGnArFI7WSr0a+u6EY7Pn+k3BnjixT/nJUren8UIoS8mDYlUySbC65EbAuojFWCdF7LkdRI8eOXI6WQWc4LWjoRnfWPYKgUiJ8euLf6ynJpDn2Mwyl9v20BjE6j6Q2aV7qK43pdbmxZNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajUU8Apc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so3027335b3a.2
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 22:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765865238; x=1766470038; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2VxSD2VA4nAbIns+0GZj4QRJDG/iBDFgYQC3bPZe6qI=;
        b=ajUU8Apc/1M3rJHWcSyvxvIs+pXu1oaFNOr/mc+4qNfu/v2Muxj9BlSXC+NxRfBULI
         snjM+p4kZUTpZpvPzQwii6zPyFfdsYFuBjP2K1H6YPS2FYU+e/4YtndhNUctZ5B/dp5P
         ahkBgKtdzQ03KYNFsJsbqdAXu68epdgZny8tsdWbhY/DkACKHFR9gmCzqla5lZCf9oPT
         JibzZKIpmVIOm44AAsOCEAmzhinaeE2H1ceOwKEjhPgE6eLfs+BQWFUQQptPyJ0FuTY7
         pXY4h7D01tqKO06NusttOKt/sOGVhHPjOpIgHDJ2bfqE/tBzf4TkpqeOhFenyGzwaLmr
         cj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765865238; x=1766470038;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VxSD2VA4nAbIns+0GZj4QRJDG/iBDFgYQC3bPZe6qI=;
        b=FGoCAcBQfTb7GShKlMFEAtsvk/jEmyY3+D2QGLE78EqKoRFCK6JmI8S27+33ba7xcX
         UVaysX4SsJ/xyxqRshBqlsghFxEKEvXdasZMwllikpn3+2CbHIXLKtyHQHPyKD752ATR
         lDIqBHRolLEwDMzDJRJHoBtz4ehKVHLXyzVuuAHlpknhGORSsycMg4/A+piMETi4IZv2
         SC6npgeB6Fogfht1eZv/tT07C31fBSJS/zJbMJ4CLzq7ybdfXBnla8kJvMd5Z/AIiCm2
         qFkJJs1OYZdMVhNhAsSysztoHoWazTsDzoc8XLO9nflG8kO1uSjKUHiAo8odzt3j8TVn
         bddg==
X-Forwarded-Encrypted: i=1; AJvYcCX64aUCgD/SdeMWKZGuPw6DsNh7q0+0HMVE7Lnp81bCkTahD4tZlSphKGA9iLjFaKzi/dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy04GPE5rsI/kGKPQUDhlxc7Z0UDMr+suMXhe8A2RlTB6aFDKlU
	W8LqAga34Y6ic2Dola7Z8HWJJPd/If5khxxVhpBgDunMStgHefQThaVG
X-Gm-Gg: AY/fxX4ABHVibnQ5zlZ6ExH50DIIH2tqW8fXkeNB6ltdmGeddGCESPWkRlSElcnlGF7
	w4OPbii3YJjotX9OKm5oqxsau1QrVh/BfpBPLrTbe4tI0SIbkFblRR4WMK+EHSji7prKDn0zk1B
	jcEquXAo/8xxCYEi09Wqz7UMNjzvfWWJzVLCu7kbNJuys4kAWJsvu9X2wj2vKH5Z/OP6qe13q8i
	VbGRb01yQ4y/lOmfthROs+8bjh/tT/1vgaPfWEwYFYPmya3/KnH+B1DY2s/3lPt+CQ+GM9J5m8f
	ngRJJGQMExf6LpqZhNLps0L6LBoR/Y3KFBJdJE8TekGHBgDvUkMrtsTQw9OPkhmNHfoeyTb5c1F
	xbk1Iv7A7uZn0aD1CBBLXX08IZ+BQqkyJ5Nf+OyWO2zO+ra+d84OVnihyhLbfGjTzCUNa7GGKEW
	zDZ/M8ojYCE2LsELfkjSM=
X-Google-Smtp-Source: AGHT+IHY43b2UFhQc36nFFe5wG0gcwuV6X4l8YdEG84Og8ORlNS7EtzWH3syDhfMVz7eTZI/94adEQ==
X-Received: by 2002:aa7:99c7:0:b0:7fb:c6ce:a85c with SMTP id d2e1a72fcca58-7fbc6ceb799mr673561b3a.6.1765865237755;
        Mon, 15 Dec 2025 22:07:17 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c237f2a5sm14177476b3a.13.2025.12.15.22.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:07:17 -0800 (PST)
Message-ID: <9e1b071598f9c1c1adcac0d8cb2591c452a675fd.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 03/10] libbpf: use kind layout to compute an
 unknown kind size
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Mon, 15 Dec 2025 22:07:14 -0800
In-Reply-To: <20251215091730.1188790-4-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:

[...]

> @@ -395,8 +416,7 @@ static int btf_type_size(const struct btf_type *t)
>  	case BTF_KIND_DECL_TAG:
>  		return base_size + sizeof(struct btf_decl_tag);
>  	default:
> -		pr_debug("Unsupported BTF_KIND:%u\n", btf_kind(t));
> -		return -EINVAL;
> +		return btf_type_size_unknown(btf, t);
>  	}
>  }
> =20

That's a matter of personal preference, of-course, but it seems to me
that using `kind_layouts` table from your next patch for size
computation for all kinds would be a bit more elegant.

Also, a question, should BTF validation check sizes for known kinds
and reject kind layout sections if those sizes differ from expected?

[...]

