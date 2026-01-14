Return-Path: <bpf+bounces-78827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CDED1C3FF
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CAF23013579
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB131ED8B;
	Wed, 14 Jan 2026 03:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C0J4omZ2"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5192FE056
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361260; cv=none; b=Hlfgvr1G0bN7ppbxi9xllGnFWIFQLclvZW1qarLTRtBp9THWBDc+dpDK7xki8jLqKBvOl6pBKRQh2yb/+yOJMkAAAb8KJp6zFEwx0aB9SQbw9OX4rbX1Ackb/QXfUfc+Dn1mxi2ikD1mpX1RSfJ7Ic8qT2sVMQG2CRNqKJ7rTEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361260; c=relaxed/simple;
	bh=volQB+UByAZxCpPV2MB6DbRWOw8a+SBlTjcryIOWTmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ubllnex7gYNEobM+XfWxv/PqHcuwVWJ98H+b8x/Alu8WiNpWH/MNxvM/mC1BuU9ZBmBRrlk1V1lX0MFE0V5y9K3Kbh7VezwXU+M/7yPqHDVu7oDpDyi3mmfLFksrPhlCzkSgReFqdg7Gy599V+D9f1QJ/5N/ZV5Umuc5AKzvg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C0J4omZ2; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768361256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfTaM3xHKrxTjEofDkWBXa/057UIGRf5olxUMa45Rkc=;
	b=C0J4omZ2/Eu1vkxk1Mr5IDptPpf2bCtYrr4XKAMWLlPPksU9eDtCcJrdjbOcmWLUr8qfRr
	d5AwTNsfIu6VcK43FH6QYiR8t1EkjdxIX/7Lg5zDTmQx/topjldfP1sFFEgmL5igPDXyGA
	JhAs0WHFWVtFHpWfMXu2SU+ugsuvWqQ=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v9 07/11] bpf,x86: add fsession support for x86_64
Date: Wed, 14 Jan 2026 11:27:20 +0800
Message-ID: <2187165.bB369e8A3T@7940hx>
In-Reply-To:
 <CAEf4BzYE0ZTrCaruJSr8MXAbZSsKz8H_BqHoZX5kS63yRBa-2g@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-8-dongml2@chinatelecom.cn>
 <CAEf4BzYE0ZTrCaruJSr8MXAbZSsKz8H_BqHoZX5kS63yRBa-2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 09:25 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Sat, Jan 10, 2026 at 6:12 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
> >
> > Add BPF_TRACE_FSESSION supporting to x86_64, including:
[...]
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index d94f7038c441..0671a434c00d 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3094,12 +3094,17 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
> >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> >                       struct bpf_tramp_links *tl, int stack_size,
> >                       int run_ctx_off, bool save_ret,
> > -                     void *image, void *rw_image)
> > +                     void *image, void *rw_image, u64 func_meta)
> >  {
> >         int i;
> >         u8 *prog = *pprog;
> >
> >         for (i = 0; i < tl->nr_links; i++) {
> > +               if (tl->links[i]->link.prog->call_session_cookie) {
> > +                       /* 'stack_size + 8' is the offset of func_md in stack */
> 
> not func_md, don't invent new names, "func_meta" (but it's also so


Ah, it should be func_meta here, it's a typo.


> backwards that you have stack offsets as positive... and it's not even
> in verifier's stack slots, just bytes... very confusing to me)


Do you mean the offset to emit_store_stack_imm64()? I'll convert it
to negative after modify the emit_store_stack_imm64() as you suggested.


> 
> > +                       emit_store_stack_imm64(&prog, stack_size + 8, func_meta);
> > +                       func_meta -= (1 << BPF_TRAMP_M_COOKIE);
> 
> was this supposed to be BPF_TRAMP_M_IS_RETURN?... and why didn't AI catch this?


It should be BPF_TRAMP_M_COOKIE here. I'm decreasing and
compute the offset of the session cookie for the next bpf
program.


This part correspond to the 5th patch. It will be more clear if you
combine it to the 5th patch. Seems that it's a little confusing
here :/


Maybe some comment is needed here.


> 
> > +               }
> >                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
> >                                     run_ctx_off, save_ret, image, rw_image))
> >                         return -EINVAL;
> > @@ -3222,7 +3227,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >         struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
> >         struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> >         void *orig_call = func_addr;
> > +       int cookie_off, cookie_cnt;
> >         u8 **branches = NULL;
> > +       u64 func_meta;
> >         u8 *prog;
> >         bool save_ret;
> >
> > @@ -3290,6 +3297,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >
> >         ip_off = stack_size;
> >
> > +       cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
> > +       /* room for session cookies */
> > +       stack_size += cookie_cnt * 8;
> > +       cookie_off = stack_size;
> > +
> >         stack_size += 8;
> >         rbx_off = stack_size;
> >
> > @@ -3383,9 +3395,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >                 }
> >         }
> >
> > +       if (bpf_fsession_cnt(tlinks)) {
> > +               /* clear all the session cookies' value */
> > +               for (int i = 0; i < cookie_cnt; i++)
> > +                       emit_store_stack_imm64(&prog, cookie_off - 8 * i, 0);
> > +               /* clear the return value to make sure fentry always get 0 */
> > +               emit_store_stack_imm64(&prog, 8, 0);
> > +       }
> > +       func_meta = nr_regs + (((cookie_off - regs_off) / 8) << BPF_TRAMP_M_COOKIE);
> 
> func_meta conceptually is a collection of bit fields, so using +/-
> feels weird, use | and &, more in line with working with bits?


It's not only for bit fields. For nr_args and cookie offset, they are
byte fields. Especially for cookie offset, arithmetic operation is performed
too. So I think it make sense here, right?


> 
> (also you defined that BPF_TRAMP_M_NR_ARGS but you are not using it
> consistently...)


I'm not sure if we should define it. As we use the least significant byte for
the nr_args, the shift for it is always 0. If we use it in the inline, unnecessary
instruction will be generated, which is the bit shift instruction.


I defined it here for better code reading. Maybe we can do some comment
in the inline of bpf_get_func_arg(), instead of defining such a unused
macro?


Thanks!
Menglong Dong


> 
> 
> 
> 
> > +
> >         if (fentry->nr_links) {
> >                 if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
> > -                              flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
> > +                              flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
> > +                              func_meta))
> >                         return -EINVAL;
> >         }
> >
> > @@ -3445,9 +3467,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
> >                 }
> >         }
> >
> > +       /* set the "is_return" flag for fsession */
> > +       func_meta += (1 << BPF_TRAMP_M_IS_RETURN);
> > +       if (bpf_fsession_cnt(tlinks))
> > +               emit_store_stack_imm64(&prog, nregs_off, func_meta);
> > +
> >         if (fexit->nr_links) {
> >                 if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
> > -                              false, image, rw_image)) {
> > +                              false, image, rw_image, func_meta)) {
> >                         ret = -EINVAL;
> >                         goto cleanup;
> >                 }
> > --
> > 2.52.0
> >
> 






