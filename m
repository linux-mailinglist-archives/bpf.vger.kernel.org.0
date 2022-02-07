Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7554AC7DF
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 18:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243211AbiBGRq1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 12:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357279AbiBGRet (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 12:34:49 -0500
X-Greylist: delayed 2037 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 09:34:44 PST
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F233C0401DA
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 09:34:44 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 217GTYZX024368;
        Mon, 7 Feb 2022 09:00:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=M+nnwaH3i5KKuVrRhdH6bci+8kEX3VMimHp95BJINeo=;
 b=cpdHo3FjxvGKu+HgdXgIFAJad09oXjvOjuhgyImLijbe4W2G473ZpIKsp2Ad5tr03y8u
 PcR7e+ceDqWfXAJpiAEohYAiWZcy6u8L549SgZiwrgKDX6y8S4AXARomYjqjFHma3NlJ
 Xtzb0jSCrYiDqKTMZo6bnJM7vwo4FM4T30Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e2sxm47ef-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Feb 2022 09:00:27 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 09:00:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+JoBXyyOpKd5rrJFCsY6e50tk44SXdvg59kkgSX6AS5oFyGFmv+2THlwWy8YhseNUrUXwGHVa/MSG2Pr39qsz2QFmltWT87T6/pNUHuz9YABdc2EIJ7B+OXwbdcSHhYzUnkJeuuiXIs5hvJDfPIiC5umxWdB5gDgfx8u7Z9gR4M92h2LEuP5sliTxtY3IkDzYzI5qVlfjEADMt57KKPsxi0k1mxgQWr0LiKmJFVHBUpjU+ABTTD6WyYj7FCc2k6HnMq5RjzAIo7ogrlKHV7ckIzYdk5NXcZVk+3h/rSce/z0RA/EDJw7PoG2fEyHOHW2zvOcXNyrYpEit/SWwrtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+nnwaH3i5KKuVrRhdH6bci+8kEX3VMimHp95BJINeo=;
 b=XvDp4nNUJg9UgtYQmRA4UlfWTMuuJf9i6AgNpOOhs2nqTq10FhfN0x7Gv5MJNwHKlyzOzQczOnTL2+B2sEs8+FsJvDTSfTxm2X2WvwBxXLjPtro2kmxpSEzXOZlKP/BtN38MwC3ZVwTyyfRJyJJi23cFIEB/6YfGIdzeE2LaXTnywgrWl0GgcmxSYsJ6h264uQV0u5oWfSQBeI+PR3JybwSlk69ZONG74oMyjKHnWPkKDEqf9uB6OlKB4QgRufGOb/w3/Fm/iBjs0FJYrhAJc2iIuKbsEy7SZNqvi0JZYTwkAm29VllNzYkQhDzX97YP5GwdzZLlUfVfVigetPQd9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3040.namprd15.prod.outlook.com (2603:10b6:208:f5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 17:00:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::11fa:b11a:12b5:a7f0%6]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 17:00:17 +0000
Message-ID: <251805f5-8180-f2fa-ace0-29f3fff61c74@fb.com>
Date:   Mon, 7 Feb 2022 09:00:13 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH v2] bpftool: Add bpf_cookie to link output
Content-Language: en-US
To:     Dmitrii Dolgov <9erthalion6@gmail.com>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <quentin@isovalent.com>
References: <20220204181146.8429-1-9erthalion6@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220204181146.8429-1-9erthalion6@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: CO2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:102:1::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d8bee06-bf76-41f6-dd1f-08d9ea5b5112
X-MS-TrafficTypeDiagnostic: MN2PR15MB3040:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB304040C1F6CF1DEE2592F93DD32C9@MN2PR15MB3040.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5bpBoIla/qIgawemTIITlUO8zv4FzS29GIluvWnd6vdAzZiNcHPU00rb3DdfO9YMAsE1fxzIgUtBBu4WtBLxP9BH0qUKYOIVakc2iz6/U95IY+gtxs7yI9dLWUF1ryiuNUBY7/mjQP+8yosDFRBH3UBcSanO/6di/nAsvMl9mK6867qu5utNqNoMNAnSs1ZxiW0I9ndTy0cNrcihj5DxSTSTZA7UG1avQBny5D3FwIQvJ3t/IGNM/5MgF15NZz0/uCzk275YTEbV7u21vls/mT9aR00/XgCFS1dmh33QLeIiTfzjaUidjrfz9VJgTKAYQBeMkg8vZ7mToBwTxvjwXN8TRgpEdYgHo7ble5p4sJfk7lHTDQw//jXn/xBWQDZuqCSJgbXS8IWSg8K+eZCO8mnPpyrcXN8UX/f5x6jcAl4/vrembyrChlOECN/8yAQEh3vmkgInJPC7Vl9qCH360neA+IfjTcCvzSbnruuN6UgG3aiwtvlS4jXzS+0B8zcKQtVTb7sqznt24mrbvtWVN93wlWj0EHGJzDF/fYUU45wLqX1oOJdwcyy18n0OEFHSe6nniUiD0JrLI8vRm70in/08KiJiZH2e2DNCz3dO4rFtlLIE3slX4oaVTAnt+NM9peDSVCK3DFDBWJhd6VCcy+6r87P+LG6bZG7uzxB3TR8GJhvgybbhAtpQHesMUDq4X3kc5oyPhe6EmoewacKDGmTXECDmuN8yHWntrbGvdO2mLlobkrnjaK4X8Ld4uohc+/VS3G/S0croZyoaYhXi9pRZREcffX64HEw0I/4kVNDNlkLQJUNzoFyeoAp2K/54
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(83380400001)(38100700002)(31696002)(86362001)(6486002)(8936002)(8676002)(966005)(66476007)(508600001)(66556008)(36756003)(31686004)(316002)(6512007)(6506007)(5660300002)(6666004)(2906002)(66946007)(52116002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUxxeWc0TXNiMlNwbGRwb1pBakpiTFYySXJYQk1MY3NSMjQ3cHZQbWtabVc2?=
 =?utf-8?B?bERGbzRVcVhoWGtUYjlPOFFwQ3FFbkp1SU5SRFA5d1lNL1hxZVVKU3I3TENo?=
 =?utf-8?B?V2FrS0pDWE1qclN1eWdUaFZCN0w3ekRuVnpjNW83SDNpVU5Yd1BEbjdVUzBl?=
 =?utf-8?B?YmdsaXBaMTJGRGt2WmV4TVBZT2Q1d1ZTL1pRbTFmOTJsSnY4NnJ1ekdjVHNu?=
 =?utf-8?B?TCtoVktCYzNKMGs1TFQ0ajR6ZnoyNElxTW1YbGZuR2N0M0haUmo0VUFHOEo1?=
 =?utf-8?B?dXRXTlp6QXM1ZUxabTRLdXRIck5wbUNMaG93NXp2WHNlUG1XbXVtbDRaYlZj?=
 =?utf-8?B?RmxSeC8rZmVTVndBaVNKYlJTMENYdWNkUWdQdWJiRGJ6eW1BREh3SzJQNEpW?=
 =?utf-8?B?QzhibUoyL2lSMUY4MHIrdkxHV0orMXBLTWZWMVZ0czBKSEtkdkJkNjRlb3RI?=
 =?utf-8?B?VER5cGo2MnNmNFJQQXVMbVNUTk9kUTRBUHhpOW9qdzhsZlBGYkRMd2dYbkJM?=
 =?utf-8?B?NU5iTzNsR0RlM21qb1F2Zk1iSE9oZGdDWHNVVnVmUGlRL1RZZ2tNM0RPM2wx?=
 =?utf-8?B?b2RLOXFJVlUvTnk3M1pYaXhqVUF1M3V2cktTQmtLaDRBajdvbFRPTXJ4OXJL?=
 =?utf-8?B?c21VYmZtUExLc0FoNWsvV0tXY3Eyc2pMSVo2bU1lczR4WEVMNnMyVlhhM3d1?=
 =?utf-8?B?bUdSeGhzMVlINGhZdzVNbldLQzh6SjdNb3g5MGpHZ0JJbm1TdCtPeTB6b2x3?=
 =?utf-8?B?WFRBNUpUdGhJK1FqNFVIZW9pTTdxQkZ0NGViQW1uTjBVWndWbENaWnhMb3lI?=
 =?utf-8?B?dnRONlhJWjVPRTVQY2hrcWh1Zm5EZGJjVDlxL2Q2MFpwMlAyeWNMNm5uMlJ3?=
 =?utf-8?B?MDRwbEJyZWdBQmpUZExVWVFJL1oveUZ0OG9qc0M0RHFIWFQvNmoyVE1nZits?=
 =?utf-8?B?bEc3S0N3aEpkZVhQTzBocHdTZ2hxZXFLWTNMV2p0cW53SjdyNXpqRkhVYjE5?=
 =?utf-8?B?N2VLdk14bkJqMVNjLytnNzlYQTlZWnBnaGsySWU0dTYrbmRLbHpmVnBROEtp?=
 =?utf-8?B?RWJQUUVlM01MRVM0b1FjZ1VFN2hhTzJHRnJFMkVZUnBsSkJXcXhudlNGd3FQ?=
 =?utf-8?B?bGJUaUN2T3g0SlJCcCtwSGJDZENlRHBISmlMYlFiVFd0VThzRUlRd1NsVVkr?=
 =?utf-8?B?cFFMUU1uTDRaMklPSDdjWmlzQzNjajMvNEl5ZmJ3MUNCY0lnaHdZRnNMWWRJ?=
 =?utf-8?B?RndXSFc0ejNjc2s5T3RROVh2SEhiUjVIY0ZheDJVYTBMVE1VVVMyN0gvNzlX?=
 =?utf-8?B?Y0xQcWNlTlYvNjY0Q3k2MHE0K3R2UHl3WG80TU9WSllyeExuUm9qeVNQVDZT?=
 =?utf-8?B?TlJKUnJDc21NN3J1UkVEM0tpN05uZWVoN2JtNjZTa09RZGJHMkZUMncwYm5C?=
 =?utf-8?B?RWxKL3gzUjAreVZGWFJhd1N3eDIzcVZHUnIvcFJnTWp5RytYYy9MSnVPdVhU?=
 =?utf-8?B?Q3UzWlpTMWNKenpMY3BqRlJlLzB3bTdCRVFYNlBNdTFjNHhGQmV6SzI2KzFG?=
 =?utf-8?B?ZEhBZENKRndVQ3d5RjRGS25Pci91VWo2amdBV25GUnovNDArVU9DYzhQaWti?=
 =?utf-8?B?WWx4dUNncENkb29WV0JGbThJbVJIaWZsNUkzamJIVURvdnl3QXUxb2drV1Q0?=
 =?utf-8?B?ZDlwejJ5L3NmMm10YkN6RnJOS0s5SlcxaGNXRGI4QjdpSjVST2FUcitqa3d0?=
 =?utf-8?B?cC9KTlVQLzljcmhLVk9LNGUwNCtpYzlmKzJ1MnNsblN1MHdqVklkNGQ2UEpB?=
 =?utf-8?B?NytnWjIzZVhKL1dJRkFQZTI4Tzc3REl2N3hyd2paRjlBcVVYaWlKWEhvZ3Bs?=
 =?utf-8?B?d0FwVWZYTDlIR2RtOW4vMzFEbXRFWjlGeE1YaUhCcWpiTGJ1WHVZOE1RaUdJ?=
 =?utf-8?B?OGdNUTlDOFBpU1J5aHZ3cVFIZWVYQkpBbjU1ZElQeEpiZC9XRlRDUlkydlFu?=
 =?utf-8?B?SzBVV0NHRU8vM1AwK2gwTjdKZU50SWhnWEJuZzNSS1prTnFKY08zanZ1QkZS?=
 =?utf-8?B?SkVNZ0lQZExvQzd3MTYvZExjOHhIUC9vZzZaRUJDdWhXQ2MvSklrVE80cGZh?=
 =?utf-8?Q?AF2aLUbCsfkDFNbComC02MhY+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8bee06-bf76-41f6-dd1f-08d9ea5b5112
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 17:00:17.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDecCcxlIQlc4y5fmrS1guVYKCYwpiP/DVpXZWEVoFMb3llDQoVF0NMqNaYLqibw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3040
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: qO_nyAv9iAwNp5lmqeliQ2qr9bg-rKRM
X-Proofpoint-ORIG-GUID: qO_nyAv9iAwNp5lmqeliQ2qr9bg-rKRM
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_06,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202070106
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/4/22 10:11 AM, Dmitrii Dolgov wrote:
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.
> 
>      $ bpftool link
>      1: type 7  prog 5  bpf_cookie 123
>          pids bootstrap(87)
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Changes in v2:
>      - Display bpf_cookie in bpftool link command instead perf
> 
>      Previous discussion: https://lore.kernel.org/bpf/20220127082649.12134-1-9erthalion6@gmail.com
> 
>   include/uapi/linux/bpf.h       |  3 +++
>   kernel/bpf/syscall.c           | 13 +++++++++++++
>   tools/bpf/bpftool/link.c       |  2 ++
>   tools/include/uapi/linux/bpf.h |  3 +++

Could you change this patch into two separate ones?
The subject 'bpftool' sounds like it is a bpftool change but
actually it also includes kernel bpf change.
Maybe:
   patch 1: prefix: bpf
      include/uapi/linux/bpf.h
      kernel/bpf/syscall.c
      tools/include/uapi/linux/bpf.h
   patch 2: prefix: bpftool
      tools/bpf/bpftool/link.c

>   4 files changed, 21 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a7f0ddedac1f..600da4496404 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5850,6 +5850,9 @@ struct bpf_link_info {
>   			__u32 target_obj_id; /* prog_id for PROG_EXT, otherwise btf object id */
>   			__u32 target_btf_id; /* BTF type id inside the object */
>   		} tracing;
> +		struct {
> +			__u64 bpf_cookie;
> +		} perf;
>   		struct {
>   			__u64 cgroup_id;
>   			__u32 attach_type;
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 72ce1edde950..94b7fa777fc7 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2948,6 +2948,7 @@ static const struct bpf_link_ops bpf_raw_tp_link_lops = {
>   struct bpf_perf_link {
>   	struct bpf_link link;
>   	struct file *perf_file;
> +	u64 bpf_cookie;
>   };
>   
>   static void bpf_perf_link_release(struct bpf_link *link)
> @@ -2966,9 +2967,20 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
>   	kfree(perf_link);
>   }
>   
> +static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
> +					  struct bpf_link_info *info)
> +{
> +	struct bpf_perf_link *perf_link =
> +		container_of(link, struct bpf_perf_link, link);
> +
> +	info->perf.bpf_cookie = perf_link->bpf_cookie;

I think we don't need bpf_cookie in bpf_perf_link. This is a low
frequency event. You can get the information from perf_link->perf_file.

Could you check whether the following works or not?

         struct perf_event *event;
         struct file *perf_file;

         perf_file = perf_link->perf_file;
         event = perf_file->private_data;
         info->perf.bpf_cookie = event->bpf_cookie;

> +	return 0;
> +}
> +
>   static const struct bpf_link_ops bpf_perf_link_lops = {
>   	.release = bpf_perf_link_release,
>   	.dealloc = bpf_perf_link_dealloc,
> +	.fill_link_info = bpf_perf_link_fill_link_info,
>   };
>   
>   static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> @@ -2993,6 +3005,7 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
>   	}
>   	bpf_link_init(&link->link, BPF_LINK_TYPE_PERF_EVENT, &bpf_perf_link_lops, prog);
>   	link->perf_file = perf_file;
> +	link->bpf_cookie = attr->link_create.perf_event.bpf_cookie;
>   
>   	err = bpf_link_prime(&link->link, &link_primer);
>   	if (err) {
> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index 97dec81950e5..3ddeacb3593f 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c
> @@ -243,6 +243,8 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
>   		printf("\n\tnetns_ino %u  ", info->netns.netns_ino);
>   		show_link_attach_type_plain(info->netns.attach_type);
>   		break;
> +	case BPF_LINK_TYPE_PERF_EVENT:
> +		printf("\n\tbpf_cookie %llu  ", info->perf.bpf_cookie);
>   	default:
>   		break;
>   	}
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index a7f0ddedac1f..600da4496404 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5850,6 +5850,9 @@ struct bpf_link_info {
>   			__u32 target_obj_id; /* prog_id for PROG_EXT, otherwise btf object id */
>   			__u32 target_btf_id; /* BTF type id inside the object */
>   		} tracing;
> +		struct {
> +			__u64 bpf_cookie;
> +		} perf;
>   		struct {
>   			__u64 cgroup_id;
>   			__u32 attach_type;
