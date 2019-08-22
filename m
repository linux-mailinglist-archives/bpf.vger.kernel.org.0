Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D8699961
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2019 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfHVQip (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Aug 2019 12:38:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38058 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730545AbfHVQio (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Aug 2019 12:38:44 -0400
Received: by mail-io1-f68.google.com with SMTP id p12so13173299iog.5;
        Thu, 22 Aug 2019 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3FgN6tHPMtfR2eh2tcn0+eFg5p7QIcdpMVYh3HXblQ=;
        b=YoksQZH6CZk9rispM3SOYYBOusbFtUm5rCwC6capVqF+tL2k5etGl9dtOzNww/DeIW
         B7lKpSIveYDL+qGTWVEo1jV4Alwe1mYrnZ1DcUsI+IbRzPodvEHkUIYkQgQkhp+rBf0Z
         Wu/ab1GuYxbWMikSOUCMaPBePwnYr1Tudq/JOzMMceWNH0XmhEubdBxFuYzHiLrSSwjW
         vdWwzLmHl9xhse/616UGWp4M4C7FQQHwtlM0ZkkDaGEepsxCSKaV7Rl6/xewiMrsjt3j
         5pNjVBzObfsDLHsrKls4T2blO6t151Z4lm/kSYXcCbKmx2BlTZr2kL+8+O4CpHoAPsDK
         PmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3FgN6tHPMtfR2eh2tcn0+eFg5p7QIcdpMVYh3HXblQ=;
        b=ZqN8dRBzepRPF4d3yTHPREuOgqCfnDgU9xkONFgRm0efPXiTtuLEBa37uhLS+V7+AL
         vtezYQAdNA6m28PJWhkg0fuA4YstLKyQ4ZevEIoGwaAu0n3+2y2dCo7JETo2o2QFPIzX
         i0nr2onlzznaHdUS52IWxlUsJ0rIjEieFANHqVeRWi7/hI2apmkCsfp9g1jeOJJt+Z5I
         +0ACtCnRezrk2BHLm4QSXOT42GZo/Dc9ixVJGYISWeFDci5VOd0j1v3C6oLSKpstv1g6
         JCOcK+jfIIdYhWJ3rlWnEnn7s0lbso3DS+bVXM4fIE3I3VW9VA0LWoBKoxp0VjiokTBj
         W37Q==
X-Gm-Message-State: APjAAAXZwTqZaoLvr2DKF3E02IBrOUVEqVVE6INvyx+7/AFiJh+eyRum
        SnNha8vBTNwbwEukhtM0sLNvQb/g0KNjrku6YPU=
X-Google-Smtp-Source: APXvYqzwldhCiG7ir76K/uWSEH120ud4pRYjWlRwuINIRmmSCViVvYmdKA/Qla5MKm403JbmwHQAN3MfzwJ6cMxzYhY=
X-Received: by 2002:a6b:dd18:: with SMTP id f24mr679216ioc.97.1566491923755;
 Thu, 22 Aug 2019 09:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190822123045eucas1p125b6e106f0310bdb50e759ef41993a91@eucas1p1.samsung.com>
 <20190822123037.28068-1-i.maximets@samsung.com>
In-Reply-To: <20190822123037.28068-1-i.maximets@samsung.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 22 Aug 2019 09:38:32 -0700
Message-ID: <CAKgT0Uf26P53EA4m503aehq3tWCX9b3C+17TW2Ursbue9Kp=_w@mail.gmail.com>
Subject: Re: [PATCH net v2] ixgbe: fix double clean of tx descriptors with xdp
To:     Ilya Maximets <i.maximets@samsung.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Eelco Chaudron <echaudro@redhat.com>,
        William Tu <u9012063@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 22, 2019 at 5:30 AM Ilya Maximets <i.maximets@samsung.com> wrote:
>
> Tx code doesn't clear the descriptors' status after cleaning.
> So, if the budget is larger than number of used elems in a ring, some
> descriptors will be accounted twice and xsk_umem_complete_tx will move
> prod_tail far beyond the prod_head breaking the comletion queue ring.
>
> Fix that by limiting the number of descriptors to clean by the number
> of used descriptors in the tx ring.
>
> 'ixgbe_clean_xdp_tx_irq()' function refactored to look more like
> 'ixgbe_xsk_clean_tx_ring()' since we don't need most of the
> complications implemented in the regular 'ixgbe_clean_tx_irq()'
> and we're allowed to directly use 'next_to_clean' and 'next_to_use'
> indexes.
>
> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> ---
>
> Version 2:
>   * 'ixgbe_clean_xdp_tx_irq()' refactored to look more like
>     'ixgbe_xsk_clean_tx_ring()'.
>
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 34 ++++++++------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> index 6b609553329f..d1297660e14a 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> @@ -633,22 +633,23 @@ static void ixgbe_clean_xdp_tx_buffer(struct ixgbe_ring *tx_ring,
>  bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
>                             struct ixgbe_ring *tx_ring, int napi_budget)
>  {
> +       u16 ntc = tx_ring->next_to_clean, ntu = tx_ring->next_to_use;
>         unsigned int total_packets = 0, total_bytes = 0;
> -       u32 i = tx_ring->next_to_clean, xsk_frames = 0;
>         unsigned int budget = q_vector->tx.work_limit;
>         struct xdp_umem *umem = tx_ring->xsk_umem;
> -       union ixgbe_adv_tx_desc *tx_desc;
> -       struct ixgbe_tx_buffer *tx_bi;
> +       u32 xsk_frames = 0;
>         bool xmit_done;
>
> -       tx_bi = &tx_ring->tx_buffer_info[i];
> -       tx_desc = IXGBE_TX_DESC(tx_ring, i);
> -       i -= tx_ring->count;
> +       while (likely(ntc != ntu && budget)) {

I would say you can get rid of budget entirely. It was only really
needed for the regular Tx case where you can have multiple CPUs
feeding a single Tx queue and causing a stall. Since we have a 1:1
mapping we should never have more than the Rx budget worth of packets
to really process. In addition we can only make one pass through the
ring since the ntu value is not updated while running the loop.

> +               union ixgbe_adv_tx_desc *tx_desc;
> +               struct ixgbe_tx_buffer *tx_bi;
> +
> +               tx_desc = IXGBE_TX_DESC(tx_ring, ntc);
>
> -       do {
>                 if (!(tx_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
>                         break;
>
> +               tx_bi = &tx_ring->tx_buffer_info[ntc];

Please don't move this logic into the loop. We were intentionally
processing this outside of the loop once and then just doing the
increments because it is faster that way. It takes several operations
to compute tx_bi based on ntc, whereas just incrementing is a single
operation.

>                 total_bytes += tx_bi->bytecount;
>                 total_packets += tx_bi->gso_segs;
>
> @@ -659,24 +660,15 @@ bool ixgbe_clean_xdp_tx_irq(struct ixgbe_q_vector *q_vector,
>
>                 tx_bi->xdpf = NULL;
>
> -               tx_bi++;
> -               tx_desc++;
> -               i++;
> -               if (unlikely(!i)) {
> -                       i -= tx_ring->count;

So these two lines can probably just be replaced by:
if (unlikely(ntc == tx_ring->count)) {
        ntc = 0;

> -                       tx_bi = tx_ring->tx_buffer_info;
> -                       tx_desc = IXGBE_TX_DESC(tx_ring, 0);
> -               }
> -
> -               /* issue prefetch for next Tx descriptor */
> -               prefetch(tx_desc);

Did you just drop the prefetch? You are changing way too much with
this patch. All you should need to do is replace i with ntc, replace
the "do {" with "while (ntc != ntu) {", and remove the while at the
end.

> +               ntc++;
> +               if (unlikely(ntc == tx_ring->count))
> +                       ntc = 0;
>
>                 /* update budget accounting */
>                 budget--;
> -       } while (likely(budget));

As I stated earlier, budget can be removed entirely.

> +       }
>
> -       i += tx_ring->count;
> -       tx_ring->next_to_clean = i;
> +       tx_ring->next_to_clean = ntc;
>
>         u64_stats_update_begin(&tx_ring->syncp);
>         tx_ring->stats.bytes += total_bytes;
> --
> 2.17.1
>
