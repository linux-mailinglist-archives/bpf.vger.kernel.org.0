Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740552D2031
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 02:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgLHBgR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 20:36:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16976 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726901AbgLHBgR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 20:36:17 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0B81UUSR020444;
        Mon, 7 Dec 2020 17:35:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=S0oUOhnm0HXvk5xhbVyieohCCETbtLjPTYFF1329WeM=;
 b=ViMKIC/pR3HMSrF1dQyKQ8h1K4rAU62CJtjlTGVzqw9xgt6VS9GkE5XIpVKr/L3NFkKe
 eSfeLg925nSifJIWb5+sPx4lIHl+OgUeL40anXkm77VH26HkxSW7n0r+zTHglmgPZSK5
 Z1OYPEov18dhLmnUwZGDgNTs4sv0MM7cJoQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3588025qse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 17:35:18 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 17:35:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PICYSep164zRlK/tZmMDIlTupeZzgFdvniP6YTNDmoeI9/475zcIz6O51E7jSt+Hit9IX0G7UZMRJNLCgILJYIaJV5ATw9KGMfTq37pWiPtQWZULbw6SFaD9/wcD4c1sKWvFZwjC/UerUaGGM4UOsmWL+g10h3s53o8gZNmTPpX/g162lyXivLOHgvM03xis0paNEW6keXCamXW/UenjShYGLEQVoIIzHaFyXCkcr+OxreB/CR2II94LnPDAaLQW3oTWg20xI7jpLG/3Hf+CHKyU0+JFbInJ0Rp34oxGoyXBfIgvRh1lkesCMdsLJPnT8ldDAHbD/rEhGemYfWlkWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0oUOhnm0HXvk5xhbVyieohCCETbtLjPTYFF1329WeM=;
 b=SdGGqhb6YOsvX0J8dNKn098PkY93T0u9jF8GQtQmmPh/uS7yoRsURdDbpC3Z2Zv1YIQWQ/VDwlIjnlL0BleMyG1SocPvNLFubG2BTZT+07IFVhxE1nzxi3AfQ7bApYVvuQvkmxSgXY8+NPKBdzD1FJF4HqBucWJH+p2kZidwr7Nq2R1Y1KMTIIrkSXVA2f1Ix9fYoCI0x8fikVmrN5VkIFmlWO3OxAXxRbsiCrUKCuXdbzk7f/17/lprTvRQnipnc5wU/WN4h1FmMBIe7/O32Hoa6aAMSwvfQO/YpBytqbbjFt1vrYhEHrAt7bbbffaIeX8fwTsJxxvfdBXJR5zQ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0oUOhnm0HXvk5xhbVyieohCCETbtLjPTYFF1329WeM=;
 b=S1FGbxCsnLTO706zW8fFUIxlFhdh/U89kE26zwo71U0tzVKw1lRFr9sOk++7BayOK4C58taTOEbjYuPAI1oG8FVcBNVnM7PNbFm6SrgnW7v1XhoVzicdzgDuP8AxJK3m8AHpxhAv9msHE9SgO1LSOWi0Ed1FxMEeNcSLXjIHpaM=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2376.namprd15.prod.outlook.com (2603:10b6:a02:8c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Tue, 8 Dec
 2020 01:35:17 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 01:35:17 +0000
Subject: Re: [PATCH bpf-next v4 05/11] bpf: Move BPF_STX reserved field check
 into BPF_STX verifier code
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201207160734.2345502-1-jackmanb@google.com>
 <20201207160734.2345502-6-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7abd0d8d-d60d-0e13-ef1e-ecaed7ff59e5@fb.com>
Date:   Mon, 7 Dec 2020 17:35:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201207160734.2345502-6-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ee04]
X-ClientProxiedBy: BYAPR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::36) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::113f] (2620:10d:c090:400::5:ee04) by BYAPR02CA0023.namprd02.prod.outlook.com (2603:10b6:a02:ee::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 01:35:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e11267-3655-4e77-4abe-08d89b198479
X-MS-TrafficTypeDiagnostic: BYAPR15MB2376:
X-Microsoft-Antispam-PRVS: <BYAPR15MB23763BF21372F3B459E81AECD3CD0@BYAPR15MB2376.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8QIHXcil/wQxIER07MkAHhzmYotMVc487Ofo1GGqgnki+SZMNoXIshD1OLUjmiXBh7E4pQXrDYLWS91a9JOCbl12iR9YqojcFNSmjAdxpRuk5/yE8paF90UBvD0pvvrd60/75zTAOJwprG3iCT8MDWBOHIElG/PT+PAg8/0gDxp+BykVEqyZEtTY/WVWZh2203oa9QgAaVUcFXeqWC9pqaOYqVGagVSExjQ8FCrtZHuLJnXu0vLJOXzsjb6+XqZvYDaihZDhipKnI3iYnI53KqSdRTDZ2oZYRTr4/WYvziD24x8IR6NNpmx23Sa7x2QMYclyxk7bXMFlp/1n+q7b0eGa9bdsT3uE7exEdmxuKlp3RjzqTlabyFoY7B7HzPemVIF0lk0MPw6nXNNufcYOWq9ngLjLmdOUny5SaMiVQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39860400002)(5660300002)(478600001)(8676002)(4326008)(36756003)(66946007)(558084003)(66556008)(31696002)(8936002)(66476007)(52116002)(54906003)(53546011)(316002)(6486002)(186003)(16526019)(86362001)(31686004)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b0lpYnM3aFZDckx3ajJKYnhLUVhiR3loYUllUm1OWHFOeGhYMU1DVkNkWkp0?=
 =?utf-8?B?WGc4VjFPTDAzd1lwSzUzZE5jd3REdkNwazgzK2NxdENaUmlnMFU0SFF1OG5w?=
 =?utf-8?B?Zk53eFdxdDZnTnMvdFR5dWg0NlY3MUJqcDR0T1ppdjRpNkEvMDlFdERQamZt?=
 =?utf-8?B?aGVYMlowWWtKUEw0bG0xRUk5eGZMSXhicU1CNDR3eHg5ZUwvMHp5K0Yzekps?=
 =?utf-8?B?c0tNRnJZOWRwYjc2bGN3UHFLVEhhOGZtZ0lCRG1sbTRkQURQYVFWcjVhSWhm?=
 =?utf-8?B?WlRMbzdYaW5nUnFrZGNVak1sMlZXVkR0dFdud3MyWVdCVUV6UnptM01tZXBB?=
 =?utf-8?B?K0drOEY3ZVlIQzRpdWRzNkMzYklBZmpkdC8rRFpaQ2huc1pBdXF6dWNpdHhX?=
 =?utf-8?B?ZkhTanFmQy9qUndscVZhaEE1RUI5RTR4THY3QzBrU25JaUVYTnNDMEMxOFcw?=
 =?utf-8?B?VmZGL294aHNaZkxxODhZVG1JQ1A2TWg4ZWxXTDcxaEJ0WVlWVC82OU1mblVr?=
 =?utf-8?B?NUJsSUMyMkYzT2VJMDNtemJvdWpQd3FjSy8zV2xZNnU3NzBTQWFMUmQwOGpz?=
 =?utf-8?B?MnVrZE4rMm5ONkF6cThVaWtwWWpZdFRGRnMrKzNOcWExdW1obllvY1lFaGxh?=
 =?utf-8?B?b1V0SHhDT0E5UTNMKzVTMVpjNSt2eiswL3lxNnh5Sm5WQ0sybXB4bkRUdWRH?=
 =?utf-8?B?Yk5UbEhnOGh4YUpOckswcEpnNlpXbmJEc3R3eG02NHgyMnlQWWcvQm14K3Jh?=
 =?utf-8?B?eXF2cllNMXVrRWtERkZKTFFLTGk3dythQmVpL2poS01xNC8zbnBJSUNZNWE2?=
 =?utf-8?B?cno3YnRSaXJJdE9seU5wbStqK3JLZElWb1pjU3V6Nm9BZ0R4RlhVc2M3YU42?=
 =?utf-8?B?cHEwOXpkQUE0SWx5NVRiWlVYOFozeHdHRWZIYmRTL2RmMmJBNnBpNHBoUEFU?=
 =?utf-8?B?LzR0ZVZ2VEFpZjhkMk9LaDJJbjYzajg4UTlLUGg1Y0p3T1duWUhweklkMWFG?=
 =?utf-8?B?MXZTVGc0aVE4NUY3SlJnK3I0b255K3V6VUZ2cnI0cTh2ckNQVVZHbFpaSlJQ?=
 =?utf-8?B?VEJoMC9UdElXUklReWlrTUVVQmd4U1BKVzJncWpsbjVhNHRCYUdIL3lvS0Z4?=
 =?utf-8?B?Yk9UUklyb1J1ajlxbExjMzdzOVNEYTA4WHRveWJYRHpYS1ZUeUJrYzlpYnJT?=
 =?utf-8?B?YVJiRUFzbjMrOXJqOWl0OWhwR2dDRUVwM004ZGFobEp5TVZ0UG82bVVTR1Vr?=
 =?utf-8?B?QUFSZE9wUk9Ja1RLNGl2dlMyWEJYTS9PRkNTWjZhR0ZWY09kNGF2VkkwaldR?=
 =?utf-8?B?VjNqR2FNdFJTbURIRzZKQW1VTHpJQ2NuU0p3ZG9Qb3FrbVVTTHVrb0IrZXZw?=
 =?utf-8?B?OHBuV1UyUzFyZ1E9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 01:35:17.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e11267-3655-4e77-4abe-08d89b198479
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBGdLKQRs/s+lyRylVviYEYTM3mh/MifEJi9x4LyuD6qE2RAqA+DThPkUtGukenO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2376
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_19:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/7/20 8:07 AM, Brendan Jackman wrote:
> I can't find a reason why this code is in resolve_pseudo_ldimm64;
> since I'll be modifying it in a subsequent commit, tidy it up.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
