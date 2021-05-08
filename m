Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8395376FA8
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 07:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhEHFEi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 May 2021 01:04:38 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45804 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229467AbhEHFEh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 8 May 2021 01:04:37 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14851JeC007339;
        Fri, 7 May 2021 22:03:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YJMScoqq4OZRLSudwfybxeXMZ8qBprrhg8WuVJ2IUP4=;
 b=Vmc0SO2HoF5Uc75Y/xZFEFRwbWuuumjF/W6eQ2NaPC3vMOfLskh9SpEBO47o7u6LYVbK
 GcUBrDk4LMDuKni6IWrpJJ/k9lhu+Hucgdw3aheDNXvStKmvNgD0S+t3QIfAwavFF1gB
 0l5te0PxFTrvbSbObrNeeQR7HHABSyXNc8c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38cspy6y28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 07 May 2021 22:03:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 7 May 2021 22:03:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0+QyIWsn7tF3DCCk+QRqGLH+lZ6/YZb0LEzK999P/XntcR1EoEZahxSswnqSy8K+n7ZEwOxYeTbPwJTDs3GxUlj2wxYfTUMWQ4QTMJjTIOVXbyD6FE5kJ/tvuO1xfdBxmKOQF9kxfMXSn+8BzRFJBsYi5Ym3XBG9sbjT2q5ceXGHUJvdg1XM2wHbmE+13zPWJlCSLqWJN+ShGPAFtg0CtOubSJtjVr2Fzrj9MwpLQBhRW10qwQxNQyxFNtTuN7fv9cEmNX3TLXy5DjsmcWXxbmjvPazgfrfymSZcXO0xv4jxt1rtw9cZaNnWDQGJxIpNKmfrU0hnq1g5B/5lowKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD3flUblBzJpZ3mdeszCYTLhCtGK39t2bhXRY5zk76g=;
 b=jyQdIAXIfU0PhkKI1MGLVuU6NzBa1dcqKNsJ4uZnXb6rNItLJalGaQYydjh1XLcv0nwG7PVJDmm2FApM8Qi3xuf0X8cughZloHMaQBD8vrYMyvhzbbCgdzcrQ/0LrUErbiF8m+hO/CirLYVlKK0oPPsrEr6KFh+99HxSyotfGwBWwcDKLSYXDRTUabxsILkI3zxFuWoreao5w6DuXgzqKzxYKeVqSA4PbuUUy2FSUUD6qrMDnP7O1yJLYATazRdOD1SdEqdJ0YxZo172ZGzaRUKxiG9dtMWutE9L+FKhhaqv6VKB5xwBp+ADBA03Xy/MX5/GCg/QZmIjZWoqgCWUlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from CH2PR15MB3573.namprd15.prod.outlook.com (2603:10b6:610:e::28)
 by CH2PR15MB3717.namprd15.prod.outlook.com (2603:10b6:610:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Sat, 8 May
 2021 05:03:26 +0000
Received: from CH2PR15MB3573.namprd15.prod.outlook.com
 ([fe80::fd38:6d99:bf87:c3e4]) by CH2PR15MB3573.namprd15.prod.outlook.com
 ([fe80::fd38:6d99:bf87:c3e4%3]) with mapi id 15.20.4087.044; Sat, 8 May 2021
 05:03:26 +0000
Date:   Fri, 7 May 2021 22:03:21 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
CC:     <dwarves@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2 dwarves] btf: Remove ftrace filter
Message-ID: <20210508050321.2qrmkzq7zjpphqo7@kafai-mbp.dhcp.thefacebook.com>
References: <20210506205622.3663956-1-kafai@fb.com>
 <YJSr7S7dRty3K8Wd@archlinux-ax161>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YJSr7S7dRty3K8Wd@archlinux-ax161>
X-Originating-IP: [2620:10d:c090:400::5:af9d]
X-ClientProxiedBy: MWHPR17CA0076.namprd17.prod.outlook.com
 (2603:10b6:300:c2::14) To CH2PR15MB3573.namprd15.prod.outlook.com
 (2603:10b6:610:e::28)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:af9d) by MWHPR17CA0076.namprd17.prod.outlook.com (2603:10b6:300:c2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Sat, 8 May 2021 05:03:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 258d378e-35f5-435e-9b1d-08d911de9c88
X-MS-TrafficTypeDiagnostic: CH2PR15MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR15MB371729C83044ADC47FBC21CFD5569@CH2PR15MB3717.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ND5LzmLR37Nk+UBCYrxHTdI46OzsS7XNS5lMyZkyAjCjT/Gs9L7M2zz71SJdCI973txEY71rm1h7Vun42vfzODGhq48wjyibc15b5xAfmw/kBeza06tzQCJQcuuDn3kbr2PMyk+aqhRk4m3UCVpEogvKClqU1PcheV3bn51biY53ETYfsyQVG4evwObvOE8CRejudtD/Tzfr8LGVsu+DlHeMarCsa9aHeeTuCYKDxpUzSKWUMV2dAXEKwZbCi6q9IXll2GsWPtgpxHmx1PdSj7RLspcz2NbM3zUQfHkxU7yeQ2vdFCx4YdEhOkoWEvOmpYbUhjnboU8hJGedDx+EGqR+Gezdvr7JkPRJSO60RBfraNGPiYVP8hKectNlw0gBvJval0EfqcbCd/+7zP10akKtYRsX5DoxlLwhBPOKLuwsYujZluwtK3KhQ2mCKYyw6WEVAGBWATjCHKBgPftakMJwxxgKTfdE9kzCAhECkgx7r5NSOySN9USS9qjfwn+EcvWdr4Xz80JiL8Ff3ij6dZVVKvSKijsPsy3dH+bUv+SipCN2yF1TArmZ0mXZ/7dPRGP8oL982OeN+ymXQHyzCA4gr6JODGd9nb6WmMRVHxPxaIED4+iGmRvUWChlfXUVLmHU9KF6+/sUeEmktzx5xQRlWS9MM9uuL71pmVaucD56ag8fT8jW2GnA35ZR26qLkfSbkZz6+5LvFAfb4ZXH9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3573.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(186003)(52116002)(16526019)(110136005)(7696005)(6666004)(54906003)(2906002)(38100700002)(66556008)(66476007)(1076003)(66946007)(4326008)(478600001)(316002)(55016002)(966005)(86362001)(9686003)(83380400001)(5660300002)(8676002)(6506007)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Yg294xOvWm1nPJaAQdK9MJzhNCZ8vjroXBlnNqggWpPM3Tc8hypCRo+32eBx?=
 =?us-ascii?Q?g9VuLo3ZcrWGhiNNKFFoXjRwQqXTPIFB1QOTcSr1gOHLTnI7bvqO4DqatTKI?=
 =?us-ascii?Q?pGYUU987JbqzStLajQ2RATeEFngrx+WSjw/PFk1ECABG5Ny3h25kl0SfYQMH?=
 =?us-ascii?Q?Orbph7TgP2MErMoO13ZDDbI9ESSfqvhVESm/E00iGoY+FLAnu02AfGVyGOaO?=
 =?us-ascii?Q?qOa72YfeHVs7aWe17DgGRprvhEw/JW3g8yF7IWazzKeS1cA/QXU6LgYqOcKy?=
 =?us-ascii?Q?mEoHIjbNDWYVGKUAvhrLzWXjAhPtnn2MdMm2J+zR2Nmn5w86XVAHNbYUPIf1?=
 =?us-ascii?Q?7RLP5jApCpa9liDT0/Yv7Grr7F5j89z/Ghj/ElQG0k8E1BdeOCv/uToL8CW3?=
 =?us-ascii?Q?Ngs9z16sICuvF9ApHX2395J1oRLxCmXDQH9+0yFNI9DmoLLB/XNbQN2rY3yA?=
 =?us-ascii?Q?40EtLbBTJqC4ABYRV+yfpGkjRvF0tStmI0rYNAbtScrDwCO3/91DixNH+VVp?=
 =?us-ascii?Q?NL8S0jKl0hx9xKBujsrvQLPb0Qup135u1YnnwSKn1S2VYQuewpUpfihjDxPM?=
 =?us-ascii?Q?wxZZ8QxsITMpGvT26XC2V02KZYcWrpId48emBQUnMvJsJ84HJC/FbYFXGO8F?=
 =?us-ascii?Q?RDPkC627niftTjib3CmEIQdTkdqMlX3B1mDRKkUYKD+slLpnhOxkbZG0Kv4r?=
 =?us-ascii?Q?XP9Q884nm25J8r7bn9rLbqA7KyIfed6HSr51E1I45KBqqn6iBdKbnD4nrt2y?=
 =?us-ascii?Q?Xa9iIYxEcNS02YWE7gLC5f4BUtz6vIxJRK+UTUYzstEaUPemu4olgUNBpQRk?=
 =?us-ascii?Q?kSrBueUiqQqeFdk/uz97mf7nKNTu1Q0VJk5kVXTs+M9Bn9XmFa8KOLXNdv9T?=
 =?us-ascii?Q?EzacQ1WgOhTvY7I1c4HS409g5lE/kvnhDKRwXMMKdT7SJeZWp0M1wavaZPUY?=
 =?us-ascii?Q?/m7O7p4WpgXaruQf0uuiesmjo9xz7PdW4TCSlc35owEs+u3AsSH7wWjGXiVR?=
 =?us-ascii?Q?S1JBS96rKe11v+OzQSeyb6VkFXCOqwMMQpjl/P751Vv4xJe+FJy3vVTCffwc?=
 =?us-ascii?Q?X1CKdF6iey1FXkzhg/oyb3IN+94khQIrtq4mcfV92azZnS7D7fJ6OPM9Fi0V?=
 =?us-ascii?Q?Z/W083D3SsYoohjiJgHND1VsW9OX97ZEwPFNQ9QxqV9BUY9gvYUrm2jz6m59?=
 =?us-ascii?Q?n7LU+iA8L284zZ5vHpbRvd3auooPEOyrakIUHPH41E9ZvLGrq2pFT8+9OesO?=
 =?us-ascii?Q?I14f3XkrrjsBaNEpLxPM5zt+SGdFGm9rKlx95HUWzdoDJaiZqlglTvfJj7AQ?=
 =?us-ascii?Q?Za9kCpj8qREysGXGs7t1g6Y4A8DCY5ewbBasVShr4Gs69g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 258d378e-35f5-435e-9b1d-08d911de9c88
X-MS-Exchange-CrossTenant-AuthSource: CH2PR15MB3573.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2021 05:03:26.0763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6mjBN/IYpvGGfnJYkckGOAacggrivHyW6hi64/MOFXv2B+w4QUGGRJzMiH1DsXe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3717
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: lUde6_hWpwqd0w3JEn5yO2ks_IpqPESb
X-Proofpoint-GUID: lUde6_hWpwqd0w3JEn5yO2ks_IpqPESb
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-08_02:2021-05-06,2021-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1011 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105080034
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 06, 2021 at 07:54:37PM -0700, Nathan Chancellor wrote:
> On Thu, May 06, 2021 at 01:56:22PM -0700, Martin KaFai Lau wrote:
> > BTF is currently generated for functions that are in ftrace list
> > or extern.
> > 
> > A recent use case also needs BTF generated for functions included in
> > allowlist.  In particular, the kernel
> > commit e78aea8b2170 ("bpf: tcp: Put some tcp cong functions in allowlist for bpf-tcp-cc")
> > allows bpf program to directly call a few tcp cc kernel functions. Those
> > kernel functions are currently allowed only if CONFIG_DYNAMIC_FTRACE
> > is set to ensure they are in the ftrace list but this kconfig dependency
> > is unnecessary.
> > 
> > Those kernel functions are specified under an ELF section .BTF_ids.
> > There was an earlier attempt [0] to add another filter for the functions in
> > the .BTF_ids section.  That discussion concluded that the ftrace filter
> > should be removed instead.
> > 
> > This patch is to remove the ftrace filter and its related functions.
> > 
> > Number of BTF FUNC with and without is_ftrace_func():
> > My kconfig in x86: 40643 vs 46225
> > Jiri reported on arm: 25022 vs 55812
> > 
> > [0]: https://lore.kernel.org/dwarves/20210423213728.3538141-1-kafai@fb.com/
> > 
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> 
> This fixes an issue with Fedora's s390x config that CKI noticed:
> 
> https://groups.google.com/g/clang-built-linux/c/IzthpckBJvc/m/MPWGDmXiAwAJ 
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org> # build
Thanks all for reviewing and testing.

In my cross compile ppc64 test, it does not solve the issue.
The problem is the tcp-cc functions (e.g. "cublictcp_*")
are not STT_FUNC in ppc64, so they are not collected in collect_function().
The ".cubictcp_*" is STT_FUNC though.

Since only the x86 (64 and 32) bpf jit can call these tcp-cc functions now
and there is no usage for adding them to .BTF_ids for other ARCHs,
I have post a patch to limit them to x86:
https://lore.kernel.org/bpf/20210508005011.3863757-1-kafai@fb.com/

Can you try the above kernel patch without pahole change?
(i.e. use pahole 1.21 as-is).  With the above kernel patch
and pahole 1.21, I have cross compiled arm64, ppc64, s390, and sparc64.

[ p.s. vfs_truncate should work as is in ppc64 since functions_cnt
       should be 0 in ppc64 and then it will rely on fn->external. ]
