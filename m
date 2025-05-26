Return-Path: <bpf+bounces-58940-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA7AAC417C
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 16:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05C23BD109
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5F3212B3B;
	Mon, 26 May 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LWNZr8cE"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92AF212D9D
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269946; cv=fail; b=NKUKutE60Ce3VQtKJK9ZueTra97FaDXp0etlr1vt9oYhdveh/G22E5W/ckmF+hivCz4Cog9HBZ3gzMCkC+jhu6Va4pQ1yjedzYIw8RI4+NrtpcUK3XrzOS1Olag4JoojYBIZAf7cxYnszKwRb4C5nl/Jfh8Gl1zkovAH6jbFMKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269946; c=relaxed/simple;
	bh=qcvaQ/tGAbXQQZWRGctNVk/GJR1hAokl8t1o/y/HXA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDUXKmKtWTDk3MtDPoA00x3+HiYu+KOA4TeEjGVf79yYhLYDR0d9fRGSZycIDHyUIMzYoQYxTH8AXhbdb7i1X+sZ9fGuztKDAfXSW9jkZdT5pyFnmgVwAD9iZsryBd6ddXzr8sceN02EPohwEpbwJuPh8ZJXBxb4cOYKHOOFt6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LWNZr8cE; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAOWxQjT3KpWNQ5TOrOEpBTK44hLZKAXs3vADC/viXz6AR9ZzaAg8mTzQ/goN6GkixGC2bhJ9OztWFwsvGMqno0wnT5kl6D0hMbPH7s5WcrGdDyj6au7yG4pH+MdPrmS23vvTqOeBcU/a3wn9rJOwfE5lBxYnbS9znkEyk1QUJzFmgOLGGKSeC++D/kDW4uxubCsXCe1sg1SWUD0i6WoaGEFJXeZZR2+4edL5qDprVNu3aLb+8MgJMMzHcZ4eXxn9rs8z3N/NFuETPw6OsW3ElewvUOGQfBvguKbm4Oa+Z3xDXiymKdOgyc1CcxVgeulmyFHUdxO3dvTGRCwBUruIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLDslDO7+d5a45vA+Yc+ykqFeOMWiqpNzSVozsBVteM=;
 b=wrwQKJyOznx+J1m3nm21S9CW70ZyLuHKTuVOAzxKQnO9rJUWnpPBFZ4mWKgGTLSt7brL9uAlBiFxe6Vs+5I0QYAcUWacWgCGvLdBiP/wEfXY/Z0upp8fJhDUY8LCU+pkzAgwRE6gLgG6ngxiTrYSKXFdyW49Q3gRvcL2H9KyeepTBDeiA/fBkf1NCvy6r3JJEVTYhAdwqp6/SYCu0HeCuE9M7YYAPEnn9bQF0675afC6b6xFlLa55guSDhE5WTFB2722gL1LhO90DQG8OhvnQape61mmrprp6JdmGREYkAXeNnIN8o09uSVvt7Q9sws4E6LRwL37QGiJq/qH1CqsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLDslDO7+d5a45vA+Yc+ykqFeOMWiqpNzSVozsBVteM=;
 b=LWNZr8cER0zr41w4vJP5+jHjAXIPT8BjYGs+I7AJD4JZXLYdfHOKeUY79jUZt9LjjbhxSttyLtHYtAf6DpJZzUkvnJA4VO6BpLjbDdK4WyZs7poMyGkn1T9pqFl7DtrNacTBjGqXnrfyUsjdAD9KWxyCXyFgApLDyQoqYuUUEBECPD8sME7qBCeY3Ooj0hNUEbu7Z1ez0lXyd6G+nXAggwHt9f/RvvTLWLcNLAFk4HAgNSgCTnnJwAVWVYzovUjXcPOnKkNJXJXQUF1Ub/FUviOC/PiKk/frW3d1SC4P4BTgcdcXTaIvP9A8bfjSStvUbZr5SkYtBRzNGZIOaIcd7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Mon, 26 May
 2025 14:32:20 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 14:32:20 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
Date: Mon, 26 May 2025 10:32:18 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <7570019E-1FF1-47E0-82CD-D28378EBD8B6@nvidia.com>
In-Reply-To: <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:d4::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f38517c-0ad7-4f73-90e7-08dd9c621f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEZCNjV3WTBXRVJHUnU2bHRaMmRtaDFhVXJLeVZ3a2pvbmxud2g2ZGd6WFV1?=
 =?utf-8?B?Z2lPdHU2K3JFNUllRUtIVDRHL2QvNmZCZ2ppMlZLcmhwTjdEL09MVW11Ujl3?=
 =?utf-8?B?NVBNTk4wMCtPMGVmNkFGNElYZ2ZQQTNPZDd2a1BGQmZEVFNUd2pGc3lGemdt?=
 =?utf-8?B?OS9UZTcvcjl5REJnLzBiQ2RDV0tpdnlNUDNHVFZSbmN3VDYzelAvT1VKOFJY?=
 =?utf-8?B?TFdGalNKWWJJY0dQdktraDNRU0JSQ1dmTW5lUmc4c3kzZllvSFBWQ3lDbUVN?=
 =?utf-8?B?QU1DSlphOEY3NDMveWk5VXd5NXU2QzdoTDJ5UmU5MzBlbFZBckxBRGt1OUZS?=
 =?utf-8?B?Y0srWTQyenVTVExpRm4wZi9sbVdXQ2VDU2Q1djJjVlM5SFltZ3VuNm05SDdl?=
 =?utf-8?B?bktyRHdYb2pRTFVDOUoyWkQvUXJVTVBuaEwwdTRkN012YlpSN1ZXQWV5cU45?=
 =?utf-8?B?SU5jcDByU1NPeDRHZjBvaGhjSC9zTjEvUGFYQ0h6bGdidVB5Rk0rME5rb3ly?=
 =?utf-8?B?OEFnU2h3TzdZTkdqeld3NFNFdXNkeEdjem5oeTFHNTNrZnB0SlBOQk5VQjRu?=
 =?utf-8?B?MFlxUjlSS2hFbVdUK1lxMXNISXgzLzEzNzUyb3RrV3pvOVhTaUtaY0tBUHhy?=
 =?utf-8?B?OUhDdXpsMm13UE1aS1R2MExacGQ2WEFncWx6Y2tvSnNKUEtadzFHSk5ZdWJD?=
 =?utf-8?B?L2JpOW5EQW85eWp4cEswOENPK2h4L2xiNVA1Qlh1aUhGcm1xeFlKdjJJZG1x?=
 =?utf-8?B?WWtuQytRZitCVTNNZGE2STh6WFJ1QnRUMitUUlJFUkJaQThHYmQ3SkVid0x4?=
 =?utf-8?B?cWZCcmFiTHp0aXRTdTlUdGEwcWFDS2ZUei9YQU11NFVpZUxLeFdBU0lYc1pa?=
 =?utf-8?B?NHlGZGk4dUpSR3NmVFVRVFRjNE9hWU5TZGNSZFA4M2NPY1d5NjNJYmpwNHFN?=
 =?utf-8?B?YnN4Wnp2WUZ3SXYySGhEUXRqUndhWSt2a3UyQTRYMzM2b1BhSkFJNFZ3b2ps?=
 =?utf-8?B?MjRHeEQ2Yk56SlQ1YjZuemN6N0xqcExBU1dkVFUrWC80ZEFWdkt6WmJnTkhl?=
 =?utf-8?B?K25uOENnT3hnSHRnN3dJYWxGUkJ1WThiNlJ3TmNFMnNRVmgrRzdPUDJla3ps?=
 =?utf-8?B?amg2djd1NTJCRDNhSHU4djh0dE1kVzhwMTVSTXI3aDFOOUppblpUNkNnbVpo?=
 =?utf-8?B?dlN6MytPdW16QlpFWXJaQlZwaXprNDBlWWxrZC9iNlg2SFFNMzJYdFY3ODlr?=
 =?utf-8?B?OStqL3dTZzZsaE9TaENRc3FxWWx0YVJBOHpEVmVVMGxFRXpodGZXbFNXem1C?=
 =?utf-8?B?SC9GamJNb3F1V1ROc2lIeVhQYnd3bk1QUk5iajFvU1ljLzc4OUcvNFVDWmhE?=
 =?utf-8?B?ZmNXYkZ2WjBrWDB3Q1ExV2V3eXd1SnZ3bDZYeE1CWks0TmVmVmVDMTdsNGwy?=
 =?utf-8?B?ZWx6YzJqTW11Q1pKTW5COUtQSUh0eUhPK3BON0hQWWw5YjRJRkI5VUNWWkwv?=
 =?utf-8?B?R2s3dkFuZy9Fbi9tVW8wTjFmQjBzbHhDR0dXQVdqcFFzRnVNVVZWdHRNVnJh?=
 =?utf-8?B?VmNMS0JzSlBDU3F0RHdZeHg5OEZCVmV6QVEwK3MxNU5pYlIwWFdtUU5rd2JC?=
 =?utf-8?B?Qk1oYUpCMllvZ0ZaSmQxOEpOa2tScitnUVp0dU00UTdkVzVGUjcrcTl4SE5S?=
 =?utf-8?B?d1FYaHQrUnVSWms5UEZZTjZTdm05VENOVVZ2RW5LY2VFbjF3bEZmVUVacTdK?=
 =?utf-8?B?bTE5ekJsQmlsaE5yVHN3UG4wOGNzR1NUbFp6OURCd2duMHVHN2hNT3VwOWRo?=
 =?utf-8?B?S1RwUGlCSlNhdkVlSWFZbkx4WVBLdE5nd1dPU04vK21wdWhiY3hKRWNDZjFz?=
 =?utf-8?B?aE5oNjNYeDNGREJFa0JxVW1VWThxa0hyYk5QYkFSUm55RG5xMWFBSG9FZzVJ?=
 =?utf-8?Q?P8zghLkpYSggOn2Vb+Kz0hb+PF4P0wET?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWU0aC9JNkZEL3BnSXRHbUtzdGFnVjVWNzk5UjNnMXNPeDFOVHo3SGJlUzJT?=
 =?utf-8?B?ZTNTWXJWWmkzUmRVTlltd3E2T05iTlY3QkVaOFVoTmJkRkQ2aHNCTkdQRkli?=
 =?utf-8?B?QzVLcU9sSE9JMTkxZUhNbGI0dDV5VDdScm5BZENpOWJJdEdHN1VKSFpuaWxv?=
 =?utf-8?B?cTZGYnorWnZJZmtHNk5MMGk2Wm5qajNRaWN0YU5WbDZ3Qks2eHB2V0g1UHB4?=
 =?utf-8?B?VmNpbDJlVWVST1l1b0tleFhZSEFTdCtrMEpPOC9KMmlrb1JkeGFxK0hFMDV3?=
 =?utf-8?B?N0R3bGV3bkFwaGk5NkFvemJuSmxJQUZETjZjdURkMDRQQlpGSytBa1lqeUc1?=
 =?utf-8?B?UjRMbnFadCtTczlTb2RIcVVrdUhwSmdNMlVOOTRpb2hIUDJNbW9uWWxFT2R3?=
 =?utf-8?B?U1ZRMUFKc3ZEbzhnTGdnVnNKS2twNkxmOWw2aHFKOEczcFJyeWJiekhVZ0Fn?=
 =?utf-8?B?eVRCdFI0cGNRNWFRRnFYN0hmZkRmSW43R2ZiOXAzYWc3Zkp3aFc0L1ltRDJt?=
 =?utf-8?B?SWN0bmozOExzczh3ekovWXdvZk10L216UkFDOUMxaHc4YXNxOHFTdnhUUlpu?=
 =?utf-8?B?VU5COEhhTkM5UXAvSVZ4eG9ITS9XZTYyOE4wWll5QzRqbStJTW50dTdTNnh2?=
 =?utf-8?B?ejBJZzVpZ3JjN05KRVpVQVpQL2tUMHdRamIyOHcwSE1sUzh5Q085SmJQaHBB?=
 =?utf-8?B?Z2syZGh6ZEMvNXBDaVRWeXVISm9oVnFkYjVsa3VROGxrUFlKYURqQUVtMWF1?=
 =?utf-8?B?RjZ4YTN4Qkw3OGQ0U1drVVljZGxTOWhMd2piZGpZN1lmVmRhbzI2dXlLNWl0?=
 =?utf-8?B?VEY3dW9hYjkraG96eUdvVmc2TVFDZ1NZbjBvYVF4T1QrV3FCZzNid2ExRzA0?=
 =?utf-8?B?OWIyU2g2NDBBVHpKS0hUaUpLMjZHVEM4eFd2TW9WcElsUCtBNjFNWHFIQUFM?=
 =?utf-8?B?YVN1alVNYzhQbVByb0dvdWZERHVTNWZpYVd2ZWZ0U0FWV01wYnJsTForSGx4?=
 =?utf-8?B?S0Fna0R1amZxTHpVZTU5ai9tTFJNVkxLTElVOG1xcVIxakdYL3BmSHBINko5?=
 =?utf-8?B?c1FjaXFxOGFJUGYzWjRneTJtTU5YWjZXOWtGenBwT0libjl6Yy9zZEpWUGUx?=
 =?utf-8?B?R04wMWF6a1JqbHArZXU4SHVrSE95SGdSREd2QXh3VUdUNDlScjZBeVhPbEF3?=
 =?utf-8?B?RUlPNjUydDF4MTMvbTlGSW1lMmJUWGllS3NEU0Z6UVk1T2l6N0lVWFU4UW4y?=
 =?utf-8?B?Vy95T1NmUVZyRGVFR3g1bzI0Q1lqaHBZNXNzd2ZNVk0vMGN0L0JzYVArdVpV?=
 =?utf-8?B?WElPZVI0T3lURC92WDZwd3NTWG9TM0lmZzFxQ3RzVTl1RU5sbTB1Q0tMdFJ4?=
 =?utf-8?B?dEZtam9YcnYvbzUyZ1JXVVBHSjZGNmhsWXl3Ny90UHR0WkdOd3I4RkhmaDF0?=
 =?utf-8?B?QzREbW9UeDFJK1dyczVNVnJEb1Q1SzNabU9LQnJudWUveWFnL2M1cnEvRStq?=
 =?utf-8?B?aUVkSW1zdDlqLzZPME9vcmI3WHB2a1BDdHN4YUsxSWZqanBUU2plRlNQdGJX?=
 =?utf-8?B?czVZMVVuSTcvN3B5Z1RSdnE2dTVYMDJRNDY2KzJ3UzdKL3RnSGNiYWs5ZzF5?=
 =?utf-8?B?VkFoUm9INUhRT1p1ekZIVCtMbTQ0ajk5RUs2Nzd3bGZTVklFeUwrRlRoSTZY?=
 =?utf-8?B?Y0lOVDBuU25iOFR4NU5mZ0t1N2pEMjYwMG5XN1RDMmY4WndZOGFzczUrMStZ?=
 =?utf-8?B?NkM4WVJQWVBUU2NWeTdOZmRQaXNRZ3dyQkxaSjJsM1FNanAxTWR1bGVpNHRO?=
 =?utf-8?B?NTZJckN4WDg0Rng2UkI0VHlMWm5wNHp0NS83M3E2V21ja2JNSjhYc1E4RmZl?=
 =?utf-8?B?N0pocjkxUk1MT2thcEZ4THFkdkxZMGROMnBFclU5cngyQTRuK2dsRTBkUXdX?=
 =?utf-8?B?VVlvK2dYSHZXWElacUNpRXFsc1JpVnJMcGc3RHZkMWRuR2VEZVBMNC9sSkZ4?=
 =?utf-8?B?aGRaOHFsVngzS1B1bEtmVTRveVlWMm5nd3E2Vm04M3lVaHdyYzc3cVRrVHlT?=
 =?utf-8?B?YzdCd09td0d3cWliQ0dDMTRVYjlwRHk3MW5Ncy8zLzFLYStOUUFUakY0Z0NX?=
 =?utf-8?Q?nseswKvJ02Yjv3bWN/cOxDXsm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f38517c-0ad7-4f73-90e7-08dd9c621f66
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 14:32:20.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEd9ivRwxvMzHUdSGxFZVEnHErHhUn0plHzMWNzbn6bU+6UMFxIoRxEPIz3KENzj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289

On 24 May 2025, at 23:01, Yafang Shao wrote:

> On Tue, May 20, 2025 at 2:05=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
>>
>> Background
>> ----------
>>
>> At my current employer, PDD, we have consistently configured THP to "nev=
er"
>> on our production servers due to past incidents caused by its behavior:
>>
>> - Increased memory consumption
>>   THP significantly raises overall memory usage.
>>
>> - Latency spikes
>>   Random latency spikes occur due to more frequent memory compaction
>>   activity triggered by THP.
>>
>> These issues have made sysadmins hesitant to switch to "madvise" or
>> "always" modes.
>>
>> New Motivation
>> --------------
>>
>> We have now identified that certain AI workloads achieve substantial
>> performance gains with THP enabled. However, we=E2=80=99ve also verified=
 that some
>> workloads see little to no benefit=E2=80=94or are even negatively impact=
ed=E2=80=94by THP.
>>
>> In our Kubernetes environment, we deploy mixed workloads on a single ser=
ver
>> to maximize resource utilization. Our goal is to selectively enable THP =
for
>> services that benefit from it while keeping it disabled for others. This
>> approach allows us to incrementally enable THP for additional services a=
nd
>> assess how to make it more viable in production.
>>
>> Proposed Solution
>> -----------------
>>
>> For this use case, Johannes suggested introducing a dedicated mode [0]. =
In
>> this new mode, we could implement BPF-based THP adjustment for fine-grai=
ned
>> control over tasks or cgroups. If no BPF program is attached, THP remain=
s
>> in "never" mode. This solution elegantly meets our needs while avoiding =
the
>> complexity of managing BPF alongside other THP modes.
>>
>> A selftest example demonstrates how to enable THP for the current task
>> while keeping it disabled for others.
>>
>> Alternative Proposals
>> ---------------------
>>
>> - Gutierrez=E2=80=99s cgroup-based approach [1]
>>   - Proposed adding a new cgroup file to control THP policy.
>>   - However, as Johannes noted, cgroups are designed for hierarchical
>>     resource allocation, not arbitrary policy settings [2].
>>
>> - Usama=E2=80=99s per-task THP proposal based on prctl() [3]:
>>   - Enabling THP per task via prctl().
>>   - As David pointed out, neither madvise() nor prctl() works in "never"
>>     mode [4], making this solution insufficient for our needs.
>>
>> Conclusion
>> ----------
>>
>> Introducing a new "bpf" mode for BPF-based per-task THP adjustments is t=
he
>> most effective solution for our requirements. This approach represents a
>> small but meaningful step toward making THP truly usable=E2=80=94and man=
ageable=E2=80=94in
>> production environments.
>>
>> This is currently a PoC implementation. Feedback of any kind is welcome.
>>
>> Link: https://lore.kernel.org/linux-mm/20250509164654.GA608090@cmpxchg.o=
rg/ [0]
>> Link: https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez=
.asier@huawei-partners.com/ [1]
>> Link: https://lore.kernel.org/linux-mm/20250430175954.GD2020@cmpxchg.org=
/ [2]
>> Link: https://lore.kernel.org/linux-mm/20250519223307.3601786-1-usamaari=
f642@gmail.com/ [3]
>> Link: https://lore.kernel.org/linux-mm/41e60fa0-2943-4b3f-ba92-9f02838c8=
81b@redhat.com/ [4]
>>
>> RFC v1->v2:
>> The main changes are as follows,
>> - Use struct_ops instead of fmod_ret (Alexei)
>> - Introduce a new THP mode (Johannes)
>> - Introduce new helpers for BPF hook (Zi)
>> - Refine the commit log
>>
>> RFC v1: https://lwn.net/Articles/1019290/
>>
>> Yafang Shao (5):
>>   mm: thp: Add a new mode "bpf"
>>   mm: thp: Add hook for BPF based THP adjustment
>>   mm: thp: add struct ops for BPF based THP adjustment
>>   bpf: Add get_current_comm to bpf_base_func_proto
>>   selftests/bpf: Add selftest for THP adjustment
>>
>>  include/linux/huge_mm.h                       |  15 +-
>>  kernel/bpf/cgroup.c                           |   2 -
>>  kernel/bpf/helpers.c                          |   2 +
>>  mm/Makefile                                   |   3 +
>>  mm/bpf_thp.c                                  | 120 ++++++++++++
>>  mm/huge_memory.c                              |  65 ++++++-
>>  mm/khugepaged.c                               |   3 +
>>  tools/testing/selftests/bpf/config            |   1 +
>>  .../selftests/bpf/prog_tests/thp_adjust.c     | 175 ++++++++++++++++++
>>  .../selftests/bpf/progs/test_thp_adjust.c     |  39 ++++
>>  10 files changed, 414 insertions(+), 11 deletions(-)
>>  create mode 100644 mm/bpf_thp.c
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
>>
>> --
>> 2.43.5
>>
>
> Hi all,
>
> Let=E2=80=99s summarize the current state of the discussion and identify =
how
> to move forward.
>
> - Global-Only Control is Not Viable
> We all seem to agree that a global-only control for THP is unwise. In
> practice, some workloads benefit from THP while others do not, so a
> one-size-fits-all approach doesn=E2=80=99t work.
>
> - Should We Use "Always" or "Madvise"?
> I suspect no one would choose 'always' in its current state. ;)
> Both Lorenzo and David propose relying on the madvise mode. However,
> since madvise is an unprivileged userspace mechanism, any user can
> freely adjust their THP policy. This makes fine-grained control
> impossible without breaking userspace compatibility=E2=80=94an undesirabl=
e
> tradeoff.
> Given these limitations, the community should consider introducing a
> new "admin" mode for privileged THP policy management.
>

I agree with the above two points.

> - Can the Kernel Automatically Manage THP Without User Input?
> In practice, users define their own success metrics=E2=80=94such as laten=
cy
> (RT), queries per second (QPS), or throughput=E2=80=94to evaluate a featu=
re=E2=80=99s
> usefulness. If a feature fails to improve these metrics, it provides
> no practical value.
> Currently, the kernel lacks visibility into user-defined metrics,
> making fully automated optimization impossible (at least without user
> input). More importantly, automatic management offers no benefit if it
> doesn=E2=80=99t align with user needs.

Yes, kernel is basically guessing what userspace wants with some hints
like MADV_HUGEPAGE/MADV_NOHUGEPAGE. But kernel has the global view
of memory fragmentation, which userspace cannot get easily. I wonder
if it is possible that userspace tuning might benefit one set of
applications but hurt others or overall performance. Right now,
THP tuning is 0 or 1, either an application wants THPs or not.
We might need a way of ranking THP requests from userspace to
let kernel prioritize them (I am not sure if we can add another
user input parameter, like THP_nice, to get this done, since
apparently everyone will set THP_nice to -100 to get themselves
at the top of the list).

> Exception: For kernel-enforced changes (e.g., the page-to-folio
> transition), users must adapt regardless. But THP tuning requires
> flexibility=E2=80=94forcing automation without measurable gains is
> counterproductive.
> (Please correct me if I=E2=80=99ve overlooked anything.)
>
> --=20
> Regards
> Yafang


--
Best Regards,
Yan, Zi

