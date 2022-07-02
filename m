Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE7563EB6
	for <lists+bpf@lfdr.de>; Sat,  2 Jul 2022 07:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiGBF63 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Jul 2022 01:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBF62 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Jul 2022 01:58:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B1F9FFB;
        Fri,  1 Jul 2022 22:58:24 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2623rwQh007485;
        Fri, 1 Jul 2022 22:58:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LFCaU5wLQ+IiSMPBU3IinAr04typU5Qa6tT7X7GkpBM=;
 b=I1uF/P0AoeThEThfmLBifxHg0Oz9gYy2seGj5x/8OZqwlfBFSk7iLRqrn/IOzRUzyYXy
 gWKYwscCIQaTIzYo2YjqTvwACygKSA6MuTF7KG9lGqRGuH1oJS5M7YJCYdkwdTq/5FXv
 /kh5RJ3uAd/dwwBcfQANWPnjABnowFaoNjA= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h1m1u85sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 22:58:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQjIDXZIfw8TGo/wzOr149zken3MPQ5RUeAY4kqTq/PI5KDfifZfAc94S1vc3vwDdCDSdjL8+pQcRd2HhboruCntkV89YbP3g6d/OSj//TPOmACtiy8Czn92xeG8/4jmDAr8qfWsxYhikK+b3sQDVS6Vg8LLUaPysNOu+4xXWT492mJ/CPmOiO2vILKiBD+pht47j7WtRXnh4XFBEl4qcayi+uCEisvnz6TFZi9jQulXOCdITRuBQyaaUewsqjZ1oSpH7r/plqlFjvIwFciutHYA0JN02Or2dX6DIgqJo0mSCt4RJY7U3BFjCVFfYSvO8GSMWuF8rr91PXTEQh3mJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFCaU5wLQ+IiSMPBU3IinAr04typU5Qa6tT7X7GkpBM=;
 b=EWAR4NO5NkU7R9P1tMzwuOTQCIAfUmZ9FYdg9iPgpWn8rPODRBH9Buhi4SDcpQgp/V1+twHflpKVE7h8+eHcW7Em3XqnbYefysHq3SVlszfhly4XTL3vrKkk2O5HYFK5EVzmreMmA2lur3YxyklyvzJa0DsOK6GpLw0RhKXPLU7jq+jvHR3aUvsvoumBEtNb2H9VmrhKK1q7zTGVLEoiICDRSG0OSG0cg3zMrT/X8DNJT+x4pVboNDwIBveEHfUYjonDEtMi3OPgFvk82oam1y0xGZf8WB1ltfcb64ngSYZL4Iq7mavPb1pqSpCiFrz6SgejKdD1LCd8d/w04I8kRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2781.namprd15.prod.outlook.com (2603:10b6:208:122::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Sat, 2 Jul
 2022 05:57:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5395.017; Sat, 2 Jul 2022
 05:57:57 +0000
Message-ID: <92434e1c-62f5-021f-294d-fdb3d0d4fd90@fb.com>
Date:   Fri, 1 Jul 2022 22:57:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: add a ksym BPF iterator
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, void@manifault.com, swboyd@chromium.org,
        ndesaulniers@google.com, 9erthalion6@gmail.com, kennyyu@fb.com,
        geliang.tang@suse.com, kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1656667620-18718-1-git-send-email-alan.maguire@oracle.com>
 <1656667620-18718-2-git-send-email-alan.maguire@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <1656667620-18718-2-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR01CA0013.prod.exchangelabs.com (2603:10b6:a02:80::26)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fafa3df2-9763-44f9-c98b-08da5befd009
X-MS-TrafficTypeDiagnostic: MN2PR15MB2781:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1yfb6laX7SS9FBn5VbAlN6xKywqkCNeorAf5mfNBawVfIpCcoCe01v81/xcCS86Fs5XNzMlITlZgntEJzQwqqqipkOw4lvNUjxvzxIqCKKnIPHKIRw7s0yL74nfbfR4jGHG1dhcOK8yT6Vsn1+UhcutYWjbaElCRDq69MqS9fw3v2T/8bZ0/pOPgkeZzOmYyhu+3GXzsvvI8qwWHzV77/HiPtbp20yjVG/N9PlcmG3ciqwhgmiW4lZJXUJbQt9isG2iX3pF1oRkwXHxuKCewtPYJeLNOHAC5TK+dW1KuoJ449CubENEkmq5hwWTG65df8pHFUi+qnBuE9TBvlw+SI+usKWPAsWb+TNpbv0O91Vg9eaiu4PH/EWfwnxcAWr/oofBtA3G8sJkFkLcBj4bsmyIdC0SDUyM+iZLU+hljpoLLlBAPkvFHV//QyicZ8ybSbnHf4s7zpYncn0kQa0D41UBluKLyKMsOn2xff3yvooGIKCjgQpNeIVYn2Ulx0r/j2Riyj0w1Ysemn0XEuQUPjTUHZexgP736Y87E1CN7u9LJhkf5T9bWzMNo9va6LSOJSxSdK05piaWCZELjVm8ALGC1F4r7h4pBDIw1L0rjj/q2lwiqrWVRxvTgshkEK8MvCXMLQpBbvbttuDSS+X8EB2CsQMvDC+aMyhcMU/zNgA3B8X2WkXiXbxXsIwHLF24F8SK83nk+b9lkdEfknwkBTJjQnLV+2qaR5nwag3EX4sPDtO7vq8j7Od57y0Nzmw9vaDNaX88tT0xPu4vLRf9mDIVV+pCstADg98FzuJZCvC5GGqSpyvSn6tiofQ7nqdwuMDlaz3vUj1TUWd53oY9Txqj34+R5u5EkZtr7TstLhnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(7416002)(5660300002)(478600001)(8936002)(41300700001)(2906002)(66476007)(86362001)(31696002)(316002)(4326008)(6666004)(966005)(66556008)(66946007)(8676002)(6486002)(83380400001)(2616005)(6512007)(186003)(38100700002)(6506007)(53546011)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXo5T3JJZzNQVkNuUm1BV0dEcFRhNXoySXBTcHlCRkhJQWs5U1FnZEpicHhB?=
 =?utf-8?B?N29xc1FHdEpobU9tMXVlaWtrUVVjcE5NZHJ0YWtJRzl4SmF1V21JRklQWHdK?=
 =?utf-8?B?S3hGQ1NIV2R2Q1paNkU2RTJZS2k2OUhaV0FNNFpubndEV0VGSHh6dURRU2VI?=
 =?utf-8?B?Y1didUkxeGRPaGQ1SXJFcFFxdm1xdVhwZVN2bkQ0Wm8xaEdYeFNyVmJ6a3dh?=
 =?utf-8?B?NVh6ZGZKME1EMGdMQXYyVTVSWTBvekppOWxJZVA1TlVjTnoyRTJiTlRYaWNO?=
 =?utf-8?B?N1c2MVkzQk9FaXBOZHVhWGh2RzQrQVk5eXJQeVBmRVpReENCL1FLK1MyMm1a?=
 =?utf-8?B?QkhaOU14VzBQaGltTEZ5QjVqRG5wS0hvQmNNNzR5VElmU2p6MnpNVXRwUmZ0?=
 =?utf-8?B?UmlMczlsZmdBMkk4WUlXeG9ZSjE2VldqVTd0cUZPYm9TZTh1VDFXRVF4Z09v?=
 =?utf-8?B?aTJxS0NoTVA0U1JRZFpWSzNKSk9xZlIrNFdSM1pCam90QWkrUzE5WGxnT2dp?=
 =?utf-8?B?Nk1OMkdpMHFQR0VhOFlhVG1LaGxrVU1zQjlmZWVQTG5acHhQYS9VcHFGUjl4?=
 =?utf-8?B?cEVGYzBpZGlBWnc4dkV3QlNJVlFkdUVpcUdqWjUyWGJjTUdWa1RONmVQSzlj?=
 =?utf-8?B?bnlRUDhFcXRWT2tXeHgwdjlmUFc1UnNzT3ZMMk5YaWVtd0NZVGVMWGo0SmUr?=
 =?utf-8?B?S3NQR3RDMjN4MFMxNWNqTkVrM1lKOFUzOUtybG1vQjhrZW1WZy9Dd3VIRFA5?=
 =?utf-8?B?OGVXVDd2U3I3TWVYSTJ4aExCekxDbmdzTjh3MmlUU0dPRTlGaWd0OWNYYTNM?=
 =?utf-8?B?ODRnMjVyUHpmSUVvelBzWkc1NFFvQ1JBakRwWnZCQ09ydjNsRGJSb3RyQkQv?=
 =?utf-8?B?ZnlNWldiL3l0bmZyREtTR2VHc2tNU2FoMDlKME15YmI2b21HOTdrV0NVcG9r?=
 =?utf-8?B?M2Q0dmdxS0JkQ3phTXhGb05GeHNOR0pzd3UydnhsYXVFWENVU0QxUE1HRkVw?=
 =?utf-8?B?SndCLy9vU2JSR1czRi9OczJlRkVNMVlLZUZ1V2VoWm9ZUTd0bEhKYjZ0SGJu?=
 =?utf-8?B?azZ1Yi9hVzRsa0RLYzI0MDc5WkNUS2NmVVYySlFIeUtBTUZ4MkdvcDc5bGRO?=
 =?utf-8?B?U1Q2TVYrN2o0RVh4d1p1a0JiQlVlNWdjd2pScm8vMGIvVHFlYzVMcnJJTThE?=
 =?utf-8?B?OVYwWmxlQ3hUNStZU2c2bmk5MzV2YVNRWm1IT25RWTFEMlNYNTltUEplOHNx?=
 =?utf-8?B?aVJlOFFLbXU0aVlaN2tmZWVYem5vWDZOdndQZjNucGxMa3NHNkRYc3p4bnZj?=
 =?utf-8?B?NmQzblh5TW5NMlhqanYwaE9HNW5Uc3VLcFZIZWRJOEIzZWRzYmRpbWJpK2pj?=
 =?utf-8?B?a3ZaZm02NW1Td20zRjZoblZIdTd4RlVIaitXUmd2RzVlWDJLcmFSL2NWZksx?=
 =?utf-8?B?VEt0RkNvT1FwN2hKSkRnWUVIMHlHMFlSbVovT1JNamtJWHlFNFVUSVpFVTFu?=
 =?utf-8?B?U2wvWitjbjdrajRQeVlEamlNai9wYnpwMnJ6d3A1dE54M2hPUmZ3MTMybTdO?=
 =?utf-8?B?NlRnWGhuOS9zQnluL0cwa2liT0RJMTdsRVZUNTZGL2hnZG50aFJaTWNsbDQx?=
 =?utf-8?B?SUNCM2h4SVMxK0tHNEc0d3Z2WG56ZkdWV2l6a1dyc3lsSzJrUDF6NjB1L2ZN?=
 =?utf-8?B?aFZvU2I2TWVnR3F2SXlaQ3RXTThWUHloVDM4V2hSN0JtUE44R3ZpN09vZWxv?=
 =?utf-8?B?Yi95di80WldaYnkrUUk0ZGluUjc3clFwaG9RZmhOczJ0dXdpYTdlRzZDbmRQ?=
 =?utf-8?B?cmVIUlk2RkV2c2Z4d0dVRHU0aG5aeDJ6NkdTMmw3RkhpQXVqV1IvdDNhY3RR?=
 =?utf-8?B?cjEvS1FkSlFYVytLN0g3ZmZkNEo1SEZQQUdWMFZ5aSs4ZzVvekE0TitvbDN0?=
 =?utf-8?B?RlcxSkt0ZXdtdko5eStxSHFXa0JiUWI1eW1vSjBweW1IaTVFNXdrTVlDZUJD?=
 =?utf-8?B?OGhFSndENmJHM2FnTy96d3NDRllaN0FkS1NYaEhwbHhEbkFOWHAydGovZVJB?=
 =?utf-8?B?ZUNnVUFXZyszUWdSdStBSDd3RithRzlsdjFVWDJnbmcveWZFZXFaOWtiemdN?=
 =?utf-8?Q?tJ7XgzPH4kbIq93pQTj0WdhKC?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafa3df2-9763-44f9-c98b-08da5befd009
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2022 05:57:57.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFgFkJymPNdG9Qt5YB8lxLBIQQFOLxz5ksZuqS3Iph31QW7AcGu57p6+7dP7ynpv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2781
X-Proofpoint-GUID: blfKb9ud3uPpa1s3IiiMMdSWBe0RPnTw
X-Proofpoint-ORIG-GUID: blfKb9ud3uPpa1s3IiiMMdSWBe0RPnTw
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-02_04,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/1/22 2:26 AM, Alan Maguire wrote:
> add a "ksym" iterator which provides access to a "struct kallsym_iter"
> for each symbol.  Intent is to support more flexible symbol parsing
> as discussed in [1].
> 
> [1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   kernel/kallsyms.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 89 insertions(+)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index fbdf8d3..8b662da 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -30,6 +30,7 @@
>   #include <linux/module.h>
>   #include <linux/kernel.h>
>   #include <linux/bsearch.h>
> +#include <linux/btf_ids.h>
>   
>   /*
>    * These will be re-linked against their real values
> @@ -799,6 +800,91 @@ static int s_show(struct seq_file *m, void *p)
>   	.show = s_show
>   };
>   
> +#ifdef CONFIG_BPF_SYSCALL
> +
> +struct bpf_iter__ksym {
> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> +	__bpf_md_ptr(struct kallsym_iter *, ksym);
> +};
> +
> +static int ksym_prog_seq_show(struct seq_file *m, bool in_stop)
> +{
> +	struct bpf_iter__ksym ctx;
> +	struct bpf_iter_meta meta;
> +	struct bpf_prog *prog;
> +
> +	meta.seq = m;
> +	prog = bpf_iter_get_info(&meta, in_stop);
> +	if (!prog)
> +		return 0;
> +
> +	ctx.meta = &meta;
> +	ctx.ksym = m ? m->private : NULL;
> +	return bpf_iter_run_prog(prog, &ctx);
> +}
> +
> +static int bpf_iter_ksym_seq_show(struct seq_file *m, void *p)
> +{
> +	return ksym_prog_seq_show(m, false);
> +}
> +
> +static void bpf_iter_ksym_seq_stop(struct seq_file *m, void *p)
> +{
> +	if (!p)
> +		(void) ksym_prog_seq_show(m, true);
> +	else
> +		s_stop(m, p);
> +}
> +
> +static const struct seq_operations bpf_iter_ksym_ops = {
> +	.start = s_start,
> +	.next = s_next,
> +	.stop = bpf_iter_ksym_seq_stop,
> +	.show = bpf_iter_ksym_seq_show,
> +};
> +
> +static int bpf_iter_ksym_init(void *priv_data, struct bpf_iter_aux_info *aux)
> +{
> +	struct kallsym_iter *iter = priv_data;
> +
> +	reset_iter(iter, 0);
> +
> +	iter->show_value = true;

I think instead of always having show_value = true, we should have
    iter->show_value = kallsyms_show_value(...);

this is consistent with what `cat /proc/kallsyms` is doing, and
also consistent with bpf_dump_raw_ok() used when dumping various
kernel info in syscall.c.

We don't have a file here, so credential can be from the current
process with current_cred().

> +
> +	return 0;
> +}
> +
> +DEFINE_BPF_ITER_FUNC(ksym, struct bpf_iter_meta *meta, struct kallsym_iter *ksym)
> +
> +static const struct bpf_iter_seq_info ksym_iter_seq_info = {
> +	.seq_ops		= &bpf_iter_ksym_ops,
> +	.init_seq_private	= bpf_iter_ksym_init,
> +	.fini_seq_private	= NULL,
> +	.seq_priv_size		= sizeof(struct kallsym_iter),
> +};
> +
> +static struct bpf_iter_reg ksym_iter_reg_info = {
> +	.target                 = "ksym",
> +	.ctx_arg_info_size	= 1,
> +	.ctx_arg_info		= {
> +		{ offsetof(struct bpf_iter__ksym, ksym),
> +		  PTR_TO_BTF_ID_OR_NULL },
> +	},
> +	.seq_info		= &ksym_iter_seq_info,
> +};
> +
> +BTF_ID_LIST(btf_ksym_iter_id)
> +BTF_ID(struct, kallsym_iter)
> +
> +static void __init bpf_ksym_iter_register(void)
> +{
> +	ksym_iter_reg_info.ctx_arg_info[0].btf_id = *btf_ksym_iter_id;
> +	if (bpf_iter_reg_target(&ksym_iter_reg_info))
> +		pr_warn("Warning: could not register bpf ksym iterator\n");
> +}
> +
> +#endif /* CONFIG_BPF_SYSCALL */
> +
>   static inline int kallsyms_for_perf(void)
>   {
>   #ifdef CONFIG_PERF_EVENTS
> @@ -885,6 +971,9 @@ const char *kdb_walk_kallsyms(loff_t *pos)
>   static int __init kallsyms_init(void)
>   {
>   	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
> +#if defined(CONFIG_BPF_SYSCALL)
> +	bpf_ksym_iter_register();

You can inline this function here and if bpf_iter_reg_target(...) 
failed, just return the error code.

> +#endif
>   	return 0;
>   }
>   device_initcall(kallsyms_init);
