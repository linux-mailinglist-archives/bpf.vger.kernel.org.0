Return-Path: <bpf+bounces-14468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1F17E52B2
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 10:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2371C20DB9
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27313101C1;
	Wed,  8 Nov 2023 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0cVxa8T"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0EFC0B;
	Wed,  8 Nov 2023 09:35:50 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBA41A2;
	Wed,  8 Nov 2023 01:35:50 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d15bdd5abso15690326d6.1;
        Wed, 08 Nov 2023 01:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699436149; x=1700040949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UZMtF5r8nYpKY7zZpmBbnL4tBnPCGvaUAiho7TtIJnw=;
        b=N0cVxa8TNEbzNLuXVyruSP9Gp4pRJQlukliP8msq4ysDY4/myqAGH1WelJCEizfCo4
         plvqM2ypWl97EDH6ENcblcXmq4Ds6+bP7BGDnIV2WgAhdChR0PUTCKfJ+HAVYzWPgkeo
         7aVJcJ5sni/VLW/OTltcSOP1a6IGd3quBNtCfx3kN6qbPGbN7L7HTHA+ytOuGyKlcfrW
         XJHkUa18IvK87a9KtoD3L1N1RbxG8GuOZVcN3Csd4eDoWBpAkZCq7M1O/5BAWfqIOE/k
         5mguWyXT8RVLvXXFAj/jrlJuo/gecYgXaZhClG1QYjLuSfOofRmMVM2fHEKP1N+A7Sc5
         WcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699436149; x=1700040949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZMtF5r8nYpKY7zZpmBbnL4tBnPCGvaUAiho7TtIJnw=;
        b=qva3ctnRpMrM/jIfJdf1VnEWtLAfH2NZcBITPy1FiRwbcXCkM0Hnldw1YU09bqS0bu
         +YQ3WLE8Vo3sC1Ar2l8fRYacB5NeAF++V4LyZMPWTRzYBJjpJpnZ4tzZwfzP30C0TemR
         trg34QrbCLKW0vlJeyKeLj+XK7jjzpm12F34S9HC1kPEdu+EJ4N0KMvhnk6FXCEl9dtV
         ccftarIV0joUV8w9IC/OfpCbnS4k79IkKc/FNwTQYj2J8KoDKagXIzI9dotcXN+Brsl6
         GhBYPuoeUNluZY7OBrVTaQpQE6zyTxyOHE1tQqvsEEQiVgzWLyg4ZVucCYpKvzQO27X8
         +1lA==
X-Gm-Message-State: AOJu0YxUz642EITMNp8Kw6rGzDLUlj1iHqHabZ5JROnL9yTxuP4IK7pX
	kJ0tqMk9t+AJhk/9XoyiBteicEAStuyA196RTXE=
X-Google-Smtp-Source: AGHT+IGWVnaxqGhNbF9Aux7HB6FshxVRyhWG94Vpf2MjqQnjVLWnQE+6WlRdsA8D308zCX7fgTynv1tabUHJSxp4ADQ=
X-Received: by 2002:a05:6214:ab0:b0:65d:486:25c6 with SMTP id
 ew16-20020a0562140ab000b0065d048625c6mr1222772qvb.3.1699436149394; Wed, 08
 Nov 2023 01:35:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103142936.393654-1-tushar.vyavahare@intel.com>
In-Reply-To: <20231103142936.393654-1-tushar.vyavahare@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 8 Nov 2023 10:35:38 +0100
Message-ID: <CAJ8uoz23WLxF4+_rthmSLAE3r-xfCggEuACW1OpnJtHBzon_yQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/xsk: fix for SEND_RECEIVE_UNALIGNED test.
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Nov 2023 at 15:41, Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Fix test broken by shared umem test and framework enhancement commit.
>
> Correct the current implementation of pkt_stream_replace_half() by
> ensuring that nb_valid_entries are not set to half, as this is not true
> for all the tests.
>
> Create a new function called pkt_modify() that allows for packet
> modification to meet specific requirements while ensuring the accurate
> maintenance of the valid packet count to prevent inconsistencies in packet
> tracking.

Thanks for the fix Tushar. While long, this gives the packet stream
modification functionality a better structure.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Fixes: 6d198a89c004 ("selftests/xsk: Add a test for shared umem feature")
> Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> ---
>  tools/testing/selftests/bpf/xskxceiver.c | 71 ++++++++++++++++--------
>  1 file changed, 47 insertions(+), 24 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> index 591ca9637b23..f7d3a4a9013f 100644
> --- a/tools/testing/selftests/bpf/xskxceiver.c
> +++ b/tools/testing/selftests/bpf/xskxceiver.c
> @@ -634,16 +634,35 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
>         return nb_frags;
>  }
>
> -static void pkt_set(struct pkt_stream *pkt_stream, struct pkt *pkt, int offset, u32 len)
> +static bool pkt_valid(bool unaligned_mode, int offset, u32 len)
> +{
> +       if (len > MAX_ETH_JUMBO_SIZE || (!unaligned_mode && offset < 0))
> +               return false;
> +
> +       return true;
> +}
> +
> +static void pkt_set(struct pkt_stream *pkt_stream, struct xsk_umem_info *umem, struct pkt *pkt,
> +                   int offset, u32 len)
>  {
>         pkt->offset = offset;
>         pkt->len = len;
> -       if (len > MAX_ETH_JUMBO_SIZE) {
> -               pkt->valid = false;
> -       } else {
> -               pkt->valid = true;
> +
> +       pkt->valid = pkt_valid(umem->unaligned_mode, offset, len);
> +       if (pkt->valid)
>                 pkt_stream->nb_valid_entries++;
> -       }
> +}
> +
> +static void pkt_modify(struct pkt_stream *pkt_stream, struct xsk_umem_info *umem, struct pkt *pkt,
> +                      int offset, u32 len)
> +{
> +       bool mod_valid;
> +
> +       pkt->offset = offset;
> +       pkt->len = len;
> +       mod_valid  = pkt_valid(umem->unaligned_mode, offset, len);
> +       pkt_stream->nb_valid_entries += mod_valid - pkt->valid;
> +       pkt->valid = mod_valid;
>  }
>
>  static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
> @@ -651,7 +670,8 @@ static u32 pkt_get_buffer_len(struct xsk_umem_info *umem, u32 len)
>         return ceil_u32(len, umem->frame_size) * umem->frame_size;
>  }
>
> -static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb_start, u32 nb_off)
> +static struct pkt_stream *__pkt_stream_generate(struct xsk_umem_info *umem, u32 nb_pkts,
> +                                               u32 pkt_len, u32 nb_start, u32 nb_off)
>  {
>         struct pkt_stream *pkt_stream;
>         u32 i;
> @@ -665,30 +685,31 @@ static struct pkt_stream *__pkt_stream_generate(u32 nb_pkts, u32 pkt_len, u32 nb
>         for (i = 0; i < nb_pkts; i++) {
>                 struct pkt *pkt = &pkt_stream->pkts[i];
>
> -               pkt_set(pkt_stream, pkt, 0, pkt_len);
> +               pkt_set(pkt_stream, umem, pkt, 0, pkt_len);
>                 pkt->pkt_nb = nb_start + i * nb_off;
>         }
>
>         return pkt_stream;
>  }
>
> -static struct pkt_stream *pkt_stream_generate(u32 nb_pkts, u32 pkt_len)
> +static struct pkt_stream *pkt_stream_generate(struct xsk_umem_info *umem, u32 nb_pkts, u32 pkt_len)
>  {
> -       return __pkt_stream_generate(nb_pkts, pkt_len, 0, 1);
> +       return __pkt_stream_generate(umem, nb_pkts, pkt_len, 0, 1);
>  }
>
> -static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream)
> +static struct pkt_stream *pkt_stream_clone(struct pkt_stream *pkt_stream,
> +                                          struct xsk_umem_info *umem)
>  {
> -       return pkt_stream_generate(pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
> +       return pkt_stream_generate(umem, pkt_stream->nb_pkts, pkt_stream->pkts[0].len);
>  }
>
>  static void pkt_stream_replace(struct test_spec *test, u32 nb_pkts, u32 pkt_len)
>  {
>         struct pkt_stream *pkt_stream;
>
> -       pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> +       pkt_stream = pkt_stream_generate(test->ifobj_rx->umem, nb_pkts, pkt_len);
>         test->ifobj_tx->xsk->pkt_stream = pkt_stream;
> -       pkt_stream = pkt_stream_generate(nb_pkts, pkt_len);
> +       pkt_stream = pkt_stream_generate(test->ifobj_tx->umem, nb_pkts, pkt_len);
>         test->ifobj_rx->xsk->pkt_stream = pkt_stream;
>  }
>
> @@ -698,12 +719,11 @@ static void __pkt_stream_replace_half(struct ifobject *ifobj, u32 pkt_len,
>         struct pkt_stream *pkt_stream;
>         u32 i;
>
> -       pkt_stream = pkt_stream_clone(ifobj->xsk->pkt_stream);
> +       pkt_stream = pkt_stream_clone(ifobj->xsk->pkt_stream, ifobj->umem);
>         for (i = 1; i < ifobj->xsk->pkt_stream->nb_pkts; i += 2)
> -               pkt_set(pkt_stream, &pkt_stream->pkts[i], offset, pkt_len);
> +               pkt_modify(pkt_stream, ifobj->umem, &pkt_stream->pkts[i], offset, pkt_len);
>
>         ifobj->xsk->pkt_stream = pkt_stream;
> -       pkt_stream->nb_valid_entries /= 2;
>  }
>
>  static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int offset)
> @@ -715,9 +735,10 @@ static void pkt_stream_replace_half(struct test_spec *test, u32 pkt_len, int off
>  static void pkt_stream_receive_half(struct test_spec *test)
>  {
>         struct pkt_stream *pkt_stream = test->ifobj_tx->xsk->pkt_stream;
> +       struct xsk_umem_info *umem = test->ifobj_rx->umem;
>         u32 i;
>
> -       test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(pkt_stream->nb_pkts,
> +       test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(umem, pkt_stream->nb_pkts,
>                                                               pkt_stream->pkts[0].len);
>         pkt_stream = test->ifobj_rx->xsk->pkt_stream;
>         for (i = 1; i < pkt_stream->nb_pkts; i += 2)
> @@ -733,12 +754,12 @@ static void pkt_stream_even_odd_sequence(struct test_spec *test)
>
>         for (i = 0; i < test->nb_sockets; i++) {
>                 pkt_stream = test->ifobj_tx->xsk_arr[i].pkt_stream;
> -               pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
> +               pkt_stream = __pkt_stream_generate(test->ifobj_tx->umem, pkt_stream->nb_pkts / 2,
>                                                    pkt_stream->pkts[0].len, i, 2);
>                 test->ifobj_tx->xsk_arr[i].pkt_stream = pkt_stream;
>
>                 pkt_stream = test->ifobj_rx->xsk_arr[i].pkt_stream;
> -               pkt_stream = __pkt_stream_generate(pkt_stream->nb_pkts / 2,
> +               pkt_stream = __pkt_stream_generate(test->ifobj_rx->umem, pkt_stream->nb_pkts / 2,
>                                                    pkt_stream->pkts[0].len, i, 2);
>                 test->ifobj_rx->xsk_arr[i].pkt_stream = pkt_stream;
>         }
> @@ -1961,7 +1982,8 @@ static int testapp_stats_tx_invalid_descs(struct test_spec *test)
>  static int testapp_stats_rx_full(struct test_spec *test)
>  {
>         pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
> -       test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> +       test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
> +                                                             DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
>
>         test->ifobj_rx->xsk->rxqsize = DEFAULT_UMEM_BUFFERS;
>         test->ifobj_rx->release_rx = false;
> @@ -1972,7 +1994,8 @@ static int testapp_stats_rx_full(struct test_spec *test)
>  static int testapp_stats_fill_empty(struct test_spec *test)
>  {
>         pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
> -       test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
> +       test->ifobj_rx->xsk->pkt_stream = pkt_stream_generate(test->ifobj_rx->umem,
> +                                                             DEFAULT_UMEM_BUFFERS, MIN_PKT_SIZE);
>
>         test->ifobj_rx->use_fill_ring = false;
>         test->ifobj_rx->validation_func = validate_fill_empty;
> @@ -2526,8 +2549,8 @@ int main(int argc, char **argv)
>         init_iface(ifobj_tx, worker_testapp_validate_tx);
>
>         test_spec_init(&test, ifobj_tx, ifobj_rx, 0, &tests[0]);
> -       tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> -       rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> +       tx_pkt_stream_default = pkt_stream_generate(ifobj_tx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> +       rx_pkt_stream_default = pkt_stream_generate(ifobj_rx->umem, DEFAULT_PKT_CNT, MIN_PKT_SIZE);
>         if (!tx_pkt_stream_default || !rx_pkt_stream_default)
>                 exit_with_error(ENOMEM);
>         test.tx_pkt_stream_default = tx_pkt_stream_default;
> --
> 2.34.1
>
>

