Return-Path: <bpf+bounces-45451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4507A9D5AD3
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 09:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04976283C7C
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F89A18C033;
	Fri, 22 Nov 2024 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IblTUbJc"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9218A94C
	for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732263215; cv=none; b=MdblqXEI3Pl3JILgzbT0W6Ju2jqUW/yO3yXpXNksjAPHKOA+0FhzghtWvu9OcmO0cyGKjBjG8rgP9lBZin38bTyoGPJwzsjAjzyDmAt+XAqcliGQQRaOl6ZiFQUuAjB3StY4msKP3+u+/NFE1dSfQ3tpc6R7xsUhoFZpY4lvl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732263215; c=relaxed/simple;
	bh=JCxji8+zZEwg3Qp6iHQDZxtQInqv5sJnQ+PuEwTDVrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVGeNIW/8yiquTOTuLeTftyKi/yked+fAx+Mt3mQmGh4E6cxGEt0xRPRe3pC02BsVo5y9v++8yFAyR/BEc7naTZan9B6teNAU3E+HOYrRWo53my+HrqapPdvVksyHdcsstzTMSnLir+LFJRishB9tV2f1jGa16bL1s6R/V40ybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IblTUbJc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732263211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jyif/vwioQZSx22jeV7A3meclVkznYeYdCGV00kxmmo=;
	b=IblTUbJceemp4PUG3LBKNjPa5xEjIJ41lN204pbxGIka0zPrBVzVbLtJy3UMazxkqTkAXj
	3HqlP9MMpkbyZfxmOqCgoQMNRi7jh+QvWrW5I1jGiPrcKNV9ko5Ge9hMWtHETFxtiK9u22
	cnG4NDdVV7rzSCS+36/56DBY33PCowo=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-6C_OhSFjOdutc1-_6ZBYlQ-1; Fri, 22 Nov 2024 03:13:30 -0500
X-MC-Unique: 6C_OhSFjOdutc1-_6ZBYlQ-1
X-Mimecast-MFC-AGG-ID: 6C_OhSFjOdutc1-_6ZBYlQ
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e3891f31330so3272873276.3
        for <bpf@vger.kernel.org>; Fri, 22 Nov 2024 00:13:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732263210; x=1732868010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jyif/vwioQZSx22jeV7A3meclVkznYeYdCGV00kxmmo=;
        b=MWU0vwLI/GirD0e0gVg1OV1/oSTRANtOIoFagyvrHNO6ha7IxjJ/nzc6LkJgdT62J5
         WGZ8ZnpfHaZQknPIRPJOJ9XtT4kEwQOX6F7d3u69L2zHuYYCRjKk7mQd54679qbN1di7
         Gh5DSDrCiJF3H4IhgZSjxqpBVhhMmwS6TAB6B+vOCFqomJDr1sGZGe/pw2nlEpDdZT7b
         M5uj9ve+8wy3MKA6KWOEVIHcNpTsbr9tFwadvPgCTaD2gYk1VblI8x5fDQZ2ycnymm3W
         cZJOKx/SI6zhGvBHLEqyrC8x8gj0T24NkD/HiYWxGBQN9/co1/R6MAM11Jo9+1+WoPSk
         ceYg==
X-Forwarded-Encrypted: i=1; AJvYcCVDBHRlAWStcruY6PUWYa1m6hZo5wCe0qPtLNIqV7U10Q2rrCMLDheaeQ8/UtNCrQ4MGvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzievmFGYBDGhDBE1lJbOHkAMVuTD0srACfwhRZPS1wvWWAkehP
	Fv3J08N1wFdE3UFg8lffrCCAWTnQ/8OQ4i++TBZW9j2FQtzSffs6g7abAl2ZkKTjQEakEpXpMnn
	1iKuG8g1S/8cOFMRdDY1bz3+wvrk11RgbPz/zrmAmHHfkMbsu7YPgsYUBaROn8sWThoB0KyMG5i
	ftp0XkXbcm4m7lxQz0dcuwvCpP
X-Gm-Gg: ASbGncvJjLuiEih1DOzjt/axjBeEMK3pCu1/Vvgk80ssYBWUc3uZz8LX4/PZ3FNw1i2
	lrAX3+Prx7jMQzTy0YXTxZaZ9PSobt2g=
X-Received: by 2002:a05:6902:1a47:b0:e38:c0ed:8110 with SMTP id 3f1490d57ef6-e38f8af84afmr1719576276.8.1732263209932;
        Fri, 22 Nov 2024 00:13:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKRhMEchEwv851aJVBwXS4rpjG90mS+TEvahOSXsiWvE5DyfFNG4Z+Ig23pjG3EVB8nsNtJzWE+ExjTpdJI/I=
X-Received: by 2002:a05:6902:1a47:b0:e38:c0ed:8110 with SMTP id
 3f1490d57ef6-e38f8af84afmr1719537276.8.1732263209529; Fri, 22 Nov 2024
 00:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <20241118-vsock-bpf-poll-close-v1-3-f1b9669cacdc@rbox.co> <7wufhaaytdjp3m3xv7jrdadqjg75is5eirv4bzmjzmezc7v7ls@p52fm6y537di>
 <350e3a3f-7ebd-471e-95fa-05225d786f1c@rbox.co>
In-Reply-To: <350e3a3f-7ebd-471e-95fa-05225d786f1c@rbox.co>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 22 Nov 2024 09:13:18 +0100
Message-ID: <CAGxU2F5M9Mzpef4ef7NXCR2YP=k_SC93GC_k9CMj1DgVSkpQSw@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf, vsock: Invoke proto::close on close()
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 8:54=E2=80=AFPM Michal Luczaj <mhal@rbox.co> wrote:
>
> On 11/21/24 10:22, Stefano Garzarella wrote:
> > On Mon, Nov 18, 2024 at 10:03:43PM +0100, Michal Luczaj wrote:
> >> vsock defines a BPF callback to be invoked when close() is called. How=
ever,
> >> this callback is never actually executed. As a result, a closed vsock
> >> socket is not automatically removed from the sockmap/sockhash.
> >>
> >> Introduce a dummy vsock_close() and make vsock_release() call proto::c=
lose.
> >>
> >> Note: changes in __vsock_release() look messy, but it's only due to in=
dent
> >> level reduction and variables xmas tree reorder.
> >>
> >> Fixes: 634f1a7110b4 ("vsock: support sockmap")
> >> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> >> ---
> >> net/vmw_vsock/af_vsock.c | 67 +++++++++++++++++++++++++++++-----------=
--------
> >> 1 file changed, 40 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >> index 919da8edd03c838cbcdbf1618425da6c5ec2df1a..b52b798aa4c2926c3f233a=
ad6cd31b4056f6fee2 100644
> >> --- a/net/vmw_vsock/af_vsock.c
> >> +++ b/net/vmw_vsock/af_vsock.c
> >> @@ -117,12 +117,14 @@
> >> static int __vsock_bind(struct sock *sk, struct sockaddr_vm *addr);
> >> static void vsock_sk_destruct(struct sock *sk);
> >> static int vsock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
> >> +static void vsock_close(struct sock *sk, long timeout);
> >>
> >> /* Protocol family. */
> >> struct proto vsock_proto =3D {
> >>      .name =3D "AF_VSOCK",
> >>      .owner =3D THIS_MODULE,
> >>      .obj_size =3D sizeof(struct vsock_sock),
> >> +    .close =3D vsock_close,
> >> #ifdef CONFIG_BPF_SYSCALL
> >>      .psock_update_sk_prot =3D vsock_bpf_update_proto,
> >> #endif
> >> @@ -797,39 +799,37 @@ static bool sock_type_connectible(u16 type)
> >>
> >> static void __vsock_release(struct sock *sk, int level)
> >> {
> >> -    if (sk) {
> >> -            struct sock *pending;
> >> -            struct vsock_sock *vsk;
> >> -
> >> -            vsk =3D vsock_sk(sk);
> >> -            pending =3D NULL; /* Compiler warning. */
> >> +    struct vsock_sock *vsk;
> >> +    struct sock *pending;
> >>
> >> -            /* When "level" is SINGLE_DEPTH_NESTING, use the nested
> >> -             * version to avoid the warning "possible recursive locki=
ng
> >> -             * detected". When "level" is 0, lock_sock_nested(sk, lev=
el)
> >> -             * is the same as lock_sock(sk).
> >> -             */
> >> -            lock_sock_nested(sk, level);
> >> +    vsk =3D vsock_sk(sk);
> >> +    pending =3D NULL; /* Compiler warning. */
> >>
> >> -            if (vsk->transport)
> >> -                    vsk->transport->release(vsk);
> >> -            else if (sock_type_connectible(sk->sk_type))
> >> -                    vsock_remove_sock(vsk);
> >> +    /* When "level" is SINGLE_DEPTH_NESTING, use the nested
> >> +     * version to avoid the warning "possible recursive locking
> >> +     * detected". When "level" is 0, lock_sock_nested(sk, level)
> >> +     * is the same as lock_sock(sk).
> >> +     */
> >> +    lock_sock_nested(sk, level);
> >>
> >> -            sock_orphan(sk);
> >> -            sk->sk_shutdown =3D SHUTDOWN_MASK;
> >> +    if (vsk->transport)
> >> +            vsk->transport->release(vsk);
> >> +    else if (sock_type_connectible(sk->sk_type))
> >> +            vsock_remove_sock(vsk);
> >>
> >> -            skb_queue_purge(&sk->sk_receive_queue);
> >> +    sock_orphan(sk);
> >> +    sk->sk_shutdown =3D SHUTDOWN_MASK;
> >>
> >> -            /* Clean up any sockets that never were accepted. */
> >> -            while ((pending =3D vsock_dequeue_accept(sk)) !=3D NULL) =
{
> >> -                    __vsock_release(pending, SINGLE_DEPTH_NESTING);
> >> -                    sock_put(pending);
> >> -            }
> >> +    skb_queue_purge(&sk->sk_receive_queue);
> >>
> >> -            release_sock(sk);
> >> -            sock_put(sk);
> >> +    /* Clean up any sockets that never were accepted. */
> >> +    while ((pending =3D vsock_dequeue_accept(sk)) !=3D NULL) {
> >> +            __vsock_release(pending, SINGLE_DEPTH_NESTING);
> >> +            sock_put(pending);
> >>      }
> >> +
> >> +    release_sock(sk);
> >> +    sock_put(sk);
> >> }
> >>
> >> static void vsock_sk_destruct(struct sock *sk)
> >> @@ -901,9 +901,22 @@ void vsock_data_ready(struct sock *sk)
> >> }
> >> EXPORT_SYMBOL_GPL(vsock_data_ready);
> >>
> >> +/* Dummy callback required by sockmap.
> >> + * See unconditional call of saved_close() in sock_map_close().
> >> + */
> >> +static void vsock_close(struct sock *sk, long timeout)
> >> +{
> >> +}
> >> +
> >> static int vsock_release(struct socket *sock)
> >> {
> >> -    __vsock_release(sock->sk, 0);
> >> +    struct sock *sk =3D sock->sk;
> >> +
> >> +    if (!sk)
> >> +            return 0;
> >
> > Compared with before, now we return earlier and so we don't set SS_FREE=
,
> > could it be risky?
> >
> > I think no, because in theory we have already set it in a previous call=
,
> > right?
>
> Yeah, and is there actually a way to call vsock_release() for a second
> time? The only caller I see is __sock_release(), which won't allow that.

Maybe no, but the `sock->sk` check made me think so.

>
> As for the sockets that never had ->sk assigned, I assume it doesn't matt=
er.

Yep, so my R-b stays here ;-)

Thanks for these great fixes,
Stefano

>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> >
> >> +
> >> +    sk->sk_prot->close(sk, 0);
> >> +    __vsock_release(sk, 0);
> >>      sock->sk =3D NULL;
> >>      sock->state =3D SS_FREE;
>


