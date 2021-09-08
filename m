Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2D4032D4
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 05:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhIHDLf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 23:11:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26014 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231769AbhIHDLf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 23:11:35 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187LU0uQ025812;
        Wed, 8 Sep 2021 03:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=indz5TpFY+NcrAXdaM+ndfSZB2PN60HrVqTcQVds9SA=;
 b=TulnVCQCIPDKV4HQLu+oqe4u0L32WMSLLHzgDPu6Il5TA65o/19F2uIMbBFjydX3ouoS
 GQpAx2c3wvz+zts7pTZQSB0mvrtS2Rw9v39D5l/6GhB5+9/3yqNseb+K8Tpe29Mcd1HP
 8j2TaxW7ELqtSnwis3BS8GYWFUOPmPnvu1/jkBYEM4+hV0CpYE3k8CGuFnb6rT1/2t8H
 KS/YQc+Nf5OHW8C0XDm6Rt0vS4ZuImjXN94xhTJSKOfYaJigGAu3yeviC5uQoEqk/00R
 2U9NKSNqpb1uBMJI2ndRLANo/fjMpkU3ehwUvw29zNJANthbmNgw40uZMwNS88wA6Osw Hg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=indz5TpFY+NcrAXdaM+ndfSZB2PN60HrVqTcQVds9SA=;
 b=NiHKr3OxbCdtt/0b+LH0kg2z8Ge8xQ5ozpmGXhy1qw6U16O6csBS+57O0wUnVV3C44XU
 u8c2pklAsolKj5WrBy7HCiRiCYxALeWFpPGOdz0dYxSUhdX+vVk3AxrIk1kqMF3d1MFI
 QVq5pk1DrjFNbLXQuLgdttG7PLJvBhJPTpxKsVZgrJLIWtqN1PM6NcKAWLk62ryd6imn
 o6JnXgPUHIFJ9CuYIb05ImX66zm3C4KFW8vWqtfftcoAnwBWiQM+vfKJJvrpfu8iCSj7
 yfTmrgr/34EZHlHqCdQf3ESJquZ4qS1jHRmcXNASP8mCtCpWr5BGa6+fr1yrNO1aAT/7 JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd8q12rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 03:10:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1883A2Bj093797;
        Wed, 8 Sep 2021 03:10:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3020.oracle.com with ESMTP id 3axcpkkffw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 03:10:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANq9rp8w20avarVds+HmXtgnt8klONHLLDfM8PpjxORTcI30VbFoC+iEvYhzDC/7vf+7QzXgj+PDws+nElZhOZtqv+pJMJBSktCPv5h9jSNB81W3KZBECzPKCivvkdKiU/n8PK3Qu9Yqg6tmaHSLfnS5QalAx7bSiaHnG+SXAvEq8tcV7tN9xcTvBxKvBK2pDsGsS6u+zax5XOAkyenUoTyaBjt11LjXqXw5qAx7k3U6xCNGjIBZH58ciqH+aGLhuvGe1PsGkJbef0NCsUwSYExxfqIvftH0jjOHqJ8A1k6A6/hHhePnqWI1JUokGQ9QqL/Li4LU2kWFZJaUYEUKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=indz5TpFY+NcrAXdaM+ndfSZB2PN60HrVqTcQVds9SA=;
 b=m2UWQmGLyyZvjt0W45gt159v5QjSTKGxSTtOMR29z/Omb+wPAcbiA2iuxHgaaTepsM3jXumtGF4P8VzE22MfQPXyphFfXgjGZMH1o4eZf/mr8XwNjZQqbNW8PAzxYcqnbBVQdvO+JkYApczrAsv25RmuvxwqMwaVtsOoT0Rg+SDmOeHLYHTonRBleMi2LhDMY5tj5NcfAWrCypt6fXN8T83rsb6NYZSX7FaBsvIXapvQ3QW+f4fAfK9fuWNJksbHptwW0r+5BEkNxjY86gMDt98ta1MrrfRTvSxYhJj3WR6DV9sc9h1pncLiOD8BjfTosecEsLLWW/iX0P7FYBSFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=indz5TpFY+NcrAXdaM+ndfSZB2PN60HrVqTcQVds9SA=;
 b=0I0UQ5pd1I2WsL+K1VUX0Sy7G3BrSLdUx8nUH+KtutECoopfgo3wbkXoD5gFBBNBpIi6pg9B70Tf8FX8XBrTZkb29/Abb4iOWxytxx1LDxHd7OJt1mLdA+bZxvkc5QpA+Y71i3xZ7Ccr/zvFYGzwUHLEFzuYRIzfYHK8vuaO47A=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM5PR10MB1356.namprd10.prod.outlook.com (2603:10b6:3:11::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.22; Wed, 8 Sep 2021 03:09:49 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 03:09:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Yonghong Song <yhs@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Luigi Rizzo <lrizzo@google.com>
Subject: Re: [PATCH mm] mm/mmap: relax mmap_assert_locked() for find_vma()
Thread-Topic: [PATCH mm] mm/mmap: relax mmap_assert_locked() for find_vma()
Thread-Index: AQHXo7Fh8ctBc8s7u0yUW+pa6CAvZKuZdouA
Date:   Wed, 8 Sep 2021 03:09:49 +0000
Message-ID: <20210908030941.rfew4t63fw4s4bpz@revolver>
References: <20210907062650.1309736-1-yhs@fb.com>
In-Reply-To: <20210907062650.1309736-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 235db0e6-60e9-4b01-879f-08d972761ec8
x-ms-traffictypediagnostic: DM5PR10MB1356:
x-microsoft-antispam-prvs: <DM5PR10MB135668BEE874FDDA175FB386FDD49@DM5PR10MB1356.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zGZ/rz54tTuJsv9weHw3y3J9wOaz3EeJNYbQntWqQ5fPI4zsuxvEVqlOTDcNa5hz2tJTfquESUVQD3xAhi/3nUMd7VAxB9bE9WyobCC7lJTU70whe1LDZuwFqLQneJlw/qjMOgfx1thVlLgw6O7SZWf9X5CY/sKMm6zd0u7jmSDdl6Je4+DC/hd7Zh+XelTfONRSckUPFqsiGzp6JwEcH6srXaQu6YmC3XIgGNaUPkcqrxFMbhJmbeLfQ33D2+WhCSgjXUtSi4SZ6ZepXbTW8IC5IHwFN+pBLu5cxz0ZZvn2/qPa1NMm53l61d2PMTfrslqTXQN+POtLUwocayzzu0c3lQJhY27fSdbYqsC0/zzxqH1LOcMoUUbixBAvTIsGT9KR8TWLN4qO4C+JZgqRG0cIZV7ocOXfOWCw5YeBuL9ppe7drlS/a+98QGC0hrNOgwdDx1oX3zZoQoeklOZN+xL7MpEvMs/p8Yg+guBjCLzj+XlvHEU3FSsN3PuwO8ZMe2waPmrLXWCoapsOfcaQ+IQNnv5x/zElN8Im/4edqPJ1DXMgPO/xUwvWFAZuAJsR6nnYxZlb4rPF1iyRbSXrA8CTG0c8oufdLXol8FIC805TfGIBgbHOb+4TsAJLV2C68PE2CZzFdhitJY+KMkDKFwottQK1DrO5QUC0u+T+QYrXdv09JlGKg2+LBjzWpv9jk/6LHRwi23I35yfHighKqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(39860400002)(396003)(376002)(346002)(136003)(38100700002)(6486002)(86362001)(33716001)(8676002)(2906002)(44832011)(6506007)(83380400001)(316002)(186003)(4326008)(8936002)(478600001)(76116006)(66476007)(91956017)(64756008)(66556008)(66446008)(66946007)(6512007)(9686003)(5660300002)(26005)(38070700005)(54906003)(122000001)(45080400002)(71200400001)(6916009)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CrvRNUf8e6eBNTDsWdXGLjZh3YmqPkOgfT1hdd4JS6MJLxfC17RjISylL9KU?=
 =?us-ascii?Q?KeKN4/l34mi9xX682+46WD4pRwE8MXjW2FGitWYPCT8yVFiol3OrHtmR4Ibh?=
 =?us-ascii?Q?PPg5Lkqq+emuP4pn+uY++02FNM00b7DRYYCteJ7rAA7d8PpLsB/59LewR2si?=
 =?us-ascii?Q?z4/nzDpsjrmalDpvujSlFb4ULt1nmbAbUw5A2Z64QrRlCbqPfXpddsIkBsgQ?=
 =?us-ascii?Q?5CGZw3TvgKc0+mKYKAQCIQ07vKiDMv3V4C979Tib2RaN7blNJKHlT0LWmenu?=
 =?us-ascii?Q?VJXBGv4eWIKwdgeJo/r5DyQMxCOnKPcUBO3RbV4H/hv5w7BCqNanoi9oxq8k?=
 =?us-ascii?Q?6kFfEqspsaXYFNwPYUlXP1IS3W5P9hVfNCeKAC8tj2ysCEVFldjwZ4CynC4R?=
 =?us-ascii?Q?2UOkQp3aBjfo7eVCJkxgUZBOiaGZkSffLxy34guKnm/1tCTdBoxzvD0hzzU9?=
 =?us-ascii?Q?hIPda8XCEnH3lRV+Y72uTnY80mamq70Ep4XEfmQ9UAG8fZmlGLB7D8aYNknd?=
 =?us-ascii?Q?5iTHt+U3PumuNRJb2ahV31b+mJQrLKoECQc1fT/E0XfRhzAT351c3Sd3DEz6?=
 =?us-ascii?Q?Yk2XfsYIXdkdgXnfw9494RFtopFOF+rDuuvUZp0sASiiChPjY+qGMWLpdfEq?=
 =?us-ascii?Q?x3gqeYnYfRpczXj56LGB4YUuQTUscjbC368dQlrYfe6xh9HQH4AAmMkv3gNl?=
 =?us-ascii?Q?e8HtKVJ5JyjHrmPucQSlpgRQyGrQebALcCe8tK/Kdyp/TRJnK6RmqnxMuB8K?=
 =?us-ascii?Q?oCLMoNvoq8c2DK1jd9KSBLGhxEISzG7d1qb+sjNPPylrc6e+Gb+IHM7YbuKF?=
 =?us-ascii?Q?4NJ46uIz2rppl2rHZ+dr3M9+0KcXcDNb/py7iYQe5Fdg4lHO8ftGdygFILC3?=
 =?us-ascii?Q?n5mmYbyp5sS5bZrLSoQmbpku//ebUimRRDgBsLhwDk81ty55Rk4qOu7vzcbD?=
 =?us-ascii?Q?bnNyXkkP4nbxI1t2ITf6UwfraxDuNDWHoHEDXJPsTMG7pwlU6wgi4POq2T/H?=
 =?us-ascii?Q?d3Y+xdPBh7s5qMoo1uJgo86ZL0HAk3pzs6UWGrP67Sn2iQVPG0pH15OxOztV?=
 =?us-ascii?Q?7dUAXNGIY8FSa83bQrk+cW6FG3QwQ6YmfRFEa10jH64iM3qnzG8lMngUSwUg?=
 =?us-ascii?Q?u9MkPAS5CREl15iiqUAlqv5JSm0uHo3DZJDL/e9xjbY+m2R5Eb+0wk/iBmDF?=
 =?us-ascii?Q?d46kgDFndsIlQMHYK0FdmtHQyFEIE1cWJ3MSaCUaRda3vBim5vjnDpos127f?=
 =?us-ascii?Q?V78RwmQhT5mMFgAIB3NxwO5bObZGOrKgIcT+lmEPxr+R6fJ5O2n5NTW7Lo3h?=
 =?us-ascii?Q?MYOBsbX8akNd2oTycUXAYEG9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4794ABB6ACEF734195A99F9CA04813B5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235db0e6-60e9-4b01-879f-08d972761ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 03:09:49.6825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4YHE3G8UudsRKN2n0TK2gYE60ggVJgewG/FSbpeJUTFvS7L/tml9ob2HdzcbbySkRkQlk21E7zjzHzcqSI8Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1356
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080019
X-Proofpoint-GUID: bySOgt172_fqpS-wht_WSV9gGBDWlXsU
X-Proofpoint-ORIG-GUID: bySOgt172_fqpS-wht_WSV9gGBDWlXsU
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* Yonghong Song <yhs@fb.com> [210907 02:27]:
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
cked() annotations to find_vma*()")
> which added mmap_assert_locked() in find_vma() function. The mmap_assert_=
locked() function
> asserts that mm->mmap_lock needs to be held. But this is not the case for
> bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.c), whic=
h
> uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock is not he=
ld
> in bpf_get_stack[id]() use case, the above warning is emitted during test=
 run.
>=20
> This patch fixed the issue by replacing mmap_assert_locked() with rwsem_i=
s_locked(&mm->mmap_lock)
> in find_vma().

I'm not a fan of removing the lockdep check.  I'd rather see find_vma()
do the lockdep and call another internal function which does exactly
what you have below.  Then you could call the one and everyone else
could keep the code they have.

More importantly, since this is the only user of the
mmap_read_trylock_non_owner(), is there a build bot that could be used
to catch errors introduced in this
path?

Thanks,
Liam

>=20
> Cc: Luigi Rizzo <lrizzo@google.com>
> Fixes: 5b78ed24e8ec("mm/pagemap: add mmap_assert_locked() annotations to =
find_vma*()")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  mm/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Alternatively we could add a bool argument to find_vma to indicate whethe=
r
> mm->mmap_lock has been held or not. But I would like to report and try th=
e
> simpler solution first.
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 88dcc5c25225..8c78b85475b1 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2275,7 +2275,7 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
>  	struct rb_node *rb_node;
>  	struct vm_area_struct *vma;
> =20
> -	mmap_assert_locked(mm);
> +	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
>  	/* Check the cache first. */
>  	vma =3D vmacache_find(mm, addr);
>  	if (likely(vma))
> --=20
> 2.30.2
>=20
> =
