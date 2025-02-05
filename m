Return-Path: <bpf+bounces-50523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0188FA29539
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBD97167163
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098E3190052;
	Wed,  5 Feb 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6jQ9S54"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB71519B1;
	Wed,  5 Feb 2025 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770659; cv=none; b=UMg2Rt9LXX3MX+bb8qiCCRo9f8tqZCniYx3uvNqYQpmH5UT1mmvPZlZDopsGxDUzBIAOmqTJi9tWTsXi8UPhmsEqhdKsYuqNLd0HgH/mvsCc/033wMMpuIHrATn6rWjexQF2F+XVCjtMXhE7f1fO2E3igTOXMAkngQf0QSdnVzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770659; c=relaxed/simple;
	bh=enYcw7+NcVuaWBTGZbs5Btv7bqj8LH5vg2Bob0DJKgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGH56/yYFKXgFhShakql/wcbGP2AdET0RTWyAolteoBiQUsFYc3ssznm5SEdduz/TeDhuYBpfD5iyBPxIB78TfQZnBBAmsjcVSDapzfUPwR7oNxZYdOh/HQmJl3tgfKgbCTW8LtoffXy7Q+n9dNvQEyj/qMsqOzy/1B2ap99q9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6jQ9S54; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d01fe20598so17960415ab.3;
        Wed, 05 Feb 2025 07:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738770657; x=1739375457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRJur1NWPFJmx17ukt71CqjYG66Syo9BTG5AKbNm/2A=;
        b=Q6jQ9S54Ru7YgF051Rrp64yzyIyq+/vdpk6GgZTfgzOBu7pf85I6wcww/JOUcERo0v
         U6qxjrG7SpoIHqe1mzPZL6FTTFhvhhJoM1MQID4YRTEKpm8WLFqSsy7tlKi8LMug2kLn
         Snjq4f1NdqxpMDUABZHBIV9mo26I+4kknBkXob4xKSh7GtAgWqef56I/mXEUuDbcg13u
         AUUsnzm4AiM68TkIAfYZWJDudnfbBgK4cAUl6Pq0Hq3/G/03tLy8XsICqwiVjwlWN2qK
         YurfWnajbfwcD4SjSiCowj+JaZFA2HhFXL92RTmO70jeWH3nUldj35KJYdD5TUOm9n7x
         r9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770657; x=1739375457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRJur1NWPFJmx17ukt71CqjYG66Syo9BTG5AKbNm/2A=;
        b=Y/N4krt8AAbw2zPckzNi/9o5hAUoAu/fw2Vh9YNCYmN4jwjinwR7enNHGyJWn96SDL
         a2Vb3SsriJWJHXvAkHNA2Gh/EvPf+rp8CoKxTj2m2Bi+QHVyHZ61m4NNTyy5bBWHvyAS
         osP3sRAbejnSD2bT95mDWGZCwtUmS2ob6n9wQaqDpUqhTNpv6DdMefn5A/M49uE22s5n
         KQY+sWI4wA8rXOxvvR2odvElh7HPW99lPO5GzRfu4aYF5RqBxj+vFYuDy5Uic8W8OMT4
         vwFrxodNjH53tQ8T3URRcMCBfO/p42pYnKXwg7ZEGTsrFSAa+B10NcGGuiuthUb8Cyzm
         68Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWH9pumQEeVgUR8of6PFO5ZfKc0WqgfSsOkQ6FISyvelD+xSSzewnGKCHNpcB0++u8l51JkSftA@vger.kernel.org, AJvYcCWhyEruQVxGmaQA1TzsnyWP9wZZuFwSgR7+JrJOQHhbf2Evvnfj/23Q4cweOZyba5MRYdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3iUPgAjQjYK//zzDND9pnB+TuGnU91V4GUfVCaLIbK+WkqJC3
	APsVP+1vyLaT8mdIPn1/xz1az9wl6w0nKzROPY9Uz+QgSlbLwzveByIQLQX9QGti2VEoROgAYwh
	LdwLPRpM8i43lYN9nUk91aYPlSeA=
X-Gm-Gg: ASbGncuokLiGb9PNYxVVMbPsNaDXlMy5d3F7cl3KoEEdXksjA3Q52v1mbMfGVjijUkD
	Xbvum3KhVGiiNkupciCmaCPDcbKndUCpysF43m5sQgGSYeMox9l+HSUnTB/mPukKN55I/pDU=
X-Google-Smtp-Source: AGHT+IHGt/NrxATtpUDUEJgkATciQsxeLvZjjwhtTdVh/7272DBhzWVcQ+o/YQ1uWb2TRvEy2mHS0VgM2shRlaolsd4=
X-Received: by 2002:a05:6e02:2163:b0:3d0:2331:f809 with SMTP id
 e9e14a558f8ab-3d04f3ff768mr34018775ab.2.1738770656988; Wed, 05 Feb 2025
 07:50:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-5-kerneljasonxing@gmail.com> <67a3830cbe106_14e083294f9@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a3830cbe106_14e083294f9@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 23:50:19 +0800
X-Gm-Features: AWEUYZlxeznu0a2Q7RvmDQzQATYdTRiOoygS_8k_p5cxnZwZRi30VHN50uCeLZw
Message-ID: <CAL+tcoD6fAhqUABGL-ERn-AZZtm0kEq587a607vz3f7b6kTo5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 04/12] bpf: stop calling some sock_op BPF
 CALLs in new timestamping callbacks
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:26=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Simply disallow calling bpf_sock_ops_setsockopt/getsockopt,
> > bpf_sock_ops_cb_flags_set, and the bpf_sock_ops_load_hdr_opt for
> > the new timestamping callbacks for the safety consideration.
>
> Please reword this: Disallow .. unless this is operating on a locked
> TCP socket. Or something along those lines.

Will adjust it.

>
> > Besides, In the next round, the UDP proto for SO_TIMESTAMPING bpf
> > extension will be supported, so there should be no safety problem,
> > which is usually caused by UDP socket trying to access TCP fields.
>
> Besides is probably the wrong word here: this is not an aside, but
> the actual reason for this test, if I follow correctly.

Right, will fix it. Thanks.

>
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  net/core/filter.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index dc0e67c5776a..d3395ffe058e 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5523,6 +5523,11 @@ static int __bpf_setsockopt(struct sock *sk, int=
 level, int optname,
> >       return -EINVAL;
> >  }
> >
> > +static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
> > +{
> > +     return bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
> > +}
> > +
> >  static int _bpf_setsockopt(struct sock *sk, int level, int optname,
> >                          char *optval, int optlen)
> >  {
> > @@ -5673,6 +5678,9 @@ static const struct bpf_func_proto bpf_sock_addr_=
getsockopt_proto =3D {
> >  BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_so=
ck,
> >          int, level, int, optname, char *, optval, int, optlen)
> >  {
> > +     if (!is_locked_tcp_sock_ops(bpf_sock))
> > +             return -EOPNOTSUPP;
> > +
> >       return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optl=
en);
> >  }
> >
> > @@ -5758,6 +5766,9 @@ static int bpf_sock_ops_get_syn(struct bpf_sock_o=
ps_kern *bpf_sock,
> >  BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_sock_ops_kern *, bpf_so=
ck,
> >          int, level, int, optname, char *, optval, int, optlen)
> >  {
> > +     if (!is_locked_tcp_sock_ops(bpf_sock))
> > +             return -EOPNOTSUPP;
> > +
> >       if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP &&
> >           optname >=3D TCP_BPF_SYN && optname <=3D TCP_BPF_SYN_MAC) {
> >               int ret, copy_len =3D 0;
> > @@ -5800,6 +5811,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_=
sock_ops_kern *, bpf_sock,
> >       struct sock *sk =3D bpf_sock->sk;
> >       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> >
> > +     if (!is_locked_tcp_sock_ops(bpf_sock))
> > +             return -EOPNOTSUPP;
> > +
> >       if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> >               return -EINVAL;
> >
> > @@ -7609,6 +7623,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_=
sock_ops_kern *, bpf_sock,
> >       u8 search_kind, search_len, copy_len, magic_len;
> >       int ret;
> >
> > +     if (!is_locked_tcp_sock_ops(bpf_sock))
> > +             return -EOPNOTSUPP;
> > +
> >       /* 2 byte is the minimal option len except TCPOPT_NOP and
> >        * TCPOPT_EOL which are useless for the bpf prog to learn
> >        * and this helper disallow loading them also.
> > --
> > 2.43.5
> >
>
>

