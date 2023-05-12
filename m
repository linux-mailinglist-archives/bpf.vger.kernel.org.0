Return-Path: <bpf+bounces-402-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA04C700A40
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 16:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44DA1C21270
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01891EA70;
	Fri, 12 May 2023 14:25:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C77BE4E
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 14:25:29 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFE32D7C
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 07:25:27 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34C56Vln031166;
	Fri, 12 May 2023 07:25:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=AT94j2HgkV/kN27+32IV8meD47PuM2zEoEGnMYINnmE=;
 b=WBKa4hoUcgGH6HQBoj+Cr+NQCZcAtIVx2I9bNG0DZ8XbUMnEKy2lMndi1m0s7SkpWcAT
 SUPgABPUi+H+h+nyJf8cXM7XBUirI8FjL4RO0dwT7rRWUuHk2+RYR+c1tI6+A2l477oQ
 yD+eQ+DmWhdRuLeROX4pWsaZNn4OzjWE2afD9RbdvePAcFQlodPHSiBxRK4Dt8ixHW29
 siYkQJNz0LiM+K2Azo7Ujhx2wd5AfObKfsMnn54xhqJWKkwzEr3tcwZeY8U+ySyB5ESa
 qOBXCQyn0lF/94RgPw/GJSZS09C/bBi2epauHiMeLdkQibm8RtQLA5/DGCMREGFXpYJZ +g== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qhb3sn86n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 May 2023 07:25:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYToYlriQI7kKZTq7HE7JNzdfKomXZRMNOJmnKU1cAIxAFCvK6tkWGxRf4ULY0m/vSArvJQOwCt/9oOBg7d6EE+ygTV9yDgAI07lTnDBNbp5yeu72ugotplDUTIR1bm+rhMfo4aWeLg2MUQPgh3DLFkqo3tVQw/tXvrZTTRegyBB9wgtRKiBgfltMyCyIUJuwsYa+T3SV7O11ZTU6sYp7BR45DBNTvC32k3Dvr43N4chkIUlQCk4yDEDj5s7Y1ELw1A81e7VpqtANyZZSYQ1FkI1aJP9Q2tIPyz2hSE3qX85GZydueXtPfcV3DVl2iiPRajwc4ITwlY80P7xRsZWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AT94j2HgkV/kN27+32IV8meD47PuM2zEoEGnMYINnmE=;
 b=TT/ICJwbJx57EIO2hTT4+ID1r0CuaLgbT6BsFdOoVxHU0TELBjQ7LFVhZCLFGEfrERGCQDWNjlXr1dBk2X9qiBb8hK+04myO60385x7mVDOYPBVA/Qyb9PPpFjBKT0gVsamgu5h4BHGoxegT/F//JK7T0oHDd0KlmzFqh5irDzI3DcHkb25I53dv7AymREy3cMZdo++VSMIsOl6yqnA5XJ5mqTGXfe63ZFGodKDHn4sPcRHfNlZdNOqgvsYGxCS7mmSUOQnRpTrj3mmbRirV7iyh6le5cDJyuJlKbl7Eh5sgi5Dw33AE41s5vul/ckEfgVl9XVi/PpiJQE8nE3D/2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB4873.namprd15.prod.outlook.com (2603:10b6:303:e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Fri, 12 May
 2023 14:24:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 14:24:57 +0000
Message-ID: <709a8173-52ea-4a29-3315-591d6b1a92b3@meta.com>
Date: Fri, 12 May 2023 07:24:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH bpf-next] bpf: Address KCSAN report on bpf_lru_list
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com
References: <20230511043748.1384166-1-martin.lau@linux.dev>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230511043748.1384166-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO1PR15MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 194bbcf9-34a5-4e76-7f73-08db52f4a95f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Gn/sAtAltSrVd0jLsr6s0nyDYDhUpK/g6NfWYS+WEXjwk4Acu3sVA831bCzq5l8Li42RSXeGhUux3MRQFcPLvxETc3r/KRzhGM6TcPU9Ae8QrBY6IiI5weyIKLoa8IWs/5qFsMGzgRlPpl999CHhWrRcnFIAJVdmOPKpc5pTLYW+NffIoUzRJ0dKLHTSbRCpgZ166+zPxf2R85Q0YkosrX12VR2gbL3b8KkRwAtBOx8CpODf13MBVb2HE5Bjok3GvqiqwrLqgR0WMpGDc3JCW6CBzuy/IaVOkVcHd1pOjOppoKXiOhqVTcSzCtiUCr0z8BD3qIvECSjyms/ulG8sCeQ7ngK/mxFnm1c6gL1udVpj3rP/VewOxZmk2vZ2VmT1zRIQASif9SlI9dHcxOm8Kaz6L39nDkKkQfqZ5rX+FU47uf6sZL/2xfDaLoB6MauvS7feXrxE0PIoIVxy4vaqqEfbtv9UOU46JZAdzo+E9IUTIhsM99i5TNxsjqzaeSxgklrGPt5bbztZGCZDH0ZIJd1t+N7uRRAG9SXM8mcNx/eJ3N9zfSMTqtIdlfXcmI1OA/8kjGKgKzcc2IkhMp2155fQhGFDFCpsjeEViir3Jak764QKm2mpghaCzq93ZY5BduxyrEd2Q8ylx7Gkky79VQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(6666004)(66476007)(316002)(8936002)(4326008)(41300700001)(2616005)(2906002)(6486002)(54906003)(66556008)(66946007)(83380400001)(478600001)(186003)(8676002)(6506007)(53546011)(5660300002)(6512007)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bmFVNCtwMTc5T1llVnRpOFVIWXAwUXVLdkNYSWxXNDg3ME9tYXNEZTRKWHRX?=
 =?utf-8?B?blZma3BxTnlGSldGU1NlZUZoOUdiOUYzWmZxQmU0T2wxSXBhNGdUVmlNQSto?=
 =?utf-8?B?R3cwQmFQTzg3OXN0Mlg2bitFeGVnVjI4MWFuSlhBRHVuV24wMDFzbW9CakI0?=
 =?utf-8?B?MUF5czNJb3JEVEV0OEl3d2NsNE4rTllwNVVWWFRIMzBJcWpXempRTUMxYm1r?=
 =?utf-8?B?VDJLeUZXOTE3ckNQSUFOell2NGVJT2xOamRVMjNUOVRHQ2NoTTdFYkQ3QzhU?=
 =?utf-8?B?ZVcvNXJhdG5IZUJyK3ltc3Bqc1g3dS9sV1JqTEJEWFFtbFJuUWtHZWpveXVZ?=
 =?utf-8?B?RVJWM3U3aDlQRDFZam1WUDMwM1hpUlMwZ2w4T1UwTEdEenJ5Z1ZuYXNaME0v?=
 =?utf-8?B?RFlIcVA5aTdtQ3FhQytiMmNCWVE2bThQN2pvWXdKUUZZVEg0S1lEL1A2NHlW?=
 =?utf-8?B?VVR1a0VUa2FXVTFIek5uQlNSMHhHSzRXdnZnMVBVQ2QyeFVkNWFaOUxoNnFB?=
 =?utf-8?B?TExhVUVxdUdxWUk1aCtVY3g2dU9vOXhLV0NwOGQrYjZ5eWEzWm1wdHpyclNN?=
 =?utf-8?B?WWFpOFZQRXkwcDBTZG5zaGg1bk04ZWRjWW96WTFERFUxV2hzS0syRDZZaDhm?=
 =?utf-8?B?USs3ZnZzb2F6b0U0VlVvTE9abW9RVUxvN0t6dDQxODRkQmlJZzlTQ1lzVFRy?=
 =?utf-8?B?QXBpTE4ycm5URXp6TVl1MTY5cGc5dXNjM01ycUNuZHY3NVo0bG1lMk9VWnVP?=
 =?utf-8?B?Sk5yMXFPR0pmQ0tsZWVGYnBrcUFjZFVWSnJlTStxZUd4dCthNEVPYlBIZTRP?=
 =?utf-8?B?cWQ5TTFKcGFIYWJNK2JZZmpyaTNrSXhkbkxEZ3pJT2ZMeG4zRWRMbFRKajc1?=
 =?utf-8?B?NG1TR2Q3SENacU0xREpwRkc3enhOZDM0T2xyMzU3SDA2Q1Buak1IRFNMVkhC?=
 =?utf-8?B?SlJYWDJ6VUxsZkFDUG1rV3BLTEY4YVQ4OXJTTURyNUg3MVdWeUdaS0Z2WmxW?=
 =?utf-8?B?V0ZtL1JHVlF2Rkd3ZVhJclhEc21HdkNvcGpGZDVYWVlod1dtU1R6SW5vSXgz?=
 =?utf-8?B?OTlCOWVpTFVOMUQ4a0wwTlhSV28wUFFRMkdBbkxmR2dYZ2lHaHhYb0hqZUhF?=
 =?utf-8?B?RGVOQjUwaEJpSE5yZjU1djNyTkdWOUJveHVZMkJvRncvbEtoV050U3JDNENQ?=
 =?utf-8?B?L1haZldWK1hxcWRrSkhmNHBCb2VuZnNMeFMyYmtxTVduZjNjMmtuYlpCVExR?=
 =?utf-8?B?dHBrS1hjUnFxaUFhcVVBMUxObDVpMEZuY1c0Ukh4M1VISTJkQXlRZjZWSElS?=
 =?utf-8?B?aHRZZThzbG1tTS95SDRMNGdqUzR1elpUNXBjbktRYjNSeEJ5bnBkYVpTNmdE?=
 =?utf-8?B?aFIzazBNbFFBODNTNHRUeDdvZGRreXJLUTRWbnlYaXVoWE54cGJsZHRKNVBI?=
 =?utf-8?B?cGR3dTZOMEVLeUZZZHlseHhodzdtYmkxS0dzVXQyeWtMK0hXeG5NbXpHOTFQ?=
 =?utf-8?B?SkZtK0dYZCtpU2lmK3ZWNVE3SWw2SS9vL1d6bmJyVmJVWllJaVJSTVpyRGJV?=
 =?utf-8?B?aEdxVVp2NGE0RjhXMXp1dHhJaEpFNTNYQ05mc1RuYzlaN0U0dHZ3RytxSlJ1?=
 =?utf-8?B?Tno0MlBxOTB4RkVoY3EyZzU0TWU2bjVOM1hkd2lXUVRSdUY3M1k5Z2xTNTUz?=
 =?utf-8?B?REwxVCtiKzhaRzZ6Q3RqdkFqb1A5SWVHTkVpNDdES2wvWTRlMitOOHhjTWcz?=
 =?utf-8?B?THlkaU1PTG9MNThudmVKMzcrRXNBQ2N1eEpkMkIxUHZxL3R1OFBhcXlIMXdZ?=
 =?utf-8?B?N2R0V2l0a1hIVThLNmNjQkp2WmF3Tm1tZ0p1dCs4TmNKMm11WHRsaXM3bFBL?=
 =?utf-8?B?K0hOZndQYllLc3h1ZEJLandjeFF6TzQ5aXExcERMdG0xbTJtNDNpaUtmVEhF?=
 =?utf-8?B?bktrNnFGM0s1TWNzeWpINW8rRjFPbkdyZSs3VW53V0RteXF0aHlZQ1JXc2FX?=
 =?utf-8?B?R3ljYlArV3V5N3F4R2hGTXp5T2NOQzVxQTYweStBOVZ0YUFmUGZoa3BVd3g1?=
 =?utf-8?B?OVpLZW9JRGdjdmhzNGpaYmJab3FCTXYvMXFaRGJ2dUhXZTRTM1NjbGsyL2Yy?=
 =?utf-8?B?WC9WTXNPbGRJcVlvSnVhd2xjNTErMW04RENCc0tOWDRUdGhHNzlmNmFYYjNT?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194bbcf9-34a5-4e76-7f73-08db52f4a95f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 14:24:57.2153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orKl8yVAoBLws7xJEk2Knnz9OxhNGLPYp6OWH2WGYmWwFnp71m7kIX/s5ciH6pt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4873
X-Proofpoint-ORIG-GUID: 1OFylc5cRvGj_i0Ny4nt1ePLEMG6bgwz
X-Proofpoint-GUID: 1OFylc5cRvGj_i0Ny4nt1ePLEMG6bgwz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_08,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/10/23 9:37 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> KCSAN reported a data-race when accessing node->ref.
> Although node->ref does not have to be accurate,
> take this chance to use a more common READ_ONCE() and WRITE_ONCE()
> pattern instead of data_race().
> 
> There is an existing bpf_lru_node_is_ref() and bpf_lru_node_set_ref().
> This patch also adds bpf_lru_node_clear_ref() to do the
> WRITE_ONCE(node->ref, 0) also.
> 
> ==================================================================
> BUG: KCSAN: data-race in __bpf_lru_list_rotate / __htab_lru_percpu_map_update_elem
> 
> write to 0xffff888137038deb of 1 bytes by task 11240 on cpu 1:
> __bpf_lru_node_move kernel/bpf/bpf_lru_list.c:113 [inline]
> __bpf_lru_list_rotate_active kernel/bpf/bpf_lru_list.c:149 [inline]
> __bpf_lru_list_rotate+0x1bf/0x750 kernel/bpf/bpf_lru_list.c:240
> bpf_lru_list_pop_free_to_local kernel/bpf/bpf_lru_list.c:329 [inline]
> bpf_common_lru_pop_free kernel/bpf/bpf_lru_list.c:447 [inline]
> bpf_lru_pop_free+0x638/0xe20 kernel/bpf/bpf_lru_list.c:499
> prealloc_lru_pop kernel/bpf/hashtab.c:290 [inline]
> __htab_lru_percpu_map_update_elem+0xe7/0x820 kernel/bpf/hashtab.c:1316
> bpf_percpu_hash_update+0x5e/0x90 kernel/bpf/hashtab.c:2313
> bpf_map_update_value+0x2a9/0x370 kernel/bpf/syscall.c:200
> generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1687
> bpf_map_do_batch+0x2d9/0x3d0 kernel/bpf/syscall.c:4534
> __sys_bpf+0x338/0x810
> __do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
> __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5094
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> read to 0xffff888137038deb of 1 bytes by task 11241 on cpu 0:
> bpf_lru_node_set_ref kernel/bpf/bpf_lru_list.h:70 [inline]
> __htab_lru_percpu_map_update_elem+0x2f1/0x820 kernel/bpf/hashtab.c:1332
> bpf_percpu_hash_update+0x5e/0x90 kernel/bpf/hashtab.c:2313
> bpf_map_update_value+0x2a9/0x370 kernel/bpf/syscall.c:200
> generic_map_update_batch+0x3ae/0x4f0 kernel/bpf/syscall.c:1687
> bpf_map_do_batch+0x2d9/0x3d0 kernel/bpf/syscall.c:4534
> __sys_bpf+0x338/0x810
> __do_sys_bpf kernel/bpf/syscall.c:5096 [inline]
> __se_sys_bpf kernel/bpf/syscall.c:5094 [inline]
> __x64_sys_bpf+0x43/0x50 kernel/bpf/syscall.c:5094
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> value changed: 0x01 -> 0x00
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 11241 Comm: syz-executor.3 Not tainted 6.3.0-rc7-syzkaller-00136-g6a66fdd29ea1 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
> ==================================================================
> 
> Reported-by: syzbot+ebe648a84e8784763f82@syzkaller.appspotmail.com
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>

