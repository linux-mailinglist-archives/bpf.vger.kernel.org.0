Return-Path: <bpf+bounces-38385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842E696422C
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73591C2450D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E201E18E371;
	Thu, 29 Aug 2024 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aw8H+tob"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197018D644
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928477; cv=none; b=auFQWA1PVl/mbuVEYviY+NOIfx7TK4cqRChIq1RmkvLNvRuGWHjwXqp6Oa7IsrUjCcB3DR0AkTLGT7v4eG0somNTdKpF+Vj/zh0mvW8RaDcWfugJvEqcAFzgGFhH5+zfJraLrwSjOk7UgwmN6TGK39xlRRsRxXFBQZLkQ2w/GtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928477; c=relaxed/simple;
	bh=aYR71yX/lEP84Q/cBlgRB5k6OYd9aKz7KXGYxZZ1rRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q035FxNk7NGKDPtD7mGXehy4M+ZIVeOGlBi9Rf9e1cKwwK4QF08sj5dcN5rIxaOWNyZrk5p36sFoG6duwa34vhp+Ea0sWJofl2l/No+7c4yBK2Ch4f4RH/iGfSekAm0i0hQPj5hlqi2ms6pCxQT2AFVzjn46A/64vYYYb9mszSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aw8H+tob; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724928474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xbs/v6QvX9Zgxt8njukpApcL5lIchC6Qom7gbhkYcJ8=;
	b=aw8H+tobvCreT2D4OrcVM7t6maTwqZUV+zg1xSpU9VQy/YmUi+zx63jUV7OpPvREqRMjAH
	aF9/WyiqpCN1jD9PbvsF5TVUauMkJIv1pbGe3ZIPvahGt1xB7rVwmY9FH61XOYOUQdXBjc
	3F9o2ikZqjBOduK7eWgiRzvcOKoDOfs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-nB8ZEU8fPkqp4a8tHhx8xQ-1; Thu, 29 Aug 2024 06:47:53 -0400
X-MC-Unique: nB8ZEU8fPkqp4a8tHhx8xQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42b8a5b7fd9so5555425e9.0
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 03:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724928472; x=1725533272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbs/v6QvX9Zgxt8njukpApcL5lIchC6Qom7gbhkYcJ8=;
        b=g9izLQxYjnv+ZsyGriBPgZFqUw1pJoZdFMOIM1daYetrIGTAmGcBveE28+3yetaXlY
         rBf2wioAJBgzIz8wXGoQeCWpkbmtDkSHk2lw4d/UK8lRZd6YIiJumtUw2MElkslaxeM7
         HkN3xI8JD0Wq5Rh74e6Li4d5R3roGZpugn667qDRwVYekHyzZJaM9GTQn/kN8XNu7GkD
         5+tX6NurJXQwVLPxFcPWJwcWh587lAgBq/6K8JqWGunJdzdYAEy6gQVUgMxN/qdH8hPc
         sFesq5Baoz5DHOG2w6tK6H5yu+uW3TAAUYRcssyy1pOIAhsIKUNEb9aPoRkKF5s57ikE
         WIog==
X-Forwarded-Encrypted: i=1; AJvYcCX4Vj8oxAqSUtTKhICPBnjlkmAKc0/Rn6qqk1WAVpEpC0MjVRjT37NQSQUK1oS/65aScY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaGyMGWYd3FZCH61aUmt9SymzbRr5U2I5yPj6StgRtv54b3W6L
	wK7HaTnAEeMO8d/Yz+8RMYN9c3OIO8s3O+y7qmBDi3eaxIjHzl4Z+yydGOY0stJrrnioscPBuBh
	LLOZpGZYGGZmWg3bkDpqFym3gmaigrkoLcsS6biNODXE1x1xSRw==
X-Received: by 2002:a05:600c:5110:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-42bb01fb87cmr16915275e9.37.1724928472393;
        Thu, 29 Aug 2024 03:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG47hK/NpUyrB2KWuczXd8vbY1gztNea2O4yagYPeZKtiaQ5r4qXRxUyfdXjiPhurJE/j3zRQ==
X-Received: by 2002:a05:600c:5110:b0:426:6a5e:73c5 with SMTP id 5b1f17b1804b1-42bb01fb87cmr16914845e9.37.1724928471549;
        Thu, 29 Aug 2024 03:47:51 -0700 (PDT)
Received: from debian (2a01cb058918ce00dbd0c02dbfacd1ba.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dbd0:c02d:bfac:d1ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6425958sm48196065e9.48.2024.08.29.03.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:47:51 -0700 (PDT)
Date: Thu, 29 Aug 2024 12:47:49 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	john.fastabend@gmail.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/12] ipv4: Unmask upper DSCP bits when
 building flow key
Message-ID: <ZtBR1Xws81abORhg@debian>
References: <20240829065459.2273106-1-idosch@nvidia.com>
 <20240829065459.2273106-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829065459.2273106-7-idosch@nvidia.com>

On Thu, Aug 29, 2024 at 09:54:53AM +0300, Ido Schimmel wrote:
> build_sk_flow_key() and __build_flow_key() are used to build an IPv4
> flow key before calling one of the FIB lookup APIs.
> 
> Unmask the upper DSCP bits so that in the future the lookup could be
> performed according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


