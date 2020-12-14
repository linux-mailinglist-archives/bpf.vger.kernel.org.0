Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466392D935B
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 07:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgLNGsC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 01:48:02 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34048 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbgLNGsC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 14 Dec 2020 01:48:02 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BE6coaC009117;
        Sun, 13 Dec 2020 22:47:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DU6Gs+cNdrm8tQSIhZyDr588NunMy3uQmrMaT4QHkzo=;
 b=CIuslgVJ/891vyQySRadC/O+lfnqGHA9QqE8xrdvg8pf6L6FXjuVcLMPNGPgK2MX/0gR
 KhAo1nPt5YNsmwXcOMqO3HmTOTOMiAgmaNgZYoyTcauDItrkM6W5Lk0WftCzlDy84qpS
 dDwS9Fkgn66/amNc/CGuGBcehb3nt1usJ+0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35cvjpxas3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 13 Dec 2020 22:47:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 13 Dec 2020 22:47:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwZZCoTCApp/rJSxpZnpvMrhKFmCzN/wV6TvJzO4ZCFB1vnYNXKKpUiFPXJ6ws041RhlD8MZj2m6sqdlfDjbR/P+ZNzposKc0DdFerJxHPkLb/0T2D8tX38Wt7Yb/qYNmMDRQ3GNccP+ATvO84pBZ/ANzP0AfgD8fk6ktSnSBwbOYqLN0fkCAMM+GKajo+q4XLLPEyxfjH9PkMa17ikQ3hjJKPPoBrT2Q8E6AyvNgnCp6xB7sktJmMzjeaDyuB4j3VKQUWXCNk1hfGNfVmi+R+cHzswxNfCQQsqAEX+PCgJU6ionyvTuHVJ1sjJH2Y4jipyDn8751YfTctr0FXm/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU6Gs+cNdrm8tQSIhZyDr588NunMy3uQmrMaT4QHkzo=;
 b=KiB/+zOX6jhZbXnkkUCQ5cUrnDlLy5jfVV/+u7iDfnZAtgFyXT/8FhpjYMuuT1mSbKKH49tfftTN/UnbY7rqlXLWiDWvVDNwL9edD5m8ghZ8QuDdp6yRN+4viT4V8/3eEl/1Gda24N5bLDgneaMQ/8hSbXFnzg4Z98FQXJMHLUcpJBl/QBiohM9ZEP6AzqFMgIH9CWZ+cbVfUHFjDjEIvZJX3AU+3MOlV0UwuDHpKcIBU/KqDozEpcRJuRFOk42fRjpofOsLHWyPN5SNZ0JUDDqz7TkPbIJlWopMHWlkdcZwsllFf1JIW7jaC50KSlpQLwGPPghKnQHR2gsEmY8Agg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU6Gs+cNdrm8tQSIhZyDr588NunMy3uQmrMaT4QHkzo=;
 b=SX43xq09eY524Y92+7qmfR5eUDO0FkErJ8vL4/S++ERSFJyzm0JRJeOLsAauLEK/AcBi1JqdDq3itNSx5U/qc+HnUCbck8y7j61nue5NPB7SKjfrT+BJ6oMnG7HiFP8X9o7ZtXMAOHTyXf3b1py/aRlK4C5bHjFBM7NRZ1hnFGc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3512.namprd15.prod.outlook.com (2603:10b6:a03:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.19; Mon, 14 Dec
 2020 06:47:03 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 06:47:03 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Florent Revest <revest@chromium.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20201126165748.1748417-1-revest@google.com>
 <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
 <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
 <CAEf4BzYz9Yf9abPBtP+swCuqvvhL0cbbbF1x-3stg9mp=a6+-A@mail.gmail.com>
 <194b5a6e6e30574a035a3e3baa98d7fde7f91f1c.camel@chromium.org>
 <CAADnVQK6GjmL19zQykYbh=THM9ktQUzfnwF_FfhUKimCxDnnkQ@mail.gmail.com>
 <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <221fb873-80fc-5407-965e-b075c964fa13@fb.com>
Date:   Sun, 13 Dec 2020 22:47:01 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <CABRcYm+zjC-WH2gxtfEX5S6mZj-5_ByAzVd5zi3aRmQv-asYqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:c9f6]
X-ClientProxiedBy: BYAPR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:a03:80::17) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::112b] (2620:10d:c090:400::5:c9f6) by BYAPR11CA0040.namprd11.prod.outlook.com (2603:10b6:a03:80::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Mon, 14 Dec 2020 06:47:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f2040e7-a62c-4f04-3bc0-08d89ffc1085
X-MS-TrafficTypeDiagnostic: BYAPR15MB3512:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3512F4AD44BC46297A8BF25FD3C70@BYAPR15MB3512.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pukNU/YTFFkBxzeVcvHCb3Cp6saw0zOPoeAgTZZxgtLMI88vZRc8HgVulUl0jly0EAOWHrdI4ouosndJDS6p63akTr1kynY+5NDmQFv2WweRiE4pLbsTV2Ump/RCfLSkhJm0VtQyhoFG8JDfLLZjtd7RydgLAh2XqtxEGqgchmyBIq7uUIo9Y/GvCIJ+GM7ZUl3LiGeApr+4GM71e/rYk4t/JPsgtDS5MXPGNrg8DfIKORR81pR9XsZYAR5sF4XWzQqgISAmosHn0Spt62SGlTNrv9yJ2BIsyjAgMclh2yjMuuKUOR5vt8fQLIckM9gdacNhzmesjuwZSoYlravyaIwOOUWxaGHXBKYoGnrObDdJbV5/ftrhNGlJF0dOywbeYExBHX9B1PshF0nycS6P6NfKlXAfumQI8XPgq51TE/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(110136005)(16526019)(53546011)(31686004)(36756003)(52116002)(186003)(54906003)(83380400001)(2616005)(6486002)(7416002)(2906002)(5660300002)(31696002)(8936002)(8676002)(508600001)(4326008)(66946007)(86362001)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkRreDI2VDRGUHZGOWl3T1ZWakRTYW1kZTBuWGt5MkRDQ1hEVHN0dTg1SVdi?=
 =?utf-8?B?U2R6cUZKb0dLT3p5TWExeHprME53bFNnMktBZzEwMXhKWEhUQTJtNEI4QXdl?=
 =?utf-8?B?K0lPbU5Nd2tMSjBiTEJMN0Y3ZmRPbnp1Wis5VEJGQkQreERUUnZNeDY0cXN0?=
 =?utf-8?B?QW5IMldMZ2twVlprOERvREYxUmdhRXBQblhwalVDMExScTJXNkJQL2pGT3No?=
 =?utf-8?B?aTNBeHoxSG1CbnZJTlc4ai9WM2lrcEN0YmwwR2FoRWk4bkp1elNnZTBKNys0?=
 =?utf-8?B?TGRFbWh6cTZkMUt1TGs5SHFUaTRlYnc2V21JL0dpZG1jbnMrQ283K0VtQ2M5?=
 =?utf-8?B?SENjbUNEWmllZENZc0Q4aWdRb056WEtHRFdWSldLOW1jZHhWc3FKYkpKeUhi?=
 =?utf-8?B?YXFLb1NOYkM3bGFXY1VGZXpkSUJ4R1l5NWVpQ21Xd2pjaDFTMk44RFoxQWUw?=
 =?utf-8?B?MlFZeGt2dVRPbmp4N3hrdklBYlVEYWthVjNHbnJUaDd6R05LT1JWbHloZUNk?=
 =?utf-8?B?N1FiekJpcGVUZFYxZ1l3bVhXdCtEMytFRlRGZXczSTh0NUQxbjFmM3lWRi9z?=
 =?utf-8?B?QUtvbWRCbFBuVDIzd1lZY212L21uSjN6TEh6NExaOGdNWXdJRnpsNDFlUmVu?=
 =?utf-8?B?dW9TOFlqRTZkbC9HM3hJMTJNM3N1b3AwdHhwT0wrb2dtVzlnK0xLRndiYnhi?=
 =?utf-8?B?T0JEVlR4dVRLQ1VYNHoxNU1QaEpZWVhkQWlSelRiVUwvcHRUVzN3QkkxeGNS?=
 =?utf-8?B?emhMOGVsd0c5bUUzRjBDWmxqakFiMDBEc2RHbmhxbjFkN2dGS1dGakc3Tlox?=
 =?utf-8?B?Ykt6emR2S09Mb2IrUG90MFhoRVlRcVhIMXN0elhOQmg3eThGUkU4N0ppRG9k?=
 =?utf-8?B?TXZYTkVvTmxvQ3FoZmY4UTNFUXpGbjAxRUhmMXA5cGJ4NkQzWk9NZHlTS3Ny?=
 =?utf-8?B?VWlrc3FBZlQ4RzYzQ3Vmc2FjTkFlL0ttNS9HTE1tK3UxdFpyNWh3UW1kUnhN?=
 =?utf-8?B?ZEZwNGNFNW5IendlbTlWdnBGclBOcDJ5SFFTN01KbTNNcm0zSmowZnFwaURw?=
 =?utf-8?B?dHFiZkp3bmV6SFY0dGxoRGZpUlY1aEFlRldyUUhsaXh0REowTy9kQk9MV2lB?=
 =?utf-8?B?UUQzRWxqS1lpLzJpQTRMdDBBUFNNVTZVV2FWa2M3eGxNV21Td3hWZERGY2lj?=
 =?utf-8?B?RCtENmFRUDdLeXhQMDBsU2Y5Qm9Ocmh5aE44U1BiTW5kdHlRN3lmdXROclM0?=
 =?utf-8?B?Uy8ycFA0TnRCTmpCVHlOM09XcGwyRGZsY2J5M0hQLzR3U2JnV05KbzRCVmFk?=
 =?utf-8?B?elVPYS9LdVBZVFJXUXJUZnNZZnBEUEZhZ2tQQjg2T1hQRjcreHptcVh2TGk4?=
 =?utf-8?B?NzZ6U0RRTTdTeUE9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 06:47:02.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2040e7-a62c-4f04-3bc0-08d89ffc1085
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/4Y0H7lAA63ri7Sw1q07DzwvlublILvKpUN+YsiTEHmBB/8Djy6dzYJTApx5+1B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3512
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_03:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140050
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/11/20 6:40 AM, Florent Revest wrote:
> On Wed, Dec 2, 2020 at 10:18 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> I still think that adopting printk/vsnprintf for this instead of
>> reinventing the wheel
>> is more flexible and easier to maintain long term.
>> Almost the same layout can be done with vsnprintf
>> with exception of \0 char.
>> More meaningful names, etc.
>> See Documentation/core-api/printk-formats.rst
> 
> I agree this would be nice. I finally got a bit of time to experiment
> with this and I noticed a few things:
> 
> First of all, because helpers only have 5 arguments, if we use two for
> the output buffer and its size and two for the format string and its
> size, we are only left with one argument for a modifier. This is still
> enough for our usecase (where we'd only use "%ps" for example) but it
> does not strictly-speaking allow for the same layout that Andrii
> proposed.

See helper bpf_seq_printf. It packs all arguments for format string and
puts them into an array. bpf_seq_printf will unpack them as it parsed
through the format string. So it should be doable to have more than
"%ps" in format string.

> 
>> If we force fmt to come from readonly map then bpf_trace_printk()-like
>> run-time check of fmt string can be moved into load time check
>> and performance won't suffer.
> 
> Regarding this bit, I have the impression that this would not be
> possible, but maybe I'm missing something ? :)
> 
> The iteration that bpf_trace_printk does over the format string
> argument is not only used for validation. It is also used to remember
> what extra operations need to be done based on the modifier types. For
> example, it remembers whether an arg should be interpreted as 32bits or
> 64bits. In the case of string printing, it also remembers whether it is
> a kernel-space or user-space pointer so that bpf_trace_copy_string can
> be called with the right arg. If we were to run the iteration over the format
> string in the verifier, how would you recommend that we
> "remember" the modifier type until the helper gets called ?
> 
