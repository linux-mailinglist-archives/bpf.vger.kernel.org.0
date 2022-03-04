Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477914CDF1B
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiCDUi3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 15:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiCDUi1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 15:38:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CCE1F0839
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 12:37:37 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so8966739pjl.4
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 12:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dsA1FX8lhTDSd3saFvm28jSYAzEeqDFlG/vil91rrcM=;
        b=ELb8d6I5AInalhNrXUcJ3Ul9HMDxT3pv4d+iaYE8ypPGAn5R+RSudInA6wXP3JvdWC
         fkleYY3f45LQ3N0lXFi+IkzrtCFMYxiZgYUI5QOrWef6wpUefcBpWJnQnx3Q9lLfUEyH
         GETA4jocgqkcs9sfEz5Xr1swZOb4NcWzHeQkMmJgSZ/emfQ2+U9/JsDsEiYwvBLc+B5V
         N4VGsBSKMtJOUyRhiYzoUONvp1K2yLrpbla7o7jniQ9BQvC0jIL1LEU5qfbPMm1XTz+R
         ZK0cP1z2TFeXPivbi0NyXD653yxDjQdC6jJ7DKUfFmsYH6OggpS2OEhVL4YN+wxMLgOw
         MzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=dsA1FX8lhTDSd3saFvm28jSYAzEeqDFlG/vil91rrcM=;
        b=0ChAqu9Z/p1CjxRJseitsaqvyj53moY6rcvfrN84W9MGiq/PpEYlZohtSs+3jcGMlt
         Fzzm7QHPg/BgMndaMzI498DornIBPdE9hsBH81Khoo25Ldm/WSNTNcSorhSptYE3U7G/
         zXiQWKt1xyinkkJ1kQNJuWVfvZ2BzjenEjUj1NC2nRnSoIVhOW5K4K5kLiD9IwPf70Sy
         rObS+ua2pAXUsONYoUjVMwIQfS8rTrvyv54ru1twFbYNrXoNMHdyzZ6D5U8jfJ2ge3Yp
         8uKM0vuWQafF2nQWZNBv5dnm2pxATCHHV4VSjspFC4OCWv1h8YUYGhwHNuibef3zBvVU
         AH4Q==
X-Gm-Message-State: AOAM530g1wWx5jKgXj27SLmGIDAUmR7FMqlw4LcPg1aJ2GpYDMr55fI+
        4uf/9BfZEASigVaCw/C8jA1tlfKnAwI=
X-Google-Smtp-Source: ABdhPJyzaxJ166VpK7Di0RahcrhJU8QBYPlYHZpHWlSgWEIA1Ep1Ch8JGfzcvMZjvknIeul6/SRdoQ==
X-Received: by 2002:a17:90a:5794:b0:1b9:8932:d475 with SMTP id g20-20020a17090a579400b001b98932d475mr463092pji.24.1646426256982;
        Fri, 04 Mar 2022 12:37:36 -0800 (PST)
Received: from google.com ([2601:647:4800:3540:80fb:e053:2773:a0bb])
        by smtp.gmail.com with ESMTPSA id s7-20020a056a00178700b004e1a15e7928sm7422232pfg.145.2022.03.04.12.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 12:37:36 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Fri, 4 Mar 2022 12:37:33 -0800
From:   Namhyung Kim <namhyung@kernel.org>
To:     Eugene Loh <eugene.loh@oracle.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Subject: Re: using skip>0 with bpf_get_stack()
Message-ID: <YiJ4jTB8siLwxAEN@google.com>
References: <30a7b5d5-6726-1cc2-eaee-8da2828a9a9c@oracle.com>
 <c65ac449-ec54-3dff-5447-8a318001285b@fb.com>
 <1b59751f-0bb1-a4ad-6548-2536e60a80ec@oracle.com>
 <4e2e5738-b103-d340-753e-7e37e06304c4@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e2e5738-b103-d340-753e-7e37e06304c4@fb.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Mon, Jun 28, 2021 at 08:33:11PM -0700, Yonghong Song wrote:
> 
> 
> On 6/25/21 6:22 PM, Eugene Loh wrote:
> > 
> > On 6/1/21 5:48 PM, Yonghong Song wrote:
> > > Could you submit a patch for this? Thanks!
> > 
> > Sure.  Thanks for looking at this and sorry about the long delay getting
> > back to you.
> > 
> > Could you take a look at the attached, proposed patch?  As you see in
> > the commit message, I'm unclear about the bpf_get_stack*_pe() variants.
> > They might use an earlier construct callchain, and I do not know ho
> > init_nr was set for them.
> 
> I think bpf_get_stackid() and __bpf_get_stackid() implementation is correct.
> Did you find any issues?
> 
> For bpf_get_stack_pe, see:
> 
> https://lore.kernel.org/bpf/20200723180648.1429892-2-songliubraving@fb.com/
> I think you should not change bpf_get_stack() function.
> __bpf_get_stack() is used by bpf_get_stack() and bpf_get_stack_pe().
> In bpf_get_stack_pe(), callchain is fetched by perf event infrastructure
> if event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY is true.
> 
> Just focus on __bpf_get_stack(). We could factor __bpf_get_stackid(),
> but unless we have a bug, I didn't see it is necessary.
> 
> It will be good if you can add a test for the change, there is a stacktrace
> test prog_tests/stacktrace_map.c, you can take a look,
> and you can add a subtest there.
> 
> Next time, you can submit a formal patch with `git send-email ...` to
> this alias. This way it is easier to review compared to attachment.

Any updates on this?  I'm hitting the same issue and found this before
sending a fix.

Thanks,
Namhyung
