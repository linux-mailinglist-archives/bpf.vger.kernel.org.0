Return-Path: <bpf+bounces-61294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE26AE46FB
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 16:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E571895733
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D7263F40;
	Mon, 23 Jun 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t14t9Cz1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924FB26058E
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689454; cv=none; b=qb+anxAeJO+vqzXbfgayhfwZX9J20oMSemo0ZpkSPsf6SXgWVC5O1YTVjxCbTLoeYZ8GI0l1JYnxuIIbf3OXmSfTAxnpE7SFB7wKPpA+jtc+6x/3uMh6dNO95NkLH73KFXva0kDkzNQ6sZuV8UH7zXUowxCYhtJLGZCDvkHSS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689454; c=relaxed/simple;
	bh=27G5tZxM8xD6Y1gt414e7Js81jz9vu52ASWX9h/SSQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0HycrLATVhLqfX/CnCjnUfIKBgGddvg7LFcltpDtG/NklvuO6/QwzgvhpbVofsS5GgbvFCQdVLbf9oQaVJ8JqqzJBx7GDKQOvdgYZi2FJwuBuj2Cups+BX3h4YLj2Gh96t7JyfuexDdstoIEX3fIxChXLfXkJ3pjPD+6yFaWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t14t9Cz1; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a58d95ea53so46103511cf.0
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 07:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750689450; x=1751294250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27G5tZxM8xD6Y1gt414e7Js81jz9vu52ASWX9h/SSQM=;
        b=t14t9Cz1YYDylMAH51+dvK3uxeRs1jmf0OZwwBsa0xkkjITsGvWJ9SHlW+xB0lXM8l
         wti3QseOmeVufU+QSCs1llF9tPv3lYD93CFk9g2L57/aDvqr/sQYkC+jQ+aw4cFn/Om1
         +G/o3JrYxDXpQvBuQoILFwkeqap+qEqIqh6POxlEzGlqmskGysNoFfFPxZjUfbB/w2Ks
         fJga1unG23XP2s94NRXGN4jQlSiobWtl+WhRUQOaJujvYaj6Vbl0mW9r9R3t/xHRJVwZ
         3GioJzJUldJmeFSVu5n8X6U3FSRX0ZyieCuiWBXL+ReEyOJav1w1nkGzqIPft788Qo6T
         dLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750689450; x=1751294250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27G5tZxM8xD6Y1gt414e7Js81jz9vu52ASWX9h/SSQM=;
        b=B02VFzck2SEanGSZzYqvQdrHHcS6ORpWI4u7IF6cgXTg/S3KOJTY1iK6n2oGa4h+7+
         fuFOTCxQCioGMpBjCqsgooBbh/qVtQp9DQQ/0Fe6DkQkl6dwwK+F7zy8HbVAfnmRnhlZ
         eKeZhbXVvnndlGKmg5fc/RwT7buJBHgOxnRk3oHYEWguPyjVPWn9E92J9lSPFpPK0cTO
         CqdmpW/+xL37i1n9ND1EDgltkADgCCBCBhaWp7BR2GQzMK4N1mqJkyiw2HVhKmJ5o0ie
         DGnB9Pz4AhDehHTVqru34wygOeani5kad+IrsA4ourSfANybSQOhYBwPeK72lvkkuGBS
         WTOA==
X-Forwarded-Encrypted: i=1; AJvYcCXkopXDRDO6HcP/ZauUj01l3cpGavfDQT5CQGPzntoTN8FyywuCPTzev3nLGbR5DGh9ahI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtF9jFQoJ2Pe01lBO+ZH6/j8p9Rzk3E6B57/mAVp5wwFddxC+9
	oA853YGixA3D6w0vX6TwPDsEsWEQbyQe+p9DOUnCZ9GbTlzncsBrltKxTlCAmW2Xyy01Br6pRrj
	zVYs3e7uZWWI8uUWzekC6+eQoMsTgKy/EvO2DJG9z
X-Gm-Gg: ASbGncttvTeaK2fug889DRXUh2qrBRMxO24Y4AZOrNsIlNZh+z935CeWZJ/vyMT8iqL
	255kURgTXB9vmuxLFuT3x+laZG9P/IlmrYdS7DRdxwjYaaEDdFSUqTTToYDeF4X8geoNoJAJ+Xh
	or7HEU8YUiFpXgMfbtHllM4QANyDS1uvhl4R/JU1WqCt8=
X-Google-Smtp-Source: AGHT+IErEx0kDAOqp1ojFcDM9yYCZh+mVleoBFl1AEdwsO+17A/oIA84nB9tL4FUjJhJfRwxa3+3/8JyJJH7G1AK0u0=
X-Received: by 2002:a05:622a:750a:b0:4a7:7c8e:1d5 with SMTP id
 d75a77b69052e-4a77c8e083amr154660831cf.17.1750689450031; Mon, 23 Jun 2025
 07:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-4-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-4-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Jun 2025 07:37:19 -0700
X-Gm-Features: AX0GCFuRrhX0LBiCnxAPHQ5MTAVLkaa48kUt8r7GSQvKFHWuAgGT6_YRkQKc9Ek
Message-ID: <CANn89iKXWH8VLY5W+iM4d7MGYL2dMRep2xG-AGGV7BcbJyMY4g@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 03/15] tcp: reorganize tcp_sock_write_txrx
 group for variables later
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
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Use the first 3-byte hole at the beginning of the tcp_sock_write_txrx
> group for 'noneagle'/'rate_app_limited' to fill in the existing hole
> in later patches. Therefore, the group size of tcp_sock_write_txrx is
> reduced from 92 + 4 to 91 + 4. In addition, the group size of
> tcp_sock_write_rx is changed to 96 to fit in the pahole outcome.
> Below are the trimmed pahole outcomes before and after this patch:

Reviewed-by: Eric Dumazet <edumazet@google.com>

