Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819A359A55F
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350364AbiHSSVW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350535AbiHSSVV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 14:21:21 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E18BB93D
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 11:21:20 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JGs5x5024556;
        Fri, 19 Aug 2022 11:21:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=q6+ogDHZtakp6CHYHvJNTvYr6zzLMsQ7esqXig/O9qA=;
 b=lQu9DkkGtBbAlqEzODp6mdUotZTJr3Ysv03/9sQGIdIIsn7BKa5jXDApJ/ZMRNeEwKck
 vCp5+vPVFjl44fCXyy+bna2hpcnxvPUKKra7dey7y/1os09bGgvAG4GHwcoX1e5dmfwD
 TBnkzEMrxFKMl48TqylhWbrcHqzCyY7A0jQ= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j27raca2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 11:21:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ifl/NYqib4KtIuv55Xek7YAPnQL4glG5wpgQy6nyt4TgtpmU1oXfJab/TuVjz4QNh4aJ2WWKdUANmhZESjnn1RUIJtNAQ+1SzI50S5nO8mhNwpwsUCTlkFzzZn684yUoRMflYuI+QaZZ7k528H0/MsW89fqbSrZpesB+02WbFyRsosztu9oVEKe/nUQANqWvjcxArpzfI3NU3DLTmhj6V65vY4IqQVuWtPGsRjx4BEwoKBEHD5s8a5siayUSYuZp5lcjJ6a7lFOa73j2ZS0yUX3qaN38VekqjVwaPzO0LhNhGIhFMToO/f3l5wq80Q9tSf4Jw/0PlIzTMve5n35UwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6+ogDHZtakp6CHYHvJNTvYr6zzLMsQ7esqXig/O9qA=;
 b=gX2sMQMxC4s2NYm9gPBAoH7SxTOvKP/SD8HkxnPCpcZeJn0AXD887aEsKvJh2HA0UVsnzREAXaNWk4qq9uCBSnZzD0v/Rpd2gaE7n+2MyWAFnKwO7KJLzfzYjPXAru7X9IEgnDy4bxgPuxMGUDcO+jN4JDH05FS6sS0IZL2fl8VAtmvpGxRlmQMKf3ZDajuuXZWz7AiSFSAK4X1YAiLhXqcM8fxrsnQUwHUFB9Gzeujnj2sWyFgZraQt0qwORo6nr3qtAUpBGxXrBD/LyCpf8Wejj6iKRDUvGS4h4MC2mV+aOKSRHeltUHA9ZZHFAH5tPAtz6cVkyOHEwNu32m2V3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4515.namprd15.prod.outlook.com (2603:10b6:806:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 18:21:00 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%5]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 18:21:00 +0000
Date:   Fri, 19 Aug 2022 11:20:58 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v3 2/5] bpf: Use
 cgroup_{common,current}_func_proto in more hooks
Message-ID: <20220819182058.v2ynphsj2wwiojmu@kafai-mbp>
References: <20220818232729.2479330-1-sdf@google.com>
 <20220818232729.2479330-3-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818232729.2479330-3-sdf@google.com>
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57cb337a-3241-4bf9-c08b-08da820f915c
X-MS-TrafficTypeDiagnostic: SA1PR15MB4515:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Kvo+CyYUYUYYKiisAeYfjULk5PjsA8UJff33m2DrNH7zudXVfPbp0OobvLRiSgMRT2Fctvm8aOuX2qZX0wR4Hgol9uhY++k56aowWf9gF41UI4q9prZlyvjsK9poho4WomJLhtW4lvOPnvYBBjnnywDkpv1ocjtGL+CKeLcccmNmfQC28trlwkc0wIaoY+qaDSGfWOhUyBnTG9KpuKtxt6nq1YH6c71Ts/lDnY+VRnqDJDxMrwb/AXsMwFCarX2DN8HyuZx9hXW7GzH4d6EuwTJ53lRuYCzbWB7tt8TQrkoZOQq44Dyg+UuhPs/7lRdtWnbzXzNit4fistbcuqFmVQdgmFZUcfcJAF6HIcMFM/1sfUwwoZEwr1V2nAtDD71jPM9GgbIptSrPnsRf2FqehnaVtiapPXqCDp1Tp+ZDLRsBY1cGOeX3TbAyTIrCfyZd142FayahWlUStPqGgdR86XQDLeXAdBRTrVxprghxa9ZIRAW++XdbARF9+pc9NKZZ3bxLS109fyi3TkBC1iE1hE3DVN5AtT9mWivRIfzP6MJVryeabmCGk/8nvulMU63FKmN7MYH9bRMuqkXaO2TU4Wt2NaVJjewb1GMgES19UqeIq7M88UuWOGH/shrkbAUGmfK+P2Icr1RoqjrhDhqO2rsFBAejyribzU5jY0ubHS8S9LjmYX0fGeDl1wYiY9Tcw8ofUmHOnTDXI1eqhuQeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(2906002)(41300700001)(66556008)(66946007)(4326008)(4744005)(66476007)(8676002)(33716001)(478600001)(316002)(6486002)(6916009)(6506007)(6512007)(9686003)(52116002)(86362001)(5660300002)(8936002)(7416002)(38100700002)(1076003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZSQbMWzJgRX02EhkF6tGdDL6ZRcwKJ9pAgJ7WSFub0D5DdHWWS7DN6r6z536?=
 =?us-ascii?Q?4YJMULPEa7OOa3sXy7ohFIjKmh6jTvfDXd5QQ9AFEPUINxjubunT4apn3axk?=
 =?us-ascii?Q?hRmhVMR/f10R3B8ZV95q0UNj1uFEBLN7auwsECBK8W4DC0VUjD8HL7h0Jx/5?=
 =?us-ascii?Q?FPrrweVFEofndUpe7rYz9U/fNgxr49zf7JsMv7ivoOiRtB9sKrCKcKvVTwM/?=
 =?us-ascii?Q?VaTac+HyflIFf1ARlL7jUNG/5WoUE3JULcqnjgbC5Ok/3KrdFtPbwFX4rN2x?=
 =?us-ascii?Q?gFFIFnVzBH6NRRRHblHBfBPT1dFeUUWZRnu6qW9XbCN15ZszO3dS4uTsgVPa?=
 =?us-ascii?Q?VocodM48vrVJSBsHnuZ/2qh4fJwj6BO94o7MkuvdOBHrTYQESiJLc4YDDSTP?=
 =?us-ascii?Q?LHPLjC6fZde/CoJMYwsI6zl24yb/hoLA+KozG6osRU5GIqVlaAKO3hAsP522?=
 =?us-ascii?Q?gfrH6wK/bu9a8WfgVLLk5veo++0LyszmFLSvvYrgZrgQE4WSEgs0dHd2FueU?=
 =?us-ascii?Q?SokWniZbYWNXVIMSvQtLdj1fYiDbrnadbqp29m5s147r/nMhHxg6ThlpHtGz?=
 =?us-ascii?Q?78Kzi+AjR56Wj+/sv7NwY5A72GURxBHYRI7c9wvw6QfvHZNoeDx0Dj9FA134?=
 =?us-ascii?Q?RhGWHYxBGkBqnPVApdSnYjwJ8gxEBnvk5Zw20perXgKn9NFVWOGJkgvP1hJt?=
 =?us-ascii?Q?HRUIIgDui99wr9d6O5RHwoM8ZtKvn5PdMAF29erjIpUTmlJvhVaM3TBgICPE?=
 =?us-ascii?Q?1IZmKts182qJ9DUwFwwPTWc7fbwqdVcD8gFfimQttY6RBuFHhWNyjbf0a28S?=
 =?us-ascii?Q?TRrWKbRNpXe/AnK1nkw/MagQ4Kk1DjYkeXgzM2NFYu+r0XIBO3aQO2plVI10?=
 =?us-ascii?Q?UaxjB6Hop35E4dJbH6FI0rc1Xf2WK1t4iHK/50JHGvt1xVuIIil76a+Hkybd?=
 =?us-ascii?Q?Qcj+WoVLzjiJqnpI8JqRlv8Rtg8S7MgyOe28j9klcy5Wo2ZoID+e5QNPFGsx?=
 =?us-ascii?Q?ziFtJ+y1tgdaHieBvmnEacn4LCpS3Gr9ogbGkd2p5reWj75d6ZI/8auEIvTw?=
 =?us-ascii?Q?ktOtKZ+xZ6AMI8aZuTG77y5YJ2owlInaey5UBhOIAZEjGJMHY80gmtXrHLXL?=
 =?us-ascii?Q?vbPsrTc9vEMSHV6JsKS9JuJCx28dptA3rdqUogz8qWuHg8Zia0+rdO2TyZNG?=
 =?us-ascii?Q?S2X9/W6o99VfU3ij0n+jbU6NLy++yvrROJcFjFbjkLND7HFTaEXzj+4CEh9f?=
 =?us-ascii?Q?JHx6DoHBl5HJm04FG+cLFvhnTNjIRoaL9/2OysMQmZwMaFwbiUhJ79MgrIyd?=
 =?us-ascii?Q?GoLdH1pZngeJSe3/h7MhURfMUZ2WzDFK0PnXaehQYdxX/qlEiCbUgYlLPu3M?=
 =?us-ascii?Q?JSPD5YXnJiuhTWgN9zkHIxoj1Lba/m6Z1qsC+80mhZqPKnlHIu7tdlSQ+8dM?=
 =?us-ascii?Q?W5u8MvdUsM5gl9EQwPqcVk8rb87aQODy0+V1KVp3i7zmAdBlhEMMESNMCQzh?=
 =?us-ascii?Q?SZq1i8ATijyQ5tCrcDYrwaqyM2Kt6Bjm9Uoy896T65FtRsUtceuAcahhwtBo?=
 =?us-ascii?Q?AFrTW0DOVbqwYydBQmwCtyHjKxnnNHWk4Nn8nvm7x1+iGF46p1ePaAeFh2XQ?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cb337a-3241-4bf9-c08b-08da820f915c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 18:21:00.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRp+bMsi47CkNPXcG2quFnL01APKq3WUFyez2yrQceodB3IwFKQWBQ22jvo5nY+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4515
X-Proofpoint-ORIG-GUID: wG4FF44HSaRRw7QBuwPBDEnb0_m_N9KY
X-Proofpoint-GUID: wG4FF44HSaRRw7QBuwPBDEnb0_m_N9KY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 04:27:26PM -0700, Stanislav Fomichev wrote:
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index fa71d58b7ded..6eba60248e20 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -189,6 +189,16 @@ static const struct bpf_func_proto bpf_get_attach_cookie_proto = {
>  static const struct bpf_func_proto *
>  bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> +#ifdef CONFIG_CGROUP_BPF
This probably is not needed.  Others lgtm.

> +	const struct bpf_func_proto *func_proto;
> +
> +	if (prog->expected_attach_type == BPF_LSM_CGROUP) {
> +		func_proto = cgroup_common_func_proto(func_id, prog);
> +		if (func_proto)
> +			return func_proto;
> +	}
> +#endif
