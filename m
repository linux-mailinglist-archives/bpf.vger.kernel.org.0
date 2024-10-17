Return-Path: <bpf+bounces-42286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB319A1E4A
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 11:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC1B1F23040
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 09:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037A1D958E;
	Thu, 17 Oct 2024 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql0WwyGY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91951D90C5;
	Thu, 17 Oct 2024 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157208; cv=none; b=FXbT3iyIv4vifQYKKh36v3z7Q3qs/+fXw3/XsHyFan1zsrOJk53uoM2rvvCJTNZRc+0NiNnfdBWpharlFxs2k2VnpkfuBJoMzs8xQ8mYWP4bwIOWZsfKb1MHkHu7zKmzbny/QAzF6p14Wxi6gRicpjfqqYZM4S2ZjnwXy0MWnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157208; c=relaxed/simple;
	bh=nJJW0IqlEidUPTYRziXp8zEdXwJwaiZA85X7aRPrG4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gie3NPCxCsqyiMlin6+z+KSzAEOk/t1t9RgkkHtPJtwzMy9ibV0AmbHXiLj5px5grEXS+JFlMkigasAoXTWkpwUrQ2gUsfD8vQSB08FcOnHEK0ohjE5uVgfGpiMPz/ftVBG9kXVuJJWiWudFTL3uxuJBPk2mo+CXPx5v0kemaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql0WwyGY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7eab7622b61so636749a12.1;
        Thu, 17 Oct 2024 02:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729157206; x=1729762006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nJJW0IqlEidUPTYRziXp8zEdXwJwaiZA85X7aRPrG4c=;
        b=Ql0WwyGY2fJarPQPddHa2mV6FVMnEJ57/Pk6UN6dDfkFmokTshPgmQQv0wkcodqNBy
         ob3FRdmAWnMdMdKJL71Ai5Z11QPsxG3CML0R0AUskyDrm6E025fCAHtLGKKy9aC6jJIE
         Nc/s/7WFsQmfTUcm3jmalccJ1K9UrtbdFAlr1JxqNDfsVl/E0Y+EOSQVW0JMnX/T0V4i
         fIw7WhfLBiC10tSraVYp5YQIvjVdartySKFA1cnx3oJaD4Mb+ZPFmpEGbAe5YwLjGpDw
         QEcxlvEelbz06X71CUR3CFf5TLpiBTn7lZEvrbwiD8RK80hH4nPllX6TPV/krmEhlAdD
         cuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157206; x=1729762006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJJW0IqlEidUPTYRziXp8zEdXwJwaiZA85X7aRPrG4c=;
        b=aIWzEcPGO4RFwWKl4kjSeBNPGPXNdshK9iRl2y2NWl2Fv7/pv1+YPQl8h/+0NolEJ0
         RQdVjddIpjoZooW4tWnPN5z2qT94nUVjRKR/lS+5ncLahFPvVlDh3jTvvlld65Pftlhf
         vv/JV9aVl5yitLuMm23R/AUYW/d1B+KU+gE8wjMLGalkTk6o9X6+O8RG99DMgsgeUcOU
         1zf2EjXeNaZUFz0fuKXbaaTWulzRAlalVRfo9JwVIRrEY5iY/ItaM+aZTIBaLZP+ey0r
         8oi2lW5JmXB0vMxubT9IG9SnUo7qojmdWmHZqMshpGDNMXaB/C6DWSHljWAoqcKDe0uh
         KE5A==
X-Forwarded-Encrypted: i=1; AJvYcCUPk/w1l+qlaEMiHXowBzp6U1X3KE3/C1TY5l61CcCrFQBDvd6JzpLzXsyxFWJyUePQ9eKTqHCZHnYeomk8@vger.kernel.org, AJvYcCW0bU0CRytgYxiusDfezrXntoXCZO1Y+aoWq/U7Ekj21dA3fVe64MMu70ci3AGRG8d5o4rOvIFzdyST@vger.kernel.org, AJvYcCXZfVHDfFxgWhwUlqoM8uV7eYWxU0reC3MGsrfzqzAoMxkxN5eBPgwQNwL0WIUgGwP0n1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxgzJfulSlk7IjUwxbNLjTo3nsQbYGqhQe+ZQ44gvQdamhaLeG
	6udAKl7V4rhZL6JlrmE1wX7Zy9QYr7NlDDw6i0Ny6ZOlwHVvNUZM
X-Google-Smtp-Source: AGHT+IE96loXrbUlaPAyE8WtyM8lDq1SaDZ9pKic4cShYAdR3fRclLcPo6MZKte8otQzE6KoCHpjSQ==
X-Received: by 2002:a05:6a20:d504:b0:1cf:3d14:6921 with SMTP id adf61e73a8af0-1d905f4f902mr10429378637.35.1729157206080;
        Thu, 17 Oct 2024 02:26:46 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a2b20sm4335243b3a.122.2024.10.17.02.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:26:45 -0700 (PDT)
Date: Thu, 17 Oct 2024 09:26:37 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>, Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCHv2 net-next 0/3] Bonding: returns detailed error about XDP
 failures
Message-ID: <ZxDYTTIgV2tE3tWw@fedora>
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <54164763-b635-4ff6-be88-56aeb461b494@blackwall.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54164763-b635-4ff6-be88-56aeb461b494@blackwall.org>

On Thu, Oct 17, 2024 at 11:40:34AM +0300, Nikolay Aleksandrov wrote:
> Please CC reviewers when sending new versions. I was CCed on patches 1 and 2
> probably due to the tag, but wasn't on patch 3 and had to search for
> the series.

Oh, sorry for the inconvenient. I thought you are in the cc list. Next time I
will do double check.

Hangbin

