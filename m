Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EE52F35E5
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 17:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbhALQh3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 11:37:29 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56666 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbhALQh2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 12 Jan 2021 11:37:28 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10CGTpkx023822;
        Tue, 12 Jan 2021 08:36:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=TNqR3H0Vi6uSoCBAkxuzuiD2DcGBLyEtbd3d4r2dcXg=;
 b=RgZidS9SDmIl32niS0EhbGlBDO2FtO8jH1p/Y62QcUZHNEDvhFZuYAQRrcr9QcfpKSIt
 pb8Z3i82FnKgm9dPPo3ft0bcL9r43H3/EJNc4+8hjMXvJgLiGvsz9E7jvfhadYhoOfwD
 LQWquUGZDshoJlSTJP690NOPbbe9JxT6/fI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 361d5n0ugh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 Jan 2021 08:36:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 12 Jan 2021 08:36:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh+QDXZij/H3BkgmqqX7LL6c/X2AOooOJt2lCfEhVLwm6UpnRqZ9TxARcKbLGmF3H6SQDLMXKXCqOxKmvvQ+/h7/NAg4Fi1geQ0JHpl4F8tdgBE/6FABEzErMMlkMmqRRPXwrlpLZD53K72pEs4j8v8wdeC8reqYZ0aHg4HYIW4CgxVxUmb0vCjtLcM6np/lpa5UmlfdYz66tv5+P7H/3jK3yJRESI8RiulgsYSaM0K3yOYcVfpuAvmmYVB/x1OBS4gaszzvy5nHHB49aFhhRE1qwkZ+lEAQNQLoocB3rEY3gEtaeIufnnhiSzOfy0to59mZFRUByf+24nnDOpZ3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNqR3H0Vi6uSoCBAkxuzuiD2DcGBLyEtbd3d4r2dcXg=;
 b=WBl1TRoolQk3E8+QYVQ/5axPEH0ZUINLHf+D0DH9lh3LvuZQVmdsmxz+6nQb8Q2Iig3XC4jNMs4rKrUPHt+LI2WSwb5u1fpdsS6aXNCMW+4XlXVR1CNpPCO74jkjXDV7UII4lYfVimM0MGSvCOctgpgQ0+NobO2ZS+WwWZ0Mh1j3r96hH1P6v2S4pBozLUVWyjFKnnfp5gjRGjjc4uQWQkf567dgPqhjD8yU1ZBzymxvleKbs4H4iSQ4p66xN+qd8elRP91X2XETO2CLQ+u8VWmFKO7VB9u+m3qX9XfdGo2cQWgBeneo1wfU9E2FIDXor/sqvbrGpxF7RaGDz/3bbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNqR3H0Vi6uSoCBAkxuzuiD2DcGBLyEtbd3d4r2dcXg=;
 b=jpjdHTH2xP91nlY7+XMC3jzq2gsSNajInZkH6fXKQfzGBguN+GhxQdRfa1Etjw0vSFO14ul0bxzpeYySE5x0JBd/2Qw3pSzPW7FWm9tpbmCXIVLO0I7GnHfyAWWzLCV6PTRxkV5UFELqacZU5zUyfQC67pUJZ96mGdnjuoxpblA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.10; Tue, 12 Jan
 2021 16:36:29 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 16:36:29 +0000
Subject: Re: [PATCH bpf-next] bpf: Clarify return value of probe str helpers
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <20210112123422.2011234-1-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3021932d-01a2-4f59-3fb0-b9f379c85cc4@fb.com>
Date:   Tue, 12 Jan 2021 08:36:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <20210112123422.2011234-1-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:3e3]
X-ClientProxiedBy: MWHPR1701CA0019.namprd17.prod.outlook.com
 (2603:10b6:301:14::29) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::190b] (2620:10d:c090:400::5:3e3) by MWHPR1701CA0019.namprd17.prod.outlook.com (2603:10b6:301:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 12 Jan 2021 16:36:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 870de2f5-3582-461b-ad7f-08d8b718369e
X-MS-TrafficTypeDiagnostic: BYAPR15MB4088:
X-Microsoft-Antispam-PRVS: <BYAPR15MB408836C424E0101905524F96D3AA0@BYAPR15MB4088.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lf3ZpA3N1FJui5ZHOSga7Bq4bwRcHQOHVvJD9kl2Wu/Q6OHk4tuFVmmpcySNKo9Wlt9ul0JCWx2hykf4BQ3fuX/30SRf20S5dsCnSXbl4xzHTl3Asd/GjwvgS8TQRszsyNj1yBvJ68vn8mKK0jXZ8nHGTjgAnyxOKjl7yulRwboyrbhL7ngeX9SsJHbbGUH9q1eLMVd8A1CueoX+2kffP92FamGSO5aUSMF4fYYEzFPTTsvDY0eLhOMDEu3uM7ChzaMz1zOhxH9iUFwWuNIXRcPDtGmXJbrvFMt6sY8XjmWhUmo2HAiOte9dFdhi+iV+aleK7fMw95//3wr/dZS7Soac5qKf+Wwta+cfHqefw7QWxon2cI6PFR1TidkSsNhwctUp+QW/ebQMmTo4L2fNNB2wlRVo68YN1pIBtAjksv62BYXl83sCLhYgN35nNYosc0nrXxdymcdpav5EH2E6EiEUtuJ/hxQldpAVUqtdO+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(39860400002)(346002)(136003)(2906002)(53546011)(2616005)(6486002)(5660300002)(8936002)(31686004)(4744005)(4326008)(66556008)(8676002)(478600001)(186003)(66476007)(316002)(54906003)(36756003)(66946007)(16526019)(86362001)(52116002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?anhIV1hmY3UzRTZ0NWZRcEVZK2UxWGtPNUozZ3lqbkxGVmVNV0NTRW4wbXdq?=
 =?utf-8?B?UXhvQlRoM2t0MDNSbm5xRXJRME5wMHpZTVQvUzFJYW5DUk5ndFhkdlNoanFQ?=
 =?utf-8?B?c1BPU2Flc2dpRlgzZ3VmeG12eXJLdDdOa1FYaFp4bG0vMjc2a3hFQ2tCcDJU?=
 =?utf-8?B?ejZJZVg5a2dQb3AycDNtNldjamdPWWhhTnVwQ1d5VFdZblRCTUVqTkFJZVM3?=
 =?utf-8?B?MDYyQlE1cjE5empJVnowR3FXOWxobWVTWXp3UW1EK1JrMy9UKzlibWYvOFRj?=
 =?utf-8?B?ZVFjbjUveURHcStZRitsZEUzcSt6YWFNVXFvNzAzR211d21Xd0lEMGdENHZZ?=
 =?utf-8?B?QkVmZXFsUlFFc3R2L1hySXRmMHBxRDdrL2dhRytJekE0TTNMelE1djd2dFJp?=
 =?utf-8?B?UTdaeDFYTVh1Rzh1RFdVWWVpNFlWSEdFWDM3cXd3SjFpWTRBdHY4b2R4RjB4?=
 =?utf-8?B?aDNETWJwVkk3RGs5TlppMlo5WnV5R0VtR252Vkd6OXZpTFFoNDdKdzdnNndE?=
 =?utf-8?B?ejdGRWM1Q0xGa2VtcW1HRUU3dWJmeVJqMmtUQndQcnF2bFZKeU5xRkdpTW9s?=
 =?utf-8?B?RkcwQ1BXRlprUmthN3dwcEFSM1ZiOHZuM2Rjc3IyTEUzMmpvR0s0ZTF1UnJ5?=
 =?utf-8?B?SS9QSlI0bVFhRFFCTFFJQmRZR3lHTk1PemQ5Vm5LMk4yK0hna2hwTEhuM1JF?=
 =?utf-8?B?NGZUNWRCclhNSEtPQTVoV0IwVVlGLzAreSt4cDV1RXo2ZUZuR2QraE82RVZw?=
 =?utf-8?B?QXl6SmxBengyTUR1QjJmYnFJai9LSktsS29QZjFVT1F5QjN1ZDZWL3hSVVoy?=
 =?utf-8?B?QnhjOUx0Q2dLaEZZMlNKdEQ4S1FFeW00dzNoQnNiV3RyT3hCdHozbDRkTHB2?=
 =?utf-8?B?OERQZTdadkh5eGh3d3VGaHNWUlR0MWF4RGVBWnl6RER1c0hrMXJaQjNYZTQ3?=
 =?utf-8?B?dDJTOGNLSjN3enZka05oME1YdHl4bThwdUFDTjRSU2xyT1BrUjNOMHVqTVV2?=
 =?utf-8?B?elBjTnE3M2tqRHcxNU5KdktqQ0xoaS90b1Bmc01Lb0p3QXhzemU3ZmVML016?=
 =?utf-8?B?QjBsLzU0T1p3VkJwTEpYWmV2UmwxdVNwL0I0RnFxbTh6UklkeDJwUVVqSTE5?=
 =?utf-8?B?Mmd1ZXhTUkxBV0RDM2JPL1hhSWVOQkxTclBYQ2E5T3haL3Uvdm1Zd1JpMVVk?=
 =?utf-8?B?RVgxeGF6WHFwcGV4dm9DYllXdFFtK0VZVXJXMlhsbGhxK0Y1c0RacFFiTHEy?=
 =?utf-8?B?VU5YYzB4MUpBbzlsTG9rRXNyL2poakhxdzYwQkNkZThETVBTOS9uRDBCV29N?=
 =?utf-8?B?M1NrM1VoWi9hWm9Xd09xNTg5V0hMb2thUEhpRExGNVRoQXJkUklMUUk5TUl0?=
 =?utf-8?B?RDF0QklOenpOTlE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 16:36:29.4952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 870de2f5-3582-461b-ad7f-08d8b718369e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVY9bIL7peJC/cr8YlrQ4Ar0OsnPqY2CE5h6ZdQM1zElzzlCnl2BDIYCa/E07qhN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4088
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_12:2021-01-12,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101120095
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/12/21 4:34 AM, Brendan Jackman wrote:
> When the buffer is too small to contain the input string, these
> helpers return the length of the buffer, not the length of the
> original string. This tries to make the docs totally clear about
> that, since "the length of the [copied ]string" could also refer to
> the length of the input.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
