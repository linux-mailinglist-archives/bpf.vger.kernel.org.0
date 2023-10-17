Return-Path: <bpf+bounces-12440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AA57CC841
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020E71C20D08
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783345F57;
	Tue, 17 Oct 2023 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DHGhlXPD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U0L0NT3u"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A575EBE
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 15:59:55 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BBE9E
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 08:59:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HFxS8n030031;
	Tue, 17 Oct 2023 15:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/WSvvXLZnmUITGeGawBOCseGDI1UvAlv83aAViS9+5U=;
 b=DHGhlXPDmyJ+EegJhzfurWhaELUdPE78ywOUg2Bt9lllBqJ711OFOR056euiDxcVvAvz
 q14lXxDgXdn/4ddYnJpbMSnB+dabGOzPgY2ALM9GI7DReSnsSlBkgWhHxnmQcHwtF7vi
 rELPa+uu267exLj0ScFf6Q9/ajAQYHZmvKszI9Z8GSimvRdJchHcxtv5AT/k1YusYr8J
 lFy0Ni0QSydAd0TJb6y3HnIdMCVKechARkl0ylRqwNgUJFWCCrDZu+UN+YSTNwohga8I
 7rnRDYAOHX+xV12bYgXTSilmm7KYXNw3OH+lO6vVbXLx4603XgyG5mAewhrEgysWXjYA XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1dhrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 15:59:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39HF2Zj6010472;
	Tue, 17 Oct 2023 15:59:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg0n0k3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 15:59:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZxWigmHtNxjFhKEV5tQZEbHxZoVo5uR5dsLgnIYorw/U0iKbbtvDBsuxc4fyEXNOCtEqsCLTnz4J/hei5Rxl2x6biMYfB/xO6RqJAEV88DaQZ9S2IVCP7ZixJ4IHCj1nPRp8UnhqMJfhIcljujqTAB5pJ82Tyrwac99+coM05uzNyfYZSqmYOSqORbC7wspFA+Lzl45H3Glgl8c+OjIizAEI7ietgfWMIizSgdX17kyhzSsTcGgdaag4CXuIvcnSsmSjQYRk5PZPtIAxx9d0/7vY2fwmnJoeldtuJwbc3FZV0TbOapo0Jq8l2wcSQbquQpsSFhqOpovG+RsLKc25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WSvvXLZnmUITGeGawBOCseGDI1UvAlv83aAViS9+5U=;
 b=df5MgNRbYNgXbuf5NYSNw4NeIXrs3gneNm3ODiMTf0sGFptjAAncWlPD/FmqvhZE2kj6p/o4pZxZ6Be2p3I3BoAqDHI8jA/QrZaio3NIZVDb3TQ285QxyK7EbpkEeDfX+3b2N5YjcNoIrRDjxWUSTcn51W49u95eGtg0btDCVAX6ICv/kNap9/mCm+Mhy/gwHJ9qr14gFAaOrfdnocDqVf23RhZL1wrNJ/HqAUMt6BvNGpFtTZu6yJcU3t/SNVGLn0Wz19wIHfWK4Ae2rtcfUljWT5nnupFU3Jiq3BKGdGCtnAPV5mZ6cFZnXwrhoOt42GlvXckG2GWQktbPPni16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WSvvXLZnmUITGeGawBOCseGDI1UvAlv83aAViS9+5U=;
 b=U0L0NT3uypcoQ7nXqemPRGnDhdM78jNqU0ugMua/JRbpm1+WwQLcfZTBvJiMqOJYtWGSwnCI3XEEPlCI50jQr+1Py5XFWCSHJjpJjiNlMPJBo7rLpkXoy2ZL6UPXrAYJLTd2R57+0DYiWPdk/QjgJJXSewWZfOPXsd1gsbkr3Qw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB6217.namprd10.prod.outlook.com (2603:10b6:208:3a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 15:59:29 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::dfa9:4b44:40d4:5d36]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::dfa9:4b44:40d4:5d36%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 15:59:29 +0000
Message-ID: <f59f5d60-c33e-1786-f442-82ea795059b2@oracle.com>
Date: Tue, 17 Oct 2023 16:59:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 dwarves 5/5] pahole: add --btf_features_strict to
 reject unknown BTF features
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org,
        andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
References: <20231013153359.88274-1-alan.maguire@oracle.com>
 <20231013153359.88274-6-alan.maguire@oracle.com>
 <dbaa9e9b3e090f5ed88faaa62a40a080eae53ec4.camel@gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <dbaa9e9b3e090f5ed88faaa62a40a080eae53ec4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd8e6fc-b7ac-4c37-0d74-08dbcf2a0b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ui/Er0byuKDBLkNNuhB3wRdN5wp1qLED7vM52z+OnjkHki6TvHzobEpuO3Z8R6miSzLIUuzSstPi9qjMTPBVoAo7yS07RmXUxrTz5hQ262YOc2MDX5nC0JSiMbOwF4PT3cqHASCqwz/d1agUSioIe8QbNynnCADs3tmz3pnnm3M1TCy6S9n5c9R14cTxtPj5d5vDU5zJ34pl7J7t9GUuuxmcLH8OKk5eMYsSLVvEGAFyO5p2BGS+s5pG2Ecta2xTbZWphfoJATY9ffa5cmNxrdxkQRZofdtjF1TJjy+LwifeZczvojCY95ycpai5Sz7xATCigH2fuZZzRscEnkjESkBFs0fRfE6iev80j2/YIIq+5/Fep66bvByu5W5e/ESMGt8GnuZ+DTaT4bae28GoH6j8qM6G1c5ZB1/hWhwuwcqWy1/xHHbUkCyFSD2qoR9uoww5zJjzhyJ/FvTuMHX5gxOqy7eCD3IH6haET5pGWThWRNnRo9HAUQAymAmsv4TlHQ06Tm7Adz5H6YdGXtt1Q1dVy6Rk0T5z2dgL8Pwfq2ACk17qTNrRZbD1pE4QVdmkj66sL5lUHS9BnkNQtzY4Hjw8A9B6PTMx5DUt2TpuaFDe37jdcetdFxa90h6C4wZc9hz+RCiZ05fH1ZeIqWbxUw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(36756003)(31686004)(66556008)(66946007)(316002)(66476007)(31696002)(86362001)(38100700002)(53546011)(83380400001)(2616005)(8936002)(6666004)(6506007)(4001150100001)(2906002)(6486002)(478600001)(8676002)(41300700001)(7416002)(5660300002)(44832011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S0ROeW1QV3lXQ05PSDRuODNMNmtlVXF5THc0VVhZNzVZRy91RXdNcnBiSTZp?=
 =?utf-8?B?Z0s2QjdZNm95OW1SSEVXK3B4aGhyVGpsRXgzL3M1SFBCcjYvcVE2blJFWW82?=
 =?utf-8?B?SGNkNnlabHNGNVltVmZhMG9qS1REdUU0L3ZqYlRDS0FwaUQ1L3RRWGFaZU5Y?=
 =?utf-8?B?VkQ4OXJ3dzlWbDBMUDhqVmtUeTJ6L2d6amszZ215VTlnYURFaENnTm1tMlY1?=
 =?utf-8?B?N0FkRHE1angxN0Y3dVdFYk8vd0NOMTh5OGZzNGdCZUtuaklwS1ZJYThpU0I2?=
 =?utf-8?B?SWdWR2FrdW1xV3Y4a09yNmc3K1p3MC9YS2tCNVZ1bzIxcFpVbVpFOEltZEc5?=
 =?utf-8?B?M2JIWk9nZmMyeVVvNmR4WVg4dG54eG9KVWk5QytiR052YWt4R3VRaDZKQlRC?=
 =?utf-8?B?OTZscGVKaTkxb1BhSFJLb2F1Y1FTUXJIWUNLeUl4Rmw3dm9aejNEVFB0VnJN?=
 =?utf-8?B?dWIyQ1loOFZDeVRzdzV6QkZORHdNVXArT2N6Q09NMWd5bmxzUk9QOVNGK0x4?=
 =?utf-8?B?RlJVUDdjSk8vSVB6N3l0dkZQdHU5T1ZVMVR6cW40MTNTUnhYanNsZlZEUys5?=
 =?utf-8?B?RDUxRmd3aXVSYWFCMFYxc1YxWXRBdG95bGxjb0RWN1lpa2w2RDFYQVF6cUdK?=
 =?utf-8?B?V0QrQlFTa0J4OVVvZjN1cnBFRGkyWElrTzQwN1N5dVVCUlFjQnd0Ylh2Vk1L?=
 =?utf-8?B?YlQxUm1rUlRnRWlQVmZxbHpZZjRObXhRTjdLdC9GWFVxZ0FCVjFHbXhLUGgy?=
 =?utf-8?B?dUh3QzVReStXR21PNWhoRkUySWFGaTY5amxyK2R6MitycUw3ZUs5ZkdzOHFh?=
 =?utf-8?B?R043cFVPVy9zWkNxNWJnZlI2VlhzVmVFSmdzbHVFZllKbWtSUzMzOGFsUllu?=
 =?utf-8?B?OENRMXpSSzBXTWJXS04wR09OTXd0QWhLWjlSdzg3Rkx2Tm9VYTk1cEhTSEZu?=
 =?utf-8?B?SVc3OXhLWU1TMXFzNkc1MkRNOGV3Q296UFd4cGt6eE1zQVVwNTNsNUJLZUIr?=
 =?utf-8?B?YStZdzM0TnZLWlBCMW1YMkxCUit2dUhtWDB0N0JmdS8rcnU2SlRycktxY01T?=
 =?utf-8?B?bzIxVWVPZWNOcWcycjUxdGZBYlAzV2ZpSTNFNEhFSDNUY3JJbTNvK3RGa1dT?=
 =?utf-8?B?TmYzQWo4M1I2dktBSS9Ub1B6ZW9qZjJtc0E5QUsrSWtPVnNpSjNMVzNUY3lT?=
 =?utf-8?B?MEJQM2tTT2RsSTBCQ0NRSmtQWFZBTGwwSEJTaCt0REtzdmoyc1NycHlYSmNp?=
 =?utf-8?B?RGlPckRZdHFiM0h0aStVLytPTDdnVkFMakJNUEdyNmNPQVgxVHA5cmIwRXJH?=
 =?utf-8?B?YzJVVE9FQUY4WE5FZTBtMEZQdVdXYTZENm9WMUxsMzc5ZFN3SVRIZjZNZkI1?=
 =?utf-8?B?UE9VTWUwd3E3c1R0OThtNUhhMlA0K29Iekx0Tjcvc1psYk9CeVhTWkZxcWwz?=
 =?utf-8?B?cG16NFlka29hY3hEc2pYMVE2OERuK0hpU3hzZEg5d09FYXlMS2ZhZFdrV1RO?=
 =?utf-8?B?SzNCTE5pWTZSbHFQenNJTExYbUZoc2ZGcWtvWndZa1lEV0VyM3JaRkJSempM?=
 =?utf-8?B?T3dMTGVYSlFlR080OFhiYkpUMTJ2MUFsN2wxZFl4cWxGVHphUk5SSWxhenhR?=
 =?utf-8?B?cyt2YWpWSGQwbjJIZnp2UU03QlpXZU9iYXUwRDYzS1ZvVlJUODBMSUJYMUxr?=
 =?utf-8?B?TmlxMEFUQTg5amZSMHNFMmpvMmNSZnlINEVpZEZhdzhwTWNoQ0YwYnpVNkhL?=
 =?utf-8?B?blhLZVZzRjZSVzNXM2pyNlorbmxjbVBJdVQwSm55MTZTVkVjT1dmaE5NTzdu?=
 =?utf-8?B?V0grMWhtdjdkRzBKTHcyWEJ1cS9leUJKWFpwclNGY2RiaUJDZkNMZ2IvMjhJ?=
 =?utf-8?B?QWxqb3lqT2t3RkxIdEZWTVlGMUhaTG5aWStJZ3gveks5Sk9tVFdROG1iTlVD?=
 =?utf-8?B?eDh0N2pSUGV0dEJ1MS9OSjdKS0RQeXdROXVNYUtoQTkyTDI5MEpxRUFPYTUw?=
 =?utf-8?B?ZjBaR0xLVlRFYnZ4dFVrYmxlUHJKOXBKRk1CYzlZMzlkNmpJMGpITTZ2eGhK?=
 =?utf-8?B?dmFZR1VBQUl5eEtEOGtXbktUYXRMS1F0L2NDbzFIb2krMWIvOTByZGRJWjhQ?=
 =?utf-8?B?ZWhUcmM2Mkhndk05UU9JTVJCY0xaUmRsMGgrVUxJSjhndG9QeWtWVXpTaWtG?=
 =?utf-8?Q?ADWXCzadU6BkvlRItQLOdlU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?djV2VzZoeEhWaXdUMGtGejNIOWRrU0xjRWpsWEdTT1ZGSktNL0tRNlNhWmZZ?=
 =?utf-8?B?WXhYZDFkQmwrQ244MGw0dHdPM2VtNmlnLzlvV3Z2bndsZUQvcDgybVVYN2VS?=
 =?utf-8?B?SUg4Z3Y2VldaSXExcGg2ZnNkMVlCRDMyOVlwRWNtbS82UEdLWW5GTnAzMzdx?=
 =?utf-8?B?V1RQNjNCTDJzWldITGVvbVNkS05sYWRoWE1UZ2RBQXBEUnJhdTFBSzZWOUlL?=
 =?utf-8?B?NzUva0ZJYnVWeEZTRU5TWnl4clhuVmRjS0k2Z1VxdzR3eTBZbGJqS3plL2ox?=
 =?utf-8?B?elR0UDZzV3UyUWYrOXBVTm0wK3dKSWhmQ3JoK2pXMWRJVlZWMTlLc0Q4c0wv?=
 =?utf-8?B?djQ2Y1R4ZWZ5YUhYbHY3RmRlOUh3QVVjMEZqZDVDVHJLbFVjVWFER1RuV3VU?=
 =?utf-8?B?WjRxWHZ4QTBxaGx4MlZqSVh0anlqRDBCQytDRHZlYWpFYzlyUUREMzdDcVVZ?=
 =?utf-8?B?bHVWVEV4MkdhdXhCb2F3MVJpT1NzYnVML3Z4amdvZTNGTDZMaDg5U09PU0ln?=
 =?utf-8?B?cEVVT2o3YjA2Z3l1ZzFsUzZFRjlrcm56L2RyQm04TEdqeCs3U0hhSFNveW41?=
 =?utf-8?B?bU9vbTFZS1ZSTVUxSG5neFRvbEx3RXBhM2w5QjlRdjZnSUcwTFgvQjRxNTVz?=
 =?utf-8?B?SzM1aTJoc3YwMk15bXRIaXh3SVhaMHFrTDA1cUVnL0JZUUVnNzJSeXRVenR2?=
 =?utf-8?B?KzRadCt6b3hYTy9WV2FUdWM2N1BBVFVZcnd2ckJIRUhsQWtFTnBXcm9QK1pV?=
 =?utf-8?B?czlLMm42UWtRYmNldVI3OWRLMlRWWkxIZGRIbW5ZRWdlVVVvNjBKM2srdFlH?=
 =?utf-8?B?clRCWDEyMDUxVmltaU9hWFdvcWhwQTRWVm1rQUk2OVpKUXpuRDhKWkkyNFB6?=
 =?utf-8?B?RzdJSzFWS2J6SzM4VElUL2lZMFJPMWVWVGl4S09NbUZUbklPU3JRbElxb2RK?=
 =?utf-8?B?WE95b1ZJNUpOU3l6TVREM0lQdUtES25yd0xyYzBxV3hvUnpySGJ6V0ZTbzc0?=
 =?utf-8?B?b3h5RTd5WlAvOGl4K1A4eG1MNUJ6NU1OSUk3enNVbG9ya2p3MzhUbGtOczVv?=
 =?utf-8?B?dFNqUjVMdEJucko5UUJ1eHRwUGxpcWhuSS8xNWswakpaNi9vRDlsbmtGdTJM?=
 =?utf-8?B?YjAwL2c4MUtsSXNXSkV3Qi96bFBNczdRNXRFT2ZWK2tDajZKUzJsTnFucENI?=
 =?utf-8?B?VnFmQW1sNlZDeTJvTzU3R25pQTNyZ1hNMlJkUE1IdU5xZGZZSXJSN0FDSmRZ?=
 =?utf-8?Q?RdhIP6jtc0EhHnO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd8e6fc-b7ac-4c37-0d74-08dbcf2a0b76
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:59:29.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0s5uqMGUvmSn/oEi1fh44HisdL1yqcbXMBVbiZoUu8DrTdQ/vHl7HNqXSWiRsz361LP9I/AlMmGJ1/BeztGTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170135
X-Proofpoint-GUID: Vvg5_9X_Kp8N9oVq-PUEg1OOO1XLKnfk
X-Proofpoint-ORIG-GUID: Vvg5_9X_Kp8N9oVq-PUEg1OOO1XLKnfk
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/10/2023 13:53, Eduard Zingerman wrote:
> On Fri, 2023-10-13 at 16:33 +0100, Alan Maguire wrote:
>> --btf_features is used to specify the list of requested features
>> for BTF encoding.  However, it is not strict in rejecting requests
>> with unknown features; this allows us to use the same parameters
>> regardless of pahole version.  --btf_features_strict carries out
>> the same encoding with the same feature set, but will fail if an
>> unrecognized feature is specified.
>>
>> So
>>
>>   pahole -J --btf_features=enum64,foo
>>
>> will succeed, while
>>
>>   pahole -J --btf_features_strict=enum64,foo
>>
>> will not.
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  man-pages/pahole.1 |  4 ++++
>>  pahole.c           | 20 +++++++++++++++++---
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index 6148915..ea9045c 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -297,6 +297,10 @@ Encode BTF using the specified feature list, or specify 'all' for all features s
>>  
>>  So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
>>  
>> +.TP
>> +.B \-\-btf_features_strict
>> +Identical to \-\-btf_features above, but pahole will exit if it encounters an unrecognized feature.
>> +
>>  .TP
>>  .B \-\-supported_btf_features
>>  Show set of BTF features supported by \-\-btf_features option and exit.  Useful for checking which features are supported since \-\-btf_features will not emit an error if an unrecognized feature is specified.
>> diff --git a/pahole.c b/pahole.c
>> index 816525a..e2a2440 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1231,6 +1231,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>>  #define ARGP_skip_encoding_btf_inconsistent_proto 340
>>  #define ARGP_btf_features	341
>>  #define ARGP_supported_btf_features 342
>> +#define ARGP_btf_features_strict 343
>>  
>>  /* --btf_features=feature1[,feature2,..] allows us to specify
>>   * a list of requested BTF features or "all" to enable all features.
>> @@ -1288,7 +1289,7 @@ bool set_btf_features_defaults;
>>   * Explicitly ignores unrecognized features to allow future specification
>>   * of new opt-in features.
>>   */
>> -static void parse_btf_features(const char *features)
>> +static void parse_btf_features(const char *features, bool strict)
>>  {
>>  	char *feature_list[BTF_MAX_FEATURES] = {};
>>  	char f[BTF_MAX_FEATURE_STR];
>> @@ -1325,6 +1326,11 @@ static void parse_btf_features(const char *features)
>>  					break;
>>  				}
>>  			}
>> +			if (strict && !match) {
>> +				fprintf(stderr, "Feature in '%s' is not supported.  'pahole --supported_btf_features' shows the list of features supported.\n",
>> +					features);
>> +				exit(EXIT_FAILURE);
>> +			}
> 
> Hi Alan,
> 
> Sorry for late response.
> 
> This won't work if --btf_features_strict specifies an incomplete list, e.g.:
> 
>   $ pahole --btf_features_strict=decl_tag,enum64 --btf_encode_detached=/dev/null ~/work/tmp/test.o 
>   Feature in 'decl_tag,enum64' is not supported.  'pahole --supported_btf_features' shows the list of features supported.
> 
> Also, I think it would be good to print exactly which feature is not supported.
> What do you think about modification as in the end of this email?
> (applied on top of your series).
>

Argh, apologies, I could have sworn I'd tested this. Thanks, the fix
looks great, and I tested your modifications and all looks good.
I can add a Co-developed-by: tag for v3, or let me know what attribution
works best for you. I'll fix the cover letter as per your other email
also. Thanks for the help!

Alan

> Thanks,
> Eduard
> 
> ---
> 
> diff --git a/pahole.c b/pahole.c
> index e2a2440..cf87f83 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -1285,6 +1285,29 @@ struct btf_feature {
>  
>  bool set_btf_features_defaults;
>  
> +static struct btf_feature *find_feature(char *name)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(btf_features); i++)
> +		if (strcmp(name, btf_features[i].name) == 0)
> +			return &btf_features[i];
> +	return NULL;
> +}
> +
> +static void init_feature(struct btf_feature *feature)
> +{
> +	*feature->conf_value = feature->default_value;
> +}
> +
> +static void enable_feature(struct btf_feature *feature)
> +{
> +	/* switch "default-off" features on, and "default-on" features
> +	 * off; i.e. negate the default value.
> +	 */
> +	*feature->conf_value = !feature->default_value;
> +}
> +
>  /* Translate --btf_features=feature1[,feature2] into conf_load values.
>   * Explicitly ignores unrecognized features to allow future specification
>   * of new opt-in features.
> @@ -1294,7 +1317,7 @@ static void parse_btf_features(const char *features, bool strict)
>  	char *feature_list[BTF_MAX_FEATURES] = {};
>  	char f[BTF_MAX_FEATURE_STR];
>  	bool encode_all = false;
> -	int i, j, n = 0;
> +	int i, n = 0;
>  
>  	strncpy(f, features, sizeof(f));
>  
> @@ -1309,36 +1332,36 @@ static void parse_btf_features(const char *features, bool strict)
>  		}
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
> -		bool match = encode_all;
> +	/* Only set default values once, as multiple --btf_features=
> +	 * may be specified on command-line, and setting defaults
> +	 * again could clobber values.   The aim is to enable
> +	 * all features set across all --btf_features options.
> +	 */
> +	if (!set_btf_features_defaults) {
> +		for (i = 0; i < ARRAY_SIZE(btf_features); i++)
> +			init_feature(&btf_features[i]);
> +		set_btf_features_defaults = true;
> +	}
>  
> -		/* Only set default values once, as multiple --btf_features=
> -		 * may be specified on command-line, and setting defaults
> -		 * again could clobber values.   The aim is to enable
> -		 * all features set across all --btf_features options.
> -		 */
> -		if (!set_btf_features_defaults)
> -			*(btf_features[i].conf_value) = btf_features[i].default_value;
> -		if (!match) {
> -			for (j = 0; j < n; j++) {
> -				if (strcmp(feature_list[j], btf_features[i].name) == 0) {
> -					match = true;
> -					break;
> -				}
> -			}
> -			if (strict && !match) {
> -				fprintf(stderr, "Feature in '%s' is not supported.  'pahole --supported_btf_features' shows the list of features supported.\n",
> -					features);
> +	if (encode_all) {
> +		for (i = 0; i < ARRAY_SIZE(btf_features); i++)
> +			enable_feature(&btf_features[i]);
> +	} else {
> +		for (i = 0; i < n; i++) {
> +			struct btf_feature *feature = find_feature(feature_list[i]);
> +
> +			if (!feature && strict) {
> +				fprintf(stderr, "Feature '%s' is not supported.  'pahole --supported_btf_features' shows the list of features supported.\n",
> +					feature_list[i]);
>  				exit(EXIT_FAILURE);
>  			}
> +			if (!feature && global_verbose)
> +				fprintf(stdout, "Ignoring unsupported feature '%s'\n",
> +					feature_list[i]);
> +			if (feature)
> +				enable_feature(feature);
>  		}
> -		/* switch "default-off" features on, and "default-on" features
> -		 * off; i.e. negate the default value.
> -		 */
> -		if (match)
> -			*(btf_features[i].conf_value) = !btf_features[i].default_value;
>  	}
> -	set_btf_features_defaults = true;
>  }
>  
>  static void show_supported_btf_features(void)

