Return-Path: <bpf+bounces-79553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BBED3BEE3
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 06:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 180D734BE4C
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 05:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134253370E2;
	Tue, 20 Jan 2026 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p+g4VwQd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CgS/hwz9"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843A299A82;
	Tue, 20 Jan 2026 05:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768888092; cv=fail; b=kSWocNCEEgVx3DG0qve73tUihTcmrii8UTarO4iuu7LxtNKeuBH+BBrokhBK/S3OcawCB+YKCmSZCLyoSD4RVfBBdOG5e70CCmLySyjeXPdko4TtxGnKLeLJ752Z5Oe1BVrp86xKt0PnX8qsd9pItq97d3L/GM1dANgDtSi45u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768888092; c=relaxed/simple;
	bh=U//BkmlTXjjWABjNPtIFwVbjauTALZNmy/8gEd6chFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PBfQ5xbmroJPLZld1DbjDMIUurYbVY1k1QtvlQGBef8OMX6CdFJh74itjAF6RInNIJKzVB6FHfIzttp8xBMNgAs71xI12sU6/FS+KwKyMDVH9WxzfjoGPl3E/NOukgbXP4t+6zwYBffKXCv76gnabnYydl2fpOrUWszyNv0voM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p+g4VwQd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CgS/hwz9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JBDYHK1429552;
	Tue, 20 Jan 2026 05:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=u/mF12DfoWTKqoNaKY
	cbpHAJydp8LUxa5B5LbgR200c=; b=p+g4VwQdMBWjK9GEBPopgrZQIbj/jB4jc+
	WTCN+Eyqf0l1WhhXEGg/7wcIXtcdUVJTSMDzokIyh/PuXof7lxiXxMz6qrFLdFEB
	7Y6C+i0HpSuaGzb78ro+GnnYQeUwVjhm7sN4ox8l6BT5cMZj3x6HzpwQTJUJZDi/
	39nWE6sU2mWCwhCzbDOAuddgEWsEwfId0/NymuvltHAkiKB75uqo5KeEVPFJq3qb
	CIt2Ycn6EKsMcx23H99NsSxIH3q4C7S+xmwotJzylAj0lfg1JIcgBiWg5fOsJHe8
	5G8UapOEJ4WlxWajXhFzEIqdoQun31GbIr3qOI6x5pAzqdd9DW+w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5k141-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 05:47:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K3QmAd032183;
	Tue, 20 Jan 2026 05:47:43 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vcw9rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 05:47:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1RHN9fhWRPWsXtg+6YPhbrpPgNiB4oKcczOYCsOQ2JcLGh04HlLcBf9lEVrTNXe/Y+r03KsLRqBHlEWjHOllLqnY48IdbRkZrcvz7YHXPvyvF5//8vdgyskfwB5EtAT1PhXYvmREeXm+adSHRSrFHIbG9echiDWe4nn9qJZ1GPNkE8IJACvcUfPYT2LSV34Xf1E2ACk+cE5HP4t44ohnkMHn8+TcUlqQeRz0KDBfOzi2r+vLrassEUptUbdSaVuTVULGLYoVnFEMIDpKgENe52jMjPpRMY5T0FyYXXt+7AnWcXN0DSoPZV8fYNiGO8Iv6DrZTCtSrJ1P9rDQfL2gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/mF12DfoWTKqoNaKYcbpHAJydp8LUxa5B5LbgR200c=;
 b=x4uixJU8UkRU0E+PHeOUUKaYJMBdHh4ZVb9HVsAyYdig4iruQknUcXRPqrcMtjEXGSLtl3NijFbCzsr2xGlmSRx+jY40kRHjKQr9xN0kyaAinqFvCBFxhG9X/3IIHlWTUKjQDK4cZQNHpMJ4N7r8gU41ZATJ+jhHEjt/PNMBXJuSchR32WrU3SntLtyjpffbT5Tv7T4ZqCbpGUkSle/hzPSDG88K0ivYL66Lpu+f3BxlOU7I/BHSsOKbOvKr0FoNwuS1Dpt3mjDT0xO7W1gxNM6RaJWEDuLC61zq2vYwsBluSHwhvsDU/6LB54to2rE+Ex5hgS4h+TFoj75OhiUgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/mF12DfoWTKqoNaKYcbpHAJydp8LUxa5B5LbgR200c=;
 b=CgS/hwz9N8s2tw0RpOAQCWdWWFiyx3St5nRKxn+ENZouQaQ9WxMo/u5DtzgM97J3lWBhlxJxYoZqg7TbvaRfBHWdFXbh0iaznO7S9qSLyAyxqwqD27IUS70neItPzfJPX0cgjGOHF0rSZVJZYz/uC8uZ8vzXlo5El42cWUPlWso=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH4PR10MB8227.namprd10.prod.outlook.com (2603:10b6:610:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 20 Jan
 2026 05:47:40 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 05:47:40 +0000
Date: Tue, 20 Jan 2026 14:47:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 13/21] slab: remove defer_deactivate_slab()
Message-ID: <aW8W8xEMJegAzVgE@hyeyoo>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-13-5595cb000772@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116-sheaves-for-all-v3-13-5595cb000772@suse.cz>
X-ClientProxiedBy: SEWP216CA0081.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH4PR10MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1d36b4-66d3-4190-0af0-08de57e76c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?43LWrLDyR9TPowQtU10LpkZ8k0c8MTpq2y4ep7ZbriqkC3FkUB9y3zAP4Gpe?=
 =?us-ascii?Q?xToCz+dYwTuVLcSHaLrklIAkS/1IHrY7QFLJ4qokR64bSPojTH8a8XbIS8Kn?=
 =?us-ascii?Q?LI2UaJvYXDrhubgg8f8gNqKFskXe4ub4lS4lY8Ji9Yi4vh3cpUxiHagsL1/l?=
 =?us-ascii?Q?5sSEghat/qRdJlgO0ffDaHyXcMuT9iwohbkVRc/HcJZW4lN89hqmFvEgCETX?=
 =?us-ascii?Q?cSOTJ5sxgIjQahRl3ON1k8eWGhIvZxZ++JSRETRh/wyXbsNJ2fr2I9OYIUKp?=
 =?us-ascii?Q?gtbXBedqLMdz1Y6ZpsExvMsAxiIoIoHCOYvFTzsIikDXj9G7MsWPo6hoyjK6?=
 =?us-ascii?Q?Q/i2SLiAjtrjqWcRmzj3OoaAJpubhOI7Iw9BkE5RaRpYhYecnI8y/aFYofQO?=
 =?us-ascii?Q?J8ANV1MWLFw9yoBS0R+JocU//VSrLkbzXKciJ847vTnY8gXt8sMcsoXXSVFa?=
 =?us-ascii?Q?l/50KEAjve4lvU+YOeztm3PPN0eIhdzfi6iamV58cVJvknLvlVjHdWjtvAu7?=
 =?us-ascii?Q?08hHb5xz7z5kTVVqI3cP2zkjvb6/ZgItuDp+NHJrsg4lNJ0EorgCNbrjAggK?=
 =?us-ascii?Q?fjq9IzFek6Xbbn/FXQRhanf/KInF59YMBkZ503kJJwxdysIys+rdglUrEBmX?=
 =?us-ascii?Q?OGgprofyFF7SyTqdPRSQsJvewhQKtYT8tioeqE0l9viujOjVhTuemHV+yoix?=
 =?us-ascii?Q?ufcQna2Gs9TrcDCExZO3TVGEahRpfQcy52kRKpV8PNJEghZwMjlMmDxvqhyL?=
 =?us-ascii?Q?cTK5pN8XRA8qvR7Y7wCBp1VIq5HVGu363T3xGMer2NS6hGkmyh8EdtZ48L4v?=
 =?us-ascii?Q?j/zsBn6o6Zt0optjlUY46f9qZ4v+jDgMOGrzXybhU/FYWwVMRtZ6ZuQRj9Pj?=
 =?us-ascii?Q?H8RP/CUxaqq9eEoUbrkjaFDyYSKVoQiLn0La1Xls6s3BC3ZwaBTStZyxx5pk?=
 =?us-ascii?Q?4x/pzsRRunAvq+8rKTfQt8iY4aqp658SbbAwoMZmwhzJK3TZZjOiOsFVjeOa?=
 =?us-ascii?Q?F8H9Hv3l3kKsdjwXnPOElagrNT8ubvfzZCXXztcaDEjWnVY+uHrRoFTKEQim?=
 =?us-ascii?Q?LzeS6yZZgfeMFa0aO/uIpW2KycP4teFUuTCm6HXB6oVQOWgESuK7NcWta6r8?=
 =?us-ascii?Q?3TmDkyJSElXC8YlQeuSYhHc0Qokqtcwg1GFFCqglG5uTj+yYrhw9eouS2+I9?=
 =?us-ascii?Q?2myjXh1s6wwbAMLzPdI2dq4UWda3jz/r+zC3+tb3WLAopX4FNoxVhBlTEes2?=
 =?us-ascii?Q?y/4RyWehM+NHuUVIC+anHYzaofeyu482bKM59ZYB7rm8wZuReL0q1stoMV/E?=
 =?us-ascii?Q?LhcGPXerW7b1eAoqqaNw6TW+sQvpDQpC/TR99VfgHi8xUisnWkZuQ6vcfqZ+?=
 =?us-ascii?Q?9b3SR5P8k0bpcGpbn9DoU3WGPH9o8WAPEKuLOzl7jDr0V84XJEt/wmXxrPir?=
 =?us-ascii?Q?ubAHGyrT2FpmSiW5im7pGyMu9D5RBVTD74/LLDYMrCHcDsb9CuTWJVIjEBLZ?=
 =?us-ascii?Q?uCrjmgSTCmfohUVxsbImBcyrqkyDTX141M+j8oeTcQdgnbibK0IG7wUetNVO?=
 =?us-ascii?Q?kTLwZDqfkEaTPtUakXs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?egWQ/BVtnEuqTJJOw03NXx0Lmt++na/+s6H/2ThGjPcWtsOlYMBIAtNwwFsA?=
 =?us-ascii?Q?+YB2VgABD/QBLmklodlFmCM7OXxnDzSQ4kCm/WH4Goj25QJAzpGR/kvzqWE6?=
 =?us-ascii?Q?UG7B6MCSoPSS/Ger3AZYY0zECuLAvjbfn7879Q3C9BSWOo+55d5F0xp350sa?=
 =?us-ascii?Q?ANBSzOv4SWIuIiK0D+KXvS0jKJw6jbEpXmNL5SoU5ZIYnKmIo7CWgu2PEUlN?=
 =?us-ascii?Q?90yY5dWhv7G2I74OCozPWHvGxMZgtvSYeqeZJyb/P4+cvkQV60DlEbUr564U?=
 =?us-ascii?Q?hJQffclTTauwspujlKnSC3yQkGqjRZMiRieBXy/eRxnZ2Db54uc9C7u9Dfau?=
 =?us-ascii?Q?U/fSGcYYN1n+eFIam8JzfqfHqscatk39lC6HHiuknPAvzr2xAvJL2kbOEnFs?=
 =?us-ascii?Q?EMXehoeo3bvE0xk0o/v4E+evvXhCL+rjuiJ6g3ebY+ZCAPBeWnG9eoqMJZ0V?=
 =?us-ascii?Q?3bx+M3CohJnvCVnSV2PAT7h4Usl0T3DLsVUtUhTuGiVaM/ilwAPPqqE7UKD0?=
 =?us-ascii?Q?+cvbWMD4SAzWGuSsugfaSzEqooKO9zdvRAkLVyeoBO5seyCeJodIrTyMtHTC?=
 =?us-ascii?Q?4S1IJPcsQVwhW/YV3goUpDB3T9arFAgzoufumEiVD8wQ/Hktcv6YMEi4M0yI?=
 =?us-ascii?Q?4Og49BmoQ1b1jEkLOSkwj/rNPumpMg+QJwDo2v1P0F8xC11D339TfTdWfVwy?=
 =?us-ascii?Q?I1P3HM5u3nyxlMBMqLwe4eukI5ugSciTanxeY5Z3hGO088Ms3JgYEXtNT5z4?=
 =?us-ascii?Q?1qTLULImowPId6YshlzP7umOgvN8v0RYDaihCTcF0Bvb8Vq7D8naDE57vRsW?=
 =?us-ascii?Q?f4Tk1Bk2kfYtNu4A4/zc4W9LLuAez+VhqqHnpoOh3d9S/6Tcl8EofiaVtzdx?=
 =?us-ascii?Q?3WAXJxo2AViDiwzeCXaspMKyrC/u9/n+YRbUSoIa3dilOATe3/Hl6MhC8lC/?=
 =?us-ascii?Q?BbRbPl+ly5S2EhtMaLatu/xcUGOdkKMpx8p5KdzX6rHhacDCqYLmEWgPpuZF?=
 =?us-ascii?Q?8vnzQ60NGwz6tbNKdXiu/t/6Mjroi0GS32WeYtXUgeyw9LVfnmQf7P+qWoQe?=
 =?us-ascii?Q?1dgOt6KcNAkcC75ws1vEYEbX46Cj/FQSr9vb8B3eWWz68fu1D8BEFIoOIvDu?=
 =?us-ascii?Q?nF52F6I5XAHZDcT7/5J6QAeS4fNOnshmwNUcGcPVIq1/4GvPxGRCbzGwmR5B?=
 =?us-ascii?Q?kDeVj3cKzM+2L40Ig8h7tYpCUuTLeXgmKdLkZ26YyktJZjVKzoCDAqw/O+zh?=
 =?us-ascii?Q?AMBviN9k78b8uLa0cFH/Lyp9PI1yQSuMdbYq4nACNr2EnnWy2GWcb4oweInK?=
 =?us-ascii?Q?a8iqKJTKaH7CTuNPNnNBTUmra5GATDCekBrW2WS3MsxbXNQrSLn7enrc1Jtt?=
 =?us-ascii?Q?77BAc7c/VpvS5sdQh4HuG49oPJk9m1vwr7djL8hIEbpNdBK9FTSW1QJM1ogE?=
 =?us-ascii?Q?0i0z5KqQ2dKuLr1bU1SNbHIy+vESU9dqtmQnadiBIS+VQhK3Aq7qJzVei7mr?=
 =?us-ascii?Q?lK9U+7aVyBVcTEQx4KQl8/erjYoz3hdvFByEOfEmMq5VdV/RhObwsYNP9dJJ?=
 =?us-ascii?Q?MEFqQHGKQb6cJMFAzlVkPay55+FTwcqVnmJ8dboC/0xWetaKUcMZU4UquGeP?=
 =?us-ascii?Q?zkdYJGG7FAfTPNTJI38gDxyfWhDXueGhrfev+bXn3qUZNrvGvSSxNLAYr0uq?=
 =?us-ascii?Q?9In/VhpqhEstuQ2eCJIhBEYm9gzuYH2wlzNcVJDZYlqA7Nrfv7rDTHdV/zsL?=
 =?us-ascii?Q?giDlY6RBOA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vijuF2fiRUalf/9cGGt21cgJpBOWuWWGX/LwKmgUXjB84pDcqQ3UXNPEHBCXn5zEdhtkCC52Ym4WGsgmv9EPBxm7/jP+qNnxnsOE/6uWeVS4MvhKTbxKyWRQsnkevKh8g0ekLKCfc/VjtsK1ZF0iIXUfBBLo7SX4z0LbmwhJRExWyYDv/JX7t39zLpEFiSITpun1ySZZYWJxx3syjfpjmYJkDSDLgCoE4hey4QQwYThU3u8FCyzTDYYEik10z8HketSXRUwnPEPy1kfyolbjQXjr3UgkBZOQda/j0GldVDeG8Bz6Ew0zu1pPvit84UOk3FS6RACzKRiy3uaMnyOLeUqHQfA9o4Olle8am0c7+qsMw4M+8HrPbxYohnu618sMs+bjesSemzfhvXa69Mov42cDSMCyoZxIv39zDOmxlfTsuFi0tG4Q9eWgKYUW0D78+hUL1XqVCeStjfxMxIQvlDkUgzBUAUtrqEn2OP7vMi16KOK/iwA0lgsGxCmC7zi2VFW6PqJzY/NoAREpx011GUEi2GoYH20JOc+HjfIypyJFiNZKC4mr69m4sSnAINR2hPqWc6Bqzqr0DmO7WQDBoOuMRkKt556RYpqynY62dDo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1d36b4-66d3-4190-0af0-08de57e76c8c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 05:47:40.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmEJoWNodsYV+x40tXBApXBfbwnCSV1BJMlzULyO02+zGqZIp2NNZvyb/SOLJVrJc7tRwS0ehHvkJSQVkcunbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA0NiBTYWx0ZWRfX/pb6aqzClFEs
 af2FoO5na5lzZkD0+LqcCJzu1b06F1n9CIjYiW3BDOMYdhkceGJhD6gsUJQ9egrvNTGdCkdrm4N
 byevhbaINtH7dMBA3YyVi8Ma5W8UANoYeR3xt/hitQgHaE7t5uaojsEHjVTLyI5c9p3Id3veehK
 Zwgj7PUWDkYutx/UbLAVGVu2IxyxWj2rdMuPFDplEgMc85PFtk7NOO23d2S+5yF2F5Wp6wga9/G
 BpucWKZRcpQ/UcJt6dynDqi5NEWkFMYOxR/IMZLi3+FhDLMAZsMxbRMMzJ2WP3x1qPIqZn8znQa
 PTb1e5STr9N7tPpBFVa5p9tuLdQFO5uiWN4phyXCouwo3xD3ZiBTIkZ8N6krEbtle+3Hy0QD5Cg
 zhCn3VqMOOEmeAWc+BAzvqJGTD5f2dR+U/uXWZJvbAJ13vaTzsXsFXCQJCYfQ6k4FCkhun35v9t
 KrChv1Js+oKLBvrQdQ6PonO+TpeBXCjTzvwJadu0=
X-Proofpoint-GUID: 8k3NpwpXJK6xl_RuLKqztq9aVt82Qc3o
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=696f1700 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=0D7NoKWLiq0uFavQnx0A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13654
X-Proofpoint-ORIG-GUID: 8k3NpwpXJK6xl_RuLKqztq9aVt82Qc3o

On Fri, Jan 16, 2026 at 03:40:33PM +0100, Vlastimil Babka wrote:
> There are no more cpu slabs so we don't need their deferred
> deactivation. The function is now only used from places where we
> allocate a new slab but then can't spin on node list_lock to put it on
> the partial list. Instead of the deferred action we can free it directly
> via __free_slab(), we just need to tell it to use _nolock() freeing of
> the underlying pages and take care of the accounting.
> 
> Since free_frozen_pages_nolock() variant does not yet exist for code
> outside of the page allocator, create it as a trivial wrapper for
> __free_frozen_pages(..., FPI_TRYLOCK).
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/internal.h   |  1 +
>  mm/page_alloc.c |  5 +++++
>  mm/slab.h       |  8 +-------
>  mm/slub.c       | 56 ++++++++++++++++++++------------------------------------
>  4 files changed, 27 insertions(+), 43 deletions(-)
> 
> index b08e775dc4cb..33f218c0e8d6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3260,7 +3260,7 @@ static struct slab *new_slab(struct kmem_cache *s, gfp_t flags, int node)
>  		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
>  }
>  
> -static void __free_slab(struct kmem_cache *s, struct slab *slab)
> +static void __free_slab(struct kmem_cache *s, struct slab *slab, bool allow_spin)
>  {
>  	struct page *page = slab_page(slab);
>  	int order = compound_order(page);
> @@ -3271,14 +3271,26 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>  	__ClearPageSlab(page);
>  	mm_account_reclaimed_pages(pages);
>  	unaccount_slab(slab, order, s);

As long as the slab is allocated with !allow_spin, it should be safe to
call unaccount_slab()->free_slab_obj_exts().

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

