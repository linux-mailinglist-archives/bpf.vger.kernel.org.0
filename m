Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D74B40B5D2
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 19:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhINRXp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 13:23:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2602 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229817AbhINRXb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 13:23:31 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18EG31qq026919;
        Tue, 14 Sep 2021 10:22:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=UH+MVKomOdF3bfb1HnMpF82f+5ayHO/qMxp18nbntQM=;
 b=LxhOLVYH/zk7V/tJutrYgw/hloqhDiXnPLcaRHymn6ssLdmInUpzsm8fBHizTabc7O4o
 RKCNoaz8u37gIRq2iRk5k0W30LeVSzBqJFIkcX+a1VcksCPX/kokWCnnE9f2ec5pP1Bt
 FRCwMCdT4U/ebcz2ojz0SAb3YLNiyPkDmMY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3b2k1rmftb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 10:22:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 10:21:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5+wK4AOPwMUOEesj44UFlOn2FtyiWrkLBB9Xb+mhSyTfD9TizHDCDIcAk6Eg88K98a55Y4wm2nqK+XPEOgfv03j9bdVFjLVySsWMI/lOLBnA/4EmHC3ztDmBqNhWSBANQCAzVHLkngTaAkzYT+DuTFs5XQzsADSP6fB+1QnIaXQ0mctBR4ua/cjEDV3+Qb59mUePveUaWwldLKNGN4iPv7PjqpUNIW6Pc1NW1+tmmCgWWbVZyr/Sf7piiJRIYctgKc2FOwRYGvmP13hX8T9t+KyayOwwejGWfu5o0Z7MOTdpLgZmTtKP3nM8Sih1h9nz35vD9qjjaaH5VnuGCuAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UH+MVKomOdF3bfb1HnMpF82f+5ayHO/qMxp18nbntQM=;
 b=R84C7DACvtJ0EhdSCypWNsA5nk9iFzW2D2tkVIn6UcmBddP01CzJbfWFOmBbC4PSqt/Ou7JS4dxqEstJY5na9+VuEHIs1QkkiH259ZzJV8E6fcJPWNfs08TUkACcKqxvVOYOr6YtaM4Xxxu/FVa2zQTi0GRwGJp0hH3FZJ+SgtQVFhm6oOmWX3jWuzJEEYP2pIRd6KJ1pY/qfWRzSxzJw4y4qfUmzxCczXD5wFbLEI/l8SLL1NNAFynyQjrcNaijmkb94gEESiMxQw9tU0np48kVmlmv3DnSHshkoQqwdOZahkqg0udBzav9AbZeCl+r1I9Qkt0o4DCD4Jh5ILasHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3791.namprd15.prod.outlook.com (2603:10b6:806:8d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 17:21:58 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 17:21:58 +0000
Date:   Tue, 14 Sep 2021 10:21:55 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: update selftests to always
 provide "struct_ops" SEC
Message-ID: <20210914172155.gntgfl74p2iljokz@kafai-mbp>
References: <20210914014733.2768-1-andrii@kernel.org>
 <20210914014733.2768-2-andrii@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210914014733.2768-2-andrii@kernel.org>
X-ClientProxiedBy: MN2PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:208:fc::31) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp (2620:10d:c091:480::1:c86c) by MN2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:208:fc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 17:21:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5262ac1e-3887-481d-cb0e-08d977a42868
X-MS-TrafficTypeDiagnostic: SA0PR15MB3791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3791EBD2528AC0CF85EDB6F0D5DA9@SA0PR15MB3791.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxkeHteBhGX3pKNIOV2KwfU3cDiOIrgK+Ewer3YBENBRp0gFYkc+MrJFseh6mRyCdwu3VqpH5uWqAB4mzOthwA492eb08nXM8XTJvuBEt+914LJi6T3s5QsmcH9mygz416P6hftugcp/jdZbKamkjCIHBhon4O//5yMnM/8aO+DgGbn+SBfnquV8iVZc2EBnQZWGh8535T0zKSXr986D3HESkO2rTZaX9wxOoeti3vq6opErH+PAQhiUnz0wAcVmwB8z/z2igrqDucOjcOAOfpNo2YUrzHNj8K/aV7oP2j5eSvtzBaQc26iFw0ZGCreK4S2N6T9k78Lv3FpfpPIrfmsdmWZPNmnapKULJJizE9ArjGRB0Q9tvNO/KnA7y3toafaecZyzHmclnPfaLyin9oP2gGpaaDE/b2d6Bs6NoWXHFUMRh2J69J7y82J748bR9/AaeQxfKjiqckI53YKU+NfenlFjeJYExrua6TICfyRYBR3/3PyWv67csNCD+dYxsvr2/nU/r47Tjryp/m7KfeZVd+c7sR4LTyYntT5Lnu9RMQRB7gRVYWIfTyACpemCEHnggFJ8ncZNGxc219ht6oy6kALScP+BvOZYlLgeO5tZcilDWS1Z/hMmWvUuvvlk8ev8EbkeeU/d7aA69wLUOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(6916009)(66556008)(66476007)(86362001)(66946007)(55016002)(8676002)(38100700002)(316002)(8936002)(4744005)(186003)(6496006)(52116002)(9686003)(5660300002)(2906002)(15650500001)(1076003)(4326008)(478600001)(33716001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OT81obne3lVL961cruDUybZTPVjCV8cWv8Qae1ilacuZiO1g3XggPJDJt0L7?=
 =?us-ascii?Q?kfkzMeXFyMv3qJV4cT5MJLvlRISir67EcV+2+fVnBnapdURNO8FOcrJwoaJu?=
 =?us-ascii?Q?4vH3fEup8L/nNz93w+R+wndaS4yOwBPjg47vOquJGL3yyuRMM7wFY1qwiMJD?=
 =?us-ascii?Q?HnDnA1ZPOiw51bmjN5fevoB98qCEF6QYoYsg04+AdK5DhaDU1wItKAA/4E26?=
 =?us-ascii?Q?K7tNiw3l4oUZP+ckV64wUny92GRx43Y1B71yNgQ3SSI0S1zaDPJgtlM69GvR?=
 =?us-ascii?Q?GAKUGGpgPKbPkmX9NuQR1+QVBfMSgIKCAarLCkxsU620HWHGhCWJ1VUAySLs?=
 =?us-ascii?Q?SJgcpytGkYeRYdO3YWUbS+VG1wpmhAQgwcmJnGhxFotq2G8t8rhckMjBs5/L?=
 =?us-ascii?Q?33x/kTaMxTaLwBI09yh8vp3UksyFu9B3CcPmDw5+7hJxPH7poaD7Hc5IdPdl?=
 =?us-ascii?Q?LDFlh5S5w1Ma1w/rH2ST5BU6RHWpu3iFtkwfsAuED4ht3oSAy7mi+OT6bpZv?=
 =?us-ascii?Q?0MFkoQtXLYlAxTEDpQK1I1QHP4YW8yXNSmmIgk6aqoEn8pZgTen/R5tMiD+4?=
 =?us-ascii?Q?rD3K7gQU40hjAsASXNs3l4EQnwf68lOsOE+0ln/sni+t4VdLdRKM39HDvOqj?=
 =?us-ascii?Q?CWc10PaSGKjD77t07ffGQP4ZGqWxB34Cj/3CNDVCUuaROi7EvUr7QHKFkK4q?=
 =?us-ascii?Q?8Jmpv8e5SeZyJKLV1mZAL02YbAWK3l1Ar+/aN2BRPOEBn1fD3Pi85QkZNbyK?=
 =?us-ascii?Q?1Isz2BQdHVau14k3msCHEJSU9Xb5LZp1lLMIxlnoCukqCPUAuJU24IkOS/tN?=
 =?us-ascii?Q?tYEv/Y0zO6ViLEIPQPqBywkvmfV0DrQB2JqloQIqHQe+eGwCHbWkWtlKOlqV?=
 =?us-ascii?Q?Eq6nfaWArvaKp4CJglJsKfhI7uiWKX2UFg4L527McSSdSkgBxdBIndJgbA5v?=
 =?us-ascii?Q?hd4ZdIbinu4j9xMMdeJ76F3xRFDXr1SUqsYGNo3qukaX4G5O75CndOpP07d2?=
 =?us-ascii?Q?FcFZFk1k88uF0+JSQ/Qz3QJ5d+VXgk/7oqrG8jZdEtjVS9vCbjHDo9r34V4k?=
 =?us-ascii?Q?pI5Jq4Z0NJiFQOPxzEEcshsLmv36Nbu3lzh273txHlMx6vVLOYYJY+fdL8MC?=
 =?us-ascii?Q?AoBdm4J6bUYlxXqUiC4zoeWU/DF/WfmxZ91YNe/wx7/g3stqWD80LXvbJbW6?=
 =?us-ascii?Q?AvSkdNnU4mu5oRLq5sTxaVNSk1gjiZpeIeWVZaOa90B24rusKehBWKVw8Von?=
 =?us-ascii?Q?rQneurA42Y1LGVQPvc9HRm6l7jhx0JZHLBbpLXTrAunxCO/APXi2a8hyFMoB?=
 =?us-ascii?Q?9BXWoEk3aQQ+KGVZ5R7opYuwkMYmDtqV5UFNF/cgPHzjjg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5262ac1e-3887-481d-cb0e-08d977a42868
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 17:21:58.7676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uAQYl4BzeAhLWYPQoJX1+44siXdfnSIwK8eVtO2idoufU4RFSDz+ZTS63Pk4AXM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3791
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ABLZSKKsmgaNbPmA9NbIVZkffYjZ16En
X-Proofpoint-ORIG-GUID: ABLZSKKsmgaNbPmA9NbIVZkffYjZ16En
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_07,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=382 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 06:47:30PM -0700, Andrii Nakryiko wrote:
> Update struct_ops selftests to always specify "struct_ops" section
> prefix. Libbpf will require a proper BPF program type set in the next
> patch, so this prevents tests breaking.
> 
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Martin KaFai Lau <kafai@fb.com>
