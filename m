Return-Path: <bpf+bounces-2002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F19D7264AD
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8AA1C20DD2
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95A735B5B;
	Wed,  7 Jun 2023 15:30:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA931ACB5
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 15:30:48 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9668610D7
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 08:30:31 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3578CJPK014481;
	Wed, 7 Jun 2023 08:29:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=KjY0V61NN6ffEjVM3SFYFjtn3mN3FXvRr+/CO8tIZBQ=;
 b=b2vb8lTToP3Ajrbqh7boc2eLSMqhjowjjCgvEjP7A6naOygP1Xgd4q0TNGmRTr9lTkTe
 3Id+gGa67AmR5ztGt2U5AvAAplPg2BB8UpKnXFxi4fGfeiCc+LrZ7lvXNP/CyqV6W1+b
 kBrOZc9mxodzvPZmW4Ki2x2cbEOUjI/6ICb+DJGGHRArqGlQ6e3sx+kBcDlbjGKEZFhg
 K0qgLM6cBbS0B5uREVSPz9MJMWnuw/9Wl1BOYrcpbHnQXGes36QPfxV9+aO98Kw7l4fo
 hnu8ufakp6YCSeFMWjdy++ta7VxoZitBcofYn6fg+B3dk4nPR6YG+c5OUEHaBuLP9dp7 JA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r2a7sqg8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jun 2023 08:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6yug/MOrAxTXE36DdhvMDhyibXYWu4bKg7iz735NjJ5LmM5BOpfI0HjLMN8pjoBwX4GwLs2JaF+p+326JDsSu+sXr/GRXmvRJpcIln8xqkbbbXtXbQ93MB9BhxCy6RbTeg59MuQhwLl/nRkM+Afikgh7CG07PoY17zwvB0svCQmUsQPtl8NiKQCtp1AJDbkv5s5Rr+GKWDVtErtS/SeCoucPWoAGXvjFUnKY+GDKsgm19yeIL9VEPM4nRRsNtRq6hY0/6wqf9dhgMmPOZ8VBkW9EVmquAb2+s1FdG9ZiBORHY8mtJTAyBNb3uhaaBEBqFXFAf60Isk/sTHZvSFXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjY0V61NN6ffEjVM3SFYFjtn3mN3FXvRr+/CO8tIZBQ=;
 b=XzB85oUwHez12AE+bSCr+H57wm8mbowUy+S63bYzrVztZ8GoZbA8XJPJu3n6IIGfxnMpDnUhkm2Vg9PMTPNoaIYB9q+COhclXuFIJVRS7dCJERVUW8z8m7k83TGsDfdNH0m0wsd7tJYXq+cqsP2rUvRPhUTRuusbvLJGlxEd+1llSWIUGe5kPFHfSOoSEMiWgadwYS+2ueRZQ/q7+7lPOzdqTVRuazRJHqy7nK5DvqMERQ1f69/YvBJA6jqRqf+iknlpSnFSawHlzGMe2/GKkgbdwS1hl7HJnxJUBz91InrnB1nIWM+AY4hjVkIncw+H00iOVTaBCjcFZ30l6YHvxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB5188.namprd15.prod.outlook.com (2603:10b6:806:238::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Wed, 7 Jun
 2023 15:29:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 15:29:41 +0000
Message-ID: <e58d3ec4-dcac-48b8-c6c2-63d131d967d8@meta.com>
Date: Wed, 7 Jun 2023 08:29:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
To: Eduard Zingerman <eddyz87@gmail.com>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com>
 <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com>
 <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
 <CAEf4BzZaUEqYnyBs6OqX2_L_X=U4zjrKF9nPeyyKp7tRNVLMww@mail.gmail.com>
 <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com>
 <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
 <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
 <CAEf4Bzbtptc9DUJ8peBU=xyrXxJFK5=rkr3gGRh05wwtnBZ==A@mail.gmail.com>
 <CAADnVQJAmYgR91WKJ_Jif6c3ja=OAmkMXoUO9sTnmp-xmnbVJQ@mail.gmail.com>
 <878rcw3k1o.fsf@toke.dk>
 <35e5f70bbe0890f875e0c24aff0453c25f018ea6.camel@gmail.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <35e5f70bbe0890f875e0c24aff0453c25f018ea6.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 305e4ca3-1235-48a1-84df-08db676c0364
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+1Dw+a91A8V2wEPGCHAJ4/XNgvlnUSxawcmQlJx1ZkEzrUfUnpZ27kg7/Q52KVK9fYDi0oEneTUcYNQCBu+ZKVa9snRg2ZTY2qexCAQfbjvA2OjvRPg0AvAt6o16OZ5VZocZyktXm8enDauK/3ED/idWNmEeX/YYr9fdeS+H0WRRARJBptBe2MzjUhKSXSTCU4+tmHeYT/FpGEz2s6SOlPchqimUAA80OwFQw5+PaTMp9wFUD49KAN6gRcMwLwzsvEEvCiM2FegWEtgHU++viWydSqtrY3SHARSbYMkAaqtygvnNhADlYL4ARuBVhcdRp7XsqGFZXszNSHc4BlrWtv943hhSxffrCWMjvonsHU9bg8+A2vO0EqMB4p3D3Xn0ODGFWaFEwB6vZZH/vHoS1NIgDtQpPDMcThEXThaZ7wQVc0EpEKM9oQTNSyoPmz64f9KkL/waWQe0+x5ldGa8ZwGpceXizCCUWqWTCAqMJZUAHLXISa2PffMHsaWti3zkgwD/sSVaP9h0z2IOccVRcKbcyA4n3YuXidMaTRyx/4O8gI/I7WbEv5sCvKOz2mxKp46IjdDXbRZdR3GO8F8Cb7LxcFAV/9ckujvWMxKmdJcL7wQsI3VH2xD3T+pJqWdqjrVOmofX/Lz5SEE10dghwg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(5660300002)(7416002)(8936002)(2906002)(316002)(41300700001)(8676002)(66946007)(66556008)(6486002)(66476007)(4326008)(110136005)(54906003)(6666004)(53546011)(186003)(36756003)(6512007)(6506007)(31686004)(2616005)(478600001)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUpVd3RHeWtzME5CZ1hQUzIrMFdjSzB0UzRGR1g2NEcrK3dXclVlb0lNWnVE?=
 =?utf-8?B?YmU3azFzZFVjd1hhQ0FOT3h3d0RuMFAyS0dKV3Q2ZXpPd0hHR0Izcm9QZGFQ?=
 =?utf-8?B?MlJvVXpOOE9ObU9DdmNLN29IaVdHTGhLcWIzd29sZ0UyTmxjUVBTSkIzeTNG?=
 =?utf-8?B?azlrZlUrSkMwbFZ5djJmS2pxVHBOMU02QmNGSm43UjFWWXlHdGgzaEpFWEpH?=
 =?utf-8?B?WXk3dDB1blNqMitqSFdOTTE1dU9wSWhOWW9HTHJUOGNUeVFlSmtabkJKb0hQ?=
 =?utf-8?B?L1BWdXYrQWh4eGNBRk81NDZ2SVV5QTFkbGhpOWtsSkkrcEtSNFE4ZTE0SXE3?=
 =?utf-8?B?OWNxWkpPcEhmRW9UckFZTlk0TDU4aEducDNMdmxuTFVvZkd5Y0Z4anAvT3Zv?=
 =?utf-8?B?VDY3SzVyS3F0UlpUdUQ1VUJ0Ri9EaUtpcWd6cm4vT2V0MWR4dUhQb1VFN1Q1?=
 =?utf-8?B?aTF5bjFuSlpJdDRGV2E1ZGZXYXhtRzIzc2oxUnFJRUtEdndyVmNkS1pRZVdK?=
 =?utf-8?B?OFdmdnFXYVc2OU1WalVLeUZ1OEREOWFidmR1S0lSV3FxZ29nakk2YmV6Q2hK?=
 =?utf-8?B?eXFSZGZlQ05xNURQa0lmRUhrSGMxVXIxRU9LOC9tSHU0Y1NidGxwUC9XWW5L?=
 =?utf-8?B?Z0pwUzgvZ3B4WW85S09sOHkwc3lOTkFva2NFMlBVYXI4N0pGK0IxbWY1cDMx?=
 =?utf-8?B?dkdzMmN2Yk9ia2ROa1J6WVNhWjF2a3ErOTZRcm5mZjRyem8vcm0xVzJlZWN1?=
 =?utf-8?B?ZEZuUlV6VU9xQzdXV1IvbU5XSGlZMUI4Q0t2WjZiSWRjSm9vTXMrQnlQWTRF?=
 =?utf-8?B?bkhycVNMK0FDYkNrelhmRFBvb2Jvd3ZVbWJyL2doYzNyQ2cvTXVQcGxldlJl?=
 =?utf-8?B?dGJ1RTM3dVhld1J6bWwzeHRpLzlwNWZTS1dWVnRYSjU5MWw0dFJCRVlXSFFY?=
 =?utf-8?B?M0tnUXRTZDJkbWlJNlFYUWdFZlBoYVAxZVlaQmlOb0pBNVN4TzAyYXZ0MmVr?=
 =?utf-8?B?cGZkZTRzMlBJSWtHak5VdUZXNGdmOVNpT093THFMZE5CbzFDUENWVFhNOHlC?=
 =?utf-8?B?dDBwS3hZNEQrS0JrZGMrSm55dzlDcWJjcUQ0alJ2dGhjVDJZNHVKaHNmc2xv?=
 =?utf-8?B?VGFvNE9Vd3V3VElWTXpuaHBXbTRHZEZzejVWVS96RjlkMkMveHBMeDNyalhR?=
 =?utf-8?B?TW9ObHVjL0NpVDkydnByWHM3SzhhaFJoM0g4Q1ptNDJ3dFZINEk2czlxNGV6?=
 =?utf-8?B?Q2NBa3FodHhROHpjZGNwbWp6SVVTZUtUdS9va00vdm5GVElIeDN2MUlHZFBi?=
 =?utf-8?B?RkF6ZnMwQWxuM0RaL293S0xZU2xTeG5SMDFnOVFjMzkzU1hQZXlNRUU0ZTJw?=
 =?utf-8?B?MzYrcjRXckRydEVBcUs5dlZWa3VlZ0M3VUxsbGRkMjZoa0Q5VzNHdlZ1aXVI?=
 =?utf-8?B?M3hJSGRGQWw1K1l0MVlEQkpDOUIrVjVIUkVjSDBRUjA0QTVXK0hHTGRzckRs?=
 =?utf-8?B?TGVDZ3N3cklJSEIxUE5PcXV1MGRPeXBBdW1iY24ybGhUL2dOMGdkSHNIQXJv?=
 =?utf-8?B?VVhnSFRtWEQzVWt3N2lMYWd0Q1lHZ243S0MzbGw0dFNIQUU3N3BEYll1Ui93?=
 =?utf-8?B?NTh6cUx5YU5SM2ZIRDdkbDJTQXdIY0ZrcmhlYVphUGdMeXBqSzllRHU3cEtx?=
 =?utf-8?B?MGw5Zm5oNEJCNy9SaklkQmpwSUpsS0twNDNHSE5zaVk0TDFmM0xxb3pSWWpS?=
 =?utf-8?B?bGxaZ2RHZkZLVEs2dU1RcHJjWFBsZTY1eitLNG9sd2x4UjNJY0p1cjdxOG1Y?=
 =?utf-8?B?azhybnQ0Q1JRYVlDNmZwVm5wdEV2RFk4M1hMRFcwQlZYRDB0RURJU0c5djJW?=
 =?utf-8?B?WWVyRC9Ea3ZzU0tJK3VLWHE5WHlnRnVzZGxlWkxySjNUQzF2ZDU4VWtSTUxa?=
 =?utf-8?B?NWxHVVFWVllOeTlYcGVDcXVDSDNZL0YrWElYTG9iOE5YT1hzODk1cWEzNENJ?=
 =?utf-8?B?VXovMVhkczZzSUp5OXFQMk83TlBFd2k5RWhRbjdydG51V09TREtjZ2x3NGcy?=
 =?utf-8?B?bUV6N3EvNU4wR1d2TkNreWxyalh2QnVsa2FhVS9JVUpWUVJEa1YxYzJLa2RJ?=
 =?utf-8?B?cHd6dDU0TlBTNElyTzRlL0c2aFEySU0wMVBGQkJmYnFvbU5FaWx0eEdHMUg0?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305e4ca3-1235-48a1-84df-08db676c0364
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 15:29:41.8012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UN+yUuDyDXk13c2/MOoOdhn40Xo5QNUtdPFUYP00PQMZzMtS7kDkxh84YCace+M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5188
X-Proofpoint-ORIG-GUID: uKHeX5iiDH6i0GVg0QxasjTT1PzfyffN
X-Proofpoint-GUID: uKHeX5iiDH6i0GVg0QxasjTT1PzfyffN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/7/23 4:55 AM, Eduard Zingerman wrote:
> On Tue, 2023-06-06 at 13:30 +0200, Toke Høiland-Jørgensen wrote:
> [...]
>>
>> As for bumping the version number, I don't think it's a good idea to
>> deliberately break compatibility this way unless it's absolutely
>> necessary. With "absolutely necessary" meaning "things will break in
>> subtle ways in any case, so it's better to make the breakage obvious".
>> But it libbpf is not checking the version field anyway, that becomes
>> kind of a moot point, as bumping it doesn't really gain us anything,
>> then...
> 
> It seems to me that in terms of backward compatibility, the ability to
> specify the size for each kind entry is more valuable than the
> capability to add new BTF kinds:
> - The former allows for extending kind records in
>    a backward-compatible manner, such as adding a function address to
>    BTF_KIND_FUNC.

Eduard, the new proposal is to add new kind, e.g., BTF_KIND_KFUNC, which
will have an 'address' field. BTF_KIND_KFUNC is for kernel functions.
So we will not have size compatibility issue for BTF_KIND_FUNC.

> - The latter is much more fragile. Types refer to each other,
>    compatibility is already lost once a new "unknown" tag is introduced
>    in a type chain.
> 
> However, changing the size of existing BTF kinds is itself a
> backward-incompatible change. Therefore, a version bump may be
> warranted in this regard.

