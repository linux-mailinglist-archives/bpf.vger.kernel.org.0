Return-Path: <bpf+bounces-6325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 442EE76808C
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 18:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15DC282316
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75851171CC;
	Sat, 29 Jul 2023 16:15:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D81F4FE;
	Sat, 29 Jul 2023 16:15:26 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17703A9A;
	Sat, 29 Jul 2023 09:15:24 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6378cec43ddso17413076d6.2;
        Sat, 29 Jul 2023 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690647324; x=1691252124;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhbwdeVAVLw7w1LdIyvCySYdGFtXHpX0EQ+J02OgF0U=;
        b=dEGwFuN2TtPnnCqswhXXgKZbTaI/LyaH7uLwuU39srOhBfG/jFwEVr+Om8WABl+htd
         e9QEjLvfWSEst536eH66pyk1vjjoy2jJ0ZMk4fC3j7pvV7hKX+jDpeEeEg1Mj8kIFhEr
         P0XM46OkPvCVfL047wmCBuzSqx8e8YA7pzdUA9UyWUwZUwOSjRO+NFo8CUpBelXBJAXB
         3owEvVYN0YG8WOIwVtDsvJa8AdmILqHfFMExCbmbnv9g691x9pa7tLzrYx3D67RNGj1P
         w9gnxpdry6iloqAHZRSwbuv0+sQUp2YZz0dWXjvtDl9+yxZlfbvoFWLEXWOKBScwQZKH
         dYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690647324; x=1691252124;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yhbwdeVAVLw7w1LdIyvCySYdGFtXHpX0EQ+J02OgF0U=;
        b=Seg1oihRIv8GVghM6dpePbYrYXp+9G7nLrthfJ6/WuifQ4KMFDktAgBzIlkQqFcM4o
         jGPqNtSY8GdRFHjiAScm7k/bL4exIq/XjuhYWI6T+qSW3Zf/4cUNAGzQPrE1RQGmMnL9
         osuIu4+b0XJX7tBw/XHF+4GVIYduFiLY1IzSiE1iqaIoQUy9Po1GEMGEM2YRoDsMgv8M
         NxQZfCfx7Z2tSGay+JwEUflTwJrjCtw2RNvsOKBRCXFinpXOXDQt+Iw2G5xvqmaaxvOr
         HP5tpdzzDXiDTWrTm+gbGUJU2SMdXNB4zEL3XfxaKm51oiG+tVD8kuiow4ir7ofhR753
         QVbQ==
X-Gm-Message-State: ABy/qLaUWJO4snfSanH/WR4MtkGZwazmqqVGfK0ZVJz042/zTmV4gApH
	Ps7OhCvaeUFi5VrWfZs3Wej+Z2m1q70=
X-Google-Smtp-Source: APBJJlGt0Qsc8iu579OjS3dPBYko4Mly73GH0w3PE/9NxRgWO3Bi5UCQgQDNCukiPFPvWPSJIgavVg==
X-Received: by 2002:a0c:e287:0:b0:63c:d763:77b4 with SMTP id r7-20020a0ce287000000b0063cd76377b4mr5144562qvl.8.1690647323986;
        Sat, 29 Jul 2023 09:15:23 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id p15-20020a0ccb8f000000b0063d06253995sm2152667qvk.22.2023.07.29.09.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 09:15:23 -0700 (PDT)
Date: Sat, 29 Jul 2023 12:15:23 -0400
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
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Simon Horman <simon.horman@corigine.com>
Message-ID: <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com>
 <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
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

Alexei Starovoitov wrote:
> On Fri, Jul 28, 2023 at 07:39:14PM +0200, Larysa Zaremba wrote:
> >  
> > +union xdp_csum_info {
> > +	/* Checksum referred to by ``csum_start + csum_offset`` is considered
> > +	 * valid, but was never calculated, TX device has to do this,
> > +	 * starting from csum_start packet byte.
> > +	 * Any preceding checksums are also considered valid.
> > +	 * Available, if ``status == XDP_CHECKSUM_PARTIAL``.
> > +	 */
> > +	struct {
> > +		u16 csum_start;
> > +		u16 csum_offset;
> > +	};
> > +
> 
> CHECKSUM_PARTIAL makes sense on TX, but this RX. I don't see in the above.

It can be observed on RX when packets are looped.

This may be observed even in XDP on veth.
 
> > +	/* Checksum, calculated over the whole packet.
> > +	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > +	 */
> > +	u32 checksum;
> 
> imo XDP RX should only support XDP_CHECKSUM_COMPLETE with u32 checksum
> or XDP_CHECKSUM_UNNECESSARY.
> 
> > +};
> > +
> > +enum xdp_csum_status {
> > +	/* HW had parsed several transport headers and validated their
> > +	 * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
> > +	 * 3 least significant bytes contain number of consecutive checksums,
> > +	 * starting with the outermost, reported by hardware as valid.
> > +	 * ``sk_buff`` checksum level (``csum_level``) notation is provided
> > +	 * for driver developers.
> > +	 */
> > +	XDP_CHECKSUM_VALID_LVL0		= 1,	/* 1 outermost checksum */
> > +	XDP_CHECKSUM_VALID_LVL1		= 2,	/* 2 outermost checksums */
> > +	XDP_CHECKSUM_VALID_LVL2		= 3,	/* 3 outermost checksums */
> > +	XDP_CHECKSUM_VALID_LVL3		= 4,	/* 4 outermost checksums */
> > +	XDP_CHECKSUM_VALID_NUM_MASK	= GENMASK(2, 0),
> > +	XDP_CHECKSUM_VALID		= XDP_CHECKSUM_VALID_NUM_MASK,
> 
> I don't see what bpf prog suppose to do with these levels.
> The driver should pick between 3:
> XDP_CHECKSUM_UNNECESSARY, XDP_CHECKSUM_COMPLETE, XDP_CHECKSUM_NONE.
> 
> No levels and no anything partial. please.

This levels business is an unfortunate side effect of
CHECKSUM_UNNECESSARY. For a packet with multiple checksum fields, what
does the boolean actually mean? With these levels, at least that is
well defined: the first N checksum fields.


