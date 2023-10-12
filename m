Return-Path: <bpf+bounces-12027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AF37C6E40
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 14:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621291C21110
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42E25107;
	Thu, 12 Oct 2023 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KvVjaDkM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dwfv5rAc"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5D208D5
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 12:36:21 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D86D3
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 05:36:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C92TFS018005;
	Thu, 12 Oct 2023 12:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=E7diJNFRd/Xk4L8X0BrGRr/tLOMKHEJ002LqzlAWA08=;
 b=KvVjaDkM++gpSJ3X939oT9xRejwQld92cTcXoO2oFDg2ES+/izuMt8nNllhiEtnNqyyx
 4TSMGcqm8d6UpAZ5odMldzJPsQGflVZaK0hWossyg8WESiIvOnZn3nBCJPrNIctW1xxe
 HPpUSOLqvxZJ36TJFIn5VlxGf0oV/za2G0PSqDSqMq6ZBHYieKWspr8IIxXqXk/Wt8nY
 kykcIzakZi7+th/q9Zm6nlhRHaKSt4a11DaqHah9e/UrqlgKlMwHIk8h20ifhAZLWe1p
 jwqTb8nHSLo5pI3++9AeVZNUwDu71VU3zkra9ZHUNCF4mXzFb6vtZ/gNQCT5AdZMFnjL jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvutnmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 12:35:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39CBidrB034816;
	Thu, 12 Oct 2023 12:35:49 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsa96wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 12:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1XJorV/ZJdVfgB2MpKd/mURf+AryC2htTHBL4pos1qIHU2GEWxNs1luXVd1+wXrsiJwWimJD0JV9Mg3mCwynaAMqOsFOfyz5NXn+uwcC+iXFg0P/IByBFQYdzbuk09pTBrhCXbSMubMp4/0Xa2qy8EMbicAfojYTAWaSzPGadKcjuzIIH5/cych6NfRRVd5x5vQ4Wn4hCu8UQy5uTKuX1ujNOIV/pb6q1TEAXU65/hK6FcFH3US0o9GYuexzYBuFNk94KQmqt/itZBumz0tm6llXP1YXGeK3Vr4rG7APZPubxm0sunXCoCX1TtCE/Os1aDqIInkarBnWIckf1Bdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7diJNFRd/Xk4L8X0BrGRr/tLOMKHEJ002LqzlAWA08=;
 b=CpSsws/CHiiz6OpO2GUV+Q9DnlvhisSNX+pXv1xJbibUIFktmGSr659GtUv1TicPkD6lpmg3Xaoivrc+TzEqcTlzcEbUYNO6Vx55YopsQNndCjkaMKdNp9pElanpfgWm6a+f79X9XUxlJ/DML2N5u2dSdi23Y0erHxgjENLrweEeqvb82ba6RqQHOdhanDNZGDs0Be0Lv9AekN+l9wcq4vhShQt0+0mqPXvQGKFdGScGEt2uL1lqOO7t3Eavc1Gr3K8nW7+tF0VToJCG91Ot7kcwq998DnsdkDfMhNsPY1llGpMknPFx68k/pYXzmAhdiXVLnUo6qT0cziE4HEXw2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7diJNFRd/Xk4L8X0BrGRr/tLOMKHEJ002LqzlAWA08=;
 b=dwfv5rAckwCeBnkX/V03wxl8LzV9Vg+7rt+XqjTJT1eGIKHTlm/9naSiYr/3I0tVQglT/WLo6adSUy7BR3U7HjstDJGH4t+Q5NhTzl/n6zuIStnVq1qNPIDDEnlr9upS3YW29NP8IfG3Us1ens+dABs+8gWkQk0UDmy4M3K1ZvU=
Received: from CH0PR10MB5276.namprd10.prod.outlook.com (2603:10b6:610:c4::23)
 by DS7PR10MB5344.namprd10.prod.outlook.com (2603:10b6:5:3ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 12 Oct
 2023 12:35:47 +0000
Received: from CH0PR10MB5276.namprd10.prod.outlook.com
 ([fe80::5b90:1cb6:408:90e3]) by CH0PR10MB5276.namprd10.prod.outlook.com
 ([fe80::5b90:1cb6:408:90e3%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 12:35:47 +0000
Message-ID: <401a9b36-9a4c-db0a-272c-e85eb31aeccd@oracle.com>
Date: Thu, 12 Oct 2023 13:35:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org,
        andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
 <20231011091732.93254-4-alan.maguire@oracle.com>
 <b7b61031f41ab4082205ed061bb66cb859bd1f0d.camel@gmail.com>
 <f822334f-335e-bd38-09c7-95c69086ba6f@oracle.com>
 <5b40ffbfa5949c24dad44ed6adf70d35cf72f757.camel@gmail.com>
 <7b4ff1c8-f8c7-b96e-c581-f27a389379f0@oracle.com>
 <07a9eb9eaa6cd424ac5025f76ea620eae6062c54.camel@gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <07a9eb9eaa6cd424ac5025f76ea620eae6062c54.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::8) To CH0PR10MB5276.namprd10.prod.outlook.com
 (2603:10b6:610:c4::23)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5276:EE_|DS7PR10MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: acdd765f-f0c7-4b50-59aa-08dbcb1fc22a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MWAJZYiAblgJxhhQSQbb1TVC7IkzLldjdCDmoizP+JR8IBFBfi0nslMSdI1Lp3KesRPCdyOz5zl1qn2PU1anolerPR/Ken/9O97uqMYIeBA3SBLbHyWk+prXj1iGmze1lxb8tEDZDuKIeyPG0c2eG0j8XxLc4IaXMy2obci2fIeimPufmuUhIQgceGDVjUkx7HKHhPG8/GuXqEUejJMnD1VGb3LxjZrnJe2DBCMhRpx3BArEZGQWY7U1TH34wEM0SNd2ApmxccLMNSjqRJgjAL8IOGKKxAs3cCyhEDzxgEnVkUWLKhrq1J6fQouG82CQrNkKhIJ1cEc4yvQAe6dAIUFGAqxmudysSxOkgOdo0byJj2L9jGRXINylUxYD+cufbYxk1u93ol/KgWUQIB546KlZ+UDWq9YWzpa+0yKacIjBSQBHGkFDBJNXRE45sLMFLYk9L/CoxKpi3qSqMQ1CSn3QaBkyhQiZuttn06U+AEGp3UxdgnoLiO46Z3deUywYmVLkVkeTW6DNcJXZhrPWmMNh4a1L/55O7CZEliKJRMVlb/xDeD3gnJkW2Dr+a21nOeQaOnbuauAYzYAbD5/fNm2cvug4YSc73Cky5TXc2xuxppuRv7JHstxFYdCrO47J+vttw49rXSJnPoshuW5QdQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5276.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(316002)(6486002)(6512007)(6506007)(6666004)(53546011)(66946007)(66556008)(66476007)(31686004)(4326008)(41300700001)(44832011)(8676002)(8936002)(38100700002)(2616005)(83380400001)(4001150100001)(7416002)(2906002)(5660300002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YS8rT2JkRWpCczFHZ0tjTHY4WHA0blBJY0xKNkwwZlp0dWN0MmdYekl1VUdw?=
 =?utf-8?B?WkdEWkRNMWwzUG1kKzZOZncyVEpXOXhWU1QxdStSR0hGTzNNSHh6R3lNVXhi?=
 =?utf-8?B?WEdaQy93V2Y3VkFNZEJGT2gyOVQwbTF5Wkd3SlExM2tldkJTUXJSWS9VVEFi?=
 =?utf-8?B?Z3dWQ1h2eE42UFdVcUJVK3hPQjIyUk9RRFphSEo5b2lQdnI0emFiWWRvMFh6?=
 =?utf-8?B?ZGpqbjM5d3QyQlMzM0JDdXArUWxZdVpHT0NnNElZT3NXU0NTZFZhRTM5YzRt?=
 =?utf-8?B?NkY1bVh2dkhrUHBWaVlQV1Q5UmdNemowa25hU1hyaFpteFgyZzNvTEV5VFRa?=
 =?utf-8?B?a2xTVGZyTlVuUGpXTFN1eTFmbzcxMmpEY1Zuck9BNkpBb25HeWtWdkNnMWRS?=
 =?utf-8?B?MUNORUExUVpPVENJT2NvMms1TXpVdWIybVlhaEpoUnFKKzdiNFNZNnVTNGln?=
 =?utf-8?B?bCtrUmdkQm5vd29oaFJ4Z0pXbWFtUHF3QnNjZXlWcE1YUzFKMWE1WUdHODVI?=
 =?utf-8?B?WFRRRkowbDlaSFBSQ094ZGZQUFJ4ZERoN3hNbWVBQkljMFhzYkpTQ2dzMTNV?=
 =?utf-8?B?OGhoSnY2eDBubFR1NjhqL1hEcHo3Qk5ZRjJlOHZNMGtqRUZGVVhPeEdSVHYz?=
 =?utf-8?B?b3A3T1Q5b0grWHZRVStWcnRHYytpbTU5SDBMZGJxWVpVV1ZuMDViRjJNeFNR?=
 =?utf-8?B?Vm8vUVh6TTZPVWpERFJHZTNCdDgxU1VFK1RYYXJoUk04aFhObTFwRS9jUFpw?=
 =?utf-8?B?ajJMYlZlRExVazRyYUdEUXVlOUpaWTI0ZU45S2lDMldlaWpTc2JDL0ZTdE9p?=
 =?utf-8?B?OHZLd1pyN2xuR1F5QlBxY3dqZFZzRWZpOGxXUjRoQ3RFdGJRZFBYQWIxN0FJ?=
 =?utf-8?B?ZDJlRlZESHBORUwzMlJvQWNtcXkyLzB6YTdSSDZRMzMwRUdCeWZqU05SbEVw?=
 =?utf-8?B?RDBVczNhb3IyTlk2VE1icjVXdHY2ZWU0WXNYMUhKemUydHRRcjErRFhxVzlu?=
 =?utf-8?B?YnRmMTVHYml1Y1lHMWpFbGJ2bGlkNmlOR2JZd0NFZUQ0a0FmZ3FSdnQ1NXEv?=
 =?utf-8?B?T1phSDNWNjZzbW01YzRtMGhyN254MXZwenlCU1NVeUF0N29DZ2RNeVFYQ1ha?=
 =?utf-8?B?ZzgvUmVmZWhmWGxSc2FLOSsyT01ONDRMTGIxTDN5dXJtQXJZZTAydnJ5RW5V?=
 =?utf-8?B?dkR1U3JTbnZHS20rYmdyYkk3MnlnSHVzMjluK1hqVnNrV0I4cFlhcmZteGZj?=
 =?utf-8?B?Qm1OVENIZG9BZWtaTk52UndCckp0czA3M2FpZTJoMTZJNklIdGhVWFBWL1Yz?=
 =?utf-8?B?MVYyc2hsdlNMc2hUaFF6ckxYcWQ2cXk1ZTRTUTV1R0ZZbUxPbWp6dmlOS2dY?=
 =?utf-8?B?ellVT1NuTk0ybU1jUWRSRnBRWld1SDE1WlRUbVA1c0ZaM2UvVm95OFo3dWVk?=
 =?utf-8?B?a1ZrbGJpb2xzT28wdk1aMm5LM3h2eGNoRnE3T3hrbzA0TytEV2hvbWV3dFhU?=
 =?utf-8?B?VFB1RUN4RUh0ektDTFFjRHhRZUJMZWhoWEs5UUVSWjRaWm03SEtrcVlsMWNh?=
 =?utf-8?B?QmN4d0NRNmFLbmdlNzUzeENaSlRlQ0tsZnZuL0t3QmphWnpFVlJiRytBTVBv?=
 =?utf-8?B?eXNpTEcwTFYwZWVjbGtBOWN4NnA0RmlQdjUyMkFKaDduRWRKOFhMNVBjbWtr?=
 =?utf-8?B?ZURoT20vb1RMNGwrdlFMMVpFdStWL1BDbVZsazNyOTJ1ajZSL2o0YjlLNWVu?=
 =?utf-8?B?RWp5d2U4S3ZhR2NibFF6QnFLb0d4R3dIT0VsZlpKVnR2YVE3UTZRSEdMNWdq?=
 =?utf-8?B?a1ljOWlGSUQ1RUF3UndhcFRvNkkrQTFvK3Z6bWlWaG5CRTRRU2tLY083anFi?=
 =?utf-8?B?UkRRa1Q3UFJ4RGRJR3NwNGxzY3UvUGtCdjcvc054SUc3b0VqN3lnQi9lbkZE?=
 =?utf-8?B?bXIzc01sMzhkaXV0cVB1bHlRbi9XamVod09rTkJUSTExUjNOT2lObnFVUzcz?=
 =?utf-8?B?bjlaYzBtdDFGYWM3RVpQb1JzOUlUeWVkekgyQktRMXVOaWJuaVMvT2hCWUhT?=
 =?utf-8?B?czl3TGdDMDA1UVorRmhjcVdZdkw5d1ZvZEtXL0tXcllaNTVEQ2lyS1UrVUsw?=
 =?utf-8?B?NVZNOTY4blAxc3VLREJad2U3eTEwWXdFMTBVQXdkR0oxUjNuMW40a0MyeWg0?=
 =?utf-8?Q?Uw4CgtUpJoI+AR1GrbCMUyc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RDZ3dk5kZi9kUmZHL0ovMVNwMDlaNDBMYmNQOGJoS2ZMSTNYSlFKRnErZ05q?=
 =?utf-8?B?WWNNVHNKN1N1aDk4OXVCWGNkT0huaTVTVkJyT1ZtK0JZd2JrQVZnOTJiaEo0?=
 =?utf-8?B?ZytSTktzVHdTWVo1TkhzRHZuTmtQbURQekZZbnhSNUFtQnhYNXhaWGVzakt4?=
 =?utf-8?B?SUlBVVVGVGlXMnZkZk1xK05SM1JsMzZiQWhNYlNLU3FEQy95clJiWCt1aHNv?=
 =?utf-8?B?SEc4b0drVjM1eHBKbkF0Z21JRG12OERBc2RqU1psRUNzNEdkdnYveFh3QWVP?=
 =?utf-8?B?T293TEhNYk1uYjF2N1dRU3BxRzhSclZTeDVmb3VmS1djd1JVV0d3V1JaRXBX?=
 =?utf-8?B?czlLbzNYSmhIU3ZOMFZ6NW9lRTcyWmhTeEdxOW52bWJsYzdDdWttcWpyc1dG?=
 =?utf-8?B?bHlidTIwUHkxaUtkZUFrb2RxeUM2M2p0NCtybmtOQ3Nsa2dMNDFySHYwR1Zj?=
 =?utf-8?B?dk4rRmx6NHlVcDJqa3FBOWVyUDdYOExnUWZWSlg2anZ0UjdTNUpVcTRQT1A2?=
 =?utf-8?B?RHU2OHRhbndIR2h0anRsMHRWWUIxK3p4clBJZnY3WWlnT2w5VXQxdHBkRVFH?=
 =?utf-8?B?cFRuaWxFb3Bwb2NQZUg2Y3pUWTZQZzhTbER3Y2RjOE9RTll0K0Q1ZGR1c2Ra?=
 =?utf-8?B?T013cWRSRWk0MTF3cytXOWtKVnlkTGE5UDB5eVJGL3MydDZHNks1cFNNSXBT?=
 =?utf-8?B?S3ZNV3RYMjBuMnI5WURlZ2UrcVg4K2VLU29nSDZaeElIOGFUWkF0ejlKMzE5?=
 =?utf-8?B?Wk1CWkw3K216TlNHdUsvdFRHaFpqWVkrQ3ROMW9CU1pKRXZGTDN5RUVvT05t?=
 =?utf-8?B?aVE1ZmFuOEFjSVZEYWJKbzVMOWV5V1pYK1dZUko4U21PWnFmOXl4WnFRUXpO?=
 =?utf-8?B?Zmswc1BFdVIvQ0VrdGNSbVNEeEMwNndTZCtDY1I2NzZicFVMQ0N4d1IvVkEv?=
 =?utf-8?B?bS9ESmRtUUM2SmEzVnJTNlJFWEhvUWtETkZmS2dRRTc3N0xnNzRFRHVITEsy?=
 =?utf-8?B?VHRsNnhxVVYxQjdSLzVoUXkxMnE2SnR1VDI2RmdZMk8zbkFUajZSa3NUdTNN?=
 =?utf-8?B?NE5rSTV5TEVEQUZWMkFuODl1L2ZDMXM2NnE1Y2FkVmY5L2VFZVBuUWVCZUZS?=
 =?utf-8?B?ZTk0M0w1R2JnQ0pPM2loUDhSemwrc3EzK1ZLbDhpSkwvdjF0V3FmQ01TSmUv?=
 =?utf-8?B?MzU3U0JxeDU5QVBESzdUL3Q4R01JZ3VXZUFscGNLNEZiaVYwUW5WUXdEekd5?=
 =?utf-8?Q?+76aq3MfEB37f+o?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdd765f-f0c7-4b50-59aa-08dbcb1fc22a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5276.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 12:35:46.9870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bv6fanXlQO3J6K3hQ6D4Rp/tVNe67BP+2Rwen/f/Mu/bfQQHs2rHvOmncGzUQoElR9+y9QiX7MjmArreqq4R6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120103
X-Proofpoint-ORIG-GUID: cFtKn6QxZ4GTzrDqJU9k0F-JHaHiY7fu
X-Proofpoint-GUID: cFtKn6QxZ4GTzrDqJU9k0F-JHaHiY7fu
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/10/2023 23:14, Eduard Zingerman wrote:
> On Wed, 2023-10-11 at 23:05 +0100, Alan Maguire wrote:
> [...]
>>>>> I'm not sure I understand the logic behind "skip" features.
>>>>> Take `decl_tag` for example:
>>>>> - by default conf_load->skip_encoding_btf_decl_tag is 0;
>>>>> - if `--btf_features=decl_tag` is passed it is still 0 because of the
>>>>>   `skip ? false : true` logic.
>>>>>
>>>>> If there is no way to change "skip" features why listing these at all?
>>>>>
>>>> You're right; in the case of a skip feature, I think we need the
>>>> following behaviour
>>>>
>>>> 1. we skip the encoding by default (so the equivalent of
>>>> --skip_encoding_btf_decl_tag, setting skip_encoding_btf_decl_tag
>>>> to true
>>>>
>>>> 2. if the user however specifies the logical inversion of the skip
>>>> feature in --btf_features (in this case "decl_tag" - or "all")
>>>> skip_encoding_btf_decl_tag is set to false.
>>>>
>>>> So in my code we had 2 above but not 1. If both were in place I think
>>>> we'd have the right set of behaviours. Does that sound right?
>>>
>>> You mean when --features=? is specified we default to
>>> conf_load->skip_encoding_btf_decl_tag = true, and set it to false only
>>> if "all" or "decl_tag" is listed in features, right?
>>>
>>
>> Yep. Here's the comment I was thinking of adding for the next version,
>> hopefully it clarifies this all a bit more than the original.
>>
>> +/* --btf_features=feature1[,feature2,..] allows us to specify
>> + * a list of requested BTF features or "all" to enable all features.
>> + * These are translated into the appropriate conf_load values via
>> + * struct btf_feature which specifies the associated conf_load
>> + * boolean field and whether its default (representing the feature being
>> + * off) is false or true.
>> + *
>> + * btf_features is for opting _into_ features so for a case like
>> + * conf_load->btf_gen_floats, the translation is simple; the presence
>> + * of the "float" feature in --btf_features sets conf_load->btf_gen_floats
>> + * to true.
>> + *
>> + * The more confusing case is for features that are enabled unless
>> + * skipping them is specified; for example
>> + * conf_load->skip_encoding_btf_type_tag.  By default - to support
>> + * the opt-in model of only enabling features the user asks for -
>> + * conf_load->skip_encoding_btf_type_tag is set to true (meaning no
>> + * type_tags) and it is only set to false if --btf_features contains
>> + * the "type_tag" feature.
>> + *
>> + * So from the user perspective, all features specified via
>> + * --btf_features are enabled, and if a feature is not specified,
>> + * it is disabled.
>>   */
> 
> Sounds reasonable. Maybe also add a line saying that
> skip_encoding_btf_decl_tag defaults to false if --btf_features is not
> specified to remain backwards compatible?
>

good idea, will do! Thanks!

Alan

> Thanks,
> Eduard
> 
> [...]

