Return-Path: <bpf+bounces-78274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95ADD06CA5
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 03:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB35A30213ED
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 02:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9AE241691;
	Fri,  9 Jan 2026 02:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkxEuUm9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982EA1DE8AD
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924442; cv=none; b=Qd/Gw+OAcsmUuXoHlmCj/ZiKKUJyC2plKNY12kCqdH7WKCRgfVplfGIi+uspyFAVKD8noc7XDtAhAbqj7PImqu20kUOWFaezfEwpghMjZgA05bsHrtHduTElyQLpLi8+PGkD66FCAnEK2S40TyaMukAqIeuf92T+3jWSI/vqZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924442; c=relaxed/simple;
	bh=hryLOezKFof52w71+g+6rMkFSW0KcZ3Y2GED6sVOngY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJSt8L8a8S5cLKj53p841Nm7FI0PxgdHytSHBpZQ6D4xvqccnmi4AzqDPbPDOg1t8HXfN5oh494V9VsVUgqOXU5i43M5EY27ZpqhE5CzFQ8DmOR/Gaf4fZQNIK/dloTf6JYYhDmnzzJYqmdmdeOlzbUDWtfKzbtzMp/VmZRs8lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkxEuUm9; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c075ec1a58aso1613636a12.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 18:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767924441; x=1768529241; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XUEBLmAfaZ8cBF45qcHkQRL5J7DFqwKhkJykuJ8KsQg=;
        b=bkxEuUm9bGfTAvqOxdr/kptcF9S13wQT/qZ24PzlK02V4XWLvW9kElFlHkzyii1phT
         05CcCD9Hw4bn7iGI1hiBZ7ZCXbIP65aGd9c1b9h3iv3z6Iyef4wo+B8c/lORDprZnyHx
         NI/tVCOYAOSLbyH7YMYmex10PH+5CzBZUVB4R0FbpviK5374834Y2k8rYXTcy1TKmxGt
         bvVPz9LjOm8PQxllyIP0Q39xKNOXX7Rt4oSoxl76ieaX/Nk72humzOn7PNieJyVHIW9D
         /BZukIH2tI709cZfQ0JVu00Lzx4ozDDok9SoxbrSR7R0VFxpmuRTcCnPGqdpJR09n3el
         sLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767924441; x=1768529241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUEBLmAfaZ8cBF45qcHkQRL5J7DFqwKhkJykuJ8KsQg=;
        b=ReWnOYcrO/C4PeboJpKcEwDA32RUDWdjlfL6+8qP/ghbbNoHwxj5qF2Mepymw4HtKv
         7J89qua/ZEF2gcEcbVdGWUimSs46/Iu2MR8QIRQMn5q0gXUSgVuKrQdd90DXze9Blzu9
         sETZ7I1jTrM+LG1uD+1y6CQoCONV3C76JU5xNwIdCLGgJjx4C19R4tBbbcgcFWc9T8JF
         6gF2iWZ2V45QE5OgeKZHyc94eVLOFu7VpkZ+0XaYktwMiYsCV3ZpX3+EjvUazP40+1dQ
         x/NDdUUdhg3szubjAyTEmpy4I1v/5Uvr0iz3AGj8iC60sVuzHLcrbG9CvMYUpnUqqojW
         ZONA==
X-Forwarded-Encrypted: i=1; AJvYcCUlBwulBQz2WGROb9F7N93Low8sKAS+blCTnmsCrtXcbGI+sVfq6aXs7VEdQYpKQptZX9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn6cD/v3OBlln6KkMTPpHTQbNEBD0DQav8cbmBWdaNG91MCHj3
	Kq8X+Q6F+YNGYXMxVOrmgs2DC+zuPBsGY4CqgcXaQefYjnbNUGCGA2oa
X-Gm-Gg: AY/fxX4XupG6WPUlyLlHvfVuzSGkHTeaqV5NHjd8Z4cy5qg3BmJIM2GeHf+Nl8mRp6R
	VOeQGa+s9FhyO/fJ1w5dzL2G6KIGfASXUvIoBVSLvfyY53riHnIhE/Z6cVZm+kk9VmEs4dwluaG
	ctNbNM+lgXVq+aNm1s/Yy+90dNzA0terhdADuiJjfosTBeZIK8McCpmaKIehE7kaHVIlnvHb0Y6
	3a0xkEm4BwUHIHUVS+QZ8k6hEC4RaSfz0bThPJUPlmZEdHVNFwnr7+atcorM/SuGxVwoC2zVTgK
	adsIGoWZxa24Ej9yI1cutThDvg6JyMIX7urbe6UY+IS84iEYG4CV19hbL3LXIRrSh5bFO3Aa8qI
	4CG1uCxLls2qnkGjdfPOUOMLHlvBzZmnDQeUZmxJkGryJRFlenzTV5/P7nAAShFo+tFICxn60r1
	ZBnYJIyG9b28MlS1s1S3tTjYDVhaQwxDr/CA6z4dtB
X-Google-Smtp-Source: AGHT+IHqvy6fiN7FRUjf2TWkekXz9PGcC0SYIOhfeXlgICFzdwmSW8tfRVUrnhzGtyIN0qdBiwkBDQ==
X-Received: by 2002:a05:6a20:958e:b0:35e:521b:f484 with SMTP id adf61e73a8af0-3898f9a09d4mr7310394637.42.1767924440792;
        Thu, 08 Jan 2026 18:07:20 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca72bfb8sm9193935a12.36.2026.01.08.18.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 18:07:20 -0800 (PST)
Message-ID: <b0c80439d8da0faddde08260d6e796629d55e9d6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift
 in the verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov	
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann	
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi	 <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, Kernel Team	 <kernel-team@meta.com>, Hao Sun
 <sunhao.th@gmail.com>
Date: Thu, 08 Jan 2026 18:07:17 -0800
In-Reply-To: <CAADnVQ+wK8qYt=Gm=Q26Kh_enOHGOk7_t8FX70J08WUMu5y_Nw@mail.gmail.com>
References: <20260103022310.935686-1-puranjay@kernel.org>
	 <20260103022310.935686-2-puranjay@kernel.org>
	 <CAEf4BzYeF2sUqEzfT6aLuBVuh1W8fkxHoFjBf-e5nvJW9UgQLw@mail.gmail.com>
	 <CANk7y0j_BW_t7Y6rPm-UaCsamJ6G3S9i5_0cYLWZ56xp1Dehkw@mail.gmail.com>
	 <cf707af183cd296c33576e478c5ba5f561350b43.camel@gmail.com>
	 <CAADnVQ+wK8qYt=Gm=Q26Kh_enOHGOk7_t8FX70J08WUMu5y_Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-08 at 17:18 -0800, Alexei Starovoitov wrote:
> On Thu, Jan 8, 2026 at 10:45=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > On Thu, 2026-01-08 at 18:28 +0000, Puranjay Mohan wrote:
> >
> > [...]
> >
> > > This is what you see when you compare this version (fork before and)
> > > and previous (fork after arsh) on the selftests added in this set:
> > >
> > > ../../veristat/src/veristat -C -e file,prog,states,insns -f
> > > "insns_pct>1" fork_after_arsh fork_before_and
> > > File                   Program  States (A)  States (B)  States (DIFF)
> > > Insns (A)  Insns (B)  Insns (DIFF)
> > > ---------------------  -------  ----------  ----------  -------------
> > > ---------  ---------  ------------
> > > verifier_subreg.bpf.o  arsh_31           1           1    +0 (+0.00%)
> > >        12         11   -1 (-8.33%)
> > > verifier_subreg.bpf.o  arsh_63           1           1    +0 (+0.00%)
> > >        12         11   -1 (-8.33%)
> >
> > Given that difference is very small, I'd prefer forking after arsh.
>
> why?
> I thought last time we discussed the conclusion was to fork it
> before AND, since at the time of ARSH the range is still properly represe=
nted,
> so reason to take chances and do it early.
>
> > Could you please take a cursory look at DAGCombiner implementation and
> > try to check if there are other patterns that use arsh or arsh+and is
> > the only one?
>
> Well, it's in commit log:
>
>   // select_cc setlt X, 0, A, 0 -> and (sra X, size(X)-1), A
>   // select_cc setgt X, 0, A, 0 -> and (not (sra X, size(X)-1)), A
>
> I suspect 2nd case should work with 'before AND' approach too,
> since 'not' should be compiled into XOR which suppose to [-1,0] ->
> into the same [-1, 0]
> But better to double check, of course.

Here another example from DAGCombiner.cpp:

  i32 X > -1 ? C1 : -1 --> (X >>s 31) | C1

The same trick, X>>s31 is in range [-1,0].
But we can fork on OR as well, of-course.

