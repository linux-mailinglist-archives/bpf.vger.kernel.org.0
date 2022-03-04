Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219AD4CE02C
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 23:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiCDWUB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 17:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCDWUB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 17:20:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D38C1BEB7
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 14:19:12 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 224HRChM018663;
        Fri, 4 Mar 2022 14:18:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Og/kho3Ss87W80hGb7LuO1k7lrgu78eaM3QTQyTPLqA=;
 b=ft4NfNFNU4LPCbc8DWjqq3+kr1i5ENktsqnu/JG6gwUa6JV/+yU/Vmbw7VY7NFqj3YiN
 DHxfWDh1IPhXsP+Fn2/0DCJSLJHC2YXEOaJYAHBToLpwgAjQ5JycEtptV2SxR4uy78+o
 SMiFj+8RjhIkarJRpA2FTK8mGJgpIuF2oSE= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ek4j40kua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 14:18:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgG4nZRLyZFOVX9o+IWFGUnBlW5/vAgf5VQCX9LbA+ipdz4vnBBqq1n8qayjcZlxgsk7OyhkHjmuMqq5kp1iopPLzEbLtZu/sH81e68cGJTI5T6jaVYCbPYXgxdyfykrvWNpQfhqe2OkUQq7OoMLgZKQUwbkBBr+CoMTTCuuffL6t0KQ19HoHgfpugcnndzfFDphyFXSwEcVl9J92BvaCZrOFVDGxEAB2qxCXPc3VFFpQ0Ps1qLUuA9kgQ6H2vaAs3imQr1eNve9gpWCeQTlAH7Kl4RFBFS/XEhU6jhseKBqgaXQiXJQ9WWLuFRRbqFRgSWrvcLUDz5L6CX8dEwLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og/kho3Ss87W80hGb7LuO1k7lrgu78eaM3QTQyTPLqA=;
 b=KhTkVwYTe14h08JXZgyLE7//QwNxMWSecbynC2yJzqNZsNs1S7fHj+NC0KpipGsiET1/eOJl3Y2LAduKMf58SzITfUwYeb+Ag9nqfKhcxAw/W5qG1GAD8xcTIzQ43TZDyklZIQC1zRQdrc33yteVoiUnBJXmBSACWi7zCYBOJZHO6nMz/zrLhD0D9uU9wJnqR51lQTurL9CLFg15iUZMcR3hMCvBpHmyjH2GfmGjEK6RBi/omY1UJv2LMr+oXOPswRY/rTJOexij8xzCldDo2V6ruWOlZw0y42Gq336IVwxRXfivhQiyTn2443Ldh70uBzl96xck4f5SvLtWnHNipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BN6PR15MB1393.namprd15.prod.outlook.com (2603:10b6:404:c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 22:18:55 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::1d2d:7a0f:fa57:cbdd%7]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 22:18:55 +0000
Date:   Fri, 4 Mar 2022 14:18:52 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next v3 4/8] bpf: Harden register offset checks for
 release helpers and kfuncs
Message-ID: <20220304221852.gjaey2y4oztsztjj@kafai-mbp.dhcp.thefacebook.com>
References: <20220304000508.2904128-1-memxor@gmail.com>
 <20220304000508.2904128-5-memxor@gmail.com>
 <20220304202830.4zgw6h5ulddx3zns@kafai-mbp.dhcp.thefacebook.com>
 <20220304204856.7pplkvhl57sxtnwz@apollo.legion>
 <20220304214333.5f3yzrhghmqf7rkd@kafai-mbp.dhcp.thefacebook.com>
 <20220304215556.2x2frcep5bebe7ch@apollo.legion>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304215556.2x2frcep5bebe7ch@apollo.legion>
X-ClientProxiedBy: MWHPR10CA0009.namprd10.prod.outlook.com (2603:10b6:301::19)
 To SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 655281ee-c78f-4c1b-352a-08d9fe2cf8a9
X-MS-TrafficTypeDiagnostic: BN6PR15MB1393:EE_
X-Microsoft-Antispam-PRVS: <BN6PR15MB13931E7A667EE5946FF254E4D5059@BN6PR15MB1393.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OH6wXh5z7EgeMpF7NwiOAxgJv0Wp/KwvZ/EuOpKmrnQvkDAL7s8EK8n7MChW7UstXr4/trs2uSXyGeiXSf/4irbXeIXlXPI4smQ2Q29wE9TbQnE8LRW/IGPGDGsC/I7Id37oD1xZApeWXYp3k1ZJC88YNiWB4HeMOpjicIBQubnucCMM9Nq9VZMZGPpjboCuLUjzE1dD+NdeukSL3awanKi5meLiSoUv78b8K/aPGLCzLAxxSJm1kzQIjgbmwsQXtpXyfAJmGyCwovCmBMFXecYLssv3ddqPHbu651JTompkePIFeohpd+bdTjV4D+0pcMkuzaAxLaX4sFWFV/WDbtt2usMZd6vOTxiesfx1kmYT9y4sPQBeC8Q97mqRLEa1rII4ZYpN42GuSZ3eaYmSx1b91KI6uOdKX3dSUNRgsJocBHgyUMqG+qK9bfdGFAnpWnTZqhIfl7E74cGiGwO52Q84qPnFAutk+b3dJkTbr4objSOndmkEdSekVdPNXNXsixwqZjJON4DjYlHxJmNLNaAw4MnEeqC9I1d2iC62s4qKXeHTGycMqLlmXaJOHAJNNMS5XZ5Ebslplx9XWtDO7yXXIP7DlCgt3hZpjGUrr40KFulCeOokjqKlmm7kKLnggBqSOP3VWPjjStmx4qwL0tzPUEaVDdvvn4qEYxT6JpfwjFe8hn5/xgq8IO1Y5u0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(38100700002)(6506007)(6666004)(6512007)(9686003)(1076003)(8936002)(6486002)(52116002)(6916009)(54906003)(316002)(2906002)(508600001)(5660300002)(86362001)(66476007)(66556008)(66946007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zAzY9cEsDIueHTeYesi9OpIVmIqrpz3IPGPwe23U2NewfBCma1jqQeFK+U8S?=
 =?us-ascii?Q?lDrJpAN6/vYXHxBebCKAlnl6flNGbodCCi3ZEfuMfT2Pj4r8tWwo+j6hfyn9?=
 =?us-ascii?Q?wywL0aMdXpDiPsSXq9jdec35LJKtC8JJVyz/ws+3mXPiAw+uOFzlBPy/ZVnd?=
 =?us-ascii?Q?oS7Ads6tQvjldkDShg2YkCs+es1kmj6OcAR+XNxFMoT7RF/Gqi3BhW3G6IRJ?=
 =?us-ascii?Q?kH06Z+SDPWk9ozImR3J33lOohQV4ukmkqNOUnY/eA6KyiZ0yW8OIgNIzVokE?=
 =?us-ascii?Q?o+UOusdhV7M3A4Cvk2FS5xn93gQeu/BtkOpWNBLeRLL8XXNpdPmOy5BHcGTW?=
 =?us-ascii?Q?UAYDfnO6jzE9KPlbVtOnycjelBX2lRA1OIDhvfUrTlcBj6cV6BfxKem/LoA+?=
 =?us-ascii?Q?VsBdJB+jbvbKGQrAjKtOD3TJfv6I+HcaaDyoj/dF7C1Hd3rcMZ/K6H+sS4LX?=
 =?us-ascii?Q?f2iK/2YdeI0it68Y3AZAWtUBamk7aPFRQfpKmcyr9cGqWGbLywYwseB6mLXg?=
 =?us-ascii?Q?rh15x4ZGshWxIH1v4E2Ms6OS4raEXyLCbCezQRXXcTYVbGlef7WWLgbOdpcO?=
 =?us-ascii?Q?d+8dUNGoYvTpyJN6xtl4tRs4Qrvn+veDjy7Eo3V9J6milTILQqKG4Ypt4XzW?=
 =?us-ascii?Q?bjX8e4DlsucTsHRizS8tOT88C5PG6rDDFUHzFY2E4Y7sbhlPu9P8ZXFXcAEZ?=
 =?us-ascii?Q?M8tMys0cYu/F801e96qJ6Oj/9/Shgu6S+nhMJSIZXQsAo/pmB6VENIabNCkr?=
 =?us-ascii?Q?EZq9RxcbTEKV5nVHFQuxEPMaW1xU4LOhWXPNQ1JQI+++159ky6d4X1XNccoH?=
 =?us-ascii?Q?BTuEElF/kG80aszoccf0LttPfw6MR06oVKYyM3x7q+1ECBjowq7YntSwt/jG?=
 =?us-ascii?Q?1KBYqZ/EAq7PxlrS/RxiFWHc2kZViCkKMC1tn2vBpl6mt0xooaZ1MUHzClvh?=
 =?us-ascii?Q?+pIzIwJnO9I9hnDYo6EUyaUvvRPdkIxoHhbVr+RVH4PGOJizlIoQqOeNM333?=
 =?us-ascii?Q?9vyIPmE4IAU73ehkxHohEFDqLkAqg1pEIboLViqbLQyKh6x7Wh7M58Q9Xp3+?=
 =?us-ascii?Q?OaK6NDW94+GRAX9252z+G0WwuqLA7pJndQAlQO2rSKgQgaSc+YmsYBxNoqA0?=
 =?us-ascii?Q?cjE+pJ+X7mcpSV5tl90Oec1Gpy9zgCghJUsZuMGwVx/qiNi9ZGJXPTkf9zWa?=
 =?us-ascii?Q?Fs5F/3xQcOrkPhKDN2+hNcxxFusapycq16n1E2JreT18qsBj8ftKa6uEB0Y8?=
 =?us-ascii?Q?xa5CGr2ykcImgsfsXubwcXhI8vgD09rAcsvUSYuwqDP82tqA5G/KxkXJSPGC?=
 =?us-ascii?Q?Vcy+ORrpJ8gvatSCRijeLsxAGEGEdirr8DAtykttmWiC7F5LLQWgku6Etats?=
 =?us-ascii?Q?R/5nsujWgkRRRxVaae/XtTPkm3FFBAktKSisMMKcOPfFEvcUcR1a2Eyd/qJj?=
 =?us-ascii?Q?fzMJe226tniMuroV7SJZZQKv8GMeipQLXKfPzwqxSIMTbk6svNgXZYMKer03?=
 =?us-ascii?Q?RJqd8hNXtPrlsjV3rBvofmafabFtKSIbD1PI8Bu2E9FpgoyikEiDZtIQiNcR?=
 =?us-ascii?Q?MKr2GeXV8MgXAoKyOY2KfKupMqqSC4SWN9JJdAcqCs/aAeQLKjhMk/xpsIFA?=
 =?us-ascii?Q?dw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655281ee-c78f-4c1b-352a-08d9fe2cf8a9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 22:18:55.8646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vc4EQv2yJkXfM+yirRm160ghguuVnr9lw9LUhOn3T5vtOAhyDLeHLFoFxveM/hqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1393
X-Proofpoint-GUID: D-Y6YfhO2i-mnEZ_La3YXdkW7JYDeQ9c
X-Proofpoint-ORIG-GUID: D-Y6YfhO2i-mnEZ_La3YXdkW7JYDeQ9c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_09,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 adultscore=0 mlxlogscore=927 lowpriorityscore=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040111
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

On Sat, Mar 05, 2022 at 03:25:56AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Sat, Mar 05, 2022 at 03:13:33AM IST, Martin KaFai Lau wrote:
> > On Sat, Mar 05, 2022 at 02:18:56AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > On Sat, Mar 05, 2022 at 01:58:30AM IST, Martin KaFai Lau wrote:

> > > > > +			verbose(env, "R%d must have zero offset when passed to release func\n",
> > > > > +				regno);
> > > > > +			return -EINVAL;
> > > > > +		}
> > > > > +		fixed_off_ok = release_reg ? false : true;
> > > > nit.
> > > > 		fixed_off_ok = !release_reg;
> > > >
> > > > but this is a bit moot here considering the reg->off
> > > > check has already been done for the release_reg case.
> > > >
> > >
> > > Yes, it would be a redundant check inside __check_ptr_off_reg, but we still need
> > > to call it for checking bad var_off.
> > Redundant check is fine.
> >
> > The intention and the net effect here is fixed_off is always
> > allowed for the remaining case, so may as well directly set
> > fixed_off_ok to true.  "fixed_off_ok = !release_reg;"
> > made me go back to re-read what else has not been handled
> > for the release_reg case but it could be just me being
> > slow here.
> >
> 
> Right, I can see why that may be confusing. I just set it to !release_reg to
> disable any other code that may be added using that bool later in the future.
hmm... If the concern is on future code,
how about using a comment to remind future cases instead
and directly set it to true?

/* All special cases were handled above, the remaining
 * PTR_TO_BTF_ID case always allows fixed off.
 */
fixed_off_ok = true;


> 
> > It will be useful to at least leave a comment here
> > on the redundant check and the remaining cases for
> > PTR_TO_BTF_ID actually always allow fixed_off.
> >
> 
> Yes, I will add a comment to make it clearer.
