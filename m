Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB566DA6AA
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 02:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDGAmT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 20:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDGAmT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 20:42:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D2C7ED5
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 17:42:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i9so41089859wrp.3
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 17:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680828136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv9/YkMS1Y89YBMKwXLS0dQH+hDDsRT1WZtJmMWtgxc=;
        b=ormS9Py+VnsScer1pneIe6Za4gW7iKFTdXe120yIBe3C75SeiInTyu4/dbNOjSamBZ
         Or6MXFeD026cHVoDtuNiij27AlBcnp92dT1RmuDQdKZ8NYbd0GzWXHe/3N3t2vH8ShCs
         UsgRtS/+qFjsdCA4pt9WOliK2JrixAZ7JdkOMet2rcFt0x1djDWtHGWW7f1ieyAH+JG3
         SVYbFD/3+L8WjTj0/AfX9DJ7TcUAceoo5TEjtbsrVdY5HSnkzqrsHsfrzMhoEkW/U4IS
         lxvUCfatiAFHC2vFJZbl21yN9nxpJBHHKlzg9OiIX0pPZcwqVAkCOATMEbwmrMzBW6Ih
         HzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680828136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv9/YkMS1Y89YBMKwXLS0dQH+hDDsRT1WZtJmMWtgxc=;
        b=pPL1L5awqbijGboWfJlutb9iy531UDOBMua6ZK0jq44peOeLQ+wRw0idcbqrEJqdvd
         47LdoZdtgaE9yarM6dJI/7YqiMX8IqQ2YJoe228mo7pGMlFH8ItXT3j9PZwDrMeXXBXh
         ZUTm1teEjKFJq5gX7UGagLwDdQzXsvPOc1dO36SpuAg1f+VqhqmHahKeUyGD5KQei4bs
         SCCPLWzhfx+sNszOOj/TFQNbZBqdH5YIVYLmg27hMBg7xKbSMRoG4XfLgt1j6tDD9Qrj
         5uwsBVD9Z4nLYJsexxtTvscZuegvVv8P+l/0+RhvcPh6MfzkuybyqL0P6yk0ySpfEBfn
         a3bg==
X-Gm-Message-State: AAQBX9eHlhWvPNfOgkkJlEBOfsNcaVC5dJTnI7Jv4lxacD3x89mEz6Z2
        jo8dgvc8jk3BwzlzL6BS81xhPvi95fERFg==
X-Google-Smtp-Source: AKy350YFwuU2AmAKR9K+JuKzJLwAYgDhNFU75LXucMXRQ3KmIPg/JUeK7XohX9lcW7Rd6PFrFytX/g==
X-Received: by 2002:a5d:40c3:0:b0:2c7:e5f:e0e0 with SMTP id b3-20020a5d40c3000000b002c70e5fe0e0mr34008wrq.65.1680828135953;
        Thu, 06 Apr 2023 17:42:15 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id t1-20020a05600001c100b002d51d10a3fasm3031567wrx.55.2023.04.06.17.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:42:15 -0700 (PDT)
Date:   Fri, 7 Apr 2023 02:42:14 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 9/9] selftests/bpf: Add tests for BPF
 exceptions
Message-ID: <qcyhnf2nmjyb6yjaqpibv2q6m4tqr63ftxmwuua3k6efjpx77u@5gohye433ufp>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-10-memxor@gmail.com>
 <20230406023809.jffvgx5r7eyjw24g@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406023809.jffvgx5r7eyjw24g@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 06, 2023 at 04:38:09AM CEST, Alexei Starovoitov wrote:
> On Wed, Apr 05, 2023 at 02:42:39AM +0200, Kumar Kartikeya Dwivedi wrote:
> > +static __noinline int throwing_subprog(struct __sk_buff *ctx)
> > +{
> > +	if (ctx)
> > +		bpf_throw();
> > +	return 0;
> > +}
> > +
> > +__noinline int global_subprog(struct __sk_buff *ctx)
> > +{
> > +	return subprog(ctx) + 1;
> > +}
> > +
> > +__noinline int throwing_global_subprog(struct __sk_buff *ctx)
> > +{
> > +	if (ctx)
> > +		bpf_throw();
> > +	return 0;
> > +}
> > +
> > +static __noinline int exception_cb(void)
> > +{
> > +	return 16;
> > +}
> > +
> > +SEC("tc")
> > +int exception_throw_subprog(struct __sk_buff *ctx)
> > +{
> > +	volatile int i;
> > +
> > +	exception_cb();
> > +	bpf_set_exception_callback(exception_cb);
> > +	i = subprog(ctx);
> > +	i += global_subprog(ctx) - 1;
> > +	if (!i)
> > +		return throwing_global_subprog(ctx);
> > +	else
> > +		return throwing_subprog(ctx);
> > +	bpf_throw();
> > +	return 0;
> > +}
> > +
> > +__noinline int throwing_gfunc(volatile int i)
> > +{
> > +	bpf_assert_eq(i, 0);
> > +	return 1;
> > +}
> > +
> > +__noinline static int throwing_func(volatile int i)
> > +{
> > +	bpf_assert_lt(i, 1);
> > +	return 1;
> > +}
>
> exception_cb() has no way of knowning which assert statement threw the exception.
> How about extending a macro:
> bpf_assert_eq(i, 0, MY_INT_ERR);
> or
> bpf_assert_eq(i, 0) {bpf_throw(MY_INT_ERR);}
>
> bpf_throw can store it in prog->aux->exception pass the address to cb.
>

I agree and will add passing of a value that gets passed to the callback
(probably just set it in the exception state), but I don't think prog->aux will
work, see previous mails.

> Also I think we shouldn't complicate the verifier with auto release of resources.
> If the user really wants to assert when spin_lock is held it should be user's
> job to specify what resources should be released.
> Can we make it look like:
>
> bpf_spin_lock(&lock);
> bpf_assert_eq(i, 0) {
>   bpf_spin_unlock(&lock);
>   bpf_throw(MY_INT_ERR);
> }

Do you mean just locks or all resources? Then it kind of undermines the point of
having something like bpf_throw IMO. Since it's easy to insert code from the
point of throw but it's not possible to do the same in callers (unless we add a
way to 'catch' throws), so it only works for some particular cases where callers
don't hold references (or in the main subprog).

There are also other ways to go about this whole thing, like having the compiler
emit calls to instrinsics which the BPF runtime provides (or have the call
configurable through compiler switches), and it already emits the landing pad
code to release stuff and we simply receive the table of pads indexed by each
throwing instruction, perform necessary checks to ensure everything is actually
released correctly when control flow goes through them (e.g. when exploring
multiple paths through the same instruction), and unwind frame by frame. That
reduces the burden on both the verifier and user, but then it would be probably
need to be BPF C++, or have to be a new language extension for BPF C. E.g. there
was something about defer, panic, recover etc. in wg14
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2542.pdf . Having the compiler
do it is also probably easier if we want 'catch' style handlers.
