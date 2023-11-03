Return-Path: <bpf+bounces-14128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF5F7E0AC0
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74F3B21464
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFC92376B;
	Fri,  3 Nov 2023 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d89lIR5O"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD41D695
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 21:39:12 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EA0112
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 14:39:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso4119658a12.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 14:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699047550; x=1699652350; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1zRLa7sBei/IFGrlANDWVJfmUM0EldzAyGd6JNFVnzY=;
        b=d89lIR5OKgrzOjMSc2fVJAKYn7URGJkMj6p2WEYoVf/DLJGatRRymIGdHqgVlQl+0/
         wpO+AnQBiE+YkuSew0wzZBcjMWGa+xK4rFUpgBG/6pmTdvKIsLoKvszmUfFy4zJQoWss
         TEG2++RdegTndElJyRGTZRLJ5I8TJPNUa6xH5FCpnPB9c9Y65jmG9B5FlSPGkUacyKVG
         o2hy8Rbq+Mv6ssMmXtpJs9pVukPNVYmupBx3e0H9eIprfhsdLX8GU8uW5tqejKjVOy7N
         Iy3NYQCayMxIePVGrnnDk+mWaPICeELqR0gOAkE1btpT4lfWKWjP8eeriyyluMPrMxuX
         BA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699047550; x=1699652350;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zRLa7sBei/IFGrlANDWVJfmUM0EldzAyGd6JNFVnzY=;
        b=fmCNhAjGZabzBYDKeJoGnK/Xza1rEqxZaJE+lx2/aZ2TFBxRFcA1a99vq1X5tjDYYM
         XF6c+hUC2zeuS1lCAQxp6psqYfjTGej+AcQXUSWd3fWc0CADRGT+K/q6Wz1ax7tfTf7U
         TvOPZdS38g9mMpDodHCG9j6AIxKcU6H5XUJQaB69ChAY1nBV1WTDRUGkz9zypq3nTAe5
         G20QyOiXPBR2fvwqggmKPaexERGfQO2QPnWDwNHuMJbY/JiJ+H31XovN07A0ONU4r7QM
         347P0f8sdeLupTxkCk6I/XfMQ+7gxNfUsY0/dBOvB5uwZo2VxHOctFw7Il9JNBlU12im
         jLRQ==
X-Gm-Message-State: AOJu0Yw5jfLymbfwZ7a1b7CP2wbpbVXNzc0Ra87klDiXzpRxK1AHepre
	nGLvQijKn67/kxvdQU6cm1A=
X-Google-Smtp-Source: AGHT+IGJ6IDh0uTQ3INB83tod9UmDkp5vMddahorTV/JC/LT2kpLJ7AQM1SlQugRhL1uCRoHQ7RaMA==
X-Received: by 2002:a05:6402:206c:b0:53e:ba3d:acb9 with SMTP id bd12-20020a056402206c00b0053eba3dacb9mr18038214edb.24.1699047549851;
        Fri, 03 Nov 2023 14:39:09 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b00540f4715289sm1396691edj.61.2023.11.03.14.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 14:39:09 -0700 (PDT)
Message-ID: <e8adb5bcc16c1a9744f5bee420111ef06da4dd1c.camel@gmail.com>
Subject: Re: [PATCH bpf-next 04/13] bpf: add register bounds sanity checks
 and sanitization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Fri, 03 Nov 2023 23:39:07 +0200
In-Reply-To: <CAEf4Bzbc_uc=77ZkipBQ_00WEh1-3zaUzOWPq4kwk7Q=YNLd6Q@mail.gmail.com>
References: <20231103000822.2509815-1-andrii@kernel.org>
	 <20231103000822.2509815-5-andrii@kernel.org>
	 <f0344812c7d5cf1384b0fb7a04100d940fdbcaf1.camel@gmail.com>
	 <CAEf4Bzbc_uc=77ZkipBQ_00WEh1-3zaUzOWPq4kwk7Q=YNLd6Q@mail.gmail.com>
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

On Fri, 2023-11-03 at 14:11 -0700, Andrii Nakryiko wrote:
[...]
> > This is a useful check but I'm not sure about placement.
> > It might be useful to guard calls to coerce_subreg_to_size_sx() as well=
.
>=20
> Those are covered as part of the ALU/ALU64 check.

Oh, right, sorry.

> My initial idea was to add it into reg_bounds_sync() and make
> reg_bounds_sync() return int (right now it's void). But discussing
> with Alexei we came to the conclusion that it would be a bit too much
> code churn for little gain. This coerce_subreg...() stuff, it's also
> void, so we'd need to propagate errors out of it as well.
>=20
> In the end I think I'm covering basically all relevant cases (ALU,
> LDX, RETVAL, COND_JUMP).
>=20
> > Maybe insert it as a part of the main do_check() loop but filter
> > by instruction class (and also force on stack_pop)?
>=20
> That would be a) a bit wasteful, and b) I'd need to re-interpret BPF_X
> vs BPF_K and all the other idiosyncrasies of instruction encoding. So
> it doesn't seem like a good idea.

tbh I think that compartmentalizing this check worth a little bit of
churn, but ok, not that important.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

