Return-Path: <bpf+bounces-27752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3DC8B164B
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D0A287B60
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 22:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDBC16DEDE;
	Wed, 24 Apr 2024 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PTv9XbM9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hNOdwgko"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3316D9C7
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 22:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713998491; cv=fail; b=thtFLiBS7B+CcQBBCdLYLAFR56RXh8gy50pqthoYYCD4wvaqSPI4jYmeNgO/doQABoqFyXGYikQ7a532Q7OJkY2OthgZjr+mYnZZWgPHWmgo4gTEHGzzpRZK2/IV4q973D8Y/tPLoLWgLOYFEFIyxKVa+TXKadix9BkEB+gu5a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713998491; c=relaxed/simple;
	bh=46lBy/wcQxmZuD1G9QsCRWeMhuzcSuEliraN9FVoEL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y9hUXlIVbh547InEPor90BZ1RmmSK1RHZmbWI0xOPv9OUAF66hIbFewqyDukn9FVvfySUO5CFap48JV3lxMQTmAbR7gqIY9EtpkAFIFN2K84eFAelRT/9CwAieFd0BSpI2FTgbhK9uFtzQBeiJulbvovPyqYdUWd0sShO4PZWvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PTv9XbM9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hNOdwgko; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OG0EAl023154;
	Wed, 24 Apr 2024 22:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=U8Ma04kpP4WxChq5N6/LPV6geIlYq9mn3UXBZf81QlE=;
 b=PTv9XbM9LQj4BwoLCYH8kLrzP0zB0ZRijdU4pkkaVzSJ+YQ7FCt1beSvvCzTI673ZY8v
 T6h1tZD2OEFZC5iF8kH2soO19iZbNaWjJ8Guol7J62/IRtKFMfsBaWzGRCn+4FkGHvTw
 HXLqYVoHT/An7plRYBiEPLqxWk9lVnj0KcfOitFiZyOtbohdMHUJoc2CaUUBYkDMP20m
 2nY0x/aWUZF9SwRHbA+DVPakv0CYyJmZK4fJG+tqzRDNLFlitWssTnaTWLahvQnFnOdP
 TWV8LRSgegSCGFAhgauElnRXmix/GzDU9l7BviAnVUHvcntreJs5WuSUK/vRl1qw6LDz oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5ausarp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:28 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OLbgQL001731;
	Wed, 24 Apr 2024 22:41:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45a4ay3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Apr 2024 22:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAuoInTcLAwrvWBApQE2WqtLhY4IAhl8Q2OcVf3zR/YfhMp9H6sbEYXBhkqiAGimUGq0Rl3L52C47wfRVYdNYCyqGpryFT54Y6mCuaCfHVUGqjoAus2Bl8B0EppvYbBcbgS0i4/nrDz3yfsIRPSwgG5cOcXaTWByS9jpvAns9q7GFcRcyL5M2jZ5f0NC2iL0GfltQvWd3eCvaJoMJYYQjRCxqrEFww/LKjp6xDGDZrUQrH2QWleXEU5lJlJYZxogU4gphiZ8PrwVOHRfaoXAixVFXFatkqz5wLtvU5GmnEewZFRtbQtk8lN2ESVKBTdUnLZ/+cIcAnM8yjhYvqEIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8Ma04kpP4WxChq5N6/LPV6geIlYq9mn3UXBZf81QlE=;
 b=fsYhMN+MYVMOHz5S6Kqe60eUGbdCB35QLjbAh6ITmfaHh9s7Y9fZr9NMthA5MZzgI5DU2Qe3YlzTWtHmPlNLHG0yIAtqkLDHb8qemrIt3lAssyxcUfWqE+Z3gtJSsHb4k/YoIV3NAFwnV7c3LBkTv0a/HbIFzo7Yod4BZEMSG+iuLsVSbinOjuNSQnMjT773vQ22xdDgEEhg3clN/lEE43dNw1CLyA6AwW3q0bUUHr7B/X3sulk06hizks96W9aKqzb/MCquV10akN9wkOVrpww1TxIXhTP2uKMqlzh+eDibqhJPZwbzkAsqmHJh3/cU3Gmw2LgULzfkd+aX2C3KAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8Ma04kpP4WxChq5N6/LPV6geIlYq9mn3UXBZf81QlE=;
 b=hNOdwgkou8yZXgO7wuK9YYcXbhH6WW1TmxHFLlL2XqLl7qYN92oyf5XnbvIHAuV6DZxgUEBxF/bD/42o/PjBMxen+pTskC3y0dLWr5+DTk7pOEpdLb2i/TmkwC69nbpayICn1vFmCmgFUTrkm4lnk0kNqYwDd+KkcLbskmoNVJg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DM4PR10MB6792.namprd10.prod.outlook.com (2603:10b6:8:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 22:41:25 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 22:41:25 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v3 2/6] bpf/verifier: refactor checks for range computation
Date: Wed, 24 Apr 2024 23:40:49 +0100
Message-Id: <20240424224053.471771-3-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240424224053.471771-1-cupertino.miranda@oracle.com>
References: <20240424224053.471771-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0425.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::29) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DM4PR10MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: f09c161b-60bd-4b9f-44f6-08dc64afac19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6Xp65ubVsY6oLrTeJosLhSzK84tWqDmAcV32zgkV8w6nMQ03x7WnbqPd5IzR?=
 =?us-ascii?Q?A0I2x0riWgyji8lZjLT6LrgQ7UMWNwGQ9+y3fW6xqmPStZkxOQf+7QukLiiH?=
 =?us-ascii?Q?R7eO4q9UazBUdkEtxestKdnxC3vnr8Vi/ao9eQ84QqXPGVJ96nFyEGi0c3As?=
 =?us-ascii?Q?r0oX0IO+WxIosCppxXdI2WGdsCvmpVn2PFXiqgYBc5cu8+HW+I59biLpno68?=
 =?us-ascii?Q?ncal2PB5r6q39Xd9gzdvc7I7NylZ4AHbIQXZ1ArssUggXQ4b1ox3PzACyEuE?=
 =?us-ascii?Q?1ZQa9e1E0svcMjWVPETYWdaj61R+6iwvDrJW8EqD0HfFMT38R1dsoXWFNkG+?=
 =?us-ascii?Q?Km71FhIOUF4WLqD9TLUEYqUmZaL/20nEsroSlTDb8IOlVT7SyTgUACH+znx7?=
 =?us-ascii?Q?yj2pUZ9I5rSrFCj6+nRp6sZ1f8lHRxwYGaw7Q33Y73kKjZmCSmuhBqo2ymUp?=
 =?us-ascii?Q?oLaHXj/ELgXbvyF0f+S8CgHmODtSA1a/vDWNXGeRYkIghhQtyR59P0dOVhMI?=
 =?us-ascii?Q?tf2WGNa/imRydg3iESKsxN5v2jDB0qP0ZWTQF0BMQMsQLNNKe0Dki988CplE?=
 =?us-ascii?Q?uQ9iT9GugMzNs02RxALkL18rqOLDSNLx9ORrb46+9Wuv6P/6XwHzb9e1Qrkj?=
 =?us-ascii?Q?Kh0r6hciaYM3YqnKVGVw9V2c2Q8MPy0KzOHF3XGCg4CCMBGEY48BnJXUc2rg?=
 =?us-ascii?Q?aEBYD4Xlek/R+7BSrl1PH0GoAummVNw7oSc3QW7nT+xXTFPxiBe27b7Be+gF?=
 =?us-ascii?Q?gaxb32AlGp/kzZ50bZghd4i+LtReOmqCvAJAI8MCewv8aj83+sBcchMa7TEi?=
 =?us-ascii?Q?io5PKGZPFbRwSIwsQV2QHtYN+fMGZ/2YH8Ck4png1rUf2MkGVZnF29vKnEOq?=
 =?us-ascii?Q?UXWREaR7bsjCeDUcv8utUYribJExR/3lxvW65q8j6y1y56P0l+6pk8c4eMq/?=
 =?us-ascii?Q?98SSxETbNhpTXD8VPQdPCYPyvYYXpMys++uf76KPTlXSqP3XBYDkCIIsjXRB?=
 =?us-ascii?Q?s2v6JB9/S5+bNdH3v6d+M0C6atW9okaubD88MWJfTcbXDd2U2LaITibfyOsD?=
 =?us-ascii?Q?VAwELRLdJOVHxzuhqfz1jz8VUz+mNovuP+Q8KAjoM5e1ZG7ofdWdRAo9k4Aa?=
 =?us-ascii?Q?HchsQtD7eJhAbtM8ge82jTwGzf64kvlH6dazer16NOwFsKCLc56GF4IZllxG?=
 =?us-ascii?Q?1QBQYyNIqYK3JCAfzrPsxGVhF1bxS7f7fZmtsWG2xKNGAAE/O5gHWBSpPCV0?=
 =?us-ascii?Q?kCOm3H0dXPJ2floLjVK7iVGH8ZgofxTlKmg8+2LRGw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rueNnUHnShAkUBUcZxiH/ay0zRtAUxpRub5MUzfswII+5fCtvrcVr900hhLU?=
 =?us-ascii?Q?BJw/z7Q8V6cSlOzc5ExHXfGBpZUu5NZ5Dx0hHVKxX1UQ/kEaXNjCXniUwNtA?=
 =?us-ascii?Q?22lae5heZKeaYMJ5veX4R1B+nBvivhupgObjvSmZqS2m931rJS2p8w0xr+Ga?=
 =?us-ascii?Q?fjBsFFDCOEB54Ym3Ik53fqJtho1yXL37VBRJ94e9LUQfsJTM8jWQqlIgnPyZ?=
 =?us-ascii?Q?vpYu7OSpXB0GtIhGgiF8x3+RFzpfaWfv22RmTNNaibM+7WSBSLKcg+rimmgZ?=
 =?us-ascii?Q?LyUqd9CU8kbiTgLtZ/Ygvp/5zJOyxJBjLdn7702JN5iqUSKV0ilRESKGrX8o?=
 =?us-ascii?Q?ar1PJ8Wnw73HVSt5BPWbGQwlCCK3fLoByhNHyk48NjYDjVqgAw1aFzP4IQ1N?=
 =?us-ascii?Q?RGBXvx9pW8Ch1SBDOBw2aq9hfQuhaNWTWYFkwJJbmEbGvoC4JafFSnwd3Up7?=
 =?us-ascii?Q?8yFmlh/VKML1jNp0MdlVJ84sJqTNBJNWvvninhlVEMC9us//ZeP2BU83x+/s?=
 =?us-ascii?Q?YW7unsZlkuryR9TFz2b2r2bEnOie9olq0XUz5XPO+mLJcLezPKOrxwBbesXy?=
 =?us-ascii?Q?5CHCz8AySPY9CHhialW5caWppnzbY0uJK2IGOwT4k47sqFfJMPtetBSntdVt?=
 =?us-ascii?Q?QzaeGAIzq1Ac8fjKPehbmx2X0HQScqtG1ZB/rdgtRDZw1Cy6j5LHG4WxLo5u?=
 =?us-ascii?Q?iMSgKHk7npT6SaGhlO193NhEJ42HJrEvKkjAdkM8UOOtL2tebMLfA+Havh8+?=
 =?us-ascii?Q?O5N0qNYsWw32ikvyQpUymrMzZ+hIg6PkjZKwORNtiljzYJVcZvG8LFGCjBTS?=
 =?us-ascii?Q?0xLU7XKXVy6QGVWfXhLXIaWai5qS4gzWCLKXD2GCfASSyTkY+CTo8ACOzp9a?=
 =?us-ascii?Q?6HtJ3PMQhJQaj1fS44GfZOR0uHG6U5Z34KAcumFoYNwnVXh3KAPCmHI1Ygnt?=
 =?us-ascii?Q?6XuNnryEm8KCox3E/zrDnMXLH2xJ1cWA9gZeKaVPA6CB9TVsvx4io+yXd+A3?=
 =?us-ascii?Q?pAu5nb/5nEWlF2Z/0ZxhxTkkLZXto9Kp/FjrzrH7EayOW6aVi2nsasOuQSRh?=
 =?us-ascii?Q?4vyhr0LBoc5Gd3gPfzj9GhnUBOE6NxI8yVgg6lK0EDNI1fs2FPYEMvyfIvnE?=
 =?us-ascii?Q?0yJfLcM2/EWTmM290xn7t7hXPwLrqD+n45tNoT0OTskTiXWhzNyVwdvFJ/Be?=
 =?us-ascii?Q?q1kgR6bSxyCUiv7n0+jBlB/6bKTmXTiGFa+lsTGGp8CgR664gjpDMgmutuzJ?=
 =?us-ascii?Q?uMTw7wAdYfBB/aSlRWjsxeC10sKUSnCV1zDJHF2JZwzkil0XExf8SqPQR9G8?=
 =?us-ascii?Q?bRRFFj/7+5mpCjwvf2bzMlITVafuGYQMgLr4Q80xlvDsqxx6rue7WcXSj22a?=
 =?us-ascii?Q?/gG4Hl0nJulKpsUGvEqhlQl8EVULY7F6sH8ijHTJzevvJTO9MG2woZobZl2N?=
 =?us-ascii?Q?e5kRQ+kDcaTnVM9Uu5/LOpG3wRTzWB5DzcyXYjDqEqHh8cFKgAGNtdcJt+pg?=
 =?us-ascii?Q?JFPPZXOViQTTPSoyxcj9yxI+oumx2LFlA+u8EDrmaxZd4Fr8DidnED6kb/v5?=
 =?us-ascii?Q?Zh6thqhknxFECkDUkL9itP/s1n4M16NoJ4E0YtqVPmyVVLf02/Fz7dwtFHuh?=
 =?us-ascii?Q?STFfyLWufCZH+EJhUG5gcYs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vy7CXVjDj0ZYwTMzrwoLOftONnI2NJqayC7vqJ8Mz2rzRUQqj8IsQlp1s9cIV0+wAC02I8pBUWKjPsj+sRGTqsux6HxnnUkFAt1o6li4/xekSMZ/iaz+hV06xGGKdePiioWJb6J28SiEgnwwIDpmiYDFGCcvymoj3tZzjTXvh9dwOZDwRpLrt3Ta8h9ArNvtJ6OVWKJ8BT9CqF36rMRACYSEe8eWu4znwk5dMpgnBp57tBLDZM6vUV78TpMUD0To802vzVipmPfe6HH1icGJR65+Fmqm5jfg3qyXihjFSckCxaS/8zcHGT5jaCMDdWmPSrV2R1dVPIJWxCNKyyyAwRr4t3IdID7gnNZiV9Di3dJrXOqOVCa5thk0gvr/QJFl4UKhL1hPv+UkpYhYmtnWZsAIeLlFfwr54WJlijwQWeVcbnAzFXPSx7Ha6Q0YVQYqCXjgvrsgx18La9sfptP/Sgs+mG9+RN3JLN6HO9CWuc2b7+rwVlJ/VPKJMpVrX2O0zyhU+NldsRTzZ1LbPfIR11wRJq9lVaHy+0kILc+fiJrfirBn0SktCldMnxyZeNXUEpDB2StAgV6MpuD77uoVAAVMNa1kh7opaGHqnC3D8dc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09c161b-60bd-4b9f-44f6-08dc64afac19
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 22:41:25.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kG5t3XCf8NXDWTBl1fcBZxss8qtFDX+0E+S02ySiEPENFYrrHYnA595pr0wV6VzEboF2xBfIKcmKtCcbzfyqWXePlc2eznJBDJ7W9QcWzZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404240117
X-Proofpoint-ORIG-GUID: gIik8PYrvFABdzXKWGXth_FhAc69qqsP
X-Proofpoint-GUID: gIik8PYrvFABdzXKWGXth_FhAc69qqsP

Split range computation checks in its own function, isolating pessimitic
range set for dst_reg and failing return to a single point.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 141 +++++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 64 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6fe641c8ae33..829a12d263a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13695,6 +13695,82 @@ static void scalar_min_max_arsh(struct bpf_reg_state *dst_reg,
 	__update_reg_bounds(dst_reg);
 }
 
+static bool is_const_reg_and_valid(struct bpf_reg_state reg, bool alu32,
+				   bool *valid)
+{
+	s64 smin_val = reg.smin_value;
+	s64 smax_val = reg.smax_value;
+	u64 umin_val = reg.umin_value;
+	u64 umax_val = reg.umax_value;
+
+	s32 s32_min_val = reg.s32_min_value;
+	s32 s32_max_val = reg.s32_max_value;
+	u32 u32_min_val = reg.u32_min_value;
+	u32 u32_max_val = reg.u32_max_value;
+
+	bool known = alu32 ? tnum_subreg_is_const(reg.var_off) :
+			     tnum_is_const(reg.var_off);
+
+	if (alu32) {
+		if ((known &&
+		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
+		      s32_min_val > s32_max_val || u32_min_val > u32_max_val)
+			*valid = false;
+	} else {
+		if ((known &&
+		     (smin_val != smax_val || umin_val != umax_val)) ||
+		    smin_val > smax_val || umin_val > umax_val)
+			*valid = false;
+	}
+
+	return known;
+}
+
+static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
+					     struct bpf_reg_state src_reg)
+{
+	bool src_known;
+	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
+	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
+	u8 opcode = BPF_OP(insn->code);
+
+	bool valid_known = true;
+	src_known = is_const_reg_and_valid(src_reg, alu32, &valid_known);
+
+	/* Taint dst register if offset had invalid bounds
+	 * derived from e.g. dead branches.
+	 */
+	if (valid_known == false)
+		return false;
+
+	switch (opcode) {
+	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_AND:
+		return true;
+
+	/* Compute range for the following only if the src_reg is known.
+	 */
+	case BPF_XOR:
+	case BPF_OR:
+	case BPF_MUL:
+		return src_known;
+
+	/* Shift operators range is only computable if shift dimension operand
+	 * is known. Also, shifts greater than 31 or 63 are undefined. This
+	 * includes shifts by a negative number.
+	 */
+	case BPF_LSH:
+	case BPF_RSH:
+	case BPF_ARSH:
+		return (src_known && src_reg.umax_value < insn_bitness);
+	default:
+		break;
+	}
+
+	return false;
+}
+
 /* WARNING: This function does calculations on 64-bit values, but the actual
  * execution may occur on 32-bit values. Therefore, things like bitshifts
  * need extra checks in the 32-bit case.
@@ -13705,51 +13781,10 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 				      struct bpf_reg_state src_reg)
 {
 	u8 opcode = BPF_OP(insn->code);
-	bool src_known;
-	s64 smin_val, smax_val;
-	u64 umin_val, umax_val;
-	s32 s32_min_val, s32_max_val;
-	u32 u32_min_val, u32_max_val;
-	u64 insn_bitness = (BPF_CLASS(insn->code) == BPF_ALU64) ? 64 : 32;
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret;
 
-	smin_val = src_reg.smin_value;
-	smax_val = src_reg.smax_value;
-	umin_val = src_reg.umin_value;
-	umax_val = src_reg.umax_value;
-
-	s32_min_val = src_reg.s32_min_value;
-	s32_max_val = src_reg.s32_max_value;
-	u32_min_val = src_reg.u32_min_value;
-	u32_max_val = src_reg.u32_max_value;
-
-	if (alu32) {
-		src_known = tnum_subreg_is_const(src_reg.var_off);
-		if ((src_known &&
-		     (s32_min_val != s32_max_val || u32_min_val != u32_max_val)) ||
-		    s32_min_val > s32_max_val || u32_min_val > u32_max_val) {
-			/* Taint dst register if offset had invalid bounds
-			 * derived from e.g. dead branches.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			return 0;
-		}
-	} else {
-		src_known = tnum_is_const(src_reg.var_off);
-		if ((src_known &&
-		     (smin_val != smax_val || umin_val != umax_val)) ||
-		    smin_val > smax_val || umin_val > umax_val) {
-			/* Taint dst register if offset had invalid bounds
-			 * derived from e.g. dead branches.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			return 0;
-		}
-	}
-
-	if (!src_known &&
-	    opcode != BPF_ADD && opcode != BPF_SUB && opcode != BPF_AND) {
+	if (!is_safe_to_compute_dst_reg_range(insn, src_reg)) {
 		__mark_reg_unknown(env, dst_reg);
 		return 0;
 	}
@@ -13806,46 +13841,24 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		scalar_min_max_xor(dst_reg, &src_reg);
 		break;
 	case BPF_LSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_lsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_lsh(dst_reg, &src_reg);
 		break;
 	case BPF_RSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_rsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_rsh(dst_reg, &src_reg);
 		break;
 	case BPF_ARSH:
-		if (umax_val >= insn_bitness) {
-			/* Shifts greater than 31 or 63 are undefined.
-			 * This includes shifts by a negative number.
-			 */
-			__mark_reg_unknown(env, dst_reg);
-			break;
-		}
 		if (alu32)
 			scalar32_min_max_arsh(dst_reg, &src_reg);
 		else
 			scalar_min_max_arsh(dst_reg, &src_reg);
 		break;
 	default:
-		__mark_reg_unknown(env, dst_reg);
 		break;
 	}
 
-- 
2.39.2


