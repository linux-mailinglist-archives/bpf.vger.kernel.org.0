Return-Path: <bpf+bounces-32577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ADB9100EF
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C911C20E5E
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47821AAE02;
	Thu, 20 Jun 2024 09:58:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753331A8C22;
	Thu, 20 Jun 2024 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877498; cv=none; b=NaKoCSvbu5+Rgl+bKJ4AhxpVPMa+DKbFEAgd8sCplkiaPLj4zVAOHWg0y1wzq+wq5n1c4ZUNY7WOpHiiMOGNBdvdjoFMZrRqCueFt7L76PSpdHhiS19QRwovQcPNPqcJWygEPEOS6pUtcSSI7scRRfTSql8rmXREgX1ox35bLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877498; c=relaxed/simple;
	bh=zVSE71SnLH+I9UT5DlKC4EFoBihe0WH0r9wpgS4IYtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uUDXGRQZMKQFi7F5KE24DcfPu3kqRQCqIBbRAqikXAVPDCb1qdBXxyNHTZ6VhpggSisbIJJBZXfshfZymXKMf2Fu3LJBSsqDPnlLj/dehU7L4nw00YOHDHBVkdQvKf5SHPkJswqTyu5jzmR2ylA+vlJHuRJyLBUFjmcykm+N+UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W4bRs66cvz2CkQV;
	Thu, 20 Jun 2024 17:54:17 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E1871A016C;
	Thu, 20 Jun 2024 17:58:12 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 17:58:11 +0800
Message-ID: <f0678e11-dd59-2e9b-56d5-cb28a20ffac7@huawei.com>
Date: Thu, 20 Jun 2024 17:58:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH bpf-next] uprobes: Fix the xol slots reserved for
 uretprobe trampoline
To: Oleg Nesterov <oleg@redhat.com>
CC: <jolsa@kernel.org>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<nathan@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<mark.rutland@arm.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240619013411.756995-1-liaochang1@huawei.com>
 <20240619143852.GA24240@redhat.com>
 <7cfa9f1f-d9ce-b6bb-3fe0-687fae9c77c4@huawei.com>
 <20240620083602.GB30070@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240620083602.GB30070@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/6/20 16:36, Oleg Nesterov 写道:
> On 06/20, Liao, Chang wrote:
>>
>> However, when i asm porting uretprobe trampoline to arm64
>> to explore its benefits on that architecture, i discovered the problem that
>> single slot is not large enought for trampoline code.
> 
> Ah, but then I'd suggest to make the changelog more clear. It looks as
> if the problem was introduced by the patch from Jiri. Note that we was
> confused as well ;)

Perhaps i should use 'RFC' in the subject line, instead of 'PATCH'?

> 
> And,
> 
> 	+	/* Reserve enough slots for the uretprobe trampoline */
> 	+	for (slot_nr = 0;
> 	+	     slot_nr < max((insns_size / UPROBE_XOL_SLOT_BYTES), 1);
> 	+	     slot_nr++)
> 
> this doesn't look right. Just suppose that insns_size = UPROBE_XOL_SLOT_BYTES + 1.
> I'd suggest DIV_ROUND_UP(insns_size, UPROBE_XOL_SLOT_BYTES).

Oh, what a stupid mistake to me. thanks for pointing that out.

> 
> And perhaps it would be better to send this change along with
> uretprobe_trampoline_for_arm64 ?

Sure, i would send them out in next revision.


> 
> Oleg.
> 

-- 
BR
Liao, Chang

