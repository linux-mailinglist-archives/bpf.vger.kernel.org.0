Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AE06D8D64
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 04:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjDFCVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 22:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFCVn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 22:21:43 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12476E88
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 19:21:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c18so36205222ple.11
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 19:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680747702; x=1683339702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eJk2CWqkHXNgp2U19DHK07M3KAxmLzB3PNq1IBndbI=;
        b=f05yQ3O4R5fNJpG4Eg0U2ZkugtL6yBl/vgXePTYP8VLIF6uQb130HRIBRcrYHQ0Ab5
         +unhpuNnSqehXgiEuzW0lEtZMaCdQL5LJW3S6SuVNARlNCzW9W8i5diXsdcY9c1LVJzL
         j71s/atP5yVeMCXIrnNFJ0/hb3/l+jQrJkc0/eyym3mlEWO/4b8RvzSimngfDTKQTeWw
         vxvfMqCd3z/3TZboc9l1lPPNlP7bhi1jQTw9DbuEJkMNveR8lFF9z/w5uCi4GZcB68zc
         dDj54yEqipdBEsoQtYG4P8XQtYiUuDGyF0H2EQMiMQVO7JdYjAOLYpyjni8YcVdgaR96
         wzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680747702; x=1683339702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eJk2CWqkHXNgp2U19DHK07M3KAxmLzB3PNq1IBndbI=;
        b=VJ51fTbHYYrmW+pvoznb8XGtqxAN+xMJgSBtGQW7Nd4qQEsfc3dDsK0vpgl/jDhU7A
         Xh0M40U74gdE2PlhH1utWrzPjZeYu4n08FxOfMJ3B8GVbBEQ5+7dK6LeQBzHxCiYF91H
         Mv5F8yCDoJAhe7M6h6P00ST5TVbUlHKCnfQhut5mpYHtD3gDKYAjAwBWKMZa1XPFp+/p
         4REZFbVY2GDUNOlLQ88DuE0GVgM0zdBMfF4gaLrIeOc3Sx8T4Mc8dlJNNrK7u0jk2oU4
         cAJlmKldkceVcfcWke1irxMsXOSUaIRJh9MmdZ4kIXjHaBD83ESmaonowA5c4UEEgYMq
         S7IQ==
X-Gm-Message-State: AAQBX9dS23ok2Qv4EBNtZa5YtDC9dKJCRAc6egXjRRtNdH741aNzPW+d
        068PIytKIGdQSFktp/aEQg5qdiWQZ6w=
X-Google-Smtp-Source: AKy350YkXC3w9+51Yo29jOKgtuJlRPVQS5TnnoTcuw4DvCRg/639K4dImkdULRQgiW7TAWRMJyzTyQ==
X-Received: by 2002:a05:6a20:7b2a:b0:e7:c39a:8826 with SMTP id s42-20020a056a207b2a00b000e7c39a8826mr1276585pzh.10.1680747702023;
        Wed, 05 Apr 2023 19:21:42 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:f79f])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79243000000b0062e12f945adsm67036pfp.135.2023.04.05.19.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:21:41 -0700 (PDT)
Date:   Wed, 5 Apr 2023 19:21:39 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 4/9] bpf: Handle throwing BPF callbacks
 in helpers and kfuncs
Message-ID: <20230406022139.75rkbl4xbwpn4qmp@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-5-memxor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405004239.1375399-5-memxor@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 05, 2023 at 02:42:34AM +0200, Kumar Kartikeya Dwivedi wrote:
> @@ -759,6 +759,8 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
>  
>  	for (i = 0; i < nr_loops; i++) {
>  		ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
> +		if (bpf_get_exception())
> +			return -EJUKEBOX;

This is too slow.
We cannot afford a call and conditional here.
Some time ago folks tried bpf_loop() and went back to bounded loop, because
the overhead of indirect call was not acceptable.
After that we've added inlining of bpf_loop() to make overhead to the minimum.
With prog->aux->exception[] approach it might be ok-ish,
but my preference would be to disallow throw in callbacks.
timer cb, rbtree_add cb are typically small.
bpf_loop cb can be big, but we have open coded iterators now.
So disabling asserts in cb-s is probably acceptable trade-off.

The choice of error name is odd, tbh.
