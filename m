Return-Path: <bpf+bounces-72274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5112C0B2F3
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B533B6141
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171AB257830;
	Sun, 26 Oct 2025 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKZUP2Yv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086FE1A9F9B
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510871; cv=none; b=IQmHlJrD0bw5rHR4SD4WhX/I2gPSHBd7utcRWKl9mJn1/cC+4u35FkKxiWtz+Azsfi0U3Rijov4l1NPG9qJKsOCf7TUCku7edco2Twe4Ixux4t7sF2g3HQuRi8A5RKbggnkp2R6wURDd07S8Gecvee8Tqf865mRIbFAFm8ACg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510871; c=relaxed/simple;
	bh=IBr4zDYE84hqXDPs4/YA66rB9iZHkZGb62/MPNO+AY0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERHjca7j99nDra0Ok2lW2P+2UiXsErMlGLzDaeDJDBuqz1mccyraork+ZlB9xj0cpQDltBrOmf3u0FGoqlBi0tUVYFa5sNRX8LE+essp96LfzwPlve4NxzmI4iU0U3djze1ItI7B68zo/TWW3Idc0Xe01/FxQoX5prEMVlCqG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKZUP2Yv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so21363845e9.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761510868; x=1762115668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXiRrT6KDWwDGKILK+9lG6sIkrxhLuGRA3Y4Nk3P+5Y=;
        b=PKZUP2YvSj8goR2zBwSWAqkOIzoxqPp0/dXktumUM0mkS47pgHrJ+c4Krl0GG2IXBI
         NxEaipT3eRe/8yDDV5RYci2iVG8LeBNRBNqhj5OIyOKBv7dWOXmTLUDPHNMNNDutxnNh
         rd7pKtgP3dvPH91OFJhhoW3sSzfX/IWFbcB4dPEiHZlYO+qVUQe/9yFlYekuaN+VirfJ
         JGA5vNpB1BtOWqNYqaoDLIjaVh/Ta0P+r+ySFkqi2lYgwyFmGssX5orOPg9jSrz97LS5
         07gyfOI/aT4dooSqkKj2imOWDw3Wy6+Owh6BBH1kjLDUAxmgMEgZovMx47V1G4GGQC5/
         3WKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510868; x=1762115668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXiRrT6KDWwDGKILK+9lG6sIkrxhLuGRA3Y4Nk3P+5Y=;
        b=rc2Jt0TkToGCDabCoFuZXWCFcCtoCY/mHZqAZrXw5oH1jnvvbw7UGA7pd09T6Ha/hu
         fiey3B47HsaPcbRD57Qjs9WGOwOr84PFBszPjjKaIn3T3+YpjqvC9KRNvPd3e8+mv8SL
         JLR5EUwfkvud7aoLIvi3H6GQmZn/t1nlxeWqZbI9Oj6qLJi4ecATw/N69pBfVWPZnS+h
         gonQaEVaJkTqYW/W/YibhHhi3rUWXJ8tjnU8kV+7OFE45W3T4MGr4eEMteRDzUic5HQT
         G41EMn3dwyvW9Apyb9Gh+BKmNRXZ7DQvPkWgq8ghmK6taBZMUNomKMOGt9VGN4V8rsMJ
         oUUg==
X-Gm-Message-State: AOJu0YwCURB/DCKX8HZK27h+ewPPTuFcrokIvFkgR282faumYUGD39qK
	V9Q1U0en1AvB2/GvJE5W51OJGtalor+kYc8nTGjuSSw1KJY2s8elgvbu59vwDg==
X-Gm-Gg: ASbGnctGhMElPh3nMaxCilubvjrxlokr35RMqHtxYw8kxo7Ju+k5ID8g1S2M1qAa6Jf
	fOx7M/2ntbQiJOaYMKYkQXFEfAjHgj9I3G7bESa1JbKd9m8U3WH+fFyCSSKweFQfqPAhtE/bYl7
	9ZjLsx/ndDN6BPRp/+96DwTWCTpeNYCG8sK9RpUQAcx1uO/2qA17yyFXJ9dpZKTEhh09vWrtqo1
	f6LqozpCpzYGZ0uFzuuLnkQi8j/PHos+a4PmZjrOMmZK/IQSsscB2MnAToR/E6Xm5u0KX68kUOO
	n4JBP4Eg1rPteS8jYIME6PC5rdEsZtZ3ylrwVGeuoZmwjESH8G/uYV1IPFJimef+GPzZT34Zph3
	idJMyK3S1UpUFWW0pycMy2O1MpCv/PWWZRnj+EPNWN92mLI7JyuMW79xiovyisaYHHGOLuH63aR
	njkMEMvkP01Q==
X-Google-Smtp-Source: AGHT+IESwbuJqvFxIDIObWx02+k9UfbYAKR1qzo30EBAOfUgqOu8AzVA7XZFAOE1W1GnUJqyVwMlQA==
X-Received: by 2002:a05:600c:4f89:b0:477:c71:1fd3 with SMTP id 5b1f17b1804b1-4770c71219fmr27360705e9.28.1761510867912;
        Sun, 26 Oct 2025 13:34:27 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd035dc2sm98102525e9.5.2025.10.26.13.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:34:27 -0700 (PDT)
Date: Sun, 26 Oct 2025 20:41:07 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v7 bpf-next 06/12] bpf, x86: add support for indirect
 jumps
Message-ID: <aP6HY/xewvV6FvDb@mail.gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
 <20251026192709.1964787-7-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026192709.1964787-7-a.s.protopopov@gmail.com>

On 25/10/26 07:27PM, Anton Protopopov wrote:
> Add support for a new instruction
>
> [...]
>
> @@ -17823,6 +17851,197 @@ static struct bpf_iarray *iarray_realloc(struct bpf_iarray *old, size_t n_elem)
>  	return new;
>  }
>  
> +static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
> +{
> +	struct bpf_insn_array_value *value;
> +	u32 i;
> +
> +	for (i = start; i <= end; i++) {
> +		value = map->ops->map_lookup_elem(map, &i);
> +		if (!value)
> +			return -EINVAL;
> +		items[i - start] = value->xlated_off;
> +	}
> +	return 0;
> +}

AI said that the function here can copy a INSN_DELETED as xlated
offset. This doesn't look correct. This function is executed in
check_cfg first, then in check_indirect_jump. And the INSN_DELETED
may only be introduced after the verification is done in the "remove
dead code" or "remove nops".

> [...]

