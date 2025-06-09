Return-Path: <bpf+bounces-60076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 211D5AD2548
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 20:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFB89188C5F4
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071521D3C0;
	Mon,  9 Jun 2025 18:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iI86gj+t"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0511821CA02;
	Mon,  9 Jun 2025 18:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749492104; cv=fail; b=J6sYt0DkX+RWn3cXkPYpIG22Oo8/fC1igJmyY0N8BBoghMujF8lZoZeAeR4PhTn9m6INV02wnhVxCpMYFiM+OTGYKvaVmAPgI/rD1w0YQUA4fMEfvLu9mE3PBFWcCFKHQp6+yRu0YNl/1fJWTUdtfEkbA6szAqc0SLliIsI/xeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749492104; c=relaxed/simple;
	bh=wZq9bw4BwO+DvxW33PWGyz1tKvkyhgV6KkM1qJ2qY2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3ArQ6vVwyqls2i13ibSGjd7a2FWWCwRHKwt0evAE2hWNgQcvBZaiqMtkJhBlSp9wOqyuJCDIQ5o79qRV21cdzyZPDFveh+UfEOPMLL0MYcPehkV2/vCPSm+wi/npJrfkpowT/5bZDZBjntfx4/cyRmqh6/iQCgXSk3nTEQ/DKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iI86gj+t; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2TIhYhLTKXENAW7h15RgKDV9B9cwuUqxvezQ6dZJf/6EAkJbR7zqb079HKPjci6/TIIpCOzvUZLFN9cj4cCaVoqEPOJjavNbL/C9jH8p0UprG5RdtBIrfCzQkC9TW+PGV95fbKWc4XZUu/LOKU5Fc2nKHAFeF7lqsptkROXE+pIF39ENPrWV/xpowCvQvrSjJbYP0AyPzbpeZbx+6tgJ/LV1DIKzMUvu8ocQCUOSPDOzlFBynC4QjabpwA0z7tyKviBNAFCklGYdZNzKL6AtkO+MkMHiFo+tfOE+489orCza2lj3qCQIVVpR3dqPT+yX9n8QLAwK1T6agV6nTCMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRKEI0Pc4Dx937hdKf5CN/csepu/oS1JjnlgcNzeL/c=;
 b=ttmLMVn5ea7UTqDzhAwAd60mo+genI2U8RzGFAKLRAtlyz3V5IhyeUVnjQ8qT/kJMPnHmxz7OuLfhooIhU7CAwT23rsy7unxXBPB/JZKpSR8e846D2Y4GgD0du+AfgqxViOvgCmMls3K/GgnoUvw/22+10iHlIAUbqwMdI/05KndzgIdqxrzp7yrnPfIlslTU82MrXF0k0XqjN1Q7bIK0hye6TJOhSRYSe02d/XB2CXqTz9o0QXzivdurX0FAZO2t48ivGyh79qQ08z7fACM/t5zA7dZeWgpe32TIXiQc3tO7D29bJt1vi6JZAKVpRHe421TCKn+zepfzjrwDYT25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRKEI0Pc4Dx937hdKf5CN/csepu/oS1JjnlgcNzeL/c=;
 b=iI86gj+tFu1aXsF7Ou97y0yIULcdxQGWbU9cS8IchylfdmXMAl3ZRp73W4Wq9IcV7biEmcD39b/FpqCvs6zy9OI8uMN4iiDWhPT/MZMd+aFwGZ2e3KPDGiAx/PdoVGW+YSfzWvQ6ddKH6y1B91MGit9b7i8fN2k+yNFCb4KAPMDJBGEKMRNR9ESwznMqYylwlQJwplPwBXlC2zeuFqECKi+pZ0sHLA7JyV0Mb3cWB9SUcSG9Rts8/WGEoxTBfCJQryhUQ+1ZwldY+dtb+rmFeYGyDGN+RN9Mkx1v3xmBXl3U1CJ4RAgu/ERo32laEb9E7CP+qtUKu/kImqZQ3SX3hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Mon, 9 Jun
 2025 18:01:35 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Mon, 9 Jun 2025
 18:01:35 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>,
	rcu@vger.kernel.org,
	bpf@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH 2/2] rcu: Fix lockup when RCU reader used while IRQ exiting
Date: Mon,  9 Jun 2025 14:01:24 -0400
Message-ID: <20250609180125.2988129-2-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609180125.2988129-1-joelagnelf@nvidia.com>
References: <20250609180125.2988129-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:408:80::49) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 4342669e-ebb2-425b-b213-08dda77faca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KLT/lI6EyK3+IbmIo5vdltJRDTHrDwv7opXJL2NcB0XCgDH5YDHrd5zKuWLe?=
 =?us-ascii?Q?PXzD92kyaOlhhfecGNGvJduoBb2CMblNnbDwF4f5iRbs17QRa1qaJI1dyCto?=
 =?us-ascii?Q?V6K/lvz6FhrqtciZh6ZkkOiAcNLy0cO/CPveFUb1DT1zVhGgl/3djh2K/UAB?=
 =?us-ascii?Q?1CxQDt/bCAZb69sJolbsOyeOac+D5pETAzlaobiOCe9ubRUmSBY4Zz8hcVdX?=
 =?us-ascii?Q?/AUzQ74c5OBuBECeNlzz1g7YfFkhfqg5yltvR5owZeTauz1Tom7XzB+DeW3y?=
 =?us-ascii?Q?Mm837vZ9/vLfFAQyQIYfMZfQnHhowYYkcpKKzd/+c0gef/Wn/HJaZ4CLVTQU?=
 =?us-ascii?Q?jPJIag5JpPkHfqLeRcXbOgj5Ty4sjxxIAYlWIcpKSTGNhrOw7b8hx/RbiKjx?=
 =?us-ascii?Q?ALZerHKsRnvwRlMQH4bNXHVGgZykbAXtBJbNPjSq3OqkWg3OMIsSUh71NTXs?=
 =?us-ascii?Q?5VA7yqE11Drd/vw17F4lx1I8T38FY2CheJR/r9M7wZK1jdO/zjKH1GtmT2jy?=
 =?us-ascii?Q?8UVOlh5ZIwX2BFZsI8Wp1rsVb7/RMrGfeQTWQaJMb8PwAY+yjF9MWCn80zwV?=
 =?us-ascii?Q?z7HOwd7f6GFwiJDoFd1itlYUk6UMUnGNpsGtf05Yglo7MLVGxFAwoHt3EkWU?=
 =?us-ascii?Q?3yUPtFe5e8jrn/ZdWdOfPnmCHdTugudgIiyiuLxMgqOn+nKRwG1zgGgmEEm/?=
 =?us-ascii?Q?g76a+/8tIhiUUgGNHU5GxyvVzesk0XKwwA+Q/9xsZVx1nf5/OoYqbnKc3FtI?=
 =?us-ascii?Q?UgsMozY1duKwl8MsGH0rE2TaBAoJY3ZXhSR6i3WlMm3H8/ow8B/jU/fD4hfg?=
 =?us-ascii?Q?30YOGu/FpzbENvewJk89S/nPKMv6YbR28d55UAt2RVwnqs3v0gBmAiJc5hz0?=
 =?us-ascii?Q?FZCy18NKPQttEUj4/79a+nkZ3foiz5v4aMcmEHh8wwEigaspnm7hcnAl6A+X?=
 =?us-ascii?Q?36uiaaGim2MQJaLgcpfto6p9cTwU5Zv8ZvmE/0I2zMAKKjbyg6wXVspeu+Va?=
 =?us-ascii?Q?xxWdSMJXeH2rJcr5YHUV+wTJIQXVFn0MEUtWvJzgucU0aQ9DXxjTpj4a7DbJ?=
 =?us-ascii?Q?2jRGMhAlMG3CmtJvT2fcwu6hbuROC848QaC2Hy2OP3KJ732j5tYzFDUFvZQ9?=
 =?us-ascii?Q?SkUEiL21FXQT46WyeJKZ6nwSXQy5nVig3l/4k24/gHIpRQ4CX0qGzrLrcZGL?=
 =?us-ascii?Q?UNL2a1dkB4bfCnI85irx9QEGYV80ZhqGnLRAFyeD7bw9ir5VmBxRSvYCJohF?=
 =?us-ascii?Q?YTexvSUmOsoZNWDs3I2asJOd2+v/LHd8hGU9xSeQOp23RPkc53OVfrKFerrI?=
 =?us-ascii?Q?KXh3oCGwYkoLTEDhaUVZpULcDuEQmhcyGoYykydtD1hMHUkM6N7sdBOdUL+a?=
 =?us-ascii?Q?7hHz2VJeFtOfFEDBIMsT0cg1r47FYwAxrCXjH2k5yvWQkihKC/ZINtGEZ2+W?=
 =?us-ascii?Q?LSEZs1/mofNSthq+EDuvrj9KrB7+W9co7NNx8Z4U3MvV1tOkriQb5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qgEsu817dPIU9G7HDvsQALzMLz4UA6IV6Y2jFH6sgR/SjygZX7m36JCkXgHs?=
 =?us-ascii?Q?uuiEroqIMHTrduZQeFy4uRt52HSkjRVfUMKqtZnzjNxzZCvZ3rREI9g0D9/B?=
 =?us-ascii?Q?AHH4CnoXnGKBYNrSQ2T/7m0RKo/2XIK3JOuasI/1Wq8FyPs7wjz7ciu8IjWl?=
 =?us-ascii?Q?2e/pYBxgoluXEjBzMcVSd20I1i5AL+uin7PjFu17gV3iSlKmI4/BzuNBitQj?=
 =?us-ascii?Q?55O7KTgE2y8S/tzchbWlovSjqBw+JM5pe5Ai19B7LE+xrH+qbV8tuWWUcAbz?=
 =?us-ascii?Q?4YCjh7/n905IDR8ZEjxwX6QUKi0EHzstFatnK1zwObnKxAv7/QTEFTVsCOcJ?=
 =?us-ascii?Q?aXE7Qay7m92D97CL2rX/xUMRgz4cB3aHUoGhcWpCXOk84Wv3SQ79JvCMZh2d?=
 =?us-ascii?Q?zZ0i7Ks9iXySCH9gtfx9eQ10yBNXlAWlY4Gmfk6sHkdb88/m5Gc8Vc/fdn+m?=
 =?us-ascii?Q?I8M0wVzBI0N6rEo0IpQ5nT5rb48lmj5rYuCTtOaSKeeaCXiQ3oirP8oVpEKn?=
 =?us-ascii?Q?cOT135M7J39EWtA8VJwyyOV0aXEW+MMgv2Fcft0rjQQnRhAo/dExAS/gIkwB?=
 =?us-ascii?Q?a04YZWA/eQk/XptXQy0yhVHSWJW1KSin/yLuaGmx812wNKwafRR13jaImSel?=
 =?us-ascii?Q?PSqwC+Hg6nOBi5SCrwZr7eelTdTMRplTSRw3TANFD5WobyR8Osy4x8+Xwo4g?=
 =?us-ascii?Q?L6W7ZW3SgfZ8ijf6Ca4SczcltcYdPTOyOpO+7/33R4tKBUwdufaJGaHfv1Wq?=
 =?us-ascii?Q?MakIAK3pczo33GxiCVAILkiF2PBfOZvUTYVoO5yVMsZ5uTRYE4TteEmPBcRD?=
 =?us-ascii?Q?pont4ww84tow/YEvMa+Qa32QKaIM2uEMMTgy6HFWAuPfLTUcieJwDr92KTlG?=
 =?us-ascii?Q?DFJ6hB2/N0Bq075XXZVqUcXTF93VB7vxouY+qU0A6rOPy4ZvjmYZ6R2H4wL+?=
 =?us-ascii?Q?v1Yvzh1T9tDTaNURkjGZvRHqVFV7DYo7b5GgoDPeH7r0iZNe/bwAC+ovWL9/?=
 =?us-ascii?Q?NqJaRDbzF0L5YFzmIqGBxNXrkHBTwiOlpSCaB/9GIk8WjYjPZI7HAVyWkhkm?=
 =?us-ascii?Q?AFfYotLPeuKgCJLVy/TuwAMFRicR7Ohj0IrN0vYJL+nwtAVRcN0xLUM4n0po?=
 =?us-ascii?Q?YuNQOt8DIqRYQU2axuto3oA9sz+kKn6nZh5PLMAefvT3Xx0BDUnfuvpb4ZBm?=
 =?us-ascii?Q?pGfFTHj4+4gpM2hhXsw5Ednpt7fdQBvttKns5hI0sxD8TM0LSNjQQB9ODD9t?=
 =?us-ascii?Q?+gr3zcnmsZWbrNVNw9X6z9L19BIuptj1gqBT7SBNxC7dJ8plCMd0wDGV9VGg?=
 =?us-ascii?Q?fVV8i2/ASRKYw11W8jpSqo6u0Ae3ncZlsxBsezyKcBwC1pQCcNfXBG0+1Mbs?=
 =?us-ascii?Q?lOodkTtdnNxMFQ4906iJQb9q4ZXTzFFwDJdqJN3M1XMNYHNb+1FoDBOXCnc+?=
 =?us-ascii?Q?QoIfu1OUZUOqgH9Qed+dluc6Gfj23ayuV63J0R0QhU1kbG0D6ceg11W8lmbn?=
 =?us-ascii?Q?9RC/hsvV8rqcjfK7wtA+SrydxxEOkE9mvH1KNLxqKFqyx7l0o/vKNoa2cJPX?=
 =?us-ascii?Q?c5KvhJfK7EHIAgbZ5R6JGJ1Lo96pxvd3GEc5NuE8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4342669e-ebb2-425b-b213-08dda77faca5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 18:01:35.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCAfdGrdUdsdfiOkXqrON6zAzb3qmyGfkUic02J319iiwvSH54fHywvGFoJUPCMUug22Sl/J51Ks2G68Diaz2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660

During rcu_read_unlock_special(), if this happens during irq_exit(), we
can lockup if an IPI is issued. This is because the IPI itself triggers
the irq_exit() path causing a recursive lock up.

This is precisely what Xiongfeng found when invoking a BPF program on
the trace_tick_stop() tracepoint As shown in the trace below. Fix by
using context-tracking to tell us if we're still in an IRQ.
context-tracking keeps track of the IRQ until after the tracepoint, so
it cures the issues.

irq_exit()
  __irq_exit_rcu()
    /* in_hardirq() returns false after this */
    preempt_count_sub(HARDIRQ_OFFSET)
    tick_irq_exit()
      tick_nohz_irq_exit()
	    tick_nohz_stop_sched_tick()
	      trace_tick_stop()  /* a bpf prog is hooked on this trace point */
		   __bpf_trace_tick_stop()
		      bpf_trace_run2()
			    rcu_read_unlock_special()
                              /* will send a IPI to itself */
			      irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);

A simple reproducer can also be obtained by doing the following in
tick_irq_exit(). It will hang on boot without the patch:

  static inline void tick_irq_exit(void)
  {
 +	rcu_read_lock();
 +	WRITE_ONCE(current->rcu_read_unlock_special.b.need_qs, true);
 +	rcu_read_unlock();
 +

While at it, add some comments to this code.

Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Closes: https://lore.kernel.org/all/9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com/
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree_plugin.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3c0bbbbb686f..53d8b3415776 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -653,6 +653,9 @@ static void rcu_read_unlock_special(struct task_struct *t)
 		struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 		struct rcu_node *rnp = rdp->mynode;
 
+		// In cases where the RCU-reader is boosted, we'd attempt deboost sooner than
+		// later to prevent inducing latency to other RT tasks. Also, expedited GPs
+		// should not be delayed too much. Track both these needs in expboost.
 		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
 			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
 			   (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
@@ -670,10 +673,15 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Also if no expediting and no possible deboosting,
 			// slow is OK.  Plus nohz_full CPUs eventually get
 			// tick enabled.
+			//
+			// Also prevent doing this if context-tracking thinks
+			// we're handling an IRQ (including when we're exiting
+			// one -- required to prevent self-IPI deadloops).
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
+			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu) &&
+			    !ct_in_irq()) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
 				if (IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) &&
-- 
2.34.1


