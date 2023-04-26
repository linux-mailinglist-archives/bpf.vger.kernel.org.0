Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC06EF9EF
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 20:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbjDZSSa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 14:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbjDZSS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 14:18:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E9583D6;
        Wed, 26 Apr 2023 11:18:27 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QHla7W024813;
        Wed, 26 Apr 2023 11:18:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ya1QInEOi6VImjwby3Ah1FpIPo8nzSKnXCpcdwsJqoo=;
 b=U5132Ti9Vlq7VIXpaHW3WZfZfFiew1v9PBfZKH6gbLtQgP8rtqukyvJK4tuZQ2qbKdn+
 joiKnyfwQkwDiE7KdZkNot8xh8JQEovrlwb2O7X0FI69oK+/ID4CuBFm+zBTgiKgt8Xn
 eS5W0/eYf5CbNSaVb6Dr/SBFG0Okcy3wdOursJ1j3zyw3kMJdFYxTxpd7ovaX2YByeoL
 BK4SjFy6XP0dOPg+5TXL1sHku0A3sNdOOn9NDL8F9gFU8MIBRf5J+1HA6BVK0X1aaR+M
 1A2IqwrzaiN6kaCGC4tGMUgUKidwGgkKRSoGZyauIzG8+ndafKpsApoqJqfBM6ErSeX8 rA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6mwsfdy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 11:17:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHMw1/zwS+Bvk6cB3zTC4QnfnIqiyDmuq1OBbD5UvjOxkXzhlWdEeGECdxkYbiSwYjPZbOMKW6S4ASzwGluXH5g80uw4Gc4fyWuicuS4eRdUWLSLRvbniX5T1KN5aJE8VeZmQbTtaHiL619G2vICRXVgJMJ5ZjCGE0anMrHPD1mrMteDk+OWdcZ/K8YVnWwF96gM1uhZHQZIUKXXyGNeCRShgGjPOnlo8AyOKxRuMYo+U8rq7XmgSxam0jXtJ3o8dMBqd0pmT+Km6IxPfDxaaAFWY6HWosCXKxN5/6tf9cSzcmzEgyPr2OvqSl1HAQ3AO2CciKMdT+1F7lPRQc+A6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya1QInEOi6VImjwby3Ah1FpIPo8nzSKnXCpcdwsJqoo=;
 b=eADMr8Lar1rpxbT1inuXvKCdcb1zn6ARK5AVoMSxWboSCcxtvY/SYE30mf0wngGXbWLY0irFuNNm4P31MxJmJVL0QUp62ZCOEGKuV8U1Z+WR5n9iNW2cMp/zx+9qEpOKngv2LMD6MM602vxKdQwHar4ajj/bZNu2y6l2Tuc3ljcJITtlPtXO2Iax0W/fp4hI1bQBgNrNM77Ir1sHROqpSucqrMQFwTn5AdheDlOGg5C5VTr5p4cqkiB8wDSl3bFmD8fEVFz38mr1Zr86qOxHmdbRaIG4ehO5azeOu5YhW4qYc70qwkOLo/1sOXe2DY5bVcw/xK8L4xgwqLrsJs/6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB4026.namprd15.prod.outlook.com (2603:10b6:303:50::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 18:17:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 18:17:56 +0000
Message-ID: <b594a56f-5e1f-da7f-0ab1-71751bd0c5e2@meta.com>
Date:   Wed, 26 Apr 2023 11:17:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] bpf: Unregister fentry when bpf_trampoline_unlink_prog
 fails to update image
Content-Language: en-US
To:     Chen Zhongjin <chenzhongjin@huawei.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
References: <20230426095548.176045-1-chenzhongjin@huawei.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230426095548.176045-1-chenzhongjin@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0177.namprd05.prod.outlook.com
 (2603:10b6:a03:339::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB4026:EE_
X-MS-Office365-Filtering-Correlation-Id: 936935de-daa9-4d42-5e05-08db46828eb6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LL8+9/WLOex4xh2+CeZRfWjoXyctHnurkEzA6fTxVuNdxhMJsiUqC+1OzRaWmL/4i3G4EkZRM6FapeeKU1rL2D2hLZMV3fS25isZVMnkUDxClNXbQVKYfeh2M5rmYsn698DwMe5gKENgsTchTbgv0AY2V8DfFrLOHNr8uSiXk1MnsmmpiPeFmFypCgPDm31sFxP1dIyg5hWiYzzTQHaRdnBH11sBwN/iqLWhwLpR3wswCwq3neRxPHebqDB/W2mCAMYHP+PzsI17nqoJBuze73YCsLl69iVI80bKN63V52HrRXU/enT/9GmjtLrtAMB62cbeb0IDBThbyobIyvzZRLvSTgjnhMdlHPwT+UMfFl8Wc7KwnKGVQqFJ+TaaepMkMBmnIm/LtXooDjOVl3pepbAsDcwFTdEhwVO/vMEdXXxqAmNa5tOEiHc+gmSmieZeimiLfZQ51RsvnJumsWMv5a8VxZ06toOVog/dKfrjufepv6eDNKdED/Xa0cYfrpmMGUP0hSvTzQwnNIt04sHmTVx4zIhYk1h9rZpWCkksyb/U6b95gZuG999lnIcbv69DgbybVA+W+S0IrXP85S3Y+F9W1DS11yrdtVkxH6wqHsSxrjwcU/vkFSccXNcHv8ZR+qFkp0N1h5/sgnyzbeAuOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(2616005)(66946007)(6486002)(83380400001)(4326008)(478600001)(186003)(53546011)(6506007)(6512007)(66556008)(2906002)(15650500001)(7416002)(5660300002)(36756003)(38100700002)(8676002)(66476007)(41300700001)(31696002)(8936002)(86362001)(316002)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdJS1kyT09FaFU4bjJMVERncGhlNFIxS2ltTmppWDV4VXdIY09xcHV6UkxR?=
 =?utf-8?B?WnhBdXk0OGpkbElCSytDZ0tscXFvMVNsMFpPOHh0bEtCblI5Yk51NStJMExq?=
 =?utf-8?B?emZHaXJhWkxJSVpGOEpVS0l3ZUdtbytoaXpJcEJVV1Joa0oyVzR3aE1weHFN?=
 =?utf-8?B?Y2k3SFVWMXA0SUhscUZuVEduMzcrS2tRcTFtb293SU1zcUtIUXFtTHVEMzZZ?=
 =?utf-8?B?ZTBUS29rTTFOUWw0WnNHbXZtUFVYc0tpSTBJcTRPVks1OHNEV3FQWmhDN2Jp?=
 =?utf-8?B?OEZrWGdnYS9VMTQ1YXB0K3N0c3VUdWRrWmFadTBmZW4xY0Z1VXdiSzh2Z0Fj?=
 =?utf-8?B?OURiTVY0STlINWJZa20yV2JFcUhUQy9CWnlYM1F4QnQyeVoyY0Vad3NzbVU1?=
 =?utf-8?B?bUhPWG9MaFF6aGFlRzVUR3RNQ2MxYXcrUHpJWXVmNjdkNUxmUGlDZlJLZGxo?=
 =?utf-8?B?MjlLc2h6N3VtNnZhSXUzQnI2YXZ4SGFVcjNPbDIyQlhodnROUjc2MW1DdTR3?=
 =?utf-8?B?emR6ald1UlFiR0t5TG1qM2dkZ0g5cHA4NEJFKzgyU01udHJBNDdWYTZsY3pK?=
 =?utf-8?B?SU9VQW9TQ2dzQ2NJNGYzTXpoV0haUmhEbnR0aHRZdldXYkUrYXVCVVlLMm1R?=
 =?utf-8?B?SEpRODcvZCttVFFmT0ZqTXZjUzg5RUY1V1V1c290ampqSVFIczNFVWJaMVBO?=
 =?utf-8?B?ajR3OEJZVlFkZnd3U3A5eWtybnMvYXB2akJNMTVsLzQ4M0tSU20rVTdMM0RW?=
 =?utf-8?B?Q0hxR2tOOUpzNE9KWm1EUTZyaThUeXhXRC8rZUdmNFF2dkhoR1RNQnltMHFz?=
 =?utf-8?B?SkVuN3RxeDNJVFRqY1BoMXhmcHFiL3NXMXdTaHdXenY5elArek13ZUpxMUpB?=
 =?utf-8?B?QWNYcnJJUDdoWkNocXk5alpya1Joa2R1VzcrdEtjYlpUT2NXb0V3SkdxN1Vv?=
 =?utf-8?B?UlNvL0FLc1owTXZjcndSWnNJeXdVL1ByS0hsWDJ0QTk4dmU2endPRXJBKy9o?=
 =?utf-8?B?czB0NXNMYjdzRHNVakIyRSsrT3FhcU5uNWw1dmczOVZXS2R6T1dBYmk3ZlE2?=
 =?utf-8?B?TFRWd3Iwb3FaNUpwSjZHZmU3Y1Jpa2c1OXRrdFh5ZVR4cG9EWTN1OGdNUVZE?=
 =?utf-8?B?c0ROT05rZ1U5djJFUW05c2dnRTV4alJtRmNvMGhIOFN6bFF6MXFpeDc1S0p3?=
 =?utf-8?B?ZW9BUXpXclVmQ21lMTl3clN5QnEwaTUvZzJIVWI4M1ppRjhjbWxsd2wvQWNR?=
 =?utf-8?B?dGNxcFpZR0JaNml3TkoyaXNVSEE1RC91OFJmV1Q0d04wNFF4bGlPU2ZEeFN4?=
 =?utf-8?B?WE9FbEVrZXpuSERVSDk3NzZkVS9uUEhlcEtCZ0VDOGc3dWNjU29zSTIyditM?=
 =?utf-8?B?NEdyZXhDRmMzVythNWxIak9hYlNSWjZKcmkxTlVTcU9IaVdBMjkycTEvVnVs?=
 =?utf-8?B?ZURLaDJxRWd4Qy8xcDlIbWZEb3BpeUs4SVVjYy9yK3hzQUtjWHJnYVJUZElI?=
 =?utf-8?B?cG1aejhiMzlWY3RxMjBPS1V4U3REYkkxYVFSdFVzcldsL2l1UG1VZnpIQVJY?=
 =?utf-8?B?bnJ0TzF2bGpoY2p6NkZKYVhsVXViUGZIQzlQS2xLWmtzVHltaFJqb3RRczgz?=
 =?utf-8?B?akZZRm5VMGtDd0RzM0wyaDhWL0tvQVpkRzlZZmh4U3lQU1Z1WEtPMW5rTFps?=
 =?utf-8?B?NEJkclRLQ0xrdDgvWWVVcTJNY29PdU1oQjVtVVFSQXpNNkltOWVlSE5IN1pM?=
 =?utf-8?B?S2R6amlyR092UlpFcmZNN0tqTGh1VkI3aWc2UXRJeklOZlRMRGtGUnZscGVq?=
 =?utf-8?B?Y1FscEFpMCtKdVdFaEcxUHkwOGNPV3NUbzJrbjk3MnNETllGcGhsM2tkb2g3?=
 =?utf-8?B?SnpmajBUSlVxdjN0KzQzUi9jVktWREY0TTlTbE91bjJ5aXpvY2hhTmZabUhj?=
 =?utf-8?B?MUFWRFJSRjhmSHNscldmZ1F3azcrNytCYnRzOE03NWNoajF0NTNaWUhLYjNh?=
 =?utf-8?B?dGg4VnAyMGlEOTJKQ0JQTEZDbEtNbTBGQXoyUlVGY2NFUno2OVN4THB5UlB2?=
 =?utf-8?B?dGorVml1dUxpZWVzN3Z2TlFRZzQ5NlZ4UTVXTHNNbjZucllkZWpicVpkUlEv?=
 =?utf-8?B?dGRsMyswQnlVVVhWQTc1WXgwaTBWM3pPdC9pUjRzQ29kWElOTDBiS1Q4OC95?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936935de-daa9-4d42-5e05-08db46828eb6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 18:17:55.9100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WX0DtQ4FAWkq8euy6vPmD5j3BKzZZDPhZRAbyV302KtObAWETHpBoS7QmG/mljmJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4026
X-Proofpoint-GUID: U8XaA7IfFw-4hu1n5i3RfcGFJUDSg-TL
X-Proofpoint-ORIG-GUID: U8XaA7IfFw-4hu1n5i3RfcGFJUDSg-TL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/26/23 2:55 AM, Chen Zhongjin wrote:
> In bpf_link_free, bpf trampoline will update the image and remove the
> unlinked prog.
> 
> bpf_trampoline_unlink_prog is committed as 'never fail', however it depends
> on the result of image update. It is possible to fail if memory allocation
> fail in bpf_trampoline_update.

Could you give more details which memory allocation fail here?
bpf_tramp_image_alloc()? Are you using some error injection or
this happens in your production workload?

> 
> The error result of bpf_trampoline_update can't be passed to bpf_link_free
> because link release callback returns void. Then it will free the prog
> whether image updating is successful or not.
> If the old image tries to call a freed prog, it makes kernel panic.
> 
>      BUG: unable to handle page fault for address: ffffffffc04a8d20
>      #PF: supervisor instruction fetch in kernel mode
>      #PF: error_code(0x0010) - not-present page
>      RIP: 0010:0xffffffffc04a8d20
>      Code: Unable to access opcode bytes at RIP 0xffffffffc04a8cf6.
>      ...
>      Call Trace:
>      ? bpf_trampoline_78223_0
>      bpf_traced_function
>      ...

Could you explain how 'the old image tries to call a freed prog'?
IIUC, the previous bpf_link_free() should not be available to
call the bpf prog, right?

> 
> Fix this when bpf_trampoline_update failed in bpf_trampoline_unlink_prog,
> unregister fentry to disable the trampoline. Then other progs on the
> trampoline can be unlinked safely and finally the trampoline will be
> released.

Do we still leak tr->cur_image here?

> 
> Fixes: 88fd9e5352fe ("bpf: Refactor trampoline update code")

If the above is a refactoring patch, you should not use that
as 'Fixes' patch, you should pick one truely introduced the issue.

> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> ---
>   kernel/bpf/trampoline.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index d0ed7d6f5eec..6daa93b30e81 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -604,7 +604,10 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_
>   	}
>   	hlist_del_init(&link->tramp_hlist);
>   	tr->progs_cnt[kind]--;
> -	return bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> +	err =  bpf_trampoline_update(tr, true /* lock_direct_mutex */);
> +	if (err && tr->cur_image)
> +		unregister_fentry(tr, tr->cur_image->image);

If error happens for the all subsequent programs,
unregister_fentry() will be called multiple times. Any side effect?

Overall, I think this is an extreme corner case which happens
when kernel memory is extreme tight. If this is the case, not
sure whether it is worthwhile to fix it or not.

> +	return err;
>   }
>   
>   /* bpf_trampoline_unlink_prog() should never fail. */
