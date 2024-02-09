Return-Path: <bpf+bounces-21651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C6A84FDA0
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 21:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF28287F72
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C25672;
	Fri,  9 Feb 2024 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTKmemSa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F11C10;
	Fri,  9 Feb 2024 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510842; cv=none; b=G9SLpSLuoLbBUZdS22UnLKUaIy6s/j3deQHkB7966XPQQrSDl04wx+0DMVUxyxF6IJoQn/HLwAIgpesYIbOzu4ETy6tZBcQBDrDacR0eXzRsbr7zJcJZzBqZpCZE5eOuKsu3v78WeR/JeH24eVPEUyNpz4NWn2w/cxntxgwQgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510842; c=relaxed/simple;
	bh=1ogBZFQd6sL61caG1BlkDBPnoyUz7gjPoCogwYbksng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjnEVACdHXvvsXrOLXeYTlwN6DGNa7vCPSUUTy2fTwZ+xNUYG3zpMCGf8K8GESO+YGvEblj8sx9XGDhghTqGiEaXxDQa0UVdsmwJlB0zv1M6yiMdZgpjXmPx3s2OxeXlCzb+FsG/5Mc23pWGzvRRXikSWxiXZroH7UuvrIjeMBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTKmemSa; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21a01c100a3so488053fac.1;
        Fri, 09 Feb 2024 12:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707510840; x=1708115640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iZqjoegvw+SzrDkzyeo9ooIPTOeMlg28K29K/qT3XeI=;
        b=TTKmemSa2V1d350vvC0t0odzUr6yop9PEP9R6c4wzrg/BAtKn+RGOsm7sLcHzLWFHr
         XtmTTyRdQ3Rp27ktViku5ifNmqY9Ma2BsIgRxij7VUxIDwXSH0gZ4IvBML+TlxCk96bq
         e9vCQ94wDQWAmgfaU/p5FDNkY0LwDm4FwRFijcEArFaylXm6nNfYFl9Ikma8zu4CK59T
         rCaQnPiPrR2HPGMRvhUtFMjYB4pYjIfZijRgRxliuK/rn5L2qOkXsxEiBoFaf9C6DFUl
         ICsqpZnebSsvU2QNbJ1wHO7pREIExguk1M5TWDBnewXd502Sj4Ui2czVCyVnIE2KEKaZ
         OTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510840; x=1708115640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iZqjoegvw+SzrDkzyeo9ooIPTOeMlg28K29K/qT3XeI=;
        b=fv1/VxK7Ku6SgCpqD3efGr8u1amer7h+ii+UQTc2xy4KyGKCXte+CY63/hzgz/lNqO
         OCbK6amHMr5NoLoaj7XdLM4aGHspKdrWdUZ7xe004234QyxmB9+fmViEPOr733i5J5HU
         h81zW0gUwuDVJ+oHXWPNH8MPdlUkuAx3tFhcPWJMZ9NkOy+1pHwxXrzC6mynPBiHcsmF
         lviJu7LtO/OfjsfmCkplOLy5fNlKtZk8RETbGLA53QxuQqNfHDziDgaAhfrrfAAp449y
         cDfgnYvjsophFME+Cin7Cwc0Om3gbQQCmo0sP14RWsV2OF5Pk42Y6323rc3ZGAPdC7L+
         I8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVR9tEA/j6jR/K1EaL29jAP2iMEQtFYmogOXhYeNSBbDd1H9t+qzoJZKXPiCPWppKyewCBwMC5+tfrncLosoNA8X4ZvBwVC3uFT2dQM
X-Gm-Message-State: AOJu0Yy8qc2d9ua8MGr1wYB2nZnLcU7wfQiMn+GY25CAfB/eYko1lcOn
	GEs6eerddmodDuWjqo3NHMr6+7wYXGTmkBrS2vAkAG4JSZ467LSK
X-Google-Smtp-Source: AGHT+IH+JtzVLPK2oDa5ykRgpy6tbjR/0HethViNZhIDO8ORD95I76PCvVDjC4dkJo3F7R777iZL4g==
X-Received: by 2002:a05:6870:d38d:b0:219:7f2b:1f2c with SMTP id k13-20020a056870d38d00b002197f2b1f2cmr372613oag.37.1707510840246;
        Fri, 09 Feb 2024 12:34:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+nu5IRiZnmLmV1wfOgutttMwrXqQ0jMoIa/VTE+Yy+JYzU3HYFz1h48ngH0C406qP75sCzUomM9CylimiJv7L8bkSeUB4xgQ76fBc7fpfQsNtht4mo8qdBmYNX+p56Ti5OenMTBvrlocBTuuVcbDVUZab1eK2
Received: from ?IPV6:2600:1700:6cf8:1240:f93c:6396:3149:ee35? ([2600:1700:6cf8:1240:f93c:6396:3149:ee35])
        by smtp.gmail.com with ESMTPSA id b23-20020ac844d7000000b0042be6d99d22sm983327qto.59.2024.02.09.12.33.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 12:33:59 -0800 (PST)
Message-ID: <fe9f9fa2-8308-422f-b47f-951b0d7875a4@gmail.com>
Date: Fri, 9 Feb 2024 12:33:58 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: remove check before __cgroup_bpf_run_filter_skb
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>, Oliver Crumrine <ozlinuxc@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, thinker.li@gmail.com
References: <ngc7klapduckb67tsymb3blu2wlmdsjo4pa4gbaivgxezbwzxp@v7akqu7gbwl4>
 <ZcV1GgitdBUIcKJT@google.com>
 <3htegzrugq4xwlizizsaku6g2pzwhndcnxxxmji4fvblisiuro@icvcsa3mky3w>
 <ZcZ2ObDxRwZ-hKLb@google.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZcZ2ObDxRwZ-hKLb@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/9/24 11:00, Stanislav Fomichev wrote:
> On 02/08, Oliver Crumrine wrote:
>> On Thu, Feb 08, 2024 at 04:43:06PM -0800, Stanislav Fomichev wrote:
>>> The check is here to make sure we only run this hook on non-req sockets.
>>> Dropping it would mean we'd be running the hook on the listeners
>>> instead. I don't think we want that.
>>
>> You are correct that we don't want to run the code on listeners. However
>> the check for that is in the function this macro calls,
>> __cgroup_bpf_run_filter_skb (the check is on line 1367 of
>> kernel/bpf/cgroup.c, for 6.8.0-rc3). The check doesn't need to be done
>> twice, so it can be removed in this macro.
> 
> Maybe we should instead remove "(!sk || !sk_fullsock(sk))" check from
> __cgroup_bpf_run_filter_skb? BPF_CGROUP_RUN_PROG_INET_EGRESS makes
> care of all those corner conditions. We just need to add those checks to
> BPF_CGROUP_RUN_PROG_INET_INGRESS.
> 
> Let me also CC Kui-Feng, he was touching this part recently in commit
> 223f5f79f2ce ("bpf, net: Check skb ownership against full socket.").
> 

Adding those checks in BPF_CGROUP_RUN_PROG_INET_INGRESS makes sense
to me if the point here is saving CPU cycles during runtime.

