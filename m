Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B1F3276DC
	for <lists+bpf@lfdr.de>; Mon,  1 Mar 2021 06:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhCAFTg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Mar 2021 00:19:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11702 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233439AbhCAFTe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Mar 2021 00:19:34 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1215Euas028267;
        Sun, 28 Feb 2021 21:18:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=U2fvm6+wC9AEhjMdn2wx50ImcEK2VEiJI27l81uQCW0=;
 b=WZGodUBP08g/dFeCXVvmFXTzegfjj2vWDyYeTN31UAnjSlXbF7q6jhxmwN6HQ/Vk02Sj
 UReF2AJNCPPrWUIKy0ZDEj0gqedETQqo1rRW/LsIUS7NfLiphW4NnzPsq4WYlXenmLrz
 bd2Nt6+BYiGhwdqrEtckakSWLO9+aoO+jNY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 36yjf5x7mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 28 Feb 2021 21:18:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 28 Feb 2021 21:18:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zc+c/BfoA8lnnxBNNrmCWJDDd6purAkGLe6EPZIePBg0TH/i6DgexUBZyW7gkGir61BlBgYwlrPD9BMYSnQO5lv8dC4r/Gi917yQeILZjwmL60VGWq2O7tsWxFNZC5gNw/bj3Nazuy3XfhxLATtFXjvq6EZrc3bV5aguzOPRKBHeAA8w4w8zY7/oAI5zzaWaVLyIl7ZN+YFpOU/9/qenRZNXo1WPcig8JBsbNrBTPJTUeWol69dt9WpYaw+XofgV81OTxINCTLZZPdx/QReak0571xAOzpJaChgJE3/yvZNGkOKgR2pmnvRvnLRRYaIv+t/XBc+gWC9B8utlxl5iVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2fvm6+wC9AEhjMdn2wx50ImcEK2VEiJI27l81uQCW0=;
 b=H8m2XGKNwhoP7DPguPQC9sT0EWJF+ym+zpmnrnXWM2hHWNpZhKUxOxycQL33Ga8rp4yulZKUmgx3EEG3+xaOeURfUjZuz2IP/sK7l6DUqIDtb1uawP7PCRufPruJt1VFI/FjLO0kJnYmzGxYNQQA/oblf8C3dxSwhDArfd1vsFFYM+s7dnhQLuq83X5v0rlVae3WDaoAMKOp8/NQKJBGWemd3RWnYVWMxPVYhKVW6mIOtJaC9jMquTy0lUaxQuTn0lyXcapT525PyxONFnsME6NWqpJ6YlCPtduBwxi8E33DGzSeEtl4oX4aZyuwyHfCU2GbtJESOnM/oGZj0dT2+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3933.namprd15.prod.outlook.com (2603:10b6:806:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 05:18:37 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 05:18:37 +0000
Subject: Re: [PATCH] bpf: selftests: test_verifier: mask bpf_csum_diff()
 return value to 16 bits
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <toke@redhat.com>
References: <20210228103017.320240-1-yauheni.kaliuta@redhat.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <acf00517-6129-869b-cd2a-03715de5fc61@fb.com>
Date:   Sun, 28 Feb 2021 21:18:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210228103017.320240-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:34a0]
X-ClientProxiedBy: MWHPR17CA0074.namprd17.prod.outlook.com
 (2603:10b6:300:c2::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1008] (2620:10d:c090:400::5:34a0) by MWHPR17CA0074.namprd17.prod.outlook.com (2603:10b6:300:c2::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 05:18:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6647700e-7a97-49ba-c7df-08d8dc7177f4
X-MS-TrafficTypeDiagnostic: SA0PR15MB3933:
X-Microsoft-Antispam-PRVS: <SA0PR15MB3933AE72BD3AE12E77F63B43D39A9@SA0PR15MB3933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/zUuwmmOjWnHa2vIuEXI2znqt2yyFh+dKM/cq/5hl0dJf0wxMhE1z0GZoMC5PiOZ5bDjM3inBtAbCdrKcxu6CzdHbo/kPl+lzeBlZtAyQaVxe1QxRY/y6sZAOCQtOv0Fl2iqZXgyOgyb7mQU6mir0aIPsrg5AUiSFO0owFOLg4w2U0OcCFUkxmya3r5hap/V7lSI0oD91Tv5UmOC774SwGmOQfmJ3jFHplyRksqi+aEk47IePD5ZyabqcFKsicWbADSN6HUNYLjEWpEfNAnks5EdlOc/f6RygKb/hQlnDI21xgzSJPSv4c6sTUfc8RkEiLTLHFnWwfziwOu6S8wDX9uxdLuc3RWvCS2LyR533kCIkcybDjYDAslRYVXyPcA0Hds+f8d6NWkcteLww3CmV4vncWwexoIptAMdBxk1685pov5ZbYYdkzdZHeb3K81s4cuvWypDetTktL2bPsoXCUVouuNKkHbhf4zpm7br6c15XbuIjV4rD0l6wTwcfne/0gmQtWEG945P+5TfhMgYX6/QsYnUxzL2eff2L63ORatrGfkjMvPRK/08TK4IZrOMAwFofGMJCzeT3q/ZB+zkiEi27v7hjPBIYx6Wof0l98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(396003)(136003)(16526019)(86362001)(2616005)(53546011)(186003)(478600001)(6486002)(4326008)(31696002)(31686004)(36756003)(83380400001)(5660300002)(8936002)(2906002)(8676002)(316002)(66476007)(66556008)(52116002)(66946007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UlFsZnlvMUp0OE5IZjNMUnp4NURncVUvSXVPaFRZTVh6TFBPaUdXeW1BTDR1?=
 =?utf-8?B?SjRxTkFyb2hybTlxVGNjNlpmR1dMOGFqQkZVa3NJaFJud0dPdXJVZEV5ME1E?=
 =?utf-8?B?M0ZOMmc0Y1JQUHhGSWlicUx4Rmpub3BwVFJCL1VMTEVLWm5yc1NPT1dZcnhy?=
 =?utf-8?B?SmJRdEFSaVgySUI4TXZJTW1pUXBQajJMLzN0WitqbElkZXBWOFQxVS9ZUzJD?=
 =?utf-8?B?OUdhR2wyNkZoSUxBNEdQWnQ1UU5XSCtUSVVOYndjeVpLZk1SSDM5b3ZUcnpK?=
 =?utf-8?B?eVM4azZNaXd2Rm56WjVEdlp5QlRDTEgzWmhLanJoakxDaTdXZFhjN0ZxeStt?=
 =?utf-8?B?R21LOTlOS2hnTnhIblF6cTU5UjJHOFNXY2xxcERjaEhXUy95Mk8xSUNQT0xr?=
 =?utf-8?B?RDE4ZE8yRVYvOWR2SEVUMkZKNG45NXZ5ZmJ4dDVUWWs3RGdYeC9UYkhLdkhl?=
 =?utf-8?B?enkxMVE4UDJ4a210VUdqNzRodjJyM3YzZ1dieGVsVUVCemlmeXFlNmY5a0Zj?=
 =?utf-8?B?dFU0VEFleVQxandGaTdhTmpJQ0l6YkpRcGNSaytVVmVQRW0rdnBLVGZDaHho?=
 =?utf-8?B?WjBTWS9kazdIVXpnUEcrQlg2Snc5MVEwUFk2K3k3VWkzNXc0VTZwOE5PVW9t?=
 =?utf-8?B?NmI0RGh3NjFyc2pzbXl0Vi81SG1yMXRKTHFSSGxyV0Nab1NWZ3VuRys3RHVj?=
 =?utf-8?B?S2c2QVhKS1UvL0hmSTd0bmFzMnhtVTNSemhTcTh0K3dTOTJqRGtHL0cxcS9p?=
 =?utf-8?B?NklLY2VpcnBRbnRVSHVtbmpXMjJTZkNUYTY0MnhvNktCd3VZYXY1bDBDMHNU?=
 =?utf-8?B?Q1poL1RVNEJyZ25wQmp0WkpMdzQ1QzArOHZGcmtzLzAvN2NxYXpQbHVIQisw?=
 =?utf-8?B?cCtQM1lrM1RpKzVXK2NXNG1QMjVDeTFLaFRNc3l0bytZZHFuTDJQQlFGK2xx?=
 =?utf-8?B?aksxdjRnOHlkSGEySmRZVWs5ZkJabzhXR0V1OVB1TFFZNU5CaWR0NWNBQ2RT?=
 =?utf-8?B?T1RzS3B0ZS9ybXpLM2lQN0ZaYS84cXczZ0hTTURWNUdQM1BWeXV0dGdoeGRx?=
 =?utf-8?B?MHRYYndzU2F1R241dTNXZGhPV21TSDU1bUhWcDFSYTN0dFFleWV4aUZnTzRh?=
 =?utf-8?B?c1ZqV2sreVBUT05GMTdTRUgvWjRET21Qa1dwcFMxMVpvMW5QZ2pQZ1c5OHlB?=
 =?utf-8?B?a0pWWGpxLytBdkc0VSsrRlpFNG10aHUxdU9RQnhjRmQ1Slg1UlIvRTJKSXN5?=
 =?utf-8?B?SjdxTUVsTW9ub0VialNvcm5NWURTNXU5TUhaKzVOKzYvSDZMbW94UDArUVVN?=
 =?utf-8?B?UWQvT3BmTExXaDdzUFRHK1NIT0g2WXN1Ykhrb1NLYkZkZDQ0ZDFqN0tPa1Z0?=
 =?utf-8?B?V3h2Mmgxc3NOUmMxYjMzdEFwNU44ai9XMU1ZK0Y1MnBmb3lQUFlMbXRqakpC?=
 =?utf-8?B?cE9yMWh5dS9VMU9xcmJXZFc1TUR2U044YWNaZWVhd0lUOVhKanF1RDNnVTFO?=
 =?utf-8?B?YzdTcWZYNXBSWEpJV2p0SDhpNFk1RXZ1cFpQV0pwRDBNZllPVDZMcHFvNVNx?=
 =?utf-8?B?QTE5dmhzZlB2YldDOElTK3ZSdjc2RUdCeUR6dnJmYVdnbmc1YlozOW95L0tC?=
 =?utf-8?B?T3hUb3U2QkZmejhXMGpDWTZCL0wyOHNNOVh3NmF2aGRvc0tZMDFDSHNteVY3?=
 =?utf-8?B?Nk9kV2FBSEc0Wnl5RTR0WGR5ZXhubHlMT0w4S2pITmxMUjhZWkk0QjIxT3pW?=
 =?utf-8?B?OGVwUndma25SaE4yL3NMK00yM3NxSE9tVHF3eVlhKzd3WlZvV1V3WWZrN2ZP?=
 =?utf-8?Q?RKNuBJMx07hnbU212VIh4pKPa74AWg6/+iD44=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6647700e-7a97-49ba-c7df-08d8dc7177f4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 05:18:37.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8slKqgBsB5cAjyk4A4qA5xgP+Cdq1apFWu/2JzIhJP7qxPTC3VUpTNmjFaHuHsC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3933
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_01:2021-02-26,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1011 mlxlogscore=911
 suspectscore=0 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103010043
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/28/21 2:30 AM, Yauheni Kaliuta wrote:
> The verifier test labelled "valid read map access into a read-only array
> 2" calls the bpf_csum_diff() helper and checks its return value.
> However, architecture implementations of csum_partial() (which is what
> the helper uses) differ in whether they fold the return value to 16 bit
> or not. For example, x86 version has:
> 
> 	if (unlikely(odd)) {
> 		result = from32to16(result);
> 		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> 	}
> 
> while generic lib/checksum.c does:
> 
> 	result = from32to16(result);
> 	if (odd)
> 		result = ((result >> 8) & 0xff) | ((result & 0xff) << 8);
> 
> This makes the helper return different values on different
> architectures, breaking the test on non-x86. To fix this, add an

I remember there is a previous discussion for this issue, csum_diff()
returns different results for different architecture? Daniel?
Any conclusion how to deal with this?

> additional instruction to always mask the return value to 16 bits, and
> update the expected return value accordingly.
> 
> Fixes: fb2abb73e575 ("bpf, selftest: test {rd, wr}only flags and direct value access")
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>   tools/testing/selftests/bpf/verifier/array_access.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/verifier/array_access.c b/tools/testing/selftests/bpf/verifier/array_access.c
> index bed53b561e04..1b138cd2b187 100644
> --- a/tools/testing/selftests/bpf/verifier/array_access.c
> +++ b/tools/testing/selftests/bpf/verifier/array_access.c
> @@ -250,12 +250,13 @@
>   	BPF_MOV64_IMM(BPF_REG_5, 0),
>   	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
>   		     BPF_FUNC_csum_diff),
> +	BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 0xffff),
>   	BPF_EXIT_INSN(),
>   	},
>   	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
>   	.fixup_map_array_ro = { 3 },
>   	.result = ACCEPT,
> -	.retval = -29,
> +	.retval = 65507,
>   },
>   {
>   	"invalid write map access into a read-only array 1",
> 
