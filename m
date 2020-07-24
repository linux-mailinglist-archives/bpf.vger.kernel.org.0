Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD422BD80
	for <lists+bpf@lfdr.de>; Fri, 24 Jul 2020 07:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgGXFcC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jul 2020 01:32:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37936 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgGXFcB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jul 2020 01:32:01 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O5TkIJ003062;
        Thu, 23 Jul 2020 22:31:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=U00cGWftkurPHDfwj3ge0E5rHNXfVWXTHiHngLg5BUE=;
 b=UJa/EZArQZ/3eHutRsQnzSCduFmMSVFuOXtwz4yPShCRr8ecpf25ITNwJ0cm830KyB49
 +rETKQ93SR03Ulre4WILcahnKgwK1PJEY/vCT7xi6JvxAWgAwbfEUUmYdV1u8+tHYSsF
 FpkLQxmPKvSKL2VyNNhNRJQWoCTto1ReJHM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32et5m06ej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 23 Jul 2020 22:31:43 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 22:31:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4lb+HgJskLLM1nPkaUHRRjgzYm4TDECUteTO1ryv9tLsiR3pLwWXQSEfB7jDMjFAEQSVtTTgPwpCeHCLqMO6qzIqhIiEvgaLH09Q4ZfNViCo7w1+pdcSSKv7/38buYqJXVqDwPaUA/nAz4yxWTnPgES1cd9gJkS+fORtgjPQXZfM3ekXZ4tpil1ypN/1tdpKdyVCeXDZvql7CXTc06gy+rgd+MBSfru956/ZjvecnO2lVet4RHjnKk2eYB8xloeh3DAvbx8T1N+sbfTrILeYjt3SlpEGWjF+HF2/9V/oEwJpTF6Q/tuU9ows1/eeZxY1v3+yak97ZvxmnBQqImRGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U00cGWftkurPHDfwj3ge0E5rHNXfVWXTHiHngLg5BUE=;
 b=jS9EEkafOywsXyX6QJ3DYOxqknuDgajzwNea7xv2r5RGwDAEoC4XjkMW7Ev32LdTyUlfDOqU/1EftiYvLW3sF/QIAa4d406NQYhoMC5anlu/5rWCCbiWx1i22EZA4aiegp3Wo/MKYDfsicKSSMNkfQNiIH7mf4EKqtU4dCkFD7NJaV46stMW9n3+ia1/saHrK1qCapop7lJ8azOrHxg69LGLXZ2Pcy44IvsTctjATlSkkWZK3K7+Ja7pXDtz5IyQ109vXTmW3NWLcRdBJ0Nudmotwm2iKvT/Xfzhw3sxxg2WdQwiSft8V7KTm6EpeM5Img13uvYXRNQsMnWjlIKQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U00cGWftkurPHDfwj3ge0E5rHNXfVWXTHiHngLg5BUE=;
 b=Cel8O19avTIZ4FeLLBMZVjtHvJ8mq6az4EK3ffJ+6CguMKqYwuuFqaPAJuI6HkNU1rftoea712mNMmsGZ+Wsn8mQQ+zXN+9lcE/lcZ6bEMcPTF6VH8kQJrT2RqkeGhs0xRB00DgZ469uz1ZcM7asvRbFL+gMF+l50Rvla/R7Xxk=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BY5PR15MB3714.namprd15.prod.outlook.com (2603:10b6:a03:1f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Fri, 24 Jul
 2020 05:31:41 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 05:31:41 +0000
Date:   Thu, 23 Jul 2020 22:31:35 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v6 1/7] bpf: Renames to prepare for generalizing
 sk_storage.
Message-ID: <20200724053135.itp5qrqaplbyzxxw@kafai-mbp>
References: <20200723115032.460770-1-kpsingh@chromium.org>
 <20200723115032.460770-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723115032.460770-2-kpsingh@chromium.org>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:e4fd) by BY3PR10CA0022.namprd10.prod.outlook.com (2603:10b6:a03:255::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Fri, 24 Jul 2020 05:31:40 +0000
X-Originating-IP: [2620:10d:c090:400::5:e4fd]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2b0d250-d40d-4ff3-aad7-08d82f92d7fe
X-MS-TrafficTypeDiagnostic: BY5PR15MB3714:
X-Microsoft-Antispam-PRVS: <BY5PR15MB37145EE4C29301848CFCABCBD5770@BY5PR15MB3714.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tuG5bSouEBlxfy1tL7SPJI/NbkREwTeqr4d4xg6YD/qiqNDMYVE8YuoRwpfjXn6L+paZMGU+nv+43OkbhPUzXt+kKUefs45HZ/H7VMrOrQzECVXoCs2/vt7cp/+hRwbSEygyhGg4U2NAv14bWdmRwyb/9mHHCW2V4HiLWb4oSJGUJW4ZRY+kCrSxJWIT+cITBP1reIEbpPSscvDcTUSNubPMbwk9ozWRT5Ws5woKtRpGPEVF8eL7e5nMGYBf7lCDRnziAqhUjqORRZWxy4mm6+Xhv8rMekWU6XoIgpv+iqXE+2YhsOVuxCHQd0crDHS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(346002)(39860400002)(366004)(376002)(2906002)(478600001)(6496006)(5660300002)(86362001)(83380400001)(186003)(16526019)(9686003)(55016002)(33716001)(52116002)(6916009)(54906003)(66556008)(6666004)(316002)(66946007)(8936002)(8676002)(1076003)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: YGXLmUgTo9odZWJL3u/UEsFeqmUVGcN97dXBdChXhJ1SFf+AHaNLzh4Dsw/awyTRzNZyfVQv0XgbxSIi/AZfXJSrZ2Gd9AUb5fvhyzrDViAvn98rBrxyQ6clQ4qFcsLvbVuPiCg5DFeDR0LAdTHbAyGTKLU6tF8Gxo2SjCt/6HtRyR0+hD3F4javIdHF8EhuNsMg5ICDLy9Qaa1cDrB01vHOWWXaDcA0rqliP29oYeoWqoXnub6Jz9yaLu94Wjs55nwlni5eyMD2F/TBfgMqz/v8YKsP75Hhg5zbTGfQlp5RBr9k4WZVX3hlvvtQV9uclHgHFiuTm692V0ASQZSPJAmNZoJ2v6iszGc7MC4QoHLVVAY/BsWs9UlDG+54N2HMaPSopMrGZKaCt3yGVpJSNLfgVYbXG65H52jFoA2WBaHaYFs2XpOTG0flV+hU5UI2MpJfdIL6LIvC1NRbmv3eSLaHYCF4wW6rJlLuADsp7GcDkNXI/zDou/mYJtaiQsbMrMzkIZGW4oDa6Jk10fK1WQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b0d250-d40d-4ff3-aad7-08d82f92d7fe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 05:31:41.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/GcP343GhG/IxdIK7sk7MKOd7TwrnWUa5wJh6qdhl25Aruxnr+5jcagMcAJsh8R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3714
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_01:2020-07-24,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 suspectscore=2 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 mlxlogscore=790 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007240041
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 23, 2020 at 01:50:26PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> A purely mechanical change to split the renaming from the actual
> generalization.
> 
> Flags/consts:
> 
>   SK_STORAGE_CREATE_FLAG_MASK	BPF_LOCAL_STORAGE_CREATE_FLAG_MASK
>   BPF_SK_STORAGE_CACHE_SIZE	BPF_LOCAL_STORAGE_CACHE_SIZE
>   MAX_VALUE_SIZE		BPF_LOCAL_STORAGE_MAX_VALUE_SIZE
> 
> Structs:
> 
>   bucket			bpf_local_storage_map_bucket
>   bpf_sk_storage_map		bpf_local_storage_map
>   bpf_sk_storage_data		bpf_local_storage_data
>   bpf_sk_storage_elem		bpf_local_storage_elem
>   bpf_sk_storage		bpf_local_storage
>   selem_linked_to_sk		selem_linked_to_storage
>   selem_alloc			bpf_selem_alloc
> 
> The "sk" member in bpf_local_storage is also updated to "owner"
> in preparation for changing the type to void * in a subsequent patch.
> 
> Functions:
> 
>   __selem_unlink_sk			bpf_selem_unlink_storage
>   __selem_link_sk			bpf_selem_link_storage
>   selem_unlink_sk			__bpf_selem_unlink_storage
>   sk_storage_update			bpf_local_storage_update
>   __sk_storage_lookup			bpf_local_storage_lookup
>   bpf_sk_storage_map_free		bpf_local_storage_map_free
>   bpf_sk_storage_map_alloc		bpf_local_storage_map_alloc
>   bpf_sk_storage_map_alloc_check	bpf_local_storage_map_alloc_check
>   bpf_sk_storage_map_check_btf		bpf_local_storage_map_check_btf
Thanks for separating this mechanical name change in a separate patch.
It is much easier to follow.  This patch looks good.

A minor thought is, when I look at unlink_map() and unlink_storage(),
it keeps me looking back for the lock situation.  I think
the main reason is the bpf_selem_unlink_map() is locked but
bpf_selem_unlink_storage() is unlocked now.  May be:

bpf_selem_unlink_map()		=> bpf_selem_unlink_map_locked()
bpf_selem_link_map()		=> bpf_selem_link_map_locked()
__bpf_selem_unlink_storage() 	=> bpf_selem_unlink_storage_locked()
bpf_link_storage() means unlocked
bpf_unlink_storage() means unlocked.

I think it could be one follow-up patch later instead of interrupting
multiple patches in this set for this minor thing.  For now, lets
continue with this and remember default is nolock for storage.

I will continue tomorrow.
