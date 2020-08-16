Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E304245630
	for <lists+bpf@lfdr.de>; Sun, 16 Aug 2020 08:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgHPGC7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 16 Aug 2020 02:02:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59080 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728572AbgHPGC7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 16 Aug 2020 02:02:59 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07G5x3NM000474;
        Sat, 15 Aug 2020 23:02:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=M9uneBLezLRyiHgvAKU++Q2Ljdn+OwMmT1MUfuYA6mk=;
 b=F6ypTmo35RlxQeXcOdOY3Kz+s2PPQg+EZ06B4+/5VTXlr/pcR5/Acbp9rSvCO+SRVXzQ
 o+PBLu9Ql6oR5tTBnJRyB0xltX9GKzeg4MQCsXWn1occUN1WFuuGo+pErFK9s987I+Gs
 35njkC3pccdmPzgiR+jxMO+YGQjH1sciUsw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32xcthjra6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 15 Aug 2020 23:02:44 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 15 Aug 2020 23:02:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF2Li5VXNmNWp8EBeUVwRQfRLVD3wSUXDKAfA3EPJdiY2RE+EOfT972I2J3we52/r9LYLNvQa4yVHNylqnCn3N5tJzLqsRzPxOru1ljiEpwI/EvIxOf8aRWvPD1nx8GCLV98iNYxB1gzBU1txKbl8YlGsbxX3nlTjgiDBKNefGvQcQAHwPYO5sDVqYo0VacIorj3DvUB86Gif5H4xOs4CPwEmMwv3hX09EUjz6HCvupcNbWKq8tH53etapyAxJUQMfxv7jzXYc18pRjiLKVnuMdVX9jRyso9oFkPgN1Bz1QMrdjM/vUFY1H4fAxGmPIXdUve9Tk0vx4oTvod17Mr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9uneBLezLRyiHgvAKU++Q2Ljdn+OwMmT1MUfuYA6mk=;
 b=JjdRq1ppxqmEjVezlGKFIlW3ScyjAqK7IHI6wKDSl57YZodRcRcKcEIWLIjyJGsBfbGJ1iC17DaTFjdp+56MZucLfou96vDX0qxpfKuKE1r9QTlWu4aoug8WzxNO8vefyaxAawiyrWYjMvI3JUvweJtZtObNw9AxaWOMGbz/UaZjG4XSmH9YvUwa4X5vbowizVEvIzLJQu/8JJrIeo8DF4Q8CmpicIXPFSrKMDNj4F1FRcCrvPn+i+bYiPfpSS226zU5kfC3lDfu8F764mTSdoQ87lsHGkR40GM8b+h2JAf+d7ta/T6SkSVTNmm2HicKyY880GosHnDawWZz0zxZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9uneBLezLRyiHgvAKU++Q2Ljdn+OwMmT1MUfuYA6mk=;
 b=jEfrOmO5+eLRKtUJZWwwPGYilBHozMxpY6jO+GursudJyfr62EXxG4nGq7ReEwokbcuzpl/TKs5WBcPekqW3cm5JSXsAeHaA99T1t0ftiVVWtZ6Karvm3AEqWK7+wfIM9GEmsyfQwTW0QmoTQg4ANJcQgep2V+JdS5Xu7HJ6OVI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2328.namprd15.prod.outlook.com (2603:10b6:a02:8b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Sun, 16 Aug
 2020 06:02:28 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3283.027; Sun, 16 Aug 2020
 06:02:28 +0000
Subject: Re: [PATCH] samples/bpf: Support both enter and exit kprobes in
 helper
To:     Lior Ribak <liorribak@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
CC:     <bpf@vger.kernel.org>
References: <20200815195726.305131-1-liorribak@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <99122200-5308-25c0-cc4f-145847ef7edb@fb.com>
Date:   Sat, 15 Aug 2020 23:02:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <20200815195726.305131-1-liorribak@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:91::25) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d9::1056] (2620:10d:c091:480::1:df42) by BL0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:91::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.16 via Frontend Transport; Sun, 16 Aug 2020 06:02:25 +0000
X-Originating-IP: [2620:10d:c091:480::1:df42]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5263ff95-c57c-4079-0668-08d841a9f45b
X-MS-TrafficTypeDiagnostic: BYAPR15MB2328:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB232803DDA7145A59E826C5BED35E0@BYAPR15MB2328.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kv2jdBDsTrWxW/5XMR56Ho6L4iF62CSjV9AvUtXvnkjWkKt+OK8gGc/5nBMpId3FoL7aE9nKjqyAW7eGlL07Nc2FFRJ0xVfXtoNI0fQELAm7N1s+cJNlDZJ1jswJTgImBqm+DcqDj4D3aR+ypIvRzxGjOZN5FxkDDHnlrc2mnzc3Mnk5Tntys4kfJ1JW+DVe6ZOH4s/P9nQ/h6b3UHbwqPn+s79D0UgBaBbiPp3ukt89dXINPdJd7JznS4gHF7QGArbjBhdSHedlWyVg+kvNfkKvrycHnVNfX42o2V702NQCAak0sh3hLBh89IjMWGEzJmqXvz5i+NjJQqqnfElNRVE/HbLOpQhXOhkVo72uGVWwAMCHuFBqKHSuYSu/xgwq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(31686004)(2906002)(110136005)(316002)(66946007)(478600001)(8676002)(52116002)(6486002)(8936002)(66556008)(66476007)(5660300002)(36756003)(31696002)(86362001)(2616005)(4326008)(53546011)(83380400001)(186003)(16526019)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: AG5I3QDnBFnSrhZpXkaCmVQVymZUDmzARJboejiAWrMRVpElT1ZQakvyB2LFl2VzxMrLvbJUT4k+R2/n43b/co8+1dSTp/ZLXsZ+pvDJc0dEXagbX+1252pyedzVv3RUY99rO/a1ObbUDA2j3Dh963eqPe3ZuAbH3+QdalikO87bYXZ/FClfsTOzTJ4SLkuXpYC6cdobwMy1SVuGAlhrAc0CNIbtruqezWlRoWRwZ3814EcWH/QUPZ9TqfaMG66jmxmTvtsvqmSxcS7kFwFOSU47SKRjnlJ+m8x+CBiAkuBxSQOthD2bkW5GQsLzWxNd1+o4EJcYWjFnzjm57xSexQZlIwRa7cbFVphqoSubaXBiVDLPQ1xZ/sDOyT9BtqBvGNPrTQj/MM8UOSKSTL/tQvZUl75lQe6X6G2xKUOZhX1rbvBUtd4Tm2O3CMk5zHEIJT3znE8cTqJKhcHQ3C3UQImj/OgEnZLW1DwCUaqJXcy0oI66QAmbamH3xoANeqSH6Mg36jSY9+xgNeLFltgkHrSnJiuU4D/eahVDfL1P2TOVIEzMIi8Kj41SYWDFT8jhbZqGcPxTO5ejc+f+mn2nOTWarSLalwQO2qj91yRqbIphUiWd4nys1kLIvqgV58nxqZP/rhs2Kg9of+HLDTF+Ij8zqHGbeRG/xSzb+rwPdm5I8SkcT2dnWpKMhBXAY33+
X-MS-Exchange-CrossTenant-Network-Message-Id: 5263ff95-c57c-4079-0668-08d841a9f45b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2020 06:02:27.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHFbarUuvqeiXfoT4+t0ESyTiVkGQ8jQ9dK5NXE4sDPF4vVLUBh8TXJ5l2X8Pq0M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2328
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-16_01:2020-08-14,2020-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008160051
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/15/20 12:57 PM, Lior Ribak wrote:
> Currently, in bpf_load.c, the function write_kprobe_events sets
> the function name to probe as the probe name.
> Even though it's valid to set one kprobe on enter and another on exit,
> bpf_load.c won't handle it, and will return an error 'File exists'.
> 
> Add a prefix to the event name to indicate if it's on enter or exit,
> so both an enter and an exit kprobes can be attached.

Only bpf_load.c change and no users here. So do you imply that
use use this piece code in your own environment some how? But in
that case, not sure whether this patch is necessary or not.

The change here is for legacy bpf_load which may go away in the future.
I understand this is for debugfs based kprobe_events where current
libbpf does not support. But if possible, you should upgrade to use
fd-based kprobe which is introduced roughly in/around 4.17 and libbpf 
has proper support.

> 
> Signed-off-by: Lior Ribak <liorribak@gmail.com>
> ---
>   samples/bpf/bpf_load.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
> index c5ad528f046e..69102358e91a 100644
> --- a/samples/bpf/bpf_load.c
> +++ b/samples/bpf/bpf_load.c
> @@ -184,18 +184,24 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
>   
>   #ifdef __x86_64__
>   		if (strncmp(event, "sys_", 4) == 0) {
> -			snprintf(buf, sizeof(buf), "%c:__x64_%s __x64_%s",
> -				is_kprobe ? 'p' : 'r', event, event);
> +			if (is_kprobe)
> +				event_prefix = "__x64_enter_";
> +			else
> +				event_prefix = "__x64_exit_";
> +			snprintf(buf, sizeof(buf), "%c:%s%s __x64_%s",
> +				is_kprobe ? 'p' : 'r', event_prefix, event, event);
>   			err = write_kprobe_events(buf);
> -			if (err >= 0) {
> +			if (err >= 0)
>   				need_normal_check = false;
> -				event_prefix = "__x64_";
> -			}
>   		}
>   #endif
>   		if (need_normal_check) {
> -			snprintf(buf, sizeof(buf), "%c:%s %s",
> -				is_kprobe ? 'p' : 'r', event, event);
> +			if (is_kprobe)
> +				event_prefix = "enter_";
> +			else
> +				event_prefix = "exit_";
> +			snprintf(buf, sizeof(buf), "%c:%s%s %s",
> +				is_kprobe ? 'p' : 'r', event_prefix, event, event);
>   			err = write_kprobe_events(buf);
>   			if (err < 0) {
>   				printf("failed to create kprobe '%s' error '%s'\n",
> 
