Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FCC405F1F
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 23:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbhIIV6m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 17:58:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60476 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229531AbhIIV6l (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 17:58:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189LiONq027266;
        Thu, 9 Sep 2021 21:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2ceb4FBi59rJc7GJ7GqPbHYesoxU7oRsUYilUCWtT08=;
 b=WD2vPKiS0Bx/1zWLvyvo4x70m+RrhUUUessuZOZf68ejg3hDjt928eazE0Q+xVT//8GH
 SNTnOdzXrVhbqWv3pFDnGXqyHoeoKvXUxS3bysJxxzaadn0xn10nC4WBGvgCJc545ig5
 9Wpr3Z60Vpr66PRKEh7XZwbVWrz+yIF1l4IZOK2ij9wi8v6VtBAanupc/4RmIe8/RTVF
 TVxa7m73mN7sjDlNL9dFkhJHXuub5kdKK0tj2n9rurdQ60rCNRA+rlyeGjuxrSvLagO1
 bOv5sIdHQMjrHg27LiY4xF+na8uw6LGPpyjF5/B05BDM/paTuXuT2NYSuiiiAz09E4ZP UA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2ceb4FBi59rJc7GJ7GqPbHYesoxU7oRsUYilUCWtT08=;
 b=N5Cp5v/vEBoTbs2jsLqaQQvtj/YnU1j1sO8HU4lW9D3NVLhjNwlmbXE3ilt63aTEcdE1
 wIFkZMzqJPl8xmjQ7tLPEtqbyztaA6pzSE5XdeQevFBOOk0LTOQnwOfFLXa+ThLLzch9
 q9I21qFXf0bcdhbxfGjte0LRqUrTpy9/l3OhJ1XBjY6Ez0iN+HzsYKanO5/nrRhYYfFs
 4ui+ZhxZauUxHFR+0HGlhykGAC8QRrU+2yzrCqRge0klLi0nmbrXShIC9PKFqt5s4dtw
 8G8wLj3efZwcSjX6djJ4CXkiGI47xhB+x6yfeiLCMTE57ou1qOJItKrjoR2un0xJ0x35 cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aytewg0s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 21:57:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189Lo7Rb116175;
        Thu, 9 Sep 2021 21:57:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by aserp3020.oracle.com with ESMTP id 3aytfxg9w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 21:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX8kG5YvNIATMhjkCPLNCGAXPIUAJoXhSxxOQkcC7LVu3MK0MSJrO7wULZr0SbPUq+9G38j2qfUjR9qW1cZU7l8967z4maU1NM17mkagnEDOCdGzvhIaf4t/u1zfJpgbipSe6KA8G+eoSBmB9tf/9mNMn+caAhORYiSaSksNh9PJ9VxL8Jn8mvGppIJZeRf6YdCN6oao/eGHHGkzEEmQH3DpWl8LlX3KkBG347KyUQTg455TTIwkJPiUqMVuJEph+V+ufFzt3G0YELDFJTwtL+Mk/GV8hgh9iJbjIqJ0GMRf+sT6DyZ05IQguTwL/qAJRTaEkY9uUUbMc4FBin4IdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2ceb4FBi59rJc7GJ7GqPbHYesoxU7oRsUYilUCWtT08=;
 b=R+I/XJPWr4GyDborujNGlgyWUb1UeWpqfKjs0cb+7fLkUxint4U2HkcmTl38+zQaPp7KWYYSEr4yHoYRFkzsjgUcmmh49m/K40DIMMMdZa4m73Hmqia4WtpZQjCJ5jtndZYWk0iWD03MfA/hTF/hDHmMV3KXkQ592uUlbSEp/TkWGdkVWuDMT/4ACqO12UVoNzp5ZAKaDbDrMZ97IjCLiGiKn7lN4bcfhnIcOxZQsyG+wXAg+Iw1yQREHBeEISU052dSpv8BPSeW8hqsjOmlIz2tDXnWCKgprpebPJ8OjOx8udubfPxjvt+x7le19alApYHl+iy/dhLeOM8ot9K+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ceb4FBi59rJc7GJ7GqPbHYesoxU7oRsUYilUCWtT08=;
 b=Fpm9TUmzccasqtwsRZeI3+bh6e8eMtROeCUHGueIHTGLkPoubBeqgdEALXJOAMyMOOJJWmZaDR6Owik4oswBkEhD/TO9yR2QObBeQ8NTmfvI8UfMhAezeFj9rf+jpCCxe3nndkbxmf5LGrta+hRAz3Xl9JXVBA8C3h6+B1B9FUg=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3100.namprd10.prod.outlook.com (2603:10b6:5:1a7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Thu, 9 Sep
 2021 21:57:10 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%5]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 21:57:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yonghong Song <yhs@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Luigi Rizzo <lrizzo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH bpf-next/mm v5] bpf/mm: fix lockdep warning triggered by
 stack_map_get_build_id_offset()
Thread-Topic: [PATCH bpf-next/mm v5] bpf/mm: fix lockdep warning triggered by
 stack_map_get_build_id_offset()
Thread-Index: AQHXpZJlGPNQnXt9q0eHyzmwpPJ/saucQBMA
Date:   Thu, 9 Sep 2021 21:57:10 +0000
Message-ID: <20210909215658.hgqkvxvtjrvdnrve@revolver>
References: <20210909155000.1610299-1-yhs@fb.com>
In-Reply-To: <20210909155000.1610299-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 124084f5-d7bb-46b9-544e-08d973dcc643
x-ms-traffictypediagnostic: DM6PR10MB3100:
x-microsoft-antispam-prvs: <DM6PR10MB31008B72B7E57165DF5C8921FDD59@DM6PR10MB3100.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i68+SnC+w4f1Lxy44/l4TAq8zV0q27Zhx7UbaUms9RozsLh4VvkuyEZqvU4OdXrhTW+NgB2fwhLydpueHaNQmv/+u3wn9V6pteU/JKNEhxvuXGGWtyQtaEOrDs3IM5MR8i4DyQp/n3wkZcJErTylDo08cRO5GGncZ+QSAA3irLyqGHMMOBgvXtUcRDo2yvWftzYhtROiQtYz00pZdR+Wl6Z5Cy+ikTBNWyFWSKsUOJd0xLOiVslD8IcCDkAKdAJxtqork2URo9pJ/e3iKpR4j5TJe80iBYzryb1KPU4yzoGlfdJf9aaH+Wj5f7/iMhZZdXZqijJoq9HbRllnKDpCQLzpR4Xv1V/RkDjNc6D+JRlJ+bJyYh69iXHm/qnXfuMyOFB1/0FArzQBAEit376IL5YJqi15H9d+zVxpNr9aO7dO6v6hz+jQJEgsfZt2038tkwKRfiL++nt93JcIKgkHfQp1CX3KYdBoYBaYV+DXoAgOKVpwUcB2eX7JFCYuh6CHsxP6fS48M+x/2gL42eX/0lQE8kJqZ8gl2LmELxxrErovRu52LggZfDv1CHczLhIb2/1/IOJdwfTgnloR3LDJSNCcRVx3bS3SoVEftbAyGrGffNxq3ypufdWIYo/gGwBhkbvJwSBr625F66oY3hOIdXGLS7FyAI+obIhVgthZGAwWWzH+N2iIGNNju+5Ew6V1IEnJM4tUnBv8n0niACOvRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(136003)(376002)(366004)(39860400002)(346002)(33716001)(26005)(44832011)(122000001)(186003)(66946007)(3716004)(1076003)(478600001)(38100700002)(2906002)(9686003)(6512007)(6486002)(6916009)(54906003)(45080400002)(5660300002)(83380400001)(38070700005)(76116006)(316002)(6506007)(8676002)(91956017)(66556008)(66476007)(8936002)(86362001)(64756008)(71200400001)(66446008)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Em1+yBFQzhizm5FW+K3H0MukxpwnDZz1gqTiNXn1m36++v8FZuorQ3fpn6zb?=
 =?us-ascii?Q?b4efKeoEBQZILocxNiS9ie644d7hPHUjDFYKAkgYHh86yEhOF4m8b7bb8z5v?=
 =?us-ascii?Q?M/YUIcVESJRbBCwxcGpWYerJxSOL23MOLUOQrrOnjQUCnt5WMMKA9AuavibK?=
 =?us-ascii?Q?mmdbQEmZcJ00pVq333rXFdcSNqDStb8RIOfje6jgsyvM7KuYHVYPSL3om90V?=
 =?us-ascii?Q?GJDT2R1kFbmdrRcfAnNVX1tBw56jkNalQ+IqpjioR2B5yR1qiMUUw9PnyMWV?=
 =?us-ascii?Q?S9XZ/ZrBH4mvhLmd7PBkvT4ZLlnMNTQ8o85fC1yxOIHJqSQNwmOzajwHQHKj?=
 =?us-ascii?Q?ngiU5hLJGhXQiaULMJ5rJbf9ECY47bICkOA26pVhaMi+vbpBFXn6wA1pdZnC?=
 =?us-ascii?Q?wibmcwmC9gzceUl31kFYPrGR7cYr7XglbV7MUk5EmtpEV9Vt7Z4sxMgaG8vH?=
 =?us-ascii?Q?rRIvzFgF06AoGUZVeeKRsWld3Q1fMiQUFlZlyRAjUCR+MBOcRbMJFK04kF/t?=
 =?us-ascii?Q?E3RLOv4NQHmvc6vsgcKW/36604Mkdue9xTSusycJFxfHyk3wMr6JtvdCOEzW?=
 =?us-ascii?Q?ErzCM6JjCFEg7Z5/9JrRY1KWcWumvJFY3kXAuBdO5PiL3E8Lk0Dbv0SdwVGf?=
 =?us-ascii?Q?gpgF7nkVd7v8j9e43+RFfX+GLWd+1DM3o8oiCm7xg3KXLlMCRnuzHyUpJN3o?=
 =?us-ascii?Q?dc/ozgDhyx79kD72PDu0bi818NVgeIkLFBiWmKoDv4YCsniKYFOg3wuwC7UT?=
 =?us-ascii?Q?m6VKeyQZ3my418AbiLrsSMPrElK3it1nOQkSRJWoi5zr0wdGwKD28TCH0v+q?=
 =?us-ascii?Q?YnowYbNVzVd1DQ4TTDA1tOQRu2EEBc8B1zy5k4qAQ2/oeXxJe3eBXcm3Hw0M?=
 =?us-ascii?Q?U1fO4ZPtp7UClFEjV6EpnAUGZIer4knKkT32Yft2cxFGOntzvorHFruP6KNX?=
 =?us-ascii?Q?IVSyT4KlzUVQU8fESDsLYMiMX81Gwr072QrNZCa9LKkzvxg9pry+gH/t3uGh?=
 =?us-ascii?Q?9+6wkKFKkn2jBrt1Uznbiv7u6N7AERQZvcF7ChYjXqAISCRpytjswh45bRFC?=
 =?us-ascii?Q?+Al8j8dO4WjoMTnS+0sbY15HkcOOEtbPDQYakl/nnqXW3q+VKn3etlqGopSG?=
 =?us-ascii?Q?nw0BEuQGst+t/yemxqelYKZQope8VgZ0UPB/Xa7ZNaHHPQwexCs4pLh629Wn?=
 =?us-ascii?Q?0ymfQ8hm1Xvc+gMqmyXRKgqEg6fM7aOzYwqKNvetmWBqoYtxL7+P+fx7M/LM?=
 =?us-ascii?Q?VpxfU1Y5mYXyzJ4p1IN1NG/6H2wFAfVBoZTtclDqbSC0ecRBCWQ+dRGN+kvl?=
 =?us-ascii?Q?XDqmkwX9kwmIzGZCe6ScvPO0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30CB82905D7E16498875E87B269E625A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 124084f5-d7bb-46b9-544e-08d973dcc643
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 21:57:10.4980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eBvi9NoiWPxSZF9hn+QGxjVH6heP2PLmcb5FULldExkqGHiMCZFSiYFJT4rnVtDpcZS0/S2vX4HA8GHctZZHJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3100
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090134
X-Proofpoint-GUID: _KBvahzJ--mrqyvqldpAiFyVm9_dqyFb
X-Proofpoint-ORIG-GUID: _KBvahzJ--mrqyvqldpAiFyVm9_dqyFb
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

* Yonghong Song <yhs@fb.com> [210909 11:50]:
> Current bpf-next bpf selftest "get_stack_raw_tp" triggered the warning:
>=20
>   [ 1411.304463] WARNING: CPU: 3 PID: 140 at include/linux/mmap_lock.h:16=
4 find_vma+0x47/0xa0
>   [ 1411.304469] Modules linked in: bpf_testmod(O) [last unloaded: bpf_te=
stmod]
>   [ 1411.304476] CPU: 3 PID: 140 Comm: systemd-journal Tainted: G        =
W  O      5.14.0+ #53
>   [ 1411.304479] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
>   [ 1411.304481] RIP: 0010:find_vma+0x47/0xa0
>   [ 1411.304484] Code: de 48 89 ef e8 ba f5 fe ff 48 85 c0 74 2e 48 83 c4=
 08 5b 5d c3 48 8d bf 28 01 00 00 be ff ff ff ff e8 2d 9f d8 00 85 c0 75 d4=
 <0f> 0b 48 89 de 48 8
>   [ 1411.304487] RSP: 0018:ffffabd440403db8 EFLAGS: 00010246
>   [ 1411.304490] RAX: 0000000000000000 RBX: 00007f00ad80a0e0 RCX: 0000000=
000000000
>   [ 1411.304492] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: fffffff=
f977e1b0e
>   [ 1411.304494] RBP: ffff9cf5c2f50000 R08: ffff9cf5c3eb25d8 R09: 0000000=
0fffffffe
>   [ 1411.304496] R10: 0000000000000001 R11: 00000000ef974e19 R12: ffff9cf=
5c39ae0e0
>   [ 1411.304498] R13: 0000000000000000 R14: 0000000000000000 R15: ffff9cf=
5c39ae0e0
>   [ 1411.304501] FS:  00007f00ae754780(0000) GS:ffff9cf5fba00000(0000) kn=
lGS:0000000000000000
>   [ 1411.304504] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1411.304506] CR2: 000000003e34343c CR3: 0000000103a98005 CR4: 0000000=
000370ee0
>   [ 1411.304508] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
>   [ 1411.304510] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
>   [ 1411.304512] Call Trace:
>   [ 1411.304517]  stack_map_get_build_id_offset+0x17c/0x260
>   [ 1411.304528]  __bpf_get_stack+0x18f/0x230
>   [ 1411.304541]  bpf_get_stack_raw_tp+0x5a/0x70
>   [ 1411.305752] RAX: 0000000000000000 RBX: 5541f689495641d7 RCX: 0000000=
000000000
>   [ 1411.305756] RDX: 0000000000000001 RSI: ffffffff9776b144 RDI: fffffff=
f977e1b0e
>   [ 1411.305758] RBP: ffff9cf5c02b2f40 R08: ffff9cf5ca7606c0 R09: ffffcbd=
43ee02c04
>   [ 1411.306978]  bpf_prog_32007c34f7726d29_bpf_prog1+0xaf/0xd9c
>   [ 1411.307861] R10: 0000000000000001 R11: 0000000000000044 R12: ffff9cf=
5c2ef60e0
>   [ 1411.307865] R13: 0000000000000005 R14: 0000000000000000 R15: ffff9cf=
5c2ef6108
>   [ 1411.309074]  bpf_trace_run2+0x8f/0x1a0
>   [ 1411.309891] FS:  00007ff485141700(0000) GS:ffff9cf5fae00000(0000) kn=
lGS:0000000000000000
>   [ 1411.309896] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1411.311221]  syscall_trace_enter.isra.20+0x161/0x1f0
>   [ 1411.311600] CR2: 00007ff48514d90e CR3: 0000000107114001 CR4: 0000000=
000370ef0
>   [ 1411.312291]  do_syscall_64+0x15/0x80
>   [ 1411.312941] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
>   [ 1411.313803]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>   [ 1411.314223] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
>   [ 1411.315082] RIP: 0033:0x7f00ad80a0e0
>   [ 1411.315626] Call Trace:
>   [ 1411.315632]  stack_map_get_build_id_offset+0x17c/0x260
>=20
> To reproduce, first build `test_progs` binary:
>   make -C tools/testing/selftests/bpf -j60
> and then run the binary at tools/testing/selftests/bpf directory:
>   ./test_progs -t get_stack_raw_tp
>=20
> The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_assert_lo=
cked()
> annotations to find_vma*()") which added mmap_assert_locked() in find_vma=
() function.
> The mmap_assert_locked() function asserts that mm->mmap_lock needs to be =
held. But this
> is not the case for bpf_get_stack() or bpf_get_stackid() helper (kernel/b=
pf/stackmap.c),
> which uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is =
not held
> in bpf_get_stack[id]() use case, the above warning is emitted during test=
 run.
>=20
> This patch fixed the issue by (1). using mmap_read_trylock() instead of
> mmap_read_trylock_non_owner() to satisfy lockdep checking in find_vma(),
> and (2). droping lockdep for mmap_lock right before the irq_work_queue().
> The function mmap_read_trylock_non_owner() is also removed since after
> this patch nobody calls it any more.
>=20
> Cc: Luigi Rizzo <lrizzo@google.com>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to =
find_vma*()")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  include/linux/mmap_lock.h |  9 ---------
>  kernel/bpf/stackmap.c     | 10 ++++++++--
>  2 files changed, 8 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 0540f0156f58..3af8f7fb067d 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -144,15 +144,6 @@ static inline void mmap_read_unlock(struct mm_struct=
 *mm)
>  	__mmap_lock_trace_released(mm, false);
>  }
> =20
> -static inline bool mmap_read_trylock_non_owner(struct mm_struct *mm)
> -{
> -	if (mmap_read_trylock(mm)) {
> -		rwsem_release(&mm->mmap_lock.dep_map, _RET_IP_);
> -		return true;
> -	}
> -	return false;
> -}
> -
>  static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
>  {
>  	up_read_non_owner(&mm->mmap_lock);
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index e8eefdf8cf3e..09a3fd97d329 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -179,7 +179,7 @@ static void stack_map_get_build_id_offset(struct bpf_=
stack_build_id *id_offs,
>  	 * with build_id.
>  	 */
>  	if (!user || !current || !current->mm || irq_work_busy ||
> -	    !mmap_read_trylock_non_owner(current->mm)) {
> +	    !mmap_read_trylock(current->mm)) {
>  		/* cannot access current->mm, fall back to ips */
>  		for (i =3D 0; i < trace_nr; i++) {
>  			id_offs[i].status =3D BPF_STACK_BUILD_ID_IP;
> @@ -204,9 +204,15 @@ static void stack_map_get_build_id_offset(struct bpf=
_stack_build_id *id_offs,
>  	}
> =20
>  	if (!work) {
> -		mmap_read_unlock_non_owner(current->mm);
> +		mmap_read_unlock(current->mm);
>  	} else {
>  		work->mm =3D current->mm;
> +
> +		/* The lock will be released once we're out of interrupt
> +		 * context. Tell lockdep that we've released it now so
> +		 * it doesn't complain that we forgot to release it.
> +		 */
> +		rwsem_release(&current->mm->mmap_lock.dep_map, _RET_IP_);
>  		irq_work_queue(&work->irq_work);
>  	}
>  }
> --=20
> 2.30.2
>=20
> =
