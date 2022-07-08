Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CAC56C0DA
	for <lists+bpf@lfdr.de>; Fri,  8 Jul 2022 20:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiGHR7t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jul 2022 13:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbiGHR7t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jul 2022 13:59:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADD41EC5E
        for <bpf@vger.kernel.org>; Fri,  8 Jul 2022 10:59:47 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 268HAXrh025065;
        Fri, 8 Jul 2022 10:59:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=v5MhMPwmWNmHMSkRh3zshCIx65+buERiWgZMGTzlvRM=;
 b=OCVkVy+kZuBk7MeXLSEm241uHpfgOX1JPmEoOFRVOv0GQr95GXwPxoDEwwPReWEAUmx1
 MtGCXrqkN6LXk0cJZLPM6A9uBrFKbhfytMiEFtPZHkcr9Yt1eMpqp5bbG5+It4OgI4o8
 cCXIHCE5zsUav2dL/UuHKqI8yB+Na3VftvQ= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h5y1dj32n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 10:59:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDueD3EFC6K29daRNA98TZn4YfiebmTkumitq4HVhL3XPbQ7LZBVWZJMO2tKY+2qV0/vJoB4X7giaSfd4lUBdNchBpqqODImaYtcB1O/ygmutkfDIEEk05Z1k/EI0Ga1AMCIrl8MkJzF9Jj5gTd9PsmmfSCrBX0ekbe4qFYsnhWN2h7cDEnBx0SGQ0RZVUaz1b0xScyygeepRDairkTiFjyfajHqZefdlYuHLEpqxIBDUc+ehxBIMVhRYq3sTPzA4+tgwxoIOhTVJ2oLAkX+SzHvQWrsfJ/XkMe00LUuW2JIzs+XxJjeenBycZHC2JDeu1EHJQH/FIGFkvqud8UeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5MhMPwmWNmHMSkRh3zshCIx65+buERiWgZMGTzlvRM=;
 b=ZGMLfpRYdSaa/NBTZaiokqdqO4fkj5qQXVefuiBE8FlIALuuHVShrPya93fiXN0LZ6E7Rx7hoz/t4lZca76sHj+MW3d50BRanRgtpUqfT65mCICjrkx4TaeYhGHAbBGlB6qVHPztHQzkzjZvBULLtZ+2s61YyllHsr9koVEbwe81EY+6R/LGZ6j5o+ZW+YN/FuAs5bRSyBdBZ6qx5g2W55f4NzVNwq90VwuUHq7wONvtEvCKsXbiFG9On2Ooi86DxojLxc4gM1/2q/R/XEWxlDyCMEfv8LS2WlDCEGB1Ixy2T16QBQogs1V0MK5SPzpxzusSiqNB2FEGh0jigwiubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN6PR15MB1329.namprd15.prod.outlook.com (2603:10b6:404:f2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 17:59:25 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%6]) with mapi id 15.20.5395.021; Fri, 8 Jul 2022
 17:59:25 +0000
Date:   Fri, 8 Jul 2022 10:59:22 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        syzbot+5cc0730bd4b4d2c5f152@syzkaller.appspotmail.com
Subject: Re: [PATCH bpf-next v3] bpf: check attach_func_proto more carefully
 in check_return_code
Message-ID: <20220708175922.pwk3wqbfm5l5idfv@kafai-mbp.dhcp.thefacebook.com>
References: <20220708175000.2603078-1-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708175000.2603078-1-sdf@google.com>
X-ClientProxiedBy: BYAPR01CA0049.prod.exchangelabs.com (2603:10b6:a03:94::26)
 To MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46741b9f-4599-4c5c-7032-08da610b97ee
X-MS-TrafficTypeDiagnostic: BN6PR15MB1329:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9wOvT1fEBN42KXK2+KaKaAUJw4edVgI26KZYmzY4wC/DoHnrUSoxZ3z1eNLdPcKu/nF12ZEl3NiZq+cfC/m6NZuw2qLXNampnZt/7CQK/TrWP0/UChbNkp57h9ZvwX8sSNVltEi0fsoyaAAUlyce/BCcwsfhQ0VLEpgAIOBDCLo+arB2HoLWBLgJBiOWDmFqEo+AGCVJVCDu/pzC80oNYhVd2Ayqi1qMDmUdTaBvMkRxkwAaUfgdxJXb0D3S4enI8vIFSfXFSF95wTMVU+mqE8JAEAMfTxWWAZRmsN1RibXOPoXtRN/U/5lgAErBjBqKXoCVGXVS8rjzm/LAP1F5nyAwT1mcDWvq4hs4ujKVwYV1Nb8MlphxYS6vSJnt441MKQ7BY6VUz4jbBVcz2u0Nb3acIS1bOqX56W51/NQ9mlUyUYUxONb5yxKc0KigXCwpIB4WvOD4grnZbzFCo4NLxFdz2sUqhMAeDw4ln++/mdzxXQmLRSBjXE6qf1f2bH9G00/10YYwGliGGX+13cwYzrAwvEBiN9dxlAoJfwLNVyGutOGX1n0nVAr33m7B5RmHVh1T5oikg/asGXRj/mhOXUp1M0rjmmBFH4blS1W1BpR+6Ds/V7VaOWJri+XLuruIvAVZRuifmMLi0W5ERaJJgSdR13YNaQ0NAV3q/GDYGGMRjGrSZgRhle/BWlwU5Mwy8TuaH+P01Xj1MBKfasgGUOn+ZbZ64qj1rYMTlchqvRwjzOCW3sG835zkosQ0Fch
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(38100700002)(186003)(83380400001)(8676002)(66556008)(66946007)(66476007)(316002)(4326008)(6916009)(6512007)(9686003)(8936002)(2906002)(6486002)(52116002)(41300700001)(478600001)(6666004)(86362001)(6506007)(5660300002)(1076003)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LxLRNm2857zw9HXyjUdMTOLr7scJbD7qHjs++1LnQ19ojhQwlDfvrt9wZvWi?=
 =?us-ascii?Q?B0UmN4oXVJf2Rwmky7Clv0ODWgml+htovA+ss9tE41dYBMQDlOV4Itt1ZMF4?=
 =?us-ascii?Q?4z+31wwfkYf56Gamx6I7Er8QGrug4UGQ7pVRqDAA9HlIqqy9dXGt/Y+nUi1a?=
 =?us-ascii?Q?I4n85b9k9QGt4nbeBmCLHnnfaLybWnXFEH2tvrA0Q8O+DkA4CHfy/UKnI5Cs?=
 =?us-ascii?Q?1ULcTM3Jkd9aCpJjZU7uTgFSbG2/31wwv+lzCSJ0dElfBuY5qXuxsQjhSIn5?=
 =?us-ascii?Q?lBfqPKSfOFP5itAQVH/kf42TS+MQvcZxyxGsk6XZePdOWS4u3suKM5vb4f0G?=
 =?us-ascii?Q?0ZTBXil6nEECvjT3fro6Og5oOvk4pajT1j98yXnnko6pg1JzZBM4Ns4boYK2?=
 =?us-ascii?Q?RJfUObVwwi7L5pw8aQ/y7NScuCm7u0i0+Ppdx/+vFDjfMkdIDvkVp5I5jUxX?=
 =?us-ascii?Q?tmyYDwyPq8bDHUvq9YnX86bzlu3WvsgTVjy08pWVGRO9ziVt/ZUMKxlrCLu9?=
 =?us-ascii?Q?sy4ge+8rQu8itQ0NbVfSNnfZasX+71sX5fTR+8ZKT+PU7ZQGr7H8JixmnoGG?=
 =?us-ascii?Q?kpr5V2RVfdWvOfFLhzeIQqcp3zb46zBB04wLzd4psr9kRkFPxZLvx8V3FvTG?=
 =?us-ascii?Q?L/aty6WCKXczbxCjLYXokPkVoAfFwycWv15MDEjEiX5KFWtoTnTchv7HiOlR?=
 =?us-ascii?Q?28PKvysSM+9WjTr2UzXJh59ofv5OefVhUoB1TUcBb9+0vLRVy2M0YAg1cV/+?=
 =?us-ascii?Q?azmHpiaVFwkI9JLEUe3Aso9KEEJKUwXGsOLpnCcbJ6JXKcO8wlfRWjSI85ij?=
 =?us-ascii?Q?AArpNkKxvZfdYdVhEltFH27jSdQBAzD1ZfK87XHRdJoy1aYIiadNlFzSrNEN?=
 =?us-ascii?Q?89sKMOQHsXgKMaMyfrbMNFIcjIpa8EZYxdGV7pYaENvSRupB8wwbNvr4VOUw?=
 =?us-ascii?Q?Kd4ITRuAJ8PedL0k+PwIzuIjy1V8ovW7YY/GG6nuEJc/yzUcO7rqafrjARj3?=
 =?us-ascii?Q?lkGIIzL1dwqmy5P4xyK4ukBZ/fCNFARMy1s2NuYGFEWcwd1Wbkl2pekh7Gg0?=
 =?us-ascii?Q?Pk5HVIQa0AJ/HQV0NUVRYeqAXeZo1+krkZ9lhThdph++xQ+VmlI9ti/bw+CL?=
 =?us-ascii?Q?nptg/zmulOzkWoZm4EQ8cC2ZLWRlCiBNZnkYqtLHEDnFQwH58bMfEV08xHv9?=
 =?us-ascii?Q?vIHdAJGc3XAVUGsoouAEs5EJodEyREXhqwkCkgQj6MHFQO1OA9lRCkiHVHuh?=
 =?us-ascii?Q?bPT0pW/ZQAUeUqflkIF78qHZZgI8OPzMfzEUvP5kzGSQ/zxjCRRZcXLkGq7a?=
 =?us-ascii?Q?uvjAfgTe/PScmAUx4MZbwGVjR3uTWnYLADcG0qw9AkR1Ifp/PaF8bpoHJIwm?=
 =?us-ascii?Q?PYTMb1l3aHp3zD3EGLbHj/m9fP5vli4F+YvGRbAv2Jq08kdPSYtZLnpa1YOk?=
 =?us-ascii?Q?bw7BpC97rrZQIronWlgsAIE/XrjMPSYUp+BW3Z+m01SuJ+5ro4nBp4kV1hh6?=
 =?us-ascii?Q?9P9WloLPMyOz74FXgFzpqf7/R4ENrzY3yJq4/gCkAGggu0eebfs2TZzMASR6?=
 =?us-ascii?Q?4+yk/IfcLNVE8qn4AgT+zqmG21J5NjAhwF+bsotkAwV9tjH7mhyTPbNes5R8?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46741b9f-4599-4c5c-7032-08da610b97ee
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 17:59:24.9741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMXvdHudxlWb7GGdBHnmNUBoCcG0UI2lSAEpOQUojyTL/h7lgds1iHsd/qkQ4Zcw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1329
X-Proofpoint-GUID: slpuqTHCsBNoGHkLnip8K-wm26loGg-t
X-Proofpoint-ORIG-GUID: slpuqTHCsBNoGHkLnip8K-wm26loGg-t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_14,2022-07-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 08, 2022 at 10:50:00AM -0700, Stanislav Fomichev wrote:
> Syzkaller reports the following crash:
> RIP: 0010:check_return_code kernel/bpf/verifier.c:10575 [inline]
> RIP: 0010:do_check kernel/bpf/verifier.c:12346 [inline]
> RIP: 0010:do_check_common+0xb3d2/0xd250 kernel/bpf/verifier.c:14610
> 
> With the following reproducer:
> bpf$PROG_LOAD_XDP(0x5, &(0x7f00000004c0)={0xd, 0x3, &(0x7f0000000000)=ANY=[@ANYBLOB="1800000000000019000000000000000095"], &(0x7f0000000300)='GPL\x00', 0x0, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, 0x2b, 0xffffffffffffffff, 0x8, 0x0, 0x0, 0x10, 0x0}, 0x80)
> 
> Because we don't enforce expected_attach_type for XDP programs,
> we end up in hitting 'if (prog->expected_attach_type == BPF_LSM_CGROUP'
> part in check_return_code and follow up with testing
> `prog->aux->attach_func_proto->type`, but `prog->aux->attach_func_proto`
> is NULL.
> 
> Add explicit prog_type check for the "Note, BPF_LSM_CGROUP that
> attach ..." condition. Also, don't skip return code check for
> LSM/STRUCT_OPS.
> 
> The above actually brings an issue with existing selftest which
> tries to return EPERM from void inet_csk_clone. Fix the
> test (and move called_socket_clone to make sure it's not
> incremented in case of an error) and add a new one to explicitly
> verify this condition.
Acked-by: Martin KaFai Lau <kafai@fb.com>
