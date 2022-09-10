Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C615B4543
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 10:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIJIoB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Sep 2022 04:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIJIoA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Sep 2022 04:44:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E052AE10;
        Sat, 10 Sep 2022 01:43:58 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28A4vmYc010271;
        Sat, 10 Sep 2022 08:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=/9RSrIY9jY8IYOjPwwNEzaCp5NRDnqzOQK5TnbsrU04=;
 b=0a/k/33zUzRhoi3SHYnweTGb0xsw5AtVQpy3zB6AYSNk3EeVZwu5CwZBq4GloLiMVVlf
 FN4G+NB0JPxXM15NFjLIEcZuKzZyseReWUmRWPFANEe1ES/mtC+302AFK1n8kJ/T+80w
 /zgp2L65WMx1mOsk4OwLbvPjcNsCOo5p62mOpP6iGyLjOXydASFYYeWQeYdgHEiXewg0
 hBmL+7DEKyAR3T7GCWjWnTvhOUGtCoxw/BrFa57A3CLL/5sio0oUKKHuIPbhXB6EXUUh
 8cBZy/UxoecfD7Dpb0dIjp7G0v5ivpXFKzIvadkjL4KuOvQRDP5gnRU5Rj4ZpVpNQHyp yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jghc2gagw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Sep 2022 08:43:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28A2pEu5013710;
        Sat, 10 Sep 2022 08:43:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jgj59m5e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Sep 2022 08:43:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8607soiqvucJ9xZMAFN8sSHbKhtnvoAF03G/LywmAVpb1ZHjLVAt4PeAwfI67e0AlrozN5VtHKjf2FAbWHrr1TRChnrTFnWJ4F89JznX2HERxz6/H+8vCRN2PfQqnPUTZ29PhY8dKmDIdR5YEbdDH9zNFDKyH3mGVxt8ug1QIdqbKHMAoyCK+AZ3EQGG4UItTeltarwh4rBtVqlNEH1FBM/uPgoiKK2pH68eU1/ODvRCOROC3IF7Kri+IueoFuXO+LWXqCXgkkK2TPq4FRz6zZiwTWJCFLAylukWdWtGX3re4SlE+5cxTJRsY1DXhBGjwuayvnXjxUQf+m7kPWyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9RSrIY9jY8IYOjPwwNEzaCp5NRDnqzOQK5TnbsrU04=;
 b=oH5ZtOuu7wPOHcD15JCgo/DLK62UZLBlfP2PxY1C818q/eSDbw0bYxnPhzs/2zVYJghR3FXCoQ7kwEaKeaP9K6jB5auET9R5hcmzXYrQhQswl0oR19C2KHUjue9dNU3OX+y7DgX1V4U8oVWiPrSUB4IhJf4/TQdrk89RCZWkL4sbBgg3yKbZ6lLjWIed5fu2LRkJEippWbXAiHjXJ9++52L19NS40gpqnllAItqxuWWUFZ/tW3dcDVpOJkbQUrpEQJTHGpMQyj+1eauphrOuE7heDd2vimwyGAMACeZCaqeDLxXh9j+Uz243PrlYenPpPw2r/6qjmBgZlYLO/E0NFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9RSrIY9jY8IYOjPwwNEzaCp5NRDnqzOQK5TnbsrU04=;
 b=TLzEOtPgGwnKeYG7Xg/qRyFddq96FHtmd4BQokeZtXevJhp2Tn71l3u3LqEvS86wJ7AFq1PT6HWtOeFiG4Nx8glBl9kXSmEyikrQHIguRBZjsIwjYh8wEEjEvkGipBey9wp767zEz3hJgusd1RVh0k+6hAAzMEhjjGItAAoyAYI=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Sat, 10 Sep
 2022 08:43:19 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7999:3e83:f609:7a35]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7999:3e83:f609:7a35%3]) with mapi id 15.20.5612.019; Sat, 10 Sep 2022
 08:43:19 +0000
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
        <871qsjyb41.fsf@oracle.com>
        <CADvTj4ov8wnWCGXsKRF5QJn9_+NQ8RspydrGPjE5=9KWZQuNEA@mail.gmail.com>
Date:   Sat, 10 Sep 2022 10:42:28 +0200
In-Reply-To: <CADvTj4ov8wnWCGXsKRF5QJn9_+NQ8RspydrGPjE5=9KWZQuNEA@mail.gmail.com>
        (James Hilliard's message of "Sat, 10 Sep 2022 02:31:20 -0600")
Message-ID: <87r10j7h8r.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0176.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::10) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|PH0PR10MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e901972-1ae8-4a75-7089-08da930882c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rXXFahHAf997GxnanX/sZLyXGEX6wCyGap6QmN1iO+6a6L56JLlCjwddAA0DeqkbtGnclJDOke9uIiRGBfcNyro5wkavhBEC+p9hZ3dfBqy6MgMuqFIZ5gTZubFSyDP7ezyPz/KLclmD1tvUew+L1QaoTUu8FY7LfnGMR8N9Vmpr6EhUOLzvMdIyiunVvdqbq32pBbbR+w6n0ao/G5UB7kBPB4lDwEh8hp+UbX5qWIBeZcWHg2URypMKNq5lxXDmiA3tbfbyLpDHiTXoKD8gat7s19AirU5tzxVWAsxmLnAoxls6uiJ/rZRa09fXPmX5bIhqKyb0Jz79bN4a0ZzdY/5VSxbzvxjVJ1j9uF46qr9IuKy+1HVW/KhU3AgO8YxPy1sfhkdVPS0rC9cluMtPhB3g4oP+YcE36PlQFqJF8j105sdKXwRipryV8+nmCT746k3NA8vXOo62+oJZej1vx0QYP+V/vvYp6xHPgaoxKyA1GHhEZrxWK/UvTQxa/6+89+HKGUw9pt72OX2YdKynESOplpXBrGi3+IY5JhMOX9R+KAG+dfVaVWmkeSMrwWk8OsWTEtloFQ6B23D0PYjIN19PmSW19LLEr90cfr1ms0n1qF/wIwrn2O7nNmFzYhl/PkVo14GGuFnIZcmwuvOLGIObWMcRGWladaei+8IoKz0EBHAxnGiCV1knxcJqSoE78ijmOTsV+0CahO+3yOev3Rjukd2YLOczoR7fjAJ1hT6dOefgG89nreqYY4LhbTOyAxPLyZovhR2bSNonrNLoYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(366004)(346002)(39860400002)(4326008)(86362001)(6486002)(8676002)(966005)(66476007)(66946007)(6506007)(66556008)(2906002)(83380400001)(478600001)(6512007)(107886003)(6666004)(53546011)(186003)(26005)(8936002)(7416002)(2616005)(38100700002)(36756003)(41300700001)(316002)(54906003)(5660300002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OqRgqQv6teLSTZ+Xq57kEWDf9ZI2pMR70Pfj0sGiFMsnPh0I/npt6leeq0Xe?=
 =?us-ascii?Q?ZPPoJzLNBezeMVT3CaOnwyTLxEsCfh9jmph25QL8z9dsPg75Hd5gjsQvSVSR?=
 =?us-ascii?Q?Sl/RRtvdemBKpsEfDGwxHtXIY2ocaMZvJnTn8+U1Mzq95j/7PH3sFyYzE/o3?=
 =?us-ascii?Q?u8eQVzzFIxKAYHM2iT+Qt3sJwnPBFg6lMTl1hSHS44VvowomHYlDyIWwuT7m?=
 =?us-ascii?Q?PIzNseNzlk+P+Hs/x1KIblHYVsesMioW4TfvPv3LDRKTGvDpm+QrzbgeHzcA?=
 =?us-ascii?Q?t3WzODarR2SyCw1WuH2SnjsClN8EqA0rbKbT/svLLQfq96wLiIgmr2I+Vh9I?=
 =?us-ascii?Q?nbAMAPF8iYHvdTNAsVrlDek29D6/MqPXQiEtWAODu9Kqk7TvsydLGtV9QyX4?=
 =?us-ascii?Q?pvN5dWhdI/8aOtmmmLoMrEVOkh7Z+ryVTUpezvrY5bx/HVxfgTkGviZk86vO?=
 =?us-ascii?Q?KvyJunjk2p4awOHnCOj22z443a+J8QBgNoFzTdoqiHb9wg7Src36A1iJyv0A?=
 =?us-ascii?Q?vi2VEIg4z09MsLqcZJYkxLSvEVfLrLLSiubAEMDmVGqHWF4JzGm+VQKjuYHM?=
 =?us-ascii?Q?qZvjnYmZ35Q0v9uS5TzDakJl+FN/KFMphpdlHQaBI24duEuNkSFS7PogwZUY?=
 =?us-ascii?Q?R+KzLpzPObQba4vm2jtVTJmSfdkiPd97FaypCo8GfUYT8Hr7eS+K5RTupxt4?=
 =?us-ascii?Q?y5aaK3zSbDUXpEa4iQK5zs50Zd3zEUYZVgz9hwHoR2qSmQkGxBXohqjt0c8+?=
 =?us-ascii?Q?8oleAiKKdNl6PFSLw9WsPpPRSjp6vRDdYAn3UDxsu1hng/OWt0Rc1peX4Fe3?=
 =?us-ascii?Q?FtqDBZzPFkJ512mp3L9nxmGoNhN81iaNYr13LpD1R8Ce1n0TJYmscd+1Hx3N?=
 =?us-ascii?Q?/nO3sETaQqY3k63t+DWSGvXqG6ZeLtIQKDnAPG+K0yrtPWQc/95s28a2h4hH?=
 =?us-ascii?Q?qZpz7CJp7N6BbAB5hfekqWCl2kZY5C7nKyoOoomlE/wlbsBZwruYBOtSPd80?=
 =?us-ascii?Q?x7fFF4kNqxSp+o6xHk0ZrFo9BxwFazJgjwEPt91uX0ivV8EGhr3S2RhPeR3U?=
 =?us-ascii?Q?AcPD9p8cxJrnyZpKnj2ssZwTU/J9sry1CnAosD4KHq6WMXjAwbREdmeerzgE?=
 =?us-ascii?Q?gCdcusx8tT15ovIv7bCI3z8DQPQlDW8TXe53mwStPbDBA/c2aO7ZGqYA1awB?=
 =?us-ascii?Q?Vfe30lt5rs6v0Me7HJGCwo8eW/IEcleoJgNsCA8XQtSCz13kDWbLkVXi1894?=
 =?us-ascii?Q?h6c4i01Fi8VJCDJd5axbt+pwZZAHoHNLWauWbuJ6mYlw2ZRmGoNJEhuOtuSA?=
 =?us-ascii?Q?QciVAwimD3s99BwmNbzqnSScAVcWlHeVyDbL/W24A+j0ceTQtTAPkuih7Dvn?=
 =?us-ascii?Q?QqJKz5OzPIdXvlffTo1KlL5QJdiDFmkdVlx15kQv3l78VzD0nqQKsddg4T5r?=
 =?us-ascii?Q?y1AhCNcx/e6OlmJU4tbgOrdLp2KPE9h7Z28Vu/WOr1pUxlEQW35rnlZm9+75?=
 =?us-ascii?Q?x5pYw1PPbRc+IABLQl3Ypr6QVQCndMFOfMjUUT+qKCQjsNIPMk3kqp57ap8c?=
 =?us-ascii?Q?geLshIqTCb8e5eQRfvOe2KuvbAYT2X0fcVUjxLQp32Awxt2ivs83wcBxooRm?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e901972-1ae8-4a75-7089-08da930882c3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2022 08:43:19.2494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyCaJZUvq/WMXbvxpCvAlBpg55Bconz0/iDT/ulDcvQOYcP5gIi+Gk+4Z1CAvjVkIe9l2a4LZ95Kq6TDI9jQFTbu8koT199SUI9QJZnsy80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-10_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209100033
X-Proofpoint-ORIG-GUID: h_WxLoYs6AiW5i0jwl6FHVNYtQZKeTQx
X-Proofpoint-GUID: h_WxLoYs6AiW5i0jwl6FHVNYtQZKeTQx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Sat, Sep 10, 2022 at 12:53 AM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>>
>> > On Fri, Sep 9, 2022 at 12:56 PM Andrii Nakryiko
>> > <andrii.nakryiko@gmail.com> wrote:
>> >>
>> >> On Fri, Sep 9, 2022 at 11:23 AM James Hilliard
>> >> <james.hilliard1@gmail.com> wrote:
>> >> >
>> >> > On Fri, Sep 9, 2022 at 12:05 PM Andrii Nakryiko
>> >> > <andrii.nakryiko@gmail.com> wrote:
>> >> > >
>> >> > > On Mon, Aug 29, 2022 at 2:05 PM James Hilliard
>> >> > > <james.hilliard1@gmail.com> wrote:
>> >> > > >
>> >> > > > The bpf_tail_call_static function is currently not defined unless
>> >> > > > using clang >= 8.
>> >> > > >
>> >> > > > To support bpf_tail_call_static on GCC we can check if __clang__ is
>> >> > > > not defined to enable bpf_tail_call_static.
>> >> > > >
>> >> > > > We need to use GCC assembly syntax when the compiler does not define
>> >> > > > __clang__ as LLVM inline assembly is not fully compatible with GCC.
>> >> > > >
>> >> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> >> > > > ---
>> >> > > > Changes v1 -> v2:
>> >> > > >   - drop __BPF__ check as GCC now defines __bpf__
>> >> > > > ---
>> >> > > >  tools/lib/bpf/bpf_helpers.h | 19 +++++++++++++------
>> >> > > >  1 file changed, 13 insertions(+), 6 deletions(-)
>> >> > > >
>> >> > > > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> >> > > > index 7349b16b8e2f..867b734839dd 100644
>> >> > > > --- a/tools/lib/bpf/bpf_helpers.h
>> >> > > > +++ b/tools/lib/bpf/bpf_helpers.h
>> >> > > > @@ -131,7 +131,7 @@
>> >> > > >  /*
>> >> > > >   * Helper function to perform a tail call with a constant/immediate map slot.
>> >> > > >   */
>> >> > > > -#if __clang_major__ >= 8 && defined(__bpf__)
>> >> > > > +#if (!defined(__clang__) || __clang_major__ >= 8) && defined(__bpf__)
>> >> > > >  static __always_inline void
>> >> > > >  bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>> >> > > >  {
>> >> > > > @@ -139,8 +139,8 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>> >> > > >                 __bpf_unreachable();
>> >> > > >
>> >> > > >         /*
>> >> > > > -        * Provide a hard guarantee that LLVM won't optimize setting r2 (map
>> >> > > > -        * pointer) and r3 (constant map index) from _different paths_ ending
>> >> > > > +        * Provide a hard guarantee that the compiler won't optimize setting r2
>> >> > > > +        * (map pointer) and r3 (constant map index) from _different paths_ ending
>> >> > > >          * up at the _same_ call insn as otherwise we won't be able to use the
>> >> > > >          * jmpq/nopl retpoline-free patching by the x86-64 JIT in the kernel
>> >> > > >          * given they mismatch. See also d2e4c1e6c294 ("bpf: Constant map key
>> >> > > > @@ -148,12 +148,19 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
>> >> > > >          *
>> >> > > >          * Note on clobber list: we need to stay in-line with BPF calling
>> >> > > >          * convention, so even if we don't end up using r0, r4, r5, we need
>> >> > > > -        * to mark them as clobber so that LLVM doesn't end up using them
>> >> > > > -        * before / after the call.
>> >> > > > +        * to mark them as clobber so that the compiler doesn't end up using
>> >> > > > +        * them before / after the call.
>> >> > > >          */
>> >> > > > -       asm volatile("r1 = %[ctx]\n\t"
>> >> > > > +       asm volatile(
>> >> > > > +#ifdef __clang__
>> >> > > > +                    "r1 = %[ctx]\n\t"
>> >> > > >                      "r2 = %[map]\n\t"
>> >> > > >                      "r3 = %[slot]\n\t"
>> >> > > > +#else
>> >> > > > +                    "mov %%r1,%[ctx]\n\t"
>> >> > > > +                    "mov %%r2,%[map]\n\t"
>> >> > > > +                    "mov %%r3,%[slot]\n\t"
>> >> > > > +#endif
>> >> > >
>> >> > > Hey James,
>> >> > >
>> >> > > I don't think it's a good idea to have a completely different BPF asm
>> >> > > syntax in GCC-BPF vs what Clang is supporting. Note that Clang syntax
>> >> > > is also what BPF users see in BPF verifier log and in llvm-objdump
>> >> > > output, so that's what BPF users are familiar with.
>> >> >
>> >> > Is the difference a BPF specific assembly format deviation or a generic
>> >> > deviation in assembler template syntax between GCC/llvm?
>> >> > https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#AssemblerTemplate
>> >> >
>> >>
>> >> Sorry, I don't understand the question. I'm talking about the above
>> >> snippet with "r1 = %[ctx]" vs "mov %%r1,%[ctx]". Seems like the rest
>> >> stayed the same. So this would be a "BPF specific assembly format"
>> >> case, right? I don't know what else could be different with GCC-BPF
>> >> assembly.
>> >
>> > I mean it's unclear if it's a generic assembly template format difference
>> > that applies to all targets or one that's BPF target specific.
>>
>> It is certainly BPF specific.
>>
>> I think that when I first wrote the BPF GNU toolchain port the assembly
>> format used by LLVM was different than it is now: I certainly didn't
>> invent the syntax the GNU assembler uses for BPF.
>>
>> It seems LLVM settled with that C-like syntax for assembly instead,
>> which is very unconventional.
>>
>> > Anyways for now I sent a new patch so that bpf_tail_call_static is defined
>> > on non-clang compilers so that it will work when GCC-BPF supports the
>> > existing asm format.
>> > https://lore.kernel.org/bpf/20220909224544.3702931-1-james.hilliard1@gmail.com/
>>
>> I don't think this patch makes much sense: these guards are designed to
>> avoid compilers that do not support the inline assembly (as presumably
>> happen with clang < 8) to choke on the header file.  That's also the
>> case of GCC BPF at the moment.
>>
>> With this patch, people won't be currentty able to use bpf_helpers.h
>> with GCC BPF even if they don't use bpf_tail_call_static.
>
> That doesn't seem to be an issue here, from what I can tell it's not
> a failure in the compiler but a failure in the assembler, so having
> bpf_tail_call_static unguarded in GCC doesn't break anything
> that isn't already broken.

IMO it makes it worse, because:

1) With your patch the error message will happen at assembly time
   (invalid syntax in the intermediate .s file mixed with valid syntax)
   pointing to a location in a temporary .S file.  With the guards, you
   get an error at compile time instead, pointing to the undefined
   function in the C source.  IMO it is much easier to figure out what
   is wrong in the second case than in the first.

2) If/when we support the C-like assembly syntax in GCC, you will want
   to guard the function anyway with a GCC_MAJOR > 12 (or whatever) very
   much like it is done with clang >= 8.

>> >> > >
>> >> > > This will cause constant and unavoidable maintenance burden both for
>> >> > > libraries like libbpf and end users and their BPF apps as well.
>> >> > >
>> >> > > Given you are trying to make GCC-BPF part of the BPF ecosystem, please
>> >> > > think about how to help the ecosystem, move it forward and unify it,
>> >> > > not how to branch out and have Clang vs GCC differences everywhere.
>> >> > > There is a lot of embedded BPF asm in production applications, having
>> >> > > to write something as trivial as `r1 = X` in GCC or Clang-specific
>> >> > > ways is a huge burden.
>> >> > >
>> >> > > As such, we've reverted your patch ([0]). Please add de facto BPF asm
>> >> > > syntax support to GCC-BPF and this change won't be necessary.
>> >> > >
>> >> > >   [0]
>> >> > > https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=665f5d3577ef43e929d59cf39683037887c351bf
>> >> > >
>> >> > > >                      "call 12"
>> >> > > >                      :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
>> >> > > >                      : "r0", "r1", "r2", "r3", "r4", "r5");
>> >> > > > --
>> >> > > > 2.34.1
>> >> > > >
