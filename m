Return-Path: <bpf+bounces-6271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2237677EF
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF15282704
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 21:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD691FB2E;
	Fri, 28 Jul 2023 21:53:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2207154B2;
	Fri, 28 Jul 2023 21:53:46 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C382D54;
	Fri, 28 Jul 2023 14:53:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbdc05a93bso16046245ad.0;
        Fri, 28 Jul 2023 14:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690581225; x=1691186025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrCmZtRx3lzfjxp9dLuW47cnLLOC5RN4s1EPMlwlsM0=;
        b=cqasNHfqoiDTzLRzMqhNztfAPqfeeaMPkBkFIN4vGesnl19KdGYHHpFMwdQuS8HW7c
         y0YBllsYCHpp18/Peg3lB7WugNxBccRD5mUlo9AsDVuAy2xHCXz7YB5UoM3gS1z0sTmQ
         BiXhJ11Hj4oqpH0ZVrHOTMV0SMrWvExa9fXFM1YihtBQSz384e6RIjwBdF6ZliiWzpgh
         oTNedbKXPxgsg7X7y0b9YW2R1yKTPjQKE/0107Rd48ABoc2OhM+/2+4PgWGw2jgExtKH
         PdHMj6npRb90UXkdQ4xZk+PJpBRvav9Qo0yAJeRcA0ijcrH2L1aENn6wia2exsz8uAqq
         xOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690581225; x=1691186025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrCmZtRx3lzfjxp9dLuW47cnLLOC5RN4s1EPMlwlsM0=;
        b=UkhZJolwwd6DQJ2AR/o52myp3GfD1yyc+7hTc4zn0LfiW4nyJWmIDXebz0CAnsEILJ
         Vbi+RPTIqeaQkxaLR44Ygr+Hmc26gqlZpWa184w4ErNbg0XkJ/Kodo+tocQVGrx/Rw4K
         TYonHZOWLgIFV1tnOO1Vkr8Qgj3pthMjRdALCl8wdYfjYy8AiUrbTr8niy33QPalB+vn
         +x+vu6LoMes5MViHin7cvJvFGPtznwIw8TPJgO9wuWc5987ezSWKX0XO18pDVCa4keJN
         K29VcnolVPFTRB1DCMCTpDFPP4BR6FmM3Y1eWiI42T+aevNyp2NBE/wLW7vWR2QHiGgP
         igCQ==
X-Gm-Message-State: ABy/qLa8qULTVBJjeSf6EaIrbXlhn9POtZWX9DgNmKil80kMsE3rIWXf
	i6u645gzePvSmevgoaf9jsc=
X-Google-Smtp-Source: APBJJlGNQ4lQwxgXQsqYjFUEwYqKXLOaQ0mNU2T/hiTQkb9p3fIJ2wcQ3cZFZQrPBGw6ZJCigM8R+w==
X-Received: by 2002:a17:902:ed8c:b0:1b8:28f6:20e6 with SMTP id e12-20020a170902ed8c00b001b828f620e6mr2418521plj.34.1690581224852;
        Fri, 28 Jul 2023 14:53:44 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:6cea])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001ac2be26340sm4041513plf.222.2023.07.28.14.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 14:53:44 -0700 (PDT)
Date: Fri, 28 Jul 2023 14:53:40 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
Message-ID: <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728173923.1318596-13-larysa.zaremba@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 07:39:14PM +0200, Larysa Zaremba wrote:
>  
> +union xdp_csum_info {
> +	/* Checksum referred to by ``csum_start + csum_offset`` is considered
> +	 * valid, but was never calculated, TX device has to do this,
> +	 * starting from csum_start packet byte.
> +	 * Any preceding checksums are also considered valid.
> +	 * Available, if ``status == XDP_CHECKSUM_PARTIAL``.
> +	 */
> +	struct {
> +		u16 csum_start;
> +		u16 csum_offset;
> +	};
> +

CHECKSUM_PARTIAL makes sense on TX, but this RX. I don't see in the above.

> +	/* Checksum, calculated over the whole packet.
> +	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> +	 */
> +	u32 checksum;

imo XDP RX should only support XDP_CHECKSUM_COMPLETE with u32 checksum
or XDP_CHECKSUM_UNNECESSARY.

> +};
> +
> +enum xdp_csum_status {
> +	/* HW had parsed several transport headers and validated their
> +	 * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
> +	 * 3 least significant bytes contain number of consecutive checksums,
> +	 * starting with the outermost, reported by hardware as valid.
> +	 * ``sk_buff`` checksum level (``csum_level``) notation is provided
> +	 * for driver developers.
> +	 */
> +	XDP_CHECKSUM_VALID_LVL0		= 1,	/* 1 outermost checksum */
> +	XDP_CHECKSUM_VALID_LVL1		= 2,	/* 2 outermost checksums */
> +	XDP_CHECKSUM_VALID_LVL2		= 3,	/* 3 outermost checksums */
> +	XDP_CHECKSUM_VALID_LVL3		= 4,	/* 4 outermost checksums */
> +	XDP_CHECKSUM_VALID_NUM_MASK	= GENMASK(2, 0),
> +	XDP_CHECKSUM_VALID		= XDP_CHECKSUM_VALID_NUM_MASK,

I don't see what bpf prog suppose to do with these levels.
The driver should pick between 3:
XDP_CHECKSUM_UNNECESSARY, XDP_CHECKSUM_COMPLETE, XDP_CHECKSUM_NONE.

No levels and no anything partial. please.

