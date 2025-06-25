Return-Path: <bpf+bounces-61501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFECAE798F
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 10:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861E35A19B1
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 08:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FC120E011;
	Wed, 25 Jun 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cDli5+K8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283220E01F
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838914; cv=none; b=c9tBunjMfS24MOkb2ScxeH/+IndOYp/rDxOkBzxpio/RSXSdK7gXWC9HMqOMhDcSx7sweXPc4Z0wJkoT6cVXQ2B3aaMJF0ksypzjKTpbNUdykT5jeKAYiwiWV30uph9e+pb+0Rz/hYwjjJC+oLvTnf9K05vpO+CsOz4dBqTH39Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838914; c=relaxed/simple;
	bh=zpwNDepzoTzzaxm0I9H9fOZHI8MES0vs8xLBUSVMd94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwSas/IObvcWKQTjAYvZxyf6VDCkE+PX7HHZaK10kSL8Uaeun3xui+4VshpvT60mh87MfxL0MCwFm7w7sgJ34nd2YELsgvcjlTcYypkv8ylOezeKfzWKODuqN3yWL/lSBXNKUeN5dFVVl9D6ttEHSdLrJt1xco1ujIjnCJnq5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cDli5+K8; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a752944794so14185091cf.3
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750838912; x=1751443712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJWUBaRn+NFbAiZsctR9Sk0rJwoQVmEaF8vNrJMha0=;
        b=cDli5+K8H0157CJRrliEULCG1ImmT23LgRW9zs5uWTXWtjR3MYfnR6xfWJFBUKFqa8
         yFuL75yfM5pBJoFxGGO9nwl0kX4KjyCwoQ53xO4uGltcKKPS9APMbI1mzCOx534VLYI2
         RkJUsUYykepxGLVgoyRrglOAao8bxwgILqL5Pwc2BpWyP4FRDXPAoqpOCoH0x/D/swOx
         ZtCgRXV7sRapZwB6/ExxromsmV+tv6EeO7xcw2sbVJ4+8WB1VHecDXDxj/GcZM9YRdi8
         uUa90ntT9APYjRQMWodVc/WSqy4YOF/baC3lEyoxm7GRkywTkVOrpofltvF/KU1Ox7eg
         tEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750838912; x=1751443712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJWUBaRn+NFbAiZsctR9Sk0rJwoQVmEaF8vNrJMha0=;
        b=gN5NqGL2fWPtfz6iVIxKPkWaxoTnT6YMrWbSLIZhoHTYtGYWwAXWT0H+h2OOlMZx+L
         0G45PMxkEuov6gtzp3sFg1ewm34LTLni/gk2gVYlfBr09JKAMOATj/EMYaLNgvD4TtUj
         XZjJmpYE0REGFsvvvIXuFmKhM4XY+RB75YmoUN07/gaAat5NrKTdOfN4p1qMdrYu4LUA
         8C/MBprOlUtDDqHwHH8+LMa6484BmMYBvdeB4CzTC6Lwo9NmGmsIHNyHXCCykMpeBdYD
         2W2KBUDt7bnvuOzmB9DqcV91tvxNJoIu7t9te0YtvQCQpka5wRhS3MQMv3mmrD4AJzLq
         JfsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlvNBM0+mvhV6S6JkD+yOiKEA87s8WLA94sadz2bNgTDhews0Me3DV+Yh9L8iiAVInPzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu18aue34Wd6s9cckVHq78sK1apCh4iG2DVKdNFlCySYNBR73+
	b0ZJojAxi+HHysO1EHq8QSnpDl4uL/R0+tMVXnnjZS3hdXd6IPmsSX2rrXQrxSJ63G+N39M7efo
	dUil7TcS7JowGkRWiD2UqUggFUbroIWsFZnMhpK7S
X-Gm-Gg: ASbGncuGr7DJMqH8fQGVYPyAp7xFIoghtX+2qFo7eTYEQg4Vx4d012Wk3OO/eMiVGpa
	AMlQkzBx7mHb0/yrt1RI3DBnqolss1VqgqTnQhtxUqWQrK/O+lcwy80IhV0fv9vssjBw7qo+pa4
	8YEBEUmpptF3KJaVefjzCF3XWTmEjMFhZ+hh3KWtKBdHkmhXrNullW
X-Google-Smtp-Source: AGHT+IH2l04goDte8C6MTfBkwicdcfLuBSPT0rwaeShXKmoGSohwlRGdRNtjkixcZ5WnAvB15y3GdC/wXCD1WKJl+GM=
X-Received: by 2002:ac8:5a55:0:b0:4a4:369c:7635 with SMTP id
 d75a77b69052e-4a7c0699e85mr36557401cf.19.1750838911907; Wed, 25 Jun 2025
 01:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Jun 2025 01:08:21 -0700
X-Gm-Features: AX0GCFtvmPCOCoMB53ZiS7lNiinqU-Ptn3ytwDVPBB0CYTmRz2Bl-m-tFudAibs
Message-ID: <CANn89iLmLeUxBh8kU-RgLZ764QsKUqb_4NiwpwhryPi=7RiZ8w@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 08/15] tcp: sack option handling improvements
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

On Sat, Jun 21, 2025 at 12:38=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> 1) Don't early return when sack doesn't fit. AccECN code will be
>    placed after this fragment so no early returns please.
>
> 2) Make sure opts->num_sack_blocks is not left undefined. E.g.,
>    tcp_current_mss() does not memset its opts struct to zero.
>    AccECN code checks if SACK option is present and may even
>    alter it to make room for AccECN option when many SACK blocks
>    are present. Thus, num_sack_blocks needs to be always valid.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

