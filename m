Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903C383ECD
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 03:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfHGBbv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Aug 2019 21:31:51 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36501 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfHGBbu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Aug 2019 21:31:50 -0400
Received: by mail-yb1-f193.google.com with SMTP id d9so25075782ybf.3
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2019 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T+sIdUCYVl9gdRoUkUG8PgRAt1MU+/JJSzC8cSPoyKI=;
        b=F4m9knohPlyqe6iRBIqFogCxSMnpxfTnrNWZCR9yxgbB7jxuwk5G49Fr3Yk/Xw8ml9
         BZedneP/R5GsmdKW1zaP8a4d6U9JK6r3soeGP9+77jQo83aNdUFu0Pg6auBFzgfb745n
         qZmIri2k5kirqo1rqRPqFtkeh+UaJ+gxE46qehbsLCBwyMGNAb4LzWNxxchylTugTGzF
         wLgGzWBtDpvrUKQxeBDO2XcdIgDVq4u0XiNjVcNspdW/kjB7dA7kKn81qOuPuEq5vT9D
         CCLS3aa+sHxb6m2tFFPS/rslez9LrTny5DfBMNa9fxii55Xz7IiwhaDAn2k/m6Tso2Db
         5r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T+sIdUCYVl9gdRoUkUG8PgRAt1MU+/JJSzC8cSPoyKI=;
        b=NRos56UvZi+WwHd+fRw+1CbwenR4KOb7p5nKkh6Xdg/SmH/zmuAjgFzCgH6K+GGIOF
         GIBE87nBP93SwpJVlLisFgaLOdHNfy2sRKV6xBPIN3q/B6QnkRVGEy0yGubbcwJOS0gC
         SIShzrxLLKfW+OYzHV+27iC5e76UaXyL6ghP0uylzNeOL+k4DFSV8NuNHJZtsrH+3g1L
         rYe9RwaauI0Sw7ABOrWRjtQBDn9wofm+i2RWU+4pl4G2uM1H7gGqjkASrXASuu5Vcmxn
         FjoEDUlcJ7JfPN73xSbnjqxf0dUyd0sjTZG2aOw0s+a+EgM2hA9XqkKqC2c5M8iYwSrI
         USig==
X-Gm-Message-State: APjAAAVn1b6CdTDfhFKujXDM7m9hxySBHjpgOTMiY/QgbR/pWaUeBB9F
        Gc02XpbDQFcY+OG1W77rFK2maA==
X-Google-Smtp-Source: APXvYqwBSZkykF5JBW3dZ2JAWQGnqKUHEgflynlYlJTG89ph5DdcJK1w1FbC6oyDXFDuWZCqly8qmQ==
X-Received: by 2002:a25:5986:: with SMTP id n128mr4697126ybb.301.1565141510026;
        Tue, 06 Aug 2019 18:31:50 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id k20sm20014855ywm.106.2019.08.06.18.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 18:31:49 -0700 (PDT)
Date:   Wed, 7 Aug 2019 09:31:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2 0/3] arm/arm64: Add support for function error
 injection
Message-ID: <20190807013139.GB6724@leoy-ThinkPad-X240s>
References: <20190806100015.11256-1-leo.yan@linaro.org>
 <20190807090811.1e50eb3e1d5a7b85743748e7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807090811.1e50eb3e1d5a7b85743748e7@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 07, 2019 at 09:08:11AM +0900, Masami Hiramatsu wrote:
> On Tue,  6 Aug 2019 18:00:12 +0800
> Leo Yan <leo.yan@linaro.org> wrote:
> 
> > This small patch set is to add support for function error injection;
> > this can be used to eanble more advanced debugging feature, e.g.
> > CONFIG_BPF_KPROBE_OVERRIDE.
> > 
> > The patch 01/03 is to consolidate the function definition which can be
> > suared cross architectures, patches 02,03/03 are used for enabling
> > function error injection on arm64 and arm architecture respectively.
> > 
> > I tested on arm64 platform Juno-r2 and one of my laptop with x86
> > architecture with below steps; I don't test for Arm architecture so
> > only pass compilation.
> > 
> > - Enable kernel configuration:
> >   CONFIG_BPF_KPROBE_OVERRIDE
> >   CONFIG_BTRFS_FS
> >   CONFIG_BPF_EVENTS=y
> >   CONFIG_KPROBES=y
> >   CONFIG_KPROBE_EVENTS=y
> >   CONFIG_BPF_KPROBE_OVERRIDE=y
> > 
> > - Build samples/bpf on with Debian rootFS:
> >   # cd $kernel
> >   # make headers_install
> >   # make samples/bpf/ LLC=llc-7 CLANG=clang-7
> > 
> > - Run the sample tracex7:
> >   # dd if=/dev/zero of=testfile.img bs=1M seek=1000 count=1
> >   # DEVICE=$(losetup --show -f testfile.img)
> >   # mkfs.btrfs -f $DEVICE
> >   # ./tracex7 testfile.img
> >   [ 1975.211781] BTRFS error (device (efault)): open_ctree failed
> >   mount: /mnt/linux-kernel/linux-cs-dev/samples/bpf/tmpmnt: mount(2) system call failed: Cannot allocate memory.
> > 
> > Changes from v1:
> > * Consolidated the function definition into asm-generic header (Will);
> > * Used APIs to access pt_regs elements (Will);
> > * Fixed typos in the comments (Will).
> 
> This looks good to me.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you!

Thanks a lot for reviewing, Masami.

Leo.
