Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953A5457854
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 22:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhKSVuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 16:50:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32426 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230133AbhKSVuB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Nov 2021 16:50:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637358418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xo6KEwqtnnTzwkn8zhhSqMZemLxghNE7qqck7cg/WoA=;
        b=h2oUrcQqEgyPQjPRd3Xy9/q3zyWIZg2pHavFEB/9q6mg0bP6fJMA6kntoNWBbr0J646cVe
        rToaxzPxa/I+R4J92nGwOcy9nFdYYbo8X2LTFMJu52zKGHt4bGZgyFZsVN3z4fISgFoWfA
        gEvZUu+mmW4aHp1LX6bAnIoAjIu73IE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-u86PpBPrOoqw5jqNpay06w-1; Fri, 19 Nov 2021 16:46:55 -0500
X-MC-Unique: u86PpBPrOoqw5jqNpay06w-1
Received: by mail-ed1-f72.google.com with SMTP id m12-20020a056402430c00b003e9f10bbb7dso2166722edc.18
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 13:46:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xo6KEwqtnnTzwkn8zhhSqMZemLxghNE7qqck7cg/WoA=;
        b=F85lxeNO75PUHPe8VFuzVJe2bCuu4LO6ht7mOxdfLOOc59pxNbitm36i057Lu7fcbE
         crlKKnPegM/F6q8Eb8oR2XVe/V8OzQA9Y3GJcLMRbbOPA1eZ0e0dBoVwwODuNcSmd063
         AFPz4JC72ShU1xu6FxycUvcXY92troCbPjifsY+bXn/B8ReWtYd/qnU7qIAKaQg8qgmY
         GN/tgNpOo8sQ73iUnp9kygRPRaX1km8lO6oANleUBKw6NSc2zJhjOxAeP80ARZhBEZvo
         X1scoglGl52cNMRi6QW9OEZtai9MtRGqSGBZX8pU98sfZpR9hh6cFXHbJxZi6eEXIh3I
         LzVg==
X-Gm-Message-State: AOAM5312vB9rZlkSaYynsNyL8yHwhN7ABGIfMFLjGI0+FDPR/Jz4+PHN
        63bvF6DeY8AlDTVYGkl/7Mt3Ol4t+TSS2KkdGqQ4PIa62UhkqN65a+5RU7T/IH/EQV+uU1gBfed
        8WmbESEMep/rJ
X-Received: by 2002:a05:6402:34f:: with SMTP id r15mr29758335edw.80.1637358414078;
        Fri, 19 Nov 2021 13:46:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDTdGEdExkfTTAn4L5UVjMh0KmihlYta3/zKLnej1i3ht1atIv2finrQja+EcBUAsX1HGRzg==
X-Received: by 2002:a05:6402:34f:: with SMTP id r15mr29758307edw.80.1637358413925;
        Fri, 19 Nov 2021 13:46:53 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id i8sm548648edc.12.2021.11.19.13.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 13:46:53 -0800 (PST)
Date:   Fri, 19 Nov 2021 22:46:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next 07/29] bpf, x64: Allow to use caller address
 from stack
Message-ID: <YZgbS0GUpEzAeGNu@krava>
References: <20211118112455.475349-1-jolsa@kernel.org>
 <20211118112455.475349-8-jolsa@kernel.org>
 <20211119041409.rb7b4i7nukowfcwb@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119041409.rb7b4i7nukowfcwb@ast-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 18, 2021 at 08:14:09PM -0800, Alexei Starovoitov wrote:
> On Thu, Nov 18, 2021 at 12:24:33PM +0100, Jiri Olsa wrote:
> > Currently we call the original function by using the absolute address
> > given at the JIT generation. That's not usable when having trampoline
> > attached to multiple functions. In this case we need to take the
> > return address from the stack.
> > 
> > Adding support to retrieve the original function address from the stack
> > by adding new BPF_TRAMP_F_ORIG_STACK flag for arch_prepare_bpf_trampoline
> > function.
> > 
> > Basically we take the return address of the 'fentry' call:
> > 
> >    function + 0: call fentry    # stores 'function + 5' address on stack
> >    function + 5: ...
> > 
> > The 'function + 5' address will be used as the address for the
> > original function to call.
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 13 +++++++++----
> >  include/linux/bpf.h         |  5 +++++
> >  2 files changed, 14 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 67e8ac9aaf0d..d87001073033 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2035,10 +2035,15 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> >  	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> >  		restore_regs(m, &prog, nr_args, stack_size);
> >  
> > -		/* call original function */
> > -		if (emit_call(&prog, orig_call, prog)) {
> > -			ret = -EINVAL;
> > -			goto cleanup;
> > +		if (flags & BPF_TRAMP_F_ORIG_STACK) {
> > +			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
> > +			EMIT2(0xff, 0xd0); /* call *rax */
> 
> Either return an eror if repoline is on
> or use emit_indirect_jump().
> 

ok, will check

thanks,
jirka

