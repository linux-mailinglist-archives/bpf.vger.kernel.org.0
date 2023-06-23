Return-Path: <bpf+bounces-3279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62C73BB08
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EDD71C212E0
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FE8AD49;
	Fri, 23 Jun 2023 15:06:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BD68BF5
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 15:06:33 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900D31BCC;
	Fri, 23 Jun 2023 08:06:31 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35NDwFF1026576;
	Fri, 23 Jun 2023 08:06:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=3YGtophNbgw2B1jc8Clszl3vTRio9ERAfYfPxf3Q1kU=;
 b=Ly1XJ2AgIhJj/LNKt2SwEXCzv+OU/MHoXpeuY9H/D8tNzxDEZ3i8dLZcQIDeS15g64pz
 O80Tv2ByxJtRy7xX2n4vXw4Srgkft4VBLuBlI9rHMqPcc830BfT0WFGWV952ihPDoZch
 +atSw/lFHHO5Sl3spj2sSczKt8ZbyCY8/Gicyp/vq0Kzxjk+0QbZNO3LMgRMmn5B+Rwz
 EUaOQKRcJ+pIbiU/xcQCdIjdz0l+cVOPZiXZj/AoeoNw9ij4aaGXDDpDNjdl8KmuNF78
 mK0NLgUMD1f5y6ydJU0SkCwQuBmsTlprS8qqGgT9uVo5epABDPGNOhn/a+oAI6PhUx7H iQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rcxs5feum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jun 2023 08:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjdrmEq9kTgWlCB2fgtiRLSMWsdYY4ogM19HEP33z9M8N94LN//24M4x4S747M+Z984mBd2tWU867i7qRzTcjq2qyrDdte/YKzpuQRQdy4mFVIbZwJ6Zdg12I+Bqqkk9kTwstGfc9fuG+byrR+T7skvpw/uQ98TwcOagYY4CMdiO2zcVruDyDv918P1CtHFzlM/0rtQvCr5uQSgdB8z7CvIMyXmUSk9A9YRk5UQonuaI7xeA/k+37wLIma404RsABa2bvK2poFKSYmsbt4/gDYJGdk7rh06ipNPSTY3kXFtLxve9rmECBuU/JafGDgqrtfk3KE4tFHe8R7Agv8jICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YGtophNbgw2B1jc8Clszl3vTRio9ERAfYfPxf3Q1kU=;
 b=C+BTRLV74AUheGhL8ZiQ+RNPCHR6JlcdxBokjeNcJ+QUxbbUYvftWhejTIV085LJioWu14j9DLN3CERzS7/NWhX8i0UmWyl3aAQ64A5V+xmyLbZsM0b0BB/PCN9gWLzxYSlpHfHnKWv1O/Zld0r8f8Ime+FKd55BQMpRSN0BJSPxQCfx8g/LnDosFxaTzU+73RY3ZN17Wercf1a8osF6TWXizg3oLh3cDEIK22xioYpC5rty+MauxErqXMaMD2kicQfHdH1ZbvsBCR4p79PmrQVNOYoEoSUE2I0yZkRSRnJCXqESGS0BUOyqYvViLAIDIc+rl29n+iwVrsL55bWcrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH3PR15MB6325.namprd15.prod.outlook.com (2603:10b6:610:161::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 15:06:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 15:06:08 +0000
Message-ID: <d4a15fa1-60cc-bb8a-f84d-9d0a1380ab88@meta.com>
Date: Fri, 23 Jun 2023 08:06:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] bpf: Replace deprecated -target with --target= for Clang
Content-Language: en-US
To: Fangrui Song <maskray@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230623020908.1410959-1-maskray@google.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230623020908.1410959-1-maskray@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:217::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CH3PR15MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: f6929013-2704-475b-0c6a-08db73fb6001
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/oJA8JKGkh9Ndn3DdjQJKWu8dB5B8QxuGBu48BG7GpVaLWXePJW9LJdmHXNGx51qpZ9i01i2aQ6imrr6aJP7xxIJkfS9D5JfkpFBFtUlij8Sb/xSdWm50kgpJOIUVhyp+78PSTXtFwiKeXiHj+oLysjmejnTVMQ46Mt+U67swHqcWV4mhqIX+uC9yLe91Eq5nyboHehTehXcTL9t+PaGqxfYzXWjctHCTyycDPFE1Cbr/j4vK7tl5urgE289moU6IXSodkC+7kvwbaYJy+mOEpD5orOkxMnt1cEfyqm4UtC01zsAePvzMLo/tSMjz4ZG9JKPEz8Wf0CgH5Pd2Yubu5qkYcnmcwWexfX0BWqQE/Pwo3GgRD7esEIywT3ukf+MIlEPRDAGlx6imX+CWwvpN3za0W5IxOwS5mqlEpf9iYWpxoWvi/FvMO2Fufgv8+RUlvJiPT5tPp/bcnF7YV2PWO8FgRvP81Sz+JoLYJdhgV75IyEoIkJ5pc8wpZ8xji4h4NepG/GkY5xb7RvExOWCkOf9kmW0IlfGIV7oQ44byc8Z3rT3bge9ZHbsAGtQdPDyP+z3A0jWicu4S/sQXNMu4fhPwh9aBMKjnABuX1pl+WJCrcwsF4/ti8gYO992wtld5ZUxy8c65BnMNFk6svfioQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(31686004)(66946007)(4326008)(66556008)(66476007)(478600001)(316002)(36756003)(8936002)(8676002)(5660300002)(2906002)(110136005)(86362001)(31696002)(41300700001)(6486002)(38100700002)(53546011)(6512007)(6506007)(186003)(6666004)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjRtYXovby9IOVZKd01odGQ0c2RNT1hKU3I5TnZaMkozT3RmQy9URVJrbEsr?=
 =?utf-8?B?TktlZGRSNHZGeDZNWHRPSHhCN0JDYytlbThNZFpmcFpTbnZ4WjZ6QVVpVFVC?=
 =?utf-8?B?V0VseFl4Q0J5YkFCSmhqQ0x3MW9IVnErVU5LZHgrZ2hQcjZHdDNZdjdKczRX?=
 =?utf-8?B?YUZKTmNNeU5naVRZMm54WlBUTGxtQ1pJWmtHNFBUYXhNWFdPcEx4ajJicUc5?=
 =?utf-8?B?Kzc5bjl3bElYOU94OUwwY3p5WkFoYzY2VWFCL3BvdHhBZHkya2tyTmZ1eUlE?=
 =?utf-8?B?ZURJZWNBc2x1U2l4NzA1aVZXMitySjl4Ukh2SitEYzJBVU9MQXAxd3lIZCtS?=
 =?utf-8?B?eWxvNnVMdlgwWERYTm10R2ZURXJ4bzJYZ1pVTEY3RUszSnlGMnBBN0ljdng1?=
 =?utf-8?B?NDhZdk00Y1FWREROVXJnU3hjT0lHVXM3ZEJoeHNyQWFZb2R2Rnh4QjA1dnEv?=
 =?utf-8?B?MzlkWHViZFlvUWUwaU80eWh5T052MDRWVG94ZWZVWXo4TWQzdy9zdWdFaTZ5?=
 =?utf-8?B?b3k4ek5QQUNyOERQUnlieXBrRlBGZnhxczJ2NVR1OS9QLzNyRUJnUFNzZWls?=
 =?utf-8?B?UTVvd3FCNzcwdnJ3WUR2aERJY0EwQTdqVktRR1JZYXVIV0lDdE9rZERXMFZB?=
 =?utf-8?B?VXFVVEc3SGgwbENpZzNmWGlxTVdFSWY2UmdtR0dSZXpZVFdENTBjWHB0c3Zz?=
 =?utf-8?B?VXhtSGZxdWlhU2VESkJ1UThKNHJHYkJXYW04ajF3akozS1V5d0tLcjJqMjFw?=
 =?utf-8?B?bk44MGZtUE95V1pOOXhVQ25iUkJuRlErL0Q4b0c4dlJWN1g3SmI2MWpzZCtL?=
 =?utf-8?B?b0V2ZXdSemd3TW54Y1ZjdFgzbGdqb0J0clRTSUlNLytlNHBZRm9hR0FJem84?=
 =?utf-8?B?bkNZTXpieGdtcTg2Rm14ckxMSFRXaGVxSU54WUxMbEcwNHNGaHd1MkhoSlRQ?=
 =?utf-8?B?ZzQ5OS9BL3AvZHpmRGYwbjAxQmJFeHM2ZDhheTBmY0FFOUREd2t4UXEzUU5r?=
 =?utf-8?B?NUN3bmNWQjU1eXo2cStQaFNGV1JaaG9JT1hJZ0R0cWFpN0hHamtwZk5uOUhD?=
 =?utf-8?B?TUFMZWtFd0p5QVF4Qis3dHVUc05UTGh3TjFRS3lnbWtlNFpMLzVDYWdiQ0VG?=
 =?utf-8?B?YVRtSkpvQ0N0akNXVEl4aGx0ZFpBc3kyaDlYd2xtTWc3T3NXVnBJZjVVZWRN?=
 =?utf-8?B?b2RlWHJDMkdSNGJlY0taWlZmcmdMYWtEelpTRlNYVVBYSGRHeEVLVkFZdDdB?=
 =?utf-8?B?dlRUY0x4bGppd3pidVUrUFUwNjFyY2ExckdXODRYVUh6WXFmRC9wS0JrVHZS?=
 =?utf-8?B?LzRpR25kN2kzdDljaUwrd0R3U1VzT2hxeWZ4VitCTzJqRFVsRW4yL1R5RGMz?=
 =?utf-8?B?cS9EZTJGOHRUM2lSWkNCK3EzKzBYa2dXKzJwb1BpYnhXTDJIS3BPUUpsbVhx?=
 =?utf-8?B?V0RpVEJNUGJLRlZNc2Zwcko0eVpyRkxlZC92QWdwZlN1T3Rjbk1FUjZBdXB0?=
 =?utf-8?B?STY0Ri9TOFpsR0Y1dERhL3gxaGROSWdmRVJJYk9ZaEpuOFVjV3RoSVlaaW12?=
 =?utf-8?B?N2YwTVhEQzd4THJoVWlucE02cVJrZkc1a3NBMHVaTXV2KzFYaGIzOFVCQ0p3?=
 =?utf-8?B?cHBWZm1yc3I3QXVCcUpxbTJyMlFlWHZPc25HQUpsM2ZlazJDSXlNMm5hZ3FJ?=
 =?utf-8?B?T1BvYWUxaW93dy8zSm83YkNRZHpaRElnaHZYb3p4aFlYSFluWGx6TUg4K052?=
 =?utf-8?B?VkR0b2VxRmNTelVCNmNIdVdaRXVETTY5dnZ2N0R5OEZoaXlPNWlsU0hTdlRT?=
 =?utf-8?B?Rm5kdTVhL3RnRDZodXBXZi92OGpqTDVycVphb3V2Y1NmY05FYjVVL1dJQWFI?=
 =?utf-8?B?YXZPTlRsRG9qNkNSY01PREhqZGQwSDhmUGpSWWNReHg0S25EWEkzekxyekRq?=
 =?utf-8?B?R2RhbzBzZ2NPcjQ1ODBzT3FaNS9keHRmd09kbVhNVWNXcFcyaS9OSVdOdUpS?=
 =?utf-8?B?V3pmUUptN25naURpRzRRV0lYOHA1cWovYStlWlJJUVVXV0dKR3J3bElQSEdL?=
 =?utf-8?B?WUl1Yk5UaTZPc0lKWCtjWDdkYWdpbWJncVNpK0ptU09jVDg5ZmFnc1RQZlBB?=
 =?utf-8?B?VlgrVjRyQXNNNkpyN3pIblpUcWZNOEEzYWhCdUR5UzZNYmFkS0k1Tm85UTJO?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6929013-2704-475b-0c6a-08db73fb6001
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 15:06:08.8813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AW1IpxoiJrnTEpe4HjfGEiqnkplYaCpPr3TuKE00dhGpsmTOAyuhEPcT7ZwF7TKD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6325
X-Proofpoint-ORIG-GUID: dnDDFWzaiiY43G8TLNmQcflZeYh3VCGX
X-Proofpoint-GUID: dnDDFWzaiiY43G8TLNmQcflZeYh3VCGX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_08,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/22/23 7:09 PM, Fangrui Song wrote:
> -target has been deprecated since Clang 3.4 in 2013. Use the preferred
> --target=bpf form instead. This matches how we use --target= in
> scripts/Makefile.clang.
> 
> Signed-off-by: Fangrui Song <maskray@google.com>

LGTM with a few nits below. As Daniel mentioned earlier. It would be
to separate tools/perf changes to a separate patch to perf subsystem.
Please also cc
    bpf@vger.kernel.org

Acked-by: Yonghong Song <yhs@fb.com>


> ---
>   Documentation/bpf/bpf_devel_QA.rst              | 10 +++++-----
>   Documentation/bpf/btf.rst                       |  4 ++--
>   Documentation/bpf/llvm_reloc.rst                |  6 +++---
>   drivers/hid/bpf/entrypoints/Makefile            |  2 +-
>   kernel/bpf/preload/iterators/Makefile           |  2 +-
>   samples/bpf/Makefile                            |  6 +++---
>   samples/bpf/gnu/stubs.h                         |  3 ++-
>   samples/bpf/test_lwt_bpf.sh                     |  2 +-
>   samples/hid/Makefile                            |  6 +++---
>   tools/bpf/bpftool/Documentation/bpftool-gen.rst |  4 ++--
>   tools/bpf/bpftool/Makefile                      |  2 +-
>   tools/bpf/runqslower/Makefile                   |  2 +-
>   tools/build/feature/Makefile                    |  2 +-
>   tools/perf/Documentation/perf-config.txt        |  2 +-
>   tools/perf/Makefile.perf                        |  4 ++--
>   tools/perf/util/llvm-utils.c                    |  4 ++--
>   tools/testing/selftests/bpf/Makefile            |  6 +++---
>   tools/testing/selftests/bpf/gnu/stubs.h         |  3 ++-
>   tools/testing/selftests/hid/Makefile            |  6 +++---
>   tools/testing/selftests/net/Makefile            |  4 ++--
>   tools/testing/selftests/tc-testing/Makefile     |  2 +-
>   21 files changed, 42 insertions(+), 40 deletions(-)
> 
[...]
> diff --git a/samples/bpf/gnu/stubs.h b/samples/bpf/gnu/stubs.h
> index 719225b16626..cc37155fbfa5 100644
> --- a/samples/bpf/gnu/stubs.h
> +++ b/samples/bpf/gnu/stubs.h
> @@ -1 +1,2 @@
> -/* dummy .h to trick /usr/include/features.h to work with 'clang -target bpf' */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* dummy .h to trick /usr/include/features.h to work with 'clang --target=bpf' */

Quentin and Daniel already mentioned this one. The SPDX license
change can be removed. This is irrelavent to the theme of this patch.


[...]
> diff --git a/tools/testing/selftests/bpf/gnu/stubs.h b/tools/testing/selftests/bpf/gnu/stubs.h
> index 719225b16626..cc37155fbfa5 100644
> --- a/tools/testing/selftests/bpf/gnu/stubs.h
> +++ b/tools/testing/selftests/bpf/gnu/stubs.h
> @@ -1 +1,2 @@
> -/* dummy .h to trick /usr/include/features.h to work with 'clang -target bpf' */
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* dummy .h to trick /usr/include/features.h to work with 'clang --target=bpf' */

Here is another place that the SPDX license is not needed.

> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 01c0491d64da..2e986cbf1a46 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -167,7 +167,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids	\
>   		OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
>   
>   # Get Clang's default includes on this system, as opposed to those seen by
> -# '-target bpf'. This fixes "missing" files on some architectures/distros,
> +# '--target=bpf'. This fixes "missing" files on some architectures/distros,
[...]

