Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4F5890D3
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 18:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbiHCQwK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 12:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbiHCQwJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 12:52:09 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986A8AE49
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 09:52:06 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273EcZdl015032;
        Wed, 3 Aug 2022 09:51:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=sW8O4J0jRRs6ueLfXqxDDj5vXVcdj5oeLLI1xMHBqn8=;
 b=ccmK4SefXJ1U4UZaoNM6U5AFHUMe4LYQCackEFfE92+JxWASictgEWFPZj/3FjWycB/R
 mIBbGSTA0GThtfgfvyl66MJTmdD7WCNmSijDPTHX/gT6Fry0YqaIOV9QdriUEb0lZiD5
 mgW2WNloIq4z6UMpl8STVNme6zwMfKZPPfE= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hqty7h343-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 09:51:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSoWmyd/p+4lXvyYd8TzapuH7hexyAsbf7L/K94ueb4GoKj4Iz8pwNQkZOpzdABI7VcUEBnBRpKqKv6qDL8x1OdX1rXLZFiXjr4pXlgzM8rDj09659RH8jmCI/TeHB+00MrkAulzSlkjpuZrx/DoM7WlsWxjQR5LrmSvaEVQAVXnYVIap/Xl7oQTWS43nqU1ncDfcBY0/eHENp3R+yMx1VwKE+D5eJWjXZJUMRqEioUYsylHmZT7nMqJTTP/GSsnwPxhjbjiK6jCuyUW8Czd9tS1FWwcMBm+lr7SxHmIgfmZmDDtHDOWPpe7BTTQqzHyM9bJshfqKFpOMXJ5nj6y2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sW8O4J0jRRs6ueLfXqxDDj5vXVcdj5oeLLI1xMHBqn8=;
 b=MC6A/g1EVSvMs0+BoiFnxVbvLLbgKB3afcpNhVeedDcZHQTMZBqwpP25UxwLvXysCCl9oJDOYd91U5HB7CN7A8WPoCY+1fqr78xAb7Ygu+2vAuEJ28pbhHcgeaHhSqC6Ak3xHK2FPfumsiyJzAG4oWcpUPQfa9fXZyyEl6AI0OjfKyqktE3ua4U3tit1yzEypenZtalFRDsbf3Y2VKIomYkDiq8VaQ1e6yrUHSzwsmk9H/Bajcg1PNz4RQf1cMWRQ6WcTDh4dPQBD6E6NfIzQBKwKjrNyXqeWpR85qPAeoEugE8IomZ3okyN/fUGqJYrSnbPXTx0j99Uz2uGhuP/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM6PR15MB2651.namprd15.prod.outlook.com (2603:10b6:5:1a3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 16:51:44 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 16:51:44 +0000
Date:   Wed, 3 Aug 2022 09:51:42 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Excercise
 bpf_obj_get_info_by_fd for bpf2bpf
Message-ID: <20220803165142.jp7xesq4ejxhwtl7@kafai-mbp.dhcp.thefacebook.com>
References: <20220803163223.3747004-1-sdf@google.com>
 <20220803163223.3747004-2-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803163223.3747004-2-sdf@google.com>
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8709a631-0aaf-4ab6-10aa-08da7570723e
X-MS-TrafficTypeDiagnostic: DM6PR15MB2651:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzZzC91fFQkBzajf4JX9n4f6qeYdM18EHxiWxvVxyi1ielsJod0WkacF9idhXLnEB95KEY4qn+hJ92N6ijr/WJhhcixjgSq6wxm6WRbebFEbGwpIDvC5hPSbljhHNDWyhOQLdrgjjUTkQPRm1XQQuqMku85tm+yiPbo0wdGXRm9svKI9EA6SS1MaE1q+3FPc5t6iT6aiQai11MZ2YmHxUKHlD5ysbbI5IRy1qbvurstVTBxSTk73Ix3Pzqnjm6o5ZF68YzDRQNIqAlDmOND3f1pOAM0fhJbmLrKH/Y4BsnKCQ4XBJulYeq9mOkj8ZUJjHhd/YmdvqyTqOp03FtqMO7g1FxEBfgNkiox2oLZdQLZUwAIKLBYAtiu4dXwbDNWNkLIenRwxMdeOjytJRLYzSX/gk6vToVPbzh0Z412aWqMtTHwHlHWtJg3FX2KI4vtLaiybjmVnoSfGdXMMLQMfs7NgTPJ50H4tZaVmhZwcUPUJT7f6eW1wwAvvujG/G985HAi0e4rmtFkupAYuoOhy6cgcjBj5KWGu+eaX4MqEoEUdiDdLhvu613NqS3U3uJ7rBa+bcyC+s5hMurCIFsrQI53AybcrV+fYkV3o5mbAOSRVq9aC4mIDjniep3O8eKZgjQyM7/qlaf00a/rSaEYMXLqjPIZy/AhkWmyRO1UmyDXVBeKuva4m02ajwb6kT7WOmxWBe7ZADi9SsyJiKZCvHvnisOcqYWY0ZRGG+I5yrQKSMPUp+8YChshOUIpQyA/T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(38100700002)(1076003)(4326008)(8676002)(186003)(66556008)(66476007)(6916009)(316002)(86362001)(66946007)(9686003)(6506007)(6512007)(52116002)(6486002)(5660300002)(478600001)(2906002)(7416002)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2sk1kG2ILNzmjtQo+WzzaldbtHQoAm7ONJ41aPGkjjuRMLXd6BRS16VXu45I?=
 =?us-ascii?Q?Z2XKaJT7+lTfm2qFIRZMGT+JgqdG8/rLxs619nP2z7SQH/F6Lin/W0+Bzo5+?=
 =?us-ascii?Q?P/uQYKzhXx4gTqVD5epJJSxLHnySlrv3VdNTPn8aa50ldBNY85mxyHJ+R9WP?=
 =?us-ascii?Q?x/C3oojOlLJHO7vcFdlQegTPPTG5rF84UOYDV3OjpL2SEEMyWfnkMXn0YzZE?=
 =?us-ascii?Q?+ytWyA+dzRml9e6WR+/SMds2mcniDLrYIkZjoYnl10xXT3mWRUVGZEbdnXrJ?=
 =?us-ascii?Q?7HlamoUBYGT2Xf7Iu2hOPQbmYhXVRu6YhV0qNfETIUCq73BarHhHn0dIqmVO?=
 =?us-ascii?Q?2ECY9b+JEiDdrIFIrtTbwy9C6cP0/4JGC6x1lFtFyJBASC45P+CdC3wR762h?=
 =?us-ascii?Q?rTwC9vu8jHA76+0Q/obQ9uKkGYVKdRuW8XdsrEd+SKF9PXGNoc2ObayzX34f?=
 =?us-ascii?Q?2YwUyB1iPjnpVQiHVriZ91Hna00ImXhs8/4L9I5k7zHuuBJSPhv1bH5LDtJZ?=
 =?us-ascii?Q?8lUvplVOZZn5KePVuSqQySN2emJSN7gEw/H/uA2hznJ9beXwrhfKMinuIBLV?=
 =?us-ascii?Q?LdqusAkmRleHRI95T1x8w5/lUY7W+x941/x3bEu42b/xKjiySPJhv1hC4HiT?=
 =?us-ascii?Q?Jz0QYBLZWsX4WF9QYsu3YWpdkacjyIwqwLwkgFMYXKDNkZA6g8gRIEgtGBwp?=
 =?us-ascii?Q?NnIihZjfiU+9z48zEr25BNQbW0tYOZcT/boJCbUQLR4z/Qfb1P2RSfOgQlXG?=
 =?us-ascii?Q?uRnpvFOsSqt5CDu/UPlu6IklixSwsXQ8veswczBpvQcL13qkY6trjosF8B0O?=
 =?us-ascii?Q?ROGmmgp73uWnBl9CEq5lE+Vxvq8/slBfUR2KGx5whDbuKIxKjIqcMKsq6Qbx?=
 =?us-ascii?Q?/4GO5Md1J56XVvmNlC7fQtsqvYK0//R/kh+/P+X/queojxmtZBfW6TAs4dAh?=
 =?us-ascii?Q?Wvc8PS9/HLcPtUrziCvJllFf73tECQBuPwIas+xZjF5QiSeIf9SSX14CY2/I?=
 =?us-ascii?Q?El/aRNkzpQvW4pWB+B7kmY7lpAI35bH66CZdQCQMSPc4iTJjvxzoOzWKmIUs?=
 =?us-ascii?Q?DxhiisoLpZjyFNSNBpgRjsEaMr8pIOIGMZwQQ75M2WPftxDK6xSsubcA3cnQ?=
 =?us-ascii?Q?PBH5sUbHs6MwErUyED/FfPi+oqOOSwXiswiYIVfPhSeszIkMaLMNPyMcRb3n?=
 =?us-ascii?Q?dgQV8MPEOyKYoIxfu9CcNVku6msTF1PT4zgoSjhBne7AaYbu8FdRSkjpcrkW?=
 =?us-ascii?Q?sDDriQyTF5P0McOiOQi6WDKeQhR/EYpM21zYOrmAQglMyVS6GwtmVP+UBK1i?=
 =?us-ascii?Q?YZS/FkTd2MWAO/v+F5lFVXB+8odllYIEM3d1YdBKjWN6Vp/uWYLZstLheIUE?=
 =?us-ascii?Q?gL/FueKE83EyCQk8SzTODJ0fkAQNXDK6Fo++fwKH2sxryRorN4OIboh2EbVY?=
 =?us-ascii?Q?XA2OpcDjXFF1cqJUyml+h/f2Ma2Nj70ZCMf2/wX70OQHQWXP1h6vft0mEads?=
 =?us-ascii?Q?UbGe2EqfbmKHDjtXlNv6OePEGyCjBc94F2qdrF97a9sinLxB/vEkN1eIYFi5?=
 =?us-ascii?Q?/ZOIPhv0/bue+186jAWRy+VEPx3oK0Bs8QBt6iJrMTrDlNVVmArnD9XgFuaq?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8709a631-0aaf-4ab6-10aa-08da7570723e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 16:51:44.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQFMJdV2mVmTC3zVlBjfxjj0DSxrLiguFKKQ+cbXq6YuCn/9VKYATbMYe5O6TkHH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2651
X-Proofpoint-ORIG-GUID: Z5-CqSa__T_0Zidg0TtEe1vN8GY1mTlX
X-Proofpoint-GUID: Z5-CqSa__T_0Zidg0TtEe1vN8GY1mTlX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_04,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 03, 2022 at 09:32:23AM -0700, Stanislav Fomichev wrote:
> +static void test_fentry_to_cgroup_bpf(void)
> +{
> +	struct bind4_prog *skel = NULL;
> +	struct bpf_prog_info info = {};
> +	__u32 info_len = sizeof(info);
> +	int cgroup_fd = -1;
> +	int fentry_fd = -1;
> +	int btf_id;
> +
> +	cgroup_fd = test__join_cgroup("/fentry_to_cgroup_bpf");
> +	if (!ASSERT_GE(cgroup_fd, 0, "cgroup_fd"))
> +		return;
> +
> +	skel = bind4_prog__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel"))
> +		goto cleanup;
> +
> +	skel->links.bind_v4_prog = bpf_program__attach_cgroup(skel->progs.bind_v4_prog, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.bind_v4_prog, "bpf_program__attach_cgroup"))
> +		goto cleanup;
> +
> +	btf_id = find_prog_btf_id("bind_v4_prog", bpf_program__fd(skel->progs.bind_v4_prog));
> +	if (!ASSERT_GE(btf_id, 0, "find_prog_btf_id"))
> +		goto cleanup;
> +
> +	fentry_fd = load_fentry(bpf_program__fd(skel->progs.bind_v4_prog), btf_id);
> +	if (!ASSERT_GE(fentry_fd, 0, "load_fentry"))
> +		goto cleanup;
> +
> +	/* Make sure bpf_obj_get_info_by_fd works correctly when attaching
> +	 * to another BPF program.
> +	 */
> +
> +	ASSERT_OK(bpf_obj_get_info_by_fd(fentry_fd, &info, &info_len),
> +		  "bpf_obj_get_info_by_fd");
> +
> +	ASSERT_EQ(info.btf_id, 0, "info.btf_id");
> +	ASSERT_GT(info.attach_btf_id, 0, "info.attach_btf_id");
> +	ASSERT_GT(info.attach_btf_obj_id, 0, "info.attach_btf_obj_id");
nit. This can check against btf_id.

Overall lgtm. Thanks.

Acked-by: Martin KaFai Lau <kafai@fb.com>
