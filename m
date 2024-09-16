Return-Path: <bpf+bounces-40002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B202D97A502
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 17:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA64291675
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 15:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA4E158853;
	Mon, 16 Sep 2024 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLdzBrwt"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231615747A;
	Mon, 16 Sep 2024 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726499626; cv=fail; b=Z4tqRzPCOOJhwaRFvWFq6HNxK/pSlFKtJBE+miHMqOxxX1YTatEw6lTPosHpGYl5xyauT4Nq2sqDU2Ti2a4zGqNs+ppHei/6+ns2QXoQA0TUOtJXlAEafwONn+JoPeYcncOF+PqZBQ9FmGQNHU5t23X5B5ea/6cUrZ/FeAG+2Tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726499626; c=relaxed/simple;
	bh=Kyt9Oo6TXYzGlg6lCKWSG9T3p+HUhM+nub21ejdwEuc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tVDsVoF6zPd8OkSGaVRwlFNAKJKUIf/8MZ4eJfQxgIp9gKIKgA4ZWmGO8+RGkARXk8lZ+SpKAQrSjSJwCyJvj0uTtxF+7RVuhtdBXqtx/YO387t31PB6lC1pqCbPISCx5UNUjshNk/NRcKrzDzxSTeOs2QgwQfp/VT+GUJNBs9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLdzBrwt; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726499625; x=1758035625;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kyt9Oo6TXYzGlg6lCKWSG9T3p+HUhM+nub21ejdwEuc=;
  b=OLdzBrwts+fab7T1iIN58X0TXAQKmi2bIGCagg5qhMMR7fXb1PY1Vpyr
   QHEnHGx472eibqkFTwS+NwC8mz8dWOQ8fUPDiiGhBTLFqKW2KWM5N6wez
   qRpNz6OKJoLVNfqy4sdM5FjRVX/Q/uXmgrjOLRo5kZJSBbx/6ialrAkLg
   Z6V/537B66ONF9n6WeXiTjELX15/hfj4k741LmFNshjtLZB11U2Zoxeog
   zDfAl4NAsLWZ4XyarAxc5x4rwXaEBLtkAubv8s/qGjdsNlUE+TTqAsdRb
   n2rMgYhx4sZ34lS3/vOlL94AkL6s0q3NPJsdZlKiv6k0dnIwhDVQv48pr
   w==;
X-CSE-ConnectionGUID: GATTpOuVS4WNQMvcs7A7cg==
X-CSE-MsgGUID: lKkmsYt8Tjq6E4ZxUNjFaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="28241343"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="28241343"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 08:13:43 -0700
X-CSE-ConnectionGUID: 3WBHoEzpR7miOvDwAl2dIA==
X-CSE-MsgGUID: daxkdDlmSN6eO/Bo6JHl6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="68864436"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 08:13:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 08:13:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 08:13:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 08:13:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 08:13:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8/x4KP4ajRQO21/074DGHA8m5RZ62wb1uuU+ggHFrmAeJxIZtskJnMybk/38IzzXercLjz83kz90NgDJDEWYbQJiPt9mWP2OEnuqYpll3NNdFdCDjZhj5HX+Os+5XyNA/lg7Bbrbtm8KbjEj6ch7Z5dM4VAgHtauOfogq/sbEfBqEoTT1RCHUxGXoD5mWXNHjaT2dTjpXAbWLl4RlYNL2kwgrgSEHBTwjMmA0/C8IcYV1L4QynEAp+GQuyuoI627N1g2q+Dbdp3A2xKZ50Reu76+wo/arow5hOTKxMU/PPhpCch3a6V9RGQpC0/PLg5wIJ0iFAYWJJvZF7OL+eu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgpApaTn9/A/Aq4QmFxrB29/9uUd8iNFTjiturUbjeY=;
 b=KkbEJ7gsJ9YRj5+DT5w/OUwpfH/w5k/9ETPVNZBBt4DfqnAhCH1mvSbxdz4+l0bx+amxgItykxo7rMiIbME35JNitmiqYQ5NCc+swvNi9Lv0wH+1LLZmXqHUI91ShgCRgeABup6EZtG0R1CJgreQHNLKna6G5LdRj797fnmHAXNd5Za1deL8N30pl9rx9RKG21BCXq6Hr7hrwgRdsxnGpumUHiVxG15M/DpKCKtarv+DF5qvwjC9uks2l2L8e5Qfuq3a5Y9RbIYhiDhWiWa7mlilB+MGbbwSEPWN/pbtldIrFobNIz2lhaeG2CENN56H7saZ7r1dJ14vD08fLWOU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 15:13:38 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 15:13:37 +0000
Message-ID: <c5977a24-ba1e-4089-a74e-4b94ca239d36@intel.com>
Date: Mon, 16 Sep 2024 17:10:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT v2 0/3] Introduce GRO support to cpumap codebase
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: <bpf@vger.kernel.org>, <kuba@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <dxu@dxuuu.xyz>,
	<john.fastabend@gmail.com>, <hawk@kernel.org>, <martin.lau@linux.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <lorenzo.bianconi@redhat.com>
References: <cover.1726480607.git.lorenzo@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1726480607.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0078.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::13) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW4PR11MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 328036c5-b599-4c81-9bec-08dcd66223df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE5UZmVqbDg3OTVYSTdmVzd3Ri84SXBmQjc0RkY5cjNzZ1A5TFRCOVY4bTBz?=
 =?utf-8?B?SFVteklBSldYcTB0TkZnWXR1cUR1TitJMFBRMkFvZXlCcXhtTDR6WWl3eUQw?=
 =?utf-8?B?Z0o4QzI4K2hTa3RMTWhudEN3dWlVMTQ2QzFabWNoT05LTXRMVVhzRGk1N280?=
 =?utf-8?B?bDZReDFvTEN2YVpvRno1MjlKSmJTMm8zVHlRTjArajA0SXM0QzJlTXVjdFVy?=
 =?utf-8?B?MW9VOEcrTjdPYTRLK1NXc3Rlb0Qvdno4TWpleVhnTzV4ZFVvRWUzQkROZUdm?=
 =?utf-8?B?bTA3ZndobXlNVE0zTXJqR0tLSXFteEptSkNJZndqcjFxZjdUcWlsSkxlYUM5?=
 =?utf-8?B?bUhsWkRXc2hqQWxkZVJFanEyTEc4d1lGUUt3NjFVQ29tMHRqamlIV25jNk4z?=
 =?utf-8?B?ck55dmg4djA1cC9SSzVJN2ZHMmJjTEhWUWwwKzhvZDV0Z09GbG9JUHhrKytx?=
 =?utf-8?B?SWpaeUhFeGoxRjdhSEZmTkJDRUsrUlo2THV0VkVyaW1jS1NIUW8zclpTQ2ly?=
 =?utf-8?B?dGUwSWZKaG9XZWdHQ3dlR2IzVXlxS0ljRHA5ZTBhZXc1QUJsZ3Q4R05NWnpF?=
 =?utf-8?B?ZlhoUk5MRUljRDFKcDB4Ulh3UUZ4YmtvU3FwaDA3YlMzOTUxYzIwK1hOd1FY?=
 =?utf-8?B?Qk9NT0dVTmRINFlmSmJyYUZtNytveERJK1FtU3NKN2orUDh1ZEgxMmtISW0r?=
 =?utf-8?B?VWFhaVF1SWR5eWFwd0RrenY1KzdDMlg1YXVsZm42cDgvRHdtQ09WZWc1eTFj?=
 =?utf-8?B?Wi9pSHlmYXhidU50aUhwYVhiYTlzZ003Z1V3VE1aUU9IYTM0a24rcThqQ0tZ?=
 =?utf-8?B?Q2xwM3RHV2oxUkM2UzZySG9Jd3pycEhpdGMzdDdUOVAzYTBnN242Vk9FYyty?=
 =?utf-8?B?cmpYWG9lUE9oNVN5SnkwVUl4VUEvMFVzRlh0d0NxZmVkeWpUTWUzVmxIOWw4?=
 =?utf-8?B?eTN5aHpHZFhjME15d2xqdFhiKzdDeXdXak1YRVJDUDlyVlR6dFFZT1JzbTZB?=
 =?utf-8?B?QzYyQkdlQWdXeTNqTm83aWM2R0hvem9UMjhCQ3NGQlBHK2xBUTFOcFdHUVQz?=
 =?utf-8?B?N2wzWjU3T0J4aG9yVW1pRGl5enRqdnhBWFZHVkxJOFl5M1ZSdDFpMlphUE9h?=
 =?utf-8?B?NDlxWHhIQVkrc290S2N1elliOE95Z05wMUZIZDQxQmlCS0VobW9EYzBKTUdo?=
 =?utf-8?B?YWFzSDFQR055bXVVN3o4OU1yQW5jUmZmS1JtcmxyTm42UWZlV3p6QVNVNjB3?=
 =?utf-8?B?L1dUWkJyYkJkUzgwbkl1aFlLQjdRV0RQM2MwU2RmeFhlMk02NnY4QnBOdkVD?=
 =?utf-8?B?Zmp4eHhGSXBFWVcrL2hmL3VjRDUrdXdXQXBUUDVRRzQweU5IV1BtTDFRWlQ4?=
 =?utf-8?B?eW1VREhZRVEydkJnaHFHejdRVmxXQVo0K3k2TGsrRDhCUXpZMUMyRFpGcGNW?=
 =?utf-8?B?WWQzWGIrNEFPVXdobExLbEFDV0xPRGxiZVhQdkhBdndIbmZYazZNZXIwbCsr?=
 =?utf-8?B?UXRyd253K3J0WXBxdnBBWGxhS2JSNnM3QkVYTzFYYndBR2Z4cmQ4TnlYalpB?=
 =?utf-8?B?ajlKUm9FM1o1UlloTTRRY3N5S2hyODllTldPbDVNVVFhLzZLa0lIWVE0ekdy?=
 =?utf-8?B?aGxpUFZqUjE5cWhaejNHU1NyRHNqbGtYZ0dKajlLT2kyMGZTd01KcDVQd0NW?=
 =?utf-8?B?ODBYOUxHMUFNYWFQVmdJWmxaN2ttUjREb0t5OXRnOGJWVWJkWnBYYU9XQkVT?=
 =?utf-8?B?RUZORTMzOHBNMGtjRDN6ZkNNQ1F2ZWV5a1ZkcVNtUFhZTDFkQWZMOVI3WTRV?=
 =?utf-8?B?UXlxRHJxVmowRXhVV3dpUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVNVzhCdUJCRzRJeDBOYUJaQU4yM3hBTnZHSWNscm5KZ3ZLQkJ3dys0UmZs?=
 =?utf-8?B?WWd4WElhTVpuTWJPcGg0ZFViQ1NDb1paamNaNDlKNUpDM1VEMnQrS3Ztemxu?=
 =?utf-8?B?ME1lTEpFbHpOcHBNYk1JU1VVM1kycldINmNZZnVUdUpCM2dFbE9Zeis1dUQ0?=
 =?utf-8?B?YmZWVnB1ckxtSFlJWjM0MFV5azh3SmtLL2lrODVDWWhiQkY0QU1lM2ZXNWxr?=
 =?utf-8?B?WWE4OUgzNmxxNlpleG1kcnR6SHRRYUlsUldhUHNFTnlLZ2tMaHJFQTM0VHg1?=
 =?utf-8?B?bVBDWDArQmVRYVhlYWFoTU9sU0ZJcUlUejdKSmxzaURZdGh5cFE2WENBdlV4?=
 =?utf-8?B?c0Y1YVI4VVEyWUlydUVKUm9zQ2QvTUdDMnViWTRUdkw0VkZ3Z3Y1dDMyUU9J?=
 =?utf-8?B?ZnM2VktTNVZJcWFscU5LSXdpQytXT0puanhya1pwVi83SGF6b25jZDROVUZu?=
 =?utf-8?B?ajEvbDRydEE5ek10M2tOZWlBUThRYmVzWlhHUUZwMzBkMWJzYTlDeUl0M2tt?=
 =?utf-8?B?U0E1bUNaWTVhYnVPeHR0bFc5eFhQTDdWbndremE0emxBMmhyQ0E2MGpXL3Y4?=
 =?utf-8?B?YXplYjhqeXJUUzV1UlVkYjhRMWMvWjdRWVBzYk5qdXhTVk1FSGVsUS9mdENp?=
 =?utf-8?B?Z05OUHArWTF3REUxZkhtYW05YTU5Z3JvS0FnZFVLdHJhcE9WZ29pS1BGLzRY?=
 =?utf-8?B?am96MU5SYThwbGVyNkllbUdlSkhycFo3VlIyNngxNWMwcGJsQzRzajZKT3pE?=
 =?utf-8?B?NkVhVUoreDhMVkpLZWFkeFFrUmhuK0JJSlhJYVlqa3hYREFzSldyTWVSalVz?=
 =?utf-8?B?R20vWXg3SXBMdVpGMEsyLy9URWgvVDZSOWQ4K254bmdMcGhTTUliME1MLzdx?=
 =?utf-8?B?YWszdXVaREVrSTU3Q1YwZkRFampwT1IvRTZGNzlwcnhCWjlmNE5CdW5hamdI?=
 =?utf-8?B?M2J5NkFNeGxUZGFrR2dYNFdWbFJlcEo3OVY0WStVN1orQlpoSWxLM21nN1Fi?=
 =?utf-8?B?Rm8zNkgxbGZiMEg4WWc4M3RRQVpSbG9GZ0srRmFYSHJoK1Q0SllPQStla2lR?=
 =?utf-8?B?c29McEtHUVpYNVd6YklwdHpNZEI3cEdjaXFYT1ExaUJjaGxlVXNNYXk1TnZn?=
 =?utf-8?B?QWMwU0hObDlXTlhTdWluWmlId0kzMkgvLzRvcTBhaStXWFpDbnZBMEMwSENZ?=
 =?utf-8?B?NXFkYXF6emtkcWYvYzd5Ni9vdUFyWWt1ajBvNWI4Wm1rOFQ3b0xQWHNSRk9r?=
 =?utf-8?B?M3UvMW5qWUhLV0VFL3ltVk1yNXJ6TXdETjBQcU5qUVpwWFZDcEZQbFFGdDBt?=
 =?utf-8?B?SE5UN3lwaTJKZ0p4WVM4YWRTMEFqNVo3eEFZSkRTb21Tdk5RL1VVN2ZDczZ5?=
 =?utf-8?B?QTREVjFMMWVBVzJDd2ZNMEhsMFUyREE2MzVsSlRUL3hGYWg2OVJkME56V1VL?=
 =?utf-8?B?RWwzOVFZMmJwYlRHdDVyRVZXbEV3TElqQlhWUHdUdUFZR0gzTjBuamJNYm4v?=
 =?utf-8?B?Mmk5bjlndUFQa2s3VUZ6bXhDMnVzU2ozUE9RZUx5ei93TkIwNTB5aStIQkRV?=
 =?utf-8?B?TkpJcGFLWmlNRFFObHIwZGt3MW1LMGdiSkQvU1pURWxmdDQyVGo3N3Q2STVT?=
 =?utf-8?B?UEVKQXN1WHVpSXpZNm1ERWpUcTd5Sk82UTc3VitYVmtGcVR6c24veHk4L1li?=
 =?utf-8?B?RTJNemZ6ZU5TeG11ZTJRV1d0YUt2aGlmVDJBWURGVjdPTTZzMFNJQ3JJWjZL?=
 =?utf-8?B?eWxkUjZFSldlUzRaZkxWVkl6Y3AxMjkzb3E0cUZMWHZBS3ErWUtad3JHVFE0?=
 =?utf-8?B?NTRLazdBdS9OV1hVaHN1RmN2WVlSc21KMDRJb2hoWlNUWnFpejVuK3JlZ1Fo?=
 =?utf-8?B?Mk4wUnJRSmxUS0k2SXlPZDJ2SHdVVzNHYm03V045aUg1bTRpUEJsYVJUV3h6?=
 =?utf-8?B?eWt1Y25pcno4S01iZTcwbTdTSFpnMnllSzhJQlVHa3NCUWt3SmRTc3Bvd3pO?=
 =?utf-8?B?SmNuNVFvZUhDZmZZTUxEUWJEeXQ5b001L3d1SzN6YUdVYmJtSlc0ZkUwYnRE?=
 =?utf-8?B?T1FQSVI5SmR3YVpKTVV2VWhNeVZVaWtmbmlmWHYwanRJN1Z6ZmFGVU9JMUIr?=
 =?utf-8?B?amloWG13QzJWbGNac1ZuWDJ6dDlmL1h2WTVWUUtORlc2S1FlZzFoQ05YR0h1?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 328036c5-b599-4c81-9bec-08dcd66223df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 15:13:37.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpkS7nN7FdQcfpnzNFXQEkbYFKCA0jGCQRAQ8S86Ne9bHCaJtGmeTd9l6fx0QfkRNN+tTqrbQxEuQTmWuOz2fGAxy9EaVrJy6jjMGzyuslA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5823
X-OriginatorOrg: intel.com

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 16 Sep 2024 12:13:42 +0200

> Add GRO support to cpumap codebase moving the cpu_map_entry kthread to a
> NAPI-kthread pinned on the selected cpu.
> 
> Changes in rfc v2:
> - get rid of dummy netdev dependency
> 
> Lorenzo Bianconi (3):
>   net: Add napi_init_for_gro routine
>   net: add napi_threaded_poll to netdevice.h
>   bpf: cpumap: Add gro support

Oh okay, so it's still uses a NAPI.
When I'm back from the conferences (next week), I might rebase and send
the solution where I only use the GRO part of it, i.e. no
napi_schedule()/poll()/napi_complete() logics.

> 
>  include/linux/netdevice.h |   3 +
>  kernel/bpf/cpumap.c       | 123 ++++++++++++++++----------------------
>  net/core/dev.c            |  27 ++++++---
>  3 files changed, 73 insertions(+), 80 deletions(-)

Thanks,
Olek

