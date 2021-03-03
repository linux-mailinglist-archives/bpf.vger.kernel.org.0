Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EFA32C20D
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbhCCWyi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:54:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13126 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1387996AbhCCURI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 15:17:08 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123KEVCq012123;
        Wed, 3 Mar 2021 12:16:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=YwXM8T+L/5a0JFY8RwrpSUHo5ag4oDLf8onuz9EReqg=;
 b=FudoXHv8LKcvWBvHOURbduNzjlOGwt/lzmG4e1A4s9M3zJ22Nt//AIWBVCptAAqO4Qjk
 9QlH0M94mopFezCGA42DW3s7L+jgG4e/pIUoAzhpNbNfaYECKaooqmqPkMlE4/haA2Oh
 bJHZmJy+6c/l/EghJE4LIgdRN/vKx/9fQIo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 371yv1d78e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 12:16:13 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 12:16:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFibc5lDLBxBqhKUmpIDGCntAJ1osKT9/Im94GR8bxjaTpLZTk8k0GdY9/QwV8QCyPSevUXMZhiKBFFUaOU0+ROKttb9PK9rXBTxNbhLk1EUFfmACS0tH+rGywwmDVfSkga0A1VeYkUowlq7dxMoOt+kNJQaCJqtqgPkn3otqMY1HZIQqtTFGABTp631H6uJX7px5WFVwZQMMBE8TsesWmQpWjcCJxPaSeSPqX0hX7EmUU/5mVMkeWUs6HAI02PTFWfvSCJE+gICLCddhWAowwysHjvRuP9KKbvAQK0BjTLHga1luaNU5EthqwU8QAb/9rD8VTzHBdxeaVeQDArSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwXM8T+L/5a0JFY8RwrpSUHo5ag4oDLf8onuz9EReqg=;
 b=FQzTkvwQT7aG61x8LDQ1e/UVsaRCJ6jw+wshk18Avl1dnr6jO52dX+vx9HIrQPDCu+Je7p19CKB0yUK4Ooom6Gn0fbnx09mXx3d/Iuxw4KZnjvDIsr8QIk3ulTNn5fQ2BdEw0gEke3J0e2p/WgqRBiYgsAgbfUBaGU1F2UT22C8uXe7aqbusOAMSG+KtlrAE7avsWxUoCO/duw00yGISQYr3GCX0ZAr40pzN1nRcemBPJoH1WdSK/oh9PHg3Wut1SlS9Vxek/Ax4ueEgKqliiI1pyyiGuk+o5OGT4aHhck4b9DapZC3/LR9+DJazy4uF49WyJtEllDCcABvCU/gAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: isovalent.com; dkim=none (message not signed)
 header.d=none;isovalent.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4706.namprd15.prod.outlook.com (2603:10b6:806:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 20:16:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 20:16:11 +0000
Subject: Re: [PATCHv2 bpf-next 03/15] bpf: Document BPF_F_LOCK in syscall
 commands
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20210302171947.2268128-1-joe@cilium.io>
 <20210302171947.2268128-4-joe@cilium.io>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <36e59797-8679-a26d-8111-78cd1ed66313@fb.com>
Date:   Wed, 3 Mar 2021 12:16:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210302171947.2268128-4-joe@cilium.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:94d2]
X-ClientProxiedBy: MWHPR14CA0063.namprd14.prod.outlook.com
 (2603:10b6:300:81::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:94d2) by MWHPR14CA0063.namprd14.prod.outlook.com (2603:10b6:300:81::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 20:16:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b13c6baf-2b66-4555-3116-08d8de813012
X-MS-TrafficTypeDiagnostic: SA1PR15MB4706:
X-Microsoft-Antispam-PRVS: <SA1PR15MB47060EEA902E35345FC14213D3989@SA1PR15MB4706.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:170;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T7An7mqWEyk4a7itwOFRrVyVWYIrCUCfyKaf019sJ7ckmkB9p1oTTC1LWnEBZ+7orOswxVjm71XQo1mSgtIOJJv/iG91Q24hpVRXxj32Y6qgpWn3ltbIvB8B8xVPVfbHAvY7/fqiCXR6BdH1tdCxfwFwgsCnwBQik3IavKQG8ijzPyRs1m6RGlblPEJTCkEM5iNQwi/qpKJyMd3dpoLId8OcfxCzUHJee8nf15tXLwhysBWScWARcDIf7cUr4EVFjH0mlTEh6hCEWZZFHxmYQZ3ycUKaBjgsBHwWhMxOkol2Gte72GUVu2VTPNV5LMSWAVaHlBiWgel0WKIB081IKv1jggAdjgGgoxlzuxm/9RaiLNh/gCq49ktUdUUpYX2d8gMO3arc+AhCjU2AnSDrwfEbN62Yua2rOlCyzb0/1PiuSu2+en+qHacRa3u0Jp8Xu12NPwS9yW4/Y+gc0BgbjO1sim9oQKmZWB3LpbEEaKvrFQkUgPGZSpyGuJL8Al34RO9iHTF/QsJACg54yK7/89EKe37RxgHJfB+jpgPQEEf1Kg6cKjiE9ztD9o7WUosnMesh6jbxUBfvBWuqC2aVE5E8mVqL8s8eebO6gAug6QY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(39860400002)(376002)(136003)(2906002)(8676002)(6486002)(4744005)(8936002)(66946007)(36756003)(6666004)(478600001)(31696002)(86362001)(31686004)(5660300002)(52116002)(53546011)(66476007)(66556008)(2616005)(66574015)(316002)(83380400001)(4326008)(54906003)(186003)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dFJOTFE1SUVzbGg3bjBiNU95NllBZ3EyRXJIeDcrM2FhNGk4ZGxFaitmSktS?=
 =?utf-8?B?bXR0dk9wWk1lRU9ESFVVbGZkZzFyRUJDWWRwU1NSbnNzNVhKbkIzMnVmcGlX?=
 =?utf-8?B?d09jbW9INDA1WTlrOERKY3RJYzBBV2ZSbTlrc0F4a0tlRmxrTW1DNmM3b0pa?=
 =?utf-8?B?aDl6ZTJXMkZCbDQ2eXNJYlVSY1p2YWRSQjUrN2E3Z1dsQ0ZWMEJKQVlGcFpO?=
 =?utf-8?B?VUovNUZFaGpqN1RTK0F1eHhVT0s5NkI4V2V2ZSsweVN0d2FsRzBTN0JpbDFw?=
 =?utf-8?B?OW4yT1pIZFNtUzJTZ0hISDN4bHBSdEgwYlgybXM4SEgyT3NlUVRCSzVpSmRv?=
 =?utf-8?B?VkE1QkI4NHdCeDc0am42OVUzenQ5b21BUmtUS2hyektEQ1FFV29tcHZUUGQ0?=
 =?utf-8?B?Vmt5NE1OS3hWSHZPcjMwRU11MlJTV2R2azkwZm1tRmtMVzh2M0hmLzE5RVB2?=
 =?utf-8?B?YVBjWDRTZGw3TGdQQ1NQWTRZTjdRR3orUlBUNi9CampmZzkzbDc0NHY4VXcz?=
 =?utf-8?B?WVpScHJwOEtnZTNCcDNQOEtpZGZKUDJDSUhFVzRuSy9nMlBVdi9rTWFna0Vx?=
 =?utf-8?B?d281UENpMHREbHlhcTNIVGJkbjUyOGNRQnY5dFJPZFBSSGxZendHajg3Zy96?=
 =?utf-8?B?WEhFYVhwUzVFL2RwT1Vid1ZGakY5dkNNNkFEb2gvc2J1MkNyTWsyQnFncnRo?=
 =?utf-8?B?YnU0M0FLWjZJOW9zT2pSTUpkQjRLYnlDczUrdloxRnJYc25JSU1JY1pvdXJO?=
 =?utf-8?B?TFdrQmlkanVmbEFqL1hCSXlTSWZGaDJ5cFlxSmJ5UUFZMzlZYi81cGx0S2dt?=
 =?utf-8?B?cHpYNlJ4WWI2aVRTWTNLUGZ5cjJwVFRxejAzaTNYS1R5alJyc0tvNEpCc0RS?=
 =?utf-8?B?MXY4VGFGMUtPVFhVOEc1RE9SQjhTajFXOVg4WXZEY2E5eEc0V3JZMkF2SHFD?=
 =?utf-8?B?WHAzOU12T0tRdUdHMFVmcTJWY2Z0VzZRbTR1cXhOa1k2RFdib2V6YzAyTDJE?=
 =?utf-8?B?L2hNZnppOCs1NW9ZdXJ2T1V5bnFIT0lNdE1RQW11cHpINDY4Ty8rQUt6bmNR?=
 =?utf-8?B?Vi9rWFhjSTV3dzBjK3ZIcFhoWHIyV3IzYVluQzFjaXo0dVdIRUVTVWl2QzhP?=
 =?utf-8?B?aDd3TUdQMkNGL1lxejZUeFFlVnhtcW5PK3gzdkZzK2h2SVRLSDZMdW5nMm9m?=
 =?utf-8?B?UGpkWmY0c2xzdFNLTVkvN0xhd2x2MDQweWxQUDk2QklFd3hUQ2d6dVUvVUpk?=
 =?utf-8?B?MTJId09TOXAyOHlTbG9mcVd2M0JDRms2L1RzSVFkbkVEM3FhRzNpWTBzWm1S?=
 =?utf-8?B?a0lvK1c0WXR5MytwNzhjU3dqbGwvOWtJU1Zoc2ErOTBkSmcvYmJXeW1wR3F1?=
 =?utf-8?B?VFFYNXg1T3h1cWsxa3RYOG1jckhRSjFjaFhnaUtPa2lHU1VvVEo5NkJ6SkZQ?=
 =?utf-8?B?N3VJSnNEWUdsMDhqVCtkYjd4Z2c4aEZkRDBBN2VPemQxcy9RMkVlWmlGbmZy?=
 =?utf-8?B?bVBET1hoTm5YUWVMU2RRZ1ZLWDNzTCtPamxLZGNFcG81ZWZLaGxGZXZ0ajZM?=
 =?utf-8?B?bmVwN091dURHNVBkeDdidFB4ci9nNFM1VHpmdHBrZnM2MHRVT1RyL0laNnpU?=
 =?utf-8?B?NzFHWlZTcUJvdW1tV3RQWVRjSlgvdXBBUys4NU1LK3F1eEx1QmdiclJzdjcz?=
 =?utf-8?B?TkpTcVhCU1lTNVNQc293WmdrZ2VRT3lTWnlEdVhGZnkzMnQrcDdtWlpzbzJp?=
 =?utf-8?B?R3hrbGx1YUtGWTdWNzNCVm5PSnpTV2I5NG1JMHIxMm11d2xKUDRRU2lKTUFZ?=
 =?utf-8?Q?bIwMQdWBoYnk19RjND+jk/w99ppquE4pj9ZQE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b13c6baf-2b66-4555-3116-08d8de813012
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 20:16:11.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mAi/BWJAYz9qmwYoMI0X+tzn66uimpDa29nBuk2jyVhHXpkHPGLjtFHxg5347SG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4706
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_06:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=571
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/21 9:19 AM, Joe Stringer wrote:
> Document the meaning of the BPF_F_LOCK flag for the map lookup/update
> descriptions. Based on commit 96049f3afd50 ("bpf: introduce BPF_F_LOCK
> flag").
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>
> ---
> CC: Alexei Starovoitov <ast@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
