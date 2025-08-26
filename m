Return-Path: <bpf+bounces-66492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B16B35138
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 03:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B05C3A6943
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29902045B5;
	Tue, 26 Aug 2025 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5sskZU9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43581411DE;
	Tue, 26 Aug 2025 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172990; cv=none; b=cAy9YdqUVBhtqtdz0tErQM5ZU6pMW0cjnjH6+YYLc6xrUJ1E4un9myPXY+mmuNVYoMPq29fw+7i+vjrj6PH9FDo+p+hIX/Vqplh8/5sYNG7v1OsMRfMmTIR7nOCV+rpy/2eViUiVVEFEYij5gI1NbKBmTajBjnU5KKn91Kbi/zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172990; c=relaxed/simple;
	bh=60DrGJbOHI5Jr6uXidnxi18fJWHYrWJJvL2z+wGxVE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHbACCs1+aJECo74j2t87qHYSGhmy5CAFuKGZX/nub5VseUa3Sqy6Ahn8TuICsJjBaMQ1Dcc7UIW2epjXrmLFRY6v0lI+ejhD63PuhULfskzKMJp8OjrIy+xnKYdoCmHYHgVCt4LrLZ21o9TmUetHjmAq2CP13kwcuXcx3uPwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5sskZU9; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e974105ab8so11776165ab.1;
        Mon, 25 Aug 2025 18:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756172988; x=1756777788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60DrGJbOHI5Jr6uXidnxi18fJWHYrWJJvL2z+wGxVE0=;
        b=X5sskZU97d9IMiGd5KNqTt4VJBw0yimj1GfK7w22y1d00MRQ3W0B/FQ+j/Bi4MgZHF
         WR57ZJ8sNF14YD2tc+NqtSvBHrE4lqgRL4juFQOc72OpEzeoOa+Ytg5/N07+jlW0G/Ak
         z0B/T9f+Q8xRCIRsHgQi3H0jKR9G2S3mQttQxgwmsEZGVW4jgUM3rDqJ8yqceH1Ii48g
         7XZ3UEKvAFXZZ5PvVFOvW/2ATWBkrGN9GGOQYuLzF5eUHqMNG0NHJkT5sVbeX55GBqub
         VFO7sNwt9qVy9nEpD1ma0vSKSAmNCb8LP5DVd2CisnWdUA1+OiYKuyjL5lwhh72CKFqf
         N3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756172988; x=1756777788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60DrGJbOHI5Jr6uXidnxi18fJWHYrWJJvL2z+wGxVE0=;
        b=ILOufrirqkqR9iUa7LfWXN+ru3B9MIqJU/LsTEdZ6qH7I+OaNiAv+zMbg9aM9zGAAx
         ghBLCW30Qa8QsFrGObWi9sftOZsnDu4fGvzGLNycE/JyQ32BWjW4SZSt8PPOqfc+jcax
         wdXoUzK9zcuqVq3XDD1g/CfnEYo25JGcdTKezUvgS1G1mAJ9xfV8OQtIgOW6LiD0xCdP
         uSdJzgCcjxy9av/jO3BsrZgQhqakg45p8iljNJRkGeP/3I36A/eOUzkRNpblre/HSBW3
         iEppc751kHwLDsV8fPbEPDstFffSKPKsCYXV8weL1tMCoIlIdQxYa80YKF1BrJGgHg4p
         RWuA==
X-Forwarded-Encrypted: i=1; AJvYcCW0fPjetkx5lD39KksHaEmU5cxMy2UtOSkeD0HUatWrZP/aXN0bRB4tsG9opNQoYeJnEttfrUfw@vger.kernel.org, AJvYcCXeZPrIy6wtfwvgy9RAvyYtVw0T6dy/dOEbsTVF7/6sDIJWoPPcrHTZ43yC6hwlqB8msE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykh86EHcAk1Fhmf7V1iBEkcX7OBAC1lzgArTmSajqxPC9dhVF9
	arJFmvQD4t+wwW77nPuTBKYs8hN3BMcSB8ZxoQ7Nwv2AmgkE40Lbu4mKs/zxMHVySBCrX54M4kF
	L5cM4mf7SY0GzgtID4p8VWZhg0z1De8c=
X-Gm-Gg: ASbGncuOlN7V/r9Ama06gToJEnl4d2eUgRhcv+qDLrJ7fbMUK7Yc687tuUiMWF+iZQu
	nTwpqxSlN31jvMTNUrV3MF2SVtn2w5jR027MAKddMC6oaBSU7SZToj4ypjs7MnlaJmBpSNxveeO
	JMaFszfuCnQYdTtrBI1drYppiVQTo3uOA85RxNTKLr7fX9BYYoKH3qIRbCOtiSHJwQSbTI6wKIz
	wi3xFABRZ6EUMaN
X-Google-Smtp-Source: AGHT+IG1BRpj8TLZDLFlkJC/FniHBzl+imsyU49RHJVLmxOacukTa4TB6th4wqVm+lNLzUbZqXRIrx6hGTZ4U3TF3+Y=
X-Received: by 2002:a05:6e02:480a:b0:3e9:4547:5e03 with SMTP id
 e9e14a558f8ab-3e945479d7dmr165187995ab.10.1756172987986; Mon, 25 Aug 2025
 18:49:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
 <20250825104437.5349512c@kernel.org> <CAL+tcoCxzyBxhCes-4OfBAePpQK3jvSRSBufo0eu6afb4hdSaA@mail.gmail.com>
 <20250825172928.234fd75c@kernel.org> <CAL+tcoCa3nfO+PJE-uccnOfQaZnUa+78AmJXwjaLod4WvPPfog@mail.gmail.com>
 <20250825181532.1b6ae14f@kernel.org>
In-Reply-To: <20250825181532.1b6ae14f@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Aug 2025 09:49:11 +0800
X-Gm-Features: Ac12FXxcw-uBeivFSh7mXfNJhBEVgGd8sQbIq7FbQcH-g-dKOLiDMYFgkuS9Es8
Message-ID: <CAL+tcoDNbi1yFaH=VpZhXKM4HtMR4S+==UweXzWzCbsXMOpnSQ@mail.gmail.com>
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

On Tue, Aug 26, 2025 at 9:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 26 Aug 2025 08:51:24 +0800 Jason Xing wrote:
> > > > Sorry for missing the question. I'm not very familiar with how to r=
un the
> > > > test based on AF_PACKET. Could you point it out for me? Thanks.
> > > >
> > > > I remember the very initial version of AF_XDP was pure AF_PACKET. S=
o
> > > > may I ask why we expect to see the comparison between them?
> > >
> > > Pretty sure I told you this at least twice but the point of AF_XDP
> > > is the ZC mode. Without a comparison to AF_PACKET which has similar
> > > functionality optimizing AF_XDP copy mode seems unjustified.
> >
> > Oh, I see. Let me confirm again that you expect to see a demo like the
> > copy mode of AF_PACKET v4 [1] and see the differences in performance,
> > right?
> >
> > If AF_PACKET eventually outperforms AF_XDP, do we need to reinvent the
> > copy mode based on AF_PACKET?
> >
> > And if a quick/simple implementation is based on AF_PACKET, it
> > shouldn't be that easy to use the same benchmark to see which one is
> > better. That means inventing a new unified benchmark tool is
> > necessary?
>
> To be honest I suspect you can get an LLM to convert your AF_XDP test
> to use AF_PACKET..

Okay, allow me to spend more time on af_packet before getting my hands
dirty... Converting xdpsock should not be that easy, I feel... But I
will give it a try first.

Thanks,
Jason

