Return-Path: <bpf+bounces-72960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1340C1E041
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 02:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D43CC4E4352
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 01:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91E266B52;
	Thu, 30 Oct 2025 01:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkgM9F/C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66914265CD0
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761787381; cv=none; b=B/5laXGOWKLZLDHu7wI+sq8aB7rLega83AxzdDZQyuvWshvnoB6VDdunA8LY6q/5995oplNxV3S/gg64d6zwv0ytaV9QChQQX4SB6vWC8qAnPVZhdnO8nTY+ur1AjJS6vs6dbFOl0T7Y+z8AX8w3BquY75jaZpVY+IW5sQDYoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761787381; c=relaxed/simple;
	bh=eQsskdPFqtAG8r+9CBnEtMXYSJGlJyL8d1/Dt3bnXQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROkTjYCYoPuy1WemVm+TajnHtfgylO/a/vsw+bA+L8knhP9Wzki1NJ70OskixxUPOGnfiYDbe229AcYoNnjqn4nIZH5Lfj1ZuYgZwpKjzlrNQTIq0LEOohisBXDfExsZnaKiIx4t+oJP56TWAt2k3+3QxwgNfU+H/4eYozG5tf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkgM9F/C; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47721293fd3so3076505e9.1
        for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 18:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761787378; x=1762392178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rnwh+mA89EL9/aOcuwY36uqtEAcvT1ErA7wnpGBYf4s=;
        b=lkgM9F/CZCIt2Lf3eJMJUN8htsG7NMV23arKuO7cbWgE9Lb7XkveABFfeWrnY97MXg
         amnoFXHmxksVCNoWQ3j2rbFsQ+xBXATbURZUwZS9ZH1Wdm378bFH494bCz6P80FnY7CM
         oMzqod1heH/WVIPIqxGA6RKw8PlxpLfuqTCllsgIkxgMT72V4tkK3JwalAN1teQwfkl6
         KGClOzbQb6oV7WBy11nJ9bU6S+fNFksblOvmBO3R9MH1kTOX9rPLR/OpWgjlcxpQ6PNF
         rUp5jfSWrnksq44fynTnnSK6louylWXnAoys2OlkXrKklsY9z9+Y7HyJc/P7N79+wSpX
         A1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761787378; x=1762392178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rnwh+mA89EL9/aOcuwY36uqtEAcvT1ErA7wnpGBYf4s=;
        b=Bsx8yjABpRvebrfB/0XvA5aTLzpj3b8cN9vPJbwLQpmL7MlW+07phQBI9P/kuZNeG1
         kSowRm+UCW3w2ccM0J9cnbZx0w75FEBdzw8cVK98mu0CVXviPl9xTThGvMGvSjMZdAQq
         ezej/4uvoNs3Wrg6I/QkEds1J8xFAkJYVNYDvNmiBbdpH/xrE18cLIgAu1VNxFhBxxnI
         Um8nV5HaXjSzHdoCdd5REGwxbrLye4+FCL4KY3Usz6P7nw47bXHby5XJxaeXbKkLcH+C
         YJjXJhZ709UsrpQ2Fcjs3grss01oG96ulvL58LVg1ZOKAbu63c2fDWpJoBQA513bJtOc
         hFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZsO8feVZ9M61Wk/pF8E8kWiFGN3Ugbsw6SpuxFsKnAi7MF4HtmtSDj0fRFIpE/K5ezIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoMoOqHKcUn00cHbWONH0ibIye2YrtBmARma5yFPbvjUGdeha
	ZD4TQnlBu/y/mGfLVejNInvLfNMmLereMa4o+afM3fhbeneb4bVIg65vzyqI3nin9kj5zlmWy5c
	G4JoniLAJdJtk9EmBprA6LTyblp3pzJI=
X-Gm-Gg: ASbGncup/CpEsXjM8X2jHu3axHHBETDkXHF2xG2fdBhkbs5SSwGQh5yjDZABwDLlJw3
	BBYvpnQpIi2UMmaGtdj1+yT+NS5JH/RLwJ9iw6rjcyzflPX+6m8kV2+d/UayO/L4EcsUYxGUt6R
	ayKoB3pEPaBJR17+hiu1vsAtX2b3vBTRfGN+Yzpb4Z6AiF9QM9KmgVMx/ahBbCRPdeOhjtgIr8Z
	RNELo4cIuk2ilwhxBvYg13XRt1vSYYMqsZXw+YDFExLb3Cvi6aGoofatQTjU+G1XgpC0U5q7vE4
	6/45hG78zrsFzGgY83uNO6wgYoAy
X-Google-Smtp-Source: AGHT+IGYH9nUghSWaMxcWEi3sXwCpko6su1tg523Ut+neA3VF5K/bqKeT6rv8gkBgSIvCPL5u+JpZLKXlbgRF1Z0UfY=
X-Received: by 2002:a05:600c:5252:b0:475:d7fd:5c59 with SMTP id
 5b1f17b1804b1-477262baf00mr12349755e9.16.1761787377570; Wed, 29 Oct 2025
 18:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023161448.4263-1-puranjay@kernel.org> <CAP01T74MS9fWmboh=vYeP=sQJT68E-naOUVfAV66xYjy6BH7NA@mail.gmail.com>
In-Reply-To: <CAP01T74MS9fWmboh=vYeP=sQJT68E-naOUVfAV66xYjy6BH7NA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Oct 2025 18:22:44 -0700
X-Gm-Features: AWmQ_blYojUAppp7wQ1XkuhLR8WWCAC_89wCPu1ygtL1z1dju2P6iuSWrqHTs4E
Message-ID: <CAADnVQLW_8FfmJXx7oJ-wD+K=hiGOeJjMAVQ4cCu344W3TowwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: stream: start using kmalloc_nolock()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 12:57=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> > -       if (!bpf_stream_page_local_lock(&flags))
> > +       alloc_size =3D round_up(offsetof(struct bpf_stream_elem, str[le=
n]), 8);
>
> nit: Is this round_up necessary anymore? I would just drop it.

Fixed and applied.

Puranjay,
see how I adjusted subj.

