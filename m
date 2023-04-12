Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702246E011C
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 23:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjDLVpv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 17:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjDLVpu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 17:45:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65476E91
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:45:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-633fc0484d4so891563b3a.3
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681335945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crYbUvMM+qq+UublWGJRe3AoZOF0jnjMgrzBIUloc5g=;
        b=FZVlIxDNVsZwWF/x8+9ck8AoUV65kkPC7hntmEUT/3gG4c1Hh4S5+D9+VJDE0A2pyZ
         jyEiBgaU4tE3TOFAQ0yJfZydDVj2SaJtAcSSgmvs5c187MwaugrZnCsknQwLuh+eI6iR
         jHhicBe7jcyvpbl3t5ILAmyYfCCYrGdTKYoGMAn5KpsPFqFaF8l4hj8tBRPED8kces2M
         jnkP5yRG/Fjxq7JAm/nougsXhYUODDqFACmN6o1cxSRN6F4sgK/chMqzKShWJMxsuYtY
         lRkb/AoINLm0GEHDImKvIdJCo2IdYhZ12OJBzYFcMhd7rjsRYo+Cb0OO6KyQPr51YrGE
         lnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681335945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crYbUvMM+qq+UublWGJRe3AoZOF0jnjMgrzBIUloc5g=;
        b=dqeyhYrJ1yLTocqoOppElqX/fGO68ZnPJDCf+LEPauJLn3uEsRvo5VfFA5QpqUlBed
         ZWFbPUc2sKU68K5N7+kGpI0dM8x2MjlsqP2FXOJ1cy8F7DLXjngjImKPnC9MFOKJHzhf
         QGHU3HEglVbwLWn2oLbtmrPb+drOvZ3zKrQn4nHVCdLGsiVr93LDt8+NPOtCfbW3DBcD
         Ul++r7EJAj2XKiWJ3f80eFgBqaAWYKPyKQ7GT9J7RZu0KmUo9Jx4KrHb9vaGcBnkLWU8
         40YSPGCHeG2ZYKRRdd0nsPfGbay/F1TrzerYmeg8z6pfBJpWgYQ+0u3JYwQogafT7CTi
         wVrg==
X-Gm-Message-State: AAQBX9f9LMSa9HLbdoDxfI4vK41UmTNMKjwklRDNxUDjCXPrPfLYrndP
        N0RvX07112/zmebkvJWFRyG/RqUMjfBYdt1sif4X9g==
X-Google-Smtp-Source: AKy350Y4/CZ4xHgg7rgydXEnmBND7Bc9oWAWjxox1vGjOiW+xJf6D2ah+ReO9z41JoyXkvPUW37w48iqNd537EdYth0=
X-Received: by 2002:aa7:88d4:0:b0:639:fed3:c57 with SMTP id
 k20-20020aa788d4000000b00639fed30c57mr168839pff.5.1681335945114; Wed, 12 Apr
 2023 14:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230412094235.589089-1-yoong.siang.song@intel.com>
 <20230412094235.589089-4-yoong.siang.song@intel.com> <ZDbjkwGS5L9wdS5h@google.com>
 <677ed6c5-51fc-4b8b-d9a4-42e4cfe9006c@intel.com>
In-Reply-To: <677ed6c5-51fc-4b8b-d9a4-42e4cfe9006c@intel.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 12 Apr 2023 14:45:33 -0700
Message-ID: <CAKH8qBtXTAZr5r1VC9ynSvGv5jWMD54d=-2qmBc9Zr3ui9HnEg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/4] net: stmmac: add Rx HWTS metadata to XDP
 receive pkt
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     Song Yoong Siang <yoong.siang.song@intel.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 1:56=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
>
>
> On 4/12/2023 10:00 AM, Stanislav Fomichev wrote:
> > On 04/12, Song Yoong Siang wrote:
> >> Add receive hardware timestamp metadata support via kfunc to XDP recei=
ve
> >> packets.
> >>
> >> Suggested-by: Stanislav Fomichev <sdf@google.com>
> >> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> >> ---
> >>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 +++
> >>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 26 ++++++++++++++++++=
-
> >>  2 files changed, 28 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac.h
> >> index ac8ccf851708..826ac0ec88c6 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> >> @@ -94,6 +94,9 @@ struct stmmac_rx_buffer {
> >>
> >>  struct stmmac_xdp_buff {
> >>      struct xdp_buff xdp;
> >> +    struct stmmac_priv *priv;
> >> +    struct dma_desc *p;
> >> +    struct dma_desc *np;
> >>  };
> >>
> >>  struct stmmac_rx_queue {
> >> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drive=
rs/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> index f7bbdf04d20c..ed660927b628 100644
> >> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> >> @@ -5315,10 +5315,15 @@ static int stmmac_rx(struct stmmac_priv *priv,=
 int limit, u32 queue)
> >>
> >>                      xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
> >>                      xdp_prepare_buff(&ctx.xdp, page_address(buf->page=
),
> >> -                                     buf->page_offset, buf1_len, fals=
e);
> >> +                                     buf->page_offset, buf1_len, true=
);
> >>
> >>                      pre_len =3D ctx.xdp.data_end - ctx.xdp.data_hard_=
start -
> >>                                buf->page_offset;
> >> +
> >> +                    ctx.priv =3D priv;
> >> +                    ctx.p =3D p;
> >> +                    ctx.np =3D np;
> >> +
> >>                      skb =3D stmmac_xdp_run_prog(priv, &ctx.xdp);
> >>                      /* Due xdp_adjust_tail: DMA sync for_device
> >>                       * cover max len CPU touch
> >> @@ -7071,6 +7076,23 @@ void stmmac_fpe_handshake(struct stmmac_priv *p=
riv, bool enable)
> >>      }
> >>  }
> >>
> >> +static int stmmac_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *ti=
mestamp)
> >> +{
> >> +    const struct stmmac_xdp_buff *ctx =3D (void *)_ctx;
> >> +
> >> +    *timestamp =3D 0;
> >> +    stmmac_get_rx_hwtstamp(ctx->priv, ctx->p, ctx->np, timestamp);
> >> +
> >
> > [..]
> >
> >> +    if (*timestamp)
> >
> > Nit: does it make sense to change stmmac_get_rx_hwtstamp to return bool
> > to indicate success/failure? Then you can do:
> >
> > if (!stmmac_get_rx_hwtstamp())
> >       reutrn -ENODATA;
>
> I would make it return the -ENODATA directly since typically bool
> true/false functions have names like "stmmac_has_rx_hwtstamp" or similar
> name that infers you're answering a true/false question.
>
> That might also let you avoid zeroing the timestamp value first?

SGTM!

> Thanks,
> Jake
