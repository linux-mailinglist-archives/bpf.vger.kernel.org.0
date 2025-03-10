Return-Path: <bpf+bounces-53706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFECA58A7B
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 03:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F47A12F8
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 02:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AD016F858;
	Mon, 10 Mar 2025 02:32:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290F5D477
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 02:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573946; cv=none; b=VF2wvoZhVLIGel0hd7LhKXcHBCDCX+X9/QOA6Z9lSdsY/u90RNbT7YE2POlTDwf3C9oDHgQaDm8EFm8ZTLhefiHBxrXrKsTA7C8OboBWUz1RzMTpkmzPNQ+YRcr2njxXoOAraKN/kbpwW+8JovFwa9502iY6/xDKLiLhG344uxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573946; c=relaxed/simple;
	bh=cwsV6gnts7ybx9O5Put7TXPegm+FekJnit+DpttuDXk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dAeD62YQxXR5iZg0bFKPrGs0Imw5O7H0THxBPj28Fjv0ySJaG0bizsZSe1Sd95oOkDJePmpzGzSQM6HjHrxqQH4Zs5OGm1MdoWYHIZsr/eK0kwb6k1yURQxSjJ4fYUy/249s/6hyf23SFn8KolMDH9k31kKrg4J4g7Y4YhfeObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZB1B35TpSz4f3lgM
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 10:31:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 850FA1A1370
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 10:32:19 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgA3nX0xT85n94veFw--.9765S2;
	Mon, 10 Mar 2025 10:32:19 +0800 (CST)
Subject: Re: [PATCH v7 2/4] selftests: bpf: add bpf_cpumask_populate selftests
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, tj@kernel.org, memxor@gmail.com
References: <20250309230427.26603-1-emil@etsalapatis.com>
 <20250309230427.26603-3-emil@etsalapatis.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <80669a7f-1f00-b361-8ff3-77053d69293a@huaweicloud.com>
Date: Mon, 10 Mar 2025 10:32:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250309230427.26603-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgA3nX0xT85n94veFw--.9765S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
	r21l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 3/10/2025 7:04 AM, Emil Tsalapatis wrote:
> Add selftests for the bpf_cpumask_populate helper that sets a
> bpf_cpumask to a bit pattern provided by a BPF program.
>
> Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Acked-by: Hou Tao <houtao1@huawei.com>


