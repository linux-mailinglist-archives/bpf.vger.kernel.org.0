Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425685848AF
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 01:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiG1XbJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 19:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiG1XbJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 19:31:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56250743C7
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 16:31:08 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIAm8Y032376;
        Thu, 28 Jul 2022 16:30:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CqBtIxOjMNbsxp0+CMPXEzNuqRUrlLf7vTdYP6+mHPI=;
 b=rJ4XNHNuoRtdECVw3+g4g7bLPST+3N8NvJUaHnNLjE9We/000K6mY9CFcrJ6PiyzZYuM
 wX9XlSGWoh8zcqll5jd3RafqJieXoonAr5LqcSnf0PWWC/hEBu3qq+FrGF97GwGMq9qN
 qzSXnjMQ3kGYqsZQ8/k6rvxwq59EgntHl08= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hkst14vau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 16:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTVE29YbGSoFDUJsyEI24QncfdoM4c7a5XVXp0RvL+Pbvol0fTLuktV11VlvTkP0Y0reQ9INJDGVpBl+ep2LHfp7WP1Jk17WULk8gNSD3pupXDgAosZ3EDRiirvhkGS0H3YRr8Hvl4DM39PqzXnA2Zy5osQM08QTsd0HVZFJi3lCHhLncxr32446i6KrvjtqFbQOXWq9n1uOF6o8x/UiH+cSx/0mnQTSIuWEGx8XXD+voYOAJjNC47NhprLeVYf8ZX3yQ70uBTrFWEeY4AVxRUmUBafvx72ptqI9Y1bBQUbSEoPAX9z0UU9x7Tz1OLWcVRNwHZP+rF5p/Nw3uisXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqBtIxOjMNbsxp0+CMPXEzNuqRUrlLf7vTdYP6+mHPI=;
 b=MRLiV7BuQPukptKZPqTYJDU8FJ566+hbeYxoN8lnXFyXEvzfBa8jbPiAN5TeODJHt3gpcg0LQFQuapyju0/Ecu6widTV9gS5vg2ygS2MV4gz2pmkzGz3mf/RSYvyBxeGEwmPWVPM2hz/zCagl/dmp4Slp2wqTW5ymsIzfpsMKIFxgEBRdZ6Px0DMhTNiFcDHtmKq6hOiUpQFPrBt0QlTCkTZmyAtnmHcKqtcXjPiy5GTIdivkvgOkqiW9Td3PnS30z8amjlurWkmYbUBeveGt82Wmz9fF3bURZ6NHIaaTpmqAdMfHDi6QGkCPdEi7aHuXsj79A8ukEhv/Sx2xyrSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1325.namprd15.prod.outlook.com (2603:10b6:320:28::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 23:30:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 23:30:51 +0000
Message-ID: <a31dfd32-3065-1881-e2e2-3c420568232a@fb.com>
Date:   Thu, 28 Jul 2022 16:30:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Support struct value argument for
 trampoline base progs
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
References: <20220726171129.708371-1-yhs@fb.com>
 <aa998af64d0662af4c138175259244640cecfcbf.camel@fb.com>
 <18273e85-4e45-c395-0aa9-a10125d59e50@fb.com>
 <17dbbb831db12049ebfb5161e380c9078fbddad5.camel@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <17dbbb831db12049ebfb5161e380c9078fbddad5.camel@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe628ac4-6cf9-41e9-ec70-08da70f135ba
X-MS-TrafficTypeDiagnostic: MWHPR15MB1325:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYaHdQeh/1kkpOMASDHltnsNxNJpaGSd68jO199GGxNEvcAZeobhqKAecNUhbN43aFyvjUXrIs70s+bMJbNW2t13NuNhlyPgb/CqOoHWcu6bORe4J8vxnREPYdVjw3KF1KCwDvz7wsMmU0+UJdEztljtmb4GyQThu0pzELCyIhxTPmS8P4zID6a/V9m4xfcFRDZ74IEsE/jPKuvetj8bA34TwzseDFhUsat3Sn+anKx/9q7yGcvqP6HzFhsaLuSDo1I3vKIBj+mq2akL1/MEYoTsBBN4Ls52d7NyTrIkIi8+aNnCUO2RHagxHGWt1yUE/CXl/JHmkOrjysYheDmlxgwiDTTuNMT4OWCWAjMvll+3lstD4ohopNGBJ6BO2PMjdvXUrnmp3haXOHaYLNppnST8EqSpP5FlEyQxDoez/SMmGjOTy8O2wSYHjkzi16RGzW3A5hd5Hf7F2luEEmeuUWFeYS9OUpdXnF/xWLk1dCuUQ+zLRgJ5PtIDGYHCdw93Vd0X0KFiMGRCw7MJPIhG11bJxprcHo4inxil6AvaHgfOOzDmNgQqEIqGMNDlXEVaEQMptLh3W+PBw69cjtg7xamx9DDHA8PiIc8oDFVf5rCRWPcn3xbQqd0X1AqU57aWlcNoXxIm8WokNHaabSeLTrAE+1Ij8AOSTA0SzTNv6GfzDAfRclqerAvR956nOP0bwuHa/XlGOOgmh2sYP4sFYsvWrGqPuUmQsFjKhh5n1UjdgkAZI98a4TMDVF8GGOtorFwTD73fGvdifcqJiVZBIDYSQXLBSt61zbH2Kp/kqacx7K7P8DSKOuAfCNnGvYUmpDqsaHB0mT0Ja+q393aaLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(86362001)(31696002)(38100700002)(83380400001)(66556008)(66946007)(8676002)(110136005)(4326008)(316002)(54906003)(66476007)(2906002)(6506007)(8936002)(6512007)(53546011)(5660300002)(478600001)(2616005)(6486002)(186003)(41300700001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0l3cjlIY1MzQnIyRUFkZFRuMDhkTzZ2aklrTGhLS1J3VmtLQ1RIMTF4d211?=
 =?utf-8?B?encreVZRK2xkcElwYldzeGNHSWh0MDYzK1JITzZlU1QwSE83YWhGN01ja1Bq?=
 =?utf-8?B?T0RhcnIrTFRKeWFBR3REdGJIY2VRU24wcStHOXhIM1crQjBYR3p4WWQvUVB1?=
 =?utf-8?B?QjVRNG9QUno4TkVHbVB0WWFwaGFTQVFUa3ZIK1ozNUk2RjJobGNjMnZRbzU3?=
 =?utf-8?B?YW43NExnMjRRVTNMVkE2KzlrOE4zQ0NZTWJEdlR6SFdPL1F1Uk1kY1VYdmJS?=
 =?utf-8?B?eDNoVDl5ZmNrVEdYdmowTHFmY0ZIODVpMlpuZXBONzAxK2RPYUtUS3htTHd6?=
 =?utf-8?B?K01YZzUxdFVEa1J1ZzJyclFXNWFERStSMlpWdWNHUDlpclpVT2o3dnBEaDU1?=
 =?utf-8?B?QkFDMVVXdU5yNkRtRFEzRWlsU3BQN240ZjNiU2pHVDFLMTVZS05wTlFhSk5L?=
 =?utf-8?B?S09ibFFRQTNtWlIyUk9yUkdKR1V5YWVkU0VnUnVrcS9ldnd3Umk0c1p2WTZy?=
 =?utf-8?B?dnljaTVKL2l6QmFkUmRlZTBzd21EY1dUWjNJY1JhU21pS1pzYWd0SXBYTGxM?=
 =?utf-8?B?clhmUGRyazIxMVg1S2U5OU9CYXd3dlpIZ0pMYXZsaGVsUzE5enR2Vk1hQzVu?=
 =?utf-8?B?SithbTZ6MU05S1piUFVCM3phMjhBeTlBOXFIcVh1bFovNGpuY0hVK0ZuWmo4?=
 =?utf-8?B?VTZ1S2V2RENITDUreUlhdHY1aVJZbkRlZ3c1aTRscVpQNWxOYjM5Vm52aTFQ?=
 =?utf-8?B?bmtaZXMwRVhHYmtaUXM2T0JEY0dzMXJkTHJzYjRjN2tWbm5CTFpleFdid3pp?=
 =?utf-8?B?a2J6dEh2NzM5aXdMU2NicDBiYy9Gc3Q2eit5YmlXS2tKY292dzhyQXNJUUVn?=
 =?utf-8?B?Q1pkUEUyY0tRWHRaUWJ1U3YwSkNqaE1mWlI0aU1DREV3bE1CYUdmWitwUEh2?=
 =?utf-8?B?VUZLWHpCVVVFTzN1c01iNUZPMTMzWFlGM0hXVUxQQk5NZjliZk9FRVRpZzJX?=
 =?utf-8?B?N093VkFyY3h0YWh5YmVneUMyZVB2bENQUk4yZ2x0NERzT1JnUlRRWk8zVGUv?=
 =?utf-8?B?clBLbU9ac3FKMm8xQnpxbnJvRDJxNlVZd0IyN2VhZ0wwdU9OZXFKNlRxcUtR?=
 =?utf-8?B?YzJrSzNxWkZrcHczTURRZDd6NzkzSnBDT3cvblBmS0NuT2FhOVcvTkFmUEJU?=
 =?utf-8?B?TmxJbmhwbzhPUmJpQVZCK2piQ3VKNjlEM0craXlWYk1pWkZEcVR0RGF4bnQ2?=
 =?utf-8?B?bDV2enVkSE1sdmxhQUROTTYxbCtObzU1WFNBVkxoaFV5YUYvOVdvOXBqaEl5?=
 =?utf-8?B?dlVnQ21hNDFybTd0bjY4ZUZWMFJaZE5Jd3VzSllhL2EzcGNYd2trcC8xMzc5?=
 =?utf-8?B?eW0zR3RmdnFScGs1UnlNSStyeEtCQjdiRkR5M3BtcEp1b1p5VGZkMnl4VjQ2?=
 =?utf-8?B?UFRWVmxHYVFaMmVqUlQzMWpUL1ZXWnBiVlluejJRcDZIZ2p3MVk5M1BMaDFs?=
 =?utf-8?B?aDZqaFZRalVoYVhuck9IUXpUbzcyY3IrcExJZUhaS3Q5L0ZQWWpmcmFCNWhr?=
 =?utf-8?B?RjA3aUVkRzZiNkhqdWM5M0pFNVNtdUlIVE1qVWIzMHFjaXhNNVJsdlZqazN4?=
 =?utf-8?B?Y3RqYlNYK3FPNmUrQjk4SlZYZ0NrMk1kU1Z0OURaYWlJZzhieGxPeDQzMVVm?=
 =?utf-8?B?a0xQVFVDNmFaRjBLbnVsbHU1cVl2eG1aekJwZG83WHlqSjhFajBxQXhqVG0y?=
 =?utf-8?B?bjhybXlUUVBudFJ4VWxYTkhGYVpoNDdhTzg2enpJRHNueVlQWmhocCsrRVNS?=
 =?utf-8?B?Q1pybXJHZzJ5bGNlblVhZHkwWkRYVkdOb21oTzZoYU1nN3VmYjNyMEZybHpm?=
 =?utf-8?B?ellxWUFLSEdkcTZ5TExjZ3UyQlZPb2JPaDZQc1JKdkFZaVhUSEVDRDI0UkhJ?=
 =?utf-8?B?VXRnaFNkbnFEOVlCc05IOURJbG1JKzF3Q3BPRk9FdHFSalNlZThOYVhPbVZ1?=
 =?utf-8?B?bGFWZ1JiZkpIaUpKejVNaFBtcEVWYUVsdFk2S2p4TThyZy9TMHBNeFdWRmN1?=
 =?utf-8?B?YVBYVWhpR0tlU3lZbEsvN3lWcElwNjc1SlhVUHNnQmxad3c3Z0s3eS96OVAx?=
 =?utf-8?B?MTVBQy8yM0FIcXM0VzBaVkdpeFVsTmpJbHJPT0xEV3BMNVRkdUhuV0FZdTlD?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe628ac4-6cf9-41e9-ec70-08da70f135ba
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 23:30:51.8624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNhlvmrn++aF+K5znMqsROKv17yc0xk5/ZqNx37yXbCocJDeTLyt/ypGbuYCWZAP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1325
X-Proofpoint-GUID: H-3gNSli6eLEey27BApB7pVNgxzL68BA
X-Proofpoint-ORIG-GUID: H-3gNSli6eLEey27BApB7pVNgxzL68BA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/28/22 12:57 PM, Kui-Feng Lee wrote:
> On Thu, 2022-07-28 at 10:46 -0700, Yonghong Song wrote:
>>
>>
>> On 7/28/22 8:46 AM, Kui-Feng Lee wrote:
>>> On Tue, 2022-07-26 at 10:11 -0700, Yonghong Song wrote:
>>>> Currently struct arguments are not supported for trampoline based
>>>> progs.
>>>> One of major reason is that struct argument may pass by value
>>>> which
>>>> may
>>>> use more than one registers. This breaks trampoline progs where
>>>> each argument is assumed to take one register. bcc community
>>>> reported
>>>> the
>>>> issue ([1]) where struct argument is not supported for fentry
>>>> program.
>>>>     typedef struct {
>>>>           uid_t val;
>>>>     } kuid_t;
>>>>     typedef struct {
>>>>           gid_t val;
>>>>     } kgid_t;
>>>>     int security_path_chown(struct path *path, kuid_t uid, kgid_t
>>>> gid);
>>>> Inside Meta, we also have a use case to attach to
>>>> tcp_setsockopt()
>>>>     typedef struct {
>>>>           union {
>>>>                   void            *kernel;
>>>>                   void __user     *user;
>>>>           };
>>>>           bool            is_kernel : 1;
>>>>     } sockptr_t;
>>>>     int tcp_setsockopt(struct sock *sk, int level, int optname,
>>>>                        sockptr_t optval, unsigned int optlen);
>>>>
>>>> This patch added struct value support for bpf tracing programs
>>>> which
>>>> uses trampoline. struct argument size needs to be 16 or less so
>>>> it can fit in one or two registers. Based on analysis on llvm and
>>>> experiments, atruct argument size greater than 16 will be passed
>>>> as pointer to the struct.
>>>
>>> Is it possible to force llvm to always pass a pointer to a struct
>>> over
>>> 8 bytes (the size of single register) for the BPF traget?
>>
>> This is already the case for bpf target. Any struct parameter (1
>> byte, 2
>> bytes, ..., 8 types, ..., 16 bytes, ...) will be passed as a
>> reference.
>>
>> But this is not the case for most other architectures. For example,
>> for
>> x86_64, in most cases, struct size <= 16 will be passed with two
>> registers instead of as a reference.
> 
> I ask this question because you modify the signature of a bpf program
> to a pointer to a struct in patch #4.  Is that necessary if the
> compiler passes a struct paramter as a reference?

Note that The true bpf program signature is only one.
long bpf_prog(<ctx_type> *ctx)
BPF_PROG is a macro for user friendly purpose.

For example,
+int BPF_PROG(test_struct_arg_1, struct bpf_testmod_struct_arg_2 *a, int 
b, int c)

after macro expansion:
int test_struct_arg_1(unsigned long long *ctx);
static __attribute__((always_inline))
typeof(test_struct_arg_1(0)) ____test_struct_arg_1(
   unsigned long long *ctx,
   struct bpf_testmod_struct_arg_2 *a, int b, int c);
...
