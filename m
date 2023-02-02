Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4F36872D6
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjBBBJm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjBBBJj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:09:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEFD74A52
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:09:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A07BF619BD
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 01:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0510C433EF;
        Thu,  2 Feb 2023 01:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675300162;
        bh=4qHLj2VwqtAJvfAp6SD3sitCNU1Js8+rE8SlCCWHcSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZH97zqJQKXIR7qPRuu0+HkStk3TQlZgRoMjFPe8WCFgellIGkQorPtb0nGDYmY0i
         naNJ/xBN+7Q6klxqVUpbMHywBYfoWQ3/6IxVCcvLUgCeKmaUISeMCNMbLkl+TaYmnN
         RLB09R45tg0l+llMw4bKE9HE+mIODT8JFXDEfd80slDQndC7oIT3Zjs44ozU6BnWUb
         buP8ULdkAUys4cz/xiVzn84ep9kgqnKdKqr080q5x06fx2uoYS1rD0qW2gzjJasX3o
         y5e0kqZ27/UD+x+lE/js4EzL67Ip+GJbn7kA1fXbmDgS6zeCopJNyw9Nkkq8+bX+Gl
         g+sDmwA2shZFw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 89BB2405BE; Wed,  1 Feb 2023 22:09:19 -0300 (-03)
Date:   Wed, 1 Feb 2023 22:09:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
        sinquersw@gmail.com, Timo Beckers <timo@incline.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Message-ID: <Y9sNP+flSiRHAt49@kernel.org>
References: <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
 <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
 <Y9nWR7mNGeGCDLYz@maniforge>
 <9c330c78-e668-fa4c-e0ab-52aa445ccc00@oracle.com>
 <Y9p+70RzH7QiO2Mw@kernel.org>
 <Y9qC5UQaw9g6cPwz@maniforge>
 <CAADnVQJQQQNw0X-jDXquFYcYeSb0f5T3657KqC8+YevFO6A0cA@mail.gmail.com>
 <Y9qa+yFq+8jT+niu@kernel.org>
 <Y9roZNTWuuQOcQ39@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9roZNTWuuQOcQ39@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 01, 2023 at 07:32:04PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Feb 01, 2023 at 02:01:47PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Feb 01, 2023 at 08:49:07AM -0800, Alexei Starovoitov escreveu:
> > > > Great, so inline and __used with __bpf_kfunc sounds like the way forward
> > > > in the short term. Arnaldo / Alexei -- how do you want to resolve the
> > > > dependency here? Going through bpf-next is probably a good idea so that
> > > > we get proper CI coverage, and any kfuncs added to bpf-next after this
> > > > can use the macro. Does that work for you?
> > > 
> > > It feels fixed pahole should be done under some flag
> > > otherwise when people update the pahole the existing and older
> > > kernels might stop building with warns:
> > > WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> > > WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> > > ...
> > > 
> > > Arnaldo, could you check what warns do you see with this fixed pahole
> > > in bpf tree ?
> > 
> > Sure.
> 
> These appeared on a distro like .config:
> 
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> WARN: resolve_btfids: unresolved symbol bpf_cpumask_any
> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
> 
> I'll do it with allmodconfig

^C[1]+  Done                    nohup make -j32 O=../build/allmodconfig

⬢[acme@toolbox bpf-next]$
⬢[acme@toolbox bpf-next]$ grep "^WARN: resolve_btfids: " nohup.out
WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
WARN: resolve_btfids: unresolved symbol bpf_cpumask_any
WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
⬢[acme@toolbox bpf-next]$

