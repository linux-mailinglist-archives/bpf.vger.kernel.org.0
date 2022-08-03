Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE11588B90
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiHCLx0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 07:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiHCLxZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 07:53:25 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1183D52DD6;
        Wed,  3 Aug 2022 04:53:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s11so9726776edd.13;
        Wed, 03 Aug 2022 04:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=dVRwnsNMnOYJckQWDK5xgonq5VH7gkOUwS9vzXnM4DI=;
        b=qv6TNw/3fHjpTQsNXD0WDM24R/VcTQrWx6DriR7ujWszATa1w7GDadABC5f4VFUxRt
         USkxDcaqNbRFE6bNeAG29cQVQEb2Xe9ztaZ7EjM9gtbgpL53SfCmsCesH2NGExRr3VmG
         EnD44ZAFOOftMye+FZkGZ4c0egbXqiYSa5lY/pPPudOjQZpX+XQp7RIIdMF468BU+iom
         /tRktxSqrKDgJ+IRaUxqR8FlYzKVHG2/E/7+9k7l4MtZiZZGfstuhtRdTTUyU80aPzZh
         A7gVBMabCBeQ5RpEOL4g31zv6TP3Y+8gqRJMrwuqlWM6yJacYL2xvJww4ZiIWZyTmPfw
         N65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=dVRwnsNMnOYJckQWDK5xgonq5VH7gkOUwS9vzXnM4DI=;
        b=QKuwL8ZeD5Y2j04FmC9921i5CY0Tm8SOoubLv2I68gNy5y6XVw2o72R69kNbx5vsEC
         trVRTpaT+92oiK+fs2lycp0DqlEwMY0847ULhOPBs3hY3znGU2CNIXv9UC0ICodghJcI
         aXH0Jg6DThb/6MRDzgGC2e3+o0fpOp5DAvKEC0GeCd9J8CY5B6rKusS9LmQtQgXuw66P
         AcUanZu49Cj6qt4vYlk0GD7BMT6ofLTUf53MwraelFksScB+kquauZpWkNUU7c+intEH
         XxjG8l/R3ZNJYj3u70rZHAi4X7hLkif9joMRCgQBK316/9zYNa+8xP9Slr9RFfcFSWbn
         IXtQ==
X-Gm-Message-State: AJIora9LfnoUQQ/XtWF1K6Y6dZxlX3s5ILIiyBJyF5Dnj/O2698Zci79
        fCyO/1W8KSoMIGed76JvKcI=
X-Google-Smtp-Source: AGRyM1tRlN6DJCNriK6MrogbG4FJfcxJXiuRzM0qe1VJ5Az2hhnmKs33twKB7KoOePr0YtTjXFFsTA==
X-Received: by 2002:a05:6402:240d:b0:43b:c41d:b0e0 with SMTP id t13-20020a056402240d00b0043bc41db0e0mr24812106eda.318.1659527602642;
        Wed, 03 Aug 2022 04:53:22 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b006fe8b456672sm7200321eju.3.2022.08.03.04.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 04:53:22 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 3 Aug 2022 13:53:20 +0200
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
Message-ID: <YuphsM7BVKfN+0ro@krava>
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

> -	err = seq->op->show(seq, p);
> -	if (err > 0) {
> -		/* object is skipped, decrease seq_num, so next
> -		 * valid object can reuse the same seq_num.
> -		 */
> -		bpf_iter_dec_seq_num(seq);
> -		seq->count = 0;
> -	} else if (err < 0 || seq_has_overflowed(seq)) {
> -		if (!err)
> -			err = -E2BIG;
> -		seq->op->stop(seq, p);
> +	err = do_seq_show(seq, p, 0);
> +	if (err < 0) {
> +		do_seq_stop(seq, p, 0);
>  		seq->count = 0;
>  		goto done;
>  	}
> @@ -153,7 +208,7 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
>  		num_objs++;
>  		offs = seq->count;
>  		p = seq->op->next(seq, p, &seq->index);
> -		if (pos == seq->index) {
> +		if (unlikely(pos == seq->index)) {
>  			pr_info_ratelimited("buggy seq_file .next function %ps "
>  				"did not updated position index\n",
>  				seq->op->next);
> @@ -161,7 +216,7 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
>  		}
>  
>  		if (IS_ERR_OR_NULL(p))
> -			break;
> +			goto stop;

we could still keep the break here

>  
>  		/* got a valid next object, increase seq_num */
>  		bpf_iter_inc_seq_num(seq);
> @@ -172,22 +227,16 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
>  		if (num_objs >= MAX_ITER_OBJECTS) {
>  			if (offs == 0) {
>  				err = -EAGAIN;
> -				seq->op->stop(seq, p);
> +				do_seq_stop(seq, p, seq->count);
>  				goto done;
>  			}
>  			break;
>  		}
>  
> -		err = seq->op->show(seq, p);
> -		if (err > 0) {
> -			bpf_iter_dec_seq_num(seq);
> -			seq->count = offs;
> -		} else if (err < 0 || seq_has_overflowed(seq)) {
> -			seq->count = offs;
> +		err = do_seq_show(seq, p, offs);
> +		if (err < 0) {
>  			if (offs == 0) {
> -				if (!err)
> -					err = -E2BIG;
> -				seq->op->stop(seq, p);
> +				do_seq_stop(seq, p, seq->count);
>  				goto done;
>  			}
>  			break;
> @@ -197,30 +246,11 @@ static ssize_t bpf_seq_read(struct file *file, char __user *buf, size_t size,
>  			cond_resched();
>  	}
>  stop:
> -	offs = seq->count;
> -	/* bpf program called if !p */
> -	seq->op->stop(seq, p);
> -	if (!p) {
> -		if (!seq_has_overflowed(seq)) {
> -			bpf_iter_done_stop(seq);
> -		} else {
> -			seq->count = offs;
> -			if (offs == 0) {
> -				err = -E2BIG;
> -				goto done;
> -			}
> -		}
> -	}
> -
> -	n = min(seq->count, size);
> -	err = copy_to_user(buf, seq->buf, n);
> -	if (err) {
> -		err = -EFAULT;
> +	err = do_seq_stop(seq, p, seq->count);
> +	if (err)
>  		goto done;

looks like we tried to copy the data before when stop failed,
now it's skipped

jirka

> -	}
> -	copied = n;
> -	seq->count -= n;
> -	seq->from = n;
> +
> +	err = do_copy_to_user(seq, buf, size, &copied);
>  done:
>  	if (!copied)
>  		copied = err;
> -- 
> 2.37.1.455.g008518b4e5-goog
> 
