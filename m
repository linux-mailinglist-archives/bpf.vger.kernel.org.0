Return-Path: <bpf+bounces-64155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B89D8B0EE16
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 11:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F505966835
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 09:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749862836B5;
	Wed, 23 Jul 2025 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Dobyz5Ug"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5977C283128
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261770; cv=none; b=VO7hso9UpBPKEop7hobi0Dp58T//ktlP8+jLp5Tvk3Z5Vc8XwcXVi/kjIaNhOB2TufMNXuEis+xR+EO6Kk7H1XtAmnexbB47/jw6xv6mnsDEa7xwbS7mtYDKQ/IX8//+t5H1JqEJnrA12ii9WiQm7xD4gNN6TVe6teUL5AdqNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261770; c=relaxed/simple;
	bh=+ytYnD3luDBYq9P4nCMvymvEEpfDPNQbSLnTtC4hmEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OTSDyb2o43wWmR7rliWCBfav++QI3jo8lEFLyqfCqHst8KgqcpdAjZGKXiXykgpKp5dT6R42rXgdUGOJmXcdR7Nwl5DR8CixLUQvDlSH5D6e+sVLyl6Ntlhy44wrPbfU6G/c4iEnxc4L/ek4Kr5azFccu4fHBimqZQHj2pHtMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Dobyz5Ug; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0c4945c76so874442766b.3
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 02:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753261767; x=1753866567; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2zcV36T8m2bDfLjZ71K3Nn6DOnILgi1eLJ8ygProCpU=;
        b=Dobyz5UghswWZ3YrUZhnvIqA0N0jisQ50PXWi4Jd5OHY9bQpcxAeCgs7Les7ttqH05
         0TkhQKY0fO7fVcMVN98sEvrT+cFUunfm7sVcJD8YeulARXmsl3aaJ9YPl02FoMFAmOH2
         T3xChhKW7rDypPUM33jhMN7oekKNlIaN0N3OpADSerXdlkTslYt4a53uAi4CewWUNSsJ
         pwVIgiSJP94FI6TU9Ag4LOHfxCcx5n7k6inxbxZgHF1pA/Nm3nICpL+5rgwRSUq7eqXY
         NqYSQpXm40SqgWbYP1cejOaAbr9nldxqO0uomtDV/bkM/52xyxFx9aVJjnJdZd9BHMo2
         sSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261767; x=1753866567;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zcV36T8m2bDfLjZ71K3Nn6DOnILgi1eLJ8ygProCpU=;
        b=sJIerjoMaTJkKFEoTcB8R97M/O6QlwacA1Y11AXCIlTE93ZbNShIgeoutHzkRexmU2
         CuV3rh+y3LehYjBsBgFMk02O0y+JsgYf3lHxDHgx5SzKt1qTpubrEAwozWB3CRn0reku
         8qQ6WwpSaWUMsSIcjgyE4aVBvwntgpFn/LO9Xadu22NrmgniW9zh/K8/kADlQNI3pjCy
         AhVXep5/dZjrOR37eW/gmKYbTlVvzYEeIhM+PxfrPjq88+pTfs6FOykoHBsxHNfaUsSO
         kHfyO7wh2oqFvQhn325rccNrAYQeTsDi6NwCZsaTjpI5kPJ++UKEiv9DMCJk0NZYNz8g
         QOpw==
X-Gm-Message-State: AOJu0YxP5DMg84RDyAvCadBi2onXpoO9ayuLtF9hMD92JpCdvx/knuGU
	hmt8AOl65etLKNaEbZEI/iio1HuNs/OyENwA+LH48TXmWopVC68g15pSrQm+uK9akRw=
X-Gm-Gg: ASbGncsIn+1UZeIysmiW6urqKrnY1aYLCVE43dOPe9lvqrzxd+8reqSD3chko2W2roG
	Xk1M9doXN15L6QA67c65VlClcjOxdyr/kZfp6i41r84VZHC0P9+3fk7nOQ0gzQpfKpnfWlmAbMJ
	YxoGmPZHJZ0anC5HxKesulZEhe6wNycvehFQJ59VCV1iyM6RCptOJPtUhEcby5GjuOViR1xx5C5
	3FrAXixX8AB7JdFwZ4a+5Qy9BxknqM5IWoPJQ5niiK1p+FmTr4sBv6X5Y3Mo0wU1NqKiBPo+eeL
	rc00KlgALGHn2/VKNieXjfVkOBKylNiIwQHvQgBvQhjxOHd4a/rc5N/EU1QcZ19D0+jgWw+c9R8
	Fx33pAugdL7F2fP0=
X-Google-Smtp-Source: AGHT+IFppVFkyEpOyB0CPplf4xKmqV75wZQ/fIWHvCo3wyJNQ+QDWQbCFvBJ3QOnmHHOIlenUkvO2w==
X-Received: by 2002:a17:907:1ca9:b0:ae0:cadc:e745 with SMTP id a640c23a62f3a-af2f8e51179mr201694266b.40.1753261766446;
        Wed, 23 Jul 2025 02:09:26 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d5255sm1008043966b.40.2025.07.23.02.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:09:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,
  Daniel Borkmann <daniel@iogearbox.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Jesper Dangaard
 Brouer <hawk@kernel.org>,  Jesse Brandeburg <jbrandeburg@cloudflare.com>,
  Joanne Koong <joannelkoong@gmail.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v3 10/10] selftests/bpf: Cover read/write to
 skb metadata at an offset
In-Reply-To: <addca8ce8c3c51bbd147175406e9da84fbc9c1e7.camel@gmail.com>
	(Eduard Zingerman's message of "Tue, 22 Jul 2025 13:30:05 -0700")
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	<20250721-skb-metadata-thru-dynptr-v3-10-e92be5534174@cloudflare.com>
	<addca8ce8c3c51bbd147175406e9da84fbc9c1e7.camel@gmail.com>
Date: Wed, 23 Jul 2025 11:09:24 +0200
Message-ID: <87a54vxohn.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 22, 2025 at 01:30 PM -07, Eduard Zingerman wrote:
> On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:
>> Exercise r/w access to skb metadata through an offset-adjusted dynptr,
>> read/write helper with an offset argument, and a slice starting at an
>> offset.
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>
> Maybe also add a test case checking error conditions for out of bounds
> metadata access?

Crossed my mind. I was on the fence here, asking myself:

do we need a test for dynptr OOB checks for each dynptr kind?

I decided at that time that we don't, but happy to add it. Doesn't hurt.

