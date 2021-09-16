Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427C440D1C4
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 04:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhIPCxx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 22:53:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26690 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233999AbhIPCxx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:53:53 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM458e000836;
        Wed, 15 Sep 2021 19:52:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=JlGIqCEbv69GaF/5n8M/xBMXn1uzo7xK2PTyLrgxH7o=;
 b=mT3F2cQr/b6hyT+Oc1wcIB+GW/xUg2aM9PFQovuQsHmXhKd/niroh23gwRcvH0ywORta
 Njd7ma97oN1oYnAI/Fxnrwjhsn6Ic7bhepGdui7kK6F/jEhKEVz/qDH3MiZefZFaaUrU
 LOYW6YSAxLkR663khX8bIcEQZd9kvUMk2xA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3kv0kte7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 19:52:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 19:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHspF+wgC2DWr2SSGV/sWw3PN6Z46+mQB9Ca+IJtTlz/9Zu9E5jeWPQNubiiSjNqeS0nSexOG44L7ZGo1m3sDJRbzIqXN3mAkKX5lpBStbXINoxzqUlhCooIbIzRK366bcNCOGLfHmDiBMluGdfdTDSckRs09DnRJkaBBY+cfAXdYvvtxo8/XguKq1kPgVpFjjoAHMalMGkD10J8picOn/4fGRQTHIWJcjRWEqcsCX66wriCOZKPBAWT0iYybiydqxbzZB53jtA/6WtmB2xsGaw8695lyOlT7XWIhuIVeiKdzYhOXPpwYGD+XpzbAX7SbrX+S/8c+48HoSRgNM/hpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JlGIqCEbv69GaF/5n8M/xBMXn1uzo7xK2PTyLrgxH7o=;
 b=nEvqo3DvZhaHxljsBfU9w0j8qy0Xq5sO6kmskCBOtkef3Agr8eiR54KL6D1ahqzvNsZdPUFD/fzUmZUAuCytlEGeTg1m6AXeY6P0DOAj5LZXxW4Y2U5wRsscBXqx8p8GPZRJ5IM+pcahkJxMvnRhdJbfk+APghvQTgNhFOxo6a9BVBlJYD4ScQmEBqBC9ntMJeffD83Y/q/gAE29dLjrR/CcvJyd/P+O723frkxo6S5s4hbhnd14WNqDUccG87A2bNKMkXwwK8hOn+dME5GRLv8vOsl53v7tT2hQUDqIB1hYJY21S68UIAxQTRLZ4iuOEGj0PWBK7cOtFMJK7Y+6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4660.namprd15.prod.outlook.com (2603:10b6:806:19f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 02:52:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 02:52:12 +0000
Subject: Re: [PATCH bpf-next 1/7] libbpf: use pre-setup sec_def in
 libbpf_find_attach_btf_id()
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210916015836.1248906-1-andrii@kernel.org>
 <20210916015836.1248906-2-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <44214572-6641-06e9-1b50-44fb0e850e92@fb.com>
Date:   Wed, 15 Sep 2021 19:52:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210916015836.1248906-2-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:51c) by MW4P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 02:52:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b13f69e5-92a6-4457-07c7-08d978bcfbe5
X-MS-TrafficTypeDiagnostic: SA1PR15MB4660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB46600CF0C0860CB6B9E4CC4AD3DC9@SA1PR15MB4660.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMdTyDvQeLZJEkt3GDzDkUPyJJB2aWK5UqA3icwP+fP6zZvxR6z1JVU4LpaO5ioVADFzM0uUGmcpjnsXNMR4NSTbnwD4DSuGs7sWhQ0x+LiXRrwbPwowVLIiF1dx8VR6XfhyHJDEVxe26HLL0BiWQyVhRA/2HUQSFa11lRKBtpH/3Z3eQmJMZ+uQ8P/bFsm1Ng4eFm8SaBIsiayj0xsZIj8SyYBfdVUkAPH4lCG8RwgiEKTHbVVOWwBpXGTWwhj4wGwPyKQkcdRx3LeAwGUZ1443abGjdm6slfYgOe+wmkFjmeh7boH6bVVB7OJtZSb2NKGzdweC5sgx4rPjDWIKRomuVgDnhYX2edVy6S7geX7CYawINiEfOTNoMHM+DcYdvW7Pw5ZvoYIRtpUhGXab796ir6lSGt5aImgo+nNU9l1NYTQWDYUGNsXJ38dCXt06WVFklL8zLkZtuxhOaSNtYtHB8xtd8nLUvm76ljwhot6pTPDWvCDCeufImhV7hPC2amkjlQEfTkA8+tepUOutV8Tf1fXMPztYY+1E/yADLReMMFnscWdeDkah/UAdKtW+fs0PQeTdpMTMGjovLzCA6I63Wj0AOovzErnHEDw7/Ta1h8oQKb0myWf/2rPFgM6wWVKJJ1HHbdQ9BkIKoQYiuVmjJVNpAMfHQKZhqU8QYoIbsTdD1o1c5xV3Km920MoYwWyi6FXmNnWALTYL67JjnLPqf5ltwzweH73bZGPcdsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(4744005)(66476007)(66946007)(66556008)(2906002)(6486002)(8936002)(38100700002)(8676002)(2616005)(52116002)(186003)(36756003)(53546011)(316002)(31686004)(5660300002)(86362001)(478600001)(31696002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0prb3FtWjNEcVJPTStHbG50elZZUnhKbkhWL2JUWHJqTXVieDJEK1M3enEy?=
 =?utf-8?B?bnYvYjJ1eExZUnJ2RFVweThpSzBGN0ZuejFwYzZ6QWpCS0k2R0dnaGt5SzlU?=
 =?utf-8?B?ZDlUQWg1TEtibzNabk5BRzAxQUtGQ1I3VzZMb2d3M0hCU3VlQzNrS3RwZnVm?=
 =?utf-8?B?eUczUWVjc2lBbzBFNlFhOVRkamFnd0NtbDNYSGQxZE9laDM4VjlVY0N1ZHQr?=
 =?utf-8?B?dXc1L3FRU2NuWXd2cUFUK1JXM01SRnVvU3NNa09kN0dadVN1SzdGK0NrOVZs?=
 =?utf-8?B?RnhPelhOSjhmZHJyT091OTU4YUF4eTB5dU8xTEJUMEkvUXJ2anJVMTFZV0lV?=
 =?utf-8?B?M3JCSTJPSHBzRXp2VnptaUF2ckNCMWV0cUkyUWhRQjdmMUhYTGNYZUdDcitB?=
 =?utf-8?B?V3p2MHRBTEdDejdGK05CeG9RTlRtM2NTeGVpTGtxcVZpLytDOGs0UW1GT3d2?=
 =?utf-8?B?eWlzY3pUSlVqUFJRVGF4aGlQK2ZBM1EvZlR4UEtVUXZKZnh5NElqVUh4M0VM?=
 =?utf-8?B?RndRWkd3eDVPOWRJcGw3UnFlb01Pak5NTS95VDhBUHJJSTl2OVFWK3ljMkpX?=
 =?utf-8?B?RTBUZi9BRGwvUElWYW5Dd2JGREh6ZGs3ZGtmbzh6cmEzaVhnNDd4eTR6Wm5N?=
 =?utf-8?B?T2ljdVZkTHNtT1liS2YvRkpsNWg3UXdlbVhrV2QrUXVJcmJTRWR5OHkyME4z?=
 =?utf-8?B?VnJDMHhuaGhkdmRHUjdwTHFxbUJJRmw0UDNGL1J4d2M5STY3ek11cXN2MS9O?=
 =?utf-8?B?dllxTExuRlkycVgrNkVHaXpCTHZHaU91NnVIOXBGN2NwdFFhb3FSVlhlbThv?=
 =?utf-8?B?T0xuWDBwOGNRSmpBOFRaUkYvMk9XNlNZS2REMTBKYmRRUzdEeW9LTlZQYXk0?=
 =?utf-8?B?NFNqendVaVRyR0c4RHdWY1RkOGUwZ3RPeG5hWHF6L0F2bzJFZTIxZ2MzT1By?=
 =?utf-8?B?VDZLNW9pNVZ3ZDRaV1NHckdidVE1NENmWDRPL2JrbVJkMmw3TUpaKzh6WnRM?=
 =?utf-8?B?Vnh1d3pmSTE1bWZNRzQzTlc2YUdYRmdjWTJZR1BaM1pmTWNTb2l2Q1JaMjUv?=
 =?utf-8?B?OG42K1Z3c3dZQVZWZk9aTWIyRW0zSk9GRHNtNVp6dHZvanJwTTJOYXFqNjJz?=
 =?utf-8?B?MlVXc0swNHVET3BPeXRmd2NSN3NVT3VPcGMzckpKdzJCVkVydHJiYWUvWHpk?=
 =?utf-8?B?VFQ4OVBxWkw4UE40dmlOT09xOTNVZVVyV0MwK2dQMnZ5alR1WFIyTWhCSUlv?=
 =?utf-8?B?eGZxQXB3NVR1eUVFOUYvRHRiVzk1bnIwc2pWL2gzSTFoYVRtUUF4Rlg1ejUy?=
 =?utf-8?B?akJvNSsyWFJmUTNOTzEvdnFzN1F4VGNnVWw1RGdNVDFyZWN1WjRmN3hpRnk1?=
 =?utf-8?B?c0pKUnU3ZXNzenkxL1ZyTXh2QWNMUVZWVmNwa3V5d052VzZOS1dyK3V5UzNG?=
 =?utf-8?B?YW5wYnVQSnRCaWVaQmpFNnZzTmxSc0ZOUWMzdlVwaVdlWjlpU0VRM3lnMGJJ?=
 =?utf-8?B?UDR5VmhJZEw0VWJ4RGdnd0hmN0xPMlc0QWxTV291Q1l5U3BJdnFsWkNuZE04?=
 =?utf-8?B?eG5wS3lxdVpSWDVFdjhhSGh6RUJlQXA2RnZHSEptWk9aVnNvdXV2NkN4UElz?=
 =?utf-8?B?TkZUQnY4QzBjR1ZycEVTbnBLWWVBRnpJRmxLVURqd21VZ1BiVTJ0Ymx2d2x3?=
 =?utf-8?B?bjZPOEVRZGQyWktoSnUyYUh0N2VaejRoanh0ZWJWM3I3djl4b3RNMjhuTGxQ?=
 =?utf-8?B?bkoxNWRzem1YTXkxZ1VkYVJDMkNUNnBSREdaMHhvYjAvdzVYcGd4TVJtSzFp?=
 =?utf-8?B?RGxuQnR5UGF6ckw4NHhxQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b13f69e5-92a6-4457-07c7-08d978bcfbe5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 02:52:12.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbSOCkb4Tjk1suw66V5bNq68Xlm5+cyxb6GZRns1oadlLIW4/V4VllPh/BweeNbN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4660
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: VmVly280of81fFM0zNe00warQWbuep9M
X-Proofpoint-GUID: VmVly280of81fFM0zNe00warQWbuep9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxlogscore=567
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160016
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/15/21 6:58 PM, Andrii Nakryiko wrote:
> Don't perform another search for sec_def inside
> libbpf_find_attach_btf_id(), as each recognized bpf_program already has
> prog->sec_def set.
> 
> Also remove unnecessary NULL check for prog->sec_name, as it can never
> be NULL.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
