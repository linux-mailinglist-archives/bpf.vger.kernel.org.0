Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049CC6572EE
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 06:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiL1FYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 00:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiL1FYW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 00:24:22 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E4DF64;
        Tue, 27 Dec 2022 21:24:21 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRNDPkW011188;
        Tue, 27 Dec 2022 21:23:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=NjBmf07ISxdjTBnqLamMAQoDep1mn1isVcdNNooUa6o=;
 b=cHlXPDO/HZF07W7Kaj3of6ajmvR28mqADkkiSbufmEPbJWq2JDN8n2DHC0M82MBWj5Iu
 +UXbeyWUaGT6aLG2jVwg47hjhgg5JofFxzL4wbYfFbIIwy/Y0cxtmm9OlMNrk/xSJ/km
 gStm37AAEsSTiGm4NGcIktBX/ZkgFuBHNXGu89oQYBdafXOomquy2I7OdV7Bphat0otP
 vIzU1ZEykuMvpPisbnGi5DqZmqQtcqMTSjM7b2SoNJmkS2zB0MrA06FEZ+uwBLhQo0nT
 0/vl7361U5VHka+wad0/LVw/YjwMyGNv5S0VAMC4LiYcTh00vwVfA1RWju45Sd8FbQwd IQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mnye59ru7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 21:23:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdlH6NUBw6lxusaXYCG0UBeneVx5RYf462Dadrpdpf9tCS567tEr2pMkZLkgqp1pBUsINCDZ0IBWrb2Kw72dVtjtKN5igsyjeuX8k91MBWYkr7AUFIcI570kSv0kxWLntQcwoCyBj/HCGE2JSYhy1l+jEBDE4rdjKzz29ngf9cFRfWbJmrNZQD4LQtUk7kho9c2srJGeS2YtbFSpQyGKFC+h/FEdgpHt8BK6klt1h38+m1+9yKBgCH+cm9ry0fBF+lhX6ACDMcvUzecedEHHX1t68EQpfsdx3C2roZuXyEZjqdowXWWTs326liwzcL+SVqexF8ezUPEDDWthtvqDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=athQcBu/0K1PKpDrzopGhxI1/aUNHbM7vCDILWLApEI=;
 b=h8IajieMshOPyIO2/dcvz3wcR4DdnufpvqZ9ehAiEcMXOv+T9V7fLZTyQBT6PWltHM+Yz14pW4jEENMgcRJyzVuvXyDmEjZ+r6ip3629NtaXNL/5a8aMMAJM8mNaOA72rp5r7jX8WMyZLu5n09dNKn0lEHwTZDIYcWKCRR1y7Vs7RSQhYVowJxKGvYoYp+pBpquuCFOjwvfaFgaBUQH++2kbYs8dHB3FqKG8lIgXoGw2u7S8XqahI20Y7lUoCCXEPFzD6WsADLmjrwNOVg6qdoxmkrztNIBwzgwQfZNCsDmoStl8UZc3bD/XrnA3+xVJJaLSxgGl5UHKIIv8durfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA0PR15MB5936.namprd15.prod.outlook.com (2603:10b6:208:3dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 05:23:56 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 05:23:55 +0000
Message-ID: <ba5aacc8-7e10-e20a-936b-f3f81d7fcf03@meta.com>
Date:   Tue, 27 Dec 2022 21:23:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: WARNING in __mark_chain_precision
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, sdf@google.com
Cc:     Hao Sun <sunhao.th@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CACkBjsaXNceR8ZjkLG=dT3P=4A8SBsg0Z5h5PWLryF5=ghKq=g@mail.gmail.com>
 <Y6C36gvJ2JnwKm3X@google.com>
 <CAEf4BzbY8SDL04W_3Vot6iiYu69Lqg9W9aMCp26+RwLBh6C_0g@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAEf4BzbY8SDL04W_3Vot6iiYu69Lqg9W9aMCp26+RwLBh6C_0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA0PR15MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf57e4c-e43a-4575-89be-08dae893b719
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6HnWwtnLuRrBtSbeBG2VhO7I9AJ4GxnAw9+GXeJ8OKx4yioAzf6tNIRsuWptHs2WiLqj7STRatRiXYrtd0xhi0gvaC0DI1afJaFcrdS2VjcNOPkcAQujahtcxu2ShmNNWcn5NwMozT8HSsb+VQPmmRinTQRvpYrdHNMUHU6zg9Kj8HJG7I2Ll3ZBOk99gIxqhPWahgkqWXBZDMGpWL/hnx40k3KU3Jv9wkVlrr4epsQFqRmPcpEh4U2HtVjvV9mymfVXg9qBysGWlYv6592IPrf5UoEe5batwpGVMGmkqv2UV3S+l7631KggTZgPRL5WifcpO0h548V63ZABoFw/lalSbx7+x1B0VI4EHDOBm2Nm3s81eoXfmYwwvLHdIfoV049O8X95zFnBfNeZfGZrHq5E/TP/u8RE+al1ADn76TdXA1Jj8CIsPl9EvDK5Oeylcu7UZLG7MJ+7I3KBJ1XGH5yUxC3HUTLnFn7zlUtarAVVqLNnli4W8iUT5O+bXRmYJUmyXusgz+xM9cGgdimJ6bjdFe9vqNqQ8Gjqx5oeJpnx396rISht8VUQH/btZg9dHbxV+0/INne/nK9iAx6WDA16ybpSYb3nBcWW4qeDobaDRBypkBgOb0gk15nFkG9MIfFWC+3eFBwiisWMwZbeC1JTNs5v/IF6lEjYLkm1Br4Qdmxop1ECz0QbJL995ulxNIl8OqIV9d9q93lyI20YTUrsm7vJ7Pon9k72dP2wXROJt1WNGANTn82oF/2QRi9h8W2W1jynnjTkVSeuU9GsPE6EuqfHtUV8kHJmmtzLPUgrgKxVL78195xbMhZSKlI86PvRLQdJ6MOMQlYoN1/54w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(6512007)(186003)(45080400002)(2616005)(38100700002)(83380400001)(966005)(6486002)(478600001)(6666004)(36756003)(53546011)(31686004)(6506007)(86362001)(31696002)(8936002)(41300700001)(316002)(66556008)(2906002)(54906003)(66946007)(66476007)(7416002)(5660300002)(4326008)(8676002)(10126625003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXdidVV6Zzk1NlRIaVpINTB1dkxlbi8raHJ0Smx6RVYzaU9FRkpnZzNmSjRD?=
 =?utf-8?B?cnFFVU9OUUc3b0c5d1N3eXFIM2dUaVd3WVB1Q0VQTVJnRFZHV0U1T3ZYaEV2?=
 =?utf-8?B?d2kzYndmcStwYWo1Qkl6Z0JOcUdVb2cxYmRncXgyaXNiOTVxSWZXdWFMLzdZ?=
 =?utf-8?B?T2hrVmZReTAzQXkxd01IRnQ5WnJ5eThOTXBjR3hpaHdiQytPakd5NTRKZm1N?=
 =?utf-8?B?RUQ3OVVWYUZDazgxQXZRWmpIclNwK1ZKSzNvQmRiV3Nwb1ZNOUhOMkJLbmla?=
 =?utf-8?B?cVluN2lZOU1ieE52Y0xzdlJjQzZGTmVhcUt2RjZ4UDZGb0pqVm8xRG50bi8v?=
 =?utf-8?B?eFVyOER2MWRjR0dlbEdFZStCUUtGTXBMcHlFbzc3V3A2REd1RGUzM1ZoMlVS?=
 =?utf-8?B?bWdhckNBNnF5STRkYVN0V0ZNemJxWU5NZ1NNcjVPZzZTN0U3QTVFRURYeEVj?=
 =?utf-8?B?K0FPOUQzMS9iSUQ5MnQ0eDd1Z1pZMDRFWStsZ2NvV29aNHQxTm9HMi90ZnRj?=
 =?utf-8?B?THpsOVRQRHg4eU5TeUdDeEF1ZE43VnhXaUg0bUd1bGtaUE1jSHExQXI2ek0y?=
 =?utf-8?B?cU5mby9YWU1FT1JjZU9rSUQ2OTZMVy83WmNSdnAyU1BwUkpHTnducml0KzNB?=
 =?utf-8?B?b2VGdjRvL01RQTJXNUlackFYNjhxZ0VGdll1TEYrbEdPUllqeXdjU0ZDbFo4?=
 =?utf-8?B?VFMzL0E5SkR6N0pXZTFWVU5GWFd3dU5zMklrb0ppaWVZTnpjWDk3eVJHWms5?=
 =?utf-8?B?SnlXTXBFWkVwSlp2V2FFaDBPakUyWUdvbk41MzVPdFNlQWRKY1BmUnVOQlpp?=
 =?utf-8?B?b2xoZTBxdHB2TzJtUFdaYWJVdHV6RUZwWVVDQWhtN0FQT082ZTI5L3NPMHht?=
 =?utf-8?B?bkVJM1dBVzNRNHFjQlc0Wnkzblk3NkNadXJmSDY0NGg2ais0VjJPNnppRlVS?=
 =?utf-8?B?K3dvdXd4YXNrZFAzRy96NE9NYjJQZlUyZ0dXeFpDS3VWeTdocVNMUE5ZV1Q2?=
 =?utf-8?B?T3VZa3A2bDlQMDBaZ0NVeG1OL0N0dGRJWU1JUVM1eWt1akF4cldIbzFIU1NS?=
 =?utf-8?B?UkgyL3JOMGdraDllQWtrcWpKZ1gyOTFTU3NQS1pGakdsR1p3MzU0V3lBMVds?=
 =?utf-8?B?di9BRElvMDNCMFhYeFh6SElXV3ZuWkdDL1RtbkdHQzR2UHRoRjRjcEJxb1NH?=
 =?utf-8?B?dTlqNytFV21KZmxuZFJRV3BsVjV5alh2eSt5d05JeDNONGFpQmVIbk9pMm1G?=
 =?utf-8?B?UDRLZUhyQUo2Y0ZNelB5SnZoMEppRUFEUTAzaW5LM2dYSThkaEVVcWVva2Vh?=
 =?utf-8?B?cFIvdk5aQzFmbnhWdWg2OWg1WlRrYUFyejhsczJKc0l0STFYTFVCN3pFYnEv?=
 =?utf-8?B?Y2Y0ZzBkRmV0RzUrY2owV3dCM0VQb2ljd2hGTlRxcU84UkhIZ1NpWWVyRG82?=
 =?utf-8?B?cXpFVVFJcm5WSzhSMHJkZXVpK0E1WE8wT3BDZG56K29EOXhBNkVJeExEOFV6?=
 =?utf-8?B?N0Vpa3pyMy84N25TTTArd3Q0eEtTRzZNcC9RblppcWE3WUZNQ1hjNVVib0F4?=
 =?utf-8?B?QmtmMC83K0xSVWZxVVJMbmdQWWJaL0pOUzJRSDhBOU44WkJJM2NHQTg5bGFR?=
 =?utf-8?B?R01XVlZhUUp1L0ZzS3lJODFVeFNoVHM4cmNvdHRPSnBQWnBGRGFXTWRvQlYv?=
 =?utf-8?B?dUZBTS9uRWhiMFJGU1kwOW9hcGFHZDFBVEY2cWYvcGkrWERKZHBVZE9Ka0tE?=
 =?utf-8?B?NkdxTEFudmk3MW1YaEtaTUFESHE1ejhSREc4dG1wd3F6ZTgyREo5RlhkbjlF?=
 =?utf-8?B?blJwT1p6YW1LejZUbFFmbUtYZWR2bkJBQjU1ZXlBZllPMGVQVHNTVzlBa3ky?=
 =?utf-8?B?MThYb085MlQvSUQ2aXc5UXdxa1piRkkrODRSSHFxQVpKSEFpa1FuRTV4SHdF?=
 =?utf-8?B?bkt0VmZyem1HNUg5YlRaRW1iS0NWN3N0MGdIU1oxYXgxOGZqME0wWnhqdDQw?=
 =?utf-8?B?eTdTa0ExY0x6ME1xdWJxekx4WVF0QStnSWFDTnp0R1Z1eWdUV2N2T1ZVcVdW?=
 =?utf-8?B?dW9uSTN3K2hJYzhhY1J5byszelBJUEc5QXJZbWFUR2hRSlZ1UGlSOXJNVEh0?=
 =?utf-8?B?WGFHT2x6SzhhTTJvQUFubjgza3VOSVJXS1JTZDkvbUd4bkpLVStieVA0MjFO?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf57e4c-e43a-4575-89be-08dae893b719
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 05:23:55.7805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muF2oa+9GEsTwefS5MlYLnUm1KAGqR3DNwYIfud0L+nJbXpjrinBWxtzC8oeH/2D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5936
X-Proofpoint-GUID: efZyha1k_bcUrVwhhVcQ_qHmnBakWMgS
X-Proofpoint-ORIG-GUID: efZyha1k_bcUrVwhhVcQ_qHmnBakWMgS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_02,2022-12-27_01,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/20/22 4:30 PM, Andrii Nakryiko wrote:
> On Mon, Dec 19, 2022 at 11:13 AM <sdf@google.com> wrote:
>>
>> On 12/19, Hao Sun wrote:
>>> Hi,
>>
>>> The following backtracking bug can be triggered on the latest bpf-next and
>>> Linux 6.1 with the C prog provided. I don't have enough knowledge about
>>> this part in the verifier, don't know how to fix this.
>>
>> Maybe something related to commit be2ef8161572 ("bpf: allow precision
>> tracking
>> for programs with subprogs") and/or the related ones?
>>
>>
>>> This can be reproduced on:
>>
>>> HEAD commit: 0e43662e61f2 tools/resolve_btfids: Use pkg-config to locate
>>> libelf
>>> git tree: bpf-next
>>> console log: https://pastebin.com/raw/45hZ7iqm
>>> kernel config: https://pastebin.com/raw/0pu1CHRm
>>> C reproducer: https://pastebin.com/raw/tqsiezvT
>>
>>> func#0 @0
>>> 0: R1=ctx(off=0,imm=0) R10=fp0
>>> 0: (18) r2 = 0x8000000000000          ; R2_w=2251799813685248
>>> 2: (18) r6 = 0xffff888027358000       ;
>>> R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>>> 4: (18) r7 = 0xffff88802735a000       ;
>>> R7_w=map_ptr(off=0,ks=156,vs=2624,imm=0)
>>> 6: (18) r8 = 0xffff88802735e000       ;
>>> R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0)
>>> 8: (18) r9 = 0x8e9700000000           ; R9_w=156779191205888
>>> 10: (36) if w9 >= 0xffffffe3 goto pc+1
>>> last_idx 10 first_idx 0
>>> regs=200 stack=0 before 8: (18) r9 = 0x8e9700000000
>>> 11: R9_w=156779191205888
>>> 11: (85) call #0
>>> 12: (cc) w2 s>>= w7
> 
> w2 should have been set to NOT_INIT (because r1-r5 are clobbered by
> calls) and rejected here as !read_ok (see check_reg_arg()) before
> attempting to mark precision for r2. Can you please try to debug and
> understand why that didn't happen here?

The verifier is doing the right thing here and the 'call #0' does
implicitly cleared r1-r5.

So for 'w2 s>>= w7', since w2 is used, the verifier tries to find
its definition by backtracing. It encountered 'call #0', which clears
r1-r5. Since w2 is not defined, the verifier issued the error:
   BUG regs 4

The specific verifier code is in backtrack_insn():

         } else if (class == BPF_JMP || class == BPF_JMP32) {
                 if (opcode == BPF_CALL) {
                         if (insn->src_reg == BPF_PSEUDO_CALL)
                                 return -ENOTSUPP;
                         /* BPF helpers that invoke callback subprogs are
                          * equivalent to BPF_PSEUDO_CALL above
                          */
                         if (insn->src_reg == 0 && 
is_callback_calling_function(insn->imm))
                                 return -ENOTSUPP;
                         /* regular helper call sets R0 */
                         *reg_mask &= ~1;
                         if (*reg_mask & 0x3f) {
                                 /* if backtracing was looking for 
registers R1-R5
                                  * they should have been found already.
                                  */
                                 verbose(env, "BUG regs %x\n", *reg_mask);
                                 WARN_ONCE(1, "verifier backtracking bug");
                                 return -EFAULT;
                         }
                 }

Note that the above mask '0x3f' which corresponds to registers r1-r5.
If it tries to find the definition for any of them, 'BUG regs <mask>'
will be printed out.


> 
> 
>>> last_idx 12 first_idx 12
>>> parent didn't have regs=4 stack=0 marks: R1=ctx(off=0,imm=0)
>>> R2_rw=P2251799813685248 R6_w=map_ptr(off=0,ks=3032,vs=3664,imm=0)
>>> R7_rw=map_ptr(off=0,ks=156,vs=2624,imm=0)
>>> R8_w=map_ptr(off=0,ks=2396,vs=76,imm=0) R9_w=156779191205888 R10=fp0
>>> last_idx 11 first_idx 0
>>> regs=4 stack=0 before 11: (85) call #0
>>> BUG regs 4
>>> processed 8 insns (limit 1000000) max_states_per_insn 0 total_states 1
>>> peak_states 1 mark_read 1
>>
>>> ------------[ cut here ]------------
>>> verifier backtracking bug
>>> WARNING: CPU: 6 PID: 8646 at kernel/bpf/verifier.c:2756 backtrack_insn
>>> kernel/bpf/verifier.c:2756 [inline]
>>> WARNING: CPU: 6 PID: 8646 at kernel/bpf/verifier.c:2756
>>> __mark_chain_precision+0x1baf/0x1d70 kernel/bpf/verifier.c:3065
>>> Modules linked in:
>>> CPU: 6 PID: 8646 Comm: a.out Not tainted 6.1.0-09634-g0e43662e61f2 #146
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux
>>> 1.16.1-1-1 04/01/2014
>>> RIP: 0010:backtrack_insn kernel/bpf/verifier.c:2756 [inline]
>>> RIP: 0010:__mark_chain_precision+0x1baf/0x1d70 kernel/bpf/verifier.c:3065
>>> Code: 0d 31 ff 89 de e8 91 ec ed ff 84 db 0f 85 ef fe ff ff e8 b4 f0
>>> ed ff 48 c7 c7 e0 8f 53 8a c6 05 28 71 ab 0d 01 e8 83 b3 1e 08 <0f> 0b
>>> e9 50 f8 ff ff 48 8b 74 24 38 48 c7 c7 80 d0 63 8d e8 49 46
>>> RSP: 0018:ffffc9001463f1a0 EFLAGS: 00010282
>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
>>> RDX: ffff888020470000 RSI: ffffffff816662c0 RDI: fffff520028c7e26
>>> RBP: 0000000000000004 R08: 0000000000000005 R09: 0000000000000000
>>> R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000000020
>>> R13: dffffc0000000000 R14: 000000000000000b R15: ffff88802be74000
>>> FS: 00007fd3daeb8440(0000) GS:ffff888063980000(0000)
>>> knlGS:0000000000000000
>>> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000000020000240 CR3: 0000000017394000 CR4: 0000000000750ee0
>>> PKRU: 55555554
>>> Call Trace:
>>> <TASK>
>>> mark_chain_precision kernel/bpf/verifier.c:3165 [inline]
>>> adjust_reg_min_max_vals+0x981/0x58d0 kernel/bpf/verifier.c:10715
>>> check_alu_op+0x380/0x1820 kernel/bpf/verifier.c:10928
>>> do_check kernel/bpf/verifier.c:13821 [inline]
>>> do_check_common+0x1c3b/0xe520 kernel/bpf/verifier.c:16289
>>> do_check_main kernel/bpf/verifier.c:16352 [inline]
>>> bpf_check+0x83b4/0xb310 kernel/bpf/verifier.c:16936
>>> bpf_prog_load+0xf7a/0x21a0 kernel/bpf/syscall.c:2619
>>> __sys_bpf+0xf03/0x5840 kernel/bpf/syscall.c:4979
>>> __do_sys_bpf kernel/bpf/syscall.c:5083 [inline]
>>> __se_sys_bpf kernel/bpf/syscall.c:5081 [inline]
>>> __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5081
>>> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>> do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
>>> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>> RIP: 0033:0x7fd3da8e4469
>>> Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48
>>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>>> 01 f0 ff ff 73 01 c3 48 8b 0d ff 49 2b 00 f7 d8 64 89 01 48
>>> RSP: 002b:00007fff090c1a78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
>>> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd3da8e4469
>>> RDX: 0000000000000080 RSI: 0000000020000840 RDI: 0000000000000005
>>> RBP: 00007fff090c2a90 R08: 00007fd3da92e160 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000561aefc006c0
>>> R13: 00007fff090c2b70 R14: 0000000000000000 R15: 0000000000000000
>>> </TASK>
