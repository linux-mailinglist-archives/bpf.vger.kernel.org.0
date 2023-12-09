Return-Path: <bpf+bounces-17315-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 261ED80B561
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 18:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12BA1F21283
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BDE18048;
	Sat,  9 Dec 2023 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQRxeXQA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8E1700
	for <bpf@vger.kernel.org>; Sat,  9 Dec 2023 09:06:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so12554785e9.0
        for <bpf@vger.kernel.org>; Sat, 09 Dec 2023 09:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702141561; x=1702746361; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fsixEpQQNMjcc2BGwviasbpmwlPiTHvX8TquKcxAEd0=;
        b=bQRxeXQABg+v/2AuDfdnqPrCTQfHoxVqXbNXHPhseiMothgVCVh2Zuzzt3rc67lTdE
         /NlKRgV1OZOa6uIoEe2BCf6CSPyRbt6wu3/spodKaYNCl2Rv5WRWp8/XFRXBhatgKZJa
         XLB/bvLxurejwx980CkqLb++gPdI6mZMLGi1R0L8sjAo8tH6v9XPQvC/su475xLLYMSE
         qm4vnVerh3InuQTT6/JWgVPYn3WyLG6OxRJ4sasgDoDWYCeFg/fyQC626P1xu+55fc9R
         U4PkOruplUq7vfMcLKweZa7R9FPU/RJ/Opi+jQm0CRABv5JDiiZ/zI5hgneC5wuMdSAE
         m33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702141561; x=1702746361;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsixEpQQNMjcc2BGwviasbpmwlPiTHvX8TquKcxAEd0=;
        b=XlqgGWnwZPQYz1mDSXCyONeBZiSPcowkq3Wv6ZJR1Qmi0d6j5icEM7eOHZrs5CVCJ3
         4nOLKOTqDblALHOwJyyVBGUajXIHZKF6+jmLm1Ov2YlxrA+gbJ3cUi9e9oWoe29c1XA8
         j9cGCOGrxG9jesOVibwCGYVWxvmpAKgjzwdEBaQvtWTRSqHXz8LR5LyFHMPGj3m2hwnI
         UDqdSPkElZIvMw1fswskwmm86V7dwvQ75Uz9NsLbfqFk7wzCoLhIZUUh1dHZKS4EM07F
         vHWNTCwPl+OHuG/vGRq6UNE80puPGpcZe0Y1Y2jdUluFMpmv9nr6VQj3CAsicG27cMvJ
         /kGw==
X-Gm-Message-State: AOJu0Yx/zhALKS8AhwKAiJaH8M9hz6SkAXXUkCVlPvqD+/sIgS7jRFuR
	wqjUhsy3WZeBYVPc9ybo4RE=
X-Google-Smtp-Source: AGHT+IFqVHgPII5PFZZWpwNX4wOdEJK2DkyavW+UC7ZgnHhzin1aMAGgnFkilnjr+NsOrDB8jT6KrQ==
X-Received: by 2002:a05:600c:501e:b0:40b:5e21:ec0d with SMTP id n30-20020a05600c501e00b0040b5e21ec0dmr956681wmr.63.1702141560439;
        Sat, 09 Dec 2023 09:06:00 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l39-20020a05600c1d2700b0040c2c5f5844sm7066435wms.21.2023.12.09.09.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:05:59 -0800 (PST)
Message-ID: <bd8a244d3c1ffb3c6e9860346e90eac7eb2a181d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: handle fake register spill to stack
 with BPF_ST_MEM instruction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Sat, 09 Dec 2023 19:05:58 +0200
In-Reply-To: <CAEf4BzaE6TiThSaq7+=KERW=zP4G6vJz1nQ6-EWQrpnF4Np=-w@mail.gmail.com>
References: <20231209010958.66758-1-andrii@kernel.org>
	 <bff7a93dc02d42f71882d023179a1b481f5c884b.camel@gmail.com>
	 <CAEf4BzaE6TiThSaq7+=KERW=zP4G6vJz1nQ6-EWQrpnF4Np=-w@mail.gmail.com>
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

On Fri, 2023-12-08 at 18:15 -0800, Andrii Nakryiko wrote:
[...]
> Now, the subtle thing here is that this doesn't happen with STACK_ZERO
> or STACK_MISC. Let's look at STACK_MISC/STACK_INVALID case.
>=20
> 1: *(u8 *)(r10 -1) =3D 123; /* now fp-8=3Dm??????? */
> 2: r1 =3D *(u64 *)(r10 - 8); /* STACK_MISC read, r1 is set to unknown sca=
lar */
> 3: if r1 =3D=3D 123 goto +10;
>=20
> Let's do analysis again. At 3: we mark r1 as precise, go back to 2:.
> Here 2: instruction is not marked as INSN_F_STACK_ACCESS because it
> wasn't stack fill due to STACK_MISC (that's handled in
> check_read_fixed_off logic). So mark_chain_precision() stops here
> because that instruction is resetting r1, so we clear r1 from the
> mask, but this instruction isn't STACK_ACCESS, so we don't look for
> fp-8 here.

Ok, so STACK_MISC does not actually leak any information, when misc
byte read it's still full range. Makes sense.
I think STACK_ZERO handling is fine, there is no need remember it as
stack access, as it marks precision right away.

Thank you for explanation and sorry for false alarm.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

