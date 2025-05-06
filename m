Return-Path: <bpf+bounces-57542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBAAACABB
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 18:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFD83AB2E2
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA21252282;
	Tue,  6 May 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="h5lcqooA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C24B1E6E
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548412; cv=none; b=CBHJLW+DNYIxLo0W4xjNHuzOIsnaBe4/66fh1jlEQr5EiSf4rubgeozn1OlNpoDjY6v9NLWw/uH30BWQSgzftGPKoiGsuWxTsZBMQQdIMfyr1Xiw3/CsbkRZHGBvEoNjNset9FXalNHxhIepfI/QJMSw+3Dcw/DoWosS/RgHWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548412; c=relaxed/simple;
	bh=MWyyMDTMqlr1guj53M2ZrYMA6BQcHQLTqHaXOxwuZl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=KQH/fFSBOTJe+Gidq+tWwK4yZ3IpHOmedi02wb6N1PNGvWyiJPoV/qERF7l+xzT7z+ZFi3MVo+Yizw6FilzYwWR3F0yXQn4e1fKaV2HiA2COa2U3fAmyXYTxjfaas0zBuucItAkA+R6xunFkFgWoyO6CuNm+U3p95b2GjcIOfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=h5lcqooA; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39bf44be22fso4011406f8f.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746548409; x=1747153209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nlGw1DoH5GpCpdT2CGs9E8kVgbap9T0vLjtXdo8eos=;
        b=h5lcqooAJBW/p9SmIggp6xjyW3dkEvNPilx5F0DRyqOP6JC7e5ml9Ic+5yUSpNspTF
         YS5ECRm/H/mT03B+b+si1viHhsgcTZBQ8Fr4U90NYVKvHS0zqLv/KbXX88PWMdn20toP
         xyLW4ozWYj+pIrX6HFxfH8axTbrTHNcFwyaJ/X/L/yshDpNAsXE/9P+Hev6VvU9IKu+3
         32fuJnBAresVT6yIAjBp38HjrWt/+lVHcCG762/bNgcVPUx5Fh0RbIuJJ+eP5JvKu4rd
         lJN5wHzHcvtBo55W+1ZFik1uI/mndv486PAZLSNBDYnUxvogf4uwoIZydSGLTQHkbMHP
         kEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746548409; x=1747153209;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nlGw1DoH5GpCpdT2CGs9E8kVgbap9T0vLjtXdo8eos=;
        b=Q5aPoC2CubeKx36mruIyPb/zpzwp436HU3W8aJ3J56Y71Zaj0yc7UGLmcfdPO5mU8t
         +xjJWWBH/Zfgi/sOaIDVWy15YjWZQqe83ZV51/8SQuWKj8WyP0deAKrpNawCXACNjB6l
         0brXkMzkUIvaUtrGLUArX2KZIiAM0mW4MgEKDt4lBZIB+6dWkDoYyVmJkBbwhcDTnPjy
         z9NJZlBL/z/RdqcaU1nk5qqaKTQP5dDaP1hpeYutPglvzMqFLiW1u4Sgqll+RoH4olZc
         JIMk2qglekbH4u+l6lvLLQ359wDNunnuv9v+fAKYJhN4ALlJzQEfc10zcuNn4gpYOHsI
         oJrA==
X-Forwarded-Encrypted: i=1; AJvYcCVmyff5Fjz0umzmPY/fmzE7jK7lvkK8jP0R+noRkrzH9gP5f+EoTEeBzPHs2qt/DNeaFRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznqctYHalUSvI3MPbbuzuNPCmhsN2ha6CvqklO2hDv9YFfsAzz
	GATaXWVJNGq5dlAMlugL0E7FSfIJ7J0W2AueZ7fL1dy2lCG/xrxsm8DSn0NGlpssYJqQxWZiZZd
	FXNqSGSBMuAkmuW06VgkDjekQnSL/QDJhcuDSZg==
X-Gm-Gg: ASbGncsODRK80dnUxbU3xEuZDsaLOkxu5hnxFUy8uxMqbS/ZBn79B3UWsbxjv2SJljW
	gCUJymPA4tDgzE4N7lR5TzDf08YsFFjqzEj4bwcnTtLWDTruEnwt4luaGBHavKJEiWG01xzs14Z
	Od5XSPGM2ZVHBVl+sKLo6ufTPcZcCH2b6L9fU=
X-Received: by 2002:a5d:5885:0:b0:391:952:c728 with SMTP id
 ffacd0b85a97d-3a0b499c89bmt89540f8f.4.1746548408716; Tue, 06 May 2025
 09:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-vmlinux-mmap-v3-0-5d53afa060e8@isovalent.com> <729dc77d091967d9496abda4ab793033f3979b2681da287f8bbf2df3de705dbf@mail.kernel.org>
In-Reply-To: <729dc77d091967d9496abda4ab793033f3979b2681da287f8bbf2df3de705dbf@mail.kernel.org>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Tue, 6 May 2025 17:19:56 +0100
X-Gm-Features: ATxdqUF37z_diu00PV7TN54FeQ-OZ98K3aAFNIZx_zAyBZw3MOZX_hEiKRLxDyo
Message-ID: <CAN+4W8hDMdUnXitHuqUxA=mFOb=-QRQrejY8Koqb5mk0z-q9zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] Allow mmap of /sys/kernel/btf/vmlinux
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 8:01=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> Dear patch submitter,
>
> CI has tested the following submission:
> Status:     FAILURE
> Name:       [bpf-next,v3,0/3] Allow mmap of /sys/kernel/btf/vmlinux
> Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=
=3D959736&state=3D*
> Matrix:     https://github.com/kernel-patches/bpf/actions/runs/1484381142=
4
>
> Failed jobs:
> sched_ext-aarch64-gcc-14: https://github.com/kernel-patches/bpf/actions/r=
uns/14843811424/job/41673133374
> test_maps-aarch64-gcc-14: https://github.com/kernel-patches/bpf/actions/r=
uns/14843811424/job/41673133358
> test_progs-aarch64-gcc-14: https://github.com/kernel-patches/bpf/actions/=
runs/14843811424/job/41673133413
> test_progs_cpuv4-aarch64-gcc-14: https://github.com/kernel-patches/bpf/ac=
tions/runs/14843811424/job/41673133375
> test_progs_no_alu32-aarch64-gcc-14: https://github.com/kernel-patches/bpf=
/actions/runs/14843811424/job/41673133323
> test_verifier-aarch64-gcc-14: https://github.com/kernel-patches/bpf/actio=
ns/runs/14843811424/job/41673133333

The failure on aarch64 is the following:

Unable to handle kernel paging request at virtual address ffffffffc2058b88
Mem abort info:
ESR =3D 0x0000000096000006
EC =3D 0x25: DABT (current EL), IL =3D 32 bits
SET =3D 0, FnV =3D 0
EA =3D 0, S1PTW =3D 0
FSC =3D 0x06: level 2 translation fault
Data abort info:
ISV =3D 0, ISS =3D 0x00000006, ISS2 =3D 0x00000000
CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000041c91000
[ffffffffc2058b88] pgd=3D0000000000000000, p4d=3D000000004250f403,
pud=3D0000000042510403, pmd=3D0000000000000000
Internal error: Oops: 0000000096000006 [#1] SMP
Modules linked in: bpf_testmod(OE)
CPU: 0 UID: 0 PID: 105 Comm: test_progs Tainted: G OE
6.15.0-rc4-gcf5bf38d19e3-dirty #2 NONE
Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
Hardware name: linux,dummy-virt (DT)
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : validate_page_before_insert+0xc/0xf0
lr : insert_page+0x54/0x160
sp : ffff800084e4b7e0
x29: ffff800084e4b7f0 x28: 0000000000000000 x27: ffff0000c0ca5500
x26: ffffc1ffc0000000 x25: 0000000000001000 x24: 0000000000000458
x23: 0000000000000000 x22: 0060000000000fc3 x21: 0000ffff8cfe6000
x20: ffff0000c26a1f00 x19: ffffffffc2058b80 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: ffff800082a651d0
x11: 0000000000000323 x10: 0000000000000323 x9 : ffff80008037d21c
x8 : 0000000000040324 x7 : 000000002193fe5d x6 : ffff80008231b0b8
x5 : ffff0000c1fa2f80 x4 : ffff0000c26a1f00 x3 : 0060000000000fc3
x2 : ffffffffc2058b80 x1 : ffffffffc2058b80 x0 : ffff0000c26a1f00
Call trace:
validate_page_before_insert+0xc/0xf0 (P)
vm_insert_page+0xc0/0x130
btf_sysfs_vmlinux_mmap+0xec/0x1a0

Clearly I'm doing something which is ok on x86_64, but not on aarch64.
Any hints how to fix this would be much appreciated.

Lorenz

