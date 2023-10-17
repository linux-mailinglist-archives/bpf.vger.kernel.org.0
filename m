Return-Path: <bpf+bounces-12425-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBB37CC540
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 15:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E26281AA5
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0903D436B6;
	Tue, 17 Oct 2023 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IH++d8M+"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0B841234
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 13:55:01 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96449FD
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 06:54:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3226cc3e324so5287963f8f.3
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 06:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697550898; x=1698155698; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fwe8zNBuNj2tqxWRkFkbGANMO5VQwj3HDYUIrwq6JQ8=;
        b=IH++d8M+2T+SNr8bp9MNsH7lEVdJwT6n5FGzpBwLP1ivdWwg2K9aYuTYvqbT6WlrFP
         JxUHsk7Anaw23QNDXTCSXow5AI27gwRPuOvmw1RxRHP+mZKyAjRJsVxVrPnn91P1Bj8p
         qnLmLCvU/G/4oMY1n2cWLIyCL7Sa0Eabbt4J/aRySqOkHVh7Bk4L1OGTLX65wZU0XlRi
         rR3Ozf92Yb24lOjG0FhoozU9+B/SQECYvWLAWuq9ZAIc10PxQRHeAFIgn5p2qmgFmfwj
         xYc3jH3w/TtR83wmRUPUXl3cQ5GNqdV9OCcQG9He7EQlI5DPGPy809zFQ+VxtIrjHVmL
         w6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697550898; x=1698155698;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwe8zNBuNj2tqxWRkFkbGANMO5VQwj3HDYUIrwq6JQ8=;
        b=bYx0H88USIolophFgBhnXBP/MOkcxAo9/HQPSN8Q33ZEIZHdxzJv9yPruruLKbo/fu
         BTB78au/910k+5F84asSuNP+WaNLXOjSasffivF2x1qsEaNayrzqO2zaUq9I88g9xWAC
         lxpRI0v0hjPN5JGdJoZ1Sl/DSGlUiV0WEFgH0wbaFymA5nPMhFKQjFQQoKNq/i5DiAKO
         A+BQJlmRhGeBvP8/OloQO2dzrfvdwLpaEOc5IuGG5cve7g3g05y+u3Nbw85pwSIU4crx
         d+SQPGlgNEuvwU/Vx/SAcbP9mD4OM3OhPt+OBUbsS78+zdlA67KVU9AyIJsJdLZr9TWa
         FAkg==
X-Gm-Message-State: AOJu0Yz4xz4wkRm9oR6qWWx9xCwUsVmsc9hKi74Yyf13/qdfdQUtErRi
	2rMtfMRa1qSEG9vPP8wYiLXjDAmpqGXyjVvM1OU=
X-Google-Smtp-Source: AGHT+IGqPwGTa/qUVGpJXpWX0VYNekJmVtyUfAOspWyTmdoeSkEc6oiiTBpxcnWLHXTqLyqVVvAfxg==
X-Received: by 2002:adf:fa47:0:b0:319:67ac:4191 with SMTP id y7-20020adffa47000000b0031967ac4191mr1973399wrr.37.1697550898091;
        Tue, 17 Oct 2023 06:54:58 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5052000000b0032dbf26e7aesm1737974wrt.65.2023.10.17.06.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:54:57 -0700 (PDT)
Date: Tue, 17 Oct 2023 16:54:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: pabeni@redhat.com
Cc: bpf@vger.kernel.org
Subject: [bug report] tcp: allow again tcp_disconnect() when threads are
 waiting
Message-ID: <ba9236a1-f473-4561-9ec0-87daf364776a@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Paolo Abeni,

The patch 419ce133ab92: "tcp: allow again tcp_disconnect() when
threads are waiting" from Oct 11, 2023 (linux-next), leads to the
following Smatch static checker warning:

net/ipv4/tcp_bpf.c:324 tcp_bpf_recvmsg_parser() warn: inconsistent returns '&sk->sk_lock.slock'.
net/ipv4/tcp_bpf.c:370 tcp_bpf_recvmsg() warn: inconsistent returns '&sk->sk_lock.slock'.

net/ipv4/tcp_bpf.c
    218 static int tcp_bpf_recvmsg_parser(struct sock *sk,
    219                                   struct msghdr *msg,
    220                                   size_t len,
    221                                   int flags,
    222                                   int *addr_len)
    223 {
    224         struct tcp_sock *tcp = tcp_sk(sk);
    225         int peek = flags & MSG_PEEK;
    226         u32 seq = tcp->copied_seq;
    227         struct sk_psock *psock;
    228         int copied = 0;
    229 
    230         if (unlikely(flags & MSG_ERRQUEUE))
    231                 return inet_recv_error(sk, msg, len, addr_len);
    232 
    233         if (!len)
    234                 return 0;
    235 
    236         psock = sk_psock_get(sk);
    237         if (unlikely(!psock))
    238                 return tcp_recvmsg(sk, msg, len, flags, addr_len);
    239 
    240         lock_sock(sk);
    241 
    242         /* We may have received data on the sk_receive_queue pre-accept and
    243          * then we can not use read_skb in this context because we haven't
    244          * assigned a sk_socket yet so have no link to the ops. The work-around
    245          * is to check the sk_receive_queue and in these cases read skbs off
    246          * queue again. The read_skb hook is not running at this point because
    247          * of lock_sock so we avoid having multiple runners in read_skb.
    248          */
    249         if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
    250                 tcp_data_ready(sk);
    251                 /* This handles the ENOMEM errors if we both receive data
    252                  * pre accept and are already under memory pressure. At least
    253                  * let user know to retry.
    254                  */
    255                 if (unlikely(!skb_queue_empty(&sk->sk_receive_queue))) {
    256                         copied = -EAGAIN;
    257                         goto out;
    258                 }
    259         }
    260 
    261 msg_bytes_ready:
    262         copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
    263         /* The typical case for EFAULT is the socket was gracefully
    264          * shutdown with a FIN pkt. So check here the other case is
    265          * some error on copy_page_to_iter which would be unexpected.
    266          * On fin return correct return code to zero.
    267          */
    268         if (copied == -EFAULT) {
    269                 bool is_fin = is_next_msg_fin(psock);
    270 
    271                 if (is_fin) {
    272                         copied = 0;
    273                         seq++;
    274                         goto out;
    275                 }
    276         }
    277         seq += copied;
    278         if (!copied) {
    279                 long timeo;
    280                 int data;
    281 
    282                 if (sock_flag(sk, SOCK_DONE))
    283                         goto out;
    284 
    285                 if (sk->sk_err) {
    286                         copied = sock_error(sk);
    287                         goto out;
    288                 }
    289 
    290                 if (sk->sk_shutdown & RCV_SHUTDOWN)
    291                         goto out;
    292 
    293                 if (sk->sk_state == TCP_CLOSE) {
    294                         copied = -ENOTCONN;
    295                         goto out;
    296                 }
    297 
    298                 timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
    299                 if (!timeo) {
    300                         copied = -EAGAIN;
    301                         goto out;
    302                 }
    303 
    304                 if (signal_pending(current)) {
    305                         copied = sock_intr_errno(timeo);
    306                         goto out;
    307                 }
    308 
    309                 data = tcp_msg_wait_data(sk, psock, timeo);
    310                 if (data < 0)
    311                         return data;

Do we need to call release_sock(sk); before returning?  It gets called
in tcp_msg_wait_data() but then it calls lock_sock() again so Smatch
and I think that cancels out.

    312                 if (data && !sk_psock_queue_empty(psock))
    313                         goto msg_bytes_ready;
    314                 copied = -EAGAIN;
    315         }
    316 out:
    317         if (!peek)
    318                 WRITE_ONCE(tcp->copied_seq, seq);
    319         tcp_rcv_space_adjust(sk);
    320         if (copied > 0)
    321                 __tcp_cleanup_rbuf(sk, copied);
    322         release_sock(sk);
    323         sk_psock_put(sk, psock);
--> 324         return copied;
    325 }

regards,
dan carpenter

