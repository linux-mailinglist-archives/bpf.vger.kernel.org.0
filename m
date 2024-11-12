Return-Path: <bpf+bounces-44575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A869C4C01
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D76B2848B
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 01:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859820B204;
	Tue, 12 Nov 2024 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB/dGvht"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA8204F7B
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731375001; cv=none; b=Z9Gd/oRgNHV7XF6MzF+pM9LAQgr1woK3El4H2BI686p/6b1ilnpzTY4E+dqsDYlUDUSvS0mks5DjfqnERCFJ4NbZBO+ZIPlMs5P1THL8E2lh1cA5OC+scQ/xCKGhWPHvqGeBlFwE44jsSapcMMi0Rv/ZdiMTY1hhmlkdVpJvvTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731375001; c=relaxed/simple;
	bh=pqNLa3Rp9pf1yOx70D4wCkFBnFWgxhdR19SnSipVznM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5xj7imieT33oIWA0rtrSdeed2FSxM9ju4/8DN7bIVkeYjuPd0nNFX+JjailgMNWt6Bo6CrscnfHg2oFzdiWkZRGwELES2iHYfeA/sUBGUoOyRdEi93Jz0H8EaEgIE8EmeS81ApQP5RsFqw62iQFJ3H6fKpi/zlr+hhQailrhwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB/dGvht; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43158625112so44926015e9.3
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 17:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731374998; x=1731979798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/SsN8VdKmGV1pQl33orMkMZzmXlVBSgJ6zPbn9T8ng=;
        b=MB/dGvhtEETfdPgZTF2NVhUpzczdnE979CFpWZcQMmZmMjKKf2XCNgXX8GOKcxv6L5
         up3flbigRtX62CW0F+utrVXwS75ARzSQWtn61iQ+XbhybzvjHLObScKBtznxRFYBdGhe
         GUGMmDs1Vu4dU5zNrmI1hZe/KftV+nGY1VpvwxHWa3/gScD1Nj8fLzU4G6way10S2Qh0
         Idx5tDEU5OOrk8QeV0S86qFbad4phHXF7QQJDalHAADYgst1Dgg5xwrxc//Qw1ZpqWw/
         DbtAGjPdBt/j1bRqXER3L7r+mSlnoUk2BS7hThK0Hzen8u9J3MpuBO/Jxp3Pv/HZSo53
         nE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731374998; x=1731979798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/SsN8VdKmGV1pQl33orMkMZzmXlVBSgJ6zPbn9T8ng=;
        b=ts8ceqgh44Y3PCYkW5XkOpg6GKhlsuvEzx0891XtXVQnpUr7wfvnb3IAks/B3+By9J
         XncHkRfek+jdV3B+11MTqp8HajxX3LXy7Js2FgHlnwdC0dacKpQ2rIO2U8SptEGYAapa
         +E1KaS8TIYcMoCcevTqODONyrt1vif6p2cZQy5MM88nabcGTgvjveuZ9noGv4uZmX5zX
         Q5cF0qeGT+w2AnttvQpeAUmUqJpm/15z6qogjHgqoRUDTQ5kjj849+bi+jhKNvAfEkEC
         sRfmTDX6CfZLAp3Kqr0y+/BHG83Hz63Tmyl8QtDjHJS1JerZSK1dRlSG8ieVxKlKpQST
         Oq3Q==
X-Gm-Message-State: AOJu0Yzxvsvlkxz1VkbyzNCsI0P1s4bvLWL2HMxecUCz8Q7qJZWqzGcJ
	AJGEWrY0OZSuLvUODFQ5JT0NyLOtNUVnQSUMaektXb3UoZ2spC9rivs+HGintXTjjMmyL45sWFN
	pM92zV4bsLiiYe7pX9OznFXdxSfw=
X-Google-Smtp-Source: AGHT+IGI826OHicDV+MfTL1WthPXt8CUFEM4HbaCijSTudDbJWwcgSNmpVL9HoDgu2kZzegZhiO+oE12WF56UJJVRNE=
X-Received: by 2002:a05:600c:3ca8:b0:426:616e:db8d with SMTP id
 5b1f17b1804b1-432b7509717mr104709275e9.15.1731374997781; Mon, 11 Nov 2024
 17:29:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109025312.148539-1-yonghong.song@linux.dev>
 <20241109025332.150019-1-yonghong.song@linux.dev> <CAADnVQJ4OiJbVMU-xrQhokPoECh4v4fWf-N-0YMx0k=h12f8EQ@mail.gmail.com>
 <a339f24d-eeb3-4086-b2b4-914e4c41766a@linux.dev>
In-Reply-To: <a339f24d-eeb3-4086-b2b4-914e4c41766a@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Nov 2024 17:29:46 -0800
Message-ID: <CAADnVQ+X29PzexOqHiKnT4w7w+X95WjH6RT=-UFGisr-xgapPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 4/7] bpf, x86: Support private stack in jit
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 3:18=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
>
> On 11/9/24 12:14 PM, Alexei Starovoitov wrote:
> > On Fri, Nov 8, 2024 at 6:53=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >>
> >>          stack_depth =3D bpf_prog->aux->stack_depth;
> >> +       if (bpf_prog->aux->priv_stack_ptr) {
> >> +               priv_frame_ptr =3D bpf_prog->aux->priv_stack_ptr + rou=
nd_up(stack_depth, 16);
> >> +               stack_depth =3D 0;
> >> +       }
> > ...
> >
> >> +       priv_stack_ptr =3D prog->aux->priv_stack_ptr;
> >> +       if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
> >> +               priv_stack_ptr =3D __alloc_percpu_gfp(prog->aux->stack=
_depth, 16, GFP_KERNEL);
> > After applying I started to see crashes running test_progs -j like:
> >
> > [  173.465191] Oops: general protection fault, probably for
> > non-canonical address 0xdffffc0000000af9: 0000 [#1] PREEMPT SMP KASAN
> > [  173.466053] KASAN: probably user-memory-access in range
> > [0x00000000000057c8-0x00000000000057cf]
> > [  173.466053] RIP: 0010:dst_dev_put+0x1e/0x220
> > [  173.466053] Call Trace:
> > [  173.466053]  <IRQ>
> > [  173.466053]  ? die_addr+0x40/0xa0
> > [  173.466053]  ? exc_general_protection+0x138/0x1f0
> > [  173.466053]  ? asm_exc_general_protection+0x26/0x30
> > [  173.466053]  ? dst_dev_put+0x1e/0x220
> > [  173.466053]  rt_fibinfo_free_cpus.part.0+0x8c/0x130
> > [  173.466053]  fib_nh_common_release+0xd6/0x2a0
> > [  173.466053]  free_fib_info_rcu+0x129/0x360
> > [  173.466053]  ? rcu_core+0xa55/0x1340
> > [  173.466053]  rcu_core+0xa55/0x1340
> > [  173.466053]  ? rcutree_report_cpu_dead+0x380/0x380
> > [  173.466053]  ? hrtimer_interrupt+0x319/0x7c0
> > [  173.466053]  handle_softirqs+0x14c/0x4d0
> >
> > [   35.134115] Oops: general protection fault, probably for
> > non-canonical address 0xe0000bfff101fbbc: 0000 [#1] PREEMPT SMP KASAN
> > [   35.135089] KASAN: probably user-memory-access in range
> > [0x00007fff880fdde0-0x00007fff880fdde7]
> > [   35.135089] RIP: 0010:destroy_workqueue+0x4b4/0xa70
> > [   35.135089] Call Trace:
> > [   35.135089]  <TASK>
> > [   35.135089]  ? die_addr+0x40/0xa0
> > [   35.135089]  ? exc_general_protection+0x138/0x1f0
> > [   35.135089]  ? asm_exc_general_protection+0x26/0x30
> > [   35.135089]  ? destroy_workqueue+0x4b4/0xa70
> > [   35.135089]  ? destroy_workqueue+0x592/0xa70
> > [   35.135089]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> > [   35.135089]  ext4_put_super+0xff/0xd70
> > [   35.135089]  generic_shutdown_super+0x148/0x4c0
> > [   35.135089]  kill_block_super+0x3b/0x90
> > [   35.135089]  ext4_kill_sb+0x65/0x90
> >
> > I think I see the bug... quoted it above...
> >
> > Please make sure you reproduce it first.
>
> Indeed, to use the allocation size round_up(stack_depth, 16) for __alloc_=
percpu_gfp()
> indeed fixed the problem.
>
> The following is additional change on top of this patch set to
>    - fix the memory access bug as suggested by Alexei in the above
>    - Add guard space for private stack, additional 16 bytes at the
>      end of stack will be the guard space. The content is prepopulated
>      and checked at per cpu private stack free site. If the content
>      is not expected, a kernel message will emit.
>    - Add kasan support for guard space.
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 55556a64f776..d796d419bb48 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1446,6 +1446,9 @@ static void emit_priv_frame_ptr(u8 **pprog, void __=
percpu *priv_frame_ptr)
>   #define LOAD_TAIL_CALL_CNT_PTR(stack)                          \
>          __LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
>
> +#define PRIV_STACK_GUARD_SZ    16
> +#define PRIV_STACK_GUARD_VAL   0xEB9F1234eb9f1234ULL
> +
>   static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 =
*rw_image,
>                    int oldproglen, struct jit_context *ctx, bool jmp_padd=
ing)
>   {
> @@ -1462,10 +1465,11 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
>          u8 *prog =3D temp;
>          u32 stack_depth;
>          int err;
> +       // int stack_size;
>
>          stack_depth =3D bpf_prog->aux->stack_depth;
>          if (bpf_prog->aux->priv_stack_ptr) {
> -               priv_frame_ptr =3D bpf_prog->aux->priv_stack_ptr + round_=
up(stack_depth, 16);
> +               priv_frame_ptr =3D bpf_prog->aux->priv_stack_ptr + round_=
up(stack_depth, 16) + PRIV_STACK_GUARD_SZ;
>                  stack_depth =3D 0;

Since priv stack is not really a stack there is no need to align it to 16
and no need to round_up() either.
let's drop these parts and it will simplify the code.

Re: GUARD_SZ.
I think it's better to guard top and bottom.
8 byte for each will do.

>          }
>
> @@ -1496,8 +1500,18 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
>                  emit_mov_imm64(&prog, X86_REG_R12,
>                                 arena_vm_start >> 32, (u32) arena_vm_star=
t);
>
> -       if (priv_frame_ptr)
> +       if (priv_frame_ptr) {
> +#if 0
> +               /* hack to emit and write some data to guard area */
> +               emit_priv_frame_ptr(&prog, bpf_prog->aux->priv_stack_ptr)=
;
> +
> +               /* See case BPF_ST | BPF_MEM | BPF_W */
> +               EMIT2(0x41, 0xC7);
> +               EMIT2(add_1reg(0x40, X86_REG_R9), 0);
> +               EMIT(0xFFFFFFFF, bpf_size_to_x86_bytes(BPF_W));
> +#endif
>                  emit_priv_frame_ptr(&prog, priv_frame_ptr);
> +       }
>
>          ilen =3D prog - temp;
>          if (rw_image)
> @@ -3383,11 +3397,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_p=
rog *prog)
>          struct x64_jit_data *jit_data;
>          int proglen, oldproglen =3D 0;
>          struct jit_context ctx =3D {};
> +       int priv_stack_size, cpu;
>          bool tmp_blinded =3D false;
>          bool extra_pass =3D false;
>          bool padding =3D false;
>          u8 *rw_image =3D NULL;
>          u8 *image =3D NULL;
> +       u64 *guard_ptr;
>          int *addrs;
>          int pass;
>          int i;
> @@ -3418,11 +3434,17 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_p=
rog *prog)
>          }
>          priv_stack_ptr =3D prog->aux->priv_stack_ptr;
>          if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
> -               priv_stack_ptr =3D __alloc_percpu_gfp(prog->aux->stack_de=
pth, 16, GFP_KERNEL);
> +               priv_stack_size =3D round_up(prog->aux->stack_depth, 16) =
+ PRIV_STACK_GUARD_SZ;
> +               priv_stack_ptr =3D __alloc_percpu_gfp(priv_stack_size, 16=
, GFP_KERNEL);
>                  if (!priv_stack_ptr) {
>                          prog =3D orig_prog;
>                          goto out_priv_stack;
>                  }
> +               for_each_possible_cpu(cpu) {
> +                       guard_ptr =3D per_cpu_ptr(priv_stack_ptr, cpu);
> +                       guard_ptr[0] =3D guard_ptr[1] =3D PRIV_STACK_GUAR=
D_VAL;
> +                       kasan_poison_vmalloc(guard_ptr, PRIV_STACK_GUARD_=
SZ);

with top and bottom guards there will be two calls to poison.

But did you check that percpu allocs come from the vmalloc region?
Does kasan_poison_vmalloc() actually work or silently nop ?

> +               }
>                  prog->aux->priv_stack_ptr =3D priv_stack_ptr;
>          }
>          addrs =3D jit_data->addrs;
> @@ -3561,6 +3583,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
og *prog)
>   out_addrs:
>                  kvfree(addrs);
>                  if (!image && priv_stack_ptr) {
> +                       for_each_possible_cpu(cpu) {
> +                               guard_ptr =3D per_cpu_ptr(priv_stack_ptr,=
 cpu);
> +                               kasan_unpoison_vmalloc(guard_ptr, PRIV_ST=
ACK_GUARD_SZ, KASAN_VMALLOC_PROT_NORMAL);
> +                       }
>                          free_percpu(priv_stack_ptr);
>                          prog->aux->priv_stack_ptr =3D NULL;
>                  }
> @@ -3603,6 +3629,9 @@ void bpf_jit_free(struct bpf_prog *prog)
>          if (prog->jited) {
>                  struct x64_jit_data *jit_data =3D prog->aux->jit_data;
>                  struct bpf_binary_header *hdr;
> +               void __percpu *priv_stack_ptr;
> +               u64 *guard_ptr;
> +               int cpu;
>
>                  /*
>                   * If we fail the final pass of JIT (from jit_subprogs),
> @@ -3618,7 +3647,21 @@ void bpf_jit_free(struct bpf_prog *prog)
>                  prog->bpf_func =3D (void *)prog->bpf_func - cfi_get_offs=
et();
>                  hdr =3D bpf_jit_binary_pack_hdr(prog);
>                  bpf_jit_binary_pack_free(hdr, NULL);
> -               free_percpu(prog->aux->priv_stack_ptr);
> +
> +               priv_stack_ptr =3D prog->aux->priv_stack_ptr;
> +               if (priv_stack_ptr) {
> +                       int stack_size;
> +
> +                       stack_size =3D round_up(prog->aux->stack_depth, 1=
6) + PRIV_STACK_GUARD_SZ;
> +                       for_each_possible_cpu(cpu) {
> +                               guard_ptr =3D per_cpu_ptr(priv_stack_ptr,=
 cpu);
> +                               kasan_unpoison_vmalloc(guard_ptr, PRIV_ST=
ACK_GUARD_SZ, KASAN_VMALLOC_PROT_NORMAL);
> +                               if (guard_ptr[0] !=3D PRIV_STACK_GUARD_VA=
L || guard_ptr[1] !=3D PRIV_STACK_GUARD_VAL)
> +                                       pr_err("Private stack Overflow ha=
ppened for prog %sx\n", prog->aux->name);
> +                       }

Common helper is needed to check guards before free_percpu.

> +                       free_percpu(priv_stack_ptr);
> +               }
> +
>                  WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
>          }
>
> This fixed the issue Alexei discovered.
>
> 16 bytes guard space is allocated since allocation is done with 16byte al=
igned
> with multiple-16 size. If bpf program overflows the stack (change '#if 0'=
 to '#if 1')
> in the above change, we will see:
>
> [root@arch-fb-vm1 bpf]# ./test_progs -n 336
> [   28.447390] bpf_testmod: loading out-of-tree module taints kernel.
> [   28.448180] bpf_testmod: module verification failed: signature and/or =
required key missing - tainting kernel
> #336/1   struct_ops_private_stack/private_stack:OK
> #336/2   struct_ops_private_stack/private_stack_fail:OK
> #336/3   struct_ops_private_stack/private_stack_recur:OK
> #336     struct_ops_private_stack:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
> [   28.737710] Private stack Overflow happened for prog Fx
> [   28.739284] Private stack Overflow happened for prog Fx
> [   28.968732] Private stack Overflow happened for prog Fx
>
> Here the func name is 'Fx' (representing the sub prog). We might need
> to add more meaningful info (e.g. main prog name) to make message more
> meaningful.

Probably worth introducing a helper like:

const char *bpf_get_prog_name(prog)
{
  if (fp->aux->ksym.prog)
    return prog->aux->ksym.name;
  return prog->aux->name;
}


>
> I added some changes related kasan. If I made a change to guard space in =
kernel (not in bpf prog),
> the kasan can print out the error message properly. But unfortunately, in=
 jit, there is no
> kasan instrumentation so warning (with "#if 1" change) is not reported. O=
ne possibility is
> if kernel config enables kasan, bpf jit could add kasan to jited binary. =
Not sure the
> complexity and whether it is worthwhile or not since supposedly verifier =
should already
> prevent overflow and we already have a guard check (Private stack overflo=
w happened ...)
> in jit.

As a follow up we should teach JIT to emit calls __asan_loadN/storeN
when processing LDX/STX.
imo it's been long overdue.

