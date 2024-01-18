Return-Path: <bpf+bounces-19767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E298310BF
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C8C1F223AC
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F87185D;
	Thu, 18 Jan 2024 01:12:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2B1844
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705540352; cv=none; b=fmnHJA07KkuvxFFHfTrVmG8AQw36kd+uxR50G7rAmG9WFISvEKvL4V92qFlBfe2B9MYDWUczx/zMfrBT2wbRfePcEwc/HrIClVKUBZAikPFW+urBxQHDfvIANX4RcMvrMTDFf0mdDkrOzOGNaJwS04XvmNUkw2R3T/UQHqQlyCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705540352; c=relaxed/simple;
	bh=5ZIE+lg9vcKp2Tu0XSGoZZnuo1xvqB5x7gUbVw7x9fg=;
	h=Received:Received:Received:Subject:To:Cc:References:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Content-Language:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo; b=DyYAgTTTGQN0R0IRhLI8G4NLVa8mR+MgjW5LmJYrDVS1s2RSlFq45OCoVUvNZlL/Sk3uo9cOAuHJ6+wutBfkRAD4UckXBwB88UReDykSSeTqPbN84D+yO/SFmu7nuOghNy9Ntziv7oOfloUGrooEqa9T4gfnPcSRrnslxUpJxFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TFl8j1fqQz4f3lfJ
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:12:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5A8E31A06DE
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:12:27 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgAn+BD4eqhl2cGqBA--.2885S2;
	Thu, 18 Jan 2024 09:12:27 +0800 (CST)
Subject: Re: [PATCH bpf v5 1/2] libbpf: Apply map_set_def_max_entries() for
 inner_maps on creation
To: Andrey Grafin <conquistador@yandex-team.ru>, bpf@vger.kernel.org
Cc: andrii@kernel.org
References: <20240117130619.9403-1-conquistador@yandex-team.ru>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <5e2b44ad-63eb-364b-9bee-65617f17a51c@huaweicloud.com>
Date: Thu, 18 Jan 2024 09:12:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240117130619.9403-1-conquistador@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgAn+BD4eqhl2cGqBA--.2885S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUU5i7kC6x804xWl14x267AKxVWUJVW8JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
	r21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUU
	U==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 1/17/2024 9:06 PM, Andrey Grafin wrote:
> This patch allows to auto create BPF_MAP_TYPE_ARRAY_OF_MAPS and
> BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY
> by bpf_object__load().
>
> Previous behaviour created a zero filled btf_map_def for inner maps and
> tried to use it for a map creation but the linux kernel forbids to create
> a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.
>
> Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
> Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>

Acked-by: Hou Tao <houtao1@huawei.com>


