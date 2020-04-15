Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BC31AAFC1
	for <lists+bpf@lfdr.de>; Wed, 15 Apr 2020 19:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411131AbgDORb4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Apr 2020 13:31:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411184AbgDORbk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:40 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515162076D;
        Wed, 15 Apr 2020 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971900;
        bh=964oN6kee5jmshS+aNJL2/5QEys/N+DxmqvpUuzapK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wKw5yEU77LDT07eRusttmJ7XZQpZVI5OIOFm7m0gG3d1ICs1svr8baTbGsHFLTjEG
         CmDTMCkZKqRb7Gq0QdazYvKSjcxen6OBIQPQQsbICYisqu7/FgK3cTD2k1Huxtndcs
         rxPHiupgPCxOtZCrcyf7YCGmXE2xSfkNWtlbBbKc=
Date:   Wed, 15 Apr 2020 10:31:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tiffany Kalin <tkalin@untangle.com>
Cc:     bpf@vger.kernel.org
Subject: Re: Bpfilter Installation
Message-ID: <20200415103138.746952e6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CABkdAXa0y=fvAU63Wsk1b1rF1AHNraJrsRnyXfScELvqswc+OA@mail.gmail.com>
References: <CABkdAXa0y=fvAU63Wsk1b1rF1AHNraJrsRnyXfScELvqswc+OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 13 Apr 2020 14:22:07 -0600 Tiffany Kalin wrote:
> Hi,
> 
> I am interested in bpfilter and I wanted to play around with it. I
> installed the latest Linux kernel (make && make modules_install &&
> make install) with BPFILTER set to yes.
> Following this video: https://www.youtube.com/watch?v=AfgwVya9Cog
> I tried to run the bpfilter.ko, but it did not work. I could not do
> modprobe nor insmod for bpfilter. Is there something I'm missing in
> order to have bpfilter.ko run? Or is there a new way to run bpfilter?
> Any guidance/help would be appreciated!

Hey! I think that video was showing some out of tree patches and hacks.
At the time there was hope that bpfilter will become a commonly used
iptables to BPF translation layer, but unfortunately the effort haven't
gone far beyond laying the groundwork. Maybe you are the person who
will take it forward? :)

FWIW there are also projects for doing such translation in user space,
there are patches for OvS to generate XDP programs, libkefir from
Netronome, and I think Red Hat was also working on something?
