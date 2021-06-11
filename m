Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276FF3A45CC
	for <lists+bpf@lfdr.de>; Fri, 11 Jun 2021 17:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFKP75 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Jun 2021 11:59:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63626 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229935AbhFKP75 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 11 Jun 2021 11:59:57 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 15BFvZ86008978;
        Fri, 11 Jun 2021 08:57:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vml8ycjd1el6bX249uTtCNfVSrW0Jmo6INwBHEKxm24=;
 b=bsDPHY/6+fYqb033lblznJ2cj/nkjFX3VPVnW0RYcnb22D2EEL6AeFO9eWza7pmo34cd
 8/oOtgJT6kL6MXb6wfSzmCGySV7s4IW4LmZy8y+B8w5dD3vQSUPSv7asb8WUHXSS3+bc
 R39FFOKB5xI7gVXGVS74dUAAIEy/MIL5qDg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 393skjnkgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Jun 2021 08:57:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 08:57:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bncpao/iQeTvzVYe/cYSFLGwFJVUP0MKuAoJpDlbzgn2+iIERiJ03QTAy8W4Uk65IGYiSq+4FamIfH3USYkfpz5B4b7Y04Ah9WFKb85pgs3G6CNKNVYtmWa6vktGwH7v0sQUNP7edfNku83T38tARMI3ebosWG+EHWrGhVnLDb3qWvBISGJpQ3SMHOh4hIkrQ0plpmdN6/zh3Fq4XuEPcSRVISXOshV98FEYV3Z2lQHkoEMQioMblEewC9wa+22YPquMqLn8Fqgni66rxX5aspmnKsv/q5zDR2t88663ntZyzuLQp2v3MTgLCzo7VcGhn/WGFX307AuqLDmssxCTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vml8ycjd1el6bX249uTtCNfVSrW0Jmo6INwBHEKxm24=;
 b=JviUFic6hkeoyZ7iw7febpts13QL9IY8PFEEaVNUeDRmHGcfCWKiDj1hF80eGKx61vrdTDkYmwXZgnzSNfl6X5B7gJS22ejS3ts89hMcsxTV2lsunx4cIsmTY0k7FsMmJS9jkFBFq9wxMpnyDftBNFr7jFSQoLrSWw/1LdhXq+QhPKa5d0W3Gxonu7FItVp019uOS7RnFNUMkL4uSXETMLCgnbo0hnmWIoALh8pnkg6O2UQQLvUpYrFMgmeiw1hRzowR9uve/M01koFOwDK90uBLlz8xtjStfqbbOR2OtavzQ4/TwAsA2PaJlQEMosSAXMkGx1hL79v7t5+5/KrEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3792.namprd15.prod.outlook.com (2603:10b6:806:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 15:57:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 15:57:43 +0000
Subject: Re: Kernel Oops in test_verifier "#828/p reference tracking:
 bpf_sk_release(btf_tcp_sock)"
To:     Tony Ambardar <tony.ambardar@gmail.com>, bpf <bpf@vger.kernel.org>,
        <linux-mips@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <CAPGftE_eY-Zdi3wBcgDfkz_iOr1KF10n=9mJHm1_a_PykcsoeA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ce6fd0fd-2fb3-7a66-4910-5fe8c2b4d593@fb.com>
Date:   Fri, 11 Jun 2021 08:57:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <CAPGftE_eY-Zdi3wBcgDfkz_iOr1KF10n=9mJHm1_a_PykcsoeA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:19a5]
X-ClientProxiedBy: BY5PR17CA0041.namprd17.prod.outlook.com
 (2603:10b6:a03:167::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::1aff] (2620:10d:c090:400::5:19a5) by BY5PR17CA0041.namprd17.prod.outlook.com (2603:10b6:a03:167::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 15:57:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac76ca1-8a54-4921-e240-08d92cf1a5f5
X-MS-TrafficTypeDiagnostic: SA0PR15MB3792:
X-Microsoft-Antispam-PRVS: <SA0PR15MB37920D9953456943CFF24043D3349@SA0PR15MB3792.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SwVfPUr5B7skuphpCozVx5f896PHmBTBqhq18sfuuQULI+kqRkjrLgAu823nk1TXVBPdTM+FU6BopCMTjfbnko5ke2sURiwH/os+iXDfM8aBfmAmtxLehDXgtW2kxWdJkWzepo2OWM9t7rvmXKnfO13FgyoMBYuQWzqOdfIsb5GtMA+NQvC3IoBCXrYji7NP4VhfI2o1x/6HKKhHo+kM19G83XSzkHSGv8BiU056xP6vVzBm8Lw476jnYDdrcW0ZtvvY3nLZAFBlfsUXb8adS3ouKrhPjx7D9lITyQffmm+lBQGu8+foub2VFc6MOZrRFawbW9Mr/R65EX1Ozh3KRMzT8Te9b+TCUUQRtdknQhbnLjL/quXZNdaF6QLC/KnvIvE0LEFOvJD7LXEdrLyspF0aylfsOsWNrHrEJxVPZrt71zfpHFGYkowIMC7hCkEn7x4nq6XuS05U57xAUxV17Jm+djrK5CPvVAeHqmLEDpsnj3DkPUqtRqOOujG+EQVPne6NHsg9kLDpYJKuWrzioi0HBbp2+i7xc5FJKmWvXZPWLQd+OUUbigD6iAzW1evfniIGEa53IR0O8m7yf9Swf7o1lVchrPucqfF7Wf0D6lKY9nYH+42YIx5x4olHuwlKGanHMrlxb9dp6d4luQg/Np0ymVX/vgh54o2j4K8PpXwU/v9NPHR1cyVstvswepXY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(52116002)(38100700002)(4326008)(316002)(5660300002)(54906003)(478600001)(110136005)(186003)(53546011)(8936002)(31696002)(2906002)(45080400002)(6486002)(66476007)(83380400001)(31686004)(36756003)(66556008)(66946007)(16526019)(86362001)(8676002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWkvRHlkR3djSnZKVVd2dGFNMU1QTnZGUHRhWGg2RHdkbk1XbVUvaVZsTGZ2?=
 =?utf-8?B?VzNYcVFSelVESGE2WVlWZmpPR0VXZjBEZFhVSkdEV0dKQXc0dkpYZWdHdlN3?=
 =?utf-8?B?TzJvOGVQcEw5cU0yU0c0RVJvY25yaXZXQytqcTUwOWxOc0ExNlFzZ3NxMGlh?=
 =?utf-8?B?ZW5kNXRCSk82YU52QWNwOUJwL2hMMkpiSWFvamNJbWo0WXpHTGcwSXF3bTdr?=
 =?utf-8?B?dURpMDBta01GdElRWXNiV0JCWWo0SjIrMkpXMGpRZmt1aVVJMU1nSnZ0Wmh4?=
 =?utf-8?B?SlppSGl6UjhpUmlkc3JRVUVQYzU5VVFyL2RteVI4SHY2TzVuQTZPSzVHSDVS?=
 =?utf-8?B?bXJ4S20wYlhZRC9MRFo3bmNMZjhaVG1oTnRQTGlLVnFmMHZhaUF0M2s1NHg1?=
 =?utf-8?B?cVk5MElLSGRYeGNyMDUyMVRwNGFETlY4V2FmUmkwbEZ2V25nL0JwdEh3NVBk?=
 =?utf-8?B?ZUdMNDRCaU9KRFI0cnFZRk5Cc2pjK25xeUsxNXJkWE1aekhRZkFtRGJlQVFi?=
 =?utf-8?B?OTYybERJeDdqL1lJdlpzZ1hsUnpRRmluMXJoa3ZTYkw1eC8yVmlOZ2c4Ynk1?=
 =?utf-8?B?OTZidnQvbmx3ZHE1bVpMcUl0UjgvbTM4Yk9uLzBjeVNOZms5WU5QVEc5NVJx?=
 =?utf-8?B?OGtXTjhjSVJ4TVdJcy8zc2pNOTZrL1FHaG1hZTNRWUQxNkkxbG9MRUxnb1lK?=
 =?utf-8?B?T1pkTzV2dEM3cEsxMytSbnRxelJJclRQVERiRGM1ZjJyaG8wTjNMcHF2Ykll?=
 =?utf-8?B?Mlk5elhFeDBvV0FzZjFBRTBHY1Jld2Z4c2VoYWFZOXRoS1JiR0Q0VEFSR1J6?=
 =?utf-8?B?ZitXRDJma3BHSWl4ajhBbTdxdGlEZndCZFdiSTI2K240cjkvclRIQ0FObElh?=
 =?utf-8?B?SVBnNGg1dFdPZWw2MHcrd1YvMy9zOHZTQ1hqNWhVM3hkM0dzZWh6MUZ1M2s3?=
 =?utf-8?B?bHVRMldsbW0zRkEzOHNibjIveVI3L1pVMnZhM3A2dEFEMzhKcE1YY2ZpbTc2?=
 =?utf-8?B?N1ZWcWxKbFBTRVVsTXduWE5wbzcrK29ucHVsejZPc0VTckZyWEw1YnZYdkhF?=
 =?utf-8?B?VmNtckVrR2ozRyt4Q3BDdHBNb1hzTzNFSHlUdm9MeWpKOVZKWVlFeTgwSlJ1?=
 =?utf-8?B?Zmx1QU1xWVNOMXhZSDhtQjZFaEw5MVZCQ2dmNk40RXZDRk5XcXk0RDdyZ2kr?=
 =?utf-8?B?clhGRWZPR1kxdlFOU2Uzck5UL1N0NWdlSTdENlFFTExEN2tpL0pNNlNvV0Jj?=
 =?utf-8?B?SDcweFFVcWdvU2xxSGZIVndsQmp0UzRyR3JGNDBGcnJtYzZSWk5ESUZMQVBU?=
 =?utf-8?B?dVlPdmk5RWJHWmZ1eXhjd2ZYeUJBb1R6aHVWbVZKcjBaNmkweXVYMG5aZHQ1?=
 =?utf-8?B?aTRSMmZGZDJkM1dMcE1vR1JmdUI4QXFlL3FiZHlOMkJNNTBJSGhXSnZOeWlr?=
 =?utf-8?B?WTRrTmZWZFhYWFlHWUN6NWZIeGVwelJDd0NoZGlhcmJsZ1B2bUFHeG9Yb3V6?=
 =?utf-8?B?aDQzTCtWMDdjdjQweitxZXpYU00yM0pLWVkvVjJHN0tBZ21mOVJlem5WcnhL?=
 =?utf-8?B?LzdEa0Q4T0NDMVg3YTQ0T1dpS0I1aGg3bzFZVHQ0WUJCeTNwWUZZVEZYS3NY?=
 =?utf-8?B?bXk4c3o0MCtjK1B0ZmFIT2V6U1VjQVZ0R0ozM2FEOG1VM296WEhmNGIxSnJC?=
 =?utf-8?B?b2l1RWsvc2JoUnVsWFZ6eHBqWW1pUERzTDlrZXc4cWt6QkxpYXhQYUlxcERa?=
 =?utf-8?B?ald5MWVOUTRyOGRqZDFOdVlYVmFESUFaRjQ0Nms2SElaSnZCbklRS1MvS0pj?=
 =?utf-8?B?amkwQ09iVmc3eDNkWThpUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac76ca1-8a54-4921-e240-08d92cf1a5f5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 15:57:43.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlEaoXQ99lGTlXj67SlY4YJ3+T6aaYdIzbWk/fEt9yISynfV4NCgDgPkaa1GCdXg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3792
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: A44zxnJ4rwGvOLQt4EyKMUp80d_myCr6
X-Proofpoint-ORIG-GUID: A44zxnJ4rwGvOLQt4EyKMUp80d_myCr6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-11_05:2021-06-11,2021-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110101
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/10/21 6:02 PM, Tony Ambardar wrote:
> Hello,
> 
> I encountered an NPE and kernel Oops [1] while running the
> 'test_verifier' selftest on MIPS32 with LTS kernel 5.10.41. This was
> observed during development of a MIPS32 JIT but is verifier-related.
> 
> Initial troubleshooting [2] points to an unchecked NULL dereference in
> btf_type_by_id(), with an unexpected BTF type ID. The root cause is
> unclear, whether source of the ID or a potential underlying BTF
> problem.

Do you know what is the faulty btf ID number? What is the maximum id
for vmlinux BTF?

The involved helper is bpf_sk_release.

static const struct bpf_func_proto bpf_sk_release_proto = {
         .func           = bpf_sk_release,
         .gpl_only       = false,
         .ret_type       = RET_INTEGER,
         .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
};

Eventually, the btf_id is taken from btf_sock_ids[6] where
btf_sock_ids is a kernel global variable.

Could you check btf_sock_ids[6] to see whether the number
makes sense? The id is computed by resolve_btfids in 
tools/bpf/resolve_btfids, you might add verbose mode to your linux build
to get more information.

> 
> Has this been seen before? How best to debug this further or resolve?
> What other details would be useful for BPF kernel developers?
> 
> Thanks for any help,
> Tony
> 
> [1]:
> (Host details)
> kodidev:~/openwrt-project$ ./staging_dir/host/bin/pahole --version
> v1.21
> 
> (Target details)
> root@OpenWrt:/# uname -a
> Linux OpenWrt 5.10.41 #0 SMP Tue Jun 1 00:54:31 2021 mips GNU/Linux
> 
> root@OpenWrt:~# sysctl net.core.bpf_jit_enable=0; ./test_verifier 826 828
> net.core.bpf_jit_enable = 0
> 
> #826/p reference tracking: branch tracking valid pointer null comparison OK
> #827/p reference tracking: branch tracking valid pointer value comparison OK
> CPU 0 Unable to handle kernel paging request at virtual address
> 00000000, epc == 80244654, ra == 80244654
> Oops[#1]:
> CPU: 0 PID: 16274 Comm: test_verifier Not tainted 5.10.41 #0
> $ 0   : 00000000 00000001 00000000 0000a8a2
> $ 4   : 835ac580 a6280000 00000000 00000001
> $ 8   : 835ac580 a6280000 00000000 02020202
> $12   : 8348de58 834ba800 00000000 00000000
> $16   : 835ac580 8098be2c fffffff3 834bdb38
> $20   : 8098be0c 00000001 00000018 00000000
> $24   : 00000000 01415415
> $28   : 834bc000 834bdac8 00000005 80244654
> Hi    : 00000017
> Lo    : 0a3d70a2
> epc   : 80244654 kernel_type_name+0x20/0x38
> ra    : 80244654 kernel_type_name+0x20/0x38
> Status: 1000a403 KERNEL EXL IE
> Cause : 00800008 (ExcCode 02)
> BadVA : 00000000
> PrId  : 00019300 (MIPS 24Kc)
> Modules linked in: pppoe ppp_async pppox ppp_generic mac80211_hwsim
> mac80211 iptable_nat ipt_REJECT cfg80211 xt_time xt_tcpudp xt_tcpmss
> xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac
> xt_limit xt_length xt_hl xt_helper xt_ecn xt_dscp xt_conntrack
> xt_connmark xt_connlimit xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT
> xt_MASQUERADE xt_LOG xt_HL xt_FLOWOFFLOAD xt_DSCP xt_CT xt_CLASSIFY
> slhc sch_mqprio sch_cake pcnet32 nf_reject_ipv4 nf_nat nf_log_ipv4
> nf_flow_table nf_conntrack_netlink nf_conncount iptable_raw
> iptable_mangle iptable_filter ipt_ECN ip_tables crc_ccitt compat
> cls_flower act_vlan pktgen sch_teql sch_sfq sch_red sch_prio sch_pie
> sch_multiq sch_gred sch_fq sch_dsmark sch_codel em_text em_nbyte
> em_meta em_cmp act_simple act_police act_pedit act_ipt act_csum
> libcrc32c em_ipset cls_bpf act_bpf act_ctinfo act_connmark
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sch_tbf sch_ingress sch_htb
> sch_hfsc em_u32 cls_u32 cls_tcindex cls_route cls_matchall cls_fw
>   cls_flow cls_basic act_skbedit act_mirred act_gact xt_set
> ip_set_list_set ip_set_hash_netportnet ip_set_hash_netport
> ip_set_hash_netnet ip_set_hash_netiface ip_set_hash_net
> ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_ipportip
> ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ip
> ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set
> nfnetlink nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter
> ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ifb dummy netlink_diag
> mii
> Process test_verifier (pid: 16274, threadinfo=c1418596, task=05765195,
> tls=77e5aec8)
> Stack : 83428000 83428000 8098be2c 00000000 83428000 8024af78 834bacdc 834bb000
>          a98a0000 834e2580 834e2c00 00000000 834e2c00 8023da9c 834bb070 00000013
>          80925164 80924f44 00000000 80925164 00000000 83428140 80bc3864 834bb070
>          834e2c00 00000000 00000010 802c441c 00000000 00000000 00000000 00000000
>          00000000 00000000 00000000 00000000 00000000 00000056 00000000 00000000
>          ...
> Call Trace:
> [<80244654>] kernel_type_name+0x20/0x38
> [<8024af78>] check_helper_call+0x1c9c/0x1dbc
> [<8024d008>] do_check_common+0x1f70/0x2a3c
> [<8024fb6c>] bpf_check+0x18f8/0x2308
> [<802369ec>] bpf_prog_load+0x378/0x860
> [<80237e1c>] __do_sys_bpf+0x3e0/0x2100
> [<801142d8>] syscall_common+0x34/0x58
> 
> Code: afbf0014  0c099b58  02002025 <8c450000> 8fbf0014  02002025
> 8fb00010  08099b4f  27bd0018
> 
> ---[ end trace ab13ac5f89eb825b ]---
> Kernel panic - not syncing: Fatal exception
> Rebooting in 3 seconds..
> QEMU: Terminated
> 
> 
> [2]:
> Function Code:
> ==============
> const char *kernel_type_name(u32 id)
> {
>      return btf_name_by_offset(btf_vmlinux,
>                    btf_type_by_id(btf_vmlinux, id)->name_off);
> }
> 
> const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id)
> {
>      if (type_id > btf->nr_types)
>          return NULL;
> 
>      return btf->types[type_id];
> }
> 
> Disassembled Code:
> ==================
> 0x0000000000000000:  AF BF 00 14    sw    $ra, 0x14($sp)
> 0x0000000000000004:  0C 09 9B 58    jal   btf_type_by_id
> 0x0000000000000008:  02 00 20 25    move  $a0, $s0
> 0x000000000000000c:  8C 45 00 00    lw    $a1, ($v0)         <-- NPE
> 0x0000000000000010:  8F BF 00 14    lw    $ra, 0x14($sp)
> 0x0000000000000014:  02 00 20 25    move  $a0, $s0
> 0x0000000000000018:  8F B0 00 10    lw    $s0, 0x10($sp)
> 0x000000000000001c:  08 09 9B 4F    j     btf_name_by_offset
> 0x0000000000000020:  27 BD 00 18    addiu $sp, $sp, 0x18
> 
