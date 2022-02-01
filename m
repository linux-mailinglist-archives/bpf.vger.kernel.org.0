Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A54A64E0
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 20:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiBATTY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 14:19:24 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24534 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236353AbiBATTY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 14:19:24 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211HDoAW003773;
        Tue, 1 Feb 2022 11:19:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=UIIbAKIbltI7CHqSmt/eJdK5U00HnponS6XzCE65V4g=;
 b=OdwbJ5MN0pdfX75gDHRp9exUZfM9lqgQVRiprHfUFtrABMj06x18oyEiqmGmbQFBKRj2
 e4kksK6I+7Ix4TNhJ/1Y1kN5gJzVnz5kRDeDUXkjGxjHv4a9DNc48GJFow3TaSot3TBY
 TCM1ztGq6/G10ZYwRZUYDxBvSrB1ogW8wJE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxqxb6jpj-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 11:19:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 11:19:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7euTwByo2PQ1hgZkjkJ8c1/wfhc5zPtoajg3xhI+G59I6ms1747A9mp6RiJZG1DznTinGtOKxIzNHgZfrPrEGs73ZnfohOhnyJsBNY5aR263DTlxX7ubXy2RekfNgyv3qiwWRGOAwjUjia1NW2e7H/3cUD3svnOsFcL6zBsTpIFMfoPtScyLUqY7LWKYMTv+z5BZdgj7kr3RaVpDXcnuqVA176HUAp6rAOx7AEhnwRRPnyVL/LH1wBwzuysrMRUkx7lckEFqztZ8814dC3HZw09ALFrru1+MIt5rMNL9RkjL1tEThuPmhvkXgrwfo/H0jGsQNHS46oT6U0w7hsdKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIIbAKIbltI7CHqSmt/eJdK5U00HnponS6XzCE65V4g=;
 b=C4pHsl5mCSETc0ubTjvS58PG6VMC2OQyF5wsM6IQnx9QGf6zGFA76hXNXgIDM+n1CyqOLhtn+XEdKtmmbE+fAzeQqWBDy0KRugcMNHOcLfGTav9hhzlGKfLSGqfdRhntnM9wxMrbtX8B99wR7YjqrM5VJGe9NQ9TooG5lbfaiFw2BVsBhiGS0Jae9AtlCbWEkzsW/jeRIxLJyCmRvxdjymoqKsgXWG8GyNFLV41302g4t9j3vDBWqxnNeWjeAAOl0p9B7plUie6lnqUEmdtXnxMCE/EFKP8J6FyhWui8MLIM941Tc/fzXRGerkDJQcn6ABThiM8iqjRWQPv8QnLVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB5299.namprd15.prod.outlook.com (2603:10b6:806:237::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Tue, 1 Feb
 2022 19:19:02 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 19:19:02 +0000
Date:   Tue, 1 Feb 2022 11:18:59 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 5/7] bpf: Convert bpf preload to light skeleton.
Message-ID: <20220201191859.uucrtjqr6spxhbcq@kafai-mbp.dhcp.thefacebook.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
 <20220131220528.98088-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131220528.98088-6-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: MW4PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:303:b7::16) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68729be3-f8c2-48e2-3501-08d9e5b7b4ea
X-MS-TrafficTypeDiagnostic: SA1PR15MB5299:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB5299793DEF97572C825B7796D5269@SA1PR15MB5299.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iX7dTmPiOqdzfTXpm9OzJXgb7/KsyWtU4aButm9fZU10TQ/RRL4zHDMwLzE6lZy5fcNugNdRGCRp/6W9Nev0v3aoKr1X0edxkxfmdim/3Ss7/YpUcY9AV7zumqAKLr5etf0v4232qjhniiId7WnJhD8AdkvqCtlTfsrzZjMuVfrZ35xZyihcko9v3aUwm0ZzE8ZOUYm5DeJXSzfxlsrcLpsHPI96JYzguzQU7/YEaAGOB5R1SSAqc477mWBq+/srLCkZf9Vo5NJ+1zuHO7LTIDR+dIcgF1lp/xXOsEYD8pC4PLOc6QSV8ywCu/2HJMg3Wn+Exbt0nCBqLDwznbCm3IqBhW1rxR1uc6SPQHTejhwCLKKFKy3MMkBA941nAl1tzDjrerYh8PGuhRLmbAMtHGPOrYpJ+JHfbbKITXQyTywCPlrfmOUCP7dC8ilSCdrAN7R94WpnI+Zr73FLP9/4lc5Arw4Atinm6mLMSNXChPwc4MvWSUQs4IzFDsG0Dadg18O397RzH6GsqT0fgw18a4m0DxvRHJIeIzBBOC1uhBTevVHyjqmn7MMx3VhykZxEIh4T6xKIkPUsyqkoJ2iEjYGb6BkM/hPIOT7SNaSmswpL0an0T02oj4RUDgbwYTztUdIA0jgMero5pF9cxjDraA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(316002)(186003)(6916009)(5660300002)(2906002)(66556008)(86362001)(8676002)(8936002)(6486002)(6512007)(508600001)(9686003)(66476007)(4326008)(52116002)(38100700002)(558084003)(6506007)(66946007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a4HN21uTjTRcHz0LIidTdBYrtx8wOUKGqvVvQeSrXp056P6iz4MVZF4+YenW?=
 =?us-ascii?Q?CjLbhLje4GmshyBJ/wBx5SAxwUA+qcGv2/SrasXmoYpUu51Je3imAlfrdP3F?=
 =?us-ascii?Q?qf2KBQNcRGqwM82jQY6yMDJ0j7MsHKTaSYQ6AgyGQrnkVHDykjqwpSH70yvC?=
 =?us-ascii?Q?+kIZ/8SSbpCoRLzxWNfgULDj1paPeyDJoGkEMClWwKd+dMEfOgjzkuNvVDef?=
 =?us-ascii?Q?xygh6Jn4TU+owSlhtnHFbiic25Z/BzZRAd7AeHhRmIl4SAdjEjl9cS0FF6aK?=
 =?us-ascii?Q?8IqD9+3txQiossCW7uONqvCQaS8FWi5ZNCXyzpxpk1QZuo/Y3aMPb8P2BIZZ?=
 =?us-ascii?Q?Uh/dk1sJ0x9+qHHUru3gXg38RHLZMozohaLdiM3zfo3IRNy867oKjIVDmq1V?=
 =?us-ascii?Q?4dmC14acFIwBfmQTvaE5pMqzld1TAftIJXSa68k1amgQmIHhArbwXzsEgs3D?=
 =?us-ascii?Q?sOty960kpOIvLoGw6BhMtWkChNOvxAJWFsikJ0PxdLgdrUZumsruKjRL60cX?=
 =?us-ascii?Q?+SxKLUf+iL37Xdm4b0vlZ7CehbVKJynbD8sawFFL8i/0NiTe3m1yfLa1exwB?=
 =?us-ascii?Q?CoERpi30lkbVKuRxh6G6QdKK78Hz6FeZNiTSD1reOH7Qs0xb7S6uXXQAWIjd?=
 =?us-ascii?Q?WDWmWT+H55XSyECAQXH98wYVbFVM68q5dieVPun2kar6BESoYyLx+kzTp5u8?=
 =?us-ascii?Q?Ky4h6/lfgmgV6/cDCkoCFQww9+qbua++NIO1v1LVw8fXzPO+O4cuqu99WbYK?=
 =?us-ascii?Q?vA3jj2AJIFSuDZmCw1BdyLAWfcD/dsfUds9WGdfHZpY/z+emMeOuepoqKBzB?=
 =?us-ascii?Q?jwoCrxIWI04zplEH+RJ+DLTNqqgeULaIy9CjrgY8WhDm+aoh2TEYiSq1oxWM?=
 =?us-ascii?Q?/SAMTJxWAX1ag4+JW/ObKcxSVOW9lwWsH9W7ePmRvtN83c0p2Lg6oXFWGayW?=
 =?us-ascii?Q?DXFI26FRe6UHXAds65w+6EEPdMFsF/K67janQmJ/ZZW6JICczrS0JbV+FY0d?=
 =?us-ascii?Q?xK9gtDeCigeKCmASuw0upT1JURyDh8NFXdIHyg0VGVgfZzt/JrxfR3m6xVp5?=
 =?us-ascii?Q?tCVAsHc/AHG//l9vZJ4xJaTWhZ259/4GUqkzPlHQFkbHGg/GsPQtVXhNUr9c?=
 =?us-ascii?Q?8WhhBDQBIbd0vGIlQ3jmWUklCSB88t3HZKco2FQ/1+YedqR7ryq2od196OUN?=
 =?us-ascii?Q?GYUDEMzOCJsIqSCkMxt9mPxpyc1Mdsc0R1Bt+A9Wa7eFKE5pkEK3Te/32o1y?=
 =?us-ascii?Q?LBYzE4KW49JP8ZpAxoEJ5g+ZVLScNAcp1R4wDGsalllO6zkvBxklX/yppboS?=
 =?us-ascii?Q?HhIO/FVgMqKngyj36Z0XncHsDSYyXWaAmuilrzsCDb/BRmnbINF+qxutappE?=
 =?us-ascii?Q?yHJHlkvBEq0czJ0AOA8E8uG2h79MxSt7Nn9KuhkEzP3SgEC9ZZFNtJv1vBUE?=
 =?us-ascii?Q?1tyzH/YWFBX4IALqZikQmZ8bj/PCRCpOlNaD6uDpdqb/snNzKpKmbIKZ0Gx7?=
 =?us-ascii?Q?29SMroW8ilt6IqBgFQU0Qzri5lpH7dk0sNi6MyvxPLvVlfi/sksXWj9XZwiz?=
 =?us-ascii?Q?JzHgKTsXZvdJjGgLVNA6QSVUYDyNzLJaxgCBFmNDaX0fXNEnCgv/BiOlpIGT?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68729be3-f8c2-48e2-3501-08d9e5b7b4ea
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 19:19:02.8065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rEU7gm2+FUB+DUt1CXNaubpVj6FEgvXyrmLmclAi+UrepzVfE6sZ6j+wegj3+/a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5299
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: zDNP5Kq0wmMKxMtQdmHN3v3Ttn9B30o1
X-Proofpoint-GUID: zDNP5Kq0wmMKxMtQdmHN3v3Ttn9B30o1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=747 priorityscore=1501
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202010109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 31, 2022 at 02:05:26PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Convert bpffs preload iterators to light skeleton.
Acked-by: Martin KaFai Lau <kafai@fb.com>
