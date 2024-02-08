Return-Path: <bpf+bounces-21509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A70484E420
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 16:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56B42819BD
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FEE7640A;
	Thu,  8 Feb 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="illLzbtb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g4DW8VxR"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458307B3E1
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406581; cv=fail; b=ZpVkLOq9b6EEvqgczQ+bKOUOCg8+L6GVNH1FvkP0h83c+TCZuuxhL3wH8fvoDjDBzRCngM2lDvIgxCVuQ3Dhfx+Gm/chFnF3tiEnPgPil8wHUtKAcQ3Gete9bGOPWV1qBzUMoXQFRncqdYBfLMCKKvZxoQ3bLxwFBAwwo13+AOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406581; c=relaxed/simple;
	bh=CJkl+/QDO95ZasEP1lAmoVhatQw3/mGRdb+/SUdhgwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=TARxDTEAyFFPxjmaeGeTx7nPxo2+8ge7yOdPjTe1UAI0ccn/29xVcnmwQibTgV95oWyzEqujm4t6HgIIZCA1IzeWhqfJECj2QwOyV0Anm7by1K6Wajotf4ns7wgnwX+eoNEUtSbYkba3S8Zn8sQEHIh+DKdH6dd8wHatQjzwmzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=illLzbtb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g4DW8VxR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418Ebxwp011658;
	Thu, 8 Feb 2024 15:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=A2mbSIx3NsCXV+oIRcdL6kxRXrQ4CM2bem8rfAOGjjU=;
 b=illLzbtbTEtalEMgYveelrKH7QpXOy4rRA8ov6lO6klaDNIjp7d89UyEOjcQ6d9mY84n
 vFPzkY3/idgT84qm4fEQG6+S9RLa87qox2++iAn4MXOep5njDuiwQJ4axBualC+2qkEK
 U2J+AI9E15tbx34RkEaJNICi3xBq4k441U/OGwXxn9zx4bWUeUzri+gIEQj30u2vlb/q
 vFvGGbZ/NpJlUHG4uykrM2BRAS+82dJGNg1eFVW4Ic9LUqIQnQtVV0PKbNY7MQX4XDS5
 LpDzGf+23VXsbUFm0XS1RJ+qzOLbzyBhiRj2gBjWZkkoP4c9jxLJc1DwIuxQ9w8jyJZR ew== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdn7rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 15:36:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418FNfUc039468;
	Thu, 8 Feb 2024 15:36:02 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxaj5ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 15:36:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZwJhZ4C7i617cIk9LwhiHrfNDZcYTybM4KxHTfq63sf33EVFCwsoqij0G2Kj/Siv7XrDnD9q8wEV2lW4GDmFOG0M5pJgfs9Bphw4oKqIKj6/IsqBNPe6GlY+DIwOejbkTD6QdujeDicnOJr21eTeMn0DSNiwnDaQe67mSwq1fRwONuteMCicaMxz2+NqFZ/kyzTKgwZ2qTWHPmPjUwCwMJW8X4aBfZuq58B/d8LoevxO3isqwuXWEiYxS9XYq+h4KfpvdMKx7QTs4VDSoBK8XQWCZA3dWLd4KAE84HQ96BI9KtcYCCKk81SmRNRHjcOggkvAW2EiZ36s2l22FBjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2mbSIx3NsCXV+oIRcdL6kxRXrQ4CM2bem8rfAOGjjU=;
 b=V/LfCYdDmWmv7VkWykTETdvlx6FCHvbTTQ6KUfAloTk71VnChqkq4lgoZJaWtT9tYZBnPG5wkOwBiLNH3vHHFWEfQlnzMPzOaVcqCt1fYZcjNSsrO/RMDX7wtIuhBVK2n+FjxiQnN0F7ky552a0JFkS+pIp3wCuuMR6VfKcfZ349wQe/uyWiGhxgxg9O+D/V8fETEwceNFeTtqijf1WT3WL/pru/cewQt67BoPWZR+7+A0ZKTh6AJnfcZ6vgwzmbS/1jiqftqq1FNuH7u7YQeMaaleC6LjuUM425fiikhA/udosR2/AHtAcabM4PCaB9hm3uCCBsv/0KJIT8+vG23g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2mbSIx3NsCXV+oIRcdL6kxRXrQ4CM2bem8rfAOGjjU=;
 b=g4DW8VxR32/PpMeMnoxl6ih2d8Jk058HRoBXzqfLuBQZzgJAAy7/b3wxqzODdcH3JHow4VsiaT3FcUddixd7tSBYsszUw+YSO5oZvnAzHj5s9glxqgcmIb4MjM2BiuXynL/3kOBwo/4tyJFwb/bHWI4PuYrNkgQy+xD0Bj3kJoM=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Thu, 8 Feb
 2024 15:36:00 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 15:36:00 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        Yonghong
 Song <yhs@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
In-Reply-To: <eea74ef852fc57e9fb69d18e1e5960523c4f7abb.camel@gmail.com>
	(Eduard Zingerman's message of "Thu, 08 Feb 2024 17:28:04 +0200")
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	<c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	<87h6ijfayj.fsf@oracle.com> <87wmrfdsk7.fsf@oracle.com>
	<4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
	<87o7crdmjn.fsf@oracle.com>
	<eea74ef852fc57e9fb69d18e1e5960523c4f7abb.camel@gmail.com>
Date: Thu, 08 Feb 2024 16:35:56 +0100
Message-ID: <87il2zdl43.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: e30e5a03-e6ac-4ae0-e7db-08dc28bba6c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MxX7mZf48mkGDIlpsoYeAUzi29GO/QgC0cqV1cjnrPWHD0dh3ltTzGMdN1XOX5BywrbMyp88wVvt7A51EvSbYK/gjIk2iP4uhUPXLYSI36Cjbsm49Ablq0SzgsmqQ30jIpKvXuhh3c4l62IgXFY+CjoHyfFgoj9NqxGVgnO+l/th744gdMm26Rk8+kgQ61ySb2EUxUiW1HVfrzA5M5vUARjQqTsPgEcsrkZM7llh6WJlVNu4xzjRzxf0iGiJAIzIrCJim4tDBrfvuaKGGvEADyo97GbX5d/c8HTTn2A9k1K+zan1ZSzmCgY6pDvPG8NTkq8zx/FqmaV5NtAd8G5w87uC9kyNBlY5lgeH5JjjG1uWstxAfQ7BQVB5ezD5lp/1+7z/f7E/QMa6sZag8PNAXDSF/PAw374Cmqr5ahHKqlqYPDSij1nYIP4QdfqWUZuNtB3Q4FKizIfSUnLA+27HjcdMLs/2MTvy8qNk8V/It100hmv/YkeDkJX+75TrX9tRpIVnm0QgJ21cazwszxBLYWrYQF3hv54djuKwJnV34TJAtzyNEHvo5PhciGZ7kNEs
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(6486002)(8936002)(36756003)(66946007)(6506007)(66556008)(54906003)(478600001)(6666004)(66476007)(6916009)(4326008)(8676002)(316002)(6512007)(38100700002)(107886003)(2616005)(86362001)(26005)(83380400001)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7EQ9TJTpC24MhhwSF8ILxd6nPYQppH5IGKjTsAPCnPyY1yv+MIP+DeqwOpUV?=
 =?us-ascii?Q?yfYVc0mTN+3JAqMqkNTSO5DzJe1qOvtWg5BvtPxFLwqdQIXQgCrGYgVJqalP?=
 =?us-ascii?Q?6sa3UDm7p1kxAfp5P+xsOroRUUu5u9byewoOHlAi0BwgmoVVNOiese9xNZCf?=
 =?us-ascii?Q?An0J42pOfuhNq00J3uEw10JAhI3RGfXZRt5/obn4E8z45l3D8AFNuku/sWfT?=
 =?us-ascii?Q?WFkRbMhRAsjmieLQed9VXwyD5jzrXQRzG3seKyhePQyGmirtW6Oshjm+2rFa?=
 =?us-ascii?Q?dVADMtvKY7y4DsDIz9hdCs9bSa8obV+HVJhRtXiSLKhyUFhUmAObdUZN/6se?=
 =?us-ascii?Q?u6f0oWuCCH+9Gp5wvD9tVEo11j2eGJo0WZBwDORby2Vfm7Og1gLu6gzf3VJ0?=
 =?us-ascii?Q?g51L77msYq/Na4aWZGWYOjxCw/ivK7ldgbppezYSJalHAtoLp0JQBTFcUi9x?=
 =?us-ascii?Q?pLw8EIYHZPMo1fNt2Er/Pitgj5lPndJi9C9lZEddA5sdHjO1qnxpWgo5cVfL?=
 =?us-ascii?Q?vikKJZ7S3jToHV3Ce0S9kL7QY3ivxiASIlvgzViBVINVW/BCHTqRPQUzn3lp?=
 =?us-ascii?Q?GybbIyEsbP3XKdyOcMhKe1CKO7wkZqBANByGlbpfM0wWLk7+ROgv1njnQygh?=
 =?us-ascii?Q?ctmH/f/p+Rs4yNMug6wPaqz41XJBKOFyTOBbRT9GzhqHq/vlTkbXCvasv1YI?=
 =?us-ascii?Q?HF3AwV40lPqitv2ctmoVq7jQ102Z6uFB3ZmK6udcIhuDYxTSnzYhrjT+qO09?=
 =?us-ascii?Q?Xq/cqgmZteGl6NZlhRi92VJwtHRN+f9OO8rOtWeMDFqA6rcBJz/J2LyL0PGq?=
 =?us-ascii?Q?piT6gKKRmou+1vGZav0DiPabVWRtfUhq49ErcWn5mZiOoFh3k4imVBQeM6in?=
 =?us-ascii?Q?PtAd6Ipw5oAigxXHW7gDhPuvVdcoShhrulzJd5mH37SCnhSdb+he5TIEd+/F?=
 =?us-ascii?Q?5xnR9mCpUIf82HOdt61h78Llfqxk49M4e6oYebw8X3AKFEDliGSfw6ypO3X9?=
 =?us-ascii?Q?xHTRNq9u+Z/l1Wbxm029MbmKHiaTT8tjaPtEITABbc/JUwBf8efnRjb/DDUZ?=
 =?us-ascii?Q?l9mI+QQUyIJDgDvkeNbleLE/P0wWuSJjLYdlMKFGEyI/yJaUY0w8HJQlx+P5?=
 =?us-ascii?Q?SNziVwCQUGRlk+r7HYnvGwjds/uYLfgwPJRKfRJmkwuipKinsnH79o/l3QJz?=
 =?us-ascii?Q?XBnqFfl7MZFpXLAgU/bNT+mYepMbkHDnDWDiu5zZTot3eXt1zTcUL8cjvn4N?=
 =?us-ascii?Q?5m0xoz8p7o68xYwdhyTLADMyePSaalvomu8cmkmsJNSRsurBPexKbzWjEKBW?=
 =?us-ascii?Q?XhqOXskIT/KSWYmWVBEKdKtaxTn8h/HgF6Mp14cCHk9wIGmZpctjwCby8YD9?=
 =?us-ascii?Q?lyd0E6J2KvdtFOX/rl0ovyU1MJZEtFsoKS10LK6ENAlNQ5/RgrVuVYlgBqgF?=
 =?us-ascii?Q?V/phqNwcD2xEbHBwefNrkkDG2c1kctOJDAC8ilxq6CxHXD+zuQt9yQR/eYdl?=
 =?us-ascii?Q?JLSk683YmMmQAXDDId0etUlB0KGfhoJLb+X7MBp2/9QJv8tLtGJSDrXEp8mu?=
 =?us-ascii?Q?3x9MRXJ9cQJ+Z5dCOGAZU+hFHpYehbtRQZCy8Y1d/A+XtCOyr7qLicQwASIO?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GRSjuSjR3mp7oe+BjFdeOmZWmx82XlcL2mEl81LRWtds9AeoVyImfy+VsLeYlHN+NNsQS6eY/dUUPNo1y4ez+7U9SwSoyk9o1mQvGJUb34orlB4Ntl3SYfE+lLg7pX6IYAktd84nIw2vPhtgJc/oSjKq/1sWVdlDOsxbqsj9zw1P6DewxgS9/GHmHl248YCCPadFqr8ktCU7sr7N7n6vTZXg39O2Na/XhBodkFQjr1aBm21+N0ER/RM39NkDze5G7tFaUreGwSPedVjQnqESY7HhoHDSXwtg9rTQs9xb4BGRMwWtSRAjxhpB/q3yU7DkBu8Tk74NCQyjvBppxsI1C+dPih/nJxgTc3QGDV8tuqG44HKibt5/haV4qN4+iQ1VqYKZJpEfKj7N/G4dOh2I83xJ8LPC/hl/O/jvGsWOOZXL/dHy/rtOD1LwHduI466oxnijFTAeuKIf32C/bcCov/HoqjBvHPH/BH8A3gF7n5jMD3nF7W5s8hNv0HxsKqXPR1U1Ynu3daxvysVAtpdrFDFgNx77JqDTqFPyjqoxxj2H9gPavbyIxAIXKTkz9V89v1jdDJ1iliZgmkA2lmwNO1Od1EM3H6YiXBuwq4KJBQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30e5a03-e6ac-4ae0-e7db-08dc28bba6c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:36:00.3781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAxvzgyxlNLcUnpSNs3yyA4ZC42LxqEw80AAM3egETPi9tKHh7rADe/4VitSd96BKqy7WCEb7IzeFFgbigY5+OnvCeeENKNPbjqIgkfjFBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_05,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=466 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080083
X-Proofpoint-GUID: -6UnkIo1sm9JF9971Tkb9lSMLtoylpDT
X-Proofpoint-ORIG-GUID: -6UnkIo1sm9JF9971Tkb9lSMLtoylpDT


> On Thu, 2024-02-08 at 16:05 +0100, Jose E. Marchesi wrote:
>> > On Thu, 2024-02-08 at 13:55 +0100, Jose E. Marchesi wrote:
>> > [...]
>> > 
>> > > However, it would be good if some clang wizard could confirm what
>> > > impact, if any, #pragma unroll (aka #pragma clang loop unroll(enabled))
>> > > has over -O2, before ditching these pragmas from the selftests.
>> > 
>> > I compiled sefltests both with and without this patch,
>> > there are no differences in disassembly of generated BPF object files.
>> > (using current clang main).
>> > 
>> > [...]
>> 
>> Hmm, wouldn't that mean that the loops in profiler.inc.h never get
>> unrolled regardless of optimization level or pragma? (profiler2.c)
>> 
>
> No, the generated code is different between profiler{1,2,3}, e.g.:
>
> $ llvm-objdump -d before/profiler1.bpf.o | wc -l
> 5356
> $ llvm-objdump -d before/profiler2.bpf.o | wc -l
> 2329
> $ llvm-objdump -d before/profiler3.bpf.o | wc -l
> 1915
>
> What I meant, is that generated code for before/profiler1.bpf.o
> and after/profiler1.bpf.o is identical, etc.

Right.  But profiler2.c before and after the patch do:

--- Before:

profiler2.c:

// SPDX-License-Identifier: GPL-2.0
/* Copyright (c) 2020 Facebook */
#define barrier_var(var) /**/
/* undef #define UNROLL */
#define INLINE /**/
#include "profiler.inc.h"

profiler.inc.h:

#ifdef UNROLL
#pragma unroll
#endif
       for (WHATEVER) {
         [...]
       }

--- After:

profiler2.c:

// SPDX-License-Identifier: GPL-2.0
/* Copyright (c) 2020 Facebook */
#define barrier_var(var) /**/
#define NO_UNROLL
#define INLINE /**/
#include "profiler.inc.h"

profiler.inc.h:

#ifdef NO_UNROLL
#pragma clang loop unroll(disable)
#endif
	for (WHATEVER) {
          [...]
        }
---

If the compiler generates assembly code the same code for profile2.c for
before and after, that means that the loop does _not_ get unrolled when
profiler.inc.h is built with -O2 but without #pragma unroll.

But what if #pragma unroll is used?  If it unrolls then, that would mean
that the pragma does something more than -funroll-loops/-O2.

Sorry if I am not making sense.  Stuff like this confuses me to no end
;)

