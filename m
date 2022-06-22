Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CB955524C
	for <lists+bpf@lfdr.de>; Wed, 22 Jun 2022 19:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377345AbiFVRYn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jun 2022 13:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376298AbiFVRYk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jun 2022 13:24:40 -0400
Received: from mail-pg1-x563.google.com (mail-pg1-x563.google.com [IPv6:2607:f8b0:4864:20::563])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E24C275D2
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 10:24:39 -0700 (PDT)
Received: by mail-pg1-x563.google.com with SMTP id d129so16675458pgc.9
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 10:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=Eg7pKoREa62TqDRaU+yo2zrV2x8I6979kwBHk4P4AYE=;
        b=yCMJXYjlOVOgxSQW41qc2I6s0BIgAMukk2o1aNXa7XJLSMwJlBRC77aIXS5NAr8pfP
         VfSsR6jJk19oWMw+/6/BJ8U5KMgHD7KkMTXK89/ESwkPKhKFXT3ww9vc5KVB1s9n46U5
         WS5Dv+XZLATsaNU8YAGY/fJvJd+RKal/VzPLXT3QMrIBlhCzoU38mIX7kZFi1/5YRyBx
         HioUFIY0HRrG6/4izGT8nlS5GZ29l7UH9v/m/pNz3oIjItb+o1d25k/nmcMkpizPoWrs
         HQYRfTFFQtKpP2+uaeYas6A5UR1LjrKx6mH6F/Uw92plQHUMmLPe+kR78dWhJjPG8HU+
         5upA==
X-Gm-Message-State: AJIora+K1U8YnR195k58Y+N7Sq+2mZKjfpsmyzPoYLZ8tSTZOSjQpdPk
        KKTf9Xr8NFDi/FpfsmJ9sWY0+0JJ4VgctpafJJOmyZBBqQpLSA==
X-Google-Smtp-Source: AGRyM1tRXLh3lv/S1lvHwP8eokS1mx+lFTZoGX3rVrF1bNj23eHMxubdK1AuFvWVbEWZk8dvfCP1WOnlb0Z+
X-Received: by 2002:a65:610f:0:b0:408:8af8:28fd with SMTP id z15-20020a65610f000000b004088af828fdmr3773097pgu.286.1655918678409;
        Wed, 22 Jun 2022 10:24:38 -0700 (PDT)
Received: from riotgames.com ([163.116.131.243])
        by smtp-relay.gmail.com with ESMTPS id w24-20020a17090aaf9800b001ec9e27742dsm2230pjq.17.2022.06.22.10.24.38
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 10:24:38 -0700 (PDT)
X-Relaying-Domain: riotgames.com
Received: by mail-qk1-f199.google.com with SMTP id i16-20020a05620a249000b006aedb25493cso2824012qkn.15
        for <bpf@vger.kernel.org>; Wed, 22 Jun 2022 10:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eg7pKoREa62TqDRaU+yo2zrV2x8I6979kwBHk4P4AYE=;
        b=U40zH1A0nsIU3C11b6t2RtEag/I6/6Q5eEbPZKTaTfpUbfOjaEWrGDc866SG/INK35
         1EFdMcPJZteT9+M4NW1Yms+k4RBYZvvsYuX9CEothlBXRGGl9bnK+Mbz3vvxLNbgsWTX
         FcfEwQev8Nj+DBdD55qFCN6OJutEpn/XZ/TS0=
X-Received: by 2002:a05:620a:4591:b0:6a7:5a82:3d2d with SMTP id bp17-20020a05620a459100b006a75a823d2dmr3163073qkb.694.1655918677020;
        Wed, 22 Jun 2022 10:24:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4591:b0:6a7:5a82:3d2d with SMTP id
 bp17-20020a05620a459100b006a75a823d2dmr3163048qkb.694.1655918676729; Wed, 22
 Jun 2022 10:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220622091447.243101-1-ciara.loftus@intel.com>
In-Reply-To: <20220622091447.243101-1-ciara.loftus@intel.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Wed, 22 Jun 2022 12:24:25 -0500
Message-ID: <CAC1LvL2zjEF16_Gbwrxwke7wpeKxNKR=vd_E2N_CpDezeo4sbw@mail.gmail.com>
Subject: Re: [PATCH net-next] i40e: xsk: read the XDP program once per NAPI
To:     Ciara Loftus <ciara.loftus@intel.com>
Cc:     intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
        kuba@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        magnus.karlsson@intel.com, maciej.fijalkowski@intel.com
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 4:15 AM Ciara Loftus <ciara.loftus@intel.com> wrote:
>
> Similar to how it's done in the ice driver since 'eb087cd82864 ("ice:
> propagate xdp_ring onto rx_ring")', read the XDP program once per NAPI
> instead of once per descriptor cleaned. I measured an improvement in
> throughput of 2% for the AF_XDP xdpsock l2fwd benchmark in busy polling
> mode on my platform.
>

Should the same improvement be made to i40e_run_xdp/i40e_clean_rx_irq for the
non-AF_XDP case?

> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index af3e7e6afc85..2f422c61ac11 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -146,17 +146,13 @@ int i40e_xsk_pool_setup(struct i40e_vsi *vsi, struct xsk_buff_pool *pool,
>   *
>   * Returns any of I40E_XDP_{PASS, CONSUMED, TX, REDIR}
>   **/
> -static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp)
> +static int i40e_run_xdp_zc(struct i40e_ring *rx_ring, struct xdp_buff *xdp,
> +                          struct bpf_prog *xdp_prog)
>  {
>         int err, result = I40E_XDP_PASS;
>         struct i40e_ring *xdp_ring;
> -       struct bpf_prog *xdp_prog;
>         u32 act;
>
> -       /* NB! xdp_prog will always be !NULL, due to the fact that
> -        * this path is enabled by setting an XDP program.
> -        */
> -       xdp_prog = READ_ONCE(rx_ring->xdp_prog);
>         act = bpf_prog_run_xdp(xdp_prog, xdp);
>
>         if (likely(act == XDP_REDIRECT)) {
> @@ -339,9 +335,15 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>         u16 next_to_clean = rx_ring->next_to_clean;
>         u16 count_mask = rx_ring->count - 1;
>         unsigned int xdp_res, xdp_xmit = 0;
> +       struct bpf_prog *xdp_prog;
>         bool failure = false;
>         u16 cleaned_count;
>
> +       /* NB! xdp_prog will always be !NULL, due to the fact that
> +        * this path is enabled by setting an XDP program.
> +        */
> +       xdp_prog = READ_ONCE(rx_ring->xdp_prog);
> +
>         while (likely(total_rx_packets < (unsigned int)budget)) {
>                 union i40e_rx_desc *rx_desc;
>                 unsigned int rx_packets;
> @@ -378,7 +380,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
>                 xsk_buff_set_size(bi, size);
>                 xsk_buff_dma_sync_for_cpu(bi, rx_ring->xsk_pool);
>
> -               xdp_res = i40e_run_xdp_zc(rx_ring, bi);
> +               xdp_res = i40e_run_xdp_zc(rx_ring, bi, xdp_prog);
>                 i40e_handle_xdp_result_zc(rx_ring, bi, rx_desc, &rx_packets,
>                                           &rx_bytes, size, xdp_res, &failure);
>                 if (failure)
> --
> 2.25.1
>
