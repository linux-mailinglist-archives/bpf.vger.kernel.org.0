Return-Path: <bpf+bounces-68099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC66B52EAC
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 12:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3017168094
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFE030C354;
	Thu, 11 Sep 2025 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/SMOWFm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06124CEE8
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587056; cv=none; b=r7KEWkOliaNTTo24qljgx4wlavDpojybYOa6TfKH++BernmAvTugu7o8KOqGd6tbeFEtV3XqK74Ejz0l9DBIF6YFCTPGXVDGqiCHjMFNQ9Yvwmij8H5T5i5v0Uc2XPoxjG3l3mhy14hrrhohrVYaXWOIlc5c67WM7fEgZZcwxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587056; c=relaxed/simple;
	bh=gBJAhqvEHPrcQ7AuGOAnRt88ljqyRo1HkemhDWzHqMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCkQKcDRkeC9TCyvJmzSVMefkhtG8Y0ELtmPW7wxmZqAIzMXzCAnVezdMXCfcBWrpzlZwo9mk95w7iJ+s4U6Sk/D/NSmqbtGUa2GBEBB3lDvWubEz3Mx9isFljAGSz7PMSsgkW7YvhFtZzU2eURNXJt3epBx7oRTxt0USpHQ7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/SMOWFm; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b5f79aa443so5220451cf.1
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 03:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757587053; x=1758191853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBJAhqvEHPrcQ7AuGOAnRt88ljqyRo1HkemhDWzHqMk=;
        b=G/SMOWFm7C0PlMXZdxkgFZD+AsTFtUjBh6xfVFkGJWtS3gcJJAGefDTAw6+YdzOVxz
         ykyPFnG8F7V418YTJ0XwEbJ6uy+0SGAgyNr+6TzT4ZwVij62NP7cPStiL/gXwnV1c7Hk
         3ORrsOwdD756dR0d3xG5GPpFwOIgk8glcOJIb8nuFA+KoxrFHL+qORzQ8pECyf0KtDs6
         G1yJS2orINxkLoLfC0ZcQJ/zgd9pZE/pz2A9Zq4iAGpSUWz2rrNLP7DrpxhklRiNnEQL
         RuuSdz2tvKb7pvQdMPoQof5vdIqzPTnCmN67X8cAB71mMJkJ1EGDXENSQwCNRu7H/vfd
         aM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757587053; x=1758191853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBJAhqvEHPrcQ7AuGOAnRt88ljqyRo1HkemhDWzHqMk=;
        b=fdAQYRiHWs0NhdqhBZKarlz6jz1Mx/gDmsQ4h7kGv3s8sw/CO7wkX/H0ekekthCYQm
         CmipCYQZLvhibHnu0MZT9wAX3bwMHAElUtdyDbcjN6g4jq+zy6Oz0bggOd8WSvToG6RC
         JYvGzxcESRYr/e1mzTsAAHxJfUiJkqQ01PEZ2uCwpWi1ypBHoKs1Ew/UthPVTtda52OS
         FihHNC13Ebv21DEbrDBBPRYVKiLtKXmbirlZxAQW+n4yP9KeQee3e2hoObq73j0ue1I3
         CAI1mW7YVCjFYGWg3D5354h5m1+a5Wrw0P7MUe/R1Z52JJFbtVAvJ0VgTHi495BF4qvR
         qp4g==
X-Forwarded-Encrypted: i=1; AJvYcCXVrxoXFgN3VqVgYfcJ5dn/820LdtHS9XDXbMdZaOPjZCLZ1NpeDhpKdMGlOijAiToRONA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ADFqBwiGXgnhDPgZBTXOUQ6NMMynHRijKTiW/coFTAp5D1Am
	9YS3wVS5CxA/Kh8rOpWzv4/w7aLSTi/+425RzG+wp/tSZbK47Yq4bVjXjTx3wdEr0Vzann3+CS6
	hrQcvuMhbYIAVE/DVV3tR3Wa4Y5te/20b39Kuop2/
X-Gm-Gg: ASbGncsh611P2vxQvkoOl0n9dd1ay5CYWEtJRmw/Tbii2oEMZs8kCw5gtjXTm068kBw
	fEsZcbrESckxVabLXv1KtcLsR2kr2Ov3F+9Ygh3+S/8s/G3x+FImrxpOCBHmppf/QQeq/8X3kR+
	CDLkf2NOp2uhNPtS1O9Ai/4xF6NC/67a5mf5Hv4vz+pJ0wImEYj4iLaHt+TwwUFupvXAI546EUY
	3o4+hgU+RNPLA==
X-Google-Smtp-Source: AGHT+IGIfwTrAX+eEwWNUP+gqA0VWd7OCs6gHhATUwsNn4thDtgWH+7/hdJD/+ZIYnscPVsLZtgwRe3URHJuJj1RLH4=
X-Received: by 2002:ac8:588d:0:b0:4b4:9590:e08a with SMTP id
 d75a77b69052e-4b5f848fd2fmr189486841cf.67.1757587052957; Thu, 11 Sep 2025
 03:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-14-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-14-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:37:20 -0700
X-Gm-Features: Ac12FXwkEN44-LdnfGfkXsCmivrlKxkPkl7EsRk6tBWM_mjIrqCCXjB3OREkXDo
Message-ID: <CANn89iKaM5HbOT2wU_qSaSxzyLRfRKz6Y3+AXq9ZmQhWjftMWQ@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 13/14] tcp: accecn: AccECN option ceb/cep and
 ACE field multi-wrap heuristics
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

On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> The AccECN option ceb/cep heuristic algorithm is from AccECN spec
> Appendix A.2.2 to mitigate against false ACE field overflows. Armed
> with ceb delta from option, delivered bytes, and delivered packets it
> is possible to estimate how many times ACE field wrapped.
>
> This calculation is necessary only if more than one wrap is possible.
> Without SACK, delivered bytes and packets are not always trustworthy in
> which case TCP falls back to the simpler no-or-all wraps ceb algorithm.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

