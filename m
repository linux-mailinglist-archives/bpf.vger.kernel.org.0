Return-Path: <bpf+bounces-29714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A372F8C5C42
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 22:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AAD1F23B78
	for <lists+bpf@lfdr.de>; Tue, 14 May 2024 20:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5974E18133B;
	Tue, 14 May 2024 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="R0KsSUeH"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7B181324;
	Tue, 14 May 2024 20:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715718291; cv=fail; b=XragwipbPDvgO6yuyJRh7Embxyu2aLLIYFdGIATPd7r1XpPWwJMwdddbQoRYq5J2oLXLvAXzr0UBvtw0kNoaMx9WmxyKtObaySmPQIFFPHCbrLVfhSxFCeRxI7hQroHf9VsPw2LCra+iqpUqDA4uR77V+NLEGJa0MNE0Quaa2IM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715718291; c=relaxed/simple;
	bh=pXsb5KmMHppGoV2hclH6UfgPk+l3NFwSPqa217XEWyw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CdmEa1CQvDVyRfbceoey+w7aKGPXl/L7MBPZOmkETfZrAqDLY6MUM94dffKH/61Lw/8iBy4spY+rlBpuuLxlP+ybI64ExCJ0nnQULC78UYymTYilf3W+HL2N4sz6ZYjYfwjbdl8OIMFelQM6/W1Re1O/pR9N5i5envdjmqWPOLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=R0KsSUeH; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EIxOgZ013775;
	Tue, 14 May 2024 13:23:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=hACKw7STHWDL+S+r+ooEujrSHXaY/QWJqh/o5YyWHKI=;
 b=R0KsSUeH3GiAEcgHLsCWBqt8y8RRidVzjPH50HJKYyS/OJTw3VA3dmYVQmNOQrMj49Qg
 mZGJUrnwHX9f3pn3e9E5gPuZ51Fr4etleqR4tQUwMHORRMVZMu4XOZLibDfSUUlzMLA2
 WblJ4FTnkkqbmiohG8VluMQAj09cz/v39h5QGiShnFYfMDah7rAzfcw24SP2RhgrztRC
 ENm4Jh74h+SYSZaTcaSxvlftNBXgHE+RNE1PH2PEDvZsaOMMGkPDsGn/XutuhWexGv8+
 gybkt+B2V3aaVK3S1rNEF33A85I7iPcaWxUuBTqAaaOki+mR//zujqX29iuc4dfXN1hh 5Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y43bf415y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 13:23:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzsDvdJbBArDhHvKsVVdwk5Tcz8usaxi+HPJhPB4lgeQwMExkY+Hjx8q7S4ev58J/Nb3brrJc42IuCOGBy/yRHBLJZ0yUNQXQEKKhlzilmw4RWc10c+OHDHJEUoxv8bjWpa0u03HJdR0ZXOCdDdYzq6qVTBDmXKomWWG+EK83kvQIJFCAJvNWlfJSXjzlKYRe+/jFziEvDSbDaONy9FEaU6/hSzh77M/035miah1MXPiTT6eEu1In61DfA6FHpD2+SmhsCrs+Auoruz7xwZpK4jx1ymHAnpXY86Ww1YdgUnv0On67gWeFEmbuq3CIPVbeunNMDHJ9jMUVtlQfqlTXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hACKw7STHWDL+S+r+ooEujrSHXaY/QWJqh/o5YyWHKI=;
 b=loI0ezuuePF3W0+IapWd0baAYAMGJnWninzlLdBYbqZ8uxNk4j1TJXk5n+DJQrvYnn6bo2OG7yJvacskj/MN0bIuCHwVvhCBVRtf80LYfvyZD5J2CdvNiuD0g50Tts8dWnTig1wv3DbxiMCQwOhiE5n7PUQpNT1Ra94YWtqzKdIvk505NazMr6pf1qBBInfFMmcUi8qYjFKjJsQe3u3JOIA8l53rFiW6kN8in3eesR5CXqj/03ZOIy++V6HCu4JgyDTOV5mqFv7kSzPn9Yucg+RUC4rLsYKpmQQVtP3tKFuw4Ndu5Y1ezncLPV0hjxN52WmlVF3k3IeHwrqfLZ8oTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA1PR15MB6420.namprd15.prod.outlook.com (2603:10b6:806:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 20:22:58 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::1ebe:a628:f42a:65a2]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::1ebe:a628:f42a:65a2%4]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 20:22:58 +0000
Message-ID: <6eb9302e-59c9-4242-bfb1-e473d3e5380e@meta.com>
Date: Tue, 14 May 2024 16:22:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, juri.lelli@redhat.com,
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
References: <20240501151312.635565-1-tj@kernel.org>
 <20240502084800.GY30852@noisy.programming.kicks-ass.net>
 <ZjPnb1vdt80FrksA@slm.duckdns.org>
 <20240503085232.GC30852@noisy.programming.kicks-ass.net>
 <ZjgWzhruwo8euPC0@slm.duckdns.org>
 <20240513080359.GI30852@noisy.programming.kicks-ass.net>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20240513080359.GI30852@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0143.namprd03.prod.outlook.com
 (2603:10b6:208:32e::28) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA1PR15MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 807f7bac-cacb-40f4-3aab-08dc7453a512
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SkxlcmVmVlRieVRTamh3a0lBRDVGWDg5dk5abVFCTnVRL1VtL21ZZUtBNWFE?=
 =?utf-8?B?Y1FleWR1YWNIQ3dWSzRFeEdyNjV3THF4dFc1a0hVN3lCZEI5bUUveEpyOW1i?=
 =?utf-8?B?VnVhSDVUTGpjaGc4YWhDSGJwZ0ZGUElDUWlBMitkaEp4c3FlcTNlL0ZVVnBu?=
 =?utf-8?B?cVllaW4vSVFKV2ZFSU1BRWd6R0luL3NsK0dUUkQvekRmWUE3cm90U3ZZMmZL?=
 =?utf-8?B?U1RGYzZkSEp6d29iN1VkczBTZWVwZ1o0WjM2Z1pMOWQxZHhyL2dlKzFlb0kz?=
 =?utf-8?B?Y1J3emtEOEVWQVNUU09vOGpwRlE1a0d3angxUy82bmZKUE9zS21uZEtWNXRV?=
 =?utf-8?B?SWsrb0pOUzJJQWZpbkNTVDhLZm1nVWE3K3g3bndOTVBTRlc2a0x1SjZyelQ3?=
 =?utf-8?B?UVRlZGFRN0NuS1Q1anZvdWROL1Vla2RXWFRmb3RaVWNBQzhKV3JrVzE4Tmhl?=
 =?utf-8?B?bHlYaUxSMW9PdkpyMUVDSzA3T2l6WjFqempzYUVBaTgrdkE1VDZrRktteGk1?=
 =?utf-8?B?YWJOQis3bVIwTEt6N0lxRFRWTzBkaEpWejIrMXZ1aUF1cjRWRE81Y3diWVN3?=
 =?utf-8?B?Z0p1a0M3blRZd2NMMCtmRVZ4RjRGZlVmN0dReFVBL1I3Z3RlNG9zM21Qdm5q?=
 =?utf-8?B?djcwY0tuc0U1dThmYWVYeEFhd29jMUxNdWNSNHpDWkVSTTlNV2YvWktDQm9m?=
 =?utf-8?B?RTN3OEkwdWE1bXk3SnZZUGNTaWNzRCtIRDBQL2lmZ0plN2xRYXQvRzJwc1Iz?=
 =?utf-8?B?cEplRno1ODN4bVU0UnM4UldjSWpoK3Y5Rmh0U3dFOVBndkhmUlJyYUVrT1V3?=
 =?utf-8?B?aUtjV0ltTEdEcmtHbnVjUVE4QzhqSGs1SXptaDlmNGROdXJOMFhvMHJRMzFE?=
 =?utf-8?B?anhqbXJwOU9SYXo2cVVkbXE5Nm9IVG1MQWFQTDBkYTB3cjBwbjYyb0tlSGtM?=
 =?utf-8?B?RUc0eURSTndtcDVXbmRCVWxNb3VoSFMzUmlhSlZZSHJ3UjYvUE83M29NUG1L?=
 =?utf-8?B?ME95UTZTcU9CeFZma1VsdTdybVhOb21uOENsM2JKTHNLZ2QybXV5OGo1UXJk?=
 =?utf-8?B?aHJZNXZVclFqckVqejhUTlRXRG1vYVpVV2pJRy9leGEvZGR5WDlIMTJpdWUy?=
 =?utf-8?B?eWVVNUZoSjNJdkFEVFpuclB0MHhsQTNxY1ZFaEpQOUUxUEdYbmRYZllWeFBT?=
 =?utf-8?B?Ujh0M3N2VUVVcDJSUjk5bENaeitlTlo2aFVub3MxQVlKQmRCL2JBeW5KQUFK?=
 =?utf-8?B?UWw1RFI2YkV4b0dtT1dHL2ZHTFJsZG1IUUM2akdpdmZzdWdVMFdhLzlIVkpY?=
 =?utf-8?B?Vm9KT2tjSmVvcytuRFcwM1RxcVIwb0tKeFJNVW0ydk5HcEIwc2tkSElDMEVw?=
 =?utf-8?B?cDNxdTNCQ1ZvRXR0bVN1SlpiajZlNU14eTkxMERDb3hJTGtsVW5QVDl6S1p0?=
 =?utf-8?B?a1ZTTnJCS1BEWG82eG9BY05qNzhROEl0R284MGVacDZENS9OTXEzd3huRyt6?=
 =?utf-8?B?NC94N2dXUDRzYjNkTTB5VU5QNEpVZ3NOblE2OWJYNWdFd2pLUVRYaWxMaFZn?=
 =?utf-8?B?cU5yaTVWalFvbXJZdk5YQWZ3YmY4WXAyOGNZUnNDbnJsem5icVBpdHhVMWJN?=
 =?utf-8?B?NEhxWnhIZVNYQ1RwVFhDVTkzRGpPK2NZWFB4T1RneTVXWkVRT01OWTc5eFFj?=
 =?utf-8?B?WHE4Q0U4SllmR3FweXZTY2pQa3BROVU5aW5HaTBOK3lTcnRRL3F1YzR3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OCttYURUVWlWVDRpQmlIUnhNWmRaQXl3Wi9xdHhVc3VQaHA4UEdhZG5ZdU5u?=
 =?utf-8?B?V2ExbXVMa2hMcmsrM04xNXZoMll4U0E5cDlzWmZJZHJVaGF3VFNBQ25MQ3Ri?=
 =?utf-8?B?d2w1OVdWbE5KWDdKTy8yTmlKbFB2cS8vTnFOU04vM0RhUHRhby9IbTBkY1V6?=
 =?utf-8?B?dGZHQjB0bmFLMFdlWWlBcko2cm91M2J4Z0VJNWwzMjJFYm5SckYvWXJ5YWI0?=
 =?utf-8?B?S2dqQUpvcmlJbjg4WnY2VTBqT2Qxc1kvVXdkam5vNWJOVWIva1p5TzJEMGdm?=
 =?utf-8?B?eldaNGNMcUMvK09yTlhwajNBb0ZkWWdlUlJ0ck1OQ2xCTTlOK3h0SERRZ1JV?=
 =?utf-8?B?ZlcvdGsxVTFEREVLVjd4V3R2V25mVnE4cTJwaGJnSzJCTFMwa3FLRlg5eStU?=
 =?utf-8?B?WUZWVzFKTkFlY3hHRjNyRUJDZkg4blFnV1BaQXN3ZjhVQnZMRjFpa2xPanhh?=
 =?utf-8?B?QStpTGsydDExZnRDaHFrRXBvWDZzQXJKY21QTjYyR2ltdGZURTk4WGZhYkRZ?=
 =?utf-8?B?clpoclVBRUYySHkzbklpMGVxOVY4OXBMbHI1TzVmc3dFejh5ZzBCV1hXMUFs?=
 =?utf-8?B?TzRGU2ZZME9YS01LeEt5Vm1kTjZqcG9hMGNOZjJhSi9ibDRTZnE0UzVyNzBX?=
 =?utf-8?B?MGYzaTNMMHhYMDZXdi9lMDZRMmF1dWRqNy91ZHNNWWpuZjY0YlBzV2ptSFJL?=
 =?utf-8?B?UWZjaldLYWY0OFh4UTNTL08vQlcwbmRLblgrNzNJbmNjL2N2cTJFa0x3M3hm?=
 =?utf-8?B?R0VPUHYxcEZybmVrbzVnd0twZDhWZkEyMWJqT3pnc0tIM1JLdzRhOEFSVnBJ?=
 =?utf-8?B?V1JPSkxjMERnMFhBUE1EWmttVitHRmI1UG02MXNyU0Rnbm5YemR2SWRLblZ1?=
 =?utf-8?B?VjZ3Qk9iNE9YQWRFd1Yzdjc1K3JGd1pzamhDNEZEUGR6Qlo5OVJBNTJFSkR2?=
 =?utf-8?B?NWZYUEhGaTE1OEZjVkxRRVFQdE9YVS9mRU1wYTNXYkR4SWIzNTdBQlBHNjVC?=
 =?utf-8?B?Z1hRbWhRNUo3Z2hXdk5Cby9zN3lRc2grRTV0ZTZlUWJFeUJyZFdGRXdhaG96?=
 =?utf-8?B?OHlMKzdmNzRTcnpHZTdvaDhYS1d3QkdnV0hNSHBXS1R0QkdRTTJtTlB1dmV0?=
 =?utf-8?B?Wjd2dkdlanBOYkZYR1hSL3RtOUFtUnQrR1M3Z29jWkx5OHc2ejVaMFhwbHZQ?=
 =?utf-8?B?MGY2M3JZejZBSmFWcm9XRy83dm5MblJ0bUFILzY5UmlHMWxnSFdub3hIUGlm?=
 =?utf-8?B?aTBmNkdSWEFsUnJxWUZvQnZSM05MSkpTQW5NaE9rcTZJeUkzZWt2M2VyNGI4?=
 =?utf-8?B?SHJuRjdHTGpJR3MwWG5JS0hQNUlXa0FJUGF5Q0FNdFVvTE01VXh5ajlIdVpy?=
 =?utf-8?B?R3h0M3YrTnZZb2pTWktOeXRhL0Yrb3h6bVkxa2gyNVdkdmY4VXp6QzVNR3F5?=
 =?utf-8?B?YkhLTHY4a2JseWY1QXhQNSsyS0RqTlVFUGxlMno0U0RqeGVSSFcyM1pwN2d6?=
 =?utf-8?B?MkptR29MVU5ZMUp0cjVpaGcvSzhFU080K2lMUUtBNlk3WTJzQ0RyZWpXZ3pR?=
 =?utf-8?B?NDNQdkJXSk93ZGRqYU0rZXByM0VsZ2Y2V3FQWm5mbTl2SERUNG9rclh3QlpB?=
 =?utf-8?B?aHdwQzN3Sk5Zd0M2VEVqYVBuNThNL3pxNVlydDJWdjRCS3FsYkg1ekxHUUhr?=
 =?utf-8?B?OVRSZTJna2dVWjJrVUtsRGRWbTJXTXlVa0k0ZlU1OGI0a2t5UWZDYXdUTVVx?=
 =?utf-8?B?NHlMNE14TFA5VHh5akc4UkhBZGJBcW82cTQ4SDlTRWtaNTJ3L1daQ1dVdlNX?=
 =?utf-8?B?dlVDNDBTQldmZ05sNDZrUmNSSnZ6ZFBHZldlNzFKdlZrSkt2Q1Q4YWxkcjUr?=
 =?utf-8?B?eXhuOW9nRTkzZGh0NEhWUWxQOFA0L24yM3hOMkcrcktySlVPTDk0VlNnSzJO?=
 =?utf-8?B?NWhHdEtHR29McE02SjRxTkFianh6dWxyZmViL1JYQzJsQnZaT1pWOFhqNGhz?=
 =?utf-8?B?NEUzQUNFYmFlalJtd0RPZFRUU2YvSVo3c3JNemhITVhBZG9idjAyYVVJblF3?=
 =?utf-8?B?NGp1a3A1UEZPVUo3bXBiVVlaaVYxM2dJM0xSWG8yQTVTaHljc3ZYZVBiTHZ0?=
 =?utf-8?Q?eH9o=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807f7bac-cacb-40f4-3aab-08dc7453a512
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 20:22:58.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYIaKUdsYKsRiz9z1+u7vM8LMGhFx1V+UbJG8mRuJj7PtKYNRs/EpwzCBx14uVUm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6420
X-Proofpoint-ORIG-GUID: lAeR__RG9MY9s0VVTbsRTnpbuzhG6cXL
X-Proofpoint-GUID: lAeR__RG9MY9s0VVTbsRTnpbuzhG6cXL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_12,2024-05-14_01,2023-05-22_02

On 5/13/24 4:03 AM, Peter Zijlstra wrote:
> On Sun, May 05, 2024 at 01:31:26PM -1000, Tejun Heo wrote:
> 
>>> You Google/Facebook are touting collaboration, collaborate on fixing it.
>>> Instead of re-posting this over and over. After all, your main
>>> motivation for starting this was the cpu-cgroup overhead.
>>
>> The hierarchical scheduling overhead isn't the main motivation for us. We
>> can't use the CPU controller for all workloads and while it'd be nice to
>> improve that,
> 
> Hurmph, I had the impression from the earlier threads that this ~5%
> cgroup overhead was most definitely a problem and a motivator for all
> this.
> 
> The overhead was prohibitive, it was claimed, and you needed a solution.
> Did not previous versions use this very argument in order to push for
> all this?
> 
> By improving the cgroup mess -- I very much agree that the cgroup thing
> is not very nice. This whole argument goes away and we all get a better
> cgroup implementation.
> 
>> This view works only if you assume that the entire world contains only a
>> handful of developers who can work on schedulers. The only way that would be
>> the case is if the barrier of entry is raised unreasonably high. Sometimes a
>> high barrier of entry can't be avoided or is beneficial. However, if it's
>> pushed up high enough to leave only a handful of people to work on an area
>> as large as scheduling, something probably is wrong.
> 
> I've never really felt there were too few sched patches to stare at on
> any one day (quite the opposite on many days in fact).
> 
> There have also always been plenty out of tree scheduler patches --
> although I rarely if ever have time to look at them.
> 
> Writing a custom scheduler isn't that hard, simply ripping out
> fair_sched_class and replacing it with something simple really isn't
> *that* hard.
> 
> The only really hard requirement is respecting affinities, you'll crash
> and burn real hard if you get that wrong (think of all the per-cpu
> kthreads that hard rely on the per-cpu-ness of them).
> 
> But you can easily ignore cgroups, uclamp and a ton of other stuff and
> still boot and play around.
> 
>> I believe we agree that we want more people contributing to the scheduling
>> area. 
> 
> I think therein lies the rub -- contribution. If we were to do this
> thing, random loadable BPF schedulers, then how do we ensure people will
> contribute back?
> 
> That is, from where I am sitting I see $vendor mandate their $enterprise
> product needs their $BPF scheduler. At which point $vendor will have no
> incentive to ever contribute back.

Especially in the scheduler space, the incentive to contribute back
today is somewhat inverted. As you mention above, it's relatively easy
to make custom things, and it's also very difficult to get features and
patches included. The cost of maintaining patches out of tree is
relatively low in comparison with the cost of working through inclusion,
and the scheduler stands out in terms of how hard it is to land changes.

I think the scheduler balances the needs of a wide variety of workloads
exceptionally well, but based on the volume of out of tree scheduler
infrastructure, it feels like the community is struggling to meet their
collaboration needs in the upstream tree.

Just like I can’t imagine one filesystem working for everything, I think
we need to open up the field a little on schedulers.  As we develop for
new variations in workloads, power management, and hardware types, I
think sched_ext gives us a way to do more collaboration in the upstream
tree, and while I’m not pretending it’s perfect, it’s definitely ready
for expansion and broader use.

I do think that sched_ext developers will keep participating upstream,
and I agree with a lot of the points that Steve makes in his reply.
People are going to keep sending patches in because the kernel community
is just the best place to build and maintain this functionality.

-chris

