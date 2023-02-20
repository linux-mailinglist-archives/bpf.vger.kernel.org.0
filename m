Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8973A69CA09
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 12:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjBTLlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 06:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBTLlR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 06:41:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1068D1B30F;
        Mon, 20 Feb 2023 03:41:08 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31K9Ds0r028910;
        Mon, 20 Feb 2023 11:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=M5Xr+FOhRLWdTOs2D6Su3QI3kthr+E8W6QWMwYGvx1s=;
 b=0oqBc+h662Be6Pj5P4hVwSKwGiesF5BoS3sEW7GsLGl1H/bQvjYYx/MV6y0lgDnlcIAQ
 PwUD6YBoPcYvytK73vqWUTQDvkxCayL7GSmU2OGdu+wwwpkdtdDweBITg37mP3n2hx6n
 bCkfbEjEb19MIB+MMAfzvmDo+yd/TKVvcuzqNbz5+MGxP0rap4AMmL4Ijq/DBQIZbEiB
 l5aQ2yiLSV40TDw/YIFrrh/dNrOzFFjPwbe8//zkjA5mPlklUi+bvmf/ic+tUe0p3rkx
 63JUTjYbHqtVun/mb2fF3gTkiTjETbfXLCEEEKiU3k2eohRCGeC41ipiY3+YZu5tRYyb hQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcax33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 11:40:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31KBLelQ000309;
        Mon, 20 Feb 2023 11:40:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn43u8bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Feb 2023 11:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKX4q0MswhkIYamBnQyZcctlBqBT6J6et/DqtLqpVaK6LnikU+XhK03fwPDatVbljV9BaKc4wwBUM4qGKwiBd2tQ71ls2rCX7amQxEfMbvy1BNBApqtFmKrC0yScN2dhqYRRE8dgFx+15DyTZhaNtWxyf7jj7WwZEo1Gvbgol/ckv8ZLSZXqa3x2nJi/K1ZXOY9FdcAddub1mzJhN6k97KahB14Wid23RwunrFB9jSZSk8SYBm4dMFAwbakR7apYxwz6do7LAa6bsumyEgNGCS8R+2bEshQitlOR0YITOxxamRxvjm97+pOQWq/hYpnGyFyTy+FWk4N4YMYUtDxx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5Xr+FOhRLWdTOs2D6Su3QI3kthr+E8W6QWMwYGvx1s=;
 b=T/gDEquVJy8y5h8TaWM0ccLt9XvCMEdjKx83xnabs0XoXstMKi/oSQyIjfA92qElAU9m+JlVk9qzdpD+ruwyxAdjovtHfO/ct2y4XYiMxKYEZQEXowBJ9aUNWtkOZ1i199AyUd6IDSXHd9TMlwD+HLnFYPX3kXbxUA5XFJifWk49Ku3YTg05277wfdabo54dHrcYkQFQ/t41KU9zVKo4jyMHWoUiNx9jd02wAC8DMxKZLIvudKHfuG+Gbe05u4v+khkD6TZLzs4FiT0SAZxKUQZdwMZsE5Pqb2xHN4d4/KqvzEh2qJbtiFeh5goDW0qMgpWaOjnizrZjIyHpoZimmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5Xr+FOhRLWdTOs2D6Su3QI3kthr+E8W6QWMwYGvx1s=;
 b=eYUWVHrlYr/wbsNlUagFOUQCns99MHu/Cgsj5bkl3fJ1jFTzEpr6NgFm19VWY7rGa48GIQMkqE57dvFW3mqyxQj6Gm948TtYGnIcWvQy9CP6YESqDtfNbyGmeP5l76LQ1/NsVXvG6IDl+3RFUAy+8pm5cCuyet7rXCGl7jsFZA8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH8PR10MB6478.namprd10.prod.outlook.com (2603:10b6:510:22e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.14; Mon, 20 Feb
 2023 11:40:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6134.016; Mon, 20 Feb 2023
 11:40:09 +0000
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: split test_attach_probe
 into multi subtests
To:     menglong8.dong@gmail.com, andrii.nakryiko@gmail.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
References: <20230220084711.261642-1-imagedong@tencent.com>
 <20230220084711.261642-3-imagedong@tencent.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <ca75773c-579e-3d1a-aba5-a70fce076cd5@oracle.com>
Date:   Mon, 20 Feb 2023 11:40:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20230220084711.261642-3-imagedong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR05CA0133.eurprd05.prod.outlook.com
 (2603:10a6:207:3::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH8PR10MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b05e18-2e20-493d-2e41-08db1337388c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqclmG0sVesRn2AWEVPEZ+hzSTHLgcSjATvUQWZ6J6S4WWXt42TFwVrFJh6+EdE3GShydITvnZDgtQBczzMAaGSpTze/OfHIv8/IyyvywUPW/gyh1GQgiYcyXeljvB3RpWq5iEViduS+SyXKICxRBoNDxA5AIm2BIn3Ps7LU7V1U6JCbanMyXTygNpCVn/cE2pUpp19JLbh4JqghDcE/TtvfIienzuH6kdrePLdnnNyvRmXYlBJalyT9vPto9Fw8Iws6ZrSJV8hz/sunsZuT2xVc1E1SasyVjKfobtWrACoo5lq0QAvINK4ayAUn3w0icAblBfTQ4xI6SXh5bmZPzobg3AT+oQl8qUaB2bSBZkqC5B2NG7Zh/I3zrAWktDcloHYZz738fX0+pPuJcr+94CokhuNM8hxCpBs6p3fJp+zLmtNv49BFSpNAmWZMxIsbmrISojEejXbJTq3oLMnN9uk/AsNeWp5prx1oe2UQcQd6RXNpmid2fLmXIumlsGB27FWEOMUofHIh49acu5rjTZMxswjTyE3bMC/Tqt7T9n8LWoTulkS/MDXWYywP9caaZyv5LRYOipzu+bpW273WamReI3CdMvf0GWLDyyb3GdD37LH9E7vQyE9kHYSyanQuOAsrH0e/dk3cqjTXW59NP6HxLWVEEGGHH3G55tsVsr2t4qGuHIQ8t/S7WZki+bgtuqQlHfOOl2yqYjky0hB5qcPI5ZI1hbSf2gDzWaQQLt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199018)(41300700001)(38100700002)(7416002)(5660300002)(44832011)(66556008)(4326008)(8676002)(66476007)(36756003)(2906002)(66946007)(8936002)(53546011)(186003)(2616005)(83380400001)(6506007)(6512007)(30864003)(316002)(6666004)(6486002)(478600001)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3NXemlvWURsOGczbXZDTmt2R1RCSmE1bk1xYVNpTTlsT3hlVmwwTlNkZHlH?=
 =?utf-8?B?aTVnZGNlT29USjlyY2o3RzVjSVBUY0grZk95SS9aMHhqa1dDbmVNOEN2cFVq?=
 =?utf-8?B?YytSTzFscDFJcXlGdG1BT0JyeEFrQ0hsU0d3c0xJaXRuenJKU2pHK3g5ZXZ3?=
 =?utf-8?B?UVhkVHhrUXlzdGc2OTd0U1ZYcktyWlpvZTRyUlE2QTBEVXVOSEtUclVxM0NQ?=
 =?utf-8?B?N053cVBtQVhVQWJUaCtxdE9vYmhZNXhId3RmckVMTEZoOUZxOU5nZnVQWDVV?=
 =?utf-8?B?eitFeWhMdUpPK3hGYWZQSG1wVlltaFBSYW1lWnA0dkZvQVJzMGU0VVVIQk5Y?=
 =?utf-8?B?ajR5TXNQM05XYW96clRRTS9jN3BHdEJOd01XZGJ1MFBnMGU0Y0J3dkR3SE9y?=
 =?utf-8?B?eTZZNW53Q1B1U2FOZXBtSU1oZW5WWjZrZ3N3cVV0QmU1d2owbmN3R1RtYkN0?=
 =?utf-8?B?bFNDVHFMb1h5Zk9Pd29KOW9KVGlJRXZFZkk5WS9Rc3NYTURoNktQblBjZWhM?=
 =?utf-8?B?NnhvYXBvOG1qT21KUSt3a0R4M1B6WkhWeXRIQzZGMnc2VkhIejV0cis2SmFR?=
 =?utf-8?B?eENUTDYwaWx1aVVhVG1TLzlvTG52anRGZDZpZmZUSk5LaVg3NXc0dk02elQ0?=
 =?utf-8?B?NlFHR2FsOWx3NG9qdFV6SkcwTVR5VFpULzlzRG85b1paZWhyVGdRdkVDVW5P?=
 =?utf-8?B?aEZqVXpHcTdIZFloM0J2b3RhdG9yWTlVb1JhcnFDRVdGV1JmZkhDN09ZL3Fw?=
 =?utf-8?B?K1dRK0RHRmUyb2U1ZldwaXkrS0syVHRmOURMZVNXcEVkQ2xmNldmcnFoY1gr?=
 =?utf-8?B?U2FDaVR6bEp6bVh3eVhmUFdUQnhuSXlLV2ZUWjhMQ3U1MHNyZTloSlI1QUxR?=
 =?utf-8?B?UjRicWhBNEFtQkgrYmlBdWQ5WXJOSVMxSFZ2ekpCSysra3pReWtZMVh2WTd4?=
 =?utf-8?B?YkhoSXFWd3BneXZtMzkvM3BFQmoxS1A0bmZMQ1FGSE15VnJwNzdoY2F1MzZN?=
 =?utf-8?B?K2IyVFZjWkNBanNKUExETkRIajFJcWROenlVTy9XSDkrVFZpTGlVdkEvbGY0?=
 =?utf-8?B?eTBuQnJBdHdZeUYxS0pGWkEvb1FIaDIvRWlHSUFKOWx4cGJLTjNQck52b0ly?=
 =?utf-8?B?QlJscC9ZZHZqNXUvaThLVmRYK05nVk5wUU5TOWhqdHJGQzBYSUo3SS9LMm05?=
 =?utf-8?B?aHJZU2UzUllmcjN3RE5CNWFIbmgvZGpvVTI4TmprSWFUNjUwazdiMXJ2eHM2?=
 =?utf-8?B?bmtGQ2hlYWNVR2d3bStqK3RNN1p2S3NURit6YVdGREQ4N0piaSt5UnJNWlFO?=
 =?utf-8?B?ZnR1aFNEUFFwaERNWk1TZ3pNa3FobVg3VnB4TGl0WTBMNnkyQ0w5ZmF5SDNn?=
 =?utf-8?B?SVhudjZJWDZPVmFxU2swZ2FnQWhDU1RqQXdrTGZFWk5FejN3WVZQWXN1Y29B?=
 =?utf-8?B?SUY0RnlWakNGSm43WFpVWHdub2ZPMmpsb0hTMUE1QS9Udlg5cHlpR2VYRzU3?=
 =?utf-8?B?ZFJkVTFvVE1kSmZZb1JDOTYyd1NqQXN6ZW5OM3hTek4yWklsVVdaWWN6OTg1?=
 =?utf-8?B?bTZjUFdPMi85bG9yTEtQNFJMK3NyU0tDeUpDSzc1S1dJMDFWTTh1bkxsa2VR?=
 =?utf-8?B?TGdiZ0FCeEU5SThLSDVvNy9tTkN5RUR5TVU4SlhFa1NJZWlHN1lwRjI5Rkpp?=
 =?utf-8?B?TlFjRXFOa2RneE5zejNObHhBTzdaRC93NmN1VllMS2hPTk9sdGE0eDZZOVpa?=
 =?utf-8?B?QThSa2E2dkFvZzI5YXlHN21tVG85NHU1b3Q5RzQvaEFxR1BGZXlVRHBIdlY3?=
 =?utf-8?B?dU50a3lmcldDTDBhUzVNTEw2TjdNOUhneWNHVUx4Tkc5Wklpc3l4eDVOOWhN?=
 =?utf-8?B?Z3JFU2FQMzAyUXBTa3gxcjYzVEdnMlU4RXFWWStXd3ZTUUExT1BqTzdOTHJC?=
 =?utf-8?B?QXptejlKanFTOWJFZ1dKbytESU1Dei96QkFSYnN5VFlPV00rUUVMOVZDUkNu?=
 =?utf-8?B?eGtuMXdVbCtFamlCKzB2RWhEaFk5T3VEVUhTbGd2ZERKbGd5QUFjWjN4Ynhq?=
 =?utf-8?B?Qk1aVDcxQjE0OUs5MWhxdzQrUlhSNkFqNFo4T1NZQWhPVSt0NkJDT1RVT2N3?=
 =?utf-8?B?N3c4NHg4cmNtK0ZzcHd6QlVUMEg1b2J3RlAwWWQ0dFRRN2R3ZnpoN2ViOHJM?=
 =?utf-8?Q?VGIUqFx5/C99vo+2jX9R2zM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aXNORnltbmhBS2pobE1sRnRPN09DVElDbWdtY0dydjVwbzRFUDVkOG1KbXJu?=
 =?utf-8?B?ZytNS0YxMWlld0k5Mi9NWjVrWEVpZXlIV0pHL3NqSzZOZ2Y3enN1bVkxaWdt?=
 =?utf-8?B?WDBLemN2SEFrN3AxZVdlc1d0S0ZnVTBqSzRFRVkzNjFuWU5FcWRnNzNGeUVP?=
 =?utf-8?B?K0J1Sk4vREt5MnNFOStpUGJnY0ozNlFITmRNcWZvV3FQQ3ovN2ZSWVlLNE1v?=
 =?utf-8?B?QWhFK3hoZ1E1ZmUvaHk1SFBSd0VNNjJPTDQxcXk1UEdWV2NjNXVHa2JiNm9o?=
 =?utf-8?B?Tm9tYlpiOEUxVTBMcWZZZTI2dmxaMGlNRnI4SHBmSnFRd3cyNk5mSU1NS0FX?=
 =?utf-8?B?dVp1eTNJdGtwdGNtM2g3dW1VUmd3dXNRSHQ3QnBZRVFQcGFZTDQ4aHluZGpB?=
 =?utf-8?B?UTB6WnJqMmdRVUhXVUdrMXpmKzlUbm5tNkRwL0FzelhGaUxDMm1lSy8zZDli?=
 =?utf-8?B?Z01WNVF5N2ZLdVZnOXJWbVd0cnBKeTZaV3NHUkFBMkFMeWszemtYYjdUSFM3?=
 =?utf-8?B?SEJZenVISnltbEhCdlIyZ3U5dWtyVmFLQmNTQ29ha0UybldVUWJsZUU2Qy90?=
 =?utf-8?B?NlVQQjFIM3RHRmRnK0h1ODBVUS90Ykt2M0FraWV5SllMZURuSjQxRXRyZExB?=
 =?utf-8?B?SXkxOVB6bGE3Q3dxYVBTSjdldTVjV0NvSkVCUFoxWSs4TU5KU3lUTGV4V01C?=
 =?utf-8?B?eURiTlZ5NVljTkxDbmEwOW5hbm9vSGJiVlVKUDJaNGEyZzdPY1h1UEZ4K291?=
 =?utf-8?B?VHQ0YTJnQXYrQUJsRGQyek4rK2hGUG85NERFdUszQ0VybWlyWXBuU29kRkt6?=
 =?utf-8?B?MWxucjdIZFAwYmZuSXc3WkpRMm5NYVU1UVBOL0pNZHMwZWNCejJ3ZWhFcGZN?=
 =?utf-8?B?b1dvOXM5OGdPMEhiaGlLRHhIVHFLdU4zN0ZmNlhYUDhXM1hwdjBsbHpBb1RK?=
 =?utf-8?B?TlFYclFYdy9oTVZCcVpXcWo4WW9FaHpoalQ1ZTMyNWpyN2hmNWoyWHBjWlhU?=
 =?utf-8?B?dlZzRmRDT0ptTmZyMlVuZkdlWHVOTStzMFk3YUJwQkgxS3lOOVYrQXhSTTYy?=
 =?utf-8?B?Y3grTWtiY2RzNElrS0QxcHpSeXdBNUlvUjI4ZWNuMzU2czl5MjBoeDdhMjc2?=
 =?utf-8?B?RGJTNk5MSW80ZUY4czdHSjluWFBtd1A1ZmtVODNab1VQcTErbUpoR1FIWWhU?=
 =?utf-8?B?aUJKVWRXTGwyTkVydlZlQ2xHU1ZNYzBjZ09HYkMzWm5ROWNVODZ1U0xwenR2?=
 =?utf-8?B?YUcrdkl3dGtWUk1vVDdLVERBNGd6Y0dhYnZKS0RkZk1YTnVQQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b05e18-2e20-493d-2e41-08db1337388c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 11:40:09.7460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNGHWB7c3xPNHsFBk04N2xKTSoMJRz35juJ1+xWwol4tY7y980yoOArc+weRD8+ob1849CHxB7B9/gq+Tr8XcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-20_08,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302200105
X-Proofpoint-GUID: eyF3fimI37XCWyBSEgDqhRbijdco2v7g
X-Proofpoint-ORIG-GUID: eyF3fimI37XCWyBSEgDqhRbijdco2v7g
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 20/02/2023 08:47, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In order to adapt to the older kernel, now we split the "attach_probe"
> testing into multi subtests:
> 
>   manual // manual attach tests for kprobe/uprobe
>   auto // auto-attach tests for kprobe and uprobe
>   kprobe-sleepable // kprobe sleepable test
>   uprobe-lib // uprobe tests for library function by name
>   uprobe-sleepabel // uprobe sleepable test
>   uprobe-ref_ctr // uprobe ref_ctr test
> 
> As sleepable kprobe needs to set BPF_F_SLEEPABLE flag before loading,
> we need to move it to a stand alone skel file, in case of it is not
> supported by kernel and make the whole loading fail.
> 
> Therefore, we can only enable part of the subtests for older kernel.
> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

this is great work! One small typo in the ref counter subtest function
name below, but for the series:

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   | 268 +++++++++++-------
>  .../bpf/progs/test_attach_kprobe_sleepable.c  |  23 ++
>  .../selftests/bpf/progs/test_attach_probe.c   |  23 +-
>  3 files changed, 208 insertions(+), 106 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 56374c8b5436..9824a5eb8595 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include "test_attach_kprobe_sleepable.skel.h"
>  #include "test_attach_probe.skel.h"
>  
>  /* this is how USDT semaphore is actually defined, except volatile modifier */
> @@ -23,110 +24,63 @@ static noinline void trigger_func3(void)
>  	asm volatile ("");
>  }
>  
> +/* attach point for ref_ctr */
> +static noinline void trigger_func4(void)
> +{
> +	asm volatile ("");
> +}
> +
>  static char test_data[] = "test_data";
>  
> -void test_attach_probe(void)
> +/* manual attach kprobe/kretprobe/uprobe/uretprobe testings */
> +static void test_attach_probe_manual(struct test_attach_probe *skel)
>  {
>  	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
>  	struct bpf_link *kprobe_link, *kretprobe_link;
>  	struct bpf_link *uprobe_link, *uretprobe_link;
> -	struct test_attach_probe* skel;
> -	ssize_t uprobe_offset, ref_ctr_offset;
> -	struct bpf_link *uprobe_err_link;
> -	FILE *devnull;
> -	bool legacy;
> -
> -	/* Check if new-style kprobe/uprobe API is supported.
> -	 * Kernels that support new FD-based kprobe and uprobe BPF attachment
> -	 * through perf_event_open() syscall expose
> -	 * /sys/bus/event_source/devices/kprobe/type and
> -	 * /sys/bus/event_source/devices/uprobe/type files, respectively. They
> -	 * contain magic numbers that are passed as "type" field of
> -	 * perf_event_attr. Lack of such file in the system indicates legacy
> -	 * kernel with old-style kprobe/uprobe attach interface through
> -	 * creating per-probe event through tracefs. For such cases
> -	 * ref_ctr_offset feature is not supported, so we don't test it.
> -	 */
> -	legacy = access("/sys/bus/event_source/devices/kprobe/type", F_OK) != 0;
> +	ssize_t uprobe_offset;
>  
>  	uprobe_offset = get_uprobe_offset(&trigger_func);
>  	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
>  		return;
>  
> -	ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
> -	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
> -		return;
> -
> -	skel = test_attach_probe__open();
> -	if (!ASSERT_OK_PTR(skel, "skel_open"))
> -		return;
> -
> -	/* sleepable kprobe test case needs flags set before loading */
> -	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable,
> -		BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
> -		goto cleanup;
> -
> -	if (!ASSERT_OK(test_attach_probe__load(skel), "skel_load"))
> -		goto cleanup;
> -	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
> -		goto cleanup;
> -
>  	/* manual-attach kprobe/kretprobe */
>  	kprobe_link = bpf_program__attach_kprobe(skel->progs.handle_kprobe,
>  						 false /* retprobe */,
>  						 SYS_NANOSLEEP_KPROBE_NAME);
>  	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe"))
> -		goto cleanup;
> +		return;
>  	skel->links.handle_kprobe = kprobe_link;
>  
>  	kretprobe_link = bpf_program__attach_kprobe(skel->progs.handle_kretprobe,
>  						    true /* retprobe */,
>  						    SYS_NANOSLEEP_KPROBE_NAME);
>  	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe"))
> -		goto cleanup;
> +		return;
>  	skel->links.handle_kretprobe = kretprobe_link;
>  
> -	/* auto-attachable kprobe and kretprobe */
> -	skel->links.handle_kprobe_auto = bpf_program__attach(skel->progs.handle_kprobe_auto);
> -	ASSERT_OK_PTR(skel->links.handle_kprobe_auto, "attach_kprobe_auto");
> -
> -	skel->links.handle_kretprobe_auto = bpf_program__attach(skel->progs.handle_kretprobe_auto);
> -	ASSERT_OK_PTR(skel->links.handle_kretprobe_auto, "attach_kretprobe_auto");
> -
> -	if (!legacy)
> -		ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_before");
> -
> +	/* manual-attach uprobe/uretprobe */
> +	uprobe_opts.ref_ctr_offset = 0;
>  	uprobe_opts.retprobe = false;
> -	uprobe_opts.ref_ctr_offset = legacy ? 0 : ref_ctr_offset;
>  	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe,
>  						      0 /* self pid */,
>  						      "/proc/self/exe",
>  						      uprobe_offset,
>  						      &uprobe_opts);
>  	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe"))
> -		goto cleanup;
> +		return;
>  	skel->links.handle_uprobe = uprobe_link;
>  
> -	if (!legacy)
> -		ASSERT_GT(uprobe_ref_ctr, 0, "uprobe_ref_ctr_after");
> -
> -	/* if uprobe uses ref_ctr, uretprobe has to use ref_ctr as well */
>  	uprobe_opts.retprobe = true;
> -	uprobe_opts.ref_ctr_offset = legacy ? 0 : ref_ctr_offset;
>  	uretprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe,
>  							 -1 /* any pid */,
>  							 "/proc/self/exe",
>  							 uprobe_offset, &uprobe_opts);
>  	if (!ASSERT_OK_PTR(uretprobe_link, "attach_uretprobe"))
> -		goto cleanup;
> +		return;
>  	skel->links.handle_uretprobe = uretprobe_link;
>  
> -	/* verify auto-attach fails for old-style uprobe definition */
> -	uprobe_err_link = bpf_program__attach(skel->progs.handle_uprobe_byname);
> -	if (!ASSERT_EQ(libbpf_get_error(uprobe_err_link), -EOPNOTSUPP,
> -		       "auto-attach should fail for old-style name"))
> -		goto cleanup;
> -
> +	/* attach uprobe by function name manually */
>  	uprobe_opts.func_name = "trigger_func2";
>  	uprobe_opts.retprobe = false;
>  	uprobe_opts.ref_ctr_offset = 0;
> @@ -136,13 +90,62 @@ void test_attach_probe(void)
>  							"/proc/self/exe",
>  							0, &uprobe_opts);
>  	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname, "attach_uprobe_byname"))
> -		goto cleanup;
> +		return;
> +
> +	/* trigger & validate kprobe && kretprobe */
> +	usleep(1);
> +
> +	/* trigger & validate uprobe & uretprobe */
> +	trigger_func();
> +
> +	/* trigger & validate uprobe attached by name */
> +	trigger_func2();
> +
> +	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
> +	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
> +	ASSERT_EQ(skel->bss->uprobe_res, 3, "check_uprobe_res");
> +	ASSERT_EQ(skel->bss->uretprobe_res, 4, "check_uretprobe_res");
> +	ASSERT_EQ(skel->bss->uprobe_byname_res, 5, "check_uprobe_byname_res");
> +}
> +
> +static void test_attach_probe_auto(struct test_attach_probe *skel)
> +{
> +	struct bpf_link *uprobe_err_link;
> +
> +	/* auto-attachable kprobe and kretprobe */
> +	skel->links.handle_kprobe_auto = bpf_program__attach(skel->progs.handle_kprobe_auto);
> +	ASSERT_OK_PTR(skel->links.handle_kprobe_auto, "attach_kprobe_auto");
> +
> +	skel->links.handle_kretprobe_auto = bpf_program__attach(skel->progs.handle_kretprobe_auto);
> +	ASSERT_OK_PTR(skel->links.handle_kretprobe_auto, "attach_kretprobe_auto");
> +
> +	/* verify auto-attach fails for old-style uprobe definition */
> +	uprobe_err_link = bpf_program__attach(skel->progs.handle_uprobe_byname);
> +	if (!ASSERT_EQ(libbpf_get_error(uprobe_err_link), -EOPNOTSUPP,
> +		       "auto-attach should fail for old-style name"))
> +		return;
>  
>  	/* verify auto-attach works */
>  	skel->links.handle_uretprobe_byname =
>  			bpf_program__attach(skel->progs.handle_uretprobe_byname);
>  	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname, "attach_uretprobe_byname"))
> -		goto cleanup;
> +		return;
> +
> +	/* trigger & validate kprobe && kretprobe */
> +	usleep(1);
> +
> +	/* trigger & validate uprobe attached by name */
> +	trigger_func2();
> +
> +	ASSERT_EQ(skel->bss->kprobe2_res, 11, "check_kprobe_auto_res");
> +	ASSERT_EQ(skel->bss->kretprobe2_res, 22, "check_kretprobe_auto_res");
> +	ASSERT_EQ(skel->bss->uretprobe_byname_res, 6, "check_uretprobe_byname_res");
> +}
> +
> +static void test_uprobe_lib(struct test_attach_probe *skel)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> +	FILE *devnull;
>  
>  	/* test attach by name for a library function, using the library
>  	 * as the binary argument. libc.so.6 will be resolved via dlopen()/dlinfo().
> @@ -155,7 +158,7 @@ void test_attach_probe(void)
>  							"libc.so.6",
>  							0, &uprobe_opts);
>  	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname2, "attach_uprobe_byname2"))
> -		goto cleanup;
> +		return;
>  
>  	uprobe_opts.func_name = "fclose";
>  	uprobe_opts.retprobe = true;
> @@ -165,62 +168,137 @@ void test_attach_probe(void)
>  							"libc.so.6",
>  							0, &uprobe_opts);
>  	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname2, "attach_uretprobe_byname2"))
> +		return;
> +
> +	/* trigger & validate shared library u[ret]probes attached by name */
> +	devnull = fopen("/dev/null", "r");
> +	fclose(devnull);
> +
> +	ASSERT_EQ(skel->bss->uprobe_byname2_res, 7, "check_uprobe_byname2_res");
> +	ASSERT_EQ(skel->bss->uretprobe_byname2_res, 8, "check_uretprobe_byname2_res");
> +}
> +
> +static void test_uporbe_ref_ctr(struct test_attach_probe *skel)

typo, should be test_uprobe_ref_ctr

> +{
> +	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> +	struct bpf_link *uprobe_link, *uretprobe_link;
> +	ssize_t uprobe_offset, ref_ctr_offset;
> +
> +	uprobe_offset = get_uprobe_offset(&trigger_func4);
> +	if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset_ref_ctr"))
> +		return;
> +
> +	ref_ctr_offset = get_rel_offset((uintptr_t)&uprobe_ref_ctr);
> +	if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
> +		return;
> +
> +	ASSERT_EQ(uprobe_ref_ctr, 0, "uprobe_ref_ctr_before");
> +
> +	uprobe_opts.retprobe = false;
> +	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
> +	uprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uprobe_ref_ctr,
> +						      0 /* self pid */,
> +						      "/proc/self/exe",
> +						      uprobe_offset,
> +						      &uprobe_opts);
> +	if (!ASSERT_OK_PTR(uprobe_link, "attach_uprobe_ref_ctr"))
> +		return;
> +	skel->links.handle_uprobe_ref_ctr = uprobe_link;
> +
> +	ASSERT_GT(uprobe_ref_ctr, 0, "uprobe_ref_ctr_after");
> +
> +	/* if uprobe uses ref_ctr, uretprobe has to use ref_ctr as well */
> +	uprobe_opts.retprobe = true;
> +	uprobe_opts.ref_ctr_offset = ref_ctr_offset;
> +	uretprobe_link = bpf_program__attach_uprobe_opts(skel->progs.handle_uretprobe_ref_ctr,
> +							 -1 /* any pid */,
> +							 "/proc/self/exe",
> +							 uprobe_offset, &uprobe_opts);
> +	if (!ASSERT_OK_PTR(uretprobe_link, "attach_uretprobe_ref_ctr"))
> +		return;
> +	skel->links.handle_uretprobe_ref_ctr = uretprobe_link;
> +}
> +
> +static void test_kprobe_sleepable(void)
> +{
> +	struct test_attach_kprobe_sleepable *skel;
> +
> +	skel = test_attach_kprobe_sleepable__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_kprobe_sleepable_open"))
> +		return;
> +
> +	/* sleepable kprobe test case needs flags set before loading */
> +	if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable,
> +		BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK(test_attach_kprobe_sleepable__load(skel),
> +		       "skel_kprobe_sleepable_load"))
>  		goto cleanup;
>  
>  	/* sleepable kprobes should not attach successfully */
>  	skel->links.handle_kprobe_sleepable = bpf_program__attach(skel->progs.handle_kprobe_sleepable);
> -	if (!ASSERT_ERR_PTR(skel->links.handle_kprobe_sleepable, "attach_kprobe_sleepable"))
> -		goto cleanup;
> +	ASSERT_ERR_PTR(skel->links.handle_kprobe_sleepable, "attach_kprobe_sleepable");
> +
> +cleanup:
> +	test_attach_kprobe_sleepable__destroy(skel);
> +}
>  
> +static void test_uprobe_sleepable(struct test_attach_probe *skel)
> +{
>  	/* test sleepable uprobe and uretprobe variants */
>  	skel->links.handle_uprobe_byname3_sleepable = bpf_program__attach(skel->progs.handle_uprobe_byname3_sleepable);
>  	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname3_sleepable, "attach_uprobe_byname3_sleepable"))
> -		goto cleanup;
> +		return;
>  
>  	skel->links.handle_uprobe_byname3 = bpf_program__attach(skel->progs.handle_uprobe_byname3);
>  	if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname3, "attach_uprobe_byname3"))
> -		goto cleanup;
> +		return;
>  
>  	skel->links.handle_uretprobe_byname3_sleepable = bpf_program__attach(skel->progs.handle_uretprobe_byname3_sleepable);
>  	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname3_sleepable, "attach_uretprobe_byname3_sleepable"))
> -		goto cleanup;
> +		return;
>  
>  	skel->links.handle_uretprobe_byname3 = bpf_program__attach(skel->progs.handle_uretprobe_byname3);
>  	if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname3, "attach_uretprobe_byname3"))
> -		goto cleanup;
> +		return;
>  
>  	skel->bss->user_ptr = test_data;
>  
> -	/* trigger & validate kprobe && kretprobe */
> -	usleep(1);
> -
> -	/* trigger & validate shared library u[ret]probes attached by name */
> -	devnull = fopen("/dev/null", "r");
> -	fclose(devnull);
> -
> -	/* trigger & validate uprobe & uretprobe */
> -	trigger_func();
> -
> -	/* trigger & validate uprobe attached by name */
> -	trigger_func2();
> -
>  	/* trigger & validate sleepable uprobe attached by name */
>  	trigger_func3();
>  
> -	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
> -	ASSERT_EQ(skel->bss->kprobe2_res, 11, "check_kprobe_auto_res");
> -	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
> -	ASSERT_EQ(skel->bss->kretprobe2_res, 22, "check_kretprobe_auto_res");
> -	ASSERT_EQ(skel->bss->uprobe_res, 3, "check_uprobe_res");
> -	ASSERT_EQ(skel->bss->uretprobe_res, 4, "check_uretprobe_res");
> -	ASSERT_EQ(skel->bss->uprobe_byname_res, 5, "check_uprobe_byname_res");
> -	ASSERT_EQ(skel->bss->uretprobe_byname_res, 6, "check_uretprobe_byname_res");
> -	ASSERT_EQ(skel->bss->uprobe_byname2_res, 7, "check_uprobe_byname2_res");
> -	ASSERT_EQ(skel->bss->uretprobe_byname2_res, 8, "check_uretprobe_byname2_res");
>  	ASSERT_EQ(skel->bss->uprobe_byname3_sleepable_res, 9, "check_uprobe_byname3_sleepable_res");
>  	ASSERT_EQ(skel->bss->uprobe_byname3_res, 10, "check_uprobe_byname3_res");
>  	ASSERT_EQ(skel->bss->uretprobe_byname3_sleepable_res, 11, "check_uretprobe_byname3_sleepable_res");
>  	ASSERT_EQ(skel->bss->uretprobe_byname3_res, 12, "check_uretprobe_byname3_res");
> +}
> +
> +void test_attach_probe(void)
> +{
> +	struct test_attach_probe *skel;
> +
> +	skel = test_attach_probe__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	if (!ASSERT_OK(test_attach_probe__load(skel), "skel_load"))
> +		goto cleanup;
> +	if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
> +		goto cleanup;
> +
> +	if (test__start_subtest("manual"))
> +		test_attach_probe_manual(skel);
> +	if (test__start_subtest("auto"))
> +		test_attach_probe_auto(skel);
> +	if (test__start_subtest("kprobe-sleepable"))
> +		test_kprobe_sleepable();
> +	if (test__start_subtest("uprobe-lib"))
> +		test_uprobe_lib(skel);
> +	if (test__start_subtest("uprobe-sleepable"))
> +		test_uprobe_sleepable(skel);
> +	if (test__start_subtest("uprobe-ref_ctr"))
> +		test_uporbe_ref_ctr(skel);

...and here.

>  
>  cleanup:
>  	test_attach_probe__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c b/tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c
> new file mode 100644
> index 000000000000..f548b7446218
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2017 Facebook
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_misc.h"
> +
> +int kprobe_res = 0;
> +
> +/**
> + * This program will be manually made sleepable on the userspace side
> + * and should thus be unattachable.
> + */
> +SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
> +int handle_kprobe_sleepable(struct pt_regs *ctx)
> +{
> +	kprobe_res = 1;
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> index 3b5dc34d23e9..9e1e7163bb67 100644
> --- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> +++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> @@ -37,17 +37,6 @@ int BPF_KSYSCALL(handle_kprobe_auto, struct __kernel_timespec *req, struct __ker
>  	return 0;
>  }
>  
> -/**
> - * This program will be manually made sleepable on the userspace side
> - * and should thus be unattachable.
> - */
> -SEC("kprobe/" SYS_PREFIX "sys_nanosleep")
> -int handle_kprobe_sleepable(struct pt_regs *ctx)
> -{
> -	kprobe_res = 2;
> -	return 0;
> -}
> -
>  SEC("kretprobe")
>  int handle_kretprobe(struct pt_regs *ctx)
>  {
> @@ -76,6 +65,18 @@ int handle_uretprobe(struct pt_regs *ctx)
>  	return 0;
>  }
>  
> +SEC("uprobe")
> +int handle_uprobe_ref_ctr(struct pt_regs *ctx)
> +{
> +	return 0;
> +}
> +
> +SEC("uretprobe")
> +int handle_uretprobe_ref_ctr(struct pt_regs *ctx)
> +{
> +	return 0;
> +}
> +
>  SEC("uprobe")
>  int handle_uprobe_byname(struct pt_regs *ctx)
>  {
> 
