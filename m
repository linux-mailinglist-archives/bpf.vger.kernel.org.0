Return-Path: <bpf+bounces-44090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E7B9BDAF8
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 02:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62FA283776
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 01:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1AA17BB03;
	Wed,  6 Nov 2024 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2OBBoCM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F83D3B8;
	Wed,  6 Nov 2024 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855483; cv=none; b=jVY8n11DJKFG4UWWdWQtDHHQOp2wgYgXdIyFaS+2BwRUb1EQqzWHD084htMHsZ5mMHt7qK01ksgqcEeWMXiTgysui4ad03i3gl/0RLKJOSJ2efC3D1rCuwgMA38iQCN/shSSbd/qgD8zXRWabBj2XHXbySg8862Db5SrQXKK3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855483; c=relaxed/simple;
	bh=uqC2bBgqxV5XhCKmfL+iLF+uiVjaHkwIHftIBJVmDyw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TvYWxai3PUqC6lClfsr2/VeuFuIEYqSM86I1rHPz4NReKLjxPumzUzB7k1Szbj+o/q7DqWU5ggmvvfZLS3x+hnjzEaZbrWVzSTVgL+Wh3CAkWGtAJ6JhuSNP6mEw+4Pk3OkIq6v42syC4mn5OAoEresZ/5IK05eNMw7lsmTQCDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2OBBoCM; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46089a6849bso40179461cf.3;
        Tue, 05 Nov 2024 17:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730855481; x=1731460281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqC2bBgqxV5XhCKmfL+iLF+uiVjaHkwIHftIBJVmDyw=;
        b=V2OBBoCM9YkT2eRf80HqOQ3i1kkCOA5OQJLGsjSeD0FGOkRYWxbkAWIAKQIK9ELtSu
         iyBOhfdXJ48kgzO4Utnf6FithiOUdvXsmGTeSfNqg6Iw1jBbNJzQt9Vb6/KaqTaA/C4/
         icRFqES2RioOckRKSvxVjmUe7QdijNSqwrsraOyRRNfVcO62saXvRMfoHOiaCWtFn85K
         nTJTcjD5IACylsGa0UPK5WWfLBamRSKBM73cep8fovg0nQZkiExq4IHmJgSBIRj9ojtw
         5u4GrMBvxQMGfcpZydvQ4fb4C+6eWjeQ8uXbdCLUJjmkgwnwvbrw/PBFknYz+3JXcchX
         7Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730855481; x=1731460281;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uqC2bBgqxV5XhCKmfL+iLF+uiVjaHkwIHftIBJVmDyw=;
        b=tgZnNOMCw6+axEPWBs90sysEhVRz8uHICGmLezaeO4uVCDMc2rHAUbTqqZQq0//lYx
         KOH7h6LJDqiyl4gCU9jC8a9Ir60tpW9ANKW44sVGLnukfW3mqsKWTwqIe8Thm1hGtM2B
         BLwzck4Znqh8Hka/jTMw4rhgk91nP/n9eGJqiNmYBak/Zgrawvr/xOHlEVSHQR01byse
         j1IPEAUhwOQa1ECOqEX/QAR72R/hLR2OlMYSpC/s95CojoLxYJG6Ea+i5mk9Hg2cM2tJ
         6+1zQ1zbSZRoFma35H2taSo0SHaCTM+tyM8By/MOYXASFGyYsOQQrV0WBpEz55UdPrYD
         povg==
X-Forwarded-Encrypted: i=1; AJvYcCVVXvhWMzQE6R+2Fy/irT9iMyytq9lg2R9adrI7SExuxyNyo+xlo9zCXV4wYs1kKNGGcyo=@vger.kernel.org, AJvYcCXDu2ccrY1M5QXWSft6oOZzmX5CUcA7i7RBMGXhhET//Ws3iZ5giaZ0aZQ8DDFzIHLr83KHwCIj@vger.kernel.org
X-Gm-Message-State: AOJu0YyuinzZ4gG4YIbYulgxcbyg8DXk/jf5ZK9USRrpKvF9UcYkcR5c
	l/XYthWf3blxM5nQJFc+jnti9H8P1LC/x/NewWYV+aWKTK9ppm3O
X-Google-Smtp-Source: AGHT+IGLEKp+Z0qeydk5XZG6T/8cgkkAHz55EUa45GbvNY1qoSHTihL8rhJQCRKuEadDLAvoDlLcfw==
X-Received: by 2002:ac8:5996:0:b0:461:2150:d59c with SMTP id d75a77b69052e-462ab22baffmr330653421cf.9.1730855480628;
        Tue, 05 Nov 2024 17:11:20 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad19ebd9sm65456591cf.84.2024.11.05.17.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 17:11:19 -0800 (PST)
Date: Tue, 05 Nov 2024 20:11:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 willemb@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <672ac23732699_cde4729460@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDEMJGYNw01QnEUZwtG5BMj3AyLwtp1m1_hJfY2bG=-dQ@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
 <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
 <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev>
 <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
 <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev>
 <CAL+tcoBf+kQ3_kc9x62KnHx9O+6c==_DN+6EheL82UKQ3xQN1A@mail.gmail.com>
 <f27ab4ce-02df-464e-90ed-852652fb7e3e@linux.dev>
 <CAL+tcoDEMJGYNw01QnEUZwtG5BMj3AyLwtp1m1_hJfY2bG=-dQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Wed, Nov 6, 2024 at 3:22=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >
> > On 11/4/24 10:22 PM, Jason Xing wrote:
> > > On Tue, Nov 5, 2024 at 10:09=E2=80=AFAM Martin KaFai Lau <martin.la=
u@linux.dev> wrote:
> > >>
> > >> On 11/1/24 6:32 AM, Willem de Bruijn wrote:
> > >>>> In udp/raw/..., I don't know how likely is the user space having=
 "cork->tx_flags
> > >>>> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflag=
s) &
> > >>>> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" se=
t.
> > >>> This is not something to rely on. OPT_ID was added relatively rec=
ently.
> > >>> Older applications, or any that just use the most straightforward=
 API,
> > >>> will not set this.
> > >>
> > >> Good point that the OPT_ID per cmsg is very new.
> > >>
> > >> The datagram support on SOF_TIMESTAMPING_OPT_ID in sk->sk_tsflags =
had
> > >> been there for quite some time now. Is it a safe assumption that
> > >> most applications doing udp tx timestamping should have
> > >> the SOF_TIMESTAMPING_OPT_ID set to be useful?
> > >>
> > >>>
> > >>>> If it is
> > >>>> unlikely, may be we can just disallow bpf prog from directly set=
ting
> > >>>> skb_shinfo(skb)->tskey for this particular skb.
> > >>>>
> > >>>> For all other cases, in __ip[6]_append_data, directly call a bpf=
 prog and also
> > >>>> pass the kernel decided tskey to the bpf prog.
> > >>>>
> > >>>> The kernel passed tskey could be 0 (meaning the user space has n=
ot used it). The
> > >>>> bpf prog can give one for the kernel to use. The bpf prog can st=
ore the
> > >>>> sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add o=
ne to the struct
> > >>>> sock. The bpf prog does not have to start from 0 (e.g. start fro=
m U32_MAX
> > >>>> instead) if it helps.
> > >>>>
> > >>>> If the kernel passed tskey is not 0, the bpf prog can just use t=
hat one
> > >>>> (assuming the user space is doing something sane, like the value=
 in
> > >>>> SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_M=
AX). I hope this
> > >>>> is very unlikely also (?) but the bpf prog can probably detect t=
his and choose
> > >>>> to ignore this sk.
> > >>> If an applications uses OPT_ID, it is unlikely that they will tog=
gle
> > >>> the feature on and off on a per-packet basis. So in the common ca=
se
> > >>> the program could use the user-set counter or use its own if user=
space
> > >>> does not enable the feature. In the rare case that an application=
 does
> > >>> intermittently set an OPT_ID, the numbering would be erratic. Thi=
s
> > >>> does mean that an actively malicious application could mess with =
admin
> > >>> measurements.
> > >>
> > >> All make sense. Given it is reasonable to assume the user space sh=
ould either
> > >> has SOF_TIMESTAMPING_OPT_ID always on or always off. When it is of=
f, the bpf
> > >> prog can directly provide its own tskey to be used in shinfo->tske=
y. The bpf
> > >> prog can generate the id itself without using the sk->sk_tskey, e.=
g. store an
> > >> atomic int in the bpf_sk_storage.
> > >
> > > I wonder, how can we correlate the key with each skb in the bpf
> > > program for non-TCP type without implementing a bpf extension for
> > > SCM_TS_OPT_ID? Every time the timestamp is reported, we cannot know=

> > > which sendmsg() the skb belongs to for non-TCP cases.
> >
> > SCM_TS_OPT_ID is eventually setting the shinfo->tskey.
> > If the shinfo->tskey is not set by the user space, the bpf prog can d=
irectly set
> > the shinfo->tskey. There is no need to use the sk->sk_tskey as the ID=
 generator
> > also. The bpf prog can have its own id generator.
> >
> > If the user space has already set the shinfo->tskey (either by sk->sk=
_tskey or
> > SCM_TS_OPT_ID), the bpf prog can just use the user space one.
> >
> > If there is a weird application that flips flops between OPT_ID on/of=
f, the bpf
> > prog will get confused which is fine. The bpf prog can detect this an=
d choose to
> > ignore measuring this sk/skb.

That will skew measurement and is under control of the process.

I don't immediately foresee this being used to measure untrusted
processes that would have an incentive to game this.

But the caveat should be stated explicitly.

> > The bpf prog can also choose to be on the very
> > safe side and ignore all skb with SKBTX_ANY_TSTAMP set in txflags but=
 with no
> > OPT_ID. The bpf prog can look into the details of the sk and skb to d=
ecide what
> > makes the most sense for its deployment.
> >
> > I don't know whether it makes more sense to call the bpf prog to deci=
de the
> > shinfo->{tx_flags,tskey} just before the "while (length > 0)" in
> > __ip[6]_append_data or it is better to call the bpf prog in ip[6]_set=
up_cork.
> > I admittedly less familiar with this code path than the tcp one.

Probably the current spot, mainly because no skb exists yet in
ip_setup_cork.
 =

> Now I feel it could be complicated for a software engineer to consider
> how they will handle the key if they don't read the kernel code very
> carefully. They are facing different situations. Being user-friendly
> lets this feature have more chances to get widely used. As I insisted
> before, I still would like to know if it is possible that we can try
> to introduce sk_tskey_bpf_offset (like patch 10-12) to calculate a bpf
> exclusive tskey for bpf use? Only exporting one key. It will be really
> simple and easy-to-use :)

That has complications of its own. It also has to deal with the user
enabling/disabling/resetting its key, and with OPT_ID passed by cmsg.
Multiple skbs may be in flight, derived from each of these sources.
A single sk flag can only offset against one of them.

I think Martin's approach is more workable. Use the tskey that is set,
if any. Else, set one. =

