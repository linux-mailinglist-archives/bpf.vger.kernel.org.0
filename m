Return-Path: <bpf+bounces-66768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E362FB39137
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 03:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92703464A24
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 01:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6723F40C;
	Thu, 28 Aug 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fB0w5ZSR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JufqQwDs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D913AD38;
	Thu, 28 Aug 2025 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756345630; cv=fail; b=jjMutRBIzvLqQdLhJ1lwpeC3IOkCfIR7CaWu1ATz69tfiAUEMKpgdr6LCfyi9JAaYAkGavfgPTOGhiiEgtOSsKZ9dncgI2T/FnjRxIcy6yICMr3bzcYX0piFMY3FZ6Poe/TlzGD0pv4gHuAu2StkkH2HCF7xTzVP2mAYmB9uKiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756345630; c=relaxed/simple;
	bh=0OLqJEExTv34M/+DBefsloPXebkuBKsZoHjKD7pa840=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lVvAGxWMMYG9WEfGGtHcg8jzaZX+18eqIFN5iGU6uvLtI0AQ/xwo7d4AWNiXE9Wk1IWCRhGhlqvWBmVsyu1jeZe4FkmVyFCsH0mZ/QJSc+PDJDnTDssl8zNnoqXysGbrOBfOfkJGBqa1d5eUXuyzLumUdrIIeej95udFlIijfeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fB0w5ZSR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JufqQwDs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RLHGit023330;
	Thu, 28 Aug 2025 01:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Cq24te4UoCeau88U+F
	A8ooUqn5bJapRRhAvAEeoxzis=; b=fB0w5ZSR5yJczxOMeCLu0Xb6j6SJhVOqG0
	YsyTBfYA6xM6BOadTRyYPw35cvtfrimhB4DTrdjKbPZm3xmn+6NBPLavxkUARgDi
	/zAJhk+Ibkv2aTB31uBXwSB4Bzpx5yBl5K96QY64PKT+tZS1wFLUE4KAofEAwAUk
	lHvUaVMxvDdPdCKwuQzxSYBtocK6fCLjVJyAfos8jb5cVzfZrMUAILJzFLnl46vL
	Z8VeVgyQJUddjF56i8CovJhUfJMxIPjV1ad/1P2oENXZHR73E1TxyQOPonnhSDY7
	vdcu8kaOorR1Mu7U0K7+xjgPSWmcSpPmWRrUuZkz8R4XNzsDH5Mg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s7jmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 01:46:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RNZ60D012229;
	Thu, 28 Aug 2025 01:46:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43b960e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 01:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfzMEgTlKJOm/HWOevX2wCXRhsQb+AEPC7KjwxJ4CgiqDi0FhBeivMwUQbMVNkTgSruiyFEBa/HK6/Y3yz3KzQFAOOVyDOIPsXWWE2t3BXGn0tqHXNv4onM+hCej234BQj128QNDIGda+pWK+BVKI21d65UwAgo2m0RUew3SLmMTIntNVPopLYz827WnKgxR5a8V+fk2sQ2dgCJoheN0TUi+WmCKasU6jN9k1aS+ksrUuAn4VKJMgXjtanqHP/yaAEY5/Sd+10ZXOXMxwQO9T7JyBWqbafchhwOAcvRcK7d+/ZzU74Bu1QGFXaVwJNv6qCnxY2CMVMudt8BFJhzhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq24te4UoCeau88U+FA8ooUqn5bJapRRhAvAEeoxzis=;
 b=nfm4SXh2FFVF8FRSif1652lEYtjvqWuHcTHmXK8lNZ0UGaIPHH6hWLa9cx7XErdWXXP//rBZ+HVg7pmT9Pz+MJL6lxiJet0uW5qWwgRfU2RSHsClEai9wbqKrXCtFsAEfIQMUtHF8gQEA9l89EnfDueYhMmc1uUIxHGSjfRDPuNBbfnUOsIqCEbh9rpZcYc6treaBN5FTDIkj+dFe8Anq5Wv1tMNTlV2Xlw0Y4qQ6lco6n5tjdp5RveN+QBrZImwbf41IJe866ng2Y5XAIb8nx9UT47rivQo/9X27NUG4CkCP34HDouvaPV57lFg7PIIwuqrg8hoDZVnAu14QmHmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq24te4UoCeau88U+FA8ooUqn5bJapRRhAvAEeoxzis=;
 b=JufqQwDsfHmHQzHKvLJD5mhcqFQKGXa86kc3kgyZJzCr2/VPAK51CO5aiojrXgMY87/KceCSUW1su3hnLEbLZFxXGjHTYfQDswhLhG2vsJfEa9AAABbtyVeHo3Z2i5Ef4b21XogCAmTguCZ0n5R4lDfBqZQhVbkZc/t5xxaOASg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA2PR10MB4522.namprd10.prod.outlook.com (2603:10b6:806:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Thu, 28 Aug
 2025 01:46:07 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 01:46:07 +0000
Date: Wed, 27 Aug 2025 21:46:01 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>,
        Kees Cook <kees@kernel.org>, Carlos O'Donell <codonell@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH v10 02/11] unwind_user/sframe: Store sframe section data
 in per-mm maple tree
Message-ID: <el6nfiplc3pitfief24cbcsd4dhvrp5hxwoz3dzccb5kilcogq@qv4pqrzekkfw>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, 
	Carlos O'Donell <codonell@redhat.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
References: <20250827201548.448472904@kernel.org>
 <20250827202440.444464744@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827202440.444464744@kernel.org>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::25) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA2PR10MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: 9494e372-31a1-4a69-dd7b-08dde5d4a80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j+Ppgur6mp84wzjY5mAzWdFePjQ+gElArDIu5dIoRC5VYUXUFpWGDrYv1WHi?=
 =?us-ascii?Q?sDeUMSbRL47AEeiqAlHYgxCQjyp3utJ6igm6Y0pmubMVlKUJCrXlJE00jej4?=
 =?us-ascii?Q?57dli/95dd9PKLtbmr0ggBzfGckohWPTXe5lgV83Xtid3x3KGT+kXdnI1rhu?=
 =?us-ascii?Q?bR5GG3dESIe9wsKizwEm0NNdz5w7Y9dvT6W80GFukj9Sfzvu4ZTDOb73AnXq?=
 =?us-ascii?Q?cJEbJzmYo0APhWWFjRlZhXHLAqDjEOlAaSBFrp31Q7WRKAHOR1measdoCw7Q?=
 =?us-ascii?Q?Q3hJh+fE0UptR3PNDJMVdyy5PJY+lqrIfSxIpdnO9ooFLZcit35+NM29F0Xt?=
 =?us-ascii?Q?7qKwDVMV2FGOk4fbTS0XXVpgfk3FeTUSbpYzQz2B9yrdlAEOUmVyI+IJQVLA?=
 =?us-ascii?Q?rUfhkS90Izy3cuGXdgZXQ/+RhT3qfW9kjRtPOfkV65fu8cOZeNhrnU1n7RRw?=
 =?us-ascii?Q?zPIA3X6eU0kBgi9fRK1GVufjxfLwoGqAuIHTttQnMWNaxj/XWOxrY4hLPAql?=
 =?us-ascii?Q?/7v/x/xGkoKHRdzwwC1ZsQSpseYY8ly46MKPIZr5ytEVG/MORwXjZmbdmV6d?=
 =?us-ascii?Q?SxIiX3MqaFnSZVE7yQE7C0B/OCxCgvANntZ7exaAWyZPNRo0+4fSmhowQW3K?=
 =?us-ascii?Q?enHq6uph2EPcvOkb7BYkDvRN5u3aQjCN6hdJPTpqXWa5J/UtjKzHhoSE0G/S?=
 =?us-ascii?Q?XOv6hJHMr+nGYDFeIAhhCwwBen0ZKXecrvZV7cNXKC1d525eBZcXFBEbgLUN?=
 =?us-ascii?Q?QdrKijyQ+OFOFAwDpcE6ox8laGUpe46IHLw3d/Q1HhcQztCgvmzg0e2yXhx/?=
 =?us-ascii?Q?XEBJJp0WldrNi0k3IbbwFcPY5KFUDGjBRK0qYSCDT/pO4vOaIOAz8eVQhwC0?=
 =?us-ascii?Q?CTgseJCogsOB0n9vm0K5ITvWYSL7rG1G28CGevB3Ea9dEK0Zr4wyvEMYYn+Y?=
 =?us-ascii?Q?TsDh9kRJsgMgSQ9Avq8ggJCbYKNA2b8NOUA+Wukc02mUNI1B83TezoGkkFBf?=
 =?us-ascii?Q?5Fw+vn5luFR9qLYO96IA+w7LrtJij16Gs7hhYa9WT/H5cVntEmXKvsJ+Hrbu?=
 =?us-ascii?Q?CeeHbNSgqlHd5BjHhNqGCiQP2vDCAUx/IXatcYbBdTvnC8/wBHI8ZA9MrAEl?=
 =?us-ascii?Q?BPpTUMJ+/D1DzvdG1Or0tjs/nPaK9Xql+b5U1ZHYWJthHMEL+zudCNlRqTEo?=
 =?us-ascii?Q?VMyA9P5dFbFcG26n76JDmhf9c1pvjIO9CGGJYLuzxv5t1d1nQYiSDqzVFA3G?=
 =?us-ascii?Q?udBMOL6XL+KqL7PAiEPHHH9CHoKmMGlcLugprbEy77XeAJWxLX/O/lLmnkqa?=
 =?us-ascii?Q?S9IRBohGr0chDrekaeZt/YDFVJJn24QGQjDiE9GtLAyHUoi79l2/geY+ArW3?=
 =?us-ascii?Q?KGYV2oSMEM5ZHcn9ObfYtvFp2j8e4UE5RIcDXO7SRqKawDl6L0hJvwakzrEA?=
 =?us-ascii?Q?VhxY/BNDU9M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2CN1gsyz7A7zPZEwP3lTYEO+COwMp9e6bcuez/qKDDcSgsKUL/6iqAdm1sMg?=
 =?us-ascii?Q?BxTkeMgrI5/Ea+tfW0yul/kO30n6fNJ7blKbTCLm8D5tAiXoBkWrkw+LTRfM?=
 =?us-ascii?Q?uGiLphEvDXHCFtdXHOLoVDekb8dJRWztddPyBQ+X+5/T0JoottX7SOFuvVzP?=
 =?us-ascii?Q?VYn/CkvLScol96WRhwGylPV2My8KycINCQ31VHXmJyinph5Iygw66foibxWj?=
 =?us-ascii?Q?g1W6RNomc1sP17Nh+VxiaHv/F0OkMtbhKQN7a95KUH1P7sYKeEUowapk1q02?=
 =?us-ascii?Q?8x1K8mer8vzGdUAAYJYtdhqJjLxJ0XzjNxJB/gVvnfGxqbAXhJ+s7q3E6kbu?=
 =?us-ascii?Q?TaiiIsaCNfNweTc+cHyzVRmH0r+IwgCgtISNLTyvd9qOIIJQzs/FROiSM4d/?=
 =?us-ascii?Q?OyzB6ZB9OhC3p1GrDPk2oK661CqnuV7PEG5UTUuN+2+wCaje8kyM25wOMgNn?=
 =?us-ascii?Q?I/CO0hpcMoFoPGaDUrqRPHKvRI/5CpbWGi4G57pUYt+73RPGnb6sTE2vQHgC?=
 =?us-ascii?Q?oxQIYn0PSnEFK0tLhETW88/uBFq4RnA66jB29uPAKzvCwgARR3bqOuQeVgRc?=
 =?us-ascii?Q?zq8vKDydtvN9i2kFKUcxE5x8K6Z+IDffeJF9E806vPK+07uWcUcg03LMU0Xg?=
 =?us-ascii?Q?E6gjsTFhUNjHvrVXHdJWdzU58LAJ+9lkB14ciNpA2BS/D1JjsMwAE4PJ62DZ?=
 =?us-ascii?Q?peLnBJAUbmrIa7OU3Z3BAnTjCsqzX33zUnMOy2Lv6F24B4t0SUpd2MYp3Gtm?=
 =?us-ascii?Q?JlElxNkoppHfeXO007jzsSzGD6Rdbjj//hrKShrErdbII/ElmQGo1zP0IFNk?=
 =?us-ascii?Q?LT3icaJDg5CodZ6Q8nqEVFht8Y87zI7SugGAw7JEml8lTKqBJQ1dWjXm/rCN?=
 =?us-ascii?Q?Ina6XYp7gcWRz/jvImPcSvh4S2KX/UXTYLxxyH6WY1YKOWhy/e+nLze8tSrw?=
 =?us-ascii?Q?62o2YsC4D0f7vuEEUE5L6GBJqF2VrGLEchzELjwiiqNPkaColvaPE5SvlP3l?=
 =?us-ascii?Q?9CG//Wtv+1R75jTYGP1x87kdBOku/0XnE9QTpGaH2Lo9/vnv6j3/DXCgNrsI?=
 =?us-ascii?Q?brERmQBYif6VfeE6sUSFDgqwxDV6Cs82e6ctT5x7ogErFpYk8zH8TypltNaY?=
 =?us-ascii?Q?fCfufu6To2qf4ulkK8EZsLc3kh+QLXMtcfb/b0ccYKyrxpSZMe265gGacJYJ?=
 =?us-ascii?Q?ciQMDLOYJ8xRQ3AA8LcEbB+nHaOSovFYJbxmDgOggRhXuqvisgnyImznSNkB?=
 =?us-ascii?Q?YjqtqeEFG4m/yisvZghGpZR+BFaGT7jScUGhmyGNfO1gkJPwa2qrCESsY1ij?=
 =?us-ascii?Q?7W/cYHv2fVBc+d7+jj/LamMCe1+HOyYJ8/NRZFRf2MJ16GspP92WNuQvAWev?=
 =?us-ascii?Q?SAUD15tdFxECtja2vsUxVO2VW4R9ML5s3rkbeh8zYqpTl1ODFI79vszlzVnX?=
 =?us-ascii?Q?09cp8Rj8heAyNIXz56Wh4z+RNM3/LDQXQKui7dXDITPXYe7MZNPF1hGBSHxx?=
 =?us-ascii?Q?HTfUT0M3FXHlfT0PQMl89S+t+bMJTYELNhtlkD4iV2mQLMv/5e+nGUwRrxXP?=
 =?us-ascii?Q?LvePb38NkPU2k1V80r8IR+epkRuQiVdylKL+Q1A6ynh23eKU3hJCkKz0ehaR?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I4E8KAtYvEop/4pTLmVBZOn05oxn88Bq/z6lv8aOlZtkmFbVlc74tEDjWazh8IFkkAvQj83c3nqrCsmeIo5c677Bz9DoJZ08/YIw0Ol+2zfSWRS1cEKM90+QN45EDmwloF6SZSjtNhtjrByapeqZpReAjFWJUc73Ksb1THhovbZKFzMn6LKpd61A7HUnYavW32nv7h03NIv4ztdIIC4qaS2oGrm5VzkIQ1MQpQkxL4+3+rZpC9L0ldmw+OFOLGn5aaHIrU6414WcqsuNmmtP42k16NrJrB7oIuKlxpO4+cux9OKjqrnSJDEHJht6pGtuarImyr94vCr+OSsY69V8Tqudq4RzWhxpRiOpU1F6psxzTxXwTx+7jSLpJisgTEvFgY35Pco8fpCK1N/iV5Hy+J4h8lLpPXIwP74W/2oUXi0tHs/IHkl0Uc7bO0hlie5qau1IB/R35CMvzy2LPqL2l5e+845mo48dkyazNd87/jXmbSv3SpqUIoCYy1AAK4B7pVAvDzB5BRqz6AgP3/VR3VzkS0BnbHzapimEKIgmTTd0T24/yl0SYYHre5C4AfD7oyWp1wFwbz47rRjmXmOHbt+KVz3E9aPaiNsiOuz7GJg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9494e372-31a1-4a69-dd7b-08dde5d4a80d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 01:46:07.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAZtqNxZxRTfB1UtvWHGERIyaMx608rHmygjiD6qB2a6YDFs9ZqHXbjHiV/vCPQE9uJEsjE6bpRicCKOiTjlgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4522
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280013
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68afb4e8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=QyXUC8HyAAAA:8 a=oGMlB6cnAAAA:8 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8
 a=1XWaLZrsAAAA:8 a=iox4zFpeAAAA:8 a=37rDS-QxAAAA:8 a=meVymXHHAAAA:8
 a=7L1rQSwQd0e8280WIGsA:9 a=CjuIK1q_8ugA:10 a=NdAtdrkLVvyUPsUoGJp4:22
 a=HkZW87K1Qel5hWWM3VKY:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=k1Nq6YrhK2t884LQW06G:22
 a=2JgSa4NbpEOStq-L5dxp:22 cc=ntf awl=host:12069
X-Proofpoint-GUID: RpWRnhEJTppGLPXZawR0XI4_9GbQ9Jqf
X-Proofpoint-ORIG-GUID: RpWRnhEJTppGLPXZawR0XI4_9GbQ9Jqf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfXwbCz8DyNkCnq
 BsFi/CKZg9YBO+fSCx0oeZyyLl+EexGTMzCdsJno/BnSvLyRA/K+JlOEHmZmMp47dSfxend8rzh
 dIVS7Useufxb771IEFJvfARJiCK+mU6UxuszcASboUbx99TAPMyNUmviKYiJbMVQmtyd0Bfeu0b
 Ll+/bV1Ax2eiBTkQZ4LYnnxpSDbZ7V9szsFKgE+lVHZPalHWr0mwsXyo9prw2TMC59NTFUeNpLb
 m0HJOt+Zfmg9NO8MVXQrwBR9tIz9FwaZNGE+4gBNIPQmWULCDF75/4MElKtjI2TMuaHeOGvMIBw
 Ad5OZCwgMPhXb81cIBeTsDMmb+v6NKd7cUGIaEZu2f8XyAHLH6aa1Oj6OOv7ha727vnT51ZuPwT
 YIE5a3tY7qTIh2LZ0ZtgLPqxCtNHCw==

* Steven Rostedt <rostedt@kernel.org> [250827 16:24]:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Associate an sframe section with its mm by adding it to a per-mm maple
> tree which is indexed by the corresponding text address range.  A single
> sframe section can be associated with multiple text ranges.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: x86@kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  arch/x86/include/asm/mmu.h |  2 +-
>  include/linux/mm_types.h   |  3 +++
>  include/linux/sframe.h     | 13 +++++++++
>  kernel/fork.c              | 10 +++++++
>  kernel/unwind/sframe.c     | 55 +++++++++++++++++++++++++++++++++++---
>  mm/init-mm.c               |  2 ++
>  6 files changed, 81 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
> index 0fe9c569d171..227a32899a59 100644
> --- a/arch/x86/include/asm/mmu.h
> +++ b/arch/x86/include/asm/mmu.h
> @@ -87,7 +87,7 @@ typedef struct {
>  	.context = {							\
>  		.ctx_id = 1,						\
>  		.lock = __MUTEX_INITIALIZER(mm.context.lock),		\
> -	}
> +	},
>  
>  void leave_mm(void);
>  #define leave_mm leave_mm
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 08bc2442db93..31fbd6663047 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1210,6 +1210,9 @@ struct mm_struct {
>  #ifdef CONFIG_MM_ID
>  		mm_id_t mm_id;
>  #endif /* CONFIG_MM_ID */
> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> +		struct maple_tree sframe_mt;
> +#endif
>  	} __randomize_layout;
>  
>  	/*
> diff --git a/include/linux/sframe.h b/include/linux/sframe.h
> index 0584f661f698..73bf6f0b30c2 100644
> --- a/include/linux/sframe.h
> +++ b/include/linux/sframe.h
> @@ -22,18 +22,31 @@ struct sframe_section {
>  	signed char	fp_off;
>  };
>  
> +#define INIT_MM_SFRAME .sframe_mt = MTREE_INIT(sframe_mt, 0),
> +extern void sframe_free_mm(struct mm_struct *mm);
> +
>  extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>  			      unsigned long text_start, unsigned long text_end);
>  extern int sframe_remove_section(unsigned long sframe_addr);
>  
> +static inline bool current_has_sframe(void)
> +{
> +	struct mm_struct *mm = current->mm;
> +
> +	return mm && !mtree_empty(&mm->sframe_mt);
> +}
> +
>  #else /* !CONFIG_HAVE_UNWIND_USER_SFRAME */
>  
> +#define INIT_MM_SFRAME
> +static inline void sframe_free_mm(struct mm_struct *mm) {}
>  static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>  				     unsigned long text_start, unsigned long text_end)
>  {
>  	return -ENOSYS;
>  }
>  static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
> +static inline bool current_has_sframe(void) { return false; }
>  
>  #endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index af673856499d..496781b389bc 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -106,6 +106,7 @@
>  #include <linux/pidfs.h>
>  #include <linux/tick.h>
>  #include <linux/unwind_deferred.h>
> +#include <linux/sframe.h>
>  
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
> @@ -690,6 +691,7 @@ void __mmdrop(struct mm_struct *mm)
>  	mm_destroy_cid(mm);
>  	percpu_counter_destroy_many(mm->rss_stat, NR_MM_COUNTERS);
>  	futex_hash_free(mm);
> +	sframe_free_mm(mm);
>  
>  	free_mm(mm);
>  }
> @@ -1027,6 +1029,13 @@ static void mmap_init_lock(struct mm_struct *mm)
>  #endif
>  }
>  
> +static void mm_init_sframe(struct mm_struct *mm)
> +{
> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> +	mt_init(&mm->sframe_mt);
> +#endif
> +}
> +
>  static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	struct user_namespace *user_ns)
>  {
> @@ -1055,6 +1064,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mm->pmd_huge_pte = NULL;
>  #endif
>  	mm_init_uprobes_state(mm);
> +	mm_init_sframe(mm);
>  	hugetlb_count_init(mm);
>  
>  	if (current->mm) {
> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
> index 20287f795b36..fa7d87ffd00a 100644
> --- a/kernel/unwind/sframe.c
> +++ b/kernel/unwind/sframe.c
> @@ -122,15 +122,64 @@ int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
>  	if (ret)
>  		goto err_free;
>  
> -	/* TODO nowhere to store it yet - just free it and return an error */
> -	ret = -ENOSYS;
> +	ret = mtree_insert_range(sframe_mt, sec->text_start, sec->text_end, sec, GFP_KERNEL);
> +	if (ret) {
> +		dbg("mtree_insert_range failed: text=%lx-%lx\n",
> +		    sec->text_start, sec->text_end);
> +		goto err_free;
> +	}
> +
> +	return 0;
>  
>  err_free:
>  	free_section(sec);
>  	return ret;
>  }
>  
> +static int __sframe_remove_section(struct mm_struct *mm,
> +				   struct sframe_section *sec)
> +{
> +	if (!mtree_erase(&mm->sframe_mt, sec->text_start)) {
> +		dbg("mtree_erase failed: text=%lx\n", sec->text_start);
> +		return -EINVAL;
> +	}
> +
> +	free_section(sec);
> +
> +	return 0;
> +}
> +
>  int sframe_remove_section(unsigned long sframe_start)
>  {
> -	return -ENOSYS;
> +	struct mm_struct *mm = current->mm;
> +	struct sframe_section *sec;
> +	unsigned long index = 0;
> +	bool found = false;
> +	int ret = 0;
> +
> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
> +		if (sec->sframe_start == sframe_start) {
> +			found = true;
> +			ret |= __sframe_remove_section(mm, sec);
> +		}
> +	}

If you use the advanced interface you have to handle the locking, but it
will be faster.  I'm not sure how frequent you loop across many entries,
but you can do something like:

MA_SATE(mas, &mm->sframe_mt, index, index);

mas_lock(&mas);
mas_for_each(&mas, sec, ULONG_MAX) {
...
}
mas_unlock(&mas);

The maple state contains memory addresses of internal nodes, so you
cannot just edit the tree without it being either unlocked (which
negates the gains you would have) or by using it in the modification.

This seems like a good choice considering the __sframe_remove_section()
is called from only one place. You can pass the struct ma_state through
to the remove function and use it with mas_erase().

Actually, reading it again,  why are you starting a search at 0?  And
why are you deleting everything after the sframe_start to ULONG_MAX?
This seems incorrect.  Can you explain your plan a bit here?

> +
> +	if (!found || ret)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +void sframe_free_mm(struct mm_struct *mm)
> +{
> +	struct sframe_section *sec;
> +	unsigned long index = 0;
> +
> +	if (!mm)
> +		return;
> +
> +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX)
> +		free_section(sec);
> +
> +	mtree_destroy(&mm->sframe_mt);

The same goes for this function.  mt_for_each will start at the top of
the tree, lock, find your result, unlock.  Each search starts from the
top of tree because it was unlocked.  In the mas_ functions, the tree is
iterated in place which can be significantly faster depending on the
tree size.

Since you are not going to edit the tree you can use a maple state:

struct sframe_section *sec;
MA_STATE(mas, &mm->sframe_mt, 0, 0);

mas_lock(&mas);
mas_for_each(&mas, sec, ULONG_MAX)
        free_section(sec);

mas_unlock(&mas);
mtree_destroy(&mm->sframe_mt);


>  }
> diff --git a/mm/init-mm.c b/mm/init-mm.c
> index 4600e7605cab..b32fcf167cc2 100644
> --- a/mm/init-mm.c
> +++ b/mm/init-mm.c
> @@ -11,6 +11,7 @@
>  #include <linux/atomic.h>
>  #include <linux/user_namespace.h>
>  #include <linux/iommu.h>
> +#include <linux/sframe.h>
>  #include <asm/mmu.h>
>  
>  #ifndef INIT_MM_CONTEXT
> @@ -46,6 +47,7 @@ struct mm_struct init_mm = {
>  	.user_ns	= &init_user_ns,
>  	.cpu_bitmap	= CPU_BITS_NONE,
>  	INIT_MM_CONTEXT(init_mm)
> +	INIT_MM_SFRAME
>  };
>  
>  void setup_initial_init_mm(void *start_code, void *end_code,
> -- 
> 2.50.1
> 
> 

