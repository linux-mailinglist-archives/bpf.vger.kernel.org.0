Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA6A4780D0
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 00:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhLPXos (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 18:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhLPXos (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 18:44:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BCDC061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 15:44:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FECAB82525
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 23:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC881C36AE7;
        Thu, 16 Dec 2021 23:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639698285;
        bh=9M7kBRLjbWiKL1GRn0ws1+kix6IN+s9H0h+dFbFSSRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=smN2ayWsrPtWgu7FS9HUdpc1i+U+xdzcSxLvmqTi3qwv1teE4UqPL3w6icoXlMxOk
         7ccB+7xfunZe0IcfD+wLFzoKtJQsQZunGukHE5GeTkm2FMsMYE7NB8Ml4CqbQxuXud
         5UICKSLfrj/oiy64Ex3Av4DZ4PjdP2WaviCnQKf2tkwFgZDAISvf8QZz+5Fp+LuRqx
         dDpXbCYUA01koSxg65fBATmSpsSqWooQnxsJ574N5UautqX0eN365xhYyrYPSn8X6h
         JE1BdJjCDQokBU58+aExvS2maYRpBtdTviWT0WAp72Q8dgmsKv/HiPA8HGdfQNLz/C
         daH+TU+xjRrfA==
Date:   Thu, 16 Dec 2021 15:44:44 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v5 0/3] bpf: remove the cgroup -> bpf header
 dependecy
Message-ID: <20211216154444.79b71610@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAADnVQ+hkTd0F05EmYPqWvfReMad5Sp6ahOBaYbv9QYkSzFH1g@mail.gmail.com>
References: <20211216025538.1649516-1-kuba@kernel.org>
        <CAADnVQ+hkTd0F05EmYPqWvfReMad5Sp6ahOBaYbv9QYkSzFH1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 16 Dec 2021 15:05:00 -0800 Alexei Starovoitov wrote:
> On Wed, Dec 15, 2021 at 6:55 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > Changes to bpf.h tend to clog up our build systems. The netdev/bpf
> > build bot does incremental builds to save time (reusing the build
> > directory to only rebuild changed objects).
> >
> > This is the rough breakdown of how many objects needs to be rebuilt
> > based on file touched:
> >
> > kernel.h      40633
> > bpf.h         17881
> > bpf-cgroup.h  17875
> > skbuff.h      10696
> > bpf-netns.h    7604
> > netdevice.h    7452
> > filter.h       5003
> > sock.h         4959
> > tcp.h          4048
>
> Applied. Thanks

Thanks! I got another patch to get to 1k objects, by taking filter.h
include out of sock.h but I'll give it a week for the dust to settle
here.
