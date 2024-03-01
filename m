Return-Path: <bpf+bounces-23172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2206286E7F6
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 19:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5DC1F29168
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B4517BA4;
	Fri,  1 Mar 2024 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZWCIrBt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D122092
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316444; cv=none; b=Tx0pj2xHfpKszztSE1pB1PEQ+fyEs3MUCD5zDj42mJF1qdndUt4JaThAr39kt/dz5w80Wq/qityfOAjHPKhktm3i9wO0ylb7iCIfFMz9O5ZIcKDYyWfgknLVWuNfOely5Kirc6pc+DMjLphzR3hesl6JDf2G+9sQddAU9jz3AfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316444; c=relaxed/simple;
	bh=iipMwBVIfsufPUdo+WvYW0UupTaXj1EcTYn66BeTt+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZFTP7V9ufaoRSopsIEYCFJDIAgurOHOBeUJ22Q+8+nb3pp9955v9kmY8CL3+IkcWGIamuwPoFjcgAgpYyBTZVXdDCc1aBEPgrlT+DR2WNvkxcNdRoF8wdaPS14k5JmpAz2Bq9rEGm1jBzpjylkH7jDLaVdDo3VWTRNn8nzyV7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZWCIrBt; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so25481041fa.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 10:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709316440; x=1709921240; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pgR98dv5m9fmyspbDAl4h0vwnaXF0N6gymGmH2IsfYg=;
        b=eZWCIrBt1mUR4U9iUtALCQZDyChuuvAiOwb7D8CNdeT/i9OcVCUJEIkFawBIrcZunF
         plx6tzv90TwxHxGL0q2tzPGHz3F3oray91m9S3aPw0Pr/IqpVGk9JJmcPSOkmN4+yhal
         mY1yDXE6lDL0je0iTi5+OeMf1rDUHGCnAUsk/jAJJaYCjRjwN4xusI3H+HNZYMnvufbO
         xpqrTIsIfMOFfYdV7xr+lEo4ut8XUBwYLQcM6L13gnk8NRP4+lWZbC21tk0BEudHKGZI
         5d141ywJymp4Wl4BXh2BWz6pErdA1UX73zSUY4rxj/4Aj890UdNlsNLGCZ9C23JO+Rdm
         /URA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709316440; x=1709921240;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgR98dv5m9fmyspbDAl4h0vwnaXF0N6gymGmH2IsfYg=;
        b=V6IQdbCeurU8YZcuWgvcuetlXzeYsu0vhimvY0dDQhPilVDPPUEZtVbjmNsxvV7dGI
         OCRkP11kk1ChwjEOKXVfT6Z7B0Q5jLjG5eYvKQeql+oF4xZIhMmi7mkEWMW6MsEP3RlI
         DVZbSc3DRv+aSdU8cANfPmrGDqEdHsJbJbsMtZ0ckDhy29Sgf7LpGD7ToQ7JUuypPqfJ
         HIquhBfdUon29e8WK5Cmaut1sFpxi+T3/IPm+DiKuTYbzLOoiY6HXLZWfx+pfQBFu1iq
         2xpLVvKF79zrkxXMMhy4aVtA/qFavRFS+W0HWn7CL2UwkP4cYVzTmtnuOTt0dXRTcWHu
         jevQ==
X-Gm-Message-State: AOJu0YxXfkHPMoQWyirKXhqEmKw1g9hWTAHVuV2PUe5ixy9sRnDysJvk
	Im5AoeimYCdjUc6NVXQUQNtilmigxXRk2N3O/F8L/m6DI5pi4YGH
X-Google-Smtp-Source: AGHT+IFS3lWZEUdKkGIyFCMWGnNbUqTSSLaACkSBq3OysQlyUN7bZVNikYN5mZsNXAItxKXPhuDfHg==
X-Received: by 2002:a05:651c:a0a:b0:2d2:7b31:882d with SMTP id k10-20020a05651c0a0a00b002d27b31882dmr2601354ljq.8.1709316440282;
        Fri, 01 Mar 2024 10:07:20 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9613000000b002cf55fddca7sm669256ljh.49.2024.03.01.10.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:07:19 -0800 (PST)
Message-ID: <fbe91fde9e6057a12f95792211be49f25c42d8a2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior
 for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com
Date: Fri, 01 Mar 2024 20:07:13 +0200
In-Reply-To: <CAEf4Bzb--AaV3=hu8J1F-taPPpYDcuRRRs_QztVr5c3g=RJFXg@mail.gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-7-eddyz87@gmail.com>
	 <CAEf4BzbXzsDUx-dvUQQEMcCVUeUjnBnbF6V4fmc36C0YzVF73A@mail.gmail.com>
	 <d5fda01ecfac47e096e741a68ac8a1d2d726fc16.camel@gmail.com>
	 <CAEf4BzYRS-wd_FTi-_=1t9mjgMp3P6yrTqbkQ+359aKmcjZDNQ@mail.gmail.com>
	 <316cd654a3c3294a2bb2b9ca2e5bc9767bef294b.camel@gmail.com>
	 <CAEf4Bzb--AaV3=hu8J1F-taPPpYDcuRRRs_QztVr5c3g=RJFXg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-01 at 10:03 -0800, Andrii Nakryiko wrote:
[...]

> > Kernel rejects DATASEC name with '?'.
> > The options are:
> > 1. Tweak kernel to allow '?' as a first char in DATASEC names;
> > 2. Use some different name, e.g. ".struct_ops.opt";
> > 3. Do some kind of BTF rewrite in libbpf to merge
> >    "?.struct_ops" and ".struct_ops" DATASECs as a single DATASEC.
> >=20
> > (1) is simple, but downside is requirement for kernel upgrade;
> > (2) is simple, but goes against current convention for program section =
names;
> > (3) idk, will check if that is feasible tomorrow.
> >=20
> > [0] https://github.com/eddyz87/bpf/tree/structops-multi-version
> >=20
> >=20
>=20
> Let's do 1) for sure (ELF allows pretty much any name for DATASEC).
> And then detect this in libbpf, and if the kernel is old and doesn't
> yet support it, change DATASEC name from "?.struct_ops" to just
> ".struct_ops". Merging DATASECs seems like an unnecessary
> complication.

Yes, makes sense, half way there already, thank you.

