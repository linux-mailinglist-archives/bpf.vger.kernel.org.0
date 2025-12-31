Return-Path: <bpf+bounces-77572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 405BBCEB6AC
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 08:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8529A3026B1D
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 07:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A942330F948;
	Wed, 31 Dec 2025 07:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3zxiStL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA4C74C14
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767164778; cv=none; b=c2ygHG9GraCo2HlHCZlC6X6KYI+/zq24SCRCgcmxHSvH7ITdpxM9o5cTY4AEbaDLx4StHnxXTTl9uhPiEkG7IzCBe2sWP/Zy68Q8LmQWVDqKj36uSL2XVc09cXc5Y8gmcGEvGU+K91ydY55EUcwCs2XRTCuP0qWhXb5Rjx9ouEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767164778; c=relaxed/simple;
	bh=Nzqh/bSDsf+P98cZDJtn1+3iz4RFYbft6J4PXkEmDaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGD24g0VPm7f846h7fEAM7ccWXN8IJ80Ig4g4MsNsx9dKv+tAQt0iPo09OTRCXxoRiYcWnENBT1/LsH/WgP74dE2psDWm5tVR0nnzYdHYsTBJ1lJ98dMpVscLm34CrmynjqmMOUPfMBZJtCxOXkjS01vCdohi9g3KdpcFPdppAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3zxiStL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-787da30c50fso94776887b3.3
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 23:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767164775; x=1767769575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmlbrDJRqfQaI/Pr1tJljjdGg0aI4ObOM9s3e9xImJA=;
        b=O3zxiStLcWkGAn80q8rGEpG8/DC/Iz3+Qax3goD7/Zy67bupjRXTC+OmnoShaXamst
         QOlDw7ncgud4XZpZTjFrAE06lVILbJBRB09eDEIrUGfw97soPg2lmcDGf7APm18NeQmS
         SCpPCqRp1d8sc/W9YcrKQp3zu6p549iwfuObpMN958SpCzUTqvk4evCYIUqhpGfr7vW6
         DA1/JVLWz5mhk4TpGF+pc0s0iRT9KXa9yrhjFG65r52Q7hFAJTkycre2C7HowxSvKjMV
         AgGiT6eJGRdFUebR9fHch4B5zgBaq0pHyd7AezYuWr8Y9lH9E/80rW502Rdenw/dDQly
         4yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767164775; x=1767769575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mmlbrDJRqfQaI/Pr1tJljjdGg0aI4ObOM9s3e9xImJA=;
        b=g3BJA9HN447ZEz4JwFzPJOOCw5dG+YZF9ljnIcw2SEyA91e/fu4UEhBgRsEfUjUzce
         a5YgFgAR6OdskK/T3ZWlFqJgCuNmsfhzTvv5YWJFKG/5PqEaER53EDJL4ef0RwXB4czf
         BKT/emUYXWqZIs7riZLI8Uu+OmggXH0NgOWNth1uuqLcZDarp6U8+IrvRSuWc0obET7Z
         37yMu3rjRuQE98QtbQU1bXBNxf86Y3nnV79Nfc0aow03+Xy4Zb2oYC/Qx0vOT0o62sis
         fEFqv7+O8M7GmyBC5tOAHb215YjxHMh2tCJ/fKTeZ/8YAFhaJzPSPNU5Y0DU3GNhXB1W
         WkWw==
X-Forwarded-Encrypted: i=1; AJvYcCUapVp4CK26lNgOmomf6P6JS5vD2u4cHgNfz74f7GR6lii02rduJ0AzO0RzWKiz5blfc4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnqkqb0ZByCuiNxyNDU4xEVXVaYK4Q76LGZMLc/4wYOXiSzOfH
	OHL+EvF/89l5AHd/0Eh2glBGmMRxk5vo6imJXsoWlBM38Kv+IPsogyVctYQ7ej7fCZMRc8FTNkM
	4Y9S9BOnbSN2Y+RFsqZzV8NDUrnBPAkE=
X-Gm-Gg: AY/fxX6l0yNi4DE0+TBA8iZvyRhPvlrunSNoAP5yUAa19qGIXeWP34IOU3Qx1voUluz
	qRFMDTnJz/MIgZcrSHw3bvBcDqjap9tSOCbYIpVRgnWRJFOnrl0tAgX/B1OnCzAho1hP+nFITe5
	D24DM0Ur7B/UdmLauIdkwEikJWOOCmv9ME6aws/5ReK0wLtuqkSKpYXLTA6rm+PUdmrkH4d2i4X
	L/drVzZ2+YA0PT552dvDn70fLEcXuCsESuWAq9lhdo3e9V4tMFCrSdKImXm36+OQe1vy3luJL/I
	1N5WyQU3ldgmE8O6msSDkcUZMcBd/D9cR8jm/VA=
X-Google-Smtp-Source: AGHT+IECdqQeja87jnIC51iwa1MILjHAmYO/YvA6NuRY+koTRCXOCWyD7RPhp872QnnI6fNnZOat9yIVwSD2tE7T57M=
X-Received: by 2002:a05:690c:7091:b0:78f:8afc:c34b with SMTP id
 00721157ae682-78fb403af70mr585123357b3.34.1767164775425; Tue, 30 Dec 2025
 23:06:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227081033.240336-1-xukuohai@huaweicloud.com>
 <CAADnVQKJk7pGW50JHj6tZAeHLxCbgmHBdhwZCY4NT-6MTg7=sQ@mail.gmail.com>
 <0c441710-5250-4706-ba81-b6b4b1277313@huaweicloud.com> <CAADnVQL6PTN2PN9ngV2PSXb=csX1KX+D-BZGzDDNtvQvtGkSkA@mail.gmail.com>
 <50a1889b-eb5b-4a76-9dc9-b55df641170e@huaweicloud.com>
In-Reply-To: <50a1889b-eb5b-4a76-9dc9-b55df641170e@huaweicloud.com>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 31 Dec 2025 08:06:03 +0100
X-Gm-Features: AQt7F2oBaQisxqKAL27SizDqpiztrAOD7aQe8Zdhcwf6Ep7iyMMBbSxjLxmVhcg
Message-ID: <CAGn_itzSC7K_eF7Lbm-im83VObqqoz6rvYMqVAOCXdD0pQ+M6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 7:47=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> On 12/31/2025 10:16 AM, Alexei Starovoitov wrote:
> > On Tue, Dec 30, 2025 at 6:05=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud=
.com> wrote:
> >>
> >> On 12/31/2025 2:20 AM, Alexei Starovoitov wrote:
> >>> On Fri, Dec 26, 2025 at 11:49=E2=80=AFPM Xu Kuohai <xukuohai@huaweicl=
oud.com> wrote:
> >>>>
> >>>> From: Xu Kuohai <xukuohai@huawei.com>
> >>>>
> >>>> When BTI is enabled, the indirect jump selftest triggers BTI excepti=
on:
> >>>>
> >>>> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> >>>> ...
> >>>> Call trace:
> >>>>    bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
> >>>>    bpf_prog_run_pin_on_cpu+0x140/0x464
> >>>>    bpf_prog_test_run_syscall+0x274/0x3ac
> >>>>    bpf_prog_test_run+0x224/0x2b0
> >>>>    __sys_bpf+0x4cc/0x5c8
> >>>>    __arm64_sys_bpf+0x7c/0x94
> >>>>    invoke_syscall+0x78/0x20c
> >>>>    el0_svc_common+0x11c/0x1c0
> >>>>    do_el0_svc+0x48/0x58
> >>>>    el0_svc+0x54/0x19c
> >>>>    el0t_64_sync_handler+0x84/0x12c
> >>>>    el0t_64_sync+0x198/0x19c
> >>>>
> >>>> This happens because no BTI instruction is generated by the JIT for
> >>>> indirect jump targets.
> >>>>
> >>>> Fix it by emitting BTI instruction for every possible indirect jump
> >>>> targets when BTI is enabled. The targets are identified by traversin=
g
> >>>> all instruction arrays of jump table type used by the BPF program,
> >>>> since indirect jump targets can only be read from instruction arrays
> >>>> of jump table type.
> >>>
> >>> earlier you said:
> >>>
> >>>> As Anton noted, even though jump tables are currently the only type
> >>>> of instruction array, users may still create insn_arrays that are no=
t
> >>>> used as jump tables. In such cases, there is no need to emit BTIs.
> >>>
> >>> yes, but it's not worth it to make this micro optimization in JIT.
> >>> If it's in insn_array just emit BTI unconditionally.
> >>> No need to do this filtering.
> >>>
> >>
> >> Hmm, that is what the v1 version does. Please take a look. If it=E2=80=
=99s okay,
> >> I=E2=80=99ll resend a rebased version.
> >>
> >> v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaw=
eicloud.com/
> >
> > I don't think you need bitmap and bpf_prog_collect_indirect_targets().
> > Just look up each insn in the insn_array one at a time.
> > It's slower, but array is sorted, so binary search should work.
>
> No, an insn_array is not always sorted, as its ordering depends on how
> it is initialized.
>
> For example, with the following change to the selftest:
>
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> @@ -75,7 +75,7 @@ static void check_one_to_one_mapping(void)
>                  BPF_MOV64_IMM(BPF_REG_0, 0),
>                  BPF_EXIT_INSN(),
>          };
> -       __u32 map_in[] =3D {0, 1, 2, 3, 4, 5};
> +       __u32 map_in[] =3D {0, 3, 1, 2, 4, 5};
>          __u32 map_out[] =3D {0, 1, 2, 3, 4, 5};
>
>          __check_success(insns, ARRAY_SIZE(insns), map_in, map_out);
>
> the selftest will create an unsorted map, as shown below:
>
> # bpftool m d i 74
> key: 00 00 00 00  value: 00 00 00 00 00 00 00 00  24 00 00 00 00 00 00 00
> key: 01 00 00 00  value: 03 00 00 00 03 00 00 00  30 00 00 00 00 00 00 00
> key: 02 00 00 00  value: 01 00 00 00 01 00 00 00  28 00 00 00 00 00 00 00
> key: 03 00 00 00  value: 02 00 00 00 02 00 00 00  2c 00 00 00 00 00 00 00
> key: 04 00 00 00  value: 04 00 00 00 04 00 00 00  34 00 00 00 00 00 00 00
> key: 05 00 00 00  value: 05 00 00 00 05 00 00 00  38 00 00 00 00 00 00 00
> Found 6 elements

Yes, it is not always sorted (jump tables aren't guaranteed to be
sorted or have unique values).

To get rid of bpf_prog_collect_indirect_targets() in internal API,
this is possible to just implement this inside arm JIT. If later it is
needed in more cases, it can be generalized.

Also, how bad is this to generate BTI instructions not only for jump
targets (say, for all instructions in the program)? If this is ok-ish
(this is a really rare condition now), then `bool is_jump_table` might
be dropped for now. (I will add similar code when add static keys and
indirect calls such that they aren't counted for BTI.)

