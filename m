Return-Path: <bpf+bounces-27753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D623E8B164D
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3541B22B7C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1CA16E861;
	Wed, 24 Apr 2024 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gUzopw12";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g3JeDGcW"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5116D9B2
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998498; cv=fail; b=HXvaxayl/7w7px81nYUZ8G9KUu0XfTn4QuUYcc9bJZb1i4T16uesRp1jDS9BYv0zU2jmq8QFcUVVbXbuHK3XHl7XvyjamYdaoZ7xKkFjbqMLIdEOdqBci+WPgb1ongYKCxFxSeOy6ObD7QEu2YMq8Y2roIySM+jhAq+RTNalGzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998498; c=relaxed/simple;
	bh=7QvLpJL6qGCHxUYoYyZ5ZTD3dR7oC5qYaUT6I4J0+80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BF4109he9x87va7Twj4aMa8e7un3aC0OCz/yL6/PkzkWQXuhdwTinVV3BA7EZ7GZ5OVn8kEnlFIsjVoJ0PHRauMJMIMpF0Mmv5qsS9xcbiLiWhk18uZai8EKwK4/swGhylEBXw/LLHvhQGgb4ShttLtR/utIVzEiNAj1QifVshQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gUzopw12; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g3JeDGcW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OI1Llx014712;
	Wed, 24 Apr 2024 22:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=53Po0fihgt5fe6JhZ/7DE075UQrOKltZcgoBx2MNSAA=;
 b=gUzopw12csE+nZGBYyaQbGQ4R2yNXgSclknqgB6xTeZhY3KSXUjNeSFv8ShlzZ2uZ7Zp
 9D1GWadZ4tIoqphKVCucn1NvpeXktDvOgjGmCXMUaDH8uYugsPtrFViFBRQjzcgf5zfw
 9S1AqG+wcN2u2Mv43EliuoR/XSwe5MclAk7gGcnR6Yekb0+eYB/C9Hsu7WLX+9K8Ms0a
 fJHU6bgvaZli7uRvEZnBZTkvWDNlUNz00bxGfAYalyTCq0nvqz84CijOSgvoYciwKx9h
 erpZ8CIFRnPnmijQUbmII9qEbMOBfzSalvdeT1eOYQ/N3Aqwns3Pwq9DaeabGPY2Wtew qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4g4hbxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OMDQKu019227;
	Wed, 24 Apr 2024 22:41:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf5gg35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYU+AhXV0I2Czy4+9Hr9eils5+wTYzzYdXqvNCbKqF9U066feUrEgdsIBl6ChZNtKl4IvDiv1R2A8XqgCzIwvXC4pLcLUHOEvmgRw0yx00K5x6HVasTshnGjyLM2heY4iCIIZToB9xudAVmnG7FMC6OzzM2epQLooXH595ffcUHWxNRyOfGXkSwswDVXdXUBBCKAs8aM3ddYZvI5uPYY+Tyq/GK1VB8jc1XQUjo3H2KY18QF/vWPysUIc7Qy03IrEsLA+++CtkRFXFIdcEzrYeOsEdXDAHeByn/mk92tk9+i/KjnY5uzsThK9YxJ+BA6B7diZXdlJyxnLxU0bvZOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53Po0fihgt5fe6JhZ/7DE075UQrOKltZcgoBx2MNSAA=;
 b=L5iHHqUBdnkwEGEeB+fHcuH6JpVG2Ww0NKD7aWSZp3nkOIILxkYPhLYgWVHmDBQlY3YXCfX7iPbQTkLybHN0p7O9Pk24a3GuljqoucC8ef32qrmZqwBtNXn2a/2tirBgiIKq8T7HceR1aUjzLSLaEuCbeEaTjSmv7f1B1wfxeaZLjV4I3qXrwzINQhSSBFue3YoKadQax9JlAaFFOzUvz2iepTljCHhSh8mYURNunwC3C7psxwofGQtSLeXwf5zKpChASten4z/UjZgunR2oIzsRw1hUyTV3vSw4nMssjkWOGRcv/I8dQxGn805K/bYnC3gCJ9prRAhtDmYCMqM4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53Po0fihgt5fe6JhZ/7DE075UQrOKltZcgoBx2MNSAA=;
 b=g3JeDGcWaNZFeNy97X3ltHa0a1mrbtshrsYur1r1myn+SUWRw546wR14iahQNQqUJwLboFWs4jp43202qtmTABv6/nNdaCFVj2Y+OLoYQlbg/tUGZjwQ15AFZYCE6RaNXNtmjcgXBex0AF9eZ08PE7QKsrby4u/asdXoydYU5KI=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6792.namprd10.prod.outlook.com (2603:10b6:8:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 22:41:30 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 22:41:30 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v3 3/6] bpf/verifier: improve XOR and OR range computation
Date: Wed, 24 Apr 2024 23:40:50 +0100
Message-Id: <20240424224053.471771-4-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240424224053.471771-1-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0413.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::17) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e06098-5ef4-4330-32e0-08dc64afaf35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HIE/PpJ+fRaaNXed80wzw5CY7gVwoEZk8p+WcZ7Rf/pc1SyresRJvAsun8YE?=
 =?us-ascii?Q?fEf7C1ssj3aILypGlRGXQ8Q47mtkWQNxNdOmmY8bbD+OgxkL3mxZRE4vHvnr?=
 =?us-ascii?Q?nGLSTrRc4sfW+gsDXpRcCkX1SCvYIEcdSLwlt+VF/BTudf5x6LEFRg+8G3IX?=
 =?us-ascii?Q?0pdYaRpHXbrg611ePsjf5lEBaGpbj97WjNGmqI6nmsb/xQbM0aw+Q+cVQHd2?=
 =?us-ascii?Q?nIKGK26HtfebUQSKC1AzmTrbNG/RYI5IDZSWPXYgiswrosIz7pUARTdn9xTR?=
 =?us-ascii?Q?o+TrTgQ9ftGIigF66jwUScPg36UyQVwWLgSv88fBqaJ/6+Zy2b3hj4+xbs+I?=
 =?us-ascii?Q?x12j6cFWBFW0YwsWAEV5pn9K29rMo31uzU/GinaNyjlZuwgXvc8XA36+pI9T?=
 =?us-ascii?Q?vCPFggbeMraqlFvOtBvggh8CGpxQB+kghqz3d8eN+stdQSxpiQaVPksylD8w?=
 =?us-ascii?Q?cSjqn+TNUtXXP9E5ajdue6C3g+j/eDTExRCWOE2ehO8wkuMKctYENp7ts2r8?=
 =?us-ascii?Q?tWKXiRQxwQLCeX+/tLXUZdh0H20+KqDgcJR622QHZXTSNI/xv8v/khwD3m9v?=
 =?us-ascii?Q?VXQXntvyeTGHvN3N3b503ruw3q80eVEyv8NYjM08cQWrv3UapmGn/oiQiUS0?=
 =?us-ascii?Q?7oPZHtwVBlFempAXrCdWJZUV5QZfWOBVB88nmzaGzgUpuMNpCnDi3eXbJMcL?=
 =?us-ascii?Q?pEwRGTc7JUhf0GzsjbvxfV9/ewiGLjhB5M/NGppokK70/jkQJELxoJhzfJhk?=
 =?us-ascii?Q?mj0CMcbUrurE9Sc4/y09s3R6+fsN0oMMRrQN5qr7Eqjy4IceEJa7dXAqVplG?=
 =?us-ascii?Q?oz9u12H8J+dVkkWOyym1mboLD5s4rjnPP3+Zx7g7qyAWktn73UBTy8Igoud1?=
 =?us-ascii?Q?5zDRzlJebygqXlqkN+yPbr+Qf6OqdK/qgN2SXJTBHwy7V86wY1Zn36rA19VX?=
 =?us-ascii?Q?4wDGY/N4eY6uD4bifHXm2d5Ke0lWtmMlpChygoT2vxRMSUPzHpqrgDlN2DIl?=
 =?us-ascii?Q?IxGyTaKicCuThexQfue6lqhJvXKcw44Dw+TtMEwSb4FbFOsaXXq94qd286nk?=
 =?us-ascii?Q?fEvwdfUOYGf5VI8JbGq95bfXbsht776sJT3HYqSrwWVfGvwDlyWR1xjfU9OI?=
 =?us-ascii?Q?4RNfKL/i6qH+H68SlUbtIz2s+JPt/12JVue3E+qAgh7+RhT9XnW+oXfbD3yz?=
 =?us-ascii?Q?yBvngLeAqFOJXYg+QjW/aJ5wnjFtJZ/OZU7FCtWa0Is84HU6OR9euSOF2+WR?=
 =?us-ascii?Q?GBRCDl0J3fFGFTUw7CBkW4fTEuEfQfH/2LRGoN7zfA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Wl4zbrKTAXJE0Tz14VyNumeXNojgLgOLwazfy4deqfKXrMTb5gPzQ2Yut5zS?=
 =?us-ascii?Q?p/0uUGI3GKlOCexnsWJU76j9RpRRgmkbheDpAojln/UyKW1iNTJUuZrwc67q?=
 =?us-ascii?Q?pwveFJ4DfDCTVEPJgPzvcCP9lr2u30g66xb3LqxMHWiWORnEJ7/Y1fK6cYhk?=
 =?us-ascii?Q?7/cUDsg68wU7m6IyMX+5lILJVUV6wbE+mT1WWmSDhApxP6WGiAjJIiU+NU/2?=
 =?us-ascii?Q?jKHi0H49Lb36MzkAmlhFRcPxAfYsbf+OT3WDM86YbZIfKZAF2LUrlMhrbDRo?=
 =?us-ascii?Q?kwNbiK0V8SqUReTyT61by1NTw1Dl1mmbp96kpw+iVzU8ET2Oti/48R20dREv?=
 =?us-ascii?Q?dqVPcoXbDHP/XtNmT9vHW6aboogbvfhD4MDJBTeOQcEd88uppOOUMUyPjHnj?=
 =?us-ascii?Q?3po1D3QEl/AjeEzya11OA29VbVce26UHtBw87LBEKxdqZLYkav8YCu6quD93?=
 =?us-ascii?Q?Hqz27G/9/OpJ0YDzcJ7JWUQKP4MMcQPe0bc2GHPOms4T1FkpoIKT6Lb4ETvk?=
 =?us-ascii?Q?+v7kdb7jNZZ8Mw9iW6x+g53vcv2SJ0gqZxHYinrtU5cLg1KSEJzhTH4J4tjk?=
 =?us-ascii?Q?QFq92jSDMeKTM4mVMgbZDl3h9uj3xVUUILUcdqBAaBJcxeD8srsRvZrf1Gpy?=
 =?us-ascii?Q?7hg7J2GXirnZHIEJzp2v/2nbcrmuLOa8DHFin4/PspfX91LL/pTtaFL3W0hE?=
 =?us-ascii?Q?41G3djHYejJ5l5t0cKpNqkpVNxJXM6+l4hExdw8wBb0kZiK7oVi/Qhl69wh0?=
 =?us-ascii?Q?mOVZn61kU0hSXS2LFHPWMfjso0GApHnpbRUUYNcMmJvsdMlCiV+ZkMgPe7yd?=
 =?us-ascii?Q?7UDDShoF7oFjpRh/XNHq/o9SHyj23u/njsrApt4lHmc9mmAxOxQ2KXvVik26?=
 =?us-ascii?Q?AXnm4ugcseCyoOoj6cpA8RKQNvgTyx8r38wFh7Ci2D3L5g/7xzZ+/hMVNo3Z?=
 =?us-ascii?Q?URLZtdhb0KtHuAKxw/tjMEeYUj9EtuY0mr0phKTbBJ4RMG+z1tyQSuL9+IA2?=
 =?us-ascii?Q?s8f4oeq0f5xxr6Y4nE7ReVCAaObQ62eHoLvfxIMi/fkzyE2he5XpRGjoSHkZ?=
 =?us-ascii?Q?9OxEp8X505MXtrH+nu05iuHJJi8Vlr6YDyCx47hPIZOUWjqmynZHSK6lSauW?=
 =?us-ascii?Q?iaVKO1hjQm0CA6uPOz+4Q5rMoJkhRMgZYSdi2nSMk25EuCZbwkZ4sCQBT9zH?=
 =?us-ascii?Q?yXGbDyRY3/xKFA9ICA7WZzUtPtC3IgZLJGlAIGw9/ObxvtQq/MOQDcHVL4s4?=
 =?us-ascii?Q?CgQR6d5J4hQi+1j/ElStJ01duEn0DLgd1HN4Dq/r5bfN6c3yfVKqrfkbzTYO?=
 =?us-ascii?Q?jTv9HjQgygaC2yWTooP8s2iZp4TzMPppSEQWh6Nacc3GB9b1nCqEaWnYaWew?=
 =?us-ascii?Q?JVGjZ0UvnY+V+onOqswmtggNMUdDtQhEEc6Q++nMVDr38BFHfVo5Q9RmL46j?=
 =?us-ascii?Q?jOGxCqoAPf+1vSJIokgWIoNA0tKuMCSZ153B6Rpi9rxD2tM48Te30ZDP/BjF?=
 =?us-ascii?Q?FLHcKeVv/srxUhjQZRwnISNfC5OI4LDrk4eTXp72EZcqlgxuj7gnWjQ5KFrh?=
 =?us-ascii?Q?hAX1YhLYix6+IXo+CXXoN09AuerxFZAFWy2pY9XmKYfMIV015xxFbIJ5vZfX?=
 =?us-ascii?Q?IsSvio6Yc6n1EqOigxXzCos=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ybj93/t3/MBHxLqLuP1HH1TiYx2XLh6ou/vtk34EiU06sw39OjfCwhvGfiFwoUNqZRZks9iJdJhmvwf2Isa/FKz8wtzV0T7oIaheKZ3kjDtRoUpl3znK5JuNnFzCgnY3cUvTZIuoUza44R+meH+m20sSteG9kbo76T0IZmJjkM5kJD/LV6GWM8Ds2KosPCowiNt4108iBUeEnk56/AN2K6Fb8l9dqHL1D9eheYVhKBaJj+bl+5HNe+RoieUX8citpePoSM5s/ZBDVTP99FCM5dZln1WJRF5Yj8PRpmZnzHj8owDpifk+nE5G5EP/6mn9YNUfrPRLq4+brPuweErl2fVp994ib2ZbYmwkkjmstpZufskI8BC8CGf+9uKRgZe7L7OchdquycKAYr0Zj/mcvM4sv/HNz9Ha5L6Xx4iUAVNA0ewroXzR7e7mIsQj5m5C2zXM0zTP6WEhRpNssD3reKalS+Hb9LMZnXFLzNLFkXxeilYQwFnxmr7+tkns5+T+KneXqOd8owIVhs2KU9upaQqhzZX1pLs7cAAjQzKbujHLsDAKob/PhxJsCjUdbAYEW89kLU+hR7UamPMc8V8G2hCt3wnP9zLEpwr2bOS/TCw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e06098-5ef4-4330-32e0-08dc64afaf35
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 22:41:30.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9HHSTilYMkrIW4+7pMCQnAkUXuMJ89XcvY3LeK9yJz/Vtm+EzT2TVymCFdHgAckTWAJaNpQVszNmiVsmOQpnALuLzdB+mWnGLlk1fiRujgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240117
X-Proofpoint-GUID: pZgaxBKrgltNOASKM1IJ1iKRJ0ywGcWZ
X-Proofpoint-ORIG-GUID: pZgaxBKrgltNOASKM1IJ1iKRJ0ywGcWZ

Range for XOR and OR operators would not be attempted unless src_reg
would resolve to a single value, i.e. a known constant value.
This condition is unnecessary, and the following XOR/OR operator
handling could compute a possible better range.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 829a12d263a5..6f956c0936d0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13747,12 +13747,12 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_ADD:
 	case BPF_SUB:
 	case BPF_AND:
+	case BPF_XOR:
+	case BPF_OR:
 		return true;
 
 	/* Compute range for the following only if the src_reg is known.
 	 */
-	case BPF_XOR:
-	case BPF_OR:
 	case BPF_MUL:
 		return src_known;
 
-- 
2.39.2


