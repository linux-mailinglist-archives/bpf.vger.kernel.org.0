Return-Path: <bpf+bounces-75854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE248C99B5D
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 02:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1ABE3344E9C
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 01:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29571DE8AF;
	Tue,  2 Dec 2025 01:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="kJb6HaUn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858673F9D2;
	Tue,  2 Dec 2025 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637949; cv=fail; b=EgYaQnp4JI6fYQWuheRJEVDeV80PW/a4+8V43HUfVTmObR2dKMzo/lj75qYphxHTqIg3J41C8BaxYvceMtEyN74mINVUYslwkTz852fEmKAnd1Fgv6+MzTzfx3JjNVSl5lARu2RpgWtRAAI351tIsb5TCTUtnJ22vjT1fbqVPD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637949; c=relaxed/simple;
	bh=I8clDcPy8iynbAxarZLoOD9HYb+CY5VULKNxXD175Jo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a6cjWNp6dHOyFjV9vGCNrb+PmC8uuQqMDdPUIYIKkbl5tXWLEtUsaL/bOT+1DThrX0YIvdQiTcCgwsrgH8D3TcZUHYvXL96XJWGerSvL7ILCzfLY5dfTie/BGQtP+o0wrH4QZ30EvWY8Y1krVWuXOMCkwPGKAXJyzNNFk0BhWcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=kJb6HaUn; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B1LW9TV1400345;
	Mon, 1 Dec 2025 17:11:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=cC6yZJ+t3AFwFKQExmklNrnrMDkkM5wxIN6PfYVSNHM=; b=kJb6HaUnjWbq
	oSfFPsZGIxRmkEW6xySKD3NQ+Mb4Sjl6D3SXfWXzx2UFL84pM9L4ncHlk9p8fYq1
	Ga6fILuio2SXFV9L0S/RCni4UI1Mvr/tTuVKQ054LDgN4a/kBiY/+Jlcn7Homlle
	PWQmNmrmyd4VdcMp5Wu5MvGYZXqjB58xyRj9EYmdOYkibHbSrLJsFPQrFbVnepzp
	ej30UC7ZzfG3rsbNZYHNwyxXJLKbCOSQykl/icZjUZwqFkkiBZgmrQvFHMHGq1Y2
	fwjEOliCsLSdiyq6C4k07YJmkaPnnCZZa9iNvhyTnxuduixvHeJKIaZi1YOdmLHK
	BgxzhNDVow==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4asehycg1t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 17:11:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrbwlQvQPAl6NjuerX/NisF6DotMZCy1VLtydC5ZQT8/HYBML0v7lLZPwkCTbdxzTBwkgQVEsmYCoef1t8x4BkB2Jq+oKBZz8a9jaoyIzvfOVrk5Z09RQHHobDf0jIzc/NLFey2jbkLtWkYVK6vlLpA262+c2yvTxmWInavKKhUk4NbI+iVMMU3a5RGtZlOgknpvhcYx9C9Bihw4v/G/y3/vjCPTK/HC9weNlgcGIEAcKvMyzoXXnYsutM4Maok33iHoeKH+YcXjxmjEFPcxP+oIwZQx6PrG94XEmT0F7JdJI7Be3z0sY7rN/emC0QppVvdP0+ztLNtYYUoiXL6hhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cC6yZJ+t3AFwFKQExmklNrnrMDkkM5wxIN6PfYVSNHM=;
 b=ns33KVar9ZOHbV1NgDWycGtMrJ02PyPOihIk+uowPNxCP6Qh8oau/9+/rFJfFPpC/6u+ugF3EHi6U/7+ikgqCmc/PyF7aJCDgiLwfhabIkKIyM/8HJvSuorqTk/TcvNhuIdMcctjw8pRh7woSZLWKwOKVAlUsIESgPiq7hiB/51g0DG3bqBm4GpG4wYXtHHwjbr/L2HzxkjHYfoyEWhiMQZbJ8pbrfrQpNrb31xbBMGrb08bNrLqnMWsYOsEryNKZl8fUuv1k9L0ClYnT342tPD136Bpiy4Ub9yKTpeJqxhMlogjfFhGxw89Af0gBEYnXUzsJbRFB1FNSm+XMoM2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by CO1PR15MB4860.namprd15.prod.outlook.com (2603:10b6:303:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 01:11:57 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 01:11:57 +0000
Message-ID: <5918e491-f3fa-4123-8cb6-42436346cca6@meta.com>
Date: Mon, 1 Dec 2025 20:11:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1 2/2] selftests/bpf: Test using cgroup storage in a
 tail call callee program
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org
Cc: Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team
 <kernel-team@meta.com>,
        Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Ihor Solodrai <ihor.solodrai@linux.dev>
References: <20251202001822.2769330-2-ameryhung@gmail.com>
 <d396eeba7daf48c871d9690857c060e4080489c5f5da9841ca186c6442bc205b@mail.kernel.org>
 <CAADnVQ+NHPc03DEFfB0Txaza8r+vWSM=jivKg=KApKzF+qvzcw@mail.gmail.com>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <CAADnVQ+NHPc03DEFfB0Txaza8r+vWSM=jivKg=KApKzF+qvzcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::11) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|CO1PR15MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: b16c1d27-bde2-4880-b102-08de313fc996
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amhiT0E1WGppdTVBSldYNGRmUmpWeGdyenNiUlJmR1FtZ3VPcVpSQmdxVWxV?=
 =?utf-8?B?amNYYlllUk1WZGIzb0hVcHpaZEFubW5Jd2pCcTlab0ZqQ2t5ay9mc2NyMitH?=
 =?utf-8?B?aXZNSzJnSmtrYUVOa00wVWQ2QzdFUCt2SmJLMDVrdDVPSnE2ckRxcWFhbElJ?=
 =?utf-8?B?cjh1WmNTVTRYSUQ5bFEvUXBlMlBRSzdNMkEzRHFyMlFYWjVJR3VoWHNMNC9Y?=
 =?utf-8?B?S285c2hvVzhUZllmWkZTdjV3a1p0L1FjMUJodGlldEVPVXBqSHUvUnBsVnZs?=
 =?utf-8?B?REhjQUU0cEJydjlIZ3JUSGpZWHVPK0RNZFQvVER3VE85V3pqZ3B5WVh4WDdT?=
 =?utf-8?B?UHM1d1VNcEFEZzJjbXdHRTZqdFFJZWg3eGZpcVdudjFvM1BkRDRZUU5pRVl3?=
 =?utf-8?B?OS9PZlQxQVlZL0hlSlMyQTlkK1o2OGFVTlB1WHpGbWpNc3lodmU5ZmhlSlBD?=
 =?utf-8?B?a1hLbUhCRkNpdUNhQUxUS3h6eklUalYzUWxsSWlPUjk0bE82Ty9aMWNhQmVp?=
 =?utf-8?B?eDhhVnplb3NXL2wrSVdJTGk3VkdHdUJHS2NBR1lwb2VnUitQSElPd3VXRHNa?=
 =?utf-8?B?WkRYVUh0c2lHQVU1a0FrNzhTb250K1JnMFkvbXZvRStzM0tFUVZZZytBVmF1?=
 =?utf-8?B?eDBOSlViZXFPSGFNQmRRSWlXajVBY21iNXM0WmFIdmRaMTYzRDBBOFFlczVN?=
 =?utf-8?B?NXR0WG5qSXhuQTlDQ09XTkV5SnNVZGdJSzZ5SmRic09CcStpQStNc21CenlR?=
 =?utf-8?B?aE9RYVIzZWNxNXVDN3JuZ2x1V0xHZzFZOFNJMWxvb2JXWDZPMlhZN2VVdk8y?=
 =?utf-8?B?LzI5QzR0SWdZRmVhcXVaMXIxNGZkSU1yZEsxcmdab1E4M1JSOUVYcStiYWRU?=
 =?utf-8?B?dVdxR0dsenFTQ1ZyNGJZL3Q5QWZXcktzZlJUOVYwaDhpY29ja0Y3Wm9wdzlu?=
 =?utf-8?B?dk5sVm9Zb0J4U29BVUk2dUgrMG9VMXU0UCtEcDhsTkJ5cElZT2pDMHlFZlZT?=
 =?utf-8?B?V0hKemZ6V1dpaHlkajd6R1IyOC9TeDRoV3B4a0M3WUhGS00vTlJNVlgvamxn?=
 =?utf-8?B?bzhLVDh5QjZxQk5rVVNUb0h0VkRHYzNzZ0dBdStuZUZTVTJJSmQ4dytUREpt?=
 =?utf-8?B?U21Rd3RiVmdVV2p5VVZYekoyK293a3BuRzh0Q3h6YytRUHdnM1JFblVkUTJX?=
 =?utf-8?B?Vlkxc0F0QzYxa1JmUmpnM2NySERwanhRQjZ1YnhzbVRhWUFHNnhrSDI2eG14?=
 =?utf-8?B?VlduK212WkZUaVJ2d1pVZWF0c3BPaHR1RmxtaHZ6bWN4UVVGb2N5aXR4WmJl?=
 =?utf-8?B?UHRyVEgvUm9WV2NlREZ2emJGcVVoYjg5VlB5bkp3QXR2YkhwWWhGVkFrRjli?=
 =?utf-8?B?ZzhxTVI0MENuNThOMzdCcUs4cTM2T3VWV3BHMXoybjZ3bHZoMXZOcnV2R3RV?=
 =?utf-8?B?NWxiaDdVNGgxeGxjQjJjUy9XWGFySG1vZG1jR3N0eVhsSm11YnhZWDVORHJV?=
 =?utf-8?B?dFJaQmxxbkxBanBEUjZJRzJUcUZOMDJOemo5Z0dEQlh3KzRNTUFFd3k1ZGxB?=
 =?utf-8?B?UjArUjdPMElLcnZNQTluZFpoMEppOWJQM0dSMDBtYzB2YjBFSE1aK09SR3cw?=
 =?utf-8?B?Q2hRUjNxOFdKN3hNU2dkZ3FmOVd5ZnVtNEoyZkVLYVRVaDBCTU51dVRuSWJJ?=
 =?utf-8?B?dXFFRmVGSW1wemp2RzlxdjBVR05wOFlGMFN3S3IrUzkxTE9QZDVyN1Z2NElq?=
 =?utf-8?B?VndlU1F1Y0JoRFRMVmNLaTNOK2F1eUNzd3BnMWZERHZ3MlBnenNtYXJZbXNX?=
 =?utf-8?B?R3dIbGVkODNVdGlqSXdrUVUwazRkelA1bENEcDViM3ZjYytsVC9BeEZDTGZU?=
 =?utf-8?B?Y3BMWDd0bEFNYmIvMGNWdFBLbmJHTW1RSituWEp1UmhSOHdhbElKT2p2WGxi?=
 =?utf-8?Q?88jOtfulqn9UGAS07+NZHWnxZXo77fij?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEJjUGp3dmJWdno0R2FoZkV6VVNRb1h3bXAyalFSQjFZc0ZmaWdoQzc5eXhI?=
 =?utf-8?B?TklRSVZZMmNBdWh6eVJURjRZRHI4ZjI2VlY3TU45YXpIT0t1VithS0Z3Umh0?=
 =?utf-8?B?R1JVQ2x5a0dUWU1ZbHlnSE00VzJqMzBtWjhuNDZxdzhQOWxQYUUyeXZ2bEtS?=
 =?utf-8?B?SC8yMWl3d05qVS9aYWpuaVNEb2hOalNxREI0Y2dsdkQyNjRlM0lxTEZHclZz?=
 =?utf-8?B?eXFpdTVWWGk4Z1ZoQS9JcHMxc1o4UkZVTjZhNmNvRGdEUW1MWFRVd0VKZmw4?=
 =?utf-8?B?RGk0NXpST2IrbWJTUmJEMXJuYnR2QS9YcGxna3BCbVp4L0RwRG1xQzJyQi91?=
 =?utf-8?B?UDlUUW5zZlRhek9kbEZLYklUWStVd2xHUUxYOGh2NUNTVFgySnhkQWVrZnRo?=
 =?utf-8?B?YWYzbDVsWEJRZXkwWW5YZk41ZVRDdVVtbXBrY3BFbCt2Yzg0M0xNem9sZkdR?=
 =?utf-8?B?cWlWV2ljWDFGME85RGdqTUlNY3J5NWdndTNLbEpWSGswbTZBWGg1RTh5ejdK?=
 =?utf-8?B?TFVqL01OcVU1ZGppZkUwdmh1V291NVBxT2F1b3JYUFk3TVJNLzBXMGpBaFBH?=
 =?utf-8?B?YlpQM0pIR1F4emQvVDJISVNXYlE2MndqOUgvb2N6cllHaUtuZGtxazFEdlVU?=
 =?utf-8?B?ejQ2STRYZjZqNEt1clBwdHdqK0pNcEw1OG0zbGh1UkhKK1l5dGJqb1JaWDls?=
 =?utf-8?B?VXkxMjdyVlBWVlMxQW4waTgyTTJPOERBSTN6SFdwK0RSVGlmcEgybEJGVEFh?=
 =?utf-8?B?c2w2SERndjcwaWdlbFJoNFlnSUl1SDYralN6dEFhSE0yazFwQnZtNnMyMjRr?=
 =?utf-8?B?eXlnR0kxVUgrUGcxeWZxSytpUHRTR0N0bTFJL2ZRcGtpeGpKWU9NYnpvZ1BC?=
 =?utf-8?B?aHp2RGZkeUxvdVZibkdFanc3SGYzUVJBWDBveE9pSHRsZVhXMFpyTFAwandH?=
 =?utf-8?B?WjJzQW5IVVVZaWpkR3JncndJTkIxN21jSkJUajFVNlIyZDlwMWdRajlESExQ?=
 =?utf-8?B?VmlyaU5vY0FGbXVIaFFxVjZpQjJtUFU5VUdCY2lVRVBXOUdtVGV0dDE1aEJs?=
 =?utf-8?B?Z2NyL3ZPMHFmY1k5WDY4T1I5cS9aUzg5N2VGWVZuOVhiMmFaY21DZnFWeDl5?=
 =?utf-8?B?dUo0QUFyaHhVWE9veElqUmt0WnZnRmVZK3QxSXZXL2ZQMGlqckxGc0RKdHNj?=
 =?utf-8?B?V2xoUmRUS2xjcnozRnB0NnJ0bWJUN2I3Y1NJZEJLOEV4dU52TjVmNXJGL2xE?=
 =?utf-8?B?NHlFYzd3RjdSeXgzd1R3OEZYaGhpczhhanZOMERBWHRjZGxWUEZibTdIR2hM?=
 =?utf-8?B?cTFLNllBclhueHlVYnlBRXVSdmF3cWNWRXRUQlRSWWt4ZlhkUTFDUjlsc3gy?=
 =?utf-8?B?cTB1Wmp4emV5Z0M2WkloY1dqMVlpdkRqZjhJZFM4NzZhekdmQ3ZhNXJSQ1No?=
 =?utf-8?B?Zk8yZmNCY2o2cXVWZ1JWYWdnQ2N5OExzZVZzemRqT3ZKV0ZYSjBFRFVWS2Fo?=
 =?utf-8?B?ZFFBSWZjelVldjRVMnhDMGoxdmxhWVRvVTEwd3cwZUd5ZHBydlpoWTV3VEJW?=
 =?utf-8?B?SGVoZWpkTkt0Wm8rdC8rbWYrSEJMeHZFRnVLMjQ4VWNxV1NScVNzMGR0RnQ2?=
 =?utf-8?B?L0ZpRWhzZ2VtMktsR1YwYVpLQ08yMDAyNXNPQ0hIalNWTHpjQjZrMkIvYm1L?=
 =?utf-8?B?Vm9PQkt2TWgwdXhqdVFKSThiMnVIMFJ3S3cwM1pVbk5PUHp5SlFiTE1kU1N5?=
 =?utf-8?B?Wlc1aTFlREZlN2o0OG9IRTRxSWExUXp2Mi80QWRhQVJneU1BVkp0Z0xIQmJl?=
 =?utf-8?B?Z2FXeEJCbXBTNlNlUlNYaWV3Y1hiWFArQ2NPTFJ4YXkwVmtiMlhpbDZhakVn?=
 =?utf-8?B?VTI5d3ZXUUdHMHg3RW9lamt1RTRSbWE1ZnlUTmZ4U0k4elF2dk5ZM24rVlM2?=
 =?utf-8?B?dGZoV3E1SHhZU2JHRmdUdmFTQ3Jqd252S1hOMTE1c2RtdkJlUmsvRE9BK2E4?=
 =?utf-8?B?UFNFUlpNSFVua200SVptbXVsU0diVFRpZTNCL09sZkNKWVRjcDlKSU1OUGlF?=
 =?utf-8?B?NXltN0NQWlJCRUY1eE5QcmRMQldPTzU4RU5hc1l5RGZFVS9CalA0eXdFR3R1?=
 =?utf-8?Q?oHJs=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16c1d27-bde2-4880-b102-08de313fc996
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 01:11:56.9931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAQva448/kZBRbLoTn+NHvKytf4Yeb0rBbzxbHgQ9AkBEq+R+izvJItzHXVgEoVR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4860
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDAwNiBTYWx0ZWRfX3nRu45mVSFqZ
 hmTczONK4WftelYK5RF//uPT1FcWqxp7o2Gvp33UI6EevwT3YaDZch3HAkQjfF7t8w1qYh0LzP7
 AfQS4j8UnqXz+J2oyfFCBwgNSD9J10KgdFYPaF2BdU9FlKKpwKyRf7sDtbWS6XXVIKJOJmMFbMj
 E8831AxYv+mD+tEg9QziDK7vZWdThqZriW91xRBTqFcK/e44VVWmouqL92RV49vRIUA3bQoVuSp
 4g5ioy6CS6PP+hNos0NvSQ20vKb0+D6z7WvrRn+WCkTZMsWLs4tU/D7sVvtoBxuXClW6YHBrgKB
 ONFYHh/vTlHSt3TBrt/hfCQz0uRcTSlnOGGq+Tcf3yzc6+sjEmtv+NT1snm7DvCjVf/iM1dncqV
 H7oRO5oG8+8s/cAdB1m+KLJ7MTcxoA==
X-Authority-Analysis: v=2.4 cv=CecFJbrl c=1 sm=1 tr=0 ts=692e3cdf cx=c_pps
 a=6O9SViV89A8ZJb2Gg0v8VA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=PNiuXHj8fdbfLyAWz_4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ETJOvNUWgmZOO3Rm16PtkcMXZ28z-VHm
X-Proofpoint-ORIG-GUID: ETJOvNUWgmZOO3Rm16PtkcMXZ28z-VHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01

On 12/1/25 8:09 PM, Alexei Starovoitov wrote:
> On Mon, Dec 1, 2025 at 4:35 PM <bot+bpf-ci@kernel.org> wrote:
>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>>> index 0ab36503c..e4a5287f1 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>>
>> [ ... ]
>>
>>> @@ -1648,6 +1649,28 @@ static void test_tailcall_bpf2bpf_freplace(void)
>>>       tc_bpf2bpf__destroy(tc_skel);
>>>  }
>>>
>>> +/*
>>> + * test_tail_call_cgrp_storage makes sure that callee programs cannot
>>> + * use cgroup storage
>>> + */
>>> +static void test_tailcall_cgrp_storage(void)
>>> +{
>>> +     int err, prog_fd, prog_array_fd, key = 0;
>>> +     struct tailcall_cgrp_storage *skel;
>>> +
>>> +     skel = tailcall_cgrp_storage__open_and_load();
>>> +     if (!ASSERT_OK_PTR(skel, "tailcall_cgrp_storage__open_and_load"))
>>> +             return;
>>> +
>>> +     prog_fd = bpf_program__fd(skel->progs.callee_prog);
>>> +     prog_array_fd = bpf_map__fd(skel->maps.prog_array);
>>                      ^^^^
>>
>> Should the return values of bpf_program__fd() and bpf_map__fd() be
>> checked before use? Other tests in this file validate these return
>> values (see test_tailcall_1 and similar tests which check for < 0).
>>
>> Without checking, if either function returns a negative error value,
>> bpf_map_update_elem() could fail for the wrong reason (invalid FD),
>> and ASSERT_ERR would still pass, potentially masking issues with the
>> actual kernel restriction being tested.
> 
> Chris,
> 
> note... AI is wrong here.
> We don't check FDs returned by these getters because skeleton open_and_load()
> succeeded.

Thanks Alexei, I'll fix this up.

-chris


