Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5052C679E6C
	for <lists+bpf@lfdr.de>; Tue, 24 Jan 2023 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjAXQUe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Jan 2023 11:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjAXQUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Jan 2023 11:20:33 -0500
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD78193FF;
        Tue, 24 Jan 2023 08:20:32 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id q141so7818091vkb.13;
        Tue, 24 Jan 2023 08:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRvaOYyC5sNficHNcLmGLW/x7PtaUYBGZNW6Hwgjd9c=;
        b=jDZLGDNDmqDYpClhO6vDirABVVZlLBWaxiGyGt9zR81400MfI+RCW+smVchbZl8Sb6
         IGzkVbr6vfMgx8+tt8IqFJBUYZ20XvzZiRFmqHHfv9DSFcMT1mLW0AV8UgUpKd6ZduAJ
         a/S5Df5FD2WyZxA8JZ8u2Uy2HlCtf8ys7/7DJIc7SJeGowfV5QcT0IxJcVFJqgglI/D+
         EuOQ+Nuusd6fjEmKKS3UideB/u/crVtqn2Bn/b0gAN8JbK6DY4VPY9r1qA3vMoSUkr2n
         /1v45L411OlRJeZb6DuN5fB1KsF9+c6Ts3Y29TU9SnTi8cpK1H/yEfP+u4uuhtdgOQqs
         Tp3Q==
X-Gm-Message-State: AFqh2koMXZSA4WB3WSmLoeoLMOmlNzLGRgJJ7L/X9xDSLvfosONhYF73
        8ueIokE/zV+dRzLd7FcgIXo=
X-Google-Smtp-Source: AMrXdXsx6Hfo6IZT2JN9cIDAItjHKN5wOzRXKiCaXLDNj+g9Y7uqE/BTR52DfhoMyVekfZ6xhUv7hg==
X-Received: by 2002:a1f:f881:0:b0:3c0:f6d6:3722 with SMTP id w123-20020a1ff881000000b003c0f6d63722mr18242290vkh.11.1674577231221;
        Tue, 24 Jan 2023 08:20:31 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:93a0])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a03cd00b006f9e103260dsm1638361qkm.91.2023.01.24.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:20:30 -0800 (PST)
Date:   Tue, 24 Jan 2023 10:20:31 -0600
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, memxor@gmail.com, hch@infradead.org
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Use BPF_KFUNC macro at all kfunc
 definitions
Message-ID: <Y9AFT4pTydKh+PD3@maniforge.lan>
References: <20230123171506.71995-1-void@manifault.com>
 <20230123171506.71995-4-void@manifault.com>
 <20230123183305.2mgoxgw4ca3sfk24@macbook-pro-6.dhcp.thefacebook.com>
 <Y87We/92xiv5/+g+@maniforge.lan>
 <20230123185434.ybfhrmbootcnjuoj@macbook-pro-6.dhcp.thefacebook.com>
 <ebff2166-8a70-af62-b859-6b5c6b008b36@iogearbox.net>
 <87o7qphspq.fsf@meer.lwn.net>
 <Y88sMlmrq0wCFSRP@maniforge.lan>
 <87lelsgf60.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lelsgf60.fsf@meer.lwn.net>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 24, 2023 at 07:50:31AM -0700, Jonathan Corbet wrote:
> David Vernet <void@manifault.com> writes:
> 
> > I was perhaps a bit naive to think we could just throw a __bpf_kfunc
> > macro onto the function signatures and call it a day :-) I think it's
> > probably best to table this for now, and either I or someone else can
> > come back to it when we have bandwidth to solve the problem more
> > appropriately.
> 
> Now I feel bad ... I was just tossing out a thought, not wanting to
> bikeshed this work into oblivion.  If what you have solves a real

No apologies necessary. I don't think this qualifies as bikeshedding.
IMO folks are raising legitimate UX concerns, which is important and
worth getting right.

> problem and is the best that can be done now, perhaps it should just go
> in and a "more appropriate" solution can be adopted later, should
> somebody manage to come up with it?

That would be my preference, but I also understand folks' sentiment of
wanting to keep out what they feel like is odd syntax, as Christoph said
in [0], and Daniel alluded to earlier in this thread.

[0]: https://lore.kernel.org/all/Y8+FeH7rz8jDTubt@infradead.org/

I tested on an LTO build and wrapper kfuncs (with external linkage) were
not being stripped despite not being called from anywhere else in the
kernel, so for now I _think_ it's safe to call this patch set more of a
cleanup / future-proofing than solving an immediate and pressing problem
(as long as anyone adding kfuncs carefully follows the directions in
[1]). In other words, I think we have some time to do this the right way
without paying too much of a cost later. If we set up the UX correctly,
just adding an EXPORT_SYMBOL_KFUNC call (or something to that effect,
including just using BTF_ID_FLAGS) should be minimal effort even if
there are a lot more kfuncs by then.

[1]: https://docs.kernel.org/bpf/kfuncs.html

If it turns out that we start to observe problems in LTO builds without
specifying __used and/or noinline, or if folks are repeatedly making
mistakes when adding kfuncs (by e.g. not giving wrapper kfuncs external
linkage) then I think it would be a stronger case to get this in now and
fix it up later.

Thanks,
David
