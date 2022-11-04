Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88A3618E56
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 03:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKDChu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 22:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKDChr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 22:37:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38DA220CB
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 19:37:46 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3NKgKG016049;
        Thu, 3 Nov 2022 19:37:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=cVPDc4/5PuG7S6pQQ/u39XqiumG5uAHLp8Fqoo+o4zQ=;
 b=MV1PHtwTC+Hfg1ikgCOMpup8cuKLoTxUKOZFMXeMoxOfEoRcFOW076buNl2+Ir3bM/jx
 EYptOA3y6s9kSvnGAmlhyBHKv9IY70iKmcOzbNUHCp1JXmlKBdkcF/K26Ct+O7dc7za5
 WJkwvWkd3QYNqf5hNHCb4s581xR+sWH7wvEDILjV1l/CGqEtop7DOgSPJkA5dCnjyl3J
 jk4tUKpImEVx7I8sdQt1ZQf+cvIybX6sDwxePJCrlQ6RAnPUNmz0X3oX/Z+W0hif9Aqr
 HyZteuKyStaimg+UjdJ5An82yV/kye/jY8yGm3T0hivS/s1zDip8et46pLQjHyDhLTpN KQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmph2shxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 19:37:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGdY4BqF1283320epm50XzQaO/z0bSYiNPWNzdvlg+HUwOiHxtwBAlO0Kv4fpDnpySdnjIIRtFRXPFXfmsQmQJCj6pBul2iD65hsoDJyy/lzKvbgrIxeQT5pOFuiW0mlf9Sm3Eeho/DUWZG8kWWDPgjaImglSGUXVVTbKxBLGzbnWXBeenDclBhlWFUD5+sjZDL+bCDsjfLNPQMXOLG0P9CWS0BPJslY+1Lt9a5bFwGRCu0nnGnKk2PHslS//pB84mcCp5+jwqoFU+mn+XxFspAhI0yemC9nnFFthz3dPTDDPvo4OPJ+GIMzC1vbTZRgLTu88qzycCQQIaYOyxiZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVPDc4/5PuG7S6pQQ/u39XqiumG5uAHLp8Fqoo+o4zQ=;
 b=OeNqZ2QTwRQFFvK2ZbuSIwJ1g4Qw3OHw9qsZdwe7ywac3M1fi/bXVGi5z5eknxzzYhDxQ+Yibq7n3WOQFiuePOgmNddQK6BNmaXO8GCMVPrWnLvX0rud6N7W90Oyw8Zq2V7cB3TcN21GEfmQYzuH8seBUDomGAJzPYYw3UoEyDRX9gWRuNRqs1Q7EDDYXhspboRGhWuqyp4JDmn9oMep/JcpIv5JUUM39w2rZ9movgj/dmEOTpKeZbjGW5bZWhfjSy9RcvFpBinSNutRjQX51g833JxvIUDXnGBmnezantjqCPjL3tEB5I8OH08+VQac5lbqqp6/lRpbzigk2Hz8+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB3739.namprd15.prod.outlook.com (2603:10b6:5:1f5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Fri, 4 Nov
 2022 02:37:30 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be%6]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 02:37:29 +0000
Message-ID: <ba1a01b3-8028-fdbb-910b-19612e22bf5f@meta.com>
Date:   Thu, 3 Nov 2022 22:37:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v4 19/24] bpf: Introduce bpf_obj_new
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-20-memxor@gmail.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221103191013.1236066-20-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8PR22CA0002.namprd22.prod.outlook.com
 (2603:10b6:930:45::7) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|DM6PR15MB3739:EE_
X-MS-Office365-Filtering-Correlation-Id: 4291448a-d612-448f-6312-08dabe0d84c3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y9+wUjz60gHUGVl3teG1Fds9ceQzDfOowGDvcN8wHO/CWdBXdCJ1X6lkUZmJYNOGSIb1hMM3S56sYS3bDw5nSUpCuwVakYmDJ9vV8JfEXjPZ2SI+rL9a0HusORJ6qb+6QXJh6fjFzOwPElXERppJLYCguJzwnUTuyi6sGnIWhg0FpU5HEPdhK0OQJJ50YZ0c/XmgJUTJ517G/Or0xHHLNMdLMWYoTBaAoN3ZY64wXf0PWrhlmJPutXIhnSIesd2Hdhjgqi4QR+z7l44bjnQyi3rdfV5LUpixezyuF4dFLJeUt+lp66vYw0V0Y+BAy/9iYedgKs8M5lUMi6SPrGTXlJdRzdt5mioqZUhVxqALzSSMPwGoAcNH311nPbLnwOCaDNWkCAuD8uqx25WJBhacOCg3QEpn5anaKsn5wco2eaTB/vYe/O+irNZH1TKBIylfEvSv89lqtx7dCeosmnOCRanmcxv/UTwXdhqvJ88qvqXQYZOP8xgi9q13lrpgEmNO5V5SUp2FLVAPx/Ycr+lsEamvVWPOTjpa4k0rTDBSmphT/hrSpswDAumaTZhveF/Cyus+2qlrpQE0tZqy5+F9cCpdHHpVoC9F9IwnBDmRoU5bsqvUzoyjRNK30iWr1H7x56E5cOmZrKpNdiHaElsVhcPudFTbEIZBAUkt29InxqulZWkhCPkCkywwLWtuGMSG/DKh8jtHs7obvTQdNITtyKb/PISQFwzYPNjyRf5KT/4MGiO2WOuhxwGp6FYAmny2ER2YnfHxCLbTDwcSoLsooVgGGEXizg3HbfcH+3sxm0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199015)(31686004)(2906002)(83380400001)(86362001)(31696002)(36756003)(66476007)(8676002)(66946007)(66556008)(6512007)(41300700001)(4326008)(316002)(38100700002)(6666004)(107886003)(5660300002)(2616005)(186003)(8936002)(6506007)(53546011)(54906003)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WCtIUk1raStLclRYc2FhdWhlNEpKSGpPOXFrRTAvWkVYUGIvRGxSaS9YcElE?=
 =?utf-8?B?RXd1M1dFN1NySVN0eEtJWEk0dGZoRkVtL2YwZVY3MlVCb2wxaExVK0VKSnpB?=
 =?utf-8?B?MGFkcnhnYVF2cGZ4cER1eSttS0NUTE50NXhrSHNubmpBcXcvRWZuYzhtYkNi?=
 =?utf-8?B?ays0M2ZvazcxdUI1cXRNa1dKV1pxN3gzTVJKUzZZQ2h3b09oZGhQckJEVnFz?=
 =?utf-8?B?MWlnTnh0Tm1HWjNrYjcxU0xER0hDRlhrRlE0R0lDTS9lR1AzZWQ4WDFqM2RW?=
 =?utf-8?B?VEJEMmVMQyt2eDRoS3IrK0cwMUdRREVSYlYxb1BzUXpCZU5VT2xZQUI3TnBW?=
 =?utf-8?B?NFdlRDVFSFF3SGIveWtHVmVKRTV3VjRDK3QwTDNSSi91eDVOZnNiWkRPVVJC?=
 =?utf-8?B?bVNld2l6SEM5cis3SU1EcXBpNXhlcnZ6UmtEbCtXVE8vZ1RHRmZndmtBRXZH?=
 =?utf-8?B?T21zem5jRW00cU9hL09zaHZXQnpoRkc5bDkvczcrM040c1hyd1pTMlgwaUQ2?=
 =?utf-8?B?VHZ1ZHZ6UmZjNFpUc25hb1RoMVdwdGFNbDIyY09GRUJxZEs1Ny93cVE3RkdV?=
 =?utf-8?B?cmhFZ08xNkRVOFEvRVIvRFlJSXYrUE93ZFc0S3NIczBOZ1Z2YjMrWU1qRXpi?=
 =?utf-8?B?Qnl3ZWFtZVAxRnAwaXhCNmVvaTB6anU1VnZkdG8wWjhtWHdWTGFOcERDcStr?=
 =?utf-8?B?d0VOT0YrbVNnZEs5ZW9OS0FsMFI1UFA3RE9vZzNRczRBalBrdEpMeW9TSFRE?=
 =?utf-8?B?ZWJoK3RqTVFHcFlEMGlmT2tNcUhNQXdKeEtNUHdJNFFlaEhKUzZ2YTJOYWVD?=
 =?utf-8?B?SlJZUU8yMUhQRzNCVXUrVkVobXNQKzBBOEY1ZDlpNThIT05nbXFYZUxHN3Ex?=
 =?utf-8?B?Z0IzNUpoS1lLQVlNVTk1Z2xVeGc0K0tXbUh0NndjYXBKT1dGaTlmQWVFaEcr?=
 =?utf-8?B?dmV5clU0WDcxa25GN1lCaVBjWlkvZzJoUDVUalVGeHdKRldadmJ4NTVIaGN0?=
 =?utf-8?B?b0xTOXl6QUR1eHViTUY5NTlCSCtIMHYwMXZwUG5pYTRadExXZmlLVmt6Zys5?=
 =?utf-8?B?MVF6NGJnQ1ptWVc0Z3k4ZG5EYllXSVpQMHNlNXpUVmE5Z2dRK1RpR1ZPNTJQ?=
 =?utf-8?B?NnpYSkRCSWgyYXFSY2k3N2Y4Q2hmNm1NOHpFSkZkYXdVVjMwVlpHeGNzQmd6?=
 =?utf-8?B?ZnF6allORDBib1ZSaVZReGU0S1RwNkkyM1dRZ3cydHYxK05PM2h0Z3dxMVlB?=
 =?utf-8?B?VFFjczhUeVduMzVwbGpsMGt0bnVUZkViNG1TTU50bkI3TzJTQmU4RFMxL3pi?=
 =?utf-8?B?bHlBUkg1MlpBM2lKc0QyVkVEekwvSVhqQ3pBOUVkTDV4bVdSajRkMmNjcDlT?=
 =?utf-8?B?TFdZT3o1cGlSU3lsdk9yR3hRT1ZFZ3NZUkpJdUhaekI0YmVNWjRqeVJ0MTZZ?=
 =?utf-8?B?Y25HdE5aeno3QTBnaGxlU3ArTm1PVmNtejgwSENTMDlMU3NuU2xJczFTYUxM?=
 =?utf-8?B?Z09yNUhSSyswY0lpTDlDWXVTeFE2N1hhZVFWWDNvUVZLY3JPQXRIVHFjV05K?=
 =?utf-8?B?ZmM4K2FTSkhMcjloT08xR1RFYTBpV0s4ZElVV0ljdmtiRGU4MmJVT0tyWldk?=
 =?utf-8?B?d21SVzBycTNVUTRLZXdJa3pJZm5oMDA0dVJhNDBaelNZekUzYXhpd01GOXMz?=
 =?utf-8?B?bmtyckt1UkZmMzhWeU1VQlk2NUE4ZkszZk9sWWR6TWdWSHJKeGJZck5rOXIv?=
 =?utf-8?B?cEFVWmJHVithb09XeHFqcFlXK3pib3VzaGt4ODJWNjhrY3B5d2hNRFZOMUtu?=
 =?utf-8?B?Smx6KzM3QTNqU1l2S2JkUlI4SVJreWRNRC9sOUh5elBwM21FODM3VmZDK0RB?=
 =?utf-8?B?cnJrNDVUQko5Rm9kandFMXlza2h5Q05xRmpSbHdHOE1leEVGSTVRKzlYN3dp?=
 =?utf-8?B?Q3JXK2F3V3B5VlhHMHlTUFdJSjMrVkdxUEZqMHA2dmkwa1lObTltUHNLeXdm?=
 =?utf-8?B?djZTbU5vVG1RTGd1Z0hZWkxteVNZWkZIR3hRbmswR1gybnYvN3hreGplSWpl?=
 =?utf-8?B?ZDdtUmtEWkhTOVhud1lMSGsrTlQyTjJGQXdQWCtGaXZkei9xRHFTeVlEWjlo?=
 =?utf-8?B?NHFxSHB4RUtVNjdDL0cxSWtDZlJvTkcrYWcwaGZCdG9FaWR0MDh3R1RxUFVD?=
 =?utf-8?Q?p8G5bOtzeDQteNsM6dlcnzE=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4291448a-d612-448f-6312-08dabe0d84c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 02:37:29.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj2/xFqm1lSg5BgDK2oGo8OpaYtTcmLH9EhmcF8kN2dX5GzTqxJHFs0lkPcUXL0vN8c9YwCVCnPb7ak76JTVcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3739
X-Proofpoint-GUID: 80bGJ3C5C5YydsbVFlGHFkuaejo-d9bt
X-Proofpoint-ORIG-GUID: 80bGJ3C5C5YydsbVFlGHFkuaejo-d9bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/22 3:10 PM, Kumar Kartikeya Dwivedi wrote:
> Introduce type safe memory allocator bpf_obj_new for BPF programs. The
> kernel side kfunc is named bpf_obj_new_impl, as passing hidden arguments
> to kfuncs still requires having them in prototype, unlike BPF helpers
> which always take 5 arguments and have them checked using bpf_func_proto
> in verifier, ignoring unset argument types.
> 
> Introduce __ign suffix to ignore a specific kfunc argument during type
> checks, then use this to introduce support for passing type metadata to
> the bpf_obj_new_impl kfunc.
> 
> The user passes BTF ID of the type it wants to allocates in program BTF,
> the verifier then rewrites the first argument as the size of this type,
> after performing some sanity checks (to ensure it exists and it is a
> struct type).
> 
> The second argument is also fixed up and passed by the verifier. This is
> the btf_struct_meta for the type being allocated. It would be needed
> mostly for the offset array which is required for zero initializing
> special fields while leaving the rest of storage in unitialized state.
> 
> It would also be needed in the next patch to perform proper destruction
> of the object's special fields.
> 
> A convenience macro is included in the bpf_experimental.h header to hide
> over the ugly details of the implementation, leading to user code
> looking similar to a language level extension which allocates and
> constructs fields of a user type.
> 
> struct bar {
> 	struct bpf_list_node node;
> };
> 
> struct foo {
> 	struct bpf_spin_lock lock;
> 	struct bpf_list_head head __contains(bar, node);
> };
> 
> void prog(void) {
> 	struct foo *f;
> 
> 	f = bpf_obj_new(typeof(*f));
> 	if (!f)
> 		return;
> 	...
> }
> 
> A key piece of this story is still missing, i.e. the free function,
> which will come in the next patch.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

[...]

> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> new file mode 100644
> index 000000000000..1d3451084a68
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h

Maybe bpf_experimental.h should go in libbpf as part of this series? If
including vmlinux.h is an issue - nothing in libbpf currently includes it - you
could rely on the BPF program including it, with a comment similar to "Note
that bpf programs need to include..." in lib/bpf/bpf_helpers.h .

> @@ -0,0 +1,20 @@
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +
> +/* Description
> + *	Allocates a local kptr of type represented by 'local_type_id' in program
> + *	BTF. User may use the bpf_core_type_id_local macro to pass the type ID
> + *	of a struct in program BTF.
> + *
> + *	The 'local_type_id' parameter must be a known constant.
> + *	The 'meta' parameter is a hidden argument that is ignored.
> + * Returns
> + *	A local kptr corresponding to passed in 'local_type_id', or NULL on
> + *	failure.
> + */
> +extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta) __ksym;
> +
> +/* Convenience macro to wrap over bpf_obj_new_impl */
> +#define bpf_obj_new(type) bpf_obj_new_impl(bpf_core_type_id_local(type), NULL)
