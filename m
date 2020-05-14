Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD9F1D346A
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 17:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgENPG3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 11:06:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64454 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbgENPG2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 11:06:28 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04EF4Tx0014528;
        Thu, 14 May 2020 08:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vDS/V0v2ZbFkzZ4w/sZdUNrVlkAITuRowrVXO+k6mPU=;
 b=pGtqISzsS72huMRZOMLk38TYch8dZ7mXYo8qwvbkIlJRvP8DYOMSr1GsZ4KpyF1ankTJ
 eiy0w72ivRiJUjWDtzvotZu/mCrW0rY/BcYll3yLyluD84wsrRx/EUXBpipqH2TluQKV
 UGBE4vh9sHFpFNen/eJbBi2AB1C6SXvJvXo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3100xhbxha-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 08:06:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 08:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAt9jVpp7/CEifNq9v68LYVLpO/RXNQTM0dC4+ig3LnUhaoz8kX4KGLIsPNiXL54E0Ig5gXesPdX8s/yJIblfxxUc2lqVK3hAGAQbJeWuQdg16+OJ/aCViLMd+Q8UBLgaGhAhMvQnylgCrj3Zg4ugEBWX7wBFRIKZnNiJouMZPV6cZqUY1tFLw8v7nPt6UEzBsVLG/s+4hX5be1H8seW2X8oGZOwjzfMxfHuYA/8tnK+YnQ7Fa2+wsEhWkMJzgBWm83hPwsVKJ/2x/OfjOWn4eXkvKlavIWlozRkBXMNxrfnwEJM3ovkkFFZ9HW+165ua7apQYTOiJae2vb6I8mhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDS/V0v2ZbFkzZ4w/sZdUNrVlkAITuRowrVXO+k6mPU=;
 b=SS723+TvXyweM13epXxFDITr0Nb9tennxWEYuV3afz6sFjcAPqFrTeF0I63YeEFsx7Nb9y0mSaU+BLbCiYx77it+Mr4PZTBmMMaeGoYOih/R1hcmNUhKyJ9XCxJHT/tBlJ7hH8RptHs3LibSrFD9VRwey8glVlhwwrhnaGZYq89SOa3+qu/5Zu8v4rshb8k8tebaHX3Z3XirafKxK9HAl0QUCObVQTNNc6n5MIpWWeN+bWVwvdthSC4QUiWBnHf76AfKBywaS6CONpgUDAN+tXaqzibDIfaUS3r18OuBsqxQxc39vj+7MVXnMiKCEtXgkLv9lK+As409czpZDqRaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDS/V0v2ZbFkzZ4w/sZdUNrVlkAITuRowrVXO+k6mPU=;
 b=OvMN7yb5tbj6+cNL39Y+KGenaVr3KEb/DpOUy5LOGtQ0fTG8je4h+Y5ZEpXgwpFzzhYXmSbA4oeUXQLtMdAUKXRzIOInX6D+XtGphEvpxPYeXM7G0nNiNj1EUa3PdPO0CMHDZ+VGGOJv0LxW2EWrnlWO5ru/2Ww9djyIbRgyVGs=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3479.namprd15.prod.outlook.com (2603:10b6:a03:106::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 15:06:08 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 15:06:08 +0000
Subject: Re: [PATCH v2 bpf-next 1/5] bpf: Allow sk lookup helpers in cgroup
 skb
To:     Andrey Ignatov <rdna@fb.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <cover.1589405669.git.rdna@fb.com>
 <9f01cc9fd918988613c6d34913cf52fbe7369515.1589405669.git.rdna@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <29715891-2ec6-a5bd-ab48-a1dbb1666045@fb.com>
Date:   Thu, 14 May 2020 08:06:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <9f01cc9fd918988613c6d34913cf52fbe7369515.1589405669.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::33) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:3bff) by BYAPR07CA0092.namprd07.prod.outlook.com (2603:10b6:a03:12b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Thu, 14 May 2020 15:06:07 +0000
X-Originating-IP: [2620:10d:c090:400::5:3bff]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42721d5c-05e6-499e-5a94-08d7f818549f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB347954487E6DB2C33316C4F8D3BC0@BYAPR15MB3479.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5zGTB98Jt6oFXEhBnwLu/gsURJc6HwpTgfy2Z+9P5yl9Sq/TCDo5b4oreDP6bh++aqHZbLpez3n3J7Fh87ACibGwNubEVdm7YSbPqN0b3UktbgsTnEr5LP80LS2sjGQ5k72yBcxofVvva2qW+ZU8mHxLNukIQlo/euiACizXwLSwkrLS16uRpoTSGTXA8dUh3YSgeUH1IXj/ay1X0KcOcTbJsfEVsTaUxjmeKHbEo6OdYNH/gzo/tRbiS2FcgDOn2Iz67EPH4LN/1eFc5zj5zVt/ZAZ3d/Cfb3OW+UpJIeWGn7icJtOhrjQHHNyOnKySS8sqN4Zk/cc9BV1smB0dtoYazJWM0w4fzZNSMZgqjLW3NFKaPU7VWy3dEWFbfv3P3L/J0awc5hTf9Eji0KUbYnjFVbIxUK/8+jyTZWEaC2YGaknBUQ2B2OwUsqcfIQajrikbbDgoBC/sIbXciVFDIJU+QLUQeayj4NLWipq6Ih/Pr15dxbm8VaLSPIXAXgsV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(366004)(39860400002)(346002)(396003)(36756003)(31696002)(66476007)(6506007)(53546011)(478600001)(16526019)(6486002)(66946007)(66556008)(186003)(5660300002)(4744005)(4326008)(6512007)(316002)(8676002)(31686004)(52116002)(2616005)(8936002)(2906002)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hIXvvSMkrB4hOySHuIH7HNjoSlQ3x00SDj3DmXDX0t/22lSaIaA9tbwwQkGpCFf2ag3v1TfQ2jifQ9HEJKsQGSJr7eEP3wd4Zomn0TLyiDBC/YUt/Q/3pdDJg5JvBi2JBB9zqw5bJJ1ZXPi2qar/eaVEbcb2nOAOT+YVwhS5YztjqeBx5xCN43VxGvo6/xHnl2yDPqy33JMk8XDT4cJzNW3Vvx79oaB1NSVvsAgvW8WhThXpeKuhWdgsGqFXVBWq8EiHewZop6w3lrKeu4QuKAcuOpUr2BnuXcXRE4/J2l6s6icjMzSyPlFyAPQZKnhSN+bQ76+nKOThuArp8y1OHLX7N9JMcjdQF0HUKqma9GE9jTZpWb2AC8vABnxKhXI6ouh5VRdRAp6pXVhzkbBNsVLWKlbaNU7sVgj5Rw3TuEHSOlaXYiG5uYO3E/v6vy+bfd8Sdzr+U2XdZdPKJ+ZvtQX0KO9O+2m7bDg64MlA2cq7hrDeTiYQBBMvV49fu4uTr0iMGdfXZJ9A2Ohnc3qvEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42721d5c-05e6-499e-5a94-08d7f818549f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 15:06:08.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/MXaLuDpKnltbD7h8GPKplyvEz/77xJYUL1gM+vGcEB9VrZJP+BeRwrggUqEPyu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3479
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 cotscore=-2147483648
 mlxscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 mlxlogscore=916 phishscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140133
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/20 2:38 PM, Andrey Ignatov wrote:
> Currently sk lookup helpers are allowed in tc, xdp, sk skb, and cgroup
> sock_addr programs.
> 
> But they would be useful in cgroup skb as well so that for example
> cgroup skb ingress program can lookup a peer socket a packet comes from
> on same host and make a decision whether to allow or deny this packet
> based on the properties of that socket, e.g. cgroup that peer socket
> belongs to.
> 
> Allow the following sk lookup helpers in cgroup skb:
> * bpf_sk_lookup_tcp;
> * bpf_sk_lookup_udp;
> * bpf_sk_release;
> * bpf_skc_lookup_tcp.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
