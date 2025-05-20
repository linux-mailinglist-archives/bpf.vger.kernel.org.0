Return-Path: <bpf+bounces-58550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B047ABD538
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 12:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56FD4C44B1
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 10:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC65D254AE4;
	Tue, 20 May 2025 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prwc5KHZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DE264638
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737185; cv=none; b=rabElubDTTH5G5WjEPb3IjeWva80s3+TtxDr2PcByNtEmxyyevooZBbiMm3cu326Fo1Fzr/ie2wjeQyzRLTF/HvS7Rwyz9Fg7EXvo9qUk/uXHnKs8EzJ1JOU+dmPfuG5FQMmTczBF3mx+4Jy6uz7sCZX3GCf5e43DvP0DA0AE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737185; c=relaxed/simple;
	bh=FxL3V0jtFjsgAS59v3HWejoNkoAFlD1rvXtnG6y2Zbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5WDWwhXs1a6fjI+WK6leZg1KiHuO+2EV1DXS1GcLNqwP1ap22odsq+b2U/5eVUanuFoasntSqnxcxoIiUbrbtDr75xgz7Fh8IBYMWsf/WkE3iuAJEcfLGNqTGx8k42RPp5ov0MWVmW/A+B4DUciY/Le5+zP+FgRqsavAYKPua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prwc5KHZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4774ce422easo51786671cf.1
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747737182; x=1748341982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxL3V0jtFjsgAS59v3HWejoNkoAFlD1rvXtnG6y2Zbc=;
        b=prwc5KHZWJYwZG/E2E6gNjC9uxoV3sYoCxCE7jMwXgdvkGeQquFbXA/IN/2AOSyTfd
         ZKsbJAmOe4+qvNi0NZ6OqBL8Yf04VFEPUbUn5XWsDkM19Lz92m5fB8bdaHlA2CVqd3HC
         03Lfv+QUKeSDwC4ZSnF6SExN6dyYO2sDYBhYvEYdAVeH/EjcNdnBbxwFIWAWJSoB998D
         h5l/7Zk2Rx/gWyvGbrU4/60n8yBrR1U9qpznH54tvj1pupUMRfkNogULRFqdANU5he6a
         hVRw9GXEaxbBfc0lw02WRsEY1N3oj1czUCiGVp95zAsqEJY0y2ikM+/QRlqWWBTCaJN4
         1Jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747737182; x=1748341982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxL3V0jtFjsgAS59v3HWejoNkoAFlD1rvXtnG6y2Zbc=;
        b=aUlV1EKS3d+1KNUr41w2Z3Wn28f1K4haV7o+GQXNwh0g+L67mSTyv1+IkNnO4rU5O6
         9YFKeP5uYP7cIHowyC4l4LsWJwo+kUJobL8vGelAu+Zc1uTKO2wmCeCTeUOhuFPecKHN
         tnM89ITf7HBNdnEDsbD+fqo3VyCqxQHWZw54SDjc1F50dBO3ZYecOIsckIpkInw+VrH/
         lpCtPM6H5rz7ImQw3ymtOE9R1+VYsbapRs5Zli7dxUc9fsQRrPINlRj9nrC4MSxMCAxR
         ATodV3Czzr6ZHckuGioq1yNFaA+Bidl5O1JVXboJtiS9AqfJZdEfHiM7SCev2/lQJDwE
         eD3g==
X-Forwarded-Encrypted: i=1; AJvYcCWozXtHM96SpJfDZYBWCSkkn6Ie4F26W8OgDlTy5NmDzjmVkuNoqwiS2re309n8sFSNSPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5T0GFMLhGR+NKGII5GSNh2FuG6gOP8bomcdUiHm5nUym9Ae+8
	57p0X6976zp3QeqWUVrQVEfkUCad7Exiac4BqUafG2tKpv7eQJj99eWOJWZ8U+rwkbjQShT7VzX
	eLR+nHn33tv33c3eUS1IFl3kkf2rPn7E8rRHUT7yLixls6vSfHDifn/rN
X-Gm-Gg: ASbGncsEAMylSIS+DdB3Ng1Bv7ppN72Eb6FzKXotPbVgcqxoi9cY6egPrDkKD+sUq/6
	+CBRdBb/rGFSTLC0XZlMIiPq++bpjsgORdLOwJOvEOl0KbJTbwWOm3pri7ldHx98LNg67BWRmmR
	F0tzXhRWwx9rAqWtgLP9czRli1IUtrsyf33Yfnvj30bfeL
X-Google-Smtp-Source: AGHT+IG9FNIYzv6dcarBeI5m4jU9YZIIxiM6brGC8IDm3JalGai8YqmQwl+Av8YyyDW0xxEWATAg7Oa4qlrNCUjkEMA=
X-Received: by 2002:a05:622a:2619:b0:476:9ac6:2f6c with SMTP id
 d75a77b69052e-494b079cfc3mr302490111cf.18.1747737171816; Tue, 20 May 2025
 03:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-10-chia-yu.chang@nokia-bell-labs.com> <ba1b1b36-cd7f-4b36-9cee-7444c219b4f5@redhat.com>
In-Reply-To: <ba1b1b36-cd7f-4b36-9cee-7444c219b4f5@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 May 2025 03:32:40 -0700
X-Gm-Features: AX0GCFt1sJuWIW2WMnPNpQ3xQRDj0A9NooFrWJ-MWgR_JsUGZDwn2hf4HU1-mHo
Message-ID: <CANn89iLkyC-MfGUTvcV=zr+LYKzMsyv1im1Oft6EAXYb2x0jGw@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 09/15] tcp: accecn: AccECN option
To: Paolo Abeni <pabeni@redhat.com>
Cc: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 2:31=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
> > group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
> > group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
> > group size of tcp_sock_write_rx is increased from 96 to 112.
>
> Note that I'm still concerned by the relevant increase of the cacheline
> groups size. My fear is that this change could defeat some/most of the
> benefist from the cacheline reorg for all tcp users.
>
> Some additional feedback from Eric and/or Neal more than welcome!

I have been trapped lately with production issues, sorry for the delay.

I am still working on an idpf bug, hopefully done today.

Then, I am OOO tomorrow, and can have a look at the whole series on Thursda=
y.

Thanks.

