Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC16F06DB
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbjD0Nqa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 09:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243361AbjD0Nq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 09:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0950B19AC;
        Thu, 27 Apr 2023 06:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98447617C2;
        Thu, 27 Apr 2023 13:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03324C433D2;
        Thu, 27 Apr 2023 13:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682603188;
        bh=DF9MTs/t39R9KsV5ErUBwEc5MNvvWKq0CgPXOj1nD/U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AzIPUDKWEzbyloo+VVOJSqQDo7NLv1dilYjNy+RHJ/W78Ug1Hfm1uYQOR/21EjOqT
         jd2LMwqhDeH79RzVjNedr4ik88rDg2VGofUL/yh2Gx8KafoIl97oSGnj6vNvhYNcGw
         Ct36ssoZv6Gk6DoqfqJ2ZPENX/P551iRbU5QU6+j/PNJ3cMlQRptqigL152cjT/rTW
         I/tjTaz3ZGA2bpdtpQ5P8vBqfN16TW5dhJN9fpSD2lUMrG9oLpKQ+ywfbxxs/Ohu9Q
         9aGUAIhSBgwS5dmPTuUlI+EWtZ4eguFhne2XcWMdXEwAwupi9wH9P8wF+gInKiz1fO
         6u0q0T/zDUZwA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 99AF215404B7; Thu, 27 Apr 2023 06:46:27 -0700 (PDT)
Date:   Thu, 27 Apr 2023 06:46:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: Re: [RFC bpf-next v2 1/4] selftests/bpf: Add benchmark for bpf
 memory allocator
Message-ID: <4ef33ab5-0bb6-4877-bd75-7d34e71213fc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
 <20230408141846.1878768-2-houtao@huaweicloud.com>
 <20230422025930.fwoodzn6jlqe2jt5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <6887e058-45e5-bbec-088a-ebc43bb066c9@huaweicloud.com>
 <20230427042049.a6knzkteidm2dfm3@dhcp-172-26-102-232.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230427042049.a6knzkteidm2dfm3@dhcp-172-26-102-232.dhcp.thefacebook.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 09:20:49PM -0700, Alexei Starovoitov wrote:
> On Sun, Apr 23, 2023 at 09:55:24AM +0800, Hou Tao wrote:
> > >
> > >> ./bench htab-mem --use-case $name --max-entries 16384 \
> > >> 	--full 50 -d 7 -w 3 --producers=8 --prod-affinity=0-7
> > >>
> > >> | name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
> > >> | --                  | --         | --                   | --                |
> > >> | no_op               | 1129       | 1.15                 | 1.15              |
> > >> | overwrite           | 24.37      | 2.07                 | 2.97              |
> > >> | batch_add_batch_del | 10.58      | 2.91                 | 3.36              |
> > >> | add_del_on_diff_cpu | 13.14      | 380.66               | 633.99            |
> > > large mem for diff_cpu case needs to be investigated.
> > The main reason is that tasks-trace RCU GP is slow and there is only one
> > inflight free callback, so the CPUs which only do element addition will allocate
> > new memory from slab continuously and the CPUs which only do element deletion
> > will free these elements continuously through call_tasks_trace_rcu(), but due to
> > the slowness of tasks-trace RCU GP, these freed elements could not be freed back
> > to slab subsystem timely.
> 
> I see. Now it makes sense. It's slow call_tasks_trace_rcu and not at all "memory can never be reused."
> Please explain things clearly in commit log.

Is this a benchmarking issue, or is this happening in real workloads?

If the former, one trick I use in rcutorture's callback-flooding code is
to pass the ready-to-be-freed memory directly back to the allocating CPU.
Which might be what you were getting at with your "maybe stealing from
free_list of other CPUs".

If this is happening in real workloads, then I would like to better
understand that workload.

							Thanx, Paul
