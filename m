Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0256CAEC
	for <lists+bpf@lfdr.de>; Sat,  9 Jul 2022 19:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiGIRYr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIRYq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 13:24:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE5371A8
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 10:24:44 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 269D4r4i010885;
        Sat, 9 Jul 2022 17:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jR6cl88Gb45DBbbJP39P7F753etiRIr9GagCa/nyliM=;
 b=wg93nzr7LUOLHkP2LeaDwlK7eeT8aD1cE3w1BfmyMZblnOeZvIdaKJCMKV8qJTlhdNvC
 +iYmNOdSlYWjTvj5i1aDiTPm0gpuJJrTIIQTQEzu2Q+F3+d9n5u/GNqxXXpL7bKiSDh2
 n4WqsHu5iYSW55I0cQCJj3QGD7R3KzU9hZwiOhxyUOiHjlgR1U1iqCbIrDmoLMKuCPBD
 UMLZZmL9TDr7zEvrix5fiuk035wg5sDHOtQtAG5Cj2OEr0qu/CH/qCWP5TTlIPgiFGM+
 maRiPnyNF662Duq5MUpd0MHAdg0Bh4/5uCBf6Ab0sCWycYVji1mW0UQ8e5OEBhsgPM0a 1w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71sc0md2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Jul 2022 17:24:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 269HAcTU014695;
        Sat, 9 Jul 2022 17:24:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7040gma9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Jul 2022 17:24:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJrc1GgaDjoNXmdjWWMifPz1DxqxWXUeBd5n9xlWMuJeVMrgoDu043G3WNqz66LPSd/Pft3T6vJe1HgaXtVfeXObp/L9WGK0bZoUUUzIsV3PiTXfXpyHp2GCu8Vswqa3c0MGFUVTOg8IvhKR7L72p9ILmOmlV73kiIUhHYpuy9xfuLD6bgSC+KMresT+cWRv2QTvDq5wm9SR463zPAw6lYpCYSgWrLRrgqs9qA1Tk1JqVNAjKHTzVYi9I+J5Wb+VKRHUFR1MzS8kl80Q/ac9vi44prCR2DeAUv4DymunE7cR2FIvE+kSi+5p0VnEBNdnEjUom7JsbRo4dH4RmQkOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jR6cl88Gb45DBbbJP39P7F753etiRIr9GagCa/nyliM=;
 b=WMDNDa+GI536J/Tlc7jNpMaa3JjyPzhDXSGvAusGleElIgyUC8P/6hUW51afQQPEn7PHiUY4rgJbBXWwef0qCNqzcB3SNU5ZraxBDD5aLl1KX4QlO6jYcaMEu+OijDPNwbGyaMn31OuvE2zY5S8caY+3EM1d66C4/oi40jJkrSSkJewaIrtY2vdCsNk+KPq/9l5zHrymoqde6jE4oeIzfkhPSYBujOeKA78Ltbt/SSqE1i/egapit/8xWj35K2lEuFJxp2hrXnnWaFNjQgqg22aw78kgBf1kWReOEulsRYFmwTr53QoYzhh6CdAtbvQJ8SXAmTEOWTSHEcjzUXbbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jR6cl88Gb45DBbbJP39P7F753etiRIr9GagCa/nyliM=;
 b=UGFnzI9eVB65BnL2lUbYb+oNjGfGuxSZOheDZJCTjPS2ww9tPbNTosJbP79XqBZfWPhlHMuERpjq/dcf6eBpTi0lUVpimm5z1pLGk2oXxbQ9+lMqKGzwe9umsDE2SoV1AkzwQ0OJtuV0+ZEGKqHqXp+zaF5jeOQ0ZxWW5uw6D4E=
Received: from DM6PR10MB2890.namprd10.prod.outlook.com (2603:10b6:5:71::31) by
 CY4PR10MB1925.namprd10.prod.outlook.com (2603:10b6:903:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sat, 9 Jul
 2022 17:24:39 +0000
Received: from DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::5fe:9732:ab57:cce0]) by DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::5fe:9732:ab57:cce0%5]) with mapi id 15.20.5417.020; Sat, 9 Jul 2022
 17:24:39 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
        <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
        <87wncnd5dd.fsf@oracle.com> <8735fbcv3x.fsf@oracle.com>
        <CADvTj4rBCEC_AFgszcMrgKMXfrBKzktABYy=dTH1F1Z7MxmcTw@mail.gmail.com>
Date:   Sat, 09 Jul 2022 19:24:31 +0200
In-Reply-To: <CADvTj4rBCEC_AFgszcMrgKMXfrBKzktABYy=dTH1F1Z7MxmcTw@mail.gmail.com>
        (James Hilliard's message of "Fri, 8 Jul 2022 14:59:30 -0600")
Message-ID: <87v8s65hdc.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::20) To DM6PR10MB2890.namprd10.prod.outlook.com
 (2603:10b6:5:71::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5378a7cb-253c-4356-f4dc-08da61cfe6e2
X-MS-TrafficTypeDiagnostic: CY4PR10MB1925:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KxaGZyFyFFqCU73LcqB5HRiOgBiAcO/aUpViNuReOcYWFM2aggPBXY7DSO9O7HVSRXAYxFgNbrjTo3jPrM17Dp1mohPz5woPfwWJW6GzhAPrMZDK1IqT5OiHLpyGV2jZvI8m+97MVnHvVxSX5SU93aVrZQIPFwMKyBAIVJ96xQUpKRSr7T6T2IXrzJ8/XDE6sqZvQ+wQrOI9Am4GZ1e9hrCptZp4mM/9AEEpYPMMjEqNyNJWTf0RGaLAsaFVEPqLnOmgRZii0LNqboyVkrVrfvX8voWp4VqqTo1b+8qe+i+vimbxs3A30QGDnEaBlMraNkmhHeDfylqesHHc8GX4esEnhrZIT3hTLEypVkPUceWVEH45UWfSQyIri7Mj/i1MaYGhag5ARqMLipN2EOPaqQ9fU66wbuXEgwsqCqK7iNMS6bp9kO7y5YBQCmMZJJ2LhY9kDpHkehCw8KGKTqCZYOHn3KqILqz6xZmxhWfmG7nplR9Ed90IRUZIzSC+MkULVgPrHywAszN5fH+o3km+QI2rorryzIFMa/vkZDqmd1UsTrgoAf+nUcGHZjDrkIB4z1Vmt1QlZOfbq3zGdB08G8Bizonr86MkRVFGfUFs/sIipHjmLQTkgOqbSa+Ci2wxYeuHcZrWqifbunuu9FfIAgOvOs/GV8QXLw6xCRCI/aOoM2pAIraPxrdQUjY3OWVuMscCXpoAfbQ5DE/blAM9d9YNa6/ncRi/EDvT8TguqilbcBPPlsmfXZiFjoWCXZl+dK6UC6k6v/TeeIwl1AHxefpZNTpOsy9IsWogCG5mKgsDS7UgKEBqxwoxWDaDnCKmMU1VcZVYui+89qSyJe6O5TaaHyy3/eYElx5J7v3frJUbftpjL9wrPYlAtr9KmJUM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2890.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(136003)(346002)(376002)(2906002)(6512007)(26005)(86362001)(6506007)(6666004)(41300700001)(53546011)(52116002)(107886003)(316002)(2616005)(186003)(66946007)(5660300002)(66476007)(66556008)(30864003)(54906003)(6916009)(4326008)(38100700002)(38350700002)(8676002)(8936002)(966005)(6486002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6EuIuZvgdfF6gAuZYWmYsO2H/IdUdV9BnK+O8i0KmJUwGWyAFtGAm/Y2otZW?=
 =?us-ascii?Q?AAPlUtlInIETO//8EoW6lTQGGlAS5SgU5g1Lo9ArAZ1MrouCcm+rM+tD8A9/?=
 =?us-ascii?Q?4wFVAG41yEtZunzjQyRW/iqjzLIBqnvA2dx7qdeF4vZtt8E7fpG9EIXDvkVf?=
 =?us-ascii?Q?IXfD1u1ac9a5aDd5HncSFyyoUCehV/mEF6GdlwD+ojdeWRTM0MJnPVti5NfP?=
 =?us-ascii?Q?SKBE2amjuh1qb9mtHL0SmYi5cqXtFhDc3TSCk1Z07XdcH1ilEMusnc6SXy39?=
 =?us-ascii?Q?E9J7v22+qAQP5KDe9FMGi3WejN28oRQSLVlTb0ju/FSrPxul+3ciQMphJlGX?=
 =?us-ascii?Q?VxnHQYV2wNDYLgv9l0Z7JXA9W0gh+UtitOg2TRciu74LqNQ1Jlya588IcMoM?=
 =?us-ascii?Q?REFfS9L4R90hY0AhTWEj8u5JqW+x/0D+2661LNbIMYdukGLnI6MsX9ty+G8u?=
 =?us-ascii?Q?gSE3rwYbO1D+4iv+2M7iO9Bs60/CKx9mq4doGBBUyKCOn8YS6Ebj6OYSGme5?=
 =?us-ascii?Q?nxeJFQHgs7KRZ1pXsVT8R6cP/CVxrR5oqJH3jjYEYfCSzvyZVhy/3eENCSzm?=
 =?us-ascii?Q?t39D+cgtq/ufBmSY9T29AjraKmQmeTozXSyGuzdmCyPvcLZw0wpVG6AXtZzL?=
 =?us-ascii?Q?He2erBZMi+rRJibxzEoJRokcqbpROwQuM3bIHvkzcXURDnqlDg7apQgGxFAH?=
 =?us-ascii?Q?R333TDTY8TUpJt9qyL5gdttIRgfz7c/nuBW12mAe4Q0ga8NAcjtN3IucN3Yh?=
 =?us-ascii?Q?g9sh7ypw67TW2fq45zWxAaK7Wsplopol19I12hlprKjQn1olpJqghmCTFaTS?=
 =?us-ascii?Q?WBCSqOIHkOcBKD6VRDe6sKPWdJMtGTp+mfc04AfEdXztRe+XQxwK+9K6pqOV?=
 =?us-ascii?Q?o5f+KJbjzEtw39i6jB3ToV9FjlGp6NpU7C94EG2Qw/Lg7znmEz0WmBEURBSF?=
 =?us-ascii?Q?hLPMsjlJ/7us7MTHzDp6gWdi7Ax5fXSqTNoQ++rMqEM97+Y5BHofIjABIlhs?=
 =?us-ascii?Q?K0B1Ea6irXkvcoLsFRI+smXJdBhamcwNxbvkWtstHEmqDK1bT0W0s7Kf2beE?=
 =?us-ascii?Q?c9fLWx7Id0vXKlboRIQ244YAyjWwDifRVHa4a6rc5XbdYrhspZQR6QNEkwbO?=
 =?us-ascii?Q?jdFVQrG+V4oqzxCO0tXLNkHpmzy3x3oexRfC/8yqsX6mAvrmGuXmEoBDHIZR?=
 =?us-ascii?Q?2alVc5eh2qwWU4Nh5NsotHEIl9/Cra+Dl2CpkXSR8EAPPmll79D8IsQgXt+i?=
 =?us-ascii?Q?MoY9ClAyTEsJ2OB2EsGUQbKVc404lJiSZ/eP1GZE7FLyw4PQOn4sCsm1mtiG?=
 =?us-ascii?Q?NLA/I70Ab0/2IORAO5XwCgZbOw++xbxqiEtk2ehO7DXpeeII4eBGNv6IScmk?=
 =?us-ascii?Q?ednMMchrrcowbfYwAUQQ1/PMeb3bwxJfBJFc/RFvrxjKBOoUA96fraiq7T2F?=
 =?us-ascii?Q?YPz9N6zIK+AI08TYwQyDYmasHVjiAaWd4Mnx3PeergWXZCyPx+gHWJAD8DiH?=
 =?us-ascii?Q?xDkUr+pAikSvqq3folT/FT8Ej/uKbTrI6HVeIMLrHirCrlfn/mmvzYPHqF/i?=
 =?us-ascii?Q?QEC4Q3/Mdav/N8o/d2iPJfKZR2O9IMWPoHW49gRPsVbxjA0t61zMA17aQmdW?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5378a7cb-253c-4356-f4dc-08da61cfe6e2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2890.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 17:24:38.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47i7UWXN5nJ0YDv/yhv9RMdIJNjo3TOv4ZINRMHiZPmOV8fYijaLD5pNxVXeTGDK66YiPqwuqTAYgAjRz/VYUWcOKHyOUPDS7W6sqt7BQrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1925
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-09_15:2022-07-08,2022-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207090077
X-Proofpoint-GUID: ibjNvFP15HqaXObeLckvjCanKdVsJfJa
X-Proofpoint-ORIG-GUID: ibjNvFP15HqaXObeLckvjCanKdVsJfJa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Fri, Jul 8, 2022 at 12:33 PM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> >> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
>> >> <james.hilliard1@gmail.com> wrote:
>> >>>
>> >>> Note I'm testing with the following patches:
>> >>> https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
>> >>> https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
>> >>>
>> >>> It would appear there's some compatibility issues with bpftool gen and
>> >>> GCC, not sure what side though is wrong here:
>> >>> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> >>> gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> >>> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> >>> libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
>> >>> Error: failed to link
>> >>> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>> >>> Unknown error -2 (-2)
>> >>>
>> >>> Relevant difference seems to be this:
>> >>> GCC:
>> >>> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>> >>> Clang:
>> >>> [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
>> >
>> > For functions GCC generates a BTF_KIND_FUNC entry, which has no linkage
>> > information, or so we thought: I just looked at bpftool/btf.c and I
>> > found the linkage info for function types is expected to be encoded in
>> > the vlen field of BTF_KIND_FUNC entries (why not adding a btf_func
>> > instead???) which is surprising to say the least.
>> >
>> > We are changing GCC to encode the linkage info in vlen for these types.
>> > Thanks for reporting this.
>>
>> Patch sent to GCC upstream:
>> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598090.html
>
> I applied that patch on top of GCC 12.1.0 and it appears to fix the
> bpftool gen object bug.
>
> I am however now hitting a different error during skeleton generation:
> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> gen skeleton src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> libbpf: elf: skipping unrecognized data section(9) .comment
> libbpf: failed to alloc map 'restrict.bss' content buffer: -22
> Error: failed to open BPF object file: Invalid argument

What is the size of the .bss section in the object file?  Try with:

$ size restrict-ifaces.bpf.o

Looking at libbpf.c, it seems to me that this may be due of trying to
mmap 0 bytes in `bpf_object__init_internal_map':

	map->mmaped = mmap(NULL, bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
	if (map->mmaped == MAP_FAILED) {
		err = -errno;
		map->mmaped = NULL;
		pr_warn("failed to alloc map '%s' content buffer: %d\n",
			map->name, err);
		zfree(&map->real_name);
		zfree(&map->name);
		return err;
	}

I see no check for zero sized sections in
bpf_object__init_global_data_maps.

Is maybe GCC failing to allocate stuff in BSS that is supposed to be
there?

> Stripped file passed to gen skeleton:
> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> btf dump file
> output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> format raw
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
> [49] VAR '_license' type_id=43, linkage=static
> [50] VAR 'is_allow_list' type_id=5, linkage=global
> [51] VAR 'sd_restrictif' type_id=37, linkage=global
> [52] FUNC 'sd_restrictif_i' type_id=47 linkage=global
> [53] FUNC 'sd_restrictif_e' type_id=47 linkage=global
> [54] FUNC 'restrict_network_interfaces_impl' type_id=47 linkage=static
> [55] DATASEC '.data' size=1 vlen=1
>     type_id=50 offset=0 size=1 (VAR 'is_allow_list')
> [56] DATASEC 'license' size=18 vlen=1
>     type_id=49 offset=0 size=18 (VAR '_license')
> [57] DATASEC '.maps' size=24 vlen=1
>     type_id=51 offset=0 size=24 (VAR 'sd_restrictif')
>
> File before being stripped using bpftool gen object:
> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> btf dump file
> output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
> format raw
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
> [51] VAR '_license' type_id=43, linkage=static
> [52] VAR 'is_allow_list' type_id=5, linkage=global
> [53] VAR 'sd_restrictif' type_id=37, linkage=global
> [54] FUNC 'bpf_map_lookup_elem' type_id=44 linkage=global
> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=global
> [56] FUNC 'sd_restrictif_e' type_id=49 linkage=global
> [57] FUNC 'restrict_network_interfaces_impl' type_id=50 linkage=static
> [58] DATASEC 'license' size=0 vlen=1
>     type_id=51 offset=0 size=18 (VAR '_license')
> [59] DATASEC '.maps' size=0 vlen=1
>     type_id=53 offset=0 size=24 (VAR 'sd_restrictif')
> [60] DATASEC '.data' size=0 vlen=1
>     type_id=52 offset=0 size=1 (VAR 'is_allow_list')
>
>>
>> >> GCC is wrong, clearly. This function is global ([0]) and libbpf
>> >> expects it to be marked as such in BTF.
>> >>
>> >>
> https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50
>> >>
>> >>
>> >>> GCC:
>> >>>
>> >>> [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> >>> [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> >>> [3] TYPEDEF '__u8' type_id=2
>> >>> [4] CONST '(anon)' type_id=3
>> >>
>> >> [...]
