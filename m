Return-Path: <bpf+bounces-49755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45647A1C089
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CA33A784D
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38943204F75;
	Sat, 25 Jan 2025 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8NAo8j5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D483204C37;
	Sat, 25 Jan 2025 02:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737773929; cv=none; b=kLJ52Voxqj51oKLAROcifwRDc6hFuQghCAZA8DiqvkmwjAk8MMXevMSE2tul4CiUOKGXFS3AY5gh2HFkePEwKSQHQEmtpBKxcpH6lfg3r7iSDvweiMDz8gh1n+FL4TEisEs/q1NUvvfyGo7xDDZDMWiIdcLfECkiewMyeRt0pHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737773929; c=relaxed/simple;
	bh=N7VoUryuA7sIX+pVXuLj6ZpsCi0C4e+/AkR/yG4qnK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJLXdvrCFZw5Nu+rzK2V05bFkAslQrhtDT7c5pZLjs86LSriYpCtQgRZ3r3LI7A0ijeHbsQP2+UasHiKGGldftOZ6HU61FUThFB/fj48BhFJKNEyAp2N6OmBqYbqgGCAXksj8qTlwSb8mH8rBHx4Pi0WjthCnFHTolcR1z88zKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8NAo8j5; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a813899384so6881585ab.1;
        Fri, 24 Jan 2025 18:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737773927; x=1738378727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bTn4zUNpYFMsXDLN2wHTNTTj0FmMEBfbipnA2KTqt0=;
        b=R8NAo8j5M2m/Pk8Wk/RdkKoMjUHCKt6aHYrxwUXAcGm3m25EvB5Qa2ZQIyK2SGaRJ2
         L2rBotcUXoHpRQ14huWWo/l90FlZT+aQsqT/kn0+5oFaxC/r8xpN0eeGAgfE5Io6uEBh
         o90PC+DIvHagh4Q2G47oF+Sy6C85BoecM1QEyPVFvn/NixnGYGVLQ52H+SJOP5ScSStP
         6XMgkcQDz8Knc6hJY351/TJ+7rlVSV4cUBtWtYVnf3hEqbrG8T6pkK+DMukHlDTGLt9u
         nkyunYYzS6Ci3PJArPHlrnT9wxn/RR/mQOuxhGNDDXTecWC4ZeJOQxpz6nifPRLM4NNX
         J0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737773927; x=1738378727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bTn4zUNpYFMsXDLN2wHTNTTj0FmMEBfbipnA2KTqt0=;
        b=RwNwf5gLEGecSCFkcEsuFLxvjucQ8K2fcZGtSABju3jWODqDXwFbw3l1NPzvIQmuvp
         KDAW/T9NhMBeoCyBnGp+qaeqJH9IESOLjJbDvVaAgqLqhmit9DZRM1qapO15xCO5RA2c
         TLPimxYW73G4TFAY9de28HyOPML5G09E/o+qzOcx1lyD+wE64Mq2/b9+K++0Se+jb20m
         3ZPtS0s0ubT/XYPiJiBA6Cn6eyGYB95hQCkyzRrBdBz82my1KPGcV3BD4sEj173HJv/U
         BBhXoU/vTWLgYu4FbX/GOX/gyYWU194ofcdaE8DJsaV4iJ4sIw+YRqpCG6iJA6prG98X
         QqNA==
X-Forwarded-Encrypted: i=1; AJvYcCW8CWx1LLf+uRvmnUWfvWUatodQRUJFBAy228sE550S++fpKXfqyOQhISqfCoCPTlLlzKdyU99k@vger.kernel.org, AJvYcCWjohZ/QoVFl76r4u8P9SnValJwee0jsS0/rpq5WdCeYqIB47dJoN4kuG1o1tc8+X7MtCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5S4ktpTuLQzseOUzQkhMi8bacV68Zd+bRE4CHSALATmpq6LKI
	eXY1sBWUSqihOZtvY3jHWwHuaBn3tKgMHdsOx8orBcL0CmxCGlDMc+m0QZa0VIPW1plFATuLxpI
	wJC+OYucw96FZIasUaNqN+3DEenA=
X-Gm-Gg: ASbGncuhKzgEKmRB7sPSzRFe6gLzaF5sVf+RytvXCHkXYJy+1Ycu+68fROkNppsc1An
	jRuwp3IMrwe4eiSW8p72TWx9yWyCEqMG4qfAm/IzN3LBAWoaSkJgBm6DJBQ6X3Q==
X-Google-Smtp-Source: AGHT+IFq9QgQHhrVq1jdZZ0ZYwpUV3fw7KfbRa7cCmzWgzVZKZZdQbxzYCPAahSxMLn4rDoDUarXo/nsCEoapMzULDs=
X-Received: by 2002:a05:6e02:3f90:b0:3cf:c85c:4f60 with SMTP id
 e9e14a558f8ab-3cfc85c503fmr47108485ab.11.1737773927078; Fri, 24 Jan 2025
 18:58:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-5-kerneljasonxing@gmail.com> <1c2f4735-bddb-4ce7-bd0a-5dbb31cb0c45@linux.dev>
 <CAL+tcoAXgeSNb3PNdqLxd1amryQ7FNT=8OQampZFL9LzdPmBrA@mail.gmail.com> <331cec22-3931-4723-aa5a-03d8a9dc6040@linux.dev>
In-Reply-To: <331cec22-3931-4723-aa5a-03d8a9dc6040@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 10:58:10 +0800
X-Gm-Features: AWEUYZnJeh8rtUN1Pc2C2tp3CD5AydYwZVaivRk8Afiq07R-iO4ZQGI2PA-Q7_c
Message-ID: <CAL+tcoANvM3hD6avRm+j_jf5XkW8NaqtSYXxcfEcx3xGnmqKVg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 04/13] bpf: stop UDP sock accessing TCP
 fields in sock_op BPF CALLs
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

On Sat, Jan 25, 2025 at 10:26=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 1/24/25 5:15 PM, Jason Xing wrote:
> >>> +static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_soc=
k)
> >>> +{
> >>> +     return bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
> >>
> >> More bike shedding...
> >>
> >> After sleeping on it again, I think it can just test the
> >> bpf_sock->allow_tcp_access instead.
> >
> > Sorry, I don't think it can work for all the cases because:
> > 1) please see BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_LEN_CB=
,
> > if req exists, there is no allow_tcp_access initialization. Then
> > calling some function like bpf_sock_ops_setsockopt will be rejected
> > because allow_tcp_access is zero.
> > 2) tcp_call_bpf() only set allow_tcp_access only when the socket is
> > fullsock. As far as I know, all the callers have the full stock for
> > now, but in the future it might not.
>
> Note that the existing helper bpf_sock_ops_cb_flags_set and
> bpf_sock_ops_{set,get}sockopt itself have done the sk_fullsock() test and=
 then
> return -EINVAL. bpf_sock->sk is fullsock or not does not matter to these =
helpers.
>
> You are right on the BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_L=
EN_CB
> but the only helper left that testing allow_tcp_access is not enough is
> bpf_sock_ops_load_hdr_opt(). Potentially, it can test "if
> (!bpf_sock->allow_tcp_access && !bpf_sock->syn_skb) { return -EOPNOTSUPP;=
 }".
>
> Agree to stay with the current "bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HDR_=
OPT_CB"
> as in this patch. It is cleaner.
>
> >>> @@ -5673,7 +5678,12 @@ static const struct bpf_func_proto bpf_sock_ad=
dr_getsockopt_proto =3D {
> >>>    BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bp=
f_sock,
> >>>           int, level, int, optname, char *, optval, int, optlen)
> >>>    {
> >>> -     return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, op=
tlen);
> >>> +     struct sock *sk =3D bpf_sock->sk;
> >>> +
> >>> +     if (is_locked_tcp_sock_ops(bpf_sock) && sk_fullsock(sk))
> >>
> >> afaict, the new timestamping callbacks still can do setsockopt and it =
is
> >> incorrect. It should be:
> >>
> >>          if (!bpf_sock->allow_tcp_access)
> >>                  return -EOPNOTSUPP;
> >>
> >> I recalled I have asked in v5 but it may be buried in the long thread,=
 so asking
> >> here again. Please add test(s) to check that the new timestamping call=
backs
> >> cannot call setsockopt and read/write to some of the tcp_sock fields t=
hrough the
> >> bpf_sock_ops.
> >>
> >>> +             sock_owned_by_me(sk);
> >>
> >> Not needed and instead...
> >
> > Sorry I don't get you here. What I was doing was letting non
> > timestamping callbacks be checked by the sock_owned_by_me() function.
> >
> > If the callback belongs to timestamping, we will skip the check.
>
> It will skip the sock_owned_by_me() test and
> continue to do the following __bpf_setsockopt() which the new timetamping
> callback should not do, no?
>
> It should be just this at the very beginning of bpf_sock_ops_setsockopt:
>
>         if (!is_locked_tcp_sock_ops(bpf_sock))
>                 return -EOPNOTSUPP;
> >
> >>
> >>> +
> >>> +     return __bpf_setsockopt(sk, level, optname, optval, optlen);
> >>
> >> keep the original _bpf_setsockopt().
> >
> > Oh, I remembered we've already assumed/agreed the timestamping socket
> > must be full sock. I will use it.
> >
> >>
> >>>    }
> >>>
> >>>    static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto =
=3D {
> >>> @@ -5759,6 +5769,7 @@ BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_=
sock_ops_kern *, bpf_sock,
> >>>           int, level, int, optname, char *, optval, int, optlen)
> >>>    {
> >>>        if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP &&
> >>> +         bpf_sock->sk->sk_protocol =3D=3D IPPROTO_TCP &&
> >>>            optname >=3D TCP_BPF_SYN && optname <=3D TCP_BPF_SYN_MAC) =
{
> >>
> >> No need to allow getsockopt regardless what SOL_* it is asking. To kee=
p it
> >> simple, I would just disable both getsockopt and setsockopt for all SO=
L_* for
> >
> > Really? I'm shocked because the selftests in this series call
> > bpf_sock_ops_getsockopt() and bpf_sock_ops_setsockopt() in patch
> > [13/13]:
>
> Yes, really. It may be late Friday for me here. Please double check your =
test if
> the bpf_set/getsockopt is called from the new timestamp callback or it is=
 only
> called from the existing BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB callback.

Oh, after reading the above a few times, I finally realized you're
right. I'll do it. Thanks!!

>
> Note that I am only asking to disable the set/getsockopt,
> bpf_sock_ops_cb_flags_set, and the bpf_sock_ops_load_hdr_opt for the new
> timestamping callbacks.

Right, right!

Thanks,
Jason

