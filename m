Return-Path: <bpf+bounces-32092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F3907670
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 17:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7926E1F224A4
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB7E1494CC;
	Thu, 13 Jun 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T613ZUqF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WbqhrdpE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D39144312
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292060; cv=fail; b=HDzwj6tlfC4ldm5C1AvQmWLPmsI1UAj1xtVOnYgQJBOMLPEIFdT0hIvKk4eSZRZLuZJNKj1/CFp4GOHZ6UhHH1C8UJ2u7X7HhVKOJrYQrh8n8GHGObqWWTbde79CXJQAqD8tjfB+XFybdlGe/kqtjtYVoLlzO/VRtdi5FuyCLqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292060; c=relaxed/simple;
	bh=8mrLid7WwcePDVHoIKFoES+M2sZbINm6flDlRR1GQtY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X4qJuP2Okq2EJktf4WCGSXfhI/IxdSH91AekWTGbveS4EX0DeH/EsiiGY8ifnlEArhh7UhiGhfv9CIM8HXt7VZpwwR0gw6NdRTzZIuQslRJK5q3qEpe13nn9M3U7CTVZFueq+O0HttmeGNiaVS2d5BLxmDiwMw8pdiKRYrC/A94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T613ZUqF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WbqhrdpE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtTP6003178
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 15:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=VpUFZTdE8I7HvH
	LPQvFeI8RGpKp4kbXyc3+lGReYFYo=; b=T613ZUqFlw9hm/SL8gWP/SJvs70s6c
	EXCowDudogp/sl+DB2ax3FF6/5Kp93Tz/8aLY2J/fNJo/nqwIAyHKqETCpklVdXx
	xJPw+4i6SO7Vcg7HfKpp9Ihmwcfy66nbPiC0Ay2LV34tyA8LNgcO1XhZxkqwsePn
	0DWSPmkHW93VNvO9FIleggM2JD9iA43IFY/x1J739DFQOgufQRoU9S6ww6bdamF8
	2grfQoqBAj/JU1uStb4NUfCkFukgZDC1Ofkl7UveFGc5IUATk75w7lsGxjr+Kdj8
	f7RKvHrIpGkohBnXcSNIxkG6nYErKB4izBdfG2dUV3Qa6y8ez1jU2hjA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhf1htnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 15:20:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DEBs8K020117
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 15:20:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync91afk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 15:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSaGxl6fHeS8eUVqhFMcbsZjjn0DfbZwRow7QkQ/41tPvocNWNoowo8myYHOU9qWmkQBjnLgWFfhpM6VkWU/2P/24lwlyIQoJDeKw+91ylHwbAdqOUi0VCTiajykifw6Dgi89xqY10HZzmegY7m6LClp3e4U6Iycy22qTgMMlYQdIrB/jV21jWrBD67IW1UKVS8SCxL2bxjiBQjOh90pitHvPrSUkHIkGFBYUgpT2zBPqvRK/Hp07w6k40nqJW7UMMZSQ76lHMRJ6FbVLBBr+Qav9wPkqduRH4yVBo7BHneuI8p28cnWZotAaZVuQzqiisvxUM+bPfQdl5CdvP8bWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpUFZTdE8I7HvHLPQvFeI8RGpKp4kbXyc3+lGReYFYo=;
 b=CZRf9yM14t6CG+4nF172oLSTIjkwkf0w5C/Zz7cGVfH4I2Bp2BDZrxqC4MgTTygmWVisLTwezJmh9+soYbW+UP+VpE5K7uZ3GP3Yp2f9vsdo1FTZmomB4Hrg9wDajIqoYZ9QP9zqJU6e27Ly8dZgyB+uKm40tVy1OWCtx6V5BuF5Ou+0qS1CIjhnBZ5Pwj6Tjw/caJKRXE1Gh4Fc2rWgYQ4dx9Z+m+aWQbUZ1tKAJ+s2+Xo9ytdS1ksjtOOvT0r6QmNG8TwdVRuBuPbEJKDSh49ZlZS/BhLv5l2iiFiXu5Jfavr9Y1cVyTkttHqnhUsKnGpD9lnoCrp35IgAoX+pIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpUFZTdE8I7HvHLPQvFeI8RGpKp4kbXyc3+lGReYFYo=;
 b=WbqhrdpEtkskMoaA7t/qkQfhG8jLi/jpAmfiCsg3MHP5q4rOVAXMUsj39kvv1DVpIXQhfq3TqNyl0eIFkbYmuHHlfiuUIZj2VKySYiDMqffpoZ4bSPrRTAt3e0L1x5vHv1nmt7xm+DI/gv+TxQbSx9Red3iIT6NlpW1n/r0iWxQ=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH0PR10MB5818.namprd10.prod.outlook.com (2603:10b6:510:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 15:20:51 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 15:20:51 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next v4 0/2] Regular expression support for test output matching
Date: Thu, 13 Jun 2024 16:20:35 +0100
Message-Id: <20240613152037.395298-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0450.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::30) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH0PR10MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: c60d3d65-143f-4dce-7a2a-08dc8bbc691b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?O/04WA3WXTaqCXOs6qsFiiAoVkNP/Fd0ytfNdJKB5nQZHFarBwOzo27oep5L?=
 =?us-ascii?Q?5uCnZDA6KJIImcR9c8JP5vVik/U5qcx6WzPCdWfX2rMDVwb510VEl1pdfrQp?=
 =?us-ascii?Q?xPABryOg/ZLOiOa5LktAOSAb5/c4Ih2wyW+SrW56YRMBekwg8+qvMYpkbgYP?=
 =?us-ascii?Q?rx6JZ4Ui4R7II7JsPmUpWs1uCcBpbzE3BPSD3mgjwi81DQxBhlZ/Wgqku5E7?=
 =?us-ascii?Q?Ezc/gUgFJHkc3JzwaP8afCFhdQ4HT2fsTyBgYwb5uMvupb8yD//QKyFPEwrx?=
 =?us-ascii?Q?5w0nH1Nip11BnNn2+8U5bt7Sq2C1eb35Tfw0c4jvQD6q8jjScvn1n7E+zrD+?=
 =?us-ascii?Q?f5MCADzR/XVwca2qop0nGPvHHMG6tiUGSfF6GbJ4w2J4Kvwe9+CJ1LoxXn9+?=
 =?us-ascii?Q?JRvHFtnkqQlvTQt5uFTLI4u1eOoQEvk10e4zh54ZfYTGxyy3kPNIbdxV8yk2?=
 =?us-ascii?Q?2fECMI3G7inNmok5HtdkX/9X0hwBJORsm9rVWg2CIGcrBS3jixzI6oOGYDs4?=
 =?us-ascii?Q?h/5kANi7bXPQ8jtLIiv/Neg++pcFfJK2Hwhdw84ZB0lziryE28pl4aTVea/N?=
 =?us-ascii?Q?eBbNfz+XAXCc8fI/koXjhuKFFP+hUJb7XNbho/x5MzyNfOZ3dfnd+gk3We46?=
 =?us-ascii?Q?6GUDtjbptgRNoPFvttDisZswzMR7F11f6LhWnJCs6auGtNSTi47B6Ag/AZNw?=
 =?us-ascii?Q?eT9+Fzf0aW+EJrDO4l/gsvE0cBZ7s8RGyyMYyBNQ3gVFp98yi0XFA84BbGL8?=
 =?us-ascii?Q?X7DIlrki62481A9tX2Ep9Hdqzclui42cR3B772rKMwp5ZbyP/f0gOlirj2jn?=
 =?us-ascii?Q?wU7pOnATMzhMxk+SExMvGg4++FjAiNCCokVGIKridMPPaEBYG218SGaM/rxt?=
 =?us-ascii?Q?MeiA7ROU9TimZfmseTBwQbX0Gq0WQzzqtzLqlzifJaaapVrnMcHytpvamfQJ?=
 =?us-ascii?Q?wpICAJXvAKqlz8QL0vUDFHe6hogziBs+02zbAlMGu9+DY9T+bI8Mlx0PjS2E?=
 =?us-ascii?Q?p7OGN+ZyfZGdwZ8xupSrzS8kE+2ak4C1zjeEDcZuDL4REIXWxUIH265khsT4?=
 =?us-ascii?Q?Ebufz+QsTP04ulyNqWP691Ra4vxKUVEvolsv+/anKZGO2LQ2k8bMlqOLVG8+?=
 =?us-ascii?Q?Is1gREfGhNpGH+kX9SNm25caJeZGHBUH+Cyfegdjz3sYARMEq2PO94Dlkw62?=
 =?us-ascii?Q?ZbFbV9+IdInMzodyeo3gwZ9xECXQEkbYD/KQQfcH37sFCBCtxxSEpz91bgeR?=
 =?us-ascii?Q?oqLgu4KqWTgohM5t2VNgK2JLE1qnxrpGLKMzwZLUz+x2Lnd1SCFFNNEtLJEC?=
 =?us-ascii?Q?I7qLlUgiDQqxrJ07N5g8s/TM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LI9a8P5j1cMmokIq1rmvF8tSWS1a5S8Pu09unO/uIzEkMaT1UzJp8JZjktRD?=
 =?us-ascii?Q?xBFt1iPVKAdlcM71HS4ZnSBvAYt+e9kHlgFJpb+AVI8wwFxj38vGytuEbtih?=
 =?us-ascii?Q?3hcyokltjwm1llkBS057d752Iv+wmJtQg0YXkYWFX/T7VaH3JN0DgmAUxSCX?=
 =?us-ascii?Q?1EJtc0QPmLTgE7aE5jywwUNg/DLa6t5JnkFqxvxC0i40nLQurYtEhvxPE8NZ?=
 =?us-ascii?Q?yvSXZ1lNm2HX7B4ohzlUg3q8Tc9Fc8E3VsLYlH9kW7hnSBScHikMair8tz3I?=
 =?us-ascii?Q?+6GjGcPYGcaFc27q4nQkhnFvg7hFkJTQzVrUoQY5x6DK68WXTyp2z4b9fWZv?=
 =?us-ascii?Q?68FMYj7xSWxdxt8wh66tIg+lXnwk1gGysypbEQcaJUZJ0NjPa10ISUac55wR?=
 =?us-ascii?Q?rH0JhD7Ag1JdW0yHh+DOTLCsXhVAxhsaIGVLKVhLtyK5yYYDXGosnuqXjXbI?=
 =?us-ascii?Q?BVHpeqBLVoJTkeMaEJyNoEfoosUBS/3BsgYNlpWdRM9NzMyhFPNrJtRe6Nk5?=
 =?us-ascii?Q?Q8+T6BP8f0NM/lThN6qVxzsAZ2MNHncfKeiYJlNDSQ90y/Dbw89R7C0wZ/PB?=
 =?us-ascii?Q?LWQYrRO9l2/tnlIUCby1tt2zjW5ie4ygOaRMPB4O/9ifu81Lsb+xz61hjUfU?=
 =?us-ascii?Q?IsCJAljzIxtW5kQ4fHj9V3MRQVHWV6JCpqnARn02xa8JFHdT9RrvZ/RgUT/v?=
 =?us-ascii?Q?xbK71se68t6yxJrAPJCGIEdcLRi/Y+M4cKVMByApGjHXiWndthPdyNS/Tvj5?=
 =?us-ascii?Q?dyxaAdRlcExUSdUUauVZ+4CkmltXH/wma8EteZomuE7rkJugWjmYrJNaIMFV?=
 =?us-ascii?Q?eJ8xmtkKjlDuuaYpvQT7+goOvTkL6EJbFjWx7n/FO+SHcziObFWUuC6NPoet?=
 =?us-ascii?Q?mftjKTkri7/LqyBbTLxRph5l62WQRiGYh5txC+Dol4d1EtHJ5QHqhAO91mFj?=
 =?us-ascii?Q?jaERTo0ywPDHdfL1UTcuRko2y6VeY49VE4p6MjGHadk05g0Pcujxtca5ZR7W?=
 =?us-ascii?Q?wvT0XGfneWjwQlZBemaeGWQXhPoNXHyricaPV8xkk+KGjJi7GG7OI/BrSopW?=
 =?us-ascii?Q?phmyr4O6/T8sHEoroYE8i7ncdYtOK5XMQq6ekOZl94fAmo3R+eHRA8lbX00U?=
 =?us-ascii?Q?HGT8Fw9znTMLp+A6OuLIDuVjsOBmUswjyxErAqPM6035H1VKjo9LVAmbfAwY?=
 =?us-ascii?Q?SQf5G3bn63SzphJK5HBmxt4odVdc/vpp/93XFGuG+oEHHC8++eQhQl6Iggup?=
 =?us-ascii?Q?z8k7dF2dFHsxConyz0RiPKanaCvlLwZ8UuaDUW/E8TW90/DB3ScqemVBf6/U?=
 =?us-ascii?Q?5cMv6R8CHpNqCtiETtXfWZwHOEpy2lGVhWEOya8zKY+FYkijv5lrgkuKoz7l?=
 =?us-ascii?Q?3zOjcFr7i4tRCMoKgUV5MTwcbSnP9eypAg11Gd6N8L9v7l3gNlaaBczDXVzZ?=
 =?us-ascii?Q?Nv1D3bZbM2JGXcXggaWZxelN6IIZOVsmGRxhieSAE1V26xG1eby7X7DF2L+0?=
 =?us-ascii?Q?vbpm79x5EGZPJ746mYdQyq2YT+Jlv014TgpnGOtOoM6y7jk5OYd6x/Kng9BG?=
 =?us-ascii?Q?zrZtAOkqIwwg05vczRwaIv2sgcXMnbBmM+qgX9leOGKAticCGIMSFrw+KUs/?=
 =?us-ascii?Q?LHB5yQKrv0npbuZ9M6flntA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2lV7sOrEKJnQ3IKV5L/vxrbEIGXuqd7M3fuCuaeqV9IG9SEPi9NwKgD2UljFzBtMBPH0eeBLdU2hd5D9KuAeS4Rf1GvkjrGaDjOFpK8pbWmc+FaIvKhlpW+WGGHAVE8aiiEyLJkyVJ8aKbXqf+5IAyRJ1x1GYmWKe55fmjrI03HymPxRtEupzb61VZwzQyndgfPuIPVc70R0f/dM/zmABujtuxGcI/rIW0EedeCqe0qTJoOqHpt9qIYYrFTRPP2tv0AK4lJmjKoOS9T1Toqr6Cj07nw/hRaWK+zPUJ9oxp8YfqBFK4f7XzZBdxiA5HNPx4yAX+JKx7wiue9QnyECaUeQUKiO4v9YSImsjfQp59a7kAFtDFCK8IwtigEEluPmEfUhFC1eg778kWp1BtYRlXi4nP1cR28POQG/2Ao2AZOmVPjE8da56FSGoZ3DyW15LXmPajXSjHhl/ehBGPVU+WPK4NpeBidlIFQxBLKFJqGGanQ0Czdudgd9qnyQabHIVrvF6nvm5Cj9PkRwvk6Oe2hBc39rXrMkx1axMtZ3sEa24Kr5Qrzwr2obRD+228j32HimItPDfoyV3b29pZt2lW7P4QpKWIddSCRghPLG4wY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60d3d65-143f-4dce-7a2a-08dc8bbc691b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:20:51.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxFfZg18TK2JeYYvdzjZEp2V+aXSKAU4IZpZf9OGI4cILJ7dK7NBYaBeMS2Dvx2XPRoATIm08uVjDNDOtKJLQ0EmaV31W/4LXUl8Y4qkguA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130111
X-Proofpoint-ORIG-GUID: VJH5JiO3eNIr52U6Be4NZHUW_RyEsz4w
X-Proofpoint-GUID: VJH5JiO3eNIr52U6Be4NZHUW_RyEsz4w

Hi everyone,

This version fixes v3 review comments from Eduard.
I also noticed I missed some previous remarks from Andrii from v2.
Apologies for that.

All should be fixed based on previous reviews.

Thanks,
Cupertino

Cupertino Miranda (2):
  selftests/bpf: Support checks against a regular expression
  selftests/bpf: Match tests against regular expression

 tools/testing/selftests/bpf/progs/bpf_misc.h  |  11 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   2 +-
 .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
 .../selftests/bpf/progs/verifier_sock.c       |   4 +-
 tools/testing/selftests/bpf/test_loader.c     | 115 ++++++++++++++----
 6 files changed, 104 insertions(+), 38 deletions(-)

-- 
2.39.2


