Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A43416449
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 19:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbhIWRXi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 13:23:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242288AbhIWRXh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 13:23:37 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18NBTbxS019740;
        Thu, 23 Sep 2021 10:21:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FwVsRPwKE2A1gny5C/yLOHFqfhTvSj2Apgje57FK93I=;
 b=LfF6nr2hxy7GwQ/fXL8iJKpfiVSuyzFPhJgPDFlS3USahs+Kt3lYFqkXgHlBEbwm8y+J
 aHJR/QRxev581bX3v36C4Fg7x7Hs/JUGlaGbnXRsA/wz9BTwUFLpgoxBXzT1RLO7TQNj
 ZdNiSGbvagFEjhQe+TDtpuFUpEAlO5bfe+0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b88bdgdx8-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Sep 2021 10:21:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 23 Sep 2021 10:21:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4OqI056JFV44PcoIK8QnArkz4tbDumffK6rNzbZdonY87A2lwzm7TuPu4CZD731YiZVsvqutnOLYIQ012X162G6VYfn6ol5qW+AfSzzKOY8CCa2iHqaBJumuXrXP9mkuId9KJsTT4bJYHSRnOpsoAVP4wWxCTVIJS380l623SrwspVT10zZlDJs8YopRoXcy835mBjPlCATw4PXPo3QN4zCO/8F+jiErMUQ6mXIDmB2ResNnbu/f2zZ+LDkdZNfMIiy4PoWpeCVjl95p64xB8v7F1NKs8ddri7IaP/yYhhPlX2Qqd6veECUTkSYZwgwiRMnNcODwR/KQMjVTqRQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FwVsRPwKE2A1gny5C/yLOHFqfhTvSj2Apgje57FK93I=;
 b=Bhf4UVVsNN6zo4S+vtdADTFa1hG3S87z8zO01mAFb9+tBb5Fvs/h7P1nSf8LvamJRxBYeeSr03M4twrtXjYSRp4IsgeJGzTNmC0uSwg9UOsNsbvcFjyqqQsoHArS0gOcYCOXA07jd1UCpUSNnKS4oPyJUAb5ysbmlnOOv2eN7cVnSnIY3AN27hp+Y6zlC89u1w1ZF4PS+Qb8xR1qoam6py8KNcXLbfmTXM6nOpw97ur5d8uVYQTfCP0SpeKYEQdR7D4M+Wwm7Zes5TZu9xFxYsxTmwZS1pGsn8xufkxtBZYa6u3zwQl0Gpm/ixVU92TE0sB3iVymxMrT6r0ohLlRbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1514.namprd15.prod.outlook.com (2603:10b6:3:d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 17:21:46 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 17:21:46 +0000
Message-ID: <1b4e41fa-9bc4-ee98-b10f-7688fdab4ff0@fb.com>
Date:   Thu, 23 Sep 2021 13:21:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v3 bpf-next 6/9] libbpf: refactor ELF section handler
 definitions
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210922234113.1965663-1-andrii@kernel.org>
 <20210922234113.1965663-7-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210922234113.1965663-7-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0022.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::35) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [172.16.2.93] (67.250.161.190) by MN2PR15CA0022.namprd15.prod.outlook.com (2603:10b6:208:1b4::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 17:21:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f50aa7a-bca6-487f-1572-08d97eb69eb8
X-MS-TrafficTypeDiagnostic: DM5PR15MB1514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR15MB151491EB5DD5E26D61E1CA5FA0A39@DM5PR15MB1514.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1w3pzbQCQcfmtXV908zyIhUFqOELKvlmYjVdf2JHec+DCIM+vaGgXJOZP2BK3I+JeNkRL/dNtosbLcTrCUkvf2MbJ6/TkCctNwyeJPlvaPZwY9FV0eQCmicseGbmEARMxUgoIph7CSXx27c1+Bs4nMS505SkJesKwCmibGQa4DW5k8aiSYXHPXbrETGiQ9rAtyiQZgnLevPWv+h/ZVdxt4gbIc+VBeB1OqEqjGWo1/adHyelKBPg+aL46t1fCsrQ4eYgoJ+ZfRKoSOnFChVzMunvTWYdoLfIA9vnLtImbDY9AWRh6vYWL8ie1sHkozdI/F305R4TvUnDwp9Y5UYmI5VMXIECmWRJeYLt68mGCk69FphhmBG0BrgV60mjXKRe2h32cnM73jz4HvwPrwgwRgt0DDG9PwQ/HpBpKHcl2s80gjjOazQSdeg4lsl0siODmHl/1mTWs/PEGJ7dbfa6iZ5ezyAbmousqEWfRYcYFuGOpNmUK7OGOjUKrQ40ZGuy1eE4uENdxPvM9JvMoUOnW0e4uSi3iOvQp0CclQnMEeuyLVngdu5ssf+isYkpn5lvM1tqx0sNW3Ua2NGlHgJrKVfL4sRvDCQVGrQDyF6qwaqjmaHxYAqyp1NmrAESdvDPlQNS05Tab8+D2NmmnfaX/5OSa+cs8bEBXPOgoOv7slj9Z57FMnK2c4zf9lU4/tfrj+vqRt4UExaF3KCBAuZNurUNFhXFqtMrbFxOM2up208=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(16576012)(8936002)(2616005)(4744005)(66476007)(956004)(186003)(86362001)(2906002)(316002)(8676002)(6486002)(31696002)(31686004)(66556008)(66946007)(5660300002)(83380400001)(508600001)(38100700002)(26005)(36756003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk5FVWt5TG5MemJDelRtN0pub1dFY1ZFWHhKakMrTlVKOWk0dExvb3dlc0po?=
 =?utf-8?B?bDkzK3ZLdWJCb2NYQzJEV2krQWlhVjQvQ3dHWkx5UHJXelBKUU9JdHh4bnFE?=
 =?utf-8?B?TGhPNHkvbFA1Rm1Odk9aRTcxY0JlOVp3QUlkN1F3V1orZU9lRUNkZW84VzJP?=
 =?utf-8?B?SDl0ZXZ6SVc0aTJnd202N0dtbWZibzhZb3Z6Snp0NDlGMVNnWEtweThQWk9t?=
 =?utf-8?B?S2JOWDE0NWl3ckdyUjJPMGxVTHBPTmxsNjRVT2VINVhZVkhhM2Y3SEtTb1o3?=
 =?utf-8?B?aGwxL3ZsYS8zaDVxR1JiQk5CVjhHT25VWFgzaDVLTUJxODZoMGdxQ1NyTFZy?=
 =?utf-8?B?WmdyYkEyV0VBclhEck91OTNFUWk2aXdNeUsvT0R4U3VpWjdSaFBXZ1dRT2VF?=
 =?utf-8?B?Q1QrMjZGdkFtRkxLeWZiVHkyc3l1YmpWK040RXRkSG9jZ3BwdUZZTlR1bUh0?=
 =?utf-8?B?NFhTUnV6YjlzenQ3akdvdktqYlV0eHpzOW5FMFRBeGl1RFRqQzRTeW5IWVNF?=
 =?utf-8?B?N05ZT1FCWVF6M3E0cFpVS1BzRXc1ZVoyN25LMlg1YkE1aW1vb0ppTlVFV2VQ?=
 =?utf-8?B?ZEFMN2RmdHBEc1BtUVQvUXJRejExSnZQSjBJak9iVVczRFUzRFhPOFBnMlZR?=
 =?utf-8?B?ZmpSMDhxTTNlNzNMMlRVQy9yNGNLTWxhdi9Hc2x0RU8xTTNEM2RtTTQ2Q3p0?=
 =?utf-8?B?VU5uS0h5dzNsU3c0K1plRzJPWFowbzJPSWFNcE02bWxjaEhQOTU2dGtLR29u?=
 =?utf-8?B?a2phUit0OVdIRWMxdlBsYjFpVmFVRFFvYm5QazBleDhtSWErOXlEZEdJc1cr?=
 =?utf-8?B?azQ3YmQxclNXZExtd2gza20rU1BnZlJ4QXVUWTJNeENjRVU2aGp4eWF1Ukph?=
 =?utf-8?B?K25QbnMwaG1GMkJKMVQ2aERxWHhJd1FOVHZQRDU4by8ybkJEc254Y1BveC9U?=
 =?utf-8?B?ZzVGaHdrVS9lVkN0MDM2Q3lpQmhmakJKYUF0Y1NwKzZ0cWZDa1RvVUhmenJn?=
 =?utf-8?B?S1pOb2JnZkNpbW84U1VpdnA3UkhnM2hUWUZTV3U2VTVxU1VRNXhnSkxIblgv?=
 =?utf-8?B?WDNFOU44VXNvU2FaUzIyZlpGSHd5aXUyVGZCU2kxNUlqNTVtdE1SSDZFbGxC?=
 =?utf-8?B?SnoweS9RRGN4Vkk4Yjl3RlZpM0hMVVplRDFuNUMwZXVFUUttdEtTd1lqaWJk?=
 =?utf-8?B?Y01qMHB4UHVWaWY4d2h1UEJwd3V3cEU5Nk52eGZQNXFHbTRoTXRQQ1c5b0U2?=
 =?utf-8?B?YXA0c01ELzlmNnl2L0luSkdwSk1XaS9neTVyRjExb3EzUUp2UStRYzhJY09S?=
 =?utf-8?B?TjBmK3RzczVzanZVWUVPK3M4ekVsdmdtZERzTjdJZlRKc0x3bGptUkVwNXhX?=
 =?utf-8?B?VW5VaWJGOXoySEcvcU00NzBaKzR5YUFaTlZNVmUyVzZsNEZUbCs2L1B0M0tV?=
 =?utf-8?B?KzRNdWpsbGZheTlhbitaU0VXNEN0RWl6V2gxaE84cmJOTDlkNHcxUzdzaHl0?=
 =?utf-8?B?T3BsZit2Vm9zMnFGR0ozNWxqUUNhOE5aWEZqdk9uRlkvNlJNQ1Bma0FkSWFU?=
 =?utf-8?B?cUFnWWVhV3BobXNicGhhWTFaa0hpZHduenV3Y2FtL2w4eVc1S3luSndkNG5x?=
 =?utf-8?B?TTQxaDVtT0g4VXhWazdadVlkNHpmMEJSNWRGTU5UQmZqZFExSS9NWjV3Nyt5?=
 =?utf-8?B?L0hQWUIwZlhIQzh4OUF4OTlHWXQvOHh5YVdmY1Eyb3prd05ocXo1UVJ2QzF1?=
 =?utf-8?Q?60Ad9kOyKr981VLipvjmXJ+YA4SjqXIdGa9ijS7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f50aa7a-bca6-487f-1572-08d97eb69eb8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 17:21:46.4813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzq90QtcURGdYqoTir3mmzSsId8uP8RalZIVDv03zLxn1oB/zRUqE+qPesvADDHLYNo/D92/9zrnX8KyTJLrzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1514
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: hZ4bTv_QemXvaTsQToQxmSHSxsefI6mr
X-Proofpoint-GUID: hZ4bTv_QemXvaTsQToQxmSHSxsefI6mr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-23_05,2021-09-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=949
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/22/21 7:41 PM, Andrii Nakryiko wrote:   
> Refactor ELF section handler definitions table to use a set of flags and
> unified SEC_DEF() macro. This allows for more succinct and table-like
> set of definitions, and allows to more easily extend the logic without
> adding more verbosity (this is utilized in later patches in the series).
> 
> This approach is also making libbpf-internal program pre-load callback
> not rely on bpf_sec_def definition, which demonstrates that future
> pluggable ELF section handlers will be able to achieve similar level of
> integration without libbpf having to expose extra types and APIs.
> 
> For starters, update SEC_DEF() definitions and make them more succinct.
> Also convert BPF_PROG_SEC() and BPF_APROG_COMPAT() definitions to
> a common SEC_DEF() use.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
