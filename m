Return-Path: <bpf+bounces-16608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35698803CF2
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 19:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67FB28114A
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEDD2F862;
	Mon,  4 Dec 2023 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgBzne4Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3185170F
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 10:25:43 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1a496a73ceso440079066b.2
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 10:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701714342; x=1702319142; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0OF4mDioL4VUgzcijZ4SuvkanOsqj/Y2ovE6XOEYlis=;
        b=FgBzne4Q9ojKfRJdxrOAF94C6ZNDgrIUQfcMO58ju/dH0K7McOUoE5QZhgxhYgb8PI
         uwHkm06Y11MG48fG+zOrlmNF+fN9L1msilPFgthHwUii311Q9YdO+leEEKaih1kZZ+nP
         IbagFxkaeosyQhxTN81ZW4X1r1v32IFGFY6ruO445GR2GOWJfps0p8EzkyR9KlLMJc72
         0fn3tYztBJxl8O7J/k78pkiO1Bz5k61+qpcm40wAkE1rJH5wfl2Qt2nsemt0/AgIQdJq
         iNy+/I1vGDfk8OlVHtQ30EbHAnwcSfEy1mEWezkwU7H87MqZ8VsQv6iH7vJjZ17qtVYF
         T51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701714342; x=1702319142;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OF4mDioL4VUgzcijZ4SuvkanOsqj/Y2ovE6XOEYlis=;
        b=qulhoN1sHcgfrAMiFNegNvoBa+xxAXzwiOw5zsULCSHenDvbTAgbFmTZ+2wW54B7r8
         wqX9m29WJhvuIjcK/5H3Pl8uCPrB2W0OIWY6QV/oUc2Pwpz0BqdsMgN0G/AD0y3h8DPe
         GWFIVhsB3ake9UR2cow3d5wPO+g3A9pVoioCU0p65IrK7F0WY/cguWZex1cbwRE9Qsm7
         eSblXnS1bNZ2WKjGBP0+Rjlo/SGo410CMT7LiNSApN1vg2NeTL8uI1pAqv/278ou41KR
         3BSeNPJV0T/Kv7RBzcKQ83LzXkBYXRyNyrYc7E8F/3isu9dTHD3lhWMalAc5+3UC8iEW
         RJow==
X-Gm-Message-State: AOJu0YyKfh4fLkIhNiJREkTBPkt/TO4Gt12k8dhNbPwIOU0G1IxUUe9/
	1EgFBuRx+WE0sE8O8w/gy8o=
X-Google-Smtp-Source: AGHT+IGOIgy2ZI2W/KFcOadh+DyNlxQbtnsS0CqXc5WNW5ezNz3bIC1QKAHdRBxpQ+3yehGSFqzMiA==
X-Received: by 2002:a17:907:1184:b0:a19:a19b:78c1 with SMTP id uz4-20020a170907118400b00a19a19b78c1mr3476471ejb.132.1701714341699;
        Mon, 04 Dec 2023 10:25:41 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z25-20020a170906241900b00a14311b5c5dsm5541224eja.185.2023.12.04.10.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:25:41 -0800 (PST)
Message-ID: <f62ef0d3c2a1fd6683b811d6ae974aa9b08557cc.camel@gmail.com>
Subject: Re: [PATCH bpf v3 1/3] bpf: add some comments to stack
 representation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com, kernel-team@dataexmachina.dev
Date: Mon, 04 Dec 2023 20:25:40 +0200
In-Reply-To: <20231202230558.1648708-2-andreimatei1@gmail.com>
References: <20231202230558.1648708-1-andreimatei1@gmail.com>
	 <20231202230558.1648708-2-andreimatei1@gmail.com>
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

On Sat, 2023-12-02 at 18:05 -0500, Andrei Matei wrote:
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---

[...]

>  	int allocated_stack;
> +	/* The state of the stack. Each element of the array describes BPF_REG_=
SIZE
> +	 * (i.e. 8) bytes worth of stack memory.
> +	 * stack[0] represents bytes [*(r10-8)..*(r10-1)]
> +	 * stack[1] represents bytes [*(r10-16)..*(r10-9)]
> +	 * ...
> +	 * stack[allocated_stack/8 - 1] represents [*(r10-allocated_size)..*(r1=
0-allocated_size+7)]
> +	 */

Nit: this uses variable 'allocated_size' that does not seem defined.
Otherwise a nice comment, thanks.


