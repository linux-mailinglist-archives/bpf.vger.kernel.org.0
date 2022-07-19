Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAAF57A75C
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 21:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbiGSTli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 15:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGSTlh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 15:41:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FB152DEB
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:41:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id bu1so23113390wrb.9
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqMPXU/hy5J5UT9zpbIzXR+SmaMEDpe2x0xawCu4+Xc=;
        b=OA15sUKR2X0chr/bQ+n2GmiKnfDbGXZm3GeDMLbos4nNcOj1PvYehwq3gxyn5O9AC/
         J5nXTROb0GVX4AqQFlSuJKKDxYfWCkiYzql5P3a8EnLhM/H97610BoFlL2T9XLT1pejr
         gpcoaMuVuSswKkRM0VTC4ZYCNU54Rzju9G1+I/9ieqeuQe6ZWvy0RtQSM0CWmp7u9ded
         wecICYnWAx8a1S8LE1qQ5yLmFikwuVW54WQ9SicxhJN0L1GhY4ZuCdskOYD26r62zLiW
         o3vhSM638MmTELWAqJl9jjRQeuuqX/to94roy29ZmdVDSDeVoT9ZC7LBCQY2fg0QBzh8
         IG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqMPXU/hy5J5UT9zpbIzXR+SmaMEDpe2x0xawCu4+Xc=;
        b=f5Ux82J//QLgG6L5R4Jm4LU+iwEMyZt6+Crug3GPi8LCi0riDrUveJE49534VYBSvS
         VuW9Yi7gM0eHbKZVjW9DVnVTD6cmjaVFRihYmEkttUW0lBv5+7DMgphzsvXsP1REdzRI
         hC1alvQi8MYTvL7CmqFJVkqVTpYJwt4i967Su7885bZZYsZkkrbMmSiHxWUekMVA/Rma
         8cyYLESV+OcGJc2nvTRymHRKhXYdthvgTLF1L66vqXfprjxZhnnxhjSy78vdD9Y1v9ff
         d48Be69nqfJ0gyxcRfdRZAp6LIGdU1oXQAKKZPrbkGvDBqWEtlxVouzTvVR03Gw64Ua/
         bxiw==
X-Gm-Message-State: AJIora/uYdKsvFOfSt1cfZUUb/moKwcAJ7PPX9f/Bp1a8QHpPDtDSFEr
        Yf/EYNdCiR3fJR7oK30+n7zPntbEhOSmIy9RNEQnsg==
X-Google-Smtp-Source: AGRyM1tdK6kWeAvNgfrVukdO99uXAAcU32CuU/nCYYUEoGbmfovUwPyylkBwB9waw8bPKdYlNnUKkDceMWFODZUX8P0=
X-Received: by 2002:a5d:588b:0:b0:21d:a918:65a5 with SMTP id
 n11-20020a5d588b000000b0021da91865a5mr28572759wrf.210.1658259694984; Tue, 19
 Jul 2022 12:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <Ys4wRqCWrV1WeeWp@castle>
 <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
 <YtaV6byXRFB6QG6t@dhcp22.suse.cz> <CAJD7tkbieq_vDxwnkk_jTYz9Fe1t5AMY6b3Q=8O-ag9YLo9uZg@mail.gmail.com>
 <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com>
 <YtcDEpaHniDeN7fP@slm.duckdns.org> <CAJD7tkZkFnVqjkdOK3Wf8f1o3XmMWCmWkzHNQKh8Znh5dDF27w@mail.gmail.com>
 <YtcIJClKxUPntdM9@slm.duckdns.org>
In-Reply-To: <YtcIJClKxUPntdM9@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 19 Jul 2022 12:40:58 -0700
Message-ID: <CAJD7tkZGpsYLB_rhbZUMyiKEzV+FYhyzFdNBtKrFzaRLi=p9Gw@mail.gmail.com>
Subject: Re: cgroup specific sticky resources (was: Re: [PATCH bpf-next 0/5]
 bpf: BPF specific memory allocator.)
To:     Tejun Heo <tj@kernel.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 12:38 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Jul 19, 2022 at 12:30:17PM -0700, Yosry Ahmed wrote:
> > Is there a reason why these resources cannot be moved across cgroups
> > dynamically? The only scenario I imagine is if you already have tmpfs
> > mounted and files charged to different cgroups, but once you attribute
> > tmpfs to one cgroup.charge_for.tmpfs (or sticky,..), I assume that we
> > can dynamically move the resources, right?
> >
> > In fact, is there a reason why we can't move the tmpfs charges in that
> > scenario as well? When we move processes we loop their pages tables
> > and move pages and their stats, is there a reason why we wouldn't be
> > able to do this with tmpfs mounts or bpf maps as well?
>
> Nothing is impossible but nothing is free as well. Moving charges around
> traditionally caused a lot of headaches in the past and never became
> reliable. There are inherent trade-offs here. You can make things more
> dynamic usually by making hot paths more expensive or doing some
> synchronization dancing which tends to be pretty hairy. People generally
> don't wanna make hot paths slower, so we tend to end up with something
> twisted which unfortunately turns out to be a headache in the long term.
>
> In general, I'd rather keep resource associations as static as possible.
> It's okay if we do something neat inside the kernel but if we create
> userspace expectation that resources can be moved around dynamically, we'll
> be stuck with that for a long time likely forfeiting future simplification /
> optimization opportunities.
>
> So, that's gonna be a fairly strong nack from my end.

Fair enough :)

Thanks for elaborating your point of view and the challenges that come
with this!

>
> Thanks.
>
> --
> tejun
