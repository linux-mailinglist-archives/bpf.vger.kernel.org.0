Return-Path: <bpf+bounces-66489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C87B35078
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266C11897843
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D01D5151;
	Tue, 26 Aug 2025 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5+RRbSC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67E5D8F0
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756169359; cv=none; b=ANK5uHAWPNVlANagJ4FkYK7GGoYshpjaeOij2tfDoNbzw7lsC123DgJWGRnTY8sWClvIl3GNPp5VedUYEfrwXbrbAmJ2gnKVrsc39yR69IlNIqfdCe2h4jfgP4b4Q8ETRHExBQ6bQyM8wZiLgyvLbAxymmXXnx49jdJTizNiosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756169359; c=relaxed/simple;
	bh=wfWl1Zxp/OdDGQdiVqKIz50IDaiDVYbxsrYjEfv3RCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNmRTUBkL/vPBpuzlM06Lp9THDTUo6ZGR9uYqfkLvpoObamun1hY17DbALpTt+4det6GEl9JJd03c9dBfzMzyqzx49vts72V+wXX5XOhPk8liTvf8bUr6NlKgf0ukQSTQvyETdRs+pdJuHaoAHb7mvu/d0d2svWNqpLEbhYjzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5+RRbSC; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c763484ccdso1509771f8f.0
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 17:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756169356; x=1756774156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfWl1Zxp/OdDGQdiVqKIz50IDaiDVYbxsrYjEfv3RCY=;
        b=E5+RRbSCeK0m50E/GnS+GfxQJ2KGon8ef5PetC4ZMqty0PsC50ll6yjUvlzQkqJGHA
         QyCT3PzUfmXBDQ9yr5WYdNV84f1w5/Wn+Xd0b5d5XfeQflKkPdDtFw53yK6Z8Er9ywxS
         n8b1BCjt9XvbiGGTfIFRO10Z4AulSzKricqb1hon0Lro+j985FrBerQmMdYyEZSTJXgM
         s5/1Tyj6P5QdCuwJL/7osJaAg303bZDTOdK/dtvPGoyNzYbx0s3bvIzf+bIG9lpRb2D3
         RKn5zDtivtGCLy75gmSM/Fj1w/2SuL75DKTiyo24f/VejeOFH3mVCu7e+bmdOm2tKv4T
         bBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756169356; x=1756774156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfWl1Zxp/OdDGQdiVqKIz50IDaiDVYbxsrYjEfv3RCY=;
        b=AmhFQ4QPwsRPJx9kQbbgAjnQCsbK/zS1druhzbCSojGFQMREt1DqW7yNE9JciLKrzn
         gcx4gENQNSq8va2CTYmJWtv8qeWqTon62vk5XC7UnhuLqHmszXJBtyrUD08ExY0p325s
         ABbMX6rJEmcXHfDjHpz7iXJWrbcwJaZtZv6BxwIBV7TlULx9jq8SYA8zdb1v6GN1wz00
         3TSnd57RWkgEBTUHNaf1pxyIT2ElzUHxEBy2JEhzkVz6uvKnRk56sucN6t0uboQ+ahGH
         tuKeFjy2upVCAoXywontgSl1lpnTcap8T+XsUDiKW9t6a2y5tTdQ2J/O/gJjP/+Gw5eE
         1Avw==
X-Forwarded-Encrypted: i=1; AJvYcCXCm4CmzlJ2f5hNqLJLljgiZKkhRJXeVOLLuw89ZE5w4UymRbaScr0wAxKWgdOvpsTNts4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGMs/IRjLjgeZc2ut2HUM7iP1gdUy43pfVKvpMMInFpvIEYubs
	4lfOF3NHM1G5URlTG1qyBRQ1nqXd7MVmaHCzmvnwg7gTSuuXIeCF7L06aSMGPxxUMRBxIhBBBgO
	uGZ6HvEaPPd05wHcSztrot03ed33dKGM=
X-Gm-Gg: ASbGncshhksLBfQCWiX5q/4pFdS68F/d9WpqKoWgDaKxjPAEjxpkjWQEQflDfxIixP0
	xyt1cw+JkolCUoK/6ODMs2/7RF/dEbRvv/RN1S0YSQ4KpZBjbnnVL+YXYOTJENWGd2vQgdADQyA
	CHYDJ8ZNy1ChPImY1h51JWaTppB5HeM56h26IsXEAPAy5TS+Ui4R0xh72JSCKpZaL5Zf67JWjuo
	dACF48NO3ZoOQ878bamPSljfXfjiTrIIvza
X-Google-Smtp-Source: AGHT+IE96L5bvZb6vj0R0KKdOW3hm+pcrTmbr73v+JmthpF9003872/bhO8RNVCug96pXi51ScwvwzruWpUR2nq55sU=
X-Received: by 2002:a5d:5d0c:0:b0:3c8:f6a3:9b05 with SMTP id
 ffacd0b85a97d-3cb5b96de4bmr268009f8f.10.1756169356008; Mon, 25 Aug 2025
 17:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
In-Reply-To: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Aug 2025 17:49:04 -0700
X-Gm-Features: Ac12FXy1kPKQgwgwq8Q_X4xMpb2IpGql8LDBwObTcAqjtxNkKHle_KwuUt8IFek
Message-ID: <CAADnVQK4nhBTCOjP2dw85v9WSUW5rs_oThk9ME-TWBTjLwnspg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/2] bpf: improve the general precision of tnum_mul
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 10:30=E2=80=AFAM Nandakumar Edamana
<nandakumar@nandakumar.co.in> wrote:
>
> This commit addresses a challenge explained in an open question ("How
> can we incorporate correlation in unknown bits across partial
> products?") left by Harishankar et al. in their paper:
> https://arxiv.org/abs/2105.05398

Either drop this paragraph or add the details inline.

> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
> from which we could find two possible partial products and take a
> union. Experiment shows that applying this technique in long
> multiplication improves the precision in a significant number of cases
> (at the cost of losing precision in a relatively lower number of
> cases).
>
> This commit also removes the value-mask decomposition technique
> employed by Harishankar et al., as its direct incorporation did not
> result in any improvements for the new algorithm.

Please rewrite commit using imperative language.
Like what you use in the comment:

> +/* Perform long multiplication, iterating through the trits in a:

"trit" is not used anywhere in the code.
Use "ternary digit" instead.

Keep acks when respining.

pw-bot: cr

