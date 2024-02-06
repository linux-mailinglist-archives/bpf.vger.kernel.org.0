Return-Path: <bpf+bounces-21301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 877BC84B2F5
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C118285010
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 11:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2841D5B1EA;
	Tue,  6 Feb 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AV/q71Pr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="twM26NEg"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB9D1EA6E
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217212; cv=fail; b=jzWSQZwuAT0N7C1iuR86B0e3TXIrEjRtyQQgFp66n42hkweJQXGrCisfyB6536P98/dooWUFpAAfQ+EH4VjygA0p4sngk7KVmjgjiixaNXNd7Hx+dSDD1O76ROCOFsYuElJKE64awzvkO/dERhjI6xYzHNen8YT/u5P/opucvs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217212; c=relaxed/simple;
	bh=XR6Bc2UkPVdVJRnP9uHYvYcCUF09kIcemCP2d5HrcoY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V4uvncDhAAGKGba2FEbdxHSkN3baV9BaZ82I9lNjgkOytWZXkkLjF9nVAuQf6XnomXXeSR3mieaXtfAe8CQ+U7n3bXPHJauAF0i+13D0HrV7UN6pLfKRNX0QkOCl2tchxsghEeE6ucKXxg2euh9ypVSUtDotMWNNqg4a8YT/gzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AV/q71Pr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=twM26NEg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 416A9Y5p021960;
	Tue, 6 Feb 2024 10:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YPfl+2KQnOeX2I+D1m0SQx0ymIypbb3SxEZT0tF3tIo=;
 b=AV/q71Prf7D0fOfbcmxSnkj0QQZX9ACMCez+mxvgz2Bach85E75XVlhIMuTzfny6iz/v
 rW21vU9DiOz6ILJFO5ULzQE1kiL1aIpsSVsZu2edj3hSOiBmO7cuNWE3T9IEM9BjIqZC
 qXeA+i9r+bZ0r9Vlgth25QojJATndxGQ8ik4jpruinYdJoAUWkT376Bf5QKKYZ/atW+X
 7oYrWMbYvGKb2XftL692aIPNDPtOc9Jjm0hUEzRGB+s0YESkw+wPpyWuU++bmdiJXnlB
 rlbnE+feF8pi2Wvzl1+FHWPa4CQePMAcY+YhsDJfpRuOd0sM4iT35eo3GkzjmC4a8eim ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dhdekep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 10:59:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 416A7ihb039333;
	Tue, 6 Feb 2024 10:59:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6w0pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 10:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuqWGnMOqujBZn5A+uzIlt6TWmkuRJuuHAM1YMdYqvJxtpz3PwtF/eGc2ksUZMiMdl3P00FeiuuFxzh7wkMs9Ii9/BG5UtUZYw4axlFQnyegjinldvA0t+6OyLQNitR829pcjzD8oRBsNxHJmu8KZk1CMglDMIoYjThvurtNF+60p6XdDWOLtLHcHbkAsCE5UfnHfS0ViXlT+RN2s3AnAty6AtMWr3VHJtll054ESU+rMkElITaXaDytYB/41Nvd2XEp3lH2AAT9oNnCbuy60V++hY/XtO8eWUJHk3KXjA85lYbT3Tpnv2HpTSw9koVjsKYwmuFkowk731HKOwFhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPfl+2KQnOeX2I+D1m0SQx0ymIypbb3SxEZT0tF3tIo=;
 b=mWzeSQx8InWb6Gm3hn01EWO9kbIFtuXmUu5K+2LUKlBxJvptVNV/kFXtaCvwrSln7fu81JfiUuEYzoerC7utVqkV+9qcSn0nonabPiicwXmXvvbduhy700LftEvwykLSI13ZuULExk2nYB94HpgUoP+IUp/0MvjtYtBEXZDZqHKLPaDbNG3y9+9oDysormaIqFg95tk0hO+2ciG5DJei1HbINjFDntvDhSVVdqFRQ0GPYWZLoif+Izp4S58MLo+cCEUh1Glv76sJWlS71H445OUIyvCk2N7PELNG2syqfuLRTXIAp0SovEbAJ1GC6agl36DCcPzbbmBtrTqtFgAl6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPfl+2KQnOeX2I+D1m0SQx0ymIypbb3SxEZT0tF3tIo=;
 b=twM26NEgS+CtwdGdYZnR407CFDbWuGi0ZlgNhaU2pL3/CKDUgseXRj4OVBfI2m1A9f5hgQpXu+ZNsjsxMBL5en72znD/7gsPXadsZfcPbV4xVXkwR3/eq9q82OI9FhB2wyz+dqBd4GcWA7yZWJ0RW8kPfhPoD6ZFZFuCC3wDr4I=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6056.namprd10.prod.outlook.com (2603:10b6:8:cb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Tue, 6 Feb 2024 10:59:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 10:59:49 +0000
Message-ID: <53c5bf7a-97ef-48f6-90f2-d2a170acf1b2@oracle.com>
Date: Tue, 6 Feb 2024 10:59:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen
 min_core_btf
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bryce Kahle <git@brycekahle.com>, bpf@vger.kernel.org,
        quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        Bryce Kahle <bryce.kahle@datadoghq.com>
References: <20240130230510.791-1-git@brycekahle.com>
 <01046526-c9b1-4d7b-b6b3-296c1bda1903@oracle.com>
 <CAEf4Bzb8zopBkfSxynV4DwzODgvPeM_M9rDJ+BtrfriW+TyAZA@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzb8zopBkfSxynV4DwzODgvPeM_M9rDJ+BtrfriW+TyAZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6056:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ca5c47f-1894-4003-7cc7-08dc2702bd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qHWPtmwJULWOuVPSRZRUcPjdGj+/xCqkmWjWt0gsxxkPk/BJN3YtO0fQRhqP+eAdUXauANAdLHccODpldfm02UdsJ2ixEclOlzs+N86hvmRvPjiLBph4VbQX1wrYr2fp8m+mSn0r8otgoCxrgWRVPXoMIF0ByIP0NkEm2QliwI2gi8AedpMRGc9YJEOpe51fFUxk5Uq/cHC+AEXHdErOTrJFk4/zCynZwY7sIXQNVNPjg55bG3SdZEYU3J39iwunE0Xteo7lHoB3elGK4bJSoIny0e1tyEPHiS4FdHjObcSIXV8Ox6p0NNHsFagxisFe2AxZdIh3N5CXk145AlDCNsZZf7G8gxF2oey4bLoeEuONAPUo51ZL6cJrqdhMJCGfkXWJ+6pHi6m4qWDy4/99StVvohyXkhxYmtbgQiidoqt8BgF4TPrgyttk+Hptw4U1NDwiPxhLz0/ph0g+aZFLVceptEjHGjaXQMCqn2yDHFvXAzfl00hUB2ezdIfWuWUcoTW+91nms+JU9byL9M3y/Y7ZgaTU90j6rPrxYDv1V9wKwmSQkhPRlyUnv4/OuYroDk8ReNIi0fQdOMEn8UwBrFBxjvjaK8IhbSDY8o/u5PZ7ZyREjAotslBUwgBom4hf6OBYPh/dm4sdocnf6JDyuQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(66899024)(31696002)(86362001)(41300700001)(6486002)(5660300002)(2906002)(478600001)(44832011)(66556008)(316002)(6916009)(54906003)(66476007)(66946007)(4326008)(36756003)(8936002)(8676002)(6512007)(6506007)(53546011)(6666004)(38100700002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2FXNjJGdTVwT24rbll1OG5CREZaazFkR0YxQVgva3Ira1BuaHd1bDE3R0ZR?=
 =?utf-8?B?a3lTK1c2SzBRQWhRdXlFMXFuVnNzRVVmYm1YbnJvWEdXeU91T0pWUW1MbUI5?=
 =?utf-8?B?a2FVUnlBdlVWRlRBSHJFdW1jdkU3U2sxcDdiakxucEU3SC9Qb09JLzhLbU1K?=
 =?utf-8?B?UFNNZWtlMFp1U09jV2FhWXVzMFJMWko4c2s5bVREM0JWRERuWmJmd2ZMTVFv?=
 =?utf-8?B?U1VKYkdWMXZhbjRKRVZZZVlMZURZdk1HMUpJTnYvdVlRN1hvL3c0SUdYM3Rk?=
 =?utf-8?B?b0NFc3FZdERSTC9VWHUxNFRhWnpxZWNmUWE5Qkpnb093OVJSdHY3TENzWml3?=
 =?utf-8?B?OHR0VnZtNjdEUDhNV1UyMTFyREoySEpJb05DaTA3NzBibHl6OUljL3phMDcx?=
 =?utf-8?B?eDY1aGJ5ZlBUbmVkY3Rsc3pKNENUcjFHckUrZkRGNXV0NXBtdnBWanYrTitk?=
 =?utf-8?B?OHFqbEpubTI5VmpVVHZiUHdWMFEyT2puV3FDRjY1SmljWDVEaFROekRJR282?=
 =?utf-8?B?T1FJazFEaDhraFN4RW5MNzU0VkcyMXJNSFdWWHRROUYxbEwwWUo0Q3dnMVBx?=
 =?utf-8?B?czYwcVVTNUxxSjJPOGRHV0FSSzBaL1FXaWtjOTVVNE5lVGRyZHdoaVpER016?=
 =?utf-8?B?ZnhPYmZGLzh4TEVITHQ3aVJHYUlaR1dqZHB3cG52RkpteEtTb0JlaWwvcm5a?=
 =?utf-8?B?ZmhtZ1ROOXpHcFBUczE4aE93Z3JGVzdldHhNZzFkbmVsR3U3blhMK0RtZ0VI?=
 =?utf-8?B?L2wxWk8yUFcyaVhUUWthK245akpFUzJMSjNlWnlhMU8rcldSK1NKNjZjaVpy?=
 =?utf-8?B?N1kwdjFrYlQzTXkvc1pTRTRDd0J4UjRsWTUvWjd6a2c0R1A4d1VUWjBsRS9S?=
 =?utf-8?B?bjNlMU1NcG1oNEx3MzNSUmdndEdPbmV0SEtyVTY3SW5KY2pheVdZaVRXcDF1?=
 =?utf-8?B?ak5Pd2RNM0tHWDIrQWF5aG5ZKytVUFJYSldsdE9ueUYrVzNvME1QYk5kKzk0?=
 =?utf-8?B?a0lKZDlYL0dQWkVnMzVGak51bjJKWFVNNWN4OXdyR1NKUFcxNDIwZ3ZVTUoz?=
 =?utf-8?B?YXFlTHl1SHR3N3hPcEQ3WkJ4Ny8wR29WY1gvOXV2MHIxWnJYZStSWGtycDJQ?=
 =?utf-8?B?MEthUWwrRFJZMFp3S2doSUhQNmVFSFZLL1Z2a29vcmhFLzBPTHlPQkhoai80?=
 =?utf-8?B?TXRjTDd4WFNmbzZFWUxhUGZGZklCbXhIZGlEYkU5TnFXRXhnMFRpS0lXblQy?=
 =?utf-8?B?MFVmK0hZcmNYNG9hdW5xM3Evc0FVemJnT3VpY0QvTFJIeTRkYTROeTNCdTJh?=
 =?utf-8?B?bUtvaFh3WGc5ZHFoSHA5NElCTGxMQkNwSHhMYlVYcTNORy8xd1NWOXQrcEhi?=
 =?utf-8?B?cW9mM3BMYUZHaGJaOTBvNmx2RDlYbXhiZTNTdXJmT3M2WWlZb1UvbFFuQkhN?=
 =?utf-8?B?Z2JKeWlTcGgxYUdQaFprNzduRHN3ZXU2UytpMk9LZzhaUlgyMWJDclR2VHB1?=
 =?utf-8?B?ZThyUTJLSVlkQ0hhcUM2RjhZS3lMWk1wVXY4eHgwSkFmZVB3UXNOUllYNjV1?=
 =?utf-8?B?YjEwRHM0Vmx1S3RMWXE1REFtbHJ0QXl1S2JhUU16ODJVZHpZOVVtbk55MDBX?=
 =?utf-8?B?QWtxcGkxcjcrK1RlTlpGK24rSU9WaXgvV2xhNGN1bEtPTGNWTU1sODhWNzlP?=
 =?utf-8?B?cFBzT3Q1TklOaW5rcHVxT09ZdVpPbVIwVXdXb1ZCZHZtamg1V0V0WTB2RHF6?=
 =?utf-8?B?bkcxWVNmbzdMcC9vU1ZidkU4YithZTZpY0Q5OWtpS3EwVXI1Z0RWeW84bElD?=
 =?utf-8?B?Q256WXlYU3VJelNjbVMreWZkcTZhYWZzTWRxTWY0dmRlc2N5emZOUFBYMm9n?=
 =?utf-8?B?cU9sQU9PNEpmazBubnVOcnpqbEZwY3dWclp5Q0xkVGw3eUdRUEJ4NzVQRHJh?=
 =?utf-8?B?dXBuYjJIb0hGa2xsQnpOV2E0ei9vQmQ0MG1mOWViMnZ6dnR5TVZrNkhCZW8v?=
 =?utf-8?B?dnF4bFBudERHUFB2Vm4rZGF0alVXVzJzbExlRVlTOEhNVzBpdlJYWWJ1MlVw?=
 =?utf-8?B?M1dJMHZqeDRMTUw5emNiUll2OWJQU2FPMGpQaDRLaW1rTkY4ekl2UG5Uem9k?=
 =?utf-8?B?R0JmU1g3dm5sQzFDdUNONStzSE1YL2JrUFNqb2gxK0R1Z2JadWFuVWtUNHZV?=
 =?utf-8?Q?Fh47wpm68Xhjt/r+436Uay0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7+De76a+foD3Lie2jvHrr0ip2EkY3yE4saUHw9QuGmiGQDlukVph5cYUuwuE/WR0i1ENHX6EQEqpZdZld3GzlLQ0i+zwdCgW29+BJFNkI4/fK1rtwWG8gQSv/9fZOR6lLyhsW4YKEqUU/NpS22AIfpLMgjlSQ7l5g/k3DHAR1R3giWYHD1jndGT8V29V4qhGXP0PTZMSWwINbKJa0BoXqLO8SRX3ra+6akcjJv81zp9eNuzUnyUSeOy30yVp4SKE7u1KA1I7HnsGdMcdQjBAyZmKRaQgb5e23OoPi1kpg9bc1/eTY6pwxdox+6Sane4tsrsxDBHNI9Io9PKERfUeeapyLq7T9Wku86xxY+RJTu6/TRjfUjqPZ+8IwllUdQAn8bkJyDU959oj9AtSMsyrm0dKOgR4uEgS/7CPyWFIdghLVu8DZW9Mq34xz5Zm/Tu3iESoGNZCX1tXw/QpFHAPs3H/l8GLy0lyQ5GA+4UVwlAANdZhBvw4bTBQn1wnW0xKMuiDRnJTeAPuMeygXH4LkdAXmni1p3D1mtNN61xLErbOQ0xaeFEQeZQO12YftzOXaZxyqUnvXcdrHNcJ1GcEcgtqqKukZnIRQ5G8vUSV9nk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca5c47f-1894-4003-7cc7-08dc2702bd08
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 10:59:49.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy6PIx9Z4qR/byibvrOxYnf87tfIAkNCRrTEwjPqxppJ+AS9rgWDEPJzENdzwT4CKzlK/g1TkBxh8eF67NbWMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402060077
X-Proofpoint-GUID: 0LkpoHpoS7KIg0Z6vxmGJe6oSQPS_q9j
X-Proofpoint-ORIG-GUID: 0LkpoHpoS7KIg0Z6vxmGJe6oSQPS_q9j

On 02/02/2024 22:16, Andrii Nakryiko wrote:
> On Wed, Jan 31, 2024 at 10:47 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 30/01/2024 23:05, Bryce Kahle wrote:
>>> From: Bryce Kahle <bryce.kahle@datadoghq.com>
>>>
>>> Enables a user to generate minimized kernel module BTF.
>>>
>>> If an eBPF program probes a function within a kernel module or uses
>>> types that come from a kernel module, split BTF is required. The split
>>> module BTF contains only the BTF types that are unique to the module.
>>> It will reference the base/vmlinux BTF types and always starts its type
>>> IDs at X+1 where X is the largest type ID in the base BTF.
>>>
>>> Minimization allows a user to ship only the types necessary to do
>>> relocations for the program(s) in the provided eBPF object file(s). A
>>> minimized module BTF will still not contain vmlinux BTF types, so you
>>> should always minimize the vmlinux file first, and then minimize the
>>> kernel module file.
>>>
>>> Example:
>>>
>>> bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
>>> bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o
>>
>> This is great! I've been working on a somewhat related problem involving
>> split BTF for modules, and I'm trying to figure out if there's overlap
>> with what you've done here that can help in either direction. I'll try
>> and describe what I'm doing. Sorry if this is a bit of a diversion,
>> but I just want to check if there are potential ways your changes could
>> facilitate other scenarios in the future.
>>
>> The problem I'm trying to tackle is to enable split BTF module
>> generation to be more resilient to underlying kernel BTF changes;
>> this would allow for example a module that is not built with the kernel
>> to generate BTF and have it work even if small changes in vmlinux occur.
>> Even a small change in BTF ids in base BTF is enough to invalidate the
>> associated split BTF, so the question is how to make this a bit less
>> brittle. This won't be needed for modules built along with the kernel,
>> but more for cases like a package delivering a kernel module.
>>
>> The way this is done is similar to what you're doing - generating
>> minimal base vmlinux BTF along with the module BTF. In my case however
>> the minimization is not driven by CO-RE relocations; rather it is driven
>> by only adding types that are referenced by module BTF and any other
>> associated types needed. We end up with minimal base BTF that is carried
>> along with the module BTF (in a .BTF.base_minimal section) and this
>> minimal BTF will be used to later reconcile module BTF with the running
>> kernel BTF when the module is loaded; it essentially provides the
>> additional information needed to map to current vmlinux types.
>>
>> In this approach, minimal vmlinux BTF is generated via an additional
>> option to pahole which adds an extra phase to BTF deduplication between
>> module and kernel. Once we have found the candidate mappings for
>> deduplication, we can look at all base BTF references from module BTF
>> and recursively add associated types to the base minimal BTF. Finally we
>> reparent the split BTF to this minimal base BTF. Experiments show most
>> modules wind up with base minimal BTF of around 4000 types, so the
>> minimization seems to work well. But it's complex.
>>
>> So what I've been trying to work out is if this dedup complexity can be
>> eliminated with your changes, but from what I can see, the membership in
>> the minimal base BTF in your case is driven by the CO-RE relocations
>> used in the BPF program. Would there do you think be a future where we
>> would look at doing base minimal BTF generation by other criteria (like
>> references from the module BTF)? Thanks!
> 
> Hm... I might be misremembering or missing something, but the problem
> you are solving doesn't seem to be related to BTF minimization. I also
> forgot why you need BTF deduplication, I vaguely remember we needed to
> remember "expectations" of types that module BTF references in vmlinux
> BTF, but I fail to remember why we needed dedup... Perhaps we need a
> BPF office hours session to go over details again?
>

Yeah, that would be great! I've put

Making split BTF more resilient

..on the agenda for 02-15.

The reason BTF minimization comes into the picture is this - the
expectations split BTF can have of base BTF can be quite complex, and in
figuring out ways to represent them, it occurred that BTF itself - in
the form of the minimal BTF needed to represent those split BTF
references - made sense. Consider cases like a split BTF struct that
contains a base BTF struct embedded in it. If we have a minimal base BTF
which contains such needed base types, we are in a position to use it to
later reconcile the base BTF worlds at encoding time and use time (for
example vmlinux BTF at module build time versus current vmlinux BTF).

Further, a natural time to construct that minimal base BTF presents
itself when we do deduplication between split and base BTF.  The phase
after we have mapped split types to canonical types is the ideal time to
handle this; the algorithm is basically

- foreach reference from split -> base BTF
 - add it to base minimal BTF
This is controlled by a new dedup option - gen_base_btf_minimal - which
would be enabled via  a ---btf_features option to pahole for users who
wanted to generate minimal base BTF. pahole places the new minimized
base BTF in .BTF.base_minimal section, with the split BTF referring to
it in the usual .BTF section. Later this base minimal BTF is used to
reconcile the split BTF expectations with current base BTF.

The kinds of minimizations I see are pretty reasonable for kernel
modules; I tried a number of in-tree modules (which wouldn't use this
feature in practice, just wanted to have something to test with), and
around 4000 types were observed in base minimal BTF.

It's possible we could adapt this minimization process to be guided
by CO-RE relocations (rather than split->base BTF references), if that
would help Bryce's case.

Alan

