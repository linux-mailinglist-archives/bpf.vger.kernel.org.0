Return-Path: <bpf+bounces-27126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7D58A9637
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 11:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D1BA1F22190
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE015AD8F;
	Thu, 18 Apr 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="btGk0c9r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M7+H/lCc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0E152E12
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432738; cv=fail; b=O871Rw4vzROvLJddd8nMvY5zg6BCZdbN9crE45do/4GzjNnwklqQT7yq2LdEOe7OXiy0L7mQ3ndpQGSKN3+YwnDPQ+QIhy+aM3UHvKz3Vp2f3iEEI9ep6jGV7Vy+1JvXiSFEodq8Gig2f9A1KiVupQsF/ho76sfRoSFL9hd2aFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432738; c=relaxed/simple;
	bh=uODTq28d9EbuvgLy1yIqIFPCcnjux7m4ENzxAIbIobU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p6qBqk6Lmd2G25gXDVErocw8zQv/OGvYYvHFWZbNtiX/+J753eSXE8Nrxcac8Z0RD6UcbG8SMP78K/3rhOnPXND56u/4WHpK6thBNnfWAy73SnOBwnzapc+pKf5ADpgtATJOH2jAL5FSPImUtjFzYNVtw5UYzK1YVepuMMf8jug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=btGk0c9r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M7+H/lCc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I7nKqI005723;
	Thu, 18 Apr 2024 09:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=dEUw3vMih+iiGFFBG6wVVU1LgBotwMeDZvop9emD1Ag=;
 b=btGk0c9rFIrg540zj5yRnnxbzkvml1BH/MkC1UrwuFxITXGS/EuHZSHQOiGM/8wADQQA
 2BuBw9K4FbT2aPQbzultdmA8adpK4ZTHZ2HBAIDXylBD3uRzOZTrc3gxg0ukp+UEoFSM
 eqoHbsdB02cxUV+hutvNeO5Tvaa3F8KKx6/aYMHMxtPANvDDu78qMveNm75ZI71iNlAn
 DR1nxfdhs2RC5/xQWo3TZknixOgEOe9vCm7szmybDAHMEZIBgzpGDZLg7+g1zdfmsK06
 71d9EAcZmZts9fOp+Ib9nKPKqJ/bWCzyZTDR5+YUvv0Bv3GSVK4xwmX3gotlHR0sHPfJ Mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycsxqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 09:31:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I93TtP013336;
	Thu, 18 Apr 2024 09:31:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xgkwj82rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Apr 2024 09:31:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVI7FMb5+gAERjocp8AurBVZzOq2KD8UOrLLQeeurYCxEzy6qiHuRb/6/xQcOdkKbUu6G7A6VLz7rJCReoOYbk40B0TvtXOncLaUnI78gG6lJ2IpHkESss+DJddman/o8/Cyru9UozIoy4belhJjmoyL3PghLUXW+54yOX3+8pweg6YZ5AQTxeOyfsRuF3d1i5PRyrUmScfuyiewhejqjdzkhd0aOo5q6+FivVSZBogqFgtLCAPoS0Pq2XyVdg5lJYcVkdOYKfptDHMm7E61H/9Wd8S7+6iV6gSN4L8o271APW1zwDxq7AfUzTdqtm2WVmuO6N9vPaiIsk26NitMRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEUw3vMih+iiGFFBG6wVVU1LgBotwMeDZvop9emD1Ag=;
 b=Sy4G5ZMjowpM43eoXf1VYZV7QEc7jZUOkD3RPs0MUEDyI2XNShMtOw8xdFXFFVxtd2ejp0svUM8GzvGhQy/qvb5v2U+9hlAMA69pPlrrp0o/hGiM/765aiJCI4UMlo8glCS+Tozx36YArKpytCSrzrmvgXpIORE0JX7heYahHifXurLLQYO+ZNWRqsYWz3zortRkLbfcPhTrArpP2EGj7tSCZWSNUPOr2hOccz5+LHMAU5IJ7oHcS2kg1G7aYpUdkGAkq6iWW1FMA+anu2RwP4gXIVAZsdCfp44Sk5qpmcrJpbEuViCgFaexj2XwMslkBkxbgFuDWV28qrVcgmoxAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEUw3vMih+iiGFFBG6wVVU1LgBotwMeDZvop9emD1Ag=;
 b=M7+H/lCcW2mfZqYRbHo5GKikp6TTbGDRa61mYicivqIa/PgHNf9YCLxdjfx4OXRS72zIpQN4IbacdaCMH3zDZyLYZL9GHuErWLqjBxAtUwg7dx2Czy/XI8/vCmnoFtt+S3398rzGKFS0w4xGfrn4wxGBB6GEQ/WbAGZwmZ2Manw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6506.namprd10.prod.outlook.com (2603:10b6:510:201::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 09:31:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 09:31:41 +0000
Message-ID: <95ccc774-18df-4c2b-94f6-a731565ff367@oracle.com>
Date: Thu, 18 Apr 2024 10:31:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v6 1/3] gobuffer: Add gobuffer__sort() helper
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>, jolsa@kernel.org, quentin@isovalent.com,
        eddyz87@gmail.com, andrii.nakryiko@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
References: <cover.1711389163.git.dxu@dxuuu.xyz>
 <ba9ff49e099583ab854d3d3c8c215c3ca1b6f930.1711389163.git.dxu@dxuuu.xyz>
 <76869286-5593-470e-b04a-e38f1613c361@oracle.com> <Zh_RUWT4b3QC31k6@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Zh_RUWT4b3QC31k6@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0277.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2f8281-1072-4286-63d7-08dc5f8a5ab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0GGeuKRWQUWHbPeZwnPee3hiMkPUdGfnpwI0LsvoL06fNqZTPSz1H08OysNhLe9D8ixRAjEBohmsVRe/YKO5xoMjbRlww6qx/2nw0Mmb+A4ditpyDo3l2RtqqWtC/YRqHpcMAmvQOdokGRPDCPqaNCaD9XQGCcur4e4mLG3QIsuZdj20ughWZ/zJbhCaiNckujNbBVTCOWcKS7zGjCsUDI/eeaW0sGdRiql/u87v/BiFVYrLggEHT2UCR4zs/73ekrR22UHsZb2+YdAsFH3ox+XwSMnD7+76JbXNaiJQIMttw3rkc2aVz733V9qewQL4NDXf4dzTbMK4jRFY47Hb2HL3RMIZ93Z0HiB3ahf8kZp8oPpeF6LtrW9Sg3xd3Yq/NOyty5AdFtL2Lc1xQtyjMiudgtf/abEhLq/a4ExRNwCEHvLVSuTYXYLcy3ebdz6Av02igmw6B+kdjtS0CTLxFImVvP5Jia77/hCFhHU5BK2A5gYigs84fxuGC9vVemSX2RrUobPAu6FS+MX+WKqSYMYikQdeB8jZX7VBlhPjdRP1jT5+/LGou0D7M2IVXmYaC49bp1yQ/4TctrA2eEWFxFJsCVbATfwpk0H+Uh71hGmH2p5E995E54ss9TZ08JvIAefkIyRU3asq5PBQvFzwaz0fmuvWlqPWTxw+sqILnhE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aWJtMFBhbEtwRXlDU2ZreUVQc3BHZ3FlSGxlRFdsOEU4VXJaMHdMUnhQeFNM?=
 =?utf-8?B?NExUNTcvZFRkd1ByQytwMU8yVVViVEdxVlZ1NWJkaWJOWnVZMFpUTmVMRXZI?=
 =?utf-8?B?SGY0NVhaL2o4a0FxcUxXakptMzEzczFrQzhrSGNnODBGMXY3V3FmdTkzbDdv?=
 =?utf-8?B?WWxvNVJNMXE4eWxKR3NSRkxUTWdqRm1aUkZ3cVNhanZ1L3Y1UVlMbXNHVVBh?=
 =?utf-8?B?bU9Ea0N4clN1SWZ1Zk5wc3RlZU1kWDNsUCtDNFpkaHZUNG1jaWZya3BBY1Jq?=
 =?utf-8?B?azNZbGJhTDlOQjB4aGJnSmdndnl1WnF6Y0RveHlGYmlxVWFxb016UGdOVVRH?=
 =?utf-8?B?d2NwcDhqTThKVThJODdVZ1RiZVlxUU16eGZqYjJUeGxuRkdvQnRKZkgrL0dU?=
 =?utf-8?B?ZXdYTlpQVS9LY2Y2S3FuZ1hpV0pIbU8vZ2xCaEpqQytsc3RJUjRKNW9DR0xB?=
 =?utf-8?B?cVp5TmVsRXNpc0QvSSsyZ0srZlU3cHphOXRrc08yM2RWTElYYTBCYWNDVy9X?=
 =?utf-8?B?azVHb0JMTmJzZlZjbkpVZ1BVL2tyLzZwT2dpdnl1NEdVQkdkRkFOdmhEWDd3?=
 =?utf-8?B?ZkxhZDFvY3lUY2s2czBSZkxGbXFGQXlhSGxCQ3lDeWMvdWVkVDYxbE5uNk1x?=
 =?utf-8?B?TGZtR2pER0xnVmhpQlloM04xZEMzemw2SG1iVDBZK3NlbTlsWUp2bytjcWF0?=
 =?utf-8?B?UW8wdUhxekY1SDZ1VkQ5ZWw4b1FnVXE2dS9UbHNoTko1MElPaC8xVkxUYkJo?=
 =?utf-8?B?ZkJMQkxaSlo3aEl2ajNtbmtxZXpUZWtCL3l5U1NHbDgzVGw2YzNMcVhkYUd1?=
 =?utf-8?B?SHhrNFA4S2J3TW1oYmcrUXUwSmVTYUNXSnJKdUZMK01zbXY4M3pUSSsvRHk4?=
 =?utf-8?B?TnpVZGlJT2pwekE4RTFUWGNGdGVtOFBjajRnTEtiekU3MXpPbEVBR05pWVhp?=
 =?utf-8?B?MExPakFzVGVERVJFVTAvQUxBQkd3VmZ4UXgwWXA2WW02Mzg2Kzl1UmhNelEx?=
 =?utf-8?B?VjBCM3ZBMUs5UWdhRDRheU54Y1Y4RmNGaEswbTRyUTg3QWpqckQxZ2wxWk5L?=
 =?utf-8?B?M0wwUVVDNmV6WXo0TkhRN21QY3g1bGtlRFJlZ1JQTXdDNGN3RkZaQUdnaEdl?=
 =?utf-8?B?Yk5kQ0t0bW03VUZIa012MFRtcUs4UVFzOVRCcjI0NXdVMEVUS3A4L0NPTDlQ?=
 =?utf-8?B?N05FR3RaMjRsR1l5bGFEUk5rN1JWTk0veGlteTZqcXhTUlZ2TEZiN3ZDdHF2?=
 =?utf-8?B?UHNrQ1VDS3laYmVuZG53N0NCeWVuMVYyNTlabFRhSVBvQzAvQlkwUGNhdnBo?=
 =?utf-8?B?Ukw0aUUvWVp1ZHRGcERYS0JDSnBLOWQvY0VKY3F1Y0phSzN2bHVZNDJkWDZK?=
 =?utf-8?B?ZlJUb2ZUdXAza0VMMStvL2EyL2NwQlA2NTVENndNb1RIdVlyQWdWVGR5UGU3?=
 =?utf-8?B?ZHNYTzdpN0EzRU5RQ2dFMkd1enFvcUphVFRBSXpNcjRkdmhjcFBPOEM5NTJ3?=
 =?utf-8?B?cnh5dmhKZ0NsazJGeDZUeTZ0cTZUNXowRmpGTTRqYjl1ZjlGZUh0WVNOU3gx?=
 =?utf-8?B?UzVTZlRidUJWdlNEcktJcHdwZGcvKzEzSjlabklldUQ0aDZrUTNDS09ZS3RJ?=
 =?utf-8?B?R21xU1NQZ3hlbWNHMElMV0F3bzlMbUdnckYzRnAxQmhzZ1p2Z0U1SWM1cTJH?=
 =?utf-8?B?bkhSc0tHYUM4blhzVjlWdEduQVlkWThZNWlSb25ZTDBIM0tnOFVJS1RQYm1o?=
 =?utf-8?B?TlVWQXArUGFJa3RFcFlrdm0yU1V6Ti9zSEloWXZJS244WitHODBLa3ZSa2p2?=
 =?utf-8?B?T0dYTEtuejRNZ1pScDUxV2Z2U1ZmWnpNZGJWcEMrOUtmNXBxakZxdjJ5T2ZL?=
 =?utf-8?B?MThBRjB0YXBGQ3lkZGhoSC9xVmdCVGJPVUJzMEhTV2J1OE1aM3M5UHRNM3dU?=
 =?utf-8?B?cFAwVldCQzJQMkczR2RFci9rRFhheUJqY3NtZSs1Y1VpSDlzQ0RrdjVGR3RP?=
 =?utf-8?B?ODdSeGVHOVVFdVBJTERtcmFrQ1NMeUlkUTI2MCtJWlZDV01NclFKYVB0NW9S?=
 =?utf-8?B?MnBWZVJFTDhKTVNXSEZtbFJCRElzNmo3Z1U2aU9kd2NkN0wzOVl1cEFGOTRs?=
 =?utf-8?B?QlBCZE5OZW1weW5zaG5ZQnZOZHNGNk9vblIzZDVOZjFqTmJvTm5oVWNYUnBN?=
 =?utf-8?Q?39VAu3a56RLiCsuWTRfDbBc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KJ5MOfRHETX9a/4zAmyCEn/+ls5rk5eiZ8jrTZNhmhwQa0cZLIIKalN+S+PPCVJIOeuknrrjx9VG9qalWFjL2d1QMqGX2LplZnKFuj0gwSWBgYN5S1eoO45LVWLvS74rZLf2TqVqzuT9R9vD87+Lblx94oukAsqnhmm6Eyj8m8Oa1BHHrH6D38caOyTX51D+Z0GDqtkTnIIBi84sMtCqMNps0eCv47MBVRVrxQ2F/nHM18ZVF9F+EL1DF4fFIE8FhsobGRoO8TeYYSw/CpRRtDMoqp8EnKzYp/IeytfgkPN/3Jj7XSi9lWR2CBuZFPfQmKHGZNf679hYTiUh4cRNL4CKlBhJyK/OfqAizq/J7z2bFy+8wQOMzAq2ZTjv7Lo1NhIrCMgj2Andw3SI/iXfi3iyCP6svv8HiTRFck2ZZliFCOmPasu0x1vLuwuDOaf9/rrGDiluQ9OQiBepELeAO7+vR/51LmKummtZiRa93Sl7Up1ED78oUpe2O1uV+il0sn7dSiKX79feWigcLLcAm2VkzYjq+A1Ns9KsRgm89pd7MkXPCNSkI2qsph/OZyOhgcVn3SXrhvXihrDNda9i96uiu/WnZDi4NRgoQIe2DTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2f8281-1072-4286-63d7-08dc5f8a5ab7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 09:31:41.5036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6vN68vgKgqFyIN3HqFCZM+EA1ovKc+C4UjNzJEjTOsf9git16WqTfhG5K38mYHqQQDQX1FfUrs0I2b3WO3IHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_08,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180067
X-Proofpoint-ORIG-GUID: m-ipfm6mqFhH41fzgaE3p0sCISebRsMW
X-Proofpoint-GUID: m-ipfm6mqFhH41fzgaE3p0sCISebRsMW

On 17/04/2024 14:40, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 17, 2024 at 10:20:41AM +0100, Alan Maguire wrote:
>> On 25/03/2024 17:53, Daniel Xu wrote:
>>> Add a helper to sort the gobuffer. Trivial wrapper around qsort().
>>>
>>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>> ---
>>>  gobuffer.c | 5 +++++
>>>  gobuffer.h | 2 ++
>>>  2 files changed, 7 insertions(+)
>>>
>>> diff --git a/gobuffer.c b/gobuffer.c
>>> index 02b2084..4655339 100644
>>> --- a/gobuffer.c
>>> +++ b/gobuffer.c
>>> @@ -102,6 +102,11 @@ void gobuffer__copy(const struct gobuffer *gb, void *dest)
>>>  	}
>>>  }
>>>  
>>> +void gobuffer__sort(struct gobuffer *gb, unsigned int size, int (*compar)(const void *, const void *))
>>> +{
>>> +	qsort((void *)gb->entries, gb->nr_entries, size, compar);
>>
>> nit shouldn't need to cast char * gb->entries to void * ; not worth
>> respinning the series for though unless there are other issues
> 
> I can remove that while applying the series, which I'm doing now.
>

great, thanks! BTW patch 2 will probably require a small tweak for
merging into next:

-	BTF_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
+	BTF_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false, true),

this will ensure it is considered a standard feature and is enabled for
"all"; for readability it might make sense to position it wth the other
features prior to

        BTF_FEATURE(reproducible_build, reproducible_build, false, false),

...since then we'd have the standard features grouped before the
non-standard ones, making it a bit more readable; not a big deal tho.
thanks!

> - Arnaldo
>  
>>> +}
>>> +
>>>  const void *gobuffer__compress(struct gobuffer *gb, unsigned int *size)
>>>  {
>>>  	z_stream z = {
>>> diff --git a/gobuffer.h b/gobuffer.h
>>> index a12c5c8..cd218b6 100644
>>> --- a/gobuffer.h
>>> +++ b/gobuffer.h
>>> @@ -21,6 +21,8 @@ void __gobuffer__delete(struct gobuffer *gb);
>>>  
>>>  void gobuffer__copy(const struct gobuffer *gb, void *dest);
>>>  
>>> +void gobuffer__sort(struct gobuffer *gb, unsigned int size, int (*compar)(const void *, const void *));
>>> +
>>>  int gobuffer__add(struct gobuffer *gb, const void *s, unsigned int len);
>>>  int gobuffer__allocate(struct gobuffer *gb, unsigned int len);
>>>  

