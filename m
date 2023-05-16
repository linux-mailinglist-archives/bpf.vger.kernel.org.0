Return-Path: <bpf+bounces-584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBA2704202
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 02:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7A21C20D46
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 00:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE8199;
	Tue, 16 May 2023 00:02:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592B187E
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 00:02:11 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624C2C5
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 17:02:09 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FMkrXb016952;
	Mon, 15 May 2023 17:01:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=tig5njNrz5+gLsI4h5FsCy+6Q+mUDeYb+rI2TbjZQYs=;
 b=n16J/e36J1o+yGzHyRwaBXCOgdm0AE0oj4MwITNYDe/ZJm8XD3DtP7CUVneObs0w9QEl
 oE6v7BoGuLj5LfaHAPn6KjXm2ywA63DDzS8N4YBwM2ziZZS/7sHWlYTRij0WdkJ2mCB+
 XbRJFA2KhYHXQK5d80v/PdLGLnVLVKkVGNJthuZUOcAL1lCKxCPVHREIhOqSSHsEfDXo
 NvgDYfwxQu7ZLE1T13s7LLx4QzjisH0vyS3t7juu1HL2pzjVrron6YyUioHcO4yZV4ng
 1BIsYCKUnnGtFSg5ajXeOYuQonofZT4JiAT/5PSZBZ402Jnq9b9pv/bV63TTUroR1CIS EQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj8cvfm8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 May 2023 17:01:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK+k1FVtHsjosLH6zmAnnXF5U4CalKEnK3vwlJwYamSVu8UakKq4Qi5J9iFezrzHyy39cYl4X/92RzIn5I9bYMJWmG/EJtC4Dah33hSDuRGXqkRh+7vYRxgSkRcoaTDqIgCoyTz0TZuryLc82uVF4bOFkbfGpsDYKwlsHLOHuXMTbsnCC5GAmHUkzyJfDwyxTzVbga+OG4O1XN0Sy07tV6f93b+FLxITL+bJVO/oF/VU2NX944Fxis0nvYiJtMbfIkIIUFoP7TFFcuuo/oJVf9lz0Tad3N6mvcTlM1OzZsxt87wpj7/rcBqwuOjrcXXld/6QZnsez+9HWN170DoIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tig5njNrz5+gLsI4h5FsCy+6Q+mUDeYb+rI2TbjZQYs=;
 b=JtG0LOg0S7HMKTbXrd6yaW8O5uEZlERFfoweKmy3qzcIkynmoEbHQUvD4CWk/bLVF4dJZ9UYzsYh5qFGIKoEHCjolcuujf96+3iXumC9Oz6mU5I+22QRrXV4xw1BxZE+/tE1Mfiifq9hmwuTTv41KZ+owMgr4Tdu0PnxDeRceYYlsW4muI8RVc4FlVYzLykBjjBdVP0WIwT1TE5HUQx0POSeA0gn+gBl439JSbjuMiuL8jFlz/r/GuQg0fFz8gLy5+xeF+jzCtSr0xw06VKLIJPYYLaHJ1q4xrz1R15tQw6FUJMcXO+ZDbYQJ2TZNuThvWX9q4zrR1/0dfvvQhfrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB4009.namprd15.prod.outlook.com (2603:10b6:303:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 00:01:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 00:01:51 +0000
Message-ID: <e47459b1-d67e-4d29-d270-1fa160d4d4da@meta.com>
Date: Mon, 15 May 2023 17:01:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf] samples/bpf: use canonical fallthrough pseudo-keyword
 in hbm.c
Content-Language: en-US
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20230515200207.2541162-1-andrii@kernel.org>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230515200207.2541162-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB4009:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1347c2-391b-471e-1954-08db55a0c094
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tn9zjoWDcESbIeRbThWPFVT5dHx+RtV0H9TgsFmBbRocKXLyfH+28cb8W17mu39g3dfrKakt0lKMZraNcguuQZD9va0Nc+UcTFb0zst6NprXM+/FwBceUvc5aqqwRVeAvL54sPdckMmtrei6utUYAj1gjBaRdT/3kaSyqky8cqeRsXazJDzItANeb5tKToC3tjWq31biw0OqCP1bjMAiMk6Ast+sNdLBpMMlrLTxRQN4zbDsGIfqDW/4YssJBzLMu8Fwq9jZS7dUMcRCjuua94YJRPbNqqMKHxH+SMD941w1wuuUXpVfJ2Mpd5+MO6t6mtrIyQLhe9miDzhq8rFbCp/bzIxF+gBv5u7i92SovbalCL/G9ISG1aGF0Yk5CfRDzSZnobfwK6palWh63Iju9DQRaXrnOkM80VmE+zy7jhcPVBby/UxlpnRG6ENQn0mvORYCWcqQeWGRSRujUrz6EAYXg0N4urY88tIRriijF/2w3IP1bgAhGRx5/lFNupo8tmWYtUEVhL5gpkcDeoMGWmWATuNvID4hDwNISXw4cZ4zZQ95AyA9q0ztY3XfclqvbwAoEu5NO8RKNTOat+rRCyB5GO/D5tKTiV0vr1pSy0A5Sj7W2V1tJlv2sZ4Uv8oyv0J8IA+s98UcWIuYlUXifw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199021)(31686004)(4744005)(2906002)(966005)(6666004)(478600001)(66946007)(6486002)(66556008)(316002)(4326008)(66476007)(2616005)(53546011)(36756003)(38100700002)(86362001)(8676002)(6512007)(31696002)(8936002)(41300700001)(5660300002)(83380400001)(186003)(107886003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?alFudjJlbWtNVzMrK283TTRMdlBtZ1VwNEJtaERrTkZnU0NCYnhQYXliOU1T?=
 =?utf-8?B?OUF5NUVsbUsyTEpQUVljSm94eHRnTCtUZUpFcXlyY2ZtZllEUU4zTXhzNnVi?=
 =?utf-8?B?QTg2amhoZzlXOXZzTlkzN2dBZURYbDZkREQvYWpWWkg0bUg4SmVVNlcvOGo5?=
 =?utf-8?B?R0RkV3greEFiVWlaM1M0SzlUbHNzWnp3MmIxUEU5c3I4bXEvcWFlVy9GaTlE?=
 =?utf-8?B?aFFENzBNT3A2cHVybzZEQzNuanJtRVBHc1hBeE1YQWN0RXZkMEVrcFBSQSsy?=
 =?utf-8?B?ekJRWWl4KzlxbWJIVTNhNWphbzdnZkFoL1QxSjBBTXIrQUEwaXVmMnZUZmpq?=
 =?utf-8?B?Ukk2UDhMbjJrNWhqRmdOSXhXU3hqUGpPOHBNeHZ3TWxweGNxMk1ObSsyQmJl?=
 =?utf-8?B?MERra0hnNGVmSHZXUmZuS1puaEdGYm5JYXRUVS9kdDdzS0ZhNkowK2d6T0ta?=
 =?utf-8?B?clpQUE54OGJiTnBHU1Z4aVIvcGZOMzArT3NSZWNJYjVpa1dNZmVNQWJrRXFT?=
 =?utf-8?B?dWVlSFhFNmtEbHB2aGFvenVoRGVQZzFlQXNFTkQrUGgrSGR5UHBhcVNqdEtw?=
 =?utf-8?B?Q0FEWm5TMGZOQnIwQVl6VjgzVENNcldZZVl1b3NoektzUHkwUEJocWJlQ2Zv?=
 =?utf-8?B?WnFmYkNDdEkxM3B5N0xSdmtCR05nbFc4N1Z4dm9sOERERmo0ZTlUU0FMb3FB?=
 =?utf-8?B?QTNXc2V2ZWJVY3d1RnM2bWwzQ2JHSFlMUUV1TXVjM0VMUkdqSnhwTFl1QWRv?=
 =?utf-8?B?RVptN29KNTN2M1YzU1dJeWczUlZoSjdIMjRZWktoNVA2NndtTWlORHI3dGwv?=
 =?utf-8?B?MW11WlNsczd1QUQxNit6bWc1TEFCbmpYK1JTUlJ2UDQrUmlVUThqaEUyc0Rh?=
 =?utf-8?B?aEQxV0hOaitkdkFhc1cwV29HbVFtdUtMN0N1T3hxNER5QXdzbTFPcG9iV2dK?=
 =?utf-8?B?RXN6MVRnV2Vzd3o4Ui9jeXNDUjJYY3YwOVdReEVML29na1hFTTlzbFVCYmRj?=
 =?utf-8?B?OVRBclBIVDdNeFVneHI3Uml4bmUvVUhPUWlRaEQ1cXF6QnpyS1FQTmdpQ2NV?=
 =?utf-8?B?M3kwRDJYb1hsT2xHSWNMMmlmazFLeGdBS25ZV1M1T01JSzJkYnlIRzVFKzNl?=
 =?utf-8?B?NGZxQ0VjVks1TENic3A4d3NNdWgxaEo1Skg0SEJpSlRMQkxSNlErS252ODJ2?=
 =?utf-8?B?TlBua053SU9wWUUrTndyMm5wVFNWbzZrc1F6alhGRjJkOTRqN2RoQXBxbWVI?=
 =?utf-8?B?T08vSSsreTBXKzhreU0rdGkyN0x5bXlJSmFOeWxpTlVCKzBnOXphWlZqdkFy?=
 =?utf-8?B?V254MlJzN25WU3ZHRHlOdEw1MXAwUVVrS0RwektVOFBCb0lvR1VVa3FtM01S?=
 =?utf-8?B?bDJKUmxmeDN6Y3VrZ1htYkl2ZjIrVlNGL1pnQjgvSTJTV3BzV2hHdG4rRk5s?=
 =?utf-8?B?QUNKVHEzRmFBM3pBZG9zTHlsVFZXUFRXWmxqaUxMYTlEWXo0Rm1RaVBNR29Z?=
 =?utf-8?B?ZlllQzhjOXN3YjNWVUdhMzNCcUFmZmhONk9iVVl2Rlo0Wit6Qi9BbU5jTEkr?=
 =?utf-8?B?SDZCbzg5MHNDakdaRHkxOVFQa1d1SUZaUVVLOHgrU0RSZXhIb3AwUFhZb2tT?=
 =?utf-8?B?bTNSd0hEZTZxaUg3azNxWEVyL3pybm9jQjIzd3pjcGM0ZS9xMXRQV3VSOEhm?=
 =?utf-8?B?eW1Xb29zVDg5QkJmQnc0Y2U4OEd6NGpQbGU0dFZWSlNubStyL3A5a2pzNjFR?=
 =?utf-8?B?N2NFd2Y1RndQV1RzY1ZML2FZbW5lVlRPRXM4RVpjbW1CbnVhN1JGc0Z4Z2Jt?=
 =?utf-8?B?NCtuOTZVdUg2R3hYZkNrUCtzT21DaHJHMCtQOVlTZ3NkbDFrNVZyZXAzQmpO?=
 =?utf-8?B?eHJack1vUWNzN0ZkU0J0WExxbG9yV0Y5U3ozVDEyQU1lcHJONkdEWHNrNEht?=
 =?utf-8?B?MklKRGI2Z1o4NnBGUURyUmgzanlmcENMd0pFTlhFUzJBTGtNZm9taTVaKy9Z?=
 =?utf-8?B?Rm9USFdtRS9Xc2FRVmNTZlh6WERxdTFrdnQ2ZWxnZ1dJV2ppUVM4bmRFN0VV?=
 =?utf-8?B?a05XTEhtUnRtYTRrUHRTdEtvVm5DU05MYmpBSGJzRDFBQ2hnZzFLUm9Qc3Bk?=
 =?utf-8?B?MnduTTBicUlWTjBOb2JGYmcyeU5tY3hBN0FwSldONTZFWEZreVZVbXhlYklZ?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1347c2-391b-471e-1954-08db55a0c094
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 00:01:51.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ufeVGzknlHV2OIyePnub1S9yycfirWDqpZVWLCxliXvdVFHes8aSQZINgCb2VYi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4009
X-Proofpoint-GUID: amO3-CvL5faQoy0UkkKXQ_n2UEyWVbrO
X-Proofpoint-ORIG-GUID: amO3-CvL5faQoy0UkkKXQ_n2UEyWVbrO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_20,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/15/23 1:02 PM, Andrii Nakryiko wrote:
> Rename now unsupported __fallthrough into fallthrough ([0]) in
> samples/bpf/hbm.c to fix samples/bpf compilation.
> 
>    [0] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

LGTM. But there is an alternative, see below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   samples/bpf/hbm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
> index 6448b7826107..7ddf25e9d098 100644
> --- a/samples/bpf/hbm.c
> +++ b/samples/bpf/hbm.c
> @@ -498,7 +498,7 @@ int main(int argc, char **argv)
>   					"Option -%c requires an argument.\n\n",
>   					optopt);
>   		case 'h':
> -			__fallthrough;
> +			fallthrough;

We could remove this 'fallthrough' completely since there is
no code under case 'h'.

>   		default:
>   			Usage();
>   			return 0;

