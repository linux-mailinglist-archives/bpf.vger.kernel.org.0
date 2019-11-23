Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5248B107FA9
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 18:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfKWRh4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 12:37:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53740 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726494AbfKWRh4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 23 Nov 2019 12:37:56 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xANHYCrH016438;
        Sat, 23 Nov 2019 09:37:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=t5S+M0MyuRnDs9xczxxVYYjav2mk7woThRt61vBARAw=;
 b=n/8dqECyOCKdNZ5SQBt86DurVA4BX7nGabIOR7XxS+esYpCQlePmg9wRjJ9KgVWjen3R
 mui1G5O6wKeOTLer25+a0aRcEMi4LZNhvg5mEoQE7ZxO7XML/XvELOBtf3jvWkxRRRHs
 bk2Wf+FYe0W1EfUOhaJdpKAJN62B4aiO/rY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wf3cr0yy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 23 Nov 2019 09:37:35 -0800
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 23 Nov 2019 09:37:34 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 23 Nov 2019 09:37:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz9UfKH9EZtApr33BsEhpvdduVZ19IXdMSI3CHuNX83ZYE9tzXwEPR9FMsJGVOQK21remnqe3fB7ripIqG6X5OQQxCgOnC6DI6dvrbixGy8TwLIXU+TdGrG3iMst5wEW7WvyCP2eFV6DFxw9Ac6cUjURxwmpxBmLRtK/pp52cfX3J5ELHnBhhxKR08/+z9PJ72r9mDiLaaofl3PAyBawT5rRIA8TEKXYea4Y5c+BmMSD/raW0HiNyOUeXSFUq42Yq81DJYB12OXl+3kXbuGLByNZdNW9l85tutkju0XbYwJTlxqSf+W6b4mzTubKNDbpN/w7a8ZimWULTx2zgtLi7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5S+M0MyuRnDs9xczxxVYYjav2mk7woThRt61vBARAw=;
 b=gSeF5uArva6WUNwsfGoDBgkjj+zMxYxU3aoMpjty8Z9lSGL8awZfw3FupXdppE2vgBtsoQap0akVfi9Zx24vqiYdAJrRsGeKN9nG26Q64xP0uQjWcb25w0KM9Yr91sqoU073boSWo76LiXS2iwQVt4D/f7A+ptGoJjwcpH6Lx67hMBE/Zn507k6NpIanfvLDVkS4WZJZUOPbKFiIW/TNx9nH7pLeEuv/tCuLpYNJfQDMPXGDYZHYNEWKXfk/fkheswdpgRN0nvKtciyNkVF67DQgtXvy15a231YOfUA8kts6bRJ/cTPh7gEJXnNKnyK+VYW0cPLE17GPpQjbha27yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5S+M0MyuRnDs9xczxxVYYjav2mk7woThRt61vBARAw=;
 b=e3V3/Zw/0oXVDrt7zMZHrzPNDbKNqqjxOBDIQXzbGqi5JeCr18IBxceLwPaS6+Ocr+iNFUQEvG07GwD09evTpuLgvR2s+7xs5chj+xJUnmthD5B2bQfX5RWZfkIRf9yAkvQfDTmVyXVZeWdOT1hFwwV9fjEEIN3YZg6sstWPWm0=
Received: from CY4PR15MB1479.namprd15.prod.outlook.com (10.172.162.17) by
 CY4PR15MB1864.namprd15.prod.outlook.com (10.174.52.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Sat, 23 Nov 2019 17:37:32 +0000
Received: from CY4PR15MB1479.namprd15.prod.outlook.com
 ([fe80::5cd:5069:d3ca:fe29]) by CY4PR15MB1479.namprd15.prod.outlook.com
 ([fe80::5cd:5069:d3ca:fe29%4]) with mapi id 15.20.2474.021; Sat, 23 Nov 2019
 17:37:32 +0000
From:   Andrii Nakryiko <andriin@fb.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "Alexei Starovoitov" <ast@kernel.org>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [linux-next:master 11808/13503] kernel/bpf/syscall.c:154:
 undefined reference to `vmalloc_user_node_flags'
Thread-Topic: [linux-next:master 11808/13503] kernel/bpf/syscall.c:154:
 undefined reference to `vmalloc_user_node_flags'
Thread-Index: AQHVofOAwCmIf4onAES1vM6RkA0LPaeZBXOA
Date:   Sat, 23 Nov 2019 17:37:32 +0000
Message-ID: <baf09eb1-946b-fe04-6302-006654d594e0@fb.com>
References: <201911231924.k1adA4Qy%lkp@intel.com>
In-Reply-To: <201911231924.k1adA4Qy%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0038.prod.exchangelabs.com (2603:10b6:300:101::24)
 To CY4PR15MB1479.namprd15.prod.outlook.com (2603:10b6:903:100::17)
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::4f9c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72383720-fff0-476d-04e4-08d7703bd1c1
x-ms-traffictypediagnostic: CY4PR15MB1864:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <CY4PR15MB1864B60334AE6FB5561B04EDC6480@CY4PR15MB1864.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:57;
x-forefront-prvs: 0230B09AC4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(386003)(6506007)(53546011)(52116002)(305945005)(99286004)(966005)(478600001)(46003)(2906002)(66946007)(8676002)(76176011)(64756008)(66556008)(66476007)(14454004)(25786009)(81156014)(81166006)(86362001)(65806001)(65956001)(54906003)(7736002)(6116002)(31696002)(6916009)(8936002)(36756003)(31686004)(5660300002)(4326008)(2616005)(11346002)(102836004)(229853002)(58126008)(71190400001)(71200400001)(5024004)(186003)(256004)(14444005)(6306002)(6486002)(66446008)(6436002)(6512007)(446003)(6246003)(316002)(81973001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1864;H:CY4PR15MB1479.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?Windows-1252?Q?8QMPEtmhrETwMfWNL0xgG3JmkpDfZCLAQjrreRf52wIBzF9GBMwmXTgF?=
 =?Windows-1252?Q?nkXpfrI5QUh0MZDjPP76huCdphKJl8EwkMLzwrg3e+dE0LpALUeArUhY?=
 =?Windows-1252?Q?WZ79/6xYCRJKjpQi7+tvwB27yzdtGzLfsMCqWVFm3FU+xg70qh2DI5Wa?=
 =?Windows-1252?Q?sSz3YiOcUojPtltWEDMNsZY9kTNkjoAEFhG1Aq3JmeKQgp9lKGlwUcdR?=
 =?Windows-1252?Q?vi1gAI3Ff1rZydJzkG13HxvU1BIRkOlxDoNpDsfX7cwpVwY/bsSuHLxM?=
 =?Windows-1252?Q?nH+t4HohOsrpALdU+EnL7yjy3xR+TyVLWtka5em3ojIidQp3YCGSYZR6?=
 =?Windows-1252?Q?HWJ5wCo8zKRtcyJG2200ZhR3/jOLQcE/o2xFulX4+6aaSu3hZ3KGH0I6?=
 =?Windows-1252?Q?i2omFGKJa6oWuNNbElSXonKSDeZmVFt1lhiMPEWANd/FV4JnEZ8upafs?=
 =?Windows-1252?Q?IC9p8BOLBTbfWyam5hEw9VQ2ydiO3bRlycjc88AErlb1H3EV7Oxqay4p?=
 =?Windows-1252?Q?Y2gj4BkaIm9wEe97OqvBNHBnAQWDAjqWA+zvx+iqNAzoFWCHnYMlvG8K?=
 =?Windows-1252?Q?5qNGRjxPMDvNFyKberXKd71BAW3xYXrVHGwfj6q5Hwj/s+uE/vxOR125?=
 =?Windows-1252?Q?0oAKYRf4SBjrYkIu+98yTC9X+nVAXWnf5AIq7ISPe/YWX04XOsGxvk8X?=
 =?Windows-1252?Q?JdzGON+XUsEDx56IYURNLS//vHUsHc+H0V1Kybv7b3lUl4JV6hj+MIq0?=
 =?Windows-1252?Q?iWgllEhFjKQIVBj0URY9Oftp7M8KJSmjUrv0+xOYRYvQh5qx29wDcCDS?=
 =?Windows-1252?Q?EKJoiBTODauI5+zUzjUKkRqkPBMZw6u/Mu/iHctsUx2VTrt9tJiNSjlC?=
 =?Windows-1252?Q?4u2pGG6EV4Ee5F/isXekp2FBiT4jigPb67BbtNjMKdbBqX8vH0xpaz5F?=
 =?Windows-1252?Q?hcE5DsafAIFZ+0SYa4ZdZyZNkkAYpm4MJY7w0695egy+qGfnVXQPzA7V?=
 =?Windows-1252?Q?R1K0rxV866XB4FgznCiIGrUUVulYBAzWLm2jGNSUI3zS+LYO56SAXvV+?=
 =?Windows-1252?Q?Bl0eqv0B4Oty4ln14Fmu+KqJuf/kegZFRPrD13plPBo1bENfFyMhMwRq?=
 =?Windows-1252?Q?g1NbGhPJNRbwhVb98bjU9KplwP8xSds4hwTvQVWBVEeDbA2g+7LqdmaF?=
 =?Windows-1252?Q?CfVWMCiRjIZcoihpjffe90hJYBwIlf/7mPNFh69+Xr+4tytyFa8GA86b?=
 =?Windows-1252?Q?5RGPeEF+SChSpJnC57aYZbBwc5UZ4LWMvceBzxD43S55+Sc+tscf/1V0?=
 =?Windows-1252?Q?WC72P5ye19qufSdMG9p8y1oa/5r7Z64gxQojWHThkmZRwVKXOpqHiFGn?=
 =?Windows-1252?Q?8+WldA4wV2DZ5KgDVvx4PJhyGVeegZ5busiABf/kE6Ev9II0zvWifDZY?=
 =?Windows-1252?Q?cMi63YH+xaAdFtTuZouE88qjPWLh3PiZLqicGa8YfOEr8OLcclO/7TY1?=
 =?Windows-1252?Q?VVr0yWFumI3MOknOuqNO4XzEj77Fu52OxoCgieTLFhJvjXQgUkfs9hKS?=
 =?Windows-1252?Q?gZtkczaxdxC8L4jEZYXRM4uERUI7AJZFez8HWTPnbzLKC/KSE84x/b2n?=
 =?Windows-1252?Q?vU2OYAXXV4c3If9b+99/5yXF792jhLwg7JOuEVE+1mmzh/0paMzW8fXu?=
 =?Windows-1252?Q?WgPEy4zs6K5JM14yV9Xcw84k1DehIH87LkdOZtmVrSgYlZ//5P14XSct?=
 =?Windows-1252?Q?nn2YTc6WDZzKlViz2YvLmDFhD0JKWkgORmrHlCgvPWAIQlP2VlYj2xsQ?=
 =?Windows-1252?Q?eXwmTPJb6V23kqTiPxNdyP0DFXV2MuakKhIsggtJTJ0szPbYSEzxMcdM?=
 =?Windows-1252?Q?0Pqm9NbYUXvABN5LYe5DMTvum2r3Fv6Ag2q13qwytWuDY6Yjl5Aog7W1?=
 =?Windows-1252?Q?iOXkd6By/xPILnK4K0wbHKXuVTSTMM/OWh4h//PkD9Kv5pZ5h/NXSd8R?=
 =?Windows-1252?Q?ByWZWFJJnFRWHTnChKaVu1zX9XJ1cxtohhmgmAR7NA6v8KvfDkU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <6C8B622A8ABA1F42B2C11A675FC87F3F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 72383720-fff0-476d-04e4-08d7703bd1c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2019 17:37:32.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDgNDtFYLaVJcrJoJiIqXUIpJxvfYtdt/fMjMFmd+YqnW1OJBqQU+ayS0wVZ3eo1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1864
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-23_04:2019-11-21,2019-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=889
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911230148
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/23/19 3:44 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it master
> head:   b9d3d01405061bb42358fe53f824e894a1922ced
> commit: fc9702273e2edb90400a34b3be76f7b08fa3344b [11808/13503] bpf: Add m=
map() support for BPF_MAP_TYPE_ARRAY
> config: arm-randconfig-a001-20191123 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
> reproduce:
>          wget https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__raw.=
githubusercontent.com_intel_lkp-2Dtests_master_sbin_make.cross&d=3DDwIBAg&c=
=3D5VD0RTtNlTh3ycd41b3MUw&r=3Dvxqvl81C2rT6GOGdPyz8iQ&m=3DOyqPkKr2ayhE9rsjQ3=
V9TjPHNWGAzMj67odoKch8_YM&s=3DJuUtGb4L_bH6ANKEMAgVL3zSBnFkOW4jhVP9W3WBHBM&e=
=3D  -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout fc9702273e2edb90400a34b3be76f7b08fa3344b
>          # save the attached .config to linux build tree
>          GCC_VERSION=3D7.4.0 make.cross ARCH=3Darm
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>     arm-linux-gnueabi-ld: section .data VMA [0000000000808000,00000000008=
829bf] overlaps section .ARM.unwind_idx VMA [00000000007d7000,000000000080b=
8ef]
>     arm-linux-gnueabi-ld: section .ARM.unwind_tab VMA [000000000080b8f0,0=
00000000080febb] overlaps section .data VMA [0000000000808000,0000000000882=
9bf]
>     kernel/bpf/syscall.o: In function `__bpf_map_area_alloc':
>>> kernel/bpf/syscall.c:154: undefined reference to `vmalloc_user_node_fla=
gs'
>=20

Can't repro this with given config on x86_64. Trying to make make.cross=20
work for me still. Any ideas why this is happening? I see that=20
__vmalloc_node_flags_caller that we also use if #ifdef'ed as static=20
inline in include/linux/vmalloc.h if no CONFIG_MMU is defined. Are we=20
missing some config dependency or should I do the same trick as=20
__vmalloc_node_flags_caller does?

Also. Daniel, when I tried to build latest bpf-next with this config, I=20
got another compilation error, related to your recent patch, you might=20
want to take a look as well:

   CC      kernel/tracepoint.o
   CC      kernel/elfcore.o
/data/users/andriin/linux/kernel/bpf/verifier.c: In function=20
=91fixup_bpf_calls=92:
/data/users/andriin/linux/kernel/bpf/verifier.c:9132:25: error: implicit=20
declaration of function =91bpf_jit_blinding_enabled=92; did you mean=20
=91bpf_jit_kallsyms_enabled=92? [-Werror=3Dimplicit-function-declaration]
   bool expect_blinding =3D bpf_jit_blinding_enabled(prog);
                          ^~~~~~~~~~~~~~~~~~~~~~~~
                          bpf_jit_kallsyms_enabled
   CC      kernel/irq_work.o
   CC      kernel/crash_dump.o

> vim +154 kernel/bpf/syscall.c
>=20
>     129=09
>     130	static void *__bpf_map_area_alloc(size_t size, int numa_node, boo=
l mmapable)
>     131	{
>     132		/* We really just want to fail instead of triggering OOM killer
>     133		 * under memory pressure, therefore we set __GFP_NORETRY to kmal=
loc,
>     134		 * which is used for lower order allocation requests.
>     135		 *
>     136		 * It has been observed that higher order allocation requests do=
ne by
>     137		 * vmalloc with __GFP_NORETRY being set might fail due to not tr=
ying
>     138		 * to reclaim memory from the page cache, thus we set
>     139		 * __GFP_RETRY_MAYFAIL to avoid such situations.
>     140		 */
>     141=09
>     142		const gfp_t flags =3D __GFP_NOWARN | __GFP_ZERO;
>     143		void *area;
>     144=09
>     145		/* kmalloc()'ed memory can't be mmap()'ed */
>     146		if (!mmapable && size <=3D (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER=
)) {
>     147			area =3D kmalloc_node(size, GFP_USER | __GFP_NORETRY | flags,
>     148					    numa_node);
>     149			if (area !=3D NULL)
>     150				return area;
>     151		}
>     152		if (mmapable) {
>     153			BUG_ON(!PAGE_ALIGNED(size));
>   > 154			return vmalloc_user_node_flags(size, numa_node, GFP_KERNEL |
>     155						       __GFP_RETRY_MAYFAIL | flags);
>     156		}
>     157		return __vmalloc_node_flags_caller(size, numa_node,
>     158						   GFP_KERNEL | __GFP_RETRY_MAYFAIL |
>     159						   flags, __builtin_return_address(0));
>     160	}
>     161=09
>=20
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology C=
enter
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.01.org_hyper=
kitty_list_kbuild-2Dall-40lists.01.org&d=3DDwIBAg&c=3D5VD0RTtNlTh3ycd41b3MU=
w&r=3Dvxqvl81C2rT6GOGdPyz8iQ&m=3DOyqPkKr2ayhE9rsjQ3V9TjPHNWGAzMj67odoKch8_Y=
M&s=3DzQax2z98Tn-V1wcH0rtwmJ0iA9DpFhqbVNzexx7wOWw&e=3D  Intel Corporation
>=20

