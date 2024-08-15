Return-Path: <bpf+bounces-37312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD77953CEE
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54541F2240C
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4988C153BED;
	Thu, 15 Aug 2024 21:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af68g1he"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E44014B09E
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758637; cv=none; b=aYrvIC4BQjAFCM3f1bwx+RaiUQbS3iUZhI9yz2FSxSEXTIsAGMTKbwHfHKkI+vsQoOnA57Ufc3e+tAfsNbjjkj3eBXC9mIl5/9w7+hX9KlHUsSQT5qaXPQTekPyIO/JxHVe/5SUWJ8qCp0d+wmNx644FCtbmwenAwtIYE7NC5gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758637; c=relaxed/simple;
	bh=77EgKjLwQsLZFXiWnfNQazCpTz3oOab5QwUk5ZSjRlw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kvc94WN0dfA7Q/62V22CN3MHZ3QmCqKEcHX+n2kg37FIDfFXd0G+ghGzq18E1OB8OfifGa9/8VSnsFc18MRrpram2B8Edgno0bydBoCDD+4oMehKrg8mTKOAr+zwFHawRqMb2876abu0hF6n78cXvUCqFXK1uB243zFXvrsVF6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af68g1he; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc65329979so13854545ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758636; x=1724363436; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZBnzcQqpg1Qz33jlXknGEGmZ9ewqHnCt8rTup4qviMw=;
        b=af68g1hexeOENu6WXYRPfHq3o/nkry0YxPTcPRBoIb00Ta+puhQHlHsCBQiQH/+16g
         bzjdzHid/N6z0QXjLI6DFzpfgeD0LGPMHgL3c0a4txZqziI2IactKprY7Se0udPb6YMT
         YyEZzMNhbboxVBIcVgUjfiHnZ2nf4f4kSyxVyQizSSRBeQf/bpJo8wh1ggCT8Qn4/JKl
         CDn/Tpf7i8rlTwz9NgOJtZdlvOz5zZFnI0txz9EOtwaZj6YAO4D8Ih1cSRO2VjBtJdr9
         SFdR8SfeVbEEYe325G6K3ooU7TcQjK9D66SU4sEYwTgGGdZH4v9X1lGRfKdUn9Ar00TL
         k16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758636; x=1724363436;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBnzcQqpg1Qz33jlXknGEGmZ9ewqHnCt8rTup4qviMw=;
        b=X0nbb5RgLXV3kQgj6jD2CMkUzKjGocuUDYWgPhCTGUGJT8J7IqB4P8yB2y1OYtLM9E
         jwtcyoStPpl9XJksuXeXVZP7+B4W5zT4zRV1MyjCQFYSEGT3nh4Rzl1tnomvxzXvknYS
         drJPP7HqfvvJ5Ph4F8TCOzJgPfBJOyFVe5G/FeYhFOx7UsE3B1NntCeuB2wm4kzPZKfT
         tPJXpS8zR/sfyW6YQlgRSAxeeogykZwfPDMLbj+vaKx8rMbbtLlDfBffIB0pbWwm7kSy
         fSYV1BRafwTZ/t06pTZzO4lKQgxlgtwf6H+urr5E+sOH9e+HAMan559jJ8At7RYk2LTK
         P3DQ==
X-Gm-Message-State: AOJu0YwkGNGX/IM/zd3oBcZeCQmWWTtZOXGJvDpFOsQ+tnN4ptJfyj/v
	Yk/Kw4QlVGlgRCCEnHsblb7NxBYVUMNwzSAVb7cVPM74LuMx2zbj
X-Google-Smtp-Source: AGHT+IFlk1KM5ETgPL92aTpAinfk15XydC4Wefdae/kBlKnlLo0Ft4K3u2A+qcZoQbJNuUt2u3NwJA==
X-Received: by 2002:a17:90a:f001:b0:2ca:8b71:21f4 with SMTP id 98e67ed59e1d1-2d3dfc61aa6mr1205809a91.18.1723758635893;
        Thu, 15 Aug 2024 14:50:35 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2330f26sm321200a91.0.2024.08.15.14.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:50:35 -0700 (PDT)
Message-ID: <875815624e852e09f926696175ffd6eb6fe1cbf3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] selftests/bpf: utility function to get
 program disassembly after jit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  hffilwlqm@gmail.com
Date: Thu, 15 Aug 2024 14:50:30 -0700
In-Reply-To: <CAEf4Bzatz89TPfCtK5i2UmCsc7D8Dx=udjQqe52-WzRH+DDC1A@mail.gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
	 <20240809010518.1137758-3-eddyz87@gmail.com>
	 <CAEf4Bzatz89TPfCtK5i2UmCsc7D8Dx=udjQqe52-WzRH+DDC1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 14:06 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -627,6 +669,9 @@ ifneq ($2:$(OUTPUT),:$(shell pwd))
> >         $(Q)rsync -aq $$^ $(TRUNNER_OUTPUT)/
> >  endif
> >=20
> > +$(OUTPUT)/$(TRUNNER_BINARY): LDLIBS +=3D $$($(TRUNNER_BASE_NAME)-LDLIB=
S)
> > +$(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS +=3D $$($(TRUNNER_BASE_NAME)-LDFL=
AGS)
>=20
> is there any reason why you need to have this blah-LDFLAGS convention
> and then applying that with extra pass, instead of just writing
>=20
> $(OUTPUT)/$(TRUNNER_BINARY): LDFLAGS +=3D $(LLVM_LDFLAGS)
>=20
> I'm not sure I understand the need for extra logical hops to do this

No real reason, that's how it is organized in bpftool makefile,
monkey see, monkey do. Will combine to have single LDFLAGS change.

[...]


