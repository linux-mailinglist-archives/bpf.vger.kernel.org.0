Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60574CB3B6
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 01:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiCBXx1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 18:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiCBXxZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 18:53:25 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896EBC7EB8
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 15:52:38 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMkFq004956;
        Wed, 2 Mar 2022 15:31:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vI8wrW9+BQMULAX9Uvl+41L/9A/hGe90XlMjQ+JsxtY=;
 b=qILn39zgmzb7aIQ9hBYDxpE7Zm78yIvdv5SFzzz4uvaCUfhkrzpjmZlD/rxZMNjMi68b
 tQV+ElyZovWrbmI8Glt3uzhkzKDa0jxJrbzGWpkkSh/MXpU8SSRUF2I8ogYiqlzYqVj2
 2mOqtdli7FD45DmOdQ9mVez2totI+XCIQw8= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ejdmmt70s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 15:31:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aC9wljxDjNnr4QN8i9XhMc572nkGs2uzvUNR+O6NbpHmYaodx/ObgSlk1/9i0n1RnhfYPnx2uqybn1XE4zn/zq4f6MFu+4KRVQkIRLD0/CP4XkfIzubfa/hQta2Jw225a4Ie11b5iMz3r7tpcHCm2QYtGQRrwYNWvPOpcHPDMwU9Lpe7Blyvk88igxsMGTwhApaDA/jsk1GxYiWPSEBSSslSEC7uCjFe5N4EQcVW/FIcLwIEWV7b2nMWH4DjfYxfoslDho6ipGkxywztJ/sLeiAkPLnnOiYbIrshmBl/lP1Pj1aOAmgxZPkj6rwD26d4QT4cp8NsWONAp/ZNu7YGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI8wrW9+BQMULAX9Uvl+41L/9A/hGe90XlMjQ+JsxtY=;
 b=CTqlEjNBGhsfjVBhjOctAYgu8UvqtrSFlMRpHHGk4AQK97J78fy1MCzErfJix58lsOY/gCX8SCA7bYRnhu86qnhZ0IqxnlaI7CW+OYFw+EV83xDbYoH2PH7h2k3I5xusiW/f5HhQxf3MneHJmhjM8uTA16FWHM9Rwp7jNzgkNKllsROyRekAz1wJ8GzjPK6NB/wBtRZ2UJfqYalFqZ5Y8p6BGpbeXggQWEpydQdwlohlP/Ef93xYr9AKVK0N7PGwa4Ouodx/ab28svMnW4sGkoq1VU+UTdK/P1SP4DADC7KDdAjHO+UuxzuPAGjJdkFducysTxXo2B0l804jPyh3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by DM6PR15MB3862.namprd15.prod.outlook.com (2603:10b6:5:2bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Wed, 2 Mar
 2022 23:31:44 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd%7]) with mapi id 15.20.5038.014; Wed, 2 Mar 2022
 23:31:44 +0000
Date:   Wed, 2 Mar 2022 15:31:41 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v1 4/6] bpf: Harden register offset checks for
 release kfunc
Message-ID: <20220302233141.qob5kwnkrtwnt6qf@kafai-mbp>
References: <20220301065745.1634848-1-memxor@gmail.com>
 <20220301065745.1634848-5-memxor@gmail.com>
 <20220302032024.knhf2wyfiscjy73p@kafai-mbp>
 <20220302094218.5gov4mdmyiqfrt6p@apollo.legion>
 <20220302215640.2thsbd4blxbfd7tk@kafai-mbp>
 <20220302223020.3vmwknct24pplzzr@apollo.legion>
 <20220302224418.5ph7nkzx2qmcy36n@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302224418.5ph7nkzx2qmcy36n@ast-mbp.dhcp.thefacebook.com>
X-ClientProxiedBy: MWHPR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:300:117::20) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38323a08-8244-43ad-f630-08d9fca4d029
X-MS-TrafficTypeDiagnostic: DM6PR15MB3862:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB3862782DE7310DF3604A3B39D5039@DM6PR15MB3862.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9RkMHnRhUFunMuwrsrF+I21LqLfazk2nwerdRzGLPGSJJVGixXPiMRKCMlAssbFmkhthCYIeqp6A+tfzp5HBK3mU8bsfaypvjJFAHgkK9W4/1e9lkfe9FGIPokoPVPqc6tNnOZLQOYj7bYyEXRavv0/XIRUpJooQ/Ro1JeunuysKYnqbAHu7nQj4dHnGp0YeMpmtMKov13DeorF8fNA25ddvOe2vmQl8xrq4ELhT7u7+P5/RuCsvkm9qczsTSql+Wah0AMZ2l7NXAMDbYFXWIoks/GjOcQSzsxvr6ukmZXbnEUx7VMAe3t73XJY1OdUUeAtDXf6mbjju4T2DDnHqo4+Hz3PINq/4sHDKhbw3Uhj52jx02qZiOPnRjjV6+CjnsfHRmf8hwKcc0r5x97Bk0XGzVOhKVb4GIAKM8nkaFNnspBLzHqYe37nfrSu9wXtF0M0+uQN/lUhqjh/liNUo4wxRtyZAU/0zo8aTUP69S+YI5QBXj1Zx3LbAk3/hH6PuhGmQXpp4WLhkg2e9LCOn+bJWBieSUjwmVMH8ukomDsvqwgnAlYMLhctB0p9yvk9iwQAk+FCijzpKRXeIA/1k+X2QhpxywhEln+JuwzNLSNTYz4XvzIhCKEzdQIbKraG57MgyM2lrUmQr/ZMgpb4YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(6486002)(8936002)(6506007)(52116002)(33716001)(83380400001)(508600001)(110136005)(54906003)(38100700002)(316002)(6512007)(1076003)(86362001)(9686003)(5660300002)(186003)(8676002)(66476007)(66556008)(66946007)(4326008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pN3f8QhYSHn+iUT7opplhl8uwdOZosX1RuXumi1LgSsNBPFpwAWlDav37pyZ?=
 =?us-ascii?Q?Fl60Cy5D5ptdjfoTYtadDBpiwKHd4bJG6Bl2zv2rcf/sBCjwrhq31/PExA1h?=
 =?us-ascii?Q?a4jncreX1s5THpbugk63bbmeSt7Jg/OtqFr9ThJpFzdiCr30ap1JhreGRij4?=
 =?us-ascii?Q?qp3m8kCvb/eg/lGnCrKpbV/B1He9LfVsJGFBHbpmvhjZXCtiSb3Fp0akykjY?=
 =?us-ascii?Q?h5T4f3MlqGRp6W12rtd0S92Ks6rw7GSiGiK4TQqhcwvGkPZ6DesIRB3IIubM?=
 =?us-ascii?Q?czvDcXk1qPEe6yDlHtM3h+BCSwN0FbwVbZOuaYf6bNl6BDfOfsfAbePIo0VE?=
 =?us-ascii?Q?Ikdk1yoOVxou1ZkSP+AvcqZhegnNoy4amQx8O60XJD7YAuI7wUszrSagwlJS?=
 =?us-ascii?Q?WZxDgrmAHhpQRmFn5KID4uwQHbnSE/vj+BpCakGC6XIPPE4uYK2fUlRLCw5o?=
 =?us-ascii?Q?0VDb6uFy77ENteFLxkr5YcwESP8Xkq+iOAPrzonNAxsMUbTTUnw+P0Zt0abe?=
 =?us-ascii?Q?cy3/nzsjwWyN1ArsodhxoOabMW3lZ5UxaA/7eJ5Nv2r/gM1ufQjCCJTxAg3N?=
 =?us-ascii?Q?WDIIM843htK52GfGbShO8xhWWXiNhqA0Ppt1pMUF543y/WxkF+49e0ceQ16k?=
 =?us-ascii?Q?rsUEFcRwbDHK0Re1333NEiUFzWClI4ZMe+KspJTQlgIyojbsr8gTiswZZRxl?=
 =?us-ascii?Q?z3MLEWcd/rkn+vqGN25WluCVzcC2ZaFWOfm1+aGipBJIgw8iXbx58TmGPi4g?=
 =?us-ascii?Q?ozkP5+QosbG9pPCNp7Yq/wInoyl/kDEbZXsmdu9eGdZWbUFk0mhrDH3ZSpeS?=
 =?us-ascii?Q?vIUT3BegcIlB4h9k7HFOYDHPjQ3dXiwFUOqOu583yrypPShR1enizobigWXs?=
 =?us-ascii?Q?9UnP/qFfNWiR/dlPMGLSywtUJd8t6Xi024RaeesfQgLCznrSR+Tclt012WVK?=
 =?us-ascii?Q?8AcraekZeVgTgH2GHNn4gi/JNNft4kpTBcsZmyAkZDsE5qMK16naGNiBBoY9?=
 =?us-ascii?Q?ySf+qGHO5ZOGBNAktA9SY53XLNGIh5l8t3SVhLAgnp7kYvsMu+4EMRO5tx/c?=
 =?us-ascii?Q?/m/xF3MsODICVdxEpy24NNMU5SLB47WQ5y7adwjDOpFzC0pooNc2u9kzmYnJ?=
 =?us-ascii?Q?+EwIUgrSSyVSRqAZGCTfXwsyZtbGyiVRicn4vWuHlK57aKC29AtEqR7YqrQm?=
 =?us-ascii?Q?wopvmCdQ5SZQDUPMLtUKbqEbsegoqpnv8a9PVw3EQ4/GyJaFC6XVK0jNk7qJ?=
 =?us-ascii?Q?GZ9z3vsaczCJYEUBJLuvqFSYGaEQS7DPwm8Yhqi84/3ljpFcf1vlD62Yia8B?=
 =?us-ascii?Q?ogivTfGqsYKkX6osxwppo0n3JLURaTvR18RQhnd5e9XMjBno7TMGqezhav37?=
 =?us-ascii?Q?+gDoXkz0UXqEAQa9zDBLb1+b3Dgf8nownzH+UfiGewX47ipwc1Nx3himOmBb?=
 =?us-ascii?Q?0KgUaeIxa1TPEEQfm4LSkJzS1maqu4vqkmgLNNy70kQvxLB2NFClFG0tw4DM?=
 =?us-ascii?Q?SSUqIW65KmNG/DZ3gCvLEt/27A9QuslTDrN8Bxtueu0QcuUjzLCnPKX4za5r?=
 =?us-ascii?Q?vU7bJfyT9Cf3YDKndwmZEI1IFo1znjWP87kxlmncIffdsroUaDzfZjpSF8/e?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38323a08-8244-43ad-f630-08d9fca4d029
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 23:31:44.8601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M28pBrV1G0kgSnFfZN3h5H7N4QVnfb6QbdCWK5VCGPadQltEaWgTIC98Hx5lWJw/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3862
X-Proofpoint-GUID: IunnJjt0DU1P3jMz8_7H9ifa-iKBXtqC
X-Proofpoint-ORIG-GUID: IunnJjt0DU1P3jMz8_7H9ifa-iKBXtqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203020098
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

On Wed, Mar 02, 2022 at 02:44:18PM -0800, Alexei Starovoitov wrote:
> > So IIUC what you're saying is that once someone performs increment, we reset the
> > ref_obj_id to 0, then the reference state is still present so
> > check_reference_leak would complain, but releasing such modified register won't
> > work since ref_obj_id is 0 (so no ref state for that ref_obj_id).
I meant error similar to release_reference() should be used and it
should be treated as release-without-prior-acquire error.  The reg
is pointing at something that its reference has not been acquired
before.

You are right, reset ref_obj_id to 0 during increment won't work
as you have explained in the following.

> > 
> > But I think clang (or even user writing BPF ASM) would be well within its rights
> > to temporarily add an offset to the register, pass member pointer to some other
> > helper, or read some data, and then decrement it again to shift the pointer
> > backwards setting reg->off to 0. Then they should be able to again pass such
> > register to release helper or kfunc. I think it would be unlikely (you can save
> > original pointer to caller saved reg, or spill to stack, or use offset in LDX,
> > etc.) but certainly not impossible.
> 
> I don't think llvm will ever do such thing. Passing into a helper means
> that the register is scratched. It won't be reused after the call.
> Saving modified into a stack to restore later just to do a math on it
> goes against "optimization" goal of the compiler.
> 
> > I think the key point is that we want to make user pass the register as it was
> > when it was acquired, they can do any changes to off between acquire and
> > release, just that it should be set back to 0 when release function is called.
> 
> Correct and this patch is covering that.
> I'm not sure what is the contention point here.
> Sorry I'm behind the mailing list.
> 
> > > >
> > > > Again, given we can only pass one referenced reg, if we see release func and a
> > > > reg with ref_obj_id, it is the one being released.
> > > >
> > > > In the end, it's more of a preference thing, if you feel strongly about it I can
> > > > go with the __check_ptr_off_reg call too.
> > > Yeah, it is a preference thing and not feeling strongly.
> > > Without the need for the release-func/reg->off preemptive fix, adding
> > > one __check_ptr_off_reg() seems to be a cleaner fix to me but
> > > I won't insist.
> 
> fwiw I like patches 1-3.
> I think extra check here for release func is justified on its own.
> Converting it into:
>   fixed_off_ok = false;
>   if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
>           fixed_off_ok = true;
> obfuscates the check to me.
> if (rel && reg->off) check
> is pretty obvious.
Yeah, I am fine with an extra check and the "must have zero offset
message when passed to release kfunc".  The error is obvious enough
on what may be wrong in the bpf prog.
