Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5DC688C48
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 02:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjBCBJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 20:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjBCBJ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 20:09:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994FB10FF
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 17:09:54 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312NuOsX030761;
        Thu, 2 Feb 2023 17:09:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=RHq27FgXUShLwWq/CfaBB4PKaR3mN1eIr3/r23yFZlU=;
 b=c9QO+B10XfCDzS+xYet2R+GKMbTim5hpUpis9ZFGLkgjUs4hMNgVICy8xbKX0M0yJHv4
 zSmC7mziRFUWYql3kJGLLkX7p4kd0g33rvWcus3aTeKJOaC1+rrFl79l/D4BQWp9Z/Bb
 4avEectJxLrOC4hadzcbHZSpEuiIzVKwNhx+oKatfayKXU4wXH54v1MWlIWsO0Q9Ikz+
 7MMlkC5G7GBzdGMO7LhWhWAsn/XJFCALB000QdPlLrtijJ/ajAq31YV9yTlGJwiYFB/A
 4VV0PXrTUrUuYNxs6/q+0cCyGYCSw2LhWacbTMmWrQiWg7yVnDTrHI5o5TXDByYX41Lc jg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nghcr30xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 17:09:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utj2iSIkCTbhrdlDIStQdFeUbgqhenn5mysVypQ0xJPj1GP8NrxxDTwYaDFhVb68PYFZBPolHgeccdUEO4iJ2nGORQt6rq+vy3srSYiPU7bOhROfLUv5nqrS8jOzMX3wvtmm6qlEo09nqRUyRtkiMoFt7hc0xIS755JZ+M74aJn05Vb8NmGUO6qknb7SSlz6Li+rwoySy4/5N65ti4tf6uI+lG8B09RPie9BmhZ8cbozhK5O1ZKq6kGvHl+GrVOAV3yKdyhRCH15xFgk88jeiAdklDWxWQuKcVDPQR5sLH/ZKW97tcxM1gqfSZ7WB4KStSiGdYYc7+ilsqjIOvdGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHq27FgXUShLwWq/CfaBB4PKaR3mN1eIr3/r23yFZlU=;
 b=efGiB+p7/a2qn3n2vC9+SrtuRq5GI3tGfwqEs9GxvEUUIUixmP6i8QEqSXeT9Degvi/VpH1o7c/TVTJcinj9VGu6Jdw4hYaAXCHldArkjoCBtqZurVK/yR2u4GXSFu42eQW1URDTBqkofsDFLH6xgc3AjLox4YeYb7LbL0FyKig32rfD9z59eEZosu/Ksz7fRst6BF5kmAad1+tSxuYgavrPi03BpEPlMzowpj09eZm1pl6hQWuovlhEX/qpDicAyH8KbZNx19gVpiNWGGFMZEKJ7wLbBmhpk/yBFNzXN7PafFGbCW8ZPk5lt/14sSClRGFwYD7t1nZDyHwTib5uWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4523.namprd15.prod.outlook.com (2603:10b6:303:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Fri, 3 Feb
 2023 01:09:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6064.027; Fri, 3 Feb 2023
 01:09:31 +0000
Message-ID: <5c9fc776-3b7b-ccd4-591d-b1502452a9ed@meta.com>
Date:   Thu, 2 Feb 2023 17:09:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 dwarves 1/5] dwarves: help dwarf loader spot functions
 with optimized-out parameters
Content-Language: en-US
To:     David Vernet <void@manifault.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, Eddy Z <eddyz87@gmail.com>,
        sinquersw@gmail.com, Timo Beckers <timo@incline.eu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <Y9gnQSUvJQ6WRx8y@kernel.org>
 <561b2e18-40b3-e04f-d72e-6007e91fd37c@oracle.com>
 <Y9hf7cgqt6BHt2dH@kernel.org> <Y9hpD0un8d/b+Hb+@kernel.org>
 <fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com>
 <CAADnVQLyFCcO4RowkZVN1kxYsLrTfcmMNOZ9F87av4Y4zfHJsw@mail.gmail.com>
 <CAADnVQ+5YgYxcEWpyy359_wVF8-xH-5Du2ix4npqdbebyQLsWA@mail.gmail.com>
 <fac05ba2-8138-cea2-c5b4-d380cc3c6ba6@oracle.com>
 <Y9mrQkfRFfCNuf+v@maniforge>
 <CAADnVQ+Bf2b62aAXQ_LG-=ayMAFhYENRghNoFF+Ma0G8oy1QnQ@mail.gmail.com>
 <Y9nWR7mNGeGCDLYz@maniforge>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <Y9nWR7mNGeGCDLYz@maniforge>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:a03:255::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd24aeb-c620-45f3-ed5f-08db05834df9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: We59Gq/O3ztYksgyo+456brhNfdR8aaQk30GcDTKt5nU843DLvk7EnKkAcZLSmy4Yj66dLuc2k8s3Fq30kglCQneUlqLsRvIYysntm02ziylnGtwlv4+WkdYkPHsYgv4L5+FO6+VbL9L8xZP0YBmtCYKySpxRi59RMc2RZ+EVn0pMei8D0DLAqwe+2Ge3M1w8c1VFtWIjPGKbsYcSSdFy9OZfdGCehNo/X5XiF/Mlbx2GE/KSZG3Fv02921Z2loP3a2srxSHEeeA2BXQiDd4G8LuQ/zce+tVXiylEsg/D4Tlt/FQKANZqWVw7iTKyJnXv/CGL2/Nll8rFSJeP9Xotuj+DJNvxjNIlbvAP2eqnzP6o4lUha5pF49DrMeaAfalE627Vr/ZmdAU11a9i/L0sSJwy/c04uw7iQHeKSR0QNGeutOoA8mCvihgyDBuwwqelSrVQwde9XoMUY1WldYcnkPcYdEY02EuKDKT9JOZhTDgchzW+yPR/MkrDT+pu2wBPWLOWch5UEWj/kPQcnksjMEH8hEgGvEpqTRAs9D5F24WeHrEglDdiToTEENED2E0LNxMrER84HDX7DPEqJ3pB1kplqYR0c2TVZ45baDeInCAEtz45iW6w4NBY3UI4QTlgOUWf6zKdwjF9OrsTGTekY5WsFlRYghllLLcYECH/2Zv+FvnmtrRNiCu2ifNYsl2Cv+pKHRNywccc1MCzRUAIql4GpN9AbVcOEcUKdsQuBcLWyNr4sZyTin58NKNXmRNX0WQuH2gK3+MJJEDZ2cvQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(31686004)(110136005)(36756003)(54906003)(66476007)(4326008)(8676002)(66946007)(5660300002)(8936002)(316002)(86362001)(66556008)(31696002)(38100700002)(966005)(53546011)(6666004)(6512007)(186003)(6506007)(2616005)(478600001)(2906002)(6486002)(7416002)(83380400001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWNJVDRVcmpXbkNPRmE4dFNHSnJoWFNxWlFSelpBbnZNb21jMC9uYWZBdHBq?=
 =?utf-8?B?ZC9uUTZMY1lXd05UV2hQZ1BPOW5sVjhMdytFbjZWem1TUnMwVkF2ZWlERi9Z?=
 =?utf-8?B?a2ZqbkNLdjJUQk05eHRTZGtwUVl4ZlRmWGljd0s3MkNpeTZUcTJpRUJLSDk5?=
 =?utf-8?B?ai92QTBnMG1tbVhxZEpFcTh6YVlsMzR4Q0lrU21RZWdYMkdRbGROSENNc2N1?=
 =?utf-8?B?NWV6dEI0RFhkcElac1VoaTljQ1lXR2x1eTg4RlFtZUZlWnB3cWc3TTYxbFU2?=
 =?utf-8?B?UHMyTVp4SUxOUVhZcVpMWms0VG4rYWhjQXRnc0ZRdXhuZWcvYjRUYzhvVXpi?=
 =?utf-8?B?YkZ4UmZML3ROQjJjUWtMc1N0QmRHR203Z3laY1FMbXJJMkZpLzdXdE01cXJV?=
 =?utf-8?B?WTByS09xM0VMdDJCY1pkU0dkaUNhcXZtN0RhclVsVHNvUzBmYWQ3MDYvVllN?=
 =?utf-8?B?Slg1Y2VrVU1OK1h0T2JuVXNlWXVkUlk0cEU5YlQzMnZHSGNsOXM5cS9xSGU5?=
 =?utf-8?B?VWFLdy9jVWtEbTRIOExYZHN2Zm83Zm13TWZSNnY5QVVpdkhZaXI5dHp2UXlT?=
 =?utf-8?B?MFQ3dllZN01zWHFHSHR5dWYvalBEd2hZTTBvVXUrVE01YTdCQXdnUUlFYTBx?=
 =?utf-8?B?eVlPMktKL1BJSHJESmZ3NUpIMmVQemVpQ2JuR2tEeHg5SHZjQkZ6V0lDMFRm?=
 =?utf-8?B?ZTFqK011Q3RobTlyREcxaUpNWlFVa0lWakh6SVBPY3lmcEZIL0NtbHZ4Nkw2?=
 =?utf-8?B?L1M0NWhzSW4xMFA2anFNV3p1aXlSOEJIVjlnY1lja0JkbWNyNHdqdjZ0RWU5?=
 =?utf-8?B?ZkhwMFJ3c0toMTVMb2pYYjUwODdOczlBaUxxTFFBY3UwWW5kelp2NWxYaW9N?=
 =?utf-8?B?Y3NTUHhhaGt6aGNmZHF2L2tObTVvUHZ6VnNZSXY1bVc5WEZVWTRnUEJUNms2?=
 =?utf-8?B?blVMTHJBdlNTVWVxbWN5dWgzL1ZkeXpoemhFV1YxdG1RN2E3a3NYdlp4RHdV?=
 =?utf-8?B?TWUvZWtMMFk0Rnc4SnV6eTNRR3RsbDlkU0ltVVpSVVJBVkFKZWU3M0VhTkVl?=
 =?utf-8?B?Ym9Ea1pjV3l1aTVQLy9LMEpibXJMeUJDaFd1aGpFalNNVVpqSEdJQTR0c28r?=
 =?utf-8?B?RWxtaytMbE1UOHYvWG5UL2lqVnBJNTZwRFJleGNrd0dwOHNzU2JBQmtzSWxK?=
 =?utf-8?B?aUhPaTRHRi8wTDlCU2s4TWQxMDVidlArWFRGTS9YZkFRbHRNR0dRMHJWN1BO?=
 =?utf-8?B?ODk1a28rWFBQUlJQYzVoQno4ZFVjNjRhVng5UUpCdjJMTENSNDRXUGM5K0xs?=
 =?utf-8?B?N0J3aVlnVWdMTldqd3hRMDhrRklpRGh0MjhtZnJUNndCV0hVTzdHdnE0U3l3?=
 =?utf-8?B?T3VKRkZQZ1kxSjFqLy8yQk5kMFRaT0NPMndsZnpyc1E4ZmpNTXo5WWFKaVpR?=
 =?utf-8?B?UlJINHNtam1TRGhxS1luOTlITHNiMnF2VFZlNEIyR250ajAyYzVTZy8zbVEr?=
 =?utf-8?B?b0FzUDVmSzd5ZjFERzRnaXprbmhMS1pGdVF5OVBEODNWaTVUczdTbVprRFZV?=
 =?utf-8?B?WEx0UUNRRlNRU2RtQ3ErVThPait5WmNROUFRUkhGV1lJZTNQWHI0ZC82OHdX?=
 =?utf-8?B?QS9TcWxWRkJ4TkxnaU5XaDFWaGxCU2wvVFhtVVZ4cHIvSUVZYVJLNWEzTUhi?=
 =?utf-8?B?MWhIWmxMbzJKSzNQVjZtOGNrR1Z3VVlKK0JFNVdKTTRoVjdvZEx5a0I0TENI?=
 =?utf-8?B?UWpxZUtnQWhlOWExQ1ZlZGQ1bXd1QkRvdkZXRzhYV1hHMnlWUDNQV29VUmov?=
 =?utf-8?B?bnBIRXgyUFgyRGJ4V3RHSFJ5MnA0UkpwNnNBUTB5d0ZOZ2dCOEp4alpqTjRF?=
 =?utf-8?B?djlvQ3o4M3hjdEsvRk8zSzVIOTR2Wm4vVFpaUHVyZjZTNjJkWTMxNk1CVFM0?=
 =?utf-8?B?Z3Awb0dueHZjdnFVUlpQQUMwQ0lNY1JsTHk4QkdvKzhZQWQ0bHFmU0JwOWtx?=
 =?utf-8?B?UTJXWjV1bkRoaW5WVnFyQm5iNUkyd3RBMmNGc2I3emlIMDQ5eDMvS0psNEhm?=
 =?utf-8?B?K0pzczIxVEQvUk5kU00rVGFNK1hpdjdjeHQ1b3h1YVFsMlBEdjVHNjhaeTNr?=
 =?utf-8?B?MlAyUXlobW0wcFNpWWZFUGZqN0srQVhLckNZR3dVS0VhMmszSjQ3cTcxTjdL?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd24aeb-c620-45f3-ed5f-08db05834df9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 01:09:31.1699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0Lyxlk9wrf4nwWPR4ajBhjHDtXSLfG+/9m9L2qaevVK2VNrFkBw/Mw5wyx5FOTe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4523
X-Proofpoint-ORIG-GUID: N7dZAUKs72S5_j8DEA_I8ZOsNTstyy8I
X-Proofpoint-GUID: N7dZAUKs72S5_j8DEA_I8ZOsNTstyy8I
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_16,2023-02-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/31/23 7:02 PM, David Vernet wrote:
> On Tue, Jan 31, 2023 at 04:14:13PM -0800, Alexei Starovoitov wrote:
>> On Tue, Jan 31, 2023 at 3:59 PM David Vernet <void@manifault.com> wrote:
>>>
>>> On Tue, Jan 31, 2023 at 11:45:29PM +0000, Alan Maguire wrote:
>>>> On 31/01/2023 18:16, Alexei Starovoitov wrote:
>>>>> On Tue, Jan 31, 2023 at 9:43 AM Alexei Starovoitov
>>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Jan 31, 2023 at 4:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>
>>>>>>> On 31/01/2023 01:04, Arnaldo Carvalho de Melo wrote:
>>>>>>>> Em Mon, Jan 30, 2023 at 09:25:17PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>>> Em Mon, Jan 30, 2023 at 10:37:56PM +0000, Alan Maguire escreveu:
>>>>>>>>>> On 30/01/2023 20:23, Arnaldo Carvalho de Melo wrote:
>>>>>>>>>>> Em Mon, Jan 30, 2023 at 05:10:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>>>>>>>>>>>> +++ b/dwarves.h
>>>>>>>>>>>> @@ -262,6 +262,7 @@ struct cu {
>>>>>>>>>>>>    uint8_t          has_addr_info:1;
>>>>>>>>>>>>    uint8_t          uses_global_strings:1;
>>>>>>>>>>>>    uint8_t          little_endian:1;
>>>>>>>>>>>> + uint8_t          nr_register_params;
>>>>>>>>>>>>    uint16_t         language;
>>>>>>>>>>>>    unsigned long    nr_inline_expansions;
>>>>>>>>>>>>    size_t           size_inline_expansions;
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> Thanks for this, never thought of cross-builds to be honest!
>>>>>>>>>
>>>>>>>>>> Tested just now on x86_64 and aarch64 at my end, just ran
>>>>>>>>>> into one small thing on one system; turns out EM_RISCV isn't
>>>>>>>>>> defined if using a very old elf.h; below works around this
>>>>>>>>>> (dwarves otherwise builds fine on this system).
>>>>>>>>>
>>>>>>>>> Ok, will add it and will test with containers for older distros too.
>>>>>>>>
>>>>>>>> Its on the 'next' branch, so that it gets tested in the libbpf github
>>>>>>>> repo at:
>>>>>>>>
>>>>>>>> https://github.com/libbpf/libbpf/actions/workflows/pahole.yml
>>>>>>>>
>>>>>>>> It failed yesterday and today due to problems with the installation of
>>>>>>>> llvm, probably tomorrow it'll be back working as I saw some
>>>>>>>> notifications floating by.
>>>>>>>>
>>>>>>>> I added the conditional EM_RISCV definition as well as removed the dup
>>>>>>>> iterator that Jiri noticed.
>>>>>>>>
>>>>>>>
>>>>>>> Thanks again Arnaldo! I've hit an issue with this series in
>>>>>>> BTF encoding of kfuncs; specifically we see some kfuncs missing
>>>>>>> from the BTF representation, and as a result:
>>>>>>>
>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
>>>>>>> WARN: resolve_btfids: unresolved symbol bpf_ct_change_status
>>>>>>>
>>>>>>> Not sure why I didn't notice this previously.
>>>>>>>
>>>>>>> The problem is the DWARF - and therefore BTF - generated for a function like
>>>>>>>
>>>>>>> int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>>>>>> {
>>>>>>>          return -EOPNOTSUPP;
>>>>>>> }
>>>>>>>
>>>>>>> looks like this:
>>>>>>>
>>>>>>>     <8af83a2>   DW_AT_external    : 1
>>>>>>>      <8af83a2>   DW_AT_name        : (indirect string, offset: 0x358bdc): bpf_xdp_metadata_rx_hash
>>>>>>>      <8af83a6>   DW_AT_decl_file   : 5
>>>>>>>      <8af83a7>   DW_AT_decl_line   : 737
>>>>>>>      <8af83a9>   DW_AT_decl_column : 5
>>>>>>>      <8af83aa>   DW_AT_prototyped  : 1
>>>>>>>      <8af83aa>   DW_AT_type        : <0x8ad8547>
>>>>>>>      <8af83ae>   DW_AT_sibling     : <0x8af83cd>
>>>>>>>   <2><8af83b2>: Abbrev Number: 38 (DW_TAG_formal_parameter)
>>>>>>>      <8af83b3>   DW_AT_name        : ctx
>>>>>>>      <8af83b7>   DW_AT_decl_file   : 5
>>>>>>>      <8af83b8>   DW_AT_decl_line   : 737
>>>>>>>      <8af83ba>   DW_AT_decl_column : 51
>>>>>>>      <8af83bb>   DW_AT_type        : <0x8af421d>
>>>>>>>   <2><8af83bf>: Abbrev Number: 35 (DW_TAG_formal_parameter)
>>>>>>>      <8af83c0>   DW_AT_name        : (indirect string, offset: 0x27f6a2): hash
>>>>>>>      <8af83c4>   DW_AT_decl_file   : 5
>>>>>>>      <8af83c5>   DW_AT_decl_line   : 737
>>>>>>>      <8af83c7>   DW_AT_decl_column : 61
>>>>>>>      <8af83c8>   DW_AT_type        : <0x8adc424>
>>>>>>>
>>>>>>> ...and because there are no further abstract origin references
>>>>>>> with location information either, we classify it as lacking
>>>>>>> locations for (some of) the parameters, and as a result
>>>>>>> we skip BTF encoding. We can work around that by doing this:
>>>>>>>
>>>>>>> __attribute__ ((optimize("O0"))) int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>>>>>>
>>>>>> replied in the other thread. This attr is broken and discouraged by gcc.
>>>>>>
>>>>>> For kfuncs where aregs are unused, please try __used and __may_unused
>>>>>> applied to arguments.
>>>>>> If that won't work, please add barrier_var(arg) to the body of kfunc
>>>>>> the way we do in selftests.
>>>>>
>>>>> There is also
>>>>> # define __visible __attribute__((__externally_visible__))
>>>>> that probably fits the best here.
>>>>>
>>>>
>>>> testing thus for seems to show that for x86_64, David's series
>>>> (using __used noinline in the BPF_KFUNC() wrapper and extended
>>>> to cover recently-arrived kfuncs like cpumask) is sufficient
>>>> to avoid resolve_btfids warnings.
>>>
>>> Nice. Alexei -- lmk how you want to proceed. I think using the
>>> __bpf_kfunc macro in the short term (with __used and noinline) is
>>> probably the least controversial way to unblock this, but am open to
>>> other suggestions.
>>
>> Sounds good to me, but sounds like __used and noinline are not
>> enough to address the issues on aarch64?
> 
> Indeed, we'll have to make sure that's also addressed. Alan -- did you
> try Alexei's suggestion to use __weak? Does that fix the issue for
> aarch64? I'm still confused as to why it's only complaining for a small
> subset of kfuncs, which include those that have external linkage.
> 
>>
>>> Yeah, I tend to think we should try to avoid using hidden / visible
>>> attributes given that (to my knowledge) they're really more meant for
>>> controlling whether a symbol is exported from a shared object rather
>>> than controlling what the compiler is doing when it creates the
>>> compilation unit. One could imagine that in an LTO build, the compiler
>>> would still optimize the function regardless of its visibility for that
>>> reason, though it's possible I don't have the full picture.
>>
>> __visible is specifically done to prevent optimization of
>> functions that are externally visible. That should address LTO concerns.
>> We haven't seen LTO messing up anything. Just something to keep in mind.
> 
> Ah, fair enough. I was conflating that with the visibility("...")
> attribute. As you pointed out, __visible is something else entirely, and
> is meant to avoid possible issues with LTO.
> 
> One other option we could consider is enforcing that kfuncs must have
> global linkage and can't be static. If we did that, it seems like

Do we really want static function to be kfuncs? It may work if we ensure
the same function name is not used in other files. But it sounds weird
since kfunc can be considered as an 'export' function (to be used by
bpf programs) which in general should have global linkage?

> __visible would be a viable option. Though we'd have to verify that it
> addresses the issue w/ aarch64.
