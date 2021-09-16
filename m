Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA98540D257
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 06:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhIPE0B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 00:26:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34964 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhIPE0A (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 00:26:00 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM40BS014964;
        Wed, 15 Sep 2021 21:24:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nxu7JrCEbg29EqSCEEe//c+eSUotQCcO9cZiVvbjE0A=;
 b=U8cyu0nzlmBTSWK1HdzKZYt7tWtEBZk2MuTSxT3ddStDO31V6Km/6a2MJz4CfZY9JHJ5
 C0AXcz1VYOT1kB/gve8UcLchaLN3z8YaJN1lg1gk1QfGGUp1c6CJlLoAWBnrWkX3rZ72
 inC/+jQWryvEFEFX5XGsIFB3PtxzN8/2C8E= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b398afum5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 21:24:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 21:24:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmXoJOwsQQ0Ks/qmB9/Kuw0wKYC/TxMnUSYuwPYe+qDl0cm/TuE9ZrVfk2fIiwZeNlP0yxkBtif7+fp3cVSocZ+D7C4YuW+1/fWh/aaU2ZZCPjiVkVT7QfJvkYyvcnX3+iRw3hiMIdsUOtILDOUhDF2ExfUp/stF+VDAMWfuHqkMf0GYlXBx9SuUd+dy+yGDcnemUEf0jgSjuKTkmT/dRIC3Oeaeez8JdC9euFqwBNGFikNiTSkylj2opxvHSFYG9W0TDgiMIelDKG8TfQBUWv7hvL+KM0EyOaKNB2nRM7tB3bUs+dOQ7q4NQIpOMQ4H11pGe/sUB8kz74yQ6Jo8xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nxu7JrCEbg29EqSCEEe//c+eSUotQCcO9cZiVvbjE0A=;
 b=FBG71bs04jnau5jpfa18V2NE5MlWB/OaAWixKp5YlF1opkV5QWJJSfO4n7usUUzpH9LAhwM2hXYXQ5u81PkXs6cZDqgf2cAihW396nhyQzuMnZrufhqeaCu+Tg2nk6Mki5zYfPfFlWdeU5KyCtN0Yr9sBZZeLqApAy6QEk9JayG5uxtqrnHIFEwrpiBxXgVkAAfDaY10LCexxSiI7Ow9u6OgaKYvqWXDAQMDITlqAcIjXNiCwr8bxNm2YbWyhJpr4swfLBLvFp6X8WuncDEF9KThZMLwKNKN9KpBaw3mlxJJ6y0fr0QfE4aYFiM2APZG0L0xbaYJ7XDutXy0AO0dVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3886.namprd15.prod.outlook.com (2603:10b6:806:8f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 04:24:24 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 04:24:24 +0000
Subject: Re: [PATCH bpf-next 5/7] selftests/bpf: switch fexit_bpf2bpf selftest
 to set_attach_target() API
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210916015836.1248906-1-andrii@kernel.org>
 <20210916015836.1248906-6-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b8dac642-bed3-cf84-4b21-99c7ffec07e1@fb.com>
Date:   Wed, 15 Sep 2021 21:24:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210916015836.1248906-6-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:51c) by BYAPR02CA0051.namprd02.prod.outlook.com (2603:10b6:a03:54::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 04:24:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7494122-ce9b-4251-a451-08d978c9dd42
X-MS-TrafficTypeDiagnostic: SA0PR15MB3886:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB388626667F61CE8A55A6034FD3DC9@SA0PR15MB3886.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAYUPvaQs942wQoVaKpNo0oUwT67T88vzXW870Ytk2Ff1gLaXn739rMCeWEkH8WsWMlzLTv9L90ZITlR9BoJ27wpZKysw6l5cYqr7ZOdbm3iIFS6yYqUBqKFlnX/iH+O1zPZBhqYzth4toNd3mtEQPfkZcy7qDVNJNL1aqphoNhRn67CFS6kqRazvPObHVk8gEqLHe6Jl41zbDcWNRvGc0lJu9grFAJ+2O506xZNbAdE4hj5wG0IH06GUUkXNx/fbyNu6g5nKDjM2JOAddUELrU4vHTNFqtzcL53qY/+6tjn0iRFcaEiQ2C2R2JaSq9kXFGDdUmgu2kA7td6+yNPP8T1QMespVTRllDbxXJtOwjZ6d5MmZJSVZZsSU3z39kBxqNKN6wH6M3UtDAwghVVByeUpf54d8fXrb1/8SOUXEXExdh53XqfCx4c1et+JfmZMUBOyY8MWYtKag5AQ+V4p4A3BdBzPKoE9WMdlCNWm4MyHezpZKN7tAG0w5Yn0F1C+f9xmTljg9BOJ7D2ea+60+pruVOzkeSXAvosda4lc3VYWtDlMUtxvrDYaKouUVKLzQIueI/FMwD77m9qTqXKSNgIbwGUhsD7/kYJygGsQ0TxTQDgHNU9Ty3Lam+ao4Ksc/855ajV8SDSAh+xWLyKvpubO9F7QR4QLv53KaDhIiJkph64Nq+ZChT7wEp+o1ip/y+ZxXLdMNYBLhKQkThHHCZ1XRATtCSpI/RMyC26rRYzmrDsZlZG8MltPDEVCIrY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6486002)(31686004)(5660300002)(66556008)(52116002)(8936002)(36756003)(66476007)(31696002)(66946007)(83380400001)(86362001)(508600001)(2906002)(316002)(38100700002)(53546011)(2616005)(4326008)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHpoRW9QS0JRbDdMWjM4OWx4ZTRSTDBwakhhYUoraXd5S1lkd0tjSXhRdHcv?=
 =?utf-8?B?ODVWTWd4OENsc3dlaStnQ3ZWdCtibUpxL0ZKRUdMc1c4RlZLMTVZV000ay9D?=
 =?utf-8?B?MzFtdUo4NmxhNDdIOVVpQWR4UWN4emxxeW1Sb1hWRzYwWW9YcmM1SWZRdnp2?=
 =?utf-8?B?LzRGa3NaeG82Y1RoNjV4UHRJUS96bHg1UEZzTUdtcjhnYmVWWFptT1JjdDFR?=
 =?utf-8?B?NU95YVM0ZVpYY0d4blg2NnZoZ2tFalMyU28rb1h5RklmSW1OOU5CQWhSOEpr?=
 =?utf-8?B?TnNEWkhPTVU3cWtNdjhNS2pqeU1BYkMraGhLZGlCdTdFbHQrV3lBU3NmUlN2?=
 =?utf-8?B?V0JvcjZlcjFPbGtLdzAvZ3grdFE4d1ZxTEErMDNUNGxLN0x0QVFNQnh0Zklj?=
 =?utf-8?B?cXVleG1kY2h0Q25KK0dlc0U2Q2xBeEdWZDNXb3RXaG9aQ3lENFJzMEJRR004?=
 =?utf-8?B?b2ZicXBnOXZ6VU16RXNvSkNEU1Zud2RQOHRMTDFrd3Q3ajFkbjhmaGI3UUEz?=
 =?utf-8?B?Zy95cXF1aTRiVndCUklRcW96MHJOdG1tTmtlTElidzYwSFZ4czd1OVMwUGhk?=
 =?utf-8?B?cW1kSUpTMm9zc1IxUHdFZTRRK0hvNEFuaFpJcDViVTdCc3ljcS9RYkg3OWts?=
 =?utf-8?B?WHV0V0ZBcG1ISmRqUWtrbjZtZEZqQWlVVnJEQWJKUVBScEZyWURJWGJJQXlI?=
 =?utf-8?B?c1hRcS9nTXQ4eDNxMllyN29FWmV2L1d0QndCQUtMaVl6MlhjUXJoaGtlMDZw?=
 =?utf-8?B?b3pnSEd5SGUrKzN1TlFHVmhkWFNpNms2ZDgxUEJUSnpudTV2R002eEo2SkhG?=
 =?utf-8?B?aldoMHRoeVRZaW9zeEhKVGJHTHl5cmt0V205QzVDdnA4azhGYTVib2xxdzNO?=
 =?utf-8?B?R1hJVmhlMWk0eXlOQkFiNmZoeXh1bXVaYmc1UHc2eHRaRDVuNlVCUjBzeXda?=
 =?utf-8?B?SDFDem45Y3ZKY1FVeXJ6ZTJDdEphMFNLMVNJUVpweWhXZUFSZysyMHhDbzBx?=
 =?utf-8?B?RWEwWXgzR1ZTN1NhbXBYbUpNR1hzT25pL2o3eFpQRmZBTFR5Z3kxNTNyNHlk?=
 =?utf-8?B?NlE1enE0Wmp1Rm9PM25yczN0Ty8xUk1LWmRST0tOTDJyTVp0MmpaeXgrOHlq?=
 =?utf-8?B?ODhLdDc4WHozRzhIdkM5c29ickZHSktXWVNMREQrS1Vrd3hVVkdRbFovWFR2?=
 =?utf-8?B?UnB1alc4MlZId3g5aGxGSEZkMUFkRzhrc0o0UlNZR0hQdk4rV2xlYnZKc05r?=
 =?utf-8?B?MVZWSnNXVXl2UnZSR3JKdDFFR2hlanBKOHk2ekYrUnlwUEU3azN4VkNYS08r?=
 =?utf-8?B?TEtIeTBUM2IwSXVrOHFMWHgzdjhGZHh3dnpWVXBNOCtCbXo5TjFoUERreUVl?=
 =?utf-8?B?QWwrUEJXemV3UkNldU5ITkJkQmp5UEo1RWpBZ1dNa0g5VHJET0lLTFVpc3hx?=
 =?utf-8?B?bGVyVFVSNytsVXhrK0JrdVA2L1FMeEFpbnNjQVplcnBtQzA4cnM4QVN0NCtI?=
 =?utf-8?B?VEY2RmNKMXp5dGxHbnZwVkJGaVpqeER6dzd4T2JoeHlCR3Z6VlRST0R0V2dh?=
 =?utf-8?B?Wjgrako0VVF0dEZOdXNVUDM2Q0lMeEJCdUU4SU4rWFgxVmZWMDlublRJWHRV?=
 =?utf-8?B?MGhkZWRkcDh4MGNWL0twbkJvcW45a3o2Z0lCUXdyZTFJTW03c00xYzZqREhG?=
 =?utf-8?B?VzgwYkNHWUovZVVDMkJPelNhK2J5RFBTUVNLdm8yMzRDMXNoVmwxbTdVU0VR?=
 =?utf-8?B?WkoxeERpZnkyUDhqL3hhUjQ3Q0dyU0RsMllZYnU4ZFZSSnZZVXMxakZ4dm51?=
 =?utf-8?Q?2msQ3MK7ArAYF3ePHwTsCHehD9kE5NOp2LLH4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7494122-ce9b-4251-a451-08d978c9dd42
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 04:24:24.6786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2esWHN1VMoAt+OTVMFhsRefijT3il0bWGgMKY8z7KDsWSapZIO4gi6y/jry0oLS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3886
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: yPIGKYpul3lY6d8-vNezspjeJnUUAgbi
X-Proofpoint-ORIG-GUID: yPIGKYpul3lY6d8-vNezspjeJnUUAgbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_01,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/15/21 6:58 PM, Andrii Nakryiko wrote:
> Switch fexit_bpf2bpf selftest to bpf_program__set_attach_target()
> instead of using bpf_object_open_opts.attach_prog_fd, which is going to
> be deprecated. These changes also demonstrate the new mode of
> set_attach_target() in which it allows NULL when the target is BPF
> program (attach_prog_fd != 0).
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Ack with a minor nit below.
Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 43 +++++++++++--------
>   1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> index 73b4c76e6b86..c7c1816899bf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> @@ -60,7 +60,7 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
>   	struct bpf_object *obj = NULL, *tgt_obj;
>   	__u32 retval, tgt_prog_id, info_len;
>   	struct bpf_prog_info prog_info = {};
> -	struct bpf_program **prog = NULL;
> +	struct bpf_program **prog = NULL, *p;
>   	struct bpf_link **link = NULL;
>   	int err, tgt_fd, i;
>   	struct btf *btf;
> @@ -69,9 +69,6 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
>   			    &tgt_obj, &tgt_fd);
>   	if (!ASSERT_OK(err, "tgt_prog_load"))
>   		return;
> -	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
> -			    .attach_prog_fd = tgt_fd,
> -			   );
>   
>   	info_len = sizeof(prog_info);
>   	err = bpf_obj_get_info_by_fd(tgt_fd, &prog_info, &info_len);
> @@ -89,10 +86,15 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
>   	if (!ASSERT_OK_PTR(prog, "prog_ptr"))
>   		goto close_prog;
>   
> -	obj = bpf_object__open_file(obj_file, &opts);
> +	obj = bpf_object__open_file(obj_file, NULL);
>   	if (!ASSERT_OK_PTR(obj, "obj_open"))
>   		goto close_prog;
>   
> +	bpf_object__for_each_program(p, obj) {
> +		err = bpf_program__set_attach_target(p, tgt_fd, NULL);
> +		ASSERT_OK(err, "set_attach_target");
> +	}
> +
>   	err = bpf_object__load(obj);
>   	if (!ASSERT_OK(err, "obj_load"))
>   		goto close_prog;
> @@ -270,7 +272,7 @@ static void test_fmod_ret_freplace(void)
>   	struct bpf_link *freplace_link = NULL;
>   	struct bpf_program *prog;
>   	__u32 duration = 0;
> -	int err, pkt_fd;
> +	int err, pkt_fd, attach_prog_fd;
>   
>   	err = bpf_prog_load(tgt_name, BPF_PROG_TYPE_UNSPEC,
>   			    &pkt_obj, &pkt_fd);
> @@ -278,26 +280,32 @@ static void test_fmod_ret_freplace(void)
>   	if (CHECK(err, "tgt_prog_load", "file %s err %d errno %d\n",
>   		  tgt_name, err, errno))
>   		return;
> -	opts.attach_prog_fd = pkt_fd;
>   
> -	freplace_obj = bpf_object__open_file(freplace_name, &opts);
> +	freplace_obj = bpf_object__open_file(freplace_name, NULL);
>   	if (!ASSERT_OK_PTR(freplace_obj, "freplace_obj_open"))
>   		goto out;
>   
> +	prog = bpf_program__next(NULL, freplace_obj);
> +	err = bpf_program__set_attach_target(prog, pkt_fd, NULL);
> +	ASSERT_OK(err, "freplace__set_attach_target");

The above pattern appears 3 times. Maybe it is worthwhile to
have a small helper. But the current code is also fine,
so I won't insist.

> +
>   	err = bpf_object__load(freplace_obj);
>   	if (CHECK(err, "freplace_obj_load", "err %d\n", err))
>   		goto out;
>   
> -	prog = bpf_program__next(NULL, freplace_obj);
>   	freplace_link = bpf_program__attach_trace(prog);
>   	if (!ASSERT_OK_PTR(freplace_link, "freplace_attach_trace"))
>   		goto out;
>   
> -	opts.attach_prog_fd = bpf_program__fd(prog);
> -	fmod_obj = bpf_object__open_file(fmod_ret_name, &opts);
> +	fmod_obj = bpf_object__open_file(fmod_ret_name, NULL);
>   	if (!ASSERT_OK_PTR(fmod_obj, "fmod_obj_open"))
>   		goto out;
>   
> +	attach_prog_fd = bpf_program__fd(prog);
> +	prog = bpf_program__next(NULL, fmod_obj);
> +	err = bpf_program__set_attach_target(prog, attach_prog_fd, NULL);
> +	ASSERT_OK(err, "fmod_ret_set_attach_target");
> +
>   	err = bpf_object__load(fmod_obj);
>   	if (CHECK(!err, "fmod_obj_load", "loading fmod_ret should fail\n"))
>   		goto out;
> @@ -322,14 +330,14 @@ static void test_func_sockmap_update(void)
>   }
>   
>   static void test_obj_load_failure_common(const char *obj_file,
> -					  const char *target_obj_file)
> -
> +					 const char *target_obj_file)
>   {
>   	/*
>   	 * standalone test that asserts failure to load freplace prog
>   	 * because of invalid return code.
>   	 */
>   	struct bpf_object *obj = NULL, *pkt_obj;
> +	struct bpf_program *prog;
>   	int err, pkt_fd;
>   	__u32 duration = 0;
>   
> @@ -339,14 +347,15 @@ static void test_obj_load_failure_common(const char *obj_file,
>   	if (CHECK(err, "tgt_prog_load", "file %s err %d errno %d\n",
>   		  target_obj_file, err, errno))
>   		return;
> -	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
> -			    .attach_prog_fd = pkt_fd,
> -			   );
>   
> -	obj = bpf_object__open_file(obj_file, &opts);
> +	obj = bpf_object__open_file(obj_file, NULL);
>   	if (!ASSERT_OK_PTR(obj, "obj_open"))
>   		goto close_prog;
>   
> +	prog = bpf_program__next(NULL, obj);
> +	err = bpf_program__set_attach_target(prog, pkt_fd, NULL);
> +	ASSERT_OK(err, "set_attach_target");
> +
>   	/* It should fail to load the program */
>   	err = bpf_object__load(obj);
>   	if (CHECK(!err, "bpf_obj_load should fail", "err %d\n", err))
> 
