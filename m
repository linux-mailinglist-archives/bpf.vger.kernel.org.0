Return-Path: <bpf+bounces-16778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB6805E28
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF571C210C4
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 18:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F6967E77;
	Tue,  5 Dec 2023 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNMvkorN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717F8CA
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 10:55:17 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1c890f9b55so123169666b.1
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701802516; x=1702407316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS0ICr4Fgf5C3ddiDdkn44Sxr4wvflqTWvNAGMVQOnc=;
        b=UNMvkorNSJXm5P5jJkKUgbtW6zy9EI9XyjP7GKtw23ULxYob47axIURwR1w7ljnVbo
         PR/f2GADd6OcAAjWAXjemjtbrKFnk+9eZHJyOs6yYfbAVXzXcxd0tjvtWCtMrbd4QlOU
         n9nB3jNe7aCc72H/VjtyClVRofZjU5VuvS6SbNYj0nKrDRiE6xUA40g5zuYSg4ckA+CW
         IH1SY+/53NOqAVTj4m56FcHodASuja2thEqz13DC2JZoHZmCCAYWOCfQHYSQHhUkwHzm
         U81nWVETZ1gHoZreWSyrYyZu2XjzgNrh/3MtLW0fuON8Aqy5kwIqeHzDLRblXKEjT/jT
         IEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802516; x=1702407316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fS0ICr4Fgf5C3ddiDdkn44Sxr4wvflqTWvNAGMVQOnc=;
        b=kGlOHjnqmGfFkDLU8ZbGugjDwiEEDBFNWWdZews4mGUHAT1ww6rLsT9EoRdaFfGD0P
         rIDaIF5UjhPyzlLSGxZaG3PnWqBUPorJabV++smB84hhUBxS6iKSWyKneQZQJ8xP6lTG
         VmTLGhA5r6kUpR7PQtceLuEV4AwP8Ffn8lBUrhwGonSaHQ9cXfhfbrRVAUSykNNZD8v3
         1LoOkfkmbC4GLkyRu+6/PIH3ZrckSJpndO15uMJUG8fCxtUvxgEs9nkiINa4P06J6TxZ
         XBJBIho7m+oUFlWdP+6lRfWARp9NE/4vI82pL/eUdY96LkdJPNltqdsGeqWOvab4+L61
         owOA==
X-Gm-Message-State: AOJu0Yy28UkTIO3r3N7D7b0hJgRZTCR4RvxrGHr8DgfrqKWlhTYmWe4O
	ftmcBCIYx9R8zcvxZU4Ap+tYBj4IlHyaMRyeWC8=
X-Google-Smtp-Source: AGHT+IHxUIXqQtuCJMKPxANZpU3SBXNdWBCp8Ilzac6/OjlP4/IoInqMZliHAFhlCtVZysouCC87qSeW45DgZjs6XvM=
X-Received: by 2002:a17:906:658a:b0:a01:811c:ce9 with SMTP id
 x10-20020a170906658a00b00a01811c0ce9mr4769309ejn.0.1701802515765; Tue, 05 Dec
 2023 10:55:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204192601.2672497-1-andrii@kernel.org> <20231204192601.2672497-4-andrii@kernel.org>
 <3fca38fdfd975f735e3dd31930637cfbc70948f4.camel@gmail.com>
 <CAEf4BzZ0Ao7EF4PodPBxTdQphEt-_ezZyNDOzqds2XfXYpjsHg@mail.gmail.com>
 <6875401e502049bfdfa128fc7bf37fabe5314e2f.camel@gmail.com>
 <CAEf4Bzb8LouFSSX5DED_ucgq_xuhukE1BQ7y=hxY0c17Nq4T+Q@mail.gmail.com>
 <7aa8af01db4fdcbedab376423d3960c22016aba3.camel@gmail.com>
 <CAEf4BzbK-D0+WU8A--+43TXb2rgUgNPaUs3Dbg4Rz1_hL6A_tw@mail.gmail.com> <534cdf2646333c301d80f731bd08424a15b20eca.camel@gmail.com>
In-Reply-To: <534cdf2646333c301d80f731bd08424a15b20eca.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Dec 2023 10:55:03 -0800
Message-ID: <CAEf4BzZ=JS8zznfM3PcC4i4HOy5ANNJRnycm90AfnjAs4YLsSQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: fix check for attempt to corrupt
 spilled pointer
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 10:49=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-12-05 at 10:30 -0800, Andrii Nakryiko wrote:
> [...]
> > > 'type !=3D SCALAR_VALUE' makes sense as well.
> > > Do you plan to add this check as a part of current patch?
> >
> > nope :) this will turn into another retval patch set story. Feel free
> > to follow up if you care enough about this, though!
>
> Well, it's a regression. On the other hand at my old job we considered

technically, but it was never meant to work, which is why I'm ok with
fixing it by tightening the check

> that feature does not exist if it's not covered by a test.
> I'll do a follow-up.

thanks!

