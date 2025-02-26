Return-Path: <bpf+bounces-52616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F06A454F0
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 06:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57F63A70C0
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 05:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEDF25E452;
	Wed, 26 Feb 2025 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP6L4w+7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A21531E8;
	Wed, 26 Feb 2025 05:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548569; cv=none; b=KWwK8IvudGdVIPfNJp/OJ9psZG1FXWEnk0DZhozznmnF3WogZx2kOcccCS5QPqthxFGvPuikKc5MF1qpw3YVh06TXh4Nm8UEfmkhHiSW8I5q4Xu3VHy6tnqb74CYS5m9ZJiQAX4MqRFgwrSn/LrZ0gxR+Da31X9ld998f/yGXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548569; c=relaxed/simple;
	bh=qgwn/5gHrE2jyzZRW6bmAicNqyZrpWmfrBL9qb4fBeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taiPAkktbKyQAS9Gj9aJqvuVusSpK6j79fVdKMhJnZqXYuZmkVhpPcWsLaskD5NduwvG7QamxQUFfJv1JBRPdmCoUcUJFOHWTlm763+FEt3h57i3C2nnnqdtThb4ce3FKbnoH87GKZHosJG8ZRJ42846dXgiJBq48utZJYS5h9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP6L4w+7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f2b7ce2f3so4550739f8f.0;
        Tue, 25 Feb 2025 21:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740548566; x=1741153366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgwn/5gHrE2jyzZRW6bmAicNqyZrpWmfrBL9qb4fBeA=;
        b=CP6L4w+7s2o76Aps7WND6FiHfRFlVE7tyGt/IsDq0aYeVBR46ei4LdTcHai/HAt+LJ
         GSsTqA1JUhVaaQGjxW5Knsm1lUdJRxQz5IrlwU/LyD4JAj1KZDMBv+1o9zY4hpRDwqU/
         sSmbXM1zEMG1Jni2nrQWuKpFDpYXpeQgSVOdRcOGz81cZhmhFbmtnQcwTjYrNA6oyVy3
         odui4/MJ5kg4IdgxnuvJK6yFkdt+HbhPuwscBHqCpNdAfj6Uv+i8Osx5YLTSgeYBcqFb
         WzmvJIrlCgF1ZwVncxHk490wtjH5HJS4It5w8H/MM3Yj/IRkFIkw0/L/tLDM9g6iPdTM
         NQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740548566; x=1741153366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgwn/5gHrE2jyzZRW6bmAicNqyZrpWmfrBL9qb4fBeA=;
        b=ge3BAAcgzjnkbGqV1EVDpZ1rXpmZ/UlcKEwuSuIdM+fCiNS0qEHsto3fqd6rMJP/F4
         /DMGcuw9jQX67/nLu8s4Vze8d2hwgKMqgU7qfv4EzEDyoPnTvGpVtv3PuFcSKtLHcbzv
         Y4/s8O0UuqXFHB6aRwM9ZRtTodNvKG4U7urnjj8fhjQhNyCt8fcNqr1vIKD3S2MhuO7g
         hFCGQdkkG3tCBhi32r2SDLRLyixk4sB0TToz+pUw9JzHrkNMDPGweO957+t/Nx2jVgXF
         IdnFpx8FEwWfDhiNHu0B5Bzar+89VR/pgZnkppQrjhuYcr3ZwaDQtsu/NSuKGrSbQKWD
         KzJg==
X-Forwarded-Encrypted: i=1; AJvYcCUwL3g5JsQV948QDjYb+YASGbScGDW54DJ7J2EVZJbymoZpriknzhqDXP9FGrKiqmpIKmQ=@vger.kernel.org, AJvYcCW+NzZlODhjojqHIlCmgtVWPM/33C32dXDWMRbSzwX0H6P3gIp8e01gJSmBkdE1p8Cfp2ID8aL1GeFbGKdr@vger.kernel.org, AJvYcCXvIb272EGir/Zt8ufnjvRZ3Xq38DZHmfcsaDlZhROV/YT+obzGU2y7aSosiXj51NGYePnO@vger.kernel.org
X-Gm-Message-State: AOJu0YwbB0m0l6JoL2YPGhQX7BQRWdw87Ip7QLspCec1N4tEuDNPyebD
	JBTv1XKiYsqcWWkyGqockGJ/SNRefgpl9VqieZKXDkEivJohz0fw+bAOXd7Y5471+ScBPE5gmxF
	8faLKaIAwHHl+RGs4VaowtAnBS5M=
X-Gm-Gg: ASbGncuCMIJZB/+QEguG9tq30tiC4HdvDWlu9bXBRvWVZIimNgD+QyuYp9F8tIFNfK7
	9V4GRlRK5ye353HDvBx16+XVxJ5lLeCRp2JG3h6YVRIxEnby5TUTcVnNsXqRvjxAN0gQ8+knr7U
	QFfE6kUuSRPW8eFgeXjupxKBg=
X-Google-Smtp-Source: AGHT+IGJ7kKSE9Klc2Pk10yZQs5vQ/oeFEoz2dII3HbyhmfLav6YXGB6DB5PetIU24Eu8QrsIzvJESpzNLNcomiDBdY=
X-Received: by 2002:a5d:5f94:0:b0:38e:6cd0:f973 with SMTP id
 ffacd0b85a97d-38f7079a39emr16785278f8f.21.1740548565859; Tue, 25 Feb 2025
 21:42:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204082848.13471-1-hotforest@gmail.com> <20250204082848.13471-3-hotforest@gmail.com>
 <cca6daf2-48f4-57b9-59a9-75578bb755b9@huaweicloud.com> <8734gr3yht.fsf@toke.dk>
 <d191084a-4ab4-8269-640f-1ecf269418a6@huaweicloud.com> <CAADnVQKD94q-G4N=w9PJU+k6gPhM8GmUYcyfj=33B_mKX6Qbjw@mail.gmail.com>
 <6a84a878-0728-0a19-73d2-b5871e10e120@huaweicloud.com>
In-Reply-To: <6a84a878-0728-0a19-73d2-b5871e10e120@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 21:42:34 -0800
X-Gm-Features: AQ5f1JrKFHxryEEBl1o8lc_G6EKvZ6s53yPq_lKQmFG77O2pmmULv0mgtif1f4U
Message-ID: <CAADnVQLrJBOSXP41iO+-FtH+XC9AmuOne7xHzvgXop3DUC5KjQ@mail.gmail.com>
Subject: Re: [RESEND] [PATCH bpf-next 2/3] bpf: Overwrite the element in hash
 map atomically
To: Hou Tao <houtao@huaweicloud.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	bpf <bpf@vger.kernel.org>, rcu@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, Cody Haas <chaas@riotgames.com>, 
	Hou Tao <hotforest@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:05=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/26/2025 11:24 AM, Alexei Starovoitov wrote:
> > On Sat, Feb 8, 2025 at 2:17=E2=80=AFAM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> Hi Toke,
> >>
> >> On 2/6/2025 11:05 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>> Hou Tao <houtao@huaweicloud.com> writes:
> >>>
> >>>> +cc Cody Haas
> >>>>
> >>>> Sorry for the resend. I sent the reply in the HTML format.
> >>>>
> >>>> On 2/4/2025 4:28 PM, Hou Tao wrote:
> >>>>> Currently, the update of existing element in hash map involves two
> >>>>> steps:
> >>>>> 1) insert the new element at the head of the hash list
> >>>>> 2) remove the old element
> >>>>>
> >>>>> It is possible that the concurrent lookup operation may fail to fin=
d
> >>>>> either the old element or the new element if the lookup operation s=
tarts
> >>>>> before the addition and continues after the removal.
> >>>>>
> >>>>> Therefore, replacing the two-step update with an atomic update. Aft=
er
> >>>>> the change, the update will be atomic in the perspective of the loo=
kup
> >>>>> operation: it will either find the old element or the new element.
> > I'm missing the point.
> > This "atomic" replacement doesn't really solve anything.
> > lookup will see one element.
> > That element could be deleted by another thread.
> > bucket lock and either two step update or single step
> > don't change anything from the pov of bpf prog doing lookup.
>
> The point is that overwriting an existed element may lead to concurrent
> lookups return ENOENT as demonstrated by the added selftest and the
> patch tried to "fix" that. However, it seems using
> hlist_nulls_replace_rcu() for the overwriting update is still not
> enough. Because when the lookup procedure found the old element, the old
> element may be reusing, the comparison of the map key may fail, and the
> lookup procedure may still return ENOENT.

you mean l_old =3D=3D l_new ? I don't think it's possible
within htab_map_update_elem(),
but htab_map_delete_elem() doing hlist_nulls_del_rcu()
then free_htab_elem, htab_map_update_elem, alloc, hlist_nulls_add_head_rcu
and just deleted elem is reused to be inserted
into another bucket.

I'm not sure whether this new hlist_nulls_replace_rcu()
primitive works with nulls logic.

So back to the problem statement..
Are you saying that adding new to a head while lookup is in the middle
is causing it to miss an element that
is supposed to be updated assuming atomicity of the update?
While now update_elem() is more like a sequence of delete + insert?

Hmm.

> I see. In v2 I will fallback to the original idea: adding a standalone
> update procedure for htab of maps in which it will atomically overwrite
> the map_ptr just like array of maps does.

hold on. is this only for hash-of-maps ?
How that non-atomic update manifested in real production?

