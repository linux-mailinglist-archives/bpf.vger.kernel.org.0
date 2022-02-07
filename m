Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665FA4AC131
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 15:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356440AbiBGOX5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 09:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357291AbiBGOVL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 09:21:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1C1C0401C0
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 06:21:10 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217DdoHn004446;
        Mon, 7 Feb 2022 14:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lB0LQyqZ7Kew2BTTUjp0c898rnubzycipfVwaoMwWRo=;
 b=AdgrwEOH2rOmLghCWIDK7XFhCEnTbfPs9u4H1tgMJBIek8uHAmfkjOaifUxL/Ii3nYJV
 QFBDQBCJ73cgqg/JM8WlNiiUF6t+mvg/OUWE2F+gF5bByvv3cokgixRaLwrXKmGhE/Ow
 lVXOCCCQ9d7hTkGKLqCDmldEFVo56jd8XGz5OUlbvFdfP1hVKaIkaBWfzqtnYynCPBGG
 J5B60XTS4UnSB/L1gl6BZqLa6TiClGq5GJ6x6WBYMPz/jxEXWz80LnBddHBjwlgVAieF
 bp44DRvlchB0X4MecWGFh2D8Zgq+AmHCRGu97HWQlacrmZY3EFIuXGMihAP5++GpZ/eg +A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13pdrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 14:20:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217EC2j3008516;
        Mon, 7 Feb 2022 14:20:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by aserp3030.oracle.com with ESMTP id 3e1f9debdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 14:20:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6/0LdJd04dH9SSRrIg0Jt9bprQupUaDM4EdjEyacts8jLq1wq0UcqpVNvf7v6ycBtTyVmzr/iKW7uwsPTTU65jgxIlmSlFUaJSc2ZS+vELDutxJs4kBPqiuEBuPcS/mfCapRVbNbT5ni8hkoWQmKXWU6Rrj4DPjOOZOoYGMnesD0dOywvna3lFkQrwt8muRYWAifmngL8uvroANtKhLGPZwMCl8yLH9XsGzgwK6MC0fgezMsRJmH0gz3wGX+SC+BdYocWfC8+3yj5mNSeSyzhXIwX537SynI6SvwjeLlfxgez3ZLghSUiOYvgjxz3FZcPwgERbAfY2ZlX8C6d/UzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB0LQyqZ7Kew2BTTUjp0c898rnubzycipfVwaoMwWRo=;
 b=Kj9M3lwFH0mzESFsNNcjrvGuFuqmRBqy36p+HJd/aRUSdtaxtkDQFGGjvpq5kt0QMncmBdE3H+hQfNyCHbz3CFu+AhLwfg9mgVrZ0xYjT+oVrrYI113tfdF1h+gqfN+x/YNMPibdXecbGVKzgDHHxD/Y/FsvLGBFE98LXIYmibenQoVkPmD6+oPf6/F58PoYDfbjKn4EP7aII25FfQ0/syQBCqfUjYAao/HNaBreEcGC5KD0DlzGxtTvn3S4DUEaq6WjTmJIXnq0tOMpHb55sK4+fHOyDCMPXK5M/yG8GkMyk4ccGHastkggPVY6k/fifeTMOICW5vRHjTB2CCxTuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB0LQyqZ7Kew2BTTUjp0c898rnubzycipfVwaoMwWRo=;
 b=Pqepsu3vwtBvqjyG6A1I4NroDVklx8NJSJ/JNA7eHBNE6UZwaZcoPkO0+KKpZEkC2S4nj6lvL2FLnE0TIvLBI+JVdAIQxxUSvswJMbETww18ZmqNSYQcqp6TMSfKYMr0Ld1y7E0rBsC8O2dg6kmYn76Efq2KUwRBdlhkckNsMF8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB5320.namprd10.prod.outlook.com (2603:10b6:408:12a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 14:20:49 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9484:fe8e:904f:1835]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9484:fe8e:904f:1835%4]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 14:20:49 +0000
Date:   Mon, 7 Feb 2022 14:20:45 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add custom SEC() handling
 selftest
In-Reply-To: <20220205012705.1077708-5-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2202071400210.9037@MyRouter>
References: <20220205012705.1077708-1-andrii@kernel.org> <20220205012705.1077708-5-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P123CA0076.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abdcf57f-4517-459d-22f3-08d9ea450a19
X-MS-TrafficTypeDiagnostic: BN0PR10MB5320:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB53201DCBD20567860B25B559EF2C9@BN0PR10MB5320.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSHpgQ9NMXIXNngzvpL1zZqU1JJ7DByGdHPdlCW7ggjlHSqR2mmZkCYciTYM4NbumljertwU/N6KYsW7XQXklTWglGLQ6tIHAZMzRHW8LjpTYHX3QoAq82yKbfPteq/aUYTDUxOiqIXoIZ52tnlE6hsAeTwAdRn2n6AUHmaAtb3tinqmoNGVX9MSdiwXAhhq/WGgHDcqD1/Llf85xkCAbLIsczcwW13dXO6EZqFzJEI4iCv54EBoNFUhnBfqTnxGKv95SVjsVsn82v3Z1vW+9nZPiYwv53KAdQCEhm4lAm8Qs5JaPdrIb3VcwjoxtNqWkwkSYHN+Jyn1HkccGOc04FsIdAysdvs2OTxLTqKxOMgFRAM8IyMq/suhJ+TWi8BwPrApPpSqyN1nDXKgflEvYtEI/669V+yU94eRUidx0ugc0gcaYF/oQoBvunjlNFGecHUuB2JbUYOQDCDXVThknSxnMVx9Uw8NAZ2lRuDVRJ+t7USB0RQZi9FhJpDS34e8yjhMPELJIfuvkIwquYzk0sQxC2x4izW5UbbRv5cRCCKZHTWFChi8I1vlOQ2RX21vpY3FoCUFev0fLVzK1HVXyYHqpPCZewNHpt83jK+4y5pa5jTLT4qSicGb3V6LvFDqw7qHDcw0SK/UXk3AAqSwuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(107886003)(8936002)(38100700002)(4326008)(8676002)(66476007)(66556008)(66946007)(5660300002)(83380400001)(52116002)(44832011)(6486002)(508600001)(6666004)(6512007)(6506007)(9686003)(6916009)(2906002)(316002)(33716001)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nozImkEkEWXUnRMIl/CkUt5wdmuvcVsx/6PA+PDdBUsKP0iBKWeU8bbx+EYC?=
 =?us-ascii?Q?Qqt9juVCwx7klO1KsPXj8fprp65T3AgWjVtODaaIaVYBy3NiuDKxc8fFkM+0?=
 =?us-ascii?Q?7fBY5tqLtD2GOh2wpCgbwVNRXaKM9ZD8dNFoARxZYuqcwMeBj9P/n0Q+h5eX?=
 =?us-ascii?Q?llYjmAx+/xgKG5/VatC1jPDobnSlear5Yx2o1qCsSQOaDHPfQ0ErBedhe8Kc?=
 =?us-ascii?Q?yI+Gf9KZXjeS9gV9ZBrpEuOvskf6r8pV8j/ge2ftINy4X6JKbETunJ4fi+pW?=
 =?us-ascii?Q?kzOtrCvZcBBu9kqE/CJO8C/Mou0C0Qpz+bK9Fb+8KCoDJ2MV1AWgIbDHFpMh?=
 =?us-ascii?Q?HiJI1gd2+lG+9wc1JO/rzZzQSr6gjDfSloTbawZW6HPdgWMONiv90veYRGIV?=
 =?us-ascii?Q?wTrh29VsDYNZwNNfFfoaFojQhhOfsC5byTq9WepJX9lZe5Lh0s3IGSqtvfgC?=
 =?us-ascii?Q?fte8wFs4u0vJyVm/khvxtL+99pFhdb0LyAN45N9HH8KgoFW7JBalFMvMWRMW?=
 =?us-ascii?Q?U+R6vMsPgcbJcy50p8aMndRqUJG60GyuS1HICyn1eFiByNQJQ4/EEE73JK2C?=
 =?us-ascii?Q?s2uHZA2uaxX8ECAQyBRoxrxsFc4TwKB8+5hVT+F4SM2N0G0VgoPas08KHHia?=
 =?us-ascii?Q?RCrhosYThnnJsFX8DH4zYZTbA/RiUysZF84zFeCA/R8Qc79SoTB4XeiG2lMq?=
 =?us-ascii?Q?01x1A0h624D0HCE+sJotIdyfRfgPJ7RG2OwZg4VL7Sn2YY8W1src3SnWeRA9?=
 =?us-ascii?Q?JLbI2tHXnYMUytH0/jkp8SswBurDR2fRUD3X7coCTNdUsvJEvccYoN+/cTqO?=
 =?us-ascii?Q?pQoY162Bnd4AQChOBGcIPzut1ylclk3r5T6FmlxfHDeRk+Ou9Ny0xm+fXHo+?=
 =?us-ascii?Q?/2yDTwaI0uSksDHazVjaYNzRjIt9R+2R0ojiY0RVGgBjKrYVYnFq0xTM9/E1?=
 =?us-ascii?Q?eDReF7Mb7gJ0sElPPqmJYy8RgLubGO1ICSh7LrsgOEhY4ueahNs9lbu+DgiP?=
 =?us-ascii?Q?OfVffSQBj6OsdXbKGDT1w+WlGsEm22XI691mcLrCBUzVjBgi+FrNrCTxAZ55?=
 =?us-ascii?Q?3Woe+EDpAXxtfESt4pxVlrxn3TTWP+pPCMA3NmMalR8z03mrE9gYByVuotUk?=
 =?us-ascii?Q?pW1mEZNVfAAxU+9rAXGKZXTaSNmPQFtKS3b4lJDzyCT+Z5pxF/+XoUQZ8nEo?=
 =?us-ascii?Q?SfoyHn6lWHhXC4D97x4NGRMG5UK4Kx7WL9pJ8TTfTGo57P+TrOo6zo7no5Ob?=
 =?us-ascii?Q?CCr0wkJMfuRBZIC3ue9O1SZqMI5WYI3OMKaWPiE0FOGZytYRVWE9omzaW2lj?=
 =?us-ascii?Q?IYjDM4oa2Wy00CU0RwAu3hzCgfWXichNJW8oHOvrztqKoQ3jPTR8TGJEJ4Ii?=
 =?us-ascii?Q?N6UQubDmCuxQ8IFPSzuLSFxjOTWlcsyUEJpdFQb0pcsZ1Pgo/yCdhG21oLLk?=
 =?us-ascii?Q?tAvkL2Z2kFDSOepsgp9wxInGQRruDVO9UQsc4tZ/fOFWD+vHVEw7s2bJ0P/V?=
 =?us-ascii?Q?xhWfxH+MkfdMHXvQctfPKu/z4xy+5vJ1hZnCeUDeK3GCy9ihsCqvoc9Fv7NC?=
 =?us-ascii?Q?nk5Rg7kS0R1OVHtoQPb0H95nfv6M3nFNqCywOWkwnO8WY00lyeE2NNb7XUYm?=
 =?us-ascii?Q?9hUHJSJ6zQ8pMeDYu62oVwXnGfFMS04aOUBL2IdnnJjwnQuAhlbQLC4UGhHO?=
 =?us-ascii?Q?082qgg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abdcf57f-4517-459d-22f3-08d9ea450a19
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 14:20:49.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yky8zeXP5Y5LH5VK991cVAF99wLSdPztKywX7XaqIf6veqeq08AteiudhCY7e5fppO4Y/G5thW6LyG0HHybWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5320
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070092
X-Proofpoint-GUID: vPzchY--i9d_E6PN4sIgpSInrMmUH124
X-Proofpoint-ORIG-GUID: vPzchY--i9d_E6PN4sIgpSInrMmUH124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 5 Feb 2022, Andrii Nakryiko wrote:

> Add a selftest validating various aspects of libbpf's handling of custom
> SEC() handlers. It also demonstrates how libraries can ensure very early
> callbacks registration and unregistration using
> __attribute__((constructor))/__attribute__((destructor)) functions.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

A few suggestions here for additional tests, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com> 

Should we override a default attach method to demonstrate that
custom handlers can do that? Or would that break parallel
testing mode?

Also might be good to have a test that captured the difference
in auto-attach behaviour between a skeleton attach and an
explicit bpf_prog__attach(); running the bpf_prog__attach on the 
SEC("xyz") should result in -EOPNOTSUPP.


> ---
>  .../bpf/prog_tests/custom_sec_handlers.c      | 136 ++++++++++++++++++
>  .../bpf/progs/test_custom_sec_handlers.c      |  51 +++++++
>  2 files changed, 187 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> new file mode 100644
> index 000000000000..8e43c5f21878
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Facebook */
> +
> +#include <test_progs.h>
> +#include "test_custom_sec_handlers.skel.h"
> +
> +#define COOKIE_ABC1 1
> +#define COOKIE_ABC2 2
> +#define COOKIE_CUSTOM 3
> +#define COOKIE_FALLBACK 4
> +
> +static int custom_init_prog(struct bpf_program *prog, long cookie)
> +{
> +	if (cookie == COOKIE_ABC1)
> +		bpf_program__set_autoload(prog, false);
> +
> +	return 0;
> +}
> +
> +static int custom_preload_prog(struct bpf_program *prog,
> +			       struct bpf_prog_load_opts *opts, long cookie)
> +{
> +	return 0;
> +}
> +
> +static int custom_attach_prog(const struct bpf_program *prog, long cookie,
> +			      struct bpf_link **link)
> +{
> +	switch (cookie) {
> +	case COOKIE_ABC2:
> +		*link = bpf_program__attach_raw_tracepoint(prog, "sys_enter");
> +		return libbpf_get_error(*link);
> +	case COOKIE_CUSTOM:
> +		*link = bpf_program__attach_tracepoint(prog, "syscalls", "sys_enter_nanosleep");
> +		return libbpf_get_error(*link);
> +	case COOKIE_FALLBACK:
> +		/* no auto-attach for SEC("xyz") */
> +		*link = NULL;
> +		return 0;
> +	default:
> +		ASSERT_FALSE(true, "unexpected cookie");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int abc1_id;
> +static int abc2_id;
> +static int custom_id;
> +static int fallback_id;
> +
> +__attribute__((constructor))
> +static void register_sec_handlers(void)
> +{
> +	abc1_id = libbpf_register_prog_handler("abc",
> +					       BPF_PROG_TYPE_RAW_TRACEPOINT, 0,
> +					       custom_init_prog, custom_preload_prog,
> +					       custom_attach_prog,
> +					       COOKIE_ABC1, NULL);
> +	abc2_id = libbpf_register_prog_handler("abc/",
> +					       BPF_PROG_TYPE_RAW_TRACEPOINT, 0,
> +					       custom_init_prog, custom_preload_prog,
> +					       custom_attach_prog,
> +					       COOKIE_ABC2, NULL);
> +	custom_id = libbpf_register_prog_handler("custom+",
> +						 BPF_PROG_TYPE_TRACEPOINT, 0,
> +						 custom_init_prog, custom_preload_prog,
> +						 custom_attach_prog,
> +						 COOKIE_CUSTOM, NULL);
> +}
> +
> +__attribute__((destructor))
> +static void unregister_sec_handlers(void)
> +{
> +	libbpf_unregister_prog_handler(abc1_id);
> +	libbpf_unregister_prog_handler(abc2_id);
> +	libbpf_unregister_prog_handler(custom_id);
> +}
> +
> +void test_custom_sec_handlers(void)
> +{
> +	struct test_custom_sec_handlers* skel;
> +	int err;
> +
> +	ASSERT_GT(abc1_id, 0, "abc1_id");
> +	ASSERT_GT(abc2_id, 0, "abc2_id");
> +	ASSERT_GT(custom_id, 0, "custom_id");
> +
> +	fallback_id = libbpf_register_prog_handler(NULL, /* fallback handler */
> +						   BPF_PROG_TYPE_KPROBE, 0,
> +						   custom_init_prog, custom_preload_prog,
> +						   custom_attach_prog,
> +						   COOKIE_FALLBACK, NULL);
> +	if (!ASSERT_GT(fallback_id, 0, "fallback_id"))
> +		return;
> +
> +	/* open skeleton and validate assumptions */
> +	skel = test_custom_sec_handlers__open();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	ASSERT_EQ(bpf_program__type(skel->progs.abc1), BPF_PROG_TYPE_RAW_TRACEPOINT, "abc1_type");
> +	ASSERT_FALSE(bpf_program__autoload(skel->progs.abc1), "abc1_autoload");
> +
> +	ASSERT_EQ(bpf_program__type(skel->progs.abc2), BPF_PROG_TYPE_RAW_TRACEPOINT, "abc2_type");
> +	ASSERT_EQ(bpf_program__type(skel->progs.custom1), BPF_PROG_TYPE_TRACEPOINT, "custom1_type");
> +	ASSERT_EQ(bpf_program__type(skel->progs.custom2), BPF_PROG_TYPE_TRACEPOINT, "custom2_type");
> +	ASSERT_EQ(bpf_program__type(skel->progs.xyz), BPF_PROG_TYPE_KPROBE, "xyz_type");
> +
> +	skel->rodata->my_pid = getpid();
> +
> +	/* now attempt to load everything */
> +	err = test_custom_sec_handlers__load(skel);
> +	if (!ASSERT_OK(err, "skel_load"))
> +		goto cleanup;
> +
> +	/* now try to auto-attach everything */
> +	err = test_custom_sec_handlers__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	/* trigger programs */
> +	usleep(1);
> +
> +	/* SEC("abc") is set to not auto-loaded */
> +	ASSERT_FALSE(skel->bss->abc1_called, "abc1_called");
> +	ASSERT_TRUE(skel->bss->abc2_called, "abc2_called");
> +	ASSERT_TRUE(skel->bss->custom1_called, "custom1_called");
> +	ASSERT_TRUE(skel->bss->custom2_called, "custom2_called");
> +	/* SEC("xyz") shouldn't be auto-attached */
> +	ASSERT_FALSE(skel->bss->xyz_called, "xyz_called");
> +
> +cleanup:
> +	test_custom_sec_handlers__destroy(skel);
> +
> +	ASSERT_OK(libbpf_unregister_prog_handler(fallback_id), "unregister_fallback");
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c b/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> new file mode 100644
> index 000000000000..2df368783678
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Facebook */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +const volatile int my_pid;
> +
> +bool abc1_called;
> +bool abc2_called;
> +bool custom1_called;
> +bool custom2_called;
> +bool xyz_called;
> +
> +SEC("abc")
> +int abc1(void *ctx)
> +{
> +	abc1_called = true;
> +	return 0;
> +}
> +
> +SEC("abc/whatever")
> +int abc2(void *ctx)
> +{
> +	abc2_called = true;
> +	return 0;
> +}
> +
> +SEC("custom")
> +int custom1(void *ctx)
> +{
> +	custom1_called = true;
> +	return 0;
> +}
> +
> +SEC("custom/something")
> +int custom2(void *ctx)
> +{
> +	custom2_called = true;
> +	return 0;
> +}
> +
> +SEC("xyz/blah")
> +int xyz(void *ctx)
> +{
> +	xyz_called = true;
> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.30.2
> 
> 
