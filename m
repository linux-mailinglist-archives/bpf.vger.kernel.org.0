Return-Path: <bpf+bounces-28581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DA68BBE24
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 23:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C98D2821AF
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A8783CDB;
	Sat,  4 May 2024 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ok9YtR/V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KgS5IvPt"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A28357C9A
	for <bpf@vger.kernel.org>; Sat,  4 May 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714856980; cv=fail; b=bWqPhHgjkTAwYrKc9KPMKdJzq+lYDLefeavkqOdAj7vbiTgFuP2UldMqBxZHzSCT0otfFgUBfPu78npsiC5HNRDCKUCu+T1zItwQNYOxFiUeTGisg7LN5VuRBOGP68AHGG1lxy671jwtLuDpvIRCsAQIKGYMpvFiZA3PZoh6x3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714856980; c=relaxed/simple;
	bh=L8GWF/Jf75Q3PTvaWly3U6mMXV2g8elUkxkSp4v7HIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=W4O5TCBGiURWAGYstDxIJOEtYfIBbrEIFJ/3mXF9LX3GgGMBJMoYFBp18pJmmD/xf2vwG7UWdaBC7I2lxxhBJxA1uzpQp+sMPoKstFcgtPfAompYQPfXYRwVPj1845zuQ+k3Ed3EKzY0XQMCnyFodPQEFGbDaf8QIo5kwWlNPD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ok9YtR/V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KgS5IvPt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 444KtM6c017077;
	Sat, 4 May 2024 21:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xEOhTmP8qFth+kjRm2Mq/at2rPXRVQ3wQSN9YnMWxrk=;
 b=ok9YtR/VsPaUkSuF/j4AGoVMNj+DxvCPFUbWqFsr0BEYkno0N7mwNDdfqb9XZdP2FWFo
 2c1PWpoon2/ZHVL8DUHNpkdRLQwp9hn2ld64h8LKH67LanGJedXp6fWlL89E9z/mOaAP
 gwrnqywZ8Z0/QTWn34aDH6EAoG+sW2e90yrjrdNEhawAC7b0TBVNePNFbfo11DqIYFU9
 0iM9QghV2NWWUDS6tBq56fkzAUoS4QKC1Fjr/ZyC+XTIEVdQE/xxE+isAOTCsjicOc5B
 T2oTI4K2Moji9btyyBYQcDJUU3eOV9aJOv83dHoFb8yw6DeYqldhuFFjKtcrKXHa7Rig 9w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbeermdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 May 2024 21:09:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 444HGUP1039397;
	Sat, 4 May 2024 21:09:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf48ra6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 May 2024 21:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9W+7RuI1JGg9jVfu6oD3s9S47y5s5d1xB8aXn8H4sONF6nxFzH+3YWxFKThMohtHQVGf6m2e9S3upOdIGGRgFzP1FB3FkaIg2yx3mD9On3OvpYLl/fddeeqwf7IaEFuPhrIflUw3vNnfWVvcU4rLIRIEQgCc0wf6nPqhYttrT8woQmoPHZj7udzqnVPx9pTBSiJDswYPoip0oZNuFnkgsgd7Z7Llx9Ss5i6xsaFw5qOEU7lvmqhIkjubHOryADQaCHgMN+SrYwz7ESu5wkiSshTd9hl728ZzEef36dy2nDSoLu95frO9FCpG2QZ+ce+vGhK3RuRKGox9dtyxAkyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEOhTmP8qFth+kjRm2Mq/at2rPXRVQ3wQSN9YnMWxrk=;
 b=K1tNWDq+Vsr4iUrk4vdLp1Zswnp9nSAZuUZ0nOuEDbK4GPgM+TSvujujqUCPLhFwj/xOWC8bh7/Tb0efoJNPEbRBp9ptMldQEjLmhkbHP5Z3dS5c6I+LPPE2GEAmO0ZJcTJEk/WwrNFan9tuP7HDvAQ4wxs3srGUY2le9YZGMudBP9T2x2RJItZ9mc4FtHUwRqQNNCNff/m6fnBUYSI9Mfjfah6xmjsAtdFrPg0w3B3JNp8KMESzSqXZMUJ1crqBcY4FqsRdT0nT7d/sucVM7Sh55ZbfZyYlQ4RkDrnyL5liiy+CtQ2P9l++sYhpR3t00d56yq5VpGZl3Jba/W2asA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEOhTmP8qFth+kjRm2Mq/at2rPXRVQ3wQSN9YnMWxrk=;
 b=KgS5IvPtARqQnQH76kdLVHUFuzk9kJgAWbhs9ziNVRkMNO/xBJyFAtphFmudTtxJkKN68A8ILFrKstuvb89t9dSH7lueb7XvFs0ygjQKPUrb+YCeinSGGWzmtqtakuc9RssvdpgU0Ryzbwf/diIGBCCI7oX59VGHn1leWJA+Pp8=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DS0PR10MB7092.namprd10.prod.outlook.com (2603:10b6:8:148::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sat, 4 May
 2024 21:09:33 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.036; Sat, 4 May 2024
 21:09:33 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        Alexei
 Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song
 <yonghong.song@linux.dev>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: Re: [RFC bpf-next] bpf: avoid clang-specific push/pop attribute
 pragmas in bpftool
In-Reply-To: <CAEf4Bza5cmJK-+tK1QJ-SVUWmTOTOM_3gZQ=9yhynU5vE_wWyg@mail.gmail.com>
	(Andrii Nakryiko's message of "Fri, 3 May 2024 15:14:14 -0700")
References: <20240503111836.25275-1-jose.marchesi@oracle.com>
	<6687f49cdd5061202ee112c38614bea091266179.camel@gmail.com>
	<171a007587c02ff4a8d064c65531fde318c3b4e2.camel@gmail.com>
	<CAEf4Bza5cmJK-+tK1QJ-SVUWmTOTOM_3gZQ=9yhynU5vE_wWyg@mail.gmail.com>
Date: Sat, 04 May 2024 23:09:23 +0200
Message-ID: <87a5l5jncs.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA3P292CA0015.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DS0PR10MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: e70ebc3e-15c7-465a-b559-08dc6c7e7e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RklmWm5LL0tWeHAwNFQ4OEVMWitBZGZBeHZqS3NjL1dLcm5pNnNLcWlsMFBM?=
 =?utf-8?B?Tng5aUUvWWxpeE1HWlVkUENBYmlONnNQYncweEVOS2t5Z2g4dkxJRXl6Rmx5?=
 =?utf-8?B?dWkwRjhYOTdJT0lpSCtMWUxlK2JuQmxMa2UzZFBiNXliT3h4eHFrQWM2aEZz?=
 =?utf-8?B?Y3V4Wks0dEswUjg0RVpnOHJtV1BKdWI1U2lnTW1lSnZBNDROeW10WmI1L1Js?=
 =?utf-8?B?UTkvT0tXdy9HY3RzYWJsL3ArcW1rb2Nvc25URHRaUjJERnBLQmxGZTQvcW11?=
 =?utf-8?B?Ni8rYUtmZjAyS1F2a2dhN2djOHU4WHJxNC9neVdtRTA4ZndHVjNMaEVwaEp5?=
 =?utf-8?B?Q1RsVGhPdkV6SS82Mi90K1NSRWFRUWVmVm5CR1JvU1UvekdrM2tBYTdMUTdx?=
 =?utf-8?B?VHlTVDF6WTk2YjJyakUxTXJ0RXdJL25uZGgrTTFRdDdtcXFaaGNWWUNzdWVZ?=
 =?utf-8?B?ZEV5ekdZZlFQbFZHNndFaUJmNCthUVFCMVRhSk1Pcy9hUTdLUTNEOWEwQ3Jo?=
 =?utf-8?B?ZFRLZkNwNVpEUDE0ejNDcjBINXNKUm45Y0xHOVl4VVRSK2tIZ0lKcFF6Q2Ji?=
 =?utf-8?B?M1o3aFh4NkFxN3ovY29KRGlNeEtJaGc0TVg1WjJEU1M0VXdwTHg0bFFyR2pO?=
 =?utf-8?B?RlVNOU9PN05JSkxxRzBkZzlVS1hjbVVEVjdtZGZycVFCclRIdnY5RHRJWm9k?=
 =?utf-8?B?dlgxaE1yMHBpNlp5YlMvZ01ucnpPN2NmbFRHWUV4US9nbW1kQUVKV1JNSXo2?=
 =?utf-8?B?ZHIxNE9mUWhHeDVPQ0dWbFArMktzYStWVy9CTWFvdTF3MmtKYytYd0xXc2hm?=
 =?utf-8?B?SWpPb2NBT0g2SjR3amR6LzBncXIzM1JQdlZIR2ZFRmNQQTYxdkNVL291TEZ6?=
 =?utf-8?B?dlV0aGZpRDI5dkpzeHRITm9NNmp0RDVIK2dFSVQzYTFNcGNySUtVNmVCQmJi?=
 =?utf-8?B?b3dCRGQ1c2lZaHFmR0w0Y1VLY2ZBUTF5bU5aUHkwOXRzWGZqUEpwTzRIckUr?=
 =?utf-8?B?aW1nRFhnR0JOSi9udzRUVnF1K2lHNSt6YzVySEkzZHVLR29UUVQxYXVlb3pO?=
 =?utf-8?B?ekJ6ZXh1SUpITWQ1N21pUzNQWm1wa1VrbHoraXVoaVZZQmg3VDlnTVBlNU1i?=
 =?utf-8?B?UmJEVzIzRGZpN1d5TlV3ckh2YVRiYjNwZ25oSkY5eHlYSzU0RjZTRUVBS0dt?=
 =?utf-8?B?S0thNm40WHBXaTUvYkNUMUdpWkRiekJXUG8ya0JyWGtkTkh6WFlWRDFzMnhj?=
 =?utf-8?B?U0tiZDRIOVlCQjE4bnV5aUppRy80a1l2OUtpbXlNQVUrSXVnVllWaHo5eGVN?=
 =?utf-8?B?eCtwU1krRnpPUVRGR290YUQ1RndvNDZ0dGFjUUl5RHVZUnI4YitOQ0RodU9Q?=
 =?utf-8?B?cVRHdnNvL1dWdEt4L0NLVHZIUlpMMFBvTW1WM2xMUDhRZEhzaFZTcElidlRs?=
 =?utf-8?B?NXp2T0JiNkZpTXZleTBEQzNmNElFMllkczdTdmRCTU11QnY3bUh1N2dQdlVn?=
 =?utf-8?B?aTRuMGQ0Y3dxZkpzZldmTStmRVVhOG9kTS81YVZMbVQyR0FpKzU3UDk2QnNj?=
 =?utf-8?B?WVRNV1R2OHBodk9aZDVla2taQjhwM092dFh3RnFVNGtoRHNFeFY0dEN4UGkv?=
 =?utf-8?Q?/2KKWszHM4yqWjv9y8LpNuXm5wzUjlsS78I+/E4t9cjE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dU1xbW12enZpN1diU3VnZW4veU5pZ3YyZG01UHNMWTd2RnlOaGozNUt5YnBm?=
 =?utf-8?B?SXRXNUxYSzlDY0pHbHFJUEVsL3pwSXVMS1FRUXF4OGM1SDFyNjBwdUJaNzJH?=
 =?utf-8?B?ekptVzBQQlN1YzY2RnN3MXdMZi95ZGExVTFiSW1WRlFDb1NkZElsbkNBWlBD?=
 =?utf-8?B?dU5LYktkTnBFU2ZkSkVpbFY0U2xkdWxnUWpuRGdYNmx3VHY0MmJ6dmJSeEtC?=
 =?utf-8?B?dnU1MS82c2c0WGpwYnl3SmppUk14RkFFZk5NZGhXNjBRMm9YR2QxcjdVZm9M?=
 =?utf-8?B?UGRnaUdXZU1XQzkzakp6c2gzR1ZLRHpjcVRtUjBzZ1RqQUVqNmcxWnZhTko2?=
 =?utf-8?B?K3l4Z2lVR1RFWXc2dFNoMnEwMjdVVFJ1YTFDS0FlNmdvWmsyM21OeC9VYVJR?=
 =?utf-8?B?KzJWRTk5K3BpU1J3b0VRVjlJN3ArWlBIVGF0VFRsNk02ekFkQWhia2Q0SkVJ?=
 =?utf-8?B?TlhqUFhWaTU3NkVkRk55alh6NXNqazI5OTZoZzZOM0g2dU9KZEdPV09DcXJh?=
 =?utf-8?B?Wk5nTllMMllxcW1pWVQrNjkzaVFHMjZZZnpwbzJlT0VmaEVDZEVmQ2J2UGdE?=
 =?utf-8?B?bXl0VlB0NWVsQTdYT0kxSkxIYmpRMXZrWUpTazZiOWpTdWh6dTlSZkE0WmV2?=
 =?utf-8?B?WVBQV0tZTERCZHRMMHBQVHZUN2J0b1hwcFVsMmdQMFQxMFg4QmNjcHhvK2hE?=
 =?utf-8?B?TVJ5bGR5akZZYUNMSzg5c2dST3VMRHY4bWJBSmU0WCswZy8zN2dmNDdSVzNH?=
 =?utf-8?B?S0VZYzVYVDZheTA2dmsreVQwWWRsak10RkxvMmJRMVBPRGUrMWp0VGl2MFpx?=
 =?utf-8?B?T2R1dDlwZ3hGSmJBaldNNUhDTTRjSFlSMXJQMXhYTzdWVUJvR1hKZk5zZzNn?=
 =?utf-8?B?dDBLNyt6K2RsOGFQdmdOR2d1bTBEd2lFMUJHcWZENm5YNjBSS3hpekFHUXlL?=
 =?utf-8?B?c1FJTnJuQjlHQ1h2bGIzUHpUam1jaVhlQUVsUmdyV0k3N09lYU42SE1KMzR6?=
 =?utf-8?B?dHdRZDhSeGVhb24yR2N0NGdGZS9DcWhMeDdpd1pQMVhCSVlKbk5haE5mNDBU?=
 =?utf-8?B?SVJpYitWd0M4U0Z1MmVaR0tFM21LYW9sVi8vR2ZYQklXR2RBNUJyTjNiT0tu?=
 =?utf-8?B?RGNjaFh6RjZ5UXZOMFlLYXVMR0JRL2Q3b0t4OGpLM08zR1VzRFZES0IyaVVs?=
 =?utf-8?B?U3A5Y0hCRDhRcXM3SmVVV2NDbVc4Tkt2ZVhqOFUweVp1UWFQM0FGN2Y4eG5t?=
 =?utf-8?B?VjR4UlVNL1dzUkhOS0x0ZXk1dFJlUEpBcjNQSm5rUVMvNDQySmphUFkwODBs?=
 =?utf-8?B?RHpWaXpGeEZkb3JzL0UrTVJrK3J5cENQNnNGY0xlMmlXbUNwNkZXYS8vaC9j?=
 =?utf-8?B?eVdCRkNzdm5yUVIzS0Zab0s4K3ZWWGNMUTFpU2lUUE5WZlVmOGRPOWorMUVY?=
 =?utf-8?B?b3BJenhLQ2hTZVEwRFBlaVEyYlJQdHh0M2lhSUZkR2FUSUZvVDBZcFBtTkt1?=
 =?utf-8?B?WkovTjQ3WG05bUlBcUIvUTNpc3lKdFkrN0NzaDg2T283UGxCU0hzZlYzQzBx?=
 =?utf-8?B?dVhlZDhZZFNvYmZEMFYxdjlxNVR0TWlPNitkWE14SWFhakFnTVcveUFnODA5?=
 =?utf-8?B?ckxTZ2NBODYzMlk0dWFQN3p6RTVsTmFwQUxzS3EwOG1TeXhCTi8rVlJjOTVz?=
 =?utf-8?B?R3g4UXk0VUFEN0pyTlB0Nit0a25IUXNEUTA0RDc1RWtXQmhYUUh4U3VCTmlH?=
 =?utf-8?B?SnFUMy9DQkJVN293WXpzTDlWMkpvOUs3RGlBQmd4d2lOa2dyOGxXM3lqVGE0?=
 =?utf-8?B?VU1SWlA4WkFhekhySUhjOXRSRmtWNWRnUllWQmpiZFFIenFPNEhNRnRHODIr?=
 =?utf-8?B?USsxRFY0Y3dubmU2M2pWZERWRkROWTNYZVpXbC9Bb2lSWmFyMFdYdTBqa0E2?=
 =?utf-8?B?K3BERzJrcXh3bldGdkRvbXZ5YytrYUM4RnljNngrMGF4Rmw2RUgrcHhZOG1U?=
 =?utf-8?B?ZFJ5RTVJRmd5dVBNak5mOUVYNlVtVk1UVjJDMGViRG1IOWRSNFBEbnVKZXhq?=
 =?utf-8?B?MGp1Qkg0cjFUSHhkNjFrQWZrcEh4bVVhVmc5SkwrMXg4ZDlSOTRycTBBNkJB?=
 =?utf-8?B?dmd4TkFsRCtJcDltdWdGaFBmWUNqZU8wVXNCSHhKN1haMUpheVplUU5kRWRJ?=
 =?utf-8?B?NkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MxwJF0D80Ljtlc9n6jHkIXvzwbjZY9OM4CP2H8ZbG3g6BUy5W/cXxUQ7AtIOEs1OJ2zZWg0WaOVlt5Z8KRE/9vsMegPOCs3n9R7R2PTMZuI+7h1wvp0niepKfB62j94eMToZZ1eyGUQZfoPfpxJyAnChYs8LZmFtg6TnILqmN0v/5kuxCSm/37wJHO9QMtS0xcXWAE2s8P+2BHEjkeowp2peqP9RAd3Kl4pkuwLAGgkIJeiGn2KTIrn5GvVNOtlCY/sKGwDkiXkSbgJX+vv0GwDmMhpaxfwhNbHuAdAa99aoNSQ3AvSKdzPaF2B8/rzz6UZS0OObcsfUguwMuVGOCkNqscolUFbnL36GdG3BkAs6n5uDrmWwJITkD3vpQPfCTtKSxSiFFI+Dgqn+KO7g8Iu4yS0j49W9DbSKb0FO9DrAbMGwdVHEHOKM+jg2DY8t7bqi/Vke5mt5GuIt+/T8BOxTC5Y82iDEuRF1VHnkvgE/+di4CMLfJDEjnfncCfP4GdcUXIMq+qRmtYTp3AMl85+3G5w7Lblp6VeEQNOHYy3cwjTWW2Gu1xudGC9ZIOd70YRRfWZ1w1O2ljYhouRxFirR6KdnpTo8GFjUmDIhAWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70ebc3e-15c7-465a-b559-08dc6c7e7e9d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 21:09:32.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: If5bxKtHVPWBKb64vzXkfx2JnwEfpvj8JgJc6DMPahbIj7BPZ3afKVHf5RNiUWqkiZNRWrbgTToY9i1u3MGtUBQ2xgpP/uXXrO9pwXTT53c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405040138
X-Proofpoint-GUID: 0B9ajUzd3khUs12bLNTyfgq0MvZ7PUpL
X-Proofpoint-ORIG-GUID: 0B9ajUzd3khUs12bLNTyfgq0MvZ7PUpL


> On Fri, May 3, 2024 at 2:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>>
>> On Fri, 2024-05-03 at 13:36 -0700, Eduard Zingerman wrote:
>> > On Fri, 2024-05-03 at 13:18 +0200, Jose E. Marchesi wrote:
>> > [...]
>> >
>> > > This patch modifies bpftool in order to, instead of using the pragma=
s,
>> > > define ATTR_PRESERVE_ACCESS_INDEX to conditionally expand to the CO-=
RE
>> > > attribute:
>> > >
>> > >   #ifndef __VMLINUX_H__
>> > >   #define __VMLINUX_H__
>> > >
>> > >   #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
>> > >   #define ATTR_PRESERVE_ACCESS_INDEX __attribute__((preserve_access_=
index))
>> > >   #else
>> > >   #define ATTR_PRESERVE_ACCESS_INDEX
>> > >   #endif
>> >
>> > Nit: maybe swap the branches to avoid double negation?
>> >
>> > >
>> > >   [... type definitions generated from kernel BTF ... ]
>> > >
>> > >   #undef ATTR_PRESERVE_ACCESS_INDEX
>> > >
>> > > and then the new btf_dump__dump_type_with_opts is used with options
>> > > specifying that we wish to have struct type attributes:
>> > >
>> > >   DECLARE_LIBBPF_OPTS(btf_dump_type_opts, opts);
>> > >   [...]
>> > >   opts.record_attrs_str =3D "ATTR_PRESERVE_ACCESS_INDEX";
>> > >   [...]
>> > >   err =3D btf_dump__dump_type_with_opts(d, root_type_ids[i], &opts);
>> > >
>> > > This is a RFC because introducing a new libbpf public function
>> > > btf_dump__dump_type_with_opts may not be desirable.
>> > >
>> > > An alternative could be to, instead of passing the record_attrs_str
>> > > option in a btf_dump_type_opts, pass it in the global dumper's optio=
n
>> > > btf_dump_opts:
>> > >
>> > >   DECLARE_LIBBPF_OPTS(btf_dump_opts, opts);
>> > >   [...]
>> > >   opts.record_attrs_str =3D "ATTR_PRESERVE_ACCESS_INDEX";
>> > >   [...]
>> > >   d =3D btf_dump__new(btf, btf_dump_printf, NULL, &opts);
>> > >   [...]
>> > >   err =3D btf_dump__dump_type(d, root_type_ids[i]);
>> > >
>> > > This would be less disruptive regarding library API, and an overall
>> > > simpler change.  But it would prevent to use the same btf dumper to
>> > > dump types with and without attribute definitions.  Not sure if that
>> > > matters much in practice.
>> > >
>> > > Thoughts?
>> >
>> > I think that generating attributes explicitly is fine.
>> >
>> > I also think that moving '.record_attrs_str' to 'btf_dump_opts' is pre=
ferable,
>> > in order to avoid adding new API functions.
>>
>> On more argument for making it a part of btf_dump_opts is that
>> btf_dump__dump_type() walks the chain of dependent types,
>> so attribute placement control is not per-type anyways.
>
> And that's very unfortunate, which makes this not a good option, IMO.

Indeed.

But for the specific case case of preserve_access_info and vmlinux.h,
having the attribute applied to all types (both directly referred and
indirectly dependent) is actually what is required, isn't it?  That is
what the current implicity push-attribute clang pragma does.

I have sent a tentative patch that adds the `record_attrs_str'
configuration parameter to the btf_dump_opts, incorporating a few
changes after Eduard's suggestions regarding avoiding double negations
and docstrings.

>> I also remembered my stalled attempt to emit preserve_static_offset
>> attribute for certain types [1] (need to finish with it).
>> There I needed to attach attributes to a dozen specific types.
>>
>> [1] https://lore.kernel.org/bpf/20231220133411.22978-3-eddyz87@gmail.com=
/
>>
>> So, I think that it would be better if '.record_attrs_str' would be a
>> callback accepting the name of the type and it's kind. Wdyt?
>
> I think if we are talking about the current API, then extending it
> with some pre/post type callback would solve this specific problem
> (but even then it feels dirty, because of "this callback is called
> after } but before ," sadness). I really dislike callbacks as part of
> public APIs like this. It feels like the user has to have control and
> the library should provide building blocks.
>
> So how about an alternative view on this problem. What if we add an
> API that will sort types in "C type system" order, i.e., it will
> return a sequence of BTF type ID + a flag whether it's a full BTF type
> definition or forward declaration only for that type. And then,
> separately, instead of btf_dump__dump_type() API that emits type *and*
> all its dependencies (unless they were already emitted, it's very
> stateful), we'll have an analogous API that will emit a full
> definition of one isolated btf_type (and no dependencies).
>
> The user will need to add semicolons after each type (and empty lines
> and stuff like that, probably), but they will also have control over
> appending/prepending any extra attributes and whatnot (or #ifdef
> guards).
>
> Also, when we have this API, we'll have all the necessary building
> blocks to finally be able to emit only types for module BTF without
> duplicated types from vmlinux.h (under assumption that vmlinux.h will
> be included before that). Libbpf will return fully sorted type order,
> including vmlinux BTF types, but bpftool (or whoever is using this
> API) will be smart in ignoring those types and/or emitting just
> forward declaration for them.
>
> With the decomposition into sort + emit string representation, it's
> now trivial to use in this flexible way.
>
> Thoughts?

I am not familiar with the particular use cases, but generally speaking
separating sorting and emission makes sense to me.  I would also prefer
that to iterators.

>
>
>>
>> [...]

