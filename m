Return-Path: <bpf+bounces-42706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B39A93F1
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E98EB227FC
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 23:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F301FEFD4;
	Mon, 21 Oct 2024 23:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw5Ykd2T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA551E201D
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552326; cv=none; b=c/J3IbglhR9cuExkD8TVJ2akTpCsOOwS1whaNGwfxEjhmicL9BcH0IiArQlax5tIC/Ng6TDjb+Fxpqma/ejsIyH/zKfgOfBzGIM8gZeWKYjn2kGm2TztU6GVqYHainI+3SZRC+E70oG3FUFCjx+Z26xtJV+D8bQo53E/bF0AjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552326; c=relaxed/simple;
	bh=CjI+/Q+iOPyFXDtYtHkf3B41PMEo8AKtoiZMU3VXbYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsZKzrYJXn9HVc209xs6A3B/RSLO/YBRrMoQkDam0sdG4HwzZDyk9EpIZzNNNIpechpviRZx9+f1vlLSFOtZyGbP9khl2gk7V0HIkW3uhgcfHkByg0HuX53VGIMTpkrUohJIgdxe3NbOpHCM6aR7FvMt6s2+oSROpLMgfzDgNL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw5Ykd2T; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so3865890b3a.3
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 16:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729552324; x=1730157124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDHtkk5JFj7beIagVYG+bExnEIrDNhyfsPwqRkpuBgg=;
        b=fw5Ykd2TeUHVCl3upY/2iDcpJ8gjjiJlr4rzLqbrnh0IUBoI+ZDQy0SGl68Vc9Ofqx
         zvGjER9v3joUOz9UaHgR+QqwTCBSDFCj+966Q0quUBicS3OCHVsdkMfLrXSKzVWt56hw
         GG3bshPFdkghxxQbOcr6aMhg9BYt2JWeuWD05Lo0+jiQyEy4EKZbuepeHpvq3ic0nzqi
         CSePDLWz7gBLqRniLxy6Sp9cTooNNHQlxc/M1mr28vdqO/R4/lgEERHknBZTk6ueAWg5
         hIEEX+iyS84HdT7i84TuzD85Ss7sCR6yaePbpjo+5aAqiED6af3QlxIbo71Mjr7LX/Hf
         SVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729552324; x=1730157124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDHtkk5JFj7beIagVYG+bExnEIrDNhyfsPwqRkpuBgg=;
        b=NSiY0sZeC4Fl8g67A9PiPicNYqkJunx8Fubvo9JvauwIWnshFeW6cgv+6m1Sa3lXMu
         OuWwOlBwZSQ2nlJ0JNKtS2FJL+A5cZyK+h+cF6YFt5a1vpQz+4+wEGsiNDXPvooeZSbh
         1BgrK4sJIYrtWweaotGGMG3txDJWaqEGYoRZA19pfkVkehGCdJKmhS5BMImezR2QqEbC
         IT1aHCVtxNC7wrG4P9ui3awOAFvXm7+PrcbSVPsA7wdPoLR5kw3f7A7mydJOHD70xh26
         8McPiBfCxw9wp/YVlm0b3tKQHekq81h7Sb2Z9svFu2DeLFZVrnHC7AdVYQM1Nofx3j5s
         fbWw==
X-Gm-Message-State: AOJu0YxWFhD3Z9pZSRgvpsDy2Rbx4b8wZ2Edg3dnWBY1smOyJNIGR16B
	n9ttytbH/RRpWsjL5lxFcbGd9IMg5HV+cN04Z3A7kpTyIF8rQXq7LtlkK9VD57CfUVSaa7CmGk5
	D8lNsD6/JR0+qnfwgEQhb2zyHUQ4=
X-Google-Smtp-Source: AGHT+IHg0QT6yNl/EtV3wsR+7GLze4NzWE2eX9ru4eE15G0U7VgSjJV2ZCyqDFm7GjlVaA6HV8fH93E8h+nein0VU+E=
X-Received: by 2002:a05:6a00:4fcb:b0:71e:6743:7599 with SMTP id
 d2e1a72fcca58-71ee4250c11mr1227145b3a.7.1729552324276; Mon, 21 Oct 2024
 16:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
In-Reply-To: <20241021014004.1647816-1-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 16:11:52 -0700
Message-ID: <CAEf4BzZ+J9P327biUtKu6Mqa=vpWk=qdgxt8dmAcy=dNFvaJHQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/7] Misc fixes for bpf
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, houtao1@huawei.com, 
	xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 6:28=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> The patch set is just a bundle of fixes. Patch #1 fixes the out-of-bound
> for sockmap link fdinfo. Patch #2 adds a static assertion to guarantee
> such out-of-bound access will never happen again. Patch #3 fixes the
> kmemleak report when parsing the mount options for bpffs. Patch #4~#7
> fix issues related to bits iterator.
>
> Please check the individual patches for more details. And comments are
> always welcome.
>
> v2:
>  * patch #1: update tools/include/uapi/linux/bpf.h as well (Alexei)
>  * patch #2: new patch. Add a static assertion for bpf_link_type_strs[] (=
Andrii)
>  * patch #4: doesn't set nr_bits to zero in bpf_iter_bits_next (Andrii)
>  * patch #5: use 512 as the maximal value of nr_words
>  * patch #6: change the type of both bits and bits_copy to u64 (Andrii)
>
> v1: https://lore.kernel.org/bpf/20241008091718.3797027-1-houtao@huaweiclo=
ud.com/
>
You have three separate groups of fixes, please send them separately
so they can be landed separately and tested separately:

> Hou Tao (7):
>   bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
>   bpf: Add assertion for the size of bpf_link_type_strs[]

first, link type fixes

>   bpf: Preserve param->string when parsing mount options

parsing fix

>   bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
>   bpf: Check the validity of nr_words in bpf_iter_bits_new()
>   bpf: Use __u64 to save the bits in bits iterator
>   selftests/bpf: Test multiplication overflow of nr_bits in bits_iter

bits iter fixes

>
>  include/linux/bpf_types.h                     |  7 +--
>  include/uapi/linux/bpf.h                      |  3 ++
>  kernel/bpf/helpers.c                          | 45 +++++++++++++++----
>  kernel/bpf/inode.c                            |  5 ++-
>  kernel/bpf/syscall.c                          |  2 +
>  tools/include/uapi/linux/bpf.h                |  3 ++
>  .../selftests/bpf/progs/verifier_bits_iter.c  | 14 ++++++
>  7 files changed, 63 insertions(+), 16 deletions(-)
>
> --
> 2.29.2
>

