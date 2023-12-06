Return-Path: <bpf+bounces-16900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF6F807632
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34729282019
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902424F1F3;
	Wed,  6 Dec 2023 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBsPIxk0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEA5DE
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 09:14:17 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ca09601127so44453671fa.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 09:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701882855; x=1702487655; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RFfBTNihWN3TWNsIHo4Q4PqLTD13Wpwm1gCvMcg9OCk=;
        b=SBsPIxk0vWyMl4JSsjR2WsYIqHVvdBV+KtHnp1xy79+sJeFXb4vpcg2qYwbU8VowW/
         q2zP829AI8km7CV2Rdm5QsMtVbgGZtXUXsidxJTKRX0ITnTCNe/ZCO9XUz/gLIRbRv9y
         re+zQA+QTy/7W5qVMJvls6mtJtafo1rXtczwDrRdwWr01V6IkHMJ5RaLgKU8s8wwr0cN
         LN//Fj89czK303x4W/s+hMzPI5gqd9xEWgoJU9H6hOABm3WnS5sKc/bnl/oIPrfEZxw1
         85cPQ6Ba6zKfHk+PzdmJ55hfyXdFJAAlIVar0WnwPALdT1Ley0M3BeQghE5aIhMvjLiU
         Ntgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701882855; x=1702487655;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFfBTNihWN3TWNsIHo4Q4PqLTD13Wpwm1gCvMcg9OCk=;
        b=c2J8y1NfsVdarWNeV5N+g9vrNppsgbmccP7OgT7HGP4qMrovx0LhGY4hBmtzjySQCF
         Mb6yrerUEsEygZqwC7YDM740hh86J/lofbKAazxnxika6MrJ4tLPwvFEwX8mCyUEtCmk
         B0kxff6ag+0IOmKEILnXvYOjbOyGfjWmywmvByMIRYe2JJPTpcqZfdZb8qFWUU3Qo1WJ
         7DTXnP8AfeUaRQW7zWrb0FZl/faHB6aqHhbKMlsann03Kr5T9S5KXU7tQXg+VzlUD5le
         k6s3OnZuxDUoRPdIEFr1aNaJbhe6VumpBTK32xg4FHkoluLfMkfzSEB4c2JHYZ4OEBx6
         z94g==
X-Gm-Message-State: AOJu0YyXG/NEyOmlllkyWEplbkQsHF972WyCznvX4lXKkATaZUvRAO5m
	VN+Vb0HjoGnJlWpXaqk8kEo=
X-Google-Smtp-Source: AGHT+IFNNAaXUDannSpka51IyVezCl1vYXxIWNb4iKOv+Mf3bBUtu9kTLHATc36zYcKAzYoBx+17wg==
X-Received: by 2002:a2e:924c:0:b0:2c9:fbb6:8bdf with SMTP id v12-20020a2e924c000000b002c9fbb68bdfmr773887ljg.65.1701882854986;
        Wed, 06 Dec 2023 09:14:14 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 4-20020a2e1444000000b002ca0ed22a22sm19691lju.63.2023.12.06.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 09:14:14 -0800 (PST)
Message-ID: <1cf2fe9a679946a05fac869299a4f37272485a3f.camel@gmail.com>
Subject: Re: [PATCH bpf v3 0/2] bpf: fix verification of indirect var-off
 stack access
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, sunhao.th@gmail.com
Date: Wed, 06 Dec 2023 19:14:13 +0200
In-Reply-To: <CABWLsevo3JDGti3c8guAm8vphUT+13aoMCibiN8EDYpcKmafAA@mail.gmail.com>
References: <20231205193250.260862-1-andreimatei1@gmail.com>
	 <e3787b1d4c2d7a6b02ca6561edad92fbc27cb6ba.camel@gmail.com>
	 <CABWLsevo3JDGti3c8guAm8vphUT+13aoMCibiN8EDYpcKmafAA@mail.gmail.com>
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

On Wed, 2023-12-06 at 11:57 -0500, Andrei Matei wrote:
[...]
> > I think we also need a selftest, at-least for patch #1.
>=20
> Yeah... I was wondering in a message on v1 [1] if a test like what I had
> prototyped there was warranted. I personally still think it's not because=
 of
> how many other variations of variable-offset stack access tests we alread=
y
> have, and how random the zero-sized read case is (even though we had a bu=
g in
> there) - so protecting against this particular regression didn't seem wor=
th it
> to me. I'm now including the test in v4 but if you change your mind about=
 it
> when you see it in context, let me know and I'll take it out.
>=20
> [1] https://lore.kernel.org/bpf/CABWLsevk47Xa1a+h0UK--94zEuxScrmyt0-D8YSh=
q1UgvVvf5g@mail.gmail.com/

The reproducer is a small and non-contrived program, so I think there
is no harm in adding it.

