Return-Path: <bpf+bounces-61418-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F802AE6E9F
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 20:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F08B1BC3133
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD83B2E6D3E;
	Tue, 24 Jun 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="frN3BPTD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C723C233134
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789892; cv=none; b=eDPkLy5lHx69pKAkEnKHtqB3kQtW8uV7MwwnYnaAridGRTKhVBMpMDVfwHVEgSNTEwozR34O0GvrfCDKzT8qkLZewCA8rtbYJ0o8qGHSWwVm4/E0QWN+nYoyOHNYxj0klXuy1gZFP5PnjijYz3i0nhi8tx6uiuo5an2u8cTJFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789892; c=relaxed/simple;
	bh=oxggGxlEAxQEG8dw/1WSvlADiepky9mdW9MNmieccOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3SGIGaV93FTztMig4Arbeqk9UU9NM0zZNKnHcLsA1jbRNsd4gzF0+J7m31MLCPbBnAAYg2T9ZORzxQaxdzGNZz1iwtSVCo1Y+io8QSo1E/SY2RDSLFGeFwgZ9hddURIGUYrDZmoE0hmWlCVBDAU9FoZyk2Ultm4NK7NS2Cs2J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=frN3BPTD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so508634f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750789889; x=1751394689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wcG9j8VdN/npPwgyr0htyxSJI9SVIjp3ma+CA4lJZY=;
        b=frN3BPTDIdQzrJIYBwis8zfSQMoyLD4EMPu/S6n7IBWNYVWI7rppG0w6NnjxKAagin
         pG+IFvzB3MiwhZgXdjQ2W3e+oMYDMfoUCs67iH47CDwS2sZcNLmNiV1qX5vD3sUeXdpr
         IJJVqmxR9tb22c8BoJj7UudPDSjJtzMKTUJZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750789889; x=1751394689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wcG9j8VdN/npPwgyr0htyxSJI9SVIjp3ma+CA4lJZY=;
        b=JNTN40VZqqrTOIt+Z8eGff8OfmzeeJ3PVIu0etx7JP15+OjaEK3V7ZPBg125PjUvcx
         rn7jLVaxIX+o2gSEWpFyZ6hb7UbD6TDLM+5oX2ECyf5PYdsObkct9Yn2DCAPD66eALHf
         el+EFOjp4jUbCzjnxm6Wz/bdPhCIzkIBdfQofZJuc+UIV4NVTylx2X8f27lQqKUAS25+
         hridlxO2SfK7UQNKIfrsPY7scApiBakIu3vpBOjtFiI8CugU96ZFxV5UxwYW8EflIKDw
         Eo8xs/9VzPuwMqTUk/ubxn0yzhbYr6wYxT2E7KGkgJhjUh6QAztVV8Ca0CxV2bgczz62
         PtiA==
X-Forwarded-Encrypted: i=1; AJvYcCWUd0UM1jftTojOOtCmzFLz8ZLMyao62QuaUMUDtVI7iBdE8OMKX8KSuGFi+rFpfqfOk1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXGTWg3sAWwRv4AOTpXALT/GEgwdtZVB0CmplD+vUsFCn6NNL
	6vQrHU8O7UxgNvw3cnNXBvOhC/7GNK067EX1KTn+OUIbVhKXqQHIeS+6959pR/BQSIGPLoT9vJe
	Wu9DE+3kC3o3dLAmgtyamxiT/9B2dNUxtxcWWFtsf
X-Gm-Gg: ASbGnct1t1kupD1f3RAGTRXh6jiV4snD81MjxMZ4xCk4XZ5oO0zP7W8dZafWyWSBgMc
	7FqEs8VCwEepriPim6o/gJNEvkK5TSGXs2qRk5nQKhL9gxvhGDNdmc1mOefHt4yJLNA+HlrB2aO
	2Gy7Bvb/m5GmQkB8CxdjM6LgNeHKNzNZ+CGAiEVxoa+qRa
X-Google-Smtp-Source: AGHT+IHlsJf8+bi5OMmeyYd45t8XxJc7w9Vdsy57udvF0huW0fRWNhgY20XQo1TYvMIZI/PAdLdm921J3sfinlX3PFU=
X-Received: by 2002:a05:6000:2f83:b0:3a5:2d42:aa25 with SMTP id
 ffacd0b85a97d-3a6ec4d3cd3mr776826f8f.50.1750789889090; Tue, 24 Jun 2025
 11:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aFl7jpCNzscumuN2@debian.debian> <633986ae-75c4-44fa-96f8-2dde00e17530@kernel.org>
 <CACKFLik8Ve4=eUV=TJMkwkScLN0H80TtiqPUwtuDqNEji+StSQ@mail.gmail.com>
In-Reply-To: <CACKFLik8Ve4=eUV=TJMkwkScLN0H80TtiqPUwtuDqNEji+StSQ@mail.gmail.com>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Tue, 24 Jun 2025 14:31:18 -0400
X-Gm-Features: Ac12FXzy1JNsBli5zeDTmdvBa1itDipHFkLbZK-3c1TY40dRr2V_CjtW_YzgdDY
Message-ID: <CACDg6nWEAKWU3s1x+NRU28BcXHK0=yFkAAU4MMkSTgEA9g592w@mail.gmail.com>
Subject: Re: [PATCH net] bnxt: properly flush XDP redirect lists
To: Michael Chan <michael.chan@broadcom.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 2:00=E2=80=AFPM Michael Chan <michael.chan@broadcom=
.com> wrote:
>
> On Mon, Jun 23, 2025 at 10:59=E2=80=AFPM Jesper Dangaard Brouer <hawk@ker=
nel.org> wrote:
> >
> > On 23/06/2025 18.06, Yan Zhai wrote:
> > > We encountered following crash when testing a XDP_REDIRECT feature
> > > in production:
> > >
> > [...]
> > >
> > (To Andy + Michael:)
> > The initial bug was introduced in [1] commit a7559bc8c17c ("bnxt:
> > support transmit and free of aggregation buffers") in bnxt_rx_xdp()
> > where case XDP_TX zeros the *event, that also carries the XDP-redirect
> > indication.
> > I'm wondering if the driver should not reset the *event value?
> > (all other drive code paths doesn't)
>
> Resetting *event was only correct before XDP_REDIRECT support was added.
>
> >
> >
> > > We can stably reproduce this crash by returning XDP_TX
> > > and XDP_REDIRECT randomly for incoming packets in a naive XDP program=
.
> > > Properly propagate the XDP_REDIRECT events back fixes the crash.
>
> Thanks for the patch.  The fix is similar to edc0140cc3b7 ("bnxt_en:
> Flush XDP for bnxt_poll_nitroa0()'s NAPI")
>
> Somehow the fix was only applied to one chip's poll function and not
> the other chips' poll functions.

Odd that we missed this back then.  Thanks for the fix for all other device=
s.

> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Andy Gospodarek <gospo@broadcom.com>

