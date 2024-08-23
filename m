Return-Path: <bpf+bounces-37958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1523A95D051
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 16:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C4D1C21D57
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7191885B8;
	Fri, 23 Aug 2024 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="Bo349JDv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="eK6AIFQc"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout148.security-mail.net (smtpout148.security-mail.net [85.31.212.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3E1885B6
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.148
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424391; cv=fail; b=F1huKis4StTO758w9IHSjwSRUa/e4nBLufbdWzaNquPdUMqIo77xsjDKf73COzfBorQDRhekESn9NwTW5/JSOZHJRTBwbCezVypDdEKVaTFJLzteYfavvUH01xpg3z4XBNL0fUfSa+imtV/madwldsErvlfSVWhjy6PfuLjwwkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424391; c=relaxed/simple;
	bh=MA4FpcITsarkJKHGv5XpnJVVHGRj7ESr2femTqJuJcE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IkpB/w9AOC8m7WZbyySmbQgncQq2ltd9DRIJIuuhE89T75TnDuJ9YN3ZawP6bOfryKcPg+9GoRqxHzGDP5VZ3+7EVOZ3wfpPeQP1EGH3/LCvmqLkYwtbf0OlHuIyn1FzTSI4QLgx3RvAiQ2+9fRC2qv2IcFt2Gth53vDBxPOAXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=Bo349JDv; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=eK6AIFQc reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx408.security-mail.net [127.0.0.1])
	by fx408.security-mail.net (Postfix) with ESMTP id 1204C322C07
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 16:46:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1724424386;
	bh=MA4FpcITsarkJKHGv5XpnJVVHGRj7ESr2femTqJuJcE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Bo349JDvbwXDQ1Hqzz9j3rY3gMJYVG+jBD9734aYyDLyB2ckY+IGDPNtWc5rCl2lE
	 rbYqDNWSXTb/q25czef2TJrlEVwN5vKfnM3mPBgZU0Me1ockSFv8ozO40tmSuzJjm5
	 k4w8iLVPpfp2NVfP3eujuXp4zlixJ6KIi8pNScBY=
Received: from fx408 (fx408.security-mail.net [127.0.0.1]) by
 fx408.security-mail.net (Postfix) with ESMTP id D6D4C322BEC; Fri, 23 Aug
 2024 16:46:25 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011027.outbound.protection.outlook.com
 [40.93.76.27]) by fx408.security-mail.net (Postfix) with ESMTPS id
 5A18B322BE6; Fri, 23 Aug 2024 16:46:25 +0200 (CEST)
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:14b::6)
 by PASP264MB5124.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:43d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 14:46:23 +0000
Received: from PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39]) by PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7a6f:1976:3bf3:aa39%4]) with mapi id 15.20.7897.014; Fri, 23 Aug
 2024 14:46:23 +0000
X-Secumail-id: <97d9.66c8a0c1.57a35.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4cihW2hPzYzGneD/2EJJv+0xbAAJiJL0llcDYUfIaofrYZApNJLmJCT8/N+Dts6meTmrH8QnfCBeRA2Nmx5tWWnEaFylfP0SmA1J6TsxXlcCz5Kayzeb0V+VRhJkm3xKxh31hBo/xYIGQGIYDaltNe7ZnV9IkpDinrTf5yF1TcN9hUTExTa7xLEl9h+VA9dzsjsemkKAaPFqvL1f5Ef5UapNEWLSJLJY76XJxPLQ14AIYxr+kpTbAhCXftruj22dKGqQqlXjRBoxBNAllsZfjS3LhYTvE2RGcc8JTRmBPTEqtMU7p9R5odJpK1FmX+gnDa/psTd1zd/2R5X3smeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4u3jbhOPEUFG/XttDhtCtgVYo2CQxezdFYBa/1xd4Y8=;
 b=YySducs9KKfLPDZ0RbrWYpvGeyY1nezwdkv+c7pZcPEEbTAzTlhazLz2eFIzVZKK2zch1WIDPlicyF0wGeSEnKqWhjhxhaDAqEnmDW+1aeMa6DhHqSLbYRpjn7snn5fNIk/MLxh38m/oHSqCWwRPp/+c1OipFQdqmO8vL7LTbxT0f5unLoQlV6RD9GK2QzpatcMcqY1uyUN65NF0BfKH/ucDO12rlzW7W/2ghZvf4Hwnb8C09odJ8Gvj+bj9vWwaZTLgA714nik0VZ9BeaeHsJ/znCva7/BAtJb63D/GGDqAYchesU14DWTVyYDAckqWNBE9jZ7uv7H6G71QmLq8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4u3jbhOPEUFG/XttDhtCtgVYo2CQxezdFYBa/1xd4Y8=;
 b=eK6AIFQchd8MHok5JXVIjBWw5nhceNC9f4d8wTjbsjYs5NwoD/0+uhVHzG+BFRQmmp/rAwD92cs4HJM9qST1VueLKH++Eqpvf4f0LFy3TffLVGSclbVEz5sOgHKN7LhjgMfhZilsGtaoNlR8Pa5hwzfujnJzmq90NZaqLnsMpDlKUo+iKzLjxnrvPiv/gdPPPHhBUWQkIasgnZZQ6UPXyNa41R/eJ/dtCpymAv4nhLhQdYKnKTwBeNkzWq3Xath0jvk3i7zVjg93uUgAKfxrWeK7GGeD9Wl5uTC+BbLBv0lYHJgH9hpuwbmLBzlIdpHCxvlel2WC6qltTSnK6gMobA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
Message-ID: <42e7d388-a4c8-42f9-bf2f-001871a7d948@kalrayinc.com>
Date: Fri, 23 Aug 2024 16:46:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 35/37] kvx: Add IPI driver
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Clement Leger <clement@clement-leger.fr>, Guillaume
 Thouvenin <thouveng@gmail.com>, Luc Michel <luc@lmichel.fr>, Jules Maselbas
 <jmaselbas@zdiv.net>, bpf@vger.kernel.org
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-36-ysionneau@kalrayinc.com>
 <cbd74fa5-d4ad-4ed0-a680-6ff5e3b8ff84@kernel.org>
Content-Language: en-us, fr
From: Yann Sionneau <ysionneau@kalrayinc.com>
In-Reply-To: <cbd74fa5-d4ad-4ed0-a680-6ff5e3b8ff84@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0050.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::10) To PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:14b::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB3481:EE_|PASP264MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b53bea-47b8-4f4b-ebdc-08dcc3825b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: tUmcaDXdeE031X2N5FAMvl/a9asuqDrTr2+gZRcphDhjrW9TYUl3kPAqg1ob8eHfWDipOGw/S/EdFnsf0E5C7CsRHNChf3Iy+ZIHHCHmafs/ghTGkoynbn8asmnc57UWCPzqbLTehi1kOyB0q90JPvv5z+wLVWkBKlofiaX4CwMCS59UbkNf9cNp8t4zq/yk2Bj1lLTQbwjt2Nnq0TCGyz8osDac2ICo0RrFAxedJNGbPhCVaS84fj3MxbQ8teV7Zqbp9++6qjwaMTq71T1lXqVha0+GSlroBexvjQYldHf9V0IBv2VMelUFLZNhN4BjXHLTaRhZXjv/z3Imobyhpw3wBqwQdDlnIyZLlHNy1m/NcNcZG6Ve4WOYqSsFM2gbesa1X5alYVUGPdXP3wCnRPp88eyaXmOZnij7sLCP0CP/5aO/DKHiVd79r7jnf31j08RKYmKs6vmNU2JXcPA4jqtuz9XOjnlfIzqKH91LWWcwLl+1FhR/3TIGkxf+fFt3kHleefCBAeMgpHzZxRiwLs7izUCrdfc9PvjVBU1Zq+nlIfaTruFONB5EtyxEwbnEsinuO0XmN8KaLBD80GxrUclp6sOQ+13SCCL19SKAAxJwg+iQjmWB7LZDEZMeOWD5N6Gn2LyjKG40X/pS97Xcn5gXFtelPYRR0E71cJRBsVUD9sYYT/xpuqFcV/TEEjOmueMURpJVmxfsa1blCAD9/1+EaGhB+rf0nFQrgWj4nvYk+6ahHuei4A1EBioeHPW3Pjz2n6j/1JiWSDEP+LnmB+zesXAgUKJrtIsQwPWrskf2m3H1HgWxOwd1s7xbNk/uxNEJWgiqJWoMJyx2iCZkUrLhZfZhSJCq5Xd7TwSUVb4M7Hhj70RLmYTx6j310ahVrN6UvdCA7DqsvRDvjk1K70Udb50zANtvSl/cXeJV5Z0arAHiJTvM3vEr8kOeEewoNXK
 1ztk+4DbrZodzqHFOP+T33fhchAGWzCrxuFncJMGaWdAFpUr0Hf6Q6HshFaB8skQX5rH5ljGRa0qJWxolyT+DC5eD/YiB5CWKc4Mfxk7JFrG0DMhi0p4lywxKYWapG3wKrs1dhDiljsxUJ8TecXU5i32+EH681Bya0qSJgLOjS6QXqyVIT1VDsHU1RPZm/T8maE/gDi/qGLo9iYUetFLbnRK1g0kVPYE+b8HeqL61AbkxGHHrwXVZ1FCBDzFWfEExElH1ppRU/LoMDbA/0uzbOgLG0EXv4kk5b4TIUWfWCkZLVIN7Ws3zljb2A355edDRPC6fCFPJtCraSOumkfU/2IZHKVTvQzsNxUoSeRIx4EJkt4kbAsSNIZMaz6u8TQuehJvcKjT7/uMkZAueWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BwY5FePfCpVY7sYbZG94+n1o+07Nv5o2hUlXHOh+rVZX+ZiLGff3a2ORXxNAuy4HTJrVzWqc9oBkXqFmqmf1qDFfDW3AqlVSiFbQybVDAzMWYcO4fpLiGGmfiWgGq4evJHQDm7YDtEks+sZPVR6Xm1YTFPZ4nmejqsBTY4I0TZfebyTeYESWQWYsoW8lnV5n/0M1uoPIXC2o7kN/K4S7HsRDzv9tTLiPPVKox6ZQ3hwVDIQp/SCRKwyyamOeukbYJer9fMrsuF7VsDLBl4MPliiuRoTvrbElZ/GAbAN9VvMymPwAwYa3q8LIHZDP9G0pG4k9vMlzR2uZIOSgHiLLkL1DoID9MhSi5jBvinbKulvhDmPH0lJvKc4+Zm4wdly9jZhQncWXxw+0GNy4mX/yNEffP8RieaTyz/nyqeSXbOZGeiVmfEUj5H6FusE0E2U+WR+gPAQO/w37CMw6EnT7XlX66D8/Molt25SZ9adHyXyIpluFmxZPrW1l7WlO6qeVLLNRlInR6qvZNGc1Bm3rjWGDyLO48vNXbPFCZaGzchOXD2mMJWtOUfNWCkGQEdA+v9opr/nNDuOfnNhBSYtpWAemz/515PkMeNENwBXgkhZOmY9hTli3c4gQjXSzm8hPmmfpzEdTYeChKIc6oaUC1h9pU3w0PZyc/kAJop4X4rhwIP/SL9QiJtHuGf5cK0MzU2CImwYrzBglrW2obl2HlWmDTkmpw8enHpkOQtzQvds3YgdFM0qwpl2BUkBM5MuPqn4fpHSvEAXrARwRzJNdEVC6PsnCxTY0WUgFss23HloUj8wRRSPIrbIKXx+9dfNANerL42jXhTMbR4ZUZoCLip01exg+bv72pOVrC40V2rWYY2bSW2dnPG8oKcZf0F3Hwx4nX/yHLY7eSO20s4bd1hpO/Jj4SZz3hgxLpUS7nIvpWTXP8kjgr5Nk62cyDFjg
 rQ7AjG+4UvkLy5tGAr6JBm1izzEoqQQnVYqe3Mffwj+jLmeJaXiYvzZ7qS8JbYu2XgG6mb7nyJUgIym3l+SneHZyOZZIXPv9iSQgAqyuALdDWNusNAeqbpqFhabsgtloGmkHwe3dinswRqVte8sqmUMe09qKdZQ0mRx2S5Uen6NWys90lOBykRrKfeDsfyU7E/0KdjaQ8qAWtacpaHs3nLXrBHgbhIFaVplMWkJtvQlIWF9FhGuJrRrJ7MgjYXiKVC/ZU7sfMLU6khPT8pp6LYVXP2qZsF2uzR4h0Q3oexFaheuyUlaQvA09ToViXpdOugdNwWTiIW5YnuIsGxqQQcwxN9aye4LxLD6RaRPenCJeZVCjQoTpYV1o2qwICXLVegyuc/oog99ZYAqL39npKrN+xiSfTn7IFn5txQDab2XCJBd4KmB+cUhQ8M9bl7TD9LfA85sTpwKJPosb2dVD+evbrQLIjdToYFr95OR+HdwQ0QpBU9ZlMVbaHpulL3gKrN3yZSiT4/PTcPk73fSxj8gFvRDFdXTqhexzvJ1BJS9Ov9PtSI/QLYhKPHAfFtzaEu4VpCq+okUTUbRfNP9aAa0TzLuC0QJ1kT71TbMXEdF/AL0/CcZLsexskZ7cEA6ldJdxXLQkYsxF5Q6+0TMvaRIzx6DXtcdti8YCJ8FlsQ813Qkx6U9WdaSIXO/NiYH4snvGnpzksRXBr4ChZ9/QmA==
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b53bea-47b8-4f4b-ebdc-08dcc3825b52
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB3481.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:46:23.2896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rURPureeU5fDP13H0WQ6ikgcIcKzQT5ViMics9v0d+MfkxhlNTeI0NYJG60FIxlFR98Sf3aNKd+fAr/i7ggqqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PASP264MB5124
X-ALTERMIMEV2_out: done

Hello Krzysztof,

On 22/07/2024 14:39, Krzysztof Kozlowski wrote:
> On 22/07/2024 11:41, ysionneau@kalrayinc.com wrote:
>> From: Yann Sionneau <ysionneau@kalrayinc.com>
>>
>> [...]
>> +
>> +int __init kvx_ipi_ctrl_init(struct device_node *node,
>> +			     struct device_node *parent)
>> +{
>> +	int ret;
>> +	unsigned int ipi_irq;
>> +	void __iomem *ipi_base;
>> +
>> +	BUG_ON(!node);
> Fix your code instead.

I am not sure I understand your comment here, I don't have the control over what the kernel passes to my driver, do I?

On the other hand, "node" being the node that matches the compatible, maybe it can never be NULL, is that what you're saying?

After doing some archeology in our old code base it seems indeed this line is an artefact of this previous code snippet:

```

np = of_find_compatible_node(NULL, NULL, "kalray,coolidge-ipi-ctrl");
BUG_ON(!np);

```

Now that this is a real driver declared via IRQCHIP_DECLARE(), I guess that this check isn't needed anymore.

>
>> +
>> +	ipi_base = of_iomap(node, 0);
>> +	BUG_ON(!ipi_base);
> No, handle it by returning.
Ack
>
>> +
>> +	kvx_ipi_controller.regs = ipi_base;
>> +
>> +	/* Init mask for interrupts to PE0 -> PE15 */
>> +	writel(KVX_IPI_CPU_MASK, kvx_ipi_controller.regs + IPI_MASK_OFFSET);
>> +
>> +	ipi_irq = irq_of_parse_and_map(node, 0);
>> +	if (!ipi_irq) {
>> +		pr_err("Failed to parse irq: %d\n", ipi_irq);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = request_percpu_irq(ipi_irq, ipi_irq_handler,
>> +						"kvx_ipi", &kvx_ipi_controller);
>> +	if (ret) {
>> +		pr_err("can't register interrupt %d (%d)\n",
>> +						ipi_irq, ret);
>> +		return ret;
>> +	}
>> +	kvx_ipi_controller.ipi_irq = ipi_irq;
>> +
>> +	ret = cpuhp_setup_state(CPUHP_AP_IRQ_KVX_STARTING,
>> +				"kvx/ipi:online",
>> +				kvx_ipi_starting_cpu,
>> +				kvx_ipi_dying_cpu);
>> +	if (ret < 0) {
>> +		pr_err("Failed to setup hotplug state");
>> +		return ret;
>> +	}
>> +
>> +	set_smp_cross_call(kvx_ipi_send);
>> +	pr_info("controller probed\n");
> Drop this simple probe successes. This is not the way to trace system
> bootup. Keep only reasonable amount, not every driver printing that its
> initcall started.
Ack.

Thanks for the review!

Regards,

-- 

Yann






