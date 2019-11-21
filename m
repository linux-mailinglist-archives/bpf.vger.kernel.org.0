Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7708105B33
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 21:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfKUUhK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 15:37:10 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49405 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfKUUhK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Nov 2019 15:37:10 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A444222A51;
        Thu, 21 Nov 2019 15:37:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Nov 2019 15:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=S9NNL0z4ZMCN7mJJB95997u5ZmZ
        /NsmBEjRnkw7He7k=; b=OR+DRRH9bsnDA99XTJIgoiCgc7FBkN3WIOu9lTr+TSx
        q1QQkeQMX6/UXZOckY5h6rQrpcPbxK1Nj4oycRtBVROgtZ41KhbEO0ayB1g4fsnc
        vMOJnBzoVM/nz+IJEUOk1eVIvNlH+kr7+Qy6quf7Ds918odXstP17XsGEXuDAI7k
        B2XHP86XmrHxfubL8xNUro0LDZUobSdZhx/FMO01qZTyKEi3YTHDMsmgOl1T2JoG
        8vXV+/ccYcGS2rbfaOnmPvGya2Yc2pe9AwAxoaene2/+/GYajsBX7xZ5OGZNGAKI
        +AM3RUiPEn4ORYkib4AXKRz6TrwhktTg3cfDhNEoKrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=S9NNL0
        z4ZMCN7mJJB95997u5ZmZ/NsmBEjRnkw7He7k=; b=osMGbLFuRY8IcDyxsXq+y/
        zo2qLv+ruzQi5BQVqK5SZ+RaguEtS0EIMyRWl8+uYbmsX4AqU1xpHsWRGOXNQKne
        5qJwrmbVIvNjgJFmLdF6NW2lPXdao4NfwtOCLtzDFv2XUNUluT3Mx6leWVKtqcAL
        O3yE8mJjlLT7imcN+pZebH81+z2xv9KRa6erBd5V3lwo5yOb0GYqio+EW94X8Gi8
        N/pLMPbDqTfDrqklhqhM86AjECqifXxOVnX2uwFYx6TI9LfKJx1H24IYgAR1mm4L
        tbiF1bwZ4UgLkDq5JK/l6t5t6nH9vlnGA+0vqvt48P1YkeGplKXnSWp6ptFpdYOg
        ==
X-ME-Sender: <xms:dPXWXQzGNUGTTEOiDkXNdf8QK-WtAlyn690FUCyaJB4u2XFTmm3xgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehvddgudegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhf
    rhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:dPXWXfIkt3zfnEkBLyAUYu-kWjE4Nkt2is28hQwuGYDYBkZYxzBEqw>
    <xmx:dPXWXaLncvMenjKfnPtiirXlC40L5jwYtuSpsduYF30Y9lymKoFLrg>
    <xmx:dPXWXcs5SlcFH9fatlgm2Az4DwCfHgnmGcZvasquILdb6xEdIyyp7w>
    <xmx:dPXWXbHfYKD7ZF8t5JDun8-tA5npMjDAo9KWNH8kTytcgRJ6Ta_S-Q>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id EBE12306005E;
        Thu, 21 Nov 2019 15:37:07 -0500 (EST)
Date:   Thu, 21 Nov 2019 21:37:06 +0100
From:   Greg KH <greg@kroah.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Wang YanQing <udknight@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: Re: Fw: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures
 using eBPF JIT
Message-ID: <20191121203706.GD813260@kroah.com>
References: <20191108075711.115a5f94@hermes.lan>
 <08b98fbd-f295-3a94-8b3e-70790179290c@iogearbox.net>
 <20191109183602.GA1033@udknight>
 <69c1fa5e-7385-fe8d-ac17-42d22db84cf4@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69c1fa5e-7385-fe8d-ac17-42d22db84cf4@iogearbox.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 11, 2019 at 01:56:31PM +0100, Daniel Borkmann wrote:
> On 11/9/19 7:36 PM, Wang YanQing wrote:
> > On Sat, Nov 09, 2019 at 12:37:49AM +0100, Daniel Borkmann wrote:
> > > [ Cc Wang (x86_32 BPF JIT maintainer) ]
> > > 
> > > On 11/8/19 4:57 PM, Stephen Hemminger wrote:
> > > > 
> > > > Begin forwarded message:
> > > > 
> > > > Date: Fri, 08 Nov 2019 07:35:59 +0000
> > > > From: bugzilla-daemon@bugzilla.kernel.org
> > > > To: stephen@networkplumber.org
> > > > Subject: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures using eBPF JIT
> > > > 
> > > > 
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=205469
> > > > 
> > > >               Bug ID: 205469
> > > >              Summary: x86_32: bpf: multiple test_bpf failures using eBPF JIT
> > > >              Product: Networking
> > > >              Version: 2.5
> > > >       Kernel Version: 4.19.81 LTS
> > > >             Hardware: i386
> > > >                   OS: Linux
> > > >                 Tree: Mainline
> > > >               Status: NEW
> > > >             Severity: normal
> > > >             Priority: P1
> > > >            Component: Other
> > > >             Assignee: stephen@networkplumber.org
> > > >             Reporter: itugrok@yahoo.com
> > > >                   CC: itugrok@yahoo.com
> > > >           Regression: No
> > > > 
> > > > Created attachment 285829
> > > >     --> https://bugzilla.kernel.org/attachment.cgi?id=285829&action=edit
> > > > test_bpf failures: kernel 4.19.81/x86_32 (OpenWrt)
> > > > 
> > > > Summary:
> > > > ========
> > > > 
> > > > Running the 4.19.81 LTS kernel on QEMU/x86_32, the standard test_bpf.ko
> > > > testsuite generates multiple errors with the eBPF JIT enabled:
> > > > 
> > > >     ...
> > > >     test_bpf: #32 JSET jited:1 40 ret 0 != 20 46 FAIL
> > > >     test_bpf: #321 LD_IND word positive offset jited:1 ret 0 != -291897430 FAIL
> > > >     test_bpf: #322 LD_IND word negative offset jited:1 ret 0 != -1437222042 FAIL
> > > >     test_bpf: #323 LD_IND word unaligned (addr & 3 == 2) jited:1 ret 0 !=
> > > > -1150890889 FAIL
> > > >     test_bpf: #326 LD_IND word positive offset, all ff jited:1 ret 0 != -1 FAIL
> > > >     ...
> > > >     test_bpf: Summary: 373 PASSED, 5 FAILED, [344/366 JIT'ed]
> > > > 
> > > > However, with eBPF JIT disabled (net.core.bpf_jit_enable=0) all tests pass.
> > > > 
> > > > 
> > > > Steps to Reproduce:
> > > > ===================
> > > > 
> > > >     # sysctl net.core.bpf_jit_enable=1
> > > >     # modprobe test_bpf
> > > >     <Kernel log with failures and test summary>
> > > > 
> > > > 
> > > > Affected Systems Tested:
> > > > ========================
> > > > 
> > > >     OpenWrt master on QEMU/pc-q35(x86_32) [LTS kernel 4.19.81]
> > > > 
> > > > 
> > > > Kernel Logs:
> > > > ============
> > > > 
> > > > Boot log with test results is attached.
> > > > 
> > 
> > Hi Daniel Borkmann!
> > 
> > I have tested and verified that the report bug has been fixed by commit
> > 711aef1bbf88 ("bpf, x32: Fix bug for BPF_JMP | {BPF_JSGT, BPF_JSLE, BPF_JSLT, BPF_JSGE}")
> > 
> > But that fix hasn't been backport to stable trees, so maybe we should do it:)
> 
> Yes, given you have access to a x32 setup and are also able to runtime test the backported
> JIT changes, please submit it to stable with us in Cc. Thanks Wang!

Backporting this would be nice if someone could do it :)

thanks,

greg k-h
