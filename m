Return-Path: <bpf+bounces-485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E765701EC4
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 19:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D485E28100E
	for <lists+bpf@lfdr.de>; Sun, 14 May 2023 17:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156A89465;
	Sun, 14 May 2023 17:37:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00EE22600
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 17:37:39 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EABE1BD7
	for <bpf@vger.kernel.org>; Sun, 14 May 2023 10:37:37 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34EHRbEw003243;
	Sun, 14 May 2023 10:37:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=sDN1DfDWcKPDoJOMs+L8IkDGGfKuZcjuCpykOO8LpWU=;
 b=nOTj/cNWIcSl0uuIbmWyGaj8tHkdTELO5wlOhoAVfB2DO3ahQw3YY2sWnaDK2xRXiXNu
 v2cBaCPUSwD0Xo6smuMJygBWKbvZI3kP4t8WRU2Slevxd3eoUW+VKypwM50djix4s5U7
 h0xB1lXTUzR6z8UkJOezAhyxUn5jOiqiTjQRth+RO9Z8T5fzZHZNgfOCepSbdOfa5er/
 Bq40CarWwkuykkZxGfo7uxf+imTYTcqgDNXCdfzmiyJiUPFCS8dGjrPKFwggWyd1lYwz
 QRxF8nN0wMpruy+7xzlNA8C0/AtGxE2vbZnhdQKwJH63Umf9GFEftS/9r77CSbg0zUWW rA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qj89xxga2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 May 2023 10:37:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/Hlf03nXlEaIElBJNAKG6dgbybmk+Q5awFQS1L6DPadEx6pT9AYSYH58vmnuwH6w5hhX2I6A9DtHoM0aDEYcgehKbUOsWcqVdkIis1RMeLz2V+Xcm1HjebQqFtJnnLyWjOaK4DdTOB0sqhav51r9Ml5Akd49C8ScmgHbaR8THRCpQDMYoc8bIh7AGb8bdDwMztVV/dBuDF161evpPAzLdikunutgaGw+JuAyUhw93pkO059vQ30ZkH2zUvI4sbGBJvbkLByOzaiu6KxTdVBvvRsmUPZg0bRejrkr9z0ZEz6FXstertEezAxrTiMelf1CTC/nzlydgBQuoKseoMo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDN1DfDWcKPDoJOMs+L8IkDGGfKuZcjuCpykOO8LpWU=;
 b=eT4m7oTaGcO8DGgT1CnRCojS+AydAp6BSudrEJYXEZniNP9MCJoWIG655iJwa0K51DMyizbhXRQRUDAWOQW30P7p9Vd7tmeof0LhYI3sUCxj7jf0huvG0LXtdD9zaN4/t0fkvLS6OMqEH5zb7OwWGkr6gw/uIfemekAMSfeAWGIbavZ48BWvh8LcVHXgrX2HkAbPp1B6okldUZFW8N9+vF5s/47OmjFbtzK6hEU8DhHAEpOOe9ZRulxZGpB34z8CsNA6jqIgyVddHIbpCVebzR15YMP/vjK0dHRdzH3ZzoEBLxmJHadYdRSsdHGFQvV4FqC8xlefVyj1XT7n7BOo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB6127.namprd15.prod.outlook.com (2603:10b6:208:44c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Sun, 14 May
 2023 17:37:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6387.029; Sun, 14 May 2023
 17:37:13 +0000
Message-ID: <49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com>
Date: Sun, 14 May 2023 10:37:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] bpf: Add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
To: Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
        Yafang Shao
 <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>, Lorenz Bauer <lmb@isovalent.com>,
        Timo Beckers <timo@incline.eu>
References: <20230510130241.1696561-1-alan.maguire@oracle.com>
 <CALOAHbDeK4SkP7pXdBWJ6Omwq2NyxJrYn6wZTX=z1-VkDtWwMQ@mail.gmail.com>
 <6b15f6ff-8b66-3a78-2df6-5def5cf77203@oracle.com>
 <CAADnVQKDO8_Hnotf40iHLD-GRmJZpz_ygpkYZGRvey0ENJOc0g@mail.gmail.com>
 <ZF61j8WJls25BYTl@krava> <278ac187-58ea-7faf-be2d-224886404ea2@meta.com>
In-Reply-To: <278ac187-58ea-7faf-be2d-224886404ea2@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: aa319796-dc2c-4957-2f34-08db54a1da6b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CEEpIQjDW4qHv9v5Gi/8ZuwcC+nW7kU6euwtBjpUCiZVXvI4Cqbh15aOkck1AqzvB00b4ubQfyuBzgmcG031YVOFx7hpRBvol4nqNaQTaqmla59vj+KdNJvvbDczLp3rU+9zxU8Z/u9pifBSCqmmrKgN0SCfk3HQgJA54hcaO0/cR1B7+XKEo89A8YR2z5U271kb9wjAFeTncvcq0v9JPsNT/gP3OByTpc2FgksDdRC1vq2grblzNONlQDgCF32L23HbVRyeMPBISsjov4LGgxsSvS/3+QDWq6PjXUT+AEFpgrQg3wU5/gc2F4R9kRSK6DomfjuBT1/GfHIkiEaWT42TbrY7AyDX31V/F05EAUbWHd67LfoS+XDvbW2aYPJay90jDh3PQoWULfZA2dhnLwL2qvhPEB4f64p5CQZ11bGz5A0kGNGEGTauOUbTw4NkKjEgbtLsuNblUyJxF+oBVjM0gJepQG0dYAEAxW/yNbHmMtUVUEk8tqb+1hmCPNkGKEHmsuaHAsg4eg4a/tAbuOT0oBdMo9yRCp54BIY2W2hNj4Lg/KfT2X1synvvbww/oJvp1DYBXcyODNj6JyMtBU+ORmJBMZ+RZsCivrjNcpWXz9EHkLX8O4LcRJeHnuEbwKNydLxXnXFCJYHL0lTn8A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(54906003)(6666004)(6486002)(478600001)(110136005)(2616005)(6512007)(6506007)(53546011)(186003)(7416002)(2906002)(36756003)(4326008)(38100700002)(66476007)(66556008)(66946007)(41300700001)(5660300002)(8676002)(8936002)(316002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWU3ZUYrTnpCQm9tUWdMS1ZaU1RvbzlFRkpJVFZIZjZFbkVIUVYyN3piZEpC?=
 =?utf-8?B?TDFwNGM5bzBQMDN1ZURMd0tidEJjeUlnYmlXWHhCVlBmZ1lXelQ1QUdZVGxx?=
 =?utf-8?B?ODNoZUZEMHUzMktNVmRkUnJuL2F5bFRhanVjWHRoaXl1R1BIcUZEMVkyK3NQ?=
 =?utf-8?B?QmpxSkt0K080aGdjbHBCb0c0TTc5NU1PN3FnUS8rVHJBV1NRN0h3VTNGN0pz?=
 =?utf-8?B?WWN2WWFtYlJuS25zZGx5YlZNdFhpL2RzcDdHQnNwZUtnR1dySGNKWVRZTGk1?=
 =?utf-8?B?UVRDa3RrYlhsUWdoNTJlQ09RMUtYRDZYZVNCa1NZMlF5V0lLS250eHpNd2lL?=
 =?utf-8?B?YWZhSUhXdmtMbXpqOXlETDBDc0VEcGJjWTRGU2FZOHJzNENTcUtNSUh5OVRv?=
 =?utf-8?B?VkdKd04xVnEvRllHbGpmTzU2SlRQZHAzVVRmM1QxY3BzQk9jVUZMZHVjMHRq?=
 =?utf-8?B?Nk9VNUZLY2RjbEJNRkxSWVIwaW1zU2d1TXRWbHBmUkZxd29xWVVZWXFrQTha?=
 =?utf-8?B?b29hNFlBSEZWZ05LeTNaVXl2ZUlMT3ZxbjN1TWMyV29UZTJuZDM0dlowb0Vm?=
 =?utf-8?B?cTFCczMrVDVDdjdMbXg3V2sxL1ZtZHpkckI4TU5rZFE2UWFTM0t5d0s2b1pt?=
 =?utf-8?B?WWdaYjF6RUhxM0hIWnVobEFTdTNjSnNJY0xJZ3pWZG0yaFdMZVFESVNzNmJU?=
 =?utf-8?B?Y2t2M3NURWxaTDQ0anlKTFRjT25ZMGFVeGRnQThnRU0yd1MvVDhGNDRXTXpv?=
 =?utf-8?B?RFZWVnNGRk5sa21Ud0kvekJ2d2JwbEphNTdKbno2YkRBNFYwcXp4R1l0MW1V?=
 =?utf-8?B?Z09TbGpYTW0wYnN1aDViTU1kS0dDay9OTnROOFJqNU1KVy9zQWF5YS9OV1VG?=
 =?utf-8?B?KzE3OWJ2YlRFWnF4RmZhRDRIUUFSU1VFMlJvWWI3ZEI2K1RNWWpxNTk4OFFp?=
 =?utf-8?B?cmpQZjI3Z2orcklIWkRHWFk1Ujl6TUhxUHlhRFFTQ2Rkck5wOVVvNGtibzcz?=
 =?utf-8?B?bERyUk1vcXdzV2tEYU5XcHp0N1puOUdYU3l3dFJmZDF6enNYaWhVZW12dW5H?=
 =?utf-8?B?Uklta0NMWElpZnJGTHVVUjBYQk9XelIzWGFjdFE5N2YwSkQ2L0xER0RYT2xQ?=
 =?utf-8?B?U3BQN1RoOTMwQkdIa3lHQ1ZQRGdUN3F4R0ZlOERCNXVzdmNGeDhlOGhrRnkw?=
 =?utf-8?B?MkkwUFU0bmhWMUMzWmZYcXJ1cW1PTU8yWlZ4VlYydkk5UFd6VHlleDdjWWdG?=
 =?utf-8?B?UUN4a21GTDhCZFMzRG9DVmtTOXhHMUlsNGU5UmJZZUNvK3drS2hXcnMyUmc0?=
 =?utf-8?B?ZjNnWk9yUUtpUkJOY1A3ZzF1QVgyaE0wUG0vS2tWNmp4alNxRlMvV3I1Wmt3?=
 =?utf-8?B?Y2plbEZrQ2U4ODgwbW9Qb2dIN3hiQVhOT1NkWW9tQ0hFMEliczBSVlpJOFJN?=
 =?utf-8?B?ajh6cjBVZ0Q2dzN0RTlqMFhQNlVsQjQrM3NBb3hLem00R000TE5xaVMxZ1ZQ?=
 =?utf-8?B?Tll1SnFoekppb1B5YXQ0VjJVa1p2TW5RTTZLSTJjc0VXc01hWUNwZTUrbTN0?=
 =?utf-8?B?c2hBd1kxUkhFczdiSU1ZaWNWTm82MXpqOElkcERGWkRheTFHM3c3UWdoa2tL?=
 =?utf-8?B?am1aeGVHMjI4dTZ2cXJZZ0ErZ1FlZVVKTWZadnVqM2hXZ1hGWUs1cTUwNlRH?=
 =?utf-8?B?c0xoYzJkT3gxeE9vSnFSV25ZV2EwbHRmazRWeEtXK0lDSXMzN3paTTdBMFNY?=
 =?utf-8?B?QWJ3Z2liYnVGdFltQ0xhM1FyOThtRE5iUnRITGVveC9nZ2ZVY1VHY3dUT2Rt?=
 =?utf-8?B?a0t3TWZNTU8zYnA4eXRUWnQ5eFczUzRWRk1pUlZFNUF4UnpoMzJXYkNRczh2?=
 =?utf-8?B?aTd5RFFkcURSTGU0akdxdWNFQkhvZG8vVHc1Vm5xMy9KaVNieEpSTDc2a1RS?=
 =?utf-8?B?VzgzU3FYT0hSeS9FdDgxZ2ZjbVYrS0dPVjlqMUR0M083TzVUTm1Yb2JhOWha?=
 =?utf-8?B?ZlE3QlE0dG9kSUo5S0NYbXg0ZFRvQnZ3WWZtWEdvSTFzV3U0c3RvdE4vQlp5?=
 =?utf-8?B?RHU2YVVRS0l3TnhWdXZpeU1IT3VXc1lXeXc2dEtTaGJ6cEtGSzgwbWhDNmpH?=
 =?utf-8?B?eWY5WXdsekdjU0xpVVFZUzZiTkRYalFuSk5yY0dhQ1lvQXBTditocmtMK08v?=
 =?utf-8?B?V1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa319796-dc2c-4957-2f34-08db54a1da6b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2023 17:37:13.4896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ablXrGYbtgitaGS1E6i6dl4nDeEHLB0xXkNPZ+99KuGslgHvyhfd7yTj/KD8Oyky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6127
X-Proofpoint-GUID: 3p4AZtTeq73jxU5MDVpIu0JBLyvxzMKB
X-Proofpoint-ORIG-GUID: 3p4AZtTeq73jxU5MDVpIu0JBLyvxzMKB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-14_13,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/12/23 7:59 PM, Yonghong Song wrote:
> 
> 
> On 5/12/23 2:54 PM, Jiri Olsa wrote:
>> On Fri, May 12, 2023 at 11:59:34AM -0700, Alexei Starovoitov wrote:
>>> On Fri, May 12, 2023 at 9:04 AM Alan Maguire 
>>> <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 12/05/2023 03:51, Yafang Shao wrote:
>>>>> On Wed, May 10, 2023 at 9:03 PM Alan Maguire 
>>>>> <alan.maguire@oracle.com> wrote:
>>>>>>
>>>>>> v1.25 of pahole supports filtering out functions with multiple 
>>>>>> inconsistent
>>>>>> function prototypes or optimized-out parameters from the BTF 
>>>>>> representation.
>>>>>> These present problems because there is no additional info in BTF 
>>>>>> saying which
>>>>>> inconsistent prototype matches which function instance to help 
>>>>>> guide attachment,
>>>>>> and functions with optimized-out parameters can lead to incorrect 
>>>>>> assumptions
>>>>>> about register contents.
>>>>>>
>>>>>> So for now, filter out such functions while adding BTF 
>>>>>> representations for
>>>>>> functions that have "."-suffixes (foo.isra.0) but not 
>>>>>> optimized-out parameters.
>>>>>> This patch assumes that below linked changes land in pahole for 
>>>>>> v1.25.
>>>>>>
>>>>>> Issues with pahole filtering being too aggressive in removing 
>>>>>> functions
>>>>>> appear to be resolved now, but CI and further testing will confirm.
>>>>>>
>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>>> ---
>>>>>>   scripts/pahole-flags.sh | 3 +++
>>>>>>   1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
>>>>>> index 1f1f1d397c39..728d55190d97 100755
>>>>>> --- a/scripts/pahole-flags.sh
>>>>>> +++ b/scripts/pahole-flags.sh
>>>>>> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>>>>>>          # see PAHOLE_HAS_LANG_EXCLUDE
>>>>>>          extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>>>>>>   fi
>>>>>> +if [ "${pahole_ver}" -ge "125" ]; then
>>>>>> +       extra_paholeopt="${extra_paholeopt} 
>>>>>> --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
>>>>>> +fi
>>>>>>
>>>>>>   echo ${extra_paholeopt}
>>>>>> -- 
>>>>>> 2.31.1
>>>>>>
>>>>>
>>>>> That change looks like a workaround to me.
>>>>> There may be multiple functions that have the same proto, e.g.:
>>>>>
>>>>>    $ grep -r "bpf_iter_detach_map(struct bpf_iter_aux_info \*aux)"
>>>>> kernel/bpf/ net/core/
>>>>>    kernel/bpf/map_iter.c:static void bpf_iter_detach_map(struct
>>>>> bpf_iter_aux_info *aux)
>>>>>    net/core/bpf_sk_storage.c:static void bpf_iter_detach_map(struct
>>>>> bpf_iter_aux_info *aux)
>>>>>
>>>>>    $ bpftool btf dump file /sys/kernel/btf/vmlinux   |  grep -B 2
>>>>> bpf_iter_detach_map
>>>>>    [34691] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
>>>>>    'aux' type_id=2638
>>>>>    [34692] FUNC 'bpf_iter_detach_map' type_id=34691 linkage=static
>>>>>
>>>>> We don't know which one it is in the BTF.
>>>>> However, I'm not against this change, as it can avoid some issues.
>>>>>
>>>>
>>>> In the above case, the BTF representation is consistent though.
>>>> That is, if I attach fentry progs to either of these functions
>>>> based on that BTF representation, nothing will crash.
>>>>
>>>> That's ultimately what those changes are about; ensuring
>>>> consistency in BTF representation, so when a function is in
>>>> BTF we can know the signature of the function can be safely
>>>> used by fentry for example.
>>>>
>>>> The question of being able to identify functions (as opposed
>>>> to having a consistent representation) is the next step.
>>>> Finding a way to link between kallsyms and BTF would allow us to
>>>> have multiple inconsistent functions in BTF, since we could map
>>>> from BTF -> kallsyms safely. So two functions called "foo"
>>>> with different function signatures would be okay, because
>>>> we'd know which was which in kallsyms and could attach
>>>> safely. Something like a BTF tag for the function that could
>>>> clarify that mapping - but just for cases where it would
>>>> otherwise be ambiguous - is probably the way forward
>>>> longer term.
>>>>
>>>> Jiri's talking about this topic at LSF/MM/BPF this week I believe.
>>>
>>> Jiri presented a few ideas during LSFMMBPF.
>>>
>>> I feel the best approach is to add a set of addr-s to BTF
>>> via a special decl_tag.
>>> We can also consider extending KIND_FUNC.
>>> The advantage that every BTF func will have one or more addrs
>>> associated with it and bpf prog loading logic wouldn't need to do
>>> fragile name comparison between btf and kallsyms.
>>> pahole can take addrs from dwarf and optionally double check with 
>>> kallsyms.
>>
>> Yonghong summed it up in another email discussion, pasting it in here:
>>
>>    So overall we have three options as kallsyms representation now:
>>      (a) "addr module:foo:dir_a/dir_b/core.c"
>>      (b) "addr module:foo"
>>      (c) "addr module:foo:btf_id"
>>
>>    option (a):
>>      'dir_a/dir_b/core.c' needs to be encoded in BTF.
>>      user space either check file path or func signature
>>      to find attach_btf_id and pass to the kernel.
>>      kernel can find file path in BTF and then lookup
>>      kallsyms to find addr.
>>
>>    option (b):
>>      "addr" needs to be encoded in BTF.
>>      user space checks func signature to find
>>      attach_btf_id and pass to the kernel.
>>      kernel can find addr in BTF and use it.
>>
>>    option (c):
>>      if user can decide which function to attach, e.g.,
>>      through func signature, then no BTF encoding
>>      is necessary. attach_btf_id is passed to the
>>      kernel and search kallsyms to find the matching
>>      btf_id and 'addr' will be available then.
>>
>>    For option (b) and (c), user space needs to check
>>    func signature to find which btf_id to use. If
>>    same-name static functions having the identical
>>    signatures, then user space would have a hard time
>>    to differentiate. I think it should be very
>>    rare same-name static functions in the kernel will have
>>    identical signatures. But if we want 100% correctness,
>>    we may need file path in which case option (a)
>>    is preferable.
> 
> As Alexei mentioned in previous email, for such a extreme case,
> if user is willing to go through extra step to check dwarf
> to find and match file path, then (b) and (c) should work
> perfectly as well.

Okay, it looks like this is more complex if the function signature is
the same. In such cases, current BTF dedup will merge these
functions as a single BTF func. In such cases, we could have:

    decl_tag_1   ----> dedup'ed static_func
                          ^
                          |
    decl_tag_2   ---------

For such cases, just passing btf_id of static func to kernel
won't work since the kernel won't be able to know which
decl_tag to be associated with.

(I did a simple test with vmlinux, it looks we have
  issues with decl_tag_1/decl_tag_2 -> dedup'ed static_func
  as well since only one of decl_tag survives.
  But this is a different issue.
)

So if we intend to add decl tag (addr or file_path), we
should not dedup static functions or generally any functions.

> 
>>
>>    Current option (a) kallsyms format is under review.
>>    option (c) also needs kallsyms change...
>>
>>
>> my thoughts so far is that I like the idea of storing functions address
>> in BTF (option b), because it's the easiest way
>>
>> on the other hand, user would need debug info to find address for the 
>> function
>> to trace.. but still just for small subset of functions that share 
>> same name
>>
>> also I like Lorenz's idea of storing BTF ID in kalsyms and verifier being
>> able to lookup address based on BTF ID.. seems like easier kallsyms 
>> change,
>> but it would still require storing objects paths in BTF to pick up the
>> correct one
>>
>> cc-ing other folks
>>
>> jirka

