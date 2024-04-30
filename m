Return-Path: <bpf+bounces-28275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A6B8B7D76
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 18:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EBC1C23B1B
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FBB17BB18;
	Tue, 30 Apr 2024 16:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs8cOeq6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04917B4FF
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495728; cv=none; b=jj3fvN2UaVQKFFNkg3muUh7Hp/evIjhgo6ixaaOpCPbmBFuzWYhureYuMzaVtpKHMoLjd3f4g7rryHf4kqhbG3wClIMk2OKDJwbStOZ4DafBh3PnL20t/MiQnNMCTef94iv5jeYeqsiGPXbjZTQDWc610+MzKkZmBLjYpMw5J7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495728; c=relaxed/simple;
	bh=KmvCXlodqI913BQocEAeycFp0aPARBW3OUH7EZGdYWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sD8kjhdYIbZpvTBYYVsR16ZHdyi5mVoOHMWIy3Zky/kHHWLSreXb/S7VbyKc7y7sQ53vbnXmqhAM3CyOpQNgyrxIb0U+BaZcFkU2LAD20yaFWIHaHZ0Ast5QQnwVW7ojPbBBqRn4I97NXaj4HED7hfJK6JqF9m3TQVoUDTK67Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs8cOeq6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so59149415ad.1
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 09:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714495727; x=1715100527; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KmvCXlodqI913BQocEAeycFp0aPARBW3OUH7EZGdYWc=;
        b=Cs8cOeq6/Ws9zhi4j9PFlG1LrysK07AkAPL0Z4MbpCXczw67ouSUJL5XOkerGOPQ5Y
         fEaBuY+IAIjVF8N0kTcUHyi6biVFqaUeG9mmeodBeCtQD1RmNfg789J13SqwM1SxRx6B
         +pH/QulNP+hJ8iSWjtLtpnqnZw+Z9Eakq1pC//jzBtC5lctFz4twSh/nLM/lEeUvzR/+
         zfjoHh/gher3G3up4cNDgJ0OYR7u1J18zC+IliFNbYRWKYU1PqIZ10rvtn61Q6M34hW5
         ql33s9kntr7mBQ8cTMqcaMtKSSJGHOy8YDCdj0RKJRP91NVQkEIPG1XJaRdlm/MTZ5e8
         zANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714495727; x=1715100527;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmvCXlodqI913BQocEAeycFp0aPARBW3OUH7EZGdYWc=;
        b=nzeckvjLmUiPz+anElSNSkbyMXkhK6OCRL/7tQp5pcQpAAU53Jzu7iGvHmytui4OMW
         EQ7x/d9hhVtWQ3siaV1OtgULyN4rj981QZCiExx5Ql3LgbXD49+L8kJ5IkYROOJbKmtN
         2oKcSNSFuy2J6sK7dRv0BhMbaZdHlHMZ/djC1JBrelLDG+ePCao8BZiCmsNBUWeah6vh
         3+WYsDPZBXW0EqswswrW4A6YPYXTADmJfdZg5Q1Twsy//mSwJy0QuR+t8oeZxBRs80gq
         S0KkpFEUVd7SKGFeVN6Yyv+hGySyNwPF0DfCqzd/BQxMh6MR0+R68SAqVslZ4uSQGgcn
         lK4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU57LXVF+0C57mM0cSv6cauVCP049NOixXOOUL53xajKf0CWSr8o2nLiVRq5/7SRP0pCY+X0OMHWF7WaADKyBZEFqjq
X-Gm-Message-State: AOJu0YzRHSn9TaZ1k6+FGFlXFRE1hWfeoojxFb+OWituTlW/rjDdjsu0
	BikhvFiGyDjT3NwPVsGPvztldWXJw3xtaIDnvKLsrJ+iVBTDNeWs
X-Google-Smtp-Source: AGHT+IFJC4hU1oO+nQw7fOnqazwhAAq9CnjfJ2OKJf7fc/+WExVhN8CVyiUdSeAoY+PAem2WckxESA==
X-Received: by 2002:a17:903:2b0f:b0:1eb:ed2:fe89 with SMTP id mc15-20020a1709032b0f00b001eb0ed2fe89mr16881166plb.10.1714495726459;
        Tue, 30 Apr 2024 09:48:46 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:313a:f4fd:13d2:b9eb? ([2604:3d08:6979:1160:313a:f4fd:13d2:b9eb])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001ebd72d55c0sm4159570pla.18.2024.04.30.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 09:48:46 -0700 (PDT)
Message-ID: <6d9cf43b7465da52bdd028143809110a9c9658e5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 7/7] bpf/verifier: improve code after range
 computation recent changes.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Jose
 Marchesi <jose.marchesi@oracle.com>, Elena Zannoni
 <elena.zannoni@oracle.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 30 Apr 2024 09:48:45 -0700
In-Reply-To: <c1d17ea3c74e7cec4ba2457e2d6b88d324064af9.camel@gmail.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
	 <20240429212250.78420-8-cupertino.miranda@oracle.com>
	 <e0aa743fd6044691d0b30e7b2761c8085a28bb0b.camel@gmail.com>
	 <c1d17ea3c74e7cec4ba2457e2d6b88d324064af9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 16:29 -0700, Eduard Zingerman wrote:
> On Mon, 2024-04-29 at 16:16 -0700, Eduard Zingerman wrote:
> [...]
>=20
> > Still, I'm not sure if we want to remove this safety check.
>=20
> ... and if we are going to remove the safety check,
> then at-least there should be a warning like there was before the
> commit from 2018. Which is almost the same amount of code as current
> 'check + invalid flag'.

My bad. I've been reminded by Yonghong that adjust_reg_min_max_vals()
is called from check_alu_op(), which does reg_bounds_sanity_check()
upon return.

This patch is fine and there is also no need to change anything in
patch #2, as it would be removed. Sorry for the noise.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

