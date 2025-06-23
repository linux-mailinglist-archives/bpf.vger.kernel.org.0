Return-Path: <bpf+bounces-61299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B6BAE4AA7
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 18:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB997AD95D
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754BF29CB40;
	Mon, 23 Jun 2025 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvvWkioS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89323C51F
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695254; cv=none; b=oJGi+e1PC5WXOVZL6JqlxrMjjLLsdLtDzZ7KnS8dPwXP6NmfFyYvaLBW5/a0mgXQzT4fYMs4ZJTzvdSbfK4PESdu9l5yw4QgYcVmFvWk/znNvfukkqqOVugpP09YZ9NIxaY99xdpXhgCZqjjUTRJKt7nGx8rzdTI4ZLehrx4zL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695254; c=relaxed/simple;
	bh=Tz+moTFStFX1YX39jWCVWhxsp1nVbvbMEnciDuWFgg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmNr5t/F0NG47T3KJzIShM+n+pk0Hx8lDQwT3x4M8EyDcHbHIZmpG+jRxJbg02PCwX3B+UVir4NA52KHM0IBEPFZScsYYlffLyO/49Tf3fH1Zxy89W9xdHB6ildpAK1rVsRMuKWsywjjZvHN0G7U9N5urz1sapmVrvT4fuPxv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gvvWkioS; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58ba6c945so74275841cf.2
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750695250; x=1751300050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN+RSCnSaEyeOJOV22jB+Ns6YfYfbuKVTQFf93dpJN8=;
        b=gvvWkioSl67jjGr10PTQQbIlXYXFSOz+Z6BtomHgsf5xPkkU/kGiapFMoBfZUN+U+Z
         PmKLO+iCoRzYV+tRxsXYCbrKhyAa1hdTqOH09Hl4u0xClAtggzbulu0ZRR7kzldIpDvE
         IwUMIZ5OTZawrkly0Dh1AcIANi1TWz5FjW9vPINoUGfMEbsrcNdIS2XQQShLb/nxi2Mc
         uUtzKrWqqLBNt14ACAOTgcBlZW5vSthVqcUdQXYPKfoMR8iTGATIR9MJO6l+HG2j3KFK
         XadtpyQk6YSNilylWwOUrTJbFS10f/Icks5jOR77h3zDvY5TAiF+pkPNiPdYPAMCO+6I
         7U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750695250; x=1751300050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wN+RSCnSaEyeOJOV22jB+Ns6YfYfbuKVTQFf93dpJN8=;
        b=Dstn3XL4a9Qoqi3I405r+4Xd2SQ/ZOTzn7PNIK7okAgBmqW+nBi3WJn3QJSK+S3Khk
         1C7/B7OzXYPxiDCFxUA6J4pn6bvVMslvbeZ1+fiIUNMLI0anujMwFiLNBetOaG1lqGk5
         Ani/XR3DJgdInw9QldPdxRHDMtAcHF9iaCuisJ16n3QzOYwoi0rE+Ly7GLgb5EQkjYu9
         HkxrlURZe9jvB7LfyqlIXe3dH7oY5khSESCol0NNt6Yf3vcuJHSVrOlyoF6ApNXQRX2m
         9W/uQiApbdnJ/mQV2wTceFYz+lW5lp3zPrc9B0gUFa+4nkhlPSGvc8+Xn636/tzUoviz
         /tyg==
X-Forwarded-Encrypted: i=1; AJvYcCUCcEGUiGpMngqBuQ9QlunztX8bn4Pn3gifdn3ECvHuRr8hk+f5oIAyjEPJeri8Rt8Bc+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBEyMw1TrQNDhVUGeMBVbFEv8CzCdBVwia+h2auhMwsqkMULgl
	7cxhn5uZwgWXv0dXf5QKZMDbU5dK3O81z8mgCAyKCf2lU3YQ3E3ACZWBP0sTgrTUZFG9eJ22OGA
	0H4tDW/9rZ6KsLAvcRFzb5oXGb0n8lTNwY3t/pcE1
X-Gm-Gg: ASbGncvHlvsSKeQqLXcShtst7W+ZFswTMVmCcjHllLWwxc+1pyHFAEcgrm/qJfRXY1q
	ELhy+WIWpei7pkf+yMimNN/FLDvCuv+4wL0PdN5MqUuQPvNltJIhMqSN7dOezIpNJ59glL0rWKz
	5R7he79PDyOeNomEeBVjXdL7MbEEGChaz86obUal3AUjQ=
X-Google-Smtp-Source: AGHT+IEobn0And7X+FnotCoZ870DRkq0dQIwi5clxpS4xb+1xJRmqq200eOqBXI6G1dwNYsWyv6mWhZ2d1yR0qDuYeA=
X-Received: by 2002:a05:622a:610e:b0:4a4:3a34:ee71 with SMTP id
 d75a77b69052e-4a77a2b6514mr178869141cf.29.1750695250190; Mon, 23 Jun 2025
 09:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-5-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-5-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Jun 2025 09:13:59 -0700
X-Gm-Features: AX0GCFsz5JzbRrh0-kqOwf2TSk7Ef6ZqFtN_ZPJc01ldHoBLtqqmmWiHN33x0qI
Message-ID: <CANn89iKLKzvkLkPY67286+dKC4fGS3VtP_YhL00BmS6-0yXKxQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 04/15] tcp: AccECN core
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
	Jason_Livingood@comcast.com, vidhi_goel@apple.com, 
	Olivier Tilmans <olivier.tilmans@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:37=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> This change implements Accurate ECN without negotiation and
> AccECN Option (that will be added by later changes). Based on
> AccECN specifications:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>
> Accurate ECN allows feeding back the number of CE (congestion
> experienced) marks accurately to the sender in contrast to
> RFC3168 ECN that can only signal one marks-seen-yes/no per RTT.
> Congestion control algorithms can take advantage of the accurate
> ECN information to fine-tune their congestion response to avoid
> drastic rate reduction when only mild congestion is encountered.
>
> With Accurate ECN, tp->received_ce (r.cep in AccECN spec) keeps
> track of how many segments have arrived with a CE mark. Accurate
> ECN uses ACE field (ECE, CWR, AE) to communicate the value back
> to the sender which updates tp->delivered_ce (s.cep) based on the
> feedback. This signalling channel is lossy when ACE field overflow
> occurs.
>
> Conservative strategy is selected here to deal with the ACE
> overflow, however, some strategies using the AccECN option later
> in the overall patchset mitigate against false overflows detected.
>
> The ACE field values on the wire are offset by
> TCP_ACCECN_CEP_INIT_OFFSET. Delivered_ce/received_ce count the
> real CE marks rather than forcing all downstream users to adapt
> to the wire offset.
>
> This patch uses the first 1-byte hole and the last 4-byte hole of
> the tcp_sock_write_txrx for 'received_ce_pending' and 'received_ce'.
> Also, the group size of tcp_sock_write_txrx is increased from
> 91 + 4 to 95 + 4 due to the new u32 received_ce member. Below are
> the trimmed pahole outcomes before and after this patch.
>

> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> ---
> v9:
> - Use tcp_data_ecn_check() to set TCP_ECN_SEE flag only for RFC3168 ECN
> - Add comments about setting TCP_ECN_SEEN flag for RFC3168 and Accruate E=
CN

Reviewed-by: Eric Dumazet <edumazet@google.com>

