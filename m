Return-Path: <bpf+bounces-33045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C84916517
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 12:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDABB21D71
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3C714A4C7;
	Tue, 25 Jun 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EetOLNzQ"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C911CA0;
	Tue, 25 Jun 2024 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310665; cv=fail; b=DXzQDLRwGlkkpCWQmTVIrtVs8lE4ZI9AuxfAoEW0pqPiVt+V/lt9xrDzMVqjM7a9BdbZlfwiwJ5f2oCmeZrSqWbwdvqvZF4Q5NghKdhjD8jNG5jgl75Un//7mla176vgJPM981G3l8zNoOgdnB0VxJKh/U6g+e1FcBm3FoW0z7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310665; c=relaxed/simple;
	bh=k94I1gWz+j9bcppidOJz4yAfYzbmjTc1zhQVasYMTmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rDm6vwFkQpt4g1Z3x2WOu9MG/pXEEkjddW29Q6Mzsb41NZNYsyBjIu/iHgomvZQBFYrbJMthCsyWdMadmyPODZhpio19hPHN5mu9XBJb59l7OZ7qMohOGUNfIIbi6R7yB+ULHualrOVA5OB9PvNVvSBhBM/b7JV9EiWvzQsHFhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EetOLNzQ; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Velp7aQpv6qkqxZGpewMBOimiz2IEgowemVdOiYX2MyRFTBb/DWGVRoFCUej+rqA3r2f4/fjmMoi+1CUErjp19E1P348mYdxYb3cBGFJY8gJFL944FE5Y58VhuzSkbydRC2E/wkURp0jn36Cx01x7yVtBBGLccj5TIGzR7cC/ZlBA/hxGn1P13M+vL9jcnp4oHej1BV2/STV1kJFcjkcStzgkE8luLTvl17ErDJeIC+LrB3R7UO7LBgFXffU33hcuAZRLq3AjOffny4wnquhUmwQ//91PHq8pw+NDyf3QCp7JwrftTiRfXfhOm+qVtJUz+uw0qKibJHHim8zuXihIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmH9vCMi8a31IKprLiY4EsvDq86RHo7WtjGnycjDj+Y=;
 b=deiujtraHvEVlityyxJg0PSZFpDWdPkpjBdiifJy+Fnsmr5OdQgOpkMWMgjhZWKO33rJCB7oEoksh/nD9rDIKSS7wNNoxf6ubbIW2orXwP1Yf2QMifWy3660cmO8Nlwgjhykk7ATgRm+jd0YZeI23gPo98ulnZ8N4E+RK709lTbNOqmtaydgnQ7rT7n3Ui0OHu465zrCWRj2p9S6t/0mNNtL5gTiNwNC/81l26xCVbdHO/o9xjtnNtjKKZ02rmtYlO6V2q+739BBnZrSMe4MRErBSTNnDeDP0US/HgkCA4to8FWFb/3M8SE4hvX+PF2JXEsItdsMcwmCpgDrbKKAQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmH9vCMi8a31IKprLiY4EsvDq86RHo7WtjGnycjDj+Y=;
 b=EetOLNzQ9xpW/2A9DdHwWRdjIIrYKfoa2Am+12tNZ+zIHtV84sDBsMJfm22oetbaCPUPF6CSqAA+5aU4rEqXszSd6P6CRFacXulATX9kAY6r2iwL0zvFKIGkpdI4bW+XUSNCnY3eKPFRuygx+J8pOkffUdAjnfH62iF8WBGGifT5h06NkDLpkiRzkr0ehoUP+aiR7B/QDuooYRQcFgZ70e0OMNRXaduvY/zgAzfJB7lYWZB+DGYDeoSesLXJcjuDmnXDIU6SmQ9IW9hfVtDfw2+nEDKF6MMcY7xOv+r5BvB6Akdy+7fLS5SB7lN+W4bcLLKeCrmyc9oBNK+xnWo/0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 10:17:39 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 10:17:39 +0000
Message-ID: <ef376c13-2ca8-4f25-9cbd-fdca37351190@nvidia.com>
Date: Tue, 25 Jun 2024 11:17:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH sched_ext/for-6.11] sched_ext: Drop tools_clean target
 from the top-level Makefile
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
 joshdon@google.com, brho@google.com, pjt@google.com, derkling@google.com,
 haoluo@google.com, dvernet@meta.com, dschatzberg@meta.com,
 dskarlat@cs.cmu.edu, riel@surriel.com, changwoo@igalia.com,
 himadrics@inria.fr, memxor@gmail.com, andrea.righi@canonical.com,
 joel@joelfernandes.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-11-tj@kernel.org>
 <ac065f1f-8754-4626-95db-2c9fcf02567b@nvidia.com>
 <ZnokS4YL71S61g71@slm.duckdns.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <ZnokS4YL71S61g71@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::16) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: a47cff92-47ac-4a24-f955-08dc95000ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTJIaUkyMjFQOWh3YytybjJITG1aZFVVSFNKdEZBTjhST2NXVWRXYXFxakow?=
 =?utf-8?B?dlplemZFUmlsV0lIN3N1VVcxWitjbVRGOE5RNGFFNU1QMW1EVFJxQ3l5UGhh?=
 =?utf-8?B?aEh3cVZzRkN3L1NuNnNoSkFQWSsxNElTTG1aWm80ZnhrV3dZS0ZLRjFqWHQ2?=
 =?utf-8?B?TWZ3Nlo5UWVvQVVFbEMzTEgxaDNqdEl1ZFNMbzBLdkFXdG1USXIwM2IyckNi?=
 =?utf-8?B?ZldIZU83dldNamtEYmRSbHlnbmxKVnRoZFpWeXF5MlJQZk94NFNyM2diVmxn?=
 =?utf-8?B?eUFBUHBhV3pjZGkzVi9wcTFOeC9aQ0ROV0M1R3p3ZkdlcGpqRjJVTnIvaUR5?=
 =?utf-8?B?RU9ta3FMeWVQcVFITzlXSEpqYU52VExKU21QUmdLYUhncjMvaEdxelJNR2pE?=
 =?utf-8?B?Rk9CaUVPZ3ZSVTRNMG9JdHM3VXBxamgydmNGRE5BNUlReTdZTWlvSWZ1UkYx?=
 =?utf-8?B?T1pwbW9ndkxLUEExN0ptSEk1MjF5K0FoSVZoSHVzUXhwOS9wclJOK2Z6K0Jh?=
 =?utf-8?B?amxzbjdFdHBGdzB6M1k4MUFZUTY3NmhVQStPOHNDQ3d3N1BvTy94M2ZYYUZQ?=
 =?utf-8?B?dkV2ZkhLM1ZFM3FDb0RxcStQK0dIK0xlWHd1ZTVob2dXbHdVMFFML1ZXbE1S?=
 =?utf-8?B?cU9EZXpvOENBSFNKN2VBNjBaMmlYdjRlYXBXTzhxVGdObFRqRTZCZk5JZFNL?=
 =?utf-8?B?RUFSRHFqZm0ycTRSMWNFRWdJTktkaVU2OHRzN3o4NGNOUE9jQVlMVUhDOGxW?=
 =?utf-8?B?SzU4SXdTV1ptcG5GbktWOU5wM1duRlNkRHRKZ3lZbXhOaEREVGhGSW9UOXF5?=
 =?utf-8?B?azlULzcxY3M0SHllZ2pscU1hQVdLdHJ0N1NsLzVEOXh1MXhzU1pMLzNINDhm?=
 =?utf-8?B?dnkrMDdNNnJEMm5qU0ZNTkM5UnhlSWFubW1OQTRBeGhabWRmK3o3UE5jNnNH?=
 =?utf-8?B?VW93bE0zZmNjYW1SWHV3NVlNbDQyK2l0d1N2UzdiQ1dXbllraU9FcDNaZHh0?=
 =?utf-8?B?dEJsV3NPVDFYa1BiMTZpMFpadU5mMkJJUDNXS05VOE43SUlpNmg0cFpWeHd2?=
 =?utf-8?B?ZjRlQ2ZFbmtXbjgzcytOd0kyYjhkQ1U4bzNtZzNXMk1nVVJPTWpWL1Fudkpy?=
 =?utf-8?B?SDFidTNKUlVveVk1Zjd0QlVKaE4wcTNUN0FMUWRLOGxWOXlsMFRyWUpvT0Fx?=
 =?utf-8?B?Q3h5QVBja0gwR0NDcUpQV2tDRVpKSmR5WnBBSE9WNG9jZFQ2SWFENk1YQmwr?=
 =?utf-8?B?dVY1NGpLRzlRWEphR09OUVFseHFneXhKRzE0Zk9OU0dCblJEQnFYYXU0V2RS?=
 =?utf-8?B?U1NCQ1k0Z1pCOHdRZWs4a1JZRm9JNWxUcFlxVDVNN3VIcDRFVlBRQ2F2WnVh?=
 =?utf-8?B?OW5BTjJkUEt2bkU4bWlpRHZWKzc0RjdkVFZTVFBod2JxNVVYYktPcHljdjBK?=
 =?utf-8?B?ZzNpb2ltNlFuMWdMR0JpNHRNM1N3bU9Ra0UreUFQSjRlRU1WVU5UUS9XVWUv?=
 =?utf-8?B?ZDgzVEZ0bVRPVWR5cDVGcko2bDU5S1hZZUxuMlFOdUU5Mk9WZW5POWFBSURJ?=
 =?utf-8?B?Vm9FZThmQ0tWd1FGcU5rSU1EU1ZLMkpjeEpxS0Fva29xNURjWGlXbk81S21m?=
 =?utf-8?B?UUlHQVRHNjIxZWYzWEl4bU9VeTZjTStUUDh6NVRyZEJpallOb25GVDE2MWRG?=
 =?utf-8?B?L0xweWVsS2RnYnM0dkxLZ25RZDByWW9LcVhCZ3VOdVBwYXlBRnYyU2E0VS9Y?=
 =?utf-8?B?L2RtUjF4TUVQdzEvTzIxZEQzRXVqckZiRERqbG1Kd005blJZaUdwMWZOa1l3?=
 =?utf-8?B?QVFqaVEwY2FuZitGUmJDdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Znd3UVlNSENDSGdEc2JzUTl3NHhKS0FOMTVuVS9HZjlLeXFBR21wamppTS8v?=
 =?utf-8?B?OUZXQnlQSmc2Q3k1UUlrdG5reGZ1dVRHWEF0ZjFpSXA2NmJIVEFwdTN5elVu?=
 =?utf-8?B?MUlWYWFEMWhLR01KV1NvWVNKQk45eXFxQVhyVTdvdHJBVFpFdk9iOXhSVHJK?=
 =?utf-8?B?d2ZhVGxKdUJGbVM2cVdtbE1QeGxZY2h0eG00TFg3b2pnaG53RnFXUlBxb3lw?=
 =?utf-8?B?NkljS0ZIdWxSTkhIQnQ4RkdOd245TzJISGN0SHJoemV1S3UxS0M5djA3TWVT?=
 =?utf-8?B?UVBqNHhtNU51Y3pSMEc5UXNwVUZEZ0R1QkJxYlVtTlU3elJ3b0lET3oxbkpB?=
 =?utf-8?B?UG9ERnh2bG53TWJNQmZDcWlDcDJ3ay9WV3VNQ3hXekhGVXR1ckFjZnc1djFx?=
 =?utf-8?B?dWFUZzFSWEdvMFZ4clREc2ZtREFDS1lVVlhtUmEveW9JSlJQeU93NFF5WmNH?=
 =?utf-8?B?c3Izbit4ay9abVVMMUVlQXJwek9hSU9DdkVhU1ZyVTlaWUdCRHp4RGErNUZS?=
 =?utf-8?B?UUJQTzV0V1hoZ2lhYkx1MjExUmwvTFJPU3AwSDBsOEwxSEtHVCtLNWRWcjRM?=
 =?utf-8?B?VjhRN1BzTEZwWTBSSUh6ZUEzZDFOYjFydDI4V09lRk1Vb0t5NmVjeFJJM3pu?=
 =?utf-8?B?Sjk1Z0t6S05ocGU3eW5tci9nS2hvd2YvdU5Zenl2eWR6MnllUytBc3VHd29r?=
 =?utf-8?B?SzErT25OeU5NU0g3VmREL0s1M0dnOEQxOHd3Z0dXUWJRSlJydmhuem1IaW1u?=
 =?utf-8?B?dnNzZGNiL3lBR0tKQzhOTThRZHBwRWFBSDd2RnJqVlNRRFpmUHJaUmpuUVJo?=
 =?utf-8?B?N1JhTTIyaldteU5kRXFNTThiVzNubUw5QmV0NFdYdGlnc2xMYnNuRnBiMXNE?=
 =?utf-8?B?N0dYZjMvMDUySGZnVVh5WVBkWVloYjBHUWFKcUhaRjhkVXdiZE5ESWU2NUxq?=
 =?utf-8?B?ZFM2MmxYWVVLM1ZIWHBVRGtJSE5mS1VsMU13UE9wK0tBY2EvL0FMRENUY0Nn?=
 =?utf-8?B?c0RQMlV0b2ZGRGR0WE9tRExYbVRtZ1NSOGxhT280SktFR3hnWWxsSHdSSXBw?=
 =?utf-8?B?ZXd5NmxxZWs4L3NrQ0ZhQjdqVTVNL3B3Z1hoT2RleEtHUXdDdXBwZ24xT1NP?=
 =?utf-8?B?dkVqdDZnR2MyYXlvZFAyMitqYmZxajZrVGwxeWlDcm04YlhVSm9mdzA4OUMr?=
 =?utf-8?B?L2lFRkNCYkVOdFk2STFJQ3hoTlIxWldma25GY3VpR1c2ZHJUWGczZ2dSNlpm?=
 =?utf-8?B?Z0dQMEE2NnNyVWYxZmRxSyt2TldKdEdIdFpvSmxZMHBTZnVjUHhXSHNMbndw?=
 =?utf-8?B?OFI4MzV3V3UwT1duZFJnalZzcFpQWGlWRC9PVXprR0NjWGtURE4vb1pXQ3Iz?=
 =?utf-8?B?Tjk2Z243elJ3bi82aEtFR2htV29IMDI4RHFtYzVnMktQWDZvdjBXcVg3aWNY?=
 =?utf-8?B?QkdNUHpYQjlTYWJxZXhXNWlWSElGdlV0V3lreU1GRXg2WkFJTWc0dVF1dXU0?=
 =?utf-8?B?NUpPRzg4Q2RqVU5SdFJQQTljd0ZVcW5xTHNZNDB1aHM4SDVFQzB4WG9pamk0?=
 =?utf-8?B?WFVvNWtYQ0ZsMlN5MTQzdld4a3JWNlZ5aHhIZ09iNElhZlFoUFVPRnhlVVJo?=
 =?utf-8?B?YjZjVnRJNWpiYWNVdzdyalBnVzVhdTRaektMaExINjh6T284KysrWWZNUWNt?=
 =?utf-8?B?L1NEWXpRVWNiNklBUSsxWnBmNTRXRGxTK0hzMUV4UW85OE9FN1krc2Y0ZzdN?=
 =?utf-8?B?SGsyTTVOUk5KTFBkdjd6aEN3U1hBTDNtdWh3U1RrSlFDb2wxUXhRNUdaUG1m?=
 =?utf-8?B?NFY0TjNvcldnSGVwbmM4eUNNS0QyMG9WM2VCZzFCblhlMlIza0pKS3BMQStn?=
 =?utf-8?B?WnlZMUVDNHRrUUhyS1JOekg4Y0IwQ1lOYm9uNTUvSmpuWU9EYnYvdUtXblgx?=
 =?utf-8?B?bmpDb3RzS3hjb0ZCYnFiSEVyejFCWllVMDRweGZ4TWdHQmY2TG9yVCtrS2tQ?=
 =?utf-8?B?UklzZ2RmZDVITncrMFZCR2lZY1RtY2QxczEvdnk4RmFkQUJzL3MrSlV2ZlQ4?=
 =?utf-8?B?cWxSZ01IS2ZwWGJielE3WXdMUU5jRHp1T1VOQmE2T3Q3aFU1Nk00TnU1K2dS?=
 =?utf-8?B?bUJXUS82T3JpVWZtZnBHaGM1NnZHUHhqUWJjRWF2ZnE2OFJIY1FwU0FDdmpF?=
 =?utf-8?B?YmpqTllYcVpEaW9ONEJ6Y3FjUjRMbkd1VzA0WkM5VSsrbFc3YU40VVh6ZEZv?=
 =?utf-8?B?TEhvWHp2K1VkejZ2WUluL0lEd3FnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47cff92-47ac-4a24-f955-08dc95000ab2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 10:17:39.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpM2wCWpy0kLqzWqnQkiubXEID69T5TlZ52AAn8saa3R1xotZncwIBMjbmmgKWLHcxhY9BAQshHYpYJhsSxc8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812


On 25/06/2024 02:58, Tejun Heo wrote:
> 2a52ca7c9896 ("sched_ext: Add scx_simple and scx_example_qmap example
> schedulers") added the tools_clean target which is triggered by mrproper.
> The tools_clean target triggers the sched_ext_clean target in tools/. This
> unfortunately makes mrproper fail when no BTF enabled kernel image is found:
> 
>    Makefile:83: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  ../../vmlinux /sys/kernel/btf/vmlinux/boot/vmlinux-4.15.0-136-generic".  Stop.
>    Makefile:192: recipe for target 'sched_ext_clean' failed
>    make[2]: *** [sched_ext_clean] Error 2
>    Makefile:1361: recipe for target 'sched_ext' failed
>    make[1]: *** [sched_ext] Error 2
>    Makefile:240: recipe for target '__sub-make' failed
>    make: *** [__sub-make] Error 2
> 
> Clean targets shouldn't fail like this but also it's really odd for mrproper
> to single out and trigger the sched_ext_clean target when no other clean
> targets under tools/ are triggered.
> 
> Fix builds by dropping the tools_clean target from the top-level Makefile.
> The offending Makefile line is shared across BPF targets under tools/. Let's
> revisit them later.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Link: http://lkml.kernel.org/r/ac065f1f-8754-4626-95db-2c9fcf02567b@nvidia.com
> Fixes: 2a52ca7c9896 ("sched_ext: Add scx_simple and scx_example_qmap example schedulers")
> Cc: David Vernet <void@manifault.com>
> ---
> Jon, this should fix it. I'll route this through sched_ext/for-6.11.
> 
> Thanks.
> 
>   Makefile |    8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> --- a/Makefile
> +++ b/Makefile
> @@ -1355,12 +1355,6 @@ ifneq ($(wildcard $(resolve_btfids_O)),)
>   	$(Q)$(MAKE) -sC $(srctree)/tools/bpf/resolve_btfids O=$(resolve_btfids_O) clean
>   endif
>   
> -tools-clean-targets := sched_ext
> -PHONY += $(tools-clean-targets)
> -$(tools-clean-targets):
> -	$(Q)$(MAKE) -sC tools $@_clean
> -tools_clean: $(tools-clean-targets)
> -
>   # Clear a bunch of variables before executing the submake
>   ifeq ($(quiet),silent_)
>   tools_silent=s
> @@ -1533,7 +1527,7 @@ PHONY += $(mrproper-dirs) mrproper
>   $(mrproper-dirs):
>   	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)
>   
> -mrproper: clean $(mrproper-dirs) tools_clean
> +mrproper: clean $(mrproper-dirs)
>   	$(call cmd,rmfiles)
>   	@find . $(RCS_FIND_IGNORE) \
>   		\( -name '*.rmeta' \) \

Fix it for me!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

