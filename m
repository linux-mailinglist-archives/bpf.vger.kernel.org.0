Return-Path: <bpf+bounces-66478-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5C1B34FDE
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFDCE161440
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D0EDF72;
	Tue, 26 Aug 2025 00:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV+o8507"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74838634;
	Tue, 26 Aug 2025 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756166501; cv=none; b=RpwKv/lXws9vLDVwTS5Lv9cpUmfQxGIEOlU2xhaGxjFQh9lzO9W7+ngs4inOzkulfk+a1SaItV53w+7RltoF3VLoxwlCFEFoDExyMNSboLmv8gG6XXuWB2y0rexl9ICkl9Q0CjzUk9XmQCWRM0wJBrVLm/ZMSQLwOl2plV+esr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756166501; c=relaxed/simple;
	bh=HtTMIa6cdbcUcyv+TTCurR+v0IZSvEVad7NmhFlzuSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSdZaow6+EwUU6ML5F/wnwp9ljMLO2XcOk50j2b+T4Z76Irfwtd3ZgN7zhvPqyNbYmguT8EttEZ9eLIzbv5/jv24UX9m94jWWInNxPHQgf449DtWEqStWZfnSiW3ae5f4SFp3aHpJr6QbQZmXGqy0QeVj4Qo2zikmjgftjKm9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV+o8507; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3eb6da24859so15106925ab.3;
        Mon, 25 Aug 2025 17:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756166499; x=1756771299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6R60g5ZvdXNjJZasDZfehuGJZ3WGntUi3KRsQlv53M=;
        b=WV+o8507DwZgw4Mt8neB0qowE5EJOea9t2CZzNyGFEvj6YR/s1gg1kVoVFceGgudNy
         x5CT22DRNpuGMVbGQpbI3KbubAiDvf8MkT/ZFt8MwME27M39lBN5W+l/3uuZEpks5PVY
         xzATuh1LaRmxzHvDxwqaUaTliPtT0QiVON9nnf+2VPLBgMQd0LYpLQowBSHxvURb2GN5
         pBMlj2V/zuF/buAwG/5ARFs6nHBto9DA9aOCEqSJ3XuWk9BnzPHmUptpL71zLlRULwCl
         VWSA7WgQXbVijO4V+9t/wVGh3ID6zEkl4/kuo2Wa+yd3FG5JUFNxtMhufsqHHFOIopvh
         P3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756166499; x=1756771299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6R60g5ZvdXNjJZasDZfehuGJZ3WGntUi3KRsQlv53M=;
        b=fekh+elQp0ue2MwmJCNCddivclHtcqF8Vhdxw4h/SJtbaB4ehAcQ5av9JxORWgi1iL
         kbzNpVemRGVlSMj6hiQDr3D90Am35wkgrfCt+2a28bMrpYjTplPxjXxQEUWDfXNfHPEJ
         PcjAPIDHObYBDD7tFMpXueQAvwoWMKsLaVic6D4tg5b6moGyEViZPzJUI8GOZe12URPk
         CsF1jD96clio54+BMXDe6rZcvTiNBgQGGftNFQPjmJxeP+eOmmImAkjQsyxxcJQnusmF
         43Q5LvtE2ss38tU7TBPRBb/PStoSGVgX7Cen5TIZxk2WbnXuj4wO4+gIu3zoEDBQdOzy
         pQCw==
X-Forwarded-Encrypted: i=1; AJvYcCUK0RyDlT6dp/ow5dNymllDE0XvNu6Q1bX1wv9OPred6ZmFij6+W7jEMxwrdEyCZOZsNQs=@vger.kernel.org, AJvYcCVQEXEuAEOQ+8iQyyCV+qGaKuEKgKeiPg4W0XwsYf8uq1LGpuJh06hP/xt/0r01d72lzz9Q7uB4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02Fd3wGSZTH2TY6P2lO25NbDP8mrewDYzu/8M6mjyvJqSvB1b
	y0M640BzAEpQEpZ2oJjZn4MUFfajsMbVXDolbx+R8bIdmszSVj/izreCa5hj17SotWrdheqyA0d
	9Qw86WA9WWI4z/XK0hnqt/UVOPQr4x1A=
X-Gm-Gg: ASbGncsJo/SwZwnNISQ2z2QWyQWsvJI1+KDD7U/LQrqN4H4opNiIayQpJ6dgIQcY8Hh
	7rx+xC55NqNsXRYyGqNvLEC7xZa4bguyR4VxS0JR+S78zPV4hXn/8yO0W3ix6URSfLK6qVWqktP
	GH9mH6HpOJvbXL0hEmNq/86ooT6ni9pT3MrS9E5M8utjG4Qrzt6KMXKBVU8YDfktBAAE0MUHzF0
	IVldA8VWNSaSdALxLqrp8WbmQI=
X-Google-Smtp-Source: AGHT+IHfUzoSBE2tzAUvRnkiyuyx8KmjHBCD91Dra7abo0PtvpXzLKvZTx1KnbQY8HCr8D9unHz8s3svkNzw9bdTdVo=
X-Received: by 2002:a05:6e02:3c03:b0:3e5:5e09:4484 with SMTP id
 e9e14a558f8ab-3e9201fd78bmr214176325ab.6.1756166499377; Mon, 25 Aug 2025
 17:01:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825135342.53110-1-kerneljasonxing@gmail.com> <20250825104437.5349512c@kernel.org>
In-Reply-To: <20250825104437.5349512c@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Aug 2025 08:01:03 +0800
X-Gm-Features: Ac12FXxAtnAeFVPKP-_fEYcZ45PXMQiFxVCyyJq_iocPV33UHnvnOa7tIeFF9WE
Message-ID: <CAL+tcoCxzyBxhCes-4OfBAePpQK3jvSRSBufo0eu6afb4hdSaA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/9] xsk: improvement performance in copy mode
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 25 Aug 2025 21:53:33 +0800 Jason Xing wrote:
> > copy mode:   1,109,754 pps
> > batch mode:  2,393,498 pps (+115.6%)
> > xmit.more:   3,024,110 pps (+172.5%)
> > zc mode:    14,879,414 pps
>
> I've asked you multiple times to add comparison with the performance
> of AF_PACKET. What's the disconnect?

Sorry for missing the question. I'm not very familiar with how to run the
test based on AF_PACKET. Could you point it out for me? Thanks.

I remember the very initial version of AF_XDP was pure AF_PACKET. So
may I ask why we expect to see the comparison between them?

Thanks,
Jason

