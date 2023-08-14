Return-Path: <bpf+bounces-7710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF477B8B0
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 14:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 599D61C20B28
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 12:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402FAD53;
	Mon, 14 Aug 2023 12:34:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D85DA923
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 12:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A5AC433C8;
	Mon, 14 Aug 2023 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692016447;
	bh=t71erLmdjDETQFMozOa5QiuBONUPlCTO6eXNRPYpsaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pJ3RlT5N10HvSfKcd/fgnkpycLpBYhyLanjgHlWoH8pNrUcTNHEDLKexj1+G6810c
	 djt2PQGj+NHmGBig8UMSPsqfsKk4WDWJDGfcAry8Vxrr0AFf0j9/zQtgmnTtkuUHmf
	 Lllm0o0Zp3P0/811gPu9W4XCpyiPB043JF9xEqT2SQK/frqVhcfeKMleDiLGcLF03N
	 It1tFoKOk4gsTVFTkJ9jIIdozSFmArNSDDPPpU+rwRRrxjcrVWf8WeSwxw1o2WGp5T
	 7MYh1YwqT9LHD1WUR2dfG7CNOJl+nwE4HGutVSMDqAX7enITVGi0MNtk51Y+hWJ/wD
	 C12gwixr6U3Pw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Luke Nelson <lukenels@cs.washington.edu>, bpf@vger.kernel.org
Cc: Luke Nelson <luke.r.nels@gmail.com>, kernel test robot <lkp@intel.com>,
 Xi Wang <xi.wang@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] riscv/bpf: Fix truncated immediate warning in
 rv_s_insn
In-Reply-To: <20230727024931.17156-1-luke.r.nels@gmail.com>
References: <20230727024931.17156-1-luke.r.nels@gmail.com>
Date: Mon, 14 Aug 2023 14:34:04 +0200
Message-ID: <87edk5g5vn.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Luke Nelson <lukenels@cs.washington.edu> writes:

> Sparse warns that a cast in rv_s_insn truncates bits from the constant
> 0x7ff to 0xff.  The warning originates from the use of a constant offset
> of -8 in a store instruction in bpf_jit_comp64.c:
>
>   emit(rv_sd(RV_REG_SP, -8, RV_REG_RA), &ctx);
>
> rv_sd then calls rv_s_insn, with imm11_0 equal to (u16)(-8), or 0xfff8.
>
> Here's the current implementation of rv_s_insn:
>
>   static inline u32 rv_s_insn(u16 imm11_0, u8 rs2, u8 rs1, u8 funct3, u8 =
opcode)
>   {
>           u8 imm11_5 =3D imm11_0 >> 5, imm4_0 =3D imm11_0 & 0x1f;
>
>           return (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 <<=
 12) |
>                  (imm4_0 << 7) | opcode;
>   }
>
> imm11_0 is a signed 12-bit immediate offset of the store instruction. The
> instruction encoding requires splitting the immediate into bits 11:5 and
> bits 4:0. In this case, imm11_0 >> 5 =3D 0x7ff, which then gets truncated
> to 0xff when cast to u8, causing the warning from sparse. However, this is
> not actually an issue because the immediate offset is signed---truncating
> upper bits that are all set to 1 has no effect on the value of the
> immediate.
>
> There is another subtle quirk with this code, which is imm11_5 is
> supposed to be the upper 7 bits of the 12-bit signed immediate, but its
> type is u8 with no explicit mask to select out only the bottom 7 bits.
> This happens to be okay here because imm11_5 is the left-most field in
> the instruction and the "extra" bit will be shifted out when imm11_5 is
> shifted left by 25.
>
> This commit fixes the warning by changing the type of imm11_5 and imm4_0
> to be u32 instead of u8, and adding an explicit mask to compute imm11_5
> instead of relying on truncation + shifting.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307260704.dUElCrWU-lkp@i=
ntel.com/
> In-Reply-To: <202307260704.dUElCrWU-lkp@intel.com>
> Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
> Cc: Xi Wang <xi.wang@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>


Thanks, Luke!

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

