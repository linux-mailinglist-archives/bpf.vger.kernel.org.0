Return-Path: <bpf+bounces-36698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3394C3E7
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 19:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E41C2222E
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D21422B8;
	Thu,  8 Aug 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON+3KrsS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397C012FF71;
	Thu,  8 Aug 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723139428; cv=none; b=oJlQ1ebe6YZskk3KDr6XVseNeR+Dtad2S1HV96lMtuGL+mnIl4YuPsfaE62OFDmqJZEEFt9trNij1Xbg+Yq+3BDnN8i9/dqzHJ6SLoCctqDHIJuQWYWpI9oPHL5/JEbBFNnCTGVHDGgLEbfdIeoxMASsiQG58UGAnmXD/GfVYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723139428; c=relaxed/simple;
	bh=y5Eps1sP9g5XINUkuc8EppCP1VRYdFpU3srS4PkyN4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUwTjrUo/Jg+fWgx9vpia5BW6Z5z7P+u2AsqHmnxhvxciTqUq1ag+Xjcc9kMYYMUseXnaIr4PO1HHIviUJN2gZgJ8PCBpm6BtHvBjMPnadro/8zvWr99IkbKUFj4l5IAOvN9OWj15FEy5k/JsYWtr85q9EV00BUHFg0j4AkIiUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON+3KrsS; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a94aa5080so154422666b.3;
        Thu, 08 Aug 2024 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723139425; x=1723744225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4bdDhWQ7X8qQM++M7HovEdjs5/KPCkAJnqC/2R+xhg=;
        b=ON+3KrsSCd9RsVBEDtScpj2dxC6D7oyJnRODkh3o0DdlhlCYFNQhQmTbz/HlvH5LDy
         s2c2G2u6VIzfBSqL0eXxKhmlDTw+T81A7keAMypX04G5WHEyMOaQyBzXms4hasp8YHk6
         TGTCgIIBClMVtacm2ooqhzcJGRekoXh9Nv76Xw4OKmY3Dkmgi3u8E05mLjVb5T0ta+tn
         hy6wKA7mB6lCUSKBiAbE5I6eAyvhprtdnyEPBwAkROqnQ3t+JLEPyWnGwIv+Ote8WHxa
         Ql7unGzCiZ+Go4n7nbmqHefKR209e4o4RLEfvLl7AvMNajdKIN+zdTxmwDBSQcTYXlFX
         07tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723139425; x=1723744225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4bdDhWQ7X8qQM++M7HovEdjs5/KPCkAJnqC/2R+xhg=;
        b=YzN5Df7hRDHwzQr7ZS1SP4aMWKVB1ULyxDv6q7Q5L9yd1eiNCcBtkeFxpqXvRThpg1
         dcoSh5R1hrCPwVsXQjByN+bM8SIlhPWvgW0SyWKsMJn3h1k4E4Q91X49RefC4F69xuiN
         3byDzONouPHsM7lRz/fzEMS3YVUao0/YlLWX1T+u0QXYcD2qgxqHUUasJxLmWtE5S7wR
         /caBagmkhaWS9KW8ytgwPP/8G24Wi7rSNYW4Rit0q6aEAPgYItlV8XDVXo6+3E9Ym8rN
         /l4amxnetYEwcr2tamhNUWKt8ZarbeF+/B+CceQSyT90aFJjFHppibzDyO1t0hCWyTFA
         fNig==
X-Forwarded-Encrypted: i=1; AJvYcCX3KXh5C9iY9+srHy3ot6lSwRU/cYhlOi3CfEvN7mT76S6gVs+WcfVc9e/aGp9iQCmAt1WmeTaHXNCvvok3k8tm2sFPd7a6TFrkZRdAM9iiuAZv2w76gGLOajhNU6ZseJ8opM++Obk6kYFIB35VsGKp0Au2zdRirjlv20078gi6pJ789Hnl
X-Gm-Message-State: AOJu0YxUrGk+ccmK4Pujj3GA28usUKEXp67yWIi+O8Ecl58Y/zVBA6ZS
	K6jnT6kUtozWWMy0z7GqwTAbYS9Ck9nEVoN8pKkySDPcig4qEMFAQI8uzixDoLgz4Rx08deu6sf
	cnv/3Q6OFdmiAw0SpeZYEAVoBz60=
X-Google-Smtp-Source: AGHT+IF7SXPWsuvpgoKrIXu0BcFSy0oLb+NpblV2FfSs12++pT5suHBnBpPwRMCYhNJbrOvyRyn8Xr6bxDCLiZFRZVE=
X-Received: by 2002:a17:907:c7db:b0:a77:d7f1:42eb with SMTP id
 a640c23a62f3a-a8090c825dcmr191339966b.23.1723139425115; Thu, 08 Aug 2024
 10:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808002118.918105-1-andrii@kernel.org> <20240808002118.918105-5-andrii@kernel.org>
 <20240808144013.GG8020@redhat.com>
In-Reply-To: <20240808144013.GG8020@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 10:50:08 -0700
Message-ID: <CAEf4BzbDZ46kc8bcYcg4pNfsnXBy-P5PktSifpHXqd4XFnO-HQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] uprobes: travers uprobe's consumer list locklessly
 under SRCU protection
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:40=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 08/07, Andrii Nakryiko wrote:
> >
> > @@ -1127,18 +1105,30 @@ void uprobe_unregister(struct uprobe *uprobe, s=
truct uprobe_consumer *uc)
> >       int err;
> >
> >       down_write(&uprobe->register_rwsem);
> > -     if (WARN_ON(!consumer_del(uprobe, uc))) {
> > -             err =3D -ENOENT;
> > -     } else {
> > -             err =3D register_for_each_vma(uprobe, NULL);
> > -             /* TODO : cant unregister? schedule a worker thread */
> > -             if (unlikely(err))
> > -                     uprobe_warn(current, "unregister, leaking uprobe"=
);
> > -     }
> > +
> > +     list_del_rcu(&uc->cons_node);
> > +     err =3D register_for_each_vma(uprobe, NULL);
> > +
> >       up_write(&uprobe->register_rwsem);
> >
> > -     if (!err)
> > -             put_uprobe(uprobe);
> > +     /* TODO : cant unregister? schedule a worker thread */
> > +     if (unlikely(err)) {
> > +             uprobe_warn(current, "unregister, leaking uprobe");
> > +             return;
>
> Looks wrong... We can (should) skip put_uprobe(), but we can't avoid
> synchronize_srcu().
>
> The caller can free the consumer right after return. You even added
> a fat comment below.
>

Yep, totally my bad, you are right. I'll add a goto synchronize (and
yep, we'll later remove it, but we should be thorough here).

> Yes, the problem will go away after you split it into nosync/sync, but
> still.
>
> Oleg.
>

