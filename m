Return-Path: <bpf+bounces-21498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB5584DF75
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 12:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBBD1C273F7
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 11:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC06F51F;
	Thu,  8 Feb 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bhfnElo0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vZ8J67Lg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183E871B31
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707390640; cv=fail; b=QgnkHaEB5rqpA7Ex/DGgXJfMlkOSikV2/geyRpRdnMrUGLTxzoiPiNW1Bo+/UWVlqNbGEEoAPpo5uw5YEL7difdyEMQ8gL5AqAhGernY/zqiCQPYn2asZWxjgBzR51Y+FWCLG2poyn7PBP+9LmnTymFkd6qu0Xc9YQ9Oj8Q8KjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707390640; c=relaxed/simple;
	bh=2N1VCVWDCg465kNbZmX/5GkFIdlIESVUNwax5dcXf8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=SKJIhyoOiRcHl+9HQdXkJVCywLCSayhry/92GORokeliwjtCYYV5gopLPWjgWCo80l/vNl4t7hx6eltvzbhRSTyVb3U2FeFrrHRa7SeHb85bMTFrw1XpvD0kNrBhgW+9WTcNcp5reipXx31AfESuHZwEGze5yiCHSJhe794kctk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bhfnElo0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vZ8J67Lg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418901IP015734;
	Thu, 8 Feb 2024 11:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cPYAcowjgfY5yUyLbqsPGeP2aN49fJhY3SvMOel1UqU=;
 b=bhfnElo0J3roccB2uhPW+Gdpn4CMy/beJ0ALATCDpalMYpdPYGkFLVX3CV9Z+P/zzQUy
 PTV3TzzFmnHPYuEcr2n5mpzJT1YZUipFJnV4Dto8427SGXRPkef9FQZYaPWT10vw+4KX
 PFHtJ78On1S9WaHnxTt/9GbI0XENhcSnzscmVQ8vkW0cCS8OF+sHjVS2OEFs4eHqgZNp
 aMKewdvC9682bktr2emhti95FYwZ49ZNJz8In0mzayTvNHGUsJoeLQUf99qJXxQxgprL
 IpxjKzSOtuEY5MDjCFpaexkuOnf2tAFTLQBCSJMaGbn4yqKPrqBhPxhpRaTrq0IN7CqT lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbm6gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 11:10:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418AhGVB036817;
	Thu, 8 Feb 2024 11:10:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxagaab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 11:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bbqa9D8ysc/+oT8jxK6wat9V8UQDU75Z8MY0TYfE9e96iMpVMGCPSTQK6HT7OhIa836vGaMohB/fzHMOLuGNO47i4q3RX5ZQ65x00IBpkxFy7QTGWBWzmFFD01whsDLKJAAyqy9oXPAro3YFHktEN5SL+tEa/e7Sqy4IUXCzsYnukygFtdxC/uFf2ybMXL2mThHGxiGQG89yKrYdq2Jrps8LLFAYmQiSpgEqCx6kBPWaYZGbczCX0735bdrUC6dSyPiHvWdFNJCtaanbirPcmokv3flHO0Wa9u125meO3jzxjsDfaZXc75c3qZFXm2k7ZM9C0Up6jHZAO7e7XXikYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPYAcowjgfY5yUyLbqsPGeP2aN49fJhY3SvMOel1UqU=;
 b=n5OhdUUz/gB8P9X+HzDFfS2d+1u/EcB+ZnkG1q1hHFluH6lByHCK0/zlpz5/8qmU8K/5lATBGLeS+H2LZEAc1RPLTXBW/X3iuQCPmMnUmCSl2d2Kzw0AZy5zW52jaVzcI+seTeOPAHS5pBJGhuFIRKPzgEJFyFvjnKxFwEu6BnP2+9oYMS+IaAABxTulzzKFxO9Sxo1u0T6p4KzXve+yRvHpTlid7SQX/LIwUPSmPw/m0tOzR+Kl5z4lHHOyZMxvT/hwNDxjyLRttywLOCsS0pjKPmRWvHF/waaECoxEQ9CmdsBzDUicUEuSlE34yBciiVhLLcmdX0biezOPnEj6Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPYAcowjgfY5yUyLbqsPGeP2aN49fJhY3SvMOel1UqU=;
 b=vZ8J67Lg5YllW5ZqAwfEuWdNul4t3waTAJfGlHT/aV2z+XO7Nb4a9BAtnQCwnanJC+1j3NkrAc/LOmVxG0rzwia4IGtDHLUwz95gQPKRm5nBZWCbZ4GXbdReobI00R2/fS7mcS67N9cYMDraMNf7EPWYbh32MI7hUhMUvtkZGLo=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SA2PR10MB4441.namprd10.prod.outlook.com (2603:10b6:806:11d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 11:10:06 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 11:10:05 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
 <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,
        Barret
 Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-mm
 <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 15/16] selftests/bpf: Add bpf_arena_list test.
In-Reply-To: <CAADnVQJEhr6WLEC=faVCO4cE0Ke-yog0zH6PGmXK9sKhdidhhA@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 7 Feb 2024 18:59:04 -0800")
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
	<20240206220441.38311-16-alexei.starovoitov@gmail.com>
	<3115274419b6bf0a27facdc0b41094842fc61c84.camel@gmail.com>
	<CAADnVQJEhr6WLEC=faVCO4cE0Ke-yog0zH6PGmXK9sKhdidhhA@mail.gmail.com>
Date: Thu, 08 Feb 2024 12:10:01 +0100
Message-ID: <87mssbfbzq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0292.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::9) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SA2PR10MB4441:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6c78b4-5d74-4592-610c-08dc28968110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hr0aJDbwcD2Uq0DGnQGt19xaiVU0UFLpapdpewNWM0VsgUFkuyCkBtfNAXh1iKcYXRsFPuRZk9gOmf9mb+xLUO0f46IC/VIKbGnvoRiwnEL2AtQAR/SMirOPr5KiKRzvOsWQBGRfKyXfQ/7vQBHYzSw79G9MqVNAb5H9rEyALNDTwM9zB+X+qrdslIq3/6EVJVsNs6bBGLTbnvioxgALWgdJbsa8dwZMNaGn3WvEZ7wLTwrCmKCWRQ4sJxRN9PpwiJbVvDu6j+QIvac+g0yTsATso7CPFQCP6E7YNq0DNsQPSs9ScwYrbxOCDTgGd0xqb/Ofp4erhJS5YyRoUdw+C/zS8BpJCTYzO3j6ioGs0uBX6c2cep4H4HQ+whyUZN/XNmGzVPqsOIF7yIRwe4oXqXOhTtKevTHXx4/rQgSokgTdR4LDaCSEcAZSYXk+0G0/uDtMsyF97BAaRedaWq18mZiksXLx2FDFN8eqmxGj3Diobn45SfuNaBbmOaJbbjuebxh2RriaHbrpRF1H57/+t/XSQUlyk0IRFnzDM9CwzBwsESr/kfzvEyrDxyBUykpV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(8936002)(66946007)(316002)(8676002)(66556008)(54906003)(66476007)(6916009)(2906002)(4326008)(6512007)(2616005)(5660300002)(26005)(6486002)(53546011)(6666004)(6506007)(478600001)(7416002)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0RHSnhsT0ZYQXY5RUhnV3J5cnl3K0J6T2s0R1ZnaEg5RGJLVHcyRC9IcFlR?=
 =?utf-8?B?aDBPTnowb1R5SUFaWmRaRkFMb29UekRrRVU0S0Y0QjVTakoxUnNydXZkYXB2?=
 =?utf-8?B?eWxtdE9sWFp6U1VNUU9weENXR0hXT0p5RGk2c1cxc1phTHlRY0xSSGtKSXVk?=
 =?utf-8?B?RXJxdEdIVEdhUncxMms1ZTlkdXFoV25QTTdYNGp5SEZnMzg1VlJwVzlEaTVs?=
 =?utf-8?B?dEk2MzdhdiswQWpEbnpsb3E2OWZtN3o5NzdIM0ZSWk1uVkF1MStTajF2NlUr?=
 =?utf-8?B?SzV5akRJNmhKdC8reUhYd1NhSDhMUS9PZEZaQkRqRUd4UzZiWDR2bGtGQmRw?=
 =?utf-8?B?ZnhnTXNZRzBhRjNnUDBsTDJQN04rYnNWaGx6QVd2bTBYZGE5ZEZqazNZaDlV?=
 =?utf-8?B?TjlOd1loOURBUWh0V1I3OUp2bCtDVm40VWMxcmppbThGL0ZXeEhkdkY1ZFhJ?=
 =?utf-8?B?VmMwbTRlSjFKM2pUNGhkT3BKRkxyeFZBc3llYkJxOGh6RDhYLzR3R2xrOGw3?=
 =?utf-8?B?WnlHRUtYUmJpbzYybitqK1daeW9Yek8xQ09oZGkrbGZ2czF0RUp2UGx1OFNp?=
 =?utf-8?B?TlRxb1Y1QkV2M0hZUzFva3d1UmxvQWllOUpWNUxBTVA1TXhzZVhhOUNncVVm?=
 =?utf-8?B?d2dMU2tDRzFhSkJpbnpJL00vbXlKN1B4UHBnREg1ZDM3dG1tRmlGRytUNUxn?=
 =?utf-8?B?WWZ6d09DWGdudzRWQmF0aURNSVp6Ky9meFhsSFRTRitHR1ArSmR1bmtITEdW?=
 =?utf-8?B?WXhUT1locTROanNoVWRHS2UrUXhLZHVYeWZqbVZPeTBvVWlEdWs3ZlpFcHAy?=
 =?utf-8?B?VDlLTVFLUFZIVjRZYUpFdXA0R213VTdrYkdjWHpDQjBIUnhvRTBnalFPWkJ5?=
 =?utf-8?B?SkZwd01JbkVDcUJQOVN2TlIxbEd3UHdXRTZZeWxjS0F3YzZuMzVLaWxyd2pH?=
 =?utf-8?B?VUtGQVB4RTdONHB3ZUgzY0tyRUlNS29vZEVxOWg4c0dybHJTeitjQ2J3TjFI?=
 =?utf-8?B?WS8wZm9ZRXkxNlJIbUdnNm9QbExMQnEzUnZOanJwVGN0VDh5a2xlTVZmWEZJ?=
 =?utf-8?B?NWhtQUR2SGdVeFEzYWEyRFQ2Tm83c2RqQmtMTEd5Q3BDSVA2eVdYbnlHb3Q2?=
 =?utf-8?B?R096cDhycmlnWEY3LzVJSzlCb0cyaFdWQStBY0x4T0lZajd1SXVpai9xYUQ3?=
 =?utf-8?B?L09pY0xmQUYyQmsrc294bHgvczJ5a1V1aVArenkzbFVUc2ZDV2RmcjJ5cUY4?=
 =?utf-8?B?OHY2c01YejVQRHZ3SFhncXg4WUdYRWRNUUtpemtMKzN0SVBOa3E3V3FhUjF1?=
 =?utf-8?B?UEVxYUZ3dTZmLzA0OXVhMlkzcllYUEhobnZ2MGdUcVlXSzlPN05jUFU1bVdO?=
 =?utf-8?B?dUo5NWJyVW51UVJkMW50d21KL2V2QUh2K2hSdlhad3VZK1I3RmpWN210Mk9O?=
 =?utf-8?B?SlQwSlgrUFh1SU5VdUxGajNPejBtZm8vSkkyL2xIWHJNbUlCZ2VTM2F4YlBI?=
 =?utf-8?B?NExMUmdGVXRZM0FpUzhZYngyNUdmWFo5bk0za0N2aTBaS2FBNGNhaXVVNXU4?=
 =?utf-8?B?bGJOR1FSQktPQzgrcDFWeGZCOS9jS3lDTjllVU9XUFRsZ0drNmp3aUMybWZ2?=
 =?utf-8?B?bVpxUHVkdng2dXBwdnpqczRpRi9zV2FjSFNFMTJXdGJMY3pnUE1IUTc2akov?=
 =?utf-8?B?YkppVWU1SmI2ZWxBZFUxZFdCWDRvcXg5R1E0eWx0T1JuN29CQjJlZzg0ekli?=
 =?utf-8?B?Sk1rSGVLTnl6NFAyUjEvaU1JdThsVDF6aHZKaVF4NDIvdGlUN0NNZHlacmVK?=
 =?utf-8?B?VHoyVVJ5YUNxRnhtNUE0ZnYvYlN0RlZvYnZydFZsN3NrL09HSzh2T0F5OGIw?=
 =?utf-8?B?S0N4Qm1aR0tyRTdaY0ZPTlFTTi81Vzh6VUFmZWZWVVBqYy9wUzNodUk0QWp5?=
 =?utf-8?B?MFhKV1FUaVVDeHY2ekVkSytRcTlEVVM1L2FldGh5T1hQTStRVkE2bVFMSElF?=
 =?utf-8?B?eldZOEszNU82NWVWaFBHZE9EeW9OU1RGRnlQOGhvRGE2endPZ3crSjBJNEJP?=
 =?utf-8?B?ODcxYXhpdHNKVzVpN2szaFJtY3hZdDh4eFJYOEQrbGVKTnRUNEZIZ1V4aVFi?=
 =?utf-8?B?YzArWTJ6dm92a1FCQ3E5ZzlveWJUTFZkMHMyYjJqSDZwa1UrVmlLRk1KZHVH?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ra4Ock5WkioPDvB1kdhuoLdwnc3U94NkOgCXQa1nAZkvdWWdsyF4UmPP6WvcrITpwowd+dOgwXdzQ0QeiEwhuqsJByNMuByjARAiJdnA7c6ziR7OoAHfvWS8RVYEWoioB2so94+U0OibnWsWcMO0K+ptnpmKiL90GeR/Ev1U9gjGPF0hfIaR8BpxOgVWHNfhPDOjF43DY8FLx0bxrvUqwkUTcNdJuajQy8LtH9JnW49IQJZf2EBiwDQFejj0+MvihNehlZFAv0pDW+tfnTLmXVKMWWkRp/SpEs1aORtSOHDvVmhbOWqbKfm/E95xEC7tSAGGYFO/gDwHgNr3zXUR0+Mzh0vHwpw3qQZls+j5SPprYW3OYdhU5WgEaFKQti6isW5wPNjyCVWFGUqu6jAnl7euu/1OLlor/NMJiUoocamHVF8bVRrFa6GA5GtW501QhQXU6vhjruI/+TQsxrKjYaCEt8lGmpe+H0IiA6hMuzfa5QXFCKY/suWoOqQEFno8e2qSOyhn2j3DVG+0YjfyF+M+PPi3mTWNRmKdWG5vruiMTCnJjZfnCB3vMbFVMMKJ2tWTJrhrwMlu1WbdCktKLCjr9UPBC4CKdu+JMQ5G59U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6c78b4-5d74-4592-610c-08dc28968110
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 11:10:05.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGOLJm1Xki7GN9Qfv9M5c8iwIQbl1qMx7wRx5TEFdjkxBosLMH010MvHvf/q9AjR/2p2FL0ggdUNqiSoUEyBPqJBKa0945oq4Rq5YPDukXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4441
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_02,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080058
X-Proofpoint-GUID: HBvheAHVajxvM-1JNLYzeWouGL85BA0G
X-Proofpoint-ORIG-GUID: HBvheAHVajxvM-1JNLYzeWouGL85BA0G


> On Wed, Feb 7, 2024 at 9:04=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>>
>> On Tue, 2024-02-06 at 14:04 -0800, Alexei Starovoitov wrote:
>> [...]
>>
>> > diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/test=
ing/selftests/bpf/bpf_arena_list.h
>> > new file mode 100644
>> > index 000000000000..9f34142b0f65
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/bpf/bpf_arena_list.h
>>
>> [...]
>>
>> > +#ifndef __BPF__
>> > +static inline void *bpf_iter_num_new(struct bpf_iter_num *, int, int)=
 {      return NULL; }
>> > +static inline void bpf_iter_num_destroy(struct bpf_iter_num *) {}
>> > +static inline bool bpf_iter_num_next(struct bpf_iter_num *) { return =
true; }
>> > +#endif
>>
>> Note: when compiling using current clang 'main' (make test_progs) this r=
eports the following errors:
>>
>> In file included from tools/testing/selftests/bpf/prog_tests/arena_list.=
c:9:
>> ./bpf_arena_list.h:28:59: error: omitting the parameter name in a functi=
on
>>                                  definition is a C23 extension [-Werror,=
-Wc23-extensions]
>>    28 | static inline void *bpf_iter_num_new(struct bpf_iter_num *, int,=
 int) { return NULL; }
>>    ...
>>
>> So I had to give parameter names for the above functions.
>
> Thanks. Fixed. Too bad gcc 12 didn't catch it.

I'm opening a GCC bugzilla for this.a

