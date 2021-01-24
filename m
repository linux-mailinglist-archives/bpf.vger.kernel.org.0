Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2A9301E6B
	for <lists+bpf@lfdr.de>; Sun, 24 Jan 2021 20:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbhAXTPj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jan 2021 14:15:39 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbhAXTPh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 24 Jan 2021 14:15:37 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10OJ59k4030051;
        Sun, 24 Jan 2021 11:14:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=M0xSxyUHEGp0i5o6SrFO2saJZfUJiEzsCGYywoQwygU=;
 b=I+PewjbQUcjB+liz1KMthnnLTj1mhhIYtt31QRTAYL6kKxaHG3wLFNOIMUo2ExRVjabf
 My+nN5w5igdN3vsonbVjHExrCUAWawZFQJaiTc/rmOtGHJfti41Tjuy+yfKh0w3p06TY
 VhNjz0ACwbG8BIR0Xyc2Lc9V7bM5a88myuM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3694xd9gh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 24 Jan 2021 11:14:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 24 Jan 2021 11:14:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dyfmu+AAa1Kc3+OzI6lhwl7s/bVv3lM1xV7OFQdje8/1/I5CWJ3LZ8twxDOt0jEXsUCuztvwLOOuQkJ7wfT+aUd9IwN9Fogswfl2rMK21/uhQdVkPm4OHUl6dLf8pyCDyWtwBs0w5xLWqK+FnhKLSPjBnCWrkqFnhZfVfvxSoxGiJLrWKsUd9pBS3IZ6MXhC/zSGJOKXt3Xdsqf6aghrQ+U+ZGy5lEji/iL/DPN8HWSnsDIE2weKIPOFW+2Rm7ZWutEVpfPcTdkBKhPxX59AsW6EMB0ztxDp3WfteOr0XBOXTAbmnG/8MyyXCi5WFs4k4rpA2Q24HCcVHFi9ZxEhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0xSxyUHEGp0i5o6SrFO2saJZfUJiEzsCGYywoQwygU=;
 b=fD1+H9brVILMPA6pKIgfJV6dtz1UJNPchI1nwuD//PUiEDVsJAECF9VfSzNqViWGCnn4ffLQqB/llQljU81Qui+rj3zNX277E9zEEWupKKptOu8XQe2KkJO2pu+lJvTf/d7p3fLqyVYHo8nIytD/ZSR2Rea+h2eVrxN0+bGOLN/BzV3RYlkVZEVIouXl7PPQdwB/753MnczPVuVN261sDNDG42fOCc9tZfQP58CYQU9YIaPal01oW4itI0RSYzk+AIz6qIlh8VSY47orsn7CK+tSX/Wyy8OHEuukKrjimPhvrYyTpGusXsojlEvxDn8e28MsMzSi43GeekTLhtZ+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0xSxyUHEGp0i5o6SrFO2saJZfUJiEzsCGYywoQwygU=;
 b=iYyIRNwaqivO+R5QTgB3pGzqhXrPBtktYiji3I5Uc8JOpm9kuwVtMqSYC8LaV7piF9BoQzGpkRPKBt8TZ9v+PnkjWy7sucbpM0R/9rsOuM1hRNNB4XNs10x7zJegEbjLlj6k38hVkOvwvXlw4OGlq0vTC29KtOvkyP2bbYCbl4g=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2456.namprd15.prod.outlook.com (2603:10b6:a02:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Sun, 24 Jan
 2021 19:14:39 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3784.017; Sun, 24 Jan 2021
 19:14:39 +0000
Subject: Re: [PATCH bpf-next v2 2/2] bpf/selftests: Add a short note about
 run_in_vm.sh in README.rst
To:     KP Singh <kpsingh@kernel.org>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
References: <20210123004445.299149-1-kpsingh@kernel.org>
 <20210123004445.299149-3-kpsingh@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3c1fc0a6-2f0f-0efe-91f8-d4a6346be1f2@fb.com>
Date:   Sun, 24 Jan 2021 11:14:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210123004445.299149-3-kpsingh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:a361]
X-ClientProxiedBy: MWHPR21CA0060.namprd21.prod.outlook.com
 (2603:10b6:300:db::22) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1946] (2620:10d:c090:400::5:a361) by MWHPR21CA0060.namprd21.prod.outlook.com (2603:10b6:300:db::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.1 via Frontend Transport; Sun, 24 Jan 2021 19:14:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d09f3a6-d96d-46f6-4052-08d8c09c4bd8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2456:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2456C44A5A28D72080E22EFCD3BE9@BYAPR15MB2456.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UWPx+xgD7TBvsmmRT/Wchl1h2xONL9phboKf+8ovTIWdk/JYiGFziUECVn8Wfym9ss0dbO3dD8B3SFCQBhU95NpEW0Ew/1nTXfEZ84o8HNfY36GazD6Ey9YWLln4lUaB1FbZYEHNTq2eQjOk2QXUQpFyEt/YqHLr+vwfcuV4i+U9yR9Y40qvyYCxICdIAGVgU6Q51KEbdxYBoy3g9z/15SMiJHaSuQ+mMPmgUdp00e14JZ1WUqm+di51z1bVagXMA6DoWF979bSl5F9GP0yB2kNqHVcJCf9P3A58MGPy3ns7KsTs3YXENJTskqkqflqFjxQ8PnrRHlgwhzoEG3E4USfFE7sdh71yuir84VqrCJOHYOQnpbUAPklL64QsH0kRjRtZLavrgRXQWcdT/xyH9JBn1Td3nn3wY/wgxqI7YbRlI3bu64nE48ft4zs8xCpTk71lBq1u88rpFYdmANfhTgixo6MYsaVhtxR8ZHN48/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(346002)(376002)(8676002)(31696002)(478600001)(36756003)(86362001)(6486002)(8936002)(2616005)(2906002)(83380400001)(31686004)(66946007)(4326008)(53546011)(16526019)(186003)(54906003)(5660300002)(316002)(66476007)(66556008)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dTE5a2ZjWFV0bHV5dURWRDF0b3FDalk5dit2cmJVV3hZN1MyRVhxUS9YeFho?=
 =?utf-8?B?b2VESlNXVWxTMnN4dWNvMUxHVWQ2Q2xOTGxob3o1RmdpMGRUc2RST3QxekRO?=
 =?utf-8?B?amxrQ0VkVDF0TUpQMUJZdGt4Z3BSSjY2SGFDRjNjRDdqYXZDTnVBZTZvVXdN?=
 =?utf-8?B?c2lLZndPbFVoYXhWOGlLZ3M1aStRQXM3MHBRdXQyZHJGWjEybmw3b2lUdVdY?=
 =?utf-8?B?NzlFOHdnN2M1MWVxandvOFdYeEkwSzNUMTYwaVM5eTNUTWthVno3ZHVOeGw4?=
 =?utf-8?B?emJSays4VWtVSHh6ZTQ3NzNRMmE1QTNXR2diNGE5eFl1b0ZReGFINnFZYmVp?=
 =?utf-8?B?RUhzWXRHcXNRVmZKUGRWemJsZTkzMVN5aDg1cXNPV1FTSGpxNnB3ZFJweUNo?=
 =?utf-8?B?K0lESzFVd3VhSWJtakd5cnVEbURMSHBkYmRkcHBFK01Walc2VmFiMWY3U2tL?=
 =?utf-8?B?Z3kvRFZweitZNXFVV1JMTnVJbGdMMk9OVENZMmx0blpEbS9La3krdkFRaTEx?=
 =?utf-8?B?TFppeHNZdE5Cakhaam8wcG9TUDFQUFhReDNXWWkwZzlIcHVTanNHM1k1Ymto?=
 =?utf-8?B?dHhlRFRoQk1jQlNiNmN4OGV0RmtKNk1XZVFhU3lIUWt2UHJ0UzBOTzhjamZF?=
 =?utf-8?B?Y2EzSURGRGJwd2tuZHJ0eFo3YWlZQ3M3L2lwN3c5V2pQdWs5Z0MyNGZFZ3ZH?=
 =?utf-8?B?S2F6SWt2ZGZiWWlhV3JKMG01blhTK3JVbENZV2dFZ1ZEbWg1cEFKcEJ4dGxq?=
 =?utf-8?B?RlVwQU9UVGtmeEI5WUZxc2Q0WThIOUZvTnZnY2x1OWpGS0xoSGhEdWhaMi9p?=
 =?utf-8?B?QVgxaDM1eGQxcWdmODVCZ0hXTHpIRDFjYktRUkhCeVp2THdSaFZ1WTFsSEcv?=
 =?utf-8?B?S3YzdGNjUCtYMkFPYXVlN3Rldm9SZFdnZUk4d2I2WGJWOTdOQVN2dXhRZ2Fy?=
 =?utf-8?B?dnNwU0JRSy9zSCt3bUdsYmFpaTUzdXdUNlNqWE83Yi8rSEc3eWN5RXRjdFlB?=
 =?utf-8?B?ejdxWDlTWFlEd0xBVk50SkJkb2Vkeis2U0tVNzdibUt3Q0xoTTI1NStzRGcw?=
 =?utf-8?B?bURjRjk3OUI1VmdRWktwRy9pVExwQkcyb2RJczYyZklLdUpGWkxadlZIN21L?=
 =?utf-8?B?SlY4QlJPSm5jSDFPUjRJZ1oxRThjenFKVllLQlVmaW92bVhsZEtRaTAvUXY5?=
 =?utf-8?B?SUJkNHFDbDZ5RTJyNTh2Qkx1ZTJwdXFXeTg4a3RqUlM5bFN3QkVMTFhWUlBs?=
 =?utf-8?B?VFBKWGx2bHN0Q3crWnhYdUJGeDlSVjc2WFV5dG9QZlRhTFgzc3RLamJtV3ZG?=
 =?utf-8?B?WEh5WTdBYmpkMUNDQnMrSnVtVnlzQkpkZ04wZmhEUnFpcjc5Wnh2VFdtaGdD?=
 =?utf-8?B?UVE5ZXNCV2ZNcnFhdFZHQktCMzhRS0hSUEZCeVliNFFRN1ZxcmRRai9GNWd5?=
 =?utf-8?B?YkF4ZkxqNGkrUXAvNlI1aEs2dDBDYURjeHpkTWMySGFiOEdMTGplcW43Qjc3?=
 =?utf-8?Q?drUf2E=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d09f3a6-d96d-46f6-4052-08d8c09c4bd8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2021 19:14:39.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAyQIpbPAWQyW5z7gC1ekZFl/2MKaWVJFqxIuFhrKapKjEWT5Z4KlXfuNSouuDDq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2456
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-24_08:2021-01-22,2021-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101240122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/22/21 4:44 PM, KP Singh wrote:
> Add a short note to make contributors aware of the existence of the
> script. The documentation does not intentionally document all the
> options of the script to avoid mentioning it in two places (it's
> available in the usage / help message of the script).
> 
> Signed-off-by: KP Singh <kpsingh@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/README.rst | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
> index ca064180d4d0..a0dac65b6b01 100644
> --- a/tools/testing/selftests/bpf/README.rst
> +++ b/tools/testing/selftests/bpf/README.rst
> @@ -6,6 +6,29 @@ General instructions on running selftests can be found in
>   
>   __ /Documentation/bpf/bpf_devel_QA.rst#q-how-to-run-bpf-selftests
>   
> +=========================
> +Running Selftests in a VM
> +=========================
> +
> +It's now possible to run the selftests using ``tools/testing/selftests/bpf/run_in_vm.sh``.
> +The script tries to ensure that the tests are run with the same environment as they
> +would be run post-submit in the CI used by the Maintainers.
> +
> +This script downloads a suitable Kconfig and VM userspace image from the system used by
> +the CI. It builds the kernel (without overwriting your existing Kconfig), recompiles the
> +bpf selftests, runs them (by default ``tools/testing/selftests/bpf/test_progs``) and
> +saves the resulting output (by default in ``~/.bpf_selftests``).
> +
> +For more information on about using the script, run:
> +
> +.. code-block:: console
> +
> +	$ tools/testing/selftests/bpf/run_in_vm.sh -h
> +
> +.. note:: The script does not yet update pahole and LLVM, so these will still need to be
> +          manually updated.
Maybe a little more clarification and actionable.

The script uses pahole and clang based on host environment setting.
If you want to change pahole and llvm, you can change PATH env variable 
in the beginning of script.

I did not test changing PATH env variable inside the script, but I think
it should work.

> +
> +.. note:: The script currently only supports x86_64.
>   
>   Additional information about selftest failures are
>   documented here.
> 
