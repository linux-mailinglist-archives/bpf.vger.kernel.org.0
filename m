Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7725FF60F2
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKITB5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Nov 2019 14:01:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36678 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfKITB5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Nov 2019 14:01:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so6328207pgh.3
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2019 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yivIudvULjNgZgb4i/54TlmMgXtkAElEU6OtffgUjYI=;
        b=JhJjm+4XOissMYVYWXY9wzdU+nBYr8AMp+KKoecUiXoA2JkBye7+MIlcT7q7MM0dJd
         nrQs/AEvp2FxFwaj/6vsCXAaHlhBfQRC1gs2lF+T1mYqcoFPW/xJ95K8RnPCWqLtuE8I
         smqL4dV1qwVEwiyEQcOWXSLTj0SIjb7ivEKL5yCwDcLLyFS5W6aWWMhAMHGa26KTBwfp
         0QnfPL5OHmlTlp3HzfyGW7AaM8IDsITGBPpKOFdeYmz4bh5rsM85ZPRzSYNqmviFYXC1
         3Ki1PMTDiQCODLuJaaQ1hgwmIBwF/alDzG/A3Jur47tWorCnUdX/COzslx/doQb0+BWF
         okKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yivIudvULjNgZgb4i/54TlmMgXtkAElEU6OtffgUjYI=;
        b=HwgO2UwUaf+/y5788b0DqjGureEjgT3vaUXIrj/vhMfTv+u63/DL3LifKBxvW+JxbF
         t8YrFzSbAF2mcFN+5zxs+f5bwDBiDNK0/HbH1EP+Cmzzw7qeyTTPQFK4SO13tprRb0pQ
         eJkN86PXfCVGWSaf9S1xXxa//SM7mR3rH0lvZGB0MHTJyZ26iy8NZhZc7yXLCrBLIUk0
         CrcsKdCja8Sxsf68DMBgYlpCpEql+9c7p1tOXnZZMjBD1tDwNagm3hJLzNQhBNG+E4ro
         NB3t01ffec8osc53Oz76LFLwAfpFXYyveK4RK9/sTrHR02DkVBLzIS8LH5M3rhZDhgP2
         fUhQ==
X-Gm-Message-State: APjAAAXC73D/xeGN9D+cl7Jl6zsPXNAFF8Vt5AdDJTu2c7ai5w9YRDte
        2+ngSRY25Zx8m1aHzk/v3JZC1mzX
X-Google-Smtp-Source: APXvYqz8hZhLIx9D28PUN1EULo7yculyY1Q2Rno1/D7fc1uvvcN5xlV1bRfPV7BRIIXPwhLBER7Zbw==
X-Received: by 2002:a17:90a:3486:: with SMTP id p6mr23495484pjb.102.1573326116887;
        Sat, 09 Nov 2019 11:01:56 -0800 (PST)
Received: from udknight.localhost ([59.57.230.80])
        by smtp.gmail.com with ESMTPSA id c9sm16110195pfb.114.2019.11.09.11.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 11:01:56 -0800 (PST)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id xA9IaBJQ001390;
        Sun, 10 Nov 2019 02:36:11 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id xA9Ia30n001387;
        Sun, 10 Nov 2019 02:36:03 +0800
Date:   Sun, 10 Nov 2019 02:36:03 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Subject: Re: Fw: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures
 using eBPF JIT
Message-ID: <20191109183602.GA1033@udknight>
References: <20191108075711.115a5f94@hermes.lan>
 <08b98fbd-f295-3a94-8b3e-70790179290c@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b98fbd-f295-3a94-8b3e-70790179290c@iogearbox.net>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 09, 2019 at 12:37:49AM +0100, Daniel Borkmann wrote:
> [ Cc Wang (x86_32 BPF JIT maintainer) ]
> 
> On 11/8/19 4:57 PM, Stephen Hemminger wrote:
> > 
> > Begin forwarded message:
> > 
> > Date: Fri, 08 Nov 2019 07:35:59 +0000
> > From: bugzilla-daemon@bugzilla.kernel.org
> > To: stephen@networkplumber.org
> > Subject: [Bug 205469] New: x86_32: bpf: multiple test_bpf failures using eBPF JIT
> > 
> > 
> > https://bugzilla.kernel.org/show_bug.cgi?id=205469
> > 
> >              Bug ID: 205469
> >             Summary: x86_32: bpf: multiple test_bpf failures using eBPF JIT
> >             Product: Networking
> >             Version: 2.5
> >      Kernel Version: 4.19.81 LTS
> >            Hardware: i386
> >                  OS: Linux
> >                Tree: Mainline
> >              Status: NEW
> >            Severity: normal
> >            Priority: P1
> >           Component: Other
> >            Assignee: stephen@networkplumber.org
> >            Reporter: itugrok@yahoo.com
> >                  CC: itugrok@yahoo.com
> >          Regression: No
> > 
> > Created attachment 285829
> >    --> https://bugzilla.kernel.org/attachment.cgi?id=285829&action=edit
> > test_bpf failures: kernel 4.19.81/x86_32 (OpenWrt)
> > 
> > Summary:
> > ========
> > 
> > Running the 4.19.81 LTS kernel on QEMU/x86_32, the standard test_bpf.ko
> > testsuite generates multiple errors with the eBPF JIT enabled:
> > 
> >    ...
> >    test_bpf: #32 JSET jited:1 40 ret 0 != 20 46 FAIL
> >    test_bpf: #321 LD_IND word positive offset jited:1 ret 0 != -291897430 FAIL
> >    test_bpf: #322 LD_IND word negative offset jited:1 ret 0 != -1437222042 FAIL
> >    test_bpf: #323 LD_IND word unaligned (addr & 3 == 2) jited:1 ret 0 !=
> > -1150890889 FAIL
> >    test_bpf: #326 LD_IND word positive offset, all ff jited:1 ret 0 != -1 FAIL
> >    ...
> >    test_bpf: Summary: 373 PASSED, 5 FAILED, [344/366 JIT'ed]
> > 
> > However, with eBPF JIT disabled (net.core.bpf_jit_enable=0) all tests pass.
> > 
> > 
> > Steps to Reproduce:
> > ===================
> > 
> >    # sysctl net.core.bpf_jit_enable=1
> >    # modprobe test_bpf
> >    <Kernel log with failures and test summary>
> > 
> > 
> > Affected Systems Tested:
> > ========================
> > 
> >    OpenWrt master on QEMU/pc-q35(x86_32) [LTS kernel 4.19.81]
> > 
> > 
> > Kernel Logs:
> > ============
> > 
> > Boot log with test results is attached.
> > 

Hi Daniel Borkmann!

I have tested and verified that the report bug has been fixed by commit
711aef1bbf88 ("bpf, x32: Fix bug for BPF_JMP | {BPF_JSGT, BPF_JSLE, BPF_JSLT, BPF_JSGE}")

But that fix hasn't been backport to stable trees, so maybe we should do it:)

