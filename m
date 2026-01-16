Return-Path: <bpf+bounces-79200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6583D2D372
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B301303F0FA
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A133385BF;
	Fri, 16 Jan 2026 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cibzc/Zl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fqR7k/2m"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A234CFD4;
	Fri, 16 Jan 2026 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548593; cv=fail; b=eGUdtweNiMO9uZu3A1DFUXkEt0OdqT18jSNhe0f7hARkneXdCjzPtVpoavF1LLy9PLy4xJ0BGI5x3YC+Ic5tumvV0kMYd9AW4h9EgQO1hpRmRR4lfRNweUXO8VSjl8ZMiAdDmFZHQNsrqZTbWyXzyEvRb+4N3mCfYFWHtfGNKlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548593; c=relaxed/simple;
	bh=nWy02fdVpJIgV5t4geOkeQxbsD1DIRjti7MB4894RHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=afwvOCuPIDUVPOwQ95TlbKJAGmp9bvAD1vcM4bv2cL+Az7KVMEojymYMqUmTeuHYxgBSEKB6AwBv7eiO67L4ij0zGGbwBZ+q1zu+rL5iH3QvjgzR7lecQufYoSR3+CrON9sitnWdVU1aNN67YctrbkLWEPd6DvC2t1WPsoWnPUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cibzc/Zl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fqR7k/2m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNND0h1817752;
	Fri, 16 Jan 2026 07:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wjrLOZCCXcrxOqasdE
	0kfxBLvr1EjRzh4KDykcYPDBQ=; b=Cibzc/ZlZiWYzx7fbj/YwEcIj17Cjgu43J
	DEYxCA2l+tutEr6tCpxEhYiGtPS7/5xwOrixTgap6w4foapIolNEzO0vIFKvHRNO
	P7YeWxzVz4ceK/QNMZTSmS3U11iRqnrHGxShEZOdGmA980mmu521etrw37dUpQpr
	HwYo9KiE1TWek7jxlyr9OhPr7puZGLCXEBr87Mjp9ZPuJuWbc+Yz4ohreybhExtj
	HB/McdxDED0i8b03MQQvhKfLY3SIdzfz6d1y9Y9mwpvVJK3cne5XWVbRhYYE/lcL
	Vkzjlz4PSyK81Q+loVejuxT5OSpPuT22D8zOI9T6t+u8FDLIXv/w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp4rxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 07:29:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60G6k7Fd032777;
	Fri, 16 Jan 2026 07:29:20 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7ckbwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 07:29:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvaQeb2/f+MmahpveHR/IOepMgsDCxTHVBdVVhmPVlVt714XMWXuOS7LHLNZfbrFu8v4Cdpq/O74BNaF15fzaAwxA/EQ6u0u+4fxRSZSsATB5hBD9btcn1b8kUVqZqE7DSS0HHJIbRY3Qdv6nIWMdiIWOLWbFEEAhyiaFaL3xzDq0f0HPOTIbQhRnGWoq/9kVHqBdx7FT67mNx/qrgmyrTBb5Tktj/PXdiDbnOu0ntRXsHLhNZdaI0WaWIZIRhVIdin1HRq1p8FjrlWe9dMDED3buxJf3xnqrn7RTIZcBnITo7q0Bew/zgaiv2c9+Zj/BiVBygVPT0BxM+PnNXb5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjrLOZCCXcrxOqasdE0kfxBLvr1EjRzh4KDykcYPDBQ=;
 b=c/idx56NXbELVhS5uVpYmYXImUgysOa8LLnLoqThLZTJ5m5De7pNm03BhPpZPkL6f4cNMeyw7H60NsqgcEMosaAyaW1xp3Yuzc3W7UdKw7TTAlMQa+STXnlhAUVy5NOVBxDKJ+JrLl6fOA/z1DVXMS+4i06wApsjMKQdcwLheGqjFZYKI30EXHzjHu8zS83Zdb/+Hp6t991lw50ffXhVft1NU2EYqSwJH+fxmj5yenR86QxiRb5V/3cbGVs8oAJqCVDEIgRzASvApyksGGvXxyHdTAG7hM1MIhwoKpQl9hYXg1YtFVVa5R67qaRfwos8KweIUp3AuVOe5peri4UDCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjrLOZCCXcrxOqasdE0kfxBLvr1EjRzh4KDykcYPDBQ=;
 b=fqR7k/2mzM0JIAz2j4NnHVaYKjs3oBSNpfv+M32bxYBfy4ewVghDd+0v08U9Kd1QVxFSeDt3dxKZes/1p8BEjpRgfQBRCGa0n4lVSwj6FeLME21Mwlkiymwv3wcUt8mi+O0fnYUBQcxvVC8ZfLNvQDzQ+nBI9W/YusLOdcpu6fU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV0PR10MB997636.namprd10.prod.outlook.com (2603:10b6:408:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 07:29:18 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 07:29:17 +0000
Date: Fri, 16 Jan 2026 16:29:07 +0900
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
Subject: Re: [PATCH RFC v2 05/20] slab: introduce percpu sheaves bootstrap
Message-ID: <aWnow3tQv0KxSOMe@hyeyoo>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-5-98225cfb50cf@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-sheaves-for-all-v2-5-98225cfb50cf@suse.cz>
X-ClientProxiedBy: SL2P216CA0168.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV0PR10MB997636:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ef7198-b446-404f-2207-08de54d0f505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5DtMEYTxrN+wDh7ipENws3hATLatWOlYM0jbu/CIEzube41137CK2WLNN3DH?=
 =?us-ascii?Q?D5EJ0Hcst/qlJz0mwjI2Yu42ISbFt0HiWdxqCkh98lXyw5CdZwB6DKaRCGO4?=
 =?us-ascii?Q?7g+RHexiW7Ulbd23k5zUDN9AXAqxyh21/3MB1Flzz5wPSrNDRCryMMfs7P5W?=
 =?us-ascii?Q?SbWvimhaKUu6/U5BSC9lk3GD4IIMZK8VWjPAKY14Wj/BiZKEF409JtKGehFs?=
 =?us-ascii?Q?kdyDUiJznAnf4ERNxivLQwqhUY0rA95+HwCgLR3o2Pp8xk7o2haUFBw/CHT+?=
 =?us-ascii?Q?xxHdE0GV1VNEFk/NSc8UQGJKS012NAtif3ICfUzkbA4lOYibKlQMHY010yG2?=
 =?us-ascii?Q?RL95Or9BoKveJi0AQep1sl7JGdIdTX7MVTkFbUPp9SyTJcsB/vY4yQEXxp1B?=
 =?us-ascii?Q?Aau120yOhmOXifYBoQdb8DWYBY/s64+MxMjTeBluVXXGRvY5LbII9kzv+SY0?=
 =?us-ascii?Q?+QLGDc4zVJA9NJ+m3iZ6H85oFPJTOpUqhqx0nks687jofQLXWMcgyqoJWjC5?=
 =?us-ascii?Q?fo0LW4+RML5EhUv+4+xii3YvUvbN3PjYiwaJPI5hEmZiP8gsvlxevDdqgkjs?=
 =?us-ascii?Q?CTzv6A4sNQhABjFbDGhPkd2iLL6TxT3vbh3uc1M92uMnR6g9JMeInt0bABgd?=
 =?us-ascii?Q?PNcJjW5JRL6AfEGsIwphW3WApOKib+qkvYGd6tcI2ANT09Sizxl3xzXxL6HU?=
 =?us-ascii?Q?h2FhD7kkd1isY3ZkrUvxlczP2lbKhl1rw6VuusGKAzweAGC/4vHCR2x7lxbX?=
 =?us-ascii?Q?as7CdMOgWirTCPBZggphDiYWSZYsvPYV4JNiAzURmVgtpyyhoBjfuQaBmqHC?=
 =?us-ascii?Q?HiEOiNzUFcOffbK3ZTymJreq1z3SzBxceYNeJ4QyqW4Hajc47x1qKRZxN0/8?=
 =?us-ascii?Q?88krKfJ7k+x85iFjA4SVpvzGhoVCgeO80dSpxJLuqctatQFYO1UHg+j5V+Qz?=
 =?us-ascii?Q?sbn/LRuI/sN3pxau4Lz5SX+Fn+6YXlWYKqUQHXmfE2F4YGCJB8S+XhhLIE9C?=
 =?us-ascii?Q?0aL/OZM0/Lrqhs8aGPror+Npxvq4lc8jbhCaX+uhqCF2sJ+pXMT8/Wp53hCK?=
 =?us-ascii?Q?rrEsvS0llCHX39TaFHN5OCqBfcckzubyqvm7AlbSuNYPv0dBE9Wo1e6YUQiB?=
 =?us-ascii?Q?D3JQSnm2sSFLOZY5FbwmW6QDps/UIv6DB2evmmSeuLtECK9yZPMHoFgqLctI?=
 =?us-ascii?Q?ODSEY4lHuDP7Qomy+9h+kNZoH2dpNJh8vXHvrnFvZoTjIE8GFTB5TzVdoIyz?=
 =?us-ascii?Q?561IvNJaBuIFtJbxQCUNc54hb0EczZRVIjYUPrwL+5SKNBNmBPyQp7ZX8/GZ?=
 =?us-ascii?Q?TdxlnuLI2SRA0j8poLjabjp3ikFBrErMUK0KRoWFEraYkWRyx6E1qyeu13+q?=
 =?us-ascii?Q?pzcRVlz9WeqF2A40YUTMIlKB5a9vGqyvrccXOt+0RpFGSP6oyxDaswoZJGUn?=
 =?us-ascii?Q?g2mlS1pBAP8kGnuxb1qdTFZobgYvlWo3nMtmouu+aS7HZXRP6mhjH92Epdre?=
 =?us-ascii?Q?eggozCSO7r0jh0+1OI6kt+M69lVylBVIJZ/vooSXLpppM29k33I8/NbxgwxU?=
 =?us-ascii?Q?CSp8h9Nn5CUElxMz238=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R6HG1FPAf3VNEpxB4zkLnVejSgYvIl00dBqM671hirX0z2EtkSqQvedFi6y4?=
 =?us-ascii?Q?RKcNlEt+WY5ubXJ59cRQpp/niAGw3djhBwzLnFcQ5GZpbDRlgsR3gsnE9onE?=
 =?us-ascii?Q?sadix4Fdu8NTNIIN+QUAP57rXjbTVZ0vdSA9iFh4+yhu/7xzQpQNoXI5XRIl?=
 =?us-ascii?Q?TwV0v5jktvyEFpat90oJaaFN15Cu5UudDuYCX3q1k19924iy78h9kTm7fWaE?=
 =?us-ascii?Q?MkQte27kAM5wC5wo2f7aZx5BZrc0G4PikEFBQGQlR0g2O7bK5ta+01mNdZQx?=
 =?us-ascii?Q?93rLmrKJ+RCIW3gsG4qlAbiF+npMakfPc/yJOCviKnFsyvr5cCr37GLkyxJs?=
 =?us-ascii?Q?FvBRmnZSl8u6mQizDOMQBcKTDp0sfyk99WwIOecAPPP1EtCnVYleGGamasP/?=
 =?us-ascii?Q?mFQV2Bd7IJ0py4lhgqkFDQQWaq4xJiB/uEZVMYutcmUvpEfV3m87mcGrD7Eo?=
 =?us-ascii?Q?o054UdhdD3C680ncoSg6fPhfN9UZjH6+dw0uks8A+fI4bOIt0+EOeSHBgS7p?=
 =?us-ascii?Q?R08cFFUYT9yRdrsVguUFTXd/AaOdTbnWpCuc8e3qLR6lXMFmahECp/6/tXFd?=
 =?us-ascii?Q?oGXzS4UQmXQ3NinCMeWOTx+HRqzMUkZqvQ1fYvhh8Iz6LbZN+odNQXJQs4VE?=
 =?us-ascii?Q?6hVr3Tf7xR3vC0avlWBaCmJG92XBmQ/KU1aD6tQEE8kzbpldj2Z65Xh8i5J5?=
 =?us-ascii?Q?JMRiMOOiuWypGh7R/YUx5pXCxIoPL57g6np1LKuDxA/T59vSR0bUZOVGea+O?=
 =?us-ascii?Q?udXsYQhHe6E3SRkLEobXlHtinwyeD+dCePHWKV+sMDmQKMUYYiRrSanFGZpm?=
 =?us-ascii?Q?AZeRawaiUEaLIteR6+2C3xO6jLWQE5y0fdq56hjPE+cXQnqtKbyv6SUinOs3?=
 =?us-ascii?Q?O2i4FlpQnY2JlTePWxQxiu0KMD8/cnh1/PIEfs4LaNkxJ9jZB0bp9ikXL33g?=
 =?us-ascii?Q?bm2mpM7knByuw4K9FU1m0i3qXsu8gLDZlRVRI9fY/NKwHCZugPiaSuwh6owY?=
 =?us-ascii?Q?LqqukdE91/gdigj5R4rB4gg7dP1Y1CQ5lmTYY2IUQi05lBTx6IITvmoLEoMm?=
 =?us-ascii?Q?tnmYPY7eJFGSvvsE0ZKzxC0k8bWF6xxyMRULtIE7QSn/MzrO1CEbf0Uuw9xV?=
 =?us-ascii?Q?MlcM5svaF4X7bIMTzqREW+kOS5NCm5EE7roIx5C/oVNFCUVAdgC2bgSFy4kl?=
 =?us-ascii?Q?EiRCPmBCyA6xnLQAlhD6FOOZ1hiUSQ/mPJ7G67jtVu2B2dse5lih/SuWfgI9?=
 =?us-ascii?Q?ydFqEw1OXgvtF9yQmG/QqFMqCLBrO/u/1eLAuAIXJkHmsPIwTfVqeIZLPOYJ?=
 =?us-ascii?Q?voUfClf9oPMeWmYqn1aw4ss0wM13yk5xB2Z5QKyarR2q6ZARQ2Xa3caGqccc?=
 =?us-ascii?Q?875BgszKFThFub8dW739bJNX3ycqikPDMQ7f2SC61TEFMGthiO2iV8Hu0ZpH?=
 =?us-ascii?Q?31gGjslCfi9sh8GzzqUEKAtlTbJIxVBqHGU8bHTRSFfYiT09dNT3Bj4/M2ej?=
 =?us-ascii?Q?4cRxQqLASJYpJCAuyAFxTkL3R7S5HCkF0fcNrlTMfSlCbaYhRPwcVqnFtGCp?=
 =?us-ascii?Q?8W+d+wt+XuaQ0JkaWdbjNbzRl4144f6m2auW4KGhuonyiwsOJH9VOTXtzDAY?=
 =?us-ascii?Q?SwjFiolbGVLJ/fQJrQtnU3B8BwHfnjYeOz4ZHN5n17PIS4TMWbA6t6gWmlWl?=
 =?us-ascii?Q?pgFPoDZaGaVf/JRpaXsFHZJNnG6VzltzLkoW10h2xgq0CrSQ5Ckw8078Ue47?=
 =?us-ascii?Q?ktA/2kGk/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cBUSucIchFHXqD7hiFDAISC4t6UovXTFLDx9Xj5DzLtsls/Y+rom6aUu1RdJYDgDzDgVGZ/5mj/qdHegMux4ayXKngOEOowbjihGNRR0LfC0SrAkODpTT9FImDtQW03lgr6FOdIuHRe4cdyHg/QA7m2NauxBOLp8UWGqGa9XNdf9nLNbZ54TFoNsEjSSOBmt0gLr9BGKBhRksxfss2PWDIlM6CE0j5VSMNRLyfdU04HHfp0Y4oHtY1eG2qwKF7fTdmnmA5kblKBUIF4fJhas39Et1uxDJ1TBE6rW6bnmmviKUqBACvcnY+U2RuBqRPdDJF8/hPReAA03tXSY8ZDnDFP1FjX9WbZIj/jNGMujozdRfc3cdcQ6ng1nX99F4u2T9NdQP43D9sCXo3rzg9T/r5iy8p1XfcV/DJZvyMT+jvSLWLpF0ULd0JM80Ek9vTDMHxhOD9tu0JTqPzJ17HAI4C+0VmFBTPLrov/DcfWXlDS5OZBQtuNnmb3qiH8Ed7ccAqnKrb+oNrLuAHPrb0SjQSTyJT+NBNLE5g4gzJkwgmo04agJFbQGZl31miZYPHRM+T3JsEPv1aZkf2YH4eAP6jos4k7aUDpxPtK0W9VwJGs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ef7198-b446-404f-2207-08de54d0f505
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:29:17.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lY8I/qBX9gNmeiKct5tQN+8MhIM6WWry/R50f41nbS/Gh5WkQc1kuvziJQRhx0tR89sH7K9WBnWRoWZd8MzsjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_02,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160057
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA1NyBTYWx0ZWRfX0zrLr+4kWYOw
 LjPoLezDw+gfTe/wycUIzicaDoCK+8+fcHPKtCXKJCp3AXhmoMDWsCi8NtOSMtSx+tECaxpLXWY
 qUSXKqCCUiQEzWlzqr+AaWRYVrD9m1zKipvdzYe07M4a6HiFvpk0LH+nz8uiTvgiWom83LsPVR2
 GS+yeggKraUatVh5Q0BosPx5VC0gHNs36GWQXUtEqN2Eaqzpuczl8MFY42HFq3AVF0pvJyYVODC
 fQtJlNgpQ1mhSE7KGjsB18iIUDgmj1qbde98tn3J+Cymb53l/ZFIE39UWGCIUxfnNfJ9St2aH6H
 mEfoelZ6/pWbQsGYUY24csYiQ2bejLW+HbenyfNaIzlANckwf1xzjdG9l3WBaD2w7iB/aGnC2sh
 7Hvp4Gj2kZHjfWMoMU5XiDgIl/Tt0ntxDhH8CV1ETm9fB4YiuJjCry7EYnleLNB2GNkKENfUW70
 TaeZG5Ct7oylUIqJ9FA==
X-Proofpoint-GUID: yQBaaDwFzTxfhgmYr2U3Fg9BadBIxLEi
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=6969e8d1 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=dBbnmaIThoCBKMIWZm4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: yQBaaDwFzTxfhgmYr2U3Fg9BadBIxLEi

Copying-and-pasting the latest version of the patch to review inline,
https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/commit/?h=b4/sheaves-for-all&id=daa81eadcd0f9e3b8085dd7fb8bb873f4cde88b4
> commit 36b6dba09fee446540b8bd6dd771859aedf2aafb
> Author: Vlastimil Babka <vbabka@suse.cz>
> Date:   Mon Oct 6 12:13:33 2025 +0200
> 
>     slab: introduce percpu sheaves bootstrap
> 
>     Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
>     sheaves enabled. Since we want to enable them for almost all caches,
>     it's suboptimal to test the pointer in the fast paths, so instead
>     allocate it for all caches in do_kmem_cache_create(). Instead of testing
>     the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
>     kmem_cache->sheaf_capacity for being 0, where needed, using a new
>     cache_has_sheaves() helper.
> 
>     However, for the fast paths sake we also assume that the main sheaf
>     always exists (pcs->main is !NULL), and during bootstrap we cannot
>     allocate sheaves yet.
> 
>     Solve this by introducing a single static bootstrap_sheaf that's
>     assigned as pcs->main during bootstrap. It has a size of 0, so during
>     allocations, the fast path will find it's empty. Since the size of 0
>     matches sheaf_capacity of 0, the freeing fast paths will find it's
>     "full". In the slow path handlers, we use cache_has_sheaves() to
>     recognize that the cache doesn't (yet) have real sheaves, and fall back.
>     Thus sharing the single bootstrap sheaf like this for multiple caches
>     and cpus is safe.
> 
>     Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

