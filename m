Return-Path: <bpf+bounces-4180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9437C749515
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D3C1C20C96
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 05:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9D110C;
	Thu,  6 Jul 2023 05:50:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E993A47;
	Thu,  6 Jul 2023 05:50:35 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF986110;
	Wed,  5 Jul 2023 22:50:33 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666ed230c81so375114b3a.0;
        Wed, 05 Jul 2023 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688622633; x=1691214633;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KqsODTKbZmN8UTNNadCpXQZDsIrjIswwPW+/1H0i60=;
        b=pkM3d8a2FY2p6XIJSq3BsHN/NilulK+jKTWoe15XMGMBpPQa2rSLATnNv+JmTyVoqN
         wkRZWagfLr7x8JSNUSRM8IFXmaAm4xnmtRGxsvsr7s95JDJoHKqDZyDThqG4MHrGXj7i
         NNQbZZhDZ+ILBscYtcrg0F7c+RneNX38uhQXNCWA6OygspHLe4ffh9eaqFqUxe4JkDyF
         b3w8LKFdPigvyal38RHfCfHQN2xmNkbzF8QvaWI4DUMBWDfVe5ctm23gPRGqzf8fWl8D
         o/NSI2RNaxMuQ8IuLIL4hD8zAcoj0tX60x9dpyqhTu4SgrlWUNvo8B7cPpaXSyV79yev
         GGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688622633; x=1691214633;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6KqsODTKbZmN8UTNNadCpXQZDsIrjIswwPW+/1H0i60=;
        b=FTt7G91QTKN7Xaxm0SIEGbgisGEKNKIwHDvcxCm1XNLMRWTwYPXdiZmkFAJPlS7hxj
         Fpc02SlNU++6ZPucpIeWU+VrJfJ42VnLLCxDr3AqkA5hPVpVLI3aUPQYcSSe4xIm1el4
         XU8ITFduu1uuHdOOVOMrKrGd+3seJhRw4Iq1INot1SiYK0WpQEI7HqYtuhSeFB/+mqDH
         J4GVz+9bz9g7Tj66cdoFW7Ex2GI+1eSJtCwnkk+SwCiQCXtuMEsRhYj/yD5gqMwtRzzi
         MTWa7daEn+zH094ewh9bH7/kjwshF/GLHpk2jTMhHM8pc2flOvusfdEVVwsEN+ycVpua
         oFPA==
X-Gm-Message-State: ABy/qLbuI3/bzEQ9AtpgrhOfuqbFQ5EovxH3qoq7+tLWkUdNI2R5tqwd
	i/jzixK8bArmi4xqR/XSQ6s=
X-Google-Smtp-Source: APBJJlEktT3qq0Z6n8MOrcFoLqPhNIKKDhh5jX78z9X5sh0L4KFZern6+qAEVmsmYveHjKrFdtC3NA==
X-Received: by 2002:a05:6a00:1a8a:b0:668:79d6:34df with SMTP id e10-20020a056a001a8a00b0066879d634dfmr1012583pfv.23.1688622632998;
        Wed, 05 Jul 2023 22:50:32 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba10::41f])
        by smtp.gmail.com with ESMTPSA id ey2-20020a056a0038c200b006828a3c259fsm449353pfb.104.2023.07.05.22.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 22:50:32 -0700 (PDT)
Date: Wed, 05 Jul 2023 22:50:31 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>, 
 Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 brouer@redhat.com, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yhs@fb.com, 
 kpsingh@kernel.org, 
 sdf@google.com, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Anatoly Burakov <anatoly.burakov@intel.com>, 
 Alexander Lobakin <alexandr.lobakin@intel.com>, 
 Magnus Karlsson <magnus.karlsson@gmail.com>, 
 Maryam Tahhan <mtahhan@redhat.com>, 
 xdp-hints@xdp-project.net, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Duyck <alexander.duyck@gmail.com>
Message-ID: <64a656273ee15_b20ce2087a@john.notmuch>
In-Reply-To: <ZKQAPBcIE/iCkiX2@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-13-larysa.zaremba@intel.com>
 <64a331c338a5a_628d3208cb@john.notmuch>
 <ZKPlZ6Z8ni5+ZJCK@lincoln>
 <9cd44759-416c-7274-f805-ee9d756f15b1@redhat.com>
 <ZKQAPBcIE/iCkiX2@lincoln>
Subject: Re: [PATCH bpf-next v2 12/20] xdp: Add checksum level hint
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

Larysa Zaremba wrote:
> On Tue, Jul 04, 2023 at 12:39:06PM +0200, Jesper Dangaard Brouer wrote:
> > Cc. DaveM+Alex Duyck, as I value your insights on checksums.
> > 
> > On 04/07/2023 11.24, Larysa Zaremba wrote:
> > > On Mon, Jul 03, 2023 at 01:38:27PM -0700, John Fastabend wrote:
> > > > Larysa Zaremba wrote:
> > > > > Implement functionality that enables drivers to expose to XDP code,
> > > > > whether checksums was checked and on what level.
> > > > > 
> > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > ---
> > > > >   Documentation/networking/xdp-rx-metadata.rst |  3 +++
> > > > >   include/linux/netdevice.h                    |  1 +
> > > > >   include/net/xdp.h                            |  2 ++
> > > > >   kernel/bpf/offload.c                         |  2 ++
> > > > >   net/core/xdp.c                               | 21 ++++++++++++++++++++
> > > > >   5 files changed, 29 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> > > > > index ea6dd79a21d3..4ec6ddfd2a52 100644
> > > > > --- a/Documentation/networking/xdp-rx-metadata.rst
> > > > > +++ b/Documentation/networking/xdp-rx-metadata.rst
> > > > > @@ -26,6 +26,9 @@ metadata is supported, this set will grow:
> > > > >   .. kernel-doc:: net/core/xdp.c
> > > > >      :identifiers: bpf_xdp_metadata_rx_vlan_tag
> > > > > +.. kernel-doc:: net/core/xdp.c
> > > > > +   :identifiers: bpf_xdp_metadata_rx_csum_lvl
> > > > > +
> > > > >   An XDP program can use these kfuncs to read the metadata into stack
> > > > >   variables for its own consumption. Or, to pass the metadata on to other
> > > > >   consumers, an XDP program can store it into the metadata area carried
> > > > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > > > index 4fa4380e6d89..569563687172 100644
> > > > > --- a/include/linux/netdevice.h
> > > > > +++ b/include/linux/netdevice.h
> > > > > @@ -1660,6 +1660,7 @@ struct xdp_metadata_ops {
> > > > >   			       enum xdp_rss_hash_type *rss_type);
> > > > >   	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
> > > > >   				   __be16 *vlan_proto);
> > > > > +	int	(*xmo_rx_csum_lvl)(const struct xdp_md *ctx, u8 *csum_level);
> > > > >   };
> > > > >   /**
> > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > index 89c58f56ffc6..61ed38fa79d1 100644
> > > > > --- a/include/net/xdp.h
> > > > > +++ b/include/net/xdp.h
> > > > > @@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > > > >   			   bpf_xdp_metadata_rx_hash) \
> > > > >   	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> > > > >   			   bpf_xdp_metadata_rx_vlan_tag) \
> > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM_LVL, \
> > > > > +			   bpf_xdp_metadata_rx_csum_lvl) \
> > > > >   enum {
> > > > >   #define XDP_METADATA_KFUNC(name, _) name,
> > > > > diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> > > > > index 986e7becfd42..a133fb775f49 100644
> > > > > --- a/kernel/bpf/offload.c
> > > > > +++ b/kernel/bpf/offload.c
> > > > > @@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
> > > > >   		p = ops->xmo_rx_hash;
> > > > >   	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
> > > > >   		p = ops->xmo_rx_vlan_tag;
> > > > > +	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM_LVL))
> > > > > +		p = ops->xmo_rx_csum_lvl;
> > > > >   out:
> > > > >   	up_read(&bpf_devs_lock);
> > > > > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > > > > index f6262c90e45f..c666d3e0a26c 100644
> > > > > --- a/net/core/xdp.c
> > > > > +++ b/net/core/xdp.c
> > > > > @@ -758,6 +758,27 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan
> > > > >   	return -EOPNOTSUPP;
> > > > >   }
> > > > > +/**
> > > > > + * bpf_xdp_metadata_rx_csum_lvl - Get depth at which HW has checked the checksum.
> > > > > + * @ctx: XDP context pointer.
> > > > > + * @csum_level: Return value pointer.
> > > > > + *
> > > > > + * In case of success, csum_level contains depth of the last verified checksum.
> > > > > + * If only the outermost checksum was verified, csum_level is 0, if both
> > > > > + * encapsulation and inner transport checksums were verified, csum_level is 1,
> > > > > + * and so on.
> > > > > + * For more details, refer to csum_level field in sk_buff.
> > > > > + *
> > > > > + * Return:
> > > > > + * * Returns 0 on success or ``-errno`` on error.
> > > > > + * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
> > > > > + * * ``-ENODATA``    : Checksum was not validated
> > > > > + */
> > > > > +__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
> > > > 
> > > > Istead of ENODATA should we return what would be put in the ip_summed field
> > > > CHECKSUM_{NONE, UNNECESSARY, COMPLETE, PARTIAL}? Then sig would be,
> > 
> > I was thinking the same, what about checksum "type".
> > 
> > > > 
> > > >   bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *type, u8 *lvl);
> > > > 
> > > > or something like that? Or is the thought that its not really necessary?
> > > > I don't have a strong preference but figured it was worth asking.
> > > > 
> > > 
> > > I see no value in returning CHECKSUM_COMPLETE without the actual checksum value.
> > > Same with CHECKSUM_PARTIAL and csum_start. Returning those values too would
> > > overcomplicate the function signature.
> > 
> > So, this kfunc bpf_xdp_metadata_rx_csum_lvl() success is it equivilent to
> > CHECKSUM_UNNECESSARY?
> 
> This is 100% true for physical NICs, it's more complicated for veth, bacause it 
> often receives CHECKSUM_PARTIAL, which shouldn't normally apprear on RX, but is 
> treated by the network stack as a validated checksum, because there is no way 
> internally generated packet could be messed up. I would be grateful if you could 
> look at the veth patch and share your opinion about this.
> 
> > 
> > Looking at documentation[1] (generated from skbuff.h):
> >  [1] https://kernel.org/doc/html/latest/networking/skbuff.html#checksumming-of-received-packets-by-device
> > 
> > Is the idea that we can add another kfunc (new signature) than can deal
> > with the other types of checksums (in a later kernel release)?
> >
> 
> Yes, that is the idea.

If we think there is a chance we might need another kfunc we should add it
in the same kfunc. It would be unfortunate to have to do two kfuncs when
one would work. It shouldn't cost much/anything(?) to hardcode the type for
most cases? I think if we need it later I would advocate for updating this
kfunc to support it. Of course then userspace will have to swivel on the
kfunc signature.

