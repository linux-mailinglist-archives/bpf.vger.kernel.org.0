Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B25A0247
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 21:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiHXTti (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 15:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiHXTth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 15:49:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AD57A506
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 12:49:36 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OItBlr020169;
        Wed, 24 Aug 2022 12:49:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=n0iObtDb/Qeh9XkdY7mV4/zjAgUYXJFLZMC5oqhizjI=;
 b=XCWt3wpNcD5qWpWwI7HpGmcfUPyMJ0NFyec2ld8QLz42tH8yMY4J1MJnP4wkRFt1vPr5
 cWmhOcUN/Tq0EjiPsvS9SYIz/RMxoj7tWJKaB156IDhlnjM4dp88d5EakMS/ILuE/lb/
 5RZr/MQC6dOwMRoY9HtjwpBEbjff4SjpDho= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5a8tnxv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 12:49:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbyfA0T/fhcmpg5yfT55yQoZUjsb4R6vWN8807BjXh69qTJxyalti3MS2XeO2zMCeRnEwtRfdO6s83r2v40oTZu8TE8V9vFbRQe3asB5/lEM9z49bNw27O37luYeYSBC3qbdqRA/Bvt1IToEOJB1bC+4mAb7W7bjzUVlGHfjwGhyRCSKkaL1KonAEMWMww5XXLOOZi7x/8xV10PJh7rFAt/px7H06k1iLSaZcLvbisYZdaYIugDQg6+j84b8huoGbUEP+mPsUAJi73EWjsa+ECzepMKnrXRZLnrRVkV3jJm64AuK/UuAZd6SinY2gcTirD0tITK7zhWe8DvtF6sr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0iObtDb/Qeh9XkdY7mV4/zjAgUYXJFLZMC5oqhizjI=;
 b=DjLrjKerZEPPfhwF8Qzk7kWsN0WVp7I/xLoqMKtgcznKD4ZCHmuLH0oNf9/aQJcIcJmUY5pFEwISJV3S9vNnF9lIkaCVA3JGmMOjHxG+gQKSaWCKtbuaPioxbEVTnGS5klEYGaVzdQr9r8kMdoRvJTi1+ib0OmuWqr/0iUOxFFp62NLle8OBn5og47sCDXK2xrw2nFAnJ2Na//CjCoFMn1eQdlQUwQZPe4z3ExnLGm25/BCrQ9xc3CPeIJ26US1RwF9kfx3cqFl+xqqgf+P5Zyr7JgW/Sp/tq0B/JeZxzPM6icl9ESOp8us4olXk6RnMFYUpyOaulTPpStMwqGsEQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB4908.namprd15.prod.outlook.com (2603:10b6:303:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 19:49:20 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 19:49:20 +0000
Message-ID: <0327a8d6-6382-d7ad-f2d8-4f13eb3ba99a@fb.com>
Date:   Wed, 24 Aug 2022 12:49:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v6 3/4] bpf: Handle show_fdinfo for the
 parameterized task BPF iterators
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220819220927.3409575-1-kuifeng@fb.com>
 <20220819220927.3409575-4-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220819220927.3409575-4-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a83196f-2d72-4383-ec1f-08da8609bc52
X-MS-TrafficTypeDiagnostic: CO1PR15MB4908:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuAGv/w7UFSJrV/X9S69dfZUJqNTCkR0TshS/g7+c4kkQV4tD4eKgqahS1fOlT4Wt/xxwf3qhyPeWOI8744HianccvVsnkPRbXIz4wYxRGnhOJi3VC5Ys9L6z3p+J+A6Imaypty7npw/rlDei5Zz+1NE3yG9GrF2AW8oqclJA4e8SKgpobRMyFggAFLKaEq9J0aN+BjT7LoTti7N8Zs5HS9GW1vtcXhdUHqafNuzZG0nHI9lfc42muzjFq89ijhG2Se4fQ7cRAt+Tak39GuAqPDJwkdXSsMvzVmTymrSUmD32yOF/E0ZXSEp8ipOqoWrW4xYU772kEHWJ5RFPpSf4p39GK9Gl5PBNxYawatGitg8vLmM2BvCeIl4VwGq9tuleOf8Vdamna2byeNlWXqmhDm2V3AGOCKr1PixZ2SYREz4/8hi667+4AoYIIJaH9Y1boIv4j31egA4f6BXomzDqTJqSuFh8ef1EbT91fPA/ksvIl7TGjrE1ijwHIgMuizfT6yT5AzQnxSoTxl/PiiUG2HIQsPuaQKevVMyHWYiFQETzrrA+6m7FfUNMQ14f66P5/Wv/iYgXKrKA0lp1jXIGtLAprv+PsyEXtlRKMtA4vXX4d9QnmoLJ/E/Vq6L16Vy5AIBNE1GolcTxLQX679WRJjWpFVb9KjQsaRJlTpThH5uE4GncQMy3U5ASwZvT8UQZ31qkW3wWVncyfEPMg9xOlhR9aK9KG0evBAbweohJ+LYSe33FTo2d7us/8kSGQWNar1SLaQDWsD6eBh2CFAs7VT/pVwikjDgo2EvoPyPFms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(366004)(39860400002)(376002)(396003)(66476007)(5660300002)(2906002)(31686004)(186003)(8936002)(66946007)(66556008)(36756003)(8676002)(83380400001)(6486002)(478600001)(6666004)(6636002)(316002)(41300700001)(31696002)(86362001)(6506007)(2616005)(6512007)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WElQaEdlMjJBK1ZMaFpTSHBaMFFKQlo2cFQzbTA0NjZYZ044cTZWdzJYaUZE?=
 =?utf-8?B?Z2EzOEkwcDk3WERDMlAxYVJUdzBlMGlhMFRWVmNwcU1pUmdxT2VEZExwSHdH?=
 =?utf-8?B?UXFTS2svUitiQ092Yi9RN3BRTTFCSmhsSm5MY2YvRGFEaUlQalM2ZzUxUFJV?=
 =?utf-8?B?bWZWY3pjbTRQY3pRRGxESCtZcTlLV2VlOW9WOGRVOHo4MVgzeEh1QTl6cHI4?=
 =?utf-8?B?ZVFFUGtFTk9YeEt1UFp6V1EzWTl5dDN3VTRyWXh2QitLZWNBU0NiYk9VczdR?=
 =?utf-8?B?RHYxY1JQVWJCRG4xTTZpZldDQlMxZTBBRlhFKzhMUlpHeVRubVAzdjlZSHlL?=
 =?utf-8?B?ajZkdFF3QlhDTTBvWmRISXRtUndhYnU2dmhTLzFLTjVMSmlxZzhONk12bTVK?=
 =?utf-8?B?elJSU2lhRkRVVEpKRFJYM0ZqME5ySVgySDd5ZVFFc001Vkc2NU5ESXl5VWZh?=
 =?utf-8?B?SHAvcXdDVnlFVE9KTkhjdkI3cE5RNXN6TEhFVGZYY09mTSs2MXJWNGI1ZExE?=
 =?utf-8?B?MTFZeXA1cmdHNWFFN1dRSVEySThaaFZGZ251UU5IeVhpdkcwU2FkSG00cXFp?=
 =?utf-8?B?TTlrb05mS3RIQml3Yk5EZnJoMStxWkNDTFlKZXE0aHZlamRkUHJTejU4eFFM?=
 =?utf-8?B?T2tuMEpGQWhqSmZ4RE1iNGJ5VVZHdXBuamlGWGtncHZHNGtlWlh6SEFrMkxq?=
 =?utf-8?B?WEtIcjBoMHRLZ3pvNnhrYlNTbXExZUYwYlVpRHpwc29YaHZaelY0ZHdxYlBP?=
 =?utf-8?B?aWVCKzR3N0tCd3hWeGpiMjJHUkh3K2pQREZZUGdla0dXdVo0MCtWUjZrRGpl?=
 =?utf-8?B?RG9ScUtjaVhqSnBVWk8xSVc2UGU0MW5TY2NRaGRnWER4RWVGVWNZZ1ZQb25T?=
 =?utf-8?B?b0JOQUYvU045bkJRenZyQ1ZoUVFlcjhjeW4xQnk3QmhTTHgxQ0VvY2JXUE1w?=
 =?utf-8?B?QTVSK291d2c0T1RKeEk2cThvbEVuL2EvUzFpRHJ4bi9PQ2RCa21TZTMrUXp0?=
 =?utf-8?B?T2VWbjUrTnRkVzlxdUhvZ3JzclI0M212d2U0L2djWG0rLzdNQTB5VnA2Wmo2?=
 =?utf-8?B?Vm42cGViZXB2YUVNei80d0ZrcFR0VnE2QXJvb3VJU281OC9FWVpiVFUvNEQr?=
 =?utf-8?B?TkorSnZqNkEyaGNOMGpYc2R5MlVFekRDdjBoZ3ZsNzNOd2NpOCtkK2lOOVAz?=
 =?utf-8?B?MFo3NmFNZUpyUFFid1hpVldiVEVEd3FoUEFZWVZOR0l1YlMvL2NRRUJBUks2?=
 =?utf-8?B?OS8xOGdFNlRjZ3RHbXlrSmg5WDdmbGgrdWc2S3d0VjJxN3dhbjU5YWlDRERi?=
 =?utf-8?B?eTZBMTZQK3dPbGNCcklva0dQeGFCUFlnSExmbWZ6d1o5MW5SQW9EK3Z2RE9M?=
 =?utf-8?B?MEhVbzNTTjJMOEdjN2I1ZTA0OFExMGwrQjVEcEMxWEUvVXY1NXpFL05iaDBT?=
 =?utf-8?B?b0NhdU9SVDVQaGhiRVROSGZqUHllRG5kWUdTcEFLUXlCTkg5K2VmVnhic1p0?=
 =?utf-8?B?ZHFIaUhXZTRrUkJqWFc0dFRRRE0razRuc3ZzVXJxcDNrYjduRGo1ZEQ3by9k?=
 =?utf-8?B?eFIzK0pST0o4K3VlNkNiTGIvM2ROU1lvUGlIVWlGNWtqSXlzY003SlhkWkky?=
 =?utf-8?B?c2xGaFBrZmtsWVdDU2xXTVg2Y2RCNU92SnE4Tkk1cWhPK2N0b2VVb0pFMUtU?=
 =?utf-8?B?anhiY3czUEYwbHpkRjFvV2JvOHBRMUt4Ykc3WDB0b2NrSDk3WmEzbzd0Yk9C?=
 =?utf-8?B?VjVIV2d6OGFLb3hqUDB4djVQVEErd1ZNaTVXUHVFR0J5eHdMSG5QOVlkWVJk?=
 =?utf-8?B?QlNTUFNZb3RyV2w5aXpjWTZBR0ZDWEtEanNHWkRmc01vOUEybG1WVGtDYk5y?=
 =?utf-8?B?Unk2U203ZGpwb3B2dFRGRFVDb3hUK1k5ZnlrYmV5eUsyS1MycGhXL01BWWh3?=
 =?utf-8?B?N2hEckIvSFNlcFpIZFlvMzZEbG1vaHNTK2syQmRJYXFYdEpZVkg4Q1VHb2tM?=
 =?utf-8?B?T1lRWXY4djZ6alJMcWhUbDcrUTBJWDA2TGZwTWlabWNjVVB1d3JZUkR2N3ZM?=
 =?utf-8?B?UFFiWEFRS042Qk5pN0V5aVNaSS90bmhSOHczRFFZWm9aVzZRdlVuUjlEYWI3?=
 =?utf-8?B?ejBES21ybThoQXE4dkVjQU9Ba1g3TUhoa1FHT0RHMWxiZGQzQlhwTTYyeVds?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a83196f-2d72-4383-ec1f-08da8609bc52
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 19:49:20.0131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pbg1EpaivWgMysnz3ZYqxDUQyxHuN8SbLeC9pJDGi0R7EkEgwaekWn6Yu0cyy19q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4908
X-Proofpoint-GUID: XXWdp9ELg_hcLexRytjmopoTOkqnIgpT
X-Proofpoint-ORIG-GUID: XXWdp9ELg_hcLexRytjmopoTOkqnIgpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_11,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/19/22 3:09 PM, Kui-Feng Lee wrote:
> Show information of iterators in the respective files under
> /proc/<pid>/fdinfo/.

Please show more information about what are dumped in
the commit message.

> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   kernel/bpf/task_iter.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 927b3a1cf354..5303eddb264b 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -611,6 +611,11 @@ static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, struct b
>   	return 0;
>   }
>   
> +static void bpf_iter_task_show_fdinfo(const struct bpf_iter_aux_info *aux, struct seq_file *seq)
> +{
> +	seq_printf(seq, "task_type:\t%d\npid:\t%d\n", aux->task.type, aux->task.pid);

It would be good if we can print either 'tid: <number>' or 'pid: 
<number>' instead of just 'pid: <number>' in all cases.
Also you don't need to print pid if it is 0 (to traverse all tasks).

We should use a string instead of an int for aux->task.type so user 
doesn't need to look at kernel source which they may not have.

> +}
> +
>   static struct bpf_iter_reg task_reg_info = {
>   	.target			= "task",
>   	.attach_target		= bpf_iter_attach_task,
> @@ -622,6 +627,7 @@ static struct bpf_iter_reg task_reg_info = {
>   	},
>   	.seq_info		= &task_seq_info,
>   	.fill_link_info		= bpf_iter_fill_link_info,
> +	.show_fdinfo		= bpf_iter_task_show_fdinfo,
>   };
>   
>   static const struct bpf_iter_seq_info task_file_seq_info = {
> @@ -644,6 +650,7 @@ static struct bpf_iter_reg task_file_reg_info = {
>   	},
>   	.seq_info		= &task_file_seq_info,
>   	.fill_link_info		= bpf_iter_fill_link_info,
> +	.show_fdinfo		= bpf_iter_task_show_fdinfo,
>   };
>   
>   static const struct bpf_iter_seq_info task_vma_seq_info = {
> @@ -666,6 +673,7 @@ static struct bpf_iter_reg task_vma_reg_info = {
>   	},
>   	.seq_info		= &task_vma_seq_info,
>   	.fill_link_info		= bpf_iter_fill_link_info,
> +	.show_fdinfo		= bpf_iter_task_show_fdinfo,
>   };
>   
>   BPF_CALL_5(bpf_find_vma, struct task_struct *, task, u64, start,
