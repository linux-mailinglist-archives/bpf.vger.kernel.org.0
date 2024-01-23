Return-Path: <bpf+bounces-20105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3768A839762
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 19:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9461C23B1D
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 18:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94868121D;
	Tue, 23 Jan 2024 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oSD8tztH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UotUB8Wv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC490811FB
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033623; cv=fail; b=GSfeI6qAKi2Kk8RoDhZ+jq3X/PdieM5xWKqtUtsw+xEiY3B4ggW4wlJJpdsLBQ1Dyhe6Kck/b6eRjHeT9A6mhR+DmWjSDOKsubpN3sIBPDwusSQxXNZFEdVtg2SNgo3Q1Sj0OEg9yV8bS0aH9gE+M9ZslCM1/vV0ZRjQ6a5OTAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033623; c=relaxed/simple;
	bh=uBK4408gdaQOOK8L98rFPafUP+ApQWlk/8eUPU8ZGJM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CevWHc8/EFF+u+i0KB3xDYfm15Pok62d7XryMkobL6ufDmX2hBMStOQ7HbCinBd3lwM32B/93p0aBOTxgemJEj6W7vMXZWAWXpRY28/Y9jki0SOG1OeBYcVCBN1USHnmVgP1vkSZYDdKxWCD/nhIT1zVDqQdbg2gVCyPGceoajk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oSD8tztH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UotUB8Wv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGRTuG011663;
	Tue, 23 Jan 2024 18:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=bAXL0+k4mzNQBPvNKEH90gGQ5OSruDtO89ZyqOW4d2I=;
 b=oSD8tztHKlsI3PtoCmVhiaH+goTnujynzR6zmWdQOOte18rziUdDhni6tPQcEdk/nEsS
 Fm3F5ckBiSsNjGbT430mUe5U8LDMt+ALHqrNMwtpDnL2a5y0Bpv9vHZCLjSE4OSLBuFd
 sdwhe+EE86LTCubFatdYcpcBuf795jLcf1BrBeqd0O1PvW+/100BbuQcX/q51qvFCP3s
 w/YUOwKAVKHJ60Dp3s34RM2k5Zv9p/yMzh+X/k7RC+ijtupt3wNHL2JHea/zrxEDEVnD
 4SeOArfgS8iuDloaSLyHrVVTo3w+Jiq2NFu6YB5SaWh7IK+GH3vZZHVsGl1/ZYN3bntf Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuq2fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 18:13:37 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NHYETb014963;
	Tue, 23 Jan 2024 18:13:36 GMT
Received: from outbound.mail.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33tcfkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 18:13:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmmnU8zQLL/ZtzInakgrRe433jwWnrVE7TPB6A84tPNYhn4NWq53Oy1Yq2J/2QYg3UNnaJSbChPLNPC0eiQYwktrdmV1IkJeO5MrM0Nudd4L3RE7qMelDQDrP66bSvFX29SmGsdGSHybDJ3KA4uW/7rF1ghJ8lmqLRp63ExSF4IhJS+1U87ppRsyGryOsX0Obzw+/gUqZTL/R6RTrwdqg4DQ3Jdk9GA2Q48PRz4BDOKdjYM7VX440/VQIm3gGIKTB8U812H3gXHCITniU+K4lBQrVuZzV8Qb+0APWswkpWkj/aYBCGoR+U99/vfHMtuTYr3AwT01bvBa6cB1w4w3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAXL0+k4mzNQBPvNKEH90gGQ5OSruDtO89ZyqOW4d2I=;
 b=AjYC99H4NT/dcO87tfxZROSUaRbaETbJNqO6u8JiqFFVYImQnMx0sEEmWqaG9jSRdKFIsmN08vWQ5UHgiZ4wdKp4FXsY8myzcH+2j2I6op7rLBXN64H2ZG38G4x3gB9LfGdXeIKKk6k2Jrac57ft133Y4SDqte9JDKauiZXlSMBJXoIBdVtLUreKVOHSL/+Km8q605e+p+TyeqHsHElVdCBEWaz7L8rzzaSG5QWUu9GQnIUZxLv/Oahcc4AH1HJfqFXDaSzYNn4YBqep/gjPRzdJmz3tQK7af7kTVKVhG1rMil8icdqTwsDj00sQclZgUdUNY+Ff2/Wufb3mOBWA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAXL0+k4mzNQBPvNKEH90gGQ5OSruDtO89ZyqOW4d2I=;
 b=UotUB8Wv89A6zNjdec+oacnfYyNH8xXG6t+8PNwwPIk+l8HOjPyHM8eVywTW6WLV8P1uytuBq9/iDvqMxxMNkYuBx0N8DMzOw/r3JYplrLIsLF9BPQ80VAPONEe5+sP6bYtg/NR1/Nqo5oxw0w7AV86zaGYFVDumJ6a+lw55QJo=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CO6PR10MB5636.namprd10.prod.outlook.com (2603:10b6:303:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 18:13:33 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 18:13:33 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH] bpf: use r constraint instead of p constraint in selftests
Date: Tue, 23 Jan 2024 19:13:09 +0100
Message-Id: <20240123181309.19853-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0105.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::20) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CO6PR10MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf6d304-524b-4e54-1d32-08dc1c3f0298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MWgoAsrKZJA8QxeGP2grqFy7ZqJvyIV+GIoz9gpz7c7mijQaltmGFnCmZyg40kR8yxp4MnZyLU7Xy6iDBUH/Wd+MYr3+IrsOUvnK2UVi7Q752XdI3Nh843kwVj23CM/+ekg3mMpqO4Gm9IpgqlrHcwnKX0KHSasFhWMc5twMoI9cuBuLZrHAGrp/3NKjnjgZAqUznFpSG2Ioyt7ZA4nAd3Zk6uY/rv/hwPA05QdeevOipOij9/N6prU+dlBqvqsf5KgtV6PY/AIGUFQnqRkGKOPxOj1OXnb4D1cNIE5LgV/Ii9r+Vp69wd7jNLgGYtYeKCp+SQpivljl6T4L1HnkWzFr8/mryycqv90xvMU9CWbT3ZFsoGXFs6HnDWHpvnvpEmoWmsSE+aZd7y4W0pT8P4b52FPElbjajMe6FiuPvXtblZFVNk/k83eGF6yU58IBHomrgEjD3rI96jnQt66wq3c6sBpkH7y5h7Hg2tu+3YvbRD2iuz6HI6n7hl/UHTAZ6Yq4EBuDmHqft3VN4ieSU5BVvT2yTw7IUErw1g83Wvg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(4326008)(8936002)(8676002)(2906002)(26005)(6916009)(66476007)(5660300002)(83380400001)(2616005)(1076003)(66556008)(66946007)(36756003)(86362001)(316002)(54906003)(478600001)(6486002)(966005)(6506007)(6666004)(6512007)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YUdtT2dndC9vT3M4TEc4YXJiaFg2bGNUYWg4dEU4WHJuL3h0YmJsbS9NRytD?=
 =?utf-8?B?cEVYcERwS2ZxamtkWlNidFRLN1NHM3lESjJyTEZxMEl1MmJvKzhGMzNWYy91?=
 =?utf-8?B?Z254Yy9Hb3JHTGJZSlRDSkZ2SUtIbno5VGdIcmlESzZPQlpROVgwRmdxY0RP?=
 =?utf-8?B?bWU3akdoNWRKbkRvYTllQmRBaEdBZU5lbG40cVFueHFnaS83czFCbUkyR28z?=
 =?utf-8?B?R29pMndmb2FUK2hXdXlqWHIvLy9XMUppSE5VT25kRDZ3U0FwcVhJVmhSejIr?=
 =?utf-8?B?MGQvSytiMDJhaG5MQm5Zc2dtWkpHTlJFMzRkTGlNR1NPZW5lZ1JPaDNXWUdy?=
 =?utf-8?B?WkZWZVFsMjFoVkFzZTJtajErME14NGg5N3RRYlM1akQ5RFBUR3ZERU0vUlZS?=
 =?utf-8?B?a2MxZ0x1TFZxME9PVWZzb21tcDlQNXpWYW1CS0RwSkF3ajBkdGUzdjMzMG5H?=
 =?utf-8?B?aTNHeW5abzAwdk82KzJuVmhyMzNoOUtlQnFXOUNlUHUvNEFwREsrZ0hqV0Fm?=
 =?utf-8?B?NVEvSFl1Vk1HRGliMnFnM0J6RmlJelhIQkw3TUZIUDBiOHpiajJtL294UGxa?=
 =?utf-8?B?VEtjQjA3UXdWRFdhOHdHZ2xESjdxQWp3TURneGNSOGtiRTVkR095T0ZkVmg3?=
 =?utf-8?B?YWRYdW1LaHNlZ2pVS1ZkWS9YUHZuUkR2K1hqUytlcUh0Yk9TK2FrcGNhYUxQ?=
 =?utf-8?B?eDVOY0VsVk5GUzA4cDQxeFVXSS9td1BmYU9PS2ltMTNyN3QrNmR3SVBjaEJa?=
 =?utf-8?B?TDlUb2hQbng3aVM4emtYTUhoaWxJOWRzN01ZVVViUE8yWVpQS2NiRm5aKy95?=
 =?utf-8?B?Y2ZXUUpueThQQmYzOGpBWEhvaEVHWFFYcHp1ZVdMblVpZll5RE9nT21leFVx?=
 =?utf-8?B?L3RoSVFYQ3FodXFRcjdJbFlpMXVmUVplTlJwckNCeERBc2ovT3J4dk9TSWNs?=
 =?utf-8?B?OHBkSXlZb3FTbkZoVkQ3d2YvMzNINTZGU1c0NVlhdGlHMElyN3ZNeXNMWWdW?=
 =?utf-8?B?K3c4VHhycDJRdzM3TVQ2ZWlTYTNTRHV6S1Q0bUY3K1Y3M2Vud21HS1dZMVFH?=
 =?utf-8?B?SFNiNEZLV2lmcTg2VXVLa0JESmJsaUdFSHhGRkFSTUlKbWZaUDU2NkVBQTk1?=
 =?utf-8?B?SWJFanIxSjAvSHpXaThqd1IvWVpOR2FPNVJXeGhLZ1hpWVJTU1FiRlFKUFF4?=
 =?utf-8?B?T2paNklNNXZveHJ0OE94ZGxmbXI2MHcvTTI3WktUd1UyTlJzb3VzRU5kTnFJ?=
 =?utf-8?B?UzM3eUsxNGtqSVFRekpyNG9lSUYzRlNXdFdXaWhhMHA3aDlwUFVYcDlGSlN2?=
 =?utf-8?B?VUp4aFBDK1RETkx3Sm1sM01jMllBNzh6VCs4TmhnUUxOZWk5M3RhVWNON2k2?=
 =?utf-8?B?Q3ZGRU1QNEp2WHV2KzNxSTlFVlYrQ01aL2drZDN3OUE2NEhGWUtGcFJUckN6?=
 =?utf-8?B?ZDhCdXZRZVZtL09oSmFQc0Nrc2pXOHE1NVFNYUtiMVJCL2JLalpFTGtlcDho?=
 =?utf-8?B?RUdlcVM5OTh1ZndzMUlHKzRYM3FjQnVpU2wraVllQXJrRStDWmhPRlRzam1M?=
 =?utf-8?B?em5yZXd6NE8wTG9QMWZFY1N1VjVqVE1va0hxUFB5ZXZNQU40RTNxaTgwRWtQ?=
 =?utf-8?B?eGtVLzZESEJzS1Z5SmFXdjZVcHdMOXhycXBBTHJJQmVCQ3VPUEJGMVZBcGdV?=
 =?utf-8?B?QmZkVTVLSTdRM0E4UFFUUUt2bVZhNi82djZQMFkxTy8xcnA5ZXJwS0JpaHZR?=
 =?utf-8?B?R3lyTHZYMGFTZUF4QjdQQWlMbDVQYnVEc05vMlEzVXNBRjR2M1pRVlc0TGp1?=
 =?utf-8?B?cjRkdDBPYVRpaXVRYWZQZVhUZWRuZUI4OTZMc1hjVk90Nko2dzlWVU5QYjhh?=
 =?utf-8?B?QWo4UFJ5L1l1L1JhWThtNFgwV3BnbytqZVdxSDdwVk9kbVJJM0ZiM0RKR2Fv?=
 =?utf-8?B?NHowOHN0NHRjSVNuNnFYK0ZYb1Q4bXJlK2FiRXhncUxaMFRNV1JVZDFSdWpu?=
 =?utf-8?B?VjNMWWxDOXREalpBUk1WRUtYNm16MkNWbGxsall3b3Z3MDRvTVp0NFNaMHpz?=
 =?utf-8?B?Y3kxTkRrMVJnVnpFd3FsdHFnK09yRlJhTUYxeHhOZGNqYUlRZW5pR3NNbmRw?=
 =?utf-8?B?OEsxL0pTc2dIUmUwK0VzZnU3c2lYMHdydFI1bVpYRW9jYXEvcEJaZkhHeW9q?=
 =?utf-8?B?dkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZotxCwGyd9OpXuUAQsHSR7SPHaj8xOsc23yBJLpO0+VA7wVB6ZVNZ7k2pN4bXc2Ix3HuWeqbaBktsFU7aXWv07WuzWievqHrXBfupoKvueOEnhO4YMur9grS6+rxBh22BQ4nQUlmHeYjjJ45kwJ9DgpkOOdCKTyWujw4SObOZqVGoiKF3HXHrrbdRkupys9JNFhPQsTos2pHaLsfMuSawtinR5NxC/k1MFhq2ic9yt+I++EipbPW6kaRV6rY3KqMetKWGXwO4CyizQwoO3U6ITz1ghO3BiMsMtN3smVaefzvJxCVfzVhQyPu+dWn1z+8//365M1auQzoHcJ9239RkzCLP0/uIOF5NlCvO8C0GKSo745cpiZvhyVNM1uMm8zUy2cKKzdDNwwrUuYq7eeqHl5o5NIEc4C+Oz4k7xQckeP82dz4KBWWO/G+swiSnVlIvpsI2ZGXtUuitQlDC0fl5JaOnBE31gZndQ0bcUqXrk8K0lkd+OpGtauEs0getWlY5PVQrMr2ubPXNu0yXTCB4IW4IruNfQf+tTGzie+Y3iCwwbJHrktKcs52VspiA4IhIVlmkYZF9WJ2TXKn6PX/VsWNXIVFsyyYdp9uGr0VOc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf6d304-524b-4e54-1d32-08dc1c3f0298
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 18:13:33.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86NZavGD8LxA0rKUO5sdyBSqjX8BNy9X0zuOOjI3kxSBMYYJVVwjjof0Oicz4TcoZlyGdft2WQNf3qZXkvKrD2ByfdTVGd5hSozeyh8lTnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401230134
X-Proofpoint-ORIG-GUID: KbJ5J0b9KsgfOqSscbb2tw2EoEFiE6LF
X-Proofpoint-GUID: KbJ5J0b9KsgfOqSscbb2tw2EoEFiE6LF

Some of the BPF selftests use the "p" constraint in inline assembly
snippets, for input operands for MOV (rN = rM) instructions.

This is mainly done via the __imm_ptr macro defined in
tools/testing/selftests/bpf/progs/bpf_misc.h:

  #define __imm_ptr(name) [name]"p"(&name)

Example:

  int consume_first_item_only(void *ctx)
  {
        struct bpf_iter_num iter;
        asm volatile (
                /* create iterator */
                "r1 = %[iter];"
                [...]
                :
                : __imm_ptr(iter)
                : CLOBBERS);
        [...]
  }

The "p" constraint is a tricky one.  It is documented in the GCC manual
section "Simple Constraints":

  An operand that is a valid memory address is allowed.  This is for
  ``load address'' and ``push address'' instructions.

  p in the constraint must be accompanied by address_operand as the
  predicate in the match_operand.  This predicate interprets the mode
  specified in the match_operand as the mode of the memory reference for
  which the address would be valid.

There are two problems:

1. It is questionable whether that constraint was ever intended to be
   used in inline assembly templates, because its behavior really
   depends on compiler internals.  A "memory address" is not the same
   than a "memory operand" or a "memory reference" (constraint "m"), and
   in fact its usage in the template above results in an error in both
   x86_64-linux-gnu and bpf-unkonwn-none:

     foo.c: In function ‘bar’:
     foo.c:6:3: error: invalid 'asm': invalid expression as operand
        6 |   asm volatile ("r1 = %[jorl]" : : [jorl]"p"(&jorl));
          |   ^~~

   I would assume the same happens with aarch64, riscv, and most/all
   other targets in GCC, that do not accept operands of the form A + B
   that are not wrapped either in a const or in a memory reference.

   To avoid that error, the usage of the "p" constraint in internal GCC
   instruction templates is supposed to be complemented by the 'a'
   modifier, like in:

     asm volatile ("r1 = %a[jorl]" : : [jorl]"p"(&jorl));

   Internally documented (in GCC's final.cc) as:

     %aN means expect operand N to be a memory address
        (not a memory reference!) and print a reference
        to that address.

   That works because when the modifier 'a' is found, GCC prints an
   "operand address", which is not the same than an "operand".

   But...

2. Even if we used the internal 'a' modifier (we shouldn't) the 'rN =
   rM' instruction really requires a register argument.  In cases
   involving automatics, like in the examples above, we easily end with:

     bar:
        #APP
            r1 = r10-4
        #NO_APP

   In other cases we could conceibly also end with a 64-bit label that
   may overflow the 32-bit immediate operand of `rN = imm32'
   instructions:

        r1 = foo

   All of which is clearly wrong.

clang happens to do "the right thing" in the current usage of __imm_ptr
in the BPF tests, because even with -O2 it seems to "reload" the
fp-relative address of the automatic to a register like in:

  bar:
	r1 = r10
	r1 += -4
	#APP
	r1 = r1
	#NO_APP

Which is what GCC would generate with -O0.  Whether this is by chance
or by design, the compiler shouln't be expected to do that reload
driven by the "p" constraint.

This patch changes the usage of the "p" constraint in the BPF
selftests macros to use the "r" constraint instead.  If a register is
what is required, we should let the compiler know.

Previous discussion in bpf@vger:
https://lore.kernel.org/bpf/87h6p5ebpb.fsf@oracle.com/T/#ef0df83d6975c34dff20bf0dd52e078f5b8ca2767

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 2 +-
 tools/testing/selftests/bpf/progs/iters.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 2fd59970c43a..fb2f5513e29e 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -80,7 +80,7 @@
 #define __imm(name) [name]"i"(name)
 #define __imm_const(name, expr) [name]"i"(expr)
 #define __imm_addr(name) [name]"i"(&name)
-#define __imm_ptr(name) [name]"p"(&name)
+#define __imm_ptr(name) [name]"r"(&name)
 #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
 
 /* Magic constants used with __retval() */
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index fe971992e635..225f02dd66d0 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -78,8 +78,8 @@ int iter_err_unsafe_asm_loop(const void *ctx)
 		"*(u32 *)(r1 + 0) = r6;" /* invalid */
 		:
 		: [it]"r"(&it),
-		  [small_arr]"p"(small_arr),
-		  [zero]"p"(zero),
+		  [small_arr]"r"(small_arr),
+		  [zero]"r"(zero),
 		  __imm(bpf_iter_num_new),
 		  __imm(bpf_iter_num_next),
 		  __imm(bpf_iter_num_destroy)
-- 
2.30.2


