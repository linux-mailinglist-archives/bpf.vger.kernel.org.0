Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04CB32C220
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391904AbhCCW6E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:58:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50878 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1388031AbhCCUad (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 15:30:33 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123KPOHE028492;
        Wed, 3 Mar 2021 12:29:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6tMD0XC2kuQueJwi2AKhG3MPMwo8jhJaY64OO4X1bmQ=;
 b=hRbQgU8ZqfbTaCQR9jwE1MTiszUPzM3qU+uYOwsQu72C3bIEpIrMQtD4lTLROscIRJFv
 wD82BUi96AyNiPKpXZxSvzoc1+frDbNXTlAoMoe0my0Na+dEV9MOExhc8JXg4oLtLFGd
 lt4K/yDeIBQOOPK/OAjq5DOLizzbYPUeSuA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 372107w0pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 12:29:38 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 12:29:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCiEtpYbjGKIDMmxXLsMINTuAxoDfiLDXo9f1cKxsULSj+m9L3ZUk435MHqz9VOQH9FOBDKeq15nezLNd6xPK6fsjK4kBCFOOa78JSeyVmLnLAbRHmxgWo3htBWb5rll7sXP4YehN/9TkEHHj1u62Rm3YPkYK2CGICzNzrFUu4usidHKXilQa8LvKdzoCRHyQYS+Y/q8lTP0JT+8yPeE7du0x+de3KFrXaR5hn1TlpPp8NyXSI/4O++lwGLtytEmf8AD2Tgd//YoFO3XeXsfWOZndutcjZcYxCeGlzGfqCU5dCQ8BYmfVAlQ31tWQ/bBHQIh96ezZC+V81OR8nYxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tMD0XC2kuQueJwi2AKhG3MPMwo8jhJaY64OO4X1bmQ=;
 b=m54NxBhtrMetdU5nB5XsuVKsSDh5yDLOg0u5gwMGTT1iRT6vRfjyDUGMq0phjQIbU3XoNB7JW14TjX+rWwUmwxnMQPoraGRqmypGaJdrDOeiMvrfsi7+a2PtQ/Q9hCPpys0YawckwGvMJ1Nd9SrqOcBQyC9X558izZSBaPGDqMGMGPQh/dtpDBc4zHP8w/2eil1vSf74sPQI1L1bJ+3Auuz5+/+LmuVtiMYL7BKOCjwVKEfzzJ4p90AW41+FA2q5Bq1imv7n3pWHkbdlLnHEdPc7FnE2bP8xgf/CuWYh48ivGGdSWcCuCVYozEFvm3+qGlaLnMUwhINk+WZeDvgwew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: isovalent.com; dkim=none (message not signed)
 header.d=none;isovalent.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2125.namprd15.prod.outlook.com (2603:10b6:805:8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Wed, 3 Mar
 2021 20:29:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 20:29:36 +0000
Subject: Re: [PATCHv2 bpf-next 06/15] bpf: Document BPF_PROG_TEST_RUN syscall
 command
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20210302171947.2268128-1-joe@cilium.io>
 <20210302171947.2268128-7-joe@cilium.io>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <79954d84-ad75-8f91-118c-0ce2150a1c96@fb.com>
Date:   Wed, 3 Mar 2021 12:29:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210302171947.2268128-7-joe@cilium.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:94d2]
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:94d2) by MW4PR03CA0226.namprd03.prod.outlook.com (2603:10b6:303:b9::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 20:29:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3db3290a-86a5-41fe-4964-08d8de830ffc
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2125:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2125F242C1714C6C52645E04D3989@SN6PR1501MB2125.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wP4utMaGr16P1Y7GUeQjPI5e7af3oVTsRdIbTi2QhjAe3oAey8cdnLEAKB9Al3Y3tlD2+7k9vTr+up825STYRZb/fierALheWC7TWKVG4Kr3/wf0kFGInZ2L5fyY0k02k4G6eozW6R0jAhTN1Pktsgp5HFwBcGCAW1/SsvBNO9HA+C8OoovuU5imqK8PKwV20cpPN1eEx806ScDDtF4lbwzkJVjqrl6Ej+IgZj/jf3lzBl1L2PtEAXVfF4wxvrAXwGa+gK8OJmy5x8R3rNXYS4GGtoiPd6fj1DfIUUskEupru5ge2CNio6CPZ8usqoZHSZWTTaSp1fo9xunvfNN8vsU0Q9+N7OrWfD1Piey10I0AvnUrwYRnJQgN88AqePfVvNPxxzua+YXX3udsHILfrflBkveQRK6/G8tYr300to+lXZfe1+31htrybpS+HXbmFNQ3JXimQ0WAswhPXym0hQ9yxpBbd9UMHtMB5ciqQ7LRc8UjJY3VbVSMlSaMaI/Cq8mSOHzXqu+IGesGdKiTq65mbqTK6uxXEIS07lYYAu5TT90+H6zXFqjQHkpsBrHIMV9g5Rj1W4bHCYc+jdbwGCmAHAuH4YMRdasmeWbSl3UjHGh9YNMj62MKg3H8u4c/WG09U1oMqxBq/hWAOPzMgXY48W9BeSMho5la6zNr4Xr+fJE0s4OJ2u8IOmN+41ap
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(376002)(366004)(31686004)(316002)(66476007)(8936002)(31696002)(66946007)(4326008)(53546011)(5660300002)(66556008)(8676002)(16526019)(186003)(966005)(54906003)(86362001)(36756003)(2616005)(478600001)(6486002)(52116002)(2906002)(66574015)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ai9lL0hVRWJZbmRPVVA4QjdDVjdtZ1k5VlBZVlpENmRnRGtzanFwQUJ3Z3Jj?=
 =?utf-8?B?Q3RNY2wzOWFGdFZISHRJRkJ0b2NtcGVUQVVLYmVZcUFJUnUyT3RpTXlMRFh5?=
 =?utf-8?B?U2VXa1A2NVpqZGFudnRrQWNsRHJZa3dTL21yeDFKVFhCekZQTW5hZmlZU3FD?=
 =?utf-8?B?bGszRm4rN0pCbjdJTXZBSXRuZ3pCUzVUZktESE04MFY3SE55OC9VTmlLS0t5?=
 =?utf-8?B?NFRlODlya1RESG1MVFl5WVc1WEYwTTNSQlN0VlUvOUp4Qktod1AzaTZIVlZM?=
 =?utf-8?B?ZnNJbmJwUlIzamZGM1hSQTN5MlpFaGhHNXlKOXRxNVU2SHBrYm5jYjJwVktU?=
 =?utf-8?B?UDYvdS9xa3hsQm5Pa2szMm80SEVRSndndGVlTURHbE1DS0NpVXlRN2JHN29r?=
 =?utf-8?B?Ny83OGROVUJIQWpOZjFQSDlHN2krYVpPMTlUcWlReFJVL1hUenp6YU9PdjZr?=
 =?utf-8?B?SWo3a2haRE9sZU45NTVaWEtWQ1EvZXNEUmhEcUN1bGdaVlpzdldHRVdMZWNy?=
 =?utf-8?B?ODdUY1VBeiswcCtQQXFPWEx2WjBuTGxFVWhGYUhsbDJZbVJUd3Fkb2Q0TlIr?=
 =?utf-8?B?VnRUOFViZmJFOFhuNVA2dUU0b1ZtR0NEYmUzRDlyb1hQSTdJMWg2NzZhc2Zj?=
 =?utf-8?B?c0gwVk8rQ3YxOVphRDJ2YUFpTHkvSGxYWG5LVTc0K2ZaaE9XMDUyd2NEMWlt?=
 =?utf-8?B?M1RzbloxNmxrekpBYlFYNWxpdytFWkxXelYvUGV5QVFPYnJ5bnhJWHEwcUlN?=
 =?utf-8?B?UzR6Z3Q0dzc0V3FCN3BYUjhydkNQSkVCV0wxd2lwYnBGNHNzUTlyUjhINUEv?=
 =?utf-8?B?eHhKbWxaMmloZVpHdmlSRlcycUtPYjhSNEovTFBRTi9ERytwNG9uWmFPbFdy?=
 =?utf-8?B?SE53cmdhS2tDc0tsZ09GdHFVV1pnRkxFMlVHVml2S0F3NVI5Y05FdFpxdnNP?=
 =?utf-8?B?K1h3OHpBZ0ZlZzlncU1ySTd1eGJVd1BtWmVBMWgra3RldG9xcW1iYnJLZ1Rx?=
 =?utf-8?B?VWpzcmYwUXYzS2FOaFZOd1YvcklNbU9LN2EvTm8vSElFaGtZTk02amVKVWN4?=
 =?utf-8?B?ZHEzNmlwS2I3a0xHazR1TXM5K0lmQ1cvYUVEQ014aDBCbkNtNGxpTUZFOGhw?=
 =?utf-8?B?UEVzWDlBWTVlRXpLNGJTTCtrU1h6RWhvMWZsT2xIUlAyODQ1R3NTZ20wOWRY?=
 =?utf-8?B?U2tXQVNyYUZpV2htZGJlTkl4Wmh3L0VFK0diOGNkRFA2czg1WjQ1SEhjYVZM?=
 =?utf-8?B?blpWUFEzbUV0cmZGWXQzbTVFaFNlVjF2a2V6Z3VrS3R5ZGVLTCtWN042V2la?=
 =?utf-8?B?NnJHRGdiVTVrd1dYZFBSWjVDaUxEWjUrWGx1cTZTRGJFQXFKVTVGZjl1N1VR?=
 =?utf-8?B?bldkbkZSaXVkWW5KOHlXYlJCOHFLUFNpbVgyY3BuTW5aNUdpYm5SUldYQlhD?=
 =?utf-8?B?MEpTUFB0KzhxenJtQWV6VnBISFZjSUtiNFpFUG9TK0hCaW9MZStldWx5M2dW?=
 =?utf-8?B?Y1hiUFQ5VFE0Qm5Sa2FrZWMrUUJ2aG1qL0NVZ21hTlhqNFl3cmtwR2J4MkxI?=
 =?utf-8?B?WHpsZDJCQzlub3QxWE16cllQUzg2aXBISk52Rkd1djdJaFEzTmo4a3d6MzZm?=
 =?utf-8?B?L0lvTUZLMmNKd3Fycks3UzdoS0hwZTMxV2ZCK29CdDVZSXRtUTVpTDdDeVhO?=
 =?utf-8?B?cWMxTXFYa3lGbG1mVVR0VzhkRHd5RVVnZndTaURkOVphbEE3aW9tSTRYNUJ3?=
 =?utf-8?B?R0NSUmQvdk0xcEFONm1JWlN1WU53eTdoeUx1TExhK0hmTFNTMUZQdkRsTGNP?=
 =?utf-8?Q?21/vDe+GgIl0qT3nGuRPQgUKGMdgI3dQKz5mI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db3290a-86a5-41fe-4964-08d8de830ffc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 20:29:36.4348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dx4ltXDE+5tpE4Rawtp6r+KHXEzTS9vWschksj+KXDIASFiBCcV6LcXQ57Mf1LHf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2125
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_06:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=764 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/21 9:19 AM, Joe Stringer wrote:
> Based on a brief read of the corresponding source code.
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   include/uapi/linux/bpf.h | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a8f2964ec885..a6cd6650e23d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -306,14 +306,22 @@ union bpf_iter_link_info {
>    *
>    * BPF_PROG_TEST_RUN
>    *	Description
> - *		Run an eBPF program a number of times against a provided
> - *		program context and return the modified program context and
> - *		duration of the test run.
> + *		Run the eBPF program associated with the *prog_fd* a *repeat*
> + *		number of times against a provided program context *ctx_in* and
> + *		data *data_in*, and return the modified program context
> + *		*ctx_out*, *data_out* (for example, packet data), result of the
> + *		execution *retval*, and *duration* of the test run.

FYI, Lorenz's BPF_PROG_TEST_RUN support for sk_lookup program
requires data_in and data_out to be NULL. Not sure whether it is 
worthwhile to specially mention here or not. The patch has not
been merged but close.

https://lore.kernel.org/bpf/20210301101859.46045-1-lmb@cloudflare.com/

>    *
>    *	Return
>    *		Returns zero on success. On error, -1 is returned and *errno*
>    *		is set appropriately.
>    *
> + *		**ENOSPC**
> + *			Either *data_size_out* or *ctx_size_out* is too small.
> + *		**ENOTSUPP**
> + *			This command is not supported by the program type of
> + *			the program referred to by *prog_fd*.
> + *
>    * BPF_PROG_GET_NEXT_ID
>    *	Description
>    *		Fetch the next eBPF program currently loaded into the kernel.
> 
