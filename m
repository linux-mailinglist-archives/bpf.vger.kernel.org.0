Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3884457259E
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiGLT2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 15:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiGLT2d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 15:28:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F2CE0F5E;
        Tue, 12 Jul 2022 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5zn6hvHj4eKtfzqRScUEHMiIgZur5MyCCs29W1zBYWo=; b=xxs5oqmrZEfO2E2kxTPGNrkRA7
        vBxlIZp9V+hqHw7UsxneA0WB6uEnzq62HTiQMSJlzBKphdX/f13tQpG50mucKGSRLyum5pR1eqxDj
        RFiCrTx/E6tlShgUgl6TZtHLYONAUGmmDpljk3YyL2wNRddKtfsrQFBX31dnnl4UmgIcDQn6Bhiy2
        R1AYFBFhR1bQRM6WmKGxKr2aLGpVzm5FLCWYcpg23IdcOzHEdsHa14+A8AmKHKpyw95W/1onf4lBW
        HyF0WFSv56iDl0v13QjsccAx2nNtGNXoTClDAz2uatbs1mqzeOgB8GGcmUtfCbvtv9ss8P+BrIeKb
        gVzKuaVA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBLBN-00E3qI-Ub; Tue, 12 Jul 2022 19:04:29 +0000
Date:   Tue, 12 Jul 2022 12:04:29 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>,
        bpf <bpf@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v6 bpf-next 0/5] bpf_prog_pack followup
Message-ID: <Ys3FvYnASr2v9iPc@bombadil.infradead.org>
References: <YsdlXjpRrlE9Z+Jq@bombadil.infradead.org>
 <F000FF60-CF95-4E6B-85BD-45FC668AAE0A@fb.com>
 <YseAEsjE49AZDp8c@bombadil.infradead.org>
 <C96F5607-6FFE-4B45-9A9D-B89E3F67A79A@fb.com>
 <YshUEEQ0lk1ON7H6@bombadil.infradead.org>
 <863A2D5B-976D-4724-AEB1-B2A494AD2BDB@fb.com>
 <YsiupnNJ8WANZiIc@bombadil.infradead.org>
 <6214B9C9-557B-4DC0-BFDE-77EAC425E577@fb.com>
 <Ysz2LX3q2OsaO4gM@bombadil.infradead.org>
 <E23B6EB1-AFFA-4B65-963E-B44BA0F2142D@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E23B6EB1-AFFA-4B65-963E-B44BA0F2142D@fb.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 05:49:32AM +0000, Song Liu wrote:
> > On Jul 11, 2022, at 9:18 PM, Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > I believe you are mentioning requiring text_poke() because the way
> > eBPF code uses the module_alloc() is different. Correct me if I'm
> > wrong, but from what I gather is you use the text_poke_copy() as the data
> > is already RO+X, contrary module_alloc() use cases. You do this since your
> > bpf_prog_pack_alloc() calls set_memory_ro() and set_memory_x() after
> > module_alloc() and before you can use this memory. This is a different type
> > of allocator. And, again please correct me if I'm wrong but now you want to
> > share *one* 2 MiB huge-page for multiple BPF programs to help with the
> > impact of TLB misses.
> 
> Yes, sharing 1x 2MiB huge page is the main reason to require text_poke. 
> OTOH, 2MiB huge pages without sharing is not really useful. Both kprobe
> and ftrace only uses a fraction of a 4kB page. Most BPF programs and 
> modules cannot use 2MiB either. Therefore, vmalloc_rw_exec() doesn't add
> much value on top of current module_alloc(). 

Thanks for the clarification.

> > A vmalloc_ro_exec() by definition would imply a text_poke().
> > 
> > Can kprobes, ftrace and modules use it too? It would be nice
> > so to not have to deal with the loose semantics on the user to
> > have to use set_vm_flush_reset_perms() on ro+x later, but
> > I think this can be addressed separately on a case by case basis.
> 
> I am pretty confident that kprobe and ftrace can share huge pages with 
> BPF programs.

Then wonderful, we know where to go in terms of a new API then as it
can be shared in the future for sure and there are gains.

> I haven't looked into all the details with modules, but 
> given CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC, I think it is also 
> possible.

Sure.

> Once this is done, a regular system (without huge BPF program or huge
> modules) will just use 1x 2MB page for text from module, ftrace, kprobe, 
> and bpf programs. 

That would be nice, if possible, however modules will require likely its
own thing, on my system I see about 57 MiB used on coresize alone.

lsmod | grep -v Module | cut -f1 -d ' ' | \
	xargs sudo modinfo | grep filename | \
	grep -o '/.*' | xargs stat -c "%s - %n" | \
	awk 'BEGIN {sum=0} {sum+=$1} END {print sum}'
60001272

And so perhaps we need such a pool size to be configurable.

> > But a vmalloc_ro_exec() with a respective free can remove the
> > requirement to do set_vm_flush_reset_perms().
> 
> Removing the requirement to set_vm_flush_reset_perms() is the other
> reason to go directly to vmalloc_ro_exec(). 

Yes fantastic.

> My current version looks like this:
> 
> void *vmalloc_exec(unsigned long size);
> void vfree_exec(void *ptr, unsigned int size);
> 
> ro is eliminated as there is no rw version of the API. 

Alright.

I am not sure if 2 MiB will suffice given what I mentioned above, and
what to do to ensure this grows at a reasonable pace. Then, at least for
usage for all architectures since not all will support text_poke() we
will want to consider a way to make it easy to users to use non huge
page fallbacks, but that would be up to those users, so we can wait for
that.

> The ugly part is @size for vfree_exec(). We need it to share huge 
> pages. 

I suppose this will become evident during patch review.

> Under the hood, it looks similar to current bpf_prog_pack_alloc
> and bpf_prog_pack_free. 

Groovy.

  Luis
