Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89572446A35
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 21:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhKEU7w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 16:59:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11630 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230064AbhKEU7v (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 16:59:51 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5FcVZs028977;
        Fri, 5 Nov 2021 13:56:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=IubO2qwisBWUXivLru9FJCP7z9UIcAyM0WS8/zg0Fcc=;
 b=Uepb9BsMcJwW48YBlH0Za+VXHvzN9ZCfb/5EQin0YbzC4G8X8SfRC5Fd73tgNIID/HAj
 wxRphbXT3Z4/ZA04iEYUzPomyFi+cmPzywKV1nRKv6EXdVxJGdM+GVUeSp57RiS85+v5
 gQsEObcmb3P+2Z9gN/JU/ybDaj/sylKoLYI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4t328743-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Nov 2021 13:56:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 5 Nov 2021 13:56:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVBXKCQpOxw9qgG9MHclXHGkAq92oxq5xK91zyesBCOBdXRT98iqMgrDZCD3dLK7crYhkOK4eyBAqaynvmClrjxOXDAZcVRetXXLVt5wsOGP/dQg2A/D1sB0ZpU/bLgoYiJkx16TA7ap/DNogwtLT6xvNZUYXrVgEnvB9avUDISSZqnnPx11/VzTgOHzVUlRimWKmO8on/tIzXpPwhvq8pvzcHKCVArROhPqNa+7et418bYlRoi7Q1VrgDPzkSeTaJA4HJyhbYZnftpVUAeCnD54HGDqaqYD5KqaM4kzIt/M2QVndlp+N9p9brGQxbNW0FjDjw/sTu0Mtg6Ljl6XRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IubO2qwisBWUXivLru9FJCP7z9UIcAyM0WS8/zg0Fcc=;
 b=LTv6o3Uc1G92COfUQCnpmfpO/eXS4IUABbZw4iHW+59BFOeWCAHhUaWlx9mYhHRedB0FgbRpOZ3wOIwh7pk55U3T7qjsXl5Kbeyvs8/r85mcs4FFMaby7wFaCMtVMYNTtrnloq2Rb09g7LNEmcrBG1t56Ru6Vugik/s66w9+9Hos9ptZBRqAuXyGzD0RjfNXW2z+XQVB4LNpUQI5KBu5aMDorTgTMWI9PKgqVdqkPkruDlq21cGaDQz/BsVfcPk45HJtWkJOHPrBvXhg++4BXlUZeVFG3Lrf0hW/PjoWEDsGNyUs+Myj7mdThSMeFd7nQIxFB8khDxPelWy7O/PqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3816.namprd15.prod.outlook.com (2603:10b6:5:2bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 20:56:27 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 20:56:27 +0000
Message-ID: <12795cc3-0399-4124-8d80-ce2690151558@fb.com>
Date:   Fri, 5 Nov 2021 16:56:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v2 bpf-next 12/12] selftests/bpf: use explicit
 bpf_test_load_program() helper calls
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>, Hengqi Chen <hengqi.chen@gmail.com>
References: <20211103220845.2676888-1-andrii@kernel.org>
 <20211103220845.2676888-13-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211103220845.2676888-13-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::31) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::102f] (2620:10d:c091:480::1:1723) by BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 20:56:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6062872-1344-46da-c3a7-08d9a09ebc48
X-MS-TrafficTypeDiagnostic: DM6PR15MB3816:
X-Microsoft-Antispam-PRVS: <DM6PR15MB381645DB78CEDEABB1E750C8A08E9@DM6PR15MB3816.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdtKBStVnIWYh8sjw4qVZIj91aVK46OVKOGeUrhVZaDsHskwUw6F3NcWT+DVJbNC8jiEkB3C14hFxWXOZDqf5E/+SXYZyyjhhIMb885VKXTgviE5s7QbbJqN2v6H6qVf8GuEcmnbcPU3e2OrEVMH48AWpxgVqy89B3E8IM+5Pij0ndkNMmMKYne+NVduS6UFdLM/1CfdnHEAlMAoEmHjEgLuia6eAaRMwRRPu7eHc0FRUDFVMj3plevfbcGaN2C/oVICXU12uDRec+SQ/iTb5/a70tPDfmTaLjPhke4GHjXXzEfoIdGd8s7P/Ap9lGK/cAZGFGQoXpSl5k4AOKZejMLF0B1H5pdoMN/eGFBWZfao6KowHIeeU9a/M8xe9gO576kbvg76qDkincTCVixNT9X8MyG2TbJScFsvz3NpV7KWgkEcb7QrFlt3GSfXPLZZVG7LlBp+W4n4xU+5QyAkQZF8Xgw11r8z0C+1pk+KuyN+nTFChczI7pu2byBg5EFAqueB9GQE9tvKMPst9JJ7k6JDTL9QTVizvl8fjBInQpKhEeOAcbcMc/i/H6+dUSgaS2e9MVTFanBvYud773PdJkcmtpXVMlhy/6S3UeHpQ6lIBUS1qtjWYq5JkwrZGQ6Ge2bApltU2f9jhfO21JI04oKzIoUxTJs95q27gchpsRZEH1TNX5j+fXJwpvGu+3SZa+L9sVSq5mG3d+GufeGuAVNUXAjGcA8QUNE8KzWU49M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(5660300002)(508600001)(36756003)(53546011)(66556008)(2906002)(66476007)(8936002)(66946007)(316002)(38100700002)(8676002)(31696002)(83380400001)(31686004)(4326008)(2616005)(6486002)(86362001)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZLbFVQY3BQbjR4WnVWbmt2UjUrTktyaWxja3hkaUgxaTIxMGtJRTRxK0Vm?=
 =?utf-8?B?QS93eHZPN0YxU0ZjbENLNEd1TlQxaVM3VFYxRUdOMmNMQTk5Uzg1K0lBN1g3?=
 =?utf-8?B?ZGYxSng1QUVFTTRRS2VseVRvYSs5Yjdhd3VVM0hZb084N2tDdmorZEQvYWh5?=
 =?utf-8?B?aVJrN0M5NkdsTkZraURCTy8yTGY5R3VKRENDQmpNSnVMdkM3N2s1bFpycGox?=
 =?utf-8?B?Y2JmeW5MUHd0Z25NbWpKVlc2ejEzTVRDbmk5ZmRuNDc2cVRXNnlIK1NxajhR?=
 =?utf-8?B?M1VJY2dWR01jYklWbFg1Q3psNllDbE91L1FaNExHYlBJaVBWQzl3MERYa1JP?=
 =?utf-8?B?ZE45UGMydVhpOTcyVjVzdUFPQTQrTk1qcVBsa1ZrclRmK2NQYUE1UjFIRGx2?=
 =?utf-8?B?NVJBcmJwdzBkUzNKMytSWmJDOHZ3U3BML21hUDNYd25oVFR1Ri9zck9nbjFi?=
 =?utf-8?B?NGhPVHYrUFJUV1JmWS9Dd0xRclpMTnZxbVk1b3BGc0NoWE1IS0sydFRoamEw?=
 =?utf-8?B?WmNZUHo2U2Q0ZzhVeXJINFljV1Vrck1oK2s2RXVMczJuZTBEUS9qZEQ1a1Vn?=
 =?utf-8?B?ckpqOHFocTVGTXB0RElDNVNFQ2k4aXA4OWZaaUJSYUNkekRON01XOXo5QzBS?=
 =?utf-8?B?Qkl0U3JvZ0JxR3NXMjZydDJDM3VWdm5CNjFGSVNqekgwbnBGb3BwQ2IvVWJ1?=
 =?utf-8?B?cHo3cjZRVUNKRXdZWjA0VmJVeTA2dWFJSEpDSWZqVWtPcVY5dUZISmlUVmFh?=
 =?utf-8?B?T1FOSDRsVUp3OHkvQU9vc1Fzbm5zMDRrSitNVkxxUElPeldOQXhZNE8vZEZN?=
 =?utf-8?B?UktBUHJJWmhaWFNDZEZTVzQ5ZWxDMmV6bGZpN1RlMGdrbTB0ZTBDdHFYNVc3?=
 =?utf-8?B?dTRDUzBia0dXSXVFN1dvVnZiQlZ1aFk4T09FT3RRSEUwdXNuZWxRbjY4d0xF?=
 =?utf-8?B?Q2RmVElRRG5ZQWhUdWF4cEFTMXozWTVKQ3Zvbk1UYWF4Y0ptWkl6OSszQVRi?=
 =?utf-8?B?NEFzek5Ydkh1RkppaDdsa3JtMHViUkVJcitlWmFBYkxrM1ZCZmZkZjE2Z2U3?=
 =?utf-8?B?dXZDRFIweTFOeWFQTEkyQ0I3NUVRdEVtRmM0UjhBcTBFQ2JUaGlxd2lSUUdv?=
 =?utf-8?B?bTM2VjZYVlF2d3NVYTlzOVVtUmczOUhaVUt2VVp3NDNSRk5sMy9NRXRtdFFM?=
 =?utf-8?B?UHU1MzVRZW1MOXFUVXFXUFdJU0tqeENhaHAySjVLdWNiQ0ZtWFcwKzhGWFlK?=
 =?utf-8?B?NmtNTFJVNUJ1OWwzWk5TMnNLUVlkbkVoTVJVMzF2aXFxOEpKRTFPZCtLMDhH?=
 =?utf-8?B?ZzI4eU9zVFdEMHd6OVBjWVJIMnNQZXhlSlZ6U1U1a1VUSFdLc2NkLzAvWlBN?=
 =?utf-8?B?WC9MekxrTXlybXNOVER3dFJmbWJNRkREL0FDSVZ3bVBwdWp0V2hKeVRaei9s?=
 =?utf-8?B?UVdUYUxGWlpnS3FqczZFcHJmRGx6a2NUd2xiZkRYWDhSRFJTRXd5YU5sUVdi?=
 =?utf-8?B?Sm42RFN6eERseklWYStUWXFhVG44WHpHVFVwekd4dXl2Z1pXcXdpSnE1d1VV?=
 =?utf-8?B?R2d1NUdndHpMZ1dwM0x6L21FQ28yMUdRREtCTVVWWE95eENTSVUvSjZPb0Vw?=
 =?utf-8?B?YjFmZ2lWWjFlSktVVWlvNytCK2xoMGRxRkJVVHhnUzZMR0Q5VXpCZmxXWUZT?=
 =?utf-8?B?ZE85ZWJiazl2Z1R6Q1d5aUVDSTRkTkcvdVQ3YnpjZlRKZm9LQXlhMWpQS2dZ?=
 =?utf-8?B?SVVjdUlmd2NDVWVqenFyNldMZmFpTzhSMytlNm9sdXBPZDNER1ljdjBydGk1?=
 =?utf-8?B?Skl1TW5HMExOMXVlV0NyYXFCMllhM0NsUmFiemRQN3V6NlZwUi91Q0JTN1ZR?=
 =?utf-8?B?UTNsVjJkT0RJTjZRQnZhUlg3RERqOTk3ZlNneXM5UHA1K3hidEVPbXh2aEgr?=
 =?utf-8?B?QmxQRER5SmxQNXduNm12OVZ2Ujk2ZmFvT2F4Uy9wOGhxYUtlcjhSRzZlR0V4?=
 =?utf-8?B?Z1AzN2NCL0Fkc2FvSWJHc2x5TzlaaUpPazNtWjFGc3pudFJKdXBKRlJGdjZw?=
 =?utf-8?B?cTRmNzhiSUh2Y1RDa2VqZ01UVDhMUVptN3ZuVmxNRDVvbWFualp5QVI0VnEy?=
 =?utf-8?B?VVFPUWtINVRCTGdTM05aWHhUUW5JSTRDQkErVmNzbDFzWmNUb3VGQmdUczhB?=
 =?utf-8?Q?83rxY3WpS+GhzMSBbrnMbwTan5aQLqsMu9FNGB5kFzPm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e6062872-1344-46da-c3a7-08d9a09ebc48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 20:56:27.5570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nvABjRplUfM13KbmzRZLJfrckKuDhBR+W6+dgpPmYsuCe9btF5FvbFM1YFU6/rk8rOpOpR0A4rZQ10WQtNS3ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3816
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: FIcmp08JWvsjF8rcvI4G8FzJHD-mQ65q
X-Proofpoint-GUID: FIcmp08JWvsjF8rcvI4G8FzJHD-mQ65q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111050114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/21 6:08 PM, Andrii Nakryiko wrote:   
> Remove the second part of prog loading testing helper re-definition:
> 
>   -Dbpf_load_program=bpf_test_load_program
> 
> This completes the clean up of deprecated libbpf program loading APIs.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

>  tools/testing/selftests/bpf/Makefile                          | 3 +--
>  .../selftests/bpf/prog_tests/cgroup_attach_autodetach.c       | 2 +-
>  tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c  | 2 +-
>  .../testing/selftests/bpf/prog_tests/cgroup_attach_override.c | 2 +-
>  .../selftests/bpf/prog_tests/flow_dissector_load_bytes.c      | 2 +-
>  .../selftests/bpf/prog_tests/flow_dissector_reattach.c        | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/signal_pending.c       | 2 +-
>  tools/testing/selftests/bpf/test_cgroup_storage.c             | 3 ++-
>  tools/testing/selftests/bpf/test_tag.c                        | 3 ++-
>  9 files changed, 12 insertions(+), 11 deletions(-)

[...]
