Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783074CC287
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 17:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiCCQVZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 11:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiCCQVY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 11:21:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C85199D63
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 08:20:39 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id r13so11790653ejd.5
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 08:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f7TIe5PD8neOmsHGveoTmC+XUaJefjzSEsNOOjYstJs=;
        b=oTpCakX6J83qtxjJ9LxslTYCyvkQI/eGeBGhFSsmEgQ0xyAsaq4T0nxwIlS2cRa/Yx
         TeW9HBu4474ZuBkmrJvZkp8CbFHwbaw3caJm2SPRvfnruPZQX0LEdYuDKWRBSQz7RLe9
         W5FgMIS4P7KfqWJqde+dgeJLnEM0weYHm7uoRSoJN68HqdrVMqkR5vXCL3j4giNF6Swy
         cFeHhrOYsBbIh2wHgA01ekJG7hdC73VsCXQ46HLT3+J3LnvBJ0WmeQthIzM/OsYb2Lib
         JG02RNDISnFYeYMhaln99Ym84OQy6PugD7mYetnXhicqFFE6j+QATPtncJdwyWx/LA1P
         RWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f7TIe5PD8neOmsHGveoTmC+XUaJefjzSEsNOOjYstJs=;
        b=GXi6iOgCJWqoTZIxG7Vx0jOA5UBkDq4J3d3tFQFFuHgkxdG9JRjtcqravFBJ0+1HYv
         yO9fn1krdi0ZmnU5ydoxsgKU+BmVS0lsC6xmWpueg5FyVjZUCwabLk0beB2SRv5OovPz
         8uQARMNv+nc/hYtMNGvhQWlwW5CGTIfl5+5iEmPjgtIjjzOrO0+lzQK26H1YtSGqYxzi
         MbpGCpZvUPnMEHRyLEDvQh3J0rADRccPfNtSdvDUdNkNWGfazqLFSDnfjD5CSwnD5x6x
         b3GG1DjKytYClexcAjfVZS8xC8AElTwDMJvki2sviNdNNDTFGCkoSdZizf1HCh2YWESj
         qV/A==
X-Gm-Message-State: AOAM531Q4FRfyKczsQhRJbE3ajpo+suHIDnnu5osBULCYBG6tGEvp8BP
        c5BQdum/t3nOHNSkjyBIrBU=
X-Google-Smtp-Source: ABdhPJx6QWzfU7x+LECBhxwpbdSmHdBUWzDXwHmbGcOUYbqvgxTEv9mxMZv9pxIU/EV529GETVn5Pg==
X-Received: by 2002:a17:906:2811:b0:6ce:eacf:5210 with SMTP id r17-20020a170906281100b006ceeacf5210mr28509586ejc.618.1646324437789;
        Thu, 03 Mar 2022 08:20:37 -0800 (PST)
Received: from erthalion.local (dslb-178-005-230-047.178.005.pools.vodafone-ip.de. [178.5.230.47])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906861700b006da745f7233sm844397ejx.5.2022.03.03.08.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:20:37 -0800 (PST)
Date:   Thu, 3 Mar 2022 17:20:10 +0100
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com
Subject: Re: [RFC PATCH v4] bpftool: Add bpf_cookie to link output
Message-ID: <20220303162010.qcz7dovfg736h4ed@erthalion.local>
References: <20220225152802.20957-1-9erthalion6@gmail.com>
 <a646e7d3-b4aa-3a00-013e-4fc9531c2d83@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a646e7d3-b4aa-3a00-013e-4fc9531c2d83@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Tue, Mar 01, 2022 at 11:53:56PM -0800, Yonghong Song wrote:
>
>
> On 2/25/22 7:28 AM, Dmitrii Dolgov wrote:
> > Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> > BPF perf links") introduced the concept of user specified bpf_cookie,
> > which could be accessed by BPF programs using bpf_get_attach_cookie().
> > For troubleshooting purposes it is convenient to expose bpf_cookie via
> > bpftool as well, so there is no need to meddle with the target BPF
> > program itself.
>
> Do you still need RFC tag? It looks like we have a consensus
> with this bpf_iter approach, right?
>
> Please also add "bpf-next" to the tag for clarity purpose.

Yeah, you're right, it seems there is no need for RFC tag any more. Will
add "bpf-next" tag as well, thanks for the suggestion.

> > diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> > index 7c384d10e95f..152502c2d6f9 100644
> > --- a/tools/bpf/bpftool/pids.c
> > +++ b/tools/bpf/bpftool/pids.c
> > @@ -55,6 +55,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
> >   		ref->pid = e->pid;
> >   		memcpy(ref->comm, e->comm, sizeof(ref->comm));
> >   		refs->ref_cnt++;
> > +		refs->bpf_cookie_set = e->bpf_cookie_set;
> > +		refs->bpf_cookie = e->bpf_cookie;
>
> Do we need here? It is weird that we overwrite the bpf_cookie with every new
> 'pid' reference.
>
> When you create a link, the cookie is fixed for that link. You could pin
> that link in bpffs e.g., /sys/fs/bpf/link1 and other programs can then
> get a reference to the link1, but they should still have the same cookie. Is
> that right?

Right, I have the same understanding about a single fixed cookie per
link. But in this particular case the implementation uses
hashmap__for_each_key_entry (which is essentially a loop with a
condition inside) and inside it returns as soon as the first entry was
found. So I guess it will not override the cookie with every new
reference, do I see it correct?
