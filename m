Return-Path: <bpf+bounces-37947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB28795CD5F
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 15:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DACB1F22AD4
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 13:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E7C188010;
	Fri, 23 Aug 2024 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="A3fZgpMo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="CfjLNQfk"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout35.security-mail.net (smtpout35.security-mail.net [85.31.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F918660F
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418606; cv=fail; b=I4DIW4wJaMhLrXfWYJUUlubvVp8u2Fx8N895zQiE5HvlftBSI0tFhDAY0Urchbnu1lUHHrTQ5FlNvW9GgQdaidU3qJRTBkKq83Qi0f60WDn/JRpUsaiCDQT9m9F27QMzemVHR1UEPYtUSxPGQQh8A12o3TSX5CcxrUmDnTHxUSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418606; c=relaxed/simple;
	bh=d54QEFwMi8MrhPUnpgOnoZDMXuP50fcC7UxoSmp+Z7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kx9hrFdjvyHOunOECzU5O2hfgF0G72LnEW+nc62UdSYXdOAY4gogvmPag0Za2os22+LqrW4V33OEreDH7DWin245+CcOpJIUVR4Io9hAqIallAtezTJ/IB9LmQ0B7eXfvZw1glaRGsCFdJKoEv5PypnwF+FVCx+KfzbiiqTFagA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=A3fZgpMo; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=CfjLNQfk reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx305.security-mail.net [127.0.0.1])
	by fx305.security-mail.net (Postfix) with ESMTP id 8EE5530EC8C
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 15:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1724418448;
	bh=d54QEFwMi8MrhPUnpgOnoZDMXuP50fcC7UxoSmp+Z7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A3fZgpMoaEijoSB0NiVRw/A7eFp4xk01gTIj5P1QP0vKhMAbmOudzraApuDhDImU7
	 RmA4SGv29dQ5t1gp9Qn5A2nupm2FhluCw9KcETAIr7M6q/zGjqyqTmcvaZLo7/NFB8
	 MZfza8WDKD2nZSwpqJDbP8y8Jd5xWjLOKk9igkMY=
Received: from fx305 (fx305.security-mail.net [127.0.0.1]) by
 fx305.security-mail.net (Postfix) with ESMTP id 5F14730EC70; Fri, 23 Aug
 2024 15:07:28 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012055.outbound.protection.outlook.com
 [40.93.76.55]) by fx305.security-mail.net (Postfix) with ESMTPS id
 AEDFE30EB22; Fri, 23 Aug 2024 15:07:27 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PR0P264MB1660.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:166::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 13:07:26 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7897.014; Fri, 23 Aug
 2024 13:07:26 +0000
X-Secumail-id: <b852.66c8898f.ad4a2.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZNT2ZFu+YBPV7FSUIrO5WLxB5qpgwlio7jQZNxQwHIiqrRRkvLuX1/gSZSi+V1mkpDfnRf7JL+dUqDrogwFLxhqF4XVH+uTm4zXY/XvJ2z+XlpxHxHpJI1h8M3BT0TRXSiEiDVCl+kNsfdlRav/6SFB19nCTZ7c3ELuKdFWU1F566d41UoboqwQekzRdiSO5Cm7KZcT7XlccKbNA9Xfr2SQvSv2E84todSYI6NPT3qYFNAFsimAc2YeFWHg8/Hd/GHBwQc+/RcOj5/3Hy48PCXkz32NzWapqTwv1nI5VpxdE9dtcpgFPib/0LU6SQ2xiNF3OpHj+hHXoI7dNg5Wog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3d1zCg9mRTmTg419Q/7OqAYndqtBVKrCO5xjrLfAvB4=;
 b=ysPpJ/BSrqKag7CqltK6Z/Nlki15aNS7RBu3dx+fra/DEi6AXF8tNSgvnPsIF82YS6laB/ym4TUUVyWpHfBQeh53LBBJNTOTGWrERV1UXmxyHWmxpbIBJTT4jrKqfWvxYwVvYB6XYhHVNHeYnEa5y4MnM8AOcOTOlVxiWCvHWQZTyb/Vp4WtiI6jT7sL5zjhFmlm6yZ4wp8/KYTrUq8ePy5yAzCw49X+N2yJWkYJCGYQH86aa8Adhj+9kyLHCZK7kJ0NoV8Coc9GiEL2cwfEFnd3ckzfTcvvAWNjzF8EKDCUCfuUjto0T6yl3bPzzqZqfZkMuF+wRhb7ywOpPPT2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3d1zCg9mRTmTg419Q/7OqAYndqtBVKrCO5xjrLfAvB4=;
 b=CfjLNQfk4UrxLnO9lyko5GDIYIYDNqHPY3TL7WG/b3gy0wb2xn5V1PUnq8txrivkWG9E6aFMeFW55HuSWWPH5UdpnWVWIaPOnxA7qRVnu8dR5nkbdMx0WJUpNbMQPdM9u5fC1yl/Ftrd2UM/X3GM0K4ntuCNyxVj8fs4oaz6Vpexeeuve3FLYkV/8ae/YS8BGhDu/HJ9xkIHS/1yakaGmgeqrDR1O9u6vkL7/LrRMZhT7xYzp0ais4t1l5I+kwhLq2gGmiCHV7gRm3IglHhYU+OVj3zL+jpG0cyU6x84Cfo1ADFpUlS0ZTImOcir1NoKRX3fGfG6d6tsckAd+9XTCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <4ac2f7d0-11f4-4cb9-b0f8-2961caca9c2f@kalrayinc.com>
Date: Fri, 23 Aug 2024 15:07:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 34/37] kvx: Add power controller driver
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Clement Leger <clement@clement-leger.fr>, Louis
 Morhet <lmorhet@kalrayinc.com>, Marius Gligor <mgligor@kalrayinc.com>, Jules
 Maselbas <jmaselbas@zdiv.net>, bpf@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-35-ysionneau@kalrayinc.com>
 <daa59ab0-08d6-4a65-9367-c34bb42b8ad8@kernel.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <daa59ab0-08d6-4a65-9367-c34bb42b8ad8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0055.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::15) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PR0P264MB1660:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e945a5-aab0-418a-50d3-08dcc374889d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: MZe3LJclmILlKVzvPSUcnFyWi/QRtO+ZHFI5fwFDgGJuhLNzN9GGybZ+CXyt4VHIl8HufbaPrGESiDeegAv1HKXzAKf4rVKddwsQdDdq8/W2GGIuXK3jaBPsaSjkPgBxpzlGg0RFe31fM62eXlntrYKLWcxb2t8htJRL/4BggyQ2uMZe4mGUREC5RH6M3vZxBb07bkquv1iFK6ZGz5NG0K4kuE88Fe4T8+zf0MXdbqV0GLIX5wSix8tZuAGOyM0GTJFj2yJZiDk/3nyka+OYiM0SwJO/W7JvNxIZgw/eUDmB73tSF1cfmNZrMuBnZ/icXDk93vl/yBgTK7l+Wxyd1DAYcgnbK7jYCJInDH6KG1B86T9IPproZMLFafPkz/SPt4TV2R2NfRj8lUIdHvNosVznT0hA5ssAFQ7MesN5KXdABVB+eFLiPPV0mCyTlMeI7Gc5reZthxHxQ+nmDaST6XuSv8BrOc3CrN2xocIVaoXytmkYmkCVjN8V63k1abV2LG/U0XbhQGiZXL4iCob63HJaHyt+C4Rg7ydgLsq0lfFAfzhIg6J6hC56w6SDT6q7Auc9JE7cA2V+iV6yvrarJZHzrbKYXvks7dKIcZIZDL+IEB8yJl//kph/lveuBHh6V1ZBZn7UZmqYNhvwmeggrMTiA9N1rrLWo0viN+vPrx4UoApDutBX/G2ozBfQXS6ewJ3i4YSA31940pyr7NBwjSZuZ5J1FpD8Zw3j6O5cN2Kl/R1+hTz8y/+o9xvLN2Qa9zUCFG+PC4W0/uMR10EzxY1RJcsl10DYK5L/Ob2nZsP+Ln3ge5SdMTMPeYbSA4/FeTc9OSh1SwOS/fwjOZBMviqehKWyOcZdBIIYHFoUQ1KYlDmzbpoya7qgQXDx0zvzvBxzwit9pf5eibjkY7NiZV0jpvXSyKmNcJzYol9uTe5DeP2AWs9BG+Pp8bgGMeftT3j
 TvrE7tr6PdPHGSXNfo4/GUL578QOAwo2Ac8Zp7R0t3P8tRWB76Iy1R2PInK1xKabOlFLD5kicsK4hKiTuqiN6KTc0sOYPW7l8ZcBSVcHeV/+AYg146w9dGnqrkVupXQpqdYP+W9FYpqVC8hc8R46OYBKpqkU6wRyN6m3GZksXYUOBJQn11tiy/5ew0sh3rbuu4Z56BFKzCSs92Rs6HiRHKXCY7e8Y6eI7ND9OVaXRJRi8MSNFW7sGUIyUxu6xxH8i+1AkN9aG2YML4vcbDnsE5HMKIJwdYYb9qnNQI+J4rcRNvgbxoUOkzzkk7v0xklcCe4me08ClLOHgOdG2Rhw8NP01UXaoI5ZUGxEh46NGQYevNY0CDX53cI6AnGgggDP3fgnUbiM5kSk/98Esvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TJrsGdVW8BNAbKBpBCDUyL9si028GVHIZx47ouC5LKYaqz3awO8C4QiqiyjzjTLW3Zzso+nclXWfeLSN8YF0o8iFUiIYJ49YCVUoye2hfxsRIDPNgjUoO7XvA1LoAg7iC3yHQpFN71kZRHGjSMhqx6RjoBVlvh+X3rzKoyrvxzNHm7sbAQq+TU4ZVLTD2gkAeArY5GmULv2AKMPOf4G30RbWFFMW3HwFbnmGY8OGy3w1iDW1lKcNGEQUuqG8/Ts1l5UPLi2BKacaw/JHos0rI5mdPEmMbSVPF2LM7n3AZFGrFiDVhY82woR5oTCR5acrxos//R92ZFvCLlYuN8/73yxIHPYKjOFsp8fve1bumb9Txia5UKbXltcYPF1kqtuS+RiOh0cL06qnJRfJ8xx+ATYjWiwvo3H5klz9YjBaycVM137EnXl+SbGZS5lNqZY1mT8CCuK04/VA7bi0SKsxV+DCSw952G1YKbOJmrEsFfTl2w5f3ELZD2LMld2XIg9w6bIeF6jGNLkGw/XyuODDVLdU4jQyVyRYrkMFasnk3+ckPIjPd+1733b/mThuQ4AtKkQRnblr+ThETFEst905dSCSnBdXTKuqXccv+moJgciXlVDF48vaeda06wU9Qd7JQxYBpNKYPROMCKFaT+YXN/dGDW949k4P26rpWzrd8lhWXLU+OD/qM0PMVAb4MmX9e++6lVpzH6bvuc13Ka4eYc/XJoEzgmlt7WfvkbNRglT+0cXoN2sp5juea4WmqYmUT6cJ5uNjeEtUpU/xtNTCGz5OoNdiaBg6yRgaGidXsgHuk1qRgMS6fEh5CWRbvz379g2Jkxiq+AaxdWxfwh9lcpXZDanoBXD6M2TwL5Qbq6CkH/uFFlrwDTC/YQWmZYZvwu6gs7vE9Oxcdo4JGMOg1lsK6s0t3bgnu6AcS0YlYfDlt0JOScgjN+4Ky1XEd5wn
 8x6S54i02ABQIkXW+GWmcQJSC1Evu0ieMk0wUvH0lJyoEcS2yR45zIl8oaKjarSYTGsnhkGLLkXSXilwq8NIIPrgn04uh71u5SvJb5olQKG3ixCJzw2E2b27JbH3K94ZNXaZ95Mhh+OZ/+4V0KnjGv2b52C7mtVByGm93oDLAwQfPEmdxDn9Mr40hS5hfsuwoMxJqQBoPnfi3PIGjJF1qBzYRx7xn4MG//v9IjX6bM5k1AfofqiPje32o2yUoqMhKpmd4znnVDqEw1r5dFSyS6qwjNoimm6ywEdwZlKmRGv6/M9u8yPJIhEFibgRPDBi8i9GQRxfIXuxpVZ6Vzt+U11mkWdThPHk2YbkHeDHkLq6XGJ8qLPP3d+wK3vJktxSHyfxZ/KTpBdx7Uki1dnp5K48ONm9GKmcq3ra8UmaLwv4LMP/50skvftzTn2HUt/c3XYPuxUURHBdL84sLO86wKppfeqi/Ij3SN9BanQLVCFm8wjvPVpID7VWum1BQDDbtdSqRSzMz7VNfqUxu6Hyh87KX9P1xEXjeXTS7zUGnZdJ6zEgnG6RnkHmo0OPiTkVf737TVdVPU/6TwBivunYHBS8C1o2L6BIqGq3St7QA8kQuwxSnkTdKwQVD3qhf709JjtWOtID2Cpm90NPPa1txIGVGXeydeXAaa7PRsTMpQD6jw4ROrwa32HwNVYDHOxAKoCCa5FPKAsL5dZXIQqyaA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e945a5-aab0-418a-50d3-08dcc374889d
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:07:25.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRn9FZpdBQHsVT4zZi0qePFi+u4wfLPj1Z9QcfpFe1sIuoy4Ptk+uPYYc27/ggUnNSLUfbdd1dBPVrDRP+jJjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1660
X-ALTERMIMEV2_out: done

Hello Krzysztof,

On 22/07/2024 14:37, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
>> The Power Controller (pwr-ctrl) controls cores reset and wake-up
>> procedure.
>> [...]
>> +
>> +static bool pwr_ctrl_not_initialized = true;
> Do not use inverted meanings.
Ack, I will fix this.
>
>> +
>> +/**
>> + * kvx_pwr_ctrl_cpu_poweron() - Wakeup a cpu
>> + * @cpu: cpu to wakeup
>> + */
>> +int __init kvx_pwr_ctrl_cpu_poweron(unsigned int cpu)
>> +{
>> +	int ret = 0;
>> +
>> +	if (pwr_ctrl_not_initialized) {
>> +		pr_err("KVX power controller not initialized!\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Set PE boot address */
>> +	writeq((unsigned long long)kvx_start,
> Addresses use kernel_ulong_t
Ack, I will fix this.
>
>> +			kvx_pwr_controller.regs + KVX_PWR_CTRL_RESET_PC_OFFSET);
>> +	/* Wake up processor ! */
>> +	writeq(1ULL << cpu,
> That's BIT
Ack, I will fix this and replace with BITULL(cpu).
>
>> +	       kvx_pwr_controller.regs + PWR_CTRL_WUP_SET_OFFSET);
>> +	/* Then clear wakeup to allow processor to sleep */
>> +	writeq(1ULL << cpu,
> BIT
Ack.
>
>> +	       kvx_pwr_controller.regs + PWR_CTRL_WUP_CLEAR_OFFSET);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct smp_operations coolidge_smp_ops __initconst = {
>> +	.smp_boot_secondary = kvx_pwr_ctrl_cpu_poweron,
>> +};
>> +
>> +static int __init kvx_pwr_ctrl_probe(void)
> That's not a probe, please rename to avoid confusion. Or make it a
> proper device driver.

Ok, I will probably rename it kvx_pwr_ctrl_init()

Thanks!

-- 

Yann







