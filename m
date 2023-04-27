Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E286F0025
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 06:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbjD0EU4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 00:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbjD0EUz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 00:20:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6D62D69;
        Wed, 26 Apr 2023 21:20:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b5c4c769aso10059457b3a.3;
        Wed, 26 Apr 2023 21:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682569253; x=1685161253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BONeYIFLJq0vXAPyZahD6Bfdi9YUeA9030sfVciDEJM=;
        b=nbkBhp9Jt0UWEwqavOqHkh/FDxkxXG6Lf1kbYAEDs3W/x81BT8DRLxoko/3I0TbwgD
         tO9EYgc4cBan3r3tNA1iF0sIxS/wZUiobM+voK5lZEJT0FVHXQay2DKlQqcP78ZbqUCF
         5o+3AzH2LEOMu0nZNEB2og1KHjKKn56DpNpiJJ7mKgwUYE2Q8F6TNaqTUslZGJszzqqW
         EC0YUi8Yz4slacvG6SgfZhBtYeWbpQJ5boBzCfeZXG9rBBldHoZLknktSh9bDi+00DmH
         znX4gCezeqgL3xy1kS0yb3E48hbV6JmD0LSje1dpVuVVu3d0RG7kq9N+iaCf15MQH154
         Lq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682569253; x=1685161253;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BONeYIFLJq0vXAPyZahD6Bfdi9YUeA9030sfVciDEJM=;
        b=eEu39uS+3x5asZ1O4f7uEs/PHF/oUErGRGRVhxJNMu4VNm5i4ySZGFRrVcD0StQ8rz
         S5+d0nGfmGvc6aA2FDObcYnAcepqLG0DKoJFB4y9EEs1nI10RGMBpnKL3W6GUvFVshFp
         WXa7diuWDnqjFvBxm6s276NxrcGGGGSwKf6HOaQplulc+kGzhE7cqSfsVO4AiCC6ISXa
         UvXyMWD7hmmOIfSPoV0Ek48AB6anDibDoH9YqFlwx3w99T4WTzsWdyo7m7aC7+snopIl
         Bn+CPydvzyRoGKmt0wCLXsaYlrVYfkCpKzZP1OnX5N8Qb8+yjrOGciozIt5nILRAeYzl
         1d1A==
X-Gm-Message-State: AC+VfDzYRsMjCaQ5SMCu6VMrETGKf+gsWywA2FKFMStwZTV+vFooxWEj
        Ezsu1WJAjLlNrqL672MLrxw=
X-Google-Smtp-Source: ACHHUZ4F1Jvcg6bkEeOt/S2r7Iw5+gHGNXI5xLQce54ceYTBbsYQLvvVcH0jdXgvFJXAUtKEda4PdA==
X-Received: by 2002:a05:6a20:8f08:b0:f0:ec64:f3de with SMTP id b8-20020a056a208f0800b000f0ec64f3demr277089pzk.25.1682569253378;
        Wed, 26 Apr 2023 21:20:53 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:3ca5])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a448a00b00246cf1a8d3dsm10448041pjg.17.2023.04.26.21.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 21:20:52 -0700 (PDT)
Date:   Wed, 26 Apr 2023 21:20:49 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: Re: [RFC bpf-next v2 1/4] selftests/bpf: Add benchmark for bpf
 memory allocator
Message-ID: <20230427042049.a6knzkteidm2dfm3@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230408141846.1878768-1-houtao@huaweicloud.com>
 <20230408141846.1878768-2-houtao@huaweicloud.com>
 <20230422025930.fwoodzn6jlqe2jt5@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <6887e058-45e5-bbec-088a-ebc43bb066c9@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6887e058-45e5-bbec-088a-ebc43bb066c9@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 23, 2023 at 09:55:24AM +0800, Hou Tao wrote:
> >
> >> ./bench htab-mem --use-case $name --max-entries 16384 \
> >> 	--full 50 -d 7 -w 3 --producers=8 --prod-affinity=0-7
> >>
> >> | name                | loop (k/s) | average memory (MiB) | peak memory (MiB) |
> >> | --                  | --         | --                   | --                |
> >> | no_op               | 1129       | 1.15                 | 1.15              |
> >> | overwrite           | 24.37      | 2.07                 | 2.97              |
> >> | batch_add_batch_del | 10.58      | 2.91                 | 3.36              |
> >> | add_del_on_diff_cpu | 13.14      | 380.66               | 633.99            |
> > large mem for diff_cpu case needs to be investigated.
> The main reason is that tasks-trace RCU GP is slow and there is only one
> inflight free callback, so the CPUs which only do element addition will allocate
> new memory from slab continuously and the CPUs which only do element deletion
> will free these elements continuously through call_tasks_trace_rcu(), but due to
> the slowness of tasks-trace RCU GP, these freed elements could not be freed back
> to slab subsystem timely.

I see. Now it makes sense. It's slow call_tasks_trace_rcu and not at all "memory can never be reused."
Please explain things clearly in commit log.

> >> +{
> >> +	__u64 *value;
> >> +
> >> +	if (ctx->from >= ctx->max)
> >> +		return 1;
> >> +
> >> +	value = bpf_map_lookup_elem(&array, &ctx->from);
> >> +	if (value)
> >> +		bpf_map_update_elem(&htab, &ctx->from, value, flags);
> > What is a point of doing lookup from giant array of en element with zero value
> > to copy it into htab?
> > Why not to use single zero inited elem for all htab ops?
> I want to check how does the different size of value effect the benchmark
> result, so I choose a variable-size value.

Not following. All elements of the array have the same size.
Are you saying you were not able to figure out how to supply a single 'value'
of variable size? Try array of max_entries=1.
Do not do unnecessary and confusing bpf_map_lookup_elem(&array, &ctx->from);.

> >
> > Each loop will run 16k times and every time you step += 4.
> > So 3/4 of these 16k runs it will be hitting if (ctx->from >= ctx->max) condition.
> > What are you measuring?
> As explained in the commit message, I am trying to let different deletion and
> deletion CPU pairs operate on the different subsets of hash-table elements.
> Assuming there are 16 elements in the htab and there are 8 CPUs and 8 threads,
> the following is the operation subset for each CPU:
> 
> CPU 0:  0 4 8 12 (do deletion)
> CPU 1:  0 4 8 12 (do addition)
> 
> CPU 2:  1 5 9 13
> CPU 3:  1 5 9 13
> 
> CPU 4:  2 6 10 14
> CPU 5:  2 6 10 14
> 
> CPU 6:  3 7 11 15
> CPU 7:  3 7 11 15

That part is clear, but

> >> +	__sync_fetch_and_add(&loop_cnt, 1);

this doesn't match the rest. loop_cnt is inremented 4 times faster.
So it's not comparable to other tests.
