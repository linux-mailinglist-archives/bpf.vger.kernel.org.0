Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB1037B516
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 06:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhELEfW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 00:35:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229495AbhELEfV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 12 May 2021 00:35:21 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14C4VIPS022128;
        Tue, 11 May 2021 21:34:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=unw5P7yJf/1biWAQuGXc6QETxMJCvRsIWg53HDXPJc8=;
 b=KFuq88Y0ebLCde8tBoQQV9s0y7iLZdyx9uzv1Mo+SaBe44sYB6vsUri27DWxAUvL2ncm
 NoO56Acc5WyV93rMIcd2UUdzLEqD1tp+H+INoqPvxtQkKHVPYsfvkaJrCWe5oPmUJJR4
 JEO7mt0yohaJ6gvGR3n6y2fG1Cg6hkTEpIc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38fap79197-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 11 May 2021 21:34:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 21:34:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmcwUQ+pn2hrg5yLBWxobFxWuAWv7QVRsixmYfi70XptxzEWERVNWANVcUCR0pFFk0DEwrfR8zuFFAGKSRDRP23X4QomoPik/Qm2Bpnv06Zsxm2iZJM9pI0AWxY61GysAvurtgHkP/p7EXnWJAuvPYquU31GDAw+OPYrc/f5XWGUJgl5YWy8MdnZmycg4U7YbJh3xnGDDZnHSjUu87zw8ZFDBmJ/fOcblhZluSMZuEQH9LNkPlFQUEdJeOmLY/crraWrKLOiqZXH5pmaJzBycRV87nPbwzB3cW5wHtLjmbal4k2E4BzhH1EaJYzIv+pk5mJgqXk9+Dn3FydD7gJsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unw5P7yJf/1biWAQuGXc6QETxMJCvRsIWg53HDXPJc8=;
 b=koTUicKXBo5A+xP4h88z6lK3IK+/ZeF92F+rVGc1bnwSV7IhdYVheGOgGN71imYQ4pGg0ogN7zvgnX7Xjq9AfnLqXbVQYGT9/ecYznMG8bVb8fG8Whmzpy/dyN1elOeDiogocMioJMCbLm3bIWTf+IBP8cWNUthVdInvrSrSt52HhwaevYirDAsodV5N/JFn1CL8+EPvhGdNUCpOe3BwrzrNbzr8L2OTxDRyELnX9r3FzWA1H+w+QyQRqjwndSoo3klxU16GP7/0KEFUcgFC5xtuZWSaFdlSFhidF0C4qI4Q4JN3o/A2G2iVEKdjjv+g0XCl9LTPJRt4PZKysqzzAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN8PR15MB3364.namprd15.prod.outlook.com (2603:10b6:408:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 04:33:57 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::d427:8d86:1023:b6b5]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::d427:8d86:1023:b6b5%6]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 04:33:57 +0000
Subject: Re: [PATCH v4 bpf-next 16/22] libbpf: Cleanup temp FDs when
 intermediate sys_bpf fails.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
 <20210508034837.64585-17-alexei.starovoitov@gmail.com>
 <CAEf4BzYPHBeK3vfwFm7oUru5Qb2MFq+sfnFV+=J-duevxXeryA@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <de6e783e-229f-cb16-add1-f12f58367e09@fb.com>
Date:   Tue, 11 May 2021 21:33:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <CAEf4BzYPHBeK3vfwFm7oUru5Qb2MFq+sfnFV+=J-duevxXeryA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:aafc]
X-ClientProxiedBy: MWHPR11CA0006.namprd11.prod.outlook.com
 (2603:10b6:301:1::16) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1acd] (2620:10d:c090:400::5:aafc) by MWHPR11CA0006.namprd11.prod.outlook.com (2603:10b6:301:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Wed, 12 May 2021 04:33:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 237421f5-e8c0-4a0e-a94d-08d914ff27fa
X-MS-TrafficTypeDiagnostic: BN8PR15MB3364:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR15MB3364B2D82202332955CDCFABD7529@BN8PR15MB3364.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfpSGTB5IpSKvq5XM0gkX0fImH7NXMuJpXOjNsi4fCo7gq/ZXTpMU/aUOuWDyfddY8x1YDj+gvl5hrPwF6RhLyOmPxnbbaoS9p/iQ5alS/6MKW6ZmpmsqMi4CvQr/W9vPLqZUzu/Qp0freEec0WH9/YBrqE0Vk1GvYOC//jfGwdLq6nVbB8VZHAkYFTWTcB33oVtAP2d7ljgqY2sW84xNC+Q/eD+7622cPMACw8F+Z0OaHzgQ0ev/0Jzt2ugKrvv0F10ceLcWrIhY/IJfNDK6FzXpU4+AegC68dvuOqR/qfR4K2qVtHhi1fVci5NSBPiUcHeWnobkuMU9UsmUi29Z4JyPmAPpMmZ4MgVbKBftuC0XUETHZ5MEh96iqmjW8AWXHudxYKUPBFZ5T3jEr4mtlutKf8TYLb9hoXNxCtlj5mzu+SKCIzXrrOsBpyu59w39fnZuIJlkKc7nxMU6/Sl5Of1ddCe39P0XtUmwJukLEFzsTEo21Zyl0AJYmjyiHqtxhYbGmMFsdYOXtdJCdIhvMXdliZ0CIww0cFDqFZAgSDOd/JsecCpzWk6wAGY0TRGeFU4PbQxdn20jYKDPiVb9Y3jQVPoJJpv/gVqZBi4H02G/Ah7AiI5ntYoNhjWCF7h/yu25mMtEPfJ1QlqtrHUGPZwftD2yhf7pc8nOt3pVGKERviHhCpBGtkSJlNTVpCQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(52116002)(2616005)(186003)(478600001)(8936002)(5660300002)(31696002)(4744005)(86362001)(8676002)(66946007)(6666004)(36756003)(110136005)(54906003)(316002)(66556008)(38100700002)(53546011)(4326008)(6486002)(2906002)(31686004)(66476007)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VTlZR3FqSTFEcEJqR1hLQUI0VzFqUXMxc1VWZTZ1dk02enZ5UmNpZDZPVkRi?=
 =?utf-8?B?bjhkdEpSWFZoQ1YxSkFYdkpNSExlcDJNZ0p4eEQzV05BRTA4LytNL1dOYkRQ?=
 =?utf-8?B?WHVxckl0Nk5xK2kwNFY1cFFkWmxvMHdBRVd4TC9VbkE3MGNKR0F4RGZhbmRI?=
 =?utf-8?B?SXBTU1NrVmdYbG1ONWxCZlNtbmNrTmM0ZXM2b0YrY3lHbnQyc0pFMXQzNzl6?=
 =?utf-8?B?Yzl0a2Jibk01ZUI0RDJhb0tiZXV1cDBBVkRWaHJXVmtwS2NHSWVEbkhQZHZa?=
 =?utf-8?B?RHA2QldoUEErQjRmekxMQUtUckZzQlhRZFNrZ2FkTys5VVIwTGxPemg4Y05J?=
 =?utf-8?B?c1pld0hHNkc5VjNUaTU4ekY5WVM4MmZYSVZjU2gzTmJFdDgzY0Z4dnkzZVA3?=
 =?utf-8?B?SXNOT3VvU2JSRzJrM2NLL20zdjNJQTJTbWdiSVlNamRKdUhGWkEvaFZXSHl6?=
 =?utf-8?B?VDVBd2FqOUtDVEd1dFVVR2ttSG9PamFHSEFndWhqMU9FVUJVQVgzZWpuY01V?=
 =?utf-8?B?ZlREYm1KRTBXeWlvZWlvSFlCdjUwVHNEaTQ4MFZZeTJWYmNKV0FoK0tCUGhI?=
 =?utf-8?B?MzBibCtHV2pZYlRCN0craldkdm1NdTlNZVdIODljSWJ1UmcxVkdscEhIcWdv?=
 =?utf-8?B?WFlqVjA2NDdUYjlPNnhPUnZLeTlmeVNUd0N6TFYzd1FTaWQwYVpQSmQvZFFt?=
 =?utf-8?B?by8ycWU3a3V5R2pQalEwb094ci94TjFPbVNHQ1IxZmF1M3JmME5LQSs3MFQ5?=
 =?utf-8?B?NFhCaFdRN3dDOUF1SWx0UnlVUmFGR3RMVDJhN2h6cDFvLzdTRkhvMmdKaWd3?=
 =?utf-8?B?UUJDbGk2d0M5MXh3bjk1V0xrL3J4a3pnTXZKSEwwdFpMRStleW95S0lkQWlP?=
 =?utf-8?B?SDVNZ3drRHkzV0NROEsrTjFrMEU4Y3lPSE56Ri9iZU5EY0kzMDYwUW0xUXFt?=
 =?utf-8?B?OHlTZW9pcVovVGczTzhuRUdkUWNlcmtuUzRhbXljSmFxbytSVHFBQ25vajlS?=
 =?utf-8?B?cTM2QXFKbUtOK2MzRm1MQ3JLYVFYZzZKUjF5Zk5MdEpUZDZDRlVZTE5LaklP?=
 =?utf-8?B?NzJrSXZwWEZMeGpRdFdOS0hVUlI1UlJ0cWhrcXplL3NnVkRMTUJyMnZzQmhs?=
 =?utf-8?B?S0twbEFvVUx6NngzS2Vyb2xneXJCdWdsbjc0SzcvZ2hRcmY2d2Vyb1lDMlVa?=
 =?utf-8?B?Y1dhQTRaQk14dVo2YTBxRXZBbmU2YldhMXkzLzZBbWcrNGJ3MkttTE1ZM3Ru?=
 =?utf-8?B?cmtQZUw2SzdnUm5za3QxTFpKSkk3WWJxZHN3Tnh1YmpURi9BZHA0aWNONkxo?=
 =?utf-8?B?QlFKMU1pdEZ1VHNlVFNucUxxbm5mNEROTE93WTNzL1JSUTB1L09EZ3c5dFVS?=
 =?utf-8?B?SVJwQkpGSThsK09yU3BIZ3ZUdTJ2Q3BUNXMxWGtKdG4xanpjVFlPUE1kRTBB?=
 =?utf-8?B?THVCeVVpc0Z4VWJYUnp3VTgzU1UxRDVpMThGWkk5dG0xLytLdjJ4Wk9NY1pi?=
 =?utf-8?B?TzVHRDRLNjJ5UTBpL01hZVhJeVBlSEdsZXMvMXVvQ0JvUjU1bStUNFlHa3hu?=
 =?utf-8?B?UUJmZERlaUZXTk9TbDBMQmVIeXE4Z3VBYi9NSHlsZ1VCOFY1NXptMUdnNVZj?=
 =?utf-8?B?NWw1dzI3UGt6ZUd6YzhqamJNTmRjSXN5emQxQnFpd3hTQjZ2NkhzY3pOelVM?=
 =?utf-8?B?dFRlTlljOVJqOTNQZTVXb04xSE12eDVNVzBINSsrbWZKUmRMZUtQa1lScHpx?=
 =?utf-8?B?OENpZkVGcHNFTHdrWGJ0UkJsSXJWRm9wMHNKZUhYWmZjeCsvYWZ0VjBlRXVM?=
 =?utf-8?Q?4lUq+bcyKGhisYk7U/I33vsTVjDA/ZRVw0fHU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 237421f5-e8c0-4a0e-a94d-08d914ff27fa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 04:33:57.1139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kuIsRFZYxhJltk3e4Kx72ftRD7kf0bAQbELgRL2kYXvY3bfsp7JK3cr8Ikp2E30R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3364
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: i9oMkDD_W9UAYM7PwhWgzVcg7CbXuLFo
X-Proofpoint-GUID: i9oMkDD_W9UAYM7PwhWgzVcg7CbXuLFo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_01:2021-05-11,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120032
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/11/21 4:34 PM, Andrii Nakryiko wrote:
>> +       bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JSGE, BPF_REG_7, 0, 1));
>> +       bpf_gen__emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0,
>> +                                      -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1));
> Just curious, why not a single BPF_JSLT straight to the cleanup label?
> 

ohh. I still didn't fix JA. I kept thinking to make it use imm32 to
address long standing issue with large programs. It was on my mind
for so long now that it became false reality :(
So above I did to avoid doing simm16 check. That's what llvm
will eventually generate. Once JA supports imm32, of course.
Thanks for asking. Will fix.
