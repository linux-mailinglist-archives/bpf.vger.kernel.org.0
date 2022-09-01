Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D185A92A5
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 11:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiIAJDV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 05:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbiIAJCi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 05:02:38 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80085.outbound.protection.outlook.com [40.107.8.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9613608D
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 02:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWP4LVnton4BdFC0G63QrKaxh4V702uA7G92Li69Cqr6MpiqBJgLW2sDP23h4v3P+3bpRXTvv+INxn1k9SMpiEydSHbYO8kxCxsai7nElC6wHJ7YRrjq4tP8+eb8YxDgI1dvhpSO7prp3+ASyxYYsEagRJUWo8+tNyzIM/RH2+deppv3f3ZbCYZ4IbRVyE9ZaOF8b1E4Djx66WwXJSBlCbrgsIo24F3Jq0UGcivyWDqxtwhHUS7akQof+izmivn6hcYIDJ2DdQVIYkeD2bQF2DfSMax8/X62LAjI5iNiUL80F6o0PI8M/TDmyOTfnI3qfN7wvV/YNBIF4sBBr/SctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEeUWCbY4Vcmt1RJa+a+AMAiSZC0gTU2/wbd063P4gE=;
 b=Rd3NlIiXVlMq8hm9edkAsDBtfYYm8jWFTKt1iVrnyFSW0RRPcNdT16ZeGryxEVTk1fuJtW0Y3T57NS82aFOMd5rulKA/KiDiAtbliLECunFY4bOnQ6/UNWm1tCnBXj9iW9VxTGfyuNg3nBKaohTYugZF3+T4VQpNkxAtha9DSNaTEYpYzl7k+GYI03wBgzJpPFP9Khz4feW3mLAykIETlRuG3EFxkxjIcdmEjpdg8IIX7VEJtDFipzwcvpeN3N4Xfw/7/dnNfyUPnOI7dz0GR/1qbnOKeMFKWI9JroGPbxaXqTVR5AISUSkpoVGy4UpHTSMrhamz72dhuyh6zjXz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEeUWCbY4Vcmt1RJa+a+AMAiSZC0gTU2/wbd063P4gE=;
 b=dZ67E1Pn/HKYAn4G9EmOWOxF7dZu4kif1nMJ979o/QZzYvaLZbVs1hb+eh8IspLOb3RQk804dpDTdoHvBNOhkk+kfgytbXZ+6wRUin1HnypB9ptQjJAFo50uak6kY3v3qMWcItrCar3TgEx49SuWJpXQpzUdhDIk4YQeZ8aTVQHHbubkJjNMMSKIu+PwvMJmfOwvJsCI1oi6qvorbWQAfEFYnju56c4UKNJfnkbwqZ7BkfvTC35SBolVIZHyKrxYWrBbwuuMRbj5KAVRTEbUcUT//K5WtjU/FA3MShJrAjb1IaH4kykRqmkUyGANrX634Xm5zn3c49wuGBBIpZrVvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AM6PR04MB6198.eurprd04.prod.outlook.com (2603:10a6:20b:b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 09:01:37 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b%9]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 09:01:37 +0000
Date:   Thu, 1 Sep 2022 17:01:24 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, kernel-team@fb.com, yhs@fb.com,
        john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next 1/2] bpf: propagate nullness information for reg
 to reg comparisons
Message-ID: <YxB05NCEbNWVYslz@syu-laptop>
References: <20220826172915.1536914-1-eddyz87@gmail.com>
 <20220826172915.1536914-2-eddyz87@gmail.com>
 <60a49435-85b8-f752-51d6-3946fa186b24@iogearbox.net>
 <83b97d563cd3f2041288fcffad1e830aac3bc2da.camel@gmail.com>
 <YxBpoj/MYrBlUJ8h@syu-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxBpoj/MYrBlUJ8h@syu-laptop>
X-ClientProxiedBy: FR3P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::14) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 625bdb64-c55e-443d-021d-08da8bf8939d
X-MS-TrafficTypeDiagnostic: AM6PR04MB6198:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3TNPonMU9DEbzpeamhVlfKJwFkXw/bgCxDiyt/kMTsoAUh0DrcXmLpdtYwtmN/mOmBI02pVESEEMvnV/vEUL2aYM7yeMaMKL2gPzNFThZgGFNN1PZ13/pmLAilBhpsLD2UiXW6L66JoN115KH7HQaakFvmuyxQQ1SWR4eSreGGIWurnEfQEVOExlYwckcoKP+AlKQ96G+4RTwH9HKvUCL6MFd6b4fRzNKsCg/tztUzjBgC8BGbvvzJ+lxbWEuNWvltT7zOjN3EB0Hi+cHf1cqjqLAU+yUR0G3V9PObjt0I8QnRnGPXPDxazRKcIqmmPvPb4Vr+kIHPlbJEraax8apIQ1HS4NXsoK3d37dsRCJVPa0lV8beeTROoeWrsLpI18IYkBZLh6sNMpwBHltn2O2fEqGbGFPXUbtJvFo9KLF+O9EeMIf5B0nczXvGW1UtRqErci3/Xy3/QMtNOG5CQn8uPvY3sfd6KSS78ChtL8f9iSg9a/CpZ19Cp+Et1AMD6Ob+m09fm/KqdIzLvAnnj/8ZMesMZiJrrVAdKZh7FA6BO8lrmireX7aZ7vGlA6eyxI2+d8L+ZYDsso7MnoGdpcyFSqaGzdWAGI6qQ4ieLUArJRwSqdItMtq8g96zfSmMg+DxTbtV0B9RU7K5TIMRhuwZzmjSPHkTIDcTgzhWuk6IytkyPjLz90RTHoMfI5O5GAcfS9HY8kaCWnfSnwlURuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(39860400002)(366004)(136003)(396003)(2906002)(478600001)(5660300002)(66946007)(66556008)(66476007)(41300700001)(4326008)(26005)(6506007)(6512007)(6486002)(86362001)(9686003)(6666004)(8676002)(186003)(8936002)(83380400001)(38100700002)(6916009)(316002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGlEVGJFbDFuTDd3WER2Ynlqd1Fld3IvNjZzSkNIZ2VIV2VuR0hhKzhLbWtL?=
 =?utf-8?B?ZkhBaXQzYTE2M3ZiK2hTb0N1UlJrODVSYzFENVNWelBtb1lyYmV2ZUt2YWUx?=
 =?utf-8?B?UmFBeXhiOWl4TUNJTER6WXRLMnRuY3JlUDBNRWQxWkRCb2tsYU0veGRrSGd6?=
 =?utf-8?B?NmxtUW9HTmhvbWZrYlJIc3V1cW0vR3crNUZhSC9SQjlQSC9FWnRtYmtqaVls?=
 =?utf-8?B?ZFQyS2VYYmNaUFMwSkV6TGp4Rlc3Q1BZWUFIQnk1TENQcGJZWmFlY05HT3h4?=
 =?utf-8?B?SENKeGwwYXdrQjFHcnlwNTFXYVdob3dQYTIzMmRFK1NEQXZCZUIvMTZldmhk?=
 =?utf-8?B?NE9kVU8zdjdYTzhxcGFmNVFsOWMrc1lMZ1NXNWpXeWFNeGUvQkhndWx6RUta?=
 =?utf-8?B?MlJSbVl6NHBCTUN5VGJjTzVIZG5CbG9kYmx3Ry9sSmdLZVc3NWdJeDdHd1JX?=
 =?utf-8?B?QUVweVR2dS9lbjgvN3BSaXJVbnpQS0Q2dVpFY2lpM0Q3bWxkdGpYL3RxaUdn?=
 =?utf-8?B?SFNoSE1razZmeVJ1MExQT2xYRGZCT09FaCtobDVDSU14RTc4cU10RUVMVEsz?=
 =?utf-8?B?OVl3ZEJxS3lhMnRkV1VhbDNWanc3MWJUNUt1c1UzVS9wdHB0VWdjeGU0a0gx?=
 =?utf-8?B?TktMc1pDVE82VE9ReVBCNHFuOERjZkkwaTJ3M1pkRWRhRnJId2w2R3NzczA3?=
 =?utf-8?B?dFVIeG52cXJIbUdYT3dDVEkvTnBIREROb0NZRGdoZWhlTHRuRGp6VUNiWSt3?=
 =?utf-8?B?bWh2QWxlUDBWK3lhRW41WFl3Q0V1UW5RZ2FvWlZQdEVDOTZwQXJXbDVKS3l1?=
 =?utf-8?B?QTdhNk1wcE10ZEViTHUyRnRXSW80UFEvQUJVMEljR0ZmRnJpZE1Pa1VablBj?=
 =?utf-8?B?RVNuK0paUXdGdEZHaG5obzY1Zm1aSEZJSms2WUtuQytQdGhZYkhlOUFnOStB?=
 =?utf-8?B?VUVNSEtSa2UvRUkrODBtdzlBb2x2MXVZRnhtVXcwWjhKOFVUVmx2cDAxYVha?=
 =?utf-8?B?WjBuUDN4d2xJTHNOZmpkbXZleTN4RkJlYmxPeFpqeXBiODVCR3VBTlE4eGlW?=
 =?utf-8?B?UDFaV1BvUU4vby80Q1pQdXpwZSsrNkRqS1d0VnRtN2EwbVFFdG9aVnd5cU16?=
 =?utf-8?B?bkwzZjJXR0JicFZIdzNzMDlZNUZyK1lZcGRTTW9YVW4vS3labXdMMWE2eGV4?=
 =?utf-8?B?YTNVYWhpREZWNGVmWHVxM1B4ZmFEOXNXVGpBcVp3alVFTnlvUmovdjZzaG9B?=
 =?utf-8?B?Q0o4M1ZKYUdQTlp0WEptSTI4QWZQdDEwbGd1bWtSUnEyd1dHbFVTT0w0Z1Nt?=
 =?utf-8?B?bXQ4cmpDazcrbDZNWC9JdWMvTElwaVhPbXJ3aFdvQXlMdzh1dWlKNHdLZnYw?=
 =?utf-8?B?aDN4Z0xra1BHbnBqUGhBSSs0OGJYN0RTZkU2Nm1uMzQvNVhJLzNKbEJQY0R3?=
 =?utf-8?B?ZUttelJsQnpuVUpMQW50cE5rUkdCSzNsV1o2N3JEaDMyYTJwMVpGdkRQVVF4?=
 =?utf-8?B?SjZUWkpJSVBXK1gxcjVXRGswSXVPZGxlbXFOeERWSXNDK1JhVWRIbnZBSmFm?=
 =?utf-8?B?QjhmWUpPbWtoaFAyV3N6bTRMaTc0TDVMMFJFNDkwVEltRjJ3MlI0dVQ1d0JH?=
 =?utf-8?B?NmlxSytMTGFaS05Gcy9mcFN1eWl1dUxsb2hFZUJuSlFtc2RUZG9jazFlUzJV?=
 =?utf-8?B?eFh2OXRaMkZsa3lyYWl2NHlpdDFPNzVDZDJwM2NuRkVZWDArRHVFZXl4ZGo4?=
 =?utf-8?B?dFJFV3YxY3pyUFdQeVJnZFRNekJHNU9xblB6SDh3RmxlSnZOOHA1Vjlrdys3?=
 =?utf-8?B?MFdYNUdsR0dwM3hJRGdGc0x5ZU5sejZOWXdlN0czNy82WkZBdEE3Sno1SEdQ?=
 =?utf-8?B?S2FmZUdxd2ZzdHNHamFWcmpUZCs2NWNRRTdoUDhyeDZseE9iYTNLWXVJeW5w?=
 =?utf-8?B?RHdlR0pJRmtZU3A0TUIvZUFPMGQzTDAvOTl6V1lPUnIyN1BNakpCZnJ5czVv?=
 =?utf-8?B?S2I3dEY4eWo3VlRVK25CYk5WSjFlZVR5MlV4eXFyRmNPRndBQW8xZzZFM2lO?=
 =?utf-8?B?a0JGeExGOGFoQVZ0cUQ1cGY0RTNTSHR5bGxFNlZ3OGpGd1lBR21OQ21pSDFS?=
 =?utf-8?Q?2WtN3zbZrbsPI5EeiBQu8LeM5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625bdb64-c55e-443d-021d-08da8bf8939d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 09:01:37.4630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7LhubSCndi/bcpDheqlOuyAMQdA0vw1FOgdonTj2nrhEd6xjq6rcPBDXjswToAuCBgh6UWAn1Q6vYnbJnePCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6198
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 01, 2022 at 04:13:22PM +0800, Shung-Hsi Yu wrote:
> On Tue, Aug 30, 2022 at 01:41:28PM +0300, Eduard Zingerman wrote:
> > Hi Daniel,
> > 
> > Thank you for commenting.
> > 
> > > On Mon, 2022-08-29 at 16:23 +0200, Daniel Borkmann wrote:
> > > [...]
> > > >   kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++--
> > > >   1 file changed, 39 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index 0194a36d0b36..7585288e035b 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
> > > >   	return type & PTR_MAYBE_NULL;
> > > >   }
> > > >   
> > > > +static bool type_is_pointer(enum bpf_reg_type type)
> > > > +{
> > > > +	return type != NOT_INIT && type != SCALAR_VALUE;
> > > > +}
> > > 
> > > We also have is_pointer_value(), semantics there are a bit different (and mainly to
> > > prevent leakage under unpriv), but I wonder if this can be refactored to accommodate
> > > both. My worry is that if in future we extend one but not the other bugs might slip
> > > in.
> > 
> > John was concerned about this as well, guess I won't not dodging it :)
> > Suppose I do the following modification:
> > 
> >     static bool type_is_pointer(enum bpf_reg_type type)
> >     {
> >     	return type != NOT_INIT && type != SCALAR_VALUE;
> >     }
> >     
> >     static bool __is_pointer_value(bool allow_ptr_leaks,
> >     			       const struct bpf_reg_state *reg)
> >     {
> >     	if (allow_ptr_leaks)
> >     		return false;
> > 
> > -    	return reg->type != SCALAR_VALUE;
> > +    	return type_is_pointer(reg->type);
> >     }
>      
> The verifier is using the wrapped is_pointer_value() to guard against
> pointer leak.
> 
>   static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regno,
>   			    int off, int bpf_size, enum bpf_access_type t,
>   			    int value_regno, bool strict_alignment_once)
>   {
>       ...
>   	if (reg->type == PTR_TO_MAP_KEY) {
>   		...
>   	} else if (reg->type == PTR_TO_MAP_VALUE) {
>   		struct bpf_map_value_off_desc *kptr_off_desc = NULL;
>   
>   		if (t == BPF_WRITE && value_regno >= 0 &&
>   		    is_pointer_value(env, value_regno)) {
>   			verbose(env, "R%d leaks addr into map\n", value_regno);
>   			return -EACCES;
>           ...
>   	}
>       ...
>   }
> 
> In the check_mem_access() case the semantic of is_pointer_value() is check
> whether or not the value *might* be a pointer, and since NON_INIT can be
> potentially anything, it should not be excluded.

I wasn't reading the threads carefully enough, apologies, just realized
Daniel had already mention the above point further up.

Also, after going back to the previous RFC thread I saw John mention that
after making the is_pointer_value() changes to exclude NOT_INIT, the tests
still passes.

I guess that comes down to how the verifier rigorously check that the
registers are not NOT_INIT using check_reg_arg(..., SRC_OP), before moving
on to more specific checks. So I'm a bit less sure about the split
{maybe,is}_pointer_value() approach proposed below now.

> Since the use case seems different, perhaps we could split them up, e.g. a
> maybe_pointer_value() and a is_pointer_value(), or something along that
> line.
> 
> The former is equivalent to type != SCALAR_VALUE, and the latter equivalent
> to type != NOT_INIT && type != SCALAR_VALUE. The latter can be used here for
> implementing nullness propogation.
> 
> > And check if there are test cases that have to be added because of the
> > change in the __is_pointer_value behavior (it does not check for
> > `NOT_INIT` right now). Does this sound like a plan?
> > 
> > [...]
> > > Could we consolidate the logic above with the one below which deals with R == 0 checks?
> > > There are some similarities, e.g. !is_jmp32, both test for jeq/jne and while one is based
> > > on K, the other one on X, though we could also add check X == 0 for below. Anyway, just
> > > a though that it may be nice to consolidate the handling.
> > 
> > Ok, I will try to consolidate those.
> > 
> > Thanks,
> > Eduard
