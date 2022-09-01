Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418405A91E1
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234156AbiIAIOp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiIAIOH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 04:14:07 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1271012AE0F
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 01:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPtO3KDD48np0lYV9mNoAcFMeN6zcLuv0Hgxn1G8GW0M4SnhXrSPGd57Gxmw4pBIcsq+kXeEmQ1VgB5UWECzQ/nLXysDjEpfHyFuYyo/jnf9xhSm5w0Y5LDINqNkNGpusjgJJPqeg0sxHySoM0NYPEBYp+GPW6IQ4awZDe0MO8Rd5Z2f+0v1Au9HQnuWF1kGHu6eF1bnycMRpujBosYLePaTUCJXOVHYGlviUX/dM7mbfXWfwrpYyWMMDVOiLeFSOK4trpU9vl5j3HxKC7y+Vfm4HVcxNJmplOo5uYpqC2EYumYb+e5KeG/+gfg5qvgkhVmX2pEK0J7c8DeM5qmr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pfIQCR0tAZI/API2xF745rwfBeZP7P7tbt+5ti2WM7U=;
 b=TLb4qp9UqW1u8IU4jziV1dhWaVKuHDzxhc1iIHj/ooovQc7fjg+qPhRbHwJshwYb9lHUfXsISEY6FzNbsT8okOWktpLqEH9D9/9MNzHmi4wBfxvke7oAy3C81m/tctEL1TjGtd3oDjR5K8avBWUuiTLLa8iE+eb1GwfWYqlo13+sAxqtnkNdTpDVrbcsll3rvZc96ndHV0eNQrplXjJCLKh1w54gMSBEiL2ZISVcL1bKutP1RjgVJQQ6XQl0VsWJioTCGRk50LJMawvGK3Nv1rb81e/fOZXC9s2lZIPI+CjTgvjI/PhSMH0LoNbEgsOR6D1fxJcVwXHQMZkoXiVUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfIQCR0tAZI/API2xF745rwfBeZP7P7tbt+5ti2WM7U=;
 b=gNNPQUEbIO7e4rrsy+d0ju+YbWxzUjnuVDzBDbM9BBpFqivfIVcOU/7/Pp8A0xL+UcRE0INCnJFMkLJmya3czxir3DZIh6skXgwDh/GETf5bN/GMDPbnrUE2TkwHc23I/roMOp5T4+M1SX3ylX7MD3tRaQJufzi51vS7BZMlXUO+VYZfs5cSw0X1dWznpdvwEwWko5bHcGcYEN/q6QjfqKDBCo4+a1D8I84094lBOrTr/jQqlnIY6LLCy7MOkwbVfyd2Z930LJQTIz3DXTLmuEb5mQgp+EBv95+3gPlB+jJ75H4dJRw6+gMgFIAi7y+ZvxvIWCY0Uvx9toDedJe1/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AM6PR04MB4391.eurprd04.prod.outlook.com (2603:10a6:20b:20::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 08:13:28 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::f95c:9464:9bc0:f49b%9]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 08:13:28 +0000
Date:   Thu, 1 Sep 2022 16:13:22 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, kernel-team@fb.com, yhs@fb.com,
        john.fastabend@gmail.com
Subject: Re: [PATCH bpf-next 1/2] bpf: propagate nullness information for reg
 to reg comparisons
Message-ID: <YxBpoj/MYrBlUJ8h@syu-laptop>
References: <20220826172915.1536914-1-eddyz87@gmail.com>
 <20220826172915.1536914-2-eddyz87@gmail.com>
 <60a49435-85b8-f752-51d6-3946fa186b24@iogearbox.net>
 <83b97d563cd3f2041288fcffad1e830aac3bc2da.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83b97d563cd3f2041288fcffad1e830aac3bc2da.camel@gmail.com>
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 851194e1-a716-41a1-2896-08da8bf1d9b9
X-MS-TrafficTypeDiagnostic: AM6PR04MB4391:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FZibFwHecc7fq5fNBfOMUkQVwYaLSxFekZG2TsW+IUVQDrjjCfvOmswPRyErBvi3paZ3EKSCPUM8TzbwdOa3rlRUGO70AMCgoa4yx8Q96c6Fqf0/ConEqubk6s8kLstwXE3FzUzVtv0ZZTgUZ6Sq7xbvVxKxDNzxe6O00y7Iae8L0ovbZI2l4xVCRcvzmN9+LedCX+oR69rvGzb5bg/Qd6hZ8HPmkGGL2JhWV3807pFOxPT5uDq3Y4rp7499/JWlFLLtq4Znmg/1aLNWcTJmlbHXPyvFVvW0EQh4ANrNxZ33m2fJcR4tKAdCtvRIJaPahT1AIJUcUShXlBHNi3zk6p2IbK8NToYdih9vR+PyhYKUOOtHNe5u5h0xlS2KCsxB3VfSQ/4oirMKZoNy5yg69LbHLqfw31f8ohOuuaLPtLjWASKI/7Iq/DVMXmmE+QaQpewFlaV/FpJiMTVeh2kiah+ZznD+pVEAdt+5GMuxV4XPI751CmPxKdIJ5iBCHfNNlVywLmu8T6wVFRevc5ltbd4t2h8GOTVu4F4qJlcUlY058TIL6jM47M9sAd+gZcMXtPdwELO3t7TIl8sm34SCRmkjTea7/De6JEvHdyqe9nTi2wIrLb/NQSPJyhql3ATASsY+4rfqzHIMR4tubXl4hNx69L/6q25WBqMws4VyjM2aJrgkqJon3X0bHf1saXNGxr/nYAWwAUiBQ1E9fQFqeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(346002)(376002)(366004)(396003)(136003)(8936002)(6486002)(38100700002)(478600001)(6506007)(316002)(41300700001)(5660300002)(6916009)(6666004)(6512007)(9686003)(26005)(86362001)(83380400001)(33716001)(2906002)(66946007)(66476007)(8676002)(186003)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUgxQ2UzWklJQU56NFRvYjFDNTBVS1JWZWtHMTdDREdzcG9JY214U3ZKK2tv?=
 =?utf-8?B?U0tNZk5NdVArWjN4OVlwc3BCV1FIN0xlZUg4TWZsSjlPUTZGMjV1MERIS2R3?=
 =?utf-8?B?Ly9Ob0RDSm4zcDdBNmo1WDFUS05IMTU2TU8ydnJHVjdMWDVDV2RLTSt6TlVS?=
 =?utf-8?B?N3pvVXVVYTMxdTRFbUR3VmlpbmhTNVBpTUJ3aWFNV3cwU21wYmFlYmZPeXVE?=
 =?utf-8?B?SDJtSDJLOEkybXhBWXBLYTBic0lYTUJWL2x2T05aczBuOVdrbFdCdFV2NXc3?=
 =?utf-8?B?bk1kdnExMmZhWlExWks0M25JT0lxMVc3QUsrMkQwZ2t1cUxKamRlL1hINVc3?=
 =?utf-8?B?TFZpWlZrMUxuTTd6V3NnRXYwTmdsRzBzOFNUQ1dWQ2hNbE1tcjl6VmpFUVJ5?=
 =?utf-8?B?Tkpaem1oR2NyT2RYUkdNOGtxSXlSNzk4NjE5alhsS3JtMlRWVnRzeWhtbUt4?=
 =?utf-8?B?TC9NRjV4cHY4dFBsdHg4eUcwMmVSeWV4L0pNUXhUdW0vdUhOb1VXdkxMeGNE?=
 =?utf-8?B?R2V0OUVURjk5Z1N2Q3kyU3F2T1hXa2s0WGtlMUVmb1Z6T296SUlsTGNmMk1O?=
 =?utf-8?B?QkRseDRlUkhlTjE3M0xGWFBPanQ3YTEwU1ZmVXRJcTM4cGxTM1d6NUxQTkF0?=
 =?utf-8?B?c2VCa2pPblZqaWhBR3RxcDJjUysxRm1LZHR2K3VoTjdCdmlNZ3dlVzJ5Q0FO?=
 =?utf-8?B?aXM3N2ZhVkI3THlJSkIyKzkvN3I4a0hwcDRPMWoxMGpRbDdOczRkeUpxcmkr?=
 =?utf-8?B?SmE4NWdXeWxBRUF4WVZnK2l0ZUVNUVhtWkFCWktmbFlJK0RaMW5xTEdINllQ?=
 =?utf-8?B?Z1R3WE1YVXBGN2lkNHkxZVZNZk9sd211WUtCTFFjZ1hjeHdTeHdiYTVGcDdw?=
 =?utf-8?B?U2ErRFRYMWcwVEhNanc0djg3cHVXZ1FWVFpNVXQxckI2TjJRRWFvWXR6MDJp?=
 =?utf-8?B?QTRQUGIyOE1VNUViaUNyZkxQc3d2dlNwYUFoY1NXci9RUUR4NFhabUFVQitk?=
 =?utf-8?B?bnFFdWhSNGo5WUpTbnI0UWY4TFM5WnlnYXB0cktKS3ZjSHBhUVpONmtqemRJ?=
 =?utf-8?B?QU53R1d3K08vT3d3QldyR3crYjFOWXpadGV4YmFaQjhNNlYwa2N5T2JIMnlC?=
 =?utf-8?B?dzg4ZWxiRFdKWTY3MlV4NVhKNnJySk56dTVOMlFTSy9GUnFBMnBqakNYMUVY?=
 =?utf-8?B?VUtmWTRaZzRKY2xVQjNHRUxEMjVSYjFsVjQxUzNFM2R2NUFoc1NxeThPVG5B?=
 =?utf-8?B?UXpKbnZSUXVSaERLM0psSHY0clFKK3VxTTU3QmZ1azB6bCt5UVpBSUsxWENy?=
 =?utf-8?B?R2xWdkFmdVltYVB0SXZMWW9uVFlBRGhEN3R5NWg1NlVmYkRWQmFkT1AwYldY?=
 =?utf-8?B?OFZobllHWGVQZXhBdUZBTk5lc1lzN3o4eFVyODJlRkcxaXMvU1ZVSVRMTi9j?=
 =?utf-8?B?amdMZFpqZEJtMFlYU0c2Rzlzd2VIbkVYS0Q5TzlxNUkxUVhvQzFVNFJROS8w?=
 =?utf-8?B?Sk85TmxzTGlOOGxHelhzT3lLQXlIdjFta3Q1VUxpOUZQYzBybVowTUs0SUE4?=
 =?utf-8?B?MjF6dVQxSEYrQUg4d05XM3JSRUxxeElNSTdOcnJzNkYvaXdJVFlIR2MycmRB?=
 =?utf-8?B?SkZHdU9BcVE2L2o2QW1CdGVobkxjaVBJWU5rNFhmZHRRNHBpazFtdmZSUFFD?=
 =?utf-8?B?WnRrZFkzRmZrcU5OWjh6bTRWZnFvOHppMHFvOG80ZS9FemNOZTFMZ25sdTRS?=
 =?utf-8?B?OXVqVnZQZExsMkFrQTFWS2x2djVzQm9LYXJJZW5sTlpZUDNhdnZZWXVxc0wr?=
 =?utf-8?B?NGFyUEVXK05GbzNkUzhjYWZ5WndTVkYzTVBvZnNQSVEycHVSWHhSeWxCVkhj?=
 =?utf-8?B?U05JaTRkSTJMck5iSkF6c3ZNZU9rcFROckpTeDQ5b1hkeTNNcEcvby9Wb05E?=
 =?utf-8?B?Smh1dTR0ck4xSTUrK3g3eXl0UVVWOUkyQVVUbHRHVUpZU2llU1duVjMvK0FN?=
 =?utf-8?B?Z0RRc2NaVlg1R2JwVmRYR3BoQ1lyYnFvaUI5VXhGWDA5Y2toWWtSM0hRV1Ux?=
 =?utf-8?B?V0dsemdYSmpNRUZ6SHRlMjJZYWZOdHMrUkJ1MzVlNXVqQ3ZaYTNVYk9JL0V5?=
 =?utf-8?Q?y7fJUG6diPDp7OHJ2p/Lg6MbD?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851194e1-a716-41a1-2896-08da8bf1d9b9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 08:13:28.4247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uT46onQMWkZWe06gsAqbIjorzxdsGBQifquwR/93SBB+DleNK3mS6wZUMwyWgkMBVMvIwsYzN50BtMJ8C0cFWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4391
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 01:41:28PM +0300, Eduard Zingerman wrote:
> Hi Daniel,
> 
> Thank you for commenting.
> 
> > On Mon, 2022-08-29 at 16:23 +0200, Daniel Borkmann wrote:
> > [...]
> > >   kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 39 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 0194a36d0b36..7585288e035b 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -472,6 +472,11 @@ static bool type_may_be_null(u32 type)
> > >   	return type & PTR_MAYBE_NULL;
> > >   }
> > >   
> > > +static bool type_is_pointer(enum bpf_reg_type type)
> > > +{
> > > +	return type != NOT_INIT && type != SCALAR_VALUE;
> > > +}
> > 
> > We also have is_pointer_value(), semantics there are a bit different (and mainly to
> > prevent leakage under unpriv), but I wonder if this can be refactored to accommodate
> > both. My worry is that if in future we extend one but not the other bugs might slip
> > in.
> 
> John was concerned about this as well, guess I won't not dodging it :)
> Suppose I do the following modification:
> 
>     static bool type_is_pointer(enum bpf_reg_type type)
>     {
>     	return type != NOT_INIT && type != SCALAR_VALUE;
>     }
>     
>     static bool __is_pointer_value(bool allow_ptr_leaks,
>     			       const struct bpf_reg_state *reg)
>     {
>     	if (allow_ptr_leaks)
>     		return false;
> 
> -    	return reg->type != SCALAR_VALUE;
> +    	return type_is_pointer(reg->type);
>     }
     
The verifier is using the wrapped is_pointer_value() to guard against
pointer leak.

  static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regno,
  			    int off, int bpf_size, enum bpf_access_type t,
  			    int value_regno, bool strict_alignment_once)
  {
      ...
  	if (reg->type == PTR_TO_MAP_KEY) {
  		...
  	} else if (reg->type == PTR_TO_MAP_VALUE) {
  		struct bpf_map_value_off_desc *kptr_off_desc = NULL;
  
  		if (t == BPF_WRITE && value_regno >= 0 &&
  		    is_pointer_value(env, value_regno)) {
  			verbose(env, "R%d leaks addr into map\n", value_regno);
  			return -EACCES;
          ...
  	}
      ...
  }

In the check_mem_access() case the semantic of is_pointer_value() is check
whether or not the value *might* be a pointer, and since NON_INIT can be
potentially anything, it should not be excluded.

Since the use case seems different, perhaps we could split them up, e.g. a
maybe_pointer_value() and a is_pointer_value(), or something along that
line.

The former is equivalent to type != SCALAR_VALUE, and the latter equivalent
to type != NOT_INIT && type != SCALAR_VALUE. The latter can be used here for
implementing nullness propogation.

> And check if there are test cases that have to be added because of the
> change in the __is_pointer_value behavior (it does not check for
> `NOT_INIT` right now). Does this sound like a plan?
> 
> [...]
> > Could we consolidate the logic above with the one below which deals with R == 0 checks?
> > There are some similarities, e.g. !is_jmp32, both test for jeq/jne and while one is based
> > on K, the other one on X, though we could also add check X == 0 for below. Anyway, just
> > a though that it may be nice to consolidate the handling.
> 
> Ok, I will try to consolidate those.
> 
> Thanks,
> Eduard
