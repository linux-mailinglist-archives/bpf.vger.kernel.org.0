Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322164D1AEF
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 15:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiCHOsz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 09:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiCHOsy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 09:48:54 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6325F340E4
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 06:47:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahGIrGyNnwejGOHC5VFFgY//6+g8pY5jgyAexw2cLmUFC0eXPvstkrZAWwljMOkBd9+kZ67cXjZLHaIW0SDL+0941p9cURAQJ/hOSHGvcIDNsv7472OWjewcF5dTT8ajfwz1UUspy/GKx17bE8yXvtmOmMEmTF/pRQuN+U9icG0NwVKCbO6I5w3/GDm7dmd1QZymjUn9jHGczTtDo9KfkdFXvCjpMZt7B0PJlXeE01X3SIx0VQFHkfYwz2cRiFCM87E6/q0y21CNoxulqzZNldJpUPnzzhq3IQ9R1TeIn8ZDdWI8ne8LE2JPKdaublIG30Ce/znJPyV5z87RLiJMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZEmW/fZNZbAmbE6Ge6DoEJ8eLKwoQdVyX3QPC30BHY=;
 b=eB4XeS/JLlscyJUZUPmIpOh50cDAx8thIvmRUmxG1d9ZZXIOUpwZyvGGgKY4BRdEibMqEftf27vg9dDacVgXK2f2KoZ2FZ5wQBBWgBA6ePD2bEmfOzRzFhcEBmcQQ1ne2FLWOZve7XjJVf1SyEev9bkgJ+H6+s4syTO65jENS28MCVrPCamuSU6ZtW4Xn6QNrCO+MZora8EUlCJVtGJgVGoaBEiXS1jEIavNLYmskp6YGoaY8DvqPCWjarLVvZK0L84ADLtMbxYQSuc17QGJE5uV+3hblIx9yI5L8uOFY3yKyP+x4MZEEItJkGbfVjJt7yanuRjZ/pyrpCBwXStzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZEmW/fZNZbAmbE6Ge6DoEJ8eLKwoQdVyX3QPC30BHY=;
 b=CrgBDfakTG9jZzwNQgjgcXegeyFVLt3YZjuduttqEyVHKVztmiyYwEFqJfF74A9tjBm16I5B6PUTCrdRQvkVIViXddsysus/FZlrcE1ivAH5oSR/yqYUhNruMkF+6LSsSN8sOavc31w9gV9HW/PZPeIdTyOM/ABBQB+D0BPeKaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by DM6PR13MB3722.namprd13.prod.outlook.com (2603:10b6:5:242::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8; Tue, 8 Mar
 2022 14:47:54 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::e035:ce64:e29e:54f6%5]) with mapi id 15.20.5061.018; Tue, 8 Mar 2022
 14:47:54 +0000
Date:   Tue, 8 Mar 2022 15:47:47 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Simon Horman <simon.horman@corigine.com>,
        oss-drivers@corigine.com
Subject: Re: [PATCH bpf-next] bpftool: Restore support for BPF
 offload-enabled feature probing
Message-ID: <Yidskyc26yC9F1c9@bismarck.dyn.berto.se>
References: <20220308113056.3779069-1-niklas.soderlund@corigine.com>
 <25f003df-97cb-549b-e117-2eb1fa2f3cc2@isovalent.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25f003df-97cb-549b-e117-2eb1fa2f3cc2@isovalent.com>
X-ClientProxiedBy: AS9PR06CA0066.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::11) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 239df105-b0e3-4342-e9bb-08da0112a061
X-MS-TrafficTypeDiagnostic: DM6PR13MB3722:EE_
X-Microsoft-Antispam-PRVS: <DM6PR13MB3722DBEDD9D5D5A133BF6753E7099@DM6PR13MB3722.namprd13.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/x1SD1FfEX2sZqixzlE2F4KdeeMaYpy5s0deu1cQ9i2kLjTnwgw3CdkCMFwi6U2GL0KLXBnvrQ3C24XzkSP9vTQml8kwd3hRlH0UQdXYC2J3VFSYihgfCtRbjTZxL4SKDUEir1rb3RvHOiviSZhIcth4A6D0K9vQtjdYKM8L/DGuXHwQv45Ecw2aNTBbf4SiqHGYOmpDh3T804Lp/ChQtRGp5GPlakJLkZP0B96GrQNAaCIhqWQV3EUTsXSZG4HwCcg25v4MmnQ2Y0/B68lVJjVEIY2yIRYj/oZL/43QTIdmkx6QraQwdXACa7R8A53nfJXFSOOdJAF4x72MDogpnMav2pOW3OFsQgnECI/oCFAhBBDOJhWLvTHM9J6G1Hpub6mA5Nr/+Guysw2xL4II5ny9ZYPRskDDpgGvBJf2l/hLsFBQZFxH8vjKnbby3UqMR0xhF7VHCZfHyRPXEJp3nNIYSGH6sFYbMWnjkTY1HEC71LkpEMkQdqN9+ABowVha0v8Uhgqc7SoVjbZBLr40UcFI2wkWhtakwCyCyDyR490R195j/IllbArJp4QrDcaKWOJGpc34E1bR9nGRfRXFOJ7lEURhhD3KB00TZISNx8SSaD1NBmkfQiB4nJzSIxuhPJciJxnOKRo7JenC1xkBbkkl9xtAjZ0HjjU0gdxAJCToMc+vRTnewbrHTSN0a1DJ5qBE/2xlLZ114lNzMu4tqgEpqS+aimb6V900c7ufMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(39840400004)(366004)(396003)(346002)(376002)(136003)(26005)(508600001)(83380400001)(107886003)(86362001)(186003)(66574015)(38100700002)(38350700002)(6486002)(8676002)(4326008)(66946007)(66556008)(66476007)(6916009)(316002)(54906003)(2906002)(5660300002)(9686003)(52116002)(53546011)(6666004)(6506007)(6512007)(8936002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjVEQnBlZ3NmaGU1YlIwb3g5VTgwTFBoZlJwWnVNMS9UYm5VVjAwM2xoSXVy?=
 =?utf-8?B?K0ZQOGRjTjBrRXIreFZ5c1BKYlZjVVFyLzdlQkZtbU9zOEtmanJHTi8zM25I?=
 =?utf-8?B?a0RBVDUwZ1BxL2g2ejQxTW92c1NqWTVGYi9kbFR6Tk9BZTN1Y0xQN3lyblhy?=
 =?utf-8?B?d1VOL25lenNpb055dTlzcWxZS3ZhU1VEZkRSSkJLTG0wNERYcXc1R01TR2Rq?=
 =?utf-8?B?MkFzY0QvQ2NCZzl4RStkbmlWZzRBbXkwb1p0eUFFN3BNeXFDZUtkTllWOWhZ?=
 =?utf-8?B?WFhoZkYxblpaTll1UXVQckh5KzQ1WGYwcU5ucmJ6cXNmcElBQUQ1RlNFMjJs?=
 =?utf-8?B?cDcydFhZUkt6aDF0TVNmQVBudHN0RUQxRVJZbkczeWFoSGNKUzZmWWtCMkpN?=
 =?utf-8?B?K2dSSVcyR3MzTHRRK2o2QnRHaytyTUtVNWJoSkJXK284UGR1WkdSQTdXaGxH?=
 =?utf-8?B?Tjl1Z2RDMDFpYVR5U29KbWpIVHNPM0hyWGZOd2tmb1FDaTZnK3lLYzE5Q2Yx?=
 =?utf-8?B?eEU3em9HYm5vRVlqanVKcFhnUUtFYkFNbUN5bGlvR1NHRXhPaG1pVjEyUEFy?=
 =?utf-8?B?YTBtc2Z4bmVwOTR3OGNPQkJXc1Y5WXFiT1V5S3I1a2pJdERiRWl4TVJWQnRB?=
 =?utf-8?B?dXZ0TEh5YmxobklkcGkvMS9mOG1FYVBhQlJCNDBwMXVqSTVaeFVTWTVzbWQx?=
 =?utf-8?B?djhiTGJXRmFmYkszV0RvUHhYMldEK0tNLzdsZFFac1hOUHdvT2lNSW1YN1RZ?=
 =?utf-8?B?WkhURzM5alFDelQxU3pxd0ordEI2L0M0Rlhrd2Y0ZExSTC9BTitmRmdYVW40?=
 =?utf-8?B?ayszMWh0VWVMRlRzdExNY2tXVXEybS9tVEpQUGlPaW9iRFBNKzRwSlo1ZlBM?=
 =?utf-8?B?Um9TR0I3c216Y1NpN2pXTnJUK2VCQmh4eCsvS05mMFJNeUpBZ0RQOE5ZMFVG?=
 =?utf-8?B?ellnUzU0V3hUZkE5Ui9ISWNKNWVXWm4rMVMyTDEwWEh0T2E4ZVRyYlcxR2Vs?=
 =?utf-8?B?eDY3ZWk0d3h2OFJIWTl3TkdaVFhkcDQ2K3YvbWJ2WFdyL1JJOHY1dUw4RS9a?=
 =?utf-8?B?QnhxT21PRTRSYkpmaG5BME9PTzdNZVFORXNKandnMnpKSXZ2ZkUxWnJuc2Vv?=
 =?utf-8?B?ekthREVUWTl0UGplOUlMOEpMT3grdTJoaytrSWtPZHlhZUI2bTY0Tm5xcGhu?=
 =?utf-8?B?NktNcDgwR09UOEJ6NmdrRmxtcEd5ZkxQcVJmTHBrV2s2YThqOXlqdGtQVmJa?=
 =?utf-8?B?Y3Y2MzJVcnVnZE9PSHlrWUN4T3FrTklvTm15Q3FDbGdWRnpvTDdlczlCVE9G?=
 =?utf-8?B?NUFLeW1haG1KdEJac25wUHBFdHVWZHhBWnN2N1F1RXY0aUY3T0xwTjJNdHht?=
 =?utf-8?B?RVNPSGc0WXdXR0FpUFB3NWFvbnBTSmpjS3NJSFYrbTJ5ZWY4eHNhaWFFYWlJ?=
 =?utf-8?B?RWxzZ1V1cXduNnY3UVYrckZMNmFDeHJZVEJlK1c4OTRGanNSZ0NsWkkwV1lu?=
 =?utf-8?B?MTNIQlhOU1ZTVnFXOWtGWkVpbkQ0Tnp3dlFQTi9QT21Hd3lRbW5UbjlZUlAr?=
 =?utf-8?B?RmVSZHUzQkhCa3FDWi9FUDhyblpWWnVwSWl5THZTQnNiTVJyU1U2bHFyc3o5?=
 =?utf-8?B?MmZzcG5aVjcvZ3RydlNURjBmOWRVY3ZEZEovb2E3eHltUm9nMHZ1emZhblVQ?=
 =?utf-8?B?dHJKMFArSFNtQXB5aS9VL2w3Z3duT2ZDM0J6WFIzMWJVdXJ2dXFsT2QveTF2?=
 =?utf-8?B?cnVHblN6b1F2RGMzd2JXMEVFUHpObkM5VXBkVFVKYkNPb1pxSEhnMDJqQjBX?=
 =?utf-8?B?OEEvRWhOLzY0dVF5dUk4VkNjMytWVHBXL0hGazBkQ3pXaGdldTRQMW9RVmda?=
 =?utf-8?B?NVVjQ0IwU1RHNlZBZ0UrU0FHVGdBRTgxekRLQjNOdWJadFBaRkdVWjBFeDJp?=
 =?utf-8?B?SkxSZXc3amw2V21TRTV2RmYza2JXREJQYzhtQm5zeEt4UkQ0K09uWGFhN29G?=
 =?utf-8?B?VXVwSGV5QzZRPT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239df105-b0e3-4342-e9bb-08da0112a061
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB4431.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 14:47:54.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wefae1ncZF8mkcZN6ktovfoJeJqU0yoXVb8rjy+XUvmeFTWuY33PKGSwy5ZyJY/mG0ZXNDZSMzmIfBu4A2mXOsNTIWX5RnGLrDY/CbAR7Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3722
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Quentin,

On 2022-03-08 14:23:30 +0000, Quentin Monnet wrote:
> 2022-03-08 12:30 UTC+0100 ~ Niklas Söderlund <niklas.soderlund@corigine.com>
> > Commit 1a56c18e6c2e4e74 ("bpftool: Stop supporting BPF offload-enabled
> > feature probing") removed the support to probe for BPF offload features.
> > This is still something that is useful for NFP NIC that can support
> > offloading of BPF programs.
> > 
> > The reason for the dropped support was that libbpf starting with v1.0
> > would drop support for passing the ifindex to the BPF prog/map/helper
> > feature probing APIs. In order to keep this useful feature for NFP
> > restore the functionality by moving it directly into bpftool.
> > 
> > The code restored is a simplified version of the code that existed in
> > libbpf which supposed passing the ifindex. The simplification is that it
> > only targets the cases where ifindex is given and call into libbpf for
> > the cases where it's not.
> > 
> > Before restoring support for probing offload features:
> > 
> >   # bpftool feature probe dev ens4np0
> >   Scanning system call availability...
> >   bpf() syscall is available
> > 
> >   Scanning eBPF program types...
> > 
> >   Scanning eBPF map types...
> > 
> >   Scanning eBPF helper functions...
> >   eBPF helpers supported for program type sched_cls:
> >   eBPF helpers supported for program type xdp:
> > 
> >   Scanning miscellaneous eBPF features...
> >   Large program size limit is NOT available
> >   Bounded loop support is NOT available
> >   ISA extension v2 is NOT available
> >   ISA extension v3 is NOT available
> > 
> > With support for probing offload features restored:
> > 
> >   # bpftool feature probe dev ens4np0
> >   Scanning system call availability...
> >   bpf() syscall is available
> > 
> >   Scanning eBPF program types...
> >   eBPF program_type sched_cls is available
> >   eBPF program_type xdp is available
> > 
> >   Scanning eBPF map types...
> >   eBPF map_type hash is available
> >   eBPF map_type array is available
> >   eBPF map_type prog_array is NOT available
> >   eBPF map_type perf_event_array is NOT available
> >   eBPF map_type percpu_hash is NOT available
> >   eBPF map_type percpu_array is NOT available
> >   eBPF map_type stack_trace is NOT available
> >   eBPF map_type cgroup_array is NOT available
> >   eBPF map_type lru_hash is NOT available
> >   eBPF map_type lru_percpu_hash is NOT available
> >   eBPF map_type lpm_trie is NOT available
> >   eBPF map_type array_of_maps is NOT available
> >   eBPF map_type hash_of_maps is NOT available
> >   eBPF map_type devmap is NOT available
> >   eBPF map_type sockmap is NOT available
> >   eBPF map_type cpumap is NOT available
> >   eBPF map_type xskmap is NOT available
> >   eBPF map_type sockhash is NOT available
> >   eBPF map_type cgroup_storage is NOT available
> >   eBPF map_type reuseport_sockarray is NOT available
> >   eBPF map_type percpu_cgroup_storage is NOT available
> >   eBPF map_type queue is NOT available
> >   eBPF map_type stack is NOT available
> >   eBPF map_type sk_storage is NOT available
> >   eBPF map_type devmap_hash is NOT available
> >   eBPF map_type struct_ops is NOT available
> >   eBPF map_type ringbuf is NOT available
> >   eBPF map_type inode_storage is NOT available
> >   eBPF map_type task_storage is NOT available
> >   eBPF map_type bloom_filter is NOT available
> > 
> >   Scanning eBPF helper functions...
> >   eBPF helpers supported for program type sched_cls:
> >   	- bpf_map_lookup_elem
> >   	- bpf_get_prandom_u32
> >   	- bpf_perf_event_output
> >   eBPF helpers supported for program type xdp:
> >   	- bpf_map_lookup_elem
> >   	- bpf_get_prandom_u32
> >   	- bpf_perf_event_output
> >   	- bpf_xdp_adjust_head
> >   	- bpf_xdp_adjust_tail
> > 
> >   Scanning miscellaneous eBPF features...
> >   Large program size limit is NOT available
> >   Bounded loop support is NOT available
> >   ISA extension v2 is NOT available
> >   ISA extension v3 is NOT available
> > 
> > Signed-off-by: Niklas Söderlund <niklas.soderlund@corigine.com>
> > Signed-off-by: Simon Horman <simon.horman@corigine.com>
> > ---
> >  tools/bpf/bpftool/feature.c | 185 +++++++++++++++++++++++++++++++++---
> >  1 file changed, 170 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
> > index 9c894b1447de8cf0..4943beb1823111c8 100644
> > --- a/tools/bpf/bpftool/feature.c
> > +++ b/tools/bpf/bpftool/feature.c
> > @@ -3,6 +3,7 @@
> >  
> >  #include <ctype.h>
> >  #include <errno.h>
> > +#include <fcntl.h>
> >  #include <string.h>
> >  #include <unistd.h>
> >  #include <net/if.h>
> > @@ -45,6 +46,11 @@ static bool run_as_unprivileged;
> >  
> >  /* Miscellaneous utility functions */
> >  
> > +static bool grep(const char *buffer, const char *pattern)
> > +{
> > +	return !!strstr(buffer, pattern);
> > +}
> > +
> >  static bool check_procfs(void)
> >  {
> >  	struct statfs st_fs;
> > @@ -135,6 +141,32 @@ static void print_end_section(void)
> >  
> >  /* Probing functions */
> >  
> > +static int get_vendor_id(int ifindex)
> > +{
> > +	char ifname[IF_NAMESIZE], path[64], buf[8];
> > +	ssize_t len;
> > +	int fd;
> > +
> > +	if (!if_indextoname(ifindex, ifname))
> > +		return -1;
> > +
> > +	snprintf(path, sizeof(path), "/sys/class/net/%s/device/vendor", ifname);
> > +
> > +	fd = open(path, O_RDONLY | O_CLOEXEC);
> > +	if (fd < 0)
> > +		return -1;
> > +
> > +	len = read(fd, buf, sizeof(buf));
> > +	close(fd);
> > +	if (len < 0)
> > +		return -1;
> > +	if (len >= (ssize_t)sizeof(buf))
> > +		return -1;
> > +	buf[len] = '\0';
> > +
> > +	return strtol(buf, NULL, 0);
> > +}
> > +
> >  static int read_procfs(const char *path)
> >  {
> >  	char *endptr, *line = NULL;
> > @@ -478,6 +510,69 @@ static bool probe_bpf_syscall(const char *define_prefix)
> >  	return res;
> >  }
> >  
> > +static int
> > +probe_prog_load_ifindex(enum bpf_prog_type prog_type,
> > +			const struct bpf_insn *insns, size_t insns_cnt,
> > +			char *log_buf, size_t log_buf_sz,
> > +			__u32 ifindex)
> > +{
> > +	LIBBPF_OPTS(bpf_prog_load_opts, opts,
> > +		    .log_buf = log_buf,
> > +		    .log_size = log_buf_sz,
> > +		    .log_level = log_buf ? 1 : 0,
> > +		    .prog_ifindex = ifindex,
> > +		   );
> > +	const char *exp_msg = NULL;
> > +	int fd, err, exp_err = 0;
> > +	char buf[4096];
> > +
> > +	switch (prog_type) {
> > +	case BPF_PROG_TYPE_SCHED_CLS:
> > +	case BPF_PROG_TYPE_XDP:
> > +		break;
> > +	default:
> > +		return -EOPNOTSUPP;
> 
> This will not be caught in probe_prog_type_ifindex(), where you only
> check for the errno value, will it? You should also check the return
> code from probe_prog_load_ifindex()? (Same thing in probe_helper_ifindex()).
> 
> You could also get rid of this switch entirely, because the function is
> never called with a program type other than TC or XDP (given that you
> already check in probe_prog_type(), and helper probes are only run
> against supported program tyeps).

I agree with this comment. I only kept the return code here as that is 
how it was treated in the libbpf version in the code. I will improve on 
this and strip it out.

> 
> > +	}
> > +
> > +	fd = bpf_prog_load(prog_type, NULL, "GPL", insns, insns_cnt, &opts);
> > +	err = -errno;
> > +	if (fd >= 0)
> > +		close(fd);
> > +	if (exp_err) {
> 
> exp_err is always 0, you don't need this part. I think this is a
> leftover of the previous libbpf probes.

Thanks, not sure how I missed that.

> 
> > +		if (fd >= 0 || err != exp_err)
> > +			return 0;
> > +		if (exp_msg && !strstr(buf, exp_msg))
> > +			return 0;
> > +		return 1;
> > +	}
> > +	return fd >= 0 ? 1 : 0;
> > +}
> > +
> > +static bool probe_prog_type_ifindex(enum bpf_prog_type prog_type, __u32 ifindex)
> > +{
> > +	struct bpf_insn insns[2] = {
> > +		BPF_MOV64_IMM(BPF_REG_0, 0),
> > +		BPF_EXIT_INSN()
> > +	};
> > +
> > +	switch (prog_type) {
> > +	case BPF_PROG_TYPE_SCHED_CLS:
> > +		/* nfp returns -EINVAL on exit(0) with TC offload */
> > +		insns[0].imm = 2;
> > +		break;
> > +	case BPF_PROG_TYPE_XDP:
> > +		break;
> > +	default:
> > +		return false;
> > +	}
> > +
> > +	errno = 0;
> > +	probe_prog_load_ifindex(prog_type, insns, ARRAY_SIZE(insns), NULL, 0,
> > +				ifindex);
> > +
> > +	return errno != EINVAL && errno != EOPNOTSUPP;
> > +}
> > +
> >  static void
> >  probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
> >  		const char *define_prefix, __u32 ifindex)
> > @@ -488,11 +583,19 @@ probe_prog_type(enum bpf_prog_type prog_type, bool *supported_types,
> >  	bool res;
> >  
> >  	if (ifindex) {
> > -		p_info("BPF offload feature probing is not supported");
> > -		return;
> > +		switch (prog_type) {
> > +		case BPF_PROG_TYPE_SCHED_CLS:
> > +		case BPF_PROG_TYPE_XDP:
> > +			break;
> > +		default:
> > +			return;
> > +		}
> 
> Here we skip the probe entirely (we don't print a result, even negative)
> for types that are not supported by the SmartNICs today. But for map
> types, the equivalent switch is in probe_map_type_ifindex(), and it
> skips the actual bpf() syscall but it doesn't skip the part where we
> print a result.
> 
> This means that the output for program types shows the result for just
> TC/XDP, while the output for map types shows the result for all maps
> known to bpftool, even if we “know” they are not supported for offload.
> This shows in your commit description. Could we harmonise between maps
> and programs? I don't mind much either way you choose, printing all or
> printing few.

This is how the output looked before the support for offload-enabled 
feature probing was dropped. I agree it would make sens to harmonise the 
two but did not want to do that at the same time as restoring the 
feature. But as you agree it's a good idea and I need to do a v2 anyway 
I will do so already.

I think aligning on how it's done for maps makes most sens.

> 
> Thanks,
> Quentin

-- 
Regards,
Niklas Söderlund
