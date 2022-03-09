Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982EB4D3D7E
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 00:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiCIXV6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 18:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiCIXV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 18:21:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBE25D5FB
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 15:20:57 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229KcnfY002644;
        Wed, 9 Mar 2022 23:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=PyztG36SyFmIi3VsuIwI5OVVR9+YMKPcG2o3+ABzzZQ=;
 b=zlPHEs79LmQT6BaQzh5tYLQZK6R+0sZT0tvqQ8zE/+EhUK91hbklloQ+8hlfUpUnwSzL
 pc5XFsL6wUe/5XkRhr46jpjgjYGTPCyVaSafd5129dtV2uXtgk+477ZEQh7C1usC+VkE
 Hxy4xbsedPZ5eto0MJnUD7XFTh4fAsZ3EEZNe9mei6oISUwQ6qRvXrDKsRigOTrQZtPc
 azqvAaKei+x9W/OPNDQwpQOqUNMbsUxarbO+Cfhhyg2pmNLujU2d+z14r9Q0mHwsGcPP
 cs0LZOWMzUTiw8wgr4ZOREsclYa575sk+bQmvtoRlSDQ0imFuHtK4nqydnSRFjFIfS/X 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9ckf0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 23:20:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229NFHva178128;
        Wed, 9 Mar 2022 23:20:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3ekyp37py0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 23:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9JeSAg1aYkNY5dle6Ico6D70aVl1VVjPxj6TvDKZYyjVOzYGbM5hmW+Hu5gpHcYPd64NLamdu++akZkCjkj4z9xjq/ojXa8BaTwzsvwlObKuHbbooSF4EUAbg1OU1jPuZ5sH4KfOza3jCmic0M+zxi31rk4bFNy42PM3smOggQjFaQC7Fz4g1NfiLETyyUe9Ttja+HsiEYCUcSd2kJzx+2yIx6I95akzjoC+TKo3DSuOfhEpwky5TlSm8Eb4oQKLRbI4TRI/q9rdNFHz6mS9Xo+b528vfJ1U5AK8RCq4YBgjggw0C+CHjznDt3oY22AUY/VorE2y/dh+tFgznWTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyztG36SyFmIi3VsuIwI5OVVR9+YMKPcG2o3+ABzzZQ=;
 b=VLigXVwlMqyk9pqcAa1AF08Bc9kNYNzmIC57NkKj6S6CspNbr9C+1I3m7Z1NO1OjKdceOSd8Nj51u3b35V6RRX1iyk7EJIiQ7Wl4HSl3Nohe44wD+leOXlwSInlm2kzWb3BoonTlJL7pN1TLlHfFLYF9GK68f+26I9SKoXN7/ZGhTD8NIoGZye+g6q8DJKJgLgAF5JuzZ/sMXx5yW+27MzSjvGPw2eeP37b8uTSGwlyfOYVJU3dLsnHkn8/nPE1saBxpDNzgZG3V6KboMZGC8pENxU81Hl5QfOjWJ7MljWHkCSm/1ngiulaHj1jt1hh4U5juewAYULy7xJjk706THg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyztG36SyFmIi3VsuIwI5OVVR9+YMKPcG2o3+ABzzZQ=;
 b=et2MogzepJsqtxmQH8Fs5QJeEj0lnBtCqvmjxyZ/IAtf7ZTEleAWpyim24BtPIww1xsm7WkA7NLk3Uf8DEWHDWD/r58l/iPj2n+pH6bJNkbt3wpXE6/MXrBQDt3ief0VUo96e8gWYwJX+SDYv8lEb+ulyUtTbXIfVfzD0wmSXcI=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM5PR1001MB2074.namprd10.prod.outlook.com (2603:10b6:4:33::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Wed, 9 Mar
 2022 23:20:49 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::6075:ab9b:a917:ecc7]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::6075:ab9b:a917:ecc7%3]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 23:20:49 +0000
Message-ID: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
Date:   Wed, 9 Mar 2022 15:20:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     bpf@vger.kernel.org
Cc:     Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: Question: missing vmlinux BTF variable declarations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0354.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::29) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4bf213e-ab49-4474-1944-08da0223725f
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2074:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2074D27620A144CEFBFABEABDB0A9@DM5PR1001MB2074.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Zcv4XRMpHX/yhRww4ZrAgGBjpPJi2kfF54qmjsdHJ/pDvfYEMV6OKy/wmdS6/kwf0urwADxS+2yob45+3LkSqYlWFwh1MHHNcEiXTxjwVEikzAqglHlNbDl0HKDE32d0zDtSRuw31Ub6c7eGjIoLTfMwdIiS7GbD7pHQcepy2ucSn4zRC1JU05inbtNfgBWWgtULl+HQnEpMp++jT+Xp1FDqn7B043c4Ey3/qa6xIHqUzjx3Y1hRkNNNiB4I6ZgSVM3+Rl4wFbYgYJZzJzyJOR+6Uipx8XOY6T6f0BOY0HxxQl9deNLL+Wl6SeZeAyc7WT+HYuFYfh/fUNpQDOxDv6D4fTWrc9nx7+ZsGPR77oaB0O3YTN+3Y+5fzdzIYUyASQsBtJ52A+Po/p8MhxI/8P9Lfj2tIOTas+zzeZkbh9YHH3uRggGKH92+zrkRZRm7piejnJA2dgXw6lh1DxXnHzbss67CegY7ZNOg/9V1TulY1ZRWcuR/+EVlcCGB64ig2N6wf+J9KvTVcUyHrTNh7iI//aMgkg7K+OJKKcl369g3r5dGhIgo7ThoGxdBq3xNVzqkTJ3uDTMVfwu4woHkBsRFgnQTn+1jncXMte0VRFgNHfYfH1696QcfIBKJKZpqXIFYsB0waodnIdPmv2FsMLsl9EMM6iKIhhUxIzbdejnIEjImXpEfTdxn8/q8rgp+NvzJWkiEWtQBtV14ExSOtDrH8QmjHCmHARlHeWSBkx/EtSkHvKg/1xiD2hmX3KZu4gaB4bi5N26ytYAhhGbGnrGb2LUlpUPA6jhxQV7MOgijJDsQ1Ki5F2lW/xA/NMLf1sn97xQNUSmSU/VCnXk63LSbJUNvQhpJ5VCUs+wlEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(54906003)(31696002)(2616005)(8676002)(4326008)(316002)(6916009)(508600001)(966005)(6486002)(26005)(38100700002)(86362001)(66556008)(6512007)(66476007)(186003)(83380400001)(66946007)(8936002)(5660300002)(31686004)(2906002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2EwaGhhck5idytMTmxvc0lPT200NmJCSCswWHVFZWxtSTQ2NnptU3JES01k?=
 =?utf-8?B?cGR6ZVhiaDJvdWFJRlhtSzJHQllZNnBGaitFaWsrNXV5QmVIQkdJUDBFZ0ph?=
 =?utf-8?B?WnlvRXU2d2hFeW5JWSttOHNnRENWUGNpWmNXeWJBU2tidkl1bXZoWXkySWFm?=
 =?utf-8?B?MlQwZy9lZFR3WWVSSStoWjgxSjdQaUhTdnFYWW5JUFR1bVUrWXZPYkNlcmNy?=
 =?utf-8?B?TzZoUFUzY3Vpb0lMUDlEUisrK3hRVlFuYVc4WWVIYmFLT1FmZlpHdGtxSXVz?=
 =?utf-8?B?QTdkWWZIZnh2Z1Y3NlBFT1k3bXFxb1pNZWNGTXV2UE9kanVuUmljaXBXQTli?=
 =?utf-8?B?N2NuWFdXZXBDUDZrL3U2aGFWd01iblQ1T2p4TG44d1I1YXVQTFQrQVVIWjUv?=
 =?utf-8?B?WndBR2l2MFVKTER5eGlqRkVZQXJZTnl6QTcrMlJHKzF5R3RwQlVTdTdpMG13?=
 =?utf-8?B?ZWZ5Q2FST1lYV1FGNVNycU0zeitub3lUUjRTcStkVlNUTFlrR2lDdjkyTUN3?=
 =?utf-8?B?WXZQZW5mQTFEelBOcVhybE1vWDI4bFBySVNEcmpFNDBMSDlOeW5TYXFDb2lv?=
 =?utf-8?B?d3I4UE1SM1NVNUJaK1lVcHFDR1ZFOFMvMldveWloYUdxVjZCUlZlK2VWQXB4?=
 =?utf-8?B?V0VNeEg1NE5RUUVIaDE2QUZIa0Fma3dSRHpqb256bTI1Q0NiZUVmd1hkWEVi?=
 =?utf-8?B?YzJVeDB6djljTDUwY3JpSHF5L1RGcFRKWlVFbUh0NjNFZHA1c2hVLzFabWIz?=
 =?utf-8?B?d3RRSllXQVZtdERZa1RPL24vbGdyRFQreG0rWmZBeEdTVFlTUkJHQ3VJcC9l?=
 =?utf-8?B?bTlUWkNyRGxGVEhxNWtsdnViNGZ3L0FTdm9UdTRsK1dpK0VuWGtOZXhGblVJ?=
 =?utf-8?B?a3hXL2ZGVjdiRzVCeENjK0IxZ0ljWmlZdjA4NHpEYjFaNTBqOXpSdVBFekR1?=
 =?utf-8?B?MjRpME82N3RGRnNDZzlhZjdqbHp3QmdtSkNIWDhTbG5uTkl4ZHdzMmw3Q0t3?=
 =?utf-8?B?N1FvbFVDczdsK1NNNDd1bytHYjhBK09OdEx5WjN6RUNZSXlIM2NBYkdZaDFK?=
 =?utf-8?B?S0VOREVqZ0FvYnRQdk9kL1RMVjNMNUJReTV0WTR3ZnRkWDF5bGVSL0ZZL3VQ?=
 =?utf-8?B?NXF1WHc2NmNXdTd2aDQvYnpDYjVLem1SWDdjYVFpdGhiZVNZdTZoTXczRWN4?=
 =?utf-8?B?YTRmckZjQUVBQlE1R0hHRDk1WUE2blIxeXRRL0xsZ0tBVzh2L25wTXNqQVdR?=
 =?utf-8?B?SW5tOXdVWTl1eU1XL0RITGg0WEZjRnh3NUcrQkZ1Tk94cnJ5Vmc0dm8vNUVI?=
 =?utf-8?B?SUt2Z01iWVBPbFBvaXZmWTVxdm9BTjkzWlJEVS8xYklrU3pKNnExWURwVzFX?=
 =?utf-8?B?S0UzazlIbC9ZdHRRbThEYzdaMSszcGNUR0tDTCtocEdnamhIRitBYk0wSWJr?=
 =?utf-8?B?allXejhvMnB3K2l0dThNK3pCbUNvcXBvRW96NDhsak4yeUIwd2NHdlRTaWV2?=
 =?utf-8?B?bFJBWHFFVE5BT092WWhDN1ptbjNFOWhuMHNtb2VRNTJFdHVxL0YyUlc1d2x2?=
 =?utf-8?B?cmZENEpqNlBlczFZVk9qQWx0NmlPWCtoNGl4MEplY3RFbTBXTTBqOGszSDFq?=
 =?utf-8?B?ODVyL2h4MmZ4aThoNTRIUklRZk9ZUC9yVU1vUVc0UTRmanhsWUJpaElzWHlW?=
 =?utf-8?B?emRSVXh1TUJCM0RnbEZvZWQ4SXlmWGl6T0U2T0hucVQ2aFRvY096MmVwMHlC?=
 =?utf-8?B?bDFIa0pUczhtblBzQmpVVWQ2Um1MU0RZSk5zcFpHT1BCL29WcndoRkg3VUtm?=
 =?utf-8?B?SUpraERsUlFLckFGVkM1YllKdUlSdTJ1VVJsNEdESWFzSnIxT0M5Q3VtemJH?=
 =?utf-8?B?QURuT3F1Q1g1d0d6WUw2U0pIZXdreDVzSTVvNVRwN3BPSW5MbTJ4TTZYRE8y?=
 =?utf-8?B?OW9qUm9FTndYb1R0Z0hwZ05pNkpFMDlTbkVDam5XN3ptV0xuWGtMQk8vd1Bp?=
 =?utf-8?B?SGtJd29RcWJlcW1STzZybWxnWWhHS0pBVWMxZkcrQzUvZVZ3R0FETTRwQnor?=
 =?utf-8?B?TmJ1cytxWlp3ZUVPN0xuN1lZeDljSTltM2FCL003TFlhTGFleUxNdW5JajIv?=
 =?utf-8?B?cmlFN3lMYzI2NGZoV2hRRWNPSEpQYUhoRVh4Q2lPNnV5cHl0dUVhblBWWDBx?=
 =?utf-8?B?c3JnS3dZcU1EcnhUVlpDKytRUmp1RXZudWhlU0lySFNBTDh6MU53VlNlaTJR?=
 =?utf-8?B?YzhqMEl1bVd4R2lHcitvVDJoQ3F3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bf213e-ab49-4474-1944-08da0223725f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 23:20:49.3854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIJmZ+OUApAs36otTM9hY2SBe9dF0aautv8A16Cafh84pDd72yN9OZdsGeHTay3+D1lCJeMprSY9GwWNyQrJzRnMb91/lGMGHIMT0Ixkf0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2074
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090114
X-Proofpoint-ORIG-GUID: c9QrKuztJEZR1VJvxU3fTKVbOv-5bZd-
X-Proofpoint-GUID: c9QrKuztJEZR1VJvxU3fTKVbOv-5bZd-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,

I've been recently learning about BTF with a keen interest in using it
as a fallback source of debug information. On the face of it, Linux
kernels these days have a lot of introspection information. BTF provides
information about types. kallsyms provides information about symbol
locations. ORC allows us to reliably unwind stack traces. So together,
these could enable a debugger (either postmortem, or live) to do a lot
without needing to read the (very large) DWARF debuginfo files. For
example, we could format backtraces with function names, we could
pretty-print global variables and data structures, etc. This is nice
given that depending on your distro, it might be tough to get debuginfo,
and it is quite large to download or install.

As I've worked toward this goal, I discovered that while the
BTF_KIND_VAR exists [1], the BTF included in the core kernel only has
declarations for percpu variables. This makes BTF much less useful for
this (admittedly odd) use case. Without a way to bind a name found in
kallsyms to its type, we can't interpret global variables. It looks like
the restriction for percpu-only variables is baked into the pahole BTF
encoder [2].

[1]: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-var
[2]: https://github.com/acmel/dwarves/blob/master/btf_encoder.c

I wonder what the BPF / BTF community's thoughts are on including more
of these global variable declarations? Perhaps behind a
CONFIG_DEBUG_INFO_BTF_ALL, like how kallsyms does it? I'm aware that
each declaration costs at least 16 bytes of BTF records, plus the
strings and any necessary type data. The string cost could be mitigated
by allowing "name_off" to refer to the kallsyms offset for variable or
function declaration. But the additional records could cost around 1MiB
for common distribution configurations.

I know this isn't the designed use case for BTF, but I think it's very
exciting.

Thanks for your attention!
Stephen
