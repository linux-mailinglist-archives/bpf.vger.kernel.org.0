Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA735657EE
	for <lists+bpf@lfdr.de>; Mon,  4 Jul 2022 15:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiGDNzz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 09:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiGDNzx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 09:55:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884BAD103;
        Mon,  4 Jul 2022 06:55:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264D2QQF004718;
        Mon, 4 Jul 2022 13:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=6ZgHeDJLTcb1F79LqQgYfku8u136QUmy8kqUY1hfjA4=;
 b=DIThNui+kzSalyYFt+efRrVbCOcYv9iRAT+h8vfNlxLn+gzoCZ80x29X9qL8XX2/hstZ
 O0B++FY60IzyFy/W2ldC1rrcXOwvKcMX0xkt3xXphq82MR2+tX/ByeJOsmXWA/lb3Eze
 QDb6JEqsXJyxeBzei8Xm3MZ4sEEGUgc5u5OFzXmXX7IDoBlaysRsQ9HqOWUFtiLxkeUd
 sHM7OLqgNBTcdRLpYNB0VGGBrByUMVce14AT5CftJLDAUO/6Ik7ay7zqbS0yUMYu+iOu
 82JtCxmmTsXmW9+ENYQNGVO6lSr9UijBHXmekjQ7A82Cb4udNGrO2KtV0UC39qQHWZD6 WA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h2dmsuhap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:55:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 264Dp9aN024120;
        Mon, 4 Jul 2022 13:55:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h2cf1ctg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jul 2022 13:55:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTH5tT9sAUQ+O2Rw1a6PqvmcI8TSCdqO0bw7PB6qHNrtlt655ROtK9oMBv3szIGWNCWMomS488Qp5gaxfr90OcaKUS4PMIFa4sM328S0LQmX7c9xxuTppB9h+yER81YqE39VcobMycncVzgKheMop2OZGSTSAH41beUOTsS07vVUl2zjE3zGOECY87Z3+Y03xfxXOjkpp3XSe/VY7sj8ZDP4SUULGK8snixjglYI2Y1Y9N9shoeYoteKGyrBxe2Grum1nBrJWssupajpaKxm/DE7Pfn6NxTU0C9o2LFtmU2pwfnOJr04phMQErqvmGZrGJSqDuSWlorQXN2NL1pitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZgHeDJLTcb1F79LqQgYfku8u136QUmy8kqUY1hfjA4=;
 b=kUeWkYfuE62C/zxiZCz1O8qku2pmk2vUhjCFrjsxwIi4dsvcnpmwX9ez0AceRF8OXHa3/V33PmPPMMsqxFDGf2IFZ7lGKwT7NR8yqURApXoqtZRMjlAmNBBZ6P8UfaYqJ9HeSmBfarCbhbP+JeN9UuXDw1hX6isL8dDNL2LvOLu7fktSstId9e+ZUtYbFOpPaqpZL9n2QpgMnsu3cXiGkWaBcxxC7DbnJIIljrW7N+tns/WP/AtoTlQYk0lTWGBs/qx0rsWjAmKsn2X1+BmCysTCN94THZoSab6L+q4bqBXoeJt/GOOVWe72oRHdhFCWMa9fJiQE/55Wwl+BoBRmmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZgHeDJLTcb1F79LqQgYfku8u136QUmy8kqUY1hfjA4=;
 b=zuAz6GLUHGVK02lDuZGaJd6pB23VWafL5qNDiv+vBZGnZkcX8y2RoCuER46R603fOnFRczoC0o0QQwspuYt88IbDjBYsh1ji8cfhNBuVXPpW+YoMDgRRRZuHKpWdAuEp3fTIhgLzR1o7RBX7+vuUGn+ES9y9KLxXJqm97HbzPOM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6086.namprd10.prod.outlook.com (2603:10b6:8:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 13:55:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::ec7b:27cb:a958:e05e%7]) with mapi id 15.20.5395.021; Mon, 4 Jul 2022
 13:55:23 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com
Cc:     kafai@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, void@manifault.com, swboyd@chromium.org,
        ndesaulniers@google.com, 9erthalion6@gmail.com, kennyyu@fb.com,
        geliang.tang@suse.com, kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next 0/2] bpf: add a ksym BPF iterator
Date:   Mon,  4 Jul 2022 14:55:14 +0100
Message-Id: <1656942916-13491-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1404e664-4c29-428b-f118-08da5dc4d728
X-MS-TrafficTypeDiagnostic: DM4PR10MB6086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jx7gHcvz48l7ZyQwvmJcWvVLQEjwRUwI8VQcC5TrR1JHmKlRw+JIJM0yTe8R8SQ7vAP5tzEGovKQe4BI/DG/zIv0SEi8+3YKG8rMB1AWDsErjpRZDDuUPbb3HwdgVoRCc7sVmHQ/jzAAJS8gbk7ENAcKlgPQ64krM/+A3BB3z/nXaDPcpgCEEWItoJX29Mh2TGtfZ9DSkY053M7rmqPX5onCnvr7FR81EhS3A+yFZwVXxxDUEk+X8bzDCPvUFYtMBKHED0d40oEyEqBgZoeC6mH74gV+WIv1a5hIoVVBOYT7LmOrq0y7RddhixCjichDMG3Q44LPyaun5ShDdFwwMs3pcet6IOBN9DOt+ncXrx1fRfSJbOm5nK+BSTc8h8aFmdEeZT1d5eG0S99Tx06hLeAxlNFVHXRo3HsIMQfhKGpyyGlVg+ZPKvdEI3qasKmTXBWI/7+uT1B9xbeN0Oeh9uOcapvO5+Hd3ZhO9qrPKCCuLxzSJAxblcC9g9SC/GEGuU+ZmKO3dimOsIzgStTLKXehLrGhswjvvI55VhbKLww9pThJeB3U017vJ4ZqJ/8JIIxYfUeOcmuBQGTOeS4tzmnM8HdjScPMtnoL58PWZSyhsODAn8TwoBT8eJRLut5n/lKOnHwk+9Tl56cAZgIw/e5vmemTZKHAyJRnsDPZ89L72w8XKSJRyWFqoxsUUTPC9+WxmQU8H5jCdfyQ94ROt3w83/2jHkQP4HxABl/Q/OochJrR48YwLfoagDYphTggYXQwF7hi/CSbQUB92OjJNdmURUoXW49CJCdVXmHSViA7s/DUfqsO97fvm2kSbDl10+m/xgTqZYzLTUkTUwBfswqD6Hrahi9d2gUAk8CQlLNBydoNyTrZwdkEaSmzjOpi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(39860400002)(136003)(366004)(4326008)(6506007)(8676002)(316002)(66476007)(66946007)(66556008)(966005)(6666004)(478600001)(41300700001)(6486002)(8936002)(7416002)(44832011)(2906002)(5660300002)(38350700002)(36756003)(86362001)(2616005)(6512007)(186003)(38100700002)(52116002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A+YKRurjq+8aYe+oQqwa1Cm2kIawST5lCp9wG/rfJij554a4MhZLNtQhcihY?=
 =?us-ascii?Q?YBkUuDMvc3Rv4omLhIk4ISUsbBNucW/gJRK1n3ey4jxJ9X3KziU/Q7jtY5YT?=
 =?us-ascii?Q?N6dzJvXloS5AkHuxDP9xBrt63C9TxmaBYalB5wL2Q9jMVLu2y/Ooug4s+aCo?=
 =?us-ascii?Q?6hq3Ljfyhb/Foutoo5VHIT8OyfzDAMKAZhmH6X/EP6senCf0XOeR15Ex42mA?=
 =?us-ascii?Q?5iEFgA/yMByi9cxD/hH2LdyM6isQjW00/hF+yTeSb9mD47NDRtd5D7UicdIm?=
 =?us-ascii?Q?SCy3ndzSTNxjMAlOsfzuK502KsTc699aHTeKQTtTwt+iX4GUU6XnSToXSp6A?=
 =?us-ascii?Q?FcPLjDcBuriWh1sbKRBHhOvYk1uzu7rJS/1FIltaeabbeTLXL02yLx+JQX/y?=
 =?us-ascii?Q?qOpjRNjgXyD5cgVcYQQlr5epLBupWG4oogcRGnfHiI39j57Dt6XaWv2MX5nj?=
 =?us-ascii?Q?Ldbk6mQnF0ORWmRd4V0ciq9jKYMgsvFQpsO1JnUV6F8JnC2xjP5swJ/8O+8w?=
 =?us-ascii?Q?MVhzZltjwSB71bPrzc0yW/LfFbEFvb47loASnXcCFNSdiZzVcdSbP81TUD1R?=
 =?us-ascii?Q?+gytAp632RPKFjfSnqJYr7ys0m6AUmjM3aw2thuRgN60vtUFt/Ls/z6xhDuC?=
 =?us-ascii?Q?jCq/uokxHEH2cPmGvPWNnnkCHkEscIQ5HdbyKVhQBGbq15Tt+1xwDS8vNmxW?=
 =?us-ascii?Q?c93Kz2dD8DUBheIR3mAVsFFYPluwLSdGDV2Gqcuo+mXwL2S0F3gYEUKgkD/m?=
 =?us-ascii?Q?fzEtcwSKZLjD1b/q8AhsKork4otFOvlI1zcGPv+Uu7WHLCK6qcf/Spk1wy/A?=
 =?us-ascii?Q?Yv7EVT81Lu4l6gtY/wr0DhTtodY1chHDCGHuRkx/lsPeJWMH7y2+fNRy/U89?=
 =?us-ascii?Q?Bz8MWkHtV43zWnXA1mD9wvTIJV3ljG6yU/uNXulVA4TCkscC413QVvbaOKRw?=
 =?us-ascii?Q?FhT2/XddRAgJC6s5VSk4l2/Pu00ZO9PTLZHBl/+C04Grq67DhNMLWUqlvIYv?=
 =?us-ascii?Q?y2f/hMZLyMrgAQRZb/CA88D922AEaa/XiM/fRb/YF7lBh81YObKpP1nytVKk?=
 =?us-ascii?Q?S9yavKFqFt62g8Z/Ckd6vNGNN4SILD190CRXVbv376akQfBKJhzNUtJ71uCt?=
 =?us-ascii?Q?ceeCQ4v+LDNLy27lgGvnxR3g1bPI17VSLJ9FQ72iTeY9h3r02JonOj/viW3j?=
 =?us-ascii?Q?GY3WFpGQFHO4WjmWA48gyUCubeWe/SwSmISGLAt2ZHAr5EQL811SAH0Zq3a8?=
 =?us-ascii?Q?KqH/vL2571JeA2JjYdDAnM2Wcx9/05MrMgOPrrHnccDVegHwHft1HBU4Mhg5?=
 =?us-ascii?Q?bv9AX7yqk4CddxrzL9rp5mIMaU0Iug1GNHaS6ZYxniljI1GNXPklg5t3BJ7M?=
 =?us-ascii?Q?TBuPJgPyXW3/UA5OFQtWUvVi784ErwED95IwKBYziz/Gr/kIdY/gwpFE0mux?=
 =?us-ascii?Q?FQBdqPM+R3XGpluv9blWsME47uakklFS1HahRhHF5mfAQwJCV46Vaz8itnfq?=
 =?us-ascii?Q?dX0JvYT5mgsmTLU1TGOX3QRiMyUib8p+mVB+aXGVqow2hu98r59RClDTlqkh?=
 =?us-ascii?Q?rupY+yRsZCIHOsGj0IQGQJfpgX97/rvCvAocVyXk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1404e664-4c29-428b-f118-08da5dc4d728
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:55:23.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6XGmwUcZfiiHGYAl60GJ+2/N06xymhaRvWLkJvXtbBMi6J5ooSAbcP0z0iMxCUhnYKGwp2pfzkdLGJ1ErsexA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6086
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-04_13:2022-06-28,2022-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=918 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207040060
X-Proofpoint-GUID: aVj91f9cXdbh7lHxhkJe61NsIRjvkSgR
X-Proofpoint-ORIG-GUID: aVj91f9cXdbh7lHxhkJe61NsIRjvkSgR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

a ksym BPF iterator would be useful as it would allow more flexible
interactions with kernel symbols than are currently supported; it could
for example create more efficient map representations for lookup,
speed up symbol resolution etc.

The idea was initially discussed here [1].

Changes since v2 [2]:

- set iter->show_value on initialization based on current creds
  and use it in selftest to determine if we show values
  (Yonghong, patches 1/2)
- inline iter registration into kallsyms_init (Yonghong, patch 1)

Changes since RFC [3]:

- change name of iterator (and associated structures/fields) to "ksym"
  (Andrii, patches 1, 2)
- remove dependency on CONFIG_PROC_FS; it was used for other BPF
  iterators, and I assumed it was needed because of seq ops but I
  don't think it is required on digging futher (Andrii, patch 1)

[1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
[2] https://lore.kernel.org/bpf/1656667620-18718-1-git-send-email-alan.maguire@oracle.com/
[3] https://lore.kernel.org/all/1656089118-577-1-git-send-email-alan.maguire@oracle.com/

Alan Maguire (2):
  bpf: add a ksym BPF iterator
  selftests/bpf: add a ksym iter subtest

 kernel/kallsyms.c                                 | 94 +++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 ++++
 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 74 ++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c

-- 
1.8.3.1

