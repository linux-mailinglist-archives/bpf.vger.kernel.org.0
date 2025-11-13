Return-Path: <bpf+bounces-74340-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D769EC555E9
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 03:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82243B794E
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 01:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516829ACDB;
	Thu, 13 Nov 2025 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I5abqi5J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0QC7Kxbk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478D13AF2;
	Thu, 13 Nov 2025 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998806; cv=fail; b=crjI1odfnGW5fOlc943cFcT4o2atnoShx+MDHiiABDdoXLXeoR2EfaSTFlHV72FNF667GnM20wJtvLHGi68YhkFQkF0B0xhXOMuzAPH8aZMQ30nV6G7ZowiaYGqda9hTH6D/A4ptBBvQDa53/7+zzMTLRRAelcAB9SahAouAIHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998806; c=relaxed/simple;
	bh=hkoQIWDoBF2WYvOnT/uMDWgv6ku2Y8yktlSbklRnUCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OQb0t9kd7ZHQOJHifzIcsR6+H75yOkzUhC5mBhPrMxWTkZBrOMzppuQjBXKWeADkH0Z147cvio+qXWrVcfj+OZfocU0XaxUqdIC/9wnhkULUr1TcMFi7JBfO/TD1bWFAYldceIa9YxogR7CA0xEjGCX8+akQtlapiw81gMwT7Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I5abqi5J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0QC7Kxbk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gEhK015601;
	Thu, 13 Nov 2025 01:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=3AiENayf1udk3Xzjkg
	esxjjv6rBUH6zUzqjaLghkc7o=; b=I5abqi5JY2QsjjZBbGfD38emnDvjAatoRk
	1Zy2xrsAAUOS1B8CyFNScn8d//fRmMHqWXC+uC/Qnk0+xRvLMwijo8HsLuwKWcKt
	vl3RBbYicWb9r9XufxavL/PKeOtr9ZSlhnqWTp2VtO+/UTiK1RN1ytKgaSNZe2D8
	qVYWGiDqbbFtxjXVH7dsmlXbquAc6FqXtbqwm+enBZ+9GhBKxMdJJ9786PtU//yC
	r95s6jnaG2R25nv4okqK4sg/8GzniLPypWJXBCtp2XPL38JhoP8PBGSxrF50TP7d
	k+ck38rrOGKUgaa66+u29IsO7NSRWHEFwi0l/cuFtn+G6KYISYig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acxfvgvey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 01:53:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD0SYic029360;
	Thu, 13 Nov 2025 01:53:09 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vafhqsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 01:53:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM6eA7lgV87uhON/H/Di9Wi/ZHcO9W+fw2iQNOcadSFp7BclyMPes5T9/uZ38TwE/Sw6Jzw1PYqJBPiN7M0ucfifAFEGxe0xkiGbdiLLvvmkKXu4ZLTPcEtE7AidaGB1+x3pptFKTdEI61qQ5G2AdpG69mjIZpzKgLhhfF8voKw/bZjcaywWT3BOvvkwtTQpErsTXLjKgmLCiXNj9Y3nkWIbXKiREyQ1wjm0o1XeCL5GAc+E7VA2gVOec+pq3u+Bf1MqnYZQ31JEpXEqwlIanwTsK3PFNMhOAa1NDlbMZzhe+yKLrLbWQqw6kuGyVf4e76JmiaZeTcT+gk3np+57gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AiENayf1udk3Xzjkgesxjjv6rBUH6zUzqjaLghkc7o=;
 b=wFse1hGXxwpCUfOkvdUn35P2J+36ZUT2szvPCLsJMXZANQPAeQczinXSLPDNORDZwi8WlIL3PxsyUFMEMqpTjDOejQLUk8MqwRp5+O7+43N+EwLArcTkGTlnORbpdCPQYVR3KrqkhEX8rvhClN9oIHMs9U9I3MyED3mkflY5hj6Zj6KRIb8ky6IDHTAbEMJispMa3azlU3xDgeOtPk7teY52q4D5ElWbwlqG4K4xyRsdrAf1jzzrVAd5O/40BUfMSZtPub/t5raK446ToWLu7ZlIkuXPqr8k6qUkbtTb6hqAYI2Z0maoHugbN7kix35JOewGXr3HNecIBTraHJKYSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AiENayf1udk3Xzjkgesxjjv6rBUH6zUzqjaLghkc7o=;
 b=0QC7Kxbketjv7qj7EEGgt3ChqaoMxCq7TLZ038c7tKdOgBUwUNOfAuisbE/u+TCccdRwvPi72shdT3WdVIy8Dm3bMWaoyWBaj9pqfGXzwsGJqHZu84eyLTv+MGW2xVEZcNd9x9d1d8INqVB2opdnt/210MPz5kt7OTFOg6Xcp50=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ2PR10MB7081.namprd10.prod.outlook.com (2603:10b6:a03:4d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 01:53:04 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 01:53:04 +0000
Date: Thu, 13 Nov 2025 10:52:55 +0900
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 4/5] slub: remove CONFIG_SLUB_TINY specific code paths
Message-ID: <aRU59y8i7fICC29T@hyeyoo>
References: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
 <20251105-sheaves-cleanups-v1-4-b8218e1ac7ef@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-sheaves-cleanups-v1-4-b8218e1ac7ef@suse.cz>
X-ClientProxiedBy: SL2P216CA0154.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ2PR10MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b08bb1-5b49-43e7-210a-08de2257621c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QwXF4dFSirJocmEFgq75iCk8jACCk+1g+RN0jjSE+wiGUzo6hXlVyUz6hMpD?=
 =?us-ascii?Q?wYqEdtB8kP6d0EeocdQw0UosBqm9uWz9tbiZaDyZ4qnqV7slwh/O99QWuCEa?=
 =?us-ascii?Q?kdUCyIBGMHd0lhV05mLPEnwbrIk9SnTtraerpvuBexyteIGN87e5ZV6KQYAw?=
 =?us-ascii?Q?Kf23yWMVho3q5IOWV17EcWg0kd1YFEs2LLTXsd7CVbisqa3gS1KpTzCnF5sD?=
 =?us-ascii?Q?wJaGRx2qUQteIB7bb5hjfvTwOEhtkcdpfgabc7ZaYFaLZFDafztxPVLGHgzm?=
 =?us-ascii?Q?D7sAqArHssYsIyNdV0bic3ejRWG5cRGzlgZ+IW7vjbXGo8pwS8DKvJ6qKma8?=
 =?us-ascii?Q?/cghXTHwYLZ0INrNO5oLLXVJGeecSgZJoqN0nPGBPaq6knCPt3deIX7UmQ0L?=
 =?us-ascii?Q?zEhoXlefDcYhrc949xDNa2lsNmXXv0abCbA8uQDqLr3PnEXWpvj9npOUBKMG?=
 =?us-ascii?Q?OL4Smh0D0G83Ls+sNRXnXTmMNqanoenf3UBKT8xmJXs64Y6k5jq91NS59r6S?=
 =?us-ascii?Q?dtjB+xyOvxS/PSOHELLL0q1pUKBC7f2jb//8QQr2EN2/Q3NLaE8VWz6+jzgJ?=
 =?us-ascii?Q?zaB+6Qsm/j1IX8pr34XMyWMe9VFzNsC4KTykcJDuZGRAvcbiGbqV6OReOK80?=
 =?us-ascii?Q?rqRQWM03+HNtJFpYcxSyLEjTylTv7XmxT4iFQN32rN74QLWO8S9sIgfsTGXo?=
 =?us-ascii?Q?aZm0OmUWKq3fIlbL9JVvcskl59Tam9j0AX3CUyWm+qj2IAKDA06DNUWKat0p?=
 =?us-ascii?Q?BzM5UIImfDCyTor+cu5RO0JagpluFvupYnxHhAgjs5bYCh9UIAgw4IW6A87e?=
 =?us-ascii?Q?k+SfkAaYhIZps5c0cPjQTIwnw9G+vaTyTRIn7vweL53+QlBRgiNzmtMvwCXj?=
 =?us-ascii?Q?XTbzo0xl4mtFlEfj/U00J/sSZYxWsfyseSueHDDw/nAxLs9/wEodLppdT7Ik?=
 =?us-ascii?Q?4w4uvlSdGiN5+oHzcMrjuSBVrz8xxZRc7GlRjJEfrTX4Ui1hfzKiJl4/hA/X?=
 =?us-ascii?Q?V7c5b2mnCrbK6FIFThQ388kDQWq7jPWKhp/7ThfjNtmIGl99OaCIakLrRmNm?=
 =?us-ascii?Q?c2WJxszJEgKjyJstkIJlPCw4RlPmHGMjfov/JZYKZxWGAK5YPugNwd3Pe5C8?=
 =?us-ascii?Q?kX5ln2z3816h4eDQwyC6gB0eMwbtcqI8rgbnR8pwkxv9CyYIpGHAMqR3W8es?=
 =?us-ascii?Q?mjvKtiy04AuTNYAU5jvmXUiFc3XuxXOOHnzZwNC33uP5zUOFFP8bgQbOF9SE?=
 =?us-ascii?Q?jEZKcBSuceDrzPZwhnP4jrEhVTua8VWkIF+H1sfDD2OpEGIo+fOHUSAUsIRf?=
 =?us-ascii?Q?9f3hsMHEg+Bg+VM/1c39Z9nyXqKc+vwcGo0JwZ7v/4fnLV0snHn9es3s4JGE?=
 =?us-ascii?Q?jJNcyXMAGXACyy+sbXHaBYSKK1EED3ijJIXvjgGddSXn8AL+00lJ6TCA8nbn?=
 =?us-ascii?Q?ihIkLBLnVgVOwq3m6LwmCfxKvRkaU26B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I2BLNr2I9hX4ESlij7VvkXqzJ6yACJyNnVFVmVHfMlogGYW4EeTHXxgKrzjT?=
 =?us-ascii?Q?ZlprUpJbYlkHJlsTZXT5XVgMYYMe1gendf22HEOTWCen32egV4hD9iDwkNt6?=
 =?us-ascii?Q?kQB2qSg+q1lsYIpSKcBTfA9BqfZ+Oy6LXKFaySz+yuvUhtp3JsCa7SFSsAh9?=
 =?us-ascii?Q?/NLksFIMIv4im58e5iOvXulbYmn68+Tj3JXeC886A0zubhpe+B8f12F0sHSr?=
 =?us-ascii?Q?+W+T75YtKP7kJ64IsobUspVAW1BJTaEYWGn1Sfo/k5rxcq9RNg6CH4IriOgQ?=
 =?us-ascii?Q?ZutUGd4ONiIuYiJ8QLcwViUWjelMb8otdFn2OsNrrSI8Rm7vMXHJAXoXTJGK?=
 =?us-ascii?Q?P7UcbOFkkFG53k8pMU5GUs5CJjSVyC8ixgLCPXIeUC7MonK6WFlzOUsAJ0M4?=
 =?us-ascii?Q?Umhh2hfzfn9lBLfUNRJcVZ0dVbSEERxREZnhSIhv642k5UHmQKkIgDvm7R7F?=
 =?us-ascii?Q?gJmXukUV0e5Ww03v7XFj9ZIsL7HUVSrbZOVGQKckkRnqtmbZTq/pZaH+HZ23?=
 =?us-ascii?Q?VMOONecyx3xit5TGL1jWXj7p1lPoRoEqJ+SKyOKAEKQ9TD82zyrkvNIbJGng?=
 =?us-ascii?Q?Tl45fwtkUVw1IC9ZonRFnSg3GR0WxA5I0BL8MgFng+mfbKpvSWFD5YgvwXqe?=
 =?us-ascii?Q?/0QlTrgbiMoMcQXE1HXVqEHSztnDEQpZ+pq15szbcZoShs/Vehye7P5usJhN?=
 =?us-ascii?Q?nNYTQ/iwhHgwHpzaWHG9/rAff2rNobls0Nv4Z/iXxSnKFpt+g/mJrU5bKOjA?=
 =?us-ascii?Q?gFm2Tc2vn21rjhdrzQmUk0NXSqBfp+IOxiovccpL9tT7ehoL+K3w57riy65Q?=
 =?us-ascii?Q?o3LM7r3KgjwaH20QVv7kZSz1aEEushJz84l0fVorfirwefzDf5JECcG+SEtX?=
 =?us-ascii?Q?fs1F4vwJR8tmA1BEFSy+B8CEURLZrTEgAcDXbPci7/10HqT6qbA5KMPIedpO?=
 =?us-ascii?Q?SpQqcNj5UwRL2SiI9DPxypQ8F0BWRA64SLNJcLnmHruZlLXdJN/JH6ORAthh?=
 =?us-ascii?Q?+6Gn6DHYz/YJQwmaVh9poi8vxz2Q4+Zuuu9HsmvLThc5Av1tiqinUIrbdukO?=
 =?us-ascii?Q?JaQ/Cm6lVuzgVd225i14r1b6pHAbv2v91JnjD9Q6MyJdYkWf9amHehqmWL4+?=
 =?us-ascii?Q?Q6TulZyg4lTTXuVUFOUIdiCMSBjeLN2yXpoxRbi3z6fQ4AwFXuXNEo1omoHC?=
 =?us-ascii?Q?zSOFNjnm/OBZDiCBJzCkoiro+GhQTEL/1mhkXLjFShLipLBbEgoeamjNxa96?=
 =?us-ascii?Q?CmmOIOQ9cFVB7rmdxC4vCAPD226vB8X26oZsUPniTqCnntulr+yhqH5h1m1i?=
 =?us-ascii?Q?ZsS0N7/9QtSCu7rn2Dv/9m7UUAW5ONu8YnSwDCAifOeMU/b2c8/zk0W7bu0h?=
 =?us-ascii?Q?DWu6DEq/avWryDIWuNKTpt5Z9YRbU/C6qpihApT/a2G1OGeaxvEiYmVL3mxW?=
 =?us-ascii?Q?RwJmrsj2ripvLcX4IlJiXOXqCV5naoA8vf3hyZwZLyiQDhhFhF84ZOM3yBps?=
 =?us-ascii?Q?Avfgvt6NliYnjzaHghfRQEaElXYgLtIaoUGkotpVWGxM0OQnODRix5cRsoCZ?=
 =?us-ascii?Q?7yUfgAfEcXCdmNKXQDQQnH0rJMh21Kny7ygbZYzL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WLljFfQzqejpbqaiIAEsFR6U7+Q1OqI8orLhv2dbTysfIUVZo1tS/LBtDN3Vuxscu0gxL6kMj5UNW9a4+XDezqgOFXVtxwHz7if9xFL2YdhoZWWV/edxUWwdmkr6XD43tHOuLT5C+doLbW4cxiPna4JbFfB+AEPrsvnpueSOz1CBH0VkMgEw1qN68e0rxNwiFxPthOWNy0kca5dpc85tp+iVciwud1vE03utIsqE41Z1EpdzPIvUBWNhrO6nd/3gIluO4NY40bblxncZYgxS2Fwn1VqkoxmUg0Py4t0paBJt1QUNYg/+6NlMmNqptF80HULaHUo+9hAZ6gtp1V2cV+Y6hEtQpkzuPOLxYPWGiO7MaoDinFNrpyuUIzuYAZpITqrzjTxg7Kj4l6dEdI0mK/FmZXd8CwhSogz2bKjq7carGHAlcMCH7V93ZVzCVTpHpRJhEA1TAAz0tbpkjpZvmoZH+rPFAtrlN3uEX0nPTRzW0Q4SMIud9dNBMUREhzRFto+ckLlG2fbEMWGoxGExZFT37HaygNNlQOz+qr0ZCz4aNF+IO3XUPhnnikI2oCaQxevactVMUtxcBTfe5cfKsay9dA9UeYYaMQIWv8kn7pc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b08bb1-5b49-43e7-210a-08de2257621c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 01:53:03.9367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ix60AzQFMSk8Iq3yUgYfdiqKu8yQQstj6+R0nhGa+JLvK9C3QTocoAVkfkGkqL3+uhEC0LVLnDIS3jxQUTSnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=824 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130010
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEzOSBTYWx0ZWRfX2wln66Y6uJIp
 r+cL8ixMrqVzdVrG2iqaneOTz8bF7eaiClcXVY2t62awAS5FWPBKTftHQYmMxoTZ+usPFGvfeRt
 gXA9Rm3ecyqWamkS3VN0rYqjd505uqPVbUXhP4gCC06sxIbGjIjFK4Ie7n4AbuDhtE9trfbHlVs
 T7kVixqibelISTO1iUK6/eIiOOd+SdN9L5N6CmO8vueMYoUFUMWUfZPSphRmo7hynaTsbhTamHf
 dAKxyuJiL7+cwX9XzRk19oypBLBiYeMUugm3LId4aJWZ1o1CB4Jji6JycCMqtHZQcZKNFeHU2/B
 817HteACFNK3KxJ4FvIPeaq/DiZzykf4vp2ss+JBVsSeF/3qCPhiavvQcPFao0G6CjRWqMM5w5d
 ZP1Iiy5hRKl3wtodvz98ToBi4Lh1rKtT1GA4uOOihR2Ze5fWBpc=
X-Proofpoint-ORIG-GUID: tBRMFoVuGmSDXM_nv4EAIBk_A_UddLh5
X-Proofpoint-GUID: tBRMFoVuGmSDXM_nv4EAIBk_A_UddLh5
X-Authority-Analysis: v=2.4 cv=FKYWBuos c=1 sm=1 tr=0 ts=69153a06 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=8ol0XHITZdbz7p4FxSsA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13634

On Wed, Nov 05, 2025 at 10:05:32AM +0100, Vlastimil Babka wrote:
> CONFIG_SLUB_TINY minimizes the SLUB's memory overhead in multiple ways,
> mainly by avoiding percpu caching of slabs and objects. It also reduces
> code size by replacing some code paths with simplified ones through
> ifdefs, but the benefits of that are smaller and would complicate the
> upcoming changes.
> 
> Thus remove these code paths and associated ifdefs and simplify the code
> base.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon

