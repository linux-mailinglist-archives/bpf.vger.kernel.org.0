Return-Path: <bpf+bounces-72298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAABC0BF0D
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 07:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE90C18938D1
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 06:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237C62DAFA3;
	Mon, 27 Oct 2025 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAAZPcQF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CFD2D8363
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761546210; cv=none; b=iXVhC/is/AFe5VzY6JH8UhCNtYhqdIiiczMoZw4PqO1GaeM57Hj5A7Ls9UUxSCjFsAZN9Q0y7W2TkcS1NPcTpEbUif+iOFLf2kgE48hyqs4i4V/6DyTelHZeva0yTv2IWuoVupX4B2r01Q63alMQjSAX4yg5aXxHKDTsVTo45NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761546210; c=relaxed/simple;
	bh=mZ9YelO6165knXext8VuZm3RWKojnU1SdbLPRp/9650=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6iEUQANHsgdEtxkpPj2YN5ta0ep8Ofl53qnRsegKHIMFlndCghywoOm33PcOJ/+mGjDoRFaJGXd8rL9spq2wMlCeZu/Dt3rP+pDPPaxiTVvCXbCALQkwLan2NeytJMpjDD8o7k9Z1A55H+Fhjpr+E88sTpfreUhsuXCB3jhDs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAAZPcQF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47118259fd8so30534025e9.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 23:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761546207; x=1762151007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dl+OitTVo8kJF6Q+w20ADFJq5rO2vSsKujVL17LyC+A=;
        b=dAAZPcQFKiT2jGLusZ5bkfnISQlimPk8p/FXKFMIY1KJPjbIwoF1VU8hdgdEQ25EGI
         hwnzbKbrmk4ndMXCGVbnaH+8elY7xJrlFYSmkyibqrUTzgZrSTV93rlw2MpknOHBbqsF
         SINvHuqxzyVUq5+fOCbVTBBF02hoeOWkqGBdpEMwGUpiHZ1OgsRb+ehxhL+1dRnaq7Xa
         i4UNWg9Ucg/NB6PRO7BkfzGiZzEdkXHwJ7Wa8YMaKCtpR5OxAgaxEUOrAjzEeOCkOr1z
         YfJzLNp2K2fX34CeKxvVSUu0b5YY0WB9kx+WDU8kFeO27jE0H5YK42LRfBzOIcSQixb2
         ntQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761546207; x=1762151007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl+OitTVo8kJF6Q+w20ADFJq5rO2vSsKujVL17LyC+A=;
        b=gYXydGcXYcemkGZRZrJi7EUjpIbFfiZTj11PcbzpDqzMasm5XzAo6T6q4aTuBi3GkJ
         1uqd+BId3V8favBYY9HTNfV7zEfcZKODIyPchmEfiZzjYYbPu9J4DaIszyy9xKvS2olM
         0Ov/ikg5QRHxlcWyWlUfwGZDltu6puc4eCkWT1C/+ohPrtwWhGKHP/7jpsnmJ1igb7e1
         Ubmsku3f8hMeCQQ3AyL+eGHKzwpup5m0C7KObZSysQcKI/0t3VMASLjiS5epgWaYGnsN
         OGgeD1GZeOIwDSOgWIhu/L+aeF1gq0les59QSc63JqzEsHipRE5ED3UiWvoposW2yFJf
         Vqqw==
X-Gm-Message-State: AOJu0Yy/Ebb6vpRZNvlw/l6Y36s1IJWHFms2r1ObvUgBPqHzYV8wduUw
	LehnEwLAnhy8IyFHJYBYJRbmwIlFyR2HedKvMJu1DxEJz0Y50GOnYUa15jGBMw==
X-Gm-Gg: ASbGncsLEeXEp48lga/D6mAfL9s7FPfu/3mqUeKuBdOrKosWk9kFB3j8cYoJMbP1s+6
	n93jGa1DRB6897L8R1SHC3nkNla0VtqVN6P5FzQSzJxHKdWd3AN+M9enoF4xaBOjZ3V4Z6wzZY4
	9tFhAQc8ZlLVKxQ18+GOLWfBCAI2QAPR0oJTm7A4B5yLBENHaJ0JA9pgGv7+vdyDaJiVgydY+QV
	RlLbpqVRx9Ge6b9ypTKjG1OQHgtw4eeVuOe3Etb7bdozmiP/+fN9zatpfdp1AkFPetuYelfIXod
	Te6j40iB/1DKsV5/rVTQbmKnGc+UvuM5cV/KHn92wSJJTk3zHctTj6e4W00CcZGy8/G3KTD1EHK
	cNocxwlDA+pl+/BeZHZcRqJI4gfUIvFYvg7Fk3jLLYAZbRgGY2p3uHG1DxxisB5xDZTFEstUBhR
	iP123AucK/znboQyAVz6c5GKqpRYitu00=
X-Google-Smtp-Source: AGHT+IHKYbrPRX7P0kNBXKBNwy56GGTNzPmbEfWoaK2ec8L1hJBZBermDNZ2r0wyV4vlqI55Dqj8Dw==
X-Received: by 2002:a05:6000:2008:b0:3ee:d165:2edd with SMTP id ffacd0b85a97d-42704d78cccmr23583631f8f.28.1761546206673;
        Sun, 26 Oct 2025 23:23:26 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddd0d372sm57894105e9.4.2025.10.26.23.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 23:23:26 -0700 (PDT)
Date: Mon, 27 Oct 2025 06:30:05 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v7 bpf-next 08/12] bpf, docs: do not state that indirect
 jumps are not supported
Message-ID: <aP8RbSt24kiPQId8@mail.gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
 <20251026192709.1964787-9-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026192709.1964787-9-a.s.protopopov@gmail.com>

On 25/10/26 07:27PM, Anton Protopopov wrote:
> The linux-notes.rst states that indirect jump instruction "is not
> currently supported by the verifier". Remove this part as outdated.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  Documentation/bpf/linux-notes.rst | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
> index 00d2693de025..64ac146a926f 100644
> --- a/Documentation/bpf/linux-notes.rst
> +++ b/Documentation/bpf/linux-notes.rst
> @@ -12,14 +12,6 @@ Byte swap instructions
>  
>  ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
>  
> -Jump instructions
> -=================
> -
> -``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
> -integer would be read from a specified register, is not currently supported
> -by the verifier.  Any programs with this instruction will fail to load
> -until such support is added.
> -
>  Maps
>  ====

Here the BPF_CALL is mentioned (thanks, AI).
I will drop this commit in the next version,
and follow up on docs later.

> -- 
> 2.34.1
> 

