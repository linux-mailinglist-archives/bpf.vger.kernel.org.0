Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFD52C3085
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 20:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390984AbgKXTK4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 14:10:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43840 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390973AbgKXTKz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 14:10:55 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AOJ4sUf002223;
        Tue, 24 Nov 2020 11:10:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=jPHTnX45waSc0K9178Ho0exh6484J+tTPy5OVzgxutY=;
 b=gLy/MlWXJCFQQ7UM+eAWPIu6h+wshyIdG7hqQeWKYH9kstUXLV6Rh/QQlq2wex1cLwmP
 0mHNhHcSM0ivSuRU2ThAtlbu0jSavl35Zk+EGEWJxNTuMXF1mnklVkLaJBmY0vTNvUNO
 wPTk9GgYDU2R3GNKCC7G3djW6zzvJpuEEVM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34ykkr37th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 11:10:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 11:10:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uv4Tw1ntTG+m+R8qMarZLaKFbGwRmgqsVNS0DvnCfW/VOSZVQs4OCA7txI/IeCxJeQn8mQhNH6rmXGcdPyy1MwGwdYr5tmbj9QbHLPJvsvccu9G2QrGuXrjeVtYO7RSWeA2U3cuMU2JK5WyiOdgymEghw33zlrpsSSCZldPeEyNtQEAi2ZiZPNpVYGxgDXz2N3ofjEyVEU6Hm7S00BvURQwif/AqzIxkXG6QjgYEkWPcdxKkVWBgxZWsqXMKA97Tch30bAmEF10gYMDBW/Wf4c7/XwDGHX31f3jf4taz7lH1E+YxeRmV4t9qiyUrYzPBqMcq5OZdSA9nyp5J0MSiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPHTnX45waSc0K9178Ho0exh6484J+tTPy5OVzgxutY=;
 b=id6TQTv+f5700sVSVYgjwFfGILHUmbts0FrNNG1k8vmQ8Fp26PalC/F5Nr+XPPXQZkozhn0BNFC7fY+x6sRjCcY9ljB5fL1QJ7S/x5JMHnuPKVPhpqzOcDyPplrUN83w15RTkdioWZFzVsapKThTi8fc9uT84doxkvP1gnMKp+0pvb+baYTR1fR8HneLgJ48FcZ/pMMA1COtpvSp9f2g0epThKWMcX1/NkEAVdFXDXzIBnbMFfhfTQS6fW1Pat5Sf+H/IHzc4c3xvPtuKWTRFOuZjFh9y32pf2R36l9fTuZ2Wm/8E+yfm1z7UDCToRCPYoy3LcJUnprjiKOdqNrzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPHTnX45waSc0K9178Ho0exh6484J+tTPy5OVzgxutY=;
 b=AJWnPvVR0VBLsotiqQn0JpL7wK3qEm1l55vJsGgNMmfS7azs1h3c85KcMK9azu0lA8yoEIleMOFRx2n8ySwe3QPrsR0EvHv4eQ3FffUqzIWgQn1hzXtO7saun5pk9AsgT/kZdWoPQcSJBPmvUecyghCFM9fWYCvfdx7relWlvVs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2327.namprd15.prod.outlook.com (2603:10b6:a02:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 24 Nov
 2020 19:10:52 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Tue, 24 Nov 2020
 19:10:51 +0000
Subject: Re: [PATCH bpf-next 1/2] selftest/bpf: fix link in readme
To:     Andrei Matei <andreimatei1@gmail.com>, <bpf@vger.kernel.org>
References: <20201122022205.57229-1-andreimatei1@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <6912beeb-9662-d217-eb11-5a320ea4cb3f@fb.com>
Date:   Tue, 24 Nov 2020 11:10:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201122022205.57229-1-andreimatei1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4987]
X-ClientProxiedBy: MWHPR2201CA0049.namprd22.prod.outlook.com
 (2603:10b6:301:16::23) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::10b2] (2620:10d:c090:400::5:4987) by MWHPR2201CA0049.namprd22.prod.outlook.com (2603:10b6:301:16::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 19:10:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4c37ba4-fa90-4b86-92ea-08d890aca8b4
X-MS-TrafficTypeDiagnostic: BYAPR15MB2327:
X-Microsoft-Antispam-PRVS: <BYAPR15MB23276D82A502D14A3F11AE35D3FB0@BYAPR15MB2327.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DAIQb3RCV1KPTtOGu57gxLxIivZV9++/jYNtu6VkVZN0wP1mCL47xHm5e9TQwoG4Pt+VKPLWVFxBXef/OsstCi/crM/u2J0wOfNoJx75R3luUgV5tlhsgH3Fx/pd3wUHMt4mrDHDAcRynOZcu2utpJ3zP36C3ZRBhU6lKkjbtXCHqthaTw8cac27Wyw0XZ4o5BNSVNpRDpPqxuqPXANV5cpQjDRVqrvOy3ITkml5X8HetbEcY44kK0s5A1ixwCZFSE89HK/ZvMK6sQhd8SGBHzy5K0FEvSgS8Dd1jgETm/wZRIO8Ok/uTTQVcv2JDxNcvNBDHdssZPq9ZZ88QticoVC8ks3+5l40yXqF8jQJP/dkX+QJUafou547mD2pzt1O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(396003)(376002)(316002)(8676002)(6486002)(2906002)(2616005)(66946007)(8936002)(66476007)(36756003)(66556008)(31696002)(478600001)(86362001)(558084003)(16526019)(52116002)(186003)(53546011)(5660300002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c05oL3V6ZTNFYTBRdEU1VDh0TzlubmNhb2QwOGdWT1Jkd2RNMlBvcDRXMm5W?=
 =?utf-8?B?Q2ZCZmdSK0F5UkVPSUp4UjEydjc1aU1uYXRWTTJTMjlydWNEWWdvK0kwUTFm?=
 =?utf-8?B?TUlUeWlTWlRWcy9KWHN1dm1XUlQ4RWFmdnNmcTZHak9TSWYwcldPYTZFMlU3?=
 =?utf-8?B?M2plbmt4cVo3UVpQMWIyS1lKQXEvTDVQbUVLZjl1RmNvaDhXSWZ6OGFSNkY4?=
 =?utf-8?B?d05paDRrUHRKT3o1OG5hbm1hYVlWeExZK0VaRE0rR2FKaUFRNVpRaTYzYkdX?=
 =?utf-8?B?dTVldllIZXBjdWVoVkFGZUlDNEE3TE94ejg4bnhHb041ODViVFpkSVJlLzZ6?=
 =?utf-8?B?TDhqZ1ZISTVJRU1qSGtJNjJyWHJqdFBxMWJIMzVVUytyNjBuVjArdkhWbFBL?=
 =?utf-8?B?WEZWRjltS2VwaUhGZU8wUU9FU3RmTCtOVng2TS9ORjlRVTFmZ3dqTUl2ZFZr?=
 =?utf-8?B?UDBUK2phbXR4cVpKQXd3dlFvVjZIek1HZ1RPNkk0ZFVWQ2FRZ21MYjdrTFVY?=
 =?utf-8?B?ZkJ3R2Erdlo1Uk9MWHVMWmlrOVJuNDRoMmhZdTJzVWxZV011c3ZjNjVFdlZ2?=
 =?utf-8?B?eHFyck1DYzlmUWhrUW9POXhiWHVNeFM0WnpTTmgxbUhRbElpakJqM2svVS8v?=
 =?utf-8?B?dDhGOC90MlJDTTR0cDUyTUVhbzdpb1FJVlpkVGg3V2lTeHBVcEEwTmVsUGJW?=
 =?utf-8?B?akMxenZUWGtvczAveEpFR3NPSWFyQ0Uya3hFaytuRkcvUVk5enVtbXJVZGNC?=
 =?utf-8?B?OC8wL2I5U3ZPWlcxU2VCVytpN2tKQzhVSjBvbm9MRlZ3RmpzQ0hTWjh6aXBN?=
 =?utf-8?B?RmxqMmpsKzloSEgwQWZOWVNCT0g1NjI2c2x0WERreFhQWmowMFR0Q3A4eE9P?=
 =?utf-8?B?aUFBVXNLb1NHK2NwNmdBVHBocU5lOHIwczFTRDF0U1BEOUdkZFZxUDdIc25Q?=
 =?utf-8?B?cGF3N3FpWEE3ZXB1KzhHTURhUUc4UU43SkVRZHRISDQwbERuZmlwYUd2bUlV?=
 =?utf-8?B?cUhSWGpOeFVvbXF4WHhIUnYvejEvWnlmbVZueFRtT25xZU9UMithWGVDUTZ1?=
 =?utf-8?B?SFMzZnZqMkk0cXllNGRJcmJtaWF5eXppUnZUcVZyalNnYkNJeUJ6aU5DUUlI?=
 =?utf-8?B?UW9WZ2VpT0lHL3dYdDB5bHR6TlNDR0tNMXpsT0R4RVFzTmVpVHdQcWJTRnIz?=
 =?utf-8?B?Uit0b0UzTEtMNnVFY2NMVlEwRmpqd09QMkQ0citvSFIxK09tbjJiNk5pb2lR?=
 =?utf-8?B?ZjZmc0ZLeEZKUk1TRTdiZW1rd3pYTHZPUzUva0NXUjgwUjN2T1FEdm5mZHl6?=
 =?utf-8?B?Q0hHL2pNcjJ6TGV5NHVFa1cvYU8xWmREM2RXQUVUNGpyZDU1MXhacTVrRU1Z?=
 =?utf-8?B?T3ZkVkhLejhST1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c37ba4-fa90-4b86-92ea-08d890aca8b4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 19:10:51.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwmbeILFmBR8dl98oeZWhvSuEZbzKT/t3WoCXgvz5vMoZTtc1LdE7EJNWYCGWIn1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2327
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_06:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=916 lowpriorityscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/21/20 6:22 PM, Andrei Matei wrote:
> The link was bad because of invalid rst; it was pointing to itself and
> was rendering badly.
> 
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
