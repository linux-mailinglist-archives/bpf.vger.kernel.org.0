Return-Path: <bpf+bounces-56795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53961A9DCF6
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 21:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 922437B08F2
	for <lists+bpf@lfdr.de>; Sat, 26 Apr 2025 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552A41E9B06;
	Sat, 26 Apr 2025 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5VwrBkR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7F19DF8B
	for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745697068; cv=none; b=DjxRdi8oSL9Ne6AI9lglr+V8vz/cLT1M2biPZ48VHaj6bPwXi6UgPcXpmBrSoCEIP6OqHl/yizsOjUe7q3zYrJ9WxOGj5NUQSklemzEcN9ontTB5V9K3bEUOTU3THRkaGRSq+TijomiMbAi4PcjcZXy3zgXUyGbOBXvRNzC0zdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745697068; c=relaxed/simple;
	bh=vADPwB0/xu4a2SLfmJy8ySH0qxf//O7BvwSjdBaNAOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cXZTz8PUgQ6Ly9qQM+saJWU5GTL4hXvPaEmEdfBTg+r7p8B646ITe+kjZky2dgqAXZ+Fl7KCAyR+K8tpc7yqKCDg7BDlJyaqZ9zQX62x9lor4KCTaxDSc7dnGRbJGlDYgdMU8Ugarg1VXaEdPxOxU2nRdvodIu5AkniUuGcyZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5VwrBkR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-736b98acaadso3343623b3a.1
        for <bpf@vger.kernel.org>; Sat, 26 Apr 2025 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745697066; x=1746301866; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d3TbxyqNJ8gSNlYw9aB780fhXGPkRknkL4U1B6hAsGE=;
        b=a5VwrBkRq35+kS/kVdv1mufhKJBWWIa1l8KTY2f4Mvqrx0D1yTdgciDSzOgKBhphpy
         jna4PxBetEj9ItpN5QFn4VWRxl9ba3mSbWUpQVO2LNrrL9PP8c8CUPvNRs5BfbkgHTtI
         +LxSHzaMg8vToh2qcB83CE2sLdsjmTy/9o6d75ZafVWis3hV/BYBQhZBg8E4xPCT5wy3
         5GNPnMv6Wowl8iDn7TdS0i3urjse4bPDVQye+AOtkkXGTmQ4mPs+g3i9ZJjlO4TszBeN
         dRpMpaK9zN22lRmtQmF0QBjsFgzGOXhvrN3U6i89Nyd/cY8uB1IvLOiDDH/nmXZsyCb/
         O93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745697066; x=1746301866;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3TbxyqNJ8gSNlYw9aB780fhXGPkRknkL4U1B6hAsGE=;
        b=C1tbe+ij5c4y7/RyLj6dI9Ux/r++wqZfddE0gXtsp522zNI+F/cKNCnW0SHfjwsyKm
         WGDWKIg5xSPRPHjwa1bvpNPhaRc6ha5sIwXHr/OIvxu6yAvspDnzgwOCZDEpp/z7fXTy
         o+BX+rmFGWAPVmBS/0ypV0J0yH5keLVxri8bY1A1SKP4yrpPlXZ9CmcB51grUbQ027YI
         5zaBcXFmu7xvhq4UC522MVW/ptMe7KF3XsGbxoMUUwx/yqnPSigpxrCvXjyn9Shs3Nam
         NJqmAndTAkPa0AwgoJtELHywHRHTodt4UHTppIpRKgmJkRiV6WJ0cjanb1TYo1RE32s7
         4csA==
X-Forwarded-Encrypted: i=1; AJvYcCXvL8GIKnZpCKCPSrf083vfZ79ggaSJEd/OwxiC7EmP07O4QLlMA0JpDJhsq9lFFIOwL2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHN6+DtTdWG+kIt++OX2tAlQO2D6pEertxkxmFDduWaSMkvUnA
	7clhka4/vBDy7FNZ+OfqH1wqvz9L2q+/cBJBtbnb36ORHcUB8iGI
X-Gm-Gg: ASbGncvSSZEa4swQgOADj3sFrTilOQKfMnTRGWPNTKXEMcrCTWHQ5dyEqV6J/N4x64B
	rh3lyINt6gHgpfWDAvQ2ICOQKXAu4m6motLfkl/6H/0I/dtK5CNh40q5FYYqXWDUwySUytS4L8L
	H9HbI3kpMRYpvkM9dxGaK156LS1hNQvkhnIkpQFKRwpYTzpytXJTovtDHvVzi+H+Yi/H6EUUsDm
	8Ez0vNKgLi69W4jqQE4GMiULfLyt3LuuPhbfJzXK9lGL7W89vb06lyZ0dHVq7g/9fmHMDQMwjvT
	IPwb1dK6C5gEuW494KJVFjMTI5jsM9rghSc91QPSUXxw9bc=
X-Google-Smtp-Source: AGHT+IFFW0I6dxWFr6IxGn94nRWCSL7WVULhsfm/+Ph2n/pkfbe+c/NPHUfAEGQL0JOMqcQvm5rQLw==
X-Received: by 2002:a05:6a20:12d1:b0:1ee:e96a:d9ed with SMTP id adf61e73a8af0-2045b6c21eamr9785943637.7.1745697066388;
        Sat, 26 Apr 2025 12:51:06 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9a560sm5310627b3a.135.2025.04.26.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 12:51:06 -0700 (PDT)
Message-ID: <39942ee3ccbc7aba2017ee2d31add0cc1b538b22.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/4] bpf: use SCC info instead of loop_entry
From: Eduard Zingerman <eddyz87@gmail.com>
To: kernel test robot <lkp@intel.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev
Date: Sat, 26 Apr 2025 12:51:04 -0700
In-Reply-To: <202504262235.h5B7vJiB-lkp@intel.com>
References: <20250426104634.744077-4-eddyz87@gmail.com>
	 <202504262235.h5B7vJiB-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-04-26 at 22:45 +0800, kernel test robot wrote:
> Hi Eduard,
>=20
> kernel test robot noticed the following build warnings:
>=20
> [auto build test WARNING on bpf-next/master]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Eduard-Zingerman/b=
pf-compute-SCCs-in-program-control-flow-graph/20250426-184824
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20250426104634.744077-4-eddyz87%=
40gmail.com
> patch subject: [PATCH bpf-next v1 3/4] bpf: use SCC info instead of loop_=
entry
> config: riscv-randconfig-001-20250426 (https://download.01.org/0day-ci/ar=
chive/20250426/202504262235.h5B7vJiB-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250426/202504262235.h5B7vJiB-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202504262235.h5B7vJiB-lkp=
@intel.com/
>=20
> All warnings (new ones prefixed by >>):
>=20
>    kernel/bpf/verifier.c: In function 'mark_all_regs_read_and_precise':
> > > kernel/bpf/verifier.c:18238:13: warning: variable 'insn_idx' set but =
not used [-Wunused-but-set-variable]
>    18238 |         u32 insn_idx;
>          |             ^~~~~~~~
>    At top level:
>    cc1: note: unrecognized command-line option '-Wno-unterminated-string-=
initialization' may have been intended to silence earlier diagnostics

I messed up when extracting frame_insn_idx().
The function needs to be updated as:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ae642459f342..06c2b3806666 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18240,7 +18240,7 @@ static void mark_all_regs_read_and_precise(struct b=
pf_verifier_env *env,
=20
        for (i =3D 0; i <=3D st->curframe; i++) {
                insn_idx =3D frame_insn_idx(st, i);
-               live_regs =3D env->insn_aux_data[st->insn_idx].live_regs_be=
fore;
+               live_regs =3D env->insn_aux_data[insn_idx].live_regs_before=
;
                func =3D st->frame[i];
                for (j =3D 0; j < BPF_REG_FP; j++) {
                        reg =3D &func->regs[j];

I'll try to figure out a test case failing w/o above hunk.
Also, patch #3 probably worth splitting in two:
- one adding new logic;
- one removing old logic.

Will wait a few days before sending v2.

> vim +/insn_idx +18238 kernel/bpf/verifier.c
>=20
>  18154=09
>  18155	/* Open coded iterators introduce loops in the verifier state grap=
h.
>  18156	 * State graph loops can result in incomplete read and precision m=
arks
>  18157	 * on individual states. E.g. consider the following states graph:
>  18158	 *
>  18159	 *  .-> A --.  Assume the states are visited in the order A, B, C.
>  18160	 *  |   |   |  Assume that state B reaches a state equivalent to s=
tate A.
>  18161	 *  |   v   v  At this point, state C has not been processed yet,
>  18162	 *  '-- B   C  so state A does not have any read or precision mark=
s from C yet.
>  18163	 *             As a result, these marks won't be propagated to B.
>  18164	 *
>  18165	 * If the marks on B are incomplete, it would be unsafe to use it =
in
>  18166	 * states_equal() checks.
>  18167	 *
>  18168	 * To avoid this safety issue, and since states with incomplete re=
ad
>  18169	 * marks can only occur within control flow graph loops, the verif=
ier
>  18170	 * assumes that any state with bpf_verifier_state->insn_idx residi=
ng
>  18171	 * in a strongly connected component (SCC) has read and precision
>  18172	 * marks for all registers. This assumption is enforced by the
>  18173	 * function mark_all_regs_read_and_precise(), which assigns
>  18174	 * corresponding marks.
>  18175	 *
>  18176	 * An intuitive point to call mark_all_regs_read_and_precise() wou=
ld
>  18177	 * be when a new state is created in is_state_visited().
>  18178	 * However, doing so would interfere with widen_imprecise_scalars(=
),
>  18179	 * which widens scalars in the current state after checking regist=
ers in a
>  18180	 * parent state. Registers are not widened if they are marked as p=
recise
>  18181	 * in the parent state.
>  18182	 *
>  18183	 * To avoid interfering with widening logic,
>  18184	 * a call to mark_all_regs_read_and_precise() for state is postpon=
ed
>  18185	 * until no widening is possible in any descendant of state S.
>  18186	 *
>  18187	 * Another intuitive spot to call mark_all_regs_read_and_precise()
>  18188	 * would be in update_branch_counts() when S's branches counter
>  18189	 * reaches 0. However, this falls short in the following case:
>  18190	 *
>  18191	 *	sum =3D 0
>  18192	 *	bpf_repeat(10) {                              // a
>  18193	 *		if (unlikely(bpf_get_prandom_u32()))  // b
>  18194	 *			sum +=3D 1;
>  18195	 *		if (bpf_get_prandom_u32())            // c
>  18196	 *			asm volatile ("");
>  18197	 *		asm volatile ("goto +0;");            // d
>  18198	 *	}
>  18199	 *
>  18200	 * Here a checkpoint is created at (d) with {sum=3D0} and the bran=
ch counter
>  18201	 * for (d) reaches 0, so 'sum' would be marked precise.
>  18202	 * When second branch of (c) reaches (d), checkpoint would be hit,
>  18203	 * and the precision mark for 'sum' propagated to (a).
>  18204	 * When the second branch of (b) reaches (a), the state would be {=
sum=3D1},
>  18205	 * no widening would occur, causing verification to continue forev=
er.
>  18206	 *
>  18207	 * To avoid such premature precision markings, the verifier postpo=
nes
>  18208	 * the call to mark_all_regs_read_and_precise() for state S even f=
urther.
>  18209	 * Suppose state P is a [grand]parent of state S and is the first =
state
>  18210	 * in the current state chain with state->insn_idx within current =
SCC.
>  18211	 * mark_all_regs_read_and_precise() for state S is only called onc=
e P
>  18212	 * is fully explored.
>  18213	 *
>  18214	 * The struct 'bpf_scc_info' is used to track this condition:
>  18215	 * - bpf_scc_info->branches counts how many states currently
>  18216	 *   in env->cur_state or env->head originate from this SCC;
>  18217	 * - bpf_scc_info->scc_epoch counts how many times 'branches'
>  18218	 *   has reached zero;
>  18219	 * - bpf_verifier_state->scc_epoch records the epoch of the SCC
>  18220	 *   corresponding to bpf_verifier_state->insn_idx at the moment
>  18221	 *   of state creation.
>  18222	 *
>  18223	 * Functions parent_scc_enter() and parent_scc_exit() maintain the
>  18224	 * bpf_scc_info->{branches,scc_epoch} counters.
>  18225	 *
>  18226	 * bpf_scc_info->branches reaching zero indicates that state P is
>  18227	 * fully explored. Its descendants residing in the same SCC have
>  18228	 * state->scc_epoch =3D=3D scc_info->scc_epoch. parent_scc_exit()
>  18229	 * increments scc_info->scc_epoch, allowing clean_live_states() to
>  18230	 * detect these states and apply mark_all_regs_read_and_precise().
>  18231	 */
>  18232	static void mark_all_regs_read_and_precise(struct bpf_verifier_env=
 *env,
>  18233						   struct bpf_verifier_state *st)
>  18234	{
>  18235		struct bpf_func_state *func;
>  18236		struct bpf_reg_state *reg;
>  18237		u16 live_regs;
>  18238		u32 insn_idx;
>  18239		int i, j;
>  18240=09
>  18241		for (i =3D 0; i <=3D st->curframe; i++) {
>  18242			insn_idx =3D frame_insn_idx(st, i);
>  18243			live_regs =3D env->insn_aux_data[st->insn_idx].live_regs_before;
>  18244			func =3D st->frame[i];
>  18245			for (j =3D 0; j < BPF_REG_FP; j++) {
>  18246				reg =3D &func->regs[j];
>  18247				if (!(BIT(j) & live_regs) || reg->type =3D=3D NOT_INIT)
>  18248					continue;
>  18249				reg->live |=3D REG_LIVE_READ64;
>  18250				if (reg->type =3D=3D SCALAR_VALUE && !is_reg_unbounded(reg))
>  18251					reg->precise =3D true;
>  18252			}
>  18253			for (j =3D 0; j < func->allocated_stack / BPF_REG_SIZE; j++) {
>  18254				reg =3D &func->stack[j].spilled_ptr;
>  18255				reg->live |=3D REG_LIVE_READ64;
>  18256				if (is_spilled_reg(&func->stack[j]) &&
>  18257				    reg->type =3D=3D SCALAR_VALUE && !is_reg_unbounded(reg))
>  18258					reg->precise =3D true;
>  18259			}
>  18260		}
>  18261	}
>  18262=09
>=20



