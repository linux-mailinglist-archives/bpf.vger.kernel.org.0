Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9D864F640
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 01:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiLQAZy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 19:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLQAZr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 19:25:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C145F9D
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 16:25:44 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BGJxXBI024750;
        Fri, 16 Dec 2022 16:25:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ixfncDCjppC5VQj1+SW079Ux75iQELyUt+Pa45GkMGE=;
 b=E2wVgfoWgAzTJ3vaQmyHqpB2QEtCMtB76EIw5+Z6vORXF18s9xoIcArMXjjUfN4s03ls
 FaPGc0yNTm7zer0V2FkPOIj1k/l282AjLDQkDcmwFhdO4W5JtUFGtfWV2bdvFINkRQOO
 c0+zr4b3D8ra9WGs1VXZJ/I10SZnXEGoBZAGHKpAOWr/aCNts2BdIPJNvK7Cq4zLLDw6
 m5P0zdNQtL6/X74n4BBKBrevndHzM/mOuzYsHRUxu1C3H1gztdVhURbH9D9w+/lTYWxD
 e3qLdzheWUGp1Gm6Rqo4eqTdPpzoMixNMaqRjXv3fG+XG8jOK8jwmjhJtB80GBNBy19S LA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mg3hn3uug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 16:25:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6kGO/Is1SyXwE9ff78Katb86lT9a8Rv8NwZbHYKleMm5nldzallZWdg0nNNUNJFlDzLZ0HsxvFbVL11AUTRZaiDIlmAWjw7ieD/qu405KKaVCpHEbmsJ6Nl/t2SqgzcQhqpgOgVGNWYBO4mQrV8k7daxRRLAtvc80vFk8auwAYhujTLib1f06zQuD2aun/G7oncwUISmVzaLlUmA5RtayNOXg8+igRGhrJOskbbNACFwOFDjLatbPwpmFL7JLa/ZEIUqNSmpT0+a5olj3EXy7u76IAP/5Dys+up5jpNeGHR+q1024MAOjrTyCkMxPEXuV6HuR4vUtlC5UAJy9WHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixfncDCjppC5VQj1+SW079Ux75iQELyUt+Pa45GkMGE=;
 b=oPmwAt/uNkP5ZdxKJHmyNBW+1pRo3Sk5Mm8wthyAaLgbmYfINnzpGCHc0oIC48EyOc/DGbxOTOxF8snnSYFUECompBkNe6U89xKr8w6SJxki5S/TDZ6YIzF7rkSCvxIois8v6DLNFnzw0xkniUKwBp82+Ey6X2xtnA4SRHaLnP7j28V0NhpZHAOP7mRz45pP/hyoFqyNs2t/2fOjNERxhedScsy8wbH5We1qSFgSn92y/BxQ2XSIzmDVa2UswymjCUnVTS8+4YHLYejf1ij5WYSiiR94KyQ8H2l2k7/xhQRDqPLqXv//gCyO5DjBJ3nsuf00jq2vlIqr91vtDSayfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ2PR15MB5720.namprd15.prod.outlook.com (2603:10b6:a03:4ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Sat, 17 Dec
 2022 00:25:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 00:25:25 +0000
Message-ID: <ae6edf45-80cc-0adb-67e4-c3da4f55f47c@meta.com>
Date:   Fri, 16 Dec 2022 16:25:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCHv3 bpf-next 1/3] bpf: Add struct for bin_args arg in
 bpf_bprintf_prepare
Content-Language: en-US
To:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Florent Revest <revest@chromium.org>
References: <20221215214430.1336195-1-jolsa@kernel.org>
 <20221215214430.1336195-2-jolsa@kernel.org>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221215214430.1336195-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ2PR15MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: bf2baae9-5089-4b2b-f475-08dadfc53120
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdUHf/6hHRsFYv4kJUZwtXMX4tHO9gfSUNKOv/YKK1McMYK8zBPC6KEAApmoYNUsQzUcDwdRxH0Aph4iVBF/6Nev9zXKxwU8AfHUnONyhmetMzg2xRqIctxdIwcWgCyVRNd4OHdtOhcRqTBQu7QV3yMvtX0uYKRi3Qrkm0pujUqZ4NtbqKtd6HzgfWIG3g3pn3fv+SkLUC9A3lrq/tFdq0kT6bjcS0si3TUp4o7gq/QZ2FVm//EeL9ayiS+rXudGSRo+fSAJ6JT07Zu/qxtrA38SnYZHS54KLHhj+Bn+xaXxeOvQ7E4Rz+7++8Kar2DMzIoT/shM8qa0u8ljNOL2pE1I5hVHWWdCHEjiUckTyzxLJpiUHW1BItZd8B4XNa6ZEkP3QWCBMUHZhF7kfUJpc0agfkJDrLDdIJr/zlauSJlyNweMI3KY1Mmp9IsAj1yAUMYyIYICegKP+keCaKwHaMhaoGve1IdVisizlCoQOkChNDT5sVyMMQc2o4UNS28U5Joz5iBhyaU8NavlkCo2ROCGK28to+1gYU0zOpCQqlTaU4l4Mr2LaYIcwZZwjUCwsCuaYuy+Emx8XoxALhd7cEdXbvHl4UmztWKAGYDc1Kf5PIg2TtU1qndyAZe48mrQRbj1LtF2oyvZOWru8wkhhX14MfAdMn9PhR9O6fUERTBT7qGC5nV7HUZM3qwyo1IVngLNwlNtYHWdyHexH96+vf8ZJhjZt5WFdk/9PYiQPOo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(2616005)(31696002)(86362001)(5660300002)(2906002)(7416002)(4744005)(8936002)(66556008)(41300700001)(6486002)(6512007)(4326008)(66946007)(478600001)(66476007)(8676002)(53546011)(6506007)(38100700002)(110136005)(186003)(54906003)(316002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VPb1ZrMS9NN3ZULzdodXJ6TGcyaHhtRDBVVlE0dTF4S1I1YlBZZUwyd2Ja?=
 =?utf-8?B?VXI2MmNjaFVOZWN5UXlhR2o4NGFVdUYzREVoSzdIV1dKZEh4RGlWY2dJQnNU?=
 =?utf-8?B?b3hrVlY0ZEZnZXdjSE0yWjFpOGtDbU1RMGt1MlJ1OVptTm40ZSsveTdyQkhR?=
 =?utf-8?B?Rlpib0tPcFUrNDYxaS8wVWhFZnViRVhyc1RJZ1pWRXhxM3hNc3VCejlzUk9H?=
 =?utf-8?B?Qm8zU2N0VzhEdEovaGJhRU96U2xFWWs5cTRwNFhjcUJFeVBJdTJiMkhHakdJ?=
 =?utf-8?B?M3F3TExMM21HSVBpTVREVXpwTTk2a21ZdlBldlN0ekkwL2NpZEhJVEZma3BQ?=
 =?utf-8?B?T0hIdzRrSEZrSTc3aS9yUFVJOCtmdVBPNGR2TktlM2JTejFlVjhKTUJDL3lJ?=
 =?utf-8?B?Q1F3cDFaQ1NjSUR5a1RqTWdLemREd05weDFJVm9lNDRTMzZScHZycENUb25P?=
 =?utf-8?B?cVhjVjR6SDZpVkphSmEwL212bTA1eFhidEx3TTN3L0RpRWRXZFdoT0pmaVl0?=
 =?utf-8?B?N3crSzVFbUpYYUJQeTFwZjRGVDVkam11Rk90bUovV0JHOGcrSEtOMVJpelpY?=
 =?utf-8?B?a2s1Vk1EQWdRcSs1ODFzU3JDdExtU01iZWg4NXZKTFM1U0xFdFZQWVRKZ1hR?=
 =?utf-8?B?SWRwSFZUaFNUaHpiMVc1T0R3elIvTGZxK3JIWkVTYVR1RmFmRFlBNHFtdEts?=
 =?utf-8?B?c1pjcThDbU1kVGl4UGxFeitkRVJzYWJuMHdjdm9mLzQ4bFNZRTRtQzZBNVZ4?=
 =?utf-8?B?ZWJsUE9zOWZGTytodjlvZGo1QkJhNG9PQ0FvdExZR2dROS9YK1YyNGwzYVpS?=
 =?utf-8?B?RzRkNzZSTS9OektUSGF0b1dScHN0R3VpWG9lMkNacXByV2F5VTZSY0FQSDVY?=
 =?utf-8?B?TUlCWklmekYwTnFlellRMVg1U1NFaVFtYVNGZ0dXcjRGdEphcFc3bGRrS00w?=
 =?utf-8?B?RERHNk1HVmZYbTlBZjNsSzNiUlRudU15blpMNFIwL0JxVm1UOGZaZk9UeFFR?=
 =?utf-8?B?c0dLTU5TVld3Z09kRjk3c3lvQ0ZudXd6MFJOWlZnekZmRlBNdmhFclFlZGF6?=
 =?utf-8?B?Q24vRStRRWFzb29sWDJpUnpiejNDbElUKzVlaGxRdUl1cTJGWEJCWDFkWGNz?=
 =?utf-8?B?bWJ3eklld2hjeTkzUGpVUnBPd3RCaS9xVkxnZDEyZEhtNFc5NHB0N0dBbm5E?=
 =?utf-8?B?eUozWitQdmhhVFN5Vks5UGliWHBFQjYxeTFBTVUzQm9iOXE4dHJKVFFlYjFV?=
 =?utf-8?B?bXFoeW9udlEvdTNpUk9TQi9GbmI4Vy9JS1Nib2hQRGd4dWtrZTRUN2kxMTZQ?=
 =?utf-8?B?SDhmc2k4eGs1bGd0dzNQRDg3dCs1UU9QSFYzUkx2enk2N0dYeUVpYktxUW5W?=
 =?utf-8?B?MEFQeGt1WjdENXJtbDdTZ3d3a3ZBOVZRZTBBZitxajV6cmN4QitHMCtMeGZ3?=
 =?utf-8?B?d3pROW5NZWdUQndCTVFhNDM3d0JmNTN6cU5kenJIT1lxL0NNM2VUTlBaL2o0?=
 =?utf-8?B?UEhyUDFqTHowOHViZ21jUEZoQzIrNitrYVJLUm9lNVIxYnhjNDN1bUhrbENo?=
 =?utf-8?B?V254NlMvM3NJZlRqYXhzMFVaN3VZU0ErUVlWYzlPak9sWUhMWHVGNFZiT2xy?=
 =?utf-8?B?M2hYQ0lXRnJIVUoyb2xVSk1HVGJHMXMrZmZxalluN1VkSkhGSzVWY2RYR2Zw?=
 =?utf-8?B?aEpoWEpZQUxDM21DSHhFSWJxOFE0SFBsMlV5VWhhWU5GcEhsbnVOL2dDd00x?=
 =?utf-8?B?Sk9BS0s5SDRHcjdMSFdOVE9jdTJsTWdmMmlGUUIvWGVwTSswaTZERGFhL281?=
 =?utf-8?B?U2JuTXk1VkZrdUZrZjdJNTJnZGxQZWMwSHhzRTlLdGpzYzJyMFpQcU5GTmRm?=
 =?utf-8?B?ZXhQNVR3VTRaQjRkdmcwYng1YUREdUxMUStuMTZoa0tNNk1JQm9LckFQc3BM?=
 =?utf-8?B?RVVZamcyQWdibC9SbTk3RDlmbUkvTndUcEM1eGJ4ZjdlaTVRb0RVdmtqRUhB?=
 =?utf-8?B?WFg3ajQ5Y2d2OWdad0xDc1NDR0RVKzRuUU4yVkpJcklObEprbUdJTHVjcU9y?=
 =?utf-8?B?OHIwb09CeDliWEJXYkVxSEcrUUFYMG5YRWdhem1vWXpYaFNpeEFBVm1uSXor?=
 =?utf-8?B?SE1McDl5QURoQzVya1FpdktDSi80V25rNVlSU01mL3gvTmhiWHVnVnpHeVAz?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2baae9-5089-4b2b-f475-08dadfc53120
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 00:25:25.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfCTHdI6SnCmIzsGvgYYLdti0rB8YqVawGZa8eUbRdpoBUqsjngeQJvRW1bKYQjH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5720
X-Proofpoint-GUID: rKdyuGLTOB7-A2ncoPFPSne_0Us8VCm5
X-Proofpoint-ORIG-GUID: rKdyuGLTOB7-A2ncoPFPSne_0Us8VCm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_15,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/22 1:44 PM, Jiri Olsa wrote:
> Adding struct bpf_bprintf_data to hold bin_args argument
> for bpf_bprintf_prepare function.
> 
> We will add another return argument to bpf_bprintf_prepare
> and pass the struct to bpf_bprintf_cleanup for proper cleanup
> in following changes.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
