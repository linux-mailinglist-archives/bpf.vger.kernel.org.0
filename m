Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABF1512151
	for <lists+bpf@lfdr.de>; Wed, 27 Apr 2022 20:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiD0Sor (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Apr 2022 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiD0So2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Apr 2022 14:44:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7087D674DA
        for <bpf@vger.kernel.org>; Wed, 27 Apr 2022 11:25:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RHpUa4018603;
        Wed, 27 Apr 2022 18:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1/ux9doE+elLouUSOw+2GUzRLgf+ht9kigWF/go5tyQ=;
 b=MzTcy6q7meSMD7bvdVBa/Yq/pRRwMMk6dCzH3pePuG/wGIDW1CKSwHA/OoMdRQySxoUc
 Q3Hnt8S5/uBnXUXPyPnnAFCArf9w1grVFpmzA5OKzmLanqOTSYEpNb4mNttjY/4O8C2A
 3+67Zq+ukSIdRqIe4jBJfTJYErTmLoc/Q0RIpfQOLs9LYqx0ittPjcWMOvXF9qsHtapy
 itVaHQdk5wGeLlEDWyEeoRsSoYvvkCcIEM0vCGUAxW9ZoknGPqXjm3xMVnb7cpWTVKMW
 Cuce/Xbe2lpfP8d2y8QBzVCYqQ07uzbS1yxxJ1xA27xoXnUpEL4KvdnW7sOlgScL1Qx9 gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k1xy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 18:24:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RIBDbS027082;
        Wed, 27 Apr 2022 18:24:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w59hw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 18:24:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aywxb/Ke7pjbVgEZDEQuI5XV6gwCxIHLYvK+HtP92Igxs3guG6+eEGUWB9mPrVdQVyexVTexOcPp6rYN7NbcZTn/lqediqA/O9vbVYU6uLeJbEJCKDllt812OBD4xE9hRgJCwl55nl8qBn9M6VsJh3qe/24EwXMY5DPD4yt3Q9nl8+WO9idZLWMP8d4i592VfqTPNJYAtAaGqqTiOlKlkDXUa7tNG+i3Gl++NTIBd9utJwyfm0FC5JsfBxJ4JdmyjRBIHDlXuHyCHKBh5nov8Av2agrs1VQB4CHw3JW67q3h2wLUly1ifGlrx7UfJ+fgPaM4ZLOLro6KxbfR2Jb5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/ux9doE+elLouUSOw+2GUzRLgf+ht9kigWF/go5tyQ=;
 b=Tm1nwuskdIWRKh9qop7JseJD1eWXYHYRMHil5GQvk4RMb3Tk/k9Wxdptg2D/v32ea3QEd9H1aLh/e4wZRhNjJOCrb1llX/8A71JjZCYuZ/jNcZteEghrGmwnf8ZFmpMI/uotBrohcEPLUZ3bBn+0SmAsRB3j4llYTuV9D2VERTzW/s5um0TrcmSCVOS2pL2IZ+bJioRTTFEkkdjn6y1DP6CM/7uQnkEI98xDVHMR/2N4nf9lTLRsgKnJLB6jQtlUWn9jco2v15ACqdFjNh1FfgIfpmP3vUHuJ6cPMSG7UmvhU1vQEPQLl9SYBBZ8l6v1/07cTc4M+UApnBbWcIh1VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/ux9doE+elLouUSOw+2GUzRLgf+ht9kigWF/go5tyQ=;
 b=xt/vNKe8OqNT+PxHKaM1WmQNoD1LzrPs585nDRD6HGLticKORybF422QSeN0b56rLKFB47DQoaWvhEsHSsYvQZ76L303fhuG3QDdh8Gjb6joF/Ejhb0S3h+LMtPP8XcYBs4C4kf1KTxpxDfc/asUGyOLJwShjuQ+18CjJm/ncYQ=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by DM6PR10MB2844.namprd10.prod.outlook.com (2603:10b6:5:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Wed, 27 Apr
 2022 18:24:43 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::875:8100:79b0:118f]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::875:8100:79b0:118f%3]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 18:24:43 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        bpf <bpf@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
In-Reply-To: <CAEf4BzbiFNnsu9pji5ifzj4nVEyAYYdqP=QVZ3XFwzL48prP3A@mail.gmail.com>
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
 <Yi7qQW+GIz+iOdYZ@syu-laptop>
 <f6f4a548-8e50-f676-8482-0ca541652cc6@fb.com> <8735jjw4rp.fsf@brennan.io>
 <YjDT498PfzFT+kT4@kernel.org> <878rt9hogh.fsf@brennan.io>
 <CAEf4BzbiFNnsu9pji5ifzj4nVEyAYYdqP=QVZ3XFwzL48prP3A@mail.gmail.com>
Date:   Wed, 27 Apr 2022 11:24:42 -0700
Message-ID: <87r15iv0yd.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0028.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::41) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cd68088-30d3-4f81-e691-08da287b3314
X-MS-TrafficTypeDiagnostic: DM6PR10MB2844:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB28449B8FDF5E72176043B46BDBFA9@DM6PR10MB2844.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrN/C4/Z9RX3OmeMVkJeJpfTSHVc2uuITPTB1blyeNShiA9oqi9jYnoPNpmZJmkKYho2MYQHPUJrj4qEhs5gimIc6iXmsDHwd0Fck+Lm+DvpClgTiPhNLMqehUPWPR+OysJ0PSVkpfL2owFCOFWwPBMnWEgBbRezHsLv9bAvcnwe5rU7eb0COoxBSuUQwkUpk3aWZOCi6yIkiEvAPU99VvmvAyRv0DwLlF98v/j4UrSbZnLDl3KAIPEeo4fEHt9nDa0Ghb5E00Ap2B04KpdpkdP3Ss+Av4bhEP28M58AxpUyxbVgzl0wiIvbSoBFL5LyWgsiZlTTjE5liqXL4AwsgrhbaFEQU1Kbs+GiC1jZL3Nl2JWi7s62XyNWod70wyJytak35g00pvCaoltTzeoB1rAGLf131Nmw+hlNVi3t4xuZaadhoeRMkkT+7ktxlbUqLRgJu/huJ/gAKfMBXmdIdVZxeEXfxbnw2ScAcDYzlPXQmG6MzqUYxpYA7BPZugZSP/9sPw65kmEDX88ihxSITZbNtx3ymBLwbO37mJoj4yn1HH1cGmUawyh2IpvG1uq8zVj+klQDBdCpaqzLDZgFSZGk1/OpPnHrDx9K9l8NJXe9et3Hij8NSBZ7zvlIv4EH6CEfsDabvn/7hJUgxdCoFdig2vj3lz3IYrIQtVkezILFfeEtbyZ7K+7pGLz50NpCDEv9t/1PvMmXDYUjUStIXDVKHEv2PWGIpL6KgFUUF3jQE+gd0oRtd5ksKSbSw3LMnT+m84tgYSopEXfSibm/3wU6mbw78urwvePI8E4T9VgICrw2RnxP3R+9+vJjXh1PW7c9gKsmOoT9XqSZVpRFdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(6512007)(26005)(86362001)(186003)(508600001)(66556008)(66476007)(38350700002)(8936002)(83380400001)(38100700002)(8676002)(2906002)(4326008)(66946007)(52116002)(6506007)(53546011)(966005)(6486002)(54906003)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ckYLTCSrROJAqzw4r5/vu4qMfyRAQyzHv3nvrPbmGZzLpfYe8sSvHqKdMst?=
 =?us-ascii?Q?ZoDIx5bgICi4WBXY2mDMS7Jvpui8nkIn9rBO50a5q6s4b4bVv+fy9ismRLhY?=
 =?us-ascii?Q?YdjvtKpKto9exa/59Z1WJ4i3iYiM+KYNmo4agvvyYAeWNHXSI1edRzemw0lQ?=
 =?us-ascii?Q?OjwLtamPY92CEA8Dx8+9ikEj7vMCfLtuBQWC8uxeWaUZmt7dFoVVEr6IzTPI?=
 =?us-ascii?Q?yfjQQ6cZhjvCYO/Q7vPzYf6REt0qkw+tlQ+HtUhY3rfYmAfAtpZpAzxFkcFn?=
 =?us-ascii?Q?naI5ZZSUH3lkef6uT00D/TmJhpeYKI3eyAoTHvH4YP5pLMPGI6A7pGg4Fpi+?=
 =?us-ascii?Q?NMc8XEzVER4L4dtuaf0WK7j5fT9cFXEEL9djSy2KbXR4aQg0In7XIX4drqpb?=
 =?us-ascii?Q?Rw/cBlUNf4etgO54cQEgqheE+vBDRfFtlNCosSU1Snrc5lN1e2MDEdpp54iA?=
 =?us-ascii?Q?7CMt3Jg0CuD5DAJoyUrxNK1RY1IsPWfcgGC0lNSAGmkpokf6g7J+1G9kw03j?=
 =?us-ascii?Q?z2yQ/C01cuYZM9pL9dGZmjcnX0aAvklslAWAdv3UP8NSJvWb9cgl3c+d2Z3A?=
 =?us-ascii?Q?/Elxl1PcJwWkDNhP/Wz11q0flXB0fb9EGNp9sMWg7yq7lLwp7HJeJCM4EiZU?=
 =?us-ascii?Q?WPRQnDCKgzT2ZMKdKuoPb9sy4In5jQAnAnhx1o8hvRM94YfbFZ79rq9mmd83?=
 =?us-ascii?Q?jZznBPSqRoV3zCm/qzDuasa1jM4grJF4W9AWMuEGzvpMyaXFakW4wOb+Uwxm?=
 =?us-ascii?Q?Xxl2nB8b1M+VZn1DfXaNPrVD+olownV112vNwWEsP5yBnMRt3b2gTVbQhyJs?=
 =?us-ascii?Q?teCTzVOwcHtjjqO1zOBrVkK5l19KxQzYBgxmIaI3hZkp8dHp2GGWTFQMVeOP?=
 =?us-ascii?Q?BoVjwGsAp0UQA7xJnxLQMl7M57nEK2CRxDO4J6LFb1HHUt186arbeqLvrt9e?=
 =?us-ascii?Q?/zvZz2E2m0XkxafEITBcSC/xPgyz3YZhcLbajZ+XqjQykf6kgoBbBjgMY8fr?=
 =?us-ascii?Q?+ESG3ydztGguogCmRXRRm6l7ewWQgJXYtQjEh1TOhYSpX99tJXUppLWpeadE?=
 =?us-ascii?Q?1MJncSPa4yZIrthP9yiX2hF/p5yKeNoE98PKFbYDmmAJOMyFCSty1LXIPa1W?=
 =?us-ascii?Q?vxnTtzciFJ6pH+OvhAil5/x2aUnZ5DqiUBrffD8TP4P39xxhW46wwvBNlgXb?=
 =?us-ascii?Q?HcbH7zIw7S65L4dz6wWVdgyhnjpOnlZdfTnWRzL9wY2FL77iWN/AbfjDJ4XU?=
 =?us-ascii?Q?c0fHeVrd5J4bVs3IRrGNffTDan7Ia4CVccT9aMoVsOkVh9O/OQasOaQNr5Ch?=
 =?us-ascii?Q?dPvdSoTaNWknJe+91B/+GoK/XQSV5/30xf2LraBY2j/vsxm6s34i33y3pEg/?=
 =?us-ascii?Q?9ZLHCgv4Ps324p4ZDKXS5rsBQOikZCBVd13hjn0SMTds0TKIxEmzjDtojPtr?=
 =?us-ascii?Q?rdIVOKcYiomGMMK1h75ppN7XMnhAbU01NpmMKLBoGJ/IaX8TLZnB4YnhleZY?=
 =?us-ascii?Q?W8XGfwS+TxeRXRUcIqtCdNXl9Id00ama3N1RH7DKA4Hj46rHHQW+hWRu9Me5?=
 =?us-ascii?Q?o+44b3ChPF/jmU4f1ZNXTqYXAeDrs4MMwnOLrVfycJvsDLroBWTzcN04WWB7?=
 =?us-ascii?Q?TsXPdKHOmPkb6XLHy8qQW6HMVR3CITEXjhVm3kGwXnbvaCn91svgyIz6YyVV?=
 =?us-ascii?Q?DmHUUfSCJhy4B0fQubt3bxtCjgt2HroZU+UOblNnx9SInZzRJUA20ggilWEb?=
 =?us-ascii?Q?cBLwWAEpFsF9spEtinoSmO0QT1PiWz4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd68088-30d3-4f81-e691-08da287b3314
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 18:24:43.6316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UxJNOLrtQBMwrA28dROz9AH8Grd+PUKLUAbxzSlzW9cA1YYEa4ICsY+j29TR8mj80ZnMfmFvSAOaH35HhFyfMMnixXcgQrauXUpym3ESFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2844
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270114
X-Proofpoint-GUID: UYvckQiX0DxjBrIQGI8YTbyjsDsZjE9V
X-Proofpoint-ORIG-GUID: UYvckQiX0DxjBrIQGI8YTbyjsDsZjE9V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
> On Wed, Mar 16, 2022 at 11:11 PM Stephen Brennan <stephen@brennan.io> wrote:
>>
>> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>> [...]
>> >> I think that kallsyms, BTF, and ORC together will be enough to provide a
>> >> lite debugging experience. Some things will be missing:
>> >
>> >> - mapping backtrace addresses to source code lines
>> >
>> > So, BTF has provisions for that, and its present in the eBPF programs,
>> > perf annotate uses it, see tools/perf/util/annotate.c,
>> > symbol__disassemble_bpf(), it goes like:
>> >
>> >         struct bpf_prog_linfo *prog_linfo = NULL;
>> >
>> >         info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
>> >                                                  dso->bpf_prog.id);
>> >         if (!info_node) {
>> >                 ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
>> >                 goto out;
>> >         }
>> >         info_linear = info_node->info_linear;
>> >         sub_id = dso->bpf_prog.sub_id;
>> >
>> >         info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
>> >         info.buffer_length = info_linear->info.jited_prog_len;
>> >
>> >         if (info_linear->info.nr_line_info)
>> >                 prog_linfo = bpf_prog_linfo__new(&info_linear->info);
>> >
>> >                 addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
>> >                 count = disassemble(pc, &info);
>> >
>> >                 if (prog_linfo)
>> >                         linfo = bpf_prog_linfo__lfind_addr_func(prog_linfo,
>> >                                                                 addr, sub_id,
>> >                                                                 nr_skip);
>> >                               if (linfo && btf) {
>> >                         srcline = btf__name_by_offset(btf, linfo->line_off);
>> >                         nr_skip++;
>> >                 } else
>> >                         srcline = NULL;
>> >
>> > etc.
>> >
>> > Having this for the kernel proper is thus doable, but then we go on
>> > making BTF info grow.
>> >
>> > Perhaps having this as optional, distros or appliances wanting to have a
>> > kernel with this extra info would add it and then tools would use it if
>> > available?
>>
>> I didn't know about the source code mapping support! And I certainly see
>> the utility of it for BPF programs. However, I'm not sure that a "lite"
>> kernel debugging experience *needs* source line mapping. I suppose I
>> should have made it more clear, but I don't think of that list of
>> "missing" features as a checklist of things we'd want feature parity
>> for.
>>
>> The advantage of BTF for debugging would be that it is small, and that
>> it is part of the kernel image without referencing any other file,
>> build-id, or kernel version. Ideally, a debugger could load a crash dump
>> with no additional information, and support a reasonable level of
>> debugging. I think looking up typed data structure values via global
>> symbols is part of that level, as well as simple backtraces and other
>> memory access.
>>
>> I wouldn't want to try to re-implement DWARF for debuginfo. If you have
>> the DWARF debuginfo, then your experience should be much better.
>>
>> >> - intelligent stack frame information from DWARF CFI (e.g.
>> >>   register/variable values)
>> >> - probably other things, I'm not a DWARF expert.
>> [...]
>> >> > Currently on my local machine, the vmlinux BTF's size is 4.2MB and
>> >> > adding 1MB would be a big increase. CONFIG_DEBUG_INFO_BTF_ALL is a good
>> >> > idea. But we might be able to just add global variables without this
>> >> > new config if we have strong use case.
>> >
>> >> And unfortunately 1MiB is really just a shot in the dark, guessing
>> >> around 70k variables with no string data.
>> >
>> > Maybe we can have a separate BTF file with all this extra info that
>> > could be fetched from somewhere, keyed by build-id, like is now possible
>> > with debuginfod and DWARF?
>>
>> For me, this ranges into the territory of duplicating DWARF. If you lose
>> the one key advantage of "debuginfoless debugging", then you might as
>> well use the build-id to lookup DWARF debuginfo as we can today.
>>
>> This is why I'm trying to propose the means of combining the kallsyms
>> string data with BTF. Anything that can make the overall size increase
>> manageable so that all the necessary data can stay in the kernel image.
>
> I think this quirk of using kallsyms strings is a no-go. But we should
> experiment and see how much bigger BTF becomes when including all the
> variables. Can you try to prototype pahole's support for this?

Hi Andrii,

Sorry for such a delay here. I tried to prototype this last month but
encountered some issues I couldn't resolve. But recently I picked it up
and I've created a prototype [1] which outputs all variables. (It's a
quite bad prototype, it strips out some useful logic regarding the
BTF_VAR_DATASEC for percpu variables. But I think it's good enough).

On my 5.4-based kernel I saw an increase in BTF section size from 3.8
MiB all the way to 6.1 MiB, or more precisely:

BTF section before: 3905938 bytes
BTF section after:  6391989 bytes (+2486051, +63.6%)

So almost a 2.5 MiB increase. My prototype doesn't output the
btf_var_secinfo structs for percpu variables anymore, which probably
breaks some BPF and reduces BTF slightly. But it also is outputting
a few thousand "dwarf variables" which were correctly filtered before,
so I think it's a wash and it's a pretty good comparison.

Clearly it can't be added without a configuration option, as 2.5 MiB is
pretty huge for a kernel memory addition. But I don't think it's so huge
that nobody would enable it. I know I would :)

[1]: https://github.com/brenns10/dwarves/tree/remove_percpu_restriction_1

> As you
> said, we can guard this extra information with KConfig and pahole
> flags, so distros can always opt-out of bigger BTF if that's too
> prohibitive. As it is right now, without firm understanding how big
> the final BTF is it's hard to make a good decision about go or no-go
> for this.

Hopefully this comparison sheds some light on that now!

>
> As for including source code itself, it going to be prohibitively
> huge, so it's probably out of the question for now as well.

Yeah, I wouldn't advocate for that.

Now, to share some of the cool possibilities that this enables. I have:
- prototype pahole [1] used for the kernel build,
- a prototype drgn with BTF+kallsyms support [2],
- some small kernel patches which add symbols to vmcoreinfo, so that
  drgn can find the kallsyms section. I'm happy to share these, I just
  haven't sent them anywhere yet.

[2]: https://github.com/brenns10/drgn/tree/kallsyms_plus_btf

Combining these three things, I've got a debugger which can open up a
vmcore _without DWARF debuginfo_ and allow you to print out typed
variable values. It just relies on BTF + kallsyms.

So the proof of concept is proven, and I'm quite excited about it!

Stephen
