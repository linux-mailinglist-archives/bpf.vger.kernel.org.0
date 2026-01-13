Return-Path: <bpf+bounces-78704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C6D18BA4
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C88593009687
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B317A31E;
	Tue, 13 Jan 2026 12:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JSnE1sT5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OcqJniNT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEA1AD5A;
	Tue, 13 Jan 2026 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307536; cv=fail; b=CAwIVnAptNjocquFt70P2QfBHegsC9eWn6p+RCB6xJAYP726jgmj3iML+E9M1uG0xN6kIF7NLxZqC04vd9n2DS/nJKLd3CEeoXr0/bf/hAz13SNCBnZvNOvSaihUmB4w3rfoPdTomr450u+haiS5j3+6VMCmSIjYCjCAusNEaGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307536; c=relaxed/simple;
	bh=ifOZp9TUgsTJP+QfZpgb67V35ltnd495Qv7QLLjX+g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QMWOHLFZxQrCaccm3b8rbyulhLZ09BlDAufhtqgJbiAsK/8bFyGT5B0PSqizSHeHCGR/PW7dixt5QjoZ+Tguy4BRFIZbr6JieqNdKZ5s/a2Ad/UEuscBG+4i0/bORYXlzEe7IWVZZlAgPY7TUYPMcqbKzZNNOvCR9jEHaTfuk9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JSnE1sT5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OcqJniNT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1gNY22735488;
	Tue, 13 Jan 2026 12:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=A4VJkLP0isOFHN1n9C
	QGVJlgzdS4Wth1+IML7zhFLWA=; b=JSnE1sT5egtFjuX3hRK4iwZotjeGQ+9CZp
	K9H8UdTFDkGdMJahN2oxTNYCpllgEKDxD3PwaYuFUjxHlOueVg1m+13sLrUXpPEg
	8o1SIXjHZR/tJOpVjIOqKXAjoP0vA5KcZ4gVgQ/fCxcaQvJuaxZ6ViAwVRwnq987
	aRJeLLY67KXebY6XXmpWtLiLdGZPOB36JwsWesRSU6RWUPJ9eJmBkJoS5ntsN3bB
	46xLDyvWWcdXXjxgxgUj2yiaUlVhLFfH2uBEtzhwmVZ3kuPOy1iGV4eHdR68v+Qg
	gSyaGVqi9QNjAXV8ekKT5JBiXFkQub/ECHa5v7MtFE6HCoAv3tfA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkrr8b9bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 12:31:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60DAiDYe008148;
	Tue, 13 Jan 2026 12:31:53 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd78e4kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 12:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlUuEFsHBS4jFRL7MQzE0ohGZwumRKoOPi5HXrn+Y2+7cFGI+4u+B/O2sp0ok7rpsgqEYZZDwEO18ejHExIz53o50IMnbyF6H25spnk4El9ugIh25DFYTioEujSr7iwEV0q1v9qWwAmF/sKIXrKlC/bOqrRjmvcFlijrLBcSrbdxsA1EibiBYDI70yxXeQ98malJN6t8j2yCtDy1OfjTtt2R5h6hksjMB8yMHR8MVuF7ixhjJeWUzgy+smqlxP9U2aa6Wn5vUm2lWKmZd4hql8uSGOP7MjWMTeRR40vFhzXdvYT+MPfF0NFxzPqn9rU3OIhIUimkKhOzmN5LONy2Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4VJkLP0isOFHN1n9CQGVJlgzdS4Wth1+IML7zhFLWA=;
 b=xPT5lGTJJQOKhYDWukRvI/ytMrB9AXBJ6nDNTgMAVAKPLcreOWlbERN09Sz0G5oQRDlPUr+iWCKphH4kUtjXIP5Ns2DhqpPTP3AtOwP1Hp8/CkjxqgTP1XiQfLKxCJYTUEO7/laKLkJrGRWhQnNr5aLS2+npSK9wYh3/tX2k2dVQ6d693QAAE8kt0LgUFplG2BAibgy6MOgVoNQV08zy5IUsQuhi82/C1V9WhZn1waDucxG6S4YvaYbjtn1VCynLgFpoaV/mpRAFRek0he4EF7HcinWNHvBjF1/Vt1nCAXvPVXIH0SyaMtOlEyUk0VsXHa3POgth3nTb1mTtGiOWBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4VJkLP0isOFHN1n9CQGVJlgzdS4Wth1+IML7zhFLWA=;
 b=OcqJniNTKX3f69kneC+KbP3IqvSth0Q6vsZJiYUIX+xOYAEJE9eJqHa+uEyuIRw6/0hkKy+y9sExEoOX2uzJW5SUonrF5HDOtEh14ChGudQy23FtSTYr1j2UK1kdntm496utnk2So0IBZ5zgTIjkDtd+B43FXy1Etx+BKnZbiho=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB5038.namprd10.prod.outlook.com (2603:10b6:5:38c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 12:31:50 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 12:31:49 +0000
Date: Tue, 13 Jan 2026 21:31:39 +0900
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
        bpf@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH RFC v2 01/20] mm/slab: add rcu_barrier() to
 kvfree_rcu_barrier_on_cache()
Message-ID: <aWY7K0SmNsW1O3mv@hyeyoo>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-1-98225cfb50cf@suse.cz>
 <aWWpE-7R1eBF458i@hyeyoo>
 <6e1f4acd-23f3-4a92-9212-65e11c9a7d1a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e1f4acd-23f3-4a92-9212-65e11c9a7d1a@suse.cz>
X-ClientProxiedBy: SEWP216CA0127.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c0::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: 47129f52-4e48-4f43-5272-08de529fb8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8XdAthm2mkxaV95IOM8kZjYtSDCijsy4i0s471lYFrMNprwg7rXOk8/H9tWU?=
 =?us-ascii?Q?1HgEj1ahL/68dGE18OEo3YCLxE5zfD3nBfjYAmAHZ59z13j8ObUDoIHGFMSP?=
 =?us-ascii?Q?mgby0e6U5/F0mY/PFTwTb7ssTqtV5Pk87d1ZlMKTn1N8cUAmrZoyrA9z+74L?=
 =?us-ascii?Q?WNB1M1iFqcOeWP7GrJNOU6pn5pU1OfSW7mqmQGvCGwXyAQ3bavQvE9ekrNIv?=
 =?us-ascii?Q?h6ouI8ZFjcuJ7RLe0F3mb4E4Wlh8IlTvAriOJoFlX3N4Ml6JAyleAiIRgAv5?=
 =?us-ascii?Q?GbSgq2wuy7BPH/i83PT41WcbVBB1DcFrf63hSOeB7VPuUzxCt1hsWSlB50gC?=
 =?us-ascii?Q?jIk3o5ejLmfb7KTQvZQocQhrHSyL48LjD6AdLRWe8jSNcYY6KXwbhdDLvdAA?=
 =?us-ascii?Q?vdOfUiomVEtQdth5XyCswL0rWH1tGnVF9uwLZIJNm7NDaaStMSzmusv37RdJ?=
 =?us-ascii?Q?nKCFGdXsMRCdwYHiKC/k0bIOksxiV/4E+zgWCHzh5E3y5jCVTzAg8Ffohyzf?=
 =?us-ascii?Q?tq8i50kcjoE79K8w0okzfQgU7ibLaAkHsw5MtkfEZUlCaP97mCX7p+NmTqEX?=
 =?us-ascii?Q?lQzPUl76hiOUEypBPWU4CAUD2i/w0LLUslA9QtPUgaKaQRu2mnf2EmpE4DYy?=
 =?us-ascii?Q?TQ1jcRAkyHXc2Ks9M3mUkLwbs/Yu3mgPugLI3T3hI5jDsTh8Tn/TTd+1xCae?=
 =?us-ascii?Q?2aOHuTRin4TANdqZzeHD4E3vsHvGQ4Um24mklO1gzygiici+b2SD9NrOUj+y?=
 =?us-ascii?Q?BWS9l+dKCm9xzvEJkweix83wtqYATtshLlZ8t995O/Bo0tL2XDd835OS3/4v?=
 =?us-ascii?Q?lXnluu8ldz5SDK3fondP0aTnRJzMEMXJJul9flJzy2QBRX5AwGD7oGuh5YYa?=
 =?us-ascii?Q?mDRGqw+KhglsoUTq+r9FKOT3g9Rwc536Agj0OpSiaq6/0qw7SgBp0YaSlxW0?=
 =?us-ascii?Q?wdLXS3hOn8+iSdsCUvI+FPLSRKJw3szGw5DnlynbCZ81rAiSOjRa4OTuX4f5?=
 =?us-ascii?Q?9yLW0aNR6YVaipmhQ6IZTKqSAmaMOiJu6vRsQxxDvvrec3Kw53DWEvA7jVYc?=
 =?us-ascii?Q?IX+i0ebyx9Zjgs4lsos+5PUeehVh0K/V8KXOhQOHVaKBcJdrvfmc3K0XJsdE?=
 =?us-ascii?Q?TOztAPFW3QCevNX9Y8NFCvk1o8gYTDB+y/Mkh/p3Aw4E4wqfQ5p7zVcVukqU?=
 =?us-ascii?Q?Ro6jopZWHSmywpdx9+YWDkOZJCVx5HvfyhS1LsdDHMiWgXNq78BD22MLAmHh?=
 =?us-ascii?Q?gw6eFTuPdpiaJgpNCMqnwjy/F3tD8NnLTnjmH2IIr0HGzllHGefLNM+ULA+o?=
 =?us-ascii?Q?ndv3g6C2xeQCVeu1e3xcZZPnMy0UTfk4BNA1JBulp8hR6RSG0Rhv9t+yZ60J?=
 =?us-ascii?Q?EePZyifjwNSIupzHg37DUt2nGaQUFoYue7Hu+XwvpAOmNKYEhnKIEtHbJrrg?=
 =?us-ascii?Q?ltDuznQoIFuC6iz/zs/ium4+ohs6HEuE4b7gY1F/6yT703aRij4Ppw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pMxB7leogKQZ6Xix8nmhRUZ0mvemMNfBAMg/9RZYigBJr+LKGa4DfQBBm+8m?=
 =?us-ascii?Q?Oadg+IWcxmOl2rs7ajakOeOGEIwhxA8w859vbjFce1ptuSEwV44APRIAsYBO?=
 =?us-ascii?Q?RaWrR5G0sGivMejXuPTaV2jnBw8l8ya2f3NNDUZJE4YjdbheWDzIqsXeYLQz?=
 =?us-ascii?Q?kfOCojvFoYw56QiUVOtvbeBaLX86Zusa1IDaqP+J1RjCfyCcQgLfkGWJRrT7?=
 =?us-ascii?Q?2nOKqHgdO7qw8aJQIIhlBsbpsoKC+oUPkVkD1OecDhdbjv5glXGcVMX1k17t?=
 =?us-ascii?Q?lXR6u6hUeu4Q7sVYA89CQwyAwdJ+OlS1OJ5Gfm5z5t1G8B9cXZs/QSxzZYA3?=
 =?us-ascii?Q?EkqBc6s3vaTOjS8viiFJ+Pt/ETbH7IOvQo8kRLJXctICYdvfR3e3nNvbYP1G?=
 =?us-ascii?Q?/bVFOi0cZmAT3dWOAzpuz8hA4chCq3XUPkpb2sRg3s+hQM3W14C6JNjfZkkr?=
 =?us-ascii?Q?JMxHaviNguTLlv0mOn6FsTJQ9A9IuA4QX8L+OVVxNckFUvMNLX2BQQ4taP92?=
 =?us-ascii?Q?PwI/cCE2QwBgwEFs04LL2QfbJiOQDUhWmYzZySFfAtOH2WVd9VEKbLKfNSPz?=
 =?us-ascii?Q?b1WwZCnDNgS01ZLaAItGfreKp5rWKsE98pqq166SkwRikpS9e3/Z2FjoAlyP?=
 =?us-ascii?Q?GQyQoeBS5h3v4NME3Y/UM613p3cMmWsJs4V2cah7uCxB5A/r5+/9eHs8UthJ?=
 =?us-ascii?Q?drSIxCh4UlUuda0Ya5mnhmiInCVgNGdhyASTMkGXc1xOavZcsPhM9D+/MRTs?=
 =?us-ascii?Q?rSdd6HYmaUdOB+pm9Vy/OFL0JCmUuGtveWDzkOQgGctQIVoq/9JksyXSw1uf?=
 =?us-ascii?Q?RdjgcF3Lr/4YUD5/l8vrANI6shxEbTfakJ9IX0/N5Oygh4RqwVKS0ix4no4h?=
 =?us-ascii?Q?uE5M7J9hOY4dRrDa5EImGGxj7VuYMOJkscg3sX+yJPShtVjpN/bgCtYDtNyl?=
 =?us-ascii?Q?9cMQVQ4mCxTVjtiogkcWl/ZEYvIlcBB141BlcstgkyqGCX8js1PFbJJc8h4v?=
 =?us-ascii?Q?S+qDxPjybcrw/VJcpligFVnzfjkoeLvr56qLo3n4uYkPszQVC/4geLGLMK7C?=
 =?us-ascii?Q?geigwfCyXsO4z2flQUXugi6lYaFgI8rKVIkxCE5GNr4/Hci2ZzWaACoKF+BZ?=
 =?us-ascii?Q?P09v0B6l9Jy0AFKkGPINNcKX7GCfL+51L3ZK2VweWRLapF1N46jPpB4k0pW/?=
 =?us-ascii?Q?aJYx8cuX6Gpe6ogVFq5/ANcWmqrVEhKwWBjavq+Cl9i5gBJ/zsc4yg2bm82j?=
 =?us-ascii?Q?ke2qR82UxoqPnpxW71QEht/S1a7kzJCE67PLdzI85usGGv36c2F5kusigbLC?=
 =?us-ascii?Q?6NY7rY79dm0AkbykZgfdZXigO5Hj2wjAA1AC+k2NQlyNulY/EuKrIzbR4GZT?=
 =?us-ascii?Q?MOa52TaGXsX08eUFz5WgNJn4H/u9g2Hc/p+RobDsmimbFVlyZohPVTFTob7o?=
 =?us-ascii?Q?5lz7AFzPYuiCDpNufrMI0WsAgaWgzk47wAXk8We62lXJjeR07S5csk+BsCQs?=
 =?us-ascii?Q?DecAgjiwpxUiaTxzxzagejojxZqdP3NNEUz3T+mrHTYP26m3JB5HMPhjw2zB?=
 =?us-ascii?Q?MmMJN7Vmm+3yYzXldnS9aBAZK71zPG6NHkQZ+nbcYYjJY3gyZu6Cf3HU8syF?=
 =?us-ascii?Q?//Yx30Yx1BobgFimV8ZbXC8to4YUjvzhyXulJyX/UIImfaynyWvsqd+VUWsB?=
 =?us-ascii?Q?2NMA9znTAe1FTxuQ7ps9gD7y8yEHJ2Qe5vSfSKcYfSgAVhn2kRlVXCO/sQR8?=
 =?us-ascii?Q?G2XfG7gA8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xpFb9/g9g6l0eKtxt2jg9fH0TgeofCSQ6AZqekHH4uQmU/W7B/gA8pJoxuFBNx/HyS4qvGBCi7beQbweMlBBWCnZJgjQFFa2Oe2jI49MFNqIFlPk7pOLK0UyxdNBH9aPNboUk29XWhPzftB9J8bDRgVo4XQP75TByZtAJo8P26WHZTOVMDPKv85hAjp9Whrw6BFtNUjGPzDmTu+eobg9h7N5ddyDobwMHKmr7CEt2A79Mopg+D7Rm33cDSXwlBEj4XYxtlj8OweS0hzcLivo3jUepbPiGCabEwLS7vXJ//Kt3nw5kWM2RT6ugrd6ldt/TBUKr8E4SPXpmBhTCpd+V/XW9JKPW36AY5pM/9vjGhpQuH+lLy2B7t5WbcKs+99rA4SCIKpQpxXXlB72p3A9r2VEDhfrwC/BqgCkxKGEnenkHTlqEhi7I12QQpmuqbvmQBw0wVGTLr1AWK+G2DMOu/+irMa6i9AOnDQ4QJIiD/q72ERtT5kQTEK+h1O9WiINbLBfgRW2aFL8McAcKiFvVOlhbpWZ5Gh1YJuHRJSeHRiGBV/d1uRD3SDd9ZW4UnChWk77PN0TynjyN8pMNEpZFfeh8/OL+SiY6Jt8yaQwQN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47129f52-4e48-4f43-5272-08de529fb8ee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 12:31:49.2643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUuNnOLyGXhC1QWjNppGNLbyew/n4f3E2eiTdT6B6kKzwXdlet1LjeCSWY9eCoDKt5pZJ9gD776pVGI96WvJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601130106
X-Proofpoint-ORIG-GUID: pOiVX1y0KkwRSjYWbEQ6KftRL9maWi8q
X-Proofpoint-GUID: pOiVX1y0KkwRSjYWbEQ6KftRL9maWi8q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEwNiBTYWx0ZWRfX9sIVvPjpgPXy
 utVQqDhnswP2qh/w9dJF2HS+39KfImZZopqbOBqHsMntSka+7WPeN2aQwpqEeKqFDmGQwFiW8kz
 W9Qd8raAtftoH/FiVHojC2xvYq6f8lHWeJGmOUnHmoSeFLU4Q+UtKMX8nTVhNUjASeugU2CM8j0
 sAq4RBJYPg3ID2F8bBTEMOwkPLma7WvAW3XcDadpYwHm+MAl9rS5MxsYL1hnSO8O8AKZHETX+an
 9+ayuDCHu0x5aKByzIZFRZlsTDPseo88mw61Jt6GZaASrpL5wzT0Z9/jn0f60Rw36aBkkjAeng9
 L8xgsY5LsSZl1iny0bBFzgtN5STgykrDkiaZyrpObCdnGhzJK8dy+rUdksnv8iTEzVlwbL8cfqZ
 KdniLeokffvPA//qrv6Op/vlxeewitz/my6tkxz9u8M9eVdVevtA1jfB4U85jcCm5YoGtGjyMYb
 FsmU2G/4aYmypuJ9zBA==
X-Authority-Analysis: v=2.4 cv=QIllhwLL c=1 sm=1 tr=0 ts=69663b3a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=ugPSupLTDk3cdBQUXpEA:9 a=CjuIK1q_8ugA:10

On Tue, Jan 13, 2026 at 10:32:33AM +0100, Vlastimil Babka wrote:
> On 1/13/26 3:08 AM, Harry Yoo wrote:
> > On Mon, Jan 12, 2026 at 04:16:55PM +0100, Vlastimil Babka wrote:
> >> After we submit the rcu_free sheaves to call_rcu() we need to make sure
> >> the rcu callbacks complete. kvfree_rcu_barrier() does that via
> >> flush_all_rcu_sheaves() but kvfree_rcu_barrier_on_cache() doesn't. Fix
> >> that.
> > 
> > Oops, my bad.
> > 
> >> Reported-by: kernel test robot <oliver.sang@intel.com>
> >> Closes: https://lore.kernel.org/oe-lkp/202601121442.c530bed3-lkp@intel.com
> >> Fixes: 0f35040de593 ("mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> > 
> > The fix looks good to me, but I wonder why
> > `if (s->sheaf_capacity) rcu_barrier();` in __kmem_cache_shutdown()
> > didn't prevent the bug from happening?
> 
> Hmm good point, didn't notice it's there.
> 
> I think it doesn't help because it happens only after
> flush_all_cpus_locked(). And the callback from rcu_free_sheaf_nobarn()
> will do sheaf_flush_unused() and end up installing the cpu slab again.

I thought about it a little bit more...

It's not because a cpu slab was installed again (for list_slab_objects()
to be called on a slab, it must be on n->partial list), but because
flush_slab() cannot handle concurrent frees to the cpu slab.

CPU X                                CPU Y

- flush_slab() reads
  c->freelist
                                     rcu_free_sheaf_nobarn()
				     ->sheaf_flush_unused()
				     ->__kmem_cache_free_bulk()
				     ->do_slab_free()
				       -> sees slab == c->slab
				       -> frees to c->freelist
- c->slab = NULL,
  c->freelist = NULL
- call deactivate_slab()
  ^ the object freed by sheaf_flush_unused() is leaked,
    thus slab->inuse != 0

That said, flush_slab() works fine only when it is guaranteed that
there will be no concurrent frees to the cpu slab (acquiring local_lock
in flush_slab() doesn't help because free fastpath doesn't take it)

calling rcu_barrier() before flush_all_cpus_locked() ensures
there will be no concurrent frees.

A side question; I'm not sure how __kmem_cache_shrink(),
validate_slab_cache(), cpu_partial_store() are supposed to work
correctly? They call flush_all() without guaranteeing there will be
no concurrent frees to the cpu slab.

...probably doesn't matter after sheaves-for-all :)

> Because the bot flagged commit "slab: add sheaves to most caches" where
> cpu slabs still exist. It's thus possible that with the full series, the
> bug is gone. But we should prevent it upfront anyway.

> The rcu_barrier() in __kmem_cache_shutdown() however is probably
> unnecessary then and we can remove it, right?

Agreed. As it's called (after flushing rcu sheaves) in
kvfree_rcu_barrier_on_cache(), it's not necessary in
__kmem_cache_shutdown().

> >>  mm/slab_common.c | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index eed7ea556cb1..ee994ec7f251 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -2133,8 +2133,11 @@ EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
> >>   */
> >>  void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
> >>  {
> >> -	if (s->cpu_sheaves)
> >> +	if (s->cpu_sheaves) {
> >>  		flush_rcu_sheaves_on_cache(s);
> >> +		rcu_barrier();
> >> +	}
> >> +
> >>  	/*
> >>  	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
> >>  	 * on a specific slab cache.

-- 
Cheers,
Harry / Hyeonggon

