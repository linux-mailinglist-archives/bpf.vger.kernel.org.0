Return-Path: <bpf+bounces-910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903BC7087C2
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 20:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435A32819C8
	for <lists+bpf@lfdr.de>; Thu, 18 May 2023 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514693D392;
	Thu, 18 May 2023 18:26:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C243D380
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 18:26:17 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2EEBA
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 11:26:15 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34IGeVtp007867;
	Thu, 18 May 2023 11:25:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Ti2cPnvbNxIGZcYXYcTG1jDZK0AbN38sQYoj7CCF/6g=;
 b=C7Pj5vZsSHX52bgugNPJW8QY9tdVkmlzAQ20FlI9vAtYuPoyjBrJQqCpY0/r8nwELIv+
 QnQHHyyT3D23aHVGzi5LVVUooZfHgaR15d4h3KUZXJYiWIQ9UMKOYG4Zu4POim/nWj7Y
 P/H32puZKveKoltlaeJFqooYbnTg8JImn3+PRtKEO3qEyghgc6uByCFXfmeMCnwo940e
 axgUsvcLBc8LtfY96V+JvLqcaru3L1Tk58Oz3TwTSEd5Y17Dm78tIKSJHvB+KYZgHSFz
 alRKLkJoBa9/+AeH9w7XOfFQiHEmyjxten98CGcZLqneWRRkiZ4WG4kZ+au/oc1SH84N eA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qnqr8gs3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 May 2023 11:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqxcSu6inywVOhwA74O3nflPR4bTLqMVyx/JtDaSLuTZNVfqho6pnG+1XvAFWnFbWRwi5RACB22bS/tjW1iboholvFMm/DjKnPEGI+/Pqw9vtkO4E9aFA+Ej2bpKY7RhedzSEc8ywjPF1vHTULxL8JLx5eP4EzJLF46ky+ye0uHle1y3cTwL2Az0dOVvx1TVOgGk/D0yaYMBCByr0qL33fkPzArw1w2oOWBcHxKy5Fa0GqHQRW0/E+t3vF7V1JmASgkuX1OFsqFD4VxAKxoJK0ZcAIH3fdPYsVu4UVEdTYHUIVunr+g9iqmaN0GWtY8NEE9CPhHHFzXL+4ElVY95SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti2cPnvbNxIGZcYXYcTG1jDZK0AbN38sQYoj7CCF/6g=;
 b=c6qNMT4n4FAlRT+KNk10CNceq5XqkAKzgnnz64szKDZdwVoXNG60r3X4K50qzYiASOoEnoGbsnWrrfFnwCv8X90WxZBNOhyMRlA+fFc915nGDJrpURKwJo8qPjgx9XMxrIlizIAW+ubI7GsginsTJw75Dhj9uJch8NJqmff5hZkGGsePdG37ziaENvhiKihn38I5pIAaHH5ymdaq027L7OoYpxe7L+LyGR7nyZ++9GhpaXVnxP/JPyfNv4e5apFLNWlsN7eWRvH6miPNnCO/5q9nF5Uwnus1N4TGZ3tQr7QmG5PAx8bBe/jb9Rk7TfSSSljiEU/jWP/IEATKpR0BNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ2PR15MB5717.namprd15.prod.outlook.com (2603:10b6:a03:4c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 18:25:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 18:25:53 +0000
Message-ID: <ee0a24c9-1106-c847-2c91-0d828ec7fba3@meta.com>
Date: Thu, 18 May 2023 11:25:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function representations
 sorted by name _and_ address
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, yhs@fb.com, andrii@kernel.org,
        daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com> <ZGXkN2TeEJZHMSG8@krava>
 <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com> <ZGZQuqVD7gNjia7Z@krava>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <ZGZQuqVD7gNjia7Z@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ2PR15MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ab23e8-6b04-40d5-4d86-08db57cd500a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	M5PE+C/vwZ9ILdsaE+cih+mD/gtU9NxRegcINt5L86VpRRdZYhMCuTVEJUv5pgTzTf8UQs7XdCt6B1L5VxOXBd0t+C3qXnxNBrxzmij0c9NELF5f5xl+l8cirYQAghYUhFBm3MewaHDzwZ/2APDjg8hNLsc+VH64OGaeqnAiuHljLYfOX8fnly6DO038UoeRuFQLS24MpqZXSKSDmBNnfttJ17g8e6QDo+aKDgPNhi35vXowV1K/0emdCI7ELIQbK6QobU+po7ITLkRyXON103y8EDMi9r89lDe+T6RsS3wKN4zZLo9NXm23JIau2NwakmIohL2e8Y+9OdM9LaKFa/Uejx0GpYFLqlViJ14M2/XedsJqFOz9pb7eXe66aDeogFV/xG5duFtCxe44tM0tULBCqfKEMlZsGlIrd446YWZt0Q7CPE8Ly/+gffBqpLZxiDJSvZ6IlC0qi4T08NrwhCNSRSG4MLeki6bljzCGYgZBh3c7KVxn5wMKU2qw5CZOCy9gVTz7Os8T13QJ5NLmYSh+dvOPXDyU6dt/R1kky7urqVixZ5Gt2/kuEeKWFkf4XU30e3kabFxtj8x5urn1MVTNSx6kdE6jwa3LnJRi8xmxMySqTo6bDHnm4v6SAx8y/59YcrNehiPp5TS1RGL4mA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199021)(2906002)(478600001)(41300700001)(4326008)(8936002)(31686004)(8676002)(316002)(110136005)(84970400001)(7416002)(6666004)(6486002)(66476007)(66556008)(66946007)(5660300002)(966005)(53546011)(6512007)(6506007)(38100700002)(186003)(2616005)(83380400001)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bVpVeVFhaXY3RFprK04yZ1o1VWhXRG5KWWErOVhXUXJxdGJMU1VjbGhVU1BS?=
 =?utf-8?B?K3kyZy80Q0hJL1NQUXhPamJsRTlCdnplaWFmOFVCeDMwTytGaHgvVENUZ0Zk?=
 =?utf-8?B?elNleVZGTmJxQmcxWXQ5dUdKOGV3OXNBS0s0WS9ndWQ5RW1FOUU4ak5Remhw?=
 =?utf-8?B?N3Nidlc1QjlvU01PQVJKMm1xck1heTAvcW9keTFzUXd4NkN6TDB3QW55a2Vs?=
 =?utf-8?B?TFlUT3hkUHNGSG11NCs2RXpjVEI4WmMrVTlBakdmckQ4bndtdnFyZzNUSjVh?=
 =?utf-8?B?aUZ6ZDJUa29zL1RZWUxDOVRGTDlSd3pWenpkNU1tcjBuZnppbXlZRFRwWURR?=
 =?utf-8?B?bnIvK242aFhlZ1JhMWZkYTFlcnYxVy9nVzRkTUZIVUJib3FsY2w5VDZtbFZo?=
 =?utf-8?B?YzZKM2E2RGZRWU83Uk56WHVxSXY0L0F2ZzVJcjY0UVJkK3Zac1IyV2xsd0hI?=
 =?utf-8?B?S1RkaURPY3ZkRDcweGZvOGgrNXFkRFFEaUpYS2YrZkp0VUVFWVJSU3Fjbk0z?=
 =?utf-8?B?Mld3NEg1RWV3K0F5NzJacjNKOFdObnAxQmdpK2tTeU5IeDJ3YVRybmxsQnRW?=
 =?utf-8?B?MjU0V2xXUHhIZXVjaURndE01UkJCYXc5K3J1Nm9NZXVNN29HeEZZQnh5RXVO?=
 =?utf-8?B?TU1UZHBSVHdqWVJlVDJVelA0Lzd5UjRXWUU5d3ZwSENoUE9XbGNLdEFwTklZ?=
 =?utf-8?B?aVVGdTNXdGpJY0pXY1FsV1ZabGpYQ1RIOG1POWZmdWpkOHYwUDdmT3hQQjNp?=
 =?utf-8?B?U3FkUFJRRHhHN0V4R1M5dlUwNS8xOHhmYTNDZVQrNFFTT2tiaWszZ1N2Vm5a?=
 =?utf-8?B?QmFhcDhqeHFqbEdNd2tPRUhaa3N3SXZBZEE1emhpL2sxTWw2S1o0K3NvbnZN?=
 =?utf-8?B?Mm9uaDZxYklHclp6ZGRLTGpQSkdQaW1uOU1aSW9sN0NqbWJsb1U5Q1RMbnhs?=
 =?utf-8?B?SUVvOWQ4dHp1UFhia2JhRkxpZzdBbk9MUUROdEpOSmg2NHRnNFR0djBYNTNV?=
 =?utf-8?B?bjVOSWc0NnBtTjg0c3l0NlVlMlJtajFBM0xxRXJ5M2daL0RsVWVBZ0IwTVFS?=
 =?utf-8?B?L00rMUF6bVNCWDk4V0NRVFdvS3JpWXA5WmJGRGRTTVZLcTdTK1hwZ2hxNGpZ?=
 =?utf-8?B?OEkyVFo5Q2RHTWw0QldIdjlLYWQyVVpJMENRWG9mTWJkYjdCSUk5VUgzWjU1?=
 =?utf-8?B?UmRvQ0g3RngrWDhZOS9QNGJqK3ZVWVQxR3piOUh3MmdMQjlSamhuenJEdmlq?=
 =?utf-8?B?ZDcydGdUVEc0cDNMYmI5OGtOeVJuZDU3WUhpdldFeGtsVDZwTTdCVWo2SkxM?=
 =?utf-8?B?alFrcUJIREk5RlhtbTFpd2VxVytneTNiUm5WVCs4ZFF0aC9yOXBzY291bUpN?=
 =?utf-8?B?V0c3RkVzZzhhU3Q5R2lLVnk4VENPTi9RcnZzby9pQkRVY2gvcUNWL3N0bmdW?=
 =?utf-8?B?cmtXbHVaVjVTQ1ZLdHlXWDBEUEFWUWVNWDJMTUs1SCtWb2tHeDVNV3BZNWFR?=
 =?utf-8?B?UExUczM0YVRWYTlMZW9MYzFxK09tK3I5U2E3V3hjL2xxN25EVnk0Q3l1VEdE?=
 =?utf-8?B?a2RKNU5HL0NNQTZzWXlhTCtJMVQvb3NPVVhOZ1ZyMVVXSW9xa2ZtYU9oQlpS?=
 =?utf-8?B?SENoV291ZjFCSlhLWmlCZXpyeldKQVRwWVdCQmVkR2V0NWhzV1NQMWluTU1y?=
 =?utf-8?B?TDRnSmlscmhHbVczVGxlLzdjZXlJQmJhVVB0WkgyY1lUbFRPNTNuNXFVNjZY?=
 =?utf-8?B?NkUweFV0QThPdXZCc3JTSlhYSkVjLzJkZTZoeUFkN2VxSWR4QUt1TVdrYjRZ?=
 =?utf-8?B?QzFjSk5yUHgwZkd6NXhXbzVkQ1p5cGRjUkF2WDh6dU9DM3ZCenZNSndwL2xE?=
 =?utf-8?B?emVsWnNYNFNXVndDTVpHdjRNem5hNGhQRkZLSTJFQjhvenFoQXc1YmZteEV6?=
 =?utf-8?B?WGN4RS9GS0oxcU9TZlRBbDN0OXlkK01Xa2cyaGhMK2FMTEtzYXFuQTNsdm9K?=
 =?utf-8?B?a0dJaVNOSnpZbUdwOVNFS0k1a1k0L0tSclU3R3JqY2NqYVB0R2xxc1ZETG5C?=
 =?utf-8?B?ZTZmS0REbnI5NEkxcEtidlBnd2FGSHdLTUc5LzkvMElxSFErdXJnMHZtUXdF?=
 =?utf-8?B?NzRxVDl5bXJjVk9BM25Td3Yyd1FRdmtoNmhiRWZCaG9Ib0dQVlB5YXkzU0NU?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ab23e8-6b04-40d5-4d86-08db57cd500a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 18:25:52.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qJOBtG2gOitlu9HK9UbYEWjE5wRLCbxi88/ng1xts6uddtRuLFaWWRw9c7FQQ8p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5717
X-Proofpoint-ORIG-GUID: _EmUyDdpeAsdh4v7VVF2xIhFIHjpagjb
X-Proofpoint-GUID: _EmUyDdpeAsdh4v7VVF2xIhFIHjpagjb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_13,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/18/23 9:22 AM, Jiri Olsa wrote:
> On Thu, May 18, 2023 at 02:23:34PM +0100, Alan Maguire wrote:
>> On 18/05/2023 09:39, Jiri Olsa wrote:
>>> On Wed, May 17, 2023 at 05:16:47PM +0100, Alan Maguire wrote:
>>>> By making sorting function for our ELF function list match on
>>>> both name and function, we ensure that the set of ELF functions
>>>> includes multiple copies for functions which have multiple instances
>>>> across CUs.  For example, cpumask_weight has 22 instances in
>>>> System.map/kallsyms:
>>>>
>>>> ffffffff8103b530 t cpumask_weight
>>>> ffffffff8103e300 t cpumask_weight
>>>> ffffffff81040d30 t cpumask_weight
>>>> ffffffff8104fa00 t cpumask_weight
>>>> ffffffff81064300 t cpumask_weight
>>>> ffffffff81082ba0 t cpumask_weight
>>>> ffffffff81084f50 t cpumask_weight
>>>> ffffffff810a4ad0 t cpumask_weight
>>>> ffffffff810bb740 t cpumask_weight
>>>> ffffffff8110a6c0 t cpumask_weight
>>>> ffffffff81118ab0 t cpumask_weight
>>>> ffffffff81129b50 t cpumask_weight
>>>> ffffffff81137dc0 t cpumask_weight
>>>> ffffffff811aead0 t cpumask_weight
>>>> ffffffff811d6800 t cpumask_weight
>>>> ffffffff811e1370 t cpumask_weight
>>>> ffffffff812fae80 t cpumask_weight
>>>> ffffffff81375c50 t cpumask_weight
>>>> ffffffff81634b60 t cpumask_weight
>>>> ffffffff817ba540 t cpumask_weight
>>>> ffffffff819abf30 t cpumask_weight
>>>> ffffffff81a7cb60 t cpumask_weight
>>>>
>>>> With ELF representations for each address, and DWARF info about
>>>> addresses (low_pc) we can match DWARF with ELF accurately.
>>>> The result for the BTF representation is that we end up with
>>>> a single de-duped function:
>>>>
>>>> [9287] FUNC 'cpumask_weight' type_id=9286 linkage=static
>>>>
>>>> ...and 22 DECL_TAGs for each address that point at it:
>>>>
>>>> 9288] DECL_TAG 'address=0xffffffff8103b530' type_id=9287 component_idx=-1
>>>> [9623] DECL_TAG 'address=0xffffffff8103e300' type_id=9287 component_idx=-1
>>>> [9829] DECL_TAG 'address=0xffffffff81040d30' type_id=9287 component_idx=-1
>>>> [11609] DECL_TAG 'address=0xffffffff8104fa00' type_id=9287 component_idx=-1
>>>> [13299] DECL_TAG 'address=0xffffffff81064300' type_id=9287 component_idx=-1
>>>> [15704] DECL_TAG 'address=0xffffffff81082ba0' type_id=9287 component_idx=-1
>>>> [15731] DECL_TAG 'address=0xffffffff81084f50' type_id=9287 component_idx=-1
>>>> [18582] DECL_TAG 'address=0xffffffff810a4ad0' type_id=9287 component_idx=-1
>>>> [20234] DECL_TAG 'address=0xffffffff810bb740' type_id=9287 component_idx=-1
>>>> [25384] DECL_TAG 'address=0xffffffff8110a6c0' type_id=9287 component_idx=-1
>>>> [25798] DECL_TAG 'address=0xffffffff81118ab0' type_id=9287 component_idx=-1
>>>> [26285] DECL_TAG 'address=0xffffffff81129b50' type_id=9287 component_idx=-1
>>>> [27040] DECL_TAG 'address=0xffffffff81137dc0' type_id=9287 component_idx=-1
>>>> [32900] DECL_TAG 'address=0xffffffff811aead0' type_id=9287 component_idx=-1
>>>> [35059] DECL_TAG 'address=0xffffffff811d6800' type_id=9287 component_idx=-1
>>>> [35353] DECL_TAG 'address=0xffffffff811e1370' type_id=9287 component_idx=-1
>>>> [48934] DECL_TAG 'address=0xffffffff812fae80' type_id=9287 component_idx=-1
>>>> [54476] DECL_TAG 'address=0xffffffff81375c50' type_id=9287 component_idx=-1
>>>> [87772] DECL_TAG 'address=0xffffffff81634b60' type_id=9287 component_idx=-1
>>>> [108841] DECL_TAG 'address=0xffffffff817ba540' type_id=9287 component_idx=-1
>>>> [132557] DECL_TAG 'address=0xffffffff819abf30' type_id=9287 component_idx=-1
>>>> [143689] DECL_TAG 'address=0xffffffff81a7cb60' type_id=9287 component_idx=-1
>>>
>>> right, Yonghong pointed this out in:
>>>    https://lore.kernel.org/bpf/49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com/
>>>
>>> it's problem, because we pass btf id as attach id during bpf program load,
>>> and kernel does not have a way to figure out which address from the associated
>>> DECL_TAGs to use
>>>
>>> if we could change dedup algo to take the function address into account and
>>> make it not de-duplicate equal functions with different addresses, then we
>>> could:
>>>
>>>    - find btf id that properly and uniquely identifies the function we
>>>      want to trace
>>>
>>
>> So maybe a more natural approach would be to extend BTF_KIND_FUNC
>> (I think Alexei suggested something this earlier but I could be
>> misremembering) as follows:
>>
>>
>> 2.2.12 BTF_KIND_FUNC
>> ~~~~~~~~~~~~~~~~~~~~
>>
>> ``struct btf_type`` encoding requirement:
>>    * ``name_off``: offset to a valid C identifier
>> -  * ``info.kind_flag``: 0
>> +  * ``info.kind_flag``: 0 or 1 if additional ``struct btf_func`` follows
>>    * ``info.kind``: BTF_KIND_FUNC
>>    * ``info.vlen``: linkage information (BTF_FUNC_STATIC, BTF_FUNC_GLOBAL
>>                     or BTF_FUNC_EXTERN)
>>    * ``type``: a BTF_KIND_FUNC_PROTO type
>>
>> - No additional type data follow ``btf_type``.
>> + If ``info.kind_flag`` is specified, a ``struct btf_func`` follows.::
>> +
>> +	struct btf_func {
>> +		__u64 addr;
>> +	};
>> + Otherwise no additional type data follows ``btf_type``.
>>
>>
>> With the above, dedup could be made to fail when functions have non-
>> identical associated addresses. Judging by the number of DECL_TAGs in
>> the RFC, we'd end up with ~1000 extra BTF_KIND_FUNCs, and the extra
>> space for struct btf_funcs would require roughly 400k. We'd still get
>> dedup of FUNC_PROTOs, so I suspect the extra size would be < 1MB
> nice, I think it's better solution
> 
>>
>>
>>
>>>    - store the vmlinux base address and treat stored function addresses as
>>>      offsets, so the verifier can get proper address even if the kernel
>>>      is relocated
>>>
>>
>> yep; when we read kernel/module BTF in we could hopefully carry out
>> this recalculation and update the vmlinux/module BTF addresses
>> accordingly.
> 
> I wonder now when the address will be stored as number (not string) we
> could somehow generate relocation records and have the module loader
> do the relocation automatically
> 
> not sure how that works for vmlinux when it's loaded/relocated on boot

Right, actual module address will mostly not match the one in dwarf.
Some during module btf load, we should modify btf address as well
for later use? Yes, may need to reuse some routines used in initial
module relocation.

> 
> jirka

