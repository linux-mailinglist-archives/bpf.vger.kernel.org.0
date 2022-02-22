Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44F04BF218
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 07:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiBVGZO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 01:25:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBVGZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 01:25:13 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C5F41
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 22:24:49 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21M3mX1w025834;
        Mon, 21 Feb 2022 22:24:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+Pc8JoDv60Mf71PYSYQwHK1GAC9VVzxs9URq8TcqgE8=;
 b=P/1PgM7GlLuJs7gFiLyuYHUBdlEuK+fwpmPZrcz77lwyBIZ5PVHboptfIDIBT+MtaUy6
 PWdI+T9g4Nr1wjnnt7LzjfRy1Y+zpEz9itV/E+0LnfMNnd9PqzBtKeBscu4gHbrKFXyQ
 tJ1urH5oZGeM18U/YtEJuYRDrOLs0Vf4JSs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ec8tk4wxh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Feb 2022 22:24:47 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 22:24:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUiENzyIgrdvTxbcLgyHSC2CePkTZ6I7ItjaoOjJM4rrzXDbXPYBngVhujASmScnMPFqBxqJbkHDFh95yyIIh1/cydwPaEpVRvrT29aEPZyboh3mI6gqaq6D4V7zIhRaAH6KUxJyjrAKFqhOdfz8l5g9t+UK1B8TzUNYDuh9xibEgKIhBX9VpHhhQYxHV38phCDwjwYXQwn9geKr98R5uhmtCCfv2Mg3wjHUD1B27JSPcjFZNUSBNlIHfEUP4rDkifM+OaU1LtT8goDg2zQ7GtkJmHWDDsmOEbDxxRYkpJ1N9VvL4HK1AEGfQbuvAGsJjdr3OcjufPu2/DG4qno0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Pc8JoDv60Mf71PYSYQwHK1GAC9VVzxs9URq8TcqgE8=;
 b=NzimzSwUtF/EvM/YuyfNRkylSzaJImtw6PBw63RzphLd3QhZAVbNUBnlm9hKfDBONbdbwgzed7KENcqxpmkkxFk4z3pJSbSB+ahDeFMXjyd1S2JwN9NDqdUONS2ta+OmxzF3fCYwQonEh+GLhpzNbIUvZI4NHcc4pFlU0jWqAJOj9g6h7hOwowqyzah8npwqdxlrSAiQZ+8jZxc0ePPGotF5vqVjqHGEJRTqEC3+Kozx4PxoVFh4e1FXNeqjafee8C8jB1zOIXrbFBQi9DxERq/ZdgYHOfKfaSx5LtR1Ml/JRtk3ib2Vkhp/mTfOp2OhUOUHR+7w3lMFljuuvUXVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL0PR1501MB2162.namprd15.prod.outlook.com (2603:10b6:207:1e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 22 Feb
 2022 06:24:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 06:24:45 +0000
Message-ID: <565e2bb0-2f42-cbb4-f63a-40723ee16414@fb.com>
Date:   Mon, 21 Feb 2022 22:24:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: How to get the device number of 'bpf_get_ns_current_pid_tgid'
 helper
Content-Language: en-US
To:     Li Qiang <liq3ea@gmail.com>, <bpf@vger.kernel.org>
References: <CAKXe6S+B9+uH3R4qiNx68yZwX32iaAC6g92x7jS9JodNRjaAyg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAKXe6S+B9+uH3R4qiNx68yZwX32iaAC6g92x7jS9JodNRjaAyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0018.namprd13.prod.outlook.com
 (2603:10b6:300:16::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a88db3df-8016-4b4a-3351-08d9f5cc04fb
X-MS-TrafficTypeDiagnostic: BL0PR1501MB2162:EE_
X-Microsoft-Antispam-PRVS: <BL0PR1501MB2162A6D3132621046ABDD3C8D33B9@BL0PR1501MB2162.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scHu6F5ZhLQq1nZ6wWboTX3DMPZnsYng7RUNDalUCD0kbQ8zIqAEok2x+VOKpyIWFU0L8CfIkP291ttT6UfOmXV0AQQ/QKNK6rO39nO+nFYoHGeAwsoaJ3PCuBbHrxY3Fn/sK5OjiKMA3c6uLU4Qyfv49uSfO77FCfutLW+PcDDQJ6cuUayBu0azJ18W2spLBaqK5MypxI2E/KSBIQV8MLLHb1jnMiy0KQeCUu57Iqxv8bkJD5esJV1Z1CAvHSr+GKH5dpwE9TTAk5DR5o+MKvbIwhvehYwxy0n5RP40jFdxJHObXwwNFWiTTSpaBvi6GQfkXCKPvSYz4Qp5r2KGkiOFpxHYc4sOGd/+LKtcwU4g/7rwX5FXVVEamNFekkGizPmjZgY/pZydYO/sYEmh58dQxKZxPMn2z/QAPRqlNxilUHSJpxuHP1aq4hZF2aZEGeKyEzuGJm7jmxy17EyZfkVs42Eirx2ddQFaURIrl7oJEW7Qw3D95M9LMbPzIQKIjhO9sKafy3BriVOQqFqPnYlBiT93Gb3ZQARIMktfufYDuaFTPAqh/5pvCkPsxzunKPkY45waeqXxnyhf3z6J1JP46aAstW8v4M0kQaGM6bY0p1Ds3/P5vnErkn/sBtscdn2bHhiYT1PD3VmfxoAaOgofsMhBZr9N14LIgyCbpf3xvBNRKtAlQANNBO2dTERrMUoOzuyllH1eawWEsOLAQGUrJmO1qvsChC3r0EQS3YPQS9IH3dEjE7+MqdJWkgA1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66946007)(66556008)(66476007)(8676002)(2616005)(186003)(31696002)(86362001)(6486002)(508600001)(36756003)(316002)(6666004)(6512007)(6506007)(52116002)(53546011)(5660300002)(31686004)(2906002)(4744005)(83380400001)(8936002)(15583001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KysydEF2WWFIY2FzZ0hNSGdjS0FLb1FRTGgwbVpUNWhMWDVDbWErS0g2ZWcx?=
 =?utf-8?B?aGNJRjJnY3NZbGwvTGVNdy9icVYwSmtDRFNtQUtoRHBBVDJzV1MrbG9vRnc5?=
 =?utf-8?B?MXhIL3R1OExNY0x5d1lqL1VMRFYwUFM2NXl5ZjRTRFVHaXExVkFyTHpVaXFl?=
 =?utf-8?B?M2Fld0o5cmtnUDNoOG9ZcU11cnZkanJ2Z2Z3RTRyQ2Evc1JKNkl0N0VJUVcv?=
 =?utf-8?B?UWE4NHdwclF3NlZ2OHpmSmxtbzVuKzQ3UURYRUR1OS85eXJrNk5CUkNuRkxz?=
 =?utf-8?B?dWxveXRPcGRaYnd4WmJnQnFNcG13ZlFPL0w0Wm5iVHo1UHBreUgvbFAwem1o?=
 =?utf-8?B?b3dZeWp2VHZsUFczUzQ4bGJXeVk2REo5bFZuVGQ0YUs5VVQvcjJGNEczNmVQ?=
 =?utf-8?B?VHBDM0NlYlRiVDM5dkpka3NWZHd6SWVsOGJlalREdTgyVWhVSTEyQkY4bzlh?=
 =?utf-8?B?NVhocnQyM1NEc0ZBNWJaemVXdzdBMENYWko5ZERYRUROaVowMWVzSXdDWEs1?=
 =?utf-8?B?TWxId1F5V2FIM2hnTUptenN1eXdYN1gxVWd0ZTVicjEyaVFTMHllWWlwVFd3?=
 =?utf-8?B?dmZ5anN5L3V4aDhJS21FN1piWVpYUDc2RjBLbkF2ZmZMQkNvdWprVkVoSFBn?=
 =?utf-8?B?WFBoUlZrUjhaSVFOc3NHNC94bjl3ZytOenh2VVlkbWtZYW5WeWdGNGN2ckIr?=
 =?utf-8?B?V3pMVm1GcGJ6NWpIVmhVU1ZWUDN1bVViZHpyR1BLaStDQ1J4Qm5zMlIzM2JS?=
 =?utf-8?B?OFZLZkNVVVRMQVNKaGRIT1NDZW43Y3hUUythbkJFUVZLYWtsNVpYYThZOHE2?=
 =?utf-8?B?WWwzWWhlYXo3UTJYckdBU0JVYVI1VFFwSndqVUdnNXZxN0xHbFNhMnIzcHBk?=
 =?utf-8?B?NkRXalZydUk3a0V3d1dON1VVd01NdDdPZlZ3S1E2YlkxbzVOc2VmNkx3Ykdq?=
 =?utf-8?B?bGlKV1hSQU1FeThPMm55ZlJEdkdZaEthWkRUSDlrU29UL1gvbHlZYXZVclNV?=
 =?utf-8?B?RGFWVEN2VGNZSlVNRUh1b203VFRYZ1l5TnIydzM2MGZiRWl0aUZtcEJuaXdC?=
 =?utf-8?B?NFVzMThPMmFLR01qTlVVU1JWTlk3Vzhzajc4bTJ3aGQ0R2NhOTF0S0pzQ3lV?=
 =?utf-8?B?V05pMWRaV1ovT2ZoOEphenRnYUxCWUhLU1hHTjZaL2VURko3a0VhbzZNQkJh?=
 =?utf-8?B?c2M5QTNrTW9PM2hWY09UYnZ6UzVSTU5MU2R3cFA5WXhHRVdlZ1lXbVl2aXh5?=
 =?utf-8?B?K29TRFNaYnVxdEpmU0VUMEppNUVYZnZRRmNNbm9HcjZSU1hnYlRvN1kzeVRE?=
 =?utf-8?B?MmFHU1ZuclhiWUFuRW1XYnZPU21mazU0Sjk2MzZoUE5GN09ldFhHdVlOVzRV?=
 =?utf-8?B?dWRxMHEzM2lBSWVRQVVpQUhyYStCTVRtR0UrakUrbWVaNjI3aTBlUlZ6VmVl?=
 =?utf-8?B?M2RyZ0NOUEY3ZThQNU5oSFh4R2dVYS9zcHErMmJtb2RaOGUwT1R0YTRYaS9k?=
 =?utf-8?B?YWtyeXJrbUNMZ2d4SGRGbXBzZjBHcXR1Z21GQjlDemZ6OXFJVlMyeVQrZ3Q0?=
 =?utf-8?B?MHVOTkdaTlpDYWN3YklOdzljeVNodlgzZ0lOb1hKY25kVFEvS1JlUWhBRXJp?=
 =?utf-8?B?eUZZZEMxQUJCS2VJcFg3TnBDVnJwTGVaU2tVblczaEZUM0d2MkFEWXUyZE9L?=
 =?utf-8?B?WDNncThzRDV6di9vSC9YVzlrSzlNa2d2RE0yUlhpWTZwYmhVR2JVL3MyS1VC?=
 =?utf-8?B?S3RiL1FGYTJDRFFOaEtNR0FHT0FSWExZOG9PNFI2TzFOWkNHbnZpcjlxd084?=
 =?utf-8?B?UlJJWjJVR0RWaDdTMTdYSGtueVp1Y0xaRHhkZGh0My9WVDlyck1tZm1mK2xi?=
 =?utf-8?B?ZStJdmY3WEhucHVKbUQyTzVGakJFd1ArTXhCK0ZDaThkWGV4eGExWW9EN0Mx?=
 =?utf-8?B?YzNmWC9vejVWa1MzZzUra0UzQnp2RklSMjNveFp1c0hhclVQNUdxSVduSmlF?=
 =?utf-8?B?SnIwRnV5VFlSVFdEL2t2alh6WnJWNDQxMU5za0liRnB3UTlvMjZrZkppTEJG?=
 =?utf-8?B?MHBwZCtORXpUb21Ld2FrQXFTQWVlMnNvSTBtNDBIeFd4VnZBcW9NWmp6clFq?=
 =?utf-8?Q?ae/WxxQNhgb7maYV5ZQW/kzgz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a88db3df-8016-4b4a-3351-08d9f5cc04fb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 06:24:45.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCXy+1J23aGzxSGEDItzeyqsKfSA8gv4t05XsZstjrIQpsj7tpMWpUC+XYmb7JUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2162
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: QA6BKjHuIotfT51Co1WuPA1hi1HGhJW6
X-Proofpoint-ORIG-GUID: QA6BKjHuIotfT51Co1WuPA1hi1HGhJW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_02,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220036
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/21/22 7:43 PM, Li Qiang wrote:
> Hello all,
> 
> As we know, to call 'bpf_get_ns_current_pid_tgid' helper we need dev
> and inode number. The inode number is quite easy to get by 'ls -lh
> /proc/xx/ns/'. So how can we get the device number easily in practice?
> the kernel test just uses 0 to test.

You can use the following command inside the namespace to
get the dev number and inode number.

$ stat -L /proc/self/ns/pid
   File: /proc/self/ns/pid
   Size: 0               Blocks: 0          IO Block: 4096   regular 
empty file
Device: 4h/4d   Inode: 4026531836  Links: 1
Access: (0444/-r--r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2022-02-21 22:22:48.782383342 -0800
Modify: 2022-02-21 22:22:48.782383342 -0800
Change: 2022-02-21 22:22:48.782383342 -0800
  Birth: -


> 
> Thanks,
> Li Qiang
