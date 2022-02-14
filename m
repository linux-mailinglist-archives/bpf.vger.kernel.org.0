Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21AA4B587F
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 18:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbiBNR17 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 12:27:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiBNR17 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 12:27:59 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718D5A1AC
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 09:27:51 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id c4so9057580pfl.7
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 09:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CJ279CudCaS/SjQv38lDfSVVrzub3twFwFz0cNIf3zQ=;
        b=P1W1U3u++4UAxn5DPbjN9wmUKs8RhmQG4DOaDMkTZ+qyBfb1WVlZAhOuFlZAq+cJcN
         pIBbLd7xmB375P21nqRFRCEhPyhKCEeNRwEbn9V7i/bVrxEB4/gbCLsXq6lW+cnvJBrV
         Q9tEOG0ViTdIZmyspUNP7ppLjrCGrw49MokFREzR5ErcQwKXYg8stV48UwZYd6Rg3A7A
         n4elcqpGNIJU/SxqQB2gbr5MlkElvX4/QFywsRf+BZ7GiucQ27cLR55KZirYzukcpYgx
         RDGtyuvAqAC2HMv4Vhqzwi+jSXQWzeG8dj3H6d4bEo9e7SQFROSUQHHVDCDyIAg45UqY
         ZdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJ279CudCaS/SjQv38lDfSVVrzub3twFwFz0cNIf3zQ=;
        b=XfYqb3aIqxYfRmOl8aGQn80xWPArKYJ3AjuErO/OK7uwzyKFjwIEHC3Q34PIaVUs6J
         pQo9WE2VUN00jm9+401U7nXMzYd70O9l29RNUPOs4iEQNceZKfy7BrYqfpsp65mPjTt8
         LSFf2YRwMoJFl41AR3HPISoQ8r+ir+8bkG1Yg0gVcA3O5MuGv4pcp+uJ2Pe5aA3TmJDg
         /rEvYJY1rB+71yinQe1XJdWaOEQSw7lkXnGhdlc5STeS2E4Y4z31icYKauIaMXJc2wLV
         kMV2pGc0aa3kw1Rf1P1kqHRDEFQwEs5I6/udCP9JSzTZVnMbUQOR+EGJ3y8hdcpR8mN0
         OtKQ==
X-Gm-Message-State: AOAM533LOu6yuqiCC1+vxPYol3Ed24VxdP+Nt0Ew21PrNnfySp8kUN8s
        HRBZ1/mBhBt/FHYIWOzybCY=
X-Google-Smtp-Source: ABdhPJwAOLoyYYnCmP2KINdHv5sauPRzqj86LeRZJoApac2LIZ1nx09NADw12PFVIrAuLg8eAbbGug==
X-Received: by 2002:a63:6a82:: with SMTP id f124mr80751pgc.64.1644859670882;
        Mon, 14 Feb 2022 09:27:50 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:528])
        by smtp.gmail.com with ESMTPSA id 10sm36401582pfm.56.2022.02.14.09.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:27:50 -0800 (PST)
Date:   Mon, 14 Feb 2022 09:27:47 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling
 selftest
Message-ID: <20220214172747.o6xr3pfvvt7545wk@ast-mbp.dhcp.thefacebook.com>
References: <20220211211450.2224877-1-andrii@kernel.org>
 <20220211211450.2224877-4-andrii@kernel.org>
 <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzbrdJMX0P=P84D40oYH3BNrL-16xqFNFH48BtYc9DaJHw@mail.gmail.com>
 <20220212001832.2dajubav5tqwaimn@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzY_tQQ3sTmTwx_uFAg3Z50ckWf1MWgCy-ZR==gV65e3Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY_tQQ3sTmTwx_uFAg3Z50ckWf1MWgCy-ZR==gV65e3Mw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 11, 2022 at 05:16:25PM -0800, Andrii Nakryiko wrote:
> >
> > Calling the callback 'preload' when it cannot affect the load is odd too.
> 
> It's what happening before loading, I never had intention to prevent
> load... Would "prepare_load_fn" be a better name?

prepare_load_fn would be more accurate name for sure.

If we're not planning to change place where init_fn is called too
then can we rename it to something that would accurately describe it?
It seems it's called after ELF is fully parsed except relos and progs
are ready to be tweaked.
Should 'prog' be in the name? Like prog_setup_fn ? or prog_init_fn ?
Then ability to set prog autoload would flow naturally from such name.
What else can be done there? Or what is a recommended use of this cb?

> might what to be able to do with this. Alan's uprobe attach by
> function name would be implementable through these APIs outside of
> libbpf as well (except then we won't be able to add func_name into
> bpf_uprobe_opts, which would be a pity).

Alan,
can you demo your "okprobe" feature based on this api?
Any rough patches would do.
The "o" handling will be done in which callback?
