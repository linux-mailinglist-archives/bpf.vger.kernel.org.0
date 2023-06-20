Return-Path: <bpf+bounces-2921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CA9736F3D
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E98A2812DB
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357F168D4;
	Tue, 20 Jun 2023 14:54:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E835101CA
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 14:54:03 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14495;
	Tue, 20 Jun 2023 07:54:01 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KE0E1I021700;
	Tue, 20 Jun 2023 07:53:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=MRMxToDpyjMoFISGOlDOXWkl35fqaC//qvBAJ1fkJoM=;
 b=CPFAC5GzTPrQQN0qocuHZKV1bH5nbY79U2yLP1LwtsnkDRPkPegbBX6omrDfP2D1Aqd5
 H77a0MZQ9v8lSOSSZ/Cv3mPk/1R84HUbNkQAdcl1hlflYk/ijh/GRrOWKDPuw6v2L/Y9
 QNMa0Hz7qAR4ogGT1GW0sG5aaQlM65F3tdHpUjZVzzVetb9BAFmPADE8P2a3nGGvqCGk
 zsrrRgllVVHXvQIJ7ueN+r6Jv0sO3xRDF/N/pwJ9KD8sXy91LGSqD7mq7FMK1nGPw/ia
 Mv95pYEjz9k0YJbEBED4EyWk7/sNu5O8N4+jYgcOlA9X+9SFCPYY8yYksDdGVDSQbJ3U pA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rb1cy4t7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jun 2023 07:53:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8k9RzYudAetA7M3oTQOT4rK9zYEyMratLY5ExsX2IUV32nk1KEnKPwv75bM+S1y+BCxt5NU90Vjh2D0BXGV6poESspaxzzZYdYvZKP9BIqToGqbrQg56Cy7Fn698I6+dLugk5PQCV+yB7Jht33WDIiTdXYwD1mw23/aKgTwZiKOX/wbd4vUPhr0mDPsjYSSG7MqctNL7/BGTtrZKvUHdrNKB+ZIFRF3Y2HdOFgocxBSOYEPwcUmKLZEdvwZA22sJSRez48x54R2zn38wizqIGaV8EbPyDB01EuLhMnPnYiGxCTLqVZEdzVYIUF324Q9foupx8RB+46+3Gy0J9ZJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRMxToDpyjMoFISGOlDOXWkl35fqaC//qvBAJ1fkJoM=;
 b=O4azG7dqv4bI+rHmZKaODRNDTeqbrxQD38nI7oUlGW83f7GpOBbz+4QS3oDCJadmLd2RMhtRVZvGx5W+AlTX0gb7OUhXYzJ+OfN1KDOKKJFbFR9RG2dXU13M8uS5kt2/mFWuRFhJ10zOMilgbFbfcnUGoNyAJxLj4Wt5UC9LzNxLrGLD/o4Nbs+XgXfEL2TBwnMCWNeKaCPE9NIczNCtjQ86PLwHOmnrIJVZ3ZnISbqOSGRHqL15VN9rBGKb7Jz7iPD9Z+BNDjF25Un/qUAp8w1QuGucl1Jryrb7N2neXrJRSr8G65MDGirQTGQGHl6KUw+xAPm/6ZmaWHRwLWwKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB5165.namprd15.prod.outlook.com (2603:10b6:510:14a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Tue, 20 Jun
 2023 14:53:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 14:53:32 +0000
Message-ID: <6b63301f-96b2-74b9-c156-3a34fb5ad346@meta.com>
Date: Tue, 20 Jun 2023 07:53:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf] bpf/btf: Accept function names that contain dots
Content-Language: en-US
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Florent Revest <revest@chromium.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, nathan@kernel.org,
        trix@redhat.com, stable@vger.kernel.org
References: <20230615145607.3469985-1-revest@chromium.org>
 <CAEf4BzbjCt3tKJ40tg12rMjCLXrm7UoGuOdC62vGnpTTt8-buw@mail.gmail.com>
 <CABRcYmK=yXDumZj3tdW7341+sSV1zmZw1UpQkfSF6RFgnBQjew@mail.gmail.com>
 <c26de68d-4a56-03a0-2625-25c7e2997d45@meta.com>
 <CAKwvOdnehNwrDNV5LvBBwM=jqPJvL7vB9HwF0YU-X5=zbByrmg@mail.gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CAKwvOdnehNwrDNV5LvBBwM=jqPJvL7vB9HwF0YU-X5=zbByrmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0017.prod.exchangelabs.com (2603:10b6:a02:80::30)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: f03b62d4-d6d7-4d51-c49b-08db719e1e03
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3CxrEy+1NDFsZIh80ztiqgq4QEJKWTFSjhcGxqWhWs5Q6b9fHVaYCXp7jIgFChJ9PrL8LbMjtRZCHhSM+IO9Ukg24uLzJ4kBGs/wCNaG28Xpij6KjlQUOBEAaVaD4ZNcCUEGGjbdepUOfKM1aDfO6yQW9SkmVp3zwwW/d6aoY1lklOsgZM1QUKEnFQ+LAcxgixA8a3XkgcY30C8XKnoom3vIRimy9xrhUL5fFLsUTYrrGIH9akqP0WzOO/MNvJ1xpUZe8qM7Up+ireJ59sUrft/1XqyldokG3/70p6AfppCe8sHC5e5AeMzc9oBqDSaMlQWxVdDE98vS0h1SItSSKzzc5Xz+TpouOuIu2DsbxAXyKchyGpnpZPL3A2x+Gpfp1AnY5tXr6DcD0PGcEbcIvATYF2asW87cGXlxbuhqQesNRw0xlzdWAT4SiX+WcY8qd2ltFRcs//3ejRKfS7EAjeQ01VS/hodQsMkv+Rxg97P+HmFWGb7XF4m6VtNlNBLZ2o4STv9FEzvbcJv2DeS4LK29dTJM6qq7bVbfqJ/5X1s/Rg1eTWFC8FaPLN1NmMv0IBiUC5OnOQ5mHEw7Lw2kXEGaOrRxiNpyyLf71FiiMTAsA3AR7Uhsly5pB85BM54TM7ul0kj261f1OzVilWwZJA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199021)(7416002)(31686004)(83380400001)(2616005)(31696002)(86362001)(2906002)(54906003)(5660300002)(66476007)(8676002)(186003)(66946007)(8936002)(66556008)(4326008)(478600001)(36756003)(41300700001)(38100700002)(53546011)(6916009)(6512007)(6506007)(6666004)(316002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXBpbHVBK1N6WjdWbXNFVWY5MlM2ejBBZTFyWmJPQ2hBais3dmhuZytBTVNm?=
 =?utf-8?B?T05iakZEY0VvSjUzWEp3QlFQTnJTZ3pvL002cG9ib2dRUzhFVDBMTTFwR1BM?=
 =?utf-8?B?cnN5SXRBZ3hwZXllaGV5NytFY2paaEtqWUt6Qm5NTzI3Tm40MThvZEdyNVRO?=
 =?utf-8?B?cWpnUitjenZNU21GbWhVZXJ3SGNQbGhiRVo0SlZCUktVZXFTNk1oS3BrYTZE?=
 =?utf-8?B?SWp4ZUxIZWJoUCs4MUpSKzZKbHZlY1BMVXhLOFBKME5OTUFHZjN6ZW1LNWN3?=
 =?utf-8?B?S1ZqSjVQRWw0dGNaRWhvMFplNkJTOUV4UEsyYkdNaTBMYVp6WGl6QjNDaXY3?=
 =?utf-8?B?eWRBU1NnU0RUT2Y2TkZ2YVZKOUlzaVRueE9xcDl0bnljZHp4WTcvZHFrWi84?=
 =?utf-8?B?aTZ2cHR2TDJxSDBIT0JiWG80TXYrOU5GRFhMN3ZKZExoYVVqWEVTVGNGK3VH?=
 =?utf-8?B?WE9IWlRRM3o2NWp4Y3ViSGYveTlvMHg2Z204MDA0aTJFRGZuUmtucnJLT3h2?=
 =?utf-8?B?OGlOQkExYytZR1FYZkJOb0draThXaHRDMDMrei9sUUFQdHBwUkFwM1MrVnZO?=
 =?utf-8?B?eXdXTTUySi8zbFFlalU3OVRQVXNHZlZTUzJVeXJoeHVWTFE0OENwTDF3WmJw?=
 =?utf-8?B?ekNtWVdkczBzejlYUVFnb2dZN3lmVDIzSHcxU01iY3d4SzIzZ1JPd2EycFhS?=
 =?utf-8?B?TkFlRXFjYWNGWWFSdXUza25aNDRLSGpGSmg0ajE1NUVCZVBBZXl1eVEwb08r?=
 =?utf-8?B?Q2dlOUN6cU80VTZ2YXcrMmxvc3RMNGFrc0RhVzhJdTJuMXRBYXhlczFOUFJx?=
 =?utf-8?B?TGdMQTZ2MDBtNE9lZEIzZlo1Mng1ZWpsQnJUWHA4Q0VqYjlpaEdiSjM2bGUw?=
 =?utf-8?B?d2VDYXRrY3R3WXNyK0l4MWc0UGpvSUlqUDlIVTF6QVgxNThXckVqa0EyMWo3?=
 =?utf-8?B?RnV2TXZRNFpQQXY3anRaQTN5ODFSc0tFekYzQ2MwUGs0U2tSQ09UNWtHNkVq?=
 =?utf-8?B?K0g3UmlXQ0VIbG5scHlMb3YrODVGRVNySlNrb3pPWXlIL0JYOWtRSVdVbHpC?=
 =?utf-8?B?K1FhR05XaWRNeTY2YlZ6RytYb1VXWlhjUHN5SzdSVnJpZVh2Um9BVXNSeVhX?=
 =?utf-8?B?OTJ6aGtGMFpGOG04QndaQ0R1aTdpOE5aT05FQjRMZnJYR0dVMTVFRXc2V2Nz?=
 =?utf-8?B?RFdpVTVzS3F5QW9UZXZhQ1MzNytMeHBDN0p0dE4yUmd2QTlQRUd4RzZjMHJQ?=
 =?utf-8?B?R0xiVUNwOTY3NjJTckZ2cVNXdVg1NmpUaUdJeE9XTXF6WUViME1VT1VLeHhU?=
 =?utf-8?B?bHk1a1NMaElxaFhvUVZUNzJzSzRJMkVoNlRjdXkyYmIxbHk5bWYwOTBFLzhj?=
 =?utf-8?B?SEowaXYrbmV5OGRmeG45dUVhOG9xTE5xNkUyTnl2eFR4VVlvLy9xbGVJSjJM?=
 =?utf-8?B?OWozRENaOVR1bTREejlVd1htYitrNEFmLzMzNTdKa3pjaWl2MERlQzJvMHkv?=
 =?utf-8?B?L0hFbkZoUkFGNlBDcGNwQjZvaGlTVys2RktxOTVzMnk0V2RzWXRhRTRXVVJE?=
 =?utf-8?B?d3NlWmsvS3cxRWZEblJuNkRWcHRvQUd5SlNaTW50WXRGZUo2Z0hBSjR5LzZW?=
 =?utf-8?B?Q3ZJV3I3eVpmUUhDU1ZCQXZ5K0UweEVWZjZMM25qSWlhcmQvOVNrbEFQVEhO?=
 =?utf-8?B?S2pFS3g2K0owMWJ1MTlCVm05WDF2Ui9RMU1OdGUvT3g1VU9BTGRtejlHdnRl?=
 =?utf-8?B?ajVuVDJ6anZTM29IdzJxSTYvWmJIMnREZEpkZUJLUmJLOHo1NmZHaDEvZmhr?=
 =?utf-8?B?M3gzdkVBWnlGUTd4MVpYYlBoQ1p6aVAxM0JrU20za3g3djlxU3RzbTdkSnlQ?=
 =?utf-8?B?YWNnZUp2d1h0L2V6MGNON00vVlc5cmFVMXZlQXBVQmdtN0ZtQ0ZvemF5SVky?=
 =?utf-8?B?cXhpRkpzd25CMHRxUlNkc2YrNCtsRG5WSERyeTJCOEo3MDFCdnNUby9hMnJL?=
 =?utf-8?B?ZGt2dEFCeHc4SlpuRTR5R3prcW1SVzFWcmZkR2FRUTRPUkFTYVB0VnUwNkdh?=
 =?utf-8?B?WW5sN0JCTERrY2Z4MDhyQlQvZHVPYmZlWkc3RmVqNDdyU1VhTXpTUDlHS083?=
 =?utf-8?B?SWhrcDc1WG1xYVA1YjZndGN3eHBsVUxSRU4rd2xQUTdPZVpKUmlJUFJWY2FH?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f03b62d4-d6d7-4d51-c49b-08db719e1e03
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 14:53:32.6677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNkIF54Rinj9Heznz6y6A2aUNYKYgbiRdGxlJSzffLbuPW4MBXv4Mp8qK6YAEsXp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5165
X-Proofpoint-ORIG-GUID: Lgzu7zW_0iCuI-VX6jBb81qooeztpBHw
X-Proofpoint-GUID: Lgzu7zW_0iCuI-VX6jBb81qooeztpBHw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_10,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/20/23 7:38 AM, Nick Desaulniers wrote:
> On Mon, Jun 19, 2023 at 2:17 PM Yonghong Song <yhs@meta.com> wrote:
>>
>> How many people really build the kernel with
>>      LLVM=1 LLVM_IAS=0
>> which uses clang compiler ans gcc 'as'.
>> I think distro most likely won't do this if they intend to
>> build the kernel with clang.
>>
>> Note that
>>      LLVM=1
>> implies to use both clang compiler and clang assembler.
> 
> Yes, we prefer folks to build with LLVM=1.  The problem exists for
> users of stable kernels that predate LLVM_IAS=1 support working well
> (4.19 is when we had most of the assembler related issues sorted out,
> actually later but we backported most fixes to 4.19).
> 
>>
>> Using clang17 and 'LLVM=1 LLVM_IAS=0', with latest bpf-next,
>> I actually hit some build errors like:
>>
>> /tmp/video-bios-59fa52.s: Assembler messages:
>> /tmp/video-bios-59fa52.s:4: Error: junk at end of line, first
>> unrecognized character is `"'
> 
> Probably because:
> 1. CONFIG_DEBUG_INFO_DWARF5=y was set or
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y and you're using a version
> of clang which implicitly defaults to DWARFv5.
> 2. you're using a version of GAS that does not understand DWARFv5.
> 3. you did not run defconfig/menuconfig to have kconfig check for
> DWARFv5 support.

Yes, I am using llvm17 which I think the default dwarf is v5, and
indeed I have
   CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y

My gas is 2.30, probably too old to support dwarf 5.

Yes, I didn't run defconfig/menuconfig.

> 
> The kconfigs should prevent you from selecting DWARFv5 if your
> toolchain combination doesn't support it; if you run kconfig.
> 
>> /tmp/video-bios-59fa52.s:4: Error: file number less than one
>> /tmp/video-bios-59fa52.s:5: Error: junk at end of line, first
>> unrecognized character is `"'
>> /tmp/video-bios-59fa52.s:6: Error: junk at end of line, first
>> unrecognized character is `"'
>> /tmp/video-bios-59fa52.s:7: Error: junk at end of line, first
>> unrecognized character is `"'
>> /tmp/video-bios-59fa52.s:8: Error: junk at end of line, first
>> unrecognized character is `"'
>> /tmp/video-bios-59fa52.s:9: Error: junk at end of line, first
>> unrecognized character is `"'
>> /tmp/video-bios-59fa52.s:10: Error: junk at end of line, first
>> unrecognized character is `"'
>> /tmp/video-bios-59fa52.s:68: Error: junk at end of line, first
>> unrecognized character is `"'
>> clang: error: assembler command failed with exit code 1 (use -v to see
>> invocation)
>> make[4]: *** [/home/yhs/work/bpf-next/scripts/Makefile.build:252:
>> arch/x86/realmode/rm/video-bios.o] Error 1
>> make[4]: *** Waiting for unfinished jobs....
>> /tmp/wakemain-88777c.s: Assembler messages:
>> /tmp/wakemain-88777c.s:4: Error: junk at end of line, first unrecognized
>> character is `"'
>> /tmp/wakemain-88777c.s:4: Error: file number less than one
>> /tmp/wakemain-88777c.s:5: Error: junk at end of line, first unrecognized
>> character is `"'
>> /tmp/wakemain-88777c.s:6: Error: junk at end of line, first unrecognized
>> character is `"'
>> /tmp/wakemain-88777c.s:7: Error: junk at end of line, first unrecognized
>> character is `"'
>> /tmp/wakemain-88777c.s:8: Error: junk at end of line, first unrecognized
>> character is `"'
>> /tmp/wakemain-88777c.s:81: Error: junk at end of line, first
>> unrecognized character is `"'
>> /tmp/wakemain-88777c.s:312: Error: junk at end of line, first
>> unrecognized character is `"'
>> clang: error: assembler command failed with exit code 1 (use -v to see
>> invocation)
>>
>> Potentially because of my local gnu assembler 2.30-120.el8 won't work
> 
> It's recorded in lib/Kconfig.debug that 2.35.2 is required for DWARFv5
> support if you're using GAS.  My machine has 2.40.
> 
>> with some syntax generated by clang. Mixing clang compiler and arbitrary
>> gnu assembler are not a good idea (see the above example). It might
> 
> I agree, but for older branches of stable which are still supported,
> we didn't quite have clang assembler support usable.  We still need to
> support those branches of stable.

Thanks Florent pointing out 5.10 stable kernels which have this issue.
I am okay with backporting to old stable kernels if that is needed.
But the patch going to bpf-next should not have a bug-fix tag and
the patch commit message can be tweaked for backport to 5.10 though.

> 
>> work with close-to-latest gnu assembler.
>>
>> To support function name like '<fname>.isra', some llvm work will be
>> needed, and it may take some time.
>>
>> So in my opinion, this patch is NOT a bug fix. It won't affect distro.
>> Whether we should backport to the old kernel, I am not sure whether it
>> is absolutely necessary as casual build can always remove LLVM_IAS=0 or
>> hack the kernel source itself.
> 
> 
> 

