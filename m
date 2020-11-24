Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA0B2C2EAF
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 18:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390776AbgKXRf0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 12:35:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42624 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733250AbgKXRf0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 12:35:26 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AOHKb42002216;
        Tue, 24 Nov 2020 09:35:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HlIuASl+LkOC44Rvj67b9KhuC8vSy9UkgRY1jWfDcWo=;
 b=nC/NOOdyE1mOXgkYh3lm/zqHzNOD4XL6K7VzEQ9WuoZEOuYaEPnfzT0hnRQkYPmeMr59
 tcO4qLXx3J+OnwMwOIkiBz8wLkriA1h3K5lpsa8FnPv0sMS0ZfeAQ143IMHtDTY6YjEF
 QYIh+wjJKt5Mn3c4Y9vXF4lYbfTtdoxMdCg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34yksttmcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 09:35:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 09:35:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ur89Mk1kvQTnbXZCciGFCbqvb2FlrRkP0IuKSfgWED7PO5uKNPJF0ZvIwCrpNM+zAckVp8cCD1MGXmqyHvaP37maR6gBHyNSNK+8HsKnlujd/Y2mmnkx2UejfCgwN8yjyvDUzBxXGTzZserHxfRJ/ZnvnhotVDJZa9szEDYhCdm7giUyk5F8Uidrq+mLmIqENhPMBF94XlhIeauoKNIA75WQKVTgAiEaDz7ui83xdY8llKjQ6TRTb1ZdeULZSYiOMlXo4JUSUjcPfecQ95PPukrDBOR4quIQaj9KbnCWuJ6ReV2PQt5d1GSngVYEI5fzIlDTYvLAe++fPX4ko9CnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlIuASl+LkOC44Rvj67b9KhuC8vSy9UkgRY1jWfDcWo=;
 b=HBdmK1L4rqar2ejYagzwwQQYd4cFPN0aIWytrUKbc83tAV3IuU4cOJY4p+++xxXs5w6oB7FraID3DMvToDSyR/HE6+daUt9r+2MxFvT3XkbxlQnp/TdJRq4Iar/zg4ioTwAKNhmdCvXlkitrnRVptCFt8U5VQ0Rc7PYDJykp0deqRBfaY73K7D7uoWjPEmMpCUOa9dKx5V4d4TzxYslN/bTJTIvYLhp7bIPZbbZe+VqfUTRDHZtsm8tY3zXwC0l1pZmAzBQBOBZmxFhRNgPIMnATtvoPFUVBOhFmpL5R7tFu/6jxz2m8NWsG6TPo/wRtyhlrZ3/+dTX63LLFHXhOUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlIuASl+LkOC44Rvj67b9KhuC8vSy9UkgRY1jWfDcWo=;
 b=QJiEy0zAaVY+etOM8LElCXFR1SRoGtF8Y6gvdQq8J0vK86YFAWHehYby+1K9/B7OPdmGwt7X4QvoUwmD20+MkjHYp3mHqtCn+1laQ41nE3KPmjG2sH3s77Utaz49cxcLuPzNjy6OaOHmuyLAilrx25uL7nhaEhMNZzOTl3ywXXc=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3365.namprd15.prod.outlook.com (2603:10b6:a03:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Tue, 24 Nov
 2020 17:35:06 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Tue, 24 Nov 2020
 17:35:06 +0000
Subject: Re: [PATCH bpf-next v3 1/3] ima: Implement ima_inode_hash
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-2-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3b6f7023-e1fe-b79b-fa06-b8edcce530de@fb.com>
Date:   Tue, 24 Nov 2020 09:35:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201124151210.1081188-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4987]
X-ClientProxiedBy: MW4PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:303:dc::32) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::10b2] (2620:10d:c090:400::5:4987) by MW4PR03CA0357.namprd03.prod.outlook.com (2603:10b6:303:dc::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 17:35:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 616c20e8-2918-4cf6-f6c7-08d8909f4828
X-MS-TrafficTypeDiagnostic: BYAPR15MB3365:
X-Microsoft-Antispam-PRVS: <BYAPR15MB33659CFA561A0D90DD80CF12D3FB0@BYAPR15MB3365.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssXSxTuIiksKtlTn5YqFeGM4HnluPDEBd4mFPaXToWLjmiDGVzse22qnU+iAd/YT3yu7TzjFWDZ2v+usaqhH6x6xN5OatXriyrBpvlseXdWZmHHGJI8n7B36JDSYnkNTljYDKkSTfwhBZfBdFuS1fWHZf5Ujsu3xk7ytmesA/VOFGJt7XuqKcE7UbBgMRnsduY/j0gCUr3pAbSTEkbl4QoZLOEa2sOT+0HZoA+PxbvwD1gOKdIy9qcTy9GTCFi+Nr39u/oRKs89A7ijGpLltGBm0rrI8D5zWDRMd8otOjAwSrVHfURnJ4fX0Y5hSXH9YoChsLduNNhfataK9eDJgL4ESH2mEifwEbjYiUBRw8osHGmlvb1LEGFydraLK5wob
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(136003)(39860400002)(376002)(4326008)(36756003)(2906002)(316002)(7416002)(8936002)(4744005)(31686004)(6486002)(16526019)(186003)(86362001)(83380400001)(53546011)(8676002)(31696002)(110136005)(54906003)(66476007)(66946007)(52116002)(66556008)(2616005)(478600001)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RWdkaVQweUlWVVJ5dGt0dUo3RUNKQVVZMUpTSXBzakRhV0NTMldYK0o1RXI0?=
 =?utf-8?B?RXE1eHVwRXRkSk93WWhNSXA0VHc1NDFLTU9MaGxSS0FEL3lsWGdVN3diSGhU?=
 =?utf-8?B?M0hvRW02UFpMNXRpVUJlY2twazh0bVJpMjk2ZklXcmdUczlHNGZ2WEpSTXVP?=
 =?utf-8?B?UTM2VHgzd0t3M1ZiY1Z6UHV0RlZoeG56TGJHcThyMTF6RExvVktaUXZGNlVX?=
 =?utf-8?B?S0FsQkxjajhKaXQ4ckoyMXFtc09vNmFjS0o3K2d0dXlzRFhhSGlXclJoUXMy?=
 =?utf-8?B?RHZ4RTBBWndHcHY5Z2kvTTk3WnZUVDdmcUQyMDVRZGowWDJqSVAwcEU3NGRw?=
 =?utf-8?B?QjhxWWtzODAzS0QweG42RlFpZ2hKcDR1UHVJS0JuOU5nYm85bWlEd3diRkgr?=
 =?utf-8?B?aC9PMThMZ01IcUJWRnI4ekZBMWZvQXFyT1hSYXFkdC9pU0NZSnFLNjJ0UUp1?=
 =?utf-8?B?RXl5TnJHclNLLzFCTVJ2M3dXRSt3aE8xcHlZeGVUbnEwRFQybnU5U2tnVDBT?=
 =?utf-8?B?ZUYxTVl2aG4zWXBEUmhvcHNNSFFyTlZKS09QOVpsb0EzNEdQUERIL0tQdW5y?=
 =?utf-8?B?MEhCVUdQOTJVSVpGbE5ObWhQbCtJdW5CV3krZkVXaHJsbStFMjJTaXVTdUJU?=
 =?utf-8?B?MUREZ3pjS3ZrSUlwdVlheG9rMHc5WDFMMjdtSzJ6UlM4R3B1a1NDVEJtVXhE?=
 =?utf-8?B?NUk4M1dVWk1zLzVjanZGWEhabWo0ZlhuMWY0RVVNOEp4US9ST3d1RE5xUmJu?=
 =?utf-8?B?UXVLY0srcnlyd1N4SFlIN1dscWNRTTc2Y2NKTTFwdVVNUS92R0t0d0ZHV245?=
 =?utf-8?B?YVBwdDBUOFA4NWwzNlVHSzhNMnQ2emM4V2U5L1RnRVk4cllPOWF5Wm9JcXhO?=
 =?utf-8?B?MlgzYy91ZVV6clZKSDlsTTA1Y3RaQWlNNUdVOVZvbUwrclJyWFptVk5leDli?=
 =?utf-8?B?QTNiT1c3WHFmblIvWmQ0elQ4SW1oYjhwMS9oeE5XOC9xa0E3d3lCSFpPd2Z3?=
 =?utf-8?B?RGJhLytDT1NkOURwS0VoZm93MXBsdGwrMnd5UFJjVXc4SmxLSWluekxvZ0FQ?=
 =?utf-8?B?OFQrdGxiSEYydHo5clhCQnk2b3lCZUoxWHZQOFdUQ3Fyc1dTQ0Z3bzB2ZldS?=
 =?utf-8?B?UUNMTjJPclA3NTVqYXM3RlY4QWVXNVpaK2JhT3FneENNYldZYkZnQzJDa2lT?=
 =?utf-8?B?WndsVHpzUUdzOXR0NUFwdE9zL01VQkZ5eU1zMStYL3lSazZvblF1UitHNUNo?=
 =?utf-8?B?akVtVDBBY2ZPKzczRzloUEFGRzNnaElnOEtSVmN1Y1djaXhHV01DWWM0UkE4?=
 =?utf-8?B?UHdKNUV0TVVRZlhVZ0VBbzRSUFNuNCtFM0xKOWZyTjNpVmZydXdxKzVaNXlw?=
 =?utf-8?B?YThWbkFWWkRVTmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 616c20e8-2918-4cf6-f6c7-08d8909f4828
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 17:35:05.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kUb24Lcoxtu0h4HdDnxByIarc6LRvUThMKUPcmV3nNZ8Ty4PpLFzAOk2zIkqrU7l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3365
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_05:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=806 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/24/20 7:12 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> This is in preparation to add a helper for BPF LSM programs to use
> IMA hashes when attached to LSM hooks. There are LSM hooks like
> inode_unlink which do not have a struct file * argument and cannot
> use the existing ima_file_hash API.
> 
> An inode based API is, therefore, useful in LSM based detections like an
> executable trying to delete itself which rely on the inode_unlink LSM
> hook.
> 
> Moreover, the ima_file_hash function does nothing with the struct file
> pointer apart from calling file_inode on it and converting it to an
> inode.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

There is no change for this patch compared to previous version,
so you can carry my Ack.

Acked-by: Yonghong Song <yhs@fb.com>
