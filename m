Return-Path: <bpf+bounces-37532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B1C95740B
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 20:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D0C1C22899
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 18:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E451B195F0D;
	Mon, 19 Aug 2024 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="My9cvnFp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9A195980
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093884; cv=none; b=f81bBnBINv0fJcg/Yh1RIzOdsbcLTiNqcjbZWVQnP7ouayCOYS2Mu0rvMdSbjAhvUaeWCYrMXW8yqvmcUe39Hal69PBr56uyZj3PDi2ajCHKJzu30hoG8taTRNU/9xpWZKiLHofZa3v4Npj5GSTFOa5o1I/LzDNlfKuYUM4cQjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093884; c=relaxed/simple;
	bh=HXg8/PpMN5XE4eV80NbtQl+bngeaV73fuV09gUuIEL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBM8R7VMgD+V9/6lCdPytn9PnKIDeQk6MST8WqBB09tSK2rQOujSHCOwxX3k17rIXhX49WxeciwisaDwHlodXHfIZfz3VJsMdsqY68nXaCAgoEEoiD4oBgE5ZYIrXj8RF/PtUKguy6/jh+AqtG5prS+poe4k/fyzXxdhjR8EPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=My9cvnFp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-371941bbfb0so2208205f8f.0
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724093881; x=1724698681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WAHg2o4IDnHG+7p8XV9sb4LZAyRFbuyoMemjAFEA5QU=;
        b=My9cvnFpv09CPd9GS5tug+VFhZhwBqkedlKFZbMpF+dJzuw0BTAtOtLq2e/6Q8Rnsm
         vRch1v5zF5Tw3O1Xn1cdM5FbnAcS0PARtOvQNW9gF+Yug1UU68zLYUpfJF9R+DCFnNu8
         Wbjkv8yM+0OQMe1zcnlWgag0kC0GZkobxG3faw64m17gZ/7pPhHodRyInHn3waK70iN9
         GllzH7kdogbyqwX3t78ZN2ZZ5HVRVf9W8OlSAHbN/htjqbJlba33peEWSP8iofOCHBRp
         1foFp/goX59I84PRoRApImx1ZyCZTd4u3NOWrhWkauPzA5v/rwI7oSFB3oAjv20KsZ+L
         UfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724093881; x=1724698681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAHg2o4IDnHG+7p8XV9sb4LZAyRFbuyoMemjAFEA5QU=;
        b=XaSiCs2SlwzbgqtakLefj3MZmU9RVcNRd26FwBph8f0F8CezveSOU9lzhP/Ata6KmB
         aO1dpG3xdzBNW8IG0Buh/p8KW6eukZ3yaytPU/Utenmdx8nrm6S0JFO9okvGEVfGI3LU
         bHrSQVCtovdFxBDFLBwLUIC1w2aKpib6be7OyhlASN68QGWqa7iTZeUCJr78hXuTKeCw
         lzdKKYnprujaaimkTPlwQOydQr11cmMLMzRptv4MwIJSnveDs0g+teo3VwTLLNNX4P42
         JybEYV7KIo9Sg6cRPXWKYD2/6LBLF36K9UkjwCLvVw4VSYwm87yvfrJQd/lMY5smpLQo
         urqg==
X-Gm-Message-State: AOJu0YxTAEvd8P/4XeXvZXUtYYU3rUbHUZRfH98PFGPbFOBVMdWWk/ER
	z8Khhz/0U/vtw+Cb0FLTB8ZzK3LXl7SFyQtCaJ9VJDvtxDXtVn41YyDq/CatevDCABwJUuPOHtt
	5MWA=
X-Google-Smtp-Source: AGHT+IHmI0QktHjn2ZLoxVK21eMUNrbscY0ivx9Cv8Op3ThpCSX7v4cx/AzlptINQN9JZEABGfo8Bw==
X-Received: by 2002:adf:f084:0:b0:371:6fc7:dac1 with SMTP id ffacd0b85a97d-37194698e6fmr7573504f8f.61.1724093880678;
        Mon, 19 Aug 2024 11:58:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfbb29sm5841254a12.48.2024.08.19.11.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:58:00 -0700 (PDT)
Date: Mon, 19 Aug 2024 21:57:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [bug report] selftest: bpf: Test bpf_sk_assign_tcp_reqsk().
Message-ID: <a063a534-0ccf-4192-a15a-732a73dbcbd0@stanley.mountain>
References: <6ae12487-d3f1-488b-9514-af0dac96608f@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ae12487-d3f1-488b-9514-af0dac96608f@stanley.mountain>

On Mon, Aug 19, 2024 at 09:54:00PM +0300, Dan Carpenter wrote:
> Hello Kuniyuki Iwashima,
> 
> Commit a74712241b46 ("selftest: bpf: Test
> bpf_sk_assign_tcp_reqsk().") from Jan 15, 2024 (linux-next), leads to
> the following Smatch static checker warning:
> 
> 	tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c:493 tcp_validate_cookie()
> 	warn: off by one 'mssind' == ARRAY_SIZE()?
> 
> ./tools/testing/selftests/bpf/progs/test_tcp_custom_syncookie.c
>     462 static int tcp_validate_cookie(struct tcp_syncookie *ctx)
>     463 {
>     464         u32 cookie = bpf_ntohl(ctx->tcp->ack_seq) - 1;
>     465         u32 seq = bpf_ntohl(ctx->tcp->seq) - 1;
>     466         u64 first = 0, second;
>     467         int mssind;
>     468         u32 hash;
>     469 
>     470         if (ctx->ipv4)
>     471                 first = (u64)ctx->ipv4->saddr << 32 | ctx->ipv4->daddr;
>     472         else if (ctx->ipv6)
>     473                 first = (u64)ctx->ipv6->saddr.in6_u.u6_addr8[0] << 32 |
>     474                         ctx->ipv6->daddr.in6_u.u6_addr32[0];
>     475 
>     476         second = (u64)seq << 32 | ctx->tcp->source << 16 | ctx->tcp->dest;
>     477         hash = siphash_2u64(first, second, &test_key_siphash);
>     478 
>     479         if (ctx->attrs.tstamp_ok)
>     480                 hash -= ctx->attrs.rcv_tsecr & COOKIE_MASK;
>     481         else
>     482                 hash &= ~COOKIE_MASK;
>     483 
>     484         hash -= cookie & ~COOKIE_MASK;
>     485         if (hash)
>     486                 goto err;
>     487 
>     488         mssind = (cookie & (3 << 6)) >> 6;
>     489         if (ctx->ipv4) {
>     490                 if (mssind > ARRAY_SIZE(msstab4))
>                                    ^
> Should be >= instead of >.
> 
>     491                         goto err;
>     492 
> --> 493                 ctx->attrs.mss = msstab4[mssind];
>     494         } else {
>     495                 if (mssind > ARRAY_SIZE(msstab6))
                                     ^

Here too, I guess.

regards,
dan carpenter



