Return-Path: <bpf+bounces-27188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7832B8AA60C
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 01:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277D71F21BA5
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 23:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143F77F10;
	Thu, 18 Apr 2024 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsPTrUhs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FED031A66
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 23:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713484682; cv=none; b=g0nK8LgQVS3SS5MelLSoNthdfaRWsz52CrMDibMjFNb6MrTzPj7RKLWhoMq/zHlgm9TGbb63t70ohM3n3r6cVLVPKSs4mVytlf68L7flEW8mPGiu7L5b6+5ZPgRXYDENjig9gr7L5cQvqLhu3hEFHC+aXMjFs2B9VTNpaJ3RaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713484682; c=relaxed/simple;
	bh=r4aGMo/vriC/fszy745BVMGNK40m1xapJyZ9virWI14=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cVB9caazC9ASA4IyUZWDJpir2R+g/7i7eL0Dum4Nxm79w2PF9+7wv6VJjlbWZYCLgQEMFKx/2UFRdKorvtL4NLiDH1DEa5VZJA466GtTo2p0sTxKGYPhfXMo6QE5zG7kdxKSqCS759CwsxO8aIwSuMlJC2Z/SRju5PqP4T7O+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsPTrUhs; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e2b1cd446fso12075385ad.3
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 16:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713484680; x=1714089480; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r4aGMo/vriC/fszy745BVMGNK40m1xapJyZ9virWI14=;
        b=NsPTrUhstYpvBInt+b/lVG2+OdpdniQgSaewZkMtv553pEmN8obaQE+jqPMreNVtht
         Zg+9WPHI6YYDK9Hyb8ujTXQbWY3sukj4KcATAHk3xDi2HVcjgwJ88zHr4rZTrOJ2CFzH
         mImAW8C/yUcnRfpm20ll0lAVDvVs1sqocBYMSCUCyGKkN8zqMeazFj6f9KZhOCXr8Ret
         vOmfBn3C29SbBzaHjaCtH0KNrNzxt2dlu8ru88rYQ9CX0Z8I5I5WXamWctFYFdt1kGgO
         COxNnIc2F5Rjgxuk8Jou4JJHjtsdxvF/qVpyrBDU9j2KgQMil0jkF/I40fxIxlTR7URk
         kaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713484680; x=1714089480;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4aGMo/vriC/fszy745BVMGNK40m1xapJyZ9virWI14=;
        b=t3T0dVIOhy5BT28fZTQpCRSuPyvPJk9uoNQvI9FC2Z/ld/fc9GFW1OvNfEJPPYC1uT
         sZtaQFO2OBTO0NAG165+TB797mG4nZfgkOgfSohRcG0jQGnuWbhXl2X60FjYeg94ydwz
         bH3W0e8X5qp1aPSkp/blQO1xMt6rgBDRy6/IxwmOSbn3bIzJ63TKo6F2AY9ZIFfYoG1P
         GU+e96XOxDdJk62/6sws3xxxsi9J6AQJ/jmMbRtJZ+bpxTRBFPSxeznOMTb7BlEUiKsw
         X7MGTcJUx0UN+jRSbSUGfERflGBXvcq5Z6ezWVLIuR2zPWs+O18zJzFjp6Abf9X1pnAF
         aTIw==
X-Forwarded-Encrypted: i=1; AJvYcCVPBgXsZmfRRQcVazOhfMAbLcWplSe2c1DnMZ8E98IUb3NFg94Ss/Aux61hb/4F8ho4Z3OqunF/KYBJd4kfdeXQw5Ld
X-Gm-Message-State: AOJu0Yw7ceuGRn4RRuUUcN8JvKGIMzBXnXBIZJVmHHU5JS0M64Bd/EQX
	zGNij90/0xVFiNygw53hyVAcbQVqBumQRne0DmeUHxNtSCkhxFzu
X-Google-Smtp-Source: AGHT+IEudL32Ji6owP8nV1zmLKNWxLR7SZ/RqyuSb35jYZg/K0EZf5JmSiykJjk3bJeTUcrSklRvFA==
X-Received: by 2002:a17:902:f78c:b0:1e6:114c:2e54 with SMTP id q12-20020a170902f78c00b001e6114c2e54mr782769pln.69.1713484680290;
        Thu, 18 Apr 2024 16:58:00 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:ad05:9ec6:fc65:cf63? ([2604:3d08:9880:5900:ad05:9ec6:fc65:cf63])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903120a00b001e789aff266sm2097537plh.118.2024.04.18.16.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 16:57:59 -0700 (PDT)
Message-ID: <dfd339d6e4876f57732c6d1555451ce776d946d3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] bpf/verifier: improve XOR and OR range
 computation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Elena
 Zannoni <elena.zannoni@oracle.com>
Date: Thu, 18 Apr 2024 16:57:58 -0700
In-Reply-To: <20240417122341.331524-3-cupertino.miranda@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
	 <20240417122341.331524-3-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-17 at 13:23 +0100, Cupertino Miranda wrote:
> Range for XOR and OR operators would not be attempted unless src_reg
> would resolve to a single value, i.e. a known constant value.
> This condition is unnecessary, and the following XOR/OR operator
> handling could compute a possible better range.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---

I agree with this reasoning regarding OR/XOR processing.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

