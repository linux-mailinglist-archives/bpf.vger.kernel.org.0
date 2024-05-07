Return-Path: <bpf+bounces-28945-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4238BEC78
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 21:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39AE1C24BCD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B105416E861;
	Tue,  7 May 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZrGgpfal";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ET/BRE9F"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574C16DEAA
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715109527; cv=fail; b=gRif/jCoOAVgzP+hEOqvF921UChe3vT8hGCtOFxOPAuEJvV+wnnbCzILTSbq3JWAZHEaUrByhEYsSjBZWQwZDI5WiknXBb28iLK5sk3S2f4NZy1SgV903e47HBVr1iqVy7HBvMWJ6UWKsL4RJYLk0u52/lK3BDSRX+tCrLyIZLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715109527; c=relaxed/simple;
	bh=w7PqGch6ay52Aano4vS3Balm4tWvQWlLQd6t3ZK2aGI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=qXy/YPMX9v0JbkFiXkPvkL0bHwjS0B3fV+S7Q0B2zsO5CxEaIWMI7HvJ2AEtHg2f0sphZDrTRo0K/OzDp77dVl+VhE5PSrKohSQL582Y0x4nG5WCqe52pWwceU4FCmf5PwMa5bHfHi1zsd5cdcvYX0LdneMQSCDeOx1o56TQ4Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZrGgpfal; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ET/BRE9F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJwSS026143;
	Tue, 7 May 2024 19:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=y+e337yUUobA8BaocacjNfV5yzQGVI/v8svqrnHksVA=;
 b=ZrGgpfalX9zwJE1lhrQnb8dDnrsoCYtehjeX4SOkFpXnXRv3/VaPFnp+leo/9A/rdmza
 pkuPGg5LulC/DILJpJMDAqGlxJXncleYevajSydOXefoGUZckzj1CnuEfvJ6ZghDxYZv
 TFITNmlYmtNcA8/6DHjQ3MIPsn765pKllSy/BlHQq9XKnfUteQePlK+MHpmXHr4ezSxP
 At7kWFCOoczZFhLH9oMfautiiQFuTnAhO59eD3BbX9vcCVpKkoeGCiifnEfP3UkM43f7
 fcFHaGk4OsZbJ7UGAwjXiIgOdoaIbv3Kbm5aUa6TMr8XX/p0KuB5qewzpeXKGhzUezqm tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfvg4st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 19:18:41 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 447IJ1bZ030907;
	Tue, 7 May 2024 19:18:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfk2e1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 19:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRXwN2Kj/SQ3xFFbEi43RV1hax0ore20IkArKDJZMPGgD9bDLGIPY7uhLPyGCg5ITIewPwY90ja3mrKtaXMrwWV04qQulpPJWyEChAGGBanCjq909wnEpuRzvJG26nmk1PtMnYJayj98EtX58jKvvkjAnoH7e5uTlOHnamG5sAFgHtPYR4r2PO/pkk7bo+OO+ND4TJWkXMFeiujpDNUycNHhmXRt1H/3ANe0Lyo95TY/g2QMprH6xcD7JoeXhG2+VmTdLPAZRa83T8IyGfQWk+cIwuZ/p68sFf4tPjoVnyya9B35PNLu/3sWmpTG870zsiqowKceZ813/KwG2hUEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+e337yUUobA8BaocacjNfV5yzQGVI/v8svqrnHksVA=;
 b=GcqY0uU7GCAbEyin/8RAac+8tffRL9qzePCzX/mQIhE29tCg08TPYjgcg0MK2yNyJ46m/mgYEHcK5m/vGX+oXendvMmGtu92Ylc2j6N2Y+CM8ULol/+07i9MzoBtkUphPlaf/20bORUuTmU6ke43ckBjXSPQWrYSAsDxCsPsenTzcSwvgwo+xyidQoQg3tWlkc3hjjRx/DpzZYvyp0Z2S/uw/r9UWdJYxY8QeK8shGPpklNqvaervMk56LpESvkF/DC/fdrc8wymXAr8Xyn0B/v4JdF0KV5UzIUsJ1RsI99d1GJ6dQGREiivKzG/mf7uho39vw6IK3WI0BwDHEmr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+e337yUUobA8BaocacjNfV5yzQGVI/v8svqrnHksVA=;
 b=ET/BRE9F9ss8sIPInVRn01Ig9x87aYfz9/uJ/ZsUHmuJE16m11CG5eTI6bzIlH9WrCySu8cWWJwFxlYTwsC9YvZbfSw+uBFY4XBNEoL2d1QT+U+ADTqTaE//8JIHzCIQ1GRdhUEzE99PPEOczLp0kLEMDhsqwTQXXBtKSiU9kIo=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH0PR10MB4566.namprd10.prod.outlook.com (2603:10b6:510:36::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 19:18:37 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 19:18:37 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next V2] bpf: avoid UB in usages of the __imm_insn
 macro
In-Reply-To: <e76d3a47-fecf-4d2c-a417-9d1f5935df7a@linux.dev> (Yonghong Song's
	message of "Tue, 7 May 2024 11:54:20 -0700")
References: <20240507133147.24380-1-jose.marchesi@oracle.com>
	<e76d3a47-fecf-4d2c-a417-9d1f5935df7a@linux.dev>
Date: Tue, 07 May 2024 21:18:33 +0200
Message-ID: <87zft1bfcm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0315.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::9) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH0PR10MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f96cb22-93d2-425b-6554-08dc6eca7f2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?kRBcH/x30vziT0BRfhgkV8hdXJV8QpZHmmdbfFneMPYvKZ+CDin+jAaLRwgr?=
 =?us-ascii?Q?Kb8Z6ymEQJH7cB7ipVkWLtv7Zq9qCaZsnv+MUiEiTsvLVpzt2jdBxTcvEuf2?=
 =?us-ascii?Q?wKpzg59ZDMOMGZdZTYihuz9V867jVgI3w61yPA8K6HndUgS6me7r5g8Y2ZQO?=
 =?us-ascii?Q?PvwRlw7nxLq1+WPtdLVHubt5dZ+Hq0zUkxkKGayou7MzlZzPvTTg8JniuyWd?=
 =?us-ascii?Q?Ecyp/jepGZfGOX1NRkbcQ4ImG9lCKMId7DZhhb7r7rrFMC6SZjbrVGE5az9Q?=
 =?us-ascii?Q?aZDYsaZHtiVwsSeJZK2owH83OeGMqXEVvQwjU/0lQ1e+w7WgGdPCf3X+IuHT?=
 =?us-ascii?Q?eDOUfu7IK8QGFRHXSsF457gjakbP4rqGGKo5Dsub/SDbWdWrd11h6D99JYAp?=
 =?us-ascii?Q?qsemOBjLsAQFlArMzrnAwsTtEmAQC39CLRi9AkC3pNMUieVmaGQLE4urSLDC?=
 =?us-ascii?Q?bt2EzP3r6MchkY5sSpwE591puE9gCw1q/x4Xo7C2kCMlz8tgqu1BfZOSmxLm?=
 =?us-ascii?Q?ufn6qPj7Lm8LY/n2Fn20kiapL0vIq0cUnEc6yaMTm2AcTF0jy87nc3w+pO7b?=
 =?us-ascii?Q?8V66xtdhgqNNt4EWKpq971RV5tEgo72XFrh1/5XMkMUCb0xw82ifVmzjs+gj?=
 =?us-ascii?Q?Snhvkwxyx3KvZSh49qltqs+55y00WG+p+Qhx/Iq+OZLtKhsvaSqg9aammnPl?=
 =?us-ascii?Q?9bY9bRhOhgqvxotYMlRN0lEGlPHTskSuHo4nTaHiZwTMzCf1m8d5dWvb5MsE?=
 =?us-ascii?Q?GpSBZN+1pCXIKrcZL1hLDMrdfcH15ChgbGyQoQNYOz97lxezHMqHgMoh6jMi?=
 =?us-ascii?Q?A/QjJz0hk+LKW6tMog0JFFhq91cbdyiPNLx/lszAcicQkYACnSgpSDA7dhkx?=
 =?us-ascii?Q?Y6gIC4eYoVO6VfhNsFaHZu8J2C5BBqRYGDp4UwN6OSKOKaIxdCoqi3EMBurp?=
 =?us-ascii?Q?aY5vQ9eg3fzshSe1gcR59PACMuEn7Yt9oR24AA77C/dDikm/r2WcBRY0xAVi?=
 =?us-ascii?Q?c3Ayf1pblXx7CyNiQqW0/2ERuQ2TBJcH9juejk/5WNB/uAe1V/VXxO2EJrw8?=
 =?us-ascii?Q?vlvYkOAMcJwwH75eJXTFZw9XI2UsLiQtYQ7juFM3miKrCH1Yf4vWeyUW1ufC?=
 =?us-ascii?Q?AFn4pVXbCttPYiwG7NhqhHap+8ET5Jx9taPfEAKoIK0E3sqHjASfpO/EXD9G?=
 =?us-ascii?Q?aakuazxYwGHksIpojqCptrFn/2u226nTV8yzip7P+l6u0JUEt2iOTvLzoy4X?=
 =?us-ascii?Q?z6674Wqj6xyeSG93fqBTI6Gm4TFxWcDvayLQS9uBkA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ktREyS6RnjfXi9AMfthrg9jIlOeYztva+FHD5pKr/WtLMYgzJgWB5PeUsZvI?=
 =?us-ascii?Q?HkUMPSn9iYc3HUShjMEH46oi6ZihGC4d1zbkwQI+Vwyn2imd72E4ebaQrP9N?=
 =?us-ascii?Q?J5S3Dy8iIhBRmaVPw+VpyWgF6I9qPiBPLf3K6004MUCF1IaoHyGMRh7bVaiR?=
 =?us-ascii?Q?AX5MY5GURgMQxoYauwyUDOjb9DTnqTUBR8GcKxnJq4RXb6qbYDvaoa02jK/R?=
 =?us-ascii?Q?RmCccDj/VJoCVVOakkUbcRr3hG9/IOG++rIEzggLiOOA+5DbA/zXLLZplcAa?=
 =?us-ascii?Q?zZNIMjJ2ku9qxQBa3UaM+7UhCDjdgSllcU8duljtwJZnieYrwvUM4edP70dT?=
 =?us-ascii?Q?vYmp55U3JnClvpYax8tHjBDq6bcWr1nLWx2HOwQXMkIqktzu5zFy3obbvDsT?=
 =?us-ascii?Q?fHHeKaJcg2ei6krXTcXl86OUoA+PKdYpQ3LDUc+/6QSAl/wLiwqw40s/wOFM?=
 =?us-ascii?Q?y0s4tuY9Nv6iJEqDGoIzl0jWpjc1X3Z+e0yAcOljzg6BGOnCU634KaVeLxlA?=
 =?us-ascii?Q?d65BQ0yN3AinV6IR3VRJAm3BHud2Vumpe30s+1MNpVRE//gYtw3LZkwxiQgi?=
 =?us-ascii?Q?LhBe0Qmum0nd0DpsBdv275Uc3c32r/dmuzp5F21xPyvA43GQ4bJU4R6K8IgD?=
 =?us-ascii?Q?TNFhDPLFQwZCGo6IFsxeh4X9fbCgUn3HitL4tf/5+RhkFPoXy/InlZ/iBRAc?=
 =?us-ascii?Q?uOqLN34sDpReuFTCplixSyNNhU7MxV5iEl6rtfip8/v+D05AyfPl4169cuRG?=
 =?us-ascii?Q?CnDj8aRqrcc8GRnt6L4gFkTFp/3re1+9uOmnls65bTKUjmc/FWKjEW9/ipLD?=
 =?us-ascii?Q?IZeD+/MZtNqc0B6pffNylwsx9dZw2FErGA1Fa0nJl/eSUlgpkiylVvbc6mPn?=
 =?us-ascii?Q?VIvV2nKKiDQfe8H6pIHW2iSrSmJpdNJ0ZoKVut10QMLGu7faO/69ylpg8tVr?=
 =?us-ascii?Q?qHuRZKH+tSmgC8AYLti5RofSeA0OIYBNG8buFD0raW4tP1dKLIhBcH5iIsL/?=
 =?us-ascii?Q?8APYYhJE1fdzwM5e1e1oogVj2OEx+aHqLjKOPlkb2a4RF3ZbRcS+vXHLvb7t?=
 =?us-ascii?Q?jJn3Mk66bznu7QWknFPV/4Ow611IODPKYsJILCbY9jgqnM4AwMKtDCOcDiE7?=
 =?us-ascii?Q?/wYod01kYv68CFNnonp5vP0N1XMqDmXXCSt49zv9hdfh9i7M9PB6yynTiLO4?=
 =?us-ascii?Q?hHmtbqXZyuOW6RX9pd5dQNwtDRVP7NfV5SMnG3NEKaQGX8ygktvLgUNVxW8Z?=
 =?us-ascii?Q?sSH3nGECcH2KWJbLSCbYI8BovTyv5oXvUkanf0r80tKsup0jpOZ0avaYwxhS?=
 =?us-ascii?Q?XsAWcalIoxcOTBB8I0woOGjCSACUPujzDz8T/r/hm9906xEFreHYQ55Nyfix?=
 =?us-ascii?Q?IJoNVmeyHe05TjVxolLRoS/mARswPeJkZiW23jhBWrFxvkX7ZrGP1CiJlg86?=
 =?us-ascii?Q?bomtBUoI6MLV3oP8BZ6/DPiiFF7w2+hucZancQRVc6mIwBXJhVi1EauL2mSv?=
 =?us-ascii?Q?7NYB38NBj7TwRG6EESTn0utGENe2x+f2sxpwK3OMmdgA7m/ZLNS1XfW+XmY2?=
 =?us-ascii?Q?99K4JXRNgJJs+2LWvNAfDw77YsD59X2YJ03RDd3c5Ozcc6Fw6n3hDPKXOGpE?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	V0Z88JOnpEr9uhh8euxyZu/3/pfaIvRnOX6pCvdFrtmBnA5h0ogDVGmeYVbVaJKR21V/gNeG6INBku/k1/hhNzFv0gJd3KxWuIFQ9Q92ZLeqWXz2SM4qHDAQVKyei+sStMVlIJHw5V/rvutElFOsJjJQJu6aCoxzO7xzrOsQBQfSJR1a/DdsBArJObIEXMemi8zV1IE8xFOetf8jjrqkVDee0GsQd44WBMs+WG9bg9svXG+v6NTQTHTfHb0DETR6HGfVjGW7nl7cEBGnKwbnyFVZo+OVEUPxCMr0HmRitD2LDNiP6uybv9uftDcDLLIgkm7o1UX7ZOHNetIyiWWbGu12aLZFbo+CC5KvImOcaepow6Iw/Z+/QT5QpshxVt2PUNFhOfCm/5rnsrnXyagnbqNbtf1HKdkymdLZsZa/vgEi7TCcIPvnjy5WFW4tQVC8pajR6B4itndWG6nYK78HWM/nntH2Vh2zQTiZ88+uhzTZxDOqS+futHHHjl67+JJk9OCxjFTtn+3b6TO0Q8RwticsMl39qBaKVcxqfwvVt6bEAcsoPD0r90Er6AQLgtCa+GenwPdMMsid3cDKaqDWLduHgBGVue6oucC2Y13tDiQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f96cb22-93d2-425b-6554-08dc6eca7f2a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 19:18:37.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzzO4bfsPCslq1rh0QzcNOENZgvO6ehLr2tAhgUgDnEFNIzyXdN5wAfLl11MwY6EBGVNN5cBlk/9EmiLVMI9Q2oFp5KtP8gbEAk8JhAn6y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_11,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405070135
X-Proofpoint-GUID: MimJsJVDg-WQIQFzcww2Boaxm-4EWr9_
X-Proofpoint-ORIG-GUID: MimJsJVDg-WQIQFzcww2Boaxm-4EWr9_


> On 5/7/24 6:31 AM, Jose E. Marchesi wrote:
>> [Differences with V1:
>> - Typo fixed in patch: progs/verifier_ref_tracking.c
>>    was missing -CFLAGS.]
>>
>> The __imm_insn macro is defined in bpf_misc.h as:
>>
>>    #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))
>>
>> This may lead to type-punning and strict aliasing rules violations in
>> it's typical usage where the address of a struct bpf_insn is passed as
>> expr, like in:
>>
>>    __imm_insn(st_mem,
>>               BPF_ST_MEM(BPF_W, BPF_REG_1, offsetof(struct __sk_buff, mark), 42))
>>
>> Where:
>>
>>    #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
>> 	((struct bpf_insn) {					\
>> 		.code  = BPF_ST | BPF_SIZE(SIZE) | BPF_MEM,	\
>> 		.dst_reg = DST,					\
>> 		.src_reg = 0,					\
>> 		.off   = OFF,					\
>> 		.imm   = IMM })
>>
>> GCC detects this problem (indirectly) by issuing a warning stating
>> that a temporary <Uxxxxxx> is used uninitialized, where the temporary
>> corresponds to the memory read by *(long *).
>>
>> This patch adds -fno-strict-aliasing to the compilation flags of the
>> particular selftests that do type punning via __imm_insn.  This
>> silences the warning and, most importantly, avoids potential
>> optimization problems due to breaking anti-aliasing rules.
>
> For all the modified verifier_* files below, the functions
> are naked inline asm, so there is no optimization risk of breaking
> anti-aliasing rules. Is this right?
>
>>
>> Tested in master bpf-next.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> Cc: Yonghong Song <yonghong.song@linux.dev>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> ---
>>   tools/testing/selftests/bpf/Makefile | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index f0c429cf4424..c7507f420d9e 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -53,6 +53,21 @@ progs/syscall.c-CFLAGS := -fno-strict-aliasing
>>   progs/test_pkt_md_access.c-CFLAGS := -fno-strict-aliasing
>>   progs/test_sk_lookup.c-CFLAGS := -fno-strict-aliasing
>>   progs/timer_crash.c-CFLAGS := -fno-strict-aliasing
>> +# In the following tests the strict aliasing rules are broken by the
>> +# __imm_insn macro, that do type-punning from `struct bpf_insn' to
>> +# long and then uses the value.  This triggers an "is used
>> +# uninitialized" warning in GCC.  This in theory may also lead to
>> +# broken programs, so it is better to disable strict aliasing than
>> +# inhibiting the warning.
>> +progs/verifier_ref_tracking.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_unpriv.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_cgroup_storage.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_ld_ind.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_map_ret_val.c-CFLAGS := -fno-strict-aliasing
>> +progs/cpumask_failure.c-CFLAGS := -fno-strict-aliasing
>
> All these verifier_* files have __imm_insn, but I didn't see
> __imm_insn usage for cpumask_failure.c. Did I miss anything?

Sorry, I missed this question.  cpumask_failure.c wasn't meant to be
there.  Will omit it in the V2 of the patch.

>
> All these verifier_* files are naked inline asm. So it should not
> cause any issues with -fstrict-aliasing. Since there are no
> issues for clang. Maybe just add -fno-strict-aliasing for gcc
> only to silence the warning.
>
>> +progs/verifier_spill_fill.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_subprog_precision.c-CFLAGS := -fno-strict-aliasing
>> +progs/verifier_uninit.c-CFLAGS := -fno-strict-aliasing
>>     ifneq ($(LLVM),)
>>   # Silence some warnings when compiled with clang

