Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82701D3EE2
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 22:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgENUSm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 16:18:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgENUSl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 16:18:41 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 04EK8fdj000799;
        Thu, 14 May 2020 13:18:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=C7qizvmOnxjeI83KE2JOQfmSTqgYblF+zDJ/WBrWf9w=;
 b=mwIfqw95+urvi1/32KgNaSu+cUig+D/Tyd4iGP0U8gZeMH3VBK2FCMucIl5PLX5MVqvv
 KLlJLiji7qFJcgF3i3Oky2/Quo4OBbJWujCOAAS9YdxO5Ti+FRuJZUuD5Tckba2xMPc3
 y8Fw6mpA9B9corI1WFmR5+XnIbm8DQ4AHXw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 310kwt02bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 13:18:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 13:18:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aV8NnoDrclkZN831kQ2N8NaTa5DUqQEGFQCYSKuVAg7PGH+1/ARAkwgwiW3bzf3TtehQ2TwitTM7+fF0UzDSn1oM5GY/RQQE/6jswY+ITnd3qZ35P2YPXA+gwMX0yGkaR5l1UIayiZd9jtdO9HfpmoS//xdKN7ZOG+p/hqhLKymr23HFzqkzohBEfxSBYd2KBY9FO6fCB5/0uPGAs5136MEgtIM/yzaBH5qjzChkr/hClf914/C6cmnUQSHOyYFkp9YaYG4sa6F1ESsmVLKvji/n5fq/qE7TsYkcD6Z/abGZcg7BM0+qd5ok4DOf7L9RmZnEZsvfhe3asjb7NRl77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7qizvmOnxjeI83KE2JOQfmSTqgYblF+zDJ/WBrWf9w=;
 b=GOOWhHzkTp4bmV1ZJ/GjQ9pFUgH1HNH+bTrwLk9W3AFHgtkh+VhWNQy3v1azjIc8rvmYXC5vpNndjtLDMUtx1Yy+sEtd6Brs18vNpmEGLnd/den1McjT2+6bXiN5OgzlvyZbn1BYMSPSD7dD4mQz3VR0ABVNi/9GUtQRUPFBXkE7BEY3vzUqfOPkAr8dVczKL57aduo9ecgk9eAFu7BjwPwnIVwUMp9BxQTabCQhfIto6hD+LylKYwlkIYraCaNF69emQrsJLNuBfPtGxNFEwkqKTyzJpiFFujlUWK1xE+yYzYRN9YBD70864E8Uwy/chbzsGm0CWQDevqKcncskOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7qizvmOnxjeI83KE2JOQfmSTqgYblF+zDJ/WBrWf9w=;
 b=U9YL+yaag/+5JVv9TVTv1T83vzyN7u3jePazgK3yxMMmGjC/VKTTpt8xJ3vuD41COTB/ZXEywvRIbZZjtGEUyNd0dVrCrPtSko96kfX8WdW9/qkwzN3JVwmGWFiRCJJU+zS4NuieTguoAhvIt76pX03UfrRqz+EwaNNQfKp8f5A=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3253.namprd15.prod.outlook.com (2603:10b6:a03:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 14 May
 2020 20:18:23 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:18:23 +0000
Subject: Re: [PATCH v3 bpf-next 5/5] selftests/bpf: Test for sk helpers in
 cgroup skb
To:     Andrey Ignatov <rdna@fb.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <cover.1589486450.git.rdna@fb.com>
 <171f4c5d75e8ff4fe1c4e8c1c12288b5240a4549.1589486450.git.rdna@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <9f376112-9d0d-cc77-437f-0357223c0f2e@fb.com>
Date:   Thu, 14 May 2020 13:18:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
In-Reply-To: <171f4c5d75e8ff4fe1c4e8c1c12288b5240a4549.1589486450.git.rdna@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rsylvan-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:c94f) by BY5PR20CA0014.namprd20.prod.outlook.com (2603:10b6:a03:1f4::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Thu, 14 May 2020 20:18:22 +0000
X-Originating-IP: [2620:10d:c090:400::5:c94f]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d26ae1b-e324-473f-7c06-08d7f843f3ab
X-MS-TrafficTypeDiagnostic: BYAPR15MB3253:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB325399EAE3D48B9224E27042D3BC0@BYAPR15MB3253.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+c89UMp1AdbW41Bh7JzEAlShl4bz4F7Ssa5crtfn02DWfgDCu0CA2VPVyDPIDDzkaJ6MlQiTouH9vx2Pus7e9FJiE1b01/eqTMvkJ1l3of9GOY5kV20rRYv0LBM+Le5THxqNSpyl9ToncJGFbvUDLaP1VKJtXtS+3wAvkRlDgpbKr2Md+wUbIJLhMHNDpdrr6v+MGuJ5jtO/LS9BqDnMLHq3HD6+yAbBdBduupoOAgRWGAfzOvw+HZo3zctRFjkrnZZjF/UrpnVmQzlyU2Pr2BT1RFJCuJ3t05ZeKOT1j9ok4qPpxDC6drOF5QLOpqE+nq7+FEexFn5XhKUjCghEfg9C1Gsjff+m7rA7fETTV/vfpjiGolKhcHYZovqWsGJxyfgK56XwItUqhtNJrU28Flwe0qaeX8aUj3wYefj1zvqMB9RJlXDiInTyOAMqbZZlihnE6esXwbpqKz8QEVv2opwK/+NpDLEUSyF9qBwxoQNEH895eca80tcOfoMKded
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(366004)(346002)(136003)(376002)(2616005)(16526019)(66946007)(6506007)(5660300002)(6486002)(53546011)(6512007)(478600001)(66476007)(86362001)(4326008)(31696002)(186003)(66556008)(52116002)(8936002)(31686004)(36756003)(8676002)(2906002)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: opbO8KqI5tjdJyXtLMQEH3gfmehQLcFyv9J9jvGPwDjJyAkHzELtu1krDixS6AngkUVNn3GxM/nC+oq8nWVc0tkSYTbKtj/nJ8HSpFqZtriUR88FCaqLcZmUuPgfX3wQ6WeapMOZqy8D+CvkjQvZ0fhfHcOXxziSd6vFAtGtPhKi38Dqu61hb26jwx8BQspCcLW4h7dUFH4HAQfyVByoTMm3EPA8aMFjOpU+FjzTMTRWDUe/g8+WmyMam1G0XfAcgGzl8FAwCrGBPVcsZsED7o8wrWiUSQcj5ae5jF/SxRE+KzYbkqOt9hSYmmgBDQ5ZAw/CCVNaQJDfXNTnVQVsqtGyDUeAp6jRZRlmqsFVkgwinIXRgl39oVW9lXXHBxZKerVFEK97AMhWvTRpB46CMisv9G11Io4PWgXstzbVOuMLxTsNhQSkmxEUAiIr/9LojYpfNN043NCTmJVCeP2fGtvLx7rW3Ck505CSe9ruS8UcRG0PJHCmdd39fESqW7CKUr1llpUXTZrGJlK1yIuEDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d26ae1b-e324-473f-7c06-08d7f843f3ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:18:23.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHqwfl2Y4RgH76n6ubdmQO2ykwhb5WZP+Ix8JGTyM16O4vFJcxJFWbw3S8dMs9oV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3253
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_07:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 cotscore=-2147483648
 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140178
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/14/20 1:03 PM, Andrey Ignatov wrote:
> Test bpf_sk_lookup_tcp, bpf_sk_release, bpf_sk_cgroup_id and
> bpf_sk_ancestor_cgroup_id helpers from cgroup skb program.
> 
> The test creates a testing cgroup, starts a TCPv6 server inside the
> cgroup and creates two client sockets: one inside testing cgroup and one
> outside.
> 
> Then it attaches cgroup skb program to the cgroup that checks all TCP
> segments coming to the server and allows only those coming from the
> cgroup of the server. If a segment comes from a peer outside of the
> cgroup, it'll be dropped.
> 
> Finally the test checks that client from inside testing cgroup can
> successfully connect to the server, but client outside the cgroup fails
> to connect by timeout.
> 
> The main goal of the test is to check newly introduced
> bpf_sk_{,ancestor_}cgroup_id helpers.
> 
> It also checks a couple of socket lookup helpers (tcp & release), but
> lookup helpers were introduced much earlier and covered by other tests.
> Here it's mostly checked that they can be called from cgroup skb.
> 
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

LGTM. Thanks!
Acked-by: Yonghong Song <yhs@fb.com>
