Return-Path: <bpf+bounces-75697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A8C91FA5
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 374354E313F
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16692328B40;
	Fri, 28 Nov 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HQpkK8Sg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="i32nQPgn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD630B525;
	Fri, 28 Nov 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332572; cv=fail; b=avcTS4Iwhj8mOLPOepwhqNfQHaJkOabSPfBXCnPDscG0LocI9lQlFUFh7Bfby76xpVVTKCs7W74ppVNxC0ioWC1ZkCw5xrFABW3r2QvAu77WAKbilmAk5T1jfXKDwl3cvzbjNJ4HNYYNG9JdQuLz7gYcMOBdiW3pNGeEFgJGLJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332572; c=relaxed/simple;
	bh=SP/dl4Qrvo1pW2C4Mvi0n/48i5qemsSK+iAMB0QBUDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kpO6htF3enm+JlD2IRL0L7bErGGKwpjuEI3qozqv3UKJQgwwEGhzLlbJpv8hmBgYiLLGwDwy0E5vBOgGiWAmViSHxXPWianxw9ozGl+KPS64eSI1IS1PlFdDJdVWU+xTrjVtU2MSDMIgk9Y7vtFdLJ3+pWqyZsT3KXMzNPLMAXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HQpkK8Sg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=i32nQPgn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS7uGdx3016548;
	Fri, 28 Nov 2025 12:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7MXWmyjP9FwoKuuPWi
	6w+reMnDtq5643N5IZpYdSMBY=; b=HQpkK8SgVpqAzAW26pPT7udm2GzZKmW0fW
	0jt73y6YP1Pi3JFRAsRkOveZcA9M2IS2ZUFHvTpA4x+MXoo7Coua7bVMVnkAVXoi
	QyEtGKYRTQWelzAWSwDLrYxLoUp+oJlQbezib3LLhbuMlJhzeI+f6Yrw9OpVidd6
	Zae+EmVp3E3U7shyq7lwMR5RnjzhHGiWMxTd9NrF664wrUaAaOYovffz3aUYL8c9
	DAXuSDZH5Kbd+CXWeHdXZS4EFEuMsXJNGQFbrKiOvzYGjE+wNK6wWPOaMUmZCic6
	Kia0rHNd71kYatGx9/kaNkhNGbxnc4nuJ8k3eFb78Uafg8zJvoqg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aq3jg8myk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 12:22:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS9rwna029809;
	Fri, 28 Nov 2025 12:22:17 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mgs715-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 12:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MNbxQW9bhhRzY8WTQvsaWN02asDtjwJc5Cs9/5QCky8A0bdCmWzCvlYPV8pf94aRS/4Yp6Y209UbwewcwKnO5oCEcZEl6K4tSeWKNPCduV2MFgurEk5aT4YhcJFYIfGQ6CRtnovRjuds1rJbHrltoJ2Z+sSLxJ92U+AJIIxpmXn6ze6P22AZNwxKAcglUhMMe+4PLDOrxl9+SrCIwG7RLN5w7hXsoiSeiIela7G/O3i9pjaUV41HKLnSWq/wniHi7RW4YOld2Ti08Ofdi/567WqOYD1Y9e0xX9dAdPDuXXs0EjblQZxyVYdEHxVKyMpQhmSHlS3SQWYhx2s32b15fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MXWmyjP9FwoKuuPWi6w+reMnDtq5643N5IZpYdSMBY=;
 b=wUE5+6pt0oD5MkyW9kKCDwuPtg92XN1R0h4bG4mdMAxcOJIjqTcawjXsa1/wwKv2ghi7Tr1Lul2J3M7ry90ehyJ1IFUqCDRpQMWGRAuLxSLJ+T1AvlhHu5+OhEDnG8cHP3WzVwPKBj09xdWAiyuP/MTy1Symn7M+ICi2CZuIYmqnpjtLA78XQJvMDdmMADlHYGunHR5nGuoqWtHVfL0VfTLZwG+4UnbMku7iY5JCy7BWzXc04yQAdT8EpvSUjgTq3IgqThxs5gY5oN/0bWUD6A/qxPglWsEvMyKjVDwWEJvk3tg/KmkVO6NMn7OHPVCxajXrfol67MaEHgquVnTqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MXWmyjP9FwoKuuPWi6w+reMnDtq5643N5IZpYdSMBY=;
 b=i32nQPgnvn9+VYyoOLFS3EFVFBK/QHkkS1jqX8/ALCD70T3FxMhr83LRYG6MjH24kcoKEZid/V/xUWsC7rOGPc0/Fv3bkQP0TQyGyAgw/IRufbFEFzKKffE0ayz1J29vlBwENH54jSzq8v4mbIx8hBvOdUmjhkwEBm37z9fUNXo=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 12:22:14 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 12:22:14 +0000
Date: Fri, 28 Nov 2025 21:22:06 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: surenb@google.com
Cc: Liam.Howlett@oracle.com, atomlin@atomlin.com, bpf@vger.kernel.org,
        cl@gentwo.org, da.gomez@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-modules@vger.kernel.org,
        lucas.demarchi@intel.com, maple-tree@lists.infradead.org,
        mcgrof@kernel.org, petr.pavlu@suse.com, rcu@vger.kernel.org,
        rientjes@google.com, roman.gushchin@linux.dev, samitolvanen@google.com,
        sidhartha.kumar@oracle.com, urezki@gmail.com, vbabka@suse.cz,
        jonathanh@nvidia.com
Subject: Re: [PATCH V1] mm/slab: introduce kvfree_rcu_barrier_on_cache() for
 cache destruction
Message-ID: <aSmT7kMDk7SLqXA5@hyeyoo>
References: <CAJuCfpFTMQD6oyR_Q1ds7XL4Km7h2mmzSv4z7f5fFnQ14=+g_A@mail.gmail.com>
 <20251128113740.90129-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128113740.90129-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SE2P216CA0104.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 91458034-e5c3-4327-b7c5-08de2e78c35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IMlxXHgURdQ6PQBf3ibW+5yQUwUJl4bV9vZBli7BSnsgXOSGk37GQ4JDRWfL?=
 =?us-ascii?Q?q9BH7wU92plaKoUlyBRZh2fSd+KolgsbZkpbCKz9r5CdcQncAZA+fGb9VoVU?=
 =?us-ascii?Q?2WQukffAYuomJUZSF48fv5OXpS/wnjGSH+CUA0lzHdWYzcsix5KzXZM3o0ss?=
 =?us-ascii?Q?zmBClzcS6RETG7mLOCWSIrUvZ3Igr6vNBTRZuZ8DMCB9Qv7+gMwLFIMnixg/?=
 =?us-ascii?Q?7igMBwY4h7ZXH1Hkjfo7UfqE4JM5MWwETeP0M6CqHUXKQSW7qCPz5GaZQkV3?=
 =?us-ascii?Q?K2AjOBS1nQ+W+YvkBKte0Gvz+EsDQIdheaT4Sp4jT6/PAe6zWRkFtsA/3GaP?=
 =?us-ascii?Q?1LvwpwyMIJXB+p0ENpE4ksFdl+13CEczPQoAiOruSUwAD5EMLtNW962GH9MF?=
 =?us-ascii?Q?JmfCO6OdhPcCS3QE4q9MHYDi6ZvvEzQpyUag2QgbeR/DNNxH54Yek3lgmS4i?=
 =?us-ascii?Q?Vzm80NfrnYRlIr+LBRLb6s7Sqntx8TEqWHMA0XHnsbq/yOrGgFFlwtzUH1/l?=
 =?us-ascii?Q?1YDL4JJokptXwEVH6VzDTzdCvSZ0xgVT1J02o4ISfAIwEc+NppIJCzBS+/aN?=
 =?us-ascii?Q?xpgJOUIrM1UjPZPt1/MTB7gklcdnrtupJFPQ++6+MPr6kcEdNtpwzjUFXyfT?=
 =?us-ascii?Q?Hvqd4jx1t+CGWpNZ2+9mfB6ky8ATOb1VbZ9AwqFJOyz/77IInV53TwA2M/Fs?=
 =?us-ascii?Q?puvMQtVRuRhaur2iYbJci+vezHQVFIF77YkPN/Ao/08BjBUt8zNaktKsUP98?=
 =?us-ascii?Q?O8dIhU6MoGgigQJR50OC+Gkvfkrz5p1orhSurtLyvB18vWx0sMpBnEVGk/qV?=
 =?us-ascii?Q?+VLeTZfaMs6//13zdod4HsDPwUp4mPXDivi9Vk/PVWWGeUMAf/7i2NC+z+zD?=
 =?us-ascii?Q?Riq5vIe/DmZoieS7dw+oqfvoW/uZt4M5e675WZ3yopihpPwyXKLBfhER+8dk?=
 =?us-ascii?Q?5IOg8lb/vX9cUz8MSPBVtaoDgZQiEho/E/z2pb3FggIPILY83ckunZPvacd6?=
 =?us-ascii?Q?KashX5/ccUPCZ4CcXmSyhEpe0N+TGQTFE4Bu+lrQSHmyeVWKMdTjKWODVc6T?=
 =?us-ascii?Q?I2xpJm1evEMUW3wKtIZ3PqxYrhaBntJGT7uqnpDwbncj+USUWoFQq2WC197l?=
 =?us-ascii?Q?TSuYtcNCh2MPBkVtsAHllOP/8VocmiZtIqTpIvBaRayG0+ENsjkEr7GAYC0u?=
 =?us-ascii?Q?bBytMxtP4HzLXgGg1AMoo1qf8nzuwC01D021kJrf7XKy93YRUrAiF0E0uD3A?=
 =?us-ascii?Q?50NEm6GEp5pINbC0tckq/KI1iblXNvaMWzMn1em448ccNs/S/gyQnXYGqq/2?=
 =?us-ascii?Q?KhVUu8fjs16RPIAzEsggHyiRo7Dn5lb4KtVVKi9oXYryWOFtWYnrxS1Ec3JF?=
 =?us-ascii?Q?9Z2YpK0aHfiXXgizeIAruWq/Wv0rRw0FcJmj7JyyXQBH6lfAeVjZ+RYBZBD/?=
 =?us-ascii?Q?ttFdPwaKv5fTh0q0FO9AM0IQFkr4sp8Gp8RWgALndaxofovGKgLXOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jC7dxQd6tE+HC67ZG0DeTAMN5RbOYktGlXjGqnbWhqiEsTECdIqUPyvZah7r?=
 =?us-ascii?Q?096kyXDRTnzUDxqZM/SLfh+pVME9r1RRyeFoPlMDy7CG+2PABwMC5BB2jH+U?=
 =?us-ascii?Q?1A6xE7vvdTosi8MF4QoF9GkzubkFz8BWynp6zxB9NdwYeBBSMYZX2COQhn6r?=
 =?us-ascii?Q?cDXpyoHYjlFgz3JDPjLu5uT7CztY5z348gPivzl+hQwEmrCJsUS2Nt5nzLsk?=
 =?us-ascii?Q?uqVxCE+XGi4zCm6ccFIz+anxnICSKZjpq+ef/Nhzq2rXOc7lNfBKGf1nMyVT?=
 =?us-ascii?Q?1J81OjJeJElKlgqG5Oq48n3EqxP8XorLcuIrKpa2zdQYO0zYGQfONysipmus?=
 =?us-ascii?Q?IUWQIlfuvlq8iexw+t+B+mObmnONQYDrF8/KIAws4Z4/VoztzZl+nYc6W6a4?=
 =?us-ascii?Q?foGd7ypbJAFD0Fzy+yQFcyHrPKOUDUNscpo5m+xQQUMkkvBsv0Rmrwe83nGh?=
 =?us-ascii?Q?OTDH/GdHvQuRNVCoVtO54gl/PN6QKyaOWrdBa88XseLtMepy3aNRMzvb2e1N?=
 =?us-ascii?Q?ZBzySDGJP8PLyB2cl/ILb3y0nMETWDiY907bQ3U12eMlazUpTO0n1ZjTgHDc?=
 =?us-ascii?Q?5MaEXLXQmu7uI3L9xMhIfeU5gEL2x/9+ju1z15vxRAzsVr0EEGLkSD1LU8Fp?=
 =?us-ascii?Q?G4kFT0vbYP/IaJbSEH4JSPMiTlHMJdwoqhk+j5EUnTJxVVOCHPcBpMyPJxvV?=
 =?us-ascii?Q?ww+edbQl3rs4UcFmTjkvYlfWoK7hmT7B9p97JwEVRsNjdIpe3w815NcvZ1Bm?=
 =?us-ascii?Q?ENumrKzkwBnfE1SSq8WdBol/2W3wMtJHgPkO+J0m5ZLxS1bJ6VfTSBB2Bpbo?=
 =?us-ascii?Q?lBQfQ1ZtLxJP49/kWJXd44+6cVnunswcIvqfARE3qURsltFKCV70r09MJ1kN?=
 =?us-ascii?Q?JdoWkG5CNTSR4S26E76ffpDsfRKAVC/d2DATQ+/BNE1WZ5teK4Y51T9VRdV3?=
 =?us-ascii?Q?IySp4FbaPuh8+7+ClUphOh36MFuAABHxUToOWT2spv93FpgP5/xWd7eG4aXI?=
 =?us-ascii?Q?/BOo4y4Xoaqt8VrLp4HY/sjZG4Xk57eYYE6BjqWnTEicCHefAwUJzg8NOnYo?=
 =?us-ascii?Q?6CoOopNOLUf8IP938wQMt2NeyxTMvJ1ea7VkUnutRxSZMJTHsGWxA8zzAfbl?=
 =?us-ascii?Q?SgjyNPF3eYPAy78LOro5FQ1c1oz3Vc6esgAb229z4tC3sfqIbyu1K0RAa/al?=
 =?us-ascii?Q?IKpRa22AqvttwTWQz1koi+hzQXtUcB7mTkLPuIMMziUQ1/LferQVYnsdMH9V?=
 =?us-ascii?Q?YVRLCac3Lv4lo66i/+ERR+jv0KucDuJXld2Xs5iXY/4UwAgAC1n+8ItAC7br?=
 =?us-ascii?Q?XCcUkorsvTLaPTm7YF+uJEGHivwIMRsmHxJJLzgF6kRxImxYSmRXdkvTkDza?=
 =?us-ascii?Q?RgAWtUCkZIN+0qLi71VNmgAJ0fq9WotYJLTfKNSxgFDiIeC98FtGAbkZkCdE?=
 =?us-ascii?Q?uvWQ0TLNsyLUpaeZx+Gtq94ddjYg6ftXn0vrB1ogAf96He3MBwP5pYAUbHRV?=
 =?us-ascii?Q?XV7HVd940d9rNunPxT8bu6sBJ0TSS5MeAHVa+GznIktl0kUytgtchmFwYZNR?=
 =?us-ascii?Q?jvferGLo68WD0bYeZHz4WtVnhpThZZ8Cbpt2Xce4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1F71dKzvmpITuFikOtDOYSg04/ZW2Asmy1v0FA6+uzzBkJuEIPDwqCqglM5Zdk++OK/3jldDz0N9ftcdHct/migjdRYjYUc48YFrBpRI8Qv2ymlnwf+wHYXQcFxpLTse2fFWG04QX3dwP+7Rp/WG8Nlkj0OFx2lQgaL6wWaTxHhIw78/g83s2nrG1WgDxJHMk7/wjXNCcyDyfWw5RO/RLYJ06LeLA0Z+lvPazoPIRVB5X/umGGTHlOTmWI2/sIhc1/ewMhwj9WI3fMXvpr9cK5QvtVMcvImlDd/fnaSIkb+70MpFocwsiIcEOfeLz+9UG8fQ7nFaGnvGRbyq8vi9FOp+TYHAmmVHjn1D+2zMC7h/C9gVsV8vKWyIAfYkHVNrhmg9sd9ljP5mk2BIWuZgbYy3RdSnxogDL2MPI2QVZ5Tmgfzq5ee+VFSaaxWGaParsMr33sN2EFK5H8jEMeRXMUrgqy4/rflFo/T6zICLVFeeehk2xRBLxHvDEO2l8HeE+jU9rThiwgM8lVDa3lUXUUWbrYdQeH8CKh8M79Y5c2/bNiejQtVvGaOxuftmemmg549SZSQaA62/EidMitp1QHy+P63TElxdXBeJiS9IIME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91458034-e5c3-4327-b7c5-08de2e78c35f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 12:22:14.3289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KChBrZt3wu1PXsKBD6uPWYxDwBV3cmN/Hk4Izm/piTrzzwUgwiZX+oE3lV5tmlJMkt+X3pnLMKUckK0XUkMHSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511280090
X-Authority-Analysis: v=2.4 cv=HbkZjyE8 c=1 sm=1 tr=0 ts=692993fb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=ws4xpseICEcKeOZcJBEA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12099
X-Proofpoint-GUID: BvrsxX389Ug780vyaYOemnqjOfZDlrrn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA5MCBTYWx0ZWRfX+lxHUq57eJYV
 iYs9iQds8zAuhy1XFAyIAU7ZQYGhWMjbG6B1OYVWKBy7m6KNd6fbmnZzt1Ds9PyfkbxrPlGuqAQ
 +OXfBcKFPz0yhM7jnucDSTKINMwRdSaTuQrzlONy7EBInCAyPxkllTYNMYptZCpm7JoVCJq1FD9
 wzCiaH0O9hzTasykLp/QoVI000EQ+KNTexPwxhphQJjt1z5i6GJsUVrcrPeFh/DOf7Bg5CLvnud
 oN/T0GAxUS4oFJHBWQOLAMONWKPB/Cd9kwXsHduiBZU7nwtwUzRuvH4VmgXbcrb0k4FFkZnjuFv
 acO+W6OQvSbv9AeeS7bDAZDqJ+T4FVOBR4xqyzTeB1SzdoG3FwAdlVlLrR8GxJW1RCGlY350Hw0
 1Mq/vEEg0F+l/LMWKuxpbiWIo18OGqDcSPHHulmU7eCTzWEKiCc=
X-Proofpoint-ORIG-GUID: BvrsxX389Ug780vyaYOemnqjOfZDlrrn

On Fri, Nov 28, 2025 at 08:37:40PM +0900, Harry Yoo wrote:
> Currently, kvfree_rcu_barrier() flushes RCU sheaves across all slab
> caches when a cache is destroyed. This is unnecessary when destroying
> a slab cache; only the RCU sheaves belonging to the cache being destroyed
> need to be flushed.
> 
> As suggested by Vlastimil Babka, introduce a weaker form of
> kvfree_rcu_barrier() that operates on a specific slab cache and call it
> on cache destruction.
> 
> The performance benefit is evaluated on a 12 core 24 threads AMD Ryzen
> 5900X machine (1 socket), by loading slub_kunit module.
> 
> Before:
>   Total calls: 19
>   Average latency (us): 8529
>   Total time (us): 162069
> 
> After:
>   Total calls: 19
>   Average latency (us): 3804
>   Total time (us): 72287

Ooh, I just realized that I messed up the config and
have only two cores enabled. Will update the numbers after enabling 22 more :)

> Link: https://lore.kernel.org/linux-mm/0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org
> Link: https://lore.kernel.org/linux-mm/e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com
> Link: https://lore.kernel.org/linux-mm/1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
> 
> Not sure if the regression is worse on the reporters' machines due to
> higher core count (or because some cores were busy doing other things,
> dunno).
> 
> Hopefully this will reduce the time to complete tests,
> and Suren could add his patch on top of this ;)
> 
>  include/linux/slab.h |  5 ++++
>  mm/slab.h            |  1 +
>  mm/slab_common.c     | 52 +++++++++++++++++++++++++++++------------
>  mm/slub.c            | 55 ++++++++++++++++++++++++--------------------
>  4 files changed, 73 insertions(+), 40 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index cf443f064a66..937c93d44e8c 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -1149,6 +1149,10 @@ static inline void kvfree_rcu_barrier(void)
>  {
>  	rcu_barrier();
>  }
> +static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> +{
> +	rcu_barrier();
> +}
>  
>  static inline void kfree_rcu_scheduler_running(void) { }
>  #else
> @@ -1156,6 +1160,7 @@ void kvfree_rcu_barrier(void);
>  
>  void kfree_rcu_scheduler_running(void);
>  #endif
> +void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);
>  
>  /**
>   * kmalloc_size_roundup - Report allocation bucket size for the given size
> diff --git a/mm/slab.h b/mm/slab.h
> index f730e012553c..e767aa7e91b0 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -422,6 +422,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
>  
>  bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
>  void flush_all_rcu_sheaves(void);
> +void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
>  
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>  			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 84dfff4f7b1f..dd8a49d6f9cc 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -492,7 +492,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
>  		return;
>  
>  	/* in-flight kfree_rcu()'s may include objects from our cache */
> -	kvfree_rcu_barrier();
> +	kvfree_rcu_barrier_on_cache(s);
>  
>  	if (IS_ENABLED(CONFIG_SLUB_RCU_DEBUG) &&
>  	    (s->flags & SLAB_TYPESAFE_BY_RCU)) {
> @@ -2038,25 +2038,13 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(kvfree_call_rcu);
>  
> -/**
> - * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
> - *
> - * Note that a single argument of kvfree_rcu() call has a slow path that
> - * triggers synchronize_rcu() following by freeing a pointer. It is done
> - * before the return from the function. Therefore for any single-argument
> - * call that will result in a kfree() to a cache that is to be destroyed
> - * during module exit, it is developer's responsibility to ensure that all
> - * such calls have returned before the call to kmem_cache_destroy().
> - */
> -void kvfree_rcu_barrier(void)
> +static inline void __kvfree_rcu_barrier(void)
>  {
>  	struct kfree_rcu_cpu_work *krwp;
>  	struct kfree_rcu_cpu *krcp;
>  	bool queued;
>  	int i, cpu;
>  
> -	flush_all_rcu_sheaves();
> -
>  	/*
>  	 * Firstly we detach objects and queue them over an RCU-batch
>  	 * for all CPUs. Finally queued works are flushed for each CPU.
> @@ -2118,8 +2106,43 @@ void kvfree_rcu_barrier(void)
>  		}
>  	}
>  }
> +
> +/**
> + * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
> + *
> + * Note that a single argument of kvfree_rcu() call has a slow path that
> + * triggers synchronize_rcu() following by freeing a pointer. It is done
> + * before the return from the function. Therefore for any single-argument
> + * call that will result in a kfree() to a cache that is to be destroyed
> + * during module exit, it is developer's responsibility to ensure that all
> + * such calls have returned before the call to kmem_cache_destroy().
> + */
> +void kvfree_rcu_barrier(void)
> +{
> +	flush_all_rcu_sheaves();
> +	__kvfree_rcu_barrier();
> +}
>  EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>  
> +/**
> + * kvfree_rcu_barrier_on_cache - Wait for in-flight kvfree_rcu() calls on a
> + *                               specific slab cache.
> + * @s: slab cache to wait for
> + *
> + * See the description of kvfree_rcu_barrier() for details.
> + */
> +void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> +{
> +	if (s->cpu_sheaves)
> +		flush_rcu_sheaves_on_cache(s);
> +	/*
> +	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
> +	 * on a specific slab cache.
> +	 */
> +	__kvfree_rcu_barrier();
> +}
> +EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
> +
>  static unsigned long
>  kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
>  {
> @@ -2215,4 +2238,3 @@ void __init kvfree_rcu_init(void)
>  }
>  
>  #endif /* CONFIG_KVFREE_RCU_BATCHED */
> -
> diff --git a/mm/slub.c b/mm/slub.c
> index 785e25a14999..7cec2220712b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4118,42 +4118,47 @@ static void flush_rcu_sheaf(struct work_struct *w)
>  
>  
>  /* needed for kvfree_rcu_barrier() */
> -void flush_all_rcu_sheaves(void)
> +void flush_rcu_sheaves_on_cache(struct kmem_cache *s)
>  {
>  	struct slub_flush_work *sfw;
> -	struct kmem_cache *s;
>  	unsigned int cpu;
>  
> -	cpus_read_lock();
> -	mutex_lock(&slab_mutex);
> +	mutex_lock(&flush_lock);
>  
> -	list_for_each_entry(s, &slab_caches, list) {
> -		if (!s->cpu_sheaves)
> -			continue;
> +	for_each_online_cpu(cpu) {
> +		sfw = &per_cpu(slub_flush, cpu);
>  
> -		mutex_lock(&flush_lock);
> +		/*
> +		 * we don't check if rcu_free sheaf exists - racing
> +		 * __kfree_rcu_sheaf() might have just removed it.
> +		 * by executing flush_rcu_sheaf() on the cpu we make
> +		 * sure the __kfree_rcu_sheaf() finished its call_rcu()
> +		 */
>  
> -		for_each_online_cpu(cpu) {
> -			sfw = &per_cpu(slub_flush, cpu);
> +		INIT_WORK(&sfw->work, flush_rcu_sheaf);
> +		sfw->s = s;
> +		queue_work_on(cpu, flushwq, &sfw->work);
> +	}
>  
> -			/*
> -			 * we don't check if rcu_free sheaf exists - racing
> -			 * __kfree_rcu_sheaf() might have just removed it.
> -			 * by executing flush_rcu_sheaf() on the cpu we make
> -			 * sure the __kfree_rcu_sheaf() finished its call_rcu()
> -			 */
> +	for_each_online_cpu(cpu) {
> +		sfw = &per_cpu(slub_flush, cpu);
> +		flush_work(&sfw->work);
> +	}
>  
> -			INIT_WORK(&sfw->work, flush_rcu_sheaf);
> -			sfw->s = s;
> -			queue_work_on(cpu, flushwq, &sfw->work);
> -		}
> +	mutex_unlock(&flush_lock);
> +}
>  
> -		for_each_online_cpu(cpu) {
> -			sfw = &per_cpu(slub_flush, cpu);
> -			flush_work(&sfw->work);
> -		}
> +void flush_all_rcu_sheaves(void)
> +{
> +	struct kmem_cache *s;
> +
> +	cpus_read_lock();
> +	mutex_lock(&slab_mutex);
>  
> -		mutex_unlock(&flush_lock);
> +	list_for_each_entry(s, &slab_caches, list) {
> +		if (!s->cpu_sheaves)
> +			continue;
> +		flush_rcu_sheaves_on_cache(s);
>  	}
>  
>  	mutex_unlock(&slab_mutex);
> -- 
> 2.43.0
> 

-- 
Cheers,
Harry / Hyeonggon

