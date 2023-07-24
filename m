Return-Path: <bpf+bounces-5701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0775EA52
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 06:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0366281491
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 04:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1001109;
	Mon, 24 Jul 2023 04:04:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15AEC2
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 04:04:08 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1B8E3
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 21:04:03 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 96C68C151554
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 21:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1690171443; bh=Ayh5yh+3009t4zu12UErgICKkBl0+Eqez6+46FeH8Is=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LEuxdSNOCDq7l6teE9DaWscmGnVZhL+sXy/Yk7npzSa1/+zgn6r7ESlz22jaNr7Te
	 G/h90IJ7rhcycfJsF8XxxOlkLGC+bomrLJkHzM4G6F89zSvwmGalVkSKSW4+SZQxaC
	 u+aW4E6Y+d1erc8JpDmLaW9AEZNY/TKShzwoMIQw=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 85404C15109A;
 Sun, 23 Jul 2023 21:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1690171443; bh=Ayh5yh+3009t4zu12UErgICKkBl0+Eqez6+46FeH8Is=;
 h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=hgCM71IxbMHFk+6CQ+PPcoUkR1t72Dg3D10bd7CkeZEueGuu6L02QBpHUZ42iFC02
 qv3H1h1eqvEd+XwfQMWZcejXX6BVSwpsnzXrT+m4KzPbZla5dnhj5efX/aW/awSeIj
 PJDGyxbXckkZgUGdtvW8Wqd46Cry4U7dDeidA13c=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 9F8F4C15109A
 for <bpf@ietfa.amsl.com>; Sun, 23 Jul 2023 21:04:02 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.096
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MAILING_LIST_MULTI,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=meta.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DZy8uHYGm-95 for <bpf@ietfa.amsl.com>;
 Sun, 23 Jul 2023 21:03:58 -0700 (PDT)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B09E7C151080
 for <bpf@ietf.org>; Sun, 23 Jul 2023 21:03:58 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36NEiQSQ008808; Sun, 23 Jul 2023 21:03:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=qeJdHVh55jK29yVp27NPiF5H5YRrvmVFkHvJtd2n6TM=;
 b=iMuavovuMWnk3E/VglCh878641gFkWKDXwUKphcnZji9nLovy82upE1sk1SiRoJKSJfK
 o+0QjvaHxGoyqHesvcsUudxOfs2CPURB8neADBpJ8Z9GM1Lk19A2zojuV7HiuXLISrFU
 wGKW6Y1CnXOGf7nVVEt1DSjZLgs769ysJuc7fVA0uqUoHsHtnqyJ79g43tYc4lFtz4FY
 VeraT4mscC1Et3omQB/Ej4Vx36Ti3vSgaiJvMk7E+ErjKsMdPNwrUXEFwEuBFJp6vQsp
 7WkbutyFuBza4RUKgd4BumfD65uS5hCzJ3kjtSoLggNI4PKJ5l3NILWRYXZgJHF7K3kw Sw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s0c7yt3na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 23 Jul 2023 21:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glZTcbm/Ctyte+78670S7NPXl7xyxJtOwDaFuKbY/ZVGltd7jLMnX5dZc7FsyPJkotaefL+ht3XvmZ0YZR2a93b+qXpNJ9Mz/fjHgf2YWJHCyVc8GEUa0vx+GsV3h5ZJagh+MU+3L9V35sPC8ajQux6mHXxut84FnUqL0NphbwmqPfpiv7a20t28CVjSu+QjMFG5km9XIG90nU0prtt4ckBVmdBDAXIhMgEwAhg2N1zsLH83iDxvsVVdyvf7oQOppgPmhUExENPcH5IjggjkuLuiQgn0r8mx+NSLsxbhKMP1YsBrSUNaK0YSJ4LHQUOmi1ecH8FM4XRl2tsb0OaQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeJdHVh55jK29yVp27NPiF5H5YRrvmVFkHvJtd2n6TM=;
 b=KmlBTSCw8QevpnL+MiqimH8eV9hFgm+YTgLvVNVd7QTCcUFnQc+pvkvJTaNN70QTLJ2L7i9uOe3gB9fGdQdI4YQEWeY1NFPgAmfdOydTa2xVKBx4TgQssUaEs+WkUgYugHW3FbX/8HEYjUUxhRoLgV3kS+ZA748Pe/6ax4ZwHPG4VhULQzNlNSd2y8nK0KJPBWYuK7CH1JUeCVL+Ubazr9FaQNng0SRe0ach/WUHuicK9pXNnegt9rHiWwWSACICfmHCa8e8L2lMa/QfU3O5TnX+4n8g5G4H+62kOZZfvdKN3O1f17i3VvHlay6dpwW0zufbqkOF7zdkoVIODR5yNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3808.namprd15.prod.outlook.com (2603:10b6:806:89::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 04:03:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 04:03:52 +0000
Message-ID: <694b67de-702e-eca5-aa03-ef84cf1a0d2a@meta.com>
Date: Sun, 23 Jul 2023 21:03:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 bpf@ietf.org, Daniel Borkmann <daniel@iogearbox.net>,
 Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230720000103.99949-1-yhs@fb.com>
 <20230720000109.101613-1-yhs@fb.com>
 <c3156f3e7769f779e9fb0dd09edf0e8cd00a5b42.camel@gmail.com>
In-Reply-To: <c3156f3e7769f779e9fb0dd09edf0e8cd00a5b42.camel@gmail.com>
X-ClientProxiedBy: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB3808:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad84699-70ac-4c9d-0df9-08db8bfafe2c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QL0gELTDjN05QH2eJpYboqNz92fmgnHf03sCpjbD1ZqBnaeRBUIB31bICs2mvmTQJQAvDo0Lx4dpLRNwsAlXybsSVoyJlP7gKMkxMhEjYnzx3ZTwuBSRrslvHbDYKbT+0ATGmY1MbbSTSapM7g06kJzueaojRgRj0hiNj5+qEJOyRTAhx/smVZdjkbEKYbUPI/CoHM4h2ep9fVO7JZvGTAPFaIPWEAUbxqBnQXljS2XGha4pKCp/T3bav3k21NOZ2IzD4KBwWw11KxRsorLKtKFBOxmFaD7FPV24RWAYOEDaF7l0UgBrTkJSacOq8CsyECFf6PR/OAi6DnNj4VGpXIDi3jmzrtkdEOaSku0v+YClsQrPcBuvQwfjEXlr2ANUmXn7Nvaom7PsgM9Faz55iz8HvcEtdReYsGSdF3mySuCxtCZyl14v4zzIxF/lVUDhMPhgTbq85K/qsG4rh7wxuXg1Nodzwkc6ZZ6cgbgV5nsPjFyJHMmAMDEA4gNaEG6rDtX/rxSgXUHwHeUoegEff7tthRFS4c0hQOwCjx2Jae7tCPffuk4CyMw5ScL9wQyBnu1/ufW4Wp5w4T4NqKrlfNcOVnga+waLVlcTecjodX9dn57o4HlFapoldQ/488KIrTDLhwQCIIFigOEao2h2pQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:SN6PR1501MB2064.namprd15.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199021)(38100700002)(53546011)(2616005)(36756003)(83380400001)(8676002)(110136005)(8936002)(5660300002)(478600001)(54906003)(66556008)(66476007)(316002)(66946007)(4326008)(41300700001)(186003)(6506007)(6512007)(6486002)(6666004)(2906002)(31696002)(31686004)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHgzSzVHM2V2MmhJc2ZrQ2FhWmlKZDhQSWMwN2NoNm16VGJWckM4UnpGOUlk?=
 =?utf-8?B?NmRpakZsSGZrbXlsNTVYeGRleU1STjQ1dnRYRW83OUVKcno5V0RvOU1XbFlE?=
 =?utf-8?B?NnhwRm1ZZWtDSnhka2tJbnQ4WHkrVHpPUnVRTm8xMTdiNmFxcGZicXZjb1ZD?=
 =?utf-8?B?Y0xEUVNSTGlndW05R3hwVXZ0L0t0eUJBalE2a1RvaURrN1k4N0ExdkNobE1s?=
 =?utf-8?B?VmxZS0JwRkxxNlRvZE9VQzYrTTg1MVRWZGh4LzNXUVRDZUordnI3azZEbjgw?=
 =?utf-8?B?aXkveEZuaHJ0ZWpldnpGUk04bG5VejduM3RXRkorREhxczhuVmVEcW05SjNO?=
 =?utf-8?B?bEVJQjZiaUczcmlwbUllRW1BZlpCaTlMck9DODZlSGFCSndJa3hWZzhwNkFV?=
 =?utf-8?B?OGo1TjNqTlBKRDAvYXdlSnA0WUhJcTNZWUpBd2R5Ym81OUZxVHFxM0YzWnlk?=
 =?utf-8?B?bVJDb3dGWTRpV29qYit2UCtpT1hibE1PUkpHNzF2SElIejhQcHZ4UzVYR2xN?=
 =?utf-8?B?NXkrcnU2Zmtwak9lRndvMW9kamhIN0lEVm9PY0hSYzNEU2JJWEhQMlRheUFO?=
 =?utf-8?B?YjFsOC9mdE5Sa0RMdHJtaU8xT2FKOHcwd3JnellENENxeEwycDVSZ0xiLytP?=
 =?utf-8?B?OE16em5Yb3R6RDlkVzAzTkdwMi9wdXlydU1menE3VzJtZHN2M2xNQnBwQUpM?=
 =?utf-8?B?Y1ZFSUNLSjhkazk2Z1U0OEtuTndIMXF1V0xGVHFEdUswRk1Db2hWRDVaWW9U?=
 =?utf-8?B?QW5ZZGVyVzVsYkVaZHp1bERmQ3cvdkVZWkNML0lKeUwva2pzSWNrWnd6Ym14?=
 =?utf-8?B?ZnNhMjQ4T1d6S0E1K1dXN2VoaSttdXhYWmd5UlFkbEt2dllLSitCZWJyK0I1?=
 =?utf-8?B?RHp1VXYvWFEwUGJZTWQxZnFEcnNvV2FzWml5Zk1mdDMxdmZOeXo1Q0djSHVq?=
 =?utf-8?B?Y1o0YUMvQlAyR2t6M2ZjMC80THlIRkJPMHdyeWtHY1pPdkg5SEpRbUI4RzhB?=
 =?utf-8?B?TjNFLzhYU2ZGU1R4aUd1TXZWQitFcmRZelFHZUluZ3Bsd3ZPZXRDb2ZkQ3Q0?=
 =?utf-8?B?cGc3a285R1hKVTl4MElnd0cxSmJRcWh1alN6b1lhZXJ3YUFrSE11bFlGVHdu?=
 =?utf-8?B?TlNjUW95ck05cS9FK0FOWkhPMlZVZnlJTHhlTzRaMXdjTVFCb0xxUW5ld1VF?=
 =?utf-8?B?aFlUSFl3VUU3WjZycm8wdFBjSkxmc3QxQmNDRTR5aFdzczE1TVhaZ2VoOWxI?=
 =?utf-8?B?b203SEhTNFVUVmFsUWtNbHRSU2hSY29KZWlhTDd1RHhpZXZRRGpWTXZZQW1p?=
 =?utf-8?B?cVo4S0gwWHZ0VlVrcjZMRGMyQmZXMjRqRnBrNDgxNnk2ay9oWnFqdnE0dzF2?=
 =?utf-8?B?OXkzeXpxODFTdWxhSW91TERqSnRQcmtJNWRuQnZTenUxMHd4Qk8zaXJjTVFP?=
 =?utf-8?B?OWdVZHczNERGZzNLMEpaTzlOVXIzbUNkYTVVaWhjcFZuR1JhcndNTTlhRzVy?=
 =?utf-8?B?aWdHUENudDNGalA3RVBKNVZJY1JHOHNGakZWd2pPL0hJejJwVjRIV25KQUhr?=
 =?utf-8?B?V2xVY1NYMVRxd2lsK0xMSDdKOGNMYjMrbWY5TGxZTExvMnptTlJXQkFkbnFu?=
 =?utf-8?B?dG9NNFdtcW1wRDljK2d0VHJlMEwyZG94UHNkb09PckZoQit1aUE0cTQxVGd2?=
 =?utf-8?B?a2tZZVl3OXRIVHpVVm9wYXJsdHZSQmI2dHp0aEx0L0FlMEVOSCtOdHR5SUNJ?=
 =?utf-8?B?MXU5aE9BVStPelE2NHV2RXR6UEFPQkUwVnBCMHpJVmR4OTBHa0ZmRkI1R1hS?=
 =?utf-8?B?amRlcEFoQms1TGVQQmtqd0M2dUErTU52SllhZUlhS1RBSlEwdlY0WXRnd3Fo?=
 =?utf-8?B?N2dWUTZqREhDYVExVUxLL2ZpYjRXT1N2empXeEFuR0NaVjJjTCtibWdnSjRo?=
 =?utf-8?B?eGdlTmVuRTIxS3JnSnBwUWpGUlJvU3ZNOElqaUZVMlM4VmJ5SmhwdU1LME5x?=
 =?utf-8?B?anNrWGVXWW5pNVBUR1h0Y2thL09PYnNYWFRqSWdXZ0tiWTY0bUNGQk1qdkJi?=
 =?utf-8?B?bnJDRmtjTXZFMXNuNW5KYUpoK24xcCs0QnJyUHpkU1B6SmI2S1ZGbXY0a0Vy?=
 =?utf-8?B?TlplUXA2UkR5bEVDNVNHbklaalhURXNaNXVsM3JUbGFQRkMvMXZkOFgvRVhS?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad84699-70ac-4c9d-0df9-08db8bfafe2c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 04:03:52.7310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8Vde8HLBjfybHGCQn2DMgFvpuIfOCfOh/1/PXQmPjgSFZjcWwVfsTA0f/dc8Co2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3808
X-Proofpoint-GUID: qWzE-pvt6tiNEhmiRdJqVwpGklbOpjhZ
X-Proofpoint-ORIG-GUID: qWzE-pvt6tiNEhmiRdJqVwpGklbOpjhZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_02,2023-07-20_01,2023-05-22_02
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/dNX4wZCghWDjPzGEgidjgy6ppcw>
Subject: Re: [Bpf] [PATCH bpf-next v3 01/17] bpf: Support new sign-extension
 load insns
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Yonghong Song <yhs@meta.com>
From: Yonghong Song <yhs=40meta.com@dmarc.ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/20/23 1:33 PM, Eduard Zingerman wrote:
> On Wed, 2023-07-19 at 17:01 -0700, Yonghong Song wrote:
>> Add interpreter/jit support for new sign-extension load insns
>> which adds a new mode (BPF_MEMSX).
>> Also add verifier support to recognize these insns and to
>> do proper verification with new insns. In verifier, besides
>> to deduce proper bounds for the dst_reg, probed memory access
>> is also properly handled.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   arch/x86/net/bpf_jit_comp.c    |  42 ++++++++-
>>   include/linux/filter.h         |   3 +
>>   include/uapi/linux/bpf.h       |   1 +
>>   kernel/bpf/core.c              |  21 +++++
>>   kernel/bpf/verifier.c          | 150 +++++++++++++++++++++++++++------
>>   tools/include/uapi/linux/bpf.h |   1 +
>>   6 files changed, 191 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 83c4b45dc65f..54478a9c93e1 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -779,6 +779,29 @@ static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
>>   	*pprog = prog;
>>   }
>>   
>> +/* LDSX: dst_reg = *(s8*)(src_reg + off) */
>> +static void emit_ldsx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
>> +{
>> +	u8 *prog = *pprog;
>> +
>> +	switch (size) {
>> +	case BPF_B:
>> +		/* Emit 'movsx rax, byte ptr [rax + off]' */
>> +		EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xBE);
>> +		break;
>> +	case BPF_H:
>> +		/* Emit 'movsx rax, word ptr [rax + off]' */
>> +		EMIT3(add_2mod(0x48, src_reg, dst_reg), 0x0F, 0xBF);
>> +		break;
>> +	case BPF_W:
>> +		/* Emit 'movsx rax, dword ptr [rax+0x14]' */
>> +		EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x63);
>> +		break;
>> +	}
>> +	emit_insn_suffix(&prog, src_reg, dst_reg, off);
>> +	*pprog = prog;
>> +}
>> +
>>   /* STX: *(u8*)(dst_reg + off) = src_reg */
>>   static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
>>   {
>> @@ -1370,9 +1393,17 @@ st:			if (is_imm8(insn->off))
>>   		case BPF_LDX | BPF_PROBE_MEM | BPF_W:
>>   		case BPF_LDX | BPF_MEM | BPF_DW:
>>   		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
>> +			/* LDXS: dst_reg = *(s8*)(src_reg + off) */
>> +		case BPF_LDX | BPF_MEMSX | BPF_B:
>> +		case BPF_LDX | BPF_MEMSX | BPF_H:
>> +		case BPF_LDX | BPF_MEMSX | BPF_W:
>> +		case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
>> +		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
>> +		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
>>   			insn_off = insn->off;
>>   
>> -			if (BPF_MODE(insn->code) == BPF_PROBE_MEM) {
>> +			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
>> +			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
>>   				/* Conservatively check that src_reg + insn->off is a kernel address:
>>   				 *   src_reg + insn->off >= TASK_SIZE_MAX + PAGE_SIZE
>>   				 * src_reg is used as scratch for src_reg += insn->off and restored
>> @@ -1415,8 +1446,13 @@ st:			if (is_imm8(insn->off))
>>   				start_of_ldx = prog;
>>   				end_of_jmp[-1] = start_of_ldx - end_of_jmp;
>>   			}
>> -			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>> -			if (BPF_MODE(insn->code) == BPF_PROBE_MEM) {
>> +			if (BPF_MODE(insn->code) == BPF_PROBE_MEMSX ||
>> +			    BPF_MODE(insn->code) == BPF_MEMSX)
>> +				emit_ldsx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>> +			else
>> +				emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn_off);
>> +			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
>> +			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
>>   				struct exception_table_entry *ex;
>>   				u8 *_insn = image + proglen + (start_of_ldx - temp);
>>   				s64 delta;
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index f69114083ec7..a93242b5516b 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -69,6 +69,9 @@ struct ctl_table_header;
>>   /* unused opcode to mark special load instruction. Same as BPF_ABS */
>>   #define BPF_PROBE_MEM	0x20
>>   
>> +/* unused opcode to mark special ldsx instruction. Same as BPF_IND */
>> +#define BPF_PROBE_MEMSX	0x40
>> +
>>   /* unused opcode to mark call to interpreter with arguments */
>>   #define BPF_CALL_ARGS	0xe0
>>   
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 739c15906a65..651a34511780 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -19,6 +19,7 @@
>>   
>>   /* ld/ldx fields */
>>   #define BPF_DW		0x18	/* double word (64-bit) */
>> +#define BPF_MEMSX	0x80	/* load with sign extension */
>>   #define BPF_ATOMIC	0xc0	/* atomic memory ops - op type in immediate */
>>   #define BPF_XADD	0xc0	/* exclusive add - legacy name */
>>   
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index dc85240a0134..01b72fc001f6 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -1610,6 +1610,9 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
>>   	INSN_3(LDX, MEM, H),			\
>>   	INSN_3(LDX, MEM, W),			\
>>   	INSN_3(LDX, MEM, DW),			\
>> +	INSN_3(LDX, MEMSX, B),			\
>> +	INSN_3(LDX, MEMSX, H),			\
>> +	INSN_3(LDX, MEMSX, W),			\
>>   	/*   Immediate based. */		\
>>   	INSN_3(LD, IMM, DW)
>>   
>> @@ -1666,6 +1669,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>>   		[BPF_LDX | BPF_PROBE_MEM | BPF_H] = &&LDX_PROBE_MEM_H,
>>   		[BPF_LDX | BPF_PROBE_MEM | BPF_W] = &&LDX_PROBE_MEM_W,
>>   		[BPF_LDX | BPF_PROBE_MEM | BPF_DW] = &&LDX_PROBE_MEM_DW,
>> +		[BPF_LDX | BPF_PROBE_MEMSX | BPF_B] = &&LDX_PROBE_MEMSX_B,
>> +		[BPF_LDX | BPF_PROBE_MEMSX | BPF_H] = &&LDX_PROBE_MEMSX_H,
>> +		[BPF_LDX | BPF_PROBE_MEMSX | BPF_W] = &&LDX_PROBE_MEMSX_W,
>>   	};
>>   #undef BPF_INSN_3_LBL
>>   #undef BPF_INSN_2_LBL
>> @@ -1942,6 +1948,21 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>>   	LDST(DW, u64)
>>   #undef LDST
>>   
>> +#define LDSX(SIZEOP, SIZE)						\
>> +	LDX_MEMSX_##SIZEOP:						\
>> +		DST = *(SIZE *)(unsigned long) (SRC + insn->off);	\
>> +		CONT;							\
>> +	LDX_PROBE_MEMSX_##SIZEOP:					\
>> +		bpf_probe_read_kernel(&DST, sizeof(SIZE),		\
>> +				      (const void *)(long) (SRC + insn->off));	\
>> +		DST = *((SIZE *)&DST);					\
>> +		CONT;
>> +
>> +	LDSX(B,   s8)
>> +	LDSX(H,  s16)
>> +	LDSX(W,  s32)
>> +#undef LDSX
>> +
>>   #define ATOMIC_ALU_OP(BOP, KOP)						\
>>   		case BOP:						\
>>   			if (BPF_SIZE(insn->code) == BPF_W)		\
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 803b91135ca0..79c0cd50ec59 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -5809,6 +5809,94 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
>>   	__reg_combine_64_into_32(reg);
>>   }
>>   
>> +static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
>> +{
>> +	if (size == 1) {
>> +		reg->smin_value = reg->s32_min_value = S8_MIN;
>> +		reg->smax_value = reg->s32_max_value = S8_MAX;
>> +	} else if (size == 2) {
>> +		reg->smin_value = reg->s32_min_value = S16_MIN;
>> +		reg->smax_value = reg->s32_max_value = S16_MAX;
>> +	} else {
>> +		/* size == 4 */
>> +		reg->smin_value = reg->s32_min_value = S32_MIN;
>> +		reg->smax_value = reg->s32_max_value = S32_MAX;
>> +	}
>> +	reg->umin_value = reg->u32_min_value = 0;
>> +	reg->umax_value = U64_MAX;
>> +	reg->u32_max_value = U32_MAX;
>> +	reg->var_off = tnum_unknown;
>> +}
>> +
>> +static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
>> +{
>> +	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
>> +	u64 top_smax_value, top_smin_value;
>> +	u64 num_bits = size * 8;
>> +
>> +	if (tnum_is_const(reg->var_off)) {
>> +		u64_cval = reg->var_off.value;
>> +		if (size == 1)
>> +			reg->var_off = tnum_const((s8)u64_cval);
>> +		else if (size == 2)
>> +			reg->var_off = tnum_const((s16)u64_cval);
>> +		else
>> +			/* size == 4 */
>> +			reg->var_off = tnum_const((s32)u64_cval);
>> +
>> +		u64_cval = reg->var_off.value;
>> +		reg->smax_value = reg->smin_value = u64_cval;
>> +		reg->umax_value = reg->umin_value = u64_cval;
>> +		reg->s32_max_value = reg->s32_min_value = u64_cval;
>> +		reg->u32_max_value = reg->u32_min_value = u64_cval;
>> +		return;
>> +	}
>> +
>> +	top_smax_value = ((u64)reg->smax_value >> num_bits) << num_bits;
>> +	top_smin_value = ((u64)reg->smin_value >> num_bits) << num_bits;
>> +
>> +	if (top_smax_value != top_smin_value)
>> +		goto out;
>> +
>> +	/* find the s64_min and s64_min after sign extension */
>> +	if (size == 1) {
>> +		init_s64_max = (s8)reg->smax_value;
>> +		init_s64_min = (s8)reg->smin_value;
>> +	} else if (size == 2) {
>> +		init_s64_max = (s16)reg->smax_value;
>> +		init_s64_min = (s16)reg->smin_value;
>> +	} else {
>> +		init_s64_max = (s32)reg->smax_value;
>> +		init_s64_min = (s32)reg->smin_value;
>> +	}
>> +
>> +	s64_max = max(init_s64_max, init_s64_min);
>> +	s64_min = min(init_s64_max, init_s64_min);
>> +
>> +	if (s64_max >= 0 && s64_min >= 0) {
>> +		reg->smin_value = reg->s32_min_value = s64_min;
>> +		reg->smax_value = reg->s32_max_value = s64_max;
>> +		reg->umin_value = reg->u32_min_value = s64_min;
>> +		reg->umax_value = reg->u32_max_value = s64_max;
>> +		reg->var_off = tnum_range(s64_min, s64_max);
>> +		return;
>> +	}
>> +
>> +	if (s64_min < 0 && s64_max < 0) {
>> +		reg->smin_value = reg->s32_min_value = s64_min;
>> +		reg->smax_value = reg->s32_max_value = s64_max;
>> +		reg->umin_value = (u64)s64_min;
>> +		reg->umax_value = (u64)s64_max;
>> +		reg->u32_min_value = (u32)s64_min;
>> +		reg->u32_max_value = (u32)s64_max;
>> +		reg->var_off = tnum_range((u64)s64_min, (u64)s64_max);
>> +		return;
>> +	}
> 
> I think that the bodies for (s64_max >= 0 && s64_min >= 0)
> and (s64_min < 0 && s64_max < 0) are now identical.

Thanks. Will change in the next revision.

> 
>> +
>> +out:
>> +	set_sext64_default_val(reg, size);
>> +}
>> +
[...]

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

