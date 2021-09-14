Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2131D40B5D4
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhINRX4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 13:23:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230390AbhINRXz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 13:23:55 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.0.43) with SMTP id 18EG1e8k002012;
        Tue, 14 Sep 2021 10:22:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=ifQKznnl8FYF5oEJpO2Hdrt6BbxwEAgXtM1vp4NWoXM=;
 b=aDz/bSO9dTEmFnQKF84P0ISLOmi1cvms43KqHPiaR/zBtCGyUCGOSx+O730pfM9+LCKr
 4lRtR08GvO9r7gZmEt8XN+O35edUmztx3qXodFqxtIlasnNiqs9ve2yTKwhvfrU7HfE5
 P5PB8kTa0CnHib+3mT7K6koJ2XD3RU2mOeo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3b2uq0hxr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 10:22:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 10:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pwlx8+oG6PSTmMPN95i8HzNa1M6pet7Jf9ZKpfqrXo8elafJsByRgkQESwSI+eG2mjLzmyQ2LqXitILu+X866l1op4XDqCG4yOUymVcO3hy6g4qlfYWKe4Tzxt5b8MU8S0zTX6KQmY5bXUuCCO64lP6qLp66mTvBVqcdnEZPsLQo83M48B6iBGRrL3DSDf90sXwoYPS2XSaL8n8IJ8/x2CTcChwwf1UkRRR9F5NskJsDHMZjafWLhNsetvtoHRfvpHT3Whvr6X1GatmN3QgOdNNn77WNWTpfUYFXxCfwqz6OzYm50nOVvq+LGoUlfIUctY0hEU2ihFGIlOGCiD3ZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ifQKznnl8FYF5oEJpO2Hdrt6BbxwEAgXtM1vp4NWoXM=;
 b=bisjmdyOEd4XEzBDg/toZI96akf3UbNhPunmn+dOk9WMU21vagrPkJ/qVRe3dHk9xvE4JAEWrvgt8xkTCUp8LEfNa3xxVsxNlOT3LICVYB5BiGos4XVHwEdRH5EPL9TuzvFxlPj27n30Lpa2jOLaeqtT3sJBNQrUQxA5oyHW577ECIcWSkfk9ht4jSM0QZ7Ev1xWuxgy5QeAuKMM9ngBQg9pyfMZ0t8hWkb+mTlvhgPH4ka9i/tPpzmwxAViNSYuxn7+67W2Atrpgv3JQKKcRPOTSUpvJfEtYcu36RFUT/GFWTB1sr9sPYezavDJ1fOEgZKMwVzto4Fs6iQTO0dt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3791.namprd15.prod.outlook.com (2603:10b6:806:8d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 17:22:24 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 17:22:24 +0000
Date:   Tue, 14 Sep 2021 10:22:20 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: ensure BPF prog types are set
 before relocations
Message-ID: <20210914172220.uw5tg6tus6etnwbw@kafai-mbp>
References: <20210914014733.2768-1-andrii@kernel.org>
 <20210914014733.2768-3-andrii@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210914014733.2768-3-andrii@kernel.org>
X-ClientProxiedBy: BL1PR13CA0382.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::27) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
Received: from kafai-mbp (2620:10d:c091:480::1:c86c) by BL1PR13CA0382.namprd13.prod.outlook.com (2603:10b6:208:2c0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Tue, 14 Sep 2021 17:22:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c14d6c19-2744-4e57-debd-08d977a437c5
X-MS-TrafficTypeDiagnostic: SA0PR15MB3791:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3791267CA54EA174CF3931ADD5DA9@SA0PR15MB3791.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFmzgiaOIZRb8d5KJ/8Gl05k1Yttfzqfp/K4ZhlHfXpozVaNNGYL28eb/h9QBCKZCWzXWqLamgBLJlNH63X9CKHDQgftgEYWyP5pymuBb2X3Gom1ErS20pWTjjRTYhX/BQWe/V2ikL3g/1TM05gPwD1PJGCsIUgYVqwIdUxd+/tHPe7gop5mr+mmM6fI2M3kJdry/rUylLU5mKRJUQzmL0AEVFxGF+M2wf/7r3SZR5Pk3je1Gqq36aR5RgXuuADgJ/2xQvdDcft8WZD6tmkd+qADkSwaZi5eXvwfP2o8goMmZB8zXrkcksFw/UKW48CtMbL1KqTlSynHCbmIPixm7JtHAHJY7V7Vyw+sD3JGtLR7IMa3+yHzMlMlvgvnzUJ0hxBV4Oa87BTt2bwZwqKzZmyZy7ujpL60+bMBOg0f25unHXTo91PyRhc2JiscEyayfFPXaRT0+35Nc012cWXYiNfUUVxu0YSDjOGRb5icEeg/TByIRL6P1qEFeSfbkzJRMs+nnHGcoyepQ7HME2uL+d8evU+/WQTFhjCya42BkLIAHUu/tOJgxkQSa5vWp1DSuUoDS0qqISqJybnuJ4NuI47rtxqEdfcqhVxhMfjRK1De2LDAeyb5IVJHKiPO0UmgNdDxCBonMMBob1RaMcYv6DVoQ3G02HdN2Og9avQPGTtYFJNVqoY9rjuzKmK70F3EJF0JzMpsNKB+VJOT/Z7T1lkYzjH97tpnpgYwrnTxHPuGFyqF/+MgKY1LgzXzfIEEwMZP8fivjwT1LQBrvNcPRtq5PkTw0/Zdq7keocCMdDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(6916009)(66556008)(66476007)(86362001)(66946007)(55016002)(8676002)(38100700002)(316002)(8936002)(186003)(6496006)(52116002)(9686003)(5660300002)(2906002)(1076003)(4326008)(478600001)(966005)(33716001)(83380400001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PUBLD4Kfpv/yqEScFx1TCdzAqvodVMO/LgwJCCGmDqKxELQg5sApfFqCQm5Z?=
 =?us-ascii?Q?vXNZkJ1/TrklZgg9l+53urUoY13FW5lo2ICvVmd3S6TnEOTBHSxc4e7drfDn?=
 =?us-ascii?Q?CX080tgCnMWMseZ4ZyF3mAumm2MS1Wf6vyET5sOPlJhzmrFGQhc/t4Z90WcN?=
 =?us-ascii?Q?UnOnsJuV3Rt3h/UtDI6h9i6ZIZ1FcihXDh62WFmZscaUIOcveu/uoPNYfhha?=
 =?us-ascii?Q?gQr2h/HnntUCSZVkgnOf9CQbVZnhYGwXqUhQ2WLnDR4ijFIViCTQkcJ3xxQ6?=
 =?us-ascii?Q?9cVr6bsGLRdnJ5s8ZFL2OgVvcnvM/2evjfzCFA1uqBLnrYbMPSRSlmYuWXFa?=
 =?us-ascii?Q?zTxyQJMQ86rjj3H4FcYt4SpVxSK2Uxc6DXWvuaBbP9nwAzyViG5ev8prm6AU?=
 =?us-ascii?Q?3YuGYFTZFpxhSzQVUK1DMwE/9P8E6VXaJ0aOxzexO0dkQIPi+GNP0yPkAuAO?=
 =?us-ascii?Q?xyrXarYzP8uV8A2IS53/F5NPT5sPsVlo5ildHWsZKO4mBXGp4LWPgnRBvdDS?=
 =?us-ascii?Q?DThaTc4CFQ5fmOazCgnQQZdGBl71D4cSIAEbs95APfhCFYimjiGikfvdSPC1?=
 =?us-ascii?Q?YclUVyayUrQtHuid/6ZgwOFUMm2DI22UsBWRXq9oP1cTj6M69C2tK7gvj7ps?=
 =?us-ascii?Q?0bgLXbU2pjqf8pnYe5t9r8TH/ZRP1bwJzeEm5g9Ftsvinr1pNs+ECrxmSfWC?=
 =?us-ascii?Q?Zspe8BAF/8lQA0v5qMrjk815VU4iIi8zCQ2btPQZWr0De7XmsATAVBklyNJ+?=
 =?us-ascii?Q?6zh6lHF4NobIw6HTK+9TYOk4c1ZuLw5oyFC0PnuAGuY5x0lmBMO3R51YvHaa?=
 =?us-ascii?Q?pGjEA1lly8kXANdU3nzxcndHpxsJ9yCufVG/AlGL7+NfZLt4U7PbZEn+CWeX?=
 =?us-ascii?Q?B21z7YN/Tku2TtOp5MWtqbcgzu4SjPBiJ8TlUMFM6g4QpAOYE8XBNKrVH5+/?=
 =?us-ascii?Q?vMgCrEHpQ4JW6Byl8a5XcV5BsHieqXptGki8Qg1e0OTubgeLAoB3usvohrOu?=
 =?us-ascii?Q?AxC5Yfz1FSzRLgTIBw1VcjDKxp5I7aisazxe8gt8UfBc84+yT7CkwAsZia+F?=
 =?us-ascii?Q?lhlcJktzke2sU40aMpZDay8pt6ROOXGEYOn4mUE1wCp+tT+L93PEoFZ/9TLx?=
 =?us-ascii?Q?GiqdJq6O6vWnZQEjmc3Gy3Vi2owCS7j1v9orh9cSqsleBov1r0f55ssCx3rz?=
 =?us-ascii?Q?uPhqUXTG7V0BwvazhbkecGNG7P3sHwlEgbVA3kApOMDLO5G9hgnt0YX6g0Sv?=
 =?us-ascii?Q?FWjqixgLbvRms9BRzG6jxPqrkpmfBLVZ7TXxyMI+7xYJjlNfJkFsFFVJAw8x?=
 =?us-ascii?Q?ZaTuI2JnEyKDUcnkFplUMN2yMcLhsgCAcW3UjcomSkEdkA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c14d6c19-2744-4e57-debd-08d977a437c5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 17:22:24.4339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o8WXsRhjfGCnxWOStU1PxYNehTE+QTBxf2Eve0jtPmXVWr6BUqIwrW44OXQcDflV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3791
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: BXLc2PFX8pjuhLFiomqquI2jBnv3whO5
X-Proofpoint-GUID: BXLc2PFX8pjuhLFiomqquI2jBnv3whO5
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_07,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=963
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 13, 2021 at 06:47:31PM -0700, Andrii Nakryiko wrote:
> Refactor bpf_object__open() sequencing to perform BPF program type
> detection based on SEC() definitions before we get to relocations
> collection. This allows to have more information about BPF program by
> the time we get to, say, struct_ops relocation gathering. This,
> subsequently, simplifies struct_ops logic and removes the need to
> perform extra find_sec_def() resolution.
> 
> With this patch libbpf will require all struct_ops BPF programs to be
> marked with SEC("struct_ops") or SEC("struct_ops/xxx") annotations.
> Real-world applications are already doing that through something like
> selftests's BPF_STRUCT_OPS() macro. This change streamlines libbpf's
> internal handling of SEC() definitions and is in the sprit of
> upcoming libbpf-1.0 section strictness changes ([0]).
> 
>   [0] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0#stricter-and-more-uniform-bpf-program-section-name-sec-handling
> 
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Martin KaFai Lau <kafai@fb.com>
