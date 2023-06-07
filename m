Return-Path: <bpf+bounces-2040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE387270A3
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADE71C20EBC
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EC43B8BE;
	Wed,  7 Jun 2023 21:40:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73253B8A3
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:40:48 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242771BF7
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:40:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977d7bdde43so276966b.0
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686174045; x=1688766045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx6ZmZ9yG8UAhPJ4Awmb7+D5yRSoZpG6TAzvfrTjS1g=;
        b=b5Y1trrLYLg4zk85SVFSjwpMOoTSbKd/l99CWGWWH5MQxMPG1u0NFd8RvdaD7/ipw4
         ep1MFPKWxSUZkNayMhEbzjguuySf6IOqVRbLcy4U4tlJ7pCzmTgoPYvFOd/pcZUpIXfH
         rgjvCRjcOGxzERCHw8EGO1f0tlnJqyfI4LGU+fO11BtiYr0MfFRxxxsZQz+6hG4t6P26
         Q4P5qyMg4k/NL5/friMSVBiQY02XaODYLiFnYtMfNR7Ey+6eU6g8iHvFwwtU+hPjWQHv
         3WINrd7GP4GHkcCt7oFpiC1ClddgpnQB1xE87nUYhlfoD3oXwtIJth05UD1Xi0K4e05w
         iKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174045; x=1688766045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx6ZmZ9yG8UAhPJ4Awmb7+D5yRSoZpG6TAzvfrTjS1g=;
        b=MagiJEv5OQSfI7QKpPoAIwkpbrjvZ8sChJEDKjCGcpG2+99K/Og5pN4IkPKRbwTZhO
         bIUO/qIPQuwZiKsQowWGsUzjaogNcgXe9zYcmUMMlmfp1BqEVCnjdf5rWv+TtiUA7ZK0
         jhtEkVcXb4fhzMrjrQ6z7M3UO+pDyRqkh0zg8WG3s1EsuHh2NXqwsXK/yTSD5JVpVMWq
         LN5E5QjkfYgwsZo1yzy6QN4mzlFnpNTIhOU5NJGB6nNAsAX2p5GEHcUByJfb8ZkJrrOZ
         W0iR1omItfADsg+33G+zzt3RPu0Q07mvcPQzwDwF69QLmmNTCUKeS6KKnbIVKQ3/byxi
         tqoA==
X-Gm-Message-State: AC+VfDz+AVCNzvX03moOwPWwOWd4Y7PRFubQ6n/H6X/0+O2YKNfV8qIa
	xeYaOeirqcqLKb8iHh/jRwcgAYqM1PRRkOpZB+w=
X-Google-Smtp-Source: ACHHUZ4BaX8BTtHzeuvQ2ZKSayaZ5jWqkWsvROqzqUtuvtkRswSyl4evua13OCg9HJD7NYPi8DK4S0cNYJ3Tw7tc5jU=
X-Received: by 2002:a17:907:970b:b0:978:8685:71d5 with SMTP id
 jg11-20020a170907970b00b00978868571d5mr241620ejc.30.1686174045540; Wed, 07
 Jun 2023 14:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230606222411.1820404-1-eddyz87@gmail.com> <20230606222411.1820404-4-eddyz87@gmail.com>
In-Reply-To: <20230606222411.1820404-4-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jun 2023 14:40:32 -0700
Message-ID: <CAEf4BzbbGV6gTJ1KdBB8EwLWV3aNE-iyNtP2pC-W1=MTDNRq5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] bpf: verify scalar ids mapping in
 regsafe() using check_ids()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 6, 2023 at 3:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> Make sure that the following unsafe example is rejected by verifier:
>
> 1: r9 =3D ... some pointer with range X ...
> 2: r6 =3D ... unbound scalar ID=3Da ...
> 3: r7 =3D ... unbound scalar ID=3Db ...
> 4: if (r6 > r7) goto +1
> 5: r6 =3D r7
> 6: if (r6 > X) goto ...
> --- checkpoint ---
> 7: r9 +=3D r7
> 8: *(u64 *)r9 =3D Y
>
> This example is unsafe because not all execution paths verify r7 range.
> Because of the jump at (4) the verifier would arrive at (6) in two states=
:
> I.  r6{.id=3Db}, r7{.id=3Db} via path 1-6;
> II. r6{.id=3Da}, r7{.id=3Db} via path 1-4, 6.
>
> Currently regsafe() does not call check_ids() for scalar registers,
> thus from POV of regsafe() states (I) and (II) are identical. If the
> path 1-6 is taken by verifier first, and checkpoint is created at (6)
> the path [1-4, 6] would be considered safe.
>
> This commit updates regsafe() to call check_ids() for precise scalar
> registers.
>
> To minimize the impact on verification performance, avoid generating
> bpf_reg_state::id for constant scalar values when processing BPF_MOV
> in check_alu_op(). Scalar IDs are utilized by find_equal_scalars() to
> propagate information about value ranges for registers that hold the
> same value. However, there is no need to propagate range information
> for constants.
>
> Still, there is some performance impact because of this change.
> Using veristat to compare number of processed states for selftests
> object files listed in tools/testing/selftests/bpf/veristat.cfg and
> Cilium object files from [1] gives the following statistics:
>
> $ ./veristat -e file,prog,states -f "states_pct>10" \
>     -C master-baseline.log current.log
> File         Program                         States  (DIFF)
> -----------  ------------------------------  --------------
> bpf_xdp.o    tail_handle_nat_fwd_ipv6        +155 (+23.92%)
> bpf_xdp.o    tail_nodeport_nat_ingress_ipv4  +102 (+27.20%)
> bpf_xdp.o    tail_rev_nodeport_lb4            +83 (+20.85%)
> loop6.bpf.o  trace_virtqueue_add_sgs          +25 (+11.06%)
>
> Also test case verifier_search_pruning/allocated_stack has to be
> updated to avoid conflicts in register ID assignments between cached
> and new states.
>
> [1] git@github.com:anakryiko/cilium.git
>
> Fixes: 75748837b7e5 ("bpf: Propagate scalar ranges through register assig=
nments.")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

So I checked it also on our internal BPF object files, and it looks
mostly good. Here are the only regressions:

Program                                   States (A)  States (B)
States   (DIFF)
----------------------------------------  ----------  ----------
---------------
balancer_ingress                               29219       34531
+5312 (+18.18%)
syar_bind6_protect6                             3257        3599
+342 (+10.50%)
syar_bind4_protect4                             2590        2931
+341 (+13.17%)
on_alloc                                         415         526
+111 (+26.75%)
on_free                                          406         517
+111 (+27.34%)
pycallcount                                      395         506
+111 (+28.10%)
resume_context                                   405         516
+111 (+27.41%)
on_py_event                                      395         506
+111 (+28.10%)
on_event                                         284         394
+110 (+38.73%)
handle_cuda_event                                268         378
+110 (+41.04%)
handle_cuda_launch                               276         386
+110 (+39.86%)
handle_cuda_malloc_ret                           272         382
+110 (+40.44%)
handle_cuda_memcpy                               270         380
+110 (+40.74%)
handle_cuda_memcpy_async                         270         380
+110 (+40.74%)
handle_pytorch_allocate_ret                      271         381
+110 (+40.59%)
handle_pytorch_malloc_ret                        272         382
+110 (+40.44%)
on_event                                         284         394
+110 (+38.73%)
on_event                                         284         394
+110 (+38.73%)
syar_task_enter_execve                           309         329
+20 (+6.47%)
kprobe__security_inode_link                      968         986
+18 (+1.86%)
kprobe__security_inode_symlink                   838         854
+16 (+1.91%)
tw_twfw_egress                                   249         251
+2 (+0.80%)
tw_twfw_ingress                                  250         252
+2 (+0.80%)
tw_twfw_tc_eg                                    248         250
+2 (+0.81%)
tw_twfw_tc_in                                    250         252
+2 (+0.80%)
raw_tracepoint__sched_process_exec               136         139
+3 (+2.21%)
kprobe_ret__do_filp_open                         869         871
+2 (+0.23%)
read_erlang_stack                                572         573
+1 (+0.17%)


They are mostly on small-ish programs. The only mild concern from my
side is balancer_ingress, which is one of Katran BPF programs. It add
+18% of states (which translates to about 70K more instructions
verified, up from 350K). I think we can live with this, but would be
nice to check why it's happening.

I suspect that dropping SCALAR IDs as we discussed (after fixing
register fill/spill ID generation) might completely mitigate that.

Overall, LGTM:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c                         | 34 ++++++++++++++++---
>  .../bpf/progs/verifier_search_pruning.c       |  3 +-
>  2 files changed, 32 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2aa60b73f1b5..175ca22b868e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12933,12 +12933,14 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
>                 if (BPF_SRC(insn->code) =3D=3D BPF_X) {
>                         struct bpf_reg_state *src_reg =3D regs + insn->sr=
c_reg;
>                         struct bpf_reg_state *dst_reg =3D regs + insn->ds=
t_reg;
> +                       bool need_id =3D (src_reg->type =3D=3D SCALAR_VAL=
UE && !src_reg->id &&
> +                                       !tnum_is_const(src_reg->var_off))=
;
>

nit: unnecessary outer ()

>                         if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
>                                 /* case: R1 =3D R2
>                                  * copy register state to dest reg
>                                  */
> -                               if (src_reg->type =3D=3D SCALAR_VALUE && =
!src_reg->id)
> +                               if (need_id)
>                                         /* Assign src and dst registers t=
he same ID
>                                          * that will be used by find_equa=
l_scalars()
>                                          * to propagate min/max range.

[...]

