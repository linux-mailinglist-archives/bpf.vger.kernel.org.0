Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1257C2A7054
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 23:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgKDWVM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 17:21:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58050 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728565AbgKDWUn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 4 Nov 2020 17:20:43 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4MEZnF001281;
        Wed, 4 Nov 2020 14:20:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=AOQGvFblC50FPhkJ2o2zgBPEf/bpy9Ys40N71XKwc/w=;
 b=UBAanx8s3a+L/nS1lt1ir/Wok7wC+fWnbp0jG+wYLaxoGtUG+fOZcgmhrqe0fTPtOZtF
 CX0aYt82gN00gPq660lIPbbfoc2WFXs/7+N0dG+Mhv8kBKnYY5U7FdRyz/SSTh6ILsSr
 LGHQVaB7fBhYi9NkOlj+jjH5T27rHXiKpMg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34kmux53xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 04 Nov 2020 14:20:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 4 Nov 2020 14:20:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5BpVA1kWynQiCWFYqvRrBoMblyHMZ+XmoUP9Ak23wsPnBcHEq8D6uc109icRoMg1T/faFdWee+iwQKJj6l+XSwmR3yesh6/2O5Vor3rxOgUB00hTP4VK9H2YDLwyuKfraE72Rly1Cz70JJqBC1oj4SHAj06/yxPokf/UwvoGTHqn18m4lbx5kGw/vWn1UxyLku9HQFxu31uIH2vzVlpusYeCoPsQCe9UmltQ/tJIkqzFLVLp6gIu7J+HgrR8wCFF+DwvQfEb2jtiWbPkFZJQz0gz3V/JO+Vb2tG5ue3JzRdQFgWn00iS7fd9z41vd/5tLnGFwlPvzfj2t2cIR+HcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOQGvFblC50FPhkJ2o2zgBPEf/bpy9Ys40N71XKwc/w=;
 b=kKMo6ddXOy3QoQA1G2XGTLIovFz+8Lhh+WvoFpx2ws0POdvRcXAo34nCjmlA7LbWHBbuLOHD+A8Hd1ShbyKV0eLnnh+2FS8gmEOe7Fk7eZ5n9Y+QEH4zZSNof6GZ2++SB4AHBB95r0xVr3mk7mWoKKaEDE4hTqD1GnpTYcaa4KCJv75YXJAaxzxywRu5S2H8wxoYBHiO/5jkRqljG7Pf1MWJv4UFg3c5Bjkr/Pul3ornGD7MtsJBNdxeSLR0xfu+GDWZIhdxVCT5WuEHLOMLZYfPFv9P++juegKMtG5StcpnkwQqlfSBCGMODL24Qg2hhRb5AI8MZB55oOdgfFXTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOQGvFblC50FPhkJ2o2zgBPEf/bpy9Ys40N71XKwc/w=;
 b=bdglQBNF4diGZbP+SnjQZyHBYjcNcI18kYgs54NHeeHRL7lzKa7VZIsjI+GggLUvXIklT50pkg3ASNreQ0Y3xOMqJQMiRPyHxV2phX9qz+HkrpqFmxLqIEwLfRpAbWn0+kipBMYBaAd4XBQxxeY9GgqlADIToT0SqibiyP4ELlg=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by SJ0PR15MB4235.namprd15.prod.outlook.com (2603:10b6:a03:2e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 22:20:23 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 22:20:23 +0000
Date:   Wed, 4 Nov 2020 14:20:17 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v3 2/9] libbpf: Add support for task local
 storage
Message-ID: <20201104222017.5ch244akvm4oz42p@kafai-mbp.dhcp.thefacebook.com>
References: <20201104164453.74390-1-kpsingh@chromium.org>
 <20201104164453.74390-3-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104164453.74390-3-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:3041]
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3041) by MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Wed, 4 Nov 2020 22:20:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a171537a-a423-4f0a-abd6-08d8810fd2f1
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4235EA1A44DC6CABADCD59D1D5EF0@SJ0PR15MB4235.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cydm7o/iY34IZAFBZ+oZxNWYR+ic7u3LghxWJx3i3PFXY/FGUwF1wRhXNbKz06iewoAG8xxMaJ/ZWoy6II9MB0WfUqgO8fls5S7muWo0W6dundjxiJb3eDh0ir7PpO8DVXy1LxT/qqmw78nb3+aHMBkEt+1oWFneQEIVSku0pf/qs9mqPAAsgM2I93pQY0nljgDVfQnoTS83bxolcn6vVcui2goiy3N4HQF6Q5YXl9wKUHD0pv4YwzNIHIg9ICygkfDZIUSB3EIQ3xNWvbkrsv3bBR5sDjiMULMznco/hfvr6/cRt8Ginf/L6IkbNgI/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(376002)(136003)(366004)(9686003)(6666004)(8936002)(8676002)(6916009)(6506007)(4326008)(186003)(55016002)(86362001)(16526019)(66946007)(478600001)(5660300002)(2906002)(7696005)(66476007)(83380400001)(66556008)(1076003)(54906003)(4744005)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: djqhDZavkomqmN4ezIN6+aI0x0iC7y/HYiWeb65oIl2/N/dvp48iTZXiUDZu4uKeRVgx2v/ffX+jFLF3G7yYJXsk5Y5hjb2uyUvjSaj3ntdlEOka0+S1RteiulWpxSicDo9NaynoPNYO3tGFzBhNAWtPWtNsJqIAqmpemOpHDwTvXDsq0j/d8SI6+fuEgPHM5Cn5XtyDFr1mcqwqsPk0AdQs4AsQ7vyMvYS0BauIHNVrEy2qXGAF8AHsaEFCWN1bk0fNgDUwGd2eZ9uUEIZ/H/OCFH23/W6VishIqbKxN3UaFAEhx2tP9tmPy5uaDj+cv1QQrohIBpJ8xZxeRx9bN6k5troVCKYeKJCYD/2SjF44WgZ2omykJm8zEc59SCREhaZl/QVHxPzM0F6DH3YEBgVG9B+FjyPEhDnptqapc9vfokMfFgKg9Uerk25h9hTiyNruET/DUccWptyDUq1lBWuP0/WmWHTwV0CK7wzKnfuNV+h01HWsJzOLWhkslFiS7IrMbpO8mlbfzDRjkx2wnADf/uQCVoDEkqAmdZ59qqj8SOTLmAPKvmqYxx9u8VtB8U8smlkjg9wAgCugdJWlwyizuDDdT3rqQujfuCX9wv+x7J3AA6jYPJ3QwgtCHqGeG1Ps5h8VeIBcuayi6bp0BGdk9bh5mrvDTYeGvkPVIhSZgirz4PiGjr8yQZpOVMf1
X-MS-Exchange-CrossTenant-Network-Message-Id: a171537a-a423-4f0a-abd6-08d8810fd2f1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 22:20:23.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnl6W3OzgNqAyn/E7bhwWgy5vpfPlIGmh2A33/M8fQtJcgnC1snouU+8fVdKFtRC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4235
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_15:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxscore=0
 mlxlogscore=876 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040158
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 04, 2020 at 05:44:46PM +0100, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Updates the bpf_probe_map_type API to also support
> BPF_MAP_TYPE_TASK_STORAGE similar to other local storage maps.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
