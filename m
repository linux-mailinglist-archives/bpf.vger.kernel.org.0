Return-Path: <bpf+bounces-51586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32AEA365EB
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 19:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8926116E6BB
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 18:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941F19884C;
	Fri, 14 Feb 2025 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNugsUvn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF7134AB;
	Fri, 14 Feb 2025 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739559062; cv=none; b=GS+RakhtWdH2lCGSON1jKrkFzsShudmn/ri68WwCWK0E9eyL6BJtbFBld0yYhROp9ilTjynVdpRaW0ndR9mbpS0R/ukzCIOOLZnCGu7uYtLQPN1gltH/MLld4qixDzTlMN6E5W0e6yBQfqZ8I+WoKO/ZE7NUiklEBnMCSE6o+jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739559062; c=relaxed/simple;
	bh=imjK+sW9lbJW0abrVkVoJS0rNMSQ5qqR2fIPKE8znU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKHGSG/ldpUMyPQrn3T2yL2Ce1GbgXKftbIt5vUBeO0dqbd0Pc9ZFMuJL35zlORJsR3/QEKl0KxMDnrsZbzAymYC/DWs4RH86d6qSWleagMKocK3qS7ZdAu+XBZmsIqkAU8RFQOyMeS6TqeMwt9dGxKS4CWjaWkFSREnX1saepY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNugsUvn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43948021a45so24875095e9.1;
        Fri, 14 Feb 2025 10:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739559059; x=1740163859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gLxmAOoDwK8eIyaaX97eA2Elu0tmIqXkknpZV8ZHNc=;
        b=YNugsUvnRjBb8FuyFG2DLt7tUDDKZT+MOyLZ9RBQBZncDkizZ0c0/1HDco2zvyDCc/
         NBY9cyig37cyroZ/wy3jE80LrwlrCRfxOSGYjN8JLZBmxmZrjS/tZKGL+M0BbtV9NUTz
         uPb8I5YsK+iPRs+9mVCMFZHDuBpWW0xKIl9nar4VsE+NRI8h1ayZaEMqUhoRA+kt0plz
         IPtIvYn4Vr87hpu5L8VrsryCfOuUJpHn1ORMHlr2iKRFEGVVbGH0EuhI4obEzs8lSfop
         13vG2EKIic1yW+gnp/M1cVk/Q08MmHP5PkZtAmn42OPf1xfxGjTA47dRe6IB4pQrTM+z
         Ba4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739559059; x=1740163859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gLxmAOoDwK8eIyaaX97eA2Elu0tmIqXkknpZV8ZHNc=;
        b=HWbYz/WuIXIS0wzIk22PJSOlsvNHOl91X7Lbh/tJikInHeXY8WZ14TaMfbAbfYbeGh
         hTY06BSYTx+aPiRrjTPRHV2h1sbsonKwDRSCUkHeaXy19r1AV+Qk7LXAhhoT91jSuukh
         qC4ZCp9+MJYekK2WUcuA1bP2u4v2VqaGpKFBD/ajHIBT6KTVef+n2lHb5ccvGwg6BW58
         Ti5/n2SNcIfeAUk2m8BXA3HhFYiVI0tsS2mfhRwEI++dNhmfwflWHyt69wcoZEAkidAf
         hlv2kgopgUDsAJOH39i3/1kK68MJVDyKefJkmpz/46dMl726IJrlMRFoa7CP9l3+3KHn
         ndiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3k/ehajkgOUezFDX8T7jkOwIk2jWdf591zr4iCLcxbG9ZASbEgqB5eNDh5nzXTXp2vBk=@vger.kernel.org, AJvYcCVnR3PUm7L6gG0ulGxV3VHPmuhMzgjmsJ2oB6H2LvwJsmRWYrBusOFLWNS4OKas+b6frAffg0MNCK/kK3c+@vger.kernel.org, AJvYcCX7ni2TcX6qQSY2w8UyMeYhh5fPHg4vMlagS74pLPkWSjZInRBwgubmyR7xQcRRFzs6FOiPnlcsuoWRAg==@vger.kernel.org, AJvYcCXW5TrSJwAV6r22hHmHAwro98cgSqqoaNVy7SU8hxHsjrvAaT1KseRn25rvZY/kxMNtUhy83/nu@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5Tsiv0nTQ+GKR8Ggdq5+R4p1ThJNa0ktI6Df/jVN91y8wR+6
	Ly/IkOPC126wT14i6keIF9PS4UICc3ZOHWZ0jIGTgZzq+skC6LV6hKY+G+tMTK/2H9mIg/wV6up
	5FKFJKwMoZRHADDnb+QHDf5Y4Nr6GIA==
X-Gm-Gg: ASbGncstkJnjWxYIdxjmePK/7w1uExfN9OR28i8uL83isAivrq8d/80T2lOv5QKAV+/
	MReR4zilGTrw3oM1b2fhUaF+T2OCvBdmU0MW2+s/5TNYlBNw1tzc6YNeteKrrVRlucnQ/uu6Ufq
	NbXHcupqs/31TJPp3IowejfBue+MEe
X-Google-Smtp-Source: AGHT+IFjeACm//H4hKOUVUr2c3fgs6P3DDeltfRXcoY4eBnzkkETCTJbBuhWr0Eg9PNNH/1wD8H/s70wz30Ov8gYtn8=
X-Received: by 2002:a05:6000:18a9:b0:38d:deb4:4ee8 with SMTP id
 ffacd0b85a97d-38f33f2f8d3mr142183f8f.28.1739559059218; Fri, 14 Feb 2025
 10:50:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214160714.4cd44261@canb.auug.org.au> <CAADnVQJhh+An8uorGh-WQfJybqAu84MOREXZtCxep7fZtyMd6A@mail.gmail.com>
 <Z68JEhkMs9rjgVHP@krava>
In-Reply-To: <Z68JEhkMs9rjgVHP@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Feb 2025 10:50:48 -0800
X-Gm-Features: AWEUYZkkBPv3tFPaDJYGOAE8-3d1axKqUPvGv8qt6VZzq4UQndwKtmR5P6nkeHc
Message-ID: <CAADnVQKOURuBdcYgCUDW5=WZsNHBzt4w=s3JCP=4ax1U_AWwFw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:12=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Feb 13, 2025 at 09:33:11PM -0800, Alexei Starovoitov wrote:
> > On Thu, Feb 13, 2025 at 9:07=E2=80=AFPM Stephen Rothwell <sfr@canb.auug=
.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > Today's linux-next merge of the bpf-next tree got a conflict in:
> > >
> > >   kernel/bpf/btf.c
> > >
> > > between commit:
> > >
> > >   5da7e15fb5a1 ("net: Add rx_skb of kfree_skb to raw_tp_null_args[]."=
)
> > >
> > > from the bpf tree and commit:
> > >
> > >   c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
> > >
> > > from the bpf-next tree.
> > >
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your t=
ree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particula=
rly
> > > complex conflicts.
> >
> > Thanks for headsup.
> >
> > Jiri,
> > what should we do ?
> > I feel that moving c83e2d970bae into bpf tree would be the best ?
>
> right, bpf tree would have been better fit for that.. should I resend tha=
t for bpf tree?

After sleeping on it I guess it's fine as-is.
When bpf tree gets pulled we will merge Linus's tree and resolve that
conflict way before the merge window.

