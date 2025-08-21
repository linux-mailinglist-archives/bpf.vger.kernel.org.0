Return-Path: <bpf+bounces-66158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F774B2F321
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 11:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9173AFAE0
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 08:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EBE2ED87F;
	Thu, 21 Aug 2025 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34LPbofN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8E15853B
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766654; cv=none; b=pXRgkXsFOhWVz/gwm0v4btWfitrFsS/12jJm9hk+/cPX1J4U3rNFyqAFNVvf58t/ScfvkNIiJNK/n7JtmrOQAiPx/9r8MlDi7XXoUecf5Htwn7hMCR5HmLv+Admq6+xL8w65LdGCIYlU7Di30V3Kgx1dtlQ2bnquSkms0AGX920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766654; c=relaxed/simple;
	bh=wVT5bcYYu2qAxq7+XV3bkPlP+gOJjAhgpOYa9K1uOUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEduRG60IW4A1oTfOdoZMWFjAPo/8i9JShHwJjGWtsPph3L9GZBzQACCXyMB7Doww0hSzXp84g7baeX4OTrUG0s8XVoSgP1EmqGoCJoo1xT/veN3gRJB3WDF26i29kFDLNNRcamQSawrmgy0ACd3lNP0/RXskHdL9OjkDVutMyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34LPbofN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b134a96ea9so6618131cf.1
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755766650; x=1756371450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVT5bcYYu2qAxq7+XV3bkPlP+gOJjAhgpOYa9K1uOUs=;
        b=34LPbofN4P393q4BdsajQS+Dcf/7YiXG5o8TTfwaN2xa2Aj05qogAbxjT0AKPYkQ/Y
         9waoL9h0FffDGh9T+d6mnHq2Ki7OvZ13kVeIW0UkZakjsSkicWs39EJTrq6q39FCWepH
         KJ225+pQTIa7n36CaHDZBUo9rRrshfYFezAivhxyjvUPFEdXTFYKpDj7LBsI2207TGG9
         lBw7adFPKXbngAv+misegPBO/2f/FSqyk7AATVNopXqWf8nA7iq4VqWTBram7bKZ228T
         InQV5OcTf4fn4GMMv89cI1VaJQ2TL0Wf+wAL+fRPA6mYEdpFWISIXyhHvRWlfXlis0bl
         xZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766650; x=1756371450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wVT5bcYYu2qAxq7+XV3bkPlP+gOJjAhgpOYa9K1uOUs=;
        b=LkklchEEA/GcinvEPnEEbL59VjKSPOhs5a6xsajD05kqNv9GP+99DiT4OFDR5zPzpv
         9DwJaDT+Zv5SpGKJH7SuLPzHIBXUiPKq7KVXzuJ86DBvEKzmQD1P3M42GYGGVaPs5X9A
         mYqGkZcsCWO8WfZzxffVavpCs+wN5z1aIaFoXeWGkz/lggtwfEWaHL3nrfNq3II8Uk74
         QE6Nii+xrohSTJSwPhwHfDAbpBp1apJwIjtQuhRdSvM692urDrt7awCbg3cDqE3X6tLo
         4lW6pO9t4L+f2LMa/+PcZUOH0yNjw9IVove20DJFig4skFPxJyOlbyu0h0jpolYobet2
         41lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfgDiDGkGcGHA4SBKtleKA/HAtzgrt3hez5/8FcvKv6o2Hb+U2AmHB1niZJam0Re7mCak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9YaZuW5/D7DZIiluJxMq2QXEKrLLhFFreut20k4Gs+LTp/ZJS
	3Ps65ZBVvI7VSNZ3jqruTKiKIRLiLmtk/EpbRyulwoUr2Z5xPjQysF7x9LuLAcZcDbzLNNq6Ubc
	Ta13jqlA2ElqB+0yrBuDqyDN8mPQgLQgZ2Na3JTuL
X-Gm-Gg: ASbGnctLFIG5zCkD9WOkIGwN3TvAk0jKxzjQveEYYKfNyjSHSuvc+j4fi/5rT2sy1Pp
	3YzJAJT7h5Dw8WOii9vUAqD3mAO8Zuy6KUOdnHBdhU0ZVMjQwOs+n/eV/dJ3Nvv2CVmHpWv6jHO
	iPa2FZly0MR/qUjhHCA8wSjxTzi2L8hKANkCEHBqxUyO8mNqF5uu8J/YSMgrXTOnxIm+z+eZn+n
	VUjesSg6voB7p6gLZ2TNkrAOg==
X-Google-Smtp-Source: AGHT+IHFkVfP6J3M/7hhl54OhQNkRmBSxPwdT/1PDEOLJvFDH72XGIwIh7eQr1CXffsV0ym4huij21JS8QYACP49XxI=
X-Received: by 2002:a05:622a:1a08:b0:4b0:b7cf:8cde with SMTP id
 d75a77b69052e-4b29fa3c3femr16301551cf.21.1755766650133; Thu, 21 Aug 2025
 01:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-8-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-8-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 01:57:19 -0700
X-Gm-Features: Ac12FXxEjL-42H9O9a-b_qJb1E8Dwb5jTLFUbV4y5evL7fDRVFtenhZTNyo0XGw
Message-ID: <CANn89iKhAKsoZX-=LkMNTjghoyuZ5r1rT=Pvu=wua4M=DPSWBA@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 07/14] tcp: accecn: add AccECN rx byte counters
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 1:39=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> These three byte counters track IP ECN field payload byte sums for
> all arriving (acceptable) packets for ECT0, ECT1, and CE. The
> AccECN option (added by a later patch in the series) echoes these
> counters back to sender side; therefore, it is placed within the
> group of tcp_sock_write_txrx.
>
> Below are the pahole outcomes before and after this patch, in which
> the group size of tcp_sock_write_txrx is increased from 95 + 4 to
> 107 + 4 and an extra 4-byte hole is created but will be exploited
> in later patches:
>
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

