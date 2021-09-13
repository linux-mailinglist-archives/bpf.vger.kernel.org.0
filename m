Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA54097A1
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhIMPmO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 11:42:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244004AbhIMPmI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 11:42:08 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DF7AcU026622;
        Mon, 13 Sep 2021 08:40:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VSo9xTgmyaNJhiRZYht73VSuDMkI79a+xmTxJNEzNIs=;
 b=Kq0IWk0rp3e5hJwCjmT3yMEi8jZ+mIa8qhDngOHjG3RX1NXecMJBAOIsSV0iUdoWzAoc
 bk1ZWNWytlat+zb1BWIKnUIYidqkLqzbMBDyF9JZpKFXE2ATeUVGe0XnaeeOwxyHXBis
 6F/VJmfPzm7wutg1s0kSdihXVUA35o8exqI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1k9rnhbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 08:40:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 08:40:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlyaSIcabaO1fg4FAc46ZdGBodz2lS4RVp2lAQ8zyXw5M95tOV3eMhfoExq0rcTzQrDV7B8oKwcV0GYEiGuwrzZWlLxiqaR4bjee6kZvKzEwiFE/I/3xa5WDGK8hrpcXSIGUbUL7d8AQ/aL0WXSEzTwPBhfT0pr/wCd2XvB2VRwLqlydZhBCyNK7u7ZapG/JXVV2h17eltE95YGuAfI97XyCv2lfYvRW3zQNZmgeFikvr5PBlMkEgX3mAcJLeluLwC0fBamyUjR6/Vp3E3YE0fi06ONB8JRuCPu5EDzeXBeO/Z8OoMN5aRb/Yqh2T/2IWuaMVhON3DbwdZMcwpS21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=w6MQ0zVypIDrg9sS+Som/C47OOhmbMmNuoImvWz4Zow=;
 b=Fz1/2J4HacvuTKYoXjWIDIXxIVpY8x1vZ6Jo/NUwfB/KcWF4QLlJLnGpl/E4CGAh/zRHUgTRgueUVbeiC89YBowJwcheet9XwUw2vDrkmGwztysvet4Vl7K9oxRRGC/F1qOVopmlKKo6XTGeR00OW6YvaJPa0nlbNtcIngdNYe0JlivHWx2c3ffnaZ7IWSZzm2n5g030Yh1aZxG+PFFMpG2IrEADpSyioPi+2C2IgfOLOJY0e9maUanUfy9LY9IxSXhAeaD5VPuN+H9SLoJBOCvdOG0J/OOfPj1kgyOLR2mlpcvB9aUQ3yy79Mj7UcicrCSgwqc9rdFVTIAMw0/GJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4337.namprd15.prod.outlook.com (2603:10b6:806:1ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Mon, 13 Sep
 2021 15:40:50 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 15:40:50 +0000
Subject: Re: bpf: bpf helper with locks
To:     Tal Lossos <tallossos@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAO15rP=00cCXkyV83JQq0xwgcFviKn0y92ggtos52qHZO01dhg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b1906c41-54e3-f4cf-2b91-3826170ac2a0@fb.com>
Date:   Mon, 13 Sep 2021 08:40:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAO15rP=00cCXkyV83JQq0xwgcFviKn0y92ggtos52qHZO01dhg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21e8::132d] (2620:10d:c090:400::5:a3) by BYAPR21CA0015.namprd21.prod.outlook.com (2603:10b6:a03:114::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Mon, 13 Sep 2021 15:40:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afd10a37-91c9-4237-c49d-08d976ccdce3
X-MS-TrafficTypeDiagnostic: SA1PR15MB4337:
X-Microsoft-Antispam-PRVS: <SA1PR15MB43371BF51F326ED8324AF5A4D3D99@SA1PR15MB4337.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: izGTt9o5NI+pG99e9PUtjfuHtTFzpP3bTFSOYHINa/iRCI2TtIoTKr7vzKgUlVP6FKlYhIk806XL8pET2q8lAnaHfkkyHXU0baHAjslMa4YPcl4ru+1AI3ei0i6Rb8n4Nq21w4qcrBNvHzs5gDV8HTKbPkE8GC/mgkuKM1rkZroO18OAF3PSHwm4a93IUEr3g/vWagVcChwiLPFhbhKTEpJ7uX1ZlOaWYRgCQBgeoSoaecjpYJcWPZ/bWGQcC/FO3d6ih7hQU/Jt74X0ZgUemMA+ll7E+wBbUfdZGM0v1yJ1mBH0k8vb8olxcnIQx+CeIHWF6u6pqMDClY/ZbC5iW8zDnBWrcxGKxwJvtlQ7S8KEX1cEseznf0Gz966WksOQN7qHw3822v+m9sEUvgDuOkc1AYmmiaaid5A+6zd8p0Y4WFLBVxun13upWVV53tMLMtbu1BeHIs+miWmwfzHSqEjFmXvhqnMgpJ3aNwSHVqGUQnnQ8DQpv5py/rwDKwKLTZgSF9iQnrLcvph7GTGH41uZXh7DRf06Cih/XUZbHJyvrZOtng9daw1i21GN/8THVtjsQe8HYKsEgzyWizE84H00OsYMCX++JUVW3JPrih+4q8AXP4k3BmesjXxQZFje8f6op4BLhOXyCl/t0nTWWE5YTgDg88KcT3Qdjl0c+RkrQgxyehawpN4aqW1KiLzXs5TYa2VjT3iHx1gZhMbZLCLcExuh6CchUlVojiVezw5pNr1NKWBhx4/reZRxZKf28aD3AWoQDHw9GyLpQn4kDNBVUQk0w2HKrXoAZwN+C4OTQnqV+Wuy7UweNxiMCKw4NGE2Q0/lO48tHKKT3DKMygUWaxPI8bx4DFJnINiEXp0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(38100700002)(8676002)(66476007)(66556008)(83380400001)(31686004)(36756003)(86362001)(66946007)(6486002)(2906002)(508600001)(5660300002)(52116002)(966005)(110136005)(53546011)(8936002)(2616005)(31696002)(316002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGI3SVpGa3B4OUcvWXpvbDIvREI2bWV5LzF1QlNEWnBsTDl3aEM2N1hLeHQy?=
 =?utf-8?B?L3Q1OHBBTVRkdGdSRXJUUzB4NUw1cVNvSmFaVXlRTTQ0SGo3TDVuTkcxREFR?=
 =?utf-8?B?ejFkMlJuSFpTTkplSitOOHFPb0k5aUQvNkt0WjZGSGlzVnhraHlmRDFNYWp5?=
 =?utf-8?B?QmZBdW41eHo4VFc3OHF1WVhVYXpOUERjNzB2a3dJKy9ycWxzaXlKSDJWNHpu?=
 =?utf-8?B?VVlTU3RxaVljSUJ2Z0ZWT3A1MjJLdFgwLzc3TEVWZ1lhbjMvRDJYVVNTTlVM?=
 =?utf-8?B?YnZvY202dzhaV2ZaVDRzelZBMEhDYVpVNWhqOWszb2xIdHZxVW9mSWtUbVov?=
 =?utf-8?B?ZHB4OWc2RlpQSkdMbDIvNGljVC9JTW9oN01mcHkvd1JaSWdyeC96QktNckU2?=
 =?utf-8?B?WTVLUEJRU3Y0TVViRldKRFdXSGRnTi9LNmlpdTBxZnFKTXNRU2c2VmRwV0Yw?=
 =?utf-8?B?dFRJV0IwRmk3ZnpqVHJPZzhIQ1pkTTVnSXVJd3pWaHM0QTdXSWg3bXorbU50?=
 =?utf-8?B?SUtGbjJld2xPOUlHSVF6ZWNLNWFzZis5Q2hjVE8xQ0J4RzV1NDB1eGR2TVRa?=
 =?utf-8?B?YjFkcjluYjhkQmVJdmtRRmM5YzA0UWZiYS8yUmttSC9Vdi9aZXJzYSszUFdQ?=
 =?utf-8?B?RmIrYXJCYWRaUVV6S09rVG5meHYxYXFpT1JwclJNbE9hdjhMME1wcmgzUy9N?=
 =?utf-8?B?SXZEL0J1d0JodHppaWNKTk1VdzQzWWc5OTF5WkVVYnpJTG5xVHhXakpUVVcv?=
 =?utf-8?B?Zm1Sa09mZFJPU1MxMEd6RlBuRVlYRThrRjFQd0V6NzFmUmlLYktzcWxTd01m?=
 =?utf-8?B?QnVISUY3dEFzcEo2UDBwcGIzaFRXL3RYOEtkaTQrVGhPd2tkVGFienFFOFBF?=
 =?utf-8?B?NjZOZ0dmL1RNNDY2elBKOVRLUkdUK3N5OGVQNjY0bDJmeXpiaFdtY3NjWHY2?=
 =?utf-8?B?aW9DZlAxRFl2TVFIUjVLcGtlOHozbzkrT0tqYmZQN0JuOWdCUkpuTmJCMUs2?=
 =?utf-8?B?SjlxY1dkblpySG1EaFVKVHVkWnc3REZjdkt1WjdUenR4M0Y5MGZHaVpJYUtD?=
 =?utf-8?B?VXR2YmE3SjZtRWg3UXlyV3hqbXhkWUl1d3Y3SDB2MFFKYitQaFlHLzBvWFBY?=
 =?utf-8?B?WlkvWFRpb1Z0VWdHUUJ3L0xJTXA0ZVM2SlVPcjlnZkd2Z0NmZmkxZWdBNXhD?=
 =?utf-8?B?Y2lVRURHWEZDS2dEL2FnNXRTTEZhYmZ6KzhGTCsveE5vbUdQNnB6VUd2QkFa?=
 =?utf-8?B?Um5WdVhqUEc0Y3ZIQWRFZ3pvNlpZRzBQZHNlWlVQdVhscFFGQ2t1NXNFK05V?=
 =?utf-8?B?MmppMHBGME1Kb09KdmR0Vzc0Y29tL1pPREFIL1BHQ1JiYTVnWUVTM3RoUGVz?=
 =?utf-8?B?RjZwYXBWdmFjNDYySGFnWkszZERpRW1wbW5Zd2ZBcmJlQnBUOHFxYlEreE9C?=
 =?utf-8?B?RWdiQnhCeGRYc3dkTGtPaTA5elE1OUw4b3pYNFpvZERKN0wveTMzLzN5YURa?=
 =?utf-8?B?TnRsMjQ4NWdDc1loclllWFJXWkVHTkJ0Z1doQW80U3gzWmNZN0NheEF4cGxD?=
 =?utf-8?B?cEZFQVN2d0xuZmR1UElMb1NtVFFJdlJOUmRkc3JMVHhpdTBlNjVVRFptblUv?=
 =?utf-8?B?djdHU0k3MmhjVnlSKzkyRjFlbndZenNsR1RSSmhhQTA3ZkVuZmpZeG9RYSt1?=
 =?utf-8?B?VVpWU0szV2dGc3k4OHRIZzJOU3ZpVmF6b3NleFJvZjFLS1RkODlERFJrRWh4?=
 =?utf-8?B?b29ISFExUWxJV0ZPTG54YllycWhqRkRZZHIxNUprZjlXM3FIMmY4cjN3ZElm?=
 =?utf-8?B?MlJQUEFkVzM2Ylg3UURHZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afd10a37-91c9-4237-c49d-08d976ccdce3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 15:40:50.2025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMPjDxb984SygXmjy7TvFHIdOxtkYVDfARpyHJBRrR/Nu4nzc6Vl/CaIWmy+rYyL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4337
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CjF_vr_ON9IMyWqBnTQH3nlpjQsalfB7
X-Proofpoint-ORIG-GUID: CjF_vr_ON9IMyWqBnTQH3nlpjQsalfB7
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_07,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=835 clxscore=1011
 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/13/21 8:03 AM, Tal Lossos wrote:
> Hello!
> I was planning on writing a bpf helper that calls a kernel function
> which has locks in it.
> While researching about it I've encountered this mail:
> https://lists.linuxfoundation.org/pipermail/iovisor-dev/2017-October/001137.html
> Is this still relevant? If not, do I need to do something special in
> order to implement it? or can I implement it just like any other bpf
> helper.

Please see the patch set:
   https://lore.kernel.org/bpf/20200825192124.710397-1-jolsa@kernel.org/
which implemented bpf_d_path() helper. To prevent deadlock or other 
issues, the helper is restricted to selective contexts.
   https://lore.kernel.org/bpf/20200825192124.710397-11-jolsa@kernel.org/
more are added recently, please check the kernel source.


> 
> Thanks.
> 
