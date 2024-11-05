Return-Path: <bpf+bounces-44015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C59BC55E
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 07:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF4FCB20EBD
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 06:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE14C1D4161;
	Tue,  5 Nov 2024 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+4h7ujw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FB0163;
	Tue,  5 Nov 2024 06:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787765; cv=none; b=QUO42b9Xkjpb8wpR46IvdjJeJiCvkC14EKFsZ0NOAajee+yxeFgvmIrWkK0hm7ocqhXgERZoqTtje4K8TrcINSvzIXJ2XUB9C82nEYPhiVW5nh4ovdC0lIf0u2b6xzC2XTe8xMxxrSFd0sWu+6EO7w3JYt6iEQkT2n6Kp0Knc5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787765; c=relaxed/simple;
	bh=aNl2E3H4cKHc9llfDLnp9kLXtaAASb/WBZ21KYfjLvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsfMyQdp6iG/ndhL5bKaCo3aFIZBPgtIw19V/WULt4ZFWSV+T/pDAJcJ6t2MhnAW2hgGsFj/HV/FLn1uV+aORb4TU7Rtx7Sdgo5AcPX7DskbNTpYYpANy7j1SPRPvIHPFXqRdozHZFzHhCU2xabOc0WBvWJ+I274mmVis2Yb/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+4h7ujw; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a6c3230858so8737015ab.0;
        Mon, 04 Nov 2024 22:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730787763; x=1731392563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNl2E3H4cKHc9llfDLnp9kLXtaAASb/WBZ21KYfjLvg=;
        b=a+4h7ujwM3y0SBCseYnKIYcVVhcrgTVgBVbrqPS0PJup13T7sboh7oCVfpYM7SMJlU
         aODwacprucIPtdS600d/cmUKPgcjUVlmETTtK/J58IGzHIOsCAe/6EMxpy/wrcW8yNF0
         1Cje5iXcRawwt7uPYxT+ftmaveIXheKYlnXrI5zXarYiK3lfIkVaENuX1yMG0vwEvgnh
         HwvhERSFXUvvvf9iW6XGmLRtkPFlvYU7YU2oWiCfQwnYxyzh73BLI/50+41BGpRJ7W1X
         Nh1NyWRSIT1gYFN/P58JhFQ6HZA3G7ecoYDKtsBKbIqfKpuSXMFk/Qyrdd9WMa4G6tSg
         IP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730787763; x=1731392563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNl2E3H4cKHc9llfDLnp9kLXtaAASb/WBZ21KYfjLvg=;
        b=brUBG3Y6W94G1ynL6/gAN9UmdyetU6jgo8w6EcmmAhE7LyULi0xKB5hbV61SV25nyk
         XFUW1DgnsO4Mdmr/ivUYkrhaqHdXjxqloQ5IZ7ea7Kjhqwaevp6emO8Dkr+g0JFZXu4k
         5kdX42NatPY+XnlP/mkRCjIHB16YX+I4v1/t4/GMFYLsnfKwjGyUwBxQJZDgI3kF6uo3
         zq4tUvGjO7E3mXw/tTj3wkMz0/C9nNqVwE7jipW0BcVsr+nCfgXIwI453eZp4YQ1AETR
         t+KW+a7G9e3JocY12imzGYqTPnhPZp0ZlGKPAXnnUCg+JGtZFmVCKTGJnZhpOAmNJvim
         sEDg==
X-Forwarded-Encrypted: i=1; AJvYcCWWpJsKvBh1TudLBlrfpx4NsP52v5SjP6a9dnVe5F+Jp9iIPjtzdoxC7abbpQA8ItEqPbBR+awx@vger.kernel.org, AJvYcCXzJomb2IoW0ZvjVPnQ0ujRnYTxbYK8yGVyb5PHbTTGFZylzkbYZx9vl+hnClCHSoz62dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxRwf59JkNdeJoxcAfUZnC7vLazgBj51d89OMxvp9RZS5A+oG
	4fLxO938piP9hccCCOmaFWFXd4vjS5EExYxahm2HtmnlQnXOrEWE/iBf5ZoUtfNS7vTwMzqzcDx
	1Zy0Eq2wfd6hH0MNqIlj6GSVLapw=
X-Google-Smtp-Source: AGHT+IEpxf2sfvFRjRpi3y6ERACa3nKX/WgSkFLuryGXPofenvfsIic7GodSZtZmsWFbCtAdwSoxq2bVFmBdoslsLfM=
X-Received: by 2002:a05:6e02:214c:b0:3a4:e4d0:9051 with SMTP id
 e9e14a558f8ab-3a617572325mr175244565ab.24.1730787762813; Mon, 04 Nov 2024
 22:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev> <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev> <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch> <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev> <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
 <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev>
In-Reply-To: <1c8ebc16-f8e7-4a98-9518-865db3952f8f@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 Nov 2024 14:22:06 +0800
Message-ID: <CAL+tcoBf+kQ3_kc9x62KnHx9O+6c==_DN+6EheL82UKQ3xQN1A@mail.gmail.com>
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

On Tue, Nov 5, 2024 at 10:09=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 11/1/24 6:32 AM, Willem de Bruijn wrote:
> >> In udp/raw/..., I don't know how likely is the user space having "cork=
->tx_flags
> >> & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) &
> >> SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set.
> > This is not something to rely on. OPT_ID was added relatively recently.
> > Older applications, or any that just use the most straightforward API,
> > will not set this.
>
> Good point that the OPT_ID per cmsg is very new.
>
> The datagram support on SOF_TIMESTAMPING_OPT_ID in sk->sk_tsflags had
> been there for quite some time now. Is it a safe assumption that
> most applications doing udp tx timestamping should have
> the SOF_TIMESTAMPING_OPT_ID set to be useful?
>
> >
> >> If it is
> >> unlikely, may be we can just disallow bpf prog from directly setting
> >> skb_shinfo(skb)->tskey for this particular skb.
> >>
> >> For all other cases, in __ip[6]_append_data, directly call a bpf prog =
and also
> >> pass the kernel decided tskey to the bpf prog.
> >>
> >> The kernel passed tskey could be 0 (meaning the user space has not use=
d it). The
> >> bpf prog can give one for the kernel to use. The bpf prog can store th=
e
> >> sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add one to =
the struct
> >> sock. The bpf prog does not have to start from 0 (e.g. start from U32_=
MAX
> >> instead) if it helps.
> >>
> >> If the kernel passed tskey is not 0, the bpf prog can just use that on=
e
> >> (assuming the user space is doing something sane, like the value in
> >> SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_MAX). I=
 hope this
> >> is very unlikely also (?) but the bpf prog can probably detect this an=
d choose
> >> to ignore this sk.
> > If an applications uses OPT_ID, it is unlikely that they will toggle
> > the feature on and off on a per-packet basis. So in the common case
> > the program could use the user-set counter or use its own if userspace
> > does not enable the feature. In the rare case that an application does
> > intermittently set an OPT_ID, the numbering would be erratic. This
> > does mean that an actively malicious application could mess with admin
> > measurements.
>
> All make sense. Given it is reasonable to assume the user space should ei=
ther
> has SOF_TIMESTAMPING_OPT_ID always on or always off. When it is off, the =
bpf
> prog can directly provide its own tskey to be used in shinfo->tskey. The =
bpf
> prog can generate the id itself without using the sk->sk_tskey, e.g. stor=
e an
> atomic int in the bpf_sk_storage.

I wonder, how can we correlate the key with each skb in the bpf
program for non-TCP type without implementing a bpf extension for
SCM_TS_OPT_ID? Every time the timestamp is reported, we cannot know
which sendmsg() the skb belongs to for non-TCP cases.

Thanks,
Jason

