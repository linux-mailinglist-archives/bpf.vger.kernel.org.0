Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D79F413F00
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 03:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhIVBgY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 21:36:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16364 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231657AbhIVBgX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 21:36:23 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLHbAu010063;
        Tue, 21 Sep 2021 18:34:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/uGOrSluJ8wjP+FtbAAzVdXtr2IaNlVtVogeM3Z4R9k=;
 b=pDcoOj+BIjPdUELQs4zNvMLkPsfQUk3UEVP0EnRs+/6GYKlAg8MydXz9dudjBFQOx8WO
 9ICJiyxERS/E053KoM3BY6uJhCp3XxbhEISCr/jK7uGtLmaYr9cN5lf1ewywF1qhcwAr
 6i/YRWjKtObFHqK02IdLD/o57HJ32GrnCWg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q62hc7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Sep 2021 18:34:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 18:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nz7mV5zb8o5Q8sDYNOC7zWRd+TxmQY8FqCKRdh0mxtLzTi2mGo6kkwhBT/cE+XxPBrHEsPiEZow1IR90vzmPpDto9FPRLgWIB/OMY+8Iw/WLQm6RyQf1MboL2VxqSeVZg+f6sizJWmmOqdHQiTJYjPmx8gMJTWQbqFunyYslgxUaPsdbiCyKeQrhwf4yBnlR527NwFIoyqI7A4G+t2nA5MlGJhr2bD6dfFlNVDwd4dx7oZ+67bnws/DacdrjJ7g4xOm/z02I9Q5uCJ4/a8AWcSSRvH2rB4dRsbtIuaxweKZvT2xU9+4qpamcT05KHhlkQdCEn3z0T/oYtYkncuT7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=/uGOrSluJ8wjP+FtbAAzVdXtr2IaNlVtVogeM3Z4R9k=;
 b=Df1lBF6pIsWVKTzeLlK0M6UVZxN4phabgZek+rjOv3EsPQpyux2KHoGygN33dIbNnm1pmtJvbmLvX5skVFc/UZDi9I2br6M3mD4DSy9pqn8t+xF1BT/ri2sqSYX/JfWQss/hW9+HrVlVjFF3HWV1+oRbthUOj/Ltt/WTEh0cMyQkZZvo+LdML/dV5GijhVrOoKdIsXCvklv5U0jjJYrn0Lbncy+jcbL8pS2LvIuVknF/dWey/UMson2ATkk2QiOXTFVNN4ePj7uT7FEze6WIBGIWr6RbFPGoWEstSsfxWeFXlxhD6r6ZqH3MplZz5wGI0PmEDKcvRznfS5N9F5YnzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1611.namprd15.prod.outlook.com (2603:10b6:3:11a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Wed, 22 Sep
 2021 01:34:41 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:34:40 +0000
Message-ID: <78a539a7-7c1b-d9ce-e4e1-8e8fa66e04bb@fb.com>
Date:   Tue, 21 Sep 2021 21:34:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v2 bpf-next 6/9] libbpf: refactor ELF section handler
 definitions
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210920234320.3312820-1-andrii@kernel.org>
 <20210920234320.3312820-7-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210920234320.3312820-7-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:208:257::14) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::12b6] (2620:10d:c091:480::1:d228) by BL1PR13CA0039.namprd13.prod.outlook.com (2603:10b6:208:257::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Wed, 22 Sep 2021 01:34:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98c0badc-d323-4f42-dfc8-08d97d69252c
X-MS-TrafficTypeDiagnostic: DM5PR15MB1611:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR15MB16113C6E6C545BAEB17535ADA0A29@DM5PR15MB1611.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Y2tFRXW/r2mQopKX+MgpUKNWPmWgck2GsRbrbIZJyG+Li7xucXxy/oi8AeXWx8G8TS73y+ImL2zTgmlPQkGBq3e49xFr6DPjJvbAz37RX0eRwkQfS9eHsZNKAve18pWNIx3Bu1SrdNQpO7VlXxo5Qml04i/h/7gQVLnbwApiHN9PDSl0DJqeAdRhw1pwed1/x0m+exnHRKAsb/a3JkGyE6hp0Atzou+uywjDI//j8UScbhIVU5Waxr1FbFtdJYUw/tzKIPzsiWgGx1m8vxOUAwmlGGOsaY2AvTisRyIqdHZeFMRRZ/LaSNCg8Y7MKTyoJFwMrvWYzWUiYLkxS5CuFptO4mljs5F01gdlCNC8bJsTVrnXAepurWQ5B6QuVpBEa95OOKt7bDkHlEwuAwbySWm+vAhweyA/3YKbE1KCAIho6dwTrQRddtgMosyXbc2WVM+VQeU7N+wk/UcLHrhdqb7lQdKgF5n/6IHhGJEWVE1moL0ypna/X56DQq8Mg8f5rAhnc+8y5BV+QdeWV2FEyU/GdGBYXiOqEH2iFNVF8nQzGd7lvA2SWUljM79xwvqqXry7KX99jzBwP8Iux9CAIsBeX6ZjHVpBpcsjIhERCEaZxbjpMfGfIR4AnlsBzH7WFROgcj4DXNtneIDtIOmApl3E0X8eS2pgP22qC5KAMIwxQnYWIPQ9wpaVwqlnX9NgdRa3BRcmMnRKeyrjkEOAoSFFLOdGc7f9ZKgiu4svug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31696002)(36756003)(8936002)(83380400001)(8676002)(66946007)(2906002)(508600001)(66556008)(31686004)(5660300002)(316002)(66476007)(186003)(86362001)(38100700002)(4326008)(2616005)(6486002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm5KeGJvVmFsN3BoQTRkRUpyZkw3NFRFRlZudDRKazVLWkFDMXcrWEpLOGRV?=
 =?utf-8?B?NXMxVDlOTWhUU3AvT2x2M2dxOTROOE40eUdwUXpVWUZRY3JScGlKejFOLzJ4?=
 =?utf-8?B?cE1FdW80ajBVdnd2NmhTSHBGL1lEazFBdTJ4L2F2OVpXbkh3RXBkWGREeHZt?=
 =?utf-8?B?RnZCV005Vi9xaklWaUlsNGFZWGtYU2p0UklkY3YzZWV3emNhbnl5dm1NeU9r?=
 =?utf-8?B?UXBVcml4VkNsd2dQVkF6Wm5mM0tyRUxEWGVLMnpjN2dtTUxSQi9JOUZMSGMz?=
 =?utf-8?B?MTVJU3RiT0RQRU9VTnp1STFaVStNWlRsVkR2dHhrYkFLekRVY1drbWNQNG1O?=
 =?utf-8?B?Q3k3SW5BRzl6aHg4QzhRbE9jYXZHdW15KzRsNEV0MTB1YmJIakdFUXZSWnYz?=
 =?utf-8?B?NFl2MWhGSlFlN0d2VWNjbnJGTzZMa2dUVnJFSzhwaVl4V0VPeGEraE5iNk1G?=
 =?utf-8?B?ZGJXRTdsdGo4Q1lKcnd2RVVZMFZOeU5WeVB5Ukc2UFpFNlVYcWdQR1Z2a1ZN?=
 =?utf-8?B?K2N2WEV6SStLN0QyTnNJNlJBTkNHbnZCajBLQkFYOEJqOG00K3p5Ti9mbWNp?=
 =?utf-8?B?UzVWSi9mRGNqMWZtTU42NUhkVysvNmlhTVlScUp6bVJaQjdMVnlScTlnUWd0?=
 =?utf-8?B?b0t6a0VEZ01uZFpyOS9DSDRXSHUrMlRVbUc3aW5Id055NSszZFR2djdBVi9F?=
 =?utf-8?B?WS9TWnQzckYvSUZUa3NVdW1YUGI3MmJJYzVROFR3VnZXNE1STG95eHo1dm1z?=
 =?utf-8?B?cDIya2RCazhMdHNSYTkrVWRHallsaEE2YU1rMm8yZDdibEZuaDBNelUxQ1Fx?=
 =?utf-8?B?VEJHb01uUlRzMXl1Umc3bkR4aVFJWU9CeGNyQ0hQdGZGN1BQYk93b2dxZEl1?=
 =?utf-8?B?bmNTUnlkODZiTGRkd3ZQOVVLbVJvckVsRmR4UHRVZ0NiWkFwMjZHNWNRY3gr?=
 =?utf-8?B?dUFUN2piYUMzMmN2RmlpeXQxeHk1WElnNVdaRFFEcWhtTm0zMTdHZ1RyTEZk?=
 =?utf-8?B?bURXd3JiMEdRczc5S3cySE4vSnp4MDBmdDFUSENsVTU0aGh0N2NNSnV6a0I4?=
 =?utf-8?B?RHIxVGhQRkh5bHR6SXdlUUEwdjQ2QVZUd3BGSkx4SzRqOXZzbzhlSDM2aWEz?=
 =?utf-8?B?MHVLVjBjM2I4UEp1c2RWMVF6L2tlZzN4ZXdzV1FLaUJWa3Nzc2E4UFlTMkdJ?=
 =?utf-8?B?Q0JCRE1HMlpRdktNN2VqaEIzNlNEZnNSbk9kaFVjbE10R3VnQW5MS082ZWpR?=
 =?utf-8?B?L3ZRRkhPQmUrNWsrY3pxd1FGbWZGWEx2N2ptZzdOUGNuclJLTklWWFY2NXBo?=
 =?utf-8?B?YXNld1RPN3A3dGZTVWZiZEtpeGZ3bmovTWVyN2x0ai9SMjRRVG9ISC95QVRk?=
 =?utf-8?B?QjJiSmhoOG9LWDB6L3Fvc0NvRmc3WVY2dkw1b1k4RHUyOVJTRXQ1YjBBWjVo?=
 =?utf-8?B?V05XQlhkemRNdXF4SjN5c0JXOUptS2ZWWHVuQWVvODErczlFZ2ljZmROZ3BQ?=
 =?utf-8?B?MGdyWk5wSldYc2FhQ3VTMWoraXJBVC9QNDRMbVcxQnd1SVRSZEM1UXNOUWxQ?=
 =?utf-8?B?ZnVGZm95RHFWb3krcnU0dk1McEhMbVR3bE9SV0R1Wm1tTkl3N3p4TE14OFl2?=
 =?utf-8?B?NjdOVklwaXlHUXQ4NFdNbW1NditQd1JpRUV2NXNqUkFWU29lZ1ZKQnMzK1BV?=
 =?utf-8?B?NnRjR0pYVFBQYXZpd0JPVEdKZjBpSUVUYWI1U2ZaMnE4OXc4Mk95TnJpZFFv?=
 =?utf-8?B?RFBjSGFJMUhJVGx1UzQ3Vy81Si9sZnMya1lKVEFmM1Q2MmZKZXBKZFlHaysz?=
 =?utf-8?B?NkZiN2hITFczVEp0ZTA3QT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c0badc-d323-4f42-dfc8-08d97d69252c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 01:34:40.8786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WFTMPsYyfEa/TC4mRJ9CqQ1X+B4xMBwjEAyvPKn+gW501sZ9HsFVbD1qbTTG2pf3zoRZuPkcRlFnvvK+prxB9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1611
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Uw2obZ-AHLSRVE6es2I2iUUnJk0a2pEw
X-Proofpoint-GUID: Uw2obZ-AHLSRVE6es2I2iUUnJk0a2pEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/20/21 7:43 PM, Andrii Nakryiko wrote:   
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
>  tools/lib/bpf/libbpf.c | 183 ++++++++++++++++-------------------------
>  1 file changed, 73 insertions(+), 110 deletions(-)

To summarize VC convo we had about this patch, you don't expect custom sec_def
writers to necessarily follow your sec_def_flags approach, but it's a good
demonstration that a long's worth of flags is plenty for enabling custom
functionality. And custom sec_def writers can treat the cookie as a ptr to a
config struct if they need something more complicated, without imposing the
struct format on all other sec_defs.

[...]

> @@ -7955,15 +7965,14 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
>  		.sec = string,						    \
>  		.prog_type = ptype,					    \
>  		.expected_attach_type = eatype,				    \
> -		.is_exp_attach_type_optional = eatype_optional,		    \
> -		.is_attachable = attachable,				    \
> -		.is_attach_btf = attach_btf,				    \
> +		.cookie = (long) (					    \
> +			(eatype_optional ? SEC_EXP_ATTACH_OPT : 0) |   \
> +			(attachable ? SEC_ATTACHABLE : 0) |		    \
> +			(attach_btf ? SEC_ATTACH_BTF : 0)		    \
> +		),							    \
>  		.preload_fn = libbpf_preload_prog,			    \
>  	}
>  
> -/* Programs that can NOT be attached. */

I found this comment and APROG_COMPAT comment useful. Not as clear to me what
SEC_NONE implies without some comment explaining or giving example. The other 
flags are more obvious to me but might be worth being explicit there as well.

> -#define BPF_PROG_SEC(string, ptype) BPF_PROG_SEC_IMPL(string, ptype, 0, 0, 0, 0)
> -
>  /* Programs that can be attached. */
>  #define BPF_APROG_SEC(string, ptype, atype) \
>  	BPF_PROG_SEC_IMPL(string, ptype, atype, true, 1, 0)
> @@ -7976,14 +7985,11 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
>  #define BPF_PROG_BTF(string, ptype, eatype) \
>  	BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 0, 1)
>  
> -/* Programs that can be attached but attach type can't be identified by section
> - * name. Kept for backward compatibility.
> - */
> -#define BPF_APROG_COMPAT(string, ptype) BPF_PROG_SEC(string, ptype)
> -
> -#define SEC_DEF(sec_pfx, ptype, ...) {					    \
> +#define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
>  	.sec = sec_pfx,							    \
>  	.prog_type = BPF_PROG_TYPE_##ptype,				    \
> +	.expected_attach_type = atype,					    \
> +	.cookie = (long)(flags),					    \
>  	.preload_fn = libbpf_preload_prog,				    \
>  	__VA_ARGS__							    \
>  }
> @@ -7996,92 +8002,49 @@ static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
>  static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
>  
>  static const struct bpf_sec_def section_defs[] = {
> -	BPF_PROG_SEC("socket",			BPF_PROG_TYPE_SOCKET_FILTER),
> +	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),

Didn't know how strictly you felt about checkpatch line-length complaints,
won't comment on them further since you mentioned 100 chars being the new
standard. But would complain about the alignment here and elsewhere in 
changes to section_defs even if checkpatch didn't exist :)

>  	BPF_EAPROG_SEC("sk_reuseport/migrate",	BPF_PROG_TYPE_SK_REUSEPORT,
>  						BPF_SK_REUSEPORT_SELECT_OR_MIGRATE),
>  	BPF_EAPROG_SEC("sk_reuseport",		BPF_PROG_TYPE_SK_REUSEPORT,
>  						BPF_SK_REUSEPORT_SELECT),

[...]
