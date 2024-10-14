Return-Path: <bpf+bounces-41846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF8999C55E
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 11:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A241F23FC6
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 09:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8806019E971;
	Mon, 14 Oct 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qAHcCadJ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0C156C76;
	Mon, 14 Oct 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897167; cv=fail; b=uEt5Hl0pdYTT0uIYPhTXkUJ0RuPJbb4u1qKi7dqCNKY2NfDXejTSHrKkpBJ8yiqIe9hMchVPwstLXCFtvTF/kh+YP5HLEfLXUj9S2oJU43zQfKavi1tOtHZUgzlHpRUYyn4PDq8S3imQQI8rLYteZ8EISkHGagrwT1MPwrpTNsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897167; c=relaxed/simple;
	bh=f2c9rl7ec3X7wRw3HE+uOgcWXw807EGpJ7RmHLhlX9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BvR3KbcyAdPzaAcRr4yT2Jk66763/0T5165+fdLUM7UTJfEQyLfXHGNiVrFeiVSAoDQQHYYuLZHTdq8EBHIo6PIPgc/nfHTvWfBo2hZg1/97qVzNODvBkPuJPnCez1YI2vsw31Mm0D2glVe6cks8dnguAM+888QBfhbHQ+VSEbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qAHcCadJ; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqa4kb+3TxeBszBd+p1vh4fW2MF2Ha8Y6eGWrullvftNwAkvIrKiTggzZf5rd/tJjBDsMFdUbe/KdDxNlYK9cP3HeiPyq8VcJ+QTxOTdcx7ztIlsfvJtEDwKAk6C2OE+ebhBv39w8ayIyKgcsTdBkes+I+KEfCOQqB9j4o29Xtvdi1svJb8zRPcGylR7cOrZjQKYi1FD9bXpI35FTAp87LhttYOXBrQ787VuHZf+wZSB7z4Xf+jXQBzOphrnS+9qbykVekKILDD60T31hKkawJ/FIyY29pSWfiplUvcF8Y1oS6/+H+fYEfFm0ei4OR39XNGV/Lf60FM45PiR4sXxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoqFP+jhiZ2xw9T0g0PtCY/oJEmUMrcL1fY0n3U3O9E=;
 b=xmAOURt1azRP/AZBEgGTQsZ05/D8nQul9fkDs+MGvuyahfaSyTRHc2iq9fGflLMJW/DJ8Z3c6WyjGJFp1PYgsqrPoREZ9LfNmM7zWOQdB2LZrZU/AI0YztNi1myh6CWDJhOgJvzHHdYiC3PU0d8wS+2BZY+bBkea9haHT1Z/6P1MXWZxaI+WizdM6QcOrVGKikZ6P8B0sDSL7CojKiNrIpwlDtA0PHF48u5zggK6Of8OqfdivsicSh4ZkV4dRXL6Rn3XJ4A/jtM/8RdobOlZaO40sWHssGWiuGHEKoY2/8OpZ4pCXKg/haJU9sFLZc2dhg56Wp+ZPLrAwq10heGK0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoqFP+jhiZ2xw9T0g0PtCY/oJEmUMrcL1fY0n3U3O9E=;
 b=qAHcCadJTHZ3WRIUrvRT8W0DHW3kIkxI+nxzqZP4sndQti4mvtf2kdRWeQvPk5yxfpG9z3pXOPrsyF1aKBJIfZ7uk1ayD7dWebOQ5JFXMJbqf5h24kNvSlBF5958r+LQQX5Ru0Ti8LabqBrWuW5gm8asJXLs38eAz8TIYHUZDmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) by
 SN7PR12MB7882.namprd12.prod.outlook.com (2603:10b6:806:348::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 09:12:43 +0000
Received: from DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627]) by DS0PR12MB6608.namprd12.prod.outlook.com
 ([fe80::b71d:8902:9ab3:f627%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 09:12:43 +0000
Message-ID: <abf6c382-7b70-4cdb-9227-7dfd21e60c45@amd.com>
Date: Mon, 14 Oct 2024 14:42:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 04/12] srcu: Bit manipulation changes for additional
 reader flavor
Content-Language: en-US
To: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, bpf@vger.kernel.org
References: <ff986c31-9cd0-45e5-aa31-9aedf582325f@paulmck-laptop>
 <20241009180719.778285-4-paulmck@kernel.org>
From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
In-Reply-To: <20241009180719.778285-4-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::14) To DS0PR12MB6608.namprd12.prod.outlook.com
 (2603:10b6:8:d0::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6608:EE_|SN7PR12MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 491a1814-bd12-461b-3911-08dcec305c19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmFZMGJBalJEcllOVHVMclJ0Sytvbm9mSk5ReUFyNHVpY3RtYVRHS1JwTWFu?=
 =?utf-8?B?ZVkzVHFMaElYdXI3d1NqdzQxYUN2SnZ1TU5SUTZEa3J5QmlTQzVaQU9pY25y?=
 =?utf-8?B?b3FZeHpSMWtyN2xlUEVQUGU1WlJnaURwRmEyUTRkSlcvR2VpR3kwQ25MNFdq?=
 =?utf-8?B?TzJ3T2RwWEZ4MmIrU1hwazd0dFlBRU9jckl5OTZjbVhrbWpMbmtzV0lyVTgy?=
 =?utf-8?B?WldOMHlDN1BmNWpqeGlSS3pqcmI1TjJ6T05GUW1mdEtHRUptOUYxNmI2K20x?=
 =?utf-8?B?RzlsQmlPWjRRWWJEelkvNGErS2ZDajArQkJEUEpJR1lxMERxS2lKU3poYWk1?=
 =?utf-8?B?UDRUV1puZkJ2SzAyS2hOWXJqSXA4YWVUN1lvQXdrMURsejFEcTRaSlZpTDVu?=
 =?utf-8?B?SXM3dUhIM2V1djRuRk9GL0dKamZBamNNWURRVDAwUjB4U3cxM3RZRXdyWVNQ?=
 =?utf-8?B?OTVZRHFDTXB5ZVRSTHpYR0s1dWdmSitIWlQ5eFc0QWV0QWNxR0tNYi90ZkV6?=
 =?utf-8?B?cElkenBDYWV5dTUyUXI3alJTNm9IRVAzWVdEZy9kVXhJNURwallJbURqUDYr?=
 =?utf-8?B?alZ4MzV3NE1Ud25Ic1M1OFp1Z2RHSkhxcjBZREU4c1FPdmZuWVVOZS90Z0Nl?=
 =?utf-8?B?NlRyV2xyMGQrRUFkUWhxQkkyejJwODZwZzFIeVE3d3lTRlkrNWJYNWY5S3Y3?=
 =?utf-8?B?UlpFYmVoWTZKTUx0Y0phZXFqNHJUbkNHZExlRVNOSlYyS1hrTUh2a0E1WkVy?=
 =?utf-8?B?eWtvYVV3TFptK0dMQllxdDREbVc2NytzeFM4RnRGZEgxWHN6UDYybmUwNjc1?=
 =?utf-8?B?NWhIbys5MUhqSmNLWjRZZjlEU1c0d0FwYjZqMWNVM2IyWUQ3Unp0VHVITDVK?=
 =?utf-8?B?VWYwOVUzeCtkNkVlcmVycHErcmN2SE9DelZxMGs5bHZmb3daWUd5Y2VtVEZ2?=
 =?utf-8?B?TGNXcnRLdUplczQ3c004bGdzWWxJUWVMRUo4cFQ5aGQ2VGw2SDZXV1dVd000?=
 =?utf-8?B?Z1RrS01PMHJTVVpRby8yUjRLZnlJaEQ2R1VINnBMY043VDhSTmN3NE5LeWhj?=
 =?utf-8?B?c0lIT2VlMnBOR3AxcS85by9Yd21aeDQ4dnZJQmRydkV0SnhwQ2JpNkhhL3h5?=
 =?utf-8?B?YlVKNHZiQmdjQ0ZyZFJ6M0ROUGRVMUpJMXBFeUZSUVJuSWk5QWdPVndqRDB0?=
 =?utf-8?B?Mkk0Yk03QTVUeFBVWkRMR2RncTV5akg3TDUwbGIwcTI2ZFBIWFZjbTdIYmdY?=
 =?utf-8?B?OFRuaUxBZjBlbkk5NkcrRjNxbFM2bmlOOG1LMlNYZ3NvUU1DTHVZbUcwTnZj?=
 =?utf-8?B?ZmhsMFViM1p3WFhnb2Y2UzRtTFVPdFRxSFdiSGdDYUpSZ1BELzljMUhMNGV3?=
 =?utf-8?B?aWUzdXR1MXdLN0tXNm4yQTUwdmMybkpTQVlZSTh5aksvZS9BYjlRR1ZRRFhx?=
 =?utf-8?B?Y2thb0MwOXZudDd4TEE2eTBvdmFZelBuZGFUY1AwYzZ2ZmJUMEVOVTJaV1Zq?=
 =?utf-8?B?SXB3SUFOSWszVzJjbTE3TkN0R01EeFNEd2F2M3NUNGtyRTRHaitvcVN0M0FK?=
 =?utf-8?B?ZDI5M3Z3cW12eUg4Ni9wNk9wNnEzTGkvcFRQY09WNHRjb0hVU0NlZTZnLzNu?=
 =?utf-8?B?a0pYVTl6TjZQbWY5VnljYlZxTzk0Y1BuSU5Dd25ZZC9rVUJHVFVHM0VCVDFP?=
 =?utf-8?B?d2ZRYlhNYjVtQllVWEZQL2VZVTBYV3F0TzkwQzZBc3dYcFRtR1E3U3V3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6608.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW5LdU1yVm8ydGlaOFJUQWk2WmJrRkdVZCtxNWNFYjRSZ090cnJLVC9MWDF0?=
 =?utf-8?B?aGxwT3B0ZkNTL2Zhb2FsVVdIMGkyUzBUcjZKYVl4VWkxbmp5dDE5SjJTS0RF?=
 =?utf-8?B?MU1vUjkrSjlTdHNGUU16NjhPQ0F0QVVqY3o4dm8zS094aXRwa0VSK3NBOWMw?=
 =?utf-8?B?bDJrampnbVZCczBZYUZkc01ZUGtrR2NrZmtvcElsMXBXZkdFZWQ4b3RydTV2?=
 =?utf-8?B?L3N2UUZzU1BIZStobUQxVHE5b1RZK2tKMm4zdWd0NHhyNXdCY0l3YzJhMmpn?=
 =?utf-8?B?UkhDL2Z6Q3pJNXYzNyt2ZlN3b3VMeXVhVUQ1WVZuaU0vWldCTGhCc0x0b1FF?=
 =?utf-8?B?M0szNWFLeVc4YUdSdThrTGdoMHpqMVJZeGpocmdPWENId0hRM3UvbVdDeHk3?=
 =?utf-8?B?RThveVdabDBnTFoxcUI0dVVENzhlUVN1ZGVHNTMvclhzRGNzY3NPNUZMTHgv?=
 =?utf-8?B?RXBuYzFhdkpaU21jekdCTGJkcTFnLzYrQVVsRnNsYnNVUVJxbThGZ2UrYVZV?=
 =?utf-8?B?dVJ4Y0d5a0llQ3VZQjcwYllqbVk0dVo2STB6cGZJeVVyMHF2TmdtL0E5RVdo?=
 =?utf-8?B?aldqZUUwc3VWTUV5SnFidXZRTXE2U1dwVXJDby9MMFplaks1bEwzbUtPZW1T?=
 =?utf-8?B?VzVyaEpLZlVZaGhlRGVwd0c0NmFrS24vbHpEVnc1S0VxS0QwMEVTWGkyT2g1?=
 =?utf-8?B?cytxa29jWHlGV3VEeDZnTGxJYUhIUU5ncEIxSnVtN0VBNEx2Y1puVTQ1c0RF?=
 =?utf-8?B?dzZRSXFCY2s5aldxRTgwL0tEeWJNbmd2ZmZtWDhOTUVBZTM5MWMwYjFLRXU1?=
 =?utf-8?B?dHRXUDVydVluY2N2ZDZvRkRyaDhubDdnV2hiRmFkSUwzUXZhd3l6ZG53ZjhV?=
 =?utf-8?B?L0YzbnlWVExnWGI1WmlhdXFFL016a1NmTnplbCtVWEhEQW9SUUhyM3dsZ0Vn?=
 =?utf-8?B?eWo1R3VJUUZQc2VhcWo3Mk5zeFA0RFVCYXJzUUcxS0JnZTRoYTBLa09rNmZW?=
 =?utf-8?B?cUo4c0hXZjhsN21WbmNqR2VSNzRnRGY0Wk1FYjUzR1NFODlzdXRIT3lkaXla?=
 =?utf-8?B?cmxVVUdNQmNtRUovQURhNjI0bU5qVXIyZ1FIblkvSDd1cTNPMmhWR1VJTTU5?=
 =?utf-8?B?QUxmWDNEbG9qenZMcTd2MkdaLzJjUUhlak93dVNHajFmcnJFcTB1eng5aEsv?=
 =?utf-8?B?TmIvMW9vZkxVWHl6WTRCV1NsaUYwekx3S3FkVkYwZnI1Y3czZTc1OVIvTGZv?=
 =?utf-8?B?dzdQWDd3dlcyYzBIVlRzRGtrT2hFZXBrdDBFbEZwdTVrWGlqaUZCM01rYVIx?=
 =?utf-8?B?R1lzSnRpMkVpaXBnV2hUYklBaHAyeGNzZnBrdlFOV1ZFbDlDNzJxY3dCRmN5?=
 =?utf-8?B?bkNYWldYalhmQmRjMUZreE1VbEE0RkNhczdOcGV1bm42TnErSlZHTWFqR3pz?=
 =?utf-8?B?NHNJVVdhbFRXcTJLcU5hYzMxQzd3MStHbFFFaDZqVXdTYkt1SjNkSTUwc1hF?=
 =?utf-8?B?Syt6bG9tSUVQOWZxRWQ3VElFY1kxTnFWTmwrcDRKdlFDVDBUUE9oZUJIS2pL?=
 =?utf-8?B?RXAvbU5uQ0E3WVN2VG9xUlh0eERxWW9FV2E5Q1djV2MvMzJGcTFxUlh1Smlh?=
 =?utf-8?B?ZE92OXpGY0F5YXZUYmQ1d1NwWWNRcU1aSHJIRnhmWWVDVDBuU201cHJjT1Ax?=
 =?utf-8?B?M2lJdG4yVndDakdPc3lsOFRnOUUvYVZ0clJwbEowaDdoMFRpOUFWNS9ZMUVR?=
 =?utf-8?B?SElLaDlmLzJnb0ZFOFE3dFp1YnVGWjlQdHlsQmR2U1YrWDBEZk1ZRU0yTDM1?=
 =?utf-8?B?NUN0VUs0TGh1M1NYcFdBdUJyWk5PWVNEL2pjdEswKzBjOUs5bzNyQTZGMVQy?=
 =?utf-8?B?bVJxcStLWFlBY2ZSS1AvNTZrSVloeFA2aGtqK2FCendxTEtpQjdzcTV3Nk9l?=
 =?utf-8?B?SHR4b3FZWEJacFBGNFJSd0dQcDU5YU4rSFZUUlplVlR0RGM5K3RVcFQ5V0Rx?=
 =?utf-8?B?UXFwNDMrdXJqUXR0bk9HMmswbWdNMFBYa0ZXTlNVRVY5cXg2WTRMM2lBeGhV?=
 =?utf-8?B?enRMNzBXMlNWbjBzMjJtSFNzK1pIdGdwdkVpQlc0N2pJZkFTc2Uwb0taWW9K?=
 =?utf-8?Q?JfSY+xwlLXpG4qxCdRRYEirIq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491a1814-bd12-461b-3911-08dcec305c19
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6608.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 09:12:43.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrnxrBRdtR2LqGnACxk81CPsCZ8xBofrknIj2xCPv2J/b+7LUeYncUAjKSWCN/9+8XRbytq2VHjYcwgNz/RFTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7882

On 10/9/2024 11:37 PM, Paul E. McKenney wrote:
> Currently, there are only two flavors of readers, normal and NMI-safe.
> Very straightforward state updates suffice to check for erroneous
> mixing of reader flavors on a given srcu_struct structure.  This commit
> upgrades the checking in preparation for the addition of light-weight
> (as in memory-barrier-free) readers.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: <bpf@vger.kernel.org>
> ---
>  kernel/rcu/srcutree.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 18f2eae5e14bd..abe55777c4335 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -462,7 +462,7 @@ static unsigned long srcu_readers_unlock_idx(struct srcu_struct *ssp, int idx)
>  		if (IS_ENABLED(CONFIG_PROVE_RCU))
>  			mask = mask | READ_ONCE(cpuc->srcu_reader_flavor);
>  	}
> -	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask >> 1)),
> +	WARN_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && (mask & (mask - 1)),
>  		  "Mixed NMI-safe readers for srcu_struct at %ps.\n", ssp);
>  	return sum;
>  }
> @@ -712,8 +712,9 @@ void srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
>  	sdp = raw_cpu_ptr(ssp->sda);
>  	old_reader_flavor_mask = READ_ONCE(sdp->srcu_reader_flavor);
>  	if (!old_reader_flavor_mask) {
> -		WRITE_ONCE(sdp->srcu_reader_flavor, reader_flavor_mask);
> -		return;
> +		old_reader_flavor_mask = cmpxchg(&sdp->srcu_reader_flavor, 0, reader_flavor_mask);

This looks to be separate independent fix?


- Neeraj

> +		if (!old_reader_flavor_mask)
> +			return;
>  	}
>  	WARN_ONCE(old_reader_flavor_mask != reader_flavor_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_reader_flavor_mask, reader_flavor_mask);
>  }


