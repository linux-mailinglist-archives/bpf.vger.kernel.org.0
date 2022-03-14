Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE5D4D906C
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 00:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiCNXhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 19:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343707AbiCNXhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 19:37:10 -0400
X-Greylist: delayed 1253 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 16:35:59 PDT
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [142.44.231.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C813F63;
        Mon, 14 Mar 2022 16:35:59 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTtph-00BJxN-UC; Mon, 14 Mar 2022 23:10:34 +0000
Date:   Mon, 14 Mar 2022 23:10:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
Message-ID: <Yi/LaZ5id4ZjqFmL@zeniv-ca.linux.org.uk>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-2-haoluo@google.com>
 <YiwXnSGf9Nb79wnm@zeniv-ca.linux.org.uk>
 <CA+khW7g+T2sAkP1aycmts_82JKWgYk5Y0ZJp+EvjFUyNY8W_5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7g+T2sAkP1aycmts_82JKWgYk5Y0ZJp+EvjFUyNY8W_5w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 14, 2022 at 10:07:31AM -0700, Hao Luo wrote:
> Hello Al,

> > In which contexts can those be called?
> >
> 
> In a sleepable context. The plan is to introduce a certain tracepoints
> as sleepable, a program that attaches to sleepable tracepoints is
> allowed to call these functions. In particular, the first sleepable
> tracepoint introduced in this patchset is one at the end of
> cgroup_mkdir(). Do you have any advices?

Yes - don't do it, unless you really want a lot of user-triggerable
deadlocks.

Pathname resolution is not locking-agnostic.  In particular, you can't
do it if you are under any ->i_rwsem, whether it's shared or exclusive.
That includes cgroup_mkdir() callchains.  And if the pathname passed
to these functions will have you walk through the parent directory,
you would get screwed (e.g. if the next component happens to be
inexistent, triggering a lookup, which takes ->i_rwsem shared).
