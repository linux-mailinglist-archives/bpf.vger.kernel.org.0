Return-Path: <bpf+bounces-44199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B30C9BFCFA
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 04:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B831C21B9E
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 03:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E38B144D1A;
	Thu,  7 Nov 2024 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG31ZVCW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811B236D;
	Thu,  7 Nov 2024 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730950350; cv=none; b=K7+xUszMEN0PMOJquvcamb7L09/dIpr/awY7A540HOwAs0F0L7DJq7wOsRrkIxRk3Ia2VsePmP15Bq2QEqBPiN1SiEC+6Rfis5G6OsTxBx5cmnN13/PEjnvbaLF78CwOK/S1r/hbU72alPyuCBqZ5RrKSJlwDaebQhjkfBQHYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730950350; c=relaxed/simple;
	bh=YRLGr0hL7V66KhpMSN4mwHtkNeiErpLUBy1OGXxi/MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rh1BLiUyLMcPyxov0SZgQiXWlDmt/2OyKB/5jVNgiiyehrVLo76K6h0SqTC2smdlA9fh/NoUecwpG/Goc/MShZYf8wk8NMuordLII6f5jJ6H51+l9WteRV4VglLdUPOB3Vj1UEClpnfemZ1Wh0SQJS1rUgdCxKi0vrcb8jeuuXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG31ZVCW; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a394418442so2081785ab.0;
        Wed, 06 Nov 2024 19:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730950347; x=1731555147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aucnnQVRtCg8PKImMoQwKKHEDFzUo2OJNOLOBwVE5pw=;
        b=eG31ZVCWhH4KZy7fgrdSbJHtxVv4r+zNRtYo/QVnW7BoZ8nquC+AQLoT+sohZqwFKU
         KrPm10+rpqWL83MBUdkuV1RL9RIstF8gkOEeM0CfKLk+NrhsVRnj2nR7m5oIyoxZrkNY
         HNK2C2GzhwfgpIhS1KdFR5vv5Zkbn4vV3ZaGYP+ymkiyIY6rD2Ops9rH19SWEdonD2W6
         SudMWUI067E7suSbwE1MCYHd9uZVNC5r1tQIgvQSHgEtxUWRJlrCCU6jpbo+p90ceYn1
         iDFDTAEFMt+Nim7lvnQPxWSA+JtdTdIJBOB2DPugez7UH2VmI8H5Zf5r9o1bKnt1v8jM
         IlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730950347; x=1731555147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aucnnQVRtCg8PKImMoQwKKHEDFzUo2OJNOLOBwVE5pw=;
        b=h1ot7eimq5WPzSrnbtt/ZARZyqDhFnZm3PCpkClfNdMjST5IPXV6gZLz5uENoFQr0j
         tpWaPQr5YZgA4Yee0EM1ZL01uGCUolw6qUh2DtVY//sFBYVcCEycjdpD9n0hTqTuuXNl
         2CWigksHtRhngVLLWsNMmBz7/eV8uMm7OtUVQ3QIaltrV4gLpzcGTnuOuTQxfFeL2UoQ
         OnMyOiri77GqUhG4/fD89ReloJPz8RlWVrHZ320xiRMhqmhuRuCHopGS1x373cwfQMoU
         lOVb7QsRaHvEp+b0NnYBGzAAx3uaO27ff0K+sQ/zpw71E6MuyNholFa7Ifj6MBKRM9Fv
         FISg==
X-Forwarded-Encrypted: i=1; AJvYcCVSQmQlT6O0vVF7IkZ6Ds/6uCW800sBrYhuNtdVfOtbOEOWwDkzKwnZBIZNm8kO4IwCMUQ=@vger.kernel.org, AJvYcCWwxocC/mjaQDwVDy+bZdp03Rt223rw2vLYxsPxThLXrhTi2TsRa6s/880o956WLRR6YI3rFvSd@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9Wov7v/tFO6PZ1UMjfLdK0xze5uRG0lx2r9me0PAGUbRZ8cP
	xFe7deaq2nyqM/LWFo6YGXukhpvo5ZQt1KAUsvS9Gz2Ey9F4TvR1YvaRJ2UoGZK4XJBtdyJuuVr
	BCLvBBhqoi7ySpJVpyv+F7wtmfC4=
X-Google-Smtp-Source: AGHT+IGZ/mupGecy45nXAD4+cLwDQBg3z+0nBYdD3IBcljcC8v/XoumIQ3nCf8P6N8ypQ8ApFJ9VaMKg3OYMb/o74Do=
X-Received: by 2002:a05:6e02:1d11:b0:3a5:e7a5:afc with SMTP id
 e9e14a558f8ab-3a6b028898dmr250024615ab.2.1730950347427; Wed, 06 Nov 2024
 19:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev> <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch> <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev> <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
 <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev> <CAL+tcoBf+kQ3_kc9x62KnHx9O+6c==_DN+6EheL82UKQ3xQN1A@mail.gmail.com>
 <f27ab4ce-02df-464e-90ed-852652fb7e3e@linux.dev> <CAL+tcoDEMJGYNw01QnEUZwtG5BMj3AyLwtp1m1_hJfY2bG=-dQ@mail.gmail.com>
 <97d8f9b3-9ae3-4146-a933-70dbe393132e@linux.dev> <CAL+tcoBzces5_awOzZsyqpTWjk0moxkjj7kHjCtPcsU3kNJ4tg@mail.gmail.com>
 <49ad2b87-29af-429e-8acb-2bba13e2b2aa@linux.dev>
In-Reply-To: <49ad2b87-29af-429e-8acb-2bba13e2b2aa@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 7 Nov 2024 11:31:51 +0800
Message-ID: <CAL+tcoAmajwBTkfrWez8sEsyHJUga5qbiOdpybjPPe44dyfYxw@mail.gmail.com>
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

On Thu, Nov 7, 2024 at 9:19=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 11/5/24 6:51 PM, Jason Xing wrote:
> > On Wed, Nov 6, 2024 at 9:09=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >>
> >> On 11/5/24 4:17 PM, Jason Xing wrote:
> >>> On Wed, Nov 6, 2024 at 3:22=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> >>>>
> >>>> On 11/4/24 10:22 PM, Jason Xing wrote:
> >>>>> On Tue, Nov 5, 2024 at 10:09=E2=80=AFAM Martin KaFai Lau <martin.la=
u@linux.dev> wrote:
> >>>>>>
> >>>>>> On 11/1/24 6:32 AM, Willem de Bruijn wrote:
> >>>>>>>> In udp/raw/..., I don't know how likely is the user space having=
 "cork->tx_flags
> >>>>>>>> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflag=
s) &
> >>>>>>>> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" se=
t.
> >>>>>>> This is not something to rely on. OPT_ID was added relatively rec=
ently.
> >>>>>>> Older applications, or any that just use the most straightforward=
 API,
> >>>>>>> will not set this.
> >>>>>>
> >>>>>> Good point that the OPT_ID per cmsg is very new.
> >>>>>>
> >>>>>> The datagram support on SOF_TIMESTAMPING_OPT_ID in sk->sk_tsflags =
had
> >>>>>> been there for quite some time now. Is it a safe assumption that
> >>>>>> most applications doing udp tx timestamping should have
> >>>>>> the SOF_TIMESTAMPING_OPT_ID set to be useful?
> >>>>>>
> >>>>>>>
> >>>>>>>> If it is
> >>>>>>>> unlikely, may be we can just disallow bpf prog from directly set=
ting
> >>>>>>>> skb_shinfo(skb)->tskey for this particular skb.
> >>>>>>>>
> >>>>>>>> For all other cases, in __ip[6]_append_data, directly call a bpf=
 prog and also
> >>>>>>>> pass the kernel decided tskey to the bpf prog.
> >>>>>>>>
> >>>>>>>> The kernel passed tskey could be 0 (meaning the user space has n=
ot used it). The
> >>>>>>>> bpf prog can give one for the kernel to use. The bpf prog can st=
ore the
> >>>>>>>> sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add o=
ne to the struct
> >>>>>>>> sock. The bpf prog does not have to start from 0 (e.g. start fro=
m U32_MAX
> >>>>>>>> instead) if it helps.
> >>>>>>>>
> >>>>>>>> If the kernel passed tskey is not 0, the bpf prog can just use t=
hat one
> >>>>>>>> (assuming the user space is doing something sane, like the value=
 in
> >>>>>>>> SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_M=
AX). I hope this
> >>>>>>>> is very unlikely also (?) but the bpf prog can probably detect t=
his and choose
> >>>>>>>> to ignore this sk.
> >>>>>>> If an applications uses OPT_ID, it is unlikely that they will tog=
gle
> >>>>>>> the feature on and off on a per-packet basis. So in the common ca=
se
> >>>>>>> the program could use the user-set counter or use its own if user=
space
> >>>>>>> does not enable the feature. In the rare case that an application=
 does
> >>>>>>> intermittently set an OPT_ID, the numbering would be erratic. Thi=
s
> >>>>>>> does mean that an actively malicious application could mess with =
admin
> >>>>>>> measurements.
> >>>>>>
> >>>>>> All make sense. Given it is reasonable to assume the user space sh=
ould either
> >>>>>> has SOF_TIMESTAMPING_OPT_ID always on or always off. When it is of=
f, the bpf
> >>>>>> prog can directly provide its own tskey to be used in shinfo->tske=
y. The bpf
> >>>>>> prog can generate the id itself without using the sk->sk_tskey, e.=
g. store an
> >>>>>> atomic int in the bpf_sk_storage.
> >>>>>
> >>>>> I wonder, how can we correlate the key with each skb in the bpf
> >>>>> program for non-TCP type without implementing a bpf extension for
> >>>>> SCM_TS_OPT_ID? Every time the timestamp is reported, we cannot know
> >>>>> which sendmsg() the skb belongs to for non-TCP cases.
> >>>>
> >>>> SCM_TS_OPT_ID is eventually setting the shinfo->tskey.
> >>>> If the shinfo->tskey is not set by the user space, the bpf prog can =
directly set
> >>>> the shinfo->tskey. There is no need to use the sk->sk_tskey as the I=
D generator
> >>>> also. The bpf prog can have its own id generator.
> >>>>
> >>>> If the user space has already set the shinfo->tskey (either by sk->s=
k_tskey or
> >>>> SCM_TS_OPT_ID), the bpf prog can just use the user space one.
> >>>>
> >>>> If there is a weird application that flips flops between OPT_ID on/o=
ff, the bpf
> >>>> prog will get confused which is fine. The bpf prog can detect this a=
nd choose to
> >>>> ignore measuring this sk/skb. The bpf prog can also choose to be on =
the very
> >>>> safe side and ignore all skb with SKBTX_ANY_TSTAMP set in txflags bu=
t with no
> >>>> OPT_ID. The bpf prog can look into the details of the sk and skb to =
decide what
> >>>> makes the most sense for its deployment.
> >>>>
> >>>> I don't know whether it makes more sense to call the bpf prog to dec=
ide the
> >>>> shinfo->{tx_flags,tskey} just before the "while (length > 0)" in
> >>>> __ip[6]_append_data or it is better to call the bpf prog in ip[6]_se=
tup_cork.
> >>>> I admittedly less familiar with this code path than the tcp one.
> >>>
> >>> Now I feel it could be complicated for a software engineer to conside=
r
> >>> how they will handle the key if they don't read the kernel code very
> >>> carefully. They are facing different situations. Being user-friendly
> >>> lets this feature have more chances to get widely used. As I insisted
> >>> before, I still would like to know if it is possible that we can try
> >>> to introduce sk_tskey_bpf_offset (like patch 10-12) to calculate a bp=
f
> >>> exclusive tskey for bpf use? Only exporting one key. It will be reall=
y
> >>> simple and easy-to-use :)
> >>
> >> imo, there is no need for adding sk_tskey_bpf_offset to sk. just allow=
 the bpf
> >> prog to decide what is the tskey.
> >>
> >> There is no usability issue in bpf prog. It is pretty normal for a bpf=
 prog
> >> author to look at the sk details to make decision.
> >>
> >> Abstracting the sk/skb is not helping the bpf prog and not the right d=
irection
> >> to go. Over time, there has been case over case that the bpf prog want=
s to know
> >> more instead of being abstracted away like running in the user space. =
e.g. The
> >> "struct bpf_sock" abstraction in the uapi/linux/bpf.h does not scale a=
nd we have
> >> stopped adding more abstraction this way. The btf (and PTR_TO_BTF_ID,
> >> CO-RE...etc) has been added to allow the bpf prog to learn other detai=
ls in sk
> >> and skb.
> >>
> >> Instead, design a better bpf kfunc to help the bpf prog to set the bit=
s/tskey in
> >> the skb. I think this is more important. tcp tskey is easy. just need =
some care
> >> on the udp tskey and need to check if the user space has already set o=
ne.
> >> A good designed bpf kfunc is all it needs.
> >
> > Thanks!
> >
> > Let me confirm again in case I'm missing something important.
> > 1) For tcp, as you said before, bpf prog can extract the seq from the
> > exported skb, so I don't need to export any key in this case.
> > 2) For udp, if the skb has skb_shinfo(skb)->tskey set, then export the
> > key, else, export zero to the bpf program.
>
> A follow up to myself on the earlier bpf kfunc comment. Something like th=
is:

Thank you so much!

>
> /* ack: request ACK timestamp (tcp only)
>   * req_tskey: bpf prog can request to use a particular tskey.
>   *            req_tskey should always be 0 for tcp.
>   * return: -ve for error. u32 for the tskey that the bpf prog should use=
.
>   *        may be different from the req_tskey (e.g. the user space has
>   *         already set one).
>   */
> __bpf_kfunc s64 bpf_skops_enable_tx_tstamp(struct bpf_sock_ops_kern *skop=
s,
>                                            bool ack, u32 req_tskey);
>
> /* "not sure" if this kfunc is needed. probably no. I think it is easier =
to pass
>   * true/false in the args[0]. It seems tskey can be 0 in udp, so

Good idea.

>   * passing tskey can't tell if the skb/cork/sockcm_cookie has the tskey.
>   */
> __bpf_kfunc bool bpf_skops_has_tskey(struct bpf_sock_ops_kern *skops);
>
> For udp, I don't know whether it will be easier to set the tskey in the '=
cork'
> or 'sockcm_cookie' or 'skb'. I guess it depends where the bpf prog is cal=
led. If
> skb, it seems the bpf prog may be called repetitively for doing the same =
thing
> in the while loop in __ip[6]_append_data. If it is better to set the 'cor=
k' or
> 'sockcm_cookie', the cork/sockcm_cookie pointer can be added to 'struct
> bpf_sock_ops_kern'. The sizeof(struct bpf_sock_ops_kern) is at 64bytes. A=
dding
> one pointer is not ideal.... probably it can be union with syn_skb but wi=
ll need
> some code audit (so please check).

Let me dig into it :)

>
>
> > 3) extend SCM_TS_OPT_ID for the udp/bpf case.
>
> I don't understand. What does it mean to extend SCM_TS_OPT_ID?

Oh, I thought you expect to pass the key from the bpf program through
using the interface of SCM_TS_OPT_ID feature which isn't supported by
bpf. Let me think more about it first.

Thanks,
Jason

