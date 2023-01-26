Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86C067C37D
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 04:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbjAZDZe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 22:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbjAZDZe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 22:25:34 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D488B5
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 19:25:33 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m11so449607pji.0
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 19:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9X6noQwThK6tIc1o2QK2Qm/5sXTmHNTq9nYKlBq2vcU=;
        b=OPOmht6VjozwRAFbk1ylqqX+J1JhWfC6XsqrV+57o8vRIHI2DeCFwbby7GfvOckuLX
         razAcq0tA9oRzrdrslsfKCFDGEFilIuFkqWFOObwhTzJVOnAdJDqS47iLR5o+FheBrIu
         N86/PZSyxazjcyU5QjIQrZU/38TMbBZVghyhXe0qk5axKT1GRa3VhrD9TAItqBmntAar
         Sy5Yapblf3DOJQo0jQp7ighZtiBb1pwrwmlnCqcltgzYVgxGbVvFATtlkLrdAYh1cxGI
         bMSd08Cq/X0NBjuaQR2rA2B3sPUmxe1Nimbow7aSGLDNsMd6bP3WJerwPuy7LAFRhELr
         54bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X6noQwThK6tIc1o2QK2Qm/5sXTmHNTq9nYKlBq2vcU=;
        b=zcUUxllTfgeqaS830EELP85z4ly0Y1vUzP6qfhDMZDnglBz/n6ZpKlGmC+LsTaIlSu
         OYnL3akQp9VD7W3L1Oq2M29PZsRnOBtIvwbOvDBmzCDCyERuR9XkMCGqcXb5GI7paEHi
         bs1jimveo1HlKXjNNsLv+BulPhF1fdyuBb32ymNt9NcYPj1hfuwGPeh6HDB87/jRmZrn
         ZDFs9gk12n2cAHhaQ7/AMV9TzlrAeqoefiGmr/xMaEUUbYM9MOLaGmHXcrpJggpjbqwq
         NS7HBOIuHTmHKTTZPEFr0zNKbnbg52gY11iIBPZg8rT2VeMokkFsDYpconYLTMf5RhDA
         y3XQ==
X-Gm-Message-State: AFqh2krCfpenpqAUucIlWvjBJrhXAC6KUar8npypQg0i+i1D5G/4QFJD
        e0MTFghwK2UOfhrhugtzkgw=
X-Google-Smtp-Source: AMrXdXuZBnjYubnWGas8xnqNl26k8z18B0wjgjx/6w13rzU7Mm0+REdM5Irbb4n+R4gI1KqZcJDqeQ==
X-Received: by 2002:a17:902:e84b:b0:194:ddc2:60e8 with SMTP id t11-20020a170902e84b00b00194ddc260e8mr28934279plg.48.1674703532791;
        Wed, 25 Jan 2023 19:25:32 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:500::6:b1d5])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902a60700b00192b0a07891sm147818plq.101.2023.01.25.19.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 19:25:32 -0800 (PST)
Date:   Wed, 25 Jan 2023 19:25:30 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com
Subject: Re: [RFC bpf-next 0/5] test_verifier tests migration to inline
 assembly
Message-ID: <20230126032530.nib7ov5gtt3knmc4@macbook-pro-6.dhcp.thefacebook.com>
References: <20230123145148.2791939-1-eddyz87@gmail.com>
 <CAEf4Bzbu2zctHntHNRVnEDa_FJz405Ld1Sb58wvJA+JvYdS+Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbu2zctHntHNRVnEDa_FJz405Ld1Sb58wvJA+JvYdS+Ag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 05:33:42PM -0800, Andrii Nakryiko wrote:
> 
> > __naked void invalid_and_of_negative_number(void)
> >
> > {
> >         asm volatile (
> > "       r1 = 0;                                         \n\
> 
> Kumar recently landed similarly formatted inline asm-based test, let's
> make sure we stick to common style. \n at the end are pretty
> distracting, IMO (though helpful to debug syntax errors in asm, of
> course). I'd also move starting " into the same line as asm volatile:

+1. Pls drop \n.
You don't have \n anyway in migrator's README on github.

> asm volatile ("                       \
> 
> this will make adding/removing asm lines at the beginning simpler (and
> you already put closing quote on separate line, so that side is taken
> care of)

+1

Also pls indent the asm code with two tabs the way Kumar did.
I think it looks cleaner this way and single tab labels align
with 'asm volatile ('.

> > All in all the current script stats are as follows:
> > - 62 out of 93 files from progs/*.c can be converted w/o warnings;

out of 98 in verifier/*.c ?

> > - 55 converted files could be compiled;
> > - 40 pass testing, 15 fail.

I would land this 40 now and continue step by step.

> >
> > By submitting this RFC I seek the following feedback:
> > - is community interested in such migration?
> 
> +1
> 
> This is a great work!

+1

> > - if yes, should I pursue partial or complete tests migration?
> 
> I'd start with partial
> 
> > - in case of partial migration which tests should be prioritized?
> 
> those that work out of the box?
> 
> > - should I offer migrated tests one by one or in big butches?

Can you do one patch one file in verifier/*.c that would map
to one new file in progs/ ?

> >
> > [1] https://github.com/eddyz87/verifier-tests-migrator

Having this link in patch series is enough.
The 'migrator' itself doesn't need to be in the kernel tree.
