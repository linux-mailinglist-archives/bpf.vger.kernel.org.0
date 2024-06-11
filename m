Return-Path: <bpf+bounces-31876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4185D904447
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 21:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27A1B20A81
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18877F7E3;
	Tue, 11 Jun 2024 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RjCrbj82"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2338FA1
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 19:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718133234; cv=none; b=uAeIqLt7RkxXinWV1jCE3l1dwPzMk7QkDyR2xBVYM2EQRDKuIhqj3s56G/huJj4zNxsaK1Oda/V3uopya3dJtIsGBbp52T1f/bOJQq6lU3ZgKdQfEKQaPNWqiLYiNgcIOOzMFrs+oC3OtmhskToUKqrrf2Dk6NgYzxVL30zzvMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718133234; c=relaxed/simple;
	bh=wAIyEg2Pvor2USCqACYPAnI2Pivre+g+Lw9GIN+SQZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAT4cygth3ix58/7Iz55SxfBZNlyV048tmHpXndM0QP5XX4TVjCjpTI55+2Q7KCr7CwDKE0AXwu6a8xrrjTWHy2epoTH7vkekPgqLrRkjjYowZ30w+5bFUJAoYDm/PgplQ7uIZCnvnIBRHZ0AQ/97bi7nvRH2kDv/Sg0bIciOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=RjCrbj82; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a08b250a2so56790157b3.3
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1718133231; x=1718738031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2msBxhPXXnBr1VfIw0JVRu445u6imiF8iI5GrfbCCDE=;
        b=RjCrbj82bUE18/gjbjgjDiU2ooIVPG/ZeiYwsvapiNIctyGqVFVZmIox6RKW0BX2cL
         eNMjFNfxMQ2gC8jd3c5Xf+F+/pySKJMMQN5MdCNUPil5MjHwYAlWlZOWdvFagkGDgqP0
         oiWfOLzKCQHI6bPSnUoYeUUakAfVx0MDdym79uQFSdhL73oY2MnWheP9CaV14JROmZQr
         f96YpbRcZEb+czGKAbHbhAApTq5BydZ31k+VhNT/flc3G4uprzAkJCu8Wy3BgYBVshLL
         qKNfmBl4ldJ/gQtgPt5F+DApxwOisy6+TUBbCK9l0KthWbqs5JJiYTwwcbePvtPpltA4
         cMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718133231; x=1718738031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2msBxhPXXnBr1VfIw0JVRu445u6imiF8iI5GrfbCCDE=;
        b=wnWjiMTOLR+5q1twU8pdk6mawAtTNV4zgddtcuxpagCxkGbLExIkIN0rDedAuplRk/
         8pK2nSMrOw9Qiiv9rJFP+qHARTMefCIh/JtN1kFPjNIX3SH3dI/UQ/bcvsI6A5PhC2Pp
         LYF7QASVmVOmGcWXb0Zb7aUvu4keejIcGT+TcMGqglywEOZmjqaKZprkACMojx8uEHwP
         TDdqkrsrkxyzkbWR4Xl6Xv0Ux7YyszNsQpmmaFQWL+PCGD7lMed4F4V1tTwOtszrjFJs
         Bteds3flm/WpmP14RHH18N7AHMaK0kuHELHZycFSibSv7VSO++4IQO0gOoH/uHqnkXs/
         HC1A==
X-Forwarded-Encrypted: i=1; AJvYcCV/vse2xeyVzSlZa15lk5NZGa7MKcimJFQwpIyGdkgwEBdpTlRFFMiO6CV6DXP260plxMN1LUEHLrosSrrHZ4lXK1/d
X-Gm-Message-State: AOJu0YxEaaO/4KEOJ7CMQrpzNVjCvALazRpKA2xcKn8/x2odSTD1M+UF
	ClsFFf6DEpBrQvcoGADcWvjAkMc1eSpthFdnD/Q0fnmcyTmAXTXoqI16ajRmbc0n+YFQvKHHiN8
	Yv0jCkuOEUtnoAyLimSwmd7nx/wZvqJz7bTMR
X-Google-Smtp-Source: AGHT+IEumhb6kBnuB1pnAkTG8fXAX0G8rC35rzNND/HE779wkC8NsPqhWU3MUxqXwoCMVzY0M5HyfhLBtT5NjcmB7NQ=
X-Received: by 2002:a0d:e802:0:b0:62c:f90d:3797 with SMTP id
 00721157ae682-62cf90d3cb1mr77094597b3.37.1718133231595; Tue, 11 Jun 2024
 12:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <20240611072107.5a4d4594@kernel.org>
 <CAM0EoMkAQH+zNp3mJMfiszmcpwR3NHnEVr8SN_ysZhukc=vt8A@mail.gmail.com>
 <20240611083312.3f3522dd@kernel.org> <CAM0EoMkgxXX4sFJ98n_UTLLFjP3KHx00aaq76t4zJJsO9zNO4A@mail.gmail.com>
 <20240611105342.02805498@kernel.org>
In-Reply-To: <20240611105342.02805498@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 11 Jun 2024 15:13:39 -0400
Message-ID: <CAM0EoM=8gqdZXt02v0jmHTqnjru4Ocv6ddjzjBXhU6eFoN50ng@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com, 
	Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, victor@mojatatu.com, pctammela@mojatatu.com, 
	Vipin.Jain@amd.com, dan.daly@intel.com, andy.fingerhut@gmail.com, 
	chris.sommers@keysight.com, mattyk@nvidia.com, bpf@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Oz Shlomo <ozsh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 1:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 11 Jun 2024 11:53:28 -0400 Jamal Hadi Salim wrote:
> > > For me it's very much not "about P4". I don't care what DSL user pref=
ers
> > > and whether the device the offloads targets is built by a P4 vendor.
> >
> > I think it is an important detail though.
> > You wouldnt say PSP shouldnt start small by first taking care of TLS
> > or IPSec because it is not the target.
>
> I really don't see any parallel with PSP. And it _is_ small, 4kLoC.
>
> First you complain that community is "political" and doesn't give you
> technical feedback, and then when you get technical feedback you attack
> the work of the maintainer helping you.
>

You made a proposal saying it was a "start small" approach. I
responded saying that it doesnt really cover our requirements and
pointed to a sample h/w to show why. I only used PSP to illustrate why
"start small" doesnt work for what we are targeting. I was not in any
way attacking your work.

We are not trying to cover the whole world of offloads. It is a very
specific niche -P4- which uses the existing tc model because that's
how match-action tables are offloaded today. The actions and tables
are dynamically defined by the users P4 program whereas in flower they
are hardcoded in the kernel. I dont see any other way to achieve these
goals with flower or other existing approaches.  Flower for example
could be written as a single P4 program and the goal here is to
support a wider range of programs without making kernel changes.

cheers,
jamal

