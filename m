Return-Path: <bpf+bounces-11337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5648A7B75C3
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 02:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 063EF2812C8
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2B4374;
	Wed,  4 Oct 2023 00:22:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2827E
	for <bpf@vger.kernel.org>; Wed,  4 Oct 2023 00:22:55 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273648E
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 17:22:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso257346266b.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 17:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696378972; x=1696983772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MHVLaedj4g/c3tPVcV8pmigaMsH0jqAy5Bu1idQin8=;
        b=fmZBMLE3b6Kang1D7OFC9f5YtrN1SUKuiXs9+DybM4ekch0p35pFa5/sTApd9WegZo
         GUKegAUPnfkX6CImffI1SB2oQ4bTMC5UO2g/FsShOG6YuifgGe4LsmAIbF8nqPctUYKc
         FH0Ft3lEaj/oJ09jNQiy4JqXByP6AkjlLkdfmE8+1/lMaRD6a0VIGyP5g4TL463VTeLp
         rkqUatsth6ebZgPBQl8F5/1YqDIV6ByhkmfgGqB20gS5ue3RM2oDCLJFY+IJfu/AT4qC
         NnSfIy1cP4fIFetBuxIo/nuTjg4O6d33clhIuAZwj2jirMXYNiQLTgcYcmm9z0sOQvCY
         rDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696378972; x=1696983772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MHVLaedj4g/c3tPVcV8pmigaMsH0jqAy5Bu1idQin8=;
        b=UkowQcQvYsxCCm5AFNJ+rpAg389AIlv+noN6ckBbHmK+vSq6CWoY6zjSRSQpX0hYOK
         tJVXzhGP1s72dLcjEyUwqieO0HbW68UcUTJkmFs9XznjJ1WcqXMmC8H4RLbCbHj2FhSR
         pbjMfRG+pjK66WpespwPGeakN0O5C25kqIOSMmnV7tp3HoW3255CNvlZ+kdSgexithX4
         +GmrjvzPwvka7WN5aCKUZoUwnJa4Wqg5CjptLC1oJHJe1oE344s3DFpmPC6413Kf/OW6
         Vj1qGGH479EM8JYtZ2FfinzzRsrSMoMElZWKyeyutV4iFJ+TrlkYyBHkobenl/UGlnIe
         JMtw==
X-Gm-Message-State: AOJu0YxHrnFp0pMXlNZCEfTWH8kyKoFRZ80B+vduLJ4Ay1j8gUABTP2Q
	gUHgFUr0Sl9jltcJpDtklhwoXSn+0yDWXSmDK7jjc55S
X-Google-Smtp-Source: AGHT+IEzwHQMiH31dGcNGUssMNNfoVh/aIBKTcloNgRLNV3qygKZQvqeg4ulxCz0P+p+onH+U7EiRIAsRwDX/BiMdl0=
X-Received: by 2002:a17:906:30d2:b0:9ae:695f:f938 with SMTP id
 b18-20020a17090630d200b009ae695ff938mr593087ejb.56.1696378972574; Tue, 03 Oct
 2023 17:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzZ6V2B5QvjuCEU-MB8V-Fjkgv_yP839r9=NDcuFsgBOLw@mail.gmail.com>
 <d68855da2d8595ed9db812cc12db0dab80c39fc4.camel@gmail.com>
 <CAADnVQJbKf5PgL5fokJAB4y5+5iqKd17W9e0P6q=vJPQM+9NJQ@mail.gmail.com>
 <9dd331b31755632f0528bfb1d0acbf904cedbd98.camel@gmail.com>
 <CAADnVQLNAzjTpyE7UcnD0Q0-p4fvL6u_3_B54o6ttBBvBv7rFw@mail.gmail.com>
 <680e69504eabbae2abd5e9e2b745319c561c86ef.camel@gmail.com>
 <CAADnVQL5ausgq5ERiMKn+Y-Nrp32e2WTq3s5JVJCDojsR0ZF+A@mail.gmail.com>
 <8b75e01d27696cd6661890e49bdc06b1e96092c7.camel@gmail.com>
 <CAADnVQLTe2=K1nTk+Ry8WmBU1C724paoT8p8_7jYL9oymchp_A@mail.gmail.com>
 <5b7f4b6199decf266a9218b674c232662ed13db5.camel@gmail.com>
 <20231003230820.iazvofhysfmurwon@MacBook-Pro-49.local> <7fd8b2cb49ba45a0c695aa954db8cd753c664ce4.camel@gmail.com>
In-Reply-To: <7fd8b2cb49ba45a0c695aa954db8cd753c664ce4.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Oct 2023 17:22:40 -0700
Message-ID: <CAEf4BzbHLiDM0fObGXBuuDO24MBNVo2dc41VvfhWNP9osxZ6Ew@mail.gmail.com>
Subject: Re: [BUG] verifier escape with iteration helpers (bpf_loop, ...)
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrew Werner <awerner32@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Andrei Matei <andreimatei1@gmail.com>, 
	Tamir Duberstein <tamird@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, kernel-team@dataexmachina.dev, 
	Song Liu <song@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 4:14=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2023-10-03 at 16:08 -0700, Alexei Starovoitov wrote:
> > ...
>
> I'll reply a bit later.
> Keeping all states before loop in a limbo might indeed be an issue
> performance wise.
>
> > I think we need a call to converge. Office hours on Thu at 9am?
> > Or tomorrow at 9am?
>
> Both are fine by me.

Ditto.

