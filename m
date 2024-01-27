Return-Path: <bpf+bounces-20493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641683EF91
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 19:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107041F23D68
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 18:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA992CCBA;
	Sat, 27 Jan 2024 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WLOVqPd/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nLPJN0Bi"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9572C1AF
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706381456; cv=fail; b=OHSRlsUpOjbflk3E8eSOZDA67FPV8q87ZdFlwb3ZlIcrnFyjCJNfK4rdwZ8R3HckWEHm59plSZYxwMvM4wf+qK1uvXYyboDevRCB/IuU9nrT0uDeGJxgDGIoe1zxzWrUNhKCGWOC6wqtHwMz6Ic70GHeCySKoPdeoxdWeP+XCC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706381456; c=relaxed/simple;
	bh=Fcy1xydwps0sYJHVXbiwT12EJHv/Q1e7Z8QO1kgHhOw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jbJReLJPxIUDrRz4tVOs3LCdypJHlR+45OeEonn5/tPBjcBKW3AoEimeNKsReLNFYrFKrjQIAZxEfDZr6G2tDRenqDqbmZK4jEDPnxgHJ9L7qxzydPqOBG+tQCwTejM1ml7OL4zsgbMQI75mJu8uvMH6oCca8JU8DMrhIPBiwlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WLOVqPd/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nLPJN0Bi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40R4eHQm027630;
	Sat, 27 Jan 2024 18:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=qaQqwE1yrCipuJuQK6DsZj28hKgBwRkV4VyHetjs23Q=;
 b=WLOVqPd/2oe5fQBg8TsKwRrr0MBqYynyREEtGk/+8JjcQ1oXGS9WpAosLyFEdupiT83P
 eXXFRvzgRabSVZuDQ8CsB1Uhcj/GxhQRgc2GyjkFM9xJ4KY+ieJihjHWkZsx4zHv8jf0
 so2MNWZEuIE3c4GqbmDaogwxfje4VvD+/xz8hb89gCDyn8gzBTDM/xiLbP673rlTSxyR
 D1Se1hXk6rhV/fEjhkcObxpc04Coq6kFjb/hP3dLtMkvNqV5pidjtMyqVwPKrtYurWMt
 AZ0u8uFUkLgGa/BdHhH7FhIyU5qY+ip/Sd3vrljPxNjW9qmDMUSVCCRgzweHS9BbMtmh cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcurspp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 18:50:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40RHBp9e014634;
	Sat, 27 Jan 2024 18:50:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr942bx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 18:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ1pq37DSUApc8F36qGlOKSlM+YSInyY6SXVkNfEnaDrigThfmml1yTiXkTYARDovJuKbTJMq/8zLV6QfEIjnyuwZ3gZnRKHszb3VgXdzuuIM7zHLvJJdiwA4cUrF6WDgBSDfXgZsAQgFPFfbUXqmNSguNcaRoAHTuw0lY4+jimCjHlOt1OrhWRkQPMWn6PEBFe+UpnZJjKnueA1VMHxOug9QbZCKSoDYx3MZJrXxV7LBeBxKvdNV8Ri35AaUlyQF+/fusSCEOZjBKZVj8SE3RkkikyrPoi2YgGl27Ejfo5uvzpmf6e1PEwV1CtDHIg/b+uHxPCE5cQFthFOtGIeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaQqwE1yrCipuJuQK6DsZj28hKgBwRkV4VyHetjs23Q=;
 b=Sjj6ugOR9vFhO+UyT/2o8zVVzGmPJ/hyx0gP2ftHRaOnBHoaa+8/QJgdKag8UTz+34GOaeKkm8z5Z7Wi32vdARET0R3m79RVAPEvO413MjV0nrX15/V3vwLTtOG9cQuTTTy6d/4Gq3mTM/0p90xTLFQRgckP3ExeJ9EmTesvwkzmeGr2jqaELuhCPG9w0OX1gPBGAgM5EtFEK0fo9IwMPVGhosq0M9klrRT1/rJQShUZXmWe9udBdJZc/Muapx3ipOrZvI8dM/UBxk+nAPiRbZwBsxLw1fXC/rwcWvoLzaSa8DA5YEgs/+1zWdc6MzE0HvvFLgsd4wwP/fil36uqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaQqwE1yrCipuJuQK6DsZj28hKgBwRkV4VyHetjs23Q=;
 b=nLPJN0BiP40AHb27QYx2EilaLIlSxfXcKIpjM4FDFSPXAkgwEhjWJC6l8WMrwNULXxUgjDmZh30MHErlDDp2q/ffuzrN4G8iXx9IqVwK6gWR2NXfXkHr1XsVKOx3WP2aFcHQR3ywcqx4m7DpERKssnzt4AUcTyTOv9c5xrRAaDU=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH0PR10MB4757.namprd10.prod.outlook.com (2603:10b6:510:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.29; Sat, 27 Jan
 2024 18:50:40 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 18:50:40 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        alexei.starovoitov@gmail.com, yonghong.song@linux.dev,
        eddyz87@gmail.com, cupertino.miranda@oracle.com,
        david.faust@oracle.com
Subject: [PATCH] bpf: generate const static pointers for kernel helpers
Date: Sat, 27 Jan 2024 19:50:31 +0100
Message-Id: <20240127185031.29854-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH0PR10MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6b7086-cda4-4a8a-7ead-08dc1f68dbb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dt8NsZ7XbAo4yrC9R6nYEp/CkbYrOWTqzpfR+hfk7i71Et8OUKgSaTME/G5ghNeJA9DYcyeG8XgtqsVaVk9d0MCU0AmoEwYHkSWiv+wh+eZYpTWM44UU4fpklpC1bdxXAcl1d0kq6DAeh6iKllEZiFcNjpHlp+/vLdzxKfW2urOK3nQeOUHylVUoNw1FIXgheiQiJPf0etNCcSP9mg6DSBAAcjiGq7IG6Nu00qBRI/Wl4ntosid6nhQS/7jVCS1yMRQ/biZrTW2gzIQGWi6x1DUOpc2ax+BBXu5N27R/CsSA+mBeHWjQ/4+fvgBH1RLBHYwiDNscKVCMITG/fxomiZzWoRiXq8MDJJxzIUfB10M0UxPZp1Dcqi9SsSgKpGbSADCRqW0QUe4DEh2tp0o+XGVC2nyZ5g4XsSbrTXMWjxMFz1KhLYtuijlqUnYDi8A4BlNbpHFpVJ55lv6XjxORGhXyyo4k8aafYzVr+EMGIUdI/beaEgzDkeVsjgqP+hu60vrXfXqVSwh9DGqkGml8QIPYrirB8KT60uPO2SquQyQ/PQ+6wj2G96yAF+WrQR+swHo4gBVDO/JDtOV+HCbe0QRtNu02FXniVZxpOJsXaW+1zoDPtWqaVss04YF+KfYM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(1076003)(26005)(6666004)(6506007)(6512007)(2616005)(107886003)(38100700002)(5660300002)(8936002)(8676002)(4326008)(41300700001)(2906002)(478600001)(6486002)(316002)(66476007)(6916009)(66556008)(66946007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wS1GRvPM0H3qC6tnQkmVP1qLq4VKArlwDbWVCXr8Ba1bWJBw+Qxb9MPdqvYO?=
 =?us-ascii?Q?X5sIivnSnW8r9mG49r7/DVr5Hb25Hryss1Htn2XNbVf8NJ+s7bsqeSNnkxyr?=
 =?us-ascii?Q?53EKMVRm3o8r0KpIrl8BQMr27OLEcA4cREgeD40X3VAwe3gHkAocUNUO68gF?=
 =?us-ascii?Q?KELbZdMK56NBZbfcHmMi4pHfxqesNquw/XDglJXZTWHXlgInmMILXwRDIaTt?=
 =?us-ascii?Q?D+N9di5PXquF/Q1qkUPfxGNfxzZLDF89lqKT2h+JIVzQf4WXOQzKql89jdcL?=
 =?us-ascii?Q?Kye12X4TxqmEUaa4YGIDshGAc+miOLdutEOoqEnDWhR8O1s72w28CsXETA0D?=
 =?us-ascii?Q?8BOoo1fuuoX8KBq1Zog4VgrEEetQJa8Av62RqGmnpfhCSc/BROZTcAmLvj1W?=
 =?us-ascii?Q?kqqsZAzPcP6bkglpBnKmXcUPeHbVBrxrMBomhB2FVvp/R9LW8TMZz0mf8VCm?=
 =?us-ascii?Q?ACLZnxvCM+egnjjbWIBQh5Uhlzbosck+N28Ay7Y6kKG++MeyoZokQkkcOp9k?=
 =?us-ascii?Q?FkTIprv/mzZifB6OQI+3Lmy3XO7kopuuIltXU0ovghAcbUZSNRtYMAZjZINy?=
 =?us-ascii?Q?+p1D31o9k0UFT2Zkh6IYYx6G+NchW3mcyHLpP2iNCa4nCLHwGlFHSIOxYm7u?=
 =?us-ascii?Q?0e1/7IRQMbgjUzRLuQ5GMKn/sQFT6ePZ/kx2qKY71FLSTVd4q3Fuffel2MTG?=
 =?us-ascii?Q?7vkimi/us/ovEksKbOXQLew2UUm5HES+gf0d1VLA3DJY69Ozld8GOHQ6KafZ?=
 =?us-ascii?Q?KMCfx7fiY8oQFWs02YxTRlIcAJoYR7fOhNnRdQW0xUosrSbD/lr2OGMthvws?=
 =?us-ascii?Q?aYSds8ldffz0LSZ5wcdCWFWROC0IzcVXCrx6kRst5SPPCVPLkEX7zaWlH7tS?=
 =?us-ascii?Q?UKfJZyEVS4Vj12+0UUzORKiEMpLqUYweCQvFy2v299bgWskMJdR9lZ5eh2Ba?=
 =?us-ascii?Q?683YdNNs/GQzSvoBt/QaZHsPY03dHQc2noL3MRd36n0pN3Z6yE7oqlrRId2x?=
 =?us-ascii?Q?ChjqEnRZ/4zjnhwJb1TcKbOJJJSMU1buIpmO5oxzjfxVnj2Mig1S0bXKE5oX?=
 =?us-ascii?Q?HcErj2N7S9vP3XdfE+xCN8xXWuXiRMpFFnJG6vC6Fyb6QPJ+UbML00+pkXP/?=
 =?us-ascii?Q?vsANrpnZM3BQ9Kl1FWZZT1FLT2SDxCd7chDgpFYJ4r7bhHSToPQatNPyxnd/?=
 =?us-ascii?Q?es/OSGq6Z15+FW6nhigKzoRxUSgaVCqnoXIJNqehz4LPCEgHpvyeisEF9cq0?=
 =?us-ascii?Q?npMq+Pej2ZM11kLOqMqFBwnuIV09yDGWnEni2j2xkQCZnvFfoT46b6urV+AA?=
 =?us-ascii?Q?skrt0t+k5WpSliWAZqgJ9JwsXzFvzZghZ6aQMgdorchuj3F5eUo+8GXArBA5?=
 =?us-ascii?Q?SH/w8wHtfgI5objWSEchhdHusi/80ovMdy+HdDBhEWhECPlW/s/8Qxo0aTb2?=
 =?us-ascii?Q?VgGZT7xzS+YI5HwrH/RwIjvvy7pfLULBgjsWuqS1RSG9vY7iMG1axtE4AyW9?=
 =?us-ascii?Q?xp2anSsv4+ky9ltfzGGQBTDSuYGM1zoG/0RWweXoToZ/6VzHsCI86EzuD4eS?=
 =?us-ascii?Q?PP8SH/X8Jz6Y7xHjxLfDMyszJk547UnAclaF3TTvgD9i8b7KZMeMjcPRVefA?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8/TdTsBRJwz+auOc7rnXEiBrqe+kc34CV/b0EHnO6rCLgAv2T+Xtq5532+ML4aSyRECK70s4Jy+Ge/5b/FCMqSSJhAuWEKbtdcLeO/PSPwWWP4/zCI0VkQh33vODzAT0Bt2jQXuydr8C18TOrS7e0o2nKZwPuKL2M3pRxitUztdI12RJz6zAdGMlMVeI7/vZ/69lVcAb6+5DlZ8WcjE7Df/IXy1SU8AQKoSrc8mtV4yZIXEEhAlZBBF5Y3sHCYhXZE+6E+5mcwyO8cEx1T6fAXPUA3DY2by2AKCe08HzaaCE0IY/I+SAcFKrzSiZl1Hwz85uRzYXOTj02WEiEaPoZwsc1cuBvK6utSsnV32lKQMCUIBsa81DGsh6rcMLdLt7WOwV2MOir+yktnyTkP08xOC3HONo2XuWjijjUDRUJRT/uvujbDSi8q7TWuR3cgL5+zertupEH3VbkeU/QlwRUJY3fZzgxTyQ+41b370mnB9saEBUmNo+TkCgR0LoTJ8zxfTlP3j9VjeXHkaGVQ2AJU6fTiuJDmUjZUvU9SkT4G8c5F9G9jT6qBiw73mb9vPfH1aeV7EHvQ4JL6uBmVqFOHr2Ih8HllgZs1asWdqKU/M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6b7086-cda4-4a8a-7ead-08dc1f68dbb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 18:50:40.3791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ggy1QD0Y1kwfUZgNXph57R/rJMPKHl3p/ogdwSGsoIfMM/cubmVpDGwNaisLaAuzJPbpXZxDDtRewhfqIRWwtUjVsbganOcwImKy1X2tdTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4757
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401270142
X-Proofpoint-ORIG-GUID: zXgGkEBbFcQBCr292_w0Z_dp_STpi3f5
X-Proofpoint-GUID: zXgGkEBbFcQBCr292_w0Z_dp_STpi3f5

The generated bpf_helper_defs.h file currently contains definitions
like this for the kernel helpers, which are static objects:

  static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;

These work well in both clang and GCC because both compilers do
constant propagation with -O1 and higher optimization, resulting in
`call 1' BPF instructions being generated, which are calls to kernel
helpers.

However, there is a discrepancy on how the -Wunused-variable
warning (activated by -Wall) is handled in these compilers:

- clang will not emit -Wunused-variable warnings for static variables
  defined in C header files, be them constant or not constant.

- GCC will not emit -Wunused-variable warnings for _constant_ static
  variables defined in header files, but it will emit warnings for
  non-constant static variables defined in header files.

There is no reason for these bpf_helpers_def.h pointers to not be
declared constant, and it is actually desirable to do so, since their
values are not to be changed.  So this patch modifies bpf_doc.py to
generate prototypes like:

  static void *(* const bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;

This allows GCC to not error while compiling BPF programs with `-Wall
-Werror', while still being able to detect and error on legitimate
unused variables in the program themselves.

This change doesn't impact the desired constant propagation in neither
Clang nor GCC with -O1 and higher.  On the contrary, being declared as
constant may increase the odds they get constant folded when
used/referred to in certain circumstances.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: alexei.starovoitov@gmail.com
Cc: yonghong.song@linux.dev
Cc: eddyz87@gmail.com
Cc: cupertino.miranda@oracle.com
Cc: david.faust@oracle.com
---
 scripts/bpf_doc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 61b7dddedc46..2b94749c99cc 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -827,7 +827,7 @@ class PrinterHelpers(Printer):
                 print(' *{}{}'.format(' \t' if line else '', line))
 
         print(' */')
-        print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
+        print('static %s %s(* const %s)(' % (self.map_type(proto['ret_type']),
                                       proto['ret_star'], proto['name']), end='')
         comma = ''
         for i, a in enumerate(proto['args']):
-- 
2.30.2


