Return-Path: <bpf+bounces-962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12910709AF1
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 17:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C717D281D55
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8451096E;
	Fri, 19 May 2023 15:10:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6F5670
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 15:10:47 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CFE1AD
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 08:10:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JEOQhi005379;
	Fri, 19 May 2023 15:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YGhnX1KnaECHxO/9Z0MSc0Hy4qHXOa3bZrFldSdPIw4=;
 b=2I8+zH98by8bC60e2fTRZfzJU280aK3MKjIpITGHVp7F2LNh4U4tUB+/a91mgOu8LyxW
 uDrK6n8lvcLUMN1fdWiZmRRV5naZNHOSLMkRSFTRTVYkUD/OkP8ICeErWeh67fJJAxJH
 FXVqIlu96G0dFMDZu+VGTLd7o0Upa4zS2FpaWygB1INp1Gdtq6V2voFNtP5YIgEr0YoA
 z13eKp6oNkYB4WY+ngVxCfRjbhP4MzuyfU1J3ulNc+UgwHiZU488NnfpNrQpF8aq63Yb
 7fp7rAi6NzpJXgnnrQleyUxqpiphNwfVZ/ya/ZnSQzX91T/4aXFXsOU27W0jki3XlCRl vA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmx8j57j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 May 2023 15:09:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34JEXnMo025031;
	Fri, 19 May 2023 15:09:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1086vp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 May 2023 15:09:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmgYJYP/uiM+pGlaqlnHpKe+KrsKuO5AF8V6W5DtMaSF33iu8UuOQN2OW0Lpif8Np0vId4km9nL+QWrFem3AHdHhgk6qWMCu9444IDyntD6cDd2l4zd5NgwJNuLHy1dMBmqH/sreMbTVRBgQH02bn0lk6T5P99CVcyTwqIRSHV78Obu7p62/dgIO9UtfrBgcIBMYDDV+180p099+VERW/iQpJsQrMtOhZH+TP1sFWKG0qKWW45o5aofAwWTJJL+2RX1XAWiiVczFEAWZo10geW5G625/vt2oIoPFOZ2198jSxcBNU2+IgUprRTpWMkjYBIehCL4JfHgVIMYG8Ju6Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGhnX1KnaECHxO/9Z0MSc0Hy4qHXOa3bZrFldSdPIw4=;
 b=cpxVTrt+M2NS/Dm2pmbr0OIh3/vep32kpgvmy/+7CwhALP1CRo/IHxYqoOcDcg6shoQ6HRDA4elpjBGyB9ZdUNaIq3m43SZyulQDFTzvOX4Y1HPju6ObdT5uIDlr5zzj4uyluxOxmgX81KfpgIKqpckjq1am0ldBggy7XMJKh9uHTeJa3Ca40A3RfjMv0RObf4QogKHHmaMlHVEXKvE4TgMQ3mwPT0dw9dtHDBtG1wq0gP6zYXhRdct/GYLrU1gOFtLz2C+AAii9eDQOSP3I7SxYM0hJJCsVCgz1IpanaLBszjuVU1ic8zcf8gS0LaTp+Ib8PK9XOFQ4ayuI9/3InA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGhnX1KnaECHxO/9Z0MSc0Hy4qHXOa3bZrFldSdPIw4=;
 b=kbsgRQ1Tz1euGd92DoakCJdUVhxZOeOTbWGxwc7HFW4NzcXejBjEolwQQJ4Phr1nDaCjck9AmbJpuTsNoiuYhUEO8aEeuJduqqitLGImKxgazDz2Rr3PYGX6Jz2tQI/SRhiZjrjMmsYINzyObMFdknFoRvmDaeeH81dSk1k+CM8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BLAPR10MB4978.namprd10.prod.outlook.com (2603:10b6:208:30e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 15:09:46 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 15:09:46 +0000
Message-ID: <c455f7a2-85c7-fdb0-509c-9c259894a3b3@oracle.com>
Date: Fri, 19 May 2023 16:08:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC dwarves 0/6] Encoding function addresses using DECL_TAGs
To: Yafang Shao <laoar.shao@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, jolsa@kernel.org, yhs@fb.com,
        andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <CALOAHbCXC5Qvn80HxVGAFLiVE17zOCyHg12X=vXJvcZCU6_gKg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CALOAHbCXC5Qvn80HxVGAFLiVE17zOCyHg12X=vXJvcZCU6_gKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BLAPR10MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: c39df269-477b-4f09-f0aa-08db587b152d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3fULIMy8KZxzZ1s4uDSSOpvW+9SmfWUUqmhmNjfgCLPXEuhRsPQk8ls0+JH9DD+8iBNXF3bJcVJslOSWzrxS/eqVu3fEIPOnEsUXy5ozFf+qEmvnoJmV2/Xpi4S9pgzj0lavwV81LhEollriyT30Ly9THpwUGQ8YWkDC4Pm7P3Ej0hW7gfcWrukds4tGVJ7ynTTo4wmLulSp+9MRFWJ17MtmrUSe/UWsTbfx+yrYVyPmmmMUyAU2HQYxoJZDuk3bMWmvUrS9tjeH0eyS1xEuhMehOWTVkgCzBaKqgnUjqPWaXUwaP+E2McE7bMgPbEGmcKlnDZrp+kCyRnuE/EszvkzwxDE9wu5vBJN36XmkbfkrAgebvAIBZe8HZJOq0AH153fPOCLdcmRJdLwqCobjHcK3ZN4n62ytXcYsyHc3j8msn99gMhJ2UA5uBneEBVyIjFD2361XMHqrR0cnOD/Mw89YwEH97ByU8JZfZHZ/9DqrDZeHrcxfqqUd1auAU6vJgmYUwYgxvDmDoQ6Ahna4eHbzufItdkpp2fRkvuxWmJDquDjMFSN0KiURpHhGEf81JhqWPxZ+xkRRFAMCbOcmPiTGQ+ZVHO35a2lbUzzXDQs6qr2b6YnqedVI6i79keglwhotS5vEzG5bRQlK59Xw1g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199021)(8936002)(8676002)(7416002)(86362001)(44832011)(31686004)(2906002)(66946007)(66556008)(66476007)(4326008)(316002)(6916009)(478600001)(5660300002)(31696002)(41300700001)(38100700002)(966005)(6486002)(2616005)(53546011)(6512007)(6506007)(186003)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDE0bDk1R1VmaEM5QTJ3NllGTEhSLzQ5M01LUmtETjMvd0tIaHBvQXVPYzVL?=
 =?utf-8?B?NjhZYVhJbUJ5R3o0MWZUditFS3pMeXdEMWgwNFRKWVVoTm1jckd2bU9uYXdI?=
 =?utf-8?B?SDdKUHdrcWo5R1JDdFNaQUtVTlNjbjRONlc4WGZwQUZaSmMrd3ZGRXkvUnlC?=
 =?utf-8?B?V01reUp0MGFqZUlXTUoycUxUOGoxWjRnMmRISzcwOHhmNUpyYnFQaFlqeXB0?=
 =?utf-8?B?ZnE0R003R3VSZWtpd0xhbHV5Qm94cWRPY3VOb00yWmU5cG1LRGtkQURrYkVK?=
 =?utf-8?B?c1prdE00SlV5ZWhxVFlTT0ZkVG1nbWVBRDBZZnRwUmpkZEFvajM0dWJQdGJF?=
 =?utf-8?B?TFR6bVZpMnNWVzVFVXVaM1pLVVVpSDVrcEtjV3FNWXVCTkFsb2E2VGt1SHZ0?=
 =?utf-8?B?OVkrdGM0M3FtUVZudzJzUmp4UXNUZWVVNFB2cFVjbC9HdjVIZVJ4U3paQyt5?=
 =?utf-8?B?MTNlYnNOSWY2TlpkTW5rVzNJVUZOSlczTUNVYXRsNnBoQi9aQUxrbnpPUGc2?=
 =?utf-8?B?azNXeU8xQUZzSjcxRmhKdTBWZW5aV04wV2QwL2JiZ0tsTTF3MlhtaFMwYVR2?=
 =?utf-8?B?WUw4SGtRQkxZZzBTSUZlakNxWGtZZTRqcElrdUpxbDc5VmZoZ3hSWnZZQUVT?=
 =?utf-8?B?eitrcW5wRTdUazlOa1lpZit2bExSQmZCUXBITHJoRWg1bHBQTHdkUXpHaDB4?=
 =?utf-8?B?Z3Z0d1BKSmhZc0NnUUV0T1ZkcllkNXJOTkdCcmpkSm4xcHpYa2FFKzZWYjNY?=
 =?utf-8?B?ZHl1aG85ZVhaVUp4cCtNT1kveVBOZTd4WEVFN0xQT1dnRi9FcS9hNUJyWm9x?=
 =?utf-8?B?WjAxM0FQenZoNjhmd3FCWm0wQldVSnJLTkVRaldSQmpxcGpleWYrNUN2dmln?=
 =?utf-8?B?Q2xOVG1PMWs2MlFYN1FCOWgvQVFubmNDbE1xNFo4ZlNLQjRJdm81VmRaNEdt?=
 =?utf-8?B?THpiSzZXY3lmcG5XVUVWbWlwR2lFeTR1UGUya2FDQ1JvUlU4dW16THlmekVo?=
 =?utf-8?B?d1gwcmlrRFkzbkZFdmZnd01iaWEvcmUybUlLYS9qdzR6VGkxcXRFcFVFV01R?=
 =?utf-8?B?UUtzY0ZhSjJKR1ppQnpaTUlqUkswcFJNbExNOGt6QWs1TVFpbDF0eVZ1cUY4?=
 =?utf-8?B?d0pmWmszY1pwbEltcGgyeG9uRllQK3BWTEJnTmF4WWVBVDM0U2gzaVZpUkNP?=
 =?utf-8?B?RDlacTNNeWhZVi9CdEp3RHlNeHFmVk9wQmE4NEc0dS8wT05DZlpXU1ljYlJ4?=
 =?utf-8?B?S1FlazdYRkNJTjRFVmtYNGorbnYwWW01Y1JmSnJFYWQ0bWxKV3BqMVE4WXBl?=
 =?utf-8?B?NnAxbWpUWVRodDBhUTVQRjdzSlB4bVp4aU1kVFNLRlk0azQrTjM1cE1CME5Y?=
 =?utf-8?B?MUxHL0prREtuVjRETlU0L0V2SERJM1NWZHhnblpXQW5UNGdRUndWdzdyTjNl?=
 =?utf-8?B?VFBobGlUcDgwdWFpTXpTVis5L2x2Z0dIdHZaS3JLZFBaZ28xRm5lTVB0dEtQ?=
 =?utf-8?B?L20wMHpCcUJCT0lieEl6dDIyenRZQWJWM2wydjREMU5OcVQ1bm9NaTg0a0xI?=
 =?utf-8?B?Y2I1NXRhZHE2SlRwSWJBTWR3ZmVBL3d6elRkR1ZEamJpT0h6ZzJIZU9ZMGda?=
 =?utf-8?B?Y2k0OHJKdmFmQ2ZZMG1aZjlYNGg0K3E5a0xPR2JmRE9Rc0FlTHU0WFp4aU9F?=
 =?utf-8?B?ejlWWnRXYmNuWERuOUxzNDRBcWpUS3JPMEJyeXJoYWw0RFc3NnhPOFBjRWVt?=
 =?utf-8?B?M0htV3dDM2paZEZxZHZsWjRZZjNaRnBlWUZRb2psOHB5ciswKzdzL2xYQlBz?=
 =?utf-8?B?NnBnUTNSc21mdVJRVzBkZyt4Ri9pdm5Sc3c3Q09pZmlYZWVMU3FEQnF0WkxP?=
 =?utf-8?B?S2lSQjNxRGxYaTBWUFZDM3JIUXdkS2lVcDlhTzBUampHVGFlM25rMmJ5K1ZN?=
 =?utf-8?B?Q0VGNzAyRXp4czRxUVI1ekgwR0hKem10YjY3ZFdzdUZwaW9RSWMrQTM4Q0tD?=
 =?utf-8?B?bWdtVUhuUVByMVJMUG9vWTMySmo5YlBNdEI3U2U5UDNYYVlIQjBHOEp6SFJ0?=
 =?utf-8?B?aU5vMjkrY1lIM2JTVlZIWDEvQ3ZRN1dDdkhrSzJBV05QUUdwODRZdy9hRkxL?=
 =?utf-8?B?Y3Z1c1ZENHkxQ0E5bnVpcEhEeVFVMHR6Z3JLUlY0OWZ0Z1prM05YVnZWQUk0?=
 =?utf-8?Q?sceG3iK5FINUDChLj6cOXP4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?azVXU2pNMmpYcVo0Wkk1cyt4Sy9FdU9kcjFJOU91a1BnRWkvNW9uS0xKS0Yy?=
 =?utf-8?B?QUJHMG84NnFPRSt4bnUrWW84L3hrU3pEUWpUVHdNT0xrdWJNTTQ3ZjRueW00?=
 =?utf-8?B?T0lJSVRWOXdlWkMwdHdUOEpLbmVCS0JtMVJacUZiQjZDOG1nR2NYUUxvTHc4?=
 =?utf-8?B?bEtnNXhsTjljRG44cjRMS01CYlJ6aURjdkhCbWF0Tmw5YTFSc1REK1NBZUhk?=
 =?utf-8?B?dWQyRWwxK1dkVi82ODRCMW8yWXR2RzRKazZoc01Cd1FtOHpYblhJNG5pVEM1?=
 =?utf-8?B?L05vcXF6UUpUeVA4YkhKdXJaVWo2b1dTK2I3WEpIYjVGOWhzbHoxazM1NzFq?=
 =?utf-8?B?SW1pdGsrNC9IUDBuRWx3eXYzaUtLcUp3TEdWWXd6YUhWcWM2aHlpN2VFMGV3?=
 =?utf-8?B?Rk5KT2tzVitOemt1TXlQMlcrOHZ4UGtacVhvdUV0WVhmK2Npd0M3YmkvYWNz?=
 =?utf-8?B?UTRwcStrc0hTeWQwWEVGVERaU1Rsc095dzFZOTY2NTZYNkpNUEJzYlVsZjJT?=
 =?utf-8?B?R3gvWnE5bGNJRW85UzhncCtMMW02eFZsYUpzS1NDcUNsS2xyblpramlqN0Iw?=
 =?utf-8?B?eVJRQ2oxSGJtUGx1N25PMEdEd05TcjhSOFVFS3M4ZjZFenYydlpFeEZJb3V6?=
 =?utf-8?B?cndkREFCOHord2lFV3Y3TTZpYWdJYjNRTm5BTGtBTUF5R0daVkx5dVdZT0pu?=
 =?utf-8?B?NnZQSThER0FKbERMTmFGQnE3L2FGM25MNjJtYkI0emhLL3pUVG44ZU9VdEpT?=
 =?utf-8?B?cGJDRnR4T01oZWJBUFNYcXBWSlpyOTNYN3NzY1lPZjEya3hwWXNtMElSc0tw?=
 =?utf-8?B?a0JrNkI1ZWpSclFJQitMc0hrZXRpNjlaZDdSRFBGSHZ1QXJwVkVHdnBCc25N?=
 =?utf-8?B?UmI4ZUM1WnNwMlRRYVkwUnN5RFBoQlA3M000am92cUFTMEoyb2h0MFpzZE9r?=
 =?utf-8?B?TEVsTVRrSUlGUE5kWGY1cmhSMjFoNkx3N2dHYXBpaXpBQWhrQmlLWGs4RnpC?=
 =?utf-8?B?VmZQcURDQjJSTjUzd3Q1WGVPenNqODZJSDBFTEl1eFFWU3VMcG1lR0dTeXd0?=
 =?utf-8?B?cW1Hc2xlNDRRWStRMHludmVjbXJyelFKVzExNG4zbkR0cHVRRXNqQ2k1eDl5?=
 =?utf-8?B?dGhpVUdiUndLQVhrYUE2T0FHLy9LK3l6VDNYZnZrOXZibDZkWXEzL01TclNB?=
 =?utf-8?B?dzRuQ1VIdmlJWEluV3NLbjFoOFF6Rk95ckFmVlhXYmtIRnNGZHRDN2JCQ3ZJ?=
 =?utf-8?Q?baKwMkn/zNaHiko?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39df269-477b-4f09-f0aa-08db587b152d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 15:09:46.5501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qyy0mBp6SsC+cSWxFxjgNXOvJ6oa7cv7N8rvm1s25Tl0i+47WciemIdfZuEnYOPPwYBXTQWXQmL0UfCsXJm3SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_10,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305190128
X-Proofpoint-GUID: 7ybqN5UP9X0n55KTdkXUfii3z_fAiTN1
X-Proofpoint-ORIG-GUID: 7ybqN5UP9X0n55KTdkXUfii3z_fAiTN1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19/05/2023 10:44, Yafang Shao wrote:
> On Thu, May 18, 2023 at 12:18 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> As a means to continue the discussion in [1], which is
>> concerned with finding the best long-term solution to
>> having a BPF Type Format (BTF) representation of
>> functions that is usable for tracing of edge cases, this
>> proof-of-concept series is intended to explore one approach
>> to adding information to help make tracing more accurate.
>>
>> A key problem today is that there is no matching from function
>> description to the actual instances of a function.
>>
>> When that function only has one description, that is
>> not an issue, but if we have multiple inconsistent
>> static functions in different CUs such as
>>
>> From kernel/irq/irqdesc.c
>>
>>     static ssize_t wakeup_show(struct kobject *kobj,
>>                                struct kobj_attribute *attr, char *buf)
>>
>> ...and from drivers/base/power/sysfs.c
>>
>>     static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
>>                                char *buf);
>>
>> ...this becomes a problem.  If I am attaching,
>> which do I want?  And even if I know which one
>> I want, which instance in kallsyms is which?
>>
> 
> As you described in the above example,  it is natural to attach a
> *function* defined in a specific *file_path*.  So why not encoding the
> file path instead ? What's the problem in it?
> 
> If we expose the addr and let the user select which address to attach,
> it will be a trouble to deploy a bpf program across multiple kernels.
> While the file path will have a lower chance to be conflict between
> different kernel versions. So I think it would be better if we use the
> file path instead and let the kernel find the address automatically.
> In the old days, when we wanted to deploy a kprobe kernel module or a
> systemtap script across multiple kernels, we had to use if-else in the
> code, which was really troublesome as it is not scalable. I don't
> think we want to do it the same way in the bpf program.
> 

I think it's important to distinguish between what we do
in libbpf/kernel to ensure safe attach and what sorts
of tracing capabilities a tracer supports. For example,
a tracer (or indeed libbpf) can take the set of different
instances of cpumask_weight() and because they all have the
same BTF description, can attach to all instances. What we
lose though by not having address-level accuracy is the
ability to do more precise tracing.

I also don't think matching addresses -> BTF ids stops us
having file information in the mix; a "struct btf_func"
could potentially contain a name offset to a string
specifying the file too. My concern though is that
relying on _just_ the file/line will not be enough
in some cases. There are some weird edge cases in the
kernel. I'll give an example where file/line isn't
enough to figure out the mapping.

Consider 'struct elf_note_info'; there are two copies
of this in the vmlinux BTF:

[16819] STRUCT 'elf_note_info' size=248 vlen=8
        'thread' type_id=16817 bits_offset=0
        'psinfo' type_id=16815 bits_offset=64
        'signote' type_id=16815 bits_offset=256
        'auxv' type_id=16815 bits_offset=448
        'files' type_id=16815 bits_offset=640
        'csigdata' type_id=6083 bits_offset=832
        'size' type_id=74 bits_offset=1856
        'thread_notes' type_id=21 bits_offset=1920


[16851] STRUCT 'elf_note_info' size=248 vlen=8
        'thread' type_id=16850 bits_offset=0
        'psinfo' type_id=16815 bits_offset=64
        'signote' type_id=16815 bits_offset=256
        'auxv' type_id=16815 bits_offset=448
        'files' type_id=16815 bits_offset=640
        'csigdata' type_id=6507 bits_offset=832
        'size' type_id=74 bits_offset=1856
        'thread_notes' type_id=21 bits_offset=1920


...and here's the structure itself:

struct elf_note_info {
 	struct elf_thread_core_info *thread;
 	struct memelfnote psinfo;
 	struct memelfnote signote;
 	struct memelfnote auxv;
 	struct memelfnote files;
 	user_siginfo_t csigdata;
 	size_t size;
 	int thread_notes;
};

The reason there are two copies is not a dedup failure;
in the first case user_siginfo_t is defined as

[6083] TYPEDEF 'siginfo_t' type_id=6082

while in the second case it gets defined as

[6507] TYPEDEF 'compat_siginfo_t' type_id=6506

The reason is include/linux/compat.h was included
in one place when fs/binfmt_elf.c was built and not
in another when fs/binfmt_elf.c was built the
second time.

Because the object was built into the kernel twice,
as well as having two different instances of BTF descriptions
for the same structure, we also have multiple different BTF
function descriptions for functions that use a
"struct elf_note_info *", and we need to figure out which
maps to which kallsyms instance of the functions like
this:

ffffffff81489380 t fill_thread_core_info
ffffffff8148ca90 t fill_thread_core_info

Now, which BTF description goes with which instance?
The file/line number is identical for each BTF description,
but the BTF is (correctly) different because the object has
been built into the kernel twice and is slightly different
in each case. The difference isn't significant in practice here,
but that doesn't mean it couldn't be in other cases. Imagine a
case where one instance of the structure contained a field and
the other didn't; we'd be interpreting the tracing data
incorrectly.

I realize it's a weird edge case, but that's just one
I found from digging a bit. My worry is if we go with
the file/line as a way of identifying the function,
these sorts of edge cases will pile up and we'll need
to go more fine-grained and use addresses in the end
anyway. Again, that doesn't stop us applying higher-level
semantics at a tracer level, but we need to build those on
solid foundations.

Alan

>> This series is a proof-of-concept that supports encoding
>> function addresses and associating them with BTF FUNC
>> descriptions using BTF declaration tags.
>>
>> More work would need to be done on the kernel side
>> to _use_ this representation, but hopefully having a
>> rough approach outlined will help make that more feasible.
>>
>> [1] https://lore.kernel.org/bpf/ZF61j8WJls25BYTl@krava/
>>
>> Alan Maguire (6):
>>   btf_encoder: record function address and if it is local
>>   dwarf_loader: store address in function low_pc if available
>>   dwarf_loader: transfer low_pc info from subtroutine to its abstract
>>     origin
>>   btf_encoder: add "addr=0x<addr>" function declaration tag if
>>     --btf_gen_func_addr specified
>>   btf_encoder: store ELF function representations sorted by name _and_
>>     address
>>   pahole: document --btf_gen_func_addr
>>
>>  btf_encoder.c      | 64 +++++++++++++++++++++++++++++++++++-----------
>>  btf_encoder.h      |  4 +--
>>  dwarf_loader.c     | 16 +++++++++---
>>  dwarves.h          |  3 +++
>>  man-pages/pahole.1 |  8 ++++++
>>  pahole.c           | 12 +++++++--
>>  6 files changed, 85 insertions(+), 22 deletions(-)
>>
>> --
>> 2.31.1
>>
> 
> 

