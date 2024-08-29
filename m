Return-Path: <bpf+bounces-38467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208AE9650A6
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 22:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F3A1F22440
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B41BAED6;
	Thu, 29 Aug 2024 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YOvqDJwq"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2022.outbound.protection.outlook.com [40.92.89.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7221B8EAE;
	Thu, 29 Aug 2024 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962697; cv=fail; b=nTG2jS0PFSo8tNBcAPWiuERwiWfz8LG/Q4nKJq+LDprVtsSDYJHiyZiYimYEOOGGBKB7bnlpBLb4MIrrXgjyjoTfyxvxDSYm+euf3dsZfd3c4B1KR8QLYREqqpzEnZQsvOrzPizIPPfUaVE16bHxquelOVCxAJiRMBNgp/T5K/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962697; c=relaxed/simple;
	bh=Tq1LQ0wEo9Ieiexf8t+BGUOIU2R3kjWACrt/ZmqMcOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=grkCCwqYf3yUhrD7v0Fw68e1MqXWNaQTjc9TyUXbAfWo8JoeqhSV2WKWObn4zxi13Bw4htcFbwPE9PyeJdni3O7dr7klE5Z9u8YbVftbALafDyBosT5pRQH1LcaeX9afkOMblZx5LBngbjBdt4gas9oME8FHx88DM9dLGvoHeNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YOvqDJwq; arc=fail smtp.client-ip=40.92.89.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkbFoish0sgz+wQMmn0FAPT6d0cuxVb6b5VEEiNGDsxo1YDSEok7QxX/8faD3j3k7PeeppvwZeO5r/mYCrhDvOw0ccivnY7rXTzpL/zuWG7QcPeKHmijR2roU1dxQV3vR8hMD18ehBkiL6eGDdaK9qNkIw4y4x6B2WhLtfX8094Bcal7J5uKQNRn+H32U0Wc/V0ojrf9OqRYLl49gO1KSrC+rX1+XDzRvm4RH8osMdeIOhlJCXNe7qJ30vmETOFeAm/UKT9JBaFh+GZGjwW+S8k8DdjUK/rDTyUXxygvh6L94WfxmpEqjVOBStTqAGt19YhDBkyGIVSi4JEuYJa1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Sd5M5oSqrC6GqDCVTMCHMocjj4EVK1pDTkdchZl6mo=;
 b=aDrVTi2v/QhayTmsg71GfBtC0a1TPzLYqElxgkrW9mtwT2+nQIyWiVFvYe6t1OVx2zEwaaizfRlATIPSE++Jt2JVUzzHVCQmue7QODo31T6i6jNrKVuUBBdl8PFX3pf2cCvQ2csxymuyLlDXMT1Q47Dz5xOLelcE2eHgkDb7rg3PHRdAKpCqiCnspVHqwQkk2yK0xfpwBxUu81M+GaVu5iI2ZiFSmpAZrBXKFqCok5RMW7azmaDiEFtCFAjI/Vszl0V++OmeVqsOpp1ilD0O0XOVYcQZeerfDrBa+T8+7UlVn5zi92kjy9i89yXMJ2ZS4T9G/26wxLA2F7g8+xjW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Sd5M5oSqrC6GqDCVTMCHMocjj4EVK1pDTkdchZl6mo=;
 b=YOvqDJwqboeDNEFzGEA35wiYdfm4Dzt9gof6DWMfVBGgZ6nJaCU15UE88OlVAX5GnsjMQzaoA6JK88E5aqcsiOCqTnKxq5Kk0u1UpClIYxGwUxvyr7QnXPLmgXCTICJUAl2iPrCd1CX+yqG3GA4ulSNj315Jrxqe1q58rQJ8PvO3PbNvw58u0LlS/g1BYCqxWVKDeIVhe0cIPbQa6yq1N8lxRPY2D9hoIaWn97SbeiCVBBf/THcRnQdxsFqD+9kVDi9jKfknT3DFbbZ69uHCZTKySyCgDtbWO7TYOS9sVJUSlK61Tl90kao2R9ZxUG45/U8QqUNdtxYzBGdaEQCO8g==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by GV1PR03MB10409.eurprd03.prod.outlook.com (2603:10a6:150:163::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 20:18:10 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 20:18:10 +0000
Message-ID:
 <AM6PR03MB5848D364CD9297DE667B401999962@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Thu, 29 Aug 2024 21:18:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Make the pointer returned by iter
 next method valid
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <AM6PR03MB58482E9A154910D06A9E58B499962@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAADnVQ+P=j0MTkyDD0vYcaqU-qqdE_+mi+gDaqDsLqTXWNPHwA@mail.gmail.com>
Content-Language: en-US
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAADnVQ+P=j0MTkyDD0vYcaqU-qqdE_+mi+gDaqDsLqTXWNPHwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [211YcQJYdt2hyKCc5HI2e4SkjgM66viY]
X-ClientProxiedBy: AM4PR07CA0026.eurprd07.prod.outlook.com
 (2603:10a6:205:1::39) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <b4d3143d-6ec9-4373-8f0e-f30dde2544be@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|GV1PR03MB10409:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc198bd-9266-4029-fd9b-08dcc867b37a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|461199028|6090799003|19110799003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	6idH1qiVRuFaanJ2zX9izeiBmI6/9TIQdJQIVYucbaRwpetZMt6sd8wwWeh+ZA/A4iykVb68To/iPrI0LBKabUaNkrev/9cpcd0fuJpiIgu0yMllGOsj0C6HrgeTrBYCJ2w+RvnHr/UReZIXjZ/yBA2m/vBC1LpVB8WPVrIFIdU4pCzjXuoaIgDsRMxGzizMX+nAO0tRd7IKZOHOFVVusFfulJ+2ysM0vzMBbwfSL9GskPT+u6iEzMO8RlqnMAL1VX/ajfMmbpDSgMmTzVbjG5wN92qGGH3FZCjWPYcDiXncixdz6o1ytSU3JYJqOYj1Qf1B3xRoc9zGL8cU3tidCAJYqVCppmkdYkf5dAP8ff+SA68JnTF48ucDWC+tTh2kxd04CWeMFNUEXOxZjlDGHqrEWVdmx9c5AfqElj0qcTpEJ+XrqbPLcfnfRa97tiI3QnTbw3eGDNEeMCEEdNDuAT0Rf63bhKd0PSYh/7nRM9SE+/jgERNXlw0kqyhnk48fPwVTK2zEyMjKeoJewEcYkileqpESJziUuxkifbQyNOoSOEHindQX4d8mOfSOvyJUNdj4aZ+LGZ+r8n3MybkVujlij9rtiY51EXgCuZksJgjK2fLxOHlfVLTzwB8TSBbaX59vJwRtc0GiontBjO59A92Rt9/rO1f6wkbEkyCZGt6rDb5K8GK7qnzdmEP9g4B7yU4rv/oQd1JHLGdX2ZxxMilOvyfwyHopqegOaJOzSiqhkI4SmC+n/OepjDqBsprGTHmEFiwQ4tXm3s7G/6doixjp8ZoMfmUmlrHapl3YGXY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXU1VU5uUzIrYUo2b09HakdEUHRqRUNCaC9KSmFCSkVaQVpOV1FZZTVFSXlC?=
 =?utf-8?B?ejRvRzQvSXV1OUFEd1ptRm42YVZUV3JPSXVUbGxlZnBlZWNYMzIzMUJoclNT?=
 =?utf-8?B?Q0ZoQ3FRRkFvcVI0MnF6cTdyYjVwQnhjTStMZXArWjUrbjlWR1JvdFlXUThi?=
 =?utf-8?B?aS9zT1FuTEtLdG90a0g5U3JZTTUxOVZJUENlS3gzTm1KMERzTFM4eVJzRG51?=
 =?utf-8?B?NENCakpDMGFrR29qeldXZTRQWitmR2huUkFpa2E0SzByRzJjTUEwMFJUOFUv?=
 =?utf-8?B?ODJtaTZYaUVxSFBYYkswSXNFS3lCazVBcTVsL1JvZ1ZiN1p6TEVDM3ZPTXQy?=
 =?utf-8?B?ZmdMcWc0SXMzdVdqaGwrUDF2NzF5NHpEYldUWCs1L0QwOGMwUzA4eTkxQ0Y1?=
 =?utf-8?B?ajFFc0xSUS9TTmVGSGhZT2FvZGlIa3ZtWTAvaUtVTkx4UXhLTEZYTWY4NUxF?=
 =?utf-8?B?RE8vRVNrNFJpWnN6QkYxL3o4amtLQ29NY2tPQk5lQzZBaUVmWVBwWkFHZjly?=
 =?utf-8?B?V0hGYlFDelBVSGFzYzZUeFZKdTU4ajUwSExvSnpoajJ6elpDRlEvOUt5K0FH?=
 =?utf-8?B?Nzdid1F0WEJnUzBSWktqUThLcnZ4MWtQV05OeEt4QWdJbDY2WlpsOGxGenhM?=
 =?utf-8?B?U3Z5VTNmeHB5U01oRytjdk5wR2t1a2liNFdVK2k0Y0ZGM01OWFVOWmZqbmgw?=
 =?utf-8?B?dHpQUDBEUjRQclNWczlsRFNaWkw4Rm0yTU1tQ2dtVlVTaVR2ZTF2K0JDRll5?=
 =?utf-8?B?R294WStxY3Y3SmdPVjY3KzNMOGo4MDVwYitMOUgxNWlQcUp0Y0M4bUNqZXI0?=
 =?utf-8?B?UlhGTFVYekZ5Qm5qbXZqRTZBL2NKWW85NnBGa2Rjek9rVWI3eDlWayt5L25Z?=
 =?utf-8?B?ZXB2TGFxM0FmMzJyUStubFFIT21tUGtSOXl5SktjYndLaG41ZnpyR09LSytp?=
 =?utf-8?B?QVhwOEZSdk9rQUREYWYrWFY3bzBwcGNJaGt2NVNNVFRjYXd1cU85VGVXYzI0?=
 =?utf-8?B?ZWJPMG9JY0pqNEliOFp5REJxY29jOEl0MG1PaGQ4UktXT05nTTZpNzFHR25S?=
 =?utf-8?B?TGUwR2Y1OHB1Tnp5YWVTb1I3T21YejIrWTlBK2IvQWFjQWROdG5PbEVBZmxk?=
 =?utf-8?B?S1NPL0ZuTFVsYVhQZE1xV3hubG81RDJCa1ZnY2h5bDJQRXJDNGV3VHhubHV1?=
 =?utf-8?B?QTRMV201d1JFd2prcFRjU3o0ZlIzRVF4emw4czYwZ2J3a2FXWEdFMndBTDNk?=
 =?utf-8?B?RG5leFV5RCtXVVVwa2Z3cHJkNXVONmEzaDhrRkF3UENOMDFXVEJKZXJPVjNQ?=
 =?utf-8?B?VEpzbFF6WHYzQjdtV0JRQnhqMmtsSkNORkpERndSQ1VNanRGU0JEczNyeVhx?=
 =?utf-8?B?bzdPK25XUHRrR1VSSytiSThEUWE2L2d6UUdGbkJhVWJKODlWUkZ1aVZKUUw1?=
 =?utf-8?B?VHUvRWM0QmJZc0Jmc2JubG1sS2Q3NUNjRDMzMGdWK1JSejEvUmtnTCtOdW1L?=
 =?utf-8?B?Tld4Z3hqZlBwaXlONTBEQjlyWXJaZGhrSWkycTlYSHg5UnFIeTdjODl5d1RJ?=
 =?utf-8?B?YlFERkdSUU1tMjQ1dWNSTk1iY05oVzRJK0dZRHdDcm1DNkV5Q3ZteGkwRy96?=
 =?utf-8?B?M2VtZURTVDV4Q284T2ZJNFE2VDF4MkM4Y29ERlFkdFo0amRBZEpTZVFDczcr?=
 =?utf-8?Q?Yfi6Lm3OcLpgwfKh399N?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc198bd-9266-4029-fd9b-08dcc867b37a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 20:18:10.0125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10409

On 8/29/24 19:37, Alexei Starovoitov wrote:
> On Thu, Aug 29, 2024 at 3:45 AM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>>                  if (prev_st)
>> @@ -12860,6 +12867,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>                          /* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
>>                          regs[BPF_REG_0].id = ++env->id_gen;
>>                  }
>> +
>> +               if (is_iter_next_kfunc(&meta) && base_type(regs[BPF_REG_0].type) != PTR_TO_MEM) {
> 
> The != PTR_TO_MEM part is a bit ugly.
> 
> Why not do it in {} scope right above?
> Just move it up by a few lines?
> Right after regs[BPF_REG_0].type = PTR_TO_BTF_ID;

You are right, I eliminated the != PTR_TO_MEM part and sent the
version 4 patch set:

https://lore.kernel.org/bpf/AM6PR03MB584869F8B448EA1C87B7CDA399962@AM6PR03MB5848.eurprd03.prod.outlook.com/T/#t

