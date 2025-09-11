Return-Path: <bpf+bounces-68098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2388FB52EB3
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 12:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4139D3A3CA3
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 10:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21531159C;
	Thu, 11 Sep 2025 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NiCS0//c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D62D30FF24
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 10:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586980; cv=none; b=d4VYU9QOWdS77+/kojtohIcPKtc9TC8aIf5onfxTuWh9mdl+lXnC8Y1Me+pKCm9+JAXEFAg1IYWMNAB3YsnxlhhnzLqre7VsJzrpR77luQ1z43n0q3Z8L9wZI0QnO0NP+1XYoOTY2w7Fh5quy6VfsyEyIVoNWsa2pQDFDU+95HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586980; c=relaxed/simple;
	bh=fzU09DMCAq3+s6xAcPw9iQSsM2DMfpbhX8B7RMRaHmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoESxSU+vDNGmtRpqwA9oG9R/cQeHCf8OpgamnTC+MdB8Kjh+qjuFIvwc/H0SgmEcTeUEm4AyJ1xz1y4FZjrKE520j8IR7zZVdIc0Hu5Zd8TpbLlRjpttmzM24zagK+2fv64hhF51UbSw1muUv/ioFurj1D3jBNcQB+ILE6unCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NiCS0//c; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-80e2c52703bso46706085a.1
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 03:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757586978; x=1758191778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIp65c74emW84B2YnB6/i2/DDD4Hn+llC22C9hRiCnk=;
        b=NiCS0//cSD0FrocGwKmaptnuhyVu+xdGCjs7S41OVTIIIVnZ0ISxW/VHKQ71EGMwpY
         0Q3RkgOaPwXrnh/ywwA8douNZwBVnTfp3zMH0pV/jIVwBGu/OzJTW2qQKXAvrz04ZV6H
         6HubEQF3Wpt5a2Sqh/+lKXYyavdvqYRUkJuQ8ZrqGlZAp/RmetqYfprBI1M0UKsn7FkR
         k6R3W7S2mVe7e185GenMupvOZmtUrZXG1LJCGujqHx0QMX1twaB3qE/06s39IhB6Yhc4
         ca25L/CY0OfcyP4JyoxOWSZTOTbCDu12yhFJoZ4wPQt/Fh9MlpQpLAnkiXXfK34r6B6t
         6Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757586978; x=1758191778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIp65c74emW84B2YnB6/i2/DDD4Hn+llC22C9hRiCnk=;
        b=g14FqZrsvGLc6vC9Gwf7g1OVqHpJtmm8WM2v/olUwcC3ZBIdzAArwMrQrsDcNlmqVb
         QYeMSAWHB9dfUQ83Iw7dc17EAP2c4iBRzPNYqnkMJqp9K7XvYXTp/oLRAbdEslsb9sq7
         qiDsq85PV0Ru/hzdUECyXILxghW6hxnwXeNF1sjxxrSV7eTAMI3j19z30kOr6P6GMDhC
         6+YL/TnLxyRgfd0n6twdg5LhK+PV0mav0PJ/gw48ir6pElh2o4wEnJwq7IODut1qSX/e
         Lztv0JIm4gFs3kYTOEkMhihs2VTfjYaH/QoAgdT/iQkY66b+LP4ggVuq4Y4HukSKIrTP
         MRaw==
X-Forwarded-Encrypted: i=1; AJvYcCV+o6i0P3WJAF2dIPdATNXdTLC6pc8M0BvxiuqVuGHM1vdR0703X+x7KpFo1Vikpq0rLNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8sc0ZmK+2oS+av1cAJvjv7fFuhzugf0c7li/JxcwWttC9L4j
	S3GmQWeFZQqeJRCwq8fTDsUKat2nrwry+X6qRtziPCUaWKN7rFTIjnJzh+vcYqBXyLobyMRTkm2
	WsqyyZO2lYCd8gU3H1On29B8GzXcEONa0tQMGpNpt
X-Gm-Gg: ASbGnct543EwLlZpwtZ/rMjxXkzSQXrRB5ea5K0ScDP7hydeHIbCMneiP4j0UWwe+id
	94VtJ/rqm9F64THN0PcSg9q76L57lQ1aaJ1kvFj+SUvTXd8LO2GjxPQc3Gi1cmdnS1Oe/earVJr
	Tpx2LMqEvrWjw1SaycFZNiDtnsHHmZD6NRr782uXRdH04cWWRmr9MyKJ78DVQ3p7qTZxfe4146T
	xPLNG9N0DmMig==
X-Google-Smtp-Source: AGHT+IHkeK8FRTt1/uOZZvt19SPsFH61ba3vv8ohKTWkwH3zfvM5AA5iGlKW7xE0TOEjkPaubARP4koKOEFkohcuvOU=
X-Received: by 2002:a05:620a:2985:b0:7fd:6709:f08d with SMTP id
 af79cd13be357-813c70b42a3mr1975265785a.81.1757586977361; Thu, 11 Sep 2025
 03:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-13-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-13-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:36:05 -0700
X-Gm-Features: Ac12FXy6oEMGb8kpdEpmCoxkyIVYHYpg1RYuIGBFn_nQMm1knd9KsxNR4ndbi6g
Message-ID: <CANn89iJcyWE_SxM+sHWM_Es8KibOQpfs+HUTD0G+bnHr3WQn-A@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 12/14] tcp: accecn: AccECN option failure handling
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
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> AccECN option may fail in various way, handle these:
> - Attempt to negotiate the use of AccECN on the 1st retransmitted SYN
>         - From the 2nd retransmitted SYN, stop AccECN negotiation
> - Remove option from SYN/ACK rexmits to handle blackholes
> - If no option arrives in SYN/ACK, assume Option is not usable
>         - If an option arrives later, re-enabled
> - If option is zeroed, disable AccECN option processing
>
> This patch use existing padding bits in tcp_request_sock and
> holes in tcp_sock without increasing the size.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>


...

> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index 53e0e85b52be..00604b7f2f3f 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -316,6 +316,8 @@ struct tcp_info {
>                                          * in milliseconds, including any
>                                          * unfinished recovery.
>                                          */
> +       __u16   tcpi_accecn_fail_mode;
> +       __u16   tcpi_accecn_opt_seen;

We never add fields in the middle of tcp_info , even in a patch series.

Some people might miss this rule in the future, by looking at a patch
doing this,
and repeating the mistake...


>         __u32   tcpi_received_ce;    /* # of CE marks received */
>         __u32   tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters *=
/
>         __u32   tcpi_delivered_e0_bytes;

