Return-Path: <bpf+bounces-27197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210A08AA6FA
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 04:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B1B2826E1
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 02:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852615D1;
	Fri, 19 Apr 2024 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/QcEFm5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8A37C
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713493946; cv=none; b=JmzxCNq+Bj0hBOnF/akiN+hhng9CCCEUmGtKxNHR9fg9rYsPb+O11O18XebFA6yPEtkM04Mhi2LmydaX75IKAMbIbgs2XPQuUy0lKOeWk0oB/e+DTCEpZ/bDapd46bpMoMZDKcTeafbTO51P478BnpYT8EfCX+B5nHKwJ6BzzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713493946; c=relaxed/simple;
	bh=i9HssSLh7pH4ASYxGJtnNZoVCfegCKwdnwtBr0+5IwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fu/aEMk+m8dHEU+xd7+BrQhisUR7YOCwrk5ZiBBKXEcXVksm7hZyMO+GVChG8W3gA50e0+55W1Kls0qt9VXDF8zRN6dR4B8mmniweSj917Fa1eqxCQWe2z/5DEBEIOhM6/+UNaqwovF1ErA6nAtfbHTTHDVWda0+L0GXGrNdex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/QcEFm5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e65a1370b7so16272145ad.3
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 19:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713493944; x=1714098744; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i9HssSLh7pH4ASYxGJtnNZoVCfegCKwdnwtBr0+5IwY=;
        b=P/QcEFm5jH8BxyLnPmDZHHzBsDRAWVXTN0j4wsUnAd4d1s7G/zFwnEa5H3QvlWsJ7Y
         ykigGVY82zJVqnVLLBeeqmqOjlw7cE4HPNOkkK0I5agHTbu87EkSJqHpa5UmRaityseX
         iiEY0OYp/o0hYSdf6WNsKPHJUnVR7G18BEajtYgJ6sVycbQ9yWkCqsTS3kvVs69kUvlQ
         UaMTBVVuzHkIuxixjSJ4b5HM4jd1FVGeNKYD/IpglOCBKXODOqS5e75NurFMrABShBx1
         QmzBXBilQQ87rIGEAW4vi5bSCRvjwiKBWhe0n1hUbo3Bp1/C86Raw3CB4HxXzNDyAt3C
         /aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713493944; x=1714098744;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9HssSLh7pH4ASYxGJtnNZoVCfegCKwdnwtBr0+5IwY=;
        b=ghFbmN0H4fKmfUu8yPbyIEhFIkLxR81y34oQMdRO3hY+nP5TPNSn2xj5yNWSM2euUv
         BZFFpo28hGixROF0OyZMX9S4uXsITGtm3ayf3KIxO4XBHLNg0+creTgQbwgZQNgeL6Fe
         fggfOlYug3XBDQf/bN543aCEiKTf3caR0gnjSmE4xfwcYr5DCU+zdb9NpulDoQ6sir7K
         RMvMYJqe0LDPYIXeitRtHjCitM6LvdptoaD5AwGXQ+MhUcT0KuGt8xvLeoHbA2feNM8w
         faFg6cLO7tsQRUYCp0B4acw+YkwNPKnB1uNFwxWvo3AO/fabb4H2ewgucImoLGCv2WXt
         qcRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMpZuB65Gp/uGMp4AUsnFjIFFfnSQBh3bvrqRtpAn3m2eSEDMZfW8JTF+iI50hBsGpJ2RCLQSRQWUvvWQRPBbkbD2B
X-Gm-Message-State: AOJu0YyS7u3Rm+EkgKYmcyo7hdO9Yb2ZtrNG6jSe4wkre9jleAZlVmfx
	hNvQmM6r1qclFBK0aq9IvGx9bEtCaH3can7sbWF0EloOzkP9Lb6xLPEeG3T7
X-Google-Smtp-Source: AGHT+IFeP5Rje8mSVbdUEjsBnS7gouTal5tHGZB3btLlxp+LY/NNkwVqZX9P+p5zSgDvjc30fBKu3A==
X-Received: by 2002:a17:903:4293:b0:1e4:1932:b0a5 with SMTP id ju19-20020a170903429300b001e41932b0a5mr752895plb.68.1713493943983;
        Thu, 18 Apr 2024 19:32:23 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:775f:334d:e9e8:42bd? ([2604:3d08:9880:5900:775f:334d:e9e8:42bd])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709027b9300b001e435fa2521sm2207292pll.249.2024.04.18.19.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 19:32:23 -0700 (PDT)
Message-ID: <16228e72f5046caa6b8faced62c525a6f7295aa9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: MUL range computation
 tests.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, Elena
 Zannoni <elena.zannoni@oracle.com>
Date: Thu, 18 Apr 2024 19:32:21 -0700
In-Reply-To: <20240417122341.331524-6-cupertino.miranda@oracle.com>
References: <20240417122341.331524-1-cupertino.miranda@oracle.com>
	 <20240417122341.331524-6-cupertino.miranda@oracle.com>
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
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---

As with or/xor, I suggest to simplify these test cases:
- avoid unnecessary control flow
- avoid map manipulations
- drop __unpriv_* and __retval parts.

