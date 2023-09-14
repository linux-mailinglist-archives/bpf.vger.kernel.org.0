Return-Path: <bpf+bounces-10065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069967A0B58
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 19:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E78A281959
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B5F26292;
	Thu, 14 Sep 2023 17:14:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650B4208A1
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 17:14:32 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C439C1FE6;
	Thu, 14 Sep 2023 10:14:31 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EEJoZw003934;
	Thu, 14 Sep 2023 17:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=AAhZUaiSSCVLnDQfD3vCn7a0ls7UpPYFs35dF9OGDLE=;
 b=Ua7jKLpqGNzb5N1WIa6fFtrEaTfO5Yba78HfcqtX9xMcTYFG1XApVnS1Df91eJBWjzon
 sOwKmCDE6G8eDAEWccgqB+eqx/1pMziJyiSvmqx7O7FhOGgOJ9gN8DU0njhbhzUWScj7
 PuLEQ8x5oduTynMNO7+JTn1AoeBqfTgliZjm8IxLrxRgu/1Jfr6f2IHPs4x+4jsubgT6
 a/YF4+c6zhfRLu3/vW+XWUMc9mpqx8WdBTmCowwvm2sk3knrUSl/mKDq2xPXzBfd3Y10
 F2zA8JKGcLpfS6a/mVcwZpkb2OrVG5JbXEEypMj1LKZ8mQBOmryFoEobMKTxPWNYAT2W AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9kwx4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Sep 2023 17:14:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38EGPxKk030258;
	Thu, 14 Sep 2023 17:14:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkj9h1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Sep 2023 17:14:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHHOAZHlyUhVQuM4e7pjT/TGEKDXeJhFMH4wQn9UnWcM6IJCVnZsDGvfYi9FkOmNH8RawPb2KhHvgvA+lB+22A6KKd2AUg9i7i1hP3SMKTuwL7gOckZqFMQaDy3LE6M78DYvfrG8YkIckDEAy9HJtG5HWKqGVZCrIgGM1koosFALUXQrZl03QnMp2hwcEgk7pznTcTMduFDB13FFmqRyY5pVc1ksH/1fcxbCkgpVzQ6q7xQDQ1IB2lA37ezRDy1x//4uJQeLBbUKzWd/UZIfZgBm22ulU/Q42muk2xgECG5JWZuWASyf0V1YdZZGQYKxOkVxlU8mgruGenuZkAG46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAhZUaiSSCVLnDQfD3vCn7a0ls7UpPYFs35dF9OGDLE=;
 b=W848yQ4cH59WAlyxji0CMu16nGxVr9oBrotNU0JLWwfy2mdVs80YGdi91BnIRO+EmUp+l/qTw8sI8eV4nawR/9R/g4/3rxW1q2fPmyX7TvAkbZyMITrpQdwndAVsDC2FQa7ynJThLxIMpxJQd07JIAcNjJF/bW1cSFJMkHuzF6HC0KKIN+xFzFeZxPfrqGxYeTwlbhk0afOmVqO5MKkYFyCxVekrTlqd1jr/rVu2drKO50aSxGP41YhVq/9/qytzjstcZXa7nwUL0HK8QqpdvyS4HmP6+sB4cAQWpDr1dMfZKnW2oFb0/RAuq1VkME8In3kYZKikMnsVpTucruQZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAhZUaiSSCVLnDQfD3vCn7a0ls7UpPYFs35dF9OGDLE=;
 b=oAvuVSxSDCE3sk/PHTNw7BkLDObqvEKbH5eJOw3UIO45ckPWim5ud+9NbIAJlxfWkFrrS9tdpjbqYM/kbSMyBAJIuJScF4avm90NhBh3yU9bXexu4FIqEr9QXcHu1mZZo9ZCzWvSjrIM9GIgORehPpZDwDkdp3zAWA8X+3Krttk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB6219.namprd10.prod.outlook.com (2603:10b6:208:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 17:14:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6efb:19f3:767c:1e23]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6efb:19f3:767c:1e23%6]) with mapi id 15.20.6792.021; Thu, 14 Sep 2023
 17:14:09 +0000
Message-ID: <2d520a7b-9166-16c4-5385-5bb90437d45c@oracle.com>
Date: Thu, 14 Sep 2023 18:14:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
Content-Language: en-GB
To: pengdonglin <pengdonglin@sangfor.com.cn>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
 <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com>
 <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
 <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com>
 <035ab912d7d6bd11c54c038464795da01dbed2de.camel@gmail.com>
 <CAADnVQLMHUNE95eBXdy6=+gHoFHRsihmQ75GZvGy-hSuHoaT5A@mail.gmail.com>
 <5f8d82c3-838e-4d75-bb25-7d98a6d0a37c@sangfor.com.cn>
 <e564b0e9-3497-a133-3094-afefc0cd1f7e@oracle.com>
 <a0bd3ed9-afe7-49a4-a394-949bd5831d6d@sangfor.com.cn>
 <6b77425c-7f09-ae6d-c981-7cb2b3b826bd@oracle.com>
 <774732d7-1603-466e-8df2-3b21314913e5@sangfor.com.cn>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <774732d7-1603-466e-8df2-3b21314913e5@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0492.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a60b39-c589-4745-b39d-08dbb546022d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r47pX5SjEwKsYHMmgyrRDYxoryg75ZIsFnUexaOxKGMe+vzSyGndxA0neUUCM4+s7X47wcIw2TtbGZSWHTmTuK2tz+CmFjo3WJ4Zt6vEEclU8hyFORJxeNE58hIEGbPAbEgvf4h3nlbx2sG4/s8TwwwYAQZJKj1VYoyDITaw31W/i1P317Fs8c6Exa0jeDoB8zXpi48ZCckldQr+/KKlp277d7qmvPDsFm7BNl1LfNBlSLJh+JEvNCfgYrbXUdSZbDAhrSAh3h0UPgFtm0orC9DokVDSzy/xPLK4uFATxA1IXrvWU98hXa4DPndBwXcrfgLxHzIlMcaHJuW7INmcKhj/e2Yc34Elo9NFX/s+wtO2Hvsqr+q2W06tHDhGl9nzQHOrUYSD9sCWzW9ZpE0NuvmKsZFEInndPetQCCYvkuTh4ttXVU8TlxhhfI+uKec5E3q8/U0eLASZJKHvgdGG6mIco1u3UkaTVDP+I9rVg/VcLVRImEnZ815w6fz+MH9XZ+KXo/5E/RAHTOxGT6PMH/i84c1wOQUDJRO+zSI8bdJ3zk4EtSuWQdAuYtnH6Y3vQ8NJnFnKRSA2kMBR8mge3KUn7qJiX2FGmB9Q3rQnlCUJDCSNNeYzcTFGaQMlA+1wayYR3VmP85L+Wmx67bYLtQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(376002)(396003)(1800799009)(186009)(451199024)(6512007)(6506007)(6486002)(966005)(53546011)(478600001)(6666004)(54906003)(110136005)(83380400001)(30864003)(2616005)(41300700001)(2906002)(66556008)(66946007)(316002)(66476007)(44832011)(4326008)(5660300002)(8936002)(8676002)(36756003)(31696002)(86362001)(38100700002)(7416002)(66899024)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eW0rdW5IUkpScDEwS3kyZis2VU1kWVNnVm5sMjlLSzlUSFl1RmZwUGZaeGI3?=
 =?utf-8?B?dGt3aUNqWGppZWlaTXR5dmVTNTI3SmdKUURkYldKK3I2Y3dOQkZpbVZaR3dL?=
 =?utf-8?B?NkpYYUkvYkFRNFBVb3FnQ1ZnbTRPTlhRMHF3eXc4dWFWMGljdEF5a2kzclV6?=
 =?utf-8?B?V2U5V3p2UkRZZmdFUWdzTHpQRTJvNy80bTJUNGEzMjdDNUhGMXhaTWxpM3JM?=
 =?utf-8?B?UWhkVkJuMnB6Wm93VHFSdEFsd0RsY1BXNzFKVVEvc3dmOHBWK3V4WlQ3MG9p?=
 =?utf-8?B?REVDUzBkWFhxOVY2ekV5TStmL1k1OVQ5UG5NdEdSVFFNcmhQR1A2S0xDV0tt?=
 =?utf-8?B?SDUveXVBZGJBL0RubTVHZDUrTjRUVlRxa1B4UUh3Zm13OHRreEpIZnZkdHly?=
 =?utf-8?B?eDlSZU1wcWNVWGMyRVN4TThIK0hCdGtTUE9aM0JYMEJTYUJHUGp0RFgyOHVY?=
 =?utf-8?B?VkhPSnpIRXdZWTlUM3J2dDBTMk0wQzNXUll2VHhDZ1prZFFOY3MxdndTSUNs?=
 =?utf-8?B?b252dTI1YWJVOTMwaWdQV3FTNzJLbHMxYVZBcExQTWIrd3kwTVovMi93T1Zq?=
 =?utf-8?B?aXJPVytkUHBiaVlTZ3h3enVzWWNONzdBVU5vSVBIZ1BGSVlBRzBJU0hGZ01H?=
 =?utf-8?B?RkI2SG9BSzhxOGU5OWYvTUoya1pFeTEyNURKdHBpZXByeS9GZnpWY0tYV29S?=
 =?utf-8?B?ZzU2Nkp3d29HZDQ1TW9wSUxUaE8wOTF2a0N5ck9NcEl0Qm1HeElzTVV1ZlVT?=
 =?utf-8?B?YXJuOVdGeW45S0lkQzZvYzhqVVRTU2dzWWlEYzhkT1k0MitGNk1uN0JIT004?=
 =?utf-8?B?bUNET043UEE3dkJod01OZnEvSE5GYkZmcUg5TXVUbEtVdGxYRnlscSs0WGFX?=
 =?utf-8?B?R1RmZlhwWi9jV1Nmd3ZCdXRIT1V0YnFzejB4bCt2YlVYSVZDajI5TWxqQmNm?=
 =?utf-8?B?TTZDRU1XMS9tYnZNQzl6WnhKTlkxZ3F2NlVIMEFENSt4K2xEdkFtZzh4b1lK?=
 =?utf-8?B?VnBOQWtvMjFYRlZHY2hPSWdud0NxeFVWQ2JINXZGU2xSTnJ6Rlhqekh1T0Y3?=
 =?utf-8?B?WUxBU3NkQmlnb2dzYmg0K2pLa253ZGlBU0ZneGwySzJzVlYyZXFUaVFMNm13?=
 =?utf-8?B?VjNwUHNmUm1TSnYyWHQ0T3FGam8zLzAvMEtwSjk5djVLQURDZkRwL25ESGJw?=
 =?utf-8?B?YWhqMVJKNnB3dU9NYkI2b2pMbU5vTU9KYVRDQU8xS2lVenVadUt1U1VYRFRL?=
 =?utf-8?B?cmIydGF0a0ZLR0JBM3hVVVdHU0JBdmFMSEgrME9hQ3ZoQ0Zha1g0RW4yMTE2?=
 =?utf-8?B?RURiQmx0U2FZSmU2UWx0Slc5THFBLzVzallraHRTeVAvU1djaHArK0xCZXgr?=
 =?utf-8?B?M1ZtdGtlTWNmSE1QQXJSeDhucENwTnFPOVhBWTRlY3pPbEtyVnJsNGpJelhj?=
 =?utf-8?B?VlJ4ZVBKSmlwZDlQbjQ3NllUSFB5R2xOM0FsditBKzY2Vy8vdnJieHQvdEl0?=
 =?utf-8?B?dUoxeTF4SGFNa0h3WGhhY3Y2WTVlaWNSZlhYc2w3emc1T3piSlZHZk9MSndD?=
 =?utf-8?B?YmZhclkxMGVlRWFqZjVkamFnRjNSSjdUT2djMmpka0pEcFZrbjNXeWZERzBl?=
 =?utf-8?B?MSs4SktyV0R4VllDUEF2MWluNERaTFJXQkd0RmdUeCtXZlhHS3N4ekdlM2h4?=
 =?utf-8?B?eGdITjYxVjRmV1lBemUvNG9TM3REMTBqTklzMFRyK3h3ek9acEVuMGZYdVJP?=
 =?utf-8?B?N2hQaWRZa0hVbzBMOGVmOFVVa29MSHZQcTVqWmhnTWxUcXVXMW1BbmJxMGR0?=
 =?utf-8?B?bEc3dDN2eXBMWE85Qm1aWmREUXlDMXZtUlVnM0xLNjNHSGt0OW1CMHl4M1pF?=
 =?utf-8?B?V09HVXBTRkNXRU5HMS9NdlhEZzVHb05lTTVEbzQ3cGVzKzFEZWwxRXZYZGxv?=
 =?utf-8?B?dTU1a3ZPUngrQVEwNFlNdnFnY2k3VkFMeUdCUU5sY2NzQmtEeDRnU0hoWkYy?=
 =?utf-8?B?MTlUOENnS0srTG01UENMOUswNTcwWTloRWVHVXVXY2ZVNG5qOC9SWDd5OWVu?=
 =?utf-8?B?UUg5NWdGS3NDMy9PaUNXV01MUlF4dlZNMFNKUklZd2ZaazVLaWdFVjJVTXdo?=
 =?utf-8?B?VTFKbDBsQS9WZzRTMWFQSzBmTnVGeHFkZ3BzUVJPdWwwb1dzQzkvaVlPOWw2?=
 =?utf-8?Q?7Lp4cZhFsqccyTIv4Or/y2c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?MjlrTkltMlhVV0pNYWhra1phOCs0d1EvYWloVXo2SWh3TEZwZmZqQ3pHa0RU?=
 =?utf-8?B?b0xGUEZqeHhHakF6MW5nc1kvdWp2Tm5oMnNWREJUc1Rpc2pZbDZNcXlWMGUx?=
 =?utf-8?B?TlowamlvbFJaekhSVXplN2VYdHJ0WkhtbVV3WWhmTk1UejhpTk1JdWpIa2Js?=
 =?utf-8?B?c1lWUlpsNFBFZ2RGa3FvVFJXc0tCVktIbDBoNEdMSXNVVzI3dGk5b0c1S1FE?=
 =?utf-8?B?MElJREV1UUV0MnhoNUwySnlOMGVheXhuUVNCVCtBbHJoOHFZZzlRODkrOVBQ?=
 =?utf-8?B?UzBNa29aK050MUdmZ2c5WVQyWVZLZUpIQ3JNUE9FbHREcWF4eVh0d3EveUts?=
 =?utf-8?B?dk85SE4zT1A0UENCT3ZVdHh4UVhTM0hnamVpRUQyZFQwQlVhTDVWdkJObFN2?=
 =?utf-8?B?QUVBZTdEekZKV2hrbktOa3dsZjgyVngwb2cvMXk0RUYybGh5MHA2R2hzUXJp?=
 =?utf-8?B?Y2JDaU5iMUpvQ2Z5ZWxFSDhHalUrOVFCNFVhK2Y2dFlhLzZSR1U1VW5RZTQ1?=
 =?utf-8?B?bTc5R1EzVnNhRnRiZjNmL3lvTGc5ckRldDBEZTZnaHhKVUp1YlEwUHFZWk85?=
 =?utf-8?B?MDJSaXl2bm9YYWFWckJZR0ZERUE2UUJUTFVMR0hKNTJPQ1RDSW1uTTlCaEs3?=
 =?utf-8?B?NkZiZTlOSG5pWEZpYjhUVWxsY2NPL01ZbGRNVUI0V3NkVmRPcXdCYVVsUmRE?=
 =?utf-8?B?RGJuVEFxT0JBMDVjOVVNam5EcXoxQ0Rna3o2UEZmYkJOcHJtaXE2TnM3VDNn?=
 =?utf-8?B?Mkp0WEpqanV2YU1KOTFrNXJOQklyZkx5ckk1RkpkUW1xL3FXVHRrUlFlNVI1?=
 =?utf-8?B?eHpVTml1Q1REeVAyTjdFcWRVZHJGdlgwd1paYnRuOW9MVjI0T1VLL2Q3aWEz?=
 =?utf-8?B?dkw5d1lkSm5OWlhkemVINFU1UjY1UC9abktwamxsc3hKQkprbzQvWkw3Rlh1?=
 =?utf-8?B?NmJiLytRdEhaZmoxdytHazVFUHZLdXIzVW9GaWQ0MEpqcmppd001MUxLYllW?=
 =?utf-8?B?T1h0ci9sOEkwZURsUmVMSGFFdUJSc25VY3BJeWg0YzlKK2RBRERnMEJhQVVa?=
 =?utf-8?B?U1hJVTFrZllvQ3p0RzJtWXArUk5GZEE1a05EbEdxOG9QRStCaXJQRkNxdG56?=
 =?utf-8?B?cXZrS0NtWHF5K1hmb3AvZ0U2MEV5czRsdi9qZ3k4VDNvaDRQVC82OUVyczcz?=
 =?utf-8?B?SVFqOWZmSmdBcTg4Y2R5RjJLOHhQM0Raak9Lb0VGQzJvdFBoQ2pJc2pWQTVD?=
 =?utf-8?Q?2jlreIdgNJeYY71?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a60b39-c589-4745-b39d-08dbb546022d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:14:09.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOUSnGErXXWTl75kkxu/k8iCYStPzygTXTi+JcHgqqNkMbQdij/e787eeYgaP9eD1MSyTZRoAwmX7PW5z1u9Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6219
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_09,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140150
X-Proofpoint-GUID: RQhoyvM7SZny74F-SBdDN_n5yoiz9W4O
X-Proofpoint-ORIG-GUID: RQhoyvM7SZny74F-SBdDN_n5yoiz9W4O

On 14/09/2023 14:05, pengdonglin wrote:
> On 2023/9/14 20:46, Alan Maguire wrote:
>> On 14/09/2023 11:13, pengdonglin wrote:
>>> On 2023/9/13 21:34, Alan Maguire wrote:
>>>> On 13/09/2023 11:32, pengdonglin wrote:
>>>>> On 2023/9/13 2:46, Alexei Starovoitov wrote:
>>>>>> On Tue, Sep 12, 2023 at 10:03 AM Eduard Zingerman <eddyz87@gmail.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> On Tue, 2023-09-12 at 09:40 -0700, Alexei Starovoitov wrote:
>>>>>>>> On Tue, Sep 12, 2023 at 7:19 AM Eduard Zingerman
>>>>>>>> <eddyz87@gmail.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
>>>>>>>>>> On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
>>>>>>>>>>> Currently, we are only using the linear search method to find
>>>>>>>>>>> the
>>>>>>>>>>> type id
>>>>>>>>>>> by the name, which has a time complexity of O(n). This change
>>>>>>>>>>> involves
>>>>>>>>>>> sorting the names of btf types in ascending order and using
>>>>>>>>>>> binary search,
>>>>>>>>>>> which has a time complexity of O(log(n)). This idea was inspired
>>>>>>>>>>> by the
>>>>>>>>>>> following patch:
>>>>>>>>>>>
>>>>>>>>>>> 60443c88f3a8 ("kallsyms: Improve the performance of
>>>>>>>>>>> kallsyms_lookup_name()").
>>>>>>>>>>>
>>>>>>>>>>> At present, this improvement is only for searching in vmlinux's
>>>>>>>>>>> and
>>>>>>>>>>> module's BTFs, and the kind should only be BTF_KIND_FUNC or
>>>>>>>>>>> BTF_KIND_STRUCT.
>>>>>>>>>>>
>>>>>>>>>>> Another change is the search direction, where we search the BTF
>>>>>>>>>>> first and
>>>>>>>>>>> then its base, the type id of the first matched btf_type will be
>>>>>>>>>>> returned.
>>>>>>>>>>>
>>>>>>>>>>> Here is a time-consuming result that finding all the type ids of
>>>>>>>>>>> 67,819 kernel
>>>>>>>>>>> functions in vmlinux's BTF by their names:
>>>>>>>>>>>
>>>>>>>>>>> Before: 17000 ms
>>>>>>>>>>> After:     10 ms
>>>>>>>>>>>
>>>>>>>>>>> The average lookup performance has improved about 1700x at the
>>>>>>>>>>> above scenario.
>>>>>>>>>>>
>>>>>>>>>>> However, this change will consume more memory, for example,
>>>>>>>>>>> 67,819 kernel
>>>>>>>>>>> functions will allocate about 530KB memory.
>>>>>>>>>>
>>>>>>>>>> Hi Donglin,
>>>>>>>>>>
>>>>>>>>>> I think this is a good improvement. However, I wonder, why did
>>>>>>>>>> you
>>>>>>>>>> choose to have a separate name map for each BTF kind?
>>>>>>>>>>
>>>>>>>>>> I did some analysis for my local testing kernel config and got
>>>>>>>>>> such numbers:
>>>>>>>>>> - total number of BTF objects: 97350
>>>>>>>>>> - number of FUNC and STRUCT objects: 51597
>>>>>>>>>> - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC
>>>>>>>>>> objects: 56817
>>>>>>>>>>      (these are all kinds for which lookup by name might make
>>>>>>>>>> sense)
>>>>>>>>>> - number of named objects: 54246
>>>>>>>>>> - number of name collisions:
>>>>>>>>>>      - unique names: 53985 counts
>>>>>>>>>>      - 2 objects with the same name: 129 counts
>>>>>>>>>>      - 3 objects with the same name: 3 counts
>>>>>>>>>>
>>>>>>>>>> So, it appears that having a single map for all named objects
>>>>>>>>>> makes
>>>>>>>>>> sense and would also simplify the implementation, what do you
>>>>>>>>>> think?
>>>>>>>>>
>>>>>>>>> Some more numbers for my config:
>>>>>>>>> - 13241 types (struct, union, typedef, enum), log2 13241 = 13.7
>>>>>>>>> - 43575 funcs, log2 43575 = 15.4
>>>>>>>>> Thus, having separate map for types vs functions might save ~1.7
>>>>>>>>> search iterations. Is this a significant slowdown in practice?
>>>>>>>>
>>>>>>>> What do you propose to do in case of duplicates ?
>>>>>>>> func and struct can have the same name, but they will have two
>>>>>>>> different
>>>>>>>> btf_ids. How do we store them ?
>>>>>>>> Also we might add global vars to BTF. Such request came up several
>>>>>>>> times.
>>>>>>>> So we need to make sure our search approach scales to
>>>>>>>> func, struct, vars. I don't recall whether we search any other
>>>>>>>> kinds.
>>>>>>>> Separate arrays for different kinds seems ok.
>>>>>>>> It's a bit of code complexity, but it's not an increase in memory.
>>>>>>>
>>>>>>> Binary search gives, say, lowest index of a thing with name A, then
>>>>>>> increment index while name remains A looking for correct kind.
>>>>>>> Given the name conflicts info from above, 99% of times there
>>>>>>> would be
>>>>>>> no need to iterate and in very few cases there would a couple of
>>>>>>> iterations.
>>>>>>>
>>>>>>> Same logic would be necessary with current approach if different BTF
>>>>>>> kinds would be allowed in BTF_ID_NAME_* cohorts. I figured that
>>>>>>> these
>>>>>>> cohorts are mainly a way to split the tree for faster lookups, but
>>>>>>> maybe that is not the main intent.
>>>>>>>
>>>>>>>> With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyte
>>>>>>>> extra memory. That's quite a bit. Anything we can do to compress
>>>>>>>> it?
>>>>>>>
>>>>>>> That's an interesting question, from the top of my head:
>>>>>>> pre-sort in pahole (re-assign IDs so that increasing ID also would
>>>>>>> mean "increasing" name), shouldn't be that difficult.
>>>>>>
>>>>>> That sounds great. kallsyms are pre-sorted at build time.
>>>>>> We should do the same with BTF.
>>>>>> I think GCC can emit BTF directly now and LLVM emits it for bpf progs
>>>>>> too,
>>>>>> but since vmlinux and kernel module BTFs will keep being processed
>>>>>> through pahole we don't have to make gcc/llvm sort things right away.
>>>>>> pahole will be enough. The kernel might do 'is it sorted' check
>>>>>> during BTF validation and then use binary search or fall back to
>>>>>> linear
>>>>>> when not-sorted == old pahole.
>>>>>>
>>>>>
>>>>> Yeah, I agree and will attempt to modify the pahole and perform a
>>>>> test.
>>>>> Do we need
>>>>> to introduce a new macro to control the behavior when the BTF is not
>>>>> sorted? If
>>>>> it is not sorted, we can use the method mentioned in this patch or use
>>>>> linear
>>>>> search.
>>>>>
>>>>>
>>>>
>>>> One challenge with pahole is that it often runs in parallel mode, so I
>>>> suspect any sorting would have to be done after merging across threads.
>>>> Perhaps BTF deduplication time might be a useful time to re-sort by
>>>> name? BTF dedup happens after BTF has been merged, and a new "sorted"
>>>> btf_dedup_opts option could be added and controlled by a pahole
>>>> option. However dedup is pretty complicated already..
>>>>
>>>> One thing we should weigh up though is if there are benefits to the
>>>> way BTF is currently laid out. It tends to start with base types,
>>>> and often-encountered types end up being located towards the start
>>>> of the BTF data. For example
>>>>
>>>>
>>>> [1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64
>>>> encoding=(none)
>>>> [2] CONST '(anon)' type_id=1
>>>> [3] VOLATILE '(anon)' type_id=1
>>>> [4] ARRAY '(anon)' type_id=1 index_type_id=21 nr_elems=2
>>>> [5] PTR '(anon)' type_id=8
>>>> [6] CONST '(anon)' type_id=5
>>>> [7] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>>>> [8] CONST '(anon)' type_id=7
>>>> [9] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>>>> [10] CONST '(anon)' type_id=9
>>>> [11] TYPEDEF '__s8' type_id=12
>>>> [12] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>>>> [13] TYPEDEF '__u8' type_id=14
>>>>
>>>> So often-used types will be found quickly, even under linear search
>>>> conditions.
>>>
>>> I found that there seems to be no code in the kernel that get the ID
>>> of the
>>> basic data type by calling btf_find_by_name_kind directly. The general
>>> usage
>>> of this function is to obtain the ID of a structure or function. After
>>> we got
>>> the ID of a structure or function, it is O(1) to get the IDs of its
>>> members
>>> or parameters.
>>>
>>> ./kernel/trace/trace_probe.c:383:       id = btf_find_by_name_kind(btf,
>>> funcname, BTF_KIND_FUNC);
>>> ./kernel/bpf/btf.c:3523:        id = btf_find_by_name_kind(btf,
>>> value_type, BTF_KIND_STRUCT);
>>> ./kernel/bpf/btf.c:5504:                id = btf_find_by_name_kind(btf,
>>> alloc_obj_fields[i], BTF_KIND_STRUCT);
>>> ./kernel/bpf/bpf_struct_ops.c:128:      module_id =
>>> btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
>>> ./net/ipv4/bpf_tcp_ca.c:28:     type_id = btf_find_by_name_kind(btf,
>>> "sock", BTF_KIND_STRUCT);
>>> ./net/ipv4/bpf_tcp_ca.c:33:     type_id = btf_find_by_name_kind(btf,
>>> "tcp_sock", BTF_KIND_STRUCT);
>>> ./net/netfilter/nf_bpf_link.c:181:      type_id =
>>> btf_find_by_name_kind(btf, name, BTF_KIND_STRUCT);
>>>
>>>>
>>>> When we look at how many lookups by id (which are O(1), since they are
>>>> done via the btf->types[] array) versus by name, we see:
>>>>
>>>> $ grep btf_type_by_id kernel/bpf/*.c|wc -l
>>>> 120
>>>> $ grep btf_find_by_nam kernel/bpf/*.c|wc -l
>>>> 15
>>>>
>>>> I don't see a huge number of name-based lookups, and I think most are
>>>> outside of the hotter codepaths, unless I'm missing some. All of which
>>>> is to say it would be a good idea to have a clear sense of what will
>>>> get
>>>> faster with sorted-by-name BTF. Thanks!
>>>
>>> The story goes like this.
>>>
>>> I have added a new feature to the function graph called
>>> "funcgraph_retval",
>>> here is the link:
>>>
>>> https://lore.kernel.org/all/1fc502712c981e0e6742185ba242992170ac9da8.1680954589.git.pengdonglin@sangfor.com.cn/
>>>
>>> We can obtain the return values of almost every function during the
>>> execution
>>> of kernel through this feature, it can help us analyze problems.
>>>
>>
>> It's a great feature!
> 
> Thanks.
> 
>>
>>> However, this feature has two main drawbacks.
>>>
>>> 1. Even if a function's return type is void,  a return value will still
>>> be printed.
>>>
>>> 2. The return value printed may be incorrect when the width of the
>>> return type is
>>> smaller than the generic register.
>>>
>>> I think if we can get this return type of the function, then the
>>> drawbacks mentioned
>>> above can be eliminated. The function btf_find_by_name_kind can be used
>>> to get the ID of
>>> the kernel function, then we can get its return type easily. If the
>>> return type is
>>> void, the return value recorded will not be printed. If the width of the
>>> return type
>>> is smaller than the generic register, then the value stored in the upper
>>> bits will be
>>> trimmed. I have written a demo and these drawbacks were resolved.
>>>
>>> However, during my test, I found that it took too much time when read
>>> the trace log
>>> with this feature enabled, because the trace log consists of 200,000
>>> lines. The
>>> majority of the time was consumed by the btf_find_by_name_kind, which is
>>> called
>>> 200,000 times.
>>>
>>> So I think the performance of btf_find_by_name_kind  may need to be
>>> improved.
>>>
>>
>> If I recall, Masami's work uses BTF ids, but can cache them since the
>> user explicitly asks for specific fields in the trace output. I'm
>> presuming that's not an option for you due to the fact funcgraph tracing
>> enables everything (or at least everything under a filter predicate) and
>> you have limited context to work with, is that right?
> 
> Yes, right.
> 
>>
>> Looking at print_graph_entry_leaf() which I _think_ is where you'd need
>> to print the retval from, you have access to the function address via
>> call->func, and I presume you get the name from snprinting the symbol to
>> a string or similar. So you're stuck in a context where you have the
>> function address, and from that you can derive the function name. Is
>> that correct? Thanks!
> 
> Yes, both print_graph_return and print_graph_entry_leaf will call
> print_graph_retval
> to print the return value. Then call sprint_symbol_no_offset with
> call->func to get
> the function name, then call btf_find_by_name_kind to get the return type.
>

So what you ultimately need is a way to map from that information
available to be able to figure out the size of the return value
associated with a function.

On the BPF side we've been thinking a bit about the relationship between
kernel function addresses and their BTF representations; sometimes
knowing BTF->address mapping is needed for cases where the same function
name has multiple inconsistent function signatures in BTF. We don't
represent function addresses yet in BTF but may end up having to.
The reason I mention this is in an ideal world, it would benefit to
populate kallsyms entries with their associated BTF ids; then a
function would need to be looked up once in kallsyms; that lookup would
benefit from recent speedups, and if it contained the associated BTF id
we'd have an O(1) lookup from the BTF id -> function. Not sure if that
would be tenable from the kallsyms side, but I just wanted to mention
it, as from the above it seems an address-based lookup is a possibility
to solve the return value type lookup problem that you're facing.

Cc'ed Jiri who had to wrestle with kallsyms for the kprobe multi stuff.
Would the above help do you think?

Thanks!

Alan

