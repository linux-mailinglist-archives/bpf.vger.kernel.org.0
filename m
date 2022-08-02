Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA613587B6A
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 13:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbiHBLPG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 07:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiHBLO4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 07:14:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71CD51429;
        Tue,  2 Aug 2022 04:14:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i13so17148671edj.11;
        Tue, 02 Aug 2022 04:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=Q2ZorbTmwuDDxNcSA+CRBMBDw68FJCVnA16N7n1OJ/A=;
        b=GcVjzh0/p/KZxLPeq9Lz5V9KkQ42dJ5jDt3hPxamKoboGjTcWIZzyWnJsflK2gDYLG
         5U8G9FdO3l+Gp2VJb0vhMjbmtvXE4xfmjUcybdMpAw6PHSqqZWOCkEuIzgSJsNJcKLTc
         oCpbLjQEsyYroswpxkE2M3KeQVi8Q++wZUcUjrbMpFV+yoKLptXNx43WPtWhpmWxz6jB
         b33HyGAnSgnzBAApBZwqbYlYfxNkYZeB/JJK5BBtoA70UTiqPLP4Oop4GQxvsPRVfOy9
         wMFvMItd8yiNBtH4NEwjuv2QeU7z1Zl9YrpKb2IgqduySvRnbp5ZjrGXid1hq12IlkYW
         qRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=Q2ZorbTmwuDDxNcSA+CRBMBDw68FJCVnA16N7n1OJ/A=;
        b=EAfWSu1jD7WPmtGdFQU6lQCNu33KujoL9FHCCZLJjx9W63QUFtPE5YDWVhAKuChTJc
         XvTekF7WTexzA66gQduN5cFQ5pX2AmtXZ5pjlgR4j5uGHu3/XLdM5CKJSkUpMIxfKkXU
         /3jWtdHjUqmDW3oKy4BaXdeWnjxdZIvNIVn4ebwPB0bGQ1x/AMUOpT/cZnA20vmI0k6S
         Yj/TmHEVlIhiyUGKQO8OAYui0yoOSuOwvpaJRiMESomQNpBWAf3ts/4EL6xpYcMhsX09
         Rx+PCV0yg8npSnThmNqVP19usHuz+0isBXa4eg6L2c8xIKha+izt3ZouBcb/lmxoaVf3
         uuZA==
X-Gm-Message-State: ACgBeo1AgVtg9+r7AxUxj/zjjJlJh0W8Vehx6sPSeOsj/gtkF6/7TaLB
        MRxYmoY5LMbcUeOTTptcZfO9nUbh4dUlyA==
X-Google-Smtp-Source: AA6agR5UcuaS8vPj9XcBz003e15FHdv+aI5UwWD92shAWBxTd8rRwTZEqw39EWLljnGhUdgQ0+OIJg==
X-Received: by 2002:a05:6402:14b:b0:43d:a7dd:4376 with SMTP id s11-20020a056402014b00b0043da7dd4376mr8621228edu.89.1659438879075;
        Tue, 02 Aug 2022 04:14:39 -0700 (PDT)
Received: from krava ([83.240.61.12])
        by smtp.gmail.com with ESMTPSA id kx6-20020a170907774600b00724261b592esm6138051ejc.186.2022.08.02.04.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 04:14:38 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 2 Aug 2022 13:14:36 +0200
To:     Hao Luo <haoluo@google.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf-next v1] bpf, iter: clean up bpf_seq_read().
Message-ID: <YukHHCF0DA6Xb/Rf@krava>
References: <20220801205039.2755281-1-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801205039.2755281-1-haoluo@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 01, 2022 at 01:50:39PM -0700, Hao Luo wrote:

SNIP

> +static int do_seq_show(struct seq_file *seq, void *p, size_t offs)
> +{
> +	int err;
> +
> +	WARN_ON(IS_ERR_OR_NULL(p));
> +
> +	err = seq->op->show(seq, p);
> +	if (err > 0) {
> +		/* object is skipped, decrease seq_num, so next
> +		 * valid object can reuse the same seq_num.
> +		 */
> +		bpf_iter_dec_seq_num(seq);
> +		seq->count = offs;
> +		return err;
> +	}
> +
> +	if (err < 0 || seq_has_overflowed(seq)) {
> +		seq->count = offs;
> +		return err ? err : -E2BIG;
> +	}
> +
> +	/* err == 0 and no overflow */
> +	return 0;
> +}
> +
> +/* do_seq_stop, stops at the given object 'p'. 'p' could be an ERR or NULL. If
> + * 'p' is an ERR or there was an overflow, reset seq->count to 'offs' and
> + * returns error. Returns 0 otherwise.
> + */
> +static int do_seq_stop(struct seq_file *seq, void *p, size_t offs)
> +{
> +	if (IS_ERR(p)) {
> +		seq->op->stop(seq, NULL);
> +		seq->count = offs;

should we set seq->count to 0 in case of error?

jirka

> +		return PTR_ERR(p);
> +	}
> +
> +	seq->op->stop(seq, p);
> +	if (!p) {
> +		if (!seq_has_overflowed(seq)) {
> +			bpf_iter_done_stop(seq);
> +		} else {
> +			seq->count = offs;
> +			if (offs == 0)
> +				return -E2BIG;
> +		}
> +	}
> +	return 0;
> +}
> +
>  /* maximum visited objects before bailing out */
>  #define MAX_ITER_OBJECTS	1000000
>  

SNIP
