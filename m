Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1D354A93A
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 08:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiFNGJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 02:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344027AbiFNGJg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 02:09:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2922D18E33
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 23:09:36 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E1phxB028500;
        Mon, 13 Jun 2022 23:09:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xBVRrCVhE588N35ymClP4oX3EakE255eKb2zOLifk28=;
 b=TimK3O1/J19cXMMEnR7off3M4P83c/vncGc0HihjGxGuHCPi10T8aotLfGjFt2E5dIQg
 eIlHA66y5mIrRsK08mSkx0m5EmZ6E18Cn+Ksmm/NQB0qBJAnpphTyugRfvd6hiqLidOr
 CHmK+FtwSxpCt5SyTyzBmw+R2n24f8iGseA= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gpddahv9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jun 2022 23:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQqNR3248PNThnYi5OJ3fzQ3/H5zhPG2slsi5JLvUSe42syU2nEcc5K4YdHMhFWUguasGk2br1iSi5n6p5pIAZamslEEZOcG7TY4NDM0atHYZIoI3DkgcKFAs0CXg8iTdkiVwBKhaTKE4TYdJg1rqZbLh7DgLwVLDs8mc4lW3MHZQZK0Dj/nkY/xAVee6jlz8S+5vX2Sm2uroUYStEa66YzVBK30qTS8Iq/wJkaDtC85BUcCLh3tdZd3goUmechXo29fcOYYGIMtnNGGGMJ7yYMYvmXOuVg5b69kfpUfLXI7YCVGDpaASiZIJjYHLDUstsLcr8a/JWjuEoIDC0qXbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPzudtEUZvYSFu+S2j84LFQX3pcEBO8xwBNxCbdXODI=;
 b=dZeHar2yhrWA922PC+HHF3c2KJfZZowGPIABEJBY/L5AT1LU/SaC00H3MKw7xOqYYZD0wHuZzpZlwHdlpcGtEZXR3+3k1Ux0RTqhD7KN1lUGGhEo/FjjsTkNnV6xZRvGWu5tLEcQ7w0TkRU9q3v9cLD1NhvHTMTV+WGScl+zY9FCZ+CGqIc+n2vpkiKbFU3gxcftIkGTGz390+hdQmBHXfBM0h6OTM9IVSTVrotCfVwC1xZtxGETLKMVLCpNE5slNVf7wzVmN+63/w43f1vpcqzIXiV5sQSI+bsxgUn+6dVxnjiQTx9Ek+LL4L53lxtV9MJ1nAeVjucm55/CN9e7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4414.namprd15.prod.outlook.com (2603:10b6:510:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22; Tue, 14 Jun
 2022 06:09:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::fde9:4:70a9:48c2%7]) with mapi id 15.20.5332.017; Tue, 14 Jun 2022
 06:09:14 +0000
Message-ID: <621b35ac-5c93-9a6d-eaf0-62cceb52cf34@fb.com>
Date:   Mon, 13 Jun 2022 23:09:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] bpf: fix rq lock recursion issue
Content-Language: en-US
To:     Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        'Alexei Starovoitov' <alexei.starovoitov@gmail.com>
Cc:     =?UTF-8?B?J1Rva2UgSMO4aWxhbmQtSsO4cmdlbnNlbic=?= <toke@redhat.com>,
        'bpf' <bpf@vger.kernel.org>,
        'Alexei Starovoitov' <ast@kernel.org>,
        'Andrii Nakryiko' <andrii@kernel.org>,
        'Daniel Borkmann' <daniel@iogearbox.net>,
        'Joanne Koong' <joannelkoong@gmail.com>,
        'Jesper Dangaard Brouer' <brouer@redhat.com>
References: <20220613025244.31595-1-quic_satyap@quicinc.com>
 <87r13s2a0j.fsf@toke.dk> <fc16df47-df2b-ffa2-4e66-5a3dc92cb4db@fb.com>
 <005f01d87f4d$9a075210$ce15f630$@quicinc.com>
 <CAADnVQJUyvhqjnn9OuB=GN=NgA3Wu59fQqLM8nzg_TWh1HnJ4Q@mail.gmail.com>
 <006701d87f6d$7fe0a060$7fa1e120$@quicinc.com>
 <CAADnVQKq-e1TT1Y2uhgCaRY4CUP37dq0HuSyTdgtxkNfv8DQUg@mail.gmail.com>
 <009d01d87f8b$79f83140$6de893c0$@quicinc.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <009d01d87f8b$79f83140$6de893c0$@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MWHPR1601CA0012.namprd16.prod.outlook.com
 (2603:10b6:300:da::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16a132eb-61f7-4f74-4057-08da4dcc6847
X-MS-TrafficTypeDiagnostic: PH0PR15MB4414:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB4414C48DDC84E9200DB8ADB1D3AA9@PH0PR15MB4414.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UnYFoAOzMXhjnlXtaT5vtW/7kwWeldm/RaZeI943L26BCXKcO2GYA7ZlaL25AxeiOFR5NARDm9ASYOTNtwZErI7geDcNlt80bSqB1LYWouHGJmGOl0f+6o5UIpzuutWVOvwdg4PissEAFyje1h74f3gsVkuTwgX7YgfYKjsY3o1qh9lvzFWqqmDqVkoONfNZ1c8dKcLMcX9ypzN11fMf3HoqqXfk+kpRuSzWvHHXcAlsdh/ZnDZ7yn2P1SYNao2PlQAKGrcxYtCZnCilcIkDX2Z63PIvrsjvS/GklDY3K2SkkRr/Fw3Eezxduz8V6uy5NHxhgQ99tHSKaoE7p9mhB6xC8tQr1yhZiCdmEyXIsVUrOsUMiVrVtg3RkngOHzmq0s0S3ZRdrgSTeGAe74+Vl5zb5VtFdwYHvdWsamrspm4dff+LTyfI+qGOFtragehRLknvuAS6z/P3Z2VWdN6gONGHFdSYu2HFCwlr4FR8B2cizciSNfnFBA1fcrku9v6tZ8gIB49n1Tq0AFXzTjHUYAlRwbLLym/H8gIPyXbRC7T8EAWKdym6wLslTq3oCVBfiLoqeieeBoNJQLRhsg+x3KinGVBb16UHEdOqRJjloKXtdr/7y5/IFbW9Nw223LneLQZ7dgFnGitU5w/v02rfEKNRqCwBAZ61sFr7xNRibd+0ozj2/yTxebfVm1fdq5WpQyLAFPtplMg1ooZqAvj7giALhiPJKewhooT2N2o39RCTao1rQlRmghPu24h0NN2vbX7yKmex0Y2P247Yh/MOm3BLlxHt/+jolRaC7phOVgaRbEDci1zFWcQaqI+h0Mp3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(36756003)(66556008)(110136005)(54906003)(53546011)(31686004)(4326008)(66476007)(66946007)(8676002)(31696002)(8936002)(316002)(38100700002)(6506007)(6512007)(508600001)(2906002)(83380400001)(6486002)(966005)(2616005)(86362001)(186003)(6666004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2NoS0xLVVAwNUI0K3F3OENjN2t4TDUxaGR3bWt1NitUdDBvSGZDZjRaWUNX?=
 =?utf-8?B?clVMOE83cml6K3BJb0RnMWFGdGhhSFJrZXg1TXkvZ2wzL1o4MnhDT3FsZUw4?=
 =?utf-8?B?cE5CcmdhM1h3VXl6WXNaVytraWs2aEhPM2dCM0lzR01Ma0QrdENPQVRKc05H?=
 =?utf-8?B?c1JubFlJZWU2Vit3UDBRdmxTUGdyTTRDdm1nT0kwSitUY1phWms5VFp2Kzhp?=
 =?utf-8?B?QkpDcnRYNGZwL1k0ZVJZVjRVakR2NVI1eHp6M3pHRTZldGNrSnh5U0w4TVFS?=
 =?utf-8?B?RzNSQ3ZMVU1Xb0l4Q2dncnRpdjQzTkkvNEhVMnM2ZmozZ05RdE1jUUVOZjQw?=
 =?utf-8?B?eEU2cHp2SjNCeDVDL1FpQTBrQmp0SHV1b2E1d1BjWFVoQTdxZXRDVGdtWTFM?=
 =?utf-8?B?NVh3bGM3cFlnWUNtMmlLN3hnSUR4TVkyNURmZWVrdzRsUjFUQnBlZlY2SFFm?=
 =?utf-8?B?SE4zSWZwUkRXK2lOWXpsQXhwY0lsZEhxZjBUSWFNcUd2S0Z4SDFHazc2NG84?=
 =?utf-8?B?dnRtTlFYeUMyWE5TY3hTZzJjOUFDMGs5SDkxYUo3bUZlUDk1ME5SQXFOSnJR?=
 =?utf-8?B?bnJhdVJJa0VMUnBZTFZlcEtWR2poSEY3TW13TmxzdzBiTjNwaDQrWm9UcnRC?=
 =?utf-8?B?YWg2eU1XQ3Y2Z1lxVDNhMEY0Z2M5dEdCNXJpSThzZEJGZ3lOWmVLK1BFbXVo?=
 =?utf-8?B?SjZjMWw0bTJZdWR2Sklzd21PY3NHMStBcHlpdEFYdE42ODFOMUR0WUxha2ZI?=
 =?utf-8?B?a1RRQnZwUnAzQm1pQ1diRWM0MmRLVktNeS9yZ0JURmJBYisrU0ozSHpMVUNW?=
 =?utf-8?B?STNiWDhoWWd5d1hBQm15eVlPKzdYdmFIWjBqV2FsTnAwREpYelZZUE56am5F?=
 =?utf-8?B?dzZ2TXgxK1Z5UTRIMEt3ejRWZ1lJRjA4NkU1TlUvMU41TlpXWW90eTA1UFVE?=
 =?utf-8?B?dE1QTUN5WWNCdGd1YVdtOWpRd3NrMXpzVzNGTmIydVRBSkZJa2N3SzlXSHlC?=
 =?utf-8?B?SXFjblgvSU80MFZqbzVhTk1SVVZaRUdBWUVMVnFWZUhzMGZIMmxpNHVjWTgz?=
 =?utf-8?B?b3lGOHRNUW5HY2FFaHZJTWhWY0N4emV3Zk1jMnVGSk1rRU1KUGwvcFZYMEdp?=
 =?utf-8?B?NXJySUpkMXhLMmZnTlN4QTQ0clczeTdJYWlVa0xDZnFjSXNkQWMvYitqWmZJ?=
 =?utf-8?B?T3dQUmtMK3B3MFRGVTg2ZlhvTy9SRzRjeVdEcTBOWWc2Zk1mZk5KcGhHUW9Z?=
 =?utf-8?B?REUvWHdwaWZlNUxlNjR0bHhCblltTHlMUlVHOHV2bFViVERzeWRmUHB3WDAw?=
 =?utf-8?B?cmhQTllmS2kwT29aNFBjVk1Hc25ZY0hyQjVsa1Z6c2lzSjBRVlIxQnZtM1lJ?=
 =?utf-8?B?WFdIWVN1MER0VDVKQVZjQlNOSTZKREhTU3ZkVnliQjA0RDdHdUtPUElybnVV?=
 =?utf-8?B?d0c3Skh2WC9hWU9ZRHZqY1IvZ0V4eG9kajdaeDZwSUpWWGRvRkFkVVI4elB0?=
 =?utf-8?B?cmh5aDg3Nk50dVJrM2JuYUY5WG1renltQms2TjNKS082TWwwemtUL2lDaEFY?=
 =?utf-8?B?NzZ1clVveXJQU3BEZlpnNnlETXk4MGR0MGlxVzROR0tWekMwY0s3bEZaN1lP?=
 =?utf-8?B?dS9WZlBONWpZS2l2VmpneGhGTzJaN3p2Nnc4a0J0NWY3alNibXUxamk1Mzk4?=
 =?utf-8?B?eStpb3VINTlEWGJLNXNLdjlESEswZWUrQWEwZFEraDZhUk5oVkJoK3lIVHdq?=
 =?utf-8?B?T2gvVmJJb0F5Nkk0MXpPTkcwMkt4a2dHRjRzQTBRUzAzTFE2SlY3UWp5REQ0?=
 =?utf-8?B?b2dhODI5VlgvL3hVMEFZMzZIN3FENEUxTzVNWURtSitva1IwaUhISFE1QWVH?=
 =?utf-8?B?NXFXdUZvbjhrV3c1ano1dnlFSUNMMWZ2NEYyQWVEcTVKdHFRWU9rTm8xK0pY?=
 =?utf-8?B?YmdYaFBwUE1iL0ZGMzNUOE1iSWVOeVZ2QUVNOHVYeUFscjFwdkZ5ckJhY2Rz?=
 =?utf-8?B?TUVnUHNmYWpvUnFzTGZMWXNGUjR1WFVNUUQrUzlNaFA3eldaaTVpVzZkZ0Jr?=
 =?utf-8?B?WS9BNWZIczZNUlhlOHFlalJKTWdUeXFCZnFpMW5aSVlsbE5DQzNWY3hjeEpO?=
 =?utf-8?B?MWJjWGNYY212NjJRSksrR3BYS2ZRV2Y4RWpPZ2FUNHRxSHIzaVdOMWM4RTlW?=
 =?utf-8?B?TkVaek03cWtGdnZvVnlJOHl5N3BuUHB5OXBOWlI4Q25WaUxLb1hVV0R3TU1i?=
 =?utf-8?B?QVRHQmxpdS8zTmR0VVhCYTlkeHhBelJNdkRNek1JZy9rSkFWSlFtYmRKK0xJ?=
 =?utf-8?B?N1o5QVp1VFJRZWV4RE1jMUZ2ZzRpSVdIQ2VHdW8wNjhBNzh3eEhCeWZYelZv?=
 =?utf-8?Q?JvepNyE9NB6l1S/s=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a132eb-61f7-4f74-4057-08da4dcc6847
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 06:09:14.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVJfZuh1DAda1y82z9z7FMH2NscWgNXVMk/3AkBNeO1nLh4Yf25W6M5UJ30Kj7MM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4414
X-Proofpoint-GUID: URiTLHnf2Ec9vrr3O2f4CAAN889TJaJ2
X-Proofpoint-ORIG-GUID: URiTLHnf2Ec9vrr3O2f4CAAN889TJaJ2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_02,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/13/22 6:10 PM, Satya Durga Srinivasu Prabhala wrote:
> 
> On 6/13/22 2:49 PM, Alexei Starovoitov wrote:
>> On Mon, Jun 13, 2022 at 2:35 PM Satya Durga Srinivasu Prabhala
>> <quic_satyap@quicinc.com> wrote:
>>>
>>> On 6/13/22 2:01 PM, Alexei Starovoitov wrote:
>>>> is doesn't solve anything.
>>>> Please provide a reproducer.
>>> I'm trying to find an easy way to repro the issue, so far, unsuccessful.
>>>
>>>> iirc the task's affinity change can race even with preemption disabled
>>>> on this cpu. Why would s/migrate/preemption/ address the deadlock ?
>>> I don't think task's affinity change races with preemption 
>>> disabled/enabled.
>>>
>>> Switching to preemption disable/enable calls helps as it's just simple
>>> counter increment and decrement with a barrier, but with migrate
>>> disable/enable when task's affinity changes, we run into recursive bug
>>> due to rq lock.
>> As Yonghong already explained, replacing migrate_disable
>> with preempt_disable around bpf prog invocation is not an option.
> 
> If I understand correctly, Yonghong mentioned that replacing migrate_
> with preempt_ won't work for RT Kernels and migrate_ APIs were introduced
> for RT Kernels is what he was pointing to. I went back and cross checked
> on 5.10 LTS Kernel, I see that the migrate_ calls end up just calling into
> preemt_ calls [1]. So far non-RT kernels, sticking to preemt_ calls should
> still work. Please let me know if I missed anything.

Yes, old kernel migrate_disable/enable() implementation with
simply preempt_disable/enable() are transitional. You can check
5.12 kernel migrate_disable/enable() implementation. Note that
your patch, if accepted, will apply to the latest kernel. So we
cannot simply replace migrate_disable() with prempt_disable(),
which won't work for RT kernel.

> 
> [1]
> https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.10/include/linux/preempt.h#335 
> 
