Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C19A47D4CB
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 17:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhLVQFJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 11:05:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44178 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229951AbhLVQFJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 11:05:09 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BMBl2Ju017000;
        Wed, 22 Dec 2021 08:04:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7xDluYLCeELFx/I8A1oV9Kwyfr13oT7+Gu5/FYnLrYA=;
 b=WoVSe/83cDaycxO80l04hdjRcJm3AXwqPrzIT3kfsKMMwqmjDGzPczehSBwOrP1C3zyF
 dOO0xLzNUoI9bpL9Jqvl7U68f8B+fCKx+UbFf7KbSEhH7HR8XCGYQw7FjE8v0KZEO+4+
 oOUmaQTxsKx0H+iC2sLU6zFkakviWQGZ/Q4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d3pm267wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Dec 2021 08:04:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 22 Dec 2021 08:04:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWWCNkeJGqG7HloSxrrGYArxbmytUXI9Izp6ktGTN6m+gpuBcsoy/6heIXbtQzZOqGZiaMP+gjTehTe69vUa0Po8CG46Q7Xg2CZVXvIHvzhcp8GeFMdzd5RDn5qYYAz5q80j+PvNl9v4dFFkqJhk5z4RAkZIkgelfMSBeHj0OzVoht65SdEQmLFCTS0wOrczt2dKWY4aq+hI037oGswR9y73ZU1pQyivdPUBuJV4IOmavYjigiJmZumFzew0r6MqGtWOrsx8fIlkWLE+Uwf7i2chWTENH9R23pZGYRQxy19hc1Q+yBngzjImzL3AJmybCApR1rkYBJiOydgvBzFotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xDluYLCeELFx/I8A1oV9Kwyfr13oT7+Gu5/FYnLrYA=;
 b=GRzVfUTeVMFh95f1Dqec0AyXn0aka36i2pynoRErBee5UVf/cVoa8f71BhXEAOw62+iMHFaJJHBkwFecfkRj2NcnXgGmZgGit1d9aNJYfU/jBmByqU5QPBizHmcYsrSuN3XS+/HD2XTU6p5/OuEPRkU773Bu6Xy1T60nOHfGmUf4fe2SzEm9wgW569M6oUbjjrPbG2V0iWo9EPqcu1ve3D+UUMi01r0bTLisITcw8vkAEQsFI98he3zspay/lvmtAyJgeQN06y991KKxLu3OBUGrfXh3wahxlLCyU8l3hDQkUpmvw7jzlJJYU4bK3YmHNaJ+sHLcnNpc2Fbvhes57Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2029.namprd15.prod.outlook.com (2603:10b6:805:2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Wed, 22 Dec
 2021 16:04:50 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.024; Wed, 22 Dec 2021
 16:04:50 +0000
Message-ID: <7a214b93-dc61-ea04-44ff-ce57f39e04ee@fb.com>
Date:   Wed, 22 Dec 2021 08:04:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH] bpf: clean up unnecessary conditional judgments
Content-Language: en-US
To:     Jackie Liu <liu.yun@linux.dev>, <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>
References: <20211222131005.1380289-1-liu.yun@linux.dev>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211222131005.1380289-1-liu.yun@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:303:86::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f0bfe18-c64e-44e4-fe80-08d9c564c852
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2029:EE_
X-Microsoft-Antispam-PRVS: <SN6PR1501MB202947A79283827B909F7BCDD37D9@SN6PR1501MB2029.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIpzzutqwP0gXmepjNG4BnionOFVjeVVSvroqqCWjiQtEceTLGHOLXBq9CdCgFChaQt4m7PJ0SpZbyZs3RXqaMpv28MX07pyEct5WfY9iXL/2edkmOtAfU0zZxdcUUiKWqXBj3gy9nQ9CoQLf1xw2ZnNJ32IfSmrZoNTaVNXFZv4pi7oyha9c5O+RG1W+YBdRN3YwiKeoo9aBILYUMVcA1J4UFPaZz+BSqwZvZhgA8AbjQ+dqecJhrhIo4C7z0XQEJlMzjqy9vLQPznjIszAuLP5eXmc8+HixKiWFcxQRmxaFKUMS2MiS43QX62TZMbtmrP2HEG2nFdy/VyUovzyfyPABoQEgXlY/OH5m26frri6oTV7YHGmCX3YaNRZlMLEJbue7ES89/tjtLQ4oBr1RjPkiUh8g55xUXSSVBFKcWVMQT5mgULGnWvEB1sGdBL5t4ugErdRquwLPP5SG5tKYIsCV+7J5bIFGw5EIxE/atHKiICscAigZTGTeg/9SibeoFcSEZP8Bbvvhq10yK9v3Pfas1tH9BBe253WJ7QzDb97OQUlU2mmGHqcnkZDQ6fDM2lKhh9IlPwTpzmS/j9zL6MRTq5TFAjHdmBLctKi5PsmhAuJ8J6cXUKFWw2FLMp+uOJ63bf9wALlQXlZBoraCgZls2fNsxvwGalusxIqa/11pBVfB4PRvQM6YT1g6x8ojpcwYIZQab+oTRI9YuanIxZqwFlfGkrVSE4vQdyY5nQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(31686004)(5660300002)(508600001)(86362001)(6486002)(316002)(52116002)(6512007)(53546011)(8676002)(31696002)(8936002)(6666004)(36756003)(38100700002)(66946007)(2906002)(4326008)(83380400001)(6506007)(2616005)(186003)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGQ4TEdCQ0RhczBzMktwOW1CQ1VWWUl5N1JBVldPVzZaOUtKNzBDRWF1cHht?=
 =?utf-8?B?SmFkN1d0dnNiTUIyWW8vU0hLcisyTUwrWkxuS2ZpaDdVSE1BOXFCa0t4Tkor?=
 =?utf-8?B?M2YwRUNwY1QyUHUwS3g3SW5hOVZLeFZGd0kxMzF3YWVXWTBZNnVSYmlSMkNB?=
 =?utf-8?B?Vm00SCtpcjZvTThXRDZaWG9ITTgzaUdGZWlxa1dwVHAydllRSkd5VENCdllj?=
 =?utf-8?B?MGI3ZmtqZmQzYVRKWk9uS1ZNcWJnOXBlZWhIakZtR2wveTB1VlRQYy9MQUc3?=
 =?utf-8?B?T3YvVmhyeEJtMEh3bFozUkJxTWZ5YXR2REw3UEtHQzl2QmFjYjUxTklGQXR4?=
 =?utf-8?B?TGpiMjV2cGQrVFpDbkV4MnJpa01Pc2VLN2I1KzQ2SS8zZnc2eXVkOGZHYW1y?=
 =?utf-8?B?c1dWTks1NHlQUmF6UFBTWWR3MmwxZjUwT1JudkVZQ3g1Y05uVVkrZjUxcE5h?=
 =?utf-8?B?TDBGSmlqNm9DZStRbmMwMzRBTmF4bFJHak5sL0JVeGg3ZjF1VzE0cWtZWVl6?=
 =?utf-8?B?S2NmTDc3Yy9GdnhZcDNrMGU3RHdtdkxMUXg0anUyblBROHJCUk81NWtQQVJs?=
 =?utf-8?B?eUowVlg2Q3JGMGtYU3FKSXhmcGxmcEN5NVc4aXA3UDV1TGdvM3FFdWxUU2hh?=
 =?utf-8?B?NlZvd1F0WmZOc014WW9CaUNmMkVCWmIvVGlkZ2l1bDZ5aVhSYmJ6Uy9FYWhY?=
 =?utf-8?B?anh0Y05IVmNXVkRQak9VOE16cm5NSFpLTi92Qnk0N29RNlU3N3NJa3pMZmFC?=
 =?utf-8?B?STQ0YlhYeFovY0NmcHlzZmh2NmRqVzV0UlVGNm5UWlJaWTB3RzNkNlB4eTZn?=
 =?utf-8?B?cFV1MkVvNGxrTGVSN2d6RjBjRVhiWFNpTThaVk5tT2N0aE9DUmpjU2tDdFhM?=
 =?utf-8?B?UkJmQjZxYTQ2RHYyT2FsazF1SERuakNtNGlGOWs0VXVyMFhZbktqKzZRYmU3?=
 =?utf-8?B?ZERmUlZHbWliWGMvbFpValVodkUybDVqY1J5L2kwek1zYTZLZUd2Z2h3dkRo?=
 =?utf-8?B?ZDNuMkZUSS9TNFM1R05sWEtrQU1pejcvamdHRzhhUDVyMVR1Q3gyeWw2SUM1?=
 =?utf-8?B?WER2K0JlY3lhMGM5K1BmbUQ3bmREdUs4OHk5c2tUZlU3NnYyRjVnQ2gySDc2?=
 =?utf-8?B?QmxWbTU5OEVEbHE3KytDNUs5ZjNlQnlIazlrN2h6ZHQzeUduSW51VXVISWxu?=
 =?utf-8?B?OGU1Ukg1S2JLZElLYWtYYWhNQXF5Kzg5Rit6cGpIdlpqTUp6TERkdzRvVy9q?=
 =?utf-8?B?RHhXUzZNK1NIWnFQR1Awc3d2aTM2ckZ2V0NsYWZPdkxzelc5N1E2WVJOd3lo?=
 =?utf-8?B?RU9JSnhaRkZVUGRoVmQwaFFOUDVRMFUxWUthcFlDRTVnZjlIc2lISDdLRmMz?=
 =?utf-8?B?bko3c3Y0Y21qTGk4cDNTR3BUWFp2T01HWW1xOTlXa08rbUQ0RjNrTzdxUlFK?=
 =?utf-8?B?ejQ4Q0p3OWJEVzRiMUJYMlNQOEhXYmo2MWd5RW1xVlVseW9JOEVTNzV2NUNI?=
 =?utf-8?B?RDZwVVBJR0xadmdKWnBOU0Z0aWNqTWxndDE2NTF2WWZqQjhiYnZiRENQMFhs?=
 =?utf-8?B?cWV1R1dvNW1kV2l2aVNtaXljWWJxdkFZNHgxRDRKUHpHdmZvRkpUNTh3OG5m?=
 =?utf-8?B?SDdudUVncVJ3ZnAyRWtuaHVLeDNEUWRIaG5LR3IxTU1aUExyQ2p5NzBRNndl?=
 =?utf-8?B?STBmeGlBNjhENUFZSTVrSGUxWTB4SmFFY3B5UllOTXRXenBKNWI5cjhuZlBU?=
 =?utf-8?B?V0M3eGRrN0RGZUFRdzB1WGlXZGVsSU1jaFFsK3RCc2pHQy9MaXJORXhGREJG?=
 =?utf-8?B?NDR5SS9wUE5WYVFaL0NDZ1c5VVhtbVZyK044VHBQd2ZKaVI2VTFtQlJraFRI?=
 =?utf-8?B?dnJGR2pFUy9JbkFqOVY1MkxRTnQzYzFyeEJBbzJNbk1ERHU3b1pIK24wWGhB?=
 =?utf-8?B?MW8zVW9jSGpCSERkWGJEMDNiWTBLWGlhSUZOaStzblJ4Y0FIblNhcmp3U3VH?=
 =?utf-8?B?V2hmeW14U2tVTlgxYmY1em5waENlQmZ6UzBUMG1nZTUrK1ZpSVdEQm1BVHZy?=
 =?utf-8?B?TjNNcmZLY011amJ3UzBDemlwNFlUV0FnMWNiNUNPNXRIc0MzaXZBTE5hME9N?=
 =?utf-8?Q?m9WoI+H2no0qjXSMNgEDH055t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f0bfe18-c64e-44e4-fe80-08d9c564c852
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 16:04:49.9325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2liTdr5aACptdSZ83TyOOCiX2MPV4wKKK4Dit22MKBS69HgXH/8BxtrpAhjwkVN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2029
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: YR1kL9fxuy13O99E529zmh6VBqLxonHP
X-Proofpoint-ORIG-GUID: YR1kL9fxuy13O99E529zmh6VBqLxonHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_07,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220092
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/22/21 5:10 AM, Jackie Liu wrote:
> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> s32 is always true regardless of the values of its operands. let's
> cleanup.
> 
> Fixes: e572ff80f05c ("bpf: Make 32->64 bounds propagation slightly more	robust")
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   kernel/bpf/verifier.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b532f1058d35..43812ee58304 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1366,11 +1366,6 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
>   	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
>   }
>   
> -static bool __reg32_bound_s64(s32 a)
> -{
> -	return a >= 0 && a <= S32_MAX;
> -}

The following bpf tree commit triggered the above change:

commit e572ff80f05c33cd0cb4860f864f5c9c044280b6
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Wed Dec 15 22:28:48 2021 +0000

     bpf: Make 32->64 bounds propagation slightly more robust

There is no need to fix bpf tree since as this patch just a cleanup
patch and there is no functionality change.

Maybe wait for the above patch available in bpf-next and submit
this patch again? Daniel, do you have any suggestions for this patch?

> -
>   static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
>   {
>   	reg->umin_value = reg->u32_min_value;
> @@ -1380,8 +1375,7 @@ static void __reg_assign_32_into_64(struct bpf_reg_state *reg)
>   	 * be positive otherwise set to worse case bounds and refine later
>   	 * from tnum.
>   	 */
> -	if (__reg32_bound_s64(reg->s32_min_value) &&
> -	    __reg32_bound_s64(reg->s32_max_value)) {
> +	if (reg->s32_min_value >= 0 && reg->s32_max_value >= 0) {
>   		reg->smin_value = reg->s32_min_value;
>   		reg->smax_value = reg->s32_max_value;
>   	} else {
