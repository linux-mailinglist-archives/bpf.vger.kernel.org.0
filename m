Return-Path: <bpf+bounces-20236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D9D83AD75
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 16:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6D21C25655
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D277C7CF13;
	Wed, 24 Jan 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/H438GI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32147C09A;
	Wed, 24 Jan 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110509; cv=none; b=KLQhZgW8ufy9ZpGJpmMNNoFVJ6YzaCz9f6IBsu9LTQB4pazjYRQEgum9gcCNmCR7T6xe1wMwQHmnrV2Ud4nwVwaoNMemETfyspDZNdabNNvhIJLf/LBx0O25Kz/JQqTwA+mtj6eMrAFZR2AsnT2BzNUv0euOAs4ry1v2k0cvB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110509; c=relaxed/simple;
	bh=+8JTMV1B+xUws5Fqq/KkkTH19dYQj6SUFIZ+eCArfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twHvT73C0rVGgnNhnr+3V+kqjRWfRotonVw1FWI62E0VWDNPWvzkxfOiRqbOYSODhsRVB5XbL9pZk3PyBHhg6E8ZEnkhmrVxA7UZjsbzuYxRhJtXUGW5MjgmZS2QMj/pTdrb2Dw1HgRuoGV1eBVVA4PLMRfQCfKJlqMQ0qWUQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/H438GI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-339208f5105so4827070f8f.1;
        Wed, 24 Jan 2024 07:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706110506; x=1706715306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq3rHmajHdoRuvin6AmYJUUivHaABBxlRIi8R3NRBWo=;
        b=I/H438GIZXCk+bjRuq3B/KY8pe4xm0Jn3YdiZrTZl0k4xTwnTUHEdZ4oTzTY8nqnFc
         Vu0yN9ymk4lUYiKImo5RBeZwhZaBnO7rggTtjWoTwIVhdUn9dKECw8Ab4oIV1/6A5RdO
         p/1k7QT8xUIyFiIp9LMz32RNQHbDkUjWF1zBcwSUdH+Wz13doWFKuUQen1rOgIGHL4x7
         2N8nx0zsvfad1lxzfOg0WAbEzuzgEES+I9KE93SGYdFerFTUT7YKV/WhvwBwcPIg0wUg
         TedBwlcIGM/UJrkG/D2TNyjSVuDZwiY7l+xLVr4NBz8z1M+nNSbXMG/sO2QelU9EyTwe
         ehQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110506; x=1706715306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq3rHmajHdoRuvin6AmYJUUivHaABBxlRIi8R3NRBWo=;
        b=UF+Vs+6SsHotRK/FHuE3g1PD3OtwIS5SuyiW1lJM4wk34Acahe+y7aDyXrvRFmOvlP
         mIZIqhxJHZu0fIQlE3klIZsbVe53vvHM4FTg6eWPLpnLz+2ZOTwcjL83hijEn/EzDYwB
         dnhtsFaM63Y0UW/iyWWS/8C83SQaimBjmLucyzzcyCNT3zubfKD/WZRCcjVAyQkV1+4w
         XUnGwZ3mAeGvubuPWLWvS2CCLlJCZI0nn3poByx6/bx4pxfzR54hCF0AlSoYD3Ta5LVt
         W+u6YklMExZJl06qtFpUdLi8/eq46wq+89fw+k0mV3h7cvWxeHwLqeRh+zIorjTqmYay
         5j6w==
X-Gm-Message-State: AOJu0YxqcptXV8YRnQYR2JlAbI/U5AaJT1XFY/ah7bLhzvzq8UeLgM96
	U6DUOK+W0LB/YZYJr16vUp4aS7d71gLulZkqsuSQlLGguvMhPMBZyUlmFGDdw6ctKBcKZwh66zI
	f1G/0RqDo16cm04GRk/ESamwOGBk=
X-Google-Smtp-Source: AGHT+IFyW3CbLgXs+fHEYb4Mq62sD30ZjNWsYFvjEe0YQggvEANXkHJWwyuCvTOMp+X3qpF5stjBqdV62fWDzTndjpE=
X-Received: by 2002:a5d:4211:0:b0:337:aa5c:a8c6 with SMTP id
 n17-20020a5d4211000000b00337aa5ca8c6mr491519wrq.128.1706110505854; Wed, 24
 Jan 2024 07:35:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124121605.1c4cc5bc@canb.auug.org.au> <CAADnVQKBCpkwx1HVaNy1wmHqVrekgkd4LEZm9UzqOkOBniTOyw@mail.gmail.com>
 <20240124001808.bfff657f089afe10e5b0824c@linux-foundation.org>
In-Reply-To: <20240124001808.bfff657f089afe10e5b0824c@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jan 2024 07:34:54 -0800
Message-ID: <CAADnVQJe-BxbKYsMUXXrsh4wEUPacDT6RtF_qrO1ewns_8T1_w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm tree
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:18=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 23 Jan 2024 17:18:55 -0800 Alexei Starovoitov <alexei.starovoitov=
@gmail.com> wrote:
>
> > > Today's linux-next merge of the bpf-next tree got a conflict in:
> > >
> > >   tools/testing/selftests/bpf/README.rst
> > >
> > > between commit:
> > >
> > >   0d57063bef1b ("selftests/bpf: update LLVM Phabricator links")
> > >
> > > from the mm-nonmm-unstable branch of the mm tree and commit:
> > >
> > >   f067074bafd5 ("selftests/bpf: Update LLVM Phabricator links")
> > >
> > > from the bpf-next tree.
> >
> > Andrew,
> > please drop the bpf related commit from your tree.
>
> um, please don't cherry-pick a single patch from a multi-patch series
> which I have already applied.

hmm. There was a clear feedback on the v1 of the series not to mix bpf
and non-bpf patches and a standalone patch was sent as v2.

Thanks.

