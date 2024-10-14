Return-Path: <bpf+bounces-41844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507B899C46D
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DAB1C223D0
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 08:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A65A15689A;
	Mon, 14 Oct 2024 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZFsh3v+p"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8C155A5D;
	Mon, 14 Oct 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896246; cv=fail; b=kwN0nj40r8NJMD/r0RnyF+VFySE/qfPC4971+7Ps8jhih7/7NI123vkVWENUvflABh8v5HZZdXr9J0o3mLRMKYOYAdWBiMQr3GZywlm2rTT5Vx6+dsKmPmiKLnfM3/u1xAV8UC8iBZWTOb7ozsm/rFUCFOenJzX78GK/B8MBh/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896246; c=relaxed/simple;
	bh=8xRvAkxYw4K9jwfaTJynFbUCsvne+bEMBCQulN9mkSQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jdxRuZjH1wn3E4xusa7+tj2SlBX6GVuDuGCIwfCYcM0SkJ7U/Qn3HADzRAPebDr1aboF1CLOmUlA1jY+3IAUuJy+ABFWfCCPeL6TmJFQSEFaAY7CBjHebjy1iY2GT+jDT6T7evVVN2/iweyOfJFDf+ognSEW6wTH/7W/3kL6A9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZFsh3v+p; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po1sUt5CbRJmPuDCfMmoaU1vYJyp4eRSUiSF5qqqAk3vM+kNQrjP+FiUvuBg+GBY3O2MHTg3MiG8GUF7vPo8SFRyVUdiBOKlu1QfVjQGCwhHSp92iYnhRyBB1jqZamPSUUQUmmxY5nuuxs7LVOrfl47jZNCWN00zOKGsqpHXXxRizwOwjwQYl0de9W0XCfTklQ7cG11DD413rM68GidG3oivG+Wd+tNYpLPbOhhHlt/mY/2hYyp+tPdF1XCrVM563ucvvv3vm3Mk7ZT8nS+OUHmtK7HQY8l42L7wGEHRfctMIKqjxSiSC4bWV/Hk/RqsiWLXs3hIP9rPrDUfEmQTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lg/HyjoxFTmNnddL1IGgzSo7i/XfJMvq0wgPBiP2HDw=;
 b=gYFtNkTAOmAFKHMSYPbhnbTZhvVfDANebb/GzDSzvnjmYZfUoauKQqsAnivwHHswqDNRGFlzzLUE0+JGpeysUDvVhjiVTJJ+9XoV4IK+Q0HEiB0X1XE/NwIxIeENP09vkq8h4rEsmihO3ucetp82cRXE/C8YuxPCtVhW9G2huYgZOPuZJ6C3/a2hwxqNxaQpnPv8UTMOBK2+leTnuzOaDvstTWsq+Awp9gcXuPFml8RPJ6xuziRvWZgCIoEX2E3nUSdq3Rxlyt6jMm79KAWqPiAFlZovUDJVbfgMmOLj+j2uBGwx8vLNxKBRY8IaM9BZNOaVRcbarQ5sDw1iRVyxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lg/HyjoxFTmNnddL1IGgzSo7i/XfJMvq0wgPBiP2HDw=;
 b=ZFsh3v+peAyIUd4XoLVqvOr9SR80al09Nwl50X1FdI1lFCv26awWkx9DQ9DBvyHLSLCYt33WK7cFLc2GeSv7RJu7UopIJ6IwMFUClJr5hvKf2zCbCz9uWkWCg5ZaZnb4slRF3ni6wcvw3a/S3FAMqjQeLvCGmEq+GmwvFyPivjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.26; Mon, 14 Oct 2024 08:57:22 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 08:57:22 +0000
Message-ID: <e2c1ca52-a690-4c56-aab8-e5f8443e9ec6@amd.com>
Date: Mon, 14 Oct 2024 14:27:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 02/12] srcu: Introduce srcu_gp_is_expedited() helper
 function
Content-Language: en-US
To: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-2-paulmck@kernel.org>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241009180719.778285-2-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::18) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|PH7PR12MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c408acf-0a3b-4b51-896d-08dcec2e376e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1pxK2Jnd3NKQVhVVUxwVVpyUm11aHR3UldRN0N3c05zUUFzUXd4UjdDcjc5?=
 =?utf-8?B?RGp4QmJ1dC9qZzJXbWsyZ0Y5SUhCbVNPaS9WakpSS2kvdFl6cEdlNi95aFZk?=
 =?utf-8?B?Q0huRkIzZUZBWVZuUlU4N2FQNnp6cjNaVG41bXZ6K3BXanVvK2FyOW1hMDVT?=
 =?utf-8?B?WGRBQ2pwcXZ1V09US0VCeXlRR25yOHpmVmM4WWthZlkrNUdxSVBwWDJ4NG53?=
 =?utf-8?B?dVp3UFNTSHNzYURsYTBFSnJwM011djY3cWJMa1R3dGVTQ1F5WWIyM1h0M1RP?=
 =?utf-8?B?R1h3VXh2dWRJMFpDeFY0cFlxVFR4L05HVitZQU9BM2ZVd2xvWjFUaTJyTlVR?=
 =?utf-8?B?VVpCOTFHOGlzbDdmZjJTNWRFbHIzYzFmV2k0YzFFbXJxMnluSzdsT0U4RVRz?=
 =?utf-8?B?WU5vQUZFR2pETy8vRFVVVVVBeVN2YlpMOUY1RklFTU9rbzVEWmZNZXZJRS9h?=
 =?utf-8?B?RkJEbnpXUXl6K0pjSm5vOUJFelpnTy9udk4wQ3I4b3o4cUtjbkR5TExxZGdU?=
 =?utf-8?B?WTN1cmdFZGFkUWJYSDVQcEJFYkF4dGxSN1RhakFVVWVFSjV5K0Y3VUlSK053?=
 =?utf-8?B?Sjc3cWgvV0VCU1VyTnRmS3F2MGMvMW5HNW02NmhHRzMrOTdENmlJSUZRVVN6?=
 =?utf-8?B?STdJOUpxYTFxM1plU2I2VDFNQ2dDODZuVHpqN095SnFvSFBsN1pDZkRWNXoz?=
 =?utf-8?B?RCttUXlSOE9YZEQrckdXVU1kejRjd0JNcDBBUFI5M01ROGNUbVZ1eUY1NHV2?=
 =?utf-8?B?MmtiZURjWGVTUUlRYUlwOFRQN1F1QUx6OXJWbUhOZEorbXZjSE5YSXd3Nk15?=
 =?utf-8?B?NDNwUEtHbkloM2pEZGtVS0tlb3p4OWREa1QrSE5xMXBIUkV6Mm1NTWsrZDhJ?=
 =?utf-8?B?UExDdFlXQmRMVkt6MDRQVXdzRDRDZDhnaHhZVVVxM21teUlGWmptV1dGeW5T?=
 =?utf-8?B?UnRRVWhKOEFwQ3BnNCtvMDZSWW13dXNpVlFRQUljc2hPblJSOXplcGFER1kz?=
 =?utf-8?B?cy9SemtqZmpLY09WNkNpNmswK01nT2FaU1lmLzNkbnM4WmxENFhwMFdTODYx?=
 =?utf-8?B?RjRMK1c1eWFWbDRHQXBDdGt2V1cvb2EyQndxRmFwZC9vMWl1YUxiU3kxMFdM?=
 =?utf-8?B?dHNQaTVjd2tQVGdZMDIvaEtTcjVrQ04zRnJmb2wvZXM4RHhNY0NHNlYzNmpP?=
 =?utf-8?B?cEM2c28rck9mbXd6c0dCTjhwdUdtMzBZbmM3Qktpdk9Oc0xINXUwTnFpZ3Qy?=
 =?utf-8?B?a21NK25KbWhQUG5hRVlwbG1GbE1EbEFCRU41SjZIaHJCRkFNaW9kamNQOFow?=
 =?utf-8?B?djZJLzlsMzRSYlIrbmVleDVjQ3dqVk5mdWFkSnhWT1VOcW1abVBaUVVBbmFI?=
 =?utf-8?B?alZJRTZVdk1YSjVsUStoU1h1R2ljcFR3K0FCNHN4N1YxSGcxV0Rxa3BOYnFs?=
 =?utf-8?B?dUdnNlBsa2dQcjJQZWpSZGlIdUNUOHJvKzFLK240UWttbEdEUWVMU1FoT2pi?=
 =?utf-8?B?ODhrS2hTVGZpQXQ5TGVwUElmZzZhMC9sOW55RXNiRnJzaU1COHErNjZTbFpH?=
 =?utf-8?B?clAyWlZXZVV3U1preXZEa3BLeWEwRDFRcTBxMjlkMjcwNW9hSUtJb29NcFE0?=
 =?utf-8?B?bi80YkJCOG9TR2xVMFhjT1ZDd29ZeW9KemlpVS9VV3BvaXNCcFNOSnlJT3BI?=
 =?utf-8?B?NHBnQkxEOHlnQ3BLQVhHUVFHWXVEemlkZ0YrRkF3QmZzc1lNRU1kMXF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFFIRk1xcFlFbGkxQnpsMkdVeVlrdEZuSG9ZbGZkWmthdUhxRlJmZElwWnpu?=
 =?utf-8?B?eXFMTEZDaUNFVGUzR3UvYTNuME1wcnhEZnUzS0FWTHNLMzZjakZhcU11WHJt?=
 =?utf-8?B?aGhwWmhRU3Npa3htbnlmWExVY1U0UDR6dXVyTTF5c0tQTnA1S01HakN0R1FT?=
 =?utf-8?B?U1lrRWR5d1JaR3ExU1JhcFVhSFVBL2srSmxYeTd2NVl1TlZrRXRGMG1OVTFk?=
 =?utf-8?B?WVFiVlZHT2hEcXlDa25hb01lSWo0Lzh1bGNOemdmQ29Eb3J1OU5rWmhMNnRl?=
 =?utf-8?B?LzVGY21ZbnBxQkllR3JYNlNIanYvV3NhN0hNOTNmT1FWU2JmQW0zMDNvQ3Ay?=
 =?utf-8?B?cjRhMi9SK0lBSXh3YkttT1FlcDdId3hIbEN0YjV3RzAyeVJUTW5ZTkltZldP?=
 =?utf-8?B?WTlBOXVGZkFZRnNRcSs4WWRsZWpXNnZuaDRNeVB0NytMQWZ1VGhGM0VrNisv?=
 =?utf-8?B?MEZQOWNrakZRRjFRU2d3M050b3Voa0xqYUYzQlVoY1FZenR0c3pKSSs2TGZS?=
 =?utf-8?B?WWpKWFdJcnVGbXZscVRIN2hwNFMxMmliSzZ5dkdOeVZhZDBxUVNZL1hvejBp?=
 =?utf-8?B?NnQyazNzajA2QzljV2M1NUhmWHU5QnhqcURLdCtURForV3ovQ2FmTVRrS2hN?=
 =?utf-8?B?WHh1WWs0VnN0aWdQNEtxYUduSUVHUnVUWG9NTmx6TTkrZWJPaU5GcGtiUTZs?=
 =?utf-8?B?VjhpVXNLdkhHSDZVRk9XL2JKQllDOW9TRVZaMXRjRjQ0eXZRRU5ZVVJFM2VK?=
 =?utf-8?B?U3hpVlBRYTQ0NHZVdlUxdnA2eUJxVml0aW4xQ0kydmVQeVU5WGN2aDluOTNW?=
 =?utf-8?B?ZTNDekxGWU9nZlZISVV5QnlZMHhQVUc2bG5YRDBQb0J6VzhQQ01EMlpEM1M1?=
 =?utf-8?B?S2R1V2tjWmZDd0tzL25mcjVQMzdHUEU3Vi9VOTZpYlV2b1JtV1NZdHJzTlJm?=
 =?utf-8?B?bERIc2c1a0d1QmVzUW5PUHZHcTF3RHlpQmNnRnFhQVNmOVBLQWpIdThzS3V5?=
 =?utf-8?B?cXZDM25OaHUrSjVQaHVQRjhJQkdKdHZnUXR4cEtla0hHaDBoUDdHUFVLWkw0?=
 =?utf-8?B?c2ZsQmlBTUVqeXZsbXV2c3FHSG9uM3hpRSs2dFFGTExvU1ZqYVUvbGRpUm1D?=
 =?utf-8?B?NWlDNHRxZGtselVoNUxDYUhKeE9pSU9GazQ1M1A1bEp5a0VYQTBYeU80VXQ0?=
 =?utf-8?B?MloxeWZPbS94MEo1NGpwSjZLcWczbGZHUWh6bm1tb29wRFNBK2c1MWdmR2s0?=
 =?utf-8?B?em0vdEJnbVVJdFhpZkJyUm9XUkcrSlZxSS9Ub1JKSE1Wb2R3Ukl0NXlKWDlN?=
 =?utf-8?B?L2Fac3hNWEFzRDRyL3pOdnp2UVBEd1JEZGZpdUFtZ2hKOVNHbkhyTlUzOFhy?=
 =?utf-8?B?Z3diSExEaWFSNWRVRGtaVjB4VDh3WEFuLzZwVkxuZEJiemZHRDZKS1g2WnlD?=
 =?utf-8?B?ZEdpMFQ5WnRObU5Nck04bDdkRXp4aDgrUmNFT0RLV0RuVTIyZ0YyVjJnbUpC?=
 =?utf-8?B?cTYwWmxtLytkN05xOGcxaDFIWkNIb2VieE8rZnBHUnljVUQ5UVc4VkpwdkJ4?=
 =?utf-8?B?ZS9tMjJJMXBrZTZTaXVoWFF4bXZzVXIrUCtndVFMY1liOHlXNEVXdVFxYktu?=
 =?utf-8?B?WEpGRHdCNHJ0WndjRnpidFUzMWZicDRTVjYyZkR2TnIrcFpISzFPUzlOSWZB?=
 =?utf-8?B?dmg2UlM0OVZrc1MzRVVYS0NDM3BRQ0FEK2VUa3lCaDFiWHlhNGlXSmdONHhS?=
 =?utf-8?B?VEFYQnZncERSZnE1QXZZMDU2NTFOQ3pTbDI0V2VwdFZwNFJQRy9yTnpKTEND?=
 =?utf-8?B?V1Z1UVBkb2wyRVh1Q2lvL1Z5bmFCSU9KZzNvK0RKVFBnYlNnVXNVNUVUUzQ0?=
 =?utf-8?B?SXVhR3QwbFhYMWw1d1Ntazg2RUhQV0IvTHowdG9DNUlvbktIc3h1c2JiN0xu?=
 =?utf-8?B?cURxNzVQanZUNG5kbTBDbWNlTEIxUHNTVzNrTXlic0Y2S2RNRGdDRG5Eb1VQ?=
 =?utf-8?B?ZkN3MXk0NFg3S3VwOHdOMzZ6bWNYWG9DdllvcWpWOS9kSEpNbnJqK0dJN0xN?=
 =?utf-8?B?eTNYYk55U2NIblBDWGZxckljUGg4bDBkT1BENFU5RlA2NEl1UzR0cUFTc0du?=
 =?utf-8?Q?I/+ZgQs+xfx+W8YDOWyZVZBtA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c408acf-0a3b-4b51-896d-08dcec2e376e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 08:57:22.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omVbz1FrRZEUJc4wuVLqP5eQ4QXZTntZs3IX+J9GnyAJ6iz5Ja3UHeURQ4MLkV5eMmxw1WBzlDoTRPeenE9U2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985

On 10/9/2024 11:37 PM, Paul E. McKenney wrote:
> Even though the open-coded expressions usually fit on one line, this
> commit replaces them with a call to a new srcu_gp_is_expedited()
> helper function in order to improve readability.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <bpf@vger.kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>


- Neeraj

