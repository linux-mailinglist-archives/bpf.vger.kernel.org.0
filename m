Return-Path: <bpf+bounces-2870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19776735D64
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 20:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392A71C20B0B
	for <lists+bpf@lfdr.de>; Mon, 19 Jun 2023 18:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABCB14283;
	Mon, 19 Jun 2023 18:17:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA33A125C7
	for <bpf@vger.kernel.org>; Mon, 19 Jun 2023 18:17:43 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E2291;
	Mon, 19 Jun 2023 11:17:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JCt1mG018165;
	Mon, 19 Jun 2023 11:17:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=eHMQcXs5/nGCmheyHVTHtMewrJELS6Cq8QOfyp2SFfQ=;
 b=gGwcKLKLRXDZwNZEbUQnvUk5EjRZAxjb5W1LaLx2TnNTAiSMiBxLhbnQUDhVUQiB5S9f
 Au1m9mj741km4SYHH2f9xftBId5j8WXt8z2/V/zHiaFuLkHtJmZlElSDIO8cqxqbmvIM
 IJK33ofGQY773NiHggG49Z3Oc1xoBm3W+9q6fmbvHMvnC4RigZTi3mNEopVhSaU5iUvx
 1MFp3kqJ/HWzzykPBu9G88/Q3wWQcWL0stH/cE4c24+O3BdLElYiI8tKxmHDsFoarqb3
 pwesgHzKM1CCEvL9L565NSM2M2tzONJIWr3XxbBywfHNd5bbdajtlXQfufkXu9g896KW tg== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r99xy64qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jun 2023 11:17:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbTC8Q3aOxnblWwbYLI2uQIfcSQz/112KVDzuUtziZxYaw+oMZIzlc1fVLew0RxqFEQSp+Olz7LW9i5fnET6ZlX3HJpLFfOmL+u+iipsJw9qCYz9zvQkzCx/R7zLstb67h+LSbR/u7veSq22piBdGUxTgntZ5tG7I81oAOKcEuTl66MJnlNb5grPcvlnjZqSaueR+xKmMDk2MBMqw8ofX0BYSw8GALSckTdvCvW5UYkG7hHcbPtFLRvSerSBquf6moWgDGiB8O7zy3M8mM7/Ot/9PR3fD6tO9nEGKAnONqJe0n8uVtApY1ToFP/t+NIVuttioc6zilOOXfdC/DWYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHMQcXs5/nGCmheyHVTHtMewrJELS6Cq8QOfyp2SFfQ=;
 b=YHJ+x0hW9VMxix8iu/APNm0ey3sJw0P+Cdy+Hva29DzY/ulKt1o8nEkYlKk3pH9YExg/8Nz92wTfPbXw0w6VJJdUg0N6o2JKvkPrlJ19Jm/cAirrO3aEU3S70x5QLjtYCTQnW9yFyCu6DuAxlhq/8aeNkmSBNlQ3DmjeafuhVoxE7mAmHFf28BNHDmVBJ9ykPtfpyHMFnU3kKq/juwRRm0EAb7xlIGbAIYu4tvi+SusUoh9mzJ/N3aEDXpSgu4ZYdwSiqMziU/LnY3f+TUiD4nmqen95G1GlXuxwKhAof4Do5wz2xlkDRqjbR2S2DzffGUw/lu1u7qmloKO6d61rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5509.namprd15.prod.outlook.com (2603:10b6:208:41b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 18:17:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 18:17:14 +0000
Message-ID: <c26de68d-4a56-03a0-2625-25c7e2997d45@meta.com>
Date: Mon, 19 Jun 2023 11:17:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
To: Florent Revest <revest@chromium.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, stable@vger.kernel.org
References: <20230615145607.3469985-1-revest@chromium.org>
 <CAEf4BzbjCt3tKJ40tg12rMjCLXrm7UoGuOdC62vGnpTTt8-buw@mail.gmail.com>
 <CABRcYmK=yXDumZj3tdW7341+sSV1zmZw1UpQkfSF6RFgnBQjew@mail.gmail.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CABRcYmK=yXDumZj3tdW7341+sSV1zmZw1UpQkfSF6RFgnBQjew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0010.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB5509:EE_
X-MS-Office365-Filtering-Correlation-Id: 782510dc-1f95-43eb-2202-08db70f16815
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BwkiDTsr/UdNJhSBPgrlvtRXDxBif3na01qZvxmFmwOGMoo59kAaRiOoCsSI/qDLZEidfuIzdY9Q6lz4joR7a3p/RiB8Oq1H+lt/72vpuDxTIsX2Zx74G085xxtjvKTbgGlkJls+BWxXApWASx/p8I0BNy7xJuaxMEfkrB+H9xYFx47KpipoWOmItRzeO1vxDIa/goHV1TTcXghtgjqQJExoAopgztRL2JJSOeLV47903KYQtI0EcCHzplCR46oHhOXxbSu4064MqtzJdAU0Vb1abKqTBrrjXOhM26BDz3sbsmgj1qREW8wrY505wQUi0RrtxvvEt4wzipns1G1EJJBnzzJbNQaRh8lxGcxw8A4wROGBvFE/ZbVgBhu9Ihuqdji3imCFtWsTKdgSNp+5wten7/q3OEi2Xv0XNla17iFovUjcRgm7ni9aUnT+qde6SsBfhAt5fbPf+9mcGW+giuGzW0N21affe8BByMlNb09LjrK7oXlf8oAiOiEdgKI6eVFgEZwQG3TYrS1H4fWD2OxXGDFBb4C9mnuZecWN73vzWCBD7Fj4Oxgc5tU18WZI/oBl/lAOiTSO0fwnw8gv37FMp3uiEn8+hBBzEzLvBSGA3JGiZfrtZiflZ0cNwRcUK9FGVpqWA3qiTiWSDr2tog==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(186003)(8676002)(8936002)(66946007)(66556008)(66476007)(5660300002)(110136005)(4326008)(6666004)(6486002)(316002)(38100700002)(478600001)(41300700001)(36756003)(53546011)(6506007)(6512007)(7416002)(86362001)(2906002)(31696002)(83380400001)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0wyQ3NVbzRjMHd3VXdPbGl5UDEwckh4bjE0dWhQc1hVS3J0a21hUmk2eld5?=
 =?utf-8?B?RzJ2NXpybisxTC9LdmVKYlNMNHI2RExWOGNsamlkRXp0OVJDRGRDRTZIcEY5?=
 =?utf-8?B?M1U4K0VzMUl1dVU5RFVQT1FWSHRNVElFU3hTdE1KZmhZVTlYK1d2bGFrNWpY?=
 =?utf-8?B?Z0syTTlPOFJKbVA0bVhWNFZ3emtBQ2dwN0w2dUY2U0x0MWNUSG4wUlJROWdJ?=
 =?utf-8?B?OEl3NE8zZ2VJS1BINFVVanVOTUxvQm1Id2VadU5XMW9PTGFoaEJ6RGVkeGxR?=
 =?utf-8?B?WkxYU0xUaDhaM1NIcUswYXRSZHFQWW1sM1BRNEdrdm5BL1BmalFjWk9UcW82?=
 =?utf-8?B?SmZJdWE1M1JwK0czdjdRcVBCNUJqMm12a0p0dUVzVmw5ZnZQY09DRzl4N25X?=
 =?utf-8?B?Y3lMUVRSMkNWN1VMYnU5R2ZlRnEzWURDKzRtYkRkNzMzaS85Y0FIQjg4aTVI?=
 =?utf-8?B?Zk5jYVdmb3JKRXFPSW9GbnU5NVNFZkRFUXNKbzl6UEwwVGd6b1lwT2FCaWdz?=
 =?utf-8?B?QVRpc1pzRVFpTlVFR3ovVEVXcWd2QTlXblpOOGJyZUdPeXBYUnFBZ1ZtaERP?=
 =?utf-8?B?czNCa1VSS0RHUVREQzJHZEJlaXNLWTI3c3h2VUdQbUp2VDhnMWNHN1NOMXZ0?=
 =?utf-8?B?YVRHcytZUEtBTW1nQjIvbVUyTFRVSzErYmZZd3J3dlFaYXpTKzJiR21lWW1N?=
 =?utf-8?B?NnhyOEdRZUlXT20rbXF6TnVOY2dTR2RHUGJ3OHRhYVQ2NThFaTdRUXdMNjJX?=
 =?utf-8?B?TnVDRC83c0QxMXlpSlJDU1M2N2lZK1dzbmVDR25NRjFOMkNrbjFvQm96eU8w?=
 =?utf-8?B?RFNUU3FWd1I0TSt1a05MS1BvY1dpMTg5MFhJRS8vSjNwbVVGbG5pREZrTmpO?=
 =?utf-8?B?eUIxUzRINGxTZFRrVWdXZThpSVNnVkNuekNNTFpNM050NEE0anNUeWJMdlpZ?=
 =?utf-8?B?YnVEZUE1cURMRkhXbEt2SGUyV09oUk1KUUUwN0s5dHVSSGRZUHNWY2YzYmJz?=
 =?utf-8?B?eTc4bDBKQ3B6MTdUK3Y3eTlqdS9vSVdPSTg2T3ZIZm5PZTlpU24zamNNczRU?=
 =?utf-8?B?TVl4REEzRjcwTnhseW8zcThCTE1lcWFtWit5ay9KbEVxQmxFbDluUjBNYzlZ?=
 =?utf-8?B?L3d6S1lIYkorU1BYVElNU1pEcm9Qd2NQdUtzdjZmb0dLdmtsVThhaHBDejhq?=
 =?utf-8?B?Y2xHZy9ZTXlObjVsWVN6Z3lHMGpJdWtqdW1ZcWtmL09LRWM1Y2UwVFlXUXQr?=
 =?utf-8?B?ZnJrVk1HT1pMb2VyY0VXN0lrSWVuR2lWcmtoOTRSUGRuWWhhc1ZYNkk1VVlo?=
 =?utf-8?B?TUx5dmNsRG1YcGlDS0YrcUI2VHlxbW5RSjdmcjRkeGVmUjFNbFpmdlZzc2hQ?=
 =?utf-8?B?WlcvM1Y3MnF6c1IvTGY0dC9GbURQb1ZSSHBDN0tkcklsLzFjYVBJQnpudk9m?=
 =?utf-8?B?T2dvMlFlWjVPUTVCdHpxWG0wR21LeEpVcUxoZ1BPZlc4aDQxVzJOalpYYTRu?=
 =?utf-8?B?TndNRjBDTk5kSUt1K3JHbFZMaFEzL095S3pGaU82eFpFRmk4ekswZ09sSmU1?=
 =?utf-8?B?Mm5pTWtXUm8zU2VtT3FnOXhySGNJTitPRXpyaldtSHNoTXE3N3JKZEtEQ00r?=
 =?utf-8?B?Z1d3bVpQUnV0WEczR08zQzNhSjdCelBGVlpxemExTXRVTTYxbXJhK3g3YTRS?=
 =?utf-8?B?ekxaTk1kMzFtdEJOR1hIeVREM285a0R4Wnl0d1N5ekFrSTllQk5ZNkNDVnNO?=
 =?utf-8?B?d3dqaUd3MEJkdVFiaEIvU3N1K2ZwREJXelFOZkZad2Q0UTlibkM5TDVOM2p1?=
 =?utf-8?B?Mm9YSUdFdnozOVBYR3B2L3lQaTFiWGlkcWpWTWt0cnJqTHZ6cGkwSGlWZjhQ?=
 =?utf-8?B?NEhySm9ZZERVeU45dVpzQmM3cXRxODE2aHFhNWR5UktxalRWTk00ZmMwVzAz?=
 =?utf-8?B?ZUhmZXk4UkN2WE1kWlFIZ1A2bGdNbHRzaDBTMFcwWWJxR2MzQ1MrT3lFcmtE?=
 =?utf-8?B?bzVMd2pVWDlKUS9sbnA0UzdtajFZTFRDRTd5ZXo0bVZKKzJiZ0xJVUkxalJ1?=
 =?utf-8?B?VmZYYU16NmxLZ2NubVdhazFXUzBQQ1dZcEpDNnVJVkRsTmpxZEY0Vm1KcW9G?=
 =?utf-8?B?Q1JsNmJXaUgxV2JzZGF2OWlvazR3RG5NN3pRLzhoaE9HbG9jTUZJVTcxeDZJ?=
 =?utf-8?B?NkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782510dc-1f95-43eb-2202-08db70f16815
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 18:17:14.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWKOVp4PX0NJijqb5wqdfnod8283qujngzlwEwhOrQuvtQIro1D65/y3RBW/Gqab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5509
X-Proofpoint-GUID: GokTkZ2IQAVECOiOtQIn_8QRzBbLSmJh
X-Proofpoint-ORIG-GUID: GokTkZ2IQAVECOiOtQIn_8QRzBbLSmJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_11,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/19/23 7:03 AM, Florent Revest wrote:
> On Fri, Jun 16, 2023 at 6:57 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Thu, Jun 15, 2023 at 7:56 AM Florent Revest <revest@chromium.org> wrote:
>>>
>>> When building a kernel with LLVM=1, LLVM_IAS=0 and CONFIG_KASAN=y, LLVM
>>> leaves DWARF tags for the "asan.module_ctor" & co symbols. In turn,
>>> pahole creates BTF_KIND_FUNC entries for these and this makes the BTF
>>> metadata validation fail because they contain a dot.
>>>
>>> In a dramatic turn of event, this BTF verification failure can cause
>>> the netfilter_bpf initialization to fail, causing netfilter_core to
>>> free the netfilter_helper hashmap and netfilter_ftp to trigger a
>>> use-after-free. The risk of u-a-f in netfilter will be addressed
>>> separately but the existence of "asan.module_ctor" debug info under some
>>> build conditions sounds like a good enough reason to accept functions
>>> that contain dots in BTF.
>>
>> I don't see much harm in allowing dots. There are also all those .isra
>> and other modifications to functions that we currently don't have in
>> BTF, but with the discussions about recording function addrs we might
>> eventually have those as well. So:
>>
>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> Thanks Andrii! :)
> 
>>> Cc: stable@vger.kernel.org
>>> Fixes: 1dc92851849c ("bpf: kernel side support for BTF Var and DataSec")
> 
> So do you think these trailers should be kept ? I suppose we can
> either see this as a "new feature" to accommodate .isra that should go
> through bpf-next or as a bug fix that goes through bpf and gets
> backported to stable (without this, BTF wouldn't work on old kernels
> built under a new clang and with LLVM_IAS=0 and CONFIG_KASAN=y so this
> sounds like a legitimate bug fix to me, I just wanted to double check)

How many people really build the kernel with
    LLVM=1 LLVM_IAS=0
which uses clang compiler ans gcc 'as'.
I think distro most likely won't do this if they intend to
build the kernel with clang.

Note that
    LLVM=1
implies to use both clang compiler and clang assembler.

Using clang17 and 'LLVM=1 LLVM_IAS=0', with latest bpf-next,
I actually hit some build errors like:

/tmp/video-bios-59fa52.s: Assembler messages:
/tmp/video-bios-59fa52.s:4: Error: junk at end of line, first 
unrecognized character is `"'
/tmp/video-bios-59fa52.s:4: Error: file number less than one
/tmp/video-bios-59fa52.s:5: Error: junk at end of line, first 
unrecognized character is `"'
/tmp/video-bios-59fa52.s:6: Error: junk at end of line, first 
unrecognized character is `"'
/tmp/video-bios-59fa52.s:7: Error: junk at end of line, first 
unrecognized character is `"'
/tmp/video-bios-59fa52.s:8: Error: junk at end of line, first 
unrecognized character is `"'
/tmp/video-bios-59fa52.s:9: Error: junk at end of line, first 
unrecognized character is `"'
/tmp/video-bios-59fa52.s:10: Error: junk at end of line, first 
unrecognized character is `"'
/tmp/video-bios-59fa52.s:68: Error: junk at end of line, first 
unrecognized character is `"'
clang: error: assembler command failed with exit code 1 (use -v to see 
invocation)
make[4]: *** [/home/yhs/work/bpf-next/scripts/Makefile.build:252: 
arch/x86/realmode/rm/video-bios.o] Error 1
make[4]: *** Waiting for unfinished jobs....
/tmp/wakemain-88777c.s: Assembler messages:
/tmp/wakemain-88777c.s:4: Error: junk at end of line, first unrecognized 
character is `"'
/tmp/wakemain-88777c.s:4: Error: file number less than one
/tmp/wakemain-88777c.s:5: Error: junk at end of line, first unrecognized 
character is `"'
/tmp/wakemain-88777c.s:6: Error: junk at end of line, first unrecognized 
character is `"'
/tmp/wakemain-88777c.s:7: Error: junk at end of line, first unrecognized 
character is `"'
/tmp/wakemain-88777c.s:8: Error: junk at end of line, first unrecognized 
character is `"'
/tmp/wakemain-88777c.s:81: Error: junk at end of line, first 
unrecognized character is `"'
/tmp/wakemain-88777c.s:312: Error: junk at end of line, first 
unrecognized character is `"'
clang: error: assembler command failed with exit code 1 (use -v to see 
invocation)

Potentially because of my local gnu assembler 2.30-120.el8 won't work
with some syntax generated by clang. Mixing clang compiler and arbitrary
gnu assembler are not a good idea (see the above example). It might
work with close-to-latest gnu assembler.

To support function name like '<fname>.isra', some llvm work will be 
needed, and it may take some time.

So in my opinion, this patch is NOT a bug fix. It won't affect distro.
Whether we should backport to the old kernel, I am not sure whether it
is absolutely necessary as casual build can always remove LLVM_IAS=0 or
hack the kernel source itself.

