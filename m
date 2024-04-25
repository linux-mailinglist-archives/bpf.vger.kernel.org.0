Return-Path: <bpf+bounces-27846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E7D8B28A0
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 20:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3185728193A
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1714E2CC;
	Thu, 25 Apr 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c51y+shJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D0514EC5D
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071563; cv=none; b=LZTVCqvX0iFb0sfSwwOimkj5pEP0NzNEaMGXTnXOPzL0vjlZxcqmmsxTXqYsGU+1ofPC1DtxuQQDnsHqrZ46ythycaK6Lact44oWu7OwbWsu8PfjRUh7UA9VkR8nFQGd62A8EDwHFMhpNz3h9NKiRsxTic/bm89+q4/HudUfX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071563; c=relaxed/simple;
	bh=xgXkNDT7eQN9MOZCNpF+MiftSDBMIPXmAW5JEwC1B8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J4il0Qz3arVmAhAk6eVt3ouqw++p9H1zTCyY5akUXFMu/Q9Y1FADiEKOFZtydYuecFrkHCnBDTpGMCexgLkm49mxdIr9I/luaJ6LKr5gyFrKPJsS+RAjWyNth+FR+e+olj/FUVZmigdQOdXD8js6aI43PO/xHWQC+KUezvogzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c51y+shJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f26588dd5eso1222104b3a.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714071561; x=1714676361; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xgXkNDT7eQN9MOZCNpF+MiftSDBMIPXmAW5JEwC1B8E=;
        b=c51y+shJz7s9jVqvm+pnPi3w3Lmun8G/76kmGNOz5yJeaFYiL0kgwlmQTvwKsDteP1
         VEpfirhuY2C5E/wKahN3zhvAU74iMpb7Gkw72E/GcPQIfkt2wsktRofGNRLjFYWzX4la
         8a2pG4DRF08uvZe+k60NEH/7u/hApj8rBv5PSkaKMP5sywSNsFuKmFQFq7GLOj3I1X5K
         p1jnMZDw2esdW93ERDqPxeMW2cf+smv7T3OeOMjY8OtWaZYhTfvBxs5XbAY3w3tnwF7k
         tgJr50YXvDst7g0PiHicRV2T20cehTrseg+RLsWTXaqGt5FkQYsdtzbGdPXJnomE7J/+
         QQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071561; x=1714676361;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgXkNDT7eQN9MOZCNpF+MiftSDBMIPXmAW5JEwC1B8E=;
        b=fshQGFjWBIPlaNnV4wo/cs8pQ5CB7HwZNG6zj/eL2dFxbDhTErXuWME4dO6wDds1EG
         9FSATP+ZYnqAvyAfJt++UJ22REGK5KlnQZcP2PzmySkyqjOd6D8CTLqH7oEm1zl3+SFb
         YAwJ7PfLJH/sm9L2h4iCKqAFTh99MNjgEi/IWzu1jhZmJYoahWqJWWXYURSpUVnDomDP
         LOYz2haNUQ3oZw4KNF25uJtgBa57pGbNRIDdl3NjvW0FM8WOa1eXEgcNxcP5yQaP1+Zb
         OFlQcyE0zlYdC54WPTRR8ERHr/RSuokELKjOsOlkMIgSqTI8z8RqOXxy4aVCHFUJu1TQ
         Y1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9/vdsIJ3sA8KxDSvfuUPwbsjTpWLnCHUTAVvCqzhgJyLAl//tzAcgbRSonIEgMwCDxxZSq+BobooS0+SAwcAx9d7j
X-Gm-Message-State: AOJu0YzCvmIVcU8f4ODSB86AwMEmIdTGsArZgBWcXpv9vphDiyxh0jzs
	mjX2WT2tyFySzJ4C7+iEGEYwmAxAmfvqp4lGhgojKHYrZxz8oXDio+ZeoBCT
X-Google-Smtp-Source: AGHT+IEX63DzRDB20CrULhU9jayEAFRb8Kxr2PqSozH46CHtm7PMwAr2tG2gEhkkiNSA8zrHGh68fQ==
X-Received: by 2002:a05:6a00:2187:b0:6ed:4223:5b47 with SMTP id h7-20020a056a00218700b006ed42235b47mr691274pfi.33.1714071561169;
        Thu, 25 Apr 2024 11:59:21 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:b5d8:5a56:aaf7:f817? ([2604:3d08:9880:5900:b5d8:5a56:aaf7:f817])
        by smtp.gmail.com with ESMTPSA id n7-20020aa78a47000000b006edd9339917sm13520462pfa.58.2024.04.25.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 11:59:20 -0700 (PDT)
Message-ID: <6e9d72ca6f02e09f3441b7742c34a3b30fd9019e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] selftests/bpf: XOR and OR range
 computation tests.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Jose
 Marchesi <jose.marchesi@oracle.com>, Elena Zannoni
 <elena.zannoni@oracle.com>
Date: Thu, 25 Apr 2024 11:59:19 -0700
In-Reply-To: <20240424224053.471771-5-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
	 <20240424224053.471771-5-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 23:40 +0100, Cupertino Miranda wrote:
> Added a test for bound computation in XOR and OR when non constant
> values are used and both registers have bounded ranges.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


