Return-Path: <bpf+bounces-1968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFAA72501F
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 00:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAA61C20BB0
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 22:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8D28C1A;
	Tue,  6 Jun 2023 22:47:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19667E4
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 22:47:17 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702E39E;
	Tue,  6 Jun 2023 15:47:16 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356IfFbM014390;
	Tue, 6 Jun 2023 15:46:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=6PznnTs89qsjqyfHmU2y1dTJJAnt2Fmz9QnQsI+Xg/c=;
 b=U/WXx+z/djnHy296r8lDtkqDeY6yFydEI/6INDHlf1MZ1FvFCvRoSg7R28O0ycbufMAK
 fMvw8uxCrrqFOIS1r89dzMlGYzCkg7oUSClX7mgOyxscxl3r6igecYUk1yTE9R0uDBkC
 Ix0wuKMK7ndselZd0LucA+IXIWpzlrYuRY2Y7RNyJeI2jGyfLd0VfoBFmuaJsaClEKMp
 IGNH71QfnWFkBhcbRD9F5guaYc9SpHGS/GpdoX+Vbfv8/o9lfap6ruoAMTyIB/Bus3/Q
 7zZnubJVjQGN1C9C5VLLk0AV9crXQGPULFr+XJw/qsiYUBZB8PoLl0L3iYSngP4cyiTG Pg== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2a7shrf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Jun 2023 15:46:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVy6TadW1t2O5bQvrHIaMp3ULXoBDN7Zq73qW2Ml5jlkdBGClbnEHhu1QpOTbzADS4zLyzo7LRHepR7u2yhChS32xrdOxK36sFMvm23Z++u6T5OoW5YT5xuqwcx9+fkG2zcWoVQxJZQLZ6axSC5MH1r3FWr9TfFUk9OjD/C/MEc+EaywTEqLBsH83htlsmj77/2L6c5uKvzySX0UDMC09jA8Otpa1mLDGFF0ymFOHwNfRgbpKyY5IqXADihHkNookSPDFqEvvzM609r4h9x/4XdFjzw2kKgg7upiIi11noVdJfXEPmLjA1YarfHSdJ/rHMTSYCIUpOKbGgA2vMMm4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PznnTs89qsjqyfHmU2y1dTJJAnt2Fmz9QnQsI+Xg/c=;
 b=X1CiZdmITfCU4UwqB7JE7ChBIifg4r25icgnKNnOhJEm6gkbIlEoAZOjkYhwLYPxP2K7jy50QTa9NV5FOJ7yCGMAdNAEt6WnnjuWfmchWsEuNV4MAuUuVXwou1Y6LIzuExxFS3QYYJrcN1VXLdCYi0OKzxxGHjtNkOc4PSKrrzSTGQcYoNZe/44ijbfQdN/nSscuAG1wLPVH0zwFiCmcWQ9vVT1khk3JF0cgmYffoMw0fkpLLJKX4pRw76IQgCQ4jD4UmbmFRha97tHheDkn/nnnN265UtZkL4dFi1PJCCyUKAixxs8HjwXgRx4lnvgQjAy6KLC0qB0bI1HFL9j8Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5380.namprd15.prod.outlook.com (2603:10b6:8:63::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 22:46:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 22:46:53 +0000
Message-ID: <b896db61-2ee1-44c8-ebb7-930e3033df42@meta.com>
Date: Tue, 6 Jun 2023 15:46:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] [v3] bpf: hide unused bpf_patch_call_args
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230602135128.1498362-1-arnd@kernel.org>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230602135128.1498362-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0061.namprd17.prod.outlook.com
 (2603:10b6:a03:167::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB5380:EE_
X-MS-Office365-Filtering-Correlation-Id: 5989c925-a04b-42fe-88fd-08db66dfec30
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VMRBEmqqKhuGgC7/TpLVakmEMrsC0bXyv0eoyuaHz82j/5H0q2E9Z8dV7yt5GlSl74n1NLfpRPxnmq3fDR4qCuFxu+/QX6wLRWj74jVH1WH8sNw+Fo5dBTqESX26QFeSq+RoKzo6UttWaegiFsrLvULQseZhiYTs666fwR2GdULSZoQi32aZZdGNDMd7m3GGhMQ5ywKkKni3agLjRktDPTW7mgxCVMEmG2V61v3rkAPJGDz9hwZ1OApUsJwLkln04FdvS6Drjzz/NCsMXGjXrn/L+OPuKDS0oM/h5TCTG5BUXyGPvO8y/fU9aatUE3VRnkB06ZhnSRitZHL4URx2NhN3r774bbo2kS+pMrUYXbmvoSOa6mLEVMTHtlt7PNP7LvcPY0fQD6ribwGsF3LUeKCOkHQBJcdBswN5jsWxCHos5Lo9hpcUYootLDNQqwAYFSll/+EUt0OpOYgeFr8eK1wdPbWKpkzbo3CFZinEI39OOG2s17oTcd6XsZBXKFX9+/COHVPGplm5LbTMd4feriM2ZKygjomTIYeusOMFjCRtgBKuiFPxygrM2I0hGhyvzKD3IP+rLCCx19B7DYRoY4dQ/Iab2h4/M650uuBMapJIrzwEwpnKVn2hBiYlpWrzfIl46MbNYH/Wjsavz+UpWQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(54906003)(110136005)(478600001)(66556008)(8936002)(8676002)(7416002)(2906002)(36756003)(31696002)(5660300002)(86362001)(4744005)(316002)(4326008)(66476007)(66946007)(38100700002)(6506007)(2616005)(41300700001)(53546011)(6512007)(83380400001)(186003)(6486002)(31686004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGNyUE1XajIvaXBudURHQUZzYnV0cHdjc0xEeWpZZjhnbGFrUlU0dWhNQlBQ?=
 =?utf-8?B?WjBzSHh2VkdITTA3U0xNV29KWGxudm5PUXY1bzVpR2lGKzU0NzkvQkZSNE96?=
 =?utf-8?B?NnhVY0s1cWFPRjVaZkxENUlPbW1JbC9kWjNUN2JHQlNDTU9Xc0YxWHRHN0Vt?=
 =?utf-8?B?N2dXdmxBNWthd3RBMlBaUVZGVVFJUEMzTHpGekdveGE0bGZjU0Z3L0ZXcW5N?=
 =?utf-8?B?N2g3dUYxSjhpT01DTzI4ajhGNmV6cHhMM2t3YkVJNmV4b2JGaWZrNmJSRzdO?=
 =?utf-8?B?TmlZb3k2YS90OGViWGZBSk9pS2hkckx3bmMyWWlMM2hpTXZha3VncWpkbzk3?=
 =?utf-8?B?TWdjZHFGRjVjMWVaMTUzME5aYk84MUJNeUdPcmZISWhHazJqM1pqSy9Kd2pT?=
 =?utf-8?B?WXVVU3REUnBaODJpTk10bWp5UVg0OEFFbmI5OVZ6Tk44V09IU3Z3bVNDU1FS?=
 =?utf-8?B?WVdpa2FITlBJeUNoVVYraXpFNjVzd0RkK3lCL0FoRVdrSlJ2bnRGSkhLeTA1?=
 =?utf-8?B?clVZbUljUFplSTdTaWFiWlVuWlFiWFlPNFZMWkFaUU5mY01Ba29vOGRmWE5P?=
 =?utf-8?B?THljdHlpQWw4OXVhdUVRa25NMDhSQnVuNHMrRkV3ZG9qWmc2K1h4c3dzUGlm?=
 =?utf-8?B?Yml2QmtCTzBweG1rY3B0SUJrWnc1UG9odXRwOGYva0ZiYi9Icmk0TGdqd0E1?=
 =?utf-8?B?R0wvczJLak5QSXRqRERjUlJuVGJDTi92eUN3a3A5TzhGTzZkbUQ4ZDJ4L2FH?=
 =?utf-8?B?WlBncDhJZ3lSK3M5OEY2clFjZStKNHQ3VmI1aG0rSEZKVDhsOEphdU03Wklh?=
 =?utf-8?B?V1BQMEs5b2IrbkxCYmJUcG9rOGFZQkI5MXd2VXgwWFZwQ2E1cGRobG1yRUxk?=
 =?utf-8?B?VnZzWmVqZ3RHdStvUk5mMlZydmNjVDVBcms2ais4Y1FXcDdJTVlHZk4ySzR4?=
 =?utf-8?B?akdjd3lSV2huYlY1Y1JPT3YzUEFvV0RqZXJPWE5SSjY1M050Yi9wT1VFWWhq?=
 =?utf-8?B?NHJBTnk3OXI3bXNxejE5WWRmWHlDYkpIYldVd205a3dmaFBYNlVPWTBidmp0?=
 =?utf-8?B?bTVYVHR5ZGd6WWY2dUdNTFdSWnozZHAybmo1MHIzUWg0TEdqNkQ1QW9tSnhX?=
 =?utf-8?B?RjBhbFdhY0hWZEFESUdveVNPbitNeVRJbUhNMWI5alFJbjhqZjRRMEYwRlk5?=
 =?utf-8?B?N2xYV2k1eGJlbXR0TytlWWNkUkdpbVllcFlJdzlXYWJjMDg5QkhNbmlqK1By?=
 =?utf-8?B?SnA4Nms4azdDUnIxZmhjQUNISzFJS0RSWkk0TE9Ba2Q0TlV1cWkrdy9odEl6?=
 =?utf-8?B?WlZydzJuNm5aQkZiSm5ITUhYRng4WXd4My9yQjF2aElMdk1uczMxdC9YT2FH?=
 =?utf-8?B?TjlZNGZEVVJZYTAraTl4bjRaUmN6ZHZwVUNvNGhBUWZFOVAxa0xRaThQaDJq?=
 =?utf-8?B?T2FnNWwwRzFrWEloM2tJVDFqeXJSZUJSakRzVDl0dVpQMDNJQ2E0RlJsZzJk?=
 =?utf-8?B?OWppN0VpbnoxeHkrVEx3eXJpMkpLN1RlUXJzTWdLWThIVW9XMm5qMUdPbU9X?=
 =?utf-8?B?MUJYaThJb3NCeUQzUlpZbXZPWkV4ZTVOclA3aTRJK09DZGRleis2dmVwak5I?=
 =?utf-8?B?b293TVR5M0dPQlZ0Nkk0RGNRYjJxcisyU3luNlNtck5qRlBvam1jVzJNUm5V?=
 =?utf-8?B?OTQwcERLMGV4c3JOVUMyT3RxNnl3UHNML1pDT0hwZzRYRnk3bUxOUW51Rkl4?=
 =?utf-8?B?QlVyYXFpR3BIb3VqK0s0YmRDOHBjNjVEdTBHVTFJN0dXMXhyczdDYjNPMDZI?=
 =?utf-8?B?b0VzOVJDRnRDRGEyL2dvZ2p2bUtCQWF5Nk1yY1NONDNSV2ZZRGYrYmR4SzNU?=
 =?utf-8?B?VEw5a0lmZ2ZpUlpwbXNtZFdTRE15cUlhTTVSR0p0ektZMnFYU01pNHlmaXR0?=
 =?utf-8?B?UHFKdVh0NmpkMnJ2WjBsbTM2Um1nakV1d0Yzbm1HbXBZTDRKanhucHRqK01V?=
 =?utf-8?B?UHBBTU1NaGU4VnJYRlRWTGZaUEhLMGQxYVZwY1lPTTE3RGZDUWpwZW01NlUr?=
 =?utf-8?B?aUFFUDRQV3hSTS9LVUtTaklRUHVaY0pPSUgvaGlMazdqd1V6YmdkT0RlTWVZ?=
 =?utf-8?B?Mld3WVQ4UDlEWFgzeE1FRkRubTY1Y1FFSG55MjVaK0x2Z2wzQU9hUXRVV092?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5989c925-a04b-42fe-88fd-08db66dfec30
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 22:46:53.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEoMxVetOE1XHANL8+JcYRT/gXXDzHoznoj90hMN3XWUl85ojSF/ZGv2B5L02FOi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5380
X-Proofpoint-ORIG-GUID: QW6NU6R7Lo-NeObI6ZLk-ebOrAhoA17W
X-Proofpoint-GUID: QW6NU6R7Lo-NeObI6ZLk-ebOrAhoA17W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_16,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/2/23 6:50 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function is only used when CONFIG_BPF_JIT_ALWAYS_ON is disabled,
> but CONFIG_BPF_SYSCALL is enabled. When both are turned off, the
> prototype is missing but the unused function is still compiled,
> as seen from this W=1 warning:
> 
> kernel/bpf/core.c:2075:6: error: no previous prototype for 'bpf_patch_call_args' [-Werror=missing-prototypes]
> 
> Add a matching #ifdef for the definition to leave it out.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Yonghong Song <yhs@fb.com>

