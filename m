Return-Path: <bpf+bounces-6546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AED76B3B4
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 13:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971591C2084C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 11:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFD7214F4;
	Tue,  1 Aug 2023 11:40:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B496A214ED
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 11:40:42 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C461B0
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 04:40:41 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371BBAtZ027071;
	Tue, 1 Aug 2023 11:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gAyAx282zE+k7yplqcnbwHiHeZd8tQVMzt3Bd32DQnM=;
 b=ZDx3feuZtceGHt+Jhh5x+njeAHB3JsVQ465pMBe3tOg2bpWjbkZidoQW/A3LyRvz5Jj8
 /6ROTHyDqHOOmyoR++vG43PofNWo3XKrJAdbNdS8ip5uN3EYcpkwIJDv9y4VzCPS+pEu
 aXIVipEbcooISUSpOe2rVpGZt1w5+d0TP+PPkn8xrinXC1DtHrvDQv8MwZAH+tveWV4Y
 0QdR9HMU/v8IV5URI12J53SMRImbgdlPLi1Um+iOUov6d6K+VUeHkHeOyvpjGJ+4RsEH
 NCvWIf1qMkhW0YWP4ML7f4xgWFDEEI/n2r34NoM7sCMRrU+z2cz6Ynlc8pCO8g7FM8DA Dg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tnbcpbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Aug 2023 11:40:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 371BNUHU000641;
	Tue, 1 Aug 2023 11:40:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s767vn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Aug 2023 11:40:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqPsmx/bQHKyFyouwuUlFxmFHa20OmDRIlWm/69e4aqZL6nPJsNEqL4BzWada1TUYvJ407Ybmavb7rZo+7h9ZVvrpSWe/U2vsbwmXYgt8pP1UxD+mnP8a9rONUe2LP6v8Be2OrjheQP/2tbSaqL2+boXJzc75GayGl749nRPU3Zo61H41UPsfoFB7VPfRvC/JKX0hfZ8f3mVpdtERUNBH5Iz7m6KNPL+kh1JP3Ptpkxa15Jykx+V8AV6VDXjb/qWcvjaa0J76alaYUVmf8zfhiASPHttpgc5ocQeRrcHaFvgbGaVIv2tNs2WSRKhclkuzM4B7turmOLWaxl+WEV7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAyAx282zE+k7yplqcnbwHiHeZd8tQVMzt3Bd32DQnM=;
 b=kB5szd7vWmQ95xgyZYRuyOvKfbCrsLrvW/8wZSQq2obXAt5VLmKddX8szrPQ+g1iQnB8iFt6thnkEJmKKYfD71laIVjLzUoW7199DbB9p2lVybtXPP0MYryowtMSmIJgwuEN5PlUc+/tD5c/O0H0EBENL2sKf2N85DMuSanhfYchnmp+TIdASYqnGiPoG6KIm0uMIqs9rsW2H1DqU8C8rIeL/9PxsOuCwXhoIFoLQbZyIP1BOAZ40xicOke0LdmsKDM6/0pudqoAx5wnhvH0vRs+SCNisZ2eq1MDIl/DFBPHeGiEPFzfyXKJtxRUi9nG0c18D6b1Gs6+p4F/X7r9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAyAx282zE+k7yplqcnbwHiHeZd8tQVMzt3Bd32DQnM=;
 b=ntKG6gi2yobAh9KCsdC2uvyDD8Ni5kq0RpVLRSwzjiq8VkOEeAiAyO06skG8brAoRF78s3y8iYtNLp/lDI+Yph9UYxNYYMqoDA4nYR/wqmJ/xoHqHziY+mJHh21+9eDgtwpQFxT44jlSMcZ8/Q4h5RKsqYM70ITb2owluYmv7hk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BL3PR10MB6139.namprd10.prod.outlook.com (2603:10b6:208:3ba::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 11:40:37 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 11:40:37 +0000
Message-ID: <7cdfed88-761e-a2c1-c8f4-976af3997128@oracle.com>
Date: Tue, 1 Aug 2023 12:40:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next] libbpf: Use local includes inside the library
Content-Language: en-GB
To: Sergey Kacheev <s.kacheev@gmail.com>, bpf@vger.kernel.org
References: <CAJVhQqXomJeO_23DqNWO9KUU-+pwVFoae0Xj=8uH2V=N0mOUSg@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAJVhQqXomJeO_23DqNWO9KUU-+pwVFoae0Xj=8uH2V=N0mOUSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0577.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::21) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BL3PR10MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7914dd68-4b05-4f2b-ebfb-08db92841fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VijJwPpYZFHTVC/GcfJPZ0zV4UUn5497T3odvpnsBN5aG3978Tts2YJ+15LPjPJnWy/m0dWxBZXrSgX0m10zOG4p6OXxMnxB02QWAe2qL6YN7c1fONVnOjajpgIs3QuWTgSBuH5wwOCrK+6AlopFhbZlRP0AUS9PbwXYPBelRiMfPCXJHoZ8hrCTVft67ORzYYbuGMlJkhaUdovAsQ7ycloD/vamzWOqfg2W/R0xzqk+f5+J3ML7mgjThOTWkToZwbG6I4BWEFXN26+7EWPJxgiBslW1kKrQ2p4tclSHsbJK1R3r1yFGpM0zwNRn6/rjPPfRz6+k4OjDkKDR9GbEzuzEwDjYjHD48ysn4IbrC0zxsCuhx8op51XxSk1JK40/SCZ6KRedtkA3fJJu2ISrt1azBUxLE08yWQDERmoZMf7AvcXlYe+K8QQYt4ZSFaQm8IbAe7x4+tGOwjCZYUUV6dH1V71Z33/FkbWqwEV4f1ESGwc+2Ao3jln+oHmrHr8MknnjElIQ5pQwuHfxONDMWiG6fE5D5WT2xGYC9EJ1nyQmDN2Ajdq07c7cHYoYqAi7WkI4lE6id/OOaD2NFrXXsy0CQQM+OJ1s3ZPHR42UavXBUir4rI7zUvR2ala8TBTaFwjICk1dQ4P2+PCxG/QVXoA8Vcyo6FO5DUP972JChDg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(31696002)(86362001)(44832011)(5660300002)(8676002)(8936002)(41300700001)(66946007)(66476007)(84970400001)(66556008)(2906002)(38100700002)(478600001)(31686004)(6512007)(6666004)(6486002)(316002)(2616005)(36756003)(83380400001)(53546011)(6506007)(186003)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXFBci9ncmU0VndEL3dOODVEbVd3WHo5ZHM3S0hkem5SUU14REJ1a0xhNmVH?=
 =?utf-8?B?VmdyTmZhOWZoNnU5cFppZUNRV0ZFZzA5UCtJbnBGSXRQYytySnZNQ2xNOWtu?=
 =?utf-8?B?c1hVOXhJcGVaRkhOcW0xU293eDVpTFkwMTVGU0Zleit0Uk1LZ1MvQVYyVjM5?=
 =?utf-8?B?cEJvcWJVK1A4QUVlUC9lOE9zY1JLek5lbGN4RkRyeHMzOGtvaGp5Y2dVRDFH?=
 =?utf-8?B?RUxPV0FJeGJMLzltNk5sTktYdzNNMUR4MGcvZ25IM01zV09BVXE0YktPOVNv?=
 =?utf-8?B?dW9Sc1VKN3FUMXJTRDlyQkI2TWROSDFJUDRDZURoaDdoeFNlYXozdFdzZVQv?=
 =?utf-8?B?aURUcUJ0WVppekVlQ3J6cDhkcEk5M1dCY0pVaGlkaUpQaFY5N0NtUlYzeEVJ?=
 =?utf-8?B?cnVjNnZlTW8xNXNpL2lmZzlORFIzcEx2Q0QxTmM5VFV4ajY1b0RlcjNzUFNH?=
 =?utf-8?B?dW9HRlZMaHNjSFhEQzNubHIwSWZKOVJhNUtDa1NBL2J6SC9rTEZrRXdXblUr?=
 =?utf-8?B?NFBLdUlJNEtEaWRTaC9WNVBlZVFzamIzWHptRDZ3c2dsNGFMSklXbmJtanl0?=
 =?utf-8?B?azZmWjZjZEhHZWxzVjBSWW1ER0JHMHMxS1hteU9IWWFTVVpVNzNvV1BQVElN?=
 =?utf-8?B?UDJwTVJjQm40eUJPbHRVZlByOTNja0VhcXoyMTRXUXlFb0tJZW1ndnM0QnJ4?=
 =?utf-8?B?OXBKRGtiZzMzZUY1U3BhWkp0SnRaU2pvSVZzYlJEbFdmRHdOakx0VGFlb2ox?=
 =?utf-8?B?SjltR1ZGM215OEtrWW9uM0JLcTFqMmdIL1hEckhZTlZKenVhYmVYMUg5bGZK?=
 =?utf-8?B?Y0JVVmJIOEgrL0ZFWjFjSytxcng2SXdpNlNIYXBDTDgvWGlzendwTjlhaDZX?=
 =?utf-8?B?NFdvSFJDS0NzV0hlRy8rZXF2cmF6SnNQMXIveC9ia0pwWjJaMzJianhGMUNt?=
 =?utf-8?B?cVRJMTZWWEV0QWNiNTJrQUdvdUNLZ2Q4T2VXc2ZpN3FCZzMrWmE5enR0eUdt?=
 =?utf-8?B?ZFFUNmw0NjFtZzVEbGtkTnFYNjcram1hMGJZM1BZQk5aRnpaMEVCQmlxS3hF?=
 =?utf-8?B?NitZTnhUTThrb1N2aml5aWRROXN2bis4L0VuZGJxQnE0R1dYTWVaWDdUM29H?=
 =?utf-8?B?VDVzb0NJdFRhNktzUE5DZ3ZlMFJ0WFdaTytyVjZ0cHJMcGNwbm1jeC9rUUhp?=
 =?utf-8?B?dXlhVldWblJ0cDJCYTRQVzF3ZlV6UlFGak0yTnNvWjRjYlFNWXYwaWZnRGpu?=
 =?utf-8?B?WlJNdUNPSnpaemZ4ZXhaY3FpdzY4UURtV0ROSS9ud2RsRHQyK2c0ZDlFd3RQ?=
 =?utf-8?B?bkdLQTQrc1IyNXF0cFZVV0taUEhhNjVxeU9ERUFXT1MxQ0xZQzlRTitFM28x?=
 =?utf-8?B?TWp2c0oxUHJuOW4zem1mMmlrT2dYbkxDQzIrak12cjlrc291ZHFIaFVsbUdH?=
 =?utf-8?B?RVFzY2FMc3YxcVpUcnZpVDlmL2tWaGo2QWxKd0lSWUxZSDROakoxaVBETzAw?=
 =?utf-8?B?Vm9lM1IrQ0duR1lYek01dkxOcE9abHAvVHl5N0oxcFF0MUFBOHBFU1U1SUJW?=
 =?utf-8?B?Q1BuRHllRGl1RVBsWmZHakZTVVJjaGlUQ1lqR1AwNkhhVEpRNFhPRThINXhF?=
 =?utf-8?B?V25LVWNINU1hMkppaUpNeGVlZXB1dXhHNEJuWW1zeVpoSjF6N1BFdkJiOGs0?=
 =?utf-8?B?a3dTdnJNNzF2a2U4dTRBRGV6NTljdGVJUjBaVm42MW1rWFRjQzZITXAxdVNS?=
 =?utf-8?B?SXU2WXJMb0tGcGtUdU9TMzIxcEZWdnI3dzFjVVhWWWVGMDlSaTJYSENuY2x3?=
 =?utf-8?B?eGZxR1V6V1Z1U2JuWVdzWUNHYjlyZ2hzbGFqSnY1YXptWGNIK2NLaitvVUJl?=
 =?utf-8?B?c1VzODJwNUxqb3ZsdG80VUd2cUpKMWdkWndhMjlTZWZ6UWprSk1NbEVqWGVk?=
 =?utf-8?B?OVhTV1ZjSHhhbnlSQ01KenFUWFdrdFZRRk5oRzAzTStibXE5NWZFM2pZQmpj?=
 =?utf-8?B?UjI0bktMbDBDRzFjWUp1VEZDcDJXSlRuVmNEQlY3MWdhVHBUV3FGdnF2ZDNJ?=
 =?utf-8?B?c0IxcytGUS83ZVNKZFE3SUgvM2dqMW9QY2hUV2hCa0hHSnNjWElMRGlSUjk2?=
 =?utf-8?B?R2dkNU5kRHNEd2pxelZSNlJXZjdxaE4xZmFoN3FXNDAxRnRFaWtPeWxPaHhy?=
 =?utf-8?Q?EoR8spZwsZnwPAYMpE0/scM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OSHT0D73HkGdJ/jJK2f9HBBlilocm7/U9U7kyr+8rrhdpoR/eferFFgrhiMrejtZ2sW75YdQC23wIQaXlfhUdkvUAULkWXTuR66vvHlfh8Q8dHKNfZwQ1pH2iiiR+jr4zaZI6NsKTOggsrzf/nNsMZ+2/L7avGxJcX1ocaA6GKM9d63jwY5UclihaQ0Kk2w+7ha7ehIepBWHTeEeiA//X40USDdVcFmmJZD0eyUA7hptzJA+jjlu8kSKUyvwnoR9BijFJ0XxQO1ujaxhhlLhLL3S2x6D4ibWhp3l5uhwTzful39PGA4P2y49ikmvxDL6ww3dLGR8zixE2/ZOIVTXedBKkrXMZNS/9ZYz7AJtl/Jn2dMqMcSGNhOoF7FE1hjojhs8KTMI8TJz5GCmKbatol35c0Z6/e3DMNJ18pedlO4CtGUg87Om9P6dLqALq2WQSEXkbB86Y7HjuxAuQi0Eao70ERhPTY152TmyC01JjZFbyvWv2IjtT7QYN/qyfl7nZz/7oLtDRgTqSt2nOnrRBAyhM1dC1Lr2egzycIe87jGiDHhFHTN6TF7BiS9X7nFJpduTCmoToWBAEsQaNMM5txZUfNQYRtkpD3r1VwthWZb7JA3aJcQ2UloaaJdiFZMXVYYg/3wbticxTgiIar2bmACUhgujZjfv5jwYzQax6cFWK+/nL2CAN4mG1kzHd7K2iXVskOASrhmO6KSIRj2GjUqsESacEYl/0mLVQsZVjZrzopb+0F0edFKCuT6TYEbKtroPUNIVGCSOkZMzUcY21ZgEfclfqeHgQgWgDDLYU/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7914dd68-4b05-4f2b-ebfb-08db92841fcb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 11:40:37.1646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONkoxShs5lcbXXZE6pgHRmQLokqFh9KTMyZalDjKTqEI8hhNPDSA1xQFVpU6OaDPBYsyMZiUwhw5GMuy72VdLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=777 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010106
X-Proofpoint-ORIG-GUID: tnWx-nll4ScUmBWLDcdHMSQUMlnQAhX9
X-Proofpoint-GUID: tnWx-nll4ScUmBWLDcdHMSQUMlnQAhX9
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/08/2023 09:38, Sergey Kacheev wrote:
> Hi!
> I found that there is no way to include library headers without doing
> PREFIX=<some tmp dir> make install with some prefix to try a new
> version of the library, this patch fixes this. Allows importing
> headers directly from src/ аnd it seems to me that this does not
> violate the current behavior.
> 
> Use local includes inside the library
>

This looks like a patch against github.com/libbpf/libbpf
The github libbpf is synced regularly with libbpf in the bpf-next
kernel tree, but the bpf-next tree is where development happens
(in the tools/lib/bpf directory). You'll need to submit a patch
against bpf-next libbpf code rather than the github mirror.

Alan

> Signed-off-by: Sergey Kacheev <s.kacheev@gmail.com>
> ---
>  src/bpf_tracing.h | 2 +-
>  src/usdt.bpf.h    | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/bpf_tracing.h b/src/bpf_tracing.h
> index be076a4..3803479 100644
> --- a/src/bpf_tracing.h
> +++ b/src/bpf_tracing.h
> @@ -2,7 +2,7 @@
>  #ifndef __BPF_TRACING_H__
>  #define __BPF_TRACING_H__
> 
> -#include <bpf/bpf_helpers.h>
> +#include "bpf_helpers.h"
> 
>  /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
>  #if defined(__TARGET_ARCH_x86)
> diff --git a/src/usdt.bpf.h b/src/usdt.bpf.h
> index 0bd4c13..f676330 100644
> --- a/src/usdt.bpf.h
> +++ b/src/usdt.bpf.h
> @@ -4,8 +4,8 @@
>  #define __USDT_BPF_H__
> 
>  #include <linux/errno.h>
> -#include <bpf/bpf_helpers.h>
> -#include <bpf/bpf_tracing.h>
> +#include "bpf_helpers.h"
> +#include "bpf_tracing.h"
> 
>  /* Below types and maps are internal implementation details of libbpf's USDT
>   * support and are subjects to change. Also, bpf_usdt_xxx() API helpers should
> --
> 2.39.2
> 

