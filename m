Return-Path: <bpf+bounces-21505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE2C84E155
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 14:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350422861F8
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 13:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0858B763ED;
	Thu,  8 Feb 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZWiYGox7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wlGGHHiM"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956E4763E9
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397477; cv=fail; b=YX6CaOJz6MsYGKO9jry9TVkKG0Ox1qFLhicVUwNQGF2VMWgHHfARQgtu4lR04XehM79SelbeHaJfR4oQafC1norSxizXziHNlq8u0f+fQbJYEhv2E8hFyyZ/sNLMqAu1zBZsXttmrAazlqChzCqzOrJAgwyz9euDya5QXg9k9FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397477; c=relaxed/simple;
	bh=60+xy7YB3mVdPLKPR12q3wHkWxfb9XZvXTissQqtFz0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LV51+Mp1cOoDAzYrGJAPAaFZXxA4QDpYUWl4Uxs/8VjroHSgCFddM+AsKHdCo7Q/cDnfavwvWe1LR22ujr3hKLbjRgJZRZSst5KPUJXw0xWsA3fbfD7l0JdnhFdx9bOOu+1t6OpBOfLqNdQDV6Uk8VBPECvn3xXbpwon0Oxnf78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZWiYGox7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wlGGHHiM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4188x1IL022084;
	Thu, 8 Feb 2024 13:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-11-20; bh=Ve6EJUZKcW4UasRwrYt14HIdmzgcHEzDREOlfamX8P8=;
 b=ZWiYGox7jqNUEFY9oSW+Yb+tYtZZsvn/lLnResie5PyavXCjPmw8yj65RWX6VyznAOhl
 7wafamrmhFgZOyvDU3QdBtWG74hF4sMMr8xE4XPY94wOiw+iNnnBX9SAYUM0NRU+Js5F
 DoJPycC9SLZNfwMhvYKxz/BJ/tOrAQYRRT+A1oFW1at/xLwu5oDYR6isO+eLEpa+RXeS
 7ooEmRpX3Gbk7R2WPSJxkvE67MRZiLWDtiVQe91h0nyMBvh4oaUUOixEdS1w6erpc+v9
 bjn11NpUaY+jGXoWrCJq8nmsdk+7eNPzPbRU3EWTMphcdggIqJ15aeVng6Km/BYCvHED ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bwevekk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 13:04:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418BMHtj039463;
	Thu, 8 Feb 2024 13:04:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxabaam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 13:04:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFccUeWOfaD4LKbVc2AVAvsHCJO458Pt0eHeKYapAE74tRiXFbPtje6SW34z12HHZ8n7Rzty/lJ4oGtqy4DstqXZH7It7KYlpanpGGdVyUBtNGO+Q1bJwyVexmtoUtt8aQgtxRb5C9fmh2+7AF94TM9jNHjaVwkhTTsrzGv7amUh6H/es9KHsGYDNo9zsSCT7a3kFLRPuDLdKGxD3m7f2CQCW2Q/Ww/X6JvzFbQAytbDzRcMPDTTCEblpLtNdio0e4UW7Szx1Z0wY3rBd+XAGEawR4MQ471vRVOhZTF3sFoJ8/XpXkKkwQaNn8XGtT+iuVRn7J50EjC9FXELkbe6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ve6EJUZKcW4UasRwrYt14HIdmzgcHEzDREOlfamX8P8=;
 b=ORgDe03piMpjpgSKWwHQbi+JS90i8Mrr9jZeKy9ZYcwDhIFVU9BACtBndQoWKN/QSDMxPbNw5p1HCPzD2U9pj82cXiRasiZlUKNM5AT0uLa+mtFtc+ns+QyrGIIqZcjA6xgQS1AWH5SnnI1O4mo4LwN5eiFBdrrFgnz2f8JYnrNPz8/kNdG2MJ4DdcWKoTSAj9OOIFtf2R4+eS/RG5RX6T9jf6QmwHj9kkMqeNv98lTY5N6cduDbASNHK10n8SWTf/w93vPNx+Vlpgh3eNneSTzKYrfKQcm5kwxvg4u2C+zHhNc8P2B+8I0gwFygpf1IQ0JkmnTaDDtfdHAZT4bjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ve6EJUZKcW4UasRwrYt14HIdmzgcHEzDREOlfamX8P8=;
 b=wlGGHHiMWMOC8mkKXZqKfjnX6D6vLzdOgipzLDTTPhn1qjNs9uLHs9WlaOPEVbtre/Z/qKvM7ZkUrWtQ+YlLNZe4hGK6s17wKEttq6AXJJlziP9B1FRRP90QJQGP//SiDQAdrlQeEmNu+lRqNKtuOKakhvp/+InokGVAdjz/+7Y=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by IA1PR10MB6735.namprd10.prod.outlook.com (2603:10b6:208:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Thu, 8 Feb
 2024 13:04:28 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5252:c588:583e:7da6]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5252:c588:583e:7da6%5]) with mapi id 15.20.7249.032; Thu, 8 Feb 2024
 13:04:28 +0000
User-agent: mu4e 1.4.15; emacs 28.1
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: [PATCH] libbpf: add support to GCC in CORE macro definitions
Date: Thu, 08 Feb 2024 13:04:23 +0000
Message-ID: <87v86z150o.fsf@oracle.com>
Content-Type: multipart/mixed; boundary="=-=-="
X-ClientProxiedBy: LO4P123CA0122.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::19) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|IA1PR10MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0a0ec2-63f3-4b72-b7ed-08dc28a67b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sYM3hBrnzR06BpurMZstDZ4U7u7Ne7qWECn05P4EFkLrm9CMuqyHfWreA98ZB2JsQO477hOP4TZLLBX6Ipz5OicqtxMB4a2lJpg7UuF/cjst9wPvNIv84OIM9HGfMgoGXpOTAAFuTn5fA/MMu93WK6ir6MhiK1IpiQZbaSqHn/Z/RaBdFH7faQRVw/dMnUOruztAJXKdoW+J3vgncz6TsFvygYQSdVx+ldYNXYnsCUZWsDxKDWdEgdDfdFfsxnl9u5FkG6aBvpVySbYr7M4iieNCdvwhTrp4aMFvyhZZrGNERGLODdEoTJTmIW8g4smPkAu8iuDaJfe4UYcQuU0A3oTlA7vJIZzUqDXsANyHx5LNU1OMd1nVcEEEvh/EPAm9BAPcyZEgEkiEndv/hyH/42zOlYl6JlT6FN2aH5tCGuN/5+lEelXdGO7zKIWVLJPJoc4kdJ+qYvHX3wXJOylutQI8VvrdGRgbnZFtdk3am/yRa9ioRlzTcoAkC0ZqyklU02hhn9Dm9v0xtVn2ZEB9fgtVYaAXQsh5uqmXQFUtdmRMgclUS3K7k5HQe9NUyqMa
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(83380400001)(2906002)(41300700001)(66556008)(316002)(66476007)(54906003)(66946007)(6916009)(36756003)(6512007)(8676002)(8936002)(86362001)(6486002)(6506007)(4326008)(53546011)(44832011)(6666004)(478600001)(5660300002)(107886003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4FHgbZdSbcRqXUgh5xwFbeeQozPlwq1wMGs/vGNc9f6LYjCLZLTrajJf9bQp?=
 =?us-ascii?Q?n5P/sh8eonq36CKqnKLcIJEe6UgNmXdCfOkvfyXmQ3MTdgcRqYNRE30//ywF?=
 =?us-ascii?Q?ofaQWwfrRj5M/DmZVz3US46p3r/yHyNXd0kvqIrsjXULzbnMXVIb+vQ6nxhn?=
 =?us-ascii?Q?ECFYO4CqfMMub0Ce6EvLJio4gT9deNsHcYTqPK3mogYRl4sQI3kQ55kkQw/W?=
 =?us-ascii?Q?Gqp9qzaUij4x6KfQ9VqI0/Iiiwd6SnIXCAMa0DYQ0cnc2CgqyDpxv9PqDD71?=
 =?us-ascii?Q?SdnzzBwGTDoqpyfNite1YS9UHneeJo7eJcCGFFIFSRdwgnzSoCLihNw1ZbX6?=
 =?us-ascii?Q?aOS9fCRk106irJ3ELVD2WInHWKUtkQbRdgP89pIdIi2TofV7aCYealB8uUTV?=
 =?us-ascii?Q?RnFA4zIi4NG7JOWIAA3qhnG4G4ikPkpAbsKj/FtRk9s2suHYYptMoL1KzIkZ?=
 =?us-ascii?Q?ymeeyjvq0mEYC0zun+VlZStRf0w2KheP0vCO+4RuC2TCjNgtGDG+oDPN0Pvf?=
 =?us-ascii?Q?016/Is/FQKYk/QkU4ebpcE/Dee7Ti+rzIMPdi1T3Lw18v27cw94UyAABp4B7?=
 =?us-ascii?Q?aYJRclKFiRwR92xuh5sn+f2SRXP/P6M1aMgSKmSE5zbo0DDTD2Ya3e9gkaf+?=
 =?us-ascii?Q?J1fa2KDhj11uPKyBsgncbnKyNDe2WMq8E/EN06Onol9Kq5PQxKsWQR2YUs3O?=
 =?us-ascii?Q?0sIhhrO96kAExbpXjReEYkFcdC7lXWL7iqr1iYAnBR5Tjwwg+9vSSAivc2yK?=
 =?us-ascii?Q?dkg4b7a/PeMqorhL1FVuXgXBROFmY1qElY+JnMFrmt43Owvl+PQODiUrx9iH?=
 =?us-ascii?Q?dq6g759E8092+eBTqenQoSlkS5WWu8cnNNr4i9g4z0OBGwDjM3YyFzEdRKqb?=
 =?us-ascii?Q?Yb6U+NW1DbSrNEnibytNZPULCWOJJzD7Je2IQSF9F5jwigU7hiFIBe7NaxLE?=
 =?us-ascii?Q?Wx+si130nwcLLRsuCsJzOpEL5L4WnXD9YteMwqWFHXRq9iFm7odjHDD54reX?=
 =?us-ascii?Q?EYoOs0Ctm0sRSG0pvMb0W+mQZFOuHjcfL8EvbHg1AW0Ynhd+jnBG67FI7Mp9?=
 =?us-ascii?Q?le8dDy65TazuX8UQfpuyuWyij1E0FeNCcotKvTLcFS3Ewom6z/gRAqqtCYLa?=
 =?us-ascii?Q?v/haEpjOAy6w5Y+vQGlyIDA5KM56cQQ+6KPHaz9CPNKRZ9CwvysYnWayiliQ?=
 =?us-ascii?Q?uM9Dnu226ysonEY/6LAXxo03awcEWb/yMtXPIBL+GpMTzJAM9lpFD6B1JOJV?=
 =?us-ascii?Q?rxhWHJUPjZiaVfoTboVILfhJK9rWcZPBK0tMU2kN+4ztuE/62q6S17oqQG5d?=
 =?us-ascii?Q?ab+ZWDQbVUlwL4X0q6EUuvQTcM87QfiAmZC/Id9mpyULy7AAeorjgbQ7uEz5?=
 =?us-ascii?Q?cfqrmtWF8vslVCJvO1XBW7UWGUlSbulViJr61Dv7b9lwdsnHOZzdkm033uSK?=
 =?us-ascii?Q?pax0n2gw4Ym11FYC4Yc5BT37A4ZSu2bpiH+uYgWWeOntZgTAsZhYVck/VT4N?=
 =?us-ascii?Q?xgQNqBD1WbZ+n8wqx7+3on75ip6wM3N29cO0L1pwRaIZf8V4H7hjlgRkKQCt?=
 =?us-ascii?Q?COgEmTozWUVSjX4wck8wYFhjaQ7nxegdeDaFFo+HFqNRoxPDrOnKIqKuW+60?=
 =?us-ascii?Q?Um0BO5VIxPVDqMUACdLgI5A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JCLf7JJvxzwDmA3Ii3NZQhi/n048VoaSVnnDNXsMJFojokWTUkF408iPVv+zT7hrSMEcSIAcY+RHOIsKKZtJUZ6k+fcE/jPAR2iurCbuU0k93wwgY4Tclzt5WsSiGKr4lOhl9mwo4kpzKiuljTXZmb+x/eWM9/0wfWr6MNhqoMzwmynF7VU6AwwaaBO8vyLiUbns5vRJ/w9N/E5u+/7F8u46aqEYIQcZbD8uuPLQbSmD+t4MNpccqvJS7yN/RQjXrZB6HytXulzHBOa4BBJHHnen+zxEqhBRLX61gqezQtbQaYl4IH4kBzHlCK0wBiY9IHClkg6vF0nLkv+jNPGnf3PaDqkvh0lc15mBp+PeRcMTUopdTnpNjOrcE5UXHsM8YBSyr0OZmIZ/JfSy9xE5AhBmLa/K4WyjYhChbDeehesHxvJLBCSsLK48x6CiCbG0Kv6K9/3eebMcXa2qK2Hq/ggc4V3jUbgahWc28fQJNv6b5hjWoFYHojFOvl0YgAzKXT2ENqXeq1ZCG3+4SQJwrNQjgboUsdXmQ5x+Myn0lExpSWKYeAMGOEYDy+wAL9ByO/utkPDpI7NtaRl/yzX5jeBfnXYInveEcNhHobJidq4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0a0ec2-63f3-4b72-b7ed-08dc28a67b45
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 13:04:28.1986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0C2xuwiSwPVY0yB6lrgUTLjB/ErTMz/4Ka1RFs5SpI5Gd1RlkGxz0TPi0pUn1de/cm57/fSoJBJ1bygInCfTOWifnDfevSmnlpfKxy8TMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_04,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080069
X-Proofpoint-ORIG-GUID: elmLenCuQH79mRFSe4tOJaYu0P0suvAv
X-Proofpoint-GUID: elmLenCuQH79mRFSe4tOJaYu0P0suvAv

--=-=-=
Content-Type: text/plain


Hi everyone,

This is a patch to make CORE builtin macros work with builtin
implementation within GCC.

Looking forward to your comments.

Regards,
Cupertino


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-libbpf-add-support-to-GCC-in-CORE-macro-definitions.patch

From c1a3a09c5949363a888f6159fa3cc16650e61c07 Mon Sep 17 00:00:00 2001
From: Cupertino Miranda <cupertino.miranda@oracle.com>
Date: Wed, 7 Feb 2024 15:01:03 +0000
Subject: [PATCH] libbpf: add support to GCC in CORE macro definitions

Due to internal differences between LLVM and GCC the current
implementation for the CO-RE macros does not fit GCC parser, as it will
optimize those expressions even before those would be accessible by the
BPF backend.

As examples, the following would be optimized out with the original
definitions:
  - As enums are converted to their integer representation during
  parsing, the IR would not know how to distinguish an integer
  constant from an actual enum value.
  - Types need to be kept as temporary variables, as the existing type
  casts of the 0 address (as expanded for LLVM), are optimized away by
  the GCC C parser, never really reaching GCCs IR.

Although, the macros appear to add extra complexity, the expanded code
is removed from the compilation flow very early in the compilation
process, not really affecting the quality of the generated assembly.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
---
 tools/lib/bpf/bpf_core_read.h | 46 ++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
index 0d3e88bd7d5f..074f1f4e4d2b 100644
--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -81,6 +81,23 @@ enum bpf_enum_value_kind {
 	val;								      \
 })
 
+/* Differentiator between compilers builtin implementations. This is a
+ * requirement due to the compiler parsing differences where GCC optimizes
+ * early in parsing those constructs of type pointers to the builtin specific
+ * type, resulting in not being possible to collect the required type
+ * information in the builtin expansion.
+ */
+#ifdef __clang__
+#define bpf_type_for_compiler(type) ((typeof(type) *) 0)
+#else
+#define COMPOSE_VAR(t, s) t##s
+#define bpf_type_for_compiler1(type, NR) ({ \
+	extern  typeof(type) *COMPOSE_VAR(bpf_type_tmp_, NR); \
+	COMPOSE_VAR(bpf_type_tmp_, NR); \
+})
+#define bpf_type_for_compiler(type) bpf_type_for_compiler1(type, __COUNTER__)
+#endif
+
 /*
  * Extract bitfield, identified by s->field, and return its value as u64.
  * This version of macro is using direct memory reads and should be used from
@@ -145,8 +162,13 @@ enum bpf_enum_value_kind {
 	}								\
 })
 
+#ifdef __clang__
 #define ___bpf_field_ref1(field)	(field)
-#define ___bpf_field_ref2(type, field)	(((typeof(type) *)0)->field)
+#define ___bpf_field_ref2(type, field)	(bpf_type_for_compiler(type)->field)
+#else
+#define ___bpf_field_ref1(field)	(&(field))
+#define ___bpf_field_ref2(type, field)	(&(bpf_type_for_compiler(type)->field))
+#endif
 #define ___bpf_field_ref(args...)					    \
 	___bpf_apply(___bpf_field_ref, ___bpf_narg(args))(args)
 
@@ -196,7 +218,7 @@ enum bpf_enum_value_kind {
  * BTF. Always succeeds.
  */
 #define bpf_core_type_id_local(type)					    \
-	__builtin_btf_type_id(*(typeof(type) *)0, BPF_TYPE_ID_LOCAL)
+	__builtin_btf_type_id(*bpf_type_for_compiler(type), BPF_TYPE_ID_LOCAL)
 
 /*
  * Convenience macro to get BTF type ID of a target kernel's type that matches
@@ -206,7 +228,7 @@ enum bpf_enum_value_kind {
  *    - 0, if no matching type was found in a target kernel BTF.
  */
 #define bpf_core_type_id_kernel(type)					    \
-	__builtin_btf_type_id(*(typeof(type) *)0, BPF_TYPE_ID_TARGET)
+	__builtin_btf_type_id(*bpf_type_for_compiler(type), BPF_TYPE_ID_TARGET)
 
 /*
  * Convenience macro to check that provided named type
@@ -216,7 +238,7 @@ enum bpf_enum_value_kind {
  *    0, if no matching type is found.
  */
 #define bpf_core_type_exists(type)					    \
-	__builtin_preserve_type_info(*(typeof(type) *)0, BPF_TYPE_EXISTS)
+	__builtin_preserve_type_info(*bpf_type_for_compiler(type), BPF_TYPE_EXISTS)
 
 /*
  * Convenience macro to check that provided named type
@@ -226,7 +248,7 @@ enum bpf_enum_value_kind {
  *    0, if the type does not match any in the target kernel
  */
 #define bpf_core_type_matches(type)					    \
-	__builtin_preserve_type_info(*(typeof(type) *)0, BPF_TYPE_MATCHES)
+	__builtin_preserve_type_info(*bpf_type_for_compiler(type), BPF_TYPE_MATCHES)
 
 /*
  * Convenience macro to get the byte size of a provided named type
@@ -236,7 +258,7 @@ enum bpf_enum_value_kind {
  *    0, if no matching type is found.
  */
 #define bpf_core_type_size(type)					    \
-	__builtin_preserve_type_info(*(typeof(type) *)0, BPF_TYPE_SIZE)
+	__builtin_preserve_type_info(*bpf_type_for_compiler(type), BPF_TYPE_SIZE)
 
 /*
  * Convenience macro to check that provided enumerator value is defined in
@@ -246,8 +268,14 @@ enum bpf_enum_value_kind {
  *    kernel's BTF;
  *    0, if no matching enum and/or enum value within that enum is found.
  */
+#ifdef __clang__
 #define bpf_core_enum_value_exists(enum_type, enum_value)		    \
 	__builtin_preserve_enum_value(*(typeof(enum_type) *)enum_value, BPF_ENUMVAL_EXISTS)
+#else
+#define bpf_core_enum_value_exists(enum_type, enum_value)		    \
+	__builtin_preserve_enum_value(bpf_type_for_compiler(enum_type), \
+				      enum_value, BPF_ENUMVAL_EXISTS)
+#endif
 
 /*
  * Convenience macro to get the integer value of an enumerator value in
@@ -257,8 +285,14 @@ enum bpf_enum_value_kind {
  *    present in target kernel's BTF;
  *    0, if no matching enum and/or enum value within that enum is found.
  */
+#ifdef __clang__
 #define bpf_core_enum_value(enum_type, enum_value)			    \
 	__builtin_preserve_enum_value(*(typeof(enum_type) *)enum_value, BPF_ENUMVAL_VALUE)
+#else
+#define bpf_core_enum_value(enum_type, enum_value)			    \
+	__builtin_preserve_enum_value(bpf_type_for_compiler(enum_type), \
+				      enum_value, BPF_ENUMVAL_VALUE)
+#endif
 
 /*
  * bpf_core_read() abstracts away bpf_probe_read_kernel() call and captures
-- 
2.39.2


--=-=-=--

