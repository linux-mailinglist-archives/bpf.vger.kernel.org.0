Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBAE4BA63E
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 17:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243406AbiBQQmU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 11:42:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243422AbiBQQmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 11:42:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB7B2B357B
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 08:42:02 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HEkN1x010826;
        Thu, 17 Feb 2022 16:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Tj/IuKumu/Zt8mI8lM4g0tWb5GaK1wWWWPAOgqnD8F4=;
 b=CxbdlmfjmH8laNEZJCeke4/8m3m+yOuyLhGO99VfU9hp5ftAhPtDijpI8+r+ykYB8aoH
 aMhZFJSp8Fp+rPWl0sAZE6YI1fSj9+6KfM2CI+xWuhNhWawK1yWeipoMtWgnC2QAkm+n
 XKYa+p7niCQhj6qKbLBWU7W7lE26Ng3LtfQNcTgbQhgW54FbBrykj4o97pTpHR8aLoXu
 xfpa+rsBZX0GVF2Dfux8VsDYKGO6LQvHLMv9VSP2wi4aR1QyEe3G7n4ey4zwZoJbc0Uw
 qBOtuHaSpPOf+BoDjZSls278e0VgPJP5D/pytpqylWYzgdO/uTOBKNx8NgVHwG6if//n HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nkdpmmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 16:41:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HGaVTP193778;
        Thu, 17 Feb 2022 16:41:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3020.oracle.com with ESMTP id 3e8nvu550x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 16:41:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/Uz8otfoEEth6MzjB3MtQgpYIX3XymC/sSblrbIjX56jx1vg3/AQrq66no7AI25oQJBKq/hcoefzMAcizK/WRAFj1IZbki0/1TNJsfdLtJxTLCltU4a7u1ABIqxuIYXNr6m56whOzv03AJVPXKU6G3gurwv7WseQj+R9fHcx1eXRPtZ56lpUOsH6mmagn8a8SG5uzeOa6KT/EeNV5WH2Ir9P32ubA0qyiC/k+4SeOKZMiFzWHeyvaAbZlnlvNU97skTqRkT+FOaYlmFPrYZ7f6kjh9m/023aGbziFz+AdEq4BOwza8Ehg45M8q8xTlo5lZhcpKtHacUTrmYYzsXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj/IuKumu/Zt8mI8lM4g0tWb5GaK1wWWWPAOgqnD8F4=;
 b=oeQnd0ljw1crUhOqmyR6QUeAuN/Ud5em7LxtigRcU0eaclH6fyPPigLnnid5b9uq3o6BCcrraU95qK2dd96ADnwEP/KqatpNn1JGM0wxGTpV99j9q14GIHkWnBByyQiHEyfgIw+07PD1sE+C4T9WJwA4AM7ktE9rKfuvElhU8TNoP03gg+20fbEvmHWf/Tjif23i/eITKVoCQna4N0+duoIQ1lslyhR2CRiS2bPxVGGMLMrZBXFy+Ho/k+l7t3aWDta1uB+cIgn96oElf+mQa847HpLlc/tjAjzZLxj5Tiwx/lWKdTENfHmrElPJ7HDNfsIVEEiKvN+11ua9GZ/XZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj/IuKumu/Zt8mI8lM4g0tWb5GaK1wWWWPAOgqnD8F4=;
 b=ot+YE0F1/hfGQymJVmcYkripNoGC9s5XhBn9a2KHcUZvdoplIjRRG/WEoNP0v7rwdBtPKXBevDcx7tPc+YJMw521dGxydFMpHdPyi01F9QZjnmfM+M3udby4Fv2Dj0FQODU8fX9Kh14DjR+pqQkStt/gJ+oZjqAtNvOwprDFwEo=
Received: from DM6PR10MB2890.namprd10.prod.outlook.com (2603:10b6:5:71::31) by
 BN6PR10MB1298.namprd10.prod.outlook.com (2603:10b6:404:43::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.14; Thu, 17 Feb 2022 16:41:27 +0000
Received: from DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::25fc:97f5:a9fb:f7b3]) by DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::25fc:97f5:a9fb:f7b3%6]) with mapi id 15.20.4975.018; Thu, 17 Feb 2022
 16:41:27 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Mark Wielaard <mark@klomp.org>, david.faust@oracle.com
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
References: <20210913155122.3722704-1-yhs@fb.com>
        <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com>
        <87sfy82zvd.fsf@oracle.com>
        <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com>
        <87ilvncy5x.fsf@oracle.com>
        <20211218014412.rlbpsvtcqsemtiyk@ast-mbp.dhcp.thefacebook.com>
        <7122dbee-8091-8cd1-d3e4-d5625d5d6529@fb.com>
        <87czlr4ndp.fsf@oracle.com>
        <61e04a73-bc4d-b250-31fe-93df4100c923@fb.com>
        <87pmodgpe8.fsf@oracle.com>
        <5e20c3e3-8074-9a94-ae9c-1ffa3c65ec82@fb.com>
        <875ypdvdcr.fsf@oracle.com>
        <CAADnVQJAHwMuyikV5+2xk5fUwsieH246YdqNFXFE0W1_AiD_qw@mail.gmail.com>
Date:   Thu, 17 Feb 2022 17:41:11 +0100
In-Reply-To: <CAADnVQJAHwMuyikV5+2xk5fUwsieH246YdqNFXFE0W1_AiD_qw@mail.gmail.com>
        (Alexei Starovoitov's message of "Thu, 17 Feb 2022 07:28:55 -0800")
Message-ID: <871r01phso.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To DM6PR10MB2890.namprd10.prod.outlook.com
 (2603:10b6:5:71::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b12f3ef6-bbf1-492e-945e-08d9f2345791
X-MS-TrafficTypeDiagnostic: BN6PR10MB1298:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB12985E2C8BD9DD96B9C6844294369@BN6PR10MB1298.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yf2kJlIaw1SqyMdaeKU2Y9iBHeyaGhzCBhK3NTaIoTh5+HicAx3K06+oEzA2INMEgBeanEWzykYiWEihNrMSyFNAVbrEu/UCqkXrb97K2ydsRD+X5/3sIcXIgaAGO76n3C0+LL2GPBqkgDAzBg0nDqIZmRmh53nVdHQnTWn9QFxO6PMBEEzM3K5XfehhkTRoYfa1GCvDxXmvDuV8xYdAHdUON1Ngw7oLtn36K8zQCWPFCzSGFHSSUUo5KNwLIOT4XF3msOP4OTD9B3zjyti9rxqPJlDmu9SHZ2zmTiAVPhpfjZk1Lg4xg4xUvEdOXK+Anhof8Lc+X3bZKlOFe1gOwbGyeLoFyF2Almo1amOykXpYjVakTfySo+SKM6kHhZLlkHr0VP0kK1RI5YZ1Yng0kB7+zEPXBD6LyDV3YevztNeTaEzjsfFoPLFgAILz9ZgrWcZIkwtMbSzaWJUejy65SoCGOvYHFwB9Om0SwP/dQ0sFajfOYH55jafXe9VDR6QnDlo+p1cbxxc1zMsGb2oeMlWbSsj8xZerlytof3xXs6eBBXy/CKP0kO27S3uo7E8PfQ+sPyR42UHy7cPtNSp/97AHSLoBam1HJDGtH/0Hnev3cyDkPm/EhENsa/yQplIebd7Ob6I69Z9mjNEzc/l9q1ZJd58/yVQ2OYghJGeaRoUjs1lRAjf20wokyOFR7Y3BRZqw5ijZnePF1ZhzGeeOfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2890.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6486002)(508600001)(6506007)(38100700002)(2906002)(38350700002)(54906003)(316002)(6666004)(6916009)(66946007)(26005)(107886003)(66556008)(8936002)(86362001)(8676002)(186003)(4326008)(6512007)(83380400001)(53546011)(4744005)(5660300002)(52116002)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SOL8rYaxd5QnKiYnIrdrAqw5X70iSXt6C3m3s2Y6CsbSBBTkDsw7JBGbIahG?=
 =?us-ascii?Q?0trTeF73DYfuQP/UqGaBs3+8MjTPdSik2D34a3awFfMxE6o5QJinnymBwR8g?=
 =?us-ascii?Q?KDFJzAHJ5gwXhBt7NKAeNZscwIamEXx8oVY/uGBbNTFwbatf2PCSBhldktS8?=
 =?us-ascii?Q?wBxdSbp9/yehGT7xsBnupVQ0hF6VXQQPbMYao2f71oVEL+UGCIGJcfK3T22s?=
 =?us-ascii?Q?+Uc/Hqs12hISZNdhb8/Wp515i4kT6CmGn8kyNxBFV465wIQtyhq11IaBCgq9?=
 =?us-ascii?Q?AT0MicLN84TJEuCpyqgM4enUfCTqlk1GzeO8Zp2xCGMNlXcPje0nI1BkUfnZ?=
 =?us-ascii?Q?7sg7LylEF+hy4y4vo9FhQKOgGzM7MMqob8p75pYTW5TqNUjetCkBOzjIybi6?=
 =?us-ascii?Q?cu0UjoUZ9Yp/M9OaBBlWOTR+T7e6iP+0T+30IDtCrkoprL1kyMWYjB/2ZuOy?=
 =?us-ascii?Q?B1NTBUCOMY317vCne8OKxslmByl09sK++++bg7VHFhlbkH3q5X63CovXXrjX?=
 =?us-ascii?Q?BmrAE5UcWlAYZ+xj8JV4n6t5PQ5iVdlJ4Ke6Ke3myENAFP+ePcIhpR0NdAF2?=
 =?us-ascii?Q?E3/suMBC/ZzNgkiqRfHpwRcGyq4/j7V02015jTZ5ZBWTDyp/d+ADR4qwBw97?=
 =?us-ascii?Q?EC9JLzzv+cKk65g0iv9fzRNtZf/XW4XEXLJzNp6RL83BQL0ohjm0z/AREXpF?=
 =?us-ascii?Q?0WENhrW967NGV6zEOMDUz7ymujywW8D1INJxU+alTnLDQAM30RVNXpO2QSIW?=
 =?us-ascii?Q?o0RnyX8L7uQtr7COaylAur9cr8ixbzvxInmgrXvTfyfG8trcktNZ/Nb7gkm+?=
 =?us-ascii?Q?NCS2HuPLCsOhu9/qQ/nmgj4wt0CC4isN91xeU/IixM4uNVG/FS7to4N+RJJw?=
 =?us-ascii?Q?PduREMwi+m+mwzoWwDbQ5w2WmiqF83cUX2f2slLL5BF0ZTKV34m8W5iqn2t2?=
 =?us-ascii?Q?3NB3Tnn9pz1vo+ZwB7tUSzd6vqH+rp0itmc7De0QT+vUncIzHFdKHE4CBwaw?=
 =?us-ascii?Q?sBoVnCNjKfUKj3EhpKOj+Asd7Z+DZaUZtPFde1Fjwq+Ga98jBUIFue6pPrT7?=
 =?us-ascii?Q?OPZHbOdSpQ+GRy+tL0sSqD0McosysQAKyF1Vv+uK1k4V0PfZpMeCLZaXNPO1?=
 =?us-ascii?Q?M8VR1cpO2udKzGjyxp4Vp0cZoSSHcWTNYmBpN0i98T/cQeRbiAASwn3WB6QE?=
 =?us-ascii?Q?AlZeeBUocWHpcXdQOAzrgCMTKdZcmDF1LE6YrRCQfNSTlEi47xYr22EgOj8v?=
 =?us-ascii?Q?85MWTsxgq3dadzA/y58gSYIbip+MpUhSGrEwaWJbHHUwSePaLyZfUpNO0ah7?=
 =?us-ascii?Q?kWu4iCXsTl/DGkC72rhwega4BLSEVFN1/4YkEBAdA8HePArN9zCro0Z7VzUu?=
 =?us-ascii?Q?h17JthwoYPKGmqsnm/89XyLtaKMhyTzqQtbXngElRkTG0V2PdCG9qmx+O56v?=
 =?us-ascii?Q?Bs5yAAts4Iv+E32E+/YI3rJhnmC/8IGw3mCmisxhkPGhQJnY2YoVciDBrvEq?=
 =?us-ascii?Q?Jc1F75XKum9AFSN5s16tG+lRBxm8/ZkvwpeZKD8qDEogpl8sZcE/D6F0zZJn?=
 =?us-ascii?Q?u/BShlo5vVWPUMmq8Q4Qjg4MZH8L5zclaLHiITssKpb5XVeZjb98Wh/e51Jq?=
 =?us-ascii?Q?e6FTg9FGZkiAdLGnOPuOnKa3AEKbTKi3EuAQLydDBNthPQoXPevOWLlra/sW?=
 =?us-ascii?Q?XWvl7A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12f3ef6-bbf1-492e-945e-08d9f2345791
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2890.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 16:41:27.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Y0/0uuNNYV2oM5RjDRHyL9JqE90chGg3ECBMgHk6E1rdN/MkxdmI3F8tZS6G+RPMnXAedOaD9SjMSxbvQjaSWx4eJZ5f/mC0Hjg5R7M29Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1298
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170075
X-Proofpoint-ORIG-GUID: QUSIO1V8G1kl9kJ1GyP6fuXz87uVWkcv
X-Proofpoint-GUID: QUSIO1V8G1kl9kJ1GyP6fuXz87uVWkcv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Thu, Feb 17, 2022 at 5:20 AM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>> Just a heads-up.
>>
>> We are still working on the GCC implementation of the tags.  Having some
>> difficulties with the ordering of the C type attributes.
>>
>> Regarding the DWARF part, GCC uses DWARF as the internal "canonical"
>> debug info, and the BTF is generated from it.  This means we had to add
>> a DWARF DIE for the pointer tag qualifier anyway in order to convey the
>> info to BTF.  So now it is just a matter of emitting it along with the
>> rest of the DWARF.
>
> Thanks for the update!
> Do you have an early git branch we can use to test building
> the kernel with it?
> Or is it not at this level yet?

Not yet.

Once we have something working internally we will submit the patches to
gcc-patches for discussion.  At that point we can put them in a branch
for early testing.
