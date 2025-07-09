Return-Path: <bpf+bounces-62843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF76AFF4EC
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 00:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1E9487CB4
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 22:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272220D51A;
	Wed,  9 Jul 2025 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="a8++rV5L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3D72610
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101242; cv=none; b=SqSluqXiz3q6ZX6/6M2TkKDFC3yPSwMSKv9huqEByqm0RgZjXscmwbEhsmc01Ae7AtZ2gx4htaCnb/MFmRU1om8UU6wV8l86FVS4VWWy5jjIalyL80+ZEJt0A8TRCgp95ZaYZ8Qt9HdUSdX1DU+yKIvreXCZT+7BxXdkmzeo3YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101242; c=relaxed/simple;
	bh=AMaPsBU1Rytq76Zm2TjETV+JkYTEUFlnbtQxIT6kLFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQAWuQSFodvJjg73rUh5lKXVqv8MVw7ZcXWXWvfdur8LMxwd6ryuZD/n7GXOc2mkBhJNmlQluqLtk7EAfcTS/6ebih0z9qdpAPOJrleT6dPg8YJDUpZsjSCRrAab4NjJ0kpA8AUc8mhBsdZ6mETtgzeSkh5RjBwupD57oFpP9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=a8++rV5L; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23de2b47a48so601335ad.2
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752101240; x=1752706040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWivPj3PrSHsIYwZQr86vF7NA1uo371elH6TQuADgAM=;
        b=a8++rV5Lp/Xo8UIWEhBLJWsgGQaLFWwgd80bY1wc3oiBkAQrrICvaAG1I66kt9Hu+a
         UVFu0YDXgZuC9Il6anx+kjWlUMEDZogDIkPKi3PizYHuxhToBWQksYlBuv1wocRfXmrM
         HG4LkpV3A6M1n4jr/ivfcKrAKBA6SEkyBj+B0SY4LaI/WT99zm6Y2Lk8RKptNXGG/KCu
         YoG6QgWG2wTlK2q3XrQXEV5Qqapl9haiuJM7x5+XQUQcr1sO6JFfLl0nUHVH+1b421Yy
         crk2DpioELWa4dHXygCDJfAVN9RA4ie4Os8STbxy+Jg4eGndme6LweO9CBk6r4uITB29
         excw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101240; x=1752706040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWivPj3PrSHsIYwZQr86vF7NA1uo371elH6TQuADgAM=;
        b=XyNVs7k7lEb8Dxaw4sma/Wtwz5rSkh4u5bi+ofyH3lZa8/YnpiRASOdZhK+QZIp5XJ
         Apl/QcE0N4JvHQzNxKNVtoTW2cKDNwdcsf2OCqylTVT5atv6lL8uDYAgiWuJn6413Wkz
         CPxduZAbWiMyTGYYccFKAlkhS9SByOzLljK/R8UZ5Uov7ktjuC/gBpx7ROjd5KKnyop+
         PFf7OyrNarCRIraYy8WmryFMUZrKKZr20I4HCXo3UlBhPaAzQNdV9l7TtxYdDMSABp5O
         A3zcVG/o2TP/2wZ8s7eGED0TsUwmRVpdkPV3qynax/w+sbGQM6zZ6zOhkMlAqnQmx+h1
         CrYw==
X-Forwarded-Encrypted: i=1; AJvYcCXMugz1NYzrhJTZzKvQFoCk2RwCr94+PrDUMpnfSeakFD1Sdm+DcXpz0686qpJyZ9az3mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygrgrkmsXJVestz3Sd16eEmeI2iwp99qRJNU+Ay2YAJKP3oGHL
	bQ1C2kFRc4SIDsVRqK5l+MsAbGY261v6z06AfIYzKNs7Wv9Np/HENbsY4UCFS6Ms5MA=
X-Gm-Gg: ASbGnctquY965ZhscH7fsOKSy3VzsHTY/fsoEAKYBFRObHCJrU+tb8WKZDZ+VY6GdrB
	sodzxB0rc20LrhJcf7tiHPqdIGE3V6Uyq/aP4Bd+rAYeoo/9Ra1MlejPOTLE+b6FhdZszrVLzzy
	P+vg4fAToepkqLZkgUzZ+R7a6jW3Ix3D2KjUoZSTIkkG+cJXNnpT51/UCayg+FqwRSlCFASi3D3
	cVEFNll6fo1CU9SXpfCPc2udhPK/renb5IJKJwUBGIBkdlhlXlZ8/Z6LQgtPoFETw66PPM/Fx4+
	XXCk6CAM86WUQmy6dPFLInfiF5oBIbnK1CE99dslIN4Oa/W/
X-Google-Smtp-Source: AGHT+IG+jFSgnEs0JKVW6bWM0FSTTQ3Kxvyr4KC6UVatwmTVNDlUrpa+OBZO81/1NzOVVRO3JRVgqw==
X-Received: by 2002:a17:903:2a85:b0:234:8f5d:e3a0 with SMTP id d9443c01a7336-23ddb19ae97mr24400685ad.2.1752101239974;
        Wed, 09 Jul 2025 15:47:19 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43411c8sm2406415ad.184.2025.07.09.15.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:47:19 -0700 (PDT)
Date: Wed, 9 Jul 2025 15:47:17 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 12/12] selftests/bpf: Add tests for bucket
 resume logic in established sockets
Message-ID: <yyng5hf5yvak3vnelrsxuxhmqyefqehfzz3lbprxrhekwzeaih@brqs42cp7fd7>
References: <20250707155102.672692-1-jordan@jrife.io>
 <20250707155102.672692-13-jordan@jrife.io>
 <3c3a1640-16b6-47a8-b1a3-a90a594885af@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3a1640-16b6-47a8-b1a3-a90a594885af@linux.dev>

On Tue, Jul 08, 2025 at 04:44:50PM -0700, Martin KaFai Lau wrote:
> On 7/7/25 8:51 AM, Jordan Rife wrote:
> > +static void remove_seen_established(int family, int sock_type, const char *addr,
> > +				    __u16 port, int *listen_socks,
> > +				    int listen_socks_len, int *established_socks,
> > +				    int established_socks_len,
> > +				    struct sock_count *counts, int counts_len,
> > +				    struct bpf_link *link, int iter_fd)
> > +{
> > +	int close_idx;
> > +
> > +	/* Iterate through all listening sockets. */
> > +	read_n(iter_fd, listen_socks_len, counts, counts_len);
> > +
> > +	/* Make sure we saw all listening sockets exactly once. */
> > +	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
> > +			       counts, counts_len);
> > +
> > +	/* Leave one established socket. */
> > +	read_n(iter_fd, established_socks_len - 1, counts, counts_len);
> > +
> > +	/* Close a socket we've already seen to remove it from the bucket. */
> > +	close_idx = get_nth_socket(established_socks, established_socks_len,
> > +				   link, listen_socks_len + 1);
> > +	if (!ASSERT_GE(close_idx, 0, "close_idx"))
> > +		return;
> > +	destroy(established_socks[close_idx]);
> > +	established_socks[close_idx] = -1;
> 
> I may have missed where the fd is closed,
> does it need to be close() first before assigning -1?

Oops, forgot to do the close after I replaced these calls with destroy.
I'll add a call to close(fd) at the end of destroy in the next spin.

Jordan

