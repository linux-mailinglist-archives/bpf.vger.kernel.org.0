Return-Path: <bpf+bounces-50461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70145A27FAD
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 00:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A9D3A4649
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 23:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D130420C00D;
	Tue,  4 Feb 2025 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ZMzeuNw6"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2070.outbound.protection.outlook.com [40.92.91.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C5C2063F3;
	Tue,  4 Feb 2025 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738712120; cv=fail; b=CKS9he9BTMHPU76WHYFpuqGXDRCHL8OAa7vaAWqiSBoT/hT4ljh0mCeFxG3sBcXSRHW+PfzlU0ciF9fjF5SoU+4pMVM8LAs459LDnEpaa7c/oKjWI6nNClrU9BrVckXzSl22YiuxfP/0GVJe6fu2NK3AKj3UAfdVjZwGtn6PKOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738712120; c=relaxed/simple;
	bh=0/OuRWs7fDsU74EsnbV342xaBfBiR7cdi2VdxgDqB8U=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=HpG7XmX8WoEvYzW/OdFt0OyLTTasfpN3fzNdclDp2EDJDF+hX5G58DmYW6kWs/BUibyHNvwv57IO/66NPGdzGBn7LNJX88DfQGF5MlmM55E92tTSwb8zZ2AjIIDAWvppq8luJIJdXqEMKbEgsozo1anjBN86UhMxX7ezNRtLFko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ZMzeuNw6; arc=fail smtp.client-ip=40.92.91.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSnhz5M2VIoLB3ITicrzmnU2T7syM8mohdTnD+LkUZrlXIba8+wNic+InaPZfUAezSZutKXvGM+c2tfWRRigD1d66jgv6yfKQQvUhpRG5snhUqUR5sh4MLN2YHD+XNo5WVdGJnRzLSvuOsBsC69TenGJgsTDzJK5rTnPMLHz2Q7KqwGqcAJD9dvtIeasRzC4WHGVc2cNZDBk6AF5+IZ2p0AbzkninzgWkwEOgMqBcTt9cKdK8DRojy9tWeAKoDzjizW1YlvY8z3+D5LgskdwYBgrAWKMc47xB++RQdMOYQn0xCWRu/8nmi2s5rPk3Q/kTbffrhvVU6qs3NxYSYfa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NA/ikNo1xW/j73evuEieazwd34fv8aWI+kQo0bEGgb0=;
 b=LOATJqu/01K8Rm/bYx8KFDw8XBPgp/hy1ILlSPgGti48Z8LT6HHmDipXdFaB0zdwq6pSuXYZNfB4AEbY8bvejXSDfK0RX5InTGagbBV7aNnJxoo4KKexgmUzVBwFMbIaIjjx7tNZMsmGT01bW5mI9iT+misLQ9AbbxEXi3ZQaPOirmexmCHwG1+JdTRkprnXHTbL248vi2tr/7Gsq2xBo576cehzFXA7kGGrRD9s9iqhDh0w/theSILooFt41wJ9Lbgk6G8XmnW1Ey0HvNA/f3uR7hWZ5ZwPoEAojoX+8CcZRytpDmth2ZplLG9ppXXY5+bhYYVlIavV6wS2tiOnQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA/ikNo1xW/j73evuEieazwd34fv8aWI+kQo0bEGgb0=;
 b=ZMzeuNw68CCjTK4idSfjt8ePotw+R1T8NCeP7KaNrjmGi0Tsj+1rHQp/7/RGYxZFtY1iHaejGXwwXhu5fmp/tia2/K93+doUDl00PLmO/x2eHevvutTl+A4RwkgjJZMla16/xfVfk7xdml0p4bvUr/4a01h3lwROcBN3EL/9YedGN+ewUilx+SKQVJx9AAk2OVh9FnEsT3gngjyC178ZpIdWQ/5fnOsFQ545hoNaG3osNoK+IRwRtEfygjVZJcgLG8haRrauGLlsEgF6UcQWIAFfTblCYi9ZmVK8nZt47p3/txDXIAUksG52b9PsS5P/j0Bjke6C4c7PedPk6yAE5A==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB9676.eurprd03.prod.outlook.com (2603:10a6:20b:61f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 23:35:15 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 23:35:15 +0000
Message-ID:
 <AM6PR03MB5080392CC36DB66E8EA202DE99F42@AM6PR03MB5080.eurprd03.prod.outlook.com>
Date: Tue, 4 Feb 2025 23:35:08 +0000
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, snorcht@gmail.com,
 brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From: Juntong Deng <juntong.deng@outlook.com>
Subject: [RFC] bpf: Rethinking BPF safety, BPF open-coded iterators, and
 possible improvements (runtime protection)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0041.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::29)
 To AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <27bdae12-c016-483c-879e-9b7f846921fe@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 0acc132f-39de-428a-bebc-08dd4574933b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|5062599005|6090799003|5072599009|8060799006|19110799003|56899033|1602099012|10035399004|440099028|4302099013|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1hxaEh2MENJOEUxVnViUm5qbUZneGM4enp3V2dpclIra3dsVHhRUzVUVi9h?=
 =?utf-8?B?REdOT0UrbHRnZHR2U1RiYmdXV0hFSElxUEZIdTgrTkswMHdNTVBtemw5TEph?=
 =?utf-8?B?Zlc2WnM2MXRLclNjSG82My8xVHVhQit5MkpVV0paa3JTR2hoUU1WRmV5NnBY?=
 =?utf-8?B?eHRPUU9qTVY0THA5QTd1QWJEaUg2QWtMajdwMlkva25reWRaM05NM3JhaGFB?=
 =?utf-8?B?a1k0R0pnbmk0ZUc4VlgwdTNxa2xxNVYza25NTTJQUG5NOVJxZmgxR2pyS2tn?=
 =?utf-8?B?ZjdyUENMdjlRMVNMSUVlbW5TeVdEVVZrQm5LNjcvZEwveEV5eFl1Zy9JVEVY?=
 =?utf-8?B?NUlJU2ZQZHBTbGVJMUhlbWpoVXdXNFhaQ0pnTk9teWU2ZnlQcm9EU3BiY0Jo?=
 =?utf-8?B?cGxCUEN2aEFMWVdYYkJTb1RJYjVUUnV3TlZWMG1RcXRoMG0xMEI0UXFkVVJt?=
 =?utf-8?B?NGthVGczbG1VTWlENGZHYXBkUVdlOXFHcC9FN1VSMlFtT0ZDZWYvWnFvbEhz?=
 =?utf-8?B?RmkvUThObmpkV0podVpkV2xuNzZOWk90NytTNHFhZmI2aDZ4ZStpQ0VYbHc1?=
 =?utf-8?B?b0FGNmdSSGlsVDlNdXVZa3FpTGdZTWRMdXl5YWV6cklmeThtSEhoU2RKcFFp?=
 =?utf-8?B?SDYvdHUxTk1VbjFxcDI0QlMwUmFhcnJ2Nm45Z2ZWMDhuZzBuOTBmdkNJVG1l?=
 =?utf-8?B?QlhGa3ZhM3ZGbzZrRWt2V1dmRUNsR1Z4bWdKWUplUENkdnNKRWhTWjBhSThU?=
 =?utf-8?B?RzNBVGpqUnFzWC9lbGRkUCt1YSthSGNqSERpQkRkTldBVlllT0xCM0Y5Q0VM?=
 =?utf-8?B?dkVFNUtnTThVSGJJSjlYMElPR1Zabi96WmVYRW85c2Z1bWxzaGtXZkFEM20r?=
 =?utf-8?B?Rkc0c2ErTGpiek9oTm03U3hmTXV3UnBORFQzQVpjaDB6ckUyRFF2amhMMktL?=
 =?utf-8?B?Q2FLYUVBSHFyeWtKYWp0M09mcEFndkpSUm5GNExLNC91WDY5MDlZMTNUT2JN?=
 =?utf-8?B?bE96a0hjeUcvNWE0dG9qcmptbjJjZEVSVmh1SE1QaUJZMFRZQmJtNzJzb01n?=
 =?utf-8?B?V3RELzZkR3BVQys5ZUxreEVPbzd6aGlmaEdPT2RQQWFMQVYvdGlaVWJyaWsx?=
 =?utf-8?B?Z1RzcURkY09sa3pEWmFPT1JOeXAwNVdHNlQ3Q3NGSm9JN0thQXlpemJHa3Zy?=
 =?utf-8?B?Q2psK3Q1WHN3M0NZSElGbUxNQ3J3c3dGNUhtTytJTWZ4MkNlcGtPeXEyUU5O?=
 =?utf-8?B?d1B0V3hVdWJjRVJVeUszd3R6MkZmNSt3QkdJZDNDWUhOWm5DNytzRlJ5d1cz?=
 =?utf-8?B?Y2l3cWdYQkd6anVLRFFrV1ZWY3h3eUk4bkxmOXM1Z0VGOVFhc1EzTjZnSXhJ?=
 =?utf-8?B?ZWpSWngza1o4bG9DalpvQmhlcExMNkt3dTZ1MG9HRzRDRE5WSDh1Rnp6aEtv?=
 =?utf-8?B?QnpDRUltY0RxeUpGTlA1SGFwWHFKc24xY054Q0hrUGV3YWIrUExWanY4dER0?=
 =?utf-8?B?RVNYV2dqamhQMWhJVnNrWEJmRUVBK2JHMWlCUUhtTk9ETW9xNjlEU0t6U3Nj?=
 =?utf-8?B?YUlEQlNnNlBkQ2pqdm91TkFGVnJNeDBOQWtGckYwaGc3RnZ6NWFFZ1doWk9F?=
 =?utf-8?B?VmFZV3VoaGNvREhOdXN4Rzc4N29nRGxldFlRRkRNVkF1dWRHZGtaTGRaTVFY?=
 =?utf-8?Q?e39Cxr4QEzf0aAOzu4zz?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXpNdldiK04yNWl2aW5MWVVBbDN2OUwvT2VVRFAvck5TTXlKNDBnbGQrRzF0?=
 =?utf-8?B?SVhUdU44T01DOU9BQUlYcG1pVGp4bkllZGdzNGl0SDVmTnZsTkhkWGdHeDM4?=
 =?utf-8?B?Z1M1ZGhaeXNCWDY0QVNTeHk2VVkvcENEcDhVMkN6aGNON3pWaGFQdzk0T0pR?=
 =?utf-8?B?ZWIzaGI0ditTWWdKb1IrZWpCUTQvWUZrMlZXSkgrUG9tMWFpeVBTcHozcG9Q?=
 =?utf-8?B?UjdJbUNML21PRm5QY09CZjBjUTg4aGROZXpGOHphR3RrS25yc0tqZGsyYjVo?=
 =?utf-8?B?d3JOT3VrWUdLaWJBWjdNQytFc090WFdKTXNHOWh6QnRQSThLZ3hVZWxpem5x?=
 =?utf-8?B?dWhHWTMzenpuSVFvK0JERUxBODl4NTdMZU5oSFl5dGx5UkZIOG9CNFpqdGpW?=
 =?utf-8?B?bXJoSVJHRndWdWVQcEt5c1ZPL0RLa2tOaVhJaDB5TW1iRGhINVIvU2NwSEJZ?=
 =?utf-8?B?WUhkQzB4MXRxNWdNeXNyNmhKWENsTUhpVlhUT1k0Wkx1RU0yMHk5RHV5Z0Zw?=
 =?utf-8?B?R1ZVanUrL2hSTnJ4d1hOenpLUjJXRWFMVmFpcEhpT2g3RVNTOGhFOXo4T0xq?=
 =?utf-8?B?NUtTTnlNZWM5S3p4RWc2TklueGtNY1B2WFNCSHcwVS95MjAvQmlrZzhDYTdE?=
 =?utf-8?B?TXVxU3FYV1pjWXZRaXhobGcrRzdUVVhhT1J3cTVEN3JHTVRXQXFHUGtKaHU3?=
 =?utf-8?B?Z0VyN3pWczhpMk1XVC9va0hJRklOK216ZmtZSDg0c1kvb1FFd0RodTNRd3dD?=
 =?utf-8?B?V1pVV3JnSHFUakJvUEpDQXlScEQ1U003UERJak5HL3FWZXZPWWpzR2Fub09K?=
 =?utf-8?B?aGNRZWRDTVdmU3ZkaEFPZWxnM2o3Q0dMUTZGalNLMmtGOEd6SFRiVk5IaVox?=
 =?utf-8?B?eXZvSkF1WjBuUDFHL1duLys4d1RiQzluQTdpV0FyOFlpU09qOTBCeUh6ejY4?=
 =?utf-8?B?a25CVG1QVGhzVjRkU3hjakp0YmhEQzVQdUNrbXkyZ1V1cVR1VDBJMVZCcVFU?=
 =?utf-8?B?N1ZlbHNIUWFIQTJQc2dSdmNGeHlnL2phYWhuQlZVT1NGMTYzU1pyY2RJckJy?=
 =?utf-8?B?ZlFNd1J1NWNCL0JESGxEMWgvV2o4YnphRS9SL2lNakFzYU11cUNqb1I4ZkpL?=
 =?utf-8?B?dGZBZWljdm1vbUJwT1RjcWMxTWZYYmRCVlBKOHdsbXhtNm45cHpzRU1nWFZx?=
 =?utf-8?B?R0hlZU5TZ1pqQzFHRUhiTXdMeEZsSDNsUGQrTE9FVTNqSTRra1JhemFBMXZC?=
 =?utf-8?B?VXNyZ1ZGOXRtS0hCb2pLWU45WHU2S3ZtSkpObGxFSFVEeVlWMVdOTnJSS1Ns?=
 =?utf-8?B?cXBjcWpDWTZjdnJKM1FucDZjdUZ2SkJlNWRZSm9Qa2hNRUttVElVK1MwaTZI?=
 =?utf-8?B?VHlRMkFodHdXSzZMdXRrTHlWQWNvREd5ZkFqMVYxeCtVdGxwbmpUVjVLTEo3?=
 =?utf-8?B?SDVramY1VXNLazBua3ZtME1BZ3h0RU45dFNzUXd3TWd1aGwvNGZZdFdYYTJx?=
 =?utf-8?B?WmFmVHcxb1hTUUx0em5OVGlYSDE5emZrRFR6enZlOXRoTTdST281WFJQZ0wv?=
 =?utf-8?B?UXV5Q3h0MzdPZjg3azRlT2tEcmlwaHlEUXZQc2V4UGRoWXNpMk1lRTFhMVBp?=
 =?utf-8?B?WTFhYzAxNlo1cXdiNEw1SjFPYnJVbXIrZEFBZ0ZlS0Y4aHd3R2FwV3llV0M5?=
 =?utf-8?Q?zeyr9LCHYAfhFRGpV+xi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acc132f-39de-428a-bebc-08dd4574933b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 23:35:14.8912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9676

This discussion comes from the patch series open-coded BPF file
iterator, which was Nack-ed and thus ended [0].

Thanks for the feedback from Christian, Linus, and Al, all very helpful.

The problems encountered in this patch series may also be encountered in
other BPF open-coded iterators to be added in the future, or in other
BPF usage scenarios.

So maybe this is a good opportunity for us to discuss all of this and
rethink BPF safety, BPF open coded iterators, and possible improvements.

[0]: 
https://lore.kernel.org/bpf/AM6PR03MB50801990BD93BFA2297A123599EC2@AM6PR03MB5080.eurprd03.prod.outlook.com/T/#t

What do we expect from BPF safety?
----------------------------------

Christian points out the important fact that BPF programs can hold
references for a long time and cause weird issues.

This is an inherent flaw in BPF. Since the addition of bpf_loop and
BPF open-code iterators, the myth that BPF is "absolutely" safe has
been broken.

The BPF verifier is a static verifier and has no way of knowing how
long a BPF program will actually run.

For example, the following BPF program can freeze your computer, but
can pass the BPF verifier smoothly.

SEC("raw_tp/sched_switch")
int BPF_PROG(on_switch)
{
	struct bpf_iter_num it;
	int *v;
	bpf_iter_num_new(&it, 0, 100000);
	while ((v = bpf_iter_num_next(&it))) {
		struct bpf_iter_num it2;
		bpf_iter_num_new(&it2, 0, 100000);
		while ((v = bpf_iter_num_next(&it2))) {
			bpf_printk("BPF Bomb\n");
		}
		bpf_iter_num_destroy(&it2);
	}
	bpf_iter_num_destroy(&it);
	return 0;
}

This BPF program runs a huge loop at each schedule.

bpf_iter_num_new is a common iterator that we can use in almost any
context, including LSM, sched-ext, tracing, etc.

We can run large, long loops on any critical code path and freeze the
system, since the BPF verifier has no way of knowing how long the
iteration will run.

The BPF verifier can guarantee that the BPF program will end, but this
end time may be in the very distant future, which may cause the system
to freeze, hold references (KF_ACQUIRE) for a long time, and hold locks
(bpf_spin_lock) for a long time.

If we still believe that BPF can be used safely in scenarios such as
LSM, sched-ext, tracing, etc., users are sensible and will not write
long-running dangerous BPF programs to get themselves into trouble,
and BPF programs can exit in a limited short time.

Then holding references or holding locks in BPF programs doesn't seem
to be a problem?

But this is obviously an idealistic assumption and we have to face the
worst-case scenario.

This brings us back to the question at the beginning, what do we expect
from BPF safety?

If we need stronger safety, then we may need something beyond static
(possible improvements section).

What do we expect from BPF and BPF open coded iterators?
--------------------------------------------------------

Would we expect BPF programs to have flexible access to more information
in the kernel?

Would we expect to have more BPF open-coded iterators allowing BPF
programs to iterate through various data structures in the kernel?

What are the boundaries of what we expect BPF to be able to do?

If we expect BPF programs to access more objects in the kernel, then
temporarily holding object references is almost inevitable, whether
during iteration or not.

Of course, there may be risks, but maybe those risks can be solved by
improving BPF?

I have always believed that BPF has the potential to obtain information
in the kernel in a flexible, scalable, safe, and portable way.

Possible improvements (runtime protection)
------------------------------------------

The inability of the BPF verifier to detect long running loops perhaps
indicates the limitations of the purely static checking approach, and
determining the running time of dynamically sized iterations by static
checking seems impossible.

We may need some additional dynamic (runtime) protection mechanisms.

Maybe a possible improvement would be to implement a simple runtime held
resources record. We pair acquire and release, lock and unlock kfuncs,
and insert some code in these functions (perhaps via macros) to record
runtime state information (such as the type of reference/lock, and the
memory address of the corresponding object/lock).

After the BPF program runs out of time, the program is forced to be
killed and resources held are automatically released based on the
reference/lock type and address to avoid impact on the overall system,
and return the error to the BPF userspace program.

The timeout can be different in different contexts or holding different
references/locks (For example, in a tracing context the timeout may be
very short).

I am not sure that adding runtime protection is worth it, since the
efforts of BPF so far have been to do all the safety checking before the
program runs, but static checking cannot solve all the problems.

If the BPF community is interested in this, maybe we can try
something new.

At the end
----------

Any discussion is welcome.

I hope this discussion helps us clarify what we can expect from BPF in
the future, and what flaws BPF currently has.

This may help us more easily decide which features should be added to
BPF and which should not, or what improvements should be made to BPF
to help us apply BPF to more scenarios in the future.

Many thanks.

