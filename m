Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601B656CB5A
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 22:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiGIUVi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 16:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIUVh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 16:21:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AA8140D5
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 13:21:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 269D5A3L006927;
        Sat, 9 Jul 2022 20:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=huZ3hbktLXPhaoOpHn6dpt88v9Vk8wHS8/XM9uG9zE0=;
 b=OJHLR9PzWh8ISDOLwyeXik14F1jBZGzj1AfYATRPMDwl93tiyIM8vj4PRS1RhDxcSKAt
 4ethTZWKqTKZrCtcNU8cOoa/R8MP/PIH1SuxYyNO20iwWiKdJL7Z8FfDP2REQOFEmBgE
 7qy7edi4IU1D58QsOZ5ouvJHKuqQ2RA6gHkCtfrJHoJWWCvQzhkNIYQvBGE+IZv6HaXm
 HCojEpMBAUyF4ju/j16zz+GJHDMGIALO55A2HZItdqzIkc9XtyBY3XGCN54QsDOOreBu
 SBWRkcwM4V3v1irkka23PqpKKatDKyX25uK82HGtyfn2ECaoehRzJv16N4CqRNiS6aqa Tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xr8qdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Jul 2022 20:21:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 269KB8ep002784;
        Sat, 9 Jul 2022 20:21:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h70414und-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Jul 2022 20:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMRMIo3qieYhsuQgAIqU95AgTR5ruDMUiwSx4XWPGf3EL6pne6QedEB6Q/MIaHwHyemyQ31wKqs56WcZCnWfVocjsOyfsXjV6UunJUGY25nRQejKHTdIH3FCwSZHkganTWMNlF0lst8uaTmUYWVBBFz9u9HOf/xpZJeExfUJHA7mGkReRxaSmaDwgw1641D4EdiHshWnyJa27HLYp+VWs6Xirmv4HrVVWyGmKIXEg5StI8wxHIpxuxVK8AVSKnaNqFi4EG1iGvEFfN2Uk/5jW2f/NXTweNZ3Qjvuv8VJGiPvWQ8lcg8/VbtVTSek3Dxq9oxlr8uwRNVpYWhpRRzpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huZ3hbktLXPhaoOpHn6dpt88v9Vk8wHS8/XM9uG9zE0=;
 b=j3hMDypmWO6fQnus4ksW5EuVYaL2bqOxsYbul1+xuZE8eHQeqlUscdwJCv67SbaXOqawdgrVUIBKPzkSnA9qye+wOkY1/2FZU87CVQXtGWAkGaDd7oRbw4G6DEJdmjXbupQeHQ3lkSr185jy/VyYCDPNHrM7WlpUQK0sjW6uWKv5ANa/TiG/LzrdBjBxRqKKntMe5C4D/7yUfXGm4fox53ROFfUGbDJNrSoy8RKiNzWua6RPYwkbnk/fMSySA39Cv5C/X/CPkwzJqDpfj3bOJIXkjDmeb/TJNlWkiPfB8gYB9ZunFZC6JNHpR8s1WRIhyBaIEGKzokjR2cJin5tOFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huZ3hbktLXPhaoOpHn6dpt88v9Vk8wHS8/XM9uG9zE0=;
 b=hRydZ8F/MlpF5/41vdUkE6fm8YJ1Z8Df6NtRlniHD/FCuLSMb6+y3h0QepSFFZ7y3Pm+AymF4uYSc11SkDNk9k1MminqOJPi4CThT5dk3tCprOBSO+MU3mANZztV3f00rQ6Wz7SS9gGzZEX3UH2ukhFFOEtRANy1v52VrZAY48A=
Received: from DM6PR10MB2890.namprd10.prod.outlook.com (2603:10b6:5:71::31) by
 CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Sat, 9 Jul 2022 20:21:30 +0000
Received: from DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::5fe:9732:ab57:cce0]) by DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::5fe:9732:ab57:cce0%5]) with mapi id 15.20.5417.020; Sat, 9 Jul 2022
 20:21:29 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
        <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
        <87wncnd5dd.fsf@oracle.com> <8735fbcv3x.fsf@oracle.com>
        <CADvTj4rBCEC_AFgszcMrgKMXfrBKzktABYy=dTH1F1Z7MxmcTw@mail.gmail.com>
        <87v8s65hdc.fsf@oracle.com>
        <CADvTj4qniQWNFw4aYpsxV5chdj5v+cLfajRXYOHiK_GOn9OLWQ@mail.gmail.com>
Date:   Sat, 09 Jul 2022 22:20:25 +0200
In-Reply-To: <CADvTj4qniQWNFw4aYpsxV5chdj5v+cLfajRXYOHiK_GOn9OLWQ@mail.gmail.com>
        (James Hilliard's message of "Sat, 9 Jul 2022 11:28:12 -0600")
Message-ID: <8735fa3unq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::18) To DM6PR10MB2890.namprd10.prod.outlook.com
 (2603:10b6:5:71::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e2c5ff-f8ea-43f7-d9b3-08da61e89b73
X-MS-TrafficTypeDiagnostic: CH0PR10MB5115:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnGCpXZOh2qHu9kQNMT1PcZa4C+6C++ti3Ejj6EYW+3fPjKg6+AE0gaUYL4Z6bntHbXT1vlGFd+YicnmYLTICPmbV3xX3m+hXr7Yzk1Ac5qZXgo2T3WZmODLnrVgh5MV9s9hC6NyTlQJWTqtJMZu130Dl+6chFNiW4tW11SHc80QlsgLE5qGWJyer2AeOTl1GF2kTDkr1tNm/1OgSOrb4C+tznccZDR4eU+3RGhYWrdHG/2j0dz0Py6Km7fded3ywwHi+ynXcSds9PAGvOPeDB3rUij4tLQp1TWWeX78vLnRYP8NMeg2Tdqu6Xifyh5XTt01hSL9nZ4TSlk4dNug+/I9z7iQxiI0B5DdcMCfPUPbOxgn2n2q8pG5/Hdd7JBMK5oRjttqLVR3mFVz28s7AO4RIRFq9+tjKPRHBFvbEL0IzdS2aQobmCTxngkjWubEksDxHWkzU7i8CAn9F/1vP6D0V5Y+Uf7sWOZumgW1zMxm/0NmhhU2tVxcR+25QCWES0+xloa5+0TBhz6tf8mQGofyafyzntxlp9WaqQOQgOlx/ZCgHZe1hFEc9zLeuTaj/txs3jdUxYtualruZsl0j9Z/RwPCEvNkSkOncIhTzLYdcOi1Lchw6h7rFMiW+v62Y1TZ8joeW5SfyCQRoSDSX1ja+2xcgKRDdOCqk42KhvMAQzhbWGcfdGrx0YzbvZ0OFBiO79VYmj36X4n94c+P1moIrgUf8OLfFc7La1LTHvln7EHFZcG8S5mZD/x2K3bpSZipOrX1Co1ijbaiTVDqCylHUnk/B9ahUL19WrpsYzEphsBHq69YtuTYRCOMZ4G1/HmwH5M+QdxKgzDgjyoMTWIpQSUjLqI3ZIrAXe9T2H2fDqxQ+YuVZfuZXTsQ0GZb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2890.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(376002)(39860400002)(136003)(366004)(86362001)(36756003)(38100700002)(52116002)(6512007)(26005)(2616005)(53546011)(38350700002)(107886003)(186003)(8676002)(8936002)(41300700001)(6506007)(54906003)(66946007)(4326008)(66556008)(478600001)(66476007)(6666004)(316002)(2906002)(966005)(6486002)(6916009)(30864003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHPHr4ZCEFtQPOLOfb643SV+E343jRclib0de8w50z6MWq1eEOLJJDLps8nM?=
 =?us-ascii?Q?5aAPQx0hnCKZdxz3d0n8UCMPXOccxeGuKXbJcRkLw6ITwqDg6eW35ZBtuvdM?=
 =?us-ascii?Q?lR2w1AxSDlD0gtKrTmne0lrNisp7woZyj/2yN7caHT2TXigHPYtGtMiJET96?=
 =?us-ascii?Q?UA6JJc2ZVh7xg0pPYNsoz7kp3WvWCJv0SqIr5mDTUKaoK3L6yJX7P+BXwyGK?=
 =?us-ascii?Q?2VucjGFM4PoTslcKa26pwhKFu4g+QKbT8DbtXYJoEdXVDCRgVBgcLSKeHbyB?=
 =?us-ascii?Q?rNbYfACefE6KXfSac5LoAplGq+36NX2Q3Cf/P1/b73Tj35yPsTZ1O5FcZqiw?=
 =?us-ascii?Q?Kar1YZ9lrF8+xPs87rPwEdvUJaRltqeTOwfTTogYR5m+nYVCdw/Rpt4zXZeV?=
 =?us-ascii?Q?E+sN+RUj6waH6ZdfSV029WZ/aCs1hzOgY38oNL4SN9uuBx7YaU0Yrxd2WYmv?=
 =?us-ascii?Q?2GFYq1C0y4K3XYJ7nyv2C+vvQFtY3bFqtXD5x9OTi/jlYXKWPGjRwuZ6nDmz?=
 =?us-ascii?Q?l7q6nYvHrZBRfHNXIeNJlTZHEJR/ihpjeUSKGjTt8Jt0sZ6hEaDMeVOX7EcP?=
 =?us-ascii?Q?66h8E2eZhW/gx2+LLREIXk1mq2JPqam80Llf9a12rHblYA/5Tx1aRRkDa7hz?=
 =?us-ascii?Q?Z+S0QQQy2NkqfjgH/t6r2saleXbtSqURuWaNVqEPXAHoc+Hk+OYilYh70z4t?=
 =?us-ascii?Q?2qhZWoXotPSqzsQXCh1QVVPwdpAGrzoEYU61q2IdmlIzX9YUigKkvZ5Wzljz?=
 =?us-ascii?Q?24HNP03Qar4DBaDxYQkn8d5Kz4rXQx6SeN+duYAC676vVjOeRyZlMdVGH4W8?=
 =?us-ascii?Q?erzonwKGSI7GcavC3GYkoFdr1d+6aJYuAKBUABQ6CXxuGCI1GAOHRG52hgX+?=
 =?us-ascii?Q?xjjjSJkaKBiv+QQCKw2XQP363sG0P4nfLj77LHb4QgCEO2u67cLYsDsnkWQu?=
 =?us-ascii?Q?Tx8KW+9eXp/pCNAQMeCNMHMc0qkSApnjI8sjeA2UCRsV0slJKh2pZseXL0dX?=
 =?us-ascii?Q?3BTQPcDP1KDli/Ks+TYbZ3K6o1wof+4wyqHXO+T2cnzjaShnjzNIG7fFGseS?=
 =?us-ascii?Q?0GlfDcQfwpB9MUWkfGI42WtD+fZ/9sdt3hY8k5maELZ+I7b79M18kU0tbSdC?=
 =?us-ascii?Q?K89BLu+EACMGlqK9g5i3tz9L2SOQibG/WXjrahAObc5DAfB+xS3sTPEHehyH?=
 =?us-ascii?Q?KQNZOcVCpdupd2t56eNJtzOno4zRp/G/N7NS4BzUZTYbIOoxIWkN9y47yfTK?=
 =?us-ascii?Q?SrUAmDiABuNHmE8FHYzf7xZ/GpgJm6cKBMSf0JRH/oA7chwssaq+zFdt1RX5?=
 =?us-ascii?Q?qh8kMVuPsORUb7UcUr2VFMyJYHxveM8rBdCjT6BP2rde19anAYQiyp7pUlh+?=
 =?us-ascii?Q?bYZ2UXBcFbByK7XtkgrUwdCsk2Me6D/F2TMaMlJgesQ0NnusGYv5QKL+QQOH?=
 =?us-ascii?Q?M3KShT2OwjG5OSTicVseNftCQDRsKsTPTM/9abDCXKBQn4rKUQZs9r4Mtfex?=
 =?us-ascii?Q?TxDe3D/5wnLuhewR5SOBmCekhxqtd3SCa4sYxSMuL+iI9bUivosJmqh4fZRm?=
 =?us-ascii?Q?SPQuwxau03ZtxYenVGWZuV/1GCInG8tk6Wd9YnzuaLDO873BGxpdZ2Al34ai?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e2c5ff-f8ea-43f7-d9b3-08da61e89b73
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2890.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 20:21:29.7995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bi77AAsVQN2nQWd0Y5PoEFLVxQLb7pa4RdZDasggMsTdICFB4zyn/L5ysJ3B+XywGmobFkFnBf+QCRTyqYrhabyHg43Aef1szmOm/UBQSFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-09_19:2022-07-08,2022-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207090091
X-Proofpoint-GUID: ELBgeiQmJVOq427uIl_4drHMAbpihfWT
X-Proofpoint-ORIG-GUID: ELBgeiQmJVOq427uIl_4drHMAbpihfWT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Sat, Jul 9, 2022 at 11:24 AM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Fri, Jul 8, 2022 at 12:33 PM Jose E. Marchesi
>> > <jose.marchesi@oracle.com> wrote:
>> >>
>> >>
>> >> >> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
>> >> >> <james.hilliard1@gmail.com> wrote:
>> >> >>>
>> >> >>> Note I'm testing with the following patches:
>> >> >>> https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
>> >> >>> https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
>> >> >>>
>> >> >>> It would appear there's some compatibility issues with bpftool gen and
>> >> >>> GCC, not sure what side though is wrong here:
>> >> >>> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> >> >>> gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> >> >>> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> >> >>> libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
>> >> >>> Error: failed to link
>> >> >>> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>> >> >>> Unknown error -2 (-2)
>> >> >>>
>> >> >>> Relevant difference seems to be this:
>> >> >>> GCC:
>> >> >>> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>> >> >>> Clang:
>> >> >>> [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
>> >> >
>> >> > For functions GCC generates a BTF_KIND_FUNC entry, which has no linkage
>> >> > information, or so we thought: I just looked at bpftool/btf.c and I
>> >> > found the linkage info for function types is expected to be encoded in
>> >> > the vlen field of BTF_KIND_FUNC entries (why not adding a btf_func
>> >> > instead???) which is surprising to say the least.
>> >> >
>> >> > We are changing GCC to encode the linkage info in vlen for these types.
>> >> > Thanks for reporting this.
>> >>
>> >> Patch sent to GCC upstream:
>> >> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598090.html
>> >
>> > I applied that patch on top of GCC 12.1.0 and it appears to fix the
>> > bpftool gen object bug.
>> >
>> > I am however now hitting a different error during skeleton generation:
>> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> > gen skeleton src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> > libbpf: elf: skipping unrecognized data section(9) .comment
>> > libbpf: failed to alloc map 'restrict.bss' content buffer: -22
>> > Error: failed to open BPF object file: Invalid argument
>>
>> What is the size of the .bss section in the object file?  Try with:
>>
>> $ size restrict-ifaces.bpf.o
>
> $ size output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>    text       data        bss        dec        hex    filename
>     386         25          0        411        19b
> output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o

Right, so the .bss section is empty.  I see a `const volatile unsigned
char is_allow_list = 0;' in restrict-ifaces.bpf.c, but that goes to
.data and not to .bss, as expected.

If you build restrict-ifaces.bpf.o with LLVM, is the bss still empty?  I
don't think the code in libbpf.c even checks for this eventuality...

>>
>> Looking at libbpf.c, it seems to me that this may be due of trying to
>> mmap 0 bytes in `bpf_object__init_internal_map':
>>
>>         map->mmaped = mmap(NULL, bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
>>                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>>         if (map->mmaped == MAP_FAILED) {
>>                 err = -errno;
>>                 map->mmaped = NULL;
>>                 pr_warn("failed to alloc map '%s' content buffer: %d\n",
>>                         map->name, err);
>>                 zfree(&map->real_name);
>>                 zfree(&map->name);
>>                 return err;
>>         }
>>
>> I see no check for zero sized sections in
>> bpf_object__init_global_data_maps.
>>
>> Is maybe GCC failing to allocate stuff in BSS that is supposed to be
>> there?
>>
>> > Stripped file passed to gen skeleton:
>> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> > btf dump file
>> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> > format raw
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
>> > [49] VAR '_license' type_id=43, linkage=static
>> > [50] VAR 'is_allow_list' type_id=5, linkage=global
>> > [51] VAR 'sd_restrictif' type_id=37, linkage=global
>> > [52] FUNC 'sd_restrictif_i' type_id=47 linkage=global
>> > [53] FUNC 'sd_restrictif_e' type_id=47 linkage=global
>> > [54] FUNC 'restrict_network_interfaces_impl' type_id=47 linkage=static
>> > [55] DATASEC '.data' size=1 vlen=1
>> >     type_id=50 offset=0 size=1 (VAR 'is_allow_list')
>> > [56] DATASEC 'license' size=18 vlen=1
>> >     type_id=49 offset=0 size=18 (VAR '_license')
>> > [57] DATASEC '.maps' size=24 vlen=1
>> >     type_id=51 offset=0 size=24 (VAR 'sd_restrictif')
>> >
>> > File before being stripped using bpftool gen object:
>> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> > btf dump file
>> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> > format raw
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
>> > [51] VAR '_license' type_id=43, linkage=static
>> > [52] VAR 'is_allow_list' type_id=5, linkage=global
>> > [53] VAR 'sd_restrictif' type_id=37, linkage=global
>> > [54] FUNC 'bpf_map_lookup_elem' type_id=44 linkage=global
>> > [55] FUNC 'sd_restrictif_i' type_id=47 linkage=global
>> > [56] FUNC 'sd_restrictif_e' type_id=49 linkage=global
>> > [57] FUNC 'restrict_network_interfaces_impl' type_id=50 linkage=static
>> > [58] DATASEC 'license' size=0 vlen=1
>> >     type_id=51 offset=0 size=18 (VAR '_license')
>> > [59] DATASEC '.maps' size=0 vlen=1
>> >     type_id=53 offset=0 size=24 (VAR 'sd_restrictif')
>> > [60] DATASEC '.data' size=0 vlen=1
>> >     type_id=52 offset=0 size=1 (VAR 'is_allow_list')
>> >
>> >>
>> >> >> GCC is wrong, clearly. This function is global ([0]) and libbpf
>> >> >> expects it to be marked as such in BTF.
>> >> >>
>> >> >>
>> > https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50
>> >> >>
>> >> >>
>> >> >>> GCC:
>> >> >>>
>> >> >>> [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> >> >>> [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> >> >>> [3] TYPEDEF '__u8' type_id=2
>> >> >>> [4] CONST '(anon)' type_id=3
>> >> >>
>> >> >> [...]
