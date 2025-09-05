Return-Path: <bpf+bounces-67639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE87B4661B
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 23:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28CAAC43F8
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601922F3625;
	Fri,  5 Sep 2025 21:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="En0dmaed"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C82F362E
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757108630; cv=none; b=F6fCbeLvHbZrKuscEw4A2NZ5arVWRPLQOzXp6aNS5OdYucNq+w20B0aTZmoEYLzfIQHC2kLNPb1J0BKF/0V2YqU/BNnCgtkSe447AHl8tfOuae+tBnewEwkyICY+Cs0gF30Ex19uSt4Pt+MPjHwq6WxUnu+awu/w6LFw6pZCteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757108630; c=relaxed/simple;
	bh=e2Ke8QRm6aiKXE3WoyccnIFNBZp60zHAL3TiekXAKKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FKVf2R8bSmvl9340ydbn4q3lk9FmtkA7QgZt1Uo/Glbb+cCTOlH48+uDcZ0PhnJn2+C5bAgdBWZx/7G7Ks4IjUB5bMlxFhXca8k/Vj63XkS6V3gPvsfmWzwSNRFqYZPX2Dp4J5vwxudsARR8cQXBqdEpfG5jTgfmsblRhO+joOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=En0dmaed; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24c89867a17so26113085ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757108629; x=1757713429; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xiShzlgHnYDg9jB/YgsXyLkekzP/aF65CvYJHNeWgPQ=;
        b=En0dmaedbrPJWETTSHRSrXeF79C09SLdWzC06BLsUZST3aIMuSBRcyKsYOWaAhEGxH
         +jQiSQjzm0z2TSJaG10NTgB4UPgNt0dtRp70mOyBaJguomWU/cd1Qk8N291M2SkuyN2v
         FKabu7zi53VFQUfWuQq1mty7xHQwhysBM4/TU4XoaFV84bL2zW4o/Q8Be+vpjDICnC6o
         6wObTh9oceOcXDxuQmf9/l1N4+dqzIpC/94cGnezAdjndpKoNI+kiYOU78LEiwtx1N8h
         5yQ8tM3LIkVDtRzcrrsl90ZqN/c+lbO1Brv0TWTca6uBdiAnkjMq+c3BUcZClaHKIEP5
         j8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757108629; x=1757713429;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiShzlgHnYDg9jB/YgsXyLkekzP/aF65CvYJHNeWgPQ=;
        b=dhxj2fLyEa3bgs2KcoUbf62guVGfg4amub8T8kl4uPa5p12QtQBAkR+ng1qRHIzi9r
         YiSXjPBJy5/UnZksCoO35V2YfxwMKd8B4e7m60T/vkKs79cbX8nwv9E9rqmps2UgX7EF
         jueIDCy3+XUUT/XGRXmMgnbRgXxl1c4WweykRBow4yrIgg8qYRc5izBLKuJu176BklKs
         IrviaYolxWmokuLfPP+PI6ofHkY5rH+h5HRBZjMdyJz4Rno7++LrL/rQBWqezSe19U9l
         ZS2PoznrI4o8RS1Ryykea7gTpK8RZIAgdWuMChVijaICsLONUOaZVR+psVJZwo1ekzEu
         tMiw==
X-Forwarded-Encrypted: i=1; AJvYcCWn5NREpXiDefNGMVakrfAPM88q+cwqNC2G5hGNWWqtZ9TibYlQSCoqjGoubTDHNx2+quY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxUvjUkOe6L+Zd2zBp+iQ+Fc0L8vDUq2DTdsTqElKO6H3n6wf
	+8mPrjqAWSXhxr34+4OeBjRLWLrIajWZv4Tt1rinhfceDAINPLCMZKlVUiZi0w==
X-Gm-Gg: ASbGncssr8X40T7KMcHEtSx0ha3G4uS22nFDAVsl4GEW5LPeBHMOcPHi8nhGLHGBKE6
	784fetl+3B+aI/c7efOZWbYKXntjJCKviYJbYyf16BCNKapOc48h48KAvEJ/dkb/+KVut9apVWQ
	0wY+yCijO1aODOSTH99IkjtbqSVyhlL8wXFbe0rpBXbwfhkdtwA0daDAvruQxZuP34be+UdHXJl
	kuVjgaBF3eAuzTfcob6tj5s1g6sfs+mta7qXXzdqe51bmekQPvM104KHlVYlB3W1lVIM4DDSrX0
	e0vjXsKQQD7ReZyqgChe1+oOvRhZv1sorA1U9NJ9D77xWOxg1B2lCtidwrUSVGloDSaKZavgLXU
	cnubRWhZfjX18T+1dGUlQLdkahS1f
X-Google-Smtp-Source: AGHT+IFtqJ4Vv5HU/Aq3PjsvXs0h9HPVweOEXd7hDAQXbTu6Th49gz2YCSVV3RQ24ibcbTlKbB5qUw==
X-Received: by 2002:a17:902:cec6:b0:24c:da60:c2c7 with SMTP id d9443c01a7336-25172293713mr1702055ad.43.1757108628508;
        Fri, 05 Sep 2025 14:43:48 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b160a3ec6sm108769205ad.27.2025.09.05.14.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:43:48 -0700 (PDT)
Message-ID: <84b34c685418234c21bb3c127bb966d5744efc59.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7] selftests/bpf: add BPF program dump in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 05 Sep 2025 14:43:44 -0700
In-Reply-To: <CAEf4BzawRYXXSJDiK4GzuYo=g-N_-QMgUXQAGN15eaPYuWXBWQ@mail.gmail.com>
References: <20250905140835.1416179-1-mykyta.yatsenko5@gmail.com>
	 <ac6e70c96097c677d5689d86dd2bc0dea603a5d1.camel@gmail.com>
	 <CAEf4BzbZg-BqMQV5vKHSDPabZQbpHFbdZhQ4NXCRiAZvh0yc=A@mail.gmail.com>
	 <d38c391c806ed34e9b669e64be4e1c85afdfd6e3.camel@gmail.com>
	 <CAEf4BzawRYXXSJDiK4GzuYo=g-N_-QMgUXQAGN15eaPYuWXBWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 14:38 -0700, Andrii Nakryiko wrote:

[...]

> > > > Fun fact: if you do a minimal Fedora install (dnf group install cor=
e)
> > > >           "which" is not installed by default o.O
> > > >           (not suggesting any changes).
> > >=20
> > > I switched to `command -v bpftool` for now, is there any gotcha with
> > > that one as well?
> >=20
> > Should be fine, I guess:
> >=20
> >   $ rpm -qf /usr/sbin/command
> >   bash-5.2.37-1.fc42.x86_64
>=20
> command is actually a shell built-in ([0]). At least for Bourne shells, I=
 think.
>=20
>   [0] https://pubs.opengroup.org/onlinepubs/009695399/utilities/command.h=
tml
>

Yes, but looks like it's a separate binary, not a command:

  $ strace command -v ls 2>&1 | grep command
  execve("/usr/bin/command", ["command", "-v", "ls"], 0x7ffffeaef7b0 /* 65 =
vars */) =3D 0

(Not that it changes much).

[...]

