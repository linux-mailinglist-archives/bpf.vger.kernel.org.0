Return-Path: <bpf+bounces-27847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436708B28A7
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 21:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013F52819AC
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 19:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C52614F10D;
	Thu, 25 Apr 2024 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xo8I4wnT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D5614F123
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071637; cv=none; b=peJUk/mum9NwZqxtijejGWPnFUQSB/hCpZ6F4z/grju/9+S1uH1CKcwnGpYwtEsxFNfUQDxqwtLtl7x41faQ6+jyh33w+hS54nkgGxXeCWUWybJBOtopsVAshbjsegUSVfh1HHAr0/cl0MfRITwSz+zqbwIUtCwjXO4cgpMOF+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071637; c=relaxed/simple;
	bh=n3JtneyVuFxwm01XdqhLdknDjM+TLb+yjKBTHRZGaGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nw1Wq28GN1zvnTMxV1aTIhwS/QStBBcreH0N/Gi4pDR0ei1PQwCgBmPOLllsKg0lFu35mNRIOQO7t/Jll+G58v9d8Au5sCe3gZq6Jcrw/4uz7EWufMY05hkoA9OHMr/6DOeUzTeLWY9L4Cuhy4W/Oykrw8s9x0qJwX1CNezje3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xo8I4wnT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed32341906so1380434b3a.1
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714071617; x=1714676417; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n3JtneyVuFxwm01XdqhLdknDjM+TLb+yjKBTHRZGaGQ=;
        b=Xo8I4wnTX1VsW9S1WTmJGnTjkn5cQoXxsjSdQwSpFjn9gMoB2LKrW0sY28sMu31SJs
         AuRZ7osN9F8ei2xm4CO9UEJoNSpOWRCAfrUbN3cYvCvmiutBu5eitAqLkK7skpKjeca1
         c9rlYO7FyF6kvMbqP+aSGkeoPnzcJEVVtYyKk2woYVM5D89C+uf/+VuN+UKkaWUD4EWT
         RrF8b2ok6+7TiBokPbfX3UceMXit8qK/r1jDMyVDk3fU2mQvr+eyKkHNHaQUyYM57It0
         7Gk9ZRLYk4+NwMd78qlPf0rDfWsAm61Rmi7yGXY9GLjPjVndx013B/o85RhWuspez82/
         s+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071617; x=1714676417;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3JtneyVuFxwm01XdqhLdknDjM+TLb+yjKBTHRZGaGQ=;
        b=hYPrkrX6gaH4c7D4ikHK465VHkpM6Z+JTEn99f90ekSosPvdvvnkuR9YcI8RyST42O
         EU3HwqxiIOLktG3U6ki7hPRZqVq6x0Ch8RU5KYvi/0mSt4Mk7TiRVBiZmF0bWII8AcgF
         cY84QnF8ksEs8k8kiEViZQjeki/y/xIbN9QL0IKzvaY43pYpvFCavxYaxQgvPpY+u5PL
         BRovgeA+H3tU8xNRHcdiJtkeuJEZhI875R+VETsMaDoJ4oKf1YKjkAZLr1Ai1pTldXD1
         xrVEUcyfkGDdnj6LuCbVKC+Emax8SRSn48WnsPh2pFTGMa/6w5HHe71x/vu8s555747L
         Kp9A==
X-Forwarded-Encrypted: i=1; AJvYcCWih4KiU4rM1eQqpMxDIWIJp013sjH7/n7ZjhCO0UtEeM+qjzGarGKBrbBFAk2kYzhvPkZkc+FmXkAHJBz7zq2QlsRS
X-Gm-Message-State: AOJu0YzqsaZwdUdu7TrISlfC1tuTV7dM9ye2eTAcmUvH31RlmS2UaiGn
	7C1Z77Dp5+k/Y/V2B4qwxPB4WKiH0Kbl6OnpTRBYhJ3jRdOYyAxa
X-Google-Smtp-Source: AGHT+IGPzdb1zfRD5UbXkpGMWVjDJdSDL89Z2Hh9kl3AfZnoOaPrV/laJygTXMEPcVoItnARzRDGpQ==
X-Received: by 2002:a05:6a20:6a24:b0:1ad:9358:25a7 with SMTP id p36-20020a056a206a2400b001ad935825a7mr829724pzk.15.1714071616376;
        Thu, 25 Apr 2024 12:00:16 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:b5d8:5a56:aaf7:f817? ([2604:3d08:9880:5900:b5d8:5a56:aaf7:f817])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001e49428f327sm14173706plf.176.2024.04.25.12.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:00:15 -0700 (PDT)
Message-ID: <51c18953a809327b6ad52c05a957784a54cc358a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf/verifier: relax MUL range
 computation check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Jose
 Marchesi <jose.marchesi@oracle.com>, Elena Zannoni
 <elena.zannoni@oracle.com>
Date: Thu, 25 Apr 2024 12:00:14 -0700
In-Reply-To: <20240424224053.471771-6-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
	 <20240424224053.471771-6-cupertino.miranda@oracle.com>
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
> MUL instruction required that src_reg would be a known value (i.e.
> src_reg would be a const value). The condition in this case can be
> relaxed, since the range computation algorithm used in current code
> already supports a proper range computation for any valid range value on
> its operands.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


