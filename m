Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAB7408353
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 06:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhIMEKE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 00:10:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50416 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229563AbhIMEKD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 00:10:03 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18D3TgNJ003084;
        Sun, 12 Sep 2021 21:08:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CZtbsWF/zyhicuMnwZkqnvFeT50Cv4s+MccIH/RWfFg=;
 b=crOdNvcjISVleq7pi5eAWfc1qkSOqNsM/czYgHDk/HHBkdjA0Od9eIPI0YmSrW6H9NAL
 mitQ1QskgJrWNQ1XkK1nMkpgz/1xGEU10jTIIz/qf1iDOG0SkU7wGz2G6lKgvkIEOIFe
 AFJzgSry4/FScDuxhX8PmGEkApSM91wwidk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1xs1r4g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 12 Sep 2021 21:08:47 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 12 Sep 2021 21:08:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/yZMiFM2gNd1QbywL9Xl3CZZ3SYQCA3S8+C76d4ETz5bCTSVxqY2fV6ZXDW+OHG3jjLh2sDGpR1EwPpFPJikcpmvJniO7PuVdxmG/3nPb/pFiOktTfzdNT0dWxcquXcLs87wB6qH4WCGi5TiybMzezPMfWb1vDoi6aon2ofXk9EhaipjrcaCCDQlc89fnMPakm0rgnKMMaYaShBnkDlvoJbxiFifqD/eV9SpW3OiXuZuM5LWT51cFmfMu1SmZIuDEhaD6e4KSViPBAtAwQ9ejNiznkfWMXS42VenEXiS3GlDSIuyHgK9QXKMp2ECA7UmYyTRqBQqdkY2n2jt7HiSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FirldxBHdtaLnJ5g/jKeSITwzPRFiFXJ8CT7R7xuU/k=;
 b=doZIiRk1SeHQoGYjTN1Vm74sAqvFTP30PbXoNBOWqVOhkfUoOpIxJHP7k0MXW0BjIdUsOi9UweCwGmsu7d8WDsKk7fEbvF+KGccScW/0QayUbPkQ7ORFuhD1GS2PD8u/Gd7blBerSlz6yQidLtDuzYcToF7BE+NLkHXc+VGaEmTm8r9WShk2Os6latOLmV1A0AokDC8S0m9TKC0pa7hkBWvJBz63VkdAGe33698sGbeCksu/rnuw4OhFx3qZKHeCnvorweBx/+KvVZ9WHznnsY6V4CrJgtklHAs0T7/q4gWXQxnjBYqEv6PaeeURXMDcE54OfyCLglj/QUoKBKyz9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4641.namprd15.prod.outlook.com (2603:10b6:806:19c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 04:08:45 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 04:08:45 +0000
Subject: Re: Why does tail call only unwind the current stack frame instead of
 resetting the current stack?
To:     Hsuan-Chi Kuo <hsuanchikuo@gmail.com>, <bpf@vger.kernel.org>
References: <93b37b05-3aab-3e50-bd1b-e97a8d5776f2@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <34d3b670-d49d-c432-892e-c86954cfd761@fb.com>
Date:   Sun, 12 Sep 2021 21:08:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <93b37b05-3aab-3e50-bd1b-e97a8d5776f2@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BYAPR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:40::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21d6::1021] (2620:10d:c090:400::5:941f) by BYAPR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:40::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 04:08:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c033ca1b-5ef4-4e79-a3d7-08d9766c2e27
X-MS-TrafficTypeDiagnostic: SA1PR15MB4641:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4641BE08CFC8FC27DC4B85DFD3D99@SA1PR15MB4641.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w69k5p+esM5KKzoUq4iKcZS2n8K92uy6MEblI97CwLhRlQN/3dagwqYSupsJHESdhRIubFJrNOQfdJbJr4pIcPxbhpQe31JNbuX/cRPzrukzsL/BeBJg4IAnv/OZj6Oy13CEReqF1uD/noeIqJivW9TV+xmkJba1PoqJPu1z9e3NiDS0tc0k611fUdHcaHzZA+h1M5NrF2CwNtXBAO8HefFv06SgOYlOe65hrRGwXvH5sDkywWKdfHYVd3VQS5a4i4+wlVW549bCFLe1reWdNmaDJfyBbeE3gPIrFb6YraL8N/GH3pmmRRuxpe8tO8m8FuBBN7dtTADzqsy74ZrzIl4utwBzNiHMYB2cjD9brH5EaiRwUPsu8apoS8Udho2exPsZFzG9Hmi05freoOEAhYmTMg95Ndfe4R83OY0LY8Oe9s2krieyKWJybexYN7KKnfhvA0GILmxK5Tb6mgoN0tklE/8TLN/kvF49mMr6S5k9DT2V28JZHeloDAE2JWiR2ZZwCrBTCZpUdMhNBVyXkFSqmPwpYNv2FdqfhnAHlwu0tu3CBghlwbPSvmOd51fmGIdOfS1ijnb5RUSK+ar4FIKm11QrlKHz7GmCM0Cd/HJsiwDecKgfwpnGq1Hv4yb4qngVqMa1tT83lNC6mJqWAEMP970WbRyJopqDBdnznvyz96iqMQ++VpinQsNAMPRMMT2gAELG9UPRllI9mimmzUgkdSaYKcwZzXMsA+BXW1ZfVzQGuV5HEXlLgrZayOsRuuKRpZv85PaRFJZq5Zb0YDVdXwblLJanTEgv5HbCcbDruu8CC4eTaXyoSozNX2bP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(478600001)(38100700002)(53546011)(5660300002)(86362001)(36756003)(8676002)(186003)(8936002)(2616005)(6486002)(83380400001)(66556008)(66476007)(52116002)(31686004)(316002)(31696002)(4744005)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGtheWl0WEFmOUJqRFZiV2t0WmdVK1B0Q0ZMRDNQc3diTmNTMTlodVRiK1NU?=
 =?utf-8?B?QmVmUXlWdUcxL1ZlbmorVkZ2RzRvaXdyTzRaQldXcEljZHlEQm45VWJPUi80?=
 =?utf-8?B?S2dUQUdoTDZGdUdxaG9WVERuY0c2cDVjRlVSVHl5OHYvSjBwQUZHYXRPZERq?=
 =?utf-8?B?NFNlZFUxZm9ENzlZUit1a2tQUkVRZGxDN2txeFJsR3U5SllhVStvZU5hZVVj?=
 =?utf-8?B?Yk9ZVTg2QjBsYmxudWpXbzVkMUVPbkRWRHpnTEVpQTlDb1lxbGJQWnRmNmJo?=
 =?utf-8?B?UTFEdG1vQVc4VDFSNU9KQVI2aHQ5TFFyMWxrb2gwSFl3c0xjV3FocG40QXVN?=
 =?utf-8?B?NXp0elpLZGVSRGNNaDFoYTRjV1RBWXhOQXpLSzBmRFZtSzdqeDBDM0xVMUpG?=
 =?utf-8?B?MzVlejRLTHZnTmhZRVBSZm9hZ2Q0a2FGTlJqUlBpSzBiTjNhbWM5YU1WaHlM?=
 =?utf-8?B?bDVnWDdUTVc4NjZFOGVCbkdrZjRMN0VXOHAvZjRrQWhKZnNoMXc2ang5ZVNz?=
 =?utf-8?B?WHF4cU5QVFEzM3MzZ09EbWR5NFg2NllKZmdvN05tN0FnMlA1eXMzbG9tOEVQ?=
 =?utf-8?B?NHZYMXhZVGJoTnpMNmtGekhqdktBT2dkekpQY1plVUlxZzNVZFk3S2hkVVhU?=
 =?utf-8?B?RG1ERnJGOTZHb2RhZEM3MXV2Uy9uQ0k0SUxFY3BhNThoejJTcm55dDF6L0NR?=
 =?utf-8?B?Z2d2YVcxWHVZN2NzNWVmOUV0L2Q1cHpxeW90UnB1V3BOU2xlR3lWUmxBNDgv?=
 =?utf-8?B?a1FOZ2lYNkZGdFppMEtYc25kWXpxaEY1VDdXSi9wOFltK1JvRVN0a2lHMXo0?=
 =?utf-8?B?WWJhOEhIbk5Hd3dhMnI0UzJIaGVIRnBuR2dWM3pNMzhRNXltS1Flb3VHMGVn?=
 =?utf-8?B?REdqWWNoaTFMbnZucGJJWGVrRnNMQ0ppbTUxQlExbEpWMXZJVXNlR3oyanE3?=
 =?utf-8?B?bGR0REhGb2xhc0xhSGxOWFF3UzhDZ2krWnp5cW1ocG54MnRpU2RVQlZlU041?=
 =?utf-8?B?ZndOWVZpUWJXZ2hVVk03M3JUSE8rclhWRHNJMU9OWXNXYjdwelZRaWp1U0lN?=
 =?utf-8?B?UFJqaXN1eHpUMTA1ck9ueGxuVEkyK1J2aVR1NjFDTWgwcTYyU1ozd3hmL3Fr?=
 =?utf-8?B?RlZQV3ErNjhRRmpJVTJuKzlieDlmc3lxVVNBNXZTYjhQUnNCaTkxRXcwd1BQ?=
 =?utf-8?B?TE4rTGhMLytYcS9Xd0VqdlJtTTBweFAza0dUaVNSUGhNQmkvc0FwK0RtdGZY?=
 =?utf-8?B?djlpTFQ0RjhuUnBVcktWMzBlR1JRYmFZK3ZTdHpCWlVJN3UzZlZLRWxoU2Vw?=
 =?utf-8?B?aWhXUHZDZ0ZWR24wcVoxVnYvSm1xWk1hZUV0UUFGcnZzMmlkb2Q0L3dLeHhQ?=
 =?utf-8?B?RGpmVmtvT0VvckhHd29idVJFNXJDZDgxb0VuUkFQdldKTmx1ejN2NG5ldlBq?=
 =?utf-8?B?VjhVa2lTRTlleGprMk5YQWp4WjUvWHJzZkROcE9BK2pjRFpOS0NOSTZpSWE3?=
 =?utf-8?B?aVBPbEZKQWlJSnpRY2Jma01iUHZkdUVSeFExK2JSWDIvQmlibDZCdGRVd2dV?=
 =?utf-8?B?RVJoVUNlRDdQNUFpenQ3enROVVp5VWczb3NXaDhGNHdIVytzUjQyMnMvU2ls?=
 =?utf-8?B?cWNjd0JOeEh0TGluS3JIUVdnNEwzS2dPQk9CRDRQQzdWQ0JGdU5COEJOMkJO?=
 =?utf-8?B?QlAyQ3RYWjc2RlVFSFY0TW55RUJIUitVS2Q1TkJzRXNaWE1xekZlQXB5czg5?=
 =?utf-8?B?ckNNWFR4Ri9GdW1NblMrZDJiNHZxSFB1L3RBWWlpUXFQcjNXWUx6RW9OMVZy?=
 =?utf-8?B?WTNidThBQXFYSGtpVEhhQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c033ca1b-5ef4-4e79-a3d7-08d9766c2e27
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 04:08:45.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1RAOzM3zJuktveVwaEOxSJupriJcX6mj5aNhPKeBoHvOykvoMqkms2blGqWjcs3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4641
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 1aAeBUm8pK38vXcKleiyO2__E7pph_w8
X-Proofpoint-ORIG-GUID: 1aAeBUm8pK38vXcKleiyO2__E7pph_w8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_02,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/12/21 10:48 AM, Hsuan-Chi Kuo wrote:
> Hi,
> 
> The function check_max_stack_depth 
> (https://elixir.bootlin.com/linux/latest/source/kernel/bpf/verifier.c#L3574 
> ) is used to ensure the stack size is no greater than 8KB.
> 
> The stack can only grow over 8KB because of tail calls as they only 
> unwind the current stack frame. I wonder why not make tail call reset 
> the stack since what was on the stack
> 
> will never be used again?

I think this is just an artifact of current implementation.
To do a correct reset of the stack, additional instructions
are needed to keep track and accumulate stack size properly,
so when a tail call is reached, it knows how much stack size
to reset.

Did you hit this limitation? Could you describe your use case
in detail?

> 
> 
> Thanks
> 
