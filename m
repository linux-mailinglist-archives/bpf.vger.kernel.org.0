Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFF56DA670
	for <lists+bpf@lfdr.de>; Fri,  7 Apr 2023 02:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjDGAHL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbjDGAHK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 20:07:10 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A416EAB
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 17:07:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o32so23333595wms.1
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 17:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680826028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ntP8s1ihlQxww/nYYUm8paP9Nw413OXTl15MVFZ8300=;
        b=SCjsOLiMO8X1WuJ8QM3izAjkvwTzhatjT9/YWnPCGFhyMmR1NvzbXFIJ5nPlwRRHpy
         2wFJpwdjdAG80vQQrLIdQ6Oa1Te9c3ZIFHiBjSJfp6l6i7L/yTqR7cRKrBOpe5gWYMvr
         zErj78HMIz1irdAYq2xzAOuyadxb1wqYTibnhdzYZYVdA+B1bfwUxy8VL7DOXCriMayX
         qUAbTtucEnzS01tLbdOxNoAcZnyT3nQI/N5Q4XRM4ozGr1yaR/u8zzlun7YWu7YAZB0r
         ztj18sKv9BwRhnz0wgq1GO2N68BbA2bUkGY7lcAjbENE+n0GL4H6TTGUGiX0HX9UKhr+
         6bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680826028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntP8s1ihlQxww/nYYUm8paP9Nw413OXTl15MVFZ8300=;
        b=HZiFlL01ntPTJJ4PEuIjRfs0kdf34NMSK4jEDVshMQQatRjqvjl1rQcOyJHGZlC3q4
         P9ojeki1bclKZNDWTG/1YTaJaDMBlOF4Lkru0eyWkdgeviKMLRefh/jJPlQx7abQCZTp
         +QseyY7RMq6RHXY1UVuihwxcPOKcJnhz39xjmX+S4J/TpcK6oEnR9klqo4uLRSsZqT4Y
         uXCHK7jrJwBV+MvVqA7ul+LyI4HQS4EzdRFys5gtHa5tnFf+4FESjQssBCIN+P4SSfNU
         xFqN07Oew+t/y0emIOgJ5LNSePSE1vKsKa+RUuloTobWGkbzYbbulJt2az3GDQcSXlCh
         fbFw==
X-Gm-Message-State: AAQBX9egu8qR1P1ZHkEa9SrAEIf+rrTPKzwLadn2P2EzsYcymGzV5hsm
        1t4poRo/53cCExkGf6CaY9o=
X-Google-Smtp-Source: AKy350ZRPOm9il5LzVw47duUr8wtPFClPMXXozDR9X3FgN9bxwGfB5c0B1N+UlACnjLleNrBYeGQqw==
X-Received: by 2002:a05:600c:2155:b0:3ed:9ed7:d676 with SMTP id v21-20020a05600c215500b003ed9ed7d676mr8389wml.13.1680826027749;
        Thu, 06 Apr 2023 17:07:07 -0700 (PDT)
Received: from localhost ([2a02:1210:74a0:3200:2fc:d4f0:c121:5e8b])
        by smtp.gmail.com with ESMTPSA id r15-20020a05600c458f00b003f03d483966sm6707902wmo.44.2023.04.06.17.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 17:07:07 -0700 (PDT)
Date:   Fri, 7 Apr 2023 02:07:06 +0200
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Subject: Re: [PATCH RFC bpf-next v1 4/9] bpf: Handle throwing BPF callbacks
 in helpers and kfuncs
Message-ID: <lhsdwzz7phbcmckprwadzrrvpxqmsnl57bxhhpex3nh5ztnyog@pwqqxtntlnh5>
References: <20230405004239.1375399-1-memxor@gmail.com>
 <20230405004239.1375399-5-memxor@gmail.com>
 <20230406022139.75rkbl4xbwpn4qmp@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406022139.75rkbl4xbwpn4qmp@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 06, 2023 at 04:21:39AM CEST, Alexei Starovoitov wrote:
> On Wed, Apr 05, 2023 at 02:42:34AM +0200, Kumar Kartikeya Dwivedi wrote:
> > @@ -759,6 +759,8 @@ BPF_CALL_4(bpf_loop, u32, nr_loops, void *, callback_fn, void *, callback_ctx,
> >
> >  	for (i = 0; i < nr_loops; i++) {
> >  		ret = callback((u64)i, (u64)(long)callback_ctx, 0, 0, 0);
> > +		if (bpf_get_exception())
> > +			return -EJUKEBOX;
>
> This is too slow.
> We cannot afford a call and conditional here.

There are two more options here: have two variants, one with and without the
check (always_inline template and bpf_loop vs bpf_loop_except calling functions
which pass false/true) and dispatch to the appropriate one based on if callback
throws or not (so the cost is not paid for current users at all). Secondly, we
can avoid repeated calls by hoisting the call out and save the pointer to
exception state, then it's a bit less costly.

> Some time ago folks tried bpf_loop() and went back to bounded loop, because
> the overhead of indirect call was not acceptable.
> After that we've added inlining of bpf_loop() to make overhead to the minimum.
> With prog->aux->exception[] approach it might be ok-ish,
> but my preference would be to disallow throw in callbacks.
> timer cb, rbtree_add cb are typically small.
> bpf_loop cb can be big, but we have open coded iterators now.
> So disabling asserts in cb-s is probably acceptable trade-off.

If the only reason to avoid them is the added performance cost, we can work
towards eliminating that when bpf_throw is not used (see above). I agree that
supporting it everywhere means thinking about a lot more corner cases, but I
feel it would be less surprising if doing bpf_assert simply worked everywhere.
One of the other reasons is that if it's being used within a shared static
function that both main program and callbacks call into, it will be a bit
annoying that it doesn't work in one context.

>
> The choice of error name is odd, tbh.

I was trying to choose something that helpers will never pass back to the
program to avoid conflicts. Open to other suggestions (but it may not matter
depending on the discussion above).
