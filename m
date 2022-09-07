Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115EF5B0F99
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiIGV4J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 17:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbiIGVz6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 17:55:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5869EC57BB;
        Wed,  7 Sep 2022 14:55:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287LIxM8001747;
        Wed, 7 Sep 2022 21:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=qmzeTUXkL4jbRmZQtYgsG5H+EVvezzYwQLFZk1MbnjY=;
 b=nvUt9lK0aE1bBOGjXWfoPvOv6S4hNOhMKExfVo6N7ai9BFX83CAz/ODK/+VgcU8FDNUb
 qtIdJ8FInyfO2unzwQmmTzLn0KPiurnOUnG84jaIm/TW8LArbePuwC/SdOjg/U+XCsVa
 S/43USEZZyQK+CW1Hy2MkBDvD+UdnXrnYQu25MxdAkrpN/BYnGzaUzixW1fl4857sDKt
 gkXFXbOw1ayycaTZxAdhRwcYASqb5kxo5EnB/8/eoPi4SnpcDwbjHwZaRA+aX1CkgePo
 +F9d9OLw2wGWrsXTmjpdACp3M2HSzpFctdRnZYlr8c5StCJ6FTannk34TInqtrMlkdPc jw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbca03j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 21:54:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 287Iev9c021141;
        Wed, 7 Sep 2022 21:54:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcaw5hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 21:54:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwIAxQwA7olkfoEDPZ1UEwTVdPfv0xW4IIfMFXZRuOdLdFP4RdkMndcjKKKpDExNpibZGDLvVZNeqWJW8H+9QxdjDc5SGSzcFDD5WB4iV+8tVutgR7XGDodr184mdxo18wK9fDXhzL/4nY/2jNxDjCGuX0AQFTM4T8ym1LpfjvPm1qtj5PRtk7VJeyIvPCZBRhewsPD+aTrFBpR9ofgVJRBSjsxj34vQFhW0mlt/pxpx4EoDvK2mlrV/1oQ1Pmz8bEFJnSpvVwvVZWkD3vBoTD8FZkNgBAuYJxvdQudUqnqlBw6ynowW+L1JuI9JNI94NBnmzy9zB3F9boICBD4tlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmzeTUXkL4jbRmZQtYgsG5H+EVvezzYwQLFZk1MbnjY=;
 b=OE28xJRS2tvrKFWA7knY1RuaWU9YTc5xuVvUHt2hGL+ajq2IjZfE8rbMOZqTaev5dLfvmiZngdqqUuLyTzV1Za7YRo66EqGpALlzEgwkz/L/ikA6N0sZJT8aJwucOUiqjoyeZDhaSMtr00YZQElkjtIwX5je6wOd8ySK3+gaJuic0b8xkVtuh0fNmRA1u8FFO7spv4+SaQy0l9vjowyUXweUU5LQhUB2XOyfcTLH5lsj0V6m9o0cCZQFA43KiEaijHAqOzVZcMF6B/ior0v1VAsereuNg3foxlvci4FRI6obvT8MRPFr9cM0InUKQwV2yIVF8y+q2kFcopSo+jR5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmzeTUXkL4jbRmZQtYgsG5H+EVvezzYwQLFZk1MbnjY=;
 b=NyY38Fk94XDa1thp0rOt16b/cBfvE0of5GKOeSlink44maaUCBP2cxk2vF2xM3Pg2o8zJBsIoDVERboFG4hqT4a2Sje2UEn1UqDWsKDuBP1WqO+n4GJ3XnX83ifuMRxBmmGHaEM0sKSP7OnPO8yIZ6sttJjUQfJfLM+tR/Xi08I=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SA2PR10MB4588.namprd10.prod.outlook.com (2603:10b6:806:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 21:54:10 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%5]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 21:54:10 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves 0/7] Add support for generating BTF for all
 variables
In-Reply-To: <CAADnVQKbf5nEBnuSLmfZ_kGLmUzeD5htc1ezbJsVg72adF4bLw@mail.gmail.com>
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
 <CAADnVQKbK__y8GOD4LqaX0aCgT+rtC5aw54-02mSZj1-U6_mgw@mail.gmail.com>
 <87sfl3j966.fsf@oracle.com>
 <CAADnVQKbf5nEBnuSLmfZ_kGLmUzeD5htc1ezbJsVg72adF4bLw@mail.gmail.com>
Date:   Wed, 07 Sep 2022 14:54:08 -0700
Message-ID: <87v8pylukf.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a7b1bd0-0706-45d1-b8ee-08da911b7e6d
X-MS-TrafficTypeDiagnostic: SA2PR10MB4588:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hu/cllFRHguJP9u3jfsDSLoP2mGDPlMH+nEVyDC1hS469Faix+EvvMhynSnx0o+wDEZFW9tl14bFsSuMRs9pU/MX15m8ir11hLsfH+mDED67DqOFRw9tz8tEvVlSkxenDIjWW7Z2bRCegYINInEJ0Ds2ZyIB2y03TV3oWUwivU7Di0kHR1W9ZQW3h66XfqNJPn1gI/9robpnv82MgXFSE2CG4ysKdWcEjL/us0JwnV+rVt4aourgihW6AhEObuAP8k6b5BT4Oms8ituJowMzmGibslpSWCBRqrwq7kcydZZCQ7usVCtMrFP5xa9StacL2JUp1NVlEa9qBdC/ETxf9Cuc13FSck7ev8HP6IbwhF53SpA07zXnziBFOR1iKexdNWxTgcms/o9NFS5NeuZnkkeERx1sVTbtMy0eG41gTX73v+gE+U3HOXUQTUj4QNOQ07Z5Jxm6cq8nPRHkepn5wncgTvaYem5NccX0Voe4FmHimN8N/NcZH87viFWdzCqCxx9WKlbY6lk1OW2shFHI9Pi0XaiAz6r8ZhDbAAb381dDAmBylXS9To58NyXKn/gwy9ZC7CX4h17BU66folrJ747Omr518mWFYez8QBriMGxTsp4cesI/0XCQQFqcL1MlRoTFFVGEx7tIitMo+wD7jIKCpoyGGLnn2KT19aPOffX2/PUL6bcTzggCkE+xQUSW/9JSBcfnXxg6X89s2M9Q+mLm9LHNmjdSBKdGuP+1A2DOPvEZsADLHcUm/RSoRyqbRIlWHr14faeJbZTxtb2U2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(396003)(376002)(366004)(38100700002)(86362001)(316002)(8936002)(5660300002)(6916009)(54906003)(2906002)(66946007)(4326008)(66556008)(66476007)(8676002)(83380400001)(478600001)(2616005)(186003)(6512007)(6486002)(966005)(41300700001)(107886003)(53546011)(26005)(6506007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?if74szQoU1Ib4GRKOXdGYDgosrq9I8VSfHb3vsx7MsgLxxk3FH/tw/pepcQ1?=
 =?us-ascii?Q?9uTbl0UfYlzzZClORQ4l75XqhAycCMQ4ybDn3Xm5I3vsVcHOVMDzP5ezdRQd?=
 =?us-ascii?Q?DGFmKQJFjTSRu5xN42U0DZ+E3wzsvldyw5SbPAeNq5dWmCfykVaNCyF0esUo?=
 =?us-ascii?Q?kt4HDJrsAmdi3EbV2ga160X/4nIJZMHKNf5wl2mUtIOGCs2IJWg0XgdIe+AQ?=
 =?us-ascii?Q?HXNhMgPFAaCOwMdMXONuTuaj71+T9ixY8FzXzejQyeTZMyfGRgQz9hWYmwXn?=
 =?us-ascii?Q?HCGYAoA38msIHfZEFKqqsW0Gh2TlUeKX6q9jSKzqFUhL5EiAHoNW5EkH3tcO?=
 =?us-ascii?Q?Bgls2sqFGoaahESlfLrO6hO2eHXgjZglpOIuEA7WFVJmfKDbA8HHB32EK8ZX?=
 =?us-ascii?Q?Edu1jOX+QVSfQ8bBAjhNqMvfY6wm9T7xlZYhkNtOg4n6VrJICOZ/lGm1V8jq?=
 =?us-ascii?Q?ty9f/dng645gJIId2KjSjpdvijpJlAdL6mVVkcCf1kXFaldKNGruJvV4FWkn?=
 =?us-ascii?Q?45PgF1u0Gapg3FE/rm4aXDV1MVE0WzgjaZlfZsDWZ3VU1AOMK/nUqCTRvhqg?=
 =?us-ascii?Q?WU/Icg10YoH1ZlD1Ltx/XEnybBMj7Ak21HxLiYEhYm+4rB3hO0RnEQjtzaoM?=
 =?us-ascii?Q?K6ZHsXvLXI3w6HgGhjH3GRXdlACUTGfTvOoxd22/uLNhrnh7jzCydnpHKYcR?=
 =?us-ascii?Q?jNL9N2Uijtu2Kep2fVUI5XJB2Z70YVBBAoJqlbl1TFfNqc9mBHSpTDfejPot?=
 =?us-ascii?Q?U9+R/C9stINPRDhxUps+PBBip8BZoYCb368DTFse3PYjTATcIiUZCONky2R0?=
 =?us-ascii?Q?v8RrzSU6jYlMAdakVTN0YYZGL1Ts+DtCB2VjI0ZmDc3Bh7CbDtR2Vcpw6r5g?=
 =?us-ascii?Q?UawHCLG7oNMYF/0+aMOJyDsLBlCQGVfrajbzqdcaOyhXgccW1Z10L5L1BLLq?=
 =?us-ascii?Q?26Ljyl6wJJv1wuzTsW30gTjzOBTBLUOQI5A6BW2vFKXZAw+HFr3o7DnvHEEr?=
 =?us-ascii?Q?Nv8GsGSXwQujKly+A/3XRs1wr/BYjTR6yJATKGMQEKbPAxvjtaadEqWSNiuF?=
 =?us-ascii?Q?y4pkgZtDhKH/ylKRTfaGWe5NMuYNYXAGZQjs3q/BJRVKXObLcCgATbEA/1VI?=
 =?us-ascii?Q?YPIufFAr4NHDWinSQ3V+gWbVDkadEXKcPvo6NlqSo7CLzL901fdV7VeAazXz?=
 =?us-ascii?Q?J/RHAlj84a8wvwJaso7yEhk2qbhaD3pxg7x04qhqw/vKszyu+f4u/az0e5o5?=
 =?us-ascii?Q?V6uHL2uvOvVUJe4R/hqZjWtFNpaoXUesEPexq3zYAf94ljU0N2MNfY/EVP10?=
 =?us-ascii?Q?kYyPHo36Zg6Y3u8yk5Fu+N9a2XyET3Z+z4ERaoTEpS0jlO3+VraneGkE+asO?=
 =?us-ascii?Q?6S/KI71C1DLz5i/GW8hgShmu9gtez3+cNhJGKGOPPVG5KLC40INlAb30OR21?=
 =?us-ascii?Q?A05DvyOJ956557BLeHJoLWNsyGEAEn0nO0OPtd9gxXFI5zPfWL5vWdsG+liX?=
 =?us-ascii?Q?GHa8FxHZ2nteQ4SMOONO33KNeATk5rovqix7ZaeCerV55/bBx26dsRKozsLv?=
 =?us-ascii?Q?5VEjtWljr0Ugt495hYZ41cY9KJhYR4UlVOxK2K+zI9KUj9d6Ocz5szJ1F2Sy?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7b1bd0-0706-45d1-b8ee-08da911b7e6d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 21:54:10.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIe9Fr2c3H6KZnU2YQEAdO6DgaelnlOy9d4A6nLQ25MD2+Iplqkf5ypa1o0XNbv3A5z2YvpyPyuLWlhS9SvBoYZT1/TfAiMszrXMXp/dyPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=969
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070080
X-Proofpoint-ORIG-GUID: i7PMUX3GqB9_2FTw38MQc8tTFmHIU6N4
X-Proofpoint-GUID: i7PMUX3GqB9_2FTw38MQc8tTFmHIU6N4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> On Wed, Sep 7, 2022 at 12:07 PM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>> > On Fri, Aug 26, 2022 at 11:54 AM Stephen Brennan
>> > <stephen.s.brennan@oracle.com> wrote:
>> [...]
>> >> Future Work
>> >> -----------
>> >>
>> >> If this proves acceptable, I'd like to follow-up with a kernel patch to
>> >> add a configuration option (default=n) for generating BTF with all
>> >> variables, which distributions could choose to enable or not.
>> >>
>> >> There was previous discussion[3] about leveraging split BTF or building
>> >> additional kernel modules to contain the extra variables. I believe with
>> >> this patch series, it is possible to do that. However, I'd argue that
>> >> simpler is better here: the advantage for using BTF is having it all
>> >> available in the kernel/module image. Storing extra BTF on the
>> >> filesystem would break that advantage, and at that point, you'd be
>> >> better off using a debuginfo format like CTF, which is lightweight and
>> >> expected to be found on the filesystem.
>> >
>> > With all or nothing approach the distros would have a hard choice
>> > to make whether to enable that kconfig, increase BTF and consume
>> > extra memory without any obvious reason or just don't do it.
>> > Majority probably is not going to enable it.
>> > So the feature will become a single vendor only and with
>> > inevitable bit-rot.
>>
>> I'd intend to support it even if just a single distribution enabled it.
>> But I do see your concern.
>
> This thread was dormant for 8 days.
> That's a poor example of "intend to support".

You're right, I definitely could have replied sooner. I'm sorry for that.

>> > Whereas with split BTF and extra kernel module approach
>> > we can enable BTF with all global vars by default.
>> > The extra module will be shipped by all distros and tools
>> > like bpftrace might start using it.
>>
>> Split BTF is currently limited to a single base BTF file. We'd need more
>> patches for pahole to support multiple --btf_base files: e.g.
>> vmlinux.btf and vmlinux-variables.btf. There's also the question of
>> modules: presumably we wouldn't try to have "$MODULE" and
>> "$MODULE-btf-extra" modules due to the added complexity. I doubt the
>> space savings would be worth it.
>>
>> I can look into these concerns, but if possible I would like to proceed
>> with this series, as it is a separate concern from the exact mechanism
>> by which we include extra BTF into the kernel.
>
> Not an option. Sorry.

Ok, so let me describe what I understand to be the proposed design as of
the previous thread, and see if it satisfies your concerns. We can work
from there to make sure we've got a concensus design before going
further.

Option #1
---------

* A new module, "vmlinux-btf-extra" (or something roughly like that) is
  added, which contains BTF only. It is generated with
  --encode_all_btf_vars and uses --btf_base=path/to/vmlinux_btf so that
  it contains only BTF variables. The vmlinux BTF would be generated
  same as always (without the --encode_all_btf_vars).

* In the previous thread, it was proposed [1] that modules could
  include variables in their BTF in order to reduce the complexity of
  the change. Modules would have their BTF generated using
  --encode_all_btf_vars and --btf_base=path/to/vmlinux_btf. The
  resulting hierarchy would look like this:

  vmlinux_btf  [ functions and percpu vars only ]
  |- vmlinux-btf-extra [ all other vars for vmlinux ]
  |- $MODULE   [ functions and all vars ]
  ...

This option is desirable because it means that we only need 2-level
split BTF, and so we don't actually need to make changes to pahole for
multiple --btf_base files. There are two downsides I see:

(a) While we save space on vmlinux BTF, each module will have a bit of
    extra data for variable types. On my laptop (5.15 based) I have 9.8
    MB of BTF, and if you deduct vmlinux, you're still left with 4.7 MB.
    If we assume the same overhead of 23.7%, that would be 1.1 MB of
    extra module BTF for my particular use case.

    $ ls -l /sys/kernel/btf | awk '{sum += $5} END {print(sum)}'
    9876871
    $ ls -l /sys/kernel/btf/vmlinux
    -r--r--r-- 1 root root 5174406 Sep  7 14:20 /sys/kernel/btf/vmlinux

(b) It's possible for "vmlinux-btf-extras" and "$MODULE" to contain
    duplicate type definitions, wasting additional space. However, as
    far as I understand it, this was already a possibility, e.g.
    $MODULE1 and $MODULE2 could already contain duplicate types. So I
    think this downside is no more.


Option #2
---------

* The vmlinux-btf-extra module is still added as in Option #1.

* Further, each module would have its own "$MODULE-btf-extra" module to
  add in extra BTF. These would be built with a --btf_base=$MODULE.ko
  and of course that BTF is based on vmlinux, so we would have:

  vmlinux_btf              [ functions and percpu vars only ]
  |- vmlinux-btf-extras    [ all other vars for vmlinux ]
  |- $MODULE               [ functions and percpu vars only ]
     |- $MODULE-btf-extra  [ all  other vars for $MODULE ]

This is much more complex, pahole must be extended to support a
hierarchy of --btf_base files. The kernel itself may not need to
understand multi-level BTF since there's no requirement that it actually
understand $MODULE-btf-extra, so long as it exposes it via
/sys/kernel/btf/$MODULE-btf-extra. I'd also like to see some sort of
mechanism to allow an administrator to say "please always load
$MODULE-btf-extras alongside $MODULE", but I think that would be a
userspace problem.

This resolves issue (a) from option #1, of course at implementation
cost.

Regardless of Option #1 or #2, I'd propose that we implement this as a
tristate, similar to what Alan proposed [2]. When set to "m" we use the
solutions described above, and when set to "y", we don't bother with it,
instead using --encode_all_btf_vars for all generation.

If we go with Option #1, no changes to this series should be necessary.
If we go with Option #2, I'll need to extend pahole to support at least
two BTF base files. Please let me know your thoughts.

Stephen

[1]: https://lore.kernel.org/bpf/CAEf4BzZmJKqXaJMBxhKqFNXzjO=eN5gk2xQVnmQVdK2xd3HQ=g@mail.gmail.com/
[2]: https://lore.kernel.org/bpf/alpine.LRH.2.23.451.2205032254390.10133@MyRouter/
