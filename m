Return-Path: <bpf+bounces-21779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F93851F8C
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB422817C5
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF3E4CDE1;
	Mon, 12 Feb 2024 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IHzAf9py";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bBMF1420"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C14CB3D
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 21:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773303; cv=fail; b=krxkdVV58gjl3UqWQPIdAeP8st4lFGJyaUaQO97CAbD3ETcrrglVmvgwPY37C9dbmhj6EsSQMOqfZnEZt857mawStwIQSCxMtYKniWPpF4YWybF0gwRv8WGJcm6yivc8ANdOMxnBHC6gn0oqovsfMi89mvgsY4duBo3OryZq8Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773303; c=relaxed/simple;
	bh=r4J7IWpHdYOeiHcbLssulCPwXpDL3d26kkyUesqHJ/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=BGMEP6SpYlUpMDC54dijw/7/qoSIp3CwkdI3tplSUmB6sbyzaiKXn2XVllGJv8KMmt3u9slZm9CCpsUfZwifALj+bfTCAlvSn8+eHl5WZKd2jF8VPzc5FnrsSJfY/JlmoYsRQS106ojrct1TuzxdWtOxFeM2L6V5Dynw809OmbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IHzAf9py; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bBMF1420; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CLJU00018335;
	Mon, 12 Feb 2024 21:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=fwug0hbS8u9jvryXEXe9n+nVdC21gP05gSE3M+fF7mI=;
 b=IHzAf9py7iIRiAINajUKrnOfu8wZv9732Xr5BGAURVVYn/l7lvMg+ywUIX3N87y5sG9+
 KxQsNrV1DrZgI7QX/lzPLeKyrX4G8/ebXzlFKoYfAUWQ0S9fGFlaLt6tzwlQMUd9E6CJ
 UXYtvRQYJ3sz8I/s8XolGDQbYHKkwYKGskags9VHzzivpDWHWdbwathKM4rn1VY8RM2v
 Jzn1UD+yAY+6mVUyX/wcExA6qxUK4ldArLjr5Ft4bu8NcJKQD03xi+7AqFZCNJFoDzMP
 8AYmpIoaJdaKqZPTMceQo0ZgB3CQenY6uUQ3wsJs75ANg+P7L7s2f3WBONQYPLfOG8cq qQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7u53r0hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 21:28:12 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CLN8Vl000716;
	Mon, 12 Feb 2024 21:28:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6che6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 21:28:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPBH1VVdBDPULgu7ASxQRZ91+i6L6lRq1TVu5togUguL3dM3RfL9khkLjqqqCrCpfNo53Vwi2ftbAxenhWZoZ4ihoOGTF+G/IsNGKALdD/MSSHNNSv5XBif3NwlXywqsnF4T6dtiGzNxq60TtyBLbJx5G5PsyZtHlAaa9tt6LhN1qpkoA4SwBMqdWlL00wqmYRopSZq2P1dD5NbpL+78FDhiIbmcCERGNTd7cAePpMzkEwYrezX1qzxPJqF04/f+exnF1bu5XixEHgDuhwT70js8zPg1lRnDoZ/AQGPp2iEuzYVhCLkv3yK4xwX+Po+To8kQG5j4hU6hdYqZi1qtzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwug0hbS8u9jvryXEXe9n+nVdC21gP05gSE3M+fF7mI=;
 b=LOiIDiwhvOyx5xoUm1UozJqRm9V3D+3WQIXr4k2kBE8YqWyun+mplxll4F9gJFA8X+OJeWBndetDq7dFAyAKBDJOo7m5U+8FesdY/OYTgeXnuX9E0h078gWmxKJ6sS2MMa7SA0ZuvljRFH3WPLzIiyj+7QGQh0njCBRsYnAe89pJFL//ZstfGOo6h1gVFQPQplIggk2rjXriWl2I4O2Z+UO1wDHz3en6cIsz9uPikgRM+gdl7CeQ6dDLZ/H2slOZz8nUU5e0JaePDgjPg5rylFyciCG3ub67lrEakKQuBvgBU+unXmia0zxcavxII7xLYAh2UFPnbbhgykVfvn78Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwug0hbS8u9jvryXEXe9n+nVdC21gP05gSE3M+fF7mI=;
 b=bBMF1420vKVFcWwHM1YVV9oOZ/y5BtAz8ceQslc7AShCaH6JVqVL9VJIsBZk/LmoH0J+T6rFimyWGjpx+uAzs4g2/QVg2LiT6f3z7S2q6RXAShcudpe7UXHG2qYmBSdxxkG6R0Nc817jpldkeFE2XnKupAWwwIfBClnyT7b7sjk=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 21:28:09 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.036; Mon, 12 Feb 2024
 21:28:09 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next v2] bpf, docs: Add callx instructions in
 new conformance group
In-Reply-To: <20240212211310.8282-1-dthaler1968@gmail.com> (Dave Thaler's
	message of "Mon, 12 Feb 2024 13:13:10 -0800")
References: <20240212211310.8282-1-dthaler1968@gmail.com>
Date: Mon, 12 Feb 2024 22:28:05 +0100
Message-ID: <87le7ptlsq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::14) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CY5PR10MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 972ece77-2d13-42a6-8444-08dc2c11829b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Bn3JS9A9WCFpMc/NSSEqq2WD10xRxpodhIxXRJ4rT1kS4dj/Y4VF3b/jx/3M/gB/Mm3e8/il6GcwEHcUm4z/0qkSAGuTrE3srxRLOE7GxGT0EBqNZbzAf1oGrJb3bELt4HcNOf0IhfcdTtJ2IcFpZYJpmO/dKukDXuHlVakivsMDIgColD0AiLogZ2j7AlWfGmB4KLQEcN6ziagff1n53lZLhszHYyO71U74ZiLPT6nCy9LVxTSCq+gDB07aXiFVtr+4yzZa1Z94CRORJ5yM1jb7lVAmVd8nUPfKnloYJNa3ixbzOSaD0G9ENyKMj5PbzYUlYFEAeYZ9CPZailniWDAiFutwqmYdo4F2UVMMTLbKcXxTX3c15yOgG4UcsOe1L8YDr8UltwNkMmOInVzGpUqWBepPlu9KMs2qgMi5u7FFD9AbS70P6J6MXI4HtuLlScQCvTbcfI/MBxcFWKkEPwOVkU1emCkC2/2u8n187/gq+f/0ii8lkxFGwkrEfz1cvgZFtpn+Dtv9/mFGpx+znNDZpCVLnEVOOj/lFwU2pj14x2X7CweGJjxgjiauYiV/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(396003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(6486002)(478600001)(41300700001)(8676002)(4326008)(8936002)(5660300002)(2906002)(6506007)(6666004)(316002)(66556008)(66946007)(66476007)(2616005)(86362001)(558084003)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?S1v0bZ7zT8UyLcc7VFQBeuYOf4k+7pt5NiWBnRD/OQvl3yyJXA/apO1lYm8X?=
 =?us-ascii?Q?/7OA7jMS7yFnAtQd5sj3f55YIgBIOUe6IopRlExF2dc4jNqcnLhZWc2sUmki?=
 =?us-ascii?Q?IH5wsJwpr/lO2C3CpgonROSrACiIcnIINYScPiYa+U5HuhecTpFQhXKMdxtB?=
 =?us-ascii?Q?VlRM9mUIe948VnyVtEZydp6keKnwWQA4+ONTYCoemROnMGasm+FrLLsa/vw9?=
 =?us-ascii?Q?XDK5Ma3+VvdO7Uq+VokAq0DW+aPwgYmwMlh3d2gjcaT1HjosDS3Rh4PJPqTe?=
 =?us-ascii?Q?Jej4amkrT2ALZZzZaFFHyTpqvfK30xjcV3SiFzLdc9E0MWFS4Pja7CHMbMVv?=
 =?us-ascii?Q?r3DOKoXNu/v+NzguHiyPwCQ5lphTfj3DXkIePA42vE31wkQx9isxCy92lHaa?=
 =?us-ascii?Q?1Xe/ibeZM2B6yEmtY6fRUl1w+LmzBFE8bMi1kjYRNi6Wdmlbf8/e2KKnJX1V?=
 =?us-ascii?Q?2cVOrcaxX4k8NpInWQ1O+cz4p+H4aN64Dzvl+7bm6SDX+w4xkCkmRpBFaDXw?=
 =?us-ascii?Q?1Sq0jYv7LcH6ywR8s+I2xeo7rTQ+veciy0+1XlthL3AXc40lZYGlwVJv1/KY?=
 =?us-ascii?Q?uKUouu8uBbRrnjz0dpBi8Nlt9T8oF5+4Fb82tSvW4Id90PsI6c9bC26htUx+?=
 =?us-ascii?Q?UQPHkp511KET0+T+MYlmt/vCs9kDfD+AACPUcrAXKonVLpZ2xI1rZHhBsjf2?=
 =?us-ascii?Q?UycwG1nNYokxzXlgLAmf5vV5W766LAqX6vWdE1aRwV5O4FZEcUah9ZdoJ+JV?=
 =?us-ascii?Q?LNB34/rD8vs7XYJQqFU1zu61i/oxU6qDvuUDgf58WZCrWj04EdA+iVAxQupE?=
 =?us-ascii?Q?J54wULsQMT6DD7EKVbZJy6bodm5Le7D94H4t+RddZv36dY7VdbrXJeOKcnh7?=
 =?us-ascii?Q?nBEYCqfcpDnIb9jVdClAak9UsK0CBQd6krFHwpE2T+4bFdbjdhx8E9plcUDc?=
 =?us-ascii?Q?iQ2Yylhp33WGI2/Y3S0IoigJJc2/1qb9GBwe1BUpc+KdoI/boQrzvKG8g1Q4?=
 =?us-ascii?Q?1RS/PWOLIUqS3T9yy+Y8bAHghASSBwaoJLkjluQ7+MeAB6+/jDP0ICp/ki1E?=
 =?us-ascii?Q?BjjGf/K1USJL9VozeiP+MbPqwwMT1HL30Siv0daaVSYvJJTmOSmIvH21DnWQ?=
 =?us-ascii?Q?Hpn6cTb/F6aawXA79oUbe4NlhTGFSb+yC6MTz2XuTJp9cgs5FtTjpbfuObFT?=
 =?us-ascii?Q?zRrcGc7DO1op6rRUWIZuXuRKCILYraP2JAoakvNNgMdO/BOy1Kz6ECUgAbf1?=
 =?us-ascii?Q?EiQ952JEiPsCJgryUA2hgsGEtgdEr9+v65rq7FqUPEN0MkUVopNcKfBiHDBM?=
 =?us-ascii?Q?sTP7z4hPnHpfiWqJOkUfo0fA9JyksvjV8h9cgvyktbaSTPP4f3ZehoPU7E/5?=
 =?us-ascii?Q?w2GUW1nK2DLm1hcwTLdXvuozjm/dOFsvoQnfzYGbTscrfmn52jLqqozx/yYe?=
 =?us-ascii?Q?uy/4s/XIZYxRqYPrbcaX0Yvkp7wf5w9NUvVcq9NofE4Y0TKnHyJbKxcM4c7p?=
 =?us-ascii?Q?zeI2XrDaPyL6qIUi6fhBBvnOlqiGwQEK2LNPwqa6M8rGgqUHDGA82oQJyldS?=
 =?us-ascii?Q?pQhfqQzKQ5wIWWoLTIXHopS/GOv/g8I1Wj0S7IR+rvBT7fZWHovZ7/9hBcqc?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eXZAovRw5/vsXW0s49BrQVin/xsqXa6UgzkbjGLw0ogo8GkpvCkDJMaiQ/j3TCRzF2Z+iEPJ1cSMuXDt+n+OEFTy7vQ48TmDnDKt0n6EK6H+JrrMxhLJMMSzygxWDP3tLBz7VvLwFM8uEELPd7Ub4IVnCq7myi32XIlxlygRneKV3SgmDwt6sZDNirWDf4TAn0NYP9Au0bUIOgRG+e13y+jzfmMmLrRt8W9TjF8zkvwZA059tigntrujrbzxMHVKlGKsljvRDzpi8w1EcshxvkWRZYjoD0K4DlM9KTUcMeOlEqPUBN6izoWtvwlIutqgm7c4E9w1Y+pd6ABrC2MBSj70NUjz7IdMG7YbHxy7AFAcRJwFH133v/aCw0G5wbKnwGkpeeEWoUjdXaFwpTui4Sni0ByFNrQVrSYonyzi5tdxXHHuXlAOY1pOfmvLZ8hYUvYAN+TRAx4UbiHwBjReyWipWwQ41BHqbLP7LWu6rJr8i6IQc2iWY2NA7XstB3pQ/1bKbOinqd40+RUU0duesQab/GOuI8PDXaD+8yF7k9SGtJZ52UPkZ8tMFhOvsAHCYewYBFVKJvSIgfiiQ2RNHbVuTB2uIjIFRey9+RiGS6A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 972ece77-2d13-42a6-8444-08dc2c11829b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 21:28:09.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIZZuguOLT53ABYPPbqPkbpZ0teMlh5qHAgDEa2o5Hnw/d9VTrYOFfaox/7cE5Ykm0WBnwa2lv0b9RNt3uCsvALhlXKZVIzXOTVe1tKsqR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=603 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120165
X-Proofpoint-ORIG-GUID: k-A-hyMeoygBpYkWzmOgqyQk32vuJ8uj
X-Proofpoint-GUID: k-A-hyMeoygBpYkWzmOgqyQk32vuJ8uj


> +BPF_CALL  0x8    0x1  call PC += reg_val(imm)          BPF_JMP | BPF_X only, see `Program-local functions`_

If the instruction requires a register operand, why not using one of the
register fields?  Is there any reason for not doing that?

