Return-Path: <bpf+bounces-21540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61CC84E938
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C609282849
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D458381DE;
	Thu,  8 Feb 2024 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jofGuO67";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ie9+bIXf"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E020F37707
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422336; cv=fail; b=TZVebLOrKlouzp4FeiYcyjZE0d84BLYu2W7W/ZiIWPUPT/qOmFypI1zWwR75o2hqfEkR0Mts87YgL/RewALxRYwvxwE/NDbgMegGgUXzt4r+sg3UwajCtPX6k5caE8N+42VSSHz52IZD2lLJ34J4JrpdBXsJqk0zfd1ZB/4Xjmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422336; c=relaxed/simple;
	bh=N1u4stJUaN1v8lGH0AKS2hZ34cVLe7y0gObEx0XOIZY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EhcQsUnxwCsAL3/cBTrknX/JQh/ySlgrLeF+GJLHZxb7S63Y7EKPdkS5AadQjzwI4Oi8nh+kjgwDn8hy+kJVr2WKT+FWl5vDpWnccLF8jhi2UNHIxzuymWYFUispCV81j1VQ0MbILeMOruJ1Wyu6esKLhU0APh6k9T0tlGwRA4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jofGuO67; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ie9+bIXf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418JmlUR003285;
	Thu, 8 Feb 2024 19:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=YK+JPCyRaQ2a0cWekiKNwKv3CgFBWCF3+LFrOEFt7zk=;
 b=jofGuO67KPxyZVBtfGCS7asxD2BUzWFS9eKdIFIDvshzoIiXWddm7M4HwUoGXgtorQno
 ESaOle3P2nAPZdIKTEDSvODcCiiJzJcBRqKCONKXJ8Ufayf+sXita5MNUlx2ML6UoGdg
 KC856fR8iMPLRhfnglIXM6s2q+a+6JILvCzUM92qLoNj9Z+NzptG2RWnSmnvg67jNifU
 n0cxGesVZeDIdkrXcRlhZkOt5Wc6PlRdH4P+ojqlgROyUTksQ1cKS+7TyXmuCHKkXIEo
 PlZ6qGh4f++Jnkdlckp9Kvd2vORa0cYv4cxJ/JCK2UlDOXT33hfo70N/TBlH/zgYwiat zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdnvm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 19:58:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418Jofcx036826;
	Thu, 8 Feb 2024 19:58:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxb6rq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 19:58:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpZFIwz9vyQulhAxYr/6NO8hvrX5+Gy5O6hrQibYekYHER+M6BO8Y4r3JQh14yNgVfMoTMS7KS33f/MdbGObLSTOYUpp5Kc7oUy03UM7f0M2OLRIt61jGF7UJ3gK81EQRqMQsYw0W/ZG3ynfpX0tiZHIi/HTvbYgPbIXfGXvOZ2uG6KVym6Zy1p/vSnfUCJSCM1qH22YTe74Zlk3Id5jynmw402JbhC/GcsyiGpNhjhWVYRnt9UCU458As5GXCtCYQSHDnTckT4f6XIERHDwpFnTZT1tZi9fO8iiYHdWovP23at1admSg+56fAADIW10/iTrYn2i+c1Lx3x4MJv7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK+JPCyRaQ2a0cWekiKNwKv3CgFBWCF3+LFrOEFt7zk=;
 b=F2SZLqTT6l/7zIEk0bb3/qnWVv/1a8ohuq1ggrKrAI3NARYOmQSC7s+14AnAzt16uR8Ll5PiKD8hAKhtkOPQ8/SEeVREkS6UrVLGGaJyGOfWkmXV/tUjuakKLQLd7zp3x6a5eJC46vJR19+qOqPDXvC+F9DhJyzVZzQ7pWKsk2857I+FDiS22htii97/edT5Dz4zx8C21/EPqAFyJMS8Oxda5H58ciX2roIxnbAzYBxJ0wLjtgwZ+8sTylWUEFaLq5CNAeSt/Ff8wpiZiXhVlyVeHdUhytA44wI/r6nj+YyZ4G17HmL7tkZymSyf65MIIUI5engp67ZRtVG3MFpTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK+JPCyRaQ2a0cWekiKNwKv3CgFBWCF3+LFrOEFt7zk=;
 b=Ie9+bIXf5p0oLQZJntEQnwDzJV3ucZXlZfAyOTZEzY0xnrwl3XMgXeyyD5/FH8PC9BTfyv2ee8mnnPuRRf+YCh/GJHnYLJlsti4eMXAXonn9mSTWxcl4Uw9TQ9S8s8p/aJPUkqs20tRV0dQiX3RM0mHY5lObOqh4By4w4PTzBB0=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CY8PR10MB6731.namprd10.prod.outlook.com (2603:10b6:930:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 19:58:47 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5252:c588:583e:7da6]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5252:c588:583e:7da6%5]) with mapi id 15.20.7249.032; Thu, 8 Feb 2024
 19:58:47 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: andrii.nakryiko@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com,
        alexei.starovoitov@gmail.com, david.faust@oracle.com,
        jose.marchesi@oracle.com,
        Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH] libbpf: add support to GCC in CORE macro definitions
Date: Thu,  8 Feb 2024 19:58:22 +0000
Message-Id: <20240208195822.1299781-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0317.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::17) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CY8PR10MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 3194c1ff-3555-4278-2588-08dc28e05cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NyxZuNCjxgxocgLOrIq8AvQUUznbcNvoUn1bC9GVZDYBGQAkeouGAG3ZE5Q+z/sH/OAQgMNYzpZB6YRpWAUL+2cAb2/ovvqJQrMICeynwZ8V2DzbbjV8FkPYGboWsBFrQNylJV0lELlAz9/s5CrLGBzNpaXYKoYJPuNWY0rujpE0UnS4ejHWtA2B6M3ju4n7+xHNH5Ad4OzPAtv7XZ8QgZB+4VJ8xUIOwgeKWOTXavtIGNNH5m++wGe4d8iCuIWiQlO7MRPB5YXrsjHizTc6sA9PCXHsEAFIU1Hej9A1AFoGLTMjrCKHkiXJPLKNmk+9t1jv7AkGkOVplC8OfRZ3ougzX4OKj9eGEBuInpIZ+73kGGSqh4q1u8lG5omQ31khJzt5VTHi8pI0Buq+mSd/EAORKbP36ro57JHN9Jvuqr9edKTrW18AxjsGxd/cFj6IUsOlmIWlUPu8brDqRU4vBOJg6qo6HY6pKD2mUB1C6QdqR65L8wM6Yo0d6bsOYPsvqQCck4EJjoesPW4nnlsBmo+Zm7BaJUwKLsuIMemaNObLkYYTmQHfkSnnA45uFFB7
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(86362001)(5660300002)(6916009)(8936002)(6506007)(316002)(36756003)(478600001)(38100700002)(8676002)(4326008)(66476007)(66946007)(66556008)(107886003)(1076003)(83380400001)(6512007)(6666004)(6486002)(41300700001)(44832011)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tJjlJaUBwo93Wjt2umyAkJqTnqkUWndJ32cXWQNEvGMSiU32gh82SRZ8/2Hr?=
 =?us-ascii?Q?CS03dpMsWpCl7YiZZR6nek6n0QsywH6lS/sLFKkXY7/pTI2I5k/vw+UQkAJ2?=
 =?us-ascii?Q?fsfBn/FEpEx9JweARc8JtOVWXxbo5OhQojbWnM3wmwAarVPOrpyWQiTlRQ1l?=
 =?us-ascii?Q?pOrc1c3NyS1s2x82PWtaLJmVrx7/G/mOwS3W+vzYbxcLBfb0T73sJblcOcY2?=
 =?us-ascii?Q?ufzHtOUgz+v7KaorCzVT8LZvtlOWTNyYfEL/5MPR4hfVCavDgHuXHp9Y1iWY?=
 =?us-ascii?Q?EDt9974YpKwr/KHzijJ27plKzLCELvudmqEP0CBd6jvU2q8QcA8kzypY8EOh?=
 =?us-ascii?Q?/YHOVVO6fPvX4ljSTHBJLa/3ulcQ3XgNGj28rrRT3KGTcVwzDBI5+RMG34ov?=
 =?us-ascii?Q?QTvyUx0KRzRKZE08zFwpKVI0B87JM5gIpoOzFWIT6aZyRkr1Pc445+SNFU0l?=
 =?us-ascii?Q?fFYgCmusNVBJXJuCR74Q5EuDcbMi/gulzJmouzVnNdUKViFT+MVjUw7sRjbt?=
 =?us-ascii?Q?1o8v085H9WFn6nn6zaBEAI72jvFiXrnYz46GFhKUM1IZRXGQFBghkjlHK9Yt?=
 =?us-ascii?Q?UVhA1xnivzyGf163vPyqO0yZan5U75skwqLoCebXTjB31y2Q2Q9thCn3EkA5?=
 =?us-ascii?Q?9nvaw8yVJwfRPTIvAsMdviF7qkneWmLncDKYzJoHWKqt6G3/NH/9UP4eB3LI?=
 =?us-ascii?Q?tv4JBJ+iPtz6k/hOjQ3ZiU1gQx/mMXEB0IzNoUXQ/3VePIfd9VAh9VD6HCWX?=
 =?us-ascii?Q?/+U3Xk02L1U4weGvKyWR/joA5YSuzr3dlnvYzyW5dt3yL/VKLME5tuRUabWr?=
 =?us-ascii?Q?wPK+bhyhdics5+uwnwnlNpPmZmyGkrjCxpXNDeFiJjns3iqyaZl7wVSnsu+k?=
 =?us-ascii?Q?mYVsZSO+RFuTM9zjpdc2NVsOHzwAgFRF5V6felVm6V1dN0rIasYzJe/mlltL?=
 =?us-ascii?Q?p+/LSNxrxlnYu2oXznKkEywfsoJ9IAR6Xkcj7oQIgW8gqBU30XovS/tSZ5tk?=
 =?us-ascii?Q?RyCOKkY86eZHeBbdPCgzmCnwHS433EcHTtGvVJVrw9i1uQshlA9MTtsCmGYc?=
 =?us-ascii?Q?IRlI0Yq1en3Xix5VQykDd1+EhhIMIRgyCVBqF3+JR1gJ7IOJnIOC0dW5qVtY?=
 =?us-ascii?Q?qpSKCS+1c1fSsgFoPiP3T/64Fh1mKSlyPkaR6D7yOL+exeIeGrw0sJazlJns?=
 =?us-ascii?Q?BgyrD1Ki1NhVhQIKGvZ1L+Fb0XHSfFqYxe11J8PmFcmZ+JR6Vay5NX0CTIxG?=
 =?us-ascii?Q?ng94rjAocgvMxwwfrevwE6OdMgvecfFv9IheKGJSpynvatnjzq2mZ+b5va8e?=
 =?us-ascii?Q?qdTJFXsYoKnsd3TheV9DmMaCzfiRmrIBRfLuw9Oy8MKs8+/RH0kH7wK7BfxI?=
 =?us-ascii?Q?JL0sOfxwKwFM8EI53uVWXzRTWKfZZ0LmT1LfvOy4mPa6/B7tr4IbXFqlMgD5?=
 =?us-ascii?Q?R/e1W2D0kNPBPo5zWiGkObyCEgZ7g58g07aJegIboXlmm/jELdUaoY6JsIPS?=
 =?us-ascii?Q?xhCkXZeX7LKznwg8gpzFmp+Nh5w+7X6RDS8KN4k9mC/KBzjy2GrNgHb8l5TM?=
 =?us-ascii?Q?zzf54zB8i6ZICydBVUa2iUmAjKZfSlMEEAeYp/PKjJGvPqfBFN8qGO3pcgpl?=
 =?us-ascii?Q?S0/NPvbYjcyv3x+o0g7cv/s=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QZ9EjkVhn3ihfgKL3aDQDAFRjMxAPYFXUgxEuhVQN33qgO89XvBopYg1tBm6iE8NunjK4zN1RH3Q8oij673e3y09GWKliAvyJMM21XGPU0GhbY8dsbcFee9yLO+m+07wXorQ/AcZ1nn5H97XF5cBn4jj9u6/dVMgV7KWVxSvfh0JUBD96uk2QORXWHcI9IwGlFwAamHeRPJYEbHMRSf+clDEtU86LeBbuglP7FTICVXQ+xHJ2g4w/6Hv2rU97xa3LFhQSm3KvRAy83zkz1noqm+C1KU0HdY6NsJ5rijFLFABx3Cu7P5SuAXpeAodYn0pWbrKqZJ7gZNFxRbDEuUgLIsMaYTCb1kBEVOlW3h5ocZ97HOBymENEx+S6YkuPxvSor8wCGoz1X6XNW76RPerrSM8+t9O+h91ezTeIwSVO7GJPwDXSD3dHbTL+4LiOci8KVqENFAdLgj1WRSYTJX13mHqm6w0uf68tSN4bh16JTQwvGhS1o5UOST1RXNQnS/Fk9lH2t6ZTmN6Xu8qZiO7A4yA6v+GYnUdlXpU4YNQNG67cyxXODycBytVE/PxoxIyM3os40KjQIkEr6tuH7BcO2HEeytRcLevhFRVwNhjAMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3194c1ff-3555-4278-2588-08dc28e05cd6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 19:58:47.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnJ9aP4krKgyX6DE3aF4pXbDVJl/2g+tefPbwZWMUn9wzj4+D9LXpZa73VqN0T38/xUzqkP3BNLU9Z4j+CW+/E87j9qIoUWukU4yMPAwbyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080106
X-Proofpoint-GUID: ddw7z3igAoCIYn6-Fqw6ZdDDOhUsxPPi
X-Proofpoint-ORIG-GUID: ddw7z3igAoCIYn6-Fqw6ZdDDOhUsxPPi

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
2.30.2


