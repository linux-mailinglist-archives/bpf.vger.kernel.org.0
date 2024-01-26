Return-Path: <bpf+bounces-20422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7199283E1F2
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 19:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC40C1F24056
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EB52137E;
	Fri, 26 Jan 2024 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AzUZjlQa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="enrlRq/x"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E2208BE
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295083; cv=fail; b=eAURspRIoq+ofPHHfsAe2CMahTlKfeZDsBxAFzmuIQTA1J3fqz35DG25oxv8r40Iiu//tvkqEQc/Hfcq8MuNO+uDNWs+VMN0/7IKNJtxbeWL2/NtXvezg4LgPp90TMGTO5nPBAcGbSkRLnW2bwwK53X7ErQ5H0yVVa5YxB6IECU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295083; c=relaxed/simple;
	bh=0wCp9EPIIxCtv0wj8Dz+gopIYLT3utAMQeRHY4Y7yo0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h+Lz7bFSsLBcEqgrZtHLi/LZDspU6S0vB3A2lyYmw3cizQITpEfwk9STtfLp0jXUMA3Xl1o/X+froy4SKA/I9JRCYlOqNH2VrN8lMlyCE2IqPTelx9s4SwZGNXF+v3Qv6VHhtfcVnzXJwoXm66QN8jqj6KkbeJB+7j9Hl+Aorc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AzUZjlQa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=enrlRq/x; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40QEioC2000569;
	Fri, 26 Jan 2024 18:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=iBrs4zKX13MKwXkbZl9/jhB3JF0bOx4J4v1AHHftBr8=;
 b=AzUZjlQawhSVoOJEam/tfwwhRVJY2sUK6TGR9UJvT24rUQRhmKbAiWeSuA97Amn111vm
 fvehB4kbrZ9dJRGUAznys1j6zshL59xvCT6fmtLA3z8LUUakUalpdo91BHOoSsWuBHqB
 7YFjXNHyhJux5PODg7fd8UIWcyLu8U1KYdjDr79k83KSC42kVST/qsL8xG24Z1v53ODd
 /HWumh7xFFg0pnmNczjkNFsyJl8J59xAVUoCCUsqmcjYlUi94q7tFVnhKjoXUaOwctYq
 Q4YMPvhwiwdgo5C7yc8hJOYqXA4A4ljohO3tjscW8g2YQ41jpJSoZzLEggB6ReKC7QyI WQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ap2p54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 18:51:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40QHoCGI011769;
	Fri, 26 Jan 2024 18:51:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs327rswe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 18:51:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOLOYEXo7DJJY/xrvI0my4eqlRrcH91TRn5GZdMbl15yCN0hzvZZxgUNG3kXASK4JjrIcULXews+IsxdanLAI4z3XPDpt0ccYiyBAg8ZVB709ScFVcMx4xoqkahP5TR4wTS+60jUu+XW3kbRBLSzAQQj85E4nFDRRKyZjT9fT3P3U1dXrZf5egzXKzKP4TBhl/jjmOn/imkVXp0sSDje3ranyKlX9UIRkkWX7hlpix8klVT8Hfnkuc7CVf/KhaPA037oqlh2vYSVSztpwPDsvxW3LJyjSN2VA9ggS71WOsI1H1xho8AkzpVrjAMDIKI9bty/8O+G2XxEcSUMzuOlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBrs4zKX13MKwXkbZl9/jhB3JF0bOx4J4v1AHHftBr8=;
 b=ft1vw9qeC4hF6JfOec391AB80+IjBPErAfBiZ9t3CCY+rs3WMqnmW5YLnfLJxr+DuBoYnfHvYdddGsSFYP2EeGnfzEPyGJR673frVsqeo+vML02wJ3vqQhtDdFZnTITwuMShF2nw8dTK6LrQ+yZQkL3BMIq6tFhPLW2skE+JFQrvqms61ATZfbpvKOJG5rNRM+PXuNVBwe8JLjr9edwFHi26FnsNM/IjOUrUdRoc7xyrNA7iYtZWqS1GPfqVgHYJ0mGWqo6mmUdlcwyR8+LOeS/HBfqc7F9YwnaqKyRQXRdJgdQTz4k/v3mMr7kGxqJUg/xmcMwQCvHzI6BukoSRhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBrs4zKX13MKwXkbZl9/jhB3JF0bOx4J4v1AHHftBr8=;
 b=enrlRq/xRgNj1tftoareYrRER8VUqYcGrl4SlScIdCvt5v+5Dg6UTiOFT4QrMwpj0vIKVscu30kmh+w2xj8zEbEOVLaL64aLwouh3f/zS0CUMM+zTawxy28EQh1ipAGZK3/yJVYQwrw7ClbE71kTfM/X+K/W5O9g2Z5fHhLTz4Q=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BL3PR10MB6210.namprd10.prod.outlook.com (2603:10b6:208:3be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 18:51:11 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 18:51:09 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: [PATCH] bpf: use -Wno-error in certain tests when building with GCC
Date: Fri, 26 Jan 2024 19:50:59 +0100
Message-Id: <20240126185059.4376-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:208:1::42) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BL3PR10MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 4abfe8f7-c271-467b-dace-08dc1e9fc26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jMHqtOiS6Pv7/6fSlaSGDJ/3tlmdXszhgaQBQKzH5WF+mcSuK/7loFL/k9rxWACRtEno0hZkUvTFuEaxnpwanQFNdIThJpwxwda9bFFaNiAqrQUmy2XCHoZj4b7yzL8ZHkPBJDXf1gy6J3OcpkKopmF/IQWppppgK15q/2Gcu3Tk4smtHJqqH86SQwjEgamAGQmkMwenz0vkUqsmAI0BLPwJiZYEtQNNq2jzCEn31qIPWv/N/1QbNCXqtbc8InwD/O0qcFzQ7QgO/G4+KBiPtXC8SW59Az0ckw2asg/aGgBw9rV9qyJqG7MyyvlD5mjBVzRp6n93r5sbqivJ5YvAH3SvrzAU6pvBSMdeQfJmvaRuc8ouPTSn4gjynXdoRTUsBqZge0SWuGibUdqPO849q5P/KwBNCcpjwQ1dcWAJNnAWXwuBS9WbxUqIC3qXRF7UrEjLCoZT8UXw7Y7PV7C04aETAIN7B6t6cckoTX7J582h5ZHiWBVcukg0oL3Akzf6XLrcqKj67YB9hMl5EC7froftJE9MLjEskYJHFoL26ztI7usqyy8UXuyEKLz6tqVT36jOVN3zVQ3fGdl253xcZ1S3HpuOSG7/gCmc8lZgH5DzXkKAuy2dqa0bBpdOpkwH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(6666004)(6506007)(2616005)(1076003)(54906003)(6916009)(316002)(66946007)(66556008)(66476007)(5660300002)(83380400001)(107886003)(38100700002)(26005)(6486002)(478600001)(8936002)(6512007)(4326008)(8676002)(2906002)(86362001)(66899024)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oqICSltFqEizn/1eAepZOOkl4VwIwqX0RtduW9/CU6Cu4svvglOOsWVn+WuY?=
 =?us-ascii?Q?mKxDT0pMpUrD6WU1UFAlt21Wfv356v46hqiKXt2rqcGpq4MTPmh4CwBRx5za?=
 =?us-ascii?Q?FaZJcxsjWoqlvanwFD8dNWwMq/CAjnlzyUTmUxsXAePuAE6KDioJPxBS87se?=
 =?us-ascii?Q?Fao9Ea+GEkyPClrldOL03J+uNgz3O8/7rptegbiQoJjuYCyxmI3uJcphCyIv?=
 =?us-ascii?Q?kv7/FN/I00F+cLqV/UX2hE8Juy10e4mcApK1o98H3d6CAeOMWwJ/SnddVkbw?=
 =?us-ascii?Q?GjUqIioiv59eQ+BhB4fZ7/waaA04EqJvxnaCE50TBybelJbjOOGlhFLdKkSE?=
 =?us-ascii?Q?P32WuDoMiRh/fF9xOZM8bTTqC2uaqlMnCACTqDoXQidO6rVjy6hYowGTeAdu?=
 =?us-ascii?Q?fmA92d1XAW1RYEMOSp8PwzTHL78uKNl/gQWQr9gSvqC2ozJeAuMxlUC5fSHy?=
 =?us-ascii?Q?3NXpV5oNBXCCZRp3JrbGwo32c/2IjDHOZdKvrxl3pt4g+YwQmCv68gP9nqyl?=
 =?us-ascii?Q?qH+bglfDuihUFnaW0DZZY4mr/p/fxtqf3/nsXhjd/IrPKNweFwg3+CLFHU7v?=
 =?us-ascii?Q?N5vy4rfT3sZ3OCQFR5l8Dn9QtJWoIQU+2wKuSlNtXN16tns+Dr3WPktUhRIQ?=
 =?us-ascii?Q?aIJ+JNYwuvheAUC8kTqPZjJbEjjWD7HwVK2xVVCmLDhvI3lwjEe5k5+m+cMX?=
 =?us-ascii?Q?R3VLK+TX16aDKT428Wmog5VGNyA+EOyCWpgdvmJcf2iA2USqGjXCAwotB5o4?=
 =?us-ascii?Q?q+KPauQJ3X8RFexVyZE31GTEiK55kUTlutXj6aSp9P9yMQxO3CpZDAavKOOD?=
 =?us-ascii?Q?L/TRe9Ny8EMfXKZuhlT2rbuxkscB6ZFEJa+oZekjjBZIH0q7cIZLmYakISu9?=
 =?us-ascii?Q?0erYb9/Anjr0dh06nRMRTbaCdNU6PmANkV6SpIfjxTR1bhDIXwlOtWRO0d1K?=
 =?us-ascii?Q?uP3W7kfPjsBqhHL8LEdX5z2oHRXs59/3iAMfR2BwwZtlYEtCIN/gvBnsV0Un?=
 =?us-ascii?Q?W8OIlL5+jPDYlyObx5nkrYCs/YXCCch2fWNi+SlgkbMG+gDUDc6/kHTc36Fv?=
 =?us-ascii?Q?SXCKIWYaGhT8/nwHnby12Zrth/2KgkX7KvghEak4XRPE1caqcITaBXm4pl+K?=
 =?us-ascii?Q?IFWmw/dK2ymHgwinhjcPH4xVuTeTwBM8ALXp/aquJumGzsMUu0CaqrrAH6NK?=
 =?us-ascii?Q?Hy+bVPBN61DaOIvsFbYXVKqCoFYXOQMmQQoonbZK8MQtrW1yvFcDXvSH6Gbq?=
 =?us-ascii?Q?uE/bowiH/o3MwDlAAVgKAFyVr8xkUklgFTScZxG42x38WpnukmQWGkl9PVrT?=
 =?us-ascii?Q?nDtpIRWI4vOW/o/ti1jwIOFA7Oc38xBC2x+mlXq1ptzlMRYbx4PspqTwsH4t?=
 =?us-ascii?Q?u+sW8/oAJ1xy17FuVGMN6j8Mg9zWV9UeURPJUq0QVAdCb49mDI3p+B+tkypq?=
 =?us-ascii?Q?Ls5Trh93Dgb92hKm1/xKPfRX0IKTrM19CEUEBB1ZB8b69t3ZIpSoCGqEvQ2j?=
 =?us-ascii?Q?fzx3Q8Th7LfKlPwbnubGOltoK0w4Pq9r25HAtSfcgsko3Aq6h45Q4m3wXAq+?=
 =?us-ascii?Q?+hx93mlTIWeMdoB8nfKTcch7XVwFDXU4QpsaERvUey7uErhsvMPd5m0izTlU?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0Rm8Vaees1/bqvLSpCXogfhFdu4yzIrYU9smoQP4xqKy52m+pqQVw1RpnF9oSTloy7EiXLEcNqzg8oZs1Pu5zBcmxsd+cVX6nj+yA5Sf7A0P+WLV2DSKO1GqZlaFx/4vevm8HcEsJ3bENcuB64/+5b5Rc0QQWKMcCQ7IPBuuj3WTRLorok963Gf+kyCfbseshUELBi45y+BxnSSv4wHXh+/2tdDWrD/blrO8YbPtYNKAQ+cHmyl1Ikr9MmMt+NQTJXYu+F/3ffgjm3EojlNJneP0Fzgy+ZcSKfisSjvJFshfEM3SC6wMt24anCgPkZ3kz0XHPGsxx14RGGNE82HECuE/kigTcgxvljKDs0BKpkJc/fY+2mUYFLkX8ENszb5qsRTgvI4f5KGSR7miiXV7O6S5KI74kl1vUT2S+lHeoq2m/6c97w4ePfx5Rnc1QiwdsN0DqMGM7QzKSdf3dXLJO+gazOwfrjezdSzvmlZPlS7c6tJjo5kR2eAERmRpt0KIe8l0n4ZMmd06u8Rpn/8DFg9Afd5GQC9iipZ57/bjhEl9x/jjTBtYgynZs8+MZ48qzhUtUEFRMi9b6zgp2UPkWEU95+Toqmzp47z0J++udts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4abfe8f7-c271-467b-dace-08dc1e9fc26e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:51:09.2686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJmtwp4kSNw3s76GxLG3w4UCKUoY/PE/vlsrLVfkk/H2/LeaHw4fx8+HpwSPk0gX+SPVC9fyjtzbKOK5x//YYjduzuGOTzAO9NOu1rAiK1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401260138
X-Proofpoint-GUID: 9uUA3EJsyWCIxlGWIDvVO_XND3JxqVdH
X-Proofpoint-ORIG-GUID: 9uUA3EJsyWCIxlGWIDvVO_XND3JxqVdH

Certain BPF selftests contain code that, albeit being legal C, trigger
warnings in GCC that cannot be disabled.  This is the case for example
for the tests

  progs/btf_dump_test_case_bitfields.c
  progs/btf_dump_test_case_namespacing.c
  progs/btf_dump_test_case_packing.c
  progs/btf_dump_test_case_padding.c
  progs/btf_dump_test_case_syntax.c

which contain struct type declarations inside function parameter
lists.  This is problematic, because:

- The BPF selftests are built with -Werror.

- The Clang and GCC compilers sometimes differ when it comes to handle
  warnings.  in the handling of warnings.  One compiler may emit
  warnings for code that the other compiles compiles silently, and one
  compiler may offer the possibility to disable certain warnings, while
  the other doesn't.

In order to overcome this problem, this patch modifies the
tools/testing/selftests/bpf/Makefile in order to:

1. Enable the possibility of specifing per-source-file extra CFLAGS.
   This is done by defining a make variable like:

   <source-filename>-CFLAGS := <whateverflags>

   And then modifying the proper Make rule in order to use these flags
   when compiling <source-filename>.

2. Use the mechanism above to add -Wno-error to CFLAGS for the
   following selftests:

   progs/btf_dump_test_case_bitfields.c
   progs/btf_dump_test_case_namespacing.c
   progs/btf_dump_test_case_packing.c
   progs/btf_dump_test_case_padding.c
   progs/btf_dump_test_case_syntax.c

   Note the corresponding -CFLAGS variables for these files are
   defined only if the selftests are being built with GCC.

Note that, while compiler pragmas can generally be used to disable
particular warnings per file, this 1) is only possible for warning
that actually can be disabled in the command line, i.e. that have
-Wno-FOO options, and 2) doesn't apply to -Wno-error.

Tested in bpf-next master branch.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/testing/selftests/bpf/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fd15017ed3b1..8c4282766976 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -64,6 +64,15 @@ TEST_INST_SUBDIRS := no_alu32
 ifneq ($(BPF_GCC),)
 TEST_GEN_PROGS += test_progs-bpf_gcc
 TEST_INST_SUBDIRS += bpf_gcc
+
+# The following tests contain C code that, although technically legal,
+# triggers GCC warnings that cannot be disabled: declaration of
+# anonymous struct types in function parameter lists.
+progs/btf_dump_test_case_bitfields.c-CFLAGS := -Wno-error
+progs/btf_dump_test_case_namespacing.c-CFLAGS := -Wno-error
+progs/btf_dump_test_case_packing.c-CFLAGS := -Wno-error
+progs/btf_dump_test_case_padding.c-CFLAGS := -Wno-error
+progs/btf_dump_test_case_syntax.c-CFLAGS := -Wno-error
 endif
 
 ifneq ($(CLANG_CPUV4),)
@@ -504,7 +513,8 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 		     $(wildcard $(BPFDIR)/*.bpf.h)			\
 		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
 	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
-					  $(TRUNNER_BPF_CFLAGS))
+					  $(TRUNNER_BPF_CFLAGS)         \
+					  $$(if $$($$<-CFLAGS),$$($$<-CFLAGS)))
 
 $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-- 
2.30.2


