Return-Path: <bpf+bounces-62545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDCBAFBAAB
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 20:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8D41AA1A95
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 18:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A19A2641EA;
	Mon,  7 Jul 2025 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIblI9fs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF85179BD;
	Mon,  7 Jul 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913076; cv=none; b=oHpuzOZ/35Jj/w+bk6tAMGkQ3kIhcPz22YPyICkhhn5K0wOGYFVqUAJ4P0vcVAw7KEsxVEFOdCz5J6hkTIv2WDu9fj8zEM1vMvjxHc9dmhfqK6WJF3UiienIuDkTl0N8ok1uHU5d/s8rr+8+qT1ampgdL2Nef/qAEFO1SyicuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913076; c=relaxed/simple;
	bh=qWHB0K8NpuvWixt9RsTATh6y/dFCRIecq0TPdHl+x/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJhlxAhP484CTckhuvDuL9I8j65qqzSUqyx1HkRZ842uCYlMQqbCAPppXLvTVnJcV/17KvFxdQamPqaBjoqQpmtFI0fxUn0mZvBppwqmb65pYdhw55KVWIGPJwx7HdSH9gnmXLs/qzoOtrWSb+9iiFuoEF9rfaRWYrverk40ckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIblI9fs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-234bfe37cccso39819595ad.0;
        Mon, 07 Jul 2025 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751913075; x=1752517875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twRFGJkGSBKLOGT4N5zxWQWX1fDGmikH371IrFdEig0=;
        b=OIblI9fsgTNcfGUvKL0EzVIk5JROXZ5mK6xogYpLZvy5Ng344xu3GvHmtRYSbnoKuG
         cKacQjoKEupI9NM0CrYAqLRG4lhR8BVcbw5vX6Fwl5OyclLYAgNYqy6U5uB+czk5JmTM
         MO06qhv4atdphOFmlMkwS2JNmswq8II3oEyf56KaswzYbSgOFiRj2MH3zA6nIWK9omwY
         Id8Lxf7L7IoA4UBYhhB/OyD2x6tnXS3vtSvFSrFaMBFjmEfMoXGBz2aIXUWWzGvQEXMr
         HmRHXMV1gZiT2bginlCsBFkWTzXaXJOgV7R9h9x/0hXTrnyCI2eEJqwlYcgeBz/MmPZ4
         ASbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751913075; x=1752517875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twRFGJkGSBKLOGT4N5zxWQWX1fDGmikH371IrFdEig0=;
        b=ayRHOgJNzaJA8w0lHNJml9Izl8fkEsCOL+l5m1E+mGgw42Jq1RiacQjSkXJY4poBfc
         Fi3yClmjEbr2tl3kvFtz1P30jem+laBpOGcY2TasE9uQ8+pU3aFsNN04aaUhby3qL4D8
         QFTyK7rDyn7/cbPSMJI1yScVZL/3C9rrE5M7x8e5khdsRJ1W0i1KYWvvSaB4GMF3KSz+
         NcTpnTxQhpXNVtKu/bIHpFqLHtD5czvcdKbpW8zIfKd8ULkAncp4RLk4NAbJckvso924
         KebT+JZuBGc6Ra/HxkFfqWDFfbpkBtW9cPDLPp0ApHoDU1ecZWQIg1+ts6tFPfSwMWTI
         1cmw==
X-Forwarded-Encrypted: i=1; AJvYcCX+ywUfofq7+P06anDIJmtJL7PQYEI2VC0XF5YU6SRL0k8UiVwKEyKJmQUm/GZzi6OsgDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1clapOZWSaynTvQHTsD1c5dREphGUsUh6Q2u//uPAlm7eTraq
	yPi2UnwCa9Cu6dOZ7M/wGtfMmo+ineUqXwf3BsExTBcql6sbxd1PcQenemnO
X-Gm-Gg: ASbGncvp6F7EDYXCV0pZcFl0Vd6HbaobHbsEUx5VG5nOFTswR3Ht1Lmy26VqHgUYPBp
	EKuFEPx0zhjZqypr7dDyWla6e1hBYYpgPv6EDQNfWdGAHrEzRWsA8dZngkjpJGk8oqSH5AmjlCV
	ASlEAUqw6PatAFbCopva2PM1Gyua9pMBa6EOUEaCzyE1HKGfaSaT+lIKeo8h2nSrK1XGdIilInk
	BZvqR1cY2J6r/CXsVG/dP0IL++ahaaLh64RlvtLII0n4DBsHIPVNmFJNd/dyhDFe4OeizdJkAXT
	wT6Rm/Ib9NRctliMDOgvBTGNu9f7z7Fp/P0BmAn6Gul1ItVdj8uAOIkWKUj1h3fDVvThIwdGOJr
	ewUMPUjfyrnujTP06OUmpvT0=
X-Google-Smtp-Source: AGHT+IFmgrf54lNn7sG8M9DkiHFBGYcTivCVJ8GI+NEep7G/K2oWDmhipUkfiwtgzpK6ewJLyqd8zQ==
X-Received: by 2002:a17:90b:584e:b0:311:ad7f:3281 with SMTP id 98e67ed59e1d1-31c20cce5edmr829000a91.12.1751913074559;
        Mon, 07 Jul 2025 11:31:14 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b38ee5f413fsm9080054a12.41.2025.07.07.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:31:13 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:31:13 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/12] bpf: tcp: Exactly-once socket iteration
Message-ID: <aGwScU1nHA4PmDpq@mini-arch>
References: <20250707155102.672692-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>

On 07/07, Jordan Rife wrote:
> TCP socket iterators use iter->offset to track progress through a
> bucket, which is a measure of the number of matching sockets from the
> current bucket that have been seen or processed by the iterator. On
> subsequent iterations, if the current bucket has unprocessed items, we
> skip at least iter->offset matching items in the bucket before adding
> any remaining items to the next batch. However, iter->offset isn't
> always an accurate measure of "things already seen" when the underlying
> bucket changes between reads, which can lead to repeated or skipped
> sockets. Instead, this series remembers the cookies of the sockets we
> haven't seen yet in the current bucket and resumes from the first cookie
> in that list that we can find on the next iteration.
> 
> This is a continuation of the work started in [1]. This series largely
> replicates the patterns applied to UDP socket iterators, applying them
> instead to TCP socket iterators.
> 
> CHANGES
> =======
> v3 -> v4:
> * Drop braces around sk_nulls_for_each_from in patch five ("bpf: tcp:
>   Avoid socket skips and repeats during iteration") (Stanislav).
> * Add a break after the TCP_SEQ_STATE_ESTABLISHED case in patch five
>   (Stanislav).
> * Add an `if (sock_type == SOCK_STREAM)` check before assigning
>   TCP_LISTEN to skel->rodata->ss in patch eight ("selftests/bpf: Allow
>   for iteration over multiple states") to more clearly express the
>   intent that the option is only consumed for SOCK_STREAM tests
>   (Stanislav).
> * Move the `i = 0` assignment into the for loop in patch ten
>   ("selftests/bpf: Create established sockets in socket iterator
>   tests") (Stanislav).

LGTM, thank you!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

