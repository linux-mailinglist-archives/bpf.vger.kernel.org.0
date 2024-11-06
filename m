Return-Path: <bpf+bounces-44102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AE99BDD4D
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 03:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1AA72814D4
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 02:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6C18FDBD;
	Wed,  6 Nov 2024 02:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXi2lm3u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA31187848;
	Wed,  6 Nov 2024 02:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861552; cv=none; b=cZw6qZK86v9W0LEzFG/eU5/PqaLwtfAIQ3cj1SmCJiQD+Ch2PgT0svAneht8573MZIjP6C9rUYWQHJc8LIU2enk19TPyZFEPvefH0WcySRDKejgG5Ib7kiPfK2PiQN+paLLYtfDfruwyFgungim1YSY4PJtqqZKCR9+ekDcJOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861552; c=relaxed/simple;
	bh=e3hlVrJRpUO6YQIlHBdkN2xvdtx+j9hFtTEy629A3/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uz1NNkdgqEmgdga48p24xOdk8s0pQ5nFVqgzQgi1VLdjLR+ahyfb1Z0GWPjkaLwwTWwHf2RoLP7Zn1ukOA+KVxv0wsP4K8jqCE0WvHT/mkftE/lbe7TLpLDAiPGY+VW28LDjZvuCvj9xRkJ9Y3/CTFAhgPMc3y21y4ueBq08RhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXi2lm3u; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-83aae6aba1aso216645239f.2;
        Tue, 05 Nov 2024 18:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730861549; x=1731466349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3hlVrJRpUO6YQIlHBdkN2xvdtx+j9hFtTEy629A3/g=;
        b=bXi2lm3uMFuwfSPqj0qcrlAgBkcQJizVfLrkHwBjHnSKo+LtBmK5Myn6ViodglNRS2
         vvqh8g4VG54zeDHTEQ1Ro6Y8FO+bhtIopkbmx5jD6AW5Ga7ILGlpGpoCsiKG/ohKK5Zq
         JEpEWkOx8Vo5UX2IDY6B4/myWspIWmvgNi0cAz1JOYauWCJhmfEGaAAgVvBbP/oF/BHl
         Nj8akciQDflz22h6EuXm45ojYMnGRLYvykTR53aab4mO79XZkez4hgr7wnIU9c8aKRqS
         oIKURhv+YXCnsGF141UCSb7MzYcomTNr8HwvkOshOxjp+w1WpqKLsRhppTPCpAqabVcz
         EYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861549; x=1731466349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3hlVrJRpUO6YQIlHBdkN2xvdtx+j9hFtTEy629A3/g=;
        b=hemILBKIxPXR5nl3j4jI0MFd3BVwsIggFo5QV+bECgNbAUNnWSnkXmcZNzvVnmCIS/
         2vIyVr4HhqhNDeRi5Zsdm2aeQdARoCB56sjNJhEsYEa1ETb9llmHf2Wfl2CbkGMpHcfz
         xCCRlIWCPBxm6NR6xhEQVSfmm8Xm1oE5Od8fPAXdc/qvQ7qfB+HY1cnly0cfJ2GySPMu
         qM4UcawIau9tqZTjgKa7VF/4e2T/m0cSJpZS0JFcP7SZi5QdqwKVEnEPAFfZNJdOnU7N
         WcIwoTAogGSTnWlNqUtu0kw7R24XvAES4OkTbf1GyI8r/rYucG64z5qvjJcIjKsXIis5
         55Eg==
X-Forwarded-Encrypted: i=1; AJvYcCU19lZ0jx5rFX28gp/OsysSriEAjOultsJZZhdsbr1kWU3FLt0ZazTjinIWDiNKBdjpJ2Q=@vger.kernel.org, AJvYcCX0N8HlWXMxX8ixNk7FFDzCTwHob6liWk71BqXfVkVr51AMDySjekhIttRbePWsKt6WnQEqSl1g@vger.kernel.org
X-Gm-Message-State: AOJu0YzHoQPEB8KgxNR9vFhFVFlmhkBrj/V5LnVgaHwuPuy2rgZ/hLlc
	EPqE4VdNi9avajfJ7yRnW6W/HvGNoIjoWVilZ/AAMVrV9h92Q3SSxulxUBXanfzG7AxIsQvZSD2
	CG15DUbUQH9MVjmszDMk0yxS9yFo=
X-Google-Smtp-Source: AGHT+IGAGYi/0qikZxCzraxfN95upskecQIA3/oO+gUFuG2yv72tP8umb8icIyB5qOqDUeyKUICsjZAGZ3XVvxK5hXE=
X-Received: by 2002:a05:6e02:216e:b0:3a4:ecdb:d61d with SMTP id
 e9e14a558f8ab-3a6b02c72e1mr197764735ab.8.1730861549381; Tue, 05 Nov 2024
 18:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev> <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev> <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch> <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev> <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
 <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev> <CAL+tcoBf+kQ3_kc9x62KnHx9O+6c==_DN+6EheL82UKQ3xQN1A@mail.gmail.com>
 <f27ab4ce-02df-464e-90ed-852652fb7e3e@linux.dev> <CAL+tcoDEMJGYNw01QnEUZwtG5BMj3AyLwtp1m1_hJfY2bG=-dQ@mail.gmail.com>
 <97d8f9b3-9ae3-4146-a933-70dbe393132e@linux.dev>
In-Reply-To: <97d8f9b3-9ae3-4146-a933-70dbe393132e@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 6 Nov 2024 10:51:52 +0800
Message-ID: <CAL+tcoBzces5_awOzZsyqpTWjk0moxkjj7kHjCtPcsU3kNJ4tg@mail.gmail.com>
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

On Wed, Nov 6, 2024 at 9:09=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 11/5/24 4:17 PM, Jason Xing wrote:
> > On Wed, Nov 6, 2024 at 3:22=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >>
> >> On 11/4/24 10:22 PM, Jason Xing wrote:
> >>> On Tue, Nov 5, 2024 at 10:09=E2=80=AFAM Martin KaFai Lau <martin.lau@=
linux.dev> wrote:
> >>>>
> >>>> On 11/1/24 6:32 AM, Willem de Bruijn wrote:
> >>>>>> In udp/raw/..., I don't know how likely is the user space having "=
cork->tx_flags
> >>>>>> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags)=
 &
> >>>>>> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set.
> >>>>> This is not something to rely on. OPT_ID was added relatively recen=
tly.
> >>>>> Older applications, or any that just use the most straightforward A=
PI,
> >>>>> will not set this.
> >>>>
> >>>> Good point that the OPT_ID per cmsg is very new.
> >>>>
> >>>> The datagram support on SOF_TIMESTAMPING_OPT_ID in sk->sk_tsflags ha=
d
> >>>> been there for quite some time now. Is it a safe assumption that
> >>>> most applications doing udp tx timestamping should have
> >>>> the SOF_TIMESTAMPING_OPT_ID set to be useful?
> >>>>
> >>>>>
> >>>>>> If it is
> >>>>>> unlikely, may be we can just disallow bpf prog from directly setti=
ng
> >>>>>> skb_shinfo(skb)->tskey for this particular skb.
> >>>>>>
> >>>>>> For all other cases, in __ip[6]_append_data, directly call a bpf p=
rog and also
> >>>>>> pass the kernel decided tskey to the bpf prog.
> >>>>>>
> >>>>>> The kernel passed tskey could be 0 (meaning the user space has not=
 used it). The
> >>>>>> bpf prog can give one for the kernel to use. The bpf prog can stor=
e the
> >>>>>> sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add one=
 to the struct
> >>>>>> sock. The bpf prog does not have to start from 0 (e.g. start from =
U32_MAX
> >>>>>> instead) if it helps.
> >>>>>>
> >>>>>> If the kernel passed tskey is not 0, the bpf prog can just use tha=
t one
> >>>>>> (assuming the user space is doing something sane, like the value i=
n
> >>>>>> SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_MAX=
). I hope this
> >>>>>> is very unlikely also (?) but the bpf prog can probably detect thi=
s and choose
> >>>>>> to ignore this sk.
> >>>>> If an applications uses OPT_ID, it is unlikely that they will toggl=
e
> >>>>> the feature on and off on a per-packet basis. So in the common case
> >>>>> the program could use the user-set counter or use its own if usersp=
ace
> >>>>> does not enable the feature. In the rare case that an application d=
oes
> >>>>> intermittently set an OPT_ID, the numbering would be erratic. This
> >>>>> does mean that an actively malicious application could mess with ad=
min
> >>>>> measurements.
> >>>>
> >>>> All make sense. Given it is reasonable to assume the user space shou=
ld either
> >>>> has SOF_TIMESTAMPING_OPT_ID always on or always off. When it is off,=
 the bpf
> >>>> prog can directly provide its own tskey to be used in shinfo->tskey.=
 The bpf
> >>>> prog can generate the id itself without using the sk->sk_tskey, e.g.=
 store an
> >>>> atomic int in the bpf_sk_storage.
> >>>
> >>> I wonder, how can we correlate the key with each skb in the bpf
> >>> program for non-TCP type without implementing a bpf extension for
> >>> SCM_TS_OPT_ID? Every time the timestamp is reported, we cannot know
> >>> which sendmsg() the skb belongs to for non-TCP cases.
> >>
> >> SCM_TS_OPT_ID is eventually setting the shinfo->tskey.
> >> If the shinfo->tskey is not set by the user space, the bpf prog can di=
rectly set
> >> the shinfo->tskey. There is no need to use the sk->sk_tskey as the ID =
generator
> >> also. The bpf prog can have its own id generator.
> >>
> >> If the user space has already set the shinfo->tskey (either by sk->sk_=
tskey or
> >> SCM_TS_OPT_ID), the bpf prog can just use the user space one.
> >>
> >> If there is a weird application that flips flops between OPT_ID on/off=
, the bpf
> >> prog will get confused which is fine. The bpf prog can detect this and=
 choose to
> >> ignore measuring this sk/skb. The bpf prog can also choose to be on th=
e very
> >> safe side and ignore all skb with SKBTX_ANY_TSTAMP set in txflags but =
with no
> >> OPT_ID. The bpf prog can look into the details of the sk and skb to de=
cide what
> >> makes the most sense for its deployment.
> >>
> >> I don't know whether it makes more sense to call the bpf prog to decid=
e the
> >> shinfo->{tx_flags,tskey} just before the "while (length > 0)" in
> >> __ip[6]_append_data or it is better to call the bpf prog in ip[6]_setu=
p_cork.
> >> I admittedly less familiar with this code path than the tcp one.
> >
> > Now I feel it could be complicated for a software engineer to consider
> > how they will handle the key if they don't read the kernel code very
> > carefully. They are facing different situations. Being user-friendly
> > lets this feature have more chances to get widely used. As I insisted
> > before, I still would like to know if it is possible that we can try
> > to introduce sk_tskey_bpf_offset (like patch 10-12) to calculate a bpf
> > exclusive tskey for bpf use? Only exporting one key. It will be really
> > simple and easy-to-use :)
>
> imo, there is no need for adding sk_tskey_bpf_offset to sk. just allow th=
e bpf
> prog to decide what is the tskey.
>
> There is no usability issue in bpf prog. It is pretty normal for a bpf pr=
og
> author to look at the sk details to make decision.
>
> Abstracting the sk/skb is not helping the bpf prog and not the right dire=
ction
> to go. Over time, there has been case over case that the bpf prog wants t=
o know
> more instead of being abstracted away like running in the user space. e.g=
. The
> "struct bpf_sock" abstraction in the uapi/linux/bpf.h does not scale and =
we have
> stopped adding more abstraction this way. The btf (and PTR_TO_BTF_ID,
> CO-RE...etc) has been added to allow the bpf prog to learn other details =
in sk
> and skb.
>
> Instead, design a better bpf kfunc to help the bpf prog to set the bits/t=
skey in
> the skb. I think this is more important. tcp tskey is easy. just need som=
e care
> on the udp tskey and need to check if the user space has already set one.
> A good designed bpf kfunc is all it needs.

Thanks!

Let me confirm again in case I'm missing something important.
1) For tcp, as you said before, bpf prog can extract the seq from the
exported skb, so I don't need to export any key in this case.
2) For udp, if the skb has skb_shinfo(skb)->tskey set, then export the
key, else, export zero to the bpf program.
3) extend SCM_TS_OPT_ID for the udp/bpf case.

I'm not sure if I should postpone implementing this part after the
basic framework of this series gets merged. Anyway, I will try this :)

Thanks,
Jason

