Return-Path: <bpf+bounces-66836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469FAB3A45F
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 17:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B4E1C80824
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00822B584;
	Thu, 28 Aug 2025 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UwS9U59I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JytAb+CM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758921C167;
	Thu, 28 Aug 2025 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394894; cv=fail; b=JYVty53cM9VtwDa4i5rzo6pWw1gfk62akJSjfxFg08jaP8N0aiTste/Z+rXplN9KEVvV0Mvw5dvBP4Sf63tqRZF+ptCMPJhsm8R0Dew57gP08LfUP+OD4ZwMpNPBdyfQH0QiCL89LIVs6oiharLXWCo9o0TNY8aV82rgNq+7Dps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394894; c=relaxed/simple;
	bh=IWKfEdxJMZP2ZEJ9lHIoR719TOMf39ZGqLzjZ9K0Bxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LjHjnSaljjMTvm2bUKNLGPDaj2iQv8Fw7XZr2fd0zhErPMaDrA52/11Cz8UdFAN/UjIEuV/QW54REWulDwZIU3pRo32GpaGknti4cuzzocygnk7A5dfqrrtw0A9bNMmWLz5cjL9KMBykUrEJtcnr1crGDJ6LkDZDQRR05kmLUb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UwS9U59I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JytAb+CM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEN1u2014256;
	Thu, 28 Aug 2025 15:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=HORPGpzHUXnmC5h95e
	r9Kp5nJVV9JyPIEfJH+k8TWTY=; b=UwS9U59IpvbGr+QMT9FC/vm+xEl+5uR132
	M0sMMkfA6+3rkIc2sk7kU415l1wzvBYNaQUqmU/SfY4H4DlBV/YrNpFetn9fyyzP
	ByQ7TnYD5IsoWez26BbKcu6zf4Ay/wBgLfAKUjb6UygbCNa7cA+Ce0e+ytTTz5EC
	TEfhxyBZUwKlzIBaVsOi/LGFHMsJGp5xvMtNWBn46z8QaUdWVvXLl4ihaAD6lWrB
	KD8pt8qJL0tNy6i58O5vdTrzOvVzUroZWEdv65NHSJp68ZCzlU0oOpMxJtO00uuu
	j8gf/fgRzEmJayyxM3BgbZvsyp+X6HXGNpkcAXQnJHXpknQeWbow==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q6790sc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 15:27:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57SEPYi5026715;
	Thu, 28 Aug 2025 15:27:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q43bw6v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 15:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXwnO7LkcOZAUzkGDGVGGmGVJqmmCyWx+vDjQMeF5BoCTHQQLJr9wg/xyTwlPvw2kKvDdLV8VrKSWcnxo/MdMLTd4b6aK/kQ5T8327DNn+OPWHkhjaqREB7P+Mes6OtlG80PJYFuudollG8Cfdm/nKEiz1bL9YDYVhm7R20A9i9f+Vc/iqC+sIDbrkLXGZFMtPfMIOfSHjbxrA6Up38cNuFi84su+OpE+mcBfz3aZiUcw2uczsQV6/g9ob871F4fb0nt2c3bW/YKwnLsAop7B3Tx8e/bo3Wov9mnjytiMe+3aRCVzU6jibDA8kdFVeCUvtwUMQn7BWVPuRh1KL3/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HORPGpzHUXnmC5h95er9Kp5nJVV9JyPIEfJH+k8TWTY=;
 b=RkTo2GDx5KFIegbwWuCQ5FmRwmyyCmsXn0OjbcfH+3BlsBQEEhbAo/gRsoFHDPRizkwQjDz+jm6j8w7gf/zTRySUHHWRwmZy9g8XY34Q0w/sgWWun29HoZvVYoBTLfJVqXyQLJCFwy6hia3Ntb53HkmOUloAOTeg7jziJn5Z8R9G3FJrGzOojbsIEBJR7STwHEmiXgolV1rFsxZiaKIw2rnOaP4bpTpT5q5ZVtf5xhltQHbXWnwDXV1oiyyd11mSymXtFjjO2MvsQPnW81eCZ/gtcTwR26lKYsORhMm3YdtWCz1DQWvNaTaWK7pYFpefgSis5nmIg2HEkoxgpUTR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HORPGpzHUXnmC5h95er9Kp5nJVV9JyPIEfJH+k8TWTY=;
 b=JytAb+CMov88g72dhoDFO3p9TD+n3jMDCm09BfjxSCAAzQUgjrjXASZjv/U1sC5n94UNcI8ZgsfGTDfdO306L0ZOXBzMqYQxXB2lEQnxPTBOl8mNYA5BlLLFnoddBpFp8MFNkO3lb8KbN5JT/q5uyLBlsqfMGTM09k5bQNzsIdI=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.16; Thu, 28 Aug 2025 15:27:07 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 15:27:07 +0000
Date: Thu, 28 Aug 2025 11:27:00 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <emcthzvyvaj4fqfurbjx7xxqh3w4uwt2qxa4h6hdurh6brvnkc@zk4dspp2tcca>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
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
 <el6nfiplc3pitfief24cbcsd4dhvrp5hxwoz3dzccb5kilcogq@qv4pqrzekkfw>
 <20250828102819.27d62d75@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828102819.27d62d75@gandalf.local.home>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd167e6-7bf3-47f2-cc46-08dde64758c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s77WT2G34AIm21YLgeYpcS4nxRiw+yiMTyGE9UVGDxt3IB2wzUt6O+1u2C6b?=
 =?us-ascii?Q?cmrb2Lq4+clSo7O8y+m9f4bJo/u5b8JAea3b2+TBCte/5deLpY9hVlO7kibd?=
 =?us-ascii?Q?QZHeigi+1KXXQ2+L5WjF1yzJgUDRYaunAXFXDipM0tjLYRYjVVli3x3pkMm7?=
 =?us-ascii?Q?J651AcjlDcTrX8ZTq/VuwGeRq6MOMZijDiZXxeDE0+rnhm4+tetaFjeZX3qX?=
 =?us-ascii?Q?9s8pN42S333mPmXC8VE0vEfIW1Iv2bTxR/igZ5vhuhipaEkxBhAwDpvL1B6Q?=
 =?us-ascii?Q?5PXqsAAAvDhZEECqw67fRZdQr4dlBA6/0fe/WVwmjiyGaYyVr3h5qs53ny4w?=
 =?us-ascii?Q?aFdDARQ0m/MRrD6uvyx+B22Pv8k3t+zXDlgjeHd7079cuUvZgwpT6NJjnSlO?=
 =?us-ascii?Q?FkBDwkBOPCJPe29KyUF/4Q+2UrPfXSw9Bmsesxcj/6PwhdyUYmwMmo41bDiB?=
 =?us-ascii?Q?GliAXtlozN+3eOkvJOU2DKlFSTtV40UwFIzUfiMsMqPX0TGZWVV5V3mfs5xn?=
 =?us-ascii?Q?b99XE70DdB10YhLB8V+eg5aeW6IlfGWZ4tTGTSA2eCeRdOL3fNbXbPjehaYo?=
 =?us-ascii?Q?eP+PI4Zj/+fn9V1VBUTW2Lz9vmkVdGAAjrKTxKY5iDHVIkMESmCM/MjNVG0b?=
 =?us-ascii?Q?xF/5S9jmuBUJ3POYdEjVZqEZdQD0/gUNbRdc3jQkUHV9DRuDqSmDTaVVBGbx?=
 =?us-ascii?Q?fFsYduXEjiUwmhmWSHM49eFuWn3DPYk+SbftXowUYkW9bZTOmebmB89IiL/A?=
 =?us-ascii?Q?/JGqXp0JBjWRxHjkB8kCId6iAhKhUWVfAx+0zYb9S1TVUfSJlEF/9SrOvIkb?=
 =?us-ascii?Q?CJTUJeY2Y9DKUIUglg89zdack8l7xWgJY1/GXZel2g67yIfPSBipaVwls3Ze?=
 =?us-ascii?Q?VXzF9QaY/AMD4B9Um7c5lRfYj/yn2vWjjzrzFyWII+6lWCo4VKcoPtUUB3nw?=
 =?us-ascii?Q?nTFHE/MVUE+5P51YzkD5mYaF1qgBx7LGMrQFx/EFnow6A6nPg0wauAUKX+Ue?=
 =?us-ascii?Q?d0ZHmf4DSJpl3Y3nizOn6hBBnPbOwkUbMpoHqupBABH9mdtSFyvNwOW+8bsa?=
 =?us-ascii?Q?WKiFf0oxL5MsPh7U/RCaYJgDCdISUapTs8oGuZzaAfl1PnMRvHZkgQ4IkeV3?=
 =?us-ascii?Q?d6Ws/d+TrzvVN2cAeulO1ywLwDGh/9qUp93gMOj+rE2DexZwE60o3dQPRS3d?=
 =?us-ascii?Q?VV8pchTDFioRAfCL1n4CchBwJmPpOJQWEwfvAzuq9oEKAVKzYsbELpV18DbB?=
 =?us-ascii?Q?9gMZcU4o8r28DDGHDbz1trcvuuvqoVB5l9PRXM5QMI8i84QJbADKOFLSJ1zy?=
 =?us-ascii?Q?gf0mN/fiJbeYB4SBO7KfpvpH3gfVC0dqCOTRrDaSzC6sjjLDQyW+ueyjJnVC?=
 =?us-ascii?Q?vooyNQ70ECaLQZ2V8ZqagNhZauNaByYYKF56i48IPFrj30aClw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SwkkmMDu+/VGmDT7PMK0rBHg63E0N85pdQFwwDQj79biKbrI6RFiDqhiUKgv?=
 =?us-ascii?Q?NwAQ3hV1LJY73iuoN4i4L3MhaHyIv4HsPIoTbyKHcm67Khmy0Aw6v+1ktdBU?=
 =?us-ascii?Q?ZsU4lBa1s/vwogfpGGWB3eO/w/1eLMh9ApZdYD4zdXuIv6Fecg2rOctxxWTA?=
 =?us-ascii?Q?j3KRxzSktN0WWhi/p7UM3GDoA0XjEjOVnupb3Dbv0EBYsVvS/6wCqPSZ29pA?=
 =?us-ascii?Q?83Xy4IjrswXKpxIcxIgsSAzzaJnXbVtXTpWPQfkFfZdIicQC2lTlJvkqU9NN?=
 =?us-ascii?Q?sD267emJIBWhnbjEkbWnMAyKwNs8yi2HSIEoniweh5JhjrRvbo36RT6jRn9Z?=
 =?us-ascii?Q?N2evACxryn8U2Irrwii16B7So4sO5dF0mDwu1kOYeopnWtLxZ08SH/EVAVbe?=
 =?us-ascii?Q?6vE5FX5uB55T5S6xZqPpG5fUQyv2fxa0JcvJFSS3mbe1gzW0sgqlDu084LmR?=
 =?us-ascii?Q?WzEK/MiTJswtFeVq1sZdGJb9AfZ4wVF/7GuKhTULdbTu8oIqJxvrwJMsht7v?=
 =?us-ascii?Q?tgRhe4wFP24krJJhFkrL5xbybQg1znREkDIJJDV40eHQ8qT1lq3xk0oIQA+7?=
 =?us-ascii?Q?nsSgMGvyXB9ayZdu9zG8BwyVs2R7CUzxzRB9qKgtjHJcUMzPHlOhgEH9cLcS?=
 =?us-ascii?Q?Oh8QZsUk4biUM5AVzzqq6i7X+3V2wgDg7y4YqKGMfBAu3pv58yHWGVKxFs++?=
 =?us-ascii?Q?cuBMX09DCxYbh+wyur3UaBjNJsxZOz7kr9dallLFYyJsxwO3YqmytqEtuun6?=
 =?us-ascii?Q?jAQpZNpKfUEESnUlnEhU91nQ6L0c0s0nRJasbilRLJ8iFATTXh63PmPjivql?=
 =?us-ascii?Q?bQu1np3Wpqq8pyZx4E/fhY5yTCdsOQ8mFF/TzKxsqYKVm1XD+hZ9PJcbHseX?=
 =?us-ascii?Q?FZUrznNYLGs1qsorLSZMlRmVjAWvJlguqNuxrwtdIJ/CDUtqP6F5SV7XbpHG?=
 =?us-ascii?Q?ym4oO2KCL3EKDtisS8INaruuYPu+DItPFfSMHDP7XxBLab/r9wPD8w+CEdxD?=
 =?us-ascii?Q?tSRc8RtaHv2CYwj26QexVMBhAmbajnMa7WgNAjZk2YthanJQOG8IPtMpm4Ux?=
 =?us-ascii?Q?VGMdZZvtzBsnoUZsTCzSMqW6+wO3aEdk/OuUzOJiu6Nph6QOEronaANYkUrb?=
 =?us-ascii?Q?/giy7UTfy9b1X8go4Y0j2gkNeKX69oRPewHpWmOoRQuoeaUBZ0eVUfJQ+Kfg?=
 =?us-ascii?Q?OmLHQHu7BiUDeviAm4MRtRx6apZmJIUyAdT5IYP/SSLbHEIt8IjRvDcxdxx6?=
 =?us-ascii?Q?W/Yq1OoolSQjVJYuB7rQjQLXwLpB1z+DXFE8AbNX94CraIYmOcFGH/zSz5ON?=
 =?us-ascii?Q?3WY0w4/higXELVMPs3VyPtpX44Lp0zfPycoQ00av381huTVxXkcAIfQqUtqA?=
 =?us-ascii?Q?VkKN8pvnSew97l0vDmk/JS57gmEtk3gTRwsx0ZUS5rYSD4bQr3vHefNhf/KW?=
 =?us-ascii?Q?F57obrNn42tyg95RCXPV5GFpIZl6/ht5fQ+wvnaVJwVC91tsINUYwVwb0T/x?=
 =?us-ascii?Q?qd2zg1o8RKID0xeeO/Xn7IxIpZml6M19nsFbvbVAxQAffBFqs1Tvl5JhWvO4?=
 =?us-ascii?Q?cQj4ulcgDkMz11DFks8pia/2rARyAHjPD/FRSg6WCi1kcYv7jsLnm/E64Hhi?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EyKe3lNdX5dPL6KDR7kOExEsiyMal1O4XDW8x90anCtlmk8n1knMOpkJlOnAj3gS/07OX+3cuFvhB4NE43er9NJwD/YKOw6CGYo38sby2yxg5kCKJKYi5p6ycbw5sitz7cthXXLh1EJ8w6D8DCYCpUjIECGbUgveLNIG/lYhnuIc863Lf4FIXt3VZssyMM+hYkRFDlTSa1/08l8PEFEKZBOBk8SOjGgFnINd2DPV28wgNVqOY/Lrm1MeMFx30gAQUbDYZBhZCZnhaVb57AyzVP7BChi9RSa3beiNHLyD+eJKaEX1ydpZzayrVnFVE2FStyN4/aDiNz4GFPgf5jzTrFsoJxXe1AwXn9+VkN/jIuGZo5qJw+Rp9TtWQxch2HmoZp2w07+XfDAaHVNcQdJF2nf4ijhp0Fg4ot87tkulTewXChQfBfM5jXVPX7mGrDyCmeotA5mndNkvNZhlW6VJZ7ewEbcGo8TrlUtM9ssnVTcUc2TluBWdlhb7pcERTUDmQKNUx1pQ6Oqhbg1v0pYlSVZMDP/3uLWQE3+3p3bP9PG10FX3DKQCfZsZpDtQq6jlJJ/BLiTfL7favert7DQZRi7c1on9ONmZfmOBslXs6UY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd167e6-7bf3-47f2-cc46-08dde64758c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:27:07.0580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FuknW/oKDfLDkO4rty4Y32hx7ATVf0X3W2Bwb3arrtLzJa0c/CtmhD6ZYeNBNjR9jDcrpTDAouIGDC63k+FyjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280128
X-Proofpoint-GUID: PiNbAdpZuqmPgRQ8rxe8tbvbA2pMamqX
X-Proofpoint-ORIG-GUID: PiNbAdpZuqmPgRQ8rxe8tbvbA2pMamqX
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68b07553 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=meVymXHHAAAA:8 a=yPCof4ZbAAAA:8
 a=QMLe4LS_oB_z2nXbcucA:9 a=CjuIK1q_8ugA:10 a=2JgSa4NbpEOStq-L5dxp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX93fSVUytmgNG
 93+iz1QKMpEpUlbYaLp9EdF66gf0ThTAse4SjKZ1K+mBopg5GyaVDW1NB8AAFGzAM/0qn7NtbHO
 Fjk0rnAo22o7EHerTp0iGyPv4fJvvNH0kFrj8gq6zE112rfp5xMQ+GFehO/L3CjJaUQ709H8OoQ
 efEqA4eLSJUg66Og7vvD94nWw4wPb8GKXNKvy6us8i81+7CoFXqwo6HiBWnG+HGmHbfsLdBUaGZ
 ZMhDKGnqsoOUWooO7nPMsoXWlJfqGEXaNRBuLFjvfkOyhP+6wOixUrmSo7v8XubHLjnXI06un1U
 7hWLX9MhUoRbVQOtO2wzn8yWz7RzVlf7h+Swj8X6zwq7XxOi3ogKQwUyYw5DPGBHt77mr3oEFSv
 NsuRnCod

* Steven Rostedt <rostedt@goodmis.org> [250828 10:28]:
> On Wed, 27 Aug 2025 21:46:01 -0400
> "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
> > >  int sframe_remove_section(unsigned long sframe_start)
> > >  {
> > > -	return -ENOSYS;
> > > +	struct mm_struct *mm = current->mm;
> > > +	struct sframe_section *sec;
> > > +	unsigned long index = 0;
> > > +	bool found = false;
> > > +	int ret = 0;
> > > +
> > > +	mt_for_each(&mm->sframe_mt, sec, index, ULONG_MAX) {
> > > +		if (sec->sframe_start == sframe_start) {
> > > +			found = true;
> > > +			ret |= __sframe_remove_section(mm, sec);
> > > +		}
> > > +	}  
> > 
> 
> Josh should be able to answer this better than I can, as he wrote it, and
> I'm not too familiar with how to use maple tree (reading the documentation
> now).
> 
> > If you use the advanced interface you have to handle the locking, but it
> > will be faster.  I'm not sure how frequent you loop across many entries,
> > but you can do something like:
> > 
> > MA_SATE(mas, &mm->sframe_mt, index, index);
> > 
> > mas_lock(&mas);
> > mas_for_each(&mas, sec, ULONG_MAX) {
> > ...
> > }
> > mas_unlock(&mas);
> > 
> > The maple state contains memory addresses of internal nodes, so you
> > cannot just edit the tree without it being either unlocked (which
> > negates the gains you would have) or by using it in the modification.
> > 
> > This seems like a good choice considering the __sframe_remove_section()
> > is called from only one place. You can pass the struct ma_state through
> > to the remove function and use it with mas_erase().
> > 
> > Actually, reading it again,  why are you starting a search at 0?  And
> > why are you deleting everything after the sframe_start to ULONG_MAX?
> > This seems incorrect.  Can you explain your plan a bit here?
> 
> Let me give a brief overview of how and why maple trees are used for
> sframes:
> 
> The sframe section is mapped to the user space address from the elf file
> when the application starts. The dynamic library loader could also do a
> system call to tell the kernel where the sframe is for some dynamically
> loaded code. Since there can be more than one text section that has an
> sframe associated to it, the mm->sframe_mt is used to hold the range of
> text to find its corresponding sframe section. That is, there's one sframe
> section for the code that was loaded during exec(), and then there may be a
> separate sframe section for every library that is loaded. Note, it is
> possible that the same sframe section may cover more than one range of text.
> 
> When doing stack walking, the instruction pointer is used as the key in the
> maple tree to find its corresponding sframe section.
> 
> Now, if the sframe is determined to be corrupted, it must be removed from
> the current->mm->sframe_mt. It also gets removed when the dynamic loader
> removes some text from the application that has the code.
> 
> I'm guessing that the 0 to ULONG_MAX is to simply find and remove all the
> associated sframe sections, as there may be more than one text range that a
> single sframe section covers.
> 
> Does this make sense?
> 

Perhaps it's the corruption part that I'm missing here.  If the sframe
is corrupt, you are iterating over all elements and checking the start
address passed in against the section start.

So if the section is corrupted then how can we depend on the
sec->sframe_start?

And is the maple tree corrupted?  I mean, the mappings to sframe_start
-> sec is still reliable, right?

Looking at the storing code, you store text_start - text_end to sec,
presumably the text_start cannot be smaller than the sframe_start?

Thanks,
Liam

