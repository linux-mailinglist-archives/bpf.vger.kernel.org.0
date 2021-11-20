Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7FD457C3E
	for <lists+bpf@lfdr.de>; Sat, 20 Nov 2021 08:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhKTHqm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Nov 2021 02:46:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18616 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229592AbhKTHql (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 20 Nov 2021 02:46:41 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AK4wonD026634
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 23:43:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=fRIyj6gY7ca3vDQ9RmTVJ6eVjyKr7dLztHE8t1HceI4=;
 b=ES+HGGdgmXodJQjo3bQ0Fs/1+j0d6kJ0CNIcINSIkwWIFNPm2fv/uRlOwJcGRhNGN0iH
 mVD5iVwqLc4Y7m4BiKDX7Hs9coS0oXfdjajCnkIK8LZksbAZmPlgAeTaCpLV3tE7wz8z
 aJ6+aOJ1cZCbuWut6PYfxkHTZfMiZlZKUFc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cee525dqs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 23:43:38 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 19 Nov 2021 23:43:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irOdSeyfR0oz1D6PQM/cxddbmfKqoa9O4MHASPMC4tJR25F3ypDsMroPSJBvU15o1nbB+M1ZjKkJC8iFJQwVy8Cp3eEbcvcedBWXMZaLoN9wO7vLMKIbfHmvuzdjkjzERKnd7fe4MMk6ymZMva/0Dtjk6atzRn9Y1VLckG0OYMQdpNA3kUcNyqqQ2tIsFL0zAuRHf7uiYHSYEDmoCulxl9HAB5Wf6AWiYQvgTZQu36NGyS1RaEwpLSSxO2tpywGUwHcKmy3aTx03ZYnAW1CudzAF9N3wjayroc5RnPoAQ0Zg01spJx3MQNsJ+TRULtjBJoNPmjf2rVnVjHmG+RMuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRIyj6gY7ca3vDQ9RmTVJ6eVjyKr7dLztHE8t1HceI4=;
 b=PERkJfUn2OnazaDd1uOlY8guREw9pDjeSjz64CDnEVUGiorIJ7YX3rZV490adSrRZhc1YN52FZz8VdM7FXZb6w06godWbpDy3i5ItXKEjOEVuo4cvDdQOKvJ2YOV99HWpP7/8RsC+037m3wQ3ERdi/9cmuD99txTtBGUp76e0ZGT/kwBmVrr2Lv3cvjic/9sCKL9b0mOIIR8mGR8kJ+HH6v+NaUi+Z5REFHczztK0kHSM9PpinGKBL6r30C1cK+xMhKkDQxq7rOsMzGbj/j0GU0gxoavO951IbdeCDhUABXdlz+ra7qVEEuuTv5eodXxcgpMXdvdx1L2GECd5xyYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5257.namprd15.prod.outlook.com (2603:10b6:806:229::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Sat, 20 Nov
 2021 07:43:34 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%4]) with mapi id 15.20.4713.024; Sat, 20 Nov 2021
 07:43:34 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: mix legacy (maps) and modern
 (vars) BPF in one test
Thread-Topic: [PATCH bpf-next 2/2] selftests/bpf: mix legacy (maps) and modern
 (vars) BPF in one test
Thread-Index: AQHX3awOXRhSN8JBkEC9OQY2WcoNSKwMCUkA
Date:   Sat, 20 Nov 2021 07:43:34 +0000
Message-ID: <C867ED10-BA7E-4227-B430-27E54F5CAEB1@fb.com>
References: <20211120011455.3679237-1-andrii@kernel.org>
 <20211120011455.3679237-2-andrii@kernel.org>
In-Reply-To: <20211120011455.3679237-2-andrii@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8edb2f2e-ed5e-454f-4ad6-08d9abf9750b
x-ms-traffictypediagnostic: SA1PR15MB5257:
x-microsoft-antispam-prvs: <SA1PR15MB5257BAB16635A0483CCAB616B39D9@SA1PR15MB5257.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sM1QO4VtLiaGoTQ6El7ICJZGZJNxeTqbPuxp2mw7mcAIBg141hgznTE6JbxWW3v6PJNkRKps/bWME8vE4XSTz+YY8sLs94z76u2+a6cwvi5HFICF/wXWXSbsQgkvi0G8NN0PxRcL0RwkG0iYsLsyS1K9KqePqnlOL5UGSLHE+ZxXfweNulPc+qmLiJhpsCeu7RN4XLZXFQI7mBA0NIv1uhEsSWzNYX8vlAzaHMhrhSsgnxYIDXnk+XENa+PiGlqXRnlxiW2U+w/MqiAFLk052wa8bGIoLrVUyKmBTY1j7MTC+W/BFbF/Hb0bgHbXlzD1wt0AKIizQIWoW5G6LcbPb19M3g0gKTd6TAoHfaMuTuwWeUkMYp+vzEfLri35HyK6wBmk8j0MCSxbK4vsA3jpKkpT6MLZ2yltYOiwaHLT8viJ2KF09dhYiF7UFUyIXElJacQ7zbjTb926tI552X9z2s6l2WFkg/PEAS+Vz71oc48P/RYqIiZub29BruwkdcpjG69HMi74UsX7YZwbS6lBD/Gw09Bn1tH1FXiZ/mNgZ5qmh72Cf8L97PrlWA+F4zPjuVqWMydQ8WM05MsOESJhgX+o67zdnNhDfDmsKBuSZVLMh3ES/iRzlFPQBH4n/IQEHPLF2YYUbUSmW8mrD+E7gtzctVnRon2g9Y+CVbYQBq3jW9nOGixwxDc4zF53LGb4yXkSBJ0rcqHFb0r0K8kwmDPAtdhyxInXdjTcakcZGsLLeXROBXeYky/msK0hGXVQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(2616005)(54906003)(38070700005)(508600001)(86362001)(6512007)(8676002)(2906002)(6506007)(71200400001)(83380400001)(66446008)(316002)(64756008)(186003)(36756003)(33656002)(122000001)(4326008)(76116006)(6916009)(8936002)(53546011)(6486002)(38100700002)(91956017)(66946007)(66476007)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o8HHsKYwMQvFJVAAtnVrSjFOdgceb93rM6wBOftF2Ji+R3o2e00ZV15+Cjr+?=
 =?us-ascii?Q?sLRDpGXjOv3i502u22Fp1wrK0ejewYMmN4Sqc1P/9b4481VrE3wvbrtTFiQy?=
 =?us-ascii?Q?DGnuZi4XB/72ApmtDUnHMrdzU3G9/NZRE23Q56dkZFX/Sr7bYb6tVNZLZ8JF?=
 =?us-ascii?Q?fkby4XuY+N+P8NQAA1JVvWG0jf6M2egrRfaqKtaNTvUCtsqZtpO18rI9668l?=
 =?us-ascii?Q?np93Zi6z8X6+t6tksisZqcRiWE+wSS8ganVXznTbUFFsE5IVA6H8B4B47AcQ?=
 =?us-ascii?Q?AXShOfpF5SdjS6/tOJIYO6LR9WWAv2q73vhTz1zdRitiaKkEfA0dX3q6AHC2?=
 =?us-ascii?Q?UY769OXkxIGflg9dc7B/mkfpdXbOjSXnoeKVA6xbWrPjCw/GlUxXHdhM3GLb?=
 =?us-ascii?Q?SsV8iHlQWG5Rs2EEwYpBMHBmiefzIari3toyrUoCoqyneAteM8iPF9wAELoU?=
 =?us-ascii?Q?uNO6/f+1f+0fzMGIXXOInVOgUdHeEmREII7V9PTeIpBpaoWF6KGZ+3bQm+QF?=
 =?us-ascii?Q?rywcb2rYtd8MCYR6LFDkgu8Ek3YLbYhygPfvNF1cJK4QPpGe1WSGA+tccHSx?=
 =?us-ascii?Q?Ezis/qT8fMFxuBTTGsaH52+JYtrWIxfXuL9EhK/OVOi3rC4zaslhSrQ9GXnW?=
 =?us-ascii?Q?EVqRLXLdHD1d/YsG435ZCJvel890fJ7XvreBkO47tP5of9NaQg/2NmKTQ2AQ?=
 =?us-ascii?Q?A7j8TwNM6nDF0THrbtL8Le9V/qWzwayh9uRCpcHVLKdnudqQIn6C3+6QE01U?=
 =?us-ascii?Q?ikBAonb9vV3w7mP7eh3qSW59oVxD83O+/kt0oeHCmid7P7Z0x0sHExPG0R1s?=
 =?us-ascii?Q?NT85vaJLgo5WI0tIu3JtgZhpeoOCrD/NWXHh/IFYnF0iQMPUdNYiGTm8q7cX?=
 =?us-ascii?Q?5ms68nFkxHhDYFq65JsN/sbhcE5+eH+Aa8D9dF2CgpN448m29oVqgS4hWRWG?=
 =?us-ascii?Q?4VYumvUcQQmVfkm+LJq6s2dqXtRwvrB42fj+8qjLAwoEYA2DVJK7Z3FM4ngA?=
 =?us-ascii?Q?aHJ80RpeBb05fkGYU43A8UPFdaQ2IKFT2lPqmVYRkFHvCsOEN9bN5q+1Q5Gn?=
 =?us-ascii?Q?2lRpggrFpyXVHDdk+7bemn0UqAlDH3Q/9mnWXgOkCPn+YkqvjwhV/MSi4ahv?=
 =?us-ascii?Q?05iTXG9F3OaXnuJirYR9N9MnNL6C9HkJdIhcWExHtRTKmcpOF+fhShzUzspV?=
 =?us-ascii?Q?LWYVd+p0r+migJtNs3f6jpSEHHhS5IAuWtOnPrtL5Xy+49Ez2XI6X8xVdUxb?=
 =?us-ascii?Q?YTzSccHW8fWj9QQjptbafLEdgjyze5049EWofkE0TFouqqpGZYCW0pcgK4j/?=
 =?us-ascii?Q?f8At5gZCqnHV1/68IoXnQStbqqri57qT+fTWLLVVMosGCZBbcqiXR3nL/iBO?=
 =?us-ascii?Q?tXdTT9t43E2NxI5qjBRx0j3MRKCPVGjtrpZOxLOWCyTEHlvdGWC8eOQRETZp?=
 =?us-ascii?Q?ik8T63VGZM2zu57dWU32jwFC8E8abvNJu2GrKjYjijEKqlWhpAPRH+zQGhSY?=
 =?us-ascii?Q?fjNFxsXul4JbEnX1i5dly/SLeQfJO0pPPJU9wD+FOhkQ93YbguaxO5B6HfuW?=
 =?us-ascii?Q?URezAzUPantL43NJBnVum5tFcNVizdlbdOg0MQ9rJ+St6qBzAlIJgUp8wa/i?=
 =?us-ascii?Q?alF/XfQIhFKg64cHzbaLuWcQFspEvJ+mGnQZRD8da1J4FXwzYsgJ2O1G9HOz?=
 =?us-ascii?Q?1oSoMraI5AJGHDHUbcoTXwJOPX4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BCBC9B9D40C764E872289A3660660AE@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edb2f2e-ed5e-454f-4ad6-08d9abf9750b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2021 07:43:34.7172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +1jVh1x3BGgCFwv8qiPSsxXl3Pr+g+JbcJtTWQmoERJkz1tx9bYJBWftc1tAlQEc+qBRsGcaL1iDymdGbly5LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5257
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: GDv9eyOYh_6njLHYGebvbCk4kjSk-oHU
X-Proofpoint-ORIG-GUID: GDv9eyOYh_6njLHYGebvbCk4kjSk-oHU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-20_02,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111200047
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 19, 2021, at 3:14 PM, Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Add selftest that combines two BPF programs within single BPF object
> file such that one of the programs is using global variables, but can be
> skipped at runtime on old kernels that don't support global data.
> Another BPF program is written with the goal to be runnable on very old
> kernels and only relies on explicitly accessed BPF maps.
> 
> Such test, run against old kernels (e.g., libbpf CI will run it against 4.9
> kernel that doesn't support global data), allows to test the approach
> and ensure that libbpf doesn't make unnecessary assumption about
> necessary kernel features.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>

With one nit below. 

> ---
> .../selftests/bpf/prog_tests/legacy_printk.c  | 65 +++++++++++++++++++
> .../selftests/bpf/progs/test_legacy_printk.c  | 65 +++++++++++++++++++
> 2 files changed, 130 insertions(+)
> create mode 100644 tools/testing/selftests/bpf/prog_tests/legacy_printk.c
> create mode 100644 tools/testing/selftests/bpf/progs/test_legacy_printk.c
> 
[...]

> +SEC("tp/raw_syscalls/sys_enter")
> +int handle_legacy(void *ctx)
> +{
> +	int zero = 0, *my_pid, cur_pid, *my_res;
> +
> +	my_pid = bpf_map_lookup_elem(&my_pid_map, &zero);
> +	if (!my_pid)
> +		return 1;
> +
> +	cur_pid = bpf_get_current_pid_tgid() >> 32;
> +	if (cur_pid != *my_pid)
> +		return 1;
> +
> +	my_res = bpf_map_lookup_elem(&res_map, &zero);
> +	if (!my_res)
> +		return 1;
> +
> +	if (*my_res == 0)
> +		bpf_printk("Legacy-case bpf_printk test, pid %d\n", cur_pid);

I think we discourage bpf_printk in selftests in general, but we do need the
bpf_printk here. So maybe add a comment here (and below) to explain the case?

Thanks,
Song

> +	*my_res = 1;
> +
> +	return *my_res;
> +}
> +
> +SEC("tp/raw_syscalls/sys_enter")
> +int handle_modern(void *ctx)
> +{
> +	int zero = 0, cur_pid;
> +
> +	cur_pid = bpf_get_current_pid_tgid() >> 32;
> +	if (cur_pid != my_pid_var)
> +		return 1;
> +
> +	if (res_var == 0)
> +		bpf_printk("Modern-case bpf_printk test, pid %d\n", cur_pid);
> +	res_var = 1;
> +
> +	return res_var;
> +}
> -- 
> 2.30.2
> 

