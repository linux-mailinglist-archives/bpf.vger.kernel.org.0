Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E31203E33
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 19:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729857AbgFVRm7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 13:42:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5890 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730005AbgFVRm6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 13:42:58 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05MHTW5T030646;
        Mon, 22 Jun 2020 10:42:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=+EOSvCSOGvYNJNH8p8Gc+7IJ851t8Pr7ZROoR9o3aFo=;
 b=grq5+UlaO3v/ag8t6rVX+gQW+IAmRsdaSowXJZqydBrIOaZFUHnTw+Jve/htuyTlzxWj
 j54okPuW4/fEvSCDl+wnu+yvtB6kipfD2UwHsTZqnyHfFa/Yd7t/hBFMvVVJZNjdNwWo
 YN660xiMFsBw3dPEXPwDaDJVV1NvE0r0ILA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31sdxysp6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 10:42:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 10:42:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0ie6nv5OyNhOFo6rPZ+aQiV3ePDC2bERWpw3E4v9l5P5f+L2rhgSK2cXidhs3dAAxpVnKDJKS9cdapZLnw89B5pnvdhoqOQj6roFnLaGFAnX17VQSSyZQfJ6RTSO1mT88CM8tCz6D8Fk44ph9ZFEkYnjptZ2SX/Z8/H+8wt1nA37xbnsT1CAqNXaK7Ex24agDWH2SvRaC/N2m1m8PN+hjQC8j3dkyVNlHKwTp9wfxFpurxV4xrXwMdMfjN0dH7pzo7pnodVguMAbJFMhygD8nn4uu6n58Ln0Yb8InZFYG5/y96jZ7KCr714QeEhwywlt6cyYidZA4zfn0liHr78Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EOSvCSOGvYNJNH8p8Gc+7IJ851t8Pr7ZROoR9o3aFo=;
 b=nGc7TN6oyTmZcAtkqb7uT6jrv5DOXi3ChI2p70bCf292u0Du+5AO+q90ClTKq1Op9HrXBLxDh6eWcrTuqOXtFzby75KZm79or6Gi6fWwQVSW0rEX/zjkc1Z24yaseI4GjD2UpfrVcvWHPi3X7JWDNHXLNTg9EY85kOLqLArBd4fBri1vUpPf9tZ6+dMWobq5v3uyp6d103x47ILLEr3XY5ZSt+GLCenms6tdvtoWn6qOr5KQo7NHDuu7okeSstw6bIhR1Yr2TryEkamJGbf7e5Tra3GAN0k11YVjAzcoNDkw7Iou2tufhCSP8Fr9vX9WIncQBB7GkU/G+PFIao7+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EOSvCSOGvYNJNH8p8Gc+7IJ851t8Pr7ZROoR9o3aFo=;
 b=k/hk2KmR3nG4GWTTdy6MSr/cZ13nHZD1MY1r1kv3lBDAqKlwSZfj+tiA0wA9NfLsSH/pynyXr6PJnL8oBtiEJzHcyzDEJyzC6E6v42/Bj0Nsl0r9sfBJH4BHh3mC5MKhocMdBNw4S0vua91PqQxeL7klPWExloHepPEGa5as1N8=
Received: from DM6PR15MB3580.namprd15.prod.outlook.com (2603:10b6:5:1f9::10)
 by DM6PR15MB3957.namprd15.prod.outlook.com (2603:10b6:5:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 17:42:43 +0000
Received: from DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4]) by DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4%6]) with mapi id 15.20.3109.025; Mon, 22 Jun 2020
 17:42:43 +0000
Date:   Mon, 22 Jun 2020 10:42:37 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrey Ignatov <rdna@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 0/5] bpf: Support access to bpf map fields
Message-ID: <20200622174237.d4su5e333cnrwhrb@kafai-mbp.dhcp.thefacebook.com>
References: <cover.1592600985.git.rdna@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1592600985.git.rdna@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR07CA0053.namprd07.prod.outlook.com
 (2603:10b6:a03:60::30) To DM6PR15MB3580.namprd15.prod.outlook.com
 (2603:10b6:5:1f9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a594) by BYAPR07CA0053.namprd07.prod.outlook.com (2603:10b6:a03:60::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 17:42:42 +0000
X-Originating-IP: [2620:10d:c090:400::5:a594]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 547bad26-d5f8-4ad7-6d01-08d816d3aadf
X-MS-TrafficTypeDiagnostic: DM6PR15MB3957:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB395762237AF71F7B6EE73947D5970@DM6PR15MB3957.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2iNMtOp6B3/Isz9d4HSVWVLAmIWs1Z3Y3LK+odcir0UvrV8eZ8u+lQwjco/N4DxPPH1gsZrLBuBSwaWrhyHqJHqbRkrjRHhOsZdTIElBJbFRAMCrYwLNrunGUXkimv6bAnupSWYrjQBSxYyCZldkOJoLFS35OvgbF/TaflNN9GuvabagLzj8SV5EcUsARhMcyK5FZWzaIEmoI1yqEeTmx3e7MehDptVHQUAizlQiECPwHX85HyANcL11ePuMmlm6hZc6xo+7IYBFtugrnDm3uhPofudbFeQh95Zkb54lj97P4hz2LClx28ztkPExWBc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3580.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(6636002)(4744005)(478600001)(6666004)(5660300002)(2906002)(8936002)(186003)(16526019)(316002)(66476007)(66556008)(1076003)(8676002)(66946007)(4326008)(7696005)(52116002)(86362001)(9686003)(83380400001)(6862004)(55016002)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 6iVn8L+gG9PvqNrdg99TEjAFoXLOpqJgqe5AufM3obMi7qExlcfrpwFpvqdRp5smcEDJ3K7IrkHWo7RtMHM7S85Gz0LM1jc9U1UIlVqHvouICXfcb3IJwvqeR5oZmE7v8+WCe0n0gwMjF1tcUKDYpmuN9WGVF2+3tPlst+TbL92iaTGx8sbF6unO/G397FM48lAY7RWj/5M9oY/ojAZpjnQLmAzB4eRzw/ZAiXz8hRwzQWrQWyJNn75cz7avKGko+jo4gi+V3FQKPuIQ3bc3YKXYsPhGhZbsv37uxqe/zQjxyy5q0w76PaoOrEBmOn7a4H6P5wcz826eqBu4wbac8mZHlK3wjZnLMWWp7KihJDznprYRCy3AEXV4c8xKylcBjm8TV2nAeg5g5IMDnZYZeb9/+sJTZE8U7AmxpYiqGHszousAfx08+OKZfeBoixMCUMMfKKn9ZZsVcLNFarzrsUjB2zqk4KxTsjm2ywlicObHGjq5yJyW5t5uHsLwMq/BG1DSD5oFSbn5kJ62hyM8Yw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 547bad26-d5f8-4ad7-6d01-08d816d3aadf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:42:43.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw1yXgF1EQ0K2X3A3NgoQHmdFp4rVl2JJJ8IiU5aV1NaRB3hEA9hyfA0/KTnGSY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3957
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_10:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 cotscore=-2147483648
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 mlxlogscore=826
 malwarescore=0 clxscore=1015 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220121
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 19, 2020 at 02:11:40PM -0700, Andrey Ignatov wrote:
> v1->v2:
> - move btf id cache to a new bpf_map_ops.map_btf_id field (Martin, Andrii);
> - don't check btf names for collisions (Martin);
> - drop btf_find_by_name_kind_next() patch since it was needed only for
>   collision check;
> - don't fall back to `struct bpf_map` if a map type doesn't specify both
>   map_btf_name and map_btf_id;
> 
> This patch set adds support to access bpf map fields from bpf programs
> using btf_struct_access().
Acked-by: Martin KaFai Lau <kafai@fb.com>
