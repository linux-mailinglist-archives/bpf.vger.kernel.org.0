Return-Path: <bpf+bounces-79587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E3D3C4F4
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 11:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E229D709E22
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5C5369975;
	Tue, 20 Jan 2026 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGEczJpA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33DE342CB6
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902842; cv=pass; b=BVOtRS/V1fcyBPdC7RulVC57iHkCRqBYcGIiDnz6PQKGgOQLMT0550+Oi5Tn7mfOtIaS+b5PrZMvyygzjc/JEmciuv7mcim0+34RWsa+h3hXDw7rCAZ4ircI9Uz266kEzCt7YGo+k1OCV3GTSbL461VasnWVMcTJg8TkThfQWZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902842; c=relaxed/simple;
	bh=bxs1d0ToON+/Bp2OpxrCQltJoJYi6G5PLdJ09NcDoJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sVnQJtDNqc6T7OLMDejhzwHrWOoMu3+5BRKN5S+5LlXEsteLZcyYwrFMd/cmjFUy2Dprgs4sPG4AJPH+7D4EqNJaF9sWx8J38ejzksvp82gyzdZgDSO4GGJ8Xp1hkuKaoF3ktqBj/qH5ZGmIZ6IliKrtiSJLAnNDCR5/3AHEnoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGEczJpA; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50143fe869fso58954211cf.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 01:54:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768902839; cv=none;
        d=google.com; s=arc-20240605;
        b=aEdCg4jSu2nyE40kLwQGngC5jk40P++OVxQOIaDefBRsy8BbiUQOHT0wSn/ZaMzih5
         d/+zaWZYoqc2KzBjY21S4JqdULCTd91ISlI4XYvhL7zI7pD6xtAxv11Bi5xJT/gHrQZH
         abJI2O6J4ctA7SMsemtfL8JYZ/y5iCiKlR4kw345zcf3R7UGk4QE8M999d4SvO1hfYkx
         j4VNVVhHsRgUWzRrIMuStZx0Y2LVsZsRODz6aYfZgdTWYxPYFoRHxA+rURzE65/mJROX
         +0TBdON1TCNOUFxxVp9rVtR2jkohvBmw45N0a0RRqTZ+tR76lm8T9yLcbBNN9IWpDZRj
         LhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M9+RAXA+S1GCjNSmsIFRavSncliAYK27qdBowu4HD38=;
        fh=R3+dUEnciq3o5sgDFXSEK6Zlzxm9Yg9ZAcEDS615oso=;
        b=YURo9/iLRh1Qq7je48AcZcPTJEKg+FiLlJTdt5/SsYXiuzCJiP1WGVaYZoNTnAvYjO
         a80VQIN2pqdBiT/N6RGqGTD4HQj7lv5JFBF/bMreaZ/2nAO3DIK4UqrNGeu9KvE/5vqd
         p3olqcnWn1BkTuw9kekDqxVxIWWFpuLYMVi16i/W3cNzU8+O9JiJzKCxQWzI2qJ2VENI
         If6ZKBDY0kB0LcBSMOdwgWkVhQjM+9yq8XPMeAU7H00gULn8MsOf0pq/GeQblFAN1wHt
         53HH9RyJQW4Adu6RYzLkS1wqE1aWU/CLnMvzZJ1Kz8srwdPQZRjkll6J+u7TR3xgOm2/
         JgWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768902839; x=1769507639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9+RAXA+S1GCjNSmsIFRavSncliAYK27qdBowu4HD38=;
        b=QGEczJpAluT8c7LsRlygARCVbVUWctoyx6kf6J4lKavXSxu8Tft8yGH7w+4VtaLNbI
         gmNxry7Zm+wZWIhsvmJRByMTZzJ0lzq8JrLRA4jOiIpwoGGEg5Y9OsSwhKAX1tPi3G64
         LMO86/ts6hjaPxxhUKc3RhjlxxRBHKsxa+gZ8qusGSXtES42rbVEntrfnUwQLLgi6fA9
         D96OsslS0f+5XajPPuRKNjUje1eFYzf1vejmO5zI/YlzInRgCCn47FJeDRiOG3ieywru
         CQMk8wn4FISM3SWopCDq5BKSOUR31+WKPJnSKhoPHo9nTobwR8Xxqu46oSg2tKeitxCz
         FALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902839; x=1769507639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9+RAXA+S1GCjNSmsIFRavSncliAYK27qdBowu4HD38=;
        b=QbEd8EylK9jpDUg8RLBt2/Q43gH4gTxcIL0xlGY4vh9zDVYGCL7OFebDpG52eP6dvw
         o7fJjVA2vXjsQwqHsRLwT/39bo0uCwM0BxObo6rNUwRz4CrRvHck93hI3Ec/jqgPar1t
         8HsYDeN5Y+hvt5X6xLCNOvU29QbKNAdl5UqmsToM7K3KHVn0qq30my49Fo+KicZr+MQR
         /g89A0w/Tmdmqctc58yeBCwWX9USKiqQpu2avIAsrucKbgqjtvNLbXxGdBxIFz5fjnj7
         iKSfpy98Al07Y330AtcRNRdcOoYaGh4IfTWZ8ZcJavpHISu978huLtqWtfrjkmD8uYSd
         9s+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4tTfD+AvG/B+j/E/H4RNg605jy1FDIJrznYq208wZNxSec9gaDTwktN6n9x/QmK3ueTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwElo/zp7aPoVVAj/ulW1WPk+xDX3aZsRAVoAzH4l96KLCtOxaG
	v1ePVbk8kYtR1501PClif0rlVPfNImEYtVeTwXx6lqdqa07QhEd7pWLOxe2+lr4xJJHjbFcKYwH
	ka+OKXd6LdJ6i/VKTk0UNsmfyK8syaTvENQiBNFyF
X-Gm-Gg: AY/fxX5BvkpsA7AqPKUU2jj4cO5l2GkgQ1lqWWymm9a/aFanoyP8jfiQxLrkU8THj6Q
	f++YgPj/Nww2k9QgL7Dz3bCpLR4TdoW04f5Qp+b6zuJwk3QPxDujfC0jIzGi3aZ+SfZMnXuEZlG
	BLYHW9kJL9kiR5EUeA6GynKFtdCfhZS0GB6tBaCje7a9u8dJpYkXLoHvXRzn+Lgr7gTb5TYTB3x
	iSIgbzraI9/EOpdfn9/j53KifFLIaS8psZ6rXzxHOgwrDPpW7SftafZcDSjt0gBc9igSW8=
X-Received: by 2002:ac8:7d45:0:b0:501:4a4a:c24e with SMTP id
 d75a77b69052e-502a160b06fmr183731541cf.25.1768902839039; Tue, 20 Jan 2026
 01:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-5-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-5-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 10:53:47 +0100
X-Gm-Features: AZwV_Qg0IWXghbxwuvPJvSjMMI2uFuU_uwIEWxMla7dfzpOOQkjvRiJt8IywSHk
Message-ID: <CANn89iLzynvieqZUVK3NqaSpMT=-toZ1M4QHvQin5gHQM7T8yA@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 04/15] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com, 
	Olivier Tilmans <olivier.tilmans@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Two CA module flags are added in this patch related to AccECN negotiation=
.
> First, a new CA module flag (TCP_CONG_NEEDS_ACCECN) defines that the CA
> expects to negotiate AccECN functionality using the ECE, CWR and AE flags
> in the TCP header.
>
> Second, during ECN negotiation, ECT(0) in the IP header is used. This pat=
ch
> enables CA to control whether ECT(0) or ECT(1) should be used on a per-se=
gment
> basis. A new flag (TCP_CONG_ECT_1_NEGOTIATION) defines the expected ECT v=
alue
> in the IP header by the CA when not-yet initialized for the connection.
>
> The detailed AccECN negotiaotn during the 3WHS can be found in the AccECN=
 spec:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

While for some reason linux uses icsk_ca_ops, I think the terminology
is about "CC : Congestion Control"

Not sure what CA means...

Reviewed-by: Eric Dumazet <edumazet@google.com>

