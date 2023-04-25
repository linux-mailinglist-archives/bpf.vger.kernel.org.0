Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD946ED996
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 03:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjDYBIV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 21:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjDYBIO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 21:08:14 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A7AF10;
        Mon, 24 Apr 2023 18:08:00 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OMINvx002052;
        Mon, 24 Apr 2023 18:07:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=paImxJaPQznKAeX+zLYZ/G0R63BRzdoSJHZpJ7ZToXc=;
 b=eWWylpShD2/w0cOBTKQup2KwG8+qhbQSMjfDnbvrceoNDyihxrc8nkJ+/yZ+XxMXvwQZ
 shSnueEXodB/gdZIukW1sHC2RSyJHr9ID2KZ3HVcFjvwDCRr1RvehF45FpHnYMYarJSL
 xALoLcr2A6JPtGqSi1O77TVkNQ40Lkv/lFi/Ls2EUh0HcViGUYlYUOu+9zkH++PcflVZ
 pU1fXkGf0WbC+jJH1DiOmUzjvvFxE7NjcF5p5gBf2fSbGUvtc/LE1vre5iqd97KWZGUz
 fMK4suwmWenrY88U+c5OCcaAeXto1bEM+0VxM9qTfXc3nzude6LQ1Uu+4inndzTCACim cw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q62ekgrte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 18:07:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSzrL6PO7vylOvp56g/QHFPBg/Xgn7NZ8rNyrlt/ro2daDdC+TDBlDO7tCfj0uvHIZ9bWT93woKD0OktSpQFukHq2ZKdOtjbjOH4hE3jPrcsGH/x95rhE8jV1LdPhSmE5IAqVxvfCw/gR1XXtQuriWsoV7KZw4N1pPZJoBkw7q/CqkxDHiXtZr+Eb3qnZnVyoLUKrgjhEc+lhu79mBb+5bYzmY/lzeDcSUSWEk+JGgGtulGT5SVoZGiNs3uwvnGq4sl3UVuzIm9hZtuISQ0+j0zKM7JiDeVFF3jp+KrDuZ+PoaT71OghJHKG+2SXO9aUmCDAIRoG7y3ddWF0j7NF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paImxJaPQznKAeX+zLYZ/G0R63BRzdoSJHZpJ7ZToXc=;
 b=hOGi388obvvQwl7ocscEg/o3EEo8vVLEH2BHGEwLZ3qSvYaAE4T5+8bWo59sYEBu7BrDju4vjxFXtqPHpvgnbSXJ9czXg2nd4D9KvyF/FjMPiyKrufJa2W+bc96pfAg6frOWEmlN4rcOjIw5TaOKU+rw54C4yKIBwzgHumi7KQ6XTE9Qm5eEDCB9v/4gjfiLYKnmspWYgt1Fk1Akqzt4CW/DrxopCL3pQROiMoXjtaaTpj3q5gmPTIBGa5A6SvNBw3IqFi28wiq2KDDwDp75LV6Zscctlf/xeUBlRYRg7M+r+f3syJ6fCkamb/KwSS0EvqKLTV/JGwGA90oJmW/pDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB5902.namprd15.prod.outlook.com (2603:10b6:8:f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 01:07:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 01:07:31 +0000
Message-ID: <8b893118-6687-1d2b-d838-1a0c6ff7d886@meta.com>
Date:   Mon, 24 Apr 2023 18:07:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2] bpftool: Dump map id instead of value for
 map_of_maps types
To:     Xueming Feng <kuro@kuroa.me>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424090935.52707-1-kuro@kuroa.me>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230424090935.52707-1-kuro@kuroa.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bbc5526-775a-45ca-d99d-08db4529720e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MA3tIKyWhiUSLy/y3xo28nYEDfZX9F4g5VGfUk3DZJqv2OXqZ2nbuox0N+CiY3fFWLE6KBLauIR2BAOc6XeyebqKp25fXWr/5isSETR3gZVA59F54OJr+DGKbPtcjkd2SgbZ2LtDaqeSPwiMqlMCafpm6qcvq1mQCINdnwDwrIRfI77aQ9Zx5rDTo2yP03ZAgm41MVgMknIcw/+FPnRDPxIaDp8RI4BzmJ47iH3MI8A2wtSXal4RJCvOFxWOBy0mk5FD+arMPJpHmmB/PXLfSUkkFWL3PoPdhnVGBTow+bvUXem+WRofVB4V8WcnGg4UBjYny0GDIKGTX2v25HsqZa9bnkZ+YzhN8JWP/WLnGUXdG9EMKEU2lVTUtzH1TbhpaWJS41FDYNpt0bbVEZ4ro5Y6FzZEPDQBN4f3cPF5VtsjC0L722h32K8ohYry5Fb5TO7zEimCr9hsxvuUmRKNFYCzm4mUBe6kd9FkEJNLOmDyTokJfrZMLUyQ0Dt/vYuXuQ39DQdb3xFjM6/ceTqVZb0Ga5yNFCEOuqwXaQ8gxtpIbJQG6F21cRaTQV7/hzbhyuI097+BYJgxUt3ldzPYpTfw8UyxOGQtmiyWHCA6TJio+poyvayyp/dv1v4SVdSEFmkb26C7nKKPn2BaY3SIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(2906002)(66476007)(66556008)(66946007)(316002)(4326008)(7416002)(5660300002)(8936002)(8676002)(41300700001)(36756003)(31696002)(86362001)(186003)(6512007)(53546011)(38100700002)(478600001)(6666004)(6486002)(83380400001)(31686004)(2616005)(6506007)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZUckk3ekhlZ1VaMjZOSTA0SVBrVlBjRi83WFBnYnU1amhZUGFFVld5ZUF4?=
 =?utf-8?B?NUZOdlEybng3Znd0REdMQ2doc3VyRTFhdUIvNnFlUEQ0NnJVTXFUN1FuZlhH?=
 =?utf-8?B?eFphNDMwUmVqeklzaVJUdEpLOXlBRTRMb244ZjlINHN5Yk0yeDA0SzFGNml5?=
 =?utf-8?B?a0Q5aGV5Tm9wcjVWem1YenMrR1NiUUlvNTlGZmVGTlB2ZmFCbHdUTjN1OFMv?=
 =?utf-8?B?cVk0UGt3bmpHeWJob2FpQlZwMDdRVVN1Ny9Ja3RZL3BWYnA0bllDWldHa3px?=
 =?utf-8?B?SGlrbHM0RWtScEIvaHlFRzdUR0NyU1N2YVFrcVRsdFdieitLNGdPQXVzclkr?=
 =?utf-8?B?a0VIOWczMHBZMGEvNDlYYURzdEtrcndNUkplL0tiNE9aNEdEcUlhdzZWQTdI?=
 =?utf-8?B?R3Zpd1VLbWErajdXMmRxME9ybnhiMlhCbzh2L3UzeEdWaTZOZGVZTGFRSjUr?=
 =?utf-8?B?Uk04Z3Z1SStJQ3JuL2JjTFFlUnFNMUs3QmxqWWZ6WHRST3VNZWVaV3pTblcv?=
 =?utf-8?B?UnBkbVR6M1RiN3A4b0lPcVhOWGxXZThLeUxlTXBRQzNxcmgveERqVW9UR2I3?=
 =?utf-8?B?Q0p4b2NrMjZlSjd2aHBCUWNuQ3dVRkZ2eDhRc0drRFloSUpCUUxqcHFXdmpw?=
 =?utf-8?B?QmgwZU00eEMwdzRENW9FbWZrZnNrcE1VeFBFYkdGTFhnelJKTXkrdWljeTRM?=
 =?utf-8?B?VC8rNUJYc2RCZGxIK21odnp6VG1TUHBJMjNQS1IxcGNIMG1ELzdJYTBLdVM0?=
 =?utf-8?B?UzA3WVk3Z01IanhkTjRvMWM3ZmpQK1FZOVlyV3h0OXVMa2w3ZWJlOXQ5amow?=
 =?utf-8?B?NUZCdzZMa1FZenQzcStzR2t1UnFHMWVLQ25QVXVKcjRWL09oMC9XWkZwQlo4?=
 =?utf-8?B?bDdHNWs1ZXR5c290RkRxMk5PZnFYVlJRMW5BdUVrZk1DU3c1c2R3ZFdhZERm?=
 =?utf-8?B?TEo2WVY4WWVRT0N1N3NQVVhKR1pNU2NjL3ZJTzczN0IyTThPQjhyN21WYWFl?=
 =?utf-8?B?TW1qQkhDbjZSdFo5SUVBM0R4QWVKQ0J4ZTRpMWFNdXhXdUw0dnFHdzc2R0pK?=
 =?utf-8?B?SWFPMStoaWVGWVYranhqczl3dXNqU1MyVzZBczBlOUNqQ1pHaVFhNldnbHlR?=
 =?utf-8?B?TGcvcWJGK1MxbXJ4aG40cmY3VzFkOEFYT3lwMUJRUXdPd01CQnlpKzUvb0c0?=
 =?utf-8?B?K1lrYW9nWVVRWS9zUTlzdGs5VWU0aHZZVk5JdCs0S2RuYjRXM09tZ1gzOTRq?=
 =?utf-8?B?RmZKUnNJVEpFWHJCN2xDL29taHR4U2hvUlBOVE9sckdRb0hDUjl1WSt2K2pS?=
 =?utf-8?B?aEZuRmFWNXdZclBKZUtWODJ3R1F1TEdLQWJYZUFJMERLc213d0ZVNlNNTmtX?=
 =?utf-8?B?M3g1TG5JZHpuUW4yV3UzSXJRVmNsMTc5OVdOM1JHTHk1NzZwdk05TTQ3Skty?=
 =?utf-8?B?RXZyTjhBeUVWanR1SHZ2bXJPWXlObDBxSHpQT0JhM2REdTJTUmwyYk51eDlq?=
 =?utf-8?B?c2szQ2paRG05WGpzVGMyZXhFaXkxakg3Si93RkV6alZRNHVGb3U0WXRNajJZ?=
 =?utf-8?B?WjA3b3NIT21FYmx4SnJwRGtyYnZMdDBtT3ZpVFd6Q0F3b20rNFQ2bE1uRHl2?=
 =?utf-8?B?d2plSy9TSTQ2UnpTTlRhajZZbFI1M0tFOWVlRFo2TDFCNmJhWlRxVE9GOWRy?=
 =?utf-8?B?bjBaSFBYRlUyeDNSWlhNbkpTZGNQeXJLRElQNXVPMEl3YXZ0dHNtaTVtWlRN?=
 =?utf-8?B?OVNaVm1zTEdXd1p2dFZlYkh4N3NacUJZUTFCTjlkWW8yTVJHY2RmOWtWRlI4?=
 =?utf-8?B?MEFVT0dMaklNN25zWHZWYzRqemIraXFiRE5YVHBMeldOenJOWE0zWTE1UEdR?=
 =?utf-8?B?ZkVCdTFsaVJMRzVPRXR6NUptWHl3eHNIOEFlcTNWbE5qeVhyaGw4OUVqbHNs?=
 =?utf-8?B?YVg3a3c3SWlOc0kvZnIrNEcxUlVLNTlJNlM1ZkN6Z01iYU9iY3pySWNBa09F?=
 =?utf-8?B?VmFLcmllcEV4UTFNSE1kWTVLKzU3VGxoWDRGYlBPcDJsYUY1L09ZOG5LTUYz?=
 =?utf-8?B?UGllR2ZRd1VVd1RVZTdxYjNERitUTXVNRS8rK1E5eTJxdEh5MVFwVW95R0hX?=
 =?utf-8?B?dkQ3cVIzS1hlWTBTKytVSFljRlRmNXBDOElyeG0zaE1FRlVFK0hhOWVwK3E3?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbc5526-775a-45ca-d99d-08db4529720e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 01:07:31.4002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HiDIj6ABf9qHC4bM/37geC6MXdAJA35VzbqcrrQY778FQuHNAJUpFDXailO9RPj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5902
X-Proofpoint-GUID: yo5uIrlis9T_GVRCxefvGO1KT_x7jIYl
X-Proofpoint-ORIG-GUID: yo5uIrlis9T_GVRCxefvGO1KT_x7jIYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_12,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/24/23 2:09 AM, Xueming Feng wrote:
> When using `bpftool map dump` in plain format, it is usually
> more convenient to show the inner map id instead of raw value.
> Changing this behavior would help with quick debugging with
> `bpftool`, without disrupting scripted behavior. Since user
> could dump the inner map with id, and need to convert value.
> 
> Signed-off-by: Xueming Feng <kuro@kuroa.me>
> ---
> Changes in v2:
>    - Fix commit message grammar.
> 	- Change `print_uint` to only print to stdout, make `arg` const, and rename
> 	  `n` to `arg_size`.
>    - Make `print_uint` able to take any size of argument up to `unsigned long`,
> 		and print it as unsigned decimal.
> 
> Thanks for the review and suggestions! I have changed my patch accordingly.
> There is a possibility that `arg_size` is larger than `unsigned long`,
> but previous review suggested that it should be up to the caller function to
> set `arg_size` correctly. So I didn't add check for that, should I?
> 
>   tools/bpf/bpftool/main.c | 15 +++++++++++++++
>   tools/bpf/bpftool/main.h |  1 +
>   tools/bpf/bpftool/map.c  |  9 +++++++--
>   3 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 08d0ac543c67..810c0dc10ecb 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -251,6 +251,21 @@ int detect_common_prefix(const char *arg, ...)
>   	return 0;
>   }
>   
> +void print_uint(const void *arg, unsigned int arg_size)
> +{
> +	const unsigned char *data = arg;
> +	unsigned long val = 0ul;
> +
> +	#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
> +		memcpy(&val, data, arg_size);
> +	#else
> +		memcpy((unsigned char *)&val + sizeof(val) - arg_size,
> +		       data, arg_size);
> +	#endif
> +
> +	fprintf(stdout, "%lu", val);
> +}
> +
>   void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
>   {
>   	unsigned char *data = arg;
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0ef373cef4c7..0de671423431 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
>   
>   bool is_prefix(const char *pfx, const char *str);
>   int detect_common_prefix(const char *arg, ...);
> +void print_uint(const void *arg, unsigned int arg_size);
>   void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
>   void usage(void) __noreturn;
>   
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index aaeb8939e137..f5be4c0564cf 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
>   		}
>   
>   		if (info->value_size) {
> -			printf("value:%c", break_names ? '\n' : ' ');
> -			fprint_hex(stdout, value, info->value_size, " ");
> +			if (map_is_map_of_maps(info->type)) {
> +				printf("id:%c", break_names ? '\n' : ' ');
> +				print_uint(value, info->value_size);

For all map_in_map types, the inner map value size is 32bit int which 
represents a fd (for map creation) and a id (for map info), e.g., in
show_prog_maps() in prog.c. So maybe we can simplify the code as below:
	printf("id: %u", *(unsigned int *)value);


> +			} else {
> +				printf("value:%c", break_names ? '\n' : ' ');
> +				fprint_hex(stdout, value, info->value_size, " ");
> +			}
>   		}
>   
>   		printf("\n");
