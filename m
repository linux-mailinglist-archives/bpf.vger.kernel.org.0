Return-Path: <bpf+bounces-3246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1598673B42C
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 11:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC581C20B12
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19CB524F;
	Fri, 23 Jun 2023 09:53:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3415246
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 09:53:48 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34F92689
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 02:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rEwzez6DbGNCs0gh0F4GeXUf/DEY4Tugli1sW4Pw/WI=; b=o4eLDg6W/L0q2mMNqH3QND845T
	f7aojKGlWePCNrIjxbNXvr6pZWepWKNNrveQRlfSIFGPgIeqMjLK0Lg7Rz91JbW2sV6PPomc2xeMh
	CIS36gnm5GnPzbPTgOLeN2d8BvpxB7GLJYCOxTzbDFX6s7mBQATIHr8zSJYYhmzeH5lxvDc2xJmmn
	oNruB4miAYla7Ru13/NFORJ4eUXZnS2eUkZMvUNBaaFv7pnrHMF2SDJv6MrDd0CgWFTcDvuNh4+Um
	/WeAj6zRPEhkx4gQ1B8bkddHTdX06zKRGpItW4Y72zP8vUQtjSS2czkJh5C/kpeKifsaq8GckA1hR
	CZTguF2Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCdTs-0002g6-7u; Fri, 23 Jun 2023 11:53:28 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCdTr-000ESQ-PJ; Fri, 23 Jun 2023 11:53:27 +0200
Subject: Re: [RFC v2 PATCH bpf-next 0/4] bpf: add percpu stats for bpf_map
To: Anton Protopopov <aspsk@isovalent.com>,
 Alexei Starovoitov <ast@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
References: <20230622095330.1023453-1-aspsk@isovalent.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d981e123-43a1-4d91-8b52-0097087656b2@iogearbox.net>
Date: Fri, 23 Jun 2023 11:53:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230622095330.1023453-1-aspsk@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26948/Fri Jun 23 09:28:15 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/22/23 11:53 AM, Anton Protopopov wrote:
> This series adds a mechanism for maps to populate per-cpu counters of elements
> on insertions/deletions. The sum of these counters can be accessed by a new
> kfunc from a map iterator program.
> 
> The following patches are present in the series:
> 
>    * Patch 1 adds a generic per-cpu counter to struct bpf_map
>    * Patch 2 utilizes this mechanism for hash-based maps
>    * Patch 3 extends the preloaded map iterator to dump the sum
>    * Patch 4 adds a self-test for the change
> 
> The reason for adding this functionality in our case (Cilium) is to get
> signals about how full some heavy-used maps are and what the actual dynamic
> profile of map capacity is. In the case of LRU maps this is impossible to get
> this information anyhow else. See also [1].
> 
> This is a v2 for the https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/T/#t
> It was rewritten according to previous comments.  I've turned this series into
> an RFC for two reasons:
> 
> 1) This patch only works on systems where this_cpu_{inc,dec} is atomic for s64.
> For systems which might write s64 non-atomically this would be required to use
> some locking mechanism to prevent readers from reading trash via the
> bpf_map_sum_elements_counter() kfunc (see patch 1)
> 
> 2) In comparison with the v1, we're adding extra instructions per map operation
> (for preallocated maps, as well as for non-preallocated maps). The only
> functionality we're interested at the moment is the number of elements present
> in a map, not a per-cpu statistics. This could be better achieved by using
> the v1 version, which only adds computations for preallocated maps.
> 
> So, the question is: won't it be fine to do the changes in the following way:
> 
>    * extend the preallocated hash maps to populate percpu batch counters as in v1
>    * add a kfunc as in v2 to get the current sum
> 
> This works as
> 
>    * nobody at the moment actually requires the per-cpu statistcs
>    * this implementation can be transparently turned into per-cpu statistics, if
>      such a need occurs on practice (the only thing to change would be to
>      re-implement the kfunc and, maybe, add more kfuncs to get per-cpu stats)
>    * the "v1 way" is the least intrusive: it only affects preallocated maps, as
>      other maps already provide the required functionality
> 
>    [1] https://lpc.events/event/16/contributions/1368/
> 
> v1 -> v2:
> - make the counters generic part of struct bpf_map
> - don't use map_info and /proc/self/fdinfo in favor of a kfunc

Tbh, I did like v1 approach a bit better. We are trying to bend over backwards just
so that we don't add things to uapi, but in the end we are also adding it to the
maps.debug, etc (yes, it has .debug in the name and all) ...

 > for maps can be extended to print the element count, so the user can have
 > convenient 'cat /sys/fs/bpf/maps.debug' way to debug maps.

... I feel with convenience access, some folks in the wild might build apps parsing
it in the end instead of writing iterators.

I would be curious to hear from Google and Meta folks in terms of how you observe
map fillup or other useful map related stats in production (unless you don't watch
out for this?), and if there is a common denominator we could come up with that
would be really useful for all parties and thus potentially make sense for fdinfo
or as an extensible bpf_map_info stats extension in case there is some agreement?

In our case we don't really care about exact numbers, just more around whether a
user is scaling up their k8s cluster to the point where the previous configurations
on sizing e.g. around LB mappings etc would hit the limits in the foreseeable future
if they dial up further. This is exported to dashboards (e.g. grafana) for visibility
so operators can know ahead of time.

The iterator approach is okay, less convenient, but if there is indeed nothing
common from other production users which helped map visibility over the years, then
so be it. I thought to at least ask given we have this thread. :)

Thanks,
Daniel

