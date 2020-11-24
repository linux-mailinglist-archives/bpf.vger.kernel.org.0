Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5042C2F01
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 18:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390773AbgKXRmE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 12:42:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3332 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390713AbgKXRmD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 12:42:03 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AOHfSbW024357;
        Tue, 24 Nov 2020 09:41:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=pez9ohBBbBKIszV+S6dK5DPpVBncky07UQ8T6La25QQ=;
 b=Fpj9Xfxw6WK0ZTUjbS+36RkO6OJV1uQUU5S9KaG/JBQ741TjWNfwmousdE1+Hfqjeyxm
 cPpwZ9Vt86UMBUpAnswcgopTC0nGKCldGD99HqSpjQjGJlsqUjj1A027bJUfrgFVvsAf
 xg7KaXMvVk+Wwhqxs2oDOJC5TrGwzjXQzLc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 350qy4ue65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 09:41:48 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 09:41:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr/8G36OO3k4HoqzJluhj9b/sLTjzdOUY7h2Fp9+rHRVTNX0sw97V9c3lDIsccSuEpbEdcGzni1iMN/oZELwSpmoTPuMYoJdn0Z35GN3n6Pqrq+wARYYqbBi1+WtplsFkrb6yU2S/ExjBRPg82rdmU57vKPT+Rz62IyEBWomdATTUOfeQf8c6BAU3MlG7SAfB1cGC6ImHUNfEoRVWoFUSNuDJ751VZKCk/HvlsNCeZKE/ZCMEHxXXoydEIvrNJxubW7gZ7AcDbjc0oUcjCfTnDgeW1TbOSAkB6YdAuGqzjDlYGD0PmBEySxz1ZxgqI/kyd+2sTnvdI+145eRdXLy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pez9ohBBbBKIszV+S6dK5DPpVBncky07UQ8T6La25QQ=;
 b=ZxNb6WsOAUwuo47ZS/ungNhqXTUXoYDsE4f3uu+vNU7/hhMlP1QEBWY7MxfMt63/7M0iJBK/YEOpLta+GMSarP70T3zyTSnr84g9OGmWRt7sewWpGlp/vr/m8QaplC1mz/nXmbNPLFsNtnKpjCKxEpwNr3Xo/OR4MIbVfvd2n7zhY2fnXoYicESS+10dqGN4z5KHOPWK9Ga7rgO8vIo9q/7cWNcLBWSyGoFqGjjSnEiR/+9wV0neGdmPk/vybzWsEk4CjWv5j7iGIxR7903e2Wk0E4aBBhPsFo/X1cSpDpccrbxUdtkLFE6+YKQZnUAD4LV7rQb0k4cN5TUyx+j7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pez9ohBBbBKIszV+S6dK5DPpVBncky07UQ8T6La25QQ=;
 b=QPnHxlFvNVapEJcWYQ1d+zAyA1jNGcuVGUbuIZj21qjpqZVpIjTY+oLQA2XyN7P/ye7bSF49K8PhRR6txTEXgtFUKGnJYxfed/oGVD0nWB7PRprQAxYgnmLdtVbHmRsxOYNclLB8NOkVtND1t3HyKYqjefVJJ50r6UIvQcU32Hg=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by SJ0PR15MB4204.namprd15.prod.outlook.com (2603:10b6:a03:2c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 24 Nov
 2020 17:41:45 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Tue, 24 Nov 2020
 17:41:45 +0000
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Add a BPF helper for getting the IMA
 hash of an inode
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20201124151210.1081188-1-kpsingh@chromium.org>
 <20201124151210.1081188-3-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4f1309b1-830b-f76f-0b9b-c783f062f0ab@fb.com>
Date:   Tue, 24 Nov 2020 09:41:41 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201124151210.1081188-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4987]
X-ClientProxiedBy: MWHPR1401CA0011.namprd14.prod.outlook.com
 (2603:10b6:301:4b::21) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::10b2] (2620:10d:c090:400::5:4987) by MWHPR1401CA0011.namprd14.prod.outlook.com (2603:10b6:301:4b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 17:41:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ccfa16e-4c84-4cdc-1404-08d890a03624
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4204:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4204089EEC90F7DA8D8E2412D3FB0@SJ0PR15MB4204.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v+cxCthuc/7qrQ9ZbDN+adBCauOFfknwYGJS8F7Bx9RS9wEKvZoSzEjGTSkWBYlv21M7qi3b6tD7P1wBRm3izOks1tg5k51j44zjpjySM+iiu8SC65cLk+QNo5BJjxXezmP6W/nIlvB2+RN8KzdpB4MNgOcPAW9oHv0yuCgIaUGPGU84/x0YxuQiHMK8G9vY6sisLi8YWYY4giFDe7sE9UX2guV05psfad4bvm7Mcrk5BhhXVSbdHhMThmaHjFC98aXznDhhGopiYmKaoAoL3iXV8jgKjxDjZfj6/8QPOQhxUX/1unav9o6Cxb1IlXTwADk1+wYIgNe9dvuTrAzwpDHbqFbuHOey74M2eB0AT5VZVzf8YKJeLVyO4I9khIlE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(366004)(346002)(6486002)(54906003)(8676002)(16526019)(66946007)(478600001)(53546011)(186003)(52116002)(66476007)(316002)(8936002)(36756003)(66556008)(110136005)(31696002)(83380400001)(4744005)(2616005)(86362001)(6666004)(31686004)(2906002)(7416002)(4326008)(5660300002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SmcvMHo1ZEdYMlBFOGVLdXJMbHlFMmw0WEFOWFFFTnN6ZEliaWZlOC9OR05r?=
 =?utf-8?B?U3YzRExsQ2R1cjVCZTdzN0lHT2NLekV0UGI4TVhBekZYUXpjZmNKQWRNbUwv?=
 =?utf-8?B?aTl6YjBLRlhuTVRER2IwRDF3eFo2TStVdjBkRHVXNEdRTDhBN2ZWc3pMcUFl?=
 =?utf-8?B?ZVRDL2t6anZKSzFudDZvank1bXcyVVVCMlgvbzFOV0dnK2xnV1NBRkZhUmxQ?=
 =?utf-8?B?bkxrbTBnUHd3RGM0enQ5OWt4bmEyODdNMGJvM0pJUFVldXZUcVhPWnpFY1Bq?=
 =?utf-8?B?Z05GWkd6M1E2QUQ4TDBEZkVvenN4YzcxS2dhVWZLZW1NMm9FMVhoMi9MU3E3?=
 =?utf-8?B?YTREK3d6VlZXWUpMZzA2KzNMQ3pCMGZReUNVb2dmM0M0bk5oTm5iS1Y3T2ha?=
 =?utf-8?B?M3lKaDhwa2hrTStMUjZpZUNMRlNzQURUMXVzblVVN3FDYVR4M1VnVUZTb0Q3?=
 =?utf-8?B?Ym1ScjYwUjg5WEZWZnIvWnAwdDk3engvUVlsNWFmZ2tDSC93aVd4MmxXdkRl?=
 =?utf-8?B?ekx6QzlvL1dIK1E3NHNranpEUE5EZlg4dEEyM0ozSmNmeTZWV2hHU1hpeGVa?=
 =?utf-8?B?TnkrQjV0Ymp3c0pTQnl0S1NRNlB3aUF5SzZVQk4zU3JIVjh6TW04OWIvNzRQ?=
 =?utf-8?B?NnROMzh1UGhCMEFUWndRRWppdlhTMlpURWlGaVU5c1J2MlkrdzBoS3pJamhD?=
 =?utf-8?B?a2hyVndNQ0NKa0NRbXpvdmJvRGp2a0llM2FtZUNtYTJUcy9wNFJYNU5zUElF?=
 =?utf-8?B?UmFIaXZQTjRJbktEU1lwZnF6WHppUkNmcnh0VytPZWsxVVYvb011d0NuWHgz?=
 =?utf-8?B?NU53NWhWa01lZ2N6UTBvanpTdENGczJkNDVoRVl4cjhxVFhsMkpobWhMYSt0?=
 =?utf-8?B?dEFjbVpDak5nODI2QVM0V0NzTjNaVHVBaDA2cTAxZHpPVzJjaDJVVkI5YVNO?=
 =?utf-8?B?UVZGRlBmZnpFMlNJREw5QldzQ2NkUUY2aFdVVTZ6b3NrbUcwenBWemMyc09K?=
 =?utf-8?B?Yk1UVkZKaDJKZWhqNkpEdXp3bFg0SHpYc0VVNldqbEEyWk1iR0NRMDFkYmJ1?=
 =?utf-8?B?MklVVGdFV3dHWWxRRGNBL1ZWemhIWmFsVXdISjJpWDZEWUh2NjVaM3pOMEFh?=
 =?utf-8?B?Ukx1U2EwL3FxSGtnZ1pZYkhkU1ZIZFpmdDUzcHozTjNqMDB3MCtTUGovdVFq?=
 =?utf-8?B?d0ZCR2ZMT1VRTjNHOG16bEhSVUNMeGU1M2tOdXZWQUJtbUR1WUU2RWM1cnBk?=
 =?utf-8?B?VFJMQ0o2dGQwNlMxZW56ZkI5Z2tuMEFJRnZGbFUxNGtFeGJ3eFdERXJQdlJl?=
 =?utf-8?B?Ui9Yc2xJOGZTRTRrOTNybnZWWFFGOEJlOEJrWFZ1NG81TFhPNWQwRnN4SzFJ?=
 =?utf-8?B?cGlkUHNCRWdrcVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccfa16e-4c84-4cdc-1404-08d890a03624
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 17:41:45.1485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IInCA/eKgLCLYIwGzkAqn1jSa+6go7+st0wmSS9kkcFV+VjUSksUrUG28ix4iGQU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4204
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_05:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=926
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/24/20 7:12 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Provide a wrapper function to get the IMA hash of an inode. This helper
> is useful in fingerprinting files (e.g executables on execution) and
> using these fingerprints in detections like an executable unlinking
> itself.
> 
> Since the ima_inode_hash can sleep, it's only allowed for sleepable
> LSM hooks.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
