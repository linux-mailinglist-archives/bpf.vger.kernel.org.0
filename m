Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF372D3471
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 21:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgLHUlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 15:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgLHUlu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 15:41:50 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861BEC061794
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 12:41:09 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f23so26569573ejk.2
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 12:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=GY4quZCaSnF2YYcFBZRxCRau/11uuDMbwi+oWqtuM1k=;
        b=TvPQr7/uYkYDPuyGQ0ikNVrQg5P9WPbsBMJPgWQP/PhBgDH7YcbheuxLR6Q/dVcHFz
         oYtxly75A0e95xyaiwnaEoz8xFf/lfIPm9I1d4u7uWlC5dZfJBJqh94BADDy4/rGWQgk
         bqGGwzpCq96PNrubgsbmY+lFjrAERE0H0zGvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=GY4quZCaSnF2YYcFBZRxCRau/11uuDMbwi+oWqtuM1k=;
        b=AySs/YARNQZ9m2JzuowVBVJ3h/YfuDYCR2372TqTth0mawqs04apHvm1bS5xvqIPpT
         yJkSpGH1/pLA8HLmK6Rry9Crk5oonDBRtQ99y9+IR04Oc1uIXw5nvvKTTJGkQkHUlQum
         bdPBMtr7JLk1jd4JzLUwkibPgUPzYVZ+pIcMh/WFz0ENswDoSybr3EX7KTAGFBTn/apO
         7cKX68TsnZpvsElQk/0dy7j3rxWivC17/8XGg5GWzAl7JlDhogj+wEk1wvdywHvz6OHJ
         eSdEfLyMtSDyFAxu6+7pho6527bZc/QOB+Jlo45kEy2GLjUQ5DNZaKTJYDWwRiQIFUb3
         2d7Q==
X-Gm-Message-State: AOAM5304JC9xsxlTBkmZw+OA0kxFyxWUgdgpTcajU0/R+BVQQa+x4zXZ
        4t6qW6ibbBpkiQ0ihZEheqpc0mMQLLBpnQ==
X-Google-Smtp-Source: ABdhPJwvbrvemQKmbeKSlfOTCoUsa8itRssg23nqKeH51AwGcQ93HLRV4DLfPX1uOHlUaRZV74BZgA==
X-Received: by 2002:a50:d484:: with SMTP id s4mr13538549edi.13.1607455854622;
        Tue, 08 Dec 2020 11:30:54 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id z22sm16468889eji.91.2020.12.08.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:30:52 -0800 (PST)
Message-ID: <61135b81892e029d293b1baa3345ba78f1e848c7.camel@chromium.org>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Expose bpf_get_socket_cookie to
 tracing programs
From:   Florent Revest <revest@chromium.org>
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, kpsingh@chromium.org,
        revest@google.com, linux-kernel@vger.kernel.org
Date:   Tue, 08 Dec 2020 20:30:51 +0100
In-Reply-To: <7c70a64f-1aba-0e11-983d-9338f25a367e@iogearbox.net>
References: <20201203213330.1657666-1-revest@google.com>
         <bdd7153b-4bf9-12dd-5950-df0ebe91659d@iogearbox.net>
         <7c70a64f-1aba-0e11-983d-9338f25a367e@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2020-12-04 at 20:03 +0100, Daniel Borkmann wrote:
> On 12/4/20 7:56 PM, Daniel Borkmann wrote:
> > On 12/3/20 10:33 PM, Florent Revest wrote:
> > > This creates a new helper proto because the existing
> > > bpf_get_socket_cookie_sock_proto has a ARG_PTR_TO_CTX argument
> > > and only
> > > works for BPF programs where the context is a sock.
> > > 
> > > This helper could also be useful to other BPF program types such
> > > as LSM.
> > > 
> > > Signed-off-by: Florent Revest <revest@google.com>
> > > ---
> > >   include/uapi/linux/bpf.h       | 7 +++++++
> > >   kernel/trace/bpf_trace.c       | 4 ++++
> > >   net/core/filter.c              | 7 +++++++
> > >   tools/include/uapi/linux/bpf.h | 7 +++++++
> > >   4 files changed, 25 insertions(+)
> > > 
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index c3458ec1f30a..3e0e33c43998 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -1662,6 +1662,13 @@ union bpf_attr {
> > >    *     Return
> > >    *         A 8-byte long non-decreasing number.
> > >    *
> > > + * u64 bpf_get_socket_cookie(void *sk)
> > > + *     Description
> > > + *         Equivalent to **bpf_get_socket_cookie**\ () helper
> > > that accepts
> > > + *         *sk*, but gets socket from a BTF **struct sock**.
> > > + *     Return
> > > + *         A 8-byte long non-decreasing number.
> > 
> > I would not mention this here since it's not fully correct and we
> > should avoid users taking non-decreasing granted in their progs.
> > The only assumption you can make is that it can be considered a
> > unique number. See also [0] with reverse counter..
> > 
> >    [0] 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=92acdc58ab11af66fcaef485433fde61b5e32fac

Ah this is a good point, thank you! I will send a v3 with an extra
patch that s/non-decreasing/unique/ in the other descriptions. I had
not given it any extra thought, I just stupidly copied/pasted existing
descriptions. :) 

> One more thought, in case you plan to use this from sleepable
> context, you would need to use sock_gen_cookie() variant in the BPF
> helper instead.

Out of curiosity, why don't we just always call sock_gen_cookie? Is it
to avoid the performance impact of increasing the preempt counter and
introducing a memory barriers ?

