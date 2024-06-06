Return-Path: <bpf+bounces-31494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8228FE4A7
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 12:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F58628503E
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6361953A2;
	Thu,  6 Jun 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VvXNLOG5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uEJ2Y5Bv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198F819538E
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671039; cv=fail; b=rFxuMAgEZziRSW8qD/kguqpxmC0Xdhgr58XqQhjRxRMnxSCVqitnX3+VR9Ej/Qr2yk1eF4bkgvwjXyfKjorXMZ8tMs/DGXAYyx6ygQJukEtqVILAJz4E0UV21P7NowRM7Rc9b/DzTK8EuNZ2rgL55QF9rHGsLwfOLMLjo4f1B40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671039; c=relaxed/simple;
	bh=2gidoPrstEgwqWGLEf5S3baNivMWAFnHPh9QWa6+A/A=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=WdmLnYJHpqOTeCd0OTP7M7pMUzo34YhD49GLfwlRIBC/Q6bZR8Be5tqSru8n2A0bvF0Y2hwouwC6YhpuEYsD5SY53uanK4QjyXSzmA6BB+RC66BMoTtibAXOfNRtWgErL8JJq6C9IER7q05PdyrC1w7sKzJQjKGxo88/WvhggVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VvXNLOG5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uEJ2Y5Bv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568iMwB020102;
	Thu, 6 Jun 2024 10:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=kmzMLB/3SxbqrxxlYde/1ePGbWUa0MySDA+Ogkrobcs=;
 b=VvXNLOG5XrND5RCPiCjkmRLghVaah7zzeVMSnXUdHsOVl2dkOa1qR/HMS3KunmX5Y6bx
 fI6LjhKBE/++ahpwK28e+3QHJ1KthYwffM4Fa1GE8G1Qw8GliQweLPAvOqd9XYjkIxuI
 CnRZ2h2a1fbiqyMClsR69f2yVZN3eQWyMjtwmgE6Tb9SwbyOo7vca8SyONSxIqGpmFfe
 h7gQUf0OHJxUKNLryeP5MDZnv4KUMR8bE7HLMkT4eaSMGMIV6vF2y29BBSDDyWwRxa64
 yhRw3DOFAbcnhNS7lomiXE9vpCExKtSkXJjvjAD6d0UeT48pwIb8aehS2+g0ZZX1JtgM gA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtwb7jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 10:50:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4569RgT2020606;
	Thu, 6 Jun 2024 10:50:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj4w7se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 10:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koUOU/ryw5XI9gGG/Wu8vqGC+jeGXRkavtKRZMZnRE8PUPJ2YpETtuKcBLjLMuHKu7I2/q6m8aMUupPTWse2STDUsyYlPHkN2U5leHW26Qnb6iaeAGNgXzwW0T67fQA1iQjqX8MWGlQwOk5bzVA/stDcKeZcorQXFj7YtKjeCAVXULDUxmtpHOGk3aiBXAgWxKiuZ09WAAQ1PrAup7ys1UquNlj0zA1G5kBq1Du6GqoxTpn0fFnyfJmX+TTwbKU/9CfLCjSOQ3xTV+u4KVzmrvN/3FG/IoZUUOUXU53gd7cn2OC9a256QQvSR6xwLRqJTn98EgIxpzQl+P25kqk/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmzMLB/3SxbqrxxlYde/1ePGbWUa0MySDA+Ogkrobcs=;
 b=ds0o14SZj7ApMaOqh9l5/mBwqyCrO501O9uiCB/CtlfugRuQ2rF3fJ/lalBFo+RbGMSZcww5rBX/v8DCitjlZFFMwOdEhxEesRQ0MK/DP2qFyKEFFyQ6QRrJ3joeO0zr44Q9uzJ6iHYelxgYjgV69WIG9UbVUw/YYR7OOEBXjgqxyBa1W4kXZqFV8lwIIHN4KX1+AQmV8pqemWx/dj4Rz5cpacgpETOnALdcdnDe4XnxfICYZEuEcL+NVMfCI+m9/AGt0h6ypEN9+EkMycAw3ipLGmqx8+wOjx1FmjmbYfl0MhjRNv0E/F7xkSe1W4ARCNyJof0AgxvpyGKLrIXGgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmzMLB/3SxbqrxxlYde/1ePGbWUa0MySDA+Ogkrobcs=;
 b=uEJ2Y5BvS8pDvfo89VLuvYik/wvMvPRkQTB/shVI17G3oIhq8kmN4VT6KHbly+RWgVZp78DINJaLQoq1kIEDWI6kRjOUxy6XuRbu8BOVelCVnnC5xMnQVYTS4bC70Hun6CRUgxq/lmTKDB7HGJpifmosOatWC8E/U5rkwr2dlQs=
Received: from BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10)
 by MN2PR10MB4174.namprd10.prod.outlook.com (2603:10b6:208:1dd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 10:50:24 +0000
Received: from BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c]) by BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 10:50:24 +0000
References: <20240603155308.199254-1-cupertino.miranda@oracle.com>
 <20240603155308.199254-3-cupertino.miranda@oracle.com>
 <CAEf4BzbqhhLsRRTP=QFm6Sh4Ku+9dKN4Ezrere0+=nm_8SzwYA@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, jose.marchesi@oracle.com, david.faust@oracle.com,
        Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Match tests against regular
 expression.
In-reply-to: <CAEf4BzbqhhLsRRTP=QFm6Sh4Ku+9dKN4Ezrere0+=nm_8SzwYA@mail.gmail.com>
Date: Thu, 06 Jun 2024 11:50:18 +0100
Message-ID: <87ikymz6ol.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM9P195CA0002.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::7) To BY5PR10MB4371.namprd10.prod.outlook.com
 (2603:10b6:a03:210::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:EE_|MN2PR10MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: e0502d96-b1c0-4961-817a-08dc86167821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VEM3eklCdzNEOXhPWDJreFZIdjFueDhKeTk1RlMwTU9MRmJoSWZHd243aDQ5?=
 =?utf-8?B?QkJqaWpiQzdtblZkcC9laTBxOUZaOVR6YXE5YUlHOGhoN29lVDFMVzl5eUEy?=
 =?utf-8?B?MmZ2V0R3Vm9GWGlubVpqeUhrVmZSNTNzK1RmTGZNeCthMTRwK0R0bE16WjRY?=
 =?utf-8?B?QXk0NVVSd1JWa3dhNE5LREJ3MjNJemxWUHdpRzgzL2dBV3M4ZFlQYzhadGNr?=
 =?utf-8?B?R3FjMis0SjRCS1JKenJNTDlvSFZIWnZCTGlKWVd0L0NKeUZGc05UWXhFdm5z?=
 =?utf-8?B?UnltY0VCekRxc0FSSTZoY2FuTVp0aElNMHVVS09xZHV6Q21CWWExUmE5L0Nu?=
 =?utf-8?B?VFRhc3NaQUJBaXNnM0I1NWFMMW9UZERIZkxPaDUzZG9VbnhDZmZyYUFrZ0JV?=
 =?utf-8?B?bDBaNlJNRUliQWV1Ym9FVElneTIzTnp6bm45VU9jN3IzZlh5OTdTV05NOEQy?=
 =?utf-8?B?eDZsa1IyVjJhNUNSVFFiWGVRRGI1TW41d1RPMGdCbkZoVkZBNHVQY1lXVmZE?=
 =?utf-8?B?VFhYbzROM0MxamtPckFtYStnVkRMY2VqQ1U4dW5FTmw1VzZVQzlWN2w2V3hM?=
 =?utf-8?B?UUNlOTdEL0dMdWRNTDQydXVYSUx2eUlYdktOUitySUlwL3AyV1dpV1RIYXdt?=
 =?utf-8?B?T09DKzE0eXlYNFFzQkpMT0JldW8zbk9zYWpUamxtWjE3WnZZa1FCVkhMYzJ2?=
 =?utf-8?B?YmlIMEdUYkNUbCtWTHQvUnRRTWpEM1FYWDE3RnhzdXlNL1lVU0hmNHpDQksw?=
 =?utf-8?B?K1FMTXBtQklVN0JjNVNoN2VoWlR2L2dodjdGYzlDMEkwNmovdkFiOEp6U0Z6?=
 =?utf-8?B?ZnEvNU5IaXNYS3RWTCthVUhhQ3dTM2VkbWVyZGo2cGVveFI4dGpNc2o0cjRr?=
 =?utf-8?B?aWJ0cE43Nlk1Yk9SWUFUY2lWdW44c0VPb3ZxUThKTjN5T1JHZ2FZdXl3OS96?=
 =?utf-8?B?VC9nMEJEL1BIQldacWVDd1gweXR2RHBERzBwZ1JrblFWSlB1bmprOEZpOTYv?=
 =?utf-8?B?RnNKNnlhTkducnRrWWpmdXl3SGE3czhFMXVCajY2NGdhRU1yVlhpTDNKTk5q?=
 =?utf-8?B?cUxKNForamx6MVd2Z0VMcGRPV3pudTdNL2h1WWJydkNCNDluczVpTExYMDVF?=
 =?utf-8?B?aXFHMGtyTGVzVFROVlhUenVsanlVNm1IOXBqaWJUUXdCVUZBRWRxUVM0MTc1?=
 =?utf-8?B?ekdtQi9URFg1amFqYVMwRExqaFVnZGdqRVMvSW1ycmVNb1I5SGxMdVF2bk1Z?=
 =?utf-8?B?WHRNMVNPZC9ncEVzQUw5Y2djZnhQSGhIU1MrcG9zQkhlUG9raUN3VjcyTk11?=
 =?utf-8?B?dThnMmV6bVhEMVJyend0a2VvcnFBcWlsVHVWRXZZV2xXNG51bGN2NEJZSUpI?=
 =?utf-8?B?Q1JXMXZnNFdNak93Zi9oMGVTNThwU1FGWktrVkkxSkJCR25zYU9QYUlKRzBx?=
 =?utf-8?B?NURzeW9TUlpYV2tEc1JFM2JXVDlnUCtWY3dJcEFGQkNEekc0alZxVkJ1dVZM?=
 =?utf-8?B?cDVnQmdsVk1kcUF2UVBiZHhCc1pseXhEakhybUhyNkFKbWMrKzJySUJQd3dl?=
 =?utf-8?B?SzMwTHBXb3AvQUpJQzN6cEtzM3d5Mng1MGl2TlpSbjhtdDlCMm5vSFllMW41?=
 =?utf-8?B?bDEzTFZ1MEtBb09kNk03SFpScnZucUQ5ZkJBb0ZTU2NNSFFMbjl2MHZxVnUx?=
 =?utf-8?B?NnpSNjJ6Y2tFWlU0QVVwUFl4VElJTmJtVzdTenN3UjQxS0JhZ0hhUVhEbERi?=
 =?utf-8?Q?aTdimTIMfzm3jT9n0AfojvjZyjdIYp+qBwjr/dP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4371.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlpFRzQ3WGpsakY1akNRQUZFeCthUVFDTzNGUGZGQ2p2ZW5OMmZuK3JXUFN1?=
 =?utf-8?B?VFNFNENTN05DcmRvYmd6L0ZocVpMWjBzbzNIL0RZaHNTcG1hc3o4TTlvcCsz?=
 =?utf-8?B?eEZ1ckcwY3YrL3dtWWZpR1lHK3RPRHNxQUxiWDRHZXFDcVh2QlR5WEtoLzVQ?=
 =?utf-8?B?MzFjQy9jWXAxMXJwT2Y4NjY1aWRqZFRabkxRU1JwUXhCQUVkL1AxYWhJSW11?=
 =?utf-8?B?RDNrOS9ZNC94NTJnWU5jdzIzMVMwT0h0Q1FQYk9UR1VXWHR6ekRnT0c5ZFpH?=
 =?utf-8?B?M1J6VkxVRFVLak01MU5LZm00K1Jmd0plQTdLSkxjSU1lcWFrRWZPdVNlZVZv?=
 =?utf-8?B?TSthaTgwcnJnYjdVMUg0d1hkTzFZaU5wS1NYaU0rUG9rSW55bk9pNGJWWEJ3?=
 =?utf-8?B?RTdGdXhXQXkzUW9vMmdEeEF0d0xlbHJ6QzE5YVh5L044M1ZLaTMvdjdpMmt0?=
 =?utf-8?B?cnNaOFJpTlh1Q0V0SWJxRVcxeXBUbk5Yand2S3N3cjRNbEpFSjQ5MGFON0dR?=
 =?utf-8?B?Y0FCdkdaOWsxY0dmVEYvMVY4M2U2bzhJQ1JJT0VsNHdzRGQxOTFBQjJJQ0ZX?=
 =?utf-8?B?d0xzMkY0MVlhMDMyTXBZb1RxREd1Q3hUTHFFSEN2Tmt3bnduM2tOUmNYSnJv?=
 =?utf-8?B?T1RHVnhoc3N2YTBRV0YvODRWd2pwZGYzb21FL0F6WXRlS2xNMVZwcWNCaGtl?=
 =?utf-8?B?RXZlUi9Da2NwZXArV0pXL0xXeE9Dc2Q2RkgvODkwM1dmWDQ3VDc1OUZLaExQ?=
 =?utf-8?B?Zi9Vb2swQjBPK0tLb2xmekxHejVraVlick96OFF4WjcxS1BrZEZDTmlTTllo?=
 =?utf-8?B?YUJEWFZaWTJuS0YrbHY2RHBxRU1FWmlzUENGdFQ0RWliTk5FUU1DZ3JSVWR3?=
 =?utf-8?B?bFk1Tmh5UThZZnhacFlST2pwZ2I1Q282VnBPMDQ5cUw2SExJdEppRjIyV1Vz?=
 =?utf-8?B?WmZ6NDBJbmNTbFpmUCt2M1Y0NU5HTnZwUHB4c205R0VxaFJyd3VPdmd6UlVX?=
 =?utf-8?B?T0lRR3pVdzRNMzdVZ3o4TjhDYmRjU0ZEYkMyTjZhOGZSdXcvTUQwSURQd1Zy?=
 =?utf-8?B?VGhBeWJ0WlZnbm82ZThYUmw4SnJlVjd0UFVkTk9RSkppRExSMUR0L2tHUkNY?=
 =?utf-8?B?R2NnNDg3cXFONUNPM2d5U3lEbHZMZ1dTMjliU1BxNVRRc3dDMThTVjVDSGxH?=
 =?utf-8?B?eEFYOGU1akZiaDhBcU9kOWRLOC9ETzl3RTNUZEhwTFA5V1VFWXlJdW1VUDhv?=
 =?utf-8?B?TDdHcWxTNmozR1k2cVhMSm1KUUNESWY5Y1ExZjRObk1nYllwQVQrTEtHMzNV?=
 =?utf-8?B?dkF1WkNpSEw2cDA3aENwNzUxNkRIZGRTMFp4bStYZlIxUnJmOHNKVVBHZE1t?=
 =?utf-8?B?RitsTUxsbHBmY2QxNlhHWlJNelo3WDRrRWYzbDNRbGg5OGVQQ3V0d1ZYNnZa?=
 =?utf-8?B?OXJocXRrNnFUcmZTcTJmU1J5UndtS2tnN25oYnZyTGtnZkdDQ09Zem1VRC91?=
 =?utf-8?B?TTg0MHBlanRZT2NxbjVPWnNrU3JhTHZDUW9PMjhFVnByVDN2TkRFS2NZeGFF?=
 =?utf-8?B?Nnc3WDZFVlM5S2RtQXdybk9wOHNoNXVWZW5yMEV4dUVGZE1VWTdvSFB0VitK?=
 =?utf-8?B?V0g0eGIvakhIcFdUZ3cvK1ZuZS9BMWhwemVPSXRkU2xFTnZrRlhMSXBOaUFO?=
 =?utf-8?B?UFluYnA2M1lyZTJmb3djM284YURlUFB0UmRramwyM2ExR0F4cm83MGlodVZU?=
 =?utf-8?B?UDVsVTJzK29qZ3dGaVk4bzJNd1VvaklCZG1mSFVxajc4aWFvMldJUFF3bU0w?=
 =?utf-8?B?djdOWjE4bWx4c1NvYTV3dlJYRzhFM1ZTN1R0ditJYXJ5bi96Z00yNFUzSnFH?=
 =?utf-8?B?RG1ZU2Jqck1zSkVETzZKMEh4eVcvVk5rdDJ1aVduM3dTY0ZFMExWUFl0bTM4?=
 =?utf-8?B?aWpIZktLNWw1d25YWVJhamtJbUNPWWw5K2RqaU4wb2ZaejRsckZ4REljTHkv?=
 =?utf-8?B?YXhqM2F1ZjZJNmVyZ0l0ZzZuNjVTYU83L1luMFU0WWRhMWdsTTR6SFp1bmpv?=
 =?utf-8?B?R28wTkM4bUhFeWsxemFsOUN5MzhzT0U3N2x0bkRyRnA4QVZhTTdldFI2aEFx?=
 =?utf-8?B?QTY4N20yRWRjclNPWjJITWFtKzNmbnNtdEVxOUQyN2ltN0xRNEdjNmRScXN5?=
 =?utf-8?Q?TdjfS/5J8T4drGkRPXYUlHc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8B75Btpr//nN0aiPu+vPkz4xolITBCFIUJrfTG5jURlPEuAtZA4sFxZ6UYFrH+RTGQsAvimGIO2H63V+/ei573ZKFqivsLkq2oQSf1dlLfAYrGTs/vd0lJDZmoDMXMJyqnucCKVP+JxHddCe+z6UdJdWNzEFKFQaeD8iFUn6GVNg/s9RbdLO3dEEAZK/nrko7nRBly6JhJjem8cYPyavO2ODWPeAr6jcIJuYOQwAAn98CYOO6UrgjwooC7ddrH6J11UKSuhB2ondSHlY2/mUGxDurxS+PUlB5KpwLGhI4ehf5fWUoi6wP1UVkcA3j0a0TvGKdqk9aTHaGEY/BO8Lc/L7TYd9MbvPdWYkQ2tdtqC5apBECSM7teyYXHMdIGd8Fb+wS7hj+iW/fWzuhenZQXZsdymugjlJYEfrOhctkrAyXlu549O2DUKBB4Dr2OkAvOKHsF1F6UQ8gdXCg8VOcOTA2bIMOVUPMhIKyPEzGUO9B/oshJ/1i0TX9VSF2cjrweHCahC7BJsjImCCjNA0Dg22m2FkWjf65bdh6SbN7EHnMiCnj2JrZiAqcvdWzclvQ0HNmkUZsgAh8n6BHYOMrN67Gg6BV7vgt6ztXg8eHqo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0502d96-b1c0-4961-817a-08dc86167821
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4371.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:50:24.4837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLLiP6+UjmN+Xnx7Cf5vtXoKVyWMji7b3f9vqKd9NzIQKWBXRBbSTnYSGiggLxFPZwh0MHneYmD0ov+XitkxNW/7hTRLvwoKvaia8spzjQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060079
X-Proofpoint-GUID: zp0yFpBD-haoAvVpQAdZ-H08ckZ2g_lv
X-Proofpoint-ORIG-GUID: zp0yFpBD-haoAvVpQAdZ-H08ckZ2g_lv


Andrii Nakryiko writes:

> On Mon, Jun 3, 2024 at 8:53=E2=80=AFAM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
>>
>> This patch changes a few tests to make use of regular expressions such
>> that the test validation would allow to properly verify the tests when
>> compiled with GCC.
>>
>> signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>> Cc: jose.marchesi@oracle.com
>> Cc: david.faust@oracle.com
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> ---
>>  tools/testing/selftests/bpf/progs/dynptr_fail.c          | 6 +++---
>>  tools/testing/selftests/bpf/progs/exceptions_assert.c    | 8 ++++----
>>  tools/testing/selftests/bpf/progs/rbtree_fail.c          | 8 ++++----
>>  tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c | 4 ++--
>>  tools/testing/selftests/bpf/progs/verifier_sock.c        | 4 ++--
>>  5 files changed, 15 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/tes=
ting/selftests/bpf/progs/dynptr_fail.c
>> index 66a60bfb5867..64cc9d936a13 100644
>> --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
>> +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
>> @@ -964,7 +964,7 @@ int dynptr_invalidate_slice_reinit(void *ctx)
>>   * mem_or_null pointers.
>>   */
>>  SEC("?raw_tp")
>> -__failure __msg("R1 type=3Dscalar expected=3Dpercpu_ptr_")
>> +__failure __regex("R[0-9]+ type=3Dscalar expected=3Dpercpu_ptr_")
>>  int dynptr_invalidate_slice_or_null(void *ctx)
>>  {
>>         struct bpf_dynptr ptr;
>> @@ -982,7 +982,7 @@ int dynptr_invalidate_slice_or_null(void *ctx)
>>
>>  /* Destruction of dynptr should also any slices obtained from it */
>>  SEC("?raw_tp")
>> -__failure __msg("R7 invalid mem access 'scalar'")
>> +__failure __regex("R[0-9]+ invalid mem access 'scalar'")
>>  int dynptr_invalidate_slice_failure(void *ctx)
>>  {
>>         struct bpf_dynptr ptr1;
>> @@ -1069,7 +1069,7 @@ int dynptr_read_into_slot(void *ctx)
>>
>>  /* bpf_dynptr_slice()s are read-only and cannot be written to */
>>  SEC("?tc")
>> -__failure __msg("R0 cannot write into rdonly_mem")
>> +__failure __regex("R[0-9]+ cannot write into rdonly_mem")
>>  int skb_invalid_slice_write(struct __sk_buff *skb)
>>  {
>>         struct bpf_dynptr ptr;
>> diff --git a/tools/testing/selftests/bpf/progs/exceptions_assert.c b/too=
ls/testing/selftests/bpf/progs/exceptions_assert.c
>> index 5e0a1ca96d4e..deb67d198caf 100644
>> --- a/tools/testing/selftests/bpf/progs/exceptions_assert.c
>> +++ b/tools/testing/selftests/bpf/progs/exceptions_assert.c
>> @@ -59,7 +59,7 @@ check_assert(s64, >=3D, ge_neg, INT_MIN);
>>
>>  SEC("?tc")
>>  __log_level(2) __failure
>> -__msg(": R0=3D0 R1=3Dctx() R2=3Dscalar(smin=3D0xffffffff80000002,smax=
=3Dsmax32=3D0x7ffffffd,smin32=3D0x80000002) R10=3Dfp0")
>> +__regex(": R0=3D[^ ]+ R1=3Dctx() R2=3Dscalar(smin=3D0xffffffff80000002,=
smax=3Dsmax32=3D0x7ffffffd,smin32=3D0x80000002) R10=3Dfp0")
>
> curious, what R0 value do we end up with with GCC generated code?
Oups, this file should have not been committed. Those changes were just
for experimentation, nothing else. :(

>
>>  int check_assert_range_s64(struct __sk_buff *ctx)
>>  {
>>         struct bpf_sock *sk =3D ctx->sk;
>> @@ -75,7 +75,7 @@ int check_assert_range_s64(struct __sk_buff *ctx)
>>
>>  SEC("?tc")
>>  __log_level(2) __failure
>> -__msg(": R1=3Dctx() R2=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D4096,sm=
ax=3Dumax=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))")
>> +__regex("R[0-9]=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D4096,smax=3Dum=
ax=3Dsmax32=3Dumax32=3D8192,var_off=3D(0x0; 0x3fff))")
>>  int check_assert_range_u64(struct __sk_buff *ctx)
>>  {
>>         u64 num =3D ctx->len;
>> @@ -86,7 +86,7 @@ int check_assert_range_u64(struct __sk_buff *ctx)
>>
>>  SEC("?tc")
>>  __log_level(2) __failure
>> -__msg(": R0=3D0 R1=3Dctx() R2=3D4096 R10=3Dfp0")
>> +__regex(": R0=3D[^ ]+ R1=3Dctx() R2=3D4096 R10=3Dfp0")
>>  int check_assert_single_range_s64(struct __sk_buff *ctx)
>>  {
>>         struct bpf_sock *sk =3D ctx->sk;
>> @@ -114,7 +114,7 @@ int check_assert_single_range_u64(struct __sk_buff *=
ctx)
>>
>>  SEC("?tc")
>>  __log_level(2) __failure
>> -__msg(": R1=3Dpkt(off=3D64,r=3D64) R2=3Dpkt_end() R6=3Dpkt(r=3D64) R10=
=3Dfp0")
>> +__msg("R1=3Dpkt(off=3D64,r=3D64)")
>>  int check_assert_generic(struct __sk_buff *ctx)
>>  {
>>         u8 *data_end =3D (void *)(long)ctx->data_end;
>> diff --git a/tools/testing/selftests/bpf/progs/rbtree_fail.c b/tools/tes=
ting/selftests/bpf/progs/rbtree_fail.c
>> index 3fecf1c6dfe5..8399304eca72 100644
>> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
>> @@ -29,7 +29,7 @@ static bool less(struct bpf_rb_node *a, const struct b=
pf_rb_node *b)
>>  }
>>
>>  SEC("?tc")
>> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root=
")
>> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf_r=
b_root")
>>  long rbtree_api_nolock_add(void *ctx)
>>  {
>>         struct node_data *n;
>> @@ -43,7 +43,7 @@ long rbtree_api_nolock_add(void *ctx)
>>  }
>>
>>  SEC("?tc")
>> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root=
")
>> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf_r=
b_root")
>>  long rbtree_api_nolock_remove(void *ctx)
>>  {
>>         struct node_data *n;
>> @@ -61,7 +61,7 @@ long rbtree_api_nolock_remove(void *ctx)
>>  }
>>
>>  SEC("?tc")
>> -__failure __msg("bpf_spin_lock at off=3D16 must be held for bpf_rb_root=
")
>> +__failure __regex("bpf_spin_lock at off=3D[0-9]+ must be held for bpf_r=
b_root")
>>  long rbtree_api_nolock_first(void *ctx)
>>  {
>>         bpf_rbtree_first(&groot);
>> @@ -105,7 +105,7 @@ long rbtree_api_remove_unadded_node(void *ctx)
>>  }
>>
>>  SEC("?tc")
>> -__failure __msg("Unreleased reference id=3D3 alloc_insn=3D10")
>> +__failure __regex("Unreleased reference id=3D3 alloc_insn=3D[0-9]+")
>
> this test definitely should have been written in BPF assembly if we
> care to check alloc_insn... Otherwise we just care that there is
> "Unreleased reference" message, we should match on that without
> hard-coding id and alloc_insn?
I agree. Unfortunately I see a lot of tests that fall in this category.
I must admit, most of the time I do not know what is the proper approach
to correct it.

Also found some tests that made expectations on .bss section data
layout, expeting a particular variable order.
For example in prog_tests/core_reloc.c, when it maps .bss and assigns it
to data.
GCC will allocate variables in a different order then clang and when
comparing content is not where comparisson is expecting.

Some other test, would expect that struct fields would be in some
particular order, while GCC decides it would benefit from reordering
struct fields. For passing those tests I need to disable GCC
optimization that would make this reordering.
However reordering of the struct fields is a perfectly valid
optimization. Maybe disabling for this tests is acceptable, but in any
case the test itself is prune for any future optimizations that can be
added to GCC or CLANG.
This happened in progs/test_core_autosize.c for example.

Anyway, just a couple of examples of tests that were made very tight to
compiler.

>
>>  long rbtree_api_remove_no_drop(void *ctx)
>>  {
>>         struct bpf_rb_node *res;
>> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/=
tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
>> index 1553b9c16aa7..f8d4b7cfcd68 100644
>> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
>> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
>> @@ -32,7 +32,7 @@ static bool less(struct bpf_rb_node *a, const struct b=
pf_rb_node *b)
>>  }
>>
>>  SEC("?tc")
>> -__failure __msg("Unreleased reference id=3D4 alloc_insn=3D21")
>> +__failure __regex("Unreleased reference id=3D4 alloc_insn=3D[0-9]+")
>
> same, relying on ID and alloc_insns in tests written in C is super fragil=
e.
>
>>  long rbtree_refcounted_node_ref_escapes(void *ctx)
>>  {
>>         struct node_acquire *n, *m;
>> @@ -73,7 +73,7 @@ long refcount_acquire_maybe_null(void *ctx)
>>  }
>>
>>  SEC("?tc")
>> -__failure __msg("Unreleased reference id=3D3 alloc_insn=3D9")
>> +__failure __regex("Unreleased reference id=3D3 alloc_insn=3D[0-9]+")
>>  long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)
>
> ditto
>
>>  {
>>         struct node_acquire *n, *m;
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/t=
esting/selftests/bpf/progs/verifier_sock.c
>> index ee76b51005ab..450b57933c79 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_sock.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
>> @@ -799,7 +799,7 @@ l0_%=3D:      r0 =3D *(u32*)(r0 + %[bpf_xdp_sock_que=
ue_id]);    \
>>
>>  SEC("sk_skb")
>>  __description("bpf_map_lookup_elem(sockmap, &key)")
>> -__failure __msg("Unreleased reference id=3D2 alloc_insn=3D6")
>> +__failure __regex("Unreleased reference id=3D2 alloc_insn=3D[0-9]+")
>
> same here and below
>
>
>>  __naked void map_lookup_elem_sockmap_key(void)
>>  {
>>         asm volatile ("                                 \
>> @@ -819,7 +819,7 @@ __naked void map_lookup_elem_sockmap_key(void)
>>
>>  SEC("sk_skb")
>>  __description("bpf_map_lookup_elem(sockhash, &key)")
>> -__failure __msg("Unreleased reference id=3D2 alloc_insn=3D6")
>> +__failure __regex("Unreleased reference id=3D2 alloc_insn=3D[0-9]+")
>>  __naked void map_lookup_elem_sockhash_key(void)
>>  {
>>         asm volatile ("                                 \
>> --
>> 2.39.2
>>

