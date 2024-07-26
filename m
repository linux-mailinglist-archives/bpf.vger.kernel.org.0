Return-Path: <bpf+bounces-35779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F75493DB31
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 01:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E782B233D5
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 23:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D26F149C4C;
	Fri, 26 Jul 2024 23:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="AEA7cOF0"
X-Original-To: bpf@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022078.outbound.protection.outlook.com [40.93.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D11CD13
	for <bpf@vger.kernel.org>; Fri, 26 Jul 2024 23:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722037541; cv=fail; b=jeepbR45mrbBZZQnPHEykS7+Z13WLY30iwWhls5thWVyBCwsxbTEoux2L0fpOcgXQcbzvet/0PDPMvfTDXh9RuhzMEapOFYgWfyZVZCLPDiyxaSzy3NQt8gk6StL3DHBy2LPv2iVCqqwAH4VisLMpsNbpYFVnBhuCj1EYZ5R7E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722037541; c=relaxed/simple;
	bh=ZnvsUhB+uujSE3qp7ohtxTogWVH4x1SMSJ5yZYBkZ/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fscjpScWK6vPZnO6ouXyaagJlzOrmVybnOVIjm2N5OhQAVf0johngYEvjflH03I1OXLy9sm7TS0gLFUwO70J7QMAEax1pWYKmZsubpSu3+qfwezVflPVXA6OiBpQIC7j/5pELxnHmiSmFJMNTq5KQTI1sYJAjGvhZocNx3wu9ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=AEA7cOF0; arc=fail smtp.client-ip=40.93.195.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HakhpA6ayg0GCEUGAWWerkjVyCqD+ECwF5Uz648FD49TxGBg0h5dXyqpJX/hDj+W43D2kAYwMhgBazT95HoWBVbONRJHLNGQjW89rcsmJAuKuNL4CeiMwHWZRHAsD46zbIf+8l3VDZmt4vDzE9mdFd7JKK9n4IqTZl7LFng0dt42oh0RCVy220hoqfBtsl7xDeUr1D7yuydMtR1QasJgLGW+bDaXeTmvsjsbMthK7pATx9OK1qwHP/cA9ea0fjLNhWxyi25RfF9egOqPcWp08ySPTczacWUxn6xFh52dTJuMPzRqCLbDXzrFiGwwYjucFbolB+EHPc+zEWxB8u/d6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlLaWAVIRj6Yk5sZ5aawwq8yDIY+KNjkR7620BMPNB8=;
 b=LW1PIAC3UIK8Xvofp57K24romTwuIhzbIHQuZvRnda/zK60PyQAOgocHpJRZjDT7otKTlE4F7JdT2jgvFU5kgyr4eVNESd+PkMDaufxn0ty0D/1+XHYbT+ysgjkD5HRLaG3nhomaUlxZ9xbaB3nnIZKoJz5EkUnSZHRxEICwe50I/E02sDx0jibctCUOorma49S017pPZLPcjEJTlDeSIC9hzWrlIPKIj/blQqFFi1P1ybDjFk/m3+BBN+xijQG0uW2r5IDl2EITgmFdHshmlsXt58CIGNAvdSSY4at62TEIa5RNBC4IL7RaovxrBrYQ4hUDXNOFbXXy6A/H3pACIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlLaWAVIRj6Yk5sZ5aawwq8yDIY+KNjkR7620BMPNB8=;
 b=AEA7cOF0zucPi69lgu/6Xnw7JGG8ScCEWClcsvjVpeglSh/OJqojgk6GKi+RoutE7+Jc/LqgyNixyo/U8n+o+7SX8QJwkYRlFoXjMIqP3/eZmbbFufhdkCmVVcq4UO1e4qR1dn933cBSrkIQ9LwoQKE1PHkVy9370wpmR7h6xH0=
Received: from CY5PR21MB3493.namprd21.prod.outlook.com (2603:10b6:930:e::6) by
 CH3PR21MB4421.namprd21.prod.outlook.com (2603:10b6:610:21c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.12; Fri, 26 Jul
 2024 23:45:37 +0000
Received: from CY5PR21MB3493.namprd21.prod.outlook.com
 ([fe80::103c:c670:fe7a:99ab]) by CY5PR21MB3493.namprd21.prod.outlook.com
 ([fe80::103c:c670:fe7a:99ab%4]) with mapi id 15.20.7828.001; Fri, 26 Jul 2024
 23:45:36 +0000
From: Michael Agun <danielagun@microsoft.com>
To: Yonghong Song <yonghong.song@linux.dev>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
CC: "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
Subject: Re: [EXTERNAL] Re: perf_event_output payload capture flags?
Thread-Topic: [EXTERNAL] Re: perf_event_output payload capture flags?
Thread-Index: AQHa3vgKy5tYtpsBAEW6H2nOXoUJ8bIJPD8AgABs3A4=
Date: Fri, 26 Jul 2024 23:45:36 +0000
Message-ID:
 <CY5PR21MB3493D67300A4005628E8CB8DD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
References:
 <CY5PR21MB349314B6ECC4284EA3712FCDD7B42@CY5PR21MB3493.namprd21.prod.outlook.com>
 <7ab6fbc6-2f05-4bb1-9596-855f276ab997@linux.dev>
In-Reply-To: <7ab6fbc6-2f05-4bb1-9596-855f276ab997@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-07-26T23:45:33.637Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3493:EE_|CH3PR21MB4421:EE_
x-ms-office365-filtering-correlation-id: c22eba66-a841-4a7c-3368-08dcadcd0c31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?utSiXmE9OYMjamv5yNfypHdptwtKigsA2zqMwSEqGJ5RDw2QG1kntf7SOU?=
 =?iso-8859-1?Q?1QrIEUpiWqDXBSF9EuzQgNnIIyJlupB1UtRPqnA063JxLw3EEajFzqgW9v?=
 =?iso-8859-1?Q?N5vCCiFUnnfJ/oGP4daE8wRdnIKu8hyzbeVo74WNmW0HLIXjy+DLgr+T4t?=
 =?iso-8859-1?Q?mtNgNJJLACOcKXQG4D6T/H86Uej5VaKTlzyllIBPHDZkxC+HEw5UM+OZsT?=
 =?iso-8859-1?Q?51nZKGBMAJTcUJSL0+N2zlqokWqExoc0W+CCiq5PynzYKVMI2fDjK/bVhf?=
 =?iso-8859-1?Q?Z1h8Z2NM+ADR1pxwlC7c2NbpkBC4loDhrkWARtkDBfvWjlG2/e7WXjY3we?=
 =?iso-8859-1?Q?x+pYPYi07wEkHU0rwLbjtVbiczTbQ0q8/ywQL1Qoq8ReUectpAcaWWuaq+?=
 =?iso-8859-1?Q?aVKvWVoA8Vi89E0puhIce7OBJTQ+nfRU2Y6QCI6BhRe/m2TkXrhKIkpeit?=
 =?iso-8859-1?Q?kLUQ2LuYp9YWUFrreVMbGP5qAQXkYWbhkxVKiuv8GYVd6EM+uv/7xQyldu?=
 =?iso-8859-1?Q?tTdHZen3PwnqCeW3LTY1Q1zN/TaIDTWBdUjF9sSR8NC2fknO11asQOxwcV?=
 =?iso-8859-1?Q?QOH8MWi8MYtqiiqT9wtPuF6uSji4rsgR9vS4T6TZxBueGTyRxOB5r8lz+9?=
 =?iso-8859-1?Q?jxcHpMQqYY3Zdn1LwMaxH9z2wJI88Ygl9XZn7VGmL9dEc3+EERM9B3LuK1?=
 =?iso-8859-1?Q?CCzkaq6Nt82yCfoGSwX42TvLCLaOsS3vhoDQumZPaXp93kCoI8UPn0OuOm?=
 =?iso-8859-1?Q?XoIBqmshMsPsjDebRKwGl6hkXaz4BzmjT2kVi7CUa4pckmkSEY7Dq8ymWJ?=
 =?iso-8859-1?Q?X1kO4JYpEPYMtR6yANxGB1V23mm91t3B7e4TUZ91MikwA74GJts04GFz58?=
 =?iso-8859-1?Q?5EYaexGYF1QXppnnu47EVGIfP0pUwS/mkGdcupXNz4LiN3WBvmJ0CvpQKh?=
 =?iso-8859-1?Q?uedJy+dQGPuE7bZm9wqXbHDJYBpcsmt0V71s1IJwW79QKrmbShjNR1EsU9?=
 =?iso-8859-1?Q?I8tLIn8uzRfWuLtlO21aj0fNgyfDhRdihgC4IK6uF0pk9po1mX6vUPz4i2?=
 =?iso-8859-1?Q?/31ux1MgD1CZaUGNqF6lb9LU+4CtlGaajbUscNBh4Fcu7Ax9wnD7g0XFxE?=
 =?iso-8859-1?Q?p/hqmX+KO8h/osJ9gbp0DR27eZ1N2cpcGGLDxGnahMI+FkKpg2ee+LIgET?=
 =?iso-8859-1?Q?zFRFpMeKc6IXqA+BHuPahB5xpbqYldbIRazG+FecZqFXnauOmzQKMh7HRl?=
 =?iso-8859-1?Q?XFkuTkRoGEGbyWBv2sW/PN1lOv8kY4XVsv0aUElhwU5g9ubcaqp2TC/HRT?=
 =?iso-8859-1?Q?NpTAzTxgni4vYTLe3fZNpqawS7N6yqzPcFGxLcNE6pNm7IVdwT2soE6eB3?=
 =?iso-8859-1?Q?iYpff5klWLIUiSVXPPzSRjqDlugqojRZVjB8iHiERn8jH9VbuuCmo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR21MB3493.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?kfEZPuVShjw9RyHcKmlr8kYyu0TgO08D3i4xJ1+uHMDcwfm8j0mlUiWSSu?=
 =?iso-8859-1?Q?kSZAsABZHmzHmgzxAOuXtQu2OKvqHqFb083PHoRRbmY6pG7O47FY8Yl2J2?=
 =?iso-8859-1?Q?FHD/bTj5cSq0m+H9a7Nhlmh5IhoBt6+viRl44GN+mcCPwPHwHKDEmJ+sNM?=
 =?iso-8859-1?Q?AOHPrwox8Drl2VljwSQ4VrOQZmGW9WfuCwFgzRRxz0B0OxuviwgibqBYwa?=
 =?iso-8859-1?Q?jP3gcPvwSfB5SB5quiB2gepK924hLrdOTz2a5AEZXexBGJrqT2l3Y/zfW0?=
 =?iso-8859-1?Q?cmxBgW+HnlpBA5sX78X8gKDgqrjJ0cJ8uLoukPRepRKmnEHHQHYm/5+2Sd?=
 =?iso-8859-1?Q?VMAQ+X0xlys2Dm233WjWaZ7pZ6zy+lQmfoDR9cRFbpbvuMz6OLGXSlXLBh?=
 =?iso-8859-1?Q?lVvsOuPQviNTYwKhNM99f0ipATxIVG6yhlMOj+EEHCyX86lZuKeHQ6IN62?=
 =?iso-8859-1?Q?ex5/2BahmJgLFy+t0d3LVajaiBCwKlnL8ysPbTBd2GBYKMqa+z53sHRSS3?=
 =?iso-8859-1?Q?UOK1XAM08MInRn5235BaHeGDlXhzK2UeV/K6pVTCHhLGsI5U54IaUVw3Dy?=
 =?iso-8859-1?Q?2WbBEiVOSouw4jy5xul7tqyp7JSc+m4cUY3zj+35yP7DK3wVTgH4BViAQj?=
 =?iso-8859-1?Q?ejJh6j5okMdFKvla5fSOncZ7jwi2p2cDCSeaZVSxL3Li4SlVZSPO7QOJ3L?=
 =?iso-8859-1?Q?uBkU852WMWxujZRs5jvhHUacWttl0kCIdNetmjSoXsK/iBUM+Nm14uv6GX?=
 =?iso-8859-1?Q?E3maQBKzYh/krsyK5EXMJAA9PqiqhvehMzyLkFPh5XajSsn14FRx/MhZiC?=
 =?iso-8859-1?Q?teZ6+O+JwhcR3ctGRELAyDfpVzn/SjgRwuZcyOhNDDDByVGwvSSlD5jrpw?=
 =?iso-8859-1?Q?FjAcabe7yjYuLm+pDU65eeNTofLPG5GuivRx2GHVhJwIfs2u7pC6uQrjUN?=
 =?iso-8859-1?Q?GVsIWSqk9g28xLHtb2spT1oT5hG8kvlBK1tv7AmRrrKJjS0PP7FOFiI3Xj?=
 =?iso-8859-1?Q?nazVpOGRIErz1uF3XEtlNSjpWw+6ab4pIWjs/AaVaUcla8LXRLqwMZB4d+?=
 =?iso-8859-1?Q?5D2SM+8BAhdbMqBN9ARLr7CJD11obWvdNiEPqYNQlUdthCJmrifvnGHALO?=
 =?iso-8859-1?Q?cNdX9+J0pIOxUhaiUaczByjNV2jV2ksrmvBG6iRc3TJ9T9FpWeadWrHYrq?=
 =?iso-8859-1?Q?vh2ME1dc+LsWApxquKPUNmSLEZ6folLVs0gs+nSbmdwPsVl7JBuFbFoUEn?=
 =?iso-8859-1?Q?JRi4cimF6zAdl7t57vdDDpmUgAxE2Ue0eMNqb3F8joAX1gAsUR5ksCnZ9B?=
 =?iso-8859-1?Q?jQOSi76+uoUwuLjwmhC6zDgpReztR2uAeF4Q9gnz1bgqtWJGQDpOIMn8bN?=
 =?iso-8859-1?Q?GsQKK6tHXOVPGDtyCQ+Cuh345YFv/8HJ57dNGxsnYRyneZ9x50Kg/1/nJX?=
 =?iso-8859-1?Q?pEFSXtcP1ShyqQbNhNAQ6uz5ln20NuaiDXr30LyJ+6FbSyvRS7qCtnm+ih?=
 =?iso-8859-1?Q?uHg0I05WcKCHp5iEYSFUK75IBTegShCWPVYbWfisIcNUsXBeSvCD94ro1i?=
 =?iso-8859-1?Q?OhhJ606q8YgLE7Q93szwg1CUZZAZ?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3493.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22eba66-a841-4a7c-3368-08dcadcd0c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 23:45:36.4062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IrB+Dholp1CxF/nOcdKyPh4MFqZX/Gq0txI0ovlNenNUsnl0vm/B64C2WZNm0Uh3gdVFsGhdNRLkE5OUWV9Sv9sTgnPDCg99p88o1IEigw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR21MB4421

CC Dave

Thank you.

Due to Microsoft policies we avoid reading code with strong licensing (like=
 GPL 2.0).

Is there some other documentation of the flags, or could you explain them i=
n words?
Or is that the complete flags description (which is in other documentation)=
 and I am misunderstanding the code below?

https://github.com/cilium/cilium/blob/3fa44b59eef792e28f70b1fd23e3e17e42690=
9f5/bpf/lib/dbg.h#L229

It looks to me here like the capture length is being OR'd into the flags.

Any insights would be appreciated.

Thanks,
Michael

________________________________________
From: Yonghong Song <yonghong.song@linux.dev>
Sent: Friday, July 26, 2024 9:58 AM
To: Michael Agun <danielagun@microsoft.com>; bpf@vger.kernel.org <bpf@vger.=
kernel.org>; bpf@ietf.org <bpf@ietf.org>
Subject: [EXTERNAL] Re: perf_event_output payload capture flags?

[You don't often get email from yonghong.song@linux.dev. Learn why this is =
important at https://aka.ms/LearnAboutSenderIdentification ]

On 7/25/24 6:42 PM, Michael Agun wrote:
> Are the perf_event_output flags (and what the event blob looks like) docu=
mented? Especially for the program type specific perf_event_output function=
s.

The documentation is in uapi/linux/bpf.h header.

https://github.com/torvalds/linux/blob/master/include/uapi/linux/bpf.h#L235=
3-L2397

  *         The *flags* are used to indicate the index in *map* for which
  *         the value must be put, masked with **BPF_F_INDEX_MASK**.
  *         Alternatively, *flags* can be set to **BPF_F_CURRENT_CPU**
  *         to indicate that the index of the current CPU core should be
  *         used.

>
> I've seen notes in (cilium) code passing payload lengths in the flags, an=
d am specifically interested in how the event blob is constructed for perf =
events with payload capture.

Could you share more details about 'passing payload lengths in the flags'?
AFAIK, networking bpf_perf_event_output() actually utilizes bpf_event_outpu=
t_data(),
in which 'flags' semantics has the same meaning as the above.

>
>
> Thanks,
> Michael

