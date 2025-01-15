Return-Path: <bpf+bounces-48886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3232A1162E
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1853A25F1
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5571EB3D;
	Wed, 15 Jan 2025 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWKyi1ZC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A7156CA;
	Wed, 15 Jan 2025 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736901853; cv=none; b=sm5Z0/HNPUUAnRUZZeAeGit7HV25WmUfU1En0jc9JHahLL4708iF7z5qzwEz8jZ7Lq1UdHsnpAf89X+AKKb7J9qdEorqn06Cvb3xXkI0SWP7wVATlB4Q2zsf3vANU6LawlMXjxl9ldDLqQ2xD9+bgo/NkMqXmf2UC+Aqw9rLV/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736901853; c=relaxed/simple;
	bh=ezEincOoHPjdcYLbZHK1viPILsSmP/9HtHulDEmmH9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHla2mLqGy6YBDAfYfmhayUZBFX3eGGCYeO3ltK+A4XWGXJk77iGECW5VpBLiOXfjS71yur+mLwESwd+IM6FADbJyGcGU9220Quxu0TNHhZFtMF6M5ITUIUdbsdpZEg82pPij86pF7r2I6DU6RJSNO7jdrYLTUOy6BDF08v12JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWKyi1ZC; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a8180205f3so1386145ab.0;
        Tue, 14 Jan 2025 16:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736901851; x=1737506651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VofIYYEITzuE/i0BCW5HTH9agRQLgUMh5W5KmnpSjk=;
        b=ZWKyi1ZC/xZ8bSbi/5hyMBr3tBolg2Ho6N7iRt1Ig1e9TWu/P0NmEt8AFx0tQ65fg/
         S5lezG5upX2iWzCOezzeJAjELa3Iw52rp/D4MJZrn2TkPVvTSIEkAoGFH/J5V1Tln0zp
         Ycf1f440MexaBLUKJddp1//KMXFzXAiK8JC6WcxlulfRhZP+3TfdXH7OLDWszXWcWBNM
         raC8dXunpXKohIsW5hQdU7x8xEBsaJz+3zyOhQ1wN4QC2eZ8Khj/fSwdheVjTiziNbnE
         aYUPsBt61SiGSEbkdo5eX5fJD67VGD8ifuFMGIAV1j7mwpj9w074gDDGVoB48Tv8rgQX
         iFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736901851; x=1737506651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VofIYYEITzuE/i0BCW5HTH9agRQLgUMh5W5KmnpSjk=;
        b=U57q1D+5c7+JSn1L5XUPMS5I1sUScDRClQrh5xxcj9nEunr/1/zhhZuT7JoD858WbY
         BxiONqBfj+Vni+D679lC146tG/h7BobV/Ti9whct6ErYd1gEgkO6pKFoKe/SRjqMN4YB
         DCKmoBc+p3yDJzHksJQOCPV10RBIMWtAMayL3WoZXrfs0Ct/+C5HiDH0ZQbIbfcXdj17
         6sqexppGloaSxanC6CztbLA0ki/zDvV1+jzjoWmZLHlncCpwXkrtNDI46DA1cDvCFkil
         iTQkWgY+UguM0S1Iy9ZPJpLg2ZyZG+n+i+SbDX3JVJrXhg0gq4kl0p8TRrWo6TZbUpmX
         NepA==
X-Forwarded-Encrypted: i=1; AJvYcCUaayLu79fHL++MzwzL6gOox1/kr0Fy7RJ3twI+hp/n8s4+IXVPjQ7nUPruB87jb0U1N9I=@vger.kernel.org, AJvYcCVkuETE8Sd3Ax7qn4zopEj6KecijaTH3TQ5qm+sd6g10e0buXDTva5UwNMn1AeqxKQkVmIqBGfR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzg4Dv7mDeGLKaLp0XG46cuxYbNL2/T200MbtHwECUmH3ev9lH
	i5i9AkvRlP1HYkaoDJwL2g/oMvJhymNyJRU6MM4/s+erVjaPg2mVNqyiC6d/ya6WbrWbNGr00TD
	/eiGkbGNmisMLr2nxgTW9OEob2rK4S3Wo
X-Gm-Gg: ASbGncux/QpjmCKwYoOOvNnzxpLS/647nxaX/TRzZEEln3yXczdQm/ePk+Rmc7Vwzny
	+V3t3wmxoicpPP7wWudDgut9ElEt0ktwnNABr+w==
X-Google-Smtp-Source: AGHT+IFGpl6DyQEIMNC3FuLaxbB3hB6Oc3I2JRjdBB7nhX0++cGikvxFVbchrEtz7rG+KdeLRa8vCtFd6RNB6GUgxvc=
X-Received: by 2002:a05:6e02:16cb:b0:3ce:3657:7407 with SMTP id
 e9e14a558f8ab-3ce84a8d3c7mr8324475ab.11.1736901851287; Tue, 14 Jan 2025
 16:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-3-kerneljasonxing@gmail.com> <5480eedb-ceb0-402e-883b-da4207dcc43d@linux.dev>
 <CAL+tcoCn_u_tgYuGbKqp9n1fqao_Yi0ogO8HFcA2TcQcHJOa2w@mail.gmail.com>
 <CAL+tcoA2+MO4WgzHHnX1hhCaQs6afmXWoOXNKf7wrz3QZVeeyA@mail.gmail.com>
 <1a0cdf13-644a-4119-9ad8-e12f81751c79@linux.dev> <CAL+tcoD2OH9Pp6-+iRaKUx7d2AjDgeM7qZjXGV=xurvhXiYrzw@mail.gmail.com>
In-Reply-To: <CAL+tcoD2OH9Pp6-+iRaKUx7d2AjDgeM7qZjXGV=xurvhXiYrzw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Jan 2025 08:43:35 +0800
X-Gm-Features: AbW1kvZgBMXv1QI9plCMT8FgtMkrjGpP-iDJffVvHq_EVJ7fVYD_UtyH7Fo4rD0
Message-ID: <CAL+tcoBdUJSTGKG2UhUtNi6z6CvkYR-QdgWd62K4xGi1RXyqqw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/15] net-timestamp: prepare for bpf prog use
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:37=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Jan 15, 2025 at 8:26=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 1/14/25 4:15 PM, Jason Xing wrote:
> > > On Wed, Jan 15, 2025 at 8:09=E2=80=AFAM Jason Xing <kerneljasonxing@g=
mail.com> wrote:
> > >>
> > >> On Wed, Jan 15, 2025 at 7:40=E2=80=AFAM Martin KaFai Lau <martin.lau=
@linux.dev> wrote:
> > >>>
> > >>> On 1/12/25 3:37 AM, Jason Xing wrote:
> > >>>> Later, I would introduce three points to report some information
> > >>>> to user space based on this.
> > >>>>
> > >>>> Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > >>>> ---
> > >>>>    include/net/sock.h |  7 +++++++
> > >>>>    net/core/sock.c    | 14 ++++++++++++++
> > >>>>    2 files changed, 21 insertions(+)
> > >>>>
> > >>>> diff --git a/include/net/sock.h b/include/net/sock.h
> > >>>> index f5447b4b78fd..dd874e8337c0 100644
> > >>>> --- a/include/net/sock.h
> > >>>> +++ b/include/net/sock.h
> > >>>> @@ -2930,6 +2930,13 @@ int sock_set_timestamping(struct sock *sk, =
int optname,
> > >>>>                          struct so_timestamping timestamping);
> > >>>>
> > >>>>    void sock_enable_timestamps(struct sock *sk);
> > >>>> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> > >>>> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *s=
kb, int op);
> > >>>> +#else
> > >>>> +static inline void bpf_skops_tx_timestamping(struct sock *sk, str=
uct sk_buff *skb, int op)
> > >>>> +{
> > >>>> +}
> > >>>> +#endif
> > >>>>    void sock_no_linger(struct sock *sk);
> > >>>>    void sock_set_keepalive(struct sock *sk);
> > >>>>    void sock_set_priority(struct sock *sk, u32 priority);
> > >>>> diff --git a/net/core/sock.c b/net/core/sock.c
> > >>>> index eae2ae70a2e0..e06bcafb1b2d 100644
> > >>>> --- a/net/core/sock.c
> > >>>> +++ b/net/core/sock.c
> > >>>> @@ -948,6 +948,20 @@ int sock_set_timestamping(struct sock *sk, in=
t optname,
> > >>>>        return 0;
> > >>>>    }
> > >>>>
> > >>>> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_SYSCALL)
> > >>>> +void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *s=
kb, int op)
> > >>>> +{
> > >>>> +     struct bpf_sock_ops_kern sock_ops;
> > >>>> +
> > >>>> +     memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp=
));
> > >>>> +     sock_ops.op =3D op;
> > >>>> +     if (sk_is_tcp(sk) && sk_fullsock(sk))
> > >>>> +             sock_ops.is_fullsock =3D 1;
> > >>>> +     sock_ops.sk =3D sk;
> > >>>> +     __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_=
OPS);
> > >>>
> > >>> hmm... I think I have already mentioned it in the earlier revision
> > >>> (https://lore.kernel.org/bpf/f8e9ab4a-38b9-43a5-aaf4-15f95a3463d0@l=
inux.dev/).
> > >>
> > >> Right, sorry, but I deleted it intentionally.
> > >>
> > >>>
> > >>> __cgroup_bpf_run_filter_sock_ops(sk, ...) requires sk to be fullsoc=
k.
> > >>
> > >> Well, I don't understand it, BPF_CGROUP_RUN_PROG_SOCK_OPS_SK() don't
> > >> need to check whether it is fullsock or not.
> >
> > It is because the callers of BPF_CGROUP_RUN_PROG_SOCK_OPS_SK guarantees=
 it is
> > fullsock.
> >
> > >>
> > >>> Take a look at how BPF_CGROUP_RUN_PROG_SOCK_OPS does it.
> > >>> sk_to_full_sk() is used to get back the listener. For other mini so=
cks,
> > >>> it needs to skip calling the cgroup bpf prog. I still don't underst=
and
> > >>> why BPF_CGROUP_RUN_PROG_SOCK_OPS cannot be used here because of udp=
.
> > >>
> > >> Sorry, I got lost here. BPF_CGROUP_RUN_PROG_SOCK_OPS cannot support
> > >> udp, right? And I think we've discussed that we have to get rid of t=
he
> > >> limitation of fullsock.
> >
> > It is the part I am missing. Why BPF_CGROUP_RUN_PROG_SOCK_OPS cannot su=
pport
> > udp? UDP is not a fullsock?
>
> No, you're not missing anything. UDP is a fullsock and
> BPF_CGROUP_RUN_PROG_SOCK_OPS itself can support udp as my v3 version
> used this method already like you suggest. I feel like
> misunderstanding what you really suggest. Sorry for the trouble
> caused.
>
> I wonder if using is_fullsock would affect/break the usage of fetching
> some fields, especially tcp related fields,  in
> sock_ops_convert_ctx_access()? Sorry that I'm not a bpf expert :(
>
> If not, I will use BPF_CGROUP_RUN_PROG_SOCK_OPS instead.

To be clearer, I would use the following code snippet in the next respin:
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int o=
p)
+{
+       struct bpf_sock_ops_kern sock_ops;
+
+       memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+       sock_ops.op =3D op;
+       sock_ops.is_fullsock =3D 1;
+       sock_ops.sk =3D sk;
+       BPF_CGROUP_RUN_PROG_SOCK_OPS(sk, &sock_ops, CGROUP_SOCK_OPS);
+}

Thanks,
Jason

