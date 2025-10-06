Return-Path: <bpf+bounces-70442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE707BBF2C4
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 22:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC033BF627
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 20:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E4A25B1D2;
	Mon,  6 Oct 2025 20:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="gD+79W3D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F51DE2A5
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781968; cv=none; b=FHTiWv77ZPZIwk8Cz+qvPzDKTlNAI0NvX7s5ahWWWXAmvxniLlumLi4I4mSrzi9tqDdFZpHjwBA0R6tsA9f/ZCLlXCUaG7ucf9Y3e9zoPiIByXECvcklUZdOC93y0HjYZaW+RDJtHv9SsRZFtipwGvXkr11R4bac5SQcFFDGv4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781968; c=relaxed/simple;
	bh=mtgyXz1+isGHbh0TiBzIhlt5T8ZpRb8qC2LSnJmWWeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAV++m9jS7280fbVxgMOSjcck5GIThVikFu8RSuTMSfTg1vMiKCMPo6PaKVJ3eXpzlMr6MaMVG0rdeYT+6AtUm1hJLYolf5GA4vUz88RI72qHWFN489GZFQA3mVPGWKAo6RX0G8Wr1N+y57cc7eqT+YjHqJ5HKiVH0L1NiecIck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=gD+79W3D; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-799a891edfeso1504126d6.3
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1759781966; x=1760386766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csdmtnrcyiyAuomREVcUN5rJ3DbG5lDVgCJERJUkBzU=;
        b=gD+79W3DJmG1466fMsrthDM0us/QQVOb/C6UHzEvnNofP6RypgNPWlFN9qjD3b3qL7
         3Wlb/EH0rMaCxdJIteqo6DRKTQJw/JmeBCOEut+7opXHBnozPLpHY+l/hzJ14mlkCai4
         dWVLFX8xKxenPGW16qewh50k8RBzHPCI/S83r6RJCOTnKeZH8ivD1Oj96JEALNl2Kqa9
         0LxKyf0y2tZX8FVIO5uBrvdTDLDvGDwNfLEjArOA07c3vRQhV3aJafUASp13KGI4NG1U
         aMBjkvBgBF1m70nhff4vIXC4XgXLHFjSqpNWdQB2PApQUbwspbuPgHw9689hqlZ+bQlv
         e6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781966; x=1760386766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csdmtnrcyiyAuomREVcUN5rJ3DbG5lDVgCJERJUkBzU=;
        b=t/TX9IiUox2iHqS8gm2XKCAEsieQNZM/iLGaYyhOMXtVtxMthnedKlYxLr2h4W5hn/
         6tsipE8fpE/dI08uJ7LcrDR8tLlWPfsZLy1dkTYjR751Tlcd9suA7K+6h5Hwyj4SySVw
         hPvbpyvgYv2b6XiQF6meM48phkkCNa30hco/yi+mmFJTc4Hu09gCHYDuvmMYwv+lNLlD
         8c+wQcMaxZhwFmwBYOUzNuS+vb3yysDpYCKksi2v7XG1pd+RMRsr+fuHe6o0kdN9QM6J
         wSyvTBzDNZaFx7AcrcSk4+p7oZKr4oG41tzdBClbU29XkfUebIK28HQZUmoZaSKAUggy
         /oLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCOywSAH+SSn/A/7G95dxnnYJAa4NMiExWCGNQI2aN5myJjHgNhhg1ATKYFkxWmcLqIBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNXwoNRuQJoLe0jw4qXUFROXnFujSJ74Vn3tLR3M8o0nWiMjaM
	lrWMy0Aj0r9MLie00v+o8m3fvMe4oC1Vty4b0TQ86folEOn6PKj2LwDY8Nt2yhbXYdX4MxOhprU
	ll3zAOmnq9CGPGBZuhSnc0/dnpFzNvRjehOhE0rIoxQ==
X-Gm-Gg: ASbGncuRXQDFf92tw4tve9pXddciEViWe9z3aj7gF7mZwsMnVKvTd4mKPSE1Xm/g7Zv
	Kx86ckN3AK9ejeC6qdZ8/zHqCpJSMDI9aILKVd0PUTMr58gYBbAQexygCJ+F/joCmZmzJ7Nm1bt
	Fr+m0fqp6a31Wqs2HPaolx4IwQNhudMeeYLc8fb2hhx64ObTOZw5VCZqjEL/MOhWT/ERDjtnvmH
	7+5rOBIMkM02oMtErdHfiSMLc/RH2mxnTjBwTsI+f3wF3HOgGpZXp+W71iLdXVDfv+tLWL8
X-Google-Smtp-Source: AGHT+IGg+YiJws3ZJsOgcsGhztS53KMiE7vcTi1Vg6OydQkRH+NT3JdbB7naKy8OafjyrFsBoiY6gxMlovrLV8DK1BY=
X-Received: by 2002:a05:6214:2401:b0:789:e48a:fc05 with SMTP id
 6a1803df08f44-879dc884d2dmr120805466d6.6.1759781965606; Mon, 06 Oct 2025
 13:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909170011.239356-1-jordan@jrife.io> <80b309fe-6ba0-4ca5-a0b7-b04485964f5d@linux.dev>
 <ilrnfpmoawkbsz2qnyne7haznfjxek4oqeyl7x5cmtds5sdvxe@dy6fs3ej4rbr> <df4c8852-f6d1-4278-84d8-441aad1f9994@linux.dev>
In-Reply-To: <df4c8852-f6d1-4278-84d8-441aad1f9994@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Mon, 6 Oct 2025 13:19:14 -0700
X-Gm-Features: AS18NWA7rxskNdC_pEVWCkl-GjzDWbVxh5zKV-bu7lMt2te7bZRCASmS91zVePE
Message-ID: <CABi4-ogK1zaupzpRppGEdM0v+4BSJHbrC4Fg=j1zBSGLbkx1rQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/14] bpf: Efficient socket destruction
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Aditi Ghag <aditi.ghag@isovalent.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 3:51=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 9/21/25 9:03 AM, Jordan Rife wrote:
> > Hi Martin,
> >
> > Thanks for taking a look.
> >
> >> How many sockets were destroyed?
> >
> > Between 1 and 5 per trial IIRC during this test. Generally, there would
> > be a small set of sockets to destroy for a given backend relative to th=
e
> > total number UDP/TCP sockets on a system.
> >
> >> For TCP, is it possible to abort the connection in BPF_SOCK_OPS_RTO_CB=
 to
> >> stop the retry? RTO is not a per packet event.
> >
> > To clarify, are you suggesting bpf_sock_destroy() from that context or
> > something else? If the former, bpf_sock_destroy() only works from socke=
t
> > iterator contexts today, so that's one adjustment that would have to be
>
> Regarding how to abort, I was thinking something (simpler?) like having t=
he
> BPF_SOCK_OPS_RTO_CB prog to enforce the "expired" logic in the
> tcp_write_timeout() by using the prog's return value. The caveat is the r=
eturn
> value of the BPF_SOCK_OPS_RTO_CB prog is currently ignored, so it may
> potentially break existing use cases. However, I think only checking retv=
al =3D=3D
> ETIMEOUT should be something reasonable. The retval can be set by
> bpf_set_retval(). I have only briefly looked at tcp_write_timeout, so ple=
ase check.

After thinking about this some more, I like the idea of handling
socket destruction inside a callback like this, since it avoids the
extra memory and bookkeeping needed to maintain another data structure
as with the explicit iteration approach. I'm imagining the logic would
look something like this for the use case I have in mind:

switch (op) {
case BPF_SOCK_OPS_RTO_CB:
    /* backend_id is derived from the socket's daddr + dport */
    v =3D bpf_map_lookup_elem(&backends_map, &backend_id);
    if (!v) /* backend no longer exists */
        /* either bpf_sock_destroy or return -ETIMEOUT */
    break;
}

I'll have to think more about the use case and see if there's anything
I'm missing, but on the face of it this seems like it would work well
(at least for TCP). I have some doubts about the ETIMEOUT thing vs
just extending bpf_sock_destroy to work for both TCP and UDP contexts
(more on this below).

> The bpf_sock_destroy() may also work but a few things need to be
> considered/adjusted. Its tcp_send_active_reset() seems unnecessary during=
 RTO.
> Maybe only tcp_done_with_err() is enough which seems to be a new kfunc it=
self.
> It also needs bh_lock_sock() which I am not sure it is true for all sock_=
ops
> callback. This could be tricky to filter out by the cb enum. Passing "str=
uct
> bpf_sock_ops *" instead of "struct sock *" to a new kfunc seems not gener=
ic
> enough. It also has a tcp_set_state() call which will recur to the
> BPF_SOCK_OPS_STATE_CB prog. This can use more thought if the above "expir=
ed"
> idea in tcp_write_timeout() does not work out.

Yeah, this is a bit tricky. I'll have to think a bit more about how
this would work. The ETIMEOUT thing would work for TCP, but if I'm
trying to extend this to UDP sockets I think you may need an explicit
bpf_sock_destroy() call anyway? And if you're making
bpf_sock_destroy() work in that context then maybe supporting ETIMEOUT
is redundant?

> [ Unrelated, but in case it needs a new BPF_SOCK_OPS_*_CB enum. I would m=
ostly
> freeze any new BPF_SOCK_OPS_*_CB addition and requiring to move the bpf_s=
ock_ops
> to the struct_ops infrastructure first before adding new ops. ]

Thanks, I'll look into this. One aspect I'm uncertain about is
applying this kind of approach to UDP sockets. The BPF_SOCK_OPS_RTO_CB
callback provides a convenient place to handle this for TCP, but UDP
doesn't exactly have any timeouts where a similar callback makes
sense. Instead, you'd need to have something like a callback for UDP
that executes on every sendmsg call where you run some logic similar
to the code above. This is less ideal, since you need to do extra work
on every sendmsg call instead of just when a timeout occurs as with
BPF_SOCK_OPS_RTO_CB, but maybe the extra cost here would be
negligible. Combined, I imagine something like this:

switch (op) {
case BPF_SOCK_OPS_RTO_CB:
case BPF_SOCK_OPS_UDP_SENDMSG_CB:
    /* backend_id is derived from the socket's daddr + dport */
    v =3D bpf_map_lookup_elem(&backends_map, &backend_id);
    if (!v) { /* backend no longer exists */
        if (sockop =3D=3D BPF_SOCK_OPS_RTO_CB)
            /* return -ETIMEOUT or maybe just bpf_sock_destroy? */
        else
            bpf_sock_destroy()
    }
    break;
}

> > made. It seems like this could work, but I'd have to think more about
> > how to mark certain sockets for destruction (possibly using socket
> > storage or some auxiliary map).
>
> The BPF_SOCK_OPS_RTO_CB should have the sk which then should have all 4 t=
uples
> for an established connection.
>
>
> >> Before diving into the discussion whether it is a good idea to add ano=
ther
> >> key to a bpf hashmap, it seems that a hashmap does not actually fit yo=
ur use
> >> case. A different data structure (or at least a different way of group=
ing
> >> sk) is needed. Have you considered using the
> >
> > If I were to design my ideal data structure for grouping sockets
> > (ignoring current BPF limitations), it would look quite similar to the
> > modified SOCK_HASH in this series. Really what would be ideal is
> > something more like a multihash where a single key maps to a set of
> > sockets, but that felt much too specific to this use case and doesn't
> > fit well within the BPF map paradigm. The modification to SOCK_HASH wit=
h
> > the key prefix stuff kind of achieves and felt like a good starting
> > point.
>
> imo, I don't think it justifies to cross this bridge only for sock_hash m=
ap and
> then later being copied to other bpf map like xsk/dev/cpumap...etc. Lets =
stay
> with the existing bpf map semantic. The bpf rb/list/arena is created for =
this.
> Lets try it and improve what is missing.

Yeah, makes sense.

>   >
> >> bpf_list_head/bpf_rb_root/bpf_arena? Potentially, the sk could be stor=
ed as
> >> a __kptr but I don't think it is supported yet, aside from considerati=
ons
> >> when sk is closed, etc. However, it can store the numeric ip/port and =
then
> >> use the bpf_sk_lookup helper, which can take netns_id. Iteration could
> >> potentially be done in a sleepable SEC("syscall") program in test_prog=
_run,
> >> where lock_sock is allowed. TCP sockops has a state change callback (i=
.e.
> >
> > You could create a data structure tailored for efficient iteration over
> > a group of ip/port pairs, although I'm not sure how you would acquire
> > the socket lock unless, e.g., bpf_sock_destroy or a sleepable variant
> > thereof acquires the lock itself in that context after the sk lookup?
> > E.g. (pseudocode):
> >
> > ...
> > for each (ip,port,ns) in my custom data structure:
> >      sk =3D bpf_sk_lookup_tcp(ip, port, ns)
> >      if (sk)
> >       bpf_sock_destroy_sleepable(sk) // acquires socket lock?
> > ...
> >
>
> The verifier could override the kfunc call to another function pointer bu=
t I am
> not sure we should complicate verifier further for this case, so adding a
> bpf_sock_destroy_sleepable() is fine, imo. Not sure about the naming thou=
gh, may
> be bpf_sock_destroy_might_sleep()?

I think using socket callbacks like BPF_SOCK_OPS_RTO_CB would make for
a more elegant solution and wouldn't require as much bookkeeping,
provided we can work something similar out for UDP. This would make
any rb/list/arena manipulation and a sleepable variant of
bpf_sock_destroy unnecessary. Maybe it's worth exploring that
direction first?

Thanks!

Jordan

