Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978C6445FD7
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 07:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhKEGpp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 02:45:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25848 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhKEGpo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 02:45:44 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A50aftJ023706;
        Thu, 4 Nov 2021 23:42:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zIl48u4BYe21+gkRPtHV3RLbxiFajRNEZvJFqPzdUIA=;
 b=KLPKLCO5JB1pXXXBe4KmLhTwWH4gQFk141DLVZD+blyqkvQULygmARw7wsvzKM6BHK/p
 SggKyLFNSZLHV0GkhHvrKdNc5B8I/+iFuOLiMZ1DaQaNoaLRsLy5nbYJD6dLTqq+wAkj
 npbohxiqDcbXrls+p0YbC618w7/Z9WJMpf8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4t7fhq8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 23:42:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 23:42:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeMpweYmYslWpJGDrZPG97vpTjhhuSfdc0ChmZPEDTR6dzwKqpxgRPpgzPpxwYRihN+28NmiIUXpJRIPQ+D9WrHyc/uAhrZoVajScikwdQCrKWo2eCmrOhZ1z/Hdkk3o8lhwuW6XYk4mOQF99yzNB3VVQszSKJJHSQ3lIPdkAFg9ia0nXWYNSlmtlPelfvaVi+T0pgOVOcniysA2ypdECwaYOR8jUSJ1kDbn5BYMCkUlQ4vxxSsUwo46skr+pqSGK7MzPR0euRXvEE/T2FoX1OWcDTDm1Z+YcAysaWqUId8CeNxbQvdcE951P37IFgwoT+/26ff/8nzO8R4EbCpXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIl48u4BYe21+gkRPtHV3RLbxiFajRNEZvJFqPzdUIA=;
 b=hAapKBotzz8njQDKVS/m/eXWdK0EbpztbtGqReIHZf35L1qIDSgKiuf5GviFyu4YSb3wSqyk2oMmuBPib9T4IUIi9W2WXQA6+GnfWPvDbBsgs+a+ZDb15z2kbOeNy2mOxHZoh9W/UR23zxuQDqUneYCfdPx2DvjjucPHiSLwupo6f0pRe1+7wpx/+iL+jtD92A2Ii9uInfsxzufBpvvAcBHPqLTSP6W0HgeOhDyGkp0oU+d654AB3HDah6Yg8XFEnJlYWfpc5WhqPr6W9xYx1gFZSYgWOnyxC0b/bMUa4diuAcCGMdfsyeWeofNl66wLro6m8yRmVUwetUycYdNYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1785.namprd15.prod.outlook.com (2603:10b6:4:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Fri, 5 Nov
 2021 06:42:50 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 06:42:50 +0000
Message-ID: <bc6ddd1f-b614-294a-5d6a-1a6af4ee5259@fb.com>
Date:   Fri, 5 Nov 2021 02:42:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 02/12] libbpf: pass number of prog load
 attempts explicitly
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Hengqi Chen <hengqi.chen@gmail.com>
References: <20211103220845.2676888-1-andrii@kernel.org>
 <20211103220845.2676888-3-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211103220845.2676888-3-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:208:2be::26) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::102f] (2620:10d:c091:480::1:7c65) by BL1PR13CA0201.namprd13.prod.outlook.com (2603:10b6:208:2be::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend Transport; Fri, 5 Nov 2021 06:42:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 910e76b6-eb88-4f41-6836-08d9a0277c33
X-MS-TrafficTypeDiagnostic: DM5PR15MB1785:
X-Microsoft-Antispam-PRVS: <DM5PR15MB17852652C4C6526CF8E7E6EBA08E9@DM5PR15MB1785.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXQajjQ4n43erXgLe8Emn6e51ZLwd9RHUPwQe2clkG+BuCr6NDO94+pHgK0l5lAuSmXVQZ6BqLG58YpyQH4bVdLUos2KY+HY/Q5t/wQLJB5exHUhHivqduCf5i4FhOMMn0vYO5nXH52wbkuuEz5LUsDerKTQPGe0m8NMANZWh9M/QY5jF2gjVNZNLJfNSEJyapy7Q1QnV1hRI8MY2BY33gSrXrHSbwcaGl1Nu2dlGOU9Ww8/5Eqgzfym8kn53/2GF0118y1kNjz/88BXMauuSqVZcT+MZjWHoFLVjaEeIKAKwXMIeyX2EqeV/8Mm5Awx2nU08TgysZ+s3JIDEABiaAcREoJej1+OyDlHrvsEVriKx07z//9CTZgRpMxY4WLbPmsNxqUdKbfeq4wwxejS7A5Hex7HR3NR4vguAMX+9vY2uHFx00jHUJQuP6lsoYn4qDrGPB6eXvzG3cAj44xhVWPY2xQ3+Nmjb7E0RGs946YZPwQq/nGs4UUwBShdPAGPZ/8vHmNde9GuTOnfJG+9jJeIYYB8nOdkDOm+0NDYCN9GPg3+lW01gmCqdtIo4lYq0By1j2FTsCRvpqA9aaN3jk5atkPGgjGhl/5s9iSg3VN9G1Ubs40rn5r2yGQdb03SF3T8qTm2IY98WU5up4nWyu/jW7i5fJ0BW0rE538Mv/8WjH0+aLXINFdkutuqTTR5AnscxVqMlBO326jMpQDvyIb6pxSgMJq1PY/aw7CJv3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(53546011)(31696002)(83380400001)(316002)(66556008)(66476007)(36756003)(66946007)(31686004)(508600001)(2616005)(86362001)(5660300002)(8676002)(6486002)(4326008)(186003)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzVVNHdQZ0c4ZVY2SHRzL0NaUEYzVjE3eVYyMG1yQXNXUWIyWC8yTzJyaVk2?=
 =?utf-8?B?cmYvZE5TRDN6TkJDZXhQSVBBZDNMeHhVajVISy85bHJRNG10UWFKK2FHZFJx?=
 =?utf-8?B?R0lEb2Z3bklORlpIUVFNazdxdGVYak9STVl5SUorOGRlNnRZdm4zUmxIbmQ2?=
 =?utf-8?B?V1NKYlM0WmRjZjdXRGthRXVkam9EdG1DY3F0ZHkyc2tOUHVRV1BFY05lbmY1?=
 =?utf-8?B?UVJMT1pweDZyV0dFanAvVm1MdzlhSEppWXp1RHFucjNXak1sRW94OTRFQzBj?=
 =?utf-8?B?ajZVNHM0b3ZUaFlwRnQ3WGlMeS9xdzNqeXJsVW4ySk0vMmNPRmhlcUVBWUd6?=
 =?utf-8?B?SmNvd21Ya1kzOUg2a2Q5WlU5SkU0YlUyV1ZiaDRvcjNXNnJqaENrMUdPSkV6?=
 =?utf-8?B?dlM4Y0FvSUZwbGtMRXhlWVRlTEh1cHBIZ2tzQ05PdEF3eUhaeWZicUpkWHYz?=
 =?utf-8?B?NjBuQ1UwbzV4NFp1Y1RydXZyaEtiSTVrVTFnZklEeng0QXVBTHlLSjBoRG5J?=
 =?utf-8?B?Si9iLzNwWG9QelZEeDg5bGRpazZBTGg4Z1ZMWVZ4d0Y4NVpMZXlxUkJKSng0?=
 =?utf-8?B?RndXWVcrKzlkelZsaGlVUHlzcDlQZ3FsT2hlZlorOGE1YmRnNHBDeUFZWFZu?=
 =?utf-8?B?OEZzWDVSNUd1emVua2YwSWxsY2xTSk9nTVRVa0VZQmcwT2tXWnpJeVBMb21W?=
 =?utf-8?B?b0xwM2paUnZRR2dQYmhTK2w1SGZjVms3L1kxcE5pRlprOEVSazBKaVdka1h3?=
 =?utf-8?B?M1V5THVORGVidndnRkJqK2hUNzM2Qi9BTUVjcGY1OE9Uenp0SGJtOS9oWE1i?=
 =?utf-8?B?cmpCT0p6dTZwK1hoSVAxcnlvbFMxbFJ2TUN1K3J2bW9zdHZMU0VHblFpeDJp?=
 =?utf-8?B?d05Wby9rZk9kWlpGcFd6TUZLTmZ0UUpDK1RTSlBBU1JQWERjOEkyNTdNaFZK?=
 =?utf-8?B?NjFDQXlEL0Q0eG4yVFUzL1RiTi9tWXVjUCt1RkVVUU51MUdoZVhybjAzU1hY?=
 =?utf-8?B?MllpRnZVQUpDdXNEc2w0OWhRSmZ1SE42SkR5OFh3VUd2dG9GODNscWZ5UmEv?=
 =?utf-8?B?V2dkcVd0aHZBMno3czAvUmtxbWYyQnpIaG9CRnYzV2p5TXNRM3dUcUhFem5t?=
 =?utf-8?B?WXRYQVFxZzh4UDJ6QTN2WGhDTHE0NzBFRTE3d0tCYTd4a2l2RXF6Wk5FeFBk?=
 =?utf-8?B?ZjlkN2JxeGdySll4NnpwaU9aVlYzMlZwNGpyNEhESjhSd2JpN3VrdjhTV1Q2?=
 =?utf-8?B?cGRKQ2ZZYlRYNEhkMGNneC9Vdm9GeFFzVytkc09xTGh1aWsxekpjbHN4VkFy?=
 =?utf-8?B?R0FpOEdJUUlBSkZuU0cwT0o2d2d2Y0F5dCsvNXFPdlRMcU1mdDNJQ3N1cTlG?=
 =?utf-8?B?RzFLL0NiL005Nk13MkNOWHFJYlM3Qlo3MlpvRy9iSVNySUFlaDB3K0Q2LzZ0?=
 =?utf-8?B?RHJmeWxSVVJZcTNhNnF3T3FIWXZNVHp2bXkxMjlzc3Q1VVQ3SWpyUk03Qm12?=
 =?utf-8?B?TzRDVmU1SU9Ka1FCdW80SDc2OWRBbFpPbDZPVEl3QXViTzZhdEkwdVBJMGRl?=
 =?utf-8?B?RmRhTGExd0g4ZVRlR1RGWVluTDE2STN3ajRhZGt0WVBsT1dKdWQxU04xZ1A5?=
 =?utf-8?B?UmFNZVl1L2xPWEdOVkxlRjZmbHJHYTFNVHVpMm1jbXRyRjlSQzdXeWUwaFF6?=
 =?utf-8?B?NmJ4UG1ic1lRNUxGSDREQ0c5WFBnRzdxV3RLUnMzY2d6b0pUalRHQjVUQTJo?=
 =?utf-8?B?QzlWcVZ4a0s5L1ZHY1pzVDRuVjFjQVdvdjdORnhGOW56c2dlOVd1UGhEOFVq?=
 =?utf-8?B?UFFXSXlicFVtYUNyZEdWQXE4dldkTitlaEkrMklFMnU3TTl1TGZwakM5ZVN2?=
 =?utf-8?B?d2hEdjhmWlI0MkpWZWsrK0x3SmYzcy8vTHJTbHprWSs1YVZoQll2cWpqQ0k3?=
 =?utf-8?B?YkxvL1VuOXcwOHFqVHhwdWJrelJTSlNHN2htbVR6LzFZVmc5elR4NHFvanhX?=
 =?utf-8?B?aVZUSzdmZHNrSjF2OXBidFRLR2hvdG9EcFpxQytERlFaRGcrZWRGd0llNWR0?=
 =?utf-8?B?bGFkWFlxb1F4c0JwbGsxZkVIMFpnRXZMS1hCUVkyYUEzYW5UOVZHbHV2Z3pE?=
 =?utf-8?B?TXVsSE1PUWRlRXg3V0xDYi9NUlc4ZjJHSFpFa1dsYTh5VVkwZU02UnlQMDJT?=
 =?utf-8?Q?hn2Ol18ZaAqvoH39mkTawGksMsHuf3KWZRIyylcnn7ba?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 910e76b6-eb88-4f41-6836-08d9a0277c33
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 06:42:49.9430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acIaiwAh2q/oIgGMiyBYsq+tCc0gR/SbruSvf/ugaN6ubK3OFksgLN7guiWCbjYhRhlB+3P+5gpGmeWwiSfugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1785
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: vgmt56SETqndlByoKREsr5Xew6RtMbNV
X-Proofpoint-GUID: vgmt56SETqndlByoKREsr5Xew6RtMbNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111050035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/21 6:08 PM, Andrii Nakryiko wrote:   
> Allow to control number of BPF_PROG_LOAD attempts from outside the
> sys_bpf_prog_load() helper.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/bpf.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index c09cbb868c9f..8e6a23c42560 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -74,14 +74,15 @@ static inline int sys_bpf_fd(enum bpf_cmd cmd, union bpf_attr *attr,
>  	return ensure_good_fd(fd);
>  }
>  
> -static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size)
> +#define PROG_LOAD_ATTEMPTS 5
> +
> +static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)

nit: Should attempts be unsigned? Although, with the pre-decrement below, I can
see the case for leaving as is.

Regardless,

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

>  {
> -	int retries = 5;
>  	int fd;
>  
>  	do {
>  		fd = sys_bpf_fd(BPF_PROG_LOAD, attr, size);
> -	} while (fd < 0 && errno == EAGAIN && retries-- > 0);
> +	} while (fd < 0 && errno == EAGAIN && --attempts > 0);
>  
>  	return fd;
>  }

[...]
