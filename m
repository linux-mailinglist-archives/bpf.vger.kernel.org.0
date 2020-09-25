Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC22A277CBF
	for <lists+bpf@lfdr.de>; Fri, 25 Sep 2020 02:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIYAS3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 20:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgIYAS3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 20:18:29 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03CC0613CE;
        Thu, 24 Sep 2020 17:18:28 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLbR5-005fA1-D2; Fri, 25 Sep 2020 00:18:03 +0000
Date:   Fri, 25 Sep 2020 01:18:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
Message-ID: <20200925001803.GV3421308@ZenIV.linux.org.uk>
References: <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
 <202009241658.A062D6AE@keescook>
 <CAG48ez2R1fF2kAUc7vOOFgaE482jA94Lx+0oWiy6M5JeM2HtvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez2R1fF2kAUc7vOOFgaE482jA94Lx+0oWiy6M5JeM2HtvA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 25, 2020 at 02:15:50AM +0200, Jann Horn wrote:
> On Fri, Sep 25, 2020 at 2:01 AM Kees Cook <keescook@chromium.org> wrote:
> > 2) seccomp needs to handle "multiplexed" tables like x86_x32 (distros
> >    haven't removed CONFIG_X86_X32 widely yet, so it is a reality that
> >    it must be dealt with), which means seccomp's idea of the arch
> >    "number" can't be the same as the AUDIT_ARCH.
> 
> Sure, distros ship it; but basically nobody uses it, it doesn't have
> to be fast. As long as we don't *break* it, everything's fine. And if
> we ignore the existence of X32 in the fastpath, that'll just mean that
> syscalls with the X32 marker bit always hit the seccomp slowpath
> (because it'll look like the syscall number is out-of-bounds ) - no
> problem.

You do realize that X32 is amd64 counterpart of mips n32, right?  And that's
not "basically nobody uses it"...
