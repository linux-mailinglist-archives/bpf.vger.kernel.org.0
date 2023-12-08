Return-Path: <bpf+bounces-17112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5771809D2E
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 08:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10635B20CEA
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 07:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C801110781;
	Fri,  8 Dec 2023 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oSe6712I"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0626D1721
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 23:33:21 -0800 (PST)
Message-ID: <8faf1308-2f9f-4923-804e-8d9b11ba74e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702020799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lglskR3KX8IH/WdEpciW9C4YcgXG92rozQyUCJ+NYvs=;
	b=oSe6712Inb4+L9rwGiPucvw2o9SsNvy80j3VYObt2AJB4KKxlR9fQ8rGIaHz3KHlbbcCH9
	VDe1RpKET8t+3mCA/5AUS0RogkPmMWaHVSDNglmfQKf7Y78G+mVl3oFwMAAJM2G56gG7J7
	OS4HLNQS8aoYVNts+sh1h9X9F/EgIeQ=
Date: Thu, 7 Dec 2023 23:33:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v9 14/15] p4tc: add set of P4TC table kfuncs
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com,
 toke@redhat.com, daniel@iogearbox.net, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20231201182904.532825-1-jhs@mojatatu.com>
 <20231201182904.532825-15-jhs@mojatatu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231201182904.532825-15-jhs@mojatatu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/1/23 10:29 AM, Jamal Hadi Salim wrote:
> We add an initial set of kfuncs to allow interactions from eBPF programs
> to the P4TC domain.
> 
> - bpf_p4tc_tbl_read: Used to lookup a table entry from a BPF
> program installed in TC. To find the table entry we take in an skb, the
> pipeline ID, the table ID, a key and a key size.
> We use the skb to get the network namespace structure where all the
> pipelines are stored. After that we use the pipeline ID and the table
> ID, to find the table. We then use the key to search for the entry.
> We return an entry on success and NULL on failure.
> 
> - xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
> program installed in XDP. To find the table entry we take in an xdp_md,
> the pipeline ID, the table ID, a key and a key size.
> We use struct xdp_md to get the network namespace structure where all
> the pipelines are stored. After that we use the pipeline ID and the table
> ID, to find the table. We then use the key to search for the entry.
> We return an entry on success and NULL on failure.
> 
> - bpf_p4tc_entry_create: Used to create a table entry from a BPF
> program installed in TC. To create the table entry we take an skb, the
> pipeline ID, the table ID, a key and its size, and an action which will
> be associated with the new entry.
> We return 0 on success and a negative errno on failure
> 
> - xdp_p4tc_entry_create: Used to create a table entry from a BPF
> program installed in XDP. To create the table entry we take an xdp_md, the
> pipeline ID, the table ID, a key and its size, and an action which will
> be associated with the new entry.
> We return 0 on success and a negative errno on failure
> 
> - bpf_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
> First does a lookup using the passed key and upon a miss will add the entry
> to the table.
> We return 0 on success and a negative errno on failure
> 
> - xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
> First does a lookup using the passed key and upon a miss will add the entry
> to the table.
> We return 0 on success and a negative errno on failure
> 
> - bpf_p4tc_entry_update: Used to update a table entry from a BPF
> program installed in TC. To update the table entry we take an skb, the
> pipeline ID, the table ID, a key and its size, and an action which will
> be associated with the new entry.
> We return 0 on success and a negative errno on failure
> 
> - xdp_p4tc_entry_update: Used to update a table entry from a BPF
> program installed in XDP. To update the table entry we take an xdp_md, the
> pipeline ID, the table ID, a key and its size, and an action which will
> be associated with the new entry.
> We return 0 on success and a negative errno on failure
> 
> - bpf_p4tc_entry_delete: Used to delete a table entry from a BPF
> program installed in TC. To delete the table entry we take an skb, the
> pipeline ID, the table ID, a key and a key size.
> We return 0 on success and a negative errno on failure
> 
> - xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
> program installed in XDP. To delete the table entry we take an xdp_md, the
> pipeline ID, the table ID, a key and a key size.
> We return 0 on success and a negative errno on failure

[ ... ]

> +BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
> +BTF_ID_FLAGS(func, bpf_p4tc_tbl_read, KF_RET_NULL);
> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create);
> +BTF_ID_FLAGS(func, bpf_p4tc_entry_create_on_miss);
> +BTF_ID_FLAGS(func, bpf_p4tc_entry_update);
> +BTF_ID_FLAGS(func, bpf_p4tc_entry_delete);
> +BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)

These create/read/update/delete kfuncs are like defining a new hidden bpf map 
type in the kernel. bpf prog can now create its own link-list and rbtree. 
sched_ext has already been using it. This is the way the bpf prog should use 
instead of creating a new map type.

