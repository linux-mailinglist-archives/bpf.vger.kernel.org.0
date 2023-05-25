Return-Path: <bpf+bounces-1216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48B67109F9
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 12:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882961C20E65
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D959E577;
	Thu, 25 May 2023 10:21:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9DE561
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:21:03 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F51A6
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 03:20:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PA0TaE008964;
	Thu, 25 May 2023 10:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aDVG0jMnH+7nS3gx60JVUIjwHIeur0Pimk1vtuYOrRs=;
 b=K1AoLtxywyXPLTN2SW8xDriJZGZhp6udJkqWXuEjJ3AdEmA4JBm09/rROfJidGrUKDRN
 9vQTltc4Whhf7MZsVtnWpHMbaZ0BQDWRPvbJR35J6i+/lZ0+o5xc5Dhw+shk7v+KhUHn
 y+uO9FfBU88717vBPAnYdo4poC79qbrA5ZytNL2q+LnJo5tYyy4jOgmbjxAdtnyK3Veg
 5RycPXKC17PsQxWqKKeLANfojittpECXuF0JwlV2ESgiHReCH4AbrrOUStayi7dQg46I
 ZToufdPUuHo2ve+XkSmTbl63XfEItCd4CLCxzu+cqBeirzJMHJzCDUj+UXtlNAvetNVt ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qt5hc0117-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 May 2023 10:20:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34P8NKRo023579;
	Thu, 25 May 2023 10:15:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8wy8re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 May 2023 10:15:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYLtVL8irzB5hVK1IrXVULm+H+3oAObwMRFp2UHjks6FMebgf6FDzj+288U0fGUQkuDNM46Lv3wWsDdkvVE6S6hvSP/3kn5UlaT8zaRj4h/NBcqzTnbvIR44Y4BFsAtcGuCCXxL3Qvqc5YQ+7b1w3AideYvzCSpc1wimfvQSM5K8vJmTQ2NZstNKkYeTdkdOODyqRcdpS3iBx7OEeosPLoR/EJQAlinA6MuCTgDjpWQs+ubdvv1LA6LWKITeYmRYkiQBE9zo0VzbAUaCkm2AvTlvHiuiXPnQBGMLih69UXPF7wSWaBUd6FP34EqUD39Jfw1RTGqmMuYhLXvRjMpeQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDVG0jMnH+7nS3gx60JVUIjwHIeur0Pimk1vtuYOrRs=;
 b=Y7eKUVfhviCUgLSYale6YT/Sa9D6F6lZwrnb4evvRMT/u6oH0+pGzagrmd/0N1c6r70RCeqXTk8mOi4EFQ0CGjHcodQ7pIJLUkYec0TTJubMDa5PGjJoErdRzm0ZMd2Wq1DJc+sKEKs1LDrVkaIHZ+c027/Z1RdVWMnIEXOse12tjytmXq9TIz1iihFsWVO6qZFeDVDc0hIMnyuUaT0x2/fi7sKcBlloLa+XlL8AQyxOfu/D8gwv5UzCTf/oL8A9c20Izga//2F+GDaHkPPPpJJUJyebgTCyoiNsI6NU3eEtcar+7x/9R8+CXhzlXHb09qxxznB6jKpHbxqGYkv7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDVG0jMnH+7nS3gx60JVUIjwHIeur0Pimk1vtuYOrRs=;
 b=SxtStYMbdU0LLwwPQE7X2q8ladUnzEs92amhMS9tfXsJBApDF9ve8PUqmq8ZmByD68cHT/N7PaYZwCIT8LYonbpL390+XDZwYKE+F15vvchZYOxP6+NdB+3tvcxlapnIT50ZL/4O+ROxPQm0aOYg/7V1U3wycWcXqgp+wGfVhOQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB6715.namprd10.prod.outlook.com (2603:10b6:610:148::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 10:15:13 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 10:15:13 +0000
Message-ID: <6cfc65a3-42f0-f520-fb24-026da60bdf3f@oracle.com>
Date: Thu, 25 May 2023 11:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function representations
 sorted by name _and_ address
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@meta.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yafang Shao <laoar.shao@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com> <ZGXkN2TeEJZHMSG8@krava>
 <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com> <ZGZQuqVD7gNjia7Z@krava>
 <ee0a24c9-1106-c847-2c91-0d828ec7fba3@meta.com>
 <CAADnVQ+xJVVbP8GC_iT3NgYhhyUxEWkT-kvNgRfDVyv4eyAgHA@mail.gmail.com>
 <CAEf4BzZZ1yP1_2zkGQnp_Zusn_z702eSi8h8ExEkTS8sfmk8_Q@mail.gmail.com>
 <ZG8huF4hD3uI0ajy@krava>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZG8huF4hD3uI0ajy@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0122.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB6715:EE_
X-MS-Office365-Filtering-Correlation-Id: 14c8e2cd-76c6-4617-17e9-08db5d08ed5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y3yv30yBmwmd8GhmUbgrmXmwSD2D/0ev00y+ljuhAQad6LkxJF5j5QhQyJvSDFITmuEaBtDaIwLNqyBKTAuuevF6L010HxroyrdWbT8YcvmRrwcHmlc6V6oMksVqPcJoueDQkXHKJ5LL4MWNAtutceRfAxFdXCI2Tx7MTLrQ2BBXRTfzD0BUijIvzLz3t2SMDOdaChNljP1j0oZdFhP6BAXa1V8SYz7mcFJHKLfGOuwQphPK6vRZuAcwMkQl7qbrcN0LJO0x5QZLOT0cWc+s2x4icFBnGJuqStWdRbvkEpcARGU2GIxQ0fY1MnE3iSJTsWxNu1to2Lqu1mqcW3DWenOjgVzZJKPmtiRo7IzflutIJOi081fY+Jcp7CXKmFvPKAKJlmZIXu/QptytW+iWvn17I5Y2pMnk7/UlePjXChZkR2xw/fz6wYgpj+o8P1yzVSpbkdgUxAK+mfb5z3Jm4WqFgwR69mff+Lc2n1CEfbLDriDW4risCRwBmV6jyqfoiEo63YUUH98KGdqu8V/QJaXBXKZ0y6gbIyog4MSAyaiJFc+z7jsDdulaKThbVl/YYYfQCOr3ZHt6e9ROGkxCfPe4i2+6zr14kuTYolElIZYGClZDgU9Z6Jz+00c5I/s7H73kbEg61ZpgfeT1qP+ypQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(2906002)(31696002)(966005)(2616005)(83380400001)(86362001)(186003)(38100700002)(53546011)(6486002)(5660300002)(8676002)(7416002)(36756003)(8936002)(316002)(44832011)(41300700001)(6506007)(6512007)(54906003)(66946007)(4326008)(478600001)(66476007)(66556008)(110136005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eE5vMTdLRHNkd2ZtdGMzL2Y1Wm1ucEpuQ0pxVFdQRzJ4U2p1eW0wWFplbEVV?=
 =?utf-8?B?aVRPb0xWanV5VkhGemswbEViaGRPemhYTWEzR3dWOG16WllTcHcraE01SzNC?=
 =?utf-8?B?ZjVhQVRrUlB6WEZCblEwVU8xekQ5ZWhkUjZNSldoc3NjdVkxTU5wVXpjM0xH?=
 =?utf-8?B?MEVxQmhPVkNQRXpSeTRxaWx3dCtQU2tINmZFWDNyQ0RKdnZuS3MwTEVOSURK?=
 =?utf-8?B?WjNjalB0ZzYwMGVpcnNzejJwMDdyTnVQMVlpcUhZKzdRK2YyWXdMNnBiYzhL?=
 =?utf-8?B?QkVQczUyNU5CSnZPcHJXbVBMcEIwdUE2UEIwazQ4dkYzaGh5a1hwcEZFL0Uz?=
 =?utf-8?B?aDA1QUN3ellDVVlTSVorUEdwcVJSWExYL01kU0wxU3MvU0x2Z3l5ZEVtcmJs?=
 =?utf-8?B?NVlQU25GdDFyQUZLN1FOYmI3ZU5GL0VwRVR4WWJVSlVqVHROc1NUTFhYUklH?=
 =?utf-8?B?dnRTYXZOaXhUSnJRY0RDOUs1aWFCRFFGOVJCYlF0eWNSMjdYSDZWOXVxMEVR?=
 =?utf-8?B?VXh6MzF3bllRWm0zWDFuTFB0YzM0ejBQUHVMK0pEbnRQNWltNGkxNWs1eE80?=
 =?utf-8?B?ZW5Yd3FWVTl2SVBLS3BucllSSnpWUGdzVHYyM1R5MU1SeGJINEVreWJDU2NF?=
 =?utf-8?B?a1hPUklRUkVxZWtwcFRyZjVqS2VoWDZlY0dPczZCOU5UQXhZbG12OFdIa2Zy?=
 =?utf-8?B?L1BLb05BMFZBWDRUeEQ3a0ZraThrdFRHWGowekZBNkl3cG41MzVYdENXcUIz?=
 =?utf-8?B?RUZHUktoSHQ0T2YzbHFkdGpEWUlTbkFlNkFyeTZxMUxlMGR4bzRoT0xhZjRY?=
 =?utf-8?B?Z0FOb0xmRGt3RDJ0OHE3OXkreXRPdTRHNkxhM0tEVkZ2bXFNQmZvZDYwb0FQ?=
 =?utf-8?B?d2RoYWhKOWZNbWp0Um1NMVhjWXhhL0VNUGRlSHFJVlo3d0p5aXFHVzZsbnhp?=
 =?utf-8?B?T0x0MUFDc1BNRTgzSDh0YzdLOFpjNndHcC9kZE5lU0hGR0RVdjBxcVBDZzYz?=
 =?utf-8?B?UURsTzlRZWRsQzZaand1clk2WTFOWXBENkljTFhaYm5jRWh1cFBRSURsVzFq?=
 =?utf-8?B?VDFWbnFLYzRHdnRSRGYza29pbTJKUmUyNDl6aER3V3drbnd2TmNhTmRnUEtt?=
 =?utf-8?B?TVNkcG0wRVhmNS9BUTdzSGw5KzZVZkNrUC9qdVhuQWtUdDNDbFk0SFFHcTZX?=
 =?utf-8?B?RUFpNFNRVjBNdHMvdUdod1Q2K2ppN2x4bmpza1JOU211emxKOHJ4YjJ2Q1Zh?=
 =?utf-8?B?RDV2MlQ2TCthOTkzK3lIeUh3MmI3VlhhL2ZvUmhuajgvWmJvVXJpUWpCYzdx?=
 =?utf-8?B?cVRMQm9GbGNJeE9MWlVSelBWSi82M0NpaFA3bTZSV0dudUJpM1d2b3hvUEZH?=
 =?utf-8?B?WjY2c2R1M3VYMGxXOXY2TWlZM1o4dlRmaDVZSlY3SU94MXhEOFd2Mm1xVm9S?=
 =?utf-8?B?cWVHa3B3bEhiRWxYOFRxb2Q2Q3JYOW5QWGd0aGU4TjRPcXIrL0ttU1E3SkJU?=
 =?utf-8?B?bENkZ24xUnNhNVozNmJBN1RqTjJwYUR6Uk5qUnVVYUwzS05CRTNOWFJHYm5L?=
 =?utf-8?B?T1BMRlUxTjhMTzk2cDhQRS9teVVKVzF5QTNSYWpnZHhGaEx5SVA4WnpDS2da?=
 =?utf-8?B?Y0JuSmdWK1Y5QkVVL1lQQlNBMFFvZ1BtNWJ6Ym9XZVdud00yU0x6TzF3aGJi?=
 =?utf-8?B?ZEVITnN3RHZNc0M2TWlHSU1wOUhOQ2w5VXJPcmxPMEw2UkUvSWF5QUJ3dGpi?=
 =?utf-8?B?Vk9tdlVCd0VIc1l4VzVxSXV3SEUxTUdpelMxSXA5dGxSWHJURWtsMHNlVjFS?=
 =?utf-8?B?bUk3S0ZBcGlWdFhMSVRWQWR0RVBqc216QXpQVUR6YU1LcjNpWFlLcFlTK0J5?=
 =?utf-8?B?Y29RU2NNTlZLa1VFaTl0WHZScGVPSmlwZGxpQ01GaDZrazFhSnN6SDN1ZFFJ?=
 =?utf-8?B?UmtCbnArNXdLV0VBN0Fta1gwaFhVL2s3d2JuMnU4WVdQQ2grSjNKZ3lJbDN6?=
 =?utf-8?B?M0NydHJtSUtrNG5sMkc3b0ZpeWlVaGEvRzJ5bG1ScUkraG1peDBobnFSVGhQ?=
 =?utf-8?B?NER5OGwxaHZ5OUU5azY0NGN1U0xVZklVWG9ySDJLU0dScTM1RElPYmpkbmZW?=
 =?utf-8?B?UTJLZURsNmVUMmd2c1pSU05ocUNESGpPblM3N2ErUEljcnV2TitDeDFWUG90?=
 =?utf-8?Q?Ia231TJZoTWn4Q3R2Uf8nEw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RlFXWVh3UElDNDlxSHFSUCtoYnl2WjZ6UjBXNXVtSFhkNlJGclA4MEErbzBY?=
 =?utf-8?B?QXA3L2FRUDl0NHovS1dhMFpZRDFSVmREcVdUdngwMndGd1creXpMdGJ1ZUIy?=
 =?utf-8?B?blhPVjZGczNySmlScWUwSHdVY1E2UTVUcTREalhseU54M24rVWE3ZkUrdTJL?=
 =?utf-8?B?YnI3TGVrcUIvTzAwTWFPdFlCQ1RXeFM0ZkI1dlIvWnl5N1Q1TklzYnFlYkxB?=
 =?utf-8?B?ZEFUTUQwM1N3WXZtZjlQR0l3akZjN1REUlNtSis2aDlNaVhSTmlkWWtXZmJR?=
 =?utf-8?B?VzFBdm9tN2REUk1yZjEweTVXdFpwZWlPSDMwTHd2eUZtM1pnWTlIbVptZVkr?=
 =?utf-8?B?dUpodFRHVE44TVVhUStYZ25oaXpqVDh1S3k0VDc0NUtKWkVrRnRDRURRNmla?=
 =?utf-8?B?TU5KQjZ2aTc1MXpoNnFqVE90cThVU3FwUzJLcnFjL2JlSjhWN3JWeExNY3g5?=
 =?utf-8?B?QkJFai91aHEvV25XTmw3NFpNeWsyazBIcno1QmZGMkxmYVh6MUdSWndPanlh?=
 =?utf-8?B?MDdlem9mVVZ5RHhMeGNiSmw0QWM2RjdjL3lXeE9HTnp4cXo0MGpvcmhTdGZO?=
 =?utf-8?B?MDFJanJLTW9rQ0wrVWdHVEljbGN5aDlpNUtKcU05aFNyT3Y5VFFFQ3FWV3l6?=
 =?utf-8?B?clV5QU5DVXB0TmROZVp2RklqM1dEdWk3R1lrYTZEcGRKaWpSNXUvaFdtaWc1?=
 =?utf-8?B?c2poQXFBSDVkc1J0M1M1VktPb0FCQ2lQRHFNdnU0YytIQnhSTkRIQi9MTEFS?=
 =?utf-8?B?Y1dMQW01WWEvYW95WWNUbW4zY1A5ZVVYa1Fld1l1WGR2VkNSN3pkSk9LUGsv?=
 =?utf-8?B?ZE5WUDJycHRnNWJjZmVWV1JKWnJYd3YwMmpvRjdlUE5OODB3S2tybzdMMG8x?=
 =?utf-8?B?RmRUTjFjYVZ5SjdodDdhZDl0L0VueWhELzlQU3htZlVkeG4yeXhYZUhuZlN2?=
 =?utf-8?B?biszdERNVlk4TDV1UTFCbFJZRnJ3c2FXb21wdEcvVDM3YmxJMy94TngzYlNj?=
 =?utf-8?B?eGJvZUF2OWc5c2w2VkRHajg1OEdzSkZReE02cVlla1lMTG5tQ2JmbkhYMStP?=
 =?utf-8?B?Y3U0SmlkQ3VSUVgzczhHbktPZXBFTEN2QUZnd3E1NHJueXZjb1hIbHpybm01?=
 =?utf-8?B?NGYzbkEzcncxUmU2cGN1TCtLeXM0NGwvOW0xVTNySHVyVUNWVkwxcDI3ajhE?=
 =?utf-8?B?M21yTGJNalZBWWtiQUJqNnlrVEtvajJSTEdKemhhRUxBcElnbGg1RFJNR0Fo?=
 =?utf-8?B?S29mUXpGR21kNkppdk8wa3BqYitXQndGbXFoa3VURUFrcGh2QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c8e2cd-76c6-4617-17e9-08db5d08ed5d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 10:15:12.8688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbfSdwWvmrOp9no3Iiu7qou2kvxxONndja3ywDgDlRJ0gcl04INZK5HkpJ6JR9CGcmSSG40gJgl6hzKSodmBnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305250085
X-Proofpoint-GUID: 0QkvDlwNB8wBJsLMSicnfsp0UZtDD7At
X-Proofpoint-ORIG-GUID: 0QkvDlwNB8wBJsLMSicnfsp0UZtDD7At
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/05/2023 09:52, Jiri Olsa wrote:
> On Mon, May 22, 2023 at 02:31:01PM -0700, Andrii Nakryiko wrote:
>> On Thu, May 18, 2023 at 5:26 PM Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>>
>>> On Thu, May 18, 2023 at 11:26 AM Yonghong Song <yhs@meta.com> wrote:
>>>>> I wonder now when the address will be stored as number (not string) we
>>>>> could somehow generate relocation records and have the module loader
>>>>> do the relocation automatically
>>>>>
>>>>> not sure how that works for vmlinux when it's loaded/relocated on boot
>>>>
>>>> Right, actual module address will mostly not match the one in dwarf.
>>>> Some during module btf load, we should modify btf address as well
>>>> for later use? Yes, may need to reuse some routines used in initial
>>>> module relocation.
>>>
>>>
>>> Few thoughts:
>>>
>>> Initially I felt that single FUNC with multiple DECL_TAG(addr)
>>> is better, since BTF for all funcs is the same and it's likely
>>> one static inline function that the compiler decided not to inline
>>> (like cpumask_weight), so when libbpf wants to attach prog to it
>>> the kernel should automatically attach in all places.
>>> But then noticed that actually different functions with
>>> the same name and proto will be deduplicated into one.
>>> Their bodies at different locations will be different.
>>> Example: seq_show.
>>> In this case it's better to let libbpf pick the exact one to attach.
>>> Then realized that even the same function like cpumask_weight()
>>> might have different body at different locations due to optimizations.
>>> I don't think dwarf contains enough info to distinguish all the combinations.
>>>
>>> Considering all that it's better to keep one BTF kind_func -> one addr.
>>> If it's extended the way Alan is proposing with kind_flag
>>> the dedup logic will not combine them due to different addresses.
>>
>> I've discussed this w/ Alexei and Yonghong offline, so will summarize
>> what I said here. I don't think that we should go the route of adding
>> kflag to BTF_KIND_FUNC. As Yonghong pointed out, previously only vlen
>> and kind determined byte size of the type, and so adding a third
>> variable (kflag), which would apply only to BTF_KIND_FUNC, seems like
>> an unnecessary new complication.
>>
>> I propose to go with an entirely new kind instead, we have plenty of
>> them left. This new kind will be pretty kernel-specific, so could be
>> targeted for kernel use cases better without adding unnecessary
>> complications to Clang. BTF_KIND_FUNCs generated by Clang for .bpf.o
>> files don't need addr, they are meaningless and Clang doesn't know
>> anything about addresses anyways. So we can keep Clang unchanged and
>> more backwards compatible.
>>
>> But now that this new kind (BTF_KIND_KERNEL_FUNC? KFUNC would be
>> misleading, unfortunately) is kernel-specific and generated by pahole
>> only, besides addr we can add some flags field and use them to mark
>> function as defined as kfunc or not, or (as a hypothetical example)
>> traceable or not, or maybe we even have inline flag some day, etc.
>> Something that makes sense mostly for kernel functions.
>>
>> Having said all that, given we are going to break all existing
>> BTF-aware tools again with a new kind, we should really couple all
>> this work with making BTF self-describing as discussed in [0], so that
>> future changes like this won't break older bpftool and other similar
>> tools, unnecessarily.
> 
> nice, would be great to have this and eventually got rid of new pahole
> enable/disable options, makes sense to do this before adding new type
> 
> jirka
>

agreed; I'd been thinking the same and I've been working on a proof-of-
concept of this based on our previous discussions, I'll send it out as
soon as I've got it roughly working.

With respect to the question of having a new kind, I'm not sure I agree
with the above. We've already broken the "vlen == number of objects
following" for BTF_KIND_FUNC, where vlen is used to represent linkage
information instead.

To me, it feels more natural to have continuity across different object
types (kernel versus BPF program) with BTF_KIND_FUNC: the fact that
it's hard to come up with an alternate name is perhaps a reflection of
this. Most characteristics (aside from "is a kfunc") seem to be shared
across kernel and BPF program functions, but the best way to judge
is probably to come up with as complete a list as is possible I suppose.

In order to accommodate a metadata description using existing
BTF_KIND_FUNC, we can have a metadata flag that can say
"KFLAG set means singular object following of object_size" that is
set for  BTF_KIND_FUNC. We can mark it as discouraged for future
use.

One argument I definitely see for a new kind representing kernel
functions is if it were the case that we might need N elements
_and_ a singular object following the btf_type to represent it.
I don't currently see any use for such a model for function
representation, but if that is anticipated somehow, it might be
worth having a new kind to support that sort of representation.

Alan

>>
>> Which, btw, is another reason to not use kflag to determine the size
>> of btf_type. Proposed solution in [0] assumes that kind + vlen defines
>> the size. We should probably have dedicated discussion for
>> self-describing BTF, but I think both changes have to be done in the
>> same release window.
>>
>>   [0] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/#t
>>
>>>
>>> Also turned out that the kernel doesn't validate decl_tag string.
>>> The following code loads without error:
>>> __attribute__((btf_decl_tag("\x10\xf0")));
>>>
>>> I'm not sure whether we want to tighten decl_tag validation and how.
>>> If we keep it as-is we can use func+decl_tag approach
>>> to add 4 bytes of addr in the binary format (if 1st byte is not zero).
>>> But it feels like a hack, since the kernel needs to be changed
>>> anyway to adjust the addresses after module loading and kernel relocation.
>>> So func with kind_flag seems like the best approach.
>>>
>>> Regarding relocation of address in the kernel and modules...
>>> We just need to add base_addr to all addrs-es recorded in BTF.
>>> Both for kernel and for module BTFs.
>>> Shouldn't be too complicated.
>>
>> yep, KASLR seems simple enough to handle by the kernel itself at boot time.
> 

