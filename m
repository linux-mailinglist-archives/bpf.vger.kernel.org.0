Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D92D57D550
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiGUU6X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233072AbiGUU6U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 16:58:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACB3904F0;
        Thu, 21 Jul 2022 13:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF54EB82680;
        Thu, 21 Jul 2022 20:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E5AC3411E;
        Thu, 21 Jul 2022 20:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658437087;
        bh=TJy6oV2ClpHeP1ehFHQPSiyhoWHgHghft6FoozMWqQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V99tJWDcRv1RzXemv+3Vfvjgenyc7nS3ZG+WWdTqQDeQNbj6aXRLWYgpTiwz0Z2Th
         oXRgO11iP5ibVAECA3ZgfhEHCq2HDspzoJ3U0iGzaqavJCbD4Q60MJdC1X18MnBZzS
         LOw5oU4GcZoQlSYQXNAAW+ygYc9HKz13l7nRwIuBRf7pFCeaYQLEFDjKNGmWCQ4HlK
         zHwlMEB9zCY18bn6/gm2Fw4HW368+3Uwfluz520FeEWc1RTezjHCNu1YGM33TUUXqS
         xiMPotDdrO/nwkkeMyi6bFKI42F7bsr1Ukft7ausiyE02yso2TPYxVRl1ZyJWexIp2
         1oFymV61XI/sA==
Date:   Thu, 21 Jul 2022 21:58:00 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/1] bpf: Drop unprotected find_vpid() in favour of
 find_get_pid()
Message-ID: <Ytm92NYx4SyKN4Nm@google.com>
References: <20220721111430.416305-1-lee@kernel.org>
 <Ytk+/npvvDGg9pBP@krava>
 <Ytk/jT+zyNZpafgn@google.com>
 <YtlDPYQWDcORbP0o@krava>
 <fbc98bb0-a2d6-a450-e6fc-878701e5906d@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbc98bb0-a2d6-a450-e6fc-878701e5906d@fb.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 21 Jul 2022, Yonghong Song wrote:

> 
> 
> On 7/21/22 5:14 AM, Jiri Olsa wrote:
> > On Thu, Jul 21, 2022 at 12:59:09PM +0100, Lee Jones wrote:
> > > On Thu, 21 Jul 2022, Jiri Olsa wrote:
> > > 
> > > > On Thu, Jul 21, 2022 at 12:14:30PM +0100, Lee Jones wrote:
> > > > > The documentation for find_pid() clearly states:
> > 
> > typo find_vpid
> > 
> > > > > 
> > > > >    "Must be called with the tasklist_lock or rcu_read_lock() held."
> > > > > 
> > > > > Presently we do neither.
> > 
> > just curious, did you see crash related to this or you just spot that
> > 
> > > > > 
> > > > > In an ideal world we would wrap the in-lined call to find_vpid() along
> > > > > with get_pid_task() in the suggested rcu_read_lock() and have done.
> > > > > However, looking at get_pid_task()'s internals, it already does that
> > > > > independently, so this would lead to deadlock.
> > > > 
> > > > hm, we can have nested rcu_read_lock calls, right?
> > > 
> > > I assumed not, but that might be an oversight on my part.
> 
> From kernel documentation, nested rcu_read_lock is allowed.
> https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html
> 
> RCU's grace-period guarantee allows updaters to wait for the completion of
> all pre-existing RCU read-side critical sections. An RCU read-side critical
> section begins with the marker rcu_read_lock() and ends with the marker
> rcu_read_unlock(). These markers may be nested, and RCU treats a nested set
> as one big RCU read-side critical section. Production-quality
> implementations of rcu_read_lock() and rcu_read_unlock() are extremely
> lightweight, and in fact have exactly zero overhead in Linux kernels built
> for production use with CONFIG_PREEMPT=n.
> 
> > > 
> > > Would that be your preference?
> > 
> > seems simpler than calling get/put for ppid
> 
> The current implementation seems okay since we can hide
> rcu_read_lock() inside find_get_pid(). We can also avoid
> nested rcu_read_lock(), which is although allowed but
> not pretty.

Right, this was my thinking.

Happy to go with whatever you guys decide though.

Make the call and I'll rework, or not.

-- 
Lee Jones [李琼斯]
