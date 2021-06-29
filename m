Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4507B3B771B
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 19:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhF2RY1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 13:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232362AbhF2RY1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 13:24:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 799C661CBE;
        Tue, 29 Jun 2021 17:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624987318;
        bh=DtKxfURUq7rtli7d8/3+ZGBPmkimDK+6xfRODXDkn9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lbiz41FbVea747oxPAlqwiFnor7cKD1lSTXqsNNd9tPUSgyt275JXjphjq4DGNiSt
         vYkG2tXqB1FTkdAdz5Qs46LjDsxRm9nQc9ijylYuQgGEiyIH8BmHnqaRyGLtDpFhs3
         Btemobcets8ueTFUG2QFsIRX2OhgBwUUS/mjKbZk=
Date:   Tue, 29 Jun 2021 19:21:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: bpf_fib_lookup support for firewall mark
Message-ID: <YNtWtEK3dBE1d5Lb@kroah.com>
References: <CA+FoirALjdwJ0=F6E4w2oNmC+fRkpwHx8AZb7mW1D=nU4_qZUQ@mail.gmail.com>
 <c2f77a3d-508f-236c-057c-6233fbc7e5d2@iogearbox.net>
 <68345713-e679-fe9f-fedd-62f76911b55a@gmail.com>
 <CA+FoirA28PANkzHE-4uHb7M0vf-V3UZ6NfjKbc_RBJ2=sKSrOQ@mail.gmail.com>
 <6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com>
 <7742f2a2-11a7-4d8f-d8c1-7787483a3935@iogearbox.net>
 <64222254-eef3-f1c4-2b75-6ea1668a0ad5@gmail.com>
 <CA+FoirARDoWWpif2tw47BG0Rh5+uBpsoVZ7Y05JnZO2UqBDSEw@mail.gmail.com>
 <CA+FoirA-eAfux3PfxjgyO=--7duWCKuyeJfxWTdW6jiMWzShTw@mail.gmail.com>
 <CA+FoirBfFwHg78_G+LdxR=x0bRVViG2QXPn9Rsb_7DfZQY4t8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FoirBfFwHg78_G+LdxR=x0bRVViG2QXPn9Rsb_7DfZQY4t8w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 29, 2021 at 10:18:14AM -0700, Rumen Telbizov wrote:
> Daniel, BPF list,
> 
> Over the last week or so David Ahern and I worked on a patchset that solves
> the problem discussed here along with a self-test.
> 
> Attached here is a patchset of 3 files which covers the following:
> 
> [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
> [PATCH 2/3] tools: Update bpf header
> [PATCH 3/3] selftests: Add selftests for fwmark support in bpf_fib_lookup
> 
> I have tested those against a very recent clone of the latest 5.13-rc7.
> Self-test results look like this:
> 
> ----
> # ./test_bpf_fib_lookup.sh
> [test_bpf_fib_lookup.sh] START
> - Running test_egress_ipv4_fwmark
>   * mark 0: PASS
>   * mark 2: PASS
> - Running test_egress_ipv6_fwmark
>   * mark 0: PASS
>   * mark 2: PASS
> [test_bpf_fib_lookup.sh] PASS: 4 -- FAIL: 0
> # echo $?
> 0
> ----
> 
> Let me know what you think and if there's anything else needed to incorporate
> the patchset into the kernel as well as what you think the next steps should be.

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
