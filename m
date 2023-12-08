Return-Path: <bpf+bounces-17250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E380AE98
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 22:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E3B1C20CA6
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657015733B;
	Fri,  8 Dec 2023 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Geb0MCUv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20396BA
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 13:11:02 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c09dfd82aso33146685e9.0
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 13:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702069860; x=1702674660; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vgux4IsC7X1KkRPDhjlOVf47aRdhBTeE2BVZVi56QhI=;
        b=Geb0MCUvrvc271XCHF+QK+PmJON5APkesuv9GuPhxOopB1hPMCY4ThpEQeLf2VXpVJ
         EhkwOrZ4Oquf+8V7iRu5mzcarlM5IKoY07+/m+OUBphdyRwCjnJFejDuZKANNs7LOMK0
         UZNBkeYPhX5Z+u9EuO8pP3bX/wdwvE2UQolLpAbgj1F6RhC/TrFGb20Ws/gPgTbljIyM
         L92SeX9fH/9cUb9Ub+2Xr0TpkuLD9dpZNsToKS5VwLm4xgTlJ8M4cBbXKZdWQ5RFRLyM
         8tKi7frZahcX4MT9EkPQ3wmXURAp6mqXAUZ3xl5WN+AdNID+knkOyhMIFHYfljMFjy7c
         wGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069860; x=1702674660;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgux4IsC7X1KkRPDhjlOVf47aRdhBTeE2BVZVi56QhI=;
        b=PI6LCGoTGbLOl6rMM0YqV8ku/dycAsbmtaZ8QylIKstKSi3BTdeETS6Yx8z9ZS+110
         uBGTKFYNO2J0t5JNqA1YbFncfZ1OnZzZl3lLa9NyBdr25qJrk6sLjXHch09kffrzTLiu
         r93fxK9vhDw0RMHgMlS3AHbdz6Ws+m6SZawcI/ST23cpQerpUuX1F1R9RUE7Zlmjnp63
         zYhrf5bRfLdiB7EIavhQQ3MOUYtIqj+VZGqmfiC8meL+dUaxfJQGlN4Wjolk4Di0yod6
         vvMze3PQWjnk4w9KToNDpCP9FX37i1VzQyRw8vT4WaGF4KKcv7xQ8h23LO7bZWZ0T9Sp
         yh0A==
X-Gm-Message-State: AOJu0YwVGNs/75Z+1FsFyWKfL3IwF8cIK7QEUnJCms18nq8WfUJ370W7
	czObchcpiz5ASQCRFZWKeVPg0QZykA7Pxg==
X-Google-Smtp-Source: AGHT+IFHW8J2un81ADBi4jyvtJ/qCTxYmfbvbAjGF9S/xv0AfiiBR06zmtn8/oLHMTEiWhGZzf2v6w==
X-Received: by 2002:a05:600c:492f:b0:40c:2d50:badc with SMTP id f47-20020a05600c492f00b0040c2d50badcmr341431wmp.2.1702069860468;
        Fri, 08 Dec 2023 13:11:00 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b004094d4292aesm3911996wmq.18.2023.12.08.13.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:11:00 -0800 (PST)
Message-ID: <f07985f79330ea475c1a6cb2a20b9772e5a65e1e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] bpf: minor cleanup around stack bounds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org
Cc: sunhao.th@gmail.com, andrii.nakryiko@gmail.com
Date: Fri, 08 Dec 2023 23:10:59 +0200
In-Reply-To: <20231208032519.260451-4-andreimatei1@gmail.com>
References: <20231208032519.260451-1-andreimatei1@gmail.com>
	 <20231208032519.260451-4-andreimatei1@gmail.com>
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
> Push the rounding up of stack offsets into the function responsible for
> growing the stack, rather than relying on all the callers to do it.
> Uncertainty about whether the callers did it or not tripped up people in
> a previous review.
>=20
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

