Return-Path: <bpf+bounces-68213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17100B5436C
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 09:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB57445E9A
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 07:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38829B783;
	Fri, 12 Sep 2025 07:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+JvqXb0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD44287263
	for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660663; cv=none; b=cKNgUw6C859CrpVhQDYcMW3vLDI3T3xHNGlzoaPVkwSnhN44dtu8OKsG1dXAk776BsrAR5Vj27QdwoKE/89shxQpdd8tjUVuG+taWtgzfi6HCgvefxofT28rE+KBRxiboDo4XejN2Sm8PM1z1zmyoAvsLwT+X+/s0wqVkufR8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660663; c=relaxed/simple;
	bh=q/3azkhASRepTVItgM865PhVwehLOoknq13jGplyT2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5xbyMzedmsGBiBOnlzqgpizptUvexGEunkpzZVm0CVUhtLE4tH+KlnBI3QuF/0WDIw+L8XzR6MmELhGXANpeQsifep3y1sMQObovn5wU29WElCjDOLpOoCQuVLlf8PW7fGu9gYIY1M+rPaHOJYPVPG6738VqSEft23taAVpaAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+JvqXb0; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b38d4de61aso22206941cf.0
        for <bpf@vger.kernel.org>; Fri, 12 Sep 2025 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757660660; x=1758265460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/3azkhASRepTVItgM865PhVwehLOoknq13jGplyT2c=;
        b=H+JvqXb0NTY2ziR0DYc9iXXDLkN8PxZJeA27/OMeSJvWepEJy0Wp/qqpG3P/h0zK5b
         1/UyUpMLtjd7x4jR8qaR3HENViubXEgR1JLVutMG0IHUTu7yegsxxlFKITm/yw+Kv8Yk
         9E8MIErhYLOAYb35PcLzX0e38aM3S8CCaZj6BxpnpzoLj1iSdCgongschHnFNr2EWDrL
         QWuO8Bpp9KFGmjebYDErULrUMTT/yiGpmDSfvXypMNpZP5WkM5gSjoCguwGMYnFYLGFq
         U1aWXtbz6kTKXQA10dufjq0dPu2vugkVgtSsf82WYd4on0iEb6ShvnR7qvpQydFy3/df
         mgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757660660; x=1758265460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/3azkhASRepTVItgM865PhVwehLOoknq13jGplyT2c=;
        b=U2hKyaVUCBk1MkUQlFQpA2ZXgKbKvbgLZzZdW5jVNN/JpsDoYCZghfIsqy3Lnv6e1X
         6kg1qOVoVlpRmm57A/+u1dARGmccCFPCRDAS+6PO3RNmqrYHpJTxNoyTpFg/xV6bNNrT
         yKQ1kho4sJ3It6bLDjbaW4NYUVtSxsxEjQInMtxB8wDB0JYUvVaHHMJiu3Ep0JarHowQ
         vbIlDPo1IvaoLIgQy8jVpG9OdChjo+X5ZlrLfBsnM++IXnv5uzz0D3brf+EnXxGYvS7d
         LHB3DByvZg88wvsmT1aqmTQGgAuf0csWo7xWn3mhQ/LvbVrIt839C53FGkItsLctAm0p
         nJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXRTdOSTciwsQxaxN9wxFyfCzz0b2YwPWZ2rReXk53B63zVKZuYT9eqx0xizpZyacUjtzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvbLdlwMFa4H9qjk3nCWLRBWzH+uKpWT1GQjM4j/wWUl7uYBwG
	oITqxFH9IIH7NmnSfj0OzK4hDld/rAj7My+CXEl9C1bUcgJhuecXavOze99z80bk8jyRzIQKRpd
	B+33sPFya8etrQ3yd/BSDZi6NMHNzRk1p2J8DpyTI
X-Gm-Gg: ASbGncuGg0jpCqXs/B3q7iCUnfuIyVBXHcI+J2ZefydWQqoznf9VimMmb+Z+iS7wIga
	qN/YkiRjbEtdnUWZz0MwOo58+eoGM6npKn18e0sZjRPp/J8p0Pu36hdacwmeWyLu/qrb8mqKLZc
	azPm3M9ZsTD2n3aU08Lj+p5tvQugkI6EybHw7d4wRfeY+t9cn4G4d3NLLqYc9NVMs6Y+7b2CQ8t
	NYw+RcgYIgcOeJQWnmH7Q==
X-Google-Smtp-Source: AGHT+IHgWpsGKQ730X4wPp2YJnGKAlEQTxGeuAX55Bp6TeDYnQIZhudmoMoA+b7dxsgyn8zLKB8Su+Ge7eawJWqcabc=
X-Received: by 2002:ac8:5882:0:b0:4b6:33e6:bc04 with SMTP id
 d75a77b69052e-4b77d05a075mr20716431cf.60.1757660659500; Fri, 12 Sep 2025
 00:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911230743.2551-3-anderson@allelesecurity.com> <CAJwJo6bsZg-arM6GAQM8Lv3DivWUERu0VyFQgi4DA+SxRrZypw@mail.gmail.com>
In-Reply-To: <CAJwJo6bsZg-arM6GAQM8Lv3DivWUERu0VyFQgi4DA+SxRrZypw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Sep 2025 00:04:07 -0700
X-Gm-Features: Ac12FXy4bKErw1s13GarDS8xoicxXKEJIYUhfNSFduEdoTfv6TSJEbr9zbXNqeY
Message-ID: <CANn89i+MPuFReHcGsp6B=40N7kvkDjZipY7ZFZXTkv+erzk8OQ@mail.gmail.com>
Subject: Re: [PATCH v3] net/tcp: Fix a NULL pointer dereference when using
 TCP-AO with TCP_REPAIR
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Anderson Nascimento <anderson@allelesecurity.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Salam Noureddine <noureddine@arista.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 4:27=E2=80=AFPM Dmitry Safonov <0x7f454c46@gmail.co=
m> wrote:
>
> On Fri, 12 Sept 2025 at 00:23, Anderson Nascimento

> LGTM, thanks for your fix!
>
> Reviewed-by: Dmitry Safonov <0x7f454c46@gmail.com>

Same, thanks for the fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>

