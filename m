Return-Path: <bpf+bounces-4851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD42750A7A
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 16:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499C428177D
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7334CD0;
	Wed, 12 Jul 2023 14:10:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49AC100AE
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 14:10:23 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808B2CE;
	Wed, 12 Jul 2023 07:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBPdS5juVM4c7yicezSnX2kCkgBo6qRAXSZ+eIP/ddGGVKQ5l1vdBkFJ2UcLui2vdOAdZWD1T7PeJ1oJxk8I+NqCBqsdqNytd9J+TGdMOPP3OzO5OfNt6COIojVUPk3+PU7WWFwbiX3Jul/WPWPQhqqmUHx4N/KVJBmli0v6wJrc4t5Zfzl99QdEG0qmh3o0g5TPUu1r3uiAOai2fMdSIHQEo9aNQ4sQaXvhK6ujrWSDAc7KjjCchgE6lvKX9iwM1cUa1MVDlfvn8yy944d24aR6jmlzAQtEFwLZdHk96QGmPGB9FRGauS62fi/TLW/KAKo0xwzln9a18Z9U98ZOWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FOQi+Aiir9e1fwEMgqZTXDIvDtb4VIY1/RX1clCV2Q=;
 b=MhaT8pjLaPpnrGN/Dvk1gAfB9KEsHZOr3CT9j+Qg3txDDhF8kw5/eXQ4URT+nbkBoYLeRFjeY6EzapyPtwyu54kASKm1S9qHYQM3womqlFn3Cmye+O3UD293Lhir7zrGl3a5cz1R5K5+M7QQ3P7rx1Kx+FgoQhRyDCYbvAJszmO8Q0R88+yfQtDQkWQ0lBdLQGz5a1WcA/tg/pMh+eRqZQKreyD4xLa7IDXbdzjICGhc13taMJ70e/b6vSH14vPJPwnhKgdAi41YrGKPtWUN/hcJ1+AFyNl+WhGwEdpbaqmUx6j4ksdWvBoF0MDRJx+h3g1ZLWjnopTUcAE2HgrZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FOQi+Aiir9e1fwEMgqZTXDIvDtb4VIY1/RX1clCV2Q=;
 b=Acxlb2nuedsusgvxVvPeV/u9WMdJeTmxUXXgXPSa45w0WHZNRPWROQu7mKvwTfQpvBIF25pzEWHadNkhrl7iDxjTqZuYCKM6eKWPlSJuvIFW+2hHPXMq6T8QpJb+VdRUqQG/pPSGf/yjp1QmJfTLJw7/AL0BTJ+tU4VVdAi3CnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 14:10:20 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::c4e6:4e87:551a:7731%5]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 14:10:19 +0000
Message-ID: <146e00be-98c8-873d-081f-252647b71b12@amd.com>
Date: Wed, 12 Jul 2023 19:38:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [BUG] perf test: Regression because of d6e6286a12e7
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: andrii@kernel.org, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
References: <ab865e6d-06c5-078e-e404-7f90686db50d@amd.com>
 <CAEf4BzZK=zm9PkUwzJRgeQ=KXjKOK9TENUMTz+_FmU6kPjab7Q@mail.gmail.com>
 <78044efc-98d7-cd49-d2b5-4c2abb16d6c9@amd.com>
 <CAEf4BzZCrDftNdNicuMS7NoF+hNiQEQwsH_-RMBh3Xxg+AQwiw@mail.gmail.com>
Content-Language: en-US
From: Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <CAEf4BzZCrDftNdNicuMS7NoF+hNiQEQwsH_-RMBh3Xxg+AQwiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: ec271843-364b-4a7e-8cb4-08db82e1b942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iekaGXehoOCkaBJG+jHG7Mrwy4+QE/YiXFfEyQ7eTljT/0mg0VcQ2xJxNB3hpQl80cV36HXPueJgqfV7HtCIZcgjGWECSb3vWJivbXEi2AX8et2dhKKP2+b/+nOWEntrUqaolbYPEUasP9LBKpJAT4CEkdvZHxpKPYJrQcitDWORd6J9adap5wYp1IvoOu87duiGX+Eb9fKoHsOP7otQGs9MVqis4gdKyZO4bGpfEBtt31dUnyt+Lcv1JLb8HZkTqVZUuVsyM3o0q0Kvh36Nw2X8JwH9J0hrO13HeaqM7WrBtF4ONdqIHLg18Cgi873r+gnd3xKkKHr8yt0d07JJccZ8H1dz+wllWl9fxrV2LJ5Y30nyRMgorAqGFC41emIJeS6YWSIXqHls34Okuac1lU+t8vYfFdrI5k+DMm6ChqD+qruPiFJ+C1sy5Gpvqh3Qnf50Xl7se/1fSZisRcQvGZYiWp9W2VEDrvsqamz2UdMNCxsMp1IVPIDURWl5lattXjy4l8icK/3Aa9Cni1ERxN1PBW6JWmzRQ8j/gQIm98OzEWr3pO7PHpmmw5I7tmdRcC91zV16+nCL3UeD4AZyUgY/Zgx0Q3aU9JDI1RX835RsYiwtAgiihg7gCHTF+Bde
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199021)(6486002)(966005)(6512007)(6666004)(186003)(6506007)(26005)(53546011)(83380400001)(36756003)(2616005)(86362001)(31696002)(38100700002)(4326008)(66556008)(66476007)(66946007)(2906002)(41300700001)(316002)(44832011)(31686004)(8676002)(8936002)(110136005)(54906003)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFVOc1hwOEUxUkZNZGFZNHd1SFZScUkvOTIyQndiZEdpcDh3STNtVzJhWG9E?=
 =?utf-8?B?bk4zb3UwOFdDbWVnUjlnNzhIeUZRWlFPbHFudlpPdk9RZVBhYkNsM3RYMU1j?=
 =?utf-8?B?NzdHQzlQc1JWVlA0aUNkLzRiUGdVRXZWSVhlQmRqSE03cSs2RFBnSllyd05q?=
 =?utf-8?B?NmwwTWpKZFl0NkhkR3JLbUgvemtJOVgybjlpKzE2VE01YWNJWGYvd1FqVzlD?=
 =?utf-8?B?aVhTbTVoMnJKUE14K0RtbVBsZk1rcWZ2RFZSR1p2a283SW9XMVozckhaNU9T?=
 =?utf-8?B?K2RDOEJuNmdLSndaNDdEbnZxVVgyWGZ5Uk5wMVBYdVNlSk5KYTJBNVo5OWJO?=
 =?utf-8?B?VEIzY1VWQ1RiaFduY0VvbzBnblY2ZjhLZFlFQnZnZ3RNc3M0OEN0TGRpd3hF?=
 =?utf-8?B?M1VPNHdyS0hCSm9HN1dnclYxQ3Y0ci9IZkY3SEhEZVlPaUU0T3FNcDhiWElQ?=
 =?utf-8?B?ZjllOTBseUdxZU9XRzJnbnRMWEdJQ0RSbTFKMDJJZjdKTXpGMGFIQ1lMQUEz?=
 =?utf-8?B?T0pQSlRCNjJMenIxamNQMytUdldPNEVWdnpwekgyblpFSWczOE9rOWphUVJQ?=
 =?utf-8?B?TFp3WExkbWU2RFFUTnlkZC9kdC9peTlBRXhxV2JDUVFCNW1hVUFSR3EwWXJE?=
 =?utf-8?B?NmIwUjlBS2QyMVpsbzBhUlhJa1kwekl0ZkJXRG5TdlZlck95MUw5SGVPZURP?=
 =?utf-8?B?cEpLRDJnY0NuVGJscDdPOWRJNVVyUk1mUVpJM3pQNEowbVlMdWd0czJ6TXhR?=
 =?utf-8?B?WjRuMDdmTkJiZDJYaCtKb0NacWZFZkZsVmswK0VoOE81NkNmZVloeTh3bVZw?=
 =?utf-8?B?eEVRUUR0SkJDUXV1bHZUUkVoaUZ0N1NJQUFURUFKMFJkRzcxQ2JvZXlDN1RC?=
 =?utf-8?B?akZQTjZGalZQSjZDdXBvYXYwOU5WU2pFZWlKbXpZMHVwTDJMcVFQV0VOeVI3?=
 =?utf-8?B?THpvWnJvZXJqYkRZL0dRYjJ1OGtTNk1YVGtBNm5rTjVoT2xZMVhGMDhNUURo?=
 =?utf-8?B?amRmcGQxempEQzY1OU12RXZWcTNoSWZoR0JXamhnakpySmhiVTJQWmFDdHp6?=
 =?utf-8?B?WFhEb1VVWHlsalhiZWpnVHFSdFc4M3pKc0E4aUtVeXlzdHNMVlExVWYyT09N?=
 =?utf-8?B?ZXBYSHhGc0JWaTkva2dMNjVSNzhwRDBtSVphYnRFQ042T0R6RHFDUlRnNFIr?=
 =?utf-8?B?OENiRFZRZ200aWlpVDRCL1pTVUQwZFhtTTh4WjlQSytZSFRqOGlEUmd1UTR1?=
 =?utf-8?B?Q3MrVmpTdytpNGp4K0RSZU80N1g1cUZ6WjRYV0lzK3lIOTA0dHVjcW8wVTlp?=
 =?utf-8?B?VlVQQ1l1VjdmMkxKMlFoUjFYMkpWOFg5Q0tCcUZtMlJsU0lHWHlPdTFHWDFs?=
 =?utf-8?B?UnVWTnA4UXpSZ3lkNnJZbWYxaTBxMHVyTWpLUEpKYUFQVytON1VGTzAwL3B2?=
 =?utf-8?B?Q1JhWjNyM2Z3ay9oaVZFSWx3dzhod2lWb2FLWkVGd3pqZHlFZkFoUlNNeGxZ?=
 =?utf-8?B?SUo5K2ZFbnRoZjdlVG5JZFRWSzgzRHlCVG9meHhWci9zTzVYc2N5T084UE84?=
 =?utf-8?B?SVQ4RUxEY00wUkdVMW4zcmR4bU9DOXVCQ0RMalZNcS9rSnBrWng4ZDZKNWQ2?=
 =?utf-8?B?ZnNvYnNwMEV2UXJCVCt5Y0tERnliVW1mQVZtdW9EaXBGYjJNaGYraml0bDZB?=
 =?utf-8?B?bkI0QVR1YkZleExiUVZQV29CbkFWYXNEQmdPMHE3UHRQZnZWc3RaOWNYTFhz?=
 =?utf-8?B?WW1kREY5MXZSOEVnMmJiTTZjNXVSZFdsNFowUDFCMC9ZaFRqK2czaXdyZE1v?=
 =?utf-8?B?S24zK2hsb0lPZ0ZlSjVaaGF5UkgxY3lWN0NOOWcwR2wzamlCbkpHZnpkTGhm?=
 =?utf-8?B?N05lMUM4UTloaUZMcnoySWIwcGw2eGg5S1J3d3hCZUdjdEwyK0dWT1pmTkVl?=
 =?utf-8?B?ZlB0aDJDRklGZkRHbEVpWjUvRHZDNDllQ0N5b1VRR0NyZ2JmdXpXM0pRZWhz?=
 =?utf-8?B?RnhkYmVwN1hxY0tpUklGVHczMkZOOW4vbXhVaGVpRnRNMHdoYVV0UWlHcmZk?=
 =?utf-8?B?RkE2RGt1UkthMjBvVTRUZ3plSGFaeGdpdGM5cVdndG1wZXZkbFZHUjQ2eGJD?=
 =?utf-8?Q?TWwFem0mOOt3bWKn4JOcHddhD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec271843-364b-4a7e-8cb4-08db82e1b942
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:10:19.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zB7I2RTRHPxdBnhzQY6fo0Fn345YaMuKiisrlLmycupqvdJFkl0FvZxAUMQnXxy8gmQBY42QIs0XVKyasylUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11-Jul-23 3:06 AM, Andrii Nakryiko wrote:
> On Sun, Jul 9, 2023 at 9:05 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>
>> On 08-Jul-23 4:46 AM, Andrii Nakryiko wrote:
>>> On Wed, Jul 5, 2023 at 9:39 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>>>>
>>>> Hi Andrii,
>>>>
>>>> I'm seeing perf test failure because of commit d6e6286a12e7 ("libbpf:
>>>> disassociate section handler on explicit bpf_program__set_type() call").
>>>>
>>>
>>> Yep, this commit would reset catch-all custom handler, which perf is
>>> setting. I've just sent a fix upstream ([0]). And once it lands, I'll
>>> cut a v1.2.1 libbpf bugfix release with just this fix on top of v1.2.
>>>
>>> Can you please double-check that this patch indeed fixes the issue for
>>> you? I tried to do this locally, but for me perf test 42 fails both at
>>> current bpf-next, with the above commit reverted, and with my fix
>>> applied on top. So I can't be 100% sure.
>>>
>>> Thanks!
>>>
>>>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/20230707231156.1711948-1-andrii@kernel.org/
>>
>> Thanks. A quick test seems to be working fine.
> 
> Alright, thanks for confirming! I've just released v1.2.1 bug fix
> release with just this fix on top of v1.2.
> 
> Thanks for reporting!
> 
> But given v1.2 was cut on May 1st, and the offending commit landed
> some time late March, I wonder how did this slip through the cracks
> and go unreported for so long? Is there something we can do to catch
> these perf-only regressions a bit sooner?

I guess it got slipped because that patch went in via bpf tree. Would
it be possible to run bpf related perf tests at the time of applying
libbpf patches? Arnaldo might have better ideas :)

Thanks,
Ravi

