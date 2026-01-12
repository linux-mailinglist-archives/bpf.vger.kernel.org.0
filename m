Return-Path: <bpf+bounces-78615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B7D15240
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 20:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7254030082D4
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E78F327206;
	Mon, 12 Jan 2026 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFbiEq4D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DEE13D51E
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 19:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247907; cv=none; b=D6HSXf0Z510IJI2OmmjCg0meNnHTjgF+thfj1UXslXNYPwjw6JcrvzDDKu0QzzHZFUmmJrTpjsC/s7ANK2Xvco6vtXs/sXwWag4OSS/0CYUMBdw2GGFpaIYEa2JOGb9Z4z8wosWP9wFmk+wl6APcqySEA/orQFRXj3MD+JDwJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247907; c=relaxed/simple;
	bh=mdVF+wmZtFB/MYrbNPhv8ax3nMAbQoBY588QV0ABZL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNusViuf1rZqZ4o3V+UEOhbmNfaNic7Cwg2usoUX+Kxa8CBLkPzEXvn6KfFw4nEgjL94iBPAcOgUwFdZlaU4UeMCj16gwc8Tp2qNfjTQR2WNMoXzlN/cmqXo64KgHjinLwxSOE7T1pGI17mbp8TDxLxnU365Z8Ccmqq6kMgBaYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFbiEq4D; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so10783275a12.3
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 11:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768247905; x=1768852705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHUtQco2qt4VlshN/yTDFydpX8nzqbujiBBoi02h7a4=;
        b=KFbiEq4DwcJ53X4tdXCqf5NeLa5OAXionrUY3TLQjXjch0wGdy9z6L7wAhJO8j1+0Y
         XElgih625kVO21IcHWcwcEOlytEeAJLsdOJ839wOSVhGZpCdCDNvQC9LNHjtMgAqYObk
         xdOt2MXqWVhUtOWoV4JQTmW1M/awLXDmj6cqaPMgvwd4fDlj5TYg9co9Gfs4IWMkhWU/
         AnF0kFY+dYN0J3UH72dJ3nMMTvoPfE0fHh/nbfbqDvvhulXrrSFcdHonNFv53R7fgMpF
         3jtTjvJ/8pO0BoMeOF5SZnmtHX+pBKZITqpefxGn9ceZ4eCwRGfXtj0K2MzzvW/BcZna
         s3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768247905; x=1768852705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UHUtQco2qt4VlshN/yTDFydpX8nzqbujiBBoi02h7a4=;
        b=e8hvKNgXFYTCnlIIcQ/WxzarkEvU1yJj/6bfXHAWQJjO0WmmySaAVb5/0StSCfWCE1
         AEkym6QMJXoIr6kq1ohin8x+u3Yzhr4VtPmfwBfJeEqunpeKtX0rHJ+Wpz1tqZpBnLjT
         rDsabZoDPQQPc7n6lgAsH36L8H5WtdN7ENr9jFxx+9LYowSqHEzhvs0W89pQdgdwPcdj
         Nq6jF8ZTtAx9fJfpE634/my6xFUO1dmSLTFE17/j4qcItHaTYzYHoW9jAuZImuscQ9mp
         ihBo3S7Y3/CRt5HIDrzkHwCD3kqxBYmWzhLYQMAuBjWAcRShVtKLOiveBABKlUHU5Y7i
         DoRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWox0lBvzN/JRSkK776AnhmjYnclMIQYEPsSkH1pHcm3GX6LCwP5ArAk/8jJXch1ehbeBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXWd6WgGcm+l9GYCiLe/aJlbTcaM0E2UF3XjOTIF6HvA5mZGwI
	j6jHZQfwahMT+3xyxJvKS8PZFCZvnjzjf2UWIfOg7GGY4SG9aRX8tqMF1uAinkEUYq4Nx90KHdM
	Q4IWgPC641c1PT4PAqltvAAKNfBV1vkgGeQ==
X-Gm-Gg: AY/fxX6MX0IeSb5owzmskb/95bIpolURJT4HDPaLDbaOfbfRQPhRXbjy/GkJ0PoAxqO
	01q02OYU5TNJctlNXj79tl+FBqZJYo/SYLMWEwOiZ7cpWiBP5X/ZgoJMFlEWa1vAHqDNVOPYFG5
	FfMGt0vMdXklOJgYJcwOuaVNIyKJBvpcTaKPwcwwhgicOsPB921wZzKQWFGwyBlRYT8U5ChwTrd
	NLz9CEzlzDH/GqOFd3/tYq6kc+tgotwsy2aNW0/zmd88l3Y7jFe1dl+Av1DV4YOpxlSZ0A=
X-Google-Smtp-Source: AGHT+IGRjgKFcYhR2lrEoiZv42ht5/YcDMnXrpV/QdRZPj5LH+0I5K/4xxCc4OuFIVui/+LKwogLNDay8aGcm5Byt3E=
X-Received: by 2002:a17:907:7294:b0:b87:253a:dd2c with SMTP id
 a640c23a62f3a-b87253ae349mr345891366b.24.1768247904295; Mon, 12 Jan 2026
 11:58:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103022310.935686-1-puranjay@kernel.org> <20260103022310.935686-2-puranjay@kernel.org>
 <CAEf4BzYeF2sUqEzfT6aLuBVuh1W8fkxHoFjBf-e5nvJW9UgQLw@mail.gmail.com>
 <CANk7y0j_BW_t7Y6rPm-UaCsamJ6G3S9i5_0cYLWZ56xp1Dehkw@mail.gmail.com>
 <cf707af183cd296c33576e478c5ba5f561350b43.camel@gmail.com>
 <CAADnVQ+wK8qYt=Gm=Q26Kh_enOHGOk7_t8FX70J08WUMu5y_Nw@mail.gmail.com>
 <b0c80439d8da0faddde08260d6e796629d55e9d6.camel@gmail.com> <CAADnVQJnjZjRdJNgSOSzt8z8DfRN7z5Ksgfi5gkY-O4Dp1e-yA@mail.gmail.com>
In-Reply-To: <CAADnVQJnjZjRdJNgSOSzt8z8DfRN7z5Ksgfi5gkY-O4Dp1e-yA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 12 Jan 2026 20:58:12 +0100
X-Gm-Features: AZwV_QhYHn1jX1Gr8nn4nPd1TDDDf15jdas6mXYEqvaLRcGRfdQysALpUsnWWmU
Message-ID: <CANk7y0g=EA05bnR_uiji0v+w-5fdV4FBmsOwjRpRf0VE1ny7TA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift
 in the verifier
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Hao Sun <sunhao.th@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 3:54=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 8, 2026 at 6:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Thu, 2026-01-08 at 17:18 -0800, Alexei Starovoitov wrote:
> > > On Thu, Jan 8, 2026 at 10:45=E2=80=AFAM Eduard Zingerman <eddyz87@gma=
il.com> wrote:
> > > >
> > > > On Thu, 2026-01-08 at 18:28 +0000, Puranjay Mohan wrote:
> > > >
> > > > [...]
> > > >
> > > > > This is what you see when you compare this version (fork before a=
nd)
> > > > > and previous (fork after arsh) on the selftests added in this set=
:
> > > > >
> > > > > ../../veristat/src/veristat -C -e file,prog,states,insns -f
> > > > > "insns_pct>1" fork_after_arsh fork_before_and
> > > > > File                   Program  States (A)  States (B)  States (D=
IFF)
> > > > > Insns (A)  Insns (B)  Insns (DIFF)
> > > > > ---------------------  -------  ----------  ----------  ---------=
----
> > > > > ---------  ---------  ------------
> > > > > verifier_subreg.bpf.o  arsh_31           1           1    +0 (+0.=
00%)
> > > > >        12         11   -1 (-8.33%)
> > > > > verifier_subreg.bpf.o  arsh_63           1           1    +0 (+0.=
00%)
> > > > >        12         11   -1 (-8.33%)
> > > >
> > > > Given that difference is very small, I'd prefer forking after arsh.
> > >
> > > why?
> > > I thought last time we discussed the conclusion was to fork it
> > > before AND, since at the time of ARSH the range is still properly rep=
resented,
> > > so reason to take chances and do it early.
> > >
> > > > Could you please take a cursory look at DAGCombiner implementation =
and
> > > > try to check if there are other patterns that use arsh or arsh+and =
is
> > > > the only one?
> > >
> > > Well, it's in commit log:
> > >
> > >   // select_cc setlt X, 0, A, 0 -> and (sra X, size(X)-1), A
> > >   // select_cc setgt X, 0, A, 0 -> and (not (sra X, size(X)-1)), A
> > >
> > > I suspect 2nd case should work with 'before AND' approach too,
> > > since 'not' should be compiled into XOR which suppose to [-1,0] ->
> > > into the same [-1, 0]
> > > But better to double check, of course.
> >
> > Here another example from DAGCombiner.cpp:
> >
> >   i32 X > -1 ? C1 : -1 --> (X >>s 31) | C1
> >
> > The same trick, X>>s31 is in range [-1,0].
> > But we can fork on OR as well, of-course.
>
> Good catch. This one can also be done "before OR".
> I doubt there will be more combinations that make
> "after ARSH" argument stronger.
> I guess I don't mind either option. Let's pick.

So, Eduard and I discussed off-list to go with before and / before or,
so I will post the next version with that.

