Return-Path: <bpf+bounces-50633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54329A2A5B9
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADF03A5BD9
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9260D226878;
	Thu,  6 Feb 2025 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn3XOFt8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFA122540F;
	Thu,  6 Feb 2025 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738837362; cv=none; b=cr0Bxr5yqFM35lM7Af6K/kxl0psW4iEf5NCQ0EnroZqPMuBtkXqPzbvrg7p8V+/XlE90sTQ5HsKEAmdX/Qx7/7b9vEqXrSJe98Ykidrza6cJb5vFlpTTDf6wK2RYfYkjfdh3Fk8b/EiAKF62SMvBRvH+LkIMkJDkfzN7MKe6Tek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738837362; c=relaxed/simple;
	bh=ITRUK2mleEF/74KTc1V9MJDwrYb1+CFbhx+ekjh6RF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPpbH1cgplBNfZmlCR5vaTVHMcH5dLTUZy6KueszaKgF6zYuPIRqkDlxfUUd2soPqOYrDahmzbmgIdrR+E3yc1E6+IodZDI80yMhnYCoeSGm5UbhplVDJur5BC3sJrleApH9r7jiFsADDBidyIuRyti7r1S2j0rNHp1/eC4Ukpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn3XOFt8; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d0558c61f4so3966895ab.0;
        Thu, 06 Feb 2025 02:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738837359; x=1739442159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITRUK2mleEF/74KTc1V9MJDwrYb1+CFbhx+ekjh6RF4=;
        b=Mn3XOFt8YO2RyEAbnu5a3n7tkACutT9bXrRcarY3bbxlrGnjxLzPas81mbNgO3gRV5
         nbFiOm8YQH+OVTFfywMV02c5UU8/6KS/JBLLGdehjs6R3wd6G7WsfnX0G2aAjBFZjpU5
         0VBUydFMgUcCz2vQJtmA/esrOeeBW3ax9cm3Hky2djMG0HfgdzgTFligEbX6kH1+NzbA
         LfsE8UE5JllJ7++BMQ5saC/B1i6jbbZp3gh4LE+YhMEukU8F4t/9sKAQO/9eiJ8d0TQA
         KrS9mFjF4HHsrAgjM7OkswHIaDS0VWjjmGiBERJdSb/pFnSa1da/6r/9fibJe6TUrGe5
         sUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738837359; x=1739442159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITRUK2mleEF/74KTc1V9MJDwrYb1+CFbhx+ekjh6RF4=;
        b=qFmHOIQjSxJT70cutPwiEUl5hDhscdStyv3hO8uyFB6i1ReTYTYGHJztYffkJGujZ3
         +89PbfIcSeH9F20DKjYgchZit7m2ofoxRoT4kt/9/sDElOW1NADiYWiFn6a2Q9wiykYp
         ngGQrwS4EQQ9j4eVS0GlU0iyHXT/mBF0XG7ZsigCML0r79UHGcC3xYp7MqrM/5J9x0a2
         sGpPOD5Q/5Lf0EHMQoA9yDucOIzKt7JSbHUQVJlo0Rg3gdzC4U9TRK0RB5EHWZfUFErp
         pCY55zGwdtzO+IwM3SfizPxhwox/AV4PBvWJQylQZWiteXWyFCd0j8MNo/ULuc2qNy3P
         gCKw==
X-Forwarded-Encrypted: i=1; AJvYcCW07gHTdd+QNzUzsdVgINdS/KvS0vuimPH2maOIGna9xT1pmcFhWNZsqme/oyHx30PctmZfJIf6@vger.kernel.org, AJvYcCXSmHNDRo3ppy1V6Q7VHETU4NFLiTucC4eh2wBl/IBAoNLOoaaKcqyqcq+/h8OHJ2GxWss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKEmFzyEH3TMS+Od0DFvh2cCD8heEd6cXhUuCBxQMPzRZs9PzO
	t1W67eKGeFQrBfLAuzDKfaxKtWl/zpDU7rtmZk1Y7QEPHgr9aYyQREdtpFUlcnPELFpcbL3tR9p
	BytFMJ5YPbLQk4X39CCnlLroSxEU=
X-Gm-Gg: ASbGncsAY0PT9uKLO+wplelxOaW6nb2CPqXKmBZKjzKAx/hlSnL/0CyyK+PYvArfXYi
	ARh6dyMtPcuxHRcM/8PS0ppS7JxEShCh8Xp036z3IBgOszIm1nHiAJFpsVL3VBj583A4MLUWi
X-Google-Smtp-Source: AGHT+IEtPTc9uft8nwa3L0tYQXjWEa0eIxuJSderjWOqvglwujSfCkIPE1NYtRO9VTJALAgsAbH02UD4m46o1/aevAk=
X-Received: by 2002:a05:6e02:12ce:b0:3cf:c07d:e9a with SMTP id
 e9e14a558f8ab-3d05a58d185mr19078455ab.4.1738837359688; Thu, 06 Feb 2025
 02:22:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-6-kerneljasonxing@gmail.com> <67a384ea2d547_14e0832942c@willemb.c.googlers.com.notmuch>
 <CAL+tcoDvCrfE+Xs3ywTA35pvR_NyFyXLihyAuFFZBA4aHmiZBg@mail.gmail.com>
In-Reply-To: <CAL+tcoDvCrfE+Xs3ywTA35pvR_NyFyXLihyAuFFZBA4aHmiZBg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 18:22:03 +0800
X-Gm-Features: AWEUYZnwB6USsLHlfud560t2tqXbwmTMNfmbEHPVYZlfcOIutFZZOfwE_OwrI1k
Message-ID: <CAL+tcoAPpLwRt1_81yM66MpeiJvD1oZjCOzy4auKR585M24yPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 4:43=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Wed, Feb 5, 2025 at 11:34=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > No functional changes here, only add skb_enable_app_tstamp() to test
> > > if the orig_skb matches the usage of application SO_TIMESTAMPING
> > > or its bpf extension. And it's good to support two modes in
> > > parallel later in this series.
> > >
> > > Also, this patch deliberately distinguish the software and
> > > hardware SCM_TSTAMP_SND timestamp by passing 'sw' parameter in order
> > > to avoid such a case where hardware may go wrong and pass a NULL
> > > hwstamps, which is even though unlikely to happen. If it really
> > > happens, bpf prog will finally consider it as a software timestamp.
> > > It will be hardly recognized. Let's make the timestamping part
> > > more robust.
> >
> > Disagree. Don't add a crutch that has not shown to be necessary for
> > all this time.
> >
> > Just infer hw from hwtstamps !=3D NULL.
>
> I can surely modify this part as you said, but may I ask why? I cannot
> find a good reason to absolutely trust the hardware behaviour. If that
> corner case happens, it would be very hard to trace the root cause...

No offense, just curious. I can keep the same approach as
SO_TIMESTAMPING since you disagree. I have no strong preference
because I found It's simpler after rewriting this part.

I will simplify this patch in v9 :)

Thanks,
Jason

