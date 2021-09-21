Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B28412E44
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 07:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhIUFnZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 01:43:25 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5430 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229441AbhIUFnZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 01:43:25 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KHwN0I005138;
        Mon, 20 Sep 2021 22:41:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LySFkt5FwRP2PO6zPbPJOAdIWnrFErDFh5d4245skHA=;
 b=VugR5WlhnZ3/QW/Fk8Y4viUPStiwm8S2ZQl3oIOmfvWsVc63RnNiy9Wz7gxZRd9ZFH8m
 yyhQhlhjISDfRm8mjZAp8F6VSN3FWh2Xz4wUt2QOhM5Qi+Vge0cDDr214eYV6tu35wdg
 9PxoILVPbETyS86ctUQu3QSHu0hRRh3omK0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b6v27vnhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Sep 2021 22:41:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 22:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiTfTf0RrkzOYogrU9SM7tcqFekPmZvrrhWKM3Sw0SbtubQJ5E3eKH1/tEXdyqRuIwlphmmJOiF1cnZoACr68rZD7Y4aLYzHa9QATQqUcvevwWFWCJCeXZqit3mb6diEdlnkXYhngpizbCw11KeWhkaDBg4oi4t3Buf+62d7J49u7RcMY+m/5XZVtHr59NvrPqx74j1XtPF8ECTAWrVfNe9hbPqV8jI1wHGkJUwpZIf1/xra9swdAROI9TOmlbi9ckWu3ZYYP/cgZ75CBeuyCAwZbKNBqOYSx2S+LXW338JXtUbwumC3RkLlk4tPgrzor3xJ/CURYPjAD1Eh2WXrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=LySFkt5FwRP2PO6zPbPJOAdIWnrFErDFh5d4245skHA=;
 b=mGmOnGlvUIW/FY66Yjgmp7R6+rfhmCOLuiIceAAXAxe5HCn7ShxdN4+47JqdzooxDuoeiTMgceGco8pRDh0dsULiB1bsj/qGw5z7ZctnZPdGdafjnTZlg+XYlfuNWbQxeWFtqREFuhPobtV9uZU3Gb0fS7jjOXXnqGGEI6VMXycvZd+R/J7qG7K/OYuuGANPXFyV97Kz5HFT0n1Sizzvi3rZ7IcvE4/TWgH9yAJQVO8S4MGXkNN84BttBG+dD0ATLFDt+AT6fVk1nAAQ9T3fW5c+356/vbJ2hZQhkLJD6EJBad3skVxohkZWBIyQ+MP+h+ovexn5OWuRX6QIUMnzSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3944.namprd15.prod.outlook.com (2603:10b6:5:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 05:41:43 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 05:41:43 +0000
Message-ID: <6ccf9689-4171-970c-c412-c0ec9652a5c7@fb.com>
Date:   Tue, 21 Sep 2021 01:41:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v2 bpf-next 3/9] selftests/bpf: normalize all the rest
 SEC() uses
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210920234320.3312820-1-andrii@kernel.org>
 <20210920234320.3312820-4-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210920234320.3312820-4-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0324.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::29) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::10ab] (2620:10d:c091:480::1:7a32) by BL1PR13CA0324.namprd13.prod.outlook.com (2603:10b6:208:2c1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Tue, 21 Sep 2021 05:41:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c91293-2194-4bd9-f7ce-08d97cc27dfc
X-MS-TrafficTypeDiagnostic: DM6PR15MB3944:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB394426B8E9CD70C1895018A4A0A19@DM6PR15MB3944.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMjsOgDtnkrUrZyUwZ9OnCxT0d+YAffabw+D1VRc7k/qmLtShlk8L65lHjDjDEi0knwP5Uv+lOV3xqsBjxCTIuXaKzj1x7HH7Mn9uPkQFyVXsZg74noHH5V9eufFxSGRmEvzCh0z+dkRRTF7VdhbEHi65E3ejfGdzeI0U/vjiDtlHLpUK6ZVmtshNCdL3DO6bQSnUJzdYHct1d18D9r5v0jacXqfEu1qvaRNW9KL49BxfRTDQF5ImlRPsxDhM9f7ucdZYuvLA8WsVUQKMmVRxZIs/3z/DVKuzquoez1cVy25nRtjMEhG+7nwPf05CS4nFJv5pdzZin8/E6IBZhz1ZN9fAenUl6uTiGXi0G2ciP9q67iqtzl+MzrKx5GMB9BXu0hq5NLCPW3znbFQZCePR3G3S7uPYTOFgXNTLiLSo1Y/Yn0RMbLdNlqKv4VYc4/Pz4VYe9mfi8KC4T8Myj1c4/3NdgOjYOq2iFVJxzn/leqE1lYwpWJThTsgmTRVDbbMVSggRwZvk+5Woe/15EgD6eCDmRCIeAiV1ayEoiCtwU5TkEK/ijLaOppZdOhebKBAV6xY3s8s9MSN5HX/gADPVf0Wf7pFtlY2S0Dgd7yJEWMqHKgk4roFhfY60t2O8P/BoQ3J9krmgWzOz9LrT0ak/PsbB9p45EHpHW6seGypwSnAZty+Q9OYhGbU4+IsGNCcl2NgN08qnZX2BaNu8VS/fN1ehNC88BltW2rUok+vmjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(186003)(66946007)(31696002)(31686004)(4326008)(2616005)(8676002)(38100700002)(53546011)(316002)(8936002)(6486002)(86362001)(508600001)(5660300002)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzFYT3drNk9xcmZWRG5nMXJneUx4YVp2TmN0V2ZrZGlOVHp1bEJ2akI3TDFu?=
 =?utf-8?B?MzVtMHVvN1BydnhpaHg2Y0pHTmZwekR0OElxTjA5Nm8zNGR2ZFc2cjZhZWc3?=
 =?utf-8?B?YVBFRGhmSW95c3VXMlJ4dytTVms5VHdaREV0ZTQ0dTFGMkwrMkVLUVhLSGRQ?=
 =?utf-8?B?QkhHcVdRbzIxNlBLY3liOGxpNmd2RGVRMGQrZGM5OUVHaUdnZXQwV21wT2hU?=
 =?utf-8?B?Vm1iQXlEYVFyZmpCUkdSWTQwTWJOd0RiR2JzVE9VRjBIaXNob2g4ZHIvbENv?=
 =?utf-8?B?L0puSm1UMUFWVXBudkpBdUVxK2ZDZ3c3Uy9wTTNZUXVtazBjR1J6eUtUUEQ3?=
 =?utf-8?B?VXdzK21wSHFTcE9sTGhUdGtaYVowTkxBdW5HK1p2RVpRSUJVRTBUS2Q4ekN1?=
 =?utf-8?B?anRJNmwwRC9HcHpiWnJta2lLNjNrVVpJdXZ5M21kSU5OWlY3cVlsQTNGWTkr?=
 =?utf-8?B?Sm01SXY2NndFK0RWVmQrRWtCRnEzaElKSWF0NjRHdW00RTRUUXltYjVPUUU1?=
 =?utf-8?B?Y0VKM3pLaCt1THUxcVZzWml2dTFMNnNTV1c5WmpXNzFzQ3VQTU9LbERTNTlT?=
 =?utf-8?B?MUY1aDNQL2x3QTE0MUs4NlV5RG12bkdWSzMrTVgzbS9JYWY3eTJDVUgrS0Jk?=
 =?utf-8?B?M3dKaTA2TFpPbjAxWGtYd1VSWGV4T1ZUU2FhSkg1ZFlPMVp4OHQ2SHlPUTF3?=
 =?utf-8?B?QUdUWmVRK1hGZTJGNSttQlROc2RldmhxWUVkbVRhU05aWHZBYnJ6L0JPZGsr?=
 =?utf-8?B?bE5VNDVNa3JrZkxLZ2dxUmRqSVdyK0hubGRpNkU5QUNLUFJ1TzhrdXQyZlZR?=
 =?utf-8?B?SzZoQ0xGYlpCMXNiZUJFa2prbmNJWFZOdkZsUWpHeXpqVHFIYmxjTTBXUGpH?=
 =?utf-8?B?Zm5LYzhRNlQ4Skxaa2IwazlGZ3g3REQyT04vSlY3K0lQSHB5NldxVXNQNkYv?=
 =?utf-8?B?Mzd0SnEwd0tnMDRVZUR6OEtpNjFpbHoyZCtmZFA1am85a1pWdHZ2QzhwajlN?=
 =?utf-8?B?ZDFiMzlWb3YzZzFvaHkzS3U2MlR1czl2Z214bWU3TUN2VDFUSkRVSFMrZHNX?=
 =?utf-8?B?UGJOLzdFQnBwTU5pV2NrdWJvUElDQlE0ZENmOXBKejRjazBKaGxBRjc1TlBk?=
 =?utf-8?B?dU52OUdEeU1aNlU4ZTVLWWh1TXg1YUtwdTBJODEyMVpRek5RSFc3VEY2Z1Iv?=
 =?utf-8?B?T1d2K2ZWeHpWeE9uVUh5bnlEcXVidmhGUGNrdVZkWnNSUTNyeVJPbnJSeEJm?=
 =?utf-8?B?ZFVJUllBTytWUE43czB5TW9MbEtteEpyc2dNNDVrZmRRLzJFd0xiSWNNbDJq?=
 =?utf-8?B?enhYbHE3Ulg4SllNUDZUVm1OMVh0SnA0N0k5Y3d1SFlUWXo2YmgxQU82dldJ?=
 =?utf-8?B?VSsvMnA1YmhuWVNRbWx0SzhJWFN5UTByTlF3anRyUmh6ZnhFM1VsM05ZaTFY?=
 =?utf-8?B?bHZXbVRWV0M5RERSOG94QmRXRTF3YmVsRUdJeVFRTHpDVGwwM2F3YytadnNo?=
 =?utf-8?B?eE0zV2dPbTl3RWlIaEF1d3l2dmFPNzdKelpFODh1OWp0amRQSWxEQS9EQ1h1?=
 =?utf-8?B?QmtkRVlnMlUvRWl6akFoN3I5aTBtM25oZldROENCNVo5QTVGSGROZWdKYkRp?=
 =?utf-8?B?RlRGaGJkajUraDJXSFdZUzF6TWJ1ajlVNEpNMU9UaWp1eWt0bUw0S1ZGc0xV?=
 =?utf-8?B?WUZ1cndOdUUyc1pmVjRLYlRCM2RTTjRpZTNXbXpucmJNM1pDQnBDZWxiTTNq?=
 =?utf-8?B?ZU9SNDgyUE5ESVNELzhiNGhKZ2dDaHFoUGY1OTJJdk9jTjV3QnlyV0oxWDZh?=
 =?utf-8?B?Y2FuMTNlT0VoQm8waWU2Zz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c91293-2194-4bd9-f7ce-08d97cc27dfc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 05:41:43.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/96MfpJhcecq+rMfBF6suJB/3sNBM+SN0+UW4Ug7yWfEPIHAObwZHX1DL983rERCQ+rWkqfGCbMfCD3YHsi8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3944
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: T8YqobLxq8AUFmi-UMidNCw2HkoyrkJE
X-Proofpoint-ORIG-GUID: T8YqobLxq8AUFmi-UMidNCw2HkoyrkJE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_01,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/20/21 7:43 PM, Andrii Nakryiko wrote:   
> Normalize all the other non-conforming SEC() usages across all
> selftests. This is in preparation for libbpf to start to enforce
> stricter SEC() rules in libbpf 1.0 mode.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/flow_dissector.c |  4 +--
>  .../selftests/bpf/prog_tests/sockopt_multi.c  | 30 +++++++++----------
>  tools/testing/selftests/bpf/progs/bpf_flow.c  |  3 +-
>  .../bpf/progs/cg_storage_multi_isolated.c     |  4 +--
>  .../bpf/progs/cg_storage_multi_shared.c       |  4 +--
>  .../selftests/bpf/progs/sockopt_multi.c       |  5 ++--
>  .../selftests/bpf/progs/test_cgroup_link.c    |  4 +--
>  .../bpf/progs/test_misc_tcp_hdr_options.c     |  2 +-
>  .../selftests/bpf/progs/test_sk_lookup.c      |  6 ++--
>  .../selftests/bpf/progs/test_sockmap_listen.c |  2 +-
>  .../progs/test_sockmap_skb_verdict_attach.c   |  2 +-
>  .../bpf/progs/test_tcp_check_syncookie_kern.c |  2 +-
>  .../bpf/progs/test_tcp_hdr_options.c          |  2 +-
>  .../selftests/bpf/test_tcp_check_syncookie.sh |  2 +-

Ran test_tcp_check_syncookie.sh as CI suite doesn't - works.

checkpatch has some line length complaints, otherwise LGTM

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
