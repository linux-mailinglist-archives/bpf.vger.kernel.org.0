Return-Path: <bpf+bounces-61292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E00AE46DA
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD3616334C
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37B2252900;
	Mon, 23 Jun 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hz5sKH/0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE091253340
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688711; cv=none; b=CZ7jMNgNIUUo65LDes4b2aPno994k6w22Q+x6KweodzDUMBfK3lYLfbQ68QWyzjxcL/zRKNPrcyMesV4mo/Kwok9Sk29BAUxeeHUHvK59BbzMqg9DV/LsS7i8s85oo3e/IbEH2pO1WQHkMmD7VEyzLQh9l98nd6JPUVR7DSaCTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688711; c=relaxed/simple;
	bh=0UZtMH503c8+1SDVd6iG+rOnSlR2koS5U3DxzW6SI4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDK7MIV+a/XZF2KADI5e6k5c8JJWGNdhtNJ6a9C06ZKhC32M5buL+aEWcob4KulTJcnNy4Wh1cQqLLg4kOVdR65LbDlYrXJcktyP2H4OPDLT1IVU8QFIOVZQcs38PDunasAUJQYsPiQI5iEkn+8OEuIjHa1dJH+rlSFzXmjD6xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hz5sKH/0; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a58f79d6e9so56776181cf.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750688709; x=1751293509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UZtMH503c8+1SDVd6iG+rOnSlR2koS5U3DxzW6SI4E=;
        b=Hz5sKH/0CUqCVy+gyeVDbBluqvWvIWtW/vlElI3RC9jKg+1d9czMYTUOzn/Bq9qn/V
         jn/AMkslROBbF3BWXMUcA9zdtSPBa+WCLXbg2jZ99/6wwqaM7P4CGUtdZpuDNQEdqtww
         pUyRzqSnrdcKoi+RYigvfqbE6QWxd8xB8sjJLNt6ACK/2Qdscc0uamLizbxiGiTjyGGQ
         5YLU5ELu0j/QDsyNxSQOYb7/1aqLms3T4z7xhX+d61PoNO38zN0RauyUMpKY9aLSmNnA
         Il5fTV0bbasKtzVxXezUZCEbZAGNpU/2BcSXRkImS6nZeZ1RhLXpVibByaQOX4tYn86g
         wODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688709; x=1751293509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UZtMH503c8+1SDVd6iG+rOnSlR2koS5U3DxzW6SI4E=;
        b=j9NaPi8Z4WbdmSQEi7RV/DrbCAzS6uzkevjG2ujdchlOaVpZ8YSCtn3kHYCnXvz6FY
         SPdUugIqqgGI7BaJUXOI2GSGIJ4aQQh7RZHV8UBshqOiv6tzuW3wUPtN1IYVjXQCbmjD
         ZOWUUp2jDmUtATFUpLCSB1oh1IhnGMN1eTPH6rm1Slxhkk2alb1U+zO0EWE913Im9Twe
         KIoHiNuK0v7T4mdKIG+wzTFd1uzJaOsxUAcGTLATGJV38Epuh3wQhpEOKC8/dLwTXBSM
         gGiwXJWXqpNz8/7X4JgDXl+7SzdlJzjYC3A0c0686CWmDuMORZZQjPiDrnbhAw7DhSSa
         6E3g==
X-Forwarded-Encrypted: i=1; AJvYcCVJeleVHIEzS/ZFr1uyaQ7Ee6E2NfRpTJlrfXYXTAiefunmRGhDmC5UXMuvq1VehgAr+RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvhiPRJgwjPBalcgHQ+UL2sLMEO4PV3q8uXCgF481bYdW1U4n
	wm6GocRyvOXyYFjw9ADZIXIY1J3gxNxpUa8Am7aFQuXUF9dmtygbW7kbp6xItvIWCGHAnfafN9b
	LM9nrOFLY6uj+NiqvPxIYHuWeDYYUO8xIpNpeT0Gl
X-Gm-Gg: ASbGncuT2Z5A0kBVw6bWpmr/DRa/Ceas9pgCI07NJOS68P8cjIUdRaV1NG7XYDSf7m/
	vNTr/w0psbR+QPKOEp7vDt48Wvvll2ZF8qzDnT2Ukmvcn9AUoLeROvuybLWEj9K4uvUUPDRR1g4
	wwME3VA1tYF5GB6hkPGAzAnqIDixCmNOrEQ94CBVELNeI=
X-Google-Smtp-Source: AGHT+IEmKVWhHe3CQXXXmJ+3AX8EMi+q/7rsvjNQufpnZ23z/jr0CTEgZ/cgGqhdl0YDzCXcGLOX3ClO1xMMJtgKcVk=
X-Received: by 2002:a05:622a:81:b0:4a7:30e2:b31e with SMTP id
 d75a77b69052e-4a77a233d86mr212392981cf.34.1750688708438; Mon, 23 Jun 2025
 07:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-3-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-3-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Jun 2025 07:24:56 -0700
X-Gm-Features: AX0GCFuuumLhEceI4NFGCl3EfDcvOiQNAlPh4nu_8dUwfmmZX_i1-HOe9hb43D0
Message-ID: <CANn89iLzOJ6YqQuQGOm5b8vdbJ12jp_2YTbKW=aGZjsy6FM95g@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 02/15] tcp: fast path functions later
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

On Sat, Jun 21, 2025 at 12:37=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> The following patch will use tcp_ecn_mode_accecn(),
> TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
> __tcp_fast_path_on() to make new flag for AccECN.
>
> No functional changes.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

