Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30B686E6B
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 19:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjBASyj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 13:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjBASyh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 13:54:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF6D6BBFD
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 10:54:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2590E61912
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 18:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59640C433EF;
        Wed,  1 Feb 2023 18:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675277675;
        bh=Seu4rzljYf9F6fS7Eg13CV/UMvOQHVy8gtK+nfNaj7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uW55gqOoDanGOP23+eMRoDoDdx14UyRyHwWrWhsq6kGQjOGaCKG9SvxAMtUfTuhrq
         gIC2XMosmF14DmijTOfTsJiklxlS2Kf8dnJAobyGC9S9XI5Eg2aZWRUigVn2FpKkEH
         hv6csRVMWsAJKKp5vgooe1fVBPqpB++opKQ2kX9PQzf462K1AnBvd6HzhNNIpx+vG0
         rIy3Mz2ZeZOx6i1BjmGKAY95VV4VUoH5eL8gOou7kdLQhTbA1dQxeJWWd/TyQ3vZlE
         iDD34UNappNnx5+BjxNgqPHkDAedq2K+b95dtxCq1828z+PZ9lTBp1Pyu/giSSbW7d
         CW+Rw1K1a2MlQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A354D405BE; Wed,  1 Feb 2023 15:54:32 -0300 (-03)
Date:   Wed, 1 Feb 2023 15:54:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Vernet <void@manifault.com>, Yonghong Song <yhs@fb.com>,
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
Message-ID: <Y9q1aEQtYNHsGMWb@kernel.org>
References: <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
 <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
 <Y9nWR7mNGeGCDLYz@maniforge>
 <9c330c78-e668-fa4c-e0ab-52aa445ccc00@oracle.com>
 <Y9p+70RzH7QiO2Mw@kernel.org>
 <Y9qC5UQaw9g6cPwz@maniforge>
 <CAADnVQJQQQNw0X-jDXquFYcYeSb0f5T3657KqC8+YevFO6A0cA@mail.gmail.com>
 <Y9qa+yFq+8jT+niu@kernel.org>
 <a9679d64-4860-a404-6030-22e104aec67f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9679d64-4860-a404-6030-22e104aec67f@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 01, 2023 at 05:18:29PM +0000, Alan Maguire escreveu:
> On 01/02/2023 17:01, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Feb 01, 2023 at 08:49:07AM -0800, Alexei Starovoitov escreveu:
> >> It feels fixed pahole should be done under some flag
> >> otherwise when people update the pahole the existing and older
> >> kernels might stop building with warns:
> >> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> >> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> >> ...
 
> Good point, something like
 
> --skip_inconsistent_proto	Skip functions that have multiple inconsistent
> 				function prototypes sharing the same name, or
> 				have optimized-out parameters.

We have:

⬢[acme@toolbox pahole]$ grep '"skip_encoding.*' pahole.c
		.name = "skip_encoding_btf_vars",
		.name = "skip_encoding_btf_decl_tag",
		.name = "skip_encoding_btf_type_tag",
		.name = "skip_encoding_btf_enum64",
⬢[acme@toolbox pahole]$

Perhaps, even being long, we should be consistent and name it:

	--skip_encoding_btf_inconsistent_proto

?
 
> ? Implementation needs a bit of thought though because we're
> not really doing the same thing that we were before. Previously we
> were adding the first instance of a function in the CU we came across.
> Probably safest to resurrect that behaviour for the legacy
> non-skip-inconsistent-proto case I think. The final patch handling

Consider getting what I have now in my next branch, that has the fixups
I made while reviewing, as discussed in this thread:

⬢[acme@toolbox pahole]$ git log --oneline -6
b1576cf15106efd7 (HEAD -> master) pahole: Sync with libbpf-1.1
e9db5622d97395b7 btf_encoder: Delay function addition to check for function prototype inconsistencies
74675488e8ed5718 btf_encoder: Represent "."-suffixed functions (".isra.0") in BTF
be470fa5757e5915 btf_encoder: Rework btf_encoders__*() API to allow traversal of encoders
d6e0778f6b5912da btf_encoder: Refactor function addition into dedicated btf_encoder__add_func
f77b5ae93844b5c4 dwarf_loader: Help spotting functions with optimized-out parameters
⬢[acme@toolbox pahole]$

And at the point where you change the behaviour you introduce the
option, so that we don't have to remove it and then ressurect.

- Arnaldo

> inconsistent function prototypes will need to be reworked a bit to 
> support this, since we tossed this approach and used saving/merging 
> multiple instances in the tree instead.  Once I've built bpf trees I'll
> have a go at getting this working.
> 
> >> Arnaldo, could you check what warns do you see with this fixed pahole
> >> in bpf tree ?
> > 
> > Sure.
> > 
> 
> I can collect this for x86_64/aarch64 too; might take a few hours
> before I have the results.
> 
> >> If there are only few warns then we can manually add __used noinline
> >> to these places, push to bpf tree and push to stable.
> >>
> >> Then in bpf-next we can clean up everything with __bpf_kfunc.
> > 

-- 

- Arnaldo
