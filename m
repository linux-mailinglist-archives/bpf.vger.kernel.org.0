Return-Path: <bpf+bounces-28768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608A58BDC93
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 09:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1848A2821DD
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522DC13C3D7;
	Tue,  7 May 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AU1gBz0l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nO/DjYOk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC413C3C0
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067776; cv=fail; b=OghM6g6T6XynL6sW21EB4p45O9MrUjQHcA9HxsxZZAIaiCYUVX/EKbGNXshGbJ789+Gku1+ladEyW0apN/pSdm8MsOhwjHDBicrOO7zLPoDThGHf1+I/5afn4wdY/NKga/K9+P6y7t0r5VE4M8WFpldRGaRpru/tIKSwzsQZ4LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067776; c=relaxed/simple;
	bh=fnv/dnse0cBB/7WpQH4FJAlXoTidvagnGEzfqa+rHeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZlkZn9kT5JfTmesrsVchInW62Ynn3ZmFTNK3luU1o652tF90D6OOkkiDQtc5Lgxzd13+YhwYiJC3Wlb1JkeNptkqsJ66XXRGvEmV/RwYt998HUZuK98qcKiCq+WJZL0/ZNr3RnZzpNkzbtNI89D78+UB/LYDP1WNd0PBBnHA5L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AU1gBz0l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nO/DjYOk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4476Sl3L026296;
	Tue, 7 May 2024 07:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=3D0amfaNiiWz/xdEK9NsUEOu3VyJK38qDr/AY46bwlw=;
 b=AU1gBz0lRH1kiNE4ixGsR53QHBPaQMhI9KDvOR/RWGfRIu5WKtnYX8cfF9x+a/X4SjZV
 0u4/+U6XWMwMD2c5Y4PMESDf3r0uH6/2K94FP5tmKRt6HyR/XmRFV3+SwiPe9nS/MWvD
 T1Koxk05vtIZJUNc15304KnjAPDzSYul7TRsQN7SCfBO+l9CM4YMCTXh/NA5+XO3B7Cd
 kV3XqonKgSFYzSNRsJiHjptNbtjGtIBciaxaDKUBGFN0tlVRM8r6YA4tE+8aV/KbVSYh
 al1hpCnvGkkJeiwA65Fob3mi9U6Pp0HbxOMGme5sYeWI9VMaxriLwizTtmDkwOL9na5Y eA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwbeev8ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 07:42:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4476EEGe027592;
	Tue, 7 May 2024 07:42:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbfdvrtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 07:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/vIuk1VNHYfoJ5+l9ssJ4Q9G0FD8VUxZUfwwVntDnm1Mj1go+Z1l1PqSbFnkXOYStBgnzgt7n6XACAL58As+7Nk0Wx/ifMsCuViD9PZiydosTAq4cCfoNkj0LZFI/wjfzOs4GnqHiSSj8Yydz1A7NioY6ePTdGpk0ZWWm4+k9q32bTXsPiMWE/w5BzS/UVc5hK4Xxan7Pt+BFDrLQKO3b5IC4H5oHVL2KmL68q2eYvosbgYQuMdtvgTM+3pZLKxD2XaGwtb44RXvsRpvtKejw2vdu4oFDEU0nDMbxErbaAzvBS2O9XVD6Zo15/iIWmG2bGNOSFZyuQmptlkNgIZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D0amfaNiiWz/xdEK9NsUEOu3VyJK38qDr/AY46bwlw=;
 b=nADxHIUvHVj/S3Bm0qgwCotc6GQ3q3C8MzfbJs1Wc0qpQ5VpMspS04RRRVco4E6IGHlMr/rkGdliQ5Qj+uV5x/qmqCAy+n0NVA4ArVOOueiEEN69zv73hHylVSuxTUjgBW2iUvn8oF4XrdhNd5yAkVB15A1X6usr/sHkTIvq4zD1mssNCHCPqscmDvoWtWb+GuYKi/YFddohllZsmLX3SRP/98Ac+xtGkPp/bKHQaCWcGo+vgf+ZC/0dMidwxRhe5WULK5/NYwMq2Nq+F7bproNG7/u7QUSN1n0a8+ZYhYVmKKv6Ve8mS9/DB5aAvyfAaYPqZa6pK6xAqQibEBhCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D0amfaNiiWz/xdEK9NsUEOu3VyJK38qDr/AY46bwlw=;
 b=nO/DjYOk8gv2sXKV70HQGY+8rnjV8o/VFq/myG4cn9q1o0WoqWO1Bq2mQ9YNGT3sRz25ScgDWo7nQNydzNBP3wDZSyD6KFZXoN93PvJKo56kw8DAlnOyYE04OFwwhzXDfQNXh1KGLdCv5GoI0qT04E/LgFy2F0vuknRL9a8lEuc=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by LV3PR10MB7747.namprd10.prod.outlook.com (2603:10b6:408:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 07:42:49 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 07:42:49 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next V2 2/2] bpf: disable some `attribute ignored' warnings in GCC
Date: Tue,  7 May 2024 09:42:27 +0200
Message-Id: <20240507074227.4523-3-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240507074227.4523-1-jose.marchesi@oracle.com>
References: <20240507074227.4523-1-jose.marchesi@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0204.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|LV3PR10MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: a05de1a3-9463-415c-a264-08dc6e694b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?QwALTTh7BBpJ96ljeMZYWUbpFWu4Mim+iRK4JepOm6G2UEZUOyL2N0HmVAas?=
 =?us-ascii?Q?VHB1kcJnVg2bDIqBsUmvyBxQjLUMeQlLJKkhiuIKBTol5HAx2lFDVyj6UA6I?=
 =?us-ascii?Q?sbAmGp9BeRWA+0nBAg8pnVPR/LAMJdkALjhuTno8SnNgRxZPhagipIezujXn?=
 =?us-ascii?Q?YrDnJtDluAUDHdcD3t4kwckvyho2LWs2dYOueIkwaQJ1phmN7j/m4EZllRAO?=
 =?us-ascii?Q?Aax9O5odJfY4lqM74FT7Gx+dNfAoB+bsreh1oCsVaLJrpmxBea8yfUy5mVH4?=
 =?us-ascii?Q?0St0eCHuHbIn4L3AwT4eNFYKime92+WUuYFBJj9GGWiP/lltNr9AQiq/9gmJ?=
 =?us-ascii?Q?eVfYIpeiqs2UgkUajxRKRNHQjG8aCxhCeDXsL1pkZSM8SyZGLX4rkG3YTjnI?=
 =?us-ascii?Q?fcymhxtes3S7OusUCIi4uioiRTciisXLhgs6KD5XW/DHR+k9IefOCXw+sFEh?=
 =?us-ascii?Q?E/dypasMgXAnKPPx4T76acNLj2YbuS1+wyIhShoJkKqydE7E9HzAL8d6oV9P?=
 =?us-ascii?Q?rK8obPbBj2ZOYqkF5RnBeJl3o9DxQye5GsttKJzHD02iTkHITdltgshE+lZp?=
 =?us-ascii?Q?pGxMMGmQZUm8e0ck40PC2qodh51Ix+krmLXENmfeLOt3MSRbHALeVEEhSfaW?=
 =?us-ascii?Q?c0DebT1mCYtw3tzvJZuhxVd0B/2R+59sNIwDq0a6oIBoliG8ItQzth5noLI7?=
 =?us-ascii?Q?wpJz6kWiOJfs9UkQixZPp8DXwy0pLSd574rA0CDsJ8hnOCrKzY1l2kYoBjCO?=
 =?us-ascii?Q?Lnr01xlNt/gSHOe54v6e59tXsoxE7GhY7aOB9zJGg8JljMzVOSTbpJZQduJ+?=
 =?us-ascii?Q?uprKaI0Y6/rnTL7UJxIwy1cakDI6F9XetFDZp/xs35p42DhwV7ysNLxkqrgs?=
 =?us-ascii?Q?vDKjy+wD/ViqnbqLDbZT3yazCQPQjuGxsJsMqY/umQdXb3dMrZV30OXLGlfS?=
 =?us-ascii?Q?E7VgtsZ1ItGykIfEWeRpOv8Mb62qi1UEoKDcNQrpUMikYonvaux3GLONYHix?=
 =?us-ascii?Q?m62i2vGz0sXQvinsm3b0i6GUUJkw1LSiP+XYIJJH5gxQvNWe4hWA2QlfJbhG?=
 =?us-ascii?Q?I4BSPIorOWkRVzt1jDRr7P/ySil2NNugsUUZYY05qwlxDEzYBOsoNuvr7BQN?=
 =?us-ascii?Q?I5hCHs5Iqa8ZCRElMCTWoHWs62DtBPtymr+TaM/LYa4X7XmKbUZYGDwzQSlM?=
 =?us-ascii?Q?DwJC27zRBaLzzB591/JdLud8oLL0Rz6e/qyeOCJJjWDBjFJZ4PRw450Mz1g?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wmbJCUVGmvNM5YeUgAE82aznqwnVMsXVt8qt6G6mAQ08nVGtZpglqiN6ghU5?=
 =?us-ascii?Q?6YBm1emMxvdqTf20Ziul+joEIlEz/5xSRYwkbATTuodQSvL0MermscR57MzH?=
 =?us-ascii?Q?itkGw9NCbYgqhHmKmtR+dptDJUT/Al1TSB0dy11Sfv+eiuX3MMsu6pVaHHrY?=
 =?us-ascii?Q?0X4MHEZRFChY2liCg8zgGos9xxkoX3jawLcqd9zAZXFb92s//JJG75CMIPR8?=
 =?us-ascii?Q?ZJjEl1kI2VVcwM6LTMgFlDHRQ23uv5Vis5oaFKyqcUN++gyIAwM14Y/eIbtw?=
 =?us-ascii?Q?/OZDMayee+knpZdRC3GBwYcDwOu7+OKUsmObzu/pISqqMISWZRg5qVSULYM/?=
 =?us-ascii?Q?ehJeEIEUt1nvnGBW2hIm4hZAe3q8V1BSaPC4QcnNi33jf95o5eI5QT1AcJ6Y?=
 =?us-ascii?Q?KiAQAe6sajZEX8l7AMyJDu5/5Mb/47K0J4pUFYKZihpgpibFbBAdH2vk4ZGS?=
 =?us-ascii?Q?9dZI8B5f9dY2PqJsX7iw0gaQ82gZtA0TR8WapoJ1vdbI/f874oMyFs07JY3V?=
 =?us-ascii?Q?/HuCwg3V/nx/lIu7LzFFACEO9ijy8ob7qu10k/6YAoc7IkmDC+jtgjX12n2N?=
 =?us-ascii?Q?kWeoLMxPaPuemO7N6YjxWMmK7F8cKfXYdY2tJbJW63syipC9nzzimuRNDd98?=
 =?us-ascii?Q?Tw09McoMd8oiT+AXAE7Y3dhLQxqxqTiH7EnEicGr+dd9RE/j2L4R2Ax5+q7H?=
 =?us-ascii?Q?1+IsJPDDTBkjy/cvkmUE41cspQDsIl0PoM3OaSunqFF0ngWjLmviTRooHXkw?=
 =?us-ascii?Q?GhUPoKMDMp/Cv8AdJfKXteEryfsl86CLGCABMkGjQURmbZh3pe/+KTySN5iu?=
 =?us-ascii?Q?nTj4tK2vRzQRefCGSWYbLl5L+VxKYizzfMBPBNKSPEFc/oelSQoFDmZaa9CL?=
 =?us-ascii?Q?xUzij64n58LaIFUWGWdY7OZ44vn3wQcS18elwgzIV4cvyKDBzu9bKP9LkJ8M?=
 =?us-ascii?Q?zf+WzSi/AMcqw2mlugXrWDf8LikURsrlIg6w1CZd4/djmWyZ4pPD5Luzc556?=
 =?us-ascii?Q?kH0/pjCZ8GCSfzu31sFxzE1t6xXwHxDj0xoIGjQTFLUOAVTP5wCbiVZ8IG0a?=
 =?us-ascii?Q?Mwm2J5ttBUlxrO+0rQWtgFctkXzWdFAkwgcFqnwuRAdi1igrkLcSI11z4xiP?=
 =?us-ascii?Q?YUCAYyFKdOm7gt2iSR5jvolHwdRyOruvmmxRmaPc0e3tXK3P9At4zDinPRDY?=
 =?us-ascii?Q?H/SDf1LKSwiBEAg4ZCQWkvaXXrIuwECui/bQNxKqDXKmMynDql3iRXz2XLi9?=
 =?us-ascii?Q?0eDkXNZpM7e6EIFHG01/znVzX4TTnqOuWSMGOd9uTjLrv95lSmsuHrskkEE+?=
 =?us-ascii?Q?hyDqMHLXcltlB79YMEuV8mKN32BY9QosnW0hNgwrRIGGdxmT2qE4tNeBd1NA?=
 =?us-ascii?Q?sXlG9KGiN08RMlf11CN8UVZxIxw7+9iFMNfaloveP+QyoQPnweQ9SFlXh5e7?=
 =?us-ascii?Q?oP1quXvaQ1tnnY++qD3JDkpS5B7e+bhGkgxEEV+GXxM+O69/qAHNyvlodRSc?=
 =?us-ascii?Q?pDFjmVP5wAAdH3uILYExs2iwB71bccYdthxRRl7UTipeUEvmUS9H0jzV8Oz5?=
 =?us-ascii?Q?v6nVMzBG+0Z+r1YpEc9++3FddwLdjqNy0TuP9WjVuvyJjX5rIQCBgAV2n+w+?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TADMiJC7l6jRYWI3S5akjbaP4h+nD2HxSgw2cRk7ohH3qKmrVsK6exlGtKfMKVlFpqQUv7vB+CraYmQieNQnJy+QxqG8r1NgE+5TcvM/h9mpBrRSL/tlj2ADEYb2mIagvqHWny3w/OJ9/wNa+e+Edv9lrxMEkezujQP7SP4H51bq+RPa9hfknrNSqH2fRZ7AD2RmUNxmmIbKyfCxlhqOiowrkZrX50YIaMY8bFBBD6rB8teCNMdFcoRbwqeHVMJ5LRZ/1E8vZYPn+sQvUvxCDAg0kzs5MzpnVYzJppIy8BkL+QgnXd4/W/Ff3dsRNw4Q4VVT3t7JI35JZYc0C36JblqjADpxPWRSZsoJ7AsZ6mnS185um8jWZfvRQQnjjq4KMns51VoYrFTBJN6chV9zHZGBGleM4Mf5WfRImTEmiOThE01wBN4+NwA1SN08GRdDdKfnJEvbOIOd5ktgvGVetISRnbkxf2iJd2nU5mGVdgqk2YexPs+xFTpono25pfn/mv5ktuk017DnhR537Ta/5ghCLyvCCnF9S6c4ZAsv0D0q6+H3PSM+f0eV0qfcOtil4Fcm23ipz3/S8KXf5v7PmhlERi0lX4sDHTFzM3wZLf0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05de1a3-9463-415c-a264-08dc6e694b6d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 07:42:49.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SgrMxuyZ67S+JJoebKDOx7pf6KIAfYhk9llGRowxGrMF3CWt1csqrji/V45Mw7P/e3zXl2L/trD1rAuJtEOWcXamxrlDQsd0yrd7QSjPtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7747
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405070051
X-Proofpoint-GUID: Vw-2b4FIrROQnwT3r5HpN-maEj9QXwSt
X-Proofpoint-ORIG-GUID: Vw-2b4FIrROQnwT3r5HpN-maEj9QXwSt

This patch modifies selftests/bpf/Makefile to pass -Wno-attributes to
GCC.  This is because of the following attributes which are ignored:

- btf_decl_tag
- btf_type_tag

  There are many of these.  At the moment none of these are
  recognized/handled by gcc-bpf.

  We are aware that btf_decl_tag is necessary for some of the
  selftest harness to communicate test failure/success.  Support for
  it is in progress in GCC upstream:

  https://gcc.gnu.org/pipermail/gcc-patches/2024-May/650482.html

  However, the GCC master branch is not yet open, so the series
  above (currently under review upstream) wont be able to make it
  there until 14.1 gets released, probably mid next week.

  As for btf_type_tag, more extensive work will be needed in GCC
  upstream to support it in both BTF and DWARF.  We have a WIP big
  patch for that, but that is not needed to compile/build the
  selftests.

- used

  There are SEC macros defined in the selftests as:

  #define SEC(N) __attribute__((section(N),used))

  The SEC macro is used for both functions and global variables.
  According to the GCC documentation `used' attribute is really only
  meaningful for functions, and it warns when the attribute is used
  for other global objects, like for example ctl_array in
  test_xdp_noinline.c.

  Ignoring this is benign.

- align_value

  In progs/test_cls_redirect.c:127 there is:

  typedef uint8_t *net_ptr __attribute__((align_value(8)));

  GCC warns that it is ignoring this attribute, because it is not
  implemented by GCC.

  I think ignoring this attribute in GCC is benign, because according
  to the clang documentation [1] its purpose seems to be merely
  declarative and doesn't seem to translate into extra checks at
  run-time, only to perhaps better optimized code ("runtime behavior
  is undefined if the pointed memory object is not aligned to the
  specified alignment").

  [1] https://clang.llvm.org/docs/AttributeReference.html#align-value

Tested in bpf-next master.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ba28d42b74db..5d9c906bc3cb 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -431,7 +431,7 @@ endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 	$(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
-	$(Q)$(BPF_GCC) $3 -O2 -c $1 -o $2
+	$(Q)$(BPF_GCC) $3 -Wno-attributes -O2 -c $1 -o $2
 endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
-- 
2.30.2


