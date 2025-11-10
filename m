Return-Path: <bpf+bounces-74047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86049C45510
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 09:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A60CE4E8B35
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 08:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1926B2F6937;
	Mon, 10 Nov 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qBlCgP2g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VRJvXrWN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEED254AFF;
	Mon, 10 Nov 2025 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762070; cv=fail; b=X3X+Wrfx7xiLkmfqmMhF5Q3YU179bs6de3Ixi0DD8iJkb1JIAp+MenkhsBOqB7641GHziVo4REgA3QJUoruH8yD5/7c+ebdl8z6H0PEt1skNlaypWAUr3kPW7tvBOX0+4+v4D0CyZvtprRbEi7S772E6kZrliMrSrqOhwbE+hpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762070; c=relaxed/simple;
	bh=QwZyElD7egKJHeSUzw2Cy94YdBKVFTJf7+yLlJdypPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n79gi8m3EAXnYzDii9ub5GCSRXsO+tkpqewu74HcjLj9cU7RUVs5uy1IBJ5ObaRZaB+ba0emWbkkoM8cp1PbTOMxY+67R061FEXXWqU1tdf9DxfPDQCQ+buTT58M8QZG0SMMzzBbIu69n6ed47pAb4rkZQ4MvZr1971D9zvKNO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qBlCgP2g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VRJvXrWN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA756Cg029668;
	Mon, 10 Nov 2025 08:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=t8WnBxXRKqrBV85LOE
	EDB6HuGTKUvTe9oerm4xKf1jg=; b=qBlCgP2gRKj5Pu9CkCquBl2zYHcFFsEWwB
	WCOvXZ+Zf/hW63EhirUEfr2VpoZfp4SYynPE54YKqK0tqSFk+0ApD2dXDcDttqD9
	F/2X7PJofOuUP7S9axU1m3Wfrw8hUCFkRziBxHfCkMbyoHFLaZee+bQwsLEGoIBu
	qzQFaDdh7ETvjoHO7j2MSb8ZZJ+mmjGHTVyxwvBtqzeBKrjNUCuG8ymBFtmT3ZU3
	Dlix/AKK//yGCoWlRSozS76+7Rz7jr3Uelj4imeMcEx+vXL1DOxpzf6H8MYQHsNS
	uJ69njrgV5bwdZ61kNFgXpYi2eU97gPfvP/dYQfWl6aZHxODdwyg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abbbp03s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 08:06:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA6TY2G000958;
	Mon, 10 Nov 2025 08:06:31 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vabufxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 08:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtZujNKuZxTgmJEJK9W2djpxULWk1VHzsYwota7H2ibLegyrDirQzbq9F6XbNvjqn0zAN4acRT7rFjewcOy1tSXO77xeQVHGcugK+AeZb0jMlp2RWooBibnpdoSydvZoUKbA87+uImY7dMp/o6QhXrMXTf49NaCj82eIQYR4cgOIdAOfdRduFzgO76FzWVe3zex75l4dsygr8+xE4c19x20UnqVXdWHhhtfynzXeIAZPzKEPSR37AmdLZAwVl59GdvPACWeL01DT8iRFwVN2Vr7c85GKDPD5jQAFre5NBGZHyDNJtJeX+j5BJBQpaaqQAafkSvvJyVyHa3qDn9R3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8WnBxXRKqrBV85LOEEDB6HuGTKUvTe9oerm4xKf1jg=;
 b=GMgJKV7sqtUIvAJOFfT1Y2b2Q+tNHjFQtrrx2CeVrRQkgra3JIqfM+AN0YpSaxsqEaNq23A53yDLE+IIK+tKsLY0j/JlKHzLHmGXtzn3JH/EQeWTcM43GvhAWEOQsT6cTCTvzsGkU+2cTHM+OfTdqSuaN6i763jxTdbt54dw1YgQC1b2efIy6gJabrCGBGSjV5GQmF+/X2k6dqgZ43pijxVv6lWzpXWRjTP7mp0YfhVOC0wpayiw1G903Lp6jziSiStBy7ZbMKAFU8xPuN/Pigy62++RXUf1bSJahgkQNWVsqTE7muWGyUBuFpswiqqBVBmY7G6wt7MkVdKSXLZa8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8WnBxXRKqrBV85LOEEDB6HuGTKUvTe9oerm4xKf1jg=;
 b=VRJvXrWNBB/XU2Mue9jhWeZiaDgLo/NWm3VymFgmxNJ2SS/xdO9k7lVimnGndoHVQLetR3umgf/NdfcTq+cUqhtNJ1xe8zThIxkKjIq6ED8pqvOVgcOozJPXJmBMBBkI33KTzLWZqlGzfIvdx/105sIrAl9BrQO2ZKHO1HSg8Aw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB5702.namprd10.prod.outlook.com (2603:10b6:303:18c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 08:06:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 08:06:28 +0000
Date: Mon, 10 Nov 2025 17:06:16 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kasan-dev@googlegroups.com, Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 2/5] slab: move kfence_alloc() out of internal bulk alloc
Message-ID: <aRGc-CV4FklELekl@hyeyoo>
References: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
 <20251105-sheaves-cleanups-v1-2-b8218e1ac7ef@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-sheaves-cleanups-v1-2-b8218e1ac7ef@suse.cz>
X-ClientProxiedBy: SEWP216CA0077.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bc::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB5702:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f8c177-2886-4094-8927-08de20300cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kcPMEtPPaiw950RP90vYTrzK4kr+mfG/dEVPjjziTMkQS5v7xFyMEwBqsAdi?=
 =?us-ascii?Q?3MFxf8fuT/r1jdMZMXidnZKUuVkDurkcr0zqlf+/wUJBe/0lJXWVTyRGR/qr?=
 =?us-ascii?Q?DZPU45hs9BBDUAmBGkeEVRMMn4Zg+Vovqooe/KqPagjg5MlGtYz5T4a5r75/?=
 =?us-ascii?Q?+6Ft3rqDy/qJIlQ2jo+wELv5sXkAxmPqTIKwUKKYbWZvcyqyxHyFVW+vnmfj?=
 =?us-ascii?Q?0H6rbsJylJZn/hhJq9xVUlJzV4vtzczE1JditBtB8qlEFrYKqYaV20Wg+7nI?=
 =?us-ascii?Q?v5NQTUY07b8CcsBnKt50GomWHrp8rRGbe1IDjaEPbNziufhWl5ukkdOudFEB?=
 =?us-ascii?Q?RCKkvUxOkm0RXO6aYWtM/cZwDq1Y+w1fbotKTuwCYDKAciy8/Okpn5W8ESKR?=
 =?us-ascii?Q?3Go6W7Wppv9eCKJfdEfv6ZPP5tuNnHzOfFVVdThnHwnJ4fRGJuOdUXlbNaRv?=
 =?us-ascii?Q?zf19zcTgSpSq2w6+hYoTv98+KcvTAI5tH4CiMQkcO9JdNb46H/IcrRt5uCHh?=
 =?us-ascii?Q?uj/AOow87l1/DKNuZjNW9do7BEOZXa35LcmJdP0GsvTO+dq/5BHyn0xqY14e?=
 =?us-ascii?Q?1x67IJWK5e77Ac5WnzQavdRBlwQ7EhYFVkXfhLUg9A9E5+HPOVNjNnDuCHX4?=
 =?us-ascii?Q?OOsOFIRkZGoww1GCevhatVvEC9HtQFVY2M/EAfQEjCbMjR+K6rm1nFrd6+Ty?=
 =?us-ascii?Q?m1buLsyGxSBI0+fz6Itz5ysf/74bppKIpyBq9O7lPuCdRuVZeVenPbSlKkEj?=
 =?us-ascii?Q?OikrGraafIZWHvOnDmjqJm9AORk17QmnqY6oj3tlLqbVbTTSEu/MVH3hmO/X?=
 =?us-ascii?Q?FljtOzDxgSu+qE7fPZmlLdP3GZGQirSq0GSuj0dCaH7rP+gGn3F0vwIUr8cc?=
 =?us-ascii?Q?ToH7ZWyCEi7oSc7xOx3p4NRou5rLN5KQwLFhGfBwuRhh+V+P7VkuTKZZm3Gb?=
 =?us-ascii?Q?8hBHgS3qg83bfVjt46oWX+mP3BJkrvXpHK0gdNV8q0ScYkyyvOSRK5NifDeD?=
 =?us-ascii?Q?gz9TjqI5v4EkmX7dRt/3yZM3KQ1N2VkrlEmrCB3/xHeaLtwr8W5syuufiUmY?=
 =?us-ascii?Q?6IbAowVS2I5QimCindRNXEdetBrbIBHyaV1/Q4i+qlgZDe8fthRYDYdsXqML?=
 =?us-ascii?Q?faOBIaLWpHsKOlnF0EmfzSWrWDEExsSCT+8SgeliZZLIchZ8NBgR/xoMH40v?=
 =?us-ascii?Q?nfoVA2D9DybEZu2pUmqo6xNRB+A/xRvHV4iO04UMgShnfdgkm8rOZA6S8rUj?=
 =?us-ascii?Q?e+TPiCCxXtlbjkhmtR+vHGzhLMcjySC5Ntkw44z37bzNYHCh+Jd6t5EVaBBt?=
 =?us-ascii?Q?NqFp4lwtC8KqP4JhcqhuxILHHpBuLsR52bLeY9kRPkWazJWX9vhTDRyEJVO9?=
 =?us-ascii?Q?Taiq4JJWylTlZRp+3GssndVP80LnTBay+RH7P7QOPsZT2QITHjbme71h8C8t?=
 =?us-ascii?Q?LGDSSCosO/UHMPDzGl4VIljWo320zDlq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t6n6p14EJ3uszObZv38f62RFSNm6BL944beVPpQjNvy9K2KCHMHgeRBelWDF?=
 =?us-ascii?Q?KMyciF34jFtP8PGEfbguCmkQRcirSE5Yzm4OsETSlyJ3skf+r4GyoKyOJuzz?=
 =?us-ascii?Q?pJzXB/i9vg6bIpcW0sdt9HV/TtCxbYDa3RQCF0pduoT+ZlklgpQyp8ZLMqMq?=
 =?us-ascii?Q?25CyJtyv4l/Bt7FNxtk1DqEXdXX3Ytr88FMsqAJ/n++0QvhpeTOWn8F/vkyP?=
 =?us-ascii?Q?av5WcQgU7x7YJNlkrubqGY9DoeD2Fd1hpx386cYxSnPxocUO5/GS77Pf/fHg?=
 =?us-ascii?Q?DEjPgoORHoCqt/VcQYMTN6mWnC/WEeZuGbOsiBSP6sgy2z+88TGM7MXLnj2L?=
 =?us-ascii?Q?IgaTWHmbaZKuD89I+pkdwmjrsY/vo+fzBHgZCIeGrvw9eDihKvH5TayWVEH5?=
 =?us-ascii?Q?xQV9d1/WYCOySqJthH/t0fycru8+aCzcY/iVrHW6LQpGeCYwKWlnAAR/ZFJf?=
 =?us-ascii?Q?iM7WkXJ9JgootHDc+GAKw8NmbtFGRmJI64wD7q+xY5qbb2M5pZVTOusQn/CB?=
 =?us-ascii?Q?lz9FJ0Z7t5ZzjqjdEzW3xne4FAGeRW0RzL02YB/hlfoy38Y/CPeP5HlLY9R4?=
 =?us-ascii?Q?ekPUk2Ag1KR+fQU7AEsiZhADNeFaSvbNEQ+tTU5MvmXJdhdqqnQXitRwIsNh?=
 =?us-ascii?Q?B2RiHmTcPWftUS7DOvpf5j6La2UTDS7r/GFYxZ5SaT1QwTReKVOKaxj1SH7V?=
 =?us-ascii?Q?y7HKK4N/AQiYTj6aAJjEvnJU8kT8OohZrEYPyGlBCRfZ6yosPvy2pXFzQoWS?=
 =?us-ascii?Q?7MjuoBuDsDHmKfOUDcX0qTqguyOROpu1UmOEvZpF4/U8xJydLulwqJgmsjut?=
 =?us-ascii?Q?356286Te41TF/dbL6JVmxge9kRxwxJrQCzuSNOw+jCuAK4g/CVjjYst5kWLs?=
 =?us-ascii?Q?Jt2t4bBoeqZdvKlanYjxr32XZDM7RqYMwH7mhJP32zPKDDmxQTE4mh1MVSG1?=
 =?us-ascii?Q?33EIksgOAGVL/18DyQzPtRzF9wyRCKonfb8I1uCBEBHBiqdrhjWm5D2FXI+x?=
 =?us-ascii?Q?38lDI9zH2YxqYlCUYB0qeg6MU2/9VdFyAPTvF1KLFX7Tw3rYnRv1Y8U4aZRo?=
 =?us-ascii?Q?iuCyb7C+nF+iuzye2ygWlTRhMy7uloENfEKSmdyf6GCleaB1mY6KuRt6FHcN?=
 =?us-ascii?Q?2eP2WGjRb0v0ZwSyV/tTfK2kwojVmxTdtWckwMFlmAgmMqcREpSUc9Po6AJa?=
 =?us-ascii?Q?XxX8wt9xmVK+imYIOZMB9hohKVlqqnWPakodi8IZ/o+8f5JLFI/qM1f7j+bu?=
 =?us-ascii?Q?/vDG7iRA2bxc0tXRpSttuc5+XQraGETTZW8Wqlr2iA+enxKfY1GOU0WD7FKU?=
 =?us-ascii?Q?s/ZHvngYfLX9pj4owPtet/GCufUT7+sk4l6XpqGqcVdfXhzcxCL/UVmuOaVv?=
 =?us-ascii?Q?pXXrDj6MzDYais9JQXVLPDF325ViEu2bqedFk99L14iOssn3FUxu1QPMpew+?=
 =?us-ascii?Q?z1/1/H1vF9zjIjkdpSEV2FVSO2wf/GKRYxu9SIfsJQa+zWYjet9BCKKVfDF7?=
 =?us-ascii?Q?qSG/2L/zAcKnp64s5Ku+keloS7MbUyEYr4XAC+CLKKr1aOcVXVkBumynhVY5?=
 =?us-ascii?Q?PkfC6CeEfx1kYBhPwtmczq2Be7zqzdpvuvUV5y6A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y1FAb1wZDerytE9AUTfhowTajcFie1zQ2nQ5ULU6sjriGzujV8SITIv5xlH09UkYyS/WlxTqm6v9Y8ccn5j9a/TOqLPCsCwsyNyM4/viJjTrr2UWx3pv0a2yS1YO76Sp63A2PH4V6DIjISLHF0QnukVLigk64HKRr4fWE6W+SfjuXLLQxCkiqKUuvbQEfRN8OSRISCAPqcsGPGvsDuZ043j2dzOCcK2Nvb3AisL1xIdi5U/hgAqyld7fJbvSR/fO3TdgOgq9gWHKbjbHjGKlc4VX6xGpjzuvOfVncSx1gmRx/InsunPZqFDVrOd6UkZtiRH1ojUt7S7BHtXUbiWkBkTwtUFS8uB8bZYwouR8nJybhxa4LlJnaA7Oma7UdjkKp4TKoEwtu9kaHdrXQrmhYGHhtDSmxo9SH9eKglDZ6s/Apot7a8/Twb8nu++2VUafCFX2ev+xoR8dRQNrX3z4K/q3/do7pNrMZ/tSp5eOt+GEebGUK/+khrpdXFxMjlLICuABb2I3rBkcNBS0w/MJdgd97K/v6wLVjoUeyFXjYLZ0yemUXybT/8BQvLKlCR2+Uw14R5STuQwsQKwvhZ2tBBjrFt/b5GJxUDYNlY3Z6zg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f8c177-2886-4094-8927-08de20300cb5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 08:06:28.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d61dAA/W/biuyZXHYBgoYmasKxiuVNtF9Tnw96ABZUmlTq3hchhkO3pQusg3UzpM9ON4LkByyC84z20K4M1Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100070
X-Proofpoint-GUID: udjYCla82JYAHFEk-Lh1sJiDy_0SBzTm
X-Authority-Analysis: v=2.4 cv=FIgWBuos c=1 sm=1 tr=0 ts=69119d08 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=fuAzT1JCOia5qPoTQrIA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:13629
X-Proofpoint-ORIG-GUID: udjYCla82JYAHFEk-Lh1sJiDy_0SBzTm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1OSBTYWx0ZWRfX+3y3u7S2MePF
 bQiDz+eN1YbTkyG2oqB+JUtDiMA7gCGtINN4AgtyWtTgV2PlXS4Gz55ClGI38sjDZPHrcVeKf2Y
 ezDPtRJ0ULOlgs3pqHgyQZKtRQN5td81ZY/VTmqKjR9eN4bg2xX3U0S+20C31/8Tdd1Y8bZrkfc
 g4jhtL77f3Dis084L9PReujRrCbWunIID7APbTf0Mfd5+0Bt4nvyFmRb00+woYbDoevF0SIN+QY
 Baslnulp+cjMXVMYUrntZIhXLukp+f54FVUPCKCz3F1vzW1zw/3KydVAqZhQNjZxKOgcoQyf7gj
 kOQvsljllzN9PU33vAYlkcT34CJGpQlMQusZ6RRHziKKwXZCgqoSf0jAeWFKX+3sKua6J0dF5G8
 MPCsiH7E61w+JGoxVynKUZyemo60iVvykcNcer6/HsOp4SaW0wo=

On Wed, Nov 05, 2025 at 10:05:30AM +0100, Vlastimil Babka wrote:
> SLUB's internal bulk allocation __kmem_cache_alloc_bulk() can currently
> allocate some objects from KFENCE, i.e. when refilling a sheaf. It works
> but it's conceptually the wrong layer, as KFENCE allocations should only
> happen when objects are actually handed out from slab to its users.
> 
> Currently for sheaf-enabled caches, slab_alloc_node() can return KFENCE
> object via kfence_alloc(), but also via alloc_from_pcs() when a sheaf
> was refilled with KFENCE objects. Continuing like this would also
> complicate the upcoming sheaf refill changes.
> 
> Thus remove KFENCE allocation from __kmem_cache_alloc_bulk() and move it
> to the places that return slab objects to users. slab_alloc_node() is
> already covered (see above). Add kfence_alloc() to
> kmem_cache_alloc_from_sheaf() to handle KFENCE allocations from
> prefilled sheafs, with a comment that the caller should not expect the
> sheaf size to decrease after every allocation because of this
> possibility.
> 
> For kmem_cache_alloc_bulk() implement a different strategy to handle
> KFENCE upfront and rely on internal batched operations afterwards.
> Assume there will be at most once KFENCE allocation per bulk allocation
> and then assign its index in the array of objects randomly.
> 
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

