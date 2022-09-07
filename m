Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A005B0CDC
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 21:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiIGTH2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 15:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIGTH0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 15:07:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0A7A9256;
        Wed,  7 Sep 2022 12:07:25 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287IScYN003028;
        Wed, 7 Sep 2022 19:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=GUjyhkQO+2Mc2TjhhyExFK/tZBS7h5B1F1z1arSNzZo=;
 b=EdMF94Ca7cBRn6RjYUxglu0SGambqzAbz5Esgoy0D+AI7JYNXoLFzwiJwpuCC1j1uXS3
 GT/KubCGVkQVAzw++x/T/9qyZUdVrEjCgo86xtZCFM3eFBm8LzrCVXaIEA0kr1cParyL
 EaLfQW/6IX6LLV4tvjRg+BuqnIdq78IyhXvkCi67puddE1VLWopEJnrMLOf2Xcnkf4rP
 w1+7H/4sIQqrqskWB1HyYF+tYSjpxR/mmx+YmGV/mjJAzpscD4DtcIF+CYGWJOOMZw9j
 z8K8tVCl4ddlciEISAvZD/kYAmj60vjUxUemICDzKrowFzOGIWZDzBSwmxgieWQ4lHFi yQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhsstky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 19:07:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 287IFuZC021226;
        Wed, 7 Sep 2022 19:07:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwcasch7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Sep 2022 19:07:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRG8pOTvkfW5CY+NK5iZytaGOIHVWBeuc7otomSNVcH9X9GfJIr5Hs8p3uuBGzU+8XeshE1IN3VTFCRvssfSke1blA1WvemeGMHippojCNDMZwMFzjrTljH/x2I/YeusKPPBnGiWdxSoyI1sRgafI2Q6bYHV4ONHvCLGb3AFOiJddb2rz1nBFzJj22JjHVehSceXLbCjvdWu+RMhnVuSsS2i7kV1uEOXlsoDq1J+VxhdZKfTf3+riQRFnqKQ3e7Ezo3RK5eOgAF+nYOwPWEPwOwIKGNUbHESO/psF8rBjPz7GVi6xZq7m4Ng82F1XowdPya8PSiwk75dkGzrYAAZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUjyhkQO+2Mc2TjhhyExFK/tZBS7h5B1F1z1arSNzZo=;
 b=NP+rDgqaTTW3zpop5Qw8RnYxcojXUf/ey1SMwX4if9oXCGXV0T+zq6sP4LojoVxvuh4XDB9GqywlGbpjH6YuZ9EBss9ZdOsMknTcl/3/ownClUT30xoijFfqPDVq6Yz5AsQ4XfHw1Cn7myfUoAEwpgZ5vGaoY2dVtycZdGfKfOXTlTFOt3osT3R7iC6nkFoBTgRhantpHXaG0F9z9sW9wyivXGeZj8Oc0b+gjO3103vUudtoc/HRJzPvWcXE2dWr0UGy9oTVrS5mECEqE81e9TzvpGadEeTcrEkis59Q8j6STYrYxuMKikDjZOEmT2DmCHqa+uAukzh3BHf3I8+kqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUjyhkQO+2Mc2TjhhyExFK/tZBS7h5B1F1z1arSNzZo=;
 b=MHXcuxtKbig9hUJr8VzhNWEe3sLX+CBf/KMMAUAXdaBzAO6Xxwa1nVECP+Mf1IK8MO6EKOolrn73gYJ56vJo9Jvb+lKhsXGKXIImc3IbLZqinwH3laFrofQvOxROOsVyMDgtdgSzr24V4ydsA/U2mpWejVZP8NQeSu6tOw/8o/M=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 19:07:00 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%5]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 19:07:00 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves 0/7] Add support for generating BTF for all
 variables
In-Reply-To: <CAADnVQKbK__y8GOD4LqaX0aCgT+rtC5aw54-02mSZj1-U6_mgw@mail.gmail.com>
References: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
 <CAADnVQKbK__y8GOD4LqaX0aCgT+rtC5aw54-02mSZj1-U6_mgw@mail.gmail.com>
Date:   Wed, 07 Sep 2022 12:06:57 -0700
Message-ID: <87sfl3j966.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:a03:255::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92bdb1c6-b66f-44ec-4f2b-08da91042403
X-MS-TrafficTypeDiagnostic: CH0PR10MB5180:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXgIUnLFhfgswk4UvoWSysyoZnPIoTScofRYrJcF6gT4iBisVppZgGpHwP3Y53QVcMyLAz5GUf2Uvt9OJiw4yS+63LhYhAU7zkWCaq+sMCA3vu5PkSe8EeShn4yE3AYT8OwLhlV1Bp3ZHFBUNfGHPBUwk3nkbXWnZiKI9xBaU2UzT9GVfDVPrw1tYwNBA52Wqm1tJaioGig2xcTMYUOPivFwynZfso/Lq9PXHbZqbM2UKkn/gtZbXK1fQuTw2k4WY8px4+k/7+wb7FHJGsAtc75uXXoyqhVrWygTsxXBMOLwZhB1LZGnne4tWSi60PAQnimtbn4KVjbaWzyCo6GKWC3533tEbw5ZFmYyBPnU768H0LTqVuOEzai+VDOVOYCMh5gaRQkR+O82dHWUCySkDUCcLE/uun5xMyTNIbHq2Gv21kMf9QZ5M0auyd2T9qx9hUN7rMS2JaLgFjmnVhQdUL3G7vyWH8DNRlRSsSxmHjf91HTeQTGfmNXgk6RMxPrnaQtvzsu3cwycj9DmxUXXBYRSqiHtw1L/B0oCqxk/HMgERiRwisZWBl0w32GsEVapq/a3CGo38r6WkpTUJVWLfDZm47lMgR++Sy2IS8OlD6Av0aS2lWO6EJZ60RstkWBEi6wsC7K/fAYC+rQkYrrfmcVkJc8UGwEvnJvGH73FqH8mFsjjjhw+rSiMuIVWPmFSolaRsfHcmgWvA21AMCQEPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(39860400002)(366004)(396003)(6666004)(2616005)(186003)(8936002)(83380400001)(2906002)(5660300002)(41300700001)(53546011)(26005)(107886003)(36756003)(86362001)(6486002)(6512007)(6506007)(478600001)(38100700002)(110136005)(54906003)(4326008)(8676002)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?piGfvj6J53hdNAOUOfZ4NRgh/h5d8mEveMAeYq9Q7nYFBK58oS/1Z8uoCj11?=
 =?us-ascii?Q?Ou9DaTEP/yw5ZgE/AU6mZ6vgnNyvpYEM5qSSSxxt09VbdWixmsCRFBjWTqwD?=
 =?us-ascii?Q?QOr1/wF2/Nt7WjvE4FRaJXzlaDKlKjE3ALwPRlP72fiL/vac0GC/EEK6LD/G?=
 =?us-ascii?Q?sS51gxV4cvhGILn9/EuVhQL+KqCF1Rsy9tUTAfU/+kAtGKQgTpesM9YRUgVX?=
 =?us-ascii?Q?IUKzmne6midoL1nQFPo0o61z4GKWGAK7pZDYqTknYqLFk3TwBwKcfJemAowB?=
 =?us-ascii?Q?fB2kkheAaqKAM87VX4052rK367dFi89OZXxKsyY0MkdgrYGLGf/8IPPjpEdq?=
 =?us-ascii?Q?XPFFsDfPkVITqaiAaxcX/Vdo//vLVzViP75wR4NUOQnBcvjwln6uWOv3P5X5?=
 =?us-ascii?Q?loOiVP/rvZTE6wFTuu6MhIGSpc0Nnpra9wLB7Oh56O6okx+I46fZSKfTUGFA?=
 =?us-ascii?Q?8L+/pyrL6IAerELkgm+pwH/laCsa0HP5zAc3LCfP/8CfRKMql354RJqfktPu?=
 =?us-ascii?Q?74c9TKYj3LwDgA04aZI7rWTQz2bOiyUmSUKj03cYinBFrdE/sZg6jHS1Zsrw?=
 =?us-ascii?Q?fVQPP4yq1noRrT0kB3VcGpaSvhYicRqhMAavoPAhk7H2h5SWTSMFTpBUizuu?=
 =?us-ascii?Q?/t/EGpufgErX1fCvtfrVm6P4uy4jh/hZ71TnItbi8NeFJsi0s66wTBFAu8J3?=
 =?us-ascii?Q?Se2+62QEncZ8qO5e0+jGVuLcgKMJIfb4j5on4ShTz/fw1ncU89YaQve5k+fY?=
 =?us-ascii?Q?B19isOKAxG8MYb1O6FIgNz8ra94GlTC8qYiLKAcGvc7ctOnW/zIAnwdPzfdZ?=
 =?us-ascii?Q?zoKiLoPIgeY6/wmYB6BrAI5bNk/knKlUaL4ylFR3pMYPjtgWkg6cc/6Dy0Sb?=
 =?us-ascii?Q?TVvHIIqXAHROAsdcWAmsdpK19KF87xM1xIPoMKkfSR7WfvXy6/E66TBcopEo?=
 =?us-ascii?Q?N6n0Pb7MT/U8nW4hQbK7j0J0puS/Y4iAnScoCBHmC/Pv95kuqpCxRGMWgBHf?=
 =?us-ascii?Q?QanhHysQPIBu0GfwmR5yucTWvZoI6PK68H1cW6if+FxLzdoL6wv4CnX2dj8F?=
 =?us-ascii?Q?ZcZhHXuTuD9IIiVZXI83NVxWpoK0gmaKESvirXLmGH1IMSOTpHlu0855PR40?=
 =?us-ascii?Q?iI9kPR/eVsPPd+qCmSzjwCEiYT/m0QC6T8eYq/zF+WT6xElrdwV6azFT/+9Q?=
 =?us-ascii?Q?1FHCbZgDRf/iHu99tcZTym0y/wLRCjCoVKQtcPoYW/3VpRcYiop1U9ePhoSW?=
 =?us-ascii?Q?xVdikP0iCo5A/KjAL8v29NI50Dwm9zgQJ1m4D7j1Pa7z3587Y2kpqFT/lhNm?=
 =?us-ascii?Q?NrrJ9LvF2counWFmM5uXcpsZKbrm8CD5vhd+KBSw/w6h+5PNMWqiIU3xBCdb?=
 =?us-ascii?Q?zHM0kaB4Ilk03KYHmCQD/HtXEMlD7+z3eEochZ4HgnQVYuaaD8a4IcGSgiM1?=
 =?us-ascii?Q?riAd0vQ738tv1OlgF0i7CME9Y/CZ3BLUbGyRu//cmQtlkugSODSFYrNh1eba?=
 =?us-ascii?Q?tR3es0lEO81Nb1cYsIBYjnQbunOkpNI7tmPliT077Vlm4y4HNGFgFaOSmuUu?=
 =?us-ascii?Q?v2yaalsRRIo5m9qSY7GaNA32uf0lxZK/39fBPYGNs69XYuSfSin1R4HGFFs6?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bdb1c6-b66f-44ec-4f2b-08da91042403
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:06:59.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WV3CemKXYwsafOP995zk9hFplPo7N8NOyn9779ZVWaKcoyXtlyRSX7QHgxdqe3bfMiBf4dVPoKbDAsHVQ3SVX6PgT6z0LornO257WuVicU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=796
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070071
X-Proofpoint-GUID: 9kSyJERn0LN--uUkUy7cxFC1hhyWbOcg
X-Proofpoint-ORIG-GUID: 9kSyJERn0LN--uUkUy7cxFC1hhyWbOcg
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
> On Fri, Aug 26, 2022 at 11:54 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
[...]
>> Future Work
>> -----------
>>
>> If this proves acceptable, I'd like to follow-up with a kernel patch to
>> add a configuration option (default=n) for generating BTF with all
>> variables, which distributions could choose to enable or not.
>>
>> There was previous discussion[3] about leveraging split BTF or building
>> additional kernel modules to contain the extra variables. I believe with
>> this patch series, it is possible to do that. However, I'd argue that
>> simpler is better here: the advantage for using BTF is having it all
>> available in the kernel/module image. Storing extra BTF on the
>> filesystem would break that advantage, and at that point, you'd be
>> better off using a debuginfo format like CTF, which is lightweight and
>> expected to be found on the filesystem.
>
> With all or nothing approach the distros would have a hard choice
> to make whether to enable that kconfig, increase BTF and consume
> extra memory without any obvious reason or just don't do it.
> Majority probably is not going to enable it.
> So the feature will become a single vendor only and with
> inevitable bit-rot.

I'd intend to support it even if just a single distribution enabled it.
But I do see your concern.

> Whereas with split BTF and extra kernel module approach
> we can enable BTF with all global vars by default.
> The extra module will be shipped by all distros and tools
> like bpftrace might start using it.

Split BTF is currently limited to a single base BTF file. We'd need more
patches for pahole to support multiple --btf_base files: e.g.
vmlinux.btf and vmlinux-variables.btf. There's also the question of
modules: presumably we wouldn't try to have "$MODULE" and
"$MODULE-btf-extra" modules due to the added complexity. I doubt the
space savings would be worth it.

I can look into these concerns, but if possible I would like to proceed
with this series, as it is a separate concern from the exact mechanism
by which we include extra BTF into the kernel.

Thanks,
Stephen
