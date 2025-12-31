Return-Path: <bpf+bounces-77612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87477CEC5A2
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 18:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 707FB300E3DE
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCD229E0F7;
	Wed, 31 Dec 2025 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBmAy/O3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2344281369
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767201299; cv=none; b=jXCEOQR+pq70+4B0BAq+iSKmb+7TYe4g8L+bW8/lWYIfd9LkGthAAUuTqqsmWda/6Z3igmKiIt4tc/nxjzujNSCgy7dWd06U4iaA4osoILvwggpKOr2SD9W3BnaFST89b4wKS9DVOdcv2+Vs3FVAuaFtG25SU9nlgHVLkGSD8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767201299; c=relaxed/simple;
	bh=Fsq00orAbx6gf+jFOsA37WfFnlWAgcCuctQqeAhXNMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHz98pNVjdaIULKadOFsbhgC2s3v4ENTYqLVAAzgBXgHWpiXN5/+QxP5xV66uMBjws1DMvqS1FoFWOdBfZ7yKUseuLo4eZ7zLupRuC3mt2OAXGs1jUogycWNEjgq31ghQ9/86uOhLuL+RtPeQ9e9VcVqm2lpjdzXrQOiv8y3cAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBmAy/O3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477563e28a3so67071865e9.1
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 09:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767201296; x=1767806096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1d3Dum9aFyRpHz1z9Qk6iD4vSzFJscDkUhD1cvVs18=;
        b=kBmAy/O3Frt1st8AvS5fCQu7BRuz84po7JJ668XE5osC/KHUP8Z3iFGVxfXpUPR2Kt
         tFuVT5zHIXj46qNKPiLw7UnWlIgUCka74VNfFvyahPZpRemnVh4VRe3EFkg/YTV4rpEg
         9C2YxPdSSTqoK3USfR9ICAwkPw2ISlwxLc2EsQnWGf2oZcBlVdgQUuXjak2qV1B6dAaI
         q4PV0tu3GwHFxF4nBLAmlu7UC0+bCruRetUPdIsdxjbMH91hNtaPleIhrv9zMD7/dCwf
         3naSEH0aH4mpANp0j72dCv18LgKdkaYKlTNznvrV3v2Z0E+ZJYNazLMYSVsmTXSn2y/m
         Xn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767201296; x=1767806096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I1d3Dum9aFyRpHz1z9Qk6iD4vSzFJscDkUhD1cvVs18=;
        b=VnSRzKHsXHWbZjwEzDa4bB4rmo+5mlpOJF5jIXwiyN/v0O+Pj2uKId+hYzpsOwT7cE
         quyeYGePyOO06iBuhqcLN/Cp86hfJQXHepcHou4iAvo2TvDXrspQM9L+aJBsnWXUHRcd
         MPJWkm/eYrjouPKTMxMspyBxtwn1HaYRhSF78Tm7jlurAIiv+uk+2DWN78DyqlHiDjRn
         5cSMmSFdfW5q7cibypGOIj7qSEdAEgabr1np2MyboQ5NHegXGkZTzerAL1X03gAWl0GO
         H23+DV8RurqARG3Si/a+/rQPxYd6Nr75IRzWLpm0ukKAFgpgPIYAJN7k2T4Z+RRkKG3w
         4IhA==
X-Forwarded-Encrypted: i=1; AJvYcCULTD0fTvrS4RDljjV+y0NOl3Smuqlpf+YMSKFPCxgmAetqXn5sPUWFWwdWsa5YGackIjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+F3+bJnnBIzor3c1Xcyra85CmN9Z8QbKmwFLOhi8713sSCJD
	x75F2lQf/7krO4wQBRqESyV/RnXbGHzcX5xEGQLIxIAUtNNvm2tupZV2rM1Na+vgM1hZcDcmWA7
	kRoinMKTQFToOZ3HALI0t9nGiV486vOw=
X-Gm-Gg: AY/fxX7QVaMCRQTiIGQHc4PRHm/uFEiw9yQ2MneZFw/E3HtUT9A4Kg18aBbKW4O08B1
	SgQGdHsJIecRknpRs1/mSTGgnHpzGJBqAESZBpakOKiAT427h10St7gvJ42X+UJrwZjF0zUgeKe
	CQ70Ygmiq7/lQlZxhOyYIOOyfuleBDXCrz4OFkkLKp9fSjRZn/kU9GcKIsXEP5pa2LrxUGpHUha
	WlSbBjSUATXj+9qzclXyRbqEbMMB2uhLagj422bV0sW+rIPkLtX0oozTsthYBMNqkPLit7dOjVA
	4R6LJbPKyrNibr9Vo6nmeIgzPM18
X-Google-Smtp-Source: AGHT+IGUf1EEAwdoDgwm6Fy/t8DB+P45OzFPl+MWkRcRqBmmoVfFX3n9wHFoS9BycdEHj9yZHZqnxH/bcQaBzY0L1WY=
X-Received: by 2002:a7b:ca4a:0:b0:477:75b4:d2d1 with SMTP id
 5b1f17b1804b1-47be29f3835mr348300525e9.15.1767201295976; Wed, 31 Dec 2025
 09:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227081033.240336-1-xukuohai@huaweicloud.com>
 <CAADnVQKJk7pGW50JHj6tZAeHLxCbgmHBdhwZCY4NT-6MTg7=sQ@mail.gmail.com>
 <0c441710-5250-4706-ba81-b6b4b1277313@huaweicloud.com> <CAADnVQL6PTN2PN9ngV2PSXb=csX1KX+D-BZGzDDNtvQvtGkSkA@mail.gmail.com>
 <50a1889b-eb5b-4a76-9dc9-b55df641170e@huaweicloud.com> <CAGn_itzSC7K_eF7Lbm-im83VObqqoz6rvYMqVAOCXdD0pQ+M6Q@mail.gmail.com>
 <a51149f1-cd63-4eaf-98dc-53be880930ab@huaweicloud.com>
In-Reply-To: <a51149f1-cd63-4eaf-98dc-53be880930ab@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 09:14:44 -0800
X-Gm-Features: AQt7F2p4Xr5aVMJ_3R9WRHW-dktpu7ayEy8c8Y3BckD_czs1k6oC72U8AJJBm88
Message-ID: <CAADnVQKeC9zue5hVr2WCaMs+3CBH-zptvhwCC4wXROXCvZvXJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 1:22=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 12/31/2025 3:06 PM, Anton Protopopov wrote:
> > On Wed, Dec 31, 2025 at 7:47=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud=
.com> wrote:
> >>
> >> On 12/31/2025 10:16 AM, Alexei Starovoitov wrote:
> >>> On Tue, Dec 30, 2025 at 6:05=E2=80=AFPM Xu Kuohai <xukuohai@huaweiclo=
ud.com> wrote:
> >>>>
> >>>> On 12/31/2025 2:20 AM, Alexei Starovoitov wrote:
> >>>>> On Fri, Dec 26, 2025 at 11:49=E2=80=AFPM Xu Kuohai <xukuohai@huawei=
cloud.com> wrote:
> >>>>>>
> >>>>>> From: Xu Kuohai <xukuohai@huawei.com>
> >>>>>>
> >>>>>> When BTI is enabled, the indirect jump selftest triggers BTI excep=
tion:
> >>>>>>
> >>>>>> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> >>>>>> ...
> >>>>>> Call trace:
> >>>>>>     bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
> >>>>>>     bpf_prog_run_pin_on_cpu+0x140/0x464
> >>>>>>     bpf_prog_test_run_syscall+0x274/0x3ac
> >>>>>>     bpf_prog_test_run+0x224/0x2b0
> >>>>>>     __sys_bpf+0x4cc/0x5c8
> >>>>>>     __arm64_sys_bpf+0x7c/0x94
> >>>>>>     invoke_syscall+0x78/0x20c
> >>>>>>     el0_svc_common+0x11c/0x1c0
> >>>>>>     do_el0_svc+0x48/0x58
> >>>>>>     el0_svc+0x54/0x19c
> >>>>>>     el0t_64_sync_handler+0x84/0x12c
> >>>>>>     el0t_64_sync+0x198/0x19c
> >>>>>>
> >>>>>> This happens because no BTI instruction is generated by the JIT fo=
r
> >>>>>> indirect jump targets.
> >>>>>>
> >>>>>> Fix it by emitting BTI instruction for every possible indirect jum=
p
> >>>>>> targets when BTI is enabled. The targets are identified by travers=
ing
> >>>>>> all instruction arrays of jump table type used by the BPF program,
> >>>>>> since indirect jump targets can only be read from instruction arra=
ys
> >>>>>> of jump table type.
> >>>>>
> >>>>> earlier you said:
> >>>>>
> >>>>>> As Anton noted, even though jump tables are currently the only typ=
e
> >>>>>> of instruction array, users may still create insn_arrays that are =
not
> >>>>>> used as jump tables. In such cases, there is no need to emit BTIs.
> >>>>>
> >>>>> yes, but it's not worth it to make this micro optimization in JIT.
> >>>>> If it's in insn_array just emit BTI unconditionally.
> >>>>> No need to do this filtering.
> >>>>>
> >>>>
> >>>> Hmm, that is what the v1 version does. Please take a look. If it=E2=
=80=99s okay,
> >>>> I=E2=80=99ll resend a rebased version.
> >>>>
> >>>> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@hu=
aweicloud.com/
> >>>
> >>> I don't think you need bitmap and bpf_prog_collect_indirect_targets()=
.
> >>> Just look up each insn in the insn_array one at a time.
> >>> It's slower, but array is sorted, so binary search should work.
> >>
> >> No, an insn_array is not always sorted, as its ordering depends on how
> >> it is initialized.
> >>
> >> For example, with the following change to the selftest:
> >>
> >> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> >> @@ -75,7 +75,7 @@ static void check_one_to_one_mapping(void)
> >>                   BPF_MOV64_IMM(BPF_REG_0, 0),
> >>                   BPF_EXIT_INSN(),
> >>           };
> >> -       __u32 map_in[] =3D {0, 1, 2, 3, 4, 5};
> >> +       __u32 map_in[] =3D {0, 3, 1, 2, 4, 5};
> >>           __u32 map_out[] =3D {0, 1, 2, 3, 4, 5};
> >>
> >>           __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
> >>
> >> the selftest will create an unsorted map, as shown below:
> >>
> >> # bpftool m d i 74
> >> key: 00 00 00 00  value: 00 00 00 00 00 00 00 00  24 00 00 00 00 00 00=
 00
> >> key: 01 00 00 00  value: 03 00 00 00 03 00 00 00  30 00 00 00 00 00 00=
 00
> >> key: 02 00 00 00  value: 01 00 00 00 01 00 00 00  28 00 00 00 00 00 00=
 00
> >> key: 03 00 00 00  value: 02 00 00 00 02 00 00 00  2c 00 00 00 00 00 00=
 00
> >> key: 04 00 00 00  value: 04 00 00 00 04 00 00 00  34 00 00 00 00 00 00=
 00
> >> key: 05 00 00 00  value: 05 00 00 00 05 00 00 00  38 00 00 00 00 00 00=
 00
> >> Found 6 elements
> >
> > Yes, it is not always sorted (jump tables aren't guaranteed to be
> > sorted or have unique values).
> >
> > To get rid of bpf_prog_collect_indirect_targets() in internal API,
> > this is possible to just implement this inside arm JIT. If later it is
> > needed in more cases, it can be generalized.
> >
> > Also, how bad is this to generate BTI instructions not only for jump
> > targets (say, for all instructions in the program)? If this is ok-ish
> > (this is a really rare condition now), then `bool is_jump_table` might
> > be dropped for now. (I will add similar code when add static keys and
> > indirect calls such that they aren't counted for BTI.)
> >
>
> IIUC, in practice insn_array usually contains only a few elements, so usi=
ng
> a simple linear search should be sufficient.

I don't see why it cannot be sorted after populating or
if upcoming bpf-static-branch logic needs a certain order and
cannot tolerate sorting-by-kernel we can enforce
sorted order as part of the contract. At insn_array freeze time
the kernel can check whether it's sorted and if not reject the freeze.
I suspect sooner or later we will need efficient search in the insn array.

