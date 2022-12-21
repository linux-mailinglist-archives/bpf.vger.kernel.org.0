Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7470865356B
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 18:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLURlf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 12:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLURle (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 12:41:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A134192B3
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 09:41:32 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLHEH25002681;
        Wed, 21 Dec 2022 17:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DYMA761UhRNNAxuw9FZcCUKBEtRCcAYMiuQ1iQ+yWZ0=;
 b=eR3EhhW/Yewo4GiXSaDIXrppxf4778nQhdexEmutmU+nNcS96MAwP2QaiWASIloxlcs6
 bEdFDmK+hCTATz0vCUxQelimq9O2v0DgVFgQxz4Lq/2ZPqTx9jqmmzdEPAnYsa/C2XNh
 mqw+PEB8fKEyES7O+EpxomxdPxc8w9KaPHh0mRgNfV4xpVBtBkwzsfEaM8/fii8vtLD5
 ZBbizxDJrMarbBfEPnH7nQE6aZvd/6HalSShS21Atjd7coGyoK3QnFyCWfd+Ci00qwpb
 3Uaa2JsoIbSu+8yd//YPx/wF8XxejQMoxWYJit8C/zYbX62KTXxPS0EiLk0Rqg/aZ/xo 1g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tpsnr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 17:41:25 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BLGRILc004617;
        Wed, 21 Dec 2022 17:41:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47d83qu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 17:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOhAlfG1UIY6ojGwrm0R9GtXDuNRhxbwcLBHWifphnSMpDA+1OaRDa5G6aPT1HTX16wTYacgdC5bKK/J0bBybnVMpSgrFQ+699Wd/Ijlb0fzhfwSo0jlsq7zksNKFykudxCRZzI4FZPwr/5//eS3ZchSc0YckJlW6sthjOuOzOJ24EwokDyA1SxCsfh94eaeeXX7lN1+yvmiq5ie5Agpk3/bFzf11LZmiDTViwlYbAtgucZiWXYx54K0nMq4q8yHRQkb8zvAS3vKhCWdbxvaEyCbeunwfbRY7qVQxC88f5yMxy2yN4cwHcklVU5amgITGkRXd1rNw37nY2887hFjrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYMA761UhRNNAxuw9FZcCUKBEtRCcAYMiuQ1iQ+yWZ0=;
 b=ZhvLA5YjStZqjSaV+pe5lWE1jdo9QhyAPERZs8vCMTXfJGxhe5euf/9jO1P9bHwNYvaR1yQMG0vhXwG4/CS1RZg4knnGoT2DTtTF3dAKMyRtDfWr3HEqcXvMdmA69fMAnTuFWkz9x9jegjsFFr7BjVNKbQIX/XdVoKE5z8dPmuF1BM05DU8mCFwxqlqr0ja1aWXVzqNsdO+hbMvM404f0SMpJYn7EalxXShuXea3ikHByqLSEbLI8/+5OXfa2VGeMb684fVpROmlyE7tiply3a278nA2qaYZFt6qN7a+uE1Dmb2JGc7tH9nIrACliEispxCtqCW1eI0935enaZIV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYMA761UhRNNAxuw9FZcCUKBEtRCcAYMiuQ1iQ+yWZ0=;
 b=CkqZ2QW/Lm9iE4Cg8g33WzkI1ZRuMjwTAFJpap2DGtW/cJjAPGgMSEWLqXdxv4sdf3H16PpP5FNfI09m+ye2gZTFlKaMdXEbtT0ITvTG9IoeeO47IgIeABPZW6yLXNVpqV5kGv5VQ/9dzGZycFRh6tT5xLzWOvXZxYYcYE17pz4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 17:41:22 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::f496:5c7f:de65:f4ee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::f496:5c7f:de65:f4ee%9]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 17:41:22 +0000
Subject: Re: Support for gcc
To:     SuHsueyu <anolasc13@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>
Cc:     bpf@vger.kernel.org
References: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
 <CAEf4BzbQYUQu1RaVrqBNJzjPxRa=W7R-ezuZoXY4O=tUP22dTA@mail.gmail.com>
 <CAEc2n-tRdpoFRA+-wQYdmgabx44xMy9cD6aAW+y7bKMUJ1r=gw@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <f0b6775d-116c-e403-ec19-a363f90534bf@oracle.com>
Date:   Wed, 21 Dec 2022 17:41:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAEc2n-tRdpoFRA+-wQYdmgabx44xMy9cD6aAW+y7bKMUJ1r=gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::29) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e25b0c-141b-47f4-bf0c-08dae37a9302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTelBgr9T4HLg5v/d26FDFcM8pz6w47zBVktpvPko6tC9QeKy70zbI5COsTWivWKTerbDFDzz8qpw33TZTRUKmtfCY9ET/BeRHXsgDMQq78nV5hVrVdO9qNzmhXzsNJltxed5Ok9MX2lUujJy89Lw3s9Lx1I4QcThJFqkpBggbrTdgQQuWxhj1GkXfmPvezGdIP2OdlrY83zaRUpGmqc0bF5R2bEA3xrfCN8cAkbvh9jFJytveXmSgpBqlYXpG6SGFIMJ2wgUpBHazlTiIzfq7+xz6aO8C33yJG513699H1buiSkJuHLwCKYt1Frpc0H3MF1rRe36GAzHqxoqwWSg4a0u51mLo4yoFBs0fhIWshlF3pGfe2BGxNIY9VpNqmVSWrpP5zv9VITuoHyGTQcy+oXjIUrt+sBhPmrbib2JFSt8ReBQP/OSXDjgiMgF2yXD3l+e1bTy0/7iOi8tBnyG928of02yw3mQGoTdkM0kSwEuf4/L2mLLdnMGVtouscZJUoXs7t3lLUlwIHuzGGQuaKqDgIsXG1uUrNs9y4GxZ318fqH+EMHE5mndlYe++BG8GcB16oSf976mkWyJHpueBLD1rfqCRWeGjz2LvLSnQs8Jv2B8SQawZ5DyA9b0uGh0RhzIJ5C00OMGZq7PT7nJNSX9LgvCx6m+c9dfaRVMLHOMT+KfB2LgQ5FLFSxMaYQDW4AWE3fLcTXV8tR515XlDM656j81CpYcPC5MuLfkQrOfyRqolkGRwxSI62ZtghDr0zzc7Utuvb1hZ/ssrMkIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199015)(6666004)(31686004)(5660300002)(8936002)(186003)(7116003)(41300700001)(3480700007)(44832011)(6512007)(2906002)(966005)(6486002)(316002)(478600001)(53546011)(6506007)(31696002)(86362001)(36756003)(66556008)(2616005)(66476007)(66946007)(4326008)(38100700002)(110136005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlhRYi8vNkZJdTNLTXF3K0E4V050a1ZMUXZ3UGY4NFo4WUVZZEdoR0ZKcWx5?=
 =?utf-8?B?Mk9uaFp2eCsrWXU0alpVVG5aNDY2TnNQRzdncG4yRkEycjAyZllZbG5NUjNz?=
 =?utf-8?B?RHBWNkxEYTZYVUdBZjA4dUNGQUYxc3JFbUU3MnhWQnlxNDhrWS8xdituTFhw?=
 =?utf-8?B?azFSRTZQMGtBQmhtN0RKMmJUZ21iNS9mMzJFakF4bWd5MzIrU3poZXprbk9B?=
 =?utf-8?B?RTFqQWNDYmsvcnMwZjZkRmduWkN6WVozNE9HSXVKQ0lXaGRXdGZvNmcrMDV2?=
 =?utf-8?B?QVpKUVFlbmNSWnpERUJLOUd4NnVwRTFJRkVmTW5SREgwNUFDRk9tVEoyRGll?=
 =?utf-8?B?TXYxNys0bGhGbVpwVWZlNUZRcEFsN3l5SHl0VVVNa2xCMGpscXBuMUhoYXRh?=
 =?utf-8?B?NC9RNVZQUHZVd1pCQmw1L1ZVWFlwSUg2VnoySDR4WURDMU12SWkyVExYVmEv?=
 =?utf-8?B?VlByTUxhcExyM3dFd21tdzRhRUZacWh3ZHlGZzlyODgzbVRycC8yTWxtTEFl?=
 =?utf-8?B?bmZSR0F3eWxaa3Nzbm1qYitaMWNvNDNNdGpPNEtnQUh2a2dHb1BwRlgvcnIz?=
 =?utf-8?B?eHBUYXh2NjVJbkpjUlpUVmtvdEFKSENObWdJWEFyeTZhaWJJdURWREV0WTBs?=
 =?utf-8?B?SzQ2V01XcEtsbkoyWWNFeXJ3aTVneGo2RTFub3JzbER1MHhCOVlsQitqeWU5?=
 =?utf-8?B?ZFA3NTcweVZQRGxqUmlDZjNadGQ2N3o0L0tJcTNNZWdYQXhuOTQvcm0rNFZV?=
 =?utf-8?B?K0hXUTBQSUNIZ3pGd2szaURYTHZicVk5d3N0WU0ySXI4SlphMlF3SHNWYm1W?=
 =?utf-8?B?S1crWkxhbTRKakxod2c4RndaU2tKSFNTTVJjLytUUzcvYnd3d0hoeUtDYWpD?=
 =?utf-8?B?UDYySTJFR1cvUU1aVlZXZjNodERKVUplTStwSkpFOHJrR0h3SHlzdWxJQ1Nv?=
 =?utf-8?B?RlVSM3VEMkl6ekkwaUNHTUZReHFnL05Kc3hWSXlTMWJGelRiNEgwNG1YRnJk?=
 =?utf-8?B?dHpuR2NQSmlSZGlvT1Zxck4vdmM1MmhlbUdzek9sRTgwQTBpQTd5U3hiTVVm?=
 =?utf-8?B?eFZkM0dSejFLWGJBUWxra2VYcndnU01kcjdZcGlFblg2SnowUXFCV0tWaWpT?=
 =?utf-8?B?UDh1VDJqVWRqRHIyZG8yK3VxdTNWTmNIWmhyVmNxSUdNVlZvWVMzRy9UZFNM?=
 =?utf-8?B?OXFrNm5MaklPUHVJRWR1enR1S012eEJJR1A3UDBoUWU0RXByVlZEc1d4V2kr?=
 =?utf-8?B?aTYrMjh5cDExWXV2K2JPQjNhQ2xtaWtOK0EvUTE0c0ZWT3ArUW1kKzYvallS?=
 =?utf-8?B?WHVMcmxvMnpqOS9EQlhvbytZNUJnK3BGZGY2TmplUHUycGdJMEl3bWVSMEZw?=
 =?utf-8?B?dzVKTFhadVMwa1IxNHVacDFSTDk1SGQvNGswdVNtQlZHaElZSEVCTkdBOXd1?=
 =?utf-8?B?MCsreGRqQ1ZlMWM1VnpMcURrTWJjYXE3bjNLMHpDK1laT0dWamROcXJQWUJX?=
 =?utf-8?B?azhYZFVFeUF4WGJqSzRFTmpPOHlBYlVjY0pvNnc3SnRwZ3Z5dGY3alBFSy9r?=
 =?utf-8?B?di9zbWwvZDQ0bC9DYWpjWGRnc0F3azRHN3g5eVovakhwd2ZOUzdjb3BMcjdx?=
 =?utf-8?B?eFJFWTBzdmdaOXFXY2MrYUJweFlTa1dBb3FZRUJnb005MllmZzhPSEEvWEFj?=
 =?utf-8?B?N01tRVM5RThTU0tzcVd2S2g3dDJkbThncFBZQ2dDc0hLSEo5QlBtYyt3dnhB?=
 =?utf-8?B?SWxUMFpOOGU3NTg3SnhTaWk3dlE4eU96T25vYWJaOUpJM00wREJkNUlKQmxP?=
 =?utf-8?B?RkdLNEhRV2paNmlhNVV2TFBoM3lkU1ZHVlhrZWJ4ZHpCemQyc0xOSUNXeVZo?=
 =?utf-8?B?SWZ2OC9qTXBMemMxKzdUN3dJVkRweTVIWEpqYjVMSUNMcEVHbGVaOGtBVHZO?=
 =?utf-8?B?ODRjZjVWYXJrRm0vTHE4QWo3aFY0OHIrOW5SaVZJSXBRbG9QNnU1ZTVuTjEy?=
 =?utf-8?B?WVVyYU5BNUpqVTlkOFlTTm02QzM2YWlUSTNvTENnazhSU0g3K1d3YzhiM1V0?=
 =?utf-8?B?UzI3c2RBbTVBc3R2ODFlWmYrN0ZNbFFFclZHSmc4TUtiTUxGaHVLQ1pEcFhw?=
 =?utf-8?B?blU2MWNGQjVuM2tRWGhzRTJNSmpGcDVrcTZOT1pxcFRDVy9HM3gvbXFhMncx?=
 =?utf-8?Q?LsJszhxcMUxT+aWzG+3OWEw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e25b0c-141b-47f4-bf0c-08dae37a9302
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2022 17:41:21.9854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2o1NQMjo8yhCsIh3FtL9cZ1VO/OOjP0NpBjpHRWxYJXLg1LaKsxWwbtzx6Bhcj/HaRRmWTsgEvY2zMIycXfXJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_10,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212210148
X-Proofpoint-ORIG-GUID: 5xwqAGrISef6Zpc_pLY-2_uPQrSNTdRq
X-Proofpoint-GUID: 5xwqAGrISef6Zpc_pLY-2_uPQrSNTdRq
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 21/12/2022 11:03, SuHsueyu wrote:
> I used clang and gcc to generate the obj files, and then readelf these
> two files, I found that there is a problem with the machine item, the
> machine item generated by clang is "Linux BPF", and the one generated
> by gcc is my physical machine architecture "x86-64", which makes the
> check of "ehdr->e_machine != EM_BPF" fail.
> This seems to be a problem with my not specifying a compilation option
> similar to clang target  when compiling with gcc.
>
> On Wed, Dec 21, 2022 at 8:34 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Dec 20, 2022 at 3:56 AM SuHsueyu <anolasc13@gmail.com> wrote:
>>>
>>> Hello, I use gcc 12.1.0 to compile a source file:
>>> t.c
>>> struct t {
>>>   int a:2;
>>>   int b:3;
>>>   int c:2;
>>> } g;
>>> with gcc -c -gbtf t.c
>>> and try to use libbpf API btf__parse_split, bpf_object__open, and
>>> bpf_object__open to parse and load into the kernel, but it failed with
>>> "libbpf: elf: /path/to/t.o is not a valid eBPF object file".
>>
>> if (ehdr->e_type != ET_REL || (ehdr->e_machine && ehdr->e_machine != EM_BPF))
>>
>> This check is failing in libbpf. So check which of those two are not
>> set appropriately. cc Jose to point where to report GCC-BPF specific
>> issues.
>>
>>>
>>> Is it wrong for me to do so? Due to some constraint, I cannot use
>>> clang but gcc. How to parse and load gcc compiled object file with
>>> libbpf?

As mentioned https://gcc.gnu.org/wiki/BPFBackEnd has some details;
I used those to install gcc-bpf-unknown-none/binutils-bpf-unknown-none
(package names differ for different distros so use the wiki page to
find the ones you need) and ran

$ bpf-unknown-none-gcc t.c -c -o t.o -gbtf
$ bpftool btf dump file t.o
[1] STRUCT 't' size=4 vlen=3
	'a' type_id=2 bits_offset=0 bitfield_size=2
	'b' type_id=2 bits_offset=2 bitfield_size=3
	'c' type_id=2 bits_offset=5 bitfield_size=2
[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
[3] VAR 'g' type_id=1, linkage=global
[4] DATASEC '.bss' size=0 vlen=1
	type_id=3 offset=0 size=4 (VAR 'g')

$ file t.o
t.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), not stripped

Hope this helps,

Alan
