Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A95B44D3
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 08:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiIJGyb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 02:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiIJGy2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 02:54:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF623E73;
        Fri,  9 Sep 2022 23:54:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28A4vWaX002941;
        Sat, 10 Sep 2022 06:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=beu4C+Ggx3Io6RsLY2L4ylCOALBPJ0GlE0qIVdEcnK4=;
 b=1cEbllljS/yCfxxsd/IoNOcdcgxf6BTP2+rmcjqLgNnQb/teHrO4S4Lq4lfWP5bv+vIP
 mMtEZ2rE/603WerWdyBT4CLJCZ0iNTI3BW9cBpQwHCDoC+t62oQEBamBEtYJJdcgQFSX
 F3I2jG2dSNcte5AfP0vA8MIzeFiig/eCSH92Me0LiCU74fhQQ7GVhYeUPBgRxHJFENDk
 yAjVF7v12RxO1sjVTXAjk+k69wdNwz5dTm7oRRtavQrk6oaBgT1032IbrzOiqg7uCtcF
 duxbcaxrNkfOWnEd57pNSbpt3Ngws/DM3SkzOzH1oSWHsh1QRRE+ySBCN1jY/OKcdNLp 0g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgh0c06hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Sep 2022 06:53:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28A1X7Hg012557;
        Sat, 10 Sep 2022 06:53:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh10v83p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Sep 2022 06:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTq6ZkyLhjMZJqZw9+rOtrkir+CKsVVspLfiuuNeK9/nqJqCa1SOeCvFT0E1MRMK5b8qH25xmPBLUdO2t0lC/AZaXa6HuoJjYDU1hafmz9B63UgFupvEXDKwdB4u10NTuF1jkzz67enVc4f7iKhxe9zDhxqpRaR+TquyEjdNNjsF28rIwhrMnp8Zo18yvVA0U3y0/kaXQHZWsGt0GJDm/uS3dAn5kPLqIFzsk+6e1lPumUMcj6TjlqbNJOeCUdyO7YufQsjsrPIhoJljtDtyOAfQq7wW22yyk3aJAnB9fk/LyNjNmQCvESHIqsRk6M09dpa9mp02QSYF8IIkKa7Ssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beu4C+Ggx3Io6RsLY2L4ylCOALBPJ0GlE0qIVdEcnK4=;
 b=Z+rQ2fcOqtWuRCB/gHCG/TjYxE1Seb0I7MyVL1n6Mn722foXPv89LgDpi7NqranClNrZL6sIoRM++vqKUMq4He6X+Ff3GyFCdZi0MToDFzDLM2m8J5MpKP76yDjkajmrBSh3RvtdIeP8SgVep8opUKxvavivxhBvwpfqJfSVPIefey7D9uadmFxhcmBbqqz/2SCx56/7WRaAnQKQ86ko3kgqgD7iozdY7zLc2namDcmdDCVFO567gSKqMPdrwG86xLHOccjZfp2Hvg0LdlOwiy3VN1BJHMiYP7zpZPvyUmYa9x7D/74T2YPK5VDCqqwJvwyR8K9OLyN0vhapbu0D2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beu4C+Ggx3Io6RsLY2L4ylCOALBPJ0GlE0qIVdEcnK4=;
 b=UOqei2j1DVS7o4/inDOyY/ruA3Wii257QeA4zusLES8QlsDvLBGwizShnXvq5nIOUnGYaUqxNpus/Tf1YBvh6LLmYhLovwFc9SMGNMaFD5R5Hwq7t0JYmvcAJcOwBYci/lUwvDGpyoxnBO/YU0+s1OQMvjIKO4mMyDM/zMzptrU=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CO1PR10MB4611.namprd10.prod.outlook.com (2603:10b6:303:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Sat, 10 Sep
 2022 06:53:35 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7999:3e83:f609:7a35]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7999:3e83:f609:7a35%3]) with mapi id 15.20.5612.019; Sat, 10 Sep 2022
 06:53:35 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        David Faust <david.faust@oracle.com>, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, elena.zannoni@oracle.com
Subject: Re: [PATCH v2] libbpf: add GCC support for bpf_tail_call_static
References: <20220829210546.755377-1-james.hilliard1@gmail.com>
        <CAEf4Bza6g4tZDtuKCaBwVVJSHUrLYh=pbUffPBpmWtR-xyXyqQ@mail.gmail.com>
        <CADvTj4pF=D7PEBF-LK_sKckRUCq-vd9ZjohpiEgLvORg8UaZyw@mail.gmail.com>
        <CAEf4BzbjMWC50J-mn_aNd2BeJWU=nLJmsJCAVvTqLSYsh4RejA@mail.gmail.com>
        <CADvTj4qLhgQ1K30dKoviw10G6f5XTv7T6SChUPvYnNWZGxw4OA@mail.gmail.com>
Date:   Sat, 10 Sep 2022 08:52:46 +0200
In-Reply-To: <CADvTj4qLhgQ1K30dKoviw10G6f5XTv7T6SChUPvYnNWZGxw4OA@mail.gmail.com>
        (James Hilliard's message of "Fri, 9 Sep 2022 16:53:24 -0600")
Message-ID: <871qsjyb41.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::9) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CO1PR10MB4611:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b40d0e-7206-412f-6892-08da92f92e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJDgwaaK4Nj0DMlcfBCsZYgpmjMuSChiNSqhbncPqPCNvDLHogFs9NNngnV+XPVFBEGlbBn3hkkGxk8+0q3zmUrlXwSp7iBU5uM4+xgUCIjie/65LpHT4B5AoqYYKj3Eeg9H1EN11pTEz8siQv6WMv7EnYe6bLE56da41RRj3+f6a9TiQj36U7RpWbm1F5tL0Npwoo9fEQ2Hz/cPEfvHUUhpzX4cbPnHVNKn9J+uGSqrxhlRYj9XP2flCzbGQMQhVI9BugqZ/vCiwG/g8PRiD+Zf+xcYoQ0FRatxljJfAOlOOzFfXUdjec+bDUxMwETLSBg/JkkWleDWRW8chwZiWDEQ/iSVATuJXHclLABjzVQ6GzLAeX8pw1pvJnhbCvb521gF7D5ZCx8AdrSnWVFmn7dxFTyna7cva4uhEqmlG/ATrUWcpRQRmXheHX5CkvomD+3krGGlK5R8JgFlF4+oJw6McZAKT8bmb/ofpGUaXDcCXYt1L6+DraY3sBrwsRLQ3/vIJ/FSi1ljjKTZowlsaMrXYjMVZZ8yypCsAzPpkPLN/dxstQUlNszTAs1RFxVIdpqxoVY+LUPxxI3t1zErj4XJG3qRwTwwINS9amt9kHZOq/9PdRdM/NgHzl+4YXNzK4hBhQVkEB68j3DOe5KZmsP9ejZgIfrOhn5xKFqZy9AYFN+C7qefCHpwC+4dYqRHNyhzy5yK0QbvMopG9IYaNfX68J69vhI+8RnRhKjK/bYYzF9GIOq/2A9u3nW9YNSgxgYjVSSTBSgiuN5PUhoPlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(396003)(346002)(366004)(2616005)(26005)(6512007)(6506007)(107886003)(6666004)(53546011)(66556008)(86362001)(2906002)(4326008)(5660300002)(8936002)(8676002)(6916009)(7416002)(316002)(54906003)(66476007)(66946007)(478600001)(966005)(36756003)(38100700002)(41300700001)(186003)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wwdneDk5qnLo6hJhldqMMVGH2PxRFAbt5A/8/+Y7EJ/Hd70u8z1sOEJpijF7?=
 =?us-ascii?Q?n/aYENHXN1u22mcd7vgGxMsJMMdTgJHkgcE0B3k+1Tn3KHU2+wXVEnCBjw+y?=
 =?us-ascii?Q?2dYsYpJYhP2QCL97nfF8DeEQ+xqN8a7vUDZw4TEGf3SD+00OdKrOq1To5w8+?=
 =?us-ascii?Q?xe6XfTvRrZnc9G3gUtFLCFJsCpHZ+uZxmxXgoto1ipLG9YY/hUeTocUjrxPX?=
 =?us-ascii?Q?nH6IozetMptoK/N/pEj7LkxxtYGRuWdyeEAy9JVmgc/WArgLF64A4jUPOb6J?=
 =?us-ascii?Q?LYIsK2z092ADHoST8OtEeCuOZ0j9KJh5tTNoHJb9BAxPNkeF3BmNt5Cyj934?=
 =?us-ascii?Q?gT3hc250NIqlq+RxXa2IJQcdNjPItqVKkssewoE0qJzlh0hvmZwAjR5y3I/g?=
 =?us-ascii?Q?oKaLSKl6BeE62MhqMDA7l6OXu425A0TK655G3v3eGzSxJS2Qy38Bibh1mdRz?=
 =?us-ascii?Q?IzUN/eTrEQIurzUECoVKMKjLxobEb1Ls1vB9HgRfooTdBQ9kavWEO5ZHbtRy?=
 =?us-ascii?Q?JjHL+RnvnmSdxlVhKONCSt1pBihdClFETzkm5WKrnQXFg122zGQiDBy0j2Ad?=
 =?us-ascii?Q?yq3jJc4/edNFumga6c/qfQ2rO94+9TlS+f4UNQNsdFH1fgvuy6AwKt5wSBEe?=
 =?us-ascii?Q?SP534DuLX4rHwAmzkzYa8oU65EeOHcOGb02S68DUUs9aOY2YfWAxXS6m40OS?=
 =?us-ascii?Q?2Wb0nhFSNLLNi60pLVkxCCcWfZUfJviGuw8uQ9+KBprPOplk7gO5ddaQBd1g?=
 =?us-ascii?Q?EWLw1ahFnxxhFOWC+BzL3d1peKglHu/H2Knf1aSRVjpqWR5ND/5qn2VWEC2j?=
 =?us-ascii?Q?j8LKnHo4NhizzTg5UJGp01l/iFL2tEMjZvEZFHN5Gx4FDGi6zvRXkAZrSlPD?=
 =?us-ascii?Q?iUmQRwhUpveMwW5t2JKBWLaols7Bdha+q3whiFsEVToZNscB8+mzuJOw8oL+?=
 =?us-ascii?Q?THIExPUzbcAbXL8k1eBHHG0dlSUJunEDBxiLkiEx+DTTZbNOg3wVHkEW/KMY?=
 =?us-ascii?Q?QfPyJeOXNeed/nhqjvQ2JMOQfJ3ar8wyxVMgrIeadHla+dKZ3HoZmhDuZvoO?=
 =?us-ascii?Q?66jNuqk2DwltbJY5Fp9d4vCphb4iwMBOLh+DzqNRghooe1q6FuJPx/YgPCYl?=
 =?us-ascii?Q?e+0kNz5GUy1Fr61BxUV2vFXog1cED2fdlgv2sRlSSO7fiHMfF+GNsS6ssZfC?=
 =?us-ascii?Q?u/TRycN7UVeOO1/CRV86Z6JqKKWeeLhW9EENPhQtg0X2p0lXyocvhaYfD79L?=
 =?us-ascii?Q?XzC5SVNj2oenm9QQ1KkEuUGlJgp36R4Zf8oMfxD2fPftOl1Uek51yfzkLuO2?=
 =?us-ascii?Q?SxHdUKQRzUu3HLBBqXmfGsUOP2LzadF3Iuy1daUUOVw9b6vSvBjwvXtn9+q2?=
 =?us-ascii?Q?MTDc0AItN0WrkhOhTYVBkD/oii/H4HzAX+cfbDl5sCcdq31qQSXHurt++P0P?=
 =?us-ascii?Q?hKe1pXu3iv3kiCna15Goxf+Q49Y+0kCqnQ5v8rEqB7z+PdoY4MTSzl8I+t6P?=
 =?us-ascii?Q?eCZxl4oBFHmHKB5t2i0RIhZ6sfwDQ/qH74PhQEbiTTfn8nw6awHt21YwS1Ek?=
 =?us-ascii?Q?EdnOz1DJGKhPVlqAJ6F48nftOpSREEfw6zlMhqNs3BW/11p9FeJEOGBKcEPz?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b40d0e-7206-412f-6892-08da92f92e85
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 06:53:35.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsY++B7VyP6wgWQCei/NtvxXZ0z7/1DrulFNufB8MErbar2WPOXT5K9arj4gL2K0E3y59asyL8QSqlarxqP9km1TtOgyDFRWBHiebHAAdss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_03,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209100023
X-Proofpoint-GUID: hYmBlp4c5XA59VO2q-76jhYQpsI3hVVt
X-Proofpoint-ORIG-GUID: hYmBlp4c5XA59VO2q-76jhYQpsI3hVVt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Fri, Sep 9, 2022 at 12:56 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Fri, Sep 9, 2022 at 11:23 AM James Hilliard
>> <james.hilliard1@gmail.com> wrote:
>> >
>> > On Fri, Sep 9, 2022 at 12:05 PM Andrii Nakryiko
>> > <andrii.nakryiko@gmail.com> wrote:
>> > >
>> > > On Mon, Aug 29, 2022 at 2:05 PM James Hilliard
>> > > <james.hilliard1@gmail.com> wrote:
>> > > >
>> > > > The bpf_tail_call_static function is currently not defined unless
>> > > > using clang >= 8.
>> > > >
>> > > > To support bpf_tail_call_static on GCC we can check if __clang__ is
>> > > > not defined to enable bpf_tail_call_static.
>> > > >
>> > > > We need to use GCC assembly syntax when the compiler does not define
>> > > > __clang__ as LLVM inline assembly is not fully compatible with GCC.
>> > > >
>> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> > > > ---
>> > > > Changes v1 -> v2:
>> > > >   - drop __BPF__ check as GCC now defines __bpf__
>> > > > ---
>> > > >  tools/lib/bpf/bpf_helpers.h | 19 +++++++++++++------
>> > > >  1 file changed, 13 insertions(+), 6 deletions(-)
>> > > >
>> > > > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> > > > index 7349b16b8e2f..867b734839dd 100644
>> > > > --- a/tools/lib/bpf/bpf_helpers.h
>> > > > +++ b/tools/lib/bpf/bpf_helpers.h
>> > > > @@ -131,7 +131,7 @@
>> > > >  /*
>> > > >   * Helper function to perform a tail call with a constant/immediate map slot.
>> > > >   */
>> > > > -#if __clang_major__ >= 8 && defined(__bpf__)
>> > > > +#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)
>> > > >  static __always_inline void
>> > > >  bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>> > > >  {
>> > > > @@ -139,8 +139,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>> > > >                 __bpf_unreachable();
>> > > >
>> > > >         /*
>> > > > -        * Provide a hard guarantee that LLVM won't optimize setting r2 (map
>> > > > -        * pointer) and r3 (constant map index) from _different paths_ ending
>> > > > +        * Provide a hard guarantee that the compiler won't optimize setting r2
>> > > > +        * (map pointer) and r3 (constant map index) from _different paths_ ending
>> > > >          * up at the _same_ call insn as otherwise we won't be able to use the
>> > > >          * jmpq/nopl retpoline-free patching by the x86-64 JIT in the kernel
>> > > >          * given they mismatch. See also d2e4c1e6c294 ("bpf: Constant map key
>> > > > @@ -148,12 +148,19 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>> > > >          *
>> > > >          * Note on clobber list: we need to stay in-line with BPF calling
>> > > >          * convention, so even if we don't end up using r0, r4, r5, we need
>> > > > -        * to mark them as clobber so that LLVM doesn't end up using them
>> > > > -        * before / after the call.
>> > > > +        * to mark them as clobber so that the compiler doesn't end up using
>> > > > +        * them before / after the call.
>> > > >          */
>> > > > -       asm volatile("r1 = %[ctx]\n\t"
>> > > > +       asm volatile(
>> > > > +#ifdef __clang__
>> > > > +                    "r1 = %[ctx]\n\t"
>> > > >                      "r2 = %[map]\n\t"
>> > > >                      "r3 = %[slot]\n\t"
>> > > > +#else
>> > > > +                    "mov %%r1,%[ctx]\n\t"
>> > > > +                    "mov %%r2,%[map]\n\t"
>> > > > +                    "mov %%r3,%[slot]\n\t"
>> > > > +#endif
>> > >
>> > > Hey James,
>> > >
>> > > I don't think it's a good idea to have a completely different BPF asm
>> > > syntax in GCC-BPF vs what Clang is supporting. Note that Clang syntax
>> > > is also what BPF users see in BPF verifier log and in llvm-objdump
>> > > output, so that's what BPF users are familiar with.
>> >
>> > Is the difference a BPF specific assembly format deviation or a generic
>> > deviation in assembler template syntax between GCC/llvm?
>> > https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#AssemblerTemplate
>> >
>>
>> Sorry, I don't understand the question. I'm talking about the above
>> snippet with "r1 = %[ctx]" vs "mov %%r1,%[ctx]". Seems like the rest
>> stayed the same. So this would be a "BPF specific assembly format"
>> case, right? I don't know what else could be different with GCC-BPF
>> assembly.
>
> I mean it's unclear if it's a generic assembly template format difference
> that applies to all targets or one that's BPF target specific.

It is certainly BPF specific.

I think that when I first wrote the BPF GNU toolchain port the assembly
format used by LLVM was different than it is now: I certainly didn't
invent the syntax the GNU assembler uses for BPF.

It seems LLVM settled with that C-like syntax for assembly instead,
which is very unconventional.

> Anyways for now I sent a new patch so that bpf_tail_call_static is defined
> on non-clang compilers so that it will work when GCC-BPF supports the
> existing asm format.
> https://lore.kernel.org/bpf/20220909224544.3702931-1-james.hilliard1@gmail.com/

I don't think this patch makes much sense: these guards are designed to
avoid compilers that do not support the inline assembly (as presumably
happen with clang < 8) to choke on the header file.  That's also the
case of GCC BPF at the moment.

With this patch, people won't be currentty able to use bpf_helpers.h
with GCC BPF even if they don't use bpf_tail_call_static.

>> > >
>> > > This will cause constant and unavoidable maintenance burden both for
>> > > libraries like libbpf and end users and their BPF apps as well.
>> > >
>> > > Given you are trying to make GCC-BPF part of the BPF ecosystem, please
>> > > think about how to help the ecosystem, move it forward and unify it,
>> > > not how to branch out and have Clang vs GCC differences everywhere.
>> > > There is a lot of embedded BPF asm in production applications, having
>> > > to write something as trivial as `r1 = X` in GCC or Clang-specific
>> > > ways is a huge burden.
>> > >
>> > > As such, we've reverted your patch ([0]). Please add de facto BPF asm
>> > > syntax support to GCC-BPF and this change won't be necessary.
>> > >
>> > >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=665f5d3577ef43e929d59cf39683037887c351bf
>> > >
>> > > >                      "call 12"
>> > > >                      :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>> > > >                      : "r0", "r1", "r2", "r3", "r4", "r5");
>> > > > --
>> > > > 2.34.1
>> > > >
