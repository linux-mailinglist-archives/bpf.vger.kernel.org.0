Return-Path: <bpf+bounces-50760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50261A2C234
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 13:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48D5168D55
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E71DF725;
	Fri,  7 Feb 2025 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmFp749p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738B92417C7;
	Fri,  7 Feb 2025 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930099; cv=none; b=ADODo9gzGSwMI2NUtIyEzU9pNknPzWL5FOW32hRIe4uobk63XKUoLWE6QDKJ0nLxy1ObZkrJO6n1OYC7dM9qLdUjz7J/IiIwyPf+RcEEf73RcL643RLq53Esrg/RIXSCm65aDigh9jMP9qa0n7SQfh08Wj7HHxU4OdaHPR/WlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930099; c=relaxed/simple;
	bh=cPcpt0PXK7obvNiTC5aMFDuDmdDtdl5Q8IABBt5/KWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXcwhR1B1yjfUBSm3wSFTWWj/kpbOHI78alddFZSmDCl5ttYfSq6fS+UgQZdJB4kkDPlVtfvcYuMVh40DRuWfzLxmgInBzNyeW+ZhSPIr1RfSGzAgGJ+io7pwF2huiCTX9XEVUvSyqrV5RuFXKzaL0bdl5yAzoU5pSPPbbz04gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmFp749p; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-854a68f5a9cso158924039f.0;
        Fri, 07 Feb 2025 04:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738930096; x=1739534896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4hHCVYSEIrh1Wchgp0ooIrORTPHl9IOkpabYOgczME=;
        b=bmFp749pMxMAiEhGtS9wKq/QG2pfozFASWan+DgiwCJmy7pmofSB1dx78XhOqTxOzy
         W3P6uzTQuhTzBnOZF7E1bH2Ke4rysBhw+WXNRTVhehIYztPZeIpuKHSKFMz7DLkIqDE4
         QCpnLwl3tzEzcfLrSAZQkW90pxnUXeX0eoalGUl+k5qlNNk4qbbiYi8RhPGq7qQR+Q2L
         /Y5nSPBorV9Km+BGNQ03rm3WiVYDlZS524B1mMpErhI/0DaSLzv842PHGLRN0S+pvs4y
         vaDY3PX9JmEYTh3FFguyWfm/YvxNXtV4x/YaqKNOF0EcS7d8BK1sB2OA4wFyl1uHAZ2H
         rqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930096; x=1739534896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4hHCVYSEIrh1Wchgp0ooIrORTPHl9IOkpabYOgczME=;
        b=hvmdM3bMPD6DZazQHRF/KuLWFg50WH8RRVoKJfs+IFHBNOLqrNV4Dx50O5ZE4DNojT
         /dVuUAstoDWNF9KwaJzHbLb6jTaVMk/eA4rRCVB6jd+VkVIwRkH6jv3SegdIgv3XnvcO
         uFYvLxAbpkkyiSiA29xEOb30cNuJdgbVl+U1AwAHwG1Gu30zEkzdGXau+WB6JOctIXOr
         rzDxuMn6o8tlNPtVr6YTjkXkJQuVHCOq0YT/uLvoj7/YmKewjTkxbywIh+U97bXHvsq8
         kp62XJI3YSfxzinso0+2e3RncbH2vJKdd6v0As8imWO0wZ9vfPkf6CdaMr0abOcdJRve
         xDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlP4t3fPXnW3wljX5FyzULMNnl/SAtv9bhLOrP7ky0+VvgBDx6HBVzkyvOpWAHRIobq4rzl3Ym@vger.kernel.org, AJvYcCXCUhXlMo+9WQsw0oCpPOxcuNVfiAC/T7H6sfCDq1SGvj5xb2/xbO8jnsyJd6mAhhl5PTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaQC4Dp6IPxXoz0x41VlXuRm7gHnWesU4n74PV06Qco/Apcaid
	SlSlTVuExxPLW0tEYAxF7V9+HF19MQuqVGREbFTZBIKls0SwqhjDKIX5/7vlPHWtk9xuXp+qH1K
	R4mhiqbi6r5fe3SGJMU+GC9lGcgg=
X-Gm-Gg: ASbGncsvAKoQfUc+ceI42r3uv30Q3ddsCe0qAdEq3yhC+70xphK2oCDmsbo8cE89tPK
	2+/tImQj7RionsMzHNQl4SHtFbMM5rqX16yUY8I7TekCnE6jsAQHZXpdfyvx8tWNTjyXzthsb
X-Google-Smtp-Source: AGHT+IEQNNHrVr0PANu0V/eLZqnnKZOy5Tmk7TYWBug6YqbOgLEKOgen5g/aLeTkPC64mEFgCdyJoQ12+Kn8rlsyz90=
X-Received: by 2002:a92:c263:0:b0:3cf:f88b:b51a with SMTP id
 e9e14a558f8ab-3d13dcfce6cmr23555255ab.2.1738930096325; Fri, 07 Feb 2025
 04:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-11-kerneljasonxing@gmail.com> <20250204175744.3f92c33e@kernel.org>
 <e894c427-b4b3-4706-b44c-44fc6402c14c@linux.dev> <CAL+tcoCQ165Y4R7UWG=J=8e=EzwFLxSX3MQPOv=kOS3W1Q7R0A@mail.gmail.com>
 <0a8e7b84-bab6-4852-8616-577d9b561f4c@linux.dev> <CAL+tcoAp8v49fwUrN5pNkGHPF-+RzDDSNdy3PhVoJ7+MQGNbXQ@mail.gmail.com>
 <CAL+tcoC5hmm1HQdbDaYiQ1iW1x2J+H42RsjbS_ghyG8mSDgqqQ@mail.gmail.com>
 <67a424d2aa9ea_19943029427@willemb.c.googlers.com.notmuch>
 <CAL+tcoCPGAjs=+Hnzr4RLkioUV7nzy=ZmKkTDPA7sBeVP=qzow@mail.gmail.com>
 <67a42ba112990_19c315294b7@willemb.c.googlers.com.notmuch>
 <CAL+tcoC_5106onp6yQh-dKnCTLtEr73EZVC31T_YeMtqbZ5KBw@mail.gmail.com>
 <b158a837-d46c-4ae0-8130-7aa288422182@linux.dev> <CAL+tcoCUjxvE-DaQ8AMxMgjLnV+J1jpYMh7BCOow4AohW1FFSg@mail.gmail.com>
 <739d6f98-8a44-446e-85a4-c499d154b57b@linux.dev> <CAL+tcoA14HKQmG9dtMdRVqgJJ87hcvynPjqVLkAbHnDcsq-RzQ@mail.gmail.com>
In-Reply-To: <CAL+tcoA14HKQmG9dtMdRVqgJJ87hcvynPjqVLkAbHnDcsq-RzQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Feb 2025 20:07:40 +0800
X-Gm-Features: AWEUYZmdF_0BLXWdpelwDDZ4cVzJhNyFiTtA_JpiQwjorMeNrDoSqEGZZELOLcg
Message-ID: <CAL+tcoD9qZvbo53QsUcC27Dp=tJshBFdjoM9RCHxHEsYjwaXWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 10/12] bpf: make TCP tx timestamp bpf
 extension work
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, willemb@google.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 10:18=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Feb 7, 2025 at 10:07=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 2/5/25 10:56 PM, Jason Xing wrote:
> > >>> I have to rephrase a bit in case Martin visits here soon: I will
> > >>> compare two approaches 1) reply value, 2) bpf kfunc and then see wh=
ich
> > >>> way is better.
> > >>
> > >> I have already explained in details why the 1) reply value from the =
bpf prog
> > >> won't work. Please go back to that reply which has the context.
> > >
> > > Yes, of course I saw this, but I said I need to implement and dig mor=
e
> > > into this on my own. One of my replies includes a little code snippet
> > > regarding reply value approach. I didn't expect you to misunderstand
> > > that I would choose reply value, so I rephrase it like above :)
> >
> > I did see the code snippet which is incomplete, so I have to guess. afa=
ik, it is
> > not going to work. I was hoping to save some time without detouring to =
the
> > reply-value path in case my earlier message was missed. I will stay qui=
et and
> > wait for v9 first then to avoid extending this long thread further.
>
> I see. I'm grateful that you point out the right path. I'm still
> investigating to find a good existing example in selftests and how to
> support kfunc.

Martin, sorry to revive this thread.

It's a little bit hard for me to find a proper example to follow. I
tried to call __bpf_kfunc in the BPF_SOCK_OPS_TS_SND_CB callback and
then failed because kfunc is not supported in the sock_ops case.
Later, I tried to kprobe to hook a function, say,
tcp_tx_timestamp_bpf(), passed the skb parameter to the kfunc and then
got an error.

Here is code snippet:
1) net/ipv4/tcp.c
+__bpf_kfunc static void tcp_init_tx_timestamp(struct sk_buff *skb)
+{
+       struct skb_shared_info *shinfo =3D skb_shinfo(skb);
+       struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
+
+       printk(KERN_ERR "jason: %d, %d\n\n", tcb->txstamp_ack,
shinfo->tx_flags);
+       /*
+       tcb->txstamp_ack =3D 2;
+       shinfo->tx_flags |=3D SKBTX_BPF;
+       shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
+       */
+}
Note: I skipped copying some codes like BTF_ID_FLAGS...

2) bpf prog
SEC("kprobe/tcp_tx_timestamp_bpf") // I wrote a new function/wrapper to hoo=
k
int BPF_KPROBE(kprobe__tcp_tx_timestamp_bpf, struct sock *sk, struct
sk_buff *skb)
{
        tcp_init_tx_timestamp(skb);
        return 0;
}

Then running the bpf prog, I got the following message:
; tcp_init_tx_timestamp(skb); @ so_timestamping.c:281
1: (85) call tcp_init_tx_timestamp#120682
arg#0 pointer type STRUCT sk_buff must point to scalar, or struct with scal=
ar
processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'kprobe__tcp_tx_timestamp_bpf': failed to load: -22
libbpf: failed to load object 'so_timestamping'
libbpf: failed to load BPF skeleton 'so_timestamping': -22
test_so_timestamping:FAIL:open and load skel unexpected error: -22

If I don't pass any parameter in the kfunc, it can work.

Should we support the sock_ops for __bpf_kfunc?

Please enlighten me more about this. Thanks in advance!

Thanks,
Jason

