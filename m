Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC5C48514B
	for <lists+bpf@lfdr.de>; Wed,  5 Jan 2022 11:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiAEKnG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Jan 2022 05:43:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54982 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiAEKnG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Jan 2022 05:43:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A28F26165A
        for <bpf@vger.kernel.org>; Wed,  5 Jan 2022 10:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A632C36AE9;
        Wed,  5 Jan 2022 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641379385;
        bh=I/O1Cq7c8tR+tfZrdfco2sXzuFJ7t6NL8Uu0B8BiNO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r+MizJZcrlnSiMxkEGPeW4Mog34/37qamqIpGsMpqm/VNOUKyaexbQ2ug1mIMsOxL
         U3/qY3Ni7pY5zQdqrCQEqLFpbY6AnjVqqEmT+cPqCMgPfPdiu5vBib3HlB2GzjwmQG
         ygjlq/97b5TSuGz3Rj+iD9eLlQP0CvDhHIGNMuXE=
Date:   Wed, 5 Jan 2022 11:43:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Buchberger, Dennis" <dennis.buchberger@hs-osnabrueck.de>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Problem loading eBPF program on Kernel 4.18 (best with CO:RE):
 -EINVAL
Message-ID: <YdV2NgMG/EWwJVQn@kroah.com>
References: <1641377010132.82356@hs-osnabrueck.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1641377010132.82356@hs-osnabrueck.de>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 05, 2022 at 10:03:30AM +0000, Buchberger, Dennis wrote:
> Hello :)
> 
> I am currently having a problem and hope you can help me: My goal is to develop a BPF-program (see below) on a development machine and then deploy it to another machine to run it there using BPF CO:RE.
> But the program does not load; bpf_object__load returns -EINVAL.
> 
> Development machine:
> - Ubuntu 20.04 LTS
> - Linux 5.4.0-90-generic x86_64
> - Kernel compiled with CONFIG_DEBUG_INFO_BTF=y, so BTF is available under /sys/kernel/btf/vmlinux
> - clang version: 10.0.0-4ubuntu1
> - llc version: 10.0.0
> 
> Target machine:
> - Ubuntu 18.10
> - Linux 4.18.0-25-generic x86_64

4.18 is very old and obsolete and insecure and only supported by the
vendor you are paying support from.  Please upgrade to a more modern
kernel (4.18 was released way back in 2018), if you wish to get help
from the kernel community.

Actually, the vendor you are paying for support to stay at this old
kernel version should be able to provide help to you, why not ask them?

thanks,

greg k-h
