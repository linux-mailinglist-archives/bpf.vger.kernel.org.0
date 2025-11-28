Return-Path: <bpf+bounces-75690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C84CCC9153C
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 09:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 597F7344222
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779EC2FD1B3;
	Fri, 28 Nov 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GONHgzpF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MsMyvYjV"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0C0288B1
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320213; cv=fail; b=sqAC0S/F7fEYdNKk7MdeejVI9WN0TQyQbjVGBT/tUA0KdwzDLCffDJ2JqVSyXJpyZNRXUu13OLdWNf4Fi3bAysMKILRgdR1TKNy74tLALXM4uyCWQgbBWcorr67zdl0m5Gb76jexqhU3CX2hi+e8HH+CGSxQHYVAheMRhmavePo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320213; c=relaxed/simple;
	bh=1XfbdG4cHVrUr3K4Mb8leE2bKoq0D3U1EIEqL0HmXsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WDCnqr4m6EWl+PtRtj3jT3LebI3NF2TSM0TKbBV+6zsnQxwtIiSDA2/s1YrehBdV2erri3TA34hlXoJaG70Q85E11iBraEIX1Ieo3ap+8ryDmHovxgbsAYwLnJ2K6oOguPbKC9i0ULMvlxyfUPsU15eLzh+Frua3336oppEhRS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GONHgzpF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MsMyvYjV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS7u6T02905950;
	Fri, 28 Nov 2025 08:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=L9ZLFxdBBNMX+BLk4a+Poenl02c55cVl+I2iUfptWBQ=; b=
	GONHgzpFKrP5eSNvOe741zMxY4u35qx6WFk/NjZuvGXMCDkoQjMHzyyCKFIEdkwg
	OC3l3308QBHGo3u1hl54lhNa3Z7gzWFgnAOEQjhxYE7haI0t68D/LVQBFDQNtqJE
	aDPcyhU2V2M7kTiNs4JrAV0ng3ljqMZCaU4aP5dx+7wVt5LTDubs5qUByzCKpbVx
	s8JqOwvPe8BB7c5PeysuDjnBD4b+KoTJggZKoERReFG3Z24NeKCSD9j0EjmLdkLv
	vihwSYJSZMQTlLOpW7kUPI4FDpxdJK7u3DVmD3dgAm+RHBLjA5Xp6uKgcXRLCpgY
	4pMciev7WUgPWyLKui3dHw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aq3j8gaca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 08:55:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS7jl1l022481;
	Fri, 28 Nov 2025 08:55:20 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mq4f72-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 08:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9zfEUz7SRUr6CUN0AyyY1Z27ZVvP1nWIzCdMFdSMhZ1jihuMiMInRf5Wq+W1HEl1wSodTDo4GR6eOSzlFIIQ/GrIrS4HrOImXnRpOJHIJhAH0Wk1BG3OzAaUfm4qVLgxQfAepeaDN/IkG3T+IGTaNp3fTfTuHM/iAyT8emwwBWyiixtZcVVBSXwqFD72yVnWtI9dF3Pl2iVEPvz5PK/YpYfQv1Pq6TZn6iftGFjGPDHtenAGVPKwYQWNqTHj0npD/uMDfMrB/8L3j8JKu/Cx2bwVuNykomX0iriwG4ZgDHv792SSz6hln3i5Sq574jiixVj5OB3yfr2hHcyncHdpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9ZLFxdBBNMX+BLk4a+Poenl02c55cVl+I2iUfptWBQ=;
 b=qVTg8L8fgL3WGwiRFQwtyskucT/tnBWkKwyvwb/9dsqDJW+uzH7BVMP53orm7NOaRxrB55+JapB3LsHGe6kUdX6WGTVE6tYLaRzOOCT4DlFm2SvqrsINYIPJus7CQlJimB28DeemhIHdPHH+/vN2ZglOaHqEDO2WsYc7NHnQ+hLdL1swRqrHCfXoxvGlZokMAclh1o45WFZkXTafVWpzjkGQKr6EeAtrpwA9acn9xa19IxWPIPcONRmzK2h2PJRTQ3aY2WXXC4C2SXhMFxkhtjCs2cyfnRGuym58DCwl2v6Ywy0ozGl7r/5Ry8Lc6nVAkH5xmDDLAq+QoUhKa7Qb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9ZLFxdBBNMX+BLk4a+Poenl02c55cVl+I2iUfptWBQ=;
 b=MsMyvYjVhVCSI9T3VZEicwb/3T+ql+FNuld8G4E6Z5k1zjrhrsWUQPItFj75ULYYG4v02wn0qTnN8dWx9OJZ7RL1ikIdX3tn0MB5Pw18m/nMfSjGmrNRPMbf0n/VSN2hQ9qLqvi+PDeBcdmaIx6dz/kJjtVTFvsFw9zBgXj3p9M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7360.namprd10.prod.outlook.com (2603:10b6:208:3d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 08:55:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 08:55:15 +0000
Date: Fri, 28 Nov 2025 08:55:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Yan <ziy@nvidia.com>, Liam Howlett <Liam.Howlett@oracle.com>,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        Johannes Weiner <hannes@cmpxchg.org>, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com,
        Matthew Wilcox <willy@infradead.org>, Amery Hung <ameryhung@gmail.com>,
        David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Barry Song <21cnbao@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>,
        Tejun Heo <tj@kernel.org>, lance.yang@linux.dev,
        Randy Dunlap <rdunlap@infradead.org>, Chris Mason <clm@meta.com>,
        bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v12 mm-new 06/10] mm: bpf-thp: add support for global mode
Message-ID: <f8b4bd7a-b2e6-4ac0-971a-75cfd03c824d@lucifer.local>
References: <20251026100159.6103-1-laoar.shao@gmail.com>
 <20251026100159.6103-7-laoar.shao@gmail.com>
 <CAADnVQKziFmRiVjDpjtYcmxU74VjPg4Pqn2Ax=O2SsfjLLy5Zw@mail.gmail.com>
 <CALOAHbD+9gxukoZ3OQvH2fNH2Ff+an+Dx-fzx_+mhb=8fZZ+sw@mail.gmail.com>
 <CAADnVQK9kp_5zh0gYvXdJ=3MSuXTbmZT+cah5uhZiGk5qYfckw@mail.gmail.com>
 <9f73a5bd-32a0-4d5f-8a3f-7bff8232e408@kernel.org>
 <CALOAHbCR3Y=GCpX8S9CctONO=Emh4RvYAibHU=ZQyLP1s0MOVQ@mail.gmail.com>
 <e52bf30d-e63b-44ed-9808-ee3e612e0ba1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e52bf30d-e63b-44ed-9808-ee3e612e0ba1@kernel.org>
X-ClientProxiedBy: LO6P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 71df3c15-5923-43a4-7df6-08de2e5bd8f5
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dWdtYi8yQlVtRUxPRXVtTllsdVFycEZzY3BYQXFqd25zbUc1Wi9GUXRacjJY?=
 =?utf-8?B?TnJrZVhnSjJtK2ppSDlLSlZLS1NRVU9HbXM4enlMOGZpd2pFN0RBelY1Y3Az?=
 =?utf-8?B?bVFDMENQNG12c1RNOWZtZmR3enJvQ1hIZ0R3MDB3SE9MR3dGa1ZBeVc0TnRW?=
 =?utf-8?B?WlZBZFhUN3REazdqbEJld3NnTFFLcFNpYlJyZ2EvdDV0MVNlOG81cXV4Q3VY?=
 =?utf-8?B?NXpOdkdhUU5FeFE3OXljeGVjRExCOTVhRTNnemU2SDB5cHR4KzdoZnVkUGxs?=
 =?utf-8?B?TUM3bnZlaVByZUo5UXNUTlh3ZWFuZ3BwbW5teStGSjVscWhGWXJmV1RPM1pH?=
 =?utf-8?B?OVROQmdZbTBmeldJK1pDNVV5RVQwMUkxRTJ4TUExaHo5cm12bm1zbG1iOUxZ?=
 =?utf-8?B?bllsMkVpYWdyaXlVeTlFb1o4WDB3MUQ1WE41MUc2bUQ0NGVpZklPWFI3bStx?=
 =?utf-8?B?Z3k4dnloT0cxNXBxZjF1Kzc0TUZmT09BT0RqV0kwN1ljNk5ZeW9jVlNRVURu?=
 =?utf-8?B?UmEzSStUa1VKdElhL2JxaklFN2hXS0JiSi8xZUdSVjFxbDJobncyTFY0SmJq?=
 =?utf-8?B?azRKMCtXc3JxamtKMlFXSStla2hHdmVGUE1jNERjZmdHRVVsUlJrc0hWQzky?=
 =?utf-8?B?RjJZN2tDTkpqQk5rQlUvZHUwQVZjUjl4MmdORDY0czUxNlBJcjJpQU5XSklK?=
 =?utf-8?B?dDhFbUhjc0kwZlhpRlFPUXNXcldOMXZMbWl1bWFYak1kNDlTdjNEbHpMTzI5?=
 =?utf-8?B?ZVU3MnZVWkdsL2dJQW1HN3pUcmNFWTk2VHZlY0MyZ0lTYU5sNGtCVEMzKzVi?=
 =?utf-8?B?WnZwQ1lEMTQxU1VBcUtLb1BRb2pGOFJSVzVyclpnWkVjOG9FbGhZOURPaDFs?=
 =?utf-8?B?S1hFQjVlbXFpaXRHRzRrc21UdDkyQjVjbVd0UDA0TDd1RzB5bmxrMmE1N3Bu?=
 =?utf-8?B?QTMrZmFjWHJYdmh2cnFORmVNeDN0eEJKY21NdVlyK0NxWW1RNldnNVNTUVdi?=
 =?utf-8?B?Qmo4TU1mQVlXV3A3Y0JHNmF3bllsb3d0VDcyWklkcmdDOUZPbmh4Z0Y1UC9M?=
 =?utf-8?B?d2diQjF5TVNleUtSZmR1eE93RWM5d2pTVDRjVk5Xa296VDhnNVplVC9xd0Y2?=
 =?utf-8?B?TUIxb3dwZkRxZ0ZLeWUxdVJBV0wra29FQzlBRVdGcDliQUtzeG5Mc2N0ZWZK?=
 =?utf-8?B?elRXZHptZU1YbVFxVDlzOTFCVFpERDlaSHpNdmFBRDZvQnVJVGpiYlRDcHVC?=
 =?utf-8?B?Yk9MVitNc1FzcHEzNnlZYTRUTVJMOSszMnpTVnc3S2RZSTRNQmhXbEJvS0Zl?=
 =?utf-8?B?Ty96NGNpTzFmbElqVWsrVXVnOU8xdkc5RTg3djVGQWdsTEVud3Y3c0RQUGZy?=
 =?utf-8?B?bHprSlRZcEk4NG15TnZKQmlIclBMVDluUE00aW1NUGpub2NTOVJCd1d1Z2N3?=
 =?utf-8?B?WFIwcHJoTjBUNUJGSUpCblRDaEFLVWUrOVhDYzk2T1NaZFhwUXVBYlMzUnVV?=
 =?utf-8?B?RHdxTXMxOU4yQ3dTd2QvN2dWSHNDdGlML1JBSlpNdXRvZFlGRTFobFNSYzMy?=
 =?utf-8?B?Q0h6aUt5ZUR2cVRyVTdEOVFyVWlEN041SXAvQXUxbHZBeThJOC9VRHVaWXlS?=
 =?utf-8?B?N3FQWEI4b0xMekJFbFROOHA3OElqZlErL2lVemJYZElwZmFFQ0RidVlQbEwr?=
 =?utf-8?B?QjZmVGVodEtKemcxNys3RDdmVWxrK0p5YS9PaXIxNWYvOHpNTFg1UFVKdzhV?=
 =?utf-8?B?Q3paVGs5cnllM3ZaVFN5bXFXd2UrTk90dHoxZ0Q0bk11NGJjdTkrelhDTlQy?=
 =?utf-8?B?bXRuQnp2WnRGRldpVUw5NkRQZENLQmFieWtwVFdjUmRVbG1DYU5LUERWMDBT?=
 =?utf-8?B?WStmS3NlRmF4UUhobHpSMFhhNkNVZEFxMVBmWjlKUmhQazRWNHp4b2ZiZkJ4?=
 =?utf-8?B?SHYwNjdIdWFKdGgrRGlydU55ZFFYWXgwNHF6aFdlSjlMT1Z0dTJxUFRQSzBl?=
 =?utf-8?B?V3c2U3puanBnPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WFNDVmlJdGJvb0N3Q0JjbWZIcWNoeTh4N1N3NjdWVllwOGZOWUROWVdGNUxx?=
 =?utf-8?B?dDZIdnhaYmdsU1F4d3g5VWdBeUJoQTZwZGlraFo1N2tpTGV6bHNuNkppUjRM?=
 =?utf-8?B?UnNHN0YyZTB1aVB1WDRBRE54WUxnam13RDZpNS9lU0hnQ012WDNxTjVOaTBD?=
 =?utf-8?B?aXo4Qk5reGNEZFJ2UVIrVTk3Y0RSRENkbkZHTlZCOXRzMytpWkdvTUJvNHhV?=
 =?utf-8?B?ZmYwYVJwa0hEZTJsa0NTN1pxSWpUR1IweWttcjErNkpVRHNNTno1TzdPSjNj?=
 =?utf-8?B?ZFFJc2psb3JVczJQYy91Y1N6RTFpaWhYSU9jVHlCL0M5NE5yNS9UM2EvRGdi?=
 =?utf-8?B?VVJNVUdSRDlCaHY1RlJRa2liR21mTmRBK0xrRjFLakJWK0lqaEVzZlJzaUhn?=
 =?utf-8?B?T1U0blJpNkZDVFc1RUEwZjR0WDYrc1Y0RjRTTklPUHZWM0gwZXRFWTVQdENu?=
 =?utf-8?B?RDBIMjlESWFDZytoNng3elJDNzdtU1ZBa2c4dmdQZDJFTisxb1FoMU5qSGFB?=
 =?utf-8?B?WnVSREVWUEUrdWNIMWMwVXRmRjRHNDZxcFZBek5wRUJiV2VGV1VyU1F5T1li?=
 =?utf-8?B?K1VYUzlJWFIxSzZrYk8xeXFBdHEySkRnVEJPMEl5S3pqOGhpcCtJZDlVd2tU?=
 =?utf-8?B?bjIvVkRYRjloM3hNZ21uRHR4ZnR4aW1mMmo1SC9SWGV6UURUTHA4bi91aHJO?=
 =?utf-8?B?NjZtTkEyOFgrMVMyVHRmUmxTdjIreU56T3gzL0JSREtEaEFPaU9RRTNra0dX?=
 =?utf-8?B?VjM1Z1B1OUpQVUo4RnBqZzU3ZEVsT2RnWDZFMDhlUVl3bzZENG12Z0NENkw3?=
 =?utf-8?B?R1I2MVVUdlBvdEozc1V2YUo0dUlMckhycVdBcDJHVjB0R3Z0UGFtQ09OeEVj?=
 =?utf-8?B?WmNQa01pUVlubmhDSGs5UlpDNFZYZDRrSm5QZnZ6L2t5VnNMU1hIaUF5RWds?=
 =?utf-8?B?cEY1M1IyQmwycUk4K1dMUVRzMzFZeVJhWFlzMkFNTDFkdFpFSU9qcFBNcnNr?=
 =?utf-8?B?YWFZWGZRUEc0VkdCT0pqd1NpQ1M5YnVybCtZVGRkMGxXU1kwNXJYSHpLbnRC?=
 =?utf-8?B?NVBuMWRpZ0x6TXBpZ05OQ0ZxRmJGVmVmZWt4SWpaMzJLZDB5VkFtRVBpNVlJ?=
 =?utf-8?B?WURiVktiTTFnRGYwMWdtbXJDK09EdDdKam1QYXpuUXB6MExsUWlxSFo5d3dF?=
 =?utf-8?B?TnAxVXQ1bWhGZU02anFlR1FIeTE0UHhGVVNDMGlJMS84Qnc4SjFsVkJCSGt4?=
 =?utf-8?B?ZlIwTGRMbDFmOUxtOGJIRmVTbnl0VWxZUHpiQ2YrQTU3cm5xQ0VaTU1FaTlq?=
 =?utf-8?B?cHNEcHRYNE1vcll3bWhrN1NGVHZOZlV1U3NXbTdnZHQyKzAzLzNXNzZMMkt2?=
 =?utf-8?B?KzF0RTJteHZqMHE1b3R4RmxpeHJ4TXh5NnBRaUJFNmZPS1EyUXlSbHNXTzJV?=
 =?utf-8?B?aEdscXVXVUZ3R1RJVVNyQVo2YlF3cUZyMzNZWjcraFlReXJ2L3ljUldLdThn?=
 =?utf-8?B?M3d2b2o2TW93a1J4VjMzTjl1T25yMWRSc2NveXpoVWxWZndHU2MrdEdBTG41?=
 =?utf-8?B?a0dXNEV4KyswVHRYNGE1eTdXLzlvSk1aOGd4YXRGS3dWL1NXdWdIaVg2SHM2?=
 =?utf-8?B?VDFBR3Q3WDhtb2FRZXFDdG42Z3RNUERucTRCWGFmd0h2dVl0eWdiZGhOeEdH?=
 =?utf-8?B?MGd6RzBXd3RaUVVXVGQ1dWtBelJNYWVyNmhyUUlCUVJFakpQdTQ3VmphS2dM?=
 =?utf-8?B?YUhEamkrdHEyZlRROWpldmpWSWx5R1N6c1ZwRUp4dXFBc0hVbWJ0all2YUVG?=
 =?utf-8?B?Qkh3a3B1MjdJMm4zQVlIQjNtMksyWTZFdS9scEIrVVJwK2pSdEtPYlpPaGtJ?=
 =?utf-8?B?RHVON2NaYms4aGtwcDBneHNHS0hiZVl5T3BiVmRRa3FtVlNYdXA5RndSbWlB?=
 =?utf-8?B?QzFQR0VndHk5NmtmelBUUzQ3TGNxSVpLMkN2L0lZb3FnRVJLWS9WNVBQRjZK?=
 =?utf-8?B?Z05CdkQ5dFY0UThBNkU4QWxrRWFKM0p6UnVuSlhDTWhwUGlCeEVwOTk2VHFJ?=
 =?utf-8?B?d1VvemJReC9OQVpxRi8zSmF3U2hLNCtNd1lqQmEyZlJNOFVVL2JGUDZUdTR4?=
 =?utf-8?B?Q1RUbytmdlkrbFVIRzJXWGNOWkZoZUtQcGJtelYwTVhTNXllM2UvbmNrWU53?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gBUVTDfabM/6B4kORjeP9Cjo0r0G9zfgsa69fKYibfL+m2UQS9nlt3pnxNxFh4GGuDA5Jo6V+C0K98Lhqu5t7p1P/qpbbtCnBX8finH7jLBKBnuvpYWuLY1d+oCxZiGTl4zDVRdgfq6yzqPjBKDtNnXHXmG9/qC6nseC9EgNC1xEuE0QwYl3lFhg2qG4nY7ntIB1kgH2v8rzVSv6XmXIsurbSGWGunFQ26MqMXkQTOlebwAcWvcOfBYjRpJYQRbRznz6WcxGPjgZSlhRaEw8GXLw+EeqFgnlrFPIWSSgQtEuOfPLK/amnMH1erZ+E9Qp9khuF5MytkMg2tBdtxt8cjiwny95E5sZ/026xleGzzhnVALbUbS7qChupd+YPodnNwWjwW5w4pFQN4HKZFHnzwJ297ZCfLJyMIUI+afGJNMk2vq2Grp6lvOeJyNzlBnIqK6r+IewO3BDG0Tb6zfLHf2NCgOq2HPDk2tEEcnWvGa48GkZk1BNhUJ/yQTx07MRKYz8/FIcaTXEZ/DIF/aOyEMp96peDa/80IzoWHfvkXgoqWlmitb7Yr1uj4Pe4YGHXnlhJFU0mbZ2R2Yko6FwUEy/6aSpelPq4bDT6jxGQ4o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71df3c15-5923-43a4-7df6-08de2e5bd8f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 08:55:15.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gqzs7EyWRtpMMr4NKq556fUASrHOW+53KKTGWg6jBIFZa+3rIC7OEsyDun/z/+WS896Wmo90UAQ9lkDnxnx6vyWA3IsFj/VqAbehVaWYKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511280064
X-Proofpoint-GUID: EXNlJ_7U0cv1iRUpP2CdVhmrO19RHVxK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA2NCBTYWx0ZWRfXzrlDyQA70JxM
 gJ8zF10Grs5m06XZNM5vXwTVO/3zr+BzFzOSdyxAMitp5O/qHO1h6FZdwVBWZ8Bu4XuGY9W6l5y
 n2SLzHW532YE4vskAqpsqy4rSs/5DxK+7AAMgTHcLUbu/TnR8zsw5kCBZvbZG28K1XpaWNrDULH
 udxvTEYpDB3wFvz4iKUCz7QBAR/OKAwlagFxLj2ma5CsapEJ4pyunPVe8ONQEXeMt/TXVzmPcoA
 MFjCGkGITN/DWYSx8mikA5yBtlMPjRMGbF0qPzZjAfBekjPJQ4vh13WrfLdPv4lkI7Eyq5tPYgs
 Vz/h517N1rpnxP9pTv+KvyeQXUo7z0GSR22I3k5jcJRKuVhsuECX6x2uvV9FDhWLhWkrHvcQ2P9
 KiKBoYgydmeieG77j7dVhmMZep1DMKSeneYgOh2iw9y/0zwYpT0=
X-Authority-Analysis: v=2.4 cv=JKA2csKb c=1 sm=1 tr=0 ts=69296379 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=07d9gI8wAAAA:8 a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
 a=mZgBUAlvKaVGFrIKYr0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=e2CUPOnPG4QKp8I52DXD:22 cc=ntf awl=host:13642
X-Proofpoint-ORIG-GUID: EXNlJ_7U0cv1iRUpP2CdVhmrO19RHVxK

On Fri, Nov 28, 2025 at 09:39:06AM +0100, David Hildenbrand (Red Hat) wrote:
> On 11/28/25 03:53, Yafang Shao wrote:
> > On Thu, Nov 27, 2025 at 7:48 PM David Hildenbrand (Red Hat)
> > <david@kernel.org> wrote:
>
> Lorenzo commented on the upstream topic, let me mostly comment on the other
> parts:
> > > > Attaching st_ops to task_struct or to mm_struct is a can of worms.
> > > > With cgroup-bpf we went through painful bugs with lifetime
> > > > of cgroup vs bpf, dying cgroups, wq deadlock, etc. All these
> > > > problems are behind us. With st_ops in mm_struct it will be more
> > > > painful. I'd rather not go that route.
> > >
> > > That's valuable information, thanks. I would have hoped that per-MM
> > > policies would be easier.
> >
> > The per-MM approach has a performance advantage over per-MEMCG
> > policies. This is because it accesses the policy hook directly via
> >
> >    vma->vm_mm->bpf_mm->policy_hook()
> >
> > whereas the per-MEMCG method requires a more expensive lookup:
> >
> >    memcg = get_mem_cgroup_from_mm(vma->vm_mm);
> >    memcg->bpf_memcg->policy_hook();
> > > This lookup could be a concern in a critical path. However, this
> > performance issue in the per-MEMCG mode can be mitigated. For
> > instance, when a task is added to a new memcg, we can cache the hook
> > pointer:
> >
> >    task->mm->bpf_mm->policy_hook = memcg->bpf_memcg->policy_hook
> >
> > Ultimately, we might still introduce a mm_struct:bpf_mm field to
> > provide an efficient interface.
>
> Right, caching is what I would have proposed. I would expect some headakes
> with lifetime, but probably nothing unsolvable.
>
>
> > > Sounds like cgroup-bpf has sorted
> > > out most of the mess.
> >
> > No, the attach-based cgroup-bpf has proven to be ... a "can of worms"
> > in practice ...
> >   (I welcome corrections from the BPF maintainers if my assessment is
> > inaccurate.)
>
> I don't know what's right or wrong here, as Alexei said the "mm_struct"
> based one would be a can of worms and that the the cgroup-based one
> apparently solved these issues ("All these problems are behind us."), that's
> why I asked for some clarifications. :)
>
> [...]
>
> > >
> > > Some of what Yafang might want to achieve could maybe at this point be
> > > maybe achieved through the prctl(PR_SET_THP_DISABLE) support, including
> > > extensions we recently added [1].
> > >
> > > Systemd support still seems to be in the works [2] for some of that.
> > >
> > >
> > > [1] https://lwn.net/Articles/1032014/
> > > [2] https://github.com/systemd/systemd/pull/39085
> >
> > Thank you for sharing this.
> > However, BPF-THP is already deployed across our server fleet and both
> > our users and my boss are satisfied with it. As such, we are not
> > considering a switch. The current solution also offers us a valuable
> > opportunity to experiment with additional policies in production.
>
> Just to emphasize: we usually don't add two mechanisms to achieve the very
> same end goal. There really must be something delivering more value for us
> to accept something more complex. Focusing on solving a solved problem is
> not good.

Yes.

>
> If some company went with a downstream-only approach they might be stuck
> having to maintain that forever.
>
> That's why other companies prefer upstream-first :)

I think trying to do downstream-only is going to cause very big headaches if we
choose to substantially alter THP in future (and of course - we do intend to).

>
>
> Having that said, the original reason why I agreed that having bpf for THP
> can be valuable is that I see a lot more value for rapid prototyping and
> policies once you can actually control on a per-VMA basis (using vma size,
> flags, anon-vma names etc) where specific folio orders could be valuable,
> and where not. But also, possibly where we would want to waste memory and
> where not.

The same for me.

But given the actual author of the feature has already treated this as a
permanent and unchanging feature, I absolutely do not have confidence that we
can do this.

The situation I feared us running in to is that we'd release this even with
CONFIG_EXPERIMENTAL_DO_NOT_RELY etc. (note the flag is somehow now
CONFIG_BPF_THP which... isn't what I wanted) and people would STILL rely on it,
then when we try to change it loudly complain and make it difficult to remove.

I am now convinced that this is just going to happen no matter what we do.

So the 'rapid prototyping' approach is just not workable, at all in my view.

>
> As we are speaking I have a customer running into issues [1] with
> virtio-balloon discarding pages in a VM and khugepaged undoing part of that
> work in the hypervisor. The workaround of telling khugepaged to not waste
> memory in all of the system really feels suboptimal when we know that it's
> only the VM memory of such VMs (with balloon deflation enabled) where we
> would not want to waste memory but still use THPs.
>
> [1] https://issues.redhat.com/browse/RHEL-121177

Right, and that's very sad that we now lose the ability to do so, but rapid
prototyping isn't feasible - I think we're seeing that.

That doesn't mean we can't have BPF for THP. It just means we have to set the
bar CONSIDERABLY higher - whatever interface we provide _has_ to be
future-proofed to any future changes we make to THP in terms of making things
more 'automatic' - and has to provide sufficient power to be useful.

I wonder how easy it will be to figure out such an interface without
accidentally causing ourselves issues down the line.

THP is a special case like that - right now we have very broken interfaces (as
evidenced by users requesting things like the prctl extensions) - and we want to
be able to fix those in the future.

Of course we have to maintain uAPI compatibility, but even the discussion around
mTHP khugepaged and 'eagerness' points to a desire to change how existing
interfaces work - imagine if we had some BPF hook that then ended up needing to
introspect current max_pte_none for instance.

So perhaps the answer is that a BPF interface should come later when we have a
better idea of the future of THP?

The whole cgroup vs mm thing again raises old issues about isolation - the
cgroup people reject the idea of THP being a resource that can be managed by
cgroups - so by even allowing a per-memcg thing we're opening that can of worms.

Anyway overall this series as-is is not really upstreamable I don't think.

Maybe we can figure out a read-only introspection hook that makes the least
assumptions that can be provided at low-risk that'd help with issues such as the
one you mention at least in respect of informing what's going on?

That could form the basis of future work towards a hook that actually changes
things?

There's no need to rush.

>
> --
> Cheers
>
> David

Thanks, Lorenzo

