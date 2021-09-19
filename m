Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04917410DC0
	for <lists+bpf@lfdr.de>; Mon, 20 Sep 2021 01:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhISXMT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Sep 2021 19:12:19 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50262 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229590AbhISXMS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 19 Sep 2021 19:12:18 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18JCNink012108;
        Sun, 19 Sep 2021 16:10:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FkANit1LtzABMDb5Vjv0A34OBiyESGyy4DretDBjS8g=;
 b=QTE54PjoH1H/e0EzzWnmwEIuuwzV3A21b80GkVzSuq9PWz7DfxTgnviGOcIHZ0jPL+1H
 O27EOYGUwySV+3aGkYoZsXveGICWDdV0tx9FMBW06CS9rZpp/sH6Gyc4i+5F95g/xoo/
 4ElJoxplcYwQlsD6DzWPjsLPFuc3fiRTM4Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b5besppb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 19 Sep 2021 16:10:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 19 Sep 2021 16:10:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akhdH88Voyu+VsLt4kAcXtj0UjHuuwIaoAEPvQyde+089Q7lnm/3oqmPnCsppify3OgsDhyL/VU4b0hTZCbNhEeLha3j6oVf+DlPsgEnmXuL9b36DJXNjNy008keZzQokzUX83TZIpOH7W66jL6hr8Q+qtX/wbz4wAmiyA585pPEvt3Y7Sa8MAjc/bmbmbUMIGVB1ptvzpVd0EIOt2brlOGIF0CP9o2dIQK/Aw2x1Phy+OdLskkyuUGL0CvCJ2pMEUOrW6OGQOLVo0LFmzHOpXyj427Mo9Ba9SkFN4EXUG8jdJJ4i3ilwdofRKTHnpsP1V39nrIfywBnvi8XztOMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hFsdaOfmqbr+rtytlpBrHz00DZzqL4jpydeE89uHrUs=;
 b=jg3qYYNriScBxOGJgyqFenKpE4lEunzydSha2X5wsV1TdKz2z3LFkDJ7+ndnXbOY6ZsaB6HvniOodtdiL8iywyA1oD5nRKZL7ndqzw1katZwjYkBNoEGIVLX+9zSwjhdOXg+QKW2zpAZzre9KCr0iNk/KnEH+utAy/p4ajte+MMOgzI/qk17D4+7wA7nzcvnBD3yBCRPrMDb7OIZJh9buZO8CsWD0PWoNWIfqY9yP4TyK5xF5L0CqWNG6E403LALI5yUcrZvj1wgT+PAVJv+EBR8g+HiwWdTmIsJ7yM0rbcz//FIu4HPgtviJRiGtpRTZCvfhhs2xCpqRxmhM7S50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4048.namprd15.prod.outlook.com (2603:10b6:806:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sun, 19 Sep
 2021 23:10:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4523.018; Sun, 19 Sep 2021
 23:10:36 +0000
Subject: Re: [PATCH dwarves] libbpf: Get latest libbpf
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210917224818.733897-1-yhs@fb.com> <YUZbpcO1il2WgNR8@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1c7ff967-f056-7cf9-9a14-8ce35db25c91@fb.com>
Date:   Sun, 19 Sep 2021 16:10:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <YUZbpcO1il2WgNR8@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21c8::110e] (2620:10d:c090:400::5:2e8b) by SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sun, 19 Sep 2021 23:10:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a47b8d0-53be-40a6-7215-08d97bc2b00f
X-MS-TrafficTypeDiagnostic: SA0PR15MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB40480A1A8992126314553BDCD3DF9@SA0PR15MB4048.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CqOaZg4i4DOi+I58DXw5QiZOxwYvuUEwx7FmozhLxOUt9Y7E3BiNrSL1suFW4tZbpxUJt4OpYGN7DplJuWI4sR34oGntegv21UB31OeH+J58w0YEM1ltZzodpqYk4qLk7D+FsrKtNJdAGiBeY+l8eOXhBjxMgpA+4ntWmUEIbHcv/6xEPzCY5kJMXQsjaM9gZNgXKF8r8TNHC5U/E3Ls9jGNSxKUiEljo6FolTh8pERcXXAWvem/1QhPliPDgYqUGUXQTTHprb7nV9FcbdQwT2pT7k/npM4gpeWmSQ7JW+/3eykHPdU0sZRALy7m7O87R/7K94lmPOq/RwUQDNqXPIbY1NARGCVcu8M+WEcV6tfK5xf9/hY6bXzlDmH4F4AY4d3Yx1R8/ebb6+oM9WUOPWdlbLvR33gehInHRcGVbTDUYvhn+Clnus/60TtO3rs09kxZRKWzD9sQnXPbRpY3qJjPkon7UPykl0hQdAUvxR64R7ergJVJmVmeU6XNgrzvZgN6IqUzvQHNaofxT1JkMcv01sCAgK/9Y83fgOPedhF0iCQ8N69G0oKa7jUnJyiZhcB94snSDvCntJlrBXflhMR2kTS0a7zl+GCxTE2iq6YsZ9XedQuMlGKJsGTiDmssmZohOCaVN0eLDF4kYsuncFzkaNdlyqw0aq5DJdqSrvDIonD3jFdJCHSpeQ0rar1yb9TVVjVnBKzycw6xEBTMhoD6UpTcu8lfNhKvptDSPBPduW9AOZ49k8I6YXMiPayv4bVLT+fsXCXw2DgFuajN6s97TMeN+2VqtRMcg4NZ1Mb9OZrolB6+ytoueOdIu/teBpDoW7xCCTiWGciMsAxZ/CzsuNoDhxrjXWi63jmk7WQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(316002)(2906002)(66556008)(6916009)(86362001)(83380400001)(5660300002)(53546011)(31696002)(966005)(2616005)(66946007)(36756003)(66476007)(52116002)(31686004)(54906003)(38100700002)(6486002)(8676002)(4326008)(186003)(8936002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHNVTXR1N0RuajAwNEhFemxLUzVwWkU1MHd1Y3ZsNXcvY3hVbU54VGNBUE9z?=
 =?utf-8?B?WExrYUlXVkgvaTMvL1o4dnEyQmxDaEJQRktpNzF6S0M1WmttNUlVSUl4WHhy?=
 =?utf-8?B?by9zdzdjT0tRZ2dFa1VDeDhiTE9WWFBrUTVBQ2tIcm5TaGV1Uy9Ic3VwTFE3?=
 =?utf-8?B?Z0xzZEh4VDBFaXh5VmxZaHFFQzVzckhXd0Q3OWhBTW1tUzNHdmFUb3NMaTRV?=
 =?utf-8?B?SFV5VDN2Qk5ocUZ2cjdXTzFUMU1JaVR1dEYvdFAwMCs3d1Z1UnhPdVdCS01H?=
 =?utf-8?B?aW9mSCtBU0I5bytrenRjYldsSWV2RFliV3kraWJPclVzNUFYZDVXSTlVMFIw?=
 =?utf-8?B?aHVOM2ppN2Ivdm5VM2Z1N090UkVaN0RDY01hdDg5ZnpjOGxJUTUxNnZta3VP?=
 =?utf-8?B?cDA0NU9SNSt3Kzk4bnE1akY2V25sWFBkWk9TMmRoeUcra1cybi9WQnBpQytP?=
 =?utf-8?B?ck5FRVorVGRXa1U5c0RiZitSTStVc2doYTVicFZEUU91d01kSXJDYzR6SGxw?=
 =?utf-8?B?OTBQK3dCZ3dlSDBKZElhV1JMQVNmTTRUaW5RZWFIVEFZSE1reG03cE5jYjBk?=
 =?utf-8?B?MnJNdmR6ZzNmWjhyYW53OGtqS3A1bzVNZVRBcmYwNnBMV1ZLZ0tFMm1GbnJ6?=
 =?utf-8?B?VnNtZTNseU5JWk4xMC9SNTNsY0hxc2dJYStJOGw5VS92Z3cyc0lScU1wcndX?=
 =?utf-8?B?R1h2MEZQTDIyaGlYWTM0dTFDNk9ZSGpRclA0UXRja3dNSUJVdnF3RkFyVGt3?=
 =?utf-8?B?RU43WnlLaXc5U3NlRStPQ0lXSWNzbkxaUHA2dDBvSlV3aHA4L0FydkE4Y3BE?=
 =?utf-8?B?MzRZMWxwbEkwdXJhNlZKWVhxQkhLU0xsWXZqazVmL1BCWmVORnIzOHppZGVm?=
 =?utf-8?B?ZERpQUllUzZ1RjFwQVlUUTUvbDhVRmN3RzlCZm51OXpaUkNWbWxzbVNhampX?=
 =?utf-8?B?RmxHOG9hQkFKNWJnMGhkYldxNkRjQzdEMjFhMUJVeWl4OGFsYi9LSVd6d2Q4?=
 =?utf-8?B?YjhYOFlCbDh5OWpWbDB2aFVJSFBBUFFhZWhaUmZXNHF6NkZjUXlwZFZUaXdk?=
 =?utf-8?B?Ukl5TkZFRUN3Q09XY3ZLaWVRUjJKR3k5WnprVTdGczJtNzJkbTR4eTVyK2pK?=
 =?utf-8?B?ZnRLc0lMWUNaK2dUdHc5c2R6amhWNkJ6U29zYmxNTWxCRFNZa0JxYTBMeEYw?=
 =?utf-8?B?MmRIQlZGUXpSbGtMbk4yaFBYcFFJS3Qza1VhbjBVZkx1eGNKODZXc1JrN3M2?=
 =?utf-8?B?Y1M5RjlDclYwWjRCdkRMSnBmbjF1NUJQeEhPcHVQanVNNHR0VHBkTW1acWhq?=
 =?utf-8?B?UFdTQUYzeUJHY1BGQnJrQ1ZGeE92RGRpeTBrMm9pODNqMjlPSU0yNTRJYTRZ?=
 =?utf-8?B?WmczZFRKdHpVQXFkK1pubFhLRDZJazgybTliK3dVZW1kL3FFNUk1T0ltWVZH?=
 =?utf-8?B?MkxrdEhsWGliZlY0eEFhTURhQVVuaFVIZXJOd3o1TEdWR3RobEo2STYxYzM4?=
 =?utf-8?B?Rjh0bnZacFRic2FHZlJTalczT1k0Z2pGK3lZNTZhck53RDRzWjZyR3JsWE9H?=
 =?utf-8?B?MStoWkhCeTZpUTNyNFVMQ0hmanFWTkdobDNyMjNvYWRIU2kyNnVUb3pwMTcw?=
 =?utf-8?B?RWNqOTE3RmlOajU5TmFCckg3MGZJZlJuSU9KTnZoZHJRWldJMXdiOFM4Unox?=
 =?utf-8?B?NE9BK3VITVhOcHl0NG9VSC9zbXB0RThFajNXazdFR0FicVlrY1g5L3ZyZ3lS?=
 =?utf-8?B?cFFUdGFiazhyQnVnS2hTRDJzczM3TEoxUXNnbFcra1hwUzk1a0VTRXVwUEVu?=
 =?utf-8?B?SnhLOVJwTmVVR1U4UE1xUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a47b8d0-53be-40a6-7215-08d97bc2b00f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 23:10:35.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ifwrOBrTmSiSyEXIHJCUYSyl1QOdFHolPA0H1MVFcpdVPkxGZz2k8DqWssDc2XO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4048
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ZGvM9rrufYCdgW9LiEWIdrCaCpSnQB_X
X-Proofpoint-GUID: ZGvM9rrufYCdgW9LiEWIdrCaCpSnQB_X
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-19_07,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109190173
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/18/21 2:35 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Sep 17, 2021 at 03:48:18PM -0700, Yonghong Song escreveu:
>> Latest upstream LLVM now supports to emit btf_tag to
>> dwarf ([1]) and the kernel support for btf_tag is also
>> landed ([2]). Sync with latest libbpf which has
>> btf_tag support. Next step will be to implement
>> dwarf -> btf conversion for btf_tag.
> 
> Thanks, applied and pushed out. Looking forward to the upcoming btf_tag
> patches!

Great! Thanks. I already have a rough pahole patch. Will do a little bit 
more testing and add flags control and then will send out.

> 
> - Arnaldo
>   
>>   [1] https://reviews.llvm.org/D106621
>>   [2] https://lore.kernel.org/bpf/20210914223015.245546-1-yhs@fb.com
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   lib/bpf | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/bpf b/lib/bpf
>> index 986962f..980777c 160000
>> --- a/lib/bpf
>> +++ b/lib/bpf
>> @@ -1 +1 @@
>> -Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
>> +Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
>> -- 
>> 2.30.2
> 
