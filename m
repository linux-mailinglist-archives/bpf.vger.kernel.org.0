Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF642B2134
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 17:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgKMQ7e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 11:59:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13320 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgKMQ7e (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 13 Nov 2020 11:59:34 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ADGuNNV004045;
        Fri, 13 Nov 2020 08:59:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=o3rMQ2o8SVPdk9JYE4RORwuHTuYlpmGLfnxQehXDqVo=;
 b=YB2eVgDxvl9RKOWrrzv1GUGkSFjZHQwHkHc6I7PV05JhNmj+FZDGsk9w5hXbFj4pCX2Q
 Zc2w3YWO+dzwGQbyRNJxarH6jofoI80pVXgvj7Ruaz5zKTS9AldRGqz/eWy91AvY4RJf
 nvdyOnEZq2I2gRQ38lC23Xax4NR4z9Vat8g= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34seqn40cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Nov 2020 08:59:30 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 13 Nov 2020 08:59:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHoFfAcC+HJSNOL9OtI/t/9c5+a++DiESKuHG4RcVmrzNvjUZaHv5V1/R9OZlq+CTIWhkzJ40pxhx3qRdmL2RxO10abHMCPIlxX/lkGwzh+3Sf0NzU/QNHDmDJn9yCLyGTQa26a8tM/iOqndQUmhweKsobjnp50IxmIJT5ITbJuTThpknJwwMkMAvD6DlMpuABkS40FIOtejvTstYaGkX1qF4LD7IQH1vRfmCqZUtEDSPH60eqfiSxD6iSD6sP8jG/foC9I0yzrTCMnQ0UZH2/XGsW4OanYAjXJX5Hakb+hjkQ72CjidQmduy7qNyu0AiNwg8z6wy+iz8O4POdZukQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3rMQ2o8SVPdk9JYE4RORwuHTuYlpmGLfnxQehXDqVo=;
 b=eiR8eu+iWuVYHorzcpB3ZHjBLSfJ1//NJukxgv52APclhnnfyHhnq1glHP3hj0K65H2ZDBcsv9uqq3xrMrcmFsH8qPF5H8mgUDzz58Prx9GGtCKC6/B7RNthDqwBsg3GV3C7YR6hiIz3ZesAeqVeClKEKWswsj50MgYW6T0VLCxiCdLa9Y1P56ODb8ixr4LXt61/1ez1xYItCwaQWhRaMBTl7M8ZU+qDAAvB9VlGhR0wWLEfCZPJa8i59EUri74+YkUQLYqIrN9O8f/k6SSQgEIO1gHJa5K/ep0CjOa/fOstytgc5s1i0J4veUE1e9cTaRHpt5pc9F1UqvheRcxrpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3rMQ2o8SVPdk9JYE4RORwuHTuYlpmGLfnxQehXDqVo=;
 b=Zv9AISVrH24flY1FcU4PuFCUielbIQoPJm8hBI6/i9tNuVxUF2vUrCuSLjVghLs/RxjPJBxZXf1dGkOgX2Z9PNMAAyA7rluhdQ4khfDFv1HP8pZUrFNMePLjyhWgcMOqxERP/Lb10tO3vB7SBW+tJy2aSG9pFDoPQOtLf71Ssgs=
Authentication-Results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2581.namprd15.prod.outlook.com (2603:10b6:a03:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 16:59:28 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::8887:dd68:f497:ea42%3]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 16:59:28 +0000
Subject: Re: Extending bpf_get_ns_current_pid_tgid()
To:     carlos antonio neira bustos <cneirabustos@gmail.com>,
        Blaise Sanouillet <blez@fb.com>
CC:     Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
References: <C71Q73J0Y8S5.3PXMV3YTPDCL7@maharaja>
 <13b5b2dd-bec0-cef2-7304-7e5a09bafb6c@fb.com>
 <MN2PR15MB2991E847DE47A265E71F1BC8A0E60@MN2PR15MB2991.namprd15.prod.outlook.com>
 <CACiB22i6d2skkJJa7uwVRrYy7dtYOxmLgFwzjtieW4BFn2tzLw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <9067600b-f340-ec3e-2ce8-d299793c123a@fb.com>
Date:   Fri, 13 Nov 2020 08:59:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.2
In-Reply-To: <CACiB22i6d2skkJJa7uwVRrYy7dtYOxmLgFwzjtieW4BFn2tzLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:a1da]
X-ClientProxiedBy: MW2PR16CA0048.namprd16.prod.outlook.com
 (2603:10b6:907:1::25) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::11f6] (2620:10d:c090:400::5:a1da) by MW2PR16CA0048.namprd16.prod.outlook.com (2603:10b6:907:1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Fri, 13 Nov 2020 16:59:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81f15152-e9c9-4454-5ae3-08d887f57b70
X-MS-TrafficTypeDiagnostic: BYAPR15MB2581:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2581276C967A81BBA7F94510D3E60@BYAPR15MB2581.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/fYVeYCDpz0eaOMp4GzRG9ETVE164ksTArszqnSVYEkpLOBtdAXM0cZK5qDZV3OTkznOSFJvjIK27qn6UZSHmw3rha6k1bhkf/PF1clGjhAut9djYZmhEQKFSyhtZRCGYYKvJKseKb9Sqr+ONJRUzpourgasXxKn8Qt0D249b6yezcuXyQ3DkRqTKEQoWY1fbAdL53wJzEFGeUvY3uw8YGiWM6UPxamQ581ma3TBF0cVE0HbxBRblLp/dm22IQYEpRRQTO4RCyji0KUgW4Tdr9YUVetiWtoaNG0V5h1fOMm/U5QRh+Odj05UvM3FI0c1tg3kz951V34XZaMdy+Z5rZTTPw4S73+m6QvIQ1496MABsRJJVPNxk3nnTSSps3QbbtlvGy+ddeUQ/zoEJ0UIC7qlPzj2G4DGV+upCyUCUzqn+7PTHjPhfSdrs3VTZtOx3rfoTyXFgAt8nvJGd/Ogw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(396003)(136003)(366004)(2616005)(6636002)(5660300002)(16526019)(110136005)(31696002)(31686004)(478600001)(7116003)(6486002)(86362001)(36756003)(8676002)(316002)(66946007)(966005)(66476007)(53546011)(186003)(52116002)(2906002)(66556008)(4326008)(8936002)(54906003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4+XjmNAEzbZFi+EitdBPJNlRwO18Ghx24P7UChZJcNFYerOXTCel6IkyXvhqWo9mUN8f29owghMihVziqsXhMJByO7dqS2u9w6tuNM7oYV6y0dtGb3oheaPvWYcCGm3nd6k8X0Y0GtZimja2RlfW7q3E3TJXkj5RN78a4czNaONX5UdEcmqNwAbwLTECpCNz7/SF1wB+TeBda0c/fPSjthXaRltsNoKwFGmpefLSCowpEQNHo6yVIlxIXpGQQehGrUEmCfxsmis484qQWuXE9hQscrrys25Bndw/LKaraXWfVj3nWcUxMPdNCxGIjMG2akNNMd9SvejvJPrVwSKUNinF32aztG51gFvhEc0BRiTJw+XWnjV1262w/K+5xK053fOH/13D8sXPgsOVDuaOQGNYsRU/ZL3dx25Jh/vOPjDCzgebRoKI4VJZMu6eu8EMqEhGS/B/BkEZOJqY5AF2frHjoOwPmX3z6K9sxGajbF2iWuDXW5Zleo38Vy1EqkBs2DfF2RGSAVeICG7LbnBobBQj57Bvk+H9MaM1gz+c9A3hTNXyp6d8bcY+sU6ZKtuOVSxXl3avZR3LBb9bTlPibZpEPBdX3wsuxuC8OivruIBoitvoBJpzlRZbfeHDeEUPX558maMGgsYyNkGwqbG4ZRpVnZ30RMyAPFzd6c7I034qCUKG/2WGe/wvx5MkQXHbh9HLqMtWTnxDtZ4bUU/0ay4xiyrvTnZOmgUV5nUdF/qkVXhOy7Ih8fIcudalby8TzleAPh0pjGZVK3Q0a9DVIWU5krr61nPnI9YAWdVolfCYyinNHOapkAoQH00VaZji1xRV0NWxOT/R9GVR4JVbOp5daoqw4zEbKtgZrnBFRMnMrlqNL8jcQIDG+M5JsvdRxNMhZdOq/WQzZ7e4lpCwzuaRSRYZpHVSoNWyFFiv6aA=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f15152-e9c9-4454-5ae3-08d887f57b70
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 16:59:28.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNvT/lSZZEFYlmkX49zpbZDtM7bP9yppHTnHWl1iwJDBJFF+ZrZ+Z57t9USXoaM8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2581
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-13_10:2020-11-13,2020-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011130110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/13/20 6:34 AM, carlos antonio neira bustos wrote:
> Hi Blaise and Daniel,
> 
> 
> I was following a couple of months ago how bpftrace was going to handle 
> this situation. I thought this PR 
> https://github.com/iovisor/bpftrace/pull/1602 
> <https://github.com/iovisor/bpftrace/pull/1602> was going to be merged 
> but just found today that is not working.
> 
> I agree with Yonghong Song on the approach of using the two helpers 
> (bpf_get_pid_tgid() and bpf_get_ns_current_pid_tgid()) to move forward 
> on the short term, bpf_get_ns_current_pid_tgid works as a replacement  
> to bpf_get_pid_tgid when you are instrumenting inside a container.
> 
> But the use case described by Blaise is one I would like to use bpftrace,
> 
> If nobody is against it, I could start working on a new helper to 
> address that situation as I need to have bpftrace working in that scenario.

Yes, please. Thanks!

> 
> For my understanding of the problem the new helper should be able to 
> return pid/tgid from a target namespace, is that correct?.

Yes. This way, the stack trace can correlate to target namespace for
symbolization purpose.

> 
> 
> Bests
> 
> 
[...]
