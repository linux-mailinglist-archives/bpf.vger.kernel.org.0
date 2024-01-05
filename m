Return-Path: <bpf+bounces-19153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0A9825D36
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 00:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E74F1C23762
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 23:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66B2360A4;
	Fri,  5 Jan 2024 23:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOkRqBll"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D73609D
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d5336986cso1032355e9.1
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 15:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704497882; x=1705102682; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZAr0Rv3OTTxeZpNWkK4fXWfEWvjtejzZjUK3LXm6B+Y=;
        b=IOkRqBllw9xnsVZIu8RM+skBGbt4DB3oXlINkUG66mAGkoeIkJT33k+KWDZ5kM4NSg
         QNik/alaEIydx10wsBFaAqOrG9F8Q4lb/vVkoOUA59F1ykJJyZ8XE1kXznbF65bomtV1
         8M/jJrx6rlok/aQfKJhN+Qa+Hm68CT/u3gI9AamplqDBDgPpIhhE4f/76LLbq7uTqT1J
         yTFN2NyVtawcgmuu05k5zRWHH6Q2GmzOT2yS8VDF+AjnDNHj/LtWV0IWNjwEv+LBKuP3
         qp/NBqylYNdfi1x8f+RDha6znXFdy9t2On1NRWyASwwbVcJIzOBhKcDuQfKPAftJ0IJX
         k4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704497882; x=1705102682;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAr0Rv3OTTxeZpNWkK4fXWfEWvjtejzZjUK3LXm6B+Y=;
        b=oM7FiY8l7IMUGQbJbzh7q7H+bEfbbC9/8lyloQVLh+aDxqW7xW6mS9wlVVkDDkYMUi
         bEvvOiD2kQTf7d/zBFEU3P9CkZBkCMUm/gp2XDrTFHPmOjskXxp7JfLSMKhUMxFF7oSW
         w3IGe0RIVtQJendAcgRRv3An4J0dEvfn/3RLWD7uqef2+nv8M2E9N1knv/5/ecfWYRYn
         JMObF6d26kiibo2MgV1mtUJq1w8WGGlhvF5uji8DApuoxeCXj2FbDOWk9S6mn0U+5WVJ
         ctmmqJOrIo5HwOcIy/FzO2iZx9H/iUUS4Sf3qWR7x8u+av1Z3RfLCnRTm9vIf5Z5H/ug
         j4Vw==
X-Gm-Message-State: AOJu0YxSca0q7BG9sy0pFJuOzhOPxx8MzrCvoDfpkTumOESXNpEk6mE1
	ayOQNjVXKz8H0P8khOGT/bE=
X-Google-Smtp-Source: AGHT+IECqOSbcFiY4i65whaobPGvTWIfyMIkRSuyR8c8ApJmXocxDeGlQPcM4bvMnHJDv/9ij7+D4A==
X-Received: by 2002:a7b:c846:0:b0:40d:9342:7570 with SMTP id c6-20020a7bc846000000b0040d93427570mr103030wml.193.1704497881721;
        Fri, 05 Jan 2024 15:38:01 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b0040d3276ba19sm2890851wmq.25.2024.01.05.15.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 15:38:01 -0800 (PST)
Message-ID: <5e31a6835b648fae9880f6bfbc40801539b2d143.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as
 imprecise spilled registers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com,  Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
Date: Sat, 06 Jan 2024 01:37:59 +0200
In-Reply-To: <ddc70b06-9fde-412f-88c0-3097e967dc6a@linux.dev>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
	 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
	 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
	 <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
	 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
	 <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
	 <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
	 <ddc70b06-9fde-412f-88c0-3097e967dc6a@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-04 at 23:14 -0800, Yonghong Song wrote:
[...]
> There is an alternative implementation in check_stack_write_var_off().
> For a spill of value/reg 0, we can convert it to STACK_ZERO instead
> of trying to maintain STACK_SPILL. If we convert it to STACK_ZERO,
> then we can reuse the rest of logic in check_stack_write_var_off()
> and at the end we have
>=20
>          if (zero_used) {
>                  /* backtracking doesn't work for STACK_ZERO yet. */
>                  err =3D mark_chain_precision(env, value_regno);
>                  if (err)
>                          return err;
>          }
>=20
> although I do not fully understand the above either. Need to go back to
> git history to find why.

Regarding this particular code (unrelated to this the patch-set).

Both check_stack_read_fixed_off() and check_stack_read_var_off()
set destination register to zero if all bytes at varying offset are STACK_Z=
ERO.
Backtracking can handle fixed offset writes, but does not know how to
handle varying offset writes. E.g. if:
- there is some code 'arr[i] =3D r0';
- and r0 happens to be zero for some state;
- later arr[i] is used in precise context;
Verifier would have no means to propagate precision mark to r0.
Hence apply precision mark conservatively.

Does that makes sense?

