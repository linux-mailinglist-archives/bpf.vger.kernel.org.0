Return-Path: <bpf+bounces-78094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2B7CFE225
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 15:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37417307CE66
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C97F328B61;
	Wed,  7 Jan 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6NGY53S"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8133B3168E3
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793839; cv=none; b=VpYzfXjnAYXpGevyiGq/QXBKi2IJFTsjAIMfN8TBbaw+ZiG6zqh6FrDiW7hORx5AjG2vtIXmjAZObbcPKm5sSL8/Aam5Z2ZuEpMXoGQsgZg+9A34MaQBlrSUxfn7zPY5YLYpF6Ua/0J1U89b2nw/1h0E+3wHFRf/Adwi5gL0V8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793839; c=relaxed/simple;
	bh=fK02nfm3x/WpspVjzqsxTFJxRC/x1RuacbvrfeaPNFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrBnbqDVHGg6kFtECX/ZwVie7IDAy6mUPiLT5QZgmicpTfnREDk3ojEWC7/NK90FoiqvfWHKUEepEKm3/kMNMKHj9d9jt87DB/zxHOJ8bemcQaovXjZlE7zjoxJyEmB0C4EBVye7gUkmVnfy3y7470o6UkyFLkqdkMIqu0B9YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6NGY53S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767793836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwU3Ac+NpGby+4CQIUS5mhzem4J8LDUziJc+mt+weZc=;
	b=M6NGY53SvZdqcok2/vEkS+o1Be+flSXui11kHO04hlf1rKFRc6wxDjhdNXIQAd5kuF0a1S
	mQ/s/QFweK2QKgpCPUsQJWYyYaMfb69/HkGoHmlYzAuiViUAye9Z4rGnPfXVejgQ8woSyS
	54G0FOjQMtGgPZ2j7wA3OXpzKv/4/GY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-EqiT7SACOKCdNoF4yWp4eQ-1; Wed, 07 Jan 2026 08:50:35 -0500
X-MC-Unique: EqiT7SACOKCdNoF4yWp4eQ-1
X-Mimecast-MFC-AGG-ID: EqiT7SACOKCdNoF4yWp4eQ_1767793834
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38301621868so3293031fa.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 05:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793834; x=1768398634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LwU3Ac+NpGby+4CQIUS5mhzem4J8LDUziJc+mt+weZc=;
        b=oj2oQWCG0UutHLuEnKRNXUix0+15IrXs2LO43lJbqVgllG05BIyv4gfxccbOCJBtLX
         BC36INvWhLcQdeDmZO+uOibrajlpWB1F1W0mVfedhn2lx2pz9SZ7yLhzIMA7bBr6T7ay
         eKa5ps9iw0cYTxttmm0aN/0y43e4IfK3RotH1H+DeSfQzxAbFz+bA4j/Ebd92GFyZJdT
         MQYLg4+PRtXg45qeOxJcJlp5/D8xX/1CTxdvCsaRlWDqLjNj/4+N9egEzygQZriOnegI
         //QUrOhblx9Y7kan6vHUFnYYGOSFdiGVtgRc2bJhtg6pzKGdtZisbhp0RFjzdhobTsKw
         gEyw==
X-Forwarded-Encrypted: i=1; AJvYcCXyD8k7kJlJWT+FiYgd1lRnuhVqG4GFFRbnsL2vMnrT7bph1V/HF0wphi8cHoyR+L6LCSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBX5W1ID0pSEgNz97F5TGJHauHqupl2t0b4lyFYeIsFR2GLxEQ
	PkhYkEL4vLzNSq0D0RK5ahTX9JLonhgd6J4/u2XHCFTETRFMB2/VBpTizZSMbHZJGlhn8ESixLq
	u0Lzxfv+VexMj6h71icfvd5d014ihNXBvHZeScg0rfeEuJlwtICYD0x+ZmgD8p+GbhMjjJp+6WF
	zovQrxU435hi2CQzbC7nDLjvF3t07y
X-Gm-Gg: AY/fxX4N9P4Zvhwb1BTIt9Fr7Z/I55kD7GN30CEU6rizIM0aQ+9mrBLmvdawYAaQand
	rDwnbdvFSG1zqpzTX49EP/upI3rdG0TK6kVFR92qZ6w6IeUYXakhq7UM3X9f0YO1n9m/8dVBOhI
	gOia+htaVhlK++6bAIL2/hXC8oHgX39Ut3Gbxqrb7hH9ciIBij5eBhjY6S6IgaHfXt+MHjKEkQM
	7bD0A80WKcx4WeABdgA5fOoMn+XBrSek2r2uOrKx/0sX01prWoqXPypqw/ON5iIiUyNKQ==
X-Received: by 2002:a05:651c:2212:b0:37a:584c:23fb with SMTP id 38308e7fff4ca-382ff6dd8eemr7013461fa.20.1767793833662;
        Wed, 07 Jan 2026 05:50:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm0tMT9u9iiOgRGj9K4E0/pPEVxnBe2X5bK9p2XFMNMGYd0BXK04nFgMfu+eVzo44KLvloczFrjtUOGz4zwfc=
X-Received: by 2002:a05:651c:2212:b0:37a:584c:23fb with SMTP id
 38308e7fff4ca-382ff6dd8eemr7013361fa.20.1767793833177; Wed, 07 Jan 2026
 05:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-8-wander@redhat.com>
 <CAP4=nvT2oPtM73nfPkSJZ4612mcAPw1LWbHNrszFBVAmSJOVbw@mail.gmail.com>
 <CAAq0SUmrRecimVNCa=zv-h3uPm-GpQo3g+ZTV4zLNVA4ZVo-EQ@mail.gmail.com> <CAP4=nvTeFtHF+K0h0FkWMh6uLb5Qwy6LnYPcrbrbNOM6M6kFNA@mail.gmail.com>
In-Reply-To: <CAP4=nvTeFtHF+K0h0FkWMh6uLb5Qwy6LnYPcrbrbNOM6M6kFNA@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 7 Jan 2026 10:50:21 -0300
X-Gm-Features: AQt7F2rnfMsmprZP2rAt--ee_rglZ18N55qI7Xvqb6bhHKWfVtx_oS-Vwti0GG8
Message-ID: <CAAq0SU=QWnfQnfKM=YOcBVBh6wuqaFub4kDf5taSv7PCMaOfnA@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] rtla: Introduce common_restart() helper
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 10:47=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> w=
rote:
>
> st 7. 1. 2026 v 13:43 odes=C3=ADlatel Wander Lairson Costa
> <wander@redhat.com> napsal:
> > >
> > > The deduplication idea is good, but I find the name of the helper
> > > quite confusing. The main function of the helper is not to restart
> > > tracing, it is to handle a latency threshold overflow - restarting
> > > tracing is only one of possible effects, and one that is only applied
> > > when using --on-threshold continue which is not the most common use
> > > case. Could something like common_handle_stop_tracing() perhaps be
> > > better?
> > >
> >
> > Sure, I will change the name in v3.
> >
>
> Thanks.
>
> > > > +enum restart_result {
> > > > +       RESTART_OK,
> > > > +       RESTART_STOP,
> > > > +       RESTART_ERROR =3D -1,
> > > > +};
> > >
> > > Do we really need a separate return value enum just for this one help=
er?
> > >
> >
> > If it was success/failure type of return value, we wouldn't need.
> > However, a three state code, I think it is worth for code readiness.
> > Do you have something else in mind?
> >
>
> The main loop can simply use the continue flag, just like in the old
> version, no need to duplicate that information into the return value
> of common_restart().
>

Ok, I will change it in v3.

> Tomas
>


