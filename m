Return-Path: <bpf+bounces-74997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D8CC6B342
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 19:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE8494E35E6
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26398361DA7;
	Tue, 18 Nov 2025 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPNl/bXa"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38931ED8F;
	Tue, 18 Nov 2025 18:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490405; cv=fail; b=HBSG2PBJ0vcKk/tEp5QQgK7AJ+VBLgcarjlOp+I9yWP0pJ8KvUfLmscKZk3L9YTn9vWUbttLmT6hyAZxKt7wcFlGs2QkUfYwG7HhKeBsQUyi7l8nDOEpUBGOxTvHWiMFCzkpd26OqyUI0/79rFYioHjXDQh46xStDNRY32Kczxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490405; c=relaxed/simple;
	bh=FIscyoppqfjEHMKkh2P56/YAIiRDDLTqtItGoeCcZtE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jw5GgItnuOjUQJdW6OZXr4bBX+DfnOViFPZcL3qzitX9ZnXKVIusjCOzHnIQhRVdEVgyCahZHm44laoC1sTuC7T4Ay1BGKltVvs9Z59Pj2cGDqrY5XN7Z+XIeEEP7IFpgQVug1AzIDYT01XkzcbgAtM3Of+2vgO5EcK7ZfmBxuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPNl/bXa; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490403; x=1795026403;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FIscyoppqfjEHMKkh2P56/YAIiRDDLTqtItGoeCcZtE=;
  b=iPNl/bXa6LGjnt+cp4vbqxq0SapVb27C/vfdX2EWEtcYzOkdqJdQ/I+s
   RvaOv9cwLNqwC6X0xIpUMJVgWOjYGBqby4Q5xmVoyGtNMHQOYi1wiFsyy
   LbBc4455qO/rH5r1+95SdJzgH4ke9iMHnpk6OgxX1PW0Fvn1dY3QoN3cs
   xfVMjNUpIGKM1QMIVIQ1ZaDNafQNbsYPINaAZwa52hMSw3wTpUlQMeZYz
   bIeyed+dLWA9JhsieNyjkrLnt0eq0atwWdldfrXjY2KysskS9Zk+aIL5V
   3DUUXwz342ciFhfDzeteZzS2ufmWxTOI+ZzAUBPgfhEd4olLAZpx+89Bl
   g==;
X-CSE-ConnectionGUID: juT5FwJ0TQG43EU4IJVWYg==
X-CSE-MsgGUID: Da56lY9jRzGzTwsWKkCoaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="83148833"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="83148833"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:26:43 -0800
X-CSE-ConnectionGUID: Yvfy4bqCToKsi63gKse5NQ==
X-CSE-MsgGUID: Zt9AuAxSSbeeydD0LfoI1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="221483964"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:26:43 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 10:26:42 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 10:26:42 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.49) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 10:26:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAAtMuHEbJxvrDhDeuwpEdFmusZz4li/bphBfsa3JyFzdGdof+VoIb87emsH+NI5CewokYE6Rk/3MSOZTM04JHqZP4QMspAR9gv+yr1qXyFLYlOcgLjb505JTEkqvUHIOVAPHt/n8IlzZ/D+b2KdvXsvezxoeHSi9CVqwp3vpB6WEPYuLsYQqazxPbgr0lOpB0RBDXDlTj3/K1+nGwZZsOoULKBku9YbChnyIIdpg6ZDtnj1P6yncw7vBFbn/CGbdoBvDsIqk4vpNUG7h3h8ZVJcptRsS3j3NgLkUdzvIytilDBC6jPNQQBee8FHgUS4TuXplQxI8IOrmK1GzQCXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0ucjVM05MeJZZSJX/hci8a2N7mzLSokTx7b1lHnYZs=;
 b=UrvIBO3uQnhHruUL+x5+Z41B2uVMWA4H0HKp2gDk82y6PjTwf59oRUoIIAacLmV2qQDxwK3aYdl1BOVmUNSUyKILXY58KsgD6qU3TP9xqZDR2XcgpNYqCUGuM+n0PGP0Q4hjTWwbtBXUGE9k2Ff+rNSrdkOxFRJGPwIVHYs4LCw506fw5Yeq4tvpwMBtt6DtQjEu8NlSNZCHjwAABiBRRbANEj5EUiSMPdBmkLHtDIDldE8VUc28FJtNgZRzfMxmae+n9nVRGPio8IbOtkPat+1edzbEBudQ54OcbHW5xM39cyaBfTVwgat6Cny9F1/OBlOq1lAGaQcB+gicHRoGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 18:26:39 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 18:26:39 +0000
Date: Tue, 18 Nov 2025 19:26:31 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>
CC: <netdev@vger.kernel.org>, <csmate@nop.hu>, <kerneljasonxing@gmail.com>,
	<bpf@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Subject: Re: [PATCH net v4] xsk: avoid data corruption on cq descriptor number
Message-ID: <aRy6V4s6stJ2hGJt@boxer>
References: <20251118124807.3229-1-fmancera@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251118124807.3229-1-fmancera@suse.de>
X-ClientProxiedBy: TL2P290CA0018.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: c3e413bc-a815-42b4-5a7b-08de26d003b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Li5RK/De6atz4yp7oc/afed1kclcKmAR5ENMhCLEw83KgFvO9w/I6rgJ0MBO?=
 =?us-ascii?Q?NpHVeMpCf5ZxvGJrJhMaGnnhf/Q8R0dTtg9xPLc4HWUNTbUCRIRR+rKaYmRe?=
 =?us-ascii?Q?VQ4gYKBq2LDz/MovL8dqjmlqHDAlNJovTCMj00Tp5zhizYqAy5ppvKO3H5jD?=
 =?us-ascii?Q?IUqF0lGAA9s64deSeCKCWQbehfx1qZ8PdSB5el3XGyHU6w43Z1u74jbRZOE7?=
 =?us-ascii?Q?4ZjiIelP4oybGgd2WoKeSSCi3U2R/ubs06s8yqGZ3nPt5dFZlVI8Bjwpa8v2?=
 =?us-ascii?Q?bdR33+l1kZzyRzU8Fp7Ni8wTkA4o7eHLx06cHS8n+NsLJTycH0sGG1W3KIMF?=
 =?us-ascii?Q?oQXiHTAbHsELpOv5oo7xZCOEWfj1hLp1P94JwUFEbWDdHbk2XUxunQQPXjfo?=
 =?us-ascii?Q?1sR9uHPp9OZqqmuAS0Si13bMqgaTSXgFKsPfuOta9Xeb4D4EoN1rlWDGrGAh?=
 =?us-ascii?Q?bWuTBWZw0A0g3sKdbSTmJBPLZ0BgbGYq32ZUJqVgiR2BU9fMyNPhGqY+fY5S?=
 =?us-ascii?Q?hGisAJTfeDZXCYOSST+9IglvyKysbOPkZLqVj7GaYi/r0Ydu7cAzBVkIxQRf?=
 =?us-ascii?Q?ZLIrSfRH5KNRLXhMjSbnhVs70YOIQMotE21uXKZ7EU7ibfiIZVI9nzrD0c8s?=
 =?us-ascii?Q?OHeWAki4feF8aASp61aUjGnvGIVqrKYlgIpyNEaydfmHT26+nWmOlBJe7VVW?=
 =?us-ascii?Q?P6fYQzvBdLGzwlghrHQznaEo2I+qSIeRak/cGKtp/tSVxcmo88b7qV55uCtf?=
 =?us-ascii?Q?KUlrHRPO+e6cFhNP6cpW59UsJeIOjUDZWS2X5IYPNAPAMljG0lcRban53rqj?=
 =?us-ascii?Q?3irFgd683d476V528Ac76/wuKh9lNuLgcvivYejSH4tE25GJ6uW6ZUCduuST?=
 =?us-ascii?Q?x93DSRLglTRfJZCdgPOv7rDnyZAUGa1vni/oQ/vLyDQFYVRlhSllMGuAaMxH?=
 =?us-ascii?Q?31+Lxc0JGVH0WN8sMhAj7liuON4D6gJ6lDnRCw6rMGjNQKmNLU6Ju7U6zY+f?=
 =?us-ascii?Q?AjVEUckMiBwIzDPu4HhjKuzeMExkyvHQBeTAicLxz84r0Eupk6Hy+y4dcr0r?=
 =?us-ascii?Q?RAbMX8QolgJthTB0zoOa1V+SLZzccmAAG/Ge7ZZ5i5nUUDb7E4ydYQ5uzXdS?=
 =?us-ascii?Q?rUr/uHbbUnVZo/W8mNrTz+OyRSckyZ2P62w5Pr63mdt9kwsgZhFwyk45ceB6?=
 =?us-ascii?Q?twkcitKW8DSY+580IVQyqFftOWKc+W1eutUGt6BpRKlvN0JvgU3tNW3O4+0u?=
 =?us-ascii?Q?Wvdeu5M4/Lc3/nc3LfiSKY7LJ6xLoipK5afL/k7xBhQd6SNH94/XZrkddazs?=
 =?us-ascii?Q?yTM0a4dWNTQWKSWDQiVDlkOvPPw9DGPf1aQ3U56Z2boP7NzbQsA33AyNwKes?=
 =?us-ascii?Q?xnfBK5rvJx/Agt8taWFALa8LkdLSdxstyV+YpXJUgiZHgh0CpA/9Iwec5+O1?=
 =?us-ascii?Q?i/Pl74Afgjv4TniTHO9rx9stNlcsfFyxoLJbTvMcJj/TA6d9VftRNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xBr2WigME4FYc8QQsywInWkRVOXul+/biw+99RlSr8nmHMZek0ZkHdFsqjVU?=
 =?us-ascii?Q?rjaaHY/VRGUlAENCW6bRIfK5ufWdrnFrgeoHSQt9uur6l74zn7pm3fCtpA81?=
 =?us-ascii?Q?3rB75VXn7oM9dEIwxMv+42KJB22u113wJStoPDWW/05fzXJWpRk+jNftSQvj?=
 =?us-ascii?Q?fDlLQ6E40jpSl2gZy2qJEWkfNzVv6f+RhFnVvMjXRVweN/ix5jc9FwjWfeg/?=
 =?us-ascii?Q?OTGHFHkctHI+BmNhz+BYgFqLreWXq5QZtmKhNocu7v078qkB58nT/aY4yhu0?=
 =?us-ascii?Q?ptXOLe9BVghq7apdTcybYuLoL7595PTaHANv9gpLHK1C608x2OqAn5f4zpR9?=
 =?us-ascii?Q?bOwJdToruOKLGaTfqNo4utqEahTzFWH57BjfNKLs6qT3JKRabZYx0qIX1OY6?=
 =?us-ascii?Q?wVJoJTNSMg5Cq0K4cM20PBWOqq+27Hz/85L7HlA02EhCAi8fH6DOkfWbulUD?=
 =?us-ascii?Q?wfGmSFwPlGMvEBXmWk8vib0OsBv6ZUoMlU3sVlIQDzVUMTPf3BMHDc5nyJRu?=
 =?us-ascii?Q?aRibisHhavnsjEG/dpe+U+EjLfz6JsaDwufq1itluud+sxU7n89T9HhyHh/9?=
 =?us-ascii?Q?WTganuek25nJ/wuVFNufSoRiTqDvTZK4lYUJTInOGmtHbrYkvckAmn/J/D1U?=
 =?us-ascii?Q?/Zvl013tyqQtJOJ2n/MuyvTds49jAbrzTtkBDvhA4r7uXCBzU7q5VC+GuSUr?=
 =?us-ascii?Q?6llFsUaJYyy+skZyxYOhxu3y/xVyzM2fa3hLnifC183F1DMWN0HqY7r3WMBO?=
 =?us-ascii?Q?r8h966S5RwVbtxlhz+MmIfjq+gtYDe0/3hh6aWE1l36pXtwv1z7iUiGur5T1?=
 =?us-ascii?Q?YyemN80Cdun+TIWy7qhdY9h1832pyaUyKOfcUjeRzlO4CP1BP5JNndm6J9ht?=
 =?us-ascii?Q?MAwqePapkO4fniCVzcdqE/VnKJwwPVzyiP+yG7pdt6utC/6MGNM83orI1AP2?=
 =?us-ascii?Q?Njludbtlt2t+u7n589oUyPogum2W3PCmYbjf/y13Wy1JTa6eNcx0hBxGId8J?=
 =?us-ascii?Q?zSBppkIWQoSsvSV3LJYaOIb3qVLhGxYUBm8wizQd++kmbuXlzOxr3Jg6axsI?=
 =?us-ascii?Q?+4vwHd8BF0eGBjQbiTOHXyvQa020aXr/XVmRv/ZeDhYPHlwvKHg3MEOjDDPD?=
 =?us-ascii?Q?x556yi99z1jMN+y/wBHRlru5ocCK4RjcZx2zVaKi4ONgQsepYpnIwV2YJrZw?=
 =?us-ascii?Q?P0UvHecpOWYh1MtNOSE0+hpHw/f7MlkO9VLzi1wP9z+IvsAKeT6wvhcv+aTA?=
 =?us-ascii?Q?r9q99xqfhQMg8p6Wff+bx6/AIKmLzQcK3cQ8A+GnH3AcEPTR//O8X6UbX6p1?=
 =?us-ascii?Q?GLHBcKZD5+t4jXL0se9THsb9eJZ+/rMiOu3yxHmr3c79Ldvm7sSSHezaZzNP?=
 =?us-ascii?Q?J90gIvzJAv/M2RVfHCI+9VjRDGNGEx/d2oITKYBhhb75DSxT/UhO/Jzh3Ut7?=
 =?us-ascii?Q?IBiUsBU4LLL6aD5HDeLIN6Tw0PROL7j/MIFZuLZe5yeP9oCsei+CEBV2DsJ9?=
 =?us-ascii?Q?XEEQTmEBBodWdnfbeqFWHjjWhBA1D0DDutqYugxdO0QLj0DbfnRBRyTLj5Vc?=
 =?us-ascii?Q?PDk5tX6oU08vS+u/hVBFg8HUrcF3qepR/97gZXjGktvjJBEJr3cAk/v7xneO?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3e413bc-a815-42b4-5a7b-08de26d003b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 18:26:39.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/lX6LF4pur1J35Alf6klWBwRNXCzzj5RyMCk8+HJDpihrla+2Ne0bSW4Ehz/MbsZehhZJQoIi9Kc6lg6VKXEl1Advj6U3UPSJ0532Nql0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7752
X-OriginatorOrg: intel.com

On Tue, Nov 18, 2025 at 01:48:07PM +0100, Fernando Fernandez Mancera wrote:
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.
> 
> skb control block shouldn't be used for this purpose as after transmit
> xsk doesn't have control over it and other subsystems could use it. This
> leads to the following kernel panic due to a NULL pointer dereference.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP NOPTI
>  CPU: 2 UID: 1 PID: 927 Comm: p4xsk.bin Not tainted 6.16.12+deb14-cloud-amd64 #1 PREEMPT(lazy)  Debian 6.16.12-1
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>  RIP: 0010:xsk_destruct_skb+0xd0/0x180
>  [...]
>  Call Trace:
>   <IRQ>
>   ? napi_complete_done+0x7a/0x1a0
>   ip_rcv_core+0x1bb/0x340
>   ip_rcv+0x30/0x1f0
>   __netif_receive_skb_one_core+0x85/0xa0
>   process_backlog+0x87/0x130
>   __napi_poll+0x28/0x180
>   net_rx_action+0x339/0x420
>   handle_softirqs+0xdc/0x320
>   ? handle_edge_irq+0x90/0x1e0
>   do_softirq.part.0+0x3b/0x60
>   </IRQ>
>   <TASK>
>   __local_bh_enable_ip+0x60/0x70
>   __dev_direct_xmit+0x14e/0x1f0
>   __xsk_generic_xmit+0x482/0xb70
>   ? __remove_hrtimer+0x41/0xa0
>   ? __xsk_generic_xmit+0x51/0xb70
>   ? _raw_spin_unlock_irqrestore+0xe/0x40
>   xsk_sendmsg+0xda/0x1c0
>   __sys_sendto+0x1ee/0x200
>   __x64_sys_sendto+0x24/0x30
>   do_syscall_64+0x84/0x2f0
>   ? __pfx_pollwake+0x10/0x10
>   ? __rseq_handle_notify_resume+0xad/0x4c0
>   ? restore_fpregs_from_fpstate+0x3c/0x90
>   ? switch_fpu_return+0x5b/0xe0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   ? do_syscall_64+0x204/0x2f0
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   </TASK>
>  [...]
>  Kernel panic - not syncing: Fatal exception in interrupt
>  Kernel Offset: 0x1c000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> 
> Instead use the skb destructor_arg pointer along with pointer tagging.
> As pointers are always aligned to 8B, use the bottom bit to indicate
> whether this a single address or an allocated struct containing several
> addresses.
> 
> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

you haven't include my ack, so:
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> v2: remove some leftovers on skb_build and simplify fragmented traffic
> logic
> 
> v3: drop skb extension approach, instead use pointer tagging in
> destructor_arg to know whether we have a single address or an allocated
> struct with multiple ones. Also, move from bpf to net as requested
> 
> v4: repost after rebasing
> ---
>  net/xdp/xsk.c | 130 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 74 insertions(+), 56 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7b0c68a70888..d7354a3e2545 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -36,20 +36,13 @@
>  #define TX_BATCH_SIZE 32
>  #define MAX_PER_SOCKET_BUDGET 32
>  
> -struct xsk_addr_node {
> -	u64 addr;
> -	struct list_head addr_node;
> -};
> -
> -struct xsk_addr_head {
> +struct xsk_addrs {
>  	u32 num_descs;
> -	struct list_head addrs_list;
> +	u64 addrs[MAX_SKB_FRAGS + 1];
>  };
>  
>  static struct kmem_cache *xsk_tx_generic_cache;
>  
> -#define XSKCB(skb) ((struct xsk_addr_head *)((skb)->cb))
> -
>  void xsk_set_rx_need_wakeup(struct xsk_buff_pool *pool)
>  {
>  	if (pool->cached_need_wakeup & XDP_WAKEUP_RX)
> @@ -558,29 +551,53 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
>  	return ret;
>  }
>  
> +static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> +{
> +	return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> +}
> +
> +static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> +{
> +	return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
> +}
> +
> +static u32 xsk_get_num_desc(struct sk_buff *skb)
> +{
> +	struct xsk_addrs *xsk_addr;
> +
> +	if (xsk_skb_destructor_is_addr(skb))
> +		return 1;
> +
> +	xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +
> +	return xsk_addr->num_descs;
> +}
> +
>  static void xsk_cq_submit_addr_locked(struct xsk_buff_pool *pool,
>  				      struct sk_buff *skb)
>  {
> -	struct xsk_addr_node *pos, *tmp;
> +	u32 num_descs = xsk_get_num_desc(skb);
> +	struct xsk_addrs *xsk_addr;
>  	u32 descs_processed = 0;
>  	unsigned long flags;
> -	u32 idx;
> +	u32 idx, i;
>  
>  	spin_lock_irqsave(&pool->cq_lock, flags);
>  	idx = xskq_get_prod(pool->cq);
>  
> -	xskq_prod_write_addr(pool->cq, idx,
> -			     (u64)(uintptr_t)skb_shinfo(skb)->destructor_arg);
> -	descs_processed++;
> +	if (unlikely(num_descs > 1)) {
> +		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>  
> -	if (unlikely(XSKCB(skb)->num_descs > 1)) {
> -		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> +		for (i = 0; i < num_descs; i++) {
>  			xskq_prod_write_addr(pool->cq, idx + descs_processed,
> -					     pos->addr);
> +					     xsk_addr->addrs[i]);
>  			descs_processed++;
> -			list_del(&pos->addr_node);
> -			kmem_cache_free(xsk_tx_generic_cache, pos);
>  		}
> +		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> +	} else {
> +		xskq_prod_write_addr(pool->cq, idx,
> +				     xsk_skb_destructor_get_addr(skb));
> +		descs_processed++;
>  	}
>  	xskq_prod_submit_n(pool->cq, descs_processed);
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
> @@ -595,16 +612,6 @@ static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
>  	spin_unlock_irqrestore(&pool->cq_lock, flags);
>  }
>  
> -static void xsk_inc_num_desc(struct sk_buff *skb)
> -{
> -	XSKCB(skb)->num_descs++;
> -}
> -
> -static u32 xsk_get_num_desc(struct sk_buff *skb)
> -{
> -	return XSKCB(skb)->num_descs;
> -}
> -
>  static void xsk_destruct_skb(struct sk_buff *skb)
>  {
>  	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> @@ -621,27 +628,22 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  static void xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
>  			      u64 addr)
>  {
> -	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> -	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
>  	skb->dev = xs->dev;
>  	skb->priority = READ_ONCE(xs->sk.sk_priority);
>  	skb->mark = READ_ONCE(xs->sk.sk_mark);
> -	XSKCB(skb)->num_descs = 0;
>  	skb->destructor = xsk_destruct_skb;
> -	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
> +	skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
>  }
>  
>  static void xsk_consume_skb(struct sk_buff *skb)
>  {
>  	struct xdp_sock *xs = xdp_sk(skb->sk);
>  	u32 num_descs = xsk_get_num_desc(skb);
> -	struct xsk_addr_node *pos, *tmp;
> +	struct xsk_addrs *xsk_addr;
>  
>  	if (unlikely(num_descs > 1)) {
> -		list_for_each_entry_safe(pos, tmp, &XSKCB(skb)->addrs_list, addr_node) {
> -			list_del(&pos->addr_node);
> -			kmem_cache_free(xsk_tx_generic_cache, pos);
> -		}
> +		xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +		kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
>  	}
>  
>  	skb->destructor = sock_wfree;
> @@ -701,7 +703,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  {
>  	struct xsk_buff_pool *pool = xs->pool;
>  	u32 hr, len, ts, offset, copy, copied;
> -	struct xsk_addr_node *xsk_addr;
>  	struct sk_buff *skb = xs->skb;
>  	struct page *page;
>  	void *buffer;
> @@ -727,16 +728,27 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  				return ERR_PTR(err);
>  		}
>  	} else {
> -		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> -		if (!xsk_addr)
> -			return ERR_PTR(-ENOMEM);
> +		struct xsk_addrs *xsk_addr;
> +
> +		if (xsk_skb_destructor_is_addr(skb)) {
> +			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
> +						     GFP_KERNEL);
> +			if (!xsk_addr)
> +				return ERR_PTR(-ENOMEM);
> +
> +			xsk_addr->num_descs = 1;
> +			xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
> +			skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> +		} else {
> +			xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +		}
>  
>  		/* in case of -EOVERFLOW that could happen below,
>  		 * xsk_consume_skb() will release this node as whole skb
>  		 * would be dropped, which implies freeing all list elements
>  		 */
> -		xsk_addr->addr = desc->addr;
> -		list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +		xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> +		xsk_addr->num_descs++;
>  	}
>  
>  	len = desc->len;
> @@ -813,7 +825,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			}
>  		} else {
>  			int nr_frags = skb_shinfo(skb)->nr_frags;
> -			struct xsk_addr_node *xsk_addr;
> +			struct xsk_addrs *xsk_addr;
>  			struct page *page;
>  			u8 *vaddr;
>  
> @@ -828,11 +840,20 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  				goto free_err;
>  			}
>  
> -			xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> -			if (!xsk_addr) {
> -				__free_page(page);
> -				err = -ENOMEM;
> -				goto free_err;
> +			if (xsk_skb_destructor_is_addr(skb)) {
> +				xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache,
> +							     GFP_KERNEL);
> +				if (!xsk_addr) {
> +					__free_page(page);
> +					err = -ENOMEM;
> +					goto free_err;
> +				}
> +
> +				xsk_addr->num_descs = 1;
> +				xsk_addr->addrs[0] = xsk_skb_destructor_get_addr(skb);
> +				skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> +			} else {
> +				xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
>  			}
>  
>  			vaddr = kmap_local_page(page);
> @@ -842,13 +863,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE_SIZE);
>  			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>  
> -			xsk_addr->addr = desc->addr;
> -			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +			xsk_addr->addrs[xsk_addr->num_descs] = desc->addr;
> +			xsk_addr->num_descs++;
>  		}
>  	}
>  
> -	xsk_inc_num_desc(skb);
> -
>  	return skb;
>  
>  free_err:
> @@ -857,7 +876,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  	if (err == -EOVERFLOW) {
>  		/* Drop the packet */
> -		xsk_inc_num_desc(xs->skb);
>  		xsk_drop_skb(xs->skb);
>  		xskq_cons_release(xs->tx);
>  	} else {
> @@ -1904,7 +1922,7 @@ static int __init xsk_init(void)
>  		goto out_pernet;
>  
>  	xsk_tx_generic_cache = kmem_cache_create("xsk_generic_xmit_cache",
> -						 sizeof(struct xsk_addr_node),
> +						 sizeof(struct xsk_addrs),
>  						 0, SLAB_HWCACHE_ALIGN, NULL);
>  	if (!xsk_tx_generic_cache) {
>  		err = -ENOMEM;
> -- 
> 2.51.1
> 

