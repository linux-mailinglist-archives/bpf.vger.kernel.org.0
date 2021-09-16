Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FBE40D1D2
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 04:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhIPC7V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 22:59:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233856AbhIPC7U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:59:20 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM3v0R015239;
        Wed, 15 Sep 2021 19:57:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=m1U2cXCaKlfqToILs+gaQs6iOz1mNTQ2rIOMc5WChNc=;
 b=eKHagsZnoQcTlsq+Bj/RfFf3WxifpldSapVZE7XNrVhqttp5feRFnVLNrgZFFvyYvoeH
 L9BgierRRMm1mSvuXbCZhfmfuhHVA21KsnZjaEza0UqFcsh7QPPO9vsABwH0ZsfDudj2
 8z4Er4MxAqB/9ahuvEkCpHIIwJ8zsdZYpao= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3my2b93d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 19:57:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 19:57:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+Nvbe5Bjt/uUupw7xdf59giSpvCUHxNQaR1tz8yvaM5QN89didjh/sVSrF6HlXtYXZTaovlXbvdXelttiqWtYkgVgUI6KutzcNjba/ZNJSNx1HSvwOLlNZovnqKgpvHFLvLaKZwOjikUugKIGxDvcPqXTQmcuQQlcJN3FTbHJ90or2HlrwSRinjfPkdl6vgTpFzV+bI1FBGR/zs2oCZsNUJ7u/AjAydNWBdaOQSNWdgH3ls4IDOqyPRQoO375lkOojocTog50JrBHQmRic2IPUeEUTTpMaCTlY0cVBaynrg70SLs7BjuFSOnZ5UQNepfTXf9VdKdim6MoIt7C1cWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=m1U2cXCaKlfqToILs+gaQs6iOz1mNTQ2rIOMc5WChNc=;
 b=F3qtcDGbwgKkRfvvXrLUhSfH76JC6B9xbcFoAvAbbl55UCyK64WWQZtEdQhCa3zqCfPgX1vYcV7vldcBQzTyhEymhFUp413XLPaXoyQAwkV1nc4p7pHzMSoboAdM27+knnY9rxjv9WxNB124pL1wI+HMUGItWsTEz2QUh2CaAdQ2pzEotFUpUjUXouR1vJh7878cgUF7QhvGEDMiccrIfwuguu9k6/3MTibH6D/G6lMS5DbPbhe7UPEwZ7UQ19org+vWm/Mb4c1Jjuwph9b+n46mlXxA0fbdXaaciYfYD47vyw/5q/MBlXJBSTY1WPbm1wpdsQ6cFILHJKcztzT3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4660.namprd15.prod.outlook.com (2603:10b6:806:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 02:57:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 02:57:46 +0000
Subject: Re: [PATCH bpf-next 3/7] libbpf: deprecated
 bpf_object_open_opts.relaxed_core_relocs
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210916015836.1248906-1-andrii@kernel.org>
 <20210916015836.1248906-4-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b078999b-ef8b-49db-e875-e20a4dd0440c@fb.com>
Date:   Wed, 15 Sep 2021 19:57:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210916015836.1248906-4-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0322.namprd04.prod.outlook.com
 (2603:10b6:303:82::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:51c) by MW4PR04CA0322.namprd04.prod.outlook.com (2603:10b6:303:82::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 02:57:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 413d7b4d-e0cc-4b17-8220-08d978bdc2e4
X-MS-TrafficTypeDiagnostic: SA1PR15MB4660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4660262ABA0987C9DEDFAB06D3DC9@SA1PR15MB4660.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sgF5/DVNAhsfF/V04Lq8FhpyssscKa4XSFFQAzolewRluMSLD6TxkLBSHPByYjTBrgCN2qkn11aBWOQvLeAkc6GCKTPIRpFrPTJIYQYkmq+xAv0I3GeySEsSyzYtJ9epi7MiuPAkpjnKaQEjp+9y/2EweVnUPRsNRJXhK7/Avq9q4L0ynfSqYO2aLqD/dq+qpeTiBn3CCE7c31QG2bkhyh/HbnAq6tSyzsjhPGAl3Kt9Q3WjTuH4RGkGtXThyVkqDSYWfdDvKPO0b74kwzDZdfd5SlA2DY6UcUdiypzhB/WpJOFvyFeSiTesoW4OcZeckISx+dgJuRU3lw3F+zqpHydfljFF6Kub3FRuZX4kOk+PepuRAMMV72vlptTfFpoQd+4XlgQJSc5Zpjj+oW9n8unPc6J9hzczi0z/Lo630rcX7Id7PJePMPOVltXcSSwzpULV7+myc8PO5KcjXijX8j5npLq/IG6wz7sv9mdViwyiJgFNsVij7fZLBeiMaVqLrlSpUufjCP4FH8h+A5BvVvn0KHcdH3ZvSt34bZhkx4Ka2hTUYLSghFIdZd+aCQDT36dsO54XH8bc8f1oESi2N1UNkHdULYYezffsDxChQRvyacnMQSxrEUYcuWX12+WJthO/mmpt4O6sBOu77WpxbbDfWrvGeaOr2l9QJaLyQkOOKdQqC6ZXRsAIWs7+4q1PRQ3yVBLfVQO8X1f3Ccay2wkVRcyBlcEDcuc50nj8IXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(66476007)(66946007)(66556008)(2906002)(558084003)(6486002)(8936002)(38100700002)(8676002)(2616005)(52116002)(186003)(36756003)(53546011)(316002)(31686004)(5660300002)(86362001)(478600001)(31696002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjBVZnNzZisyQ0srTHplcU53OWxRUlIyUEZCRTRQaUR5ZXhLZGhpUDF2QlhL?=
 =?utf-8?B?K01IYnlPWmZMUnFQUHRsV2Zmc3JRSnU4RjVMSmdRRFpzOU4wSkpncHhTZGJM?=
 =?utf-8?B?S1FVNE9lS25jeUhJRG1pSHBieVZoWXU4SE9xOEEvZ24wbFJqNHVzUUNRQXVB?=
 =?utf-8?B?NGhvdVJJRnViQXAyME9hYm1tWWhJZFdiMXJQR2pJdElKQU5HV3ZWV1FDc2cx?=
 =?utf-8?B?Yit1YTRmWW1IUEs0Vk9JSlVtMDFpS280Q3RTS3YvVTl6em45R3NnV1ROTkQv?=
 =?utf-8?B?NXZQcmowNHNFM0lnRG81TTY1MUc5TXNLQ0h5d1JaUW5OWndXalIxdE1RQytI?=
 =?utf-8?B?QWpic01RMHhVWUc2Y2plK1BEcFZzQXpEanhxRTBmUWNjRk91MTREYkVKaWJJ?=
 =?utf-8?B?cVRHZGQxem1zaUpzZHQ4Q2ZtN1ZjZnVRRXljWE9IMFpOOXVaUVNuWllzdWNm?=
 =?utf-8?B?NitoNkU4VWZtREtERmpHU0hzVEhFUE9GSXhJZzU0eW9wZlNleDBxdkRNUGFt?=
 =?utf-8?B?VVZsS1JSRXNTRWtzUjlOZFdzandQaTY2QWlUb1hHVFE3bGhGdmhtaVl3VWpC?=
 =?utf-8?B?L1NLSG9MMVRYZDRmS01pYktUemc3dDNobTRFKytrU28vaVc4aU9HR2NNM0xL?=
 =?utf-8?B?MStkRzg1WmFuWnZ5Z1V0elAwZitLS2Q1WlVJZHNQSkthS1V5ZUd4S2VaUEpG?=
 =?utf-8?B?NW12VFJIY082WjJLSE8rbktSdUFmcWx0eWE0Q0R3QzAyeWxDenBsOUJjbGpy?=
 =?utf-8?B?NW01R2RRUjJ5QmhFa1gzM2ozVEZva1phU3JrdzZSY1hCT0k5NWtSNm1oampa?=
 =?utf-8?B?a1U4OStMRE1NZjJmQmtWaHZ5ZmJ1aFFla3BwZ2d1NmNuRHd0UnF3TFdVWVFi?=
 =?utf-8?B?RmNDUlMwVUhHVldvQXpYd2hXUUdDZzlLSVJWUUd5c2J0TWhOdldQNk42QUdD?=
 =?utf-8?B?SndUa3Z6YzZkNzc2OEdpb2g4THRETkxoTmZ1eUdUZVBJam83WXBZM3gzTFZk?=
 =?utf-8?B?MmNVSHlycHBDWm9wdk4rSU9IV3ZZNkJhaHFHLzFOd2Z3SEFqUmczWmJNc3pu?=
 =?utf-8?B?SGtlSkgyRVJSRTZad0o5Vjc0NVN6cTFCUm5Ea0ZSNTZMd1Y1SWpoWjNlYXo0?=
 =?utf-8?B?Z1JrdmkraDVTc2ZtYmxIK1FqdlRyNVdDeUpML25ZSHA2U1VyVlQ4QU5meGpG?=
 =?utf-8?B?bHJ6blVRdk5saENxdDB2SlJabTVKR1I4UlNHUlByYmk5OWpEUmFLVmkrcEhM?=
 =?utf-8?B?c3p6d1RVKzc2cDR6MENiVlY0WXRmWWxlUERZU05DSkF0OStLT0xQeXg0SjFI?=
 =?utf-8?B?V3lId1cxTU1mRTJoL0tVRTFQdytLTnFUckt1cEFOZGdWVkU4RmRrZytlaXZm?=
 =?utf-8?B?eEJtSkJrMXNYTEFKTWNUU21kWUZQYmlLRUp4cytkWjcvMmwzS3F6SEFXN2NN?=
 =?utf-8?B?WUoxczcvOHNWSytLcW5zNDFCM3NTNS94amJhczJmWnRTbk9mWkZsUXVBUG9E?=
 =?utf-8?B?Tys2Z1hWRnNJanNubTlZbEJHWk56clROTG9jT3hMaU1pU2JMVU9OWmg0MCt0?=
 =?utf-8?B?OE1kSXE1eXAyVENTbmJGVmNhbVBTcm1jcEtuWUJxb0FxTzcwQXl4ZHlhRlN0?=
 =?utf-8?B?K1loU0tzNTZTU3RkUHUrS252SXZibG0vU2lHWWNWUlE4TVhDT0xOcTZON3Zp?=
 =?utf-8?B?K2djdnVieGNwaDRmcXVCeDBiSGdybXczRmNvcVJybGNONlJtSElnOW5kbU5E?=
 =?utf-8?B?ZDMrM1dPREVTS3BwZEZqMHVmK0tsbUFhYVh0SXQ3OWZnOFBER0RseU01K2FT?=
 =?utf-8?B?V3ZDV0pvVzZsS2dmeW4xZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 413d7b4d-e0cc-4b17-8220-08d978bdc2e4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 02:57:46.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dh251/XI1czUvnl6vNkil15a66HIWFlCgZE1cdVCnGVeqIjZ03lv6pkddHrOuc0M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4660
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: uUqjdvbnrIuiiUnRWXfPsIc1uj9fvRad
X-Proofpoint-ORIG-GUID: uUqjdvbnrIuiiUnRWXfPsIc1uj9fvRad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=914 bulkscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/15/21 6:58 PM, Andrii Nakryiko wrote:
> It's relevant and hasn't been doing anything for a long while now.
> Deprecated it.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
