Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD90520435A
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 00:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgFVWLY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 18:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgFVWLW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 18:11:22 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A2C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 15:11:22 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 35so8204223ple.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 15:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jsVPzH2ZVzYXWKsg/xSATy1OsuZYQqUQ4NemGXf0ce8=;
        b=aNJWwU9UXIKVUaiaAAveP5pLL/g5ojqY/oSuaNd1xCspd8/0/1p0d1Km3HAcEN0Nh2
         LjYkm+xdBZC4Wpz3YABbkAoYnKgcz/ztYWWjAYKfVIJykrs3kqPeeOL5HFAGEPEem1BW
         5lViUUPafqHgKu9AWNqWAwA39s2WGwfyc7og3ZQ+sISgqC/xI71MI37gCZW9kkggsesK
         lyW2FdjNWlCuq3WrkLnYnld1ZPJ1bofb+i9m0Gha3GYkkWNrdnPoxoEcv+ub1FHqPFEE
         IP1dMd1i9rnQj1GOLJR7MLNmxVwWWb+UQYgfrx0QI52mPKHxV+6ordCJr2Npq+gDXQPq
         U8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jsVPzH2ZVzYXWKsg/xSATy1OsuZYQqUQ4NemGXf0ce8=;
        b=D8b97O03HSzQOd/IgwXK36EZ0JwMvyuNMom48670iQLvKj0S1rpQAMMHJArqjWsFZP
         CftZx72Ll191JJWzw1elzz9tWF+siq3LB2HjtDaDQUjpO8epeTfjA9Y5wJbPLKopGpeY
         u7u5NP30Sz3iHEEF+pU7WR5xOlVLlmFQ5RCbD2YkLVGV6d7+M9taaDJjBtr1yF96YU+i
         fEZIjzuK7N8GMxf+bEX40XbEMEh1wJkETguKAw/BsY9l79OH70lIhI2HkkPzV2SvcZzE
         lQZxCXdqoB6XBOzZPrDjn1XIftqpo1GWGPwE6fcmXe7dgRXFQ2GXIZ6+1PzY2d4oicOw
         awvg==
X-Gm-Message-State: AOAM532RnRmZ0GtQQ3Xsru1WKbnJHhacWzujELBGCrptIdBdeiR7dtVk
        9xlXDe4Yag5KwpkUbBq/yGEEIWbC
X-Google-Smtp-Source: ABdhPJw0Idu0XtNqB6CvqREpI1PauS/5xK/gB6K+pkAeYHNQbWclbmDSvYKctUiLEOjkn42rJJozdg==
X-Received: by 2002:a17:90a:d206:: with SMTP id o6mr18587853pju.132.1592863882084;
        Mon, 22 Jun 2020 15:11:22 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:739c])
        by smtp.gmail.com with ESMTPSA id q10sm15836700pfk.86.2020.06.22.15.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:11:21 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:11:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrey Ignatov <rdna@fb.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Support access to bpf map fields
Message-ID: <20200622221118.4czg7mtsy5e5vuqv@ast-mbp.dhcp.thefacebook.com>
References: <cover.1592600985.git.rdna@fb.com>
 <6479686a0cd1e9067993df57b4c3eef0e276fec9.1592600985.git.rdna@fb.com>
 <5eeed39388e0d_38742acbd4fa45b89b@john-XPS-13-9370.notmuch>
 <20200622183911.GA31771@rdna-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622183911.GA31771@rdna-mbp.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 22, 2020 at 11:39:11AM -0700, Andrey Ignatov wrote:
> John Fastabend <john.fastabend@gmail.com> [Sat, 2020-06-20 20:27 -0700]:
> > Andrey Ignatov wrote:
> ...
> > > 
> > > The feature is available only for CONFIG_DEBUG_INFO_BTF=y and gated by
> > > perfmon_capable() so that unpriv programs won't have access to bpf map
> > > fields.
> > > 
> > > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > > ---
> > >  include/linux/bpf.h                           |  9 ++
> > >  include/linux/bpf_verifier.h                  |  1 +
> > >  kernel/bpf/arraymap.c                         |  3 +
> > >  kernel/bpf/btf.c                              | 40 +++++++++
> > >  kernel/bpf/hashtab.c                          |  3 +
> > >  kernel/bpf/verifier.c                         | 82 +++++++++++++++++--
> > >  .../selftests/bpf/verifier/map_ptr_mixing.c   |  2 +-
> > >  7 files changed, 131 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 07052d44bca1..1e1501ee53ce 100644
> > 
> > LGTM, but any reason not to allow this with bpf_capable() it looks
> > useful for building load balancers which might not be related to
> > CAP_PERFMON.
> 
> Thanks for review John. I agree that this can be useful for many
> use-cases, incl. networking programs.
> 
> Accessing a kernel struct looks like "tracing" kind of functionality to
> me (that's why CAP_PERFMON), but I'm not quite sure, and using
> bpf_capable() looks fine as well.
> 
> Alexei, since you introduced CAP_BPF, could you clarify which cap is the
> right one to use here and why?

It's tracing and pointers are accessed, so cap_perfmon.
