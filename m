Return-Path: <bpf+bounces-28676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716F48BD006
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE921F251C5
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28CF81207;
	Mon,  6 May 2024 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WIiyxJ9U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qVbU/WRh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B913D264
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005196; cv=fail; b=eOXN448oaKWuJeFCK9yd6c4HWVjhxOIkU76fmGt4kcWxWIZ7Ftt7uXywqoi4eR1mfqf6qPx1FFuc3nBDXPoMKtD+8fHUalr2ASF8B0OOVymysbaJ9Oi2uCdywz9PI8IXnFNpg0TZDRnl85S3b3l/rv42nFek8Qt1HEWyXtJKSB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005196; c=relaxed/simple;
	bh=mULoiXPrd5uqIQWzHgwRdZTMRgB9XVz1dHMj0XBlUsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2nGVpCeeNmlUMAl71ECWSlB1FLUX6VoWbdk4H4vRKQZTIr8LKtxp9nNCQ7pnBHXZZwkM9C3zBcoEu1BezrNCVkYzTJIYBcpC1eexVhVjupDrmcsmd+UVyWPj1QEKnu9tpPUoVpyvh5H4iBOeknVG7gNV+RRoiGBL/3ks8TI8JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WIiyxJ9U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qVbU/WRh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446An41I009277;
	Mon, 6 May 2024 14:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=uWPAzeAJ5UJQJrhIs3Tg6LiCfVc10E5WWADrJQRgstI=;
 b=WIiyxJ9ULKM5t2YBRO5GWkNXLOK+8/kl6DlxVVkeT8G85GeN3ciJJsgQH3yQmBv708GZ
 wsWheDqYmEuFcRxI+IxPDpWHL9fmf9flCbES7C1ndgKr9lJGnPC5E2IDHDf2OQduVrcY
 hZrnLj6gDImN/g7Y2vW+zf4csM4tj19xxF9O5Vo4cpYAXTSun8E+f7wEqDTX0OI8+U1M
 PirP+eZzW9VI7bSeWjfcxVprglIbe98ISnfq+bELUGCe27S9NqFu+mBbELnSKF8Di7oE
 KWf0EH4MVzSh2ulV+fPPs3+KsX+LJXwNkzOngTkalsN46cYARhA1CdJpYMHQfMZI2hbA DQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbeetq4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446CeXfn027671;
	Mon, 6 May 2024 14:19:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfcxa49-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/wwsM5sFAlZ4wnkMnYooxxGN97SFFb8oGTFYBWUBBvvXgm588/Aa5Q4Qz8N/UILFRmwQauF2AJ2csqhP6fH9mNrjC1zYzl9mlMs9ocnVcXqJkHi74SAxYAeCu/fz+tTNdL5Ej4W1swubVg1BAEtqTQicwQJ/iEXcVoyvgzQup2A52iWQr6D6z/bEwniyY0TI//3UcVhsZgA6JI16XK85I2DGoqDfSn7pfS8BEA2bw2KQIX3mxkbIpSD9oAwBxWe/1GGHl0DVCdBlOys7lvn8B19ljhi8yJsY2axmfm1+2R+7wvtaFd2kUfvXIlsP1c5lNajwsfP9tUEF5npuDh2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWPAzeAJ5UJQJrhIs3Tg6LiCfVc10E5WWADrJQRgstI=;
 b=HPuOP6V+jM7J+LQeMpBwl5E4pEOSqwpp4UbOpr03TDgbla0z4C3UHi6kYExLTsSX6FbTPfD3WsvHd2RDUlQb/7OFk2KF4nByar7qb1SKGJMYI0nEVgu0v0BVh4qKFSrTep0UJJVoAQC69VWakbiw/Hiiq4Rwhbj2ol30pSB8uqUXwM+y9zf3q5+tqVlKDj2xCQg5gSz5xoHWn+N/iIOA4RNOwQSYvK/p6uryO0DJIYc43Sw0HwPU27oFKosj5stacQ9Fah/vpbmL1iggbOO0rnJtdGQd487EdOPS6ARINN9Frmbp1dBSC8PBNLHPeJGglbQ0VZ+MCqr2sjznHEMTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWPAzeAJ5UJQJrhIs3Tg6LiCfVc10E5WWADrJQRgstI=;
 b=qVbU/WRhOIms+peCphlfjVnj/9YZqkBBRtjRUc6uEqoFU1uLTpG8HdS/O/DnCjCdP411nNMsk8+RoPoZKDUD5dbXHoy7wzmzcfacuZcJ1GGg89B3Lnn9qADDTpYKUiyVASfgzejtp9X/t9rxatepaDviLfaDrdpyGpIUczyelKc=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:19:46 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:19:46 +0000
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
Subject: [PATCH bpf-next v5 4/6] selftests/bpf: XOR and OR range computation tests.
Date: Mon,  6 May 2024 15:18:47 +0100
Message-Id: <20240506141849.185293-5-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506141849.185293-1-cupertino.miranda@oracle.com>
References: <20240506141849.185293-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::9) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f1be7f-1934-4e07-cd21-08dc6dd794d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+1zOAyttKteqQsZcesGXams/xFajnGTUUiQ9kQ5jgllGAJ+hP6rZ0II2K5sC?=
 =?us-ascii?Q?RUryqXjq1YHmWWN4pKUvCGcqO+iK/cfb20CbTdTHAFzcz5t6RwaQPEw1wruE?=
 =?us-ascii?Q?5QysnYgi/rS2gvk29+NQeAD/yRn5ax4j5Zs82W4FTfp/uOMWt1eievNakRqs?=
 =?us-ascii?Q?/qWOQ00GQmWXL/b6B028vFkWhFvpYsc8pSt9rzzeNzUV1hiA4sOkNJuYCd5d?=
 =?us-ascii?Q?iWfvWcDpskvG6T9KEx57+eaCSX88bQkbllYVI4a4IZgpQsmqRAwxYKPZEKVc?=
 =?us-ascii?Q?mToFCudz0THSXIfEYmbYvOTv8/iepsy1duvz+5r7yTtgllY5CtPndv767wEt?=
 =?us-ascii?Q?SpwnRKhGGuTr5IGczWrflnpR62OfshYqEI2dKDrUHNwshn/b+m3ZYvH+6QQ6?=
 =?us-ascii?Q?6IhJInrUOTVm5jf8TIsDzaxgytbYbTzLXiVxTytzNZ02aKHuC0Jsnhe3dvFm?=
 =?us-ascii?Q?KrBJYD0J33dwfaRbRBX52Zd8uAnzuxEAvbLdKmcnO5CNXu2tZOkat7ijmcyY?=
 =?us-ascii?Q?nBeumyHlRGkkFK1JUEGbeGRtSgPIjvV+jRJH/TBIQ/HPk+PXYS784ySkCpDJ?=
 =?us-ascii?Q?EtkbzppjGawlL1ZXzxxSYC39PmS8VdeuUj5q3rpnqWLvVkI87/vuuI/VeDPR?=
 =?us-ascii?Q?K2ZQmFvG8QxPSmQ6ikerDUkzDXoYJomeC9P13M2e4l8Gtf44kt/9AvXlSuX5?=
 =?us-ascii?Q?C4mlv4ZVoPv7NjCLdfD2fZHXbLK0t2tt598/X5YyXk2nqMd0PBgrOTEXYn8B?=
 =?us-ascii?Q?PTvT96SG7pBaOeT+Uz6sFep0HuRH3O1FPokNWPtMLk8kcQZImdqPhJ03jkRI?=
 =?us-ascii?Q?Esa+orvA2LjrLhssW6e4xy6pKlSCFBDidLdWIGGXKIt/9NCX1SPoUyngul6B?=
 =?us-ascii?Q?4kSvKKFe+BKvQZFez6Uyzkrvw4wDFwRa0YMSQRdn80Hn1I/Dxiqx+rtssz1i?=
 =?us-ascii?Q?j91g5H4hVwR7oRSSPmkRthmHr3oMc8M181iBbcTWHOY+raIZSxziY4GDVfHi?=
 =?us-ascii?Q?e7onDgmkxGIz90a3hHESmBlyTW4/EwF5sW6/0yn8+Wf0mj2GMclOqNgOWqEJ?=
 =?us-ascii?Q?fU7MhbYBq9gby9LnLiZ7PyxtnqH8pVlvlRvSy0qaSe8HrWG3yuvlsmoeyhXm?=
 =?us-ascii?Q?77zIAMX/wJlc83P3gTdl05oJx2AjAGwoJkAyMIIGKda6F0gOOAcanxF0WaG3?=
 =?us-ascii?Q?Bm3d88Z+DRP1FPIx5pCS6cGOpqmx1I0nYGncoS1JdeX7eFSjU/7ab4aSquep?=
 =?us-ascii?Q?e2HVGszdMxNjlcs/F6SjVnKR+Q+cSdOr/b+g/tA5QQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WGfW0bxyreQU3qrd0PMTRgjnJwzitpYZA3nmjxpjhGoQZV+zUSRffBJop9Kr?=
 =?us-ascii?Q?RmzFvcX3BWdPeceAP6nYHZVJ4Z59ueU/siHEZGVK3UdpOlfGTATZu0sIXUOS?=
 =?us-ascii?Q?wttgL7LEq0CxCXbKdk2xvNQm4jXz4RgITc39MOu+fV8ilZGFpK20in5eICdz?=
 =?us-ascii?Q?OGqeo8Dyhv8g640la6ahdHiQ1/i+xri9OZFt9juzYU5W0mXMWGgS5dtTxrIq?=
 =?us-ascii?Q?AZTLHy21Bc2ChDkIEAlty9nRBZBzdnz5AZiK9XvLkYx0zSp66w0M0WMYI4ew?=
 =?us-ascii?Q?lV186B0SYN5sdClePkav/zrQBAJMYPZxBjyX8B2gRGIHDXB18upYpKcJNABn?=
 =?us-ascii?Q?mLsseVjZcmDBRv8kzJD92ScR/4c/lLelMS1i6G2MFNMBPHGWmsFLQujE5TTy?=
 =?us-ascii?Q?yk2DHZQitpMjaIZGUapZ4fjaN3CK9nMtsLzkqoa222BxoC0pvTTAamYnCWGJ?=
 =?us-ascii?Q?Zt1C/sgvVGLwo/SiJydchSNxpDb6qnhQPXU2a2JZlgECLv8Ek0SlEEAG9jsd?=
 =?us-ascii?Q?f9ioHlHdkkoAIPLtoqa0VAArvJCBB7HpuSsZuX0DYK/hHis+EKGdmpyv7/oY?=
 =?us-ascii?Q?acZKN3fuQo14pCGO1dbWR0JMjMdI5SjwquzAgXPxMiR5iROHKbRkbHaPt1tH?=
 =?us-ascii?Q?UKekzPQJ1mN77rydXI2TQYtgErfp61PshivvUVtQbUWS+f9qp1kwLLwMXe67?=
 =?us-ascii?Q?tqQ9IamgjphE+O4aSCIF491xBHJ5svhuKFSPXigCzYn+Fgf11qGP/qWymtkR?=
 =?us-ascii?Q?9+to4n+jpk3+mTe5zihLPg68eBYqxQeloRmDVec9Pk9+eUuWtrcaXHG2CTfO?=
 =?us-ascii?Q?XV9FDGnxtqiED2KAskMdcFuPUq/hy5wvFBHuAvx57rEaixYpiCqe4YpDFAOz?=
 =?us-ascii?Q?3Ga1FXMpHg6JK4FH43eewbo4yUz91wbejxNbaa4u+0cwOt5cjBXuX7ZA92rt?=
 =?us-ascii?Q?Lnue1qiM9VljCjYjK/dV5d+Ik9oNwmNiAE5K9nVlvEdp8IIOy8I28wOkCK7I?=
 =?us-ascii?Q?+xEWENZodYYiqADkvavrqL3Qpdc+67eOJ0ISmsiwZ1RIrQgif43Wt5oCKbPR?=
 =?us-ascii?Q?u1PjDNNUD18Z7eYtBlx6I3R7NLQF9zm0pNbldsroH0J734y2n1tBbLGiXOWn?=
 =?us-ascii?Q?xhQYB3InmZmev31T8sIW/bI07mpgCD2RqlVtqxF7brK4SIc994ZXCfK9kQqo?=
 =?us-ascii?Q?gw0xv45m+yK+PjoNTnz68ukZDJk0a2CBta5Lik4V2UaPfld7S1IqI9UohSV4?=
 =?us-ascii?Q?rOJPUNQtVc3YACPj5WhZxi2snitCi4V4pfP3zQPq0HYESXeTZxBjMmfyp10F?=
 =?us-ascii?Q?Uh3GeJ6jVFdED/UOoWKvFHp0gm3l2jHYFxrVpdqVOnRFepXVmbsGNkri/IcM?=
 =?us-ascii?Q?RkRBWrq4wM20covCOXv9zXmCPxRq5pg3MNuL/8trRU6lY/S6XFiMQ14g2qHr?=
 =?us-ascii?Q?WFHy1ZDNmQhyLJXpdMpxmPNW3dIsCGvVcpFWPp4udntCr1RFABkMkfXgYKZE?=
 =?us-ascii?Q?LfUAq/Bet1OTlpCnMAN3Pw2RKumXXpPy76BPP31z8V30XPI4RSZm8rxi2ojv?=
 =?us-ascii?Q?ZyILvX+mzcALnzjjBI4ALPmsjedVbNpafj2nc1KVE1rXhTwuIBdIXSWSKxtC?=
 =?us-ascii?Q?CBTsilRYsxurFgy1S1rqbbY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xdKAShJfMpDTmQvtOeryKjDaQZJaPktFiXizcJTMauzbIQLikQTScwe5ZRh3y588Nz1UDjwZiWCVOe135c1lHG3/jYNhHCwFrte7N3Nzl+SxvUGcyaDEabmDY66AW0Ld5RkPW7vNiyCepaoifdaX3EEb0SmVC+qx6o4rdDYMG6y+4Gr8IxjWDC+soaq7uy3ViP2+CtP8CAbd0TtO9qW1p97rA7ovi24OqE5r2m6ixv+s4ik/hgFLVps4uYJwt4xdfrJrWqSwDIQ3IKx+lYsg/FfFraMjNOxoCFzpssMBUTeG4KXigfsmOtOVoDwtKW/mBUPCBHZvGJJaQmgdWrXLHe0YfoX1kcJbGFFqKBXfJst8jn33gP3KSl2luutHzP6DuzDGOaAJcIY5YkEiv116IN3TZukI72Y+SPcuJzscytALYdl7sRKafrOEuFXwQnNz2sIRtWyaDwOXfYfYVcv8MMhWEG6vS8K4EUiI4ZjoofC/5PvBrBXMcmQKCIbQn2YgHgAH7vAC+xQdBNc0wOAh2BI3RoNJuemZNme6R7n9NjAcS/cPzbIbTKukJQfbmmKRsuqWfTyYZJiGqs2FWsGfHofK8g7jIlfCTTMLW5FHV28=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f1be7f-1934-4e07-cd21-08dc6dd794d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:19:46.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NG4FbeU73visg9bCbW8BTQNgh2iGAYPR1LKqpRXU7dQqGN098lL99Uc/vd05CFVCi3+T6yg+917QyVS8oIDBHAovLAWqbktUXrNaQbLrD0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405060099
X-Proofpoint-GUID: hrejfeno_OihQjurK2Ib4E7_gpGouUTM
X-Proofpoint-ORIG-GUID: hrejfeno_OihQjurK2Ib4E7_gpGouUTM

Added a test for bound computation in XOR and OR when non constant
values are used and both registers have bounded ranges.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 960998f16306..7d570acf23ee 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -885,6 +885,48 @@ l1_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("bounds check for non const xor src dst")
+__success __log_level(2)
+__msg("5: (af) r0 ^= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=431,var_off=(0x0; 0x1af))")
+__naked void non_const_xor_src_dst(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 &= 0xaf;					\
+	r0 &= 0x1a0;					\
+	r0 ^= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	__imm_addr(map_hash_8b),
+	__imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("bounds check for non const or src dst")
+__success __log_level(2)
+__msg("5: (4f) r0 |= r6                      ; R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=431,var_off=(0x0; 0x1af))")
+__naked void non_const_or_src_dst(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 = r0;					\
+	call %[bpf_get_prandom_u32];                    \
+	r6 &= 0xaf;					\
+	r0 &= 0x1a0;					\
+	r0 |= r6;					\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	__imm_addr(map_hash_8b),
+	__imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("bounds checks after 32-bit truncation. test 1")
 __success __failure_unpriv __msg_unpriv("R0 leaks addr")
-- 
2.39.2


