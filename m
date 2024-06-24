Return-Path: <bpf+bounces-32927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EACA91548A
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 18:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5542848B8
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 16:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A804519E7F6;
	Mon, 24 Jun 2024 16:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="h2eseths"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AEB19E7EA;
	Mon, 24 Jun 2024 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247431; cv=fail; b=DoBUdXJguJ9aOc5bSQG0fSeUGPSUAgpOO1bNFcVP0o8b+i1aNH6jNnG33i7uHX1cWCQ2ELR7GbODxzefs/fEuvBwh4v9qJxtEDP7icJsvkMXQAFkNE8JqRMADLhn9KFUjpLGrtA7lJjwHN5PaFAT4VwvOZy+uhBvquutWYp18gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247431; c=relaxed/simple;
	bh=K6ebMRdXwNhIAloAEO+ehB670eAKm4VGd5mxAUZ1Vvg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=baaC1zYkmXhMi3ivgrFiahzfsPCpXMJfjmyufE8QPurCDpkylR8Xo70Vx6XrMOApqf5m0HK1A+jluW3Qplq9Zx+7Im457m9gWLpiong6gdnsl5Ca4tqp/JQ+G03eBTvvNnjXDFkyhnJIeo37Nt1DpIzl3Z28MUrarJwOQYa3xeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=h2eseths; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OGcjGY017656;
	Mon, 24 Jun 2024 09:42:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=QB5vv5k7YGVmEWgstPwbwvOHoVDKQLxfWY3vCEI+Jis=; b=
	h2eseths9AFUsRjCH1SNPZOr68+/jP64AJNAP9vBnM8STWEip7W/MpmhfjCyeXPl
	wHhYZAd3uhor6KAMf1zS8WWQepuE7SXk/5uEa0m+3x4W+QAJKxCrIfgcpt6838qx
	kVumPiqRigcpl5EHsKcY4U7PUA4jsvyiKVOpvAmS5t4FXf+wwhOTaxU9moph/Is8
	Lv3mphGJQ7Nl2tpuVDgTgDRyF9+Ei6AcQ4ujTmGNeb4sb/s+CalIDnjcCfxaiM8/
	KV7A7M56BtFEty7bSouWORU+2Z6NMwfE1N+dZVPoxBJZjxCC2eaJcczUjIr8ZrSl
	UNfYQTu/3kWJtAI7WTXZ0w==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yy218k8ht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 09:42:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4+KCUcmMPbxH2gjLq5sIq8Sl15C4za2AmeDeAUCiip32bT3cx1IIdBd52CObLriGuKYqM1A1qb43uSBur2sZawmC1qiXL2WiI65Gyim0DkEvB8lEwg//lwdlvRFHTXel7SLB8IstgbfFQ7IihIU62ObtkpAZLZw1I4dAWy8GxayI0+bMzvNZ6BB6hLBg3DpqdV4smS89cm1X2grKckLvohnfyWvbsyrWI6Y/p45GRdisp/l2i1ud/AaG+AUDQIBiHikZ6MgpMt0q8I5TpIbgZCNrxqGNVsQyAe3RyFrcnyI9c/9w/kmLOM7ounKU9rMsG8HkmDgOx2bEk0CcrcXmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QB5vv5k7YGVmEWgstPwbwvOHoVDKQLxfWY3vCEI+Jis=;
 b=ELo6eaZHcFay9Y4v2gntvcJGUnka0RDqgPrSbQk9SRT8+7U3NHc1Q7yApr7om+mD5+6tQhn4nIQuUH38Rpo+2Rfapobfe4cyUuxK7RoNZ9XLnbv0FnmOTJTZrM4WhjI1t4qAoAJe7BKDQbq2G8xZHOT8SIonbcTiM2Zdm2wSvUOd+DiVc6O8aHDWvTOeiuNq136Hvs/dlX1L4XfqWmefGGztlIk8dyvK5qbDqk2H4D83qTU8A+Kzuo4QyrUMumEjkJyJGWoU98dxZtZCGH47AB5mKJ2o8GM/bIIoGtVuTT/EMQyRqyToo+xBsxWTzgm5ISaHRYv5J4yGPYfJGjm1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW3PR15MB3993.namprd15.prod.outlook.com (2603:10b6:303:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 16:42:13 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::4f47:a1b2:2ff9:3af5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::4f47:a1b2:2ff9:3af5%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 16:42:13 +0000
Message-ID: <612c8f18-21e5-452d-8e9f-583f224d8e54@meta.com>
Date: Mon, 24 Jun 2024 12:42:01 -0400
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
 <87r0cqo9p0.ffs@tglx> <364ed9fa-e614-4994-8dd3-48b1d8887712@meta.com>
 <878qywyt1c.ffs@tglx>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <878qywyt1c.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0039.namprd20.prod.outlook.com
 (2603:10b6:208:235::8) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW3PR15MB3993:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ea39c1-b635-49d1-6e5c-08dc946c9985
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eXlmLzFNTld4QjF4VGtWc0htRnVvcTFPTFdqQnBOVGp6OXZwM3lDbkdFUTBZ?=
 =?utf-8?B?SnpWcS9TcDE1TWZrb25QZzdRQkV3SUk3VGVEakZhbTZRWXFRUTJ2cHgzYy84?=
 =?utf-8?B?aFJhTXdzdzEwY2dUMXFpckRGV0FtaE5GenBZOThCejZxQkdRMkFwWkZjdVg4?=
 =?utf-8?B?MmRDTW5sM0RrdE9ndG5lRnE1clVKbHEzRWVBcGQ5NUZYTnlsT2k4dHlhanEv?=
 =?utf-8?B?bHIrNlZVVGVBWWVRVnY0c1ZSMTdqeThwNXgwWDRKYVdKc2UyN0xPQ0RKR0Mv?=
 =?utf-8?B?UWlWNDB6eStMcHEzZWNCNE9oZlhHQ3RBbVJZSVYvNmYyOHpRdzNuUlRaUjBT?=
 =?utf-8?B?dE5FS2R5N2Z6WmFoZG1Od0l6TDZ4RFhtK051b2Q4bFk0ZzNZcUZuemRXSkdY?=
 =?utf-8?B?TCsra0YyWG5Vc01ZV0pyRVcxQ0gzN2JZRWpGWmt5S3R1Z1RmWUNqZUh6bVcr?=
 =?utf-8?B?ZVpUR2ZlaHJQWVZlZkVNL3FhTWVaZTV5NXFac25WVE9XWDRBakVONWpRTXkw?=
 =?utf-8?B?Z1V6ZXBJWHRRWHhIdEh3a3VFQ0hCRGMwOTFKNi93MXBrd2ZJalRuV1krRzVj?=
 =?utf-8?B?WUV0YWFHT0x2TkxZVWQ3Nm54OEd3bUNJakFtSXBtTGVKbDk0dG1xUzNLRnFB?=
 =?utf-8?B?S20rN1FRUmVwVy9HTnVBU2xUaUJad25rUVZSYWtLUjJNWHEzRWtCdmh6UVlR?=
 =?utf-8?B?RjEvU3BZMWFoQTY2MklvWGVRa3RRUUVpdVl4NVl5cXBaazEwYUJud0hmMExl?=
 =?utf-8?B?ak5FUkxyaHVQYmJ2aTliaFBFNkk5cmNNbHRDdlp2TFBnaUcyK1dKR3JVdnRr?=
 =?utf-8?B?dmE1d0hkTEF3TUVUNFREY3M3YXZLUGZCNTZkS0JSMlg0UUpham1TZm1NMVpy?=
 =?utf-8?B?dW1Lb3h6MC9yeVpoT3BXeVZ5N2hVVjZxS1dZcW9aM2hWUVRVUFZ1dlVxNzVr?=
 =?utf-8?B?VCtDTXZUNDU4bjdSWDhSN21Dd1J4VHJaejFDL0FjMjR4WWZoNXZCL0lRa25E?=
 =?utf-8?B?L1NnZnd6dTJ6WHlreVRFSVdrMGpoTGZrVldDRElGa2p3S2VJZ3VpMGVhaHY3?=
 =?utf-8?B?TlUzWjZ3YlhoM2NlR3BjV0JKaVRhOEoxU2ErY1hFMnhYR1gvVXNnek5uL3Nv?=
 =?utf-8?B?MXkvUkJkNzhDWnJ5eUIzTnBydWZub0VkbU9DM0F6Mm1aQldVU0Q1d2N3U21z?=
 =?utf-8?B?Y1R5Z1NEZ09vYVJMYTlmQytOY0dhOG9heURkVC9ya3d2Y0s2YmFSbXNhT1pH?=
 =?utf-8?B?UzFiMElhbkJBcVVxd05CRVRXU1Z2WjJ0SFRhamcwcnZYTzNIbE0wYW9rUDh5?=
 =?utf-8?B?MFV1Lzl1UUs0cmhlV0J4eEozM2E1RkY3eWFOekZoNW5yWlFiVERhaDhRd0lo?=
 =?utf-8?B?WWhJeWxMS00xTStpNnZKUVpaU0JLQk15b01rOUs4RmdLQmZFR0Y2TG52NW1X?=
 =?utf-8?B?Y29sUkxvVGZLSU4weVVZaEg0OEZ6RnNNL1VVVzZXV2Z0SExHaFVBVVVQSnBZ?=
 =?utf-8?B?aTV2UWl4L21HSDZLeTlMb3BndDhCRlFWc3RHYWsrdUEza1VmMkh6anIwRGpI?=
 =?utf-8?B?MUo4cWRiZURabld3amFOYU1XQkM4YWROMVV3RGhlNHNrTHREMUtjRnhSd1Jj?=
 =?utf-8?B?aEJiSnd0cm84UUJzK01SMlA3VElHWURydVRnN3B3Ly9uNG9HaUQ2WWtPWXBk?=
 =?utf-8?B?cnhveEovNHRlaUluRml5am9OVmhkL2NCeEk0S1R1ZUN0TTdqRTBqbkpzaE1m?=
 =?utf-8?Q?r6IJ7HgT6eUTOO8mtbqGWFfIIuQj1A3CEg7Bd2Y?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WEhCazBVcTdrOHRLTStxSVRlVjhIUHprYUJBOFRkQU05R2dzczFweGZaT1ZW?=
 =?utf-8?B?WThMbzkycndVeWtEeWRmMnptK2hRZlpjTXlJSkt0MExVNGdYNk9kOEw1RWwy?=
 =?utf-8?B?Z0MwNVdTWjhhdE5xNXVYQjhNYTd4TCtCUnpHWEJ2OXk4akhsZ1FxOUIwb0Nv?=
 =?utf-8?B?U1BWRUVxOXNOZG5DcFFtd08vREZ6WlpVbVk3cW00dFNEalZJd0dQVVg5TVRj?=
 =?utf-8?B?UDJjckZlMml2Zi8xa0tzYUVMUmVNeEtjekpTUitjUkhkN29tZWpBcEdDa2lX?=
 =?utf-8?B?R0FYUTcvMHBMNGkwS2M5c3gzRC92Vi9aS2EzSUpiSWNSSTJrOGFBU3VuQ1hz?=
 =?utf-8?B?cHE1cU9nOTRFM0JmUzZjdkVhT01DamtubVBRNTIvOERra0U5V1FrbFRBZWdu?=
 =?utf-8?B?bGFVOU15aUdMdjNtQU5wdzNHRExsUzdveklqK0YzZXRwTEpaZmszNm9MVUZU?=
 =?utf-8?B?V1p3a1ExWHpFbTZtZFdjZlZjdVI0T0F5ckF0VHFxeEl2bWdySTJ6ZTNwNWtX?=
 =?utf-8?B?SmhoOVhQV213RmFqVVZXMUlFN1hJWG9hUk9Tc1ZOQURnNXZxdGR0RFpna2Vj?=
 =?utf-8?B?M2hSSHhPdC9qVjVjbUMwV0VkengzRnFtUGNZMjRWdXYxZ1FPYjRhS0JpL0tJ?=
 =?utf-8?B?WjRuNjZYRjRMNitPVy9sYmNUR2xadlZUMGkzTm1SQ09FNWZ4YWxYNXZKdElo?=
 =?utf-8?B?aEk5TnVWUTVkV1ltOThOWE1USWNOVVprZVVuN0R1WUhFZTd1UzV2SFNZUzh4?=
 =?utf-8?B?RGFXTGUwWW8vSG9JVkJBTlc2b1pvWkJZZndmQmFtUFloRk1tWUVVWHRGTFA4?=
 =?utf-8?B?UDRuZnZqTGRFU1loVlh2Ukk4RVpTY3IvdmJTNEJzejlheUd5bHhmRkI4UXZk?=
 =?utf-8?B?Z1ZBOHZXMHd2bmNMaDAwNU04NGZqcTVOSkF2dVl4eGJUU0E0R1MrN0luamdi?=
 =?utf-8?B?TjlZZXRmWXRBRFpZYXZrM1hmamFFUnErYWM2M20zbjFNb3EwNUxjWlRtWVhD?=
 =?utf-8?B?bmZyRWlUVURvVzZRTnczS2VycUZNUHMrZ1Z6akhTSWd2TnF4UGNZaFh5SFp1?=
 =?utf-8?B?Y0MxTnl6VFU1b1laSXNqTUQ4aU9GQ3k4YTg3UzQ0bFdNTWlwTUljd0dGNDZz?=
 =?utf-8?B?SWtnVUFzdWMrV0Mvd3BkVjBydS9Zem02UzlOV3pGQnBETjMxNFdCdGdzQkhI?=
 =?utf-8?B?MVU2RzFrWkhvUVg4Q0hYbGZsaThnNXJ0VVU2UndKSU0zb3J4dHg1UnprNnh6?=
 =?utf-8?B?ZzNHd3RldXR1WTBmdDJvVDRhWkZ5VDBCTEhwajZ0cFpQcmZoL2dvK3huWnRB?=
 =?utf-8?B?cTk1SjNOQ2FNMVdxNzBybTNUZjVtY0h3SW15RkZZYXVDZ0Zhd3VMQmtNZTNJ?=
 =?utf-8?B?aUZwVWp1Rkx6NTl4aGFYZkxxU3dWTklVZUFzREVzbDVOdHpYOTZ3dmRSUU9G?=
 =?utf-8?B?UFlET242RmlaYjJkNkNTZS9rc2YxTWp6eUdSbWNxeWl3NUp4QVNuUDUwQnpR?=
 =?utf-8?B?SnhUd2tqaFBkMDRBVlJVYWNOK2pIbzdCdzlINkd6OTBpMFRudXh0N1dpK3dl?=
 =?utf-8?B?emJjbVJ1bWZ1MnBTYkFzSitSajJkTjVGWm5RNTQ0K2hBL1ZaREl1Vm5tVlNH?=
 =?utf-8?B?a3ZrVDdnR1VNSFJ0amhEaUJhaGhIRkxrZUJNSTZTZWNFaGxoQ3hxSDJNK1Jo?=
 =?utf-8?B?TEtGQUNsNjdZb1I2dW5oU3ZEN1lOcDdvMUJRNWN1SytDa0QzVWozRFJ6RVRJ?=
 =?utf-8?B?M3l1VUV3czFSWGRBZ3hzQTYvakdyQ2tNMXFNMmt3aG9mNEhJUlFNQVRScGVC?=
 =?utf-8?B?ME5RcGpUdGpxSnltTiszTXpablQwOVFpSTNnZ1F3ZWlpWU5uNkRxNnl5UVd3?=
 =?utf-8?B?YnZHZHI5Uzk3eDZIeFNCL0tyU1A3UGpLd1k5Ni9tOXFKTStMZWh4Q2IrL1hn?=
 =?utf-8?B?bWlrUVJhU05pY0dRTjNRYk9rR1RiR0JjL3c2a1hYRHowTVJ2cFNlTi9pK1pB?=
 =?utf-8?B?WGF5b2U3Y2xYdWkzcm1JclBkMGk4SHlSTk5QYzltck5WbExpS3Nnbi93Z3h6?=
 =?utf-8?B?QjMxS1MrTEZvTVViY0V1OFNGSFo3bGJHckc4a2tvVi8vbGY5U1lMWFMxejZ2?=
 =?utf-8?Q?mm4o=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ea39c1-b635-49d1-6e5c-08dc946c9985
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 16:42:13.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7KWScl8fzKkWSIW+hPwj1X3ke/8vQFU0cZs1nAfg1YeuPyot78uyOlNZAl4bzRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3993
X-Proofpoint-ORIG-GUID: 5lEGLmpYRF-94TqZH3Ffq2Vq1c1Xpo3g
X-Proofpoint-GUID: 5lEGLmpYRF-94TqZH3Ffq2Vq1c1Xpo3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_13,2024-06-24_01,2024-05-17_01

On 6/23/24 4:14 AM, Thomas Gleixner wrote:
> Chris!
> 
> On Fri, Jun 21 2024 at 17:14, Chris Mason wrote:
>> On 6/21/24 6:46 AM, Thomas Gleixner wrote:
>> I'll be honest, the only clear and consistent communication we've gotten
>> about sched_ext was "no, please go away".  You certainly did engage with
>> face to face discussions, but at the end of the day/week/month the
>> overall message didn't change.
> 
> The only time _I_ really told you "go away" was at OSPM 2023 when you
> approached everyone in the worst possible way. I surely did not even say
> "please" back then.

Looping back to where I jumped into this thread, the context was you
suggesting that if we'd just asked one more time, real collaboration
might have started.  I'm not trying to change the message by snipping
this out of context, so if I've got this wrong, please do correct me.

>>> If you really wanted to get my attention then you exactly know how
>>> to get it like everyone else who is working with me for decades.

I really don't object to the scheduler maintainers disliking sched_ext.
Pluggable scheduling isn't a problem you wanted to solve, and bpf
probably isn't how you would have solved it.  We could have talked every
day for the last 18 months, and by now we'd have a huge library of
sonnets and haikus for each other, but sched_ext still wouldn't be merged.

I do object to rewriting history to claim that if we'd just used the
secret handshake, things would somehow be different than they are now.

> 
> The message people (not only me) perceived was:
> 
>   "The scheduler sucks, sched_ext solves the problems, saves us millions

I joined a conference I'd never been to before and brought a laundry
list of problems to the table.  So, there's definitely truth to the
perception that I came with an agenda and pushed it.

But, if I left anyone with the impression I thought the scheduler
sucked, that wasn't my goal.  Like every part of the kernel, there are
problems the scheduler creates and problems it doesn't solve, and my
goal is/was to invest in discussing and fixing both.

>    and Google is happy to work with us [after dropping upstream scheduler
>    development a decade ago and leaving the opens for others to mop up]."
> 

It's not a surprise that google and meta have a lot of problems in
common.  For us, collaborating with google is really rewarding and
important for a bunch of subsystems, scheduler included.

Google is full of smart people, and carrying private patches is both
expensive and wildly boring, and I'm always interested in why smart
people use different strategies to solve problems we have in common.

It's part of a discussion we get into internally.  Why does our kernel
team exist at all?  Are we just here to stabilize and ship Linus's
kernel?  Or are we here to try and advance our infrastructure by
developing in the kernel?

Those are two pretty different paths, and I know that we optimize for
things others don't care about, like contorting ourselves to make things
easier to ship to production.  But, we also optimize for feedback loops
with workload owners that other distros and kernel developers would
really envy.

It's a mixed bag, but I can say with certainty that adding features and
optimizations to the upstream kernel is one of the least efficient ways
to improve infra.  Some of this is for really good reason, nobody wants
all the tech debt that would come out of upstreaming every bad idea
we've ever had.  But there's a balance.

Before anyone gets upset with me, the upstream kernel can be the best
kernel on the planet and still be a really inefficient way to land
features and optimizations for applications.

> followed by:
> 
>   "You should take it, as it will bring in fresh people to work on the
>    scheduler due to the lower entry barrier [because kernel hacking sucks].
>    This will result in great new ideas which will be contributed back to
>    the scheduler proper."
> 
> That was a really brilliant marketing stunt and I told you so very bluntly.
> 

Yeah, I'd say all of those things again, and I think I repeated some of
it in this email too.  It's one of my favorite topics of conversation so
I won't bore everyone here (even more than I already have), but I'm
always trying to find ways to improve the feedback loops between
workloads and the kernel developers.

sched_ext has been really effective at that so far, both inside meta and
for others in the community.

> It was presumably not your intention, but that's the problem of
> communication between people. Though I haven't seen an useful attempt to
> cure that.
> 
> After that clash, the room got into a lively technical discussion about the
> real underlying problem, i.e. that a big part of scheduling issues comes
> from the fact, that there is not enough information about the requirements
> and properties of an application available. Even you agreed with that, if I
> remember correctly.

I still do!  In a private email a few months ago I promised you that my
one true workload modeling project was just a few months away.  It still
is just a few months away, but I do find the topic really interesting.

But, I disagree that we should stop sched_ext development until we find
the perfect way to model the properties and requirements of
applications.  I'm really glad that eevdf landed with more of a
iterate-in-the-kernel approach.

> 
> sched_ext does not solve that problem. It just works around it by putting
> the requirements and properties of an application into the BPF scheduler
> and the user space portion of it. That works well in a controlled
> environment like yours, but it does not even remotely help to solve the
> underlying general problems. You acknowlegded that and told: But we don't
> have it today, though sched_ext is ready and will help with that.

For me, the underlying general problems get solved with frequent
experiments and tight feedback loops.  It's all about iteration and
cooperation with the application developers, and sched_ext absolutely
does provide that.

Quoting from another email of yours in this thread

"I recently watched a talk about sched ext which explained how to model
an execution pipeline for a specific workload to optimize the scheduling
of the involved threads and how innovative that is. I really had a good
laugh because that's called explicit plan scheduling and has been
described and implemented in the early 2000s by academics already."

This is kind of exactly my point.  We do agree that there are lots of
well understood solutions to well understood problems that are missing
from the kernel.

> 
> The concern that sched_ext will reduce the incentive to work on the
> scheduler proper is not completely unfounded and I've yet to see the
> slightest evidence which proves the contrary.

Linus answered this pretty effectively, and I don't see the need to
expand on his comments.

> 
> Don't tell me that this is impossible because sched_ext is not yet
> upstream. It's used in production successfully as you said, so there
> clearly must be something to learn from which could be shared at least in
> form of data. OSPM24 would have been a great place for that especially as
> the requirements and properties discussion was continued there with a plan.
> 
> At all other occasions, I sat down with people and discussed at a technical
> level, but also clearly asked to resolve the social rift which all of this
> created.
> 
> I thereby surely said several times: "I wish it would just go away and stay
> out of tree", but that's a very different message, no?
> 

No, it's really not a different message.  The kernel tree is where
kernel development happens best.  Linus covered the comparison with RT
as well, but I definitely do understand you've had to carry a few
patches out of tree.

> Quite some of the questions and concerns I voiced, which got also voiced by
> others on the list, have not been sorted out until today. Just to name a
> few from the top of my head:
> 
>     - How is this supposed to work with different applications requiring
>       different sched_ext schedulers?
> 

I'll let Tejun pitch in on this one.

>     - How are distros/users supposed to handle this especially when
>       applications start to come with their own optimized schedulers?
> 

Having worked for two or three distros (I'd count meta, we have
customers too), distros pick and choose what to support based on what
their customers need and pay for, and different distros will make
different choices.  I'd assume we'll have a spectrum:

- sched_ext is unsupported, talk to the vendor
- sched_ext is unsupported, but we'll give debugging a shot
- sched_ext is supported when you're using $supported schedulers

Vendors might provide optimized schedulers, but they have to support a
huge range of distros and gloriously crusty enterprise kernels, so I
can't see anyone making it a requirement.

>     - What's the documented rule for dealing with bugs and regressions on a
>       system where sched_ext is active?
> 
>
> "We'll work it out in tree" is not an answer to that. Ignoring it and let
> the rest of the world deal with the fallout is not a really good answer
> either.

It's not different from any other new kernel component, or old kernel
component for that matter.  What's the documented rule for dealing with
bugs and regressions when a usb nic driver is loaded?  If you're asking
about bpf ABI, that's been covered in many other threads.

> 
> I'm not saying that this is all your and the sched_ext peoples fault, the
> other side was not always constructive either. Neither did it help that I
> had to drop the ball.
> 
> For me, Linus telling that he will merge it no matter what, was a wakeup
> call to all involved parties. One side reached out with a clear message to
> sort this out amicably and not making the situation worse.

This last part is where you lost me.  I've only seen a clear message to
delay for any and every reason you can make stick.  I know it's a jerk
thing to say and I'm sorry, but that's how it feels from my end.

> 
>> At any rate, I think sched_ext has a good path forward, and I know we'll
>> keep working together however we can.
> 
> Carefully avoiding the perception trap, may I politely ask what this is
> supposed to tell me?

I was shooting for optimism here...we've all known each other a long
time.  We'll find ways to keep working together.

-chris


