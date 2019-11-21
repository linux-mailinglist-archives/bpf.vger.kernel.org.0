Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920D3105B53
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 21:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfKUUrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 15:47:06 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56751 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbfKUUrG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Nov 2019 15:47:06 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CB3AC22A3D;
        Thu, 21 Nov 2019 15:47:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Nov 2019 15:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=kwbDiFNmhsVb1vd4MRG73FMK+4G
        jURw5B90Y8jrA7O0=; b=Da0js/uHz1gVhpTPNGgC5IB3aeNstxs3u2Tfz173TNB
        3XqR9qcJbwefhrhv9ri8BmdqhPzIc8mBP8ijwjioVHSdoLSDczPr5KT4v9/+E83R
        m/3WtiS8WhEpGTP1+xTeQNcPpPt5rExpumxfVREu1F+o/jvf5LdF1VOHiKi4edXx
        QLZw89Q5gxVc9/q2KDU6ZYNJSAg94UdcbUIPtFAhOTGHMciHRUVV/6j43FBjtUWb
        Z6H0w80juSNppBgzmg13Y7MzrjNeAR36GWQBwNGvAHe3erw30mR+zhxtQio7BcF1
        jrMUPCbeQYUYqzegrWnFL6du1/IQ+oM+KHsSy9h6sAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kwbDiF
        NmhsVb1vd4MRG73FMK+4GjURw5B90Y8jrA7O0=; b=rbZSVZAy6Lwe5TwRQ1QzR/
        6AF0Vy4oml6P3Q8K0fPTqIVpbifml9rIyoF1bY3zbTTBDSq52H6a/sC3BqjFnXBv
        Q+SE/Bn+5eBeaeo6oYSeT7z6ipHaRwQnC3RataL47eEHJx0dzja62goKIcuQz4h3
        oyzN9INRJhHyBIdbXAOYjdffdS/mjPw+ZIa3idK8hX/bLZNQLo29unEWIYXWr4Sq
        EEYxFuw94i2ItEylQX/AutwOW3BAboAiMYBZ1J+3Yz42bR/TORVzuf9UHxe73eqh
        MaVnIhnFjdNG7HR6abYrV2RlgTZTvpDyVj+STWpcVJVgss5teitJpxR987FOxzjg
        ==
X-ME-Sender: <xms:yffWXQ0y0MaBOOa-m8b45wlol5wL2AB1rnydHZ0akZLlLXRhuTxsJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehvddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhf
    rhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:yffWXfXyvb5dTIDd5kfKO6yjDPkmmuBfvzj4WbmKmTdnfYImszWIwg>
    <xmx:yffWXT59rxA99htzaalpa0aPpN94YHRxlSOawr0t0y78qX2NkVWAxA>
    <xmx:yffWXeIQZQ0w8p7VseheY9BO4bvI5tuRvS6JmEiBe1J4EoRcxPwFXg>
    <xmx:yffWXaGu33zfp6R9i5Ji3zHfw3cN8o6cCE-wrOcUaowujd9xMcwiJw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0FF653060061;
        Thu, 21 Nov 2019 15:47:04 -0500 (EST)
Date:   Thu, 21 Nov 2019 21:47:03 +0100
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
Message-ID: <20191121204703.GA839951@kroah.com>
References: <20191108075711.115a5f94@hermes.lan>
 <08b98fbd-f295-3a94-8b3e-70790179290c@iogearbox.net>
 <20191109183602.GA1033@udknight>
 <69c1fa5e-7385-fe8d-ac17-42d22db84cf4@iogearbox.net>
 <20191121203706.GD813260@kroah.com>
 <b5f589e6-d105-fa98-efce-0b088ff4da6a@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5f589e6-d105-fa98-efce-0b088ff4da6a@iogearbox.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 21, 2019 at 09:42:54PM +0100, Daniel Borkmann wrote:
> On 11/21/19 9:37 PM, Greg KH wrote:
> > On Mon, Nov 11, 2019 at 01:56:31PM +0100, Daniel Borkmann wrote:
> > > On 11/9/19 7:36 PM, Wang YanQing wrote:
> > > > On Sat, Nov 09, 2019 at 12:37:49AM +0100, Daniel Borkmann wrote:
> > > > > [ Cc Wang (x86_32 BPF JIT maintainer) ]
> > > > > 
> > > > > On 11/8/19 4:57 PM, Stephen Hemminger wrote:
> > > > > > 
> > > > > > Begin forwarded message:
> > > > > > 
> > > > > > Date: Fri, 08 Nov 2019 07:35:59 +0000
> > > > > > From: bugzilla-daemon@bugzilla.kernel.org
> > > > > > To: stephen@networkplumber.org
> > > > > > Subject: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures using eBPF JIT
> > > > > > 
> > > > > > 
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=205469
> > > > > > 
> > > > > >                Bug ID: 205469
> > > > > >               Summary: x86_32: bpf: multiple test_bpf failures using eBPF JIT
> > > > > >               Product: Networking
> > > > > >               Version: 2.5
> > > > > >        Kernel Version: 4.19.81 LTS
> > > > > >              Hardware: i386
> > > > > >                    OS: Linux
> > > > > >                  Tree: Mainline
> > > > > >                Status: NEW
> > > > > >              Severity: normal
> > > > > >              Priority: P1
> > > > > >             Component: Other
> > > > > >              Assignee: stephen@networkplumber.org
> > > > > >              Reporter: itugrok@yahoo.com
> > > > > >                    CC: itugrok@yahoo.com
> > > > > >            Regression: No
> > > > > > 
> > > > > > Created attachment 285829
> > > > > >      --> https://bugzilla.kernel.org/attachment.cgi?id=285829&action=edit
> > > > > > test_bpf failures: kernel 4.19.81/x86_32 (OpenWrt)
> > > > > > 
> > > > > > Summary:
> > > > > > ========
> > > > > > 
> > > > > > Running the 4.19.81 LTS kernel on QEMU/x86_32, the standard test_bpf.ko
> > > > > > testsuite generates multiple errors with the eBPF JIT enabled:
> > > > > > 
> > > > > >      ...
> > > > > >      test_bpf: #32 JSET jited:1 40 ret 0 != 20 46 FAIL
> > > > > >      test_bpf: #321 LD_IND word positive offset jited:1 ret 0 != -291897430 FAIL
> > > > > >      test_bpf: #322 LD_IND word negative offset jited:1 ret 0 != -1437222042 FAIL
> > > > > >      test_bpf: #323 LD_IND word unaligned (addr & 3 == 2) jited:1 ret 0 !=
> > > > > > -1150890889 FAIL
> > > > > >      test_bpf: #326 LD_IND word positive offset, all ff jited:1 ret 0 != -1 FAIL
> > > > > >      ...
> > > > > >      test_bpf: Summary: 373 PASSED, 5 FAILED, [344/366 JIT'ed]
> > > > > > 
> > > > > > However, with eBPF JIT disabled (net.core.bpf_jit_enable=0) all tests pass.
> > > > > > 
> > > > > > 
> > > > > > Steps to Reproduce:
> > > > > > ===================
> > > > > > 
> > > > > >      # sysctl net.core.bpf_jit_enable=1
> > > > > >      # modprobe test_bpf
> > > > > >      <Kernel log with failures and test summary>
> > > > > > 
> > > > > > 
> > > > > > Affected Systems Tested:
> > > > > > ========================
> > > > > > 
> > > > > >      OpenWrt master on QEMU/pc-q35(x86_32) [LTS kernel 4.19.81]
> > > > > > 
> > > > > > 
> > > > > > Kernel Logs:
> > > > > > ============
> > > > > > 
> > > > > > Boot log with test results is attached.
> > > > > > 
> > > > 
> > > > Hi Daniel Borkmann!
> > > > 
> > > > I have tested and verified that the report bug has been fixed by commit
> > > > 711aef1bbf88 ("bpf, x32: Fix bug for BPF_JMP | {BPF_JSGT, BPF_JSLE, BPF_JSLT, BPF_JSGE}")
> > > > 
> > > > But that fix hasn't been backport to stable trees, so maybe we should do it:)
> > > 
> > > Yes, given you have access to a x32 setup and are also able to runtime test the backported
> > > JIT changes, please submit it to stable with us in Cc. Thanks Wang!
> > 
> > Backporting this would be nice if someone could do it :)
> 
> It landed on the stable list today:
> 
> https://lore.kernel.org/stable/20191121074336.GA15326@udknight/
> https://lore.kernel.org/stable/20191121074725.GA15476@udknight/
> https://lore.kernel.org/stable/20191121074511.GC15326@udknight/
> https://lore.kernel.org/stable/20191121074452.GB15326@udknight/

Ugh, I totally missed them as they got filed into my bpf@ mailing list
mbox.  Thanks, I'll go dig them up now!

greg k-h
