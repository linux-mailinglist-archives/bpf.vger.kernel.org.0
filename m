Return-Path: <bpf+bounces-60622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB295AD93CE
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 19:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808631746EC
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D716C222574;
	Fri, 13 Jun 2025 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tbD0YO+U"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93412132111;
	Fri, 13 Jun 2025 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836133; cv=fail; b=W7htNGKFyNk0FdNsvKgDqWYPNE0BiVODaxc0ni/JnFmFSHg/CrHF/pxa2CoQ0GmlsSuqsS6UErQUQ6fbfqMnB9JpolWsgLz5vO4I9h4y3e2dJ/QY5kCPUmRFfiwb+F3TQL1VxkIkICSUM7AR05Ixf8TiXrGlNOWmRJ0951X/8SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836133; c=relaxed/simple;
	bh=LpZaHfGO4rwQwA62pqUFyh97Mcq1zLMnlN8bMNZfaBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlkdaRMQeUjncBkcfDXkU/vYevrfopnedYmFhpMvBrc/n3PLkp0AvPQzTepRLjFarW2hXSKGMW7dzSAjtiJPY/tUVWHO/WtCdr2mcm44c+WjFmNOL8tuqXQL7iPHuVCS0iUpUnbXWqrID7ar7RZ9yC25GSgDvE5fKaM0m67aVKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tbD0YO+U; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIxAGLpPgt5OZl5YvRkjeCRpBVs1TMlzJH1h5SIc3i3ggclinNXJl+ByrK0DSW3v+EX9IFnWES/kMZLL2ahegdMVyg+N9sWTAFhGwSBiSRJ8a7AffYE3Y+96ZDnBM2bO/qc7MxNe0AruLJWb6rkvMSOB9BTEDmzPOQ6HG8tZfhXKoxQYwhi8dn1UhB/khYDAEDNAQdkWz/y7QxEBtYZVs7vFtEP5wWJrmQzPNnBOy6+SmilrO8zMDwMCacCzmKJ74aakkIlT8GRBoRDtMIz8XHWtOGWh49nvW5llSNKy9+pdDwDlUcMmGZPNLZWqwmzueHGWnASmtUzQ9+YJrBo28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cINPyb2NTHR88aD711CjKx1Vz1pFkDrT453wsJ6uI8=;
 b=ICy8PRGOjIPDpQ+LxPuUUuL+4PgLyUvdLRYqW8SW1e6rSwRzhBl9EFdrsJqQOmq7odZOggeCb9HVu7NRULH1pC3P+2lGXClNnvePoodrvIi7VMDMGAH67y8lBUMBRb4GvaqPD57eyE7yfYEvoDzicUfx+7w+bx6dUyMrYsEGykXGjLtsaHdT6QkmzVxoCii3mP3ParAfRqUZndjKPuKy2HlhWlZKKcJHWiRtreHs1X/z9P+Zgugnn9U015jlXtmo3W+F+RFroP0syz6mfmcsXoubIDcBeWJjh+mKUxzJADFr2bXRMRX3QT7RQe6hgpYlT9oe08ok8BhMMVK9lHr2MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cINPyb2NTHR88aD711CjKx1Vz1pFkDrT453wsJ6uI8=;
 b=tbD0YO+U+WAbCBxqNpmWbbCl9XZvYtC7HSCosOLZ8Bla5F473pfhYRRBj9vUQfHTfeuR8V6UZa5rlWw4b/VyBCQyR+ujPsRX4WupNJwptNZ4GqqM1gLpAdFpV0dCtBmOTxYefXuwqfHg88o6+vIm5tX9dtvK6b8PqQ84a4XtPih+muCcOI0I+Z76LMBxgCaagGUFCrptrfMRsCQH7ao9s6XgrUT6y2BY6MYg8V9MnPo4vw6jdlcLnm32JlSjXkU+CpoNv0uY4Ix5kq74TooPNqma/mkNsF2Aq+S30Z4N0GNtcrPdsjZ0YVRVxpnrM/+vLqDOJbC+qSoIEBzYscmaZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Fri, 13 Jun 2025 17:35:27 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8792.034; Fri, 13 Jun 2025
 17:35:26 +0000
Message-ID: <a8200977-689d-4041-936b-3a92eac1bbe9@nvidia.com>
Date: Fri, 13 Jun 2025 13:35:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add a deadline server for sched_ext tasks
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 bpf@vger.kernel.org
References: <20250613051734.4023260-1-joelagnelf@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250613051734.4023260-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:208:d4::15) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 936606e4-c73e-4b34-7f9e-08ddaaa0aee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2RZVWFUb0lidGNYdGhzL3NmaGNDS05SZk8rT1lCd0M5SitWWUZBV0d1R2RZ?=
 =?utf-8?B?a1ZndVNPZVd1TXdOVGxRV0lTMjVSMHBVek5hajM1YVE1VWp6djZpRmR5cldU?=
 =?utf-8?B?MWxQbnhRN2RrSVhlL1RkV3pTZUZVTm90UUU5SXV2MENLUFFjMVZDVVdsem14?=
 =?utf-8?B?MytkZTlBL0JqaXpsOGc3QXNtQUdWZTVqZ2pSa01jcVRCdTdQcVFLRDJoOCtM?=
 =?utf-8?B?emQ4c3RQclFaai82NjB1OUx6T0x6ZFdCN2NXV3d2bTZ4SmdpVURuVEprbjNY?=
 =?utf-8?B?dmVOUmJTMjllejlXYUF1VXBZL3kyYit6NmQyc29hUzlOVDJvZk5GTWxzdDA2?=
 =?utf-8?B?WG9kazBDWXNOQnRRSjl5K3UvMm9aQVVYTVJnSStKa0NFKzQ0YjdJNmRNTGxw?=
 =?utf-8?B?VWlZT09XRThMc2ttanpEMGk5QmVQeFFyRWdUZG5BeEtGVmJFc3RlbVdUdWp3?=
 =?utf-8?B?d0FaMEdKTkNaNmIybStCRHlUVGVTNkdlNGtaNXlVSmpTZ3gydXpINStwY3E3?=
 =?utf-8?B?dWpmYmd6RjNUUCtZdExoc25OYmlvUUhjdEZXRUVHdHR1MUZ6b0YzOTRtRVVY?=
 =?utf-8?B?NVJtQ01XQ05BbnRCKzFibDJ0RTRITE4wbVJrQzdZUTBSeURhQ3FSL0RWUU1W?=
 =?utf-8?B?T1pScHJBTFNCemRqYlcwNEQ5cWw4OGMwcmlpSVE3dEo0Tk1peUxGb2UzVzZC?=
 =?utf-8?B?WFh6MG9TRllxYmd0UkV6WEsvYkVnZWgvMHNIR3VRUUJ0R2M5ZFlXdlk2Q1Z6?=
 =?utf-8?B?R2gyTENkb205VXE0d0Q0TUY0TzZrUG5WYlhIN1JPZnNqS0NybSt1NkRwZ2tC?=
 =?utf-8?B?VFRTTjhwd3FCTEIxMEFMdVZKRk83Q2NnKy9nRGExSnVsTnpBY01WeGRmY0E5?=
 =?utf-8?B?cE5jQk1aNkV2RkdCQytzWDllMkprcWRyZXNZR2N2MjhVbzRoRnFpZDJpV1Rz?=
 =?utf-8?B?NkVheGNwSnROeUxCekVPSWtIQ25xckJTaW5LN0QxQi8zUVM2SFdOZm50QXR1?=
 =?utf-8?B?Mkt4QVNRdzBMUmxhZVdIcnlWdWV0OSs4Q3ZRZUMzb1J2Kzh0SmFsN3MxNmh3?=
 =?utf-8?B?Z3N6c2JleTMrRVp4Y1dpL0NTYUZRN09FTW5iUWJMaS9hTktoeXp4N2ptc0xQ?=
 =?utf-8?B?WTdRbDQ1ZkZqR0p0eHRXRHlEQ1JwRkMzUnNzRll6MnI5V2VLZEJQTVBxRWRZ?=
 =?utf-8?B?TG54MzVLQ0VOMVNCamcvcm1yMzlyTjZTRzY4V1BhZTVhc1FJOU1md3Y0MEJK?=
 =?utf-8?B?MEhhYWVDZmhmYUFpZm9NMlBNVHRTNkZaVmw2RmVqMnhPR1k4SkhMUVFjS21z?=
 =?utf-8?B?bkFqa2xVT3ExanVucERDcFRrMCs4L1VKZ2hXaWxubkZGWmZhU0o0cXdZMzQ1?=
 =?utf-8?B?RnJPWnY1YTNtcitoUW80QXllNzJyVE5LcmxBb3krQ2lmTm14Ry9tTlkxcXZE?=
 =?utf-8?B?QzhIZXR5dUJMRExiUzlZeUR0bFV6d29yajZ2ME5NL1N6U0s3ZW1HbThpODFh?=
 =?utf-8?B?bE9WMG1EWk9raUtUWm9OcitHMmtlRng5MXNYZjlZbUdvR1BZbExtVTg5eTk0?=
 =?utf-8?B?cHp5djBDVHJZeDQyelRoU1EwS2tWL1NzUUJqZ0YwOXBtanNrak5EVGNXVlVQ?=
 =?utf-8?B?TUhvdmVoWEpsU1FiYzZrT2tRQ3gvTFFXUERmTUorTHlDamlhSlQ0Ri9jZVFu?=
 =?utf-8?B?V1VUU01QZkQxclMvd3l1cjNnd2NhaENYY2lYcVFhUzZkeTJ3QWJ4K1JkQ0do?=
 =?utf-8?B?Lyt4QnJwVUM3K2hNV2Mya1pycTZ5cTR0aHdVYlViMUNlczBwT2hkZER6SHQy?=
 =?utf-8?B?aGpucGVQRTZMTm94ZzJHVGN0TnBEL1BtV3ZIVWNEVHVQWXpmTDUrdFg4REVG?=
 =?utf-8?B?aWVWdlZEWjFUbnNKWENicmlyWUc2OG9tR0JqeXRPNDkzWDhrWUJiMHNvS3RB?=
 =?utf-8?Q?wGfC1rdntl0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmgyckprNVBYRjFBcm8vRHhKK01aZThXOHJhN0gzcTVOemxhWWZSL1UrWCtY?=
 =?utf-8?B?YzhxTkZXOHBObEVUcGljeGxzcTNTRmFiTmp2eno5VDY2bTFYY2dNc09QNEN2?=
 =?utf-8?B?SjhnU3JzTmtZb3hScEwzQ3pySjA3M0dLeHFScEZRV3ljOVAxQU4wd1cxZVZQ?=
 =?utf-8?B?WkU3ZU1FbG9PVlN6WHJJazVjbmxZZ2h1TS9laHZHRlE0bEVMRVJNK20zeHNK?=
 =?utf-8?B?WEFSQnVuVFJrckdVb3ZLbFhYcFVveXJ3Q29vd2E1MGZhT05PT2pzd0drbTZY?=
 =?utf-8?B?TlBoRFNoVDhGK1hxU0FLbk1WOW5oUGZOR0dmOXpYWk53dlMxOWlxMnU2Q01p?=
 =?utf-8?B?MVAwdmZINmtKMHhobExhV2hDQ0Z3MTlhN3I2S0psQkRDZXlmeEpSY1kwTURZ?=
 =?utf-8?B?dFJJV1Jua0xnU3EvQnZrU1ZTQ0JnV3RaWi9uTGdkMXVkZjdvNnVoOWFudnk2?=
 =?utf-8?B?ZlBTZGNNbVl6SWlIeklGcWhOSCtCdEdVaXUwTm94S3N1WHVrT2c1VE9UK3NX?=
 =?utf-8?B?SVNTTjZoWjVJL05rTVdOSDM0b1dIazIwbEFCM09yWVFZMXM3VG5aTThrTk5C?=
 =?utf-8?B?eitlckRFcVhzUU95ZjlKS0JOOWlMQmwrTnVCeS9OOUw3Z3lSeTlCV1RoM1Vw?=
 =?utf-8?B?K012MFJlSHlJaThkbGtvSU5iUnZHLzNtbWNDZHRIZzZvRHgxUUx1akkzeTlt?=
 =?utf-8?B?ZWtBbFVvWUNPU2dpRE9jS3hzRTA5Q2ZBQzV3R0xOSkNPTUZqUXloR0krZXBv?=
 =?utf-8?B?YktHWkRzcWpMSkNWdEpHLzNMcThEM0ZXSFhiYU5MYnlUbHFXYXo2b2hSYzhy?=
 =?utf-8?B?dTJQTzduQ2dpakRybE9yR3lIVnpPUGJXeExwTUFEV2sxNHIwa2hnejJXZnhk?=
 =?utf-8?B?c0FXWUhzT2xVUHdCQnJ4aTlUR0x3eEVJQXFkZ3g2MFdIK2MwaWVnYU8yZUU4?=
 =?utf-8?B?Y0R3V0dBUnFTRHY5bzFFaHFLcTFwdHA4SjhaSE1vb0d5alM4QjM4cHBLQlNC?=
 =?utf-8?B?Nmk5WHVIQjJrdFB4V1JBdEZTc3ErVTc0K2pucjMxSGFBWE54bkJSNU10a2hR?=
 =?utf-8?B?Z3B5UUQ5ek9ncVp2MWhuSnE3UDBUVWR5enMwL0dJNlhNaENYcmdSWFpTWmlV?=
 =?utf-8?B?OFFEb000Uk9wR0J1NWtmTEJabE1PWGVQd1BZWmZCak0rdXZ3MlpoSENtaU5B?=
 =?utf-8?B?WEx4NFhQbmJsNWVkUDJ0aEVEMEVHWGVVL2Y2TGVJQi9jOExPVU1lWFJvTWNB?=
 =?utf-8?B?UHpqYlBFa0lYV21zVEFheUtIM0NZQ1d6ZlNhb0hVbXFINHltMjZEMnRDeWZ4?=
 =?utf-8?B?MVoxL0lQeEVNeG9jc3ZqN1N6RXdHeTVxZUhmMDFMdGk3SUpnNDFUWjlqNEwy?=
 =?utf-8?B?ay9scnZTTnQ2WXhHSUt4VktadlFsVFY4VUN4NVZweFgvUjVRUU5GRWozTHl4?=
 =?utf-8?B?VUNPZWdkb0R0R1Bnd3cxNlZyWlROSzhLOWZGTitnV3NTL3laa3Jod29tcHpC?=
 =?utf-8?B?TXVaSTVmb0o4UUd1emdpRkpERW8ySjRnd01JVTQ4Ujh6czVJK210Ujg1M3Mw?=
 =?utf-8?B?bUlVZFRIUWhXWEhKekJZREdpdXJqQ29uL1J0RTlZU2ZtK3lHTTRBRXVTVzhU?=
 =?utf-8?B?d2hjK2dqLytPdTdJZVdZRFJKUzVic2JrVE1obU4xSm1NRmNSclhOanFJelFZ?=
 =?utf-8?B?MlNrQUhiTncrY214Z2c0b3ppYnhnUWNNM1d5bGM1Y2Rqc29CR0dzR2FpbGdD?=
 =?utf-8?B?dkpWL1kwZjMrNnlkUE5UQ05QY09aZkF3aEtLOXVwY0xEM0d4aklreE90YS9k?=
 =?utf-8?B?dXBFMGErTm1MSVZYKzhlaFlpVm12ZHdhSHJZUXVpLzFXcFJsQWd0cUxaRGlF?=
 =?utf-8?B?SHA5QWRTR1NaMkJQR3BFYUREbUFyc2h3QTYvL2VzSllJYzNnRVBERFlxUlBi?=
 =?utf-8?B?ajdmbVZCZmVzcnBmUlVRaGg2Y1B4cnB1OFhPdVBsRDJ0YkVVQ1ZUZG9yQUp0?=
 =?utf-8?B?aW1YNHhEWURneVlmanFCWTUxL2R5M0hrYzJkQjFtRE42aE9aRzJyZFMxR2Y1?=
 =?utf-8?B?ZHNFRFIrS29KQ0hqL1hnMnc2VGNEZ2E3SjZsRXVGeEF2ZlU1b0JCUi9SWitL?=
 =?utf-8?Q?9/6P0m46zXZCe+Wfa2hfirjUK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936606e4-c73e-4b34-7f9e-08ddaaa0aee2
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 17:35:26.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHeEW6mRVY/McLifo9hRakhjGpzxX6Vdh4fZIddMHafk4ZURhWfFC0XbKUrdoSbhwtu3AZNcbLCKejrtfGLj6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423



On 6/13/2025 1:17 AM, Joel Fernandes wrote:
> sched_ext tasks currently are starved by RT hoggers especially since RT
> throttling was replaced by deadline servers to boost only CFS tasks. Several
> users in the community have reported issues with RT stalling sched_ext tasks.
> Add a sched_ext deadline server as well so that sched_ext tasks are also
> boosted and do not suffer starvation.
> 
> A kselftest is also provided to verify the starvation issues are now fixed.
> 
> Btw, there is still something funky going on with CPU hotplug and the
> relinquish patch. Sometimes the sched_ext's hotplug self-test locks up
> (./runner -t hotplug). Reverting that patch fixes it, so I am suspecting
> something is off in dl_server_remove_params() when it is being called on
> offline CPUs.

I think I got somewhere here with this sched_ext hotplug test but still not
there yet. Juri, Andrea, Tejun, can you take a look at the below when you get a
chance?

In the hotplug test, when the CPU is brought online, I see the following warning
fire [1]. Basically, dl_server_apply_params() fails with -EBUSY due to overflow
checks.

@@ -1657,8 +1657,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
                u64 runtime =  50 * NSEC_PER_MSEC;
                u64 period = 1000 * NSEC_PER_MSEC;

-               dl_server_apply_params(dl_se, runtime, period, 1);
-
+               WARN_ON_ONCE(dl_server_apply_params(dl_se, runtime, period, 1));
                dl_se->dl_server = 1;
                dl_se->dl_defer = 1;
                setup_new_dl_entity(dl_se);

I dug deeper, and it seems CPU 1 was previously brought offline and then online
before the warning happened during *that onlining*. During the onlining,
enqueue_task_scx() -> dl_server_start() was called but dl_server_apply_params()
returned -EBUSY.

In dl_server_apply_params() -> __dl_overflow(), it appears dl_bw_cpus()=0 and
cap=0. That is really odd and probably the reason for warning. Is that because
the CPU was offlined earlier and is not yet attached to the root domain?

The problem also comes down to why does this happen only when calling my
dl_server_remove_params() only and not otherwise, and why on earth is
dl_bw_cpus() returning 0. There's at least 2 other CPUs online at the time.

Anyway, other than this mystery, I fixed all other bandwidth-related warnings
due to dl_server_remove_params() and the updated patch below [2].

[1] Warning:

[   11.878005] DL server bandwidth overflow on CPU 1: dl_b->bw=996147, cap=0,
total_bw=0, old_bw=0, new_bw=52428, dl_bw_cpus=0
[   11.878356] ------------[ cut here ]------------
[   11.878528] WARNING: CPU: 0 PID: 145 at
               kernel/sched/deadline.c:1670 dl_server_start+0x96/0xa0
[   11.879400] Sched_ext: hotplug_cbs (enabled+all), task: runnable_at=+0ms

       [   11.879404] RIP: 0010:dl_server_start+0x96/0xa0
[   11.879732] Code: 53 10 75 1d 49 8b 86 10 0c 00 00 48 8b
[   11.882510] Call Trace:
[   11.882592]  <TASK>
[   11.882685]  enqueue_task_scx+0x190/0x280
[   11.882802]  ttwu_do_activate+0xaa/0x2a0
[   11.882925]  try_to_wake_up+0x371/0x600
[   11.883047]  cpuhp_bringup_ap+0xd6/0x170

       [   11.883172]  cpuhp_invoke_callback+0x142/0x540

              [   11.883327]  _cpu_up+0x15b/0x270
[   11.883450]  cpu_up+0x52/0xb0
[   11.883576]  cpu_subsys_online+0x32/0x120
[   11.883704]  online_store+0x98/0x130
[   11.883824]  kernfs_fop_write_iter+0xeb/0x170
[   11.883972]  vfs_write+0x2c7/0x430

       [   11.884091]  ksys_write+0x70/0xe0
[   11.884209]  do_syscall_64+0xd6/0x250
[   11.884327]  ? clear_bhb_loop+0x40/0x90

       [   11.884443]  entry_SYSCALL_64_after_hwframe+0x77/0x7f


[2]: Updated patch "sched/ext: Relinquish DL server reservations when not needed":
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/commit/?h=sched/scx-dlserver-boost-rebase&id=56581c2a6bb8e78593df80ad47520a8399055eae

thanks,

 - Joel


> 
> v2->v3:
>  - Removed code duplication in debugfs. Made ext interface separate.
>  - Fixed issue where rq_lock_irqsave was not used in the relinquish patch.
>  - Fixed running bw accounting issue in dl_server_remove_params.
> 
> Link to v1: https://lore.kernel.org/all/20250315022158.2354454-1-joelagnelf@nvidia.com/
> Link to v2: https://lore.kernel.org/all/20250602180110.816225-1-joelagnelf@nvidia.com/
> 
> Andrea Righi (1):
>   selftests/sched_ext: Add test for sched_ext dl_server
> 
> Joel Fernandes (9):
>   sched/debug: Fix updating of ppos on server write ops
>   sched/debug: Stop and start server based on if it was active
>   sched/deadline: Clear the defer params
>   sched: Add support to pick functions to take rf
>   sched: Add a server arg to dl_server_update_idle_time()
>   sched/ext: Add a DL server for sched_ext tasks
>   sched/debug: Add support to change sched_ext server params
>   sched/deadline: Add support to remove DL server bandwidth
>   sched/ext: Relinquish DL server reservations when not needed
> 
>  include/linux/sched.h                         |   2 +-
>  kernel/sched/core.c                           |  19 +-
>  kernel/sched/deadline.c                       |  78 +++++--
>  kernel/sched/debug.c                          | 171 +++++++++++---
>  kernel/sched/ext.c                            | 108 ++++++++-
>  kernel/sched/fair.c                           |  15 +-
>  kernel/sched/idle.c                           |   4 +-
>  kernel/sched/rt.c                             |   2 +-
>  kernel/sched/sched.h                          |  13 +-
>  kernel/sched/stop_task.c                      |   2 +-
>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
>  tools/testing/selftests/sched_ext/rt_stall.c  | 213 ++++++++++++++++++
>  13 files changed, 579 insertions(+), 72 deletions(-)
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
> 


