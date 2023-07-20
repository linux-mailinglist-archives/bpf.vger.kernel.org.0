Return-Path: <bpf+bounces-5559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6206975BA96
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 00:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933F51C211BB
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 22:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFF91DDF6;
	Thu, 20 Jul 2023 22:27:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A879168B4;
	Thu, 20 Jul 2023 22:27:44 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E62B3;
	Thu, 20 Jul 2023 15:27:43 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-765ae938b1bso120779785a.0;
        Thu, 20 Jul 2023 15:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689892062; x=1690496862;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcKhesrVeKLtLXd1iNI5/TtHDFxZo4Ec1vI3ofFv2C0=;
        b=pIEIzOoUyAZJgvfrDsJxPf0zzWbvWiTx6sfMKz6BMJZLMc0Gp1SHbnrUbklDgEDuYs
         /QHI2sCEAfEgKCWIC/80/q/F3upISVmOFH1oYwjOB4IkLvvx7SUwECw3jho+UEuK8Amt
         DapPWqruHvFV+75Ol8LoggfTjXyVSeZmOZYo6AE3g32M+I8ZTB5w/YZjMl7jew+ZQIH8
         WKeeTg6sDVgLhquaz/K6wA1Tm6OrdFH0QLOaPQsFKPQeof0yCfh4Wj/M3erHrXKCtB99
         DyHC5zWp8yF8D2KQ49a+fCQIFIGa8taCen+/d2EON8xkKHwOjOu32Wl5vv6bwqr24dFP
         jpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689892062; x=1690496862;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wcKhesrVeKLtLXd1iNI5/TtHDFxZo4Ec1vI3ofFv2C0=;
        b=lFLi7UdF1YkrP9zU3aUJatt5ePFzoEJaAiuHSMScwfJUivfShkSEU1MpSQAnv5O1Qi
         V6R6FQzauGXpnPOHleZCtrA1Nfd2ZGGSI/6zava7jKseAdS0GDqjusy4E23dnwgI9jVY
         25NfBVq0ErrV4Dh4oiF92v3phqWJpzbWCTW6lXgVRJS+rufVzr7hZfBr0UaIt58zn9rF
         Kuu1A/oCU6fwBW5geq9SvTuIdlcxwZ+VoEKvUijujkvrbg5AmsN1XTM1PVhpdhej+qdh
         owMmebGuylawt+iaYzYzU/ekQkaXDBpba30qO/CMv2w/hN6FvEFBY3ZYgGW3vRA6lU1K
         LbFQ==
X-Gm-Message-State: ABy/qLb4YTA+1vmW6Mo1pJ3gbpyYZHJWi9SxDhHa+aZNFM5erUBSWVCX
	wQVEZCjgxuJifDTSwgEHNl8=
X-Google-Smtp-Source: APBJJlEwJSrzsxt2v1eBTSo1BMVY1u4FA6mZQIZWPwmOe0ZeRV1ZQwKri/g15PxCSnRq8gm3z6kU2A==
X-Received: by 2002:a05:620a:cc1:b0:765:a57a:16fe with SMTP id b1-20020a05620a0cc100b00765a57a16femr48397qkj.76.1689892062290;
        Thu, 20 Jul 2023 15:27:42 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id j18-20020a0cf512000000b0063c666dc802sm791422qvm.27.2023.07.20.15.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 15:27:41 -0700 (PDT)
Date: Thu, 20 Jul 2023 18:27:41 -0400
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
Message-ID: <64b9b4ddae4e7_2c3d502944a@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZLlZ2E4rdKdBTqsf@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-13-larysa.zaremba@intel.com>
 <64b858ac9edd3_2849c129476@willemb.c.googlers.com.notmuch>
 <ZLkD/XWi+eQU9AQC@lincoln>
 <ZLkHK6Zbqwkxc8WM@lincoln>
 <64b93cc46ad9b_2ad92129445@willemb.c.googlers.com.notmuch>
 <ZLlZ2E4rdKdBTqsf@lincoln>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Zaremba, Larysa wrote:
> On Thu, Jul 20, 2023 at 09:55:16AM -0400, Willem de Bruijn wrote:
> > Zaremba, Larysa wrote:
> > > On Thu, Jul 20, 2023 at 09:57:05AM +0000, Zaremba, Larysa wrote:
> > > > On Wed, Jul 19, 2023 at 05:42:04PM -0400, Willem de Bruijn wrote:
> > > > > Larysa Zaremba wrote:
> > > > > > Implement functionality that enables drivers to expose to XDP code checksum
> > > > > > information that consists of:
> > > > > > 
> > > > > > - Checksum status - bitfield that consists of
> > > > > >   - number of consecutive validated checksums. This is almost the same as
> > > > > >     csum_level in skb, but starts with 1. Enum names for those bits still
> > > > > >     use checksum level concept, so it is less confusing for driver
> > > > > >     developers.
> > > > > >   - Is checksum partial? This bit cannot coexist with any other
> > > > > >   - Is there a complete checksum available?
> > > > > > - Additional checksum data, a union of:
> > > > > >   - checksum start and offset, if checksum is partial
> > > > > >   - complete checksum, if available
> > > > > > 
> > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > ---
> > > > > >  Documentation/networking/xdp-rx-metadata.rst |  3 ++
> > > > > >  include/linux/netdevice.h                    |  3 ++
> > > > > >  include/net/xdp.h                            | 46 ++++++++++++++++++++
> > > > > >  kernel/bpf/offload.c                         |  2 +
> > > > > >  net/core/xdp.c                               | 23 ++++++++++
> > > > > >  5 files changed, 77 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > index ea6dd79a21d3..7f056a44f682 100644
> > > > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > > > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> > > > > >  .. kernel-doc:: net/core/xdp.c
> > > > > >     :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > > > >  
> > > > > > +.. kernel-doc:: net/core/xdp.c
> > > > > > +   :identifiers: bpf_xdp_metadata_rx_csum
> > > > > > +
> > > > > >  An XDP program can use these kfuncs to read the metadata into stack
> > > > > >  variables for its own consumption. Or, to pass the metadata on to other
> > > > > >  consumers, an XDP program can store it into the metadata area carried
> > > > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > > > index 1749f4f75c64..4f6da36ac123 100644
> > > > > > --- a/include/linux/netdevice.h
> > > > > > +++ b/include/linux/netdevice.h
> > > > > > @@ -1660,6 +1660,9 @@ struct xdp_metadata_ops {
> > > > > >  			       enum xdp_rss_hash_type *rss_type);
> > > > > >  	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
> > > > > >  				   __be16 *vlan_proto);
> > > > > > +	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
> > > > > > +			       enum xdp_csum_status *csum_status,
> > > > > > +			       union xdp_csum_info *csum_info);
> > > > > >  };
> > > > > >  
> > > > > >  /**
> > > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > > index 89c58f56ffc6..2b7a7d678ff4 100644
> > > > > > --- a/include/net/xdp.h
> > > > > > +++ b/include/net/xdp.h
> > > > > > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > > > > >  			   bpf_xdp_metadata_rx_hash) \
> > > > > >  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > > > > >  			   bpf_xdp_metadata_rx_vlan_tag) \
> > > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
> > > > > > +			   bpf_xdp_metadata_rx_csum) \
> > > > > >  
> > > > > >  enum {
> > > > > >  #define XDP_METADATA_KFUNC(name, _) name,
> > > > > > @@ -448,6 +450,50 @@ enum xdp_rss_hash_type {
> > > > > >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
> > > > > >  };
> > > > > >  
> > > > > > +union xdp_csum_info {
> > > > > > +	/* Checksum referred to by ``csum_start + csum_offset`` is considered
> > > > > > +	 * valid, but was never calculated, TX device has to do this,
> > > > > > +	 * starting from csum_start packet byte.
> > > > > > +	 * Any preceding checksums are also considered valid.
> > > > > > +	 * Available, if ``status == XDP_CHECKSUM_PARTIAL``.
> > > > > > +	 */
> > > > > > +	struct {
> > > > > > +		u16 csum_start;
> > > > > > +		u16 csum_offset;
> > > > > > +	};
> > > > > > +
> > > > > > +	/* Checksum, calculated over the whole packet.
> > > > > > +	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > > > > > +	 */
> > > > > > +	u32 checksum;
> > > > > > +};
> > > > > > +
> > > > > > +enum xdp_csum_status {
> > > > > > +	/* HW had parsed several transport headers and validated their
> > > > > > +	 * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
> > > > > > +	 * 3 least significat bytes contain number of consecutive checksum,
> > > > > 
> > > > > typo: significant
> > > > > 
> > > > > (I did not scan for typos, just came across this when trying to understand
> > > > > the skb->csum_level + 1 trick. Probably good to run a spell check).
> > > > >
> > > 
> > > Oh, and about skb->csum_level + 1, maybe this way it would be more 
> > > understandable: XDP_CHECKSUM_VALID_LVL0 + skb->csum_level?
> > 
> > Agreed, that would help document the intent.
> >  
> > > Using number of valid checksums (starts with 1) instead of checksum level 
> > > (starts with 0) is a debatable decision, but I have decided to go with it under 
> > > 2 assumptions:
> > > 
> > > - the only reason checksum level in skb starts with 0 is to use less bits
> > > - checksum number would be more intuitive for XDP/AF_XDP application developers
> > > 
> > > I encourage everyone to share their opinion on that.
> > 
> > I assumed this offset by one was because csum_status zero implicitly
> > meant XDP_CHECKSUM_NONE. Is that not correct? That should probably
> > get an explicit name.
> > 
> 
> Well, I was not sure, whether I should add XDP_CHECKSUM_NONE, because it would 
> be equal to returning -ENODATA from kfunc, but after giving it some thought now, 
> it is worth to have XDP_CHECKSUM_NONE for packets that have no checksum to 
> check, like for hash there is XDP_RSS_TYPE_L2.

On receive, CHECKSUM_NONE means that the packet has not been checked, not
necessarily that it has no checksum. Perhaps the device was unable to
parse the protocol.

(on transmit, it conveys that a transmit checksum is not required.)

