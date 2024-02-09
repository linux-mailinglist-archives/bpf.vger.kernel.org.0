Return-Path: <bpf+bounces-21655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C5B84FE8A
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 22:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028161F25C7C
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 21:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FA3374F1;
	Fri,  9 Feb 2024 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XtZKTBm/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667A175B0
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 21:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707513085; cv=none; b=Unno/RlS6PWSwAFehtDkw2gjCkZsRzFISm80X4+JCVWsOmayM0yY4kj8jbsfC9pMEBCNK+n7plZoYW2DwPcl2A2mz/5QmSpxSQFgUiaVFixmd88sBc2w2fQ2KsSTJ+eUsLcXi56X2elAs/08sVtT557SKH85Aemvo7rBja7vCgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707513085; c=relaxed/simple;
	bh=XUcH1UxLCxfIwyJ9CRFC+7ICqDqroCA5cgXdrikWaRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h76YW2gzhQoZa0rmJlo+Hpci4enM6TOW+lze4j3xOLpzR8Psfdnme0THO6j+iX31aGlJ6EfXRW4BagVU8TtcWihWoHPf5JxzInxB6g76dFrf88xhCc6vg3Ppi5oZXs1G5ISJo716hxF9Lf+LXiD76FyFeDvpXY4gNvqUWgA4fdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XtZKTBm/; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-218642337c9so767923fac.3
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 13:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707513082; x=1708117882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6TgcwAbgsmLtLyu5Ofw1Dd466E2FrR34L8AWToaH3s=;
        b=XtZKTBm/Z7iEq+KpASrtQOEc3Q/EOxUyJs3Saw4h4NpnJHItCkXPFXdzi42DcvTBOH
         pZsN5nbUAfuruNVx5GoXepMIIpCgQd5EtvbfkLPXVgLMTAWr4fcsl8aQsugCV/RNr6yT
         05dc8nvQ2Q2l5xw9tK2KQpaAMJnGpHhZLwSbFHtVEfr3GdGlNcF+h2cvtP5cfmNlnO5Y
         lhNS3pwhZkHBH7FB7EnFbuAkYlwCIFs5TUuDV2GsBAxYkhEsbMetRNY0Tqc71aqPVbP6
         f40Ngtv1zmY7+0cqn25V7DUarhE1wWW0rpHpregX2WOsar1dGkdgOBoLkcAMKjpX34eU
         UTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707513082; x=1708117882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6TgcwAbgsmLtLyu5Ofw1Dd466E2FrR34L8AWToaH3s=;
        b=q2AIgmxfKOC/utP1lzu+S2ssa/viRCj20hGPxox/lQsEY0yak/KHVZQ+sVJkwf67zx
         CKGp8Id/sT3yz0kn0PBU29HOxINqFPp4bybLI6Gmm0Gfk61KbwNCO6pqMUIti8dKsNq2
         f7tTu09Tl9G3qwZmI6JgztAD+2dQTdPZHo/EYiUA6tuOAvfjiE9e/HskX/ZD/UgwxYru
         lkQWGg1vLx/f9NFGtrZtCXDa5R8Hy8yvUm7p/RTyDU8HbXNLqHGzSJFrm3LRwHqEvh31
         CWUJPzkydV2anm7S2RZXm+ymhAK42+fidc0fDgQVlOYrVa1X8elOc4IYxiro60QYjcDt
         YWVw==
X-Forwarded-Encrypted: i=1; AJvYcCU5wOlj+mRzJ/x81HZRaryXNq5SmB0uLFXQK1OQdJhY6atWmPOvYIFQfzy4hsmEc61fLyduBHZCEDMxtEv26gc9hXIy
X-Gm-Message-State: AOJu0YzSmAObRipRxNaaPcvUmtEjWyQyC65+bdhH/VOj5BHLPz75J719
	a05B6BI/9TFOtsLfuLcQL86rhGefXPgimVo93+xzEYGVhEpATegw3kO9TECPec8=
X-Google-Smtp-Source: AGHT+IGl3bcIXf9vxhkEqrznfhES+9b4LRsM6WT2DoAnggZow6RhmartJWmHnoEjEXctYwPR1K8p3A==
X-Received: by 2002:a05:6870:b250:b0:219:b163:70d8 with SMTP id b16-20020a056870b25000b00219b16370d8mr552722oam.6.1707513082402;
        Fri, 09 Feb 2024 13:11:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXm3qqN7nurWgs9IaVrQ6JuoBgeVnXrUdVl39H6TG/U/U9XfNjgLSUynl36AntPvANxVhyPrAcht2SAT/qsUR1SWgM32c8saU0lm4578MElg9Mym2NaaOkFMFEtPMYsZxnZEKrVAKX3QLkDwEML4umP3Bq2P9v5yRwOIR1TXTjKj8gGHXbNWWctV9sKk6p4ZYW4gQ3y8FMeEpx3CkGvGa7KZxnpcVOVi2bUFH4q/x49qRl68MfMvnjk0uewdY0rCov92fBPwa7O3yypCTDysSJrWPuN0TmvB+hBqyDByVBJa6bylcoR7qjqdw27s7AU3GXCoURVufP5e5XaNUAqetK7A9CMOUFM5ksHcT56zwg/HOuaWGFmS6S1ES7OJXlQNMV8cKFlhO55G1XY0RppWhk2pLTJjlIVwv2iNZ1oFt3KEOCr3FnwQpXyeV83sdY0eXvLCZQk++lC6wzubsY0QzZBsQ8wUirg1IHvWNzht7zrvyy+POKQvf0RR+dTCnKG5r8FIpzanAory9C60cbXIMryjFS5e863M+S0Q5qxEX7t2g4Kst3xz/0jBfpu7nmUaiMK/za6cXUtXuaLedTjoNju0mvpixm/mGZ/T9s=
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id e21-20020a631e15000000b005d8e280c879sm2240643pge.84.2024.02.09.13.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:11:22 -0800 (PST)
Date: Fri, 9 Feb 2024 13:11:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org
 (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next v2] net/sched: actions report errors with
 extack
Message-ID: <20240209131119.6399c91b@hermes.local>
In-Reply-To: <20240208182731.682985dd@kernel.org>
References: <20240205185537.216873-1-stephen@networkplumber.org>
	<20240208182731.682985dd@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 18:27:31 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> > -	if (!tb[TCA_ACT_BPF_PARMS])
> > +	if (NL_REQ_ATTR_CHECK(extack, nla, tb, TCA_ACT_BPF_PARMS)) {
> > +		NL_SET_ERR_MSG(extack, "Missing required attribute");  
> 
> Please fix the userspace to support missing attr parsing instead.

I was just addressing the error handling. This keeps the same impact as
before, i.e no userspace API change.

