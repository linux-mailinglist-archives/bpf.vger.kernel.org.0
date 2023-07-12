Return-Path: <bpf+bounces-4842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7CF7501DC
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 10:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793652819A4
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 08:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D121100A5;
	Wed, 12 Jul 2023 08:40:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE84638
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 08:40:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE949B1;
	Wed, 12 Jul 2023 01:40:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Id55VkIh+uDP3OMXPyoleB32UNhFXsfvXs8JWNCb6lfSsKjldlA1Xs2xAc6XihcnNtH60Wm4HA3cNMGhK+z3wwc6H8Tiv6SdSgaObfn9BarwpBpnKhTd3ZGwcRIz6/qMgVTk/j+W5F8rkjtPSIdaMEdQLZla7WPtLK7RwavslahzKTumRn5ByvLV4H2wJq0D2NrKyMpaWVyG/2/P3EESklvrWbbSF/jfP40Bq5FKqB5BfLfMx66rtdoHbZPAf7FaKglt7+Oo4Vlp+VA8vrLM1/4LbbnUwJzWzgwV0R9cNm98DaIEKfChiG0LX9tyPt0uoe2T5thpQnVQ7/4s2YNzog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8Nd6nPjgytuJzUI3dLBMwDMZwAG6InuReonRMu34mY=;
 b=gqzaskzTJ6Gfrlp+ABah4w4pJdHvtbuhTAbrLEjzEU8x/nLV/x+GqBr4PbgufQvYOhjOCS5rPqQwHlmmh7l2wSnz3zrLV7w9D8WCSySOXdYPAZfpBYmIe53ZvNIJBxAPGTyXvQr3aYWXMWaDxgRqs0CDl1TqKYi8NZS6r7pjiF/Ml7vn9SAkVcCkD/W9w705bZeqgkJWLX0ZQZ+iH5UczOarAydQvuEklteuruUhhMzwBiysNWudvAp8lNwiWP5Toxq5n1EvIeK4/50CofcnyWvxZb4KKIoQmbLchV80ylbF5MvTqXpbg04DljHwh7Q1VawzOB4QYKd/I1xhjwsHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8Nd6nPjgytuJzUI3dLBMwDMZwAG6InuReonRMu34mY=;
 b=Om9/vYWtGRpGvTKhp5e+uWjfsj1jm6Shu9DBsDQEYup1f/KoLGP9KseY1CHG+UBmZmUqkZu4C7g5NlnN7aaX3rngNrxx6uZy1Ex2ZJImn8ekTmINyv/YSXQNmhYa+kVlLvQYJchEGP3RoINMuYnub/qxZ23GPweaX+d7jQNQq2hXdJD7llQ5F8gJowMIT2NPRtM20NFRHVNNpNSZuh+dIX0Azq+rXeMloS5cI5ojNXW67l6rPmmKxqu+jCvm0QOgx8v3ZebAKmFuCCOIy4LVmgPNFaXfBIwRKcCTuaTHR39Kd8sblBahASfGbCE0qXucLYqE3f67Wn+mjfXeuft8cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22; Wed, 12 Jul 2023 08:40:36 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::55cf:c134:4296:5ec1]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::55cf:c134:4296:5ec1%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 08:40:36 +0000
Message-ID: <5fa8c14d-50c7-ec0f-79d1-ac0c1c6cb8eb@nvidia.com>
Date: Wed, 12 Jul 2023 11:40:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH bpf-next] libbpf: only reset sec_def handler when
 necessary
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org, acme@kernel.org
References: <20230707231156.1711948-1-andrii@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230707231156.1711948-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cfda7d6-832d-4b84-a249-08db82b3a9cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1hMNkn3KkHnwosf8lKhGgO6BN9LjCcKYwm+TTx0ct8T7mE72IPlofDD3laLbhWmu1lGgoDJkky4Q+WBRGjc0VMsW3WIeJ9Jeh468z1gsOYdnC5SI0NYOeLF+lur76xd/2LgMA+CXTAOu1U8pyeWCh452Sl9EyMo//sIJh363gpsKfZKtz1KLpOjg0Di661RYzlckbX0cpH/45lUG0S4PbZC8mizgTZIeS9zYU9APDDkc04rWW+iYjT42IfOyZP7a7BdHjjmdLnTyJFKGUM61M+OYv/qS9AJC2L3VSaRSGCuYwXE9EGWAtmMG6/y6/uuD/z9pMs9LnMjojDTrJ6GM/HIaDASDhhIyHk7XCAjgOifvB2XT5Cm9Puy6PkKDg9D1UE+Btfp9fYNX40nKgho0XDH93bsNAd4e/eboj02R5zLwW+17OLqrFvvO0waWRzcp/VmhiqDthtArDA2GnWjISUllcQclwF3DHE2jkxkk/0gBMpYWO8cfkeX5xD4wKLcRa46Jrzf4upWS5jVqrbm3y5gG9FETWn4H0WtJeGWfcQDpKjvWrR5proUHk+Ab/f+5Sp++6+6umL7fL+74rjz6a6CMMhAF5L3JynLOF4n5vp55id3ibNHeHVQzNMzKBV0LNNY/oBvv+FnEw8+tcvLuT4NT4ekP6ni4bnx06MPqJGI2B5lWFSWFNxfpXyOfFE87
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(41300700001)(8936002)(8676002)(6486002)(6666004)(2906002)(31686004)(316002)(5660300002)(4326008)(66946007)(66556008)(66476007)(6512007)(966005)(36756003)(478600001)(31696002)(186003)(86362001)(38100700002)(83380400001)(53546011)(6506007)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzBjMXJpUVoyYzBWd0s4TzJQeUtNNlNlbG9ET2FlbnRjOU9EekRtQ2xvakNu?=
 =?utf-8?B?V3ExQVMrVmhhWDFZcENkcTZpQ3VPQk9rQW80bWRVOHJWT2pzRzNqT3lnYjBl?=
 =?utf-8?B?SnVGcHhtTXFreUhYdFZmclRQS0pIcDI3MUdYQXZaU3U4L1E2V2t4aExNSHI4?=
 =?utf-8?B?eEZFeFBmc2ZXQkFvWnNNYnJkN2FhUXRHdGhzdjBzOWxQVTdPU3FRdkFja1NY?=
 =?utf-8?B?c1RLQ0N5U0tiUkZzc3JwZ09ZN01seVpmc1BKSEx4RnROdEVGZk5ldzRaTlEy?=
 =?utf-8?B?cjd2TUQ1VFJxeTJxTXFVYkFNcUJDaW9tUHp0Qytudi93T0tOVUxWVFpNRS9K?=
 =?utf-8?B?VzQrcUJaaGp1N1orNU9ZWG9IZVFuRjhvWGpSTkVmd053dlRwRHc0WkVBWWlS?=
 =?utf-8?B?ME0wUmQ3RmdmZXZNQWprbCtUNUFTYjZOck12b0QvMHdBbWM2SzNxeDNIU2dh?=
 =?utf-8?B?aXRaM2NFaUoydWcxdEh6N2sxM0JLSWtGbHF2cUFDUE50Qzl2RFI4WWpkVU5t?=
 =?utf-8?B?K2RjSFk3ZnJ3QytpaDNxRk16WjQ2U05LbGhaSW5kM0Y0QmVIQTdObStjN0tG?=
 =?utf-8?B?R2g2THZSNS80Wm9XUGFkQ2htNHdQUjBUNXozdDJKZnBRVVZycmpjb3BMZ1hu?=
 =?utf-8?B?dlFKUkhMWGpXdnByUnk3UjMrcXZyekdmUDdPODBZVzFWNXFsZHk2Qy9VWmhl?=
 =?utf-8?B?Nm1SdjhhLzNSTFJ2SXNRZHFVZllvTE40ZmNtTHIrY3ZDcjJUOGJHNEN3blBu?=
 =?utf-8?B?L0I2bUJZK1U2QTFZREdTbXBjUXRhbTdyMStBVzVGRjk1RncrbmNPYW0vNDJH?=
 =?utf-8?B?dmRNcGZvZjlSWllLUVF5eTBBY21hQTdXN0txY1ptNHk4UTRCRXM2dEdwWllU?=
 =?utf-8?B?MDFnRGtVb3huZHdVTTYvalN5ZXIvWTFkTWV2d2NLUGNBSXV2RS9YdEFYZ2hV?=
 =?utf-8?B?MHd2eFk0QkZPajhTUEp4K05SdkZ5Qnd3STZyQnhZS0p2bVNSSGp0ZkhpYXE3?=
 =?utf-8?B?M0ZSWXJYaGNJTDlJZlBTSVFXQjdlL1pLRU9VR3dqYlVvNi8xb2VHTWFxYnFF?=
 =?utf-8?B?ZVNXNHFKSlM3MXpWcFcrUHI0L1FiQWtjbGRyV0d5dzhwb2pUR2w4MVZ0cis2?=
 =?utf-8?B?UnZvbjZGeDdqWGduRytVbjN6eDBsSkhEZVpKbnJTczliRmQyd2xoSWdOM0Q3?=
 =?utf-8?B?aEd6Y21LOWxMaWJrMnNpODJXaHdDNnlJeExGYSs2bHJpL3RuYnBUSGJaTzNi?=
 =?utf-8?B?OWVnaHdPcGxuVlZDSlBUS1lIVVE5TGhrd2YvL2RxRnkxSENxanUwSjNRTzVP?=
 =?utf-8?B?dDFZSHkzK2pyUjBvRFJkUVRReHF3RG9TZjBXY21KVExnRjRpdlZGOUR2WmRv?=
 =?utf-8?B?OG9ibFl5eUw0USs2RGc5enUvMWhvVkc0VlJHM2paU1MzSkZnRjNDSy84a0hj?=
 =?utf-8?B?b3ZCdzN0cXVIY1d3MG40ZCtrZkJzMUlrMnlESXd5TkxpYlh4aUZ2Y25wc05X?=
 =?utf-8?B?RVlWaFhzaFA1L1JJYlVrZ0hmQWFOdjVEK29PMkk0d0F0K3NXWGEvSUF4V3lp?=
 =?utf-8?B?eXdVcVA3SlhuUld5aVpiWUhsUStpR04wVHNtLzNoRDhnZU1HTzlEcHBYYzV1?=
 =?utf-8?B?N3pDYzZSdTA0bXlMdTNlL0wvc1lrLzlLRjk1MVRQTVpOVHhQZVl5UFl1cFlx?=
 =?utf-8?B?WFVKaXZJN081WjRKVVNJZ0lWYkhUZEpObFFvYnRxSWYwUXI0UVZ1TUg4ZC9U?=
 =?utf-8?B?RlRXaGNGNmx0d25zRGRGaVF3aThRZmo1bDFMVGVxM0d3dUY0NERhdk1ybHpD?=
 =?utf-8?B?QmhsekdiUThKd2RXL3hDWGZvV0ErVGNFdFFFWnBpZ0k0SkQ2Vkg2K1hncFg1?=
 =?utf-8?B?cE1ZM25wVFlUOEdYZDlKZTlaa3ZISDBVQzk4QndtOG5KQjNSZEV6N2Z0dW1a?=
 =?utf-8?B?MHhNUTk0ckFDNEV4NWt0dXdJc09pUDFHVHMwVU9TdTdTVkpSL2N2M2VxNUU3?=
 =?utf-8?B?ZVVCdWNHc3pGUUNjUysxRHZPemVhRUVhVUN0aFBWNDlLeUsvemtoMDB2Z25W?=
 =?utf-8?B?QVVBTXJxQ0Q0cndrVnArRVNKa2lyc0l1a05Tdi9JZFVERFVXVnFQdFIyR2xE?=
 =?utf-8?Q?O/HfTucLcwu2Gqx5NNryqW72f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cfda7d6-832d-4b84-a249-08db82b3a9cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 08:40:36.5084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICSzuFJwmZKPIZNAvpXvk6hpvDp3PalBLuj+LvO4OK9oZF1vroCeqZ9GRR5ybsh3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/07/2023 2:11, Andrii Nakryiko wrote:
> Don't reset recorded sec_def handler unconditionally on
> bpf_program__set_type(). There are two situations where this is wrong.
> 
> First, if the program type didn't actually change. In that case original
> SEC handler should work just fine.
> 
> Second, catch-all custom SEC handler is supposed to work with any BPF
> program type and SEC() annotation, so it also doesn't make sense to
> reset that.
> 
> This patch fixes both issues. This was reported recently in the context
> of breaking perf tool, which uses custom catch-all handler for fancy BPF
> prologue generation logic. This patch should fix the issue.
> 
>   [0] https://lore.kernel.org/linux-perf-users/ab865e6d-06c5-078e-e404-7f90686db50d@amd.com/
> 
> Fixes: d6e6286a12e7 ("libbpf: disassociate section handler on explicit bpf_program__set_type() call")
> Reported-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

FWIW, the cited commit broke multibuffer xdp programs (the frags
prog_flags wasn't passed from userspace), this commit fixed the issue.

Thanks Andrii!

