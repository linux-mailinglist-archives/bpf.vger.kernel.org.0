Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AE85A62ED
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiH3MLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 08:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiH3MLO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 08:11:14 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DFFA6AE5
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 05:11:13 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id t5so13884544edc.11
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 05:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date;
        bh=c450vXD3gQ9mwolVi6I4OQx/0q0xvsx4IFeelm93Bxs=;
        b=LIVLfkjz75r5kPtWI4SETxpSYONiWlGJvhH28vsIhMz3w1YPCStFNdrmpBAaLzdURj
         OL6ATpf6IvYczMc6vEuPRCugKrcLF/6MPKjY5zPstgkV9zCjFdhDzhs10LP7cQYG/Fqs
         LfRCrwI+ASHPbYvni3WpzCjC+1I5Z2onJZIRrj79U0BLRKjr1I0AtchM87WBD2ORawEF
         fduCib/olgOaNBgMaUD2ObyVIHyq0dKuElfsYkkXeg0Btr185vOCqytwJWQVijfEB100
         bjv3wRZDT+nPT6jyJaSud4eXBzG2DYL7V8YkdEDOlovkm1ElxlT1tire9Dt0sKuk3NR1
         L0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date;
        bh=c450vXD3gQ9mwolVi6I4OQx/0q0xvsx4IFeelm93Bxs=;
        b=GMQO6NU7mYiOR4Nk5nw8Cx7f7KHXd0VE2YD+oJlIWN95GQz0/b/PBeBBPvFeA6jzwu
         GoNxyAEmVvibvup6/HaPU00i6J4ofcsjHfg4fnUc7C3FPMOv9FFKKw7/f/gMG/U2X9Ch
         PtbDPX75zR1c2sl7Gs3PT6R2i4azzeiVMKN5IL+Aw17AGzJevw8af2I2s1PHrPNCmbPX
         iz5XQDkvGJHyfXkvRMSrTUqaGc78TQVY+sFPDfWwNJo+JsIrqPXclY/cFy8CqgrwbF+S
         ePyO6zCBg59CW7h1NV5Wu9emzW0TzZaYOhJFcA7O089/d4Ps0eHD2iJ+359D3KaTPFwX
         WMCw==
X-Gm-Message-State: ACgBeo1cLR5cxNrVb7gnNBOVlXWinOR8pH+s042la81RnM58B/h8Sh80
        24SbxhIWtvv9sx7RMNnr2xk=
X-Google-Smtp-Source: AA6agR56z9RQv2HZnhRatK5KFYkeqSD/5VA1Dsal+9LwRkQFRdRIhXOCNelfDfXFE3GTLFVILPiW9g==
X-Received: by 2002:a05:6402:11cb:b0:43c:c7a3:ff86 with SMTP id j11-20020a05640211cb00b0043cc7a3ff86mr20478668edw.383.1661861471843;
        Tue, 30 Aug 2022 05:11:11 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id ku1-20020a170907788100b00738467f743dsm5694705ejc.5.2022.08.30.05.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 05:11:11 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 30 Aug 2022 14:11:09 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Allow struct argument in trampoline
 based programs
Message-ID: <Yw3+XcnFkT16Z3dx@krava>
References: <20220828025438.142798-1-yhs@fb.com>
 <20220828025443.143456-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828025443.143456-1-yhs@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 27, 2022 at 07:54:43PM -0700, Yonghong Song wrote:

SNIP

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 903719b89238..4a081bfb4c8a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5328,6 +5328,31 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
>  	return btf_type_is_int(t);
>  }
>  
> +static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
> +			   int off)
> +{
> +	const struct btf_param *args;
> +	const struct btf_type *t;
> +	u32 offset = 0, nr_args;
> +	int i;
> +
> +	nr_args = btf_type_vlen(func_proto);
> +	args = (const struct btf_param *)(func_proto + 1);
> +	for (i = 0; i < nr_args; i++) {
> +		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
> +		offset += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
> +		if (off < offset)
> +			return i;
> +	}
> +
> +	t = btf_type_skip_modifiers(btf, func_proto->type, NULL);
> +	offset += btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
> +	if (off < offset)
> +		return nr_args;
> +
> +	return nr_args + 1;
> +}
> +
>  bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  		    const struct bpf_prog *prog,
>  		    struct bpf_insn_access_aux *info)
> @@ -5347,7 +5372,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  			tname, off);
>  		return false;
>  	}
> -	arg = off / 8;
> +	arg = t == NULL ? (off / 8) :  get_ctx_arg_idx(btf, t, off);

is the t == NULL check needed? we relied on t being defined later in the code

jirka

>  	args = (const struct btf_param *)(t + 1);
>  	/* if (t == NULL) Fall back to default BPF prog with
>  	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
> @@ -5417,7 +5442,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  	/* skip modifiers */
>  	while (btf_type_is_modifier(t))
>  		t = btf_type_by_id(btf, t->type);
> -	if (btf_type_is_small_int(t) || btf_is_any_enum(t))
> +	if (btf_type_is_small_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
>  		/* accessing a scalar */
>  		return true;
>  	if (!btf_type_is_ptr(t)) {
> @@ -5881,7 +5906,7 @@ static int __get_type_size(struct btf *btf, u32 btf_id,
>  	if (btf_type_is_ptr(t))
>  		/* kernel size of pointer. Not BPF's size of pointer*/
>  		return sizeof(void *);
> -	if (btf_type_is_int(t) || btf_is_any_enum(t))
> +	if (btf_type_is_int(t) || btf_is_any_enum(t) || __btf_type_is_struct(t))
>  		return t->size;
>  	return -EINVAL;

SNIP
