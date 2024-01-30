Return-Path: <bpf+bounces-20702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6601084233E
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 12:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94E31F2AF94
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 11:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8EC67736;
	Tue, 30 Jan 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i3q2qrTn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wHEREuhr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E067727
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614599; cv=fail; b=VcevbdlxLKXLlNEjKQNQBl+QZPOXgQ/EC/ISu8GYXyR0gdlQ7ZbKkG0rDy2Knc+r4PjK9RNVvUcx27zeiMnGzcTP1ZC/THcQa/Dm9ZF4glDjy51lu4xtm0YwWJCAe6spvH8gPdrkNA1Yt9foorhzOApGOjcODcSJ3gELyS6dJT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614599; c=relaxed/simple;
	bh=wGgZth6srd7wcq2HA800vod2F2NZj6eIHbWjbpk3dwM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QVravhPhrb9gAsBWzkhAlJb6Uac1jg2K4zbJ5JwueBY43Tj1CMO2UANuYBjzZHptGLeIJeQXt3fr2+fRwGAasrmw42qGZG/gJ/veZR0r8DqK8d4PvnLfKSUHzREo23ejyvkTOvXmL/o9zwGHjbgAVaQfziKXAXcGkPtk58bJk0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i3q2qrTn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wHEREuhr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40U9428V013178;
	Tue, 30 Jan 2024 11:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=kSITDLoit8Ka95mpsqAfGKZYvqoHEhn7IUKknkOpIa0=;
 b=i3q2qrTn2W39igy9x/LuRkkZ8FsBfYiIvYexq+KdrOEOcxllG1I0U3z7fn98bN5jmkRs
 hHWJqeJvNLKECdNZKRkOu74ncTWmpQPZUGaDptJqRFLYYLXnB7UpSJLJ4yOSL5lV7l66
 kjT3N2aMRmUnFoZwDaAOg5vVTL/OKuZmJ09TyNLgByd6sehuzXy9E1+swtYleEVlkpNA
 frcgD376m0WplbiNF9I1NK3uMCkh2TuDkp06MmVMg2EaXYUb4dMWUHlNhee/jg2+U8od
 RKJLVTnLysA3UMvfQ5Uf0gf46PHAyyvgHnwQnn7bvtCuEKITRJB0oT6wJjogUJmUYBfM nA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdpg0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 11:36:34 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UAUTu9031408;
	Tue, 30 Jan 2024 11:36:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9788hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 11:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOq74he4py5N7NTa7j1CXBEdxSuZs+sZ26KhTozFuaWsW6hTG5sHQaTmP/1voR6I0sLTe6JOaaD/HrzY7t4yFW0B+qCgXE2Brv2iUiXujolH8eNgGlzjG1z72HA5DfilWHV8z36sEzbi9Axb1VHWXwnVby2hrkWSoUWs0i2TgraT7H4gdffjf3eC9WHbkePzODwkMGLz3Kk1YxjUmieK3AFc3VT3+oQvg8iyBCOugaJWwqk6PK1GLjLoUoyiG506PFsbkkWwlK8hp+twTWXSBoczEqh1EiJo/lUzzYvZzkrRxGBVwwJEQxC5GiOEi1JmtshmPkF1oiS4S8mL02c/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSITDLoit8Ka95mpsqAfGKZYvqoHEhn7IUKknkOpIa0=;
 b=jCbIta0tuAEgbwjBBCUhVQFbFSAS8hAsJ/lWhUoZCl6d7GvRAfQ5xiCRqWSAISNN7wiKZDucrxRVURThlBeqy1r4OswAK1V7Lmdht02v8z9RwCR00VN6P4+lkT3XHQZloniFyL8qHoICF8N6IGnpJEUw9nO+im9Poi7YufBfL6bLhqw2AbPJTYIdQ3C13IxoLbrxWJdVJAQP9SZLB82IzsIk4Xd70oR4ndeL3m9Bdve0EPL+DgwQUMjgKzqRjPfDyXLmWcSN++if1uZv1fvwlPS7+/Dce3Q/OUNZoK3yNelt5p/TRj24bJjzjc6Gz3qUU3INCtXD6vv5HNvCPTUxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSITDLoit8Ka95mpsqAfGKZYvqoHEhn7IUKknkOpIa0=;
 b=wHEREuhrK7vAIwXl0euqng4wP5j3O8ZU6A0aYzV5pFf0fT4xVnTSlRB7WtXAalaSX4kBu14VAaT0U7QEtR5DfnTU0CTxtd5NEAEXqY8LAu+s0QRwL2iGwEhQ55/jjzJ/59DIOKYfNGcTKC6NCVA8L2vUxcFq2m4VDCRPhFA02Tw=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BY5PR10MB4291.namprd10.prod.outlook.com (2603:10b6:a03:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 11:36:30 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:36:30 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next] bpf: move -Wno-compare-distinct-pointer-types to BPF_CFLAGS
Date: Tue, 30 Jan 2024 12:36:24 +0100
Message-Id: <20240130113624.24940-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0012.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::25) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BY5PR10MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 1825cdca-f7f9-4594-6fae-08dc2187b3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6cHvqM1eh2RRyPFn3QiQpHoileh+03UorAHRU5dCTUlC4EbthilyWOUXHk/Cux/gYQpB9+GtqaSaahuVQBMzIJXz315pw6sA7XVk1m9ZiYfXALsQfKRzjDlZXBXi0ddXtlW7+Rxp3vwo1pl0xgCtYQXsrpUG+T7hkUIk3J40o4KdojCITwwPkWt/E8VqXENgluUpjvMDN26MjhqoHCI5ENoqwpHe987UWV8TIQ2MpfwKFPOiK+tQZ+hSCIAYWX5u4kNWansgFzpXJCDqbOST+JqW4MjY1kDlB2cqnsWxsEo0IquZcl2hE6t+xybrzdkQO/fQQ1F6f+RaJZUv8JA9jdxORgXMvEmcNiL4DzMmceoeZKW8YXrmy3Mfl+FAfNA304XsoVuIHYqjoXZsnS90NlnnlUPhnU5j/OXsepC4boiRL/DenDUH3rzwvCEseRaMvJ49IhBiZKNW6Adt5Eh1w17AECJ+9Ac/8pDShwEVyDK3uXro6wJo7UOrkMRQHZtZw0tZgmxKKswa33nGydqJBlPZVP8bMCFHA94A+guSzwH1klXQuKzn0ulldMBS8omwSqINJIXhF5uAJoOrJdzhDMtdaPb0xiQrzTDulDucrrPJ7wAul9LcQl6jJsTXTec9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(316002)(6916009)(54906003)(6666004)(66946007)(6486002)(83380400001)(86362001)(66556008)(66476007)(966005)(478600001)(38100700002)(8676002)(1076003)(26005)(107886003)(8936002)(6506007)(2616005)(4326008)(6512007)(5660300002)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w3gdrlMwCoj08rhczMnU/Cn+91z4LQ8fAxnP/whCBfnlDIvaDTq5XSrJ4Gtn?=
 =?us-ascii?Q?fg4TvffbHy1fza2FecBIf8eNx9k6AxXa92aWsn7DOmm5s0XxNcLm0uMFaBpC?=
 =?us-ascii?Q?LYgqcuMu+riKXb0PwjGk2JC8I5cjjiiGpvJtJjN8ZZAWmUyc1VVvHJYmJuPw?=
 =?us-ascii?Q?RoTwhLUPh+isLCoSiEiWjGwAI1URq61HMRPX4l88Ykla6fucyxjdQ7WgzStR?=
 =?us-ascii?Q?HsHsHF+wp2DsZadFAuPzyWpKVds4ih43TLNQsBqFpFn18jePh+kEtJtNrYl1?=
 =?us-ascii?Q?S7cB/BBjIzK/y8X8H7K2pqqPTFlc4f1tZm4mY1NkcaWJXn3CXWzJNk97a0A+?=
 =?us-ascii?Q?KYQ0Spyb4scG4VjI9lP9cGv4pdC6jOkkVCwdza+zPGTYIzmX8IPdHo53lXXG?=
 =?us-ascii?Q?TOw6i/1UYBNtghuR39ePx0oMYrf0J36259mjFhYGF0Tpn6R+Q5Zgj1dqiFv6?=
 =?us-ascii?Q?baK17RISk/JIH1SUO8ZdFQl4Jy5Dbieuc46ZJes0WiQjIy0gxDD2nUgHajn0?=
 =?us-ascii?Q?NVdgyzSOXvp8WjWm2P3gqWAVUd1lTeVlThemDEKCkVOgR5I01cd0A9Tzidip?=
 =?us-ascii?Q?fLoFsC79tk29Da6XgyXYNwAlV5rmcMDMAiHs1xG1FSoygifLhnrGiDFrJdYN?=
 =?us-ascii?Q?YhGRf2HampAI3+LpWnJ/JiDFaHxTuelqhBrs+0X5+l0W5/LR/+pwZ5mXcRYD?=
 =?us-ascii?Q?sMiBSukxNtk6vKpRiQflEuXfMABEjeIP+AoPkWgwkYicEGi2ZoIsWjM+FhbS?=
 =?us-ascii?Q?tN9FXGjAQAqsPB1p+RBbVtOmkI2PZNomPt7pbsolDmJBN7lHIBiim2FmN1Nl?=
 =?us-ascii?Q?dYnJ1qxYvFKU5m+W84KGg6b5q5ifVZdyZHZGb1VdCk3W+5jtoZBOP+k7y17h?=
 =?us-ascii?Q?wPm0iF4mlg3gZidon9nwWnGvAhxoBJ0ZSstKo8qRsr0ee/K82YGJvfYURQ5x?=
 =?us-ascii?Q?Fg4lkHvGct4VuCwBiVFf1U403eFvJfLcwpfv9G4Q2s4Rzx/zYmLn3g4DdEy3?=
 =?us-ascii?Q?bkk7qfHrcCe4VKl+JQz8IQbhompDzNYmPE5ctoz69xWkgdRECvmLgodJqige?=
 =?us-ascii?Q?IlM77DttuJUR/Xfm4tt80SByoWB8GOTVWsuvgMHrBgOtWG51HveHP6i3+FOr?=
 =?us-ascii?Q?FZCWrROKalukknVWeCDXwGOgEssdomNycGaRgGq3szqBLOgjfRznBouuNFjX?=
 =?us-ascii?Q?800xGvHcV4UHTpmsBHZ5I5ih6RYULxRJ+Lw2SpN/ZS/kCzJ5XXCom/R2esaT?=
 =?us-ascii?Q?jmewXjyPpXIgMZjFfCQb2qhrBRRsFLqTnb4tQyjORBhywBz1D3mCoWmcGQml?=
 =?us-ascii?Q?NNBdkPINP9MVPrLR/B+gd235aTFR4N19juNsmnT+X06ByWwkPuOQNpD6C/sF?=
 =?us-ascii?Q?f1CwVRA39mYbuzHMMYkyUyhUAxY0lwWRBqqA9F8bra0RG1h/v12uuRozRD8d?=
 =?us-ascii?Q?leVlfrl/EOG/eKk51JdG1heFFg3kCzdkB9hxeJYT7QUuohBLLmmM24I+gS/s?=
 =?us-ascii?Q?yFYxemEO42pSaSJ5b40bSwgsbYb7HuH2P1eQm3Enr/4zcfF6JmiuQ4URXuYN?=
 =?us-ascii?Q?TNnwODjEE8k+Grq1xkDX0E6wmilv0n2JYgh8OJrNXrpJiDavbOgzXVn/EwXy?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gY/DvYyNm1g3ai/hH602aYgp1PmfArztF0XFQNnM9lpHqENyMdl5rZgo93k5u3ga8wJKVZtKNu3RkoTjJrD9JJkEWG0XGfRvYHBmLJZr4BrPJEG3dL/jJH+RJN4ltf2ekZCAbOzzw11hk2BI/FE5FUHFhqj5JeA4zHijjd8w7prIo//ph4GxV3ZVBj35efHb+FSejaVVzvRarfzQayLgNulgckqCgTw3NZWEnt3CQm7AE1SJWBUdVcmVrS2todbaYgX2ejUwuBg0eNH5lMUYUfEweqNfhIOIP4UGkCPwmm9dxV0l6hHyNPQ0c1xUvAdmuU8xBkGqNiuWnAn9UapMgOIgEQuq03yv+bNhVBr/ny0ylhmIsQo7GfUCa1Pem4SfzagM2PFYtIuIEsz/z3O7rcPSzkNbViEIrY3ESy0qWiAOn6CAfNYunZIfn5BLCEtIctsoJi/HCopzkkmHQQy+nWAtVDm/DP/6OFnhbkxFU/ARYuaHbd/GHyrvWX/d3YGwHbuAKsAZMPLyj47PrgmYwwxsjtJ5S2R4QxCZ87RgB1UWBKJ90EJb8FnPO/iZv9RpN36zwi5ln/p3UXPA7Xj/LMZWNE7qSqqeoGrjC3TKqcc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1825cdca-f7f9-4594-6fae-08dc2187b3c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:36:30.2142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYSHQcVPMhqXP3DLEXKwb9NgH1wXF1qS3wklQX33JOCPIpGW6UeHCel+DIBTChznFHI5mr6VKFr1NDLh/IqZSE1vbZPzulbZIeCMqEM+pBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4291
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300084
X-Proofpoint-ORIG-GUID: imPygTnBKHNyTiXy7I26DNJmds4yBqQs
X-Proofpoint-GUID: imPygTnBKHNyTiXy7I26DNJmds4yBqQs

Clang supports enabling/disabling certain conversion diagnostics via
the -W[no-]compare-distinct-pointer-types command line options.
Disabling this warning is required by some BPF selftests due to
-Werror.  Until very recently GCC would emit these warnings
unconditionally, which was a problem for gcc-bpf, but we added support
for the command-line options to GCC upstream [1].

This patch moves the -Wno-cmopare-distinct-pointer-types from
CLANG_CFLAGS to BPF_CFLAGS in selftests/bpf/Makefile so the option is
also used in gcc-bpf builds, not just in clang builds.

Tested in bpf-next master.
No regressions.

[1] https://gcc.gnu.org/pipermail/gcc-patches/2023-August/627769.html

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
---
 tools/testing/selftests/bpf/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1a3654bcb5dd..f9f7d24e6d77 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -391,11 +391,11 @@ endif
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 BPF_CFLAGS = -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)	\
 	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
-	     -I$(abspath $(OUTPUT)/../usr/include)
+	     -I$(abspath $(OUTPUT)/../usr/include)			\
+	     -Wno-compare-distinct-pointer-types
 # TODO: enable me -Wsign-compare
 
-CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
-	       -Wno-compare-distinct-pointer-types
+CLANG_CFLAGS = $(CLANG_SYS_INCLUDES)
 
 $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS += -fno-inline
 $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS += -fno-inline
-- 
2.30.2


