Return-Path: <bpf+bounces-21538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F086C84E930
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBB32859DA
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430F383A9;
	Thu,  8 Feb 2024 19:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gb2W1HJw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SCeDZps2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A20381D1
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422113; cv=fail; b=rPSDDPM+nbnf7IyYnbE7dsFi2sZ08OEe9T9QY+0OZwoGy7kUmKi3u7I7qfLHS91elhshCAZoMcoe+/kGbypiUUjGe4f2HaBpthtQ9vpaZq4TZKFdo1QlplS+5AEto55NZiTT55EjjaDiDNJJss7cgoxeXVYY++Cj6YscuX2ooEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422113; c=relaxed/simple;
	bh=LnUNCYAy0s/ppBlAVR83Qr197eJb3HShn7o0zOcz+6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=H4xKwP1ydLaBO3KQp+/IXKU20a1Wm1vp8ryEPAo/HRiFMHrnZZuw/SnpsxveXnjVHyvb/Ifsg3AJ2PKmhGC6WhBckJWRTfgWQ97Ii8HOCpV9oF9s6zS9n/Ge8Awxt8CC/QEJW7vZQIUvLeSvznD3ZBeMa39qkcMiLkAbs28ISgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gb2W1HJw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SCeDZps2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418Jn3cU005849;
	Thu, 8 Feb 2024 19:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6kZVxsa8XwCsrzqfSgRjWdCEqBeOwBmm5uUli7jbuHg=;
 b=gb2W1HJwF+4eec9iHdYXLaAkf2leEkGqBpDf6Oxs+8y7HM25dubX6K47uHm100jN8pB4
 4hqvg0xzUFxe7RL7EGanyJ3bYB4mCJCDpTyE8HNwu618Id7lKu88WmVZWOT4QsAP8ij5
 7jVHDaf7D25GMOrGe98QwOYgYCzXNuRYyXv4KVc2qwcGV8FBe+/jSvQmx7KfciY1O50p
 7ggVxml3m9gc+NuEOXmSR6kgKdJjHVzwVvblpL2OaTs1aZV/kvjkytzrSTDToMytmsnR
 Yx9HWVCFMSmqkjQERuaahf75lWL4WeEkA/qTCIzu9LI+E7wvreng7vx6nyIYibHDPWBD nQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwewhpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 19:55:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418ItXbH039463;
	Thu, 8 Feb 2024 19:55:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxawsdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 19:55:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgKQlf58+aBWoUxfMDEh9PlGZiOVdQIK+egCw8onqR+FNTy7NL7wmug9CWq83nOPXv269FjGU6HNSQTE6hAnLUsOzXXNBYlV5gFJTpOCMPn0RUilxT6u69Lye+CxFY4dsDV1hBx9lnKZgyF2+ZQG5NB/x+wrszO1l2CZwxuP7gSHuWWQuK3U1IDRI7PgbEjSP+ij4cx9jaMn0E2uR2x7Kqt6+81IzuasTZAPpaCGaJale7Q3k5oCrX3GNdfByC6/geDFDVMsaBJ/fv6hAt6aCmFsPwtVubsCdVnv2q3DBGkTEdUpTsOycMzwIa6LOkLQppTmLSEHezMu+PxPLAEyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kZVxsa8XwCsrzqfSgRjWdCEqBeOwBmm5uUli7jbuHg=;
 b=g8s2jl7vUuocfV0u/XXlu/KdVp/py7ZW9UF4bY689hHFwKNlsmW9x0/BrAt/xPo8mJT83laf+df0+Em4HJ046wi7llhVI07fQoGOh+DChsKlnPmQ4yRZYSD7+rkZxgSGBmcSETboDbIkD0wz+6VkZDnkDqaROUL5sSS/vMqSUxFMVEyfGqg350xBGBBpUHn1Mktczqo+Qn0/j4eblNVGu3Ghs32bVv4dXxmsHSNgyQW1RAk1GTDSaLMb2BHyuPmg9Zw7ZsQGZdXVITPXy0zJMGrvaBWmliU32twri0be791+kq2GDTqrCCuzvKzElGh7i6ehF3ZO6ooWBEhgz9IlNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kZVxsa8XwCsrzqfSgRjWdCEqBeOwBmm5uUli7jbuHg=;
 b=SCeDZps2jx87HLkmid3J7ZJhPGVcjcmmHl4KkF35A2Fyj7tpVjDHl9zBgrmtPJ0tCifyD21hM28n+YbcBHpWYoh01oHmjk3CiEEWinvyo7nwUEqocf4uLa7wM+LxrvP//jvkOyWFTCGeNrfplHSFn7/1n+goANSsxnFGHmKo9wY=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CH3PR10MB7117.namprd10.prod.outlook.com (2603:10b6:610:126::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 19:55:04 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 19:55:04 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org,
        Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com
Subject: Re: [PATCH] libbpf: add support to GCC in CORE macro definitions
In-Reply-To: <CAEf4BzZ5=E+EFs4vccWr-NPpqHej915w-GQfhSG=F1RaAJXB-A@mail.gmail.com>
	(Andrii Nakryiko's message of "Thu, 8 Feb 2024 10:50:16 -0800")
References: <87v86z150o.fsf@oracle.com>
	<CAEf4BzZ5=E+EFs4vccWr-NPpqHej915w-GQfhSG=F1RaAJXB-A@mail.gmail.com>
Date: Thu, 08 Feb 2024 20:54:57 +0100
Message-ID: <87wmreafzi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CH3PR10MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fe22cd-7abc-4eee-0a85-08dc28dfd7e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WAW5guKW6qJcDyIFe/4R5bsg8ZYX2aMqpulErqfcMimi982XrQUzusoJsMBMBsXUKt8CWC6UwY5z7J5ch/bLDd4TP703OJxlINSExhGlyDIooKEC8JUTaEqSXia2Hm2C6h1u7occE0rE1PQmQemvjoi6UOVc4AQ4vuNLgwXskdgzo8yMth+cMaVoycU5kgywCexeGOS653j3Ftl6Dyr0qRv3kkdhRaLGJF5KuaEYg+GsjC7z9HPsnbKTwmIuCIJ2k3Fxcj5YGgI7cNciJGxTgwXUS98YzDMIEoM6odOtb83+Fgige0JOtLaG5m+/xmUwDjz3ei8JmpxwZRptFQZ98FZtvZHH+E0CxhORWN2viosyM/imSKo86xUkx1hNHn5V2AH3K392G5RlqLwoz6hlgdMi0LAfDXnX5rnvJ/gl9xBiRGTNbK8MpTeGOq2hrZKuXH7grjfPqKYv1H1xTNrP0sFccJFt+Gy/TOa0mamEJkDW2yOp6Ob849VHYM5ney5URGmhNmojRKzoB7iISCRhuq4hAiqHlU6r2oiKO9rmh9epAMdTFat7eECU/GZa1CyR
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(86362001)(41300700001)(2906002)(83380400001)(38100700002)(2616005)(26005)(6486002)(107886003)(6512007)(5660300002)(6506007)(53546011)(6666004)(478600001)(66946007)(8936002)(66556008)(6916009)(54906003)(66476007)(316002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dU9hWDA4M1ZiVDVLa3NNMTFWRXpkazNINHRvaWp5THFJODBlK096YzYxakoy?=
 =?utf-8?B?UWdzUnNObVV4SS9Zb2FlcWJoNHRURmRTN1QrOVJ4SHFGWU9rd1JYODZSRUNo?=
 =?utf-8?B?bFFydWl1dUF3MEczWlJ3T0lwQW13T082NTFOTlB0bFdrMlBZM0tndSs5eXVJ?=
 =?utf-8?B?Z2x2VFpPRVJoVzRONGxFaUdTRFFJMnJTMDBmbk5OcGFKSVVUTFFuUy9WV0Z5?=
 =?utf-8?B?eGNCWFhyWGdySVE3TkFLOGVzU1lZRE4xR3FQQ2tzRGlLb2ZEdWhKVW4vNEs3?=
 =?utf-8?B?UG5OYjRmRTBscEw3dU1ZNEhQdkg0VlR0SUc4cTk4T2NqeWtSMDRxYklPQ2VF?=
 =?utf-8?B?Q1d2Y2laN2VEOUNqdGI3SE5LTEQ0eUdFb3hSNytlclpZcHhTaXRhQ2xuRlBH?=
 =?utf-8?B?RnZtN0YycVEvNVRkWTRDV2M3MHVyblJKTU14eUtyUGJjeGtIQmdmUEFvU2xE?=
 =?utf-8?B?T01yMmF3SzdCSk9tVldabTNzOWpraVhYR0FGL29FOVJTUy9OTFlBSTZPbmhh?=
 =?utf-8?B?ZHVOV2FWWERIN0dzWVFJcHEvc2VkaU1YVVBONzB1amIreEJLY0RScTV0bkpR?=
 =?utf-8?B?dmQ4WEFzSzQ2T0RxUytVbU5lT3lqQU5pWFc0RnhzR25nSVlMR2xlSFhMdEd0?=
 =?utf-8?B?RmM4QWYvSzBZcG93d1luc3ZvUTREQ3I4ajRaa0xENDlQNVd0VDRQQlhkaEdv?=
 =?utf-8?B?V2RoTWUveXUvcDB5OXZjbDBqMnZzNUVwM2l1WTBZMHhkTE03bDFHVnBIL0Ro?=
 =?utf-8?B?ZE9pY2IvREZ6cUZBQmhxRnBVTjFsRnlDbURPUitGOEU3ZlVFTVpPaTFOaTV3?=
 =?utf-8?B?dWtWc0poNWxnM2d1L3J3eGY5UHZKclBlSjVPYkk3Qy9XM3BsSVNsbEJrYXpJ?=
 =?utf-8?B?NjMxemZwcExKVXQ4bVpQYzFrREd2TjBOMEsxUkE4YzBlSjBDeTFxN1BHOG00?=
 =?utf-8?B?WmlPVlo2aW1RcGFSSEtJemNkMHlGaGN0QlRsWFVuOXIrWndEVXBoVWpFZXhs?=
 =?utf-8?B?S0xpUUtGVWIrdVllTGtOeHdpSVRNZ1h5NCtKQS80UXRBcHpSWXdEU2ZnNVFF?=
 =?utf-8?B?cng4SHg3N1R0OThNUVRTUWlseVRvbC9nK21keXptNDdVeDA1eVFaUzBoNE14?=
 =?utf-8?B?SUxTUW9YWWZQbjZneE9nQitFenIvUS9za04xQmV2SjEyOVkrVERBZjhWeHNF?=
 =?utf-8?B?azQ2N2FBRXlLYThYZnZnRXBPTEZUb0R2QmJTbmdSZ1BwN1A2Y1JNRkQzb0Rm?=
 =?utf-8?B?bVZLR2JoaksrMlA5UzNVSlRrc1Jvd0htSlBSM2NJcytxeFJ5RXNXQUF2SzNB?=
 =?utf-8?B?ZTBvWUVTTDE5Qnd2bTVDQ3hhUW9RekJRa1lkM3NsdW5WNk56ZHNmalpjL25C?=
 =?utf-8?B?RHR1R1RKY3J6ZnpaVzUwUi9zb1dtb0FDQkdWNGFramYwZXU5SElPcStuT2sx?=
 =?utf-8?B?RTQvSDdyeHNlSGQ3Zng5U0ppWnhNREFWcldhSGFHRVQ2NmZxSHp0NmZwZDJs?=
 =?utf-8?B?RGlNVXpETEhFN3d2OXM4OHFMUXpMb21VUmNjK3FjT1h1SkpCYTNkN2dLcEJq?=
 =?utf-8?B?S1NaRHV4cmp2OXpwaVVDK0cvbnArVFAreENDM3IvMmZhOXcrbUhOVmxLMC9i?=
 =?utf-8?B?T2Q2cHV0M0FlcHZMa01sU1Z4dnBKRVRQMkRMeTNKYWx4cjhPRHFuRnVPK1BV?=
 =?utf-8?B?TkJQeC9yT0lGdjNzVDY4T09VUER3ZG9RSlBEbUlxaUVKNDFvWkVLYXNHR01E?=
 =?utf-8?B?MzRRbjZUVGhQVUsvR2M3ZngvWThSVjdSei9IZGd2UnYxbFNyTUt6NlRqWVBo?=
 =?utf-8?B?ZFZzWnJzN3l6TEhocmg1bHRrQWxxQ1lpM2l3SHExWG8xUlhMQzVFQmVLc3hj?=
 =?utf-8?B?V0NNNXFNLzhaL3BscFZ3Rks2V3FzbndLc0VaVXdnNUdvL0gybUlKZzgwQmto?=
 =?utf-8?B?bW5BKzZvZllVKzU5MERMVnRTaWNsc3ZnUGdIMTZwVXZZaHVOWUtMa0sra0E3?=
 =?utf-8?B?OW9FcHZqYVZud2dQWTFRR0R4dVhHRGNyNTU4UUxhbEFLcGdwTEJKd05ZdVJN?=
 =?utf-8?B?ekhxNGdnYVA1djVDYTlvK3lISEFXc2JFSjNiUFo1NlM2K29UOVV4THZ5SEtX?=
 =?utf-8?B?RG4zbHVKZmJVQlVtZURCVVFNUkRLbGVsbmQreHZDZUUvR010cU5OaGJHeVZj?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JrlWprIK2HMNg/O5JQgXOWMDRyPqjyXE22zism45rS463+alD6Opy2PfDubPcS9Ah9BV/M0hYuF9fsc0c3YU2kZoTuLvyN8Y9vqSbsEEQMByDHoid6u/gc5ecqAchRUgf9t3kmrrfAMVLbocrRvqnVmKyshg6EQ3VqeBUtyI3FkLWt0vB8whOHGgS7ZsEFDPJCCqkxVOStDySmoA0hOLC3FhJH+WhCi2CJR9lsR47/d+J3p/Rw+bqGw5Fc30XTTsbNpOgD/Kdx2w29LcwYGYK3AytJFbH2EjiCCb/Lmp/FY8Me3YI9Lc9OOjtobOdiRiHL1JLxBF7FjsMe5RVJkUdYx5+scX4NsBPF+U8MSD8o37P0Rw6Vjv3bd0gjuo3mfnvf0tGVdq6G127qnHLIIaZE3jrllMCJNn71HtgVPEAoPPTbheOhHX0x14OeVgEaCRGaJirMvnkMeNG2iWqzK1d+Y/52ZaAgrgk1RNzW/qhZR38ctoe/W12Th5uiD5P94di4TuOirXnY6YYW7Ast0+gqYuPlKeT/HpCuPPnAfH0e9hRrFkBy0Jx6nPjwcFeLmGuV6ehM+lcTKYIdfHDW3csPBdRkRulJWiHroZgmkd9Hg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fe22cd-7abc-4eee-0a85-08dc28dfd7e8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:55:04.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToOY9EEKNbCYrhwyGexBtUwaV8MzjWhAoNO38Ou+mCOoA+DlC+ty/7BaV8pLVd/+uvq5slaXt8NZmHLcjjf2D9Z5kattM90/LFrNb169rMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7117
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080105
X-Proofpoint-ORIG-GUID: Z2so4wgKAbjrqPE5BDx71J7TDM7jH0oK
X-Proofpoint-GUID: Z2so4wgKAbjrqPE5BDx71J7TDM7jH0oK


> On Thu, Feb 8, 2024 at 5:07=E2=80=AFAM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
>>
>>
>> Hi everyone,
>>
>> This is a patch to make CORE builtin macros work with builtin
>> implementation within GCC.
>>
>> Looking forward to your comments.
>>
>
> Can you please repost it as a proper patch email, not as an attachment?
>
> But generally speaking, is there any way to change/fix GCC to allow a
> much more straightforward way to capture type, similar to how Clang
> does it? I'm not a big fan of extern declarations and using per-file
> __COUNTER__. Externs are globally visible and we can potentially run
> into name conflicts because __COUNTER__ is not globally unique.
>
> And just in general, it seems like this shouldn't require such
> acrobatics.
>
> Jose, do you have any thoughts on this?

Yes the macro is ugly and more elaborated than the clang version, but I
am afraid it is necessary in order to overcome the fact GCC
constant-folds enumerated values at parse-time.

Note however that the expression-statement itself to which the macro
expands is not elaborated, much like the null pointer dereference in the
clang version doesn't get elaborated.  These are just conveyed to the
builtins an the builtins use the TREE (IR in case of clang I guess) to
extract the type from it.

As far as I understand it the extern declaration in the macro is not
declaring an object with extern visibility, so it should not result in
any symbol being defined nor have any impact outside of the compilation
unit.  The __COUNTER__ is there just so you can use the macro more than
once in the same compilation unit, but that's all.

Cuper will correct me if I am wrong.

>
>> Regards,
>> Cupertino
>>

