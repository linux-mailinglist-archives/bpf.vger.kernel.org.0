Return-Path: <bpf+bounces-17249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA3480AE88
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696D91F219D3
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 21:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776CE57332;
	Fri,  8 Dec 2023 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgNcFm0o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912D8198A
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 13:06:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so25398895e9.1
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 13:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702069590; x=1702674390; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D+kyOlW+wBUznLFxaWrdeKYzVDxQbRAWKClyNLHg8cE=;
        b=DgNcFm0ooXEuYrWPYbngGioazWiaYAX4AFUTgwe3K9SM8O8DDx7Pq6cZaTMSfWOqHj
         V/I0Tq1En0Q7vQvD+4Y9zYxSL5fTb9GzCsVLmUlwK0dsd02+tBM/DcBJGHevF128y+9T
         RrCcGHKtsIwFPDjc0L0dgr2qrHOJ1eDzayDhz2xFGAUjDy+RBJFCBaxRYrT2r9lrlSMt
         pjgDsphmOOgjnmMZ78E2mror92dgdwvfMAwrhnfZa5c0HLyJomTDqY1WOt0TqlRkcLD4
         tq7MlyNATxR4FJ5FsNDdv84Gi6UiYxwWsCeq8PmmUJz4BWX6AGF0BDQ3AhkFV1dpOAo1
         /mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069590; x=1702674390;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+kyOlW+wBUznLFxaWrdeKYzVDxQbRAWKClyNLHg8cE=;
        b=rNL4MHey2cR1szPdKFffyeRadH6Kn3kbZWdaP3jyqCkW0jFv++s+nIhn37Ximc5fTC
         0/cxfqmxslYD8jnMtx2PcZW7Yeg2bi8qQ4KH2w7hcrFGBAbz9IVQ7bmT7eI6X8cINjoe
         +4yscdkkPeZKQsRiw0Q935D3eZnw824Vmk43qapfCKXlz9LlHRpm9kWhfE+rvGoTHSMN
         dvV1zM/Usvo5nAB/cLDJ/SPvt4M0c0RgmHRz0inqqnaucPu83fIj5VGkh87dWHXUX1Bx
         J2P3FZqQTOhseG/nUGp2fHeUdsLtv6jTLySKl+S1WVNcyCNnv69a73cCccK/cLVSqiHa
         xwFA==
X-Gm-Message-State: AOJu0Yw+HDqtO2RaT2KTPnS9mfnbNCkQXi2AKoTLsD8JyE4kRDD/XPLS
	3U9YjZf2gK2sHN6/ckswluzZp8HwSa8v/A==
X-Google-Smtp-Source: AGHT+IFigR9dfU5nnYyiqwzAd4uHSMxDVTlMnAKxSuF+0/oiyKiuAOtr8hSLZMGjx7dkXuxWRBgxBw==
X-Received: by 2002:a05:600c:b55:b0:40c:1f44:b15c with SMTP id k21-20020a05600c0b5500b0040c1f44b15cmr351347wmr.99.1702069589714;
        Fri, 08 Dec 2023 13:06:29 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040c2963e5f3sm3914409wmb.38.2023.12.08.13.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:06:29 -0800 (PST)
Message-ID: <25c4fe6a84f94a13ed7dd62940e006a66fe4afe0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: add some comments to stack
 representation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org
Cc: sunhao.th@gmail.com, andrii.nakryiko@gmail.com
Date: Fri, 08 Dec 2023 23:06:28 +0200
In-Reply-To: <20231208032519.260451-2-andreimatei1@gmail.com>
References: <20231208032519.260451-1-andreimatei1@gmail.com>
	 <20231208032519.260451-2-andreimatei1@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-07 at 22:25 -0500, Andrei Matei wrote:
> Add comments to the datastructure tracking the stack state, as the
> mapping between each stack slot and where its state is stored is not
> entirely obvious.
>=20
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


