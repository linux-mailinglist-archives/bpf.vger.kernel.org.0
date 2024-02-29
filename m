Return-Path: <bpf+bounces-22970-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7AB86BC81
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 01:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1170E1F263FE
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8A160;
	Thu, 29 Feb 2024 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVN+Ysd7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20622116
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165098; cv=none; b=h5+Z0izEctvj+CRu0Pcb/aO4YZRvIDA0ThSV5VGpxdaFl2oDMuCdtsPpFD/UYaznNABXFULCORn5bxURQBKt3aVMhWUsQwonVE3J8TC8vVDGmUx0dWZEjcMG8cdEVA1+ZQbi80cr0rAuIZqHizoujWcNY+7kVx50H8CtThgjXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165098; c=relaxed/simple;
	bh=Kdp7gr9msYrs+LC23rJg1hC2xr4ZIvopP2fkdihKh3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sSfRYd0F1ZVOxHFj5OQxGLauJOg+qapuQQByQwBigjZf3tPmKXyHkQYEkY6cegyx8Ofd5AA9xV5qh7eMeujmWFjEtjr6/06l0rdWHK0foO798FjHCpIKkcfSLqzblMOQImkN3ZMNztMKl4x4ugagdhXEFOR7psZJMOhoGJERugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVN+Ysd7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512bd533be0so253942e87.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709165095; x=1709769895; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q3dei5C6nJK/mgEgfC+GulYlse9AtsUM87fg96wgyvU=;
        b=NVN+Ysd7zujVCKYRvSChXdbOZuTGyIHzlIYoEM7fZZU+sxo3e8+9AAQA/WnziqQi8H
         XQ663oJTPAy3R1mV8KAQ2KIxXuEWrHq9QZtoZjhv7dxEaFD8qg8UcVRs0j1TNhaCUmqo
         z/X3TtsqYawg1/e56oB6tQz4IEVgHduNxvDyXtREzK+vh9PstZrdqnO6wzLCDgb4mUt4
         XxqXpkgNmvLXJoAiwY2FMhZlNQHlzBCCJwMqpfU+tDoDIN7YwyNYbv74teEQXtktBRXo
         PR7kaROgLKgms/BR4MsZWsiikfVfE/MAayt8gprhVV5Pa6V5StGXBhmnk3acaNXeXyDm
         zuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165095; x=1709769895;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3dei5C6nJK/mgEgfC+GulYlse9AtsUM87fg96wgyvU=;
        b=N5UtbthMriRepFiT02odul7r+7udPJ6lQrbK2d8eCC7P5KQfjEBPDqKbR1G7xnsJ8y
         0rMqHPpUrYLXVNqOJ49LUxlgSE9K2qsP+FPMTrYsnfNfaFHsuCrXxNCtr5SWt5sWdvA/
         o8fVO9kS6b60ltu0geyKV3An83z+u1rTST+tfbmOSFd/XgohDfmHM3GCeMMsDf9v5zor
         Zgo2JEeeDVCe9ohvpcyFj7DJv8Ce+H7GhtR0dVOVGo5hJhXZVpYXD1P93KVFgryL7yi7
         16IQztVA9qzaggSyaO3sqovsJQPOhhNfbrO69z9ajLvwlh9CEMrtxeLqRJHnnj7CUeGk
         r/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ+PwdRXRYVEg/NtI343SuA6NRquF/OVtOz9AXLbFRYIVr6KF8epCC3s+l87zBsPSjfaX1i+rtKxoaiBDhMRorUmAb
X-Gm-Message-State: AOJu0YyZnCLO2mzzGWb3Fln/exZHT0Dm/nt7IVaVfQ3Mxe4X0uCx9yus
	ivvAhSgsSRJfIj3tjldeUK8fFtmZysBBsUAA7CC+tX9NRQnx4rJl
X-Google-Smtp-Source: AGHT+IEjQ5HtlZZx2VQ8JUKtnnlFDkrFNv1k5YSFoEELLF+XWvzXzFS9ttAxt9yOu3ZSO1Kp5XDUMQ==
X-Received: by 2002:a05:6512:acc:b0:513:1ae0:2be2 with SMTP id n12-20020a0565120acc00b005131ae02be2mr291335lfu.62.1709165094729;
        Wed, 28 Feb 2024 16:04:54 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r11-20020ac24d0b000000b00513143a72bfsm36228lfi.239.2024.02.28.16.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:04:54 -0800 (PST)
Message-ID: <1fca7711dfcd9f1033390af6b1e1068ca9629207.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Martin KaFai Lau
	 <martin.lau@linux.dev>
Cc: andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com, 
 yonghong.song@linux.dev, void@manifault.com, bpf@vger.kernel.org,
 ast@kernel.org
Date: Thu, 29 Feb 2024 02:04:53 +0200
In-Reply-To: <CAEf4BzbQryFpZFd0ruu0w9BC6VV-5BMHCzEJJNJz_OXk5j0DEw@mail.gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-8-eddyz87@gmail.com>
	 <1e95162a-a8d7-44e6-bc63-999df8cae987@linux.dev>
	 <CAEf4BzbQryFpZFd0ruu0w9BC6VV-5BMHCzEJJNJz_OXk5j0DEw@mail.gmail.com>
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

On Wed, 2024-02-28 at 15:55 -0800, Andrii Nakryiko wrote:
> On Tue, Feb 27, 2024 at 6:11=E2=80=AFPM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:

[...]

> > Instead of adding struct_ops_refs and autoload_user_set,
> >=20
> > for BPF_PROG_TYPE_STRUCT_OPS, how about deciding to load it or not by c=
hecking
> > prog->attach_btf_id (non zero) alone. The prog->attach_btf_id is now de=
cided at
> > load time and is only set if it is used by at least one autocreate map,=
 if I
> > read patch 2 & 3 correctly.
> >=20
> > Meaning ignore prog->autoload*. Load the struct_ops prog as long as it =
is used
> > by one struct_ops map with autocreate =3D=3D true.
> >=20
> > If the struct_ops prog is not used in any struct_ops map, the bpf prog =
cannot be
> > loaded even the autoload is set. If bpf prog is used in a struct_ops ma=
p and its
> > autoload is set to false, the struct_ops map will be in broken state. T=
hus,
>=20
> We can easily detect this condition and report meaningful error.
>=20
> > prog->autoload does not fit very well with struct_ops prog and may as w=
ell
> > depend on whether the struct_ops prog is used by a struct_ops map alone=
?
>=20
> I think it's probably fine from a usability standpoint to disable
> loading the BPF program if its struct_ops map was explicitly set to
> not auto-create. It's a bit of deviation from other program types, but
> in practice this logic will make it easier for users.
>=20
> One question I have, though, is whether we should report as an error a
> stand-alone struct_ops BPF program that is not used from any
> struct_ops map? Or should we load it nevertheless? Or should we
> silently not load it?
>=20
> I feel like silently not loading is the worst behavior here. So either
> loading it anyway or reporting an error would be my preference,
> probably.

The following properties of the struct_ops program are set based on
the corresponding struct_ops map:
- attach_btf_id - BTF id of the kernel struct_ops type;
- expected_attach_type - member index of function pointer inside
  the kernel type.

No corresponding map means above fields are not set,
means program fails to load with error report.

So I think it is fine to try loading such programs w/o any additional
processing.

