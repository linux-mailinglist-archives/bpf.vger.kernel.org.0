Return-Path: <bpf+bounces-65167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06E5B1CF8F
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 01:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70CD7AE437
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 23:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F727814A;
	Wed,  6 Aug 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B9yIPecP"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3547427470;
	Wed,  6 Aug 2025 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524703; cv=fail; b=a2bdcVCgSmVvdMCD49lOdA9Ct6t74KGcTYbggCM93ox/qclCryziNmBY3evlSQtruJDikkNGVU2x+jOZVlJYKAJG/zYgMnLATsldkW+Viugxx6TDBMdYbHgTFALi4grdSFH1aPPNOxZb1XpJ2yLxkncgqs/bvsya33Gho6u4m8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524703; c=relaxed/simple;
	bh=g703uMlFmBqn70elpDPDigxsNVZDzZW2u6QWdyqxpGs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z02Oq55sEVlFzMiCoP9c19ZlJOgeRx1wdU2D49wYCkV3eG48tKAeCzDb83vGGfF23p0ggun8A5enP9HvlKk1DoHnsnh5JVggsmnSUuOd+RIs4pHmiCsC6NGguxnbf74LLgV/MOo1h0y4J7FxMrHGie7guB31SMBL2ZIwJv4anVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B9yIPecP; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576DvxGR015103;
	Wed, 6 Aug 2025 23:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g703uMlFmBqn70elpDPDigxsNVZDzZW2u6QWdyqxpGs=; b=B9yIPecP42x9AWQW
	fJN1haByhN0o/mOPH4496GbSr4WbeoeJj8EmtfIogQJuILTlfgUMLUIePkxkIdpB
	tb2UUskE/AwmtnEx5/NCezP9wTeAXpqH6i3kusPo6XmHXZMpxYmErlUL/ieARSHN
	NjKXz7Omi80PIThHlENWxSOT8i4UjjDez3M6dIjO3Qj9GnmglkayQKMf7uS2yq2S
	28Z6pDlo/tXOYPRbTMmUfm2Hk11VMDER2quHh2y+UPXkqEVJgFsbTq6bbKSpXxbc
	5XXv8PaTQtpDXlMVCB5vnUNV7xDYrwTGjAbsk5kdu7wpyNRpTfs0SazQAbD+3pPv
	sVVpfQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvvvc08-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 23:58:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BiilsnmgyI4INJ48FsoUkV4yqQugUTvQoSxtFtz1PlF2mkkD9IJeRog1ZEHDW9oAnCqlEM/1RDhWQpMm8pSLYkSUvsInYwl3KvFsHyvdQ7kzkKd/3eMWyowXY0wEswA2NiJ2QJHYCdFLyzjXWExso6fYrjH72eFOOMn2ZWOcoBqw7LsAgmRDv0E67zqkDY94qnrGJz/XJjjvACGKO67ZFUtHrveKHGBVSzQKLDrUv3ILSWEJaJnpRQRFAJNsy5P9yJGz2etcAm9vWgsdKXmUPeSBx3fwNa5ETbT53wA2WXSZg0KgN92SDUjMlcayaOWqZSXQUoQJG+VMMy9qdcY5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g703uMlFmBqn70elpDPDigxsNVZDzZW2u6QWdyqxpGs=;
 b=UHDIiL9Qn40cVjJa8c8GMO1vQX1QR+Qzcw94ybFzk79oLfa4MbvhX6vhywm0rn2MTeaW7Lo6ammg8Xcx89bzVXghTnkCfPnX7WHkCCzzvCw4WmF/8UswYm8xEKLkxsSj8fwMwxzIaSPKBu82ARZFnHQ5ivk/yQ3xghxV7nmqFOMvU8fkS+3FfxN7R8sQBuBuUlZBEm28+KQK5Hn+aIwe7knMJLRIF0322EjkcZH4Ec1sP5GpDOl9iM/s/cLj8kyGdfJg49EDyj3urgsQBoA4cm4Y3XJGvYC5dfejLaI8QYu/B83bWZKAqZDZ9hvIAs1rAvXZCdgSGDm3U4e/6f0d5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CO1PR02MB8460.namprd02.prod.outlook.com (2603:10b6:303:158::23)
 by IA3PR02MB10495.namprd02.prod.outlook.com (2603:10b6:208:537::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 23:57:59 +0000
Received: from CO1PR02MB8460.namprd02.prod.outlook.com
 ([fe80::bf56:c358:f1e0:65e2]) by CO1PR02MB8460.namprd02.prod.outlook.com
 ([fe80::bf56:c358:f1e0:65e2%3]) with mapi id 15.20.8989.013; Wed, 6 Aug 2025
 23:57:59 +0000
From: Andrew Pinski <quic_apinski@quicinc.com>
To: Namhyung Kim <namhyung@kernel.org>, Sam James <sam@gentoo.org>
CC: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland
	<mark.rutland@arm.com>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang,
 Kan" <kan.liang@linux.intel.com>,
        Andrew Pinski <quic_apinski@quicinc.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
Thread-Topic: [PATCH] perf: use __builtin_preserve_field_info for GCC
 compatibility
Thread-Index: AQHcBmWTajyP34/TW0O1QlIpFos8n7RWSFaAgAAAh4A=
Date: Wed, 6 Aug 2025 23:57:59 +0000
Message-ID:
 <CO1PR02MB8460C81562C4608B036F36A5B82DA@CO1PR02MB8460.namprd02.prod.outlook.com>
References:
 <fea380fb0934d039d19821bba88130e632bbfe8d.1754438581.git.sam@gentoo.org>
 <aJPmX8xc5x0W_r0y@google.com>
In-Reply-To: <aJPmX8xc5x0W_r0y@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8460:EE_|IA3PR02MB10495:EE_
x-ms-office365-filtering-correlation-id: baffbc6d-fa1b-4edb-9222-08ddd545125e
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjdndDUxNDRhOVpwSVVQckZNb090VEpMbTdMUUU3TEFha3BDSHJVYWNhTEUx?=
 =?utf-8?B?NTJjYnFlQVBRaVArN05pT2FtSkY5ajUvZHdsQ0VnRnRXZzhmRS9hWTRKOWR6?=
 =?utf-8?B?ZG1HVGtQTU5HdVVnVFRVeUZocUt0OWN1R2NTclNXWEdJL2ZiOW1jN2VKakJt?=
 =?utf-8?B?VlF4OUsvTDNwNHlUQ1JUaUR3Qys5TjV3UE50UmRuc0F2Z1VPV2JDUC9JOHN6?=
 =?utf-8?B?NVphYUtrL3dXRDgxMU1MbzdlK0t5K2h5Mm1ScDZyTGI0Z2xyRXJwczVvOVAr?=
 =?utf-8?B?YlhLQndESkE1a0hpZzdQcEErSzBHUGtFTnJmcDJwajlmeW1lanpMRXYvcFpl?=
 =?utf-8?B?eDFTQ3FYdlpKYVByVFI3NU1sVnI0dk0vaG42c2owTFNXem5SSXcwUWR5VHI3?=
 =?utf-8?B?bXk2bStjVUs0Qzg4YXhpcHFFQ1ZoanFEQ084eldseTVoZWpWalhPRlN0Y2dS?=
 =?utf-8?B?WkxqSGFYOWVoVUNhSEdvUU5wcmFLQU5OYkJ1TThVLzZTSitOZW5zend0cmlC?=
 =?utf-8?B?dmR5NGRFREtZTzRDT05kaElLZDVEcERqblozSURqVEhaRFJxV3RhWGQ5eU5q?=
 =?utf-8?B?dGE0aFpnSkJJOHVDb1o3NFl5cUhNeUl3WldCbXZXYzBYcjRWS3BPT0VQeGtB?=
 =?utf-8?B?L2JIaU5hNW9xYVc3SGtrRStETGhPVVUyVmg3YlFYSktBdVo5a3RMVlVKS3pM?=
 =?utf-8?B?cGM3VU9saE5ZeFVhczJHMkFPbWZjWEpyTjEvQitSMlNiT3c2QVV1OWZKQ1FR?=
 =?utf-8?B?MUVKT004UTQ4Q2oxMjBBMTFwcG5tYzFqT2VMdTVOcko5RW91b1JBM0ZSb2dD?=
 =?utf-8?B?TlJadHl1Mm5JQjYxdW9oVC9tRmFOYTAyV2Ewa2tueHA2bmZ4UlJlZElMdDk2?=
 =?utf-8?B?WjdKSlh5WWNETm9wYWFNWkk1MXhvYUdVL01BQ1RZUmxpUlRFMlNZSGxadDFL?=
 =?utf-8?B?WDgrMmkxVUdjQ3FQTXhQUlhQS3p3TldWRXY1NHVKS3h3NjVOUkQ5R1hUSlNm?=
 =?utf-8?B?cC83RFVTNnRsQzZFOEc0VU5semJNalRKU2tCWXliNnArT1RXVzdBMnlJbEpq?=
 =?utf-8?B?c25QcGtXbVhqcE13aXNEcldOeHNDWFJCTkFTemE3c3c2K2pYaXRjdUVGSG4v?=
 =?utf-8?B?czdNMDc1Z09jMkp2S29ON2R4K1RmT3ZaaHRsZEIxRnB3TmE1enJNcjFybTQy?=
 =?utf-8?B?dGpJSmhDQUo5QWhuQldSZmE5NC9HWXZweGpmRUlqQXhqRVZUR3BlYWtGTWhr?=
 =?utf-8?B?RVJ2MzZ6RUFialdUVzZiRDBHc0FZZndOc2k2SHVmTVpmS21raGhsaVZ1MFA3?=
 =?utf-8?B?c0dLQno2T2tUUU9zYnRHeUh0MnlzNlgvQXZDMHp6QzRnczczUmhCRVMvRlMz?=
 =?utf-8?B?Vk9ZMkpqT2pQa3VVRUFHYy83U3BHRzFBck1YNFlrcUJDZmgyNWNSNVZmUnp1?=
 =?utf-8?B?VEJ2eFJwdEhveE9MS3U2WitLNmVmck82N1pKZVFSYWpneHNMb044amtJUmIz?=
 =?utf-8?B?K0EzbFk3eDRPL2J1bi9qU2NVZkVTTkp2Qld3bjZDRjdScWpQNjE2WGdUOUpy?=
 =?utf-8?B?aUVOMUZoNUNaUWdTYnNUUGUzZ0ptSTF3VUVyWXNZUlFOcHNaQ2VTNUhOcGtW?=
 =?utf-8?B?VEJjdXQzV0lENHp4bnM0MGZBL01SckprRytNSWFCeFU2VFB2WVgwRzJrMGpL?=
 =?utf-8?B?ekNpRG81OTljK1Y3c1kwUHpnSEE0YWNEVXVKbzdDQnZvRWlxUTVLM0l4M0hn?=
 =?utf-8?B?M1FGa3o5S2U1SGhGRkZJSFF1TkRzbFNxMlM4eW5tdUFJdlVKUDFYMlJVeEp3?=
 =?utf-8?B?R0tGWGFocnNXTE5VL3lPcE5nTGFpdkoxd3o4NEpWemFHMi9xN3JWbXdwQ3cr?=
 =?utf-8?B?NUJCamlYLzcvc2hMcVN5SDF3OHUxT1p6RHpjeW85eWR4eHBEZHFKRDdvay9D?=
 =?utf-8?B?OXhuUTA4eDB0ZjFlOE4yL3hyNEZXR2FFUkNXZVVZblFPbStaeGlSTC9aczRr?=
 =?utf-8?Q?yOebXOn/LgIJHRMSMMCbqc2zt0hX8o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8460.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUtSbG9mQmtkUFpQbjJ1Z3hFdG5wczdYbmNVTWs5L2EzaEJjemxWT2dROGgy?=
 =?utf-8?B?TytEZ2Z4RHNYR3NxWkJiN01EaW9wV3JjZDJiZHVlK0ZFeFBmN3lSaDA3NjYy?=
 =?utf-8?B?WkdUL21NZm45Ylo4MEdFWnNsUkVGbEYxalRtWXlhTkV4Q2pReDRTVzM0dHp2?=
 =?utf-8?B?ME1PZ0NhK1psbzV2TjRMQTJNR0pSY0g3Ni9uOVpBZCtVL0RpSjBvZWV3UjNt?=
 =?utf-8?B?SmVlZTdBZUNkM0FjODJjbGhvdE1TU0JiMi83dXJmdzF4cW1NQ0FPMWRPMkhy?=
 =?utf-8?B?c2Y3WEVCcWh4ZjFvSzNmV3B2akJ1dDd3SjlWcFZNRTJJZUgvVWVYUExCVmJt?=
 =?utf-8?B?YjNNNHJJb2RnUEZVQ2pRM0RiSi96dnhJRVYzdDNycVU1UHVyZGh2WnJIVkVZ?=
 =?utf-8?B?UWgxR1NjUUgzR0wxMkMvcFdwSmVTcDNyUFZIUWlUV04vdldyUXhKT3dTNTdK?=
 =?utf-8?B?ZFF3U3BRKzNNbVZTMDJnbkkxeFBHQi8wZm1PZG8ySmJLRDV5ZlJwKzNSc3g0?=
 =?utf-8?B?SkFaMzFsSVFJZnZhSGxPbUd6dzlxMkhIbE1zMGxpSFl0UjhncndRa3JsN1hk?=
 =?utf-8?B?anFVK0tERExJajhoMXdGb25TcEhuUWFzSFJ6V3oxRXhkNjBHd0FYQndmeVpa?=
 =?utf-8?B?MHYwdWpzazMvZ21Rc2Zka3NiN3I0VWkrcTZFTXdick9XUnVRT2czcXRJeXFv?=
 =?utf-8?B?YlJjejl5WDJ5dEJORTcwbllEbE9MdXF3TXlUeitpYlVmZjlnMU14NmdhVXR5?=
 =?utf-8?B?cHRTZG1yeFJCNFV6N3N6TVNPRFZYdWo2WmZvdUY3S1FpWlRUcGhINGR0NVRa?=
 =?utf-8?B?UitGTlJib0cwVUZuWU8xd3haNWVjdkw5Q2JONUd1Y3o0UDB4SFVJZWFzMkVM?=
 =?utf-8?B?cm9XMmtSTFhSamV3SzZNaHdlWWV2elJ3MVdpZ2dycTlZOS9sS0tBTSsyMzZQ?=
 =?utf-8?B?STlVbnRBU0JoR00rQ3NOcFRheXk1Q3YyVlZPR0RzdG14WlVzR240RjBPaitJ?=
 =?utf-8?B?QlRGMXlLb1dLM3lreTlML1VEam55NGxYa0NSTmkvNW56c3N0TmFpcGFTZE5x?=
 =?utf-8?B?cWFKdFBoeEE2UFEvR3VZWG1Wc1lIUGI5Skg1d1p0RlV1RSs5dkJVcGNOVUth?=
 =?utf-8?B?ZnNLYldNZlBDbm5iMXZ1NUx2VFVtK3lmRnE4YWRMOW5hYXhDRHBSOWwwSEw2?=
 =?utf-8?B?Rnk5bFFCOFpoV2RHbzhIaFNhenlUOVcwVWMzSS9HMTNvOVprMmZyVXA3em1i?=
 =?utf-8?B?QUdWMFhQQ3Z6RmNITXRBN3NyaFNCa1FOaHI3UVRaaGJYcDlZemg0eGRZMmhH?=
 =?utf-8?B?NTg1U2hQK2JTT21RdUtqZGZXTS8wU2ZoZVNEUnFMeHhqb3hJZzF2THZMVmR3?=
 =?utf-8?B?aHZPNXdoQWp1bEpvOTduMlNHK3Q4L0QrTEZKbG5JYzBTTGt2ejUzK213d3J1?=
 =?utf-8?B?RlREM0h2QSs0SXQrdExQVmc1UlkwMTZ2NFk4K1E5TWJOei9WT2ZwZ1RrOWxj?=
 =?utf-8?B?ejJjMEx0UHZtaVFuWFhKenVRVXhXSnlSMEROaXN6S0NWY0ZtYVQ4Qm94OGNJ?=
 =?utf-8?B?KzUyT204VDFLS2FkcDI3dEw1RSt6TzJNd3RNd2lPZGVvbVkxYmdsdHJrb1Rl?=
 =?utf-8?B?U04rK1M2ZkVHQkwvOEFKL0JuZW51bjlOQmxmdEZVcmlKR3hYVm1ZbUJFL0s3?=
 =?utf-8?B?bCtTajJOeHBYeHIrVmlqWElUeTdBaDE5SWdsYnhFVElCaHZrK1E4Y01UNVBi?=
 =?utf-8?B?d2pxRWRnS01FWVRFc05hT1VJYlowbEhESzVrcHY5c1F2eDRXMjZSMXpwVEZE?=
 =?utf-8?B?RVFTbXBNWGZGT2FONVNvSm5ZVUtoMFFCTWxodTJ5RGYxd0lqdEdJTEttclFJ?=
 =?utf-8?B?a2kyT0VKVHRiRXVySzhBREdLYStScmgzTjU4Wklxd2JBNWpBUU5SZkppZTJZ?=
 =?utf-8?B?RkZUT2RGU2lZZlNqYWpSc1VQQ3VHRVFGUzJWK0RJL0kraUI1S1ZrY2t2ODh6?=
 =?utf-8?B?K2VTZFpZd3pCSUNrOHlwSVVuaUhNNm1ZV2s0RXM4VXV5S2oxamhvOHlxVkwv?=
 =?utf-8?B?aTNuaEttQ1JPL1JCdW9jM01Nb1JvRGJIOWt2K3dHVllGYWRwVVN4cEdMeHVQ?=
 =?utf-8?Q?VH1o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fklA7OvZw+g0GgBTJQzKcgdTyFJ87PWeNsHBEpQ1WeCFyZW/SNNTFWeU3wHb+3N9bvgJ34han7cz/njEPejA9jBEhzrgs6NUbOwDXXN7Qu6/NEt427FplVtQWZoEg9xDDLe3uXjCbUPyWr//IKzXhEc1oSH0sWZ8tBjD4b/uNtbPGL6BOQKC3fLVYD7rDjtbIo4yvgIodRbyHYY8KSqelRILGLLRJsVdUghpQeMkmXDo7MTCpOoKRT6SE9SVMj4xxG2TwC4WIr0dDsKMDLdaejIRbGqP8doplYEFPbde5cDeuSLgXC1rrEjShc6zBl19BIyp+twjQmpSTT/XjnoohHYdQHvPMR0ZWXnJXmsGC+q9VXCe375SRlPFVscjbnkz3YhSt2/LS8YCX6KiAigBHUiDt2JMgeGRnPh5nJ9U+paQu9q/hvXyAoAagiU3ZA5gD+kzE8FitPzuA1l7Nwdv7CzlaS0UQYKLULaeJKq3pYJNHrX9MU089hcLTcEn+ijtarxlp6zDDTt7r7ybqgYTg9YkOHV5lHlXh3MbuaeVepc0KEAhbGEhHjJWFCGdZNSZBzFvTzwQbWlkXqJhJFFV2JB3oMz7kUMAGoVgSmLYRFu0lXhCMT54PHI+vqZCG6yA
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8460.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baffbc6d-fa1b-4edb-9222-08ddd545125e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 23:57:59.4062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7MqJ2woJGTP4Y4ccNw535z8ChoLo+NE40SzjVndvccA8by9XodfpbE0x+QaIkcls5U1STYwqGSMF1N7G5KqHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB10495
X-Proofpoint-ORIG-GUID: vL0cdzd8kRCRDY4rVyq9vZ46hJonEjnx
X-Authority-Analysis: v=2.4 cv=GttC+l1C c=1 sm=1 tr=0 ts=6893ec0b cx=c_pps
 a=mXs27GP3B2XOU+bPH1EGlQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=7mOBRU54AAAA:8
 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8
 a=1XWaLZrsAAAA:8 a=COk6AnOGAAAA:8 a=PjyfGHOG8MQlBxjsWIwA:9 a=QEXdDO2ut3YA:10
 a=wa9RWnbW_A1YIeRBVszw:22 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: vL0cdzd8kRCRDY4rVyq9vZ46hJonEjnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXwQTaqowYAIO9
 ZNMnSsnvvm0hZTRCK/uQCddbHJZGtLWssYsCIs3Ltm09mse3HDlZG2uA7ce4RcfIr6BMsXFpfZJ
 AH7M9/tQfoxSEzAt+XHvDlDSrg3Swd2QnAsr1dmm3srnNPXVMosgQPBpNXjRUkf8QIGlc/3DRiU
 mdsldEy3WHrq3NKLONCm2Wc1D9TOwyj2Vr7uxyhz2LrgqfF9ViQGAlAMVwRMklxd2gCb9H9xL+t
 GUb7iHo77wBTALcnEStMr/xG0CXQV5jjZ/88p2Y5aK/1wEbOwWiK6KBbugBTeRsQaixnigiUXFv
 OskHxTEYKg4IW93ZP1zXFfAJBmyQHc64WKrBuptppRu07ge9KUm2AOmuw3kPyn3jfjPjNHlji2c
 M718NAlC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA2LCAyMDI1IDQ6
MzQgUE0NCj4gVG86IFNhbSBKYW1lcyA8c2FtQGdlbnRvby5vcmc+DQo+IENjOiBQZXRlciBaaWps
c3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29AcmVkaGF0
LmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbw0KPiA8YWNtZUBrZXJuZWwub3JnPjsgTWFy
ayBSdXRsYW5kDQo+IDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFsZXhhbmRlciBTaGlzaGtpbg0K
PiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYQ0KPiA8am9s
c2FAa2VybmVsLm9yZz47IElhbiBSb2dlcnMgPGlyb2dlcnNAZ29vZ2xlLmNvbT47IEFkcmlhbg0K
PiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgTGlhbmcsIEthbg0KPiA8a2FuLmxp
YW5nQGxpbnV4LmludGVsLmNvbT47IEFuZHJldyBQaW5za2kNCj4gPHF1aWNfYXBpbnNraUBxdWlj
aW5jLmNvbT47IGxpbnV4LXBlcmYtDQo+IHVzZXJzQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gYnBmQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBwZXJmOiB1c2UgX19idWlsdGluX3ByZXNlcnZlX2ZpZWxkX2luZm8NCj4gZm9y
IEdDQyBjb21wYXRpYmlsaXR5DQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIFdlZCwgQXVnIDA2LCAy
MDI1IGF0IDAxOjAzOjAxQU0gKzAxMDAsIFNhbSBKYW1lcw0KPiB3cm90ZToNCj4gPiBXaGVuIGV4
cGxvcmluZyBidWlsZGluZyBicGZfc2tlbCB3aXRoIEdDQydzIEJQRiBzdXBwb3J0LA0KPiB0aGVy
ZSB3YXMgYQ0KPiA+IGJ1aWQgZmFpbHVyZSBiZWNhdXNlIG9mIGJwZl9jb3JlX2ZpZWxkX2V4aXN0
cyB2cyB0aGUNCj4gbWVtX2hvcHMgYml0ZmllbGQ6DQo+ID4gYGBgDQo+ID4gIEluIGZpbGUgaW5j
bHVkZWQgZnJvbSB1dGlsL2JwZl9za2VsL3NhbXBsZV9maWx0ZXIuYnBmLmM6NjoNCj4gPiB1dGls
L2JwZl9za2VsL3NhbXBsZV9maWx0ZXIuYnBmLmM6IEluIGZ1bmN0aW9uDQo+ICdwZXJmX2dldF9z
YW1wbGUnOg0KPiA+IHRvb2xzL3BlcmYvbGliYnBmL2luY2x1ZGUvYnBmL2JwZl9jb3JlX3JlYWQu
aDoxNjk6NDI6DQo+IGVycm9yOiBjYW5ub3QgdGFrZSBhZGRyZXNzIG9mIGJpdC1maWVsZCAnbWVt
X2hvcHMnDQo+ID4gICAxNjkgfCAjZGVmaW5lIF9fX2JwZl9maWVsZF9yZWYxKGZpZWxkKSAgICAg
ICAgKCYoZmllbGQpKQ0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeDQo+ID4gdG9vbHMvcGVyZi9saWJicGYvaW5jbHVkZS9icGYvYnBmX2hlbHBl
cnMuaDoyMjI6Mjk6IG5vdGU6IGluDQo+IGV4cGFuc2lvbiBvZiBtYWNybyAnX19fYnBmX2ZpZWxk
X3JlZjEnDQo+ID4gICAyMjIgfCAjZGVmaW5lIF9fX2JwZl9jb25jYXQoYSwgYikgYSAjIyBiDQo+
ID4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA+IHRvb2xzL3BlcmYv
bGliYnBmL2luY2x1ZGUvYnBmL2JwZl9oZWxwZXJzLmg6MjI1OjI5OiBub3RlOiBpbg0KPiBleHBh
bnNpb24gb2YgbWFjcm8gJ19fX2JwZl9jb25jYXQnDQo+ID4gICAyMjUgfCAjZGVmaW5lIF9fX2Jw
Zl9hcHBseShmbiwgbikgX19fYnBmX2NvbmNhdChmbiwgbikNCj4gPiAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+DQo+ID4gdG9vbHMvcGVyZi9saWJicGYv
aW5jbHVkZS9icGYvYnBmX2NvcmVfcmVhZC5oOjE3Mzo5OiBub3RlOg0KPiBpbiBleHBhbnNpb24g
b2YgbWFjcm8gJ19fX2JwZl9hcHBseScNCj4gPiAgIDE3MyB8ICAgICAgICAgX19fYnBmX2FwcGx5
KF9fX2JwZl9maWVsZF9yZWYsDQo+IF9fX2JwZl9uYXJnKGFyZ3MpKShhcmdzKQ0KPiA+ICAgICAg
IHwgICAgICAgICBefn5+fn5+fn5+fn4NCj4gPiB0b29scy9wZXJmL2xpYmJwZi9pbmNsdWRlL2Jw
Zi9icGZfY29yZV9yZWFkLmg6MTg4OjM5OiBub3RlOg0KPiBpbiBleHBhbnNpb24gb2YgbWFjcm8g
J19fX2JwZl9maWVsZF9yZWYnDQo+ID4gICAxODggfA0KPiBfX2J1aWx0aW5fcHJlc2VydmVfZmll
bGRfaW5mbyhfX19icGZfZmllbGRfcmVmKGZpZWxkKSwNCj4gQlBGX0ZJRUxEX0VYSVNUUykNCj4g
PiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fg0KPiA+IHV0aWwvYnBmX3NrZWwvc2FtcGxlX2ZpbHRlci5icGYuYzoxNjc6Mjk6IG5v
dGU6IGluIGV4cGFuc2lvbg0KPiBvZiBtYWNybyAnYnBmX2NvcmVfZmllbGRfZXhpc3RzJw0KPiA+
ICAgMTY3IHwgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGJwZl9jb3JlX2ZpZWxkX2V4aXN0
cyhkYXRhLQ0KPiA+bWVtX2hvcHMpKQ0KPiA+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+IGNjMTogZXJyb3I6IGFyZ3VtZW50IGlz
IG5vdCBhIGZpZWxkIGFjY2VzcyBgYGANCj4gPg0KPiA+IF9fX2JwZl9maWVsZF9yZWYxIHdhcyBh
ZGFwdGVkIGZvciBHQ0MgaW4NCj4gPiAxMmJiY2Y4ZTg0MGY0MGI4MmIwMjk4MWU5NmUwYTVmYmIw
NzAzZWE5DQo+ID4gYnV0IHRoZSB0cmljayBhZGRlZCBmb3IgY29tcGF0aWJpbGl0eSBpbg0KPiA+
IDNhOGI4ZmMzMTc0ODkxYzRjMTJmNTc2NmQ4MjE4NGE4MmQ0YjJlM2UNCj4gPiBpc24ndCBjb21w
YXRpYmxlIHdpdGggdGhhdCBhcyBhbiBhZGRyZXNzIGlzIHVzZWQgYXMgYW4NCj4gYXJndW1lbnQu
DQo+ID4NCj4gPiBXb3JrYXJvdW5kIHRoaXMgYnkgY2FsbGluZyBfX2J1aWx0aW5fcHJlc2VydmVf
ZmllbGRfaW5mbw0KPiBkaXJlY3RseSBhcw0KPiA+IHRoZSBicGZfY29yZV9maWVsZF9leGlzdHMg
bWFjcm8gZG9lcywgYnV0IHdpdGhvdXQgdGhlDQo+IF9fX2JwZl9maWVsZF9yZWYgdXNlLg0KPiAN
Cj4gSUlVQyBHQ0MgZG9lc24ndCBzdXBwb3J0IGJwZl9jb3JlX2ZpZWxkc19leGlzdHMoKSBmb3Ig
Yml0ZmllbGQNCj4gbWVtYmVycywgcmlnaHQ/ICBJcyBpdCBnb25uYSBjaGFuZ2UgaW4gdGhlIGZ1
dHVyZT8NCg0KTGV0J3MgZGlzY3VzcyBob3cgX19idWlsdGluX3ByZXNlcnZlX2ZpZWxkX2luZm8g
aXMgaGFuZGxlZCBpbiB0aGUgZmlyc3QgcGxhY2UgZm9yIEJQRi4gUmlnaHQgbm93IGl0IHNlZW1z
IGl0IGlzIHBhc3NlZCBzb21lIGV4cHJlc3Npb24gYXMgdGhlIGZpcnN0IGFyZ3VtZW50IGlzIG5l
dmVyIGV2YWx1YXRlZC4NClRoZSBwcm9ibGVtIGlzIEdDQydzIGltcGxlbWVudGF0aW9uIG9mIF9f
YnVpbHRpbl9wcmVzZXJ2ZV9maWVsZF9pbmZvIGlzIGFsbCBpbiB0aGUgYmFja2VuZCBhbmQgdGhl
IGZyb250IGVuZCBkb2VzIG5vdCB1bmRlcnN0YW5kIG9mIHRoZSBzcGVjaWFsIHJ1bGVzIGhlcmUu
DQoNCkdDQyBpbXBsZW1lbnRzIHNvbWUgInNwZWNpYWwiIGJ1aWx0aW5zIGluIHRoZSBmcm9udC1l
bmQgYnV0IG5vdCBieSB0aGUgbm9ybWFsIGZ1bmN0aW9uIGNhbGwgcnVsZXMgYnV0IHBhcnNpbmcg
dGhlbSBzZXBhcmF0ZWx5OyB0aGlzIGlzIGhvdyBfX2J1aWx0aW5fb2Zmc2V0b2YgYW5kIGEgZmV3
IG90aGVycyBhcmUgaW1wbGVtZW50ZWQgaW4gYm90aCB0aGUgQyBhbmQgQysrIGZyb250LWVuZHMg
KGFuZCBpbXBsZW1lbnRlZCBzZXBhcmF0ZWx5KS4gTm93IHdlIGNvdWxkIGhhdmUgYWRkIGEgaG9v
ayB0byBhbGxvdyBhIGJhY2tlbmQgdG8gc29tZXRoaW5nIHNpbWlsYXIgYW5kIG1heWJlIHRoYXQg
aXMgdGhlIGJlc3Qgd2F5IGZvcndhcmQgaGVyZS4NCkJ1dCBpdCB3b24ndCBiZSBfX2J1aWx0aW5f
cHJlc2VydmVfZmllbGRfaW5mbyBidXQgcmF0aGVyIGBfX2J1aWx0aW5fcHJlc2VydmVfZmllbGRf
dHlwZV9pbmZvKHR5cGUsZmllbGQsa2luZClgIGluc3RlYWQuIA0KDQpfX2J1aWx0aW5fcHJlc2Vy
dmVfZW51bV90eXBlX3ZhbHVlIHdvdWxkIGFsc28gYmUgYWRkZWQgd2l0aCB0aGUgZm9sbG93aW5n
Og0KX19idWlsdGluX3ByZXNlcnZlX2VudW1fdHlwZV92YWx1ZShlbnVtX3R5cGUsIGVudW1fdmFs
dWUsIGtpbmQpIA0KDQpBbmQgY2hhbmdlIGFsbCBvZiB0aGUgcmVzdCBvZiB0aGUgYnVpbHRpbnMg
dG8gYWNjZXB0IGEgdHJ1ZSB0eXBlIGFyZ3VtZW50IHJhdGhlciB0aGFuIGhhdmluZyB0byBjYXN0
IGFuIG51bGwgcG9pbnRlciB0byB0aGF0IHR5cGUuDQoNCldpbGwgY2xhbmcgaW1wbGVtZW50IGEg
c2ltaWxhciBidWlsdGluPw0KDQpOb3RlIHRoaXMgd29uJ3QgYmUgZG9uZSB1bnRpbCBhdCBsZWFz
dCBHQ0MgMTY7IG1heWJlIG5vdCB1bnRpbCBHQ0MgMTcgZGVwZW5kaW5nIG9uIGlmIEkgb3Igc29t
ZW9uZSBlbHNlIGdldHMgdGltZSB0byBpbXBsZW1lbnQgdGhlIGZyb250LWVuZCBwYXJ0cyB3aGlj
aCBpcyBhY2NlcHRhYmxlIHRvIGJvdGggdGhlIEMgYW5kIEMrKyBmcm9udC1lbmRzLg0KDQpUaGFu
a3MsDQpBbmRyZXcgUGluc2tpDQoNCj4gDQo+ID4NCj4gPiBMaW5rOiBodHRwczovL2djYy5nbnUu
b3JnL1BSMTIxNDIwDQo+ID4gQ28tYXV0aG9yZWQtYnk6IEFuZHJldyBQaW5za2kNCj4gPHF1aWNf
YXBpbnNraUBxdWljaW5jLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTYW0gSmFtZXMgPHNhbUBn
ZW50b28ub3JnPg0KPiA+IC0tLQ0KPiA+ICB0b29scy9wZXJmL3V0aWwvYnBmX3NrZWwvc2FtcGxl
X2ZpbHRlci5icGYuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvcGVyZi91dGlsL2Jw
Zl9za2VsL3NhbXBsZV9maWx0ZXIuYnBmLmMNCj4gPiBiL3Rvb2xzL3BlcmYvdXRpbC9icGZfc2tl
bC9zYW1wbGVfZmlsdGVyLmJwZi5jDQo+ID4gaW5kZXggYjE5NWU2ZWZlYjhiZS4uZTU2NjZkNGMx
NzIyOCAxMDA2NDQNCj4gPiAtLS0gYS90b29scy9wZXJmL3V0aWwvYnBmX3NrZWwvc2FtcGxlX2Zp
bHRlci5icGYuYw0KPiA+ICsrKyBiL3Rvb2xzL3BlcmYvdXRpbC9icGZfc2tlbC9zYW1wbGVfZmls
dGVyLmJwZi5jDQo+ID4gQEAgLTE2NCw3ICsxNjQsNyBAQCBzdGF0aWMgaW5saW5lIF9fdTY0DQo+
IHBlcmZfZ2V0X3NhbXBsZShzdHJ1Y3QgYnBmX3BlcmZfZXZlbnRfZGF0YV9rZXJuICprY3R4LA0K
PiA+ICAgICAgICAgICAgICAgaWYgKGVudHJ5LT5wYXJ0ID09IDgpIHsNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgdW5pb24gcGVyZl9tZW1fZGF0YV9zcmNfX19uZXcgKmRhdGEgPSAodm9pZA0K
PiA+ICopJmtjdHgtPmRhdGEtPmRhdGFfc3JjOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgIGlmIChicGZfY29yZV9maWVsZF9leGlzdHMoZGF0YS0+bWVtX2hvcHMpKQ0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBpZg0KPiA+ICsgKF9fYnVpbHRpbl9wcmVzZXJ2ZV9maWVsZF9pbmZv
KGRhdGEtPm1lbV9ob3BzLA0KPiBCUEZfRklFTERfRVhJU1RTKSkNCj4gDQo+IEkgYmVsaWV2ZSB0
aG9zZSB0d28gYXJlIGVxdWl2YWxlbnQgKG1heWJlIHdvcnRoIGENCj4gY29tbWVudD8pLiAgQnV0
IGl0J2QgYmUgZ3JlYXQgaWYgQlBGL2NsYW5nIGZvbGtzIGNhbiByZXZpZXcgaWYNCj4gaXQncyBv
ay4NCj4gDQo+IEFueXdheSwgSSBjYW4gYnVpbGQgaXQgd2l0aCBjbGFuZy4NCj4gDQo+IFRlc3Rl
ZC1ieTogTmFtaHl1bmcgS2ltIDxuYW1oeXVuZ0BrZXJuZWwub3JnPg0KPiANCj4gVGhhbmtzLA0K
PiBOYW1oeXVuZw0KPiANCj4gDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIGRhdGEtPm1lbV9ob3BzOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biAwOw0KPiA+IC0tDQo+ID4gMi41MC4xDQo+ID4NCg==

