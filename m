Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850DD4B1A36
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 01:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346194AbiBKANn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 19:13:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbiBKANn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 19:13:43 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50D3270A
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 16:13:42 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21ANrIe9013553;
        Thu, 10 Feb 2022 16:13:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/+Mzlqvr6Nq6WazxEHPB+BPDAY2F0uuq9KZvgO3+HhQ=;
 b=lXdxcjBjdsWR2oCEh2fnasaZo+8SGDrc2xgEe1Eprrbl1sTav4BQve5IfXNPNPbhYZbl
 w6zpbBkU8LXIU/WEg4/L3RabJjoMcX0FNxIKdvdjHRnw/48Zcrxb/jzoebK6k7jFcyha
 JzgRAj8dv+mmf6HoIHWqF6ONYTCCDec44Tg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58e1j3mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 16:13:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 16:13:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzQb+KTmUcezMG8wDh+iNDiQZRizIE2U3Fyj1H0byw44TK6OCEu5ctZEvb6n4BSCEpI2iKgcAHlwAsUCd8wUz9mSNGa7wK7FXuyM8V3MYS/N3dfI3cRN0OGVmfbTTAalVP3rk4CfKNfkbqM0S8MkoMV8AHrwj5eOFPvcGoKZo15tphzpcAK48uQIWnSEM/8qCy8G3oOVpicBub5Ggmjj6miXssQ+6JjbumiZtGe1zaiWR+HG08B5KBiBJTG21g8r9RBz97gd8FwjFW/vJysD3j+gFaACs5AB8TZEuVtaiZH7F7nk0ATQa8gg46Ybw64LEObC3+R49ZcLIsVgeWlfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+Mzlqvr6Nq6WazxEHPB+BPDAY2F0uuq9KZvgO3+HhQ=;
 b=jTKqijcwiAEn5D980K76Roi6sp232pO8raeugv7ZXNSl0S6hkCq/KTz3gimOMGwbnBZeg5JotNZB5CWOM0hjrFwrBclgXqGy2SRelRow+SaEKX/OrgALhnVxJJSwLP498Zs32I+ZCWCllbcm63st+aXtNV56Lagv/im6ClHpFujaRBwEfVCrJEIJ7mZK1TnjjROCQ6TppiJ2AepM/k6jYDiBtW9Xib0SfFpUdupwZGxdH9nLS0XxNFslGx6UmOnW+QvlK8NEopShwvid/GFudABGJdvMzSZUCOISFqOKNuZvTQzNW/ja9I3dnbR8bHgum6P8CpNLOU93sycnj2k7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3356.namprd15.prod.outlook.com (2603:10b6:5:165::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Fri, 11 Feb
 2022 00:13:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 00:13:24 +0000
Message-ID: <96931b07-2244-f5de-5bda-c62a464db2b1@fb.com>
Date:   Thu, 10 Feb 2022 16:13:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf v2 1/2] bpf: Fix crash due to incorrect copy_map_value
Content-Language: en-US
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
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220211000245.s27zktgzl7pzaqt6@apollo.legion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:303:b9::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 575a0d8f-b97c-4386-dd74-08d9ecf35211
X-MS-TrafficTypeDiagnostic: DM6PR15MB3356:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB33569AD63C4222BF7B5C4B63D3309@DM6PR15MB3356.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pep5tMoA8p/RLrqWmKPPt7MGjmz2tFAEncPgW3iyO2nIt7W/4h0eYZmRCsebXcFvQuLrcCKUhHjK7dwv9ki7PYqZ55yapWIZ1krCImVeacscw0CTu5W2C8QwKiBWaGOqW8UqDHibbrQPFJQFFB5V8NN/UyxStVAP0Vzro0NDhzuQ5otWi9M9XV77FDRKLuKYJ3JJWGAQfPy38Tmf2NdwHmN3PwiV3S+S/ej9/xORFs1jY1wbVgBOxwXDdW/QOq4YciBuXZja52zBHYXsOB3Je5WIZODL5t5hfTsXRtgM8Xh3hM7R9G6f8y0fZjJwRfY4UK4qvLeD3zj2OxthPAhHkKyILpXkpAdogNL+//qr/Iz8AVLEsa1tPJZ8A/qAHv/pxow1ADHNidGZscYF9gOlxIspIpNa589B91f4S0BKYXXRK8KfXWFphl1VYs9QUhhAs0KJJlUgCE+lMH/ZHJF/AG9jh7w3I/e5Bq2yG51g/8VM0EnI1iiFMQNOqRCNkEn8dPQ4e8GVVkZ8Ypqtez++VtUDks7UlYQJ92ZZlKFU42x9Zcvo36IJXl/TpGerPBNLlC/6KY9k0vcA1FqRLDvxdv1T2dwYN3iE4S94DHzH65F9L5sM882NjvlKA/ZYVmfWaf3xCb/zuQWOdIjyPiPCqciKQEW+9P6N7ry//Cz5jj0EY9S6yvMkP+BFHmvBwl5JZwXUpnEmPtV/W+Te1TsfxfNvtuaT2n0cJGMqudaDNq/WcIzmHkesT+1kSOdDUDim
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(36756003)(508600001)(6486002)(6666004)(5660300002)(31686004)(2906002)(66556008)(4326008)(8676002)(66476007)(186003)(31696002)(66946007)(54906003)(6916009)(8936002)(6512007)(2616005)(38100700002)(86362001)(316002)(53546011)(52116002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE5IK0l6SFVhQ3RnTkhNRnE5cFBPVUdOL0xsbk9CNmpXcVFDeHc3Z2xMZjdk?=
 =?utf-8?B?VmlIak9uTHMyckRaMzR2dkk1eVpVRC9JQ0Ryb3BSeFh3YlJCMTdzWTlINklx?=
 =?utf-8?B?U09YVEVUbFVJSHhiRFRVbzJHbFpnUzBIWm9WSjJJb3RZekZmcHNSUlZmQ2tu?=
 =?utf-8?B?MDJXaW5SaXVxWjQzRE9SU1JWbTdpSmY4dDBpK0hzUGJHWE9SZFU5TDlkYVZo?=
 =?utf-8?B?Rksweml4eXlHSUpVdE8xWlNVdEhmeHBmcmk3dzE3THFaQXVtcXUrWStuc2lI?=
 =?utf-8?B?MHVxOWtDSk84RXdLU01leDdoK3BETUR0a2psVmRiNlpoOEFvSHFvSjhYZkU0?=
 =?utf-8?B?ZG5TNkxSdUY1bDdsaEZEMktlUzNoNlQrVXZYRDhCM08vMERHYXdjU3JLR2FH?=
 =?utf-8?B?SlpoV1pNUE95alZJL0FUSlRqQUV5L3F6NlNNL3BWN0N1NmVoRXFOb1Y0M0tS?=
 =?utf-8?B?YkovM1Z4cEV0Ynh6UmVaUlg0Uzlua000OE9PeHVURW1jV2tUMWNzQ2RJYTU2?=
 =?utf-8?B?eHFYbi9YUTcwWEY4enhzRDJTVmVrSjZJZGt1ZnJMUXhILzhwQTJSOFJXa01U?=
 =?utf-8?B?bWl6YUMwd2xxa0ZBREluK2d4R0xNcmJXcnQvUkVOdzJoYk12TXU0TkMxVjJM?=
 =?utf-8?B?VUlkZGdnSXZGMjErZ1hoS2wvK2ZSclgzcU9HZThxdmcvNUhaK0Y2Y3RoMzFq?=
 =?utf-8?B?MFpyZGMxWmdzL0o5b1BuSi9JNUlTM21UMXdYaHVEMGtzRjI5cjliZDVqYnBz?=
 =?utf-8?B?UW1aVHlSRXllOGdtaDI3YXFtTHhVN1VhYzRDd3NYVk9FNEZNR2RaMVJRNmRv?=
 =?utf-8?B?ZEZDTWFsZDg3NkRaL0hOUkEydk0yRmNYUlBONTVGaWdGT3NWS0VJajZ1M3RF?=
 =?utf-8?B?YUw2eDN4TU5ZRUZlVjd4MnJCSzNmRjdyYzEyWk1iUkQ1N2d4MXNBcENDK1FY?=
 =?utf-8?B?UmJmR05YSVZDMjJaRjJnSjV4VTVHOW1Jb3FpcnJNTm5nTWtBaDhGMVhZemIr?=
 =?utf-8?B?NDhWaDRhRnU4YnVZclJ4dVpoU0RNQkNjWTdVdGh1Z1g4R1lnTzVxTi9RK0RY?=
 =?utf-8?B?emlWNFE2TWJMTFVZQWJTdU1VT2FZczYvZUhJTGRpYTlvNnd2cmdjQkF6ak8z?=
 =?utf-8?B?dmtzUkVCbCsyNFpMUjNhSlgyZ0NmeEhZNTkycFRZTWUzNFk4N1g2T09ybFho?=
 =?utf-8?B?c0lYaERSUFNDSCswTnVCMGtuSUZ6SGk4V1VhQlJDeTNrMHdvN3hrZTgxelpx?=
 =?utf-8?B?VGZSZ2Q4dlBFTG4wUEpWRXdjbnh4MXA0NERXVzdQZ2p2bUx1Y0lmVXhaQ3ZU?=
 =?utf-8?B?bFZYZUdkcGVJQk11N2picHZjbWNUL3BIYUh3OWU4Q3ExWFVUczNEbVE4UkNN?=
 =?utf-8?B?TkNlL1JibWM3SjNpeFdZL2MzVWN5YldEd1d0aFdFTXoxNFZSZkYvaStwQ3I0?=
 =?utf-8?B?V1hJODlhdFd2dTZ4eXJVVURIaXpuaXkwdVd1MlNpSXl0VEpUVFdoZFBVWWZ5?=
 =?utf-8?B?Vy9seW5IYTgwNFhmSk9wTU9TTGROTDlIT1ZVMGltSVY0aVFCMnV1UVdkYWl5?=
 =?utf-8?B?dmM0Q2RuMmZ3N24zd2NvZ1l6NWdQeks4ekJ5SjVJR1RLT3hhdVIrd0EzZmpN?=
 =?utf-8?B?cmIzcG41Q1hTam1pb3krNm5aOThJSXROL0FTUkNIZmovOTk3RkZYdEMxdXV6?=
 =?utf-8?B?QWxHM1RJM1hxTkZyT3ZsckF2Q2FuUjB2Qzh0cVlvYmtCR1Vvamh3cTNCdGs0?=
 =?utf-8?B?blJ6K09hbG9KTjMrbUpnUStyai9JM3hBb1ZqOEVGaXl2QWpwbXpJRG5LRXZk?=
 =?utf-8?B?S0NZMjhxR3Z6RTFEWDh3MEZPRm9hQnFSaXFvb3U3dkxjZ1lBT0JOb2hDaUlQ?=
 =?utf-8?B?b0FSakVsOWJ4VHhoaHNRNmV6VnduNGRCbXJlV3l5MytKT3lJTGxIWGtIRTdG?=
 =?utf-8?B?MEpnWkM3NTQyekdyUE1UTTB4eVhhZko4R3JXOE1iNVNKK3U3Z1NpS3g4ekpr?=
 =?utf-8?B?M2lRZEZ0NHJYQUpmZzBZNkM0eGc2S0oreDlSSTVuVjczVjNXeU51RFNtVm9h?=
 =?utf-8?B?enNrNnpVOE5RT3p0aU4wQkZVcml4a3FQWXZFL0JLdHhOeFh2c0NZYXF4VmVo?=
 =?utf-8?B?eEZ4aU82SVJSOVdxdlhGS3VVbnhNK0ZOMG53L1d5OXM0c2VxMWFmTUY0STdy?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 575a0d8f-b97c-4386-dd74-08d9ecf35211
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 00:13:24.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LThZH9/1NClid8Pv24fHr7CTNnPb+C9Ycylpx2SoRFvsoZrL8DABegU1zum4855l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3356
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Z-i3c0fZQuhqGGOnygH8iwjPzMr9VPxm
X-Proofpoint-ORIG-GUID: Z-i3c0fZQuhqGGOnygH8iwjPzMr9VPxm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202110000
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



On 2/10/22 4:02 PM, Kumar Kartikeya Dwivedi wrote:
> On Fri, Feb 11, 2022 at 05:24:55AM IST, Yonghong Song wrote:
>>
>>
>> On 2/10/22 2:49 PM, Alexei Starovoitov wrote:
>>> On Thu, Feb 10, 2022 at 12:05 AM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>>
>>>> On 2/9/22 11:52 AM, Kumar Kartikeya Dwivedi wrote:
>>>>> On Thu, Feb 10, 2022 at 12:36:08AM IST, Yonghong Song wrote:
>>>>>>
>>>>>>
>>>>>> On 2/8/22 11:03 PM, Kumar Kartikeya Dwivedi wrote:
>>>>>>> When both bpf_spin_lock and bpf_timer are present in a BPF map value,
>>>>>>> copy_map_value needs to skirt both objects when copying a value into and
>>>>>>> out of the map. However, the current code does not set both s_off and
>>>>>>> t_off in copy_map_value, which leads to a crash when e.g. bpf_spin_lock
>>>>>>> is placed in map value with bpf_timer, as bpf_map_update_elem call will
>>>>>>> be able to overwrite the other timer object.
>>>>>>>
>>>>>>> When the issue is not fixed, an overwriting can produce the following
>>>>>>> splat:
>>>>>>>
>>>>>>> [root@(none) bpf]# ./test_progs -t timer_crash
>>>>>>> [   15.930339] bpf_testmod: loading out-of-tree module taints kernel.
>>>>>>> [   16.037849] ==================================================================
>>>>>>> [   16.038458] BUG: KASAN: user-memory-access in __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>>>> [   16.038944] Write of size 8 at addr 0000000000043ec0 by task test_progs/325
>>>>>>> [   16.039399]
>>>>>>> [   16.039514] CPU: 0 PID: 325 Comm: test_progs Tainted: G           OE     5.16.0+ #278
>>>>>>> [   16.039983] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.15.0-1 04/01/2014
>>>>>>> [   16.040485] Call Trace:
>>>>>>> [   16.040645]  <TASK>
>>>>>>> [   16.040805]  dump_stack_lvl+0x59/0x73
>>>>>>> [   16.041069]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>>>> [   16.041427]  kasan_report.cold+0x116/0x11b
>>>>>>> [   16.041673]  ? __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>>>> [   16.042040]  __pv_queued_spin_lock_slowpath+0x32b/0x520
>>>>>>> [   16.042328]  ? memcpy+0x39/0x60
>>>>>>> [   16.042552]  ? pv_hash+0xd0/0xd0
>>>>>>> [   16.042785]  ? lockdep_hardirqs_off+0x95/0xd0
>>>>>>> [   16.043079]  __bpf_spin_lock_irqsave+0xdf/0xf0
>>>>>>> [   16.043366]  ? bpf_get_current_comm+0x50/0x50
>>>>>>> [   16.043608]  ? jhash+0x11a/0x270
>>>>>>> [   16.043848]  bpf_timer_cancel+0x34/0xe0
>>>>>>> [   16.044119]  bpf_prog_c4ea1c0f7449940d_sys_enter+0x7c/0x81
>>>>>>> [   16.044500]  bpf_trampoline_6442477838_0+0x36/0x1000
>>>>>>> [   16.044836]  __x64_sys_nanosleep+0x5/0x140
>>>>>>> [   16.045119]  do_syscall_64+0x59/0x80
>>>>>>> [   16.045377]  ? lock_is_held_type+0xe4/0x140
>>>>>>> [   16.045670]  ? irqentry_exit_to_user_mode+0xa/0x40
>>>>>>> [   16.046001]  ? mark_held_locks+0x24/0x90
>>>>>>> [   16.046287]  ? asm_exc_page_fault+0x1e/0x30
>>>>>>> [   16.046569]  ? asm_exc_page_fault+0x8/0x30
>>>>>>> [   16.046851]  ? lockdep_hardirqs_on+0x7e/0x100
>>>>>>> [   16.047137]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>>> [   16.047405] RIP: 0033:0x7f9e4831718d
>>>>>>> [   16.047602] Code: b4 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b3 6c 0c 00 f7 d8 64 89 01 48
>>>>>>> [   16.048764] RSP: 002b:00007fff488086b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000023
>>>>>>> [   16.049275] RAX: ffffffffffffffda RBX: 00007f9e48683740 RCX: 00007f9e4831718d
>>>>>>> [   16.049747] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007fff488086d0
>>>>>>> [   16.050225] RBP: 00007fff488086f0 R08: 00007fff488085d7 R09: 00007f9e4cb594a0
>>>>>>> [   16.050648] R10: 0000000000000000 R11: 0000000000000206 R12: 00007f9e484cde30
>>>>>>> [   16.051124] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>>>>>> [   16.051608]  </TASK>
>>>>>>> [   16.051762] ==================================================================
>>>>>>>
>>>>>>> Fixes: 68134668c17f ("bpf: Add map side support for bpf timers.")
>>>>>>> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>>>>>> ---
>>>>>>>      include/linux/bpf.h | 3 ++-
>>>>>>>      1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>>>>> index fa517ae604ad..31a83449808b 100644
>>>>>>> --- a/include/linux/bpf.h
>>>>>>> +++ b/include/linux/bpf.h
>>>>>>> @@ -224,7 +224,8 @@ static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
>>>>>>>       if (unlikely(map_value_has_spin_lock(map))) {
>>>>>>>               s_off = map->spin_lock_off;
>>>>>>>               s_sz = sizeof(struct bpf_spin_lock);
>>>>>>> -   } else if (unlikely(map_value_has_timer(map))) {
>>>>>>> +   }
>>>>>>> +   if (unlikely(map_value_has_timer(map))) {
>>>>>>>               t_off = map->timer_off;
>>>>>>>               t_sz = sizeof(struct bpf_timer);
>>>>>>>       }
>>>>>>
>>>>>> Thanks for the patch. I think we have a bigger problem here with the patch.
>>>>>> It actually exposed a few kernel bugs. If you run current selftests, esp.
>>>>>> ./test_progs -j which is what I tried, you will observe
>>>>>> various testing failures. The reason is due to we preserved the timer or
>>>>>> spin lock information incorrectly for a map value.
>>>>>>
>>>>>> For example, the selftest #179 (timer) will fail with this patch and
>>>>>> the following change can fix it.
>>>>>>
>>>>>
>>>>> I actually only saw the same failures (on bpf/master) as in CI, and it seems
>>>>> they are there even when I do a run without my patch (related to uprobes). The
>>>>> bpftool patch PR in GitHub also has the same error, so I'm guessing it is
>>>>> unrelated to this. I also didn't see any difference when running on bpf-next.
>>>>>
>>>>> As far as others are concerned, I didn't see the failure for timer test, or any
>>>>> other ones, for me all timer tests pass properly after applying it. It could be
>>>>> that my test VM is not triggering it, because it may depend on the runtime
>>>>> system/memory values, etc.
>>>>>
>>>>> Can you share what error you see? Does it crash or does it just fail?
>>>>
>>>> For test #179 (timer), most time I saw a hung. But I also see
>>>> the oops in bpf_timer_set_callback().
>>>>
>>>>>
>>>>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>>>>> index d29af9988f37..3336d76cc5a6 100644
>>>>>> --- a/kernel/bpf/hashtab.c
>>>>>> +++ b/kernel/bpf/hashtab.c
>>>>>> @@ -961,10 +961,11 @@ static struct htab_elem *alloc_htab_elem(struct
>>>>>> bpf_htab *htab, void *key,
>>>>>>                            l_new = ERR_PTR(-ENOMEM);
>>>>>>                            goto dec_count;
>>>>>>                    }
>>>>>> -               check_and_init_map_value(&htab->map,
>>>>>> -                                        l_new->key + round_up(key_size,
>>>>>> 8));
>>>>>>            }
>>>>>>
>>>>>> +       check_and_init_map_value(&htab->map,
>>>>>> +                                l_new->key + round_up(key_size, 8));
>>>>>> +
>>>>>
>>>>> Makes sense, but trying to understand why it would fail:
>>>>> So this is needed because the reused element from per-CPU region might have
>>>>> garbage in the bpf_spin_lock/bpf_timer fields? But I think atleast for timer
>>>>> case, we reset timer->timer to NULL in bpf_timer_cancel_and_free.
>>>>>
>>>>> Earlier copy_map_value further below in this code would also overwrite the timer
>>>>> part (which usually may be zero), but that would also not happen anymore.
>>>>
>>>> That is correct. The preallocated hash tables have a free list. Look
>>>> like when an element is put into a free list, its value is not reset.
>>>
>>> I don't follow. How do you think it can happen?
>>> htab_delete/update are calling free_htab_elem()
>>> which calls check_and_free_timer().
>>> For pre-alloc htab_update calls check_and_free_timer() directly.
>>> There should be never a case when timer is active in the free list.
>>
>> The issue is not a timer active in the free list. It is the timer value
>> is not reset to 0 in the free list.
>> For example,
>>   1. value->timer... is set properly (non zero)
>>   2. value is deleted through update or delete, value->timer
>>      is cancelled and freed, and the hash_elem is put into
>>      free list. But the hash_elem value->timer is not zero.
> 
> But in all cases, check_and_free_timer was called right? Which then calls
> bpf_timer_cancel_and_free which does this:
> 
>    1336 void bpf_timer_cancel_and_free(void *val)
>    1337 {
>    1338         struct bpf_timer_kern *timer = val;
>    1339         struct bpf_hrtimer *t;
>    1340
>    1341         /* Performance optimization: read timer->timer without lock first. */
>    1342         if (!READ_ONCE(timer->timer))
>    1343                 return;
>    1344
>    1345         __bpf_spin_lock_irqsave(&timer->lock);
>    1346         /* re-read it under lock */
>    1347         t = timer->timer;
>    1348         if (!t)
>    1349                 goto out;
>    1350         drop_prog_refcnt(t);
>    1351         /* The subsequent bpf_timer_start/cancel() helpers won't be able to use
>    1352          * this timer, since it won't be initialized.
>    1353          */
>    1354         timer->timer = NULL;
>    ...
> 
> So the timer->timer was set to NULL in the map value.

Looking at one call site:

                 bpf_timer_cancel_and_free(elem->key +
                                           round_up(htab->map.key_size, 8) +
                                           htab->map.timer_off);

So I am talking about to have
    *(struct bpf_timer *)value = (struct bpf_timer){};
The timer->timer is for bpf_hrtimer.

> 
>>   3. one hash_elem is picked up from the free list,
>>      and proper value is copied to the value except value->timer
>>      and value->spinlock (if they exist). This happens with this patch.
>>   4. some later kernel functions may see value->timer is set and
>>      do something bad ...
> 
> --
> Kartikeya
