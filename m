Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB046D433D
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 13:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjDCLRV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 07:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjDCLRS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 07:17:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6010B1D923
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 04:16:56 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso32148037pjb.3
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680520615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke1BmpJax0dFxDzlH+fS+VmzwhJuJbFy2IGCh2H/H80=;
        b=do6CEDVjMR71jqF0bpSY9nVTAnaHoU/UV9pX90cv0snUMn6ZJpMxCCfot2PUitZoc5
         pEuoGjhoDLKX9C6YmLu1zhyJjjpdMcheApGJQxUn+43jMWvW1GVGR5gMzDxk+Dryzfg5
         nowHGujOvTKHYjNjqhmSRlcM2LT0ZIa6+R1lc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680520615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke1BmpJax0dFxDzlH+fS+VmzwhJuJbFy2IGCh2H/H80=;
        b=Z/MW8ASMWe9SNNdWDdvzdWpWHy86NPaxhHSR8sK/ZYmUEPr6uGKA4Sz8GqywxtxW9r
         v6wr9PoF7fC55thc5bYcZ4QJ40hgrfntbYFP0UNvMOQHdVCCrH7ArchpkVuq3iiXMoib
         w3qgC52gsj+6w/l6wMKcKkL9nsFKz6/7XvVwGh86Vsk5WFSJc/hlTBQDTLqdZO6f9Tlp
         JaBB1H0vpcBBRf0S4JSivpQMAXZ1YSrug2tmYNWdoZsCbLFMpmE36H/2htKKdzYb/Z+b
         Edy8BcdrvyqlDanDOjShO3ae7xfMBR0J88xrJI/i1m0+uHVDs2ZpJCJhRRWVNUTulYIN
         d12A==
X-Gm-Message-State: AAQBX9c9oVzWup9QH2JVp3HS9RUVSlCqSAyWojddrsawkc7TnYH7OwzU
        RuAcBg9MNS1Mw2Dew6twt6recFL6UBhyX5yDBvni1A==
X-Google-Smtp-Source: AKy350a0m8UMHP75L6OmsSj6MDl520edXzfsPgoQs+rXUr4+WE0UzLlQtsiZsOVTXM31l2z3Sxh1PKzALboC62Ci13M=
X-Received: by 2002:a17:902:d70c:b0:1a1:def4:a030 with SMTP id
 w12-20020a170902d70c00b001a1def4a030mr6366338ply.0.1680520615096; Mon, 03 Apr
 2023 04:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230401234144.3719742-1-xukuohai@huaweicloud.com>
In-Reply-To: <20230401234144.3719742-1-xukuohai@huaweicloud.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 3 Apr 2023 13:16:44 +0200
Message-ID: <CABRcYmJ7Oi6fpU76aNFpEwa94sZ+O7q6M1k-LMB0f0iXbFXGZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Fixed a BTI error on returning to
 patched function
To:     Xu Kuohai <xukuohai@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 1, 2023 at 12:43=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> When BPF_TRAMP_F_CALL_ORIG is set, bpf trampoline uses BLR to jump
> back to the instruction next to call site to call the patched function.
> For BTI-enabled kernel, the instruction next to call site is usually
> PACIASP, in this case, it's safe to jump back with BLR. But when
> the call site is not followed by a PACIASP or bti, a BTI exception
> is triggered.
>
> Here is a fault log:
>
>  Unhandled 64-bit el1h sync exception on CPU0, ESR 0x0000000034000002 -- =
BTI
>  CPU: 0 PID: 263 Comm: test_progs Tainted: GF
>  Hardware name: linux,dummy-virt (DT)
>  pstate: 40400805 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D-c)
>  pc : bpf_fentry_test1+0xc/0x30
>  lr : bpf_trampoline_6442573892_0+0x48/0x1000
>  sp : ffff80000c0c3a50
>  x29: ffff80000c0c3a90 x28: ffff0000c2e6c080 x27: 0000000000000000
>  x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000050
>  x23: 0000000000000000 x22: 0000ffffcfd2a7f0 x21: 000000000000000a
>  x20: 0000ffffcfd2a7f0 x19: 0000000000000000 x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffcfd2a7f0
>  x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>  x11: 0000000000000000 x10: ffff80000914f5e4 x9 : ffff8000082a1528
>  x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0101010101010101
>  x5 : 0000000000000000 x4 : 00000000fffffff2 x3 : 0000000000000001
>  x2 : ffff8001f4b82000 x1 : 0000000000000000 x0 : 0000000000000001
>  Kernel panic - not syncing: Unhandled exception
>  CPU: 0 PID: 263 Comm: test_progs Tainted: GF
>  Hardware name: linux,dummy-virt (DT)
>  Call trace:
>   dump_backtrace+0xec/0x144
>   show_stack+0x24/0x7c
>   dump_stack_lvl+0x8c/0xb8
>   dump_stack+0x18/0x34
>   panic+0x1cc/0x3ec
>   __el0_error_handler_common+0x0/0x130
>   el1h_64_sync_handler+0x60/0xd0
>   el1h_64_sync+0x78/0x7c
>   bpf_fentry_test1+0xc/0x30
>   bpf_fentry_test1+0xc/0x30
>   bpf_prog_test_run_tracing+0xdc/0x2a0
>   __sys_bpf+0x438/0x22a0
>   __arm64_sys_bpf+0x30/0x54
>   invoke_syscall+0x78/0x110
>   el0_svc_common.constprop.0+0x6c/0x1d0
>   do_el0_svc+0x38/0xe0
>   el0_svc+0x30/0xd0
>   el0t_64_sync_handler+0x1ac/0x1b0
>   el0t_64_sync+0x1a0/0x1a4
>  Kernel Offset: disabled
>  CPU features: 0x0000,00034c24,f994fdab
>  Memory Limit: none
>
> And the instruction next to call site of bpf_fentry_test1 is ADD,
> not PACIASP:
>
> <bpf_fentry_test1>:
>         bti     c
>         nop
>         nop
>         add     w0, w0, #0x1
>         paciasp
>
> For bpf prog, jit always puts a PACIASP after call site for BTI-enabled
> kernel, so there is no problem.
>
> To fix it, replace BLR with RET to bypass the branch target check.
>
> Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
> Reported-by: Florent Revest <revest@chromium.org>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Thank you Xu! It does fix the BTI Oops I observed :)

Tested-by: Florent Revest <revest@chromium.org>
Acked-by: Florent Revest <revest@chromium.org>

> ---
>  arch/arm64/net/bpf_jit.h      | 4 ++++
>  arch/arm64/net/bpf_jit_comp.c | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index a6acb94ea3d6..c2edadb8ec6a 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -281,4 +281,8 @@
>  /* DMB */
>  #define A64_DMB_ISH aarch64_insn_gen_dmb(AARCH64_INSN_MB_ISH)
>
> +/* ADR */
> +#define A64_ADR(Rd, offset) \
> +       aarch64_insn_gen_adr(0, offset, Rd, AARCH64_INSN_ADR_TYPE_ADR)
> +
>  #endif /* _BPF_JIT_H */
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 62f805f427b7..b26da8efa616 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1900,7 +1900,8 @@ static int prepare_trampoline(struct jit_ctx *ctx, =
struct bpf_tramp_image *im,
>                 restore_args(ctx, args_off, nargs);
>                 /* call original func */
>                 emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
> -               emit(A64_BLR(A64_R(10)), ctx);
> +               emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
> +               emit(A64_RET(A64_R(10)), ctx);
>                 /* store return value */
>                 emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
>                 /* reserve a nop for bpf_tramp_image_put */
> --
> 2.30.2
>
