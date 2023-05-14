Return-Path: <bpf+bounces-483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD872701E51
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 18:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62092810A6
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 16:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA26A749C;
	Sun, 14 May 2023 16:58:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6001117
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 16:58:40 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D799730C1
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 09:58:37 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34EGg5sP032608;
	Sun, 14 May 2023 09:58:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=pMxUPy5Yz347PuiSgPJITx7dJNjHiIY63SkZebnk/SU=;
 b=cF5b2WWc9T0Ma6Co8nkkSCSvFhd28VRIX/PM+jeRXrcwhAIIctUZcIajL5ZIrp09l1pC
 3KVWvvPVBwr6SXmvb3d7CW71TzsZ7SwlZyfn6fU+mP6nvNvGuCaqKDuqoAX5rNNoAf9B
 KrEAB81GeDjcKdkNgS1hlHSjzm/Lvt00s9ZZ6p9U3+LHiTiRlVktlbZyVX9TWqa0OQ0x
 tbOBn2sxiDp7OLGA6fxzWYyeGDJd/JyIoQ5Evc/mTyuGbxMCzRJe0BifZl1Yxs4n3Dhm
 Vvlkw0lrG/fnBYXCq/GVgTbYC86SfbBoBRZ+SjUBkMRK/Sqbp7RiLyi/377j8ZTpcVIy 9g== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj5vqy1vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 May 2023 09:58:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c86rfUarOvLi92B+mfo/EDFMbBaaXquMVrfUSkOMBWkCs2NHrrUR7z0lkk9oedfgF0Zr4tDwcmvIcP8191h+nRfQfXQhes6k6pkI0c5D4p+Y2TaMwOkSb4r3b1Sx0u1vwWzlXMY8QkyGemXXMs427rAeURm3H9x+PrG4j24e3sX0gNxslrcAxrEt4iHaSPp8rKn2tJzCgHVXSPQRRFLwlt/3gM8spwri18PjdC7VVhXMZGU5P2Q9/puP1l0iEzA5tHD2TMjNP5CF1vFXyESA4FxzgpsBKtbi3AHTL6HeM1gJBsjmnsCkugWIOZNmZ7rG0NcxMwHRWc2RRnBTMVoF6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re0qJRXFAsUF7dCRgw+XliG9CUCJJBwxcTScBzIFvRg=;
 b=OCjHJkg5eWlWvZYC8QU89PRv1kNwfDVI6Eial0XA+eiejoQcuo78/0zvignG3+Lf7LjhLmYTfj+rWFYUNxbUT3MJ3G3PQJbBnX3elyE95WH/XZWgAXVY4Lhav4CUj5xsF61C85H3SPDeYBJ0//Z2LbjGnp43oe+avEbGW6EAhhXrwRzVDh2VM6ePFI0cq3BWGD/b9JVygjh9I8Lgc2KYI5aSxCmz/TyFpJF0S0ORk2hLxUhA11TbdZdiL82wczuroCN2tQ576Af4XlIYM2FcHrgyr/aMct40HPTEcg48kY8Z7rT+9M6R0QUHhX16zBMJuidD2ax+UXez1d8JOw5zRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3870.namprd15.prod.outlook.com (2603:10b6:806:8a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 16:58:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 16:58:29 +0000
Message-ID: <d275bd5e-e468-c590-9a10-8230a9ad7daa@meta.com>
Date: Sun, 14 May 2023 09:58:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: selftest sock_fields failed on s390x with latest llvm17
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@meta.com>,
        Manu Bretelle <chantr4@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>
References: <e7f2c5e8-a50c-198d-8f95-388165f1e4fd@meta.com>
 <daf235c37af3790f7dd7c1b2089617d49fad7b6e.camel@linux.ibm.com>
 <47d0a6958657890d84dbd944782603175268b340.camel@linux.ibm.com>
 <8376a6d2-a3bc-4742-254f-a05605002c30@meta.com>
 <75f39027fe1889cd69d01d439d558418cbd020a1.camel@linux.ibm.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <75f39027fe1889cd69d01d439d558418cbd020a1.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB3870:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7cbe0e-a3cd-4109-8fb4-08db549c711e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b30Pbu0X5et5CQLBTq85FKa53JjCgGDVDCqYZyx8p+tdTCrsrB1FADELWz1/3Q4ixu/HzPao//lVM3UDn9WkKs2NCNGKypu+WITjzlPriL/YoYtRozOMn6DYsrhtcFNz76vi6EfO4pxi6lfQ+3Z59l5y8qJZl8RGEYImD3ijgQJjQTuT2JzIM0n1lmKPeAmxCm4pyH82s4tD/EbmcRCKPaV/E//UKtrebWYspZi+u4PYxcStwGaaImZUA7czw5GxtMMSvQL796LcJrBZDGpnr+V077giTgrAX4uSnbI86XGEbvN6tWGm+qQFiyfIMJ4m3BAVMk2vAQ5DEuZLKeHyc7QRLnuv+9/9g49hioGKILz7y+kArKw7Iho3ghtmKxdFmz1e/+sJnONF74Kj5HXYlWUwqeXNtlCFuSu0Gv7XFfh8zkylkgVpB+m5CtSpMe0VQ+ZqVo5n3S5aXhl8iStjXHl2iKyKX+v8t4iI02uYSpdgfhj0TzeASZu71+EdUx+ocqwmOZ+ZIurxnIqnpFE/ghgzfbhqcW0tK3LygjnssoBvoIrtI9g4EmrQExkncN5mjzEbfaTIe5KhaY4TUs14rbMB/Wc4g93O+Evt2f2NYAzW20M3ls7KtU1aVAYdu65ScpShnt6IMzHB3ZDcIMPGjA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(38100700002)(2616005)(186003)(53546011)(83380400001)(2906002)(30864003)(6506007)(6512007)(5660300002)(41300700001)(8676002)(8936002)(36756003)(6486002)(31696002)(478600001)(966005)(6666004)(66476007)(66556008)(66946007)(54906003)(316002)(4326008)(6916009)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YjJlWXY5YXQwRGJSSEpjTnlMVVNQcytnbklhZktsVTF6bHFaTGRIN1JZcVAx?=
 =?utf-8?B?TkNwejFidkNOYVJ2Qm9uZmJpemUzakt3MFN5SDdkYlNTYlM0Q1JhRUlMNGVJ?=
 =?utf-8?B?NktLVGR1OW42YVMyd3BGcVFZMXNEOG1WL3pPTEdDMEV5ZHhyN1daZ3JVcXBV?=
 =?utf-8?B?eVBrTnJUMW5qZEx4VWRQNnJxaVpUN1ZKRm5UQWdjVnhoaE5YcGtqN29NNzdl?=
 =?utf-8?B?Z1pLYnN2bnhYdmxvU0ZUeXNrc0lPUWxBVkZwQ3RreTc0ZWVSakZaa2JsMTBI?=
 =?utf-8?B?TStzTTJ6eWV0NGFLSjQxMXFDc2g3MFJqemNBWjA2OHdTOHdVUlozczVxdUhJ?=
 =?utf-8?B?dlBad0hIcUJkbmJ4TmlhalVWN1B1aGpNQXdTamRvdDc4U1FtVkI3VzZQVGNH?=
 =?utf-8?B?bFl4M0VWSjQ3UFh0bzNqL1I1THkyVVhSODRGYUg1REVZa3VTR0tiMGdwdXQv?=
 =?utf-8?B?bWlDdktuVmhhZzE2MDJRSkZaSVozcXU3bXVGNDlSN2dhZFA3amlqUTg2empU?=
 =?utf-8?B?dGMwRURmTUo2cWxtd202Q0VkQ1JsNDBteWZFdm9HZGt4bjZ5SDBYdWdCaG1M?=
 =?utf-8?B?NWcwL0VrdTEzVFM2dnpzTTVKdDVmanZ4cXdGRzMyV25aTWNZc2V1dWdHaG9K?=
 =?utf-8?B?Y0QwekpKejNyVENzcnZOdjhYVlJKRWZzR0hLcy8vbTBNYmYyOTY4ZzJOZXp4?=
 =?utf-8?B?T29TcEtyd1QxTHlKRHQreWpZaTN6TlJMY0xvSGdtdGxCN0JVeGVURGpxV2NK?=
 =?utf-8?B?YXdZZ213VWJwTWJKdENDRjk1Wm1QZ01MSnNSd2pQYkhzRGhxcFNhbjJLM0Qw?=
 =?utf-8?B?YWl6WVdvdVFUcm9IN0tTSE5lb1FzSnN3VW9ZWWZCODN5MUJaMFBQcTNjSFNi?=
 =?utf-8?B?b1FrY29CdXhDTHNXT2Z0VktCVGhMR1BocmN0U0Uzengrd0dSTmxxek96SCtw?=
 =?utf-8?B?cTJVczFxMldpa1pnMWYweExSRkkydHJYS3BzWEk1RXZVbWZabksxMm9VYnRD?=
 =?utf-8?B?czBNZTF2SlpsdFJDenNneHErOG9vNjBudFlxcExrQTRaTHpHelU0SEZQVUd6?=
 =?utf-8?B?YTJwVmxlcGhDVmV6QkFIa1BmV2R0eG5wWkFjK0dHVXpvSzY0dnNOMmJVbWxI?=
 =?utf-8?B?emJSRmxxYzlLOVBsNE56TmZOU0V3SDRaYW02enhxaFRsVEgwQ05xOUJZczNq?=
 =?utf-8?B?Z0lBUEVYMGtrODI2cEE4TTNzK0xrc2dNVDkwTWEvSkpMaVczS08zWXNKTXFz?=
 =?utf-8?B?cXZLZVBZVHN6cjhyaVVnbVg1aFpiNy94NEF4YW8vSFRaS2NjYmNjL0o3eXZk?=
 =?utf-8?B?Ung4R3kyN3V4K3ZpcHFXR2lSZkZoTkZrVWxTU3FkMGRyMmlzMmRVY2RRWDVO?=
 =?utf-8?B?a2tNWGJvWjIxQlhUOWUrZGZGbWNiRFU0OFZIUzV1OHoxUGlrTEhQTlUybngw?=
 =?utf-8?B?RUhieklTb3N2WU04N2pnU0xSWHhSSVNIM3lORnpzNWd6czRsZTlMUEN2SmVr?=
 =?utf-8?B?cU90TXZBeldYNlgyVHlMWWhPSWlRWCtLcEJSYmdXWmtBWWs4bnFrM3lkcTMv?=
 =?utf-8?B?TXJ6TFloT1o3R29LTXoxTG1ZeGRtek1wcmhmcTV5ZlVDUUVCT2pPcVF4a2dJ?=
 =?utf-8?B?VFdtSStTZklpcllXL1IzaVA5REp2bXBQcWxHKzBKa213RU8ycUg5M250NXV6?=
 =?utf-8?B?VVlHN1luM1NlYllUbmY4RmsvdWR4czJCUVJYUUMvam1mMXFqRTRpdGZjYlBX?=
 =?utf-8?B?WWhZK1p4UENLb0dsQnYyOEJFUEM1UXlFVGI2TU9jNU0vQXY4RnI1RmFSUUZ4?=
 =?utf-8?B?eUo1bVVoMExrMU9jck9US2ZGOFc1ZUhITFNxWWVMczY2dGFpS1QxOUtmV1NQ?=
 =?utf-8?B?L1dLcndsR2FGanY0YnIyMXVjY2NVZmtkU2EyRS8vT1ZNcE5XdjJIUFYwMmtD?=
 =?utf-8?B?ZUhMY1RNV2pVLzJKalVLMmZDMHFUaDUxNEVSYnVlUkFYNTVBb2lmOWQvNTVO?=
 =?utf-8?B?UXhVN1FmUTdZaGRFcE1tdWNNcmZGd09UMmcyVXVpRjR1R21XK3VlNC9SbjQy?=
 =?utf-8?B?MWFmYnppSlFkTjhXNERqN1R0cVNWaDJIMGExSkFTemZjRFF2OTVISmlyWWZR?=
 =?utf-8?B?ckUrR2ZmVnZRb3JPTmVMZldxQkdnYXVjYmh0aERvb3VQZmJBakhmQ09pL1Fm?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7cbe0e-a3cd-4109-8fb4-08db549c711e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 16:58:29.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lppwlkuyRWpPXEqVXSKQm+nsjf6oU1OHOwcAh+cz6wLZu2KRQG5SSLKMqeafUgAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3870
X-Proofpoint-ORIG-GUID: RFpNnHLxr1RDR7V-rDhnomXEP1nRyEf-
X-Proofpoint-GUID: RFpNnHLxr1RDR7V-rDhnomXEP1nRyEf-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_12,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/13/23 1:24 AM, Ilya Leoshkevich wrote:
> On Fri, 2023-05-12 at 21:13 -0700, Yonghong Song wrote:
>>
>>
>> On 5/12/23 7:40 AM, Ilya Leoshkevich wrote:
>>> On Wed, 2023-05-03 at 21:46 +0200, Ilya Leoshkevich wrote:
>>>> On Wed, 2023-05-03 at 12:35 -0700, Yonghong Song wrote:
>>>>> Hi, Ilya,
>>>>>
>>>>> BPF CI ([1]) detected a s390x failure when bpf program is
>>>>> compiled
>>>>> with
>>>>> latest llvm17 on bpf-next branch. To reproduce the issue, just
>>>>> run
>>>>> normal './test_progs -j'. The failure log looks like below:
>>>>>
>>>>> Notice: Success: 341/3015, Skipped: 29, Failed: 1
>>>>> Error: #191 sock_fields
>>>>>      Error: #191 sock_fields
>>>>>      create_netns:PASS:create netns 0 nsec
>>>>>      create_netns:PASS:bring up lo 0 nsec
>>>>>     
>>>>> serial_test_sock_fields:PASS:test_sock_fields__open_and_load 0
>>>>> nsec
>>>>>     
>>>>> serial_test_sock_fields:PASS:attach_cgroup(egress_read_sock_fie
>>>>> lds)
>>>>> 0
>>>>> nsec
>>>>>     
>>>>> serial_test_sock_fields:PASS:attach_cgroup(ingress_read_sock_fi
>>>>> elds
>>>>> )
>>>>> 0 nsec
>>>>>      serial_test_sock_fields:PASS:attach_cgroup(read_sk_dst_port
>>>>> 0
>>>>> nsec
>>>>>      test:PASS:getsockname(listen_fd) 0 nsec
>>>>>      test:PASS:getsockname(cli_fd) 0 nsec
>>>>>      test:PASS:accept(listen_fd) 0 nsec
>>>>>      init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt_fd)
>>>>> 0
>>>>> nsec
>>>>>     
>>>>> init_sk_storage:PASS:bpf_map_update_elem(sk_pkt_out_cnt10_fd) 0
>>>>> nsec
>>>>>      test:PASS:send(accept_fd) 0 nsec
>>>>>      test:PASS:recv(cli_fd) 0 nsec
>>>>>      test:PASS:send(accept_fd) 0 nsec
>>>>>      test:PASS:recv(cli_fd) 0 nsec
>>>>>      test:PASS:recv(accept_fd) for fin 0 nsec
>>>>>      test:PASS:recv(cli_fd) for fin 0 nsec
>>>>>     
>>>>> check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cnt,
>>>>> &accept_fd) 0 nsec
>>>>>     
>>>>> check_sk_pkt_out_cnt:PASS:bpf_map_lookup_elem(sk_pkt_out_cnt,
>>>>> &cli_fd) 0 nsec
>>>>>      check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0 nsec
>>>>>      check_result:PASS:bpf_map_lookup_elem(linum_map_fd) 0 nsec
>>>>>      check_result:PASS:bpf_map_lookup_elem(linum_map_fd,
>>>>> READ_SK_DST_PORT_IDX) 0 nsec
>>>>>      check_result:FAIL:failure in read_sk_dst_port on line
>>>>> unexpected
>>>>> failure in read_sk_dst_port on line: actual 297 != expected 0
>>>>>      listen_sk: state:10 bound_dev_if:0 family:10 type:1
>>>>> protocol:6
>>>>> mark:0
>>>>> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
>>>>> src_port:51966 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:0(::)
>>>>> dst_port:0
>>>>>      srv_sk: state:9 bound_dev_if:0 family:10 type:1 protocol:6
>>>>> mark:0
>>>>> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
>>>>> src_port:51966 dst_ip4:7f000006(127.0.0.6) dst_ip6:0:0:0:1(::1)
>>>>> dst_port:38030
>>>>>      cli_sk: state:5 bound_dev_if:0 family:10 type:1 protocol:6
>>>>> mark:0
>>>>> priority:0 src_ip4:7f000006(127.0.0.6) src_ip6:0:0:0:1(::1)
>>>>> src_port:38030 dst_ip4:0(0.0.0.0) dst_ip6:0:0:0:1(::1)
>>>>> dst_port:51966
>>>>>      listen_tp: snd_cwnd:10 srtt_us:0 rtt_min:4294967295
>>>>> snd_ssthresh:2147483647 rcv_nxt:0 snd_nxt:0 snd:una:0
>>>>> mss_cache:536
>>>>> ecn_flags:0 rate_delivered:0 rate_interval_us:0 packets_out:0
>>>>> retrans_out:0 total_retrans:0 segs_in:0 data_segs_in:0
>>>>> segs_out:0
>>>>> data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:0
>>>>> bytes_acked:0
>>>>>      srv_tp: snd_cwnd:10 srtt_us:3904 rtt_min:272
>>>>> snd_ssthresh:2147483647
>>>>> rcv_nxt:648617715 snd_nxt:4218065810 snd:una:4218065810
>>>>> mss_cache:32768
>>>>> ecn_flags:0 rate_delivered:1 rate_interval_us:272 packets_out:0
>>>>> retrans_out:0 total_retrans:0 segs_in:5 data_segs_in:0
>>>>> segs_out:3
>>>>> data_segs_out:2 lost_out:0 sacked_out:0 bytes_received:1
>>>>> bytes_acked:22
>>>>>      cli_tp: snd_cwnd:10 srtt_us:6035 rtt_min:730
>>>>> snd_ssthresh:2147483647
>>>>> rcv_nxt:4218065811 snd_nxt:648617715 snd:una:648617715
>>>>> mss_cache:32768
>>>>> ecn_flags:0 rate_delivered:1 rate_interval_us:925 packets_out:0
>>>>> retrans_out:0 total_retrans:0 segs_in:4 data_segs_in:2
>>>>> segs_out:6
>>>>> data_segs_out:0 lost_out:0 sacked_out:0 bytes_received:23
>>>>> bytes_acked:2
>>>>>      check_result:PASS:listen_sk 0 nsec
>>>>>      check_result:PASS:srv_sk 0 nsec
>>>>>      check_result:PASS:srv_tp 0 nsec
>>>>>
>>>>> If bpf program is compiled with llvm16, the test passed
>>>>> according
>>>>> to
>>>>> a CI run.
>>>>>
>>>>> I don't have s390x environment to debug this. Could you help
>>>>> debug
>>>>> it?
>>>>>
>>>>> Thanks!
>>>>>
>>>>>      [1]
>>>>> https://github.com/kernel-patches/vmtest/actions/runs/4866851496/jobs/8679080985?pr=224#step:6:7645
>>>>
>>>>
>>>> Hi,
>>>>
>>>> thank for letting me know.
>>>> I will look into this.
>>>>
>>>> Best regards,
>>>> Ilya
>>>
>>> In the meantime the issue was fixed by:
>>>
>>> commit 141be5c062ecf22bd287afffd310e8ac4711444a
>>> Author: Shoaib Meenai <smeenai@fb.com>
>>> Date:   Fri May 5 14:18:12 2023 -0700
>>>
>>>       Revert "Reland [Pipeline] Don't limit ArgumentPromotion to -
>>> O3"
>>>       
>>>       This reverts commit 6f29d1adf29820daae9ea7a01ae2588b67735b9e.
>>>       
>>>       https://reviews.llvm.org/D149768   is causing size regressions
>>> for -
>>> Oz
>>>       with FullLTO, and I'm reverting that one while investigating.
>>> This
>>>       commit depends on that one, so it needs to be reverted as
>>> well.
>>
>> The transformtion "Don't limit ArgumentPromotion to -O3" is
>> temporarily
>> reverted. But it could be reverted again once the issue is resolved.
>> So it is a good idea to resolve the issue in the kernel.
>>
>>>
>>> But looking at the codegen differences:
>>>
>>> $ diff -u <(sed -e s/[0-9]*://g pass.s) <(sed -e s/[0-9]*://g
>>> fail.s)
>>>
>>> -pass.o:        file format elf64-bpf
>>> +fail.o:        file format elf64-bpf
>>>
>>> -00000000000002c8 <sk_dst_port__load_half>
>>> -       69 11 00 30 00 00 00 00 r1 = *(u16 *)(r1 + 48)
>>> +00000000000002c0 <sk_dst_port__load_half>
>>> +       54 10 00 00 00 00 ff ff w1 &= 65535
>>>           b4 00 00 00 00 00 00 01 w0 = 1
>>>           16 10 00 01 00 00 ca fe if w1 == 51966 goto +1 <LBB6_2>
>>>           b4 00 00 00 00 00 00 00 w0 = 0
>>>
>>> This is what ArgumentPromotion is supposed to do, so that's okay so
>>> far. However, further down below we have:
>>>
>>>    Disassembly of section cgroup_skb/egress:
>>>
>>> -       bf 16 00 00 00 00 00 00 r1 = r6
>>> +       61 76 00 30 00 00 00 00 r7 = *(u32 *)(r6 + 48)
>>> +       bc 17 00 00 00 00 00 00 w1 = w7
>>>           85 01 00 00 00 00 00 53 call sk_dst_port__load_word
>>>
>>> ...
>>>
>>> -       bf 16 00 00 00 00 00 00 r1 = r6
>>> +       74 70 00 00 00 00 00 10 w7 >>= 16
>>> +       bc 17 00 00 00 00 00 00 w1 = w7
>>>           85 01 00 00 00 00 00 57 call sk_dst_port__load_half
>>>
>>> so there is no 16-bit load anymore, instead, the result from the
>>> earlier 32-bit load is reused. However, on BE these kinds of loads
>>> for this particular field are not consistent at the moment - see
>>> [1]
>>> and the previous discussions.
>>>
>>> De-facto we have the following results:
>>>
>>> - int load: 0x0000cafe
>>> - short load: 0xcafe
>>
>> So 'De-facto' means the above is the expected result.
>>
>>>
>>> On a consistent BE we should have rather had:
>>>
>>> - int load: 0x0000cafe
>>> - short load: 0
>>
>> What does 'consistent BE' mean here? Does it mean the expected
>> result from the source code itself?
> 
> I should not have called the de-facto example "BE" at all: it's rather
> "mixed endianness" or "weird endianness" or something along these
> lines.
> 
> On "consistent BE" or simply "BE" properties like
> 
> *(uint32_t *)p = (*(uint16_t *)p << 16) | *(uint16_t *)(p + 2);
> 
> hold. This is currently not the case for bpf_sock.dst_port.
> 
> We compile with -mbig-endian, so we promise to the compiler that the
> machine is big-endian, and the compiler expects the above to hold for
> any p. Unfortunately when p points to bpf_sock.dst_port, this is not
> the case.

If I understand correctly, *(uint32_t *)p to get the bpf_sock.dst_port
is for backward compatibility. But the real u32 read by compiler will
do (*(uint16_t *)p << 16) | *(uint16_t *)(p + 2) which is not the
same as expected *(uint32_t *)p so we have problem here.

> 
> The property above is important for the correctness of the load/store
> tearing transformations. What we have here is not exactly tearing, but
> is quite close.
> 
>>> Clang, of course, expects a consistent BE and optimizes around
>>> that.
>>>
>>> This was a conscious tradeoff Jakub and I have agreed on in order
>>> to
>>> keep the quirky behavior from the past. Given what's happening with
>>> Clang now, I wonder if it would be worth revisiting it in the name
>>> of
>>> consistency?
>>
>> If I understand correctly, I think the issue is
>>       r7 = *(u32 *)(r6 + 48)
>>       w7 >= 16
>>       w1 = w7
>>
>> after verifier, it is changed to
>>      r7 = *(u16 *)(r6 + <kernel offset>)
>>      w7 >= 16
>>      w1 = w7
>>
>> and the result after verifier rewrite is completely wrong.
>> Is it right?
> 
> No, the verifier rewrite is correct.
> The sk_dst_port__load_word() part of the test succeeds.
> 
> All these rewrites already work fine, they are correct and consistent.
> It's really just bpf_sock.dst_port that is special.
> 
>> If this is the case, during verifier rewrite, if it is
>> big endian, say the user intends to load 4 bytes (from uapi header)
>> while the kernel field is 2 bytes, in such cases, kernel
>> can still pretend to generate 4-byte load. For example,
>> for the above example, the code after verification could be:
>>      r7 = *(u16 *)(r6 + <kernel offset>)
>>      r7 <= 16
>>      w7 >= 16
>>      w1 = w7
>>
>> Hopefully, we won't have many such cases. Does this work?
> 
> This would break the sk_dst_port__load_word() part of the test.

This is a hack. This may work for this specific u16 case, but
yes, it won't work for u32 load case.

> 
> 
> 
> Above I asked whether we can resolve the inconsistency, but I thought
> about it and I don't see a way of doing it without breaking the ABI,
> which is at worst unacceptable, and at best a last resort measure.
> 
> What do you think about marking bpf_sock.dst_port volatile? volatile
> should prevent tearing and similar optimizations, with which we have a
> problem here.
> 
> We could also add a comment warning users not to cast away this
> volatile due to the quirk we have. And then we should adjust the test
> (making all casts volatile) to comply with this new warning.

I did a little study on this. The main problem here for
static __noinline bool sk_dst_port__load_half(struct bpf_sock *sk)
{
         __u16 *half = (__u16 *)&sk->dst_port;
         return half[0] == bpf_htons(0xcafe);
}

Through some cross-function optimization by ArgumentPromotion
optimization, the compiler does:
    /* the below shared by sk_dst_port__load_word
     * and sk_dst_port__load_half
     */
    __u32 *word = (__u32 *)&sk->dst_port;
    __u32 word_val = word[0];

    /* the below is for sk_dst_port__load_half only */
    __u16 half_val = word_val >> 16;

    ... half_val passed into sk_dst_port__load_half ...
    return half_val == bpf_htons(0xcafe);

Here, 'word_val = word[0]' is replaced by 2-byte load
by the verifier and this caused the trouble for later
sk_dst_port__load_half().

I don't have a good solution here. The issue is exposed
as we have both u16 and u32 load for &sk->dst_port and
the compiler did some optimization with this.

I would say this is an extreme corner case and we can just
fix in the source code like below:

diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c 
b/tools/testing/selftests/bpf/progs/test_sock_fields.c
index bbad3c2d9aa5..39c975786720 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -265,7 +265,10 @@ static __noinline bool 
sk_dst_port__load_word(struct bpf_sock *sk)

  static __noinline bool sk_dst_port__load_half(struct bpf_sock *sk)
  {
-       __u16 *half = (__u16 *)&sk->dst_port;
+       __u16 *half;
+
+       asm volatile ("");
+       half  = (__u16 *)&sk->dst_port;
         return half[0] == bpf_htons(0xcafe);
  }

Could you try whether the above workaround works or not?
If we want the code to be future proof for potential
cross-func optimization for these noinline functions, we
can add similar asm codes to all of
bool sk_dst_port__load_{word, half, byte}.


> 
>>> [1]
>>> https://lore.kernel.org/bpf/20220317113920.1068535-5-jakub@cloudflare.com

