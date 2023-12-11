Return-Path: <bpf+bounces-17432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAEE80D958
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 19:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD33281E4F
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0F51C59;
	Mon, 11 Dec 2023 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixn9cLBV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B56FAC
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:52:55 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9ea37ac87so66445871fa.3
        for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 10:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702320773; x=1702925573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4v6TGj/sTZeSwAouIJCM+wEU6bvB2qUVQKKDLymwJGY=;
        b=ixn9cLBVkOUheYI0rrvDlCNCN10PfUFzlojkFdC4XpeX7CGlYVNDA5cDhPMILxf5qt
         dLG0RP3iDcNrjGVbNaQQLLZWzvaUQDtI52Gw3tBX7HRW8ASP065Sf52b9+QFEKfDIXCQ
         xfwYLLBaYEmeLiS+nrOPqNoCP1EKpHtgvfYpNpsMsYLIIigCCw3M6iUpMc+MyBesXb0N
         AKNSQ+raLXJ22jQCLid3q0rwqQKE1lsfeHwWRp09KL8i7cLCXsJcfuHXaNidshl/NuRu
         FVaZu3VqT49gp6L4fziWZ9hlJsZgo/z2HfYPu0s8hNgtJqtfoil9CzvCL0LuAVXGlSAH
         M/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702320773; x=1702925573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v6TGj/sTZeSwAouIJCM+wEU6bvB2qUVQKKDLymwJGY=;
        b=eHMJ1xbKn7N8OMsio3XGc+XxZvR2aCANPAZHOk0ndTaIW3yYY8VQMT70ScyZfz8uly
         ok1BtcJIA1NdT9lYirDma/ct377z0Bgv2HY8RfgbxvPsvGDefU3rBTvtnwiNfosUmxxs
         HPYNwmzL5I/XsPD0UCBw9OsVcO6ylPSNb0vAar/Lx0CIdIiddyU7aQQ28xtGuDzS9uQ6
         dK6CfvqU+g4n04ECLUsmlY/r4HY5LsDq16PcXLXU1LjsyN5EAcjWVdS931g09eIz91X2
         xW9MBpPydwSldY3cpENQQICbZB7dk3lSvsphMnc/76sFaz7Jfp9XuA17muJ6uH9DAeRn
         ZhRA==
X-Gm-Message-State: AOJu0YwQBeLu50Lo3IBOX7y/oFsHv7OBmrsbSm9LjJgts2kqx3hwC27L
	/DZh9oADV5rUiykOcAp35f4=
X-Google-Smtp-Source: AGHT+IF3GzcfmJH1A8mmYyLGHVcFvOObGZBkJ6Nuz+OmUmt5zeQ9q1ZXl9AFsWR19E8bAVkhLzStjw==
X-Received: by 2002:a2e:bc23:0:b0:2cc:1d5f:9ec0 with SMTP id b35-20020a2ebc23000000b002cc1d5f9ec0mr1430657ljf.27.1702320773073;
        Mon, 11 Dec 2023 10:52:53 -0800 (PST)
Received: from erthalion.local (dslb-178-012-113-064.178.012.pools.vodafone-ip.de. [178.12.113.64])
        by smtp.gmail.com with ESMTPSA id r10-20020a508d8a000000b0054cb88a353dsm3875948edh.14.2023.12.11.10.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:52:52 -0800 (PST)
Date: Mon, 11 Dec 2023 19:49:08 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v7 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231211184908.qhfdspfb77ttm2zw@erthalion.local>
References: <20231208185557.8477-1-9erthalion6@gmail.com>
 <20231208185557.8477-2-9erthalion6@gmail.com>
 <ZXcA4KxoaDagJPjc@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXcA4KxoaDagJPjc@krava>

> On Mon, Dec 11, 2023 at 01:30:24PM +0100, Jiri Olsa wrote:
> > +	/* Bookkeeping for managing the prog attachment chain */
> > +	if (tgt_prog &&
> > +		prog->type == BPF_PROG_TYPE_TRACING &&
> > +		tgt_prog->type == BPF_PROG_TYPE_TRACING)
> > +		prog->aux->attach_tracing_prog = true;
>
> wrong indentation in here, please check the if conditions around

I'm a bit confused here, why is the indentation here wrong? IIUC "if"
predicates have to be aligned on the same column, with padding where
needed. Or is it always necessary to expand the last tab with spaces?

