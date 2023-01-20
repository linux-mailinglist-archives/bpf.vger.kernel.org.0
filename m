Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDB4674D33
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 07:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjATGUu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 01:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjATGUs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 01:20:48 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40081999
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 22:20:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d8so4666050pjc.3
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 22:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNLLJ2yMqB9EbH8HGRIj3W+NQ9L4lYYvUBsP/+K74MY=;
        b=ZgigrVuMGITqo3vZpgAoW7dbT9E4B62Tn2AT06xgb6OO05Iyt/QjknFs2678uMUu3b
         LGw4QDOrIJ7GX3+yU5DtVAaqOrMk2RuuWWr7pW9m35nmstQBGMPqR6/EROwBvN8gbTf/
         2EAm6RTUYFOlnIhUO5biQvgC/2yTtYqIaNatTyoQq45q2GxGHJPseko7GDPfC1AYTvaa
         9dCa8iwPV1iBapJu2c8roqLXY0X+OLNdEDwiHNd/AuGE8zZbGKuhuA28cwqdzzmn6jb5
         PkPDTkdNRAJc0AmTm3hM8eXo4PWFS5jE0mKC/LQ4TNbBe/Ep+kQfec3k7YM8l/UO3a05
         5pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNLLJ2yMqB9EbH8HGRIj3W+NQ9L4lYYvUBsP/+K74MY=;
        b=zDG8PBIOXUQhs8hY0nEdBddF+gD5kncyfjdqV8RqEMH5ZXx8xL/QHX0MfXSSgSP0jO
         MY+n36mPCkRkA2WK7W+UNoQ8h/svnhZnJEj7tDUKeMGJwHWfcDNSxIq99INOGkh7cW2n
         GH8K7wPGF7RPhqizpoZsiCuqDMLKNCPG9adfsc8UeOJq6+94OcFbca5MHlmNAtOVUoed
         vml3QpXbkRDUm7m2RKLkDvQE9+um081n0zK0zC0X3RvO51WLLhDlF0IhokzMgnyzDat6
         ssMpU4ayHC6Br4awxIeJg3OQglGryS49o6qLITQB+9mh9mMwlqwfHusJ0aRmzNZ/y7v2
         g3cg==
X-Gm-Message-State: AFqh2kooIMFrYzBbTljKvVUeMucuDwtvuP8ZqVcjfW39izAVDPW4+DJw
        YZSmjpOn60/qgWQNHpalUSk=
X-Google-Smtp-Source: AMrXdXsY67TLFJVg131tUFnWYSKnrBc06Tq3gaAsTzKwdsWaB1PO5yVvTilkIn1AhMdnAyFdXwCQ/Q==
X-Received: by 2002:a17:902:cf08:b0:192:c125:ac2f with SMTP id i8-20020a170902cf0800b00192c125ac2fmr15791113plg.8.1674195644428;
        Thu, 19 Jan 2023 22:20:44 -0800 (PST)
Received: from MacBook-Pro-6.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:186c])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902b19500b00189e1522982sm26134757plr.168.2023.01.19.22.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 22:20:43 -0800 (PST)
Date:   Thu, 19 Jan 2023 22:20:41 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v3 09/12] selftests/bpf: Add dynptr pruning tests
Message-ID: <20230120062041.x7aylmmpmnoh4igx@MacBook-Pro-6.local.dhcp.thefacebook.com>
References: <20230120034314.1921848-1-memxor@gmail.com>
 <20230120034314.1921848-10-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120034314.1921848-10-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 20, 2023 at 09:13:11AM +0530, Kumar Kartikeya Dwivedi wrote:
> +
> +SEC("?tc")
> +__failure __msg("cannot overwrite referenced dynptr") __log_level(2)
> +int dynptr_pruning_overwrite(struct __sk_buff *ctx)
> +{
> +	asm volatile (
> +		"r9 = 0xeB9F;"
> +		"r6 = %[ringbuf] ll;"
> +		"r1 = r6;"
> +		"r2 = 8;"
> +		"r3 = 0;"
> +		"r4 = r10;"
> +		"r4 += -16;"
> +		"call %[bpf_ringbuf_reserve_dynptr];"
> +		"if r0 == 0 goto pjmp1;"
> +		"goto pjmp2;"
> +	"pjmp1:"
> +		"*(u64 *)(r10 - 16) = r9;"
> +	"pjmp2:"
> +		"r1 = r10;"
> +		"r1 += -16;"
> +		"r2 = 0;"
> +		"call %[bpf_ringbuf_discard_dynptr];"

It should still work if we remove "" from every line, right?
Would it be easier to read?
