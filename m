Return-Path: <bpf+bounces-22747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB12A8684F2
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 01:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C368B22B0B
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 00:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D1681F;
	Tue, 27 Feb 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+v/X80l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316BA376
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993231; cv=none; b=EQ57iygI5gzs6OxPRFMW7jqC12IrYNWtET9FmhKzV3LtpVZ5+xHMYMjwH4cvpVg66NPfpg7Xj8MAoiMoxEFF2NRql572P4iJsX+ZWACdNNSyCacv35nTVuganJbwPMxX2/JoKJDQRHVcteUyJj/yvejnKRQHoycBYv+99pc+A2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993231; c=relaxed/simple;
	bh=kD7Ho5vWIa5qzv+7p10TUuvMzBHfz5/jjsy1s5Yhhic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBeLzTv6RTIDI4Dkisgf5YcbqA5pDSJ74MxySZyRCeeh6kW62gfW0HrJ4bpa5p272mMg4LN4oq/WWiiukXBFmKgngmT5RQAu1MEDLUY+a+CpvflhHlKNVxm9LbdP3RZ2I/2a+qRgrzgvsRZkDCwT4pNVYkdLoEiU/eBfOcrIglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+v/X80l; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d8739ddd4so2844302f8f.2
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 16:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708993227; x=1709598027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjgQUBsNCGcu13+XB9WIRwi54S7VlQsBPwtLifMzGEw=;
        b=f+v/X80lCJvQtFoxdZp3kWtmPVPITMmNnuEED6zfXZYBZn4KmKfynE2yE+OJBKMMD0
         PgM6Ng6Nt5X8OC9jKt2Dc9yDqkCd4SPgYSJdUdmiS0keRKNTz1s2unabMJeDCIPrt6wN
         k5sNnkhTCBqT/9ilQl89dmWCxOyjdg+gv20xLBGbK3+u9NclH/qaW9q+381ulRvacjvz
         VLmiaZitKO1dAQ/tL7vrIjj/qFltq5GDZg8qC5HVPCT7EMroPxF4Oiytbg56liuhhjy7
         3+KUg+Ey5hQkzHEsFY/EzvudkKkYhFZ1ry6uZkw9B3jHf8MVJqPt0pIN76SyluUbWgHv
         nThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708993227; x=1709598027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjgQUBsNCGcu13+XB9WIRwi54S7VlQsBPwtLifMzGEw=;
        b=v2f4BTVdJyxb6CpYplZHg9cgoRlAgPQy9aFK/JHJEw7L2v+gKxQpO3oe906wkW9eoO
         qD2di0bCM37uGWasLnE48aNXAgx8UYlBhcnbesMF4U+oLV9kDzbZ1YiACLUzJig2K/EX
         SSolbb0mujzgObwdoMsuFpg/4UXA2l5ZY7teDp8V0B4yLbQJjKv9hdYA3JW2604qi+f5
         rIBxkwcuHEb0xJKdt1jr2mwP7Xua18fFPT4tl8m4X7ort3szt0MDOX0KmlQVbpgVsdHd
         rHjRPEzI9+XdSzBauyoYSrV5ru/hHHlSol8CAALkMcqBg4QhjZNEQ1c2WHA8xuW1Bfud
         VDKA==
X-Forwarded-Encrypted: i=1; AJvYcCWKkjcw3Wy98En0T9AcrrrKrVKyxX0mJ7ox60Uc/qm5fb4RE3CW3JiUqKxqNS2TrRWaEGmHsXvRhiZezD1Y6BCokNgd
X-Gm-Message-State: AOJu0YxZpPJ0hsWCM9yd81LVbzWeA50Kfusya2PQEmsfwVEQZXq7t36v
	ECyZLurcdoSU7KV72CJq5cHfRzXT6v71jgLYdjO1qM1Tx8W2MGo6t7YbknQ9XJ7p03gxpBOLYD9
	LE+3aMRSjFTeGFTmk1mA/apzpm0E=
X-Google-Smtp-Source: AGHT+IES0hl+g59F7zRZmy5q7l4sHMvphb+qii873s984YvhkwTxSGuXimASwWOZsNvrBww5oSaVa3Cwydq1L5lNT+0=
X-Received: by 2002:a5d:6d85:0:b0:33d:da6e:b7ed with SMTP id
 l5-20020a5d6d85000000b0033dda6eb7edmr3861599wrs.18.1708993226953; Mon, 26 Feb
 2024 16:20:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218114818.13585-1-laoar.shao@gmail.com> <20240218114818.13585-2-laoar.shao@gmail.com>
 <65dd1d0d6e41b_20e0a208a9@john.notmuch>
In-Reply-To: <65dd1d0d6e41b_20e0a208a9@john.notmuch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 26 Feb 2024 16:20:15 -0800
Message-ID: <CAADnVQKtL0mo2pqcKtOJ+nzG0K72dhH47KZP_-O06U6pfvzb1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bits iterator
To: John Fastabend <john.fastabend@gmail.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 3:21=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
> > +__bpf_kfunc int *bpf_iter_bits_next(struct bpf_iter_bits *it)
> > +{
> > +     struct bpf_iter_bits_kern *kit =3D (void *)it;
> > +     const unsigned long *bits =3D kit->bits;
> > +     int bit;
> > +
> > +     if (!bits)
> > +             return NULL;
> > +
> > +     bit =3D find_next_bit(bits, kit->nr_bits, kit->bit + 1);
>
> Seems like this should be ok over unsafe memory as long as find_next_bit
> is bounded?

Are you proposing to add find_next_bit() as a kfunc instead?

With the bpf_can_loop() proposal these two can be combined and
it will probably achieve the same result.
But imo this iterator is small enough to get in now and
delete later when there is a better way.
Ideally we'd need to add new instructions to operate with bits efficiently.

