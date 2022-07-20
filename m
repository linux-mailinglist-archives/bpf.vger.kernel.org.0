Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7809157BC3E
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 19:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiGTREI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiGTREB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 13:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 802FD6BC27
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 10:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658336637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xuZtPMEGTJUPyCThBRbp89TRLDnOnODjmUD0CEahbP8=;
        b=Q6XktXoXa4nUgQUi4jupDYltJQ/YfWai51mn5joW/4d8iSHpBUHqs2p9w5JzaPC1VdUbH5
        On8OgO5y3rzR/eK23Vuav5sX58NtPY4ATRR7r8Uf3hag68aXm4Wx/BzuxgxUy6b/3ty9MP
        K9R/SCyW6BBOdm423xCeauHoHRk5ABE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-Wigm-e-oP2m3JXQvXV0BJA-1; Wed, 20 Jul 2022 13:03:56 -0400
X-MC-Unique: Wigm-e-oP2m3JXQvXV0BJA-1
Received: by mail-ed1-f70.google.com with SMTP id s17-20020a056402521100b0043ade613038so12538762edd.17
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 10:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xuZtPMEGTJUPyCThBRbp89TRLDnOnODjmUD0CEahbP8=;
        b=x3wFSywXLvYHne6R4D0yI01BzBPwKp156PJq8mu1tEoxqa5T4p9goRuL+msFIsluTz
         +I8wWNdYxnRm61PXWXdyDg8DDa0cO8j1DBNtSc0IYUXJU2B6cYJUthYH4Sk+hQFBV2di
         omqj2XWMS4kvEFeHWuXmQJajIyx8Hvb3vfo+Mdv17vSQANyeuKxfsWgVF0jjf4vnJ1bt
         WIdjMoiSc0cFjukw7B7r0PCSjVxtFlr4fCbBNrtMNXYKir72iKf4Y8IW9PkF/1olIVq6
         8RIgi7ypWmTNeJSUe5Db6E/+g1mdxDdBXm299uyBcY/rKMcfGC5JuSVEk7eVHTeNUZZk
         NPrw==
X-Gm-Message-State: AJIora8YYPH0rcWUS5/aNHVpdLA5tHfYXRV9TV0JXlaZjTwBdot9ZSnX
        UWJTAx4LyubMCQcAUCkEPCkbGjyscc84GrkwPzRkuP64v0UysKaCCIixnhHcwDz5D51bh9U9K7m
        uyg+3v7WH1Wkz
X-Received: by 2002:a17:907:7d8b:b0:72f:2306:329a with SMTP id oz11-20020a1709077d8b00b0072f2306329amr16924723ejc.369.1658336634572;
        Wed, 20 Jul 2022 10:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v8HK3Vlfjf43MlHI1Fad5ztpTBq9UeLWcrb3eFi6pmR6+PN79I0J3ji7iEf9BXw4FEHd/yNQ==
X-Received: by 2002:a17:907:7d8b:b0:72f:2306:329a with SMTP id oz11-20020a1709077d8b00b0072f2306329amr16924697ejc.369.1658336634208;
        Wed, 20 Jul 2022 10:03:54 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id w6-20020a50fa86000000b0043ba0cf5dbasm2875285edr.2.2022.07.20.10.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 10:03:53 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 38BC34DA0BE; Wed, 20 Jul 2022 19:03:52 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     KP Singh <kpsingh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 05/13] bpf: Add documentation for kfuncs
In-Reply-To: <20220719132430.19993-6-memxor@gmail.com>
References: <20220719132430.19993-1-memxor@gmail.com>
 <20220719132430.19993-6-memxor@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Jul 2022 19:03:52 +0200
Message-ID: <878ronu35z.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> As the usage of kfuncs grows, we are starting to form consensus on the
> kinds of attributes and annotations that kfuncs can have. To better help
> developers make sense of the various options available at their disposal
> to present an unstable API to the BPF users, document the various kfunc
> flags and annotations, their expected usage, and explain the process of
> defining and registering a kfunc set.

[...]

> +2.4.2 KF_RET_NULL flag
> +----------------------
> +
> +The KF_RET_NULL flag is used to indicate that the pointer returned by the kfunc
> +may be NULL. Hence, it forces the user to do a NULL check on the pointer
> +returned from the kfunc before making use of it (dereferencing or passing to
> +another helper). This flag is often used in pairing with KF_ACQUIRE flag, but
> +both are mutually exclusive.

That last sentence is contradicting itself. "Mutually exclusive" means
"can't be used together". I think you mean "orthogonal" or something to
that effect?

-Toke

