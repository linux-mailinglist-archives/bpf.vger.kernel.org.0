Return-Path: <bpf+bounces-9516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D580798997
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 17:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2306E281A45
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587FFE551;
	Fri,  8 Sep 2023 15:07:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA18F6AA2
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 15:07:50 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DB31BFA
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 08:07:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388F4sBg013403;
	Fri, 8 Sep 2023 15:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ri9+yIgWGUhQj9k4iHlowGb8gbcuF+SHXTLvR8NEnjY=;
 b=nh+128RsIhp7lw5oxhXwkSIM0G4SOi1+cyLfGjTh1ipw8hhXgN8M/182oVBV4yoc+kLA
 JjiNMt+ms2vidrZFCqdE7boMkgL+hvgc57Fc5k8dv3LL96kxs6Hd+7yBWkZbtm6KjcKK
 1OQNOyvjvBWQOnWdaMstgA2qb5ilyXRmqM82KhXPNOTjQDxU9rVwMmE/ZD/GDf9cSiks
 fpZ7U9+r7XdKdOtpCTdP21eYv0py/EMV49xf6oQMmGYJnQs8TjjhPVu1BqycDiRGSe01
 N4eI8SvbzrceWOyJiuCDruVyci4KuWVAXz4Og57sHWvLwtFbYRPivx/ok8ClyFYQdSbO zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t05e882ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Sep 2023 15:07:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 388EYPTT030441;
	Fri, 8 Sep 2023 15:07:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3syfy1grpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Sep 2023 15:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aego0aXQNPtdHdIY86EmNReQzV6neXr1GNiBhl89apC873b7FKItHwF3DsGotX4gYPan9UkbHh7qMtO4oxa/CvusHX+DXuZ93oTaHPMnp7aMjgtAaLxFxYfMl6lsq5w4EDSGVVSvhPKN+AQI7AHs6BDjORP/hU6xQ6J7lqV15EI1NYRTvX4ONWyO2D1lbZq2Q3WvJO011ifF0ViR1CPG2Wuvht2Tuf7CS7EBY42OvT0X84Ru2wUeO56smsXdj4jOV80xPlr4GFpPPiV6KjvRG/N3SeA+t+p1Aftu7i0M2kgiPfPmHsG3Avc+VOYwK3XXSWihGQhROFZR/Ru+k46cEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri9+yIgWGUhQj9k4iHlowGb8gbcuF+SHXTLvR8NEnjY=;
 b=P52UilTHv97apDermG2oZPpS/Sc4ZUNgfWqe5Waq+MR2TKqahlHHuEX17ewvnlpRGNWX7iG0laG9oX/IDbI2mwWoJCfnnz4rN2vuHW/MFrSBWHIHmekBUwvSxEx5BtyjbARTpgzsvdiNEJVPdU18zIyp4q03VyYlTpoQx34PczsXQKmzapDHTZr7Sw+MwiQg1VquJeTHEi+KNAOw6nD+mSl2+t49oq7eKClTJdbAgEcoaBfPWLSHHfYO4xvLnYgecJjUHEeBo8/jIinuAenNEJjgbbXWig8fY3dqvrBu3kStnnNu18NXijTDuQ7kI5SMUBt5/M0mUB2jUmgv1mUkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri9+yIgWGUhQj9k4iHlowGb8gbcuF+SHXTLvR8NEnjY=;
 b=v5YgjOUCzciVyInqKfHjgrTVdowWuGmSGIIPbklBwLdpIv213ng1oxS2j4S0wobmb+fxnWkrNvRP7Ovnh5i9147V/ECOcTID28fYYKaQv1PRPYqKfMmZelgVQ2BzrXgYF+QwBiqfUIwHHjsFnb6SEs6p3RRopQTsoowtwYwf+6k=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO6PR10MB5649.namprd10.prod.outlook.com (2603:10b6:303:14c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 15:07:22 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7ae6:dcdd:3e38:5829]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::7ae6:dcdd:3e38:5829%3]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 15:07:22 +0000
Message-ID: <a219fa4f-1b25-e6c2-bd73-59b475118999@oracle.com>
Date: Fri, 8 Sep 2023 16:07:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 2/3] libbpf: Support symbol versioning for
 uprobe
Content-Language: en-GB
To: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        olsajiri@gmail.com
References: <20230905151257.729192-1-hengqi.chen@gmail.com>
 <20230905151257.729192-3-hengqi.chen@gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230905151257.729192-3-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO6PR10MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 1822cede-a8e3-4376-f2ce-08dbb07d4d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3bKjvfnWe3l9knXCW3ZmXWbR9ABNPRPlHc4llWBFpWhgh+3Uianbwp3wzlJNWWd9BmNlOSao94tWXRbTgccts508kGC+WXcZn9bH4BjCoQqio7Z0y+6hrb5C/gME2HlEaIHXKTp2sQjkGnJkzIlAlXZruyQUPG5SpoYFFN5WmHj9l6q28Z1HVco6/75UKOwDK7aVhGgRYTdq0w2NyNFrZJgc0xvtp3+Kz5G2sZOAZVCSeV/NWixmw9y4FyaYW3+rmuYEHaKafYCssQmU4Bc/TOyz8CKD793O3Vq1Ur+Row0WjQMWxEsynM93mK3tnLqh7GCNGT50ySp2zeY9TaNMjaIOz73LKyXeBh3BwZ0OepXWh04pZcWvfaLwq1DXKscMfY2VsVbEN+niumatyf603KbF5rsGVYTFXmINETArj8QWvYurOuPn2QLG2TNCWtX+Aiti6gKiu2DbIGNv9ZRhDZ9K4x3FdHNzqOgUBp7DLrFilsJGI0IdpiyFT+rvD5uA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(136003)(376002)(1800799009)(186009)(451199024)(2906002)(2616005)(86362001)(31696002)(53546011)(478600001)(36756003)(6486002)(6666004)(6506007)(966005)(38100700002)(83380400001)(6512007)(41300700001)(31686004)(8936002)(5660300002)(8676002)(66556008)(316002)(66476007)(4326008)(66946007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZkRNWTVSYU40cVRYZ3NlUERVc3N5Njg5elFhUy8rU0F6bmJEd1M3SjZ5MUNL?=
 =?utf-8?B?NytFc0FSVFQySFlJOXZkb1RRN2JKUmJKWXFCaXlIN1BsdzJuZ0ovc2hEVXdV?=
 =?utf-8?B?WEZ3a014TmVid01ORkRqQXdSelJoSnhRdFNocUp4cGhreUJHUlR3TytTcXgr?=
 =?utf-8?B?Qk40SVlHL0dDbnNoNkxZbnh6Qm4xQmpRRlcxbU5LTGsxSEhGVEJuZnVPclRC?=
 =?utf-8?B?TTE1cGs3SU0xblR2bFFUMEZyMm11Rk9DNCtieCt1S2pPbEdnTkpHYmdVMTlM?=
 =?utf-8?B?dlNXdlFiclZRakExekpaM3p4R0RPakdicTlHbDloZHdHQURwNFdocEZQdEpR?=
 =?utf-8?B?SUpFbnRDUVRKQ21VdjF2OUNhOFpJWHdidDk4OEI2aThzb2lmSTdDSThTNXVo?=
 =?utf-8?B?VU1kWnlQdk0rNCt2QmJ0S1JhTHc0bExpaFlMMXRIejAyWXJ0akxoWVlXWjdL?=
 =?utf-8?B?b2ZkTkIrVFRGMEJHVktmTEM1cTFzUk5QOE9UZ3B0bGNIb2VHQ3JmQVV3Y25j?=
 =?utf-8?B?aFFCVDBhNEtJN1JjalV6K3R2emN0elZmbWJXeHNiNTVtZms2ZzgwNEIxVDVW?=
 =?utf-8?B?dlFhZWdmc3BlcDVHUHpSK1VSb2QyWi85V2VtSEsxQXgwMVU4MkYwNEdOOFVX?=
 =?utf-8?B?YitnUDNDR21BVW9nS1Q2ZjJ2OEZjbVBCcjJIU2I4L29NSUxLUEo3L3lUWHZO?=
 =?utf-8?B?c2d2R0hmYTNKc2x0NkFNZnRCdDlxeE11R3BqMktneWV1R2hhMHFvREdibkVI?=
 =?utf-8?B?VHh1QVBZTjY5RGFNRlhoWUVacGZRM2xoeEROY1ZBMFljcGdPQ3lTVXVMWGpU?=
 =?utf-8?B?MkREeTJycjNjRGN6QVpWUzNzM1NpOFZCNFVYT3ZDOWFXT3F5bFd2Nk5STExS?=
 =?utf-8?B?eVNlaTJ6NXpiVlZZZGcvUkRGVHJ3TzdydTRCR2Z1dHF0Mzc0WDRoY0I3T2pE?=
 =?utf-8?B?UENQMTVTZ3Q3YTIrQWE0WU5oMGQ5WmQwZzN5eG5kTTQ5c1haTHJJbGpVWnVX?=
 =?utf-8?B?TlNPckQxS0tadnAyeHNidHAwajFiYjlqUFNTdm1GQmlqa3c1TllPQ0QrLzNS?=
 =?utf-8?B?ZDUyYVFhNWR4Z3NQcXdXVDRuTmdnQy9Xb1BhWnIySnJtTmpBTGZoTGZkeXFq?=
 =?utf-8?B?eEFYL2NTTHpmUkFJK3oyREhFYmlzdmJ2U1dIUi8vUC8yTUpoaW9NWmpUYkZh?=
 =?utf-8?B?RUdERkNIbktSVzB1Z0dUUDN2WkZMbmRkSU1ocVo2eXUvWjEwcEN4U0ZPb1pU?=
 =?utf-8?B?VFExNWZCekZLcm03citVU3JpQUhzL0dhOG9VY3VPeXBGVlRKbkJUTEo2QmZm?=
 =?utf-8?B?MWRQN0oxZ1Z0MGVJaFpPbUZlNEdndzlTalNyTTQrU2RoKzhVeGc5L0EzYjNU?=
 =?utf-8?B?NWtCOVZGdzQ0MlFDdkVGMGtQcnhNb0ZWRitZbUphdmJ0bXNqdW1VaC8wMTl6?=
 =?utf-8?B?RW5XNmVLODdIY01IVmxPMWVjc2YzV3pEdUNrRzZOVFZ1NDYxSWtKV1NMWERG?=
 =?utf-8?B?aC9tSjNMS0p0VmROd2lSdG8xYkdDQ2tkS25hRW0wZmVLeFVQY01kNURWSjFT?=
 =?utf-8?B?b2pVR3Roa09BYm1vaHhwdTV0a2JZY0tma1VlZFRkRndWck9nWFpVL2VzNkU2?=
 =?utf-8?B?SmcwNkxpUHppNkJIaGhNUzFwaDBhdDNXdWx5eXFOUUZ3UHFGRnIrcmt4eDJt?=
 =?utf-8?B?OGowK1dRUjZKUE1TQVA5SjdPcHRKN0U3SGJ1Mks3dmlFWVNMbVdoUFhLbGE2?=
 =?utf-8?B?NEFESlUrS01mRktkZldRaXRjV011eW9aejZsc0RiclVGQ0Nid1AyN3loS0Zz?=
 =?utf-8?B?NC9KVDdiMGdHSEtOWEVpdWdBejF6cE5jL2xwMHQyWS9pQjRiZVNrK1FVVitI?=
 =?utf-8?B?Yy8yYnFqZGhpZWRiT0x2MERSck9HVGtvNytrc082N0VxL2IxZ1NCU0t3dEpl?=
 =?utf-8?B?UjJVZWdlV3Q0cGhwaDBoSVRtNEFiMlFsU3hsdWxzcWVudDFMNjZoVS84d0du?=
 =?utf-8?B?M1UzTUpIME9vemlLMWtBd1BoM2ZpMWNsYXJsaVI2cG5MSHBlbUpIdVhqR21E?=
 =?utf-8?B?bkYvaktJZTNOSzVBSWxuMDREKzVieWV5bGNaRWVyYm5sRE00WmFwWTFOMXpY?=
 =?utf-8?B?OCtrcWZWRElFZE9uZkl1UUN6dmNGOGgxY1hMVkRZaXlQMGZBd2pKaU1MTDVU?=
 =?utf-8?Q?5XKMccmUytU9pizZ5VXXbK0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EJuffmiNuYcQqK/BK2dQkOCc0SbVopB8wb0TaLCO5Cg6TRokE3ismV4pK+MbTZ++Ads9ZPcgYSc8RROyaT9QmGOCy08Oipt/OvlCzt0YGSS5M0+4+wH0+4P5Gyqt6GjHGFJM7OZlvduG4Qwd0J8MCRbnxlXiRO0gmZiE4JjG4xa32GO+EvTIRDJBSDv+7taXhK+5LftLo66i7DErevNjN/7BNuWkhpQ3BC90WLid/PhoOmg/XGjxHGS5Rs9+75W8BNjH6xit4XAKFdd9QumULn06rjPokBqMik8+mzEHu4c+N4HNe83hkWMlntmcIdZEKkGKz+6V7pMO7yeL3vRKfG7uPvURHqcDBSTfEYD+nI6pwZEBJS/+0hg4AIGeBmIaMA5gKuf9qxMtRTd5bBwe0ODozX79Xrth2p8UrUvyiAbaA9Z0tFiyXYmq6JalNNeZ89VoOYHCIJfdbKnoLc/u3rX7CE9niuTm5ufjbIl5QcCBTMyyPejE6XdbkAtK3dXbT7R8Sjk8+GGFcXguCbq0+R9EtpU2p46yQqOS+sw5Qy5yUxodleGvbm2eXnAtfoKTM+w68WG4JSO/Lf5Pf1DXuaFeYOXKPH3S5BQIy0RFkYoWBKnUrJ0UwFqeAydZ7nmLQDlTJxotdXPF4FF64zfO1uAUE0RMJo/M0TWy1Z1a93vhvtUbxbwYm9/YhsTRqTu50uJU+j/1JA+mVVxB1q0fyhqUD6unkQZ29ta6M7MeI6xQvP3Uws5cZiyyTMkWpVPM9LgF1/nYEGJgKe6b1Ygk3TzBdzOygY/YgN2WByx9RNvAFGxFqWz6wATUQ8EIhyKjhc433dhDkAA+KrVnWhcxkkM4Ng1XJ7NpQnjZTsMxnhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1822cede-a8e3-4376-f2ce-08dbb07d4d79
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 15:07:22.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFsXU8zgNbzd0MW6+mq1nIH0oqEVOHO/IOehjHN8BMMOC1J2s52NqsBpwhrrMucyWsZQgCtkNgTPKXpfxQnSuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5649
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080139
X-Proofpoint-GUID: CFKk-WdQUXSrakczNMkJp6dnW7Tvp1fk
X-Proofpoint-ORIG-GUID: CFKk-WdQUXSrakczNMkJp6dnW7Tvp1fk
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 05/09/2023 16:12, Hengqi Chen wrote:
> In current implementation, we assume that symbol found in .dynsym section
> would have a version suffix and use it to compare with symbol user supplied.
> According to the spec ([0]), this assumption is incorrect, the version info
> of dynamic symbols are stored in .gnu.version and .gnu.version_d sections
> of ELF objects. For example:
> 
>     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
>     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
>     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
> 
>     $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>       706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
>       2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
>       2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5
> 
> In this case, specify pthread_rwlock_wrlock@@GLIBC_2.34 or
> pthread_rwlock_wrlock@GLIBC_2.2.5 in bpf_uprobe_opts::func_name won't work.
> Because the qualified name does NOT match `pthread_rwlock_wrlock` (without
> version suffix) in .dynsym sections.
> 
> This commit implements the symbol versioning for dynsym and allows user to
> specify symbol in the following forms:
>   - func
>   - func@LIB_VERSION
>   - func@@LIB_VERSION
> 
> In case of symbol conflicts, error out and users should resolve it by
> specifying a qualified name.
> 
>   [0]: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/symversion.html
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

One question below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/elf.c    | 145 +++++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.c |   2 +-
>  2 files changed, 133 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 5c9e588b17da..2d2819b7e018 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -1,5 +1,8 @@
>  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> 
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
>  #include <libelf.h>
>  #include <gelf.h>
>  #include <fcntl.h>
> @@ -10,6 +13,17 @@
> 
>  #define STRERR_BUFSIZE  128
> 
> +/* A SHT_GNU_versym section holds 16-bit words. This bit is set if
> + * the symbol is hidden and can only be seen when referenced using an
> + * explicit version number. This is a GNU extension.
> + */
> +#define VERSYM_HIDDEN	0x8000
> +
> +/* This is the mask for the rest of the data in a word read from a
> + * SHT_GNU_versym section.
> + */
> +#define VERSYM_VERSION	0x7fff
> +
>  int elf_open(const char *binary_path, struct elf_fd *elf_fd)
>  {
>  	char errmsg[STRERR_BUFSIZE];
> @@ -64,11 +78,14 @@ struct elf_sym {
>  	const char *name;
>  	GElf_Sym sym;
>  	GElf_Shdr sh;
> +	int ver;
> +	bool hidden;
>  };
> 
>  struct elf_sym_iter {
>  	Elf *elf;
>  	Elf_Data *syms;
> +	Elf_Data *versyms;
>  	size_t nr_syms;
>  	size_t strtabidx;
>  	size_t next_sym_idx;
> @@ -111,6 +128,18 @@ static int elf_sym_iter_new(struct elf_sym_iter *iter,
>  	iter->nr_syms = iter->syms->d_size / sh.sh_entsize;
>  	iter->elf = elf;
>  	iter->st_type = st_type;
> +
> +	/* Version symbol table is meaningful to dynsym only */
> +	if (sh_type != SHT_DYNSYM)
> +		return 0;
> +
> +	scn = elf_find_next_scn_by_type(elf, SHT_GNU_versym, NULL);
> +	if (!scn)
> +		return 0;
> +	if (!gelf_getshdr(scn, &sh))
> +		return -EINVAL;
> +	iter->versyms = elf_getdata(scn, 0);
> +
>  	return 0;
>  }
> 
> @@ -119,6 +148,7 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
>  	struct elf_sym *ret = &iter->sym;
>  	GElf_Sym *sym = &ret->sym;
>  	const char *name = NULL;
> +	GElf_Versym versym;
>  	Elf_Scn *sym_scn;
>  	size_t idx;
> 
> @@ -138,12 +168,112 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
> 
>  		iter->next_sym_idx = idx + 1;
>  		ret->name = name;
> +		ret->ver = 0;
> +		ret->hidden = false;
> +
> +		if (iter->versyms) {
> +			if (!gelf_getversym(iter->versyms, idx, &versym))
> +				continue;
> +			ret->ver = versym & VERSYM_VERSION;
> +			ret->hidden = versym & VERSYM_HIDDEN;
> +		}
>  		return ret;
>  	}
> 
>  	return NULL;
>  }
> 
> +static const char *elf_get_vername(Elf *elf, int ver)
> +{
> +	GElf_Verdaux verdaux;
> +	GElf_Verdef verdef;
> +	Elf_Data *verdefs;
> +	size_t strtabidx;
> +	GElf_Shdr sh;
> +	Elf_Scn *scn;
> +	int offset;
> +
> +	scn = elf_find_next_scn_by_type(elf, SHT_GNU_verdef, NULL);
> +	if (!scn)
> +		return NULL;
> +	if (!gelf_getshdr(scn, &sh))
> +		return NULL;
> +	strtabidx = sh.sh_link;
> +	verdefs =  elf_getdata(scn, 0);
> +
> +	offset = 0;
> +	while (gelf_getverdef(verdefs, offset, &verdef)) {
> +		if (verdef.vd_ndx != ver) {
> +			if (!verdef.vd_next)
> +				break;
> +
> +			offset += verdef.vd_next;
> +			continue;
> +		}
> +
> +		if (!gelf_getverdaux(verdefs, offset + verdef.vd_aux, &verdaux))
> +			break;
> +
> +		return elf_strptr(elf, strtabidx, verdaux.vda_name);
> +
> +	}
> +	return NULL;
> +}
> +
> +static bool symbol_match(Elf *elf, int sh_type, struct elf_sym *sym, const char *name)
> +{
> +	size_t name_len, sname_len;
> +	bool is_name_qualified;
> +	const char *ver;
> +	char *sname;
> +	int ret;
> +
> +	name_len = strlen(name);
> +	/* Does name specify "@LIB" or "@@LIB" ? */
> +	is_name_qualified = strstr(name, "@") != NULL;
> +
> +	/* If user specify a qualified name, for dynamic symbol,
> +	 * it is in form of func, NOT func@LIB_VER or func@@LIB_VER.
> +	 * So construct a full quailified symbol name using versym info
> +	 * for comparison.
> +	 */
> +	if (is_name_qualified && sh_type == SHT_DYNSYM) {
> +		/* Make sure func match func@LIB_VER */
> +		sname_len = strlen(sym->name);
> +		if (strncmp(sym->name, name, sname_len) != 0)
> +			return false;
> +
> +		/* But not func2@LIB_VER */
> +		if (name[sname_len] != '@')
> +			return false;
> +
> +		ver = elf_get_vername(elf, sym->ver);
> +		if (!ver)
> +			return false;
> +
> +		ret = asprintf(&sname, "%s%s%s", sym->name,
> +			       sym->hidden ? "@" : "@@", ver);
> +		if (ret == -1)
> +			return false;
> +
> +		ret = strncmp(sname, name, name_len);

I _think_ because we're using the length of the name we're searching for
we'd end up matching pthread_rwlock_wrlock@@G and
pthread_rwlock_wrlock@@GLIBC_2.34 ; should we use strlen(sname) to do
an exact match here?


> +		free(sname);
> +		return ret == 0;
> +	}
> +
> +	/* Otherwise, for normal symbols or non-qualified names
> +	 * User can specify func, func@@LIB or func@@LIB_VERSION.
> +	 */
> +	if (strncmp(sym->name, name, name_len) != 0)
> +		return false;
> +	/* ...but we don't want a search for "foo" to match 'foo2" also, so any
> +	 * additional characters in sname should be of the form "@LIB" or "@@LIB".
> +	 */
> +	if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
> +		return false;
> +
> +	return true;
> +}
> 
>  /* Transform symbol's virtual address (absolute for binaries and relative
>   * for shared libs) into file offset, which is what kernel is expecting
> @@ -166,9 +296,8 @@ static unsigned long elf_sym_offset(struct elf_sym *sym)
>  long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>  {
>  	int i, sh_types[2] = { SHT_DYNSYM, SHT_SYMTAB };
> -	bool is_shared_lib, is_name_qualified;
> +	bool is_shared_lib;
>  	long ret = -ENOENT;
> -	size_t name_len;
>  	GElf_Ehdr ehdr;
> 
>  	if (!gelf_getehdr(elf, &ehdr)) {
> @@ -179,10 +308,6 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>  	/* for shared lib case, we do not need to calculate relative offset */
>  	is_shared_lib = ehdr.e_type == ET_DYN;
> 
> -	name_len = strlen(name);
> -	/* Does name specify "@@LIB"? */
> -	is_name_qualified = strstr(name, "@@") != NULL;
> -
>  	/* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is used because if
>  	 * a binary is stripped, it may only have SHT_DYNSYM, and a fully-statically
>  	 * linked binary may not have SHT_DYMSYM, so absence of a section should not be
> @@ -201,13 +326,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>  			goto out;
> 
>  		while ((sym = elf_sym_iter_next(&iter))) {
> -			/* User can specify func, func@@LIB or func@@LIB_VERSION. */
> -			if (strncmp(sym->name, name, name_len) != 0)
> -				continue;
> -			/* ...but we don't want a search for "foo" to match 'foo2" also, so any
> -			 * additional characters in sname should be of the form "@@LIB".
> -			 */
> -			if (!is_name_qualified && sym->name[name_len] != '\0' && sym->name[name_len] != '@')
> +			if (!symbol_match(elf, sh_types[i], sym, name))
>  				continue;
> 
>  			cur_bind = GELF_ST_BIND(sym->sym.st_info);
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 96ff1aa4bf6a..30b8f96820a7 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11512,7 +11512,7 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
> 
>  	*link = NULL;
> 
> -	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.]+%li",
> +	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li",
>  		   &probe_type, &binary_path, &func_name, &offset);
>  	switch (n) {
>  	case 1:
> --
> 2.34.1

