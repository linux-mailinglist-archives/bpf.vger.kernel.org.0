Return-Path: <bpf+bounces-79454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD332D3AB90
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4D7F30511BA
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E337999D;
	Mon, 19 Jan 2026 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GqVrsFLn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED07278753
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832437; cv=none; b=q8S1I9cXsEkb7Dt97/hu07ercJsPraWDGl+izaXw7Yy5Swe0goCBCd6TwsQ5ktDxaxoYZ4morNqY3iBwVG7gX7gHz1eOxxp8H5uBphXTSEM5o2O4Wp5k75P7FPdQftQSTPELp4v1tqrDtHPjnrQfAtwDTU/rQpS2zPpQzbNhU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832437; c=relaxed/simple;
	bh=h7SIbPvUem6CMqCr2nLh5sUw9HLI7B6iZKHQUa+0I+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACaHbpnwF/T3Ou5MaQz8p66nncyXb5ftdkl/tSUWrdJzg920qq7irumd4G8Fc/lIuIKhFZ1k1nBy9NFUXxNQehmFf1/IkY85++vrNIrdEGantSkHpTS0fsIICeqJUkJjUOtLX1tOnQlUD6gbNl+hCSO6C8W6sK/OkTsZrHPVvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GqVrsFLn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-480142406b3so21367575e9.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 06:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832434; x=1769437234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wpcw/R03P/c22tZFBiSJ/LY5v4nnS2BeYH/AbU3n8YQ=;
        b=GqVrsFLndGfOnnpR+WlXVCrVdbj3W1TwYCpWMP1EOCYyC7mFANf3KX6K+wsmi1fm8g
         m17NikUADaTxIbR4NrjnK4VrPCKUhAIdNoj8iWjY0JscWGYB68bMXoz+/FACB5KZaw0R
         mI14F1wRB57E3jqTL7+n33YSBy43dKh3q+YwiknNNrYO9ckM8BSQynTLyl38K9qq6Q0e
         e7Afjqz5sh/1R0GvrXeAIaYPcb2DfLQi2uvlM3VyDFrVNG/d7SwxXpausyK67olTEenC
         zOpgymKWRYZFPs/e6/ycdbQ2FVhc+9UEyzv5qnM7b0sGAVOD/ikrMiRL3L4oxeJoPo5T
         ksaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832434; x=1769437234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wpcw/R03P/c22tZFBiSJ/LY5v4nnS2BeYH/AbU3n8YQ=;
        b=CwBL0WSWhOsHf83ao7yX1xHuIeaPzHExoA1M664J/3Co6ZI/ewUk0hrVA+zK+Lu921
         zKCkkK6pXYcplTUUyA4rLwWm/8KliHWJgoG8rD6aSG+spWtg+7tHxubZGLe2X41cB+fN
         upZ+C3A0nzcF7GCZyXiMWw5wNdZWBxsqFqOgTBPePWtEYKqj3xjKMdEI8M0u2qS9eADg
         Ot1vlKxQaouSelYxSS2QHJAITzms8E1qFwg2+PpuIUpZwJ8gcHLHBjJYmm79gHMPCMUI
         gJ60bGTwtFZ/Bm4jrDDPeLjJLIQB9s+NCg3rDnbRz8pFTIK5oR4DcpqM/zet6rfaiweu
         CDfg==
X-Gm-Message-State: AOJu0YxG7+T09VOELc3oGKfas5dh5a6xx0RtuVRsgCOztyuKhoWqmocw
	+t0YzQ0uGiLqmx1ZKP+aD5F3MjpeL1fXkmdKehG49NODsME0xU5R8J/0Umd7WPg7RXc=
X-Gm-Gg: AZuq6aLOYGVrq24UqrDutg8NzucFt8LfTR2fekMnhK9bmMzEtW0iLlS/b1VzY2HSKs1
	UECTxg9cTuODKQsgbD8DXmUebafCmK/4b4YbbuL9aTTSYTN/LIOyzvzT9icGLZKEApR4C4ge8tx
	RuWuwtrZrrbz1te6KwutyMXnlX3pWJHiRC9Pwflmj6QzoRjD8z92TEdG1E1IXSzId+n8HSv3U8Z
	6bBwqR/IQs/+54XmPRXuT5cPEd2BW8QvxFgkAzDfcmpJKUweGGhOksmtVSDQ11FfP7mj0M0augk
	ZNFEXtQ6CQHfYHEAlriZWMFtjBvrwC1EfBRtVtXH1OMYB8KGFRzvjfEYvInNf0prTDOY8KoZoFY
	tOj78h9DJFcwW2yx+JR73sNHQ7+Nd3o2hN8iawx7e+rp5+Sfp0c+B5u2tGoI/o9H24NPIoeQFE6
	UV3I98Ooq28C7OlhOotYYtIQmBUT2JTfUWjNUXoH5i/11D6Px5soKputwjTNQOB6KkElI8zQ==
X-Received: by 2002:a5d:5f49:0:b0:432:dc5c:25cf with SMTP id ffacd0b85a97d-4356998ad56mr14248770f8f.18.1768832433923;
        Mon, 19 Jan 2026 06:20:33 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997ed8bsm23686974f8f.36.2026.01.19.06.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:20:33 -0800 (PST)
Message-ID: <6a236a7c-e8a8-49c1-9407-749b9b6c9f95@blackwall.org>
Date: Mon, 19 Jan 2026 16:20:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 01/16] net: Add queue-create operation
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-2-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:25, Daniel Borkmann wrote:
> Add a ynl netdev family operation called queue-create that creates a
> new queue on a netdevice:
> 
>        name: queue-create
>        attribute-set: queue
>        flags: [admin-perm]
>        do:
>          request:
>            attributes:
>              - ifindex
>              - type
>              - lease
>          reply: &queue-create-op
>            attributes:
>              - id
> 
> This is a generic operation such that it can be extended for various
> use cases in future. Right now it is mandatory to specify ifindex,
> the queue type which is enforced to rx and a lease. The newly created
> queue id is returned to the caller.
> 
> A queue from a virtual device can have a lease which refers to another
> queue from a physical device. This is useful for memory providers
> and AF_XDP operations which take an ifindex and queue id to allow
> applications to bind against virtual devices in containers. The lease
> couples both queues together and allows to proxy the operations from
> a virtual device in a container to the physical device.
> 
> In future, the nested lease attribute can be lifted and made optional
> for other use-cases such as dynamic queue creation for physical
> netdevs. The lack of lease and the specification of the physical
> device as an ifindex will imply that we need a real queue to be
> allocated. Similarly, the queue type enforcement to rx can then be
> lifted as well to support tx.
> 
> An early implementation had only driver-specific integration [0], but
> in order for other virtual devices to reuse, it makes sense to have
> this as a generic API in core net.
> 
> For leasing queues, the virtual netdev must have real_num_rx_queue
> less than num_rx_queues at the time of calling queue-create. The
> queue-type must be rx as only rx queues are supported for leasing
> for now. We also enforce that the queue-create ifindex must point
> to a virtual device, and that the nested lease attribute's ifindex
> must point to a physical device. The nested lease attribute set
> contains a netns-id attribute which is currently only intended for
> dumping as part of the queue-get operation. Also, it is modeled as
> an s32 type similarly as done elsewhere in the stack.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Link: https://bpfconf.ebpf.io/bpfconf2025/bpfconf2025_material/lsfmmbpf_2025_netkit_borkmann.pdf [0]
> ---
>   Documentation/netlink/specs/netdev.yaml | 44 +++++++++++++++++++++++++
>   include/uapi/linux/netdev.h             | 11 +++++++
>   net/core/netdev-genl-gen.c              | 20 +++++++++++
>   net/core/netdev-genl-gen.h              |  2 ++
>   net/core/netdev-genl.c                  |  5 +++
>   tools/include/uapi/linux/netdev.h       | 11 +++++++
>   6 files changed, 93 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


