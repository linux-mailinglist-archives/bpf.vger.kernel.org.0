Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBB3326772
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 20:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhBZT3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 14:29:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9320 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230163AbhBZT3u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 14:29:50 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QJNml9010683;
        Fri, 26 Feb 2021 11:27:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WzVBJtPVXOtjJe/Yru4/tYGSfCmj2n90ktfJ1jOVxi4=;
 b=YOfIBFtaiBgC24j2znx9wjJSvY3w/wM0VsaZqibrIs6Q/cjePs+frUcOSLSzDzPeLywt
 VpTE6/x5F7NbXrdGzjg4POmFDD6ef5zuRhu6W9D8vExR5bVjQb7Z/TmqtxBPMmSy5c4+
 ZlyYgiND4IPQ9yTcqY0kJhh5riM2nak9VO4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36x96c1m8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Feb 2021 11:27:57 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 11:27:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYZuIBLpF46hAnNNXrH8y5Gxz455Yv0q1wmWgN2ggjKLaGE8pghEZwezel9rtP92HmnMlj8VhKDHzrhKoBoiAwuQ/ssogP9XJ2PtKWIK1n1HpAhsiYTUPMaZfQ44JeqZo5J+quMe6qrJo6iRSnXx4XinMour+luZZIbbycbgOwZ/mzHhITxUwkNAKqC44jgIi9JSkiRCDf/LA1VmxJJK6LIANZDV1rErlLFlZyJkwTiyJDeEmGpTubSh0chX9zszsKipuy0j1kPncURyy+Rb65FShSNV+j2xrVflAfn71WUvHblMwyxdqxWRfDkwvPswmvik0Q2rJ1NDMyVEbG7MfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzVBJtPVXOtjJe/Yru4/tYGSfCmj2n90ktfJ1jOVxi4=;
 b=FGuxmj8+RVl7+qIUv7npLi6kT+rbvJJxB5pyy/s1XpY6cHppVczEk3WN2UOOWtw+rQ17RsNU/S/CdZs0aod/5xgvlTU68SWdiZ4+z9pGst2OiOalWECi/wh+W2b5nFS69IjyKgN9z7CaooBwbxecOF4u1112C2e+mUIZp8GA7KQ4jN3psdl3hg/3DiT1VVMk/5CnltNUNkJfDWybjAcv5WDqiQwuSxNDxdJH66jtbwwZs6WP8fYW9HNmc8bTRDS1633X5zMZL2+4gl7Xjry0hpVQlDUAN3+/e9wLSVuK93qFHHiw64efhHCvVGg0SIdieB3n7t+IAwvjDUAKeHniAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN7PR15MB2291.namprd15.prod.outlook.com (2603:10b6:406:8c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 19:27:53 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd%6]) with mapi id 15.20.3763.019; Fri, 26 Feb 2021
 19:27:53 +0000
Subject: Re: [PATCH bpf-next v4 05/12] bpf: add bpf_for_each_map_elem() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210226051305.3428235-1-yhs@fb.com>
 <20210226051310.3428705-1-yhs@fb.com>
 <CAEf4Bza-EJ=AB0eMQLGomdmQNnN_PccaeoMk9HBmWaGfkh7enA@mail.gmail.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <964673c2-0bd4-02db-51a1-dc495a1b2d9b@fb.com>
Date:   Fri, 26 Feb 2021 11:27:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4Bza-EJ=AB0eMQLGomdmQNnN_PccaeoMk9HBmWaGfkh7enA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f3bf]
X-ClientProxiedBy: MWHPR22CA0040.namprd22.prod.outlook.com
 (2603:10b6:300:69::26) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:f3bf) by MWHPR22CA0040.namprd22.prod.outlook.com (2603:10b6:300:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Fri, 26 Feb 2021 19:27:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbe39549-360f-4ee4-cd94-08d8da8c9c80
X-MS-TrafficTypeDiagnostic: BN7PR15MB2291:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR15MB22918E64F1A342A381136846D79D9@BN7PR15MB2291.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqnpV1QsJvPVlp+h22JTJWGn4HVRwcQrFiYrIcPWYcEorIEMjODr9AttgZ3bWN2tJZBIku6xljeHYq1td3Ozr5rI9WbaRIL1ifZ7CW+wHFV6VqymLc32qqX65/7jtRtGJP8oi79OE7dgSBETL75cjG0SvNWNGseq41lyWXRWOgzWHhd4YD8FZfxlGysBDRX23ZcQKaD6YJm4tnEgexNxS229jGLZ5g/thhYSLT3Yn9SW/HUWJsmQR7qyJv0xsLojCZAQ1HSx0/eZC0sBo6YmP1nscVzGWwirxEfpHkbCDN/i60Sc05NBQ2q6m2meoQpwqP6YZOfTPVxj3EWZ+Ddw3kxdjLuIg4D1ceejLRNL4MVPL2TFMARsWqw057NMSl1exyjeGSEevoqYYKGn9Vi4GyueCqdviK5nPXzZMEZA7fJdJl9G6JD1/50iMj7UE1PjJSPPkiM5ehx472QewN2DTeEcX6L3Gtzl1bwUjigxCtj8iCn6c+r6dT5TttDdkSnEn/e0D7wLeXwSY5RDl73H2PaQvpAdWk4LJrCRKQo8FxCPu8cqic3Mn9I/t8KDT0pmFND4iBzavHrcrGUNaSPtbs1By2BUdopyVvQUTk+wM84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(366004)(376002)(136003)(16526019)(8936002)(31686004)(316002)(86362001)(31696002)(478600001)(2906002)(186003)(8676002)(110136005)(53546011)(52116002)(2616005)(5660300002)(4326008)(66476007)(6486002)(66556008)(66946007)(36756003)(54906003)(4744005)(6636002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d3N4aCtLRzJBRWt2S2UzdjBMR05TaDFqNmpzWWx6Snh1NlNBSHc2ajZrNUMv?=
 =?utf-8?B?ZnV3VVUwSTRYNWZMTXNDeVhhUDJGS21lejJuMDAxaFlicFB1WTUyQTdJSm8v?=
 =?utf-8?B?RWVXQlhQVU0xakM2THFTRWw4a01PUmo2aEN0a3ZuUldqbWFzSEJlaWVmYjUx?=
 =?utf-8?B?YnF1QmtMY1hTVHdBSmFlOFg3cUN6S05HcUk0MENhajZqMDRmVVhvcC9MWkVx?=
 =?utf-8?B?dzFUazJ3Nkw0RlBSUUY0QktML096VVM0aEVpYXRqN1dFU1VUR3R2aWxKRzEw?=
 =?utf-8?B?dkp3V0J3ZDgzTS9aSm43T0dmSmcwbFNxR280NXpnMEFWWG9vbDVXNHpzWVhN?=
 =?utf-8?B?VEx1UUN2ZHZlcVVMdXlUelJjc3F4eUdtZ0pVWHVvVys4L3AzZWxuR05lejZM?=
 =?utf-8?B?b1luSG1vaDNiS0NOaFFRcW04NlNhNm5XWUVTYTZsNUdpbVB6cTlCMTIrSGlx?=
 =?utf-8?B?dThEMmZRM3RiNVVNM0xkTzdtM3FDSk1SK2UwUDU0K3VXT3h6Yk5HQm03Szgv?=
 =?utf-8?B?eE1iZ3FTWWR5SE14c3plYjVkck9FamhHSTJqTkpLK1Q0UWx1MElyNU5QMkx6?=
 =?utf-8?B?U3Fpd2RlNnVpNXgyZVlBMnUvYml0Um5OVkFvVStNeDYzaWZaZEtDbUZEcE5a?=
 =?utf-8?B?MW9CdVFSeVp6Uld0Z1cwa1ZZRDRzYUpKV0hvWGlJSVpCbkRmbFJpYXp6RGlX?=
 =?utf-8?B?eWNCVkw2SW40NUtTMmVycVVnRUJYT3cwNDdTb3JoUmE0K09HOHc3a2JPQStp?=
 =?utf-8?B?cDhzdkxjY0oxNmUxeDBJTjBaVGNaYmVLK1llM28wUS85blREK202UTMvM1RI?=
 =?utf-8?B?NHNrMnNvMTlBaVdwMzRPenI2N0dpSEVURTVQM21jNEVhZGZjNUFoL2tsSWZ2?=
 =?utf-8?B?QmtpbjJibzZDZDBMZVhVNnhnOVg1WWtDU3VOQmorQ0dnOHl0ZndIM1Z3aWt3?=
 =?utf-8?B?MDA0UUx2UE5kWDRmRUJuKzNmTWZWcG5DWU1aYzdxZnR4Q21TakxaNHVuUENx?=
 =?utf-8?B?cFdjeTVuVWlFZkpKdCtMTjlFandzVkVvUHc4RHA1T2xBcytQSU1Pa3NrOTln?=
 =?utf-8?B?aEVqQjFnVFhCNjJZRy8zdVFIaFdyWHZvdi8wZlJrUGNuRUVldzRaYXNEa0ly?=
 =?utf-8?B?UjVSdjgxZkIyUnI1dGtCSmNvWC9DeXRzU0RqTFR5dFFhN3F6d2VOMjJPMXdY?=
 =?utf-8?B?WmNpMHdNV2pJTVlTUUdrdTNySDFMbEdrMW1xTmFDUmZpNWx6M0dOVE9KSzUr?=
 =?utf-8?B?aWlhZUxUbXpvQ3I2WU1mRVlJQW1JOHlIdG5UK21BQWIzSERjMWdRSTZFYVQ5?=
 =?utf-8?B?czJJdjU0czB5NjVITDFnSGhXN1NCT0RnN2ZoVm1KU3VzODBGWkFBZlM1czc1?=
 =?utf-8?B?S2Q1RXE3NGpMYWQ2Wm9aYTFRMXpqdDgyS2ZDRXZyT3I5UE52V2xSTHduK043?=
 =?utf-8?B?M0g4OEd4VThVakZqM3NQK0xhUlkwSHd1Z0ZZZkZrdWJXWmp5WXVDWHlIWWo5?=
 =?utf-8?B?WjlkbUtpNHhpc3k4M0MrWUVKb1UvQ1llWTdnZWFnbUlPU1kxbC9BZThZV0Zh?=
 =?utf-8?B?QUtYRnNLelJVRGg1SkhGL2E4ZytCZENnR3FGVm5LU09McHVhRFlUVWk4OFkv?=
 =?utf-8?B?UThXMHppY3M4VHBTYjVDUVoxNERXNTllcTRpMEwydjV1d3MvNzc1Y1JwSXhP?=
 =?utf-8?B?b0VnQ2tmTDlnRjZaQXA1SXdqbS9jQTc1YWx4U2RCWks2MU5peXdMaG9qM1ly?=
 =?utf-8?B?UUpNdU1JTFY3alVHK21xVGxZOVIyczFOTmsycWl4T3g3U0lDS2JRVlJVcHFy?=
 =?utf-8?B?TXNoVkE5ZWd6a3c0SmoyUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe39549-360f-4ee4-cd94-08d8da8c9c80
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 19:27:53.0747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+ptvfttozE7vYJgd1rUUhv5ioMBuly4KO6yUUmdvwSbNDoj/jAmFgFJQdH+BRbH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2291
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_07:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=794 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102260142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/26/21 11:22 AM, Andrii Nakryiko wrote:
>>    * long bpf_check_mtu(void *ctx, u32 ifindex, u32 *mtu_len, s32 len_diff, u64 flags)
>>    *     Description
>> -
> BTW, this was fixed in a7c9c25a99bb ("bpf: Remove blank line in bpf
> helper description comment") and applied to the bpf tree. Not sure if
> it will cause a merge conflict later. Maybe Alexei or Daniel can just
> add this line back while applying?
> 

yeah. we'll cherry pick into bpf-next. It will get rebased anyway.
