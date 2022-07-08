Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2C556B8FE
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 13:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbiGHL4M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 07:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbiGHL4M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 07:56:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3403C9A6AA
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 04:56:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268B87rC032242;
        Fri, 8 Jul 2022 11:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=EwmafJj0BnRYoZoD8zKu86PICL1OjIV56O19jN3ihoQ=;
 b=cIQDFfoQTWx4NehgdwOoh6/ua54w1oVhVrJhC95741GubO1QwWoe0OtwuEBVyVa/nPmj
 +1LiQmZzc/NjhODFMbZpfbopHg/vKEGtly6C/D35TAr7Ml7FtUvEZBPJl1wkA3I9ufjl
 5wGbByS0SG0a0X/GHOLVEaQfXJNoT5Iq22WVds59yl7SRtCROMk3Y1CKL5LM2o/eLp4e
 H0wTY5zx03+L3RVl/s+Lf6OhimIZLZQDM9r1sdzefJq4VZpy567s1ubLXHWXC6WLERUF
 3Rg0Qa9q4ZCGXPngxE6np89AAlF9o7G5axirHDYY1NPNIfwwi3yWJ0yD09XWfcA2bw15 gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4uby7wc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 11:56:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268BnvH9002463;
        Fri, 8 Jul 2022 11:56:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud9u7v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 11:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYER+XZqY6i4Zi9sr52vgFBE08vG5dV3PzS94Y5UGx3bok1MDyC6elc7tK6+yXHfRyL9kFoUi89t8MGX6RxmEOFfQ+Rs7HpXjp48VoiRP0S4u9XEL53viRTMKLMEUvHwBeW1RWrSxJeWOBDTM5xZdIuZDXxqumB8YxHLVZkIZQncuz047fdOwafITc8N2SoIjeqqKxMCMtRC1b3eBd775cwLnlN9SKQJmiHG7gdMUQGbq3EfOiTQ5I9L6cV3Sf+MZwA11TF7rFp0wX+DnC69T00VOJ1nSLd3EtBx7sGSZvkNhwNAKAZa/nNb8L1zn12Y3eUJnPLfMyXG43IrJsgLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwmafJj0BnRYoZoD8zKu86PICL1OjIV56O19jN3ihoQ=;
 b=Ue60FZ7tmsyHADOVBP31nWQjOKpN5vNzmfO2cwaaKQvpLcALgHE82lZAK+tyt1x9FpHiRypz9Q/V6Sx5beyzY6CyOcZJ/3kpwp5KR6B6r9/cRa1UnJubml13IfeRZMbfaemZ5MRqvO/FO11eeaX8+CveJNr7LU/1VbmWmK4pw1qBI9HBP1Z3IpmxzrKU5ej/4LH9VRh/u34+ujUxgKXrT7tNQWesDxTIjCeBAKyZCna6h1tvaY/3bGOWi5SXG+lyivzf99kWxc12YzGAwgb+EEFLIVYJ3yj8b98DJJ2LliZ4PrKtAugMqi0SrvQ6h/sb3a7Nah5jXhvN+8XjOR+tTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwmafJj0BnRYoZoD8zKu86PICL1OjIV56O19jN3ihoQ=;
 b=CrDiA/BNgfbuLGznswLtA2CmjFgk7XXyw/ni16mYc4bhha/wzGm6RIROooUM4mzd2gbGCf1YPmrJ7DSOULZQ85rFFROvkggONY202QsbMhoaAJKUqs+k2VaaUfO1ZDUIadSbobs5OPNySsd/MmDZiNYVGLgzWVCCYl+vx05DpRQ=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CY4PR10MB1351.namprd10.prod.outlook.com (2603:10b6:903:2b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Fri, 8 Jul
 2022 11:56:05 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::287e:5ffc:d595:8316]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::287e:5ffc:d595:8316%6]) with mapi id 15.20.5395.020; Fri, 8 Jul 2022
 11:56:05 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
        <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
        <CADvTj4rfDAFj0MAVyo=jaBG85MTgHcXi75_cRsby1LXTk7FgfQ@mail.gmail.com>
Date:   Fri, 08 Jul 2022 13:55:58 +0200
In-Reply-To: <CADvTj4rfDAFj0MAVyo=jaBG85MTgHcXi75_cRsby1LXTk7FgfQ@mail.gmail.com>
        (James Hilliard's message of "Wed, 6 Jul 2022 11:49:01 -0600")
Message-ID: <87let3es35.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::18) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2a14e3a-7c61-4452-810e-08da60d8d62e
X-MS-TrafficTypeDiagnostic: CY4PR10MB1351:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n96UpZQjuSY0jzR4dStTxRIClNudMCEhlp28B0GfpWCxVI79+e1y0PsHh+JjoiS41fHnCBYHjDNtegeraeAn6j8Fagh665VMXexnWLglPe7YI0B09WSbaK5LGznaCZ+DIclfk3JNFXjz4B3L/1MEmlIVI0Qy5D/G4pFugseAijJxIQuP8fkSb4AamERifODZm8IPSBbXf4GuQijycfvV6nGmYwX+bweuq3cPDR6aI+5pxCPfS3m8erSV5VrddmJe5OGnDVISHG6PLe4Nzee8QYzCOP0BztEc4/JbODQ89fSHPwXa8qn4PolAAjBdhkxRD9p9miarj4MksWPkGpiAFXaW9V4eZ4irEKFZakH7Get5VAwRHWSSVwu8uSxJmL6S+2WL5GJIE3bT68iaxBDNMqFHqBZbkU/d1Db+PWEKfs6fKtiR9zu+7aNm1e1lXC9I3O2CB6/tBoLBsWP8WzfLhDpg/YbjQglVusmP32uKgbNdBB4fhBGkLsGS174/tlUjz0h3lyGY5+rtTFRoNPoJ0VveyOjJbxXwa1m2cFDH2QUHObwkJO6e4BleC9GDu3PbI4NUwCG1ID+b1HCdD07JxNikr7z/bCZvGM6IYjwZmHl+f0VQzz/Ke2yQ4HEU9sXnIGqEIdBz+9wTrS8sn5EdH4dcRXHhWDT9tsIvDOs4OiCKaOYrvuwL5fCWcpmC381YoCmdZ9Ol6QnqmrYpu5wJYmD4hUxL3gphHTr4NRAbYjHj3fx29QCtDGoEmTMXYenTVB6DhbCGIWjD8saNiaqOr6taL+1Vz1w5aU67HDFUl2uF9vsuewoZN2bACpThQolfd98DdNJtkW9sY7tVATy82BA+BvkYwE7Je9HdWdHftP0W3UfeiIv8A+aZvfgeJ8uq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(39860400002)(396003)(376002)(136003)(53546011)(66946007)(52116002)(8676002)(4326008)(5660300002)(41300700001)(478600001)(8936002)(66476007)(6666004)(26005)(2906002)(66556008)(86362001)(316002)(6512007)(966005)(2616005)(6486002)(186003)(38100700002)(6916009)(36756003)(38350700002)(54906003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BAN2ZoAzG0/nfG5OgY9Je/Opked+V7ugVrz9PmstWPFfKt4ugH3NyUctrdyU?=
 =?us-ascii?Q?aCNk86zD3Zk9vageMqNd4D0ntTL8V/XWc718JEiUzbCa7GjLpV+p5l5rCbTc?=
 =?us-ascii?Q?V+LJwjLj9tZUNwOf9rQ7yCv+Fmex+kGcqwPIVRb9RSPSQimQhoELsaBWmsNJ?=
 =?us-ascii?Q?3UMn2SvrFRprGUx0yuxXwbba67W1NMsfZQwvFa7FNoOzem9iEjNritGq7sp8?=
 =?us-ascii?Q?HoiOyzO9e6tOJb93GID/ZDrJiLkO4xLN89c/G1OtLS6e8UDboj5I9yiydsxb?=
 =?us-ascii?Q?RbmXZ2RUnxRKaVC5rkMBu4HmKj1megc8Y46z1FIfqKUFrz6ur5iewQwubM1k?=
 =?us-ascii?Q?RbuXVMy7mJGUPg23dafPFhuMQmq3JNeKEACtjBQVsifgadNVKV6CzvofPnY0?=
 =?us-ascii?Q?eLlBcy6epzfuveuRCOLpLA2V5Uc3bBIRyXLpN1pzaOAxX9DHH4l4cuL9aXC9?=
 =?us-ascii?Q?Lljbb+P02D6CHAiXvqDqWh/J8vewa0xin3l1Q0Z7H4Yb3MVrgTOlbKKmJesR?=
 =?us-ascii?Q?oK5bVHJP3QwdJx29JUcmBKSSDBrOdSl6llG5y3K2X7H+UsbJGbkRBQLIOcJI?=
 =?us-ascii?Q?DOTefRDNJGoy9EORocbeLQp6q1lFEsRuLtgceabO2gy7C5ZeL3Te5gbY/keP?=
 =?us-ascii?Q?6Y/EuLnCTVGfl8a0VDNLMRzblOldzkXorl/xpai4CyPSl4GMNOzEexGIZo66?=
 =?us-ascii?Q?va+0OBc13I4YaNAGYSsbd6VfS26fFvuojK2N6dOtgetuuKqOdC5odgnfCfLW?=
 =?us-ascii?Q?bD5xi/3N6yVvLARVeXk2GmJCj/btbzXShoG2Fi4uHpKExx+eIlUMqL/9jzkg?=
 =?us-ascii?Q?tn6FM9Fr40XiGNFyagJrMhHV4Ir/+nPncbnaLXv+XSm5mbk5q+h88iPsTyiY?=
 =?us-ascii?Q?EeBFwhlgCo7P5X7ZQf6kI9jmmpY0kQWbeDGlDMdbto7sOzaXE3kPjm4F0P6u?=
 =?us-ascii?Q?rTj5a7gPIl/ATsUyeS7kJMbI4u7YsNnQi+9OkstdQO4voS+KhUPL27g/QaVD?=
 =?us-ascii?Q?kZlXkNuSnpBo71+m43ekUtZHwAYCmHvTdU7pTX+QJRdcNfAR3uhpvl4yKROH?=
 =?us-ascii?Q?QqDxDoyhkuttFbr5yIKEjYFcOq8Gu6hhEX7bYBGgJ88AALOEP90F1t9TtKVN?=
 =?us-ascii?Q?UehvnYH9xMc/us1YHNSKY77z273lEJ9aIZ+y80M4ZjTBQzSwQD9kA0apW8ZM?=
 =?us-ascii?Q?amISGzfTv/DWT/xxFoPlQfyZQg3Y6CfimUH95Up8hfbxdrxfZURwtvSX1Tw4?=
 =?us-ascii?Q?GEMwUJAw3C0nHlPj/9zaCctT8JJMejTaxR+Y3M5GuVUA2CxcZ2AuA5CSw7tY?=
 =?us-ascii?Q?7ksQvDu0AYScBHS+B3JPJ43zBnd/limBWHLm9C2B/KbwcgzR87rOUOc01qSd?=
 =?us-ascii?Q?fS2hojMQEF9D0QYa/wlLTU5rg/09PN+KTDVOgdGzWBV4m84l5EBUSqpzGsbS?=
 =?us-ascii?Q?d/i/mpP8heKdAcyv2Cri7sxS5S8oLRtfb1ucnzG6lgWac6vx0H7OA3A071hP?=
 =?us-ascii?Q?TDh29gDxWT35qVtZDw3JF186/aJ2QMGEfgx50Wv/J+L+go+ppwa7ikE5ESg7?=
 =?us-ascii?Q?SJ+qMclGDN3CPMGkMPap1A74S14fW1acmvLGBWV3SMAiYkIZke/EbbxLpiRw?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a14e3a-7c61-4452-810e-08da60d8d62e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 11:56:05.0483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Za2sDtuqJAoEwMK57isUk11UAgHJx5LUhjhrUaeo/AxYiXy4yrBYCj+A0L0Vxu6/4bJvFel56Aw8r/KDYNfHK72kPcxTmcZIVuTregCCkyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1351
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_08:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080044
X-Proofpoint-ORIG-GUID: FUp9dUPk5DqNWSxF5DU1k7QyH3P-zTj7
X-Proofpoint-GUID: FUp9dUPk5DqNWSxF5DU1k7QyH3P-zTj7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Wed, Jul 6, 2022 at 11:20 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
>> <james.hilliard1@gmail.com> wrote:
>> >
>> > Note I'm testing with the following patches:
>> > https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
>> > https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
>> >
>> > It would appear there's some compatibility issues with bpftool gen and
>> > GCC, not sure what side though is wrong here:
>> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> > gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> > src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> > libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
>> > Error: failed to link
>> > 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>> > Unknown error -2 (-2)
>> >
>> > Relevant difference seems to be this:
>> > GCC:
>> > [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>> > Clang:
>> > [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
>> >
>>
>> GCC is wrong, clearly. This function is global ([0]) and libbpf
>> expects it to be marked as such in BTF.
>
> Does this invocation look correct?
> /home/buildroot/buildroot/output/per-package/systemd/host/bin/bpf-gcc
> -O2 -mkernel=5.2 -mcpu=v3 -mco-re -gbtf -r -std=gnu11 -D__x86_64__
> -mlittle-endian -I. -idirafter
> /home/buildroot/buildroot/output/per-package/systemd/host/x86_64-buildroot-linux-gnu/sysroot/usr/include
> ../src/core/bpf/restrict_fs/restrict-fs.bpf.c -o
> src/core/bpf/restrict_fs/restrict-fs.bpf.unstripped.o

Hmm, why linking a relocatable ELF instead of just using a compiled
object (with -c)?

> I've also tried without the -r(relocatable object) flag but that gives
> a different error:
> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
> libbpf: unsupported kind of ELF file
> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o: no
> error
> Error: failed to link
> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
> Unknown error -95 (-95)
>
> GCC without relocatable flag:
> [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
> [3] TYPEDEF '__u8' type_id=2
> [4] CONST '(anon)' type_id=3
> [5] VOLATILE '(anon)' type_id=4
> [6] INT 'short int' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
> [7] INT 'short unsigned int' size=2 bits_offset=0 nr_bits=16 encoding=(none)
> [8] TYPEDEF '__u16' type_id=7
> [9] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [10] TYPEDEF '__s32' type_id=9
> [11] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [12] TYPEDEF '__u32' type_id=11
> [13] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> [14] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64
> encoding=(none)
> [15] TYPEDEF '__u64' type_id=14
> [16] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
> [17] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
> [18] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
> [19] CONST '(anon)' type_id=18
> [20] TYPEDEF '__be16' type_id=8
> [21] TYPEDEF '__be32' type_id=12
> [22] ENUM 'bpf_map_type' encoding=UNSIGNED size=4 vlen=31
>     'BPF_MAP_TYPE_UNSPEC' val=0
>     'BPF_MAP_TYPE_HASH' val=1
>     'BPF_MAP_TYPE_ARRAY' val=2
>     'BPF_MAP_TYPE_PROG_ARRAY' val=3
>     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=4
>     'BPF_MAP_TYPE_PERCPU_HASH' val=5
>     'BPF_MAP_TYPE_PERCPU_ARRAY' val=6
>     'BPF_MAP_TYPE_STACK_TRACE' val=7
>     'BPF_MAP_TYPE_CGROUP_ARRAY' val=8
>     'BPF_MAP_TYPE_LRU_HASH' val=9
>     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=10
>     'BPF_MAP_TYPE_LPM_TRIE' val=11
>     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=12
>     'BPF_MAP_TYPE_HASH_OF_MAPS' val=13
>     'BPF_MAP_TYPE_DEVMAP' val=14
>     'BPF_MAP_TYPE_SOCKMAP' val=15
>     'BPF_MAP_TYPE_CPUMAP' val=16
>     'BPF_MAP_TYPE_XSKMAP' val=17
>     'BPF_MAP_TYPE_SOCKHASH' val=18
>     'BPF_MAP_TYPE_CGROUP_STORAGE' val=19
>     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=20
>     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=21
>     'BPF_MAP_TYPE_QUEUE' val=22
>     'BPF_MAP_TYPE_STACK' val=23
>     'BPF_MAP_TYPE_SK_STORAGE' val=24
>     'BPF_MAP_TYPE_DEVMAP_HASH' val=25
>     'BPF_MAP_TYPE_STRUCT_OPS' val=26
>     'BPF_MAP_TYPE_RINGBUF' val=27
>     'BPF_MAP_TYPE_INODE_STORAGE' val=28
>     'BPF_MAP_TYPE_TASK_STORAGE' val=29
>     'BPF_MAP_TYPE_BLOOM_FILTER' val=30
> [23] UNION '(anon)' size=8 vlen=1
>     'flow_keys' type_id=29 bits_offset=0
> [24] STRUCT 'bpf_flow_keys' size=56 vlen=13
>     'nhoff' type_id=8 bits_offset=0
>     'thoff' type_id=8 bits_offset=16
>     'addr_proto' type_id=8 bits_offset=32
>     'is_frag' type_id=3 bits_offset=48
>     'is_first_frag' type_id=3 bits_offset=56
>     'is_encap' type_id=3 bits_offset=64
>     'ip_proto' type_id=3 bits_offset=72
>     'n_proto' type_id=20 bits_offset=80
>     'sport' type_id=20 bits_offset=96
>     'dport' type_id=20 bits_offset=112
>     '(anon)' type_id=25 bits_offset=128
>     'flags' type_id=12 bits_offset=384
>     'flow_label' type_id=21 bits_offset=416
> [25] UNION '(anon)' size=32 vlen=2
>     '(anon)' type_id=26 bits_offset=0
>     '(anon)' type_id=27 bits_offset=0
> [26] STRUCT '(anon)' size=8 vlen=2
>     'ipv4_src' type_id=21 bits_offset=0
>     'ipv4_dst' type_id=21 bits_offset=32
> [27] STRUCT '(anon)' size=32 vlen=2
>     'ipv6_src' type_id=28 bits_offset=0
>     'ipv6_dst' type_id=28 bits_offset=128
> [28] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=4
> [29] PTR '(anon)' type_id=24
> [30] UNION '(anon)' size=8 vlen=1
>     'sk' type_id=32 bits_offset=0
> [31] STRUCT 'bpf_sock' size=80 vlen=14
>     'bound_dev_if' type_id=12 bits_offset=0
>     'family' type_id=12 bits_offset=32
>     'type' type_id=12 bits_offset=64
>     'protocol' type_id=12 bits_offset=96
>     'mark' type_id=12 bits_offset=128
>     'priority' type_id=12 bits_offset=160
>     'src_ip4' type_id=12 bits_offset=192
>     'src_ip6' type_id=28 bits_offset=224
>     'src_port' type_id=12 bits_offset=352
>     'dst_port' type_id=20 bits_offset=384
>     'dst_ip4' type_id=12 bits_offset=416
>     'dst_ip6' type_id=28 bits_offset=448
>     'state' type_id=12 bits_offset=576
>     'rx_queue_mapping' type_id=10 bits_offset=608
> [32] PTR '(anon)' type_id=31
> [33] STRUCT '__sk_buff' size=192 vlen=33
>     'len' type_id=12 bits_offset=0
>     'pkt_type' type_id=12 bits_offset=32
>     'mark' type_id=12 bits_offset=64
>     'queue_mapping' type_id=12 bits_offset=96
>     'protocol' type_id=12 bits_offset=128
>     'vlan_present' type_id=12 bits_offset=160
>     'vlan_tci' type_id=12 bits_offset=192
>     'vlan_proto' type_id=12 bits_offset=224
>     'priority' type_id=12 bits_offset=256
>     'ingress_ifindex' type_id=12 bits_offset=288
>     'ifindex' type_id=12 bits_offset=320
>     'tc_index' type_id=12 bits_offset=352
>     'cb' type_id=34 bits_offset=384
>     'hash' type_id=12 bits_offset=544
>     'tc_classid' type_id=12 bits_offset=576
>     'data' type_id=12 bits_offset=608
>     'data_end' type_id=12 bits_offset=640
>     'napi_id' type_id=12 bits_offset=672
>     'family' type_id=12 bits_offset=704
>     'remote_ip4' type_id=12 bits_offset=736
>     'local_ip4' type_id=12 bits_offset=768
>     'remote_ip6' type_id=28 bits_offset=800
>     'local_ip6' type_id=28 bits_offset=928
>     'remote_port' type_id=12 bits_offset=1056
>     'local_port' type_id=12 bits_offset=1088
>     'data_meta' type_id=12 bits_offset=1120
>     '(anon)' type_id=23 bits_offset=1152
>     'tstamp' type_id=15 bits_offset=1216
>     'wire_len' type_id=12 bits_offset=1280
>     'gso_segs' type_id=12 bits_offset=1312
>     '(anon)' type_id=30 bits_offset=1344
>     'gso_size' type_id=12 bits_offset=1408
>     'hwtstamp' type_id=15 bits_offset=1472
> [34] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=5
> [35] CONST '(anon)' type_id=33
> [36] PTR '(anon)' type_id=0
> [37] STRUCT '(anon)' size=24 vlen=3
>     'type' type_id=39 bits_offset=0
>     'key' type_id=40 bits_offset=64
>     'value' type_id=41 bits_offset=128
> [38] ARRAY '(anon)' type_id=9 index_type_id=16 nr_elems=1
> [39] PTR '(anon)' type_id=38
> [40] PTR '(anon)' type_id=12
> [41] PTR '(anon)' type_id=3
> [42] ARRAY '(anon)' type_id=19 index_type_id=16 nr_elems=18
> [43] CONST '(anon)' type_id=42
> [44] FUNC_PROTO '(anon)' ret_type_id=36 vlen=2
>     '(anon)' type_id=36
>     '(anon)' type_id=46
> [45] CONST '(anon)' type_id=0
> [46] PTR '(anon)' type_id=45
> [47] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>     'sk' type_id=48
> [48] PTR '(anon)' type_id=35
> [49] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>     'sk' type_id=48
> [50] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>     'sk' type_id=48
> [51] VAR 'is_allow_list' type_id=5, linkage=global
> [52] VAR '_license' type_id=43, linkage=static
> [53] VAR 'sd_restrictif' type_id=37, linkage=global
> [54] FUNC 'bpf_map_lookup_elem' type_id=44 linkage=static
> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
> [56] FUNC 'sd_restrictif_e' type_id=49 linkage=static
> [57] FUNC 'restrict_network_interfaces_impl' type_id=50 linkage=static
> [58] DATASEC 'license' size=0 vlen=1
>     type_id=52 offset=0 size=18 (VAR '_license')
> [59] DATASEC '.maps' size=0 vlen=1
>     type_id=53 offset=0 size=24 (VAR 'sd_restrictif')
> [60] DATASEC '.data' size=0 vlen=1
>     type_id=51 offset=0 size=1 (VAR 'is_allow_list')
>
>>
>> https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50
>>
>>
>> > GCC:
>> >
>> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> > [3] TYPEDEF '__u8' type_id=2
>> > [4] CONST '(anon)' type_id=3
>>
>> [...]
