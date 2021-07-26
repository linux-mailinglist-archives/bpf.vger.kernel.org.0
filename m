Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B5D3D5190
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 05:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhGZCwg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 22:52:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60198 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230272AbhGZCwg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 25 Jul 2021 22:52:36 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q3WS2o007470;
        Sun, 25 Jul 2021 20:32:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=uO/zXhBO8rT6Qpb79bnd4nbRTJY1beZait9SWE8F5IU=;
 b=D9SoUsHTQdfFl6YrkDEnKU0jPQBsCsjM+LsUeQRmj+XcBY3kwXW47H2u+BBn1KiM+xg9
 KlboaJrCf5cPRJEwJf2X0Ea7ReQ1sj2IJTUmdoZZnmQ9DtX5RL8nm0itqjogE0rJ8Y4v
 HD61UpN6HPCRUEXovMPKh6QCra9UTe0jiqU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0e6rqfef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 25 Jul 2021 20:32:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 20:32:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAt4//1G2bwhoT3U9I3EgFp50iebPqJOoifzhJz41r3difmfUgjy5/Pmmnr3CzZdDW72Kmn+UBqrOg/Ss4JT4T1mhI+SjBGDrY+u6WLb1DIoFVsYaUPnYwGhMYsX5x9M6+5CCN6+vf2q97ld/9w9ZEPT1hUxjrGpHMQDIMMzUHWArBvQLCy5HuFY6EofEd2A8rF7UgTh4rzlYh2gbY6kB51iVrP2f+FdIFKqFlH9vazxvcB0BKu0di1+x681F6huJTzwtbxBMsdbBS42St/4sfjf8l/rtvQosM6kos7HPTa7wzvVth9wbCe87D64pMfUX8bm7TH3FNq0/fFnhHSvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO/zXhBO8rT6Qpb79bnd4nbRTJY1beZait9SWE8F5IU=;
 b=I/IOkrb9AH/1IEYaK7+HlJAed7w/+QrOvOTfQzwlXdr8pW8ME4kDlF2NB3IDaKPu4oRBPPz6kwg4Hug3A3Kj3z5DzU/crwpAMaGUrPV3ycz2YRw2yVlZxjaccUpNU2VPT8zwuar06N83nIgU8sRt4HkoBeCAqtzVd3kiPfjvJAdY/XI68H4GxrqbYRvkbLV4c6UpA5yd9jksx6pDPZVcJrqxWtTvoa1Uvi8AovtrQu5eZKtOZPwsiyahNWGseX6xmbn7frCJH1KVRmu2CJL95+qA1YCQmr8mr0v4CSNZeGlxI1+jPqcraI0cyIAUFatv+PFqiTCuRK8wSIGm4psaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB1965.namprd15.prod.outlook.com (2603:10b6:805:3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 03:32:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 03:32:47 +0000
Subject: Re: [PATCH bpf-next 1/2] tools/resolve_btfids: emit warnings and
 patch zero id for missing symbols
To:     Hengqi Chen <hengqi.chen@gmail.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <yanivagman@gmail.com>
References: <20210725141814.2000828-1-hengqi.chen@gmail.com>
 <20210725141814.2000828-2-hengqi.chen@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <dde36573-f6b9-8570-0878-e313e771345a@fb.com>
Date:   Sun, 25 Jul 2021 20:32:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210725141814.2000828-2-hengqi.chen@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:300:d4::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:cf4) by MWHPR19CA0002.namprd19.prod.outlook.com (2603:10b6:300:d4::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 03:32:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec2ce54e-ecc5-4893-ca70-08d94fe609a4
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1965:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB19657AF95AFF2A9EC55CC8BDD3E89@SN6PR1501MB1965.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:332;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPblYfEmggEzrlrTEnVRZbDzv70isE2/jRxqv+uF6j5Wf9PIlnE3teHvADhO+4Fq2JBFK9nFhgigNLYZ3GZT3frlfNCxosgSoICKUHrZ9iUeNj88W1gB2P6I/N72TQgt23MmVk3xJM4RB7Mo9rKaIFFdWCYC6asP7XZSyNpWLSl77/RLZrsjDeaNqGW9PwjW0y0JXpqmqXw9ZYvG8aRgZJqzauLETIfD55J+tz6yl0MFeUzmo0LgzmI1U2eol87fXqEX8NImCBac6woqA2LMwpMpYvZTARB9te4OPGtwrHyd9VG336lD2MmJUfY4ShEm3Uh9+P8YcmEpSUnkH0RQT5pE3YQz3gjTBzqHSyhNREWfKfGupL9sCpUNID9sntOr0CuCz65e0PB1dDwmMeWbRGtz+vHXhPvpWmtn+8ghq7xP4SL679MumtL/CBoesbwCj+fBeSfaQcHuKnpOY+yhSG9dYB5ZbfdE97q4StQlMVsjTsgf+3yVAN1jkCHIdyAC98JurGBXbK9G9oSwvGLBuA3QR/8k0x6Y21QuI48XvTm0MwREdPBxn6GvFH4VTWrXDtKuUmgYQ/xMzPDqXaVGMg2bwsS2trNOVtaT1VA2pGjHH/0GCnfR5DKcZE321EIyp3JS00Rbk+WoeaDfUmcYlNOx0iO3pF40YislKZDXU0m1FzB4npfTsoMc+w36hddflfONQtmMdDVOMhLHCZRNHwH4D4+gLVDRC0NsP0eiGWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(4326008)(53546011)(5660300002)(2906002)(66556008)(66946007)(86362001)(478600001)(31696002)(186003)(66476007)(2616005)(52116002)(38100700002)(6486002)(31686004)(316002)(36756003)(8676002)(83380400001)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEI2SHZVY2RnekRjOTVibTZJYkFGQ2dXQlI2RUl1Z0hCV0E4UmxxeFRpV0FS?=
 =?utf-8?B?d1hKRk43OWM3ZE52RzRBRS9HME4vOURYd0FSU2w4R0Q1Um5oMHM5OGtHb3RS?=
 =?utf-8?B?ZzdrL2pueG8xVGFReEl2WGE0c1ZBRTRnNjk4eUNOOWpXbWVpRUt5Mno4blI2?=
 =?utf-8?B?K1dDNTlkQXFTYml6Y0g4SDVJNTVmcEdBT2w2N1ZtL2tDSmNsbmE4c01Jd1hl?=
 =?utf-8?B?U1dSMU1id3BUOTJJc2tHTklSREZZQUgxNVJPeit2Y201eEFEb2pOTWR0L2RV?=
 =?utf-8?B?eXBMZnZxakp3dStxRW9iVkc4VFgzdkZKVzFhWXZtbE03VGVLdTNuelJMZnFN?=
 =?utf-8?B?TyttdjQ0TnRrMHh5ZGxQRTM5anBsK3Fha0hJR0hBTGdRTWRHQWozci9MR3lv?=
 =?utf-8?B?Y2hNZmJZakJ2eGkyUlZhaUlsb2RIMjdQUDhEY3JKUkRncVU1MUorQTZBTFdG?=
 =?utf-8?B?YThWTDFjUHJUWm5CREwvemZ4Q0NleFJ6cTdIODVVZFEzL25LVTFQYTJ2SlNs?=
 =?utf-8?B?Q1BwalRsekRVd0RFdHlzVUVqU2pZMUJWSGNuRU01SVk4dm8zTjZRR0o2WGFh?=
 =?utf-8?B?eTBDSkRTckpRUnlYZFRSTGJPUFFibytJcjF4K0tVcWttUWF1bTNDWkxFMHI2?=
 =?utf-8?B?bUpxVDRsUW9nV051MzFKaHIxZWNZc2ExeWFxUTJmcVhHV1NXWU5WQlp0ZXk5?=
 =?utf-8?B?MjhzOUlEVk1KZWIwT044aTRjSktLTTRFTzI4R0hpOGhMWWl6THhnb2ZDVE5v?=
 =?utf-8?B?U2svSnRybFh6Vm96OUNMeW5Wa201Y3pwWTJBRldjSVVyK0Y3eUxZWXJmbFpx?=
 =?utf-8?B?eEFmeWd5V05JaTZ0Z1Vudis0eml0QnFKWnFqNUtNdHo4dk92ZFJLU1YzdkRS?=
 =?utf-8?B?VHdtRWdvSVdHb0dtTEdZSzl4ZXBCVzdjbkZFUXg2VG1xQ1hnbkQ2andmcUYz?=
 =?utf-8?B?WkJ3ZitHeWdIQmRKTWx5WUdyQmF4MkZTMVJaSVNmVFpzTTZTU1g1MjdjVHpK?=
 =?utf-8?B?d09zV0VLblR2bk1UVkFNMlZoeXgxRXpod2tlcnduTFNocXRFN2dzQ0s3R3Nn?=
 =?utf-8?B?SXZWOTY5UjJBMC9sZnJmSXBraitnU0dMQmF2NDhPMFZlSmtMSXJHc3Zhemdx?=
 =?utf-8?B?NiswUGJxL2RmSTlZWXpqTnVMV0J4ZisvUTI2N1Bya0RTNUxhUGJlYlc4dlVB?=
 =?utf-8?B?dnRQRitOWGhOMCsrMXpaMzB4WGpQWVVGalZuOUpzZ1dFTE5ZZnFHTzRPTnN1?=
 =?utf-8?B?Um92S1hyVkVMeElOd0NPMXNHbTBaS0VNWjBsQXhxVnpudjFTbThXM2NodkFH?=
 =?utf-8?B?NGRUMmJQK25wTTk0Z3dQMHg2WnZuSGQ0RTd6NTIydFRVVHcvTStJVTdTV3da?=
 =?utf-8?B?MEQyNTBYTU8zOWRBRThXOHhJQmhQNE8vVmpCTjRnM0lyeFVkUDcvQ1RMM2Vw?=
 =?utf-8?B?UWpwemRIUWoxajVrQ3NnUytoSW9VT3AranJPdWVmWUFJencyV2hQM2NXclZS?=
 =?utf-8?B?Zzg3QXEvN0NtRFdWM1oycXdxaFZrN2xIVnFsbEROR3ZkbGpUMFZVYVZXMXJP?=
 =?utf-8?B?cEczYVBLMm1CYmtYK1BFdXJVNVhON3VpZVFtbk9DaVJJRDVnL1YwQmcxMmNo?=
 =?utf-8?B?NDlBZHJBaC9sVG1RbVFDeFk5TEhvUnI3Z2RkVlE3QXJHYWFJV1RWSENkQnhY?=
 =?utf-8?B?TFVEVTV5dFJwc09kUW1UNGEzU1VTRjFkdDhLMVpwZHFnQWhzeVFiUnhmaUY5?=
 =?utf-8?B?YXNDeXZVTWpHSVQrbzNyNWZoODVBSVcySTR1T1IwM2VJV3JGRGNmVFFYNTJh?=
 =?utf-8?B?VmRZRWJWVHUwdHoycGdNZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2ce54e-ecc5-4893-ca70-08d94fe609a4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 03:32:47.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9BY4JTwYtvRxtxcG9V8yNtX06iDY/6dRwHkr0IH742AQ1EMUUSal0EV/xMH8Otr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1965
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 53EtA-aq1VIPWYgXPFbl92jFSFgR2xgG
X-Proofpoint-GUID: 53EtA-aq1VIPWYgXPFbl92jFSFgR2xgG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_01:2021-07-23,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/25/21 7:18 AM, Hengqi Chen wrote:
> Kernel functions referenced by .BTF_ids may changed from global to static
> and get inlined and thus disappears from BTF. This causes kernel build

the function could be renamed or removed too.

> failure when resolve_btfids do id patch for symbols in .BTF_ids in vmlinux.
> Update resolve_btfids to emit warning messages and patch zero id for missing
> symbols instead of aborting kernel build process.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

LGTM with one minor comment below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/bpf/resolve_btfids/main.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> index 3ad9301b0f00..3ea19e33250d 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -291,7 +291,7 @@ static int compressed_section_fix(Elf *elf, Elf_Scn *scn, GElf_Shdr *sh)
>   	sh->sh_addralign = expected;
> 
>   	if (gelf_update_shdr(scn, sh) == 0) {
> -		printf("FAILED cannot update section header: %s\n",
> +		pr_err("FAILED cannot update section header: %s\n",
>   			elf_errmsg(-1));
>   		return -1;
>   	}
> @@ -317,6 +317,7 @@ static int elf_collect(struct object *obj)
> 
>   	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
>   	if (!elf) {
> +		close(fd);
>   		pr_err("FAILED cannot create ELF descriptor: %s\n",
>   			elf_errmsg(-1));
>   		return -1;
> @@ -484,7 +485,7 @@ static int symbols_resolve(struct object *obj)
>   	err = libbpf_get_error(btf);
>   	if (err) {
>   		pr_err("FAILED: load BTF from %s: %s\n",
> -			obj->path, strerror(-err));
> +			obj->btf ?: obj->path, strerror(-err));

Why you change "obj->path" to "obj->btf ?: obj->path"?
Note that obj->path cannot be NULL.

>   		return -1;
>   	}
> 
[...]
