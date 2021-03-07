Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF5F3303DC
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCGSSs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 13:18:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57794 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230416AbhCGSSS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Mar 2021 13:18:18 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 127IBYlD020090;
        Sun, 7 Mar 2021 10:18:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GYrEYjFqsoFxsg787ezJKVIaCNPwIWMRrqUlR998o1c=;
 b=MIh+AGQFNoVexPGDwD/zh5bfcEthaolnpC5Rvs3H17D9Wd7MmBlygX9KRCiBBOqjpFuv
 LBVYnxwPRyo/5qZKNX36fyCw256bKIzW/3I1U7BbCXm0xu5DkfRmNLtP7W3fY1wBRwnL
 7O4B5hV5Sj18ousUYixDp3pUB+UuMERGeNo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 374t97sb87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 07 Mar 2021 10:18:15 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 7 Mar 2021 10:18:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoeesOrbhGZZyUCh3QVggKgUZJuNUlPRjhvDI3LdQFzxXVVSL1ks3eVtE2Tr900TOMBRxH/O5gLqqM909pmYKcJwEhyIsd0fcLwwmQYIrf7k69vocmo6rpbi5o+gnYirwR0Kh1LMNbGV7bvMNff5IWYJwjQTIbiX3toFTtaIXRRnuOWsi0NQTu6+bBzHhSjrt5H+fzATEOGpj5nFauZDDZmo/C4Tsu3utAKLACM6oF8Pq64MMvx8kor8jXgGkNRcZCoyr6W73Tn1lZIYOTNrv6yIKD5v1i0JBFJVbpnMTe6vrhyvWoxsaWaJIvViJAf3lkU7Tvb9lTzod5HWEo0mlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYrEYjFqsoFxsg787ezJKVIaCNPwIWMRrqUlR998o1c=;
 b=bRcFyU0Wuppd1T1jVfBAAfaz4LLRIDwv3g8zl36O7AhYs6BeEeCayofaWwDl/KvZDft9EOnSgzJXoMXR7ZNl3cs7qSDlzQOJ3TGzLgkkiXx2PHJe6EiIDju0wQNLuB7tvu4kboUnIWSyT0txWbrBx7pVCKwzDoRqLwQzMTKrFtsD2CjqoumbN86BxpgmOPc7INJpGZ/W5+qMt9PYK8K33kgV0jy5AHlqPrhxpLjCSks9dXb/Byx3bOz/mVfYbm0KNKVmzYeHfJocGuwb4YPR+25gm5MiJcpLR7FequnmNReH2pANeA4W9xH/9dnpjDJiFv9R8RdOzqnIRcCois5xtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2029.namprd15.prod.outlook.com (2603:10b6:805:2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Sun, 7 Mar
 2021 18:18:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.037; Sun, 7 Mar 2021
 18:18:14 +0000
Subject: Re: [PATCH bpf-next v2] bpf: Change inode_storage's lookup_elem
 return value from NULL to -EBADF.
To:     Tal Lossos <tallossos@gmail.com>, <bpf@vger.kernel.org>
CC:     <kpsingh@kernel.org>, <gilad.reti@gmail.com>
References: <20210307120948.61414-1-tallossos@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e812c654-a5d2-847d-c378-2271e0bdef22@fb.com>
Date:   Sun, 7 Mar 2021 10:18:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210307120948.61414-1-tallossos@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:a497]
X-ClientProxiedBy: CO2PR04CA0146.namprd04.prod.outlook.com (2603:10b6:104::24)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1105] (2620:10d:c090:400::5:a497) by CO2PR04CA0146.namprd04.prod.outlook.com (2603:10b6:104::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Sun, 7 Mar 2021 18:18:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fc204a3-5f25-4f14-a5d0-08d8e1955f67
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2029:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB20293E5666C8EBA766081AF2D3949@SN6PR1501MB2029.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFVRBfpxCxbe/ByAAzjwMuTnfPU1JvEkaneTZFQLCF7Z9mpk83aeDJUA0XI3UrF4xCLVRBXvXXzNJw4yj7vqxU76AJO/nR4s1rAPEFNVhOBwhXFOZcOPkEYXV+eiWljdGxb+OpyrPai1dRrDM0ZrzUvv+kUaII4OwpCU/ZkKFOR2CEhYF1xzumYQcUD3MgGmLFZP/F6xM/UO+rlzLf1qI/Y68prX0mFU6bZ5PgrXAXjsSycbwiElmqwwVqaKMxJHb0PH9HJ5BcE269Z91G7+SRgmdQ22EH/7nNyMTqnAziqBQZQvHYsGbelyys9id5ftulKl7LS2cJvAzlSj0TWZ/OeAZaajiqYZup4qjSsx3P/iOGdXrANvwU3LwuAANqwsm9Fdx6vnW+2n4jZa2agf3mUtVkJj35S3MD0WbAUMRVLglxQPnDB10l54lGWEI1OD92vrQAEhcakkcx/61B7fY/NinmGjCegmYlcT1hv/thJh1wTPoXiZSVwVhdSQFXliYHxuL64I/Cb8YW4N6n8BgbLCSiXuGVe8zfn9XxDKq5aZRViO/tRQ5HL8plZz7FcEoeOchACTbrAss+hhiaWAY83yEf/vtymsAxe00TDNsmk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(4326008)(66556008)(316002)(36756003)(53546011)(31686004)(2616005)(5660300002)(8676002)(8936002)(66476007)(4744005)(478600001)(52116002)(31696002)(6486002)(66946007)(186003)(16526019)(2906002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M0QwUUtGWHhGTnRNWVM2dThuclliMEpkaHNNZmdRaWRoVkFkTzhUazNqMmRC?=
 =?utf-8?B?ZGJ1aFJDVE44UkFLbWVQK3pkZmV2a2JYK3UxVFVCZnBwQ0VPRWo2bkVtRmEz?=
 =?utf-8?B?enVDZmhaeWVTU3BhNC93SjZZQmdiTXNnNXQ1aTdFZGtuc0RKQlM4QlUvbFhs?=
 =?utf-8?B?Z3lCRWg1dytBNWlSaVBKQTRZcXFaMUVhdExrbDNuZkd5MkFCNm95dDB0WGti?=
 =?utf-8?B?dHY1YjdqeDU2YUY5aFJuNitMY0R3SjZmVXlWQ1BBbkJuSXkyb3gzaG5CV3dp?=
 =?utf-8?B?OG9IZXZBblErV005eEYraE1ZeldZOXYzcHBhamZ1b25xK3I2WklzR09CZ05i?=
 =?utf-8?B?azJaeFBERUN3YUNZbUZZckFTQVMwZjB6Q1NjNElQc1J1VFhoekE0bEJMWDRk?=
 =?utf-8?B?S1p4dU96M1p2NVAyVUh6U0s2Z2ZNeEpTYVRZNUxJWmp3bXlZQzJneE1uNEJF?=
 =?utf-8?B?NzJqWjdlbnVhMWZXNU5HZ2pQTk95aXhGV1RXTVU1VGhlMzZJeWl0d0MwYnFP?=
 =?utf-8?B?YmZoRjFLK0ZpVVEzVk96MkNkblFIM1FPQlY0bVNqeW1CVDhGVVVieklBTVBX?=
 =?utf-8?B?OG9wdmYwUk1MSnNXWjYwakZ0Z01tTUNCTjRLd3ZiUGwzMVNKVVhGRVR6dEdS?=
 =?utf-8?B?UERTZzhuTEVWbm53MkhGeUZPZFJSNkVmTFc1cjlZUmE1QkE1TGxtQ1ZSdVNZ?=
 =?utf-8?B?MVcwOGNYMDJNTnQ3dVB2RHhWNU5GVjFJZ2hweVB1eW5zTXl1bWJtZW1OTkw0?=
 =?utf-8?B?QlNwRVQ3YkRFV0xhNDlnZWx4Y2VtbFFJeVNaalJYRzFoQzRqOXRyL0tVTXJT?=
 =?utf-8?B?NllTL0w1NUJta3kzTXZMMGp4cSt4dDYvM25wcGk3K0EwU2t3QnFEcHlWTVYw?=
 =?utf-8?B?cGNrZDFReFNXcTUzelA2RThUQ1FtcFFNa2hvRGtCdERTNHRqMWtqaVBrTmxk?=
 =?utf-8?B?aytBd0wvdnhyb2QrUXEyVFR6dzZ5Mk1hZlNHSndqK0VCZDFqbHBtRzhvdnZQ?=
 =?utf-8?B?MGVBRTJ5UkF1Y2dFWWQ2ZnpYd1NMczgvT1hQTkdSTjQybU9rMklLNG1HRWIy?=
 =?utf-8?B?ZVhrNHlNdFVuREJaVVFsak9ZWVhVQ3FNdmdJTHJUd0FidVVHUkx6a09aY2oy?=
 =?utf-8?B?bktsV0FBS3NTS0xjWTM2VVVGeHEyZXltbGV6NGJFOE54ZXNBRmtja1lsYllR?=
 =?utf-8?B?eHYyNE0wd2RWbnNySVpFcjhROUwraEd6NFBvbkpYNVZvbU52K09LUUlKWGN6?=
 =?utf-8?B?K051clNGWWxMaWpYMXFJdXM4a0FWaE5pb29jQVE4V1ZadWh0QTFXczhsMUIw?=
 =?utf-8?B?anByZVYwbm5nanlLaVA2TzZkN29Bbm9JZWpLeG9reEJuOU1PSGdmWUp4cC9x?=
 =?utf-8?B?bFpSYzZQVDR5RzFrRjRZVk5YR3JLWXY2RXE0dDZQYi8yN3N1ZmRac1JVSVJI?=
 =?utf-8?B?bE05aHQxTlVFQlNhQ1E2Q2lwOE0xTll6b3ZUcW84b2FERmtscTdTdXRMTkNX?=
 =?utf-8?B?T2ZvaUdXU1FJM2xsWmV2czhPVDFRazByYmhTamtLcms0UDZDR2VFblRIMFpj?=
 =?utf-8?B?dUt2VGVsWFFKUmlNMHhOZlg5K2pTajlwYXZET20rWmxUU0xtMXc2U0VxZlVM?=
 =?utf-8?B?d2lvc3hlZ1lrR3pYaTh4cHRUeUt0d1grelYvVEdtd25zTnVzQTg5a2ljVXBn?=
 =?utf-8?B?MGNtSlBuUFlYNEs5SGZuSjV1TVBHNFJTZmhQREhNN2REKys3TmZ5L1dNTDcx?=
 =?utf-8?B?WnJyQ2h6aHB3bFJUVklIS0M4eHdvVnQyRkpGVStWVk0ybWhBMG5uWldEWm1S?=
 =?utf-8?B?cGJiZzdHaVJiRVpTNXNtdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc204a3-5f25-4f14-a5d0-08d8e1955f67
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2021 18:18:14.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KiTNPo1t9rLU2alIU/eDb/mEdyDuGhh7NW+rw1L6Lafrd8IEoeRYoS7zeAYUrZ6t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2029
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-07_13:2021-03-03,2021-03-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxlogscore=842 adultscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103070101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/7/21 4:09 AM, Tal Lossos wrote:
> bpf_fd_inode_storage_lookup_elem returned NULL when getting a bad FD,
> which caused -ENOENT in bpf_map_copy_value.
> EBADF is better than ENOENT for a bad FD behaviour.
> 
> The patch was partially contributed by CyberArk Software, Inc.
> 
> Signed-off-by: Tal Lossos <tallossos@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
