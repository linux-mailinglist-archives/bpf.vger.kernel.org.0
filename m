Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFFF468901
	for <lists+bpf@lfdr.de>; Sun,  5 Dec 2021 04:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhLED4V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Dec 2021 22:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhLED4V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Dec 2021 22:56:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90383C061751
        for <bpf@vger.kernel.org>; Sat,  4 Dec 2021 19:52:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53167B80D34
        for <bpf@vger.kernel.org>; Sun,  5 Dec 2021 03:52:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F553C341C5;
        Sun,  5 Dec 2021 03:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638676372;
        bh=jWrBOHScoDrsQvIYg4zsm8wvbxZgY3TZWa4J0gBl5o8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=URIi5tFE58OWDU0i02n1xlIaasTI0Xfu66db1JFkyCiJTE2vX3Fbmn9fleu//jeOG
         whGp10nVyOG5s8NJ1gsm/chkPU/91feHB7o0hp5feGx7rE7ESsLHl2S5tglfGvuQKe
         V28AouwX8bf8Q11YzfgvgDm0ORgh+XXE5uA8A4MAztQeE6Paz7C7YIzMDIjyyVv3dl
         Sp2WX2IjUFhxnwEHX/rmSWgeQxog4qmZ9Wg4HJTp7bRYlqCKirtz+mPcPRTBDqee60
         t7+8KWKY9z/w6NMMQnwTy0OPVOnPI0pMeZESzt10zNnKSO3Ue4uyRdx/rWMdBMwaKM
         qJtk3pvNnoZmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 783565C0FC9; Sat,  4 Dec 2021 19:52:51 -0800 (PST)
Date:   Sat, 4 Dec 2021 19:52:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow bpf_local_storage to be used by
 sleepable programs
Message-ID: <20211205035251.GY641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210902044430.ltdhkl7vyrwndq2u@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7OePr4Uf7tLR2OAy79sxZwJuXcOBqjEAzV7omOc792KA@mail.gmail.com>
 <20211123182204.GN641268@paulmck-ThinkPad-P17-Gen-1>
 <20211123222940.3x2hkrrgd4l2vuk7@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ4VDMzp2ggtVL30xq+6Q2+2OqOLhuoi173=8mdyRbS+QQ@mail.gmail.com>
 <20211130023410.hmyw7fhxwpskf6ba@kafai-mbp.dhcp.thefacebook.com>
 <CACYkzJ7+V=ui7kS-8u7zQoHPT3zZE6X3QuRROG3898Mai9JAcg@mail.gmail.com>
 <20211130225129.GB641268@paulmck-ThinkPad-P17-Gen-1>
 <20211204010152.GA3967770@paulmck-ThinkPad-P17-Gen-1>
 <CACYkzJ5h+MaGxhYH-vhQQdqzbiVs4p2GVMnBWMjoA0xE9Tz_aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ5h+MaGxhYH-vhQQdqzbiVs4p2GVMnBWMjoA0xE9Tz_aw@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 05, 2021 at 03:27:47AM +0100, KP Singh wrote:
> On Sat, Dec 4, 2021 at 2:01 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Nov 30, 2021 at 02:51:29PM -0800, Paul E. McKenney wrote:
> 
> [...]
> 
> > > There are probably still bugs, but it is passing much nastier tests than
> > > a couple of weeks ago, so here is hoping...
> >
> > And this is now in -next.  Please let me know how it goes!
> 
> I was able to rebase this on linux-next which has Paul's changes and
> ran it with:
> 
> root@kpsingh:~# cat /proc/cmdline
> console=ttyS0,115200 root=/dev/sda rw nokaslr rcupdate.rcu_task_enqueue_lim=4
> 
> The warning about the nested spinlock in the raw spin locked section
> is also gone and I don't
> see any other warnings. Will send the rebased series after doing a few
> more checks.

Thank you, and here is hoping for continued testing success!  ;-)

							Thanx, Paul
