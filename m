Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC7A56BC6E
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 17:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiGHOwM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbiGHOwL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 10:52:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9E111C10
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 07:52:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268EUf46026579;
        Fri, 8 Jul 2022 14:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Zd33upKufOR/glGgWWUvVwRsREbnWYuBPkUWxv8kfME=;
 b=sAxjmzJ6Y7KcV0uoBrgCqX4zogqfcKF2cFtIejIWFfS62F38LDNytt1G0sdnpmEe2HDb
 L66DlUvOnh54cAIgazpu4osYGhYIOUSbsnvgfW7znv2kSUXi+uM1P7+xUqj2GVKFf+TV
 4yStLdbgS96KiJfqLsunqJTOStrVyRupiIjsPtVdZJL0et7S57L46zBKXcYnUptBlsfw
 qpAFSpPeewvia71VmNBHAQKgrGFPAAdsHZQc4y/ZhVdfBVvQHmOGFrs3lBNYi4CxEZJ3
 YVLqgjlLGLZRPfAjmhwpO7EOnOJKkFkfvmJOhbadP8tssjsZC/u+y9b9zrG8w+fGYtfU +A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubygcet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 14:52:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 268EjMps038676;
        Fri, 8 Jul 2022 14:52:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h4ud6xek1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jul 2022 14:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qg9URgfASrj5psZsUcEBSkQvHJ8CM0DhFVG5jGzF1iCz0QbZP4CdcJOgGV7PB3JKhYxm1IrY2e2W0wH+8A0Zvdsna3YFjUzeL1/W7nrYMRRLlru+HUByJijvtGQzY0xPuauvIhhdVuNeJu8z35lmTGy+MQHN3MUTFQjIC9so8EQZFu8aX2bs1YxuJ+somGNBrEE/zFd08+yAVP/74gZ7jqWMGK1OfzWq/BbE+ijn963PJm91buBcL73C/B6gULYbdCAy2Op/zEKWFJgYt5SpL4Imgbh6NBJq47taNdk+0k03G1t5XNIe2qqZIV8fyBILmEpCHJl3FeqUsYqvgzRGDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd33upKufOR/glGgWWUvVwRsREbnWYuBPkUWxv8kfME=;
 b=QtkBKFadhq8BT0N4sf66wpDVhVW+PspTYQxiWPaSZadJPIlcZNCkIl6Y46PfIUNHq9RWfKKqF83tCGhumnI2MEcMzrDb+3r6unlIPSghNP/ACBOwJoo9N05HKJxixkyuCFrgZ58hDkGM0WdtXnqnbmYR3rQpLymAN9U661Fo7eO0kNME2WoJm2EMMmACDL0sXUqzhQTDu6okdQmOXDZjFBLvcnk4fZNGXoq4L2h0pTsBwiLh/9JHDrPNOupFWJExcFHurYN4wagUAPi74ZDQWoa+td6sD6jTqkvtz8afGecgTb3RPt56dWjOpTKS8A5kSTU7cMedPLXUFXsmhLFLZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd33upKufOR/glGgWWUvVwRsREbnWYuBPkUWxv8kfME=;
 b=sjXmMKxARhT4gW75ZZe70qyt0FJSmC33ms3rDg21n10f7SoDt7wPM0QVRwUxLlGICqDHPKCepV/qB5iIi3iT97IZ7Bc5PK9RXF1KpxjNbfdgM9jMw8MmJGDwQKZX1Sij5rN6rROq8xF2IywdPhgxizyH8OkezYnTVXxzXyR5e10=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BYAPR10MB3592.namprd10.prod.outlook.com (2603:10b6:a03:11f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Fri, 8 Jul
 2022 14:52:06 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::287e:5ffc:d595:8316]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::287e:5ffc:d595:8316%6]) with mapi id 15.20.5395.020; Fri, 8 Jul 2022
 14:52:06 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
        <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
Date:   Fri, 08 Jul 2022 16:51:58 +0200
In-Reply-To: <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
        (Andrii Nakryiko's message of "Wed, 6 Jul 2022 10:20:47 -0700")
Message-ID: <87wncnd5dd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0237.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::8) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7baea5ae-5c39-4a11-aa0e-08da60f16d20
X-MS-TrafficTypeDiagnostic: BYAPR10MB3592:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9feFV0VkOJaTuLFMshx3JisYeVT8xbTsMOHM/IEyv0KDUnn+G+id07KB9dIaViVlIY5i+CILjNrGYR+vqbcJT6jt1k/AdD8rujIrstfo5L2mQy12ygq3IprcQgZdVdQY8IQJ1ekr5oMC6JCxgHqPKeTA38RA/gtDNrh3qyn3Gv4Pc36Y1tImwve/iwl9Gm4JFb3DTEk7EXtw09KnNn6p81kRTqoXOrRQ7Dz0KjHbneypP+M3qpOHAmRgBOnOWgUOZuz9MW9Rq9VRGJwqXsOxe8wIUIORiO5rWYM++w+pOE+gbhgwPKlxIoa9cW+ZVz+kauaMSihKqM5BlQAMsdqCjvzTY0MTnWfrZDshfDm7X3BbGFmLzzh8TwLa40qox4J9jRA+lC4bPd51mtjOXQXJ49yFI6YfZ+p4cHd+7dnkVdAV6OfZI+YPsaLf+TpiiJjmA6W9X49JLX/hOJIuIugEvuw0o1uFkRyB6hWZ1piiqWdI8gFWMB8+UuXWKNrfCI31GKqTFeu6oNnRpN+N40jBHsbwcl87f/g77f0ofa5bnVWyzsRJjQ+oCqN6p7MlQBZHw32QpZmHKmCTC+bewip9iyahRYzhb4Hlh7TYiMk3PCLlbZCLjwGJivHJ9dUBBoZUPjrBVYqSqRxlsaHuQ1RNwdXCfWYKlsU0PlKAYYbd1LWE51AhZNJi/3t83TqrhA3CIPm1YFVFUqwySJfasKYMzvpw37Iec+zc1nqKpqYAYEhIGsxQpvvFIb1Lph/zin9Q/nEfwYE3aBdb1mjA9iIC4yq1ite9yEHnnk40wj1w60md9ACx5BuAAny4RE0sdE/criAUAv3KutjvsQ8AXYn/0F0LYASXvlxT50wHzQJYv9+R/ux9Ym/cjyspPHsaG+xm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(366004)(396003)(39860400002)(8676002)(86362001)(54906003)(26005)(6916009)(66556008)(66476007)(4326008)(66946007)(52116002)(6506007)(8936002)(6512007)(2906002)(186003)(53546011)(6486002)(38100700002)(5660300002)(107886003)(2616005)(41300700001)(966005)(316002)(478600001)(36756003)(38350700002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ApbBrf/8VzmenXt6hCJ1uCPqSaX/P1uySMZP5zhj7Jpeel5ntWEpfMxTegNz?=
 =?us-ascii?Q?c/lU94yoovkfZGLBIakkzPKgxYoRm1wa+0GTRPZgHQtq3OkEOkMt8SPbJmAF?=
 =?us-ascii?Q?6OdvRsVDsy0A2iQ1yMb2QkpMy32Q2nNEWqnjMT3ythfgM3huETthuwOsH+m2?=
 =?us-ascii?Q?15I/GryiZqC3CmpVgdYrtT/46/hO6g2JvC7LL7ExW1qGtbY7xElUqQvkTPaV?=
 =?us-ascii?Q?Ath5FvpZ0j83+7bHociw1WT+TOctfZv9zpDUERmUjODzrq+VnTWOXNyhd8Dj?=
 =?us-ascii?Q?YU3MgHb6LhF4KdnyYZqlquFLC6Q927ikU01XYz6mkruJegpksQgkW+Fa/hnM?=
 =?us-ascii?Q?3RBHsBs/5vypbM1IR/nrVbpDZ3awaTYHPSwfxHIm6uD3oxM5ecTaC0XDw1AP?=
 =?us-ascii?Q?lLBaH9ijyeKzBIhdBX3kYNwETF1h16MJQmPDfIa30bGdfMN3vg0e9Knspxcy?=
 =?us-ascii?Q?FPE6ufgO+eLHIvcEpyz6rjIdiUA7EKWig2BaQ0/0CcCNBsuDlBRKJBSblzwg?=
 =?us-ascii?Q?pTgAglUYDTxBYYj2JwseE7DZriH8/NXYQZ63VkSNEzcoAt3Dgi+EzWoM5lNx?=
 =?us-ascii?Q?o1m1F52WsOFpc/wWs0wAszHcL0DoE42Z0MUR7y9ptv3vss/mGqbmgH5SNMR7?=
 =?us-ascii?Q?ZIyjM/IrtxJ1NU7ZCRNv1UK/+SNYTC5/EKwROUixvyaFNGWQs3EPzqqj3d82?=
 =?us-ascii?Q?7RRYgmc15n/HIOT867PjSq7yHcL8Bh5j2eCixyhZhBTDxiY5ypwwYJru0Bbn?=
 =?us-ascii?Q?irTE4oxVBJGQ1HQiYueuuEvjbjjnQkvduuwNXEm15YnCMidrRLy16dbDURhN?=
 =?us-ascii?Q?ihe9flqK6nKHsKIb2oQC+t3Fi8NqSf0Yr9tVMesXWC1h/5bk7iH5ePdiOx//?=
 =?us-ascii?Q?6CH54QydYBrPTj81ibXvSgebH11gicF9v0PKuAmwuq6eIfmF7/xya40XyugF?=
 =?us-ascii?Q?Nuze2xyIHY6MlqyUqYQTUu15Hb1X2d1KldoR/BzfsdppnbsswAa7HV+5WOm4?=
 =?us-ascii?Q?5aw0Bv1zg8tdEhjAZCgonumQu9eRAl0/Ckma2GsvIlBHiXmwNBfUAIXLkFg0?=
 =?us-ascii?Q?wxrnXCgYKD1Ut4u/0sn9orSo19TYbJJ2KpcYtEgTXnJfdVgVaU24xGdXJOl6?=
 =?us-ascii?Q?E0V9S0uIeK4uQCt9+tJhbt3VpVnsLsQsKaglTRrs/L4oh3sUv+DQ2LGKs8ah?=
 =?us-ascii?Q?QDk3ZPD7z/55XaB8taX4/8+6Iz3DkFLhCQgRSvphWu2GltPaw+wNR5WC7Z4n?=
 =?us-ascii?Q?8XtBsKeU9KEeviiOabu33p/6sBnxykWBXu4u6q6nl2dN2wWmesDs2PT87+RU?=
 =?us-ascii?Q?0KfeFcxvuP6N3NzuDDsMWz9ZSPxusPteKKOwGHP4866Klc9NT5hLzDSFZ9sZ?=
 =?us-ascii?Q?n1gxg0gfm9+T0kjTFTxkCfMDkWOJuEqIJcaRdmA6VMaQSRntMNQOUeBARiKy?=
 =?us-ascii?Q?LBDLlyIr1OOejSczTCBaS/q89zE9W/kfnRbChjNp7j58MuXOILZyiuPkZIXR?=
 =?us-ascii?Q?EVxyFKF0PVbGYGSYLSb0uCFO+YvyxAmMw33/f3bxOL8AVlGSZyjaQ0EzKQGF?=
 =?us-ascii?Q?YsCljR+sFLZEPfW9W//rhmwCUNJHaSiyb0pW78om6gtrxbhrC6aAPzplpj5m?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7baea5ae-5c39-4a11-aa0e-08da60f16d20
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 14:52:06.2307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2smvMSE9GFZcVvyA7L+ghywikZdbhoThrOOer9qr/zvPL8+dnqFmldqzJV5yL6JBk0qwIYS99A9m12rfqp+BX8KmlLomqoVF19C8XXW9dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3592
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-08_12:2022-07-08,2022-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207080057
X-Proofpoint-ORIG-GUID: HHrH5bu48gig-z4ygI0Q7Rspr94Pw1pP
X-Proofpoint-GUID: HHrH5bu48gig-z4ygI0Q7Rspr94Pw1pP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
> <james.hilliard1@gmail.com> wrote:
>>
>> Note I'm testing with the following patches:
>> https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
>> https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
>>
>> It would appear there's some compatibility issues with bpftool gen and
>> GCC, not sure what side though is wrong here:
>> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
>> Error: failed to link
>> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>> Unknown error -2 (-2)
>>
>> Relevant difference seems to be this:
>> GCC:
>> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>> Clang:
>> [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global

For functions GCC generates a BTF_KIND_FUNC entry, which has no linkage
information, or so we thought: I just looked at bpftool/btf.c and I
found the linkage info for function types is expected to be encoded in
the vlen field of BTF_KIND_FUNC entries (why not adding a btf_func
instead???) which is surprising to say the least.

We are changing GCC to encode the linkage info in vlen for these types.
Thanks for reporting this.

> GCC is wrong, clearly. This function is global ([0]) and libbpf
> expects it to be marked as such in BTF.
>
> https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50
>
>
>> GCC:
>>
>> [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> [3] TYPEDEF '__u8' type_id=2
>> [4] CONST '(anon)' type_id=3
>
> [...]
