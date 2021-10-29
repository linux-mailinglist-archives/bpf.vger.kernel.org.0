Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB244404EF
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 23:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhJ2Vcx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 17:32:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48191 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230301AbhJ2Vcx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 17:32:53 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TJnMRT028953;
        Fri, 29 Oct 2021 14:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=BrH4s0HRgwEFDYxqeBrY0wXy9H65Jb3uBJZvUz1CND0=;
 b=YndF0RNIuQYeuMOo4XWdJs8wlbtZH+cQS4GrSS1WXIasR5pOYPb/zEjH+2Qz/ewFLWap
 IchnSsROxUdGgbvbpPnQeqBQaf+yQ6ls7IBmH3slL0F0d6HnKjnz6yLPYAJiI47fiHGY
 J6w2WAsEX8HjtQFe+0EDSHX2sJmep10pO80= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c098n7jmj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 Oct 2021 14:30:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 14:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8RaycPBT1blMQLPtS3BPFuLQagyIBRLIUR+BeiEZ8RsrVT3Bn6YUUImQa/XkY4xl6w/6pKOsE0bOhHWXvea+lBr/sTn02V/mIFM4nS6AxncGd96B+sqsCDr82Y0PfAbJ5YWHMz7oxjHL35/QihBRDjIKKhEYE9ePLYxTTSa3q8Eg7TCX56fxlCGmcaRPnJm3AxQmihCSQCh98NIuo8r1OS2hPtnUYaETkNXNCAJFlxF66/s12NuoGys5+BLekJJd5e1TXEijefUvZ1+K+s2CdFAoZhTOntu97m+UxxVwD1wEj6xQ/Eu5h53G758HCIqtl5Wyg4HLKaiY2376nd7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrH4s0HRgwEFDYxqeBrY0wXy9H65Jb3uBJZvUz1CND0=;
 b=E4mMaK3QOa1sbwDQr7w0xrygqBPdc5BylvhXVU3ZuxcMoiusrTvyCq+0Ad5lo/ByQfh/5XrlM4nLzbWh7LtQ6VFCE2c2C4s4azXHlNNARhsCNdSo2Rs1CCtrE4wwA1EmgeehMcZLtzomOkMWk8mepZmWJ2p11/+lNTK9HtqrMhTzI5ADfTB7sa0I4V7mMG1C4nAJCfSXSdDovNCKp+YcgOFLrlfM/on3Ll3nqNaU2iGXqHcmRyem8H8tqZKI9OHsBGpO10F1WXliDMiOh4sxP0ncHgFegZKYzPUbqD1/cUtR9V3Y4Z2jg03xqZKIEijLQ8ywWJ6kbPD1HuR+96ugmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2333.namprd15.prod.outlook.com (2603:10b6:805:19::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 21:30:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4628.023; Fri, 29 Oct 2021
 21:30:01 +0000
Message-ID: <4c3d57b5-240f-5403-2a0a-a1e5726db322@fb.com>
Date:   Fri, 29 Oct 2021 14:29:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 2/3] bpf: Add alignment padding for "map_extra" +
 consolidate holes
Content-Language: en-US
To:     Joanne Koong <joannekoong@fb.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>
References: <20211029170126.4189338-1-joannekoong@fb.com>
 <20211029170126.4189338-3-joannekoong@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211029170126.4189338-3-joannekoong@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:300:117::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21c1::17cb] (2620:10d:c090:400::5:47d6) by MWHPR03CA0002.namprd03.prod.outlook.com (2603:10b6:300:117::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 21:30:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: badc39f4-d7c5-440b-df3e-08d99b2343d0
X-MS-TrafficTypeDiagnostic: SN6PR15MB2333:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2333CA9110134D4DF17D2730D3879@SN6PR15MB2333.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:240;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nuxerg7nDvEe2+15nV5QS2UbrH1i4wY8SpPi8y9WHxtAjtQKKFjzs609U0n8HjibyAhfb2dxgUOYZcZSVK0CQupwY71c1vW4gu9wLugyDIu5dLa7dEM9Lh1pn3jpwcg0ponnG22sRh0TRixKRGGCONfvUKi/sIof4DrE5V0rAus/66rmu/kPde9Vi45XEudCOAW+e/eNfOWTmcseJuPJDF8Dwn4n39iZf1bij1ClqtI4HWCB3S8PvlalHvxpwqZ2nOpVTb1gzDojVNWdefThqjdhpZqpgarqNXV0e68aOEGq4+APtDhiBrLwa3hZLt0+sLozJVBsrLYw4kB0TnR4Vjr6l4G0AIMowCDB7q7qVzOBd6rP02daEVD8vFHZ9E376BGuAYXNvWUqTepkMaLc5K72oaOefsO7bTgMexih96eV8JcNyYfKuexcb+oTlU3kf4nIOQsZ+UUJ2CyXsFXbL9tNhtsFSXYJX0iqQ7yMJ9iUgdw33oPj0mfND63TgkjPQgryQNqzfN6+g8ZnW/2E9MtVnVY5fJ+K/aFzMYtcVZsqihsmoxchtRdJU+jfXG411uPmqV3JOBtTToH+L+wyMo/zKXDY3kudZfavFpUAxj0H8zM9q4VX2P5QlK7c75hcp7vxMwIrHTvb11n91JwY9g6a0WBeB39LyXeev/GGNgEqZIw3QeUD7Z56MID/LICCn2RXY3jgcVmTUtBDBh0i7qge5I5hwQqK34Gjw+RoRCVofHn54abRY1hGDZu0RA5kWb13kY8Rwe1degXcIqesFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(83380400001)(36756003)(186003)(53546011)(2906002)(508600001)(4326008)(6486002)(316002)(66556008)(66946007)(66476007)(8676002)(31696002)(52116002)(38100700002)(2616005)(86362001)(8936002)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjdEM0VnQXh5dWJ3T1E3MzhxeDlMcS9QeHErN2tyZHBRZEozSzFtQVlRcmU2?=
 =?utf-8?B?MVdCa1FxT3F0ckRyUEdGZGV4ZFNjTkZvVjc0UWRJcmNyd1hSd0h1TUZUcThh?=
 =?utf-8?B?VXMzYXMrZzNFWUhBWG1qYngyaXVKM2FsU0NHeGRVQk9SRlhoOEZycmtxc2FR?=
 =?utf-8?B?OGxJUThoZldRMklmNmFaRTZ5L1dkV2t3QmNUd2RWN0JScWdyeFlEaEhydzVI?=
 =?utf-8?B?anpPS1pHdDMwWEhjcWRXVTRoZ2pTbC80MnEzUUYzSzZBbGpTUFpLRnNxRVRx?=
 =?utf-8?B?SFVlckp3L0I2OXVNSVhvZ3did1IxR0l5K0xTZkU4cnJHMEtIWDJ0Y3Rvb0dW?=
 =?utf-8?B?cXB0ZTNTa0ZQVDhDc1pRRDczLzNvSk1Xc0NvZXFvN1ZMWEYwdjVEbnZvR2xE?=
 =?utf-8?B?bjRXckJiUitHWEtkODRjZXIvNUlhSGNlOXJjQVI1RzRtM08xakJLak4rVlNr?=
 =?utf-8?B?SEtjcWpPaDlaSXhoNU9BdzVCczVaSXdOa2dQcVVQbzdRRmNVVnJVNTMxU0Uz?=
 =?utf-8?B?SmpBRndGZHlSL0FuczJOYXJzem4vZnJvcVU3a0hWSEd2THZzVjYvbWc0RmJ6?=
 =?utf-8?B?cWk2TCs5N0RrVklvY01VZUdtMEFsQ2FYQUhrdGMySWdHb2hZUVc0MkRwMzB2?=
 =?utf-8?B?d1RnVnN4blgvbVMwYjBQLzlZQzl0emJYR1BnaEtkSDQ2azF0aWROZnN3QXY0?=
 =?utf-8?B?Z3g4OVlrRHUyZ0Vqa0dUMjAwVmpJalZ5T3R2NUxva0lZN2l2Tk5CY0drM3Ux?=
 =?utf-8?B?TzZzWGpGcFlFM2xmei9vakZqRFhQekxRb0hza1dxZW5JdjdRSlZEODYzSUdv?=
 =?utf-8?B?MkIxYW81SUJDYWVqZTlWa0o5akgrNlJlN0I5dUpjL1d6ZTlTZXZ4ZUVvc0dW?=
 =?utf-8?B?bTROWjlzTTAydU1leTMvNU9Sc0o0TEtTY1c0bEFEUG9BeFVGS0xDVWdQZ2F2?=
 =?utf-8?B?ZGV1ZGlNWlk0M2VsMisyUEVyeFZrWDl3Y2gwYVVFZUpFMlJmaDZjcXB2dzBN?=
 =?utf-8?B?Qmg5UUdxYU5RS0xqbjhpNzFFbWlqVi9Fb05mc3V5ek43Wmc5dVpXZGZ4bVdK?=
 =?utf-8?B?Z2FrUFFJZUdRSFlxMEowbkhjL25xSEQ3YUVXR1llbEFDTHgrR29mZWplT01i?=
 =?utf-8?B?S3dZRnZWLzdlcjBlRVFWWnZDTnNNYU8wWDg4K3h3eHpHOFVxRGRvQ1NMbWtq?=
 =?utf-8?B?bCtzRFZNZ1JIaERqVXJJZWpuVVpWcDNwSFBzSVorYkphcGhObDRzSnpaam93?=
 =?utf-8?B?NmY3allTYXRUYzY2eFl3N0ExalNPa2pqNVFqTzh6R2dXQTh0QTluOTFVdFkw?=
 =?utf-8?B?WGhMeCtSdDNiNTREY0p1YmdnSVkyeG1CYnA3a1dEZUhnZFp4TktOU1R0M0Fa?=
 =?utf-8?B?ZjhTdTFhM0FnMW55SCtGamo0YjBZR25nNTVLeTNmVml0UHAwdDZ1WUNCZlBK?=
 =?utf-8?B?K0FtNlU2ZElTdVV2WkYrZTZFSDNReTkzK2R0ZnZXaU9rY3hQc04zUEVJditK?=
 =?utf-8?B?QUI5ZGp1OERYTTRrdTNpZ2w1L1pWVHdzTXI4akhLcGhRbHRCVWptclhkcDUy?=
 =?utf-8?B?djl5anNzVFEwUy9FZzIxZGkwU2dqRENUMWg2MHozakEwUDl2OC9HemdPMCtU?=
 =?utf-8?B?dEpIUG5YVXZ1RUlVUVFGSjZHbi9Ob2tiaGdKZXFyQmdIVXBaREd5UmZYNEdW?=
 =?utf-8?B?S1QxU3FFNERTcysxanV3eXkrS1VkUlRrc0lBQ2pXZ3ZpNEdyZ0xQaTNMOUpB?=
 =?utf-8?B?d1lhaDk0ekpGMU96T0VwVDJWbVVKSjR5OWhreXFWZUZnVzNkdHFiSGRLSUtJ?=
 =?utf-8?B?bXBzcE92VFh5NXpEMlJ6MFJzemJYajM2ZDRXYm5EcEV3aU9tdmd5aXFybjE0?=
 =?utf-8?B?WE5HSTU2V3pDLzdHWVVDc1U4ZzBMbkJPcTJjVlQrMTZlYjNNcmtKeHFzK2xG?=
 =?utf-8?B?QzRBK0MxWk4wT2RUYlZEOEpKaFlxRW1meERzL2FGekl6aExXS3Nuelo5TWlv?=
 =?utf-8?B?bndWZW42L1BGeVQybndjeVFSeS9KczRVUmMrZ2pHNlNOZzFRRnUvdGRFU2ZZ?=
 =?utf-8?B?NWl1TktOb01Vb0xzTmYwWTRBZTNQd3I1Z0VoN1Z5WGtoMGJnVmpWQ2NaTTU0?=
 =?utf-8?B?WlViLzA2dUhya09nOWMyZktXN1R2WTlXdThpeGd2TEpocUZ4cml2N0VpbS9m?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: badc39f4-d7c5-440b-df3e-08d99b2343d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 21:30:01.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEh8s9NfuyFpyxzKrpih6frL0pGXTVZYARIh9Qy8FTe53pNXVfnxKiiadbwgMjth
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2333
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: DLVc0IJLofsHgPOFKlkWqfsVO_BsqyQi
X-Proofpoint-ORIG-GUID: DLVc0IJLofsHgPOFKlkWqfsVO_BsqyQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_06,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=549 bulkscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110290119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/29/21 10:01 AM, Joanne Koong wrote:
> This patch makes 2 changes regarding alignment padding
> for the "map_extra" field.
> 
> 1) In the kernel header, "map_extra" and "btf_value_type_id"
> are rearranged to consolidate the hole.
> 
> Before:
> struct bpf_map {
> 	...
>          u32		max_entries;	/*    36     4	*/
>          u32		map_flags;	/*    40     4	*/
> 
>          /* XXX 4 bytes hole, try to pack */
> 
>          u64		map_extra;	/*    48     8	*/
>          int		spin_lock_off;	/*    56     4	*/
>          int		timer_off;	/*    60     4	*/
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          u32		id;		/*    64     4	*/
>          int		numa_node;	/*    68     4	*/
> 	...
>          bool		frozen;		/*   117     1	*/
> 
>          /* XXX 10 bytes hole, try to pack */
> 
>          /* --- cacheline 2 boundary (128 bytes) --- */
> 	...
>          struct work_struct	work;	/*   144    72	*/
> 
>          /* --- cacheline 3 boundary (192 bytes) was 24 bytes ago --- */
> 	struct mutex	freeze_mutex;	/*   216   144 	*/
> 
>          /* --- cacheline 5 boundary (320 bytes) was 40 bytes ago --- */
>          u64		writecnt; 	/*   360     8	*/
> 
>      /* size: 384, cachelines: 6, members: 26 */
>      /* sum members: 354, holes: 2, sum holes: 14 */
>      /* padding: 16 */
>      /* forced alignments: 2, forced holes: 1, sum forced holes: 10 */
> 
> } __attribute__((__aligned__(64)));
> 
> After:
> struct bpf_map {
> 	...
>          u32		max_entries;	/*    36     4	*/
>          u64		map_extra;	/*    40     8 	*/
>          u32		map_flags;	/*    48     4	*/
>          int		spin_lock_off;	/*    52     4	*/
>          int		timer_off;	/*    56     4	*/
>          u32		id;		/*    60     4	*/
> 
>          /* --- cacheline 1 boundary (64 bytes) --- */
>          int		numa_node;	/*    64     4	*/
> 	...
> 	bool		frozen		/*   113     1  */
> 
>          /* XXX 14 bytes hole, try to pack */
> 
>          /* --- cacheline 2 boundary (128 bytes) --- */
> 	...
>          struct work_struct	work;	/*   144    72	*/
> 
>          /* --- cacheline 3 boundary (192 bytes) was 24 bytes ago --- */
>          struct mutex	freeze_mutex;	/*   216   144	*/
> 
>          /* --- cacheline 5 boundary (320 bytes) was 40 bytes ago --- */
>          u64		writecnt;       /*   360     8	*/
> 
>      /* size: 384, cachelines: 6, members: 26 */
>      /* sum members: 354, holes: 1, sum holes: 14 */
>      /* padding: 16 */
>      /* forced alignments: 2, forced holes: 1, sum forced holes: 14 */
> 
> } __attribute__((__aligned__(64)));
> 
> 2) Add alignment padding to the bpf_map_info struct
> More details can be found in commit 36f9814a494a ("bpf: fix uapi hole
> for 32 bit compat applications")
> 
> Signed-off-by: Joanne Koong <joannekoong@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
