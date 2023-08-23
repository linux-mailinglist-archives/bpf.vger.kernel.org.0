Return-Path: <bpf+bounces-8373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52656785B89
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CE91C20C9F
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 15:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C641DD525;
	Wed, 23 Aug 2023 15:07:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83BFCA62;
	Wed, 23 Aug 2023 15:07:00 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC902E71;
	Wed, 23 Aug 2023 08:06:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RW8gr4QTWz4f3kq5;
	Wed, 23 Aug 2023 23:06:48 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgAn_qCIIOZksUWeBQ--.39856S2;
	Wed, 23 Aug 2023 23:06:48 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: linux-riscv@lists.infradead.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 0/7] Add support cpu v4 insns for RV64
Date: Wed, 23 Aug 2023 23:10:52 +0000
Message-Id: <20230823231059.3363698-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAn_qCIIOZksUWeBQ--.39856S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tryfJF1DZr48JrWxtFWxtFb_yoW8JryUCo
	WYq39FkF9IyF47tanrZ3WSyF43tF98ur4kGry7KFyrAr48ZrnrKw1rur4xuF9rZwsIqr9r
	Xay2yFyDJrykXayxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYK7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl8cAvFVAK0I
	I2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0
	Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84
	ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8C
	rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxV
	WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS
	5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l
	IxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNXo2DUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support cpu v4 instructions for RV64. The relevant tests have passed as show bellow:

# ./test_progs-cpuv4 -a ldsx_insn,verifier_sdiv,verifier_movsx,verifier_ldsx,verifier_gotol,verifier_bswap
#116/1   ldsx_insn/map_val and probed_memory:OK
#116/2   ldsx_insn/ctx_member_sign_ext:OK
#116/3   ldsx_insn/ctx_member_narrow_sign_ext:OK
#116     ldsx_insn:OK
#309/1   verifier_bswap/BSWAP, 16:OK
#309/2   verifier_bswap/BSWAP, 16 @unpriv:OK
#309/3   verifier_bswap/BSWAP, 32:OK
#309/4   verifier_bswap/BSWAP, 32 @unpriv:OK
#309/5   verifier_bswap/BSWAP, 64:OK
#309/6   verifier_bswap/BSWAP, 64 @unpriv:OK
#309     verifier_bswap:OK
#323/1   verifier_gotol/gotol, small_imm:OK
#323/2   verifier_gotol/gotol, small_imm @unpriv:OK
#323     verifier_gotol:OK
#331/1   verifier_ldsx/LDSX, S8:OK
#331/2   verifier_ldsx/LDSX, S8 @unpriv:OK
#331/3   verifier_ldsx/LDSX, S16:OK
#331/4   verifier_ldsx/LDSX, S16 @unpriv:OK
#331/5   verifier_ldsx/LDSX, S32:OK
#331/6   verifier_ldsx/LDSX, S32 @unpriv:OK
#331/7   verifier_ldsx/LDSX, S8 range checking, privileged:OK
#331/8   verifier_ldsx/LDSX, S16 range checking:OK
#331/9   verifier_ldsx/LDSX, S16 range checking @unpriv:OK
#331/10  verifier_ldsx/LDSX, S32 range checking:OK
#331/11  verifier_ldsx/LDSX, S32 range checking @unpriv:OK
#331     verifier_ldsx:OK
#342/1   verifier_movsx/MOV32SX, S8:OK
#342/2   verifier_movsx/MOV32SX, S8 @unpriv:OK
#342/3   verifier_movsx/MOV32SX, S16:OK
#342/4   verifier_movsx/MOV32SX, S16 @unpriv:OK
#342/5   verifier_movsx/MOV64SX, S8:OK
#342/6   verifier_movsx/MOV64SX, S8 @unpriv:OK
#342/7   verifier_movsx/MOV64SX, S16:OK
#342/8   verifier_movsx/MOV64SX, S16 @unpriv:OK
#342/9   verifier_movsx/MOV64SX, S32:OK
#342/10  verifier_movsx/MOV64SX, S32 @unpriv:OK
#342/11  verifier_movsx/MOV32SX, S8, range_check:OK
#342/12  verifier_movsx/MOV32SX, S8, range_check @unpriv:OK
#342/13  verifier_movsx/MOV32SX, S16, range_check:OK
#342/14  verifier_movsx/MOV32SX, S16, range_check @unpriv:OK
#342/15  verifier_movsx/MOV32SX, S16, range_check 2:OK
#342/16  verifier_movsx/MOV32SX, S16, range_check 2 @unpriv:OK
#342/17  verifier_movsx/MOV64SX, S8, range_check:OK
#342/18  verifier_movsx/MOV64SX, S8, range_check @unpriv:OK
#342/19  verifier_movsx/MOV64SX, S16, range_check:OK
#342/20  verifier_movsx/MOV64SX, S16, range_check @unpriv:OK
#342/21  verifier_movsx/MOV64SX, S32, range_check:OK
#342/22  verifier_movsx/MOV64SX, S32, range_check @unpriv:OK
#342/23  verifier_movsx/MOV64SX, S16, R10 Sign Extension:OK
#342/24  verifier_movsx/MOV64SX, S16, R10 Sign Extension @unpriv:OK
#342     verifier_movsx:OK
#354/1   verifier_sdiv/SDIV32, non-zero imm divisor, check 1:OK
#354/2   verifier_sdiv/SDIV32, non-zero imm divisor, check 1 @unpriv:OK
#354/3   verifier_sdiv/SDIV32, non-zero imm divisor, check 2:OK
#354/4   verifier_sdiv/SDIV32, non-zero imm divisor, check 2 @unpriv:OK
#354/5   verifier_sdiv/SDIV32, non-zero imm divisor, check 3:OK
#354/6   verifier_sdiv/SDIV32, non-zero imm divisor, check 3 @unpriv:OK
#354/7   verifier_sdiv/SDIV32, non-zero imm divisor, check 4:OK
#354/8   verifier_sdiv/SDIV32, non-zero imm divisor, check 4 @unpriv:OK
#354/9   verifier_sdiv/SDIV32, non-zero imm divisor, check 5:OK
#354/10  verifier_sdiv/SDIV32, non-zero imm divisor, check 5 @unpriv:OK
#354/11  verifier_sdiv/SDIV32, non-zero imm divisor, check 6:OK
#354/12  verifier_sdiv/SDIV32, non-zero imm divisor, check 6 @unpriv:OK
#354/13  verifier_sdiv/SDIV32, non-zero imm divisor, check 7:OK
#354/14  verifier_sdiv/SDIV32, non-zero imm divisor, check 7 @unpriv:OK
#354/15  verifier_sdiv/SDIV32, non-zero imm divisor, check 8:OK
#354/16  verifier_sdiv/SDIV32, non-zero imm divisor, check 8 @unpriv:OK
#354/17  verifier_sdiv/SDIV32, non-zero reg divisor, check 1:OK
#354/18  verifier_sdiv/SDIV32, non-zero reg divisor, check 1 @unpriv:OK
#354/19  verifier_sdiv/SDIV32, non-zero reg divisor, check 2:OK
#354/20  verifier_sdiv/SDIV32, non-zero reg divisor, check 2 @unpriv:OK
#354/21  verifier_sdiv/SDIV32, non-zero reg divisor, check 3:OK
#354/22  verifier_sdiv/SDIV32, non-zero reg divisor, check 3 @unpriv:OK
#354/23  verifier_sdiv/SDIV32, non-zero reg divisor, check 4:OK
#354/24  verifier_sdiv/SDIV32, non-zero reg divisor, check 4 @unpriv:OK
#354/25  verifier_sdiv/SDIV32, non-zero reg divisor, check 5:OK
#354/26  verifier_sdiv/SDIV32, non-zero reg divisor, check 5 @unpriv:OK
#354/27  verifier_sdiv/SDIV32, non-zero reg divisor, check 6:OK
#354/28  verifier_sdiv/SDIV32, non-zero reg divisor, check 6 @unpriv:OK
#354/29  verifier_sdiv/SDIV32, non-zero reg divisor, check 7:OK
#354/30  verifier_sdiv/SDIV32, non-zero reg divisor, check 7 @unpriv:OK
#354/31  verifier_sdiv/SDIV32, non-zero reg divisor, check 8:OK
#354/32  verifier_sdiv/SDIV32, non-zero reg divisor, check 8 @unpriv:OK
#354/33  verifier_sdiv/SDIV64, non-zero imm divisor, check 1:OK
#354/34  verifier_sdiv/SDIV64, non-zero imm divisor, check 1 @unpriv:OK
#354/35  verifier_sdiv/SDIV64, non-zero imm divisor, check 2:OK
#354/36  verifier_sdiv/SDIV64, non-zero imm divisor, check 2 @unpriv:OK
#354/37  verifier_sdiv/SDIV64, non-zero imm divisor, check 3:OK
#354/38  verifier_sdiv/SDIV64, non-zero imm divisor, check 3 @unpriv:OK
#354/39  verifier_sdiv/SDIV64, non-zero imm divisor, check 4:OK
#354/40  verifier_sdiv/SDIV64, non-zero imm divisor, check 4 @unpriv:OK
#354/41  verifier_sdiv/SDIV64, non-zero imm divisor, check 5:OK
#354/42  verifier_sdiv/SDIV64, non-zero imm divisor, check 5 @unpriv:OK
#354/43  verifier_sdiv/SDIV64, non-zero imm divisor, check 6:OK
#354/44  verifier_sdiv/SDIV64, non-zero imm divisor, check 6 @unpriv:OK
#354/45  verifier_sdiv/SDIV64, non-zero reg divisor, check 1:OK
#354/46  verifier_sdiv/SDIV64, non-zero reg divisor, check 1 @unpriv:OK
#354/47  verifier_sdiv/SDIV64, non-zero reg divisor, check 2:OK
#354/48  verifier_sdiv/SDIV64, non-zero reg divisor, check 2 @unpriv:OK
#354/49  verifier_sdiv/SDIV64, non-zero reg divisor, check 3:OK
#354/50  verifier_sdiv/SDIV64, non-zero reg divisor, check 3 @unpriv:OK
#354/51  verifier_sdiv/SDIV64, non-zero reg divisor, check 4:OK
#354/52  verifier_sdiv/SDIV64, non-zero reg divisor, check 4 @unpriv:OK
#354/53  verifier_sdiv/SDIV64, non-zero reg divisor, check 5:OK
#354/54  verifier_sdiv/SDIV64, non-zero reg divisor, check 5 @unpriv:OK
#354/55  verifier_sdiv/SDIV64, non-zero reg divisor, check 6:OK
#354/56  verifier_sdiv/SDIV64, non-zero reg divisor, check 6 @unpriv:OK
#354/57  verifier_sdiv/SMOD32, non-zero imm divisor, check 1:OK
#354/58  verifier_sdiv/SMOD32, non-zero imm divisor, check 1 @unpriv:OK
#354/59  verifier_sdiv/SMOD32, non-zero imm divisor, check 2:OK
#354/60  verifier_sdiv/SMOD32, non-zero imm divisor, check 2 @unpriv:OK
#354/61  verifier_sdiv/SMOD32, non-zero imm divisor, check 3:OK
#354/62  verifier_sdiv/SMOD32, non-zero imm divisor, check 3 @unpriv:OK
#354/63  verifier_sdiv/SMOD32, non-zero imm divisor, check 4:OK
#354/64  verifier_sdiv/SMOD32, non-zero imm divisor, check 4 @unpriv:OK
#354/65  verifier_sdiv/SMOD32, non-zero imm divisor, check 5:OK
#354/66  verifier_sdiv/SMOD32, non-zero imm divisor, check 5 @unpriv:OK
#354/67  verifier_sdiv/SMOD32, non-zero imm divisor, check 6:OK
#354/68  verifier_sdiv/SMOD32, non-zero imm divisor, check 6 @unpriv:OK
#354/69  verifier_sdiv/SMOD32, non-zero reg divisor, check 1:OK
#354/70  verifier_sdiv/SMOD32, non-zero reg divisor, check 1 @unpriv:OK
#354/71  verifier_sdiv/SMOD32, non-zero reg divisor, check 2:OK
#354/72  verifier_sdiv/SMOD32, non-zero reg divisor, check 2 @unpriv:OK
#354/73  verifier_sdiv/SMOD32, non-zero reg divisor, check 3:OK
#354/74  verifier_sdiv/SMOD32, non-zero reg divisor, check 3 @unpriv:OK
#354/75  verifier_sdiv/SMOD32, non-zero reg divisor, check 4:OK
#354/76  verifier_sdiv/SMOD32, non-zero reg divisor, check 4 @unpriv:OK
#354/77  verifier_sdiv/SMOD32, non-zero reg divisor, check 5:OK
#354/78  verifier_sdiv/SMOD32, non-zero reg divisor, check 5 @unpriv:OK
#354/79  verifier_sdiv/SMOD32, non-zero reg divisor, check 6:OK
#354/80  verifier_sdiv/SMOD32, non-zero reg divisor, check 6 @unpriv:OK
#354/81  verifier_sdiv/SMOD64, non-zero imm divisor, check 1:OK
#354/82  verifier_sdiv/SMOD64, non-zero imm divisor, check 1 @unpriv:OK
#354/83  verifier_sdiv/SMOD64, non-zero imm divisor, check 2:OK
#354/84  verifier_sdiv/SMOD64, non-zero imm divisor, check 2 @unpriv:OK
#354/85  verifier_sdiv/SMOD64, non-zero imm divisor, check 3:OK
#354/86  verifier_sdiv/SMOD64, non-zero imm divisor, check 3 @unpriv:OK
#354/87  verifier_sdiv/SMOD64, non-zero imm divisor, check 4:OK
#354/88  verifier_sdiv/SMOD64, non-zero imm divisor, check 4 @unpriv:OK
#354/89  verifier_sdiv/SMOD64, non-zero imm divisor, check 5:OK
#354/90  verifier_sdiv/SMOD64, non-zero imm divisor, check 5 @unpriv:OK
#354/91  verifier_sdiv/SMOD64, non-zero imm divisor, check 6:OK
#354/92  verifier_sdiv/SMOD64, non-zero imm divisor, check 6 @unpriv:OK
#354/93  verifier_sdiv/SMOD64, non-zero imm divisor, check 7:OK
#354/94  verifier_sdiv/SMOD64, non-zero imm divisor, check 7 @unpriv:OK
#354/95  verifier_sdiv/SMOD64, non-zero imm divisor, check 8:OK
#354/96  verifier_sdiv/SMOD64, non-zero imm divisor, check 8 @unpriv:OK
#354/97  verifier_sdiv/SMOD64, non-zero reg divisor, check 1:OK
#354/98  verifier_sdiv/SMOD64, non-zero reg divisor, check 1 @unpriv:OK
#354/99  verifier_sdiv/SMOD64, non-zero reg divisor, check 2:OK
#354/100 verifier_sdiv/SMOD64, non-zero reg divisor, check 2 @unpriv:OK
#354/101 verifier_sdiv/SMOD64, non-zero reg divisor, check 3:OK
#354/102 verifier_sdiv/SMOD64, non-zero reg divisor, check 3 @unpriv:OK
#354/103 verifier_sdiv/SMOD64, non-zero reg divisor, check 4:OK
#354/104 verifier_sdiv/SMOD64, non-zero reg divisor, check 4 @unpriv:OK
#354/105 verifier_sdiv/SMOD64, non-zero reg divisor, check 5:OK
#354/106 verifier_sdiv/SMOD64, non-zero reg divisor, check 5 @unpriv:OK
#354/107 verifier_sdiv/SMOD64, non-zero reg divisor, check 6:OK
#354/108 verifier_sdiv/SMOD64, non-zero reg divisor, check 6 @unpriv:OK
#354/109 verifier_sdiv/SMOD64, non-zero reg divisor, check 7:OK
#354/110 verifier_sdiv/SMOD64, non-zero reg divisor, check 7 @unpriv:OK
#354/111 verifier_sdiv/SMOD64, non-zero reg divisor, check 8:OK
#354/112 verifier_sdiv/SMOD64, non-zero reg divisor, check 8 @unpriv:OK
#354/113 verifier_sdiv/SDIV32, zero divisor:OK
#354/114 verifier_sdiv/SDIV32, zero divisor @unpriv:OK
#354/115 verifier_sdiv/SDIV64, zero divisor:OK
#354/116 verifier_sdiv/SDIV64, zero divisor @unpriv:OK
#354/117 verifier_sdiv/SMOD32, zero divisor:OK
#354/118 verifier_sdiv/SMOD32, zero divisor @unpriv:OK
#354/119 verifier_sdiv/SMOD64, zero divisor:OK
#354/120 verifier_sdiv/SMOD64, zero divisor @unpriv:OK
#354     verifier_sdiv:OK
Summary: 6/166 PASSED, 0 SKIPPED, 0 FAILED

NOTE: ldsx_insn testcase uses fentry and needs to rely on ftrace direct call [0].
[0] https://lore.kernel.org/all/20230627111612.761164-1-suagrfillet@gmail.com/

Pu Lehui (7):
  riscv, bpf: Fix missing exception handling and redundant zext for
    LDX_B/H/W
  riscv, bpf: Support sign-extension load insns
  riscv, bpf: Support sign-extension mov insns
  riscv, bpf: Support 32-bit offset jmp insn
  riscv, bpf: Support signed div/mod insns
  riscv, bpf: Support unconditional bswap insn
  selftests/bpf: Enable cpu v4 tests for RV64

 arch/riscv/net/bpf_jit.h                      |  30 ++++++
 arch/riscv/net/bpf_jit_comp64.c               | 102 ++++++++++++++----
 .../selftests/bpf/progs/test_ldsx_insn.c      |   3 +-
 .../selftests/bpf/progs/verifier_bswap.c      |   3 +-
 .../selftests/bpf/progs/verifier_gotol.c      |   3 +-
 .../selftests/bpf/progs/verifier_ldsx.c       |   3 +-
 .../selftests/bpf/progs/verifier_movsx.c      |   3 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |   3 +-
 8 files changed, 122 insertions(+), 28 deletions(-)

-- 
2.39.2


