Return-Path: <bpf+bounces-3260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA2373B7FF
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B525281B66
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B18A8C02;
	Fri, 23 Jun 2023 12:45:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43E568B;
	Fri, 23 Jun 2023 12:45:38 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893D52130;
	Fri, 23 Jun 2023 05:45:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e6541c98so418205b3a.2;
        Fri, 23 Jun 2023 05:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687524307; x=1690116307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sk22LSjhy08WjBidsivSikrImU390NZZ49H7BXVoJQ=;
        b=dgy9ZZ/B/vzCfojJVvZFlMcbLu3U6AgURT7rc5FqQVNQ1ELPMyoJgnhNKdbnnSvKHw
         4ed/xa08bzusVTq2xsiDkJz8HAbslFeisfotHSzb6BROJQgM8Lhk3T/hvBq8jzvYlKcq
         27lIJ13qyy2Q+8VUVrDZwzgW44vlG4VhrBgv3yIyS9GDwH/KFZdjU9yBQyC0r6Nsa2xm
         GZa6mWGhu9Wi7yv1VnipgVBE9u3228i3fyfJeTHBRpxcYLyyjjef2luCa/bWKz+X2kSd
         En6B81JiqQtZmTiVcTuYkZdw7Ht1YzZDb4TjLongLYNkUAgS7hNxC5LOKFlNfYrA9/I2
         IrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524307; x=1690116307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sk22LSjhy08WjBidsivSikrImU390NZZ49H7BXVoJQ=;
        b=Nrm863dTY6S/l2y1nc4DXSlRCavc56OMMTx8U4pAAw8i8U8JpQFLHsyf+GL5Eit6Zq
         IGjdWzTO3FCeZ56flzRpoRCOLHoxOgDQ92+Vv0CH8zC6bXBNcB9az58zObP74Nd8x/x7
         35+kNhJq+zY6wl+Ufyc+1RFU+zUj6rcxETV6rzNIzXei8ZlimrrrlzbEoPafYuH158RU
         CvyYOqSb9pDIsQBRDYg7QtDp35Cfei0h5mfHug33ejjFok2eLghCszv2QdRwSmhIATB9
         hnhhRNg4GeJa1434XAdH29LHTQDKFakpNZocRLJh9F43jme7S0TSFzKaer1uCDyt0ewl
         ey8w==
X-Gm-Message-State: AC+VfDyk8ihSxJUEQrPWhifPZeG8nV//iwBay908+A+jNSPaCaS3+LqX
	KHN6BBhFAnZHe3ICByYHAPg=
X-Google-Smtp-Source: ACHHUZ6yh1r1E1jdJMamk8/pwcIqXZFbn5z9Z4TX1FSYCK9sWTPK/gmdJAqZ5PY9Qy0QovhJWcDbvw==
X-Received: by 2002:a05:6a20:54aa:b0:112:2843:b546 with SMTP id i42-20020a056a2054aa00b001122843b546mr26730950pzk.58.1687524306826;
        Fri, 23 Jun 2023 05:45:06 -0700 (PDT)
Received: from VkUbuntu ([150.117.130.6])
        by smtp.gmail.com with ESMTPSA id y20-20020a1709027c9400b001b53c8659fesm7120300pll.30.2023.06.23.05.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:45:06 -0700 (PDT)
Date: Fri, 23 Jun 2023 20:44:54 +0800
From: Wong Vee Khee <veekhee@gmail.com>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Mark Gross <markgross@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Wong Vee Khee <veekhee@apple.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Andrey Konovalov <andrey.konovalov@linaro.org>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
	bpf@vger.kernel.org, Voon Wei Feng <weifeng.voon@intel.com>,
	Tee Min <tee.min.tan@linux.intel.com>,
	Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: Re: [PATCH net-next 1/6] platform/x86: intel_pmc_core: Add IPC
 mailbox accessor function and add SoC register access
Message-ID: <ZJWTxiJA4Z028/2G@VkUbuntu>
References: <20230622041905.629430-1-yong.liang.choong@linux.intel.com>
 <20230622041905.629430-2-yong.liang.choong@linux.intel.com>
 <0652c9c8-27ee-0af9-9aa8-a2909142d405@redhat.com>
 <1599dd7a-f297-577b-7f5c-295a660c0c9c@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599dd7a-f297-577b-7f5c-295a660c0c9c@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 01:52:49PM +0800, Choong Yong Liang wrote:
> Hi Hans,
> 
> I will discuss it with David but currently he is on vacation. It might take
> some time to get the final output. Thank you.
>

Please remember not to top post on ML.

Regards,
 Vee Khee

