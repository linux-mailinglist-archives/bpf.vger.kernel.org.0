Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2008C40998F
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbhIMQmT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 12:42:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47700 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237242AbhIMQmT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 12:42:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFtQS0022320;
        Mon, 13 Sep 2021 16:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=8ZLXCdS6gIZ0XAxclA5aUpHaR6kKiVMpvt5V9+fHBeI=;
 b=ceasT8XSzYBNjnk/6BXzqWUTOMqGnaJEAydcNq67WiU+bFURk1RsUy5kbKrAAyhA88R+
 Ky49gmnoze/SmVgf5UrDTZczE1OPcyO6MGuoLgYOsYWpB2Ha24jA4g9jRVz8Swu0BMZp
 RAEBT3n74n4YWDsjgQJb+nu/2aOKyuLF2On+1rjzVfrQ8jbzVo7rHi3rvpiay3bgbvtW
 nqQ+bt/eu7amQLeB58G+uyVJt7zys+XD4zUHTfxhs+jOZFHb1/MEis3dXN2C+zYdW0H3
 njGkdZQlfwtdKtBA2SPEqv+1ncbMqkSHT9MlzKBjso4H6HhxFFe2sdwhPAYNfhTFvchj 4g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=8ZLXCdS6gIZ0XAxclA5aUpHaR6kKiVMpvt5V9+fHBeI=;
 b=q4Hg834BuabrhizZfmNNevPYJ1jDnSW242ExzYMNeEzMkpY09OtjHs3fK3LzBW3TKnmL
 Tjud8qnMVHEdDapX6W3LmWfTZIbDFDt5nWWEraMJc+4OGLeGuRwc9Iw/XP7XKYrfMhC+
 iB0gSEFiJxNItcH2EkdAzKD1F0RSBSG4jSmiiXiyNFHpZ/Ivh6FQy/0fJk0ERecy3v+u
 mj0K0v3k+S2pI3y1bhz37DiMKYturcDTVAlKwasVShAqwoqmJnhZeamZcNgBylzM6Ihq
 OZ3YzrfEmFAZto44kXNIAZ6Q/NkcdJZAZ4Y7+/1vBfUWbQr0tViimsTnLvYWyh9c5TJM KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b1h45kfvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 16:40:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18DGeMSG076471;
        Mon, 13 Sep 2021 16:40:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by aserp3020.oracle.com with ESMTP id 3b0m94y59r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 16:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfX4rD/mHiJ9EUIf96ND4dkTFh1yGC8f0QQt3KiCj3XeQbBaV1BU6SHTaili9uJzgRoF0LlXByI6LCrPiJIsQsFQJENm6RzrRN8C5lzQaMjJroyeSp738tqy8KYt+YusLJGeXzp+NM9tZbcVfh9NBRroAPIZWghMuXxfk+8SfzQkMAkrx3YQD4LKGzYYBT/vSzuG/16uOUDAA7oP8jk6/fuvRnM56LRLFQgexEh2IJeUPoHPZvVI3uioKETpRhIYV+5XvriAOVYDa8aL1WVAbjDql9r+DgZiDdFt37GXozx73b2RHmSEIrKSHsrwVQlfWyKgjKtgBnXisOaECVRZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8ZLXCdS6gIZ0XAxclA5aUpHaR6kKiVMpvt5V9+fHBeI=;
 b=Z+nzziqXXAvSKbC2MPRgSCf6EqNcXYWdzrQkViaVIOXYkxMQqEuHfZrPFHIYjAN1heU0tHYbfweqUeFr9Uvr7z8gsOA7/qlHaaoDBI5vq5qBFcAetf8v0ZVtNqM9XMeBI5tJUaYa2niKDCZHC+Ozjtar1bqnU5I7bQQcU98YsmqIX89n81Dh36Zx+dcNoz+TLXVVFQ5AGSgX/WrqeAB193R+jgfLKaDmPhEJBjYZLkVL6iPv0OBjHYZlO9p5zZxXKIi9mmaMuQIeo3dllKUctlWKK571b4uAurL26AVAPrvldHd+7Np5cxMvV4wTDA5OoQ8xLxxaPM9y4vns6cQYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZLXCdS6gIZ0XAxclA5aUpHaR6kKiVMpvt5V9+fHBeI=;
 b=WpnOMAs2sZxbxzKAx9E8hndLWVe9ZN9ovTppsWJ2Hw4tX67UCc+Oghfq2PE8mWA87/AXgkLy0p39O9zrJye3DiCZMkxK2YIh8RSK0y4DOv+CYpWszb5m32yamGWYh2x0hBquEwHQ0l7i8en07xSXjmo1SQpRvhlydajvhcwaC2Y=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BYAPR10MB3704.namprd10.prod.outlook.com (2603:10b6:a03:123::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 16:40:15 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::f89b:d57b:829b:84ca]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::f89b:d57b:829b:84ca%7]) with mapi id 15.20.4500.017; Mon, 13 Sep 2021
 16:40:15 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
References: <20210913155122.3722704-1-yhs@fb.com>
        <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com>
Date:   Mon, 13 Sep 2021 18:40:06 +0200
In-Reply-To: <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com> (Yonghong Song's
        message of "Mon, 13 Sep 2021 09:08:57 -0700")
Message-ID: <87sfy82zvd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::11) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
Received: from termi.oracle.com (141.143.193.71) by LO2P123CA0096.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:139::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Mon, 13 Sep 2021 16:40:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e025a47a-9e63-4b1f-492a-08d976d529a2
X-MS-TrafficTypeDiagnostic: BYAPR10MB3704:
X-Microsoft-Antispam-PRVS: <BYAPR10MB370418C003D6BA0A0DBD60A594D99@BYAPR10MB3704.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OkOhTScT5djWEbi9+eWweUhpWCDLkafo4yXvNG+wojopMwBSHjUaWs+Z0d6Bk0V0zpPAZ+zfMCpm2aqgktJu26zby++gnVp3VNIikbaH120rGGQNWicrzk53FX3DoCaVOFMnfLzADzdi0DXugvyUjYwvD8Br77lneBYnP5aWTue3OP9l92HKbapbU7TUYuiZ/TcBxSrH+E7X+nMeJmjeIarv7ORpkSxwlM6nqygEaesfVEAI4mteQptNR+FMMOtlM5yq8iaWiyb89JPOYIFmlpsiKHAi3LgF/DCfDY8xtoJFsrK/MfdIyju28gaiRGcQCxAokPKhSK8aChi3SRz7jSdkX/NSjoqMpsisBMytm/0r+pfDH4C66FVUcr/u3bQlncE8CmGx7jcnaGGt65t5AyOi6yXQwvR5rSDvHetcDQZqC4ZlaCgtt3BD40xATfnsfZ5a25vDoH2ESqA28gPxo//Lo+YI3BXpKGenYqut4D/WkjonQ/eH6q4IBKi5aWDGzS9vJU0v/esNSrjhE0wXpRuHrq3OkzAS0nuhTKaAtKnGEygAAN6tUOken4eP0zQ9HPVHWy0idDtercf80BOnDAQvATIDq5qaHO65bQUCVmWFzLfHRfnlqSrgg72rwAe3vNNor+qaEAAQAD1OKpsTxgYGO9OipAvHfqulgRhHWD+xo312Js2El1hUX2mbxFMbbPIGOYaKZlW4qy15htlymb2X+l4AmlNVlLQOJqOcJ62WfbwPK15AW5bW7yhReiYp7PkVhsyNh+/7d6LDiwhs/7zLstFie23VHAdwusOVZLkLtGsUuQdh1WW78BNJMcP3oysgzvQa2iyZkBOsk7qQlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(396003)(136003)(316002)(36756003)(86362001)(2906002)(66946007)(83380400001)(7696005)(66476007)(54906003)(8676002)(8936002)(5660300002)(38350700002)(6486002)(2616005)(966005)(956004)(186003)(52116002)(26005)(66556008)(4326008)(478600001)(53546011)(6666004)(6916009)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1kcU4O72BH+fhuhRuPRI+Kt2uTULYoZ9jRDXu3F4fFQnNN944ZnO52ztY93a?=
 =?us-ascii?Q?nFfGGtFhWlZsOFFfotazw57o221BqKdS9QJkyxnVFu4zlG4J9CjcUemPj6m6?=
 =?us-ascii?Q?avE+pcXkh1R4BsCE1nMt35kCHSUxBw5BHdOOURxUBtofXToU2Edbaur9k01D?=
 =?us-ascii?Q?sGTB18aqJxlNXJ8HtnULcEFScM1gDqLRwSQSmDbPQFwFl+M0jJ6fAax70I0R?=
 =?us-ascii?Q?ligWR5u6ZomYadGO7nnfOjyGhU26164044noEXAxJLyxX4hoZMQDfrhMrEnJ?=
 =?us-ascii?Q?+WXxggrO5WKlGSIOar3wyJfaCf05/DRUOhiY+kfgl8aanTVgWWINjH+olJc6?=
 =?us-ascii?Q?fb+IqzxuaFGpc66wIfGqqwGTccttUqF1dIvyUk0LNipSgTJilbDfHf4e0A2h?=
 =?us-ascii?Q?KeBIm8N0mjQk+41FN+pj9KphrhSxqONLz6Z3KxCchoRqGtuyM84PZnf68DQh?=
 =?us-ascii?Q?5y5w+StKJuXoO/cfiimiccAcq4WenVdpAYQATa69EUUnH9+hmzxw7zOpU3B9?=
 =?us-ascii?Q?9yRtsVPpAfamkT6awcWHoCv1fD7dYdJglZ2du/+NWaod4DPRVvxEporMRjao?=
 =?us-ascii?Q?DhWouGqjyu0Og0gcYUJWqQAE7pGuVgFmtHXR+F1nOleA4zJGddu4ma038u7n?=
 =?us-ascii?Q?ehiSZgNUk3lygAozD+kOaeSmgzRQ3gUNcSuc7V4XDie1FFWp1Wwfx1DHjNcI?=
 =?us-ascii?Q?wKrqyBe5xBCCFSxAPwaBhDUBvTTnOkiyAmBQj+VElhFztis0LS9dUlD/9yBQ?=
 =?us-ascii?Q?Kd6LFmaOa0t7jkUnCqlhFyTxIVvdzKZf+efgZS+fHjdol/BBZ7ldwiH5y3Nt?=
 =?us-ascii?Q?UlAiY1PpYDt/NjXl4HcWREWiBsIlTuL5+IK1/h3Aay0uf5HF6lsqFhq/hw7Q?=
 =?us-ascii?Q?onHkgtLNODBwp2WaEIcGHS2NHCfgHG4Y06aeULgdI7ND3hiA9Y0E41SJ2CTM?=
 =?us-ascii?Q?4Gb1niNieQdVWWwFTC0dw0kEqzpeicUQrgPaEFRZ7273JFrJc8MX2sK765aQ?=
 =?us-ascii?Q?1JkllCq1fhJqSAdhz5O7ZCq7ulHggANFpYE1U41C2lUYBwqSyJdV3hfA5jdh?=
 =?us-ascii?Q?IqmfNhOKzDO7/z2Umuvy9X2NWzhPm9BDoLJmsrfHX9EOyjpkgiRdV0VlN5WJ?=
 =?us-ascii?Q?UFVKr0kmPY+UN3EX/oxtKCk31sSsJMCH3QViiWEPskl3STzipwtVNpr9Q/se?=
 =?us-ascii?Q?zwJ/CLGRPgHP23V8bXzb4TpgsLBYT1xjJRrS9uWXfNxoqNhKEH7m5YxziCbl?=
 =?us-ascii?Q?jhrfRCOAgMm8izIVDAITVsrgSL0zsQ3sM3PKM7uKJnnBV/UJ9VUG/4ikYHVM?=
 =?us-ascii?Q?Djt8c0l04744Un0jEJ4c/nXE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e025a47a-9e63-4b1f-492a-08d976d529a2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 16:40:15.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VG8SJmXtxBG1Q5x4R8N4pYxVG4qRzr7rsQZ0mGgpV++cPcYMsrfNewHD2Mao1lF060X0JOnUOwXJHynxFJf7cVkpPLLKoAhVAGuf7CckDn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3704
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109130108
X-Proofpoint-ORIG-GUID: A9vCYK5QHXX1dGQmgfBIaldw1sJMF2-u
X-Proofpoint-GUID: A9vCYK5QHXX1dGQmgfBIaldw1sJMF2-u
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> cc Jose E. Marchesi
>
> Hi, Jose, just let you know that the BTF format for BTF_KIND_TAG is
> changed since v1 as the new format can simplify kernel/libbpf
> implementation. Thanks!

Noted.  Thanks for the update.

>
> On 9/13/21 8:51 AM, Yonghong Song wrote:
>> LLVM14 added support for a new C attribute ([1])
>>    __attribute__((btf_tag("arbitrary_str")))
>> This attribute will be emitted to dwarf ([2]) and pahole
>> will convert it to BTF. Or for bpf target, this
>> attribute will be emitted to BTF directly ([3], [4]).
>> The attribute is intended to provide additional
>> information for
>>    - struct/union type or struct/union member
>>    - static/global variables
>>    - static/global function or function parameter.
>> This new attribute can be used to add attributes
>> to kernel codes, e.g., pre- or post- conditions,
>> allow/deny info, or any other info in which only
>> the kernel is interested. Such attributes will
>> be processed by clang frontend and emitted to
>> dwarf, converting to BTF by pahole. Ultimiately
>> the verifier can use these information for
>> verification purpose.
>> The new attribute can also be used for bpf
>> programs, e.g., tagging with __user attributes
>> for function parameters, specifying global
>> function preconditions, etc. Such information
>> may help verifier to detect user program
>> bugs.
>> After this series, pahole dwarf->btf converter
>> will be enhanced to support new llvm tag
>> for btf_tag attribute. With pahole support,
>> we will then try to add a few real use case,
>> e.g., __user/__rcu tagging, allow/deny list,
>> some kernel function precondition, etc,
>> in the kernel.
>> In the rest of the series, Patches 1-2 had
>> kernel support. Patches 3-4 added
>> libbpf support. Patch 5 added bpftool
>> support. Patches 6-10 added various selftests.
>> Patch 11 added documentation for the new kind.
>>    [1] https://reviews.llvm.org/D106614
>>    [2] https://reviews.llvm.org/D106621
>>    [3] https://reviews.llvm.org/D106622
>>    [4] https://reviews.llvm.org/D109560
>> Changelog:
>>    v1 -> v2:
>>      - BTF ELF format changed in llvm ([4] above),
>>        so cross-board change to use the new format.
>>      - Clarified in commit message that BTF_KIND_TAG
>>        is not emitted by bpftool btf dump format c.
>>      - Fix various comments from Andrii.
>> Yonghong Song (11):
>>    btf: change BTF_KIND_* macros to enums
>>    bpf: support for new btf kind BTF_KIND_TAG
>>    libbpf: rename btf_{hash,equal}_int to btf_{hash,equal}_int_tag
>>    libbpf: add support for BTF_KIND_TAG
>>    bpftool: add support for BTF_KIND_TAG
>>    selftests/bpf: test libbpf API function btf__add_tag()
>>    selftests/bpf: change NAME_NTH/IS_NAME_NTH for BTF_KIND_TAG format
>>    selftests/bpf: add BTF_KIND_TAG unit tests
>>    selftests/bpf: test BTF_KIND_TAG for deduplication
>>    selftests/bpf: add a test with a bpf program with btf_tag attributes
>>    docs/bpf: add documentation for BTF_KIND_TAG
>>   Documentation/bpf/btf.rst                     |  27 +-
>>   include/uapi/linux/btf.h                      |  52 +--
>>   kernel/bpf/btf.c                              | 120 +++++++
>>   tools/bpf/bpftool/btf.c                       |  12 +
>>   tools/include/uapi/linux/btf.h                |  52 +--
>>   tools/lib/bpf/btf.c                           |  85 ++++-
>>   tools/lib/bpf/btf.h                           |  15 +
>>   tools/lib/bpf/btf_dump.c                      |   3 +
>>   tools/lib/bpf/libbpf.c                        |  31 +-
>>   tools/lib/bpf/libbpf.map                      |   5 +
>>   tools/lib/bpf/libbpf_internal.h               |   2 +
>>   tools/testing/selftests/bpf/btf_helpers.c     |   7 +-
>>   tools/testing/selftests/bpf/prog_tests/btf.c  | 318 ++++++++++++++++--
>>   .../selftests/bpf/prog_tests/btf_tag.c        |  14 +
>>   .../selftests/bpf/prog_tests/btf_write.c      |  21 ++
>>   tools/testing/selftests/bpf/progs/tag.c       |  39 +++
>>   tools/testing/selftests/bpf/test_btf.h        |   3 +
>>   17 files changed, 736 insertions(+), 70 deletions(-)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_tag.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/tag.c
>> 
