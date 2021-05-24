Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3738DF38
	for <lists+bpf@lfdr.de>; Mon, 24 May 2021 04:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhEXCfl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 May 2021 22:35:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21414 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231867AbhEXCfk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 23 May 2021 22:35:40 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14O2UTHk012677;
        Sun, 23 May 2021 19:34:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nOat5laMslQOllSd5Bu4E679a0Pwny7JacEQ8JHT4mA=;
 b=PsttnC30QDjUtKoxTqav2xzPm4EvhphAXItTiY/BDvbGqGDjAZYhZPAlooHj0NoEo9oy
 vq7LrACwEOFH96dIvMKJsNwp4008qJvmazJUBUJctLtjysSKoMgbMuTLLyOi1Ms+qkcy
 ew2PcU9lQtmJRW2Mw02ten26jpkuvlgvQpc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38qht132wh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 23 May 2021 19:34:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 23 May 2021 19:34:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2lzWb6HT7GzujvJuBu7hXbDRm7FwxBLvOydHNjnAW2arO++2k8zd3zy0Gnsy6EWKyOllqnufsnJz9l4RGRLrihk0fzk98NIppnIg5j/2zTTAQonYjirsLbTlQvCPtqe1rjYimkZuP1lfvYSZw37B7N/VP5iEo5rMyuV0e56D1H1Xd2cUe9tu9+pTnRehMlvmgRyAariN1/whydPy4UGtZpraDcO6Kz2X8tVlYAEI6wHWm5/EHApUEVdcbYEAb4vciO7nf28jwo3w+SLJVaevf9PWrQwTiVJKwryCJZZGlUKsfndBWizZRFL3qR9IJao501Q+Iv3FcWileeW8KwDVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOat5laMslQOllSd5Bu4E679a0Pwny7JacEQ8JHT4mA=;
 b=Gq0DO1Z68h2Uhe/DP3Xiahtdqa0eXSTOjRoA/0QS0jj2rba9z4JyAz+Dv4XGOsNd1PjPmqTSaPqVy/ceSQVs/58dc6jh3ap+zg1dmR/GD/r8ripahdm35yagNRBJ5mjoqMFYnqgNXzU3/qiPxnZWue2OW1k19x4Clp5EYbFDSlOAzv/VynFLstAYq4WU90pfhxuEJpXtOxMAsrzn42Y7zSkR663MpZKRc5CVZpWJNJrfBALSyM1UTPTrah6x4Q4UdcEfJH4OMxKqusG3pCTeU+Zf1Rju6hRwFQsx6KeoLXJ+5iSDNt9edHcv1IGiJSe6e/euLyMI3FULl4OskdfrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4096.namprd15.prod.outlook.com (2603:10b6:805:53::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Mon, 24 May
 2021 02:34:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 02:34:07 +0000
Subject: Re: Why does bpf_probe_read also release relocation information?
To:     Shuyi Cheng <chengshuyi@linux.alibaba.com>, <bpf@vger.kernel.org>
References: <4b600d5b-c92b-878f-1306-d15909b56c3e@linux.alibaba.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <04c59931-2b42-2994-8080-582beca40427@fb.com>
Date:   Sun, 23 May 2021 19:34:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <4b600d5b-c92b-878f-1306-d15909b56c3e@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:5649]
X-ClientProxiedBy: MWHPR17CA0052.namprd17.prod.outlook.com
 (2603:10b6:300:93::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1160] (2620:10d:c090:400::5:5649) by MWHPR17CA0052.namprd17.prod.outlook.com (2603:10b6:300:93::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Mon, 24 May 2021 02:34:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8332bfce-9c9a-4203-0dea-08d91e5c673c
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4096:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB40968DC6F00461B619955B6BD3269@SN6PR1501MB4096.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 31g66RDsy3KSViTH7PDrH9YiAUXGGri7y1D4DCkctk2s+alGQvKBAgyrGN8JECQ3ZwXcybB5w+5OCbtYf75XwAdO15dz+VlrZXwMcpKkdg4IdDu1omHGUQYCHg2VtdspAqBj6at4PM1SggpHL3chyd2vfIZ9Dyt+gP5zCG/QRjDmsGWaF9mOdjmhE2a+uPjwaAQk/R+X2tdH2MDXHyLbrCipaMffXO3Z4na9xApbhXORF4gzyvC3iBzSQR1rG5J8xBSmT/o+M2+HToypAq88dtyfeKmxbYxi2LW06E32reJSLTkRaUZX06R/v2fwkgmT6a0A6TRvu5xvXR3pDfCk8+jBy6Js+ZEjIOC501M5t/oYHfuBkX60RZOE4lRZ46uftv9AxgsqrleJSGeJe61/LEeS4AhRp6NI0fgBZxTKRfodNJtv3qY+fRdy00LKO2GzAs86W8GwbVO+11gf3dNzjte7EYbkdfWDJPGJ/tgGxoZ5ELTYGKuM1aI3bKMGQ+LBmvLNA4UBGujS3aTDhpTfN1bSfcdc/EwEnYzxnrBEmtj25+X4mUasSqkQ0einQL45YVKQwg7wBOqUFW4k98CW2a5+pus3pAbomwdFvBWficMZH2bJ+yC20D+PWmrWphO0q+TsA9bVVedjHWlSELw3XuAXofutYwJN8MbsjsDy6B6eyV8tgUDw7nTTYmQAB3/JPINxRwyPHKICW9OCkmcDocfkcunSgedID7Ce2Otm3rX8fUgNnO6znUj/fkd1CprufMeXkHxBl01jKJ1ch1lfTGWepZqQpMpTvg8mk7DN/bTMs7NWk4ej4Ua4bLzN95jC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(8936002)(52116002)(316002)(66946007)(31686004)(38100700002)(2906002)(8676002)(36756003)(966005)(31696002)(16526019)(5660300002)(83380400001)(478600001)(186003)(66556008)(6666004)(66476007)(86362001)(53546011)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UWFqVFBCbmdDYllXVTJBOFdrMEJDWUhxSm9BV0ZTRi9UUGZ4ZUMwMnJSZkhM?=
 =?utf-8?B?Q3JEdFh6ZUdMQUVlOGROTC9tYkZaZUxYY1ZIdnlTSjcrZ0FBd0MxV1VOUERK?=
 =?utf-8?B?Y08zK0xZc2tlZkhuYjZPeTNmSGwvUlNjWGpxdXo2N0tmUEtYOFhxRW9YemJt?=
 =?utf-8?B?S2dOQ3ZZWVlOd0V0L2V3UlIxc1hxVFc0Um5zc3VyKzdKOTZwOERZTTJrelJN?=
 =?utf-8?B?MWRqNWQ1Q1Znd2NYNWxORVVqblpZQmFPM0xvWDhpWS9TcEdoV3lEK0hJRFdk?=
 =?utf-8?B?d2psOWJ4Y1hPdVlDamxON1NIclVXblYzbktoNERaQkJya3NPS3BMb2Fvb1pJ?=
 =?utf-8?B?a2g5SFRWOG5ZQ01VYnN4WDZhK25sZWdDMkRYMGZ3ODZlTFpBYUZjdWw0djlm?=
 =?utf-8?B?QjJ6RUR0MEtjeUg0dm91d0V2bE1KRThldnc2aXpra2JMSzhBa1ZobFpUU3JE?=
 =?utf-8?B?cDJST0VlcjE1ZnRiSkFXN3FTNW96czlVdDNwRXhIR0JMTkhZbmZZR2o4L09q?=
 =?utf-8?B?THFvQ1JUaWRrR0RoZkZwNnJvZmErS0hLN2YyRHhCU1Q2UU9zSW9XRHpJbkpj?=
 =?utf-8?B?SzZXdWZQVzZkOWpXdUpldWkraVZCUXpUZjM3LzZMK2U0NlhqcUtjdDEwb1V2?=
 =?utf-8?B?ZU5Od2FBY3ZpMjZTaXFpcGV3bTNTM3ozaElwUFYvdXlSVkJOVFN6UEcwdWNW?=
 =?utf-8?B?dnNGUndFRTZYU3g4aURTZVpac0p4cnhBdElncDNLMTY0K25kbG0wMGEreFQw?=
 =?utf-8?B?WWhxOTJwc3ZwZUN0YXIrNTB2bjhzQlVVYnc3ZnlRZEJSNTd5K25wTEsvdXBE?=
 =?utf-8?B?VElLU3J3UGRiM0thSWliVk50MDhabTBCTDdYWGxsVlJKd2lvSWRiMlNLWVZB?=
 =?utf-8?B?ZU9NVGgwK0FpcDh1R2NCRkFOeHdzOGlrS01DeXRaaUo0MkJHTzBLU0lYdkFt?=
 =?utf-8?B?Z3QxR0tFMWsrV1VQcE8ybFJGWWdtWXZyakNLS1p5V00vR05VNFIwQjRoeCsz?=
 =?utf-8?B?bEpVUUZkWlpsNXBQbnZCbC9ZWis2Y2J0MGQxcWtYdlkrL0xyUjlRaXlrSGpz?=
 =?utf-8?B?amFaYWpiSyt2ZTNoWW1VeCs5Mk94VTF5dTFCL3RXcmFTckNmK1h5RGQvdFA3?=
 =?utf-8?B?ckdmTzA0NWN0eE0vejlDcjh6d1JMUXlzTWJvQ2xpZ21qa3lDODVzSHJ4OW9y?=
 =?utf-8?B?ZFN6OFlKVTFIVkVhTENuK2o3ZTUxZng5UkhOZG1BNFRudUpnblJkYisrOGxx?=
 =?utf-8?B?ckJHSkVTKzNkKzBTVHVVYzYwZGt2YThLQkxucFBKK0FDZDhnNVdxN083cHh1?=
 =?utf-8?B?MTJYV29UU2x4SUdKLysvbVM5WlRPTXpJWWYrN0tPVlBIVkNPZ21vVElNbHVo?=
 =?utf-8?B?YnJuUWQzcStudDhQTlcwN3JtZ1c3Q3EyVE1kMzY3ZGRpby9PUHd3aDlaWEpW?=
 =?utf-8?B?ZGl3YnI5dms0WEpTYkg3L2Y4ZTJrdldFV05OTGV5c0pHdnBCUk5tWEUwbitE?=
 =?utf-8?B?U3dRbUQrZTJmZlM4ZStIcFhQay9haFRPM3JuU2l4ZjlGUDlMZm8vVXNtaFQy?=
 =?utf-8?B?MENwRG5EdzJzaEk2NDBXc0k0RllPUEliL252UHVGK3RZM0RHS3ZIbFJMbGFG?=
 =?utf-8?B?VzJmaDNsQklUYTR1VmVFTkV5MHVCVTBxK293c2Z1aHJnaHhWWkp3UmxmRkx5?=
 =?utf-8?B?UFVuVjdrTkowV2doSUNVekNrbzZkRjdRYkdPVmF6VW5wRTIrTTdrSlFxMC9K?=
 =?utf-8?B?TUlUQ2xpKzZDMHFHRGxXUzhzR0I3UDZvZWRCQTF5SzcrU2wyaGZ1cWIzQVli?=
 =?utf-8?Q?PN17D5X7zfs8iQttC2oka9V1NAxoOcb+RQjp4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8332bfce-9c9a-4203-0dea-08d91e5c673c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 02:34:06.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmvyQJieYgIERgqRLyg6WiOPFicR8wFVQkwn8G1Cz25e4kOmcJXty9OrbsJWTyCZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4096
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: D0U8UnsilL43EfBv1mR_YAVEjNNCoRZI
X-Proofpoint-GUID: D0U8UnsilL43EfBv1mR_YAVEjNNCoRZI
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_02:2021-05-20,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240017
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/23/21 7:24 PM, Shuyi Cheng wrote:
> Hello everyone,
> 
> I would like to ask a question. The question is: Why does bpf_probe_read 
> not use __builtin_preserve_access_index and also release relocation 
> information?
> 
> The following document is from: 
> https://github.com/libbpf/libbpf/blob/57375504c6c9766d23f178c40f71bf5e8df9363d/src/libbpf_internal.h#L414 
> 
> 
>   * Such relocation is emitted when using __builtin_preserve_access_index()
>   * Clang built-in, passing expression that captures field address, e.g.:
>   *
>   * bpf_probe_read(&dst, sizeof(dst),
>   *          __builtin_preserve_access_index(&src->a.b.c));
>   *
>   * In this case Clang will emit field relocation recording necessary 
> data to
>   * be able to find offset of embedded `a.b.c` field within `src` struct.
> 
> 
> This document clearly explains the function of 
> __builtin_preserve_access_index. However, I did a small test. The test 
> results show that only using bpf_probe_read and not using 
> __builtin_preserve_access_index will also be relocated.The specific test 
> content is as follows:
> 
> // The bpf program.
> SEC("kprobe/kfree_skb")
> int BPF_PROG(kprobe__kfree_skb,struct sk_buff *skb)
> {
>      unsigned char *data;
>      bpf_probe_read(&data,sizeof(data),&skb->data);
>      return 0;
> }
> 
> // The debug log.
> libbpf: CO-RE relocating [0] struct sk_buff: found target candidate 
> [3057] struct sk_buff in [vmlinux]
> libbpf: CO-RE relocating [0] struct sk_buff: found target candidate 
> [23925] struct sk_buff in [vmlinux]
> libbpf: prog 'kprobe__kfree_skb': relo #0: matching candidate #0 [3057] 
> struct sk_buff.data (0:77 @ offset 240)
> libbpf: prog 'kprobe__kfree_skb': relo #0: matching candidate #1 [23925] 
> struct sk_buff.data (0:77 @ offset 240)
> libbpf: prog 'kprobe__kfree_skb': relo #0: patched insn #0 (ALU/ALU64) 
> imm 240 -> 240

Did you include "vmlinux.h" in your program? The "vmlinux.h" contains

#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
#pragma clang attribute push (__attribute__((preserve_access_index)), 
apply_to = record)
#endif

which will put preserve_access_index to all record (struct/union) 
definitions. So the above "sk_buff" member access will be relocated
automatically by libbpf.

> 
> Thanks in advance for your help,
> Cheng
> 
> 
