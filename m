Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810E1403F21
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 20:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhIHScu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 14:32:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5218 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345602AbhIHScs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 14:32:48 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188HxNIB028112;
        Wed, 8 Sep 2021 18:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=by4Mo6RlOTJgBkFVhEUVLNSbryNutopw2BkNJnJP1Rc=;
 b=s1ppqnTrsLMCYrC6xC4N+2XcvtSzxHcmshBa7zPL3YXYZtbAl+J1cm54nY1dfSFs6/ke
 2UnPYa9pJkSNi67JxxyYqVwBj9NBL8kKn3p9weOnzbhxp87ntHGtocoE64oSyCSpzYz7
 VL1rlVYq83TUx5gYuO6ittJGKgit9pk4iXmr6QaqAZxWzLeNWq4cFdmaRetgKW+jA9/a
 R6fCu7KAsS97dWJNTiUX8cxFGCeISHwbFWHbCAuHHMxwHdIw50ZBJzrSU3TepudNnlbm
 QxwfEhG/HF/WSnWJI7xJj4lNRAEToCUFtpmP9mQ7NLOc8sv56lcPwJUo2dty1X3RZQ/m VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=by4Mo6RlOTJgBkFVhEUVLNSbryNutopw2BkNJnJP1Rc=;
 b=Tcun9lZmYcCoLtCjvnr8PZ6XLpkxmWU6lElwV1UUMegX6EdfgAg/ukWPXNtf4RtqZh/U
 vUdU82xGOPXtn+VrcE6svDoKEcuWPpVYnNENcD+V9VkJkNv+d2o4szirINyULJgdjP3y
 LfdvrJ0WaKiIz47yI0lDQDU+B9Z41A0alrXr9M88SEl8LLDEXYfgVkiTz37n8PkLdqpw
 MWR+vIokNMc5xSbuzRwKhO5lsGVpHARTH1t6MwiA3UAVZPfo7R1oaHumwQUsvwcVTis7
 ryO0cTYg952AOM0UOYybKwjD4sBdAm2sSosulLMhMQUZE3omMuwxhNYlRMH3b3v650mM wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd8q3qk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 18:30:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188IGI9Y002616;
        Wed, 8 Sep 2021 18:30:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by userp3020.oracle.com with ESMTP id 3axst47uxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 18:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHDWCS4pld1K9/jywJXlpGgnkGBEZweiV1X4z4QCUTLLA2hnKipkE8+hgfDPmCG9GkzVNJfi6iFLJb259JHoure5HZeruk5PjVU/Gj81yCwNS0M5y204/eWeT8u+jcdMX/uqEOq8ddMSzpA+02/vJd1bSOjrC6u0vYwRn1Id8/WENBIRvkcQLyjM12bc5CCkfmO3udzWMX8LsBzlcTseAUx7S95Gj8zgneMCr4owNhoJihWhb63NzPFbIUxuhXEgsFzyzlbrpwxHEXSAFWgDaaHxNl+My4RViyQpAD3G1ildbnizrYNAC8hdWnjYCSvfMMAyJR76WFUlnvcEMcF20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=by4Mo6RlOTJgBkFVhEUVLNSbryNutopw2BkNJnJP1Rc=;
 b=OjMLc4A9gu0HUNqkWGWouyfcp9uF8WiPn6VabUILRy3ERGP+vzKoGGAbMKgcMfrl9PqvuBzh0/TopS0vH8M2dG+fDc4ji5ZRvrmZ+fVjhpOsMr00mFwqn5c4rbuZ1US+kB3MSbmEUfDpLiCWBn2EA6W8kQ11LaJzf40nN3ZxcKesBPm6//sFcZrsJpOdkmSVeB5Hs0+9rmZGgdhT1yyt0r/5MMrxFv/2lKs+K39iwMnAUMGLpc4QpphmHM0cz4Vwpa5RY8TG2PH8DxMXvD9+MqGHJSvtAlKum8jH3TCaiHZwuXSXPA4higyherOiscWTyCH47Vk/7SsZNVE+nC9yNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by4Mo6RlOTJgBkFVhEUVLNSbryNutopw2BkNJnJP1Rc=;
 b=LExKjI5d5tp5qQ5sNLsl2i4EzeWnby9x4nP6k1BSOT4Cej7heazGlKBKyGZB/SglV0o3+GdHaxtSLOqrECuw/EAQyfZivnOSLxlj1FdLxZG87NQlgYOBioTCWFyftzFu4ZhhMl9WUT7k/1b2/dlcDRKJE5bdAVfwA1+HbCjRPzg=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB2700.namprd10.prod.outlook.com (2603:10b6:5:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 18:30:52 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 18:30:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Luigi Rizzo <lrizzo@google.com>, Yonghong Song <yhs@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "walken@fb.com" <walken@fb.com>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Thread-Topic: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Thread-Index: AQHXpGw9DgXD+GNr6U6ppzcLTIluVquaDuuAgAAaBwCAAAYWgIAAB/aAgAAICwCAABANgIAAEJuAgAADVQCAAAjagIAAAsoAgAADfYCAAAGKAIAAAq0A
Date:   Wed, 8 Sep 2021 18:30:52 +0000
Message-ID: <20210908183032.zoh6dj5xh455z47f@revolver>
References: <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
 <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
 <20210908151230.m2zyslt4qrufm4bv@revolver>
 <f5328a05-ed3c-a868-9240-1b0852e01406@fb.com>
 <CAMOZA0+2KLgYTXDZHGUYFnYezee=_hH6kFVM+-n2ZQuFTfh6yg@mail.gmail.com>
 <20210908172118.n2f4w7epm6hh62zf@ast-mbp.dhcp.thefacebook.com>
 <20210908105259.c47dcc4e4371ebb5e147ee6e@linux-foundation.org>
 <20210908180258.yjh62e5oouckar5b@ast-mbp.dhcp.thefacebook.com>
 <20210908111527.9a611426e257d55ccbbf46eb@linux-foundation.org>
 <CAADnVQ+5m0+X1Xvgu-wYii2nWvAtEfk2ffM6mQTaiq2SPM1Z=A@mail.gmail.com>
In-Reply-To: <CAADnVQ+5m0+X1Xvgu-wYii2nWvAtEfk2ffM6mQTaiq2SPM1Z=A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73feea33-c8c8-4d75-52c1-08d972f6c9d6
x-ms-traffictypediagnostic: DM6PR10MB2700:
x-microsoft-antispam-prvs: <DM6PR10MB2700646CD2914F8C0768521CFDD49@DM6PR10MB2700.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nC73SRwsMAd7bdxRUWQaaCDNjK6jbcgbj/hrlbbgDOVsxx1Q94TJl8fe95UMFwsmbhWrw4YCyC9JfO+i13OuJPLxsmqFLRGnWEHcCydrvqzxGlWm2luPjGmMpQHTMfPbix7L6p950LihyFfwBDYiPEoKiOHXAR11i/1Q+/FnGmmzSdAxRGqc5iDMtsJu5d6sVdRw2qY50Af9R7p+Z7lwY/n0INmfcl+/qZF/WuBw8N1TuJ8p3vwom77OVqLtxlBUeYk8lZ0jyQoXmeLiqMdnwsas9eRFq27JM7g906tRyvFHVexHha4S2SWRtWNH7unIn05HKRyMj1Xf6wuuIiMxn0a27YGN0+qteW7ysaRUid9ktkw0GuV1eI/buq9LBayg6IpfUO/bHH6VsRj/6b4kmF6ehqE8rct9mswjmi3o74FxYBem5yWyMKdAPE89uLMTr4GfXjldhMMDBcJ6w/HDxR4dY9maCKn5YRohaMgfesxF5pMaCJ2w+4FAbwHl2F8d57J2nRYNCf4mGEmg3qpJF65bypcZrrjLJehRlNH5ucdFgSHBtAB0X/SgHTJMcDc2ertU9CVTO5wTM/zxU6x7dC4N60o83z592oeVrvoSXhd+0NitEEtqZUSjzbU5ZCbU9c+gFqV4o+CTOpw6bHFNU2H/GsOl0M1r0J4jEu/F+PdIKneBY2R2pAh1JkKFptP+eDIP9zp6xxyGbQDJ6b6Mhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(346002)(366004)(136003)(39860400002)(396003)(376002)(44832011)(54906003)(2906002)(8936002)(33716001)(91956017)(316002)(6506007)(4326008)(38070700005)(7416002)(86362001)(71200400001)(1076003)(478600001)(6512007)(66476007)(66446008)(5660300002)(53546011)(66946007)(64756008)(66556008)(9686003)(26005)(186003)(8676002)(6486002)(6916009)(83380400001)(76116006)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lLMk2MTqUdepm8glLQ51azlTgEYbZ24VEwGENs960FB7oWU1fQaw0evNMYyT?=
 =?us-ascii?Q?iPSa3tInqRd/onxesQ5tG+uuFWd08CWuokLVfuyY3ivA7KR1+l4A/6VU4W2O?=
 =?us-ascii?Q?QVCxpT+AUbW90xhiNZse5yEy26jsEAuMGtmV1Vcq1+4G8AU3L/3xtAYtI5E3?=
 =?us-ascii?Q?N7+HmUh/xJva5FK3N89dtuGaFrtevsLYTNeO7XEwn3fYMW2ZpG7exIQ80p23?=
 =?us-ascii?Q?CPzYwjEMk81fxQWPw7D8Pz0984nbQKoPw6FWWLyJQ2DLzF23mmuOZrkahI4Y?=
 =?us-ascii?Q?aVylORdSuF7lZs3ZKAh3dDpfLaXUSwU6iorP88WpeNjOzk+JM7NCfrI3thVr?=
 =?us-ascii?Q?HNTt2HlF1sx8prP7Ce4I6ETKybEwzv7OuKu8VgGW6gZd4u40sEEGr3x4htfA?=
 =?us-ascii?Q?m1ra+cRjV+MYP928FBCrtYKiCm5dAD0lL9A4ajWFttN6FC6kxDS5DU8tlKz4?=
 =?us-ascii?Q?padHnI5pfnmknzoMAk25G/YV+vZXd5I8Y9TYZaPJ3oy1yymWYN/gEhch3nYX?=
 =?us-ascii?Q?Yg50T+sTAuDA0NrCqqt1BL3BsJqYA6RtGZgABQBquaWDhExjGpU2FWoK01+Z?=
 =?us-ascii?Q?ePf7wM5uXFgY6UhW6dAH9ckU3bFLQYiKz4Lp40ONojknZqk33BXoD1GbAfye?=
 =?us-ascii?Q?zHtMOm57/6chz1lr7ScyF94Sqp/vI1xM1WFGQmdqkkHr76N0plf44ZjpRRc6?=
 =?us-ascii?Q?ZEy1AR60cWhXMvVgFh2dEeP6/w18iauu6Aj65j5LWEcEiwlSN7YqE6W0WbcG?=
 =?us-ascii?Q?1roEhrRut3lQac/KRNB2aA3IgpCcWaoc5KnqEHEt4CUNgHmdZVXaZks9lujR?=
 =?us-ascii?Q?13zklvb48F3Dm2rOa6/FVBmJMcjOQD+Gl5qmlIWBtEY+B8vxK3zztjqQ70Rl?=
 =?us-ascii?Q?g9AixkPZ/nswmUtUUBgvotfYbyzOrjqRBpRpnRZ1r9kQId+QnpL+x7ARz7rz?=
 =?us-ascii?Q?Y+eElWKFBkhNJSiAdgBcILT3vYgn9VEj4ONybhJVIopoa6+70/g48zZtKu8t?=
 =?us-ascii?Q?q3MyYW/iYAkfL09m9hnOXPQFnNpVQBe+dgrbZ80++AT3wqGgwq5PRU/l7LFh?=
 =?us-ascii?Q?jAEE/X2MjsX6mITEgnoOlOOSwSQKQ5eXR/4P9UYq6gPg8ezuKlkuoVTtsOYs?=
 =?us-ascii?Q?0XzyHuSwhWVsc1VU5cH26e9zZXFuYM91FH/9KEBY0JTT1nHPYBMe0xg8+iUV?=
 =?us-ascii?Q?2AvEilGwJSyJ9hNS9M5tP13//6jnOdeGE4Jf8KXR1AbkI+tEjyXipzMZzHbC?=
 =?us-ascii?Q?N8N1vzki0F6GJ4JMSt3EqQM6H7cHG8mbiSKn94lS5tjgl1ElmiBwlCkGXzXb?=
 =?us-ascii?Q?V6dvlapqU5Y+gU0r5uTsHCmX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C51FC75D80B71C4283F83006E0C4ACAE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73feea33-c8c8-4d75-52c1-08d972f6c9d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 18:30:52.2467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuBy5YiXGTQBHoFNapsZSbQ234/95TIhbFV1HLEf+tDP6owveBysF0tYhinM/7SvdbNl+mTJrJBLGaYo54Khpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2700
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080115
X-Proofpoint-GUID: yP_2zbxISsMhAxcvWTyHLIdmZ0kb-8-7
X-Proofpoint-ORIG-GUID: yP_2zbxISsMhAxcvWTyHLIdmZ0kb-8-7
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* Alexei Starovoitov <alexei.starovoitov@gmail.com> [210908 14:21]:
> On Wed, Sep 8, 2021 at 11:15 AM Andrew Morton <akpm@linux-foundation.org>=
 wrote:
> >
> > On Wed, 8 Sep 2021 11:02:58 -0700 Alexei Starovoitov <alexei.starovoito=
v@gmail.com> wrote:
> >
> > > > Please describe the expected userspace-visible change from Peter's
> > > > patch in full detail?
> > >
> > > User space expects build_id to be available. Peter patch simply remov=
es
> > > that feature.
> >
> > Are you sure?  He ends up with
>=20
> More than sure :)
> Just look at below.
>=20
> > static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id=
_offs,
> >                                           u64 *ips, u32 trace_nr, bool =
user)
> > {
> >         int i;
> >
> >         /* cannot access current->mm, fall back to ips */
> >         for (i =3D 0; i < trace_nr; i++) {
> >                 id_offs[i].status =3D BPF_STACK_BUILD_ID_IP;
> >                 id_offs[i].ip =3D ips[i];
> >                 memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
> >         }
> >         return;
> > }
> >
> > and you're saying that userspace won't like this because we didn't set
> > BPF_STACK_BUILD_ID_VALID?
>=20
> The patch forces the "fallback path" that in production is seen 0.001%
> Meaning that user space doesn't see build_id any more. It sees IPs only.
> The user space cannot correlate IPs to binaries. That's what build_id ena=
bled.

I was thinking of decomposing the checks in my first response to two
functions.

Something like this:
--------------
diff --git a/mm/mmap.c b/mm/mmap.c
index dce46105e3df..8afc1d22aa61 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2293,12 +2293,13 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
 EXPORT_SYMBOL(get_unmapped_area);
=20
 /* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *find_vma_non_owner(struct mm_struct *mm,
+					 unsigned long addr)
 {
 	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
=20
-	mmap_assert_locked(mm);
+	VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
 	/* Check the cache first. */
 	vma =3D vmacache_find(mm, addr);
 	if (likely(vma))
@@ -2325,6 +2326,11 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
, unsigned long addr)
 	return vma;
 }
=20
+struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+{
+	lockdep_assert_held(&mm->mmap_lock);
+	return find_vma_non_owner(mm, addr);
+}
 EXPORT_SYMBOL(find_vma);
=20
 /*

--------------

Although this leaks more into the mm API and was referred to as ugly
previously, it does provide a working solution and still maintains the
same level of checking.

Would it push the back actors to just switch to non_owner though?


Thanks,
Liam
