Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921B3576592
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiGOQxm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 12:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiGOQxl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 12:53:41 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF724B8E
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 09:53:39 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGHFMm008184;
        Fri, 15 Jul 2022 09:53:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9YDjlZh6rvfFoGMCF49Gh4HmR8099IzEqlw0NulcDZs=;
 b=LqeAk0c15WTtbXC0MCI8bdBfwA+tW9LnnqyAhQjxXNZibZwawXbOmd2zX3WM50GwG+Qn
 6jWVrbhYQC9cVQIQnMBicKZsihmKwaNYz0LwnSqeX0oEzINN6FfSNUdLvOBhfhcmd/H0
 ZVLfo5FWxug71dX/wYzqxov/30VjF8rExgk= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3haxdg42mm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 09:53:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4RQ7wO4vrwJYr1fwOaOQfPJxHrasVk5c3UGuAn/clUg/DGg6Se+QoRMSPoiU2JuP6SPQ8X0WF6ZCvjm/O4uKNEk11PtJIO1ZOEO4V2xQHI6+nE9Sqn2coPevqvKRDWkS6LMLtU1LHLUxeqO3R6ru43wGUgNCSzVA+Kj4wqMMTVo+F6bBNyHPnXaPVdTV4XniQ4Hy8e8hD9MZEvHwrTf/FlCgWrBpEJAEz488eHtoihpulINqR1xFNJK70WwU+FzSM90IrGNhJqdXQxRN6BDDsUVtA5YipQUK4LeRrypzoy5spaF4sXkJPENAMbBxjnPEfGMCpmIoVM5CcnRoASCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YDjlZh6rvfFoGMCF49Gh4HmR8099IzEqlw0NulcDZs=;
 b=Mn9AmGXwfNpBrTPPcOqxS3kFZ4vyBhRhGHGMa104A8oF4cI04CVdZbScRRXtdWHDvQ+++E9mhKmDJwafYVW65ccKQ9dORD3ERrJqRP5A+XuuGCANg1pByAzMZiWfFzWKzDzufNVuSLk5D5fuOUjVMFdKuLggB2Pta7R0dpcX01xOvGc5D1LxW3j0pp5Pu6e6SNZhTtolfPYaaZY8EEhlrj4OEOn00t3LitQAP5BdleGXNl7/DqAhHaYYuOvwZy921RzK4ZQHYLu8+5GQeH7sSuT9C1HpgVSkZidiJuJcbb6I1HflESwuHTak6FZYlOSjl96H8xdwqFZqV0kvTx+ijg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4509.namprd15.prod.outlook.com (2603:10b6:510:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Fri, 15 Jul
 2022 16:53:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 16:53:23 +0000
Message-ID: <57ec7256-f8e6-35ca-4dfe-0f4908d0afd9@fb.com>
Date:   Fri, 15 Jul 2022 09:53:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH bpf-next v3 0/1] libbpf: perfbuf expose ring buffer
Content-Language: en-US
To:     Jon Doron <arilou@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
Cc:     Jon Doron <jond@wiz.io>
References: <20220715141835.93513-1-arilou@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220715141835.93513-1-arilou@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dfbb36e-82e8-478f-d8bb-08da66828772
X-MS-TrafficTypeDiagnostic: PH0PR15MB4509:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zEQeSXQzB99hRGFjFZ8MRSgPu9bEbEETF1YQr34FzAsqEUbsD6U4qSRF+eY/gjlniGKbLMt1mD8glQ2XCkGed4q1N9yi3ibkHnEF65mwhZgjoo8vWfcNpiI/3ongMDls1byUPq/JSyBkiYat6jZesn5n1Y03HJ130D3UWKINlY/F3vjnqfL3l2pt2IhfC4B2qHK8YIrHVdMYQDKQ6l/UlSnr6Y8WZvTNN8UESVYzIZ1CUBnUm3tnuji8c5fuCfneWN42z/RHejtBcfMhqUUKKQCGeQ9BP2o5IeHTa6FyGjUY/aSs0LV+0AhOT/ZbpTSSoYskU0OHhKZU2pXqRzaZrUtRiQu451XaAa+BwT0XgZMAV/BBNVo48kh5tYlqj4D3JeGNW3B5rl+O6MwpTfX12ZedWEKH1vkVQUr5eoBl9Q/DtRem+l6XoJkenlhG21O2E2vlt6zM7GNdQderDAZJV244LgmbUCghlJOEqUZ6+4xoVqCTK5uI60ZhnbnGSG29a6RmoVmZxAesqGntL1WbcpGZYd4V9/jqGPVsfo5inER2CNcdxArPtWdujOrwiEfaaDGb2ypre/W4cbp5O327C+9jynyIsiZobPl5KMnDyH+Ewd+47JH8B0Noi2J1l40DE20FtlPJwfPFreYCE5kNmTR/sSQBwaHhOu6+9tEKpfw0weXBtG4uZl+inZpamtGtZMDv7jkJmRGbCnEYQvb27WOfX3CmiixitctJGHQoN+JRoEymrX6lyJhP26tUh8TORmvKogGi8XxgM2CmE7bzWW8zWthu9ywsTWAAaCwVU44faUTXbUNiP3awY3jkZO5yN1VzXpY5YP7m1OLEbw9lJrjpEBTBBt+dBIdNV0Wp8nM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(86362001)(31696002)(478600001)(5660300002)(8936002)(6486002)(316002)(38100700002)(36756003)(8676002)(66476007)(66946007)(66556008)(41300700001)(4326008)(186003)(83380400001)(6506007)(53546011)(2616005)(6512007)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RURwMVdGVzUwOXBMdm1FQzVLZEgzY082c3VHczB0TzFWVGVmc29ZK1hrUC9K?=
 =?utf-8?B?MEEzQ2NtaEVoRFBJUVpHYWNrdElOMjJMaVZkeVEzVmRFY01JZkRNOUFBVEd4?=
 =?utf-8?B?K3pkUDF0Z2tRc3hUc2QwTmRsa3ZjSk9pRk83TEV6My85OHNZLzhmQ3NvSVZl?=
 =?utf-8?B?V2VuYktDWVBNSG42OXdNMzVOK2NaNUNnNk8vMnMrdjFWNDhtekpkc1RJK1BZ?=
 =?utf-8?B?MEpEaHBrd2JGVmVYc0ZDMXdEMHdMS3E2QW1sWk9mVFp1ZmptVStTYU93QnZK?=
 =?utf-8?B?OWkweG5Ua0xSMHBxY2ZBbmI5QllWTHQxMCs3SkU5ZEhtMFRBa2QzajZUanlq?=
 =?utf-8?B?RXhFTzFHK0NobWhqLzYrWFlva2pzaVFZUVFNcTV2V1ZYKy9WSHdDRzA2Y2hG?=
 =?utf-8?B?NUJMdldMM2pHaTdrTE55K0llS0tJcExYWjdZaGd2N295UTNYUWNFT2kvQzZk?=
 =?utf-8?B?d1UrY2IvNXRsdnVnaGp4d01lWFJLMCtUN1NhbEtsSFh2ZzlvcXZKaU9mMFkw?=
 =?utf-8?B?U1FsYUd1OFcyUTNvdkRad3hMMUlHQkt2SEJzT2NUeGdPOVRmMkxuY2ZFNTBK?=
 =?utf-8?B?U3czMXh0MzZsSlEyMDdHbXhKd2tONHpxNUJhNEI5MGZuWS9PQUNtNUwzeEtT?=
 =?utf-8?B?VzhzRnVCa3hVTTh5M0F1elNKZzNJQ1lNWkh6UnljazdmQjROVHJid0hCUjNC?=
 =?utf-8?B?bS95R0NHbVRyUnd5K3B2Skx1UXlIU1dsSFFmbXRuL0lWSUhkRFIvWlhXSFRP?=
 =?utf-8?B?Q0RVNG55b3BiV1Jkb3ZITHJWVTY5eis4QithVmtJZzZ1aENscXA4ZUxURmdR?=
 =?utf-8?B?d1MrbUUzQitkalFCWkJwVGxpVXhiUUNHa2gyOXJtNXV5MnllN3dVNUdhb1V5?=
 =?utf-8?B?ck5JNDdxdGJiSXZmRjZCQkoxTzZqMTN4U0hLVGYwZ0N2Wi9xMk45SjRTNS9Q?=
 =?utf-8?B?TUp5QWF6eHcvQVZ2WU9ndkg1RFc3cnl2d1lBNUxTdStaRk55NFdUMjhYN1NM?=
 =?utf-8?B?d01rUGE1anEzeWhBZjBnbkVvTzQ1YkJpcEJaMk9hR1EyTG9kMk1HVy9nRmRv?=
 =?utf-8?B?NEZZZ3FYYytjNTRCenN5ZmFJV1BROG9IZ1lLZG1halk5aGZ4M09uYVNwRXVM?=
 =?utf-8?B?ZnZCelRESEExYWQ4eWhDSjFVeEExejVwSENoUG14SkIrL2RQQUdzVjFjSHFC?=
 =?utf-8?B?eHRvK081ajRaeWJaMXV2QUxvN0JKMHFlWXNtbDBiaUNPSmJ2Mi9mR0d0TDhY?=
 =?utf-8?B?WnZETURiVGFtZ3ZSdHpESDJ4SGFjelN6Q2llTFY1d2NRMGVSLzVoRkMvYmtC?=
 =?utf-8?B?eWhBNTFIZlNLckNqQmlmR1ppNms0ZCtKNk53R1lUdUFydEhMd2ttVFpYS3JQ?=
 =?utf-8?B?aFc3QXNuTnZTdTF5c21DdHFENjBDZVpOZlk4cHB6Y01qNmJqaGdQY2YzdXBR?=
 =?utf-8?B?NHFrV3JxVHBnSDR3TDd4dXp1a0IyaTMyUG1Gak1iUS9Ma2RvV1I2TzZzVzJ2?=
 =?utf-8?B?YzBUSm1TWkZmTDh0QnRUUDJsMVlMeDYxOGkwMm5tdGNqOGNaZDdwcWpHTVdE?=
 =?utf-8?B?ZlA0dllvaXF1RjNMWjFkUzFRTkdDUVorRWdQUVZBTUp3QjdGcGJXbmlaaE40?=
 =?utf-8?B?cnVxd0xmZlo5SVo0VElOUElCN05ibGM5Ti9CL0wxZkFJN3JjRnZBZ2FVTFE1?=
 =?utf-8?B?NWc4MzBFSmh0aGkwZ2xpdjcyUEY3NzJ2KzA5MHhvMjdVV1ZzVE1McUs4WDFt?=
 =?utf-8?B?bWF1WWx0NTFiNGZEMUI5WnRQYjJlaitZV3B2dS9VbGY0N1A4NVowMUJJcCt4?=
 =?utf-8?B?aWNHbi8zM3hDdUlFL05vbmhlcGlEVnBLS3JnRmk1M3lITURuYWs0YnJ5bC94?=
 =?utf-8?B?MU1yUUUvWkpGQ3h2bS9mNmx2dG0yY3JqZW0rWFJkMEtKMXU3YVpSN0xmUGU2?=
 =?utf-8?B?UlM0ZmdkSzNvRDhJOVo4dHdqK29nMTdZaVozOGN5b1ZBL0JOOU5ubDMzd3B3?=
 =?utf-8?B?OExZOGNzYlk0eElTMC80QzlCblJ4UFFobjc4OUJyUTBVQUtCQ1ZtNHRVcmdu?=
 =?utf-8?B?MEpOYW1ONVZiWTQ1WDhHN05sMFh4a2tIVys4eFRxY3dVdFRwVExnb04xcDR4?=
 =?utf-8?B?ZUVsRFYyWjh6MlVmUFBuRWI4UmJac2RyK3QxV2E5aG40QTRZaFR0NWhYVjZO?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfbb36e-82e8-478f-d8bb-08da66828772
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 16:53:23.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4k4OMA0DXpvJ3Zb7QE2anFzMRJ1EnvGFyOYrBO6vXsf6tulEAdS3mnVm3RnCrQEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4509
X-Proofpoint-GUID: nc2-Npw3yKnUpfUboV82Xkv7bvrIZS69
X-Proofpoint-ORIG-GUID: nc2-Npw3yKnUpfUboV82Xkv7bvrIZS69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_09,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/15/22 7:18 AM, Jon Doron wrote:
> From: Jon Doron <jond@wiz.io>
> 
> Add support for writing a custom event reader, by exposing the ring
> buffer.
> 
> Few simple examples where this type of needed:
> 1. perf_event_read_simple is allocating using malloc, perhaps you want
>     to handle the wrap-around in some other way.
> 2. Since perf buf is per-cpu then the order of the events is not
>     guarnteed, for example:
>     Given 3 events where each event has a timestamp t0 < t1 < t2,
>     and the events are spread on more than 1 CPU, then we can end
>     up with the following state in the ring buf:
>     CPU[0] => [t0, t2]
>     CPU[1] => [t1]
>     When you consume the events from CPU[0], you could know there is
>     a t1 missing, (assuming there are no drops, and your event data
>     contains a sequential index).
>     So now one can simply do the following, for CPU[0], you can store
>     the address of t0 and t2 in an array (without moving the tail, so
>     there data is not perished) then move on the CPU[1] and set the
>     address of t1 in the same array.
>     So you end up with something like:
>     void **arr[] = [&t0, &t1, &t2], now you can consume it orderely
>     and move the tails as you process in order.
> 3. Assuming there are multiple CPUs and we want to start draining the
>     messages from them, then we can "pick" with which one to start with
>     according to the remaining free space in the ring buffer.
> 
> Jon Doron (1):
>    libbpf: perfbuf: Add API to get the ring buffer
> 
>   tools/lib/bpf/libbpf.c   | 26 ++++++++++++++++++++++++++
>   tools/lib/bpf/libbpf.h   |  2 ++
>   tools/lib/bpf/libbpf.map |  1 +
>   3 files changed, 29 insertions(+)
> 

This is a patch set with a single patch. There is no need for
the cover letter. Further the cover letter description is
identical to the commit message of the first patch.
