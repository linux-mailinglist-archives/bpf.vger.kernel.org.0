Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1361584672
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 21:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiG1T3p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiG1T3o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 15:29:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D686BD7D
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 12:29:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SGxXEs015372;
        Thu, 28 Jul 2022 19:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dex4YTDvTrXjaSt9gBeGxqsYjL4vyeVGuKCOcIr4Myo=;
 b=Dmo3IejnCIM7T79kyTMx/CgQpeEW8kzpi1AP2txhKWoQE+f/tVOVEQQ6IO3wVVwk7IbP
 4fRUIM+BSzIYyjrmRsJ5kzcAHlfAEb9dfIgPKg5/ovL9Z9vOqBsurSR8KYohaMCd1mUB
 kdk3p7pDI46KrPQgaM2GaKJqnzTPPKsOtBojZi+FCjRnCl4+1YCtjFFlLzS4wtUl5z8x
 L7uzvWEVsCylmbGpJoKtcMt8WrGWQhleX27GjVXqaDDGd8AP6DUzumm14KMWGQsAFgz3
 qhAFV49QxcIGt3fcpEgDM/yvlAy+xZ+z/K5f13YzVt2IhVgYjR/AUWJT5uE9/taPQcnd ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg94gngeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 19:29:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26SGieuh029695;
        Thu, 28 Jul 2022 19:29:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hkt7c6vbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 19:29:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHbD708RCXQsMIG8XREcD0tADVs3ujxVdaxQUHv3KyJj2r33Nbv0nL2ctt0mVCKHoBXRxS0g9wVVxofuwRXscICmduw2YAdHnKBb1CaMn4SaX2tyKPT1z+w6AFqpqFiRsbwjafdutHxx0kmccQhN00d1MhMQuZ7k8cfblo1YSU5V10W9fcVYcWSoczhUEEJ3SENJVjOCTWJpNlmvSPdQMy4oSrfI5v8PLILYDAgGFvxM/NQ1SE2EKBxgvLWWc8BB9YXsqwtT8wwYtS5m49gNb2A3OO808nGwr4LlwnSAmWn6NtxbbpLquy8YfQsct3GrnGqZ8MBJS8oAhynjA1d6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dex4YTDvTrXjaSt9gBeGxqsYjL4vyeVGuKCOcIr4Myo=;
 b=Wjy2+Bhd2oX/ibuBRV65cxodqbzWBaLmzAnUiG8qzY7EcozlrOHfS+eI/paTAPTV4SpqybwUDkhUqzCg2Vc/KiAjStwXiMiT5+7ugHPrNZmwGCiGD9KRZGLhpwORXwKYYkyk0TJbniTpNS2FPdyHHTVulR+9KJWOq4LlqJfyw3iJA/ORI+40Cx/UUN5RFxPxFuQhZB3neGoHznUEFu6GGmVmI4Ny3P/zdzdoDtesCMbvyBeB6UYrLODhwWej5msCa9GOE8ey3vYsx71A5VJq8/xBKz9pEmWTg1g5avyoQhAStVZTG+HYJtJSs+Wa3hPuwJP6Erxu8l8hz/eochGD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dex4YTDvTrXjaSt9gBeGxqsYjL4vyeVGuKCOcIr4Myo=;
 b=VkIU0svz6tDBn6vbaM+gqCLfeaUkMrA3TautW4L1horw1exMUFb/jaiMF80g80imTWCfTfruquHhKGg7pJ3gVuDJwBPEusMmwBYm8DeEaihKiPnlQz/LaeByTFgRwgHhm0PhUYldnY7QsnwTJRe4CpRYkKZ8zWDeGTh3aelD7zc=
Received: from MN2PR10MB3213.namprd10.prod.outlook.com (2603:10b6:208:131::33)
 by CY4PR1001MB2149.namprd10.prod.outlook.com (2603:10b6:910:41::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.20; Thu, 28 Jul
 2022 19:29:37 +0000
Received: from MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::815f:640c:8792:186b]) by MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::815f:640c:8792:186b%5]) with mapi id 15.20.5482.011; Thu, 28 Jul 2022
 19:29:37 +0000
Message-ID: <eac902cf-37c7-09d0-2ec6-20f72ec27e31@oracle.com>
Date:   Thu, 28 Jul 2022 12:29:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next] libbpf: avoid mmap for size 0 sections
Content-Language: en-US
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org
References: <20220727204808.13210-1-david.faust@oracle.com>
 <YuKaFiZ+ksB5f0Ye@krava>
From:   David Faust <david.faust@oracle.com>
In-Reply-To: <YuKaFiZ+ksB5f0Ye@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:806:125::27) To MN2PR10MB3213.namprd10.prod.outlook.com
 (2603:10b6:208:131::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c214c52-6b2c-4c1c-78b7-08da70cf828b
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2149:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zI5+wqgvuy1MUyWU5jewNtK1q5+RAhT+wM1ErhH1lIFAivV8G7kNCjODROMJ7xeq2QeklMnWoqiojx+99R2x/0yuvP2O60sjsoE8VeO69aw2Yg+k9CcoOIKoM2cg42UsYB3ax7uxUvdwsnwZT4phJdMNaVK7KMi94xH/sgPVcrWoT4T7z89nQjkY1G6lOUqfjEtAUdn9Mv/5usNf84g2oi4vPLH3jhbCqcGzZXAvLhGozXSFWh+EuRRo5NFB5hYuORJvD7MRoeDDXdEupMZVvQNARMS2bS9Qta6jsAJjAgm9sJVSFqFqsfN5LNyHNHgzMKpo/ZukU2GNeRDVQMw+EPyX3U+8n9TvaryRbO6brgwwNzgWXsDuNrX46whbbWh8hFDtToElaO6ubCMeOTxha1E4ynljq4xRpnRC9cEuPSkYF++uAclpWMpHP0IIPhfY5pTRNT/9XZUrp4gnoeFVruiOgxme8KwRnKMSahdsPoGTvCZl0kWld+k4MD59ljul6NQRQKLf8/fhNNgHPKayRRP69Zlg1UkHRloekDCl3jyV0ecje+wA7gQaR2vMx/el6mHnpYLRCX6XNGDjmmKKwPk5JdQvRk9bSZZrg+11IBi2GYJWu6RhcX5Zt7WmQLZf1qErmErhFusRW/fHtksniUy5f39IUekGUrsIYiTUGBum/HQbtGBI2kxXRiAWB8g1k+ILFKjKJLAKmPhyEM+xPFmJMMDv7t5Vxo9mTPiRWcIYIcA7WKLJwwqQLlP0E+6djIDWvijKUuTGoUgpuhul+sy7N+cXMY8MmAhi72Tba9amDDBrBPJHsPWqgVclzsyP8fXzbV1grzf9dO1j6JXYYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3213.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(396003)(366004)(136003)(6486002)(478600001)(66476007)(66556008)(66946007)(4326008)(31696002)(86362001)(6916009)(316002)(2616005)(8676002)(186003)(6506007)(53546011)(83380400001)(41300700001)(38100700002)(6512007)(36756003)(5660300002)(31686004)(44832011)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1tbW1DTktaTGFUREJ0dWNKR1VIU3VpenhJUy83Q3R5VW1VUHlkS3ZCZGxq?=
 =?utf-8?B?UEdqbUdHQjRaaU9Hc1FHM3RzTXYrM3RLVXhJY2tDbm9HZmt4WTh4ZjNEdCtT?=
 =?utf-8?B?ajdldXU4T3NHeXJ6SXoxL0d1WFJWdXQwNlRDYjFWRmNnTEdGUFlYSU9WYnpK?=
 =?utf-8?B?ajRNaEV5clVTbk82ZU41dmQxalJpR3AveVBHb0dmSE5qS293azVHVitiMWJ6?=
 =?utf-8?B?SHBXQ0VKWWpvN3hZbzVqSXFMNWtZUG1WazJNM3dwSjVHOVg0ZUdMeTBRWmVl?=
 =?utf-8?B?eCsxZ1NiNVd1U1l3aS8zaE82cDMrYkMyS044TUVMZzRad2FJODhiQnMxOUxD?=
 =?utf-8?B?aXBNakRYZ3VKalpQQm1pZW1xeGJkaWxFcFJjVUF2d09PVTgrUERFTHNJRkpI?=
 =?utf-8?B?eU9zNlNSSFQ0RGtMYW52Z1J3aXNOdzJ2RUp2bUJ0SXFJMUluTnNWNHI2UlNH?=
 =?utf-8?B?M053MWxOKzIwcW1rWEtFRU5pYkRwNTFPZWs4OCtpRjhybzhSc1c1NWszVHpq?=
 =?utf-8?B?SzFLNVdMM2pXaklrNklNNCtydGtyekh4VGptZm9EbS9UTHNJN2EzR09GdkNy?=
 =?utf-8?B?bVM5VnBKTDlkRG1JWmsrNndwcy9BYmNxUTB3WWk1MXRYVUw1YVNDQnp6NWhZ?=
 =?utf-8?B?THpxR2FKdk1DU0V4TWw1aTBJNWx1UzlHY0dGNUdyMHpNNzRlWlVRMmFiZGZL?=
 =?utf-8?B?Y2szcTdMMDZ3bUxaOFRIdmtYaThDbE9aNHk4RlphZTZOOHlhN0paRDB0Nzl2?=
 =?utf-8?B?L3dNTHpIUWxUdnFGV3BZSzNBZElyWWhLelBueUM5bHd3ZEVZQnIzcE94TjJP?=
 =?utf-8?B?Um1RaVZ5THlqZ3ROQkRYcmQyRXRNOEluemNDYktIRkJqODg0QVo0VjFScnh3?=
 =?utf-8?B?MXZKTkpvNmFmRVY3WHlMM0ROL3ZQbWIwcnFYRXMyd05QcXpRQXlYSmxkbkhE?=
 =?utf-8?B?SW1qWjZaQkQxWW9LbE9oQnJsYTRodmI4dUcyRmdnUGN4cmRBZTdXWjI1dk45?=
 =?utf-8?B?UFdTVzFLZ1AxV0NMZmVCbXQ4c25BZm1mbys2V1JmVExHOWVWak1KNjUyeW5J?=
 =?utf-8?B?a1phdEpmdWhNVE8rMVJlYk9KNzJUVkJjcERCRnJLektsRHE3RHZEZkxWQ2w5?=
 =?utf-8?B?eE55N1ptcHdGd2g2QkptbmpsVDF0YW1wQXRFRFVDaW9BeHo4WWRKby9raVM5?=
 =?utf-8?B?Y054azJOQ2ZybUZqb0VZM2FPSG5KaytNV3ViYmUvWWFyQkhINSs5Zkxvc3VP?=
 =?utf-8?B?dDF0WlVvSlpzWjh2WTkrYVlUQkFKMDBpV3JHclA4eHFPelBWd0F2NVo1YWlG?=
 =?utf-8?B?Z1dXOVJPNE52b01lMVJieDV2NWFIREJtRTlIQXUzRlR5dkU3bHQrOXZiRTRq?=
 =?utf-8?B?QnRxRXI4NzU4WUlqem9IL1RrQmtSZEVHZy9sRHh2MUpIRlNUSGJxWlB0Zk5s?=
 =?utf-8?B?VkYrQkRxWWtBZTNYR2xVQmg1V3dRbDBGWm9WVkNQSkNSNjJIUkdwdEFabDB1?=
 =?utf-8?B?L0ZyMEpUd1QvK2dvYklzcDBadzVxdzJUVHYxVWZGMGFTbGlnYVhMc0kxZkg1?=
 =?utf-8?B?MW5IWi8xWjVFTHNubDIvMUIyaDNDUTlsRkNUdjJrSC9Ycm5KMG1OUWlHK1Z4?=
 =?utf-8?B?cEhDSFM1REJzTTNvL3RKNC8vZ1Y4N2tVZlpHa3VUOWd3dWFaMkYxSCsxZXlL?=
 =?utf-8?B?K1R6azdsZ3FRVDFqQnltaDhBQXI1NkdUYlZtL2lrOEVybVFyTXFNR0lpRk5a?=
 =?utf-8?B?VUswdnJWVjc2NjBHbGNVQlVQU3YvcFUwL2FmdElTWmJTQ1lVRVF2MjhmdG9x?=
 =?utf-8?B?OGFoV3U5L1VQSmowdERlMFRibmNrNysyY2Q3OVo5dUhUT2liSXRic0ZrOGpY?=
 =?utf-8?B?M3RsUEJ4K1VyQzN2STRGK1d0Y1VXN0tLQ1hyZEEyTkNVVEg3UkdYcTIwU3lt?=
 =?utf-8?B?ZU0yM2ROWnYwaHVRV2NWRGNsOE1wamR3T0xkdC9BUUNFOU9Edmg1clVnR0sw?=
 =?utf-8?B?S3Z5dHV3aEFGZVZNYW5sQXpNaVJvZEhUQW1DL1h0bHpIMUtadmpIWldHdUNx?=
 =?utf-8?B?MEhUL2daSTJMODRHZWlCQk1HSmNHbmRLcERUQnRYMGQ0eEwrRmpvajJnUnZt?=
 =?utf-8?B?QjRaZFI0VWxaQVhQTU05M2JjMjBXc0NGaTYwQ1hLeFdqbWZLRnMzQXBFZGlD?=
 =?utf-8?Q?aouH1IPOyVzzYUY94TBO99k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c214c52-6b2c-4c1c-78b7-08da70cf828b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3213.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 19:29:37.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 53ekydruzOES7MFG5VFjXsxEJ3g/NcakAH+uXHxsIEupMJQNftaL6NTulqCe6EqcvDi+ET/rtphnW9E7qzL8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280087
X-Proofpoint-GUID: tJn8-Zk1AwVRDBDWuapE2Ybg5d02Ja02
X-Proofpoint-ORIG-GUID: tJn8-Zk1AwVRDBDWuapE2Ybg5d02Ja02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/28/22 07:15, Jiri Olsa wrote:
> On Wed, Jul 27, 2022 at 01:48:08PM -0700, David Faust wrote:
>> When populating maps in bpf_object__init_global_data_maps(), recognized
>> sections with no data (e.g. a .bss with size 0) lead to an mmap of 0
>> bytes which fails with EINVAL.
>>
>> Add a check to skip mapping sections which are present, but empty.
>>
>> Signed-off-by: David Faust <david.faust@oracle.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index b01fe01b0761..4e7ceb4f5a27 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -1642,6 +1642,10 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
>>  	for (sec_idx = 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
>>  		sec_desc = &obj->efile.secs[sec_idx];
>>  
>> +		/* Skip recognized sections with size 0. */
>> +		if (sec_desc->data && sec_desc->data->d_size == 0)
>> +		  continue;
> 
> nit missing tab indent
> 
> also we seem to check for size in bpf_object__elf_collect
> before adding SEC_DATA/SEC_RODATA but not SEC_BSS
> 
> I think the check should be rather in bpf_object__elf_collect
> before we add the desc for it

I see, thanks. Will send an updated patch.

David

> 
> jirka
> 
>> +
>>  		switch (sec_desc->sec_type) {
>>  		case SEC_DATA:
>>  			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
>> -- 
>> 2.36.1
>>
