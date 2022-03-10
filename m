Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD824D3E2C
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 01:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiCJAbm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 19:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiCJAbl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 19:31:41 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D90C124C28
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 16:30:42 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id l20so6615246lfg.12
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 16:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bEaQ5W7/uwxuPOhbs7aFS9WiQFjr1dAU1fc+RFzx3w=;
        b=GO1t2zd3diCLOfc1GR/4QHxRBwrXV3/Ri2DyCkq4E1Njl+mjDqufI33kutF5DdEGbM
         gwB9uJ0GOTZZadP1Tx+ogWkrvDnn+qqvel7Ys+vdsRnsIM9i3ysfWrJ4HXUr8JdUKcrm
         8A2f7TXgUf1IHxsom0VuQZ+muNjQGSsk5YvC8JFZvHiaS81hWoKbwhk3n+AEmcByhmI2
         3xtNdmnsv5psAM65huJgPO0CxRkkDVJDB4Sjet93q4qclZOwmw6QnjR5wd7Yv/wnoodE
         3FRZGLdaYleo426aRw5WO3nGJPErBzgC1aGr/9IMEZoxny2/W4khl7VKOy0p1ToVzBr3
         HfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bEaQ5W7/uwxuPOhbs7aFS9WiQFjr1dAU1fc+RFzx3w=;
        b=P577fWcFc6VnsN49WXerMRNCXAQP5xthrorG6DEZtoo9aF+6oIqtMAoIiXW4XB1DVJ
         rXzV327piy2X0ffyhDOAXnjq3X7oZkfFRE1uCzhlerGaQv/D2HqWwCpE06Uj5RKRu5jh
         tiLyFKrUxpu5ypSvAkU1as/NxYlGOZe77ES9wcy4VN17sbR+Q8heLWyMfVXmBGtxVRuZ
         ExfJZWHm5sYf6IOzVS+3YSZf6oXj9mQhrgstJJE4oHnzImsvGZ2R7jjiu874iVKUrxjY
         M3d5VfDyCZOApjNX246WCeQMghrdeCoHlt3izfkTOdk7j8G4Nvhdr4tQoX3g1rShRTXg
         avpw==
X-Gm-Message-State: AOAM53313X+ecCL4TZx8GdTnLVtVTRWvNdhkaGeLeFlQmxyUXw1IIEYi
        +fw7WSx5jnDH8aZBhCntDRROrpci/GgwQoEHEqd58g==
X-Google-Smtp-Source: ABdhPJzUUdb5H/LMWsKDBHyHNBeZMnD/yO8aJ/W7N28+TxUIsfQLa/4g1x3U6w4mi39mlp++/YJ9Y98gdyc+MF3LGG0=
X-Received: by 2002:a05:6512:308e:b0:448:3826:6d68 with SMTP id
 z14-20020a056512308e00b0044838266d68mr1329592lfd.184.1646872240210; Wed, 09
 Mar 2022 16:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20220308153011.021123062@infradead.org> <20220308200052.rpr4vkxppnxguirg@ast-mbp.dhcp.thefacebook.com>
 <YifSIDAJ/ZBKJWrn@hirez.programming.kicks-ass.net> <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
In-Reply-To: <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 9 Mar 2022 16:30:28 -0800
Message-ID: <CAKwvOdk0ROSOSDKHcyH0kP+5MFH5QnasD6kbAu8gG8CCXO7OmQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 8, 2022 at 2:32 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 08, 2022 at 11:01:04PM +0100, Peter Zijlstra wrote:
> > On Tue, Mar 08, 2022 at 12:00:52PM -0800, Alexei Starovoitov wrote:
> > > On Tue, Mar 08, 2022 at 04:30:11PM +0100, Peter Zijlstra wrote:
> > > > Hopefully last posting...
> > > >
> > > > Since last time:
> > > >  - verified clang-14-rc2 works
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt

I observed the following error when building with
CONFIG_LTO_CLANG_FULL=y enabled:

ld.lld: error: ld-temp.o <inline asm>:7:2: symbol 'ibt_selftest_ip' is
already defined
        ibt_selftest_ip:
        ^

Seems to come from
commit a802350ba65a ("x86/ibt: Add IBT feature, MSR and #CP handling")

Commenting out the label in the inline asm, I then observed:
vmlinux.o: warning: objtool: identify_cpu()+0x6d0: sibling call from
callable instruction with modified stack frame
vmlinux.o: warning: objtool: identify_cpu()+0x6e0: stack state
mismatch: cfa1=4+64 cfa2=4+8
These seemed to disappear when I kept CONFIG_LTO_CLANG_FULL=y but then
disabled CONFIG_X86_KERNEL_IBT. (perhaps due to the way I hacked out
the ibt_selftest_ip label).

Otherwise defconfig and CONFIG_LTO_CLANG_THIN=y both built and booted
in a vm WITHOUT IBT support.

Any idea what's the status of IBT emulation in QEMU, and if it exists,
what's the necessary `-cpu` flag to enable it?
-- 
Thanks,
~Nick Desaulniers
