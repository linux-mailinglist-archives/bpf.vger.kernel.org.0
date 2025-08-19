Return-Path: <bpf+bounces-65988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E23B2BE80
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 942EA7A13A9
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951131E11F;
	Tue, 19 Aug 2025 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YSM1HVVR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB6131CA79
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598083; cv=none; b=L07/bsJpzsOhy4pdEFnDCgw0l4VnwpXo+ia8/ClbHQEy9+6bw7L/9mlXHkU9gZRg4w6NfM1Q1gwQGHN2DNwf4Ku1llYFSyuf95blx10A8cknCCqmdzTD/ibvIt+6jepT5Nq2K8ywiO2s5RU6mywBrtbBZSEitj3IxL7IleXu/YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598083; c=relaxed/simple;
	bh=lfdDwgwmbdoZPKO2L6guIJGA/JQk9g1JYnAbMgcu9lY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VQnGjffuVmcw0ap/nWoYcAInZ9drqDbAtcS+gJ0E9bh/oim7aKgQJfYMAUabqQMke45iCpVkyhoL8viBiBd39LqZ57VVQWialVp8Q9aaUObkil8IVG1RCCAB0n4Z5V5zyRsbWzzRu7nzCdQBIWVpY7QFsDQ+07l/xW/3wIEtnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YSM1HVVR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso6190982a12.2
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755598079; x=1756202879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfdDwgwmbdoZPKO2L6guIJGA/JQk9g1JYnAbMgcu9lY=;
        b=YSM1HVVR2IwClTvxZhYntK4MlOAr3jtZH16NImleFeFnyeOvwtiX3OXvFZgHdM+K3f
         iOFzXjRm1yxpiq8Ez1LpiJfZ+jsfQUgUaWxYJf+dTlkHww+C47lZTzmmbEuistE7ZO02
         pkuvCN+b4gGyC4oEsB9eWVlmGlmcqM88PNm9S7FQbffNmpR8dBbVNae/NAYPcTWhRa/f
         grce0MJ4Tn0Zkl0Dhh2j07e7ADZrBJnIEZ5ryR7zKY4VY32kqFl7d+YBSBvCP+LV2cA0
         UgZjvFS6Sx5PCCGzOFDlc1J98wk81I45xXc7jd01BhokjjjnpUwpIjWuYqAsuX0n81iO
         Q7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598079; x=1756202879;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfdDwgwmbdoZPKO2L6guIJGA/JQk9g1JYnAbMgcu9lY=;
        b=H3q62GqnarIuoKnCWMHMuGiSBHqV4hKx4Xy9XMRMBmVOW7DCqj4TIFQ2CRErGyznn8
         Nlk+QnMUFk658vVRlYc7/U5IeAs5fxb8hhzOhDMamCcUq5+TYZ9rFCfDI3ZB8d8V6XVf
         v4Eo5HBAanYXh4UkNlZHbZw81lgMkfp7w2P/+GRWY2xFI1Y8AJA8+6voRpSuKu6qhKU0
         rSmCJPUGzOXiaBwU2lqxV4474nUwV31pDe/SNXOCCRE64GbydVxak8J5c0tVULixG2f5
         MIAtTdWt29fbjrKOmrKRPLY4aq8J+GXTrndxYEgiuYRCwedSVSZdHbJ74/SzRYTtZkrI
         XWTw==
X-Gm-Message-State: AOJu0YzF7ZtEq9Vx2Ciajr58zwRuy1ar9Fr0JCFVUonmlNJJb/GnNm1v
	f8DFj6o8yNrGOCTJlPtriA1yG79R0zC5pimppeDghlx3E+Q+EowqLwELz8QHIhOlTqe4vrRlciD
	8Fgt7
X-Gm-Gg: ASbGncuqPha9X1ijyecmIi9teQLdpCcN9P3xFUiyCZ0nR618IRIIneWYxa5InXZXbrm
	aFwEZNxnPGub0TrDjgk2XJMcgHkg6t471V8gFjxhSIUBJEa0OhJi4TaDvlkHNeCEAReiuFRpLAp
	a0RdD6VXMIjQWKQA+zfE3wGdQPjzL+leKSIHuzSxMEtoBMIKxuqpj9bJ88hUlincLl92aUt3lRT
	yJEyLC3frIvFiEdYUrb5qs5RqQMHvTiFgsV0ScJK+k9IAXC4oOfPUjeLerMvQMc9/4bFoTyqZLY
	hmt7wy8BofxDOHEv6zbCKshoNVt/xQ7JES18nQvLmJPG3EvsaY4F1N7mLNCnx/jpiVYPBWKiM2p
	3RvlNCk8zXrQ4LY8=
X-Google-Smtp-Source: AGHT+IGwCYDOFfKh5eQnDdJl6GKcu+lBoEyCWS/tcJJzvzPXIE34XsK/D5uXtEjIisAOPggDgVEZ2w==
X-Received: by 2002:a05:6402:524d:b0:617:dc54:d808 with SMTP id 4fb4d7f45d1cf-61a7e6d99b2mr1459711a12.3.1755598079463;
        Tue, 19 Aug 2025 03:07:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a758c0e6fsm1503523a12.57.2025.08.19.03.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:07:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,  andrii@kernel.org,  arthur@arthurfabre.com,
  daniel@iogearbox.net,  eddyz87@gmail.com,  edumazet@google.com,
  kuba@kernel.org,  hawk@kernel.org,  jbrandeburg@cloudflare.com,
  joannelkoong@gmail.com,  lorenzo@kernel.org,  martin.lau@linux.dev,
  thoiland@redhat.com,  yan@cloudflare.com,  kernel-team@cloudflare.com,
  netdev@vger.kernel.org,  sdf@fomichev.me
Subject: Re: [PATCH bpf-next v7 0/9] Add a dynptr type for skb metadata for
 TC BPF
In-Reply-To: <175554964898.2904664.15930245053733821413.git-patchwork-notify@kernel.org>
	(patchwork-bot's message of "Mon, 18 Aug 2025 20:40:48 +0000")
References: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
	<175554964898.2904664.15930245053733821413.git-patchwork-notify@kernel.org>
Date: Tue, 19 Aug 2025 12:07:57 +0200
Message-ID: <87ldnfzksi.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 08:40 PM GMT, patchwork-bot+netdevbpf@kernel.org wr=
ote:
> This series was applied to bpf/bpf-next.git (master)
> by Martin KaFai Lau <martin.lau@kernel.org>:

Now the real work begins =F0=9F=98=85

