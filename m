Return-Path: <bpf+bounces-10585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A496E7A9C15
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 21:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26BE3B21A48
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 19:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3CC41745;
	Thu, 21 Sep 2023 18:59:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F911643A;
	Thu, 21 Sep 2023 18:59:09 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3FC59158;
	Thu, 21 Sep 2023 11:59:06 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so164783a12.0;
        Thu, 21 Sep 2023 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695322745; x=1695927545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM0Kr0OylFS8h4HMgyBWTdSjUbHONrsWq/2Y18Dc9+w=;
        b=hxbPaxD0P2oGrfy2z5bsfHIihlYLMR8k2ZgadeqVqTrZVttMSOHR/4jljB1IUOXO7l
         wEc7ZUiEe+8OjcFAECob/VCnPBXNbjXwyHsvzmo2CqzBQCaDhQdcGzmL+jfUl8YqwIie
         TsWGNfKLYKif5sg+D/XIW6fBu1fah5BRAQPrG3EwnahRUJ28nF/ptJLacS/u8Te4VVw6
         TQ+3sU5WH3p4n373H8GwLA9Zne9mOEgGF73MeCiGs0na/S4xk/x8j/+vNLGnFYFdowmC
         JHKZAubdxIJ+BzsCxZvlrvCaoqrqbhtZ/8/hpP8G4CO4w4HfNh/RGNeA+lIDd4vf8Ybw
         6FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322745; x=1695927545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RM0Kr0OylFS8h4HMgyBWTdSjUbHONrsWq/2Y18Dc9+w=;
        b=Zsnl1z2jnaDBMCub64WIJmNqoevlCwQWVW2PskC3/CqsLQgILwxXRZzP9OusuGQjx6
         TiToAQfdfnCbx0Nc1fVM08Yq8gHW3rs8kNUYOpMVekQ98xnlIrb+5n3zeby7+VDLlOo4
         QMDDc2Rdj85RR7FvmDwa9hZe+mMSuD1R5wf5fiw2he2CfR/8RoFXGzGz2HAUP/pfXIRS
         VnOWN9a+l43A9CP7nzjWvUZK57l2tu6MgHXxSBLvP3AIjBJq1hpuLR0aS5AlLhvs8/Xi
         ftD0qiSmFdqD+xjR138NZ8Cxa4vAAobzUDzEaeVZZvjdPaln+GtwLwA2FGFivNPwUzP/
         DHhQ==
X-Gm-Message-State: AOJu0Yz0wEtK+IoK8MZQifmM1lRRtMXP410BqPym4V1R+aulraiD5/xM
	PpsDYZOsrAjDAKEMY2WHwEudZSzATEeqnaHRhZ7EjHHlWSX3o5HT
X-Google-Smtp-Source: AGHT+IH42ZePTEEcyeAWZsr6Nka8QYq4XjZvfjMPXGICv02k5AWL9uBwUYNwDDB7UCYIumNNOxJxWgVcYVEpAl7nLhY=
X-Received: by 2002:a05:6214:20ea:b0:64a:8d39:3378 with SMTP id
 10-20020a05621420ea00b0064a8d393378mr4561058qvk.4.1695279076016; Wed, 20 Sep
 2023 23:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918093304.367826-1-tushar.vyavahare@intel.com> <20230918093304.367826-5-tushar.vyavahare@intel.com>
In-Reply-To: <20230918093304.367826-5-tushar.vyavahare@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 21 Sep 2023 08:51:05 +0200
Message-ID: <CAJ8uoz15WdTgQSqSY6Bge9cjo6q8=EKf6Jf6qTvW3wajr=wk8g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/8] selftests/xsk: iterate over all the sockets
 in the receive pkts function
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sept 2023 at 11:14, Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Improve the receive_pkt() function to enable it to receive packets from
> multiple sockets. Define a sock_num variable to iterate through all the
> sockets in the Rx path. Add nb_valid_entries to check that all the
> expected number of packets are received.
>
> Revise the function __receive_pkts() to only inspect the receive ring
> once, handle any received packets, and promptly return. Implement a bitma=
p
> to store the value of MAX_SOCKETS.
>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 276 ++++++++++++++---------
>  tools/testing/selftests/bpf/xskxceiver.h |   2 +
>  2 files changed, 171 insertions(+), 107 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/sel=
ftests/bpf/xskxceiver.c
> index 9f241f503eed..cf3a723cc827 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -80,6 +80,7 @@
>  #include <linux/if_ether.h>
>  #include <linux/mman.h>
>  #include <linux/netdev.h>
> +#include <linux/bitmap.h>
>  #include <arpa/inet.h>
>  #include <net/if.h>
>  #include <locale.h>
> @@ -540,8 +541,10 @@ static int test_spec_set_mtu(struct test_spec *test,=
 int mtu)
>
>  static void pkt_stream_reset(struct pkt_stream *pkt_stream)
>  {
> -       if (pkt_stream)
> +       if (pkt_stream) {
>                 pkt_stream->current_pkt_nb =3D 0;
> +               pkt_stream->nb_rx_pkts =3D 0;
> +       }
>  }
>
>  static struct pkt *pkt_stream_get_next_tx_pkt(struct pkt_stream *pkt_str=
eam)
> @@ -641,14 +644,16 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_=
stream *pkt_stream, struct pk
>         return nb_frags;
>  }
>
> -static void pkt_set(struct xsk_umem_info *umem, struct pkt *pkt, int off=
set, u32 len)
> +static void pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt, int =
offset, u32 len)
>  {
>         pkt->offset =3D offset;
>         pkt->len =3D len;
> -       if (len > MAX_ETH_JUMBO_SIZE)
> +       if (len > MAX_ETH_JUMBO_SIZE) {
>                 pkt->valid =3D false;
> -       else
> +       } else {
>                 pkt->valid =3D true;
> +               pkt_stream->nb_valid_entries++;
> +       }
>  }
>
>  static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
> @@ -670,7 +675,7 @@ static struct pkt_stream *pkt_stream_generate(struct =
xsk_umem_info *umem, u32 nb
>         for (i =3D 0; i < nb_pkts; i++) {
>                 struct pkt *pkt =3D &pkt_stream->pkts[i];
>
> -               pkt_set(umem, pkt, 0, pkt_len);
> +               pkt_set(pkt_stream, pkt, 0, pkt_len);
>                 pkt->pkt_nb =3D i;
>         }
>
> @@ -702,7 +707,7 @@ static void __pkt_stream_replace_half(struct ifobject=
 *ifobj, u32 pkt_len,
>
>         pkt_stream =3D pkt_stream_clone(umem, ifobj->xsk->pkt_stream);
>         for (i =3D 1; i < ifobj->xsk->pkt_stream->nb_pkts; i +=3D 2)
> -               pkt_set(umem, &pkt_stream->pkts[i], offset, pkt_len);
> +               pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len=
);
>
>         ifobj->xsk->pkt_stream =3D pkt_stream;
>  }
> @@ -724,6 +729,8 @@ static void pkt_stream_receive_half(struct test_spec =
*test)
>         pkt_stream =3D test->ifobj_rx->xsk->pkt_stream;
>         for (i =3D 1; i < pkt_stream->nb_pkts; i +=3D 2)
>                 pkt_stream->pkts[i].valid =3D false;
> +
> +       pkt_stream->nb_valid_entries /=3D 2;
>  }
>
>  static u64 pkt_get_addr(struct pkt *pkt, struct xsk_umem_info *umem)
> @@ -797,6 +804,10 @@ static struct pkt_stream *__pkt_stream_generate_cust=
om(struct ifobject *ifobj, s
>
>                 if (pkt->valid && pkt->len > pkt_stream->max_pkt_len)
>                         pkt_stream->max_pkt_len =3D pkt->len;
> +
> +               if (pkt->valid)
> +                       pkt_stream->nb_valid_entries++;
> +
>                 pkt_nb++;
>         }
>
> @@ -1018,133 +1029,179 @@ static int complete_pkts(struct xsk_socket_info=
 *xsk, int batch_size)
>         return TEST_PASS;
>  }
>
> -static int receive_pkts(struct test_spec *test, struct pollfd *fds)
> +static int __receive_pkts(struct test_spec *test, struct xsk_socket_info=
 *xsk)
>  {
> -       struct timeval tv_end, tv_now, tv_timeout =3D {THREAD_TMOUT, 0};
> -       struct pkt_stream *pkt_stream =3D test->ifobj_rx->xsk->pkt_stream=
;
> -       struct xsk_socket_info *xsk =3D test->ifobj_rx->xsk;
> +       u32 frags_processed =3D 0, nb_frags =3D 0, pkt_len =3D 0;
>         u32 idx_rx =3D 0, idx_fq =3D 0, rcvd, pkts_sent =3D 0;
> +       struct pkt_stream *pkt_stream =3D xsk->pkt_stream;
>         struct ifobject *ifobj =3D test->ifobj_rx;
>         struct xsk_umem_info *umem =3D xsk->umem;
> +       struct pollfd fds =3D { };
>         struct pkt *pkt;
> +       u64 first_addr;
>         int ret;
>
> -       ret =3D gettimeofday(&tv_now, NULL);
> -       if (ret)
> -               exit_with_error(errno);
> -       timeradd(&tv_now, &tv_timeout, &tv_end);
> -
> -       pkt =3D pkt_stream_get_next_rx_pkt(pkt_stream, &pkts_sent);
> -       while (pkt) {
> -               u32 frags_processed =3D 0, nb_frags =3D 0, pkt_len =3D 0;
> -               u64 first_addr;
> +       fds.fd =3D xsk_socket__fd(xsk->xsk);
> +       fds.events =3D POLLIN;
>
> -               ret =3D gettimeofday(&tv_now, NULL);
> -               if (ret)
> -                       exit_with_error(errno);
> -               if (timercmp(&tv_now, &tv_end, >)) {
> -                       ksft_print_msg("ERROR: [%s] Receive loop timed ou=
t\n", __func__);
> -                       return TEST_FAILURE;
> -               }
> +       ret =3D kick_rx(xsk);
> +       if (ret)
> +               return TEST_FAILURE;
>
> -               ret =3D kick_rx(xsk);
> -               if (ret)
> +       if (ifobj->use_poll) {
> +               ret =3D poll(&fds, 1, POLL_TMOUT);
> +               if (ret < 0)
>                         return TEST_FAILURE;
>
> -               if (ifobj->use_poll) {
> -                       ret =3D poll(fds, 1, POLL_TMOUT);
> -                       if (ret < 0)
> -                               return TEST_FAILURE;
> -
> -                       if (!ret) {
> -                               if (!is_umem_valid(test->ifobj_tx))
> -                                       return TEST_PASS;
> -
> -                               ksft_print_msg("ERROR: [%s] Poll timed ou=
t\n", __func__);
> -                               return TEST_FAILURE;
> -                       }
> +               if (!ret) {
> +                       if (!is_umem_valid(test->ifobj_tx))
> +                               return TEST_PASS;
>
> -                       if (!(fds->revents & POLLIN))
> -                               continue;
> +                       ksft_print_msg("ERROR: [%s] Poll timed out\n", __=
func__);
> +                       return TEST_CONTINUE;
>                 }
>
> -               rcvd =3D xsk_ring_cons__peek(&xsk->rx, BATCH_SIZE, &idx_r=
x);
> -               if (!rcvd)
> -                       continue;
> +               if (!(fds.revents & POLLIN))
> +                       return TEST_CONTINUE;
> +       }
>
> -               if (ifobj->use_fill_ring) {
> -                       ret =3D xsk_ring_prod__reserve(&umem->fq, rcvd, &=
idx_fq);
> -                       while (ret !=3D rcvd) {
> -                               if (xsk_ring_prod__needs_wakeup(&umem->fq=
)) {
> -                                       ret =3D poll(fds, 1, POLL_TMOUT);
> -                                       if (ret < 0)
> -                                               return TEST_FAILURE;
> -                               }
> -                               ret =3D xsk_ring_prod__reserve(&umem->fq,=
 rcvd, &idx_fq);
> +       rcvd =3D xsk_ring_cons__peek(&xsk->rx, BATCH_SIZE, &idx_rx);
> +       if (!rcvd)
> +               return TEST_CONTINUE;
> +
> +       if (ifobj->use_fill_ring) {
> +               ret =3D xsk_ring_prod__reserve(&umem->fq, rcvd, &idx_fq);
> +               while (ret !=3D rcvd) {
> +                       if (xsk_ring_prod__needs_wakeup(&umem->fq)) {
> +                               ret =3D poll(&fds, 1, POLL_TMOUT);
> +                               if (ret < 0)
> +                                       return TEST_FAILURE;
>                         }
> +                       ret =3D xsk_ring_prod__reserve(&umem->fq, rcvd, &=
idx_fq);
>                 }
> +       }
>
> -               while (frags_processed < rcvd) {
> -                       const struct xdp_desc *desc =3D xsk_ring_cons__rx=
_desc(&xsk->rx, idx_rx++);
> -                       u64 addr =3D desc->addr, orig;
> +       while (frags_processed < rcvd) {
> +               const struct xdp_desc *desc =3D xsk_ring_cons__rx_desc(&x=
sk->rx, idx_rx++);
> +               u64 addr =3D desc->addr, orig;
>
> -                       orig =3D xsk_umem__extract_addr(addr);
> -                       addr =3D xsk_umem__add_offset_to_addr(addr);
> +               orig =3D xsk_umem__extract_addr(addr);
> +               addr =3D xsk_umem__add_offset_to_addr(addr);
>
> +               if (!nb_frags) {
> +                       pkt =3D pkt_stream_get_next_rx_pkt(pkt_stream, &p=
kts_sent);
>                         if (!pkt) {
>                                 ksft_print_msg("[%s] received too many pa=
ckets addr: %lx len %u\n",
>                                                __func__, addr, desc->len)=
;
>                                 return TEST_FAILURE;
>                         }
> +               }
>
> -                       print_verbose("Rx: addr: %lx len: %u options: %u =
pkt_nb: %u valid: %u\n",
> -                                     addr, desc->len, desc->options, pkt=
->pkt_nb, pkt->valid);
> +               print_verbose("Rx: addr: %lx len: %u options: %u pkt_nb: =
%u valid: %u\n",
> +                             addr, desc->len, desc->options, pkt->pkt_nb=
, pkt->valid);
>
> -                       if (!is_frag_valid(umem, addr, desc->len, pkt->pk=
t_nb, pkt_len) ||
> -                           !is_offset_correct(umem, pkt, addr) ||
> -                           (ifobj->use_metadata && !is_metadata_correct(=
pkt, umem->buffer, addr)))
> -                               return TEST_FAILURE;
> +               if (!is_frag_valid(umem, addr, desc->len, pkt->pkt_nb, pk=
t_len) ||
> +                   !is_offset_correct(umem, pkt, addr) || (ifobj->use_me=
tadata &&
> +                   !is_metadata_correct(pkt, umem->buffer, addr)))
> +                       return TEST_FAILURE;
>
> -                       if (!nb_frags++)
> -                               first_addr =3D addr;
> -                       frags_processed++;
> -                       pkt_len +=3D desc->len;
> -                       if (ifobj->use_fill_ring)
> -                               *xsk_ring_prod__fill_addr(&umem->fq, idx_=
fq++) =3D orig;
> +               if (!nb_frags++)
> +                       first_addr =3D addr;
> +               frags_processed++;
> +               pkt_len +=3D desc->len;
> +               if (ifobj->use_fill_ring)
> +                       *xsk_ring_prod__fill_addr(&umem->fq, idx_fq++) =
=3D orig;
>
> -                       if (pkt_continues(desc->options))
> -                               continue;
> +               if (pkt_continues(desc->options))
> +                       continue;
>
> -                       /* The complete packet has been received */
> -                       if (!is_pkt_valid(pkt, umem->buffer, first_addr, =
pkt_len) ||
> -                           !is_offset_correct(umem, pkt, addr))
> -                               return TEST_FAILURE;
> +               /* The complete packet has been received */
> +               if (!is_pkt_valid(pkt, umem->buffer, first_addr, pkt_len)=
 ||
> +                   !is_offset_correct(umem, pkt, addr))
> +                       return TEST_FAILURE;
>
> -                       pkt =3D pkt_stream_get_next_rx_pkt(pkt_stream, &p=
kts_sent);
> -                       nb_frags =3D 0;
> -                       pkt_len =3D 0;
> -               }
> +               pkt_stream->nb_rx_pkts++;
> +               nb_frags =3D 0;
> +               pkt_len =3D 0;
> +       }
>
> -               if (nb_frags) {
> -                       /* In the middle of a packet. Start over from beg=
inning of packet. */
> -                       idx_rx -=3D nb_frags;
> -                       xsk_ring_cons__cancel(&xsk->rx, nb_frags);
> -                       if (ifobj->use_fill_ring) {
> -                               idx_fq -=3D nb_frags;
> -                               xsk_ring_prod__cancel(&umem->fq, nb_frags=
);
> -                       }
> -                       frags_processed -=3D nb_frags;
> +       if (nb_frags) {
> +               /* In the middle of a packet. Start over from beginning o=
f packet. */
> +               idx_rx -=3D nb_frags;
> +               xsk_ring_cons__cancel(&xsk->rx, nb_frags);
> +               if (ifobj->use_fill_ring) {
> +                       idx_fq -=3D nb_frags;
> +                       xsk_ring_prod__cancel(&umem->fq, nb_frags);
>                 }
> +               frags_processed -=3D nb_frags;
> +       }
>
> -               if (ifobj->use_fill_ring)
> -                       xsk_ring_prod__submit(&umem->fq, frags_processed)=
;
> -               if (ifobj->release_rx)
> -                       xsk_ring_cons__release(&xsk->rx, frags_processed)=
;
> +       if (ifobj->use_fill_ring)
> +               xsk_ring_prod__submit(&umem->fq, frags_processed);
> +       if (ifobj->release_rx)
> +               xsk_ring_cons__release(&xsk->rx, frags_processed);
> +
> +       pthread_mutex_lock(&pacing_mutex);
> +       pkts_in_flight -=3D pkts_sent;
> +       pthread_mutex_unlock(&pacing_mutex);
> +       pkts_sent =3D 0;

This patch looks much bigger than it is. You have only removed the
while loop and therefore had to change the indentation of the whole
function. The change looks good.

> +
> +return TEST_CONTINUE;
> +}
> +
> +bool all_packets_received(struct test_spec *test, struct xsk_socket_info=
 *xsk, u32 sock_num,
> +                         unsigned long *bitmap)
> +{
> +       struct pkt_stream *pkt_stream =3D xsk->pkt_stream;
>
> -               pthread_mutex_lock(&pacing_mutex);
> -               pkts_in_flight -=3D pkts_sent;
> -               pthread_mutex_unlock(&pacing_mutex);
> -               pkts_sent =3D 0;
> +       if (!pkt_stream) {
> +               __test_and_set_bit((1 << sock_num), bitmap);
> +               return false;
> +       }
> +
> +       if (pkt_stream->nb_rx_pkts =3D=3D pkt_stream->nb_valid_entries) {
> +               __test_and_set_bit((1 << sock_num), bitmap);
> +               if (test_bit(test->nb_sockets, bitmap))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static int receive_pkts(struct test_spec *test)
> +{
> +       struct timeval tv_end, tv_now, tv_timeout =3D {THREAD_TMOUT, 0};
> +       u32 sock_num =3D 0;
> +       int res, ret;
> +
> +       DECLARE_BITMAP(bitmap, MAX_SOCKETS);

This is a declaration that should be bunched with the declarations above.

> +
> +       ret =3D gettimeofday(&tv_now, NULL);
> +       if (ret)
> +               exit_with_error(errno);
> +
> +       timeradd(&tv_now, &tv_timeout, &tv_end);
> +
> +       while (1) {
> +               sock_num =3D (sock_num + 1) % test->nb_sockets;
> +
> +               struct xsk_socket_info *xsk =3D &test->ifobj_rx->xsk_arr[=
sock_num];
> +
> +               if ((all_packets_received(test, xsk, sock_num, bitmap)))
> +                       break;
> +
> +               res =3D __receive_pkts(test, xsk);
> +               if (!(res =3D=3D TEST_PASS || res =3D=3D TEST_CONTINUE))
> +                       return res;
> +
> +               ret =3D gettimeofday(&tv_now, NULL);
> +               if (ret)
> +                       exit_with_error(errno);
> +
> +               if (timercmp(&tv_now, &tv_end, >)) {
> +                       ksft_print_msg("ERROR: [%s] Receive loop timed ou=
t\n", __func__);
> +                       return TEST_FAILURE;
> +               }
>         }
>
>         return TEST_PASS;
> @@ -1577,7 +1634,6 @@ static void *worker_testapp_validate_rx(void *arg)
>  {
>         struct test_spec *test =3D (struct test_spec *)arg;
>         struct ifobject *ifobject =3D test->ifobj_rx;
> -       struct pollfd fds =3D { };
>         int err;
>
>         if (test->current_step =3D=3D 1) {
> @@ -1592,12 +1648,9 @@ static void *worker_testapp_validate_rx(void *arg)
>                 }
>         }
>
> -       fds.fd =3D xsk_socket__fd(ifobject->xsk->xsk);
> -       fds.events =3D POLLIN;
> -
>         pthread_barrier_wait(&barr);
>
> -       err =3D receive_pkts(test, &fds);
> +       err =3D receive_pkts(test);
>
>         if (!err && ifobject->validation_func)
>                 err =3D ifobject->validation_func(ifobject);
> @@ -1734,9 +1787,15 @@ static int __testapp_validate_traffic(struct test_=
spec *test, struct ifobject *i
>                 pthread_join(t0, NULL);
>
>         if (test->total_steps =3D=3D test->current_step || test->fail) {
> +               u32 i;
> +
>                 if (ifobj2)
> -                       xsk_socket__delete(ifobj2->xsk->xsk);
> -               xsk_socket__delete(ifobj1->xsk->xsk);
> +                       for (i =3D 0; i < test->nb_sockets; i++)
> +                               xsk_socket__delete(ifobj2->xsk_arr[i].xsk=
);
> +
> +               for (i =3D 0; i < test->nb_sockets; i++)
> +                       xsk_socket__delete(ifobj1->xsk_arr[i].xsk);
> +
>                 testapp_clean_xsk_umem(ifobj1);
>                 if (ifobj2 && !ifobj2->shared_umem)
>                         testapp_clean_xsk_umem(ifobj2);
> @@ -1812,8 +1871,6 @@ static int swap_xsk_resources(struct ifobject *ifob=
j_tx, struct ifobject *ifobj_
>  {
>         int ret;
>
> -       xsk_socket__delete(ifobj_tx->xsk->xsk);
> -       xsk_socket__delete(ifobj_rx->xsk->xsk);
>         ifobj_tx->xsk =3D &ifobj_tx->xsk_arr[1];
>         ifobj_rx->xsk =3D &ifobj_rx->xsk_arr[1];
>
> @@ -1831,6 +1888,10 @@ static int testapp_xdp_prog_cleanup(struct test_sp=
ec *test)
>         if (testapp_validate_traffic(test))
>                 return TEST_FAILURE;
>
> +       test->ifobj_tx->xsk_arr[0].pkt_stream =3D NULL;
> +       test->ifobj_rx->xsk_arr[0].pkt_stream =3D NULL;
> +       test->ifobj_tx->xsk_arr[1].pkt_stream =3D test->tx_pkt_stream_def=
ault;
> +       test->ifobj_rx->xsk_arr[1].pkt_stream =3D test->rx_pkt_stream_def=
ault;=C2=B4

Would it make more sense if this was part of the function below?

>         if (swap_xsk_resources(test->ifobj_tx, test->ifobj_rx))
>                 return TEST_FAILURE;
>         return testapp_validate_traffic(test);
> @@ -1861,6 +1922,7 @@ static int testapp_stats_tx_invalid_descs(struct te=
st_spec *test)
>  {
>         pkt_stream_replace_half(test, XSK_UMEM__INVALID_FRAME_SIZE, 0);
>         test->ifobj_tx->validation_func =3D validate_tx_invalid_descs;
> +       test->ifobj_rx->xsk->pkt_stream->nb_valid_entries /=3D 2;

Should be part of  pkt_stream_replace_half()

>         return testapp_validate_traffic(test);
>  }
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.h b/tools/testing/sel=
ftests/bpf/xskxceiver.h
> index e003f9ca4692..aa6cccb862bc 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.h
> +++ b/tools/testing/selftests/bpf/xskxceiver.h
> @@ -108,6 +108,8 @@ struct pkt_stream {
>         u32 current_pkt_nb;
>         struct pkt *pkts;
>         u32 max_pkt_len;
> +       u32 nb_rx_pkts;
> +       u32 nb_valid_entries;
>         bool verbatim;
>  };
>
> --
> 2.34.1
>
>

