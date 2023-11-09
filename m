Return-Path: <bpf+bounces-14615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09247E7111
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622C11C20AB6
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385D430FB2;
	Thu,  9 Nov 2023 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWJ790Je"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561B521113
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:03:58 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEC92139
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 10:03:57 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a6190af24aso204478666b.0
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 10:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699553036; x=1700157836; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZqTu4qcixWvmJQsxq1t7xa/+9rDSiFXajkAeu6NUjVk=;
        b=MWJ790JeBzDWCNXTRyN0o5P+cFkjlKBNBlMD/IRfDjaD6M7GbEXkWijVthMGjMnY2f
         gkM8vxr7cviwyAMzmHVHBnUQndLdQL8/Vrp1dgoXXZrohUougZ3tERRWGdm8c2VynyO1
         g5xvxtc1Km/q0Uli47OEQqj8BXo8DPRdpPUODwI/NWFv6jawIRzBRfjQB1hBsh4P+b+b
         2AIn4Y/60Rml7PMCWSxIJ34m0Rv6AJY2wpEMYRnCIoOkttbcsMIA1xKdv9av1H/eXPq3
         2xs7TXQ6CaAAoPjqBL3SH32E8oY0Kpov27aiAQrB2Se6WRuiomPJta9w3QDsPtBrQVyZ
         MO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553036; x=1700157836;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqTu4qcixWvmJQsxq1t7xa/+9rDSiFXajkAeu6NUjVk=;
        b=GiEo1zO/EQnf6puCqyBp4XuuVOEMM1rcKfaKXJSdcEtSsPxCxDh1NSl5W/NiUV70WJ
         9aHm0Rtf8EiS2qxzUEYay4fY+gD+AFZw0/S6ZYUx4YfPAtMtGPZG6zSph1zkXd72rc66
         1L4bkhUMn7aPy0XSuxCgQxRlZGEAyRaA3NjW5vPQkiESsunQX3QBzxuTa0LPbWqgggdN
         5cueYi7eou1GJBR80q6h5oLm849cbEtiZ+/UyU4PfihY3W/ln0lzEc/PJWJbtMrkElCM
         FGXoQ6p1Q2uWmTz/pu9DHUjCr/VrnfCxJ7h1nrbKjDCvc6aoOyEK0g1YGPoB2mg5Dq3R
         WCvw==
X-Gm-Message-State: AOJu0YxIG7j3wANRSq9TeiJC7jGZw4mtf2H9eQMw8UjzZkiJzT/ic3/P
	SloYnHJd8xJZ6DQBoEaqfnT17rLpmUU=
X-Google-Smtp-Source: AGHT+IFb8kw4AAzTI4CvSOx4pYtL9xmUY0ByPg6TJ0yKVrT2haON7/7wmqolFa82butiOOVREPLLlg==
X-Received: by 2002:a17:906:6a1c:b0:9dd:b89a:9959 with SMTP id qw28-20020a1709066a1c00b009ddb89a9959mr5354896ejc.16.1699553036104;
        Thu, 09 Nov 2023 10:03:56 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id pw11-20020a17090720ab00b009ade1a4f795sm2795327ejb.168.2023.11.09.10.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:03:55 -0800 (PST)
Message-ID: <e7493d856dcfdfae27404680025d7e7759686952.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: enforce precision for r0 on callback
 return
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Date: Thu, 09 Nov 2023 20:03:54 +0200
In-Reply-To: <CAEf4BzZDMHvBYKc+=jwdXBE36E=r8n5zzpvpzy5fTtL56d+2Cg@mail.gmail.com>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-4-andrii@kernel.org>
	 <71cc364752f383559c7d7a570001fd353f0ca8aa.camel@gmail.com>
	 <CAEf4BzY1-mcN5Wjf4-FOKQvnom+0EV=a=cGxvBO9=rbCS0kzwA@mail.gmail.com>
	 <b335aa904dca981058e1db92b6270960f2a28948.camel@gmail.com>
	 <CAEf4BzYHOMgxE1NitS_8YosrYWFzZ-BT8qL=Fnyna9tDA2M+2A@mail.gmail.com>
	 <CAADnVQ+wMq36--Wp1COwbfUsCNo7q1JyHh+QzRvFNNmkvdsmEg@mail.gmail.com>
	 <CAEf4BzZDMHvBYKc+=jwdXBE36E=r8n5zzpvpzy5fTtL56d+2Cg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-09 at 10:01 -0800, Andrii Nakryiko wrote:
[...]
> > Just like Ed I was also initially confused by this.
> > As you said check_return_code() has the same problem.
> > I think the issue this patch and similar in check_return_code()
> > should be fixing is the case where one state went through
> > ret code checking, but another state with potentially out-of-range
> > r0 got state pruned since r0 wasn't marked precise.
>=20
> Right.
>=20
> > Not sure how hard it would be to come up with a selftest for such a sce=
nario.
>=20
> Yep, I'll think of something. Lots of tests to come up with :)

Hm, range argument is convincing, thank you.

