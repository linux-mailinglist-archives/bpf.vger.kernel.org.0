Return-Path: <bpf+bounces-31068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9B8D699F
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 21:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0EA3B2708F
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 19:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36BD17FAD9;
	Fri, 31 May 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dRftjTHz"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021007.outbound.protection.outlook.com [40.93.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821F7F499
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 19:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717183031; cv=fail; b=jBi2bYLyjFzc6vMi8mMkPiYSqGeo323dZ/eG4r7MjLz9/MmIeDwWbvSSBZahgArdJSZG6W+/X4p9KWkifqjY2X+o0DBn03FVUt5jD4iSpO9Hyjoi4bNfb+SC1T2AUxOVrA+eym62Bps4Kvh2R4QWsyxGHe4STTqECaDTmdIET0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717183031; c=relaxed/simple;
	bh=ctF56jR773otXMDMEY4ngFiDWA4AtqXdhCXIaGqWYv0=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LTT1IC+FzoiCBK53tCl9F3PLxyvf3TdnyqWtBdQvDpkzbDP6TTVSNCmBO6zBI9aVu8A5iv0eaDGZ6C4mU4wwB9qXI561H5H2lcY+wTBSoCbvSYyIwfoRAX19IYusLgUiIZd9LhJss+j9Ac0U7D6Ia+IKWKTxOOnhDnfXUmZkIpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=dRftjTHz; arc=fail smtp.client-ip=40.93.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8KuinKG/QzyD4956Cl452yTAbCzK4odLs8EBy1BTDYLo5XoOdZTvWbxO4MIrsYtkQTjHzqCluXYww6KKY+qEHkgIUKw5MURkitXkz0D+I7BafkPx8gQ67888LO16Ft9btfbWgjG2pLm87IJ261l83RWQiid1MAivmkW09TapxLpA0gt66LiXqC4LDypaKVsp3E5FGTb1eCML4auLWlnEptG5Ija1Pf4cshZ4h6IJbHQ9NuzaYY5u3VmbdW5DoNHEkG+Sw/dq53vu2/MAOqyjhX9rfMwtuteSU1A9pH2gUCq1sVKScnkT3RA6N1MaDcLUTYj2zvH4oH8vhpZrvjSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctF56jR773otXMDMEY4ngFiDWA4AtqXdhCXIaGqWYv0=;
 b=Z1vMUZj1hbkFOIkBuIjO9B0/LnMzoeZ1rmP5h+TujbA4S7jrC3ZRF4Ak4Syj70XHFmsoO6hN3ffufYlNIw2LhUAtolW9FuZ26PCBNoxoTsmbb2f4GzXpR6m3XyUpZhvsbTkzBZsTkTjjZAfeyxfhGqZUrPY1e3YJCEiX2AZmITxIFwlC5h+M2lwhVRbP6zgzhQeoudLx+3gBDJz05ech/4sjWBau+BVkCTAVpmIlyIpdLxOhdoJ3arbJDXEWNvmDCxPo93O745iF00qPeBC+dl+OLWBvHQQqgoQKCkY1ANPtQ+NeIZXUSzgHFNv4qQI7nYqqOOOMeRBzkD61MQsuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctF56jR773otXMDMEY4ngFiDWA4AtqXdhCXIaGqWYv0=;
 b=dRftjTHzrRDPn+bBEj29buD1DEgytECLl5iICGN/1ByrytJBDvyPKSXPns9sYVUgyediNt3JZMuHDDI70OsCtUph5rP64oOOxh44b6h5wUhweIS2jYq3BjI6l/5DAoNTpCkfI1T356rZ9K3UGUIwcDqk8SNRcvQq8Qfzlz8f7rY=
Received: from MN2PR21MB1455.namprd21.prod.outlook.com (2603:10b6:208:204::12)
 by DM6PR21MB1419.namprd21.prod.outlook.com (2603:10b6:5:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.8; Fri, 31 May
 2024 19:17:06 +0000
Received: from MN2PR21MB1455.namprd21.prod.outlook.com
 ([fe80::518a:1143:20d9:7346]) by MN2PR21MB1455.namprd21.prod.outlook.com
 ([fe80::518a:1143:20d9:7346%6]) with mapi id 15.20.7656.005; Fri, 31 May 2024
 19:17:06 +0000
From: Alan Jowett <Alan.Jowett@microsoft.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Behavior of BPF helper functions like bpf_skb_load_bytes (and
 presumably other kfuncs) that have out parameters?
Thread-Topic: Behavior of BPF helper functions like bpf_skb_load_bytes (and
 presumably other kfuncs) that have out parameters?
Thread-Index: AQHas4niQvoBBtzhLE2me8UA1rkUbA==
Date: Fri, 31 May 2024 19:17:06 +0000
Message-ID:
 <MN2PR21MB14558D2F7556683E57E252B2FAFC2@MN2PR21MB1455.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-31T19:17:07.229Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR21MB1455:EE_|DM6PR21MB1419:EE_
x-ms-office365-filtering-correlation-id: 40f72a20-1dd3-4a06-dee7-08dc81a642ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?wHLFts76peGHBjH85He5LH4P5QZ3qD+rgVXg5mE1Bq1fBoFSD17c6pLse8?=
 =?iso-8859-1?Q?O3l7ePQ0swjc3kpQG8tFWEH9AR2utas0z3QyxlgEVaJly4KvCa7A3DQdNo?=
 =?iso-8859-1?Q?CpydBe/6XDOp+WeSlBe9p0tO2+0/qOL48PsWupxiay4ITD9mbyHfRDuWsA?=
 =?iso-8859-1?Q?lW8CYmO8lRydrr27cu96E0jyYLZzg09A9pgG50Aahnx8zjc1cA35fKa8E6?=
 =?iso-8859-1?Q?cDz2Np2UyFwasYn2WXFw/1ARUraOdT8NLYymVQRFxiK34KNiuXRwV7bSOw?=
 =?iso-8859-1?Q?YZBUe/db35llsqCsEFG0SSzGsaRv83qPDG6OFDv7MxSRFpr/EJJ6nQ29t+?=
 =?iso-8859-1?Q?XjThoFgOnPPBKOCj9uJ0sgofXDgTGtJ8poiGMKfT965QTJJkclR1RROtUj?=
 =?iso-8859-1?Q?84VeAXYXkMhy4N5/CR0XAFATfcvjJ6VFW3p/dvb9OhHPaX94i7g0GVJ8cz?=
 =?iso-8859-1?Q?Ra2u4rtEKHLAlk6zp3BT8e0DOt1YQVaYM+g8piz3CPumpUShD20uK2xt0J?=
 =?iso-8859-1?Q?vM7dmaXOkF9XtjEQvmGyeY6CFi/xagwzs2mDcN9BeIpX/V7SBQR2CB+ZXF?=
 =?iso-8859-1?Q?N0eYFhgwiP6ORPZWZT8PGMC02AQCeh99W6K4m/E1RByYfR3LE5AirGyJ+O?=
 =?iso-8859-1?Q?mGKX4gkZtIhWZEJvwUWMwpX5kAPLCktFAfsOznKxljzQip/w3o0Q1h1gMQ?=
 =?iso-8859-1?Q?LK4P1k0qAFuKLaN6SBjMbreX8zv1qe2hZqc9AFj1G5M9S/RYU49Pd/puIH?=
 =?iso-8859-1?Q?ixGO8yFyH08VPiuNoVaRiFv4i5fzseBnK4WoEGhQTLRs2pGs/SvLkJLxBk?=
 =?iso-8859-1?Q?r1Gub1yeCDiZOvIOZLt7YlreAbJ0lq6KimBAsgrxaQlplr/C2afodBiRc1?=
 =?iso-8859-1?Q?9TKKB2ePZwvEPP/NYBlMe2wQ4ru130QITcrZqm+Hf8OejbQJ4vBW/cfKw9?=
 =?iso-8859-1?Q?S8i/tUtbaGvPKktw22MVFrJ2K/AVXd06jxXD1a2Ne6ubQWeeKfrAV/040y?=
 =?iso-8859-1?Q?0yR4AdF/hQeMT2BuRxpO7sw/rlwNQKKQyGk+buc5FPXopHjTiesVEGCkdA?=
 =?iso-8859-1?Q?D1h59i3FfIcv083cPpaERHjS4VF3oF13GnUEkYtE4h3IB2b8aps7FAPFwb?=
 =?iso-8859-1?Q?C/lMHqqTEzfWfi5lO8n3lfDk1RlBVjX8ezy/VF4Sv7t3sCG9y31gKnjLAd?=
 =?iso-8859-1?Q?jVCrbJp1M+BH9BDeU+XZZ20MSMf2RD6VHupeHc15SzJ6Jkv6v79Yy3kBE3?=
 =?iso-8859-1?Q?YS51DYb2XYBcrm+1e9BR9LOCIMFW7QBOcAwf4JcdU8ennBS8BiT28tHFSl?=
 =?iso-8859-1?Q?T4EdDvauCKnPSdU/++C0DrsHj7R7y8rOixqOnabSrQRkf9GrqjJ4W45bf0?=
 =?iso-8859-1?Q?DuCHizw2UoXxrppW8taI1sD5r/Dg1otw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1455.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fTvMDEIkQhi4ISjWLXsJExYjk21laSIETipv25Ub/CAgHHknQNo2hAAj2A?=
 =?iso-8859-1?Q?+yXnECAiMkKZmDaGsTz7Lgburo88K0Smift0PvU2sD7B354awKQPBFwRQS?=
 =?iso-8859-1?Q?im8M53wK+3wq7YQKn+cyg6H7ZblbfNW+flJQb4sWwDVi37xaTubdA8THiM?=
 =?iso-8859-1?Q?a5H9U3MQoaecC52uZ+IcSPlW+rkEN97i8lfORKOYaHvc/jzphyLFE+6qZG?=
 =?iso-8859-1?Q?ulny9WQZHBzxn8o0pfJXg8XxDRc7lGHrfm17LcSb6yF2aBQfhjxpSr/30o?=
 =?iso-8859-1?Q?X+mpu+smG1f2KhpOSOsXydMhc4DHGLGGPH6Yj7jX+6gk1WJrA3jaZb/kxO?=
 =?iso-8859-1?Q?mXJQEV6ebgl4sLhdb8vd5vuUV1kjS9QF/btYb2KDlsh1d8CCYQm8G8qTgk?=
 =?iso-8859-1?Q?wwiTVOmWebsYoqiBm5ODDHBmIngDBdYBJOIeCCLUm7zqNkrc2WZPR9LkBK?=
 =?iso-8859-1?Q?4IXAUqmNaB5ur8kj/KM/l69J9a7BTLYkWmQ8tnnjJRbF6Ip39FBsvu6Rex?=
 =?iso-8859-1?Q?EeY/1m3LeEbaU9j38pMDwaPPRYz4zjLTMWbQ4WadoymyJQT2KV5r4uBCy+?=
 =?iso-8859-1?Q?BHcfF9nihl6L4fbG709Vml2boE8OCEuTGPRt6D0ehqTe7m9fg+WbqvuEUH?=
 =?iso-8859-1?Q?vd0Rth7S3mzWllwQaU0SeUfub1x9lEpCL4StkezBuQU8ZLzP+Jo33RlW0P?=
 =?iso-8859-1?Q?3SappOBDVUO6xsxy4YF/yq7hBBOmjHCUMBQ9QfABxpUBXKUK9PDEtrTEI+?=
 =?iso-8859-1?Q?y8bDaVsteNnEyTdC5cXCvy0O0/XG3eKdlu04zO8Uj0druhpfmmXOxiqsMY?=
 =?iso-8859-1?Q?/30VFqWsFsIHuOfl1Bjf6QOep0lNCQy+GroP4sKuxHBvggfaydLKXD7kw+?=
 =?iso-8859-1?Q?U1/LO0QJQvOi/UUmAw4PzydammjxS4H778K+osZjAa6Ftje3dNgXejuA/6?=
 =?iso-8859-1?Q?smBYFMtjcaAdC+B4wvQB3A1MwJQvQPVbMriSn6HoR4EB8EP7znvLibLYF0?=
 =?iso-8859-1?Q?K4OYeUDcd+b4Ki+EZsIaIdrCLXp2dmbgkKDQxAhRYxdelhkx4FcSyIxF4Q?=
 =?iso-8859-1?Q?6PzO7u1hNu6gY6CX4U1AV8bvIvaR6WDAinO/kAzBLCqGKjDFAKsB8vs6CP?=
 =?iso-8859-1?Q?AZY1utEd+f5XDtMgLJ2wJyRkiTBwIIWz8fnVygR9AS/3JfIUEncfrSlsTM?=
 =?iso-8859-1?Q?UZ7VD/2BCa4gKTIk//cqkoThJOJ39IM3naT2TPcGvZtWa/eacbnMULxZce?=
 =?iso-8859-1?Q?gZsJ9FEqOmeSb8QkeXQU1mgDN6xcuvK1kDZNRiQ0iOnOVCVBPGlqKJ4iM1?=
 =?iso-8859-1?Q?+YtzUhq8A1Ef/8d1rGwB0FpatFBxnx06VhUhnrmtEtQ8DYNcq92SVUh7p7?=
 =?iso-8859-1?Q?eVhRzi1Q+JPzmgs92AcOCNRz9IOFZ1vL+yAx1u2m1IFsWyGGJYnZCDMmw7?=
 =?iso-8859-1?Q?A3ixE29lKyctnnD4rA1eGYtPnGTyaGNFxrPr/r8L1irLui8xgAeEVbNwS4?=
 =?iso-8859-1?Q?HnkyokLu7GouCuVv+RlPonxlfZQftDbhSWD4g7WkEKGNegKZp7ovINjZml?=
 =?iso-8859-1?Q?28ir3U9sKrGzEH9C30UodHMpaBK2Jr0RqR8P1k23mIdfNMwBRRWcO7JXQg?=
 =?iso-8859-1?Q?hDQMJ6xxTcRH2G9H06PneQ/JlG4XMndOpAwQhiXjcP4UjDwg09GLvsz6+d?=
 =?iso-8859-1?Q?LCtniJ+nNIE0PzEspkY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1455.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f72a20-1dd3-4a06-dee7-08dc81a642ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 19:17:06.6598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q/6GMixNCDspNmkffFCVx+jgmQT+iW2RAFxHSyN8cp42JtIdG0EnS7hmYREaw/rM7Zk9QhmpUOABqMUhB21c+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1419

long bpf_skb_load_bytes(const void *skb, u32 offset, void *to, u32 len)=0A=
=0A=
What is the behavior of bpf_skb_load_bytes on failure, specifically with re=
spect to the memory pointer to by the "to" parameter. Does it always zero i=
nitialize the output? Is this a documented requirement of helper functions =
and and kfuncs? This somewhat meaningless program seems to suggest that the=
 verifier assumes that the "out" parameters are always initialized and I wa=
s wondering if this behavior is documented somewhere or if it should be?=0A=
=0A=
__attribute__((section(".maps"), used))=0A=
struct {=0A=
=A0 =A0 __uint(type, BPF_MAP_TYPE_ARRAY);=0A=
=A0 =A0 __type(key, uint32_t);=0A=
=A0 =A0 __type(value, uint64_t);=0A=
=A0 =A0 __uint(max_entries, 1);=0A=
} test_map;=0A=
=0A=
=0A=
SEC("socket_filter")=0A=
int UninitilizedRead(struct __sk_buff* ctx) {=0A=
=A0 =A0 uint64_t value;=0A=
=A0 =A0 int key =3D 0;=0A=
=A0 =A0 if (bpf_skb_load_bytes(ctx, -1, &value, sizeof(value)) < 0) {=0A=
=A0 =A0 =A0 =A0 bpf_map_update_elem(&test_map, &key, &value, 0);=0A=
=A0 =A0 }=0A=
=A0 =A0 return 0;=0A=
}=0A=
=0A=
If bpf_skb_load_bytes doesn't zero initialize value, then it will leak unin=
itialized stack memory. The verifier appears to accept this, so it presumab=
ly assumes that value was zero initialized on failure?=0A=
=0A=
Regards,=0A=
Alan Jowett=

