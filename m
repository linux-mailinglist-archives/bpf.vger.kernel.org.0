Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE152042E8
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 23:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgFVVsT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 17:48:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1822 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730646AbgFVVsS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 17:48:18 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MLiGc5010985;
        Mon, 22 Jun 2020 14:48:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FexwbODgDKRtQ8yRQbrSghNakWgTH84nI8fFnXd3V1U=;
 b=O5PqLyuoMIqtvOUQVFXXwcPJJLA7R8q55OwtkEzmf4qHcH5X7c8SV8+qgDwjUhnQ6YTt
 Zi91WaPhDW/+4CNbQsWbV5IvJAjbrRPa5uCd+3G4o4LpjPhyPmnv/sJaAAFvEt9H1kuV
 6vShNPmcq9v6L/gYsYcYkZ3Sew0pUg/qwlg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31sfykth2s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 14:48:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 14:47:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzL3A509QB4TaLBnqraseiJWBu8cCUOCOb3WYk0aC6LlXCXx/wEZxFsZk1uTbo/Y8iYD91cdJ5y/ltMF0xyAuA2uuV2tBvcbVsBkaBHOyMgDMdIgPHZ/rjNk15AP2U1dOhVU3Ds2k6ULZ9Mh/7O6qBYaNJ+PULOsNLA3s43ZjBY6h9rruWfg45kOdO2QhhiIXVp3QjvG/Melwh7HtSKSDWmTE7sHlKLhBVbvqPx2CehyPzi9SZ+cGG+St322bfZRG9J2HaKrQGS353bqAlqaBTcQyUJ1RLa+r4PbNfevwDWhAq7QlLkBtcIZU64PWr8y7NdNC+uY71siybLOBARjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FexwbODgDKRtQ8yRQbrSghNakWgTH84nI8fFnXd3V1U=;
 b=goYMrxxY4Rzb/I1OrXHTXIfWLbI347NYp44rZ+TpQS0KLGpkExa8AtJmZnXfJzX98y7geK9UjMmENQnhAK7XUFBzEYpsLH8mbjwNlE0DOCNlvvhajYhyxZi8PuyzReYdzwd5o4Y8Km7tJSLahGkxADXJemQqk12ANxnhQmGsCZ3ZySC7BnE7AaRuSQc1hZoLPKMeX8W1t6ZeUQpSG1mKbB3PT7Fn/gluqZkgEa9TAghTrkj3nINE4KkHD2mbZnT+KJ+QDesx1q5jiGOY8GyjKHtYpldhxSS3aXNWCesS/6uaIzw1AQ+qNbXVG0BRc1ZgB4/YopEZZwPjf7iCwFlHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FexwbODgDKRtQ8yRQbrSghNakWgTH84nI8fFnXd3V1U=;
 b=LSiJt/PJfwVMOKXQonqSRQfPUiURSs6ghbmmkHPPK/hxNa04WlnwmMo1m6KCsA8aVKoebo1YilB5OyGks7LAa1/yUtcPwne/HEHMCVQ6XSBdeUc0yKzy1pNsjMdsxcrQ+egleAKt35Ublf/6NRxeNG0HhyrKu1CeIhdhjtJpZJU=
Received: from DM6PR15MB3580.namprd15.prod.outlook.com (2603:10b6:5:1f9::10)
 by DM6PR15MB2556.namprd15.prod.outlook.com (2603:10b6:5:1ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 21:47:53 +0000
Received: from DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4]) by DM6PR15MB3580.namprd15.prod.outlook.com
 ([fe80::88ab:3896:e702:55e4%6]) with mapi id 15.20.3109.025; Mon, 22 Jun 2020
 21:47:53 +0000
Date:   Mon, 22 Jun 2020 14:47:51 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 07/15] bpf: add bpf_seq_afinfo in
 udp_iter_state
Message-ID: <20200622214751.jqnvaxpaiqvp6ehl@kafai-mbp.dhcp.thefacebook.com>
References: <20200621055459.2629116-1-yhs@fb.com>
 <20200621055507.2629951-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200621055507.2629951-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To DM6PR15MB3580.namprd15.prod.outlook.com
 (2603:10b6:5:1f9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a594) by BY5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:1e0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 21:47:52 +0000
X-Originating-IP: [2620:10d:c090:400::5:a594]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c24cdb44-90da-400a-b5bd-08d816f5ea8b
X-MS-TrafficTypeDiagnostic: DM6PR15MB2556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB255698900F2259C40F7129E6D5970@DM6PR15MB2556.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yO6CDuzPwMDjjHnChiSfLrHnZBx1Xhd8KWMK2Gfyagnl/stKkeLyVMPiEilagLw+Fkrf5xb40nwL8gYP+RLLWdFvw5ooI+Xjfc3JK0LoBUEa1ZqoqCcnDQF9Cj8pC9Q9o2cZESvhCEXhu/BmvbYQ5s6zh2SHF82Y1EVfcj35foQrhCdRgKghbFAsy2w2zO/pPMMH6tYuLPPFRztvp5qgf8KUufN1LN4peIX+lAgnl+ZR2TWcI4Rl6ZgpNvgehh7jT8CgUVPzuJre/2putyPK8SAdPfxCZ1X0VfI6CTlFz3RvUAkLFdA/fHK7AJWGphvg+GQIusN5Cliic8kVAaRhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB3580.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39860400002)(136003)(366004)(396003)(316002)(66556008)(66476007)(86362001)(8676002)(8936002)(5660300002)(478600001)(66946007)(2906002)(1076003)(16526019)(4744005)(54906003)(6862004)(9686003)(186003)(4326008)(52116002)(6636002)(7696005)(6506007)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +ZCjvjQ48ZzQJWJUFz6PCbGOY+YYE/rlDUoA1/yZYHGfvoOCWdkWM6PR+zaGZBQ3A7cUmAal8PGHSe9yqdrLZTL7Ro157LjrPNvThOCUW39us6I2apMYoGP47YjAEtDl9jl2JvCAof8pM3E3ayKDWYTDD7SxmTAi3TXT8w9n0DShEMC9NhjAwHdAoPNWX4OnW6cnWLbtiD8Zqu6kdwqbDLwzfjL5PZsVsi4yvfj1NhTWG9Zh7iUyd7GJaUnEGW9JDLXFro+IaqUEozFCKbEaJ0cOb7XYMhPqYnv4RVqpVluqihg/36bP/tznHhpfQLvSq2pczH5u+S8kkoeaQQX0peSszXdSPrG3ERZsppVoMTD9mfzj3v21ZI10Y8vUfIUkGloeij8d7AmCvWBG7iVk4Mq/xzTJyXSGNDQXwP550+zUrUDHOCMRFOCtuPAI2HLUb2KQuCetF1MtGotS6Tev0RGGJfWE7rs8uHTdC2cofzIgEt+K/dxvGriQRkrXQ90Y4fDVX346qmqEYIABnwEwTw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c24cdb44-90da-400a-b5bd-08d816f5ea8b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 21:47:53.3037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCH/U7I8ND7KiGraBCNGb4Ps+vJwvvJZ3jfem9MbfyXikpFSnpQlUQgNvq8ng013
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2556
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_15:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 adultscore=0 cotscore=-2147483648 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=782 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jun 20, 2020 at 10:55:07PM -0700, Yonghong Song wrote:
> Similar to tcp_iter_state, a new field bpf_seq_afinfo is
> added to udp_iter_state to provide bpf udp iterator
> afinfo.
> 
> This does not change /proc/net/{udp, udp6} behavior. But
> it enables bpf iterator to avoid get afinfo from PDE_DATA
> and iterate through all udp and udp6 sockets in one pass.
Acked-by: Martin KaFai Lau <kafai@fb.com>
