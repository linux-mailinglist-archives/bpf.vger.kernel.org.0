Return-Path: <bpf+bounces-13138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF827D5679
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A59F1C20C51
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 15:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3293717E;
	Tue, 24 Oct 2023 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVJXaQXA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013D37164
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:31:56 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D6F123
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 08:31:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso3285504f8f.1
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698161513; x=1698766313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIwskzaILIGb3OgOBOOgpxT8l2Eva7GV0J+HgUWpKjY=;
        b=WVJXaQXAt9jnVqijpjHApr+cp/vSVW/M4GwurSqthkcg/EcZGu3NpYZgEbR+S66dth
         ZZR2fw53EdXqS0r/rZkRusb7NRqOadis5qXouLfQ39O34yNBb7tfly4XfqT/sZb7IIEF
         alqH23mk5elzoic4u6Tq6UfmLpqJA4EksofsnLNDBZ9QkXWps2FWw5mIR1JEdvF4ClZs
         JoqFV6SPYhD8ey0gdpf+k8lv+z1Jh2936mXWb0NzQDyghhy1OzWE4/LAmXj77KJft96S
         9rJ4OW/2mAGKwuhItciuosvwZO8rsSS/665B/ck63TryNg8actOTzIR8BAQ1qtnsyVUz
         +DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698161513; x=1698766313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIwskzaILIGb3OgOBOOgpxT8l2Eva7GV0J+HgUWpKjY=;
        b=R7avaKMMisuXYzSDwkk4QIidibVrVxdtm8IWiTZID+9BP6bHBiQGHOGmOpCw2Ij67r
         AFrucDNizIitD3EEAz818vF9FrJmIeRI4WnuS9rnaVrM+VjgbbffJjA/xTVFrxKrHTDR
         P+FSQNpFTZ52pohl6WDwrjakSJrVhgwgjHVo+ElB0MwN3xLIbtcQf+6hzFspzsETI20q
         TAmciAW1HogGfFhtd7sOyMkzQ5nEqYJIOStPg74kEdRZpIuNxWORQv+o5B1aJ+Y4ZnXb
         jCC6BziSY1KBaIWRC3VoCZszbrcKX3T3drrqVQm1bxxdLktcBNamlLV/5lwTkqsJyooZ
         XLrg==
X-Gm-Message-State: AOJu0YylR4LusFPWfsCGwVyg12x2Dok/Tg2NC8RVxPSLaBPEaT219k+E
	L/mPYjxod8xbseYuGNEuHpD9RQ9u7lIwprvbtGbSwsOI
X-Google-Smtp-Source: AGHT+IG80drvOviCPG8eeUNi4XYuJ4JD9qmRtUy7D2jdZvoiovE4Uz8AcyfWFpLYB4Ubqalq16du7oBcXFeAdKNI4eA=
X-Received: by 2002:adf:fdc8:0:b0:32d:a3ee:6f73 with SMTP id
 i8-20020adffdc8000000b0032da3ee6f73mr8574770wrs.42.1698161512559; Tue, 24 Oct
 2023 08:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022205743.72352-1-andrii@kernel.org> <20231022205743.72352-4-andrii@kernel.org>
 <ZTe28jP0qFNtf89A@u94a>
In-Reply-To: <ZTe28jP0qFNtf89A@u94a>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Oct 2023 08:31:41 -0700
Message-ID: <CAADnVQ+_PrGAsQfQag0ktFHZ2pOVA2-63n-pA5=uRSu5GmWM0g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: enhance subregister bounds deduction logic
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 5:22=E2=80=AFAM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Sun, Oct 22, 2023 at 01:57:39PM -0700, Andrii Nakryiko wrote:
> > Add handling of a bunch of possible cases which allows deducing extra
> > information about subregister bounds, both u32 and s32, from full regis=
ter
> > u64/s64 bounds.
> >
> > Also add smin32/smax32 bounds derivation from corresponding umin32/umax=
32
> > bounds, similar to what we did with smin/smax from umin/umax derivation=
 in
> > previous patch.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Forgot to add
>
> Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
>
> And that the acked-by for this and previous patches applies to future
> version of the patchset as well.
>
> Q: I going through the patches rather slowly, one by one, and sending
> acked-by as I go, is that considered too verbose? Is it be better to spen=
d
> the time to go through the entire patchset first and just send an acked-b=
y
> to the cover letter?

Take your time. Careful review of every individual patch is certainly prefe=
rred.
This is a tricky change. I'm still stuck on patch 2 :)

