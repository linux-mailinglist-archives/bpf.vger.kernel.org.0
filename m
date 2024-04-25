Return-Path: <bpf+bounces-27806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F58B21AF
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 14:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775141C22276
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98A91494A8;
	Thu, 25 Apr 2024 12:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nmow2w4w";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qWBI3jHS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7D149C5A
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048382; cv=fail; b=r+n22qgd5T0DxR1RC80jaYO1N6pdbhmnHa3mgnYbzT+IXc5hd1qxwVxVO1Y4izOwA5uQuupTcmE2OWlzYREfU4e8rsNY6sgINgdMHZOzn/XisRmcZhIDKpvJwilI/04n6PQ1hHxRpQG5cbmf8Y4JFjI3RfPjHOurzYmRyJ1zK74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048382; c=relaxed/simple;
	bh=Z4ka9Ai4lPME3xEXy93R90r/A1bLr5OIcIpZFXKfzGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=kHdATjOGFCbfuBpo+s4xACAFGQN6/ttgBaVXZlZOHmE8uaNqDKhRoB9UR+GvNmg5ZDmH/pSRaI+Pnociidc+JuZT76NACes9Betjv5zChFG2Gtzzine1N/KR7qy/wfF95kOEN3ytburVxXUTsYTvM4fN/ocyH7tiznJNkXPkc30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nmow2w4w; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qWBI3jHS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P8uIqb024048;
	Thu, 25 Apr 2024 12:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=n0loyBC/ScJ8WvFRQEDmLiFHJ8txmt3LwGkjaLIcnBA=;
 b=nmow2w4w3AVbcKCR7CxVbP3oQIBTX5L/RAv6Z6VcYICP47X+b4lhzbrvV2e+qpbOOQSq
 HRJpDEDCB9XxojDFd6ouATT3TafafT3HSdgDMKZXjVmsspF2ezYDO4cinzwOnuwf9lji
 teXceaksuCnTYJaYkm2xwKtTTVXGtd9gR68APJfDG6+kqJjdq732i9WcacDcGzm7tPJp
 TXL2wmUefEs6NsOPItyOEpGZCpUXI7QmSXoEtpLVn1H6D9PfsPeRrGuTi8kg153ofGBH
 nQp2mSQlHv1oQCJG3RrOE/oBrsdGjQZZ7LmXH1F5kGbZle7pReOAwaVRCOAkLBHs+fc9 eQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbtxf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 12:32:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43PBtTFk035565;
	Thu, 25 Apr 2024 12:32:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45a9nbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 12:32:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya6TUQ2DMRjFtiW2p7NH2ytrPizZldkWTWcMmppmXejpX3wYTcOzwffiv3LDLIHJnvavrpyJ8sNEmSwU/YpUDyNYDSIG9ATREbUKZbfFmvw+oLeaMpUU8SsiA1EhCri7VLIRqt9vp4zAvGVK0IWxOKZt0r3/QLWhQe1sSnSPKXGwG4SU/kMbCxMFVRNVsZ9+76OlV9vyVWBJ+JCmI9W5xTPP7cnjRVXgtrccwkOc6Qh1d0/wRSKWDJ0YvjvU8+mHKjC8yuHTj5Hc11NbFz5rWvir1nvoWaMo0+4lNWHILilpgxtofewmD4jXVmMZet5eOkasmfjDKotq4x8gZEBA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0loyBC/ScJ8WvFRQEDmLiFHJ8txmt3LwGkjaLIcnBA=;
 b=BuQCZ55DggA4G0zvsafNOqul5iHkPGqqvog3oTnXDiXMVujavTSZ9/CLRS8GMcSiuG8w8SBZOGZVbDsji1zmSDBMLQV6ml2Aoi4bYBJu08tg69MeQpaHfOxJh4LeM270CSmW8heKRDlAv5EgXowQ/X2UtMjB4TuGRUNYssjdtRxFHk8OboJDLJPZ/d0dT5/iQUPiqJubcNc7J6dIwpE4prVA50wUsaCllMGsFAjYcebPA2O1w9FbHwmyVGpqQEi8uCwXylYV7Ksiv750gbxICTyMca5aG/uOh69xc6phoSVMb3X6AR1Vtobq4DTC7U2bGY6zLAJH4PWQUdHKQP5DIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0loyBC/ScJ8WvFRQEDmLiFHJ8txmt3LwGkjaLIcnBA=;
 b=qWBI3jHSflgOcinD13SqsIbOJSOrp/DGM3gHHyBVkz8RpDIp+wfwTyFMm2qAfgzLvtP3BE+R/N6XajFMlcum4WclN9dyt7bOMXCU9zaI7ZZ2YQuv4wZHytl20S7+GU23yGR3Z5TS4JolWajgnYEB9ek1Ys6V/pK3GGsW0cP4bKg=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by MN6PR10MB7491.namprd10.prod.outlook.com (2603:10b6:208:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 12:32:50 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 12:32:50 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Cupertino Miranda
 <cupertino.miranda@oracle.com>,
        indu.bhagat@oracle.com
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in
 selftests/bpf/Makefile
In-Reply-To: <CAADnVQJzLzrxtHeVcpNBtb-rnwWfApFEy_kv7LzWDee4pH1ezQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 24 Apr 2024 14:48:06 -0700")
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
	<744420fb-4b2b-44c8-9e35-1ffd9f086fd9@linux.dev>
	<87v8465u8p.fsf@oracle.com>
	<CAADnVQJzLzrxtHeVcpNBtb-rnwWfApFEy_kv7LzWDee4pH1ezQ@mail.gmail.com>
Date: Thu, 25 Apr 2024 14:32:40 +0200
Message-ID: <87a5lh4o7r.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::15) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|MN6PR10MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 862b7b1c-a85e-4168-8097-08dc6523d036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YlNKTUNUemlnMUZ6YmRQeFBYWGU1dm0rcVIyd25xckxVY0lJOHFhTWNJdFVh?=
 =?utf-8?B?M1lRTE1OdkNJb21oc2JzSkVmSEQwVml5TGJWL2ZueXhUMnFGQ2tXejVncVE1?=
 =?utf-8?B?bVR4Mk91N0tSVkdvVkZOaFBqZHJ1Tjh4NFhRUTA2RFBqdnVJTkUwejU0Nlhh?=
 =?utf-8?B?eW1pRzN2QzBseFR2U05RSFJzbUEwOGgxSllEREhRalZEQ0xGTys2SGdPR3d3?=
 =?utf-8?B?NnlsNkxDU0NKalBJVFR5QkxvTDMzUmVabkJLK1hJUGJaTG1PSXlIdXFKa3or?=
 =?utf-8?B?Mkp3RjZlTXUzeDR0ZXZTbmRNK1NoaUZ4MnpFbmhydzZzdDIwNTFhcU94Qnc5?=
 =?utf-8?B?RERxUks0bHFQeHpxcjdKeVp1L2RXNTJXbldTQ1UwTnAxTkFpMUZDaTFTOVhl?=
 =?utf-8?B?SENSVTBmckdSSFN1Rlh3U3BsZ3lmeFBiRmdWQ1o5YWpEMVpQYlJkK1hRaFNh?=
 =?utf-8?B?YjhJbWZyYUovRW5BZ295eTdJVHhNWWFjdjRObGdPY3gyMG5HQXJjVlM0Y2FW?=
 =?utf-8?B?WDFkUmI4RktjalovK0tsdEcrUHpvZFZ5RnVnODdGczJod0hsWGovOTBhaVdY?=
 =?utf-8?B?b1RKWFNxNzJxNXNGUS80cHM2R1M4TWZBb05UelFLWkxseEF3ZXBEUG9GUk5x?=
 =?utf-8?B?STJZYklsbGZmQmhMYTg4ZTgzMVl0cFhWaWpLeTRObGQ1Z2doSGF5NGR1aXVK?=
 =?utf-8?B?aldsNEdHeTJhRGE5dzkyeFBXQ0NON0VOdG5DK1BrMkJkZXArVy92Sk1RVm4y?=
 =?utf-8?B?R2ZWT042eEN6NVorZGl2WHVaa1NUYTZzUnp6UUZoOE83bXl3NE8vMk5XT0xI?=
 =?utf-8?B?QXBld3M2U2JTMkZVRlJzUlA1NzdpMGdEMWFJcjdmSVY2V0ZUMnNIM0ZOckZr?=
 =?utf-8?B?M3dFVlp6RjJ6dmlubVF3TkV4eVhkRWNINmhyOHZBbnVOczRYdGR4b0s3R3pO?=
 =?utf-8?B?UjF5OWVFUkU1VCtGN1Z3TTVpbFlhRlg4cjVkYUJIODJSWFFZY3o5VmFEam9C?=
 =?utf-8?B?ajV2TzNwdGhYdWRVaGloTUlnNFFXNUN1YTNCK2xFS0tEQU1ueDh2TDMvV00r?=
 =?utf-8?B?VktBb3F2RS9POUlLQmNFQWw4U2lHcExHTWg5TkhHR04wNk1FdTl1YWtGYVlD?=
 =?utf-8?B?MGtIUVpjU0ExYlk1eFV0dVJtMUJsckc4SnI2ZkZkZ2NpMjBtYktaQnVXcVF2?=
 =?utf-8?B?blhKdXUvSTFaOVIxR2ZJa2wrTStMZ01Kdm9BR0FSdnUraE9EK1RYbnl2V1U5?=
 =?utf-8?B?eUVTVkhGSS84Y1ZLRlR5TzVGL0Q1UHZCQ1g4aUZHYURoam0zVzJaV1hXTEVU?=
 =?utf-8?B?OERTU1pVQzh5TTZCMTVXdjdlMnZ3VzZ4MCtBZzFzRzVPRHdjN3pmdkVac0hM?=
 =?utf-8?B?OHAxWkN3cUYyM2dDa09yVm9pVitZcCtDa2ZxcitqSXJZakRwdTIrK1A0YjQw?=
 =?utf-8?B?d04vdVFYOEU4YVY3K0JDeWhPUmZLbFhhRnNYeXk5QzNTbFlPdCtjVm1GU0I3?=
 =?utf-8?B?cXFWT1lhSHlqcHRTcXB2WElDUGNMYXV4V1IyZG8wM21wWTZKT3NEalZ3STdH?=
 =?utf-8?B?bjN0bGRveGRWRDlyMWxzbDZaM1BVZWUxbm4rNWltUFdYaTlKVnpCR1NPZXNO?=
 =?utf-8?B?bHlYWW9abnlwL0VIK1YrM3EvOENsRVBORjJXU0NNNFlFdXlqUUhONVE1YTVh?=
 =?utf-8?B?YlNtNlZPbjQvWXM0ZDgvNVB2dmhDUFNhT0VIQXg1MkN3UElFejdCKytnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEQ3c055clozNkZEWkNxdC9IY2wxOU9xcnBrUFZ3TjFCMUxsOFpOUU1xTTB2?=
 =?utf-8?B?MmM0NXlCUVNmaXluNldZdlBLQlVZOFBzTko1L2pCTmwycHU2N3hEY0FYZFA3?=
 =?utf-8?B?ZW4zUlpHTGZjcFZwc21nMHBnQ1hhcm1NQ09IK0ZQZjY1aWx6T2ZQb3MrTXFj?=
 =?utf-8?B?YUZyWEd4K25STHN2b0FLYjB6b29lc2p0cjRvRGM2NkR4bksxNUJhSEdBSlJT?=
 =?utf-8?B?Y3cwVHgvRTR2WG40dGF0L3JVVTRsVDQ5UUE5YzJHSHhFU3Z1QnVxaXdKYzI1?=
 =?utf-8?B?b296Vk56S0J6RHJYWlRROENubGl4L00yNTE5NUwrQnlnaDVKcVBzUUllak5h?=
 =?utf-8?B?b3FxSHZmZHplc1lzZkpRd1pWbTF4MVkreVNVeGowcGR6UTVWQjdJdmVsdFlv?=
 =?utf-8?B?cTdUV3lWZHlINHlyMmcwTGlZSXdUMzZoekREYTB2UkViMFE5c3ZQcVFVdk5q?=
 =?utf-8?B?M1NEdUJqaGg4YlJpNjlUNzFQa2ovVWJJTTFLVzgwem8wUXdqYjRvL0FZeTlF?=
 =?utf-8?B?Wk5MSCs0Q1ZJT0hITXNORHB5NVZBbzZtbC9KSFJ0OHR3enNJRzArLzh5SlZ6?=
 =?utf-8?B?Y1NMVDhtSmxiOHd2TitMYVhtVEtoNllLNUdqZTkzY1kwWFFTZ2hmNkJaWDZC?=
 =?utf-8?B?WWo1Ymh5VEk4cHA4UU9BT0pBMUsyTW92K0pqNnM3ZXVvVVVnMHZIRUhrdlFF?=
 =?utf-8?B?ZVhPb043L1ZUdVJIWExlbUFqOWlEZzZ5Sk9HSDQrODVYYU5Ib3A0Z2RaN1Vn?=
 =?utf-8?B?a0ZMQ1R1bUgvNXY1QU5CVWh2OFJETStjM2RYZ3Izb1V5ZDNOUURBUWhUNktp?=
 =?utf-8?B?T1djUHZNdjZIUWV5cTNkN3ROck1SS3VTZEFGaTFyejgycld3SXdWcU5NcGpU?=
 =?utf-8?B?R1VXbWtNU2NtUDRKNmMyTGhGUGJVUXBxc3BSRVdBWnpvTW90bHFWeE9SUDRa?=
 =?utf-8?B?KzhxR21BZElEWmx4c0Irc1NQaUVPdDFvMU5hQ2M5OUJLOTdtMUMvazl6dWp6?=
 =?utf-8?B?T1VRbi9OdlUvbkpwcHlQZ0dxRitEWmVPV1NuQnVEMmg1cjZEYkk5WXEwQ1FZ?=
 =?utf-8?B?eHl2NjZza3JJZ2x0eEU5U3FxUUVwUVZqL3hnZDVLZWlET3dSLzVnVWYwWGN1?=
 =?utf-8?B?UmI0OU1XTFNsZStLS2o3WExmd3ZibWR0VFJEWWtIWjJvWXBlTWtNMEIvYjVy?=
 =?utf-8?B?Q1ZMLzFncTZ6Y1lPOFE2YXdyNjZrVVU3ci82Ny9FYzJwSDZSOTdyN0t1MExt?=
 =?utf-8?B?QTAwVXlLZUdtTkQwL1ZnTjBvTm1pRmJ1OUNvcFIzbXZ0WW5pQVpBRmhBRU54?=
 =?utf-8?B?ZVUvMDZDaTExYjhscWJjd251Uy9NSnlUczQxQ0N5ZlI0YjF4WkhTYzNDdWxs?=
 =?utf-8?B?UzVoT3pqMCtISnN1Sm1DUmY1SHJTVGk2a2ppaGU5YWNFbVo3dENTVCtmWnQx?=
 =?utf-8?B?T1RvYjRSd202UjFabXVENTdFcTdpUzl2N2RtclkzRzlYNjNpWmprSkJBYXdt?=
 =?utf-8?B?L1BuQWR2SHFlRWRSM20wZzJ0UTlpdy9JeEcxQnhJWnpRNEw1Tm9nQ3QyZG1G?=
 =?utf-8?B?bjRqZ3NmTTFaU2xYT1ltTGRveUVtSXNheTF3L0IzY3VaeHMxWHdTd002Yi9N?=
 =?utf-8?B?bElKdTlTSXBYWDJ5akc0bThaUFNpRTVrK2tucDlSSXFZTlh0MWVkVHhlVm5T?=
 =?utf-8?B?ZFJVaStnZHBTcDNVR2FJV1lYdzVZaEwwb2ZXM1Y0WWtESVN5WlNwdnkvRTA4?=
 =?utf-8?B?aUpqeWE2elhvTEcxWEFuYjI3c29qTjRMWmtwdC9jUDdkZVJ0YXlJMkNvUERH?=
 =?utf-8?B?S1F4OWs3bGZwa1NJcGVaandyRzlHaTYyZDlzaWNnVmdibENlOE1nZlRMNE1y?=
 =?utf-8?B?a2N4RGxzVkVwV0hHKzJlVlBOUll5Tlo3MGtva0QrMjBsdW9lcHdtZSt0OXhR?=
 =?utf-8?B?V1gwbUF5Rlg2SEhCTklQNW1aMElLOEdRaTdQVXFtM2JNMWlwdGhmUHl0SVJE?=
 =?utf-8?B?V2lnM3FXWTBaSlpyR1FYWFlOMGsrVXo0eThMZnJCZmxqbG5zQWE0Mi9wNnFp?=
 =?utf-8?B?VTJhQ3Z0dVRTN3B1MnNFMU5QaW1DZTNlYWU1aTJDaS9ZTjhibXpGSFE3K0JS?=
 =?utf-8?B?Q25mUGJDS1NNRkpqTUFLS3ZPSThNQ3BnbFFuQjB4alFuL2g2cHU1ZjFLTm1m?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PbfZpxvpSHguGRjlGOE9hvFiVwx9SKVsg9rjALS/6mBE970d+8LKxCfJA0HGsSzxrBRRzAfV9dkiBAA5QNsR9AfED3gh5HI+AcxBLMDLBjeR/8NrGPavwgKiwQIwBIMlF9DM8mNOEz8MjM/rRBie9GiOe65syXNiuUJ+nAHQikQ/938haqCE+idvxuoaAeAF3g7HB6BJXbLKOx+tP2XzXdslSwGwxhqBT3BJhgoYRYWwdPhbhL7Pf0FXkOGfk1fW69AGhx8jlbNhUThqLl9rnLW5+G812uZGRPOeVVdY46weCh8RwlTJOlB6cijv3Spsmv5kIEzDwwOeTZbyBaz0zlvTbM3vpx7DKhdMvx3Zp9HSMYdDrn41JTOY91KtH/7lBVKL87cSFfEzmUqlavxTmDujrHnQVwoJhLYVJBPNoObLtBb9y9zrgslvM3pOMvlt51LKF44iGtD9/KbvcPiOle4gtqrPgC9ZQiK4p7mHPTzV/Ky2qatroY5SZykSgs2f60ONfKGdq2aax4z2/xtXJ5JRpxjt7sGa0bv/qz+vaFoR6slxWGPKZNZl/E7LmweRd9k6ee4jUDmTVTvJrdCCBbkxAzhSJERD7Y9KABgm1+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862b7b1c-a85e-4168-8097-08dc6523d036
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 12:32:50.5918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qG/TJlJRngCWdaDNBWxNnZFyD2XQIBD1X4r0BMCJRLPItJRlzNcnhknQ+HVgWFoTXGsUKtODwMk47obE17OEiLLDBFMBW31wwSoKLhF8/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_12,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250091
X-Proofpoint-GUID: BoxvoId4JJ0LaieNPzE38A62Qty2Tcnv
X-Proofpoint-ORIG-GUID: BoxvoId4JJ0LaieNPzE38A62Qty2Tcnv


> On Wed, Apr 24, 2024 at 2:30=E2=80=AFPM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> Hi Yonghong.
>>
>> > On 4/24/24 1:41 AM, Jose E. Marchesi wrote:
>> >> This little patch modifies selftests/bpf/Makefile so it passes the
>> >> following extra options when invoking gcc-bpf:
>> >>
>> >>   -gbtf
>> >>     This makes GCC to emit BTF debug info in .BTF and .BTF.ext.
>> >
>> > Could we do if '-g' is specified, for bpf program,
>> > btf will be automatically generated?
>>
>> Hmm, in principle I wouldn't oppose for -g to mean -gbtf instead of
>> -gdwarf.  DWARF can always be generated by using -gdwarf.
>>
>> Faust, Indu, WDYT?
>>
>> >>
>> >>   -mco-re
>> >>     This tells GCC to generate CO-RE relocations in .BTF.ext.
>> >
>> > Can we make this default? That is, remove -mco-re option. I
>> > can imagine for any serious bpf program, co-re is a must.
>>
>> CO-RE depends on BTF.  So I understand the above as making -mco-re the
>> default if BTF is generated, i.e. if -gbtf (or -g with the modification
>> above) are specified.  Isn't that what clang does?  Am I interpreting
>> correctly?
>>
>> >>
>> >>   -masm=3Dpseudoc
>> >>     This tells GCC to emit BPF assembler using the pseudo-c syntax.
>> >
>> > Can we make it the other way round such that -masm=3Dpseudoc is
>> > the default? You can have an option e.g., -masm=3Dnon-pseudoc,
>> > for the other format?
>>
>> We could add a configure-time build option:
>>
>>   --with-bpf-default-asm-syntax=3D{pseudoc,normal}
>>
>> so that GCC can be built to use whatever selected syntax as default.
>> Distros and people can then decide what to do.
>
> distros just ship stuff.
> It's our job to pick good defaults.

Yeah it was a rather dumb idea that would only complicate things for no
good reason.

The unfortunate fact is that at this point the kernel headers that
almost all BPF programs use contain pseudo-C inline assembly and having
the toolchain using the conventional assembly syntax by default would
force users to specify the command-line option explicitly, which is a
great PITA.  So I guess this is one of these situations where the worse
option is indeed the best default, in practical terms.

So ok, as much as it sucks we will make -masm=3Dpseudoc the default in GCC
for the sake of practicality.

> I agree with Yonghong that -g should imply -gbtf for bpf target
> and -mco-re doesn't need to be a flag at all.

We like the idea of -g implying -gbtf rather than -gdwarf for the BPF
target.  It makes sense.  Faust is already working on it.

As for -mco-re, it is already the default with -gbtf, and now it will be
the default for -g.

> Compiler should do it when it sees those special attributes in C code.
> -masm=3Dpseudoc is a good default as well, since that's what
> everyone in bpf community is used to.

We will try to get all the changes above upstream before GCC 14 gets
branched, which shall happen any day now.  Once they are in GCC the only
extra option to be added to GCC_BPF_BUILD_RULE will be -g.  Will send an
updated patch then.

Salud!

