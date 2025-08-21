Return-Path: <bpf+bounces-66157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E17CAB2F300
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 10:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92021C26DCA
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D28F2ED848;
	Thu, 21 Aug 2025 08:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZ6ZQ8CL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5072ECEBF
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766433; cv=none; b=KjLkjpQ56iI9iBzmtVQpYK5zoErbe/rG1989AwNZ1O6GVaYTSEYGk7KW80u3BFGW0Vo3PouZLMj5r608rsGGnYIa5OxSj1LDAdyRLIkU+D7T60w6ENok6fldr/7KZ4WOpJIu6OjkX0OXwG6niQFBAs5Nsh6q8Wzaj6AkMit5mlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766433; c=relaxed/simple;
	bh=aBhzP6d3YQDrwI7ND5rpwO6HjIyfUepP/sZomCKrjm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1JDOoQCfJNMpoV429LgJJrn0y7zEXNUkndiNtnZW0BmSnJl8p91P6YdkVwvDcuO6TqZv5NaCpiO06q+/yz8PYHy04ZLqRQ3anqOx9/34G4PLgrwKUnV5gNnic92bq6KjvERS3Gtgd9Hnl9h4Z4REHcqUsSUGvPjmdd+kk5W3/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZ6ZQ8CL; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b297962b9cso6994671cf.2
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 01:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755766430; x=1756371230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBhzP6d3YQDrwI7ND5rpwO6HjIyfUepP/sZomCKrjm8=;
        b=gZ6ZQ8CLB54J23MX/pt7FqW269gE8bsMDwn21mPtLT1bevECMXpZpl21m1w6brOzBu
         oD6kz2uLAhFXuUSa1JYnGDvF9Zlm3WtzvlcetMDIrjNtJ0N8w6WeE4ioy+2F2bq4Mwg8
         FsI+nj+q/zSl48nemYBRa4/Z8uUOB7/vrRKfzt5bkWvrb04M0tqPX1r4prY/Iss0AMs+
         6T5MhmhMbywueAOuCjOS4vHAwZDOcrkq2nm2esudyoTgS0uBf2DfYxynGv6Dw7XH8VG2
         CVzWYtowqIDYUI+LP/UQOdn6KpiezjhugF9HtEkJ3YEULL2oQ0eXqKeg08ILMfKcLP/U
         rXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766430; x=1756371230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBhzP6d3YQDrwI7ND5rpwO6HjIyfUepP/sZomCKrjm8=;
        b=iNo7Lhquekozp8J/pgBCQ/yCRGabOTK8NB1Iwvj3Goiwpv9xKEtpfZg1PgH9PIROCG
         BHBtSsnFQe2ovZthE37u2G2gpEoQ56xgxUEXS9gdPGUP8Z8yOcLeWdeTSppT2k2T3rDX
         ohV9VEzBR/7eaGMF9623LKFCbf7pKB7hl0Eln5srfXDoMoIf7WcT7PEHUkEVqzcXtqQ5
         hiJcJVs1ecgEcbiUrXX7PZbV/+9lsDmyEOAD9R4Fw+JSos6XUCoeBQVvmCYRTvSxzhLV
         CcIqYo/czZNOU8cfiDMoIsvnKyEpXIcfTgdpzDp5tqcZJnhqvheqJB/j4Spxt0vyzTh7
         O0JA==
X-Forwarded-Encrypted: i=1; AJvYcCXa2IeSN+Tqs8wrxOSeEKtuMK792NJ1xFsNbcKCCOxnbwMnKZTBAj2p7I7Ik/jQcgMcfq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtl9sxSpCK91rH/eHnX495ZVmnGQgf8MjjsoaZCjKGSpFAhNbj
	iDhBr0QGtdU1P9q1zVS8XfWbsfW+CTU+NtGfqlfmtzSUhPzS5y4WioW2EOYwBg0DSk7T8iA6W00
	oBHLImu2jSlzffCog27zyLWxzb6e67BDDVrOik2+9
X-Gm-Gg: ASbGncsJemTGpASV4oaGgsTGKTkzeRtNYRU8VTLUDEWsGsno3ZZxeOcmtzeMqGoTMfi
	5UOT7sFzmlh1iKYLcw5FWVTPW62YxVDWJuaXyw9Bo+FHiI1Zz3pa8ZyuNRnUuKI7zHL5VsdRb0x
	ave6QedBrEiS92T6luV+OLTpeBXd41FlmCRHoNPSUELhIaLn97ifvMqTIX7nKSVT7tOBrsqM2mc
	FrxewCr9iZYFkMLRU75mT3Sjg==
X-Google-Smtp-Source: AGHT+IFv/PtcOPUQj2eIhfJGxSY/JvZ2K28lWNXCVsP0qeHLxlQhiCXLQmPIYrOD4LLNF/m/ke6DWecfHMX5teVadAA=
X-Received: by 2002:a05:622a:1115:b0:4b0:6836:6efa with SMTP id
 d75a77b69052e-4b29fa33f1cmr12068061cf.17.1755766430147; Thu, 21 Aug 2025
 01:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-5-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-5-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 01:53:39 -0700
X-Gm-Features: Ac12FXyHsFmM4Y6s9A4jizpJZU8-dSIL1pxwxTNu7e_RRTYEAUIKywp1b0fLC34
Message-ID: <CANn89iJn24y7pfqOL9unDK2WX9wjVwTRXjsY0ABdHtxQzexS_Q@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 04/14] tcp: ecn functions in separated
 include file
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
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> The following patches will modify ECN helpers and add AccECN herlpers,
> and this patch moves the existing ones into a separated include file.
>
> No functional changes.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

