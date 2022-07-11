Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B34A56FECB
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 12:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiGKKYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 06:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiGKKXs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 06:23:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5661CCB473;
        Mon, 11 Jul 2022 02:37:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x91so5521709ede.1;
        Mon, 11 Jul 2022 02:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ad7/A44+0NiPdgz2BZ+Q1Vs/gVbFqnOPeM6zyIQDjww=;
        b=HwiS7GBkhxX5+WYj1FPToirU9/fbx0C1fzYibPQuAeSusOEVKt5/ysGfWCM/7r3jNs
         xJ6pdY+9T8siTFO5B4rLH5Rm/wSj4WM9I8uIYhd1jqiCL+jXNF7ypIHkrrcfPmIOgToN
         oXPbvi/lvdF6x320B1GN51vWclNSupIF4/W+orw95HM4BebaHJa7zzwZhFlX9tI/lm9U
         Rb75zuvsgAUEdSYU6iV20GfHONeDhzQwHR09SwtmeshwYC5cbC9p/HZKpTN2f+bWgFNH
         iwS2tEd1vLQw/1aexnBHv78pWdM+YAax/Gk/+eopLHOXFXpWl1FNjhp4ufwp5ar74ni1
         y2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ad7/A44+0NiPdgz2BZ+Q1Vs/gVbFqnOPeM6zyIQDjww=;
        b=cH08E5B7uGcSPnVjlUwd8T4yqUvNW2N0d7I2Rn7a0bOyRrnFFjkuw9gEIHVffjpTxY
         Rzn8CTbZcT9u9RbVFBv9//NZZDX3rmV8T0coh+RmWZVZpaky9wUKHt51ZuavwdVbdHlg
         Fcxih75doBTlIOu5jtQEDZT+egi76i0o2YTPOgw74snzifs40i0su+yHcP1FDTlUhw99
         t4WEbCHekUt1QEDsPoh33FhT0MkB0OpftWaAkVC1GxCToPjpG28gfPdhD/nW6L1l7XAM
         uVpD4Wd8u6hGWCa6k0zLGdDYJ+vz+HckVqYWZeU7LM+heTAVDMP2uKb6vAiF5jPHCAJE
         jMBA==
X-Gm-Message-State: AJIora8uVv1OqzIT/ZwpyJ5JvEq02T78dZp4v1FDyjAAJxVE3qgJM7Nv
        3SsA36aktbsRbunOIyRrzV4=
X-Google-Smtp-Source: AGRyM1sx/XLJao/eFV/jXtGv7wuazy8yBhCYstsFSxCmpbO27YqDHxVfYGuZLJX6qNSgkssYQ/spXQ==
X-Received: by 2002:a05:6402:5201:b0:43a:d797:b9c with SMTP id s1-20020a056402520100b0043ad7970b9cmr4356750edd.343.1657532271384;
        Mon, 11 Jul 2022 02:37:51 -0700 (PDT)
Received: from krava ([151.14.22.253])
        by smtp.gmail.com with ESMTPSA id u18-20020aa7d892000000b0043a6e807febsm4003414edq.46.2022.07.11.02.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 02:37:50 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 11 Jul 2022 11:37:48 +0200
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 0/2] btf: support BTF_KIND_ENUM64
Message-ID: <YsvvbDrwDJ5Qu5wu@krava>
References: <20220629071213.3178592-1-yhs@fb.com>
 <YrzH1ABPYmKSEogS@kernel.org>
 <YsvqYhbee6WpBckl@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsvqYhbee6WpBckl@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 11, 2022 at 11:16:21AM +0200, Jiri Olsa wrote:
> On Wed, Jun 29, 2022 at 06:44:52PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 29, 2022 at 12:12:13AM -0700, Yonghong Song escreveu:
> > > Add support for enum64. For 64-bit enumerator value,
> > > previously, the value is truncated into 32bit, e.g.,
> > > for the following enum in linux uapi bpf.h,
> > >   enum {
> > >         BPF_F_INDEX_MASK                = 0xffffffffULL,
> > >         BPF_F_CURRENT_CPU               = BPF_F_INDEX_MASK,
> > >   /* BPF_FUNC_perf_event_output for sk_buff input context. */
> > >         BPF_F_CTXLEN_MASK               = (0xfffffULL << 32),
> > >   };    
> > 
> > Applied, added the entry for skip generating enums to the man page,
> > added support to the pahole BTF loader, used the new pahole to build
> > bpf-next/master, all seems ok, pushing to next on git.kernel.org so that
> > the libbpf github CI can give it a go.
> > 
> > To build with torvalds/master one has to add --skip_encoding_btf_enum64,
> > I think, haven't tested with it, without it isn't working, libbpf
> > complains at that btfids tool.
> > 
> > Please check/test what is in there now:
> > 
> >   git://git.kernel.org/pub/scm/devel/pahole/pahole.git next
> >   https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next
> > 
> > Unless someone screams I plan pushing out a new release, update fedora
> > packages, etc early next week its overdue by now.
> 
> I used this new pahole in kernel build and it looks ok,
> but I'm getting following warning:
> 
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol mptcp_sock
> 
> might be specific to my .config, I'll check and let you know

ok I have only FWD declaration of mptcp_sock struct, that's why it
can't get resolved.. when I enabled CONFIG_MPTCP it goes away

so no problem with pahole ;-)

Tested-by: Jiri Olsa <jolsa@kernel.org>


the problem is with the btf_sock_ids array that carries mptcp_sock
BTF id even when the CONFIG_MPTCP option is not enabled

I'll follow up on that in separate email

thanks,
jirka
