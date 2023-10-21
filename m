Return-Path: <bpf+bounces-12902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212907D1FDC
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 23:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AAF5B20E4F
	for <lists+bpf@lfdr.de>; Sat, 21 Oct 2023 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F1E210F1;
	Sat, 21 Oct 2023 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBmPN+E/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37B1EA6E
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:41:17 +0000 (UTC)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BFC9C
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 14:41:15 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a6a8c957ccso63525239f.3
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697924475; x=1698529275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX/+26FZoxbqhfvQJjSrin/6U0Pr2TOVk2i7kYpeMu8=;
        b=QBmPN+E/hn4TVmJc8aq8D6Pd5qpHyBzBeaFDCx8bDKe/1RXM/2b+Yp1Zz3CmnwQv8q
         TRi62cANUDYhjIasSeVmEpE8RoseYL5Zwp/vVnYnyFeAzs979oKasElg+t0IQMMZzFPq
         VbdNNr6kfHroHjfDcL7MD37SGnInpJVsx+q87lFSmIxCCORO1fq3IheQY753sE4pUCDu
         f1TeykKVfWsXhcTTMh9Q4jDeHYbKJlLMNa803tV/3f57FFkV5dIcM6obtxNVbS1qKoHg
         wo4LnrSi5abC0QrY1eGBM678l8BbkrmSsz4QYCBmPFnOtMB9lJ5e2QyfUl+/8g93x65Z
         wXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697924475; x=1698529275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX/+26FZoxbqhfvQJjSrin/6U0Pr2TOVk2i7kYpeMu8=;
        b=d2zPO6jcSG4lPyKqjVtbC0zbfCAnQjLUlUtHzQzMNPkE5Lblfp+9/LPpmB7L1b9mUd
         ZK81yaXuoZ0gEbMg4Uoi3PnTmtaUehxhvZ8hmHme7/LXvT9uHmykwzdiAJmA92kndaTA
         MDmMLV3TKsM5QcyCqfU2JenQyOfYLeOSDBCnhYiNB7c5HF0xKZZU/fSeX/2bq1SB2k8R
         ItaBkoYXlvH3YOryOxIP4g9EVONF6BDT1aO7FI3kLeIroOgmlrP5UD1jz1qtsAK5QjvV
         zH6rgAJxwD+cnAMWkFYgUa4WPrm8VWNt5nlUa2c2pgkbZhzA8qkY/ua45Rw3DlXYyRpf
         MRYQ==
X-Gm-Message-State: AOJu0YxHor8NpeTxy+yzt6x+SrWetzPeZhqNzSP7wUiA3Mz+ckD1lhJZ
	2ugDIfo1ITdTPL5CL5TYQs2GPNSRXlc=
X-Google-Smtp-Source: AGHT+IFIkWnWLL6MWE1WrQLB6pPnrTRYzFLqhgWi5mO9HSa5Cgs8YfWXQxhYlc2c2nPWMhofwPY54Q==
X-Received: by 2002:a05:6e02:1c2b:b0:34f:70ec:d4cf with SMTP id m11-20020a056e021c2b00b0034f70ecd4cfmr7444868ilh.8.1697924474829;
        Sat, 21 Oct 2023 14:41:14 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:8b66])
        by smtp.gmail.com with ESMTPSA id 63-20020a17090a09c500b00262eb0d141esm3792431pjo.28.2023.10.21.14.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 14:41:14 -0700 (PDT)
Date: Sat, 21 Oct 2023 14:41:10 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com,
	john.fastabend@gmail.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: exact states comparison for iterator
 convergence checks
Message-ID: <20231021214110.cpgk32tqaerzbvbe@MacBook-Pro-49.local>
References: <20231021005939.1041-1-eddyz87@gmail.com>
 <20231021005939.1041-2-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021005939.1041-2-eddyz87@gmail.com>

On Sat, Oct 21, 2023 at 03:59:35AM +0300, Eduard Zingerman wrote:
>  
> +static struct bpf_verifier_state_list **__explored_state(struct bpf_verifier_env *env,
> +							 int idx,
> +							 int callsite);
...
> +static struct bpf_verifier_state *find_prev_entry(struct bpf_verifier_env *env,
> +						  struct bpf_verifier_state *cur,
> +						  int insn_idx)
> +{
> +	struct bpf_verifier_state_list *sl;
> +	struct bpf_verifier_state *st;
> +
> +	/* Explored states are pushed in stack order, most recent states come first */
> +	sl = *__explored_state(env, insn_idx, cur->frame[cur->curframe]->callsite);
...
> +		prev_st = find_prev_entry(env, cur_st->parent, insn_idx);
...
> +static struct bpf_verifier_state_list **__explored_state(struct bpf_verifier_env *env,
> +							 int idx,
> +							 int callsite)
> +{
> +	return &env->explored_states[(idx ^ callsite) % state_htab_size(env)];
> +}
> +
>  static struct bpf_verifier_state_list **explored_state(
>  					struct bpf_verifier_env *env,
>  					int idx)
> @@ -15032,7 +15161,7 @@ static struct bpf_verifier_state_list **explored_state(
>  	struct bpf_verifier_state *cur = env->cur_state;
>  	struct bpf_func_state *state = cur->frame[cur->curframe];
>  
> -	return &env->explored_states[(idx ^ state->callsite) % state_htab_size(env)];
> +	return __explored_state(env, idx, state->callsite);
>  }

Do we really need to introduce this new helper?
I suspect the concern was that cur->callsite != cur->parent->callsite, right?
But that can never be the case, since bpf_iter_num_next() is force checkpoint,
so inside process_iter_next_call() cur_st->parent is guaranteed to be from
the same function and callsites will be the same.
I can undo above and replace with a warn_on (or with a comment) while applying?

