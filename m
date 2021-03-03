Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDF832C1F9
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449764AbhCCWxu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:53:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57340 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377035AbhCCTpg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 14:45:36 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123JidIb008947;
        Wed, 3 Mar 2021 11:44:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qCSX4XhuPcfpNYEHu/mhmMBXksSywEag1gtf830PQAg=;
 b=BWxxECZ+sPbjv4gY6D+5B7wS7+1jUE0lsgoZzI6qrlzbiuTWM2iXJqGR0bFlkV3pkyXL
 rfZoKkAFYjCTDVSpPFi1JEusUFHB3wqxIRxq0qb7sNYZZI+e0gIRtIGbC2glk7rLYAfM
 KfpTDFI5B2r1LjZelkIcX7a4zhRO57Z4f9Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3727guk8du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 11:44:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 11:44:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKX83u8omU1xqeuSB1Ro1XtTIZSutXs88XHQoxpeAm21oUt79KGTJLsSYoszQvL7cCDjq9fq5VF3TTb+7rSTVAP32KUBXqxmihg8699/nIxqLw3cU73I9Dkco1T6yu3ahl6KhOl9YZk7k+l2Rb7AZw7/aT1t93RhEJkqnlkrMSp3bEl/u8DBRbhZPz5DpeTIDYd0eHnXzXWs+9Wa/fA9HVBoPQzzrCVjIQqshgUev9FF+mwOrTy5nIT7ZPziat+O6K8/s7ibMZb0QXV45W/RTiq0RD942Gktf76bJu3cBxezO6+PMl1zHCbNfpHYBSj1BXQNe3SK9DJ/humNibVCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCSX4XhuPcfpNYEHu/mhmMBXksSywEag1gtf830PQAg=;
 b=NRdlYWmaGOy4h8eNISaURCQ/pUIFCj2GCA1dZbCKwpUE+PgfBR+W99vOVX5rGVo1SJdeSliEyNgNO4OR2NknfX2gocQ/QTyj6b5K9GulHXYdLWQ6kIt32Q3Lu2rtYC+uCMwn8FznGpMKSfN5wZfn8u8nQ+t/eZtSjE2RUnc4joR8jPB2nLRwnDpYRj2rWBxl2f03i3K4dhEeRS0PpzWlIlsZH/jcjyTRIK6qu6PYIOGxcSwvpSNAosHWGTUk25tADwy1i5mjiOoKcE4BsULgf93U+wO4mhxAOQ4tZ4wXjsoeSPprZs0C4YDas4QOruNWNCPPtslVtuP8Fb7diK7dmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: isovalent.com; dkim=none (message not signed)
 header.d=none;isovalent.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2285.namprd15.prod.outlook.com (2603:10b6:805:19::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 3 Mar
 2021 19:44:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 19:44:34 +0000
Subject: Re: [PATCHv2 bpf-next 02/15] bpf: Add minimal bpf() command
 documentation
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20210302171947.2268128-1-joe@cilium.io>
 <20210302171947.2268128-3-joe@cilium.io>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7e1eab1c-e063-124d-fd15-6b7b714e9218@fb.com>
Date:   Wed, 3 Mar 2021 11:44:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210302171947.2268128-3-joe@cilium.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:94d2]
X-ClientProxiedBy: CO2PR04CA0079.namprd04.prod.outlook.com
 (2603:10b6:102:1::47) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:94d2) by CO2PR04CA0079.namprd04.prod.outlook.com (2603:10b6:102:1::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 19:44:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8a3546b-e6bc-48e9-619d-08d8de7cc55d
X-MS-TrafficTypeDiagnostic: SN6PR15MB2285:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2285879087AB705F80576100D3989@SN6PR15MB2285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdN9yyOwgIp01mlJNQsc7F/lRvn7G/mGCKj/yTWN+4OxMHxlznthPdgSVKqi3Gd2OX/tSkL9mrazycX3edzgbH3CbpuBdjsh3r/crsFrqpUIo9dwpCBZHbWNBoMT4mruut/TkOMl7Behibhr+tI6uIC/zVd8Su3mMi1ZBIJsyZ+UJ713tHX4Ycgo5d2xsBMY3M/KrfA0QY9sq66eJnrxf21AMseVSdg31rcbNk7dCPez7tNM4bf7nZPAzJxoeDmBtzKyf/L3Ogvoe75+ZKGJi0+XJpMmYQ/N2AZGGF63e/RGQFidhp1PS8ivcKn0K0Oy63+N1Zz9wl/cQ7QqjWGDHmW2YGHV++zgQdafLvXdXUQO0CT77Jz7SCib984LBtHQKpFgIOOAIzgLqBftGIXJ6gUqkYZ7IWAjCtXQ1ybdW+TBg/Ds0MIKMeiRMx+cc4sej0Oky75Rv6E1raoSG2x/dmYUCt5OkrB5KQBYq9UoMW+g5b1L47KTvM9HMhVrKSNNqL4COTlaR9wYH8RFiIuzVmrps4/4QlqLKd/YvEEtW3PYtKLkaSQbPAq7CwsPFtpn7rL0FgHqadcvmxe8wMg7FKQme7+eJAPAKz4XeaO552s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(366004)(346002)(396003)(54906003)(2906002)(66556008)(31686004)(66476007)(478600001)(8936002)(186003)(31696002)(4326008)(6486002)(52116002)(83380400001)(5660300002)(66574015)(53546011)(66946007)(16526019)(36756003)(8676002)(316002)(86362001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TVAxL1VPNWhGbGEzSndjdjk1TGgwb2NtUnYxNEJqNDlkNXN4NXVkL3NNOFdv?=
 =?utf-8?B?M3lTbFFGeml6cDdXcWlxa1FVT2hjeUNubFFKcm9wSHZicndzeXJBcFIrb3ha?=
 =?utf-8?B?TGNMaWdpNG54ei8zOWNKMjZqZ2MwRkVGeTlSUkRoMEVqS2Q0Y2QwTG54YkNJ?=
 =?utf-8?B?RXVLbFJnREpaelhYU1J3YUREdnlBL0toTkpKMGJobDdmRlZ4cHpRTmFKaXBa?=
 =?utf-8?B?OGdSMHFZLzlkMTBaMlBrbmRERkhMWFJJUmhnVFpmY2xIL1g2RW5sSlFKcGZ6?=
 =?utf-8?B?SlArWVAzZGJINjdmZkVUUzIySjdLcjBmdXUvTys1MmFvTEZqQmYvSlVjSStU?=
 =?utf-8?B?M1NUVTdSK0lEOVpmMHhCTi8vTzFsRHJzSzZRZFgybTl0NjUzSEVaQmFyQkZi?=
 =?utf-8?B?TUNObTU1c3lNTncvM1Y2a0ZTbDhIZTlmYkFVK0ZJZldYRStlRXhNZnM2UytS?=
 =?utf-8?B?bnhjL21JRGx6R2RyM1JWWXljVUZrQTdKdkNLcmdSTytkcWtLRXhoOFQzdmFu?=
 =?utf-8?B?QjNoVHkzN085aVpVaXVOcmlpbTZ5SnJQdHhLbGFKTndQeXQzcFRCRisvd3BF?=
 =?utf-8?B?UDBpUDlKYmxhOHNUU0xNcXFFdzZWU2xPRXpGTTZseTUrdWxnWFdRL0o1dS9H?=
 =?utf-8?B?dk53Z282ejFUL1J5d3o0UTlPcnBZdTM1SjVnOTZPQURDa0ZVZWx4ZGFPS0Nu?=
 =?utf-8?B?V3NLUlRleG1JZFJUZEx2NXVNaXRTdDlET2Z3K1prZy82a3lJclJ0U3EvUGN2?=
 =?utf-8?B?cVkzVUh4VG00Y21BaTQwbDB1RllMd2hxK053dWltQjhXU3dkS25pVkNkaUZ3?=
 =?utf-8?B?TTQySnd3NGJKN2p4RXNNdzg1dG1Nb3JNa0Q5cHZnTUFoRHpaYkE1VkRURDJE?=
 =?utf-8?B?R2FpWEROQmlUdDZzVW5XZVl5RTBCNFFEQUg1amxjMDZFZDJmWlJLUWZ4OHo2?=
 =?utf-8?B?MHNlOFMxejU1WEVFa0hKblRCUjBuRkhkczcxb1VCS0ttRUtycWJac3p2MDd0?=
 =?utf-8?B?cjlTa2VJN1Nsam8wcUFzNEV0STJZZjJIUy91UVVFUTFwM243VVNOZForR1dJ?=
 =?utf-8?B?UXdzSlBiNWtiaTlBZTQvaXgwcWtGS1JvczNvK2tIVUc4S01rWURXSlVESnV4?=
 =?utf-8?B?Q0Z5Rlg0QTJUc25KRVhDbnA4UDNlZ2N1emVOdmUwZjFYMWFKa1pFVDdVZ2tK?=
 =?utf-8?B?RFVhaFN5RFZ2K0JlZE1iOVNISEovZTNCUVprc1EvYWJ4dnZFTkhqWDZNS1VN?=
 =?utf-8?B?MUE4YmJtRGprMXZEYU0wMm50dmRuVk1XY1Y1MDVOVlllMit6K2xHdU5tRVAx?=
 =?utf-8?B?cXRRZ0JadWQ1RUpNNkZ2NjhxendLdkQyWW1PRElZVXEyZ1lSb0hPeUZXVG4w?=
 =?utf-8?B?UzMwZ2FldjI5dU1WUVZUcEJ0aWRlYTZsWDhCa0ZxSWJ0emVwRlBhdm5OaWtX?=
 =?utf-8?B?OS82T1hPU1JDTzJlV2xDSWg2SGlzczc3Y3QzVUkxSzBDRjlyclBVcXJ0NmlT?=
 =?utf-8?B?SjZMc0VLR2RGbjM5MGk3cTVMazRLTkE5TlgvV0pwUWVOWUxsanN1aHNrc25E?=
 =?utf-8?B?UEZvQWtKZE85MjloRHpFQUUyVUZYYXkrZEkzWTF2M2I4bEdCTU9oamxCS3BQ?=
 =?utf-8?B?QTZlU0hRTnRBQ0xoeFNFK0U2TTZSR0VicFFYSHdneEdCbThOcjB3NTdDbzE3?=
 =?utf-8?B?akw1MC91S2NZeHBzRDVBYmxBbGowN1Z4dGtSQXVNdDZ5d3NNT1FYRFJOa1ZO?=
 =?utf-8?B?RVR5ZkVOeEZaSSt6TjJ0ai9oRjhUMVR5eGV6SFErblZvT2ptMkYyU21KKyti?=
 =?utf-8?Q?+1ONp42+F0oDM0ijTuIRFLBfRzO3xLf6hhpWU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a3546b-e6bc-48e9-619d-08d8de7cc55d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 19:44:34.2646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nL7E6H+73a92NsqJkYlrrlXUVSgWOG32qNBOP1ckchT62Er4phpSP4pc9QHsvZQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2285
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_06:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/21 9:19 AM, Joe Stringer wrote:
> Introduce high-level descriptions of the intent and return codes of the
> bpf() syscall commands. Subsequent patches may further flesh out the
> content to provide a more useful programming reference.
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>

With a nit to update NOTES section,
Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   include/uapi/linux/bpf.h | 368 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 368 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fb16c590e6d9..052bbfe65f77 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -204,6 +204,374 @@ union bpf_iter_link_info {
>    *		A new file descriptor (a nonnegative integer), or -1 if an
>    *		error occurred (in which case, *errno* is set appropriately).
>    *
> + * BPF_OBJ_PIN
> + *	Description
> + *		Pin an eBPF program or map referred by the specified *bpf_fd*
> + *		to the provided *pathname* on the filesystem.
> + *
> + *	Return
> + *		Returns zero on success. On error, -1 is returned and *errno*
> + *		is set appropriately.
> + *
> + * BPF_OBJ_GET
> + *	Description
> + *		Open a file descriptor for the eBPF object pinned to the
> + *		specified *pathname*.
> + *
> + *	Return
> + *		A new file descriptor (a nonnegative integer), or -1 if an
> + *		error occurred (in which case, *errno* is set appropriately).
> + *
[...]
> + * BPF_PROG_BIND_MAP
> + *	Description
> + *		Bind a map to the lifetime of an eBPF program.
> + *
> + *		The map identified by *map_fd* is bound to the program
> + *		identified by *prog_fd* and only released when *prog_fd* is
> + *		released. This may be used in cases where metadata should be
> + *		associated with a program which otherwise does not contain any
> + *		references to the map (for example, embedded in the eBPF
> + *		program instructions).
> + *
> + *	Return
> + *		Returns zero on success. On error, -1 is returned and *errno*
> + *		is set appropriately.
> + *
>    * NOTES
>    *	eBPF objects (maps and programs) can be shared between processes.
>    *	For example, after **fork**\ (2), the child inherits file descriptors
> 
