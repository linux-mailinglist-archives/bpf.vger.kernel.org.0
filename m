Return-Path: <bpf+bounces-26209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501B089CAE5
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 19:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091B22868E3
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE4E143C7E;
	Mon,  8 Apr 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="DGqFJ0zy"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A87143C59;
	Mon,  8 Apr 2024 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597759; cv=none; b=d38y7qPxbcmx9HP3aZ59G7Bg17JjxdIe2n9vlfcPCrGNq8RB5c1002LQFdL576UR56bNlmCrQahJm54hD/GGl8oduW6veqUxkOLfsjcYbzqmboTd2vkDRffPN3R7iExuOsNtn2utLYFSZeQYJgN3pFiEfulKELxbS+s/yH3r2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597759; c=relaxed/simple;
	bh=Gt8kmdgt3jC/2C9AavtI++umsEd4HivNfc+qOWCE0NU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KY01pcekunPvivqGrsi4X6McV9ol8yh7pgRys4oOM0hNnbmDlcfhffxxgXikObMsFjVZuHHzWxj+ggqvDyS3tA7DI2jXdHDMFIh0shFm5mjUcGs6TXsHn1Ev69tJE6H49OEZj91lGkJPP+qEtVZTPVcUWd8vkX/dEzsJHcAKSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=DGqFJ0zy; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zqfMpMqh1K3K3KMFWSlU2agOFI0BMTv0sMd0UrEYpvs=; b=DGqFJ0zysgp7o499yBYyBB6WfC
	yR2ohk87cpJpLV06Eelb6o9zTkF+mqWriNNps/zRHCOWKgd/fP6yKKAMLhQvorQrrkyZklWK8q5GL
	zB6Ls8+2n5A4Uz9W7ukbid8nMcLa/slUT5Mls2Tp8mPbBzNR5EOXBwKftWN/P7JkkrCd33AwxmD5a
	PGGuD4SvjXsu4LhZSnjICaHFzeZpVjeebDqRW62LvSkp7mbIdwYsWdJdAWRv0pDeJx/w8EBmSN5Y1
	r3r7SVVHqimntxjr1D6frifuhBVP9YZZxtoPZFHzOfqhH98NzawuNyOLLo8VF3nS0ZVjquTtgW00E
	aDdA815g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rtsuH-000ASw-2u; Mon, 08 Apr 2024 19:35:45 +0200
Received: from [178.197.249.16] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rtsuF-0081uc-2G;
	Mon, 08 Apr 2024 19:35:43 +0200
Subject: Re: [PATCH net-next v15 14/15] p4tc: add set of P4TC table kfuncs
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com, anjali.singhai@intel.com,
 namrata.limaye@intel.com, tom@sipanda.io, mleitner@redhat.com,
 Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com,
 horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, martin.lau@linux.dev,
 victor@mojatatu.com, pctammela@mojatatu.com, alexei.starovoitov@gmail.com,
 bpf@vger.kernel.org
References: <20240408122000.449238-1-jhs@mojatatu.com>
 <20240408122000.449238-15-jhs@mojatatu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f27bfc4d-8985-6d3d-01f5-782ae1ccb9ee@iogearbox.net>
Date: Mon, 8 Apr 2024 19:35:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240408122000.449238-15-jhs@mojatatu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27239/Mon Apr  8 10:26:06 2024)

On 4/8/24 2:19 PM, Jamal Hadi Salim wrote:
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
> 
> Note:
> All P4 objects are owned and reside on the P4TC side. IOW, they are
> controlled via TC netlink interfaces and their resources are managed
> (created, updated, freed, etc) by the TC side. As an example, the structure
> p4tc_table_entry_act is returned to the ebpf side on table lookup. On the
> TC side that struct is wrapped around p4tc_table_entry_act_bpf_kern.
> A multitude of these structure p4tc_table_entry_act_bpf_kern are
> preallocated (to match the P4 architecture, patch #9 describes some of
> the subtleties involved) by the P4TC control plane and put in a kernel
> pool. Their purpose is to hold the action parameters for either a table
> entry, a global per-table "miss" and "hit" action, etc - which are
> instantiated and updated via netlink per runtime requests. An instance of
> the p4tc_table_entry_act_bpf_kern.p4tc_table_entry_act is returned
> to ebpf when there is a un/successful table lookup depending on how the
> P4 program is written. When the table entry is deleted the instance of
> the struct p4tc_table_entry_act_bpf_kern is recycled to the pool to be
> reused for a future table entry. The only time the pool memory is released
> is when the pipeline is deleted.
> 
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Nacked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>

Given the many reasons stated earlier & for the record:

Nacked-by: Daniel Borkmann <daniel@iogearbox.net>

