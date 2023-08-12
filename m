Return-Path: <bpf+bounces-7631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E22779CFD
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 05:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC4E1C20AAD
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 03:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9453115CD;
	Sat, 12 Aug 2023 03:29:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F515A0
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 03:29:56 +0000 (UTC)
Received: from out-121.mta0.migadu.com (out-121.mta0.migadu.com [IPv6:2001:41d0:1004:224b::79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFDFC5
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 20:29:54 -0700 (PDT)
Message-ID: <9c386f0f-ff12-2994-42ab-d3796d57a03a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691810992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s2zpVvC9UHKWOV44DjVAYXQtH+VCHbjYo2h9U4UAxc0=;
	b=tiisBPv0izePrkJo58Dkm/c6y/oCtVKD5uXejTxYR3W2TtXdAzL+OCWV4MJYgnSyCQh5Zw
	XITucpKQEEQrNwOhtvzhGk6FN3mKjk3rWwPi+p1EtImZaPFhItOM7UkQO42/gjHDhP2fjf
	3JZQJeWXhNDiSdFZk2z5TAHj7Nx4yFg=
Date: Fri, 11 Aug 2023 20:29:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add selftest for
 fill_link_info
Content-Language: en-US
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20230811023647.3711-1-laoar.shao@gmail.com>
 <20230811023647.3711-3-laoar.shao@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230811023647.3711-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/10/23 7:36 PM, Yafang Shao wrote:
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index 3b61e8b..b2f46b6 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -12,3 +12,6 @@ kprobe_multi_test/skel_api                       # libbpf: failed to load BPF sk
>   module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
>   fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
>   fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
> +fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> +fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
> +fill_link_info/kprobe_multi_ubuff                # bpf_program__attach_kprobe_multi_opts unexpected error: -95

The bpf CI is failing: 
https://patchwork.kernel.org/project/netdevbpf/patch/20230811023647.3711-3-laoar.shao@gmail.com/

The patch author is responsible to monitor the result from patchwork.



