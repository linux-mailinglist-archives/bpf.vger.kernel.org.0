Return-Path: <bpf+bounces-12428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC907CC5AB
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3691C206FD
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBA543A9F;
	Tue, 17 Oct 2023 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTTEHwy7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295243681
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 14:15:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F023DFE
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697552103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nkQTej9CUN1xc2G1qV1a/xqmoCzCR8Grn+zQt9Wwwc=;
	b=MTTEHwy7rH0UpxylgWya+j1v8TYLFMrxVpyr1wBJjIbbZDZS1gyrIKh8p/PBGc58m3uImC
	yafTvJHxUntm0kfLakltmKoShGF/QSQB5DciZ4PtMWdG23M8g6Agl7ihf4WkbgKrTmGH8b
	7dXkVvZbx8ZvWZxa4JJKSlQFzhc3BIA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-khJ_arrAOuaJoJrlyxeHMg-1; Tue, 17 Oct 2023 10:14:56 -0400
X-MC-Unique: khJ_arrAOuaJoJrlyxeHMg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9c37ff224b9so42124466b.0
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 07:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697552095; x=1698156895;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nkQTej9CUN1xc2G1qV1a/xqmoCzCR8Grn+zQt9Wwwc=;
        b=t2+VtRmS/BJzgwKHUiLmvjxsSbQpMGoN+yMuxBhO4qcmbdirLzkF8IHQY5PK5bAXFl
         0Er4AeT5sBniXVZElk+O2Bu0c9eKECTtyG2JLsHl9zgsJ0YBxOtEMTNBm54MUDyhWmlv
         RIOdj/fk8ezpkLEcGQkUBxtl2dGXPb/NgC+/aHul4hK+A0AqeQNkGfbmnjFr4Hc0G8Dw
         zgIzZ8H/6ZN/D07tqFYb4o57+57YBXcofRweR89Z7RLZxxmRsUa08fI44Naq9UhwFkaC
         e3socGpymyaEJRf2MTYuY6l5zI9BLZAukX4ij3AxjKRx9Zx+mavcI30rgfNfkKbVHQyD
         e+jg==
X-Gm-Message-State: AOJu0YxalPiOxArCwmUp8bnunyOpwKEAO/i+SDGnS50OXIcNjTE1vVOO
	MqB6RKLQAOzL9bSolrmYOEp2EuZLZJF0FpPpeENB9dGgJbI+tLsaUCeHRxT4pLIkRtgsFOfjnx3
	gm1MTzQ+XiXNekafmPGRs
X-Received: by 2002:a17:907:d13:b0:9be:7de2:9282 with SMTP id gn19-20020a1709070d1300b009be7de29282mr1774865ejc.5.1697552095128;
        Tue, 17 Oct 2023 07:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbhYOVuxlzPpwr2c6BQGJkNCp7N/QBDJicrbGPiXl9nN25rVFFuyVK8mDIe9bdZAn6iY3/VA==
X-Received: by 2002:a17:907:d13:b0:9be:7de2:9282 with SMTP id gn19-20020a1709070d1300b009be7de29282mr1774849ejc.5.1697552094697;
        Tue, 17 Oct 2023 07:14:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-87.dyn.eolo.it. [146.241.233.87])
        by smtp.gmail.com with ESMTPSA id v26-20020a170906339a00b009adc77fe165sm1339956eja.118.2023.10.17.07.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:14:54 -0700 (PDT)
Message-ID: <78ae0a2e925540ca99774f8f1758f5982562cab4.camel@redhat.com>
Subject: Re: [bug report] tcp: allow again tcp_disconnect() when threads are
 waiting
From: Paolo Abeni <pabeni@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: bpf@vger.kernel.org
Date: Tue, 17 Oct 2023 16:14:53 +0200
In-Reply-To: <ba9236a1-f473-4561-9ec0-87daf364776a@moroto.mountain>
References: <ba9236a1-f473-4561-9ec0-87daf364776a@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-17 at 16:54 +0300, Dan Carpenter wrote:
> The patch 419ce133ab92: "tcp: allow again tcp_disconnect() when
> threads are waiting" from Oct 11, 2023 (linux-next), leads to the
> following Smatch static checker warning:
>=20
> net/ipv4/tcp_bpf.c:324 tcp_bpf_recvmsg_parser() warn: inconsistent return=
s '&sk->sk_lock.slock'.
> net/ipv4/tcp_bpf.c:370 tcp_bpf_recvmsg() warn: inconsistent returns '&sk-=
>sk_lock.slock'.
>=20
> net/ipv4/tcp_bpf.c
>     218 static int tcp_bpf_recvmsg_parser(struct sock *sk,
>     219                                   struct msghdr *msg,
>     220                                   size_t len,
>     221                                   int flags,
>     222                                   int *addr_len)
>     223 {
>     224         struct tcp_sock *tcp =3D tcp_sk(sk);
>     225         int peek =3D flags & MSG_PEEK;
>     226         u32 seq =3D tcp->copied_seq;
>     227         struct sk_psock *psock;
>     228         int copied =3D 0;
>     229=20
>     230         if (unlikely(flags & MSG_ERRQUEUE))
>     231                 return inet_recv_error(sk, msg, len, addr_len);
>     232=20
>     233         if (!len)
>     234                 return 0;
>     235=20
>     236         psock =3D sk_psock_get(sk);
>     237         if (unlikely(!psock))
>     238                 return tcp_recvmsg(sk, msg, len, flags, addr_len)=
;
>     239=20
>     240         lock_sock(sk);
>     241=20
>     242         /* We may have received data on the sk_receive_queue pre-=
accept and
>     243          * then we can not use read_skb in this context because w=
e haven't
>     244          * assigned a sk_socket yet so have no link to the ops. T=
he work-around
>     245          * is to check the sk_receive_queue and in these cases re=
ad skbs off
>     246          * queue again. The read_skb hook is not running at this =
point because
>     247          * of lock_sock so we avoid having multiple runners in re=
ad_skb.
>     248          */
>     249         if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
>     250                 tcp_data_ready(sk);
>     251                 /* This handles the ENOMEM errors if we both rece=
ive data
>     252                  * pre accept and are already under memory pressu=
re. At least
>     253                  * let user know to retry.
>     254                  */
>     255                 if (unlikely(!skb_queue_empty(&sk->sk_receive_que=
ue))) {
>     256                         copied =3D -EAGAIN;
>     257                         goto out;
>     258                 }
>     259         }
>     260=20
>     261 msg_bytes_ready:
>     262         copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
>     263         /* The typical case for EFAULT is the socket was graceful=
ly
>     264          * shutdown with a FIN pkt. So check here the other case =
is
>     265          * some error on copy_page_to_iter which would be unexpec=
ted.
>     266          * On fin return correct return code to zero.
>     267          */
>     268         if (copied =3D=3D -EFAULT) {
>     269                 bool is_fin =3D is_next_msg_fin(psock);
>     270=20
>     271                 if (is_fin) {
>     272                         copied =3D 0;
>     273                         seq++;
>     274                         goto out;
>     275                 }
>     276         }
>     277         seq +=3D copied;
>     278         if (!copied) {
>     279                 long timeo;
>     280                 int data;
>     281=20
>     282                 if (sock_flag(sk, SOCK_DONE))
>     283                         goto out;
>     284=20
>     285                 if (sk->sk_err) {
>     286                         copied =3D sock_error(sk);
>     287                         goto out;
>     288                 }
>     289=20
>     290                 if (sk->sk_shutdown & RCV_SHUTDOWN)
>     291                         goto out;
>     292=20
>     293                 if (sk->sk_state =3D=3D TCP_CLOSE) {
>     294                         copied =3D -ENOTCONN;
>     295                         goto out;
>     296                 }
>     297=20
>     298                 timeo =3D sock_rcvtimeo(sk, flags & MSG_DONTWAIT)=
;
>     299                 if (!timeo) {
>     300                         copied =3D -EAGAIN;
>     301                         goto out;
>     302                 }
>     303=20
>     304                 if (signal_pending(current)) {
>     305                         copied =3D sock_intr_errno(timeo);
>     306                         goto out;
>     307                 }
>     308=20
>     309                 data =3D tcp_msg_wait_data(sk, psock, timeo);
>     310                 if (data < 0)
>     311                         return data;
>=20
> Do we need to call release_sock(sk); before returning?  It gets called
> in tcp_msg_wait_data() but then it calls lock_sock() again so Smatch
> and I think that cancels out.

Indeed you are right, we need something alike:
				copied =3D data;
				goto release;
			}

>=20
>     312                 if (data && !sk_psock_queue_empty(psock))
>     313                         goto msg_bytes_ready;
>     314                 copied =3D -EAGAIN;
>     315         }
>     316 out:
>     317         if (!peek)
>     318                 WRITE_ONCE(tcp->copied_seq, seq);
>     319         tcp_rcv_space_adjust(sk);
>     320         if (copied > 0)
>     321                 __tcp_cleanup_rbuf(sk, copied);

release:
>     322         release_sock(sk);
>     323         sk_psock_put(sk, psock);
> --> 324         return copied;
>     325 }

and something similar in tcp_bpf_recvmsg(). I can send a patch (or you
can go ahead if you prefer).

Thanks!

Paolo


