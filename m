Return-Path: <bpf+bounces-32771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236B8912F44
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 23:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74035B2238E
	for <lists+bpf@lfdr.de>; Fri, 21 Jun 2024 21:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4014417C233;
	Fri, 21 Jun 2024 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="WAqoRLEd"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E51517C215;
	Fri, 21 Jun 2024 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004569; cv=fail; b=XS1lE6KleXr/mK9lcbPNda7yC1lw8w0riul5EQMv6f0QNOmnLw/YXJ7ngYLElGW5PcLNSioq+rHAZ5Hxb2n5bDGzSEvsnfiRTpC96KeX0VZFZKvIvw0FBRiflHyV5Bz71FiQYLDJnD5VBmtrOTUO+hKTGS3ODnPuEM9LlYjAmEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004569; c=relaxed/simple;
	bh=od27pxOClrb3zQQU5yC96Xe3ngYp9Bm7X1RONdixjSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a0bu5X1/cUKr7L7qnPrzoXYsnxrJUS8Nd2PXQZxlWSsAzvOynKclCevv9mZvT6p9AR5RyOabOvVa7sSmFCcqe4YLYJ6Xo7u78CiH4+kzFzbef2FEaTqWSCWuSuBfy+8Y18Qtj8x4VK/uWdGm169LpmTuYk4lw0OBk2Ycfnuw2X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=WAqoRLEd; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45LJ7ZsG031659;
	Fri, 21 Jun 2024 14:15:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=b1U/MyjkE7xQqsSmLk2vPyKJ79K/czK25NoSvCTed8c=;
 b=WAqoRLEdm+90gavWbT0VTbhBJUsCDxoQ+aR/8Fb31QB3vhYzygucNWAyn+cxaTFqaFHL
 kNuxJ4OIRbNLD2RrmU5SRue4GIzEgngg222gVprjTKg7fvVWBriLMaxavhsxacf/fSri
 PRAXgFm1+s7KOzP9Ov0PTdWP2wnddnncPgxAgW7rYnQEYlsFDBCu0RjHScvRZ+D14Y/2
 dketV3TN9lkxrmvxLzg3kKXv1ct6d88YtpuO85t6+7NDcoNKZYywzSt19iUoD6DFVaJR
 Zp+R8vffRqksUYUK7DduKeU5zDtfZtl4zMktTAOdXQXCK0kFyZR24TvCJwtdQEIaLYmB /A== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yvrph8jrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 14:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUe98XEUUVBFRzC5HwedSPV3UPHuOMIk4HusnyjEGx5GWhYNITZaHLmzJykCHSXKWIkz3QpJlCIlLhOyn0ToLewklNYBILYUAqLYNrZcNThuIoKaILfF5eZtPzNkOevbsi6yUg44cK62FfrxRFiObPluUN1iG9P7GSv1gWc4cyZfLIsAdygyUzZT6YNQC4YXq/LygOdcv0kaEaCUCGJWDQKOj3tZ8d9U/HRBIpzxzDDTYdHYttC33mrFmMCilWYQv8xOGiYpEfuJzvpmDtmQIpDNUnEQrnr66nenFte139f4VO2rf1s1wB4r87azMUpQNdeZk/L3BAPbEQG25S/pSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1U/MyjkE7xQqsSmLk2vPyKJ79K/czK25NoSvCTed8c=;
 b=P7qkoltCERKSWFt0K2DgHYbL4XkBoX8gkk+8yvQp1AKfZNA8PoYD6Y2XJlBE+DHcXEJ20AuRoyeqP3vpGfykWNKB8VgnGqMgpJpxENBTFAeQo1K4dUZQn4aiZN4Jq8B1k/ZcGtwgy6MPWnEtO9DbibSrY5BdO85BRSetmSzMdrgMrL8zJwqG8F6NtosUA2sUX9X4fN6YobPwi6282WI82OgRc+GrPAo8HmUgtH9QHR/LxwlHoB+fXuRFFp01PcpNRjRr4CicABfSvsO8WDIQd7KhATr/bWmTLiLc+tN1hjXQR61xQJC4FrYV9mypCtt3ZD7SzDWdOC8F4dfgppg85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by LV8PR15MB6389.namprd15.prod.outlook.com (2603:10b6:408:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 21:14:46 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::4f47:a1b2:2ff9:3af5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::4f47:a1b2:2ff9:3af5%7]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 21:14:46 +0000
Message-ID: <364ed9fa-e614-4994-8dd3-48b1d8887712@meta.com>
Date: Fri, 21 Jun 2024 17:14:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
        andrea.righi@canonical.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx>
 <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx>
 <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx> <ZnSEeO8MHIQRJyt1@slm.duckdns.org>
 <87r0cqo9p0.ffs@tglx>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <87r0cqo9p0.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::26) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|LV8PR15MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c59797-80df-4889-3b0a-08dc92372d66
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011|7416011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVhQSWh4aWo4NEJ5TnJ3K0tzdGc3WFBlR3V5c0oyemNybUZMbytSWjcvUzJF?=
 =?utf-8?B?eE1uQS80aU4zaDhsbmk1UjJUa2wvRSsvenVtVm41ZW55cmtndmNHUWltb2xT?=
 =?utf-8?B?UWtSUExCTHp3UE1Rbk5kSXg0cE5mUGZxeTdTMCswR2NVQ0k2V1JUb1NyTndR?=
 =?utf-8?B?citwOEg1QU5CTHQ4QlQvcElrL1Y3TGhWKzZsSGI5aCtYc0xoUHZscHErNUVD?=
 =?utf-8?B?OG1nb3ppT2lRSHRuczhqMjgzcm5zZ2hPYnV5bkxWR0pySVBiY1VRRkZVNmRl?=
 =?utf-8?B?SDFkcW03RzE0OXNJT0ZFbThwWjhXVXRJYmtrRFJ6QjdYN2prMU80RTRIRkxq?=
 =?utf-8?B?cTNlaEE0bjRHWkl2SHRZcUNsNitneTNZV2NPQTlTWDFpbmtBWEtQS0lMQTkx?=
 =?utf-8?B?bUNZUzRnOTZGQ0NPN2NpdkdRMS9OUEdSYjQwTmVVbnZMUVZMS2JSUi84S0xa?=
 =?utf-8?B?OG1COFdPbjRTcFVFQnRSelVOa2t4ekJzc0pRWXVBZlZRUHpDd2pRbWFMZEI1?=
 =?utf-8?B?RFA3cnRXM093djQwaXB1Mitodkt3bUo5akFTTGphcm9NSkFCdkQ1U25GMGxh?=
 =?utf-8?B?VS9Wc1NnZi9sdzhPLy9Od1NaOGFZSEQ5aHZ1QjJYbzFsZlFOeU0yUXBQR0Ru?=
 =?utf-8?B?c2MwajIvb0pqQ290TXdqWXRqVUFIUkFTN1dwbE9zREtNbFYvUmphWFQ2aDBO?=
 =?utf-8?B?Z2xVU2NQK2YwVVRCZWZTbmtTdm5NM3B0RTdBWUw1SnJiTFFHckhSS253aFBr?=
 =?utf-8?B?clRwa0V4enkxaFBaTU9HRE9QUElFWXdhd0lOczdiZTRDV1k2VGxndUhFYVZ2?=
 =?utf-8?B?WDJZVHYyT2lyZWh2RUQ3b1MyRkpBK20wR05xbUErT3F5YnlKck5ZNzljWWdU?=
 =?utf-8?B?ZlVLZnZHRjJZdFV6aWh0WnFYQjZQcWZ4UFBhUHMzNTI5UnJ6a0piQkNxUGh5?=
 =?utf-8?B?MWhuTXp6Z3BaUTg4ei8rMmN5eFVvRGNRdEJuaEFCOUY5NE8ybmt3eFVKZURx?=
 =?utf-8?B?c2tMTG41TURNRjN0bURXa284U0xscVZ6eXBoZ1ZnRHpvQmF2T2t6UGRUK3E2?=
 =?utf-8?B?U040Yk9hMjd5YXpuZFRkZkRNZ255SkRtaVNrK3lNRWpVT3cwWnVQMFJ4OVQ2?=
 =?utf-8?B?clVPc2RIeDdmY0w3eXAzVUsvVFZveXJJNUZNSGFMSitlZm5XWjhtUlhoU3JN?=
 =?utf-8?B?L1dzL21VSUlXUS9TbGdRT1dJWnA2dFFtK01NZ1FLbDN3aXNyenRMWi9La3Va?=
 =?utf-8?B?VTVQUGVKb0JZU21jcVhxQXhTOTNINXhpZkxjN2VBdlRWTzd1TnJxaUhTaFM5?=
 =?utf-8?B?RXRvaXRqUVdTZVppa3IzdG9sNHMrV1Y3cllkKy9pcWhFcTRIT2dhdEhWc3pt?=
 =?utf-8?B?cUxiN1dxMkZrbkNyMFRsQ2ZJVFk5YnlLUHNVY1IzNkF2Y01KRy8wckhib3BK?=
 =?utf-8?B?OW1VRXpNa3FoZ090dTZIOEtMemZVZlJhNFRudmQ5UDZtNVMxanh3VTNsblhF?=
 =?utf-8?B?dGw5ZnlaU29yRzlzQkkxenZrNDFGb1J2YmRPOG1jenNndkdPRzRheWMzOWRi?=
 =?utf-8?B?b3ZIMGtyRk1tbStGeE1FYndjTW95R25hc3UxMHlXNFBYZ1RPcWNsRWJRSXZy?=
 =?utf-8?B?YWV4MHdOZHBmditWYWF0NSszZDJ2SjMzNXdrcTc3UU9TOWlwVDN2czJHS215?=
 =?utf-8?B?NWtQdzE3UEI2VTZ5TGphZlRHRU1YeEJlSlN6Mys3TmFveXdmOHFsR0hMZnhT?=
 =?utf-8?Q?GWC9jjF72iGfI4MfSjd4ZWG57d8RfCjOuOCxfq3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGUwYnhvbGtyNCtuZm01OXFZTEN1bklvOWZrSFBqRjVNemNYR0l3VEd3K21a?=
 =?utf-8?B?OGU5VHIvYkx1V1l2eEpxWlp1UFB5OENHL2p4REtpcjZsVVY4c2g1NzQ5QW9q?=
 =?utf-8?B?YUJMUXliN01CQlI3eFlTMEo2MkNVZFB0TXJxLytEUklXR09aUjc3WkhpOFJX?=
 =?utf-8?B?TktKUC9rV25HdDlKb2FrVFIxV2RRUmJKWFFWaVZ6RG1CdTFuQS9laXVVRkhV?=
 =?utf-8?B?ak1yREdhRUNybnROMUxFendPTUdlVFZGQ002UDJlaDdISE1RYTc3RDFkQlk1?=
 =?utf-8?B?NkRQMytNY29ITTlLckFzRWowMFBOc3FNYXZWNWFtNHpzWEVoVVN5aFBqRXY3?=
 =?utf-8?B?cGc0bVN2SEdOQlhBZFJLQkRnbDBDTm56QVYveWlIUzd6ZGIvRlYremxBR041?=
 =?utf-8?B?MldOVVpaM2JRSDcraDA3UTA1RlpCMDJNMXZycjVDaUV4REZrZlB0ZmYvRi9h?=
 =?utf-8?B?Y3JHS1hKdFhBSTlNTFFZaVVlNi9pd1BzSStOVTVEN1Y4VkFlVG5yemV2Qkpm?=
 =?utf-8?B?azRBd0J4ZkFZcEt2dUN2YWdqcjRzVmg1OXhNWXNBdDNCU2RFcCtFcFdJdWZQ?=
 =?utf-8?B?S1BPUUlyRThaSTRmaUhsVUdsbWxtTlZpaFpuMDNjRk5BU0lneVRrVG1QeDU1?=
 =?utf-8?B?S2NkUEU1dUZ0azVLSFIzcTE0bEt0ZmlMa1A5TE5CMWhVOU9oQmZlbi9IcFdF?=
 =?utf-8?B?WVZLL244Q0xidDVzRWtMN3FPcE1EVXhZMHFhZFN3alp2aUFNaXVWZWp4Tm1N?=
 =?utf-8?B?V3Z0OEx1S3l6R1hIWmMwMkkvN3B2bVVhZEVESm1oUVRVQWg5enJFWmZaZjJy?=
 =?utf-8?B?OFJaclA1RVN5ZXg4emo1dFNxZ3JGS25BbGJmYWZTa3UvR0o3bnJjb05sY1VI?=
 =?utf-8?B?NDFqMXpMelVVa0c0VVR2TkFOa2ZwTk1MaW43aWUrRXdNVm1BNkJOalZCcUVu?=
 =?utf-8?B?ZjNxSlhWMG1zeVJiVXAzVVQ5b3RjWGN5REJRN0NJQ3VEb1R3MDhPdk0wMnpp?=
 =?utf-8?B?MjVsYmdveFIrK1g0bVNJbzhEOVpMTmFoM0I0Wmd5eXdyc0d0UmpQZHdYZnh3?=
 =?utf-8?B?NUVwUWNWOHNhcnFTVW14eVFCcWZwTFBxVVhQT1VYWEUrNGl3TEhseCtZcGln?=
 =?utf-8?B?czZScEFWTmtpNUl3aTZ0dldiZ0ZqelBKNTJ1QlI1Nmc2bnVZY2doS2IvOS8x?=
 =?utf-8?B?SFN0TzJrMi9rR1E4dnFES1dPWHYvUkpWMUo5OThhNkIrLzQ5YlJraTk1ZkFJ?=
 =?utf-8?B?bHlSN0xQQkJ3cGxoMVdnaHVEYW5peEUyRGJFVFZWTFlkUmh3aTh6RXRsNEhN?=
 =?utf-8?B?N3dSOU9CVUlCSWhRYm1vVGtGRmkyMWorYVprd25ZSWpLbmk5T3dQM3liK05j?=
 =?utf-8?B?ZUxWeXNYQ1RsYi9xTXh0VUk0MVBscFVzRXNFdWQvT01Wa1FRbXE0KzlLZEhz?=
 =?utf-8?B?Y09BK250cUpZc01XWXhDYzdzNjVYU1FTeWtVUmc5NHRmQUwzbS9MR0xEbGxG?=
 =?utf-8?B?NlVHMUM0TWFhQ2tpdHg3OVpyY2NIUGhBRFl4Sk1SOXVycEtYYTNpaXdZSUsr?=
 =?utf-8?B?QXcwMnRTeXRMQWxTYytld1hvTlM3Ly9Sb2NIUzdEYWkxeTVsSXBQcldwZGxM?=
 =?utf-8?B?MU1DQWNJMDhKYjEwS2piT0RraTFUSnU4L3dYWjBuVmJyVWpic2xBaG9qTFhE?=
 =?utf-8?B?MVowM0gxenV0R0NkOG10M1duNGZ1eVVqVTlvb0dKN2Y1aERkbzM0Y0lmdFZq?=
 =?utf-8?B?ZEgxVE1CMHRBRWlPVEdDVThiVVRjZWxuVGx2R3NCb3F5cmFOb3hrQS8zTTlt?=
 =?utf-8?B?RElXd21xaHdIaWhVblZ3QTRnRUQ1aHNWZmdTZUZma1FocHdEeHZoWlFIcjNO?=
 =?utf-8?B?ZlFWa0l1a0NoSmF2N25YZTM3SVNuQnJtQldoNlJPYU41dUxTdm1neUpaUTZZ?=
 =?utf-8?B?M2hONnZGb2p0YWFKcFovMGY4QTJ4dEUvbzArL1dNcExuT0d6bW1idndIVHJ0?=
 =?utf-8?B?NzBwNTgxR0o1N21aRlNPMDNIUEp3c1NFZFMyYXI2b3VvRnVmTTlPRThEc3NV?=
 =?utf-8?B?V3dieUpTbEptTlphU2RRM0ZUY256TGx5bUJLY2FSdEhwRmxsSUwyYkZJeWJE?=
 =?utf-8?Q?N5NU=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c59797-80df-4889-3b0a-08dc92372d66
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 21:14:46.4078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRWEaisxZlWmmnp9FtH5JpciqQE5srGOdrNKLqBSkJ57FdJ/zxkF/Be39Xp5sweY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR15MB6389
X-Proofpoint-ORIG-GUID: k-UxHwEmnYY6T5JVJTTipXsSUv9TqMc4
X-Proofpoint-GUID: k-UxHwEmnYY6T5JVJTTipXsSUv9TqMc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_12,2024-06-21_01,2024-05-17_01

On 6/21/24 6:46 AM, Thomas Gleixner wrote:

>> When we attempted to follow up with you afterwards, we got no responses.
> 
> I just checked and found three private mails from you which ended up in
> the wrong filter dated Feb 1, Feb 9, Feb 16. My bad that I dropped
> them, but definitely not because of desinterest or malice.
> 
> You can of course say you tried and I ignored you, but seriously?
> 
> If you really wanted to get my attention then you exactly know how to
> get it like everyone else who is working with me for decades.

I'll be honest, the only clear and consistent communication we've gotten
about sched_ext was "no, please go away".  You certainly did engage with
face to face discussions, but at the end of the day/week/month the
overall message didn't change.

I think we made a long list of private and public attempts to
collaborate, and at some point we just had to be willing to take no for
an answer.

So, yes, seriously.  It's certainly not hard to find times where I
ignored patches or emails, and I've obviously handed off almost all of
my maintainership work to focus on other kernel topics, but I'm never
comfortable when I watch maintainers try to push 100% of the
collaboration burden onto everyone else around them.

The good news is that every merge window is a new chance to argue with
each other, and I know Linus doesn't want us to save all the arguing for
the start of the merge window, but saying every day is a new chance to
argue sounded less optimistic somehow.

At any rate, I think sched_ext has a good path forward, and I know we'll
keep working together however we can.

-chris



