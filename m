Return-Path: <bpf+bounces-44083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C899BDA23
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 01:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A492D1F23AED
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 00:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6A8C11;
	Wed,  6 Nov 2024 00:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkMSR5DS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27080B;
	Wed,  6 Nov 2024 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852310; cv=none; b=fTOh9k8NBK5lkNqeOalS6UTw9KUxOtbSV5ZlxtzMd0ksa0+Lss0OeOI6yocFNWisIYd6nzH4W9XYc9yl646nDpHoFsGPDEyRddIb9IR5J2/ZyOBbQpFMaAMSqauvNA09lO1R+264wMBN2FZSm0waY29dzPTp2MZX1zdx5FfSJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852310; c=relaxed/simple;
	bh=kTjHpZ0XEFVEvO+BD5OmpRuXk69iQIvP5v/IF/gOm+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYQmViMv5jaPYZb819120/q3W4FBlI2iPVAQyeBBC+wFQC1rselbn1DjuSKDJfjCEBpRPdHMyvKmxi/HmUbhrr2gZj8KKdWCmGWdZaY3PYfx97rnYlzU/jUvGNkFQj5rX9oRHRKISO5RazQaUlpZCDeAXAB4I+9iv9v/VYihvSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkMSR5DS; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a6ababaaa9so18910315ab.1;
        Tue, 05 Nov 2024 16:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730852306; x=1731457106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTjHpZ0XEFVEvO+BD5OmpRuXk69iQIvP5v/IF/gOm+Y=;
        b=BkMSR5DS+a5gtIh1/CCTynmBMq+n7M4zyQsw911tdZKo9PT3Kbp89w6P66pdcqmwpk
         NpPiLsVc+g0cER5Up/8s3leLeRRy4kJ8fsI2JD+3fKK1kccMK7ih5P76Rx7PBBgUZKlM
         CIXFvHOjjGhYwQ8NMEa6k4F5sBkVS4N0/5BLn2yhOWp7I3paQaxCkPC9r3EQDn72tui+
         ZNXuRkyldqMJ+Ah5zMEt9GuGJuPV5j93fZDL0sdkyY/YInMD89LESxh7A5V1KaL9jWlY
         +3gHMdkgkj4l8mnq1U8GZZSlzuajtkAHlgZU36EF6F1YBcesgWbXH8CdnYvvFIRviUD/
         DLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730852306; x=1731457106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTjHpZ0XEFVEvO+BD5OmpRuXk69iQIvP5v/IF/gOm+Y=;
        b=vxt2b++TqpRSZBYBwbdafCC0dnI+RVYm5w2GnHlcyNRO1W2A5EEY6zICzRmqmlhCcu
         U7kwBglZ5U7Mh3vssZev/bL8S1Xv9O4xhs0YikhNUC01c5NKV2tMJVRolSe3wOQmfKBe
         2u3vOyKH9a/dzdVQXP6yIPPnTiDH7VEbEMFJn5ed3/fm7xy7LOOokNuPZUXNyNvCAUNL
         5keEPYkPApvXuTyI84wrS/ckPZaL6PTlR1iA5IRMN/q3TOaMOVQAZDknwN0CXpbkh7KX
         p4NLwCXq8qHEg53H1JN+7p9wqduaKYgkprsfUPS/QPVVd8nXh71EPUds0XIcsbxx+wIu
         8DJw==
X-Forwarded-Encrypted: i=1; AJvYcCUKWxixN2tKfZfTOXuMmcnq5Bn3bRzXtc5LCNwLF2zl8i51ZkO0LL/dtvOMApNC96Gzqn/Z/Ic5@vger.kernel.org, AJvYcCXCFkU3vMrRQtbHCMYiKqk+ww9qOYeFv1rlCbJKcntJC3uqLPt07q8BoFBRsPXGcahBceE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKjRXFEokWpf6UhjccQl/KsCCowGUjCafLlcWEi7l94Pp8ZVd
	91va2Rs/i6XaEa4J2gaAFIOjG5VzK/rxykUOJ7xw9dx8/nOFCqhhf2eTnFWCp3mTH41vJKo0Zsj
	PDuTzQYjcRNkASaOr4Cmesgh9lrs=
X-Google-Smtp-Source: AGHT+IHNu0+9ahVe6YNsCt62rXR+7BXcSDmvYUB2eThsb7Gf2Qme0A9vyaCydGOTlakgRN78QU4d0ulsMKiu0Zvt7R4=
X-Received: by 2002:a05:6e02:1fc5:b0:3a6:b481:3fd2 with SMTP id
 e9e14a558f8ab-3a6b4814332mr173866965ab.4.1730852306377; Tue, 05 Nov 2024
 16:18:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev> <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev> <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch> <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev> <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
 <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev> <CAL+tcoBf+kQ3_kc9x62KnHx9O+6c==_DN+6EheL82UKQ3xQN1A@mail.gmail.com>
 <f27ab4ce-02df-464e-90ed-852652fb7e3e@linux.dev>
In-Reply-To: <f27ab4ce-02df-464e-90ed-852652fb7e3e@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 6 Nov 2024 08:17:50 +0800
Message-ID: <CAL+tcoDEMJGYNw01QnEUZwtG5BMj3AyLwtp1m1_hJfY2bG=-dQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, willemb@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 3:22=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 11/4/24 10:22 PM, Jason Xing wrote:
> > On Tue, Nov 5, 2024 at 10:09=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >>
> >> On 11/1/24 6:32 AM, Willem de Bruijn wrote:
> >>>> In udp/raw/..., I don't know how likely is the user space having "co=
rk->tx_flags
> >>>> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) &
> >>>> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set.
> >>> This is not something to rely on. OPT_ID was added relatively recentl=
y.
> >>> Older applications, or any that just use the most straightforward API=
,
> >>> will not set this.
> >>
> >> Good point that the OPT_ID per cmsg is very new.
> >>
> >> The datagram support on SOF_TIMESTAMPING_OPT_ID in sk->sk_tsflags had
> >> been there for quite some time now. Is it a safe assumption that
> >> most applications doing udp tx timestamping should have
> >> the SOF_TIMESTAMPING_OPT_ID set to be useful?
> >>
> >>>
> >>>> If it is
> >>>> unlikely, may be we can just disallow bpf prog from directly setting
> >>>> skb_shinfo(skb)->tskey for this particular skb.
> >>>>
> >>>> For all other cases, in __ip[6]_append_data, directly call a bpf pro=
g and also
> >>>> pass the kernel decided tskey to the bpf prog.
> >>>>
> >>>> The kernel passed tskey could be 0 (meaning the user space has not u=
sed it). The
> >>>> bpf prog can give one for the kernel to use. The bpf prog can store =
the
> >>>> sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add one t=
o the struct
> >>>> sock. The bpf prog does not have to start from 0 (e.g. start from U3=
2_MAX
> >>>> instead) if it helps.
> >>>>
> >>>> If the kernel passed tskey is not 0, the bpf prog can just use that =
one
> >>>> (assuming the user space is doing something sane, like the value in
> >>>> SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_MAX).=
 I hope this
> >>>> is very unlikely also (?) but the bpf prog can probably detect this =
and choose
> >>>> to ignore this sk.
> >>> If an applications uses OPT_ID, it is unlikely that they will toggle
> >>> the feature on and off on a per-packet basis. So in the common case
> >>> the program could use the user-set counter or use its own if userspac=
e
> >>> does not enable the feature. In the rare case that an application doe=
s
> >>> intermittently set an OPT_ID, the numbering would be erratic. This
> >>> does mean that an actively malicious application could mess with admi=
n
> >>> measurements.
> >>
> >> All make sense. Given it is reasonable to assume the user space should=
 either
> >> has SOF_TIMESTAMPING_OPT_ID always on or always off. When it is off, t=
he bpf
> >> prog can directly provide its own tskey to be used in shinfo->tskey. T=
he bpf
> >> prog can generate the id itself without using the sk->sk_tskey, e.g. s=
tore an
> >> atomic int in the bpf_sk_storage.
> >
> > I wonder, how can we correlate the key with each skb in the bpf
> > program for non-TCP type without implementing a bpf extension for
> > SCM_TS_OPT_ID? Every time the timestamp is reported, we cannot know
> > which sendmsg() the skb belongs to for non-TCP cases.
>
> SCM_TS_OPT_ID is eventually setting the shinfo->tskey.
> If the shinfo->tskey is not set by the user space, the bpf prog can direc=
tly set
> the shinfo->tskey. There is no need to use the sk->sk_tskey as the ID gen=
erator
> also. The bpf prog can have its own id generator.
>
> If the user space has already set the shinfo->tskey (either by sk->sk_tsk=
ey or
> SCM_TS_OPT_ID), the bpf prog can just use the user space one.
>
> If there is a weird application that flips flops between OPT_ID on/off, t=
he bpf
> prog will get confused which is fine. The bpf prog can detect this and ch=
oose to
> ignore measuring this sk/skb. The bpf prog can also choose to be on the v=
ery
> safe side and ignore all skb with SKBTX_ANY_TSTAMP set in txflags but wit=
h no
> OPT_ID. The bpf prog can look into the details of the sk and skb to decid=
e what
> makes the most sense for its deployment.
>
> I don't know whether it makes more sense to call the bpf prog to decide t=
he
> shinfo->{tx_flags,tskey} just before the "while (length > 0)" in
> __ip[6]_append_data or it is better to call the bpf prog in ip[6]_setup_c=
ork.
> I admittedly less familiar with this code path than the tcp one.

Now I feel it could be complicated for a software engineer to consider
how they will handle the key if they don't read the kernel code very
carefully. They are facing different situations. Being user-friendly
lets this feature have more chances to get widely used. As I insisted
before, I still would like to know if it is possible that we can try
to introduce sk_tskey_bpf_offset (like patch 10-12) to calculate a bpf
exclusive tskey for bpf use? Only exporting one key. It will be really
simple and easy-to-use :)

Thanks,
Jason

