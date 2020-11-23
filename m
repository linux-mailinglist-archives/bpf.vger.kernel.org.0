Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE59C2C137A
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 20:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgKWSib (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 13:38:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728745AbgKWSia (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Nov 2020 13:38:30 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0ANIURWp014786;
        Mon, 23 Nov 2020 10:36:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zlF0/34bsHrIYubYU46aoKgRM/VEdwtpByyxzKXafQ4=;
 b=mqvC9VAz5OARkZnG0u0fCheDLVtcyjriCli38jHRqtdwlorPC00sEjiQb/9befNmgyTG
 mPopKmVyqGq33Gjp7Di3AFgoHzJhxpclGkuMciqmMteLf2RiIhjHQO+DBaPifG1yvqPP
 GurNDG37Usg0F/ikxAFsSQIZf2+50ouzb4M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34ykstnue0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Nov 2020 10:36:10 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 23 Nov 2020 10:36:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgZ/h3Ol4zmhiLvxqThZCSY/rHwqFWoY753ZghJsXFUuIanSE3LLOsrjZWWHdzfz4fLIrF7Z6QTTzo/uhU0F6XNsInoLHIZoDx+qRgJMVa4kv9aTZOayMCCmkBeqhNOeej5q/EaFA6dvvAIlwfZUSCpURRQ1jRTRFjq+gK2JgXNlcvFxTFuIAE40VtTEHtVd95JNnqOj20Eh1Rc7N8XK7fM1ysmNHdBMd4cbcZMVOcM2XqPpeKRXu8zA7yECnIMTnn4am6gNVlrMy3h43ha49qsxsvookkdYRw/erxn46axYu+3pP51KPJFZ0pmw6xs/eCopFS4RgklBEo+jB3A1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlF0/34bsHrIYubYU46aoKgRM/VEdwtpByyxzKXafQ4=;
 b=l5ro8zSp9boNPj7vhTBagbD7yDohDIwO94NDhdU2mJjRn/N8pI71Ag1xNF+ZFiwblUX9tFujA30Gdh0DAM36kE35QAYvwx6J4MBedtAgFISbvhB5tes2TB/9kxXKutiN/UAh0H5pj6AV93IiJYlYp0mXG38CwDzHVGr7zXmO1IEKmF3giTsLyJbqyfLOcLAXsRH0DDnyUTILurssO1/l805uRlpPvZgmYFjXzM8OvWa2CLxfQIb1oBR+NcbGvMs7YVH1X30sGWD4cH+71+TmMbfXHjAiSqLruzoZsKix+8WexrBY2Ha7pvbFxyYYRpBaY9fnZ4QsJmCpzg3v2WmzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlF0/34bsHrIYubYU46aoKgRM/VEdwtpByyxzKXafQ4=;
 b=OP4/d6HsobftcUb6I2Sik+CusiDFAIFOcA1vq9Hip6HuSAMKzXoUFW18Xrjm08HEj7zxL/xuF9bt6U9HzzcrbvwClAwdK1acpXMIfaQKNm8dVZhID5qr7sJ1wbmMhdPXVTJfTHecjl94DxQ4McyOV8GixhZ+1me58twMRM3U9AQ=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3668.namprd15.prod.outlook.com (2603:10b6:a03:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 18:36:08 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Mon, 23 Nov 2020
 18:36:08 +0000
Subject: Re: [PATCH bpf-next v2 3/3] bpf: Update LSM selftests for
 bpf_ima_inode_hash
To:     KP Singh <kpsingh@chromium.org>, Mimi Zohar <zohar@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Petr Vorel <pvorel@suse.cz>
References: <20201121005054.3467947-1-kpsingh@chromium.org>
 <20201121005054.3467947-3-kpsingh@chromium.org>
 <05776c185bdc61a8d210107e5937c31e2e47b936.camel@linux.ibm.com>
 <CACYkzJ4VkwRV5WKe8WZjXgd1C1erXr_NtZhgKJL3ckTmS1M5VA@mail.gmail.com>
 <0f54c1636b390689031ac48e32b238a83777e09c.camel@linux.ibm.com>
 <CACYkzJ6VEKBJnJZ+CBvpF6C=Kft5A2O5f=Uu4rTMtUiRKN5S-g@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <cf0d94ca-b6a0-1a1a-6cf2-a641002588bf@fb.com>
Date:   Mon, 23 Nov 2020 10:36:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <CACYkzJ6VEKBJnJZ+CBvpF6C=Kft5A2O5f=Uu4rTMtUiRKN5S-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:fc96]
X-ClientProxiedBy: MWHPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:300:4b::23) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1039] (2620:10d:c090:400::5:fc96) by MWHPR02CA0013.namprd02.prod.outlook.com (2603:10b6:300:4b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 18:36:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3fd0e0b-15ba-47e4-f697-08d88fdea4be
X-MS-TrafficTypeDiagnostic: BY5PR15MB3668:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3668C77197AF865200C57BB3D3FC0@BY5PR15MB3668.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cJq/9jngIYCyiNSV6Y0gdTwsoIk4u436v/lJABRrK/sqpkmK2y8Vh+WuvSyhFSTpXBkRauKsbHXv6AtMRIVZFWuiGmewhJO8JB5iQ025bEFKA2qT2Cra67n3a80C2KHSUN0eVv7RO502zggOfO05fUiYcfufdhId5ubSbXxMCRJMZvb6TdLWzCZyHw8We90zEslSumXPwUTs2yYu5xWg/Q9bafuLDEmk/IPSm1KoZxo3UNXcihFzd10PzV16ez8ejjBFch4WmdrZQYEEzF/hPvQs9WHpmuHpVkNWYiW2UHOi+HkH0ggafkitaIjnlfgLEVCwxmp78r8geQ19cmrRyeI52qWfot1lCi76YtQu8v4XAHvnZQ7Tk7evqmzGdvDz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(376002)(39860400002)(366004)(8676002)(7416002)(66556008)(31696002)(52116002)(4326008)(36756003)(66946007)(5660300002)(66476007)(86362001)(31686004)(478600001)(2906002)(15650500001)(316002)(6486002)(110136005)(2616005)(54906003)(16526019)(186003)(8936002)(83380400001)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rjg/txJOGk5PrzEIAjDZoEqIPqJhwPjDJdKEn27/QtRubiZgfmy8EM3IYzgrBpB8V6Tj2Qg2NBZLt2eeaBQaksdgdEPpqWVj/ERfRd4t7/WoErmucZdrDdYZgiMb7uyKNJSx9OMB0N3ii9bkgQduz06Jot6hftjF7SYgwQbrtE0XVgu1o4w0sa/lhWtAFBAhnQzoqCvx2uzlFNT73s3WBibACVNKf48BV4Ps4IVm+E7LsvPgFaepYXfSrTwo0Kj47mLKHzriEiyBJcPm5E0qQtBiMp74wPbFZxs4+rfRY8PTRGy3cFpXvimBZSHjVUddZE69xvZpNdILRwU3kkXl1pJ7N7s0KQZzue/AP7uZfqBDA0+fNndUMQKIQ1iw/mTLxnW1XVcVAQL8T3e0ltjR2T6Wu2AMronHeYTF64pY1PUDTHAaRNH2UuujlkabquCVnBpR7f468qTN9CXOx4+C9xu+DFTL1N7fgHhD43kgAzHAcSWLZtWAX+Rv6WVbQxxEMDEPDLYCkHTmmFTTjF1gptP67Ms+puuzPBqZ3uQg3atyf4jsot9B+6WALbC6S8T9hPjf0uZjTQMddYsVIVYR28QW2Lcdc3lO6kKCZ9mDYFcWNfNp09zZQQYr674gyXiu7FvZMnjiBVI8MHmx6SVTXYOWbkrFhTAk2268zN3753Sfu8CnLWaPLh434/LwV1YuHs9BPYOnoknRsd2tntBidaEcEtR2vDj4stb9QZAyantQjt8/c3csvorM+lhx2M1Ba3aanDr0AhamPy+86ZYWUOzG+ObsXmIrpbzT1C6/Us/EBXy1w+/EdHMB0AIt0TfLHUUGp2ChIdVrEJdihM2vZ3nx9zakh+H8/owBE2bNdSPRSTa4t+rnhOxUS7ZfYH7X7e6r3pH3dtvLPpZzA3evwc6wQA4y5FZ5KFV7TVhF9o0=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fd0e0b-15ba-47e4-f697-08d88fdea4be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 18:36:08.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eb7M/4E27AgICGaSfFN2tGHOno488ePZDdUI6AscS6euQCu6h1syLQ0HYvgtjG/n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3668
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_17:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011230122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/20 10:27 AM, KP Singh wrote:
> [...]
> 
>>>>
>>>> Even if a custom policy has been loaded, potentially additional
>>>> measurements unrelated to this test would be included the measurement
>>>> list.  One way of limiting a rule to a specific test is by loopback
>>>> mounting a file system and defining a policy rule based on the loopback
>>>> mount unique uuid.
>>>
>>> Thanks Mimi!
>>>
>>> I wonder if we simply limit this to policy to /tmp and run an executable
>>> from /tmp (like test_local_storage.c does).
>>>
>>> The only side effect would be of extra hashes being calculated on
>>> binaries run from /tmp which is not too bad I guess?
>>
>> The builtin measurement policy (ima_policy=tcb") explicitly defines a
>> rule to not measure /tmp files.  Measuring /tmp results in a lot of
>> measurements.
>>
>> {.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
>>
>>>
>>> We could do the loop mount too, but I am guessing the most clean way
>>> would be to shell out to mount from the test? Are there some other examples
>>> of IMA we could look at?
>>
>> LTP loopback mounts a filesystem, since /tmp is not being measured with
>> the builtin "tcb" policy.  Defining new policy rules should be limited
>> to the loopback mount.  This would pave the way for defining IMA-
>> appraisal signature verification policy rules, without impacting the
>> running system.
> 
> +Andrii
> 
> Do you think we can split the IMA test out,
> have a little shell script that does the loopback mount, gets the
> FS UUID, updates the IMA policy and then runs a C program?
> 
> This would also allow "test_progs" to be independent of CONFIG_IMA.
> 
> I am guessing the structure would be something similar
> to test_xdp_redirect.sh

Look at sk_assign test.

sk_assign.c:    if (CHECK_FAIL(system("ip link set dev lo up")))
sk_assign.c:    if (CHECK_FAIL(system("ip route add local default dev lo")))
sk_assign.c:    if (CHECK_FAIL(system("ip -6 route add local default dev 
lo")))
sk_assign.c:    if (CHECK_FAIL(system("tc qdisc add dev lo clsact")))
sk_assign.c:    if (CHECK(system(tc_cmd), "BPF load failed;"

You can use "system" to invoke some bash commands to simulate a script
in the tests.

> 
> - KP
> 
>>
>> Mimi
>>
