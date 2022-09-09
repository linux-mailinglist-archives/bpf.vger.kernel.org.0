Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147E75B3FAB
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiIITb7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 15:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIITb4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 15:31:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CCDC57B7;
        Fri,  9 Sep 2022 12:31:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289JSdDp004365;
        Fri, 9 Sep 2022 19:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=apR9Lf2lJKsgkxoivPP9FzbVLkjIrdwLR/AMJl1yfGQ=;
 b=yHcpxWGNAmQ6iNdxnVn3aoabPD17N1kS94CIWssybxigXU8dXYdlREaki4Bdfj+caaR/
 998E5X+9/8WcCGqoZi9nm467IcIuIqVvfdBsHEBmsISVuqOHUgWwQnprXaohRMGDB7Uj
 Z5F4rU5RM20TgJIUr6B2k215usxckzzLlZZHWdq2vEvsIv1d+eEoLB6Deo6+hfCY1Q87
 rsFrNBIwmPVzuNUS+L92IKbt28H6A+VVVBIN3vQzPev0eThOVxfZNrkECIlcAd/Vrn3Q
 VpJ0Pdjs+6BrCMKo6gk+/KKA15brCPoU/uW9OEG06VOCxiynrcPfqwAscKcG7PI+4mRt yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2rbsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 19:31:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289J4e2U036079;
        Fri, 9 Sep 2022 19:31:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc8u5hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 19:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b35ye+OzfpTuiUA+A8Qoe/VxfAKn8bB652NmaeEUMxffEeq3XKSC8unrLRGdZrJXRalhS66vBT4CFRqETiv7pEHjja3Yfv2gCCjOgi0PhZQqYfYzBcbc8yqjFcKhQZI4ooZL+y+aGHZCJK3OkSQRa8bCGntEUJ7Ul8JDAUA0PUJVwPG1WydwafczVswg6i+VBq6HlU3gg5Sy6rNHCvRT0bM/ypOA/BP39P8TjEcTsz6NlTaWLM7Y/8xrTeD2uME5jOOPkOl3pRXpeUEp0jCEWS4uZ8nv48IG2tGu4KHxRRg/nKzcUG7RpygOVy9b31kjpd4iaec2sGRff1i44Tc8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apR9Lf2lJKsgkxoivPP9FzbVLkjIrdwLR/AMJl1yfGQ=;
 b=F8m7Po83sclfT/vo1wl1aUlqDEdse3R4XCak1yajCz/GqdtBTgoPq9YmDRK+Hzzt22T/3VYMRG4mipQ4UegLT/51DSrxwlAGWZnAzb3UcV85Zvu0q1Aivi15Ghhx0NwcYtc6ocNt4TKjE4v1w4yTxNG67tMh+owJ5cIEgNJOTgE3Ntosm2eEpyvsJkJJHlT2SwnWnN5yDWZKSpSyi/aetGyjsSulFQBz4Vmwcy8TnYKL7Cv6U8uy5mU916T3Qvzbgzm8Qdj5Ppi0xtwY+wfOP4RboVlx4hZE3wMQTJaEA9VgYJfVmVINvaFo9VhLubJ88GUVHO6DkC6PvvzPUnMgYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apR9Lf2lJKsgkxoivPP9FzbVLkjIrdwLR/AMJl1yfGQ=;
 b=oakFQ+lbg8psaRo6t/3VkDfHW4lM5sOjRyZQOh9RiWo1czuGLTytk+Lo9uO3n/2l61BWsjjXm8o1RNH5LEFzrVrfdbL3Z+zJC2a0+d1CjIRdyJ+Jg1rN3+o3a9okxAatVaTW1PTR005oxm3AyFPWpggNVwZ4SqBl5F5aOJ1K63Y=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by MN0PR10MB5958.namprd10.prod.outlook.com (2603:10b6:208:3ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 9 Sep
 2022 19:31:27 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%6]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 19:31:27 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves 0/7] Add support for generating BTF for all
 variables
In-Reply-To: <CAADnVQJCQdL4j1FFdSE=K6mUaoVGJkcVK-xzgJ_5MSvb2tEkFw@mail.gmail.com>
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
 <CAADnVQKbK__y8GOD4LqaX0aCgT+rtC5aw54-02mSZj1-U6_mgw@mail.gmail.com>
 <87sfl3j966.fsf@oracle.com>
 <CAADnVQKbf5nEBnuSLmfZ_kGLmUzeD5htc1ezbJsVg72adF4bLw@mail.gmail.com>
 <87v8pylukf.fsf@oracle.com>
 <CAADnVQJCQdL4j1FFdSE=K6mUaoVGJkcVK-xzgJ_5MSvb2tEkFw@mail.gmail.com>
Date:   Fri, 09 Sep 2022 12:31:24 -0700
Message-ID: <87sfl0l4z7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|MN0PR10MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: f4944bf6-2135-487e-1f27-08da9299e377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ky0LPzfDXH9CFYiBclDuiE+PG9Lb0u5qjhwUdHfB4lg+tL6A6j9MklVyBAp8dDrPIO8wUkAiQbF6GI50GGnTWL8OqoGA9hhMwGXKO33IYpvXOec7vPrjsh15JRmJNJ3AwMG9Bh4UCd/efS7hoh1vCVlfA+2mD8wMZiajfQBc2ZuGnn7tzQ/brwhAEnT8BDQCKAnw5lfoaJw6Vpqi9cBhFRVVUBWN0DZJ1l+st0DcB/R8EU5LC6GQ23FdXFW/kLjToGIj8XwgQAYW8xPBuRjk1dpDDs2c/LchQxCEFZQvtg+BaK1If8XWl8AfmEVu19pgvDyR387Mb9MaTr1akZiczH9EpTTDUGpP45pgHk/juDpO0KSq77/snnbhZi0N0jRYMDHYd6X0HD33xsHfaibRMAjfKHFZwsIVYVXv0/XCo9lE3dlO3MlQxKCjIEE0QoxYbpZjApYvrw19iLJ8pkWqGbm1tG4dvxeK3f0Z7srCUAHI/ZNOl90mmlQ9YG53C6hKu3jq9I6rerqR3f+ve7aFqpxw8lxaG2nHg+m0KlgkehUsCiblyBh3K66qEJg4IzRkrjJcCUmGq8IL3nVO2B8Rnhg0JQBTVnar5VAuHL2KAmUzo1hvxmHlQyQ1dw/fWHIIXb9OMszwCMfeUByxGQPht6oXVN7wKUrn6oObcw6A/k1AE359O+KI63SHaZqS+JdE6lJlG1l0agSWkidPttFmDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(396003)(376002)(136003)(346002)(6916009)(4326008)(41300700001)(66476007)(2906002)(8676002)(5660300002)(36756003)(8936002)(86362001)(6512007)(54906003)(66946007)(26005)(6486002)(316002)(6506007)(478600001)(66556008)(2616005)(107886003)(83380400001)(38100700002)(186003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rYtDlvJl2+A1Shh+AlOLCdooLWkmDnbmEDuFsYxDECf2Cw0ZmZLjsfwpmBGk?=
 =?us-ascii?Q?6gSkcKhiqYnX9z6faQxZR6i7v7CjlBDoKN5rYv4iBMCJTuB08HKv9Ey6xTSC?=
 =?us-ascii?Q?5IwOq2E9fLY2ku0kqPQdrWudWW5e83kwBJm0Lq/rv4Yhf0+aV2hWlhbIr2+Z?=
 =?us-ascii?Q?J3J6YStT4HgDAgSpzSvBUFV93c6DAqOWczleq2bLKlfsMVJlk7ANx9/UcRhE?=
 =?us-ascii?Q?P43UQKQ7dZIDEbuM2/QKowS1vrozm5YmDbQba0Zutw0P7Ya2yT6VAI36DA5z?=
 =?us-ascii?Q?dHtOmtmcOoZ2aA8LAHvQvout0KkVK5eVSFF+pnEGpd/+mGjQlkLt6yPCy7WN?=
 =?us-ascii?Q?YTAdE1XLcTpp/Fgw5sJNojP+DwqV5z/86POAfQECFSWLXqiBSjQUGbD0eaoF?=
 =?us-ascii?Q?VdOLcmpAtzsNIGdf1ZmshNH4DLClGEYBxBtl7GnIh/OirhkJdPTz8DgRsjgt?=
 =?us-ascii?Q?+5uLSXt5fX6mPaHUoKSa9BBKsSkUbQp11ykIgTHQnpw/sYxeS3ryCNHkeeqA?=
 =?us-ascii?Q?tdkuP4m2/nBsm3GMV3f9swLL9KecXiT6xnnY/IYdIKKXCALnGsVWLiE+ghvy?=
 =?us-ascii?Q?TX47Gf2gpASy3fA9dEypsSlRmcu7r7ZTWSIe/WCcArfL+j0DFbOaH9/K6YlG?=
 =?us-ascii?Q?i1rAL4das7PtG6KrwnSFlQeJ6JM+E0i9byeMg18jnrl6Hiy4I+CmsmcrfUSh?=
 =?us-ascii?Q?cjsY4BbUoS0OR1YN54ffa9xOQ+h4lLx0lqTAECX6ufsVrR91NGNLTO1MWv5E?=
 =?us-ascii?Q?VlHuJHCmKN5XwtQeuF/mJymWcH9SDBNvHn21qs5P2wS3QYqEqbJqsGzgNu9t?=
 =?us-ascii?Q?8LJPakavBZLH0UP0zoih1cJSXJI/eBSFJoOlWXnUBdtTc6riPTdVt3qBhzrK?=
 =?us-ascii?Q?Y0aNUeueT2tii+IVgnoHh6Z1CmjlJOvV+jemVuzrQmxPwz9F1Yb0sUDG6p8T?=
 =?us-ascii?Q?HZMRFcg8DZ/UESE7IgXzBFCK1xaJqrgTrkNkkTkROZoavCGGteM3NA6agXVZ?=
 =?us-ascii?Q?rNSzUAxD7cu0JrxkdTySj/83lIlI6stCA9IMvPw2SVJ2UgwmcXLXxFoZOb02?=
 =?us-ascii?Q?7Mw/tYpQJm6I6eDh9lS74Y8Ps8Qj2iCTtTwGXbI+6v7reD3RbrrQhydzi94g?=
 =?us-ascii?Q?B/1i0TtGS7Jiit5suOUNsJIH5PdNNcxOVAH0SJv1B+OU5p+RsYn5OtSR5cOI?=
 =?us-ascii?Q?Gf2RnfnEVPuvy9y+snjeI8S9ACOF5TKOAEPgFFfxQY5Ij9ezMgy4xYrxgKiz?=
 =?us-ascii?Q?FFxsldBUrrylmK43fJcNcMF/U5edFkX7tbBGStnbOM9jQgWtV1QBibpCGOT2?=
 =?us-ascii?Q?iCHzieFMT2NDN5qU9m6zVGj/E3VRvKuFnV0a1aBUcKb3v9SzJ33Faao+zd0h?=
 =?us-ascii?Q?N/TBjIU0DRyefinJXAXzHQIHG+IgKWIJpICBxuBPEStdSyBdwVKA5WUjAHfg?=
 =?us-ascii?Q?I6zRb5iY4mlSC8vDtX6ircI5kwgtj0cusxWOfD37CW/5mj6tm2tgh1pI7aQ4?=
 =?us-ascii?Q?nLFOLLsPueF0WjhXacSLHM0m5zGe0YR97XaOrxYTkpSaOunqC1r5soOnqX+F?=
 =?us-ascii?Q?0diDcclyWysS/sLRcsrjlQgxvUpOMEspQ/iJlWJiMoG5iTeYZhxphHPMLFev?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4944bf6-2135-487e-1f27-08da9299e377
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 19:31:27.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A/YPY+8swzyTB1iTEbs6dM76M6NmRKLGYWLAjP6YKqNaw6NZtBwreqkFpd9ILsk72VplsOjAC/jcna9lC6dwPSd4yk3qGhotxhqp7s5FZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209090069
X-Proofpoint-GUID: NLrTwG-yxO3oAWm1wAWITOCTEyPqZ5EE
X-Proofpoint-ORIG-GUID: NLrTwG-yxO3oAWm1wAWITOCTEyPqZ5EE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>> (a) While we save space on vmlinux BTF, each module will have a bit of
>>     extra data for variable types. On my laptop (5.15 based) I have 9.8
>>     MB of BTF, and if you deduct vmlinux, you're still left with 4.7 MB.
>>     If we assume the same overhead of 23.7%, that would be 1.1 MB of
>>     extra module BTF for my particular use case.
>>
>>     $ ls -l /sys/kernel/btf | awk '{sum += $5} END {print(sum)}'
>>     9876871
>>     $ ls -l /sys/kernel/btf/vmlinux
>>     -r--r--r-- 1 root root 5174406 Sep  7 14:20 /sys/kernel/btf/vmlinux
>>
>> (b) It's possible for "vmlinux-btf-extras" and "$MODULE" to contain
>>     duplicate type definitions, wasting additional space. However, as
>>     far as I understand it, this was already a possibility, e.g.
>>     $MODULE1 and $MODULE2 could already contain duplicate types. So I
>>     think this downside is no more.
>
> Both concerns are valid, but I'm a bit puzzled with (a).
> At least in the networking drivers the number of global vars is very small.
> I expected other drivers to be similar.
> So having "functions and all vars" in ko-s should not add
> that much overhead.
>
> Maybe you're seeing this overhead because pahole is adding
> all declared vars and not only the vars that are actually present?
> That would explain the discrepancy.
> (b) with a bunch of duplicates is a sign that something is off as well.

Sorry, I didn't actually have an analysis for module BTF, I was just
extrapolating the result I had seen for vmlinux. I went ahead and did a
proper test, generating BTF for a distribution kernel from Oracle Linux
(kernel-uek-5.15.0-1.43.4.1.el9uek.x86_64) - something that I easily had
on hand and could regenerate the BTF for quickly.

Basically, the steps were:

    pahole -J vmlinux --btf_encode_detached=vmlinux.btf
    pahole -J vmlinux --btf_encode_detached=vmlinux.btf.all \
           --encode_all_btf_vars

    # For each module
    pahole -J $MODULE --btf_encode_detached=$MODULE.btf \
           --btf_base=vmlinux.btf
    pahole -J $MODULE --btf_encode_detached=$MODULE.btf.all \
           --btf_base=vmlinux.btf --encode_all_btf_vars

    # what if we based the module BTF on the "vmlinux.btf.all" instead?
    pahole -J $MODULE --btf_encode_detached=$MODULE.btf.all.all \
           --btf_base=vmlinux.btf.all --encode_all_btf_vars

And then using ls/awk to sum up the bytes of each BTF file. Results are:

vmlinux:

-rw-r-----. 1 opc opc 4904193 Sep  9 18:58 vmlinux.btf
-rw-r-----. 1 opc opc 6534684 Sep  9 18:58 vmlinux.btf.all

In this case there's a 33% increase in BTF size.

modules:

$ ls -l *.btf | awk '{sum += $5} END {print(sum)}'
43979532
$ ls -l *.btf.all | awk '{sum += $5} END {print(sum)}'
44757792
$ ls -l *.btf.all.all | awk '{sum += $5} END {print(sum)}'
44696639

So the "*.btf.all.all" modules were just an experiment to see if the
extra data inside "vmlinux.btf.all" could reduce some duplication in
module BTF. The answer was yes, but not enough to make up for the
increase in the vmlinux BTF size.

The "*.btf.all" modules are the ones we would actually expect to use in
Option #1, where we have a vmlinux-btf-extras and the rest of the
modules include their globals in their BTF sections directly, and are
based off of the vmlinux BTF. This test shows on average, that the
module BTF size would grow by 1.6% with Option #1. Of course the exact
memory size that accounts for will vary by workload, depending on how
many modules are loaded. But I'd imagine, assuming you have around 5MB
of module BTF *actually loaded*, then the overhead would be around 85k
bytes.  I don't know about how you feel, but I think that sounds
acceptable, it's just 22 pages at 4k size :)

Let me know how it sounds to you.

Thanks,
Stephen

>>
>>
>> Option #2
>> ---------
>>
>> * The vmlinux-btf-extra module is still added as in Option #1.
>>
>> * Further, each module would have its own "$MODULE-btf-extra" module to
>>   add in extra BTF. These would be built with a --btf_base=$MODULE.ko
>>   and of course that BTF is based on vmlinux, so we would have:
>>
>>   vmlinux_btf              [ functions and percpu vars only ]
>>   |- vmlinux-btf-extras    [ all other vars for vmlinux ]
>>   |- $MODULE               [ functions and percpu vars only ]
>>      |- $MODULE-btf-extra  [ all  other vars for $MODULE ]
>>
>> This is much more complex, pahole must be extended to support a
>> hierarchy of --btf_base files. The kernel itself may not need to
>> understand multi-level BTF since there's no requirement that it actually
>> understand $MODULE-btf-extra, so long as it exposes it via
>> /sys/kernel/btf/$MODULE-btf-extra. I'd also like to see some sort of
>> mechanism to allow an administrator to say "please always load
>> $MODULE-btf-extras alongside $MODULE", but I think that would be a
>> userspace problem.
>>
>> This resolves issue (a) from option #1, of course at implementation
>> cost.
>>
>> Regardless of Option #1 or #2, I'd propose that we implement this as a
>> tristate, similar to what Alan proposed [2]. When set to "m" we use the
>> solutions described above, and when set to "y", we don't bother with it,
>> instead using --encode_all_btf_vars for all generation.
>>
>> If we go with Option #1, no changes to this series should be necessary.
>> If we go with Option #2, I'll need to extend pahole to support at least
>> two BTF base files. Please let me know your thoughts.
>
> Completely agree that two level btf-extra needs quite a bit more work.
> Before we proceed with option 2 let's figure out
> the reason for extra space in option 1.
