Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF95B368E
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIILlM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 07:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiIILk4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 07:40:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3DE1AF22
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 04:40:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bj14so2232182wrb.12
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=RQdyheQEdBwlN5AUWD/28exptj6FeXRUMRGwNcf0Gu8=;
        b=NlaafQm9MBfBztbM7RNeZ/X2mpfcfsiZxj58YjxfzfknlWNr/XVnh32PBBBkj49SO2
         ABelvnBU/O7wmcUE/+iF+xrbSkMr/HMJyFcNL4U+vQLYCZhCxCvUCelowYkh67UIfWwH
         G4J70LLuXhMLtNZwa6kV8Jt/tvBzLExVQYVXii48ELqwaIc1ozxwbHN2pDX5TIeu9ywr
         KaK8TeYliCL8+Uvpbv39Obr4KsYRhO51/d/e9UjXpw9lkU2fGJzH0XYryoklx3bl5u4y
         CevvUpUlxtjpADEZyUrMBe6hihtAktuIRNTfPQMz7CisvK4AoRRhGDP7dgk08iYV70lO
         lv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=RQdyheQEdBwlN5AUWD/28exptj6FeXRUMRGwNcf0Gu8=;
        b=n11dbNeNTElzjWwdKyUT7KlOQvrK85zsf0yQNKKAJobNPSGIbbmglgtOgAtNkpTzcs
         WZiuOxYNvJ7/D5Ux5USmEXe2/bh+7ClQwJQ7Vsqb8eZ/GVF1vJgXKytJ+xBRbHW0SAI8
         8RJfmBbL/kiaDjoPVnqDNAxyBFSyzG2AdvHOwZ0NWXxZ9u6NTk7EM9mOy5ZsBhD82OKX
         NUX1WJjLvrZAm5oi4C5BcGi4TraCh1670RaEhlrmX17UdZs+PTpooqUEzIuFvb4CLXgW
         5N6T5wq+Ua5tcsDaZVf70vsWFJY3v3CpDq9Di32CD9FoJpHeLQQwdTJxfNwELvFOAtg/
         LQDg==
X-Gm-Message-State: ACgBeo0Ms2YCDGcCNq4KQKFntr9pfFSBQKTrrxBfgWDxg3Hsch294kGx
        WXGsNvwgCYVGqHqvIxIr1Hd2sgIBA3pD1g==
X-Google-Smtp-Source: AA6agR5n2aBP/3nayTabsL1HTxLoRhn9LTfOISgPrGj85Doz/FXXfu7iJ6euwk2/1pcZ6ADYOyzJZw==
X-Received: by 2002:a05:6000:2c1:b0:226:e7d0:f098 with SMTP id o1-20020a05600002c100b00226e7d0f098mr7913195wry.578.1662723651676;
        Fri, 09 Sep 2022 04:40:51 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id h14-20020a05600c414e00b003b3180551c8sm345301wmm.40.2022.09.09.04.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 04:40:51 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 9 Sep 2022 13:40:49 +0200
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: Re: [PATCHv3 bpf-next 3/6] bpf: Use given function address for
 trampoline ip arg
Message-ID: <YxsmQbYzfIND27Ix@krava>
References: <20220909101245.347173-1-jolsa@kernel.org>
 <20220909101245.347173-4-jolsa@kernel.org>
 <Yxsj7KUhVYYxJ1l9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxsj7KUhVYYxJ1l9@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 01:30:52PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 09, 2022 at 12:12:42PM +0200, Jiri Olsa wrote:
> > Using function address given at the generation time as the trampoline
> > ip argument. This way we get directly the function address that we
> > need, so we don't need to:
> >   - read the ip from the stack
> >   - subtract X86_PATCH_SIZE
> >   - subtract ENDBR_INSN_SIZE if CONFIG_X86_KERNEL_IBT is enabled
> >     which is not even implemented yet ;-)
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index ae89f4143eb4..1047686cc545 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2039,13 +2039,14 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
> >  int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
> >  				const struct btf_func_model *m, u32 flags,
> >  				struct bpf_tramp_links *tlinks,
> > -				void *orig_call)
> > +				void *func_addr)
> >  {
> >  	int ret, i, nr_args = m->nr_args, extra_nregs = 0;
> >  	int regs_off, ip_off, args_off, stack_size = nr_args * 8, run_ctx_off;
> >  	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> >  	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
> >  	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> > +	void *orig_call = func_addr;
> >  	u8 **branches = NULL;
> >  	u8 *prog;
> >  	bool save_ret;
> > @@ -2126,12 +2127,10 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> >  
> >  	if (flags & BPF_TRAMP_F_IP_ARG) {
> >  		/* Store IP address of the traced function:
> > -		 * mov rax, QWORD PTR [rbp + 8]
> > -		 * sub rax, X86_PATCH_SIZE
> > +		 * mov rax, func_addr
> 
> Shouldn't that be: movabs? Regular mov can't do 64bit immediates.

right, will change

jirka

> 
> Also curse Intel syntax, this is bloody unreadable.
> 
> >  		 * mov QWORD PTR [rbp - ip_off], rax
> >  		 */
> > -		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
> > -		EMIT4(0x48, 0x83, 0xe8, X86_PATCH_SIZE);
> > +		emit_mov_imm64(&prog, BPF_REG_0, (long) func_addr >> 32, (u32) (long) func_addr);
> >  		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
> >  	}
> >  
> > -- 
> > 2.37.3
> > 
