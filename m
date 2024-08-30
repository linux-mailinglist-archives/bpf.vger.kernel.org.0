Return-Path: <bpf+bounces-38500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B928C9654A0
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766D928715D
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8FF4595B;
	Fri, 30 Aug 2024 01:18:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1721F3A8D2
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724980686; cv=none; b=CcuOtSdefODUWjZWRkihB9K5O/ik8+HFOrwXdSKpneR8gHMqKfM3g9OLy+AxovCC+f/X27waKVl75h9vmuycBES3mXfxjDlHTTPpHENgbwLtOqKMsBwLVGUkT2mNQcTcAnBTIk5JKRYI62UQ88kD4t8WMxMjwWvdrJRMAmYSdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724980686; c=relaxed/simple;
	bh=T5khp2IOgxmThgXUNUk7h3/itvLtgWIxI4p/73kVsyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BZ43/FzLqWHCsFTer73Yy/Y0omuK+d4jP85ZtSEzRIcgMSB1GXLhO8cTgIkx+nWamitwWUw5VSsqQBrgm/Se5WAFPbgmrUftL0BopdllHjFw2eUMpLAMJkmxgTRX7piAxkVYNx3LxQ9bB29yYmI2Bap2xnHNLyc3xC2nPS4pj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ww0d82pWNz2DbZm;
	Fri, 30 Aug 2024 09:17:48 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BE5EE140361;
	Fri, 30 Aug 2024 09:18:01 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Aug 2024 09:18:01 +0800
Message-ID: <1fefabf3-3fe1-22cf-dc7c-bed655829330@huawei.com>
Date: Fri, 30 Aug 2024 09:18:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] bpf: Use sockfd_put() helper
Content-Language: en-US
To: Stanislav Fomichev <sdf@fomichev.me>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<haoluo@google.com>, <jolsa@kernel.org>, <bpf@vger.kernel.org>
References: <20240829085040.156043-1-ruanjinjie@huawei.com>
 <ZtDk9juU30-rIOQ_@mini-arch>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZtDk9juU30-rIOQ_@mini-arch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/30 5:15, Stanislav Fomichev wrote:
> On 08/29, Jinjie Ruan wrote:
>> Replace fput() with sockfd_put() in bpf_fd_reuseport_array_update_elem().
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Can you resend with a proper [PATCH bpf-next] tag? 

Sure.

> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

