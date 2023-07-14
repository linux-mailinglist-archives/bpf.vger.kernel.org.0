Return-Path: <bpf+bounces-5049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E143A754524
	for <lists+bpf@lfdr.de>; Sat, 15 Jul 2023 00:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43CA82812E2
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 22:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AB82772D;
	Fri, 14 Jul 2023 22:51:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6F2C80
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 22:51:53 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250F21989
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 15:51:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53482b44007so1551628a12.2
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689375111; x=1691967111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iPv7Xy98zfV90+bKc2zAmbRl2PoOgtmF33HF8qz//gk=;
        b=OtEIneHlUodjDBrXLAGpDzRYG3+Id5xBdugzB9prJ/LqBxHQXB4yswHY45UpqEFxuR
         K7GUKylsLPuldQ4b+lTSKiYHT+kZQpxBJi4lSs5DG8RNxF9DdVWHj6mAkqvFd7KvHwHy
         4cLeBY8hPo4JEhXSOWWNIRINqOpCZP/QLLFTxHOfcllTbsYIpEZ/3guPbhWdWHAB6GCI
         rB86eRwR5t3pMNUNNhi5eZlc8KdY9ORU8wygfEYhpD98Xt/qJQgsjWw+MhcjbL8xuiTX
         cy/M3imHNksdaCJgpESAQ4MUFCKBDHUvlXkozct1X+Tl4msslTVeX7R9LFDeXmedJ7YU
         RiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689375111; x=1691967111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPv7Xy98zfV90+bKc2zAmbRl2PoOgtmF33HF8qz//gk=;
        b=W3Wy94o2rjm6f436BfnwWZ1nj0Ubfh0k4Dllw6CLAzNvMtGRs3bwx3FZGL2nb//mx9
         mfDmI21ZEyfovHZG9Cyc0QT0o25eZGitGOyROlSCr8OABgZr3F8rWrGsWnCKPN5tFpZp
         AIQM9Fn1Yywt+HYSCUrDwW+qklWRhnn/b2D5oecqH3VuJ+CcLe7KGM2/+AbEymXSp81N
         M+jTz7whK3jcTqqAVEvyxrUGTPkuMrHAriDfXdLAa09iodP9UKChZtz66WS3lJlMpczl
         Ne9oktZ9tFNwd9WX9DEvJwiH43AEiZtqOotx8Y2K8Bp1iY6Ev0ndBVREpt1AvNDWMqfu
         tXGw==
X-Gm-Message-State: ABy/qLajPTguePK2KpeXzHmMpOtrOM2kK0EJWTw/yUlxNUeya66Ncwur
	CDt1ehZoIKrPPJ2UJkqhoYki+8o+HXM=
X-Google-Smtp-Source: APBJJlFkQdNnHlK0vGxIS+dvUfGQwcileMYP9RpbBsragW6ei09rDzAfr/iISdFvjizhmqU+3Ik+SQ==
X-Received: by 2002:a17:90a:7781:b0:263:f648:e6e1 with SMTP id v1-20020a17090a778100b00263f648e6e1mr4058073pjk.14.1689375111530;
        Fri, 14 Jul 2023 15:51:51 -0700 (PDT)
Received: from MacBook-Pro-8.local ([2620:10d:c090:400::5:2ff4])
        by smtp.gmail.com with ESMTPSA id i34-20020a17090a3da500b002676e973275sm1486521pjc.1.2023.07.14.15.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 15:51:51 -0700 (PDT)
Date: Fri, 14 Jul 2023 15:51:49 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 06/10] bpf: Implement bpf_throw kfunc
Message-ID: <20230714225149.f3uy4oimdi6a5etu@MacBook-Pro-8.local>
References: <20230713023232.1411523-1-memxor@gmail.com>
 <20230713023232.1411523-7-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713023232.1411523-7-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 08:02:28AM +0530, Kumar Kartikeya Dwivedi wrote:
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 209811b1993a..f1d7de1349bc 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -131,4 +131,10 @@ extern int bpf_rbtree_add_impl(struct bpf_rb_root *root, struct bpf_rb_node *nod
>   */
>  extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root *root) __ksym;
>  
> +__attribute__((noreturn))
> +extern void bpf_throw(u64 cookie) __ksym;
> +
> +#define throw bpf_throw(0)
> +#define throw_value(cookie) bpf_throw(cookie)

Reading the patch 10 I think the add-on value of these two macros is negative.
If it was open coded as bpf_throw(0); everywhere it would be easier to read imo.

