Return-Path: <bpf+bounces-29179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C59568C1087
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51311B2259F
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 13:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287E9158DA1;
	Thu,  9 May 2024 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4hvl+jf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA661514F4;
	Thu,  9 May 2024 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262105; cv=none; b=LTB/SyhlApWdAY6wvVIrXAFAv9d7XHm0xhEeIRROBTGNf5Z28Ddi4s0JUH8G5WT/oPTAbdv7KAYoSd5qD/4Czf2HDQfF9VA5B1p+RFXVsBk9Wp8yDZyswyw7qREIqs4F7QttVujuBt3Q4/NZah/C5CFL5p7B6BUD8oHb6GbLjac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262105; c=relaxed/simple;
	bh=byWCUfWH9G9t798Z/UalQqwNars7ub6qY+Y8p84jINs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Hr/t3UoCwnUuzVHJyHIIGSjsqakGdGXRGMMtksVfLHzSodatFh5LzJ7zcv7zkKaJFBk0pTrPRWRnDFxA46uyYe9pMdw7USUaBf1Tu+y1dbXPlglKnKbIVMk7PfADjkxRJiGjlK/m/kjn4MEJWWTQaN+V1Vl/fed1D3/mGbNwU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4hvl+jf; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-792c34f891eso20209385a.1;
        Thu, 09 May 2024 06:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715262103; x=1715866903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/hDoEEEO+Anwz6S3zgshZvUzJLkImXA0wUVfV3KGBY=;
        b=C4hvl+jfhFTh5fKDxniDVYXjJuR6PAcXUe3yrKecKq9tHN8eUeUWAppSh6ij89U7xX
         FEKMArdZVNE+WR3cpmum+hkRmJlz7BJr2Y54EqK8+4Mdd2RlbHcH/Ypm/yKMGRq8iAud
         NZohwae9L0xHPTV5IjYgXesfg5wvk/n09HWDntMHzX2XBWdQf0WEaznMKHFNRdPT956k
         e7IzePCVb1wmTHmOtNkYtumDAQMzhOHbwpdL68JpNdNQvus07VNSZqR1OOwgsReXIqDJ
         gj5BBvWec54ETJXCX4SlT8IscwENu9/t1yual1HUUon/KgQLczNphOOGQBahgJBTxxTL
         kLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715262103; x=1715866903;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/hDoEEEO+Anwz6S3zgshZvUzJLkImXA0wUVfV3KGBY=;
        b=IRK8ag25z9Tu7rqQyzrrfzgQ2rb0g+nWQz5Eh9V0sAWsMkN1LtycClvBA/nxJTWCTS
         fB6Gwz+aBje/CW0/xd0vrD537kh7yzYcCxhNAxG6Scd9+VQLdTpKQpFE9d6F0QgQGjXD
         nlLTCGJZb39IIwPIoutnJZdlu0xv+42IKAiIpnz1FqGeGEoLqVkp6rxzUHnYcGLSMlba
         smvHDVAyHE8hnWwZvun3Yk7AHP9hfXrFhV8NTPGDPHBY2pW9cawjR3Zqj0ZPTBvj4NCg
         URMTcfRu+EH/8Dfw+so41xUARbuLRKKmXemsVqp5tH+yQ3fGtIWirIjaWF9M08rmbt1E
         n2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0TepOL0eynDPRIkG74RQhJCphU1bwKBjCaI5sf84pjW3sDlUrZopmZIZJjhZBbaLElk4fKnygazWYMBqxrSVsCcEGO2uCdLKKjFoc/dsXnZPiH30J9TFs/Fsjlr7qmRExGXGURvMaEsJApxLT81VENJB4z/8P9Kue
X-Gm-Message-State: AOJu0YzlEZlwhlzKRhkaMXqLm0yP2hHli68JlYvwwM5P+/5XmFuohXjb
	ceBL1xonJGgm/nQp6mwubItxa2/pkyz0K5w8hpC15tyEZ8RCnV+r
X-Google-Smtp-Source: AGHT+IEC6zx5G5aGb3z2zBxSi/6jyKi3pIt3NFO1UVMHHOItQUwIpMf6Iy2ywJx3RO14fJpdZhA0sw==
X-Received: by 2002:a37:c243:0:b0:792:960c:80cd with SMTP id af79cd13be357-792b276b341mr626867185a.74.1715262103063;
        Thu, 09 May 2024 06:41:43 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf310848sm68698485a.110.2024.05.09.06.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:41:42 -0700 (PDT)
Date: Thu, 09 May 2024 09:41:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Martin KaFai Lau <martin.lau@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 bpf <bpf@vger.kernel.org>
Cc: kernel@quicinc.com
Message-ID: <663cd29678007_12691429440@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240508215842.2449798-3-quic_abchauha@quicinc.com>
References: <20240508215842.2449798-1-quic_abchauha@quicinc.com>
 <20240508215842.2449798-3-quic_abchauha@quicinc.com>
Subject: Re: [RFC PATCH bpf-next v7 2/3] net: Add additional bit to support
 clockid_t timestamp type
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Abhishek Chauhan wrote:
> tstamp_type is now set based on actual clockid_t compressed
> into 2 bits.
> 
> To make the design scalable for future needs this commit bring in
> the change to extend the tstamp_type:1 to tstamp_type:2 to support
> other clockid_t timestamp.
> 
> We now support CLOCK_TAI as part of tstamp_type as part of this
> commit with exisiting support CLOCK_MONOTONIC and CLOCK_REALTIME.
> 
> Link: https://lore.kernel.org/netdev/bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev/
> Signed-off-by: Abhishek Chauhan <quic_abchauha@quicinc.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

For the non-BPF parts.

