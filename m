Return-Path: <bpf+bounces-66412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E4CB348FE
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20475E7AA3
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1081F301000;
	Mon, 25 Aug 2025 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbG3g0F6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DF2304993
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143253; cv=none; b=sdx/gPLbheN/6VQHvN6mMpqiJK5GDeX41ZplW4d6octTLdeNmgR3HyK8KuBsM44d5dBlLuVUjnLjzUvVl14B448s/+yrbcqy5ZNjxvJtrtHwo7T+KPrBqNmym3KQ5b6SNwzbqJt3fROVwqg0HWfYlg04XI4Id4YmuDqMj1YPNN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143253; c=relaxed/simple;
	bh=qALHTb18fItlePsZkOFxJcOziMRbpSgNg6bp8um0nrU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHAxb1tKYEjvkr/N6Ftft/4pFLfhCl/naHk5OyowbjN3nFlCpyKnPFI+60pFAu+2Eva6T/R1ApouAC41hGEo+Jo9rgygOdu4JnO1vjGl09dldgg9P7x5anYNdmZHzHD8ALTW4ON/tLDpT0UJRg6l0HoqqsYl3Ff5VHr9Ym9a01Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbG3g0F6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-323266d6f57so4903321a91.0
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 10:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756143251; x=1756748051; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qALHTb18fItlePsZkOFxJcOziMRbpSgNg6bp8um0nrU=;
        b=XbG3g0F6ZljuEoCgTRZHngMfp1vp+c0qF8TWG8rPXCR9pYzM3IOF0a+I8rXmwgjw4W
         Cxe0ohsQjQMDe4LB8xzBh8EfTah5oZIX5+e+5/ZFpcvUjCvZX2iFdKOOyQlDFU1KlF3F
         3tS2UMGCIvZhv3bX63GZ3suqD9lgxFx4VKnoMT40HrNUkwsLG7frFJMm5t3SFs+p//xy
         PZwLkOY+nJSt453EnTSRTRwcEWopFrCWudCFhk17fC10JWf+XlqvaOzz0+LAh/sdS9xZ
         +i4/B/FxZkUfW1DVglWMDY+PfVzy9EZh9OPADmzVZWgmLl0WNYVT7JP60OaxjLx/D+HJ
         XCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756143251; x=1756748051;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qALHTb18fItlePsZkOFxJcOziMRbpSgNg6bp8um0nrU=;
        b=Gi1eoSgx4M0bb/UO9/Epwpao98AVH3+LobOHkXfLxMFNq+PUDxdfA25Sars0KqsLjC
         vnCbrnHojF2hPh/ZM/O0Xh1idmW5fLkxPfUEPU638kprEt0/YYSBAf6lMDmHlnR91AMt
         9rEH/CFuidmrTV6m1gWOYKOBBFcqBLgUCFVF4cZPt7mFp5qvdSP8tZIoW1eYy3AT73GV
         cEHLLD4RCMYBTiFiIEK0xkjlEgVHjTnQn52WtGf0chTsa0AdVvlhbD/ytdGRegGvQ12U
         L6SXKzuz7DW/OvcUFp8lu6INvijavSw2pmqnEMt4APvRV8f885d0CSGb2AfAwLaPgN+p
         0Psw==
X-Gm-Message-State: AOJu0YxlZE2rdYnBe/ZxRtedGmUNx/W/BnOeJAJwdknUzNFvFRxxJdcd
	zSpt+3aMEm2pN0Z/U2cTVOi2pqYjFVi4HSJuvs7iY0MZMkTbq1j4yI1w
X-Gm-Gg: ASbGncv+8crwWj9Nx4pWbGb3yqOOx9V30+l55ZWB/awpPVgFZ3T8VID6JJ6dGEzrskf
	b9it0XTYkuMiTJiWLBm5d4lVTij8pSmGKa4UzOprNAczsz3wEHPl+n8cHA6I9Yv6nGo7hEBAIoA
	7/fRvybYVgHbSPyKLgf+JfJojGdeKJvi4qBucPrhGZHjxNw/3V+0rHxiMzbNagaHwl0P8ReIeei
	jT39ICBLooG4oKkt+cX+2tQCKINlY6c+2LQ4oLWoCCR2KhktwUN87LIMkUoVUD0y8jfa2agQXAU
	vDw2yaFTDliH1gOzyRTGya2F8IBMQ4WYZU0agkASvhw6sahhKihx6limsXnDcS6a9McJaSIwNpm
	oVDoP1l1pbCqCGO50lPbjGgj83qTy
X-Google-Smtp-Source: AGHT+IGoy5PzmxkyWjoAW31AufnKvCk7HMXsIhR9+/WlWsYtoWNTkg/aeIs5mEZw6IKE+0O4rt8/PQ==
X-Received: by 2002:a17:90b:5806:b0:323:7e81:7faa with SMTP id 98e67ed59e1d1-32518b825a6mr15496453a91.36.1756143251260;
        Mon, 25 Aug 2025 10:34:11 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::947? ([2620:10d:c090:600::1:48d8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254aa7c48dsm7690580a91.31.2025.08.25.10.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:34:10 -0700 (PDT)
Message-ID: <1b4fcf8f76024e7fa547d592db4e178af4fd3037.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki	 <jakub@cloudflare.com>, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>
Date: Mon, 25 Aug 2025 10:34:09 -0700
In-Reply-To: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
References: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-25 at 22:59 +0530, Nandakumar Edamana wrote:
> This commit addresses a challenge explained in an open question ("How
> can we incorporate correlation in unknown bits across partial
> products?") left by Harishankar et al. in their paper:
> https://arxiv.org/abs/2105.05398
>=20
> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
> from which we could find two possible partial products and take a
> union. Experiment shows that applying this technique in long
> multiplication improves the precision in a significant number of cases
> (at the cost of losing precision in a relatively lower number of
> cases).
>=20
> This commit also removes the value-mask decomposition technique
> employed by Harishankar et al., as its direct incorporation did not
> result in any improvements for the new algorithm.
>=20
> Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

