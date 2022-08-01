Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793B55871D8
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 21:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiHATze (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 15:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbiHATz3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 15:55:29 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF106BE3
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 12:55:27 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271FHdhM011536;
        Mon, 1 Aug 2022 12:55:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=YNsqzVa5hxUDIG0hgbvc3pjbsz0RsQunDMrby9K22+Y=;
 b=MeGEdWEmoxTV093gs+6s+gM5BCCyIkhA4nlmiq2CPOdbjEUTdK4T6ikLZgmbMe3YSXPQ
 zmUg4vuHG7eHmuugWGpJac88J4myXSFwaNz+cGtDcZY6Yf3pmCqQzRKvKwxggHqR4puF
 vQDiJvwPHo6/ShPqNBeWwI0LL39Rk0/nPeU= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn3y3dm4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 12:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENlYuFfDyS3C9A89xhlbWVTgNwdHd6E7oHIEluambPlabeb2clrR1jMWFv7u3mweqKjtzu194Ch4YXcMTJfMYbm6dVvxYpqV20aeDA8vHYX0TqMoVxr3KWnftiUeWuUK6j/c1BTZMX/4yEEtfcHhVRLDvMjcS74SJnRWJlpQsIFJJItpeqjPxMKMu6NZBExmfAChKR5BcrhhxCWLsfg6hF7hqldgIuyNurXQYrwVXw6LU8HqpCz3wfOIU+anDqI32HgedKuOQRtZbwtwTEFKANL8bSh3N4a1V7hIffJx77mfFYutlHr6mLh/3UO6XlTm3yKgtv3mo2J36kViWo7WHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNsqzVa5hxUDIG0hgbvc3pjbsz0RsQunDMrby9K22+Y=;
 b=l8XMh9xT+6CtavF4oRN9eyg7gfFl0h7VqnIQMqbwNFmPU257+LkNo26Oawd9yD1UWr8DwkP4jJQC1M/l1+Lk7o7gfgKqvv8lJgQdz4TXlfuLRbUHhx0a+6taUM1Xnic1WAkJ2qcqQBcglNPqTD7007HeIpw3xO9fivEXTJWOjGS8vzHAyP3PWJcEiAMhr3GLDNinQD/DMkLgIKGpo7go2gFk0Ynt5Km9B9erExPTBX3UxMEaY8asNS6efIyupFjUl9ww0LkRZd+gg4oERNssvkW1MqKP79t//oJUA3f0QmPVJaunVQ0MKAQVB4s8GpVhFcasrj8sEhFQMGdfPUqoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN8PR15MB3187.namprd15.prod.outlook.com (2603:10b6:408:73::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 19:55:06 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 19:55:05 +0000
Date:   Mon, 1 Aug 2022 12:55:04 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Excercise
 bpf_obj_get_info_by_fd for bpf2bpf
Message-ID: <20220801195504.du5vx6wyxoh44cox@kafai-mbp.dhcp.thefacebook.com>
References: <20220730000809.312891-1-sdf@google.com>
 <20220730000809.312891-2-sdf@google.com>
 <20220801174530.lcxhrvm6xtfjpxa7@kafai-mbp.dhcp.thefacebook.com>
 <CAKH8qBv2mNxTKV=GzB1mmSq+pTRAFzZHAE=827ByrcLykV_WQA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKH8qBv2mNxTKV=GzB1mmSq+pTRAFzZHAE=827ByrcLykV_WQA@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d7379b4-41c4-4726-a2b7-08da73f7baf8
X-MS-TrafficTypeDiagnostic: BN8PR15MB3187:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxqd7KPlc697hGOcGic4ZVR+ZRIj7ihIl/s8tApCm5JTEkFox3V584hGvQOu4iUd5o6Tk9K8La6XX8bF5kXtHXAICHWmdyTTQRpac5DlegIWq7X0dqPbVoQaZYqEkLNJgyCH3RD8aH4Ix54JaLvM5ZbyURaQdrHWs70Udty+hhxRWDrlFz9Bz5hMZ8umyxSyrlfWm/Xdj5VnfH7AgyL464DfBsMxIQsJbI0pMcssgvkuzOEiMSPcYFaXVRCE6C9F3p9dTFdDNK3L4ZC99kuFgWTEG/vpvZIvx83xrq2KnX41qHpXkTMgHzuGsGsyGEKjo7WwMN8l1+T63HtFQt7T8MLijg08qd4zaP8WnJfwBicsmGOUFJbFMk6MKHXJGPW4Qv764V6cBJgBdTK3G4CNLY8IQNr+76lSdTkgYbxyXLwxoV0CMVdRSreU4L4Y0TVbUzGMrTaBHxzTCu6+mOCqP6bGNNzUJD8cvoPI5KKeoUxt4uzKNglAeWWXpReJZuEAaUL0qxrNkWMcVRNjHeKZHJZ1raHNsUIx+lN3IvWhYMKsW3FjcNTb6NUcECIMHQY+ZFDX5nxll9d5zVOnCS0nle7tHQ8dGO5MK0QGdQOu1Cd9YbYxJ9RpaAlY3xHP3Wm+Y7bK1dUo88fmJ8LSKVOADJKorFUr9iwBZ8Ui4Vwx+EZ66JUNoEM0//0QRzkPCCdLq+2tN5bA+n8d9sfaEooVtG5+fH838DzU3T4QHsjL8HGQu6627edHiS1/g21+/VR5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(5660300002)(6486002)(6916009)(7416002)(316002)(8936002)(66556008)(66476007)(66946007)(8676002)(4326008)(478600001)(1076003)(6512007)(9686003)(2906002)(186003)(41300700001)(52116002)(53546011)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BQixmHm78hwc5gQrHXqFdqKb2GfBfT7Tc2Of6OmvLVYQVRV3eCpsMDmLjPXQ?=
 =?us-ascii?Q?8FiRhRJ7OpNS4rOh7AslW6WFhSr9uP42YCynrahK8bfZajNmb9I9mLQWR45C?=
 =?us-ascii?Q?oIoPn4QJIphcOaiC+prJJW0XhsKTvnNnHo0v/tSBmhn52bbvC0bsK3gE2U2m?=
 =?us-ascii?Q?5Et9TY74Ah9X+onJh9Qo+rvbWpGy8H4VVIG4PMuonpSSZaaLuwl9nYEJ7G/R?=
 =?us-ascii?Q?xrr1lZHdSssVDMu52YIbuIOM3pQ0HDGZSSKIJV9gg06IhRYpes61jgJDjIfS?=
 =?us-ascii?Q?h7Y4IA79pokrGJSoYy9OMXP59+no1xIGoWf0UZum236z0OkN/4thBmU4MhXU?=
 =?us-ascii?Q?PQEvLcQ+rDWwKqDjk3vzOf3fvh26jRqjHBlslLZG5VSoGXV1a4fWSOPTkIfW?=
 =?us-ascii?Q?uqutvEYqTnHpMfSBPQZpAKW5mU3XeOB0z4Qtp/l9CyreMfTxtaS35inz0dqO?=
 =?us-ascii?Q?aRzI/0iNjJeKq/NxV9ZSuQT6KJJTxbhyK3cgh+uBe/pVYJbizrCIXyteWYaz?=
 =?us-ascii?Q?3Q4zc1YmY+1uckhqn4ZBTInEeJ7Zeh1rXT0+lSVk/IcaCG0O9p45IHZIrbjj?=
 =?us-ascii?Q?URZw3iizHV22BDy8d9t5vrkF24ro4WsFEvV53Bvf1x/yc3dfNbnmIqn7cASJ?=
 =?us-ascii?Q?ZR/gndCLTSNn6YQyf9tjKrV/smCzo0YMt6mBtL3gXLXvvGXw0EOUb8PcamAh?=
 =?us-ascii?Q?UCk939ehIRx2KOc6FkQpwPG8MvGQNjvMUMm99cCUT818mzLLjigqbOeQrP/M?=
 =?us-ascii?Q?Fg0AIroHtZK1u4PyWPpdEwOj5/8fS4MdTGpjJ2jBekGQPXEjsmFJEcLTBo0F?=
 =?us-ascii?Q?nTxKxaf3ORo4FJf1DPpQ+VjhfdJUHqYXTigOm08kjMdwZGaLT0IrXTEONtwE?=
 =?us-ascii?Q?LI12XExuomm0skWNNkMx4JrJIU9uWjyzxralnLSvBy6k14xKqkkw1097g/XD?=
 =?us-ascii?Q?oL4eJKWNh+9eAjHpFk8YfM7nigh78oCbwkPqAcG53neMwWPZ8F1l0ilpWW9c?=
 =?us-ascii?Q?TW13P8lBr5uuH1JCfWQ+uhnuWt5c2DFZ2Qf8nilkJgtMzIdD26+Ywh4AmnZy?=
 =?us-ascii?Q?zXY84TWShMb/jAQn/QVsX9rqw0Et+5gWwzvhwGz3yRVBogmy9fA7ltfK6t3f?=
 =?us-ascii?Q?XxLAw24+jhaERJpJYhz2E/6Lc2tZZY6TZAvMnJsfIO5ZXMzjl4317UPhpiw0?=
 =?us-ascii?Q?DMYT+m8d/U41U9ab8szLrc8U2mFM9wlPmdV2mWOcWPsvty5CtfgLw5hUAnml?=
 =?us-ascii?Q?PuYKAUqPYYmTLKUITraxq+T8v8mg7wggUAL2OR7zP4GJKJQd54fx3koXlOAy?=
 =?us-ascii?Q?2vBEU4m8bGvNZvaE22DSYoGY0Y8iqPkSKroEW/Upw0ubEz3sOI7xmgyLplSO?=
 =?us-ascii?Q?Gas5leOTNb9eZNshbqyJjYIuUbTfONd4clPhvuzk71rRm1RA0aC9wJUlcxtq?=
 =?us-ascii?Q?4eyqGdwIXM5nuAlD20MtoH74sEXw+xxVVqkI2UQfxSugwfAgfaRutvfNeVyZ?=
 =?us-ascii?Q?Xzo3QwLBp8VRPySwj0APzdY/hKkxPkkEozB5ho48gtmKOKNHKVT4okK66wIe?=
 =?us-ascii?Q?bq1ZrRxnyYDbLsTRcdjDGoQj0k++LI8egsjnB0cNQNjM06rdMWmvfYGD6k2X?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7379b4-41c4-4726-a2b7-08da73f7baf8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 19:55:05.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZuPs0cfO757n0qYUBgAYP1N2YDhp//gowseVeMTClkD7WTXEwVfzf5PX3Q1av8+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3187
X-Proofpoint-ORIG-GUID: ApMUD1eZjV5c1kD9SCZ9Qpn9aDS1kueV
X-Proofpoint-GUID: ApMUD1eZjV5c1kD9SCZ9Qpn9aDS1kueV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_10,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 01, 2022 at 11:23:56AM -0700, Stanislav Fomichev wrote:
> On Mon, Aug 1, 2022 at 10:45 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Fri, Jul 29, 2022 at 05:08:09PM -0700, Stanislav Fomichev wrote:
> > > Apparently, no existing selftest covers it. Add a new one where
> > > we load cgroup/bind4 program and attach fentry to it.
> > > Calling bpf_obj_get_info_by_fd on the fentry program
> > > should return non-zero btf_id/btf_obj_id instead of crashing the kernel.
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > ---
> > >  .../selftests/bpf/prog_tests/attach_to_bpf.c  | 109 ++++++++++++++++++
> > >  .../selftests/bpf/progs/attach_to_bpf.c       |  12 ++
> > >  2 files changed, 121 insertions(+)
> > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> > >  create mode 100644 tools/testing/selftests/bpf/progs/attach_to_bpf.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> > > new file mode 100644
> > > index 000000000000..fcf726c5ff0f
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/attach_to_bpf.c
> > > @@ -0,0 +1,109 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +#define _GNU_SOURCE
> > > +#include <stdlib.h>
> > > +#include <bpf/btf.h>
> > > +#include <test_progs.h>
> > > +#include <network_helpers.h>
> > > +#include "attach_to_bpf.skel.h"
> > > +
> > > +char bpf_log_buf[BPF_LOG_BUF_SIZE];
> > static
> 
> Will remove bpf_log_buf. Sent v2 too soon :-(
> 
> > > +
> > > +static int find_prog_btf_id(const char *name, __u32 attach_prog_fd)
> > > +{
> > > +     struct bpf_prog_info info = {};
> > > +     __u32 info_len = sizeof(info);
> > > +     struct btf *btf;
> > > +     int err;
> > > +
> > > +     err = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     if (!info.btf_id)
> > > +             return -EINVAL;
> > > +
> > > +     btf = btf__load_from_kernel_by_id(info.btf_id);
> > > +     err = libbpf_get_error(btf);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     err = btf__find_by_name_kind(btf, name, BTF_KIND_FUNC);
> > > +     btf__free(btf);
> > > +     if (err <= 0)
> > > +             return err;
> > > +
> > > +     return err;
> > > +}
> > > +
> > > +int load_fentry(int attach_prog_fd, int attach_btf_id)
> > static
> 
> Thx!
> 
> > > +{
> > > +     LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > > +                 .expected_attach_type = BPF_TRACE_FENTRY,
> > > +                 .attach_prog_fd = attach_prog_fd,
> > > +                 .attach_btf_id = attach_btf_id,
> > > +                 .log_buf = bpf_log_buf,
> > > +                 .log_size = sizeof(bpf_log_buf),
> > > +     );
> > > +     struct bpf_insn insns[] = {
> > > +             BPF_MOV64_IMM(BPF_REG_0, 0),
> > > +             BPF_EXIT_INSN(),
> > > +     };
> > > +     int ret;
> > > +
> > > +     ret = bpf_prog_load(BPF_PROG_TYPE_TRACING,
> > > +                         "bind4_fentry",
> > > +                         "GPL",
> > > +                         insns,
> > > +                         ARRAY_SIZE(insns),
> > > +                         &opts);
> > > +     if (ret)
> > > +             printf("verifier log: %s\n", bpf_log_buf);
> > If this fentry prog is in the attach_to_bpf.c and load by skel, this printf
> > and the bpf_log_buf can go away.  I wonder if it can use the '?' like
> > SEC("?cgroup/bind4") and SEC("?fentry").  Then opens attach_to_bpf.skel.h
> > twice and use bpf_program__set_autoload() to load individual program .
> 
> Good ideal, let me try to see if doing "?fentry" is easier..
> (unless we agree to keep load_fentry, see below)
> 
> > Another option could be to reuse the progs/bind4_prog.c and directly
> > put the fentry program in the attach_to_bpf.c.
> >
> > btw, this test feels like something that could be a few line
> > addition to the test_fexit_bpf2bpf_common() in fexit_bpf2bpf.c.
> > Adding one to test fentry into a cgroup bpf prog is also good.
> > No strong opinion here also.
> 
> I was trying to reuse fexit_bpf2bpf initially but I sank too much time
> into it and decided that it might be easier to write a
> simpler/separate reproducer instead :-(
> How about we reuse progs/bind4_prog.c and keep load_fentry() ? And put
> this new test in fexit_bpf2bpf.c ?
Reusing bind4_prog.c sounds good.  Either use bind4_prog.c in the
new prog_tests/attach_to_bpf.c (likely need a better name) or the
fexit_bpf2bpf.c is fine.  Whatever makes more sense.
I was mostly thinking to avoid the special verifier log buf handling and
the printf here.  If an empty fentry prog may look weird, may be just
skip the bpf_log_buf and printf since it will never fail and keep the
load_fentry ?
