Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A84CE0F5
	for <lists+bpf@lfdr.de>; Sat,  5 Mar 2022 00:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiCDX1O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 18:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCDX1N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 18:27:13 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B6E0A04
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 15:26:24 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224HQjQm007019;
        Fri, 4 Mar 2022 15:26:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=uPv/7Tj2r0a+MhkAH+aNg1GXdg64jKKMAFO9oSEep+c=;
 b=GrD5mCN8G8l5F9inEg66Wx55fc161i/Pee53SHyjTXdAn4ddWX/3NZSv5aPtpl/772RU
 Oi8m8ZqqGdGBOqqFQ7ZnTZT/eEpdqtd6NPs/aKKFrFzfOcDuBFf1DdAkTXnqc4/SJS5d
 bXAsIuBKV9zBppxUzGsAUXI3poQyTRrE0kI= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ek4hrrxuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 15:26:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTfP81AmRpHgxw8tuSYYdr/sB85dpgTEHIPV38Aiz6LOWPso4oxH8nl975jWX7gvKtdY/87sHJH8pXaxSum7Yo/ppRstCuKfsjjpd9XpcdnwjGmUT4q4Ncal/qryzTX5ucQTR2lhcXO3v8PcjlMxoup7nwWe03kIliOeRbFLc094JA6cwyUiT9jhkr27Xswde4HriYOQMVkqnTU75twCf4rpaD50wiYADBBBpkwCD1h3iYKS2u0Tz70DmozshsBYJqgMRftWvVaIEy7iBz+pIO8+N/HMVEvNrU4kUjyxxCc5fRGYOy3t3D7bEMsShpHT6KNtzHBmjnSlmpD+iaG+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPv/7Tj2r0a+MhkAH+aNg1GXdg64jKKMAFO9oSEep+c=;
 b=d1tHT+kvNY+nIBmum7FbyQxXttFVvwm+yG38nxDPG5xx2t/5RiFm/zsTTXC6f4/nz/0X8eQe00tr53ttVoDC4zfGqR63ishI8DEQ78WFpml5IQRyeVtr9rlnYezp+BAAW7vmWn0Nt9S1DMbuOvSOmQU9L3MxX41LzoJShaUUn1mcXWRh151t4jXj4O2Ce9mUWfqAFNqDjhuC4S0gVsIcm0IXOrDsegc7LoPKkQKYnP+X78eIszfN6zXs9m2j7FmVS4C/rJjeMj3MreHhgyVaRkz8P+Brkz95I60LWuvfAWxWh+GLDVjPxylW/sTPTIJrsilDKCkW5PynoeUek28yJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by MW2PR1501MB2043.namprd15.prod.outlook.com (2603:10b6:302:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 23:26:08 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd%7]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 23:26:08 +0000
Date:   Fri, 4 Mar 2022 15:26:04 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v4 0/8] Fixes for bad PTR_TO_BTF_ID offset
Message-ID: <20220304232604.r6kzyipvqyqyrdon@kafai-mbp.dhcp.thefacebook.com>
References: <20220304224645.3677453-1-memxor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304224645.3677453-1-memxor@gmail.com>
X-ClientProxiedBy: MW3PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:303:2a::31) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbebbbcd-ba3e-4c64-25c8-08d9fe365c33
X-MS-TrafficTypeDiagnostic: MW2PR1501MB2043:EE_
X-Microsoft-Antispam-PRVS: <MW2PR1501MB2043D93B1DC9236034D19056D5059@MW2PR1501MB2043.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +0eyzHsBQshyaJiOH9SOoFLHh85eZ9sB5KVqUwegZby08x8Qp92rvMvyLgydTDzjIQ2Ix6JW1NUPcKVtYE5eBL6qUq3dggwdsL3AceBKIARiL0gbiifOCTM6U64xjeILddzAZlKo3tDlUPfB+cfz6L5q2IA9UVZKrnCwBB1ejtjaQkG5ZCY7qOA4GUTQhNzP7AO9Fxg0nkfsrd+MjEh0yi0nQSodTiVJhlPwD5PtY3aqsW/uRiOyQROAdkU1GiBCkFAO/Xz6PND6GrbTd97Byl/AB579bi/5GHcLe2XrFSVhq6BMVm2Pdwtr4W84voeuTmg/wpznYW9gRysXScNsud0iD4qyJXK3VEqznKTj7H2DEx4JQ5fj5KmKNWzmAz4kvUfsDTftx8wrVE8wUR/s/zo5dGjxkrgT9MMYbed1kX1MYiz3VSIVVMgt18sweDkV+v0F8ZNg+RDHwZevtC4fL6CJGl3rFlHudeqaGGr9MRLBEm6lOlYAVNcx7mIh3L8x9Othv30nfxDCSkQWfDyfUdC2nPC23wJ9xosQHjGX/aPPeADfTjnec8750EL29ld/O8DmvyIavQcJCM69xATkDefU8yUQ70c3HplRDWPlxV0WJHWyrbNUkJ0vvoC2tvMoug4g82EEMGpu1BE0XDlfXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(86362001)(508600001)(6916009)(316002)(54906003)(6486002)(2906002)(6506007)(4744005)(52116002)(8676002)(66476007)(4326008)(66946007)(66556008)(5660300002)(6666004)(1076003)(186003)(6512007)(9686003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nm0gSsp0sg58PP9J2kD28GwOYfZvCYDXkyRSHx/EsEaWozOyQYd7N5fhL8I2?=
 =?us-ascii?Q?829PusfnxVs/xSSUP47vFtGbb/CrT2p7u/N2O8nTPvbASaMnL+R7RvqqDDF3?=
 =?us-ascii?Q?IqnqTzN6hGzMypvLOsk7ObnaRx4XVm+FYnD7wrULiapZgxEwntClpW/RBDL8?=
 =?us-ascii?Q?1Ro7ubPby4z3pV0VY9oOKuX9RYFyqtYcSnelqw1vtVKXLAxiM0LG6tbzzXUb?=
 =?us-ascii?Q?gVceGYYHDSF58euplnPEIBDqHzSs9XS+/cXZKuZMhC0k7VaGPtiTFBbiM8iq?=
 =?us-ascii?Q?5deBlBV1oyf0DjH4zvpuTp0+vQpVySEeH/c3a4cc6Py307rzOCVwc6Qrz9tt?=
 =?us-ascii?Q?LsNnlGwhKYIR8l/cr7by8dSRfxpbiPqkwRg3lXexHRwJ9SFX2QYY2iW6UjXA?=
 =?us-ascii?Q?CpvA3j8srTKap4AiADj7clfhXCQxF9aO2X6Nn3Zzx2b++c4rrCHXJoiQusNS?=
 =?us-ascii?Q?FYiDNMHFMBBpUklaJlK+vMz6ZhXMHxgUIKXUrhhg8pqCLposhTQbFY21VXyM?=
 =?us-ascii?Q?pwB6+u8LK4uCKIxh2Zm6aE5ftYUMqQzLgvgyI8YqPfcTfLLij8krqOPohlZE?=
 =?us-ascii?Q?mlP6xhi+wyqLFPZJz4lUAENVakU3GCfjBOt4w4YxQNQDnGJGcf3ie3GFCBCh?=
 =?us-ascii?Q?40xgB80Nl7XlT/lStTqDoxxGS9uGRc07rfAp1HpJd8VOIjUcc1NdfmMsHp78?=
 =?us-ascii?Q?CWYTkiFNv/mxdqGLJJbuKuWJIEL1AARz8HT+NJikYfBtvLaFErFZ3NTw1eYK?=
 =?us-ascii?Q?sc6JmejJv3/hMc/no/M2OL1jxRnEKyY8NvDL4zSH+Nmm3HFhdC0PBt7mfiYj?=
 =?us-ascii?Q?vhIPUmV5Z5UvI4b+8JQgMzRPDlHmDwowAbwx3Vew5dv1u2HEjlygDKJSOuqI?=
 =?us-ascii?Q?tSgZCuRfunETID9GYIfVOb7cWl0a+ABKDUXeapYXecB1HFxco36wF7us2P6P?=
 =?us-ascii?Q?D4UMiyyKy3aCdOtJaHgh8FPCDcJD/dw6OZfhU2WUx/yWBUcGknHkZQPpd6aF?=
 =?us-ascii?Q?pedONUunfV+VqSfWyTedGw0GjjYnhNilUvjq0XELxpeX9hqvVFhZPLRttiFL?=
 =?us-ascii?Q?bssLhBImLrXmgPNeL68ZgsavFwhY4FAZHW3vUa6tnndZqdAKWGcfCtCxaxyG?=
 =?us-ascii?Q?1te8hknUcCIS9jvCWrHD6lyLEyCSBQtBjFfitmIcqz2ipUpFbGsljB/zPmwE?=
 =?us-ascii?Q?yiPtB4Ipn4zhMYmUxaQIIcGl5ZJfHu7uYFQFG1TUDfm7Qdt/uJ55tTWk10s0?=
 =?us-ascii?Q?q1j0kzslGWqYDUrulfiDePD9unb4TqpLmKwvfIu0/yJAvjWaRTYZ+nXg6zRf?=
 =?us-ascii?Q?i0gOr/bjg7dL9usChXog5hUKe3hACx4TT/31lIsSnG0oeF6mJG9zzgdtibre?=
 =?us-ascii?Q?+Jg/z2QAmW8aOBMwMvPVvzIkf+6m3Xp9QwmrMMdpcMRIMtd7eicNaant9oPo?=
 =?us-ascii?Q?J5HfI9XVzkEKQvhE+18HyleNHrlfIb4hMJw1o9MVc7kw8UzAjRU+AN2a4B2D?=
 =?us-ascii?Q?GAEzSroHwUj/dru9b2q17tUHr4tuTpXLEMF/cRV2yNDkvMKaZKAUYTvSsKfm?=
 =?us-ascii?Q?DdUYsiogreZlW0j37SLwu4lCEB2SLU8cSEptIi+A?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbebbbcd-ba3e-4c64-25c8-08d9fe365c33
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 23:26:08.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XyGF7k4nRgo+RnzLU4oCzM61QSIeTb3JKk6PaiW+KfE2ivwB5CGE1TfRbV3dt8KL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2043
X-Proofpoint-GUID: Yin4iQyXaIqzrScihYybbfLn0QO481td
X-Proofpoint-ORIG-GUID: Yin4iQyXaIqzrScihYybbfLn0QO481td
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=557
 impostorscore=0 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040117
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 05, 2022 at 04:16:37AM +0530, Kumar Kartikeya Dwivedi wrote:
> This set fixes a bug related to bad var_off being permitted for kfunc call in
> case of PTR_TO_BTF_ID, consolidates offset checks for all register types allowed
> as helper or kfunc arguments into a common shared helper, and introduces a
> couple of other checks to harden the kfunc release logic and prevent future
> bugs. Some selftests are also included that fail in absence of these fixes,
> serving as demonstration of the issues being fixed.
Acked-by: Martin KaFai Lau <kafai@fb.com>
