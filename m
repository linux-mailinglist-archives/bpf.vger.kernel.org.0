Return-Path: <bpf+bounces-27227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9FE8AB0D9
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 16:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3061C21057
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242F12E1D2;
	Fri, 19 Apr 2024 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LftBvZp/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B44F214;
	Fri, 19 Apr 2024 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713537461; cv=none; b=KD+QqGZYNoiZpgEjuabGf6Z0/uG+qhHpPLdL2sPX2slz3AwTS3ZOh3Akh/wuNwKS6VtmbUV9FIks+M3mk1qIEsQKqGfAxPDrxfkBPdokMAZJgsquv76fzWOcrmMlenrTsD3reD/bYTarOnZ7jG3nRCV2qSOAIlGQ5O62OJG4aiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713537461; c=relaxed/simple;
	bh=st86GX7iBP9tvzFZtXYPue1x9VRSo+Qw8zww2g7qvNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6+JTAwO1RCymsPzCa5onW1gmQrVIKw9/aWBN1dWZamTt+2Zv5ZirUa4hLX22lO3YotgrHd+NjIz3853jNVDkkALxhlcwDd3pB1Fh8VoNY8eV6eXqX7oW/y8ub7bAuVQThkW6J3jZG0xwto4EB++zhmMqAFed7t9ZdwlGudRNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LftBvZp/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-571b1434592so2222268a12.0;
        Fri, 19 Apr 2024 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713537458; x=1714142258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st86GX7iBP9tvzFZtXYPue1x9VRSo+Qw8zww2g7qvNA=;
        b=LftBvZp/TacLbn5vBUIbWlBuT1XT0h+ifxQ4ngAqsaWGzc1t3HM4eEIuirJtRbdKb4
         JaUmDajtDEsZIhgwO82u5XS1Ba6gU7HM8kU/eOqvEdJ7pJJ/WOxbO//3iF4PvXHiP97z
         jZwK3nryCG5VnPD6PpUQSRamtU/5xzM1wh8/UbtvLw+qgBgklODX0J+FvoFCgSB8WQxQ
         HVwVl2byuGx6HN29hg9NzkDWAmBifVjoayyE1yiPjJ+8AlFN+bwKKEg+38Z67gq+UVbP
         laktLnAKm5Uue5TKty9eYq67RFga/Gi3jZvIf8/vNzxD1x0rV3H5IoA3AJTyeQe8R4HP
         COkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713537458; x=1714142258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st86GX7iBP9tvzFZtXYPue1x9VRSo+Qw8zww2g7qvNA=;
        b=xIhsjR/I4RAt3It4spVRkT3Qf6MdWULhxH5MFq9WcTci+nxM4yxyoB99NSxMljiwnL
         W/QWldSBS4WzS32QLWDv2WPv6RVF2XaEvsi37U2waMOnZL+N9p2pYgAI5mv2ogKJDeRl
         CJjERbx+QYYfOSApYGBOimXmUz9sJyi1IeoTCmWaDcA0j7oGaqMFj5hXfKdBV9dknCpJ
         M3rqGn0lf4gHh9BMQrXxgSrLEoYNM++I+DmykPcgZTOpcAEt+bwmHoOZL/eLzq5HeZAP
         yzNY3Gce4oNCIdt0k6BCG0ZPn7YzHvr5tgmGR8rpF0y40HhoEtOzGd9PBiN3Ob6yfqmf
         faQw==
X-Forwarded-Encrypted: i=1; AJvYcCWLVNlunAWjuaknZm8/q9lYuwjLkRLFeaexXIUtJng0Z6+PnYwiPdwGDvHyG/o7lOAbOZKejXkzubM8P/R6nrL49AWU9/gLBqs/69rlLPtigRvlyYyCuEtF9Co6
X-Gm-Message-State: AOJu0YzV8y4EQUhPy/T2nyE56QuDfGd86KR+5cpMKH3gmzYAgN7Vdpwo
	qhdXDWuZx0OM6IV+G5gMmp67zvP4pPyKW+YQYUJMWx+SdsIBdhyjqnEU6hccLCkBa9F8GxCcKDT
	5eqnOnFAtdtcZNsrX0ATGkum3MTE=
X-Google-Smtp-Source: AGHT+IFoZjgEdGS7MWEggnj+KGADbvTg+Nteh1tALhx8I3Ag8Xlx9K+Ax/q/G/qSxHQP1AJbjIO+PP/nahYSD/USxU8=
X-Received: by 2002:a17:906:3b8e:b0:a52:6b5f:fc67 with SMTP id
 u14-20020a1709063b8e00b00a526b5ffc67mr1539763ejf.61.1713537458015; Fri, 19
 Apr 2024 07:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410140141.495384-1-jhs@mojatatu.com> <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <CAADnVQ+-FBTQE+Mx09PHKStb5X=d1zPt_Q8QYUioUpyKC4TA7A@mail.gmail.com> <CAM0EoMknntbtdZY32yjA8pUHMONfZyO8gbxkm31eSKj19NBRhQ@mail.gmail.com>
In-Reply-To: <CAM0EoMknntbtdZY32yjA8pUHMONfZyO8gbxkm31eSKj19NBRhQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 19 Apr 2024 07:37:26 -0700
Message-ID: <CAADnVQKapK1iUrX+vED4pq4LGa8sM6V0FgYotvHOuuc+0D+K4A@mail.gmail.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	khalidm@nvidia.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	victor@mojatatu.com, Pedro Tammela <pctammela@mojatatu.com>, Vipin.Jain@amd.com, 
	dan.daly@intel.com, andy.fingerhut@gmail.com, chris.sommers@keysight.com, 
	mattyk@nvidia.com, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 7:34=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Fri, Apr 19, 2024 at 10:23=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Apr 19, 2024 at 5:08=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > My view is this series should still be applied with the nacks since i=
t
> > > sits entirely on its own silo within networking/TC (and has nothing t=
o
> > > do with ebpf).
> >
> > My Nack applies to the whole set. The kernel doesn't need this anti-fea=
ture
> > for many reasons already explained.
>
> Can you be more explicit? What else would you add to the list i posted ab=
ove?

Since you're refusing to work with us your only option
is to mention my Nack in the cover letter and send it
as a PR to Linus during the merge window.

