Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C947532DA89
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 20:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhCDTow (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 14:44:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32211 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236812AbhCDTon (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 4 Mar 2021 14:44:43 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124JcRgD013240;
        Thu, 4 Mar 2021 11:44:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=F8GXmDpNrYd31XW+U7WKBfV6NA4a/I6s6IS74M6hL68=;
 b=Fo/LmtOpOb/EncOGCMb09gZ4e2JG6TNu3cHFbJLUlqFri2DT4AiFshuoC5kSuz2JqZNS
 3QKM/6ZN5OoeKdtLHf6Ltj1EXJpQZLMHrthJHVNAXCijc2rX7a+HLZnQWlPFkzk8q0Nn
 31H2HdoP0jNpa+6tE742gBwIPAWtPbCUHJI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 372kycwfte-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Mar 2021 11:44:00 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Mar 2021 11:43:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxqK7rZUPL10BQcW/ksPTSXAqf+rZFuqBkl+5Ltik0Knpz57i3hoZgWfeQ9KzhiewYTqtv05ZdWCwISkjGNXrPD+GK3qeTyv3ODOJTeKrzACMbyK5d9FXjp0q5+KM1VmQKcsbaWtm/xlzeufrw8bwrS0In3UxUowat5bDmIlXmKdBONEPOSvfoLpZ399T9kzMsjydlPQboTtoMBn7J0f80XWa+BxattLYfeoFuRTwvPa28sRCM6H6GED6yUu55egLYcc5Z5Qi1/ZFiQhvkqLk4jecFj7L6nm1ClBydJQGMN3zj153rWhz5OdY7r7s7OX/ajaEW9q7+kFD4i+k4dmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8GXmDpNrYd31XW+U7WKBfV6NA4a/I6s6IS74M6hL68=;
 b=Cq1AtM1sh2PAComRtxpbWv5d+XCsEMhkvxv1/wbOYypFTkLL4Gl5LBjVxZs+2iw64CtxQ/pGwYHVzfLXBbf7mN2p/lSFNW7zNqSDarFmjLgA6B4kuZRs4044KdwFWkL0ePq3KqpjqfkIO23Hkt0wzz+wxD1DuZyjgkG69gT3Jto8sA/UD3QLA9+XBrjB2fBN3zVH+tJxehK2w426lE1SmmSk3EKKikN706U8oZLkL7rngLBROgEptOMOR+pzgNb007HE8Jhf78dmiclQr7hZ/9Z7u8pBMNmHgxki9lflQkOCK50czsuz2ZEIlgKW/ve/ig65dVGC8s8P+I3gfaYhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3967.namprd15.prod.outlook.com (2603:10b6:806:8c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 19:43:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Thu, 4 Mar 2021
 19:43:57 +0000
Subject: =?UTF-8?Q?Re=3a_bpf=3a_inode=5fstorage_lookup_element_unexpected_be?=
 =?UTF-8?B?aGF2aW91cuKAj+KAjw==?=
To:     Tal Lossos <tallossos@gmail.com>, <bpf@vger.kernel.org>
CC:     <kpsingh@kernel.org>, <gilad.reti@gmail.com>
References: <CAO15rP=MCzHx74Wx1dp1b-DCpxAp3CAPK_cg5=642WkCCnX6ww@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <355027ba-e67e-6c18-3f6b-2749e4de25d9@fb.com>
Date:   Thu, 4 Mar 2021 11:43:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <CAO15rP=MCzHx74Wx1dp1b-DCpxAp3CAPK_cg5=642WkCCnX6ww@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:1edb]
X-ClientProxiedBy: MWHPR17CA0056.namprd17.prod.outlook.com
 (2603:10b6:300:93::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:1edb) by MWHPR17CA0056.namprd17.prod.outlook.com (2603:10b6:300:93::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 4 Mar 2021 19:43:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74ec48a8-3131-4f23-3e2c-08d8df45d97d
X-MS-TrafficTypeDiagnostic: SA0PR15MB3967:
X-Microsoft-Antispam-PRVS: <SA0PR15MB396700E4E15B23EFAEEE4ACBD3979@SA0PR15MB3967.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHWECH7TMTyhsap7l0w/ZThoFjRHstdw2QkIofvFxeQAKqsWlDFPrxJulpkzKo2/O5DNuO4X7HBRCi8rn9O5ZSPS2O77gPetgKgqsNOpDncEUhYaE/JohWYSiyrc+toR1IQdCLk2oHTIwVGzo1axtCeYHQkyDPyL3u5O4SN8eaYOv7hCljQ7tXXDIJIilSg9EV/BEOkTLPW4e9u6tpgoMUbI0xi7lSTeSJcEIrTOwtRUzUs4ln7CmssEzPtx8iUB4rFuseQKEDPo5SlG9NCko1efLtA2bvvW3i1q1XnPQ6/B8DbcL517Bz/H1Z1ZdfP6zITFFhHnQYkGehxvswrw5f+4nMk8FUnDgkQFJV64W6xrcwHS3QUjfWTs9qz3YqczLI2XiebKQtieNOVHkp20LGRxN2Hu8ZHUpHCYbp1UXV8uaJojCyr3cOmjL+zCJ4YB6nNo33GtpmxIDOuXXRwIoVQT4mUs518/RgZ2wSex7JHMwN4ffhreQu+5U7ztcTk82IXUi4ZG0YPPsmhyxG9ybUzTOVuk7vnMwoj5ao7oTjnXCqPpg4uW7OpT+5ppx63mhaI5Cp4qF6RoZ2lCR2ng8ds3PC/Luu5bw3CjYU7ktBA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39860400002)(376002)(5660300002)(86362001)(31696002)(186003)(36756003)(2616005)(31686004)(66556008)(4744005)(52116002)(16526019)(8936002)(316002)(83380400001)(2906002)(6666004)(53546011)(4326008)(66476007)(478600001)(66946007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RlZRZHZCbEdTNHp5ODRERnE2d291TGRET205c1JOMXpSTlNGeHZtYTVkRjdI?=
 =?utf-8?B?b2FvWlFqaFVDTkd4TE13OFptc1VhRTNuK2FBM3Z0Z254cU01eUhhM3Z0Tm9D?=
 =?utf-8?B?SEpUQ1FFdkltTXBVbDd2dGlPVU1GaVVJTW9kaERPYVlFRjBsMFNCdEtiQUxM?=
 =?utf-8?B?ZmRsd1laZFcrU3BRR3JyRE9SZEpMVitHTEJXZ1NDM3oxZXd6S0M5S0lNbGZw?=
 =?utf-8?B?RzN6dXN2dWl4TDVvRmZWZEdZUkp0dFJmcUdjVjhFT0hkUE1WT3ZxZVJ4Mmlt?=
 =?utf-8?B?YWNVd0w4bUkwVW0zd1NyMUg5a2ZNT3RDbTRadFdoUThCVGdFRzVqNmZQeVc2?=
 =?utf-8?B?STdBNFJ3U1FKY3BodHdvczZoWi9xWmlVSDVwNGNmODJJYUgrSDJrTFkzeWZH?=
 =?utf-8?B?TnNacFdTc0tBWXRMaExZZHFZR0tmYjk5a1BwM1p5SXBGUXk3bTEyZFQrclZS?=
 =?utf-8?B?d09Dd3BBVElCTDRJeGpzajVwaHdORytiOHlOaUlOMktXdlNJRk1zV09DOHFM?=
 =?utf-8?B?UGNtUXh2cXdONGpuajIrRWpjZWxRMnZBUEMzQmZhK3dIdnlVQndRekU5enh5?=
 =?utf-8?B?R0p4ODlpcXp2dFI5ZnJLZldLVlU5cER2c25nUityMXVhdXo0Nis4dTlXK3NQ?=
 =?utf-8?B?K2dOUTQwRFAwTk9VQ2xPQ0tDM2F4Z0VnNUtVTVVjQmZqMWJpTVVFMjMxejk2?=
 =?utf-8?B?VGdsazd0Um1GTmR4U242RHBseUdtUSt6MzVzUm5vazU4V05mTVJnK0lsUkk3?=
 =?utf-8?B?ekN1NUZqdGhjNnBtbGd5UFZ6VlRPcXNsbVNoNmErdVFzUlhqVXNBa1VxeldV?=
 =?utf-8?B?TU4zVDFmNzlITEpURGttZFdvTS9mRGcxWCttSzRIbzQvMjkxenlKeGdXdzBt?=
 =?utf-8?B?UkRtQUUxYVBVT3BvbVhHeWcydzdKUVJ6Q1NTMU81YS9vQjloc1FVaFZoc3Z5?=
 =?utf-8?B?Vm9nL0dXQXNGb2hiNk1LWGRDU0wvdEYzajhFSjQ2eVNHZmgyWXB3VWFpbUw2?=
 =?utf-8?B?bFVkTFNMQ0x1QkRCLy9UeTVoV0hnazA2dThLalEwVC8vaFh2dXFza3hIanpG?=
 =?utf-8?B?WGdGTkliMVR3NElBZGRmdmdjQlU0aGdMdjR4TzNTNk5IYWYzRW9JS0FualBy?=
 =?utf-8?B?U3hDNURXcm1pUDRXY2tXYzV6Ri84SU5aaTNIV2YwQjluRnJNdXViMGJEbW5q?=
 =?utf-8?B?Vy9COFQyRXE5MUl5ZmcyK29XbVVvdDM1elJpem5DZUZoeWRSR1k2R3cwdjNy?=
 =?utf-8?B?bE9ZVEJoRnJialJJT2ZwdVFVNDdWV1FYNEhiaG5JaGxZTHB0RG5VQUJObFhD?=
 =?utf-8?B?bklKVWNOMk4xeVIwUTJXQXYxOGxKS0tNZVRBRTRqMFh3bittbFNQSjlQdTBj?=
 =?utf-8?B?SlVRMDRuTW9LcUtGb2tkQjBGL2RrZzQzM0krSkJFSUtpLzVzZ3ZtSlF0SENx?=
 =?utf-8?B?NWg0cC9BVy8xQm1lTHM4YXByWmpCUlJUd1g3T04yeG1hdEE2L0puNFZuQ1Iv?=
 =?utf-8?B?eEt3VDhVK2l5VDNPN2wvanZNQytGMFdqNzVDbjdyQ3A0QWJKY0lYaTRwREhB?=
 =?utf-8?B?MTc3UG4rZVF0VWZmK3IxZS95a1ZsTCt3N1RmcDBzV0ZVRXFtRG5uamovRVEy?=
 =?utf-8?B?dy80dTUveG00R0VSRGJBSjdwODl3b2RNQ25DejFpSXljbGNoOFI0V2RmcHF0?=
 =?utf-8?B?cEdod1kxdmozOVVUUEQ0U3orNWhFRkZVZ0hXTzB0TnRobTBmU09oRHc1R1VO?=
 =?utf-8?B?YklENkFhU1dDeEF1cTAzTk4zbm5ZVU5xTU1pWGcrR1pXQ1hTRkZEa0F5Z0RO?=
 =?utf-8?Q?I3QIpIoH1dBdaiIK46iqQitQb19cBTh9DQpxs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ec48a8-3131-4f23-3e2c-08d8df45d97d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 19:43:56.8885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYijN8hndN2vYHvdmYliIM4TXd/KnYJxwCEw9nLCuE8+jekZLo4ytUldq/lgYbaH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3967
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_05:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=766 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/4/21 7:11 AM, Tal Lossos wrote:
> Hi,
> For some reason I've noticed that the current inode_storage's
> lookup_elem func returns NULL for a bad fd, which causes ENOENT in
> bpf_map_copy_value.
> This behaviour is different from the other inode_storage's functions
> like update_elem which returns EBADF for a bad fd.
> 
> We've checked in the other local storage maps (tasks and sock) and
> they return EBADF for a bad fd in their lookup_elem func.
> Should inode_storage's lookup_elem func be changed for this same behaviour?
> I could submit a patch which changes that behaviour.

Yes, -EBADF is better than -ENOENT. Please go ahead to submit a patch.
Thanks!

> 
> Thanks.
> 
