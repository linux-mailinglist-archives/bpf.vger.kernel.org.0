Return-Path: <bpf+bounces-65976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E41B2BD37
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE9B1BC4D3D
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E27C31579D;
	Tue, 19 Aug 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="E/SW5yQZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5758730FF3C
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595210; cv=none; b=onX+rL1ZvrYRu7vLXd8ATseGHL6R/Yc1k+XZ3aI+jP6ltOswyuzCGt2bP06p3awXOMQiv9boENkNUeLFMx+BIPcfdHkaaYUQksKcWXHpvA285sf5nVArt9YVM9mYXkmCZB8zZ5QbPFzvST+j6GclqHX5SEPMxW7frbAZYcZJ6Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595210; c=relaxed/simple;
	bh=TxdvJ2aZ0MrozZpw19NlbIeky5ylu08W5vO3L2sBGzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JRwiyshJ2IpESlwkOh4XP1RQMdOZWrVKN3horIWYWYnRGteZMPI5Wnrzo3KMJx/MfX+gd8NXKBD1HmoTRuMB5rtdCJr/qQtyvB7SS7IyRPq34oKJabLH5lXtOqJuxmzji1UmaoKlhTyStN4bH7Gf6sH7ylEYvbumvRkylzCjdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=E/SW5yQZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb73621fcso587316466b.0
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755595206; x=1756200006; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2fhGkQqGm9GoaNDXa1LIR5YVmq5SQbq2OoJ8u7LltE=;
        b=E/SW5yQZemSNYgO1EHq6rSOVwWo0JRkcZ5riBKK+dK7pEty7+GPiDx+66sM0ypVTyM
         6Q8pCAagycK3tdxvmxxKkIe9XCJnbZry/SAgJjwzJ8HxPmIjIFVs2uhDM0FFskv332Jg
         wIrwkkc+S0fOV55BcSKvSxlfHMEtZ/llx3/e4mlCHFHcf6JOBcoZccw2h8Bmiu9D3drc
         2O7HoIrZq2LZsfQfGP+oVvOAJJKY5qIl6KhOXtD5N8A5FgziHl+wxvRumL7g6W+bS5nU
         yOXZvq/R0iYRDSpFw7QCfDvmzwzkZCQOHFSvWll7zEP6B2YQ5n5TO0Z1cRVe2Y40JzN9
         DhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755595206; x=1756200006;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2fhGkQqGm9GoaNDXa1LIR5YVmq5SQbq2OoJ8u7LltE=;
        b=OXXbQk/ooB9MGRvOt9gKfGSpKF8tT/4cPsZgBv7uha82f6idrqDeQqHOpWg8BYUhTb
         37Sv0u24eAZtIu7OdUbR//qX6pvICOrMWTl/kqeu+5xAMh99uD95HbUtYsgjas111YEr
         J9eOb93KG49agove5DqsvegEGmzFJvsJ+/mogVFygWFwBQjrqxoB8qGJkNTZPg3sPfzU
         b+saCqqbjnnZIJubGpwjtTfNCWotoR2kb8H2s25rauxw6N5VP3pcZL+aXOjSqgc29b8L
         GgyrchVx8PtcmR4AQMGmUQfRHwnxb/yy0gXAzoWc21ZUN5zFe5X4fRxq+RkLay7jIXbJ
         TrCg==
X-Forwarded-Encrypted: i=1; AJvYcCUHxxYfy4FSlYuLGWh2ft4L8R0+DDcJYU+R52trQtW/tb3MiBANKjLW1VSCx5I3PuBOrjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYf5E841cwQpJA18wbtAeHfpoolibozeQMFNW/3L8k4GlLDd11
	EraaOkTLB7HcRZMi628rjVODHSV2/paqZvrfEZXytsOBqVj1LBrRIJsdfdpCJBNCcaw=
X-Gm-Gg: ASbGncvwV5SFIA5DK77r7U3+SuZaZUwMHtdAc+4LoiEUEzMOal3GGzTBDUwZB+UziH3
	2T90Qct/EOvakA9DZQNF02auUllvrM+6bhUtX1kdSJiVHOWYUHyRG/XJqEZ46EP9dq6fuISrtb8
	+S5HfVK91rRstsNQNVn/n47Bgs84YPKYV3j7nlLkzGdUXsI5/7Ec+Ntq3DGdertp6QRqHnxr5cl
	WGf/qzSnr2dC5MjBicIRP64j/wEprRCvlB8hnpwSZ6wSzx1JJ7Dml3SoNagl9tYTZB31MfNOk8U
	g65iV+gHY/2ZXnAKH2egsiQK5x8Alo9jwJ9o6ZJDOFKBq4ZOW0QRuCte4d8wYhaJApGGxtFvk/J
	mpcsX6hu3RIaRD/E=
X-Google-Smtp-Source: AGHT+IHb2W3Kr9QquAnjo1K0OvnqT9rs8ydpQgZYRxMHEyn7rJk2NbuqsB55qTn8fIsbyzlZxu77mg==
X-Received: by 2002:a17:907:7fa1:b0:ad8:87ae:3f66 with SMTP id a640c23a62f3a-afddd249ab4mr159537366b.60.1755595206548;
        Tue, 19 Aug 2025 02:20:06 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afddc04f96csm117800466b.112.2025.08.19.02.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:20:05 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Nandakumar Edamana <nandakumar@nandakumar.co.in>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Andrii
 Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of tnum_mul
In-Reply-To: <7ac103b171a8b5ccfffff08e4cf201152d2134d4.camel@gmail.com>
	(Eduard Zingerman's message of "Mon, 18 Aug 2025 15:49:59 -0700")
References: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
	<87tt24zdy4.fsf@cloudflare.com>
	<7ac103b171a8b5ccfffff08e4cf201152d2134d4.camel@gmail.com>
Date: Tue, 19 Aug 2025 11:20:04 +0200
Message-ID: <87plcrzn0b.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 18, 2025 at 03:49 PM -07, Eduard Zingerman wrote:
> On Mon, 2025-08-18 at 20:23 +0200, Jakub Sitnicki wrote:
>> On Fri, Aug 15, 2025 at 07:35 PM +0530, Nandakumar Edamana wrote:
>> 
>> [...]
>> 
>> > @@ -155,6 +163,14 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b)
>> >  	return TNUM(v & ~mu, mu);
>> >  }
>> >  
>> > +struct tnum tnum_union(struct tnum a, struct tnum b)
>> > +{
>> > +	u64 v = a.value & b.value;
>> > +	u64 mu = (a.value ^ b.value) | a.mask | b.mask;
>> > +
>> > +	return TNUM(v & ~mu, mu);
>> > +}
>> > +
>> 
>> Not sure I follow. So if I have two tnums that represent known contants,
>> say a=(v=0b1010, m=0) and b=(v=0b0101, m=0), then their union is an
>> unknown u=(v=0b0000, m=0b1111)?
>
> Yes, because a and b have no bits in common.
> As far as I understand, tnum_union() computes a tnum that is a
> superset of both `a` and `b`. Maybe `union` is not the best name.

Makes sense if I think about it like that. Thanks.

