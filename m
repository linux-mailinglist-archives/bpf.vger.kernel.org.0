Return-Path: <bpf+bounces-53877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4341A5D52A
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 05:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85836189404A
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 04:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C61DB377;
	Wed, 12 Mar 2025 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ctsKdy/D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608403FD4
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741755457; cv=none; b=VYc/iveZk0jzTtcSQfW1471JTMmbEt3hJOS8EWthiortFAqNkivtQz31nnRWCybDRwZxxFks/Cr0OZsqmeB4/51986gPSCrJ14APCxVaWCe0NsvlPhPXvAb5bnp8xNRLJqj5GVrfrJyRkuX5PuA95VSQeo9Kr/IZ8ScfNyrp1o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741755457; c=relaxed/simple;
	bh=gKZ9bkQ9GnEPgrv2Cxvqzv+ZQ4ARoHdoKdw/H8KfwDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qv6ENC4KzRiUFLOdSY+d0bOiidQsD+G04aeHgK+Zyrb5BiNu53a/CAj8/UEBJqqDBG+TUEuewWXkh9W6ocvlZJwd8UhtQ+R/dzepSpNf8+i/t7FwBwjOh1mbiVrOI5W8WQFSyEXhyW6x+w4+5ijsXmbAZYCsWqgjA+A4zmMY5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ctsKdy/D; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47677b77725so32999501cf.3
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 21:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741755455; x=1742360255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKZ9bkQ9GnEPgrv2Cxvqzv+ZQ4ARoHdoKdw/H8KfwDY=;
        b=ctsKdy/DWOEwgbsiWECXHBg5L1Tq9MBpbBU4Q3QLMiVxAN9Od4HPwpXIjpJMYdqa2T
         3lfMBg7D2hm1dyY5HYEElOnbSZIPZAQj/Ijz++4fizBaGX6KRT7N5w/bQ3859amruz36
         +sw8TI3pAUQsHOja/ZS69is8UAqW4VdO5tPn+JgzGYp7bo9hVEq/C71GSi8e0tX4b5VK
         Sn8ebo0sTLTt4fKavQPZ8MYbdJCvxbSDG0HufcGamGwiJ6O4cwCmLdBAShZn1J/vD+yd
         vl23OYtSZtzeE4aRd031ucgYttZkl7lE7J9esHDvT7V2Jmp6eLFgN6mptbm+IhSrL2c5
         FsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741755455; x=1742360255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKZ9bkQ9GnEPgrv2Cxvqzv+ZQ4ARoHdoKdw/H8KfwDY=;
        b=KAe6CkQTmzPlOg83V8vODBZflaxNmgG6W6u1ZjNcSWgIUfJcLP/satFFFdMWHfDpyB
         lFEqnStUHhzJkKx4/uSjx7kIHdxkUMBxKnoTnqYJbVUv1mql8ay1Cf8dyQ1rzEImvJWI
         e0pDwZR1swRWVQiaDRdyN2lYKoERHyNvgJZW9Zg4mR3uATJRRLIiKT2h4lELFi0oczDR
         Bq960i+VdpvwsSkF1QrJFeKBPqzWo/OGYL4FzCngml/Ow11AceUCdszzjjq8f/wrNdl5
         HUEoAXw991dfivIEKNh2cNnHcXT9K1LomCs8TrSrbhc4i/SqkZCcjdpnzeWlISSNDHns
         Mw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8Qo4YE1Wr5op4qWFyAWNNNSH6T/TBn8LTBfDK4zghdUCEnEp++Qd9uMfTHBMxBJzW/6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxipgGRn/5aiOkwZZUIALxs8diGZSIK7VoFv0bdkTjUGX9Dg3Np
	8BFyeaFQOtUpEnK+Wn/S3AlYb/m9GLVVBNkTFYFecZlKQ228fW0umsCchA3WnDr25TYH0ARDB70
	KHz1Ne+Zgxdnq7gDHsLhp4GXJKPGAC5rWkcoJ
X-Gm-Gg: ASbGncsjTz+r4YkzuIYsMG33GKbHnhZIL2o71Foj52J0qB7lt19w/q2f9Ig3zrwyhMw
	YQEc9DErYHeHgwV6fO482HjLdRQ7U1PuL7TrmLjrZLyaLN/7TVyGXUC18vYI9mX1Wa6RlJWXruW
	6O3IzQri5n3jARCjdg/FQ164CR7g==
X-Google-Smtp-Source: AGHT+IFxweTRrmyxD0z2rXDtguA8C4PbQGiHdjMhGYB/p9zTnHYNhw4HqtiRWGPvHWSJ+BUltYwvAME1i+Lvl+uSHyY=
X-Received: by 2002:ac8:7f52:0:b0:476:8825:99ba with SMTP id
 d75a77b69052e-47688259f29mr130462051cf.12.1741755455060; Tue, 11 Mar 2025
 21:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250311085437.14703-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Mar 2025 05:57:24 +0100
X-Gm-Features: AQ5f1JqyplD4RAYNNkjIn99u4w0CrvAAPBXcoao54iBAd_wBxygJhoFMLLEVJQo
Message-ID: <CANn89iJQ3D=Zad1UsqgL=GhfxF8TxiwHgWvT=xchm4scatgbWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] tcp: add some RTO MIN and DELACK MAX
 {bpf_}set/getsockopt supports
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	kuniyu@amazon.com, ncardwell@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:56=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> Introduce bpf_sol_tcp_getsockopt() helper.
>
> Add bpf_getsockopt for RTO MIN and DELACK MAX.
>
> Add setsockopt/getsockopt for RTO MIN and DELACK MAX.
>
> Add corresponding selftests for bpf.
>
> v2
> Link: https://lore.kernel.org/all/20250309123004.85612-1-kerneljasonxing@=
gmail.com/
> 1. add bpf getsockopt common helper
> 2. target bpf-next net branch

Some of us are busy attending netdev conference.

Please split this series in two, one for pure TCP changes and one
other for BPF, and send it after the netdev conference ends.

It is not because BPF stuff is added that suddenly a series can escape
TCP maintainers attention.

Thank you

