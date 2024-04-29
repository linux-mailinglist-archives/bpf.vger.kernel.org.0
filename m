Return-Path: <bpf+bounces-28169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEAA8B6484
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10C11C215C3
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F78184104;
	Mon, 29 Apr 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F7s+eZM/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BAUPfpTM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE91836EF
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425824; cv=fail; b=tSgLW0ihXDBWKBBUtuLE+iVtRHb05uBdH89SsAVOiLPjS/7Jcc7saTaZIZ9Ekc+2uvrTmIPchlyvJoTko4OfBWWB228O0uQ5Yq3GNLn1jCzmunzojgOFsU5sjmEVhG7OCYI1/KyG8FT+ecwSm5C5bxWMHALaMnpIuGISIw8RxKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425824; c=relaxed/simple;
	bh=i8S/+wrErany3wbZTX14ooLr381ax0IlqpQ0kBXQJww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxqFoCuzIOIHpNSjipagrrhzxHq4qt3+WjynkV/9aQ/bwk8ZyXz+oLik9+b882sp/ENpt3Dfiho1dXHNsXh0okk7G2crupbt3w0JXkBwvHkvU95s9lNE4LltZCSEovwhhh0x0Is7TXRuIvnVCWJA48Nr25q+cnmIhEw3bVZZ2Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F7s+eZM/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BAUPfpTM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TKFmgE005279;
	Mon, 29 Apr 2024 21:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Kiy1j7ZxtprfAnIbOIFVcUwqUiROQa96z0TzvqUhSvs=;
 b=F7s+eZM/HQHOxSP9fHLbO0sHlDGMdRlPG1Pakdha/ujuVOma/9p6nUG1AyyT3mAh9aZL
 pb/fEA0AAUMQMFojL1kgulJDUSpHE27stG9eQHmuXMswgq24iLQqDmLiCVXmBndiPnHt
 HTv7Y0UsuC7wWJuwws5MP5cO9rqCHk3YD6Cc8nUAv/RfR8XyjM/bZD9H8t/jzZmnGuQz
 AfpiSqqjGw9E/zloPjG6ZT/4IJx8CkdhEHWQPcuSkQ4gJTwVsdVcEwDGYdVGH66BJzXn
 TRRXG0tptCW5yvLkNHfEf12L/SX8mxhzP6uhV+53J5SVwUCSLmauFy1sVnOw6Oz3mIsy Sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrswvkpd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TK84Ao008598;
	Mon, 29 Apr 2024 21:23:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6wbww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 21:23:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPj6aFUqOjgyt6awPBhGMPigLxTsPLjVJvRVxDP0PMgnAdW+1/TVbD5u8J03M7AUsvO/dPH9++edCHYrOOJ4Xd987JNBXkwaq8RNEukgvrqRfL9Ff+sOpHH+l4FIim0yWNdM68E8tfmouVx773JwhOVyRAhNXI8pVQtYF3B3ofiHPSd+5aH5/dVVCi0snH5OWSkJ/BFzFfpcRLZeWXy+gSqCijceTc7mcVfstIF4VfiXCAHcwsh9oa+/ptOxtOV+cL75/XxHQoHzuWIYK79pC1aUhJKzQp/uQFv10ieKs53PE6vyREOUFciEZSgC4Fdxg4gKzcIbnvAN13Psp8sS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kiy1j7ZxtprfAnIbOIFVcUwqUiROQa96z0TzvqUhSvs=;
 b=bQ30AwmKlinJ7lVaAq3rK9hHjz89MFdFjNY+7tenRP8VPQl6643kpAmogQPVeSI8KMo/PjeBs3gBSMabq4AnHR487rkXIX6Rtdh0hTpP4q6SevHeFh0Nyx3h8DFOX4PnRZtWMWAHQqxk67lGD7a/qGN4l9BxfzbDjCIS9TeSy59kRuvvkhvV02xRGgGN4aCdCesQJ3VMpeA9YsFfJPiIQ9+NGhhElyganzUNjcFnwoGUNwMazyWTqoGBJrLJyjRz2kyTW6XcStumXpXaLqj+uggKLYT9SWrPsfWeSaLCuYGt0rTAvFQR7VQQj/UgSx6UWgb22JoCFnWvhEyFkFkLVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kiy1j7ZxtprfAnIbOIFVcUwqUiROQa96z0TzvqUhSvs=;
 b=BAUPfpTMOmO24gmknvrPXNSx6g20ctGWkSTk63CI8ZDQ6mtesXazzb1g9xXPMoIJrGluvl92OhJg9UhRUB1NrgDaOys2g0Bhrwtj2/ab+qY1MFr6jVZn2zNrVEJHbB1j8cEaktFY2BYjVkdiRMfxqUTeVjd/bW9U0juVB3ePxP4=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 21:23:35 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.030; Mon, 29 Apr 2024
 21:23:35 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v4 3/7] bpf/verifier: improve XOR and OR range computation
Date: Mon, 29 Apr 2024 22:22:46 +0100
Message-Id: <20240429212250.78420-4-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240429212250.78420-1-cupertino.miranda@oracle.com>
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:205::23)
 To MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd4b8f8-d1c7-4414-b269-08dc6892a096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/wY7MPCuQxcQnPtOXJkbaB2dzPbYOTV7Qka8kyYM+bX1swAaUdPaBa9z2UyK?=
 =?us-ascii?Q?YWaag5IEt9sB0znY7xDQSycotP5IqGqsIFgD+nKOUYAlqAoIReX0cU1+9kA3?=
 =?us-ascii?Q?0uMe/CuhuUVw41krQyCLFr+OInC/KgDk627h/ARuFRtA8Khd5t8XtxwqhWGm?=
 =?us-ascii?Q?iQsv7K9U8ka1K3+090AwcR6C8DJ2rzemuEYXrb6oupW1XZC3o1ziwVXioB6Y?=
 =?us-ascii?Q?3MXG9n3iBYmmS/dBYcTCUNVsrGP4Q3UBN1piRzWUnFxEZj73Y5l4kTB2s6Zn?=
 =?us-ascii?Q?qs9r2sUj45M7diWuLLJnJDpSk26UOC0HJFOSbJd3t8G7VzjYVafV75Az1em8?=
 =?us-ascii?Q?3w3VzXaScNt4xYu2AculGQblpVjsVSbxdLILu25xs+B1xOdrtiJUK1MKCZFb?=
 =?us-ascii?Q?K8OLH9K7/YnQkx8X90TpqqmBz9YjYFOEZIpjzBnfd3c7onqNgbiQURTZWlWS?=
 =?us-ascii?Q?jVdUzYtMYoJPNvoksqeesitxYsCmoYPsoixx2npAmXKeqrIwWwpGJp/SxCO6?=
 =?us-ascii?Q?qxyn1JaALi+QV55hWXKrZyqtJVnvTZFer3CgCjDZc5d7lhVPvYl6uWxkHgv4?=
 =?us-ascii?Q?PvH+TPbP0Ar4UJ6y97S69i6UCC9lZg9XqBF73K5coyFXSqtPj8WsUz8dfHAZ?=
 =?us-ascii?Q?Nlyt1ui62B6zxnuxP1AF87v5ta4EctlrNSssFbuXOJamZ/5irnlsjHKrgi6q?=
 =?us-ascii?Q?Yk6gCMANBVOBQTW3oPZkeK0qaEl0U+9xv4mFNhFTTMIW3W0ZBEq96PkS43ch?=
 =?us-ascii?Q?FXvUdR0C9R9ym/SvPHDgM5gOsJdYhdiGE5OaDVEYfjGZzI5qpLwkniOaiRYs?=
 =?us-ascii?Q?qxHkQFHKr94Y+ZgkWwTYbhmTHmyhNUVZXK2g8jlo/QC39GGuwEij9aHl5Y71?=
 =?us-ascii?Q?adked5HGEbBSvL4YpTM0ox6YZsJieiIEqX8rSOVd5kJgdXVcoZZZPxfyHN/y?=
 =?us-ascii?Q?w3LFTdJ8e/PgtmQ7E/Xpob9qM49KYmpnkGvnrAFpKNU5UdreYn8JXDzD/H1y?=
 =?us-ascii?Q?0ls432+xpGq5n9gR5LCNBjSiwqTyzkjYqYnQ/1ZWKCsxrXvsrx6jy3HB7IBG?=
 =?us-ascii?Q?qAKhwxjyax2m1QXqFCHy0w5B93m3EEzhqByS+KqxBn5PrEXlOZOwFyKgG2YE?=
 =?us-ascii?Q?CaQlZ5snm/h8SypP7MxoUw+63tHCMJIcHW9LeSdDhDwsaGPf//0+6qis/8xl?=
 =?us-ascii?Q?Rj//R5rMI51kNV05cUWs3wrbM1hNemfUkelzblS+PkpBKVKNbw6bmyJXyEfm?=
 =?us-ascii?Q?u2V8nGPKjBplLip/pbgw362exqxgjoz55IKxjAj4Xw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?++pfixPidk1e5p+569QdnYTFfnY96vIsqLdpc1C0NCpo4K6kGzWsoxuiX31h?=
 =?us-ascii?Q?chOCdkP8gux9OiWzpIKhkaiWsQqgW7BsVzvtTkgugHEuU3X6dnIlZ3xxvFWd?=
 =?us-ascii?Q?fxGvs0bqUfsz1Ve1rETFuneMHjYqHgKbktT+txdGHqlKMotj4J8WKsnhMdHG?=
 =?us-ascii?Q?4ByuEjviiucBeqjlXCv8GUFIzOkuVXMYJC3kAgNgkFIDsk8RmGcgrMYqeowg?=
 =?us-ascii?Q?N3Ze6q97dbmTSKiEBIzDi6puj1UJHw8LEkmHATCjAs2tBpvLtAzOjn+zfLS+?=
 =?us-ascii?Q?0G4Vgo3lSvHPSAjDNcmcAAZg9kiHuq4v4VuVQCbLtZCAoj46iqt2w0rcJ85/?=
 =?us-ascii?Q?M/Si/WqwZBN0w3ITmpgmLYFmvRsefbSwmD0wpBrwhdzwcN7b1C+b7f7FH4Gf?=
 =?us-ascii?Q?ds+/VwyLDXk85BSTRo6kbJ8fd8aENM14jh4uB//jn1FpBu6KCgQHZ0jN1JNs?=
 =?us-ascii?Q?IKyZUGJyZBGzPu/omVhjjVNZCrCkKt7ANdsPyqSmhnqIN1Tmj1AlJSiUGsrJ?=
 =?us-ascii?Q?SYP5uypHB/0D0YhgqfaqYpnulDGkco08aew/tUZHT2MkdllhFemB07weURNO?=
 =?us-ascii?Q?YyWOGuCHcx9eaQ314oSfzwMvhSlG2205LHvND+xRSGmZLAgRTzv2rTsurGdh?=
 =?us-ascii?Q?8O42V2HMvWHnNLG57w1zA/Wkd+4CwyTNx3wZvQq3lMoIkWzqvC983ZIctv0+?=
 =?us-ascii?Q?BhpQIPr4bL6xHFTj2308KBVqmsEzvuJh8QSh+xcfjTcWxtT4JBCf3al3oyGu?=
 =?us-ascii?Q?dMhn9LYKQs2WRStIkjoY+ESnS91DWjQNFztb5boXMH0QSLcNm+QWRTJPVfIH?=
 =?us-ascii?Q?1MzyKFbda19pIb6UO/owRmKslu7WAiiePbkcs78GDBC2qpm+KUB/a25duCex?=
 =?us-ascii?Q?HDPjWz5QfnLfgzeZu5UddFL1aeyhu68lTsWoDzIANBl/S8ookzL/36wn8+om?=
 =?us-ascii?Q?dwwD6hO4HhcXaxcBoAatnAsQlesHDQ+rZHPvyoya21lR93gdh2/Os6YNlUg+?=
 =?us-ascii?Q?ZRnyejSO+9/5dRnN7sLi2Osmo/fSFmMnZ82YWyQIWqZOWLWLbjZxP6jHG64y?=
 =?us-ascii?Q?gpYvQacCziD//MrAPNRCNquTjLXDaHnEMquqIofR3URQeGNymu5GDC5u5ogs?=
 =?us-ascii?Q?pzXxqoRsVR/uy/P6btV2+6MELtUmL+7caL1u7lRlB5lD6ejLru0r7W4q26h4?=
 =?us-ascii?Q?Zj0TxySgV9eRzu6uT+LWR1pfggprhjYT3WtPTpQswdaeqim/bNhC07dh5+Mw?=
 =?us-ascii?Q?ss1RTetgePL0FmE6ZIVRxa2/yeQ/RgJQq23kYyulkxBMbXOe+tR5XMl9oR+m?=
 =?us-ascii?Q?LzAGl3/7RjyZB8BtptaLfj4fjMC3UERb1jeQ0IVAc5zvAgez6ueat0jTshb2?=
 =?us-ascii?Q?JpOi3Bzvmx54fDwktYu16w6XynyI+wpVOKzjm2VVUBRZ1h7XOCcevSFi6jEB?=
 =?us-ascii?Q?NPhhTqL6bNqS25+NT7uDbYVC+dUzl6rlJCHCO7b+ZQbYz79a7yvGNYcQSoBJ?=
 =?us-ascii?Q?nbOU++PKE/PI4yEldmBFi9QFxzIF+dFblcoEOgzg/ocm9gFc8KMrwEwz6nz/?=
 =?us-ascii?Q?qjZpdQQ0mGJzAy6gvtppldq59C7mW/m+wUwSNmsZOxj5/+Gmt4kFL/mN3jcs?=
 =?us-ascii?Q?JSiLymvFWqtfxGTUWVXnuMs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	e96eJgBvAlt5pFcpdWpnHGS2wrmrEXi6vRhgD5L+jJdLBbrOnKCISm+HbuRfC1fXNoDMCAZeBM4kZ0M6+RzhQV2OhziUeV4ak57ZIgUvgfNkrABcaCZDs3WOM3I37Vr58hIWSNyJKU5PN5zj48i7wmmxJiwMpZRzSDzW4Zt72LPqu5hBkOg4xAtiNaZbE3G8iuWf+fuxulyL3zfHUr17s7sZjET9DdadWh+5etwyYaLSfuWByluQEJPzuhWXwjthe4GpKdPsmnZM0EG0bQWcaxhs7ai3HqeW7Xv8A48OPtiYu1sIjsu3JUnXOygvssBAI3LNk8Os28wiBpEI9x151HgMZBAVSkQjMJOSlOlgJ0a7LQbxlovYDWAW+odb8wWfIa6UQFZbLzLQD5rNFw1HIugMqonLntI/bgGZ6ExfSL+y2gKbuhMg5XY2Svn3hM05VxZGlp3Ws+tu952+HSX0ETqU8wJI4Zhw+Vt759xCrHBDNzy6Tv4mgP01L7wpQ691ftsq4Z8C7Q5adB19tT0yuokhJCBGzB56BPSdjoycQ1xfCWAooHChL1pULFeEtOLVT+Ylo8ZvhloSzGlYFjb3Abr54fBoxBsphworuMEFQfU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd4b8f8-d1c7-4414-b269-08dc6892a096
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:23:35.0168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVypPe1FqYvoJRgHPg88QTeYMbJcYO9YQFgrn0aeRNpteGvKf/Y/uEg2g4tOZqFU+uyP2tkCR+GL5o7fIHYs4lYHMjiRmKUX4QzP/XAEgjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_18,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290141
X-Proofpoint-GUID: dozftlAR2o2G6nlv7DRn9NXqoqkOYmwr
X-Proofpoint-ORIG-GUID: dozftlAR2o2G6nlv7DRn9NXqoqkOYmwr

Range for XOR and OR operators would not be attempted unless src_reg
would resolve to a single value, i.e. a known constant value.
This condition is unnecessary, and the following XOR/OR operator
handling could compute a possible better range.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1777ab00068b..54aca9b377a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13744,12 +13744,12 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_ADD:
 	case BPF_SUB:
 	case BPF_AND:
+	case BPF_XOR:
+	case BPF_OR:
 		return true;
 
 	/* Compute range for the following only if the src_reg is const.
 	 */
-	case BPF_XOR:
-	case BPF_OR:
 	case BPF_MUL:
 		return src_is_const;
 
-- 
2.39.2


