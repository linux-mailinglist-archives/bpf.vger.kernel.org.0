Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537363413E7
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 04:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhCSD51 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 23:57:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34234 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233704AbhCSD5H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Mar 2021 23:57:07 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12J3t6rt003868;
        Thu, 18 Mar 2021 20:56:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GHP9kzDxwdbtbJj/l89XK/fVZlKvhsjyxqEHq0Nvuwc=;
 b=W8/VWnSkLIRGO3d1xW6AU4jaqmU5DNi1H3NclOPm/sGuhaQu2SxePMmuHQ+XC1ouWhYU
 xQDFGrssh7U11zr7Uy7RehLzcjqYt4ngaV9RhLnSSxTfopkI1nIubSPBasSGUcbmjU9g
 Hn4pT2h2IsW04eUn9/FVkh/ZpvxbjWQTJvQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37bek0vg8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Mar 2021 20:56:51 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 18 Mar 2021 20:56:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYGiqKQQvtqwdpeGRkPyVz4Kz9E7zCg3oQ9XqnX+y/CX7dt9L0QrjU1Q85eGgndq1c/sKaHyrjR2GjBuu1WMNfLJB+77bSeLq9KiKZ/0Db6LcTIivQebXQ8VWhJ1Ds9MXwvy7FrFnLlhJK3+eYZSSkxk+cJU2g90KL2XuTHGumHijacQWrkDbiecNEffdRxNmXCLoS7C57/1LkYn6o35raR3snK2xrxpCJ882lIHKrSabcyaNibndHBwnLo4jjjt6aEz6mhy10uiEzshwHI3JaZs/fWmn83NsYR7+cFnV4u1W6Z+BKS3yHRQ/b5DHN88X4zknst0Z9IWLQXlDW3fUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHP9kzDxwdbtbJj/l89XK/fVZlKvhsjyxqEHq0Nvuwc=;
 b=IE0IZBfF2St2Wl9ODCj40aDqmQuxwg7zKKsl99fN4/HaTZWimTMSc+fySwyrUeWKmfekPEONXuMb1KeCxJDHzVqF4aa+zhHh6QDPsXzW0GmyhAY4GY+62hhPobN2oDJ6hWO5BFQyTqofMu/32WnWuV3RGqu3EBbGjax69fC1cXYAvRrCacT6tMR+IseaMlPcxkGJnOuA/rGX+V9wDDe953FPpGEZTBOrCU3UUl+Dg4EmphsVaPdgm5Vm19wGlEv6z3qcWgX60pTfZcpNGc7gNR9sp8mJQowMXIEcpTKF5OuYlFPNmpjZmbgV1tFaj5ZbWRZvzRzlEV0rax/6sG2j+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2336.namprd15.prod.outlook.com (2603:10b6:805:26::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 03:56:49 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3933.033; Fri, 19 Mar 2021
 03:56:49 +0000
Subject: Re: CLANG LTO compatibility issue with DEBUG_INFO_BTF
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bpf@vger.kernel.org>
References: <20210319113730.7ad6a609@xhacker.debian>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4e1d1504-55e5-db8b-112b-921d86ef7d5b@fb.com>
Date:   Thu, 18 Mar 2021 20:56:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <20210319113730.7ad6a609@xhacker.debian>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:939]
X-ClientProxiedBy: BYAPR08CA0022.namprd08.prod.outlook.com
 (2603:10b6:a03:100::35) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::193b] (2620:10d:c090:400::5:939) by BYAPR08CA0022.namprd08.prod.outlook.com (2603:10b6:a03:100::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Fri, 19 Mar 2021 03:56:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc1be0c-28d6-4c38-5675-08d8ea8b058b
X-MS-TrafficTypeDiagnostic: SN6PR15MB2336:
X-Microsoft-Antispam-PRVS: <SN6PR15MB233604CB59EFD7DE74C48B2FD3689@SN6PR15MB2336.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwdliZ4ZOtF5mC5OqQPpxmQFLx9XQ4kygLFYakln+X/Pq68YPWVIJma3IsrEO5tCi7KW4Cnks7U9TOt+y60hdI4CIKBpfYvjsJujEMRl8oTNCHZ285rU+lB54ezixfB3GxSYsd6D1AU5yFpudWFSPTWhnYhiyOpVvSrTMXQXnAwSeqebkYDFh3wt1hUakO7UmsRwqAYstDSk6a2pHt0VMMagZftLysb5GcCMrqpnk1DtaIR9FVHsrdEiKLkHqoeLTgUoavVicR22kBUdd2ynRiSuc1bHxR2Xp+Ha+JP+QNeTBl1JeWCETe8S+1eSpiWA+cHYvyu8ITF/HbHMV2hpjEFidbPApAsvUrwh0Iu9IRTujgGFXxuAccKf9LMK7GVr58J61IKXpH1dm+rDYRBLHvxZRxHZUNsSlcjkSFFCGLadwtHluz8WaMkFp9ArJjo3SDA9tt5QR4Su1uv7t84CcS/x9FIrloqKViqM5eEJoleYsX2RWNOsJ+ZHVO1pARX32pYLOSrkzONAFfZYfDnSB0DTtahwF7XNzt0t5mMcEXGSKnFe/e/PObTJ0Px91YxgeXdRh67wOYIuXYOpSKsILnjGdXlulWOzHoQTW0bFQu3Vveoqd1eOi9yOvRlPcY//GW1ND69oog9DvZ8YBnTmag8hepEVwZ3+I6QaqT5vU+/XjX9Bsz1rSKp6BiLALWNkc4P8d99b+NPK8S/FFXdejw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(2616005)(478600001)(8676002)(316002)(16526019)(31686004)(83380400001)(110136005)(66476007)(66556008)(66946007)(38100700001)(186003)(8936002)(6486002)(2906002)(5660300002)(36756003)(86362001)(53546011)(52116002)(31696002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QkYzY3h2bFNjcTYrem13QjB4SnFRZnBmWVcyQXVDZ256TmhhM2dRT0RsWnBz?=
 =?utf-8?B?M2REOEpUaFRkVzVWcjV4OGdmQlNkeENaQVNNeWVnN2N4K244REtVUGl3Z2Jl?=
 =?utf-8?B?ZTRNNEpGTHdzZ2NsZTRmRzJ4aHNWSjlUcUIwMnllUGFCTm44dzk1YkIxWlMx?=
 =?utf-8?B?aFpwenJacmNBM1dXRFl1MXAyVDVlQ3MvMmtFZ1p3V2tvV010Y2RNZG01UnEr?=
 =?utf-8?B?SWtaaTh1VWxQZG5oN3JPb21yYWVxRjVsQUgwZGg3dGpmNHNuTGxrZ2pOc25Z?=
 =?utf-8?B?cjQ1cldLYWJ3OTBpV2dadVRaTFZCNDlWVHJXa3I2bHZOR0xYS2tRMlNjQ1Bx?=
 =?utf-8?B?RmFOMGRCaVNQTExQY1QyOVBNRENlYVh5alU3Tm9UTStFTm50V2Nsck9jWHRJ?=
 =?utf-8?B?d0crdTRkTGpYQjB6NDUwc2JrdXY1NXJUalQxOTNuS08xU3dqOFg4R2UyY016?=
 =?utf-8?B?QmljVXgvOXJPNGNrV1ROeitjNzFxM0RNUUorM09PSnNJdkQ5NjFFWEZZcjBE?=
 =?utf-8?B?S3dSZENjVWY2U3VvRlNkMDFzRnZ5NHd1eGZGY1lybkhvMEpsWGc0aTQveXow?=
 =?utf-8?B?OUpHYXVxYlQ2bkd6SmtFV2o3Q0tMbEVVck5ZaEZFQ2dvSWsraUlJdkx3RU5O?=
 =?utf-8?B?QlFFYllOM0JVd0o2RVRQVjF3OTNzUDBWQUF1cEVGUTFiWm1KclZVdUxnSGhk?=
 =?utf-8?B?Q2RGYVBQejczOHM4QW1mVGFVcW01cEhPOFExUVNjR0YwbVV6K2p6SVl1Z3dp?=
 =?utf-8?B?cWVZSWVNVVA0UDFrUzJyQzhVZDBkZkxmdkJHYTVSNkY4WUFkTlF5eVNqYVZm?=
 =?utf-8?B?UXlyWVlnam9kV3c0OTAvajhmNWZvLzRiY1ZRM2lZSFI3dVRLQkxEMnRuZW9M?=
 =?utf-8?B?NGJGekNsM1lXditjbWp2a0N6dmdVa1IxbXU0eVBUZUtwcGRib29ra3FkYlh1?=
 =?utf-8?B?TUJobE1Ybk0yYUkrdlJUeXJrODI4dGtTMmJFaUpTckhhUlJWSmZtMkNnWU9o?=
 =?utf-8?B?THNHRTluOHV0N0RUeWlkaTQrVnU0TnhPRFlUa0plMkFQeTJ0ZkFVdWVPclJR?=
 =?utf-8?B?SGdidXpYOU9sMmdhdjc4dWdLMStaQkFJVXo1YW9VblRXL09xL3MweGdlenlU?=
 =?utf-8?B?eWxBaW54ZnN6ZVY2TUJhNUNFblZKWDRydlo5WXpqOWptU2hpLzFkSXJtRHJC?=
 =?utf-8?B?UGtSVnQwZDFKSkhxTlR2eldGVkJ0NGNqTXV6K01yMGxJV0FvZlptdVFDTUVE?=
 =?utf-8?B?Zk5lSWNKcnZrcnBzTmRBeGh3QlVTVk1OUUpWR0dNTUMyaTVxbURjTzJlQ0xD?=
 =?utf-8?B?b1ZYMWFsSlNiMW1GeEE4MTA4ckd4cmpCY0RHak1RMk5NVS9aL2xQOEVZejlK?=
 =?utf-8?B?UjVtcHVOYjNHWTl1Uy9QWWdUQTltRWFycUdmRmp1cE5kQ1pNL3YrSjFFSVpR?=
 =?utf-8?B?c3dSaWFXSWhtVXlQY0w5blloYTk3ZW5ubFFSeDh2WHpZV1NidGJBakJhUHhs?=
 =?utf-8?B?OWRsdG16K3lFbFFlZUYzOGRjOG9kMExjajI5QXVLc21UK0VPOWZVS2p0K0NQ?=
 =?utf-8?B?clFjS1F0RDFoZGJWOWNIanZpOUVQbkxRYzdFb0ErSkh5elRtWEdCNlhEUUJR?=
 =?utf-8?B?bGRUcmNZNUFuM0lrdWVEMm9ONTBmb3JUd2tsV0R6TVlBN1NKQk4yV0xUcjQ4?=
 =?utf-8?B?c1J5aFpLZ0oreEdmYTJaaTRvL2ZvUmR3WC80MjdLK0xMR3dFdHROcFBYYlRV?=
 =?utf-8?B?TmNYN0UzNTgzUnEzeXI0R0J1SW5OUXpsK29Pa004SVZnclM1Z2VHMThuUldS?=
 =?utf-8?Q?F2R4h2FL/a4bhth5ECuW1uaYQe/FRzqp8ak60=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc1be0c-28d6-4c38-5675-08d8ea8b058b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2021 03:56:49.0334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Lvkv9/zhSIIFgUyTqGozCjKn+EkAMteOK6cnRmsEWV1h6iEuDj3PLSJsg3py/VG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2336
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_01:2021-03-17,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/18/21 8:45 PM, Jisheng Zhang wrote:
> Hi,
> 
> When trying the latest 5.12-rc3 with both LTO_CLANG_THIN and DEBUG_INFO_BTF
> enabled, I met lots of warnings such as:
> 
> ...
> tag__recode_dwarf_type: couldn't find 0x4a7ade5 type for 0x4ab9f88 (subroutine_type)!
> ftype__recode_dwarf_types: couldn't find 0x4a7ade5 type for 0x4ab9fa4 (formal_parameter)!
> ...
> namespace__recode_dwarf_types: couldn't find 0x4a8ff4a type for 0x4aba05c (member)!
> namespace__recode_dwarf_types: couldn't find 0x4a7ae9b type for 0x4aba084 (member)!
> ...
> WARN: multiple IDs found for 'path': 281, 729994 - using 281
> WARN: multiple IDs found for 'task_struct': 421, 730101 - using 421
> ...
> 
> 
> then finally get build error:
> FAILED unresolved symbol vfs_truncate
> 
> 
> Is this a known issue? Do we need to make DEBUG_INFO_BTF depend on !LTO?

This is a known issue for pahole. pahole does not handle dwarf well 
generated with LTO. Bill Wendling from google is looking at the issue 
and I will help look at the issue as well. Since bpf heavily depends
on BTF, at this point, I suggest if you are using bpf, please do not
turn on LTO. Or if you build with LTO, just turn off DEBUG_INFO_BTF
in your config. Thanks!

> 
> pahole version: v1.20
> clang version: 11.0
> 
> 
> Thanks
> 
