Return-Path: <bpf+bounces-35295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFAD939765
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD88B21BE1
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E97525D;
	Tue, 23 Jul 2024 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBFgjZSX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B67F;
	Tue, 23 Jul 2024 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721693897; cv=none; b=Svl7B3WWkhEulAjM2kVNukxJK3g4UolFBmMs46UWwoba9+l+QICkFDhEjENdtXGYN0FHQzyVbFz4Iug5HPpC4V9RAeTDjcmtTC5H6yOUKXxN4WidlOaEfKsZz29CTEoi+1OCYFu8BLpXdzSgGkU3iIhMhwBp+wBCZyFvu9Hngp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721693897; c=relaxed/simple;
	bh=T/dooMdpXGESMhSu/ZQDAMWKSjgIvIUJdlUnMhm7mK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc7hSK4JRG8/43E8Rqs1sQk/bQoiZOMZtXoB3w1dkVq8/wtd3RiohR9cR4jEcoIZlMBA7NSAY5DobsDVPU07zRdBEfoPb7MJqZ6UO1qyVgotmCfpvLW3RtxW+A/1ZilKhy9FZdZ39FKeg/VCu+I/m1hWxerUZy2l6g1yXKC/uik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBFgjZSX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc52394c92so1658105ad.1;
        Mon, 22 Jul 2024 17:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721693893; x=1722298693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z/GUDbvYzJWAfHZbz27cut8vW/U6BKnv1xXyxFttHs=;
        b=TBFgjZSXasfNFNgY+n61L0jHRkbuVYhuz6HLCHNUdqfgf0RRFKy3vlKEfuRR4/yjMS
         T3BqI07pf+sUzrbiNUEgLuF+UjDlGaGZatgSSMrAjhVA5q38hioJfs/fxIYfTPH5n8r0
         wNzv9MTMJs/9lAKRlrWvfJf/ZuGGHsCgiLbs+0hjCLqPeRNvpbdjwWPPKPy0Dx8plbF8
         eOTCIKMVDAsuXjLSR6LUq+VaJNZh6PHCmDBs4pgn+QyKKyvr93tTjVxNfxmqYt8SG5ED
         wBlwRiZB47ome3Zt/C+2m7BSeOj6YgzBwo07BL854cC0mUR1KnunFKgQ0qE20IIZ3pqJ
         gnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721693893; x=1722298693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z/GUDbvYzJWAfHZbz27cut8vW/U6BKnv1xXyxFttHs=;
        b=bZVloq95gW+4xA1rMP49Kcf6uvdHHTNiv2b8cUvAB/OKFOTZGK4ZbK5DcNOl2Ggo78
         0AIVNOfufyxbNbTwbWDkXSULT2xoCRWW+moCNAzJ47cozzCPKdP5o2UWlHLdz4aupr68
         hVnFQ4GCXA4Z63iFQ6Oq0UmYkih63GRq4fAH3+z9dMuK4vt6G+Gn0LRz3JzLcHMHMO1j
         OwUQw2sg6rgTeRccZJSDUxKxGk8AIGy6XFjSkj99nmV0VrcdE/i8B+FM3SSEX8PftqoU
         uGuU6C8Se7Pa7dNIKDAyGnyA07ps//FWhgJcylP1da3mepxTeQvQEbXfOX+u/1016UsM
         zH9g==
X-Forwarded-Encrypted: i=1; AJvYcCUrPHcs0v7/fB6m+G6aD2PouLyfouP0/pMs1Y9YtZFyp4c5m4Bc7lLEqIyaYYt4ataYA1QzYKnLoojnfVXwgm0K4GsjuRIMepMijGbRWPOSNIawSc0AdsgNqnTy
X-Gm-Message-State: AOJu0Yx5NwsRZy9jZiystdPu149T76R7Mj9Wfntr7N/0uM0KmUaNZQTS
	wEuY8mFVbHpMBGtGR8xDA1HFRhfj+mkhrIjPMro+3SNaIpQ3lXYq
X-Google-Smtp-Source: AGHT+IFu2w2fZE8dCLe74W4cnqPmhaS6zpBT6HzYrKRIXXmdJESS0bt+Z8VhkyN+Gzfvencb5lyyqQ==
X-Received: by 2002:a17:902:e805:b0:1fb:6663:b647 with SMTP id d9443c01a7336-1fdb5f50c08mr15043875ad.3.1721693893239;
        Mon, 22 Jul 2024 17:18:13 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::5:9d00])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31a2d8sm61372595ad.121.2024.07.22.17.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 17:18:12 -0700 (PDT)
Date: Mon, 22 Jul 2024 17:18:09 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	jhs@mojatatu.com, jiri@resnulli.us, martin.lau@kernel.org, netdev@vger.kernel.org, 
	sdf@google.com, sinquersw@gmail.com, toke@redhat.com, xiyou.wangcong@gmail.com, 
	yangpeihao@sjtu.edu.cn, yepeilin.cs@gmail.com, donald.hunter@gmail.com
Subject: Re: [OFFLIST RFC 3/4] bpf: Support bpf_kptr_xchg into local kptr
Message-ID: <darbgv5izfcghfynr3efoo5w5slsa7kmwcsqpbrasa2u3u76bl@sm4zq2drkjai>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240719172119.3199738-1-amery.hung@bytedance.com>
 <20240719172119.3199738-3-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719172119.3199738-3-amery.hung@bytedance.com>

On Fri, Jul 19, 2024 at 05:21:18PM +0000, Amery Hung wrote:
> From: Dave Marchevsky <davemarchevsky@fb.com>
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Amery,
please add your SOB after Dave's when you're sending patches like this.

Remove OFFLIST in subject... and resend cc-ing bpf@vger.

Add proper commit log.

> -	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type)) {
> +	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type) && regno > 1) {

I don't understand the point of regno > 1. Pls explain/add comment.

Patches 1 and 2 make sense.

