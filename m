Return-Path: <bpf+bounces-8491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A9D787524
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 18:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84F61C20EB1
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CFC14AAA;
	Thu, 24 Aug 2023 16:20:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA142100C1;
	Thu, 24 Aug 2023 16:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F3CAC433C7;
	Thu, 24 Aug 2023 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692894028;
	bh=aizNYgKtrqTEedzxsp28ChIYT8WrLItTNVGgzRpawOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QyFLdE8+OIR0cF0ZChjD6QcD3vP3imzYkjumPvHcdFDGbTvpE2SXX172N7XWItln7
	 C1feEAfAFyJU6AMyD8nJkd118D/hlPOmKc9iEwxN8oN7RobzXsA98CBsoM5jEMU78J
	 V3ak4mR12hBJ6rcxIzFN67c+n72yYPlAeG/Cng+dff40gFJscbACDqr7YijTjNLIKU
	 9zJ7qIGZkRaMbqyWhJiQ0VRaLzJ9hjqfJQ6Z4Lk/ewAt8AxS2ubV9osWLOhnsr9TRT
	 Di3lr6ILDKW2NRgP/YPebfBacmDKf6XZGdCKNgNbqNCicH6yFRCggN/P0uIsvsahOQ
	 x9AOBp1bvG5Bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ED1BE21EDF;
	Thu, 24 Aug 2023 16:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/7] Add support cpu v4 insns for RV64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169289402805.11089.2746747452832460498.git-patchwork-notify@kernel.org>
Date: Thu, 24 Aug 2023 16:20:28 +0000
References: <20230824095001.3408573-1-pulehui@huaweicloud.com>
In-Reply-To: <20230824095001.3408573-1-pulehui@huaweicloud.com>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@kernel.org,
 yhs@fb.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 palmer@dabbelt.com, xukuohai@huawei.com, puranjay12@gmail.com,
 pulehui@huawei.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Aug 2023 09:49:54 +0000 you wrote:
> Add support cpu v4 instructions for RV64. The relevant tests have passed as show bellow:
> 
> # ./test_progs-cpuv4 -a ldsx_insn,verifier_sdiv,verifier_movsx,verifier_ldsx,verifier_gotol,verifier_bswap
> #116/1   ldsx_insn/map_val and probed_memory:OK
> #116/2   ldsx_insn/ctx_member_sign_ext:OK
> #116/3   ldsx_insn/ctx_member_narrow_sign_ext:OK
> #116     ldsx_insn:OK
> #309/1   verifier_bswap/BSWAP, 16:OK
> #309/2   verifier_bswap/BSWAP, 16 @unpriv:OK
> #309/3   verifier_bswap/BSWAP, 32:OK
> #309/4   verifier_bswap/BSWAP, 32 @unpriv:OK
> #309/5   verifier_bswap/BSWAP, 64:OK
> #309/6   verifier_bswap/BSWAP, 64 @unpriv:OK
> #309     verifier_bswap:OK
> #323/1   verifier_gotol/gotol, small_imm:OK
> #323/2   verifier_gotol/gotol, small_imm @unpriv:OK
> #323     verifier_gotol:OK
> #331/1   verifier_ldsx/LDSX, S8:OK
> #331/2   verifier_ldsx/LDSX, S8 @unpriv:OK
> #331/3   verifier_ldsx/LDSX, S16:OK
> #331/4   verifier_ldsx/LDSX, S16 @unpriv:OK
> #331/5   verifier_ldsx/LDSX, S32:OK
> #331/6   verifier_ldsx/LDSX, S32 @unpriv:OK
> #331/7   verifier_ldsx/LDSX, S8 range checking, privileged:OK
> #331/8   verifier_ldsx/LDSX, S16 range checking:OK
> #331/9   verifier_ldsx/LDSX, S16 range checking @unpriv:OK
> #331/10  verifier_ldsx/LDSX, S32 range checking:OK
> #331/11  verifier_ldsx/LDSX, S32 range checking @unpriv:OK
> #331     verifier_ldsx:OK
> #342/1   verifier_movsx/MOV32SX, S8:OK
> #342/2   verifier_movsx/MOV32SX, S8 @unpriv:OK
> #342/3   verifier_movsx/MOV32SX, S16:OK
> #342/4   verifier_movsx/MOV32SX, S16 @unpriv:OK
> #342/5   verifier_movsx/MOV64SX, S8:OK
> #342/6   verifier_movsx/MOV64SX, S8 @unpriv:OK
> #342/7   verifier_movsx/MOV64SX, S16:OK
> #342/8   verifier_movsx/MOV64SX, S16 @unpriv:OK
> #342/9   verifier_movsx/MOV64SX, S32:OK
> #342/10  verifier_movsx/MOV64SX, S32 @unpriv:OK
> #342/11  verifier_movsx/MOV32SX, S8, range_check:OK
> #342/12  verifier_movsx/MOV32SX, S8, range_check @unpriv:OK
> #342/13  verifier_movsx/MOV32SX, S16, range_check:OK
> #342/14  verifier_movsx/MOV32SX, S16, range_check @unpriv:OK
> #342/15  verifier_movsx/MOV32SX, S16, range_check 2:OK
> #342/16  verifier_movsx/MOV32SX, S16, range_check 2 @unpriv:OK
> #342/17  verifier_movsx/MOV64SX, S8, range_check:OK
> #342/18  verifier_movsx/MOV64SX, S8, range_check @unpriv:OK
> #342/19  verifier_movsx/MOV64SX, S16, range_check:OK
> #342/20  verifier_movsx/MOV64SX, S16, range_check @unpriv:OK
> #342/21  verifier_movsx/MOV64SX, S32, range_check:OK
> #342/22  verifier_movsx/MOV64SX, S32, range_check @unpriv:OK
> #342/23  verifier_movsx/MOV64SX, S16, R10 Sign Extension:OK
> #342/24  verifier_movsx/MOV64SX, S16, R10 Sign Extension @unpriv:OK
> #342     verifier_movsx:OK
> #354/1   verifier_sdiv/SDIV32, non-zero imm divisor, check 1:OK
> #354/2   verifier_sdiv/SDIV32, non-zero imm divisor, check 1 @unpriv:OK
> #354/3   verifier_sdiv/SDIV32, non-zero imm divisor, check 2:OK
> #354/4   verifier_sdiv/SDIV32, non-zero imm divisor, check 2 @unpriv:OK
> #354/5   verifier_sdiv/SDIV32, non-zero imm divisor, check 3:OK
> #354/6   verifier_sdiv/SDIV32, non-zero imm divisor, check 3 @unpriv:OK
> #354/7   verifier_sdiv/SDIV32, non-zero imm divisor, check 4:OK
> #354/8   verifier_sdiv/SDIV32, non-zero imm divisor, check 4 @unpriv:OK
> #354/9   verifier_sdiv/SDIV32, non-zero imm divisor, check 5:OK
> #354/10  verifier_sdiv/SDIV32, non-zero imm divisor, check 5 @unpriv:OK
> #354/11  verifier_sdiv/SDIV32, non-zero imm divisor, check 6:OK
> #354/12  verifier_sdiv/SDIV32, non-zero imm divisor, check 6 @unpriv:OK
> #354/13  verifier_sdiv/SDIV32, non-zero imm divisor, check 7:OK
> #354/14  verifier_sdiv/SDIV32, non-zero imm divisor, check 7 @unpriv:OK
> #354/15  verifier_sdiv/SDIV32, non-zero imm divisor, check 8:OK
> #354/16  verifier_sdiv/SDIV32, non-zero imm divisor, check 8 @unpriv:OK
> #354/17  verifier_sdiv/SDIV32, non-zero reg divisor, check 1:OK
> #354/18  verifier_sdiv/SDIV32, non-zero reg divisor, check 1 @unpriv:OK
> #354/19  verifier_sdiv/SDIV32, non-zero reg divisor, check 2:OK
> #354/20  verifier_sdiv/SDIV32, non-zero reg divisor, check 2 @unpriv:OK
> #354/21  verifier_sdiv/SDIV32, non-zero reg divisor, check 3:OK
> #354/22  verifier_sdiv/SDIV32, non-zero reg divisor, check 3 @unpriv:OK
> #354/23  verifier_sdiv/SDIV32, non-zero reg divisor, check 4:OK
> #354/24  verifier_sdiv/SDIV32, non-zero reg divisor, check 4 @unpriv:OK
> #354/25  verifier_sdiv/SDIV32, non-zero reg divisor, check 5:OK
> #354/26  verifier_sdiv/SDIV32, non-zero reg divisor, check 5 @unpriv:OK
> #354/27  verifier_sdiv/SDIV32, non-zero reg divisor, check 6:OK
> #354/28  verifier_sdiv/SDIV32, non-zero reg divisor, check 6 @unpriv:OK
> #354/29  verifier_sdiv/SDIV32, non-zero reg divisor, check 7:OK
> #354/30  verifier_sdiv/SDIV32, non-zero reg divisor, check 7 @unpriv:OK
> #354/31  verifier_sdiv/SDIV32, non-zero reg divisor, check 8:OK
> #354/32  verifier_sdiv/SDIV32, non-zero reg divisor, check 8 @unpriv:OK
> #354/33  verifier_sdiv/SDIV64, non-zero imm divisor, check 1:OK
> #354/34  verifier_sdiv/SDIV64, non-zero imm divisor, check 1 @unpriv:OK
> #354/35  verifier_sdiv/SDIV64, non-zero imm divisor, check 2:OK
> #354/36  verifier_sdiv/SDIV64, non-zero imm divisor, check 2 @unpriv:OK
> #354/37  verifier_sdiv/SDIV64, non-zero imm divisor, check 3:OK
> #354/38  verifier_sdiv/SDIV64, non-zero imm divisor, check 3 @unpriv:OK
> #354/39  verifier_sdiv/SDIV64, non-zero imm divisor, check 4:OK
> #354/40  verifier_sdiv/SDIV64, non-zero imm divisor, check 4 @unpriv:OK
> #354/41  verifier_sdiv/SDIV64, non-zero imm divisor, check 5:OK
> #354/42  verifier_sdiv/SDIV64, non-zero imm divisor, check 5 @unpriv:OK
> #354/43  verifier_sdiv/SDIV64, non-zero imm divisor, check 6:OK
> #354/44  verifier_sdiv/SDIV64, non-zero imm divisor, check 6 @unpriv:OK
> #354/45  verifier_sdiv/SDIV64, non-zero reg divisor, check 1:OK
> #354/46  verifier_sdiv/SDIV64, non-zero reg divisor, check 1 @unpriv:OK
> #354/47  verifier_sdiv/SDIV64, non-zero reg divisor, check 2:OK
> #354/48  verifier_sdiv/SDIV64, non-zero reg divisor, check 2 @unpriv:OK
> #354/49  verifier_sdiv/SDIV64, non-zero reg divisor, check 3:OK
> #354/50  verifier_sdiv/SDIV64, non-zero reg divisor, check 3 @unpriv:OK
> #354/51  verifier_sdiv/SDIV64, non-zero reg divisor, check 4:OK
> #354/52  verifier_sdiv/SDIV64, non-zero reg divisor, check 4 @unpriv:OK
> #354/53  verifier_sdiv/SDIV64, non-zero reg divisor, check 5:OK
> #354/54  verifier_sdiv/SDIV64, non-zero reg divisor, check 5 @unpriv:OK
> #354/55  verifier_sdiv/SDIV64, non-zero reg divisor, check 6:OK
> #354/56  verifier_sdiv/SDIV64, non-zero reg divisor, check 6 @unpriv:OK
> #354/57  verifier_sdiv/SMOD32, non-zero imm divisor, check 1:OK
> #354/58  verifier_sdiv/SMOD32, non-zero imm divisor, check 1 @unpriv:OK
> #354/59  verifier_sdiv/SMOD32, non-zero imm divisor, check 2:OK
> #354/60  verifier_sdiv/SMOD32, non-zero imm divisor, check 2 @unpriv:OK
> #354/61  verifier_sdiv/SMOD32, non-zero imm divisor, check 3:OK
> #354/62  verifier_sdiv/SMOD32, non-zero imm divisor, check 3 @unpriv:OK
> #354/63  verifier_sdiv/SMOD32, non-zero imm divisor, check 4:OK
> #354/64  verifier_sdiv/SMOD32, non-zero imm divisor, check 4 @unpriv:OK
> #354/65  verifier_sdiv/SMOD32, non-zero imm divisor, check 5:OK
> #354/66  verifier_sdiv/SMOD32, non-zero imm divisor, check 5 @unpriv:OK
> #354/67  verifier_sdiv/SMOD32, non-zero imm divisor, check 6:OK
> #354/68  verifier_sdiv/SMOD32, non-zero imm divisor, check 6 @unpriv:OK
> #354/69  verifier_sdiv/SMOD32, non-zero reg divisor, check 1:OK
> #354/70  verifier_sdiv/SMOD32, non-zero reg divisor, check 1 @unpriv:OK
> #354/71  verifier_sdiv/SMOD32, non-zero reg divisor, check 2:OK
> #354/72  verifier_sdiv/SMOD32, non-zero reg divisor, check 2 @unpriv:OK
> #354/73  verifier_sdiv/SMOD32, non-zero reg divisor, check 3:OK
> #354/74  verifier_sdiv/SMOD32, non-zero reg divisor, check 3 @unpriv:OK
> #354/75  verifier_sdiv/SMOD32, non-zero reg divisor, check 4:OK
> #354/76  verifier_sdiv/SMOD32, non-zero reg divisor, check 4 @unpriv:OK
> #354/77  verifier_sdiv/SMOD32, non-zero reg divisor, check 5:OK
> #354/78  verifier_sdiv/SMOD32, non-zero reg divisor, check 5 @unpriv:OK
> #354/79  verifier_sdiv/SMOD32, non-zero reg divisor, check 6:OK
> #354/80  verifier_sdiv/SMOD32, non-zero reg divisor, check 6 @unpriv:OK
> #354/81  verifier_sdiv/SMOD64, non-zero imm divisor, check 1:OK
> #354/82  verifier_sdiv/SMOD64, non-zero imm divisor, check 1 @unpriv:OK
> #354/83  verifier_sdiv/SMOD64, non-zero imm divisor, check 2:OK
> #354/84  verifier_sdiv/SMOD64, non-zero imm divisor, check 2 @unpriv:OK
> #354/85  verifier_sdiv/SMOD64, non-zero imm divisor, check 3:OK
> #354/86  verifier_sdiv/SMOD64, non-zero imm divisor, check 3 @unpriv:OK
> #354/87  verifier_sdiv/SMOD64, non-zero imm divisor, check 4:OK
> #354/88  verifier_sdiv/SMOD64, non-zero imm divisor, check 4 @unpriv:OK
> #354/89  verifier_sdiv/SMOD64, non-zero imm divisor, check 5:OK
> #354/90  verifier_sdiv/SMOD64, non-zero imm divisor, check 5 @unpriv:OK
> #354/91  verifier_sdiv/SMOD64, non-zero imm divisor, check 6:OK
> #354/92  verifier_sdiv/SMOD64, non-zero imm divisor, check 6 @unpriv:OK
> #354/93  verifier_sdiv/SMOD64, non-zero imm divisor, check 7:OK
> #354/94  verifier_sdiv/SMOD64, non-zero imm divisor, check 7 @unpriv:OK
> #354/95  verifier_sdiv/SMOD64, non-zero imm divisor, check 8:OK
> #354/96  verifier_sdiv/SMOD64, non-zero imm divisor, check 8 @unpriv:OK
> #354/97  verifier_sdiv/SMOD64, non-zero reg divisor, check 1:OK
> #354/98  verifier_sdiv/SMOD64, non-zero reg divisor, check 1 @unpriv:OK
> #354/99  verifier_sdiv/SMOD64, non-zero reg divisor, check 2:OK
> #354/100 verifier_sdiv/SMOD64, non-zero reg divisor, check 2 @unpriv:OK
> #354/101 verifier_sdiv/SMOD64, non-zero reg divisor, check 3:OK
> #354/102 verifier_sdiv/SMOD64, non-zero reg divisor, check 3 @unpriv:OK
> #354/103 verifier_sdiv/SMOD64, non-zero reg divisor, check 4:OK
> #354/104 verifier_sdiv/SMOD64, non-zero reg divisor, check 4 @unpriv:OK
> #354/105 verifier_sdiv/SMOD64, non-zero reg divisor, check 5:OK
> #354/106 verifier_sdiv/SMOD64, non-zero reg divisor, check 5 @unpriv:OK
> #354/107 verifier_sdiv/SMOD64, non-zero reg divisor, check 6:OK
> #354/108 verifier_sdiv/SMOD64, non-zero reg divisor, check 6 @unpriv:OK
> #354/109 verifier_sdiv/SMOD64, non-zero reg divisor, check 7:OK
> #354/110 verifier_sdiv/SMOD64, non-zero reg divisor, check 7 @unpriv:OK
> #354/111 verifier_sdiv/SMOD64, non-zero reg divisor, check 8:OK
> #354/112 verifier_sdiv/SMOD64, non-zero reg divisor, check 8 @unpriv:OK
> #354/113 verifier_sdiv/SDIV32, zero divisor:OK
> #354/114 verifier_sdiv/SDIV32, zero divisor @unpriv:OK
> #354/115 verifier_sdiv/SDIV64, zero divisor:OK
> #354/116 verifier_sdiv/SDIV64, zero divisor @unpriv:OK
> #354/117 verifier_sdiv/SMOD32, zero divisor:OK
> #354/118 verifier_sdiv/SMOD32, zero divisor @unpriv:OK
> #354/119 verifier_sdiv/SMOD64, zero divisor:OK
> #354/120 verifier_sdiv/SMOD64, zero divisor @unpriv:OK
> #354     verifier_sdiv:OK
> Summary: 6/166 PASSED, 0 SKIPPED, 0 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/7] riscv, bpf: Fix missing exception handling and redundant zext for LDX_B/H/W
    https://git.kernel.org/bpf/bpf-next/c/469fb2c3c1bb
  - [bpf-next,v2,2/7] riscv, bpf: Support sign-extension load insns
    https://git.kernel.org/bpf/bpf-next/c/3d06d8163f98
  - [bpf-next,v2,3/7] riscv, bpf: Support sign-extension mov insns
    https://git.kernel.org/bpf/bpf-next/c/694896ad3ca7
  - [bpf-next,v2,4/7] riscv, bpf: Support 32-bit offset jmp insn
    https://git.kernel.org/bpf/bpf-next/c/d9839f16c150
  - [bpf-next,v2,5/7] riscv, bpf: Support signed div/mod insns
    https://git.kernel.org/bpf/bpf-next/c/3e18ff4bce9b
  - [bpf-next,v2,6/7] riscv, bpf: Support unconditional bswap insn
    https://git.kernel.org/bpf/bpf-next/c/83cc63afab71
  - [bpf-next,v2,7/7] selftests/bpf: Enable cpu v4 tests for RV64
    https://git.kernel.org/bpf/bpf-next/c/0209fd511fa4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



