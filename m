Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1983241BC
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 17:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhBXQIo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 11:08:44 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:49708 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235964AbhBXPo2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 10:44:28 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id F069472C8B1;
        Wed, 24 Feb 2021 18:43:40 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D37304A4720;
        Wed, 24 Feb 2021 18:43:40 +0300 (MSK)
Date:   Wed, 24 Feb 2021 18:43:40 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        "Anton V. Boyarshinov" <boyarsh@altlinux.org>
Subject: Re: EFI boot fails when CONFIG_DEBUG_INFO_BTF=y on arm64
Message-ID: <20210224154340.mxjhr7odpu33vou7@altlinux.org>
References: <20210211233956.em5k4vtefyfp4tiv@altlinux.org>
 <CAEf4BzZNS_BQhjRuT25YEa0ppU=4_v5kUqMxOaW_FqdXXDtVNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CAEf4BzZNS_BQhjRuT25YEa0ppU=4_v5kUqMxOaW_FqdXXDtVNg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii,

On Mon, Feb 22, 2021 at 05:30:09PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 11, 2021 at 3:44 PM Vitaly Chikunov <vt@altlinux.org> wrote:
> >
> > Hi,
> >
> > We have boot test using OVMF/AAVMF EFI firmware on aarch64 in qemu. When
> > we try to build kernel with `CONFIG_DEBUG_INFO_BTF=y' (pahole v1.20)
> > previously successful EFI boot test fails with:
> >
> >   EFI stub: ERROR: Failed to relocate kernel
> >   EFI stub: ERROR: Failed to relocate kernel
> >
> > Without EFI it boots normally. On other our architectures (such as
> > arm32, i586, powerpc, x86_64) it boots normally too (all without EFI
> > boot, but x86_64 is also successfully tested with OVMF EFI boot).
> 
> So this seems like an arm64-specific issue? Is it possible to get any
> help from someone familiar with arm64 specifics to find out what
> exactly causes this problem? We use `pahole -J` to "implant" .BTF into
> vmlinux.o, but later rely on vmlinux loader scripts to have a loadable
> .BTF section. The problem might happen somewhere along those steps. I
> don't think I can be of much help here without a bit more information
> (and seems like no one else on this list came up with any suggestions
> as well).

Thanks for the reply! After some experiments and debugging today it's
turned out that problem is low default memory size for qemu. When
increased to `-m 512` it booted good. Thereby, now we can enable BTF for
aarch64 too.

Vitaly,

> 
> >
> > This is tested on 5.4.97, but I can try 5.10.15 if needed.
> >
> > Thanks,
> >
