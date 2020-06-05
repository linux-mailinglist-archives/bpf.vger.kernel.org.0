Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB81EFD4F
	for <lists+bpf@lfdr.de>; Fri,  5 Jun 2020 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgFEQNT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Jun 2020 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgFEQNR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jun 2020 12:13:17 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF64C08C5C3
        for <bpf@vger.kernel.org>; Fri,  5 Jun 2020 09:13:17 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id l6so8074604qkk.14
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2020 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h2V903U1EEnx/XeNr72mNgocRsdt/ir45d5WQ/jkKQU=;
        b=fX7nTmfYPjTpo8/dsU6y1YIojRoqvUxlVR3wxzdEkiguIMJnSCIGILdMqxercgOzH9
         VdsC/MkR89Fi9w2J2VVclnG5+Q4t7TZklVFSYaliOnFHRuZhNdwwtnf9dSBUcc4b5h7P
         T4Y4URdm9mTeDHjmszBlznB/EBduPnucl7hm82RfB/250J0Hc9dD5yW5RAnpRlIwXpEC
         gMt2aobSyinlx/KY9sakFdy2gBhbCoakMxg4w8YVkV3Qm/Y87LSKlBymTn97Yt4QDBwR
         wFuLmTu7iW0EGvbnmlQ0exNiWRPuOid7/IYdEQrWPCizNnD1Tj1MpgJir8nBI6Ieh91L
         2Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h2V903U1EEnx/XeNr72mNgocRsdt/ir45d5WQ/jkKQU=;
        b=NnPZT7j+JmuMypE/SvkNU5kq630q2nq5ucsoyy7lsepvgfdUHC3WGRjKdwFdRCyRr8
         91ySQQkM2stmAXZTKzNqJ3ZZ/bhfruu2eGvPsavhe8Ie5mNnFqbVke8m6xRlNcOZL6cf
         /Ay38zsAzHTOOktrSs+ENmu7kt4HbYYsmxjshhOXYluj2VSyAM1lxklq6JWebuiY9AmJ
         wllEeMtWdjH4AUKU9QFlak7GYZ0mpkQUTikJvR9sFPHmlrpKGleoXS2naDtgspyD8nF4
         9zsq87N5O4p7taUk6D8I9nSxbl/jYsHC3ikto+ocrHXKNm4Paj2uaNuovUHkdHv8cqy1
         IuTQ==
X-Gm-Message-State: AOAM532GO/5BLNFg5m71zhoyTY4l9xH7W8pP5EwiUXWi4KiW8z4BNS4J
        yJfBSn53slJnpeCXFtcvv4d7wic=
X-Google-Smtp-Source: ABdhPJx846OyGeHZzKZe/tfRllC6Ck01OYQHAiyPvZvGXqeK/ZqNlebXaXREwxEszApr2c6SJ56T1TM=
X-Received: by 2002:a0c:b5c1:: with SMTP id o1mr10715971qvf.9.1591373596658;
 Fri, 05 Jun 2020 09:13:16 -0700 (PDT)
Date:   Fri, 5 Jun 2020 09:13:14 -0700
In-Reply-To: <20200605043517.cupb77gzytqhanyk@ast-mbp.dhcp.thefacebook.com>
Message-Id: <20200605161314.GA245787@google.com>
Mime-Version: 1.0
References: <20200605002155.93267-1-sdf@google.com> <20200605043517.cupb77gzytqhanyk@ast-mbp.dhcp.thefacebook.com>
Subject: Re: [PATCH bpf v2] bpf: increase {get,set}sockopt optval size limit
From:   sdf@google.com
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/04, Alexei Starovoitov wrote:
> On Thu, Jun 04, 2020 at 05:21:55PM -0700, Stanislav Fomichev wrote:
> > Attaching to these hooks can break iptables because its optval is
> > usually quite big, or at least bigger than the current PAGE_SIZE limit.
> >
> > There are two possible ways to fix it:
> > 1. Increase the limit to match iptables max optval.
> > 2. Implement some way to bypass the value if it's too big and trigger
> >    BPF only with level/optname so BPF can still decide whether
> >    to allow/deny big sockopts.
> >
> > I went with #1 which means we are potentially increasing the
> > amount of data we copy from the userspace from PAGE_SIZE to 512M.
> >
> > v2:
> > * proper comments formatting (Jakub Kicinski)
> >
> > Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  kernel/bpf/cgroup.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index fdf7836750a3..fb786b0f0f88 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> > @@ -1276,7 +1276,14 @@ static bool  
> __cgroup_bpf_prog_array_is_empty(struct cgroup *cgrp,
> >
> >  static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int  
> max_optlen)
> >  {
> > -	if (unlikely(max_optlen > PAGE_SIZE) || max_optlen < 0)
> > +	/* The user with the largest known setsockopt optvals is iptables.
> > +	 * Allocate enough space to accommodate it.
> > +	 *
> > +	 * See XT_MAX_TABLE_SIZE and sizeof(struct ipt_replace).
> > +	 */
> > +	const int max_supported_optlen = 512 * 1024 * 1024 + 128;

> looks like arbitrary number. Why did you pick this one?
> Also it won't work with kzalloc() below.
I tried to add some reasoning that iptables is _probably_ the
biggest known user, but I agree, that is somewhat arbitrary.

And good point on kzalloc, iptables is using kvalloc, missed that :-(

> May be trim it to some number instead of hard failing ?
> bpf prog cannot really examine more than few kbytes.
I'm not sure we can trim, because if we do it and BPF program
modifies it, we need to merge the trimmed part with the
rest (untrimmed) before passing it down to the real kernel
handler. So it ether means we copy this modified part back
to the userspace (bad?) or we reallocate more memory (equally bad?).

Let me try to look into #2 that I've suggested in the description.
Maybe for "big" (>PAGE_SIZE) optvals we can say that only
level/optname are supported for some policy related actions,
but modifying/observing the data is not supported (at least for now).
