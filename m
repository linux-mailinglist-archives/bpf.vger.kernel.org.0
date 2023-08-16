Return-Path: <bpf+bounces-7898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8827577E309
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 15:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C32281A36
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105011C8B;
	Wed, 16 Aug 2023 13:50:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A49DF60
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 13:50:13 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94083125;
	Wed, 16 Aug 2023 06:50:11 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GDmp3p032625;
	Wed, 16 Aug 2023 13:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=S+exLgjl2OMnMAg7ghRpfun9xWgBSib4lyss8W2PYHw=;
 b=rfS89HuGiisf857ZQZ5H4Go6LCkaG9oqXzMKXcslRN4SuDBUkOC1SRH/efcwZdRCfZ/f
 068ZeUzAplkYjY2HYqg0wIo/eM17WzA48nDor95wL65C2gQuvx4JztyLR+IMNiqaVMcc
 Cbf0xc56rtCXd7RqFemK7lffjDteBtuRPNHJIeaiDuvrDxu453QvSqa6hZ52bSROxjrY
 Nlrm8zcKMy4PvM6vDXmtUnuhS+dUMc0N94qkD9JFHps3Za4hbudzqOfacbSi+g2Af300
 KIOs9XfS3psItiRBPcxR8Fa3+Uq4b50tUOlzdH2RA54yORHXiRthdxiqoOzDfEdDPKaB BA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwq5ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 13:49:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37GDmmj2003669;
	Wed, 16 Aug 2023 13:49:28 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexyk8p83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Aug 2023 13:49:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux1TPBiL+SE0WTw5dGJglanXclpC3IMTYw2M/Y1wNwUW1lqGrrnL0bCiftOAHt3Ut8EemdnMcJvZlXAu/kyixVzd88/c0HOFYm+xiAFpscqSVpT9bRj5mh1BzSUfdFCkuKWtxjA4xfzZV26Pidz0sPO6207z5NswZzvxOsfZMPtZD2qF2xIxr27zoJxX6Ns0EXalx1VmMcYHQLuftSxk9LH9Yj850pbPmW37kTVUvvm4ebDHibngoKhv++sAfMUk9Z8u7Ty2mCUyElF9cZNZNdCdVtYbj9+0gyE0v60hVMnVmqRMolT+qXmF7i4ooGyv8tfR80LSWQ+zSQOf1K+RRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+exLgjl2OMnMAg7ghRpfun9xWgBSib4lyss8W2PYHw=;
 b=Rpruw/3WvuD50YXCvWtw+5leqnXbA7FdsHImzUVhobbXNFUcNYKJje2xSgwyYwtPu8bISY0isb4rzl+t03ve/mu4BETjeyHEcb/KfaSAMrRiDHDPe5TKqVWLgeVZ6goxVpQshWQHtxre72Hn6hK4P2s3davKGpOR7jzflQOLMe//v1oLpH/DCFOokatoCRdpfoDWkEflw5a4TuxUTYErpl3uLLzXy0/szREQrc6/k3yY8M8K8/Ws2sHlEPjVVekmexdi+ig2D1FDVSIdo2iVfIxwWiCCj0npT6pU/w5VqOXq90ReBGneLvxWyBZ1lGdWW1grpG6rW9EQuBLdqaNlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+exLgjl2OMnMAg7ghRpfun9xWgBSib4lyss8W2PYHw=;
 b=dwqSVtz+wlImbRhffBsOWpEPqPDERr1mXcxnvkF9OvedM2H1mBhrfyKDH4Ci+l+lq/E8afEb1tZfM9R4lNq/p9HfjSp5B0HRu2SnsFvHz1Oa9H9FVajHTRKkXHlXIMlC94Xvvv0dNtOvprbrkh4zZ5biyogjDBpLr7dYWsqmjhk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 13:49:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 13:49:25 +0000
Message-ID: <cb817ceb-3a26-844b-05fa-06394e4e025e@oracle.com>
Date: Wed, 16 Aug 2023 14:49:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 4/5] bpf: Add a OOM policy test
Content-Language: en-GB
To: Chuyi Zhou <zhouchuyi@bytedance.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, muchun.song@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
 <20230810081319.65668-5-zhouchuyi@bytedance.com>
 <5bb59039-4f3b-49b6-d440-3210d7a92754@oracle.com>
 <ae654476-5cc2-36ae-1047-eba196c9b38d@bytedance.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ae654476-5cc2-36ae-1047-eba196c9b38d@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0041.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 188df5c9-a28e-4c5b-2f50-08db9e5f9a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Sf69BjLA/MpZ1Tv8qaBPC6Mu5cj84v1JxNU3+EaJMb1u7uWmGRoIanBTRw90IWLov0z+9wpYb6EoxeYMmX3rqa4yMsYk0ioTnLhzup06xPodIz4t2/7rjtdxXTLls2BuK2l7R7oO4HzjPm9sAHoXiJUCp63Zf0gX1QkSaWWXB8to1XYGe5rPZtsy7nwhT2wNLQN8VKtBzzPupb/iLkE9L8GO4KZfYHk0jkFKMXvOJl7Co18MP/XlnaW4CMvK/tYM/MRSpoP6N8nRPMHMJA/PV7TP+NXuswj6JsVyxfu482i5balTiEskFn2yYG2fW+3GnYorR2MbFRowvcUkQy46yJoAm3ic/sjj420eNaBoBa7JOOLVLTJBHssPE/9Nb+80YLkVT2NFCuiAXSNfpsppJTpnZOc/EfhtcK3FTADm0pdEQ+HFLfXubO+roWYYb0rcrS9ClYo6hp8fRlFZMQZRrPJEIkO/U5UbM606uo9fxac7vN/PG7EpfbhTmWQdAbSpjrSCpvUms/kproZnI/mg5C/O5b0EwUkqbxJamb0jzuvQsYCFo9Pi0xsOGjdoWIcB5JPh4Nr0k380SGuLkcQ77IjQV8+KxdwdTLffJwmTIiU0gJUJfNvmEKUAh4AwUS9n0R3nMdtFFSZPVZK95M6mcQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(66946007)(66476007)(66556008)(966005)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(30864003)(2906002)(83380400001)(478600001)(7416002)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZVAwZkt4S0U0U25JUU9LdnFHSG1CTjhjd0t4VzBEcm1laUxWWDVlVjdzTGJz?=
 =?utf-8?B?S2hPRUt6Mkx5eDlaajVBWDc4blRHMndLNWdtb0h0enpucmFNdVU5Zjc1YjQ2?=
 =?utf-8?B?ZkpqaE5uN3Vya3hkYm50dkZlSkxmMVpkNnlHUmFwNkZ5a2REYmNENStObkpW?=
 =?utf-8?B?OGJHbXFwR3Y0alVTR2phdWFWa0M0dzZLT3czNFZmRTRrVlJ0MnZtSlhEMTUx?=
 =?utf-8?B?TkFKbjU4Z2FldlZhSGcydVdraGk5b0wxL0J6ckdoK2hTUXJqWjZmZVU4TnlH?=
 =?utf-8?B?V0dRNGZhVG8vOWVKVFhkblR5U0JNNkRoMHhMMitCVjFpS3VWL2FpM2JIcUsy?=
 =?utf-8?B?SERsaysvVEhwNkhZc2R5Q2t1a2RybGdPNnAxQlh2ZW5RUGUwUUk0bTdYTEty?=
 =?utf-8?B?cDI3ZzB1T09VekdFelRvcXdiNDZuMDVCbGp5eHI3azZQdTFobkZVMExPdndt?=
 =?utf-8?B?a1kzSlBEWlBnK2FBUEF5YlVYc3RWRnhpNm55azlTZ3MySFRueVNpc3RqSGpW?=
 =?utf-8?B?NS82TUd5WllKeUsxUm1nZXI2SHVtMmcvakFIdkZ6VFcvNGpJS2FhZ004cHhM?=
 =?utf-8?B?MmJoQ1pzMTZQOFUvUmp6RFVKcjhSRUVLSnpRam5BU0twMWsyeUdyU0dmWngz?=
 =?utf-8?B?SlVJQnJhWDdrUjNSdGVGekVTV3Rad2todmdzV1dEWU1hcUFHVmYzV1p6c01F?=
 =?utf-8?B?M3F5Ri9tcnRTcXZaalYxWERZcjFBN0xUUDZhOC9ST0YwR1owNVBoT1doTVQy?=
 =?utf-8?B?NlFieU1tZmpucHhrTXBYTUJpdDAzVkkxWnNCSElXUlZOU2lpa0xlUzAzby9q?=
 =?utf-8?B?MDl1Q0JwcFVuRmpSWW43emhOSEM5NkVYR0VYMmc4NnpERng4V0FLdTgrSi9k?=
 =?utf-8?B?b00wZ25sb2taWHlUSGpDRnlzaU9zR2V0cGFRelhaRFMzeEFQaFEvN1RVb0ts?=
 =?utf-8?B?WXRRVjdVRWxXMWJia0VPOXRMakxXZlc0RDVHbnFHRnYwQTVpTWtDOWlTcWZi?=
 =?utf-8?B?NVkyQk5WaTRSRzV4OHJ3dXJIRDJrcDBLR2NJdmpGanpDeWx2Q0licEQ0cnRp?=
 =?utf-8?B?T1BwSCs5YUhtVndaRTAyMnRvdjkzMExoclNGclRta1UySnFVbXJaMlArSUlH?=
 =?utf-8?B?aDR2TzUwZ0RjR0Z0RUNQVHFJWGNaZHBjVmlNQjhnZG9MY2FtVEtWbDdIREQr?=
 =?utf-8?B?NWZmNmJJdHN1NXEyUWFWdUpGTzYrYWNLVlM5c1FuNnoxS2hZM0t4Um9rQXJO?=
 =?utf-8?B?ZTk1UHhaQmUvbVVuOVlEbjZKTDV0RVJCYjM0SlNLTzVnTDNYbHFoR2pNbDVX?=
 =?utf-8?B?OGdTMEpJTW9JTUd1VW1sVjNDQVFySmxwd3FJa2xqNVZWREdacUZkb0VyU2xB?=
 =?utf-8?B?SFFvamVGNDNFR1lKbFJSMmoxSkVVcFpydEs2ank4OXFFWTQ4UVYvN1JFMU5Y?=
 =?utf-8?B?MGdQQ0VYM0RWNXM5azViV0RlNzNUc3oza3JRNy9JUjloVStKalJVVEp3TzYz?=
 =?utf-8?B?b2QzWWtTT1B6U2t2bEhjNXVYZldlNWlNaU9scHVWdDM2dEdPTURpeFZlZlla?=
 =?utf-8?B?N1E0eVdKS0l5bEp0dUtJakJtc0V5dWdJc2lhcHBudnNpenlCYzRWZXEvQnBh?=
 =?utf-8?B?YVVndjJBb1NGei85dUk0K1ZZQVBCblZTTldEaDFNUDRpRlVDMGpGcmJMcGlm?=
 =?utf-8?B?SjF1bWZoamYrdzlzZTZIVDdPYVhJVzlGclhEeUxKMlljWkI4THcrVWpaTFht?=
 =?utf-8?B?anJENEQ1MEtiaVJJY1ZCcUd3UGROSzlwTTNOR2F0V29YRDJsN3N3K2k0dVdS?=
 =?utf-8?B?dWRoZ0FSZFk3VFVhdFl1UjZkQ2ZjY21YMnIvbTlzQ0pkNUZtM24yOENQTnlC?=
 =?utf-8?B?NkRvWVhlakgwNGJ1RDI5bThDbkJQWjBjWTFzWnRBWlFBZ01nQnVEQTkzOVpr?=
 =?utf-8?B?TUU3RG1YVC9wNlpKYzhqTStXYzRSSEtPbHNtRHF4RVBObEVLZHd6c3hPM3Zh?=
 =?utf-8?B?cnJId09wUlBZOS9vMnc0MUJ5OXIraU01RTlBVFJ6NXU5YlVrdkhPQzFUb2dS?=
 =?utf-8?B?TW9Ud1JNM3RCbzJRWEwxekN5M0JhaFlGdGJmb1FiMkJCWWFaUDYrb1REbkh3?=
 =?utf-8?B?V3c0b2NCWDN6d3NnRUp4QTY5MXl1V2oxczZwTVhYWVBMUDdmU2VVemFjbE80?=
 =?utf-8?Q?MaDDyfjP8Eo10oDJfEtLSOo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JbWckA1zRVqGCGqoq4sJSKzazV9b01cdCrRuBJAmy+u2tbpcshDi0JjlN7jqej3r/RIVZ9NrFOxTy68+sLQK4PiOXZ2ONEQDaSA3yqCgFFeFP55tTWmJqh2qEUdkwML8iu5ggvcPzRgpeblcdmjh8v+2lZIaDGkJ346zVbcQMesvgS+SkkUHq/NQiFDmNP67mfjLnHbRTA74GsTxwFcFyfm4HnYcjLILt+95xWYL88OZRE2L9vWuvZol3Ut+mTHekVaiT+N2VOkEwuQLEwmWnffgpMeXb+ydSxqMorcHw19PAyflSGAMSwp9yu88g4i3iz0fxmvnrMB9fZJ5vc6QB+Mrhbxm4EULHKtqhHYE2zhdwctifd509ssffyQNOhO66HJ5pbPwPw+E73UYRM+sI5Qs1Qgqo0rhWUdq3MPAXTfnie23xWm1960itdrCjAyXS7wVSrE8rnuZZSItsbckiMcShfwI0Wzp/vDyGIKVNCPzBGbt6EmIREcxqXR0bo1Jy6Bqp6SZX1QQp4vYIr5TPK79RDZ7Z9CpgqUoJUOqds6ahUDOT5W6HFidRndt1aECQeMSQwQxicVLBB9EToo0V7lA1/E/jM44Lr9PGPJsO8ZrIaf+ZCYdbjwGErO0P8l18cYdTbpyV6Fbukv4UErW95yuuvZJHEjNlq00nkyr5TZZYMZoNGjtOnCdfVTS1rGZ7+ZokYhQLiYDB7TSWJBydIzaOUz5U44WlDe4D/SWFF3TEW2UKt+KmHtRi305/aMrMxJUZe+nZ1cdzDmGvquz7hmwYaRpru2YyCepwTsi3T6Q7+6rbHnlmBqYHvQDxatbSGcit+1SDuhROLRvIiQJ56y7jMul7/FQ6WZSAlPi4Dcgz3JNikpJUpxLAFcXSmmQds9LYmI3zOUrGOwoNwIIH43Z77UhIHWYLnhAeh5u/C0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188df5c9-a28e-4c5b-2f50-08db9e5f9a83
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:49:25.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EO/mDnlGfYPcpt64vjvUuQbonWdXfDW1GcWup4npG2n0914udI4QtjHagh+l01KBRw0MZAXs1b0WQaY/e33ZjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_13,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160119
X-Proofpoint-ORIG-GUID: h6WXwbLT1zh7duB7BCcSBwXvLLEPi_dp
X-Proofpoint-GUID: h6WXwbLT1zh7duB7BCcSBwXvLLEPi_dp
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 16/08/2023 13:31, Chuyi Zhou wrote:
> Hello,
> 
> 在 2023/8/16 19:53, Alan Maguire 写道:
>> On 10/08/2023 09:13, Chuyi Zhou wrote:
>>> This patch adds a test which implements a priority-based policy through
>>> bpf_oom_evaluate_task.
>>>
>>> The BPF program, oom_policy.c, compares the cgroup priority of two tasks
>>> and select the lower one. The userspace program test_oom_policy.c
>>> maintains a priority map by using cgroup id as the keys and priority as
>>> the values. We could protect certain cgroups from oom-killer by setting
>>> higher priority.
>>>
>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>> ---
>>>   .../bpf/prog_tests/test_oom_policy.c          | 140 ++++++++++++++++++
>>>   .../testing/selftests/bpf/progs/oom_policy.c  | 104 +++++++++++++
>>>   2 files changed, 244 insertions(+)
>>>   create mode 100644
>>> tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>>>   create mode 100644 tools/testing/selftests/bpf/progs/oom_policy.c
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>>> b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>>> new file mode 100644
>>> index 000000000000..bea61ff22603
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
>>> @@ -0,0 +1,140 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +#define _GNU_SOURCE
>>> +
>>> +#include <stdio.h>
>>> +#include <fcntl.h>
>>> +#include <unistd.h>
>>> +#include <stdlib.h>
>>> +#include <signal.h>
>>> +#include <sys/stat.h>
>>> +#include <test_progs.h>
>>> +#include <bpf/btf.h>
>>> +#include <bpf/bpf.h>
>>> +
>>> +#include "cgroup_helpers.h"
>>> +#include "oom_policy.skel.h"
>>> +
>>> +static int map_fd;
>>> +static int cg_nr;
>>> +struct {
>>> +    const char *path;
>>> +    int fd;
>>> +    unsigned long long id;
>>> +} cgs[] = {
>>> +    { "/cg1" },
>>> +    { "/cg2" },
>>> +};
>>> +
>>> +
>>> +static struct oom_policy *open_load_oom_policy_skel(void)
>>> +{
>>> +    struct oom_policy *skel;
>>> +    int err;
>>> +
>>> +    skel = oom_policy__open();
>>> +    if (!ASSERT_OK_PTR(skel, "skel_open"))
>>> +        return NULL;
>>> +
>>> +    err = oom_policy__load(skel);
>>> +    if (!ASSERT_OK(err, "skel_load"))
>>> +        goto cleanup;
>>> +
>>> +    return skel;
>>> +
>>> +cleanup:
>>> +    oom_policy__destroy(skel);
>>> +    return NULL;
>>> +}
>>> +
>>> +static void run_memory_consume(unsigned long long consume_size, int
>>> idx)
>>> +{
>>> +    char *buf;
>>> +
>>> +    join_parent_cgroup(cgs[idx].path);
>>> +    buf = malloc(consume_size);
>>> +    memset(buf, 0, consume_size);
>>> +    sleep(2);
>>> +    exit(0);
>>> +}
>>> +
>>> +static int set_cgroup_prio(unsigned long long cg_id, int prio)
>>> +{
>>> +    int err;
>>> +
>>> +    err = bpf_map_update_elem(map_fd, &cg_id, &prio, BPF_ANY);
>>> +    ASSERT_EQ(err, 0, "update_map");
>>> +    return err;
>>> +}
>>> +
>>> +static int prepare_cgroup_environment(void)
>>> +{
>>> +    int err;
>>> +
>>> +    err = setup_cgroup_environment();
>>> +    if (err)
>>> +        goto clean_cg_env;
>>> +    for (int i = 0; i < cg_nr; i++) {
>>> +        err = cgs[i].fd = create_and_get_cgroup(cgs[i].path);
>>> +        if (!ASSERT_GE(cgs[i].fd, 0, "cg_create"))
>>> +            goto clean_cg_env;
>>> +        cgs[i].id = get_cgroup_id(cgs[i].path);
>>> +    }
>>> +    return 0;
>>> +clean_cg_env:
>>> +    cleanup_cgroup_environment();
>>> +    return err;
>>> +}
>>> +
>>> +void test_oom_policy(void)
>>> +{
>>> +    struct oom_policy *skel;
>>> +    struct bpf_link *link;
>>> +    int err;
>>> +    int victim_pid;
>>> +    unsigned long long victim_cg_id;
>>> +
>>> +    link = NULL;
>>> +    cg_nr = ARRAY_SIZE(cgs);
>>> +
>>> +    skel = open_load_oom_policy_skel();
>>> +    err = oom_policy__attach(skel);
>>> +    if (!ASSERT_OK(err, "oom_policy__attach"))
>>> +        goto cleanup;
>>> +
>>> +    map_fd = bpf_object__find_map_fd_by_name(skel->obj, "cg_map");
>>> +    if (!ASSERT_GE(map_fd, 0, "find map"))
>>> +        goto cleanup;
>>> +
>>> +    err = prepare_cgroup_environment();
>>> +    if (!ASSERT_EQ(err, 0, "prepare cgroup env"))
>>> +        goto cleanup;
>>> +
>>> +    write_cgroup_file("/", "memory.max", "10M");
>>> +
>>> +    /*
>>> +     * Set higher priority to cg2 and lower to cg1, so we would select
>>> +     * task under cg1 as victim.(see oom_policy.c)
>>> +     */
>>> +    set_cgroup_prio(cgs[0].id, 10);
>>> +    set_cgroup_prio(cgs[1].id, 50);
>>> +
>>> +    victim_cg_id = cgs[0].id;
>>> +    victim_pid = fork();
>>> +
>>> +    if (victim_pid == 0)
>>> +        run_memory_consume(1024 * 1024 * 4, 0);
>>> +
>>> +    if (fork() == 0)
>>> +        run_memory_consume(1024 * 1024 * 8, 1);
>>> +
>>> +    while (wait(NULL) > 0)
>>> +        ;
>>> +
>>> +    ASSERT_EQ(skel->bss->victim_pid, victim_pid, "victim_pid");
>>> +    ASSERT_EQ(skel->bss->victim_cg_id, victim_cg_id, "victim_cgid");
>>> +    ASSERT_EQ(skel->bss->failed_cnt, 1, "failed_cnt");
>>> +cleanup:
>>> +    bpf_link__destroy(link);
>>> +    oom_policy__destroy(skel);
>>> +    cleanup_cgroup_environment();
>>> +}
>>> diff --git a/tools/testing/selftests/bpf/progs/oom_policy.c
>>> b/tools/testing/selftests/bpf/progs/oom_policy.c
>>> new file mode 100644
>>> index 000000000000..fc9efc93914e
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/oom_policy.c
>>> @@ -0,0 +1,104 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +#include <vmlinux.h>
>>> +#include <bpf/bpf_tracing.h>
>>> +#include <bpf/bpf_helpers.h>
>>> +
>>> +char _license[] SEC("license") = "GPL";
>>> +
>>> +struct {
>>> +    __uint(type, BPF_MAP_TYPE_HASH);
>>> +    __type(key, int);
>>> +    __type(value, int);
>>> +    __uint(max_entries, 24);
>>> +} cg_map SEC(".maps");
>>> +
>>> +unsigned int victim_pid;
>>> +u64 victim_cg_id;
>>> +int failed_cnt;
>>> +
>>> +#define    EOPNOTSUPP    95
>>> +
>>> +enum {
>>> +    NO_BPF_POLICY,
>>> +    BPF_EVAL_ABORT,
>>> +    BPF_EVAL_NEXT,
>>> +    BPF_EVAL_SELECT,
>>> +};
>>
>> When I built a kernel using this series and tried building the
>> associated test for that kernel I saw:
>>
>> progs/oom_policy.c:22:2: error: redefinition of enumerator
>> 'NO_BPF_POLICY'
>>          NO_BPF_POLICY,
>>          ^
>> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75894:2:
>> note: previous definition is here
>>          NO_BPF_POLICY = 0,
>>          ^
>> progs/oom_policy.c:23:2: error: redefinition of enumerator
>> 'BPF_EVAL_ABORT'
>>          BPF_EVAL_ABORT,
>>          ^
>> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75895:2:
>> note: previous definition is here
>>          BPF_EVAL_ABORT = 1,
>>          ^
>> progs/oom_policy.c:24:2: error: redefinition of enumerator
>> 'BPF_EVAL_NEXT'
>>          BPF_EVAL_NEXT,
>>          ^
>> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75896:2:
>> note: previous definition is here
>>          BPF_EVAL_NEXT = 2,
>>          ^
>> progs/oom_policy.c:  CLNG-BPF [test_maps] tailcall_bpf2bpf4.bpf.o
>> 25:2: error: redefinition of enumerator 'BPF_EVAL_SELECT'
>>          BPF_EVAL_SELECT,
>>          ^
>> /home/opc/src/bpf-next/tools/testing/selftests/bpf/tools/include/vmlinux.h:75897:2:
>> note: previous definition is here
>>          BPF_EVAL_SELECT = 3,
>>          ^
>> 4 errors generated.
>>
>>
>> So you shouldn't need the enum definition since it already makes it into
>> vmlinux.h.
>> OK. It seems my vmlinux.h doesn't contain these enum...
>> I also ran into test failures when I removed the above (and compilation
>> succeeded):
>>
>>
>> test_oom_policy:PASS:prepare cgroup env 0 nsec
>> (cgroup_helpers.c:130: errno: No such file or directory) Opening
>> /mnt/cgroup-test-work-dir23054//memory.max
>> set_cgroup_prio:PASS:update_map 0 nsec
>> set_cgroup_prio:PASS:update_map 0 nsec
>> test_oom_policy:FAIL:victim_pid unexpected victim_pid: actual 0 !=
>> expected 23058
>> test_oom_policy:FAIL:victim_cgid unexpected victim_cgid: actual 0 !=
>> expected 68
>> test_oom_policy:FAIL:failed_cnt unexpected failed_cnt: actual 0 !=
>> expected 1
>> #154     oom_policy:FAIL
>> Summary: 1/0 PASSED, 0 SKIPPED, 1 FAILED
>>
>> So it seems that because my system was using the cgroupv1 memory
>> controller, it could not be used for v2 unless I rebooted with
>>
>> systemd.unified_cgroup_hierarchy=1
>>
>> ...on the boot commandline. It would be good to note any such
>> requirements for this test in the selftests/bpf/README.rst.
>> Might also be worth adding
>>
>> write_cgroup_file("", "cgroup.subtree_control", "+memory");
>>
>> ...to ensure the memory controller is enabled for the root cgroup.
>>
>> At that point the test still failed:
>>
>> set_cgroup_prio:PASS:update_map 0 nsec
>> test_oom_policy:FAIL:victim_pid unexpected victim_pid: actual 0 !=
>> expected 12649
>> test_oom_policy:FAIL:victim_cgid unexpected victim_cgid: actual 0 !=
>> expected 9583
>> test_oom_policy:FAIL:failed_cnt unexpected failed_cnt: actual 0 !=
>> expected 1
>> #154     oom_policy:FAIL
>> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>> Successfully unloaded bpf_testmod.ko.
>>
>>
> It seems that OOM is not invoked in your environment(you can check it in
> demsg). If the memcg OOM is invoked by the test, we would record the
> *victim_pid* and *victim_cgid* and they would not be zero. I guess the
> reason is memory_control is not enabled in cgroup
> "/mnt/cgroup-test-work-dir23054/", because I see the error message:
> (cgroup_helpers.c:130: errno: No such file or directory) Opening
>> /mnt/cgroup-test-work-dir23054//memory.max

Right, but after I set up unified cgroup hierarchy and rebooted, that
message disappeared and cgroup setup succeeded, _but_ the test still
failed with 0 victim_pid/cgid.  I see nothing OOM-related in dmesg, but
the toplevel cgroupv2 cgroup.controllers file contains:

cpuset cpu io memory hugetlb pids rdma

Is there something else that needs to be done to enable OOM scanning?
I see the oom_reaper process:

root          72       2  0 11:30 ?        00:00:00 [oom_reaper]


This test will need to pass BPF CI, so any assumptions about
configuration need to be ironed out. For example, I think you should
probably have

diff --git a/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
index bea61ff22603..54fdb8a59816 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_oom_policy.c
@@ -109,6 +109,7 @@ void test_oom_policy(void)
        if (!ASSERT_EQ(err, 0, "prepare cgroup env"))
                goto cleanup;

+       write_cgroup_file("/", "cgroup.subtree_control", "+memory");
        write_cgroup_file("/", "memory.max", "10M");

        /*

...to be safe, since

https://docs.kernel.org/admin-guide/cgroup-v2.html#organizing-processes-and-threads

...says

"No controller is enabled by default. Controllers can be enabled and
disabled by writing to the "cgroup.subtree_control" file:

# echo "+cpu +memory -io" > cgroup.subtree_control

"

Are there any other aspects of configuration like that which might
explain why the test passes for you but fails for me?

Alan

