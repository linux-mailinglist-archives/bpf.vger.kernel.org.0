Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48CC3CCA61
	for <lists+bpf@lfdr.de>; Sun, 18 Jul 2021 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhGRTcI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Jul 2021 15:32:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46888 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhGRTcH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 18 Jul 2021 15:32:07 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16IJB8dA014847;
        Sun, 18 Jul 2021 12:29:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=to : from : subject :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=D4subyRdJvJth9Eo5JgYukHZPy9N+w09zxgAHUPYmGU=;
 b=ZQlPeMWnjW/zFpZPniheTatEjTdhxiqwbIhDXHpi2eFP05enQY0jRykTC2Bb4/lZrjg1
 au4V58BY1+KTMzitlbwGX/ksM1EAYuaipWwtUhumvPCPgp6tplv4FGIrUllKzJKjnDEb
 YH68zrvZTKvqJFwZZT9t/mN1rwTt9b+bhGo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39uthrpfxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 18 Jul 2021 12:29:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 18 Jul 2021 12:29:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g86sibi7nP+Jhzj0wO5Pdji5gSBd7U98RPwNevWkxwK+WsL9cbNE1OP/n5gp12S54eu6Z+LAy3wW4vYRe6g7W3W/Tcj4z4cHoGuOkAkOq+nHqII70Df7UqWRPyVJD3NwlX3fXYQYSKvAyN9Gnkq+mZ6VAT/+Qt6XvlPRUPytMe9Kvz6iRB+4mWZWIebHRIDXqKtgm8L+LrKlq74RQBehDjQ9kLFSUU0v8dYYBOjbY6GNNW9UgLeci/+lIKDVhdhTQm8IiLvQMp6wSsU/lMoHtEx21lIRfwL30L7Bwl8xtz9gk+j/WEj0F5xfv0PBXRB6kNKHbdXaeCO34lG+EzHeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4subyRdJvJth9Eo5JgYukHZPy9N+w09zxgAHUPYmGU=;
 b=Sjeuzby4tAxNwdKQENYHCtjHyA7et2wZQbvRMKzqi+uWjpceiUFxx2Ei53ILjglq3BUHBmjDkjSbwtnbWoxKtJdZYzw06d9/34QsOVhCPZyo2EYpCQezGgnul6YUwP0KHXkOMm1mJ2XmeQu3ctHc7RDa0g9DhMuOT6vd/mrd809R9hk/N5RoU1ME88XTxGlHXWp5ti4Wu1evcUuh9KQcx99xorGEGIsgtvQPjFOfe1mxdSosq+DlM7yU5OGlJdsZI+Z5dSw1iVwQaT6rXOATuX7ikdS0omtyZEZpd1Zmfc/f7+Pj0U6RMYrhAVJpNu5nWrF+ZcTMyhqL18AaGGkb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4708.namprd15.prod.outlook.com (2603:10b6:806:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Sun, 18 Jul
 2021 19:29:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4331.032; Sun, 18 Jul 2021
 19:29:03 +0000
To:     bpf <bpf@vger.kernel.org>, <yajun.deng@linux.dev>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Subject: bpf selftest tc_bpf failed with latest bpf-next
Message-ID: <536141f3-f76a-67d7-a081-c518919efd05@fb.com>
Date:   Sun, 18 Jul 2021 12:29:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:40::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::11a5] (2620:10d:c090:400::5:b97c) by BYAPR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:40::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Sun, 18 Jul 2021 19:29:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eabc544-f5a0-4497-922b-08d94a224cdf
X-MS-TrafficTypeDiagnostic: SA1PR15MB4708:
X-Microsoft-Antispam-PRVS: <SA1PR15MB47086AE0ACCD8EABDD7E7997D3E09@SA1PR15MB4708.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWl6uSrsDu7CH2jMIxGZo2HGfNJjdI/UDS2oOVZnRagstfaAV/wOTCTMYFJYqiv40KTfX72b/bnAG/1qkHbLCEBNIF99qakByMPtcCWytqknNjiphNO3/6MTVZ7GillKLDeMZgw0E/8xnaV9tSGmpRKzWl03p/v1s5ZqMRAALMQa4qud6RDxDtOb77X7BXp+jZvzjMfxfqKvjM9mPNKukmVeNg9/GDdmrH/FmhLryei9yWBuWqvmTmsbB6rwWqZJuX02J3C91uHpNREw8TsoAkGI2Z24o41pT7zsz79vJJjzL7E/VZiS28yikHPE1dTNQwYzDGDvhrw9Vu8UhB+ZkkBcrU6/iDn1IleZMVhbWz3bZYLVl+bfPdZtUsXHdCtALZ3tGJItWULDnQRE3+YLj/6HzXAOx8cTkWa9nV9qn4ncX2a5boStnfuNkcQGrvPBBlyIFmuzs8Yv7bGwQiiAWnqAjEp5qbrz9YvWFOJGOn5Sy6phMlc6Ddd/6jJNytxLk3VsRBOryPzcRpbkPRLipi/cd6x0eFMEqMT3/q0OOGm94SNJvgI6UxzzpI52hl/05YbNOYCte7HEgC45rqFOjJnD9Qcuz3P7Ta40gbJWjWK9kaFt3IMpdUdQVxX9M5E4ylstmZSpNlyQ/D7gvQ0ROUwg2zUnrHBRzKNfrIyvHH2n22IbtqT/21Oaw+7O25x1ywpytMvz2A2QMwc+9oyY2oxN7lFSm31PCHEO23/MUW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(36756003)(66946007)(508600001)(8936002)(8676002)(86362001)(31696002)(110136005)(6486002)(52116002)(316002)(186003)(2906002)(31686004)(5660300002)(2616005)(38100700002)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWRVQlhReUFPOUY2L1pnMU52N293eWhaVTBpTzhobThzMzllL1VVUlVKcjA3?=
 =?utf-8?B?N0hwN1Vjc1g5OXdDdlJDRGFEVm5rS2k1MmI1b251dDNKdmQwUVJBakZBQTQ4?=
 =?utf-8?B?ZHBFMXl5a2VjK3hVRnF5c1N3YW0xd0Y1UkN0WXNSQlVVcWl1Ykl6VGVmUjRX?=
 =?utf-8?B?VnRqaSt6cXRuaDFHL3NrVEhSQUhWVUszSGNZYjlyTTBZM3pUTXpaUVh6Vkhh?=
 =?utf-8?B?dy9tdjRrNGxpSzBsaHJWUXFxRUJadjJJckl5SW9mVmNYYnVKRkN1b2hYYW9a?=
 =?utf-8?B?cFQ0R1RObUpNWUdiWTBiZHgxY2M3NjZLN2xYNG1rMUJkWGI1TjZsUVdjRDNR?=
 =?utf-8?B?WDdvL1NoUTE3K1VGNUhsV2NWYUFhM3BMdEpNclR3dE1xQzNRUlpRZFVaNHJY?=
 =?utf-8?B?NFhDaE9BYWlYS0ZQR2dkK0tRZVdIMzVobHNMbytITzhEdzVjV29wbzZsdGpN?=
 =?utf-8?B?Y3lPcmxnUWMrS3N0V3VUUWlRYjVja005K3F3aDVhNUJHWnExcWkycVBQYWZl?=
 =?utf-8?B?c0VrQWRoUGZWM2k0Z1pSenlzdjhXWUN2ekphcE45NzAzWnpEVG1wT2dVN09F?=
 =?utf-8?B?aVBhQStUWmZsNXd3K2N3Rk1SWXp3bW9BclZKT1JiQ3htbmNTYUpwUmNqZHRa?=
 =?utf-8?B?RVlRcSttYTBzRVRvSy9qUEswdGppb1VuRndHcUFZQ0dka2EvbWpMS0ZjNkpO?=
 =?utf-8?B?ZjRpanp1d0JkMTFNSWZCT09UWTlLYnJXaTRxUnh6bmx4ZXBQcW9RMW1iZkh6?=
 =?utf-8?B?ajRIUDJyY1dHUjdtelpJRjdwa0JWbkJCbE1sdktaYjJQWllOZXE5WDR1NWtk?=
 =?utf-8?B?Y1BORk5pa0s1UlVUc25vVGdnUitaSzhYa0o4alFjTzY0ejVjSnNWdEhtOUpv?=
 =?utf-8?B?eEZhV0hUTS9JOUhvcnVkWjFIODhrd2ZiNjBidVZRakNZOFlqS1JSZU5HVXRz?=
 =?utf-8?B?S00vUHZ2V0xMRCtrV3dCNVAzZmlRZDZZZE5YZzgvSnFRekEvVE9XRCtCMERr?=
 =?utf-8?B?UEV3YkRVaklKYTBMNktaQzE2aERGaEpEeG5DUm55T01reVBBZUhrNUovSmhZ?=
 =?utf-8?B?NXBhVkhQcms1TXhvdG9uc2s5RS9LVU11WEdLTmg2YkxDb3ovTW5jekFydUR0?=
 =?utf-8?B?bHdwOHpGQkZTaW5lemhicE5idisvd2xUVzJYZ0lVb1g2N2c2Y3g5N1IwMjEy?=
 =?utf-8?B?dnZxNDBHOWIzTDFVMW9GMkJ4U1ZtS2dOak9sbXg2MzBqUVlKNlRvelNlZnFD?=
 =?utf-8?B?MXZpKzZrZnVjK29BVmI2OWNkcG1VRzhBdjZkSlozVXpDS0hoN3VENU5rS2Ju?=
 =?utf-8?B?dUJtR0cvam9HbEtOanhnRVhGRUhWbWNYQ2pQREFtODBZR2pmdjRWc2FWSUtM?=
 =?utf-8?B?ZEVjWW4ySjN0Q0hiSmJRWkQwRDNRbFY5UGJvN3NwbkhEZHJncDF3c1ZxVloz?=
 =?utf-8?B?S3BaT0ZYamM1Q25HZFN5UUF0RlZhWW1RVlJwYVIycWFmc1ZWTWdkYTNhNmI0?=
 =?utf-8?B?VUJob0lBTGR5RFFHQWJVcjFqV0cxKy9nRDhCaTlrbUlzeGQ1cjltRWtvVEVK?=
 =?utf-8?B?enRuMUd3MG1hd1hJUW01OU4zNjJwSkVtUSt0WjFXVVBUNnBIOXdyeU45Zysv?=
 =?utf-8?B?a1JmUWhqN1NXMWloM05YaXdoQmVlbk8vdkRqNGFSQ3I0L3ZwMmhyKzFPTWpB?=
 =?utf-8?B?VFJvdWNVd1Q2cGtJaStNZU14OWhtZy9VWEhYcU44UVcrbGxmR1ZibFd3aEx6?=
 =?utf-8?B?dld1ZmdLZzZ0QXJZek1mak9EMExMZEF2d2Znekt1dHBRbDdKYStDTzdVVVZa?=
 =?utf-8?B?cmNTNEdlbDR1cVN0WTRhQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eabc544-f5a0-4497-922b-08d94a224cdf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 19:29:03.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2S5+9pr5Ei28u6/EWKpbGHBOX5xJVZBqOslotATuPs8C2DQYpEG0MJxrpAJiRFKj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4708
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 3OWaFH9KrOVUm0YVnnTodJm-tmv_zHTT
X-Proofpoint-ORIG-GUID: 3OWaFH9KrOVUm0YVnnTodJm-tmv_zHTT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-18_09:2021-07-16,2021-07-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1011 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 mlxlogscore=976
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107180132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf selftest tc_bpf failed with latest bpf-next. The following is 
the command to run and the result:

$ ./test_progs -n 132
[   40.947571] bpf_testmod: loading out-of-tree module taints kernel.
test_tc_bpf:PASS:test_tc_bpf__open_and_load 0 nsec
test_tc_bpf:PASS:bpf_tc_hook_create(BPF_TC_INGRESS) 0 nsec
test_tc_bpf:PASS:bpf_tc_hook_create invalid hook.attach_point 0 nsec
test_tc_bpf_basic:PASS:bpf_obj_get_info_by_fd 0 nsec
test_tc_bpf_basic:PASS:bpf_tc_attach 0 nsec
test_tc_bpf_basic:PASS:handle set 0 nsec
test_tc_bpf_basic:PASS:priority set 0 nsec
test_tc_bpf_basic:PASS:prog_id set 0 nsec
test_tc_bpf_basic:PASS:bpf_tc_attach replace mode 0 nsec
test_tc_bpf_basic:PASS:bpf_tc_query 0 nsec
test_tc_bpf_basic:PASS:handle set 0 nsec
test_tc_bpf_basic:PASS:priority set 0 nsec
test_tc_bpf_basic:PASS:prog_id set 0 nsec
libbpf: Kernel error message: Failed to send filter delete notification
test_tc_bpf_basic:FAIL:bpf_tc_detach unexpected error: -3 (errno 3)
test_tc_bpf:FAIL:test_tc_internal ingress unexpected error: -3 (errno 3)
#132 tc_bpf:FAIL

The failure seems due to the commit
    cfdf0d9ae75b ("rtnetlink: use nlmsg_notify() in rtnetlink_send()")

Without the above commit, rtnetlink_send() will return 0 even if
netlink_broadcast() (called by rtnetlink_send())
returns an error. The above commit makes it return
an error code if netlink_broadcast() failed.

Such a rtnetlink_send() return value change impacted the return value
for tfilter_del_notify(), in sched/cls_api.c, in the above test.
Previously return 0, now return -3 (-ESRCH), causing the test failure.

I am not sure what is the proper solution to address this.
Should we just adjust test, or kernel change is also needed?

Kumar, Yajun, could you take a look?


