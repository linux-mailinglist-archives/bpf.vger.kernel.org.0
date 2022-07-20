Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B557BD93
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 20:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiGTSSi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiGTSSh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 14:18:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F91A61D95
        for <bpf@vger.kernel.org>; Wed, 20 Jul 2022 11:18:36 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KHij6b016150;
        Wed, 20 Jul 2022 11:18:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rKK3td8lJ9WC0doTlMWUOv+aISFcYGUIQF1n0jbM56A=;
 b=MaQNbeOUL/TgkOmhAV5qNIuIUCYzfEKBU7cxiO8UQR9+ty1VhDEy+UGEuGyaOHVpqKs5
 hJIdDYl8vdHsoEmkWtOgT/YAsu6F2Q253EqZsSHUzHgUQaS8dH+Fs4gOkPqYkXS60Umq
 MAJscJ1IXPksYyXiFoUrM36rkaY4rXkBVS4= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3henhb0p14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 11:18:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yddf8RXEXJSJNxLn3M1ds/7lv6LS4Kr0iat7KC3dTDFcB1www+BgOGZBSDMIZ+uOQakQEPJIsY3coyyRvDao63WpgTOGVOMvdBFe/NsbivvxdZDs3V1oSYI68O/KQlnEZNPMAR42U1XpnTy3D6ScU22vgvuJVCdxt9gQgL7I+0XTjkWIGkqWloQ1ahGiN4Xw+LXGB3axPAAm+7sslNsXIBDqE+2rSDhMc8HLCF3oY7arg1pe1uQQEZ9KXcR4JUY5pfr4YzOARUhwwJIWAs2+hagCPKCJS/hkN7+Cnif5guWKFpuiGEhLcWdz8Pzfg3fNwKk28TpUXJQqd6jpbhEwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKK3td8lJ9WC0doTlMWUOv+aISFcYGUIQF1n0jbM56A=;
 b=Nw56scNdTaI3Y02wlWOtex2kE++9O+u5vmRup/Q1wOq/POG3Imt4N7QBIg9Fz5pmbBaV2h7+uU2zjiQ72DPF5vs4ONARVhdrlMgW56aHWdZaMEPMow/u6prY0lcDZCqsOEG3thh2enBWA8sa2iGkuQJXBq7owbXx1EpLeLHEpRfJ24lZQ/cxrscONp1KkL7Prdg1/SMBgNraZ79ffzY55tgFZ8amOOJlnDQ2h5jf5tuOmmoBYmugiLpczZMYn+oweOJXUUYYw6sYLL1DJgWLCnHGypu7u+g1hVf2jO8X/TLUEDsJOg65XPX84c6Qgeilcm0iQYy1IkEbJxZrrMuFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM6PR15MB3387.namprd15.prod.outlook.com (2603:10b6:5:16d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 20 Jul
 2022 18:18:00 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%8]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 18:18:00 +0000
Date:   Wed, 20 Jul 2022 11:17:58 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH bpf-next v2] bpf: fix
 bpf_trampoline_{,un}link_cgroup_shim ifdef guards
Message-ID: <20220720181758.3vrihdn2bdxlnbn3@kafai-mbp.dhcp.thefacebook.com>
References: <20220720155220.4087433-1-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720155220.4087433-1-sdf@google.com>
X-ClientProxiedBy: SJ0PR05CA0204.namprd05.prod.outlook.com
 (2603:10b6:a03:330::29) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d9fd460-50c7-43f6-0f23-08da6a7c2da3
X-MS-TrafficTypeDiagnostic: DM6PR15MB3387:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuWRh6fFVsKRN5lZN16re8571vQstSipP/nqH/lKh79tn6vgu3KCiiMWFSIy0YAb2VBNVFCDhBOh507XQAxHPDDyjrB2EfGa5tbSI3tBo4FfOoyWVx83tSiWFYiydu93RVgr2zQtXwzUCkOu4zcf4eQ0mbUsjTT48OK/uqz8FkwNZblJG0XgLOYkXN+1JfVJC5s4A8WrC7hCxJ4L/wf56r21yzYrozuobmskmT9KNcFf7pb5i8aCHwEZUDsxARBzO2Mh5eFDXNeXyVieYelesu6sK9YTE1MEL/85VJ40RvUiCVQaB9HImf1jRFUNiEZpzisJ51I59dY044nD5XvdN9Zx8NBr1/Qs82HFbK+CccdgrvsBh5OoXNXin8BjGJ5KVqcAls3X7SSbqzZRKZVt67DCGOZb2Ij7Fd8aHCkcfhIx8iafbpy7u1PuPfTiGF2YF5ctH+uzyHQUSMzHkvrQxXuNsLfUcmnDQ3oDqEcMvj8ADMUtM8S63MEQ0FFGyDRAbISyW+Fvh6aVhDRkI7DTTItuOp4/h2q4Wy94VxwUdntD2szL+nkvXD1cERff1uPCh9oTmwDc/5JAYk8Ygr88JUbd9grWMM0QNmCD1KA+zfD2p9arzf1mO6yvGLJT1EfGkCqOSrZ5oLsTaACJ3OOiI8KmRzyor5luj7aj5zhQ+RLcVXF4iRcOsWlYRdDEfZPzDBdUECaxaH4YWl7MnAyV80UatfmwO5V5l35JNlAOR8Dhv4c8c3qU5dINaEIwkGmt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(478600001)(9686003)(6512007)(52116002)(6486002)(41300700001)(6506007)(38100700002)(5660300002)(4744005)(2906002)(7416002)(66946007)(66476007)(66556008)(8936002)(1076003)(6916009)(83380400001)(186003)(316002)(8676002)(4326008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i3BbRgLwDdZj+BZ5U88fzL+RU7WOgRUhx/K3xsDDW4CEwVHjnfv5tJXseboa?=
 =?us-ascii?Q?lGvbWP/I+Ek91Aaz2qDyTlmEKJUwoxN7vS2AIO1RVxr4/KdjZMzq8OJY4dAq?=
 =?us-ascii?Q?uL7nyTyxZzRtenvYEuM1bkycioHlgkXavv2hktF9oMPmIIL38yd7e8MEDOSG?=
 =?us-ascii?Q?Vz8SjPM+UcebPzHnJsnybFrN3X8OEsz7RkYLUPoBe7h2AX+Ve++PR5TXj7x/?=
 =?us-ascii?Q?ssih8pw6l49yeFhkG+z0e+UTOKRvBU8xgIh+7PjH7gOk9g2xbCwRiNR/TAFx?=
 =?us-ascii?Q?LstEJiXalMMWW5FAEX0bXQ6uT2YkCmWlEUwI15HEAZZ6UOzFAJaAGhc+h3q0?=
 =?us-ascii?Q?YIvlNTbw0l6jdDdFHheMeJQfK5mOzZLMoDPL0UPTT6o+ya/EJB/m0ZEXqjUN?=
 =?us-ascii?Q?fycJAXQ3CiGJhAwtBFdO68gncvScwpSUxz9FwqtoUpOs2260V78zjvrccubD?=
 =?us-ascii?Q?9tltefi4cmh0GqGV/V2e+9As0ywQWBcnYowwC0VyTey4jwBVNfYfQzX8rw44?=
 =?us-ascii?Q?gKRoUVqX90SKI0d5r8HAEE7xLm3WxLaXhnmQtCGW16seHKeCOXM+qEBuTVgG?=
 =?us-ascii?Q?dwueyYUKl1w9p7CCAQ341BB8Z4MPUaTxy6YmEa9xBba6WuvV9jPSICU/HhNY?=
 =?us-ascii?Q?MgG7ji+qjXuW8LIvCn1F+X2N7LHNsLK/TSv0kJw4WWk5zpDrLcHEn4Y5tlsV?=
 =?us-ascii?Q?NORIHTINKd/64JXCbrCnqbmu5vjIjEtStYpHAKlcsgXHDS38NHH+w3aHwX8k?=
 =?us-ascii?Q?WG8BS5OCIWtURScNBwvPj/rw8arh3FVmD0GzeJnhtsGpXjRWc+zbsntyiaIE?=
 =?us-ascii?Q?gullq8uRPzbqlov7pcSPp91eI6W8eqwrasP2Zt09I4GMaoVN1pLjerWXtkPg?=
 =?us-ascii?Q?gGYuannFzqRULiDIDDj3tVh10NTWXdgpeQc7SDPW/vQqgmQECEKSxR7fZmhi?=
 =?us-ascii?Q?FalJauaNV0rgT7cqRT4ux6ivIzPReTwlA0bjfEgH79iouXo51sPjYS8qJ+yL?=
 =?us-ascii?Q?fKL01W0H+EZgTvpw149RBzrD+M41IlhCMPKqnKn8WDLLhDNIdXM16x+F93qX?=
 =?us-ascii?Q?YnPIy0AJGtfIF0+Syanpnnbc0Vc7KQZTi6aIgiZEMQ6yxP43kMo7T4wXIP++?=
 =?us-ascii?Q?UPeuErqKtLRvOfT3bRs0F27oELyIeMQZJr44OWiHpM4wEgVXBPeLZ13X6ksi?=
 =?us-ascii?Q?CCYEs4QfnDU0wij8xRx8JKeQqT+K/A/uoNCJkTsc9Rgoj6EMBWTSBoA+H72J?=
 =?us-ascii?Q?BiACNk4iNjALwLkjMkMxujiIi0E0V6lXAa+yG/FSxpVhcw3aW3ZCignRfhLa?=
 =?us-ascii?Q?KP4GW5KYZ1fVcB/4wgxqG9MNAV5xR4aRoOH3OhCbhy3gLdnUcp4cUPRtuhuC?=
 =?us-ascii?Q?9dh6arf0we/CThBBYYYa93tlOACN5ststDSLuKk9ONbaMGTiWXeXbWHx59vJ?=
 =?us-ascii?Q?V7hRonqymRbbn9jGA9tZL7IvsidY3sYeUF8hN9C5VeThL5EEpseirmy7lRke?=
 =?us-ascii?Q?Pdwtf8x9wc3JbbImq36DSn8gGlNkM6S4aq29q6zhUK8dBctzmo4wq0tquAAj?=
 =?us-ascii?Q?q8oo5ViNtzr/U8DflDZFUSEGXoN86iFoYhYaTknNMSBk6ucRj+jOqpTXIqTN?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9fd460-50c7-43f6-0f23-08da6a7c2da3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 18:18:00.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVbwI4jXBsPtYTbpFMO7s9PAc9JVTTr/5aB9LyneFqcGkUIkotC1m+bqaUTfFrej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3387
X-Proofpoint-GUID: SIi0g3_RO3xSQp522QaNE4BMbCj2hDCW
X-Proofpoint-ORIG-GUID: SIi0g3_RO3xSQp522QaNE4BMbCj2hDCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 20, 2022 at 08:52:20AM -0700, Stanislav Fomichev wrote:
> They were updated in kernel/bpf/trampoline.c to fix another build
> issue. We should to do the same for include/linux/bpf.h header.
> 
> v2:
> - Martin: bpf_trampoline_link_cgroup_shim should be fixed as well
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 3908fcddc65d ("bpf: fix lsm_cgroup build errors on esoteric configs")
Acked-by: Martin KaFai Lau <kafai@fb.com>
