Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70D8674CEB
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjATF7O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjATF7N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:59:13 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8C0EF8F;
        Thu, 19 Jan 2023 21:59:12 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v23so4486118plo.1;
        Thu, 19 Jan 2023 21:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtnXlmTpuc06EMMN7aGW2IlZGwG+DgNxDWRhTtH1Re8=;
        b=kgpNi+jm296fYI3NfSQzo8YYhvoSww5NhWWGEc2nKkXV4x9aqG9sh8RAk6TnBKwGEt
         Uq1SjlFfVAUxh6XKQZDUlqksnDk2EELfLO+cQ9IpI6sbfng0rUX9BWu0zFq02N+PMfiP
         dVpWeuzMwLJoKmAqw5BK1f8EYetZo4biRnSPCyIaHGtXBIIjBVcv5CCGPsQs0ogMH4IL
         ZOCcs1hQpH3wjPBbUAtH/sPPOLSYYi052WHj9auNJWFiVth2IQYeebvV+zDKnA40Et97
         EJQ3PA7KNKK6yCqX9mymtRmq/p0+wgFv1GiX+e+fPjQxRIo4cy1lXXeNmS6kZ9AYAxn1
         cs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtnXlmTpuc06EMMN7aGW2IlZGwG+DgNxDWRhTtH1Re8=;
        b=jav/p9HbGa2BP9fYRFt/BOcJV4vDbbsCCcebnZKBUgL/lnHoVlf5tRXeWU0MM0X45/
         3OZHfmyeYRZzPbsi2DKpdHx/rpo/PcNhv71smRauQBp/9wZI+yKTMLRhL8wyzIAXgkWG
         yBB67s64+qxJPttVQGLhzwNVsdf0NO88edlUeOLNzbQWOq/ecOhVJAD28x5MSaR1Lb/V
         lVY2tR0lwZcuBoo8Cy7RTLehuhwSvWr/rFhJPgE7OlDnbha1C3XUc9HuV6BaBrgNv251
         GWplN9EXkrfJv2CboQzV9bCz2c7G+0nFVIzMlUunZ/cgGlbNenLgjKdUgvwxuA7VNf1F
         jMGQ==
X-Gm-Message-State: AFqh2kqwoPLIbwewvx73vrrbCNY1r7D1PcdT6lS+1elDKHkTuUlBEPQ/
        RKXrn5btD666ubMs4FmXeKo=
X-Google-Smtp-Source: AMrXdXt9Av6xCBCR93tx05BLDhKhEv4i8QUv6LxNawaF18SnmrH3JHXQLeFWRQoUUjL2GbdPxn+72w==
X-Received: by 2002:a17:902:9002:b0:194:9c02:7619 with SMTP id a2-20020a170902900200b001949c027619mr14595690plp.29.1674194350123;
        Thu, 19 Jan 2023 21:59:10 -0800 (PST)
Received: from MacBook-Pro-6.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:186c])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001708c4ebbaesm12757237pli.309.2023.01.19.21.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:59:09 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:59:06 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 7/8] bpf/docs: Document cpumask kfuncs in a new
 file
Message-ID: <20230120055906.m4pkchwawfxhj6ze@MacBook-Pro-6.local.dhcp.thefacebook.com>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-8-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119235833.2948341-8-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 05:58:32PM -0600, David Vernet wrote:
> +
> +For example:
> +
> +.. code-block:: c
> +
> +	/**
> +	 * A trivial example tracepoint program that shows how to
> +	 * acquire and release a struct bpf_cpumask *.
> +	 */
> +	SEC("tp_btf/task_newtask")
> +	int BPF_PROG(task_acquire_release_example, struct task_struct *task, u64 clone_flags)
> +	{
> +		struct bpf_cpumask *cpumask, *acquired;
> +
> +		cpumask = bpf_cpumask_create();
> +		if (!cpumask)
> +			return 1;
> +
> +		acquired = bpf_cpumask_acquire(cpumask);
> +		bpf_cpumask_release(cpumask);
> +		bpf_cpumask_acquire(acquired);
> +
> +		return 0;
> +	}

As the first example in the doc it was... alarming :)
I've read it as it says that bpf_cpumask_acquire has to be called on
freshly created cpumask before it can be used.
I've started to doubt by code reading skills of the previous patches :)
A basic example is probably necessary to introduce the concept.
Or this example should have bpf_cpumask_set_cpu right after create and
more alu ops after release with comments to demonstrate the point.
