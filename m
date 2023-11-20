Return-Path: <bpf+bounces-15397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142C07F1DD3
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 21:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FEB71C212CF
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 20:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E837177;
	Mon, 20 Nov 2023 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dYMJBLkC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D92BE
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 12:12:19 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7b3d33663so53500937b3.3
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 12:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700511138; x=1701115938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14nwulPEeUr0EpWytQxDZg4XoQQ8mZYNfFjDYt7nYIE=;
        b=dYMJBLkCvkeZnduUNN9KzF/8QjZjY9Rf0NRFv/nRSAr72qA5tVl5oXzSQbypJ+0JJX
         JIHGIb0Jf0Z/cIJaG7hA0PeUqcVruzm1rR8P26FNMWyyvIj8aeOj8dY7ZBPn+6WDXGLX
         bzCImC1sYzTs80soWgF/+ESJHHcXgszemzIlx9yUHhY6M33wgYFIm8lyWCSUqZA1ROsy
         x7E+N6ScyDE+7y43FQoPM7FulQL2elo1P8Hp4bm9+63iH3cbBQg0tGNDBqryLh9Yw6lu
         VXicp6kdzNk4MISDlrYsNlGXiKEEmiI8ZkgHyrgLFAKSvml7LfA4QaTSA8DKWa5IGm/c
         iIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700511138; x=1701115938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14nwulPEeUr0EpWytQxDZg4XoQQ8mZYNfFjDYt7nYIE=;
        b=W14PI83w6w7ibvFWtvC9x2xGQQ/MdN5UlaXRKcqzUahdXoP2LeP2qMXxT9GOcEwsMN
         LlGlxIoIHI4rcepR2eQjPqsbU+yrGPj3sVA3WPQO2HOuTHqFt3NnKkm7LTYqG/hmU2dI
         pcsLWND5Nngt1teJI4573Fgd8eesuelIz+2GKsdo3Zd3ia09PEkT4N4uL3wHZD3GJodr
         85uXxzdf79HXJJ/54nqWJmHlTiqYtmfEhxRsarOLpRZ55vWz6GA14HsYH+TRpURBEhOx
         b9N2/eAkOv7vyAStU7mDuib3c3XK0JRwQ8rfZlP33/ext0Qf4SQfnwRg0WM5r3ngx4ch
         eRbQ==
X-Gm-Message-State: AOJu0YwVKu82MZ/U2MJZjjgyn/98fp27kEF33kICbQ6DHXFawj1b2Dko
	ABrY0qhE5ZldHn0Iox1tvpvF941DIb+tkUrE76dpIQ==
X-Google-Smtp-Source: AGHT+IFJBVUwAPayK6m4ZeiyR3shdv888RLWySawUD7HjkgqZBfQjzlpvQoP231k5N/KslSpJRPYieN6RjgGDC5G8Sg=
X-Received: by 2002:a0d:c402:0:b0:5c8:cc4d:2aca with SMTP id
 g2-20020a0dc402000000b005c8cc4d2acamr9739511ywd.31.1700511138551; Mon, 20 Nov
 2023 12:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116145948.203001-1-jhs@mojatatu.com> <20231116145948.203001-10-jhs@mojatatu.com>
 <ZVY/GBIC4ckerGSc@nanopsycho> <CAM0EoMkdOnvzK3J1caSeKzVj+h-XrkLPfsfwRCS_udHem-C29g@mail.gmail.com>
 <bdbaa38c-5dd1-4060-b787-014daa2a0abe@kernel.org>
In-Reply-To: <bdbaa38c-5dd1-4060-b787-014daa2a0abe@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 20 Nov 2023 15:12:07 -0500
Message-ID: <CAM0EoM=VrMBYWmD5nZD+B-2M2i_QfeQ1uR4cH94Skn1DweSh2g@mail.gmail.com>
Subject: Re: [PATCH net-next v8 09/15] p4tc: add template pipeline create,
 get, update, delete
To: David Ahern <dsahern@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, deb.chatterjee@intel.com, 
	anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io, 
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com, 
	toke@redhat.com, mattyk@nvidia.com, David Ahern <dsahern@gmail.com>, 
	Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 1:20=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 11/17/23 4:09 AM, Jamal Hadi Salim wrote:
> >>> diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
> >>> index ba32dba66..4d33f44c1 100644
> >>> --- a/include/uapi/linux/p4tc.h
> >>> +++ b/include/uapi/linux/p4tc.h
> >>> @@ -2,8 +2,71 @@
> >>> #ifndef __LINUX_P4TC_H
> >>> #define __LINUX_P4TC_H
> >>>
> >>> +#include <linux/types.h>
> >>> +#include <linux/pkt_sched.h>
> >>> +
> >>> +/* pipeline header */
> >>> +struct p4tcmsg {
> >>> +      __u32 pipeid;
> >>> +      __u32 obj;
> >>> +};
> >>
> >> I don't follow. Is there any sane reason to use header instead of norm=
al
> >> netlink attribute? Moveover, you extend the existing RT netlink with
> >> a huge amout of p4 things. Isn't this the good time to finally introdu=
ce
> >> generic netlink TC family with proper yaml spec with all the benefits =
it
> >> brings and implement p4 tc uapi there? Please?
> >>
>
> There is precedence (new netdev APIs) to move new infra to genl, but it
> is not clear to me if extending existing functionality should fall into
> that required conversion.
>

Big question is:  how does the genl (which i am assuming you mean the
ynl stuff) fit back into iproute2?
The yaml files approach is a great deal of help for maintenance IMO (a
lot of repetitive code gone). But do we leave the rest of the masses
out? What is the motivation for pushing anything to be shared? And if
the answer is to convert everything onwards into genl then where is
the central location to grab that code from? Is it still iproute2 or
the kernel? etc

cheers,
jamal

> >
> > Several reasons:
> > a) We are similar to current tc messaging with the subheader being
> > there for multiplexing.
> > b) Where does this leave iproute2? +Cc David and Stephen. Do other
> > generic netlink conversions get contributed back to iproute2?
> > c) note: Our API is CRUD-ish instead of RPC(per generic netlink)
> > based. i.e you have:
> >  COMMAND <PATH/TO/OBJECT> [optional data]  so we can support arbitrary
> > P4 programs from the control plane.
> > d) we have spent many hours optimizing the control to the kernel so i
> > am not sure what it would buy us to switch to generic netlink..
> >
>

