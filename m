Return-Path: <bpf+bounces-64101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F376B0E4F6
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 22:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585453A460A
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B882D1F1302;
	Tue, 22 Jul 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbxsuXJz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828F27CB04;
	Tue, 22 Jul 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215977; cv=none; b=JSp5+ZvrtaeoBegS2r51FWwCfHSnyvFxlBi6PpM9tb8yGEzq3VXx1lnVdnUkvHnsKyFzm1szZd7Hi/xTOyKVJWCuHJi+58azfd+eC+D7Po8J4nIPGMxJIuJbPDnplXMoTb4v+DBaMDt9weSVcMZFvTw5zDRuMGZLEJnqg4xuejY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215977; c=relaxed/simple;
	bh=LL5RR4/aJlWO/iPpEVte+oyM0zfLlcouNYh7/2jWS+Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gqc/p0FG+5N2isa6FtNXfNtH6sMNRKCCt8vb8gsSfEvtdCw0VeDjacA61MRGJj7aud5kpnHzCDqGD/CF1LJ4Xc03Vhs2r5UhrHd61vRlpjc5fkWZIuIAztDVpG9sUu12s4KOoUTAJNtgINhEgPF+QzVVA/OuDnZ5eGCJA2FxmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbxsuXJz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74b56b1d301so3971422b3a.1;
        Tue, 22 Jul 2025 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753215974; x=1753820774; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LL5RR4/aJlWO/iPpEVte+oyM0zfLlcouNYh7/2jWS+Y=;
        b=FbxsuXJzobdOpKWFrEafb1lJpwcuXKNAYVNpDpKisaYR522UFB3nEDr/rsPvZHYgEt
         VfyPBhpBSj79vDf24JolGcBsl7+t2f+MRcMyxYbYdE241g299o1axeDK4EKVOiZzIwKd
         zYEwCipS31WWhB/FUn5d+jkZoVu4b73njLAchM6jo2+ZXfPirBFwDqzk+ODUPczIX/Im
         juEwfMWJ/2QIpc07jkUfDWtvFKrymig9Uw8H5xMzgFIxYkxnJOXikcAvMtZa7c4zfBnS
         F9sUH1BpFeP0YKuwf5X32PnKCTGLDfJvFnT9jFZ/DS+YtY3SsG8GCs5IWgYCvYwF+zOF
         jEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753215974; x=1753820774;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LL5RR4/aJlWO/iPpEVte+oyM0zfLlcouNYh7/2jWS+Y=;
        b=SjA011hxTvL0pWB1mb4kdlyK0pj4ndQG/HmrDQJ57zCuQR4NSeLzBkqW6Tt9xGZCCa
         PatRAU/bvFeIjrrp3QbNSukNUeogo/zyS7BIkkUvQW23mYKiQRw+UUf42IAFNxYlC4jj
         +ozJZ237jnPaWSBASrvAR2zYcsDnW7+7ocuxIfxBmhrW0TW7BOXdQHf84u18BSw7G81D
         dIYpz+eTsYvv1ywajyatK9B2yI3QhxqfLoxbO1l3IxNPmebFCkSOyvvxlZoWYm7aoEQB
         6XBxITcbwHUKOoLpQHejwCZFwM8TPKliWNMtGIAg4dQX05MXmWnYB+0sOstqlQoG169v
         j4QA==
X-Forwarded-Encrypted: i=1; AJvYcCUqAjqv3w6b4K/SZ3d+o/I/w5kLXvXY5AsezD3vaNW6wJLdkaF7Xm9eU1sIunF98XkwxGI=@vger.kernel.org, AJvYcCWtnS5p6mvfBvfP1SwO6HFgbrjlGVArK2lc3+s56VEqRTPyN+4hSaqi97zdIaeY857ihybf69by@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPc+CA89rDd++qmdDgIuNL84bCn75rGFIOisRgPROstZBtqVJ
	U4VyxtpyU9Wx+05mltDeoFThbiUcDap2cVhQq7mWmHvVKYBKpw81dNtz
X-Gm-Gg: ASbGnctrbKzKUCsTfSOx/Mzx0D48G232gCKLljJXD52rrWAUawESlsi7XztdMW2lPRv
	Q7NitenRG/QU9xswJVsEw364rU++Wql3jw1/rmhIX1yAJHpFqAb+612maCXXbu/rdYJwix45xqW
	LDLDeRy7GqXEbCCO6t+jRFXdp40aXZR3+KyTDENvtcleI+twyHeUBdNeuPmr6wc3ogCpEtyxtLs
	hgB1JYQyZJUUhrg1vr6fCCHJ5b6HSvIbk2hg590jegbKpwpTg0tMqJ990HfqB0nxNaIqTJuAJn0
	R2O00OoksQSqWsQgkM09UO2X6AMMOWKZk0hYqsBYed+zUC1nkAgnhDVMZ7ONMwPLIy8I4foSBPS
	XgVd2DwxkQRsjWgQi0Iu8MnL1gqtxumehFBl2PZ4=
X-Google-Smtp-Source: AGHT+IFW89gfYzIsRV/hDIG3cjA15S8nNXog/FO1ykrz6vnDE6XAIHxtTnq4ZGdYM4q+hV6KG9EzUw==
X-Received: by 2002:a05:6a21:512:b0:215:eafc:abd9 with SMTP id adf61e73a8af0-23d49041f8bmr361897637.14.1753215974196;
        Tue, 22 Jul 2025 13:26:14 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:e6e1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c8eb0e98sm8278093b3a.66.2025.07.22.13.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:26:13 -0700 (PDT)
Message-ID: <8d84854a460e3324c2734bea3efbad86e0c8331f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 10/10] selftests/bpf: Cover read/write to
 skb metadata at an offset
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>, Daniel
 Borkmann <daniel@iogearbox.net>, Eric Dumazet	 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer	 <hawk@kernel.org>,
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong	
 <joannelkoong@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>, kernel-team@cloudflare.com, netdev@vger.kernel.org,
 Stanislav Fomichev	 <sdf@fomichev.me>
Date: Tue, 22 Jul 2025 13:26:11 -0700
In-Reply-To: <20250721-skb-metadata-thru-dynptr-v3-10-e92be5534174@cloudflare.com>
References: 
	<20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	 <20250721-skb-metadata-thru-dynptr-v3-10-e92be5534174@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-21 at 12:52 +0200, Jakub Sitnicki wrote:
> Exercise r/w access to skb metadata through an offset-adjusted dynptr,
> read/write helper with an offset argument, and a slice starting at an
> offset.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

