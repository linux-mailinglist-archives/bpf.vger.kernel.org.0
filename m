Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60DC4F21D9
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 06:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiDECiR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 22:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiDECiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 22:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31832D92C4
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 18:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0E5B6177A
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 00:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57772C341C5
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 00:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649116837;
        bh=zFyw1VrfGv7NEuMWOTezqzL8GubbV0WO1PDpwo/w7kk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IzT8pKglPQrYQePYYNDTTvWosEy8MxZkq3wR0piD8u7iSz63ghJ7anCpsXVy8rPww
         h8sb6BeBAosTUPJfJSBf5tC/Uc9Zc7IhUFp3EN+3Y4bey3Juna89uPMBgdz3W6AXN8
         KvMFgfyNzawLqWgHmU50yAJKNxBLRXw3d+NWJeiFYcgugGX/GADSzk/5G8g9++kPxr
         OpF27iOsOSCNOr0NIjmDYXJCtgmcKH1aCT/Qss+bZqX0jw6YqWJZnXdaS1BIF6FzjI
         YW3kHL8sWBe0nwkHW+VswjM/Okte+nrlOhP3czPdm/y4SX3zE8ViE7mZZZHIzCb+Y/
         aCTsH/tzvnYAg==
Received: by mail-ed1-f47.google.com with SMTP id c42so5565374edf.3
        for <bpf@vger.kernel.org>; Mon, 04 Apr 2022 17:00:37 -0700 (PDT)
X-Gm-Message-State: AOAM530OKCLAs/VCPOPwtnkedEY6aXRu2G77Nrhro4nCdJEkb9JCoV6M
        gQeKJHzPyTtIM7HruMOXBBgWG5/nrkhL1LCFGgxvkw==
X-Google-Smtp-Source: ABdhPJx00CBmV+NQNnGWVZ6pCbTPeYWoi7t9WNITl4M8WQe+QSjOqLEi5/uSRAkUXHVhCjpjoCKilOkyYU4kDA3K4zE=
X-Received: by 2002:aa7:c157:0:b0:418:f8e3:4c87 with SMTP id
 r23-20020aa7c157000000b00418f8e34c87mr671966edp.271.1649116835186; Mon, 04
 Apr 2022 17:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220328175033.2437312-1-roberto.sassu@huawei.com>
 <20220331022727.ybj4rui4raxmsdpu@MBP-98dd607d3435.dhcp.thefacebook.com>
 <b9f5995f96da447c851f7c9db8232a9b@huawei.com> <20220401235537.mwziwuo4n53m5cxp@MBP-98dd607d3435.dhcp.thefacebook.com>
 <CACYkzJ5QgkucL3HZ4bY5Rcme4ey6U3FW4w2Gz-9rdWq0_RHvgA@mail.gmail.com>
 <CAEiveUcx1KHoJ421Cv+52t=0U+Uy2VF51VC_zfTSftQ4wVYOPw@mail.gmail.com>
 <c2e57f10b62940eba3cfcae996e20e3c@huawei.com> <CAADnVQJSso+GSXC-QmNmj0GBPZzxRCRfqAcQbqD-6y0CtMSopQ@mail.gmail.com>
In-Reply-To: <CAADnVQJSso+GSXC-QmNmj0GBPZzxRCRfqAcQbqD-6y0CtMSopQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 5 Apr 2022 02:00:24 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7ZVbL2MG7ugmDEfogSPAHkYYMCHxRO_eBCJJmBZyn6Rw@mail.gmail.com>
Message-ID: <CACYkzJ7ZVbL2MG7ugmDEfogSPAHkYYMCHxRO_eBCJJmBZyn6Rw@mail.gmail.com>
Subject: Re: [PATCH 00/18] bpf: Secure and authenticated preloading of eBPF programs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 5, 2022 at 12:49 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Apr 4, 2022 at 10:21 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> >
> > > From: Djalal Harouni [mailto:tixxdz@gmail.com]
> > > Sent: Monday, April 4, 2022 9:45 AM
> > > On Sun, Apr 3, 2022 at 5:42 PM KP Singh <kpsingh@kernel.org> wrote:
> > > >
> > > > On Sat, Apr 2, 2022 at 1:55 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > ...
> > > > >
> > > > > > Pinning
> > > > > > them to unreachable inodes intuitively looked the
> > > > > > way to go for achieving the stated goal.
> > > > >
> > > > > We can consider inodes in bpffs that are not unlinkable by root
> > > > > in the future, but certainly not for this use case.
> > > >
> > > > Can this not be already done by adding a BPF_LSM program to the
> > > > inode_unlink LSM hook?
> > > >
> > >
> > > Also, beside of the inode_unlink... and out of curiosity: making sysfs/bpffs/
> > > readonly after pinning, then using bpf LSM hooks
> > > sb_mount|remount|unmount...
> > > family combining bpf() LSM hook... isn't this enough to:
> > > 1. Restrict who can pin to bpffs without using a full MAC
> > > 2. Restrict who can delete or unmount bpf filesystem
> > >

I like this approach better, you will have to restrict the BPF, if you
want to implement MAC policy using BPF.

Can you please try implementing something using these hooks?

> > > ?
> >
> > I'm thinking to implement something like this.
> >
> > First, I add a new program flag called
> > BPF_F_STOP_ONCONFIRM, which causes the ref count
> > of the link to increase twice at creation time. In this way,
> > user space cannot make the link disappear, unless a
> > confirmation is explicitly sent via the bpf() system call.

I don't like this approach, this just sounds like an intentional
dangling reference, prone to refcounting errors and it does not
really solve the purpose you want to achieve.

And you will still need a policy around the BPF syscall,
so why not just use the LSM hooks as suggested above?

> >
> > Another advantage is that other LSMs can decide
> > whether or not they allow a program with this flag
> > (in the bpf security hook).
> >
> > This would work regardless of the method used to
> > load the eBPF program (user space or kernel space).
> >
> > Second, I extend the bpf() system call with a new
> > subcommand, BPF_LINK_CONFIRM_STOP, which
> > decreases the ref count for the link of the programs
> > with the BPF_F_STOP_ONCONFIRM flag. I will also
> > introduce a new security hook (something like
> > security_link_confirm_stop), so that an LSM has the
> > opportunity to deny the stop (the bpf security hook
> > would not be sufficient to determine exactly for
> > which link the confirmation is given, an LSM should
> > be able to deny the stop for its own programs).
> >
> > What do you think?
>
> Hack upon a hack? Makes no sense.
