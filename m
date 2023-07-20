Return-Path: <bpf+bounces-5471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0416775B085
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 15:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8BE281E74
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDFB182C3;
	Thu, 20 Jul 2023 13:55:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE23182A8;
	Thu, 20 Jul 2023 13:55:19 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB4BE6F;
	Thu, 20 Jul 2023 06:55:18 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4053cc10debso6614621cf.2;
        Thu, 20 Jul 2023 06:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689861317; x=1690466117;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmQzphPp6MsTwBmccR9FSyIZcou9tRoCvSUS9C0hUzU=;
        b=FVKeE7iIzIcTqqTBE32N6Hi81S6a5PvH88h6tsACN+Itpd4kHLEnohSwcVcWpavPWR
         O0nqaKMsOA/DQl+xnCdmZ2fGSbBW9Tec823RoOwGS+9f7AuIJLj93yAYN5dthy1xZz6V
         bwrb+5JlF4lSGINVZYdL59H9oUiZb4uDE850YWdDGkmFyPN0M66QqSrqZThd6ftt51c9
         42Q6ARjtsWB5AP9kDf9jdi4uTXyzjZANT69seQVfnBZNYVVc3gVV2jPcX9tcvgJWP3JB
         QpZMxUtjEKuNFi3HSsffAwWhHmncoMQDtfFi/mwox5EkROFb6PWg/xVb1N3bj5uA+Au4
         q/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861317; x=1690466117;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZmQzphPp6MsTwBmccR9FSyIZcou9tRoCvSUS9C0hUzU=;
        b=cK00xamlwh/L3fLVkyPwCLpgAwdyhh3WiyAJ7PM7Px5qVPszFdKUjwE/DimUpGsNOH
         Uyxqg/S9FgFyigSZgadedrvaxPn137w1GCZj8TnQIWjbpRnVLShI/EoRx6aBdvH28aRJ
         T2yiW8jvRoakXb7vXy+IKWjGiyozTGM6NrnofOYWVwF7bGNkhjUP+sxA8SylRZrnb7kM
         FkPRaQnmj1FPyDHHN2DOigAkmQnmQB3VuJI1HTcf0U/l8wCbYewxb7/RVRUI66fAvlp5
         MBH//9GVIk0aw+DmelCD5kO8D+6BOmV/xlTkbi+I2cGvYPTxSvHIfvCVEMB+m7B7tcpv
         VQcA==
X-Gm-Message-State: ABy/qLZNRkLVefGT/Ua4oUhLI1+rFPMJ46uWgaIQH5Q2HyJRY8icY5iZ
	gfvG9lc+TGEcHGXlrf2idjg=
X-Google-Smtp-Source: APBJJlHt8gW9/kRasKkWTHQdzcYBTRPNmDl9FEOLu6xE+ywV6+D7gwx0OeCSgxRgBJcOHOXFSFX/ow==
X-Received: by 2002:ac8:5992:0:b0:405:4673:58e0 with SMTP id e18-20020ac85992000000b00405467358e0mr850583qte.63.1689861317098;
        Thu, 20 Jul 2023 06:55:17 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id n15-20020ac8674f000000b004033c3948f9sm326503qtp.42.2023.07.20.06.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:55:16 -0700 (PDT)
Date: Thu, 20 Jul 2023 09:55:16 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "ast@kernel.org" <ast@kernel.org>, 
 "daniel@iogearbox.net" <daniel@iogearbox.net>, 
 "andrii@kernel.org" <andrii@kernel.org>, 
 "martin.lau@linux.dev" <martin.lau@linux.dev>, 
 "song@kernel.org" <song@kernel.org>, 
 "yhs@fb.com" <yhs@fb.com>, 
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
 "kpsingh@kernel.org" <kpsingh@kernel.org>, 
 "sdf@google.com" <sdf@google.com>, 
 "haoluo@google.com" <haoluo@google.com>, 
 "jolsa@kernel.org" <jolsa@kernel.org>, 
 David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 "Brouer, Jesper" <brouer@redhat.com>, 
 "Burakov, Anatoly" <anatoly.burakov@intel.com>, 
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>, 
 Magnus Karlsson <magnus.karlsson@gmail.com>, 
 "Tahhan, Maryam" <mtahhan@redhat.com>, 
 "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <64b93cc46ad9b_2ad92129445@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZLkHK6Zbqwkxc8WM@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-13-larysa.zaremba@intel.com>
 <64b858ac9edd3_2849c129476@willemb.c.googlers.com.notmuch>
 <ZLkD/XWi+eQU9AQC@lincoln>
 <ZLkHK6Zbqwkxc8WM@lincoln>
Subject: Re: [PATCH bpf-next v3 12/21] xdp: Add checksum hint
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

Zaremba, Larysa wrote:
> On Thu, Jul 20, 2023 at 09:57:05AM +0000, Zaremba, Larysa wrote:
> > On Wed, Jul 19, 2023 at 05:42:04PM -0400, Willem de Bruijn wrote:
> > > Larysa Zaremba wrote:
> > > > Implement functionality that enables drivers to expose to XDP code checksum
> > > > information that consists of:
> > > > 
> > > > - Checksum status - bitfield that consists of
> > > >   - number of consecutive validated checksums. This is almost the same as
> > > >     csum_level in skb, but starts with 1. Enum names for those bits still
> > > >     use checksum level concept, so it is less confusing for driver
> > > >     developers.
> > > >   - Is checksum partial? This bit cannot coexist with any other
> > > >   - Is there a complete checksum available?
> > > > - Additional checksum data, a union of:
> > > >   - checksum start and offset, if checksum is partial
> > > >   - complete checksum, if available
> > > > 
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > ---
> > > >  Documentation/networking/xdp-rx-metadata.rst |  3 ++
> > > >  include/linux/netdevice.h                    |  3 ++
> > > >  include/net/xdp.h                            | 46 ++++++++++++++++++++
> > > >  kernel/bpf/offload.c                         |  2 +
> > > >  net/core/xdp.c                               | 23 ++++++++++
> > > >  5 files changed, 77 insertions(+)
> > > > 
> > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > > index ea6dd79a21d3..7f056a44f682 100644
> > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> > > >  .. kernel-doc:: net/core/xdp.c
> > > >     :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > >  
> > > > +.. kernel-doc:: net/core/xdp.c
> > > > +   :identifiers: bpf_xdp_metadata_rx_csum
> > > > +
> > > >  An XDP program can use these kfuncs to read the metadata into stack
> > > >  variables for its own consumption. Or, to pass the metadata on to other
> > > >  consumers, an XDP program can store it into the metadata area carried
> > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > index 1749f4f75c64..4f6da36ac123 100644
> > > > --- a/include/linux/netdevice.h
> > > > +++ b/include/linux/netdevice.h
> > > > @@ -1660,6 +1660,9 @@ struct xdp_metadata_ops {
> > > >  			       enum xdp_rss_hash_type *rss_type);
> > > >  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
> > > >  				   __be16 *vlan_proto);
> > > > +	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
> > > > +			       enum xdp_csum_status *csum_status,
> > > > +			       union xdp_csum_info *csum_info);
> > > >  };
> > > >  
> > > >  /**
> > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > index 89c58f56ffc6..2b7a7d678ff4 100644
> > > > --- a/include/net/xdp.h
> > > > +++ b/include/net/xdp.h
> > > > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > > >  			   bpf_xdp_metadata_rx_hash) \
> > > >  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > > >  			   bpf_xdp_metadata_rx_vlan_tag) \
> > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
> > > > +			   bpf_xdp_metadata_rx_csum) \
> > > >  
> > > >  enum {
> > > >  #define XDP_METADATA_KFUNC(name, _) name,
> > > > @@ -448,6 +450,50 @@ enum xdp_rss_hash_type {
> > > >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
> > > >  };
> > > >  
> > > > +union xdp_csum_info {
> > > > +	/* Checksum referred to by ``csum_start + csum_offset`` is considered
> > > > +	 * valid, but was never calculated, TX device has to do this,
> > > > +	 * starting from csum_start packet byte.
> > > > +	 * Any preceding checksums are also considered valid.
> > > > +	 * Available, if ``status == XDP_CHECKSUM_PARTIAL``.
> > > > +	 */
> > > > +	struct {
> > > > +		u16 csum_start;
> > > > +		u16 csum_offset;
> > > > +	};
> > > > +
> > > > +	/* Checksum, calculated over the whole packet.
> > > > +	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > > > +	 */
> > > > +	u32 checksum;
> > > > +};
> > > > +
> > > > +enum xdp_csum_status {
> > > > +	/* HW had parsed several transport headers and validated their
> > > > +	 * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
> > > > +	 * 3 least significat bytes contain number of consecutive checksum,
> > > 
> > > typo: significant
> > > 
> > > (I did not scan for typos, just came across this when trying to understand
> > > the skb->csum_level + 1 trick. Probably good to run a spell check).
> > >
> 
> Oh, and about skb->csum_level + 1, maybe this way it would be more 
> understandable: XDP_CHECKSUM_VALID_LVL0 + skb->csum_level?

Agreed, that would help document the intent.
 
> Using number of valid checksums (starts with 1) instead of checksum level 
> (starts with 0) is a debatable decision, but I have decided to go with it under 
> 2 assumptions:
> 
> - the only reason checksum level in skb starts with 0 is to use less bits
> - checksum number would be more intuitive for XDP/AF_XDP application developers
> 
> I encourage everyone to share their opinion on that.

I assumed this offset by one was because csum_status zero implicitly
meant XDP_CHECKSUM_NONE. Is that not correct? That should probably
get an explicit name.

