Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1C47B08D
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 16:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhLTPqO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 10:46:14 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10442 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229644AbhLTPqN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 20 Dec 2021 10:46:13 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BK7sMmN013834;
        Mon, 20 Dec 2021 07:45:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6kLOThCjdlt1B5LbCzV0TrV6QYlEpg3AJe8a3IB0Gpw=;
 b=F5i2Mvc0ZIfESIlfCikK9dHvuJVc89MMDURCT1dCDMhJvoTMcxWzMh3V2fxt2ULpDO8v
 1hdhgI8/2d4HdOPnV9fPE0JPYlwMRFVQoxVpuv0ahwOflPy3XPKlFpDrrwcpurkfUGLf
 eQ5A9VOZwy8lvARP1dvM2uXWbY1PcsbN5tU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d21vp8175-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Dec 2021 07:45:59 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 07:45:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmeRhEvWKDAB+fyWgnRs9+3x2kIJTAKrw5QWqLzfE37tJdVgGlZ1hRn0+B0DLSEt3bziOd6AtZgiItklwT0guR78Gx8NqaTMBBWv87kHoKMjtLrlG1wjykXXuAMBTI8Q/AYU0HZtyHfkJLFOdO51WQgtSjJc83PZkfQS0R0mNiVM//EnVzMmibBobnuRFoVgx5v9yAColoN2PB9k+ajNW1d8zNsdNT95CUn/ExJTYxxILo1/PHbmSoMDLdlLT/4tnyVgGyazNZPV+aoANaRAFYA7uM5xndq+cvJzHHDlYCi4TPJFSsZFjDRuP9sUmlZBfx6IkSA/UTTpTzeh0TZHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kLOThCjdlt1B5LbCzV0TrV6QYlEpg3AJe8a3IB0Gpw=;
 b=Q8ZhM6IlIA3ARusp1vGnEsaD/AbENGNMCuaP/wSw5QrWMvhSStMs0pQuLdiY3w5m7dOfARAoRpN4URKGG1z/gOD0GemkSUeqYFtLpeWsfT5o33t0+vlUelAGlV3eslNWoWEFOwEVbxO/K5KsyS8UIh+6KkNNcELEP+zil43OIhe4DtDkjcYFkTUVylMEgTJIebFK1dih5Uy4Yi6mX/9MknEraqwbyGXRRX0zSnoo/+WzbcYBhfA5bIAQbfqFzh8g0rh3kdofKp0taP5O4gOTOa+fAVbJcjO3OKvzk84d3aYTh0cksfKcXnBbgtGVLv8V5aK7ia/brdJmemPzjQZ3ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4062.namprd15.prod.outlook.com (2603:10b6:806:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Mon, 20 Dec
 2021 15:45:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 15:45:25 +0000
Message-ID: <705a8df4-a7c0-58e5-33c8-db35491abd43@fb.com>
Date:   Mon, 20 Dec 2021 07:45:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix map_fds buffer overflow in
 test_verifier
Content-Language: en-US
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20211220140436.1975970-1-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211220140436.1975970-1-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:300:4b::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 819847cb-c9e3-481d-970a-08d9c3cfbda9
X-MS-TrafficTypeDiagnostic: SA0PR15MB4062:EE_
X-Microsoft-Antispam-PRVS: <SA0PR15MB40621CF342AE4285B54B5655D37B9@SA0PR15MB4062.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkyCJPRkZe4hd09bbDE6/OMKiuMfhJpGJlecdTR82c6Wx2nNWm7BpMyZfy1ovR3VLf+8Ap9z4+w5LB50aF2F/Pwrj6K1LiHslkEjMNbVctNyDYcrp9t+d7tT0J5/zXafdgF3btIeN0QZSUjVwPfg8nerV/jIjb3/8KE2WMHXyevuCuYWbv6RW7DL178VY3XcYeIn3Mt6s1cwwCttbf5w+Wxpfn4DnGaA1gKh5zCFpTIQzMgIZupnZukeAbYIK8uX7mtwB7nhxmLU2itkuj635KaMwMEVXsH/RwLc4RGNOhyBplv77z2vfYtKANwfyAquqfqBLhcwIkLSRG+kKOn4kNo1K/pqc4oMwJUoUKr8lANwEqAMIwRfLcBZuVjJsMz1ASGVh3VgTL+MM2C3sXwpLe/gTcrYcjOJWTTn09QZDB9uSpx2kxxQvtA2hO/WK8AHcjZhy6qqI8VyVq2BzxN0RbxB1l/Nv38UKU6pxOFQWpd+MOEp0iyPEy7ADUcbrcrnQ8MuB0G0ysaCtYutYbfnnZoxY4oNmIG9oMRy4mkmBOtjm6UrDl0EcujTLFUptX5kUnmBOtbuD3KdEE2rDTpqOZ1nOs57aR8RvFluPIpYkELPaW9R1w3zlD0p7bmBajZjvLksCM8CKJY764N4UI8Sl/sCmq1pYnUR20qsQjwzXgUM0E0NCVLEdqmrFNN1wjo6GAayqFdWDoo1FOa2LpWF5CDS2mK0DsTISJgo0ccf0SD8rrSiIqa8nszT5aGvcRYalnBqFTJ0hNPlA5dsVNPG3LfC282BJ43DhOidrs8G9JAzaE9t500puHdpU9SFf9Xv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(186003)(66476007)(38100700002)(54906003)(66946007)(8936002)(53546011)(6506007)(8676002)(6666004)(86362001)(5660300002)(966005)(6512007)(36756003)(110136005)(31686004)(31696002)(4326008)(6486002)(83380400001)(508600001)(52116002)(2906002)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEZxd1FaUnVRWmVMSHJxQXVVakN6RkZsZUpBNzhZMlovcHBUdlZMQUlWQ3Rh?=
 =?utf-8?B?RUZIRTQwdVlLaXp5WjR3cE0xSHFkcGs5MW4wTSt5cnQydGdGQmpTWGxYbk1H?=
 =?utf-8?B?K3YxcVJGdWpudEZicTdHNzNraGs2VEFQWGIreDVqUVRWYXUxNVhlWWYxWk9T?=
 =?utf-8?B?dEFvQXVWcERuMnNrZ3A4UXI2ak9Nc2t6V1Y2Sk52MndaZXJUTXJyTVNGcjFD?=
 =?utf-8?B?Q0RHREhNU2NNMXd3SWV3bzJGbE1PbHczNHB5ZU92bTdIcS8vdStZTUwzNGM4?=
 =?utf-8?B?M3lTSExiZnFJS1pQa1loWTE3UFZUVHVYRk5qMXdnaDFGUVgwR1Q2YWNNa3FF?=
 =?utf-8?B?a2U4T3lXRGZZWVVhQ1hjS251ZFZFTWYxZWl4VEgwcENiaWpENUJXRmttSTJN?=
 =?utf-8?B?eG1lYmltOUx2cDkzV2o5YndHUi9oQ3dycURmMTA0ZjVTNjB4UzNUOUUwK09y?=
 =?utf-8?B?aVo4QTZrVU5vTlNiMEhGSDZqOTFzQmF4ZU12TlVoQTlaaVo4QWhpYmowWXpB?=
 =?utf-8?B?VjBudVVOdlpoRjlLREVZbllCZ2dpUEpESkUxcFFpOTFQZzFJYjBzTjNCaC9Q?=
 =?utf-8?B?S0VITHF4c2E2UWQ5ejNaQ2pjeGJNVjNUbHRFWnlpbUlaRlJYazZEQ1l6bVpW?=
 =?utf-8?B?a3BVSUZsSGp0NXNrZ3I1SDlHZldSQkJBRGdQK2FlSVdPS1RDZWdUeFVuT3RN?=
 =?utf-8?B?YTFrMUhuZy9HWkpzbHJYTC9KNUhsN1ZaU1I0QVM2RFFtTVk3dlhiaG1uSzQ2?=
 =?utf-8?B?VWhvNkhBc0dEaWx1LzVLZWo5dllnSHkyV01kUS9Jd2pWdG5UbEx3dFZOVDRh?=
 =?utf-8?B?d3hIVjcrWDFYVVcveVBMYVNJZkdtbVJaMzNBUC9ESWd6cGg3bXM5YmppY0F6?=
 =?utf-8?B?OFRmN2pnWEdrNlpabHNiOGNQeFBYSVdqdWduSE5OUlNWQ2N2bmd0dGZ2LzNn?=
 =?utf-8?B?N0dxVENWdVNDRGZJVVNLc0o3RTZiQjF0aklZU0lrWTBFMEt2UHJMRmZta2Ju?=
 =?utf-8?B?L2hyc0VDVUZ1cXJ0dzd5QzJBSXJUR0NkRHlycEtyWXJQaSs0RTAxaVphVHNw?=
 =?utf-8?B?VXNPdzl3UlR2enoyNDUwanVHYWRId3hxTzRSOTRDVnVRMHdRcUxJZ3JlQ1J5?=
 =?utf-8?B?MDJoeFh1Z1o0Y1BaOUpGVzUxSzZtWjZpZEcrRC9jbXZaeUlEc0VSV2lYcCtr?=
 =?utf-8?B?UzhjTzRpS3JWclQxY3NwL1k1TnJ6cmFvUzJlK3dweXBrVjdCWmFKcVZ4S1k5?=
 =?utf-8?B?VFdNSjVtcktxaCtyNkZiZmVVUVJSbWEvNi9pR2tZZXVzNVFwWFdpeExXd3JB?=
 =?utf-8?B?MlY4dXEyQ2tXS1F2eEdGRWN2SWJZZmxkYUR0Y204SHlMNWtzRGpldnd6ZWph?=
 =?utf-8?B?M0hRUThwdzc0bzRJT0pMQ1ZraXh5TjQxQnVnamRLemFKNUZLUGZUcU44dHVx?=
 =?utf-8?B?VlVGalliejRRUDYyQWlZdjhuS2NTeXlvYVZWWmhPSVA3L0dselkvTjkwaUZz?=
 =?utf-8?B?RWtnVjRtNnJzZ01zWVYwMU91NE02TC9VcHlxU001eEs4aFJCY1Jid1BjdGND?=
 =?utf-8?B?NXg4dEZxdUVieGRFaCsrZTlud1NLRW91c1A1aHJxbW9qaTBJalVzNk5kNHhz?=
 =?utf-8?B?VUQwL2VxejBxcnBkQXhNR042cUEwc3lKRUsvanQwMnpUNG9VeVpncExMSDdV?=
 =?utf-8?B?eGNWb01IcksvcTVpa1YwYWhqM2tMZGRFWXczNVhBTXplNVZxbyt2S0Y0SG5k?=
 =?utf-8?B?aXNlbWtOYUt1NnZwZW95MjdDNE8vdW00QnRPQk04cFFocTdIck5kN2poMVBj?=
 =?utf-8?B?RnZTU1hONnRnaFpmbk14SEFQUllJTnBZYXpWODlKbGs4ZjJ6T2s0NHErbVdj?=
 =?utf-8?B?cVFWRm1yeU5ycUs2bHNzQ0pBYy9aN3VqSFRmSjhGZXhGZDk2VkNRcWlwOFFN?=
 =?utf-8?B?QjFBb2hQcjNNY2ZFTnZZcCswSHpaK0dZbktYRmI5V0d6N2hpb0I1VE1Jb21r?=
 =?utf-8?B?VVc5dW04aEsxdmNVcDliMTcyM3hqNUlhMVdSZWw3SUg4Qi9sWSswQWJmMGZ6?=
 =?utf-8?B?QW9XOE5qQ0diRlpZbFVBeGR5ZUtWMmlOQmEydDNGbCtJQWpxeWRIQllXdFBQ?=
 =?utf-8?Q?HowWd15keG+4bFVe/fCO9IrHx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 819847cb-c9e3-481d-970a-08d9c3cfbda9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2021 15:45:25.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38WWV0M4f6egcR4G1K+0DDLTk/0T1wPIjllDOHZNuJoM8lER75a3THxXSJ7s/RSv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4062
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Z3Momn2e-0-bdG-c03Mt2FK-kKCpUgZs
X-Proofpoint-ORIG-GUID: Z3Momn2e-0-bdG-c03Mt2FK-kKCpUgZs
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-20_07,2021-12-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112200090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/20/21 6:04 AM, Ilya Leoshkevich wrote:
> do_test_fixup() accesses map_fds[21], which is out of bounds. Extend
> map_fds array to 22 elements.
> 
> Fixes: e60e6962c503 ("selftests/bpf: Add tests for restricted helpers")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tools/testing/selftests/bpf/test_verifier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index b0bd2a1f6d52..76cd903117af 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -53,7 +53,7 @@
>   #define MAX_INSNS	BPF_MAXINSNS
>   #define MAX_TEST_INSNS	1000000
>   #define MAX_FIXUPS	8
> -#define MAX_NR_MAPS	21
> +#define MAX_NR_MAPS	22

The patch has been fixed by:
   https://lore.kernel.org/bpf/20211214014800.78762-1-memxor@gmail.com/
and merged into bpf tree. It should circulate back to bpf-next later
when the patch goes from bpf->net->linus->net-next->bpf-next.

>   #define MAX_TEST_RUNS	8
>   #define POINTER_VALUE	0xcafe4all
>   #define TEST_DATA_LEN	64
