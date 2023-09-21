Return-Path: <bpf+bounces-10580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23787A9C87
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815AA1F21669
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F209CA58;
	Thu, 21 Sep 2023 18:44:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFC79CA41;
	Thu, 21 Sep 2023 18:44:15 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03773ECA5C;
	Thu, 21 Sep 2023 11:44:13 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-57b48918efcso152707eaf.1;
        Thu, 21 Sep 2023 11:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695321853; x=1695926653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YYfgmqOWJYL4RFhEhCUjfY5/mLJnIuSj1yZxZ7ffUFY=;
        b=TewYodz0AirS0wk/c8jPg71Llu4dQnIk5ccntjBs6wJ5MfsnC8m/7Y7Ea1bhUzu9uu
         mZ62fxNEkj/+I3+a2WEdV61VdBQTdw7mqVdENT1AbrtP199eU7Xi0ITMplLC14M4xE1m
         wYci6VGF9Ti/fNr0uSANM6ygYiZppZi2IP5oWJdNaXP4EL52CgLTyBmRYbSSJhBk6l0p
         OYW7LPRWBUOmZxQceSu60pRNZXgqEuwmUMNylbHCr7sotQckZhgHTZfRBSAGxJvHuKUh
         R+sIxQow+V5iVTHAwTzZA2pjEu/dycOtv+Dzu9IjPy+EyiP9yFiob1y8JksDjiuysnt3
         br/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321853; x=1695926653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYfgmqOWJYL4RFhEhCUjfY5/mLJnIuSj1yZxZ7ffUFY=;
        b=rV2D/ZRkTl6a59IsOd5V1cnhkRAA11GrulLn4z4L1AoVLkXAKCM3Q1a1AL3SVLDhYm
         nMTmbWWXZziknnv0W17VGbATT7EuwFA4QjT+YMlcQPG3Mr6eBHiAcRDdEeDkStIlBHyx
         Wl3XUFKY1unU7sfvIS4q0ofFknDRutPngWqDVszTTpJCKdrk2yLIfnvkPWeQU/iJe4SI
         AIxsFeYAyWRJ7bpzhdFonVN7mEsRxghOaFsR0gSKjQbg6HWvmIxjLxdv50AaOwspXhPp
         cP5PNnDRfeaFSy63q3tiGUI94PQPEinG1V07XkxcY8/8koNLipjYjXNC2InsUbcLbEq6
         0Jbw==
X-Gm-Message-State: AOJu0YxQMgcGwRdLHCpFERK1YiBSTyYhCvQqyGXbf+q0y9KTrwydlCdA
	B5bbWbuNwJyJ8cuZu/fw877rY/CWyQRfTGNxsyebR6nWVo6MaQ==
X-Google-Smtp-Source: AGHT+IFXGzgLX7ANRyQlp6Bi5iEojSubUy63e1IH7TE/jMO1+ZjCNxZY76ReOoGSvNG4+KlXDv3jhamG37y9rhhAkfM=
X-Received: by 2002:a05:6214:2b0a:b0:63c:f852:aa30 with SMTP id
 jx10-20020a0562142b0a00b0063cf852aa30mr4799963qvb.0.1695279693856; Thu, 21
 Sep 2023 00:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918093304.367826-1-tushar.vyavahare@intel.com> <20230918093304.367826-7-tushar.vyavahare@intel.com>
In-Reply-To: <20230918093304.367826-7-tushar.vyavahare@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 21 Sep 2023 09:01:22 +0200
Message-ID: <CAJ8uoz1QtRzeo8DxrpujjHGoPWd8FJASUWjfNrROuaJOCw+ZGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/8] selftests/xsk: iterate over all the sockets
 in the send pkts function
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sept 2023 at 11:15, Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Update send_pkts() to handle multiple sockets for sending packets.
> Multiple TX sockets are utilized alternately based on the batch size for
> improve packet transmission.

I do not know if it is "improved" ;-), but it is good to test sending
from multiple sockets. Please make that clearer.

> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 64 +++++++++++++++++-------
>  1 file changed, 45 insertions(+), 19 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index e67032f04a74..0ef0575c095c 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -1204,13 +1204,13 @@ static int receive_pkts(struct test_spec *test)
>         return TEST_PASS;
>  }
>
> -static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeout)
> +static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, bool timeout)
>  {
>         u32 i, idx = 0, valid_pkts = 0, valid_frags = 0, buffer_len;
> -       struct pkt_stream *pkt_stream = ifobject->xsk->pkt_stream;
> -       struct xsk_socket_info *xsk = ifobject->xsk;
> +       struct pkt_stream *pkt_stream = xsk->pkt_stream;
>         struct xsk_umem_info *umem = ifobject->umem;
>         bool use_poll = ifobject->use_poll;
> +       struct pollfd fds = { };
>         int ret;
>
>         buffer_len = pkt_get_buffer_len(umem, pkt_stream->max_pkt_len);
> @@ -1222,9 +1222,12 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
>                 return TEST_CONTINUE;
>         }
>
> +       fds.fd = xsk_socket__fd(xsk->xsk);
> +       fds.events = POLLOUT;
> +
>         while (xsk_ring_prod__reserve(&xsk->tx, BATCH_SIZE, &idx) < BATCH_SIZE) {
>                 if (use_poll) {
> -                       ret = poll(fds, 1, POLL_TMOUT);
> +                       ret = poll(&fds, 1, POLL_TMOUT);
>                         if (timeout) {
>                                 if (ret < 0) {
>                                         ksft_print_msg("ERROR: [%s] Poll error %d\n",
> @@ -1303,7 +1306,7 @@ static int __send_pkts(struct ifobject *ifobject, struct pollfd *fds, bool timeo
>         xsk->outstanding_tx += valid_frags;
>
>         if (use_poll) {
> -               ret = poll(fds, 1, POLL_TMOUT);
> +               ret = poll(&fds, 1, POLL_TMOUT);
>                 if (ret <= 0) {
>                         if (ret == 0 && timeout)
>                                 return TEST_PASS;
> @@ -1349,27 +1352,50 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
>         return TEST_PASS;
>  }
>
> +bool all_packets_sent(struct test_spec *test, unsigned long *bitmap)
> +{
> +       if (test_bit(test->nb_sockets, bitmap))
> +               return true;

This does not seem to be correct. You are testing one bit here, but
are you not supposed to test that all bits have been set?

> +
> +       return false;
> +}
> +
>  static int send_pkts(struct test_spec *test, struct ifobject *ifobject)
>  {
> -       struct pkt_stream *pkt_stream = ifobject->xsk->pkt_stream;
>         bool timeout = !is_umem_valid(test->ifobj_rx);
> -       struct pollfd fds = { };
> -       u32 ret;
> +       u32 i, ret;
>
> -       fds.fd = xsk_socket__fd(ifobject->xsk->xsk);
> -       fds.events = POLLOUT;
> +       DECLARE_BITMAP(bitmap, MAX_SOCKETS);

Should be with the declarations in RCT order.

>
> -       while (pkt_stream->current_pkt_nb < pkt_stream->nb_pkts) {
> -               ret = __send_pkts(ifobject, &fds, timeout);
> -               if (ret == TEST_CONTINUE && !test->fail)
> -                       continue;
> -               if ((ret || test->fail) && !timeout)
> -                       return TEST_FAILURE;
> -               if (ret == TEST_PASS && timeout)
> -                       return ret;
> +       while (!(all_packets_sent(test, bitmap))) {
> +               for (i = 0; i < test->nb_sockets; i++) {
> +                       struct pkt_stream *pkt_stream;
> +
> +                       pkt_stream = ifobject->xsk_arr[i].pkt_stream;
> +                       if (!pkt_stream || pkt_stream->current_pkt_nb >= pkt_stream->nb_pkts) {

Can pkt_stream be NULL?

> +                               __test_and_set_bit((1 << i), bitmap);

test_and_set? You are not testing anything here so it is enough to just set it.

> +                               continue;
> +                       }
> +                       ret = __send_pkts(ifobject, &ifobject->xsk_arr[i], timeout);
> +                       if (ret == TEST_CONTINUE && !test->fail)
> +                               continue;
> +
> +                       if ((ret || test->fail) && !timeout)
> +                               return TEST_FAILURE;
> +
> +                       if (ret == TEST_PASS && timeout)
> +                               return ret;
> +
> +                       ret = wait_for_tx_completion(&ifobject->xsk_arr[i]);
> +                       if ((ret || test->fail) && !timeout)
> +                               return TEST_FAILURE;
> +
> +                       if (ret == TEST_PASS && timeout)
> +                               return ret;

Why testing the same things before and after wait_for_tx_completion?
Should it not be fine to just do it in one place?

> +               }
>         }
>
> -       return wait_for_tx_completion(ifobject->xsk);
> +       return TEST_PASS;
>  }
>
>  static int get_xsk_stats(struct xsk_socket *xsk, struct xdp_statistics *stats)
> --
> 2.34.1
>
>

