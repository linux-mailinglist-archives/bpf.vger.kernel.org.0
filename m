Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AEC4F86A7
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 19:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiDGRzo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 13:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiDGRzo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 13:55:44 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD122EBC4
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 10:53:43 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237FWulL017189;
        Thu, 7 Apr 2022 10:53:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=2x0pBHfAJ2wPxUGjvKHqiEo+a7pON1bzeFAc2D7H/dk=;
 b=gecg5Z0bRX4AhB8wTSdVDhNlhHZC/LZxsL0Jan7Tw3cQbS/w8h+2S89WsqC8/BX2Ad6x
 wkyeE08keJdqhF4LB2C8Ep7m1bD9O63pnnJGhqp286K/qwg+qPcB4lg0kUjid2c7dssh
 /XMkWRR8/PYcDkADihI/oZGpP/iPSx/tY2w= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2041.outbound.protection.outlook.com [104.47.51.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f9nrndyxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 10:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZCrmK9u7GzqqHlSoCLIrua0gF3fyYpAc4so1f8/RyGyp09pGSZkAXxLU9Q3ibau+dp81GKi4TntH08eRrFGgv78M3nAMg5jpkSy+xMugddBGyKQNmf1IcXmCdXUH5Xf/yq3q+eBffr+o5p6H7qfdiktMpwEsN/m8JN0KWaJyZgB7K2yETJL/YiuyxgtAKiyXdJrPCXrkRE0LUlo0qIE4te5FH/TiQZ87bCQa6bvZIwRe2DwjjLicVwdGbhilE9/vl5h+PQagZcRZ5oX6icX6+VJ/E3uBiSieNqMrn/HkF5pR+BI5MQk6wQjhpZpEaQyhypFn3QtugdwSu5N2h+p7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x0pBHfAJ2wPxUGjvKHqiEo+a7pON1bzeFAc2D7H/dk=;
 b=Ze86g7EwElHo1hAVCzXEGHnc4bBTGRgHOekiN/k0SxMkajWOqVv18gGWkOGLpiRCl2FDDXsNE6778tWNEGhhc2PXbI4u5/BkKtktSyj8node5gbRuZT24+H4HeMm9OHhF2XMkkIYrqUXBFVytVYk85+mgBDa9PPILUpriC1ujnERMa9cGySNr2GbISU8cOD5eNLN1aAV6TwEIxIl+xE8NHTKFy7c5PgvNS8IrJaq/tT2TxdhHJG1Mcy6jZbROFLOmAxhCXdj8WMPGonWpmoFanjKYhtG/KZZrbEukcEuiyYN4IcnTXpYZpiioBkY2UsvLGsW6pzlfv6ribjhaDbQNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by DM6PR15MB3548.namprd15.prod.outlook.com (2603:10b6:5:1d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 17:53:36 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::bda3:5584:c982:9d44]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::bda3:5584:c982:9d44%3]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 17:53:36 +0000
Date:   Thu, 7 Apr 2022 10:53:33 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     =?utf-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>
Cc:     yhs@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org, shuah@kernel.org,
        ast@kernel.org, andrii@kernel.org
Subject: Re: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
Message-ID: <20220407175333.tnmk4am3hzpfhept@kafai-mbp.dhcp.thefacebook.com>
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-4-fankaixi.li@bytedance.com>
 <20220324193755.vbtg2dvi4x3rysx2@kafai-mbp>
 <CAEEdnKFbq=TpmrXtFi8A-pPcLS-pRS2TT_726v7S52XMX6crQA@mail.gmail.com>
 <CAEEdnKH2g0gZ5y2x_1BCK1MHt6_r=_RLw18=apbwpn9+Thi7nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEdnKH2g0gZ5y2x_1BCK1MHt6_r=_RLw18=apbwpn9+Thi7nA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06e44719-4c84-4ae3-9d68-08da18bf8a6b
X-MS-TrafficTypeDiagnostic: DM6PR15MB3548:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB354886FA57A8EDF7DB819041D5E69@DM6PR15MB3548.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqKaWLw53q9YHteZdwm0sGjAZUjMWsb3yF7el8SR5A99qVY2teeYE5tVEip73G8LoJtCGz+C0tops2kpl2W/NVRWoDS9UncDNa7sr8XMeUfL9EILlPAu15iEcjLTg4MGMgd0YagYC7+3SY31ycO7ZOftaRGwTHN1TLvwvpm+Em9YIJ9LTFwzk9/Rbi2CrYOn/ek6MnzHjFvNFLYJOR8uLeBgouUuuVDHBGwU93OYz0uRREAXoQZ1P2Bj8pYchRoEBeB/6Oh10uVJwgSPc4wAP/DRhuhIi1gk93E28zVKKRM8P+1LD6eWFBJVBReAOGnEmPRzZwsZuAXg9NjXxb1TR8o9DS115aYsYHM85mFBWhEKDqWRVNuXqxulGKCC74yK6sy1DAXQZ33GKlOA8tqhGr3yIuDXzxIzmGO3SjemXVVjjUAIFFg7WgBKBFFGO0BzY629EEDnRIi3rnKT7wwE2ci2i5r9mzr8Fvr24XITM/dMLWZnD3j/WXbwg0X+L/iEZMpIlZoM72kf0P2H1WXfUr15Heq4htZdu58/NHA6w1Hf1VAdABo6T9zNakz892Wj7MNSRPy2sCXorY8fKSSBoprmpWw3qR9DsomeLxXnAJmFWtDJWve2L76jgU/ACJh39blob5tvI+BDq2SdD9Ec4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(52116002)(6916009)(86362001)(316002)(186003)(38100700002)(66556008)(8936002)(6512007)(9686003)(4326008)(8676002)(5660300002)(508600001)(2906002)(83380400001)(6666004)(66946007)(6486002)(1076003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTVaUjBZQlQxNm4wUWFlMlc4Y21jV2VvbkIwcVRabFJCOWZ2d3V2RnpkbWgz?=
 =?utf-8?B?eXJnQlErSUVoT2NzWkExTWhUbVc0NDJ1bVFhRHYxbUh4NGkyZkJrdlNoQk5a?=
 =?utf-8?B?amQzT3Uydld1SHNLZTkwcm1zZzlPZkdKajZNbEhYbTFEek5ncDl3NElPL3Bp?=
 =?utf-8?B?NzZHdWdwTTZGLzhOSC82dUhwY2x0SFZIZDA3S2FyZTZpMEk2alhDQTB2MkEx?=
 =?utf-8?B?Q1MyQjdEVFhLQWJobUlXUzhSd3Y2eDFndEt4bERVRDB3Zkx0aktIQlczZ1F4?=
 =?utf-8?B?U1VzU0hiY3BRQWJ6UFR4K0dYZVVaRzJiWG9GMEltdFZ5RmdOVjlaYnZmUTJ6?=
 =?utf-8?B?clpWaXluNGNPSXo2Nmt1dmN1UXhqYU96eGFNU01UeFNaRDMxODVkVW9UT09G?=
 =?utf-8?B?RDRMWk1TSmt0QTFQaS9QQ0tiMXZOOW9EMEtyVkpSZGJEU3lTL1k3ZW96cllU?=
 =?utf-8?B?ZWFmQlVKQjVGYkNiT0FHQVh2dXFVaC9rU3EzN0JmUUtKMzRlc0pGVmpVUVMz?=
 =?utf-8?B?V2JnRDRRWU55akUzMGpkQ0J6VmRPajFBdG5mWmhYblpqOGFRVkpiZll0NUFz?=
 =?utf-8?B?UDJUSkQxNG83ajdzalltc1U4VDBKNnhpbzRaSy9BZndmbEM5bWxySlBreXQ4?=
 =?utf-8?B?SVpnd3RKOVJsQUl0MGM2NFBLZDZFWUpWVHBJSXAxemZ3bjQ5QUxxblUxL0gy?=
 =?utf-8?B?V3VndGJaM3FTbVI4OTRVUWd5bHdqRk93Y2hrWjM1bHVVdXJlK3lIQzlRRDVY?=
 =?utf-8?B?ZHFCd0xlNXdWQnZON2RIL0w1V2lTK2lmYWFORTcwdFBlNCtQNlFpejdXNFJD?=
 =?utf-8?B?a0NjVW14cXRvVXJiWVUvOFJtMHl5ekptLzNJVWFyN3FDaVlvK082VDYrS0tn?=
 =?utf-8?B?T1ZxLzJrdnBzSUFRWGpyL1poT3ppMVB6VkdVSDlQVloydHFSNW1tMlN5V2xV?=
 =?utf-8?B?Mi9oSno0cUwvaFFSdlhsZzVra2xUd2JuYXo3YUhESWNpamFBeXdobVBxUE5h?=
 =?utf-8?B?eXFJaHR1Z0RpaUs1MFlQY0ovbCtTY2h4c1VMZ0F4d3lNRGlNQUxZSHpMYTY5?=
 =?utf-8?B?UWRYcTBpR2Q1ZWNDSG5kcm1EVlpyQ0wweFN3cmN6Lzh6b3dKYkk4N0ZiWS9F?=
 =?utf-8?B?MmlWMlQwMTY1TU9FVUNMT0xOSUUxSHNTMGhvWWtGKzBCbW9jQzZMdU54cDhH?=
 =?utf-8?B?emRhNTcrNHNmcCtNVitUdlF5M21TRkFabHRGeXdPNmhNNFk0cVEvVERJNEl0?=
 =?utf-8?B?NzdVTjcwNHZ2UHozS1NOTEduUy82bkRYcE5NWjMyeGdUdC9LRjhXSkJTbE9Q?=
 =?utf-8?B?Rk1NNTZNMmR2ZjZLVVhwSzRTUU5pZ0dtVGZqMWpxTGZ3RzBwK05BSHArUzdx?=
 =?utf-8?B?L20rQUViTEltZ1htU1pMbkdqeW9tOVkwbmdhTmlKb3dYeE5EaFpKUHdYbzhQ?=
 =?utf-8?B?eHA0eTBzTXFuNHM0TzRLK05ucGZRMXBRODV3bi80ZEUveGo1a0hOYk9ybWVT?=
 =?utf-8?B?K3lReHQ4RERUT0xxSVRkZWlwVllhblp3L0h6M056VmwwdjlkL3gvSkFWalJa?=
 =?utf-8?B?SWlscnRjdlZuWTdyZVI4N3NIcTdyUjlHQUl0TzlkVjJ2WW1ycDU4bVVmSlVQ?=
 =?utf-8?B?SmhBaXN3Q1lBaG9pSjRnbEtJdDkwenlSY25xMTY2d1JEZ280UGRGRUdWZGRU?=
 =?utf-8?B?RWVneEVvc29aaGNPVjEydnBvY3ZzenNLZ2k4NjA2Q3ZtV3Y1R1RiampFUEUr?=
 =?utf-8?B?TWlkRTFzRnVZb2pTdzlMYVcvUXFab2ZxNnZUZ0t4eC92RFZaOFZHQmdqRG1D?=
 =?utf-8?B?QVRjcUlaZW5mdS9iSWNCSmdabUtMNldDT1RqRmJqLzVZL0VFSW5iWlMyWkw4?=
 =?utf-8?B?SWxPNjBkOUFIcGQrczJka3VkYWh2ZjRmcFdMSVQ3K0FOc1BrdStoM3RyVm5E?=
 =?utf-8?B?VXUwT05KOXlIUmY0RFFtazRiOXFnVllBRzMvTHI1aTduZTk2aGdtaGdqMDNY?=
 =?utf-8?B?KzhIU0k5Y0QrYmtxamZGdEVyMkp2MEJJRTRrYUVJZUFib3drVzJZZHgwRDZa?=
 =?utf-8?B?eWU1MytQLzdBaDdkMTRpSU1Ib3Y0ejVwNVhsSktoYWJ0bWlGVmFrKzVwdWtE?=
 =?utf-8?B?dXVpaFgrZkZLZlZOT2JuTmE1TWVoU1FUSjZ2Z1AwNW9xZzJ2Yi9zWDhTL0dt?=
 =?utf-8?B?aDdmdGJVWG1taVQ0K0NRZ1FyRy9ieGxoY2ZYMFloS0M3bEJtYTNLNklDU3NE?=
 =?utf-8?B?aUk3MEFTUTZFL1VGTEM4OHdCYnBCYmJUVWtnenQrZjk2Q0FyNEt3dmptdjlO?=
 =?utf-8?B?ZzJMREtldW5YY2cwaXVMaU1VNSs1TFp5RWpFVHBOQktOdW5ta1kyRzZ2NVR3?=
 =?utf-8?Q?mGSlZGzINTadveDI=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e44719-4c84-4ae3-9d68-08da18bf8a6b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 17:53:36.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z9WNT7WL5r4JNffiqZebamu30njXvyvIPb4bpFnauSLa2qlJ6zd7BygrF7pBYcVq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3548
X-Proofpoint-GUID: Mwln6VeXrh8rJiD8QHbv2kEG5olKWR2i
X-Proofpoint-ORIG-GUID: Mwln6VeXrh8rJiD8QHbv2kEG5olKWR2i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_03,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 06, 2022 at 04:03:32PM +0800, 范开喜 wrote:
> Hi Martin KaFai Lau and Yonghong,
> 
> I have prepared v3 patches for tunnel source ip feature. Some obviously
> errors have been fixed. But there are three problems left. They makes me
> copy tunnel test cases and put tunnel source ip test codes into them.
> I put these three problems here:
> 
> I have tried to use bpf_printk in bpf kernel code. But the object file could
> not be loaded by tc filter command. There are .relxxx section such as
> .relgre_set_tunnel in the output of objdump.  The tc filter says it could
> not find the dedicated section.
> So I still use bpf_trace_printk now.
> 
> I have tried to use a bpf map "local_ip_array" to store tunnel source ip
> address. Userspace code change tunnel source ip by updating map
> "local_ip_array" in the middle of test. Kernel bpf code get the tunnel source
> ip by looking up the map. But the object file could not be loaded by tc filter
> command also. The verifier says "R1 type=scalar expected=map_ptr" when
> calling "bpf_map_lookup_elem" helper function. I check the assembly code
> that the r1 register value is 0 when calling "bpf_map_lookup_elem".
> I write a tiny bpf loader for this test. But It's too heavy.
> 
> I have read test cases in prog_tests directory. They use c code to replace
> shell command to create network namespace and ping. Also functions like
> "test_tc_peer__load" are used to load bpf code. It's more complicate than
> shell commands. And there are many duplicate funtions like create_ns in
> some files.
> The code in test_progs.c are common functions not test cases.
> Maybe we could move tunnel test code to it in the future until the test
> framework is complete.
Regarding the "test_tc_peer__load" is more complicated than shell,
it is the skeleton and a better way to load bpf to do test.
It makes the user space test easier to write, e.g. the bpf_printk+grep
for capturing error can go away and replace it with checking some
bpf's global variables instead.  All newly added tests are using it.

There are examples in prog_tests/ (i.e. test_progs) doing similar things as
the test_tunnel.sh, e.g. creating netns, adding veth, tc filter...etc.
For example, take a look at tc_redirect.c and how it avoids the tc bpf
loading issues that you have seen.

The .sh is not run by CI also.  I also only run test_progs regularly.
I was also not sure if test_tunnel.sh should further be extended, so
did not mention it.  However, based on the issues you are seeing from
making common changes to the bpf prog, it is clear that it should be done
in prog_tests/ (i.e. test_progs) instead.  At least start with the
two new tests that you are adding in patch 2 and 3 instead of further
extending the test_tunnel.sh.  That will setup a base to move
all test_tunnel.sh to prog_tests/ eventually.
