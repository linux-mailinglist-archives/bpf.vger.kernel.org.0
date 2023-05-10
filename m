Return-Path: <bpf+bounces-290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215EE6FDF4C
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA3D1C20DA6
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9178414A84;
	Wed, 10 May 2023 13:55:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083F12B8C
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 13:55:43 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82565FE9
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:55:08 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34A8Dmhi013811;
	Wed, 10 May 2023 06:54:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=kEQAN0rVBcG03I5aJZs/QR0EIzWUAxB1Hoa5S/EYVrs=;
 b=FEcMJ56N6nI6PEpQPtiz/RXhTeULREGuT1cbW9O43+P/wNFtdtY6ib/m04eMNQzpaXtd
 /WW+oPGUo1d/W1WrnmyWjOZbrVAJSq/fa13h1nLn+4PLciTJrFT8Jw0u8M24Jwc2g/ex
 ZIYq7Xw4ZpRFzc58kSLNJVTz7gr6Zvct2Fr66SKFNgt+EA37JxBVPns91SoSOwjdazta
 LClKBBnbnAGgx3KL3r34AFyxKikdvx/w1mPdmIFOwqgAAZm8YfWahss7tNJzJFjR/7pl
 Zstoav9Pb3IMVFW6LnmwqGZlw3QlQAqUVKW8h4YhidxP/Hs9Z6HdmkTGDHrhah15hxBt 5Q== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qfvurdneq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 May 2023 06:54:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihgj7xr3kOgzdM+rw62jCu+X7HVCKP+vXB/e5l/xJCJCNqdx3CMPSAM+xmLrJjeEzgdR/uV/wWN23Ejk8r2/U5FzcwIcK4v8jT+1qwwT9+NFznLqVnzXb9QbD5foLxTzBeCYtbIs0R4mYh1V+LQ6XLw6aFKWJPjC707/YEVbk1i1mzBZoci+4fzgELKWeuwy6H7cExMxCuQYEQQRKD1n9m2JbIsWEVyI0eUhOtpE7sfgu16/z/v5w0wNPpGp4R+gfK4LVWWTREuaoq0kZhij4ACQJYOfMfsOe76opXSr7orRf+Ei27fDl//PFXLsbPBvSeFqsQDF0AtLazcDMXA73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEQAN0rVBcG03I5aJZs/QR0EIzWUAxB1Hoa5S/EYVrs=;
 b=bX0UOx7sF0sa0Zrx/uS3mi7xmrgkNu+pm6QrX9tiRX7SE/HH8w6OcZn65KgJc9hIF0E6e6qi9ReWJ8YS/zqLnusYsxiOhtJUvLTwiyQLZYYFeYJ9f/4Giw3ujqU/ZeEbdsaimQn6RR6vjUWtRA4EOM3bAu6aHE3/yfEXtbhli+/qyIdHSn0Mi1GEjpnaudoODWDeyZECJULXO7VSpFjtSoNH5qGdKyNdMXeP0AOFu55Rszili64t5VlUv0iZ2rj5Wh5eUlX/YwkrSBj2CcljunT5eljmdx9TpHHer0f1RJ+hQwOxrQtx6lPvL+h2t2cT/VBU7rPQZGPqeKeT7XQFVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4722.namprd15.prod.outlook.com (2603:10b6:806:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 13:54:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 13:54:25 +0000
Message-ID: <82d8aeb9-73e3-676c-5e18-34e19f8c17d6@meta.com>
Date: Wed, 10 May 2023 06:54:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: pahole issue. Re: [PATCH bpf-next 2/2] fork: Rename mm_init to
 task_mm_init
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20230424161104.3737-1-laoar.shao@gmail.com>
 <20230424161104.3737-3-laoar.shao@gmail.com>
 <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
 <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com>
 <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com>
 <CALOAHbAnGLYV9H2t=4rHxdmXwUhXbsUEvK5-MLPq38JkUR8jGw@mail.gmail.com>
 <CAADnVQKuaKwfwPvt3ffi3Gkzsq=9Oj=tnb6Ya1O0EX5uApQg7w@mail.gmail.com>
 <CALOAHbDdm-wLJ+eWzWza3wED4LuwxnE9bf2ssGhNgZjgkE82jw@mail.gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CALOAHbDdm-wLJ+eWzWza3wED4LuwxnE9bf2ssGhNgZjgkE82jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4722:EE_
X-MS-Office365-Filtering-Correlation-Id: 65312563-d81e-481d-1dd9-08db515e10f3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bfj2ifmRh9ckUyKffHP0kbnzGpuTrHB2b5MbhsOpzbV/UXTyZznifIYkj6zlcHKs0t0rCRrsHmF1DVt42ms4gFKnrGboCxv789EzAwqBVfcw/7KVspxhleyvnP9IVC03e37XJ9P9Zzaep5aTm51UTSppgHGZp0rsdVjQuY8MuBcGk/HbJwv1+YqsdVs4YnmbfZeLXinOIHIkH/5W0L/nVVQTlFKj/zDhUzduPlzLITM6+UonieEH1ws39lSWcoFNFlS0AmhRCfYKG6Gb/i0TShJ0MCEWpNY3k3ICs6NpEqdKgCpmASECSXV5bITFW2BnQhTYsw6wfXvcG3gfPjiN4vuBl8iTdGUx98Pf11t9UOFNcov+4b8z8iuODqxdTElQ6KL+JxmpPYHI0VcrLRNSmFL1pvjh6FsJRNX1CfOlMEWzRFdiM3+s6Z2M2tUDrvNTGd57TPcanr/7cOQZTTYPGO7ujIvnA6601Izgk41xbqRjriLILlyxacSuG4GZdmspBA+P0yFqQ4Ko1cag4BdJFVHa1PuWaDN1c5G3BeQbp/+ZFnwcwM8V5ko+GSFabzUhyYcHmZnFko846mtouuduPFhMJx9uyblu6+kJbv6NZdFowC/o4DhLcERW+opeyyhSBsOl/xFUYr+3pnTizDNHrA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(451199021)(54906003)(110136005)(31686004)(478600001)(86362001)(66476007)(66556008)(6666004)(66946007)(316002)(41300700001)(5660300002)(36756003)(8936002)(6486002)(4326008)(8676002)(38100700002)(7416002)(31696002)(53546011)(6506007)(6512007)(186003)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VklNVlNwQkFIQ2dqRXpLNzEzMFZKSTRoY0pobkZITjVKVjh3NVowZ293RFRO?=
 =?utf-8?B?TWhzQjNYWlVxYmdzdWtwbUszdjd1QzZzV0JjUnA0cWZIckF3ZFVWU2wvdWZx?=
 =?utf-8?B?R3N4WGxIMUMwNENTaU1lanovRnhrTU9Va3BqQzVpZVo3dnRod2NaRTV4VFZC?=
 =?utf-8?B?NTNsd1cvMUM0WWJJQmxjeWd0aEZzQzhveWYycGR3cldnZFBuU0lEdUljSHcw?=
 =?utf-8?B?UFhjUDllZlhZRWN3eVJIN0ZUbTV5SXYwa1pyeXUzOWM0Q3ZtdlhpSDVaWW9S?=
 =?utf-8?B?MWU1L29wWkxuMFhCdm9ENmg4c1VlQmEvM2d3cEVrZjZKRXJUZmNXVlN3MEF6?=
 =?utf-8?B?Y0tkUHVCeGJlTUlaN1VldlJJZWhTbHkya2ZNSVhZQ0t0YnFUUFZ5ZVFSZnV6?=
 =?utf-8?B?bEJBOWltcVM4aFI4K3dXbG5lZ0FBaGloMGQ1NUx4bkg1TkJxeGpHRzA4K3p1?=
 =?utf-8?B?M3l0VmNsRnMxdkFpYUVkenFmV0EvQ0pBdWVwejNkbWV6R2JRbHN0V0NmMXp5?=
 =?utf-8?B?L2lRbThSUmVvV2xKQ1E5RGZZSXN3bkVFcnRiYTlyMG9rRDhscDZZSnhUbFE2?=
 =?utf-8?B?VVFMQzhZamF2cEtCMW1tOWwrd2R5SEx6OVl4M1RRdGIwQzlWcUxXN0NpSVBV?=
 =?utf-8?B?N3c4Tzlsb29CM0ZiSGh1aHMwQjJuQlhubERmdXlZRnlmNWJlbjVFMzRXeDZY?=
 =?utf-8?B?NS9RaTZscmZQelpOaGR1czdhU05leTllQ0ZXMjBNa2ZLM0pUSjM5MzYyZDZM?=
 =?utf-8?B?L3B0cUlEcThsN3laZlcxZ3RQcUdvMkRDVEo2RktRQTltSm1lWXRIVlB0bHhC?=
 =?utf-8?B?amVlZE5vbkR4NXFuVE54Rm1Cakl2eVNRdEcwQ0NHc2FJaGg2Y3B6Wm41TW1v?=
 =?utf-8?B?RU5DT2RicFJMK0M3a2loRjJvV2draU85VmVacUUyMWc5QzdhZmttK3ltTE44?=
 =?utf-8?B?ZWFZOEJpajRoNWphOXRWb1d4ZmdsQ0RJSEprWVhLdVplUjlQZzBhTzk4ZzBj?=
 =?utf-8?B?UnhlTHNkVE9NNkd2TVpiMjJRaUpUMzB6RGd6MURLck9XSXhURUZQenNYVHdC?=
 =?utf-8?B?eFR3VFRkbDlmVUZDQ1hLQktNU2E2bm9RUmM1UnNrbnR2UmlTeVVva3NPTFRp?=
 =?utf-8?B?ZW1UUjM0Q0t4THlIZFFqREQyQW4weWtMd0VuaGRHQktjRXNsWHV6b25XT3I1?=
 =?utf-8?B?R056MjYyRnA2ZGZJTFhQemRlS2ppSDFUSVE1YVR6MnlDK2taTWIzOGJZczBi?=
 =?utf-8?B?SnVGc2ZHTjFkQWZtYlBwc2Qxekg2SERqdzhVMSs5NkYvS1B5eTJreUg3bXFQ?=
 =?utf-8?B?L2hiUUp6MGdVZHhzSkhwVjZsTDFHK1ZJazJiU2JXN2xoand1OHdzcWZ0Q2pV?=
 =?utf-8?B?UlBhNWliMXlJbGJCWmxDdUZBVHgzSXg1d2d1dy8vUmxHNGNxYVFTSXZUN2pJ?=
 =?utf-8?B?MzVQUmlXUldrSi9EODk5MTE4alluR1kvdFlqNTk5MXVIbmVuV1B5L1hjdmE5?=
 =?utf-8?B?Z2dvQW84dHB5S0dDQnBtS1dXVlFLazJzVHBHQUxCeVRTWG1RNmMzbGNVNDNP?=
 =?utf-8?B?NEo2Sk5aaW0zYklSRTBMTCtDN0diQTVEczFCU0c1OGJ0MUxZQzRkYmZwOGFn?=
 =?utf-8?B?MmdZM2dEWWE4M1dHMmhqd3JjR1doM0N1M2xqUVZQeWZIbmF3TjVNY2JacUht?=
 =?utf-8?B?QXl2K0RWbHdGRXBONm00MFdBSENOQVRjR0dOR0RUZWh5c3FQZjAydTRKY3hE?=
 =?utf-8?B?cUE3azdhOWZZS1RDcy8vVnJNdVUxbE1TSTE2cENvbS9IZ0JVMVlQcHg2V2Jp?=
 =?utf-8?B?QU1KZFlCSFZlNEMvVTFoSHVDZ2lWSjVWTkRSR0hJdXI2RTBVMUgvQ2hLVVM0?=
 =?utf-8?B?TjFMTEZjZGhOV1Y0OFQrUHF0Snl4U05mckQrTFR1MW5Uc0cvbWZta1d4bnRL?=
 =?utf-8?B?SWFmaHErRlM0NUYrV1UyamVNWVBwYlgvcDRGQ2t6OVVyd0FUN3U4bHV2UTVE?=
 =?utf-8?B?a1hSWk05RkhvbEg0U2dJNlAxaE16c1NsWG1PdHI5ZUtRVENFYlUxV245Q3R3?=
 =?utf-8?B?M0k2aEtZdnN4ZUE1bkY0L0FZNHh4WEZHYWdyM0hUWFluVjBHYnM2SERhTmZR?=
 =?utf-8?B?N1E4VjdSZi93Rmc5QjNQTnE3WXEwcEJtTHIzWEE5SzFDakVybkpEVEIrS0ky?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65312563-d81e-481d-1dd9-08db515e10f3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:54:25.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezotEvy1AnugVXl8ErKK2Ik/7U5A+8FqKDlXCRL897mNTWAuo0UgAIk41Nh4C+/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4722
X-Proofpoint-ORIG-GUID: --uagRDVFEqJXTzrTAQUY6AgvPW_XuOi
X-Proofpoint-GUID: --uagRDVFEqJXTzrTAQUY6AgvPW_XuOi
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/9/23 10:38 PM, Yafang Shao wrote:
> On Wed, May 10, 2023 at 1:18 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, May 9, 2023 at 8:36 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>
>>> On Tue, May 2, 2023 at 11:40 AM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> Alan,
>>>>
>>>> wdyt on below?
>>>>
>>>
>>> Hi Alexei,
>>>
>>> Per my understanding, not only does pahole have issues, but also there
>>> are issues in the kernel.
>>> This panic is caused by the inconsistency between BTF and kallsyms as such:
>>>     bpf_check_attach_target
>>>         tname = btf_name_by_offset(btf, t->name_off); // btf
>>>         addr = kallsyms_lookup_name(tname); // kallsyms
>>>
>>> So if the function displayed in /proc/sys/btf/vmlinux is not the same
>>> with the function displayed in /proc/kallsyms, we will get a wrong
>>> addr.  I think it is not proper to rely wholly on the userspace tools
>>> to make them the same. The kernel should also imrpve the verifier to
>>> make sure they are really the same function.  WDYT?
>>
>> Are you saying it's not proper to rely on compilers
>> and linkers to build the kernel?
>> pahole, resolved_btfid, kallsym gen, objtool are part of the
>> compilation process.
>> The bugs in them are discovered from time to time and
>> have to be fixed. Just like compiler and linker bugs.
> 
> I was wondering if it is possible to add BTF_ID into kallsyms or to
> add function address into BTF. Because the function name is not
> unique, while the function ID is unique. So with the function ID we
> can always get what we want.

We just had some discussions during LSFMMBPF led by Jiri
about how to resolve such issues. Yes, adding 'addr' to BTF
is one solution. Also, if this patch set 
(https://lore.kernel.org/lkml/20221205163157.269335-1-nick.alcock@oracle.com/) 
can make it
into the kernel, adding 'file_path' to the BTF should also work.
So ya, two possible solutions here.

> 
> For example,
> 
> $ cat /proc/kallsyms | awk '{if ($2=="t"||$2=="T") {print $3}}' |
> sort|   uniq -c | sort -n -r | less
>       56 __pfx_cleanup_module
>       56 cleanup_module
>       47 __pfx_cpumask_weight.constprop.0
>       47 cpumask_weight.constprop.0
>       21 __pfx_jhash
>       21 __pfx_cpumask_weight
>       21 jhash
>       21 cpumask_weight
>       17 type_show
>       17 __pfx_type_show
>       14 __rhashtable_insert_fast.constprop.0
>       14 __pfx___rhashtable_insert_fast.constprop.0
>       12 __rhashtable_remove_fast_one.cold
>       12 __rhashtable_remove_fast_one
>       12 __pfx___rhashtable_remove_fast_one
>       11 __xfrm_policy_check2.constprop.0
>       11 __pfx___xfrm_policy_check2.constprop.0
>       11 __pfx_modalias_show
>       11 modalias_show
>       10 rht_key_get_hash.isra.0
>       10 __pfx_rht_key_get_hash.isra.0
>       10 __pfx_name_show
>       10 __pfx_init_once
>       10 name_show
>       10 init_once
>        9 __pfx_event_show
>        9 event_show
>        8 __pfx_dst_output
>        8 dst_output
>        7 state_show
>        7 size_show
>        7 __pfx_state_show
>        7 __pfx_size_show
> 
> kallsyms_lookup_name() always returns the first function and ignores
> the others, so it is impossible to trace the other functions with the
> same name AFAIK.
> 

