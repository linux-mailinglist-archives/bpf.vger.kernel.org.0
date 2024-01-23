Return-Path: <bpf+bounces-20107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3C839913
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3D82963D7
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 19:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633BF1292F6;
	Tue, 23 Jan 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F8O0MF42";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ds4LrWM1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426A1292E9
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 19:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036428; cv=fail; b=jiYqYzIDN8ftHFVlBeugvixNs0wrE/b9LbdxmtzEW/0HV0JET+AEDrY8GchcfhRXW9ykIAErNki1v74Od0rNoLOxK/eOHW41jPGYJ2FR0RSD7nULEJvZLVW5RloLNVd62bkabD24B9cH36bkHHnD6l0E+TdPQt8KSsjBrN9hfaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036428; c=relaxed/simple;
	bh=3JZmKIr9ucZchAeyEmkBNVG1gedhhlIrpLSTOQLt80s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s5Um+gkkSQb5IPRgxTT+ky60rG1xy77J3IQue+Mb8ORqCgv54wxyi0andK/YNM/EbEgcRdmaBGzSvog5863cn8KCeLRpZjaDAp9fckTcLZeyVLKiZBFC0oPXYOB7gmoxp8BvIhc449hjR171A3P/Zcq3p/bS7Q7kscgY6ag4Sgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F8O0MF42; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ds4LrWM1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NGRT2x011663;
	Tue, 23 Jan 2024 19:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=oNTKRNbG5q1wLicXb7gkW+GEloxNmI0FdnA9CCXMSH8=;
 b=F8O0MF42TUJZHOX1RRZT2W1uiUuz1lqT1ZX337ezaEtY4gDZGa6TQR9BjyuHFgaBVmTt
 mxTKnpZsqusQk95ujW+G09WnP/e/ZzZcYzasJ+QI9LLj5pqEHDlfeU/sLAg5Wjkwbi0b
 Iv810wOsyeltoYrJlNeMWXJhbynROUAJV8+1TqWju3MQBCJLDeFzNjVC6f3gSi7b4Hr/
 0m+ehu5g+JrRKD+xlUuxz8bQrk28KZZxLVAekq3AeOsEOWzPSduJ5CW4e1X7UqqyEzV6
 /bUt1lmYYCBk8IMFoZ8DSxne+y30zCPHwqprHta4U6kWVs7m75wcrcgGTpdvuJ6oavap OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuq5u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 19:00:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40NHaPLp006132;
	Tue, 23 Jan 2024 19:00:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32r9ted-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jan 2024 19:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3vfK08ONaM1JTPcvrKw5+RZeXa+WX11KMQ6K2f6RgF0tCMzEIgmEsvra7KkpIKIw/UMi5QpRnw7hxkMcPDtpE9PHJcyiv4e0J2yqIbjRHymjmlwrDcI/ImtDaaNJsbVSxn4dvxIdM1rQEa2LhAsYGTOQ0czCdeiNtGHdsHHiO3KVFCzzzwDzTubclLLZrs7l7JKbeDQovkURopzbrKKdllFErWIPPUaN6LVvnVIXo1tD6W/SidEJ2ZDD484hAKpTOGk2QsdbtkEIFG4jdkJ+7K+0ozP/6lL4B2EeDr+GEASp9kiUqPjnAEZ2bGECvEgJ99q74bpHQ1cfazkLAYDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNTKRNbG5q1wLicXb7gkW+GEloxNmI0FdnA9CCXMSH8=;
 b=X8p/vEtl1BxbcKjtfzIwlyfYhmDzeyoC4axA28cIaJTzIuuKx3SBRiCyPKfaV4yg6blnOGDNrMOOdc4ne2UjUK93J+3gP+6kIIYdr/5WqLt6p0QZNDwEKlQw3mPQt278AxdpFiGNgXo2rfS6TwgFBVBUFwOpZQ55Jof2DD2JxmoEKMjIINf1D5dnNFn7MZdkgy5AT4AejGIE5SzhUExVaOwZCncPAgMz85dmkf+ir1mjyam7r7l5kjQcRAmA57o4Wnn++U3RZpQ+NAwJ2PM9H4Tm5emAGtfKGBFm9wwrJErod650DC5WLNG4kWy0qpauqrlu+TTpwU7rIWPGjka3Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNTKRNbG5q1wLicXb7gkW+GEloxNmI0FdnA9CCXMSH8=;
 b=Ds4LrWM1/oUEASz7jYFPJypdQXgm8QVbQ2ZGo6O4x4rheFc7XweqOgTwglJRXL/NHN+XEYXfoBfXNSK3FNc/Hu59fuD9td/aNtG1hjGvjxtEEdGovc5H2Ta+PIxhquaeGUCBTA6ufPgOpH0KtB4ivyhSyCyKPKrXUoFT9+Hak8Y=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DM6PR10MB4315.namprd10.prod.outlook.com (2603:10b6:5:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 19:00:12 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 19:00:12 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>, Eduard Zingerman <eddyz87@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: [PATCH] bpf_helpers.h: define bpf_tail_call_static when building with GCC
Date: Tue, 23 Jan 2024 19:59:45 +0100
Message-Id: <20240123185945.16005-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::8) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DM6PR10MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: c0992436-2835-49e4-468e-08dc1c45871d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	94QlArPwzD5l0pShujZVH+xtM5oip+PeZY0V3UIp7E9xBMa0mVslr8bZZOrmELJ/jehe5GFgF6bzHZZPe4CXvV8wx4HrP8bLo/yWmUjgYHo5GLeZEnI1ip2HQdoeIrycqz/Ln+ttqwM0fyDU2YteWtitXMGxNhJ4oH1VqKciqKbz5nSnvRjUKCVOdv0yE7xfLn4U36l87sk0CpjvSQTRmGGtdW3MVk1pOfZYD4aLw5pXiHblY8brjC9uIUs2Ym/NSTvHWmS8pTgnRJ+HZNEqcxaf1eF2jxEF3rM0RFtD004swVe0bTH+NVz3JS9mXmITxPhlVXR4/9G1fLeLR4V0Luq5cH4rPX7fu2XG0nYpWv2imYA6R1ZQ8AhnO4I0KQb9VYJL7twJfYwm+SF+g4Ddyla5n83eO1BN0ISAIr3D7Y/R3L3NryvBvPG3mNGtvYV34QncKOY9eUEog2/tUj9d9ImYpkep4+LQ3Hz0qXgmTXXT1QJQYoh3pOdkH2VRCTa32EJWVz8DpMkxGJ0j9H2P3g/Rhx3hCm/b/iMhs0LwBKph5CtcFQh5Pa09aP2007br
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(86362001)(478600001)(6486002)(36756003)(26005)(6916009)(6506007)(1076003)(2616005)(107886003)(83380400001)(8936002)(316002)(8676002)(6666004)(54906003)(2906002)(6512007)(4326008)(41300700001)(38100700002)(5660300002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JBS24693VNzXjpvPNYz4zxIx6AifYx9d387JykysUdYgAbGCZ2kb8fBjT8/e?=
 =?us-ascii?Q?jNtEGuRXVx2RecaxDKJs/ycyYCAwxCo5ftHaujl7zhuvfe1y4FuYe5cGw/MQ?=
 =?us-ascii?Q?OD1LHoqDNfGlW7jNmF/B1uM9rMNmuBPnvCoqLvkvDCWPUJ+YffHB0nHoaz8r?=
 =?us-ascii?Q?S5o+3ohtlx+kukhzYRNvGIZr3JPMYbk7U4dFv+BtKr2kotIlv9Afql3qWMzs?=
 =?us-ascii?Q?PeAwY+URrstfg+aBkoC8wajKlWxtZiuirLcO1H4yCNdmcZHysaq8hUYsO0bd?=
 =?us-ascii?Q?PT2ceqliAKDyRHZHzpPM4xVGcICFXLuIPLRlzcY6py8SmDkHOdsx4UjuYZfO?=
 =?us-ascii?Q?I7mYwwDzeiPQPwimImdErLXGno6RrDfzNdbfU2gt2I6V/aijatboeg/a5fAO?=
 =?us-ascii?Q?zMaZJrNKWLsvUwpVf0DB6apIkIPA4Hbs2SARk6Iv/lL4gcWzTX4TnxJNU5XE?=
 =?us-ascii?Q?cJCrt8lVn7UhKluNfnP+RA2zcPSZOpJNS8z/sHSoUfQueXF8Lb+I8R0JE/G9?=
 =?us-ascii?Q?B2pGpA/Thy2UPinC0k1apoiuqb77L0JB2IIc0pvHDJsUDjNWTX5POB/hOb5D?=
 =?us-ascii?Q?X8wRhTNSW+y+b6WasmnOd8UvHWyY5gg5qAkqjYNc15OXSFddTUcSvKgPBLDC?=
 =?us-ascii?Q?NpizDNx5H72CSwUsZ0kjdhB2pq1nNwyyHWKvHDo3chk5qHwPeR7xnr7c63p0?=
 =?us-ascii?Q?1tC/6SiNY+7WUuN/DTMxQZcpfvNLiiOEiDKxp9HhN1dSe6lIiOdGsbyfq8Ho?=
 =?us-ascii?Q?/VGM4vwsDuq5BIbxKRlATVuE5Loiid7TOLae2rza3UNkSQT19afk8iduMiUu?=
 =?us-ascii?Q?Pdo1bx3v4a2yShNDbRDicDIeLOnBouHA9eL6unXZuAoL2dn82abeEExChUEi?=
 =?us-ascii?Q?+xULrAZUV/uTQe83J+r+Xwb0pASsiGg3LqDNFmZ/gWzaU7K40xBdjpzEGv2r?=
 =?us-ascii?Q?P8ThMFi8T9gN4DRFiFQkwgI/fOoucnYyjP5eMuNRKZnwQ5JPzYJRxdyNKKdM?=
 =?us-ascii?Q?4Qwpirxp5vVo8our0/KGzucGV2XnlNyW70fm/oLpI5g0RSO8M0BIA1ju0OgQ?=
 =?us-ascii?Q?PY/syyLB6V6O/0g0xGUWLvh4ZNhmLL9ZoMWkHYeRS2kTL+TTSUuAl7C6W75p?=
 =?us-ascii?Q?vug0iqTplcqBPNOLtsLSQu+CJUyEC+81atcQf5wphcE0ZA5JQC2XK2zwyw99?=
 =?us-ascii?Q?JWuwGT8G8L33fGEIuS3aTsecc6ahOL2gIFi081ObJb1yhApsy210Hi4pIZgo?=
 =?us-ascii?Q?f7qaFZ/zGMzba49Eg9YsSEdp/Ds9yKbqoR1vd3q840WIvtia2eI+A8YOrz12?=
 =?us-ascii?Q?IpllEaQ3uPcuimLbthFKaA+Te67e3FAFCdJ76vWD4zk6mfEV7t1zX0F0+rfJ?=
 =?us-ascii?Q?vXb5J/j3k1wlW8p+bons3RJ2tk3/RiZCgzI5fHmCEoaXM5Wno7OHq6fZDmYh?=
 =?us-ascii?Q?a9uQkvJfEFQOcJru3qMdg7lcIWL6aLBo9b2q70T1XVk/E2Ukx5Vp6xmtEZQG?=
 =?us-ascii?Q?JFkmrPVTLMp5bmbxQDnWAz29KufH5zm2SM0mA291qAlEqwQR2IdXxuSPD5pa?=
 =?us-ascii?Q?7Q/3LCo6lJJu5QZ41vf4dwawk5QzeDlXcMkAIHY8ddCgAj7h0FWBhKKOE3R0?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7Goc4rEm3fhfkjj9FvumOsNLS8IbcuhPNpi39QujVesYawDCrLFJ5Vu2D9BDcEilJ/sUm8xSsFQBbF+sWSxLVludYg55NUHakxrJldE5PjR2ewPRbYC4sLCgKgWhL0OYVkktGF0KU8O3C+/X13Sc9UmUilDwYDEQBUTM409VwX7F9XIL5DzlUumgABwrL/Wx/Aau7eFycf1cZBb2KNMt2K9plK8fwDLlSJwO3WawIZA2UMs8grU/1w2ShY78Y/d9xvDXHTmvPIYb2fSvi9g5Wp2fun/LLTWGLhhk292YOkW3urD7FiV1mQEjZk5yUi0r1tV57HAcj8ANvwfpGIGd1h2VN2iGzxzCNtpS5AgPWqgBn44u+v0WIfa+jB571csmUei0opPoM3zVDP4pmTJEZwRKOKdKSp1bGoUFhOgrkpc9RbRkVYWyhzTj70DNvfW4YCrP8gxVOpMjxv51f/xT1aV5ics54i93SLQphxgkvX87umkhUyj2P8RbbU3IgBuxswouwPFh3sqV6/IOV/v8scaRCBm2uiWRLL6QR55ry8halfThMAO9ovU4nuyrCkBKQFjpjWI5yG5MBa5OD/vWKiPSlHJwKQFYdTWtemodR8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0992436-2835-49e4-468e-08dc1c45871d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 19:00:12.6820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fdQUzmeMT0/BBh65d3BhzF/8GzaJFbkoUAiiSeP6fYBNuXgzw90r8bk/zXn9IqcydTn1VvOvOtAGhVt12k40ARTMYD7vk62eKl0TD5+iCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401230141
X-Proofpoint-ORIG-GUID: G1zXWKYBHYA1qCWHm_MgBam1xLFoSaeK
X-Proofpoint-GUID: G1zXWKYBHYA1qCWHm_MgBam1xLFoSaeK

The definition of bpf_tail_call_static in tools/lib/bpf/bpf_helpers.h
is guarded by a preprocessor check to assure that clang is recent
enough to support it.  This patch updates the guard so the function is
compiled when using GCC as well.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/lib/bpf/bpf_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 2324cc42b017..3306f50c5081 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -136,7 +136,7 @@
 /*
  * Helper function to perform a tail call with a constant/immediate map slot.
  */
-#if __clang_major__ >= 8 && defined(__bpf__)
+#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)
 static __always_inline void
 bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 {
-- 
2.30.2


