Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B8867F329
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjA1Abb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjA1Ab1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:31:27 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C8F7A93
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:31:07 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C0A6D320094B;
        Fri, 27 Jan 2023 19:23:30 -0500 (EST)
Received: from imap42 ([10.202.2.92])
  by compute1.internal (MEProxy); Fri, 27 Jan 2023 19:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674865410; x=1674951810; bh=XkwRqtsAcS
        RGNliBPzGdjn6EE4bshUlyrh0HYCfx8BA=; b=R5m0FJ1q8J09R/0wLGYTgp33lq
        WS82+r+wsZQx7iF8UGDEsMHXdTJT9B0kFvWGBh9oOEbE+xgUogNrz3Yf3Gl8owcE
        v31Q3wCHKM09h8XWmLdTrpEburHzGUukre0JOBYYTL8ioYxegj5LSdDc3KZE9a1u
        Lf+j2OztDNFSwytb9M4VmsZpaqYgHT1memwUS5K07iHY4V0fxleKcUNKTCR5fw/7
        z2B9PHd+bhJYNDpCE84gZl6gmQjR1Ipb64GhnZH6NcoYlIbxR0iF6U0PyQSFYJqV
        zydVZLAQ8qymuvm6dpoYpVNBtT9S4vZd4Qa+7tdspcmD5YAmutUbXTjVDlwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674865410; x=1674951810; bh=XkwRqtsAcSRGNliBPzGdjn6EE4bs
        hUlyrh0HYCfx8BA=; b=ZkcdGbYL+jaYkdyApEEOuxRzCcJdv/MMrE06OG069zBk
        rcLFjuEKuE5hulKvVBm3SiBt4089x7fY/MiW7algppaPcjnVD56NW/YBJtWghoup
        DgKHIqd6VF5nogUm2VBtOpjegBaMEHsanK/hTSv+oyzHOb+4GvOrM1JVuwmleD3O
        2LUaLyf09TTA3+UjJaiYKkOWisMn06yzTb7Eqv5a5efXpcYdFG2XRlywUoJSx4US
        bkqZP41TWtvceFrreobVLMaDZgieYCK3rAg81ohArkiK4qLg/f5TCKQX3L1C2i5U
        3uGfniEu0uCVAVxPH//CB+g0XM9urewD4M2ETCCTMg==
X-ME-Sender: <xms:AmvUY-i4YAf489t7Z7CDZEZ8v9GPcqRDaBPojxyZD1ydu-AWImnPpQ>
    <xme:AmvUY_BGJfiA-y577xs2fnIdR477EhHmVHgS3HzGK4jkFKIO8ZfmezzKnT1W2N7vN
    Yb7DgNqaY5h7ED9iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvjedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucggtffrrghtthgvrhhnpeetleffffehgfeigfetleeuteehfeetleduudffleet
    vdfgudejjedvhfejgfduveenucffohhmrghinhepkhgrlhhlshihmhhsuddrshgrshdpkh
    grlhhlshihmhhsvddrshgrshdpkhgrlhhlshihmhhsfedrshgrshdpvhhmthgvshhtrdhs
    hhdpugiguhhuuhdrgiihiienucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:AmvUY2EsO6JNbtQs4TcgCKPFDd2NGvQhxFmH_9S8eiqA4pfIR1t7uw>
    <xmx:AmvUY3R3YImr7fID_0rIoLuemPV2_XOVU0P9LCygznDZ1qamaw0dZw>
    <xmx:AmvUY7zYmBxvH2ZwRHzXp_09aoRyy8qcFJGmVxqhgryhbmTmBKCU5g>
    <xmx:AmvUY0p9uwo-eCcMumt4HAO5dWtYiYFsgQO-60glNQRhgoJab1gU7g>
Feedback-ID: i6a694271:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2397FBC0078; Fri, 27 Jan 2023 19:23:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <ff12051b-e8f9-44d7-a8ea-5fa7094375e6@app.fastmail.com>
In-Reply-To: <070e7661-8b19-417f-8e16-8ccc34d6c7bc@app.fastmail.com>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
 <Y85AHdWw/l8d1Gsp@krava>
 <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
 <bb569967-d33a-7252-964b-a36501b3366a@gmail.com> <Y9RlpyV5JPz/hk1K@krava>
 <070e7661-8b19-417f-8e16-8ccc34d6c7bc@app.fastmail.com>
Date:   Fri, 27 Jan 2023 17:23:08 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Jiri Olsa" <olsajiri@gmail.com>,
        "Alexandre Peixoto Ferreira" <alexandref75@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 27, 2023, at 5:21 PM, Daniel Xu wrote:
> Hi Jiri & Alexandre,
>
> On Fri, Jan 27, 2023, at 5:00 PM, Jiri Olsa wrote:
>> On Fri, Jan 27, 2023 at 04:28:54PM -0600, Alexandre Peixoto Ferreira wrote:
>>> 
>>> 
>>> On 1/24/23 00:13, Daniel Xu wrote:
>>> > Hi Jiri,
>>> > 
>>> > On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
>>> > > On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
>>> > > > Hi,
>>> > > > 
>>> > > > I'm getting the following error during build:
>>> > > > 
>>> > > >          $ ./tools/testing/selftests/bpf/vmtest.sh -j30
>>> > > >          [...]
>>> > > >            BTF     .btf.vmlinux.bin.o
>>> > > >          btf_encoder__encode: btf__dedup failed!
>>> > > >          Failed to encode BTF
>>> > > >            LD      .tmp_vmlinux.kallsyms1
>>> > > >            NM      .tmp_vmlinux.kallsyms1.syms
>>> > > >            KSYMS   .tmp_vmlinux.kallsyms1.S
>>> > > >            AS      .tmp_vmlinux.kallsyms1.S
>>> > > >            LD      .tmp_vmlinux.kallsyms2
>>> > > >            NM      .tmp_vmlinux.kallsyms2.syms
>>> > > >            KSYMS   .tmp_vmlinux.kallsyms2.S
>>> > > >            AS      .tmp_vmlinux.kallsyms2.S
>>> > > >            LD      .tmp_vmlinux.kallsyms3
>>> > > >            NM      .tmp_vmlinux.kallsyms3.syms
>>> > > >            KSYMS   .tmp_vmlinux.kallsyms3.S
>>> > > >            AS      .tmp_vmlinux.kallsyms3.S
>>> > > >            LD      vmlinux
>>> > > >            BTFIDS  vmlinux
>>> > > >          FAILED: load BTF from vmlinux: No such file or directory
>>> > > >          make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>>> > > >          make[1]: *** Deleting file 'vmlinux'
>>> > > >          make: *** [Makefile:1264: vmlinux] Error 2
>>> > > > 
>>> > > > This happens on both bpf-next/master (84150795a49) and 6.2-rc5
>>> > > > (2241ab53cb).
>>> > > > 
>>> > > > I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
>>> > > > upstream pahole on master (02d67c5176) and upstream pahole on
>>> > > > next (2ca56f4c6f659).
>>> > > > 
>>> > > > Of the above 6 combinations, I think I've tried all of them (maybe
>>> > > > missing 1 or 2).
>>> > > > 
>>> > > > Looks like GCC got updated recently on my machine, so perhaps
>>> > > > it's related?
>>> > > > 
>>> > > >          CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
>>> > > > 
>>> > > > I'll try some debugging, but just wanted to report it first.
>>> > > hi,
>>> > > I can't reproduce that.. can you reproduce it outside vmtest.sh?
>>> > > 
>>> > > there will be lot of output with patch below, but could contain
>>> > > some more error output
>>> > Thanks for the hints. Doing a regular build outside of vmtest.sh
>>> > seems to work ok. So maybe it's a difference in the build config.
>>> > 
>>> > I'll put a little more time into debugging to see if it goes anywhere.
>>> > But I'll have to get back to the regularly scheduled programming
>>> > soon.
>>> 6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is commented but fails
>>> in pahole when CONFIG_X86_KERNEL_IBT is set.
>>
>> could you plese attach your config and the build error?
>> I can't reproduce that
>
> I've confirmed that CONFIG_X86_KERNEL_IBT=n fixes my issue as well.
>
> Here is the config that produces my originally reported error:
> https://pastes.dxuuu.xyz/wlg9tb
>
> Thanks,
> Daniel

Here's a patch that helps for me. Not sure if you want to apply this or fix
the root cause in bpftool.

---

From 3dc50f3dd45767cb8c3b32c1510c7064f20f80c1 Mon Sep 17 00:00:00 2001
Message-Id: <3dc50f3dd45767cb8c3b32c1510c7064f20f80c1.1674865319.git.dxu@dxuuu.xyz>
From: Daniel Xu <dxu@dxuuu.xyz>
Date: Fri, 27 Jan 2023 17:17:32 -0700
Subject: [PATCH] bpf, selftests: Disable CONFIG_X86_KERNEL_IBT for vmtest.sh

CONFIG_X86_KERNEL_IBT=y was causing the following compile error:

          BTF     .btf.vmlinux.bin.o
        btf_encoder__encode: btf__dedup failed!
        Failed to encode BTF
          LD      .tmp_vmlinux.kallsyms1
          NM      .tmp_vmlinux.kallsyms1.syms
          KSYMS   .tmp_vmlinux.kallsyms1.S
          AS      .tmp_vmlinux.kallsyms1.S
          LD      .tmp_vmlinux.kallsyms2
          NM      .tmp_vmlinux.kallsyms2.syms
          KSYMS   .tmp_vmlinux.kallsyms2.S
          AS      .tmp_vmlinux.kallsyms2.S
          LD      .tmp_vmlinux.kallsyms3
          NM      .tmp_vmlinux.kallsyms3.syms
          KSYMS   .tmp_vmlinux.kallsyms3.S
          AS      .tmp_vmlinux.kallsyms3.S
          LD      vmlinux
          BTFIDS  vmlinux
        libbpf: failed to find '.BTF' ELF section in vmlinux
        FAILED: load BTF from vmlinux: No data available
        make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 255
        make[1]: *** Deleting file 'vmlinux'
        make: *** [Makefile:1252: vmlinux] Error 2

Disable for vmtests as we do not really need the extra security measures
there.

I suspect this was recently triggered by
4fd5f70ce14d ("x86/Kconfig: Enable kernel IBT by default").

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/config.x86_64 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index dd97d61d325c..3026b1282cc7 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -237,6 +237,7 @@ CONFIG_VIRTIO_PCI=y
 CONFIG_VLAN_8021Q=y
 CONFIG_X86_ACPI_CPUFREQ=y
 CONFIG_X86_CPUID=y
+CONFIG_X86_KERNEL_IBT=n
 CONFIG_X86_MSR=y
 CONFIG_X86_POWERNOW_K8=y
 CONFIG_XDP_SOCKETS_DIAG=y
--
2.39.1
