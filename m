Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99FC574460
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 07:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbiGNFN0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 01:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiGNFNY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 01:13:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889D1DF0
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 22:13:23 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y4so970949edc.4
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 22:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8Ddo2feSE47nPWaHVtR56YpSRocG8NVA5HlJMhgs2rs=;
        b=jjMrCr58WuYq8QuqRhAuQienPpB2t9XEJilSE7Gc1KTyLceLA4Yv8gnAJRyiMg44a6
         f2VPB6xD2aZoVhQZCOSG6uaY623rRAtBryU2qEDsNX387iQI3e2CxrLVRQQP9StoHUHE
         tLfXNpQxJzHxp+Mko2Y72Ns4JsO/ePBN4rJZXgt/ryW9yMW8I9Yh50j0c6ib5QNobZI0
         /rwl6Q0EJ17gWIC2wYwX++d3vgCsBVlQemubbbBcMw/9Lz5cc342wqhVftOzU6wktmCE
         /wGdfZ3q5u8zbmmtBot6vh2Y0RF9F/DiePcKUQH9gJX2Bdad+4hybr1ZG3rLeTWgfdS3
         opkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8Ddo2feSE47nPWaHVtR56YpSRocG8NVA5HlJMhgs2rs=;
        b=c4GSl6mv/mKn6nbuQqKemAUMtbPmhmlwA8uMBQJN9OBlCpwvVYAkl/DjrTfdJcfy3C
         JBg2VFZtFJNogstVd05aseM8XJsCiVtlZQ9fiMRPltMpfnl0rGEi1E3zFEWgoKAOPkkA
         1Jv5uFug76vXyUxd//8bIlU8YvJuND8M2ySQZt50cjIFvFB+59FfQtSPXF5M0ZIDZwHg
         HuSKzfXEQzWUB+ooCwfi1GvkWLq5B2jxtma4zojmLo8FBvOgYDj3Yj9YS4Y7gxubyif1
         DBxwUmWAGQwjeun1MmH63iHL1JtOZ8HtNUXrNBWJdYuB+qqncXOhlttMrD4p23xG0QNf
         T1Lw==
X-Gm-Message-State: AJIora9Nwgyyg1vqzLo5Zu2c9lmufD5SCifavvNpW8HSCr4zI1IsvZh2
        lQBR5gIKDoeJSBLARYNxGJreiMrtigAqQGPOCZrpo/ydsfMRgA==
X-Google-Smtp-Source: AGRyM1vExwKNeZJEvhnWVpkFlekY6h0VASXMr3AHz47rVz9HeyxbjYJ7/3WrTRyj/q+U30nuhNKHMjJ0tJhQkWg/RVY=
X-Received: by 2002:a05:6402:1c01:b0:43a:f714:bcbe with SMTP id
 ck1-20020a0564021c0100b0043af714bcbemr10120853edb.14.1657775602079; Wed, 13
 Jul 2022 22:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <BN6PR11MB16338E9998353C6B239CD27792869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <BN6PR11MB16332A018C2FAB69B479EA2B92869@BN6PR11MB1633.namprd11.prod.outlook.com>
 <Ys2tkthkFE1XkEPh@google.com> <BN6PR11MB16331BEF1C7F6F37F76C55DD92899@BN6PR11MB1633.namprd11.prod.outlook.com>
In-Reply-To: <BN6PR11MB16331BEF1C7F6F37F76C55DD92899@BN6PR11MB1633.namprd11.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 22:13:10 -0700
Message-ID: <CAEf4BzZ6RoHz9L-x=YrWmn7yX4xKQ=UeLk4Y5rkSaYuAVGsehg@mail.gmail.com>
Subject: Re: Build error of samples/bpf
To:     "Zeng, Oak" <oak.zeng@intel.com>
Cc:     "sdf@google.com" <sdf@google.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 13, 2022 at 8:35 AM Zeng, Oak <oak.zeng@intel.com> wrote:
>
> Thank you sdf for the reply.

please don't top post in mailing list, reply inline instead

>
> It is news to me that samples/bpf tend to go stale. When I looked the sam=
ples/bpf folder git history, the last update is from only 2 months ago. And=
 yes I can see samples/bfp is not actively updated recently. We are from In=
tel's GPU group and we are working on some bpf tools for GPU profiling purp=
ose. We made our work based on the structure of samples/bpf because we can =
conveniently use libbpf. We chose bpf c frontend (vs python frontend) becau=
se python bpf program seems can't execute under non-root leading to some se=
curity concerns. This work is not yet upstream but we planned to upstream i=
t.
>
> Now if samples/bpf is going stale, we need to change our plan. Specifical=
ly I have a few questions for our future planning:
>
> 1. does bpf community accept more bpf samples such as using bpf to kprobe=
/tracepoint GPU activities? Is such work helpful/welcome to/by the communit=
y? I can see the existing samples and selftest are mainly for general linux=
 profiling such as fs, network etc. Do you accept more samples for specific=
 driver profiling - in our case it is profiling of Intel's i915 GPU driver.
>

Generic BPF tools are generally put into BCC/libbpf-tools ([0]). If
they are very specialized and niche, it might not be accepted. But I'd
try there first.

As for samples/bpf, no we don't add any new things there. It should
either be a selftest-like and go into selftests/bpf, or it should be
outside of the kernel repo.

  [0] https://github.com/iovisor/bcc/tree/master/libbpf-tools

> 2. Should we port our samples/bpf to tools/testing/selftests/bpf for upst=
ream purpose? I am not sure whether tools/testing/selftests/bpf is a good p=
lace for our gpu profiling samples. If tools/testing/selftests/bpf is not a=
 good place for gpu profilers, any suggestion where we can upstream our gpu=
 profilers?

If the BPF part of such profilers is complicated and stresses BPF
verifier, we can put those up as "BPF verifier scalability" tests (see
bpf_verif_scale.c in selftests/bpf), it's good to have real-world
complicated examples there to detect regressions. But tool itself
probably should be in libbpf-tools or in some dedicated repo.

>
> Cc other bpf reviewers. Thank you for your considerations!
>
> Thanks,
> Oak
>
> > -----Original Message-----
> > From: sdf@google.com <sdf@google.com>
> > Sent: July 12, 2022 1:23 PM
> > To: Zeng, Oak <oak.zeng@intel.com>
> > Cc: bpf@vger.kernel.org
> > Subject: Re: Build error of samples/bpf
> >
> > On 07/12, Zeng, Oak wrote:
> > > Hello all,
> >
> > > I tried to build the latest samples/bpf following instructions in the
> > > README.rst in samples/bpf folder. I ran into various issue such as:
> >
> > > samples/bpf/Makefile:375: *** Cannot find a vmlinux for VMLINUX_BTF a=
t
> > > any of "  /home/szeng/dii-tools/linux/vmlinux", build the kernel or
> > > set VMLINUX_BTF or VMLINUX_H variable
> >
> > > I was able to fix above issue by enable CONFIG_DEBUG_INFO_BTF in
> > > kernel .config file.
> >
> > > But I eventually ran into other errors.  I had to fix those errors by
> > > install dwarves, updating my clang/llvm to version 10.
> >
> > > I was able to build it if I comment out all the xdp programs from
> > > Makefile. It seems those xdp programs require advanced features such
> > > as data structure layout in vmlinux.h (dumped from vmlinux using
> > > bpftool) and this require special kernel config support.
> >
> > > So I thought instead of fixing those errors one by one, I should ask
> > > those who are working in this area, is there any instructions on how
> > > to build samples/bpf? The README.rst seems out-of-date, for example,
> > > it doesn't mention CONFIG_DEBUG_INFO_BTF. The required llvm/clang
> > > version in README.rst is also out-of-date.
> >
> > > More specifically, to build samples/bpf, is there an example kernel
> > > .config to use? I tried those config here
> > > https://github.com/torvalds/linux/blob/master/tools/testing/selftests=
/
> > > bpf/config
> > > but build errors persist.
> >
> > > Or is there any other tools I need to install/update on my system?
> >
> > In general, I'd say, samples/bpf tend to go stale. We mostly work on th=
e
> > selftests and don't pay too much attention to the samples :-( Ideally, =
the
> > samples should be part of selftests so they get exercised by the CI.
> >
> > One thing I can suggest is to look at tools/testing/selftests/bpf/vmtes=
t.sh
> > script. It builds the kernels with vetted configs capable of running se=
lftests.
> > That should be, in theory, be enough to compile the samples.
> >
> > > My whole build log is as below:
> >

[...]
