Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC33B330589
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 02:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhCHBD6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 20:03:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231387AbhCHBDh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 7 Mar 2021 20:03:37 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1280mR6H023243;
        Sun, 7 Mar 2021 17:03:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5n1bQ+S/KjRNLx0WZazqebFk+CyZgDN0nNvKl0v6fns=;
 b=MnC7rSrN49ST3SZT6IF7/Mu53s6poncf8lAJDRFWZ0SJNKWFwhxuzglD9i8LhYEBbpR+
 Ua2KfnADGLWo0Lsa41MN6VHtzEI/h7wuAYPxN1rauWVM0SYyo4y/fZIJ2dG1qLjeC7Uq
 J+HnE08+oXtzCiHtjDrIyoXSOo2T6fWyvTo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 374thpt5vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 07 Mar 2021 17:03:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 7 Mar 2021 17:03:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCaEDwcVCPkJzLW9xHDLXvN3z+wOw4uI1s4GSI5zxqqrgZ/QEvSnj+lCLYjs9lNGupq5G+h8Qtx5pkPdP4rPt04TXZY6+8GoeopwfPXI+aJ1Zq65cdmj2csERCtyaXTKcbgam0+vjb0sSeMRa7G+9tWUN8gjbgRZKMJfXzLg17ZipClbD4OolMrxiZookyqUzRv8Br9rcBpHdiAXCof/2ZSj0KmU/K4AduEJybdeAI5Tn0xsAVcIP3KW75bX+r6lTMezsfAnezYyVESZH+nWwptShaRE7pRYYL2bE7dS6cvbpmzmo12MFLV4H5zaJ5V8P8+6AwupSBdmDe/6WVwE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n1bQ+S/KjRNLx0WZazqebFk+CyZgDN0nNvKl0v6fns=;
 b=HNd6wGn8QZmknukD01ubX78zwSofhnjfg1FWLtn8U4PdpGwefaLivIJWOVVabEbg4Is6jdymoCVyou7dLIVqKsGuAjGNxBbmx2VNOvumgGBTICQ4JLLYlZFHUOtkOO3JmfOS1pTLjHX8bE1iUKDPAPQ7sps5PVcYFq60l/+CCMMb0/9jK1Cgz9vbTNgnSG1R0ZUICr1jsmplcWvu5cH26VqiaxV2OezRecT0oER8h72//JrKDpFxueMiSJJv97f3/R1g/dSaxeRN4KKDkcSaaYB4pgFeSg5AP6GsFwE3ZsZtEq5VO767Iv5HVJ1pmrza+fG2x06eyR0n2iuJOzO+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4708.namprd15.prod.outlook.com (2603:10b6:806:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 8 Mar
 2021 01:03:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.037; Mon, 8 Mar 2021
 01:03:18 +0000
Subject: Re: [PATCH bpf] bpf: Dont allow vmlinux BTF to be used in map_create
 and prog_load.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <andrii@kernel.org>, <kafai@fb.com>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <20210307225248.79031-1-alexei.starovoitov@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a08d0d5a-6c36-2633-a19e-2a8cd662e8e6@fb.com>
Date:   Sun, 7 Mar 2021 17:03:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210307225248.79031-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:8b5a]
X-ClientProxiedBy: MW4PR04CA0334.namprd04.prod.outlook.com
 (2603:10b6:303:8a::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1105] (2620:10d:c090:400::5:8b5a) by MW4PR04CA0334.namprd04.prod.outlook.com (2603:10b6:303:8a::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Mon, 8 Mar 2021 01:03:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d7998e0-a11e-40f0-cfa9-08d8e1cdf5d0
X-MS-TrafficTypeDiagnostic: SA1PR15MB4708:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB470866A56658EB357CBA7B51D3939@SA1PR15MB4708.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKbqvVuXW0h1lWHFje4YDDv2b3yVjaDQQsd6xI12ya1xZsuI7/0SG3W9tACMexTTyn3Hbdx6SAB4Clp/ZMMeH/KdNbUVX/JiFm24FnDGZgUCv7UpX+UCBq6mENC6Emd/mksza5U1IkrwoQQs+h2LVK+I3DzEJ/tKyFY1lT7A7KreGh6prhc51ogtgsNYhXNH2XyXPFbJC7OAx7HE1+lSLUG7rifDCy/yzk5PKQFMERxgzfmrZxL/jK6zUBOf/9x+czANaph1mFKBC1ymJHC0Hb2THk9PG2XVEMr/7CY8sB0mzhNYjtaGjxRKLXM6d4Y925TaS/n45/ISe5VNmwDeobSy6S99/xK/olw0v1aiCb1qfkFP9nVNAEaaQGOPGNBdDe7NgI8GDJZwAw7tMbRqkpFgQBVJkRkcKKmfqadbE160pB7ScIdWBIafGG1XB7R7rIByNjmCYz1cNJXGUTUsWuyS4x2Do7IeQQbT9uhvHUSDOri9+3609K8OwETESX/Az7lZyldZOymwiRLigHC2pDxNSt4+sOxjaEtPomXn1FhgGxdeRsyhWSFOjHlSu2gGHEuYtyWgu882kxZPvebNTdp3jMv3gEX9ZCvf2eOrnRYtH2iZv3/pyt7ypH+3Vkmx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(396003)(376002)(136003)(31696002)(8936002)(6666004)(5660300002)(86362001)(36756003)(478600001)(66946007)(52116002)(66476007)(83380400001)(8676002)(66556008)(6486002)(53546011)(2906002)(2616005)(186003)(31686004)(4326008)(16526019)(4744005)(316002)(192303002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QUVBR2E4NlI5VGttTkdZTXlZVkZSQ2o0cERGRjVXZ09kU0s4U1YwOWkrY2E1?=
 =?utf-8?B?enI1amFOcW1OZHduRmtrdFgrRFcyK3pFZW5XcVI4cE0rRWkyYndVOVdPVTVs?=
 =?utf-8?B?UnR3aGtnSUpVekZOQUtwcXdmVnBiQi9xNERlM3dVWjJYR0lDRU9CVStJMk5a?=
 =?utf-8?B?VEhDeTN0L21xNjRMWEEreG9kUGhNTVRUb295SWJjUDdVL1h6VHBjQkFPM05S?=
 =?utf-8?B?eldJSmprcW1PUlRpYXFwM1BlZ1Y4Y0NGdDRhbkVOc2hlY0M2a2tqaS91azRv?=
 =?utf-8?B?MGhaSHpZS244UlhhWmRoalZ3WG83VDA5Q2FPWktIL2podm1PRjFTTUxuMzlK?=
 =?utf-8?B?bVJsbGZ6bTgrZzF1cU5mVTUrTU9xK2cwc3hqcGEyT3BXa29mNGpkMW55T0Y0?=
 =?utf-8?B?Z0wyb2NQbmNyYVUyUlpFaFQ2RFdyZkkrNGlMV0MwWVZPUnFpWXoyQmZpR3JU?=
 =?utf-8?B?ME9YRTFWdjcyZHMxZlB1OHZnZFIvVkZkUEVFdW84NkxqSG9jMUpUTUtMSm8r?=
 =?utf-8?B?ODV6a0lUNDNZenM1bXZnWCtlcGRXN2RSUm1RMjI3TnFhNUlFUjBjRFVIdXZz?=
 =?utf-8?B?SnlNZjNxaGZTdzBiSENlZmhIVlQ0YzVPcWIxS25ScjhqZlBkTys2UFppeTJy?=
 =?utf-8?B?ZjZFVmp6NlkxVk42blM5SmFnaW5aYUJlTkx1UDBRN21seklUZVRWcFNSTmxH?=
 =?utf-8?B?Nmh5OG1ibGxxQlpQcUFlQWtWQnQwM2FUSE94TUp3Wm1HOGpNWFo3SzhLWjht?=
 =?utf-8?B?cHpwS01IMUtrMVNveklqRzJPRThxMTBYUjJTZHdxNG44NFhJcU0wZ2lHOWda?=
 =?utf-8?B?eXBhRGJvQ1JJWVdyWEhMNEl5STc0MmVHUU1weURnN2hueGJlOUYrcFhhdVhR?=
 =?utf-8?B?U3pzME5pOGpTcEZlVTdHSFNxWVpXbkNpN1FPV1NFYjNSRWhaRnp4UWtaT1J3?=
 =?utf-8?B?cDM2djY3ZElJdHh5QklFZTZoSzdrV2FCcVc2RlhSNEVzd045ZFEvcXN5TGl2?=
 =?utf-8?B?ZWhkNW5PT29MMkNjTzlIRURmSFErdnZXbG5weFBDaHc3V1hrOEFsWHFoM1kz?=
 =?utf-8?B?UllPbHp1WGlqNnNvSnBpY3Q3V2I4Q0NDaDFUd2N2TmNHUHVFSVVoU0wvVU1l?=
 =?utf-8?B?aWpEYmpMWVNoN2tickQyZ21qRzNIZmIySm9GSG44cEkvVTdNT0RUMjRpWWJ3?=
 =?utf-8?B?L3FqYWN5YUVTd2sza1MxM2ZDOUNaM21XUk03OEVwNWxNVTgxakRUK0pDeWZz?=
 =?utf-8?B?Z0pYQ3Q1RXFCcU5Cekdyc2pJVGR5dHBoNTF3WVh3djFtM3ZNbGZWR2xwUExu?=
 =?utf-8?B?ME4wUVR0bkdYUHY5OE8xbjgwNjdhbllqRVg3bnlRclZWRjFCcTZHb3IvZnJx?=
 =?utf-8?B?WmRYZkhaNitPQWRRV0M5d0VHSHFtR1VHZmNaU3hmRU8yaFBPTEF1YXZJd1JI?=
 =?utf-8?B?M3k2VHN2b1hDdVVHOVowWTBrNEtVZkI5YnhZNmhPZXRoMDBJY3JiTk9yYkFL?=
 =?utf-8?B?SmJQNU1LZzJab0paUnlXekducHVYcmJMMDhLTkMzeHM2NG5McDRnUmtxTGdl?=
 =?utf-8?B?bFk0TDhZcTQ0cjdnQjkxQ2tWRFpPbWJXTVNBR0Z4LzRSd1pqemxzemhKaUZ0?=
 =?utf-8?B?Y2VQWURGVVIrZEhLY0pYV015S29lNERZV0pMTXNjZUVETVFQRVM0eU44bkRM?=
 =?utf-8?B?Ykh0bFZpWXVVTDhXZE5iNzhScGFkSnZVd3JhcXRXR2c3Y2NDSEFJRFhTaXFK?=
 =?utf-8?B?eFMvY2R1b09vV2Zwazk3V1A3SHZhSnI1d0FWaE9pWk54YWtDbXNqZy9lZW9i?=
 =?utf-8?B?dzVkZDdjVFZuNE5ETkpaQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7998e0-a11e-40f0-cfa9-08d8e1cdf5d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 01:03:18.7389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCOkIFOcliNq4ZUBfF/KzYkHQ1jbFXrk/w8AcKhriDj608vfwCkwjZ9pq0IgGktY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4708
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-07_17:2021-03-03,2021-03-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103080001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/7/21 2:52 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The syzbot got FD of vmlinux BTF and passed it into map_create which caused
> crash in btf_type_id_size() when it tried to access resolved_ids. The vmlinux
> BTF doesn't have 'resolved_ids' and 'resolved_sizes' initialized to save
> memory. To avoid such issues disallow using vmlinux BTF in prog_load and
> map_create commands.
> 
> Reported-by: syzbot+8bab8ed346746e7540e8@syzkaller.appspotmail.com
> Fixes: 5329722057d4 ("bpf: Assign ID to vmlinux BTF and return extra info for BTF in GET_OBJ_INFO")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
