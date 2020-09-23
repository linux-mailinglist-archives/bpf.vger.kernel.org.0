Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7F8275234
	for <lists+bpf@lfdr.de>; Wed, 23 Sep 2020 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgIWHRk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 03:17:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55846 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgIWHRk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Sep 2020 03:17:40 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08N7Ge6V004049;
        Wed, 23 Sep 2020 00:17:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=to : cc : from : subject
 : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=QnpxgczPJD5vMdG63ERHT7c4SnDkQT96X3Miiad6mwk=;
 b=TgDoHlTwX8D4m4E1u4rstw2/Qh5Dp7kXG6Veh3qSi2+Chonjp0WTpqRvYAspQF4niSRN
 UCsX283khR72S9U91loYd2K3RsMLzDfAbP+aNsLzCFCJSoM2DfHDKrPR5MIVKqxk71gq
 jWf6RI5gtswIJlqgAxILAOW6n+cRoCyQC0w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp6j260-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 23 Sep 2020 00:17:26 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 23 Sep 2020 00:17:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNxuJzx6NNd2rnCHLGDp7GADVUk0I+BlvR2zNUPdQwKk1k7Qfm/CBcGEZQjSLiHRfu4sZDwZOJboW4nscvrGUNYKn5xk863Icmbd9IrkVVOzWI2+VveJ1UnCPFBX1KFlN7MwzmjEyGUHOVcjycazkUUMXlZuODrWWG15pyrbCHeGJYrqjX6a2IhY9g27LJZq8au4SgsuvrSprQi3WFCKA8u+YPd1ydGxKWq8uLSo066HYW6S0L4gGbfKb+Y56IVgIaFqjU8fiX/IFh6X+RP61dxXqmk1K4yD5RU7hvZP1L43Haj7qMFticXgrnfTisaLMWvecQU9hmSHRuZTiRv1DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnpxgczPJD5vMdG63ERHT7c4SnDkQT96X3Miiad6mwk=;
 b=iFIz3Lt/EKdfizZQhRhEZDMEAENF3L3s/h6dHjG9njTCEbpBBrDZsurTNHrO9E+oAtLLBlwMxQKyPqbcHYekpDv9LJ0eBVYmYi9pSoWSVL1tQB3hi3bAjx3+cRoopF/pw5WF4T3JnmPBia2pj8R50bIfTvrTfFtU0o1jBJR4qwYzOWlLKTrFVxHJQO40uBxw2p0Ijua7Bj6nfTvy9lyB1OPsxTKTKB9t5jnzAHE19L3fRUkg8P2Z4iN6FsbywjoI8nWcWRcfHPf4L3sH5D3ErNGNt7pXnY9Y2HLALSpIWiKdNJqKN4DmM24/gInSQJSbeiPh5jA9cdaPHiNF0nxCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QnpxgczPJD5vMdG63ERHT7c4SnDkQT96X3Miiad6mwk=;
 b=G4OYbesRKnPSfYcuaGrK6pYpzeQbEXNYTJGbdjRy0R1j9TE/DqlYL3iLOIecKNFDuXmWpIgVWytrmUe32Mq52LrwvvYNTvTV5YEvkLnB99aNU/ihY4lq5zPIrCyR7PCsmq1Bma89AMhPzMso+ppJ0U+yBweahaCevLm3GgY3VKk=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 07:17:24 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:17:24 +0000
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrii Nakryiko <andriin@fb.com>
From:   Yonghong Song <yhs@fb.com>
Subject: Help testing llvm patch to generate verifier friendly code
Message-ID: <80d19887-5b77-a442-5207-a2685cdd1f83@fb.com>
Date:   Wed, 23 Sep 2020 00:17:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:ba4d]
X-ClientProxiedBy: MWHPR10CA0012.namprd10.prod.outlook.com (2603:10b6:301::22)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::12c1] (2620:10d:c090:400::5:ba4d) by MWHPR10CA0012.namprd10.prod.outlook.com (2603:10b6:301::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 07:17:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e4c266d-490c-4740-bb18-08d85f90b800
X-MS-TrafficTypeDiagnostic: BYAPR15MB3208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB32088A17660535ADB136505AD3380@BYAPR15MB3208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2OkyzBBtD0p+CUKQ1KmniOCiLdgo6PcyMVu4qI2K6Y7b/RIYgojp6tt/x2L9nx/dx3dGhrHQph0SZpz/jnrJy2TrLi2+z/mdbEIvyUl5+LaSrIhLMHHIZi9LMWQVsXNhlqATByXPieytuXBHufApRLVAdN+bRnShBhNEGy+Jj8JWcHSWwlr9qaS5Z0kBVhXjSFDxjHhlWxXFjQhdq0jjT+mZRKMhwSgVk08ReuyYkyUBgYV1OcWUVVV63oXtv9JA+0Jh9joIL9J6RM6/FDEgSMCPQu87nybU8HAfWBt7grJhpX2PlFuCprVFgIOywZiWwYwafNC7MDJ7N1ie289i4Pyym7oZZhvQda+ndwm1ipryMjltlDkZPEF0CA6Y862mbCeTKa4p06UBBq2JuxeFMLQyYvCp7fUYPVSG/Xquuuhwka7PLTFYmKHkSDJzmW3KELfCc941bhpHOD4D8l+gzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(2616005)(186003)(16526019)(6916009)(83380400001)(8936002)(8676002)(5660300002)(54906003)(6486002)(52116002)(86362001)(31686004)(31696002)(36756003)(4326008)(2906002)(66556008)(66476007)(66946007)(478600001)(316002)(966005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: McYy6G+yjfee4/ago0RPZlJ+EmzkUQMfh3tMKLO15MIy9ccyizYjsxEe72RuoQKETb+/XKAw0KmLzOsFJBaEZXcVeFQNrsrkL2bGTiPUCT26PxAMzOT0Pa0JsIhua2+lI7/VkJneTMUr0u2Dx2OY6x6Uo9rxpEMVPn+72+21TYhuJryTR5e1PencKkyz1eIZ1U7h9HZRRNYb5BcZzPNkJWuHVPOJtBG67VsaBKzSqE9S6XofDuKojJNb5mCJA29cLzlP6TpB92xTmYwjgKD0869fLjU+1MA2pZkkcK1CbYSDUyXBOBFX4i59kbxyJqtinLWdYMaEm6h90MaXITDPIbAJHc/stKNu8K1+cCPt0SmwypEtJpbdq0bON151+w3M97vLl+g//aAE+E36LgfacOLMUnT0qzW5hcUfOdA+a6GvzfIroh+NWAz9sDjfzTDseI6T/Vp8EBXYK9t0bRrp775ENYBP/ekLG2p1i5fCgGPOWe7650JTWdFThih+Ao1hjwqqhkGgLnXiL1k6qxK9LBFMiIt/uYkcYSzyHeLFArhpKzf0yb/p6E4qlkrsZzlrpYlQ/0C9dwJvrF570Pj7eUqbVckEYjYW+/re9jcyyr0T/Iawc15TCvmHOWbsNOQEiqrcCwVnR5jtSTvkoIp1K8oSnFUSJt2in+B3b/+5EBs=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4c266d-490c-4740-bb18-08d85f90b800
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 07:17:24.2178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+uGclfaUIWPtxL7NIMVhqN8DE+esgqkt8YLS35KtgM3PEh3bDxsujmQBRaazz/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_03:2020-09-23,2020-09-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 mlxlogscore=597 suspectscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009230057
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I have spent some time to add additional logic in llvm BPF backend
in order to generate verifier friendly code.

The first patch is:
   https://reviews.llvm.org/D87153
which moves CORE relocation builtin handling from in late IR
optimization (after inlining and major optimizations)
to in early IR optimization (before inlining and any optimizations).
The reason is to prevent harmful CSEs.

But this change may change how compiler do optimizations.
The patch can pass bpf selftests in latest bpf-next.
Andrii helped it can also pass bcc/libbpf-tools.

If your code uses COREs, esp. having a lot of subroutines
and/or loops, it would be good to give a try with new patch
to see whether there are any issues or not. In my case,
for one of our internal applications with lots of subroutines
and loops, inlining all subroutines and unrolling all loops
will cause register spills which cannot be handled by
the verifier, while existing llvm won't have issue.

FYI, I have two more patches (still need tuning) in pipeline:
   https://reviews.llvm.org/D85570 to serialize code across control flows
   https://reviews.llvm.org/D87428 to avoid repeated condition evaluation

Thanks,

Yonghong
