Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD384DEA43
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 20:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiCSTDl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 15:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243971AbiCSTDl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 15:03:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EF12993F5
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 12:02:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q19so7446690pgm.6
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z3FcS83kgpPidvUUvWpsrfv/mutUCp++jHRygGiHHnM=;
        b=MlCSRiGzkTmgxh/YQzbJA6ioyId+GCBiKjLIMU5ZC/5hMbAcD10yy+9xk6IwsySM5G
         TGRdC+ksLpimHu+W8tUAqVSGVJCJsutgwVECHnGku8r6/VBNhaZowIA3wKw3Mc3qKRNC
         r0FX2tQ+tvTC+j6wa2LxWEJ/0/YfwRSCCKDW5vRDDIEwpw7/B5ibO41OeU09IgPtKPPC
         zmqstIliVd7P5IdgjmTwwGsyVsjDlzYAbqvZxVa9tGbz0Vr+0skiYYQPtWxGZgRI37Wr
         FqA0Dmj1QpvKWmu79V+BfBj0yNuSPLUPXbO98MUHzceVFiMOxc4u2zuXjf05ZxpYmbme
         YiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z3FcS83kgpPidvUUvWpsrfv/mutUCp++jHRygGiHHnM=;
        b=tTSJJPY1XlOuPXOuNxbK4ECrK/BmsfsC6bD9KvUUYIkqSxKut7ZJZFTF+4tqXlZDMn
         wyylVuQVWNbkpa/MqPMZGY3Y32fJdmXQXZI30S+Sa3enYY7V4uzS2r74W9aNthXcw1V2
         PDbzTHUPUW4z9ajBIUTI2aOS6LsJYldp5tvozL0H50HLAOW0QMhjEcxuaBIzTWzYOuiv
         c3xBn5grWF1D1gedMd9BcbJpZTfDNbEBDBKXWGdfz6CC9wBpslG2D5MJ5SQT1QKyT8x4
         I86yVSBiKduS86ng3h1sFMPxk4zl88/usd5Cr4+TTVx5mJ7eO9njr8bfasVxCNHHvtdx
         wtrA==
X-Gm-Message-State: AOAM5330mq/Lih+jVfsGqksOuGGImYue/ICbbvhC1YNKZEKp+ygqjT96
        O+qv5e07lkpOK0qs3L5+wmw=
X-Google-Smtp-Source: ABdhPJzzpFRRBxK9rQPx1a9V1Bph3Umc4ZoUa+XgUzRvSOGBBS038oF93TSKK92428QXAmZDOWuykQ==
X-Received: by 2002:a63:5119:0:b0:37f:8077:ae15 with SMTP id f25-20020a635119000000b0037f8077ae15mr12752599pgb.11.1647716539181;
        Sat, 19 Mar 2022 12:02:19 -0700 (PDT)
Received: from localhost ([14.139.187.71])
        by smtp.gmail.com with ESMTPSA id l27-20020a63701b000000b0038233e59422sm4012570pgc.84.2022.03.19.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 12:02:18 -0700 (PDT)
Date:   Sun, 20 Mar 2022 00:32:14 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 06/15] bpf: Allow storing user kptr in map
Message-ID: <20220319190214.wgxqdzfwe3frbxyw@apollo>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-7-memxor@gmail.com>
 <20220319182813.issitd7s3c5b6qw3@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319182813.issitd7s3c5b6qw3@ast-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 19, 2022 at 11:58:13PM IST, Alexei Starovoitov wrote:
> On Thu, Mar 17, 2022 at 05:29:48PM +0530, Kumar Kartikeya Dwivedi wrote:
> > Recently, verifier gained __user annotation support [0] where it
> > prevents BPF program from normally derefering user memory pointer in the
> > kernel, and instead requires use of bpf_probe_read_user. We can allow
> > the user to also store these pointers in BPF maps, with the logic that
> > whenever user loads it from the BPF map, it gets marked as MEM_USER. The
> > tag 'kptr_user' is used to tag such pointers.
> >
> >   [0]: https://lore.kernel.org/bpf/20220127154555.650886-1-yhs@fb.com
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h   |  1 +
> >  kernel/bpf/btf.c      | 13 ++++++++++---
> >  kernel/bpf/verifier.c | 15 ++++++++++++---
> >  3 files changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 433f5cb161cf..989f47334215 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -163,6 +163,7 @@ enum {
> >  enum {
> >  	BPF_MAP_VALUE_OFF_F_REF    = (1U << 0),
> >  	BPF_MAP_VALUE_OFF_F_PERCPU = (1U << 1),
> > +	BPF_MAP_VALUE_OFF_F_USER   = (1U << 2),
> ...
> > +		} else if (!strcmp("kptr_user", __btf_name_by_offset(btf, t->name_off))) {
>
> I don't see a use case where __user pointer would need to be stored into a map.
> That pointer is valid in the user task context.
> When bpf prog has such pointer it can read user mem through it,
> but storing it for later makes little sense. The user context will certainly change.
> Reading it later from the map is more or less reading random number.
> Lets drop this patch until real use case arises.

In some cases the address may be fixed (e.g. user area registration similar to
rseq, that can be done between task and BPF program), as long as the task is
alive.

But the patch itself is trivial, so fine with dropping for now.

--
Kartikeya
