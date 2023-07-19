Return-Path: <bpf+bounces-5384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0675A0C1
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 23:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752EA281AD8
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 21:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A725152;
	Wed, 19 Jul 2023 21:51:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF291BB23;
	Wed, 19 Jul 2023 21:51:21 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E41FF1;
	Wed, 19 Jul 2023 14:51:18 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7654e1d83e8so15086685a.1;
        Wed, 19 Jul 2023 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689803478; x=1690408278;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6znaKwzT2W7vgJvU/pVQCid0fljnEMc1pWgZYNykTk=;
        b=XmWaPZelNKumkFx7Y9x+5cV9BKFzHFOJ5Rw4EGMUCZ5Xe5tr+BiSG73d6Xo89y34sS
         iNAcvQtOvOXLA3bx2Yw4euTOn7VRjKEDDRXHukFkHKhAuNRXCeZPmwPL2isEUaP+Z6EG
         evymV5lHSfGpVtvxa89yS58xQ2n8QmUCbiHfucRhk3hy3NIJoRPmGBjCd5p1A0jRtD/o
         Mb9E/0pVy2SA37Tc5trL8ChgC1GKIBn5ansYPaZJokhzBgqaLVLOyQ54QQrHK1tm4vPq
         xrCW5j0vtNiDjreOAiZPafiWFMligRLI5hEPPhnIEcfYQNR8p7ujFACikCg3lB9rg5X9
         4NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689803478; x=1690408278;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I6znaKwzT2W7vgJvU/pVQCid0fljnEMc1pWgZYNykTk=;
        b=HQzJ8wy/s7mGKJkJ7oQgsdICyzzfzunXSKWkrDc8g41125BKr0nhW45hlQFvzIgW2n
         YjlVCYgMDbFiUrCDiQk9eXOvdA/Tl/SX3lw5hZ+81Wie8H4LoYrG/BsYiL+etMTmEesG
         LtcQ5Ug4fYeJn+2wTjYHYQZWxjEIxwG/TCqwgWETMic1cv1Lrk6KdSx9W3um5FC0rTiu
         i/+F4FfktpHNsHj8XlIOZME25ZrDx4n5933lzwm5qX4k1H+SAuP89vJ7uxnx/ybtCLbD
         Tj8C+0X+qnrvPItGQwW7ZHrp7LvV8tXetf9tfechaB0MGJobqP8MBdFRaiUmLMY6sVLD
         Fl4w==
X-Gm-Message-State: ABy/qLZNXJZsegmem7yrlf1MkSChIA43IC8TMXdJWvUsLnt8CjqgWQxl
	SC5VqmppCYdSYwtNB9nfpR0=
X-Google-Smtp-Source: APBJJlHqk3S7ZpojYwSyvRrCvv1sgJVWHTPYVfGlfEacATFU0U8JXzpg0wi7I8vfifs6luEC3o70mQ==
X-Received: by 2002:a05:620a:258e:b0:766:fa1f:4ea4 with SMTP id x14-20020a05620a258e00b00766fa1f4ea4mr992430qko.1.1689803477790;
        Wed, 19 Jul 2023 14:51:17 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id f21-20020ae9ea15000000b00767b37256ecsm1529421qkg.107.2023.07.19.14.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 14:51:17 -0700 (PDT)
Date: Wed, 19 Jul 2023 17:51:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yhs@fb.com, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jesper Dangaard Brouer <brouer@redhat.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Alexander Lobakin <alexandr.lobakin@intel.com>, 
 Magnus Karlsson <magnus.karlsson@gmail.com>, 
 Maryam Tahhan <mtahhan@redhat.com>, 
 xdp-hints@xdp-project.net, 
 netdev@vger.kernel.org
Message-ID: <64b85ad52d012_2849c1294df@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230719185930.6adapqctxfdsfmye@macbook-pro-8.dhcp.thefacebook.com>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-14-larysa.zaremba@intel.com>
 <20230719185930.6adapqctxfdsfmye@macbook-pro-8.dhcp.thefacebook.com>
Subject: Re: [PATCH bpf-next v3 13/21] ice: Implement checksum hint
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexei Starovoitov wrote:
> On Wed, Jul 19, 2023 at 08:37:26PM +0200, Larysa Zaremba wrote:
> > Implement .xmo_rx_csum callback to allow XDP code to determine,
> > whether HW has validated any checksums.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > index 54685d0747aa..6647a7e55ac8 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> > @@ -660,8 +660,37 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan_tci,
> >  	return 0;
> >  }
> >  
> > +/**
> > + * ice_xdp_rx_csum_lvl - Get level, at which HW has checked the checksum
> > + * @ctx: XDP buff pointer
> > + * @csum_status: destination address
> > + * @csum_info: destination address
> > + *
> > + * Copy HW checksum level (if was checked) to the destination address.
> > + */
> > +static int ice_xdp_rx_csum(const struct xdp_md *ctx,
> > +			   enum xdp_csum_status *csum_status,
> > +			   union xdp_csum_info *csum_info)
> > +{
> > +	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
> > +	const union ice_32b_rx_flex_desc *eop_desc;
> > +	enum ice_rx_csum_status status;
> > +	u16 ptype;
> > +
> > +	eop_desc = xdp_ext->pkt_ctx.eop_desc;
> > +	ptype = ice_get_ptype(eop_desc);
> > +
> > +	status = ice_get_rx_csum_status(eop_desc, ptype);
> > +	if (status & ICE_RX_CSUM_NONE)
> > +		return -ENODATA;
> > +
> > +	*csum_status = ice_rx_csum_lvl(status) + 1;
> > +	return 0;
> > +}
> 
> and xdp_csum_info from previous patch left uninitialized?
> What was the point adding it then?

I suppose this driver only returns CHECKSUM_NONE or
CHECKSUM_UNNECESSARY? Also based on a grep of the driver dir.

In general the layout makes sense to me, and +1 on supporting
other drivers that do return CHECKSUM_COMPLETE or CHECKSUM_PARTIAL
rigth from the start.




