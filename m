Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FAA478132
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhLQAVk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:21:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18558 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229504AbhLQAVj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 19:21:39 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BGHNjZ7024050;
        Thu, 16 Dec 2021 16:21:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mWI5kALHQSM85kyL/x7CLfnm4UpqRekrOpNvBQ4zt9c=;
 b=BgMKgi5ZoARPw2n8j+GNS5e1/alRCVVns0a0+ofbyS+cEc0PjZ6Jsm54ZHSN8/W+5vJ+
 oBZ+gNu+DwlhQLcbdtenVjo2WAivoQkDkTrR0L2lEnfBzSrvzPt9rhLPAZ5QMTzZ01Fq
 U7r0qFAzu/fDKw1CiK5xrz3Rs8sBPdafMTk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3d00nn6w9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Dec 2021 16:21:26 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 16:21:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIXYvnaWnPNwX2ljlqvciF1sFCHVI3dNKHfZAGldP/KKcB3eH7DqSRJWV+BdRwFXdc09jnAbe7o89hGnxKw1Tj09/T7C/gIln3n1y2cE5QnZOJp5wJMCfkuvh2L7wkJ2Y49Vfjh+sRMy3e9lHrHwGjkVxEqnSgM1kP6SE/Vm2ggqXg9FZ1XJv9mhBHpWH1X33RvlWcOBweEVhVdOakTbh95bddpY8iZg3j65zIMufYxeOU1YdKQ54/sOacEzNGNd6j06AgPOxQpr2RRDRyyKM11MW+LM/WetCEN9oazH8vsNnEelfaUXeAraAiEco82lJ1EK+2pDqOUT3xzTkbktmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWI5kALHQSM85kyL/x7CLfnm4UpqRekrOpNvBQ4zt9c=;
 b=PMKfKZIC6r+6BXWuGGhC6sgO0uZnBUMz83r65rwo8ozlp3wRejPLkdcMqPPW3VjfAEu4QU8hHb0svXjQEH09VdDHU6m2an2QoHeYA6CReBcwM/e0F/ft0OoWgBnnk+WlW/3jHbAMdTqmAOnwxsQ8tLEZVfABslg6agIcSMXHc551ADtVafq2cOf/KutFxlq5FmM4Pq+/++w5ERvnFSrr/nNESpiiPijWIS+9kUuW8rYGEGDnh4ixh61m97Lo/eTmVGNFXSHaArYmKPQlauf9Gsf7NXbIiCRbKLszJ2vy84I9kyseFw5u8CkRwWGrI7QI5+1esL+sja70W6p9yDJHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1596.namprd15.prod.outlook.com (2603:10b6:3:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Fri, 17 Dec 2021 00:21:24 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::755e:51ae:f6c:3953%7]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 00:21:24 +0000
Message-ID: <b183b2b8-3bff-f647-678f-40b479c9c5c5@fb.com>
Date:   Thu, 16 Dec 2021 19:21:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: add libbpf feature-probing
 API selftests
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211216070442.1492204-1-andrii@kernel.org>
 <20211216070442.1492204-3-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211216070442.1492204-3-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:208:120::19) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aabc6217-8999-477b-a48e-08d9c0f328df
X-MS-TrafficTypeDiagnostic: DM5PR15MB1596:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB159610CA2D74C465B196D9AEA0789@DM5PR15MB1596.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0kmKN6czQh4sca9FDQonROXeGfy+ZED4Ibf3daw00k1m8jRzY//2Pz3tuwV7cJjVWbUq3GptqZ5y77ncveAA67fbzQqFkGewJbSROlFNp/QhpelZ8zqr37qfe+j+RZfkShy6anKDGSMdRcvKcyl7AcIu4rrmgVU0IUohNDRmX4A/vr2C+RSaGMnY3IW2R13KlLq0d8s1c7iYRZtSGp0ThvGOeiYDIdhMhNv36CDQXEmo9CVRG1Azl89h6pcUms63ommRx/BAYgY+YGvKNUNJImSwnbbQA9+4AcQ+A0ckp1nTe4rgizrxtuRcYDPYyfhoQPmRnrQAl8mCEmlFgHgT0AAoIepRbq7mnPoa0Vcl46CHmlSkAnoUHAT+FS87lJhmOOFOK8kBz7425bT+wxU0Qh4pRPVf9pQbrOP2qqoQBgdza+tYqnVXLsQJglWP7nXvEnGxBSO4QNgfyNR1inIbZM+WoIP6znnA/Arv195MafNRmI9nja2de9gcG1s87cZQsx4jEnE8h3wjTt5Vn2qKnDA9T27Ulest8Msv1TCDqfOdfsvsHMEqsRx94l/m6MWuQQg2lSrHV0T2x7+Lj4dX/pPy9yzSABcxB9LsyYeQ0i/MxeTYRScMmz3+r3bgmnfCkO96PoGk9tIdf63X6AKRSk6H02fovNIpV0hjpTWjzpNrVFfpbwwdpDp/OjnK7g3ZP33TAmYsDEMScqmf1GBVFW27bCsVWwZFt0ydvsQLlE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2906002)(83380400001)(31686004)(4326008)(316002)(8676002)(86362001)(66476007)(66556008)(66946007)(53546011)(6506007)(186003)(6512007)(31696002)(6666004)(36756003)(508600001)(2616005)(38100700002)(6486002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU5kMEN6TitoWmdVMlZuL2MrU2lGbkEwK0xZazRmL1k4TjBKMjhBb2ZGVVlp?=
 =?utf-8?B?bXJ3aEhZd2U0ZnlqK1pKTEc0OWFaK2F3U3VjMFIraDJTNFJ2bUZhaExDbDV4?=
 =?utf-8?B?QnRjeEZCWlhjTVVHeURWeStIb09kNUltYnY1VVVNbUI5ODJqOW5qbFBQV2x3?=
 =?utf-8?B?UUd0STJ1OFpyV3QyQkpnZG1VaTNMM05YV3JBc2g4Z25BMkJGZks2ZkFQR0dN?=
 =?utf-8?B?UVAxM2QySjAxZW5rcVE5RFNMeEsyZktyd012MTR5MStNSWV3bUg4aWl3dUxT?=
 =?utf-8?B?TTBUbk9pcytQT21qa3pnZXhLSFhTSzJOTTN0WGNTYkh5SkZSZXk5QVFvY2pQ?=
 =?utf-8?B?VW5JMTVtK24ySGVVT3RPbFpnT2FyU2FkVVE2RzJTNE9pUlNXQlNLaGVRQmVw?=
 =?utf-8?B?dnpJOE9OcU1OODVqRjBxYXA2UllxdnI0d1lIWllhMVRrc0R4ejZUbmJQa2V5?=
 =?utf-8?B?VXZuR3RKTW5HTHNRNE0xaTNGKzRBUTZ3eE8zZVlzNi9zaEw1S3J0UWFvRkhS?=
 =?utf-8?B?QWRjTThzakI4TnBUTHQwU0pZWDdUQWNsT2d0YVYvWFdtbFBiV1lrV1REbFht?=
 =?utf-8?B?ZFh0NTJXclRvN25KV01Vbm1NYWYxdWIyRGtmVW9EMkdwVm9VM1JwTGhFelNU?=
 =?utf-8?B?VjlTWUdMZk5ValNETEk4WTc5VDdXTWs1Tnk2ZFhBaEJFa3dla3NHVDMvdDdk?=
 =?utf-8?B?Wml0dERRS1o2UzBGRVdpWThWUlZDc0ttUklEREt0NkVUY000UzQvQ1pkTXdF?=
 =?utf-8?B?R3ZBZW1XWFozWlNVZUEwWnpnS1R1d0xhUldmdkM2bkovTTdxbm1GUEQ1WEF2?=
 =?utf-8?B?eU1xb0JuMkpNcXBOK2Y4UlNKZ3REVHVMbzNCakgwUGN4NUYyaHNNa0taY0U5?=
 =?utf-8?B?T3pyRWlpR2E4SDBDNER3YjFUQnNIOGZReW1rcDNLenBXTXBDUk1iQklDTyt0?=
 =?utf-8?B?bmY5K2FWTjFSSEZzd2FFRGJoUmdLSjV2Z1hieFI0Zm9UR2xad3V4amFDYmhB?=
 =?utf-8?B?aGl1UmYwQXZTV3ZnaTlGSjBMVVdRUThwQUc3SzgzN2RodU0rL0l3N3ErSTRV?=
 =?utf-8?B?UUtIa1h4Ky9Ib2lPUXVzd0xveGpneXlNbG1JZmcwclQvVE5LenZiT2RWeGNz?=
 =?utf-8?B?Z2U0VHVzQlBWSzNjblkzTXlvdTNjcGorRVo5elNuRnU0RFI5OFhUTkpmMGVR?=
 =?utf-8?B?TzhGYnVmYnhPSDhIa2NNbEJERE1HV1FocVNRUHpBRXZ3UDlMUFdpTzdrdWUz?=
 =?utf-8?B?YzlYV2pBQ3l2WnVMSWc4bFR2aTBDMWFOZDZ6Mjl1Zk1DOTRxTUF1RWFScHBl?=
 =?utf-8?B?c3BKSU10a2FlRTZOTWpQVHpNSE9xSDVSanJaSks0NkFuTUFid2czZ09zUFU1?=
 =?utf-8?B?UEl6VmJrOUJVNlcxaDdwRDZ2M0lkVDZPYTZHSi9nbmZCdk9GYkNFRUpVQ1Vw?=
 =?utf-8?B?MDI2b2FyLzVhZUFza0ZBRHM3OXgxWVd3UW1UUjkzdFhYMEt2dHR3cmNvYWFC?=
 =?utf-8?B?OE1sMHoxY20rQnduREhhWnhsNXJIY1Q4TUpRZlBkbVozTVRMSE16WUg4d2VU?=
 =?utf-8?B?SkdKVGhkSjRZMmlJUFRUSlhoVGI3bExlYkdFckRIUUg4RjBMRXJEaUxmUlJH?=
 =?utf-8?B?Uzh3bnNseUJlNEwvY0o3ZkE4TTFkRk41ZklQc3M0VlVhU1RHUkVCNTFndUov?=
 =?utf-8?B?RTRTc0FsRjVqMUFERGRGL0lMQlpYUUlpaFNXeG5VUUM3MEdQcTVFSmRBTWJl?=
 =?utf-8?B?TnhSRkNCQitXZlpBaTFlenNORTh1ODdoVXVPVmRQYjhXaFVCd05pSFlMR2FO?=
 =?utf-8?B?Q1FFMlpOVTRaenNyUUdSZS9ORTlaRUwvMW1XVzNiWmphdEFpMzhPWElYcG5r?=
 =?utf-8?B?NVlYUFh1cHBxNk81UmhtN2Izdnl6K0hVUFlkL0tVNnlESjhGUlBkdXowdlFK?=
 =?utf-8?B?WnF4QmNkbmJsMWN1UUdFV29mR084WVRWMk5NQkpLOGZVaURXUkwzQ1M0YnBq?=
 =?utf-8?B?Q0lQRU50VlU3TVpPZ0k1RVljdmoraWtWVktONGRPcWZRdGh4Q1hHaWN4a0hZ?=
 =?utf-8?B?LzhBTHJKMnY2U0haQldBaExqRzF3SmRxUkNUYkhXOXlPcC9IMitWWGRSL09O?=
 =?utf-8?B?SEU1VjlKcmVXSi9kQnRyd05LOERydklsbW5XTHVBazY5Q2RvOXpxbCtXbWlR?=
 =?utf-8?Q?EmUblwFOcH2bdZuaSJfADBP6g4qnZITOSCuTnuxLsQ5g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aabc6217-8999-477b-a48e-08d9c0f328df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 00:21:24.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1PCJ5LUJfQ4ZRrQpZpED4bVBEurF2qfhhx8vqrOsYqx/c9uenqjE7ohCsbk/oFYJ6tHUphgqbqwpLmGJdEq0og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1596
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 8ZcYntoONZq-Ub2pz6S8xbmZinHQR-61
X-Proofpoint-ORIG-GUID: 8ZcYntoONZq-Ub2pz6S8xbmZinHQR-61
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_09,2021-12-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=755 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112170000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/16/21 2:04 AM, Andrii Nakryiko wrote:   
> Add selftests for prog/map/prog+helper feature probing APIs. Prog and
> map selftests are designed in such a way that they will always test all
> the possible prog/map types, based on running kernel's vmlinux BTF enum
> definition. This way we'll always be sure that when adding new BPF
> program types or map types, libbpf will be always updated accordingly to
> be able to feature-detect them.
> 
> BPF prog_helper selftest will have to be manually extended with
> interesting and important prog+helper combinations, it's easy, but can't
> be completely automated.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

[...]

> +	for (e = btf_enum(t), i = 0, n = btf_vlen(t); i < n; e++, i++) {
> +		const char *prog_type_name = btf__str_by_offset(btf, e->name_off);
> +		enum bpf_prog_type prog_type = (enum bpf_prog_type)e->val;
> +		int res;
> +
> +		if (prog_type == BPF_PROG_TYPE_UNSPEC)
> +			continue;
> +
> +		if (!test__start_subtest(prog_type_name))
> +			continue;
> +
> +		res = libbpf_probe_bpf_prog_type(prog_type, NULL);
> +		ASSERT_EQ(res, 1, prog_type_name);
> +	}

I like how easy BTF makes this.
Maybe worth trying to probe one-past-the-end of enum to confirm it fails as
expected?

Regardless,

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

> +cleanup:
> +	btf__free(btf);
> +}

[...]
