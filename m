Return-Path: <bpf+bounces-28580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D18BBE1C
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 22:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689BFB2115A
	for <lists+bpf@lfdr.de>; Sat,  4 May 2024 20:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AFD83CDA;
	Sat,  4 May 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GBrlfIG1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mQdtbftD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9381E53F
	for <bpf@vger.kernel.org>; Sat,  4 May 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714856130; cv=fail; b=Djmr3tz5KjJ6d/A0syNf4yJhEtJy0AcGYaSwFg0QQuY0ZkIhHWx8gWw4nr1MSKymI7KAtN+AwuextWU0Tfo1ZWB+1zDlX2XCak/DVE6mV4uqvj/RkCtZA754pmaQXg22W4aP5J61owAUqed4JuRmDrPwHEnCsXU4DM/lXTLLTqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714856130; c=relaxed/simple;
	bh=9eS6qC+9fACo5gKrBKpfXZlRc+ZLj17Dwh8uvlrXE38=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rCk5GAO500bg+PAsrKQUeesLLTyP5rPr/cCqtG25RgVXEfjEJMCtcmJO3DwkcdIdGsp6L0jgK/XLDGvPmtnRKnrS34XJoRCfbhWZ40oN4u2G2XJmnZTfUMVSFhZ72sZTHMlMuSmcLnwsgD81IfJ/vHf0wVonWJCDtadopr8oj3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GBrlfIG1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mQdtbftD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 444Kkd4A015443;
	Sat, 4 May 2024 20:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=wo07iGoQOQIURiNJDK+1tZLrpcBajF4ycdszu2e2rFs=;
 b=GBrlfIG1WUqZvYPS3zWX599Yjj+NmSfScQaVapyQbpKtcHSFLbB+ZKFi3LZpAjvaskWM
 KPuz6ipcrosKbaW1MFTBpWsKsAr/QghK5iu9Y+uuRsQ9Vj5HJUJOS3zvzteGpc8XruF2
 0dHxlTakzidvntVOSYxodtG1xJeRUSQW8OHNOOmSmrybGer223A21GGZa400DWpW+m9X
 ppS+6eKuPfaVrH+jNMfO10t7AcnVFdxFDXSa2NC1gfCVV6JE4uz3nx4tB1hsf7eQ+lIb
 DSN4Rv+klxr2kZq3vuWUsIS/87HzqG8IDO1NADJRsl2H5Ro9PU1ghSRx4iYBtaLCMOP/ 7g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcmv8jx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 May 2024 20:55:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 444H2nRF014041;
	Sat, 4 May 2024 20:55:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf4hhjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 04 May 2024 20:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlEUBdqvKCa/s0oUuM1tAQG6y20+cm1LwtDIphExaLa893qpd6lj4jlSy0vbKnc8e8dbUCaYng4tQ6e1RUcOkRrVCJdomkLAis0WzDqgtXnT3n1rMc4cBCAdnbtZHyT1GNCF6hIH/5cB6RsxUkzxxT/POztqfdl6jfmjVuOngKrSgyOJNZlwQW3pNDRVmEMM2NezQieoMWvbgEBn/8xJQ55cz5aDNoE5jSEdo9PxmO9pr3mKWaqOnSy/NpxDPxOXKWzaPE4phUuCmz2C2QgYDjitOcCg1cA/IkbTTSZe/zJQW9WG8eLZk8VIioU9WqMdulyw1RVTQuFUzCb+Vo5cDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wo07iGoQOQIURiNJDK+1tZLrpcBajF4ycdszu2e2rFs=;
 b=adVN5TZScsGsYl1rtO7yM1+miVftrL+PddWQ+IGYVVRl0fgd28gEjYxDzbkkHZUNwQ+g5YduaRbEQjCPlQ652iGcOSoUwzmLzfO2lEofOqPnBYUoP2jTO7YVKVW/0knh/sYVcX61GIGu/SWS0qBOREFEoRI1+0UdVwCJsz/Gdjgcrmcm3gplc6lYFb/6g1QEe2wunWdMwpE5cxSkRIaHMLnuDrYQqT+YOBHtNN3vntjbYzpiw2nox/Fr7jFrmm9kb5iWB3heK1DaqfOvPXg2tC78vSuWrvkG6FTAh0fUWzMhVgjomc2foeryVAGQi6SoLSU37dUAQLJwnA7M2EMWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wo07iGoQOQIURiNJDK+1tZLrpcBajF4ycdszu2e2rFs=;
 b=mQdtbftD8cS0iKHFLYe9VIdam+LH8wdfuYcbcYWQMSLveM39FTu+I8I3XIUR+uQn/NYl2W7OlCjxWTpyT/sdVB0jh78hOKDwzenxiNZY7JJ7TAtsesbE+eMQsqlyTw7EyjxP9qqNP0D+uNj/a+GxQw9K+qsmXrbff8bFjAgyabE=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH7PR10MB6968.namprd10.prod.outlook.com (2603:10b6:510:279::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sat, 4 May
 2024 20:55:16 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.036; Sat, 4 May 2024
 20:55:16 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: [PATCH bpf-next] bpf: avoid clang-specific push/pop attribute pragmas in bpftool
Date: Sat,  4 May 2024 22:55:10 +0200
Message-Id: <20240504205510.24785-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA2P292CA0007.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH7PR10MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 627ef794-9bd8-4e82-a715-08dc6c7c8001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WCcqOBKzNCJj1QnKjjy1afxJ76dVUgfAmLhON0Q57haJL8Y/xEwxedmmV1St?=
 =?us-ascii?Q?dK+A9ZtVHw+Le55duYx0ilggPhOvhhKgEAnX4cX0ounzvv2S6NJA6aox8yJn?=
 =?us-ascii?Q?coFUe7OyvGIHd8dJ9cR2wbTZtMBLq9/TtNWLAp500lBSTa1fmc+fYD6r01SV?=
 =?us-ascii?Q?Mozvq802N7RleabhAcH/In9k10+7HvLQ6H4LrCpck/Nqc7idvxW03PTgxTlZ?=
 =?us-ascii?Q?gHq/4Xcjm0Qpkb95Ii37ZjPARx2WcP1zTTaYrQsvvlnJOcZ4hURWXJwKKegC?=
 =?us-ascii?Q?FNhWvCt8TLJWTQepHy0mMQ21f1wqQRDPn/iOQsOrQYWgBgpMcpzgDd00JnVS?=
 =?us-ascii?Q?z21jq3Q0l+HuA5A4cHn8VO3S0XV13NTfcOSL2aEnP/olxmJI6G7YK/SyYsMd?=
 =?us-ascii?Q?+xFh18DX0c9PrOiMG4Kn4LcYDn26aVl8Mmk8TCONHlGxwcNqTbamIlEtktfc?=
 =?us-ascii?Q?9byFgxWVypiI7YvklNg9CNty6mOAxa3cOeKrnZ4eJS2k4HX0g1+zOolxUBw8?=
 =?us-ascii?Q?yDfoIjKc3s3xw9pY0T/N//auRwh9Woc0xzk/9KMgVF1NGpdnHQGu+xK7uDom?=
 =?us-ascii?Q?45CMQ+TmXGT58uHQlSZSHQceKNZs30d31wyzesufogjw92MgLyHTVjiZ6932?=
 =?us-ascii?Q?tyu03392qaPOhhCv6whrr8TY0DmqTnUJrPe5ME38caRnSai9CbFeUFPq5DRV?=
 =?us-ascii?Q?lohRX/QuAhfIeS2WfYxDuw9DPxHl06a/Lbqy+rRItKiVIJkqqYR17nbj1M/1?=
 =?us-ascii?Q?aJ6o8b+l6iuhjaFQPr3p3pnsyC0oCBYADrmQuvn6loDknWkTO1elfIZUAL62?=
 =?us-ascii?Q?RKuP0Im+2xqtZ+fZjsyTMZ4tjuzH7TBdCIaEmytY2tfbFXCUjFc8NraigQ41?=
 =?us-ascii?Q?VUhwSeIk0XOk05tpugv4ITY3ODHAjAmHh7I72aBLsYH7GWydSCAnxSKKyHeJ?=
 =?us-ascii?Q?8plgTsu/p6w5MRJHQB8tX0q1soweBwsTeyeTLPUwJ04r7Mm7m+Fazz44wxgt?=
 =?us-ascii?Q?kMke8zdE6weS6/V8I5/r7ZE1obVhaWedg+oIbNekoK236/5z4EKhL/b/cja1?=
 =?us-ascii?Q?GKpmvcGuvkh7uZYByGEPIYfIXzhxH1mvaZcD4704SPQ68YIqDhuYjYpl5yhw?=
 =?us-ascii?Q?GOJUsctrXieDtDUFi40QrJ8MEW7pXM7xwKS4HkPoM/VS9q02zOaAfAAuDe1c?=
 =?us-ascii?Q?8C8hATeCrAdGGSoC1p4DkwxiBocLw46gw+jF3VYoyPSHXGKNE2sshiIIxVXx?=
 =?us-ascii?Q?sQmRzZnEguXWaFN+VZhbaIb+js58j4xxcCTMPq2djg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5rPjyv99POX5oKrhyomGJYwlHKgaa2spOBpcZOxZJlD/N5rX37smCiahODmA?=
 =?us-ascii?Q?nt8zDMJLWZRRwxj0mghj853uvgxzBKFOjKu8NnAvgLwsCjMphvFzV7gKZsDk?=
 =?us-ascii?Q?YCIrVU/is44o4AwiqX3libcTMQbO0BGdWtGOheKYujIrns1iztUSXzIaXX74?=
 =?us-ascii?Q?kokP7vXOcvYE99xpP16Faj0axxgflwy4JP8jPTDzrQA1xkT+8mPxsxb7fCLz?=
 =?us-ascii?Q?tE+vteY3xwc3jcgEQLzGPfIpGMWrMms94/Psbmez2m9mII5ooUXMoDNkr8ii?=
 =?us-ascii?Q?pfc4bfoLzzH1lCkct3l2hMezYw4Brvo3uPrDqmCxDclByO1u+lqUuZkbBg6W?=
 =?us-ascii?Q?lOLthYds7UJX4GQt+7HBBxAG6s8mtSZXirEqsKZwEQoH0DpwAdJjpL8xTYi2?=
 =?us-ascii?Q?jrxJB3SDfxMzpWPnfuFIpCamQh4ZtxoNdME0mb2K9jDM2FwExsnWVdR9iDNU?=
 =?us-ascii?Q?DgzlJL5HW2ARr5QMi26g+EcbN59YgB+7+jGrWaYvFWWl+W07xxNG06rJJEHl?=
 =?us-ascii?Q?tQmYuZBmy8N/HfeR9tB60RUVW51ltpwuKT8Mq2eRI9cZyN6dHj7Zy91d/F2E?=
 =?us-ascii?Q?Nw/qbFNKGJiDY7F75ZqgQvMVQBWpwlr7XfnN4Vn+54zO3v11Irn6u40bdWjb?=
 =?us-ascii?Q?xd/2CNztGBemRKxYvNvu/QlMJhAiXQIwEczkaECvIszP9YIwgXvkuOfANtg1?=
 =?us-ascii?Q?BPdl3eHdI9WFoYoiQI6tq5Li6WMxUWA/Bm32E2soA2EdjQGgg1BX4+C5/Dsg?=
 =?us-ascii?Q?6ccsaE5ZbhRktBB8vGDduKuc6pi9wrFZ/dLHb4QVjxdef7hM5SyGc0H3MEpJ?=
 =?us-ascii?Q?mSfydNhJkiWe1kJGJ/djQ0AdChNKEwe6r5NQbOgb7WshvfByn38OWaLmo9Ki?=
 =?us-ascii?Q?WNZbAXbgLEQWxzJ/TUjDrcGqgnbfRMyFBkdLhbCSLtoj51iDwIfk9Lp21AXU?=
 =?us-ascii?Q?gkjDmTA8yuDnI2bXEaGhXaqU521UqzslUT6NZlBofhXAZS/WdVooi2kD7cJM?=
 =?us-ascii?Q?Sptq0zV+X3jBJqVBVPJi8mX1r+/Z7NNfZ1QucCA3mgZIQ+RD9JF4zivvJUm7?=
 =?us-ascii?Q?tm1rJh9q0ScYMdKIAJMdUnpNlV3z+pHwY9qRsSktHbJSMT4KrYvhEhWbNBt7?=
 =?us-ascii?Q?9XKNW9sLLm/4Mq0qqEK42CcZedQBQRZ7JEcOmdWTFesd0vrKji01xO5mfDID?=
 =?us-ascii?Q?09k5ISVdvngySlY94AxtfLmIKQceK4FpXfKQCxr0ekyLnCfUVn6LsbhU6qIs?=
 =?us-ascii?Q?RMDNkCUa537TCsC0B+n8qQFmmm1hQICuZtgsLus+iLRtKL7QxkUcYiU49Eci?=
 =?us-ascii?Q?9MyrloPH1MsbDaKOqoIc9hm03R98/O772BiWeV711h0w0YooO+CsXsQaa2Dm?=
 =?us-ascii?Q?Ul3QtDNIQFxeCF0dkofR/ttzcLIT54CWGHig23Gv50DwE1aBPAoh95fCyHII?=
 =?us-ascii?Q?IUjSeGWD6MxeJ4OLEvmAAYuOI981AiYzpdOf3H5gcI8w3JsCwx0/R82dChYk?=
 =?us-ascii?Q?bLp8W4zqvPf7P4FIigsC59T1TPXbfnaTgv7w3ojSd9JIsSCCzUNQXICCs+1x?=
 =?us-ascii?Q?nOYfK/54K3PTfTyS77pDG9Gv+uiM3SA8Jr8hr+45jmSr2wAfjw6tURG5ek+x?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z++Y1RlLt9lHKv5qoXFTjFowIcU1K1zGbXhWs7/EquW5a4Z5ksNAitJM9w4MWYgrxpuC8rcKKLIsSJG5gl+o5oW2/NB7vflNeMmskC94CvhZcekYycMgeR0en8szIb0Pa7b/h42DAFPS8v4fxHKyBlYRSG+eK55Gvfw8FlNRr5+VwdaFz+4IyO0ZaTXRxh6g8vobytfGe+YHxvH4PHfHIPjj/upQdD2+lnB0UvNDJlNEO0d2lH7WKe6F8jVB352oiZ5DUA9jBtEmzxQTGtwgHz90z0eCi1fOo72eIluo+GUJDdg4/IIuu2/TfXzdnhVSF/HZ6AG73N/QyPrNx1b4fsGahCn1tJei22yxJt6RHdLxSXaGd8ZNQn5EzgvdaFgGZQg6pr14za6sA5bG6CzDGIbNH9TfKCZHj58d66DKiX4RN1X6uuL4IH0dS+QVKsSlU4oyjO0IOClB9PPM6Mhyf9ybJHLAA96FWfaBTAZv4qDSB6U0ioMqWWlt+yTCqNLK+Sg7bax7Lk0YcGdw4H5+GCMYa3k+0weqGHrSHK5kIMjB+FAYmiNPvgvdSfXJ/eUYtkm44oKiw2f5DVTYC35CaPMPhLZIigEnWUaHUYpt98g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627ef794-9bd8-4e82-a715-08dc6c7c8001
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 20:55:16.1326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ebUJFl1WtJ+hv5T/WFQBRrquUFNmPmfmujUzF1wSwHTyv46pJhZw6oxy29QT3TgGDjWD3CNz0yW5ktI7DXukgE36+kZexko5EkAA17q4ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405040137
X-Proofpoint-GUID: upLFCveO0D0-o_KkFKXvziZeLNSDCdGh
X-Proofpoint-ORIG-GUID: upLFCveO0D0-o_KkFKXvziZeLNSDCdGh

The vmlinux.h file generated by bpftool makes use of compiler pragmas
in order to install the CO-RE preserve_access_index in all the struct
types derived from the BTF info:

  #ifndef __VMLINUX_H__
  #define __VMLINUX_H__

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #pragma clang attribute push (__attribute__((preserve_access_index)), apply_t = record
  #endif

  [... type definitions generated from kernel BTF ... ]

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #pragma clang attribute pop
  #endif

The `clang attribute push/pop' pragmas are specific to clang/llvm and
are not supported by GCC.

This patch modifies bpftool in order to, instead of using the pragmas,
define ATTR_PRESERVE_ACCESS_INDEX to conditionally expand to the CO-RE
attribute:

  #ifndef __VMLINUX_H__
  #define __VMLINUX_H__

  #ifndef BPF_NO_PRESERVE_ACCESS_INDEX
  #define ATTR_PRESERVE_ACCESS_INDEX __attribute__((preserve_access_index))
  #else
  #define ATTR_PRESERVE_ACCESS_INDEX
  #endif

  [... type definitions generated from kernel BTF ... ]

  #undef ATTR_PRESERVE_ACCESS_INDEX

To make this possible the btf_dump_opts have been expanded with a new
configurable field `record_attrs_str', which is a string that gets
inserted at the point compiler attributes are expected for each
emmited C struct and union type:

  DECLARE_LIBBPF_OPTS(btf_dump_opts, opts);
  [...]
  opts.record_attrs_str = "ATTR_PRESERVE_ACCESS_INDEX";
  d = btf_dump__new(btf, btf_dump_printf, NULL, &opts);
  [...]
  err = btf_dump__dump_type(d, root_type_ids[i]);

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/bpf/bpftool/btf.c  | 15 +++++++++------
 tools/lib/bpf/btf.h      |  9 ++++++++-
 tools/lib/bpf/btf_dump.c |  8 ++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..c548dc3b4bd7 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -463,19 +463,24 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
 static int dump_btf_c(const struct btf *btf,
 		      __u32 *root_type_ids, int root_type_cnt)
 {
+	DECLARE_LIBBPF_OPTS(btf_dump_opts, opts);
 	struct btf_dump *d;
 	int err = 0, i;
 
-	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
+	opts.record_attrs_str = "ATTR_PRESERVE_ACCESS_INDEX";
+	d = btf_dump__new(btf, btf_dump_printf, NULL, &opts);
 	if (!d)
 		return -errno;
 
 	printf("#ifndef __VMLINUX_H__\n");
 	printf("#define __VMLINUX_H__\n");
 	printf("\n");
-	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-	printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
+	printf("#ifdef BPF_NO_PRESERVE_ACCESS_INDEX\n");
+	printf("#define ATTR_PRESERVE_ACCESS_INDEX\n");
+	printf("#else\n");
+	printf("#define ATTR_PRESERVE_ACCESS_INDEX __attribute__((preserve_access_index))\n");
 	printf("#endif\n\n");
+	printf("\n");
 
 	if (root_type_cnt) {
 		for (i = 0; i < root_type_cnt; i++) {
@@ -493,9 +498,7 @@ static int dump_btf_c(const struct btf *btf,
 		}
 	}
 
-	printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
-	printf("#pragma clang attribute pop\n");
-	printf("#endif\n");
+	printf("#undef ATTR_PRESERVE_ACCESS_INDEX\n");
 	printf("\n");
 	printf("#endif /* __VMLINUX_H__ */\n");
 
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 8e6880d91c84..f7f9a2c7f96e 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -234,9 +234,16 @@ LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
 struct btf_dump;
 
 struct btf_dump_opts {
+	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
+	/* String to be inserted at the point where compiler
+	 * attributes are expected in each emitted C struct and
+	 * union type.
+	 */
+	const char *record_attrs_str;
+	size_t :0;
 };
-#define btf_dump_opts__last_field sz
+#define btf_dump_opts__last_field record_attrs_str
 
 typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
 
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 5dbca76b953f..fbc112f31d33 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -116,6 +116,11 @@ struct btf_dump {
 	 * data for typed display; allocated if needed.
 	 */
 	struct btf_dump_data *typed_dump;
+	/*
+	 * string with C attributes to be used in record
+	 * types.
+         */
+	const char *record_attrs_str;
 };
 
 static size_t str_hash_fn(long key, void *ctx)
@@ -167,6 +172,7 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 	d->printf_fn = printf_fn;
 	d->cb_ctx = ctx;
 	d->ptr_sz = btf__pointer_size(btf) ? : sizeof(void *);
+	d->record_attrs_str = OPTS_GET(opts, record_attrs_str, NULL);
 
 	d->type_names = hashmap__new(str_hash_fn, str_equal_fn, NULL);
 	if (IS_ERR(d->type_names)) {
@@ -1024,6 +1030,8 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 	}
 	if (packed)
 		btf_dump_printf(d, " __attribute__((packed))");
+	if (d->record_attrs_str)
+		btf_dump_printf(d, " %s", d->record_attrs_str);
 }
 
 static const char *missing_base_types[][2] = {
-- 
2.30.2


