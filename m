Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8DB4B1AE8
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 02:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346654AbiBKBEy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 20:04:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346645AbiBKBEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 20:04:53 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4075F71
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 17:04:53 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANrR4A001813;
        Thu, 10 Feb 2022 17:04:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cy65In0rlJSnvljANQKadsXzlOZ3vAVRlLhOF1J5sx8=;
 b=p8JL4tqCk1VG1HCARpU8nN9hqzTHRZgGiIGjk4Tu9NyhBZDE7RMJxSYPx3/qLtappijL
 3kWN0DNkDy6V0QxFBamu7oExYNioqKqU8x/xXU976m6C8SJo2QXxbg2+GlAJc1m+cksP
 ZppGSLcVxoJyZvFyVCHwLgV5YghJAjVeKWE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e54v64dyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 17:04:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 17:04:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHgtoBRE2ZXiZbGD66tKGZAvtqqvLxtmmgj/RBi7tbRFZOu8stD2528loLtKC6WSESPXbwm14ZppNu9T5W8fhpUEAmsjIum+veWfx1+9g4k1TZhn/pHLaelHgwgXrq95J1lbaMC3Ym4oVTinhFHsErBapC65LIQL7/3HLhmYMkrZcLWCnQTStO9zPx/XBI13f4LA+XkFH1+iMC8ZuGRz+XqxVPLlMbfDppbWOjavWt/uUXXoVqqltePR7Y7FA1TVmc2tYk0VNfUkFmqGdovJLoD9ixe3gBO7MOPNqADTvAqzIkoOO+F4dQE+CPzGOaPKdTRVNkoiHc9ephQ71oaudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy65In0rlJSnvljANQKadsXzlOZ3vAVRlLhOF1J5sx8=;
 b=Zy0NYNtGFxkXs2IERPDoQ5EBZnpUBhRacllb7POsOxH0+wOWJokzt4cj6d0FLglMlxI4hVNpgTV4RJP5D4KNL7OF4Z5OGgKhAS/jOp7NDvbHlqXrGblf0itAYLtbmdHBDMaNfCPghIGnWq7CJ/M85NKuMIe6x+9zFEUZUbMqIWhMU3TmD9/DY7QukiKT03PLS5hZT4yLPJVnaHpp7VW/woXwPuzIynd99C8JOQXQFrgy08guPf7BwIEBDfZRMfFAhSj+1OgUq/3TIUVciefdZ1rwhaga/4LNVl3veJNcRbMElyPJN5BHTa3MCCOeOS9BnowC3So/fLY5PwcXZ7nZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by BY3PR15MB5059.namprd15.prod.outlook.com (2603:10b6:a03:3ce::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 01:04:36 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::c5d8:3f44:f36d:1d4b%6]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 01:04:29 +0000
Message-ID: <99ad3ab0-c0d0-5d83-ac0e-314ac0b96842@fb.com>
Date:   Thu, 10 Feb 2022 17:04:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix crash due to incorrect copy_map_value
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220209070324.1093182-1-memxor@gmail.com>
 <20220209070324.1093182-2-memxor@gmail.com>
 <57359c7b-7c6b-cfc9-22e8-5288a6ce0517@fb.com>
 <20220209195254.mmugfdxarlrry7ok@apollo.legion>
 <e74b1aa6-7aa6-d814-5dbf-209506e00553@fb.com>
 <CAADnVQLUrz=Hwp-3e9k5RMSiD+a_nhZVHjWzR4cneZ4naQqrEQ@mail.gmail.com>
 <e7b471b5-e93c-d9ed-bc36-970b73df6643@fb.com>
 <20220211000245.s27zktgzl7pzaqt6@apollo.legion>
 <96931b07-2244-f5de-5bda-c62a464db2b1@fb.com>
In-Reply-To: <96931b07-2244-f5de-5bda-c62a464db2b1@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:303:b4::26) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd8a7b6-0c04-46eb-b051-08d9ecfa74dd
X-MS-TrafficTypeDiagnostic: BY3PR15MB5059:EE_
X-Microsoft-Antispam-PRVS: <BY3PR15MB50592BACBBADE05655111705D3309@BY3PR15MB5059.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8SxgW5t3Yuhrk9Xmnwe7JQdiS6j+4cx4zt9bQlnaayrpX2MimGQ417HsY5339B2r05vrn+5Cn1DqnreMyuuLXkqL/v2+6nHgRpfx/JlA7ruoE4in212HaexDm1eIxLpFTBeSFH+wLufClVT20hakK0u8EP2qzZqgI4CrK2k9NacvMjGQ3jafZIyOMrm7GGsYh7PRRWyKIAOERQsFasrISIvjG+4UpuHSAujbNGGdOhfvRDX/i9/ai6sw9nMITynrWfVbvmaeNgaOBnb48g/oSmebj3oAOc4Dr6hhE9GhlfsTjtO/YdnZ3ip5/dgJei42/r0fCZtWO+qeJyQSSiUEY7xecTG0xasmXTyN1XsRztbps4xFY87C8RrqbrmltBl6189lnwSHsn8IQiUuOSO9eivvMajapgtl9Pa9giYjuknfQI69Bi2GBmWN7Qmj4ETRIockraofjBidE0HPHzPKPAGa7kelMgX8+cFjtzjmVb18ork1gmpSTk958IRVTrR5arcEjwbmmdgDYZeW0IRf9p9spECujB1zeCqWGk9UhrIlUX39JPQUqWhBBtsgzDP8Pz67ZhzEvJ2cTWynVgvyF0ZCoNCVlMmJkiSe6uiFMe5QnQ3hW3TYBEVobLfL0pM5IOEPxMfpKfGMCGCsl5emE5FTY6sW7OyWxwLqOJbzi4xkZ75RYiyhcXXacX9nj0huu0/3hvTvrs7HRY9idcRYlWpOd4lbyJzYDQjxEK+D53QI9wdXMz2g//LULaht9wh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(86362001)(66946007)(186003)(4326008)(6486002)(83380400001)(31696002)(38100700002)(36756003)(8676002)(8936002)(52116002)(53546011)(66476007)(316002)(6916009)(31686004)(54906003)(508600001)(2906002)(2616005)(6506007)(6512007)(6666004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3l6eHJIbkg0cXltMWxGUE4vSVNrNXM1cWNtdHdKY3BPb1hXS3dRbmpZckFJ?=
 =?utf-8?B?azV2SkFpTG9ZdjlERVZ5V01FRGl2TDdwYTdpR3U3aFdzNjJuTDBwTkpMSmxD?=
 =?utf-8?B?RTN5b3ZDQmdoUk5qY2phUlQvKzYzWkF3SFI3NFVyMXJpcC8rOEdWSTdzRkJW?=
 =?utf-8?B?ZFVPUWZzdUkxYW1aOFlwTklxVXVVNm9BeU5rRW5BLytlcTF6TFBFOEc3M2Ny?=
 =?utf-8?B?RlN1aHMwY3RnTW5NVUFWdUpBMEpsd2k5TmdMa054RGg2UDFaQ2NjcEt0Nys2?=
 =?utf-8?B?cVlhY1U4citYckYxMUF6dnhaWEQ1VTVtUWU2RmFpN09GaUdyYlQxdWhybzZp?=
 =?utf-8?B?b3NNc3NwRjA2V0lkUFUvL0hlaWdMK3ZZT21XL3MyS2pnNDdRa0hPbExPOXdy?=
 =?utf-8?B?bFdPSmlrbmJJK0o0SmVIT0VXRFdiYXd6cDdMMHUyS1gramFpSTJKc3JHRFR4?=
 =?utf-8?B?Nzd3K1FubHdySlRNS0hIVCtVL0ZWdjdtTzdZeFNhZHRCUFRjR1F5U1FGeWha?=
 =?utf-8?B?Yzd0S1ViVkVyRDgwL2tsNDV6WEtuaWV1RjVLVGdTR3BBWHhYT1NuK1V3UEl3?=
 =?utf-8?B?N1hZbVFXU3J3enc3eFFORWttQTJDakhtK2t0bmNLbWhCQS84RkxLeGFidjha?=
 =?utf-8?B?dWROQzdReHphcHRNeWF5Tyt5eSthNi83SjBxeXEyeENweGJnRzk2TnFLeDZp?=
 =?utf-8?B?bHpGemhyYXUwQW44NEZ0a3UxaFlLUy9SZjZTdVNXRG9BRFVOU0g2Y3VhQ1pr?=
 =?utf-8?B?a2dudE1yQUZjbmFscWtaWEZNdUN5eWNHNzFmV3c0ckFVVnMwbmhRcms0M2tF?=
 =?utf-8?B?WG52UlMyTW1XMXNxcU45NDlBbjR6bDNDSTZLdXNZdU5wN1RyQzIwVTNoRHhp?=
 =?utf-8?B?ZUJkQjd5NnRkYXdvSEcrUGZ3aUM1WStud1ZWWVhucUw3OUs3ZW1Vak1GNGZj?=
 =?utf-8?B?RjlNNVFRSzgwMi9HTXFYMkUxdWRZcmhleUpiMTF6NklEb3NBdmhuTmV4VG5n?=
 =?utf-8?B?M3VpZ01WOTRxc3V0bkVrUEJkL1Q5OGRLTEJpSS8yMGpnWHh5UnF6bFhsVW1l?=
 =?utf-8?B?ZVlUU0k3Y2FHODBXQXQ2bktkUmRkTWtUNzlOd3hLSHROZHJod2VmRnRLNU1V?=
 =?utf-8?B?USt2cDJjaXhRMzkvMHU4R3U3aGhoV0RxcGVHRENUYmw3UDFyaFBHWnkwamRm?=
 =?utf-8?B?dCt1QmNJTFc0VGVhWkNoQXJiM1NrOXpwa2s1OENJcWpVQ3lMVW9lOThZNjhC?=
 =?utf-8?B?OU8vWWZkU2RIcEtESkxOUVFQeEdUS1crVG1vcmpLclhwM3loVkZVenBrak16?=
 =?utf-8?B?S1piNGpHcHhQdGIwSGtudm1TNHJUcnYxdWVpYmJwVmF2b0gvdTBTQjVlN3ln?=
 =?utf-8?B?eWNValFRNXA1VHpERGt1OVZUZUgzaTNIWjZBeHVsS2V6N3h0SkRTMzJ5dFdO?=
 =?utf-8?B?M0xaYmZJdTVwTlhuQ1lnWkRVRm5HN2VnUDZrZkN5dUt4S2hwM1EreitYWldP?=
 =?utf-8?B?SExwMnh0ZC9XTnpwam43SElCUnQxWVAzZnpGcFBEYzNtRG4zNms2U290YTE5?=
 =?utf-8?B?b1ZsaWVTeTVCRE9mbTF2UCtNMjdXREpLTjNqdkdWZis2dENMSXZ3aHJ1N2xY?=
 =?utf-8?B?UjdMRGZ5emEyTEpVejQ1SkZXUjhGZkJ3RldzMjR3VXJqVFlMUkdtdG5GWVRR?=
 =?utf-8?B?WDhweTZwd0ZHYWVSSVV2SjlidDlObnA5c01kR1NlZVVpdFV1R21oZ1NSQjBQ?=
 =?utf-8?B?MkNLM1phdk95d2t2UU1wRmMvSjhHbFVLeGk5VWlsbW1RdThTSzYxT3VkWVQr?=
 =?utf-8?B?Q2NEVlhnbCtGVzV5Ni84Wk9XdC9vWU5uWWpwWVhDWkhIUDIvMnJna2lVRWxl?=
 =?utf-8?B?VkcvTmpFemFjWVg4OGtnZVhFUGN3THNwV1hNUG1JNU9lMzE2SDUvRVpsRjNF?=
 =?utf-8?B?ODF0dmU1ZElHOGFyODhpQUVYMmRleCtXc2FtZjF4aGRrT3VPZmFabFNFbjJS?=
 =?utf-8?B?cGpuRWtpcmRUdCt5Y016OU9RcXRtYVdFclFPQXNMLytJQ1lrNm1HTXhCWUZB?=
 =?utf-8?B?SjFjSkVaSVdsM05aMitUOXVSZG1hczZ6QUZlU3NLbDc2dDAxSkk2UStXODZa?=
 =?utf-8?B?emEwcW1sTHlYdUVQNjRWNlpWTmZvNzVnV1ArKytaajVMaEwyUmZrTExrci9p?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd8a7b6-0c04-46eb-b051-08d9ecfa74dd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:04:29.7863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzoE1Z1Rpej+uFi9S6VChUex9culsrxWiWhvbFQ0rl4yODHG60RNC66G+n2cGAjd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5059
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: m4UhPrpHxeUgYOYaM08eX9qUXTlkdWi_
X-Proofpoint-GUID: m4UhPrpHxeUgYOYaM08eX9qUXTlkdWi_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110001
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



On 2/10/22 4:13 PM, Yonghong Song wrote:
> 
> 
> On 2/10/22 4:02 PM, Kumar Kartikeya Dwivedi wrote:
>> On Fri, Feb 11, 2022 at 05:24:55AM IST, Yonghong Song wrote:
>>>
>>>
>>> On 2/10/22 2:49 PM, Alexei Starovoitov wrote:
>>>> On Thu, Feb 10, 2022 at 12:05 AM Yonghong Song <yhs@fb.com> wrote:
>>>>>
>>>>>
>>>>> On 2/9/22 11:52 AM, Kumar Kartikeya Dwivedi wrote:
>>>>>> On Thu, Feb 10, 2022 at 12:36:08AM IST, Yonghong Song wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/8/22 11:03 PM, Kumar Kartikeya Dwivedi wrote:
>>>>>>>> When both bpf_spin_lock and bpf_timer are present in a BPF map 
>>>>>>>> value,
>>>>>>>> copy_map_value needs to skirt both objects when copying a value 
>>>>>>>> into and
>>>>>>>> out of the map. However, the current code does not set both 
>>>>>>>> s_off and
>>>>>>>> t_off in copy_map_value, which leads to a crash when e.g. 
>>>>>>>> bpf_spin_lock
>>>>>>>> is placed in map value with bpf_timer, as bpf_map_update_elem 
>>>>>>>> call will
>>>>>>>> be able to overwrite the other timer object.
>>>>>>>>
>>>>>>>> When the issue is not fixed, an overwriting can produce the 
>>>>>>>> following
>>>>>>>> splat:
>>>>>>>>
>>>>>>>> [root@(none) bpf]# ./test_progs -t timer_crash
>>>>>>>> [   15.930339] bpf_testmod: loading out-of-tree module taints 
>>>>>>>> kernel.
>>>>>>>> [   16.037849] 
>>>>>>>> ==================================================================
>>>>>>>> [   16.038458] BUG: KASAN: user-memory-access in 
>>>>>>>> __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>>>>> [   16.038944] Write of size 8 at addr 0000000000043ec0 by task 
>>>>>>>> test_progs/325
>>>>>>>> [   16.039399]
>>>>>>>> [   16.039514] CPU: 0 PID: 325 Comm: test_progs Tainted: 
>>>>>>>> G           OE     5.16.0+ #278
>>>>>>>> [   16.039983] Hardware name: QEMU Standard PC (i440FX + PIIX, 
>>>>>>>> 1996), BIOS ArchLinux 1.15.0-1 04/01/2014
>>>>>>>> [   16.040485] Call Trace:
>>>>>>>> [   16.040645]  <TASK>
>>>>>>>> [   16.040805]  dump_stack_lvl+0x59/0x73
>>>>>>>> [   16.041069]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>>>>> [   16.041427]  kasan_report.cold+0x116/0x11b
>>>>>>>> [   16.041673]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>>>>> [   16.042040]  __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>>>>> [   16.042328]  ? memcpy+0x39/0x60
>>>>>>>> [   16.042552]  ? pv_hash+0xd0/0xd0
>>>>>>>> [   16.042785]  ? lockdep_hardirqs_off+0x95/0xd0
>>>>>>>> [   16.043079]  __bpf_spin_lock_irqsave+0xdf/0xf0
>>>>>>>> [   16.043366]  ? bpf_get_current_comm+0x50/0x50
>>>>>>>> [   16.043608]  ? jhash+0x11a/0x270
>>>>>>>> [   16.043848]  bpf_timer_cancel+0x34/0xe0
>>>>>>>> [   16.044119]  bpf_prog_c4ea1c0f7449940d_sys_enter+0x7c/0x81
>>>>>>>> [   16.044500]  bpf_trampoline_6442477838_0+0x36/0x1000
>>>>>>>> [   16.044836]  __x64_sys_nanosleep+0x5/0x140
>>>>>>>> [   16.045119]  do_syscall_64+0x59/0x80
>>>>>>>> [   16.045377]  ? lock_is_held_type+0xe4/0x140
>>>>>>>> [   16.045670]  ? irqentry_exit_to_user_mode+0xa/0x40
>>>>>>>> [   16.046001]  ? mark_held_locks+0x24/0x90
>>>>>>>> [   16.046287]  ? asm_exc_page_fault+0x1e/0x30
>>>>>>>> [   16.046569]  ? asm_exc_page_fault+0x8/0x30
>>>>>>>> [   16.046851]  ? lockdep_hardirqs_on+0x7e/0x100
>>>>>>>> [   16.047137]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>>>> [   16.047405] RIP: 0033:0x7f9e4831718d
>>>>>>>> [   16.047602] Code: b4 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 
>>>>>>>> 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 
>>>>>>>> 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 6c 
>>>>>>>> 0c 00 f7 d8 64 89 01 48
>>>>>>>> [   16.048764] RSP: 002b:00007fff488086b8 EFLAGS: 00000206 
>>>>>>>> ORIG_RAX: 0000000000000023
>>>>>>>> [   16.049275] RAX: ffffffffffffffda RBX: 00007f9e48683740 RCX: 
>>>>>>>> 00007f9e4831718d
>>>>>>>> [   16.049747] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
>>>>>>>> 00007fff488086d0
>>>>>>>> [   16.050225] RBP: 00007fff488086f0 R08: 00007fff488085d7 R09: 
>>>>>>>> 00007f9e4cb594a0
>>>>>>>> [   16.050648] R10: 0000000000000000 R11: 0000000000000206 R12: 
>>>>>>>> 00007f9e484cde30
>>>>>>>> [   16.051124] R13: 0000000000000000 R14: 0000000000000000 R15: 
>>>>>>>> 0000000000000000
>>>>>>>> [   16.051608]  </TASK>
>>>>>>>> [   16.051762] 
>>>>>>>> ==================================================================
>>>>>>>>
>>>>>>>> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
>>>>>>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>>>>>>> ---
>>>>>>>>      include/linux/bpf.h | 3 ++-
>>>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>>>>>> index fa517ae604ad..31a83449808b 100644
>>>>>>>> --- a/include/linux/bpf.h
>>>>>>>> +++ b/include/linux/bpf.h
>>>>>>>> @@ -224,7 +224,8 @@ static inline void copy_map_value(struct 
>>>>>>>> bpf_map *map, void *dst, void *src)
>>>>>>>>       if (unlikely(map_value_has_spin_lock(map))) {
>>>>>>>>               s_off = map->spin_lock_off;
>>>>>>>>               s_sz = sizeof(struct bpf_spin_lock);
>>>>>>>> -   } else if (unlikely(map_value_has_timer(map))) {
>>>>>>>> +   }
>>>>>>>> +   if (unlikely(map_value_has_timer(map))) {
>>>>>>>>               t_off = map->timer_off;
>>>>>>>>               t_sz = sizeof(struct bpf_timer);
>>>>>>>>       }
>>>>>>>
>>>>>>> Thanks for the patch. I think we have a bigger problem here with 
>>>>>>> the patch.
>>>>>>> It actually exposed a few kernel bugs. If you run current 
>>>>>>> selftests, esp.
>>>>>>> ./test_progs -j which is what I tried, you will observe
>>>>>>> various testing failures. The reason is due to we preserved the 
>>>>>>> timer or
>>>>>>> spin lock information incorrectly for a map value.
>>>>>>>
>>>>>>> For example, the selftest #179 (timer) will fail with this patch and
>>>>>>> the following change can fix it.
>>>>>>>
>>>>>>
>>>>>> I actually only saw the same failures (on bpf/master) as in CI, 
>>>>>> and it seems
>>>>>> they are there even when I do a run without my patch (related to 
>>>>>> uprobes). The
>>>>>> bpftool patch PR in GitHub also has the same error, so I'm 
>>>>>> guessing it is
>>>>>> unrelated to this. I also didn't see any difference when running 
>>>>>> on bpf-next.
>>>>>>
>>>>>> As far as others are concerned, I didn't see the failure for timer 
>>>>>> test, or any
>>>>>> other ones, for me all timer tests pass properly after applying 
>>>>>> it. It could be
>>>>>> that my test VM is not triggering it, because it may depend on the 
>>>>>> runtime
>>>>>> system/memory values, etc.
>>>>>>
>>>>>> Can you share what error you see? Does it crash or does it just fail?
>>>>>
>>>>> For test #179 (timer), most time I saw a hung. But I also see
>>>>> the oops in bpf_timer_set_callback().
>>>>>
>>>>>>
>>>>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>>>>> index d29af9988f37..3336d76cc5a6 100644
>>>>>>> --- a/kernel/bpf/hashtab.c
>>>>>>> +++ b/kernel/bpf/hashtab.c
>>>>>>> @@ -961,10 +961,11 @@ static struct htab_elem 
>>>>>>> *alloc_htab_elem(struct
>>>>>>> bpf_htab *htab, void *key,
>>>>>>>                            l_new = ERR_PTR(-ENOMEM);
>>>>>>>                            goto dec_count;
>>>>>>>                    }
>>>>>>> -               check_and_init_map_value(&htab->map,
>>>>>>> -                                        l_new->key + 
>>>>>>> round_up(key_size,
>>>>>>> 8));
>>>>>>>            }
>>>>>>>
>>>>>>> +       check_and_init_map_value(&htab->map,
>>>>>>> +                                l_new->key + round_up(key_size, 
>>>>>>> 8));
>>>>>>> +
>>>>>>
>>>>>> Makes sense, but trying to understand why it would fail:
>>>>>> So this is needed because the reused element from per-CPU region 
>>>>>> might have
>>>>>> garbage in the bpf_spin_lock/bpf_timer fields? But I think atleast 
>>>>>> for timer
>>>>>> case, we reset timer->timer to NULL in bpf_timer_cancel_and_free.
>>>>>>
>>>>>> Earlier copy_map_value further below in this code would also 
>>>>>> overwrite the timer
>>>>>> part (which usually may be zero), but that would also not happen 
>>>>>> anymore.
>>>>>
>>>>> That is correct. The preallocated hash tables have a free list. Look
>>>>> like when an element is put into a free list, its value is not reset.
>>>>
>>>> I don't follow. How do you think it can happen?
>>>> htab_delete/update are calling free_htab_elem()
>>>> which calls check_and_free_timer().
>>>> For pre-alloc htab_update calls check_and_free_timer() directly.
>>>> There should be never a case when timer is active in the free list.
>>>
>>> The issue is not a timer active in the free list. It is the timer value
>>> is not reset to 0 in the free list.
>>> For example,
>>>   1. value->timer... is set properly (non zero)
>>>   2. value is deleted through update or delete, value->timer
>>>      is cancelled and freed, and the hash_elem is put into
>>>      free list. But the hash_elem value->timer is not zero.
>>
>> But in all cases, check_and_free_timer was called right? Which then calls
>> bpf_timer_cancel_and_free which does this:
>>
>>    1336 void bpf_timer_cancel_and_free(void *val)
>>    1337 {
>>    1338         struct bpf_timer_kern *timer = val;
>>    1339         struct bpf_hrtimer *t;
>>    1340
>>    1341         /* Performance optimization: read timer->timer without 
>> lock first. */
>>    1342         if (!READ_ONCE(timer->timer))
>>    1343                 return;
>>    1344
>>    1345         __bpf_spin_lock_irqsave(&timer->lock);
>>    1346         /* re-read it under lock */
>>    1347         t = timer->timer;
>>    1348         if (!t)
>>    1349                 goto out;
>>    1350         drop_prog_refcnt(t);
>>    1351         /* The subsequent bpf_timer_start/cancel() helpers 
>> won't be able to use
>>    1352          * this timer, since it won't be initialized.
>>    1353          */
>>    1354         timer->timer = NULL;
>>    ...
>>
>> So the timer->timer was set to NULL in the map value.
> 
> Looking at one call site:
> 
>                  bpf_timer_cancel_and_free(elem->key +
>                                            round_up(htab->map.key_size, 
> 8) +
>                                            htab->map.timer_off);
> 
> So I am talking about to have
>     *(struct bpf_timer *)value = (struct bpf_timer){};
> The timer->timer is for bpf_hrtimer.

Sorry. You are correct. timer->timer indeed sets the 'timer' part of
the value to NULL (0). It is probably somewhere else is leaking.
Let me check again.

> 
>>
>>>   3. one hash_elem is picked up from the free list,
>>>      and proper value is copied to the value except value->timer
>>>      and value->spinlock (if they exist). This happens with this patch.
>>>   4. some later kernel functions may see value->timer is set and
>>>      do something bad ...
>>
>> -- 
>> Kartikeya
