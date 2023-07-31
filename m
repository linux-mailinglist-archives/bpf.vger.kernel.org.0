Return-Path: <bpf+bounces-6451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93AD769B0B
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 17:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D250281455
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 15:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08CB18C39;
	Mon, 31 Jul 2023 15:45:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B86514F8E
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 15:45:56 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0170B171A;
	Mon, 31 Jul 2023 08:45:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTLIm009050;
	Mon, 31 Jul 2023 15:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=BAqiTFCJh3WCiKiNLKxDrnvly24Fo7wIZ+/Ao2pFaps=;
 b=OMcozcqk3QwU5UPe+jSdoRXhDGrVzWwqjsAX0anNG1mJvzMn1hcNYdnaCty/BrjaY5bL
 1J/hi5/GAsX1YkpwHQw1S4kR/uIv2aphfalb2LGbtZlmg0xIDNLXAwXQOdBCFfE1nhdD
 S8mQnMhBMnKA5pxFjktoOeD3Er5jEKGKQeEWmLYvVj6iWBMyldBPcXSGEC7oUKeO/ShN
 wP6BGdy3bV9wkiFVgdzJnQH0grjcf/21gIPRh8xBje51erENO1dUfCCLPRXMN6ncILXV
 J/angQaBI1ltmrE9hSAoBvmMszHp1Ku6WXBJ8QoN8s1lvOjV4Euo4FceU9vIR19vpwQt 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcttwbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Jul 2023 15:45:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VEpc92000832;
	Mon, 31 Jul 2023 15:45:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74t99d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Jul 2023 15:45:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPQcYECL3QuVOw/l0tFVlSDDQS2ywtLCjOAnPUwzaFkg681RRDe4Md01w8OP1j8ms4BqP5RZ/1e7P8BsVqRBfa9761PjLBeHTOttg0eXkZ5EgDPkjFMIL7LMe2HsFPHk5WbV1pQTy56HpyVaJF6Rhn+XmLy7X5puEGOOf0tn8Cgo9Q7Gcn/Zc7/Qwh7P/oHSGupmVVg6z2ZcTwIo6SLKgKveMuRpllk9LjjPnpfC/piEgshKqGIc7KgnLEKCyDVTMsYGM8qupdm2B8u9SRHtm8vVg8RV37heo1dHkmtQ90y9VQnABvquCmXCFN8pJdCwjNCpAvOfYXYfEnj9Hq+xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAqiTFCJh3WCiKiNLKxDrnvly24Fo7wIZ+/Ao2pFaps=;
 b=mFjhLKG/thfu8bBMMd6j4WlDdvMLK6nzYHGsmq2dhEvK6ExAoBWFR+H+vM8xa3DP8ob/k+xFTnW839sLBRGx5YGT1Jv9ndqNFn7ZoGGQO50+MBx3EUN+mO/+aU9ixKRr1GDC1mtO3KLvtB4FyezrXy/Yx6kAbXCkxwicoeSMb0spsrrJ8jKx7MhuiJNPFwRBukvme+saPmzEPF3Fqa+QfCWuK2jUT2s7XnWpsnJEN9UsXMD5Thp9ZwhM5Ivq/LtNeTHuYMuA8I0O0TzDlQ4IhcnKjxCEIYLqK6YW0P2c+wNKpYbcsJpUfTl8SQK8YET4nJktvD2G8rueFHrj6nHIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAqiTFCJh3WCiKiNLKxDrnvly24Fo7wIZ+/Ao2pFaps=;
 b=CLrmLeQuy7a3kDlRSz5WRwaDTp0wF5N8Kwu/PAv//IsO0YyPlJJdrdXcF2Ba1pydHEphcYRhqo5pxZujxs/GKY564n+k7PwlkLXThvWyLxakcIeqWI30DDN3i5ZdWC8n7DS49Q69Tj2DBe6gVX2NIdPtXEJwWOUhyorLcG4+vns=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH0PR10MB6957.namprd10.prod.outlook.com (2603:10b6:510:285::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 15:45:38 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 15:45:37 +0000
Message-ID: <c5accb4d-21d1-d8d9-85a0-263177a06208@oracle.com>
Date: Mon, 31 Jul 2023 16:45:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo
 <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
 <ZMDvmLdZSLi2QqB+@krava> <20230726200716.609d8433a7292eead95e7330@kernel.org>
 <6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
 <20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
 <20230727105102.509161e1f57fd0b49e98b844@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230727105102.509161e1f57fd0b49e98b844@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH0PR10MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 72933f95-1659-43f2-c8f6-08db91dd2f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0d7aAIGVgK1nRJcnk65vLOH/3CpBMpjSoaC9zqu9yN9NJ8qq2dGpheNam7EeC+kg8AzlzO/liBRXo+TLqj9Xld7EkFXT/xEQ0Ga1fe5P6hcCp9oOEkX/KA4FaQngc0IAR9ndh0X4jz8/k48cSKNANFVnoHAOPwkoJwg768EA63d2GU+/bFkhXJtvuV31fRiDyZPAWz3etf5scpKvYhHgviT9B6boymXlzVo+FwXyf8QkwKwv9orYblp33/4O9DjWcmhlA9iRPqyBcA6HtOhiAMYpa62EwdG6OBS7MIwHlpomF2D0rHKm91EdPD4oTwa0byly3ejvKG1XXH62g1yDKfwd6Fmab5AUDfpA2aHb0hXaPKlJzUb0o6Uc3jhABz4dhryGMyF91gE/l0tERF8eI0r+WPwMooMTAUlylDsF0tasRXFODE04XyXPwPLsfTZf/t6CPi+bQbLQRSfthIkQEYVItRiDuwX0z+MqOzbderQlIQgi4Fu/ED5FpinUfl0CbJMsVuWKE5UFn/od7ld8PQZJleei65t9PiL9rfgEwutbLBx6Wf5PFtPr1WS5qRes1R2m2e+Udx4P761cClL8VdU53yv7cmDDUbadt9swq99gmXp8xOmjf0wZuarX+J51NhFVrGDaley4mT/UfVhjUg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199021)(6512007)(6666004)(6486002)(186003)(83380400001)(2616005)(36756003)(86362001)(31696002)(38100700002)(6506007)(53546011)(5660300002)(41300700001)(8676002)(8936002)(31686004)(6916009)(66946007)(66476007)(2906002)(66556008)(316002)(45080400002)(478600001)(44832011)(4326008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVZqZkZ0N2NSNXpKajNNNUZmbzkvTmMxUGdhSVF4RE52dStKWnZadDVNKzJq?=
 =?utf-8?B?NVFodGl3dU9KL3hlbDEzMVFMLzVQb09BWGdzWUxDZkpDa2RkbmtwSEZFQ2pR?=
 =?utf-8?B?RWpPaWZsSzVGekRvMTRtYlFxUHYvZnFIVnR4a1U1WDl6WEpWUEd6Vk9lVW16?=
 =?utf-8?B?MXRrdG9DR253NVZBRGFqN3M2WE92bndITTJoeWpPSHR2M2MyaWRVS21MWHhx?=
 =?utf-8?B?UUNjUHpVbFdoMjRnYTFPdE1Xb2hjdldFaHhWRlE0cXFBdS9iZXNPUE9BRUhj?=
 =?utf-8?B?TDVqRlpmS00xZEN4dnl0YWpJZXZVTjl4QjJWeGFMdERlQzh5bWtTamY5UUZV?=
 =?utf-8?B?dzFnakxUV3lzQUljbi9CU3JaZFRIUzVHNzRiT1hLQVJVeWVKTXYrYis1WWQ2?=
 =?utf-8?B?WHlIL3YyMTRycStyTitkOGcyK3MyMFdPdGFVVnppelBpQUpiVEozcFZYSFFw?=
 =?utf-8?B?eDNNRDBqSHlZd2kvNHZQMWJPRjl6bTBacGdjcWNxUnV0VXNCNmtYUEtOVG1y?=
 =?utf-8?B?RkJhUmVMTk9may9GWjJlbThhRXlOV3l0ZWJ3bkxWZkN3QktBRGZETUV3OVU4?=
 =?utf-8?B?Z3AwL28wcFJ5Ukd5YXRCbk10OGZHL3c3RVhQdGZiQUNwRDhHdmJRSC9XNHdy?=
 =?utf-8?B?TUlXOWNrSlU1ZkU5L1NIRVF0WWowWU1hWXUya1VsVFBlRVkwZ3pvRDZ1YkY2?=
 =?utf-8?B?dXE0QXBqOEF0UWZRV1pWOTBBQjRtT0JFVW16RDJkZ3o3SmRFUng0dDVVRjlx?=
 =?utf-8?B?ZndwMHlaZ2RCTXFuS29Qb3htNWl4ZkNPNXFPVzhzOVhiZlhMMWFBZ2pMakh3?=
 =?utf-8?B?M1RvOFpzcXlNc3BTaFBDVG1hdHJ1Vm5DTXNjQnlFWElNL3BvWCtGSUZZbUNE?=
 =?utf-8?B?YVJMRHpZRGkvVFo5QXdlcUJHdnhqcmduYnRxemRTQ0ZqczdsKzZTdkpZV0JQ?=
 =?utf-8?B?aVZXWkp2Ukw5TjkzVk8vTFYzNzZKTFh4angrWHhvTUR4ZlU4cGhteUUvbjlM?=
 =?utf-8?B?ajFBSmtQMnNLbkpuWmkzT1hsdWdDVDZXaVcyRWJSV0tyU0Znci9KT2hFOXdM?=
 =?utf-8?B?WE1tZ2NtaFRHRnhPK0x2Y0JCVjluNlJaUDhBcjVwRC9OeWh4WU1HdnRwdS9s?=
 =?utf-8?B?THN4UlpUV3I1b3RFVm9EUi9sdDJvS25YRkh2UklNOWtGQklQRTJmUGQ5M0po?=
 =?utf-8?B?Zm52TXYwWVhLVUJJTk1vNExKTk0zU0pUMDlma21vZGtxdDZ1YkNWU0s2ckls?=
 =?utf-8?B?Z0hYWTRhdHNDRVBvNmZaY01kZHpCNDl3RVVUSFVOTzg4WnMxNlZLd1NucjN5?=
 =?utf-8?B?aXJVYnZCc1hGQXp5cERoNkhiR1dFS3BZemV5ZFlocTFBbXlSU2RZaGtjN3Fm?=
 =?utf-8?B?eXdaWDkreWEva05EVVhvUEtLaElFMjMrVUpGTVJHOW5XcVdsNVAwMEV4SDBq?=
 =?utf-8?B?YWR4QnZ3MGNFL3ViYVJnWEk5ZVczbjRQQXB0YlJoVTh6VzlFN2RCWnFqdHVR?=
 =?utf-8?B?d1UwVmRkemNSQndVaVdneVFEV2xkZVJ5TVVUVUJJN2Nja1FMZU1reFVMVUw2?=
 =?utf-8?B?ZEt3KzlQZ0twVzVXRzgyNGpqdTZCY1UzR0J5c3kxVk9nWWh6cUdRUlRObk5H?=
 =?utf-8?B?aTZiZmlPdFJhSElDcWFJZTFzTkRNbWZKenpjS2poYkozREgvd29hK3o2a2Rz?=
 =?utf-8?B?cTBkMkxQUDAvcVhuNnFxUXFnS0VpWmtuMHA0TG03V01jOEtSWUFCWmhsRlgr?=
 =?utf-8?B?SGxybnRySWZ5d0QzL0ZQVTNEdVlBN2NZb25tWFI3Q29MMEp3MUp1d25zclpD?=
 =?utf-8?B?K2gvbng0VGgvL3hOcFhFOFpJNmloMnhFNEV0Wk8waFd4OE1XSnZxazROOU03?=
 =?utf-8?B?SzdndTJGV0VtZGR4QnRiN0oxTGVCOVQ1TStCbnpaYlZaMWJ5OUt3M09nWjlo?=
 =?utf-8?B?VmxRQTd0OXZHQVl2VlV0NnZOdGJOTXlkNkFkajEzSWJYZXd2czBkcWMwVmsx?=
 =?utf-8?B?bFN2ZTdnS1VWVXVWN1pmc3A1YWlMUkV5MWZVNlpuUWl1TkhYdWdKNXJ6azdv?=
 =?utf-8?B?Sk9ycTFzb09TRVB6bjdTRUxSKzJzOE5yZmh2N1RwTjJ6WVV3akZwT0RRMUsw?=
 =?utf-8?B?QlluMko0d3d6ZkRqOER1Vng2ZUlBVXdwWVZZYjBxNmpGMU1zVlZiNStWZC8x?=
 =?utf-8?Q?W7ue9S+rBxm10DivxLV3KTs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G4+V48gDmc+SQQfU5oInRl8HUHfBZB+NRHl3g9CxsnSrzHXU+TCIFi5tOrkwR0xwHHtZP5XLx4eCUDq7wdKuBlfk8/W7frlwFHE5iipJNsfn6FSJyjHEuIXKZKMd+4myyqQZiXMh6hxfhhTm8mr5iD8x6Aw4Bm6MgyfrnpfhWgZS3t9YdP9aMr1T/22Eo1+lBasA9ccGZJ1Wwr/E3DpPa++oz5EdLzIAHI5tCPUpxpy4VmblszEMDvYKh5nifrKAkRKq1JhrcHamwGAOG85FW3pLlldfQANjuxssEp4WW/sA+5vlMZ8iuu11x/YsMQUg0mA2msY5XWIkQXsYEvgvXxHoy2WWcn6K/ouEpyzFcKSIJJks81feX9rZ1pJPGl+ojjOzlX1wNRUno14gCnayKFNcrPoUvxJl5lAH+FKa/CTIux4fPlIOulNjOWdIQzYQeYSeIwtSc9T/16fnyNG4/5remrSP20MVxHqK7OiZYOwCEqWXXu78W2+M6XwKD8b5o6Rw2oP6oKiB3ByxKU/1d3pqkylFG0MZDJhTbbM0bGm9gt08t6ozBOeCVkzE2J/dVqS83D8U5nF7MmYcN65Fhbn+gZIteNIOOjW2ThUGlELd4hQT91SSn/R0QlgWMgJijAf+EFMDj0owFTNdbNPsfRTGkmwotfJh98VrIzNYV14BdEdsdHoNCRQj54ZH4RxAInKJ31qZNTW1231ja2b+vgQVN89KdGFqvFLVJtJ8U18wEziPHpDCY/DKoA1WncjJEEos1bJOKi0yvz5lnDNLcsDCIzSnSSJqqAtbBy2ZEb7P9LyYc0Vpqn7KyFDE9gLIAsKtdHVunX0LkVXYM06VFdnOmHT57/+fov848nPwXixhd9mdoDJGEWxpZFK9D9/eeuPpopovNvIPqXpBZOIviw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72933f95-1659-43f2-c8f6-08db91dd2f71
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 15:45:37.8295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mptSGq8wbIFTx+YMpelw/GqkaYfjfsxNrgdOzzF45t5yu/46lSpwfPK3qz1+KBkLOMTSnHZQ8sk18lQXeGEnRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_09,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310142
X-Proofpoint-GUID: R2KwNvZ3t6wYDVFZcA7F0u0v-OOLcvym
X-Proofpoint-ORIG-GUID: R2KwNvZ3t6wYDVFZcA7F0u0v-OOLcvym
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/07/2023 02:51, Masami Hiramatsu (Google) wrote:
> On Thu, 27 Jul 2023 09:38:14 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>>> Yep, BPF generation is more selective about what it emits in 1.25 to
>>> avoid cases where a kernel function signature is ambiguous (multiple
>>> functions of the same name with different signatures) or where it has
>>> unexpected register use. You can observe this via pahole's --verbose
>>> option (a lot of outut is emitted):
>>>
>>> In a built kernel directory (where unstripped vmlinux is present):
>>> $ PAHOLE_FLAGS=$(./scripts/pahole_flags)
>>> $ PAHOLE=/usr/local/bin/pahole
>>> $ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
>>
>> So this will generate BTF from vmlinux DWARF info.
>>
>>> If you want to investigate why a function has been left out, look for
>>> "skipping" verbose output like this:
>>>
>>> skipping addition of 'access_error'(access_error) due to multiple
>>> inconsistent function prototypes
>>> skipping addition of
>>> 'acpi_ex_convert_to_object_type_string'(acpi_ex_convert_to_object_type_string.isra.0)
>>> due to unexpected register used for parameter
>>
>> Ah, that's nice. Let me try.
> 
> $ pahole --version 
> v1.23
> 

shouldn't this be v1.25? Is it possible pahole is picking up the wrong
libdwarves? what does "ldd pahole" say?

> $ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
> die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!
> 
> OK, so something failed.
> 
> $ grep skipping /tmp/pahole.out  | wc -l
> 0
> 
> Nothing to be skipped.
> 
> $ grep -w kfree /tmp/pahole.out | wc -l
> 0
> $ grep -w vfs_read /tmp/pahole.out | wc -l
> 0
> 
> But both kfree and vfs_read are not found.
>  
> $ perf probe -k ./vmlinux -V kfree
> Available variables at kfree
>         @<kfree+0>
>                 (unknown_type)  object
> $ perf probe -k ./vmlinux -V vfs_read
> Available variables at vfs_read
>         @<vfs_read+0>
>                 char*   buf
>                 loff_t* pos
>                 size_t  count
>                 struct file*    file
> 
> However, perf probe can find both in the DWARF info.
> 
> Thank you,
> 

Unfortunately (or fortunately?) I haven't been able to reproduce so far
I'm afraid. I used your config and built gcc 13 from source; everything
worked as expected, with no warnings or missing functions (aside from
the ones skipped due to inconsistent prototypes etc).

One other thing I can think of - is it possible libdw[arf]/libelf
versions might be having an effect here? I'm using libdwarf.so.1.2,
libdw-0.188, libelf-0.188. I can try and match yours. Thanks!

Alan

