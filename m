Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2187F3AD362
	for <lists+bpf@lfdr.de>; Fri, 18 Jun 2021 22:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhFRUJX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Jun 2021 16:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhFRUJX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 18 Jun 2021 16:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624046832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nF7w/bRMF9yLough+lpnUI5zPdwvtiS+Mg2nsdKHrg4=;
        b=VjSr+y1EJD8n4mP1gNazOeAeC48HA0o98594rlYNXMIStA/0MWmqx2GkkSmLyub4tHZjzm
        9XLO3HT6IyAq4G+p/nQGaMAHIh1WsawKMR1LKhG4I9rkElqGrG44g8OfkkzWRWIWecMe5v
        LV8pytDRqg/y3/qCpwa6iVcd0w15Vr0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281--1Zt57NqMveCxQVn6E8lRg-1; Fri, 18 Jun 2021 16:07:10 -0400
X-MC-Unique: -1Zt57NqMveCxQVn6E8lRg-1
Received: by mail-ed1-f70.google.com with SMTP id j19-20020aa7c4130000b029039497d5cdbeso209390edq.15
        for <bpf@vger.kernel.org>; Fri, 18 Jun 2021 13:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nF7w/bRMF9yLough+lpnUI5zPdwvtiS+Mg2nsdKHrg4=;
        b=sJ5eirSbOOgjlOTbTh96M5OCAFvVrIJ/2DBj2WVk5oCn33jDJJnDdh0sbqb7MS1j9F
         ntO5pJtxZLOoFHqwgFdE7R2Q6UmRtSfipHlM9hKrM22Yp0hDVuI9xQ9OMSaoN3hE5Hu4
         iKiHE9XMBZpvaMVxxNxe++vvdMLAVJzcuS8UkNuUkohaWKF2XxTeHAcLVOfTP+07sYw7
         eFYbKM9U8cOeWJHgd4kkLRVvvk09edkeQ3OjZSgoe77jWWBva1mNoxsXKJ3l3IMtJFIs
         jjt8CTmHSDUcDREO/ZDI1/ZpuJc4BvR3gQGUFIL+Og51lydeOy8OJX/QPZ3KWcJPKVDy
         B1bQ==
X-Gm-Message-State: AOAM533pQxG5WZA9UhhuewvPy+GF8uq9CxdGaVOe9T631lDbgYw6ZXgS
        4GIneKk6c7OCY33bs1DLI42c+ub6dApHE56gk95qypmYzCVWzw/13osZ+ASATVuWpAif+B5e7WF
        enI12PyxACHnV
X-Received: by 2002:a17:906:1c84:: with SMTP id g4mr12260382ejh.99.1624046829133;
        Fri, 18 Jun 2021 13:07:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymURQ+JwV7b+V1F2pnphqLC6Cl2Klj4s5lxuDVf5+VvgJ417d5EIiqn/XBcMZgoEQ/LFVyKw==
X-Received: by 2002:a17:906:1c84:: with SMTP id g4mr12260367ejh.99.1624046828988;
        Fri, 18 Jun 2021 13:07:08 -0700 (PDT)
Received: from krava ([37.188.132.65])
        by smtp.gmail.com with ESMTPSA id yh11sm1402145ejb.16.2021.06.18.13.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:07:08 -0700 (PDT)
Date:   Fri, 18 Jun 2021 22:07:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next] bpf, x86: Remove unused cnt increase from EMIT
 macro
Message-ID: <YMz86IxKqoXGErAW@krava>
References: <20210616133400.315039-1-jolsa@kernel.org>
 <08876866-c004-ede7-6657-10a15f51f6d8@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08876866-c004-ede7-6657-10a15f51f6d8@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 17, 2021 at 01:04:08PM +0200, Daniel Borkmann wrote:
> On 6/16/21 3:34 PM, Jiri Olsa wrote:
> > Removing unused cnt increase from EMIT macro together
> > with cnt declarations. This was introduced in commit [1]
> > to ensure proper code generation. But that code was
> > removed in commit [2] and this extra code was left in.
> > 
> > [1] b52f00e6a715 ("x86: bpf_jit: implement bpf_tail_call() helper")
> > [2] ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> > 
> > Signed-off-by: Jiri Olsa <jolsa@redhat.com>
> > ---
> >   arch/x86/net/bpf_jit_comp.c | 39 ++++++++++---------------------------
> >   1 file changed, 10 insertions(+), 29 deletions(-)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 2a2e290fa5d8..19715542cd9c 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -31,7 +31,7 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
> >   }
> >   #define EMIT(bytes, len) \
> > -	do { prog = emit_code(prog, bytes, len); cnt += len; } while (0)
> > +	do { prog = emit_code(prog, bytes, len); } while (0)
> >   #define EMIT1(b1)		EMIT(b1, 1)
> >   #define EMIT2(b1, b2)		EMIT((b1) + ((b2) << 8), 2)
> > @@ -239,7 +239,6 @@ struct jit_context {
> >   static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
> >   {
> >   	u8 *prog = *pprog;
> > -	int cnt = 0;
> >   	if (callee_regs_used[0])
> >   		EMIT1(0x53);         /* push rbx */
> > @@ -255,7 +254,6 @@ static void push_callee_regs(u8 **pprog, bool *callee_regs_used)
> >   static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
> >   {
> >   	u8 *prog = *pprog;
> > -	int cnt = 0;
> >   	if (callee_regs_used[3])
> >   		EMIT2(0x41, 0x5F);   /* pop r15 */
> > @@ -303,7 +301,6 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
> 
> nit: In emit_prologue() we also have cnt that we could just replace with X86_PATCH_SIZE
> directly as well.

right, will send v2

thanks,
jirka

> 
> >   static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
> >   {
> >   	u8 *prog = *pprog;
> 
> Otherwise, lgtm.
> 
> Thanks,
> Daniel
> 

