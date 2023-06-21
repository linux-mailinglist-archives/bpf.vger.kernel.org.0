Return-Path: <bpf+bounces-2979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A307379B4
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 05:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E131C20D74
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 03:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAAF17FA;
	Wed, 21 Jun 2023 03:28:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C917EC
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 03:28:46 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DD5DC;
	Tue, 20 Jun 2023 20:28:45 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L0Fb0F006572;
	Tue, 20 Jun 2023 20:28:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=J8wxnOwdnptZrdgiH7+QqGmhk1ut888eKBpsu2fPbl4=;
 b=gxryR+2dTHoB8D+0Gn0R990O+s77xDHRgv42SxfC8u9/Q558+rAbuncqGi0RJgqkZELd
 ZtwpecK4dOIqRClkXd2FLKoFhh5nr7xnZb9LIPbccwy2DvZB/I9jorNBgyjKOMfdAo8j
 93e8NSPZV2pOKgGnfJ8dMlmllH3uf+LjTO8paTYgpPk6+8xnVZmkBCQcjHpWb0CKf8+4
 cICnabR9hDQvz8josLPfD3KUSjC16vmrJFj51o8B6axfuQyXFyV27IdZu7X237DMFtuT
 2yHbcnS7INx5zzgWVyjXpGIMCvhupvHjvB/RbOcqaxdth1eZJfv6F6pd/u2pEAfm4Vze tg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rb1cy9ukc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Jun 2023 20:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DB4cFGWZYUvDPIDuDG8H+fOVNPkySBhq8r6E2v+hmPam6p2jif9h3PkKsnOu2Ze6RkYj/2rQ9EfoD9UTCX1S1fuiCGzxrEgWmW/etlZCZmgLwXZOzwDrCC1VZDSNc4rhHM00oum7TdaKg7Yme7OIqVN2x3qCOO2q4UGEZiGyW9SHLSwU853qt5XvaE8d0zfwrij9zEGokjAIMg19fCcYhghEOEXyMqspOcCaQwC7si/Xen/IwMXhkFsXulAGLU6yIn2s2ZH4YWjBQhpbfddn+awEaro4LRc90bxAG802ZigjL3gmerhHy9RjOkUW1y76nTL0gdGx9ozPjYh8bLhq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8wxnOwdnptZrdgiH7+QqGmhk1ut888eKBpsu2fPbl4=;
 b=XO3oUYx+H+fS2pqWGqYng4cSQhH2b9IsKUOC3oV/c9zLf7t7/TS8fT3otsEmn6g1ElmbMN2RxKwmrRWgaK3Xyr6vAPIwfShoHhBJNpamqe6LCWaNm9LEO72X+vtufo7BwbpEqlc3xoqpAKgtw67umntWpT2rSWAo/90XBUGeFdbHykwWkRKNogc0NMEUDdZxBu6oE068bLQXYUX4/tAj2G5ZAg/TCVL/z4geQ7cnkAAFYwuCgcmtunx05IqvGzhmmUfdd+MgeKageF8gICid+SoYgBUTKLo3Wjue89/5akfA22PghGAOmz2FgHe9k8xMaPR9xFiqWc2E+qaOaxkj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB5826.namprd15.prod.outlook.com (2603:10b6:806:32c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Wed, 21 Jun
 2023 03:28:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 03:28:17 +0000
Message-ID: <2dcc697a-46fe-0933-0508-90ebad9ac8f3@meta.com>
Date: Tue, 20 Jun 2023 20:28:13 -0700
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
 <6b63301f-96b2-74b9-c156-3a34fb5ad346@meta.com>
 <CAKwvOdna=1Sg4Aab=BE6F86H9ZE7kPRM=VTkqQuGiF-Jdze-cA@mail.gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CAKwvOdna=1Sg4Aab=BE6F86H9ZE7kPRM=VTkqQuGiF-Jdze-cA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SN7PR15MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a7a2c8-a22b-456d-50fc-08db72078db9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q4io8xG99DKK/bOLtSvIsL1hc5HfgTDOaj1iCRh2gHsbC25tyexEgTS7sgp5SsFLd7bU2Gnuld/Rc7XDRaOYoV0JQOdj/CZKBWVzm9R4u68CkKyUhtM630Mr+trGjKvvaf6nqnecR2NENZ1fldgUokE3no5F43UMddOsPYOZ/UUWQApWtfSuV4O2Hc9ZsLI0SGBDGhs9OPIY7UmBrbutOiRskHi6xaMw2O5ZefVFpVgFr7m1nqDvL5UMsefZWeBU+f0wn6qlHt9OmdmowfaYEv5s1BDg4z+s4N5RN8IxdeRKsibcghVT85Xo3KiIp5IuU8xGOFTA3K72aUR0U3/Oc/rAzAahNzywn/YdG0JR1SEsriDbnHI+hgco2xDHk1cFxYffSv9HV+wYNv2GTPMbN2lkT48LiLR/+urqMu9sWN+MgPCoecvzWu6FECJ5kXm6pF8rjHMrkju/pUpogxw+LZzxlEe2U9YbX/NFvLAndXeWt2rS09GBrF4yGBrDsLgeKf394F3a/AYoctxHl+xmBu7zZx1vQxAYJXavfAzz/yH5xszTBGUeieHT24bKzeuxoU5OCM5Wbjows57t4iQyG8Fl/R0kb9Dy3Xlsx0z1T1/PJSFSZp2cCYqNRJgcVAFBEmKlLisUT/H4ezc+Uv8jfQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(7416002)(478600001)(5660300002)(31686004)(66476007)(66946007)(4326008)(6916009)(66556008)(2906002)(54906003)(316002)(41300700001)(6666004)(6486002)(8936002)(8676002)(53546011)(6512007)(186003)(6506007)(2616005)(83380400001)(38100700002)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZW9xZmhQVVVDUUNsT1RVdU8wNVEvZGVuMWJMRXA3VTVieHNkb0IxelVGOWxD?=
 =?utf-8?B?RGdnZElFalJXaldTSVdmQm5UdExTODljTHpqYlo3bHdXQ3lvY2cxeThEUmJP?=
 =?utf-8?B?aWNPRXFyUUdrOTl5OHNBcloyaW5rai9MT1kxN0YzQkRQYjVpTHhkRkRBVXJT?=
 =?utf-8?B?dk8ycHZTVG1JMHIzK1cyTzJDVjNjNlNsQVNYSGtZRGMxckY0d2RrazJTWFpO?=
 =?utf-8?B?U0pPMXRsV1k0RmFOTjJPeW9ONlBrSDMwdDVYNm9OUXVHbDRQZXFYMEcrVFFP?=
 =?utf-8?B?bzNFeUNxdm5FVDVBTngwdHlyTFhoMkIvRm1HMWtOK1pORDA1L0JnbzlQS3Y5?=
 =?utf-8?B?cFoxK1FVS1h1ZU01UWV6dDNWT3MzY2lWSVZ5TWN2OElRTGFQcUxKVFVTczFk?=
 =?utf-8?B?YlV3MHhQTHNSYUJlelhlaW9UQWdEemtNaTlTQVJ3Rk9sT25BeWxJVlVQQlo1?=
 =?utf-8?B?R1d6cXdYUDZ4MXhFWS8rbHF5ZTdWTEx6K1RuNmNTRnh6ZHBQb0hzQ3pMZzBk?=
 =?utf-8?B?bWF4czM3clFtZXJ4SkVPTFJ3d0Z1Si81Tk5KcmxzTWI5N3oxSWh5OVdWazdx?=
 =?utf-8?B?OTdDSGEyWFM0NFZ3c2g0dTBidWNDcTQzMzBEcWhLRFVWMHZReHZ2Wm1laVM2?=
 =?utf-8?B?MzRuOE1YTlV1eWVMSjAwa2M2R2pCMi9lL0IvY0Y5OCtrM3JKakpWRWduVTB2?=
 =?utf-8?B?dC9FMnZicGswSkFkanFlT1pBQThrQTFtTWVnUnNMMlJ0QmJUZ0Z3RlRkUzZH?=
 =?utf-8?B?aTRacWJQSWNXZW42RUxWeHBoeld1WWp0RDY3VHRsRGdoMTdDM1ovUmpFeXQy?=
 =?utf-8?B?ZG5OOVNRdzRmZjFJSmkzRmxyU0FnbGNKZnN5OU1pa1QveUxaaThVcnh0UUxK?=
 =?utf-8?B?WW1mWEpqOVVqdjhSZWNyZVRGYVE2Mnd1VEpPWnZxeGh3T1NzSUEzSDVuZDZ1?=
 =?utf-8?B?Qk5jbHl0WTBTR2Nra2xlcFluMWNFa1poTGdzdmN6M0RJRHgvUSsvZCtReVlt?=
 =?utf-8?B?YkZibUpnWWs1QTY1aGVSQnpjdzJpSnh1bnE3MURVVnZSZEtyYy9sbC85d3h5?=
 =?utf-8?B?TGJOMCtJSnliTmMrUkhmVW9SeWJyd2xvRWdkQWl3Y3o0L2dsMERHRnp4dXlI?=
 =?utf-8?B?NTRKRlFmTXBMU1czbGxwSlFWSU1NQVNoSnVISnN1K1VJdHBRWGROMlEyZ2xI?=
 =?utf-8?B?RWd0bUtCbE9yQkwyemN5VlNFT3hVOWNkZTF0OVNnZzdIRktCaXA3Z3ZoNWtF?=
 =?utf-8?B?bkhNZkduQ2lralpyaGtQREY1c0kvbk05V0grZFBBWW9WSm5vOHRycjNwNGJo?=
 =?utf-8?B?RlB5OXl2RmpqcXhNN0RxcGtyTzMyK2V4OEFDQmluQlU5QUo3alZVNEw0cWVv?=
 =?utf-8?B?RnlpcGxwVUdPdFZlZ2FtOWNzTUpjelNIejZ2VVMvN3piaXJ2SERxU1V3eEZK?=
 =?utf-8?B?QVZHYm5RZ2I2RW1FdWd2RStkS3dwUGszOW5qQy9PMXNNYUwwSWkrK2ZiVWV2?=
 =?utf-8?B?ZXJYM2JaRHZyYVo5Ykc0dnU5TloxTHhvSDd2aUh4cUhTME1SYlQvQkdzOHhu?=
 =?utf-8?B?b1hCajB3VjVXYWRlOFpFZkh3dWVCc1J5RFZ1N3gyVENRakx6OFczc1VPOUlt?=
 =?utf-8?B?V3lYdGU3aWNUbmQ2WjFRVVgwUmxZLzkyQmdGTlhQWEpkWUlzNG1pSEw1bnJu?=
 =?utf-8?B?Q2plY01qMzA1amp1Q2MrMTNpMTNrNS9ZMWMwd3oyVjE2TE03ZEhib0l0Tk5S?=
 =?utf-8?B?Slp2MXJmWmp5bjVYWWFjeHIrN1ZpN2IvdEpVeHZOYWF6SUxjTmQ2bnRTS3dl?=
 =?utf-8?B?M0pvT2VyNTU4WTBBRGlaUXJsK1VBKytkTmx0cEpTQUZpejJyeG9QVTdZREFH?=
 =?utf-8?B?UEl3dGNGczhRYjJ5YWd5L3h0Vm0yNEY5cHV1czFPeExYU3NuTmdEdGJ3d0Nx?=
 =?utf-8?B?czJtVUNMZjk0TVNsQ1lRRk9XSjVVMWlLUDFHUEFTQm1BTUpWRjZDV1Y1QU5h?=
 =?utf-8?B?U3J5a2U0Yk8xWFFOSFYzZ0tQbmV0U1FjbGhyNzkwN21SQ2wyQkUrVDY0c0dq?=
 =?utf-8?B?MkxJNFBCK1RWN3I3SURFNllmZkcyQUhGcitod3kzRG1SMU1WYThOTlBVUERk?=
 =?utf-8?B?bHpqSDE2d1V4UEZwZ0NtNE1VS1BFMndQVExoRWxCWlpDNWFLRTI5MSsrQytH?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a7a2c8-a22b-456d-50fc-08db72078db9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 03:28:17.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWaMc6AJRnOMdZLZeTbRuv4HRwY9uedgPG57Eq+8ODQPYBN26r0DSsWXqBvzgCFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5826
X-Proofpoint-ORIG-GUID: q-oRzR_5_IkY1-r18tLV3VYSvOmSYyNW
X-Proofpoint-GUID: q-oRzR_5_IkY1-r18tLV3VYSvOmSYyNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_01,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/20/23 8:07 AM, Nick Desaulniers wrote:
> On Tue, Jun 20, 2023 at 10:53 AM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 6/20/23 7:38 AM, Nick Desaulniers wrote:
>>> 3. you did not run defconfig/menuconfig to have kconfig check for
>>> DWARFv5 support.
>>
>> Yes, I didn't run defconfig/menuconfig.
> 
> That doesn't mean the odd combo of clang+gas doesn't work.
> 
> Just like how using scripts/config is a hazard since it also doesn't
> run kconfig and allows you to set incompatible configurations. Garbage
> in; garbage out.
> 
>>
>>>
>>> The kconfigs should prevent you from selecting DWARFv5 if your
>>> toolchain combination doesn't support it; if you run kconfig.
>>>
>>>> /tmp/video-bios-59fa52.s:4: Error: file number less than one
>>>> /tmp/video-bios-59fa52.s:5: Error: junk at end of line, first
>>>> unrecognized character is `"'
>>>> /tmp/video-bios-59fa52.s:6: Error: junk at end of line, first
>>>> unrecognized character is `"'
>>>> /tmp/video-bios-59fa52.s:7: Error: junk at end of line, first
>>>> unrecognized character is `"'
>>>> /tmp/video-bios-59fa52.s:8: Error: junk at end of line, first
>>>> unrecognized character is `"'
>>>> /tmp/video-bios-59fa52.s:9: Error: junk at end of line, first
>>>> unrecognized character is `"'
>>>> /tmp/video-bios-59fa52.s:10: Error: junk at end of line, first
>>>> unrecognized character is `"'
>>>> /tmp/video-bios-59fa52.s:68: Error: junk at end of line, first
>>>> unrecognized character is `"'
>>>> clang: error: assembler command failed with exit code 1 (use -v to see
>>>> invocation)
>>>> make[4]: *** [/home/yhs/work/bpf-next/scripts/Makefile.build:252:
>>>> arch/x86/realmode/rm/video-bios.o] Error 1
>>>> make[4]: *** Waiting for unfinished jobs....
>>>> /tmp/wakemain-88777c.s: Assembler messages:
>>>> /tmp/wakemain-88777c.s:4: Error: junk at end of line, first unrecognized
>>>> character is `"'
>>>> /tmp/wakemain-88777c.s:4: Error: file number less than one
>>>> /tmp/wakemain-88777c.s:5: Error: junk at end of line, first unrecognized
>>>> character is `"'
>>>> /tmp/wakemain-88777c.s:6: Error: junk at end of line, first unrecognized
>>>> character is `"'
>>>> /tmp/wakemain-88777c.s:7: Error: junk at end of line, first unrecognized
>>>> character is `"'
>>>> /tmp/wakemain-88777c.s:8: Error: junk at end of line, first unrecognized
>>>> character is `"'
>>>> /tmp/wakemain-88777c.s:81: Error: junk at end of line, first
>>>> unrecognized character is `"'
>>>> /tmp/wakemain-88777c.s:312: Error: junk at end of line, first
>>>> unrecognized character is `"'
>>>> clang: error: assembler command failed with exit code 1 (use -v to see
>>>> invocation)
>>>>
>>>> Potentially because of my local gnu assembler 2.30-120.el8 won't work
>>>
>>> It's recorded in lib/Kconfig.debug that 2.35.2 is required for DWARFv5
>>> support if you're using GAS.  My machine has 2.40.
>>>
>>>> with some syntax generated by clang. Mixing clang compiler and arbitrary
>>>> gnu assembler are not a good idea (see the above example). It might
>>>
>>> I agree, but for older branches of stable which are still supported,
>>> we didn't quite have clang assembler support usable.  We still need to
>>> support those branches of stable.
>>
>> Thanks Florent pointing out 5.10 stable kernels which have this issue.
> 
> No, all kernels have this issue, when using `LLVM=1 LLVM_IAS=0`.  It's
> more likely that someone is using that combination for branches of
> stable that predate 4.19 (such as 4.14) but we do still try to support
> that combination somewhat, even if we recommend just using `LLVM=1`.
> Interop between toolchains is still important, even if "why would you
> do that?"

Okay, yes, although 'LLVM=1' is recommended way to compiler clang
based kernel, users can certainly do 'LLVM=1 LLVM_IAS=0' as well
although not recommended. Then it is okay to put a bug fix in
the commit message. Just need to clarify that
   - > 5.10 kernel, LLVM=1 (LLVM_IAS=0 is not the default)
     is recommended but user can still have LLVM=1 LLVM_IAS=0
     to trigger the issue
   - <= 5.10 kernel, LLVM=1 (LLVM_IAS=0 is the default) is
     recommended in which case gnu as will be used.

> 
>> I am okay with backporting to old stable kernels if that is needed.
>> But the patch going to bpf-next should not have a bug-fix tag and
>> the patch commit message can be tweaked for backport to 5.10 though.
>>
>>>
>>>> work with close-to-latest gnu assembler.
>>>>
>>>> To support function name like '<fname>.isra', some llvm work will be
>>>> needed, and it may take some time.
>>>>
>>>> So in my opinion, this patch is NOT a bug fix. It won't affect distro.
>>>> Whether we should backport to the old kernel, I am not sure whether it
>>>> is absolutely necessary as casual build can always remove LLVM_IAS=0 or
>>>> hack the kernel source itself.
>>>
>>>
>>>
> 
> 
> 

