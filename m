Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A404730D3EF
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 08:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhBCHMP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 02:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhBCHL7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 02:11:59 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC3C06174A
        for <bpf@vger.kernel.org>; Tue,  2 Feb 2021 23:11:19 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id e15so11642810lft.13
        for <bpf@vger.kernel.org>; Tue, 02 Feb 2021 23:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTvYzJWV70mLxuetyfqxqpEczxvMfqQITcuSh6FmUBU=;
        b=QzUyd2LinSAlUDJa25vo5/l8eDbZKcSl58f9H57XD0DzDoT99Nz/UVf0p1hOa/LKBT
         rmdubPam5Q7Exb7X0fctnSKSvEezmxNdWVOLOyYajxqyj9zISQSlcUneZD3Xjyp6zpvr
         LXCz8WwioIm8DKDtiUGBq+oEpcj1ei3zVgjn1zh5DSWwv4c2uAKuGeqfGiQ/rtdI3PQT
         7FupJRl5zfnXjixQdnwocfW60cNb9Ix9I7RptK9YWVU8sUI9dzM6B+V/l5gfKphZQbHe
         i59wORp2wz9TzZ/+pterYXBSXxmh/5Jr3UzeY4MiwOvtfIEx9id7gdAEGYnWi42MGtGz
         q8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTvYzJWV70mLxuetyfqxqpEczxvMfqQITcuSh6FmUBU=;
        b=ozDYZwU5/e8DkwxhPfMBvGAaVWUUh+aPdcCaGgai9Vey3BCnjaSGStijNn/jKXCDo0
         KuZSVM4nAxbzQ4zJU27Hmobx1JN5RIXRVrYgbmYxi/6xsh3pxAt4q4HXFRzgeetvawd5
         MB9hRSKmEqEV6tjARl37Lawbq/0cVVPGnUpSCtF6bREEf07Q7iSW+DWw3kU6/CbKfCQ2
         V9d9gQm6cum/7v24RRhxVyHTddKpQyyWhiXCjqnAcXtcn5z52wQRtCbLA8DOLJmLAYnx
         6XDex8Z8uazqVsCrkbpPGl/i9yXNr1WZiXX5zhk081QShrh6LDkuNpqlvc3RsXcYt3AM
         9BcQ==
X-Gm-Message-State: AOAM531HmkkZHppxZ8yPKn+aphGOr2IMi6zHY3odR07uGqgv/LHT8Qjj
        rr2IutUNLx5xG+qkwNGdhx0sHzWHnoCG7QpNwPE=
X-Google-Smtp-Source: ABdhPJzs8bn9Aj4cM2u2dIighGiYJbmPKpsxL1az4uUviPLrD7CEQSP7ln84xF6vLRpcjZxxEpMRrbUWQCVRoPgCXSs=
X-Received: by 2002:a19:7911:: with SMTP id u17mr1043793lfc.214.1612336277808;
 Tue, 02 Feb 2021 23:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20210203070636.70926-1-alexei.starovoitov@gmail.com> <baf2f6f5-9e0d-e09d-1030-f20288618e20@suse.com>
In-Reply-To: <baf2f6f5-9e0d-e09d-1030-f20288618e20@suse.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 2 Feb 2021 23:11:06 -0800
Message-ID: <CAADnVQ+mDa+m=qnbHAT2v_rknESrrc5GL8Z3i6TOK0BwhzydyA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Unbreak BPF_PROG_TYPE_KPROBE when kprobe is
 called via do_int3
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 2, 2021 at 11:09 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 3.02.21 =D0=B3. 9:06 =D1=87., Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The commit 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> > converted do_int3 handler to be "NMI-like".
> > That made old if (in_nmi()) check abort execution of bpf programs
> > attached to kprobe when kprobe is firing via int3
> > (For example when kprobe is placed in the middle of the function).
> > Remove the check to restore user visible behavior.
> >
> > Fixes: 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> > Reported-by: Nikolay Borisov <nborisov@suse.com>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Tested-by: Nikolay Borisov <nborisov@suse.com>
>
>
> So I take it you have verified the callpaths and deemed that it's safe
> to remove this check?

I stared a lot into different places. It's not pretty. I will follow up wit=
h
tightening patches for bpf-next, but I couldn't come up with anything
better for bpf tree.
