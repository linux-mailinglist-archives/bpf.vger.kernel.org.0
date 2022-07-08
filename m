Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5262056BB1E
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbiGHNqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 09:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiGHNqj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 09:46:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D552CC95
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 06:46:38 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268B8AWi032559;
        Fri, 8 Jul 2022 13:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Rvcxbh0+APYNTg3rbx9A7F1S05mSlfK91ri/RJYJdI8=;
 b=nyOUDdFz8FKB+oZn7eEXX+j7v5fdaKinz5JZ+/i9GvLL/zXASqDzZ+EkU8ZOufMBfvT2
 eK4Cvr78GlsUHJptwOR5I1WCMqPbabCgWgMhVs7vJErPYLDGLIJHpZzMbHPdsvJ7q6XI
 Dqw/kkgymtwq6TyPlXUBVMR3d5Dbv+owo2RcrLG58lxLv1ckqpvuh08Bwx4bSehhoJnc
 +5A9ad2i4W71gaFPcVFCTc8DhU1Re3XSKDVtfSWGasWTtkfXrVbmLnZwhpvOel0/jld4
 uLxF65P6WymvIxb+PFVnxjZBaACZcYniCb9b+V9aFFMSQSEa+K74yIdu60myqIJW2Vks CA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyr69m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 13:46:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268DeEpn017579;
        Fri, 8 Jul 2022 13:46:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud7pg0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 13:46:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn7IG0JSImgLhWk7CtwK8GsjwQvslyFfFcdv+ne6LoccGifV6T9L5T3wh6ylj9rosaOVRlkIWGSnmQTz3PBgKsi4dkg/DiOYbBwuxwnocWtFAuE//F8W9bR2Q7xh1i7MxFMuMvBVbij6qxvo7k2kqCMQ1Ndbe/3hhq7+RNbM6jMjvpQ8C73WSAa3KzZsCMx5NPNCBeFUpYieEm5zRl4xlmSwH7fXC7AL21IESDfNs6I5t75gV33Pz0CDObqes10osasmTra26Ely0HYu5FCvJy3mYqWMxErhXXWfzK/4U0JrSJO3Zwpbnv9ByGFLC+Y/MZANREQs69iIxk17VSJfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rvcxbh0+APYNTg3rbx9A7F1S05mSlfK91ri/RJYJdI8=;
 b=JIy6q9Cve1Ioz0jmgLOTFPnPntIVP6kI+XQNpPDO2UjRv5EUng8UDOo8Qr/PnWH+W4xzb2UCL2wM1OdlXNij0vMVlhF4hr0NmTpHfVHhNBZ/0Pp5RA5DkY4A8jCWGM/E5Bli+5LOx1yYjBJ82/Pv2213zZbX1NRrQqozvLho+p3mrqhYcK0iU46ufALUE2a65F67ce+kVsw37qeyqyttGqN2uOHfNTFPLAx3opQLNIZBBbQm4YbzOWFJ9T1DYkXgtB04qYjdnEt6OiFSD8cJjMpxEe7TstRxn3vSHm5NRkgbWod3BDEBNP6L9b1FpUNP5sDRPX4FH9FOTpa9EH0TWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rvcxbh0+APYNTg3rbx9A7F1S05mSlfK91ri/RJYJdI8=;
 b=ZUC0N2DbZ3RTiW4xEUL9IZ8zza80ZaWEyE+A6YDQOwtKk76+SPitJfLvQkVsX9UbzPMR86rqi2WDi9+Hh/OCIzKO75ZAzcYdPKWNvxApKuXgtX7UY1R3R3WDS/CF6D0oHD+Wkr6w7vhht60YYtfFO3xBnrZ/5udm0Limfq3WauE=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by MWHPR10MB1375.namprd10.prod.outlook.com (2603:10b6:300:22::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 8 Jul
 2022 13:46:33 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::287e:5ffc:d595:8316]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::287e:5ffc:d595:8316%6]) with mapi id 15.20.5395.020; Fri, 8 Jul 2022
 13:46:33 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
        <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
        <CADvTj4rfDAFj0MAVyo=jaBG85MTgHcXi75_cRsby1LXTk7FgfQ@mail.gmail.com>
        <87let3es35.fsf@oracle.com>
        <CADvTj4qZANp7CxJnM_AoFcvRQpnXC0nmTagNgnnzkGMSLKeH+A@mail.gmail.com>
Date:   Fri, 08 Jul 2022 15:46:24 +0200
In-Reply-To: <CADvTj4qZANp7CxJnM_AoFcvRQpnXC0nmTagNgnnzkGMSLKeH+A@mail.gmail.com>
        (James Hilliard's message of "Fri, 8 Jul 2022 06:23:04 -0600")
Message-ID: <875yk7emz3.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0106.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::21) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61fc5c93-b275-4424-a519-08da60e84506
X-MS-TrafficTypeDiagnostic: MWHPR10MB1375:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qq78EAppybUKjgWnZmKPgQTXWiEZxy1P9dTX1Idaots2QzUuPWovS4MynySrsbZox6u/6ypXgvqupLQe+aYT5KhFdCRPlUKC/s/LAj53Lfef7y+9IqRnVxEXLNWVNZgtgo3MwHzCBzqGB7TY0HxUNCgms91wHr3G8e5CVKmCXpEywdFIfqNdY0mdWGHGoa83x+pLGJ/qkFQ4YcAJQ4WPQoIkRdqJgP88U4ne31WnIlliPQQU1YdiPn9E6o312aYO+7U6E/5K5DHMkpQEJ7K+lWYGV/F2CkXygIHZTfgV3yb/HMvsGsBZbD688gl4pkS8zA5LUy9+5cVTq0glvqqVWRxeZ400ZlfQpv8cegWNYVphefB65Wa9K8EMI2co11mph/W3v8MYbOILj6Tb7EiFYU1csINSA8DmHGl3sY8vKJo6p4riv3pxAGx5QcARlsWY+8TuQS90tdlELbnw6jb9dWVveAtA5YurRPbmY3TnPVOfiWD4ggm3N6WgYgFFoCsS1cJV6KaQX4mTYz7aq3zvM3AJ/NMKUjVhwJFDdIo2OdBgYyjEOhsbCDylZOHM1R1Dz5cz+/dolFrlPF8Ptp/+1HZO0huCCndl+eJlqsUMo8cptiEDhjnT0oaCsGAKEoRxG3J6NSAefAcvfAdXJX3lXTMI8waLgmSuoa4angdfT34M30hH1F9bzUwL9dz62T33I7Kq/vfHom7v5s7LTUhd78yOSV4JBrf5yzNPK0bnZdtWuiUUGYmASFy1t3PZ79vc11uZPHnSj9ZiXJYYe4m1nvDXH/NH7xzuk3PLswo74jhRcSal3QOiRD6GDv8EfzXCSkc2FZcI2HOmyffKNXMUjsA2TiVQFowc7GvTDO5xmL7teP7SDMhOSYezONLhWJNn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(346002)(136003)(366004)(53546011)(66946007)(4326008)(8676002)(5660300002)(41300700001)(478600001)(8936002)(6666004)(66476007)(52116002)(26005)(2906002)(86362001)(316002)(66556008)(6512007)(966005)(2616005)(38100700002)(186003)(30864003)(36756003)(6916009)(38350700002)(6486002)(54906003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HcWJqKzOL2EUH9fEiYTQbVXOwXJh64RRGereP1zdM1vOyUSyrcTomXg75eXx?=
 =?us-ascii?Q?eAeZYyVOo6nt5i2uCI8bJ5PZjF8CkT/adu594LGfxT+Ja2SpXQD+UwWuTGlC?=
 =?us-ascii?Q?NE3nFLnq5DPRh/l13b2FgY1z/1CWJeg01wKt5eE4hlGeljGURZ1sZa9hudXf?=
 =?us-ascii?Q?UEPFdQJaYqljkfN+WhrKtdM8nypwqJQkm+WHwcZiBpHZJlkkrczEWuhs+eAR?=
 =?us-ascii?Q?nBcsE2WCwamuaVCQ+hQnNpZ3lt4Xpdr/MWfK7E94wmcVlzzwthYlJtbhczFs?=
 =?us-ascii?Q?qv/owbxz733WTwYDfDCHLHYxdywC/74+4Ir/aBNFbtUhA1eHaEunu33rU7DS?=
 =?us-ascii?Q?COoNG+AQcGy+3i69ZS5Jl//QmVVaWpkfr3oixM4pvyp2v7MXPLjrCQYiIIe8?=
 =?us-ascii?Q?v4JLwd+qP/bgMoluoDUY7JCxXrOpK/90nR+flaBi5uIzyTQfz9EgdFaSmewj?=
 =?us-ascii?Q?vHWsjnnPmIiQwvjb3J2TP7+prbfXd3kFvR4cipOOaOAuc87amGI5oxsap70a?=
 =?us-ascii?Q?+T2uNNHAQZemIVz2SsFqKjIumN0DkuJzmj9/om3LYuPkr0GLKsFAnib/nt2M?=
 =?us-ascii?Q?O/jXrIPdfc6NEyS+FcCR0J92sOGny0ap0jwWs8H5YCfdfcgw39kIErc6TWJu?=
 =?us-ascii?Q?v1MdRvnOlxPtl734GBqcYjdpUao9F575hOaAaakwlR1dmzaZfOT1JjhnbuTs?=
 =?us-ascii?Q?gEwC+ghdQi9xILDfU+g7xjCBI8XNbn1I5r++iWo6Mk4cBQpmkwZBUsgDha0h?=
 =?us-ascii?Q?JlT624YMr9ZhxikPCeR9vv9hjrjPa84DRK+W3ZijMzyw5hv4xzLM4Qj7ePta?=
 =?us-ascii?Q?bO/cCcPl4Uo3ZRum9z9ur4SY7c7YNtDdm+5bjz6XNmpL/dHEftzXsn3v9Xoq?=
 =?us-ascii?Q?NO95ddumfLaaqbOMgDQoFHSBvWVme7H8fLYwhVcbgqSQhmaEEXAlbl+JuIDZ?=
 =?us-ascii?Q?9EEJckP+BOoiFpDpKWvbqDZH5/mQeCxMz9fEIo9LIu08tNLbR1dsGIsPDNCk?=
 =?us-ascii?Q?gwBmbz+RsQI3ZwmRyfako8kZJcAr20+mjtaE0msyNVjyTzfXZq2XjlhQD0GT?=
 =?us-ascii?Q?Ttxlce06loTzX+OgtkI5K+JqFz5J38Jud+RXf35Li8+JNt1ZMEQngX200+Iw?=
 =?us-ascii?Q?b9f3I3iuGki0NnlDCW3Tmj5SgsINzU8Ys6M6pQBgPSIUI+b+6Ds1JAUvTfWz?=
 =?us-ascii?Q?ue1z39wmn1ppskY1AyuwMeXXIzCYvHoJ1SveK8EPOsa6RpUpo8HQ2zLu/nFa?=
 =?us-ascii?Q?QyaBEzZjmF0R/Ig+qAj9U2p/fdGf/SsHZJAkEAJ24eNp5IriyGSYCu+XzGpO?=
 =?us-ascii?Q?/Hb1+jCObkszRhsGSfr3EPLBEFixUhhVxwRpZM7tLxaXlrBtHp+vepcrjHoy?=
 =?us-ascii?Q?0NEOKwGhez3TqUn7gWmSkUxXOC9icHIl4dP053dVe5IsC6UB8p/1Q2ShGV50?=
 =?us-ascii?Q?zWplJB0v2dLDdHBjdRaLlOWsAlEoyNah3zIW+/eXwJPuyEtIdpkbNIX/OejU?=
 =?us-ascii?Q?6MQqudmg+2fBIvGzFSQgrjxE+C+LoeArAGLKSKl5lENsyhAGR5yDXF62b5lz?=
 =?us-ascii?Q?nr6XqHC9KBHgTsVr3uQIeJHwZVLt/h1UR6uZNbfGyfUJPxNpME5PtEHqzVrt?=
 =?us-ascii?Q?zQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fc5c93-b275-4424-a519-08da60e84506
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 13:46:33.5120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +u/GWtDaXCL0HOKFhhUK5JOsHaoqUwUHVnTZuLj1ZK/0vgAdKDYOcrH1MXNaXXUEGrfuBHsm86VxzWQqjb36TF+3k05okWxS+5FVRLgVLnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1375
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_11:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080052
X-Proofpoint-GUID: jIJK6RDlwvAQceliNxYjCYN_KBQweAFj
X-Proofpoint-ORIG-GUID: jIJK6RDlwvAQceliNxYjCYN_KBQweAFj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Fri, Jul 8, 2022 at 5:56 AM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Wed, Jul 6, 2022 at 11:20 AM Andrii Nakryiko
>> > <andrii.nakryiko@gmail.com> wrote:
>> >>
>> >> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
>> >> <james.hilliard1@gmail.com> wrote:
>> >> >
>> >> > Note I'm testing with the following patches:
>> >> > https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
>> >> > https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
>> >> >
>> >> > It would appear there's some compatibility issues with bpftool gen and
>> >> > GCC, not sure what side though is wrong here:
>> >> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> >> > gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> >> > src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> >> > libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
>> >> > Error: failed to link
>> >> > 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>> >> > Unknown error -2 (-2)
>> >> >
>> >> > Relevant difference seems to be this:
>> >> > GCC:
>> >> > [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>> >> > Clang:
>> >> > [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
>> >> >
>> >>
>> >> GCC is wrong, clearly. This function is global ([0]) and libbpf
>> >> expects it to be marked as such in BTF.
>> >
>> > Does this invocation look correct?
>> > /home/buildroot/buildroot/output/per-package/systemd/host/bin/bpf-gcc
>> > -O2 -mkernel=5.2 -mcpu=v3 -mco-re -gbtf -r -std=gnu11 -D__x86_64__
>> > -mlittle-endian -I. -idirafter
>> > /home/buildroot/buildroot/output/per-package/systemd/host/x86_64-buildroot-linux-gnu/sysroot/usr/include
>> > ../src/core/bpf/restrict_fs/restrict-fs.bpf.c -o
>> > src/core/bpf/restrict_fs/restrict-fs.bpf.unstripped.o
>>
>> Hmm, why linking a relocatable ELF instead of just using a compiled
>> object (with -c)?
>
> This bpftool gen object build stage AFAIU is needed to strip the object before
> using it for skeleton generation, does that sound right?

Thing is, `gcc -r' involves the linker.  The GNU linker (ld) supports
linking BPF objects, but AFAIK the kernel BPF objects are all supposed
to be compiled objects, not linked as relocatable objects.  (The LLVM
BPF toolchain doesn't support linking BPF objects as far as I know.)

That's my understanding, but note I'm not very familiar with bpftool
(I'm trying to find time now to fix that.)

>>
>> > I've also tried without the -r(relocatable object) flag but that gives
>> > a different error:
>> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> > gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> > src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> > libbpf: unsupported kind of ELF file
>> > src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o: no
>> > error
>> > Error: failed to link
>> > 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>> > Unknown error -95 (-95)
>> >
>> > GCC without relocatable flag:
>> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> > [3] TYPEDEF '__u8' type_id=2
>> > [4] CONST '(anon)' type_id=3
>> > [5] VOLATILE '(anon)' type_id=4
>> > [6] INT 'short int' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
>> > [7] INT 'short unsigned int' size=2 bits_offset=0 nr_bits=16 encoding=(none)
>> > [8] TYPEDEF '__u16' type_id=7
>> > [9] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>> > [10] TYPEDEF '__s32' type_id=9
>> > [11] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>> > [12] TYPEDEF '__u32' type_id=11
>> > [13] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>> > [14] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64
>> > encoding=(none)
>> > [15] TYPEDEF '__u64' type_id=14
>> > [16] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>> > [17] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>> > [18] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> > [19] CONST '(anon)' type_id=18
>> > [20] TYPEDEF '__be16' type_id=8
>> > [21] TYPEDEF '__be32' type_id=12
>> > [22] ENUM 'bpf_map_type' encoding=UNSIGNED size=4 vlen=31
>> >     'BPF_MAP_TYPE_UNSPEC' val=0
>> >     'BPF_MAP_TYPE_HASH' val=1
>> >     'BPF_MAP_TYPE_ARRAY' val=2
>> >     'BPF_MAP_TYPE_PROG_ARRAY' val=3
>> >     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=4
>> >     'BPF_MAP_TYPE_PERCPU_HASH' val=5
>> >     'BPF_MAP_TYPE_PERCPU_ARRAY' val=6
>> >     'BPF_MAP_TYPE_STACK_TRACE' val=7
>> >     'BPF_MAP_TYPE_CGROUP_ARRAY' val=8
>> >     'BPF_MAP_TYPE_LRU_HASH' val=9
>> >     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=10
>> >     'BPF_MAP_TYPE_LPM_TRIE' val=11
>> >     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=12
>> >     'BPF_MAP_TYPE_HASH_OF_MAPS' val=13
>> >     'BPF_MAP_TYPE_DEVMAP' val=14
>> >     'BPF_MAP_TYPE_SOCKMAP' val=15
>> >     'BPF_MAP_TYPE_CPUMAP' val=16
>> >     'BPF_MAP_TYPE_XSKMAP' val=17
>> >     'BPF_MAP_TYPE_SOCKHASH' val=18
>> >     'BPF_MAP_TYPE_CGROUP_STORAGE' val=19
>> >     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=20
>> >     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=21
>> >     'BPF_MAP_TYPE_QUEUE' val=22
>> >     'BPF_MAP_TYPE_STACK' val=23
>> >     'BPF_MAP_TYPE_SK_STORAGE' val=24
>> >     'BPF_MAP_TYPE_DEVMAP_HASH' val=25
>> >     'BPF_MAP_TYPE_STRUCT_OPS' val=26
>> >     'BPF_MAP_TYPE_RINGBUF' val=27
>> >     'BPF_MAP_TYPE_INODE_STORAGE' val=28
>> >     'BPF_MAP_TYPE_TASK_STORAGE' val=29
>> >     'BPF_MAP_TYPE_BLOOM_FILTER' val=30
>> > [23] UNION '(anon)' size=8 vlen=1
>> >     'flow_keys' type_id=29 bits_offset=0
>> > [24] STRUCT 'bpf_flow_keys' size=56 vlen=13
>> >     'nhoff' type_id=8 bits_offset=0
>> >     'thoff' type_id=8 bits_offset=16
>> >     'addr_proto' type_id=8 bits_offset=32
>> >     'is_frag' type_id=3 bits_offset=48
>> >     'is_first_frag' type_id=3 bits_offset=56
>> >     'is_encap' type_id=3 bits_offset=64
>> >     'ip_proto' type_id=3 bits_offset=72
>> >     'n_proto' type_id=20 bits_offset=80
>> >     'sport' type_id=20 bits_offset=96
>> >     'dport' type_id=20 bits_offset=112
>> >     '(anon)' type_id=25 bits_offset=128
>> >     'flags' type_id=12 bits_offset=384
>> >     'flow_label' type_id=21 bits_offset=416
>> > [25] UNION '(anon)' size=32 vlen=2
>> >     '(anon)' type_id=26 bits_offset=0
>> >     '(anon)' type_id=27 bits_offset=0
>> > [26] STRUCT '(anon)' size=8 vlen=2
>> >     'ipv4_src' type_id=21 bits_offset=0
>> >     'ipv4_dst' type_id=21 bits_offset=32
>> > [27] STRUCT '(anon)' size=32 vlen=2
>> >     'ipv6_src' type_id=28 bits_offset=0
>> >     'ipv6_dst' type_id=28 bits_offset=128
>> > [28] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=4
>> > [29] PTR '(anon)' type_id=24
>> > [30] UNION '(anon)' size=8 vlen=1
>> >     'sk' type_id=32 bits_offset=0
>> > [31] STRUCT 'bpf_sock' size=80 vlen=14
>> >     'bound_dev_if' type_id=12 bits_offset=0
>> >     'family' type_id=12 bits_offset=32
>> >     'type' type_id=12 bits_offset=64
>> >     'protocol' type_id=12 bits_offset=96
>> >     'mark' type_id=12 bits_offset=128
>> >     'priority' type_id=12 bits_offset=160
>> >     'src_ip4' type_id=12 bits_offset=192
>> >     'src_ip6' type_id=28 bits_offset=224
>> >     'src_port' type_id=12 bits_offset=352
>> >     'dst_port' type_id=20 bits_offset=384
>> >     'dst_ip4' type_id=12 bits_offset=416
>> >     'dst_ip6' type_id=28 bits_offset=448
>> >     'state' type_id=12 bits_offset=576
>> >     'rx_queue_mapping' type_id=10 bits_offset=608
>> > [32] PTR '(anon)' type_id=31
>> > [33] STRUCT '__sk_buff' size=192 vlen=33
>> >     'len' type_id=12 bits_offset=0
>> >     'pkt_type' type_id=12 bits_offset=32
>> >     'mark' type_id=12 bits_offset=64
>> >     'queue_mapping' type_id=12 bits_offset=96
>> >     'protocol' type_id=12 bits_offset=128
>> >     'vlan_present' type_id=12 bits_offset=160
>> >     'vlan_tci' type_id=12 bits_offset=192
>> >     'vlan_proto' type_id=12 bits_offset=224
>> >     'priority' type_id=12 bits_offset=256
>> >     'ingress_ifindex' type_id=12 bits_offset=288
>> >     'ifindex' type_id=12 bits_offset=320
>> >     'tc_index' type_id=12 bits_offset=352
>> >     'cb' type_id=34 bits_offset=384
>> >     'hash' type_id=12 bits_offset=544
>> >     'tc_classid' type_id=12 bits_offset=576
>> >     'data' type_id=12 bits_offset=608
>> >     'data_end' type_id=12 bits_offset=640
>> >     'napi_id' type_id=12 bits_offset=672
>> >     'family' type_id=12 bits_offset=704
>> >     'remote_ip4' type_id=12 bits_offset=736
>> >     'local_ip4' type_id=12 bits_offset=768
>> >     'remote_ip6' type_id=28 bits_offset=800
>> >     'local_ip6' type_id=28 bits_offset=928
>> >     'remote_port' type_id=12 bits_offset=1056
>> >     'local_port' type_id=12 bits_offset=1088
>> >     'data_meta' type_id=12 bits_offset=1120
>> >     '(anon)' type_id=23 bits_offset=1152
>> >     'tstamp' type_id=15 bits_offset=1216
>> >     'wire_len' type_id=12 bits_offset=1280
>> >     'gso_segs' type_id=12 bits_offset=1312
>> >     '(anon)' type_id=30 bits_offset=1344
>> >     'gso_size' type_id=12 bits_offset=1408
>> >     'hwtstamp' type_id=15 bits_offset=1472
>> > [34] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=5
>> > [35] CONST '(anon)' type_id=33
>> > [36] PTR '(anon)' type_id=0
>> > [37] STRUCT '(anon)' size=24 vlen=3
>> >     'type' type_id=39 bits_offset=0
>> >     'key' type_id=40 bits_offset=64
>> >     'value' type_id=41 bits_offset=128
>> > [38] ARRAY '(anon)' type_id=9 index_type_id=16 nr_elems=1
>> > [39] PTR '(anon)' type_id=38
>> > [40] PTR '(anon)' type_id=12
>> > [41] PTR '(anon)' type_id=3
>> > [42] ARRAY '(anon)' type_id=19 index_type_id=16 nr_elems=18
>> > [43] CONST '(anon)' type_id=42
>> > [44] FUNC_PROTO '(anon)' ret_type_id=36 vlen=2
>> >     '(anon)' type_id=36
>> >     '(anon)' type_id=46
>> > [45] CONST '(anon)' type_id=0
>> > [46] PTR '(anon)' type_id=45
>> > [47] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>> >     'sk' type_id=48
>> > [48] PTR '(anon)' type_id=35
>> > [49] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>> >     'sk' type_id=48
>> > [50] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>> >     'sk' type_id=48
>> > [51] VAR 'is_allow_list' type_id=5, linkage=global
>> > [52] VAR '_license' type_id=43, linkage=static
>> > [53] VAR 'sd_restrictif' type_id=37, linkage=global
>> > [54] FUNC 'bpf_map_lookup_elem' type_id=44 linkage=static
>> > [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>> > [56] FUNC 'sd_restrictif_e' type_id=49 linkage=static
>> > [57] FUNC 'restrict_network_interfaces_impl' type_id=50 linkage=static
>> > [58] DATASEC 'license' size=0 vlen=1
>> >     type_id=52 offset=0 size=18 (VAR '_license')
>> > [59] DATASEC '.maps' size=0 vlen=1
>> >     type_id=53 offset=0 size=24 (VAR 'sd_restrictif')
>> > [60] DATASEC '.data' size=0 vlen=1
>> >     type_id=51 offset=0 size=1 (VAR 'is_allow_list')
>> >
>> >>
>> >> https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50
>> >>
>> >>
>> >> > GCC:
>> >> >
>> >> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> >> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> >> > [3] TYPEDEF '__u8' type_id=2
>> >> > [4] CONST '(anon)' type_id=3
>> >>
>> >> [...]
