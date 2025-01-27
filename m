Return-Path: <bpf+bounces-49872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFDFA1DAD1
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 17:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A519B188945C
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D201157465;
	Mon, 27 Jan 2025 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7VqSsu8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4173D64;
	Mon, 27 Jan 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737996623; cv=none; b=g8jjZJe0pj0I267drMKbWUHLTs7Su8PVyIfa/gFV/3bXkPoTJVCd5ck5EPhBISRb/6sPuPI1MUWGA7Q9HOBKSfD3tXcUXEy49hw3/FvFnA02mF/GPGDK+ihs07uaZbbqLNkv3Y5Dwi/3BKJuPN9lkoaLOrQQPSXtgjvKcJTF+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737996623; c=relaxed/simple;
	bh=4eMJ6dNs78vhPKEr4/Zek7iEDf3GW96/yiHO387NT8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMx1Fn3fIL6Yrj96JKyaAXgfC+jPlWfKESUn3NiTMXK2FMtb/zSChDAirPQGcwvL29UI92dZTEs6jKX+5d9aTrP1zm7pKGiEbYLg2KFojoQu+MifxkCn/c6GI0pgPTaFIIWmEu/kHcqUgf6BnXIZnHMXopEw414QWlHY81vLWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7VqSsu8; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so7217375a91.0;
        Mon, 27 Jan 2025 08:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737996622; x=1738601422; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JqaAx3l5UvR6RdJOS4dq1vZQGJJ3/P1h1kbS9S//ltU=;
        b=M7VqSsu8TVLDZ8bcqM1JPAuuFo+7xGdZNlmL5jC3Sodc0msbjPjII3BFmnkt7oQZJS
         xkvUx17KFn9jFufy2CryPojCiIdzbFhzVJI8TdgLl2FEmG1HOzG4IL22u0YiNZitHed7
         GL+7XcRIRgVDq9crW/zw3TqAPedPdWpS/1FUpzCMTOIczzzS5vVd5Ny+UNfMlKNs5Kon
         sx/MWiBS3gvCXa1E2XVMLtuVd46xI02R9v8F0lYmGovEZAusp0XSdO4oOlzvgeD9EcCB
         sXdjdW/mJWi81lzIU1mZwQseuYnXPvh4TSMqjIpxmxHqWXrOP86WiW3WkVymIDQDIEiF
         yM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737996622; x=1738601422;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqaAx3l5UvR6RdJOS4dq1vZQGJJ3/P1h1kbS9S//ltU=;
        b=mF07zEzKTVkm53uJAGPsjQaHcBv0ej2kOwF8C6hkRUzSykTaQyzzkYNBeeozuZNPU+
         Edgn1BvGv/+md8Hk5ckMPUt3a/thk1dHt4e/oqsQzKG4M0czT4I1NWt+LUS9krwACj09
         c7NalGnTWUtKx+MWm1kTMta623Tq+l9iHIBiVlOEpBaBB+VS0+XfVaAjeubUb3W2kKx2
         9mztxSNhP5F9M065g0tUogH5bcdi86CwopPGwEfQo+/JfHOmcHLKPWoHhJ7Q5lm/DCDA
         T267LJx8LG+OS9ZHO2gvVfbMMQZoHyv8UPdr8g0XHMzWpv5BKzkpyi42nNeuV5q34Kej
         hq7g==
X-Forwarded-Encrypted: i=1; AJvYcCWs0tnqJRk4rl3yvblgdw6WzG1CQpgC1pGORtVVJ580o+FpMOT/iZS+Xz9zDQFnp7I83oBPcCWv@vger.kernel.org, AJvYcCXVDPAy6ZpGTlsSLKZp3JDX6OxyJItQUyAEUQZ/p5/PrvOZF6wAt8EUB6JwYWe6mp9XtpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUSCN+10lEdF9eaMyNOB0NBJ6UBXIdopsZ+0zIryJeqIPsAFd7
	fOcbn1hER6ITMHQnuqKjIbKb3nQSQ12HfllXGVEjhtGSTKMnuvI=
X-Gm-Gg: ASbGncsRccg1mHAFeb08HY1EsZBhlfXs8cFwzTdK6mPy/k2fGZgDTmsP5kn7q+puw5t
	mAZFCMVXfh4Pi7eqzdwJm0vfyZXmfaxFs6E6w4JKq0/13dDk3mBvSKFIaVo1wlJUSH+stmIPOGD
	S/K8p1okdaC5MX+Z5PCfe5kHpAZb6dqWJyjxCXVaB/6g5xyBloo2dH7hj0+eJN7DUoj7TDRCT7c
	Ed7KZZe9xxRn0L8NwtWY0ZK3vRbnJYOv+8sAZtY2XvpIC5wwVkJExSj+U0UqvZtVC9nx9CeNZc3
	xiZ3
X-Google-Smtp-Source: AGHT+IH7ENF+/Aww1QG4PkDutuUp75KE9OurU3FE7XyIpC2jdWpV8Dil6F827vH4LhGTUqSsBZ3gzA==
X-Received: by 2002:a17:90b:2583:b0:2ef:949c:6f6b with SMTP id 98e67ed59e1d1-2f7ff358287mr21856474a91.13.1737996621532;
        Mon, 27 Jan 2025 08:50:21 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb194a5sm7467698a91.44.2025.01.27.08.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:50:20 -0800 (PST)
Date: Mon, 27 Jan 2025 08:50:20 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests/net: Add test for loading devbound XDP
 program in generic mode
Message-ID: <Z5e5TKixwRLBLDfc@mini-arch>
References: <20250127131344.238147-1-toke@redhat.com>
 <20250127131344.238147-2-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250127131344.238147-2-toke@redhat.com>

On 01/27, Toke Høiland-Jørgensen wrote:
> Add a test to bpf_offload.py for loading a devbound XDP program in
> generic mode, checking that it fails correctly.
> 
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

