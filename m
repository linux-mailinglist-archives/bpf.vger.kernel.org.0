Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5879E637567
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 10:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiKXJm7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 04:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiKXJm6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 04:42:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299B6976D2
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 01:42:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i12so1701853wrb.0
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 01:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmd1/9s1rQKDmAWfh67gx25yvlIQdWgrBPInzcXI9IU=;
        b=jOZVeWylzdsBTCb4xYN/n6QVWxDPnRragBGYMyjoa0ZmsQrhlKwTic8FLGFM2C6Tct
         KzzFga8oe0IVYmqQDv4szJSexKv3yDi+xuCgLdw74ODHdH0JLm9VyiB4FgFh4mnSPlhV
         Av8xNnIQhA8XVMVOweXMR1kd46uJu3Idmi2K6mLJYfjLlXRhOPmRl4/E5CLGvkjRfJMn
         YGyUDryn6gJvQkXRWFfOiHbBXWSuvxBn/5ARqEY9WmczjtMIQJ9cqkWvurCyLuhrNXa5
         K5ixqGDh34sFfs6SuhaAzggoB8grkREpDUkHMzZ2THNXld9w3fj+oRsueOMoYBdIGZrY
         YTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kmd1/9s1rQKDmAWfh67gx25yvlIQdWgrBPInzcXI9IU=;
        b=S+v8xKlmmt+OIrDiPzn2jBnbybJENyemFqTZ0YgliKKTadcZNrDiZDKnNTXH8rR9UF
         vUrAZVKDStnLbf87RaSdlzC35TWBTrITlOzpe7IPT9Y/ZaMvdhyosezo04MvljSy+kcH
         76lfVwc9KxMPk+aEJximwPC67p35oMWKV9jPpxCmodOGDKL3cfrDoIl2pJJayplyuC5J
         B72afdNa7J4dwGWRsAPJZTRKVSwcEsB8KooQv5Fsnnn/omc279dwqVTRJadPqhLCuIPx
         6uysGX+x3hAYwiujpw2xkfEslUziltlvvHWhjVfGPtvl5XLnACqN6rU3H05xoFds0ZQM
         JhAQ==
X-Gm-Message-State: ANoB5plPzyGj/MKeUZiZSrbUhbQyhxl2f7YMxdLJNBxE/zVvzgTQRlLA
        cIJXdo/qbccRa033A8QFuSY=
X-Google-Smtp-Source: AA0mqf51Ly7Qxba46zu9eSAUey7t43Wz3mUrGy+nVxL5FnRtWFBW0oJKe0bXPnNwGh2azjHGVfTlBQ==
X-Received: by 2002:a05:6000:86:b0:241:d5d8:b2f1 with SMTP id m6-20020a056000008600b00241d5d8b2f1mr10446616wrx.274.1669282973526;
        Thu, 24 Nov 2022 01:42:53 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm6637710wmq.36.2022.11.24.01.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 01:42:53 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 24 Nov 2022 10:42:51 +0100
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some
 tracepoints
Message-ID: <Y388m6wOktvZo1d4@krava>
References: <20221121213123.1373229-1-jolsa@kernel.org>
 <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 24, 2022 at 01:41:23AM +0100, Daniel Borkmann wrote:
> On 11/21/22 10:31 PM, Jiri Olsa wrote:
> > We hit following issues [1] [2] when we attach bpf program that calls
> > bpf_trace_printk helper to the contention_begin tracepoint.
> > 
> > As described in [3] with multiple bpf programs that call bpf_trace_printk
> > helper attached to the contention_begin might result in exhaustion of
> > printk buffer or cause a deadlock [2].
> > 
> > There's also another possible deadlock when multiple bpf programs attach
> > to bpf_trace_printk tracepoint and call one of the printk bpf helpers.
> > 
> > This change denies the attachment of bpf program to contention_begin
> > and bpf_trace_printk tracepoints if the bpf program calls one of the
> > printk bpf helpers.
> > 
> > Adding also verifier check for tb_btf programs, so this can be cought
> > in program loading time with error message like:
> > 
> >    Can't attach program with bpf_trace_printk#6 helper to contention_begin tracepoint.
> > 
> > [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> > [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
> > [3] https://lore.kernel.org/bpf/Y2j6ivTwFmA0FtvY@krava/
> > 
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   include/linux/bpf.h          |  1 +
> >   include/linux/bpf_verifier.h |  2 ++
> >   kernel/bpf/syscall.c         |  3 +++
> >   kernel/bpf/verifier.c        | 46 ++++++++++++++++++++++++++++++++++++
> >   4 files changed, 52 insertions(+)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index c9eafa67f2a2..3ccabede0f50 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1319,6 +1319,7 @@ struct bpf_prog {
> >   				enforce_expected_attach_type:1, /* Enforce expected_attach_type checking at attach time */
> >   				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
> >   				call_get_func_ip:1, /* Do we call get_func_ip() */
> > +				call_printk:1, /* Do we call trace_printk/trace_vprintk  */
> >   				tstamp_type_access:1; /* Accessed __sk_buff->tstamp_type */
> >   	enum bpf_prog_type	type;		/* Type of BPF program */
> >   	enum bpf_attach_type	expected_attach_type; /* For some prog types */
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index 545152ac136c..7118c2fda59d 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> >   			     struct bpf_reg_state *reg,
> >   			     enum bpf_arg_type arg_type);
> > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog);
> > +
> >   /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
> >   static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> >   					     struct btf *btf, u32 btf_id)
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 35972afb6850..9a69bda7d62b 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3329,6 +3329,9 @@ static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> >   		return -EINVAL;
> >   	}
> > +	if (bpf_check_tp_printk_denylist(tp_name, prog))
> > +		return -EACCES;
> > +
> >   	btp = bpf_get_raw_tracepoint(tp_name);
> >   	if (!btp)
> >   		return -ENOENT;
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index f07bec227fef..b662bc851e1c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7472,6 +7472,47 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
> >   				 state->callback_subprogno == subprogno);
> >   }
> > +int bpf_check_tp_printk_denylist(const char *name, struct bpf_prog *prog)
> > +{
> > +	static const char * const denylist[] = {
> > +		"contention_begin",
> > +		"bpf_trace_printk",
> > +	};
> > +	int i;
> > +
> > +	/* Do not allow attachment to denylist[] tracepoints,
> > +	 * if the program calls some of the printk helpers,
> > +	 * because there's possibility of deadlock.
> > +	 */
> 
> What if that prog doesn't but tail calls into another one which calls printk helpers?

right, I'll deny that for all BPF_PROG_TYPE_RAW_TRACEPOINT* programs,
because I don't see easy way to check on that

we can leave printk check for tracing BPF_TRACE_RAW_TP programs,
because verifier known the exact tracepoint already

thanks,
jirka

> 
> > +	if (!prog->call_printk)
> > +		return 0;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(denylist); i++) {
> > +		if (!strcmp(denylist[i], name))
> > +			return 1;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int check_tp_printk_denylist(struct bpf_verifier_env *env, int func_id)
> > +{
> > +	struct bpf_prog *prog = env->prog;
> > +
> > +	if (prog->type != BPF_PROG_TYPE_TRACING ||
> > +	    prog->expected_attach_type != BPF_TRACE_RAW_TP)
> > +		return 0;
> > +
> > +	if (WARN_ON_ONCE(!prog->aux->attach_func_name))
> > +		return -EINVAL;
> > +
> > +	if (!bpf_check_tp_printk_denylist(prog->aux->attach_func_name, prog))
> > +		return 0;
> > +
> > +	verbose(env, "Can't attach program with %s#%d helper to %s tracepoint.\n",
> > +		func_id_name(func_id), func_id, prog->aux->attach_func_name);
> > +	return -EACCES;
> > +}
> > +
> >   static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >   			     int *insn_idx_p)
> >   {
> > @@ -7675,6 +7716,11 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >   		err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> >   					set_user_ringbuf_callback_state);
> >   		break;
> > +	case BPF_FUNC_trace_printk:
> > +	case BPF_FUNC_trace_vprintk:
> > +		env->prog->call_printk = 1;
> > +		err = check_tp_printk_denylist(env, func_id);
> > +		break;
> >   	}
> >   	if (err)
> > 
> 
