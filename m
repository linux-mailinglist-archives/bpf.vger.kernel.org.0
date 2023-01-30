Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29771681858
	for <lists+bpf@lfdr.de>; Mon, 30 Jan 2023 19:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjA3SJE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Jan 2023 13:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjA3SJD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Jan 2023 13:09:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781C4EF5
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 10:08:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D99EFB815CC
        for <bpf@vger.kernel.org>; Mon, 30 Jan 2023 18:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D95C433EF;
        Mon, 30 Jan 2023 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675102132;
        bh=Z3chGKodOqcxcingj9qzIjQAzQEmK+13Jz9p6cwdMG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JoAzECdQ2e379yYwgHvpnjbKMUPG4ET/9ap8GZjxVv2esawuZ6G8G4Ubi8fD4U7rk
         kwg//SYnlRAKOwmyN3B2926K02PxNUN20Fd9vSvxjwWe97vQTH6agDD95EjXIDfpwO
         CpYmno7drtTp6uoY5eKLymzdG48KZRJvVdFaCWDPZvrTgIpNtwnZly5wHFA5ZFDOJm
         1dKpDc8jgBUBqqAaxRrO5GhP4X43A3FpmXHNtCb19N89hxEBtZ9IDzbOEe2eb4VF7u
         haCyNrqVAIPjCPT9Q64Kp87XYMoBSwoAbtWgWn9hZI6vT1LYc9wsGTLZuLWKW7W1Uo
         ojPEyu7X0j0gw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 194EF405BE; Mon, 30 Jan 2023 15:08:49 -0300 (-03)
Date:   Mon, 30 Jan 2023 15:08:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, yhs@fb.com, ast@kernel.org,
        olsajiri@gmail.com, eddyz87@gmail.com, sinquersw@gmail.com,
        timo@incline.eu, daniel@iogearbox.net, andrii@kernel.org,
        songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 dwarves 5/5] btf_encoder: delay function addition to
 check for function prototype inconsistencies
Message-ID: <Y9gHsXhe1ygOqI8t@kernel.org>
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-6-git-send-email-alan.maguire@oracle.com>
 <20230130172037.vbe55faqcrkkxbge@macbook-pro-6.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130172037.vbe55faqcrkkxbge@macbook-pro-6.dhcp.thefacebook.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jan 30, 2023 at 09:20:37AM -0800, Alexei Starovoitov escreveu:
> On Mon, Jan 30, 2023 at 02:29:45PM +0000, Alan Maguire wrote:
> > There are multiple sources of inconsistency that can result in
> > functions of the same name having multiple prototypes:
> > 
> > - multiple static functions in different CUs share the same name
> > - static and external functions share the same name
> > 
> > Here we attempt to catch such cases by finding inconsistencies
> > across CUs using the save/compare/merge mechanisms that were
> > previously introduced to handle optimized-out parameters,
> > using it for all functions.
> > 
> > For two instances of a function to be considered consistent:
> > 
> > - number of parameters must match
> > - parameter names must match
> > 
> > The latter is a less strong method than a full type
> > comparison but suffices to match functions.
> > 
> > With these changes, we see 278 functions removed due to
> > protoype inconsistency.  For example, wakeup_show()
> > has two distinct prototypes:
> > 
> > static ssize_t wakeup_show(struct kobject *kobj,
> >                            struct kobj_attribute *attr, char *buf)
> > (from kernel/irq/irqdesc.c)
> > 
> > static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
> >                            char *buf)
> > (from drivers/base/power/sysfs.c)
> > 
> > In some other cases, the parameter comparisons weed out additional
> > inconsistencies in "."-suffixed functions across CUs.
> > 
> > We also see a large number of functions eliminated due to
> > optimized-out parameters; 2542 functions are eliminated for this
> > reason, both "."-suffixed (1007) and otherwise (1535).
> 
> imo it's a good thing.
> 
> > Because the save/compare/merge process occurs for all functions
> > it is important to assess performance effects.  In addition,
> > prior to these changes the number of functions ultimately
> > represented in BTF was non-deterministic when pahole was
> > run with multiple threads.  This was due to the fact that
> > functions were marked as generated on a per-encoder basis
> > when first added, and as such the same function could
> > be added multiple times for different encoders, and if they
> > encountered inconsistent function prototypes, deduplication
> > could leave multiple entries in place for the same name.
> > When run in a single thread, the "generated" state associated
> > with the name would prevent this.
> > 
> > Here we assess both BTF encoding performance and determinism
> > of the function representation in baseline compared to with
> > these changes.  Determinism is assessed by counting the
> > number of functions in BTF.  Comparisons are done for 1,
> > 4 and 8 threads.
> > 
> > Baseline
> > 
> > $ time LLVM_OBJCOPY=objcopy pahole -J vmlinux
> > 
> > real	0m18.160s
> > user	0m17.179s
> > sys	0m0.757s
> > 
> > $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|wc -l
> > 51150
> > $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|uniq|wc -l
> > 51150
> > 
> > $ time LLVM_OBJCOPY=objcopy pahole -J -j4 vmlinux
> > 
> > real	0m8.078s
> > user	0m17.978s
> > sys	0m0.732s
> > 
> > $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|wc -l
> > 51592
> > $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|uniq|wc -l
> > 51150
> > 
> > $ time LLVM_OBJCOPY=objcopy pahole -J -j8 vmlinux
> > 
> > real	0m7.075s
> > user	0m19.010s
> > sys	0m0.587s
> > 
> > $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|wc -l
> > 51683
> > $ grep " FUNC " /tmp/vmlinux.btf.base |awk '{print $3}'|sort|uniq|wc -l
> > 51150
> 
> Ouch. I didn't realize it is so random currently.
> 
> > Test:
> > 
> > $ time LLVM_OBJCOPY=objcopy pahole -J  vmlinux
> > 
> > real	0m19.039s
> > user	0m17.617s
> > sys	0m1.419s
> > $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|wc -l
> > 49871
> > $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|uniq|wc -l
> > 49871
> > 
> > $ time LLVM_OBJCOPY=objcopy pahole -J -j4 vmlinux
> > 
> > real	0m8.482s
> > user	0m18.233s
> > sys	0m2.412s
> > $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|wc -l
> > 49871
> > $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|uniq|wc -l
> > 49871
> > 
> > $ time LLVM_OBJCOPY=objcopy pahole -J -j8 vmlinux
> > 
> > real	0m7.614s
> > user	0m19.384s
> > sys	0m3.739s
> > $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|wc -l
> > 49871
> > $ bpftool btf dump file vmlinux | grep ' FUNC ' |sort|uniq|wc -l
> > 
> > So there is a small cost in performance, but we improve determinism
> > and the consistency of representation.
> 
> This is a great fix.
> 
> I'm not an expert in this code base, but patches look good to me.
> Thank you for fixing it.

And all the description of the problem and of the solution, limitations,
together with a summary of the review comments, its a pleasure to
process a patch series like this one :-)

Doing that now and performing the usual tests,

Thanks,

- Arnaldo
 
> > For now it is better to have an incomplete representation
> > that more accurately reflects the actual function parameters
> > used, removing inconsistencies that could otherwise do harm.
> 
> +1

-- 

- Arnaldo
