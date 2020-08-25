Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1575A250DE2
	for <lists+bpf@lfdr.de>; Tue, 25 Aug 2020 02:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgHYAyf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Aug 2020 20:54:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8024 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728352AbgHYAyd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Aug 2020 20:54:33 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P0sGwJ031408;
        Mon, 24 Aug 2020 17:54:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=yVsu0D1kvRRrOrKbGKWqqRmUhcBGwvbkNoqpFULAnFk=;
 b=o+AIoN/pQrbf+PrO9n72/oZ/dsBYrIkpq3fiQON+a4QkV/nQ6pFG6pDc77xEoByLYll6
 4OLn+EVqCNdiuLMmeE+dSlSF2qCAPXTaQZ1EksqrWbU1Kk1nzUlwY4tBtb/G4OgsVI5N
 5digEAmzOKWVUa0+KsK+8MVQmPqSeRCwMuE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 333kmmyys5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Aug 2020 17:54:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 24 Aug 2020 17:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS32WxbRhZWAph6DcKYgJ2HU0JGcbLqM6xrERzh/qcJ+GMehRbwlUuufkll3Tr3OsLFIfCAkNGdNkv+9QCQYzZeuWSs1vPKClYTkVpqTxJONMf3I8wHtWHwcL3lEhv5DZOrRA1DnSvruDeOc7yFx5vQK2jRTF8eG8A3Uv6GOUtpJYScKdckXujkGGjIcgGiNLLme4q1brf4q0W3/C/xKk+1CLQ03J4pX9IuyyE3E3MCoRYB4lE/EudXEPJw0vkcz5PGm9RQYGNFspmj09VUeoTzjZCkPeAolZeMDrRW8hkUfxEeyqzEu0H9dve3AtxuJX5lHhp9ZbnXxi8dpnGO/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVsu0D1kvRRrOrKbGKWqqRmUhcBGwvbkNoqpFULAnFk=;
 b=Hg9NVGel3FuHZvS/IAjAnr88P5+OuxORvwioBDx9oEMNElSoFJTNzXj9+j5luEUhs3VQRh6cK+fFDoZPp4osclKNSkdO7Bz1pMNthNXtXoxftXI4KW4x7LN18i6HOp3o5AC1Y9f9l25owwc5cCqUxbtQ/jz6RShlt7BxZlEMj/Z0K+v9UG2QnGPTyexKj+UXQLm3EaIH9kdJ+xLD0MuE5iZcVr59JZuQ5TXBlsw1bJqh1kL9sP1av93kKOb23bdZNzn9wENa1NuGvblnGdHHpJWwln5u/JbQPioC22DoOKJOWuwcgdazugMYty0ggm6jPL2vQlqbT3lHifyz/hUyxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVsu0D1kvRRrOrKbGKWqqRmUhcBGwvbkNoqpFULAnFk=;
 b=PE6u8S2femgAaS2P8PJp+RX/r7UnEok/tE/LQkQQaLXaIe34Fqzpu5wxoqZuCjDv9JwIUWgFkWqCyinNUKIKRW1kza3KcgK++Yo/HLaXBIStwxU7H6ZwU1vQuwTXJ0xFOGOGqotpa9JfKiYuTI5T1wTzVXhH1P1ULkjAVuw9qgs=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3207.namprd15.prod.outlook.com (2603:10b6:a03:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 00:53:52 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 00:53:52 +0000
Date:   Mon, 24 Aug 2020 17:53:47 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v9 3/7] bpf: Generalize bpf_sk_storage
Message-ID: <20200825005347.6bslsr3jfayuce5q@kafai-mbp.dhcp.thefacebook.com>
References: <20200823165612.404892-1-kpsingh@chromium.org>
 <20200823165612.404892-4-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200823165612.404892-4-kpsingh@chromium.org>
X-ClientProxiedBy: BYAPR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:40::27) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BYAPR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:40::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 00:53:52 +0000
X-Originating-IP: [2620:10d:c090:400::5:87f3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2ae8a9c-86ce-4ff7-1538-08d8489155f8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3207:
X-Microsoft-Antispam-PRVS: <BYAPR15MB320771A3547B05FB25698670D5570@BYAPR15MB3207.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHH+GojeCOTzcJI4sffJjc+QIbXhFQ5brmLX1rEy3d/KDFNuqp0vuncTV9oY19HkiDSDyuqhbo52zKST+gEFwQC7m+w5BnSeuQovOU1cFpPdygPMq7ClJGVzJVcPQ+0mOrO6qd8TA657mAL613cV5xnwrfSw7MqDo5r5DlnJj91UeERbkLvE8GV4uzf/bfCLklg05v/6UaiWvat2QD+QWmrVO37h+nlsZYwdAY2FClPXKUUjDg7NpUXdoNgo0o5eTvp1NIjYIE/ZMDpqCAmn5BH5eYJH7E9jkEEBVwPwtnxlz8cTkPq8v26SPNm7/spS92PJh0ufVslZ2lFzhbL5ICIN2XrxR6HDrkGOfFxAIvKCMr470VMdpX0SRJRCIgLfNfh3znaMY0Tiiv1F7NHU6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(346002)(366004)(376002)(6486002)(186003)(5660300002)(6916009)(52116002)(956004)(86362001)(4326008)(66946007)(16576012)(66556008)(9686003)(6666004)(966005)(8676002)(316002)(8936002)(2906002)(66476007)(54906003)(1076003)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: atADlOajkXJsmH9wodxpiP+couu7i+7wzWtRp7xLXVb7EXhA3FPCujyRH25JnZD9Bcj9dMXOGru7x4Ftr+UHmjuC5Hpif4TDzdFvy/BoEmKYobLLOeUmNottCCcz589x/b3lTtYJuD7VX2xq3aMIDlGbgTGrRK1wKLkbvcsuKSQPq84EXrFiXfB1GvrfDX4B2uvPbC28CXFtc7dTfzRWkb9tg+92Dl3DnJ3COlda5K0SNLKX1dmGdOIzeyX4n34uwdDCaXrGFisUeY0SSLTWL/EBRoujxOtxENAQD77oinW6iJog3NTwW05N3TxkhL9nLIqLwfeQED2nUVxxWNfMvW86WUcZnoP2bPAa4+6btAdCI+avYGNnyHNQf/5CS/U/DoCRZYJwmNOQOgQhtM2+HfiRSE6/rrEOFCXIJX1WBZeuZC3ELI/FkFjVQCTQrbsfHK3lDC5XmlZamn+1qur2LAoU8C4DbAVBNP9MYy5km9s+4vq0BTTESwUPVYreJZPeoH94EApw1iTB6EwqD7xZzXi05zVYhBU/Nq2ZO2/0GsU3M/6//fmH1SV/sI2LjxdKTyygMO82q7bzCLXDfiloGV+x1ARIsnYxu8uoVQRDCz7se3dMqd73VDZVpVM80xU5jX4Eu0p5C2VzsodefBvApGjIU1eVgO08OVzTH6X4QoM=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ae8a9c-86ce-4ff7-1538-08d8489155f8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 00:53:52.4643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ecm9XGoR1UblTgbE/WZ2/wDTfk/m8G+EARJjGtVwe6pCvDbQ9D4StsLz+L9Iy8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3207
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=821 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250005
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 23, 2020 at 06:56:08PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Refactor the functionality in bpf_sk_storage.c so that concept of
> storage linked to kernel objects can be extended to other objects like
> inode, task_struct etc.
> 
> Each new local storage will still be a separate map and provide its own
> set of helpers. This allows for future object specific extensions and
> still share a lot of the underlying implementation.
> 
> This includes the changes suggested by Martin in:
> 
>   https://lore.kernel.org/bpf/20200725013047.4006241-1-kafai@fb.com/
> 
> adding new map operations to support bpf_local_storage maps:
> 
> * storages for different kernel objects to optionally have different
>   memory charging strategy (map_local_storage_charge,
>   map_local_storage_uncharge)
> * Functionality to extract the storage pointer from a pointer to the
>   owning object (map_owner_storage_ptr)
> 
> Co-developed-by: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
Signed-off-by: Martin KaFai Lau <kafai@fb.com>
