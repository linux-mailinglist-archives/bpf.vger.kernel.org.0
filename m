Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0E4298CC
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 23:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhJKV1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Oct 2021 17:27:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1152 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230114AbhJKV1O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Oct 2021 17:27:14 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BI6EDq019105;
        Mon, 11 Oct 2021 14:24:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7kEPh3VDSUbwXQu3QuUfqjrYNqsuATFeW7QHbRJbOV0=;
 b=FmXFVjHrIO6cwhEQGc+AbkmB91L1OWT9oi39BYnXMzT462MXZxXwCTvvKUe4xvOiUdD8
 yP82xRSPP66xn6r4pIXmPDl9vdB9MnD1y/f+jmr5jOT1/DcYUHc88Dn/fpiJaCZ4ljnX
 tZpYNP5O/UYTi/CgS/V+IXilcRMVvbCmetI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bmk334hgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 Oct 2021 14:24:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 11 Oct 2021 14:24:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmpbOgqwx+BUtGyhl5RD7/44GIvvJXdFPIi3PO/amsAlp3ieM44AWcMcp8VQ/P2vw2dYdnPZ7N5CIa7ANbXg5xljw5bnUQI4YcNwczOlkBit4YEPQ75CQJmfRLyE6Dv2ibNufHbyg2AAhjjy3tQljs+sy6BFuVTe1xvBJozdn5Cscqgy45MO9H7gnjTDAbMSVE5tEQs/v1TBBCZDEApDkqyMJk3YgLnN5eGppmoE/me81ya3r6coqvTMrl8jTvn6NvK13+whP/rdKj5UHo0YMAy6bdU/x5SQAsxP++Wzvq6eH1HkYE4bb9PmzOyWdkpZHq2V66ChDtcrfWzpx1SFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kEPh3VDSUbwXQu3QuUfqjrYNqsuATFeW7QHbRJbOV0=;
 b=oCarLUFPy0lV8M8ct3cwlgQFsQUVgMApruxEkJYH8OmJiz8QhgtR2v0JbBRPjfwwOJhMKn90Cj4qciYzWap4kLF3FtYpTqduVjJO8akWD/s4m3hbSrRULOK8h+jek6AZljTLY50HISTg6s4OvN9fQSo9HYbwYnSWK6kJTAZwW40wPDh/7oBp8P6rmgjcYTk0WuBLUMk9zmAcdy6Jwz7O6fZWarIb2umgaQIuU9RJJaqPNPBadz9yXewtNBGp7Ogb5tkJKXS5Z0b3TheXpg+UfflV3TQp7kozLFOiSkyGYjolWusuHnFdpSJ+V+d9HLPQZXAn52sPkmJ3iwU9m73+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MWHPR15MB1135.namprd15.prod.outlook.com (2603:10b6:320:23::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Mon, 11 Oct
 2021 21:24:56 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::7d63:ef35:f43e:d7c2]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::7d63:ef35:f43e:d7c2%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 21:24:56 +0000
Subject: Re: [PATCH bpf-next 09/10] libbpf: simplify look up by name of
 internal maps
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Stanislav Fomichev <sdf@google.com>
References: <20211008000309.43274-1-andrii@kernel.org>
 <20211008000309.43274-10-andrii@kernel.org> <87pmsfl8z0.fsf@toke.dk>
 <CAEf4Bzb+z365WCbfPYw5xqhTAqoaAo6y+-Lt-iXGAGeeaLHMOw@mail.gmail.com>
 <87r1cvjioa.fsf@toke.dk>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <91b10579-61fc-3bc7-8349-0ff3228905ae@fb.com>
Date:   Mon, 11 Oct 2021 14:24:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <87r1cvjioa.fsf@toke.dk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:303:8c::35) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1945] (2620:10d:c090:400::5:7e70) by MW4PR03CA0150.namprd03.prod.outlook.com (2603:10b6:303:8c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 21:24:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f96b943-3fab-46f5-75ad-08d98cfd9282
X-MS-TrafficTypeDiagnostic: MWHPR15MB1135:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB11359BF1D52B803E0EB767AAD7B59@MWHPR15MB1135.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DueoTM1JNRia/XcEXwkYLSmDLLgLJMPPyQTqTZmpTmIsLQhdHpEAKXx4TjMOsAfo5371ZhS8DQhDrJBWd3lqFwFtSZqo81hPuiKSRqaTc3k2dvzVQSrpu9GfefUcDT9o+zTko3yPfSRRNuKB8/30x7SVro1ai51l/hd/zubZFtWVV7WQJ4X0nBkjjdF7ZqsVS9ViVihc5XobEu8kciWGsE1RZ5605Dw1ChyHRv44E6YoNimx9CvJMV1GWJ4jJf5kUTDu1U59cTzDKduGF/W1VbGEOTKB1tUS4bqYwIR+VhlNsKo23gviq/hRnLosPCriCnKLXDGG9HUG9wnhVU86NNuGUtpVitpgzyJPv9TQ4OMfOAmq0W9mDWefnXaH6MntUj+VzrOvVVUpmwzx0qh85Fplwi3ypAOYYzeDaNMVu8J/CSB18Ffqt+GoGJ9sI5Xi9UHcdjqDNRwjsT5tlS7mXJtQPB1J4Qd6+Qn3BtIfqbeorxpKGEVDIHGBLV2TVNVijFnkc7b1mm6Cm2NVZgavsU3iDXRpjBXCzOwtdPbgTXiAQ2F43IJx4Cx0wROD4CK6wX+gDRN0e8vje+I/Axx+3P4Bou8sRqXYI6MF9uLbvduuUSI0YWXpK6RUnMoOt8l3H3TLldEGhP6u/y2cwj8+lI6DImI+OdZfJ2GkGq6yR7kyRes9ta1alVmyW+fbG/dYSQtxRPE7CSf0xz7phGgKCWa6QPOuOYsZQHlBncjG+ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(53546011)(31686004)(31696002)(2616005)(4326008)(66476007)(66946007)(38100700002)(8936002)(186003)(8676002)(86362001)(6666004)(36756003)(52116002)(508600001)(54906003)(110136005)(6486002)(4744005)(316002)(2906002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K012VzFraGpacGJYZDhaaDlIbUpwWm9ZRFVsWG9GZ1EwQ3pMOFVWeU9WVWZT?=
 =?utf-8?B?UEtBK05tU01FVlF4RjAyMUZNY3RhbDRmUDkvaFBna2hCSElKRE82RnFUL1Fn?=
 =?utf-8?B?eGozeHp4dm5ESG15SzFTL0ZEUERmUDVxVW0yNTlUSE0xYmwwd2JqR01LMS9M?=
 =?utf-8?B?dlJQNkdyYVBsY2pzTUF5anZJQk1jR0pCOUxYQmREZmh1VW56VTY0dGtBNjZk?=
 =?utf-8?B?SkRHYnJUZ1J6cWdKOHJyaElOVFEzZ3BMcGcyQjhJUXdFNFBHK1BFcVMremJI?=
 =?utf-8?B?Um9VdVZhMGx2eFJ4Ris5a20zaWNjSlRMOE8yQk5FNG9ta2o4b1pHendTTTVp?=
 =?utf-8?B?NnRCcW9pNERaNmF5ZjFPVWI2VXRmLytBQTZ1QThxVm5DeGFzcUtDdjk4Z2FY?=
 =?utf-8?B?VlVhK2lRK20xK01ldkYwLys5N0hLQ1Jic0FFNHh1SDJWLzUrRlFGL1J4ZHM4?=
 =?utf-8?B?a2hybTJXTlNBdTY0Q0RJUUFJeDBzL0xseG44empSWDF3d0ZsMEVlcW5qeVEz?=
 =?utf-8?B?czBNemZlQ0FYRDBmVEJDWTNvRWhPNlBwYnpLTjI2Wmd6QUprS1ZwZzV5OEFZ?=
 =?utf-8?B?VzU3eVgwWTN6U3JxaW5vRFA0MkFFRW1KbDlwQnkvb1I2Y3BYYmE1RG04RXNw?=
 =?utf-8?B?cXhWK3hJRTlIdS9YT3Fub0xwVzJtM09LVStvaE1mNGV0a2ZNeXVYL0hyT2Vh?=
 =?utf-8?B?cE5WWGhXNXE4anJYaHFLTU9XcE5VV0JjRG5GWktIRGduc0xmZFZIbUhkWW04?=
 =?utf-8?B?ZVpGeUR1U2M4RnZQWFZPc2lHNlNiZVFiYTZNVHhua2E5N3JUVXRkQjhOUHhW?=
 =?utf-8?B?TG9tL0l4aExQd2ZHYWZDMk9Sa0krTktSdmRhMzlEejA1ZFk5N21RODEydVl0?=
 =?utf-8?B?SjNaSUkrdmo5RU5hWEtCSFBRTkNUeUtEdTV0cXdpc2xYMnBxZElja3BjWjRk?=
 =?utf-8?B?aTRPYkxKQ0VJaE5TTThNRGxRTUs4b3lPOStLcmJyMU4zVWhnK1ljR00wUFBG?=
 =?utf-8?B?Mi9kUys4Mkt0ZWNKMzQ1bUwxSUo5RmMvYlBsSlNwU1U0djNpVXM1Uk16Y2li?=
 =?utf-8?B?T1ExUXFFV1JhTUxTUU5wZGF2TEVYVWpHZzhHSHdDOXNZZEhnOCtxMnhhL3U0?=
 =?utf-8?B?OTdSMlZqRGV4Q0lDSmluamRaL0VtemxMU3JtVUF1SXROMENRbU1NYjJUbVZN?=
 =?utf-8?B?Rmd0TitDVUZKZm01bUJIZ3QzWm5RRWtQa01UVk1yK1ZkYXExOERkeTZYRVN6?=
 =?utf-8?B?UVpnV3BWbVhkb3JIZ2ZFbHIxSW5YTnl1M2laalR4UUdGQlhYbmYvOUtGb3ZS?=
 =?utf-8?B?d1hBNGRiTWExeWdMTEVCVDNLdkR6d05vREhDNmV2WURIdVRYdGNWSDN1cWUy?=
 =?utf-8?B?WUJzWGlwS2hXQUdUcVhEd0dHOGZubTQwd2xYSTMwQlg4dmM5bnN6dUlYOU9s?=
 =?utf-8?B?REs0MVVEa3VDVWJnalhBb2hJK1hRa2QxcENrR3hrTk9abWFQK2xWWjJybTJK?=
 =?utf-8?B?d2Z3YUR6c3M0K2hBUlpLUnJNamtXMi9xakxVcE4yTkFZM1lrcEJCZ2M5T0tG?=
 =?utf-8?B?Q2szemhzMWNKbm8vNFFseSsvZTNUVER3aWdGd2tMdEJTd2FmZDR2SGVsTlVt?=
 =?utf-8?B?QXgvTWpzV2laQmgzTGcwb1Y4RDZYUTBjdGVXN3dsSkNDSnltVXZBSzZXNTJL?=
 =?utf-8?B?WklZUHVyTFB0MnhYaXRkRHhmMkZFQVFob1JDd296ZGRlaVpGUS9YNjZmREVh?=
 =?utf-8?B?czNSbi9vaWxjdENZWCtZY21XRHNGcFE0Q2VSTWx0Rk5CbkhiK2N4QVk1VDB5?=
 =?utf-8?B?dHRHL202bEpHcUVNWUtSZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f96b943-3fab-46f5-75ad-08d98cfd9282
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 21:24:56.3816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgRcyEZKhc/psrOksiVcrria4nZIh2YiehxMBMgRUSE37NmEES3LJPhclpjSDsw4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1135
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: xaFts8F3KRxMzLUOjYdeaP8V0zY0Ezzy
X-Proofpoint-GUID: xaFts8F3KRxMzLUOjYdeaP8V0zY0Ezzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-11_11,2021-10-11_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=968 spamscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110110121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/8/21 2:44 PM, Toke Høiland-Jørgensen wrote:
> 
> Hmm, so introduce a new 'map_name_long' field, and on query the kernel
> will fill in the old map_name with a truncated version, and put the full
> name in the new field? Yeah, I guess that would work too!

Let's start storing full map names in BTF instead.
Like we do already for progs.
Some tools already fetch full prog names this way.
